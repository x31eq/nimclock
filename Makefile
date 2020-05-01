all: fedate feedate festamp feestamp

feedate: feedate.nim feetime.nim
	nim c -d:release feedate.nim

fedate: fedate.nim feetime.nim
	nim c -d:release fedate.nim

festamp: festamp.nim feetime.nim
	nim c -d:release festamp.nim

feestamp: feestamp.nim feetime.nim
	nim c -d:release feestamp.nim
