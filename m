Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 005F6CCD184
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 13:01:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6qFz-0006gY-U3; Thu, 09 Oct 2025 09:00:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1v6qFp-0006bo-8K
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 09:00:21 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1v6qFe-0006ge-BH
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 09:00:20 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8CxHvDHsedop0kUAA--.43401S3;
 Thu, 09 Oct 2025 20:59:51 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowJCxG8HCsedoBqnWAA--.42888S5;
 Thu, 09 Oct 2025 20:59:51 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>, "Michael S . Tsirkin" <mst@redhat.com>
Subject: [PULL  3/6] tests/data/acpi/loongarch64: Update expected DSDT.*
Date: Thu,  9 Oct 2025 20:35:58 +0800
Message-Id: <20251009123601.2380901-4-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20251009123601.2380901-1-gaosong@loongson.cn>
References: <20251009123601.2380901-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCxG8HCsedoBqnWAA--.42888S5
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
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

From: Huacai Chen <chenhuacai@kernel.org>

DSDT diffs from "iasl -d":

@@ -11,7 +11,7 @@
  *     Signature        "DSDT"
  *     Length           0x000011FB (4603)
  *     Revision         0x01 **** 32-bit table (V1), no 64-bit math support
- *     Checksum         0x5D
+ *     Checksum         0x5B
  *     OEM ID           "BOCHS "
  *     OEM Table ID     "BXPC    "
  *     OEM Revision     0x00000001 (1)
@@ -1426,11 +1426,11 @@
             Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
             {
                 Memory32Fixed (ReadWrite,
-                    0x100E001F,         // Address Base
+                    0x100E0020,         // Address Base
                     0x0000000C,         // Address Length
                     )
             })
-            OperationRegion (PRST, SystemMemory, 0x100E001F, 0x0C)
+            OperationRegion (PRST, SystemMemory, 0x100E0020, 0x0C)
             Field (PRST, ByteAcc, NoLock, WriteAsZeros)
             {
                 Offset (0x04),

Signed-off-by: Huacai Chen <chenhuacai@kernel.org>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20250923143542.2391576-4-chenhuacai@kernel.org>
Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 tests/data/acpi/loongarch64/virt/DSDT         | Bin 4603 -> 4603 bytes
 tests/data/acpi/loongarch64/virt/DSDT.memhp   | Bin 5824 -> 5824 bytes
 tests/data/acpi/loongarch64/virt/DSDT.numamem | Bin 4609 -> 4609 bytes
 .../data/acpi/loongarch64/virt/DSDT.topology  | Bin 4905 -> 4905 bytes
 tests/qtest/bios-tables-test-allowed-diff.h   |   4 ----
 5 files changed, 4 deletions(-)

diff --git a/tests/data/acpi/loongarch64/virt/DSDT b/tests/data/acpi/loongarch64/virt/DSDT
index b31841aec6ed296f10ea1695a67ead38f45424d5..55aa34f988d6ef69293e91c5fe45bee0a02bc5f1 100644
GIT binary patch
delta 44
zcmeyZ{9BpJCD<k8w;%%pWAsL@BfP>2415AS3=9mF4ABh%LBSymJPMm1@=CD)02#3h
APXGV_

delta 44
zcmeyZ{9BpJCD<k8w;%%pW9&w*BfP@$415AS3=9mF4ABh%LBSymJo1|#@=CD)02$8<
APXGV_

diff --git a/tests/data/acpi/loongarch64/virt/DSDT.memhp b/tests/data/acpi/loongarch64/virt/DSDT.memhp
index e291200fc91caa3d93dcd6ec4736f7340f5e3f65..c0955eb60448cc5f4d38d410abc260ae54ea2e9a 100644
GIT binary patch
delta 44
zcmX@0dq9`VCD<k8fEWV<W5PzRW+7n(20j5E1_p*ohUkWXpx_V&9)-;dgcMi+`vnS0

delta 44
zcmX@0dq9`VCD<k8fEWV<W70;hW+7pD20j5E1_p*ohUkWXpx_V&9{J4+gcMi+`y&cU

diff --git a/tests/data/acpi/loongarch64/virt/DSDT.numamem b/tests/data/acpi/loongarch64/virt/DSDT.numamem
index 07923ac39584c5a5e73c9556d251814ce10de6cc..61e47e7252155dcf9c76879c4f60f4b3eef63f86 100644
GIT binary patch
delta 44
zcmZovX;k5I33dr#6k=dte72G62(PdL1D^m70|P@PLv%wxP;dwXkHY4Myb3G;-$V)Z

delta 44
zcmZovX;k5I33dr#6k=dte6f-12(Pd_1D^m70|P@PLv%wxP;dwXkNoC`yb3G;-(m^%

diff --git a/tests/data/acpi/loongarch64/virt/DSDT.topology b/tests/data/acpi/loongarch64/virt/DSDT.topology
index 6dfbb495f88b74b87849b58473e46717bc588a56..b2afebc938ce45d798c8aa5f45a463f1617e257e 100644
GIT binary patch
delta 44
zcmZ3fwo;ADCD<iIQ<#B)@!UqPBfP>2415AS3=9mF4ABh%LBSymJPMm1@_MiW0PuGT
Ag8%>k

delta 44
zcmZ3fwo;ADCD<iIQ<#B)@xn%~BfP@$415AS3=9mF4ABh%LBSymJo1|#@_MiW0PvLx
Ag8%>k

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index 2ed837faee..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,5 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/loongarch64/virt/DSDT",
-"tests/data/acpi/loongarch64/virt/DSDT.memhp",
-"tests/data/acpi/loongarch64/virt/DSDT.numamem",
-"tests/data/acpi/loongarch64/virt/DSDT.topology",
-- 
2.47.0


