Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7986DCCD195
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 08:09:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBTuR-0000Oy-6a; Wed, 22 Oct 2025 04:09:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vBTuE-0000LO-1P
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 04:09:15 -0400
Received: from mail-westus3azlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c107::1] helo=PH8PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vBTuB-00021g-RO
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 04:09:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R5esdebqXoBROT3FrIitlGZEidPoLOeXYqhWEvmTIOZiqGIOVAKX7QplY65qAFtW63c+UuWmPHJLOZEsH5s9pjM2BgPHgjA+WqJHeSFfIqZvZU2RfUSXszF2ty7gxkf9kFYO7CbdRkpjk/z27RGlMSHlaykVcwMecrz/guGG7Z5kNCnApYltMiFCxFc5h794F6SwdlLUpHzyT/+XfCnjMzaFqkqH4gYb85rv2PDIXGksAIDkH4pu16f6G7DvKucNhLGb+dYOjCf1d6wnc6ibh+c3fVWTnUkmZU1evK0rw9NG00HSsq3Gztm80wcKtDuj5ul2CuXWjLumIWyIc6jVqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HeKLRoI/GOzcZInDgzCjka2RIHMo+M3jpFBcK8PbrkA=;
 b=NhH0Po/U+KSEUo+Jnfd+5LuYLXcx26OOuSL8i8LJJKfJId3LF1wXfV6TlADl0d7NFhK4pZBIy1kEaZModp9oqCt1ymdjHtV5k65ZNumSkHpDUtPHbywgbHH4YIu3HfoSev6DzW0a1qa4HP7JCQJaNkmCQLktc8eg/vn+11wRvYEGWWhO4+JukpNuzwf7CuyUoQmmuUKRghKOeULYUHp0P4OVkdJEZAf/b9acIIU2yw/AE9u/L0DLYvaNvPMqwAYdr9wQrZ5JXJGz7z2OZHl+/YCxhFAnzsspHP2imKKDp8Lby5cM7hXV0UA9Jz7lyJut3l+qE+sJSJHImeYr0Mha7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HeKLRoI/GOzcZInDgzCjka2RIHMo+M3jpFBcK8PbrkA=;
 b=qMGx5ICTXZBV1LFFYHL75Ou2E+3st/xLTl2yyaijxnEe/MIrOEE0+E7c/cES9rHaNqQvOB8wqKcBhf1rhIzYHVGGCT4xMCmmbsF8EXGhWPo8exaOZVMD/ngghHWJITEIs/yZ4sq2hGo/mrY902y5oD5s3p6WfgvVhNaSD4/IUzA2dBxa3JZMyDTgBXcegDhiLNsiIxAPlDsjTs4FVZ6HgsyeQqQoqq9RBVFCqEKxp6Cg9QKpvMzdajigVYCt21SbPfjcQmidCkjViWhTQrmgsiQX2HKFoJpRhqNGsVAiLJf05d4Vb878w+jpcMkpgpHR7ei7tlCbZ9XbDJDc03mgUg==
Received: from MN2PR22CA0003.namprd22.prod.outlook.com (2603:10b6:208:238::8)
 by SA0PR12MB4365.namprd12.prod.outlook.com (2603:10b6:806:96::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Wed, 22 Oct
 2025 08:09:03 +0000
Received: from MN1PEPF0000F0E5.namprd04.prod.outlook.com
 (2603:10b6:208:238:cafe::5e) by MN2PR22CA0003.outlook.office365.com
 (2603:10b6:208:238::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.17 via Frontend Transport; Wed,
 22 Oct 2025 08:09:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MN1PEPF0000F0E5.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Wed, 22 Oct 2025 08:09:03 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Wed, 22 Oct
 2025 01:08:49 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 22 Oct
 2025 01:08:41 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: <mst@redhat.com>, <imammedo@redhat.com>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>
Subject: [PATCH 3/3] tests/qtest/bios-tables-test: Update DSDT blobs after
 GPEX _DSM change
Date: Wed, 22 Oct 2025 09:06:39 +0100
Message-ID: <20251022080639.243965-4-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251022080639.243965-1-skolothumtho@nvidia.com>
References: <20251022080639.243965-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E5:EE_|SA0PR12MB4365:EE_
X-MS-Office365-Filtering-Correlation-Id: 5206c192-1355-4d77-bad2-08de114243b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: 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
 =?utf-8?Q?PXto=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 08:09:03.2702 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5206c192-1355-4d77-bad2-08de114243b2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4365
Received-SPF: permerror client-ip=2a01:111:f403:c107::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=PH8PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Update the reference DSDT blobs after GPEX _DSM change. This affects the
aarch64 'virt', riscv64 "virt", loongarch64 "virt" and the x86 'microvm'
machines.

DSDT diff is the same for all the machines/tests:

 /*
  * Intel ACPI Component Architecture
  * AML/ASL+ Disassembler version 20230628 (64-bit version)
  * Copyright (c) 2000 - 2023 Intel Corporation
  *
  * Disassembling to symbolic ASL+ operators
  *
- * Disassembly of tests/data/acpi/aarch64/virt/DSDT, Fri Oct 10 11:18:21 2025
+ * Disassembly of /tmp/aml-E6V9D3, Fri Oct 10 11:18:21 2025
  *
  * Original Table Header:
  *     Signature        "DSDT"
  *     Length           0x000014D9 (5337)
  *     Revision         0x02
- *     Checksum         0xA4
+ *     Checksum         0xA5
  *     OEM ID           "BOCHS "
  *     OEM Table ID     "BXPC    "
  *     OEM Revision     0x00000001 (1)
  *     Compiler ID      "BXPC"
  *     Compiler Version 0x00000001 (1)
  */
 DefinitionBlock ("", "DSDT", 2, "BOCHS ", "BXPC    ", 0x00000001)
 {
     Scope (\_SB)
     {
         Device (C000)
         {
             Name (_HID, "ACPI0007" /* Processor Device */)  // _HID: Hardware ID
             Name (_UID, Zero)  // _UID: Unique ID
         }

@@ -1822,33 +1822,33 @@
                 Else
                 {
                     CDW1 |= 0x04
                 }

                 Return (Arg3)
             }

             Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
             {
                 If ((Arg0 == ToUUID ("e5c937d0-3553-4d7a-9117-ea4d19c3434d") /* Device Labeling Interface */))
                 {
                     If ((Arg2 == Zero))
                     {
                         Return (Buffer (One)
                         {
-                             0x01                                             // .
+                             0x00                                             // .
                         })
                     }
                 }

                 Return (Buffer (One)
                 {
                      0x00                                             // .
                 })
             }

             Device (RES0)
             {
                 Name (_HID, "PNP0C02" /* PNP Motherboard Resources */)  // _HID: Hardware ID
                 Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                 {
                     QWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,

Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 tests/data/acpi/aarch64/virt/DSDT             | Bin 5337 -> 5337 bytes
 .../data/acpi/aarch64/virt/DSDT.acpihmatvirt  | Bin 5423 -> 5423 bytes
 tests/data/acpi/aarch64/virt/DSDT.acpipcihp   | Bin 6246 -> 6246 bytes
 .../acpi/aarch64/virt/DSDT.hpoffacpiindex     | Bin 5391 -> 5391 bytes
 tests/data/acpi/aarch64/virt/DSDT.memhp       | Bin 6698 -> 6698 bytes
 tests/data/acpi/aarch64/virt/DSDT.pxb         | Bin 7812 -> 7812 bytes
 tests/data/acpi/aarch64/virt/DSDT.smmuv3-dev  | Bin 10274 -> 10274 bytes
 .../data/acpi/aarch64/virt/DSDT.smmuv3-legacy | Bin 10274 -> 10274 bytes
 tests/data/acpi/aarch64/virt/DSDT.topology    | Bin 5539 -> 5539 bytes
 tests/data/acpi/aarch64/virt/DSDT.viot        | Bin 5354 -> 5354 bytes
 tests/data/acpi/loongarch64/virt/DSDT         | Bin 4603 -> 4603 bytes
 tests/data/acpi/loongarch64/virt/DSDT.memhp   | Bin 5824 -> 5824 bytes
 tests/data/acpi/loongarch64/virt/DSDT.numamem | Bin 4609 -> 4609 bytes
 .../data/acpi/loongarch64/virt/DSDT.topology  | Bin 4905 -> 4905 bytes
 tests/data/acpi/riscv64/virt/DSDT             | Bin 3538 -> 3538 bytes
 tests/data/acpi/x86/microvm/DSDT.pcie         | Bin 2985 -> 2985 bytes
 tests/qtest/bios-tables-test-allowed-diff.h   |  16 ----------------
 17 files changed, 16 deletions(-)

diff --git a/tests/data/acpi/aarch64/virt/DSDT b/tests/data/acpi/aarch64/virt/DSDT
index 38f01adb61e6e4704821cee5e397888bb6b7e46d..35a862e44714d26ded01d40dc147e76cc73a1c84 100644
GIT binary patch
delta 26
icmcbqc~g_iCD<k8rU(NA)6$Jx7Q&1So1KNHF#-T`5(jwz

delta 26
icmcbqc~g_iCD<k8rU(NA(~^x`7Q&2-o1KNHF#-T`3<r4t

diff --git a/tests/data/acpi/aarch64/virt/DSDT.acpihmatvirt b/tests/data/acpi/aarch64/virt/DSDT.acpihmatvirt
index 37a9af713b94a3fd34907dc86c40aaa79e93239c..7ce35f0d8606d17f3ddb9aa090c97c7ac9a38982 100644
GIT binary patch
delta 26
hcmZ3lwO)(MCD<iIUzCA?sbC{lpD-iC=9$9N7y)3m2K4{{

delta 26
hcmZ3lwO)(MCD<iIUzCA?DSsnZpD-ii=9$9N7y)3g2K4{{

diff --git a/tests/data/acpi/aarch64/virt/DSDT.acpipcihp b/tests/data/acpi/aarch64/virt/DSDT.acpipcihp
index 04427e2d8eb8d2db0a7ae3dbe546d9072406d09b..6d1765c31017dede80d1d87f8fa7c6dd055d1839 100644
GIT binary patch
delta 26
hcmaE6@XUbACD<h-O@e`esc<8gg)k$-W@lk#Rsd@^29E#$

delta 26
hcmaE6@XUbACD<h-O@e`esbC|Qg)k%IW@lk#Rsd@;29E#$

diff --git a/tests/data/acpi/aarch64/virt/DSDT.hpoffacpiindex b/tests/data/acpi/aarch64/virt/DSDT.hpoffacpiindex
index 43ab60496e5a06706d4626d9e7b58b2d7e809e75..61cce30c7471faa4a9b7e3562dcb4ab9b3519a21 100644
GIT binary patch
delta 26
hcmeCz>eu3O33dtL7iC~z^4Z8`A<W3I*;)7uBLGsg1^WO1

delta 26
hcmeCz>eu3O33dtL7iC~z^4`d0A<W3Q*;)7uBLGsa1^WO1

diff --git a/tests/data/acpi/aarch64/virt/DSDT.memhp b/tests/data/acpi/aarch64/virt/DSDT.memhp
index 3c391674446167bc9c79fd5dcb1c37e80cc7bbae..ffc5f1c0d1090582672c60ade3eb1bc41acc5ef7 100644
GIT binary patch
delta 26
hcmZ2wvdV<ZCD<iIONxPk>B>ef3t>iv&CbHl*#KgY2MquK

delta 26
hcmZ2wvdV<ZCD<iIONxPk>GDP{3t>ja&CbHl*#KgS2MquK

diff --git a/tests/data/acpi/aarch64/virt/DSDT.pxb b/tests/data/acpi/aarch64/virt/DSDT.pxb
index 71c632cedcca63a77a4cdde53d9bc392102687b6..f98dcbfc6b823bce6d5710e8056a4e260fb92a02 100644
GIT binary patch
delta 33
ncmZp%ZL#HY33dr-kz-(B65YtPONfzS^HCu#E+BP5W(y+#m9q%&

delta 33
ncmZp%ZL#HY33dr-kz-(B65hzQONfzi^HCu#E+BP5W(y+#m7oal

diff --git a/tests/data/acpi/aarch64/virt/DSDT.smmuv3-dev b/tests/data/acpi/aarch64/virt/DSDT.smmuv3-dev
index e8c2b376df7bddc2392945ea8cbb550b3d3b5e26..6c12a7aaf8a6315bac968a685f5b6673e7248817 100644
GIT binary patch
delta 55
zcmZ1!uqc4bCD<iINrQobY4t{~T|$fun~w_haPlxL5oBg$h;H&^@iCZuLC9<Ka+$51
KK*?COql^H#4-gjs

delta 55
zcmZ1!uqc4bCD<iINrQobX~jmaT|$hEn~w_haPlxN5oBg$h;H&^@iCZuLC9<Ka+$51
KK*?COql^H!*$@{1

diff --git a/tests/data/acpi/aarch64/virt/DSDT.smmuv3-legacy b/tests/data/acpi/aarch64/virt/DSDT.smmuv3-legacy
index e8c2b376df7bddc2392945ea8cbb550b3d3b5e26..6c12a7aaf8a6315bac968a685f5b6673e7248817 100644
GIT binary patch
delta 55
zcmZ1!uqc4bCD<iINrQobY4t{~T|$fun~w_haPlxL5oBg$h;H&^@iCZuLC9<Ka+$51
KK*?COql^H#4-gjs

delta 55
zcmZ1!uqc4bCD<iINrQobX~jmaT|$hEn~w_haPlxN5oBg$h;H&^@iCZuLC9<Ka+$51
KK*?COql^H!*$@{1

diff --git a/tests/data/acpi/aarch64/virt/DSDT.topology b/tests/data/acpi/aarch64/virt/DSDT.topology
index 9f22cd3dc81efe3ebcb8caf913842a8dea910627..208a3163a6bf2a59cf421418dcb16ad1156285c6 100644
GIT binary patch
delta 26
icmZ3iy;z&eCD<iou_yxr)69)rOd^a7n|Vd1F#-T#9R_9q

delta 26
icmZ3iy;z&eCD<iou_yxr(~ON=Od^bon|Vd1F#-T#7Y1ek

diff --git a/tests/data/acpi/aarch64/virt/DSDT.viot b/tests/data/acpi/aarch64/virt/DSDT.viot
index dd3775a0762ae1a5ddb89dd656d81eee581dccb6..f81e3e6cc794d77ea66b7e27b1afe56e248132b6 100644
GIT binary patch
delta 26
hcmaE*`AU<^CD<k8l?Vd^llw+43t>iv&CbHh83A%X2VVdH

delta 26
hcmaE*`AU<^CD<k8l?Vd^liNlv3t>ja&CbHh83A%R2VVdH

diff --git a/tests/data/acpi/loongarch64/virt/DSDT b/tests/data/acpi/loongarch64/virt/DSDT
index 55aa34f988d6ef69293e91c5fe45bee0a02bc5f1..09aa903c4e875f541223e36f59b28e101599df20 100644
GIT binary patch
delta 26
icmeyZ{9BpJCD<k8w;%%pW6Vab$vlh<o9FSwvH}2l69@SK

delta 26
icmeyZ{9BpJCD<k8w;%%pWAsL@$vljVo9FSwvH}2l4F~xE

diff --git a/tests/data/acpi/loongarch64/virt/DSDT.memhp b/tests/data/acpi/loongarch64/virt/DSDT.memhp
index c0955eb60448cc5f4d38d410abc260ae54ea2e9a..a069d6878fb45fa6b0e6342eedb0eb3d25eb20da 100644
GIT binary patch
delta 26
icmX@0dq9`VCD<k8fEWV<W8y}x$vlh<o9FQ;aRC5qod+-g

delta 26
icmX@0dq9`VCD<k8fEWV<W5PzR$vljVo9FQ;aRC5qmj^Ha

diff --git a/tests/data/acpi/loongarch64/virt/DSDT.numamem b/tests/data/acpi/loongarch64/virt/DSDT.numamem
index 61e47e7252155dcf9c76879c4f60f4b3eef63f86..78ece52f57a383db128c7d1a08526e15ab911bb7 100644
GIT binary patch
delta 26
hcmZovX;k5I33dr#6k=dte7=!uG7lre=6O8HtN>Vb2A==`

delta 26
hcmZovX;k5I33dr#6k=dte72EmG7lr;=6O8HtN>VV2A==`

diff --git a/tests/data/acpi/loongarch64/virt/DSDT.topology b/tests/data/acpi/loongarch64/virt/DSDT.topology
index b2afebc938ce45d798c8aa5f45a463f1617e257e..7ab23f47cc82dd7bc1975e17893a8cd61039e66d 100644
GIT binary patch
delta 26
icmZ3fwo;ADCD<iIQ<#B)@%%=v$vlh<o9FR#vjG5Njt4CO

delta 26
icmZ3fwo;ADCD<iIQ<#B)@!UqP$vljVo9FR#vjG5NhzBhI

diff --git a/tests/data/acpi/riscv64/virt/DSDT b/tests/data/acpi/riscv64/virt/DSDT
index 527f239dab13a00ad42e5a70b8dc2b89f12aa84a..968e1a15c87bb5753b3a84ddb357e26312767220 100644
GIT binary patch
delta 25
gcmca4eMy?jCD<k85-$S-lj=sUVqQju$#uLT0Ac+G$N&HU

delta 25
gcmca4eMy?jCD<k85-$S-lgdV}VqQkZ$#uLT0AcqA$N&HU

diff --git a/tests/data/acpi/x86/microvm/DSDT.pcie b/tests/data/acpi/x86/microvm/DSDT.pcie
index ba258f454dc0e59ef2fd67e0ce37e270e7c122e8..b646a05551c1ed902413a462442346ce246f8675 100644
GIT binary patch
delta 25
gcmZ1}zEYgaCD<ioB{u^D(~pf@mfVaClU=w|0bO|puK)l5

delta 25
gcmZ1}zEYgaCD<ioB{u^D)Ax;BmfVbtlU=w|0bO$juK)l5

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index e2fce2e972..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,17 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/aarch64/virt/DSDT",
-"tests/data/acpi/aarch64/virt/DSDT.acpihmatvirt",
-"tests/data/acpi/aarch64/virt/DSDT.memhp",
-"tests/data/acpi/aarch64/virt/DSDT.pxb",
-"tests/data/acpi/aarch64/virt/DSDT.topology",
-"tests/data/acpi/aarch64/virt/DSDT.acpipcihp",
-"tests/data/acpi/aarch64/virt/DSDT.hpoffacpiindex",
-"tests/data/acpi/aarch64/virt/DSDT.viot",
-"tests/data/acpi/aarch64/virt/DSDT.smmuv3-legacy",
-"tests/data/acpi/aarch64/virt/DSDT.smmuv3-dev",
-"tests/data/acpi/riscv64/virt/DSDT",
-"tests/data/acpi/loongarch64/virt/DSDT",
-"tests/data/acpi/loongarch64/virt/DSDT.topology",
-"tests/data/acpi/loongarch64/virt/DSDT.numamem",
-"tests/data/acpi/loongarch64/virt/DSDT.memhp",
-"tests/data/acpi/x86/microvm/DSDT.pcie",
-- 
2.43.0


