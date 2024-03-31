Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12D80CD128A
	for <qemu-devel@archiver.kernel.org>; Sun, 31 Mar 2024 16:16:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rqxqx-0003el-Ov; Sun, 31 Mar 2024 12:16:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefan@weilnetz.de>)
 id 1rqxqu-0003eE-Ok; Sun, 31 Mar 2024 12:16:13 -0400
Received: from mail.weilnetz.de ([37.120.169.71]
 helo=mail.v2201612906741603.powersrv.de)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefan@weilnetz.de>)
 id 1rqxqr-0001la-PF; Sun, 31 Mar 2024 12:16:12 -0400
Received: from qemu.weilnetz.de (qemu.weilnetz.de [188.68.58.204])
 by mail.v2201612906741603.powersrv.de (Postfix) with ESMTP id 76012DA06D4;
 Sun, 31 Mar 2024 18:16:03 +0200 (CEST)
Received: by qemu.weilnetz.de (Postfix, from userid 1000)
 id F073D460023; Sun, 31 Mar 2024 18:16:02 +0200 (CEST)
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Luc Michel <luc@lmichel.fr>,
 Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, qemu-devel@nongnu.org, qemu-trivial@nongnu.org,
 Stefan Weil <sw@weilnetz.de>
Subject: [PATCH for-9.0] Fix some typos in documentation (found by codespell)
Date: Sun, 31 Mar 2024 18:15:26 +0200
Message-Id: <20240331161526.1746598-1-sw@weilnetz.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=37.120.169.71; envelope-from=stefan@weilnetz.de;
 helo=mail.v2201612906741603.powersrv.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Stefan Weil <sw@weilnetz.de>
From:  Stefan Weil via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Stefan Weil <sw@weilnetz.de>
---
 docs/devel/atomics.rst     | 2 +-
 docs/devel/ci-jobs.rst.inc | 2 +-
 docs/devel/clocks.rst      | 2 +-
 docs/system/i386/sgx.rst   | 2 +-
 qapi/qom.json              | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/docs/devel/atomics.rst b/docs/devel/atomics.rst
index ff9b5ee30c..b77c6e13e1 100644
--- a/docs/devel/atomics.rst
+++ b/docs/devel/atomics.rst
@@ -119,7 +119,7 @@ The only guarantees that you can rely upon in this case are:
   ordinary accesses instead cause data races if they are concurrent with
   other accesses of which at least one is a write.  In order to ensure this,
   the compiler will not optimize accesses out of existence, create unsolicited
-  accesses, or perform other similar optimzations.
+  accesses, or perform other similar optimizations.
 
 - acquire operations will appear to happen, with respect to the other
   components of the system, before all the LOAD or STORE operations
diff --git a/docs/devel/ci-jobs.rst.inc b/docs/devel/ci-jobs.rst.inc
index ec33e6ee2b..be06322279 100644
--- a/docs/devel/ci-jobs.rst.inc
+++ b/docs/devel/ci-jobs.rst.inc
@@ -115,7 +115,7 @@ CI pipeline.
 QEMU_JOB_SKIPPED
 ~~~~~~~~~~~~~~~~
 
-The job is not reliably successsful in general, so is not
+The job is not reliably successful in general, so is not
 currently suitable to be run by default. Ideally this should
 be a temporary marker until the problems can be addressed, or
 the job permanently removed.
diff --git a/docs/devel/clocks.rst b/docs/devel/clocks.rst
index b2d1148cdb..177ee1c90d 100644
--- a/docs/devel/clocks.rst
+++ b/docs/devel/clocks.rst
@@ -279,7 +279,7 @@ You can change the multiplier and divider of a clock at runtime,
 so you can use this to model clock controller devices which
 have guest-programmable frequency multipliers or dividers.
 
-Similary to ``clock_set()``, ``clock_set_mul_div()`` returns ``true`` if
+Similarly to ``clock_set()``, ``clock_set_mul_div()`` returns ``true`` if
 the clock state was modified; that is, if the multiplier or the diviser
 or both were changed by the call.
 
diff --git a/docs/system/i386/sgx.rst b/docs/system/i386/sgx.rst
index 0f0a73f758..c293f7f44e 100644
--- a/docs/system/i386/sgx.rst
+++ b/docs/system/i386/sgx.rst
@@ -6,7 +6,7 @@ Overview
 
 Intel Software Guard eXtensions (SGX) is a set of instructions and mechanisms
 for memory accesses in order to provide security accesses for sensitive
-applications and data. SGX allows an application to use it's pariticular
+applications and data. SGX allows an application to use its particular
 address space as an *enclave*, which is a protected area provides confidentiality
 and integrity even in the presence of privileged malware. Accesses to the
 enclave memory area from any software not resident in the enclave are prevented,
diff --git a/qapi/qom.json b/qapi/qom.json
index 8d4ca8ed92..85e6b4f84a 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -802,7 +802,7 @@
 #
 # @fd: file descriptor name previously passed via 'getfd' command,
 #     which represents a pre-opened /dev/iommu.  This allows the
-#     iommufd object to be shared accross several subsystems (VFIO,
+#     iommufd object to be shared across several subsystems (VFIO,
 #     VDPA, ...), and the file descriptor to be shared with other
 #     process, e.g. DPDK.  (default: QEMU opens /dev/iommu by itself)
 #
-- 
2.39.2


