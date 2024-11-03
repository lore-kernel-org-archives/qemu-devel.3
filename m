Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C734E6749D
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Nov 2024 10:27:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7Xor-0007T1-1o; Sun, 03 Nov 2024 05:26:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1t7Xom-0007PD-QD; Sun, 03 Nov 2024 05:26:49 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1t7Xoj-0005rt-Ix; Sun, 03 Nov 2024 05:26:48 -0500
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Xh9hp5k3Mz6K8f8;
 Sun,  3 Nov 2024 18:25:14 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
 by mail.maildlp.com (Postfix) with ESMTPS id 53A70140C72;
 Sun,  3 Nov 2024 18:26:43 +0800 (CST)
Received: from 00293818-MRGF.huawei.com (10.48.154.43) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 3 Nov 2024 11:26:24 +0100
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, <mst@redhat.com>
CC: <salil.mehta@huawei.com>, <maz@kernel.org>, <jean-philippe@linaro.org>,
 <jonathan.cameron@huawei.com>, <lpieralisi@kernel.org>,
 <peter.maydell@linaro.org>, <richard.henderson@linaro.org>,
 <imammedo@redhat.com>, <andrew.jones@linux.dev>, <david@redhat.com>,
 <philmd@linaro.org>, <peterx@redhat.com>, <eric.auger@redhat.com>,
 <will@kernel.org>, <ardb@kernel.org>, <oliver.upton@linux.dev>,
 <pbonzini@redhat.com>, <gshan@redhat.com>, <rafael@kernel.org>,
 <borntraeger@linux.ibm.com>, <alex.bennee@linaro.org>, <npiggin@gmail.com>,
 <harshpb@linux.ibm.com>, <linux@armlinux.org.uk>,
 <darren@os.amperecomputing.com>, <ilkka@os.amperecomputing.com>,
 <vishnu@os.amperecomputing.com>, <karl.heubaum@oracle.com>,
 <miguel.luis@oracle.com>, <salil.mehta@opnsrc.net>, <zhukeqian1@huawei.com>,
 <wangxiongfeng2@huawei.com>, <wangyanan55@huawei.com>,
 <jiakernel2@gmail.com>, <maobibo@loongson.cn>, <lixianglai@loongson.cn>,
 <shahuang@redhat.com>, <zhao1.liu@intel.com>, <linuxarm@huawei.com>,
 <gustavo.romero@linaro.org>
Subject: [PATCH V3 4/5] tests/qtest/bios-tables-test: Update DSDT golden
 masters for x86/{pc, q35}
Date: Sun, 3 Nov 2024 10:24:18 +0000
Message-ID: <20241103102419.202225-5-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241103102419.202225-1-salil.mehta@huawei.com>
References: <20241103102419.202225-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.48.154.43]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

Update DSDT golden master files for x86/pc and x86/q35 platforms to
accommodate changes made in the architecture-agnostic CPU AML. These
updates notify the guest OS of vCPU hot-plug and hot-unplug status
using the ACPI `_STA.Enabled` bit.

The following is a diff of the changes in the .dsl file generated with
IASL:

  * Disassembling to symbolic ASL+ operators
  *
- * Disassembly of tests/data/acpi/x86/pc/DSDT, Sat Nov  2 21:08:37 2024
+ * Disassembly of /tmp/aml-FSFNW2, Sat Nov  2 21:08:37 2024
  *
  * Original Table Header:
  *     Signature        "DSDT"
- *     Length           0x0000214F (8527)
+ *     Length           0x00002171 (8561)
  *     Revision         0x01 **** 32-bit table (V1), no 64-bit math support
- *     Checksum         0x59
+ *     Checksum         0xAA
  *     OEM ID           "BOCHS "
  *     OEM Table ID     "BXPC    "
  *     OEM Revision     0x00000001 (1)
@@ -1480,6 +1480,7 @@
                 CRMV,   1,
                 CEJ0,   1,
                 CEJF,   1,
+                CPRS,   1,
                 Offset (0x05),
                 CCMD,   8
             }
@@ -1514,9 +1515,16 @@
                 Acquire (\_SB.PCI0.PRES.CPLK, 0xFFFF)
                 \_SB.PCI0.PRES.CSEL = Arg0
                 Local0 = Zero
-                If ((\_SB.PCI0.PRES.CPEN == One))
-                {
-                    Local0 = 0x0F
+                If ((\_SB.PCI0.PRES.CPRS == One))
+                {
+                    If ((\_SB.PCI0.PRES.CPEN == One))
+                    {
+                        Local0 = 0x0F
+                    }
+                    Else
+                    {
+                        Local0 = 0x0D
+                    }
                 }

                 Release (\_SB.PCI0.PRES.CPLK)

Reported-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 tests/data/acpi/x86/pc/DSDT                   | Bin 8527 -> 8561 bytes
 tests/data/acpi/x86/pc/DSDT.acpierst          | Bin 8438 -> 8472 bytes
 tests/data/acpi/x86/pc/DSDT.acpihmat          | Bin 9852 -> 9886 bytes
 tests/data/acpi/x86/pc/DSDT.bridge            | Bin 15398 -> 15432 bytes
 tests/data/acpi/x86/pc/DSDT.cphp              | Bin 8991 -> 9025 bytes
 tests/data/acpi/x86/pc/DSDT.dimmpxm           | Bin 10181 -> 10215 bytes
 tests/data/acpi/x86/pc/DSDT.hpbridge          | Bin 8478 -> 8512 bytes
 tests/data/acpi/x86/pc/DSDT.hpbrroot          | Bin 5034 -> 5068 bytes
 tests/data/acpi/x86/pc/DSDT.ipmikcs           | Bin 8599 -> 8633 bytes
 tests/data/acpi/x86/pc/DSDT.memhp             | Bin 9886 -> 9920 bytes
 tests/data/acpi/x86/pc/DSDT.nohpet            | Bin 8385 -> 8419 bytes
 tests/data/acpi/x86/pc/DSDT.numamem           | Bin 8533 -> 8567 bytes
 tests/data/acpi/x86/pc/DSDT.roothp            | Bin 12320 -> 12354 bytes
 tests/data/acpi/x86/q35/DSDT                  | Bin 8355 -> 8389 bytes
 tests/data/acpi/x86/q35/DSDT.acpierst         | Bin 8372 -> 8406 bytes
 tests/data/acpi/x86/q35/DSDT.acpihmat         | Bin 9680 -> 9714 bytes
 .../acpi/x86/q35/DSDT.acpihmat-noinitiator    | Bin 8634 -> 8668 bytes
 tests/data/acpi/x86/q35/DSDT.applesmc         | Bin 8401 -> 8435 bytes
 tests/data/acpi/x86/q35/DSDT.bridge           | Bin 11968 -> 12002 bytes
 tests/data/acpi/x86/q35/DSDT.core-count       | Bin 12913 -> 12947 bytes
 tests/data/acpi/x86/q35/DSDT.core-count2      | Bin 33770 -> 33804 bytes
 tests/data/acpi/x86/q35/DSDT.cphp             | Bin 8819 -> 8853 bytes
 tests/data/acpi/x86/q35/DSDT.cxl              | Bin 13148 -> 13182 bytes
 tests/data/acpi/x86/q35/DSDT.dimmpxm          | Bin 10009 -> 10043 bytes
 tests/data/acpi/x86/q35/DSDT.ipmibt           | Bin 8430 -> 8464 bytes
 tests/data/acpi/x86/q35/DSDT.ipmismbus        | Bin 8443 -> 8477 bytes
 tests/data/acpi/x86/q35/DSDT.ivrs             | Bin 8372 -> 8406 bytes
 tests/data/acpi/x86/q35/DSDT.memhp            | Bin 9714 -> 9748 bytes
 tests/data/acpi/x86/q35/DSDT.mmio64           | Bin 9485 -> 9519 bytes
 tests/data/acpi/x86/q35/DSDT.multi-bridge     | Bin 13208 -> 13242 bytes
 tests/data/acpi/x86/q35/DSDT.noacpihp         | Bin 8235 -> 8269 bytes
 tests/data/acpi/x86/q35/DSDT.nohpet           | Bin 8213 -> 8247 bytes
 tests/data/acpi/x86/q35/DSDT.numamem          | Bin 8361 -> 8395 bytes
 tests/data/acpi/x86/q35/DSDT.pvpanic-isa      | Bin 8456 -> 8490 bytes
 tests/data/acpi/x86/q35/DSDT.thread-count     | Bin 12913 -> 12947 bytes
 tests/data/acpi/x86/q35/DSDT.thread-count2    | Bin 33770 -> 33804 bytes
 tests/data/acpi/x86/q35/DSDT.tis.tpm12        | Bin 8961 -> 8995 bytes
 tests/data/acpi/x86/q35/DSDT.tis.tpm2         | Bin 8987 -> 9021 bytes
 tests/data/acpi/x86/q35/DSDT.type4-count      | Bin 18589 -> 18623 bytes
 tests/data/acpi/x86/q35/DSDT.viot             | Bin 14615 -> 14649 bytes
 tests/data/acpi/x86/q35/DSDT.xapic            | Bin 35718 -> 35752 bytes
 tests/qtest/bios-tables-test-allowed-diff.h   |  41 ------------------
 42 files changed, 41 deletions(-)

diff --git a/tests/data/acpi/x86/pc/DSDT b/tests/data/acpi/x86/pc/DSDT
index 92225236e717b2e522a2ee00492fb0ded418dc7b..46c8ffda011e71ce0a0ee707d320f13e9afd74f8 100644
GIT binary patch
delta 125
zcmV-@0D}L|Lh(WhL{mgmaUlQz0jjYIx(o?HL0?lsUt5Arlg$iX0WFg(4Il?YP*PI?
z00NUv4JZOiHIsM^HUdQmldugnHaC-8F9csxLSIlrNia}SMN>miQd0q-8k1Zv1Yc7^
fUr<9yFi=uOQ$tWiP62QV4`87Ma0(5x{tZzR)F2~R

delta 75
zcmV-R0JQ({LeD}9L{mgmPayyR0a>vMx(o?VK3`KpUt5Amlg$iX0VtC!4Ilyl1Cvt?
hC<0A0lYI>~21o`&Q&d5dKMpPe0AP|18?zw}P!lL!6Pf@3

diff --git a/tests/data/acpi/x86/pc/DSDT.acpierst b/tests/data/acpi/x86/pc/DSDT.acpierst
index 25b39955059409b177870800949eaf937cd39005..8332df33f33ddaa4241752dcc2cf83ebd1cccd80 100644
GIT binary patch
delta 125
zcmV-@0D}MaL6|}cL{mgm7$E=v0rIg5x(o?HL0?lsUt5Arlg$iX0WFg(4Il?YP*PI?
z00NUv4JZOiHIsM^HUdQmldugnHaC-8F9csxLSIlrNia}SMN>miQd0q-8k1Zv1Yc7^
fUr<9yFi=uOQ$tWiP62QV4`87Ma0(5x{tfsNv>hY5

delta 75
zcmV-R0JQ&@LiRxlL{mgm_8<TN0iv-Ax(o?VK3`KpUt5Amlg$iX0VtC!4Ilyl1Cvt?
hC<0A0lYI>~21o`&Q&d5dKMpPe0AP|18?zw}_Yzj16#M`H

diff --git a/tests/data/acpi/x86/pc/DSDT.acpihmat b/tests/data/acpi/x86/pc/DSDT.acpihmat
index 73a9ce59e9426b180fea0ec5820c4841ebdb6700..bf093f6d8290a10a0823299238d5196d19b8e77d 100644
GIT binary patch
delta 108
zcmV-y0F(dxOrA{&L{mgmo+bbQ0cWuax(o?GM_*GyUt5Arlg$iX0WFg(4Il?YP*PI?
z00NUv4JZOhJCk?~K>|exle-Ny7B`bzF9csxLSIlrNia}SMN>miQd0qw?+qIUp#^XX
O4PcXS5EZi@4qX_VYaSc`

delta 69
zcmV-L0J{I4P5ev>L{mgmd?o+@0T!_ex(o?UL|;=vUt5Amlg$iX0VtC!4Ilyl1Cvt?
bC<075lYI?A0!RjvzzsE%3=SHzEDmxQwg?iz

diff --git a/tests/data/acpi/x86/pc/DSDT.bridge b/tests/data/acpi/x86/pc/DSDT.bridge
index 4cef454e379e1009141694e0f4036a2a701c80d7..c0bf671621348f698d2535cfd734dc05a9c7256a 100644
GIT binary patch
delta 125
zcmV-@0D}Lfc*uAPL{mgmNIU=l0l2XWx(o?HL0?lsUt5Arlg$iX0WFg(4Il?YP*PI?
z00NUv4JZOiHIsM^HUdQmldugnHaC-8F9csxLSIlrNia}SMN>miQd0q-8k1Zv1Yc7^
fUr<9yFi=uOQ$tWiP62QV4`87Ma0(5x{tYND-?SrS

delta 75
zcmV-R0JQ(ec&2y?L{mgmCOiND0cWuax(o?VK3`KpUt5Amlg$iX0VtC!4Ilyl1Cvt?
hC<0A0lYI>~21o`&Q&d5dKMpPe0AP|18?zw}CoV4C6Q%$F

diff --git a/tests/data/acpi/x86/pc/DSDT.cphp b/tests/data/acpi/x86/pc/DSDT.cphp
index 1dc928333d7ae7e4df6bb51d850af5e1cb480158..e72a2df567d28b08b17051dd5612fb77abaf6e20 100644
GIT binary patch
delta 108
zcmV-y0F(cpM!`l3L{mgmK_dVF0S>VWx(o?HUSCr}Ut5Arlg$iX0WFg(4Il?YP*PI?
z00NUv4JZOiQj>TMasovNlk5#O7B`bzF9csxLSIlrNia}SMN>miQd0qwAPyS_p#^XX
O4PcX@5EZjf4$l-zMIEpJ

delta 69
zcmV-L0J{IdMxRCsL{mgmA0q$&0ll#bx(o?VTVGQ`Ut5Amlg$iX0VtC!4Ilyl1Cvt?
bC<0ATlYI?x0!Rjv@eMVTJq{YPT@K_Fz)ut-

diff --git a/tests/data/acpi/x86/pc/DSDT.dimmpxm b/tests/data/acpi/x86/pc/DSDT.dimmpxm
index 9f71d2e58b1707e733584e38dab7f73f9bda5eb7..17a53d9ef714c973c934fdbd2021b2c03fa08a87 100644
GIT binary patch
delta 103
zcmV-t0GR*9Pv=hxL{mgm=O+LF0n4!p&I}1kQeRU-Ut5Arli>_r0WFh24Il?YP*PI?
z00NU@4JZObN0W>VSpr1}ljjXJ7B`bzF9csxLSIlrNia}SMN>miQd0qw8x9)<p#^XX
J4YM^4kQr`|9g+Y5

delta 96
zcmV-m0H6QoPsL9PL{mgm#U}s&0g15+&I}1iP+wC*Ut5Amli>_r0VtC|4Ilyl1CwVB
zC;~=BlaUQs0!Rjv><u*<8k1Zv1Yc7^Ur<9yFi=uOQ$tWiP62QV4`7oZ5EZj+4tg1d
CN*kj9

diff --git a/tests/data/acpi/x86/pc/DSDT.hpbridge b/tests/data/acpi/x86/pc/DSDT.hpbridge
index db420593a3c51eced25cd57420353fbb9ccdf63c..26f5a1875162459daaa285fef8b6c63678f7726a 100644
GIT binary patch
delta 125
zcmV-@0D}LXLcl@_L{mgmKp_AC0p76+x(o?HL0?lsUt5Arlg$iX0WFg(4Il?YP*PI?
z00NUv4JZOiHIsM^HUdQmldugnHaC-8F9csxLSIlrNia}SMN>miQd0q-8k1Zv1Yc7^
fUr<9yFi=uOQ$tWiP62QV4`87Ma0(5x{tX}#q@E(k

delta 75
zcmV-R0JQ(WLY_hjL{mgm9w7h#0gbT=x(o?VK3`KpUt5Amlg$iX0VtC!4Ilyl1Cvt?
hC<0A0lYI>~21o`&Q&d5dKMpPe0AP|18?zw}9}^2{6AAzT

diff --git a/tests/data/acpi/x86/pc/DSDT.hpbrroot b/tests/data/acpi/x86/pc/DSDT.hpbrroot
index 31b6adb4eb941e5bf0c02ec8c3819c9213adf022..e0c7c2a56d5d8afb5f78134c9b175d6153dca776 100644
GIT binary patch
delta 132
zcmV-~0DJ$cC(I`bL{mgm%o6|r0nV`sZ3_uOL0?lsUt5ArlYk3e0WFi?3m^wWP*PI?
z00NT%3@8FhHIpk0HU>oqLsL{ilh6z<IRIdwH<Mg11Yc7^Ur<9yFi=uOQ$tWvQvskF
mlUy$ZUsFO~P(w*DP*O!xLr_Id0dNWrV4($Y3JtTd4EYA91|?Yl

delta 103
zcmV-t0GR*GC#ok3L{mgmsuKVJ0e!IwZ3_ucK3`KpUt5AmlYk3e0VtE-3m^gj1Cs^}
zC<0A0lQ0Z62S^4(Q&d3-lTi&9lg|zo8~|XT8k1Zv1Yc7^Ur<9yFi=uOQ$tWiP62QV
J53|z@`39~899{qb

diff --git a/tests/data/acpi/x86/pc/DSDT.ipmikcs b/tests/data/acpi/x86/pc/DSDT.ipmikcs
index c2a0330d97d495298889b9e28bde2f90235cea88..119bd256adfb443922cf988e4f4ac3278a1d55ba 100644
GIT binary patch
delta 125
zcmV-@0D}LQL%Bl=L{mgmxgh`m0Vc5ux(o?HL0?lsUt5Arlg$iX0WFg(4Il?YP*PI?
z00NUv4JZOiHIsM^HUdQmldugnHaC-8F9csxLSIlrNia}SMN>miQd0q-8k1Zv1Yc7^
fUr<9yFi=uOQ$tWiP62QV4`87Ma0(5x{tcNEhRP!L

delta 75
zcmV-R0JQ(PLzhDeL{mgmmmvTE0oAbzx(o?VK3`KpUt5Amlg$iX0VtC!4Ilyl1Cvt?
hC<0A0lYI>~21o`&Q&d5dKMpPe0AP|18?zw}m=ifW6gU6?

diff --git a/tests/data/acpi/x86/pc/DSDT.memhp b/tests/data/acpi/x86/pc/DSDT.memhp
index c15a9fae947bb3929a30c60b7c0f2092705868f8..9ca8a6e2f7898ccd304de44a34bd318a209917e9 100644
GIT binary patch
delta 125
zcmV-@0D}LXO~6eGL{mgmz$O3y0gbT=x(o?NL0?lsUt5Arlg$iX0WFg(4Il?YP*PI?
z00NUv4JZOYHj{V_HUdQmldugnHaC-8F9csxLSIlrNia}SMN>miQd0q-8k1Zv1Yc7^
fUr<9yFi=uOQ$tWiP62QV4`87Ma0(5x{tciQ$vGpG

delta 75
zcmV-R0JQ(WO`c5(L{mgmo+bbQ0ZXw8x(o?LKVMTqUt5Amlg$iX0VtC!4Ilyl1Cvt?
hC;~$?lYI>~21o`&Q&d5dKMpPe0AP|18?zw}pBN%i6V?C#

diff --git a/tests/data/acpi/x86/pc/DSDT.nohpet b/tests/data/acpi/x86/pc/DSDT.nohpet
index dd29f5cb620e5164601e303e37524530ddb12684..6127a2c9ac43e961e7e8ca01673117382c20bedb 100644
GIT binary patch
delta 132
zcmV-~0DJ$zLE}LRL{mgm;~)S40d%nnEDQ-jL0?lsUt5ArlRpez0WFiB3?K(XP*PI?
z00NW13@8FhHIwQLHU>oqLsL{ilaCE9IRIdwH<Mg11Yc7^Ur<9yFi=uOQ$tWvQvskF
mlUy$ZUsFO~P(w*DP*O!xLr_Id0dNWrV4($Y3JtSx4N()<(j_PW

delta 98
zcmV-o0G<EiLBT-^L{mgm!5{zt0VA;rEDQ-xK3`KpUt5AmlRpez0VtE63?Kpk1CzxJ
zC<0A0lkW^R21o`&Q&d5du?;R90AQdRlUy$ZUsFO~P(w*DP*O!xLr_Id0dNWrvyu%_
E6I@6eQ~&?~

diff --git a/tests/data/acpi/x86/pc/DSDT.numamem b/tests/data/acpi/x86/pc/DSDT.numamem
index 8a6b56fe7da18bf42c339d13b863aabf81780527..18c815efa890503f5e0ca94665239f58fe283735 100644
GIT binary patch
delta 125
zcmV-@0D}M3Lia)nL{mgmcOd`(0Y$M2x(o?NL0?lsUt5Arlg$iX0WFg(4Il?YP*PI?
z00NUv4JZOYHj{V_HUdQmldugnHaC-8F9csxLSIlrNia}SMN>miQd0q-8k1Zv1Yc7^
fUr<9yFi=uOQ$tWiP62QV4`87Ma0(5x{tZ_Xu+1X~

delta 75
zcmV-R0JQ)2Le)YFL{mgmRUrTX0RyoLx(o?LKVMTqUt5Amlg$iX0VtC!4Ilyl1Cvt?
hC;~$?lYI>~21o`&Q&d5dKMpPe0AP|18?zw}RudKi6G{L8

diff --git a/tests/data/acpi/x86/pc/DSDT.roothp b/tests/data/acpi/x86/pc/DSDT.roothp
index a16b0d9d4becec47fa3cf57ed0077ff6cff88908..8256503220c11cbb902c6967fccba87e711bcd5a 100644
GIT binary patch
delta 125
zcmV-@0D}LZV8UPuL{mgmLNEXT0XDG;x(o?HL0?lsUt5Arlg$iX0WFg(4Il?YP*PI?
z00NUv4JZOiHIsM^HUdQmldugnHaC-8F9csxLSIlrNia}SMN>miQd0q-8k1Zv1Yc7^
fUr<9yFi=uOQ$tWiP62QV4`87Ma0(5x{tY4`f<hvK

delta 75
zcmV-R0JQ(YV4z?ML{mgmATR&`0p+m@x(o?VK3`KpUt5Amlg$iX0VtC!4Ilyl1Cvt?
hC<0A0lYI>~21o`&Q&d5dKMpPe0AP|18?zw}AtE;m6T|=j

diff --git a/tests/data/acpi/x86/q35/DSDT b/tests/data/acpi/x86/q35/DSDT
index fb89ae0ac6d4346e33156e9e4d3718698a0a1a8e..b0bbff7686c9a56129bfa3408e62f142cc482713 100644
GIT binary patch
delta 108
zcmV-y0F(ctLB&A|L{mgm#UKCx0f?~*2N?-LL0?lsUt5ArlNuRb0WFhx86XEkP*PI?
z00NVn87KluHIu~|HUdQmll>Vr7B`bzF9csxLSIlrNia}SMN>miQd0qwF&Y~Np#^XX
O4PcY892K)+8bStU_Z`Xr

delta 76
zcmV-S0JHzaL8CzmL{mgmqaXkP0XMM<2N?-ZK3`KpUt5AmlNuRb0VtDs86W}x1CyW`
iC<0A0lgb%321o`&Q&d5dj2bQi0AQ0%8XL228dnAt3lug0

diff --git a/tests/data/acpi/x86/q35/DSDT.acpierst b/tests/data/acpi/x86/q35/DSDT.acpierst
index 46fd25400b7c00ee9149ddb64cb5d5bd73f6a82b..f91cbe55fcfeea319babf7c9a0c6a6ccdc3320d1 100644
GIT binary patch
delta 108
zcmV-y0F(c;LDoSEL{mgm)*t`?0VuHw2N?-LL0?lsUt5ArlNuRb0WFhx86XEkP*PI?
z00NVn87KluHIu~|HUdQmll>Vr7B`bzF9csxLSIlrNia}SMN>miQd0qwF&Y~Np#^XX
O4PcY892K)+8dC;Xq8+XP

delta 76
zcmV-S0JHzrL9{^%L{mgmv>*Tg0oSn#2N?-ZK3`KpUt5AmlNuRb0VtDs86W}x1CyW`
iC<0A0lgb%321o`&Q&d5dj2bQi0AQ0%8XL228fXSeRuvim

diff --git a/tests/data/acpi/x86/q35/DSDT.acpihmat b/tests/data/acpi/x86/q35/DSDT.acpihmat
index 61c5bd52a42242e85090934e8e45bf01642609d6..0949fb9d67c70dc882e50501ece421114ad8080b 100644
GIT binary patch
delta 122
zcmV-=0EPe1OY%z!L{mgm@+ANO0Y$M22N?-KM_*GyUt5ArlNuRb0WFhx86XEkP*PI?
z00NVn87KltJCns3K?y|&LsL{i30otRAsiEviy9ai0AQdulUy$ZUsFO~P(w*DP*O!x
cLr_vv0h2r$8wQ~Ta0(4zlOG%vvuqk<3nf7y_y7O^

delta 96
zcmV-m0H6QzOVCRSL{mgm&?Nu>0ras72N?-YL|;=vUt5AmlNuRb0VtDs86W}x1CyW`
zC<075lgb%E0!Rjv4H`8X8k1Zv1Yc7^Ur<9yFi=uOQ$tWiP62QV4`7o)92K*U8e|Jg
C=NiBO

diff --git a/tests/data/acpi/x86/q35/DSDT.acpihmat-noinitiator b/tests/data/acpi/x86/q35/DSDT.acpihmat-noinitiator
index 3aaa2bbdf54a0d0cade14421e84c6ec5a42f96fa..0fa4daa35cf95f93ba8c15f478460fe4e14e6d9e 100644
GIT binary patch
delta 125
zcmV-@0D}LzL)=3OL{mgm+#vt}0spZI2N?-SQeRU-Ut5ArlNuRb0WFhx86XEkP*PI?
z00NVn87KllN0Y@FSpr1}lOP&3HaC-8F9csxLSIlrNia}SMN>miQd0q-8k1Zv1Yc7^
fUr<9yFi=uOQ$tWiP62QV4`87Ma0(5xZW>Gn*IFXn

delta 76
zcmV-S0JHzxL%Kr>L{mgmx*-4n0ll#b2N?-QP+wC*Ut5AmlNuRb0VtDs86W}x1CyW`
iC;~)9lgb%c21o`&Q&d5duNp1_0AQ1F8XL2b8cPRMBNdqd

diff --git a/tests/data/acpi/x86/q35/DSDT.applesmc b/tests/data/acpi/x86/q35/DSDT.applesmc
index 944209adeaa5bbb722431161c404cb51b8209993..a5d032b7d96113c9393036b2ba831adb6d584142 100644
GIT binary patch
delta 108
zcmV-y0F(dGLGwWhL{mgm^B@2K0eG<r2N?-LL0?lsUt5ArlNuRb0WFhx86XEkP*PI?
z00NVn87KluHIu~|HUdQmll>Vr7B`bzF9csxLSIlrNia}SMN>miQd0qwF&Y~Np#^XX
O4PcY892K)+8gK@gu^w^&

delta 76
zcmV-S0JHz|LD4}9L{mgm(I5Z-0VlBv2N?-ZK3`KpUt5AmlNuRb0VtDs86W}x1CyW`
iC<0A0lgb%321o`&Q&d5dj2bQi0AQ0%8XL228ifWpg%sWZ

diff --git a/tests/data/acpi/x86/q35/DSDT.bridge b/tests/data/acpi/x86/q35/DSDT.bridge
index d9938dba8fa5d405f7696c0dbdc24f3ae42ec934..3464f552974672bde25eb15f1c93c309c57ef5cb 100644
GIT binary patch
delta 108
zcmV-y0F(c~UE*B|L{mgm;w}IH0i>}C2N?-LL0?lsUt5ArlNuRb0WFhx86XEkP*PI?
z00NVn87KluHIu~|HUdQmll>Vr7B`bzF9csxLSIlrNia}SMN>miQd0qwF&Y~Np#^XX
O4PcY892K)+8ebH#h#sy0

delta 76
zcmV-S0JHz%UBF!mL{mgmz%Bp)0aLLG2N?-ZK3`KpUt5AmlNuRb0VtDs86W}x1CyW`
iC<0A0lgb%321o`&Q&d5dj2bQi0AQ0%8XL228gvv$d=(l1

diff --git a/tests/data/acpi/x86/q35/DSDT.core-count b/tests/data/acpi/x86/q35/DSDT.core-count
index a24b04cbdbf09383b933a42a2a15182545543a87..08f5d5f54bcb61235b98fc85bb814046dd038c13 100644
GIT binary patch
delta 110
zcmV-!0FnRkWRqnIL{mgmlQIAR0r9a42N?>FT>)QHLSI{gO_LiLUI8tWdKn-GLr_vv
z0RRG%oEazrhf=e~8M6WcMF^9795og<lUy$ZUsFO~P(w*DP*O!xLr_vv0h6yB8wQ~T
Qa0(4zlQ16@v)>$&6%NoKK>z>%

delta 71
zcmV-N0J#5?W$|PRL{mgmaWVh^0k5$N2N?>DTLE8FLSI{gNRt~GUI8eRdKn-B00Wbu
d87KmZP_xS!vjPH029tmsHIvL78nf&irxpI;78U>i

diff --git a/tests/data/acpi/x86/q35/DSDT.core-count2 b/tests/data/acpi/x86/q35/DSDT.core-count2
index 3a0cb8c581c8cc630a2ec21712b7f8b75fcad1c8..d29a7108f82110ce9f9b4e006501215d41c5420a 100644
GIT binary patch
delta 126
zcmV-^0D=GNhXRa<0t!S^L{tof0003(u?hzn3W#+EUsFO~TY^oK8yQ{!Et7f~AO}NG
zQd0o{0+XB>C<1_Lv&I=;3<*UDLsL{i30otRK`0ZGswNm20AQdulUy$ZUsFO~P(w*D
gP*O!xLr_vv0h3!M8wQ~Ta0(4zlRqdGvx_EQU6UXp_5c6?

delta 100
zcmV-q0Gt1ehyv<|0t!S^L{#d700032u?hzn3WjqAUsFO~TY^ZF8yQ{!D3f{_AOZjb
zlc5<X0)uF?%Nbt`0!RjvEG9J?8k1Zv1Yc7^Ur<9yFi=uOQ$tWiP62QV4`7pFC>67<
GCSP5hTO4Nq

diff --git a/tests/data/acpi/x86/q35/DSDT.cphp b/tests/data/acpi/x86/q35/DSDT.cphp
index 20955d0aa30120553da35d5a6640055d26255cf9..7fd59bf6702c04a622f05ae356a2ea37312ab403 100644
GIT binary patch
delta 108
zcmV-y0F(doM3qGfL{mgml_CHD0qn5~2N?-LUSCr}Ut5ArlNuRb0WFhx86XEkP*PI?
z00NVn87KluQj^6QasovNlQ|kS7B`bzF9csxLSIlrNia}SMN>miQd0qwZ5kT}p#^XX
O4PcW{92K*j8rBDgEFOjc

delta 73
zcmV-P0Ji^?Me{@oL{mgmb0Po$0h_T32N?-ZTVGQ`Ut5AmlNuRb0VtDs86W}x1CyW`
fC<0ATlgb%#0!RjvJ{mQXiW(Y|5FHh>zZ%vD0Bsc$

diff --git a/tests/data/acpi/x86/q35/DSDT.cxl b/tests/data/acpi/x86/q35/DSDT.cxl
index f561750cab8b061c123c041fe2209d74c7a740f1..92769c630dc362c781c4e9a83d6f8be306121c5a 100644
GIT binary patch
delta 108
zcmV-y0F(dRX8vXhL{mgmelq|70i3Z42N?-LL0?lsUt5ArlNuRb0WFhx86XEkP*PI?
z00NVn87KluHIu~|HUdQmll>Vr7B`bzF9csxLSIlrNia}SMN>miQd0qwF&Y~Np#^XX
O4PcY892K)+8v7Wj?jJD#

delta 76
zcmV-S0JH!8X53~9L{mgmTr&Uw0ZXw82N?-ZK3`KpUt5AmlNuRb0VtDs86W}x1CyW`
iC<0A0lgb%321o`&Q&d5dj2bQi0AQ0%8XL228W0&mgA|?s

diff --git a/tests/data/acpi/x86/q35/DSDT.dimmpxm b/tests/data/acpi/x86/q35/DSDT.dimmpxm
index 228374b55bd544116e359f659e546fc66cf8a895..1db0bf454a203006f866e6752d06422ae675cbd3 100644
GIT binary patch
delta 132
zcmV-~0DJ$LPP<MDL{mgmJ0}1D0jRMG8yN{oQeRU-Ut5ArlP(!v0WFh_86XEkP*PI?
z00NV*87KlnN0ZqZSq4Q2LsL{ilc5?eIRIdwH<Mg11Yc7^Ur<9yFi=uOQ$tWvQvskF
mlUy$ZUsFO~P(w*DP*O!xLr_Id0dNWrV4($Y3JtS@8kY>9)+IIo

delta 91
zcmV-h0HpuBPMJ;$L{mgm87BY$0cNoZ8yN{mP+wC*Ut5AmlP(!v0VtD=86W}x1Cz8F
xC;~=BlinFw0!RjvIT|$?8k1Zv1Yc7^Ur<9yFi=uOQ$tWiP62QV53{5imkeVJ7_9&R

diff --git a/tests/data/acpi/x86/q35/DSDT.ipmibt b/tests/data/acpi/x86/q35/DSDT.ipmibt
index 45f911ada5645f158f3d6c0c430ec1d52cadc5d8..25f43ae8efb55364a739e6b5e3cb4e71e61862b0 100644
GIT binary patch
delta 108
zcmV-y0F(djL6AZUL{mgm5Fr2n0lTpZ2N?-LL0?lsUt5ArlNuRb0WFhx86XEkP*PI?
z00NVn87KluHIu~|HUdQmll>Vr7B`bzF9csxLSIlrNia}SMN>miQd0qwF&Y~Np#^XX
O4PcY892K)+8jS`%#T}~v

delta 76
zcmV-S0JHy)LheBdL{mgm?jQgF0c)`e2N?-ZK3`KpUt5AmlNuRb0VtDs86W}x1CyW`
iC<0A0lgb%321o`&Q&d5dj2bQi0AQ0%8XL228lna~7Zn!(

diff --git a/tests/data/acpi/x86/q35/DSDT.ipmismbus b/tests/data/acpi/x86/q35/DSDT.ipmismbus
index e5d6811bee1233d74236453c49060390d74d4416..32bcd25bda9e9d2775790385f8da6a11e9d5cb46 100644
GIT binary patch
delta 108
zcmV-y0F(dwL7hShL{mgm9U%Y!0W7f!2N?-LL0?lsUt5ArlNuRb0WFhx86XEkP*PI?
z00NVn87KluHIu~|HUdQmll>Vr7B`bzF9csxLSIlrNia}SMN>miQd0qwF&Y~Np#^XX
O4PcY892K)+8kz<gLLE>5

delta 76
zcmV-S0JHy{Li<4qL{mgm`yc=S0o<_)2N?-ZK3`KpUt5AmlNuRb0VtDs86W}x1CyW`
iC<0A0lgb%321o`&Q&d5dj2bQi0AQ0%8XL228m|Uoloh-H

diff --git a/tests/data/acpi/x86/q35/DSDT.ivrs b/tests/data/acpi/x86/q35/DSDT.ivrs
index 46fd25400b7c00ee9149ddb64cb5d5bd73f6a82b..f91cbe55fcfeea319babf7c9a0c6a6ccdc3320d1 100644
GIT binary patch
delta 108
zcmV-y0F(c;LDoSEL{mgm)*t`?0VuHw2N?-LL0?lsUt5ArlNuRb0WFhx86XEkP*PI?
z00NVn87KluHIu~|HUdQmll>Vr7B`bzF9csxLSIlrNia}SMN>miQd0qwF&Y~Np#^XX
O4PcY892K)+8dC;Xq8+XP

delta 76
zcmV-S0JHzrL9{^%L{mgmv>*Tg0oSn#2N?-ZK3`KpUt5AmlNuRb0VtDs86W}x1CyW`
iC<0A0lgb%321o`&Q&d5dj2bQi0AQ0%8XL228fXSeRuvim

diff --git a/tests/data/acpi/x86/q35/DSDT.memhp b/tests/data/acpi/x86/q35/DSDT.memhp
index 5ce081187a578ba7145a9ba20d30be36c13b7663..be90eb71d8dda8fe54c79ffffe103986ee06ae3a 100644
GIT binary patch
delta 108
zcmV-y0F(dnOO#9sL{mgm6ea)w0cx=d2N?-RL0?lsUt5ArlNuRb0WFhx86XEkP*PI?
z00NVn87KlkHj~8}HUdQmll>Vr7B`bzF9csxLSIlrNia}SMN>miQd0qwF&Y~Np#^XX
O4PcY892K)+8j%YyK^=tv

delta 76
zcmV-S0JHy;O!7+#L{mgm@+ANO0V%Nx2N?-PKVMTqUt5AmlNuRb0VtDs86W}x1CyW`
iC;~$?lgb%321o`&Q&d5dj2bQi0AQ0%8XL228m0>~pA_)`

diff --git a/tests/data/acpi/x86/q35/DSDT.mmio64 b/tests/data/acpi/x86/q35/DSDT.mmio64
index bdf36c4d575bfc4eb2eac3f00c9b7b4270f88677..01f276a6aff38a1d4f58640a9e6d120fc9a04b61 100644
GIT binary patch
delta 108
zcmV-y0F(cXO0P-^L{mgmFC_o~0V}Zz2N?-RL0?lsUt5ArlNuRb0WFhx86XEkP*PI?
z00NVn87KlkHj~8}HUdQmll>Vr7B`bzF9csxLSIlrNia}SMN>miQd0qwF&Y~Np#^XX
O4PcY892K)+8mtNexE(D3

delta 76
zcmV-S0JHzEN{vbiL{mgm4J7~o0qL;{2N?-PKVMTqUt5AmlNuRb0VtDs86W}x1CyW`
iC;~$?lgb%321o`&Q&d5dj2bQi0AQ0%8XL228o>$>SQME6

diff --git a/tests/data/acpi/x86/q35/DSDT.multi-bridge b/tests/data/acpi/x86/q35/DSDT.multi-bridge
index 1db43a69e4c2affd8bd678bbef4d3c228380288e..1bd2ee8d2ebd3c9e0ed89a86478691f2e06f2590 100644
GIT binary patch
delta 108
zcmV-y0F(ciXS!z!L{mgmx-$R(0iCf52N?-LL0?lsUt5ArlNuRb0WFhx86XEkP*PI?
z00NVn87KluHIu~|HUdQmll>Vr7B`bzF9csxLSIlrNia}SMN>miQd0qwF&Y~Np#^XX
O4PcY892K)+8aEk-^&TYv

delta 76
zcmV-S0JHzPXP9RSL{mgmm@@zX0Zg$92N?-ZK3`KpUt5AmlNuRb0VtDs86W}x1CyW`
iC<0A0lgb%321o`&Q&d5dj2bQi0AQ0%8XL228cZ20sT7d_

diff --git a/tests/data/acpi/x86/q35/DSDT.noacpihp b/tests/data/acpi/x86/q35/DSDT.noacpihp
index 8bc16887e1c963c61aaecf71712a09c0554f6d67..45cc2bcffa42d73db110afd5075556dcfe5d9936 100644
GIT binary patch
delta 125
zcmV-@0D}LkK+Ql3L{mgmO&|aO0UNOjx)%vSL0?lsUt5Arlg$@i0WFg(7$65jP*PI?
z00NUv7$^ctHIsN4HUdQmldu>yHaC-8F9csxLSIlrNia}SMN>miQd0q-8k1Zv1Yc7^
fUr<9yFi=uOQ$tWiP62QV4`87Ma0(5x{unI>b*&<G

delta 75
zcmV-R0JQ(jK&wCsL{mgmD<A*>0m`uox)%vgK3`KpUt5Amlg$@i0VtC!7$5=w1Cvu2
hC<0A0lYJOA21o`&Q&d5dKN&6p0AP|C8?zx9EC(#i6T$!h

diff --git a/tests/data/acpi/x86/q35/DSDT.nohpet b/tests/data/acpi/x86/q35/DSDT.nohpet
index c13e45e3612646cc2e30f00b3b7e53335da816ea..f110504b9c813aa07802fc17d2869596a2eeca6f 100644
GIT binary patch
delta 125
zcmV-@0D}LOK({~&L{mgmHy{820a39Ec^C;nL0?lsUt5ArlZ+T%0WFj37$65jP*PI?
z00NT@87KluHIp|PHUdQmlW!R{HaC-8F9csxLSIlrNia}SMN>miQd0q-8k1Zv1Yc7^
fUr<9yFi=uOQ$tWiP62QV4`87Ma0(5xy%|^rNJSyi

delta 76
zcmV-S0JHzMK$SoWL{mgm6(9fr0RXWIc^C;#K3`KpUt5AmlZ+T%0VtE}7$5=w1CtUN
iC<0A0lROzV21o`&Q&d5d{uwR;0AQ2985^_U8CM1b{}kN-

diff --git a/tests/data/acpi/x86/q35/DSDT.numamem b/tests/data/acpi/x86/q35/DSDT.numamem
index ba6669437e65952f24516ded954b33fe54bdedfb..6090958f39875f5806e72e23f32cb4b3ae840627 100644
GIT binary patch
delta 108
zcmV-y0F(czLCZl3L{mgm%OC&%0VA;r2N?-RL0?lsUt5ArlNuRb0WFhx86XEkP*PI?
z00NVn87KlkHj~8}HUdQmll>Vr7B`bzF9csxLSIlrNia}SMN>miQd0qwF&Y~Np#^XX
O4PcY892K)+8b}67S{-@-

delta 76
zcmV-S0JHzgL8(CsL{mgmsUQFV0pYO<2N?-PKVMTqUt5AmlNuRb0VtDs86W}x1CyW`
iC;~$?lgb%321o`&Q&d5dj2bQi0AQ0%8XL228eIlJS`_90

diff --git a/tests/data/acpi/x86/q35/DSDT.pvpanic-isa b/tests/data/acpi/x86/q35/DSDT.pvpanic-isa
index 6ad42873e91c80cef5a42224cb4d31936dad59b4..7a8e568315a43f1fa98068d8e78995c98064fb91 100644
GIT binary patch
delta 108
zcmV-y0F(cSLaIUvL{mgmDj@&>0Xne?2N?-LL0?lsUt5ArlNuRb0WFhx86XEkP*PI?
z00NVn87KluHIu~|HUdQmll>Vr7B`bzF9csxLSIlrNia}SMN>miQd0qwF&Y~Np#^XX
O4PcY892K)+8m9*N!5tF-

delta 76
zcmV-S0JHz9LWn{NL{mgm2q6Ff0qL;{2N?-ZK3`KpUt5AmlNuRb0VtDs86W}x1CyW`
iC<0A0lgb%321o`&Q&d5dj2bQi0AQ0%8XL228oUMxWE6h@

diff --git a/tests/data/acpi/x86/q35/DSDT.thread-count b/tests/data/acpi/x86/q35/DSDT.thread-count
index a24b04cbdbf09383b933a42a2a15182545543a87..08f5d5f54bcb61235b98fc85bb814046dd038c13 100644
GIT binary patch
delta 110
zcmV-!0FnRkWRqnIL{mgmlQIAR0r9a42N?>FT>)QHLSI{gO_LiLUI8tWdKn-GLr_vv
z0RRG%oEazrhf=e~8M6WcMF^9795og<lUy$ZUsFO~P(w*DP*O!xLr_vv0h6yB8wQ~T
Qa0(4zlQ16@v)>$&6%NoKK>z>%

delta 71
zcmV-N0J#5?W$|PRL{mgmaWVh^0k5$N2N?>DTLE8FLSI{gNRt~GUI8eRdKn-B00Wbu
d87KmZP_xS!vjPH029tmsHIvL78nf&irxpI;78U>i

diff --git a/tests/data/acpi/x86/q35/DSDT.thread-count2 b/tests/data/acpi/x86/q35/DSDT.thread-count2
index 3a0cb8c581c8cc630a2ec21712b7f8b75fcad1c8..d29a7108f82110ce9f9b4e006501215d41c5420a 100644
GIT binary patch
delta 126
zcmV-^0D=GNhXRa<0t!S^L{tof0003(u?hzn3W#+EUsFO~TY^oK8yQ{!Et7f~AO}NG
zQd0o{0+XB>C<1_Lv&I=;3<*UDLsL{i30otRK`0ZGswNm20AQdulUy$ZUsFO~P(w*D
gP*O!xLr_vv0h3!M8wQ~Ta0(4zlRqdGvx_EQU6UXp_5c6?

delta 100
zcmV-q0Gt1ehyv<|0t!S^L{#d700032u?hzn3WjqAUsFO~TY^ZF8yQ{!D3f{_AOZjb
zlc5<X0)uF?%Nbt`0!RjvEG9J?8k1Zv1Yc7^Ur<9yFi=uOQ$tWiP62QV4`7pFC>67<
GCSP5hTO4Nq

diff --git a/tests/data/acpi/x86/q35/DSDT.tis.tpm12 b/tests/data/acpi/x86/q35/DSDT.tis.tpm12
index e381ce4cbf2b11f56a2d0537db4d21acc97450c9..29a416f0508655d2bfde01fff4d25ad7f89581d9 100644
GIT binary patch
delta 108
zcmV-y0F(cLMx#awL{mgmBO?F+0l2XW2N?-LL0?lsUt5ArlNuRb0WFhx86XEkP*PI?
z00NVn87KluHIu~|HUdQmll>Vr7B`bzF9csxLSIlrNia}SMN>miQd0qwF&Y~Np#^XX
O4PcY892K)+8lVUxjU9mi

delta 76
zcmV-S0JHz2MuA2OL{mgm0V4na0cWua2N?-ZK3`KpUt5AmlNuRb0VtDs86W}x1CyW`
iC<0A0lgb%321o`&Q&d5dj2bQi0AQ0%8XL228np=KvJ>q9

diff --git a/tests/data/acpi/x86/q35/DSDT.tis.tpm2 b/tests/data/acpi/x86/q35/DSDT.tis.tpm2
index a09253042ce4a715922027245de8a2ab7449c5b7..59288f02c43cf2efc1555599131fde05dbbaa1cd 100644
GIT binary patch
delta 108
zcmV-y0F(clM!iM~L{mgmJtF`B0dlbl2N?-LL0?lsUt5ArlNuRb0WFhx86XEkP*PI?
z00NVn87KluHIu~|HUdQmll>Vr7B`bzF9csxLSIlrNia}SMN>miQd0qwF&Y~Np#^XX
O4PcY892K)+8oCH6*Bzq(

delta 76
zcmV-S0JHzSMw><oL{mgm8zTS!0U@yp2N?-ZK3`KpUt5AmlNuRb0VtDs86W}x1CyW`
iC<0A0lgb%321o`&Q&d5dj2bQi0AQ0%8XL228qWyp{1guW

diff --git a/tests/data/acpi/x86/q35/DSDT.type4-count b/tests/data/acpi/x86/q35/DSDT.type4-count
index edc23198cdb47a981bcbc82bc8e392b815abb554..eaca76e8e61eb62f75dbdf093e803eea34330deb 100644
GIT binary patch
delta 135
zcmV;20C@kMkpaJv0SZJ@L{z^>0003Uu?hzn3X8x3UsFO~TY^oK8yQ{!Et7f~AO}NG
zQd0o{0+XB>C<24Ev&I?A1qMY3LsL{ik{~WQ0AQdulUy$ZUsFO~P(w*DP*O!xLr_vv
p0iYU_TrUJ)Q$k-*LrE}DQbkikP(@Awa0(A#p#^XX4YT1NyeMbeCx8F|

delta 106
zcmV-w0G0p0kpZ2N0SZJ@L{yzf0005ou?hzn3W>e~UsFO~TY^ZF8yQ{!D3f{_AOZjb
zlc5<X0*14*%NffB2S^4(Q&d3-lYt-?k|Guy0AQdRlUy$ZUsFO~P(w*DP*O!xLr_Id
M0dNWrvjZT!D56px$^ZZW

diff --git a/tests/data/acpi/x86/q35/DSDT.viot b/tests/data/acpi/x86/q35/DSDT.viot
index 8d98dd8845a60a08df5aff27097646bea4913b75..71379a48ddebf7e1f5e853fcbbb6befd561cb8e4 100644
GIT binary patch
delta 108
zcmV-y0F(cha=CH}L{mgmIXM6T0V=Ty2N?-LL0?lsUt5ArlNuRb0WFhx86XEkP*PI?
z00NVn87KluHIu~|HUdQmll>Vr7B`bzF9csxLSIlrNia}SMN>miQd0qwF&Y~Np#^XX
O4PcY892K)+8nzxcZ5_`5

delta 76
zcmV-S0JHzOa+h)nL{mgm7dZd`0okz%2N?-ZK3`KpUt5AmlNuRb0VtDs86W}x1CyW`
iC<0A0lgb%321o`&Q&d5dj2bQi0AQ0%8XL228p|FuVHG<7

diff --git a/tests/data/acpi/x86/q35/DSDT.xapic b/tests/data/acpi/x86/q35/DSDT.xapic
index d4acd851c62c956436a436f9fa6d08fc5f370fa7..9059812b5892ba7ac5c9bd312fd9f45a4f59f105 100644
GIT binary patch
delta 135
zcmV;20C@j~mjbAl0t!S^L{zAY0003mu?hzn3WV<lUsFO~TY^oK8yQ{!Et7f~AO}NG
zQd0o{0+XB>C<2V*v&I?A4F*LBLsL{ik|-`Y0AQdulUy$ZUsFO~P(w*DP*O!xLr_vv
p0iYU_TrUJ)Q$k-*LrE}DQbkikP(@Awa0(A#p#^XX4YT1VrDL5sC_MlG

delta 107
zcmV-x0F?izmjZ^D0t!S^L{x^00005)u?hzn3WDthUsFO~TY^ZF8yQ{!D3f{_AOZjb
zlc5<X0*~Rd%NffJ2S^4(Q&d3-lYuA~lR79C8~|XT8k1Zv1Yc7^Ur<9yFi=uOQ$tWi
NP62QV53>U(rDNy6AIJaz

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


