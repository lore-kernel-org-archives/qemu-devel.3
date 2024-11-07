Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 743E7D4335B
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 12:37:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t91lR-0006nv-5t; Thu, 07 Nov 2024 07:37:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1t91lP-0006bL-4j
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 07:37:27 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1t91lL-0001mR-Db
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 07:37:26 -0500
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XkhRL02w4z6LDB7;
 Thu,  7 Nov 2024 20:37:18 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id EA392140CB9;
 Thu,  7 Nov 2024 20:37:21 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 7 Nov 2024 13:37:21 +0100
To: "Michael S . Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 <qemu-devel@nongnu.org>
CC: <linuxarm@huawei.com>
Subject: [PATCH 5/5] bios-tables-test: Add data for complex numa test (GI,
 GP etc)
Date: Thu, 7 Nov 2024 12:34:46 +0000
Message-ID: <20241107123446.902801-6-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241107123446.902801-1-Jonathan.Cameron@huawei.com>
References: <20241107123446.902801-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.122.19.247]
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 frapeml500008.china.huawei.com (7.182.85.71)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Given this is a new configuration, there are affects on APIC, CEDT
and DSDT, but the key elements are in SRAT (plus related data in
HMAT).  The configuration has node to exercise many different combinations.

0) CPUs + Memory
1) GI only
2) GP only
3) CPUS only
4) Memory only
5) CPUs + HP memory

GI node, GP Node, Memory only node, hotplug memory
only node, latency and bandwidth such that in Linux Access0
(any initiator) and Access1 (CPU initiators only) given different
answers.  Following cropped to remove details of each entry.

[000h 0000 004h]                   Signature : "SRAT"    [System Resource Affinity Table]
...
[030h 0048 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
...
[032h 0050 001h]     Proximity Domain Low(8) : 00
[033h 0051 001h]                     Apic ID : 00
...
[040h 0064 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
...
[042h 0066 001h]     Proximity Domain Low(8) : 03
[043h 0067 001h]                     Apic ID : 01
...
[050h 0080 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
...
[052h 0082 001h]     Proximity Domain Low(8) : 05
[053h 0083 001h]                     Apic ID : 02
...
[060h 0096 001h]               Subtable Type : 01 [Memory Affinity]
...
[062h 0098 004h]            Proximity Domain : 00000000
...
[068h 0104 008h]                Base Address : 0000000000000000
[070h 0112 008h]              Address Length : 00000000000A0000
...
[088h 0136 001h]               Subtable Type : 01 [Memory Affinity]
...
[08Ah 0138 004h]            Proximity Domain : 00000000
...
[090h 0144 008h]                Base Address : 0000000000100000
[098h 0152 008h]              Address Length : 0000000003F00000
...
[0B0h 0176 001h]               Subtable Type : 01 [Memory Affinity]
...
[0B2h 0178 004h]            Proximity Domain : 00000004
...
[0B8h 0184 008h]                Base Address : 0000000004000000
[0C0h 0192 008h]              Address Length : 0000000004000000
... some zero length entries follow...

[1A0h 0416 001h]               Subtable Type : 05 [Generic Initiator Affinity]
[1A1h 0417 001h]                      Length : 20

[1A2h 0418 001h]                   Reserved1 : 00
[1A3h 0419 001h]          Device Handle Type : 01
[1A4h 0420 004h]            Proximity Domain : 00000001
[1A8h 0424 010h]               Device Handle : 00 00 01 02 00 00 00 00 00 00 00 00 00 00 00 00
[1B8h 0440 004h]       Flags (decoded below) : 00000001
                                     Enabled : 1
                  Architectural Transactions : 0
[1BCh 0444 004h]                   Reserved2 : 00000000

[1C0h 0448 001h]               Subtable Type : 06 [Generic Port Affinity]
[1C1h 0449 001h]                      Length : 20

[1C2h 0450 001h]                   Reserved1 : 00
[1C3h 0451 001h]          Device Handle Type : 00
[1C4h 0452 004h]            Proximity Domain : 00000002
[1C8h 0456 010h]               Device Handle : 41 43 50 49 30 30 31 36 40 00 00 00 00 00 00 00
[1D8h 0472 004h]       Flags (decoded below) : 00000001
                                     Enabled : 1
                  Architectural Transactions : 0
[1DCh 0476 004h]                   Reserved2 : 00000000

[1E0h 0480 001h]               Subtable Type : 01 [Memory Affinity]
...
[1E2h 0482 004h]            Proximity Domain : 00000005
...
[1E8h 0488 008h]                Base Address : 0000000100000000
[1F0h 0496 008h]              Address Length : 0000000090000000

Example block from HMAT:
[0F0h 0240 002h]              Structure Type : 0001 [System Locality Latency and Bandwidth Information]
[0F2h 0242 002h]                    Reserved : 0000
[0F4h 0244 004h]                      Length : 00000078
[0F8h 0248 001h]       Flags (decoded below) : 00
                            Memory Hierarchy : 0
                   Use Minimum Transfer Size : 0
                    Non-sequential Transfers : 0
[0F9h 0249 001h]                   Data Type : 03
[0FAh 0250 001h]       Minimum Transfer Size : 00
[0FBh 0251 001h]                   Reserved1 : 00
[0FCh 0252 004h] Initiator Proximity Domains # : 00000004
[100h 0256 004h]  Target Proximity Domains # : 00000006
[104h 0260 004h]                   Reserved2 : 00000000
[108h 0264 008h]             Entry Base Unit : 0000000000000004
[110h 0272 004h] Initiator Proximity Domain List : 00000000
[114h 0276 004h] Initiator Proximity Domain List : 00000001
[118h 0280 004h] Initiator Proximity Domain List : 00000003
[11Ch 0284 004h] Initiator Proximity Domain List : 00000005
[120h 0288 004h] Target Proximity Domain List : 00000000
[124h 0292 004h] Target Proximity Domain List : 00000001
[128h 0296 004h] Target Proximity Domain List : 00000002
[12Ch 0300 004h] Target Proximity Domain List : 00000003
[130h 0304 004h] Target Proximity Domain List : 00000004
[134h 0308 004h] Target Proximity Domain List : 00000005
[138h 0312 002h]                       Entry : 00C8
[13Ah 0314 002h]                       Entry : 0000
[13Ch 0316 002h]                       Entry : 0032
[13Eh 0318 002h]                       Entry : 0000
[140h 0320 002h]                       Entry : 0032
[142h 0322 002h]                       Entry : 0064
[144h 0324 002h]                       Entry : 0019
[146h 0326 002h]                       Entry : 0000
[148h 0328 002h]                       Entry : 0064
[14Ah 0330 002h]                       Entry : 0000
[14Ch 0332 002h]                       Entry : 00C8
[14Eh 0334 002h]                       Entry : 0019
[150h 0336 002h]                       Entry : 0064
[152h 0338 002h]                       Entry : 0000
[154h 0340 002h]                       Entry : 0032
[156h 0342 002h]                       Entry : 0000
[158h 0344 002h]                       Entry : 0032
[15Ah 0346 002h]                       Entry : 0064
[15Ch 0348 002h]                       Entry : 0064
[15Eh 0350 002h]                       Entry : 0000
[160h 0352 002h]                       Entry : 0032
[162h 0354 002h]                       Entry : 0000
[164h 0356 002h]                       Entry : 0032
[166h 0358 002h]                       Entry : 00C8

Note the zeros represent entries where the target node has no
memory.  These could be surpressed but it isn't 'wrong' to provide
them and it is (probably) permissible under ACPI to hotplug memory
into these nodes later.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

---
Since v6: Rebased - required data update.
---
 tests/qtest/bios-tables-test-allowed-diff.h     |   5 -----
 tests/data/acpi/x86/q35/APIC.acpihmat-generic-x | Bin 0 -> 136 bytes
 tests/data/acpi/x86/q35/CEDT.acpihmat-generic-x | Bin 0 -> 68 bytes
 tests/data/acpi/x86/q35/DSDT.acpihmat-generic-x | Bin 0 -> 12599 bytes
 tests/data/acpi/x86/q35/HMAT.acpihmat-generic-x | Bin 0 -> 360 bytes
 tests/data/acpi/x86/q35/SRAT.acpihmat-generic-x | Bin 0 -> 520 bytes
 6 files changed, 5 deletions(-)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index 3c0967078f..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,6 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/x86/q35/APIC.acpihmat-generic-x",
-"tests/data/acpi/x86/q35/CEDT.acpihmat-generic-x",
-"tests/data/acpi/x86/q35/DSDT.acpihmat-generic-x",
-"tests/data/acpi/x86/q35/HMAT.acpihmat-generic-x",
-"tests/data/acpi/x86/q35/SRAT.acpihmat-generic-x",
diff --git a/tests/data/acpi/x86/q35/APIC.acpihmat-generic-x b/tests/data/acpi/x86/q35/APIC.acpihmat-generic-x
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..317ddb3fbed94e4f49a87976fdc7f23b1a6c3fdc 100644
GIT binary patch
literal 136
zcmZ<^@O18AU|?WQaPoKd2v%^42yj*a0!E-1hz+6{7#{os(;N&85Soz@LNhUeXht58
ongjnpBoh}9gBTzdD=U!Z1+h3eVJt470*DwlH<-o3_8({j09efo0RR91

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/x86/q35/CEDT.acpihmat-generic-x b/tests/data/acpi/x86/q35/CEDT.acpihmat-generic-x
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..31c9011663639b4a0f4816f3b2b06398f94682f7 100644
GIT binary patch
literal 68
zcmZ>EbqR4{U|?Xhb@F%i2v%^42yj*a0!E-1hz+6{7!(*BfFy(s;xkNuupuM>Q<et-

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/x86/q35/DSDT.acpihmat-generic-x b/tests/data/acpi/x86/q35/DSDT.acpihmat-generic-x
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..c4ecc4fda26c5083d256ecadda8ec900d67470c6 100644
GIT binary patch
literal 12599
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
G8vh5ccNMh&

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/x86/q35/HMAT.acpihmat-generic-x b/tests/data/acpi/x86/q35/HMAT.acpihmat-generic-x
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..0e5765f6ee4c07638c70647ae145e968718b67cd 100644
GIT binary patch
literal 360
zcmeb9bqvX1WME+Ock*}k2v%^42yj*a0-z8Bhz+7)Km*7?=EKC%X^=V)XaHgs5CaPU
znNtB32dQC$vIW$k3?Kzk!wkf%P$3YX2`UEC0}=;`ae=W2gAr7W703dq;{anOBsL>h
pJ=k8L!N~R^yOS7uPXNsZ*=NL%!XOExQ-JsckOiV);t2K$1^{D&4*>uG

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/x86/q35/SRAT.acpihmat-generic-x b/tests/data/acpi/x86/q35/SRAT.acpihmat-generic-x
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..b45838adb7d304f8a36c38c90d89f3629ec48353 100644
GIT binary patch
literal 520
zcmWFzatz^MVqjn_cJg=j2v%^42yj*a0!9V~1`r!WgD@Njp!1m-QRP{gkok-naGg*F
z7hC|lI-mt$@PQeo5LF!uOc=(1(J1c3v=^ogl^*QsSQQwc;mZh&B?N$l37Y}~14zQr
eIl$Avz|hPAsstv_sKE*qfydhfm;gM0fdT+OoeTj0

literal 0
HcmV?d00001

-- 
2.43.0


