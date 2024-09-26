Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96B64CCFA13
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2024 11:34:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stmkq-0000Nj-16; Thu, 26 Sep 2024 07:33:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yangyicong@huawei.com>)
 id 1stmkn-0000F6-VJ
 for qemu-devel@nongnu.org; Thu, 26 Sep 2024 07:33:49 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yangyicong@huawei.com>)
 id 1stmkk-00048Y-B5
 for qemu-devel@nongnu.org; Thu, 26 Sep 2024 07:33:49 -0400
Received: from mail.maildlp.com (unknown [172.19.163.252])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4XDryX2VcgzfcWl;
 Thu, 26 Sep 2024 19:31:16 +0800 (CST)
Received: from kwepemd200014.china.huawei.com (unknown [7.221.188.8])
 by mail.maildlp.com (Postfix) with ESMTPS id F00E51800D5;
 Thu, 26 Sep 2024 19:33:33 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemd200014.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Thu, 26 Sep 2024 19:33:33 +0800
To: <mst@redhat.com>, <imammedo@redhat.com>, <peter.maydell@linaro.org>,
 <wangyanan55@huawei.com>, <anisinha@redhat.com>,
 <jonathan.cameron@huawei.com>, <qemu-devel@nongnu.org>
CC: <shameerali.kolothum.thodi@huawei.com>, <alireza.sanaee@huawei.com>,
 <prime.zeng@hisilicon.com>, <yangyicong@hisilicon.com>, <linuxarm@huawei.com>
Subject: [PATCH 5/5] tests: virt: Update expected ACPI tables for virt test
Date: Thu, 26 Sep 2024 19:33:23 +0800
Message-ID: <20240926113323.55991-6-yangyicong@huawei.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20240926113323.55991-1-yangyicong@huawei.com>
References: <20240926113323.55991-1-yangyicong@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.50.165.33]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemd200014.china.huawei.com (7.221.188.8)
Received-SPF: pass client-ip=45.249.212.188;
 envelope-from=yangyicong@huawei.com; helo=szxga02-in.huawei.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  Yicong Yang <yangyicong@huawei.com>
From:  Yicong Yang via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Yicong Yang <yangyicong@hisilicon.com>

Update the ACPI tables according to the acpi aml_build change, also
empty bios-tables-test-allowed-diff.h.

The disassembled differences between actual and expected PPTT shows
below. Only about the root node adding and identification flag set
as expected.
  /*
    * Intel ACPI Component Architecture
    * AML/ASL+ Disassembler version 20210604 (64-bit version)
    * Copyright (c) 2000 - 2021 Intel Corporation
    *
  - * Disassembly of tests/data/acpi/aarch64/virt/PPTT, Thu Sep 26 08:54:39 2024
  + * Disassembly of /tmp/aml-QNEIU2, Thu Sep 26 08:54:39 2024
    *
    * ACPI Data Table [PPTT]
    *
    * Format: [HexOffset DecimalOffset ByteLength]  FieldName : FieldValue
    */

   [000h 0000   4]                    Signature : "PPTT"    [Processor Properties Topology Table]
  -[004h 0004   4]                 Table Length : 0000004C
  -[008h 0008   1]                     Revision : 02
  -[009h 0009   1]                     Checksum : A8
  +[004h 0004   4]                 Table Length : 00000060
  +[008h 0008   1]                     Revision : 03
  +[009h 0009   1]                     Checksum : 26
   [00Ah 0010   6]                       Oem ID : "BOCHS "
   [010h 0016   8]                 Oem Table ID : "BXPC    "
   [018h 0024   4]                 Oem Revision : 00000001
   [01Ch 0028   4]              Asl Compiler ID : "BXPC"
   [020h 0032   4]        Asl Compiler Revision : 00000001

   [024h 0036   1]                Subtable Type : 00 [Processor Hierarchy Node]
   [025h 0037   1]                       Length : 14
   [026h 0038   2]                     Reserved : 0000
  -[028h 0040   4]        Flags (decoded below) : 00000001
  +[028h 0040   4]        Flags (decoded below) : 00000011
                               Physical package : 1
                        ACPI Processor ID valid : 0
                          Processor is a thread : 0
                                 Node is a leaf : 0
  -                    Identical Implementation : 0
  +                    Identical Implementation : 1
   [02Ch 0044   4]                       Parent : 00000000
   [030h 0048   4]            ACPI Processor ID : 00000000
   [034h 0052   4]      Private Resource Number : 00000000

   [038h 0056   1]                Subtable Type : 00 [Processor Hierarchy Node]
   [039h 0057   1]                       Length : 14
   [03Ah 0058   2]                     Reserved : 0000
  -[03Ch 0060   4]        Flags (decoded below) : 0000000A
  +[03Ch 0060   4]        Flags (decoded below) : 00000011
  +                            Physical package : 1
  +                     ACPI Processor ID valid : 0
  +                       Processor is a thread : 0
  +                              Node is a leaf : 0
  +                    Identical Implementation : 1
  +[040h 0064   4]                       Parent : 00000024
  +[044h 0068   4]            ACPI Processor ID : 00000000
  +[048h 0072   4]      Private Resource Number : 00000000
  +
  +[04Ch 0076   1]                Subtable Type : 00 [Processor Hierarchy Node]
  +[04Dh 0077   1]                       Length : 14
  +[04Eh 0078   2]                     Reserved : 0000
  +[050h 0080   4]        Flags (decoded below) : 0000000A
                               Physical package : 0
                        ACPI Processor ID valid : 1
                          Processor is a thread : 0
                                 Node is a leaf : 1
                       Identical Implementation : 0
  -[040h 0064   4]                       Parent : 00000024
  -[044h 0068   4]            ACPI Processor ID : 00000000
  -[048h 0072   4]      Private Resource Number : 00000000
  +[054h 0084   4]                       Parent : 00000038
  +[058h 0088   4]            ACPI Processor ID : 00000000
  +[05Ch 0092   4]      Private Resource Number : 00000000

  -Raw Table Data: Length 76 (0x4C)
  +Raw Table Data: Length 96 (0x60)

  -    0000: 50 50 54 54 4C 00 00 00 02 A8 42 4F 43 48 53 20  // PPTTL.....BOCHS
  +    0000: 50 50 54 54 60 00 00 00 03 26 42 4F 43 48 53 20  // PPTT`....&BOCHS
       0010: 42 58 50 43 20 20 20 20 01 00 00 00 42 58 50 43  // BXPC    ....BXPC
  -    0020: 01 00 00 00 00 14 00 00 01 00 00 00 00 00 00 00  // ................
  -    0030: 00 00 00 00 00 00 00 00 00 14 00 00 0A 00 00 00  // ................
  -    0040: 24 00 00 00 00 00 00 00 00 00 00 00              // $...........
  +    0020: 01 00 00 00 00 14 00 00 11 00 00 00 00 00 00 00  // ................
  +    0030: 00 00 00 00 00 00 00 00 00 14 00 00 11 00 00 00  // ................
  +    0040: 24 00 00 00 00 00 00 00 00 00 00 00 00 14 00 00  // $...............
  +    0050: 0A 00 00 00 38 00 00 00 00 00 00 00 00 00 00 00  // ....8...........

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 tests/data/acpi/aarch64/virt/PPTT              | Bin 76 -> 96 bytes
 tests/data/acpi/aarch64/virt/PPTT.acpihmatvirt | Bin 156 -> 176 bytes
 tests/data/acpi/aarch64/virt/PPTT.topology     | Bin 336 -> 356 bytes
 tests/qtest/bios-tables-test-allowed-diff.h    |   3 ---
 4 files changed, 3 deletions(-)

diff --git a/tests/data/acpi/aarch64/virt/PPTT b/tests/data/acpi/aarch64/virt/PPTT
index 7a1258ecf123555b24462c98ccbb76b4ac1d0c2b..cafd4ee23cb4579234b36bc1b06d1380ac8fafea 100644
GIT binary patch
literal 96
zcmWFt2nk7GU|?WYbMklg2v%^42yj*a0!E-1hz+6{L>L$ZK{PUeim9N9aRK=jNMZmJ
Cw+8_L

delta 38
kcmYfB;R*-{3GrcIU|?D?kxP!15y)bg=qSvi0%AY`0D`Lo$p8QV

diff --git a/tests/data/acpi/aarch64/virt/PPTT.acpihmatvirt b/tests/data/acpi/aarch64/virt/PPTT.acpihmatvirt
index 4eef303a5b6168c6bc3795c2e2c53f65b4c4cfd4..8d560405bc7c557867efa32fef5b579f5709d729 100644
GIT binary patch
literal 176
zcmWFt2npH1z`(%F<K*w`5v<@85#X!<1dKp25F11@h%hh+f@ov_6;nYI;{x(6aEO7;
b0?8riMHU0;EdgRCkQxvGs)LC!Lqr$=th)&T

literal 156
zcmWFt2nm_Pz`(%t&&l7}BUr&HBEVSz2pEB4AU23*5Mf{d(;zks0L8d~Y!w(EL?em8
b)g$Re76a)`0AeN}1_P+x1R#eQBEkRwWK9VH

diff --git a/tests/data/acpi/aarch64/virt/PPTT.topology b/tests/data/acpi/aarch64/virt/PPTT.topology
index 3fbcae5ff08aaf16fedf4da45e941661d79c1174..d0e5e11e90f33cbbbc231f9ad0bd48419e0fea65 100644
GIT binary patch
literal 356
zcmWFt2nk7HWME*P=H&0}5v<@85#X!<1VAAM5F11@h%hh+f@ov_6;nYI69Dopu!#Af
ziSYsX2{^>Sc7o)9c7V(S=|vU;>74__Oh60<Ky@%NW+X9~TafjF#BRXUfM}@RH$Wx}
cOdLs!6-f-H7uh_Jy&6CPHY9a0F?OgJ00?*x0RR91

literal 336
zcmWFt2nh*bWME*baq@Te2v%^42yj*a0-z8Bhz+6{L>L&rG>8oYKrs+dflv?<DrSKu
z#s}p4;1GkGi=-D>45YUMh?!vef$Csl%t&G&Cde(wdO>1GKm-gx_1*yTS+Iz)B8h>R
aAic=uf$S9l3b27BK>%tVNQ@mK!T<mOd=3Es

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
2.24.0


