- [Supported Tags](#org6664acc)
  - [Simple Tags](#org11b541d)
  - [Shared Tags](#orgb0acb9d)
- [Quick Reference](#orgac66b5e)
- [What is CCL?](#org7e91dd4)
- [What's in the image?](#org0a8eaf9)
- [License](#org7bfb70d)



<a id="org6664acc"></a>

# Supported Tags


<a id="org11b541d"></a>

## Simple Tags

-   `1.12-buster`, `buster`
-   `1.12-stretch`, `stretch`
-   `1.12-windowsservercore-1809`, `windowsservercore-1809`
-   `1.12-windowsservercore-ltsc2016`, `windowsservercore-ltsc2016`


<a id="orgb0acb9d"></a>

## Shared Tags

-   **`1.12`, `latest`:** -   `1.12-buster`
    -   `1.12-windowsservercore-1809`
    -   `1.12-windowsservercore-ltsc2016`
-   **`1.12-windowsservercore`, `windowsservercore`:** -   `1.12-windowsservercore-1809`
    -   `1.12-windowsservercore-ltsc2016`


<a id="orgac66b5e"></a>

# Quick Reference

-   **CCL Home Page:** [https://ccl.clozure.com/](https://ccl.clozure.com/)
-   **Where to file Docker image related issues:** <https://gitlab.common-lisp.net/cl-docker-images/ccl>
-   **Where to file issues for CCL itself:** [https://github.com/Clozure/ccl/issues](https://github.com/Clozure/ccl/issues)
-   **Maintained by:** [Eric Timmons](https://github.com/daewok/docker-ccl/) (i.e., this is not an official CCL image)
-   **Maintained by:** [Eric Timmons](https://github.com/daewok) and the [MIT MERS Group](https://mers.csail.mit.edu/) (i.e., this is not an official CCL image)
-   **Supported architectures:** `linux/amd64`, `linux/arm/v7`, `windows/amd64`


<a id="org7e91dd4"></a>

# What is CCL?

From [CCL's Home Page](https://ccl.clozure.com):

> Clozure CL (often called CCL for short) is a free Common Lisp implementation with a long history. Some distinguishing features of the implementation include fast compilation speed, native threads, a precise, generational, compacting garbage collector, and a convenient foreign-function interface.


<a id="org0a8eaf9"></a>

# What's in the image?

This image contains CCL binaries built from the latest binary releases from the CCL devs for a variety of OSes and architectures.


<a id="org7bfb70d"></a>

# License

CCL is licensed under the [Apache v2.0](https://www.apache.org/licenses/LICENSE-2.0).

The Dockerfiles used to build the images are licensed under BSD-2-Clause.

As with all Docker images, these likely also contain other software which may be under other licenses (such as Bash, etc from the base distribution, along with any direct or indirect dependencies of the primary software being contained).

As for any pre-built image usage, it is the image user's responsibility to ensure that any use of this image complies with any relevant licenses for all software contained within.
