Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AB09C3DA6D
	for <qemu-devel@archiver.kernel.org>; Fri, 23 May 2025 10:29:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIPeI-0006pZ-2a; Fri, 23 May 2025 06:29:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alireza.sanaee@huawei.com>)
 id 1uIPeF-0006hT-3H
 for qemu-devel@nongnu.org; Fri, 23 May 2025 06:29:07 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alireza.sanaee@huawei.com>)
 id 1uIPeC-0003jo-R4
 for qemu-devel@nongnu.org; Fri, 23 May 2025 06:29:06 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4b3hBd613Bz6L55s;
 Fri, 23 May 2025 18:25:45 +0800 (CST)
Received: from frapeml500003.china.huawei.com (unknown [7.182.85.28])
 by mail.maildlp.com (Postfix) with ESMTPS id 438561400CA;
 Fri, 23 May 2025 18:29:03 +0800 (CST)
Received: from a2303103017.china.huawei.com (10.47.30.103) by
 frapeml500003.china.huawei.com (7.182.85.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 23 May 2025 12:29:02 +0200
To: <qemu-devel@nongnu.org>, <mst@redhat.com>
CC: <anisinha@redhat.com>, <imammedo@redhat.com>,
 <jonathan.cameron@huawei.com>, <linuxarm@huawei.com>,
 <peter.maydell@linaro.org>, <prime.zeng@hisilicon.com>,
 <shameerali.kolothum.thodi@huawei.com>, <wangyanan55@huawei.com>,
 <yangyicong@hisilicon.com>
Subject: [PATCH v5 4/4] tests: virt: Update expected ACPI tables for virt test
Date: Fri, 23 May 2025 11:26:54 +0100
Message-ID: <20250523102654.1719-5-alireza.sanaee@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250523102654.1719-1-alireza.sanaee@huawei.com>
References: <20250523102654.1719-1-alireza.sanaee@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.47.30.103]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 frapeml500003.china.huawei.com (7.182.85.28)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=alireza.sanaee@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Update the ACPI tables according to the acpi aml_build change, also
empty bios-tables-test-allowed-diff.h.

The disassembled differences between actual and expected PPTT shows
below. Only about the root node adding and identification flag set
as expected.

 /*
  * Intel ACPI Component Architecture
  * AML/ASL+ Disassembler version 20200925 (64-bit version)
  * Copyright (c) 2000 - 2020 Intel Corporation
  *
- * Disassembly of tests/data/acpi/aarch64/virt/PPTT, Thu Apr 24 11:02:39 2025
+ * Disassembly of /tmp/aml-E0RF52, Thu Apr 24 11:02:39 2025
  *
  * ACPI Data Table [PPTT]
  *
  * Format: [HexOffset DecimalOffset ByteLength]  FieldName : FieldValue
  */

 [000h 0000   4]                    Signature : "PPTT"    [Processor Properties Topology Table]
-[004h 0004   4]                 Table Length : 0000004C
+[004h 0004   4]                 Table Length : 00000060
 [008h 0008   1]                     Revision : 02
-[009h 0009   1]                     Checksum : A8
+[009h 0009   1]                     Checksum : 27
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
+    0000: 50 50 54 54 60 00 00 00 02 27 42 4F 43 48 53 20  // PPTT`....'BOCHS
     0010: 42 58 50 43 20 20 20 20 01 00 00 00 42 58 50 43  // BXPC    ....BXPC
-    0020: 01 00 00 00 00 14 00 00 01 00 00 00 00 00 00 00  // ................
-    0030: 00 00 00 00 00 00 00 00 00 14 00 00 0A 00 00 00  // ................
-    0040: 24 00 00 00 00 00 00 00 00 00 00 00              // $...........
+    0020: 01 00 00 00 00 14 00 00 11 00 00 00 00 00 00 00  // ................
+    0030: 00 00 00 00 00 00 00 00 00 14 00 00 11 00 00 00  // ................
+    0040: 24 00 00 00 00 00 00 00 00 00 00 00 00 14 00 00  // $...............
+    0050: 0A 00 00 00 38 00 00 00 00 00 00 00 00 00 00 00  // ....8...........

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
---
 tests/data/acpi/aarch64/virt/PPTT              | Bin 76 -> 96 bytes
 tests/data/acpi/aarch64/virt/PPTT.acpihmatvirt | Bin 156 -> 176 bytes
 tests/data/acpi/aarch64/virt/PPTT.topology     | Bin 336 -> 356 bytes
 tests/qtest/bios-tables-test-allowed-diff.h    |   3 ---
 4 files changed, 3 deletions(-)

diff --git a/tests/data/acpi/aarch64/virt/PPTT b/tests/data/acpi/aarch64/virt/PPTT
index 7a1258ecf123555b24462c98ccbb76b4ac1d0c2b..15598a9b8a3cc0cdd50bc1f77c73ae0ba728a272 100644
GIT binary patch
literal 96
zcmWFt2nk7GU|?WUck*}k2v%^42yj*a0!E-1hz+6{L>L$ZK{PUeim9N9aRK=jNMZmJ
Cwg&+K

delta 38
kcmYfB;R*-{3GrcIU|?D?kxP!15y)bg=qSvi0%AY`0D`Lo$p8QV

diff --git a/tests/data/acpi/aarch64/virt/PPTT.acpihmatvirt b/tests/data/acpi/aarch64/virt/PPTT.acpihmatvirt
index 4eef303a5b6168c6bc3795c2e2c53f65b4c4cfd4..7b613ddaf4b8cfa13821aa2e835d290077221897 100644
GIT binary patch
literal 176
zcmWFt2npH1z`(%7>*Vk35v<@85#X!<1dKp25F11@h%hh+f@ov_6;nYI;{x(6aEO7;
b0?8riMHU0;EdgRCkQxvGs)LC!Lqr$=thxyS

literal 156
zcmWFt2nm_Pz`(%t&&l7}BUr&HBEVSz2pEB4AU23*5Mf{d(;zks0L8d~Y!w(EL?em8
b)g$Re76a)`0AeN}1_P+x1R#eQBEkRwWK9VH

diff --git a/tests/data/acpi/aarch64/virt/PPTT.topology b/tests/data/acpi/aarch64/virt/PPTT.topology
index 3fbcae5ff08aaf16fedf4da45e941661d79c1174..6b864f035c9f48845e9a3beb482c5171074864a5 100644
GIT binary patch
literal 356
zcmWFt2nk7HWME*L?&R<65v<@85#X!<1VAAM5F11@h%hh+f@ov_6;nYI69Dopu!#Af
ziSYsX2{^>Sc7o)9c7V(S=|vU;>74__Oh60<Ky@%NW+X9~TafjF#BRXUfM}@RH$Wx}
cOdLs!6-f-H7uh_Jy&6CPHY9a0F?OgJ00?&w0RR91

literal 336
zcmWFt2nh*bWME*baq@Te2v%^42yj*a0-z8Bhz+6{L>L&rG>8oYKrs+dflv?<DrSKu
z#s}p4;1GkGi=-D>45YUMh?!vef$Csl%t&G&Cde(wdO>1GKm-gx_1*yTS+Iz)B8h>R
aAic=uf$S9l3b27BK>%tVNQ@mK!T<mOd=3Es

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


