caching
continueBuildingCommitList: anOrderedCollection asyncWith: aHistoryWalker
	commitListBuildProcess := 
	[aHistoryWalker continueDo: [:each | anOrderedCollection add: each].
	cachedCommitList := anOrderedCollection.
	Project current addDeferredUIMessage: [self changed: #commitList]]
		forkAt: Processor userBackgroundPriority
		named: self class name, ' commit list builder'.