Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28ECBCF8859
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 13:29:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vM4fL-000153-KP; Thu, 20 Nov 2025 08:25:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vM4fE-0000ip-EB; Thu, 20 Nov 2025 08:25:32 -0500
Received: from mail-northcentralusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c105::1] helo=CH1PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vM4fC-0002dA-Py; Thu, 20 Nov 2025 08:25:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aMfurFsBRK18CjXQq6aPdc8pKRtfGVMx7ecZ9qQsf7uk6W+AbUFtDJX79LV/yskC/+wu4MXVCqXZf9O0VGtq27T8UZfA9uGmrzNfSsL9vw0daMdoQMo849pYzS6vZlWlIdRgOZQXQ18l3songYe2guIij6KtbFELZKN/6wcwOfCprYlEjGIowWFC/n+M0R8Z2BeoNzymgueKrG+FQGsWpAbBC623y1GS0k920iKe7o+7EFXbaDg3Zxaa1Quoy+0XUNEXE9MxdXn4dobCYhcDlRilPnOiThQuRABwcUK/AexaMg7m11F/sv282JK1X41VeZ7Ho+lYPsxobjXI+oLFGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uH2twHtJr7H2dW6oDKHOrxZhJ8DuCogXU2858oBv8JU=;
 b=bemRhupIu8VdAb/PFtP1NgyMb/lmbIrKhPw2PWln2S6LcLeh56uQztHCZCpT4Dpv4sHUrEqYR2googAnyi1J0d6IUs+EW/HGXsdd7bpES96I7TvBQ4mO/ppmxWDccqVfRTm/vdvLoOImIsRX3f2RaY36nckK6OFPF3r9gldAUIaAnFV3F05EAzr2YLL179oOIR9/4/zM6KRt1Ab7sqXghmFbd/bfyr5FpBCE7oaMynd3Gr6i/pbZfcR7N+6/4qTuiwi1KUg1tLkMEFAFYHRsnxnhejyHjV/niLzyRiXv/bDqngkJTvSX5SFd80lRDmCIY842FUZOmhODxQslAXs7ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uH2twHtJr7H2dW6oDKHOrxZhJ8DuCogXU2858oBv8JU=;
 b=SjMuWN3i8dlarvpqoGvl3dsJb/gBmXdBl4euxOIUFRde0nO3x8AA1E3c41snebK/OrcNzTCZQ/9vnzte7CwoYq36XqrFgbfdlijIJk+LEMRQgZzwmr8p1jgrEZMVG/TUgR7OOcFvFErD5CzuqRFoE1vwwZWjp/x0CAtoUP3ahf2VERZIRmeZP9/nVG7ytHAQl28ZrS4CRTa02/m+RFiaCJj3VHLbvcel9x8vEjhK+3tjlnBii3Ly0nG+cMCHeEgwIgKa4tJ1rnsNnI+zeHlEYaBM8A6PUzXnj9XkvWhKZm4y907yj7da3x+gqVrWNwT/mURkXQW2XRHuLF65QwRa1w==
Received: from BYAPR07CA0037.namprd07.prod.outlook.com (2603:10b6:a03:60::14)
 by MN2PR12MB4080.namprd12.prod.outlook.com (2603:10b6:208:1d9::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Thu, 20 Nov
 2025 13:25:24 +0000
Received: from MWH0EPF000971E6.namprd02.prod.outlook.com
 (2603:10b6:a03:60:cafe::64) by BYAPR07CA0037.outlook.office365.com
 (2603:10b6:a03:60::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Thu,
 20 Nov 2025 13:25:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000971E6.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 13:25:24 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 05:25:06 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 05:25:03 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <kjaju@nvidia.com>
Subject: [PATCH v6 25/33] tests/qtest/bios-tables-test: Update IORT blobs
 after revision upgrade
Date: Thu, 20 Nov 2025 13:22:05 +0000
Message-ID: <20251120132213.56581-26-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251120132213.56581-1-skolothumtho@nvidia.com>
References: <20251120132213.56581-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E6:EE_|MN2PR12MB4080:EE_
X-MS-Office365-Filtering-Correlation-Id: c03b0ccf-f6aa-498a-374e-08de28384317
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|7416014|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tNk8wk2VQQOs8CE/TCidJ++dAK5BHN2F/Gn0nDyqRCtaYQdVmj++bhRsh97W?=
 =?us-ascii?Q?gJveY4ILO1wQHJd2eCljTznpG6O3mlIozAIdvOEpuBaBgU3a7QiBJolkje8x?=
 =?us-ascii?Q?QbfK9mjh4ldpbwIiih+mdGmx+ZQiKcOSPz34bQTQ8I0zBg+z/xpQ0sh/pMww?=
 =?us-ascii?Q?iRFiUev6suuBKVmgKRlqpdOZlXA0De3OG5yJ9KawFXr48Wgc5mzYyxAZlNMV?=
 =?us-ascii?Q?BWN/FNiDvBF095k6r+iiGjV/gHjXWXke8gYr0obUz18271fb1gyU7XcH0fTr?=
 =?us-ascii?Q?kiGQ0FP5xn6M8mKxj3DhPkJ1ogQCistb7nXeoTEZSZTv9QjaySE2I8vWjEKV?=
 =?us-ascii?Q?7iZbrxl+ZbIK9af1yKouCPUn3bnUMqpqrIhIS5Uu5T+MZkVy6E4wuGEv/br+?=
 =?us-ascii?Q?NeV6LtMUKPON9c453ic5yOjFq7djfS5IYz1vrwGuYxB3ea49d9LtQe2SPnbK?=
 =?us-ascii?Q?qWuqaLr2dTgMl0n6Yp2GOz8jhD7bfsuqcZBwztT81JOmVXnHt8CYek9TlfUh?=
 =?us-ascii?Q?Sn/iWKdmxZFIqD0t8Zjb4ixGcqjyVuyLd4fco/+qufy1FMtJv2oTQzFSM8D8?=
 =?us-ascii?Q?pAhvbRnY0qzvsDteKMT4ZKeVrKQZJo0/oToj0dJYgN6x/B0NpH/uCQO1IIIk?=
 =?us-ascii?Q?ZG/SmusfeJp995LPW3TN3SoXVar4gy/fo3gjbh7TiZlicHN/Q/37MQzgSUNF?=
 =?us-ascii?Q?/c5qruDWicBFukBJxC3KhxVzk+NBXRVYybvEeGvFRDeFhuYlrriycNySrnxq?=
 =?us-ascii?Q?IiaUHIOQG1g9NXXY2y01aPGFDCyyV84ipn3MluWIxwjezHmwZ+TkHACjN1UV?=
 =?us-ascii?Q?jUG1JLP3PPPZl/2dZTcG2YVhZMZWOcx84quMc5fYLtyAaCa2Dyqow6Udz6w7?=
 =?us-ascii?Q?GOiNkrcRlvj86s0myNsiNLg1uSP1i0//vxZ7g8wE/ulQ2OP+5oVB7BvhG7BH?=
 =?us-ascii?Q?uKCaTqaNXdW+pGPr0tDr3vIAkha7vr3E7BspQutYDl1Wz14C1ZuRBUzhy5jA?=
 =?us-ascii?Q?3VMYUKj0A6wGV7eFpEkRLmC7XAnxc6tFEFpE3fJ/7Fao7D3xQh7/B9Qd2fCS?=
 =?us-ascii?Q?sab1oc9HhwLy8L3jXyFeCKzKHJxW+7Uv9F78ub+f5CQHtKO4JohpR6MGM6N6?=
 =?us-ascii?Q?DUbPT26iJUkUICIZURLwesJ3t/HzCnpo14259cUxyfzbHETBfPFkxPiZFFDc?=
 =?us-ascii?Q?x5ilXl1E17g+bWmn+I3gQq21Cl4s940gSgskPKm0plqJdZpmPmW46cFDiZqE?=
 =?us-ascii?Q?3IHvVfA7qov+ulRSwvtAyJ+Y0a/Agg7yRRKwIGoImUHwojzyCqxACzK9UMGw?=
 =?us-ascii?Q?RRMj6CsFhihdv2moEpf/aqC4MAzO6L+jUHJjIODrYtLMLF5Sze4yuOpddMdu?=
 =?us-ascii?Q?bGmnonOD5IiYPebP2BDp52Q73P35VWhKgxoD/lFYraWwV3YufxT2BboyBqan?=
 =?us-ascii?Q?ovHv9R38fQ7aWbFJXNyzps+2LYYC056NHCPtMZUz6mTygjPR2Wq/iNpi1/Np?=
 =?us-ascii?Q?vLxZr/55mSpsVYKkZfSNI7Q1C6zTrnkdmc007oZ7Objr1cYvXBB00I02hXlk?=
 =?us-ascii?Q?xfGwfpRL1D8ZhpERj3Y=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(7416014)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 13:25:24.0991 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c03b0ccf-f6aa-498a-374e-08de28384317
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4080
Received-SPF: permerror client-ip=2a01:111:f403:c105::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=CH1PR05CU001.outbound.protection.outlook.com
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

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
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


