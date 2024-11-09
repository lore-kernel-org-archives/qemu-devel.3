Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7A10D64097
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Nov 2024 00:09:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9Z22-0006e7-Df; Fri, 08 Nov 2024 19:08:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1t9Z1y-0006dI-12; Fri, 08 Nov 2024 19:08:46 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1t9Z1u-0004Uc-DK; Fri, 08 Nov 2024 19:08:45 -0500
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XlbkV3DDnz6L6vc;
 Sat,  9 Nov 2024 08:08:34 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
 by mail.maildlp.com (Postfix) with ESMTPS id 859DC140517;
 Sat,  9 Nov 2024 08:08:40 +0800 (CST)
Received: from 00293818-MRGF.huawei.com (10.48.150.69) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 9 Nov 2024 01:08:26 +0100
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
Subject: [PATCH V2 3/3] tests/qtest/bios-tables-test: Fix DSDT golden masters
 for x86/{pc, q35}
Date: Sat, 9 Nov 2024 00:07:28 +0000
Message-ID: <20241109000728.206825-4-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241109000728.206825-1-salil.mehta@huawei.com>
References: <20241109000728.206825-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.48.150.69]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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

Update the DSDT golden master files for the x86/pc and x86/q35 platforms
to address recent changes in the architecture-agnostic CPU AML code,
which impacted the backward compatibility of the migration feature on
the x86 platform. Additionally, initialize CPU's presence statically
within the CPU AML to avoid the need for extending the ACPI ABI for
dynamic CPU presence checks.

The following is a diff of the changes in the .dsl file generated with IASL:

  * Disassembling to symbolic ASL+ operators
  *
- * Disassembly of tests/data/acpi/x86/pc/DSDT, Fri Nov  8 23:03:54 2024
+ * Disassembly of /tmp/aml-FONNW2, Fri Nov  8 23:03:54 2024
  *
  * Original Table Header:
  *     Signature        "DSDT"
- *     Length           0x00002171 (8561)
+ *     Length           0x00002150 (8528)
  *     Revision         0x01 **** 32-bit table (V1), no 64-bit math support
- *     Checksum         0xAA
+ *     Checksum         0xF6
  *     OEM ID           "BOCHS "
  *     OEM Table ID     "BXPC    "
  *     OEM Revision     0x00000001 (1)
@@ -1480,7 +1480,6 @@
                 CRMV,   1,
                 CEJ0,   1,
                 CEJF,   1,
-                CPRS,   1,
                 Offset (0x05),
                 CCMD,   8
             }
@@ -1515,16 +1514,9 @@
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
+                    Local0 |= 0x0F
                 }

                 Release (\_SB.PCI0.PRES.CPLK)

Reported-by: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20241106100047.18901c9d@imammedo.users.ipa.redhat.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 tests/data/acpi/x86/pc/DSDT                   | Bin 8561 -> 8528 bytes
 tests/data/acpi/x86/pc/DSDT.acpierst          | Bin 8472 -> 8439 bytes
 tests/data/acpi/x86/pc/DSDT.acpihmat          | Bin 9886 -> 9853 bytes
 tests/data/acpi/x86/pc/DSDT.bridge            | Bin 15432 -> 15399 bytes
 tests/data/acpi/x86/pc/DSDT.cphp              | Bin 9025 -> 8992 bytes
 tests/data/acpi/x86/pc/DSDT.dimmpxm           | Bin 10215 -> 10182 bytes
 tests/data/acpi/x86/pc/DSDT.hpbridge          | Bin 8512 -> 8479 bytes
 tests/data/acpi/x86/pc/DSDT.hpbrroot          | Bin 5068 -> 5035 bytes
 tests/data/acpi/x86/pc/DSDT.ipmikcs           | Bin 8633 -> 8600 bytes
 tests/data/acpi/x86/pc/DSDT.memhp             | Bin 9920 -> 9887 bytes
 tests/data/acpi/x86/pc/DSDT.nohpet            | Bin 8419 -> 8386 bytes
 tests/data/acpi/x86/pc/DSDT.numamem           | Bin 8567 -> 8534 bytes
 tests/data/acpi/x86/pc/DSDT.roothp            | Bin 12354 -> 12321 bytes
 tests/data/acpi/x86/q35/DSDT                  | Bin 8389 -> 8356 bytes
 tests/data/acpi/x86/q35/DSDT.acpierst         | Bin 8406 -> 8373 bytes
 tests/data/acpi/x86/q35/DSDT.acpihmat         | Bin 9714 -> 9681 bytes
 .../acpi/x86/q35/DSDT.acpihmat-noinitiator    | Bin 8668 -> 8635 bytes
 tests/data/acpi/x86/q35/DSDT.applesmc         | Bin 8435 -> 8402 bytes
 tests/data/acpi/x86/q35/DSDT.bridge           | Bin 12002 -> 11969 bytes
 tests/data/acpi/x86/q35/DSDT.core-count       | Bin 12947 -> 12914 bytes
 tests/data/acpi/x86/q35/DSDT.core-count2      | Bin 33804 -> 33771 bytes
 tests/data/acpi/x86/q35/DSDT.cphp             | Bin 8853 -> 8820 bytes
 tests/data/acpi/x86/q35/DSDT.cxl              | Bin 13182 -> 13149 bytes
 tests/data/acpi/x86/q35/DSDT.dimmpxm          | Bin 10043 -> 10010 bytes
 tests/data/acpi/x86/q35/DSDT.ipmibt           | Bin 8464 -> 8431 bytes
 tests/data/acpi/x86/q35/DSDT.ipmismbus        | Bin 8477 -> 8444 bytes
 tests/data/acpi/x86/q35/DSDT.ivrs             | Bin 8406 -> 8373 bytes
 tests/data/acpi/x86/q35/DSDT.memhp            | Bin 9748 -> 9715 bytes
 tests/data/acpi/x86/q35/DSDT.mmio64           | Bin 9519 -> 9486 bytes
 tests/data/acpi/x86/q35/DSDT.multi-bridge     | Bin 13242 -> 13209 bytes
 tests/data/acpi/x86/q35/DSDT.noacpihp         | Bin 8269 -> 8236 bytes
 tests/data/acpi/x86/q35/DSDT.nohpet           | Bin 8247 -> 8214 bytes
 tests/data/acpi/x86/q35/DSDT.numamem          | Bin 8395 -> 8362 bytes
 tests/data/acpi/x86/q35/DSDT.pvpanic-isa      | Bin 8490 -> 8457 bytes
 tests/data/acpi/x86/q35/DSDT.thread-count     | Bin 12947 -> 12914 bytes
 tests/data/acpi/x86/q35/DSDT.thread-count2    | Bin 33804 -> 33771 bytes
 tests/data/acpi/x86/q35/DSDT.tis.tpm12        | Bin 8995 -> 8962 bytes
 tests/data/acpi/x86/q35/DSDT.tis.tpm2         | Bin 9021 -> 8988 bytes
 tests/data/acpi/x86/q35/DSDT.type4-count      | Bin 18623 -> 18590 bytes
 tests/data/acpi/x86/q35/DSDT.viot             | Bin 14649 -> 14616 bytes
 tests/data/acpi/x86/q35/DSDT.xapic            | Bin 35752 -> 35719 bytes
 tests/qtest/bios-tables-test-allowed-diff.h   |  41 ------------------
 42 files changed, 41 deletions(-)

diff --git a/tests/data/acpi/x86/pc/DSDT b/tests/data/acpi/x86/pc/DSDT
index 46c8ffda011e71ce0a0ee707d320f13e9afd74f8..330c37242582c766fbb25cb75cd826df1675a319 100644
GIT binary patch
delta 99
zcmV-p0G$8vLeN4AL{mgmP$2*S0rs&9x(o?GKVMTqUt5Amlg$iX0VtC!4Ilyl1Cvt?
zC<0D1lYI>~21y1(Q&d5dKMpP(0AQdSlUy$ZUsFO~P(w*DP*O!xLr_Id0euP&V6z|&
FQ4^Mb8z2Ax

delta 125
zcmV-@0D}L}Lh(WhL{mgmaUlQz0jjYIx(o?HL0?lsUt5Arlg$iX0WFg(4Il?YP*PI?
z00NUv4JZOiHIsM^HUdQmldugnHaC-8F9csxLSIlrNia}SMN>miQd0q-8k1Zv1Yc7^
fUr<9yFi=uOQ$tWiP62QV4`87Ma0(5x{|!+S)S)9<

diff --git a/tests/data/acpi/x86/pc/DSDT.acpierst b/tests/data/acpi/x86/pc/DSDT.acpierst
index 8332df33f33ddaa4241752dcc2cf83ebd1cccd80..850a1ac380d0c2e0155aa23bcd2551912aebff60 100644
GIT binary patch
delta 99
zcmV-p0G$7rLia%mL{mgm_aFcO0Y9+{x(o?GKVMTqUt5Amlg$iX0VtC!4Ilyl1Cvt?
zC<0D1lYI>~21y1(Q&d5dKMpP(0AQdSlUy$ZUsFO~P(w*DP*O!xLr_Id0euP&V6z|&
F_!5C)8-f4;

delta 125
zcmV-@0D}MbL6|}cL{mgm7$E=v0rIg5x(o?HL0?lsUt5Arlg$iX0WFg(4Il?YP*PI?
z00NUv4JZOiHIsM^HUdQmldugnHaC-8F9csxLSIlrNia}SMN>miQd0q-8k1Zv1Yc7^
fUr<9yFi=uOQ$tWiP62QV4`87Ma0(5x{|)#Ow4Nip

diff --git a/tests/data/acpi/x86/pc/DSDT.acpihmat b/tests/data/acpi/x86/pc/DSDT.acpihmat
index bf093f6d8290a10a0823299238d5196d19b8e77d..09f486a880e6637c23c1467232e0c8ef9615bbf8 100644
GIT binary patch
delta 92
zcmV-i0Hgn&P5n#?L{mgmeI@_^0i>}Cx(o?VL|;=vUt5Amlg$iX0VtC!4Ilyl1Cvt?
yC<0A6lYI?A0!apwzzsDT8<Siw1Yc7^Ur<9yFi=uOQ$tWiP62%i4`8z^4s#gayBV4Q

delta 114
zcmV-&0FD3sOrA{&L{mgmo+bbQ0cWuax(o?GM_*GyUt5Arlg$iX0WFg(4Il?YP*PI?
z00NUv4JZOhJCk?~K>|exle-Ny7&nt#F9csxLSIlrNia}SMN>miQd0q-8k6x26$)?)
U4`87Ma0(4zlW`Cgvmg##7+5nO!~g&Q

diff --git a/tests/data/acpi/x86/pc/DSDT.bridge b/tests/data/acpi/x86/pc/DSDT.bridge
index c0bf671621348f698d2535cfd734dc05a9c7256a..af1957c0e4b12ae16692cb0093b404ca83239893 100644
GIT binary patch
delta 99
zcmV-p0G$8Gc&B&@L{mgmCp-WE0R*uMx(o?GKVMTqUt5Amlg$iX0VtC!4Ilyl1Cvt?
zC<0D1lYI>~21y1(Q&d5dKMpP(0AQdSlUy$ZUsFO~P(w*DP*O!xLr_Id0euP&V6z|&
FC@xBG8Y}<+

delta 125
zcmV-@0D}Lgc*uAPL{mgmNIU=l0l2XWx(o?HL0?lsUt5Arlg$iX0WFg(4Il?YP*PI?
z00NUv4JZOiHIsM^HUdQmldugnHaC-8F9csxLSIlrNia}SMN>miQd0q-8k1Zv1Yc7^
fUr<9yFi=uOQ$tWiP62QV4`87Ma0(5x{|zWE;58#=

diff --git a/tests/data/acpi/x86/pc/DSDT.cphp b/tests/data/acpi/x86/pc/DSDT.cphp
index e72a2df567d28b08b17051dd5612fb77abaf6e20..f3507e8b63a30951c70ff5b6e1aa2b6403d128d5 100644
GIT binary patch
delta 92
zcmV-i0HgoGMxaItL{mgmAR_<(0a~#Nx(o?GTwhZ{Ut5Amlg$iX0VtC!4Ilyl1Cvt?
yC<0DUlYI?x0!apw@eMT^8<Siw1Yc7^Ur<9yFi=uOQ$tWiP62%i4`8!g4&@Z5@fphi

delta 125
zcmV-@0D}LZM!`l3L{mgmK_dVF0S>VWx(o?HUSCr}Ut5Arlg$iX0WFg(4Il?YP*PI?
z00NUv4JZOiQj>TMasovNlk5#OHaC-8F9csxLSIlrNia}SMN>miQd0q-8k1Zv1Yc7^
fUr<9yFi=uOQ$tWiP62QV4`87Ma0(5xI}YU(f;%F-

diff --git a/tests/data/acpi/x86/pc/DSDT.dimmpxm b/tests/data/acpi/x86/pc/DSDT.dimmpxm
index 17a53d9ef714c973c934fdbd2021b2c03fa08a87..be083ea5ebe9557b2d042e97428396f8ac286508 100644
GIT binary patch
delta 97
zcmV-n0G|KnPsUFQL{mgm#wP#(0T;0f&I}1jP+wC*Ut5Amli>_r0VtC|4Ilyl1CwVB
zC;~@ClaUQs0!apw><u*=8<Siw1Yc7^Ur<9yFi=uOQ$tWiP62%i4`5)EAP^O^Z4P=F
De|{UK

delta 144
zcmV;B0B`@sPv=hxL{mgm=O+LF0n4!p&I}1kQeRU-Ut5Arli>_r0WFh24Il?YP*PI?
z00NU@4JZObN0W>VSqVi5LsL{i30otR0T2_DYYrGX0AQdulUy$ZUsFO~P(w*DP*O!x
yLr_vv0iYU_TrUJ)Q$k-*LrE}DQbkikP(@Awa0(A#p#^XX4PcZ14;8aa4tg2;)G1E@

diff --git a/tests/data/acpi/x86/pc/DSDT.hpbridge b/tests/data/acpi/x86/pc/DSDT.hpbridge
index 26f5a1875162459daaa285fef8b6c63678f7726a..13f776e0d60f46a6e645198e88a7eda0212b4542 100644
GIT binary patch
delta 99
zcmV-p0G$88LZ3nkL{mgmA0Yq$0V=Tyx(o?GKVMTqUt5Amlg$iX0VtC!4Ilyl1Cvt?
zC<0D1lYI>~21y1(Q&d5dKMpP(0AQdSlUy$ZUsFO~P(w*DP*O!xLr_Id0euP&V6z|&
FAQKy-8IS+~

delta 125
zcmV-@0D}LYLcl@_L{mgmKp_AC0p76+x(o?HL0?lsUt5Arlg$iX0WFg(4Il?YP*PI?
z00NUv4JZOiHIsM^HUdQmldugnHaC-8F9csxLSIlrNia}SMN>miQd0q-8k1Zv1Yc7^
fUr<9yFi=uOQ$tWiP62QV4`87Ma0(5x{|z7$r5_^7

diff --git a/tests/data/acpi/x86/pc/DSDT.hpbrroot b/tests/data/acpi/x86/pc/DSDT.hpbrroot
index e0c7c2a56d5d8afb5f78134c9b175d6153dca776..0bc4bbbdfcf8ed7a8c8c7d1ddfcf7edfd2d9a606 100644
GIT binary patch
delta 104
zcmV-u0GI#FC#xq4L{mgms}leK0UEIiZ3_uNKVMTqUt5AmlYk3e0VtE-3m^gj1Cs^}
zC<0D1lQ0Z62T2A)Q&d3-lTi&9lg|zo9ROgU8<Siw1Yc7^Ur<9yFi=uOQ$tWiP62%i
K4`8#?4EYA6ksM$E

delta 132
zcmV-~0DJ$dC(I`bL{mgm%o6|r0nV`sZ3_uOL0?lsUt5ArlYk3e0WFi?3m^wWP*PI?
z00NT%3@8FhHIpk0HU>oqLsL{ilhF(=IRIdwH<Mg11Yc7^Ur<9yFi=uOQ$tWvQvskF
mlUy$ZUsFO~P(w*DP*O!xLr_Id0dNWrV4($Y3JtTe4EYA9&?Q^|

diff --git a/tests/data/acpi/x86/pc/DSDT.ipmikcs b/tests/data/acpi/x86/pc/DSDT.ipmikcs
index 119bd256adfb443922cf988e4f4ac3278a1d55ba..717c10930385122e8c4347d335374e4b5697e385 100644
GIT binary patch
delta 99
zcmV-p0G$81LzqJfL{mgmm>~cF0dlblx(o?GKVMTqUt5Amlg$iX0VtC!4Ilyl1Cvt?
zC<0D1lYI>~21y1(Q&d5dKMpP(0AQdSlUy$ZUsFO~P(w*DP*O!xLr_Id0euP&V6z|&
FnG;%V8omGk

delta 125
zcmV-@0D}LRL%Bl=L{mgmxgh`m0Vc5ux(o?HL0?lsUt5Arlg$iX0WFg(4Il?YP*PI?
z00NUv4JZOiHIsM^HUdQmldugnHaC-8F9csxLSIlrNia}SMN>miQd0q-8k1Zv1Yc7^
fUr<9yFi=uOQ$tWiP62QV4`87Ma0(5x{|%WFhf5;(

diff --git a/tests/data/acpi/x86/pc/DSDT.memhp b/tests/data/acpi/x86/pc/DSDT.memhp
index 9ca8a6e2f7898ccd304de44a34bd318a209917e9..a72efd5d8f858046cff0b80320d880dfb3014af8 100644
GIT binary patch
delta 99
zcmV-p0G$88O`lB)L{mgmpC$kR0okz%x(o?MKVMTqUt5Amlg$iX0VtC!4Ilyl1Cvt?
zC;~(@lYI>~21y1(Q&d5dKMpP(0AQdSlUy$ZUsFO~P(w*DP*O!xLr_Id0euP&V6z|&
FpcswY8(aVY

delta 125
zcmV-@0D}LYO~6eGL{mgmz$O3y0gbT=x(o?NL0?lsUt5Arlg$iX0WFg(4Il?YP*PI?
z00NUv4JZOYHj{V_HUdQmldugnHaC-8F9csxLSIlrNia}SMN>miQd0q-8k1Zv1Yc7^
fUr<9yFi=uOQ$tWiP62QV4`87Ma0(5x{|%rR$+{z!

diff --git a/tests/data/acpi/x86/pc/DSDT.nohpet b/tests/data/acpi/x86/pc/DSDT.nohpet
index 6127a2c9ac43e961e7e8ca01673117382c20bedb..ae7d4a1d025cf410233caa81c301f45cf4c62166 100644
GIT binary patch
delta 99
zcmV-p0G$8hLBc@_L{mgm!XN+u0l={eEDQ-iKVMTqUt5AmlRpez0VtE63?Kpk1CzxJ
zC<0D1lkW^R21y1(Q&d5du?;RA0AQdSlUy$ZUsFO~P(w*DP*O!xLr_Id0euP&V6&19
FQ4^`h9994T

delta 132
zcmV-~0DJ$!LE}LRL{mgm;~)S40d%nnEDQ-jL0?lsUt5ArlRpez0WFiB3?K(XP*PI?
z00NW13@8FhHIwQLHU>oqLsL{ilaLKAIRIdwH<Mg11Yc7^Ur<9yFi=uOQ$tWvQvskF
mlUy$ZUsFO~P(w*DP*O!xLr_Id0dNWrV4($Y3JtSy4N()=oFyv&

diff --git a/tests/data/acpi/x86/pc/DSDT.numamem b/tests/data/acpi/x86/pc/DSDT.numamem
index 18c815efa890503f5e0ca94665239f58fe283735..ca4c630447f5be2b39b4648fb0397dcdf06cd8df 100644
GIT binary patch
delta 99
zcmV-p0G$8#Le@eGL{mgmRv`cY0g<r^x(o?MKVMTqUt5Amlg$iX0VtC!4Ilyl1Cvt?
zC;~(@lYI>~21y1(Q&d5dKMpP(0AQdSlUy$ZUsFO~P(w*DP*O!xLr_Id0euP&V6z|&
FR}*`?8qfd$

delta 125
zcmV-@0D}M4Lia)nL{mgmcOd`(0Y$M2x(o?NL0?lsUt5Arlg$iX0WFg(4Il?YP*PI?
z00NUv4JZOYHj{V_HUdQmldugnHaC-8F9csxLSIlrNia}SMN>miQd0q-8k1Zv1Yc7^
fUr<9yFi=uOQ$tWiP62QV4`87Ma0(5x{|#3Yu}&ij

diff --git a/tests/data/acpi/x86/pc/DSDT.roothp b/tests/data/acpi/x86/pc/DSDT.roothp
index 8256503220c11cbb902c6967fccba87e711bcd5a..9ff5a97046ba8b03686b75e48b90ed04dadcbe3c 100644
GIT binary patch
delta 99
zcmV-p0G$8AV4+|NL{mgmAus>{0fMm#x(o?GKVMTqUt5Amlg$iX0VtC!4Ilyl1Cvt?
zC<0D1lYI>~21y1(Q&d5dKMpP(0AQdSlUy$ZUsFO~P(w*DP*O!xLr_Id0euP&V6z|&
FA|h8E8cF~F

delta 125
zcmV-@0D}LaV8UPuL{mgmLNEXT0XDG;x(o?HL0?lsUt5Arlg$iX0WFg(4Il?YP*PI?
z00NUv4JZOiHIsM^HUdQmldugnHaC-8F9csxLSIlrNia}SMN>miQd0q-8k1Zv1Yc7^
fUr<9yFi=uOQ$tWiP62QV4`87Ma0(5x{|zD{g2N(&

diff --git a/tests/data/acpi/x86/q35/DSDT b/tests/data/acpi/x86/q35/DSDT
index b0bbff7686c9a56129bfa3408e62f142cc482713..eea903a3d69d03b4ce0d205d2a1bb9ff5bc80409 100644
GIT binary patch
delta 83
zcmV-Z0IdJTL8L(nL{mgmq#ytQ0o1Vy2N?-KKVMTqUt5AmlNuRb0VtDs86W}x1CyW`
pC<0D1lgb%321y1(Q&d5dj2bQk0AQdSlTR8I1bqq*V6$x+SO(Ap7JL8z

delta 125
zcmV-@0D}LdLB&A|L{mgm#UKCx0f?~*2N?-LL0?lsUt5ArlNuRb0WFhx86XEkP*PI?
z00NVn87KluHIu~|HUdQmll>VrHaC-8F9csxLSIlrNia}SMN>miQd0q-8k1Zv1Yc7^
fUr<9yFi=uOQ$tWiP62QV4`87Ma0(5xOd41Qp-m#4

diff --git a/tests/data/acpi/x86/q35/DSDT.acpierst b/tests/data/acpi/x86/q35/DSDT.acpierst
index f91cbe55fcfeea319babf7c9a0c6a6ccdc3320d1..352876acc29d55469a37e7322d50807df28411b7 100644
GIT binary patch
delta 83
zcmV-Z0IdJkLA5~&L{mgmwIBch0d%nn2N?-KKVMTqUt5AmlNuRb0VtDs86W}x1CyW`
pC<0D1lgb%321y1(Q&d5dj2bQk0AQdSlTR8I1bqq*V6$x+X$Hm=7GMAX

delta 125
zcmV-@0D}LuLDoSEL{mgm)*t`?0VuHw2N?-LL0?lsUt5ArlNuRb0WFhx86XEkP*PI?
z00NVn87KluHIu~|HUdQmll>VrHaC-8F9csxLSIlrNia}SMN>miQd0q-8k1Zv1Yc7^
fUr<9yFi=uOQ$tWiP62QV4`87Ma0(5xOd4qhkNYBl

diff --git a/tests/data/acpi/x86/q35/DSDT.acpihmat b/tests/data/acpi/x86/q35/DSDT.acpihmat
index 0949fb9d67c70dc882e50501ece421114ad8080b..4e28f56048dcdf161bc3468d500943b3d2ac5bde 100644
GIT binary patch
delta 97
zcmV-n0G|KyOVLXTL{mgm(Io%?0fMm#2N?-ZL|;=vUt5AmlNuRb0VtDs86W}x1CyW`
zC<0A6lgb%E0!apw4H`8Y8<Siw1Yc7^Ur<9yFi=uOQ$tWiP62%i4`5)EK^zscjv8bO
DMFJYa

delta 130
zcmV-|0Db?_OY%z!L{mgm@+ANO0Y$M22N?-KM_*GyUt5ArlNuRb0WFhx86XEkP*PI?
z00NVn87KltJCns3K>|exlL#6$H#d`9F9csxLSIlrNia}SMN>miQd0q-8k1Zv1Yc7^
kUr<9yFi=uOQ$tWiP62QV4`87Ma0(4zlOP-wvuzq=3rV&kk^lez

diff --git a/tests/data/acpi/x86/q35/DSDT.acpihmat-noinitiator b/tests/data/acpi/x86/q35/DSDT.acpihmat-noinitiator
index 0fa4daa35cf95f93ba8c15f478460fe4e14e6d9e..0641e4973d5d38ff5fce3416003bd4b11f75443e 100644
GIT binary patch
delta 99
zcmV-p0G$8aL%Tx?L{mgmyCDDo0ZXw82N?-RP+wC*Ut5AmlNuRb0VtDs86W}x1CyW`
zC;~-Algb%c21y1(Q&d5duNp2L0AQdSlUy$ZUsFO~P(w*DP*O!xLr_Id0euP&V6%`K
FOb2iD8=?RJ

delta 125
zcmV-@0D}L!L)=3OL{mgm+#vt}0spZI2N?-SQeRU-Ut5ArlNuRb0WFhx86XEkP*PI?
z00NVn87KllN0Y@FSpr1}lOP&3HaC-8F9csxLSIlrNia}SMN>miQd0q-8k1Zv1Yc7^
fUr<9yFi=uOQ$tWiP62QV4`87Ma0(5xZyHPo*V`iA

diff --git a/tests/data/acpi/x86/q35/DSDT.applesmc b/tests/data/acpi/x86/q35/DSDT.applesmc
index a5d032b7d96113c9393036b2ba831adb6d584142..9481b249904ae522df2eb0eb41b4eb0c73a76997 100644
GIT binary patch
delta 83
zcmV-Z0IdJ>LDE4AL{mgm(jWi;0mQKi2N?-KKVMTqUt5AmlNuRb0VtDs86W}x1CyW`
pC<0D1lgb%321y1(Q&d5dj2bQk0AQdSlTR8I1bqq*V6$x+h6eW37bE}x

delta 125
zcmV-@0D}M0LGwWhL{mgm^B@2K0eG<r2N?-LL0?lsUt5ArlNuRb0WFhx86XEkP*PI?
z00NVn87KluHIu~|HUdQmll>VrHaC-8F9csxLSIlrNia}SMN>miQd0q-8k1Zv1Yc7^
fUr<9yFi=uOQ$tWiP62QV4`87Ma0(5xOd5s;+#w@H

diff --git a/tests/data/acpi/x86/q35/DSDT.bridge b/tests/data/acpi/x86/q35/DSDT.bridge
index 3464f552974672bde25eb15f1c93c309c57ef5cb..0333d99920f40258e7733b423f82457303c04065 100644
GIT binary patch
delta 83
zcmV-Z0IdJwUBO)nL{mgm!7cy*0r0U32N?-KKVMTqUt5AmlNuRb0VtDs86W}x1CyW`
pC<0D1lgb%321y1(Q&d5dj2bQk0AQdSlTR8I1bqq*V6$x+brcAb7hnJY

delta 125
zcmV-@0D}L)UE*B|L{mgm;w}IH0i>}C2N?-LL0?lsUt5ArlNuRb0WFhx86XEkP*PI?
z00NVn87KluHIu~|HUdQmll>VrHaC-8F9csxLSIlrNia}SMN>miQd0q-8k1Zv1Yc7^
fUr<9yFi=uOQ$tWiP62QV4`87Ma0(5xOd53*_$MQQ

diff --git a/tests/data/acpi/x86/q35/DSDT.core-count b/tests/data/acpi/x86/q35/DSDT.core-count
index 08f5d5f54bcb61235b98fc85bb814046dd038c13..d65f1600252216d00815ed31b6af47ed44256f8b 100644
GIT binary patch
delta 94
zcmV-k0HObrW%6VSL{mgmaxwq_0X?w_2N?>ETLE8FLSI{gNRt~GUI8eRdKn-B00Wbu
z87KmaP_xS!vjPH129tmsH5wa}TrUJ)Q$k-*LrE}DQbkikP(@AweF_g?v+EqF74~);
AApigX

delta 116
zcmV-)0E_?fWRqnIL{mgmlQIAR0r9a42N?>FT>)QHLSI{gO_LiLUI8tWdKn-GLr_vv
z0RRG%oEazrhf=e~8M6WcMF^9795om>lUy$ZUsFO~P(w*DP*O!xLr_vv0iYU_u^bf&
Wa0(A#p#^XX4PcWo9~HCU9Fi5&@geB|

diff --git a/tests/data/acpi/x86/q35/DSDT.core-count2 b/tests/data/acpi/x86/q35/DSDT.core-count2
index d29a7108f82110ce9f9b4e006501215d41c5420a..345a6f47eb9330498f69d312c980e1147ad0ed42 100644
GIT binary patch
delta 101
zcmV-r0Gj`dhyv?}0t!S^L{#g80004xu?hzn3WswBUsFO~TY^ZF8yQ{!D3f{_AOZjb
zlc5<X0)%L@%Nbt`0!apwEG9J@8<Siw1Yc7^Ur<9yFi=uOQ$tWiP62%i4`5)EVJH=|
HttMYx>zy5G

delta 142
zcmV;90CE58hXRa<0t!S^L{tof0003(u?hzn3W#+EUsFO~TY^oK8yQ{!Et7f~AO}NG
zQd0o{0+XB>C<1_Lv&I=;3<pIBLsL{i36otYEjj>Tpf{6TF9csxLSIlrNia}SMN>mi
wQd0q-8k1Zv1Yc7^Ur<9yFi=uOQ$tWiP62QV4`87Ma0(4zlRzjHvy3KRUGW?zr2qf`

diff --git a/tests/data/acpi/x86/q35/DSDT.cphp b/tests/data/acpi/x86/q35/DSDT.cphp
index 7fd59bf6702c04a622f05ae356a2ea37312ab403..e31b0e38d0b53bad9e2eb92cdaf1f7e95bf37538 100644
GIT binary patch
delta 97
zcmV-n0G|JqMf5}pL{mgmbRqx%0XVS=2N?-KTwhZ{Ut5AmlNuRb0VtDs86W}x1CyW`
zC<0DUlgb%#0!apwJ{mO}8<Siw1Yc7^Ur<9yFi=uOQ$tWiP62%i4`5)E5FHh>zZ%vD
D2$LGa

delta 128
zcmV-`0Du4VM3qGfL{mgml_CHD0qn5~2N?-LUSCr}Ut5ArlNuRb0WFhx86XEkP*PI?
z00NVn87KluQj^6QatTEULsL{i30otR@f;JAy&4!B0AQdulUy$ZUsFO~P(w*DP*O!x
iLr_vv0iYU_ZyFT}a0(A#p#^XX4PcW|92K*k8rBC;J0%1F

diff --git a/tests/data/acpi/x86/q35/DSDT.cxl b/tests/data/acpi/x86/q35/DSDT.cxl
index 92769c630dc362c781c4e9a83d6f8be306121c5a..33eaaf264614645c0cf21ac2780657b8dc91a357 100644
GIT binary patch
delta 83
zcmV-Z0IdK1X5D5AL{mgmT{8dx0qC&`2N?-KKVMTqUt5AmlNuRb0VtDs86W}x1CyW`
pC<0D1lgb%321y1(Q&d5dj2bQk0AQdSlTR8I1bqq*V6$x+5g7r`7UTc`

delta 125
zcmV-@0D}MBX8vXhL{mgmelq|70i3Z42N?-LL0?lsUt5ArlNuRb0WFhx86XEkP*PI?
z00NVn87KluHIu~|HUdQmll>VrHaC-8F9csxLSIlrNia}SMN>miQd0q-8k1Zv1Yc7^
fUr<9yFi=uOQ$tWiP62QV4`87Ma0(5xOd1gx?4ctC

diff --git a/tests/data/acpi/x86/q35/DSDT.dimmpxm b/tests/data/acpi/x86/q35/DSDT.dimmpxm
index 1db0bf454a203006f866e6752d06422ae675cbd3..02f7ce30fe8f4564046c39884aec3a0c5ce1e78b 100644
GIT binary patch
delta 92
zcmV-i0HgoAPMS^%L{mgm8Ych%0ras78yN{nP+wC*Ut5AmlP(!v0VtD=86W}x1Cz8F
yC;~@ClinFw0!apwIT|$@8<Siw1Yc7^Ur<9yFi=uOQ$tWiP62%i4`8#T8kY>IB^j>(

delta 134
zcmV;10D1qKPP<MDL{mgmJ0}1D0jRMG8yN{oQeRU-Ut5ArlP(!v0WFh_86XEkP*PI?
z00NV*87KlnN0ZqZSqDW3LsL{i36lXE7n4vL88$bQTrUJ)Q$k-*LrE}DQbkikP*PI?
opc<20F9csxLSIlrNia}SMN>miMNR>53J+kR1#k)tvx6F!44`%-p8x;=

diff --git a/tests/data/acpi/x86/q35/DSDT.ipmibt b/tests/data/acpi/x86/q35/DSDT.ipmibt
index 25f43ae8efb55364a739e6b5e3cb4e71e61862b0..5405acbb56542be6842296aa66ecca4aed3b721c 100644
GIT binary patch
delta 83
zcmV-Z0IdIzLhnHeL{mgm?;rpG0SK`Q2N?-KKVMTqUt5AmlNuRb0VtDs86W}x1CyW`
pC<0D1lgb%321y1(Q&d5dj2bQk0AQdSlTR8I1bqq*V6$x+qXxDr7F_@U

delta 125
zcmV-@0D}MTL6AZUL{mgm5Fr2n0lTpZ2N?-LL0?lsUt5ArlNuRb0WFhx86XEkP*PI?
z00NVn87KluHIu~|HUdQmll>VrHaC-8F9csxLSIlrNia}SMN>miQd0q-8k1Zv1Yc7^
fUr<9yFi=uOQ$tWiP62QV4`87Ma0(5xOd6vGauFha

diff --git a/tests/data/acpi/x86/q35/DSDT.ipmismbus b/tests/data/acpi/x86/q35/DSDT.ipmismbus
index 32bcd25bda9e9d2775790385f8da6a11e9d5cb46..3b34a1909040bc0ab986e27461b5e1dfe913f700 100644
GIT binary patch
delta 83
zcmV-Z0IdI=Li|ArL{mgm{2%}T0eP_s2N?-KKVMTqUt5AmlNuRb0VtDs86W}x1CyW`
pC<0D1lgb%321y1(Q&d5dj2bQk0AQdSlTR8I1bqq*V6$x+um<4I7XknP

delta 125
zcmV-@0D}MgL7hShL{mgm9U%Y!0W7f!2N?-LL0?lsUt5ArlNuRb0WFhx86XEkP*PI?
z00NVn87KluHIu~|HUdQmll>VrHaC-8F9csxLSIlrNia}SMN>miQd0q-8k1Zv1Yc7^
fUr<9yFi=uOQ$tWiP62QV4`87Ma0(5xOd7BTMy4Vo

diff --git a/tests/data/acpi/x86/q35/DSDT.ivrs b/tests/data/acpi/x86/q35/DSDT.ivrs
index f91cbe55fcfeea319babf7c9a0c6a6ccdc3320d1..352876acc29d55469a37e7322d50807df28411b7 100644
GIT binary patch
delta 83
zcmV-Z0IdJkLA5~&L{mgmwIBch0d%nn2N?-KKVMTqUt5AmlNuRb0VtDs86W}x1CyW`
pC<0D1lgb%321y1(Q&d5dj2bQk0AQdSlTR8I1bqq*V6$x+X$Hm=7GMAX

delta 125
zcmV-@0D}LuLDoSEL{mgm)*t`?0VuHw2N?-LL0?lsUt5ArlNuRb0WFhx86XEkP*PI?
z00NVn87KluHIu~|HUdQmll>VrHaC-8F9csxLSIlrNia}SMN>miQd0q-8k1Zv1Yc7^
fUr<9yFi=uOQ$tWiP62QV4`87Ma0(5xOd4qhkNYBl

diff --git a/tests/data/acpi/x86/q35/DSDT.memhp b/tests/data/acpi/x86/q35/DSDT.memhp
index be90eb71d8dda8fe54c79ffffe103986ee06ae3a..2978ecc86ad9e1fb745618f01a9ec4cdb809de28 100644
GIT binary patch
delta 83
zcmV-Z0IdI%O!G?$L{mgm^CbWP0k^RV2N?-QKVMTqUt5AmlNuRb0VtDs86W}x1CyW`
pC;~(@lgb%321y1(Q&d5dj2bQk0AQdSlTR8I1bqq*V6$x+rwj2A7dHR^

delta 125
zcmV-@0D}MXOO#9sL{mgm6ea)w0cx=d2N?-RL0?lsUt5ArlNuRb0WFhx86XEkP*PI?
z00NVn87KlkHj~8}HUdQmll>VrHaC-8F9csxLSIlrNia}SMN>miQd0q-8k1Zv1Yc7^
fUr<9yFi=uOQ$tWiP62QV4`87Ma0(5xOd6*PU~VE<

diff --git a/tests/data/acpi/x86/q35/DSDT.mmio64 b/tests/data/acpi/x86/q35/DSDT.mmio64
index 01f276a6aff38a1d4f58640a9e6d120fc9a04b61..c81653972d5ca73c06f1af056d3e4a1c40fc4b78 100644
GIT binary patch
delta 83
zcmV-Z0IdJ7N{&hjL{mgm4kZ8p0e7(q2N?-QKVMTqUt5AmlNuRb0VtDs86W}x1CyW`
pC;~(@lgb%321y1(Q&d5dj2bQk0AQdSlTR8I1bqq*V6$x+!U~0}72f~=

delta 125
zcmV-@0D}LHO0P-^L{mgmFC_o~0V}Zz2N?-RL0?lsUt5ArlNuRb0WFhx86XEkP*PI?
z00NVn87KlkHj~8}HUdQmll>VrHaC-8F9csxLSIlrNia}SMN>miQd0q-8k1Zv1Yc7^
fUr<9yFi=uOQ$tWiP62QV4`87Ma0(5xOd7%pD^nr>

diff --git a/tests/data/acpi/x86/q35/DSDT.multi-bridge b/tests/data/acpi/x86/q35/DSDT.multi-bridge
index 1bd2ee8d2ebd3c9e0ed89a86478691f2e06f2590..f22f49a9baef29ff2dd49ad0db3fa4d7ec76c8a3 100644
GIT binary patch
delta 83
zcmV-Z0IdJIXPIXTL{mgmnKJ+Y0qL;{2N?-KKVMTqUt5AmlNuRb0VtDs86W}x1CyW`
pC<0D1lgb%321y1(Q&d5dj2bQk0AQdSlTR8I1bqq*V6$x+O&RFt7S{j(

delta 125
zcmV-@0D}LSXS!z!L{mgmx-$R(0iCf52N?-LL0?lsUt5ArlNuRb0WFhx86XEkP*PI?
z00NVn87KluHIu~|HUdQmll>VrHaC-8F9csxLSIlrNia}SMN>miQd0q-8k1Zv1Yc7^
fUr<9yFi=uOQ$tWiP62QV4`87Ma0(5xOd3rY$Ic@7

diff --git a/tests/data/acpi/x86/q35/DSDT.noacpihp b/tests/data/acpi/x86/q35/DSDT.noacpihp
index 45cc2bcffa42d73db110afd5075556dcfe5d9936..e506092a554df06d5d384be14ee831603d07516f 100644
GIT binary patch
delta 99
zcmV-p0G$8LK&(ItL{mgmEFb^?0cWuax)%vRKVMTqUt5Amlg$@i0VtC!7$5=w1Cvu2
zC<0D1lYJOA21y1(Q&d5dKN&6^0AQdSlUy$ZUsFO~P(w*DP*O!xLr_Id0euP&V6z|@
FEeA`{8a)62

delta 125
zcmV-@0D}LlK+Ql3L{mgmO&|aO0UNOjx)%vSL0?lsUt5Arlg$@i0WFg(7$65jP*PI?
z00NUv7$^ctHIsN4HUdQmldu>yHaC-8F9csxLSIlrNia}SMN>miQd0q-8k1Zv1Yc7^
fUr<9yFi=uOQ$tWiP62QV4`87Ma0(5x{}?R?b}k}!

diff --git a/tests/data/acpi/x86/q35/DSDT.nohpet b/tests/data/acpi/x86/q35/DSDT.nohpet
index f110504b9c813aa07802fc17d2869596a2eeca6f..1215e1c682b00fe739bb9d46d7967b93d442c13a 100644
GIT binary patch
delta 83
zcmV-Z0IdJFK$buXL{mgm79aos0iCf5c^C;mKVMTqUt5AmlZ+T%0VtE}7$5=w1CtUN
pC<0D1lROzV21y1(Q&d5d{uwR=0AQdSlffAk1bqq*V6)#DSO&n57b5@w

delta 125
zcmV-@0D}LPK({~&L{mgmHy{820a39Ec^C;nL0?lsUt5ArlZ+T%0WFj37$65jP*PI?
z00NT@87KluHIp|PHUdQmlW!R{HaC-8F9csxLSIlrNia}SMN>miQd0q-8k1Zv1Yc7^
fUr<9yFi=uOQ$tWiP62QV4`87Ma0(5xz8P2sNX8-5

diff --git a/tests/data/acpi/x86/q35/DSDT.numamem b/tests/data/acpi/x86/q35/DSDT.numamem
index 6090958f39875f5806e72e23f32cb4b3ae840627..2ae96986366a2ec3cd30f329484dfaad0cde1ef1 100644
GIT binary patch
delta 83
zcmV-Z0IdJZL8?ItL{mgmsvrOW0dKJi2N?-QKVMTqUt5AmlNuRb0VtDs86W}x1CyW`
pC;~(@lgb%321y1(Q&d5dj2bQk0AQdSlTR8I1bqq*V6$x+UIx0L7Ayb&

delta 125
zcmV-@0D}LjLCZl3L{mgm%OC&%0VA;r2N?-RL0?lsUt5ArlNuRb0WFhx86XEkP*PI?
z00NVn87KlkHj~8}HUdQmll>VrHaC-8F9csxLSIlrNia}SMN>miQd0q-8k1Zv1Yc7^
fUr<9yFi=uOQ$tWiP62QV4`87Ma0(5xOd4JWeflCz

diff --git a/tests/data/acpi/x86/q35/DSDT.pvpanic-isa b/tests/data/acpi/x86/q35/DSDT.pvpanic-isa
index 7a8e568315a43f1fa98068d8e78995c98064fb91..08032ce5d117bbf233242dba9be3911a54092689 100644
GIT binary patch
delta 83
zcmV-Z0IdJ2LWx2OL{mgm2_XOg0fw;(2N?-KKVMTqUt5AmlNuRb0VtDs86W}x1CyW`
pC<0D1lgb%321y1(Q&d5dj2bQk0AQdSlTR8I1bqq*V6$x+y#{`n6~zDm

delta 125
zcmV-@0D}LCLaIUvL{mgmDj@&>0Xne?2N?-LL0?lsUt5ArlNuRb0WFhx86XEkP*PI?
z00NVn87KluHIu~|HUdQmll>VrHaC-8F9csxLSIlrNia}SMN>miQd0q-8k1Zv1Yc7^
fUr<9yFi=uOQ$tWiP62QV4`87Ma0(5xOd7ogAxa_U

diff --git a/tests/data/acpi/x86/q35/DSDT.thread-count b/tests/data/acpi/x86/q35/DSDT.thread-count
index 08f5d5f54bcb61235b98fc85bb814046dd038c13..d65f1600252216d00815ed31b6af47ed44256f8b 100644
GIT binary patch
delta 94
zcmV-k0HObrW%6VSL{mgmaxwq_0X?w_2N?>ETLE8FLSI{gNRt~GUI8eRdKn-B00Wbu
z87KmaP_xS!vjPH129tmsH5wa}TrUJ)Q$k-*LrE}DQbkikP(@AweF_g?v+EqF74~);
AApigX

delta 116
zcmV-)0E_?fWRqnIL{mgmlQIAR0r9a42N?>FT>)QHLSI{gO_LiLUI8tWdKn-GLr_vv
z0RRG%oEazrhf=e~8M6WcMF^9795om>lUy$ZUsFO~P(w*DP*O!xLr_vv0iYU_u^bf&
Wa0(A#p#^XX4PcWo9~HCU9Fi5&@geB|

diff --git a/tests/data/acpi/x86/q35/DSDT.thread-count2 b/tests/data/acpi/x86/q35/DSDT.thread-count2
index d29a7108f82110ce9f9b4e006501215d41c5420a..345a6f47eb9330498f69d312c980e1147ad0ed42 100644
GIT binary patch
delta 101
zcmV-r0Gj`dhyv?}0t!S^L{#g80004xu?hzn3WswBUsFO~TY^ZF8yQ{!D3f{_AOZjb
zlc5<X0)%L@%Nbt`0!apwEG9J@8<Siw1Yc7^Ur<9yFi=uOQ$tWiP62%i4`5)EVJH=|
HttMYx>zy5G

delta 142
zcmV;90CE58hXRa<0t!S^L{tof0003(u?hzn3W#+EUsFO~TY^oK8yQ{!Et7f~AO}NG
zQd0o{0+XB>C<1_Lv&I=;3<pIBLsL{i36otYEjj>Tpf{6TF9csxLSIlrNia}SMN>mi
wQd0q-8k1Zv1Yc7^Ur<9yFi=uOQ$tWiP62QV4`87Ma0(4zlRzjHvy3KRUGW?zr2qf`

diff --git a/tests/data/acpi/x86/q35/DSDT.tis.tpm12 b/tests/data/acpi/x86/q35/DSDT.tis.tpm12
index 29a416f0508655d2bfde01fff4d25ad7f89581d9..3d3c3d88619e15ae944261df473aa247a1b8f72f 100644
GIT binary patch
delta 83
zcmV-Z0IdI`MuJ8PL{mgm0wVwb0R*uM2N?-KKVMTqUt5AmlNuRb0VtDs86W}x1CyW`
pC<0D1lgb%321y1(Q&d5dj2bQk0AQdSlTR8I1bqq*V6$x+wg^}o6*B+;

delta 125
zcmV-@0D}L5Mx#awL{mgmBO?F+0l2XW2N?-LL0?lsUt5ArlNuRb0WFhx86XEkP*PI?
z00NVn87KluHIu~|HUdQmll>VrHaC-8F9csxLSIlrNia}SMN>miQd0q-8k1Zv1Yc7^
fUr<9yFi=uOQ$tWiP62QV4`87Ma0(5xOd7TbQmP_U

diff --git a/tests/data/acpi/x86/q35/DSDT.tis.tpm2 b/tests/data/acpi/x86/q35/DSDT.tis.tpm2
index 59288f02c43cf2efc1555599131fde05dbbaa1cd..f3d0175fec6e53a41f78065498ba1bbf63ddc80a 100644
GIT binary patch
delta 83
zcmV-Z0IdJLMw~_pL{mgm93ub#0lu*c2N?-KKVMTqUt5AmlNuRb0VtDs86W}x1CyW`
pC<0D1lgb%321y1(Q&d5dj2bQk0AQdSlTR8I1bqq*V6$x+&<LWP7F7TM

delta 125
zcmV-@0D}LVM!iM~L{mgmJtF`B0dlbl2N?-LL0?lsUt5ArlNuRb0WFhx86XEkP*PI?
z00NVn87KluHIu~|HUdQmll>VrHaC-8F9csxLSIlrNia}SMN>miQd0q-8k1Zv1Yc7^
fUr<9yFi=uOQ$tWiP62QV4`87Ma0(5xOd8M#S$raP

diff --git a/tests/data/acpi/x86/q35/DSDT.type4-count b/tests/data/acpi/x86/q35/DSDT.type4-count
index eaca76e8e61eb62f75dbdf093e803eea34330deb..30630c2befcb909205694d0dae19a8ca304cc047 100644
GIT binary patch
delta 107
zcmV-x0F?i~kpZ5O0SZJ@L{y$g0004Lu?hzn3W~l0UsFO~TY^ZF8yQ{!D3f{_AOZjb
zlc5<X0*AA+%NffB2T2A)Q&d3-lYt-?k|Guz0AQdSlUy$ZUsFO~P(w*DP*O!xLr_Id
N0euP&V6y`tyeOMm9?Sp$

delta 136
zcmV;30C)eMkpaJv0SZJ@L{z^>0003Uu?hzn3X8x3UsFO~TY^oK8yQ{!Et7f~AO}NG
zQd0o{0+XB>C<24Ev&I?A1qMY3LsL{ilK~(uIRIdwH<Mg11Yc7^Ur<9yFi=uOQ$tWv
qQvskFlUy$ZUsFO~P(w*DP*O!xLr_Id0dNWrV4($Y3JtU3AG|1iaVLZT

diff --git a/tests/data/acpi/x86/q35/DSDT.viot b/tests/data/acpi/x86/q35/DSDT.viot
index 71379a48ddebf7e1f5e853fcbbb6befd561cb8e4..ec4e3201ca754393735896c66704d6c9246ea650 100644
GIT binary patch
delta 83
zcmV-Z0IdJHa+q=oL{mgm7&!m{0d}zp2N?-KKVMTqUt5AmlNuRb0VtDs86W}x1CyW`
pC<0D1lgb%321y1(Q&d5dj2bQk0AQdSlTR8I1bqq*V6$x+%pR?&7J&c&

delta 125
zcmV-@0D}LRa=CH}L{mgmIXM6T0V=Ty2N?-LL0?lsUt5ArlNuRb0WFhx86XEkP*PI?
z00NVn87KluHIu~|HUdQmll>VrHaC-8F9csxLSIlrNia}SMN>miQd0q-8k1Zv1Yc7^
fUr<9yFi=uOQ$tWiP62QV4`87Ma0(5xOd8A{Xv`v_

diff --git a/tests/data/acpi/x86/q35/DSDT.xapic b/tests/data/acpi/x86/q35/DSDT.xapic
index 9059812b5892ba7ac5c9bd312fd9f45a4f59f105..da4c47ab5a15b4d7818209317d6e7680f014b099 100644
GIT binary patch
delta 108
zcmV-y0F(cymjZ{E0t!S^L{x{10004su?hzn3WMziUsFO~TY^ZF8yQ{!D3f{_AOZjb
zlc5<X0)XPP%NffJ2T2A)Q&d3-lYuA~lR79C9ROgU8<Siw1Yc7^Ur<9yFi=uOQ$tWi
OP62%i4`8zcD5YcLDIdxJ

delta 136
zcmV;30C)d~mjbAl0t!S^L{zAY0003mu?hzn3WV<lUsFO~TY^oK8yQ{!Et7f~AO}NG
zQd0o{0+XB>C<2V*v&I?A4F*LBLsL{ilL06$IRIdwH<Mg11Yc7^Ur<9yFi=uOQ$tWv
qQvskFlUy$ZUsFO~P(w*DP*O!xLr_Id0dNWrV4($Y3JtU3C#7SvStvmO

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


