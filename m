Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAF41C369D8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 11:11:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9MOS-0007m5-3E; Mon, 28 Apr 2025 07:11:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alireza.sanaee@huawei.com>)
 id 1u9MOE-0007Su-5W; Mon, 28 Apr 2025 07:11:11 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alireza.sanaee@huawei.com>)
 id 1u9MOA-00025g-KZ; Mon, 28 Apr 2025 07:11:09 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZmLGw5tZ9z6K9Rs;
 Mon, 28 Apr 2025 19:06:16 +0800 (CST)
Received: from frapeml500003.china.huawei.com (unknown [7.182.85.28])
 by mail.maildlp.com (Postfix) with ESMTPS id 9D6F11402EF;
 Mon, 28 Apr 2025 19:11:04 +0800 (CST)
Received: from a2303103017.china.huawei.com (10.203.177.99) by
 frapeml500003.china.huawei.com (7.182.85.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 28 Apr 2025 13:11:03 +0200
To: <qemu-devel@nongnu.org>
CC: <philmd@linaro.org>, <alireza.sanaee@huawei.com>, <anisinha@redhat.com>,
 <armbru@redhat.com>, <berrange@redhat.com>, <dapeng1.mi@linux.intel.com>,
 <eric.auger@redhat.com>, <farman@linux.ibm.com>, <gustavo.romero@linaro.org>, 
 <imammedo@redhat.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <linuxarm@huawei.com>, <mst@redhat.com>,
 <mtosatti@redhat.com>, <peter.maydell@linaro.org>, <qemu-arm@nongnu.org>,
 <richard.henderson@linaro.org>, <shameerali.kolothum.thodi@huawei.com>,
 <shannon.zhaosl@gmail.com>, <yangyicong@hisilicon.com>, <zhao1.liu@intel.com>
Subject: [PATCH v10 6/6] Update the ACPI tables according to the acpi
 aml_build changes
Date: Mon, 28 Apr 2025 12:07:54 +0100
Message-ID: <20250428110754.48-7-alireza.sanaee@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250428110754.48-1-alireza.sanaee@huawei.com>
References: <20250428110754.48-1-alireza.sanaee@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.203.177.99]
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 frapeml500003.china.huawei.com (7.182.85.28)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=alireza.sanaee@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  Alireza Sanaee <alireza.sanaee@huawei.com>
From:  Alireza Sanaee via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

 /*
  * Intel ACPI Component Architecture
  * AML/ASL+ Disassembler version 20200925 (64-bit version)
  * Copyright (c) 2000 - 2020 Intel Corporation
  *
- * Disassembly of tests/data/acpi/aarch64/virt/PPTT.acpihmatvirt, Thu Apr 24 19:37:19 2025
+ * Disassembly of /tmp/aml-X03H52, Thu Apr 24 19:37:19 2025
  *
  * ACPI Data Table [PPTT]
  *
  * Format: [HexOffset DecimalOffset ByteLength]  FieldName : FieldValue
  */

 [000h 0000   4]                    Signature : "PPTT"    [Processor Properties Topology Table]
-[004h 0004   4]                 Table Length : 000000B0
+[004h 0004   4]                 Table Length : 000001F0
 [008h 0008   1]                     Revision : 02
-[009h 0009   1]                     Checksum : 0D
+[009h 0009   1]                     Checksum : C6
 [00Ah 0010   6]                       Oem ID : "BOCHS "
 [010h 0016   8]                 Oem Table ID : "BXPC    "
 [018h 0024   4]                 Oem Revision : 00000001
 [01Ch 0028   4]              Asl Compiler ID : "BXPC"
 [020h 0032   4]        Asl Compiler Revision : 00000001

 [024h 0036   1]                Subtable Type : 00 [Processor Hierarchy Node]
 [025h 0037   1]                       Length : 14
 [026h 0038   2]                     Reserved : 0000
 [028h 0040   4]        Flags (decoded below) : 00000011
                             Physical package : 1
                      ACPI Processor ID valid : 0
                        Processor is a thread : 0
                               Node is a leaf : 0
                     Identical Implementation : 1
@@ -34,94 +34,72 @@
 [030h 0048   4]            ACPI Processor ID : 00000000
 [034h 0052   4]      Private Resource Number : 00000000

 [038h 0056   1]                Subtable Type : 00 [Processor Hierarchy Node]
 [039h 0057   1]                       Length : 14
 [03Ah 0058   2]                     Reserved : 0000
 [03Ch 0060   4]        Flags (decoded below) : 00000011
                             Physical package : 1
                      ACPI Processor ID valid : 0
                        Processor is a thread : 0
                               Node is a leaf : 0
                     Identical Implementation : 1
 [040h 0064   4]                       Parent : 00000024
 [044h 0068   4]            ACPI Processor ID : 00000000
 [048h 0072   4]      Private Resource Number : 00000000

-[04Ch 0076   1]                Subtable Type : 00 [Processor Hierarchy Node]
-[04Dh 0077   1]                       Length : 14
+[04Ch 0076   1]                Subtable Type : 01 [Cache Type]
+[04Dh 0077   1]                       Length : 1C
 [04Eh 0078   2]                     Reserved : 0000
-[050h 0080   4]        Flags (decoded below) : 0000000A
-                            Physical package : 0
-                     ACPI Processor ID valid : 1
-                       Processor is a thread : 0
-                              Node is a leaf : 1
-                    Identical Implementation : 0
-[054h 0084   4]                       Parent : 00000038
-[058h 0088   4]            ACPI Processor ID : 00000000
-[05Ch 0092   4]      Private Resource Number : 00000000
-
-[060h 0096   1]                Subtable Type : 00 [Processor Hierarchy Node]
-[061h 0097   1]                       Length : 14
-[062h 0098   2]                     Reserved : 0000
-[064h 0100   4]        Flags (decoded below) : 0000000A
-                            Physical package : 0
-                     ACPI Processor ID valid : 1
-                       Processor is a thread : 0
-                              Node is a leaf : 1
-                    Identical Implementation : 0
-[068h 0104   4]                       Parent : 00000038
-[06Ch 0108   4]            ACPI Processor ID : 00000001
-[070h 0112   4]      Private Resource Number : 00000000
-
-[074h 0116   1]                Subtable Type : 00 [Processor Hierarchy Node]
-[075h 0117   1]                       Length : 14
-[076h 0118   2]                     Reserved : 0000
-[078h 0120   4]        Flags (decoded below) : 00000011
-                            Physical package : 1
-                     ACPI Processor ID valid : 0
-                       Processor is a thread : 0
-                              Node is a leaf : 0
-                    Identical Implementation : 1
-[07Ch 0124   4]                       Parent : 00000024
-[080h 0128   4]            ACPI Processor ID : 00000001
-[084h 0132   4]      Private Resource Number : 00000000
-
-[088h 0136   1]                Subtable Type : 00 [Processor Hierarchy Node]
-[089h 0137   1]                       Length : 14
-[08Ah 0138   2]                     Reserved : 0000
-[08Ch 0140   4]        Flags (decoded below) : 0000000A
-                            Physical package : 0
-                     ACPI Processor ID valid : 1
-                       Processor is a thread : 0
-                              Node is a leaf : 1
-                    Identical Implementation : 0
-[090h 0144   4]                       Parent : 00000074
-[094h 0148   4]            ACPI Processor ID : 00000002
-[098h 0152   4]      Private Resource Number : 00000000
-
-[09Ch 0156   1]                Subtable Type : 00 [Processor Hierarchy Node]
-[09Dh 0157   1]                       Length : 14
-[09Eh 0158   2]                     Reserved : 0000
-[0A0h 0160   4]        Flags (decoded below) : 0000000A
-                            Physical package : 0
-                     ACPI Processor ID valid : 1
-                       Processor is a thread : 0
-                              Node is a leaf : 1
-                    Identical Implementation : 0
-[0A4h 0164   4]                       Parent : 00000074
-[0A8h 0168   4]            ACPI Processor ID : 00000003
-[0ACh 0172   4]      Private Resource Number : 00000000
+[050h 0080   4]        Flags (decoded below) : 000000FF
+                                  Size valid : 1
+                        Number of Sets valid : 1
+                         Associativity valid : 1
+                       Allocation Type valid : 1
+                            Cache Type valid : 1
+                          Write Policy valid : 1
+                             Line Size valid : 1
+[054h 0084   4]          Next Level of Cache : 00000000
+[058h 0088   4]                         Size : 00200000
+[05Ch 0092   4]               Number of Sets : 00000800
+[060h 0096   1]                Associativity : 10
+[061h 0097   1]                   Attributes : 0F
+                             Allocation Type : 3
+                                  Cache Type : 3
+                                Write Policy : 0
+[062h 0098   2]                    Line Size : 0040
+
+Invalid subtable length

-Raw Table Data: Length 176 (0xB0)
+Raw Table Data: Length 496 (0x1F0)

-    0000: 50 50 54 54 B0 00 00 00 02 0D 42 4F 43 48 53 20  // PPTT......BOCHS
+    0000: 50 50 54 54 F0 01 00 00 02 C6 42 4F 43 48 53 20  // PPTT......BOCHS
     0010: 42 58 50 43 20 20 20 20 01 00 00 00 42 58 50 43  // BXPC    ....BXPC
     0020: 01 00 00 00 00 14 00 00 11 00 00 00 00 00 00 00  // ................
     0030: 00 00 00 00 00 00 00 00 00 14 00 00 11 00 00 00  // ................
-    0040: 24 00 00 00 00 00 00 00 00 00 00 00 00 14 00 00  // $...............
-    0050: 0A 00 00 00 38 00 00 00 00 00 00 00 00 00 00 00  // ....8...........
-    0060: 00 14 00 00 0A 00 00 00 38 00 00 00 01 00 00 00  // ........8.......
-    0070: 00 00 00 00 00 14 00 00 11 00 00 00 24 00 00 00  // ............$...
-    0080: 01 00 00 00 00 00 00 00 00 14 00 00 0A 00 00 00  // ................
-    0090: 74 00 00 00 02 00 00 00 00 00 00 00 00 14 00 00  // t...............
-    00A0: 0A 00 00 00 74 00 00 00 03 00 00 00 00 00 00 00  // ....t...........
+    0040: 24 00 00 00 00 00 00 00 00 00 00 00 01 1C 00 00  // $...............
+    0050: FF 00 00 00 00 00 00 00 00 00 20 00 00 08 00 00  // .......... .....
+    0060: 10 0F 40 00 01 1C 00 00 FF 00 00 00 4C 00 00 00  // ..@.........L...
+    0070: 00 80 00 00 80 00 00 00 04 03 40 00 01 1C 00 00  // ..........@.....
+    0080: FF 00 00 00 4C 00 00 00 00 C0 00 00 00 01 00 00  // ....L...........
+    0090: 03 07 40 00 00 1C 00 00 0A 00 00 00 38 00 00 00  // ..@.........8...
+    00A0: 00 00 00 00 02 00 00 00 7C 00 00 00 64 00 00 00  // ........|...d...
+    00B0: 01 1C 00 00 FF 00 00 00 00 00 00 00 00 00 20 00  // .............. .
+    00C0: 00 08 00 00 10 0F 40 00 01 1C 00 00 FF 00 00 00  // ......@.........
+    00D0: B0 00 00 00 00 80 00 00 80 00 00 00 04 03 40 00  // ..............@.
+    00E0: 01 1C 00 00 FF 00 00 00 B0 00 00 00 00 C0 00 00  // ................
+    00F0: 00 01 00 00 03 07 40 00 00 1C 00 00 0A 00 00 00  // ......@.........
+    0100: 38 00 00 00 01 00 00 00 02 00 00 00 E0 00 00 00  // 8...............
+    0110: C8 00 00 00 00 14 00 00 11 00 00 00 24 00 00 00  // ............$...
+    0120: 01 00 00 00 00 00 00 00 01 1C 00 00 FF 00 00 00  // ................
+    0130: 00 00 00 00 00 00 20 00 00 08 00 00 10 0F 40 00  // ...... .......@.
+    0140: 01 1C 00 00 FF 00 00 00 28 01 00 00 00 80 00 00  // ........(.......
+    0150: 80 00 00 00 04 03 40 00 01 1C 00 00 FF 00 00 00  // ......@.........
+    0160: 28 01 00 00 00 C0 00 00 00 01 00 00 03 07 40 00  // (.............@.
+    0170: 00 1C 00 00 0A 00 00 00 14 01 00 00 02 00 00 00  // ................
+    0180: 02 00 00 00 58 01 00 00 40 01 00 00 01 1C 00 00  // ....X...@.......
+    0190: FF 00 00 00 00 00 00 00 00 00 20 00 00 08 00 00  // .......... .....
+    01A0: 10 0F 40 00 01 1C 00 00 FF 00 00 00 8C 01 00 00  // ..@.............
+    01B0: 00 80 00 00 80 00 00 00 04 03 40 00 01 1C 00 00  // ..........@.....
+    01C0: FF 00 00 00 8C 01 00 00 00 C0 00 00 00 01 00 00  // ................
+    01D0: 03 07 40 00 00 1C 00 00 0A 00 00 00 14 01 00 00  // ..@.............
+    01E0: 03 00 00 00 02 00 00 00 BC 01 00 00 A4 01 00 00  // ................

 /*
  * Intel ACPI Component Architecture
  * AML/ASL+ Disassembler version 20200925 (64-bit version)
  * Copyright (c) 2000 - 2020 Intel Corporation
  *
- * Disassembly of tests/data/acpi/aarch64/virt/PPTT.topology, Thu Apr 24 19:37:25 2025
+ * Disassembly of /tmp/aml-6P9K52, Thu Apr 24 19:37:25 2025
  *
  * ACPI Data Table [PPTT]
  *
  * Format: [HexOffset DecimalOffset ByteLength]  FieldName : FieldValue
  */

 [000h 0000   4]                    Signature : "PPTT"    [Processor Properties Topology Table]
-[004h 0004   4]                 Table Length : 00000164
+[004h 0004   4]                 Table Length : 0000027C
 [008h 0008   1]                     Revision : 02
-[009h 0009   1]                     Checksum : 97
+[009h 0009   1]                     Checksum : C6
 [00Ah 0010   6]                       Oem ID : "BOCHS "
 [010h 0016   8]                 Oem Table ID : "BXPC    "
 [018h 0024   4]                 Oem Revision : 00000001
 [01Ch 0028   4]              Asl Compiler ID : "BXPC"
 [020h 0032   4]        Asl Compiler Revision : 00000001

 [024h 0036   1]                Subtable Type : 00 [Processor Hierarchy Node]
 [025h 0037   1]                       Length : 14
 [026h 0038   2]                     Reserved : 0000
 [028h 0040   4]        Flags (decoded below) : 00000011
                             Physical package : 1
                      ACPI Processor ID valid : 0
                        Processor is a thread : 0
                               Node is a leaf : 0
                     Identical Implementation : 1
@@ -34,223 +34,81 @@
 [030h 0048   4]            ACPI Processor ID : 00000000
 [034h 0052   4]      Private Resource Number : 00000000

 [038h 0056   1]                Subtable Type : 00 [Processor Hierarchy Node]
 [039h 0057   1]                       Length : 14
 [03Ah 0058   2]                     Reserved : 0000
 [03Ch 0060   4]        Flags (decoded below) : 00000011
                             Physical package : 1
                      ACPI Processor ID valid : 0
                        Processor is a thread : 0
                               Node is a leaf : 0
                     Identical Implementation : 1
 [040h 0064   4]                       Parent : 00000024
 [044h 0068   4]            ACPI Processor ID : 00000000
 [048h 0072   4]      Private Resource Number : 00000000

-[04Ch 0076   1]                Subtable Type : 00 [Processor Hierarchy Node]
-[04Dh 0077   1]                       Length : 14
+[04Ch 0076   1]                Subtable Type : 01 [Cache Type]
+[04Dh 0077   1]                       Length : 1C
 [04Eh 0078   2]                     Reserved : 0000
-[050h 0080   4]        Flags (decoded below) : 00000010
-                            Physical package : 0
-                     ACPI Processor ID valid : 0
-                       Processor is a thread : 0
-                              Node is a leaf : 0
-                    Identical Implementation : 1
-[054h 0084   4]                       Parent : 00000038
-[058h 0088   4]            ACPI Processor ID : 00000000
-[05Ch 0092   4]      Private Resource Number : 00000000
-
-[060h 0096   1]                Subtable Type : 00 [Processor Hierarchy Node]
-[061h 0097   1]                       Length : 14
-[062h 0098   2]                     Reserved : 0000
-[064h 0100   4]        Flags (decoded below) : 00000010
-                            Physical package : 0
-                     ACPI Processor ID valid : 0
-                       Processor is a thread : 0
-                              Node is a leaf : 0
-                    Identical Implementation : 1
-[068h 0104   4]                       Parent : 0000004C
-[06Ch 0108   4]            ACPI Processor ID : 00000000
-[070h 0112   4]      Private Resource Number : 00000000
-
-[074h 0116   1]                Subtable Type : 00 [Processor Hierarchy Node]
-[075h 0117   1]                       Length : 14
-[076h 0118   2]                     Reserved : 0000
-[078h 0120   4]        Flags (decoded below) : 0000000E
-                            Physical package : 0
-                     ACPI Processor ID valid : 1
-                       Processor is a thread : 1
-                              Node is a leaf : 1
-                    Identical Implementation : 0
-[07Ch 0124   4]                       Parent : 00000060
-[080h 0128   4]            ACPI Processor ID : 00000000
-[084h 0132   4]      Private Resource Number : 00000000
-
-[088h 0136   1]                Subtable Type : 00 [Processor Hierarchy Node]
-[089h 0137   1]                       Length : 14
-[08Ah 0138   2]                     Reserved : 0000
-[08Ch 0140   4]        Flags (decoded below) : 0000000E
-                            Physical package : 0
-                     ACPI Processor ID valid : 1
-                       Processor is a thread : 1
-                              Node is a leaf : 1
-                    Identical Implementation : 0
-[090h 0144   4]                       Parent : 00000060
-[094h 0148   4]            ACPI Processor ID : 00000001
-[098h 0152   4]      Private Resource Number : 00000000
-
-[09Ch 0156   1]                Subtable Type : 00 [Processor Hierarchy Node]
-[09Dh 0157   1]                       Length : 14
-[09Eh 0158   2]                     Reserved : 0000
-[0A0h 0160   4]        Flags (decoded below) : 00000010
-                            Physical package : 0
-                     ACPI Processor ID valid : 0
-                       Processor is a thread : 0
-                              Node is a leaf : 0
-                    Identical Implementation : 1
-[0A4h 0164   4]                       Parent : 0000004C
-[0A8h 0168   4]            ACPI Processor ID : 00000001
-[0ACh 0172   4]      Private Resource Number : 00000000
-
-[0B0h 0176   1]                Subtable Type : 00 [Processor Hierarchy Node]
-[0B1h 0177   1]                       Length : 14
-[0B2h 0178   2]                     Reserved : 0000
-[0B4h 0180   4]        Flags (decoded below) : 0000000E
-                            Physical package : 0
-                     ACPI Processor ID valid : 1
-                       Processor is a thread : 1
-                              Node is a leaf : 1
-                    Identical Implementation : 0
-[0B8h 0184   4]                       Parent : 0000009C
-[0BCh 0188   4]            ACPI Processor ID : 00000002
-[0C0h 0192   4]      Private Resource Number : 00000000
-
-[0C4h 0196   1]                Subtable Type : 00 [Processor Hierarchy Node]
-[0C5h 0197   1]                       Length : 14
-[0C6h 0198   2]                     Reserved : 0000
-[0C8h 0200   4]        Flags (decoded below) : 0000000E
-                            Physical package : 0
-                     ACPI Processor ID valid : 1
-                       Processor is a thread : 1
-                              Node is a leaf : 1
-                    Identical Implementation : 0
-[0CCh 0204   4]                       Parent : 0000009C
-[0D0h 0208   4]            ACPI Processor ID : 00000003
-[0D4h 0212   4]      Private Resource Number : 00000000
-
-[0D8h 0216   1]                Subtable Type : 00 [Processor Hierarchy Node]
-[0D9h 0217   1]                       Length : 14
-[0DAh 0218   2]                     Reserved : 0000
-[0DCh 0220   4]        Flags (decoded below) : 00000010
-                            Physical package : 0
-                     ACPI Processor ID valid : 0
-                       Processor is a thread : 0
-                              Node is a leaf : 0
-                    Identical Implementation : 1
-[0E0h 0224   4]                       Parent : 00000038
-[0E4h 0228   4]            ACPI Processor ID : 00000001
-[0E8h 0232   4]      Private Resource Number : 00000000
-
-[0ECh 0236   1]                Subtable Type : 00 [Processor Hierarchy Node]
-[0EDh 0237   1]                       Length : 14
-[0EEh 0238   2]                     Reserved : 0000
-[0F0h 0240   4]        Flags (decoded below) : 00000010
-                            Physical package : 0
-                     ACPI Processor ID valid : 0
-                       Processor is a thread : 0
-                              Node is a leaf : 0
-                    Identical Implementation : 1
-[0F4h 0244   4]                       Parent : 000000D8
-[0F8h 0248   4]            ACPI Processor ID : 00000000
-[0FCh 0252   4]      Private Resource Number : 00000000
-
-[100h 0256   1]                Subtable Type : 00 [Processor Hierarchy Node]
-[101h 0257   1]                       Length : 14
-[102h 0258   2]                     Reserved : 0000
-[104h 0260   4]        Flags (decoded below) : 0000000E
-                            Physical package : 0
-                     ACPI Processor ID valid : 1
-                       Processor is a thread : 1
-                              Node is a leaf : 1
-                    Identical Implementation : 0
-[108h 0264   4]                       Parent : 000000EC
-[10Ch 0268   4]            ACPI Processor ID : 00000004
-[110h 0272   4]      Private Resource Number : 00000000
-
-[114h 0276   1]                Subtable Type : 00 [Processor Hierarchy Node]
-[115h 0277   1]                       Length : 14
-[116h 0278   2]                     Reserved : 0000
-[118h 0280   4]        Flags (decoded below) : 0000000E
-                            Physical package : 0
-                     ACPI Processor ID valid : 1
-                       Processor is a thread : 1
-                              Node is a leaf : 1
-                    Identical Implementation : 0
-[11Ch 0284   4]                       Parent : 000000EC
-[120h 0288   4]            ACPI Processor ID : 00000005
-[124h 0292   4]      Private Resource Number : 00000000
-
-[128h 0296   1]                Subtable Type : 00 [Processor Hierarchy Node]
-[129h 0297   1]                       Length : 14
-[12Ah 0298   2]                     Reserved : 0000
-[12Ch 0300   4]        Flags (decoded below) : 00000010
-                            Physical package : 0
-                     ACPI Processor ID valid : 0
-                       Processor is a thread : 0
-                              Node is a leaf : 0
-                    Identical Implementation : 1
-[130h 0304   4]                       Parent : 000000D8
-[134h 0308   4]            ACPI Processor ID : 00000001
-[138h 0312   4]      Private Resource Number : 00000000
-
-[13Ch 0316   1]                Subtable Type : 00 [Processor Hierarchy Node]
-[13Dh 0317   1]                       Length : 14
-[13Eh 0318   2]                     Reserved : 0000
-[140h 0320   4]        Flags (decoded below) : 0000000E
-                            Physical package : 0
-                     ACPI Processor ID valid : 1
-                       Processor is a thread : 1
-                              Node is a leaf : 1
-                    Identical Implementation : 0
-[144h 0324   4]                       Parent : 00000128
-[148h 0328   4]            ACPI Processor ID : 00000006
-[14Ch 0332   4]      Private Resource Number : 00000000
+[050h 0080   4]        Flags (decoded below) : 000000FF
+                                  Size valid : 1
+                        Number of Sets valid : 1
+                         Associativity valid : 1
+                       Allocation Type valid : 1
+                            Cache Type valid : 1
+                          Write Policy valid : 1
+                             Line Size valid : 1
+[054h 0084   4]          Next Level of Cache : 00000000
+[058h 0088   4]                         Size : 00200000
+[05Ch 0092   4]               Number of Sets : 00000800
+[060h 0096   1]                Associativity : 10
+[061h 0097   1]                   Attributes : 0F
+                             Allocation Type : 3
+                                  Cache Type : 3
+                                Write Policy : 0
+[062h 0098   2]                    Line Size : 0040

-[150h 0336   1]                Subtable Type : 00 [Processor Hierarchy Node]
-[151h 0337   1]                       Length : 14
-[152h 0338   2]                     Reserved : 0000
-[154h 0340   4]        Flags (decoded below) : 0000000E
-                            Physical package : 0
-                     ACPI Processor ID valid : 1
-                       Processor is a thread : 1
-                              Node is a leaf : 1
-                    Identical Implementation : 0
-[158h 0344   4]                       Parent : 00000128
-[15Ch 0348   4]            ACPI Processor ID : 00000007
-[160h 0352   4]      Private Resource Number : 00000000
+Invalid subtable length

-Raw Table Data: Length 356 (0x164)
+Raw Table Data: Length 636 (0x27C)

-    0000: 50 50 54 54 64 01 00 00 02 97 42 4F 43 48 53 20  // PPTTd.....BOCHS
+    0000: 50 50 54 54 7C 02 00 00 02 C6 42 4F 43 48 53 20  // PPTT|.....BOCHS
     0010: 42 58 50 43 20 20 20 20 01 00 00 00 42 58 50 43  // BXPC    ....BXPC
     0020: 01 00 00 00 00 14 00 00 11 00 00 00 00 00 00 00  // ................
     0030: 00 00 00 00 00 00 00 00 00 14 00 00 11 00 00 00  // ................
-    0040: 24 00 00 00 00 00 00 00 00 00 00 00 00 14 00 00  // $...............
-    0050: 10 00 00 00 38 00 00 00 00 00 00 00 00 00 00 00  // ....8...........
-    0060: 00 14 00 00 10 00 00 00 4C 00 00 00 00 00 00 00  // ........L.......
-    0070: 00 00 00 00 00 14 00 00 0E 00 00 00 60 00 00 00  // ............`...
-    0080: 00 00 00 00 00 00 00 00 00 14 00 00 0E 00 00 00  // ................
-    0090: 60 00 00 00 01 00 00 00 00 00 00 00 00 14 00 00  // `...............
-    00A0: 10 00 00 00 4C 00 00 00 01 00 00 00 00 00 00 00  // ....L...........
-    00B0: 00 14 00 00 0E 00 00 00 9C 00 00 00 02 00 00 00  // ................
-    00C0: 00 00 00 00 00 14 00 00 0E 00 00 00 9C 00 00 00  // ................
-    00D0: 03 00 00 00 00 00 00 00 00 14 00 00 10 00 00 00  // ................
-    00E0: 38 00 00 00 01 00 00 00 00 00 00 00 00 14 00 00  // 8...............
-    00F0: 10 00 00 00 D8 00 00 00 00 00 00 00 00 00 00 00  // ................
-    0100: 00 14 00 00 0E 00 00 00 EC 00 00 00 04 00 00 00  // ................
-    0110: 00 00 00 00 00 14 00 00 0E 00 00 00 EC 00 00 00  // ................
-    0120: 05 00 00 00 00 00 00 00 00 14 00 00 10 00 00 00  // ................
-    0130: D8 00 00 00 01 00 00 00 00 00 00 00 00 14 00 00  // ................
-    0140: 0E 00 00 00 28 01 00 00 06 00 00 00 00 00 00 00  // ....(...........
-    0150: 00 14 00 00 0E 00 00 00 28 01 00 00 07 00 00 00  // ........(.......
-    0160: 00 00 00 00                                      // ....
+    0040: 24 00 00 00 00 00 00 00 00 00 00 00 01 1C 00 00  // $...............
+    0050: FF 00 00 00 00 00 00 00 00 00 20 00 00 08 00 00  // .......... .....
+    0060: 10 0F 40 00 00 18 00 00 10 00 00 00 38 00 00 00  // ..@.........8...
+    0070: 00 00 00 00 01 00 00 00 4C 00 00 00 01 1C 00 00  // ........L.......
+    0080: FF 00 00 00 00 00 00 00 00 80 00 00 80 00 00 00  // ................
+    0090: 04 03 40 00 01 1C 00 00 FF 00 00 00 00 00 00 00  // ..@.............
+    00A0: 00 C0 00 00 00 01 00 00 03 07 40 00 00 1C 00 00  // ..........@.....
+    00B0: 10 00 00 00 64 00 00 00 00 00 00 00 02 00 00 00  // ....d...........
+    00C0: 94 00 00 00 7C 00 00 00 00 14 00 00 0E 00 00 00  // ....|...........
+    00D0: AC 00 00 00 00 00 00 00 00 00 00 00 00 14 00 00  // ................
+    00E0: 0E 00 00 00 AC 00 00 00 01 00 00 00 00 00 00 00  // ................
+    00F0: 01 1C 00 00 FF 00 00 00 00 00 00 00 00 80 00 00  // ................
+    0100: 80 00 00 00 04 03 40 00 01 1C 00 00 FF 00 00 00  // ......@.........
+    0110: 00 00 00 00 00 C0 00 00 00 01 00 00 03 07 40 00  // ..............@.
+    0120: 00 1C 00 00 10 00 00 00 64 00 00 00 01 00 00 00  // ........d.......
+    0130: 02 00 00 00 08 01 00 00 F0 00 00 00 00 14 00 00  // ................
+    0140: 0E 00 00 00 20 01 00 00 02 00 00 00 00 00 00 00  // .... ...........
+    0150: 00 14 00 00 0E 00 00 00 20 01 00 00 03 00 00 00  // ........ .......
+    0160: 00 00 00 00 01 1C 00 00 FF 00 00 00 00 00 00 00  // ................
+    0170: 00 00 20 00 00 08 00 00 10 0F 40 00 00 18 00 00  // .. .......@.....
+    0180: 10 00 00 00 38 00 00 00 01 00 00 00 01 00 00 00  // ....8...........
+    0190: 64 01 00 00 01 1C 00 00 FF 00 00 00 00 00 00 00  // d...............
+    01A0: 00 80 00 00 80 00 00 00 04 03 40 00 01 1C 00 00  // ..........@.....
+    01B0: FF 00 00 00 00 00 00 00 00 C0 00 00 00 01 00 00  // ................
+    01C0: 03 07 40 00 00 1C 00 00 10 00 00 00 7C 01 00 00  // ..@.........|...
+    01D0: 00 00 00 00 02 00 00 00 AC 01 00 00 94 01 00 00  // ................
+    01E0: 00 14 00 00 0E 00 00 00 C4 01 00 00 04 00 00 00  // ................
+    01F0: 00 00 00 00 00 14 00 00 0E 00 00 00 C4 01 00 00  // ................
+    0200: 05 00 00 00 00 00 00 00 01 1C 00 00 FF 00 00 00  // ................
+    0210: 00 00 00 00 00 80 00 00 80 00 00 00 04 03 40 00  // ..............@.
+    0220: 01 1C 00 00 FF 00 00 00 00 00 00 00 00 C0 00 00  // ................
+    0230: 00 01 00 00 03 07 40 00 00 1C 00 00 10 00 00 00  // ......@.........
+    0240: 7C 01 00 00 01 00 00 00 02 00 00 00 20 02 00 00  // |........... ...
+    0250: 08 02 00 00 00 14 00 00 0E 00 00 00 38 02 00 00  // ............8...
+    0260: 06 00 00 00 00 00 00 00 00 14 00 00 0E 00 00 00  // ................
+    0270: 38 02 00 00 07 00 00 00 00 00 00 00              // 8...........

Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
---
 tests/data/acpi/aarch64/virt/PPTT              | Bin 96 -> 176 bytes
 tests/data/acpi/aarch64/virt/PPTT.acpihmatvirt | Bin 176 -> 496 bytes
 tests/data/acpi/aarch64/virt/PPTT.topology     | Bin 356 -> 676 bytes
 tests/qtest/bios-tables-test-allowed-diff.h    |   3 ---
 4 files changed, 3 deletions(-)

diff --git a/tests/data/acpi/aarch64/virt/PPTT b/tests/data/acpi/aarch64/virt/PPTT
index 15598a9b8a3cc0cdd50bc1f77c73ae0ba728a272..43b9b7047ad93eee1d2ac0a9b08d22d73bebdf54 100644
GIT binary patch
literal 176
zcmWFt2npH1z`($y;pFe^5v<@85#X!<1dKp25F11@h%hh+f@ov_6;nYHW0YZF_z&kR
zFfed1FbMEFFu=rpKynRW#K6LgCVl`Y2egct-GPAtXbu;UYXQU{zy!oKK%4@^02kX2
A0RR91

delta 38
kcmdnMn7|bf5E7EWz`($yK9S2wgh7OXfeXm90Ad&b0DQ6pGynhq

diff --git a/tests/data/acpi/aarch64/virt/PPTT.acpihmatvirt b/tests/data/acpi/aarch64/virt/PPTT.acpihmatvirt
index 7b613ddaf4b8cfa13821aa2e835d290077221897..fc318de992302251ad33b6e74c1632d281ff56e5 100644
GIT binary patch
literal 496
zcmah_F$%&!5S-)$#YTmc7FSsK1j~>#7J>m&<N-dzA`kExd4LbFxJrD6Pw)pia~L^I
zAVY@TojG>c6h&D+BOtzI`+R$_Sykkgpak`*NPvZEh>x}kv}g&uzOw};z<idX)pzo0
z|6yeQbVrY2W}E`tGv&A;g_t~%N3z|;mav_Si{!eS;dMu^CxepDc(C5d_Fmm4PZ-Kw
r>tWr^^}5r7-`f(-x=XCsr{qw^nQ!_syzc1H5C5Ms3}t0p**D}HPG2ek

literal 176
zcmWFt2npH1z`(%7>*Vk35v<@85#X!<1dKp25F11@h%hh+f@ov_6;nYI;{x(6aEO7;
b0?8riMHU0;EdgRCkQxvGs)LC!Lqr$=thxyS

diff --git a/tests/data/acpi/aarch64/virt/PPTT.topology b/tests/data/acpi/aarch64/virt/PPTT.topology
index 6b864f035c9f48845e9a3beb482c5171074864a5..cdbc482d467fc6987ab3ddf3ca38d987adfe484b 100644
GIT binary patch
literal 676
zcmaixy$!-J6ofB7{8SJm3JQu83_w9ai4uwwNJN5yk})VV00l!(Fa$-0U<`JEJL4de
zAmtRt?|sjHzBqZl-(P*eUnko%+r`NtPh-jhpjb1;z(}(z%VsqeF<&~&n*y(I9s_+K
z8m>_BqiThD5C%0~vPJ_zZw0WAdT%%+TE>Orq=a4uoNkIMIm~<md3EMzN!;-ARH0~k
zF}!5$j~Dfpmnnl#i9L70Slq~Afy1i1(l)8h-&qTbra!|=HTb=&lWi;?cg9!c*2{x&
s$kfPT9gEt$Ow_b!dNI6Yjs4yKCNDZ(+cLi93hcQ@#$BdH4(nO;2Hztu0RR91

literal 356
zcmWFt2nk7HWME*L?&R<65v<@85#X!<1VAAM5F11@h%hh+f@ov_6;nYI69Dopu!#Af
ziSYsX2{^>Sc7o)9c7V(S=|vU;>74__Oh60<Ky@%NW+X9~TafjF#BRXUfM}@RH$Wx}
cOdLs!6-f-H7uh_Jy&6CPHY9a0F?OgJ00?&w0RR91

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index e84d6c695520..dfb8523c8bf4 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,4 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/aarch64/virt/PPTT",
-"tests/data/acpi/aarch64/virt/PPTT.acpihmatvirt",
-"tests/data/acpi/aarch64/virt/PPTT.topology",
-- 
2.34.1


