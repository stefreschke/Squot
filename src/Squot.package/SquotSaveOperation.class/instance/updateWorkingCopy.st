applying
updateWorkingCopy
	self workingCopy
		loadedVersion: newVersion;
		cacheSavedArtifacts: (self capturedArtifacts ifNil: [Dictionary new]);
		resetAdditionalParents;
		cacheNewMonticelloVersions: patch message: message;
		resetNewVersionMessage.