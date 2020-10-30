- [Supported Tags](#org94ff483)
  - [Simple Tags](#org06e0e6c)
  - [Shared Tags](#orga931b0d)
- [Quick Reference](#orgda4e6aa)
- [What is CCL?](#org02e7535)
- [What's in the image?](#orgc41932e)
- [License](#org5cd0b88)



<a id="org94ff483"></a>

# Supported Tags


<a id="org06e0e6c"></a>

## Simple Tags

-   `1.12-debian-buster`, `1.12-debian`, `debian-buster`, `debian`
-   `1.12-debian-stretch`, `debian-stretch`
-   `1.12-ubuntu-focal`, `1.12-ubuntu`, `ubuntu-focal`, `ubuntu`
-   `1.12-ubuntu-bionic`, `ubuntu-bionic`
-   `1.12-windowsservercore-ltsc2019`, `1.12-windowsservercore`, `windowsservercore-ltsc2019`, `windowsservercore`


<a id="orga931b0d"></a>

## Shared Tags

-   **`1.12`:** -   `1.12-debian-buster`
    -   `1.12-windowsservercore-ltsc2019`
-   **`latest`:** -   `1.12-debian-buster`
    -   `1.12-windowsservercore-ltsc2019`


<a id="orgda4e6aa"></a>

# Quick Reference

-   **CCL Home Page:** [https://ccl.clozure.com/](https://ccl.clozure.com/)
-   **Where to file Docker image related issues:** <https://github.com/cl-docker-images/ccl>
-   **Where to file issues for CCL itself:** [https://github.com/Clozure/ccl/issues](https://github.com/Clozure/ccl/issues)
-   **Maintained by:** [Eric Timmons](https://github.com/daewok/docker-ccl/) (i.e., this is not an official CCL image)
-   **Maintained by:** [Eric Timmons](https://github.com/daewok) and the [MIT MERS Group](https://mers.csail.mit.edu/) (i.e., this is not an official CCL image)
-   **Supported architectures:** `linux/amd64`, `linux/arm/v7`, `windows/amd64`
-   **Previously known as:** `daewok/ccl`


<a id="org02e7535"></a>

# What is CCL?

From [CCL's Home Page](https://ccl.clozure.com):

> Clozure CL (often called CCL for short) is a free Common Lisp implementation with a long history. Some distinguishing features of the implementation include fast compilation speed, native threads, a precise, generational, compacting garbage collector, and a convenient foreign-function interface.


<a id="orgc41932e"></a>

# What's in the image?

This image contains CCL binaries built from the latest binary releases from the CCL devs for a variety of OSes and architectures.

The general policy for OS support is that images will be built for two versions of supported OSes: either the two most recent versions or the latest LTS and most recent version, as applicable.


<a id="org5cd0b88"></a>

# License

CCL is licensed under the [Apache v2.0](https://www.apache.org/licenses/LICENSE-2.0).

The Dockerfiles used to build the images are licensed under BSD-2-Clause.

As with all Docker images, these likely also contain other software which may be under other licenses (such as Bash, etc from the base distribution, along with any direct or indirect dependencies of the primary software being contained).

As for any pre-built image usage, it is the image user's responsibility to ensure that any use of this image complies with any relevant licenses for all software contained within.
