Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B07A9C28B28
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 06:27:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsFYA-0008LV-Qq; Wed, 12 Mar 2025 02:26:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tsFY4-0008Ku-5Y
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 02:26:36 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tsFXz-0006JX-Ij
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 02:26:35 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8BxXWsNKdFnef2SAA--.53939S3;
 Wed, 12 Mar 2025 14:26:21 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMBxb8cNKdFnCV1FAA--.61289S2;
 Wed, 12 Mar 2025 14:26:21 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH] docs/system: Add entry for LoongArch system
Date: Wed, 12 Mar 2025 14:26:20 +0800
Message-Id: <20250312062620.3360498-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBxb8cNKdFnCV1FAA--.61289S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

Add index entry for LoongArch system and do some small modification
with  LoongArch document with rst syntax.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 docs/system/loongarch/virt.rst   | 31 ++++++++++---------------------
 docs/system/target-loongarch.rst | 19 +++++++++++++++++++
 docs/system/targets.rst          |  1 +
 3 files changed, 30 insertions(+), 21 deletions(-)
 create mode 100644 docs/system/target-loongarch.rst

diff --git a/docs/system/loongarch/virt.rst b/docs/system/loongarch/virt.rst
index 172fba079e..7845878469 100644
--- a/docs/system/loongarch/virt.rst
+++ b/docs/system/loongarch/virt.rst
@@ -12,14 +12,15 @@ Supported devices
 -----------------
 
 The ``virt`` machine supports:
-- Gpex host bridge
-- Ls7a RTC device
-- Ls7a IOAPIC device
-- ACPI GED device
-- Fw_cfg device
-- PCI/PCIe devices
-- Memory device
-- CPU device. Type: la464.
+
+* Gpex host bridge
+* Ls7a RTC device
+* Ls7a IOAPIC device
+* ACPI GED device
+* Fw_cfg device
+* PCI/PCIe devices
+* Memory device
+* CPU device. Type: la464.
 
 CPU and machine Type
 --------------------
@@ -39,13 +40,7 @@ can be accessed by following steps.
 
 .. code-block:: bash
 
-  ./configure --disable-rdma --prefix=/usr \
-              --target-list="loongarch64-softmmu" \
-              --disable-libiscsi --disable-libnfs --disable-libpmem \
-              --disable-glusterfs --enable-libusb --enable-usb-redir \
-              --disable-opengl --disable-xen --enable-spice \
-              --enable-debug --disable-capstone --disable-kvm \
-              --enable-profiler
+  ./configure --target-list="loongarch64-softmmu"
   make -j8
 
 (2) Set cross tools:
@@ -53,9 +48,7 @@ can be accessed by following steps.
 .. code-block:: bash
 
   wget https://github.com/loongson/build-tools/releases/download/2022.09.06/loongarch64-clfs-6.3-cross-tools-gcc-glibc.tar.xz
-
   tar -vxf loongarch64-clfs-6.3-cross-tools-gcc-glibc.tar.xz  -C /opt
-
   export PATH=/opt/cross-tools/bin:$PATH
   export LD_LIBRARY_PATH=/opt/cross-tools/lib:$LD_LIBRARY_PATH
   export LD_LIBRARY_PATH=/opt/cross-tools/loongarch64-unknown-linux-gnu/lib/:$LD_LIBRARY_PATH
@@ -74,13 +67,9 @@ Note: To build the release version of the bios,  set --buildtarget=RELEASE,
 .. code-block:: bash
 
   git clone https://github.com/loongson/linux.git
-
   cd linux
-
   git checkout loongarch-next
-
   make ARCH=loongarch CROSS_COMPILE=loongarch64-unknown-linux-gnu- loongson3_defconfig
-
   make ARCH=loongarch CROSS_COMPILE=loongarch64-unknown-linux-gnu- -j32
 
 Note: The branch of linux source code is loongarch-next.
diff --git a/docs/system/target-loongarch.rst b/docs/system/target-loongarch.rst
new file mode 100644
index 0000000000..316c604b91
--- /dev/null
+++ b/docs/system/target-loongarch.rst
@@ -0,0 +1,19 @@
+.. _LoongArch-System-emulator:
+
+LoongArch System emulator
+-------------------------
+
+QEMU can emulate loongArch 64 bit systems via the
+``qemu-system-loongarch64`` binary. Only one machine type ``virt`` is
+supported.
+
+When using KVM as accelerator, QEMU can emulate la464 cpu model. And when
+using the default cpu model with TCG as accelerator, QEMU will emulate a
+subset of la464 cpu features that should be enough to run distributions
+built for the la464.
+
+Board-specific documentation
+============================
+
+.. toctree::
+   loongarch/virt
diff --git a/docs/system/targets.rst b/docs/system/targets.rst
index 224fadae71..38e2418801 100644
--- a/docs/system/targets.rst
+++ b/docs/system/targets.rst
@@ -18,6 +18,7 @@ Contents:
 
    target-arm
    target-avr
+   target-loongarch
    target-m68k
    target-mips
    target-ppc

base-commit: 825b96dbcee23d134b691fc75618b59c5f53da32
-- 
2.39.3


