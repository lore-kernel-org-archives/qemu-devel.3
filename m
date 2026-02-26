Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44E00FC592B
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 10:54:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvZ0B-0007au-N5; Thu, 26 Feb 2026 05:53:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vvZ0A-0007a5-H6; Thu, 26 Feb 2026 05:53:50 -0500
Received: from mail-westus2azlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c007::2] helo=MW6PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vvZ08-00015y-Ts; Thu, 26 Feb 2026 05:53:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oO8Qhf45hoKM8O+d/nRlMEhNp2O+OOFSTT4WfV0xPv3k24XShtEbhyFS+Hau69qMbHM9qvTcFj0mfQXUmr0yDFTndrSZeYw/C1BdusJludc9fWnt1ZbeEWFzqRS5QPAuMdM+ga1nie/eBnwwRxUE8xk445XWe9arHjcUI5WNiiNSSqDrA7h9ncy0nYrVQB3J8g8SvaPmMhp+t+L8Tzlg+dW296asSuDDb4lneJwzL5eEO8821syHhBPaKDMHnaMOpPYEhLTpDWKKMxF8ojo3ayI+x3Ir8hTHItk6vvcTKT+4NOYitcMQZlCStcjVDDK21PL/IQx9A0+2UXimTgo5xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZPO3285NFZW58Qfr2Ufe7ruqPU+jqaG8EJNayzxmPpg=;
 b=fifVfLXDW7BQO4bwD9xGt9LE5GTsBqpMxA6Q8a32rBwQ4+Im9t+gPx9nBXlL/W0TS3bwH1QwTXGyFCVNyL8S7QzMKqw70nDmwMjOXMu30wHOcYTffWNVqXJFq040nx3IW+yM6wzc8SS9PxwnAWr1X2a7W1NLOi9tqeU9VROP6jT0mBLp6GuEVgqCI/PSYtrUC88LF6eUxP0L1g+E65J076/AjDx5x/TQ6CAnZCGI8Z9TwBFvOPVxP8QA7vjdcT5NH2ROEGdIL3UeTMRXG6Qc+LtxbqX4RAnaUJ440gU1BC7xYyICG9VozsnJzdBgRLxKrAXvqdir3shN15r3fN/AJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZPO3285NFZW58Qfr2Ufe7ruqPU+jqaG8EJNayzxmPpg=;
 b=jF7dLSZB8uPTgjqvPp+1Uy2ABQc7Lm4b10Pwv1pEVSCrAw3ZOn9dX7wTqJqHjLxgfgTdN09NM3ZrC6SNoXWQUnnh+aNpIhjzAnR8f3jk7cu5m1BmOx5EZCLUO7jwcRDhIVB5EBhXteLWsMA9SLNXQRjYz+6e4z4ul9gzmr4NkuSmdyrJJhMvtjLIQSLL9QgqcEu61hVRoaqYBvOmELVAciGqSqbYHFlf1YhcsvFixWj73I0TVRIiVB0QXIbBvag/hFgstXZw02cFrrCCsEtFh4+WfiN2seC0/C67LFF2Ri2QItpdaXv4ux03aFWjKgFKuUt8B085C/BWXXHMABp3Ag==
Received: from DS7PR03CA0041.namprd03.prod.outlook.com (2603:10b6:5:3b5::16)
 by DS0PR12MB7771.namprd12.prod.outlook.com (2603:10b6:8:138::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Thu, 26 Feb
 2026 10:53:42 +0000
Received: from DM2PEPF00003FC7.namprd04.prod.outlook.com
 (2603:10b6:5:3b5:cafe::cd) by DS7PR03CA0041.outlook.office365.com
 (2603:10b6:5:3b5::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.22 via Frontend Transport; Thu,
 26 Feb 2026 10:53:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM2PEPF00003FC7.mail.protection.outlook.com (10.167.23.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 26 Feb 2026 10:53:42 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 02:53:20 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 02:53:16 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v3 29/32] tests/qtest/bios-tables-test: Update IORT blobs for
 SMMUv3 identifier change
Date: Thu, 26 Feb 2026 10:50:53 +0000
Message-ID: <20260226105056.897-30-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260226105056.897-1-skolothumtho@nvidia.com>
References: <20260226105056.897-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC7:EE_|DS0PR12MB7771:EE_
X-MS-Office365-Filtering-Correlation-Id: b37a069d-264e-498e-85b0-08de75254e7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|7416014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: ES4n1Msm4eFRsYbBMhWZlHbv2HpMPwh1rQvsRxi5chSqrFxCzVIVcCWQiyqi7kncFKR9TFrQqwgT7YGu9TmmXYmwULvxV7RkF7gCyO/dBiIaM6cVOd5MZO6AVQX58MjR5nf9RJi2YbCw9ar4EQvN3DN5YOMKuz05w1ZSaDNjrWJ20Pj8vQjMChMToIYHSFJacCgkr0extc4Q7BYQwuhCpsnhj+zlnBq3lhsJNEE/YCWvaq7Vq3/LRGvilrYimk1lh6dzU7FsrL/9bCyjVJ40gnQclJKRSY9TvvTR/HkIPJZCeRif9dywKvGAFC9uM+mo+2VSxvvl1Xbh5ohui/KRrVlejTP8/S0NtVdY9aobZJ2jvaJqu3ZkOl5R/bLrg4MDIvjtKai+K3j8CzYEXzThVZMstOCvwAJlAn8/931Yz0V3eTnkfcpwUVWxlWmsjwBS94MdLcbegVgI9zsAbNw3wHrbVLWttf6BGE69iSwm3gl7aC8GHq0cI57ZUM1iOmKeWZA0jKBPBRFDMF6HuSfCHpUQ0SSg81hh5jrCrM/V2VPWSE9pz947SyFHew1Gdt59SKWHEdJgYLUNCjpj49aQ2StkDH6fHF/lUijo2Ya3JzTZ8vPB+OyjeS6lmh2xOg0wHdrrmBce9yt58S3GjGAP+E3JdxxswHdEKToGUtC7w2MDAavvGrrOnOtR4lNGLjEIDJLkamx00aS9RanL7fJXF/FP9ONM/QyCi6Qi1DCl0IB5o0DpJD2cCw7Xybmcy4agOLLPElExUrjvTOSSMSNFPsEPUw/+Mq6epuSLVp1zjH+7Ba4pNBatj503tkvouacVDREkuGeDyc9ymm9EURHWPg==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: by4TODZtJvu5C+Mj5r5d4tN2P8bqt0LSNJGEx0bf5Rm1t5Pl+jUHTL54JVNYuBDfF7NWHuc1hk0o+/ZL2u0nbXdimSwebsqxT6sEKNOf32Ddb1SqjtWcpeR5GdzVpepsb0ejRwRh8bOQQgOyvf/N0rzV5eHezwt/1zUpv8Lvk5oVbDqkJM5D5scYE6+08QRoD2/aSKakoFBp1XKE0zG3XPNZBMSVma9Jsj/HyJYH0t274/Jeauv1xzufQWR3VAOFUDfYPNSkVVxFMGrUamk1OVo5e62BaWDtcAdcFUyXMFn7cB9puKU6e2UuUbDjKyjxc2Bxj9x05tVXVIPihsPLDibosb0r45e6HhgTWB5YaABaAdDXUdJVjm4E5GKKO4pVxLqwONsP1ppMwezbscrFTuDkc7s3S01Nt66lVf7agunfhEViJbP/M9n1DCnsnY1Y
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 10:53:42.1019 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b37a069d-264e-498e-85b0-08de75254e7e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM2PEPF00003FC7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7771
Received-SPF: permerror client-ip=2a01:111:f403:c007::2;
 envelope-from=skolothumtho@nvidia.com;
 helo=MW6PR02CU001.outbound.protection.outlook.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Update the reference IORT blobs after identifier change for SMMUv3 nodes.
This affects the aarch64 'virt' IORT tests.

IORT diff is the identifier change in SMMUv3 nodes:

 /*
  * Intel ACPI Component Architecture
  * AML/ASL+ Disassembler version 20230628 (64-bit version)
  * Copyright (c) 2000 - 2023 Intel Corporation
  *
- * Disassembly of tests/data/acpi/aarch64/virt/IORT.its_off, Wed Feb 25 16:36:44 2026
+ * Disassembly of /tmp/aml-KVO1K3, Wed Feb 25 16:36:44 2026
  *
  * ACPI Data Table [IORT]
  *
  * Format: [HexOffset DecimalOffset ByteLength]  FieldName : FieldValue (in hex)
  */

 [000h 0000 004h]                   Signature : "IORT"    [IO Remapping Table]
 [004h 0004 004h]                Table Length : 000000AC
 [008h 0008 001h]                    Revision : 05
-[009h 0009 001h]                    Checksum : 95
+[009h 0009 001h]                    Checksum : 96
 [00Ah 0010 006h]                      Oem ID : "BOCHS "
 [010h 0016 008h]                Oem Table ID : "BXPC    "
 [018h 0024 004h]                Oem Revision : 00000001
 [01Ch 0028 004h]             Asl Compiler ID : "BXPC"
 [020h 0032 004h]       Asl Compiler Revision : 00000001

 [024h 0036 004h]                  Node Count : 00000002
 [028h 0040 004h]                 Node Offset : 00000030
 [02Ch 0044 004h]                    Reserved : 00000000
...

 [074h 0116 001h]                        Type : 02
 [075h 0117 002h]                      Length : 0038
 [077h 0119 001h]                    Revision : 03
-[078h 0120 004h]                  Identifier : 00000001
+[078h 0120 004h]                  Identifier : 00000000
 [07Ch 0124 004h]               Mapping Count : 00000001
 [080h 0128 004h]              Mapping Offset : 00000024

 [084h 0132 008h]           Memory Properties : [IORT Memory Access Properties]
 [084h 0132 004h]             Cache Coherency : 00000001
 [088h 0136 001h]       Hints (decoded below) : 00
                                    Transient : 0
                               Write Allocate : 0
                                Read Allocate : 0
                                     Override : 0
 [089h 0137 002h]                    Reserved : 0000
 [08Bh 0139 001h] Memory Flags (decoded below) : 03
                                    Coherency : 1
                             Device Attribute : 1
 [08Ch 0140 004h]               ATS Attribute : 00000000
 [090h 0144 004h]          PCI Segment Number : 00000000
 [094h 0148 001h]           Memory Size Limit : 40
 [095h 0149 002h]          PASID Capabilities : 0000
 [097h 0151 001h]                    Reserved : 00

 [098h 0152 004h]                  Input base : 00000000
 [09Ch 0156 004h]                    ID Count : 000000FF
 [0wA0h 0160 004h]                 Output Base : 00000000
 [0A4h 0164 004h]            Output Reference : 00000030
 [0A8h 0168 004h]       Flags (decoded below) : 00000000
                               Single Mapping : 0

...

Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h     |   4 ----
 tests/data/acpi/aarch64/virt/IORT.its_off       | Bin 172 -> 172 bytes
 tests/data/acpi/aarch64/virt/IORT.msi_gicv2m    | Bin 172 -> 172 bytes
 tests/data/acpi/aarch64/virt/IORT.smmuv3-dev    | Bin 260 -> 260 bytes
 tests/data/acpi/aarch64/virt/IORT.smmuv3-legacy | Bin 192 -> 192 bytes
 5 files changed, 4 deletions(-)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index df5fe417c0..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,5 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/aarch64/virt/IORT.its_off",
-"tests/data/acpi/aarch64/virt/IORT.msi_gicv2m",
-"tests/data/acpi/aarch64/virt/IORT.smmuv3-legacy",
-"tests/data/acpi/aarch64/virt/IORT.smmuv3-dev",
diff --git a/tests/data/acpi/aarch64/virt/IORT.its_off b/tests/data/acpi/aarch64/virt/IORT.its_off
index 0cf52b52f671637bf4dbc9e0fc80c3c73d0b01d3..295dc381063fa4c415a933c5c690ca0fc8ffd6dc 100644
GIT binary patch
delta 23
ecmZ3(xQ3C-(?2L=4FdxM>$Hhnd5jDbD~$n68wN1|

delta 23
ecmZ3(xQ3C-(?2L=4FdxM>(q%{d5nw`D~$n676vf@

diff --git a/tests/data/acpi/aarch64/virt/IORT.msi_gicv2m b/tests/data/acpi/aarch64/virt/IORT.msi_gicv2m
index 0cf52b52f671637bf4dbc9e0fc80c3c73d0b01d3..295dc381063fa4c415a933c5c690ca0fc8ffd6dc 100644
GIT binary patch
delta 23
ecmZ3(xQ3C-(?2L=4FdxM>$Hhnd5jDbD~$n68wN1|

delta 23
ecmZ3(xQ3C-(?2L=4FdxM>(q%{d5nw`D~$n676vf@

diff --git a/tests/data/acpi/aarch64/virt/IORT.smmuv3-dev b/tests/data/acpi/aarch64/virt/IORT.smmuv3-dev
index 60cfed1361976ef26b280c11ba2e233f1cfd9383..12f3e0f01864acf24fc86d4cde2de561aa92f878 100644
GIT binary patch
delta 23
ecmZo+YGLB?^bZPQVPs%n^`6MJiIHLAUUvXH(*=zH

delta 23
ecmZo+YGLB?^bZPQVPs%n^_<AHiIHjIUUvXH$pwu7

diff --git a/tests/data/acpi/aarch64/virt/IORT.smmuv3-legacy b/tests/data/acpi/aarch64/virt/IORT.smmuv3-legacy
index e2de4049f044bdfe5b3e656b94282ddf17832d9f..f940b696af2abcbb3b46fcc865acde7456aa3389 100644
GIT binary patch
delta 23
ecmX@Wcz}`1(?2NW00RR9tL#LsJVu6zmF@scb_NIl

delta 23
ecmX@Wcz}`1(?2NW00RR9tIR~MJVwTemF@scaRvwg

-- 
2.43.0


