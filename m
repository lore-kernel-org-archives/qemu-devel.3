Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A28ECF11CF
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 11:22:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syrEq-00048P-HX; Thu, 10 Oct 2024 07:21:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alireza.sanaee@huawei.com>)
 id 1syrEn-00042b-OD; Thu, 10 Oct 2024 07:21:45 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alireza.sanaee@huawei.com>)
 id 1syrEg-0005NF-Vc; Thu, 10 Oct 2024 07:21:45 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XPS4W3m2Gz6K5sG;
 Thu, 10 Oct 2024 19:21:15 +0800 (CST)
Received: from frapeml500003.china.huawei.com (unknown [7.182.85.28])
 by mail.maildlp.com (Postfix) with ESMTPS id ED6D3140A36;
 Thu, 10 Oct 2024 19:21:35 +0800 (CST)
Received: from a2303103017.china.huawei.com (10.126.168.143) by
 frapeml500003.china.huawei.com (7.182.85.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 10 Oct 2024 13:21:34 +0200
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: <zhao1.liu@intel.com>, <zhenyu.z.wang@intel.com>,
 <dapeng1.mi@linux.intel.com>, <yongwei.ma@intel.com>, <armbru@redhat.com>,
 <farman@linux.ibm.com>, <peter.maydell@linaro.org>, <mst@redhat.com>,
 <anisinha@redhat.com>, <shannon.zhaosl@gmail.com>, <imammedo@redhat.com>,
 <mtosatti@redhat.com>, <berrange@redhat.com>, <richard.henderson@linaro.org>, 
 <linuxarm@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
 <Jonathan.Cameron@Huawei.com>, <jiangkunkun@huawei.com>,
 <yangyicong@hisilicon.com>
Subject: [PATCH v3 6/6] Update the ACPI tables according to the acpi aml_build
 change, also empty bios-tables-test-allowed-diff.h.
Date: Thu, 10 Oct 2024 12:18:22 +0100
Message-ID: <20241010111822.345-7-alireza.sanaee@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241010111822.345-1-alireza.sanaee@huawei.com>
References: <20241010111822.345-1-alireza.sanaee@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.168.143]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 frapeml500003.china.huawei.com (7.182.85.28)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=alireza.sanaee@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

```
test_acpi_one("-M virt,smp-cache.0.cache=l1i,smp-cache.0.topology=cluster,"
                  "smp-cache.1.cache=l1d,smp-cache.1.topology=cluster,"
                  "smp-cache.2.cache=l2,smp-cache.2.topology=cluster,"
                  "smp-cache.3.cache=l3,smp-cache.3.topology=cluster "
                  "-cpu cortex-a57 "
                  "-smp sockets=1,clusters=2,cores=2,threads=2", &data);
```

/*
 * Intel ACPI Component Architecture
 * AML/ASL+ Disassembler version 20200925 (64-bit version)
 * Copyright (c) 2000 - 2020 Intel Corporation
 *
 * Disassembly of ../../../tests/data/acpi/aarch64/virt/PPTT.topology, Mon Oct  7 16:57:29 2024
 *
 * ACPI Data Table [PPTT]
 *
 * Format: [HexOffset DecimalOffset ByteLength]  FieldName : FieldValue
 */

[000h 0000   4]                    Signature : "PPTT"    [Processor Properties Topology Table]
[004h 0004   4]                 Table Length : 0000021C
[008h 0008   1]                     Revision : 03
[009h 0009   1]                     Checksum : 4D
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
[02Ch 0044   4]                       Parent : 00000000
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

[04Ch 0076   1]                Subtable Type : 01 [Cache Type]
[04Dh 0077   1]                       Length : 1C
[04Eh 0078   2]                     Reserved : 0000
[050h 0080   4]        Flags (decoded below) : 000000FF
                                  Size valid : 1
                        Number of Sets valid : 1
                         Associativity valid : 1
                       Allocation Type valid : 1
                            Cache Type valid : 1
                          Write Policy valid : 1
                             Line Size valid : 1
[054h 0084   4]          Next Level of Cache : 00000000
[058h 0088   4]                         Size : 00200000
[05Ch 0092   4]               Number of Sets : 00000800
[060h 0096   1]                Associativity : 10
[061h 0097   1]                   Attributes : 0F
                             Allocation Type : 3
                                  Cache Type : 3
                                Write Policy : 0
[062h 0098   2]                    Line Size : 0040

[068h 0104   1]                Subtable Type : 01 [Cache Type]
[069h 0105   1]                       Length : 1C
[06Ah 0106   2]                     Reserved : 0000
[06Ch 0108   4]        Flags (decoded below) : 000000FF
                                  Size valid : 1
                        Number of Sets valid : 1
                         Associativity valid : 1
                       Allocation Type valid : 1
                            Cache Type valid : 1
                          Write Policy valid : 1
                             Line Size valid : 1
[070h 0112   4]          Next Level of Cache : 0000004C
[074h 0116   4]                         Size : 00008000
[078h 0120   4]               Number of Sets : 00000080
[07Ch 0124   1]                Associativity : 04
[07Dh 0125   1]                   Attributes : 03
                             Allocation Type : 3
                                  Cache Type : 0
                                Write Policy : 0
[07Eh 0126   2]                    Line Size : 0040

[084h 0132   1]                Subtable Type : 01 [Cache Type]
[085h 0133   1]                       Length : 1C
[086h 0134   2]                     Reserved : 0000
[088h 0136   4]        Flags (decoded below) : 000000FF
                                  Size valid : 1
                        Number of Sets valid : 1
                         Associativity valid : 1
                       Allocation Type valid : 1
                            Cache Type valid : 1
                          Write Policy valid : 1
                             Line Size valid : 1
[08Ch 0140   4]          Next Level of Cache : 0000004C
[090h 0144   4]                         Size : 0000C000
[094h 0148   4]               Number of Sets : 00000100
[098h 0152   1]                Associativity : 03
[099h 0153   1]                   Attributes : 07
                             Allocation Type : 3
                                  Cache Type : 1
                                Write Policy : 0
[09Ah 0154   2]                    Line Size : 0040

[0A0h 0160   1]                Subtable Type : 00 [Processor Hierarchy Node]
[0A1h 0161   1]                       Length : 1C
[0A2h 0162   2]                     Reserved : 0000
[0A4h 0164   4]        Flags (decoded below) : 00000010
                            Physical package : 0
                     ACPI Processor ID valid : 0
                       Processor is a thread : 0
                              Node is a leaf : 0
                    Identical Implementation : 1
[0A8h 0168   4]                       Parent : 00000038
[0ACh 0172   4]            ACPI Processor ID : 00000000
[0B0h 0176   4]      Private Resource Number : 00000002
[0B4h 0180   4]             Private Resource : 00000084
[0B8h 0184   4]             Private Resource : 00000068

[0BCh 0188   1]                Subtable Type : 00 [Processor Hierarchy Node]
[0BDh 0189   1]                       Length : 14
[0BEh 0190   2]                     Reserved : 0000
[0C0h 0192   4]        Flags (decoded below) : 00000010
                            Physical package : 0
                     ACPI Processor ID valid : 0
                       Processor is a thread : 0
                              Node is a leaf : 0
                    Identical Implementation : 1
[0C4h 0196   4]                       Parent : 000000A0
[0C8h 0200   4]            ACPI Processor ID : 00000000
[0CCh 0204   4]      Private Resource Number : 00000000

[0D0h 0208   1]                Subtable Type : 00 [Processor Hierarchy Node]
[0D1h 0209   1]                       Length : 14
[0D2h 0210   2]                     Reserved : 0000
[0D4h 0212   4]        Flags (decoded below) : 0000000E
                            Physical package : 0
                     ACPI Processor ID valid : 1
                       Processor is a thread : 1
                              Node is a leaf : 1
                    Identical Implementation : 0
[0D8h 0216   4]                       Parent : 000000BC
[0DCh 0220   4]            ACPI Processor ID : 00000000
[0E0h 0224   4]      Private Resource Number : 00000000

[0E4h 0228   1]                Subtable Type : 00 [Processor Hierarchy Node]
[0E5h 0229   1]                       Length : 14
[0E6h 0230   2]                     Reserved : 0000
[0E8h 0232   4]        Flags (decoded below) : 0000000E
                            Physical package : 0
                     ACPI Processor ID valid : 1
                       Processor is a thread : 1
                              Node is a leaf : 1
                    Identical Implementation : 0
[0ECh 0236   4]                       Parent : 000000BC
[0F0h 0240   4]            ACPI Processor ID : 00000001
[0F4h 0244   4]      Private Resource Number : 00000000

[0F8h 0248   1]                Subtable Type : 00 [Processor Hierarchy Node]
[0F9h 0249   1]                       Length : 14
[0FAh 0250   2]                     Reserved : 0000
[0FCh 0252   4]        Flags (decoded below) : 00000010
                            Physical package : 0
                     ACPI Processor ID valid : 0
                       Processor is a thread : 0
                              Node is a leaf : 0
                    Identical Implementation : 1
[100h 0256   4]                       Parent : 000000A0
[104h 0260   4]            ACPI Processor ID : 00000001
[108h 0264   4]      Private Resource Number : 00000000

[10Ch 0268   1]                Subtable Type : 00 [Processor Hierarchy Node]
[10Dh 0269   1]                       Length : 14
[10Eh 0270   2]                     Reserved : 0000
[110h 0272   4]        Flags (decoded below) : 0000000E
                            Physical package : 0
                     ACPI Processor ID valid : 1
                       Processor is a thread : 1
                              Node is a leaf : 1
                    Identical Implementation : 0
[114h 0276   4]                       Parent : 000000F8
[118h 0280   4]            ACPI Processor ID : 00000002
[11Ch 0284   4]      Private Resource Number : 00000000

[120h 0288   1]                Subtable Type : 00 [Processor Hierarchy Node]
[121h 0289   1]                       Length : 14
[122h 0290   2]                     Reserved : 0000
[124h 0292   4]        Flags (decoded below) : 0000000E
                            Physical package : 0
                     ACPI Processor ID valid : 1
                       Processor is a thread : 1
                              Node is a leaf : 1
                    Identical Implementation : 0
[128h 0296   4]                       Parent : 000000F8
[12Ch 0300   4]            ACPI Processor ID : 00000003
[130h 0304   4]      Private Resource Number : 00000000

[134h 0308   1]                Subtable Type : 01 [Cache Type]
[135h 0309   1]                       Length : 1C
[136h 0310   2]                     Reserved : 0000
[138h 0312   4]        Flags (decoded below) : 000000FF
                                  Size valid : 1
                        Number of Sets valid : 1
                         Associativity valid : 1
                       Allocation Type valid : 1
                            Cache Type valid : 1
                          Write Policy valid : 1
                             Line Size valid : 1
[13Ch 0316   4]          Next Level of Cache : 00000000
[140h 0320   4]                         Size : 00200000
[144h 0324   4]               Number of Sets : 00000800
[148h 0328   1]                Associativity : 10
[149h 0329   1]                   Attributes : 0F
                             Allocation Type : 3
                                  Cache Type : 3
                                Write Policy : 0
[14Ah 0330   2]                    Line Size : 0040

[150h 0336   1]                Subtable Type : 01 [Cache Type]
[151h 0337   1]                       Length : 1C
[152h 0338   2]                     Reserved : 0000
[154h 0340   4]        Flags (decoded below) : 000000FF
                                  Size valid : 1
                        Number of Sets valid : 1
                         Associativity valid : 1
                       Allocation Type valid : 1
                            Cache Type valid : 1
                          Write Policy valid : 1
                             Line Size valid : 1
[158h 0344   4]          Next Level of Cache : 00000134
[15Ch 0348   4]                         Size : 00008000
[160h 0352   4]               Number of Sets : 00000080
[164h 0356   1]                Associativity : 04
[165h 0357   1]                   Attributes : 03
                             Allocation Type : 3
                                  Cache Type : 0
                                Write Policy : 0
[166h 0358   2]                    Line Size : 0040

[16Ch 0364   1]                Subtable Type : 01 [Cache Type]
[16Dh 0365   1]                       Length : 1C
[16Eh 0366   2]                     Reserved : 0000
[170h 0368   4]        Flags (decoded below) : 000000FF
                                  Size valid : 1
                        Number of Sets valid : 1
                         Associativity valid : 1
                       Allocation Type valid : 1
                            Cache Type valid : 1
                          Write Policy valid : 1
                             Line Size valid : 1
[174h 0372   4]          Next Level of Cache : 00000134
[178h 0376   4]                         Size : 0000C000
[17Ch 0380   4]               Number of Sets : 00000100
[180h 0384   1]                Associativity : 03
[181h 0385   1]                   Attributes : 07
                             Allocation Type : 3
                                  Cache Type : 1
                                Write Policy : 0
[182h 0386   2]                    Line Size : 0040

[188h 0392   1]                Subtable Type : 00 [Processor Hierarchy Node]
[189h 0393   1]                       Length : 1C
[18Ah 0394   2]                     Reserved : 0000
[18Ch 0396   4]        Flags (decoded below) : 00000010
                            Physical package : 0
                     ACPI Processor ID valid : 0
                       Processor is a thread : 0
                              Node is a leaf : 0
                    Identical Implementation : 1
[190h 0400   4]                       Parent : 00000038
[194h 0404   4]            ACPI Processor ID : 00000001
[198h 0408   4]      Private Resource Number : 00000002
[19Ch 0412   4]             Private Resource : 0000016C
[1A0h 0416   4]             Private Resource : 00000150

[1A4h 0420   1]                Subtable Type : 00 [Processor Hierarchy Node]
[1A5h 0421   1]                       Length : 14
[1A6h 0422   2]                     Reserved : 0000
[1A8h 0424   4]        Flags (decoded below) : 00000010
                            Physical package : 0
                     ACPI Processor ID valid : 0
                       Processor is a thread : 0
                              Node is a leaf : 0
                    Identical Implementation : 1
[1ACh 0428   4]                       Parent : 00000188
[1B0h 0432   4]            ACPI Processor ID : 00000000
[1B4h 0436   4]      Private Resource Number : 00000000

[1B8h 0440   1]                Subtable Type : 00 [Processor Hierarchy Node]
[1B9h 0441   1]                       Length : 14
[1BAh 0442   2]                     Reserved : 0000
[1BCh 0444   4]        Flags (decoded below) : 0000000E
                            Physical package : 0
                     ACPI Processor ID valid : 1
                       Processor is a thread : 1
                              Node is a leaf : 1
                    Identical Implementation : 0
[1C0h 0448   4]                       Parent : 000001A4
[1C4h 0452   4]            ACPI Processor ID : 00000004
[1C8h 0456   4]      Private Resource Number : 00000000

[1CCh 0460   1]                Subtable Type : 00 [Processor Hierarchy Node]
[1CDh 0461   1]                       Length : 14
[1CEh 0462   2]                     Reserved : 0000
[1D0h 0464   4]        Flags (decoded below) : 0000000E
                            Physical package : 0
                     ACPI Processor ID valid : 1
                       Processor is a thread : 1
                              Node is a leaf : 1
                    Identical Implementation : 0
[1D4h 0468   4]                       Parent : 000001A4
[1D8h 0472   4]            ACPI Processor ID : 00000005
[1DCh 0476   4]      Private Resource Number : 00000000

[1E0h 0480   1]                Subtable Type : 00 [Processor Hierarchy Node]
[1E1h 0481   1]                       Length : 14
[1E2h 0482   2]                     Reserved : 0000
[1E4h 0484   4]        Flags (decoded below) : 00000010
                            Physical package : 0
                     ACPI Processor ID valid : 0
                       Processor is a thread : 0
                              Node is a leaf : 0
                    Identical Implementation : 1
[1E8h 0488   4]                       Parent : 00000188
[1ECh 0492   4]            ACPI Processor ID : 00000001
[1F0h 0496   4]      Private Resource Number : 00000000

[1F4h 0500   1]                Subtable Type : 00 [Processor Hierarchy Node]
[1F5h 0501   1]                       Length : 14
[1F6h 0502   2]                     Reserved : 0000
[1F8h 0504   4]        Flags (decoded below) : 0000000E
                            Physical package : 0
                     ACPI Processor ID valid : 1
                       Processor is a thread : 1
                              Node is a leaf : 1
                    Identical Implementation : 0
[1FCh 0508   4]                       Parent : 000001E0
[200h 0512   4]            ACPI Processor ID : 00000006
[204h 0516   4]      Private Resource Number : 00000000

[208h 0520   1]                Subtable Type : 00 [Processor Hierarchy Node]
[209h 0521   1]                       Length : 14
[20Ah 0522   2]                     Reserved : 0000
[20Ch 0524   4]        Flags (decoded below) : 0000000E
                            Physical package : 0
                     ACPI Processor ID valid : 1
                       Processor is a thread : 1
                              Node is a leaf : 1
                    Identical Implementation : 0
[210h 0528   4]                       Parent : 000001E0
[214h 0532   4]            ACPI Processor ID : 00000007
[218h 0536   4]      Private Resource Number : 00000000

Raw Table Data: Length 540 (0x21C)

    0000: 50 50 54 54 1C 02 00 00 03 4D 42 4F 43 48 53 20  // PPTT.....MBOCHS
    0010: 42 58 50 43 20 20 20 20 01 00 00 00 42 58 50 43  // BXPC    ....BXPC
    0020: 01 00 00 00 00 14 00 00 11 00 00 00 00 00 00 00  // ................
    0030: 00 00 00 00 00 00 00 00 00 14 00 00 11 00 00 00  // ................
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

Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
---
 tests/data/acpi/aarch64/virt/PPTT.topology  | Bin 356 -> 540 bytes
 tests/qtest/bios-tables-test-allowed-diff.h |   1 -
 2 files changed, 1 deletion(-)

diff --git a/tests/data/acpi/aarch64/virt/PPTT.topology b/tests/data/acpi/aarch64/virt/PPTT.topology
index d0e5e11e90f33cbbbc231f9ad0bd48419e0fea65..f5f07b87c3777106e74f380de7941e1c01fc3447 100644
GIT binary patch
literal 540
zcmZvXI}XAy5JV>*2o(g0GDQlGKtUNL4F!luq~Hh?93lk;$DrUC6gdjVpo1A>2S;LM
z%e!y9_D)?lO%?*tuH09fLtY;1DrW=$l<UL-nCtYzvZcp@40!i-4orY_R*;0D)3(xE
zvk*rGivR<yGYC;)v;cfFC0cVUI4UmOCl#DQ+D*9&vMKY2t95$J__56O`b@nqZvA7z
z_KHOoxp}{3-usL_pDR7u{(Q!sPos6zc}G5}4ScFq|DT!EDy+||au;^4J6ZgPjXWlw
S>h0TY?~`Ec-II5*#Ig@|86g1x

literal 356
zcmWFt2nk7HWME*P=H&0}5v<@85#X!<1VAAM5F11@h%hh+f@ov_6;nYI69Dopu!#Af
ziSYsX2{^>Sc7o)9c7V(S=|vU;>74__Oh60<Ky@%NW+X9~TafjF#BRXUfM}@RH$Wx}
cOdLs!6-f-H7uh_Jy&6CPHY9a0F?OgJ00?*x0RR91

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index ba2a8180e9..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,2 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/aarch64/virt/PPTT.topology",
-- 
2.34.1


