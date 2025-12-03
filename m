Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DE48D116F3
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 08:02:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQhnE-0000Rv-AI; Wed, 03 Dec 2025 03:00:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vQhn6-0000Il-F7; Wed, 03 Dec 2025 03:00:50 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vQhn0-0006zo-Mu; Wed, 03 Dec 2025 03:00:48 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 1DB6F17076F;
 Wed, 03 Dec 2025 10:59:23 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id DA77132B496;
 Wed, 03 Dec 2025 10:59:40 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.7 098/116] Remove the remainders of the Avocado tests
Date: Wed,  3 Dec 2025 10:59:18 +0300
Message-ID: <20251203075939.2366131-17-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.7-20251203105830@cover.tls.msk.ru>
References: <qemu-stable-10.0.7-20251203105830@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 WEIRD_QUOTING=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Thomas Huth <thuth@redhat.com>

Now that all Avocado tests have been converted to or been replaced by
other functional tests, we can delete the remainders of the Avocado
tests from the QEMU source tree.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20250414113031.151105-16-thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
(cherry picked from commit 52e9ed6d3ac44424e098333772077a41bb88c4db)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/MAINTAINERS b/MAINTAINERS
index 07f77c048e..5fd757c5dd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2073,7 +2073,7 @@ S: Supported
 F: hw/acpi/viot.c
 F: hw/acpi/viot.h
 
-ACPI/AVOCADO/BIOSBITS
+ACPI/FUNCTIONAL/BIOSBITS
 M: Ani Sinha <anisinha@redhat.com>
 M: Michael S. Tsirkin <mst@redhat.com>
 S: Supported
@@ -4246,12 +4246,6 @@ R: Philippe Mathieu-Daudé <philmd@linaro.org>
 S: Maintained
 F: tests/tcg/Makefile.target
 
-Integration Testing with the Avocado framework
-W: https://trello.com/b/6Qi1pxVn/avocado-qemu
-R: Cleber Rosa <crosa@redhat.com>
-S: Odd Fixes
-F: tests/avocado/
-
 GitLab custom runner (Works On Arm Sponsored)
 M: Alex Bennée <alex.bennee@linaro.org>
 M: Philippe Mathieu-Daudé <philmd@linaro.org>
diff --git a/configure b/configure
index 02f1dd2311..000309cf61 100755
--- a/configure
+++ b/configure
@@ -1685,7 +1685,7 @@ LINKS="$LINKS pc-bios/optionrom/Makefile"
 LINKS="$LINKS pc-bios/s390-ccw/Makefile"
 LINKS="$LINKS pc-bios/vof/Makefile"
 LINKS="$LINKS .gdbinit scripts" # scripts needed by relative path in .gdbinit
-LINKS="$LINKS tests/avocado tests/data"
+LINKS="$LINKS tests/data"
 LINKS="$LINKS tests/qemu-iotests/check tests/qemu-iotests/Makefile"
 LINKS="$LINKS python"
 for f in $LINKS ; do
diff --git a/docs/about/build-platforms.rst b/docs/about/build-platforms.rst
index 1552b1a704..52521552c8 100644
--- a/docs/about/build-platforms.rst
+++ b/docs/about/build-platforms.rst
@@ -123,11 +123,11 @@ Rust build dependencies
   to build QEMU.
 
 Optional build dependencies
-  Build components whose absence does not affect the ability to build
-  QEMU may not be available in distros, or may be too old for QEMU's
-  requirements.  Many of these, such as the Avocado testing framework
-  or various linters, are written in Python and therefore can also
-  be installed using ``pip``.  Cross compilers are another example
+  Build components whose absence does not affect the ability to build QEMU
+  may not be available in distros, or may be too old for our requirements.
+  Many of these, such as additional modules for the functional testing
+  framework or various linters, are written in Python and therefore can
+  also be installed using ``pip``.  Cross compilers are another example
   of optional build-time dependency; in this case it is possible to
   download them from repositories such as EPEL, to use container-based
   cross compilation using ``docker`` or ``podman``, or to use pre-built
diff --git a/docs/devel/build-system.rst b/docs/devel/build-system.rst
index a759982f45..258cfad3fe 100644
--- a/docs/devel/build-system.rst
+++ b/docs/devel/build-system.rst
@@ -134,7 +134,7 @@ in how the build process runs Python code.
 
 At this stage, ``configure`` also queries the chosen Python interpreter
 about QEMU's build dependencies.  Note that the build process does  *not*
-look for ``meson``, ``sphinx-build`` or ``avocado`` binaries in the PATH;
+look for ``meson`` or ``sphinx-build`` binaries in the PATH;
 likewise, there are no options such as ``--meson`` or ``--sphinx-build``.
 This avoids a potential mismatch, where Meson and Sphinx binaries on the
 PATH might operate in a different Python environment than the one chosen
@@ -151,7 +151,7 @@ virtual environment with ``pip``, either from wheels in ``python/wheels``
 or by downloading the package with PyPI.  Downloading can be disabled with
 ``--disable-download``; and anyway, it only happens when a ``configure``
 option (currently, only ``--enable-docs``) is explicitly enabled but
-the dependencies are not present\ [#pip]_.
+the dependencies are not present.
 
 .. [#distlib] The scripts are created based on the package's metadata,
               specifically the ``console_script`` entry points.  This is the
@@ -164,10 +164,6 @@ the dependencies are not present\ [#pip]_.
               because the Python Packaging Authority provides a package
               ``distlib.scripts`` to perform this task.
 
-.. [#pip] ``pip`` might also be used when running ``make check-avocado``
-           if downloading is enabled, to ensure that Avocado is
-           available.
-
 The required versions of the packages are stored in a configuration file
 ``pythondeps.toml``.  The format is custom to QEMU, but it is documented
 at the top of the file itself and it should be easy to understand.  The
@@ -497,8 +493,7 @@ number of dynamically created files listed later.
   ``pyvenv/bin``, and calling ``pip`` to install dependencies.
 
 ``tests/Makefile.include``
-  Rules for external test harnesses. These include the TCG tests
-  and the Avocado-based integration tests.
+  Rules for external test harnesses like the TCG tests.
 
 ``tests/docker/Makefile.include``
   Rules for Docker tests. Like ``tests/Makefile.include``, this file is
diff --git a/docs/devel/codebase.rst b/docs/devel/codebase.rst
index 085da10a22..2a3143787a 100644
--- a/docs/devel/codebase.rst
+++ b/docs/devel/codebase.rst
@@ -175,11 +175,6 @@ yet, so sometimes the source code is all you have.
 * `tests <https://gitlab.com/qemu-project/qemu/-/tree/master/tests>`_:
   QEMU `test <testing>` suite
 
-  - `avocado <https://gitlab.com/qemu-project/qemu/-/tree/master/tests/avocado>`_:
-    Functional tests booting full VM using `Avocado framework <checkavocado-ref>`.
-    Those tests will be transformed and moved into
-    `tests/functional <https://gitlab.com/qemu-project/qemu/-/tree/master/tests/functional>`_
-    in the future.
   - `data <https://gitlab.com/qemu-project/qemu/-/tree/master/tests/data>`_:
     Data for various tests.
   - `decode <https://gitlab.com/qemu-project/qemu/-/tree/master/tests/decode>`_:
diff --git a/docs/devel/testing/avocado.rst b/docs/devel/testing/avocado.rst
deleted file mode 100644
index eda76fe2db..0000000000
--- a/docs/devel/testing/avocado.rst
+++ /dev/null
@@ -1,581 +0,0 @@
-.. _checkavocado-ref:
-
-
-Integration testing with Avocado
-================================
-
-The ``tests/avocado`` directory hosts integration tests. They're usually
-higher level tests, and may interact with external resources and with
-various guest operating systems.
-
-These tests are written using the Avocado Testing Framework (which must be
-installed separately) in conjunction with a the ``avocado_qemu.QemuSystemTest``
-class, implemented at ``tests/avocado/avocado_qemu``.
-
-Tests based on ``avocado_qemu.QemuSystemTest`` can easily:
-
- * Customize the command line arguments given to the convenience
-   ``self.vm`` attribute (a QEMUMachine instance)
-
- * Interact with the QEMU monitor, send QMP commands and check
-   their results
-
- * Interact with the guest OS, using the convenience console device
-   (which may be useful to assert the effectiveness and correctness of
-   command line arguments or QMP commands)
-
- * Interact with external data files that accompany the test itself
-   (see ``self.get_data()``)
-
- * Download (and cache) remote data files, such as firmware and kernel
-   images
-
- * Have access to a library of guest OS images (by means of the
-   ``avocado.utils.vmimage`` library)
-
- * Make use of various other test related utilities available at the
-   test class itself and at the utility library:
-
-   - http://avocado-framework.readthedocs.io/en/latest/api/test/avocado.html#avocado.Test
-   - http://avocado-framework.readthedocs.io/en/latest/api/utils/avocado.utils.html
-
-Running tests
--------------
-
-You can run the avocado tests simply by executing:
-
-.. code::
-
-  make check-avocado
-
-This involves the automatic installation, from PyPI, of all the
-necessary avocado-framework dependencies into the QEMU venv within the
-build tree (at ``./pyvenv``). Test results are also saved within the
-build tree (at ``tests/results``).
-
-Note: the build environment must be using a Python 3 stack, and have
-the ``venv`` and ``pip`` packages installed.  If necessary, make sure
-``configure`` is called with ``--python=`` and that those modules are
-available.  On Debian and Ubuntu based systems, depending on the
-specific version, they may be on packages named ``python3-venv`` and
-``python3-pip``.
-
-It is also possible to run tests based on tags using the
-``make check-avocado`` command and the ``AVOCADO_TAGS`` environment
-variable:
-
-.. code::
-
-   make check-avocado AVOCADO_TAGS=quick
-
-Note that tags separated with commas have an AND behavior, while tags
-separated by spaces have an OR behavior. For more information on Avocado
-tags, see:
-
- https://avocado-framework.readthedocs.io/en/latest/guides/user/chapters/tags.html
-
-To run a single test file, a couple of them, or a test within a file
-using the ``make check-avocado`` command, set the ``AVOCADO_TESTS``
-environment variable with the test files or test names. To run all
-tests from a single file, use:
-
- .. code::
-
-  make check-avocado AVOCADO_TESTS=$FILEPATH
-
-The same is valid to run tests from multiple test files:
-
- .. code::
-
-  make check-avocado AVOCADO_TESTS='$FILEPATH1 $FILEPATH2'
-
-To run a single test within a file, use:
-
- .. code::
-
-  make check-avocado AVOCADO_TESTS=$FILEPATH:$TESTCLASS.$TESTNAME
-
-The same is valid to run single tests from multiple test files:
-
- .. code::
-
-  make check-avocado AVOCADO_TESTS='$FILEPATH1:$TESTCLASS1.$TESTNAME1 $FILEPATH2:$TESTCLASS2.$TESTNAME2'
-
-The scripts installed inside the virtual environment may be used
-without an "activation".  For instance, the Avocado test runner
-may be invoked by running:
-
- .. code::
-
-  pyvenv/bin/avocado run $OPTION1 $OPTION2 tests/avocado/
-
-Note that if ``make check-avocado`` was not executed before, it is
-possible to create the Python virtual environment with the dependencies
-needed running:
-
- .. code::
-
-  make check-venv
-
-It is also possible to run tests from a single file or a single test within
-a test file. To run tests from a single file within the build tree, use:
-
- .. code::
-
-  pyvenv/bin/avocado run tests/avocado/$TESTFILE
-
-To run a single test within a test file, use:
-
- .. code::
-
-  pyvenv/bin/avocado run tests/avocado/$TESTFILE:$TESTCLASS.$TESTNAME
-
-Valid test names are visible in the output from any previous execution
-of Avocado or ``make check-avocado``, and can also be queried using:
-
- .. code::
-
-  pyvenv/bin/avocado list tests/avocado
-
-Manual Installation
--------------------
-
-To manually install Avocado and its dependencies, run:
-
-.. code::
-
-  pip install --user avocado-framework
-
-Alternatively, follow the instructions on this link:
-
-  https://avocado-framework.readthedocs.io/en/latest/guides/user/chapters/installing.html
-
-Overview
---------
-
-The ``tests/avocado/avocado_qemu`` directory provides the
-``avocado_qemu`` Python module, containing the ``avocado_qemu.QemuSystemTest``
-class.  Here's a simple usage example:
-
-.. code::
-
-  from avocado_qemu import QemuSystemTest
-
-
-  class Version(QemuSystemTest):
-      """
-      :avocado: tags=quick
-      """
-      def test_qmp_human_info_version(self):
-          self.vm.launch()
-          res = self.vm.cmd('human-monitor-command',
-                            command_line='info version')
-          self.assertRegex(res, r'^(\d+\.\d+\.\d)')
-
-To execute your test, run:
-
-.. code::
-
-  avocado run version.py
-
-Tests may be classified according to a convention by using docstring
-directives such as ``:avocado: tags=TAG1,TAG2``.  To run all tests
-in the current directory, tagged as "quick", run:
-
-.. code::
-
-  avocado run -t quick .
-
-The ``avocado_qemu.QemuSystemTest`` base test class
-^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
-
-The ``avocado_qemu.QemuSystemTest`` class has a number of characteristics
-that are worth being mentioned right away.
-
-First of all, it attempts to give each test a ready to use QEMUMachine
-instance, available at ``self.vm``.  Because many tests will tweak the
-QEMU command line, launching the QEMUMachine (by using ``self.vm.launch()``)
-is left to the test writer.
-
-The base test class has also support for tests with more than one
-QEMUMachine. The way to get machines is through the ``self.get_vm()``
-method which will return a QEMUMachine instance. The ``self.get_vm()``
-method accepts arguments that will be passed to the QEMUMachine creation
-and also an optional ``name`` attribute so you can identify a specific
-machine and get it more than once through the tests methods. A simple
-and hypothetical example follows:
-
-.. code::
-
-  from avocado_qemu import QemuSystemTest
-
-
-  class MultipleMachines(QemuSystemTest):
-      def test_multiple_machines(self):
-          first_machine = self.get_vm()
-          second_machine = self.get_vm()
-          self.get_vm(name='third_machine').launch()
-
-          first_machine.launch()
-          second_machine.launch()
-
-          first_res = first_machine.cmd(
-              'human-monitor-command',
-              command_line='info version')
-
-          second_res = second_machine.cmd(
-              'human-monitor-command',
-              command_line='info version')
-
-          third_res = self.get_vm(name='third_machine').cmd(
-              'human-monitor-command',
-              command_line='info version')
-
-          self.assertEqual(first_res, second_res, third_res)
-
-At test "tear down", ``avocado_qemu.QemuSystemTest`` handles all the
-QEMUMachines shutdown.
-
-The ``avocado_qemu.LinuxTest`` base test class
-^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
-
-The ``avocado_qemu.LinuxTest`` is further specialization of the
-``avocado_qemu.QemuSystemTest`` class, so it contains all the characteristics
-of the later plus some extra features.
-
-First of all, this base class is intended for tests that need to
-interact with a fully booted and operational Linux guest.  At this
-time, it uses a Fedora 31 guest image.  The most basic example looks
-like this:
-
-.. code::
-
-  from avocado_qemu import LinuxTest
-
-
-  class SomeTest(LinuxTest):
-
-      def test(self):
-          self.launch_and_wait()
-          self.ssh_command('some_command_to_be_run_in_the_guest')
-
-Please refer to tests that use ``avocado_qemu.LinuxTest`` under
-``tests/avocado`` for more examples.
-
-QEMUMachine
------------
-
-The QEMUMachine API is already widely used in the Python iotests,
-device-crash-test and other Python scripts.  It's a wrapper around the
-execution of a QEMU binary, giving its users:
-
- * the ability to set command line arguments to be given to the QEMU
-   binary
-
- * a ready to use QMP connection and interface, which can be used to
-   send commands and inspect its results, as well as asynchronous
-   events
-
- * convenience methods to set commonly used command line arguments in
-   a more succinct and intuitive way
-
-QEMU binary selection
-^^^^^^^^^^^^^^^^^^^^^
-
-The QEMU binary used for the ``self.vm`` QEMUMachine instance will
-primarily depend on the value of the ``qemu_bin`` parameter.  If it's
-not explicitly set, its default value will be the result of a dynamic
-probe in the same source tree.  A suitable binary will be one that
-targets the architecture matching host machine.
-
-Based on this description, test writers will usually rely on one of
-the following approaches:
-
-1) Set ``qemu_bin``, and use the given binary
-
-2) Do not set ``qemu_bin``, and use a QEMU binary named like
-   "qemu-system-${arch}", either in the current
-   working directory, or in the current source tree.
-
-The resulting ``qemu_bin`` value will be preserved in the
-``avocado_qemu.QemuSystemTest`` as an attribute with the same name.
-
-Attribute reference
--------------------
-
-Test
-^^^^
-
-Besides the attributes and methods that are part of the base
-``avocado.Test`` class, the following attributes are available on any
-``avocado_qemu.QemuSystemTest`` instance.
-
-vm
-""
-
-A QEMUMachine instance, initially configured according to the given
-``qemu_bin`` parameter.
-
-arch
-""""
-
-The architecture can be used on different levels of the stack, e.g. by
-the framework or by the test itself.  At the framework level, it will
-currently influence the selection of a QEMU binary (when one is not
-explicitly given).
-
-Tests are also free to use this attribute value, for their own needs.
-A test may, for instance, use the same value when selecting the
-architecture of a kernel or disk image to boot a VM with.
-
-The ``arch`` attribute will be set to the test parameter of the same
-name.  If one is not given explicitly, it will either be set to
-``None``, or, if the test is tagged with one (and only one)
-``:avocado: tags=arch:VALUE`` tag, it will be set to ``VALUE``.
-
-cpu
-"""
-
-The cpu model that will be set to all QEMUMachine instances created
-by the test.
-
-The ``cpu`` attribute will be set to the test parameter of the same
-name. If one is not given explicitly, it will either be set to
-``None ``, or, if the test is tagged with one (and only one)
-``:avocado: tags=cpu:VALUE`` tag, it will be set to ``VALUE``.
-
-machine
-"""""""
-
-The machine type that will be set to all QEMUMachine instances created
-by the test.
-
-The ``machine`` attribute will be set to the test parameter of the same
-name.  If one is not given explicitly, it will either be set to
-``None``, or, if the test is tagged with one (and only one)
-``:avocado: tags=machine:VALUE`` tag, it will be set to ``VALUE``.
-
-qemu_bin
-""""""""
-
-The preserved value of the ``qemu_bin`` parameter or the result of the
-dynamic probe for a QEMU binary in the current working directory or
-source tree.
-
-LinuxTest
-^^^^^^^^^
-
-Besides the attributes present on the ``avocado_qemu.QemuSystemTest`` base
-class, the ``avocado_qemu.LinuxTest`` adds the following attributes:
-
-distro
-""""""
-
-The name of the Linux distribution used as the guest image for the
-test.  The name should match the **Provider** column on the list
-of images supported by the avocado.utils.vmimage library:
-
-https://avocado-framework.readthedocs.io/en/latest/guides/writer/libs/vmimage.html#supported-images
-
-distro_version
-""""""""""""""
-
-The version of the Linux distribution as the guest image for the
-test.  The name should match the **Version** column on the list
-of images supported by the avocado.utils.vmimage library:
-
-https://avocado-framework.readthedocs.io/en/latest/guides/writer/libs/vmimage.html#supported-images
-
-distro_checksum
-"""""""""""""""
-
-The sha256 hash of the guest image file used for the test.
-
-If this value is not set in the code or by a test parameter (with the
-same name), no validation on the integrity of the image will be
-performed.
-
-Parameter reference
--------------------
-
-To understand how Avocado parameters are accessed by tests, and how
-they can be passed to tests, please refer to::
-
-  https://avocado-framework.readthedocs.io/en/latest/guides/writer/chapters/writing.html#accessing-test-parameters
-
-Parameter values can be easily seen in the log files, and will look
-like the following:
-
-.. code::
-
-  PARAMS (key=qemu_bin, path=*, default=./qemu-system-x86_64) => './qemu-system-x86_64
-
-Test
-^^^^
-
-arch
-""""
-
-The architecture that will influence the selection of a QEMU binary
-(when one is not explicitly given).
-
-Tests are also free to use this parameter value, for their own needs.
-A test may, for instance, use the same value when selecting the
-architecture of a kernel or disk image to boot a VM with.
-
-This parameter has a direct relation with the ``arch`` attribute.  If
-not given, it will default to None.
-
-cpu
-"""
-
-The cpu model that will be set to all QEMUMachine instances created
-by the test.
-
-machine
-"""""""
-
-The machine type that will be set to all QEMUMachine instances created
-by the test.
-
-qemu_bin
-""""""""
-
-The exact QEMU binary to be used on QEMUMachine.
-
-LinuxTest
-^^^^^^^^^
-
-Besides the parameters present on the ``avocado_qemu.QemuSystemTest`` base
-class, the ``avocado_qemu.LinuxTest`` adds the following parameters:
-
-distro
-""""""
-
-The name of the Linux distribution used as the guest image for the
-test.  The name should match the **Provider** column on the list
-of images supported by the avocado.utils.vmimage library:
-
-https://avocado-framework.readthedocs.io/en/latest/guides/writer/libs/vmimage.html#supported-images
-
-distro_version
-""""""""""""""
-
-The version of the Linux distribution as the guest image for the
-test.  The name should match the **Version** column on the list
-of images supported by the avocado.utils.vmimage library:
-
-https://avocado-framework.readthedocs.io/en/latest/guides/writer/libs/vmimage.html#supported-images
-
-distro_checksum
-"""""""""""""""
-
-The sha256 hash of the guest image file used for the test.
-
-If this value is not set in the code or by this parameter no
-validation on the integrity of the image will be performed.
-
-Skipping tests
---------------
-
-The Avocado framework provides Python decorators which allow for easily skip
-tests running under certain conditions. For example, on the lack of a binary
-on the test system or when the running environment is a CI system. For further
-information about those decorators, please refer to::
-
-  https://avocado-framework.readthedocs.io/en/latest/guides/writer/chapters/writing.html#skipping-tests
-
-While the conditions for skipping tests are often specifics of each one, there
-are recurring scenarios identified by the QEMU developers and the use of
-environment variables became a kind of standard way to enable/disable tests.
-
-Here is a list of the most used variables:
-
-AVOCADO_ALLOW_LARGE_STORAGE
-^^^^^^^^^^^^^^^^^^^^^^^^^^^
-Tests which are going to fetch or produce assets considered *large* are not
-going to run unless that ``AVOCADO_ALLOW_LARGE_STORAGE=1`` is exported on
-the environment.
-
-The definition of *large* is a bit arbitrary here, but it usually means an
-asset which occupies at least 1GB of size on disk when uncompressed.
-
-SPEED
-^^^^^
-Tests which have a long runtime will not be run unless ``SPEED=slow`` is
-exported on the environment.
-
-The definition of *long* is a bit arbitrary here, and it depends on the
-usefulness of the test too. A unique test is worth spending more time on,
-small variations on existing tests perhaps less so. As a rough guide,
-a test or set of similar tests which take more than 100 seconds to
-complete.
-
-AVOCADO_ALLOW_UNTRUSTED_CODE
-^^^^^^^^^^^^^^^^^^^^^^^^^^^^
-There are tests which will boot a kernel image or firmware that can be
-considered not safe to run on the developer's workstation, thus they are
-skipped by default. The definition of *not safe* is also arbitrary but
-usually it means a blob which either its source or build process aren't
-public available.
-
-You should export ``AVOCADO_ALLOW_UNTRUSTED_CODE=1`` on the environment in
-order to allow tests which make use of those kind of assets.
-
-AVOCADO_TIMEOUT_EXPECTED
-^^^^^^^^^^^^^^^^^^^^^^^^
-The Avocado framework has a timeout mechanism which interrupts tests to avoid the
-test suite of getting stuck. The timeout value can be set via test parameter or
-property defined in the test class, for further details::
-
-  https://avocado-framework.readthedocs.io/en/latest/guides/writer/chapters/writing.html#setting-a-test-timeout
-
-Even though the timeout can be set by the test developer, there are some tests
-that may not have a well-defined limit of time to finish under certain
-conditions. For example, tests that take longer to execute when QEMU is
-compiled with debug flags. Therefore, the ``AVOCADO_TIMEOUT_EXPECTED`` variable
-has been used to determine whether those tests should run or not.
-
-QEMU_TEST_FLAKY_TESTS
-^^^^^^^^^^^^^^^^^^^^^
-Some tests are not working reliably and thus are disabled by default.
-This includes tests that don't run reliably on GitLab's CI which
-usually expose real issues that are rarely seen on developer machines
-due to the constraints of the CI environment. If you encounter a
-similar situation then raise a bug and then mark the test as shown on
-the code snippet below:
-
-.. code::
-
-  # See https://gitlab.com/qemu-project/qemu/-/issues/nnnn
-  @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable on GitLab')
-  def test(self):
-      do_something()
-
-You can also add ``:avocado: tags=flaky`` to the test meta-data so
-only the flaky tests can be run as a group:
-
-.. code::
-
-   env QEMU_TEST_FLAKY_TESTS=1 ./pyvenv/bin/avocado \
-      run tests/avocado -filter-by-tags=flaky
-
-Tests should not live in this state forever and should either be fixed
-or eventually removed.
-
-
-Uninstalling Avocado
---------------------
-
-If you've followed the manual installation instructions above, you can
-easily uninstall Avocado.  Start by listing the packages you have
-installed::
-
-  pip list --user
-
-And remove any package you want with::
-
-  pip uninstall <package_name>
-
-If you've used ``make check-avocado``, the Python virtual environment where
-Avocado is installed will be cleaned up as part of ``make check-clean``.
diff --git a/docs/devel/testing/functional.rst b/docs/devel/testing/functional.rst
index 9bc973392a..8030cb4299 100644
--- a/docs/devel/testing/functional.rst
+++ b/docs/devel/testing/functional.rst
@@ -6,9 +6,6 @@ Functional testing with Python
 The ``tests/functional`` directory hosts functional tests written in
 Python. They are usually higher level tests, and may interact with
 external resources and with various guest operating systems.
-The functional tests have initially evolved from the Avocado tests, so there
-is a lot of similarity to those tests here (see :ref:`checkavocado-ref` for
-details about the Avocado tests).
 
 The tests should be written in the style of the Python `unittest`_ framework,
 using stdio for the TAP protocol. The folder ``tests/functional/qemu_test``
diff --git a/docs/devel/testing/index.rst b/docs/devel/testing/index.rst
index 1171f7db8f..ccc2fc6cbc 100644
--- a/docs/devel/testing/index.rst
+++ b/docs/devel/testing/index.rst
@@ -10,7 +10,6 @@ testing infrastructure.
    main
    qtest
    functional
-   avocado
    acpi-bits
    ci
    fuzzing
diff --git a/docs/devel/testing/main.rst b/docs/devel/testing/main.rst
index e56da22edf..6b18ed875c 100644
--- a/docs/devel/testing/main.rst
+++ b/docs/devel/testing/main.rst
@@ -919,21 +919,6 @@ Python. You can run the functional tests simply by executing:
 
 See :ref:`checkfunctional-ref` for more details.
 
-Integration tests using the Avocado Framework
----------------------------------------------
-
-The ``tests/avocado`` directory hosts integration tests. They're usually
-higher level tests, and may interact with external resources and with
-various guest operating systems.
-
-You can run the avocado tests simply by executing:
-
-.. code::
-
-  make check-avocado
-
-See :ref:`checkavocado-ref` for more details.
-
 .. _checktcg-ref:
 
 Testing with "make check-tcg"
diff --git a/pythondeps.toml b/pythondeps.toml
index c03c9df81b..7eaaa0fed1 100644
--- a/pythondeps.toml
+++ b/pythondeps.toml
@@ -27,9 +27,5 @@ pycotap = { accepted = ">=1.1.0", installed = "1.3.1" }
 sphinx = { accepted = ">=3.4.3", installed = "5.3.0", canary = "sphinx-build" }
 sphinx_rtd_theme = { accepted = ">=0.5", installed = "1.1.1" }
 
-[avocado]
-# Note that qemu.git/python/ is always implicitly installed.
-# Prefer an LTS version when updating the accepted versions of
-# avocado-framework, for example right now the limit is 92.x.
-avocado-framework = { accepted = "(>=103.0, <104.0)", installed = "103.0", canary = "avocado" }
-pycdlib = { accepted = ">=1.11.0" }
+[testdeps]
+qemu.qmp = { accepted = ">=0.0.3", installed = "0.0.3" }
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 9b7c410ff2..9a3d137283 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -18,7 +18,6 @@ ifneq ($(filter $(all-check-targets), check-softfloat),)
 	@echo " $(MAKE) check-tcg                Run TCG tests"
 	@echo " $(MAKE) check-softfloat          Run FPU emulation tests"
 endif
-	@echo " $(MAKE) check-avocado            Run avocado (integration) tests for currently configured targets"
 	@echo
 	@echo " $(MAKE) check-report.junit.xml   Generates an aggregated XML test report"
 	@echo " $(MAKE) check-venv               Creates a Python venv for tests"
@@ -26,7 +25,6 @@ endif
 	@echo
 	@echo "The following are useful for CI builds"
 	@echo " $(MAKE) check-build              Build most test binaries"
-	@echo " $(MAKE) get-vm-images            Downloads all images used by avocado tests, according to configured targets (~350 MB each, 1.5 GB max)"
 	@echo
 	@echo
 	@echo "The variable SPEED can be set to control the gtester speed setting."
@@ -86,26 +84,12 @@ distclean-tcg: $(DISTCLEAN_TCG_TARGET_RULES)
 
 # Python venv for running tests
 
-.PHONY: check-venv check-avocado check-acceptance check-acceptance-deprecated-warning
+.PHONY: check-venv
 
 # Build up our target list from the filtered list of ninja targets
 TARGETS=$(patsubst libqemu-%.a, %, $(filter libqemu-%.a, $(ninja-targets)))
 
 TESTS_VENV_TOKEN=$(BUILD_DIR)/pyvenv/tests.group
-TESTS_RESULTS_DIR=$(BUILD_DIR)/tests/results
-ifndef AVOCADO_TESTS
-	AVOCADO_TESTS=tests/avocado
-endif
-# Controls the output generated by Avocado when running tests.
-# Any number of command separated loggers are accepted.  For more
-# information please refer to "avocado --help".
-AVOCADO_SHOW?=app
-ifndef AVOCADO_TAGS
-	AVOCADO_CMDLINE_TAGS=$(patsubst %-softmmu,-t arch:%, \
-						 $(filter %-softmmu,$(TARGETS)))
-else
-	AVOCADO_CMDLINE_TAGS=$(addprefix -t , $(AVOCADO_TAGS))
-endif
 
 quiet-venv-pip = $(quiet-@)$(call quiet-command-run, \
     $(PYTHON) -m pip -q --disable-pip-version-check $1, \
@@ -113,47 +97,11 @@ quiet-venv-pip = $(quiet-@)$(call quiet-command-run, \
 
 $(TESTS_VENV_TOKEN): $(SRC_PATH)/pythondeps.toml
 	$(call quiet-venv-pip,install -e "$(SRC_PATH)/python/")
-	$(MKVENV_ENSUREGROUP) $< avocado
+	$(MKVENV_ENSUREGROUP) $< testdeps
 	$(call quiet-command, touch $@)
 
-$(TESTS_RESULTS_DIR):
-	$(call quiet-command, mkdir -p $@, \
-            MKDIR, $@)
-
 check-venv: $(TESTS_VENV_TOKEN)
 
-FEDORA_31_ARCHES_TARGETS=$(patsubst %-softmmu,%, $(filter %-softmmu,$(TARGETS)))
-FEDORA_31_ARCHES_CANDIDATES=$(patsubst ppc64,ppc64le,$(FEDORA_31_ARCHES_TARGETS))
-FEDORA_31_ARCHES := x86_64 aarch64 ppc64le s390x
-FEDORA_31_DOWNLOAD=$(filter $(FEDORA_31_ARCHES),$(FEDORA_31_ARCHES_CANDIDATES))
-
-# download one specific Fedora 31 image
-get-vm-image-fedora-31-%: check-venv
-	$(call quiet-command, \
-             $(PYTHON) -m avocado vmimage get \
-             --distro=fedora --distro-version=31 --arch=$*, \
-	"AVOCADO", "Downloading avocado tests VM image for $*")
-
-# download all vm images, according to defined targets
-get-vm-images: check-venv $(patsubst %,get-vm-image-fedora-31-%, $(FEDORA_31_DOWNLOAD))
-
-check-avocado: check-venv $(TESTS_RESULTS_DIR) get-vm-images
-	$(call quiet-command, \
-            $(PYTHON) -m avocado \
-            --show=$(AVOCADO_SHOW) run --job-results-dir=$(TESTS_RESULTS_DIR) \
-            $(if $(AVOCADO_TAGS),, --filter-by-tags-include-empty \
-			--filter-by-tags-include-empty-key) \
-            $(AVOCADO_CMDLINE_TAGS) --max-parallel-tasks=1 \
-            $(if $(GITLAB_CI),,--failfast) $(AVOCADO_TESTS), \
-            "AVOCADO", "tests/avocado")
-
-check-acceptance-deprecated-warning:
-	@echo
-	@echo "Note '$(MAKE) check-acceptance' is deprecated, use '$(MAKE) check-avocado' instead."
-	@echo
-
-check-acceptance: check-acceptance-deprecated-warning | check-avocado
-
 FUNCTIONAL_TARGETS=$(patsubst %-softmmu,check-functional-%, $(filter %-softmmu,$(TARGETS)))
 .PHONY: $(FUNCTIONAL_TARGETS)
 $(FUNCTIONAL_TARGETS):
@@ -169,13 +117,13 @@ check-func check-func-quick:
 
 # Consolidated targets
 
-.PHONY: check check-clean get-vm-images
+.PHONY: check check-clean
 check:
 
 check-build: run-ninja
 
 check-clean:
-	rm -rf $(TESTS_RESULTS_DIR)
+	rm -rf $(BUILD_DIR)/tests/functional
 
 clean: check-clean clean-tcg
 distclean: distclean-tcg
diff --git a/tests/avocado/README.rst b/tests/avocado/README.rst
deleted file mode 100644
index 94488371bb..0000000000
--- a/tests/avocado/README.rst
+++ /dev/null
@@ -1,10 +0,0 @@
-=============================================
-Integration tests using the Avocado Framework
-=============================================
-
-This directory contains integration tests. They're usually higher
-level, and may interact with external resources and with various
-guest operating systems.
-
-For more information, please refer to ``docs/devel/testing.rst``,
-section "Integration tests using the Avocado Framework".
diff --git a/tests/avocado/avocado_qemu/__init__.py b/tests/avocado/avocado_qemu/__init__.py
deleted file mode 100644
index 93c3460242..0000000000
--- a/tests/avocado/avocado_qemu/__init__.py
+++ /dev/null
@@ -1,424 +0,0 @@
-# Test class and utilities for functional tests
-#
-# Copyright (c) 2018 Red Hat, Inc.
-#
-# Author:
-#  Cleber Rosa <crosa@redhat.com>
-#
-# This work is licensed under the terms of the GNU GPL, version 2 or
-# later.  See the COPYING file in the top-level directory.
-
-import logging
-import os
-import subprocess
-import sys
-import tempfile
-import time
-import uuid
-
-import avocado
-from avocado.utils import ssh
-from avocado.utils.path import find_command
-
-from qemu.machine import QEMUMachine
-from qemu.utils import (get_info_usernet_hostfwd_port, kvm_available,
-                        tcg_available)
-
-
-#: The QEMU build root directory.  It may also be the source directory
-#: if building from the source dir, but it's safer to use BUILD_DIR for
-#: that purpose.  Be aware that if this code is moved outside of a source
-#: and build tree, it will not be accurate.
-BUILD_DIR = os.path.dirname(os.path.dirname(os.path.dirname(os.path.dirname(__file__))))
-
-
-def has_cmd(name, args=None):
-    """
-    This function is for use in a @avocado.skipUnless decorator, e.g.:
-
-        @skipUnless(*has_cmd('sudo -n', ('sudo', '-n', 'true')))
-        def test_something_that_needs_sudo(self):
-            ...
-    """
-
-    if args is None:
-        args = ('which', name)
-
-    try:
-        _, stderr, exitcode = run_cmd(args)
-    except Exception as e:
-        exitcode = -1
-        stderr = str(e)
-
-    if exitcode != 0:
-        cmd_line = ' '.join(args)
-        err = f'{name} required, but "{cmd_line}" failed: {stderr.strip()}'
-        return (False, err)
-    else:
-        return (True, '')
-
-def has_cmds(*cmds):
-    """
-    This function is for use in a @avocado.skipUnless decorator and
-    allows checking for the availability of multiple commands, e.g.:
-
-        @skipUnless(*has_cmds(('cmd1', ('cmd1', '--some-parameter')),
-                              'cmd2', 'cmd3'))
-        def test_something_that_needs_cmd1_and_cmd2(self):
-            ...
-    """
-
-    for cmd in cmds:
-        if isinstance(cmd, str):
-            cmd = (cmd,)
-
-        ok, errstr = has_cmd(*cmd)
-        if not ok:
-            return (False, errstr)
-
-    return (True, '')
-
-def run_cmd(args):
-    subp = subprocess.Popen(args,
-                            stdout=subprocess.PIPE,
-                            stderr=subprocess.PIPE,
-                            universal_newlines=True)
-    stdout, stderr = subp.communicate()
-    ret = subp.returncode
-
-    return (stdout, stderr, ret)
-
-def is_readable_executable_file(path):
-    return os.path.isfile(path) and os.access(path, os.R_OK | os.X_OK)
-
-
-def pick_default_qemu_bin(bin_prefix='qemu-system-', arch=None):
-    """
-    Picks the path of a QEMU binary, starting either in the current working
-    directory or in the source tree root directory.
-
-    :param arch: the arch to use when looking for a QEMU binary (the target
-                 will match the arch given).  If None (the default), arch
-                 will be the current host system arch (as given by
-                 :func:`os.uname`).
-    :type arch: str
-    :returns: the path to the default QEMU binary or None if one could not
-              be found
-    :rtype: str or None
-    """
-    if arch is None:
-        arch = os.uname()[4]
-    # qemu binary path does not match arch for powerpc, handle it
-    if 'ppc64le' in arch:
-        arch = 'ppc64'
-    qemu_bin_name = bin_prefix + arch
-    qemu_bin_paths = [
-        os.path.join(".", qemu_bin_name),
-        os.path.join(BUILD_DIR, qemu_bin_name),
-        os.path.join(BUILD_DIR, "build", qemu_bin_name),
-    ]
-    for path in qemu_bin_paths:
-        if is_readable_executable_file(path):
-            return path
-    return None
-
-
-def _console_interaction(test, success_message, failure_message,
-                         send_string, keep_sending=False, vm=None):
-    assert not keep_sending or send_string
-    if vm is None:
-        vm = test.vm
-    console = vm.console_file
-    console_logger = logging.getLogger('console')
-    while True:
-        if send_string:
-            vm.console_socket.sendall(send_string.encode())
-            if not keep_sending:
-                send_string = None # send only once
-
-        # Only consume console output if waiting for something
-        if success_message is None and failure_message is None:
-            if send_string is None:
-                break
-            continue
-
-        try:
-            msg = console.readline().decode().strip()
-        except UnicodeDecodeError:
-            msg = None
-        if not msg:
-            continue
-        console_logger.debug(msg)
-        if success_message is None or success_message in msg:
-            break
-        if failure_message and failure_message in msg:
-            console.close()
-            fail = 'Failure message found in console: "%s". Expected: "%s"' % \
-                    (failure_message, success_message)
-            test.fail(fail)
-
-def interrupt_interactive_console_until_pattern(test, success_message,
-                                                failure_message=None,
-                                                interrupt_string='\r'):
-    """
-    Keep sending a string to interrupt a console prompt, while logging the
-    console output. Typical use case is to break a boot loader prompt, such:
-
-        Press a key within 5 seconds to interrupt boot process.
-        5
-        4
-        3
-        2
-        1
-        Booting default image...
-
-    :param test: an Avocado test containing a VM that will have its console
-                 read and probed for a success or failure message
-    :type test: :class:`avocado_qemu.QemuSystemTest`
-    :param success_message: if this message appears, test succeeds
-    :param failure_message: if this message appears, test fails
-    :param interrupt_string: a string to send to the console before trying
-                             to read a new line
-    """
-    _console_interaction(test, success_message, failure_message,
-                         interrupt_string, True)
-
-def wait_for_console_pattern(test, success_message, failure_message=None,
-                             vm=None):
-    """
-    Waits for messages to appear on the console, while logging the content
-
-    :param test: an Avocado test containing a VM that will have its console
-                 read and probed for a success or failure message
-    :type test: :class:`avocado_qemu.QemuSystemTest`
-    :param success_message: if this message appears, test succeeds
-    :param failure_message: if this message appears, test fails
-    """
-    _console_interaction(test, success_message, failure_message, None, vm=vm)
-
-def exec_command(test, command):
-    """
-    Send a command to a console (appending CRLF characters), while logging
-    the content.
-
-    :param test: an Avocado test containing a VM.
-    :type test: :class:`avocado_qemu.QemuSystemTest`
-    :param command: the command to send
-    :type command: str
-    """
-    _console_interaction(test, None, None, command + '\r')
-
-def exec_command_and_wait_for_pattern(test, command,
-                                      success_message, failure_message=None):
-    """
-    Send a command to a console (appending CRLF characters), then wait
-    for success_message to appear on the console, while logging the.
-    content. Mark the test as failed if failure_message is found instead.
-
-    :param test: an Avocado test containing a VM that will have its console
-                 read and probed for a success or failure message
-    :type test: :class:`avocado_qemu.QemuSystemTest`
-    :param command: the command to send
-    :param success_message: if this message appears, test succeeds
-    :param failure_message: if this message appears, test fails
-    """
-    _console_interaction(test, success_message, failure_message, command + '\r')
-
-class QemuBaseTest(avocado.Test):
-
-    # default timeout for all tests, can be overridden
-    timeout = 120
-
-    def _get_unique_tag_val(self, tag_name):
-        """
-        Gets a tag value, if unique for a key
-        """
-        vals = self.tags.get(tag_name, [])
-        if len(vals) == 1:
-            return vals.pop()
-        return None
-
-    def setUp(self, bin_prefix):
-        self.arch = self.params.get('arch',
-                                    default=self._get_unique_tag_val('arch'))
-
-        self.cpu = self.params.get('cpu',
-                                   default=self._get_unique_tag_val('cpu'))
-
-        default_qemu_bin = pick_default_qemu_bin(bin_prefix, arch=self.arch)
-        self.qemu_bin = self.params.get('qemu_bin',
-                                        default=default_qemu_bin)
-        if self.qemu_bin is None:
-            self.cancel("No QEMU binary defined or found in the build tree")
-
-    def fetch_asset(self, name,
-                    asset_hash, algorithm=None,
-                    locations=None, expire=None,
-                    find_only=False, cancel_on_missing=True):
-        return super().fetch_asset(name,
-                        asset_hash=asset_hash,
-                        algorithm=algorithm,
-                        locations=locations,
-                        expire=expire,
-                        find_only=find_only,
-                        cancel_on_missing=cancel_on_missing)
-
-
-class QemuSystemTest(QemuBaseTest):
-    """Facilitates system emulation tests."""
-
-    def setUp(self):
-        self._vms = {}
-
-        super().setUp('qemu-system-')
-
-        accel_required = self._get_unique_tag_val('accel')
-        if accel_required:
-            self.require_accelerator(accel_required)
-
-        self.machine = self.params.get('machine',
-                                       default=self._get_unique_tag_val('machine'))
-
-    def require_accelerator(self, accelerator):
-        """
-        Requires an accelerator to be available for the test to continue
-
-        It takes into account the currently set qemu binary.
-
-        If the check fails, the test is canceled.  If the check itself
-        for the given accelerator is not available, the test is also
-        canceled.
-
-        :param accelerator: name of the accelerator, such as "kvm" or "tcg"
-        :type accelerator: str
-        """
-        checker = {'tcg': tcg_available,
-                   'kvm': kvm_available}.get(accelerator)
-        if checker is None:
-            self.cancel("Don't know how to check for the presence "
-                        "of accelerator %s" % accelerator)
-        if not checker(qemu_bin=self.qemu_bin):
-            self.cancel("%s accelerator does not seem to be "
-                        "available" % accelerator)
-
-    def require_netdev(self, netdevname):
-        netdevhelp = run_cmd([self.qemu_bin,
-                             '-M', 'none', '-netdev', 'help'])[0];
-        if netdevhelp.find('\n' + netdevname + '\n') < 0:
-            self.cancel('no support for user networking')
-
-    def _new_vm(self, name, *args):
-        self._sd = tempfile.TemporaryDirectory(prefix="qemu_")
-        vm = QEMUMachine(self.qemu_bin, base_temp_dir=self.workdir,
-                         log_dir=self.logdir)
-        self.log.debug('QEMUMachine "%s" created', name)
-        self.log.debug('QEMUMachine "%s" temp_dir: %s', name, vm.temp_dir)
-        self.log.debug('QEMUMachine "%s" log_dir: %s', name, vm.log_dir)
-        if args:
-            vm.add_args(*args)
-        return vm
-
-    def get_qemu_img(self):
-        self.log.debug('Looking for and selecting a qemu-img binary')
-
-        # If qemu-img has been built, use it, otherwise the system wide one
-        # will be used.
-        qemu_img = os.path.join(BUILD_DIR, 'qemu-img')
-        if not os.path.exists(qemu_img):
-            qemu_img = find_command('qemu-img', False)
-        if qemu_img is False:
-            self.cancel('Could not find "qemu-img"')
-
-        return qemu_img
-
-    @property
-    def vm(self):
-        return self.get_vm(name='default')
-
-    def get_vm(self, *args, name=None):
-        if not name:
-            name = str(uuid.uuid4())
-        if self._vms.get(name) is None:
-            self._vms[name] = self._new_vm(name, *args)
-            if self.cpu is not None:
-                self._vms[name].add_args('-cpu', self.cpu)
-            if self.machine is not None:
-                self._vms[name].set_machine(self.machine)
-        return self._vms[name]
-
-    def set_vm_arg(self, arg, value):
-        """
-        Set an argument to list of extra arguments to be given to the QEMU
-        binary. If the argument already exists then its value is replaced.
-
-        :param arg: the QEMU argument, such as "-cpu" in "-cpu host"
-        :type arg: str
-        :param value: the argument value, such as "host" in "-cpu host"
-        :type value: str
-        """
-        if not arg or not value:
-            return
-        if arg not in self.vm.args:
-            self.vm.args.extend([arg, value])
-        else:
-            idx = self.vm.args.index(arg) + 1
-            if idx < len(self.vm.args):
-                self.vm.args[idx] = value
-            else:
-                self.vm.args.append(value)
-
-    def tearDown(self):
-        for vm in self._vms.values():
-            vm.shutdown()
-        self._sd = None
-        super().tearDown()
-
-
-class LinuxSSHMixIn:
-    """Contains utility methods for interacting with a guest via SSH."""
-
-    def ssh_connect(self, username, credential, credential_is_key=True):
-        self.ssh_logger = logging.getLogger('ssh')
-        res = self.vm.cmd('human-monitor-command',
-                          command_line='info usernet')
-        port = get_info_usernet_hostfwd_port(res)
-        self.assertIsNotNone(port)
-        self.assertGreater(port, 0)
-        self.log.debug('sshd listening on port: %d', port)
-        if credential_is_key:
-            self.ssh_session = ssh.Session('127.0.0.1', port=port,
-                                           user=username, key=credential)
-        else:
-            self.ssh_session = ssh.Session('127.0.0.1', port=port,
-                                           user=username, password=credential)
-        for i in range(10):
-            try:
-                self.ssh_session.connect()
-                return
-            except:
-                time.sleep(i)
-        self.fail('ssh connection timeout')
-
-    def ssh_command(self, command):
-        self.ssh_logger.info(command)
-        result = self.ssh_session.cmd(command)
-        stdout_lines = [line.rstrip() for line
-                        in result.stdout_text.splitlines()]
-        for line in stdout_lines:
-            self.ssh_logger.info(line)
-        stderr_lines = [line.rstrip() for line
-                        in result.stderr_text.splitlines()]
-        for line in stderr_lines:
-            self.ssh_logger.warning(line)
-
-        self.assertEqual(result.exit_status, 0,
-                         f'Guest command failed: {command}')
-        return stdout_lines, stderr_lines
-
-    def ssh_command_output_contains(self, cmd, exp):
-        stdout, _ = self.ssh_command(cmd)
-        for line in stdout:
-            if exp in line:
-                break
-        else:
-            self.fail('"%s" output does not contain "%s"' % (cmd, exp))
diff --git a/tests/avocado/avocado_qemu/linuxtest.py b/tests/avocado/avocado_qemu/linuxtest.py
deleted file mode 100644
index 66fb9f1507..0000000000
--- a/tests/avocado/avocado_qemu/linuxtest.py
+++ /dev/null
@@ -1,253 +0,0 @@
-# Test class and utilities for functional Linux-based tests
-#
-# Copyright (c) 2018 Red Hat, Inc.
-#
-# Author:
-#  Cleber Rosa <crosa@redhat.com>
-#
-# This work is licensed under the terms of the GNU GPL, version 2 or
-# later.  See the COPYING file in the top-level directory.
-
-import os
-import shutil
-
-from avocado.utils import cloudinit, datadrainer, process, vmimage
-
-from avocado_qemu import LinuxSSHMixIn
-from avocado_qemu import QemuSystemTest
-
-if os.path.islink(os.path.dirname(os.path.dirname(__file__))):
-    # The link to the avocado tests dir in the source code directory
-    lnk = os.path.dirname(os.path.dirname(__file__))
-    #: The QEMU root source directory
-    SOURCE_DIR = os.path.dirname(os.path.dirname(os.readlink(lnk)))
-else:
-    SOURCE_DIR = BUILD_DIR
-
-class LinuxDistro:
-    """Represents a Linux distribution
-
-    Holds information of known distros.
-    """
-    #: A collection of known distros and their respective image checksum
-    KNOWN_DISTROS = {
-        'fedora': {
-            '31': {
-                'x86_64':
-                {'checksum': ('e3c1b309d9203604922d6e255c2c5d09'
-                              '8a309c2d46215d8fc026954f3c5c27a0'),
-                 'pxeboot_url': ('https://archives.fedoraproject.org/'
-                                 'pub/archive/fedora/linux/releases/31/'
-                                 'Everything/x86_64/os/images/pxeboot/'),
-                 'kernel_params': ('root=UUID=b1438b9b-2cab-4065-a99a-'
-                                   '08a96687f73c ro no_timer_check '
-                                   'net.ifnames=0 console=tty1 '
-                                   'console=ttyS0,115200n8'),
-                },
-                'aarch64':
-                {'checksum': ('1e18d9c0cf734940c4b5d5ec592facae'
-                              'd2af0ad0329383d5639c997fdf16fe49'),
-                'pxeboot_url': 'https://archives.fedoraproject.org/'
-                               'pub/archive/fedora/linux/releases/31/'
-                               'Everything/aarch64/os/images/pxeboot/',
-                'kernel_params': ('root=UUID=b6950a44-9f3c-4076-a9c2-'
-                                  '355e8475b0a7 ro earlyprintk=pl011,0x9000000'
-                                  ' ignore_loglevel no_timer_check'
-                                  ' printk.time=1 rd_NO_PLYMOUTH'
-                                  ' console=ttyAMA0'),
-                },
-                'ppc64':
-                {'checksum': ('7c3528b85a3df4b2306e892199a9e1e4'
-                              '3f991c506f2cc390dc4efa2026ad2f58')},
-                's390x':
-                {'checksum': ('4caaab5a434fd4d1079149a072fdc789'
-                              '1e354f834d355069ca982fdcaf5a122d')},
-            },
-            '32': {
-                'aarch64':
-                {'checksum': ('b367755c664a2d7a26955bbfff985855'
-                              'adfa2ca15e908baf15b4b176d68d3967'),
-                'pxeboot_url': ('http://dl.fedoraproject.org/pub/fedora/linux/'
-                                'releases/32/Server/aarch64/os/images/'
-                                'pxeboot/'),
-                'kernel_params': ('root=UUID=3df75b65-be8d-4db4-8655-'
-                                  '14d95c0e90c5 ro no_timer_check net.ifnames=0'
-                                  ' console=tty1 console=ttyS0,115200n8'),
-                },
-            },
-            '33': {
-                'aarch64':
-                {'checksum': ('e7f75cdfd523fe5ac2ca9eeece68edc1'
-                              'a81f386a17f969c1d1c7c87031008a6b'),
-                'pxeboot_url': ('http://dl.fedoraproject.org/pub/fedora/linux/'
-                                'releases/33/Server/aarch64/os/images/'
-                                'pxeboot/'),
-                'kernel_params': ('root=UUID=d20b3ffa-6397-4a63-a734-'
-                                  '1126a0208f8a ro no_timer_check net.ifnames=0'
-                                  ' console=tty1 console=ttyS0,115200n8'
-                                  ' console=tty0'),
-                 },
-            },
-        }
-    }
-
-    def __init__(self, name, version, arch):
-        self.name = name
-        self.version = version
-        self.arch = arch
-        try:
-            info = self.KNOWN_DISTROS.get(name).get(version).get(arch)
-        except AttributeError:
-            # Unknown distro
-            info = None
-        self._info = info or {}
-
-    @property
-    def checksum(self):
-        """Gets the cloud-image file checksum"""
-        return self._info.get('checksum', None)
-
-    @checksum.setter
-    def checksum(self, value):
-        self._info['checksum'] = value
-
-    @property
-    def pxeboot_url(self):
-        """Gets the repository url where pxeboot files can be found"""
-        return self._info.get('pxeboot_url', None)
-
-    @property
-    def default_kernel_params(self):
-        """Gets the default kernel parameters"""
-        return self._info.get('kernel_params', None)
-
-
-class LinuxTest(LinuxSSHMixIn, QemuSystemTest):
-    """Facilitates having a cloud-image Linux based available.
-
-    For tests that intend to interact with guests, this is a better choice
-    to start with than the more vanilla `QemuSystemTest` class.
-    """
-
-    distro = None
-    username = 'root'
-    password = 'password'
-    smp = '2'
-    memory = '1024'
-
-    def _set_distro(self):
-        distro_name = self.params.get(
-            'distro',
-            default=self._get_unique_tag_val('distro'))
-        if not distro_name:
-            distro_name = 'fedora'
-
-        distro_version = self.params.get(
-            'distro_version',
-            default=self._get_unique_tag_val('distro_version'))
-        if not distro_version:
-            distro_version = '31'
-
-        self.distro = LinuxDistro(distro_name, distro_version, self.arch)
-
-        # The distro checksum behaves differently than distro name and
-        # version. First, it does not respect a tag with the same
-        # name, given that it's not expected to be used for filtering
-        # (distro name versions are the natural choice).  Second, the
-        # order of precedence is: parameter, attribute and then value
-        # from KNOWN_DISTROS.
-        distro_checksum = self.params.get('distro_checksum',
-                                          default=None)
-        if distro_checksum:
-            self.distro.checksum = distro_checksum
-
-    def setUp(self, ssh_pubkey=None, network_device_type='virtio-net'):
-        super().setUp()
-        self.require_netdev('user')
-        self._set_distro()
-        self.vm.add_args('-smp', self.smp)
-        self.vm.add_args('-m', self.memory)
-        # The following network device allows for SSH connections
-        self.vm.add_args('-netdev', 'user,id=vnet,hostfwd=:127.0.0.1:0-:22',
-                         '-device', '%s,netdev=vnet' % network_device_type)
-        self.set_up_boot()
-        if ssh_pubkey is None:
-            ssh_pubkey, self.ssh_key = self.set_up_existing_ssh_keys()
-        self.set_up_cloudinit(ssh_pubkey)
-
-    def set_up_existing_ssh_keys(self):
-        ssh_public_key = os.path.join(SOURCE_DIR, 'tests', 'keys', 'id_rsa.pub')
-        source_private_key = os.path.join(SOURCE_DIR, 'tests', 'keys', 'id_rsa')
-        ssh_dir = os.path.join(self.workdir, '.ssh')
-        os.mkdir(ssh_dir, mode=0o700)
-        ssh_private_key = os.path.join(ssh_dir,
-                                       os.path.basename(source_private_key))
-        shutil.copyfile(source_private_key, ssh_private_key)
-        os.chmod(ssh_private_key, 0o600)
-        return (ssh_public_key, ssh_private_key)
-
-    def download_boot(self):
-        # Set the qemu-img binary.
-        # If none is available, the test will cancel.
-        vmimage.QEMU_IMG = super().get_qemu_img()
-
-        self.log.info('Downloading/preparing boot image')
-        # Fedora 31 only provides ppc64le images
-        image_arch = self.arch
-        if self.distro.name == 'fedora':
-            if image_arch == 'ppc64':
-                image_arch = 'ppc64le'
-
-        try:
-            boot = vmimage.get(
-                self.distro.name, arch=image_arch, version=self.distro.version,
-                checksum=self.distro.checksum,
-                algorithm='sha256',
-                cache_dir=self.cache_dirs[0],
-                snapshot_dir=self.workdir)
-        except:
-            self.cancel('Failed to download/prepare boot image')
-        return boot.path
-
-    def prepare_cloudinit(self, ssh_pubkey=None):
-        self.log.info('Preparing cloudinit image')
-        try:
-            cloudinit_iso = os.path.join(self.workdir, 'cloudinit.iso')
-            pubkey_content = None
-            if ssh_pubkey:
-                with open(ssh_pubkey) as pubkey:
-                    pubkey_content = pubkey.read()
-            cloudinit.iso(cloudinit_iso, self.name,
-                          username=self.username,
-                          password=self.password,
-                          # QEMU's hard coded usermode router address
-                          phone_home_host='10.0.2.2',
-                          phone_home_port=self.phone_server.server_port,
-                          authorized_key=pubkey_content)
-        except Exception:
-            self.cancel('Failed to prepare the cloudinit image')
-        return cloudinit_iso
-
-    def set_up_boot(self):
-        path = self.download_boot()
-        self.vm.add_args('-drive', 'file=%s' % path)
-
-    def set_up_cloudinit(self, ssh_pubkey=None):
-        self.phone_server = cloudinit.PhoneHomeServer(('0.0.0.0', 0),
-                                                      self.name)
-        cloudinit_iso = self.prepare_cloudinit(ssh_pubkey)
-        self.vm.add_args('-drive', 'file=%s,format=raw' % cloudinit_iso)
-
-    def launch_and_wait(self, set_up_ssh_connection=True):
-        self.vm.set_console()
-        self.vm.launch()
-        console_drainer = datadrainer.LineLogger(self.vm.console_socket.fileno(),
-                                                 logger=self.log.getChild('console'))
-        console_drainer.start()
-        self.log.info('VM launched, waiting for boot confirmation from guest')
-        while not self.phone_server.instance_phoned_back:
-            self.phone_server.handle_request()
-
-        if set_up_ssh_connection:
-            self.log.info('Setting up the SSH connection')
-            self.ssh_connect(self.username, self.ssh_key)
-- 
2.47.3


