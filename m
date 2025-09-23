Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C2BFCAC5AC
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 14:37:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v148k-0003LD-5R; Tue, 23 Sep 2025 10:37:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenhuacai@kernel.org>)
 id 1v148j-0003Ki-Aw
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 10:37:09 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenhuacai@kernel.org>)
 id 1v148h-0002vH-GG
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 10:37:09 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 86C8F60286;
 Tue, 23 Sep 2025 14:37:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D30ABC113CF;
 Tue, 23 Sep 2025 14:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1758638225;
 bh=h/vocRLC3EsjFTFrRzRzyUm/9TY0VTtNrZpUtfxmFZQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=jSq8UULxWpHrMj4EfxJX9gw30lKNxwTjnTCmz0M2/EAlzIhLW1AFWB+u6Qk+T0lfg
 QzwmPYIRnklmcorvXotbb1HofRPusHYalpSGBwXZu2hlCYCEDxbRKYucLuIWttAM7F
 O482TG3xcDkoLXew1gzlmcF2+Q4E93y48dia9YQZXIuHU2uYl+nCFrp/1cBbLzSJft
 lpqNTnYMzbGmkPGpt62kAi+rM88WcGFRyGy+OfLfwQ7Ou9lt8dTIRixe7shYcNJAXc
 H3KYz/5lJBmzIzDMxVcxUlsioIUKO1OE5DeEjUnsaywobeYCy7+yj3LvukwDZ1wmsX
 nUrNH76j/zMJA==
From: Huacai Chen <chenhuacai@kernel.org>
To: Bibo Mao <maobibo@loongson.cn>,
	Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, WANG Xuerui <git@xen0n.name>,
 qemu-devel@nongnu.org, Huacai Chen <chenhuacai@kernel.org>
Subject: [PATCH 3/3] tests/data/acpi/loongarch64: Update expected DSDT.*
Date: Tue, 23 Sep 2025 22:35:42 +0800
Message-ID: <20250923143542.2391576-4-chenhuacai@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250923143542.2391576-1-chenhuacai@kernel.org>
References: <20250923143542.2391576-1-chenhuacai@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=chenhuacai@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
2.47.3


