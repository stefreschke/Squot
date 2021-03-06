tests
testOldCherryPickWithConflicts
	self suppressChangeNotificationsDuring:
	[scenario := SquotWorkingCopyTestMergeConflictScenario forTestCase: self.
	[[[workingCopy
		cherryPickInteractivelyFromVersion: scenario thirdVersion
		withParent: scenario firstVersion
		ifLoadCanceled: [self fail: 'this code should not be reached']
		ifSaveCanceled: [self fail: 'this code should not be reached']]
		on: Deprecation do: [:e | e resume]]
	
	on: SquotMergeRequested do: [:request | 
		scenario
			assertConflictedMethodWorkingEditionPresentIn: request merge;
			assertConflictedMethodIncomingEditionPresentIn: request merge;
			assertThirdMethodWillBeAdded: request merge;
			chooseWorkingEditionOfConflictedMethodIn: request merge.
		request resume]

	on: SquotSelectionOfChangesRequested do:
		[:request | request message: 'new version'; resume]
	
	] valueSupplyingAnswers: {{'*'. #default}}].
	scenario assertConflictMethodHasNotChanged;
		assertThirdMethodLoaded.
	self assert: scenario secondVersion equals: workingCopy loadedVersion parents first;
		deny: scenario thirdVersion = workingCopy loadedVersion;
		assert: 'new version' equals: workingCopy loadedVersion message.