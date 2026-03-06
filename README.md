# Compare osbuild depsolving between dnf4 and dnf5

Build container:
```console
podman build . -t depsolve-compare
```

Create output directory and run test script:
```console
mkdir -p ./manifests
podman run -it --rm -v./manifests:/manifests depsolve-compare:latest
```

Check for differences:
```console
diff -r manifests/dnf4/manifests manifests/dnf5/manifests
```

WARNING: The output directories (`manifests/dnf4/` and `manifests/dnf5/`) are cleared at the start of each run.
