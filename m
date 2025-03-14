Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 741BBC282EC
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 09:00:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tt0u1-0002EB-Jh; Fri, 14 Mar 2025 05:00:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tt0u0-0002Dl-NC
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 05:00:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tt0tu-0001Bs-Vv
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 05:00:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741942813;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Cx9au8EqksRfRrFZIiSx29Q6ALU3SQ+9KAEOwwf0bv0=;
 b=aszr3q2hyaBdOQ7N7gF5ab9l6YS9mZZl8/iAexbptntzAwws3/tJdJBJV6iY0XdDnPmoAn
 KHJBtnRa47gjxIk6b/MKd9WbKJSW6d8LQbCMbYZIduJgsi1I7hBXCs8SKQ3AuWBrrUvINO
 4f4R7Dz75R0HFQQJxARcWp45sZE2Opc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-684-HLqElclFMWG8JGB2_3p89w-1; Fri,
 14 Mar 2025 05:00:10 -0400
X-MC-Unique: HLqElclFMWG8JGB2_3p89w-1
X-Mimecast-MFC-AGG-ID: HLqElclFMWG8JGB2_3p89w_1741942809
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0C7101956056; Fri, 14 Mar 2025 09:00:09 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.82])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3E6631828A83; Fri, 14 Mar 2025 09:00:05 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH] docs/devel/testing: Dissolve the ci-definitions.rst.inc file
Date: Fri, 14 Mar 2025 09:59:57 +0100
Message-ID: <20250314085959.1585568-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This file was meant for defining the vocabulary for our testing
efforts, but it did not age well: First, the definitions are not
only about the CI part, but also about testing in general, so most
of the information should rather reside in main.rst instead.
Second, some vocabulary has never been really adopted by the QEMU
project, for example we never really use the word "system testing"
since "system" rather means the system emulator binaries in the
QEMU project (and we also don't do any testing with other components
like libvirt and virt-managers here). It also defines that the qtests
are the "functional" tests in QEMU, which is not really up to date
anymore after the "tests/functional" framework has been introduced
a couple of months ago (FWIW, the qtests could rather be seen as a
mix between unit testing and functional testing).

To solve this problem, move the useful parts of this file into
main.rst and directly into ci.rst, and drop the ones (like "system
testing") that we don't really need anymore.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 docs/devel/testing/ci-definitions.rst.inc | 121 ----------------------
 docs/devel/testing/ci.rst                 |  28 ++++-
 docs/devel/testing/main.rst               |  65 ++++++++++--
 3 files changed, 81 insertions(+), 133 deletions(-)
 delete mode 100644 docs/devel/testing/ci-definitions.rst.inc

diff --git a/docs/devel/testing/ci-definitions.rst.inc b/docs/devel/testing/ci-definitions.rst.inc
deleted file mode 100644
index 6d5c6fd9f20..00000000000
--- a/docs/devel/testing/ci-definitions.rst.inc
+++ /dev/null
@@ -1,121 +0,0 @@
-Definition of terms
-===================
-
-This section defines the terms used in this document and correlates them with
-what is currently used on QEMU.
-
-Automated tests
----------------
-
-An automated test is written on a test framework using its generic test
-functions/classes. The test framework can run the tests and report their
-success or failure [1]_.
-
-An automated test has essentially three parts:
-
-1. The test initialization of the parameters, where the expected parameters,
-   like inputs and expected results, are set up;
-2. The call to the code that should be tested;
-3. An assertion, comparing the result from the previous call with the expected
-   result set during the initialization of the parameters. If the result
-   matches the expected result, the test has been successful; otherwise, it has
-   failed.
-
-Unit testing
-------------
-
-A unit test is responsible for exercising individual software components as a
-unit, like interfaces, data structures, and functionality, uncovering errors
-within the boundaries of a component. The verification effort is in the
-smallest software unit and focuses on the internal processing logic and data
-structures. A test case of unit tests should be designed to uncover errors due
-to erroneous computations, incorrect comparisons, or improper control flow [2]_.
-
-On QEMU, unit testing is represented by the 'check-unit' target from 'make'.
-
-Functional testing
-------------------
-
-A functional test focuses on the functional requirement of the software.
-Deriving sets of input conditions, the functional tests should fully exercise
-all the functional requirements for a program. Functional testing is
-complementary to other testing techniques, attempting to find errors like
-incorrect or missing functions, interface errors, behavior errors, and
-initialization and termination errors [3]_.
-
-On QEMU, functional testing is represented by the 'check-qtest' target from
-'make'.
-
-System testing
---------------
-
-System tests ensure all application elements mesh properly while the overall
-functionality and performance are achieved [4]_. Some or all system components
-are integrated to create a complete system to be tested as a whole. System
-testing ensures that components are compatible, interact correctly, and
-transfer the right data at the right time across their interfaces. As system
-testing focuses on interactions, use case-based testing is a practical approach
-to system testing [5]_. Note that, in some cases, system testing may require
-interaction with third-party software, like operating system images, databases,
-networks, and so on.
-
-On QEMU, system testing is represented by the 'check-avocado' target from
-'make'.
-
-Flaky tests
------------
-
-A flaky test is defined as a test that exhibits both a passing and a failing
-result with the same code on different runs. Some usual reasons for an
-intermittent/flaky test are async wait, concurrency, and test order dependency
-[6]_.
-
-Gating
-------
-
-A gate restricts the move of code from one stage to another on a
-test/deployment pipeline. The step move is granted with approval. The approval
-can be a manual intervention or a set of tests succeeding [7]_.
-
-On QEMU, the gating process happens during the pull request. The approval is
-done by the project leader running its own set of tests. The pull request gets
-merged when the tests succeed.
-
-Continuous Integration (CI)
----------------------------
-
-Continuous integration (CI) requires the builds of the entire application and
-the execution of a comprehensive set of automated tests every time there is a
-need to commit any set of changes [8]_. The automated tests can be composed of
-the unit, functional, system, and other tests.
-
-Keynotes about continuous integration (CI) [9]_:
-
-1. System tests may depend on external software (operating system images,
-   firmware, database, network).
-2. It may take a long time to build and test. It may be impractical to build
-   the system being developed several times per day.
-3. If the development platform is different from the target platform, it may
-   not be possible to run system tests in the developer’s private workspace.
-   There may be differences in hardware, operating system, or installed
-   software. Therefore, more time is required for testing the system.
-
-References
-----------
-
-.. [1] Sommerville, Ian (2016). Software Engineering. p. 233.
-.. [2] Pressman, Roger S. & Maxim, Bruce R. (2020). Software Engineering,
-       A Practitioner’s Approach. p. 48, 376, 378, 381.
-.. [3] Pressman, Roger S. & Maxim, Bruce R. (2020). Software Engineering,
-       A Practitioner’s Approach. p. 388.
-.. [4] Pressman, Roger S. & Maxim, Bruce R. (2020). Software Engineering,
-       A Practitioner’s Approach. Software Engineering, p. 377.
-.. [5] Sommerville, Ian (2016). Software Engineering. p. 59, 232, 240.
-.. [6] Luo, Qingzhou, et al. An empirical analysis of flaky tests.
-       Proceedings of the 22nd ACM SIGSOFT International Symposium on
-       Foundations of Software Engineering. 2014.
-.. [7] Humble, Jez & Farley, David (2010). Continuous Delivery:
-       Reliable Software Releases Through Build, Test, and Deployment, p. 122.
-.. [8] Humble, Jez & Farley, David (2010). Continuous Delivery:
-       Reliable Software Releases Through Build, Test, and Deployment, p. 55.
-.. [9] Sommerville, Ian (2016). Software Engineering. p. 743.
diff --git a/docs/devel/testing/ci.rst b/docs/devel/testing/ci.rst
index ed88a2010be..e21d39db57a 100644
--- a/docs/devel/testing/ci.rst
+++ b/docs/devel/testing/ci.rst
@@ -1,14 +1,34 @@
 .. _ci:
 
-==
-CI
-==
+Continuous Integration (CI)
+===========================
+
+Continuous integration (CI) requires the builds of the entire application and
+the execution of a comprehensive set of automated tests every time there is a
+need to commit any set of changes [1]_. The automated tests are composed
+of unit, functional and other tests.
 
 Most of QEMU's CI is run on GitLab's infrastructure although a number
 of other CI services are used for specialised purposes. The most up to
 date information about them and their status can be found on the
 `project wiki testing page <https://wiki.qemu.org/Testing/CI>`_.
 
-.. include:: ci-definitions.rst.inc
+These tests are also used as gating tests before merging pull requests.
+A gating test restricts the move of code from one stage to another on a
+test/deployment pipeline. The step move is granted with approval. The approval
+can be a manual intervention or a set of tests succeeding [2]_.
+
+On QEMU, the gating process happens during the pull request. The approval is
+done by the project leader running its own set of tests. The pull request gets
+merged when the tests succeed.
+
 .. include:: ci-jobs.rst.inc
 .. include:: ci-runners.rst.inc
+
+References
+----------
+
+.. [1] Humble, Jez & Farley, David (2010). Continuous Delivery:
+       Reliable Software Releases Through Build, Test, and Deployment, p. 55.
+.. [2] Humble, Jez & Farley, David (2010). Continuous Delivery:
+       Reliable Software Releases Through Build, Test, and Deployment, p. 122.
diff --git a/docs/devel/testing/main.rst b/docs/devel/testing/main.rst
index 9869bcf0341..e56da22edf6 100644
--- a/docs/devel/testing/main.rst
+++ b/docs/devel/testing/main.rst
@@ -5,19 +5,32 @@ Testing in QEMU
 
 QEMU's testing infrastructure is fairly complex as it covers
 everything from unit testing and exercising specific sub-systems all
-the way to full blown acceptance tests. To get an overview of the
+the way to full blown functional tests. To get an overview of the
 tests you can run ``make check-help`` from either the source or build
 tree.
 
-Most (but not all) tests are also integrated into the meson build
-system so can be run directly from the build tree, for example:
-
-.. code::
+Most (but not all) tests are also integrated as an automated test into
+the meson build system so can be run directly from the build tree,
+for example::
 
   [./pyvenv/bin/]meson test --suite qemu:softfloat
 
 will run just the softfloat tests.
 
+An automated test is written with one of the test frameworks using its
+generic test functions/classes. The test framework can run the tests and
+report their success or failure [1]_.
+
+An automated test has essentially three parts:
+
+1. The test initialization of the parameters, where the expected parameters,
+   like inputs and expected results, are set up;
+2. The call to the code that should be tested;
+3. An assertion, comparing the result from the previous call with the expected
+   result set during the initialization of the parameters. If the result
+   matches the expected result, the test has been successful; otherwise, it has
+   failed.
+
 The rest of this document will cover the details for specific test
 groups.
 
@@ -44,9 +57,17 @@ cannot find them.
 Unit tests
 ~~~~~~~~~~
 
-Unit tests, which can be invoked with ``make check-unit``, are simple C tests
-that typically link to individual QEMU object files and exercise them by
-calling exported functions.
+A unit test is responsible for exercising individual software components as a
+unit, like interfaces, data structures, and functionality, uncovering errors
+within the boundaries of a component. The verification effort is in the
+smallest software unit and focuses on the internal processing logic and data
+structures. A test case of unit tests should be designed to uncover errors
+due to erroneous computations, incorrect comparisons, or improper control
+flow [2]_.
+
+In QEMU, unit tests can be invoked with ``make check-unit``. They are
+simple C tests that typically link to individual QEMU object files and
+exercise them by calling exported functions.
 
 If you are writing new code in QEMU, consider adding a unit test, especially
 for utility modules that are relatively stateless or have few dependencies. To
@@ -885,6 +906,10 @@ changing the ``-c`` option.
 Functional tests using Python
 -----------------------------
 
+A functional test focuses on the functional requirement of the software,
+attempting to find errors like incorrect functions, interface errors,
+behavior errors, and initialization and termination errors [3]_.
+
 The ``tests/functional`` directory hosts functional tests written in
 Python. You can run the functional tests simply by executing:
 
@@ -1023,3 +1048,27 @@ coverage-html`` which will create
 Further analysis can be conducted by running the ``gcov`` command
 directly on the various .gcda output files. Please read the ``gcov``
 documentation for more information.
+
+Flaky tests
+-----------
+
+A flaky test is defined as a test that exhibits both a passing and a failing
+result with the same code on different runs. Some usual reasons for an
+intermittent/flaky test are async wait, concurrency, and test order dependency
+[4]_.
+
+In QEMU, tests that are identified to be flaky are normally disabled by
+default. Set the QEMU_TEST_FLAKY_TESTS environment variable before running
+the tests to enable them.
+
+References
+----------
+
+.. [1] Sommerville, Ian (2016). Software Engineering. p. 233.
+.. [2] Pressman, Roger S. & Maxim, Bruce R. (2020). Software Engineering,
+       A Practitioner’s Approach. p. 48, 376, 378, 381.
+.. [3] Pressman, Roger S. & Maxim, Bruce R. (2020). Software Engineering,
+       A Practitioner’s Approach. p. 388.
+.. [4] Luo, Qingzhou, et al. An empirical analysis of flaky tests.
+       Proceedings of the 22nd ACM SIGSOFT International Symposium on
+       Foundations of Software Engineering. 2014.
-- 
2.48.1


