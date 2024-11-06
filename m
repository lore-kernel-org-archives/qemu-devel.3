Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24F76D44D58
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 13:05:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8fiu-0006yq-JP; Wed, 06 Nov 2024 08:05:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1t8fiW-0006ny-Rv; Wed, 06 Nov 2024 08:05:00 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1t8fiT-0000YR-JG; Wed, 06 Nov 2024 08:05:00 -0500
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Xk55d1GWtz6LD6C;
 Wed,  6 Nov 2024 21:04:53 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
 by mail.maildlp.com (Postfix) with ESMTPS id A73141404F4;
 Wed,  6 Nov 2024 21:04:55 +0800 (CST)
Received: from 00293818-MRGF.huawei.com (10.126.170.112) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 6 Nov 2024 14:04:41 +0100
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, <mst@redhat.com>,
 <imammedo@redhat.com>
CC: <salil.mehta@huawei.com>, <jonathan.cameron@huawei.com>,
 <peter.maydell@linaro.org>, <richard.henderson@linaro.org>,
 <anisinha@redhat.com>, <eduardo@habkost.net>, <marcel.apfelbaum@gmail.com>,
 <david@redhat.com>, <philmd@linaro.org>, <peterx@redhat.com>,
 <pbonzini@redhat.com>, <gshan@redhat.com>, <borntraeger@linux.ibm.com>,
 <alex.bennee@linaro.org>, <linux@armlinux.org.uk>,
 <darren@os.amperecomputing.com>, <ilkka@os.amperecomputing.com>,
 <vishnu@os.amperecomputing.com>, <karl.heubaum@oracle.com>,
 <miguel.luis@oracle.com>, <salil.mehta@opnsrc.net>, <zhukeqian1@huawei.com>,
 <wangxiongfeng2@huawei.com>, <wangyanan55@huawei.com>, <zhao1.liu@intel.com>, 
 <linuxarm@huawei.com>, <gustavo.romero@linaro.org>
Subject: [PATCH 3/3] tests/qtest/bios-tables-test: Fix DSDT golden masters for
 x86/{pc, q35}
Date: Wed, 6 Nov 2024 13:03:31 +0000
Message-ID: <20241106130331.205020-4-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241106130331.205020-1-salil.mehta@huawei.com>
References: <20241106130331.205020-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.170.112]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 frapeml500007.china.huawei.com (7.182.85.172)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=salil.mehta@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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
Reply-to:  Salil Mehta <salil.mehta@huawei.com>
From:  Salil Mehta via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Update DSDT golden master files for x86/pc and x86/q35 platforms to fix
the earlier changes made in the architecture-agnostic CPU AML. These
updates notify the guest OS of vCPU hot-plug and hot-unplug status using
the ACPI `_STA.Enabled` bit. Earlier order of checking `presence` and
`enabled` broke the x86 migration to platforms using older version of
the Qemu.

The following is a diff of the changes in the .dsl file generated with IASL:

  * Disassembling to symbolic ASL+ operators
  *
- * Disassembly of tests/data/acpi/x86/pc/DSDT, Wed Nov  6 11:41:11 2024
+ * Disassembly of /tmp/aml-6S3FW2, Wed Nov  6 11:41:11 2024
  *
  * Original Table Header:
  *     Signature        "DSDT"
  *     Length           0x00002171 (8561)
  *     Revision         0x01 **** 32-bit table (V1), no 64-bit math support
- *     Checksum         0xAA
+ *     Checksum         0xB0
  *     OEM ID           "BOCHS "
  *     OEM Table ID     "BXPC    "
  *     OEM Revision     0x00000001 (1)
@@ -1515,16 +1515,13 @@
                 Acquire (\_SB.PCI0.PRES.CPLK, 0xFFFF)
                 \_SB.PCI0.PRES.CSEL = Arg0
                 Local0 = Zero
-                If ((\_SB.PCI0.PRES.CPRS == One))
-                {
-                    If ((\_SB.PCI0.PRES.CPEN == One))
-                    {
-                        Local0 = 0x0F
-                    }
-                    Else
-                    {
-                        Local0 = 0x0D
-                    }
+                If ((\_SB.PCI0.PRES.CPEN == One))
+                {
+                    Local0 = 0x0F
+                }
+                ElseIf ((\_SB.PCI0.PRES.CPRS == One))
+                {
+                    Local0 = 0x0D
                 }

                 Release (\_SB.PCI0.PRES.CPLK)

Suggested-by: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20241106100047.18901c9d@imammedo.users.ipa.redhat.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 tests/data/acpi/x86/pc/DSDT                   | Bin 8561 -> 8561 bytes
 tests/data/acpi/x86/pc/DSDT.acpierst          | Bin 8472 -> 8472 bytes
 tests/data/acpi/x86/pc/DSDT.acpihmat          | Bin 9886 -> 9886 bytes
 tests/data/acpi/x86/pc/DSDT.bridge            | Bin 15432 -> 15432 bytes
 tests/data/acpi/x86/pc/DSDT.cphp              | Bin 9025 -> 9025 bytes
 tests/data/acpi/x86/pc/DSDT.dimmpxm           | Bin 10215 -> 10215 bytes
 tests/data/acpi/x86/pc/DSDT.hpbridge          | Bin 8512 -> 8512 bytes
 tests/data/acpi/x86/pc/DSDT.hpbrroot          | Bin 5068 -> 5068 bytes
 tests/data/acpi/x86/pc/DSDT.ipmikcs           | Bin 8633 -> 8633 bytes
 tests/data/acpi/x86/pc/DSDT.memhp             | Bin 9920 -> 9920 bytes
 tests/data/acpi/x86/pc/DSDT.nohpet            | Bin 8419 -> 8419 bytes
 tests/data/acpi/x86/pc/DSDT.numamem           | Bin 8567 -> 8567 bytes
 tests/data/acpi/x86/pc/DSDT.roothp            | Bin 12354 -> 12354 bytes
 tests/data/acpi/x86/q35/DSDT                  | Bin 8389 -> 8389 bytes
 tests/data/acpi/x86/q35/DSDT.acpierst         | Bin 8406 -> 8406 bytes
 tests/data/acpi/x86/q35/DSDT.acpihmat         | Bin 9714 -> 9714 bytes
 .../acpi/x86/q35/DSDT.acpihmat-noinitiator    | Bin 8668 -> 8668 bytes
 tests/data/acpi/x86/q35/DSDT.applesmc         | Bin 8435 -> 8435 bytes
 tests/data/acpi/x86/q35/DSDT.bridge           | Bin 12002 -> 12002 bytes
 tests/data/acpi/x86/q35/DSDT.core-count       | Bin 12947 -> 12947 bytes
 tests/data/acpi/x86/q35/DSDT.core-count2      | Bin 33804 -> 33804 bytes
 tests/data/acpi/x86/q35/DSDT.cphp             | Bin 8853 -> 8853 bytes
 tests/data/acpi/x86/q35/DSDT.cxl              | Bin 13182 -> 13182 bytes
 tests/data/acpi/x86/q35/DSDT.dimmpxm          | Bin 10043 -> 10043 bytes
 tests/data/acpi/x86/q35/DSDT.ipmibt           | Bin 8464 -> 8464 bytes
 tests/data/acpi/x86/q35/DSDT.ipmismbus        | Bin 8477 -> 8477 bytes
 tests/data/acpi/x86/q35/DSDT.ivrs             | Bin 8406 -> 8406 bytes
 tests/data/acpi/x86/q35/DSDT.memhp            | Bin 9748 -> 9748 bytes
 tests/data/acpi/x86/q35/DSDT.mmio64           | Bin 9519 -> 9519 bytes
 tests/data/acpi/x86/q35/DSDT.multi-bridge     | Bin 13242 -> 13242 bytes
 tests/data/acpi/x86/q35/DSDT.noacpihp         | Bin 8269 -> 8269 bytes
 tests/data/acpi/x86/q35/DSDT.nohpet           | Bin 8247 -> 8247 bytes
 tests/data/acpi/x86/q35/DSDT.numamem          | Bin 8395 -> 8395 bytes
 tests/data/acpi/x86/q35/DSDT.pvpanic-isa      | Bin 8490 -> 8490 bytes
 tests/data/acpi/x86/q35/DSDT.thread-count     | Bin 12947 -> 12947 bytes
 tests/data/acpi/x86/q35/DSDT.thread-count2    | Bin 33804 -> 33804 bytes
 tests/data/acpi/x86/q35/DSDT.tis.tpm12        | Bin 8995 -> 8995 bytes
 tests/data/acpi/x86/q35/DSDT.tis.tpm2         | Bin 9021 -> 9021 bytes
 tests/data/acpi/x86/q35/DSDT.type4-count      | Bin 18623 -> 18623 bytes
 tests/data/acpi/x86/q35/DSDT.viot             | Bin 14649 -> 14649 bytes
 tests/data/acpi/x86/q35/DSDT.xapic            | Bin 35752 -> 35752 bytes
 tests/qtest/bios-tables-test-allowed-diff.h   |  41 ------------------
 42 files changed, 41 deletions(-)

diff --git a/tests/data/acpi/x86/pc/DSDT b/tests/data/acpi/x86/pc/DSDT
index 46c8ffda011e71ce0a0ee707d320f13e9afd74f8..bbcbca90276747c2c1c733fecef13ca5e418c2e0 100644
GIT binary patch
delta 37
vcmV+=0NVfYLh(WhL{mgmaUlQz0kE+O;0==j4jTa+k`5FDQd0r59S&3z-RKGj

delta 53
zcmV-50LuUILh(WhL{mgmaUlQz0jjYI;0+cxlUy$ZUsFO~P(w*DP*O!xLr_vv0h8$s
L903Kh9S&3z%f=73

diff --git a/tests/data/acpi/x86/pc/DSDT.acpierst b/tests/data/acpi/x86/pc/DSDT.acpierst
index 8332df33f33ddaa4241752dcc2cf83ebd1cccd80..53f9668d5cd37affb0ff623a29c7069f09771daf 100644
GIT binary patch
delta 37
vcmV+=0NVeULYP7dL{mgm7$E=v0r;^B;0==j4jTa+k`5FDQd0r59S-{v!s!X>

delta 53
zcmV-50LuTELYP7dL{mgm7$E=v0rIg5;0+cxlUy$ZUsFO~P(w*DP*O!xLr_vv0h8$s
L903Kh9S-{vq?Zqw

diff --git a/tests/data/acpi/x86/pc/DSDT.acpihmat b/tests/data/acpi/x86/pc/DSDT.acpihmat
index bf093f6d8290a10a0823299238d5196d19b8e77d..f1433f480e84de07c28ebd29c503867137322ab2 100644
GIT binary patch
delta 53
zcmV-50LuTKO`c5(L{mgmo+bbQ0d27g>kX3(4jUL8pc<20F9csxLSIlrNia}SMN>mi
LQd0r5C=PZQrD_ir

delta 61
zcmV-D0K)&CO`c5(L{mgmo+bbQ0cWua>kSq+lUy$ZUsFO~P(w*DP*O!xLr_vv0h199
T6bVI60dNWrV4(%GC=PZQBT*2U

diff --git a/tests/data/acpi/x86/pc/DSDT.bridge b/tests/data/acpi/x86/pc/DSDT.bridge
index c0bf671621348f698d2535cfd734dc05a9c7256a..df93da014bce8893c6be790dc2204a33e61d6865 100644
GIT binary patch
delta 37
vcmV+=0NVe^c*uAPL{mgmNIU=l0lu*c;0==j4jTa+k`5FDQd0r59S$ol;EW0r

delta 53
zcmV-50LuT!c*uAPL{mgmNIU=l0l2XW;0+cxlUy$ZUsFO~P(w*DP*O!xLr_vv0h8$s
L903Kh9S$ol&<YR2

diff --git a/tests/data/acpi/x86/pc/DSDT.cphp b/tests/data/acpi/x86/pc/DSDT.cphp
index e72a2df567d28b08b17051dd5612fb77abaf6e20..45c17abeb58faee635ab536147ee8a2838b77d1d 100644
GIT binary patch
delta 53
zcmV-50LuTtM!`l3L{mgmK_dVF0Ti(c91fE`4jUL8pc<20F9csxLSIlrNia}SMN>mi
LQd0r5Sq|tFeaH@%

delta 76
zcmV-S0JHzWM!`l3L{mgmK_dVF0S>VW91b%#lUy$ZUsFO~P(w*DP*O!xLr_vv0iYU_
iTrUJ)Q$k-*LrE}DQbkikP(@Awa0(A#p#`&94(JpdOBFu=

diff --git a/tests/data/acpi/x86/pc/DSDT.dimmpxm b/tests/data/acpi/x86/pc/DSDT.dimmpxm
index 17a53d9ef714c973c934fdbd2021b2c03fa08a87..41ef5b14b55d9cecd77d7908c24c43508e36eeab 100644
GIT binary patch
delta 84
zcmV-a0IUD!Pv=hxL{mgm=O+LF0nxDv7Y;WXlUy$ZUsFO~P(w*DP*O!xLr_Id0dNWr
qV4)nK8k1Zv1Yc7^Ur<9yFi=uOQ$tWvQvq-a4PcWX5EZj+4tg0v9vE!^

delta 44
zcmV+{0Mq~HPv=hxL{mgm=O+LF0n4!p7Y+e8lRpj>lOPTp1qE;l4PcWX5EZj+4tg0b
CSqt<4

diff --git a/tests/data/acpi/x86/pc/DSDT.hpbridge b/tests/data/acpi/x86/pc/DSDT.hpbridge
index 26f5a1875162459daaa285fef8b6c63678f7726a..0d746c1850e7c3775023cd9e47d4969f19c04cf7 100644
GIT binary patch
delta 37
vcmV+=0NVe+Lcl@_L{mgmKp_AC0pzg?;0==j4jTa+k`5FDQd0r59S$QC&khN9

delta 53
zcmV-50LuTsLcl@_L{mgmKp_AC0p76+;0+cxlUy$ZUsFO~P(w*DP*O!xLr_vv0h8$s
L903Kh9S$QCw)_t!

diff --git a/tests/data/acpi/x86/pc/DSDT.hpbrroot b/tests/data/acpi/x86/pc/DSDT.hpbrroot
index e0c7c2a56d5d8afb5f78134c9b175d6153dca776..09c0d387d667f865e26f6fcb5314c95a4e6b1395 100644
GIT binary patch
delta 76
zcmV-S0JHzhC(I`bL{mgm%o6|r0o1VylMFK&lUy$ZUsFO~P(w*DP*O!xLr_Id0dNWr
iV4)nK8k1Zv1Yc7^Ur<9yFi=uOQ$tWvQvtKk4EzRkSr<Y8

delta 53
zcmV-50LuT&C(I`bL{mgm%o6|r0nV`slMEI&lUy$ZUsFO~P(w*DP*O!xLr_vv0h62z
L903Kh&<y+ry2%h%

diff --git a/tests/data/acpi/x86/pc/DSDT.ipmikcs b/tests/data/acpi/x86/pc/DSDT.ipmikcs
index 119bd256adfb443922cf988e4f4ac3278a1d55ba..5a5f763efbf4ab32bf64008bc3aed73fd4d0b38e 100644
GIT binary patch
delta 37
vcmV+=0NVe#L%Bl=L{mgmxgh`m0W7f!;0==j4jTa+k`5FDQd0r59S)om%K{0d

delta 53
zcmV-50LuTlL%Bl=L{mgmxgh`m0Vc5u;0+cxlUy$ZUsFO~P(w*DP*O!xLr_vv0h8$s
L903Kh9S)omu0Rh|

diff --git a/tests/data/acpi/x86/pc/DSDT.memhp b/tests/data/acpi/x86/pc/DSDT.memhp
index 9ca8a6e2f7898ccd304de44a34bd318a209917e9..d7e156617ecc8d011192a22398ab47d2ac27163b 100644
GIT binary patch
delta 37
vcmV+=0NVe+O~6eGL{mgmz$O3y0h6%`;0==j4jTa+k`5FDQd0r59S)-y+Eofh

delta 53
zcmV-50LuTsO~6eGL{mgmz$O3y0gbT=;0+cxlUy$ZUsFO~P(w*DP*O!xLr_vv0h8$s
L903Kh9S)-y#^Vq5

diff --git a/tests/data/acpi/x86/pc/DSDT.nohpet b/tests/data/acpi/x86/pc/DSDT.nohpet
index 6127a2c9ac43e961e7e8ca01673117382c20bedb..29e55cb624c1d19097bf8732d88dca896a458770 100644
GIT binary patch
delta 76
zcmV-S0JHz&LE}LRL{mgm;~)S40eZ0tQVla2lUy$ZUsFO~P(w*DP*O!xLr_Id0dNWr
iV4)nK8k1Zv1Yc7^Ur<9yFi=uOQ$tWvQvtJ&4OA0zX%<re

delta 53
zcmV-50LuU4LE}LRL{mgm;~)S40d%nnQVkY2lUy$ZUsFO~P(w*DP*O!xLr_vv0h3z|
L903Khj}254xg-xL

diff --git a/tests/data/acpi/x86/pc/DSDT.numamem b/tests/data/acpi/x86/pc/DSDT.numamem
index 18c815efa890503f5e0ca94665239f58fe283735..73e8ec60fdff3be9ea5c2fe246a14a7cb6cf1543 100644
GIT binary patch
delta 37
vcmV+=0NVfeLia)nL{mgmcOd`(0ZXw8;0==j4jTa+k`5FDQd0r59S&L(*EtEg

delta 53
zcmV-50LuUOLia)nL{mgmcOd`(0Y$M2;0+cxlUy$ZUsFO~P(w*DP*O!xLr_vv0h8$s
L903Kh9S&L(zvmBW

diff --git a/tests/data/acpi/x86/pc/DSDT.roothp b/tests/data/acpi/x86/pc/DSDT.roothp
index 8256503220c11cbb902c6967fccba87e711bcd5a..6fcf58475ed9c9ec2bfdc54c162a500116dd5ab2 100644
GIT binary patch
delta 37
vcmV+=0NVe;V8UPuL{mgmLNEXT0X(q^;0==j4jTa+k`5FDQd0r59S$WT%9;r=

delta 53
zcmV-50LuTuV8UPuL{mgmLNEXT0XDG;;0+cxlUy$ZUsFO~P(w*DP*O!xLr_vv0h8$s
L903Kh9S$WTtr!mA

diff --git a/tests/data/acpi/x86/q35/DSDT b/tests/data/acpi/x86/q35/DSDT
index b0bbff7686c9a56129bfa3408e62f142cc482713..3ed6309318703c1201e08afb15ef4e42edea64ed 100644
GIT binary patch
delta 53
zcmV-50LuTxLB&A|L{mgm#UKCx0gkZ>EgF+f8XFiKpc<20F9csxLSIlrNia}SMN>mi
LQd0r5Y8qPxttbyn

delta 76
zcmV-S0JHzaLB&A|L{mgm#UKCx0f?~*EgCa7lUy$ZUsFO~P(w*DP*O!xLr_vv0iYU_
iTrUJ)Q$k-*LrE}DQbkikP(@Awa0(A#p#`&Q8e0Zn^cB|t

diff --git a/tests/data/acpi/x86/q35/DSDT.acpierst b/tests/data/acpi/x86/q35/DSDT.acpierst
index f91cbe55fcfeea319babf7c9a0c6a6ccdc3320d1..acc29ac6ee5f87f620357356b0174f0df05abb7f 100644
GIT binary patch
delta 53
zcmV-50LuT?LDoSEL{mgm)*t`?0WPr$EgF+f8XFiKpc<20F9csxLSIlrNia}SMN>mi
LQd0r5Y8q??sD2MH

delta 76
zcmV-S0JHzrLDoSEL{mgm)*t`?0VuHwEgCa7lUy$ZUsFO~P(w*DP*O!xLr_vv0iYU_
iTrUJ)Q$k-*LrE}DQbkikP(@Awa0(A#p#`&Q8f*qwKNY(G

diff --git a/tests/data/acpi/x86/q35/DSDT.acpihmat b/tests/data/acpi/x86/q35/DSDT.acpihmat
index 0949fb9d67c70dc882e50501ece421114ad8080b..3711ade7ab3cbb838e0695a8a354cc3511195d84 100644
GIT binary patch
delta 61
zcmV-D0K)(BOY%z!L{mgm@+ANO0ZXw8I2w~#8XFuOpc<20F9csxLSIlrNia}SMN>mi
TQd0qN3JqYBK^zscjv8bON;47R

delta 44
zcmV+{0Mq~SOY%z!L{mgm@+ANO0Y$M2I2r*rlVBPZlR+9B1qE;l4PcW&92K*U8e|JE
Cu?#{0

diff --git a/tests/data/acpi/x86/q35/DSDT.acpihmat-noinitiator b/tests/data/acpi/x86/q35/DSDT.acpihmat-noinitiator
index 0fa4daa35cf95f93ba8c15f478460fe4e14e6d9e..7ef3af06c3db708a41054d19962d688019c3816d 100644
GIT binary patch
delta 38
wcmV+>0NMZCL)=3OL{mgm+#vt}0R^!NP#TkQ8XEx|lW-ao15#4~vyB>02jQy<fB*mh

delta 53
zcmV-50LuT|L)=3OL{mgm+#vt}0spZIP#P9DlUy$ZUsFO~P(w*DP*O!xLr_vv0h3u8
L903KhjT%n}%_R@B

diff --git a/tests/data/acpi/x86/q35/DSDT.applesmc b/tests/data/acpi/x86/q35/DSDT.applesmc
index a5d032b7d96113c9393036b2ba831adb6d584142..a6375cdf7caef4e1a2e4a043e4c04e17f58e70ae 100644
GIT binary patch
delta 53
zcmV-50LuUKLGwWhL{mgm^B@2K0e-OxEgF+f8XFiKpc<20F9csxLSIlrNia}SMN>mi
LQd0r5Y8r_K#jFqX

delta 76
zcmV-S0JHz|LGwWhL{mgm^B@2K0eG<rEgCa7lUy$ZUsFO~P(w*DP*O!xLr_vv0iYU_
iTrUJ)Q$k-*LrE}DQbkikP(@Awa0(A#p#`&Q8i@vkZWez4

diff --git a/tests/data/acpi/x86/q35/DSDT.bridge b/tests/data/acpi/x86/q35/DSDT.bridge
index 3464f552974672bde25eb15f1c93c309c57ef5cb..54d397735532d600fb49308b2f1a5a1b5fc04dbd 100644
GIT binary patch
delta 53
zcmV-50LuU3UE*B|L{mgm;w}IH0jjYIEgF+f8XFiKpc<20F9csxLSIlrNia}SMN>mi
LQd0r5Y8rSH&-xHB

delta 76
zcmV-S0JHz%UE*B|L{mgm;w}IH0i>}CEgCa7lUy$ZUsFO~P(w*DP*O!xLr_vv0iYU_
iTrUJ)Q$k-*LrE}DQbkikP(@Awa0(A#p#`&Q8h8|xWfr>t

diff --git a/tests/data/acpi/x86/q35/DSDT.core-count b/tests/data/acpi/x86/q35/DSDT.core-count
index 08f5d5f54bcb61235b98fc85bb814046dd038c13..32d891d59362351e6af41b2051982f5e16c553f8 100644
GIT binary patch
delta 53
zcmV-50LuT9Ws_wJL{mgmlQIAR0r#;As~nTe92*!Mpc<20F9csxLSIlrNia}SMN>mi
LQd0r5=p3sR*2WQ7

delta 61
zcmV-D0K)&1Ws_wJL{mgmlQIAR0r9a4s~i?LlUy$ZUsFO~P(w*DP*O!xLr_vv0h7@j
T6bVI60dNWrV4(%G=p3sROgj?W

diff --git a/tests/data/acpi/x86/q35/DSDT.core-count2 b/tests/data/acpi/x86/q35/DSDT.core-count2
index d29a7108f82110ce9f9b4e006501215d41c5420a..5f408f64297e9aeb3c8b0b8dce90dfb6292d323f 100644
GIT binary patch
delta 86
zcmV-c0IC0shysj=0t!S^L{tof0003<u?klvHyV>%F9csxLSIlrNia}SMN>miMNR>5
s3J+kR9H1JLTrUJ)Q$k-*LrE}DQbkikP*PI?a0(4zlVK<ov#lmyT>xPiSO5S3

delta 46
zcmV+}0MY-9hysj=0t!S^L{tof0003(u?klv0XLI>CKZ!lCL9F?a0(4zlVK<ov#lmy
ET_1!Dj{pDw

diff --git a/tests/data/acpi/x86/q35/DSDT.cphp b/tests/data/acpi/x86/q35/DSDT.cphp
index 7fd59bf6702c04a622f05ae356a2ea37312ab403..efa970f93d0ca69b4e77b6628157e5fdd8e4d759 100644
GIT binary patch
delta 61
zcmV-D0K)&3MU_PgL{mgml_CHD0rIg5X&RG?8XFuOpc<20F9csxLSIlrNia}SMN>mi
TQd0qN3JqYB5FHh>zZ%vDH)|3z

delta 68
zcmV-K0K5N{MU_PgL{mgml_CHD0qn5~X&M1HlaU$~A)p$QTrUJ)Q$k-*LrE}DQbkik
aP(@Awa0(A#p#^XX4PcWH9Tl^`8rBD`@)OJe

diff --git a/tests/data/acpi/x86/q35/DSDT.cxl b/tests/data/acpi/x86/q35/DSDT.cxl
index 92769c630dc362c781c4e9a83d6f8be306121c5a..ee6939a341be35d4be2d5f865efd230ce31fd7bc 100644
GIT binary patch
delta 53
zcmV-50LuUVX8vXhL{mgmelq|70iv-AEgF+f8XFiKpc<20F9csxLSIlrNia}SMN>mi
LQd0r5Y8n(7%$yIj

delta 76
zcmV-S0JH!8X8vXhL{mgmelq|70i3Z4EgCa7lUy$ZUsFO~P(w*DP*O!xLr_vv0iYU_
iTrUJ)Q$k-*LrE}DQbkikP(@Awa0(A#p#`&Q8Wb6hY!*KN

diff --git a/tests/data/acpi/x86/q35/DSDT.dimmpxm b/tests/data/acpi/x86/q35/DSDT.dimmpxm
index 1db0bf454a203006f866e6752d06422ae675cbd3..4ec8564ff941acb9af07ffc35e7b21e5adf74c72 100644
GIT binary patch
delta 59
zcmV-B0L1^hPP<MDL{mgmJ0}1D0j{wMWEvhClUy$ZUsFO~P(w*DP*O!xLr_Id0dNWr
RV4)nK8k27t6|<olnhXIG5mf*H

delta 53
zcmV-50LuTnPP<MDL{mgmJ0}1D0jRMGWEvJXlUy$ZUsFO~P(w*DP*O!xLr_vv0h4VS
L903Khp&FVDptlbp

diff --git a/tests/data/acpi/x86/q35/DSDT.ipmibt b/tests/data/acpi/x86/q35/DSDT.ipmibt
index 25f43ae8efb55364a739e6b5e3cb4e71e61862b0..b304c28b64769a106d6c93d5ac195bc28a6949ab 100644
GIT binary patch
delta 53
zcmV-50LuT6LXbiVL{mgm5Fr2n0l~2fEgF+f8XFiKpc<20F9csxLSIlrNia}SMN>mi
LQd0r5Y8s{nfp8A4

delta 76
zcmV-S0JHy)LXbiVL{mgm5Fr2n0lTpZEgCa7lUy$ZUsFO~P(w*DP*O!xLr_vv0iYU_
iTrUJ)Q$k-*LrE}DQbkikP(@Awa0(A#p#`&Q8m0yyO%*u+

diff --git a/tests/data/acpi/x86/q35/DSDT.ipmismbus b/tests/data/acpi/x86/q35/DSDT.ipmismbus
index 32bcd25bda9e9d2775790385f8da6a11e9d5cb46..8dc12ebb2aa45e2e147a3016ce8b0edc4c30b90b 100644
GIT binary patch
delta 53
zcmV-50LuTJLY+biL{mgm9U%Y!0Wz@)EgF+f8XFiKpc<20F9csxLSIlrNia}SMN>mi
LQd0r5Y8tZ!b43nQ

delta 76
zcmV-S0JHy{LY+biL{mgm9U%Y!0W7f!EgCa7lUy$ZUsFO~P(w*DP*O!xLr_vv0iYU_
iTrUJ)Q$k-*LrE}DQbkikP(@Awa0(A#p#`&Q8nXrn$`sxJ

diff --git a/tests/data/acpi/x86/q35/DSDT.ivrs b/tests/data/acpi/x86/q35/DSDT.ivrs
index f91cbe55fcfeea319babf7c9a0c6a6ccdc3320d1..acc29ac6ee5f87f620357356b0174f0df05abb7f 100644
GIT binary patch
delta 53
zcmV-50LuT?LDoSEL{mgm)*t`?0WPr$EgF+f8XFiKpc<20F9csxLSIlrNia}SMN>mi
LQd0r5Y8q??sD2MH

delta 76
zcmV-S0JHzrLDoSEL{mgm)*t`?0VuHwEgCa7lUy$ZUsFO~P(w*DP*O!xLr_vv0iYU_
iTrUJ)Q$k-*LrE}DQbkikP(@Awa0(A#p#`&Q8f*qwKNY(G

diff --git a/tests/data/acpi/x86/q35/DSDT.memhp b/tests/data/acpi/x86/q35/DSDT.memhp
index be90eb71d8dda8fe54c79ffffe103986ee06ae3a..2b1ac856b94d4e33c4ced07964bf796c5d915bc0 100644
GIT binary patch
delta 53
zcmV-50LuTAOq5ItL{mgm6ea)w0dTPjEgF+f8XFiKpc<20F9csxLSIlrNia}SMN>mi
LQd0r5Y8t8wd`S+A

delta 76
zcmV-S0JHy;Oq5ItL{mgm6ea)w0cx=dEgCa7lUy$ZUsFO~P(w*DP*O!xLr_vv0iYU_
iTrUJ)Q$k-*LrE}DQbkikP(@Awa0(A#p#`&Q8mbEyG8Gm8

diff --git a/tests/data/acpi/x86/q35/DSDT.mmio64 b/tests/data/acpi/x86/q35/DSDT.mmio64
index 01f276a6aff38a1d4f58640a9e6d120fc9a04b61..412f9cb1da9bca5756a347b8eee33ac7641bc9c0 100644
GIT binary patch
delta 53
zcmV-50LuTbO0P-^L{mgmFC_o~0Wq-(EgF+f8XFiKpc<20F9csxLSIlrNia}SMN>mi
LQd0r5Y8u4~fr<{Y

delta 76
zcmV-S0JHzEO0P-^L{mgmFC_o~0V}ZzEgCa7lUy$ZUsFO~P(w*DP*O!xLr_vv0iYU_
iTrUJ)Q$k-*LrE}DQbkikP(@Awa0(A#p#`&Q8pR47o)tX+

diff --git a/tests/data/acpi/x86/q35/DSDT.multi-bridge b/tests/data/acpi/x86/q35/DSDT.multi-bridge
index 1bd2ee8d2ebd3c9e0ed89a86478691f2e06f2590..4d77514e40ed8c7a0704ffeac98aaf0ea42a97f9 100644
GIT binary patch
delta 53
zcmV-50LuTmXS!z!L{mgmx-$R(0i&@BEgF+f8XFiKpc<20F9csxLSIlrNia}SMN>mi
LQd0r5Y8p@(yipIQ

delta 76
zcmV-S0JHzPXS!z!L{mgmx-$R(0iCf5EgCa7lUy$ZUsFO~P(w*DP*O!xLr_vv0iYU_
iTrUJ)Q$k-*LrE}DQbkikP(@Awa0(A#p#`&Q8c-Q`k`^)m

diff --git a/tests/data/acpi/x86/q35/DSDT.noacpihp b/tests/data/acpi/x86/q35/DSDT.noacpihp
index 45cc2bcffa42d73db110afd5075556dcfe5d9936..0cced3ab840a3f937d2a8715a153547e2aebb4c1 100644
GIT binary patch
delta 37
vcmV+=0NVe}K+Ql3L{mgmO&|aO0U@yp;24tu85;o{k{J{OQd0r59T_kO#2*O*

delta 53
zcmV-50LuT(K+Ql3L{mgmO&|aO0UNOj;20J+lUy$ZUsFO~P(w*DP*O!xLr_vv0h8$%
L903Kh9T_kOq2~^#

diff --git a/tests/data/acpi/x86/q35/DSDT.nohpet b/tests/data/acpi/x86/q35/DSDT.nohpet
index f110504b9c813aa07802fc17d2869596a2eeca6f..1c39b95fd330143abda31d60f1b47c3ee80d2b4d 100644
GIT binary patch
delta 53
zcmV-50LuTjK({~&L{mgmHy{820avjKpBa<D85<ZJpc<20F9csxLSIlrNia}SMN>mi
LQd0r5+!<R2riBl@

delta 53
zcmV-50LuTjK({~&L{mgmHy{820a39EpBWZ6lUy$ZUsFO~P(w*DP*O!xLr_vv0h6d1
L903Kh+!<R2l{gOs

diff --git a/tests/data/acpi/x86/q35/DSDT.numamem b/tests/data/acpi/x86/q35/DSDT.numamem
index 6090958f39875f5806e72e23f32cb4b3ae840627..944d7938feb5d87a6056f14cc83f98dddd782304 100644
GIT binary patch
delta 53
zcmV-50LuT%LCZl3L{mgm%OC&%0V%NxEgF+f8XFiKpc<20F9csxLSIlrNia}SMN>mi
LQd0r5Y8qh%p-B$^

delta 76
zcmV-S0JHzgLCZl3L{mgm%OC&%0VA;rEgCa7lUy$ZUsFO~P(w*DP*O!xLr_vv0iYU_
iTrUJ)Q$k-*LrE}DQbkikP(@Awa0(A#p#`&Q8es-apcRS$

diff --git a/tests/data/acpi/x86/q35/DSDT.pvpanic-isa b/tests/data/acpi/x86/q35/DSDT.pvpanic-isa
index 7a8e568315a43f1fa98068d8e78995c98064fb91..1d1e06322cb4cf5c6ff9e6f86a29c691abe6d5d1 100644
GIT binary patch
delta 53
zcmV-50LuTWLaIUvL{mgmDj@&>0YI?|EgF+f8XFiKpc<20F9csxLSIlrNia}SMN>mi
LQd0r5Y8t=>eFYAc

delta 76
zcmV-S0JHz9LaIUvL{mgmDj@&>0Xne?EgCa7lUy$ZUsFO~P(w*DP*O!xLr_vv0iYU_
iTrUJ)Q$k-*LrE}DQbkikP(@Awa0(A#p#`&Q8o&k@O%)&j

diff --git a/tests/data/acpi/x86/q35/DSDT.thread-count b/tests/data/acpi/x86/q35/DSDT.thread-count
index 08f5d5f54bcb61235b98fc85bb814046dd038c13..32d891d59362351e6af41b2051982f5e16c553f8 100644
GIT binary patch
delta 53
zcmV-50LuT9Ws_wJL{mgmlQIAR0r#;As~nTe92*!Mpc<20F9csxLSIlrNia}SMN>mi
LQd0r5=p3sR*2WQ7

delta 61
zcmV-D0K)&1Ws_wJL{mgmlQIAR0r9a4s~i?LlUy$ZUsFO~P(w*DP*O!xLr_vv0h7@j
T6bVI60dNWrV4(%G=p3sROgj?W

diff --git a/tests/data/acpi/x86/q35/DSDT.thread-count2 b/tests/data/acpi/x86/q35/DSDT.thread-count2
index d29a7108f82110ce9f9b4e006501215d41c5420a..5f408f64297e9aeb3c8b0b8dce90dfb6292d323f 100644
GIT binary patch
delta 86
zcmV-c0IC0shysj=0t!S^L{tof0003<u?klvHyV>%F9csxLSIlrNia}SMN>miMNR>5
s3J+kR9H1JLTrUJ)Q$k-*LrE}DQbkikP*PI?a0(4zlVK<ov#lmyT>xPiSO5S3

delta 46
zcmV+}0MY-9hysj=0t!S^L{tof0003(u?klv0XLI>CKZ!lCL9F?a0(4zlVK<ov#lmy
ET_1!Dj{pDw

diff --git a/tests/data/acpi/x86/q35/DSDT.tis.tpm12 b/tests/data/acpi/x86/q35/DSDT.tis.tpm12
index 29a416f0508655d2bfde01fff4d25ad7f89581d9..a06de42fd12f395aaebbb801368efffbe1be2371 100644
GIT binary patch
delta 53
zcmV-50LuTPMx#awL{mgmBO?F+0lu*cEgF+f8XFiKpc<20F9csxLSIlrNia}SMN>mi
LQd0r5Y8tr+jtvh3

delta 76
zcmV-S0JHz2Mx#awL{mgmBO?F+0l2XWEgCa7lUy$ZUsFO~P(w*DP*O!xLr_vv0iYU_
iTrUJ)Q$k-*LrE}DQbkikP(@Awa0(A#p#`&Q8o3BEsuhj^

diff --git a/tests/data/acpi/x86/q35/DSDT.tis.tpm2 b/tests/data/acpi/x86/q35/DSDT.tis.tpm2
index 59288f02c43cf2efc1555599131fde05dbbaa1cd..f39e769d932eb89f9ed620ff57a37707155ddbe3 100644
GIT binary patch
delta 53
zcmV-50LuTpM!iM~L{mgmJtF`B0eG<rEgF+f8XFiKpc<20F9csxLSIlrNia}SMN>mi
LQd0r5Y8ulBlAjMH

delta 76
zcmV-S0JHzSM!iM~L{mgmJtF`B0dlblEgCa7lUy$ZUsFO~P(w*DP*O!xLr_vv0iYU_
iTrUJ)Q$k-*LrE}DQbkikP(@Awa0(A#p#`&Q8q)|j^cAoG

diff --git a/tests/data/acpi/x86/q35/DSDT.type4-count b/tests/data/acpi/x86/q35/DSDT.type4-count
index eaca76e8e61eb62f75dbdf093e803eea34330deb..8cea3b46ac597ab5456476d0c61c88e2e4ae2757 100644
GIT binary patch
delta 77
zcmV-T0J8tTkpaJv0SZJ@L{z^>0003au?oW<Ga8dzF9csxLSIlrNia}SMN>miMNR>5
j3J+kR9H1JLTrUJ)Q$k-*LrE}DQbkikP*PI?vLL@GgcBCv

delta 54
zcmV-60LlNqkpaJv0SZJ@L{z^>0003Uu?oW<7B`bzF9csxLSIlrNia}SMN>miQd0qw
M%pV*91+pN&D9IcUH~;_u

diff --git a/tests/data/acpi/x86/q35/DSDT.viot b/tests/data/acpi/x86/q35/DSDT.viot
index 71379a48ddebf7e1f5e853fcbbb6befd561cb8e4..0a16eb366cc299efcbc88745028c63951e7b0e57 100644
GIT binary patch
delta 53
zcmV-50LuTla=CH}L{mgmIXM6T0Wh%&EgF+f8XFiKpc<20F9csxLSIlrNia}SMN>mi
LQd0r5Y8uZTnx79*

delta 76
zcmV-S0JHzOa=CH}L{mgmIXM6T0V=TyEgCa7lUy$ZUsFO~P(w*DP*O!xLr_vv0iYU_
iTrUJ)Q$k-*LrE}DQbkikP(@Awa0(A#p#`&Q8qXd=N)_Ay

diff --git a/tests/data/acpi/x86/q35/DSDT.xapic b/tests/data/acpi/x86/q35/DSDT.xapic
index 9059812b5892ba7ac5c9bd312fd9f45a4f59f105..b8a4f47013cd3424d9a05643ece52b0abb3dc326 100644
GIT binary patch
delta 77
zcmV-T0J8t6mjbAl0t!S^L{zAY0003su?oW{Ga8dzF9csxLSIlrNia}SMN>miMNR>5
j3J+kR9H1JLTrUJ)Q$k-*LrE}DQbkikP*PI?vM8uyi{BSA

delta 54
zcmV-60LlNTmjbAl0t!S^L{zAY0003mu?oW{7B`bzF9csxLSIlrNia}SMN>miQd0qw
M%qJWH1+plpW6i!0k^lez

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index 512d40665d..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,42 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/x86/pc/DSDT",
-"tests/data/acpi/x86/pc/DSDT.acpierst",
-"tests/data/acpi/x86/pc/DSDT.acpihmat",
-"tests/data/acpi/x86/pc/DSDT.bridge",
-"tests/data/acpi/x86/pc/DSDT.cphp",
-"tests/data/acpi/x86/pc/DSDT.dimmpxm",
-"tests/data/acpi/x86/pc/DSDT.hpbridge",
-"tests/data/acpi/x86/pc/DSDT.hpbrroot",
-"tests/data/acpi/x86/pc/DSDT.ipmikcs",
-"tests/data/acpi/x86/pc/DSDT.memhp",
-"tests/data/acpi/x86/pc/DSDT.nohpet",
-"tests/data/acpi/x86/pc/DSDT.numamem",
-"tests/data/acpi/x86/pc/DSDT.roothp",
-"tests/data/acpi/x86/q35/DSDT",
-"tests/data/acpi/x86/q35/DSDT.acpierst",
-"tests/data/acpi/x86/q35/DSDT.acpihmat",
-"tests/data/acpi/x86/q35/DSDT.acpihmat-noinitiator",
-"tests/data/acpi/x86/q35/DSDT.applesmc",
-"tests/data/acpi/x86/q35/DSDT.bridge",
-"tests/data/acpi/x86/q35/DSDT.core-count",
-"tests/data/acpi/x86/q35/DSDT.core-count2",
-"tests/data/acpi/x86/q35/DSDT.cphp",
-"tests/data/acpi/x86/q35/DSDT.cxl",
-"tests/data/acpi/x86/q35/DSDT.dimmpxm",
-"tests/data/acpi/x86/q35/DSDT.ipmibt",
-"tests/data/acpi/x86/q35/DSDT.ipmismbus",
-"tests/data/acpi/x86/q35/DSDT.ivrs",
-"tests/data/acpi/x86/q35/DSDT.memhp",
-"tests/data/acpi/x86/q35/DSDT.mmio64",
-"tests/data/acpi/x86/q35/DSDT.multi-bridge",
-"tests/data/acpi/x86/q35/DSDT.noacpihp",
-"tests/data/acpi/x86/q35/DSDT.nohpet",
-"tests/data/acpi/x86/q35/DSDT.numamem",
-"tests/data/acpi/x86/q35/DSDT.pvpanic-isa",
-"tests/data/acpi/x86/q35/DSDT.thread-count",
-"tests/data/acpi/x86/q35/DSDT.thread-count2",
-"tests/data/acpi/x86/q35/DSDT.tis.tpm12",
-"tests/data/acpi/x86/q35/DSDT.tis.tpm2",
-"tests/data/acpi/x86/q35/DSDT.type4-count",
-"tests/data/acpi/x86/q35/DSDT.viot",
-"tests/data/acpi/x86/q35/DSDT.xapic",
-- 
2.34.1


