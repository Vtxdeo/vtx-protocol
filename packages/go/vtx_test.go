package vtxprotocol

import (
	"os"
	"strings"
	"testing"
)

func TestIntegrity(t *testing.T) {

	path := GetWitPath()

	if path == "" {
		t.Fatal("GetWitPath returned empty string, runtime caller resolution failed")
	}
	t.Logf("Resolved WIT Path: %s", path)

	info, err := os.Stat(path)
	if os.IsNotExist(err) {
		t.Fatalf("Critical: WIT file not found at resolved path: %s", path)
	}
	if info.IsDir() {
		t.Fatalf("Resolved path is a directory, expected file: %s", path)
	}

	content, err := os.ReadFile(path)
	if err != nil {
		t.Fatalf("Failed to read WIT file: %v", err)
	}

	if !strings.Contains(string(content), "package vtx:api") {
		t.Error("Validation failed: File content does not contain 'package vtx:api' signature")
	}
}