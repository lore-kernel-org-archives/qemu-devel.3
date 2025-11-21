Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56F6ACFC50C
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 04:36:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMeJ4-0004F8-Ig; Fri, 21 Nov 2025 22:29:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMeJ1-0004Dr-4m; Fri, 21 Nov 2025 22:28:59 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMeIR-0002dn-17; Fri, 21 Nov 2025 22:28:55 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 7B69A16C702;
 Fri, 21 Nov 2025 16:51:57 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id D2A4F32199F;
 Fri, 21 Nov 2025 16:52:05 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Shameer Kolothum <skolothumtho@nvidia.com>,
 Eric Auger <eric.auger@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.1.3 42/76] tests/qtest/bios-tables-test: Update DSDT blobs
 after GPEX _DSM change
Date: Fri, 21 Nov 2025 16:51:20 +0300
Message-ID: <20251121135201.1114964-42-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.1.3-20251121155857@cover.tls.msk.ru>
References: <qemu-stable-10.1.3-20251121155857@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Shameer Kolothum <skolothumtho@nvidia.com>

Update the reference DSDT blobs after GPEX _DSM change. This affects the
aarch64 'virt', riscv64 "virt", loongarch64 "virt" and the x86 'microvm'
machines.

DSDT diff is the same for all the machines/tests:

 /*
  * Intel ACPI Component Architecture
  * AML/ASL+ Disassembler version 20230628 (64-bit version)
  * Copyright (c) 2000 - 2023 Intel Corporation
  *
  * Disassembling to symbolic ASL+ operators
  *
- * Disassembly of tests/data/acpi/aarch64/virt/DSDT, Fri Oct 10 11:18:21 2025
+ * Disassembly of /tmp/aml-E6V9D3, Fri Oct 10 11:18:21 2025
  *
  * Original Table Header:
  *     Signature        "DSDT"
  *     Length           0x000014D9 (5337)
  *     Revision         0x02
- *     Checksum         0xA4
+ *     Checksum         0xA5
  *     OEM ID           "BOCHS "
  *     OEM Table ID     "BXPC    "
  *     OEM Revision     0x00000001 (1)
  *     Compiler ID      "BXPC"
  *     Compiler Version 0x00000001 (1)
  */
 DefinitionBlock ("", "DSDT", 2, "BOCHS ", "BXPC    ", 0x00000001)
 {
     Scope (\_SB)
     {
         Device (C000)
         {
             Name (_HID, "ACPI0007" /* Processor Device */)  // _HID: Hardware ID
             Name (_UID, Zero)  // _UID: Unique ID
         }

@@ -1822,33 +1822,33 @@
                 Else
                 {
                     CDW1 |= 0x04
                 }

                 Return (Arg3)
             }

             Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
             {
                 If ((Arg0 == ToUUID ("e5c937d0-3553-4d7a-9117-ea4d19c3434d") /* Device Labeling Interface */))
                 {
                     If ((Arg2 == Zero))
                     {
                         Return (Buffer (One)
                         {
-                             0x01                                             // .
+                             0x00                                             // .
                         })
                     }
                 }

                 Return (Buffer (One)
                 {
                      0x00                                             // .
                 })
             }

             Device (RES0)
             {
                 Name (_HID, "PNP0C02" /* PNP Motherboard Resources */)  // _HID: Hardware ID
                 Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                 {
                     QWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,

Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20251022080639.243965-4-skolothumtho@nvidia.com>
(cherry picked from commit ccf166d89dcf57c9d333f05173851f90e416097a)
(Mjt: regenerate all actual tables)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tests/data/acpi/aarch64/virt/DSDT b/tests/data/acpi/aarch64/virt/DSDT
index 18d97e8f22..47d4b9d2ba 100644
Binary files a/tests/data/acpi/aarch64/virt/DSDT and b/tests/data/acpi/aarch64/virt/DSDT differ
diff --git a/tests/data/acpi/aarch64/virt/DSDT.acpihmatvirt b/tests/data/acpi/aarch64/virt/DSDT.acpihmatvirt
index 2cef095bcc..044a075401 100644
Binary files a/tests/data/acpi/aarch64/virt/DSDT.acpihmatvirt and b/tests/data/acpi/aarch64/virt/DSDT.acpihmatvirt differ
diff --git a/tests/data/acpi/aarch64/virt/DSDT.acpipcihp b/tests/data/acpi/aarch64/virt/DSDT.acpipcihp
index 8d55a877a4..87e05d2a28 100644
Binary files a/tests/data/acpi/aarch64/virt/DSDT.acpipcihp and b/tests/data/acpi/aarch64/virt/DSDT.acpipcihp differ
diff --git a/tests/data/acpi/aarch64/virt/DSDT.hpoffacpiindex b/tests/data/acpi/aarch64/virt/DSDT.hpoffacpiindex
index 970d43f68b..fcae6ca910 100644
Binary files a/tests/data/acpi/aarch64/virt/DSDT.hpoffacpiindex and b/tests/data/acpi/aarch64/virt/DSDT.hpoffacpiindex differ
diff --git a/tests/data/acpi/aarch64/virt/DSDT.memhp b/tests/data/acpi/aarch64/virt/DSDT.memhp
index 372ca3d7fb..2f5039aff0 100644
Binary files a/tests/data/acpi/aarch64/virt/DSDT.memhp and b/tests/data/acpi/aarch64/virt/DSDT.memhp differ
diff --git a/tests/data/acpi/aarch64/virt/DSDT.pxb b/tests/data/acpi/aarch64/virt/DSDT.pxb
index c277988249..8a2d8a878f 100644
Binary files a/tests/data/acpi/aarch64/virt/DSDT.pxb and b/tests/data/acpi/aarch64/virt/DSDT.pxb differ
diff --git a/tests/data/acpi/aarch64/virt/DSDT.topology b/tests/data/acpi/aarch64/virt/DSDT.topology
index ebbeedc1ed..3400ea67c4 100644
Binary files a/tests/data/acpi/aarch64/virt/DSDT.topology and b/tests/data/acpi/aarch64/virt/DSDT.topology differ
diff --git a/tests/data/acpi/aarch64/virt/DSDT.viot b/tests/data/acpi/aarch64/virt/DSDT.viot
index b897d66797..7a50bed9cc 100644
Binary files a/tests/data/acpi/aarch64/virt/DSDT.viot and b/tests/data/acpi/aarch64/virt/DSDT.viot differ
diff --git a/tests/data/acpi/loongarch64/virt/DSDT b/tests/data/acpi/loongarch64/virt/DSDT
index b31841aec6..2fdb2a750f 100644
Binary files a/tests/data/acpi/loongarch64/virt/DSDT and b/tests/data/acpi/loongarch64/virt/DSDT differ
diff --git a/tests/data/acpi/loongarch64/virt/DSDT.memhp b/tests/data/acpi/loongarch64/virt/DSDT.memhp
index e291200fc9..fbd1b9242d 100644
Binary files a/tests/data/acpi/loongarch64/virt/DSDT.memhp and b/tests/data/acpi/loongarch64/virt/DSDT.memhp differ
diff --git a/tests/data/acpi/loongarch64/virt/DSDT.numamem b/tests/data/acpi/loongarch64/virt/DSDT.numamem
index 07923ac395..6509d71044 100644
Binary files a/tests/data/acpi/loongarch64/virt/DSDT.numamem and b/tests/data/acpi/loongarch64/virt/DSDT.numamem differ
diff --git a/tests/data/acpi/loongarch64/virt/DSDT.topology b/tests/data/acpi/loongarch64/virt/DSDT.topology
index 6dfbb495f8..6a97c076a5 100644
Binary files a/tests/data/acpi/loongarch64/virt/DSDT.topology and b/tests/data/acpi/loongarch64/virt/DSDT.topology differ
diff --git a/tests/data/acpi/riscv64/virt/DSDT b/tests/data/acpi/riscv64/virt/DSDT
index 527f239dab..968e1a15c8 100644
Binary files a/tests/data/acpi/riscv64/virt/DSDT and b/tests/data/acpi/riscv64/virt/DSDT differ
diff --git a/tests/data/acpi/x86/microvm/DSDT.pcie b/tests/data/acpi/x86/microvm/DSDT.pcie
index ba258f454d..b646a05551 100644
Binary files a/tests/data/acpi/x86/microvm/DSDT.pcie and b/tests/data/acpi/x86/microvm/DSDT.pcie differ
diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index e2fce2e972..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,17 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/aarch64/virt/DSDT",
-"tests/data/acpi/aarch64/virt/DSDT.acpihmatvirt",
-"tests/data/acpi/aarch64/virt/DSDT.memhp",
-"tests/data/acpi/aarch64/virt/DSDT.pxb",
-"tests/data/acpi/aarch64/virt/DSDT.topology",
-"tests/data/acpi/aarch64/virt/DSDT.acpipcihp",
-"tests/data/acpi/aarch64/virt/DSDT.hpoffacpiindex",
-"tests/data/acpi/aarch64/virt/DSDT.viot",
-"tests/data/acpi/aarch64/virt/DSDT.smmuv3-legacy",
-"tests/data/acpi/aarch64/virt/DSDT.smmuv3-dev",
-"tests/data/acpi/riscv64/virt/DSDT",
-"tests/data/acpi/loongarch64/virt/DSDT",
-"tests/data/acpi/loongarch64/virt/DSDT.topology",
-"tests/data/acpi/loongarch64/virt/DSDT.numamem",
-"tests/data/acpi/loongarch64/virt/DSDT.memhp",
-"tests/data/acpi/x86/microvm/DSDT.pcie",
-- 
2.47.3


