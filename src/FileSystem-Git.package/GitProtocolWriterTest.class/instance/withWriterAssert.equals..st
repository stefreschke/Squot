helpers
withWriterAssert: aBlock equals: aString
	| result |
	result := ByteArray streamContents: [ :stream |
		| writer |
		writer := self targetClass on: stream.
		aBlock value: writer].
	self assert: aString equals: result asString