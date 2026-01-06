Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23A4DCE9D71
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 16:03:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vd9Wa-0002Xw-3i; Tue, 06 Jan 2026 11:03:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alireza.sanaee@huawei.com>)
 id 1vd9WV-0002Op-QM; Tue, 06 Jan 2026 11:03:08 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alireza.sanaee@huawei.com>)
 id 1vd9WS-0007Tw-TE; Tue, 06 Jan 2026 11:03:07 -0500
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dlwtX5nn6zJ46bg;
 Wed,  7 Jan 2026 00:03:00 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
 by mail.maildlp.com (Postfix) with ESMTPS id 8CB1A40571;
 Wed,  7 Jan 2026 00:03:02 +0800 (CST)
Received: from a2303103017.china.huawei.com (10.47.31.135) by
 dubpeml500005.china.huawei.com (7.214.145.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 6 Jan 2026 16:03:00 +0000
To: <qemu-devel@nongnu.org>, <gustavo.romero@linaro.org>
CC: <anisinha@redhat.com>, <armbru@redhat.com>, <berrange@redhat.com>,
 <dapeng1.mi@linux.intel.com>, <eric.auger@redhat.com>,
 <farman@linux.ibm.com>, <imammedo@redhat.com>, <jiangkunkun@huawei.com>,
 <maobibo@loongson.cn>, <mst@redhat.com>, <mtosatti@redhat.com>,
 <peter.maydell@linaro.org>, <philmd@linaro.org>, <qemu-arm@nongnu.org>,
 <richard.henderson@linaro.org>, <shannon.zhaosl@gmail.com>,
 <yangyicong@hisilicon.com>, <jonathan.cameron@huawei.com>,
 <linuxarm@huawei.com>, <zhao1.liu@intel.com>
Subject: [PATCH v17 8/8] Update the ACPI tables based on new aml-build.c
Date: Tue, 6 Jan 2026 15:58:27 +0000
Message-ID: <20260106155828.643-9-alireza.sanaee@huawei.com>
X-Mailer: git-send-email 2.51.0.windows.2
In-Reply-To: <20260106155828.643-1-alireza.sanaee@huawei.com>
References: <20260106155828.643-1-alireza.sanaee@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.47.31.135]
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 dubpeml500005.china.huawei.com (7.214.145.207)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=alireza.sanaee@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-to:  Alireza Sanaee <alireza.sanaee@huawei.com>
From:  Alireza Sanaee via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The disassembled differences between actual and expected PPTT based on
the following cache topology representation:

- l1d and l1i shared at cluster level
- l2 shared at cluster level
- l3 shared at cluster level

 /*
  * Intel ACPI Component Architecture
  * AML/ASL+ Disassembler version 20230628 (64-bit version)
  * Copyright (c) 2000 - 2023 Intel Corporation
  *
- * Disassembly of tests/data/acpi/aarch64/virt/PPTT.topology, Fri Aug  8 16:50:38 2025
+ * Disassembly of /tmp/aml-JGBZA3, Fri Aug  8 16:50:38 2025
  *
  * ACPI Data Table [PPTT]
  *
  * Format: [HexOffset DecimalOffset ByteLength]  FieldName : FieldValue (in hex)
  */

 [000h 0000 004h]                   Signature : "PPTT"    [Processor Properties Topology Table]
-[004h 0004 004h]                Table Length : 00000164
+[004h 0004 004h]                Table Length : 00000204
 [008h 0008 001h]                    Revision : 02
-[009h 0009 001h]                    Checksum : 97
+[009h 0009 001h]                    Checksum : B8
 [00Ah 0010 006h]                      Oem ID : "BOCHS "
 [010h 0016 008h]                Oem Table ID : "BXPC    "
 [018h 0024 004h]                Oem Revision : 00000001
 [01Ch 0028 004h]             Asl Compiler ID : "BXPC"
 [020h 0032 004h]       Asl Compiler Revision : 00000001

 [024h 0036 001h]               Subtable Type : 00 [Processor Hierarchy Node]
 [025h 0037 001h]                      Length : 14
 [026h 0038 002h]                    Reserved : 0000
 [028h 0040 004h]       Flags (decoded below) : 00000011
                             Physical package : 1
                      ACPI Processor ID valid : 0
                        Processor is a thread : 0
                               Node is a leaf : 0
                     Identical Implementation : 1
@@ -34,223 +34,369 @@
 [030h 0048 004h]           ACPI Processor ID : 00000000
 [034h 0052 004h]     Private Resource Number : 00000000

 [038h 0056 001h]               Subtable Type : 00 [Processor Hierarchy Node]
 [039h 0057 001h]                      Length : 14
 [03Ah 0058 002h]                    Reserved : 0000
 [03Ch 0060 004h]       Flags (decoded below) : 00000011
                             Physical package : 1
                      ACPI Processor ID valid : 0
                        Processor is a thread : 0
                               Node is a leaf : 0
                     Identical Implementation : 1
 [040h 0064 004h]                      Parent : 00000024
 [044h 0068 004h]           ACPI Processor ID : 00000000
 [048h 0072 004h]     Private Resource Number : 00000000

-[04Ch 0076 001h]               Subtable Type : 00 [Processor Hierarchy Node]
-[04Dh 0077 001h]                      Length : 14
+[04Ch 0076 001h]               Subtable Type : 01 [Cache Type]
+[04Dh 0077 001h]                      Length : 18
 [04Eh 0078 002h]                    Reserved : 0000
-[050h 0080 004h]       Flags (decoded below) : 00000010
+[050h 0080 004h]       Flags (decoded below) : 0000007F
+                                  Size valid : 1
+                        Number of Sets valid : 1
+                         Associativity valid : 1
+                       Allocation Type valid : 1
+                            Cache Type valid : 1
+                          Write Policy valid : 1
+                             Line Size valid : 1
+                              Cache ID valid : 0
+[054h 0084 004h]         Next Level of Cache : 00000000
+[058h 0088 004h]                        Size : 00200000
+[05Ch 0092 004h]              Number of Sets : 00000800
+[060h 0096 001h]               Associativity : 10
+[061h 0097 001h]                  Attributes : 0F
+                             Allocation Type : 3
+                                  Cache Type : 3
+                                Write Policy : 0
+[062h 0098 002h]                   Line Size : 0040
+
+[064h 0100 001h]               Subtable Type : 01 [Cache Type]
+[065h 0101 001h]                      Length : 18
+[066h 0102 002h]                    Reserved : 0000
+[068h 0104 004h]       Flags (decoded below) : 0000007F
+                                  Size valid : 1
+                        Number of Sets valid : 1
+                         Associativity valid : 1
+                       Allocation Type valid : 1
+                            Cache Type valid : 1
+                          Write Policy valid : 1
+                             Line Size valid : 1
+                              Cache ID valid : 0
+[06Ch 0108 004h]         Next Level of Cache : 0000004C
+[070h 0112 004h]                        Size : 00008000
+[074h 0116 004h]              Number of Sets : 00000080
+[078h 0120 001h]               Associativity : 04
+[079h 0121 001h]                  Attributes : 03
+                             Allocation Type : 3
+                                  Cache Type : 0
+                                Write Policy : 0
+[07Ah 0122 002h]                   Line Size : 0040
+
+[07Ch 0124 001h]               Subtable Type : 01 [Cache Type]
+[07Dh 0125 001h]                      Length : 18
+[07Eh 0126 002h]                    Reserved : 0000
+[080h 0128 004h]       Flags (decoded below) : 0000007F
+                                  Size valid : 1
+                        Number of Sets valid : 1
+                         Associativity valid : 1
+                       Allocation Type valid : 1
+                            Cache Type valid : 1
+                          Write Policy valid : 1
+                             Line Size valid : 1
+                              Cache ID valid : 0
+[084h 0132 004h]         Next Level of Cache : 0000004C
+[088h 0136 004h]                        Size : 0000C000
+[08Ch 0140 004h]              Number of Sets : 00000100
+[090h 0144 001h]               Associativity : 03
+[091h 0145 001h]                  Attributes : 07
+                             Allocation Type : 3
+                                  Cache Type : 1
+                                Write Policy : 0
+[092h 0146 002h]                   Line Size : 0040
+
+[094h 0148 001h]               Subtable Type : 00 [Processor Hierarchy Node]
+[095h 0149 001h]                      Length : 1C
+[096h 0150 002h]                    Reserved : 0000
+[098h 0152 004h]       Flags (decoded below) : 00000010
                             Physical package : 0
                      ACPI Processor ID valid : 0
                        Processor is a thread : 0
                               Node is a leaf : 0
                     Identical Implementation : 1
-[054h 0084 004h]                      Parent : 00000038
-[058h 0088 004h]           ACPI Processor ID : 00000000
-[05Ch 0092 004h]     Private Resource Number : 00000000
-
-[060h 0096 001h]               Subtable Type : 00 [Processor Hierarchy Node]
-[061h 0097 001h]                      Length : 14
-[062h 0098 002h]                    Reserved : 0000
-[064h 0100 004h]       Flags (decoded below) : 00000010
-                            Physical package : 0
-                     ACPI Processor ID valid : 0
-                       Processor is a thread : 0
-                              Node is a leaf : 0
-                    Identical Implementation : 1
-[068h 0104 004h]                      Parent : 0000004C
-[06Ch 0108 004h]           ACPI Processor ID : 00000000
-[070h 0112 004h]     Private Resource Number : 00000000
-
-[074h 0116 001h]               Subtable Type : 00 [Processor Hierarchy Node]
-[075h 0117 001h]                      Length : 14
-[076h 0118 002h]                    Reserved : 0000
-[078h 0120 004h]       Flags (decoded below) : 0000000E
-                            Physical package : 0
-                     ACPI Processor ID valid : 1
-                       Processor is a thread : 1
-                              Node is a leaf : 1
-                    Identical Implementation : 0
-[07Ch 0124 004h]                      Parent : 00000060
-[080h 0128 004h]           ACPI Processor ID : 00000000
-[084h 0132 004h]     Private Resource Number : 00000000
-
-[088h 0136 001h]               Subtable Type : 00 [Processor Hierarchy Node]
-[089h 0137 001h]                      Length : 14
-[08Ah 0138 002h]                    Reserved : 0000
-[08Ch 0140 004h]       Flags (decoded below) : 0000000E
-                            Physical package : 0
-                     ACPI Processor ID valid : 1
-                       Processor is a thread : 1
-                              Node is a leaf : 1
-                    Identical Implementation : 0
-[090h 0144 004h]                      Parent : 00000060
-[094h 0148 004h]           ACPI Processor ID : 00000001
-[098h 0152 004h]     Private Resource Number : 00000000
-
-[09Ch 0156 001h]               Subtable Type : 00 [Processor Hierarchy Node]
-[09Dh 0157 001h]                      Length : 14
-[09Eh 0158 002h]                    Reserved : 0000
-[0A0h 0160 004h]       Flags (decoded below) : 00000010
-                            Physical package : 0
-                     ACPI Processor ID valid : 0
-                       Processor is a thread : 0
-                              Node is a leaf : 0
-                    Identical Implementation : 1
-[0A4h 0164 004h]                      Parent : 0000004C
-[0A8h 0168 004h]           ACPI Processor ID : 00000001
-[0ACh 0172 004h]     Private Resource Number : 00000000
+[09Ch 0156 004h]                      Parent : 00000038
+[0A0h 0160 004h]           ACPI Processor ID : 00000000
+[0A4h 0164 004h]     Private Resource Number : 00000002
+[0A8h 0168 004h]            Private Resource : 0000007C
+[0ACh 0172 004h]            Private Resource : 00000064

 [0B0h 0176 001h]               Subtable Type : 00 [Processor Hierarchy Node]
 [0B1h 0177 001h]                      Length : 14
 [0B2h 0178 002h]                    Reserved : 0000
-[0B4h 0180 004h]       Flags (decoded below) : 0000000E
+[0B4h 0180 004h]       Flags (decoded below) : 00000010
                             Physical package : 0
-                     ACPI Processor ID valid : 1
-                       Processor is a thread : 1
-                              Node is a leaf : 1
-                    Identical Implementation : 0
-[0B8h 0184 004h]                      Parent : 0000009C
-[0BCh 0188 004h]           ACPI Processor ID : 00000002
+                     ACPI Processor ID valid : 0
+                       Processor is a thread : 0
+                              Node is a leaf : 0
+                    Identical Implementation : 1
+[0B8h 0184 004h]                      Parent : 00000094
+[0BCh 0188 004h]           ACPI Processor ID : 00000000
 [0C0h 0192 004h]     Private Resource Number : 00000000

 [0C4h 0196 001h]               Subtable Type : 00 [Processor Hierarchy Node]
 [0C5h 0197 001h]                      Length : 14
 [0C6h 0198 002h]                    Reserved : 0000
 [0C8h 0200 004h]       Flags (decoded below) : 0000000E
                             Physical package : 0
                      ACPI Processor ID valid : 1
                        Processor is a thread : 1
                               Node is a leaf : 1
                     Identical Implementation : 0
-[0CCh 0204 004h]                      Parent : 0000009C
-[0D0h 0208 004h]           ACPI Processor ID : 00000003
+[0CCh 0204 004h]                      Parent : 000000B0
+[0D0h 0208 004h]           ACPI Processor ID : 00000000
 [0D4h 0212 004h]     Private Resource Number : 00000000

 [0D8h 0216 001h]               Subtable Type : 00 [Processor Hierarchy Node]
 [0D9h 0217 001h]                      Length : 14
 [0DAh 0218 002h]                    Reserved : 0000
-[0DCh 0220 004h]       Flags (decoded below) : 00000010
+[0DCh 0220 004h]       Flags (decoded below) : 0000000E
                             Physical package : 0
-                     ACPI Processor ID valid : 0
-                       Processor is a thread : 0
-                              Node is a leaf : 0
-                    Identical Implementation : 1
-[0E0h 0224 004h]                      Parent : 00000038
+                     ACPI Processor ID valid : 1
+                       Processor is a thread : 1
+                              Node is a leaf : 1
+                    Identical Implementation : 0
+[0E0h 0224 004h]                      Parent : 000000B0
 [0E4h 0228 004h]           ACPI Processor ID : 00000001
 [0E8h 0232 004h]     Private Resource Number : 00000000

 [0ECh 0236 001h]               Subtable Type : 00 [Processor Hierarchy Node]
 [0EDh 0237 001h]                      Length : 14
 [0EEh 0238 002h]                    Reserved : 0000
 [0F0h 0240 004h]       Flags (decoded below) : 00000010
                             Physical package : 0
                      ACPI Processor ID valid : 0
                        Processor is a thread : 0
                               Node is a leaf : 0
                     Identical Implementation : 1
-[0F4h 0244 004h]                      Parent : 000000D8
-[0F8h 0248 004h]           ACPI Processor ID : 00000000
+[0F4h 0244 004h]                      Parent : 00000094
+[0F8h 0248 004h]           ACPI Processor ID : 00000001
 [0FCh 0252 004h]     Private Resource Number : 00000000

 [100h 0256 001h]               Subtable Type : 00 [Processor Hierarchy Node]
 [101h 0257 001h]                      Length : 14
 [102h 0258 002h]                    Reserved : 0000
 [104h 0260 004h]       Flags (decoded below) : 0000000E
                             Physical package : 0
                      ACPI Processor ID valid : 1
                        Processor is a thread : 1
                               Node is a leaf : 1
                     Identical Implementation : 0
 [108h 0264 004h]                      Parent : 000000EC
-[10Ch 0268 004h]           ACPI Processor ID : 00000004
+[10Ch 0268 004h]           ACPI Processor ID : 00000002
 [110h 0272 004h]     Private Resource Number : 00000000

 [114h 0276 001h]               Subtable Type : 00 [Processor Hierarchy Node]
 [115h 0277 001h]                      Length : 14
 [116h 0278 002h]                    Reserved : 0000
 [118h 0280 004h]       Flags (decoded below) : 0000000E
                             Physical package : 0
                      ACPI Processor ID valid : 1
                        Processor is a thread : 1
                               Node is a leaf : 1
                     Identical Implementation : 0
 [11Ch 0284 004h]                      Parent : 000000EC
-[120h 0288 004h]           ACPI Processor ID : 00000005
+[120h 0288 004h]           ACPI Processor ID : 00000003
 [124h 0292 004h]     Private Resource Number : 00000000

-[128h 0296 001h]               Subtable Type : 00 [Processor Hierarchy Node]
-[129h 0297 001h]                      Length : 14
+[128h 0296 001h]               Subtable Type : 01 [Cache Type]
+[129h 0297 001h]                      Length : 18
 [12Ah 0298 002h]                    Reserved : 0000
-[12Ch 0300 004h]       Flags (decoded below) : 00000010
+[12Ch 0300 004h]       Flags (decoded below) : 0000007F
+                                  Size valid : 1
+                        Number of Sets valid : 1
+                         Associativity valid : 1
+                       Allocation Type valid : 1
+                            Cache Type valid : 1
+                          Write Policy valid : 1
+                             Line Size valid : 1
+                              Cache ID valid : 0
+[130h 0304 004h]         Next Level of Cache : 00000000
+[134h 0308 004h]                        Size : 00200000
+[138h 0312 004h]              Number of Sets : 00000800
+[13Ch 0316 001h]               Associativity : 10
+[13Dh 0317 001h]                  Attributes : 0F
+                             Allocation Type : 3
+                                  Cache Type : 3
+                                Write Policy : 0
+[13Eh 0318 002h]                   Line Size : 0040
+
+[140h 0320 001h]               Subtable Type : 01 [Cache Type]
+[141h 0321 001h]                      Length : 18
+[142h 0322 002h]                    Reserved : 0000
+[144h 0324 004h]       Flags (decoded below) : 0000007F
+                                  Size valid : 1
+                        Number of Sets valid : 1
+                         Associativity valid : 1
+                       Allocation Type valid : 1
+                            Cache Type valid : 1
+                          Write Policy valid : 1
+                             Line Size valid : 1
+                              Cache ID valid : 0
+[148h 0328 004h]         Next Level of Cache : 00000128
+[14Ch 0332 004h]                        Size : 00008000
+[150h 0336 004h]              Number of Sets : 00000080
+[154h 0340 001h]               Associativity : 04
+[155h 0341 001h]                  Attributes : 03
+                             Allocation Type : 3
+                                  Cache Type : 0
+                                Write Policy : 0
+[156h 0342 002h]                   Line Size : 0040
+
+[158h 0344 001h]               Subtable Type : 01 [Cache Type]
+[159h 0345 001h]                      Length : 18
+[15Ah 0346 002h]                    Reserved : 0000
+[15Ch 0348 004h]       Flags (decoded below) : 0000007F
+                                  Size valid : 1
+                        Number of Sets valid : 1
+                         Associativity valid : 1
+                       Allocation Type valid : 1
+                            Cache Type valid : 1
+                          Write Policy valid : 1
+                             Line Size valid : 1
+                              Cache ID valid : 0
+[160h 0352 004h]         Next Level of Cache : 00000128
+[164h 0356 004h]                        Size : 0000C000
+[168h 0360 004h]              Number of Sets : 00000100
+[16Ch 0364 001h]               Associativity : 03
+[16Dh 0365 001h]                  Attributes : 07
+                             Allocation Type : 3
+                                  Cache Type : 1
+                                Write Policy : 0
+[16Eh 0366 002h]                   Line Size : 0040
+
+[170h 0368 001h]               Subtable Type : 00 [Processor Hierarchy Node]
+[171h 0369 001h]                      Length : 1C
+[172h 0370 002h]                    Reserved : 0000
+[174h 0372 004h]       Flags (decoded below) : 00000010
+                            Physical package : 0
+                     ACPI Processor ID valid : 0
+                       Processor is a thread : 0
+                              Node is a leaf : 0
+                    Identical Implementation : 1
+[178h 0376 004h]                      Parent : 00000038
+[17Ch 0380 004h]           ACPI Processor ID : 00000001
+[180h 0384 004h]     Private Resource Number : 00000002
+[184h 0388 004h]            Private Resource : 00000158
+[188h 0392 004h]            Private Resource : 00000140
+
+[18Ch 0396 001h]               Subtable Type : 00 [Processor Hierarchy Node]
+[18Dh 0397 001h]                      Length : 14
+[18Eh 0398 002h]                    Reserved : 0000
+[190h 0400 004h]       Flags (decoded below) : 00000010
+                            Physical package : 0
+                     ACPI Processor ID valid : 0
+                       Processor is a thread : 0
+                              Node is a leaf : 0
+                    Identical Implementation : 1
+[194h 0404 004h]                      Parent : 00000170
+[198h 0408 004h]           ACPI Processor ID : 00000000
+[19Ch 0412 004h]     Private Resource Number : 00000000
+
+[1A0h 0416 001h]               Subtable Type : 00 [Processor Hierarchy Node]
+[1A1h 0417 001h]                      Length : 14
+[1A2h 0418 002h]                    Reserved : 0000
+[1A4h 0420 004h]       Flags (decoded below) : 0000000E
+                            Physical package : 0
+                     ACPI Processor ID valid : 1
+                       Processor is a thread : 1
+                              Node is a leaf : 1
+                    Identical Implementation : 0
+[1A8h 0424 004h]                      Parent : 0000018C
+[1ACh 0428 004h]           ACPI Processor ID : 00000004
+[1B0h 0432 004h]     Private Resource Number : 00000000
+
+[1B4h 0436 001h]               Subtable Type : 00 [Processor Hierarchy Node]
+[1B5h 0437 001h]                      Length : 14
+[1B6h 0438 002h]                    Reserved : 0000
+[1B8h 0440 004h]       Flags (decoded below) : 0000000E
+                            Physical package : 0
+                     ACPI Processor ID valid : 1
+                       Processor is a thread : 1
+                              Node is a leaf : 1
+                    Identical Implementation : 0
+[1BCh 0444 004h]                      Parent : 0000018C
+[1C0h 0448 004h]           ACPI Processor ID : 00000005
+[1C4h 0452 004h]     Private Resource Number : 00000000
+
+[1C8h 0456 001h]               Subtable Type : 00 [Processor Hierarchy Node]
+[1C9h 0457 001h]                      Length : 14
+[1CAh 0458 002h]                    Reserved : 0000
+[1CCh 0460 004h]       Flags (decoded below) : 00000010
                             Physical package : 0
                      ACPI Processor ID valid : 0
                        Processor is a thread : 0
                               Node is a leaf : 0
                     Identical Implementation : 1
-[130h 0304 004h]                      Parent : 000000D8
-[134h 0308 004h]           ACPI Processor ID : 00000001
-[138h 0312 004h]     Private Resource Number : 00000000
-
-[13Ch 0316 001h]               Subtable Type : 00 [Processor Hierarchy Node]
-[13Dh 0317 001h]                      Length : 14
-[13Eh 0318 002h]                    Reserved : 0000
-[140h 0320 004h]       Flags (decoded below) : 0000000E
+[1D0h 0464 004h]                      Parent : 00000170
+[1D4h 0468 004h]           ACPI Processor ID : 00000001
+[1D8h 0472 004h]     Private Resource Number : 00000000
+
+[1DCh 0476 001h]               Subtable Type : 00 [Processor Hierarchy Node]
+[1DDh 0477 001h]                      Length : 14
+[1DEh 0478 002h]                    Reserved : 0000
+[1E0h 0480 004h]       Flags (decoded below) : 0000000E
                             Physical package : 0
                      ACPI Processor ID valid : 1
                        Processor is a thread : 1
                               Node is a leaf : 1
                     Identical Implementation : 0
-[144h 0324 004h]                      Parent : 00000128
-[148h 0328 004h]           ACPI Processor ID : 00000006
-[14Ch 0332 004h]     Private Resource Number : 00000000
-
-[150h 0336 001h]               Subtable Type : 00 [Processor Hierarchy Node]
-[151h 0337 001h]                      Length : 14
-[152h 0338 002h]                    Reserved : 0000
-[154h 0340 004h]       Flags (decoded below) : 0000000E
+[1E4h 0484 004h]                      Parent : 000001C8
+[1E8h 0488 004h]           ACPI Processor ID : 00000006
+[1ECh 0492 004h]     Private Resource Number : 00000000
+
+[1F0h 0496 001h]               Subtable Type : 00 [Processor Hierarchy Node]
+[1F1h 0497 001h]                      Length : 14
+[1F2h 0498 002h]                    Reserved : 0000
+[1F4h 0500 004h]       Flags (decoded below) : 0000000E
                             Physical package : 0
                      ACPI Processor ID valid : 1
                        Processor is a thread : 1
                               Node is a leaf : 1
                     Identical Implementation : 0
-[158h 0344 004h]                      Parent : 00000128
-[15Ch 0348 004h]           ACPI Processor ID : 00000007
-[160h 0352 004h]     Private Resource Number : 00000000
+[1F8h 0504 004h]                      Parent : 000001C8
+[1FCh 0508 004h]           ACPI Processor ID : 00000007
+[200h 0512 004h]     Private Resource Number : 00000000

-Raw Table Data: Length 356 (0x164)
+Raw Table Data: Length 516 (0x204)

-    0000: 50 50 54 54 64 01 00 00 02 97 42 4F 43 48 53 20  // PPTTd.....BOCHS
+    0000: 50 50 54 54 04 02 00 00 02 B8 42 4F 43 48 53 20  // PPTT......BOCHS
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
+    0040: 24 00 00 00 00 00 00 00 00 00 00 00 01 18 00 00  // $...............
+    0050: 7F 00 00 00 00 00 00 00 00 00 20 00 00 08 00 00  // .......... .....
+    0060: 10 0F 40 00 01 18 00 00 7F 00 00 00 4C 00 00 00  // ..@.........L...
+    0070: 00 80 00 00 80 00 00 00 04 03 40 00 01 18 00 00  // ..........@.....
+    0080: 7F 00 00 00 4C 00 00 00 00 C0 00 00 00 01 00 00  // ....L...........
+    0090: 03 07 40 00 00 1C 00 00 10 00 00 00 38 00 00 00  // ..@.........8...
+    00A0: 00 00 00 00 02 00 00 00 7C 00 00 00 64 00 00 00  // ........|...d...
+    00B0: 00 14 00 00 10 00 00 00 94 00 00 00 00 00 00 00  // ................
+    00C0: 00 00 00 00 00 14 00 00 0E 00 00 00 B0 00 00 00  // ................
+    00D0: 00 00 00 00 00 00 00 00 00 14 00 00 0E 00 00 00  // ................
+    00E0: B0 00 00 00 01 00 00 00 00 00 00 00 00 14 00 00  // ................
+    00F0: 10 00 00 00 94 00 00 00 01 00 00 00 00 00 00 00  // ................
+    0100: 00 14 00 00 0E 00 00 00 EC 00 00 00 02 00 00 00  // ................
     0110: 00 00 00 00 00 14 00 00 0E 00 00 00 EC 00 00 00  // ................
-    0120: 05 00 00 00 00 00 00 00 00 14 00 00 10 00 00 00  // ................
-    0130: D8 00 00 00 01 00 00 00 00 00 00 00 00 14 00 00  // ................
-    0140: 0E 00 00 00 28 01 00 00 06 00 00 00 00 00 00 00  // ....(...........
-    0150: 00 14 00 00 0E 00 00 00 28 01 00 00 07 00 00 00  // ........(.......
-    0160: 00 00 00 00                                      // ....
+    0120: 03 00 00 00 00 00 00 00 01 18 00 00 7F 00 00 00  // ................
+    0130: 00 00 00 00 00 00 20 00 00 08 00 00 10 0F 40 00  // ...... .......@.
+    0140: 01 18 00 00 7F 00 00 00 28 01 00 00 00 80 00 00  // ........(.......
+    0150: 80 00 00 00 04 03 40 00 01 18 00 00 7F 00 00 00  // ......@.........
+    0160: 28 01 00 00 00 C0 00 00 00 01 00 00 03 07 40 00  // (.............@.
+    0170: 00 1C 00 00 10 00 00 00 38 00 00 00 01 00 00 00  // ........8.......
+    0180: 02 00 00 00 58 01 00 00 40 01 00 00 00 14 00 00  // ....X...@.......
+    0190: 10 00 00 00 70 01 00 00 00 00 00 00 00 00 00 00  // ....p...........
+    01A0: 00 14 00 00 0E 00 00 00 8C 01 00 00 04 00 00 00  // ................
+    01B0: 00 00 00 00 00 14 00 00 0E 00 00 00 8C 01 00 00  // ................
+    01C0: 05 00 00 00 00 00 00 00 00 14 00 00 10 00 00 00  // ................
+    01D0: 70 01 00 00 01 00 00 00 00 00 00 00 00 14 00 00  // p...............
+    01E0: 0E 00 00 00 C8 01 00 00 06 00 00 00 00 00 00 00  // ................
+    01F0: 00 14 00 00 0E 00 00 00 C8 01 00 00 07 00 00 00  // ................
+    0200: 00 00 00 00                                      // ....

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
---
 tests/data/acpi/aarch64/virt/PPTT.topology  | Bin 356 -> 516 bytes
 tests/qtest/bios-tables-test-allowed-diff.h |   3 ---
 2 files changed, 3 deletions(-)

diff --git a/tests/data/acpi/aarch64/virt/PPTT.topology b/tests/data/acpi/aarch64/virt/PPTT.topology
index 6b864f035c9f48845e9a3beb482c5171074864a5..4f9472c5f728f3068d1054d5042b85190bdb88da 100644
GIT binary patch
literal 516
zcmZvXy$!-Z4255QAXNNF6ciL!P%r{zlr$7bL?T57U;qX{A_Gt|2qk4ohG7Wa3wP0p
z#END6^S#(Ein5GDAbe%Ve19@oRpf>i08p-oC9qKR&9aThf)#M<Y6DDw`7DLw2leXq
zLmd6_hCL38k`!1|$8txPaXnn=XBC{Q-b1-FvMKYYs}()g-e8&2`b^pnU2|HqTCvC?
zcf+qVz1z0>Vcoy2<qdlSw@IRz6_Zp2=W4%;a%XmzJ6SxyMjmt8PHwetg0c5b_lhN!
FeE|+Z9RUCU

literal 356
zcmWFt2nk7HWME*L?&R<65v<@85#X!<1VAAM5F11@h%hh+f@ov_6;nYI69Dopu!#Af
ziSYsX2{^>Sc7o)9c7V(S=|vU;>74__Oh60<Ky@%NW+X9~TafjF#BRXUfM}@RH$Wx}
cOdLs!6-f-H7uh_Jy&6CPHY9a0F?OgJ00?&w0RR91

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index e84d6c6955..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,4 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/aarch64/virt/PPTT",
-"tests/data/acpi/aarch64/virt/PPTT.acpihmatvirt",
-"tests/data/acpi/aarch64/virt/PPTT.topology",
-- 
2.43.0


