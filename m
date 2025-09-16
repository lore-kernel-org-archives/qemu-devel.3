Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 288EACAC598
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 16:56:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyYuK-0006nm-Nq; Tue, 16 Sep 2025 12:51:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1uyYuI-0006ck-I7
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 12:51:54 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1uyYuD-0006x9-2D
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 12:51:54 -0400
Received: from localhost.localdomain (unknown [167.220.208.43])
 by linux.microsoft.com (Postfix) with ESMTPSA id 4254820154ED;
 Tue, 16 Sep 2025 09:51:33 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4254820154ED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1758041497;
 bh=C7NCJc4y06Z06yg3ax79By+mM2/zrQZx9Z/eT5BQJEc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Bvur6OaREMkiH+1fkm8nFcor5Py5Je8PDac1modUqfKjXxmjv/xSwPkzrrCpt3Ze3
 speG4iC+MoHz41kEFp0dm2nS1/ydRHm56lToU6+nsZdUAz9IMeP9xrebmaTcwGCG6g
 gE1AI0i4M8zcX8UzdqwJ9kkJ5r+Uynp3m+MvTrCc=
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Wei Liu <liuwe@microsoft.com>, Cornelia Huck <cohuck@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 Magnus Kulke <magnuskulke@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Eric Blake <eblake@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v4 26/27] docs: Add mshv to documentation
Date: Tue, 16 Sep 2025 18:48:46 +0200
Message-Id: <20250916164847.77883-27-magnuskulke@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250916164847.77883-1-magnuskulke@linux.microsoft.com>
References: <20250916164847.77883-1-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Added mshv to the list of accelerators in doc text.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
---
 docs/about/build-platforms.rst |  2 +-
 docs/devel/codebase.rst        |  2 +-
 docs/glossary.rst              |  6 +++---
 docs/system/introduction.rst   |  3 +++
 qemu-options.hx                | 16 ++++++++--------
 5 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/docs/about/build-platforms.rst b/docs/about/build-platforms.rst
index 8671c3be9c..06ba0ddc9a 100644
--- a/docs/about/build-platforms.rst
+++ b/docs/about/build-platforms.rst
@@ -55,7 +55,7 @@ Those hosts are officially supported, with various accelerators:
    * - SPARC
      - tcg
    * - x86
-     - hvf (64 bit only), kvm, nvmm, tcg, whpx (64 bit only), xen
+     - hvf (64 bit only), mshv (64 bit only), kvm, nvmm, tcg, whpx (64 bit only), xen
 
 Other host architectures are not supported. It is possible to build QEMU system
 emulation on an unsupported host architecture using the configure
diff --git a/docs/devel/codebase.rst b/docs/devel/codebase.rst
index 2a3143787a..69d8827117 100644
--- a/docs/devel/codebase.rst
+++ b/docs/devel/codebase.rst
@@ -48,7 +48,7 @@ yet, so sometimes the source code is all you have.
 * `accel <https://gitlab.com/qemu-project/qemu/-/tree/master/accel>`_:
   Infrastructure and architecture agnostic code related to the various
   `accelerators <Accelerators>` supported by QEMU
-  (TCG, KVM, hvf, whpx, xen, nvmm).
+  (TCG, KVM, hvf, whpx, xen, nvmm, mshv).
   Contains interfaces for operations that will be implemented per
   `target <https://gitlab.com/qemu-project/qemu/-/tree/master/target>`_.
 * `audio <https://gitlab.com/qemu-project/qemu/-/tree/master/audio>`_:
diff --git a/docs/glossary.rst b/docs/glossary.rst
index 4fa044bfb6..0fa75c9d1e 100644
--- a/docs/glossary.rst
+++ b/docs/glossary.rst
@@ -12,7 +12,7 @@ Accelerator
 
 A specific API used to accelerate execution of guest instructions. It can be
 hardware-based, through a virtualization API provided by the host OS (kvm, hvf,
-whpx, ...), or software-based (tcg). See this description of `supported
+whpx, mshv, ...), or software-based (tcg). See this description of `supported
 accelerators<Accelerators>`.
 
 Board
@@ -102,8 +102,8 @@ hypervisors.
 
 In the context of QEMU, an hypervisor is an API, provided by the Host OS,
 allowing to execute virtual machines. Linux implementation is KVM (and supports
-Xen as well). For MacOS, it's HVF. Windows defines WHPX. And NetBSD provides
-NVMM.
+Xen and MSHV as well). For MacOS, it's HVF. Windows defines WHPX. And NetBSD
+provides NVMM.
 
 .. _machine:
 
diff --git a/docs/system/introduction.rst b/docs/system/introduction.rst
index 4cd46b5b8f..9c57523b6c 100644
--- a/docs/system/introduction.rst
+++ b/docs/system/introduction.rst
@@ -23,6 +23,9 @@ Tiny Code Generator (TCG) capable of emulating many CPUs.
   * - Xen
     - Linux (as dom0)
     - Arm, x86
+  * - MSHV
+    - Linux (as dom0)
+    - x86
   * - Hypervisor Framework (hvf)
     - MacOS
     - x86 (64 bit only), Arm (64 bit only)
diff --git a/qemu-options.hx b/qemu-options.hx
index ab23f14d21..ad747eb154 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -28,7 +28,7 @@ DEF("machine", HAS_ARG, QEMU_OPTION_machine, \
     "-machine [type=]name[,prop[=value][,...]]\n"
     "                selects emulated machine ('-machine help' for list)\n"
     "                property accel=accel1[:accel2[:...]] selects accelerator\n"
-    "                supported accelerators are kvm, xen, hvf, nvmm, whpx or tcg (default: tcg)\n"
+    "                supported accelerators are kvm, xen, hvf, nvmm, whpx, mshv or tcg (default: tcg)\n"
     "                vmport=on|off|auto controls emulation of vmport (default: auto)\n"
     "                dump-guest-core=on|off include guest memory in a core dump (default=on)\n"
     "                mem-merge=on|off controls memory merge support (default: on)\n"
@@ -66,10 +66,10 @@ SRST
 
     ``accel=accels1[:accels2[:...]]``
         This is used to enable an accelerator. Depending on the target
-        architecture, kvm, xen, hvf, nvmm, whpx or tcg can be available.
-        By default, tcg is used. If there is more than one accelerator
-        specified, the next one is used if the previous one fails to
-        initialize.
+        architecture, kvm, xen, hvf, nvmm, whpx, mshv or tcg can be
+        available. By default, tcg is used. If there is more than one
+        accelerator specified, the next one is used if the previous one
+        fails to initialize.
 
     ``vmport=on|off|auto``
         Enables emulation of VMWare IO port, for vmmouse etc. auto says
@@ -226,7 +226,7 @@ ERST
 
 DEF("accel", HAS_ARG, QEMU_OPTION_accel,
     "-accel [accel=]accelerator[,prop[=value][,...]]\n"
-    "                select accelerator (kvm, xen, hvf, nvmm, whpx or tcg; use 'help' for a list)\n"
+    "                select accelerator (kvm, xen, hvf, nvmm, whpx, mshv or tcg; use 'help' for a list)\n"
     "                igd-passthru=on|off (enable Xen integrated Intel graphics passthrough, default=off)\n"
     "                kernel-irqchip=on|off|split controls accelerated irqchip support (default=on)\n"
     "                kvm-shadow-mem=size of KVM shadow MMU in bytes\n"
@@ -241,8 +241,8 @@ DEF("accel", HAS_ARG, QEMU_OPTION_accel,
 SRST
 ``-accel name[,prop=value[,...]]``
     This is used to enable an accelerator. Depending on the target
-    architecture, kvm, xen, hvf, nvmm, whpx or tcg can be available. By
-    default, tcg is used. If there is more than one accelerator
+    architecture, kvm, xen, hvf, nvmm, whpx, mshv or tcg can be available.
+    By default, tcg is used. If there is more than one accelerator
     specified, the next one is used if the previous one fails to
     initialize.
 
-- 
2.34.1


