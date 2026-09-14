Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 860E0C88E6F
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 09:40:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x63AU-0003rX-K7; Mon, 14 Sep 2026 05:40:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1x63AS-0003pG-Im; Mon, 14 Sep 2026 05:40:04 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1x63AN-0001Qo-4F; Mon, 14 Sep 2026 05:40:04 -0400
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.183]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 68E9ddc0024283
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 14 Sep 2026 18:39:43 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=1Y3vUbnPrVJUfdka901BPRpfkrcNnJ5SN1c7PMJr2a4=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1789378783; v=1;
 b=YXJwei4vfHC09HUu9VtRVO4hcyWnVe4X1pPWES8/xzX9zxYek5rFd32PUO9rklP4
 2A70D9JxZ2H3v5sNjnHfykhisOgZrOjzb8oUCsbVV9EEL+fqBk6bu2kbC4w7svz+
 gbrvpMcC8Gn5730WwUUwcuBq3Z3Trbng+0ac6k+3R+WW/SnltBjq4f0HeGd8F7r5
 F/WFScKTzi3rg1hc82lcpgFQ3F0TRLmbBpDzV6CqMirzn0WVZZ7VmK0+W7W/qD4D
 6Z0rUzVmFPpG+nNZE7YIcKF0kkbeMEiOYzZNhco3tzXbYQp0fojzWvw1y0McEy/T
 ymCtd589ul1nCowN5FliBg==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Mon, 14 Sep 2026 18:39:26 +0900
Subject: [PATCH v8 5/5] test/acpi: aarch64/virt: Update golden masters for
 DSDT and MCFG
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-virt-v8-5-7418578fef08@rsg.ci.i.u-tokyo.ac.jp>
References: <20260914-virt-v8-0-7418578fef08@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260914-virt-v8-0-7418578fef08@rsg.ci.i.u-tokyo.ac.jp>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Eric Auger <eric.auger@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Andrew Jones <andrew.jones@oss.qualcomm.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=64133;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=30PNzozOxf2onQBZasEsrm9Rr7o2FEH0uDBloczmnuE=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQ9byA7f2sk24weTOc++pQPll15dhR5rCl2aJh+f/3KbJv
 FbKYZpwRykLgxgXg6yYIktK0W5ujejaT4UJ8S0wc1iZQIYwcHEKwESuFDAynPfx7jbtbI+Qmn2a
 ZXLeaRvzGUsza95WBgrNW3HTcWPnCkaGpftveE1dVHTWTKNVaKf6nM9TPy896m71x1qU941jptR
 OJgA=
X-Developer-Key: i=odaki@rsg.ci.i.u-tokyo.ac.jp; a=openpgp;
 fpr=AEDC03C9AF734F2EC26A7BFFA4BAEAA73536753C
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

@@ -1,36 +1,36 @@
 /*
  * Intel ACPI Component Architecture
  * AML/ASL+ Disassembler version 20240322 (64-bit version)
  * Copyright (c) 2000 - 2023 Intel Corporation
  *
- * Disassembly of tests/data/acpi/aarch64/virt/MCFG
+ * Disassembly of /tmp/aml-EFVEJ3
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

@@ -1,30 +1,30 @@
 /*
  * Intel ACPI Component Architecture
  * AML/ASL+ Disassembler version 20240322 (64-bit version)
  * Copyright (c) 2000 - 2023 Intel Corporation
  *
  * Disassembling to symbolic ASL+ operators
  *
- * Disassembly of tests/data/acpi/aarch64/virt/DSDT
+ * Disassembly of /tmp/aml-5GVEJ3
  *
  * Original Table Header:
  *     Signature        "DSDT"
- *     Length           0x000014D9 (5337)
+ *     Length           0x000014D5 (5333)
  *     Revision         0x02
- *     Checksum         0xA5
+ *     Checksum         0xF7
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

@@ -1,30 +1,30 @@
 /*
  * Intel ACPI Component Architecture
  * AML/ASL+ Disassembler version 20240322 (64-bit version)
  * Copyright (c) 2000 - 2023 Intel Corporation
  *
  * Disassembling to symbolic ASL+ operators
  *
- * Disassembly of tests/data/acpi/aarch64/virt/DSDT.acpihmatvirt
+ * Disassembly of /tmp/aml-HQ03I3
  *
  * Original Table Header:
  *     Signature        "DSDT"
- *     Length           0x0000152F (5423)
+ *     Length           0x0000152B (5419)
  *     Revision         0x02
- *     Checksum         0x70
+ *     Checksum         0xB3
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

@@ -1,30 +1,30 @@
 /*
  * Intel ACPI Component Architecture
  * AML/ASL+ Disassembler version 20240322 (64-bit version)
  * Copyright (c) 2000 - 2023 Intel Corporation
  *
  * Disassembling to symbolic ASL+ operators
  *
- * Disassembly of tests/data/acpi/aarch64/virt/DSDT.topology
+ * Disassembly of /tmp/aml-UC05I3
  *
  * Original Table Header:
  *     Signature        "DSDT"
- *     Length           0x000015A3 (5539)
+ *     Length           0x0000159F (5535)
  *     Revision         0x02
- *     Checksum         0x99
+ *     Checksum         0xEB
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

@@ -1,30 +1,30 @@
 /*
  * Intel ACPI Component Architecture
  * AML/ASL+ Disassembler version 20240322 (64-bit version)
  * Copyright (c) 2000 - 2023 Intel Corporation
  *
  * Disassembling to symbolic ASL+ operators
  *
- * Disassembly of tests/data/acpi/aarch64/virt/DSDT
+ * Disassembly of /tmp/aml-TZRGJ3
  *
  * Original Table Header:
  *     Signature        "DSDT"
- *     Length           0x000014D9 (5337)
+ *     Length           0x000014D5 (5333)
  *     Revision         0x02
- *     Checksum         0xA5
+ *     Checksum         0xF7
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

@@ -1,30 +1,30 @@
 /*
  * Intel ACPI Component Architecture
  * AML/ASL+ Disassembler version 20240322 (64-bit version)
  * Copyright (c) 2000 - 2023 Intel Corporation
  *
  * Disassembling to symbolic ASL+ operators
  *
- * Disassembly of tests/data/acpi/aarch64/virt/DSDT
+ * Disassembly of /tmp/aml-9EZ4I3
  *
  * Original Table Header:
  *     Signature        "DSDT"
- *     Length           0x000014D9 (5337)
+ *     Length           0x000014D5 (5333)
  *     Revision         0x02
- *     Checksum         0xA5
+ *     Checksum         0xF7
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

@@ -1,30 +1,30 @@
 /*
  * Intel ACPI Component Architecture
  * AML/ASL+ Disassembler version 20240322 (64-bit version)
  * Copyright (c) 2000 - 2023 Intel Corporation
  *
  * Disassembling to symbolic ASL+ operators
  *
- * Disassembly of tests/data/acpi/aarch64/virt/DSDT.memhp
+ * Disassembly of /tmp/aml-32Q9I3
  *
  * Original Table Header:
  *     Signature        "DSDT"
  *     Length           0x00001A2A (6698)
  *     Revision         0x02
- *     Checksum         0xD4
+ *     Checksum         0x11
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

@@ -1,30 +1,30 @@
 /*
  * Intel ACPI Component Architecture
  * AML/ASL+ Disassembler version 20240322 (64-bit version)
  * Copyright (c) 2000 - 2023 Intel Corporation
  *
  * Disassembling to symbolic ASL+ operators
  *
- * Disassembly of tests/data/acpi/aarch64/virt/DSDT.acpipcihp
+ * Disassembly of /tmp/aml-DCVWI3
  *
  * Original Table Header:
  *     Signature        "DSDT"
- *     Length           0x00001866 (6246)
+ *     Length           0x00001862 (6242)
  *     Revision         0x02
- *     Checksum         0x71
+ *     Checksum         0xC3
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

@@ -1,30 +1,30 @@
 /*
  * Intel ACPI Component Architecture
  * AML/ASL+ Disassembler version 20240322 (64-bit version)
  * Copyright (c) 2000 - 2023 Intel Corporation
  *
  * Disassembling to symbolic ASL+ operators
  *
- * Disassembly of tests/data/acpi/aarch64/virt/DSDT.hpoffacpiindex
+ * Disassembly of /tmp/aml-KHOBJ3
  *
  * Original Table Header:
  *     Signature        "DSDT"
- *     Length           0x0000150F (5391)
+ *     Length           0x0000150B (5387)
  *     Revision         0x02
- *     Checksum         0x4C
+ *     Checksum         0x9E
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

@@ -1,30 +1,30 @@
 /*
  * Intel ACPI Component Architecture
  * AML/ASL+ Disassembler version 20240322 (64-bit version)
  * Copyright (c) 2000 - 2023 Intel Corporation
  *
  * Disassembling to symbolic ASL+ operators
  *
- * Disassembly of tests/data/acpi/aarch64/virt/DSDT.pxb
+ * Disassembly of /tmp/aml-FHLGJ3
  *
  * Original Table Header:
  *     Signature        "DSDT"
- *     Length           0x00001E84 (7812)
+ *     Length           0x00001E80 (7808)
  *     Revision         0x02
- *     Checksum         0x15
+ *     Checksum         0x67
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

@@ -1,30 +1,30 @@
 /*
  * Intel ACPI Component Architecture
  * AML/ASL+ Disassembler version 20240322 (64-bit version)
  * Copyright (c) 2000 - 2023 Intel Corporation
  *
  * Disassembling to symbolic ASL+ operators
  *
- * Disassembly of tests/data/acpi/aarch64/virt/DSDT
+ * Disassembly of /tmp/aml-BP7DJ3
  *
  * Original Table Header:
  *     Signature        "DSDT"
- *     Length           0x000014D9 (5337)
+ *     Length           0x000014D5 (5333)
  *     Revision         0x02
- *     Checksum         0xA5
+ *     Checksum         0xF7
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

@@ -1,30 +1,30 @@
 /*
  * Intel ACPI Component Architecture
  * AML/ASL+ Disassembler version 20240322 (64-bit version)
  * Copyright (c) 2000 - 2023 Intel Corporation
  *
  * Disassembling to symbolic ASL+ operators
  *
- * Disassembly of tests/data/acpi/aarch64/virt/DSDT.viot
+ * Disassembly of /tmp/aml-ARLYI3
  *
  * Original Table Header:
  *     Signature        "DSDT"
- *     Length           0x000014EA (5354)
+ *     Length           0x000014E6 (5350)
  *     Revision         0x02
- *     Checksum         0x47
+ *     Checksum         0x99
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

@@ -1,30 +1,30 @@
 /*
  * Intel ACPI Component Architecture
  * AML/ASL+ Disassembler version 20240322 (64-bit version)
  * Copyright (c) 2000 - 2023 Intel Corporation
  *
  * Disassembling to symbolic ASL+ operators
  *
- * Disassembly of tests/data/acpi/aarch64/virt/DSDT.smmuv3-legacy
+ * Disassembly of /tmp/aml-XDBZI3
  *
  * Original Table Header:
  *     Signature        "DSDT"
- *     Length           0x00002822 (10274)
+ *     Length           0x0000281E (10270)
  *     Revision         0x02
- *     Checksum         0xAB
+ *     Checksum         0xFD
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

@@ -1,30 +1,30 @@
 /*
  * Intel ACPI Component Architecture
  * AML/ASL+ Disassembler version 20240322 (64-bit version)
  * Copyright (c) 2000 - 2023 Intel Corporation
  *
  * Disassembling to symbolic ASL+ operators
  *
- * Disassembly of tests/data/acpi/aarch64/virt/DSDT.smmuv3-dev
+ * Disassembly of /tmp/aml-OB0ZI3
  *
  * Original Table Header:
  *     Signature        "DSDT"
- *     Length           0x00002822 (10274)
+ *     Length           0x0000281E (10270)
  *     Revision         0x02
- *     Checksum         0xAB
+ *     Checksum         0xFD
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
 tests/data/acpi/aarch64/virt/DSDT.11.1           | Bin 0 -> 5337 bytes
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
 tests/data/acpi/aarch64/virt/MCFG.11.1           | Bin 0 -> 60 bytes
 tests/data/acpi/aarch64/virt/MCFG.memhp          | Bin 0 -> 60 bytes
 15 files changed, 11 deletions(-)

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
index 35a862e44714d26ded01d40dc147e76cc73a1c84..649b1e78d57748d3d941c9b79d7d30cfb43ec7ca 100644
GIT binary patch
delta 65
zcmV-H0KWg(Db*<oL{mgm)f4~#0{4*$8v%*2CPxYZMzd}Tp$7~MUqeDc0Hh26005A)
X9}-ys3XlK*00960|DOP}f)iH(cgzzn

delta 69
zcmcbrc~g_iCD<k8rU(NA)6$7t(u}<u)!exly*B4@Eo2uEh<A2!WLUz-z`!8jz`($;
WSz0KPkqgZH|Np<d!{$2Sa7F-)LJ}(g

diff --git a/tests/data/acpi/aarch64/virt/DSDT.11.1 b/tests/data/acpi/aarch64/virt/DSDT.11.1
new file mode 100644
index 0000000000000000000000000000000000000000..35a862e44714d26ded01d40dc147e76cc73a1c84
GIT binary patch
literal 5337
zcmZvgOK%%h6oAjzV|zS)Wc)}RJ5KCEsdz?XyLq&<1$)Lx+}erpqz#fQjVn|{8y1$R
zkV=J=8mTRjSkMU8MhgD}i4{9`2(f0vA7F>koja49qn=qfzK`?W``w(8j<4<5`+w#E
zLO-|mtR1J?`nYdZtJSIk0OGs&Ykb#I?z&FP9ZpJ?X_}h5)3H-ctKTtAa|1N@cE^U{
z<f^sT3&sY$9n-AU{4ve722Q4=7oNpI0OMc)d>aKtxc~r<VK~{`I<U4R_oH_2wrQGm
z&|GJ~sV6kovYLuSWc0K|gyM^SWK+E}2)5MS9qgH=xpuznS>*ZRI)wbiO^m3?)hR+O
z`wAk25H%ms61%8#2tC9xRK%!bMuTO9IYtyQ8kljJWvCoOLyXIqvBokY979KpHOyFN
z8BvarM2vOJ*kBnkj*&);4b0eN85+kh5MvWFuCR<a$H*ea6~w6dF9%IAUFR5i#JGwX
zY?{)SBuMoI#CRVw_&iN=`&dMbYnZ|3X^LZ%5aT*#@Ohf%7-ht`ff;<B&T)(t#P|R+
z_&hZ@MintW#0)-9GaTbJ#Asp$pQl-laS<_En8D|1j$>Rx3=1*pe4gex#+!&?V+Nn6
z^Bm)C#Ass%pQj5P<6Xqq!VEr73mjt=F}5*-&(lSYVIsy3X7G7h<QR3t=wJq)rzMVY
z88L2R2A`)(9Ah0ZZea$Wr)7?@i5OkX;PZ5uV_Zdy9%3~3JYC@!*AQbDGx$8MaEu#>
zvF9^7YWJ)l>hJbV%iKCEKKcVElhzYno%6akUluX6FCTTCfujs1%HIw_DH=gtWKgp2
z40TiN%71$ZN)#h_TW>Hd*+*IaTSQr5%DTj`WZyaKW#8)f|24sCnw#QGI=0_xh?=jx
z4Vv3(?Vg>Zvp>jG^l~38=)irbf(ccy;XZr`58xBH4<I03nbsfd=el3$N7;m$n9V@^
zZ$N%mx~5r!Y*O^=A#prGBiuF324queayC;y#MI7OBB~DAv>fx|8s|+BY5H?RUS$2O
zB_e~VAsK1<ks<IRgH^&_WUzy<7a2?q%gCA^8J3a3DykP5>_GJ*gQ=>F3^uRI$Y7NS
z@r)492=$D}$Y7Ny@r)ABDD{j|&lvHH5ziR)j8RXGcxuE`qn;Y|j1$i|@r+Z?IQ7(t
zr%pU|>Zw!D1o2D|&jj^MP|qasOcKu|^-NOF6!A<E&lL4cQO`8-OcT#E^-NRGIpR4-
zJm;wA9Q8Dar$Iao>S<8V4Drkm&kXg<P|qy!%o5Km^~_Sw9P!K%&m8s4QO`W_%oEQ%
z^~_VxdEz-wJm;zBJoQ{4o(sftfqE`b&jRr*5YGbjEKtuy;<-pX7pdnW^(+$4BJnIz
z&m#3K5zi9wEK$!A^;{yJOT=@DdM;7VGVv@E&ocEaQ_p4MxlBBlspm5FTp^w-#B+su
zu29bk@vIQf3iYf6o_WKyT1_}ji(4P@`$kqQJ2Cyyixh;CAfB1{P@We6lHxK)JjQJH
zpZHlOMpvH~KuLyW3t;9=pWOgZ;P@RB<2^^-jG3H-9?}08^4*xb=UD3TAz1c7ZMqvd
z`7D#ujbZPv#=n*Fhd&-XYW{Nlk57*eb=9&D>c@w=X4wagvG^E08R?bL)OdOFK>1pP
zdt<d}?&XO$Ec*;GG9HPZpOUgmplYXw`S)Dg>8aBTa?Rg2e*4>5`>OYS;h$ddSF1OT
zpFD)qOjwa0!%0sav>jC3Sl$(uxcF-5<}2pj>CR@eia2HT7~;FQ5wo<rtK!aWyKTGj
z?m=F-)kKkWyJM%e+cqgE!^&GS^r$^(Z$lD5i|gv}X+kuuw$tub^Q&(A&VGC>8l$Ok
z@?@lo+T>aPV9?T!WJeYB>a*>(ZR<zFNl}c*)n)Bx`Bm9)QWSI0P{ZFB7+e0%MXi^=
z6=~Z}FEw31c?e^1TBB*{C4Zu)qiO7i2YTpqG}fQK7y+D)rsb1|dTgAHgdhc@@i#9%
f2e>!BCkKa<gkzen<~HpC3@3ArxhWe-k!$}0AN?LZ

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/aarch64/virt/DSDT.acpihmatvirt b/tests/data/acpi/aarch64/virt/DSDT.acpihmatvirt
index 7ce35f0d8606d17f3ddb9aa090c97c7ac9a38982..aa813cbcc4e8ac8ba7c68c3aac590eaa0eb90a28 100644
GIT binary patch
delta 66
zcmV-I0KNaODyu3AL{mgmD-{3$0<)0{8v>6<u_v4g0Y<aL3ZVxK3|~V+K>(x-0001x
Yvvm?#0Sb@+00030|Nox=v)B_?0cSN6mH+?%

delta 70
zcmZ3jwO)(MCD<iIUzCA?sbC_PG*h$3M)f&dj9#0Ma4lpP5Qukna%5P-$H2fK;K0DZ
Xu(?nul93C{{Qv*Iyu;=z!r_bndzTWD

diff --git a/tests/data/acpi/aarch64/virt/DSDT.acpipcihp b/tests/data/acpi/aarch64/virt/DSDT.acpipcihp
index 6d1765c31017dede80d1d87f8fa7c6dd055d1839..5bd4a06dd193f065e2b9d2686bb371ebb3bfc620 100644
GIT binary patch
delta 65
zcmV-H0KWg`Fyb%@L{mgmVi*7b0>hCC8v%#0CPxYZMzd}Tp$7~MUqeDc0Hh26005A)
X9}-ys3XlK*00960|DOP}f)nHfU)K{t

delta 69
zcmaE4@XUbACD<h-O@e`esc<5fG-LNhHFqvXug!T}3)uw(;+>rw8J6%dFfa%>FfcG|
WmKKU+<N`DQ|Nk%Vu(?k72@3#oSrR?~

diff --git a/tests/data/acpi/aarch64/virt/DSDT.hpoffacpiindex b/tests/data/acpi/aarch64/virt/DSDT.hpoffacpiindex
index 61cce30c7471faa4a9b7e3562dcb4ab9b3519a21..ec8ebbfdafabdd790297ec8728e9922c24c1b132 100644
GIT binary patch
delta 65
zcmeCz>ek|N33dtL7G+>ynm3V4nz3`EnmZSx+vYs3h3q^$@y<?;3`=+z7#JpOmKTa-
V<eI?1z`*eT|Nr?6o127t837go5wQRO

delta 69
zcmeCy>eu3O33dtL7iC~z@|nmb&Dgt9&7F(UYjYmgLUsXxcxNX^h9!Iq3=9Ge3=9mL
WrG+9Hxxmc-|NqN7Y_1dTWdr~us1U6H

diff --git a/tests/data/acpi/aarch64/virt/DSDT.memhp b/tests/data/acpi/aarch64/virt/DSDT.memhp
index ffc5f1c0d1090582672c60ade3eb1bc41acc5ef7..8a6cafac00d406077d6a369747c6e383d94a0786 100644
GIT binary patch
delta 43
zcmZ2wvdV<ZCD<iIONxPkNpK^VfDqFJ#?3N9F^pUj7#SEC{{R0!pK)`O@Cr5n?UM{C

delta 43
zcmZ2wvdV<ZCD<iIONxPk>B>ef0U;&<hs`oVF^pUS4h#$o|NsA&ci7w{yn+n?_kav3

diff --git a/tests/data/acpi/aarch64/virt/DSDT.pxb b/tests/data/acpi/aarch64/virt/DSDT.pxb
index f98dcbfc6b823bce6d5710e8056a4e260fb92a02..356e610fdffb6fea0a763517b62df0ed0c64ab97 100644
GIT binary patch
delta 65
zcmV-H0KWf(J%Bw5L{mgmfF1w<0%ws58v%x~Ce#xFMzi}9p$7~MUqeDc0Hh26005A)
XtQ%PY3XlK*00960|DOP}4;^&@V;K`h

delta 69
zcmZp$ZL#HY33dr-kz-(B5}n8;&Dgb3?TRp?*XG~C3)uw(;+>rw8J6%dFfa%>FfcG|
WULhUH$OUHp|Nmd!VKcXEDI)-PzY;<K

diff --git a/tests/data/acpi/aarch64/virt/DSDT.smmuv3-dev b/tests/data/acpi/aarch64/virt/DSDT.smmuv3-dev
index 6c12a7aaf8a6315bac968a685f5b6673e7248817..f1419cbda7167ed5a36410f71c52e3d2a22218fe 100644
GIT binary patch
delta 73
zcmV-P0Ji_4P@Yf<L{mgm9w-0+0{xK+8v%o{CSe@~Mv_oNNt6E*AG50+eg_N;UqeDc
f0Hh26005A)IVD*E3XlK*00960|DOP}oF;|=B@-5f

delta 77
zcmbOiuqc4bCD<iINrQobY4t=dX~y=AYKgL}UXucxJtzMcmfyTuwvJsuAl})@kzolR
f0|SGA0|NuYW>eKjMlLY(|NsB;4x4AFwJ`z!LyZ-I

diff --git a/tests/data/acpi/aarch64/virt/DSDT.smmuv3-legacy b/tests/data/acpi/aarch64/virt/DSDT.smmuv3-legacy
index 6c12a7aaf8a6315bac968a685f5b6673e7248817..f1419cbda7167ed5a36410f71c52e3d2a22218fe 100644
GIT binary patch
delta 73
zcmV-P0Ji_4P@Yf<L{mgm9w-0+0{xK+8v%o{CSe@~Mv_oNNt6E*AG50+eg_N;UqeDc
f0Hh26005A)IVD*E3XlK*00960|DOP}oF;|=B@-5f

delta 77
zcmbOiuqc4bCD<iINrQobY4t=dX~y=AYKgL}UXucxJtzMcmfyTuwvJsuAl})@kzolR
f0|SGA0|NuYW>eKjMlLY(|NsB;4x4AFwJ`z!LyZ-I

diff --git a/tests/data/acpi/aarch64/virt/DSDT.topology b/tests/data/acpi/aarch64/virt/DSDT.topology
index 208a3163a6bf2a59cf421418dcb16ad1156285c6..33a9c4c397ca498f5b3fbcc7e7e446fe8ac0b125 100644
GIT binary patch
delta 65
zcmV-H0KWgDE1xS0L{mgmpA`TA0_%|q8v%o{CJ_q(Mzc5zp$7~MUqeDc0Hh26005A)
X=@MB13XlK*00960|DOP}OcYlEOyd%(

delta 69
zcmbQQy;z&eCD<iou_yxr)69un(v0mJ)daa2y*68LFJu=Gh<A2!WLUz-z`!8jz`($;
W`KeGOBNv$Y|Nnn^hs_=$;fw%X^%184

diff --git a/tests/data/acpi/aarch64/virt/DSDT.viot b/tests/data/acpi/aarch64/virt/DSDT.viot
index f81e3e6cc794d77ea66b7e27b1afe56e248132b6..625ce32b13706b83d4400548dcf8b81485dba965 100644
GIT binary patch
delta 65
zcmV-H0KWg~Dds5(L{mgm<`e(`0-2Et8v%*2CPxYZMzd}Tp$7~MUqeDc0Hh26005A)
X9}-ys3XlK*00960|DOP}f)i)~acmP6

delta 69
zcmaE+`AU<^CD<k8l?Vd^llw$2X~y1-YVKT&UYql{7P1Qn#5+4VGA!X^U|<k%U|?X_
WEG-nt$OUHp|Nmd!VRM~u1|tB5HWCp4

diff --git a/tests/data/acpi/aarch64/virt/MCFG b/tests/data/acpi/aarch64/virt/MCFG
index f4ae3203a4e9258a397c9912332178640209637b..99e75f326c3c7fc3be5154c4667f34995e33dbc2 100644
GIT binary patch
delta 30
ecmcDq;qrBMbGKn&U|?J`kxP|#0s{p62T=f4aRlW6

delta 30
fcmcDq;qrBMbGKn&U|@VRkxP|Vz<~h_{)0#WS8)X8

diff --git a/tests/data/acpi/aarch64/virt/MCFG.11.1 b/tests/data/acpi/aarch64/virt/MCFG.11.1
new file mode 100644
index 0000000000000000000000000000000000000000..f4ae3203a4e9258a397c9912332178640209637b
GIT binary patch
literal 60
ucmeZuc5}C3U|?W;<K*w`5v<@85#X$#prF9Wz`y`vgJ>im-~i$L2T=ezMF;@^

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/aarch64/virt/MCFG.memhp b/tests/data/acpi/aarch64/virt/MCFG.memhp
new file mode 100644
index 0000000000000000000000000000000000000000..360f1dbbea17e4857f1c26a172ff533eef446823
GIT binary patch
literal 60
ucmeZuc5}C3U|?We?d0$55v<@85#X$#prF9Wz`y`vgJ>i$0m}am5(5A*-UtBz

literal 0
HcmV?d00001


-- 
2.55.0


