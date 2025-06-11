Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A3E6C677C4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 16:02:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPNs6-0005bV-9U; Wed, 11 Jun 2025 12:00:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alireza.sanaee@huawei.com>)
 id 1uPNs0-0005Vw-UI; Wed, 11 Jun 2025 12:00:09 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alireza.sanaee@huawei.com>)
 id 1uPNrw-0000Kt-W0; Wed, 11 Jun 2025 12:00:08 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bHVj51mQWz6GDq1;
 Wed, 11 Jun 2025 23:59:37 +0800 (CST)
Received: from frapeml500003.china.huawei.com (unknown [7.182.85.28])
 by mail.maildlp.com (Postfix) with ESMTPS id 9F2BE1404FA;
 Thu, 12 Jun 2025 00:00:01 +0800 (CST)
Received: from a2303103017.china.huawei.com (10.203.177.99) by
 frapeml500003.china.huawei.com (7.182.85.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 11 Jun 2025 18:00:00 +0200
To: <qemu-devel@nongnu.org>, <mst@redhat.com>
CC: <anisinha@redhat.com>, <armbru@redhat.com>, <berrange@redhat.com>,
 <dapeng1.mi@linux.intel.com>, <eric.auger@redhat.com>,
 <farman@linux.ibm.com>, <gustavo.romero@linaro.org>, <imammedo@redhat.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <linuxarm@huawei.com>, <maobibo@loongson.cn>, <mtosatti@redhat.com>,
 <peter.maydell@linaro.org>, <philmd@linaro.org>, <qemu-arm@nongnu.org>,
 <richard.henderson@linaro.org>, <shameerali.kolothum.thodi@huawei.com>,
 <shannon.zhaosl@gmail.com>, <yangyicong@hisilicon.com>, <zhao1.liu@intel.com>
Subject: [PATCH v13 7/7] Update the ACPI tables based on new aml-build.c
Date: Wed, 11 Jun 2025 16:56:18 +0100
Message-ID: <20250611155618.351-8-alireza.sanaee@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250611155618.351-1-alireza.sanaee@huawei.com>
References: <20250611155618.351-1-alireza.sanaee@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.203.177.99]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 frapeml500003.china.huawei.com (7.182.85.28)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=alireza.sanaee@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
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
 * Disassembly of tests/data/acpi/aarch64/virt/PPTT.topology, Tue Jun  3 13:48:43 2025
 * Disassembly of /tmp/aml-424862, Tue Jun  3 13:48:43 2025
 *
 * ACPI Data Table [PPTT]
 *
 * Format: [HexOffset DecimalOffset ByteLength]  FieldName : FieldValue (in hex)
 */

[000h 0000 004h]                   Signature : "PPTT"    [Processor Properties Topology Table]
[004h 0004 004h]                Table Length : 00000164
[004h 0004 004h]                Table Length : 0000021C
[008h 0008 001h]                    Revision : 02
[009h 0009 001h]                    Checksum : 97
[009h 0009 001h]                    Checksum : 4E
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
@ -34,223 +34,370 @@
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

[04Ch 0076 001h]               Subtable Type : 00 [Processor Hierarchy Node]
[04Dh 0077 001h]                      Length : 14
[04Ch 0076 001h]               Subtable Type : 01 [Cache Type]
[04Dh 0077 001h]                      Length : 1C
[04Eh 0078 002h]                    Reserved : 0000
[050h 0080 004h]       Flags (decoded below) : 00000010
[050h 0080 004h]       Flags (decoded below) : 000000FF
                                  Size valid : 1
                        Number of Sets valid : 1
                         Associativity valid : 1
                       Allocation Type valid : 1
                            Cache Type valid : 1
                          Write Policy valid : 1
                             Line Size valid : 1
                              Cache ID valid : 1
[054h 0084 004h]         Next Level of Cache : 00000000
[058h 0088 004h]                        Size : 00200000
[05Ch 0092 004h]              Number of Sets : 00000800
[060h 0096 001h]               Associativity : 10
[061h 0097 001h]                  Attributes : 0F
                             Allocation Type : 3
                                  Cache Type : 3
                                Write Policy : 0
[062h 0098 002h]                   Line Size : 0040

[068h 0104 001h]               Subtable Type : 01 [Cache Type]
[069h 0105 001h]                      Length : 1C
[06Ah 0106 002h]                    Reserved : 0000
[06Ch 0108 004h]       Flags (decoded below) : 000000FF
                                  Size valid : 1
                        Number of Sets valid : 1
                         Associativity valid : 1
                       Allocation Type valid : 1
                            Cache Type valid : 1
                          Write Policy valid : 1
                             Line Size valid : 1
                              Cache ID valid : 1
[070h 0112 004h]         Next Level of Cache : 0000004C
[074h 0116 004h]                        Size : 00008000
[078h 0120 004h]              Number of Sets : 00000080
[07Ch 0124 001h]               Associativity : 04
[07Dh 0125 001h]                  Attributes : 03
                             Allocation Type : 3
                                  Cache Type : 0
                                Write Policy : 0
[07Eh 0126 002h]                   Line Size : 0040

[084h 0132 001h]               Subtable Type : 01 [Cache Type]
[085h 0133 001h]                      Length : 1C
[086h 0134 002h]                    Reserved : 0000
[088h 0136 004h]       Flags (decoded below) : 000000FF
                                  Size valid : 1
                        Number of Sets valid : 1
                         Associativity valid : 1
                       Allocation Type valid : 1
                            Cache Type valid : 1
                          Write Policy valid : 1
                             Line Size valid : 1
                              Cache ID valid : 1
[08Ch 0140 004h]         Next Level of Cache : 0000004C
[090h 0144 004h]                        Size : 0000C000
[094h 0148 004h]              Number of Sets : 00000100
[098h 0152 001h]               Associativity : 03
[099h 0153 001h]                  Attributes : 07
                             Allocation Type : 3
                                  Cache Type : 1
                                Write Policy : 0
[09Ah 0154 002h]                   Line Size : 0040

[0A0h 0160 001h]               Subtable Type : 00 [Processor Hierarchy Node]
[0A1h 0161 001h]                      Length : 1C
[0A2h 0162 002h]                    Reserved : 0000
[0A4h 0164 004h]       Flags (decoded below) : 00000010
                            Physical package : 0
                     ACPI Processor ID valid : 0
                       Processor is a thread : 0
                              Node is a leaf : 0
                    Identical Implementation : 1
[054h 0084 004h]                      Parent : 00000038
[058h 0088 004h]           ACPI Processor ID : 00000000
[05Ch 0092 004h]     Private Resource Number : 00000000

[060h 0096 001h]               Subtable Type : 00 [Processor Hierarchy Node]
[061h 0097 001h]                      Length : 14
[062h 0098 002h]                    Reserved : 0000
[064h 0100 004h]       Flags (decoded below) : 00000010
[0A8h 0168 004h]                      Parent : 00000038
[0ACh 0172 004h]           ACPI Processor ID : 00000000
[0B0h 0176 004h]     Private Resource Number : 00000002
[0B4h 0180 004h]            Private Resource : 00000084
[0B8h 0184 004h]            Private Resource : 00000068

[0BCh 0188 001h]               Subtable Type : 00 [Processor Hierarchy Node]
[0BDh 0189 001h]                      Length : 14
[0BEh 0190 002h]                    Reserved : 0000
[0C0h 0192 004h]       Flags (decoded below) : 00000010
                            Physical package : 0
                     ACPI Processor ID valid : 0
                       Processor is a thread : 0
                              Node is a leaf : 0
                    Identical Implementation : 1
[068h 0104 004h]                      Parent : 0000004C
[06Ch 0108 004h]           ACPI Processor ID : 00000000
[070h 0112 004h]     Private Resource Number : 00000000

[074h 0116 001h]               Subtable Type : 00 [Processor Hierarchy Node]
[075h 0117 001h]                      Length : 14
[076h 0118 002h]                    Reserved : 0000
[078h 0120 004h]       Flags (decoded below) : 0000000E
[0C4h 0196 004h]                      Parent : 000000A0
[0C8h 0200 004h]           ACPI Processor ID : 00000000
[0CCh 0204 004h]     Private Resource Number : 00000000

[0D0h 0208 001h]               Subtable Type : 00 [Processor Hierarchy Node]
[0D1h 0209 001h]                      Length : 14
[0D2h 0210 002h]                    Reserved : 0000
[0D4h 0212 004h]       Flags (decoded below) : 0000000E
                            Physical package : 0
                     ACPI Processor ID valid : 1
                       Processor is a thread : 1
                              Node is a leaf : 1
                    Identical Implementation : 0
[07Ch 0124 004h]                      Parent : 00000060
[080h 0128 004h]           ACPI Processor ID : 00000000
[084h 0132 004h]     Private Resource Number : 00000000

[088h 0136 001h]               Subtable Type : 00 [Processor Hierarchy Node]
[089h 0137 001h]                      Length : 14
[08Ah 0138 002h]                    Reserved : 0000
[08Ch 0140 004h]       Flags (decoded below) : 0000000E
[0D8h 0216 004h]                      Parent : 000000BC
[0DCh 0220 004h]           ACPI Processor ID : 00000000
[0E0h 0224 004h]     Private Resource Number : 00000000

[0E4h 0228 001h]               Subtable Type : 00 [Processor Hierarchy Node]
[0E5h 0229 001h]                      Length : 14
[0E6h 0230 002h]                    Reserved : 0000
[0E8h 0232 004h]       Flags (decoded below) : 0000000E
                            Physical package : 0
                     ACPI Processor ID valid : 1
                       Processor is a thread : 1
                              Node is a leaf : 1
                    Identical Implementation : 0
[090h 0144 004h]                      Parent : 00000060
[094h 0148 004h]           ACPI Processor ID : 00000001
[098h 0152 004h]     Private Resource Number : 00000000

[09Ch 0156 001h]               Subtable Type : 00 [Processor Hierarchy Node]
[09Dh 0157 001h]                      Length : 14
[09Eh 0158 002h]                    Reserved : 0000
[0A0h 0160 004h]       Flags (decoded below) : 00000010
[0ECh 0236 004h]                      Parent : 000000BC
[0F0h 0240 004h]           ACPI Processor ID : 00000001
[0F4h 0244 004h]     Private Resource Number : 00000000

[0F8h 0248 001h]               Subtable Type : 00 [Processor Hierarchy Node]
[0F9h 0249 001h]                      Length : 14
[0FAh 0250 002h]                    Reserved : 0000
[0FCh 0252 004h]       Flags (decoded below) : 00000010
                            Physical package : 0
                     ACPI Processor ID valid : 0
                       Processor is a thread : 0
                              Node is a leaf : 0
                    Identical Implementation : 1
[0A4h 0164 004h]                      Parent : 0000004C
[0A8h 0168 004h]           ACPI Processor ID : 00000001
[0ACh 0172 004h]     Private Resource Number : 00000000

[0B0h 0176 001h]               Subtable Type : 00 [Processor Hierarchy Node]
[0B1h 0177 001h]                      Length : 14
[0B2h 0178 002h]                    Reserved : 0000
[0B4h 0180 004h]       Flags (decoded below) : 0000000E
[100h 0256 004h]                      Parent : 000000A0
[104h 0260 004h]           ACPI Processor ID : 00000001
[108h 0264 004h]     Private Resource Number : 00000000

[10Ch 0268 001h]               Subtable Type : 00 [Processor Hierarchy Node]
[10Dh 0269 001h]                      Length : 14
[10Eh 0270 002h]                    Reserved : 0000
[110h 0272 004h]       Flags (decoded below) : 0000000E
                            Physical package : 0
                     ACPI Processor ID valid : 1
                       Processor is a thread : 1
                              Node is a leaf : 1
                    Identical Implementation : 0
[0B8h 0184 004h]                      Parent : 0000009C
[0BCh 0188 004h]           ACPI Processor ID : 00000002
[0C0h 0192 004h]     Private Resource Number : 00000000

[0C4h 0196 001h]               Subtable Type : 00 [Processor Hierarchy Node]
[0C5h 0197 001h]                      Length : 14
[0C6h 0198 002h]                    Reserved : 0000
[0C8h 0200 004h]       Flags (decoded below) : 0000000E
[114h 0276 004h]                      Parent : 000000F8
[118h 0280 004h]           ACPI Processor ID : 00000002
[11Ch 0284 004h]     Private Resource Number : 00000000

[120h 0288 001h]               Subtable Type : 00 [Processor Hierarchy Node]
[121h 0289 001h]                      Length : 14
[122h 0290 002h]                    Reserved : 0000
[124h 0292 004h]       Flags (decoded below) : 0000000E
                            Physical package : 0
                     ACPI Processor ID valid : 1
                       Processor is a thread : 1
                              Node is a leaf : 1
                    Identical Implementation : 0
[0CCh 0204 004h]                      Parent : 0000009C
[0D0h 0208 004h]           ACPI Processor ID : 00000003
[0D4h 0212 004h]     Private Resource Number : 00000000

[0D8h 0216 001h]               Subtable Type : 00 [Processor Hierarchy Node]
[0D9h 0217 001h]                      Length : 14
[0DAh 0218 002h]                    Reserved : 0000
[0DCh 0220 004h]       Flags (decoded below) : 00000010
[128h 0296 004h]                      Parent : 000000F8
[12Ch 0300 004h]           ACPI Processor ID : 00000003
[130h 0304 004h]     Private Resource Number : 00000000

[134h 0308 001h]               Subtable Type : 01 [Cache Type]
[135h 0309 001h]                      Length : 1C
[136h 0310 002h]                    Reserved : 0000
[138h 0312 004h]       Flags (decoded below) : 000000FF
                                  Size valid : 1
                        Number of Sets valid : 1
                         Associativity valid : 1
                       Allocation Type valid : 1
                            Cache Type valid : 1
                          Write Policy valid : 1
                             Line Size valid : 1
                              Cache ID valid : 1
[13Ch 0316 004h]         Next Level of Cache : 00000000
[140h 0320 004h]                        Size : 00200000
[144h 0324 004h]              Number of Sets : 00000800
[148h 0328 001h]               Associativity : 10
[149h 0329 001h]                  Attributes : 0F
                             Allocation Type : 3
                                  Cache Type : 3
                                Write Policy : 0
[14Ah 0330 002h]                   Line Size : 0040

[150h 0336 001h]               Subtable Type : 01 [Cache Type]
[151h 0337 001h]                      Length : 1C
[152h 0338 002h]                    Reserved : 0000
[154h 0340 004h]       Flags (decoded below) : 000000FF
                                  Size valid : 1
                        Number of Sets valid : 1
                         Associativity valid : 1
                       Allocation Type valid : 1
                            Cache Type valid : 1
                          Write Policy valid : 1
                             Line Size valid : 1
                              Cache ID valid : 1
[158h 0344 004h]         Next Level of Cache : 00000134
[15Ch 0348 004h]                        Size : 00008000
[160h 0352 004h]              Number of Sets : 00000080
[164h 0356 001h]               Associativity : 04
[165h 0357 001h]                  Attributes : 03
                             Allocation Type : 3
                                  Cache Type : 0
                                Write Policy : 0
[166h 0358 002h]                   Line Size : 0040

[16Ch 0364 001h]               Subtable Type : 01 [Cache Type]
[16Dh 0365 001h]                      Length : 1C
[16Eh 0366 002h]                    Reserved : 0000
[170h 0368 004h]       Flags (decoded below) : 000000FF
                                  Size valid : 1
                        Number of Sets valid : 1
                         Associativity valid : 1
                       Allocation Type valid : 1
                            Cache Type valid : 1
                          Write Policy valid : 1
                             Line Size valid : 1
                              Cache ID valid : 1
[174h 0372 004h]         Next Level of Cache : 00000134
[178h 0376 004h]                        Size : 0000C000
[17Ch 0380 004h]              Number of Sets : 00000100
[180h 0384 001h]               Associativity : 03
[181h 0385 001h]                  Attributes : 07
                             Allocation Type : 3
                                  Cache Type : 1
                                Write Policy : 0
[182h 0386 002h]                   Line Size : 0040

[188h 0392 001h]               Subtable Type : 00 [Processor Hierarchy Node]
[189h 0393 001h]                      Length : 1C
[18Ah 0394 002h]                    Reserved : 0000
[18Ch 0396 004h]       Flags (decoded below) : 00000010
                            Physical package : 0
                     ACPI Processor ID valid : 0
                       Processor is a thread : 0
                              Node is a leaf : 0
                    Identical Implementation : 1
[0E0h 0224 004h]                      Parent : 00000038
[0E4h 0228 004h]           ACPI Processor ID : 00000001
[0E8h 0232 004h]     Private Resource Number : 00000000

[0ECh 0236 001h]               Subtable Type : 00 [Processor Hierarchy Node]
[0EDh 0237 001h]                      Length : 14
[0EEh 0238 002h]                    Reserved : 0000
[0F0h 0240 004h]       Flags (decoded below) : 00000010
[190h 0400 004h]                      Parent : 00000038
[194h 0404 004h]           ACPI Processor ID : 00000001
[198h 0408 004h]     Private Resource Number : 00000002
[19Ch 0412 004h]            Private Resource : 0000016C
[1A0h 0416 004h]            Private Resource : 00000150

[1A4h 0420 001h]               Subtable Type : 00 [Processor Hierarchy Node]
[1A5h 0421 001h]                      Length : 14
[1A6h 0422 002h]                    Reserved : 0000
[1A8h 0424 004h]       Flags (decoded below) : 00000010
                            Physical package : 0
                     ACPI Processor ID valid : 0
                       Processor is a thread : 0
                              Node is a leaf : 0
                    Identical Implementation : 1
[0F4h 0244 004h]                      Parent : 000000D8
[0F8h 0248 004h]           ACPI Processor ID : 00000000
[0FCh 0252 004h]     Private Resource Number : 00000000

[100h 0256 001h]               Subtable Type : 00 [Processor Hierarchy Node]
[101h 0257 001h]                      Length : 14
[102h 0258 002h]                    Reserved : 0000
[104h 0260 004h]       Flags (decoded below) : 0000000E
[1ACh 0428 004h]                      Parent : 00000188
[1B0h 0432 004h]           ACPI Processor ID : 00000000
[1B4h 0436 004h]     Private Resource Number : 00000000

[1B8h 0440 001h]               Subtable Type : 00 [Processor Hierarchy Node]
[1B9h 0441 001h]                      Length : 14
[1BAh 0442 002h]                    Reserved : 0000
[1BCh 0444 004h]       Flags (decoded below) : 0000000E
                            Physical package : 0
                     ACPI Processor ID valid : 1
                       Processor is a thread : 1
                              Node is a leaf : 1
                    Identical Implementation : 0
[108h 0264 004h]                      Parent : 000000EC
[10Ch 0268 004h]           ACPI Processor ID : 00000004
[110h 0272 004h]     Private Resource Number : 00000000

[114h 0276 001h]               Subtable Type : 00 [Processor Hierarchy Node]
[115h 0277 001h]                      Length : 14
[116h 0278 002h]                    Reserved : 0000
[118h 0280 004h]       Flags (decoded below) : 0000000E
[1C0h 0448 004h]                      Parent : 000001A4
[1C4h 0452 004h]           ACPI Processor ID : 00000004
[1C8h 0456 004h]     Private Resource Number : 00000000

[1CCh 0460 001h]               Subtable Type : 00 [Processor Hierarchy Node]
[1CDh 0461 001h]                      Length : 14
[1CEh 0462 002h]                    Reserved : 0000
[1D0h 0464 004h]       Flags (decoded below) : 0000000E
                            Physical package : 0
                     ACPI Processor ID valid : 1
                       Processor is a thread : 1
                              Node is a leaf : 1
                    Identical Implementation : 0
[11Ch 0284 004h]                      Parent : 000000EC
[120h 0288 004h]           ACPI Processor ID : 00000005
[124h 0292 004h]     Private Resource Number : 00000000

[128h 0296 001h]               Subtable Type : 00 [Processor Hierarchy Node]
[129h 0297 001h]                      Length : 14
[12Ah 0298 002h]                    Reserved : 0000
[12Ch 0300 004h]       Flags (decoded below) : 00000010
[1D4h 0468 004h]                      Parent : 000001A4
[1D8h 0472 004h]           ACPI Processor ID : 00000005
[1DCh 0476 004h]     Private Resource Number : 00000000

[1E0h 0480 001h]               Subtable Type : 00 [Processor Hierarchy Node]
[1E1h 0481 001h]                      Length : 14
[1E2h 0482 002h]                    Reserved : 0000
[1E4h 0484 004h]       Flags (decoded below) : 00000010
                            Physical package : 0
                     ACPI Processor ID valid : 0
                       Processor is a thread : 0
                              Node is a leaf : 0
                    Identical Implementation : 1
[130h 0304 004h]                      Parent : 000000D8
[134h 0308 004h]           ACPI Processor ID : 00000001
[138h 0312 004h]     Private Resource Number : 00000000

[13Ch 0316 001h]               Subtable Type : 00 [Processor Hierarchy Node]
[13Dh 0317 001h]                      Length : 14
[13Eh 0318 002h]                    Reserved : 0000
[140h 0320 004h]       Flags (decoded below) : 0000000E
[1E8h 0488 004h]                      Parent : 00000188
[1ECh 0492 004h]           ACPI Processor ID : 00000001
[1F0h 0496 004h]     Private Resource Number : 00000000

[1F4h 0500 001h]               Subtable Type : 00 [Processor Hierarchy Node]
[1F5h 0501 001h]                      Length : 14
[1F6h 0502 002h]                    Reserved : 0000
[1F8h 0504 004h]       Flags (decoded below) : 0000000E
                            Physical package : 0
                     ACPI Processor ID valid : 1
                       Processor is a thread : 1
                              Node is a leaf : 1
                    Identical Implementation : 0
[144h 0324 004h]                      Parent : 00000128
[148h 0328 004h]           ACPI Processor ID : 00000006
[14Ch 0332 004h]     Private Resource Number : 00000000

[150h 0336 001h]               Subtable Type : 00 [Processor Hierarchy Node]
[151h 0337 001h]                      Length : 14
[152h 0338 002h]                    Reserved : 0000
[154h 0340 004h]       Flags (decoded below) : 0000000E
[1FCh 0508 004h]                      Parent : 000001E0
[200h 0512 004h]           ACPI Processor ID : 00000006
[204h 0516 004h]     Private Resource Number : 00000000

[208h 0520 001h]               Subtable Type : 00 [Processor Hierarchy Node]
[209h 0521 001h]                      Length : 14
[20Ah 0522 002h]                    Reserved : 0000
[20Ch 0524 004h]       Flags (decoded below) : 0000000E
                            Physical package : 0
                     ACPI Processor ID valid : 1
                       Processor is a thread : 1
                              Node is a leaf : 1
                    Identical Implementation : 0
[158h 0344 004h]                      Parent : 00000128
[15Ch 0348 004h]           ACPI Processor ID : 00000007
[160h 0352 004h]     Private Resource Number : 00000000
[210h 0528 004h]                      Parent : 000001E0
[214h 0532 004h]           ACPI Processor ID : 00000007
[218h 0536 004h]     Private Resource Number : 00000000

Raw Table Data: Length 356 (0x164)
Raw Table Data: Length 540 (0x21C)

    0000: 50 50 54 54 64 01 00 00 02 97 42 4F 43 48 53 20  // PPTTd.....BOCHS
    0000: 50 50 54 54 1C 02 00 00 02 4E 42 4F 43 48 53 20  // PPTT.....NBOCHS
    0010: 42 58 50 43 20 20 20 20 01 00 00 00 42 58 50 43  // BXPC    ....BXPC
    0020: 01 00 00 00 00 14 00 00 11 00 00 00 00 00 00 00  // ................
    0030: 00 00 00 00 00 00 00 00 00 14 00 00 11 00 00 00  // ................
    0040: 24 00 00 00 00 00 00 00 00 00 00 00 00 14 00 00  // $...............
    0050: 10 00 00 00 38 00 00 00 00 00 00 00 00 00 00 00  // ....8...........
    0060: 00 14 00 00 10 00 00 00 4C 00 00 00 00 00 00 00  // ........L.......
    0070: 00 00 00 00 00 14 00 00 0E 00 00 00 60 00 00 00  // ............`...
    0080: 00 00 00 00 00 00 00 00 00 14 00 00 0E 00 00 00  // ................
    0090: 60 00 00 00 01 00 00 00 00 00 00 00 00 14 00 00  // `...............
    00A0: 10 00 00 00 4C 00 00 00 01 00 00 00 00 00 00 00  // ....L...........
    00B0: 00 14 00 00 0E 00 00 00 9C 00 00 00 02 00 00 00  // ................
    00C0: 00 00 00 00 00 14 00 00 0E 00 00 00 9C 00 00 00  // ................
    00D0: 03 00 00 00 00 00 00 00 00 14 00 00 10 00 00 00  // ................
    00E0: 38 00 00 00 01 00 00 00 00 00 00 00 00 14 00 00  // 8...............
    00F0: 10 00 00 00 D8 00 00 00 00 00 00 00 00 00 00 00  // ................
    0100: 00 14 00 00 0E 00 00 00 EC 00 00 00 04 00 00 00  // ................
    0110: 00 00 00 00 00 14 00 00 0E 00 00 00 EC 00 00 00  // ................
    0120: 05 00 00 00 00 00 00 00 00 14 00 00 10 00 00 00  // ................
    0130: D8 00 00 00 01 00 00 00 00 00 00 00 00 14 00 00  // ................
    0140: 0E 00 00 00 28 01 00 00 06 00 00 00 00 00 00 00  // ....(...........
    0150: 00 14 00 00 0E 00 00 00 28 01 00 00 07 00 00 00  // ........(.......
    0160: 00 00 00 00                                      // ....
    0040: 24 00 00 00 00 00 00 00 00 00 00 00 01 1C 00 00  // $...............
    0050: FF 00 00 00 00 00 00 00 00 00 20 00 00 08 00 00  // .......... .....
    0060: 10 0F 40 00 00 00 02 02 01 1C 00 00 FF 00 00 00  // ..@.............
    0070: 4C 00 00 00 00 80 00 00 80 00 00 00 04 03 40 00  // L.............@.
    0080: 00 00 01 00 01 1C 00 00 FF 00 00 00 4C 00 00 00  // ............L...
    0090: 00 C0 00 00 00 01 00 00 03 07 40 00 00 00 01 01  // ..........@.....
    00A0: 00 1C 00 00 10 00 00 00 38 00 00 00 00 00 00 00  // ........8.......
    00B0: 02 00 00 00 84 00 00 00 68 00 00 00 00 14 00 00  // ........h.......
    00C0: 10 00 00 00 A0 00 00 00 00 00 00 00 00 00 00 00  // ................
    00D0: 00 14 00 00 0E 00 00 00 BC 00 00 00 00 00 00 00  // ................
    00E0: 00 00 00 00 00 14 00 00 0E 00 00 00 BC 00 00 00  // ................
    00F0: 01 00 00 00 00 00 00 00 00 14 00 00 10 00 00 00  // ................
    0100: A0 00 00 00 01 00 00 00 00 00 00 00 00 14 00 00  // ................
    0110: 0E 00 00 00 F8 00 00 00 02 00 00 00 00 00 00 00  // ................
    0120: 00 14 00 00 0E 00 00 00 F8 00 00 00 03 00 00 00  // ................
    0130: 00 00 00 00 01 1C 00 00 FF 00 00 00 00 00 00 00  // ................
    0140: 00 00 20 00 00 08 00 00 10 0F 40 00 04 00 02 02  // .. .......@.....
    0150: 01 1C 00 00 FF 00 00 00 34 01 00 00 00 80 00 00  // ........4.......
    0160: 80 00 00 00 04 03 40 00 04 00 01 00 01 1C 00 00  // ......@.........
    0170: FF 00 00 00 34 01 00 00 00 C0 00 00 00 01 00 00  // ....4...........
    0180: 03 07 40 00 04 00 01 01 00 1C 00 00 10 00 00 00  // ..@.............
    0190: 38 00 00 00 01 00 00 00 02 00 00 00 6C 01 00 00  // 8...........l...
    01A0: 50 01 00 00 00 14 00 00 10 00 00 00 88 01 00 00  // P...............
    01B0: 00 00 00 00 00 00 00 00 00 14 00 00 0E 00 00 00  // ................
    01C0: A4 01 00 00 04 00 00 00 00 00 00 00 00 14 00 00  // ................
    01D0: 0E 00 00 00 A4 01 00 00 05 00 00 00 00 00 00 00  // ................
    01E0: 00 14 00 00 10 00 00 00 88 01 00 00 01 00 00 00  // ................
    01F0: 00 00 00 00 00 14 00 00 0E 00 00 00 E0 01 00 00  // ................
    0200: 06 00 00 00 00 00 00 00 00 14 00 00 0E 00 00 00  // ................
    0210: E0 01 00 00 07 00 00 00 00 00 00 00              // ............

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
---
 tests/data/acpi/aarch64/virt/PPTT.topology  | Bin 356 -> 540 bytes
 tests/qtest/bios-tables-test-allowed-diff.h |   3 ---
 2 files changed, 3 deletions(-)

diff --git a/tests/data/acpi/aarch64/virt/PPTT.topology b/tests/data/acpi/aarch64/virt/PPTT.topology
index 6b864f035c9f48845e9a3beb482c5171074864a5..645b873906fc29f03392ae5ac18853ee59e10100 100644
GIT binary patch
literal 540
zcmZvXI}XAy5JV>*2o(g0GDQlGKtUNL4F!Toq~Hh?93lk;$DrUC6gdjVpo1A>2S;LM
z%e!y9_D)?lO%?*-uH09fLtY;1DrW=$l<UL-nCtYzvZcp@40!i-4orY_R*;0D)3(xE
zvk*rGivR<yGYC;)v;cfFC0cVUI4UmOCl#DQ+D*9&vMKY2t95$J__56O`b@nqZvA7z
z_KHOoxp}{3-usL_pDR7u{(Q!sPos6zc}G5}4ScFq|DT!EDy+||au;^4J6ZgPjXWlw
S>h0TY?~`Ec-II5*#Ig@|7$E@w

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


