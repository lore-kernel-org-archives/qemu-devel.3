Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BC3BCCF9EE
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 10:21:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDKKE-00071Q-IZ; Mon, 27 Oct 2025 06:19:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vDKK9-0006xS-K1; Mon, 27 Oct 2025 06:19:37 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vDKK2-000584-2S; Mon, 27 Oct 2025 06:19:37 -0400
Received: from h205.csg.ci.i.u-tokyo.ac.jp (h205.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.205]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 59RAJBfU020236
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 27 Oct 2025 19:19:20 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=IcBO2Yt+DqB8nrWS7Sd5TeHKho63rTwoIDY92VLgr3I=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Date:Subject:Message-Id:To;
 s=rs20250326; t=1761560360; v=1;
 b=f/kcdtKrWAKj4+oCf3ymSXzLqtqt+s3b6Zh+4IbykEupbGNXcX3XjeyeWKKAbPDL
 t054akkwAbiQQuz2WedxefvDEoCZioJe70/Dy/b9RGcYEXxOHflfdXA3UJFiHmqz
 vZvBzEVQ7QPKNeMJ7fzBuwfByFNiIRxHmquEjoFMd9kQfWCfQwcQWfZbDzzKiYTT
 Ynbmnb6zYu5fjK9HlX78jStPMqCBumPvhP6FncwtczJs6yWWU+GfRLHds4W0VImn
 s39gpZ0DaeVwKeH+krJX8VU4hSoG84Cjkt5hqGPWWm9dWWs9iVSAwulTCftvE5b8
 B3dD0euxiOfHwPOn2sUsUA==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Mon, 27 Oct 2025 19:19:08 +0900
Subject: [PATCH v3 3/3] test/acpi: aarch64/virt: Update golden masters for
 DSDT and MCFG
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251027-virt-v3-3-fa2a2f37e32d@rsg.ci.i.u-tokyo.ac.jp>
References: <20251027-virt-v3-0-fa2a2f37e32d@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20251027-virt-v3-0-fa2a2f37e32d@rsg.ci.i.u-tokyo.ac.jp>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Eric Auger <eric.auger@redhat.com>, Andrew Jones <ajones@ventanamicro.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.15-dev-179e8
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Without this change, the following warnings were emitted:

acpi-test: Warning! MCFG binary file mismatch. Actual [aml:/tmp/aml-4S2NE3], Expected [aml:tests/data/acpi/aarch64/virt/MCFG].
See source file tests/qtest/bios-tables-test.c for instructions on how to update expected files.
acpi-test: Warning! MCFG mismatch. Actual [asl:/tmp/asl-DU2NE3.dsl, aml:/tmp/aml-4S2NE3], Expected [asl:/tmp/asl-46HNE3.dsl, aml:tests/data/acpi/aarch64/virt/MCFG].
--- /tmp/asl-46HNE3.dsl 2025-10-27 19:10:55.775319406 +0900
+++ /tmp/asl-DU2NE3.dsl 2025-10-27 19:10:55.771030289 +0900
@@ -1,36 +1,36 @@
 /*
  * Intel ACPI Component Architecture
  * AML/ASL+ Disassembler version 20240322 (64-bit version)
  * Copyright (c) 2000 - 2023 Intel Corporation
  *
- * Disassembly of tests/data/acpi/aarch64/virt/MCFG
+ * Disassembly of /tmp/aml-4S2NE3
  *
  * ACPI Data Table [MCFG]
  *
  * Format: [HexOffset DecimalOffset ByteLength]  FieldName : FieldValue (in hex)
  */

 [000h 0000 004h]                   Signature : "MCFG"    [Memory Mapped Configuration Table]
 [004h 0004 004h]                Table Length : 0000003C
 [008h 0008 001h]                    Revision : 01
-[009h 0009 001h]                    Checksum : EC
+[009h 0009 001h]                    Checksum : AC
 [00Ah 0010 006h]                      Oem ID : "BOCHS "
 [010h 0016 008h]                Oem Table ID : "BXPC    "
 [018h 0024 004h]                Oem Revision : 00000001
 [01Ch 0028 004h]             Asl Compiler ID : "BXPC"
 [020h 0032 004h]       Asl Compiler Revision : 00000001

 [024h 0036 008h]                    Reserved : 0000000000000000

-[02Ch 0044 008h]                Base Address : 0000004010000000
+[02Ch 0044 008h]                Base Address : 0000000090000000
 [034h 0052 002h]        Segment Group Number : 0000
 [036h 0054 001h]            Start Bus Number : 00
 [037h 0055 001h]              End Bus Number : FF
 [038h 0056 004h]                    Reserved : 00000000

 Raw Table Data: Length 60 (0x3C)

-    0000: 4D 43 46 47 3C 00 00 00 01 EC 42 4F 43 48 53 20  // MCFG<.....BOCHS
+    0000: 4D 43 46 47 3C 00 00 00 01 AC 42 4F 43 48 53 20  // MCFG<.....BOCHS
     0010: 42 58 50 43 20 20 20 20 01 00 00 00 42 58 50 43  // BXPC    ....BXPC
-    0020: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 10  // ................
-    0030: 40 00 00 00 00 00 00 FF 00 00 00 00              // @...........
+    0020: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 90  // ................
+    0030: 00 00 00 00 00 00 00 FF 00 00 00 00              // ............
acpi-test: Warning! DSDT binary file mismatch. Actual [aml:/tmp/aml-TS2NE3], Expected [aml:tests/data/acpi/aarch64/virt/DSDT].
See source file tests/qtest/bios-tables-test.c for instructions on how to update expected files.
acpi-test: Warning! DSDT mismatch. Actual [asl:/tmp/asl-R7MNE3.dsl, aml:/tmp/aml-TS2NE3], Expected [asl:/tmp/asl-LESNE3.dsl, aml:tests/data/acpi/aarch64/virt/DSDT].
--- /tmp/asl-LESNE3.dsl 2025-10-27 19:10:55.788319510 +0900
+++ /tmp/asl-R7MNE3.dsl 2025-10-27 19:10:55.781319454 +0900
@@ -1,30 +1,30 @@
 /*
  * Intel ACPI Component Architecture
  * AML/ASL+ Disassembler version 20240322 (64-bit version)
  * Copyright (c) 2000 - 2023 Intel Corporation
  *
  * Disassembling to symbolic ASL+ operators
  *
- * Disassembly of tests/data/acpi/aarch64/virt/DSDT
+ * Disassembly of /tmp/aml-TS2NE3
  *
  * Original Table Header:
  *     Signature        "DSDT"
- *     Length           0x000014D9 (5337)
+ *     Length           0x000014D5 (5333)
  *     Revision         0x02
- *     Checksum         0xA4
+ *     Checksum         0xF6
  *     OEM ID           "BOCHS "
  *     OEM Table ID     "BXPC    "
  *     OEM Revision     0x00000001 (1)
  *     Compiler ID      "BXPC"
  *     Compiler Version 0x00000001 (1)
  */
 DefinitionBlock ("", "DSDT", 2, "BOCHS ", "BXPC    ", 0x00000001)
 {
     Scope (\_SB)
     {
         Device (C000)
         {
             Name (_HID, "ACPI0007" /* Processor Device */)  // _HID: Hardware ID
             Name (_UID, Zero)  // _UID: Unique ID
         }

@@ -1751,33 +1751,33 @@
                     0x001FFFFF,
                     0x02,
                     L001,
                     Zero
                 },

                 Package (0x04)
                 {
                     0x001FFFFF,
                     0x03,
                     L002,
                     Zero
                 }
             })
             Method (_CBA, 0, NotSerialized)  // _CBA: Configuration Base Address
             {
-                Return (0x0000004010000000)
+                Return (0x90000000)
             }

             Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
             {
                 WordBusNumber (ResourceProducer, MinFixed, MaxFixed, PosDecode,
                     0x0000,             // Granularity
                     0x0000,             // Range Minimum
                     0x00FF,             // Range Maximum
                     0x0000,             // Translation Offset
                     0x0100,             // Length
                     ,, )
                 DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                     0x00000000,         // Granularity
                     0x10000000,         // Range Minimum
                     0x3EFEFFFF,         // Range Maximum
                     0x00000000,         // Translation Offset
@@ -1840,34 +1840,34 @@
                     }
                 }

                 Return (Buffer (One)
                 {
                      0x00                                             // .
                 })
             }

             Device (RES0)
             {
                 Name (_HID, "PNP0C02" /* PNP Motherboard Resources */)  // _HID: Hardware ID
                 Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                 {
                     QWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                         0x0000000000000000, // Granularity
-                        0x0000004010000000, // Range Minimum
-                        0x000000401FFFFFFF, // Range Maximum
+                        0x0000000090000000, // Range Minimum
+                        0x000000009FFFFFFF, // Range Maximum
                         0x0000000000000000, // Translation Offset
                         0x0000000010000000, // Length
                         ,, , AddressRangeMemory, TypeStatic)
                 })
             }
         }

         Device (\_SB.GED)
         {
             Name (_HID, "ACPI0013" /* Generic Event Device */)  // _HID: Hardware ID
             Name (_UID, "GED")  // _UID: Unique ID
             Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
             {
                 Interrupt (ResourceConsumer, Edge, ActiveHigh, Exclusive, ,, )
                 {
                     0x00000029,
acpi-test: Warning! MCFG binary file mismatch. Actual [aml:/tmp/aml-DJVQE3], Expected [aml:tests/data/acpi/aarch64/virt/MCFG].
See source file tests/qtest/bios-tables-test.c for instructions on how to update expected files.
acpi-test: Warning! MCFG mismatch. Actual [asl:/tmp/asl-EAUQE3.dsl, aml:/tmp/aml-DJVQE3], Expected [asl:/tmp/asl-2OBQE3.dsl, aml:tests/data/acpi/aarch64/virt/MCFG].
--- /tmp/asl-2OBQE3.dsl 2025-10-27 19:11:08.644093437 +0900
+++ /tmp/asl-EAUQE3.dsl 2025-10-27 19:11:08.640430242 +0900
@@ -1,36 +1,36 @@
 /*
  * Intel ACPI Component Architecture
  * AML/ASL+ Disassembler version 20240322 (64-bit version)
  * Copyright (c) 2000 - 2023 Intel Corporation
  *
- * Disassembly of tests/data/acpi/aarch64/virt/MCFG
+ * Disassembly of /tmp/aml-DJVQE3
  *
  * ACPI Data Table [MCFG]
  *
  * Format: [HexOffset DecimalOffset ByteLength]  FieldName : FieldValue (in hex)
  */

 [000h 0000 004h]                   Signature : "MCFG"    [Memory Mapped Configuration Table]
 [004h 0004 004h]                Table Length : 0000003C
 [008h 0008 001h]                    Revision : 01
-[009h 0009 001h]                    Checksum : EC
+[009h 0009 001h]                    Checksum : AC
 [00Ah 0010 006h]                      Oem ID : "BOCHS "
 [010h 0016 008h]                Oem Table ID : "BXPC    "
 [018h 0024 004h]                Oem Revision : 00000001
 [01Ch 0028 004h]             Asl Compiler ID : "BXPC"
 [020h 0032 004h]       Asl Compiler Revision : 00000001

 [024h 0036 008h]                    Reserved : 0000000000000000

-[02Ch 0044 008h]                Base Address : 0000004010000000
+[02Ch 0044 008h]                Base Address : 0000000090000000
 [034h 0052 002h]        Segment Group Number : 0000
 [036h 0054 001h]            Start Bus Number : 00
 [037h 0055 001h]              End Bus Number : FF
 [038h 0056 004h]                    Reserved : 00000000

 Raw Table Data: Length 60 (0x3C)

-    0000: 4D 43 46 47 3C 00 00 00 01 EC 42 4F 43 48 53 20  // MCFG<.....BOCHS
+    0000: 4D 43 46 47 3C 00 00 00 01 AC 42 4F 43 48 53 20  // MCFG<.....BOCHS
     0010: 42 58 50 43 20 20 20 20 01 00 00 00 42 58 50 43  // BXPC    ....BXPC
-    0020: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 10  // ................
-    0030: 40 00 00 00 00 00 00 FF 00 00 00 00              // @...........
+    0020: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 90  // ................
+    0030: 00 00 00 00 00 00 00 FF 00 00 00 00              // ............
acpi-test: Warning! DSDT binary file mismatch. Actual [aml:/tmp/aml-4CVQE3], Expected [aml:tests/data/acpi/aarch64/virt/DSDT.acpihmatvirt].
See source file tests/qtest/bios-tables-test.c for instructions on how to update expected files.
acpi-test: Warning! DSDT mismatch. Actual [asl:/tmp/asl-COEQE3.dsl, aml:/tmp/aml-4CVQE3], Expected [asl:/tmp/asl-WUJQE3.dsl, aml:tests/data/acpi/aarch64/virt/DSDT.acpihmatvirt].
--- /tmp/asl-WUJQE3.dsl 2025-10-27 19:11:08.656421660 +0900
+++ /tmp/asl-COEQE3.dsl 2025-10-27 19:11:08.648421597 +0900
@@ -1,30 +1,30 @@
 /*
  * Intel ACPI Component Architecture
  * AML/ASL+ Disassembler version 20240322 (64-bit version)
  * Copyright (c) 2000 - 2023 Intel Corporation
  *
  * Disassembling to symbolic ASL+ operators
  *
- * Disassembly of tests/data/acpi/aarch64/virt/DSDT.acpihmatvirt
+ * Disassembly of /tmp/aml-4CVQE3
  *
  * Original Table Header:
  *     Signature        "DSDT"
- *     Length           0x0000152F (5423)
+ *     Length           0x0000152B (5419)
  *     Revision         0x02
- *     Checksum         0x6F
+ *     Checksum         0xB2
  *     OEM ID           "BOCHS "
  *     OEM Table ID     "BXPC    "
  *     OEM Revision     0x00000001 (1)
  *     Compiler ID      "BXPC"
  *     Compiler Version 0x00000001 (1)
  */
 DefinitionBlock ("", "DSDT", 2, "BOCHS ", "BXPC    ", 0x00000001)
 {
     Scope (\_SB)
     {
         Device (C000)
         {
             Name (_HID, "ACPI0007" /* Processor Device */)  // _HID: Hardware ID
             Name (_UID, Zero)  // _UID: Unique ID
         }

@@ -1769,33 +1769,33 @@
                     0x001FFFFF,
                     0x02,
                     L001,
                     Zero
                 },

                 Package (0x04)
                 {
                     0x001FFFFF,
                     0x03,
                     L002,
                     Zero
                 }
             })
             Method (_CBA, 0, NotSerialized)  // _CBA: Configuration Base Address
             {
-                Return (0x0000004010000000)
+                Return (0x90000000)
             }

             Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
             {
                 WordBusNumber (ResourceProducer, MinFixed, MaxFixed, PosDecode,
                     0x0000,             // Granularity
                     0x0000,             // Range Minimum
                     0x00FF,             // Range Maximum
                     0x0000,             // Translation Offset
                     0x0100,             // Length
                     ,, )
                 DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                     0x00000000,         // Granularity
                     0x10000000,         // Range Minimum
                     0x3EFEFFFF,         // Range Maximum
                     0x00000000,         // Translation Offset
@@ -1858,34 +1858,34 @@
                     }
                 }

                 Return (Buffer (One)
                 {
                      0x00                                             // .
                 })
             }

             Device (RES0)
             {
                 Name (_HID, "PNP0C02" /* PNP Motherboard Resources */)  // _HID: Hardware ID
                 Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                 {
                     QWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                         0x0000000000000000, // Granularity
-                        0x0000004010000000, // Range Minimum
-                        0x000000401FFFFFFF, // Range Maximum
+                        0x0000000090000000, // Range Minimum
+                        0x000000009FFFFFFF, // Range Maximum
                         0x0000000000000000, // Translation Offset
                         0x0000000010000000, // Length
                         ,, , AddressRangeMemory, TypeStatic)
                 })
             }
         }

         Device (\_SB.GED)
         {
             Name (_HID, "ACPI0013" /* Generic Event Device */)  // _HID: Hardware ID
             Name (_UID, "GED")  // _UID: Unique ID
             Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
             {
                 Interrupt (ResourceConsumer, Edge, ActiveHigh, Exclusive, ,, )
                 {
                     0x00000029,
acpi-test: Warning! MCFG binary file mismatch. Actual [aml:/tmp/aml-BGDPE3], Expected [aml:tests/data/acpi/aarch64/virt/MCFG].
See source file tests/qtest/bios-tables-test.c for instructions on how to update expected files.
acpi-test: Warning! MCFG mismatch. Actual [asl:/tmp/asl-18CPE3.dsl, aml:/tmp/aml-BGDPE3], Expected [asl:/tmp/asl-43HPE3.dsl, aml:tests/data/acpi/aarch64/virt/MCFG].
--- /tmp/asl-43HPE3.dsl 2025-10-27 19:11:21.702930144 +0900
+++ /tmp/asl-18CPE3.dsl 2025-10-27 19:11:21.698408108 +0900
@@ -1,36 +1,36 @@
 /*
  * Intel ACPI Component Architecture
  * AML/ASL+ Disassembler version 20240322 (64-bit version)
  * Copyright (c) 2000 - 2023 Intel Corporation
  *
- * Disassembly of tests/data/acpi/aarch64/virt/MCFG
+ * Disassembly of /tmp/aml-BGDPE3
  *
  * ACPI Data Table [MCFG]
  *
  * Format: [HexOffset DecimalOffset ByteLength]  FieldName : FieldValue (in hex)
  */

 [000h 0000 004h]                   Signature : "MCFG"    [Memory Mapped Configuration Table]
 [004h 0004 004h]                Table Length : 0000003C
 [008h 0008 001h]                    Revision : 01
-[009h 0009 001h]                    Checksum : EC
+[009h 0009 001h]                    Checksum : AC
 [00Ah 0010 006h]                      Oem ID : "BOCHS "
 [010h 0016 008h]                Oem Table ID : "BXPC    "
 [018h 0024 004h]                Oem Revision : 00000001
 [01Ch 0028 004h]             Asl Compiler ID : "BXPC"
 [020h 0032 004h]       Asl Compiler Revision : 00000001

 [024h 0036 008h]                    Reserved : 0000000000000000

-[02Ch 0044 008h]                Base Address : 0000004010000000
+[02Ch 0044 008h]                Base Address : 0000000090000000
 [034h 0052 002h]        Segment Group Number : 0000
 [036h 0054 001h]            Start Bus Number : 00
 [037h 0055 001h]              End Bus Number : FF
 [038h 0056 004h]                    Reserved : 00000000

 Raw Table Data: Length 60 (0x3C)

-    0000: 4D 43 46 47 3C 00 00 00 01 EC 42 4F 43 48 53 20  // MCFG<.....BOCHS
+    0000: 4D 43 46 47 3C 00 00 00 01 AC 42 4F 43 48 53 20  // MCFG<.....BOCHS
     0010: 42 58 50 43 20 20 20 20 01 00 00 00 42 58 50 43  // BXPC    ....BXPC
-    0020: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 10  // ................
-    0030: 40 00 00 00 00 00 00 FF 00 00 00 00              // @...........
+    0020: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 90  // ................
+    0030: 00 00 00 00 00 00 00 FF 00 00 00 00              // ............
acpi-test: Warning! DSDT binary file mismatch. Actual [aml:/tmp/aml-N5CPE3], Expected [aml:tests/data/acpi/aarch64/virt/DSDT.topology].
See source file tests/qtest/bios-tables-test.c for instructions on how to update expected files.
acpi-test: Warning! DSDT mismatch. Actual [asl:/tmp/asl-CNWOE3.dsl, aml:/tmp/aml-N5CPE3], Expected [asl:/tmp/asl-J52OE3.dsl, aml:tests/data/acpi/aarch64/virt/DSDT.topology].
--- /tmp/asl-J52OE3.dsl 2025-10-27 19:11:21.719525359 +0900
+++ /tmp/asl-CNWOE3.dsl 2025-10-27 19:11:21.712525303 +0900
@@ -1,30 +1,30 @@
 /*
  * Intel ACPI Component Architecture
  * AML/ASL+ Disassembler version 20240322 (64-bit version)
  * Copyright (c) 2000 - 2023 Intel Corporation
  *
  * Disassembling to symbolic ASL+ operators
  *
- * Disassembly of tests/data/acpi/aarch64/virt/DSDT.topology
+ * Disassembly of /tmp/aml-N5CPE3
  *
  * Original Table Header:
  *     Signature        "DSDT"
- *     Length           0x000015A3 (5539)
+ *     Length           0x0000159F (5535)
  *     Revision         0x02
- *     Checksum         0x98
+ *     Checksum         0xEA
  *     OEM ID           "BOCHS "
  *     OEM Table ID     "BXPC    "
  *     OEM Revision     0x00000001 (1)
  *     Compiler ID      "BXPC"
  *     Compiler Version 0x00000001 (1)
  */
 DefinitionBlock ("", "DSDT", 2, "BOCHS ", "BXPC    ", 0x00000001)
 {
     Scope (\_SB)
     {
         Device (C000)
         {
             Name (_HID, "ACPI0007" /* Processor Device */)  // _HID: Hardware ID
             Name (_UID, Zero)  // _UID: Unique ID
         }

@@ -1793,33 +1793,33 @@
                     0x001FFFFF,
                     0x02,
                     L001,
                     Zero
                 },

                 Package (0x04)
                 {
                     0x001FFFFF,
                     0x03,
                     L002,
                     Zero
                 }
             })
             Method (_CBA, 0, NotSerialized)  // _CBA: Configuration Base Address
             {
-                Return (0x0000004010000000)
+                Return (0x90000000)
             }

             Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
             {
                 WordBusNumber (ResourceProducer, MinFixed, MaxFixed, PosDecode,
                     0x0000,             // Granularity
                     0x0000,             // Range Minimum
                     0x00FF,             // Range Maximum
                     0x0000,             // Translation Offset
                     0x0100,             // Length
                     ,, )
                 DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                     0x00000000,         // Granularity
                     0x10000000,         // Range Minimum
                     0x3EFEFFFF,         // Range Maximum
                     0x00000000,         // Translation Offset
@@ -1882,34 +1882,34 @@
                     }
                 }

                 Return (Buffer (One)
                 {
                      0x00                                             // .
                 })
             }

             Device (RES0)
             {
                 Name (_HID, "PNP0C02" /* PNP Motherboard Resources */)  // _HID: Hardware ID
                 Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                 {
                     QWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                         0x0000000000000000, // Granularity
-                        0x0000004010000000, // Range Minimum
-                        0x000000401FFFFFFF, // Range Maximum
+                        0x0000000090000000, // Range Minimum
+                        0x000000009FFFFFFF, // Range Maximum
                         0x0000000000000000, // Translation Offset
                         0x0000000010000000, // Length
                         ,, , AddressRangeMemory, TypeStatic)
                 })
             }
         }

         Device (\_SB.GED)
         {
             Name (_HID, "ACPI0013" /* Generic Event Device */)  // _HID: Hardware ID
             Name (_UID, "GED")  // _UID: Unique ID
             Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
             {
                 Interrupt (ResourceConsumer, Edge, ActiveHigh, Exclusive, ,, )
                 {
                     0x00000029,
acpi-test: Warning! MCFG binary file mismatch. Actual [aml:/tmp/aml-GPWVE3], Expected [aml:tests/data/acpi/aarch64/virt/MCFG].
See source file tests/qtest/bios-tables-test.c for instructions on how to update expected files.
acpi-test: Warning! MCFG mismatch. Actual [asl:/tmp/asl-RQWVE3.dsl, aml:/tmp/aml-GPWVE3], Expected [asl:/tmp/asl-FU9UE3.dsl, aml:tests/data/acpi/aarch64/virt/MCFG].
--- /tmp/asl-FU9UE3.dsl 2025-10-27 19:11:34.352034597 +0900
+++ /tmp/asl-RQWVE3.dsl 2025-10-27 19:11:34.347286310 +0900
@@ -1,36 +1,36 @@
 /*
  * Intel ACPI Component Architecture
  * AML/ASL+ Disassembler version 20240322 (64-bit version)
  * Copyright (c) 2000 - 2023 Intel Corporation
  *
- * Disassembly of tests/data/acpi/aarch64/virt/MCFG
+ * Disassembly of /tmp/aml-GPWVE3
  *
  * ACPI Data Table [MCFG]
  *
  * Format: [HexOffset DecimalOffset ByteLength]  FieldName : FieldValue (in hex)
  */

 [000h 0000 004h]                   Signature : "MCFG"    [Memory Mapped Configuration Table]
 [004h 0004 004h]                Table Length : 0000003C
 [008h 0008 001h]                    Revision : 01
-[009h 0009 001h]                    Checksum : EC
+[009h 0009 001h]                    Checksum : AC
 [00Ah 0010 006h]                      Oem ID : "BOCHS "
 [010h 0016 008h]                Oem Table ID : "BXPC    "
 [018h 0024 004h]                Oem Revision : 00000001
 [01Ch 0028 004h]             Asl Compiler ID : "BXPC"
 [020h 0032 004h]       Asl Compiler Revision : 00000001

 [024h 0036 008h]                    Reserved : 0000000000000000

-[02Ch 0044 008h]                Base Address : 0000004010000000
+[02Ch 0044 008h]                Base Address : 0000000090000000
 [034h 0052 002h]        Segment Group Number : 0000
 [036h 0054 001h]            Start Bus Number : 00
 [037h 0055 001h]              End Bus Number : FF
 [038h 0056 004h]                    Reserved : 00000000

 Raw Table Data: Length 60 (0x3C)

-    0000: 4D 43 46 47 3C 00 00 00 01 EC 42 4F 43 48 53 20  // MCFG<.....BOCHS
+    0000: 4D 43 46 47 3C 00 00 00 01 AC 42 4F 43 48 53 20  // MCFG<.....BOCHS
     0010: 42 58 50 43 20 20 20 20 01 00 00 00 42 58 50 43  // BXPC    ....BXPC
-    0020: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 10  // ................
-    0030: 40 00 00 00 00 00 00 FF 00 00 00 00              // @...........
+    0020: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 90  // ................
+    0030: 00 00 00 00 00 00 00 FF 00 00 00 00              // ............
acpi-test: Warning! DSDT binary file mismatch. Actual [aml:/tmp/aml-0OWVE3], Expected [aml:tests/data/acpi/aarch64/virt/DSDT].
See source file tests/qtest/bios-tables-test.c for instructions on how to update expected files.
acpi-test: Warning! DSDT mismatch. Actual [asl:/tmp/asl-AJEVE3.dsl, aml:/tmp/aml-0OWVE3], Expected [asl:/tmp/asl-28AWE3.dsl, aml:tests/data/acpi/aarch64/virt/DSDT].
--- /tmp/asl-28AWE3.dsl 2025-10-27 19:11:34.371625795 +0900
+++ /tmp/asl-AJEVE3.dsl 2025-10-27 19:11:34.359625699 +0900
@@ -1,30 +1,30 @@
 /*
  * Intel ACPI Component Architecture
  * AML/ASL+ Disassembler version 20240322 (64-bit version)
  * Copyright (c) 2000 - 2023 Intel Corporation
  *
  * Disassembling to symbolic ASL+ operators
  *
- * Disassembly of tests/data/acpi/aarch64/virt/DSDT
+ * Disassembly of /tmp/aml-0OWVE3
  *
  * Original Table Header:
  *     Signature        "DSDT"
- *     Length           0x000014D9 (5337)
+ *     Length           0x000014D5 (5333)
  *     Revision         0x02
- *     Checksum         0xA4
+ *     Checksum         0xF6
  *     OEM ID           "BOCHS "
  *     OEM Table ID     "BXPC    "
  *     OEM Revision     0x00000001 (1)
  *     Compiler ID      "BXPC"
  *     Compiler Version 0x00000001 (1)
  */
 DefinitionBlock ("", "DSDT", 2, "BOCHS ", "BXPC    ", 0x00000001)
 {
     Scope (\_SB)
     {
         Device (C000)
         {
             Name (_HID, "ACPI0007" /* Processor Device */)  // _HID: Hardware ID
             Name (_UID, Zero)  // _UID: Unique ID
         }

@@ -1751,33 +1751,33 @@
                     0x001FFFFF,
                     0x02,
                     L001,
                     Zero
                 },

                 Package (0x04)
                 {
                     0x001FFFFF,
                     0x03,
                     L002,
                     Zero
                 }
             })
             Method (_CBA, 0, NotSerialized)  // _CBA: Configuration Base Address
             {
-                Return (0x0000004010000000)
+                Return (0x90000000)
             }

             Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
             {
                 WordBusNumber (ResourceProducer, MinFixed, MaxFixed, PosDecode,
                     0x0000,             // Granularity
                     0x0000,             // Range Minimum
                     0x00FF,             // Range Maximum
                     0x0000,             // Translation Offset
                     0x0100,             // Length
                     ,, )
                 DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                     0x00000000,         // Granularity
                     0x10000000,         // Range Minimum
                     0x3EFEFFFF,         // Range Maximum
                     0x00000000,         // Translation Offset
@@ -1840,34 +1840,34 @@
                     }
                 }

                 Return (Buffer (One)
                 {
                      0x00                                             // .
                 })
             }

             Device (RES0)
             {
                 Name (_HID, "PNP0C02" /* PNP Motherboard Resources */)  // _HID: Hardware ID
                 Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                 {
                     QWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                         0x0000000000000000, // Granularity
-                        0x0000004010000000, // Range Minimum
-                        0x000000401FFFFFFF, // Range Maximum
+                        0x0000000090000000, // Range Minimum
+                        0x000000009FFFFFFF, // Range Maximum
                         0x0000000000000000, // Translation Offset
                         0x0000000010000000, // Length
                         ,, , AddressRangeMemory, TypeStatic)
                 })
             }
         }

         Device (\_SB.GED)
         {
             Name (_HID, "ACPI0013" /* Generic Event Device */)  // _HID: Hardware ID
             Name (_UID, "GED")  // _UID: Unique ID
             Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
             {
                 Interrupt (ResourceConsumer, Edge, ActiveHigh, Exclusive, ,, )
                 {
                     0x00000029,
acpi-test: Warning! MCFG binary file mismatch. Actual [aml:/tmp/aml-JEU1E3], Expected [aml:tests/data/acpi/aarch64/virt/MCFG].
See source file tests/qtest/bios-tables-test.c for instructions on how to update expected files.
acpi-test: Warning! MCFG mismatch. Actual [asl:/tmp/asl-4IU1E3.dsl, aml:/tmp/aml-JEU1E3], Expected [asl:/tmp/asl-T4UZE3.dsl, aml:tests/data/acpi/aarch64/virt/MCFG].
--- /tmp/asl-T4UZE3.dsl 2025-10-27 19:11:47.137811428 +0900
+++ /tmp/asl-4IU1E3.dsl 2025-10-27 19:11:47.133159724 +0900
@@ -1,36 +1,36 @@
 /*
  * Intel ACPI Component Architecture
  * AML/ASL+ Disassembler version 20240322 (64-bit version)
  * Copyright (c) 2000 - 2023 Intel Corporation
  *
- * Disassembly of tests/data/acpi/aarch64/virt/MCFG
+ * Disassembly of /tmp/aml-JEU1E3
  *
  * ACPI Data Table [MCFG]
  *
  * Format: [HexOffset DecimalOffset ByteLength]  FieldName : FieldValue (in hex)
  */

 [000h 0000 004h]                   Signature : "MCFG"    [Memory Mapped Configuration Table]
 [004h 0004 004h]                Table Length : 0000003C
 [008h 0008 001h]                    Revision : 01
-[009h 0009 001h]                    Checksum : EC
+[009h 0009 001h]                    Checksum : AC
 [00Ah 0010 006h]                      Oem ID : "BOCHS "
 [010h 0016 008h]                Oem Table ID : "BXPC    "
 [018h 0024 004h]                Oem Revision : 00000001
 [01Ch 0028 004h]             Asl Compiler ID : "BXPC"
 [020h 0032 004h]       Asl Compiler Revision : 00000001

 [024h 0036 008h]                    Reserved : 0000000000000000

-[02Ch 0044 008h]                Base Address : 0000004010000000
+[02Ch 0044 008h]                Base Address : 0000000090000000
 [034h 0052 002h]        Segment Group Number : 0000
 [036h 0054 001h]            Start Bus Number : 00
 [037h 0055 001h]              End Bus Number : FF
 [038h 0056 004h]                    Reserved : 00000000

 Raw Table Data: Length 60 (0x3C)

-    0000: 4D 43 46 47 3C 00 00 00 01 EC 42 4F 43 48 53 20  // MCFG<.....BOCHS
+    0000: 4D 43 46 47 3C 00 00 00 01 AC 42 4F 43 48 53 20  // MCFG<.....BOCHS
     0010: 42 58 50 43 20 20 20 20 01 00 00 00 42 58 50 43  // BXPC    ....BXPC
-    0020: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 10  // ................
-    0030: 40 00 00 00 00 00 00 FF 00 00 00 00              // @...........
+    0020: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 90  // ................
+    0030: 00 00 00 00 00 00 00 FF 00 00 00 00              // ............
acpi-test: Warning! DSDT binary file mismatch. Actual [aml:/tmp/aml-NCU1E3], Expected [aml:tests/data/acpi/aarch64/virt/DSDT].
See source file tests/qtest/bios-tables-test.c for instructions on how to update expected files.
acpi-test: Warning! DSDT mismatch. Actual [asl:/tmp/asl-NNZZE3.dsl, aml:/tmp/aml-NCU1E3], Expected [asl:/tmp/asl-VK4ZE3.dsl, aml:tests/data/acpi/aarch64/virt/DSDT].
--- /tmp/asl-VK4ZE3.dsl 2025-10-27 19:11:47.150727239 +0900
+++ /tmp/asl-NNZZE3.dsl 2025-10-27 19:11:47.143727183 +0900
@@ -1,30 +1,30 @@
 /*
  * Intel ACPI Component Architecture
  * AML/ASL+ Disassembler version 20240322 (64-bit version)
  * Copyright (c) 2000 - 2023 Intel Corporation
  *
  * Disassembling to symbolic ASL+ operators
  *
- * Disassembly of tests/data/acpi/aarch64/virt/DSDT
+ * Disassembly of /tmp/aml-NCU1E3
  *
  * Original Table Header:
  *     Signature        "DSDT"
- *     Length           0x000014D9 (5337)
+ *     Length           0x000014D5 (5333)
  *     Revision         0x02
- *     Checksum         0xA4
+ *     Checksum         0xF6
  *     OEM ID           "BOCHS "
  *     OEM Table ID     "BXPC    "
  *     OEM Revision     0x00000001 (1)
  *     Compiler ID      "BXPC"
  *     Compiler Version 0x00000001 (1)
  */
 DefinitionBlock ("", "DSDT", 2, "BOCHS ", "BXPC    ", 0x00000001)
 {
     Scope (\_SB)
     {
         Device (C000)
         {
             Name (_HID, "ACPI0007" /* Processor Device */)  // _HID: Hardware ID
             Name (_UID, Zero)  // _UID: Unique ID
         }

@@ -1751,33 +1751,33 @@
                     0x001FFFFF,
                     0x02,
                     L001,
                     Zero
                 },

                 Package (0x04)
                 {
                     0x001FFFFF,
                     0x03,
                     L002,
                     Zero
                 }
             })
             Method (_CBA, 0, NotSerialized)  // _CBA: Configuration Base Address
             {
-                Return (0x0000004010000000)
+                Return (0x90000000)
             }

             Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
             {
                 WordBusNumber (ResourceProducer, MinFixed, MaxFixed, PosDecode,
                     0x0000,             // Granularity
                     0x0000,             // Range Minimum
                     0x00FF,             // Range Maximum
                     0x0000,             // Translation Offset
                     0x0100,             // Length
                     ,, )
                 DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                     0x00000000,         // Granularity
                     0x10000000,         // Range Minimum
                     0x3EFEFFFF,         // Range Maximum
                     0x00000000,         // Translation Offset
@@ -1840,34 +1840,34 @@
                     }
                 }

                 Return (Buffer (One)
                 {
                      0x00                                             // .
                 })
             }

             Device (RES0)
             {
                 Name (_HID, "PNP0C02" /* PNP Motherboard Resources */)  // _HID: Hardware ID
                 Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                 {
                     QWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                         0x0000000000000000, // Granularity
-                        0x0000004010000000, // Range Minimum
-                        0x000000401FFFFFFF, // Range Maximum
+                        0x0000000090000000, // Range Minimum
+                        0x000000009FFFFFFF, // Range Maximum
                         0x0000000000000000, // Translation Offset
                         0x0000000010000000, // Length
                         ,, , AddressRangeMemory, TypeStatic)
                 })
             }
         }

         Device (\_SB.GED)
         {
             Name (_HID, "ACPI0013" /* Generic Event Device */)  // _HID: Hardware ID
             Name (_UID, "GED")  // _UID: Unique ID
             Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
             {
                 Interrupt (ResourceConsumer, Edge, ActiveHigh, Exclusive, ,, )
                 {
                     0x00000029,
acpi-test: Warning! MCFG binary file mismatch. Actual [aml:/tmp/aml-7WB3E3], Expected [aml:tests/data/acpi/aarch64/virt/MCFG].
See source file tests/qtest/bios-tables-test.c for instructions on how to update expected files.
acpi-test: Warning! MCFG mismatch. Actual [asl:/tmp/asl-4UB3E3.dsl, aml:/tmp/aml-7WB3E3], Expected [asl:/tmp/asl-TRI3E3.dsl, aml:tests/data/acpi/aarch64/virt/MCFG].
--- /tmp/asl-TRI3E3.dsl 2025-10-27 19:12:00.047489241 +0900
+++ /tmp/asl-4UB3E3.dsl 2025-10-27 19:12:00.041389109 +0900
@@ -1,36 +1,36 @@
 /*
  * Intel ACPI Component Architecture
  * AML/ASL+ Disassembler version 20240322 (64-bit version)
  * Copyright (c) 2000 - 2023 Intel Corporation
  *
- * Disassembly of tests/data/acpi/aarch64/virt/MCFG
+ * Disassembly of /tmp/aml-7WB3E3
  *
  * ACPI Data Table [MCFG]
  *
  * Format: [HexOffset DecimalOffset ByteLength]  FieldName : FieldValue (in hex)
  */

 [000h 0000 004h]                   Signature : "MCFG"    [Memory Mapped Configuration Table]
 [004h 0004 004h]                Table Length : 0000003C
 [008h 0008 001h]                    Revision : 01
-[009h 0009 001h]                    Checksum : EC
+[009h 0009 001h]                    Checksum : AB
 [00Ah 0010 006h]                      Oem ID : "BOCHS "
 [010h 0016 008h]                Oem Table ID : "BXPC    "
 [018h 0024 004h]                Oem Revision : 00000001
 [01Ch 0028 004h]             Asl Compiler ID : "BXPC"
 [020h 0032 004h]       Asl Compiler Revision : 00000001

 [024h 0036 008h]                    Reserved : 0000000000000000

-[02Ch 0044 008h]                Base Address : 0000004010000000
+[02Ch 0044 008h]                Base Address : 0000000190000000
 [034h 0052 002h]        Segment Group Number : 0000
 [036h 0054 001h]            Start Bus Number : 00
 [037h 0055 001h]              End Bus Number : FF
 [038h 0056 004h]                    Reserved : 00000000

 Raw Table Data: Length 60 (0x3C)

-    0000: 4D 43 46 47 3C 00 00 00 01 EC 42 4F 43 48 53 20  // MCFG<.....BOCHS
+    0000: 4D 43 46 47 3C 00 00 00 01 AB 42 4F 43 48 53 20  // MCFG<.....BOCHS
     0010: 42 58 50 43 20 20 20 20 01 00 00 00 42 58 50 43  // BXPC    ....BXPC
-    0020: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 10  // ................
-    0030: 40 00 00 00 00 00 00 FF 00 00 00 00              // @...........
+    0020: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 90  // ................
+    0030: 01 00 00 00 00 00 00 FF 00 00 00 00              // ............
acpi-test: Warning! DSDT binary file mismatch. Actual [aml:/tmp/aml-0QB3E3], Expected [aml:tests/data/acpi/aarch64/virt/DSDT.memhp].
See source file tests/qtest/bios-tables-test.c for instructions on how to update expected files.
acpi-test: Warning! DSDT mismatch. Actual [asl:/tmp/asl-I1L3E3.dsl, aml:/tmp/aml-0QB3E3], Expected [asl:/tmp/asl-IB72E3.dsl, aml:tests/data/acpi/aarch64/virt/DSDT.memhp].
--- /tmp/asl-IB72E3.dsl 2025-10-27 19:12:00.067829947 +0900
+++ /tmp/asl-I1L3E3.dsl 2025-10-27 19:12:00.057829866 +0900
@@ -1,30 +1,30 @@
 /*
  * Intel ACPI Component Architecture
  * AML/ASL+ Disassembler version 20240322 (64-bit version)
  * Copyright (c) 2000 - 2023 Intel Corporation
  *
  * Disassembling to symbolic ASL+ operators
  *
- * Disassembly of tests/data/acpi/aarch64/virt/DSDT.memhp
+ * Disassembly of /tmp/aml-0QB3E3
  *
  * Original Table Header:
  *     Signature        "DSDT"
  *     Length           0x00001A2A (6698)
  *     Revision         0x02
- *     Checksum         0xD3
+ *     Checksum         0x10
  *     OEM ID           "BOCHS "
  *     OEM Table ID     "BXPC    "
  *     OEM Revision     0x00000001 (1)
  *     Compiler ID      "BXPC"
  *     Compiler Version 0x00000001 (1)
  */
 DefinitionBlock ("", "DSDT", 2, "BOCHS ", "BXPC    ", 0x00000001)
 {
     External (_SB_.NVDR, UnknownObj)

     Scope (\_SB)
     {
         Device (C000)
         {
             Name (_HID, "ACPI0007" /* Processor Device */)  // _HID: Hardware ID
             Name (_UID, Zero)  // _UID: Unique ID
@@ -1753,33 +1753,33 @@
                     0x001FFFFF,
                     0x02,
                     L001,
                     Zero
                 },

                 Package (0x04)
                 {
                     0x001FFFFF,
                     0x03,
                     L002,
                     Zero
                 }
             })
             Method (_CBA, 0, NotSerialized)  // _CBA: Configuration Base Address
             {
-                Return (0x0000004010000000)
+                Return (0x0000000190000000)
             }

             Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
             {
                 WordBusNumber (ResourceProducer, MinFixed, MaxFixed, PosDecode,
                     0x0000,             // Granularity
                     0x0000,             // Range Minimum
                     0x00FF,             // Range Maximum
                     0x0000,             // Translation Offset
                     0x0100,             // Length
                     ,, )
                 DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                     0x00000000,         // Granularity
                     0x10000000,         // Range Minimum
                     0x3EFEFFFF,         // Range Maximum
                     0x00000000,         // Translation Offset
@@ -1842,34 +1842,34 @@
                     }
                 }

                 Return (Buffer (One)
                 {
                      0x00                                             // .
                 })
             }

             Device (RES0)
             {
                 Name (_HID, "PNP0C02" /* PNP Motherboard Resources */)  // _HID: Hardware ID
                 Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                 {
                     QWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                         0x0000000000000000, // Granularity
-                        0x0000004010000000, // Range Minimum
-                        0x000000401FFFFFFF, // Range Maximum
+                        0x0000000190000000, // Range Minimum
+                        0x000000019FFFFFFF, // Range Maximum
                         0x0000000000000000, // Translation Offset
                         0x0000000010000000, // Length
                         ,, , AddressRangeMemory, TypeStatic)
                 })
             }
         }

         Device (\_SB.GED)
         {
             Name (_HID, "ACPI0013" /* Generic Event Device */)  // _HID: Hardware ID
             Name (_UID, "GED")  // _UID: Unique ID
             Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
             {
                 Interrupt (ResourceConsumer, Edge, ActiveHigh, Exclusive, ,, )
                 {
                     0x00000029,
acpi-test: Warning! MCFG binary file mismatch. Actual [aml:/tmp/aml-CK9OE3], Expected [aml:tests/data/acpi/aarch64/virt/MCFG].
See source file tests/qtest/bios-tables-test.c for instructions on how to update expected files.
acpi-test: Warning! MCFG mismatch. Actual [asl:/tmp/asl-3A9OE3.dsl, aml:/tmp/aml-CK9OE3], Expected [asl:/tmp/asl-9ICPE3.dsl, aml:tests/data/acpi/aarch64/virt/MCFG].
--- /tmp/asl-9ICPE3.dsl 2025-10-27 19:12:13.697371145 +0900
+++ /tmp/asl-3A9OE3.dsl 2025-10-27 19:12:13.693601573 +0900
@@ -1,36 +1,36 @@
 /*
  * Intel ACPI Component Architecture
  * AML/ASL+ Disassembler version 20240322 (64-bit version)
  * Copyright (c) 2000 - 2023 Intel Corporation
  *
- * Disassembly of tests/data/acpi/aarch64/virt/MCFG
+ * Disassembly of /tmp/aml-CK9OE3
  *
  * ACPI Data Table [MCFG]
  *
  * Format: [HexOffset DecimalOffset ByteLength]  FieldName : FieldValue (in hex)
  */

 [000h 0000 004h]                   Signature : "MCFG"    [Memory Mapped Configuration Table]
 [004h 0004 004h]                Table Length : 0000003C
 [008h 0008 001h]                    Revision : 01
-[009h 0009 001h]                    Checksum : EC
+[009h 0009 001h]                    Checksum : AC
 [00Ah 0010 006h]                      Oem ID : "BOCHS "
 [010h 0016 008h]                Oem Table ID : "BXPC    "
 [018h 0024 004h]                Oem Revision : 00000001
 [01Ch 0028 004h]             Asl Compiler ID : "BXPC"
 [020h 0032 004h]       Asl Compiler Revision : 00000001

 [024h 0036 008h]                    Reserved : 0000000000000000

-[02Ch 0044 008h]                Base Address : 0000004010000000
+[02Ch 0044 008h]                Base Address : 0000000090000000
 [034h 0052 002h]        Segment Group Number : 0000
 [036h 0054 001h]            Start Bus Number : 00
 [037h 0055 001h]              End Bus Number : FF
 [038h 0056 004h]                    Reserved : 00000000

 Raw Table Data: Length 60 (0x3C)

-    0000: 4D 43 46 47 3C 00 00 00 01 EC 42 4F 43 48 53 20  // MCFG<.....BOCHS
+    0000: 4D 43 46 47 3C 00 00 00 01 AC 42 4F 43 48 53 20  // MCFG<.....BOCHS
     0010: 42 58 50 43 20 20 20 20 01 00 00 00 42 58 50 43  // BXPC    ....BXPC
-    0020: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 10  // ................
-    0030: 40 00 00 00 00 00 00 FF 00 00 00 00              // @...........
+    0020: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 90  // ................
+    0030: 00 00 00 00 00 00 00 FF 00 00 00 00              // ............
acpi-test: Warning! DSDT binary file mismatch. Actual [aml:/tmp/aml-CJ9OE3], Expected [aml:tests/data/acpi/aarch64/virt/DSDT.acpipcihp].
See source file tests/qtest/bios-tables-test.c for instructions on how to update expected files.
acpi-test: Warning! DSDT mismatch. Actual [asl:/tmp/asl-85JPE3.dsl, aml:/tmp/aml-CJ9OE3], Expected [asl:/tmp/asl-5OZOE3.dsl, aml:tests/data/acpi/aarch64/virt/DSDT.acpipcihp].
--- /tmp/asl-5OZOE3.dsl 2025-10-27 19:12:13.712939854 +0900
+++ /tmp/asl-85JPE3.dsl 2025-10-27 19:12:13.705939798 +0900
@@ -1,30 +1,30 @@
 /*
  * Intel ACPI Component Architecture
  * AML/ASL+ Disassembler version 20240322 (64-bit version)
  * Copyright (c) 2000 - 2023 Intel Corporation
  *
  * Disassembling to symbolic ASL+ operators
  *
- * Disassembly of tests/data/acpi/aarch64/virt/DSDT.acpipcihp
+ * Disassembly of /tmp/aml-CJ9OE3
  *
  * Original Table Header:
  *     Signature        "DSDT"
- *     Length           0x00001866 (6246)
+ *     Length           0x00001862 (6242)
  *     Revision         0x02
- *     Checksum         0x70
+ *     Checksum         0xC2
  *     OEM ID           "BOCHS "
  *     OEM Table ID     "BXPC    "
  *     OEM Revision     0x00000001 (1)
  *     Compiler ID      "BXPC"
  *     Compiler Version 0x00000001 (1)
  */
 DefinitionBlock ("", "DSDT", 2, "BOCHS ", "BXPC    ", 0x00000001)
 {
     Scope (\_SB)
     {
         Device (C000)
         {
             Name (_HID, "ACPI0007" /* Processor Device */)  // _HID: Hardware ID
             Name (_UID, Zero)  // _UID: Unique ID
         }

@@ -1751,33 +1751,33 @@
                     0x001FFFFF,
                     0x02,
                     L001,
                     Zero
                 },

                 Package (0x04)
                 {
                     0x001FFFFF,
                     0x03,
                     L002,
                     Zero
                 }
             })
             Method (_CBA, 0, NotSerialized)  // _CBA: Configuration Base Address
             {
-                Return (0x0000004010000000)
+                Return (0x90000000)
             }

             Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
             {
                 WordBusNumber (ResourceProducer, MinFixed, MaxFixed, PosDecode,
                     0x0000,             // Granularity
                     0x0000,             // Range Minimum
                     0x00FF,             // Range Maximum
                     0x0000,             // Translation Offset
                     0x0100,             // Length
                     ,, )
                 DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                     0x00000000,         // Granularity
                     0x10000000,         // Range Minimum
                     0x3EFEFFFF,         // Range Maximum
                     0x00000000,         // Translation Offset
@@ -1840,34 +1840,34 @@
                     }
                 }

                 Return (Buffer (One)
                 {
                      0x00                                             // .
                 })
             }

             Device (RES0)
             {
                 Name (_HID, "PNP0C02" /* PNP Motherboard Resources */)  // _HID: Hardware ID
                 Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                 {
                     QWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                         0x0000000000000000, // Granularity
-                        0x0000004010000000, // Range Minimum
-                        0x000000401FFFFFFF, // Range Maximum
+                        0x0000000090000000, // Range Minimum
+                        0x000000009FFFFFFF, // Range Maximum
                         0x0000000000000000, // Translation Offset
                         0x0000000010000000, // Length
                         ,, , AddressRangeMemory, TypeStatic)
                 })
             }
         }

         Device (\_SB.GED)
         {
             Name (_HID, "ACPI0013" /* Generic Event Device */)  // _HID: Hardware ID
             Name (_UID, "GED")  // _UID: Unique ID
             Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
             {
                 Interrupt (ResourceConsumer, Edge, ActiveHigh, Exclusive, ,, )
                 {
                     0x00000029,
acpi-test: Warning! MCFG binary file mismatch. Actual [aml:/tmp/aml-AKH2E3], Expected [aml:tests/data/acpi/aarch64/virt/MCFG].
See source file tests/qtest/bios-tables-test.c for instructions on how to update expected files.
acpi-test: Warning! MCFG mismatch. Actual [asl:/tmp/asl-6TI2E3.dsl, aml:/tmp/aml-AKH2E3], Expected [asl:/tmp/asl-P7F3E3.dsl, aml:tests/data/acpi/aarch64/virt/MCFG].
--- /tmp/asl-P7F3E3.dsl 2025-10-27 19:12:27.044864322 +0900
+++ /tmp/asl-6TI2E3.dsl 2025-10-27 19:12:27.040471411 +0900
@@ -1,36 +1,36 @@
 /*
  * Intel ACPI Component Architecture
  * AML/ASL+ Disassembler version 20240322 (64-bit version)
  * Copyright (c) 2000 - 2023 Intel Corporation
  *
- * Disassembly of tests/data/acpi/aarch64/virt/MCFG
+ * Disassembly of /tmp/aml-AKH2E3
  *
  * ACPI Data Table [MCFG]
  *
  * Format: [HexOffset DecimalOffset ByteLength]  FieldName : FieldValue (in hex)
  */

 [000h 0000 004h]                   Signature : "MCFG"    [Memory Mapped Configuration Table]
 [004h 0004 004h]                Table Length : 0000003C
 [008h 0008 001h]                    Revision : 01
-[009h 0009 001h]                    Checksum : EC
+[009h 0009 001h]                    Checksum : AC
 [00Ah 0010 006h]                      Oem ID : "BOCHS "
 [010h 0016 008h]                Oem Table ID : "BXPC    "
 [018h 0024 004h]                Oem Revision : 00000001
 [01Ch 0028 004h]             Asl Compiler ID : "BXPC"
 [020h 0032 004h]       Asl Compiler Revision : 00000001

 [024h 0036 008h]                    Reserved : 0000000000000000

-[02Ch 0044 008h]                Base Address : 0000004010000000
+[02Ch 0044 008h]                Base Address : 0000000090000000
 [034h 0052 002h]        Segment Group Number : 0000
 [036h 0054 001h]            Start Bus Number : 00
 [037h 0055 001h]              End Bus Number : FF
 [038h 0056 004h]                    Reserved : 00000000

 Raw Table Data: Length 60 (0x3C)

-    0000: 4D 43 46 47 3C 00 00 00 01 EC 42 4F 43 48 53 20  // MCFG<.....BOCHS
+    0000: 4D 43 46 47 3C 00 00 00 01 AC 42 4F 43 48 53 20  // MCFG<.....BOCHS
     0010: 42 58 50 43 20 20 20 20 01 00 00 00 42 58 50 43  // BXPC    ....BXPC
-    0020: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 10  // ................
-    0030: 40 00 00 00 00 00 00 FF 00 00 00 00              // @...........
+    0020: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 90  // ................
+    0030: 00 00 00 00 00 00 00 FF 00 00 00 00              // ............
acpi-test: Warning! DSDT binary file mismatch. Actual [aml:/tmp/aml-9PJ2E3], Expected [aml:tests/data/acpi/aarch64/virt/DSDT.hpoffacpiindex].
See source file tests/qtest/bios-tables-test.c for instructions on how to update expected files.
acpi-test: Warning! DSDT mismatch. Actual [asl:/tmp/asl-WLK3E3.dsl, aml:/tmp/aml-9PJ2E3], Expected [asl:/tmp/asl-67Z2E3.dsl, aml:tests/data/acpi/aarch64/virt/DSDT.hpoffacpiindex].
--- /tmp/asl-67Z2E3.dsl 2025-10-27 19:12:27.057543091 +0900
+++ /tmp/asl-WLK3E3.dsl 2025-10-27 19:12:27.051047288 +0900
@@ -1,30 +1,30 @@
 /*
  * Intel ACPI Component Architecture
  * AML/ASL+ Disassembler version 20240322 (64-bit version)
  * Copyright (c) 2000 - 2023 Intel Corporation
  *
  * Disassembling to symbolic ASL+ operators
  *
- * Disassembly of tests/data/acpi/aarch64/virt/DSDT.hpoffacpiindex
+ * Disassembly of /tmp/aml-9PJ2E3
  *
  * Original Table Header:
  *     Signature        "DSDT"
- *     Length           0x0000150F (5391)
+ *     Length           0x0000150B (5387)
  *     Revision         0x02
- *     Checksum         0x4B
+ *     Checksum         0x9D
  *     OEM ID           "BOCHS "
  *     OEM Table ID     "BXPC    "
  *     OEM Revision     0x00000001 (1)
  *     Compiler ID      "BXPC"
  *     Compiler Version 0x00000001 (1)
  */
 DefinitionBlock ("", "DSDT", 2, "BOCHS ", "BXPC    ", 0x00000001)
 {
     Scope (\_SB)
     {
         Device (C000)
         {
             Name (_HID, "ACPI0007" /* Processor Device */)  // _HID: Hardware ID
             Name (_UID, Zero)  // _UID: Unique ID
         }

@@ -1751,33 +1751,33 @@
                     0x001FFFFF,
                     0x02,
                     L001,
                     Zero
                 },

                 Package (0x04)
                 {
                     0x001FFFFF,
                     0x03,
                     L002,
                     Zero
                 }
             })
             Method (_CBA, 0, NotSerialized)  // _CBA: Configuration Base Address
             {
-                Return (0x0000004010000000)
+                Return (0x90000000)
             }

             Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
             {
                 WordBusNumber (ResourceProducer, MinFixed, MaxFixed, PosDecode,
                     0x0000,             // Granularity
                     0x0000,             // Range Minimum
                     0x00FF,             // Range Maximum
                     0x0000,             // Translation Offset
                     0x0100,             // Length
                     ,, )
                 DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                     0x00000000,         // Granularity
                     0x10000000,         // Range Minimum
                     0x3EFEFFFF,         // Range Maximum
                     0x00000000,         // Translation Offset
@@ -1840,34 +1840,34 @@
                     }
                 }

                 Return (Buffer (One)
                 {
                      0x00                                             // .
                 })
             }

             Device (RES0)
             {
                 Name (_HID, "PNP0C02" /* PNP Motherboard Resources */)  // _HID: Hardware ID
                 Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                 {
                     QWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                         0x0000000000000000, // Granularity
-                        0x0000004010000000, // Range Minimum
-                        0x000000401FFFFFFF, // Range Maximum
+                        0x0000000090000000, // Range Minimum
+                        0x000000009FFFFFFF, // Range Maximum
                         0x0000000000000000, // Translation Offset
                         0x0000000010000000, // Length
                         ,, , AddressRangeMemory, TypeStatic)
                 })
             }
         }

         Device (\_SB.GED)
         {
             Name (_HID, "ACPI0013" /* Generic Event Device */)  // _HID: Hardware ID
             Name (_UID, "GED")  // _UID: Unique ID
             Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
             {
                 Interrupt (ResourceConsumer, Edge, ActiveHigh, Exclusive, ,, )
                 {
                     0x00000029,
acpi-test: Warning! MCFG binary file mismatch. Actual [aml:/tmp/aml-ABQME3], Expected [aml:tests/data/acpi/aarch64/virt/MCFG].
See source file tests/qtest/bios-tables-test.c for instructions on how to update expected files.
acpi-test: Warning! MCFG mismatch. Actual [asl:/tmp/asl-A3PME3.dsl, aml:/tmp/aml-ABQME3], Expected [asl:/tmp/asl-FTAME3.dsl, aml:tests/data/acpi/aarch64/virt/MCFG].
--- /tmp/asl-FTAME3.dsl 2025-10-27 19:12:44.852373797 +0900
+++ /tmp/asl-A3PME3.dsl 2025-10-27 19:12:44.843702978 +0900
@@ -1,36 +1,36 @@
 /*
  * Intel ACPI Component Architecture
  * AML/ASL+ Disassembler version 20240322 (64-bit version)
  * Copyright (c) 2000 - 2023 Intel Corporation
  *
- * Disassembly of tests/data/acpi/aarch64/virt/MCFG
+ * Disassembly of /tmp/aml-ABQME3
  *
  * ACPI Data Table [MCFG]
  *
  * Format: [HexOffset DecimalOffset ByteLength]  FieldName : FieldValue (in hex)
  */

 [000h 0000 004h]                   Signature : "MCFG"    [Memory Mapped Configuration Table]
 [004h 0004 004h]                Table Length : 0000003C
 [008h 0008 001h]                    Revision : 01
-[009h 0009 001h]                    Checksum : EC
+[009h 0009 001h]                    Checksum : AC
 [00Ah 0010 006h]                      Oem ID : "BOCHS "
 [010h 0016 008h]                Oem Table ID : "BXPC    "
 [018h 0024 004h]                Oem Revision : 00000001
 [01Ch 0028 004h]             Asl Compiler ID : "BXPC"
 [020h 0032 004h]       Asl Compiler Revision : 00000001

 [024h 0036 008h]                    Reserved : 0000000000000000

-[02Ch 0044 008h]                Base Address : 0000004010000000
+[02Ch 0044 008h]                Base Address : 0000000090000000
 [034h 0052 002h]        Segment Group Number : 0000
 [036h 0054 001h]            Start Bus Number : 00
 [037h 0055 001h]              End Bus Number : FF
 [038h 0056 004h]                    Reserved : 00000000

 Raw Table Data: Length 60 (0x3C)

-    0000: 4D 43 46 47 3C 00 00 00 01 EC 42 4F 43 48 53 20  // MCFG<.....BOCHS
+    0000: 4D 43 46 47 3C 00 00 00 01 AC 42 4F 43 48 53 20  // MCFG<.....BOCHS
     0010: 42 58 50 43 20 20 20 20 01 00 00 00 42 58 50 43  // BXPC    ....BXPC
-    0020: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 10  // ................
-    0030: 40 00 00 00 00 00 00 FF 00 00 00 00              // @...........
+    0020: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 90  // ................
+    0030: 00 00 00 00 00 00 00 FF 00 00 00 00              // ............
acpi-test: Warning! DSDT binary file mismatch. Actual [aml:/tmp/aml-17PME3], Expected [aml:tests/data/acpi/aarch64/virt/DSDT.pxb].
See source file tests/qtest/bios-tables-test.c for instructions on how to update expected files.
acpi-test: Warning! DSDT mismatch. Actual [asl:/tmp/asl-EYCKE3.dsl, aml:/tmp/aml-17PME3], Expected [asl:/tmp/asl-BVNKE3.dsl, aml:tests/data/acpi/aarch64/virt/DSDT.pxb].
--- /tmp/asl-BVNKE3.dsl 2025-10-27 19:12:44.877190872 +0900
+++ /tmp/asl-EYCKE3.dsl 2025-10-27 19:12:44.866190784 +0900
@@ -1,30 +1,30 @@
 /*
  * Intel ACPI Component Architecture
  * AML/ASL+ Disassembler version 20240322 (64-bit version)
  * Copyright (c) 2000 - 2023 Intel Corporation
  *
  * Disassembling to symbolic ASL+ operators
  *
- * Disassembly of tests/data/acpi/aarch64/virt/DSDT.pxb
+ * Disassembly of /tmp/aml-17PME3
  *
  * Original Table Header:
  *     Signature        "DSDT"
- *     Length           0x00001E84 (7812)
+ *     Length           0x00001E80 (7808)
  *     Revision         0x02
- *     Checksum         0x13
+ *     Checksum         0x65
  *     OEM ID           "BOCHS "
  *     OEM Table ID     "BXPC    "
  *     OEM Revision     0x00000001 (1)
  *     Compiler ID      "BXPC"
  *     Compiler Version 0x00000001 (1)
  */
 DefinitionBlock ("", "DSDT", 2, "BOCHS ", "BXPC    ", 0x00000001)
 {
     Scope (\_SB)
     {
         Device (C000)
         {
             Name (_HID, "ACPI0007" /* Processor Device */)  // _HID: Hardware ID
             Name (_UID, Zero)  // _UID: Unique ID
         }

@@ -2936,33 +2936,33 @@
                     0x001FFFFF,
                     0x02,
                     L001,
                     Zero
                 },

                 Package (0x04)
                 {
                     0x001FFFFF,
                     0x03,
                     L002,
                     Zero
                 }
             })
             Method (_CBA, 0, NotSerialized)  // _CBA: Configuration Base Address
             {
-                Return (0x0000004010000000)
+                Return (0x90000000)
             }

             Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
             {
                 WordBusNumber (ResourceProducer, MinFixed, MaxFixed, PosDecode,
                     0x0000,             // Granularity
                     0x0000,             // Range Minimum
                     0x007F,             // Range Maximum
                     0x0000,             // Translation Offset
                     0x0080,             // Length
                     ,, )
                 DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                     0x00000000,         // Granularity
                     0x10000000,         // Range Minimum
                     0x3EFEFFFF,         // Range Maximum
                     0x00000000,         // Translation Offset
@@ -3025,34 +3025,34 @@
                     }
                 }

                 Return (Buffer (One)
                 {
                      0x00                                             // .
                 })
             }

             Device (RES0)
             {
                 Name (_HID, "PNP0C02" /* PNP Motherboard Resources */)  // _HID: Hardware ID
                 Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                 {
                     QWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                         0x0000000000000000, // Granularity
-                        0x0000004010000000, // Range Minimum
-                        0x000000401FFFFFFF, // Range Maximum
+                        0x0000000090000000, // Range Minimum
+                        0x000000009FFFFFFF, // Range Maximum
                         0x0000000000000000, // Translation Offset
                         0x0000000010000000, // Length
                         ,, , AddressRangeMemory, TypeStatic)
                 })
             }
         }

         Device (\_SB.GED)
         {
             Name (_HID, "ACPI0013" /* Generic Event Device */)  // _HID: Hardware ID
             Name (_UID, "GED")  // _UID: Unique ID
             Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
             {
                 Interrupt (ResourceConsumer, Edge, ActiveHigh, Exclusive, ,, )
                 {
                     0x00000029,
acpi-test: Warning! MCFG binary file mismatch. Actual [aml:/tmp/aml-X0H1E3], Expected [aml:tests/data/acpi/aarch64/virt/MCFG].
See source file tests/qtest/bios-tables-test.c for instructions on how to update expected files.
acpi-test: Warning! MCFG mismatch. Actual [asl:/tmp/asl-BVH1E3.dsl, aml:/tmp/aml-X0H1E3], Expected [asl:/tmp/asl-PZW0E3.dsl, aml:tests/data/acpi/aarch64/virt/MCFG].
--- /tmp/asl-PZW0E3.dsl 2025-10-27 19:13:10.090364665 +0900
+++ /tmp/asl-BVH1E3.dsl 2025-10-27 19:13:10.084206282 +0900
@@ -1,36 +1,36 @@
 /*
  * Intel ACPI Component Architecture
  * AML/ASL+ Disassembler version 20240322 (64-bit version)
  * Copyright (c) 2000 - 2023 Intel Corporation
  *
- * Disassembly of tests/data/acpi/aarch64/virt/MCFG
+ * Disassembly of /tmp/aml-X0H1E3
  *
  * ACPI Data Table [MCFG]
  *
  * Format: [HexOffset DecimalOffset ByteLength]  FieldName : FieldValue (in hex)
  */

 [000h 0000 004h]                   Signature : "MCFG"    [Memory Mapped Configuration Table]
 [004h 0004 004h]                Table Length : 0000003C
 [008h 0008 001h]                    Revision : 01
-[009h 0009 001h]                    Checksum : EC
+[009h 0009 001h]                    Checksum : AC
 [00Ah 0010 006h]                      Oem ID : "BOCHS "
 [010h 0016 008h]                Oem Table ID : "BXPC    "
 [018h 0024 004h]                Oem Revision : 00000001
 [01Ch 0028 004h]             Asl Compiler ID : "BXPC"
 [020h 0032 004h]       Asl Compiler Revision : 00000001

 [024h 0036 008h]                    Reserved : 0000000000000000

-[02Ch 0044 008h]                Base Address : 0000004010000000
+[02Ch 0044 008h]                Base Address : 0000000090000000
 [034h 0052 002h]        Segment Group Number : 0000
 [036h 0054 001h]            Start Bus Number : 00
 [037h 0055 001h]              End Bus Number : FF
 [038h 0056 004h]                    Reserved : 00000000

 Raw Table Data: Length 60 (0x3C)

-    0000: 4D 43 46 47 3C 00 00 00 01 EC 42 4F 43 48 53 20  // MCFG<.....BOCHS
+    0000: 4D 43 46 47 3C 00 00 00 01 AC 42 4F 43 48 53 20  // MCFG<.....BOCHS
     0010: 42 58 50 43 20 20 20 20 01 00 00 00 42 58 50 43  // BXPC    ....BXPC
-    0020: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 10  // ................
-    0030: 40 00 00 00 00 00 00 FF 00 00 00 00              // @...........
+    0020: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 90  // ................
+    0030: 00 00 00 00 00 00 00 FF 00 00 00 00              // ............
acpi-test: Warning! DSDT binary file mismatch. Actual [aml:/tmp/aml-VZH1E3], Expected [aml:tests/data/acpi/aarch64/virt/DSDT].
See source file tests/qtest/bios-tables-test.c for instructions on how to update expected files.
acpi-test: Warning! DSDT mismatch. Actual [asl:/tmp/asl-O600E3.dsl, aml:/tmp/aml-VZH1E3], Expected [asl:/tmp/asl-CIW1E3.dsl, aml:tests/data/acpi/aarch64/virt/DSDT].
--- /tmp/asl-CIW1E3.dsl 2025-10-27 19:13:10.106396252 +0900
+++ /tmp/asl-O600E3.dsl 2025-10-27 19:13:10.098394021 +0900
@@ -1,30 +1,30 @@
 /*
  * Intel ACPI Component Architecture
  * AML/ASL+ Disassembler version 20240322 (64-bit version)
  * Copyright (c) 2000 - 2023 Intel Corporation
  *
  * Disassembling to symbolic ASL+ operators
  *
- * Disassembly of tests/data/acpi/aarch64/virt/DSDT
+ * Disassembly of /tmp/aml-VZH1E3
  *
  * Original Table Header:
  *     Signature        "DSDT"
- *     Length           0x000014D9 (5337)
+ *     Length           0x000014D5 (5333)
  *     Revision         0x02
- *     Checksum         0xA4
+ *     Checksum         0xF6
  *     OEM ID           "BOCHS "
  *     OEM Table ID     "BXPC    "
  *     OEM Revision     0x00000001 (1)
  *     Compiler ID      "BXPC"
  *     Compiler Version 0x00000001 (1)
  */
 DefinitionBlock ("", "DSDT", 2, "BOCHS ", "BXPC    ", 0x00000001)
 {
     Scope (\_SB)
     {
         Device (C000)
         {
             Name (_HID, "ACPI0007" /* Processor Device */)  // _HID: Hardware ID
             Name (_UID, Zero)  // _UID: Unique ID
         }

@@ -1751,33 +1751,33 @@
                     0x001FFFFF,
                     0x02,
                     L001,
                     Zero
                 },

                 Package (0x04)
                 {
                     0x001FFFFF,
                     0x03,
                     L002,
                     Zero
                 }
             })
             Method (_CBA, 0, NotSerialized)  // _CBA: Configuration Base Address
             {
-                Return (0x0000004010000000)
+                Return (0x90000000)
             }

             Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
             {
                 WordBusNumber (ResourceProducer, MinFixed, MaxFixed, PosDecode,
                     0x0000,             // Granularity
                     0x0000,             // Range Minimum
                     0x00FF,             // Range Maximum
                     0x0000,             // Translation Offset
                     0x0100,             // Length
                     ,, )
                 DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                     0x00000000,         // Granularity
                     0x10000000,         // Range Minimum
                     0x3EFEFFFF,         // Range Maximum
                     0x00000000,         // Translation Offset
@@ -1840,34 +1840,34 @@
                     }
                 }

                 Return (Buffer (One)
                 {
                      0x00                                             // .
                 })
             }

             Device (RES0)
             {
                 Name (_HID, "PNP0C02" /* PNP Motherboard Resources */)  // _HID: Hardware ID
                 Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                 {
                     QWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                         0x0000000000000000, // Granularity
-                        0x0000004010000000, // Range Minimum
-                        0x000000401FFFFFFF, // Range Maximum
+                        0x0000000090000000, // Range Minimum
+                        0x000000009FFFFFFF, // Range Maximum
                         0x0000000000000000, // Translation Offset
                         0x0000000010000000, // Length
                         ,, , AddressRangeMemory, TypeStatic)
                 })
             }
         }

         Device (\_SB.GED)
         {
             Name (_HID, "ACPI0013" /* Generic Event Device */)  // _HID: Hardware ID
             Name (_UID, "GED")  // _UID: Unique ID
             Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
             {
                 Interrupt (ResourceConsumer, Edge, ActiveHigh, Exclusive, ,, )
                 {
                     0x00000029,
acpi-test: Warning! MCFG binary file mismatch. Actual [aml:/tmp/aml-Y330E3], Expected [aml:tests/data/acpi/aarch64/virt/MCFG].
See source file tests/qtest/bios-tables-test.c for instructions on how to update expected files.
acpi-test: Warning! MCFG mismatch. Actual [asl:/tmp/asl-2M40E3.dsl, aml:/tmp/aml-Y330E3], Expected [asl:/tmp/asl-KN11E3.dsl, aml:tests/data/acpi/aarch64/virt/MCFG].
--- /tmp/asl-KN11E3.dsl 2025-10-27 19:13:23.114865240 +0900
+++ /tmp/asl-2M40E3.dsl 2025-10-27 19:13:23.106206670 +0900
@@ -1,36 +1,36 @@
 /*
  * Intel ACPI Component Architecture
  * AML/ASL+ Disassembler version 20240322 (64-bit version)
  * Copyright (c) 2000 - 2023 Intel Corporation
  *
- * Disassembly of tests/data/acpi/aarch64/virt/MCFG
+ * Disassembly of /tmp/aml-Y330E3
  *
  * ACPI Data Table [MCFG]
  *
  * Format: [HexOffset DecimalOffset ByteLength]  FieldName : FieldValue (in hex)
  */

 [000h 0000 004h]                   Signature : "MCFG"    [Memory Mapped Configuration Table]
 [004h 0004 004h]                Table Length : 0000003C
 [008h 0008 001h]                    Revision : 01
-[009h 0009 001h]                    Checksum : EC
+[009h 0009 001h]                    Checksum : AC
 [00Ah 0010 006h]                      Oem ID : "BOCHS "
 [010h 0016 008h]                Oem Table ID : "BXPC    "
 [018h 0024 004h]                Oem Revision : 00000001
 [01Ch 0028 004h]             Asl Compiler ID : "BXPC"
 [020h 0032 004h]       Asl Compiler Revision : 00000001

 [024h 0036 008h]                    Reserved : 0000000000000000

-[02Ch 0044 008h]                Base Address : 0000004010000000
+[02Ch 0044 008h]                Base Address : 0000000090000000
 [034h 0052 002h]        Segment Group Number : 0000
 [036h 0054 001h]            Start Bus Number : 00
 [037h 0055 001h]              End Bus Number : FF
 [038h 0056 004h]                    Reserved : 00000000

 Raw Table Data: Length 60 (0x3C)

-    0000: 4D 43 46 47 3C 00 00 00 01 EC 42 4F 43 48 53 20  // MCFG<.....BOCHS
+    0000: 4D 43 46 47 3C 00 00 00 01 AC 42 4F 43 48 53 20  // MCFG<.....BOCHS
     0010: 42 58 50 43 20 20 20 20 01 00 00 00 42 58 50 43  // BXPC    ....BXPC
-    0020: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 10  // ................
-    0030: 40 00 00 00 00 00 00 FF 00 00 00 00              // @...........
+    0020: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 90  // ................
+    0030: 00 00 00 00 00 00 00 FF 00 00 00 00              // ............
acpi-test: Warning! DSDT binary file mismatch. Actual [aml:/tmp/aml-JY30E3], Expected [aml:tests/data/acpi/aarch64/virt/DSDT.viot].
See source file tests/qtest/bios-tables-test.c for instructions on how to update expected files.
acpi-test: Warning! DSDT mismatch. Actual [asl:/tmp/asl-V8J1E3.dsl, aml:/tmp/aml-JY30E3], Expected [asl:/tmp/asl-0HU1E3.dsl, aml:tests/data/acpi/aarch64/virt/DSDT.viot].
--- /tmp/asl-0HU1E3.dsl 2025-10-27 19:13:23.138499055 +0900
+++ /tmp/asl-V8J1E3.dsl 2025-10-27 19:13:23.126498958 +0900
@@ -1,30 +1,30 @@
 /*
  * Intel ACPI Component Architecture
  * AML/ASL+ Disassembler version 20240322 (64-bit version)
  * Copyright (c) 2000 - 2023 Intel Corporation
  *
  * Disassembling to symbolic ASL+ operators
  *
- * Disassembly of tests/data/acpi/aarch64/virt/DSDT.viot
+ * Disassembly of /tmp/aml-JY30E3
  *
  * Original Table Header:
  *     Signature        "DSDT"
- *     Length           0x000014EA (5354)
+ *     Length           0x000014E6 (5350)
  *     Revision         0x02
- *     Checksum         0x46
+ *     Checksum         0x98
  *     OEM ID           "BOCHS "
  *     OEM Table ID     "BXPC    "
  *     OEM Revision     0x00000001 (1)
  *     Compiler ID      "BXPC"
  *     Compiler Version 0x00000001 (1)
  */
 DefinitionBlock ("", "DSDT", 2, "BOCHS ", "BXPC    ", 0x00000001)
 {
     Scope (\_SB)
     {
         Device (C000)
         {
             Name (_HID, "ACPI0007" /* Processor Device */)  // _HID: Hardware ID
             Name (_UID, Zero)  // _UID: Unique ID
         }

@@ -1751,33 +1751,33 @@
                     0x001FFFFF,
                     0x02,
                     L001,
                     Zero
                 },

                 Package (0x04)
                 {
                     0x001FFFFF,
                     0x03,
                     L002,
                     Zero
                 }
             })
             Method (_CBA, 0, NotSerialized)  // _CBA: Configuration Base Address
             {
-                Return (0x0000004010000000)
+                Return (0x90000000)
             }

             Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
             {
                 WordBusNumber (ResourceProducer, MinFixed, MaxFixed, PosDecode,
                     0x0000,             // Granularity
                     0x0000,             // Range Minimum
                     0x00FF,             // Range Maximum
                     0x0000,             // Translation Offset
                     0x0100,             // Length
                     ,, )
                 DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                     0x00000000,         // Granularity
                     0x10000000,         // Range Minimum
                     0x3EFEFFFF,         // Range Maximum
                     0x00000000,         // Translation Offset
@@ -1840,34 +1840,34 @@
                     }
                 }

                 Return (Buffer (One)
                 {
                      0x00                                             // .
                 })
             }

             Device (RES0)
             {
                 Name (_HID, "PNP0C02" /* PNP Motherboard Resources */)  // _HID: Hardware ID
                 Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                 {
                     QWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                         0x0000000000000000, // Granularity
-                        0x0000004010000000, // Range Minimum
-                        0x000000401FFFFFFF, // Range Maximum
+                        0x0000000090000000, // Range Minimum
+                        0x000000009FFFFFFF, // Range Maximum
                         0x0000000000000000, // Translation Offset
                         0x0000000010000000, // Length
                         ,, , AddressRangeMemory, TypeStatic)
                 })
             }
         }

         Device (\_SB.GED)
         {
             Name (_HID, "ACPI0013" /* Generic Event Device */)  // _HID: Hardware ID
             Name (_UID, "GED")  // _UID: Unique ID
             Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
             {
                 Interrupt (ResourceConsumer, Edge, ActiveHigh, Exclusive, ,, )
                 {
                     0x00000029,
acpi-test: Warning! MCFG binary file mismatch. Actual [aml:/tmp/aml-N9D3E3], Expected [aml:tests/data/acpi/aarch64/virt/MCFG].
See source file tests/qtest/bios-tables-test.c for instructions on how to update expected files.
acpi-test: Warning! MCFG mismatch. Actual [asl:/tmp/asl-28D3E3.dsl, aml:/tmp/aml-N9D3E3], Expected [asl:/tmp/asl-IDJ3E3.dsl, aml:tests/data/acpi/aarch64/virt/MCFG].
--- /tmp/asl-IDJ3E3.dsl 2025-10-27 19:13:41.049946243 +0900
+++ /tmp/asl-28D3E3.dsl 2025-10-27 19:13:41.044788785 +0900
@@ -1,36 +1,36 @@
 /*
  * Intel ACPI Component Architecture
  * AML/ASL+ Disassembler version 20240322 (64-bit version)
  * Copyright (c) 2000 - 2023 Intel Corporation
  *
- * Disassembly of tests/data/acpi/aarch64/virt/MCFG
+ * Disassembly of /tmp/aml-N9D3E3
  *
  * ACPI Data Table [MCFG]
  *
  * Format: [HexOffset DecimalOffset ByteLength]  FieldName : FieldValue (in hex)
  */

 [000h 0000 004h]                   Signature : "MCFG"    [Memory Mapped Configuration Table]
 [004h 0004 004h]                Table Length : 0000003C
 [008h 0008 001h]                    Revision : 01
-[009h 0009 001h]                    Checksum : EC
+[009h 0009 001h]                    Checksum : AC
 [00Ah 0010 006h]                      Oem ID : "BOCHS "
 [010h 0016 008h]                Oem Table ID : "BXPC    "
 [018h 0024 004h]                Oem Revision : 00000001
 [01Ch 0028 004h]             Asl Compiler ID : "BXPC"
 [020h 0032 004h]       Asl Compiler Revision : 00000001

 [024h 0036 008h]                    Reserved : 0000000000000000

-[02Ch 0044 008h]                Base Address : 0000004010000000
+[02Ch 0044 008h]                Base Address : 0000000090000000
 [034h 0052 002h]        Segment Group Number : 0000
 [036h 0054 001h]            Start Bus Number : 00
 [037h 0055 001h]              End Bus Number : FF
 [038h 0056 004h]                    Reserved : 00000000

 Raw Table Data: Length 60 (0x3C)

-    0000: 4D 43 46 47 3C 00 00 00 01 EC 42 4F 43 48 53 20  // MCFG<.....BOCHS
+    0000: 4D 43 46 47 3C 00 00 00 01 AC 42 4F 43 48 53 20  // MCFG<.....BOCHS
     0010: 42 58 50 43 20 20 20 20 01 00 00 00 42 58 50 43  // BXPC    ....BXPC
-    0020: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 10  // ................
-    0030: 40 00 00 00 00 00 00 FF 00 00 00 00              // @...........
+    0020: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 90  // ................
+    0030: 00 00 00 00 00 00 00 FF 00 00 00 00              // ............
acpi-test: Warning! DSDT binary file mismatch. Actual [aml:/tmp/aml-IAE3E3], Expected [aml:tests/data/acpi/aarch64/virt/DSDT.smmuv3-legacy].
See source file tests/qtest/bios-tables-test.c for instructions on how to update expected files.
acpi-test: Warning! DSDT mismatch. Actual [asl:/tmp/asl-TY02E3.dsl, aml:/tmp/aml-IAE3E3], Expected [asl:/tmp/asl-5U62E3.dsl, aml:tests/data/acpi/aarch64/virt/DSDT.smmuv3-legacy].
--- /tmp/asl-5U62E3.dsl 2025-10-27 19:13:41.068643477 +0900
+++ /tmp/asl-TY02E3.dsl 2025-10-27 19:13:41.058643396 +0900
@@ -1,30 +1,30 @@
 /*
  * Intel ACPI Component Architecture
  * AML/ASL+ Disassembler version 20240322 (64-bit version)
  * Copyright (c) 2000 - 2023 Intel Corporation
  *
  * Disassembling to symbolic ASL+ operators
  *
- * Disassembly of tests/data/acpi/aarch64/virt/DSDT.smmuv3-legacy
+ * Disassembly of /tmp/aml-IAE3E3
  *
  * Original Table Header:
  *     Signature        "DSDT"
- *     Length           0x00002822 (10274)
+ *     Length           0x0000281E (10270)
  *     Revision         0x02
- *     Checksum         0xA8
+ *     Checksum         0xFA
  *     OEM ID           "BOCHS "
  *     OEM Table ID     "BXPC    "
  *     OEM Revision     0x00000001 (1)
  *     Compiler ID      "BXPC"
  *     Compiler Version 0x00000001 (1)
  */
 DefinitionBlock ("", "DSDT", 2, "BOCHS ", "BXPC    ", 0x00000001)
 {
     Scope (\_SB)
     {
         Device (C000)
         {
             Name (_HID, "ACPI0007" /* Processor Device */)  // _HID: Hardware ID
             Name (_UID, Zero)  // _UID: Unique ID
         }

@@ -4121,33 +4121,33 @@
                     0x001FFFFF,
                     0x02,
                     L001,
                     Zero
                 },

                 Package (0x04)
                 {
                     0x001FFFFF,
                     0x03,
                     L002,
                     Zero
                 }
             })
             Method (_CBA, 0, NotSerialized)  // _CBA: Configuration Base Address
             {
-                Return (0x0000004010000000)
+                Return (0x90000000)
             }

             Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
             {
                 WordBusNumber (ResourceProducer, MinFixed, MaxFixed, PosDecode,
                     0x0000,             // Granularity
                     0x0000,             // Range Minimum
                     0x000F,             // Range Maximum
                     0x0000,             // Translation Offset
                     0x0010,             // Length
                     ,, )
                 DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                     0x00000000,         // Granularity
                     0x10000000,         // Range Minimum
                     0x3EFEFFFF,         // Range Maximum
                     0x00000000,         // Translation Offset
@@ -4210,34 +4210,34 @@
                     }
                 }

                 Return (Buffer (One)
                 {
                      0x00                                             // .
                 })
             }

             Device (RES0)
             {
                 Name (_HID, "PNP0C02" /* PNP Motherboard Resources */)  // _HID: Hardware ID
                 Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                 {
                     QWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                         0x0000000000000000, // Granularity
-                        0x0000004010000000, // Range Minimum
-                        0x000000401FFFFFFF, // Range Maximum
+                        0x0000000090000000, // Range Minimum
+                        0x000000009FFFFFFF, // Range Maximum
                         0x0000000000000000, // Translation Offset
                         0x0000000010000000, // Length
                         ,, , AddressRangeMemory, TypeStatic)
                 })
             }
         }

         Device (\_SB.GED)
         {
             Name (_HID, "ACPI0013" /* Generic Event Device */)  // _HID: Hardware ID
             Name (_UID, "GED")  // _UID: Unique ID
             Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
             {
                 Interrupt (ResourceConsumer, Edge, ActiveHigh, Exclusive, ,, )
                 {
                     0x00000029,
acpi-test: Warning! MCFG binary file mismatch. Actual [aml:/tmp/aml-LL7GE3], Expected [aml:tests/data/acpi/aarch64/virt/MCFG].
See source file tests/qtest/bios-tables-test.c for instructions on how to update expected files.
acpi-test: Warning! MCFG mismatch. Actual [asl:/tmp/asl-XC7GE3.dsl, aml:/tmp/aml-LL7GE3], Expected [asl:/tmp/asl-NUV2E3.dsl, aml:tests/data/acpi/aarch64/virt/MCFG].
--- /tmp/asl-NUV2E3.dsl 2025-10-27 19:13:59.023594515 +0900
+++ /tmp/asl-XC7GE3.dsl 2025-10-27 19:13:59.013437933 +0900
@@ -1,36 +1,36 @@
 /*
  * Intel ACPI Component Architecture
  * AML/ASL+ Disassembler version 20240322 (64-bit version)
  * Copyright (c) 2000 - 2023 Intel Corporation
  *
- * Disassembly of tests/data/acpi/aarch64/virt/MCFG
+ * Disassembly of /tmp/aml-LL7GE3
  *
  * ACPI Data Table [MCFG]
  *
  * Format: [HexOffset DecimalOffset ByteLength]  FieldName : FieldValue (in hex)
  */

 [000h 0000 004h]                   Signature : "MCFG"    [Memory Mapped Configuration Table]
 [004h 0004 004h]                Table Length : 0000003C
 [008h 0008 001h]                    Revision : 01
-[009h 0009 001h]                    Checksum : EC
+[009h 0009 001h]                    Checksum : AC
 [00Ah 0010 006h]                      Oem ID : "BOCHS "
 [010h 0016 008h]                Oem Table ID : "BXPC    "
 [018h 0024 004h]                Oem Revision : 00000001
 [01Ch 0028 004h]             Asl Compiler ID : "BXPC"
 [020h 0032 004h]       Asl Compiler Revision : 00000001

 [024h 0036 008h]                    Reserved : 0000000000000000

-[02Ch 0044 008h]                Base Address : 0000004010000000
+[02Ch 0044 008h]                Base Address : 0000000090000000
 [034h 0052 002h]        Segment Group Number : 0000
 [036h 0054 001h]            Start Bus Number : 00
 [037h 0055 001h]              End Bus Number : FF
 [038h 0056 004h]                    Reserved : 00000000

 Raw Table Data: Length 60 (0x3C)

-    0000: 4D 43 46 47 3C 00 00 00 01 EC 42 4F 43 48 53 20  // MCFG<.....BOCHS
+    0000: 4D 43 46 47 3C 00 00 00 01 AC 42 4F 43 48 53 20  // MCFG<.....BOCHS
     0010: 42 58 50 43 20 20 20 20 01 00 00 00 42 58 50 43  // BXPC    ....BXPC
-    0020: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 10  // ................
-    0030: 40 00 00 00 00 00 00 FF 00 00 00 00              // @...........
+    0020: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 90  // ................
+    0030: 00 00 00 00 00 00 00 FF 00 00 00 00              // ............
acpi-test: Warning! DSDT binary file mismatch. Actual [aml:/tmp/aml-WG7GE3], Expected [aml:tests/data/acpi/aarch64/virt/DSDT.smmuv3-dev].
See source file tests/qtest/bios-tables-test.c for instructions on how to update expected files.
acpi-test: Warning! DSDT mismatch. Actual [asl:/tmp/asl-0EG2E3.dsl, aml:/tmp/aml-WG7GE3], Expected [asl:/tmp/asl-GTD3E3.dsl, aml:tests/data/acpi/aarch64/virt/DSDT.smmuv3-dev].
--- /tmp/asl-GTD3E3.dsl 2025-10-27 19:13:59.043788261 +0900
+++ /tmp/asl-0EG2E3.dsl 2025-10-27 19:13:59.033788180 +0900
@@ -1,30 +1,30 @@
 /*
  * Intel ACPI Component Architecture
  * AML/ASL+ Disassembler version 20240322 (64-bit version)
  * Copyright (c) 2000 - 2023 Intel Corporation
  *
  * Disassembling to symbolic ASL+ operators
  *
- * Disassembly of tests/data/acpi/aarch64/virt/DSDT.smmuv3-dev
+ * Disassembly of /tmp/aml-WG7GE3
  *
  * Original Table Header:
  *     Signature        "DSDT"
- *     Length           0x00002822 (10274)
+ *     Length           0x0000281E (10270)
  *     Revision         0x02
- *     Checksum         0xA8
+ *     Checksum         0xFA
  *     OEM ID           "BOCHS "
  *     OEM Table ID     "BXPC    "
  *     OEM Revision     0x00000001 (1)
  *     Compiler ID      "BXPC"
  *     Compiler Version 0x00000001 (1)
  */
 DefinitionBlock ("", "DSDT", 2, "BOCHS ", "BXPC    ", 0x00000001)
 {
     Scope (\_SB)
     {
         Device (C000)
         {
             Name (_HID, "ACPI0007" /* Processor Device */)  // _HID: Hardware ID
             Name (_UID, Zero)  // _UID: Unique ID
         }

@@ -4121,33 +4121,33 @@
                     0x001FFFFF,
                     0x02,
                     L001,
                     Zero
                 },

                 Package (0x04)
                 {
                     0x001FFFFF,
                     0x03,
                     L002,
                     Zero
                 }
             })
             Method (_CBA, 0, NotSerialized)  // _CBA: Configuration Base Address
             {
-                Return (0x0000004010000000)
+                Return (0x90000000)
             }

             Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
             {
                 WordBusNumber (ResourceProducer, MinFixed, MaxFixed, PosDecode,
                     0x0000,             // Granularity
                     0x0000,             // Range Minimum
                     0x000F,             // Range Maximum
                     0x0000,             // Translation Offset
                     0x0010,             // Length
                     ,, )
                 DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                     0x00000000,         // Granularity
                     0x10000000,         // Range Minimum
                     0x3EFEFFFF,         // Range Maximum
                     0x00000000,         // Translation Offset
@@ -4210,34 +4210,34 @@
                     }
                 }

                 Return (Buffer (One)
                 {
                      0x00                                             // .
                 })
             }

             Device (RES0)
             {
                 Name (_HID, "PNP0C02" /* PNP Motherboard Resources */)  // _HID: Hardware ID
                 Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                 {
                     QWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                         0x0000000000000000, // Granularity
-                        0x0000004010000000, // Range Minimum
-                        0x000000401FFFFFFF, // Range Maximum
+                        0x0000000090000000, // Range Minimum
+                        0x000000009FFFFFFF, // Range Maximum
                         0x0000000000000000, // Translation Offset
                         0x0000000010000000, // Length
                         ,, , AddressRangeMemory, TypeStatic)
                 })
             }
         }

         Device (\_SB.GED)
         {
             Name (_HID, "ACPI0013" /* Generic Event Device */)  // _HID: Hardware ID
             Name (_UID, "GED")  // _UID: Unique ID
             Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
             {
                 Interrupt (ResourceConsumer, Edge, ActiveHigh, Exclusive, ,, )
                 {
                     0x00000029,

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 tests/qtest/bios-tables-test-allowed-diff.h      |  11 -----------
 tests/data/acpi/aarch64/virt/DSDT                | Bin 5337 -> 5333 bytes
 tests/data/acpi/aarch64/virt/DSDT.acpihmatvirt   | Bin 5423 -> 5419 bytes
 tests/data/acpi/aarch64/virt/DSDT.acpipcihp      | Bin 6246 -> 6242 bytes
 tests/data/acpi/aarch64/virt/DSDT.hpoffacpiindex | Bin 5391 -> 5387 bytes
 tests/data/acpi/aarch64/virt/DSDT.memhp          | Bin 6698 -> 6698 bytes
 tests/data/acpi/aarch64/virt/DSDT.pxb            | Bin 7812 -> 7808 bytes
 tests/data/acpi/aarch64/virt/DSDT.smmuv3-dev     | Bin 10274 -> 10270 bytes
 tests/data/acpi/aarch64/virt/DSDT.smmuv3-legacy  | Bin 10274 -> 10270 bytes
 tests/data/acpi/aarch64/virt/DSDT.topology       | Bin 5539 -> 5535 bytes
 tests/data/acpi/aarch64/virt/DSDT.viot           | Bin 5354 -> 5350 bytes
 tests/data/acpi/aarch64/virt/MCFG                | Bin 60 -> 60 bytes
 tests/data/acpi/aarch64/virt/MCFG.memhp          | Bin 0 -> 60 bytes
 13 files changed, 11 deletions(-)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index efb00724d09f..dfb8523c8bf4 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,12 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/aarch64/virt/DSDT",
-"tests/data/acpi/aarch64/virt/DSDT.acpihmatvirt",
-"tests/data/acpi/aarch64/virt/DSDT.acpipcihp",
-"tests/data/acpi/aarch64/virt/DSDT.hpoffacpiindex",
-"tests/data/acpi/aarch64/virt/DSDT.memhp",
-"tests/data/acpi/aarch64/virt/DSDT.pxb",
-"tests/data/acpi/aarch64/virt/DSDT.smmuv3-dev",
-"tests/data/acpi/aarch64/virt/DSDT.smmuv3-legacy",
-"tests/data/acpi/aarch64/virt/DSDT.topology",
-"tests/data/acpi/aarch64/virt/DSDT.viot",
-"tests/data/acpi/aarch64/virt/MCFG",
diff --git a/tests/data/acpi/aarch64/virt/DSDT b/tests/data/acpi/aarch64/virt/DSDT
index 38f01adb61e6e4704821cee5e397888bb6b7e46d..bafee1ad5569096de297ae6279ecff11573e370f 100644
GIT binary patch
delta 65
zcmV-H0KWg(Db*<oL{mgm)f4~#0``##8v%*2CPxYZMzd}Tp$7~MUqeDc0Hh26005A)
X9}-ys3XlK*00960|DOP}f)iH(cbO9|

delta 69
zcmcbrc~g_iCD<k8rU(NA(~^l?(u}<u)!exly*B4@Eo2uEh<A2!WLUz-z`!8jz`($;
WSz0KPkqgZH|Np<d!{$2Sa7F-)3lb^-

diff --git a/tests/data/acpi/aarch64/virt/DSDT.acpihmatvirt b/tests/data/acpi/aarch64/virt/DSDT.acpihmatvirt
index 37a9af713b94a3fd34907dc86c40aaa79e93239c..88cfd3d76415b498dae67b9838d020ed118e9710 100644
GIT binary patch
delta 66
zcmV-I0KNaODyu3AL{mgmD-{3$0<w_`8v>6<u_v4g0Y<aL3ZVxK3|~V+K>(x-0001x
Yvvm?#0Sb@+00030|Nox=v)B_?0cQadl>h($

delta 70
zcmZ3jwO)(MCD<iIUzCA?DSslDG*h$3M)f&dj9#0Ma4lpP5Qukna%5P-$H2fK;K0DZ
Xu(?nul93C{{Qv*Iyu;=z!r_bndtVZf

diff --git a/tests/data/acpi/aarch64/virt/DSDT.acpipcihp b/tests/data/acpi/aarch64/virt/DSDT.acpipcihp
index 04427e2d8eb8d2db0a7ae3dbe546d9072406d09b..7879b2011ba8e700150dff1a1efae85fb902c596 100644
GIT binary patch
delta 65
zcmV-H0KWg`Fyb%@L{mgmVi*7b0>Y6B8v%#0CPxYZMzd}Tp$7~MUqeDc0Hh26005A)
X9}-ys3XlK*00960|DOP}f)nHfU!)U3

delta 69
zcmaE4@XUbACD<h-O@e`esbC_PG-LNhHFqvXug!T}3)uw(;+>rw8J6%dFfa%>FfcG|
WmKKU+<N`DQ|Nk%Vu(?k72@3#oA`(3S

diff --git a/tests/data/acpi/aarch64/virt/DSDT.hpoffacpiindex b/tests/data/acpi/aarch64/virt/DSDT.hpoffacpiindex
index 43ab60496e5a06706d4626d9e7b58b2d7e809e75..469e24bd2dfb4e5753a80f34910a3e3c55c82180 100644
GIT binary patch
delta 65
zcmeCz>ek|N33dtL7G+>ynmdt8nz3`EnmZSx+vYs3h3q^$@y<?;3`=+z7#JpOmKTa-
V<eI?1z`*eT|Nr?6o127t837f~5wHLN

delta 69
zcmeCy>eu3O33dtL7iC~z@}9^g&Dgt9&7F(UYjYmgLUsXxcxNX^h9!Iq3=9Ge3=9mL
WrG+9Hxxmc-|NqN7Y_1dTWdr~uaS*Hk

diff --git a/tests/data/acpi/aarch64/virt/DSDT.memhp b/tests/data/acpi/aarch64/virt/DSDT.memhp
index 3c391674446167bc9c79fd5dcb1c37e80cc7bbae..11dddd1cb4ee743f3a96ca0f3733aeaa123ec2f7 100644
GIT binary patch
delta 43
zcmZ2wvdV<ZCD<iIONxPkNnj(FfDqFJ#?3N9F^pUj7#SEC{{R0!pK)`O@Cr5n?RE?(

delta 43
zcmZ2wvdV<ZCD<iIONxPk>GDP{0U;&<hs`oVF^pUS4h#$o|NsA&ci7w{yn+n?_hSqw

diff --git a/tests/data/acpi/aarch64/virt/DSDT.pxb b/tests/data/acpi/aarch64/virt/DSDT.pxb
index 71c632cedcca63a77a4cdde53d9bc392102687b6..e953e254d9177a8b74a5bf11bd9dd72f3d224f7d 100644
GIT binary patch
delta 65
zcmV-H0KWf(J%Bw5L{mgmfF1w<0%eg38v%x~Ce#xFMzi}9p$7~MUqeDc0Hh26005A)
XtQ%PY3XlK*00960|DOP}4;^&@VzU!O

delta 69
zcmZp$ZL#HY33dr-kz-(B5}wE<&Dgb3?TRp?*XG~C3)uw(;+>rw8J6%dFfa%>FfcG|
WULhUH$OUHp|Nmd!VKcXEDI)-PQ4&A^

diff --git a/tests/data/acpi/aarch64/virt/DSDT.smmuv3-dev b/tests/data/acpi/aarch64/virt/DSDT.smmuv3-dev
index e8c2b376df7bddc2392945ea8cbb550b3d3b5e26..9adacac2ecf04c737c055936a365b60e4e8b7419 100644
GIT binary patch
delta 73
zcmV-P0Ji_4P@Yf<L{mgm9w-0+0{W2(8v%o{CSe@~Mv_oNNt6E*AG50+eg_N;UqeDc
f0Hh26005A)IVD*E3XlK*00960|DOP}oF;|=Bw`kV

delta 77
zcmbOiuqc4bCD<iINrQobX~je?X~y=AYKgL}UXucxJtzMcmfyTuwvJsuAl})@kzolR
f0|SGA0|NuYW>eKjMlLY(|NsB;4x4AFwJ`z!LeLd{

diff --git a/tests/data/acpi/aarch64/virt/DSDT.smmuv3-legacy b/tests/data/acpi/aarch64/virt/DSDT.smmuv3-legacy
index e8c2b376df7bddc2392945ea8cbb550b3d3b5e26..9adacac2ecf04c737c055936a365b60e4e8b7419 100644
GIT binary patch
delta 73
zcmV-P0Ji_4P@Yf<L{mgm9w-0+0{W2(8v%o{CSe@~Mv_oNNt6E*AG50+eg_N;UqeDc
f0Hh26005A)IVD*E3XlK*00960|DOP}oF;|=Bw`kV

delta 77
zcmbOiuqc4bCD<iINrQobX~je?X~y=AYKgL}UXucxJtzMcmfyTuwvJsuAl})@kzolR
f0|SGA0|NuYW>eKjMlLY(|NsB;4x4AFwJ`z!LeLd{

diff --git a/tests/data/acpi/aarch64/virt/DSDT.topology b/tests/data/acpi/aarch64/virt/DSDT.topology
index 9f22cd3dc81efe3ebcb8caf913842a8dea910627..bc0eecf93c7ed9005fe0bd9872ae65fb34a75d1b 100644
GIT binary patch
delta 65
zcmV-H0KWgDE1xS0L{mgmpA`TA0_u?p8v%o{CJ_q(Mzc5zp$7~MUqeDc0Hh26005A)
X=@MB13XlK*00960|DOP}OcYlEOt2EF

delta 69
zcmbQQy;z&eCD<iou_yxr(~OB+(v0mJ)daa2y*68LFJu=Gh<A2!WLUz-z`!8jz`($;
W`KeGOBNv$Y|Nnn^hs_=$;fw%Xz7eJX

diff --git a/tests/data/acpi/aarch64/virt/DSDT.viot b/tests/data/acpi/aarch64/virt/DSDT.viot
index dd3775a0762ae1a5ddb89dd656d81eee581dccb6..fcae132d9e4ac74b44a068d210bb3ed9a7347829 100644
GIT binary patch
delta 65
zcmV-H0KWg~Dds5(L{mgm<`e(`0+^8s8v%*2CPxYZMzd}Tp$7~MUqeDc0Hh26005A)
X9}-ys3XlK*00960|DOP}f)i)~aXAwd

delta 69
zcmaE+`AU<^CD<k8l?Vd^liNftX~y1-YVKT&UYql{7P1Qn#5+4VGA!X^U|<k%U|?X_
WEG-nt$OUHp|Nmd!VRM~u1|tB4{}K=Y

diff --git a/tests/data/acpi/aarch64/virt/MCFG b/tests/data/acpi/aarch64/virt/MCFG
index f4ae3203a4e9258a397c9912332178640209637b..99e75f326c3c7fc3be5154c4667f34995e33dbc2 100644
GIT binary patch
delta 30
ecmcDq;qrBMbGKn&U|?J`kxP|#0s{p62T=f4aRlW6

delta 30
fcmcDq;qrBMbGKn&U|@VRkxP|Vz<~h_{)0#WS8)X8

diff --git a/tests/data/acpi/aarch64/virt/MCFG.memhp b/tests/data/acpi/aarch64/virt/MCFG.memhp
new file mode 100644
index 0000000000000000000000000000000000000000..360f1dbbea17e4857f1c26a172ff533eef446823
GIT binary patch
literal 60
ucmeZuc5}C3U|?We?d0$55v<@85#X$#prF9Wz`y`vgJ>i$0m}am5(5A*-UtBz

literal 0
HcmV?d00001


-- 
2.51.0


