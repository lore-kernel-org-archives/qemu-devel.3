Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EED9BD767FA
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 20:08:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6bSS-0000zv-A2; Thu, 31 Oct 2024 16:07:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1t6bSJ-0000hY-EN; Thu, 31 Oct 2024 16:07:45 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1t6bSG-0007aG-F5; Thu, 31 Oct 2024 16:07:43 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XfZkP2wQbz6JBfK;
 Fri,  1 Nov 2024 04:06:05 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
 by mail.maildlp.com (Postfix) with ESMTPS id 3ACC51400D3;
 Fri,  1 Nov 2024 04:07:27 +0800 (CST)
Received: from 00293818-MRGF.huawei.com (10.48.152.207) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 31 Oct 2024 21:07:07 +0100
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
Subject: [PATCH V2 5/6] tests/qtest/bios-tables-test: Update DSDT golden
 masters for x86/{pc, q35}
Date: Thu, 31 Oct 2024 20:05:01 +0000
Message-ID: <20241031200502.3869-6-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241031200502.3869-1-salil.mehta@huawei.com>
References: <20241031200502.3869-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.48.152.207]
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

Update DSDT golden master files for x86/pc and x86/q35 platforms to accommodate
changes made in the architecture-agnostic CPU AML. These updates notify the
guest OS of vCPU hot-plug and hot-unplug status using the ACPI `_STA.Enabled`
bit.

The following is a diff of the changes in the .dsl file generated with IASL:

  * Disassembling to symbolic ASL+ operators
  *
- * Disassembly of tests/data/acpi/x86/pc/DSDT, Wed Oct 30 11:24:52 2024
+ * Disassembly of /tmp/aml-2A3EW2, Wed Oct 30 11:24:52 2024
  *
  * Original Table Header:
  *     Signature        "DSDT"
- *     Length           0x0000214F (8527)
+ *     Length           0x00002155 (8533)
  *     Revision         0x01 **** 32-bit table (V1), no 64-bit math support
- *     Checksum         0x59
+ *     Checksum         0xD2
  *     OEM ID           "BOCHS "
  *     OEM Table ID     "BXPC    "
  *     OEM Revision     0x00000001 (1)
@@ -1517,6 +1517,10 @@
                 If ((\_SB.PCI0.PRES.CPEN == One))
                 {
                     Local0 = 0x0F
+                }
+                Else
+                {
+                    Local0 = 0x0D
                 }

                 Release (\_SB.PCI0.PRES.CPLK)

Reported-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 tests/data/acpi/x86/pc/DSDT                   | Bin 8527 -> 8533 bytes
 tests/data/acpi/x86/pc/DSDT.acpierst          | Bin 8438 -> 8444 bytes
 tests/data/acpi/x86/pc/DSDT.acpihmat          | Bin 9852 -> 9858 bytes
 tests/data/acpi/x86/pc/DSDT.bridge            | Bin 15398 -> 15404 bytes
 tests/data/acpi/x86/pc/DSDT.cphp              | Bin 8991 -> 8997 bytes
 tests/data/acpi/x86/pc/DSDT.dimmpxm           | Bin 10181 -> 10187 bytes
 tests/data/acpi/x86/pc/DSDT.hpbridge          | Bin 8478 -> 8484 bytes
 tests/data/acpi/x86/pc/DSDT.hpbrroot          | Bin 5034 -> 5040 bytes
 tests/data/acpi/x86/pc/DSDT.ipmikcs           | Bin 8599 -> 8605 bytes
 tests/data/acpi/x86/pc/DSDT.memhp             | Bin 9886 -> 9892 bytes
 tests/data/acpi/x86/pc/DSDT.nohpet            | Bin 8385 -> 8391 bytes
 tests/data/acpi/x86/pc/DSDT.numamem           | Bin 8533 -> 8539 bytes
 tests/data/acpi/x86/pc/DSDT.roothp            | Bin 12320 -> 12326 bytes
 tests/data/acpi/x86/q35/DSDT                  | Bin 8355 -> 8361 bytes
 tests/data/acpi/x86/q35/DSDT.acpierst         | Bin 8372 -> 8378 bytes
 tests/data/acpi/x86/q35/DSDT.acpihmat         | Bin 9680 -> 9686 bytes
 .../acpi/x86/q35/DSDT.acpihmat-noinitiator    | Bin 8634 -> 8640 bytes
 tests/data/acpi/x86/q35/DSDT.applesmc         | Bin 8401 -> 8407 bytes
 tests/data/acpi/x86/q35/DSDT.bridge           | Bin 11968 -> 11974 bytes
 tests/data/acpi/x86/q35/DSDT.core-count       | Bin 12913 -> 12919 bytes
 tests/data/acpi/x86/q35/DSDT.core-count2      | Bin 33770 -> 33776 bytes
 tests/data/acpi/x86/q35/DSDT.cphp             | Bin 8819 -> 8825 bytes
 tests/data/acpi/x86/q35/DSDT.cxl              | Bin 13148 -> 13154 bytes
 tests/data/acpi/x86/q35/DSDT.dimmpxm          | Bin 10009 -> 10015 bytes
 tests/data/acpi/x86/q35/DSDT.ipmibt           | Bin 8430 -> 8436 bytes
 tests/data/acpi/x86/q35/DSDT.ipmismbus        | Bin 8443 -> 8449 bytes
 tests/data/acpi/x86/q35/DSDT.ivrs             | Bin 8372 -> 8378 bytes
 tests/data/acpi/x86/q35/DSDT.memhp            | Bin 9714 -> 9720 bytes
 tests/data/acpi/x86/q35/DSDT.mmio64           | Bin 9485 -> 9491 bytes
 tests/data/acpi/x86/q35/DSDT.multi-bridge     | Bin 13208 -> 13214 bytes
 tests/data/acpi/x86/q35/DSDT.noacpihp         | Bin 8235 -> 8241 bytes
 tests/data/acpi/x86/q35/DSDT.nohpet           | Bin 8213 -> 8219 bytes
 tests/data/acpi/x86/q35/DSDT.numamem          | Bin 8361 -> 8367 bytes
 tests/data/acpi/x86/q35/DSDT.pvpanic-isa      | Bin 8456 -> 8462 bytes
 tests/data/acpi/x86/q35/DSDT.thread-count     | Bin 12913 -> 12919 bytes
 tests/data/acpi/x86/q35/DSDT.thread-count2    | Bin 33770 -> 33776 bytes
 tests/data/acpi/x86/q35/DSDT.tis.tpm12        | Bin 8961 -> 8967 bytes
 tests/data/acpi/x86/q35/DSDT.tis.tpm2         | Bin 8987 -> 8993 bytes
 tests/data/acpi/x86/q35/DSDT.type4-count      | Bin 18589 -> 18595 bytes
 tests/data/acpi/x86/q35/DSDT.viot             | Bin 14615 -> 14621 bytes
 tests/data/acpi/x86/q35/DSDT.xapic            | Bin 35718 -> 35724 bytes
 tests/qtest/bios-tables-test-allowed-diff.h   |  41 ------------------
 42 files changed, 41 deletions(-)

diff --git a/tests/data/acpi/x86/pc/DSDT b/tests/data/acpi/x86/pc/DSDT
index 92225236e717b2e522a2ee00492fb0ded418dc7b..e9e1a1eba3c81b296804ea50f2a42c3841bff6ef 100644
GIT binary patch
delta 50
zcmV-20L}l;Le)YFL{mgmRUrTX0n)Jwx(otEKa<7`umVFglXwj_0Zx;z4NwK41#k)t
Iv;GZH6P#QR&;S4c

delta 44
zcmV+{0Mq}~LeD}9L{mgmPayyR0a>vMx(otOK9j}_umVjplXwj_0Z5at4N$WM4p0*{
C5)Co{

diff --git a/tests/data/acpi/x86/pc/DSDT.acpierst b/tests/data/acpi/x86/pc/DSDT.acpierst
index 25b39955059409b177870800949eaf937cd39005..7d0385b5f9e1f04e55cc190892ad26050a930122 100644
GIT binary patch
delta 50
zcmV-20L}mQLHt1qL{mgm{2%}T0UNOjx(otEKa<7`umVFglXwj_0Zx;z4NwK41#k)t
Iv;GbE60H&tu>b%7

delta 44
zcmV+{0Mq~cLH0okL{mgm_8<TN0iv-Ax(otOK9j}_umVjplXwj_0Z5at4N$WM4)+pb
CW)Bkp

diff --git a/tests/data/acpi/x86/pc/DSDT.acpihmat b/tests/data/acpi/x86/pc/DSDT.acpihmat
index 73a9ce59e9426b180fea0ec5820c4841ebdb6700..c1ad3cbadc6310cecb6cdb8f859fd2402ce46b20 100644
GIT binary patch
delta 55
zcmV-70LcIROoB}cL{mgmf+hd}0gtf?x(otDMU%!1umVCllXwk50Zx;;4NwN51#k)t
NV3TkV6|)}>T^Q)x5Q+c*

delta 44
zcmV+{0Mq}1P5ev>L{mgmd?o+@0T!_ex(otNM3cr0umVgulXwk50Z5a&4N$WX4ssYW
CtPNrS

diff --git a/tests/data/acpi/x86/pc/DSDT.bridge b/tests/data/acpi/x86/pc/DSDT.bridge
index 4cef454e379e1009141694e0f4036a2a701c80d7..5f91aafbefa0dd02d2cc18efbe146c9cd6c78063 100644
GIT binary patch
delta 50
zcmV-20L}lVc&vB|L{mgmEIa@J0pPI;x(otEKa<7`umVFglXwj_0Zx;z4NwK41#k)t
Iv;GYzE}&8m+yDRo

delta 44
zcmV+{0Mq}hc&2y?L{mgmCOiND0cWuax(otOK9j}_umVjplXwj_0Z5at4N$WM4ks=+
CYz;mD

diff --git a/tests/data/acpi/x86/pc/DSDT.cphp b/tests/data/acpi/x86/pc/DSDT.cphp
index 1dc928333d7ae7e4df6bb51d850af5e1cb480158..26f4e272eb4146fffa8182e14d2ccd110860516b 100644
GIT binary patch
delta 55
zcmV-70LcHJMx{myL{mgmB_jX;0XDG;x(otET$9EOumVF-lXwks0Zx<a4NwN51#k)t
NV3VN`6|+zd&lJky5bOW|

delta 44
zcmV+{0Mq}aMxRCsL{mgmA0q$&0ll#bx(otOTa(5NumVj`lXwks0Z5bU4N$W|4&)Rz
C;trDl

diff --git a/tests/data/acpi/x86/pc/DSDT.dimmpxm b/tests/data/acpi/x86/pc/DSDT.dimmpxm
index 9f71d2e58b1707e733584e38dab7f73f9bda5eb7..34bd16d362a164f765b160e906ea285c746701a6 100644
GIT binary patch
delta 48
zcmV-00MGx$Ps>jVL{mgm%O?N;0pzg?&I|!gli3Wh0ZfyN4O#(CljaRj1)&9S3JtS0
G4v-n5ED#g`

delta 52
zcmV-40L%Z&PsL9PL{mgm#U}s&0g15+&I|!ali3Wh0Y;OH4O$0C218R+K?#!~5G|7#
K4jr>R4v!hafDfkt

diff --git a/tests/data/acpi/x86/pc/DSDT.hpbridge b/tests/data/acpi/x86/pc/DSDT.hpbridge
index db420593a3c51eced25cd57420353fbb9ccdf63c..0606ddd2016530cc91834ef41860f94655a35a43 100644
GIT binary patch
delta 50
zcmV-20L}lNLZm_pL{mgmBq0C*0S2)Ox(otEKa<7`umVFglXwj_0Zx;z4NwK41#k)t
Iv;GYr6J)OrKmY&$

delta 44
zcmV+{0Mq}ZLY_hjL{mgm9w7h#0gbT=x(otOK9j}_umVjplXwj_0Z5at4N$WM4j&UE
CpA4b^

diff --git a/tests/data/acpi/x86/pc/DSDT.hpbrroot b/tests/data/acpi/x86/pc/DSDT.hpbrroot
index 31b6adb4eb941e5bf0c02ec8c3819c9213adf022..545b4019468d928df92e7f3c458280a387914140 100644
GIT binary patch
delta 59
zcmV-B0L1^QC$J|9L{mgmuoD0P0rs&9Z3_ZLKa+V2umVFglPe5122KV;Q&d5d&<rk<
Rl?)vPp#^XX4YRQf`34El5vc$G

delta 60
zcmV-C0K@;VC#ok3L{mgmsuKVJ0e!IwZ3_ZVK9hM1umVjplPe512}lM*Q&d3-TO*T!
S4il4o3^kK~4i&S_4C4m<R}o<V

diff --git a/tests/data/acpi/x86/pc/DSDT.ipmikcs b/tests/data/acpi/x86/pc/DSDT.ipmikcs
index c2a0330d97d495298889b9e28bde2f90235cea88..622d272e4bf75efe9101cfa383475135bb500005 100644
GIT binary patch
delta 50
zcmV-20L}lGL!CnkL{mgmogn}K0Zy?Bx(otEKa<7`umVFglXwj_0Zx;z4NwK41#k)t
Iv;Ga46M)nYZU6uP

delta 44
zcmV+{0Mq}SLzhDeL{mgmmmvTE0oAbzx(otOK9j}_umVjplXwj_0Z5at4N$WM4ww@=
Ch7HgF

diff --git a/tests/data/acpi/x86/pc/DSDT.memhp b/tests/data/acpi/x86/pc/DSDT.memhp
index c15a9fae947bb3929a30c60b7c0f2092705868f8..bbdcce072de8a2fbe89632075a0099af171f3a84 100644
GIT binary patch
delta 48
zcmV-00MGxPO{7f<L{mgmq$U6W0j9AEx(oqJlf?|N0ZEg04L1Q!ldla>1)&9S3JtUV
G4WJl%{STJ_

delta 42
zcmV+_0M-AbO`c5(L{mgmo+bbQ0ZXw8x(oqDlf?|N0Yj5_4L1Quldla>vjq;H7#Z*k
A`2YX_

diff --git a/tests/data/acpi/x86/pc/DSDT.nohpet b/tests/data/acpi/x86/pc/DSDT.nohpet
index dd29f5cb620e5164601e303e37524530ddb12684..8e738e4ed34e90741b2af11bae2927ab23b9716f 100644
GIT binary patch
delta 50
zcmV-20L}lwLB~M~L{mgm#~=Uz0i3Z4EDQogKa)5NumVFglj;mM0Zx-44NwK41#k)t
Ivv3Vj6MnM}CIA2c

delta 44
zcmV+{0Mq}+LBT-^L{mgm!5{zt0VA;rEDQoqK9e{MumVjplj;mM0Z5Y}4N$Xp4Nwyz
C4h)9?

diff --git a/tests/data/acpi/x86/pc/DSDT.numamem b/tests/data/acpi/x86/pc/DSDT.numamem
index 8a6b56fe7da18bf42c339d13b863aabf81780527..78bc2ca8b1b6fa9a01182550dd9d80fe27035ddb 100644
GIT binary patch
delta 48
zcmV-00MGx`Lfb+LL{mgmTOj}d0ba2Rx(oqJlf?|N0ZEg04L1Q!ldla>1)&9S3JtUV
G4ObI(HxCN{

delta 42
zcmV+_0M-B7Le)YFL{mgmRUrTX0RyoLx(oqDlf?|N0Yj5_4L1Quldla>vjq-T6BV8e
AZ2$lO

diff --git a/tests/data/acpi/x86/pc/DSDT.roothp b/tests/data/acpi/x86/pc/DSDT.roothp
index a16b0d9d4becec47fa3cf57ed0077ff6cff88908..f8164f4fb224b1accd45431baee9fa002c4f5cc7 100644
GIT binary patch
delta 50
zcmV-20L}lPV5VRSL{mgmCNKa10ba2Rx(otEKa<7`umVFglXwj_0Zx;z4NwK41#k)t
Iv;GYtB7e{h`Tzg`

delta 44
zcmV+{0Mq}bV4z?ML{mgmATR&`0p+m@x(otOK9j}_umVjplXwj_0Z5at4N$WM4k02s
C$_-oq

diff --git a/tests/data/acpi/x86/q35/DSDT b/tests/data/acpi/x86/q35/DSDT
index fb89ae0ac6d4346e33156e9e4d3718698a0a1a8e..de0b8b2511d0ddc72babf40cc4ce4f206c9306c3 100644
GIT binary patch
delta 55
zcmV-70LcHNL8(CsL{mgmsUQFV0kE+O2N?oIKa&#~umVFglf@Y}0Zx<r8BhkH1#k)t
NV3V;N6|-R)LI%b}5H|n-

delta 44
zcmV+{0Mq}eL8CzmL{mgmqaXkP0XMM<2N?oSK9ds}umVjplf@Y}0Z5bl8BnuQ8dnAv
C0Sv+b

diff --git a/tests/data/acpi/x86/q35/DSDT.acpierst b/tests/data/acpi/x86/q35/DSDT.acpierst
index 46fd25400b7c00ee9149ddb64cb5d5bd73f6a82b..294aa4a38498d7a41ae7d21d69637af447454471 100644
GIT binary patch
delta 55
zcmV-70LcHeLApT-L{mgmx*z}m0Z_3D2N?oIKa&#~umVFglf@Y}0Zx<r8BhkH1#k)t
NV3V;N6|-R)QwG665E}ph

delta 44
zcmV+{0Mq}vL9{^%L{mgmv>*Tg0oSn#2N?oSK9ds}umVjplf@Y}0Z5bl8BnuQ8fXSF
C><y*>

diff --git a/tests/data/acpi/x86/q35/DSDT.acpihmat b/tests/data/acpi/x86/q35/DSDT.acpihmat
index 61c5bd52a42242e85090934e8e45bf01642609d6..3afe828b29962abf2f97bc5cdb04416994570bcf 100644
GIT binary patch
delta 71
zcmV-N0J#6qOV&#YL{mgm)+GP{0d27g2N?oHMUxX5umVCllf@Z92~Gw>Q&d3-TO*Sp
d921j^8W@v08XX3q1#k)tV3Qvl6|-y_WDDBY6G#96

delta 44
zcmV+{0Mq~0OVCRSL{mgm&?Nu>0ras72N?oRM3WO4umVgulf@Z90Z5Yv8c?%c8hHyq
CcMWm?

diff --git a/tests/data/acpi/x86/q35/DSDT.acpihmat-noinitiator b/tests/data/acpi/x86/q35/DSDT.acpihmat-noinitiator
index 3aaa2bbdf54a0d0cade14421e84c6ec5a42f96fa..b804c531acb6e8900106dab687c8689bec69ef3d 100644
GIT binary patch
delta 48
zcmV-00MGxrL%>4{L{mgmz##wt0T{6g2N?lOlM)%R0ZNm^8Cn5OlOGyT1)&9S3JtSv
G8cYXG&J7Cy

delta 42
zcmV+_0M-A%L%Kr>L{mgmx*-4n0ll#b2N?lIlM)%R0YsC;8Cn5IlOGyTvvnFv2NjkK
AYybcN

diff --git a/tests/data/acpi/x86/q35/DSDT.applesmc b/tests/data/acpi/x86/q35/DSDT.applesmc
index 944209adeaa5bbb722431161c404cb51b8209993..02fdf5b3fd51f7ffb20305335d111b1278c1d645 100644
GIT binary patch
delta 55
zcmV-70LcH*LDxYFL{mgm*B}4@0idx82N?oIKa&#~umVFglf@Y}0Zx<r8BhkH1#k)t
NV3V;N6|-R)a0cJJ5Z?d*

delta 44
zcmV+{0Mq~1LD4}9L{mgm(I5Z-0VlBv2N?oSK9ds}umVjplf@Y}0Z5bl8BnuQ8ifWc
CI}K_8

diff --git a/tests/data/acpi/x86/q35/DSDT.bridge b/tests/data/acpi/x86/q35/DSDT.bridge
index d9938dba8fa5d405f7696c0dbdc24f3ae42ec934..7600941e40bd5e2e773f7aa2a1aeb3d9a32e5e44 100644
GIT binary patch
delta 55
zcmV-70LcHqUB+DsL{mgm#x4K=0nD)q2N?oIKa&#~umVFglf@Y}0Zx<r8BhkH1#k)t
NV3V;N6|-R)Uli(y5gPyi

delta 44
zcmV+{0Mq}*UBF!mL{mgmz%Bp)0aLLG2N?oSK9ds}umVjplf@Y}0Z5bl8BnuQ8gvvh
CQVpg6

diff --git a/tests/data/acpi/x86/q35/DSDT.core-count b/tests/data/acpi/x86/q35/DSDT.core-count
index a24b04cbdbf09383b933a42a2a15182545543a87..dbd7a694d3146c3223e7c511a04dc9a51d57fac5 100644
GIT binary patch
delta 56
zcmV-80LTCFWcOqWL{mgmcQOC~0VuHw2N?o`T$2+Su>ycmv&I>-0s&5wdK^#&p#^XX
O4PcWn9~HCT9Fi6PNfD_4

delta 45
zcmV+|0Mh^WWbtGQL{mgmaWVh^0k5$N2N?p5TayzRu>y)vv&I>-0s%;qdK^%*&>W`~
DX3-C_

diff --git a/tests/data/acpi/x86/q35/DSDT.core-count2 b/tests/data/acpi/x86/q35/DSDT.core-count2
index 3a0cb8c581c8cc630a2ec21712b7f8b75fcad1c8..2e3cc743567b8c166b2d4dc4ab421af931842418 100644
GIT binary patch
delta 72
zcmV-O0Js0@hXU}20t!S^L{#vD00048u?hzn0gRIp8L|P1v&9);3<*vKLsL{i30otR
eK`0ZGswNndStcC@p#^XX4PcW$C>67dCSP4Y85Q3E

delta 45
zcmV+|0Mh^PhXU${0t!S^L{#d700032u?hzn0fv(j8L|O`v&9);3;{@!CMHm`d?s{V
DRk03+

diff --git a/tests/data/acpi/x86/q35/DSDT.cphp b/tests/data/acpi/x86/q35/DSDT.cphp
index 20955d0aa30120553da35d5a6640055d26255cf9..2cfc5a6669b09ca0bf8fda926a5c6e3848e819c1 100644
GIT binary patch
delta 55
zcmV-70LcIIMEOJtL{mgmc_IJ+0Ti(c2N?oIT$2+SumVF-lf@Zw0Zx-R8c+tI1#k)t
NV3SZB6|<ch)(6Do5H<h+

delta 44
zcmV+{0Mq~ZMDs)nL{mgmb0Po$0h_T32N?oSTayzRumVj`lf@Zw0Z5ZL8c?&28tVr;
CgbpGA

diff --git a/tests/data/acpi/x86/q35/DSDT.cxl b/tests/data/acpi/x86/q35/DSDT.cxl
index f561750cab8b061c123c041fe2209d74c7a740f1..5107c436ef8b0d1d2c7d66f59da5b29e604e2b9d 100644
GIT binary patch
delta 55
zcmV-70LcH`X5wZFL{mgmVlw~$0mQKi2N?oIKa&#~umVFglf@Y}0Zx<r8BhkH1#k)t
NV3V;N6|-R)`xxl&5uN}5

delta 44
zcmV+{0Mq~CX53~9L{mgmTr&Uw0ZXw82N?oSK9ds}umVjplf@Y}0Z5bl8BnuQ8W0&U
C`3))n

diff --git a/tests/data/acpi/x86/q35/DSDT.dimmpxm b/tests/data/acpi/x86/q35/DSDT.dimmpxm
index 228374b55bd544116e359f659e546fc66cf8a895..5058d808b533b6ee55660fab4c03ba525ac2e63d 100644
GIT binary patch
delta 57
zcmV-90LK5BPM=N+L{mgmA143+0l~2f8yNvklO`Fl0ZfzF8CnKT218R+L6e~xE|X>&
P9R;BUa0(5xf*O|$)*}#C

delta 58
zcmV-A0LA~GPMJ;$L{mgm87BY$0cNoZ8yNvelO`Fl0Y;P98CnTQ218R+K?z$UlkprA
QlTI2nlTjQMvz{7(4AgrNjsO4v

diff --git a/tests/data/acpi/x86/q35/DSDT.ipmibt b/tests/data/acpi/x86/q35/DSDT.ipmibt
index 45f911ada5645f158f3d6c0c430ec1d52cadc5d8..875781741c0239bd70a6fc4013bc8f03ea6ced32 100644
GIT binary patch
delta 55
zcmV-70LcIDLG(ciL{mgm^dJBL0pzg?2N?oIKa&#~umVFglf@Y}0Zx<r8BhkH1#k)t
NV3V;N6|-R)jRyQo5tje}

delta 44
zcmV+{0Mq~ULGD2cL{mgm?jQgF0c)`e2N?oSK9ds}umVjplf@Y}0Z5bl8BnuQ8lnb4
CA`T(|

diff --git a/tests/data/acpi/x86/q35/DSDT.ipmismbus b/tests/data/acpi/x86/q35/DSDT.ipmismbus
index e5d6811bee1233d74236453c49060390d74d4416..f958a3f22e645e7aa30451ed0525c4bcb23a94a7 100644
GIT binary patch
delta 55
zcmV-70LcIQL4iUFL{mgm0U-bY0aURH2N?oIKa&#~umVFglf@Y}0Zx<r8BhkH1#k)t
NV3V;N6|-R)ng*o_54`{Y

delta 44
zcmV+{0Mq}0Li<4qL{mgm`yc=S0o<_)2N?oSK9ds}umVjplf@Y}0Z5bl8BnuQ8m|UE
C$__{X

diff --git a/tests/data/acpi/x86/q35/DSDT.ivrs b/tests/data/acpi/x86/q35/DSDT.ivrs
index 46fd25400b7c00ee9149ddb64cb5d5bd73f6a82b..294aa4a38498d7a41ae7d21d69637af447454471 100644
GIT binary patch
delta 55
zcmV-70LcHeLApT-L{mgmx*z}m0Z_3D2N?oIKa&#~umVFglf@Y}0Zx<r8BhkH1#k)t
NV3V;N6|-R)QwG665E}ph

delta 44
zcmV+{0Mq}vL9{^%L{mgmv>*Tg0oSn#2N?oSK9ds}umVjplf@Y}0Z5bl8BnuQ8fXSF
C><y*>

diff --git a/tests/data/acpi/x86/q35/DSDT.memhp b/tests/data/acpi/x86/q35/DSDT.memhp
index 5ce081187a578ba7145a9ba20d30be36c13b7663..2e90fba1e72c1ef94b9e8ddb5b5034fe7371e447 100644
GIT binary patch
delta 53
zcmV-50LuUJOZZC)L{mgm_$2@U0fey%2N?lNlM)%R0ZEg@88-n=ll&P_2B8IT3JqYB
Lu^bh%VH%MO*#Z#!

delta 42
zcmV+_0M-BaOY%z!L{mgm@+ANO0V%Nx2N?lHlM)%R0Yj6-88-n)ll&P_vr-zS3ntSI
AhX4Qo

diff --git a/tests/data/acpi/x86/q35/DSDT.mmio64 b/tests/data/acpi/x86/q35/DSDT.mmio64
index bdf36c4d575bfc4eb2eac3f00c9b7b4270f88677..ebde2fed094fd0eecbbc83e8ccc12db3ff471b6a 100644
GIT binary patch
delta 53
zcmV-50LuT3N|Q<oL{mgm6D0ru0YtG12N?lNlM)%R0ZEg@88-n=ll&P_2B8IT3JqYB
Lu^bh%VH&IoeytBB

delta 42
zcmV+_0M-AKN{vbiL{mgm4J7~o0qL;{2N?lHlM)%R0Yj6-88-n)ll&P_vr-zt3jN9q
AumAu6

diff --git a/tests/data/acpi/x86/q35/DSDT.multi-bridge b/tests/data/acpi/x86/q35/DSDT.multi-bridge
index 1db43a69e4c2affd8bd678bbef4d3c228380288e..9ab52bd77c8ceb0c6487974b19aae6e0702b7086 100644
GIT binary patch
delta 55
zcmV-70LcHCXP##YL{mgmo-+Ud0mZQj2N?oIKa&#~umVFglf@Y}0Zx<r8BhkH1#k)t
NV3V;N6|-R)HyPFw5Rw1@

delta 44
zcmV+{0Mq}TXP9RSL{mgmm@@zX0Zg$92N?oSK9ds}umVjplf@Y}0Z5bl8BnuQ8cZ1@
CKMfrK

diff --git a/tests/data/acpi/x86/q35/DSDT.noacpihp b/tests/data/acpi/x86/q35/DSDT.noacpihp
index 8bc16887e1c963c61aaecf71712a09c0554f6d67..4a2a3281d6a4633bdac1232eb911c8d1aa1d036c 100644
GIT binary patch
delta 50
zcmV-20L}laK(RmyL{mgmF(3c{0YkA0x)%aPKa<86umVFglXw_50Zx;z7*GYF1#k)t
Iv;G(@2X}W4*8l(j

delta 44
zcmV+{0Mq}mK&wCsL{mgmD<A*>0m`uox)%aZK9j~5umVjplXw_50Z5at7*MkX87v1g
CB@H<M

diff --git a/tests/data/acpi/x86/q35/DSDT.nohpet b/tests/data/acpi/x86/q35/DSDT.nohpet
index c13e45e3612646cc2e30f00b3b7e53335da816ea..1263faef6dcb0a8d273a1d689c06c504a7ec7dc5 100644
GIT binary patch
delta 50
zcmV-20L}lEK$}1cL{mgm8z2Ax0eP_sc^CpkKa+(RumVFglQ$VQ0Zx-{8BhhG1#k)t
Iv%MKu23qY6wEzGB

delta 44
zcmV+{0Mq}QK$SoWL{mgm6(9fr0RXWIc^CpuK9hwQumVjplQ$VQ0Z5Z>8Bnvt8CM1Z
C;0zW3

diff --git a/tests/data/acpi/x86/q35/DSDT.numamem b/tests/data/acpi/x86/q35/DSDT.numamem
index ba6669437e65952f24516ded954b33fe54bdedfb..b97e22e837d05355d75d56fb93029cb1b08abf0d 100644
GIT binary patch
delta 53
zcmV-50LuTVL9amyL{mgmuOI*b0X(q^2N?lNlM)%R0ZEg@88-n=ll&P_2B8IT3JqYB
Lu^bh%VH!vVo@@_t

delta 42
zcmV+_0M-AmL8(CsL{mgmsUQFV0pYO<2N?lHlM)%R0Yj6-88-n)ll&P_vr-ye1{Ki^
A{Qv*}

diff --git a/tests/data/acpi/x86/q35/DSDT.pvpanic-isa b/tests/data/acpi/x86/q35/DSDT.pvpanic-isa
index 6ad42873e91c80cef5a42224cb4d31936dad59b4..ac99bf0cee6ab2e2c20ddefb00330b105f524b24 100644
GIT binary patch
delta 55
zcmV-70LcG{LXJWTL{mgm4j}*l0b;QV2N?oIKa&#~umVFglf@Y}0Zx<r8BhkH1#k)t
NV3V;N6|-R)rv{Vh4}bsw

delta 44
zcmV+{0Mq}DLWn{NL{mgm2q6Ff0qL;{2N?oSK9ds}umVjplf@Y}0Z5bl8BnuQ8oUM$
C+6@Z;

diff --git a/tests/data/acpi/x86/q35/DSDT.thread-count b/tests/data/acpi/x86/q35/DSDT.thread-count
index a24b04cbdbf09383b933a42a2a15182545543a87..dbd7a694d3146c3223e7c511a04dc9a51d57fac5 100644
GIT binary patch
delta 56
zcmV-80LTCFWcOqWL{mgmcQOC~0VuHw2N?o`T$2+Su>ycmv&I>-0s&5wdK^#&p#^XX
O4PcWn9~HCT9Fi6PNfD_4

delta 45
zcmV+|0Mh^WWbtGQL{mgmaWVh^0k5$N2N?p5TayzRu>y)vv&I>-0s%;qdK^%*&>W`~
DX3-C_

diff --git a/tests/data/acpi/x86/q35/DSDT.thread-count2 b/tests/data/acpi/x86/q35/DSDT.thread-count2
index 3a0cb8c581c8cc630a2ec21712b7f8b75fcad1c8..2e3cc743567b8c166b2d4dc4ab421af931842418 100644
GIT binary patch
delta 72
zcmV-O0Js0@hXU}20t!S^L{#vD00048u?hzn0gRIp8L|P1v&9);3<*vKLsL{i30otR
eK`0ZGswNndStcC@p#^XX4PcW$C>67dCSP4Y85Q3E

delta 45
zcmV+|0Mh^PhXU${0t!S^L{#d700032u?hzn0fv(j8L|O`v&9);3;{@!CMHm`d?s{V
DRk03+

diff --git a/tests/data/acpi/x86/q35/DSDT.tis.tpm12 b/tests/data/acpi/x86/q35/DSDT.tis.tpm12
index e381ce4cbf2b11f56a2d0537db4d21acc97450c9..3305b0a67f4a672096a4c7e19d13e58e771c6c54 100644
GIT binary patch
delta 55
zcmV-70LcG=Mu$cUL{mgm2O|Ig0pPI;2N?oIKa&#~umVFglf@Y}0Zx<r8BhkH1#k)t
NV3V;N6|-R)pa`Yc5AFZ}

delta 44
zcmV+{0Mq}6MuA2OL{mgm0V4na0cWua2N?oSK9ds}umVjplf@Y}0Z5bl8BnuQ8np=h
C$P9S^

diff --git a/tests/data/acpi/x86/q35/DSDT.tis.tpm2 b/tests/data/acpi/x86/q35/DSDT.tis.tpm2
index a09253042ce4a715922027245de8a2ab7449c5b7..c4697d0c8c01f9ec8c461416c53fddf5e945a5de 100644
GIT binary patch
delta 55
zcmV-70LcHFMxjOuL{mgmAtL|)0h+N22N?oIKa&#~umVFglf@Y}0Zx<r8BhkH1#k)t
NV3V;N6|-R)x(KRy5D)+W

delta 44
zcmV+{0Mq}WMw><oL{mgm8zTS!0U@yp2N?oSK9ds}umVjplf@Y}0Z5bl8BnuQ8qWv<
CAq<-U

diff --git a/tests/data/acpi/x86/q35/DSDT.type4-count b/tests/data/acpi/x86/q35/DSDT.type4-count
index edc23198cdb47a981bcbc82bc8e392b815abb554..9adbf8aa063bc4c293d21ec354682b67ba0ee8d7 100644
GIT binary patch
delta 59
zcmV-B0L1^DkpZKT0SZJ@L{y_l0003tu?hzn0gsas8L|P4v&9+A1qMzALsL{ik{~XV
R#UC97p#^XX4YT1NyeJe55=;O9

delta 59
zcmV-B0L1^JkpZ2N0SZJ@L{yzf0005ou?hzn0g00m8L|O}v&9+A1qVn5LsL{i36sqs
REtAC`9h0yj6|?;xrYJXN6aD}I

diff --git a/tests/data/acpi/x86/q35/DSDT.viot b/tests/data/acpi/x86/q35/DSDT.viot
index 8d98dd8845a60a08df5aff27097646bea4913b75..da2c931ad925c4eb008800cbc57b94a5c5e21c93 100644
GIT binary patch
delta 55
zcmV-70LcHBa-DJtL{mgm9XS910aCFF2N?oIKa&#~umVFglf@Y}0Zx<r8BhkH1#k)t
NV3V;N6|-R)wjQ#r5Ig_?

delta 44
zcmV+{0Mq}Sa+h)nL{mgm7dZd`0okz%2N?oSK9ds}umVjplf@Y}0Z5bl8BnuQ8p|Fh
CHx0)C

diff --git a/tests/data/acpi/x86/q35/DSDT.xapic b/tests/data/acpi/x86/q35/DSDT.xapic
index d4acd851c62c956436a436f9fa6d08fc5f370fa7..8f32aa572d0da050831a43eafd5dc92393a0da97 100644
GIT binary patch
delta 60
zcmV-C0K@-=mjaBJ0t!S^L{yB600043u?hzn0f>_l8L|R};<LsX%MAuj218R+L6Rsg
Slf@?;1)&9S3JtU2C#7RPB@>bW

delta 62
zcmV-E0Kxx^mjZ^D0t!S^L{x^00005)u?hzn0fLhf8L|S8;j_jW%MA%g218R+K?z$U
UlTj)YldUH;ld&lkv;8NJV|@P=H~;_u

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


