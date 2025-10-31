Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCC7BCCFA03
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 11:04:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEmoL-0000hr-CN; Fri, 31 Oct 2025 06:56:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vEmmV-0006IM-8j; Fri, 31 Oct 2025 06:54:56 -0400
Received: from mail-eastus2azlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c110::1] helo=BN1PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vEmmK-00032w-Ki; Fri, 31 Oct 2025 06:54:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L4+giRZ5L4btU7OPXNeQ70Lei4Bdgf6UWv7sP3OEhjtgpRxDP95tg/AP0AC85m9opAfn+5toQH6hSJH0CLFODagZX+E6Juw5DWzHvDKNJkO9Lx29hedZQJiR33Oij3uo6tbxQbh5OAa8c+GoZu4hXP7TP7CkGqE9N4Pay2gKVdLt3ganSGAMeHBXOeZ3B3i1bRGc+QgOamLIKNurZKzmkdFgwarFHzHyyOVA6oCCVim862zlmMNKKXXKUj6CxjFSvI516KrxmXgj480e/dasurA4Kb3VGn2AC77WGWMoXxguEGN9ttpphMfKzDkOcV9jv5OmRAVz5XdYerlIEnGh0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qaScdJr3eH2L7EPTd/PvjT91oOc9w27F4/RJzlgAEcc=;
 b=cnMFrFJnq820dYOwCzf26PybwJsE26S+WidGdBtyZCvO/q1e/aJN5aHEIfHmQ9beQsPIu1C86wZEeEqJWwLswtWr6tbksXyRmQcyUokZ+jBqBOiAKSo83iEDanaNh4Qs6umxemToUMZPexJ8QJspk/65n4KS/023nQGcdxztq8L0zAWHAAXHAhbfqTFmFCyGU9U6LockCVhvKXipt4O1nLF5OcseTg4zBqZc5SRgZKxQMKphL4ZS1KILMaNhFrY3KzJm4k5XJDmPCfluuHb9eQYkL6zRsLRIoZAVmrgiFMLKGCTcwZVESZ4imPb9nVySGDYYpQUYT/geY8d1Jp3rBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qaScdJr3eH2L7EPTd/PvjT91oOc9w27F4/RJzlgAEcc=;
 b=UueM2ePr0w99Av70EaCX6gmK3RfoZfmBdFuYeUFTp8p0E6nMyMiufvEsNsuUUPulZIQ4KPYdDZhQ0pipR23IYUJ6NvB/g3JOUSTe4DlkugmD2gwTu9DmmnCJAoGUI+hYL0NW+laoohCCezNooCYDS/5R1mDQpEr2N/rlehjHM6VTejpaKRsa960AbqLejdOsFtDALN/dKDsN3DUDci6vTUnd2N3iY9EDVoVdWe5xiKqWooavFU2c6wsoCo/NQVDgIUQxzp1x7M82sC4RHzwgVSNBhU+m2wWKKwL3FY0x2cDn7wtHqUg5kjW5PfduiiPwW7o4k47GUwvigdV6Wt84hQ==
Received: from MN0PR03CA0011.namprd03.prod.outlook.com (2603:10b6:208:52f::13)
 by CY5PR12MB6347.namprd12.prod.outlook.com (2603:10b6:930:20::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Fri, 31 Oct
 2025 10:54:33 +0000
Received: from BL02EPF0001A0FD.namprd03.prod.outlook.com
 (2603:10b6:208:52f:cafe::7e) by MN0PR03CA0011.outlook.office365.com
 (2603:10b6:208:52f::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.15 via Frontend Transport; Fri,
 31 Oct 2025 10:54:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A0FD.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Fri, 31 Oct 2025 10:54:33 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 31 Oct
 2025 03:54:24 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 31 Oct
 2025 03:54:21 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <kjaju@nvidia.com>
Subject: [PATCH v5 24/32] tests/qtest/bios-tables-test: Update IORT blobs
 after revision upgrade
Date: Fri, 31 Oct 2025 10:49:57 +0000
Message-ID: <20251031105005.24618-25-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251031105005.24618-1-skolothumtho@nvidia.com>
References: <20251031105005.24618-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FD:EE_|CY5PR12MB6347:EE_
X-MS-Office365-Filtering-Correlation-Id: e93bc0a7-78c1-43a1-42fc-08de186be059
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|7416014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VVk1CuxutBHHzdKrrFI6xMm0rFw2qe3Pdkk5lmBZOm7qWwBG97+USRbQtpxk?=
 =?us-ascii?Q?vIdNICSSLwGxtWxpl3h1BVWizdkgixrblFT9hq9+Lu/DDLDqg25vbxvFvYcD?=
 =?us-ascii?Q?NieBYKxFvM1N5bdCdvMJu3VLUsSXYtCuUoCvT+H9eomDiLu46/BGmpPfmcTv?=
 =?us-ascii?Q?HyKibopbLXnKZWerxkdyV+uSwgbTBdm4uKpbbHFUO45cZARASp3HynvDbn8m?=
 =?us-ascii?Q?NUqkqKl3nS3wnwiB9ckksNjUJ5gM+0CPxKGGEb+ZVWPqvQXRhbBpW8xMZB4w?=
 =?us-ascii?Q?KTfpK5npIBrDo4yn+h223JVsKzsPiXEO5vBoldSWXwJfbDcgu+qzqgxU0VHi?=
 =?us-ascii?Q?z8H1CYNMtRaj7DE2eAiS5zpBp8Jm+c0TM6uVVWGxKvemWp4IdqWu5b2ocvRb?=
 =?us-ascii?Q?12cJunJpvab1VrECCY5cuCjwjcRLfVidZNddUBlcXxYui1uVBUjjsdsiMMJk?=
 =?us-ascii?Q?Y8BWwtUT7mo6L+JatNoYEDT7/45ku6rhe2qL2FcLQyIX5nGT/a8yxHP4LLLi?=
 =?us-ascii?Q?RMq8raqRuFE+feadbXa2G7+wuH2/DbRppDSmE56Jmu8KlnJVUIolS55LJvE/?=
 =?us-ascii?Q?Nh2Bz1glZcEgJApTZ2t+LAwnOpJz8pWb2IlsaMnJgcCI9KY7jjzG3kY/4q7T?=
 =?us-ascii?Q?m1AaL28GCCZJ1deDQkjQGv972DeTB+fQTkIDOhfYQHpgCyXvA27pumghhFyK?=
 =?us-ascii?Q?aEmnWyZ0zPiMhrxtHYxEkJA+j8gTu4pS/fpEnhjQWejR/Dmyb2qIc4+19c8C?=
 =?us-ascii?Q?maodp0e7Hrrnhfy+ThWr0LS2DF7kBTSGvupk1U8Ho1Ld50qrlGTSe9gVFe6p?=
 =?us-ascii?Q?2isnlHScSCEdx92opcvlQwybM/RB0QGrFYH+XUvHL7UNQmvPbf/rVGhDRc8V?=
 =?us-ascii?Q?kN1eNALt0+9SQYTAxV0oNI5o+gN3oMaJlqETOrj3ddOp5RV26X64Nx9WwXkv?=
 =?us-ascii?Q?Ub5kGu8VaQefEjAo/eLWYnTgOen0fRlS8KG6VjBcsyqk4Ws1JBg5FN/iUNFK?=
 =?us-ascii?Q?aYE3umw5mTPf6JooXTmOekT2321p8v7BEWQF2Y6P6Mlpu/Wror6S0RDIx3A/?=
 =?us-ascii?Q?JiLgeVRiMBlexWW65+dMe3fzf3lB6p7f4FG/MMBqaXCQ/bJCnGnhMb0a6u7v?=
 =?us-ascii?Q?dhpgXNmaMoOI1HDynvPvFrlziYE3hosppJDF3h4vaHHRpFyo5i4Tvoim4h+U?=
 =?us-ascii?Q?0pzg/3QtraljBc5cP9X1m/66AJiN74bkqmUOXr10Hw2NU3+AC4yxRXF2wBq0?=
 =?us-ascii?Q?urImxuZlidwZtQCeE3xRWPzOvefwIAT542dvsb9ijgqj/KOZQkSujUVl9c/0?=
 =?us-ascii?Q?oKXpscdpP2G1M0J7EuBlC/YnMHKjVJByH3lgNCmUjuhcsRe3FZDaOz0Exbzz?=
 =?us-ascii?Q?UE00JgYzefDxg9tq7UXi74p4WYDRj6VG+yHPrBg67EWUO0tHChodfALXXQXW?=
 =?us-ascii?Q?Q+edcGtkaLK/LysmxlsGpf1qlAYYkRwq38T3N8vsS2KThP46WKA44ZBYKfDn?=
 =?us-ascii?Q?GIw6+7g/g45ggVqaLj9JV65YEjkVpYdvtksgcQdv9HQrT7I5wUFHhh66H1PS?=
 =?us-ascii?Q?XZiP+aA3851knF+qtuw=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 10:54:33.5987 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e93bc0a7-78c1-43a1-42fc-08de186be059
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6347
Received-SPF: permerror client-ip=2a01:111:f403:c110::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=BN1PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

Update the reference IORT blobs after revision upgrade for RMR node
support. This affects the aarch64 'virt' IORT tests.

IORT diff is the same for all the tests:

 /*
  * Intel ACPI Component Architecture
  * AML/ASL+ Disassembler version 20230628 (64-bit version)
  * Copyright (c) 2000 - 2023 Intel Corporation
  *
- * Disassembly of tests/data/acpi/aarch64/virt/IORT, Mon Oct 20 14:42:41 2025
+ * Disassembly of /tmp/aml-B4ZRE3, Mon Oct 20 14:42:41 2025
  *
  * ACPI Data Table [IORT]
  *
  * Format: [HexOffset DecimalOffset ByteLength]  FieldName : FieldValue (in hex)
  */

 [000h 0000 004h]                   Signature : "IORT"    [IO Remapping Table]
 [004h 0004 004h]                Table Length : 00000080
-[008h 0008 001h]                    Revision : 03
-[009h 0009 001h]                    Checksum : B3
+[008h 0008 001h]                    Revision : 05
+[009h 0009 001h]                    Checksum : B1
 [00Ah 0010 006h]                      Oem ID : "BOCHS "
 [010h 0016 008h]                Oem Table ID : "BXPC    "
 [018h 0024 004h]                Oem Revision : 00000001
 [01Ch 0028 004h]             Asl Compiler ID : "BXPC"
 [020h 0032 004h]       Asl Compiler Revision : 00000001
 ...

Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 tests/data/acpi/aarch64/virt/IORT               | Bin 128 -> 128 bytes
 tests/data/acpi/aarch64/virt/IORT.its_off       | Bin 172 -> 172 bytes
 tests/data/acpi/aarch64/virt/IORT.smmuv3-dev    | Bin 364 -> 364 bytes
 tests/data/acpi/aarch64/virt/IORT.smmuv3-legacy | Bin 276 -> 276 bytes
 tests/qtest/bios-tables-test-allowed-diff.h     |   4 ----
 5 files changed, 4 deletions(-)

diff --git a/tests/data/acpi/aarch64/virt/IORT b/tests/data/acpi/aarch64/virt/IORT
index 7efd0ce8a6b3928efa7e1373f688ab4c5f50543b..a234aae4c2d04668d34313836d32ca20e19c0880 100644
GIT binary patch
delta 18
ZcmZo*Y+&T_^bZPYU|?Wi-8hk}3;-#Q1d;#%

delta 18
ZcmZo*Y+&T_^bZPYU|?Wi-aL`33;-#O1d;#%

diff --git a/tests/data/acpi/aarch64/virt/IORT.its_off b/tests/data/acpi/aarch64/virt/IORT.its_off
index c10da4e61dd00e7eb062558a2735d49ca0b20620..0cf52b52f671637bf4dbc9e0fc80c3c73d0b01d3 100644
GIT binary patch
delta 18
ZcmZ3(xQ3C-(?2L=4FdxM>(q%{ivTdM1ttIh

delta 18
ZcmZ3(xQ3C-(?2L=4FdxM^Yn>aivTdK1ttIh

diff --git a/tests/data/acpi/aarch64/virt/IORT.smmuv3-dev b/tests/data/acpi/aarch64/virt/IORT.smmuv3-dev
index 67be268f62afbf2d9459540984da5e9340afdaaa..43a15fe2bf6cc650ffcbceff86919ea892928c0e 100644
GIT binary patch
delta 19
acmaFE^oEJc(?2LAhmnDS^~6T5Bt`%|fCYU3

delta 19
acmaFE^oEJc(?2LAhmnDS`P4?PBt`%|eg%C1

diff --git a/tests/data/acpi/aarch64/virt/IORT.smmuv3-legacy b/tests/data/acpi/aarch64/virt/IORT.smmuv3-legacy
index 41981a449fc306b80cccd87ddec3c593a8d72c07..5779d0e225a62b9cd70bebbacb7fd1e519c9e3c4 100644
GIT binary patch
delta 19
acmbQjG=+)F(?2Lggpq-P)oUXc7b5^FiUXej

delta 19
acmbQjG=+)F(?2Lggpq-P*=Hjc7b5^Fhy$Mh

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index 3279638ad0..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,5 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/aarch64/virt/IORT",
-"tests/data/acpi/aarch64/virt/IORT.its_off",
-"tests/data/acpi/aarch64/virt/IORT.smmuv3-legacy",
-"tests/data/acpi/aarch64/virt/IORT.smmuv3-dev",
-- 
2.43.0


