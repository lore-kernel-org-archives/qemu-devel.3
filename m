Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCCBECF65DB
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 10:49:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkK82-0002vz-NX; Mon, 26 Jan 2026 05:47:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vkK7W-0001Eo-P9; Mon, 26 Jan 2026 05:47:04 -0500
Received: from mail-centralusazlp170110009.outbound.protection.outlook.com
 ([2a01:111:f403:c111::9] helo=DM5PR21CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vkK7U-0005j0-VS; Mon, 26 Jan 2026 05:46:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vi0zvVbO4fDb1Dgra8pzRt9xvpkn9XElVpnVDcFyXsM6uqS/JrPpAgRUcRo+KJ6QC34TMPNHEMJ0Of2qd8uilCibmgWvTLLb8pFaUhNOZsIjy10RRZ1gK5NbuM+PEyqJgjrgof6ky57DQO4cDJCTkmJX0oQawDxUR5+X8IIaPYmdS8exPaJnVqC6iIYeSXF7VyfdPIy2vOJ0GHpMXbtrDN6WW8dNC8f4tzm1AHbV0rtcXch4NACS2brCbtdge1dONShi5yKDdwtBPbgnBtodDoCgt+hWXFZ8CROAQjWjEgjvB6V0ujQYj9DBmbx9N5lzQr+lDrlYBzg0lNvFDY78/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oDnRsvAi//efRK5JnNaaRJq2ZkhxcZYysAZUVBtJ74g=;
 b=Jz+SNL9vkmsHxs7eHHHakq4KkoTK2V3bugZwhraZY64bpP1r1mtjsJVqKjAafiDD5Qr9pG2LWajlkIDB+pnUgV653hyW9l8CgbbW3ANlbXTendfueivKRrsajd8UtSiSe+sEqcx+PnbjIgHFqyHhoesBDrUurEgEWZbi1UtvMoIpvCfBwD10BbHOac7jq41zk//PMon+cV/trrtlSbPBjJ9+peH9ACpFpAFQPS9RiU5qhesK7iHwoOvVJeHgrbAk1eM58fZ1chc5Vfd+qkl4EOmazWQuQ0If8usjsohzL3HVXlJrcQ0lze2wtfhPj76cGIPRd/WY2vEx5fhv6h/7kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oDnRsvAi//efRK5JnNaaRJq2ZkhxcZYysAZUVBtJ74g=;
 b=aiQiKA7g4OEJ2U9w/Cpe69WoMaBQe+FLScBXDtocOk/bU2zC0H3nHHIv9oimKTa6Vv6PU+ndlCdyV+XB4fPBbX8ybSef5OCIq5dv1EwpZsHwnwrYCXHgbEOFXmm3LPlzTvlq25kijQmRUOqmZAjPOpFytM+AibRy/5i2ZMF5IS3VtSuS8NvsUmcpe7k5BVTsaF+Xwf5KJINjzY1v1/RL3iVZIvwmyZQNgwsp6C1JjcHwbEYBLRC8RBZv2lFFkrr9CNYUauxnwsiWxbRQx3s0nI7O5FJpniyymZBwTIdT3nH8FrU2Z26/IhsRRDOI2XlMQQJFqUoCbwJr919ELrm9Iw==
Received: from BL0PR0102CA0062.prod.exchangelabs.com (2603:10b6:208:25::39) by
 DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.11; Mon, 26 Jan 2026 10:46:49 +0000
Received: from BL6PEPF0002256F.namprd02.prod.outlook.com
 (2603:10b6:208:25:cafe::8f) by BL0PR0102CA0062.outlook.office365.com
 (2603:10b6:208:25::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.14 via Frontend Transport; Mon,
 26 Jan 2026 10:48:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0002256F.mail.protection.outlook.com (10.167.249.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Mon, 26 Jan 2026 10:46:49 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 26 Jan
 2026 02:46:40 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 26 Jan
 2026 02:46:35 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <clg@redhat.com>, <alex@shazbot.org>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>,
 <kjaju@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v9 26/37] tests/qtest/bios-tables-test: Update IORT blobs
 after revision upgrade
Date: Mon, 26 Jan 2026 10:43:23 +0000
Message-ID: <20260126104342.253965-27-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260126104342.253965-1-skolothumtho@nvidia.com>
References: <20260126104342.253965-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256F:EE_|DS0PR12MB7804:EE_
X-MS-Office365-Filtering-Correlation-Id: e4d7bac6-f8b3-4f65-1a99-08de5cc835be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|7416014|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?on+sUrVQVhxqkL/G445ia97M0qDYyGiWzC/4yPFr28dUgvOPI4dW9bo7k3YH?=
 =?us-ascii?Q?/+l9OwJoePCMyTCafGAjjq5pgqst3Nc2O9uwKlx+ymnEqgsCcpChzVt/Hqpg?=
 =?us-ascii?Q?7E2d8k2Diq5PqzJwGrhXkBR9BnYOTjVe4PZOFNrVWuCKJis1W7tdn8dfI6dk?=
 =?us-ascii?Q?g1IjsEzyuv7Q1Je354MCjcCVG1ILo5HSgT9SI08PIzhT8O/PSkG/A4dDrTo3?=
 =?us-ascii?Q?oOW8JxKVEk6ErPKqFB+T7cIP3tivOjlD84EWsp5+q6ok6BHpbdTd1QsZA7VB?=
 =?us-ascii?Q?cWR3+ufrLbWabXKoUv4tuk14CvBQMPDLXMiDX4rderFwMILAtmcBdmk6vifE?=
 =?us-ascii?Q?VCrHr3MXAhhPgBfuFQM35KWJzbgKua5KptepV0XNQzjUcqosZGqcpUCBWTFU?=
 =?us-ascii?Q?q0PSx/dZhptDbEFmBOShUlTegkKoy8WUGM3vRrRhSg0bDyW0Uu4OYtS9Zkrd?=
 =?us-ascii?Q?pXi0foIuBn2rRM4L6C9dFOXKF9Epz5+F+GjWlLCDEkZHAwfOF/MkMFO7wtWv?=
 =?us-ascii?Q?CTM1z8hDYG7zPRYNUFKLg5pEmzRLXnEnoXtXaBZdBxQmdT6OfsYuVisqxVtH?=
 =?us-ascii?Q?SO/fxnMRVTFWEsoaXba5DOH9GCvaTHxB/RxvHXhTs+/aoxASfd4MF9R21DHA?=
 =?us-ascii?Q?b9BZDeJqp7YXqvVt/throh1gusnsJPLl4GQzWYmMPcv6Nedc8EJ1XU0L4ksO?=
 =?us-ascii?Q?f/aFwDhc//Mb7pSUyrgiea2AbG4hsqk3qf/foL6amQKOy70wiOrO2DP8Tn9a?=
 =?us-ascii?Q?GAtr3b3tcMOMAtGXZXyOQSmNuM5HOF/B6nt00Rjcc/YEbtMgKUOY7NI60yBB?=
 =?us-ascii?Q?pXxwdGgEZEYe41Jaj4Q7YOgc6GRioZA722US+wfnd8hhhISmqoSCXKmmIpM6?=
 =?us-ascii?Q?+n1GA6C+9ZrHOaAVrMu9FEkN4KJZnf+vNCVgRbGCkL/1HsE6DRAsDVdYGEnW?=
 =?us-ascii?Q?mpVOL9Jo6ky2x3RSZJtCs1/zAlT9uiO+dxylOrwMdz8NJZJq3qz6yohQJn9M?=
 =?us-ascii?Q?AlZ4FaNqAUntkmRE//CTsEGnFb2aXyOsqK5P3vxxp3sV6dpqblkKKwwPKzS8?=
 =?us-ascii?Q?y1a/d6dC7ch3Fd22IaanFGnoRL/pQxHKIOVu79455+csu8yhC+VDv0a5lKr9?=
 =?us-ascii?Q?wtTSKPHxm5BMqESV1mgOtwyUc5aRR7p65qqtpmaV7ScoIIQOEeh97KcZKsMb?=
 =?us-ascii?Q?9OqPkuIEqvcvyXhFVJV4x/z1Ek+NdjTPaiMvG/D5YrJdAHxegXJIuXhdVgIl?=
 =?us-ascii?Q?rk/b/PdaDDNB/h1h0AY5CF7TrCAR4QvKlBDNuzlwxH8rfXKfhiMr7iqJSI0M?=
 =?us-ascii?Q?7KkH2ffBmxQ10qEOV5mGetvXNVNg56NSo1KBZvmiQnTnUojqVb66Cys5lacB?=
 =?us-ascii?Q?tQ2NKIIAPzbZSoWemR+Q3aP4offxfUHBVRlz5voce235DkfyWfyoGbWVNqkC?=
 =?us-ascii?Q?ellKRecyGwmsbFUz7pL1udOIz1CBpp2CMGXf4HG7e4V5VL3relAqjACDIAIL?=
 =?us-ascii?Q?METR4XtOz4pfXFwN1UjGRzlU/6yEccKdpJm+RyVO2xgn9rQWQdkbXfNeErMv?=
 =?us-ascii?Q?i9Rd1U6uB2m9YvMhTKtNojo/rU939cxzkAeKQuFx4bEN1Hgj48NFF39zuQaQ?=
 =?us-ascii?Q?ThS7whTFDdg3xDWYVCl/1O4vqOF9zLJqnssWhV0HzywbTeFmhxLLOa6x9jZv?=
 =?us-ascii?Q?KWFNFw=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 10:46:49.6108 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4d7bac6-f8b3-4f65-1a99-08de5cc835be
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0002256F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7804
Received-SPF: permerror client-ip=2a01:111:f403:c111::9;
 envelope-from=skolothumtho@nvidia.com;
 helo=DM5PR21CU001.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=0.587, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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
Tested-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
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


