tests
testSwitchToRestoresUnsavedChanges
	| trackedObject addedObject defaultHistorian otherHistorian |
	"given"
	trackedObject := StringHolder new contents: 'Tracked'; yourself.
	workingCopy add: trackedObject at: 'tracked.txt'.
	workingCopy saveVersionWithMessage: 'add something'.
	"remember this version on another branch"
	(otherHistorian := repository historianNamed: 'other') version: workingCopy baseVersion.
	"add another version"
	addedObject := StringHolder new contents: 'Added'; yourself.
	workingCopy add: addedObject at: 'added.txt'.
	workingCopy saveVersionWithMessage: 'add something else'.
	trackedObject contents: 'Unsaved'.
	defaultHistorian := workingCopy loadedHistorian.
	workingCopy switchTo: otherHistorian.
	self assert: trackedObject contents = 'Tracked'.
	"when"
	workingCopy switchTo: defaultHistorian.
	"then"
	self assert: trackedObject contents = 'Unsaved'.