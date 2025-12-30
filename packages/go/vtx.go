package vtxprotocol

import (
	_ "embed"
	"path/filepath"
	"runtime"
)

var WitContent string

func GetWitPath() string {
	_, filename, _, ok := runtime.Caller(0)
	if !ok {
		return ""
	}
	return filepath.Join(filepath.Dir(filename), "wit", "vtx.wit")
}