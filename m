Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2244FEB597C
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 08:35:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vq5gz-0006PE-Oc; Wed, 11 Feb 2026 03:35:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vq5gx-0006Og-EP; Wed, 11 Feb 2026 03:35:23 -0500
Received: from mail-westus3azlp170100009.outbound.protection.outlook.com
 ([2a01:111:f403:c107::9] helo=PH7PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vq5gv-0002kO-Cu; Wed, 11 Feb 2026 03:35:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LNd/Z/pP/68J0KBIO3tiyBlDFNTrOAiBpglHfLwcp/M95R6BESUNTgCV3lMvfQm/236rhAeU/M5l5NCCFNqkBd2BaBBeVWv0LkH6UVJ4FLQs/z2Kst8W9SSAY8EdkJwJpMUNBvoMmKBW9LbpnERkupMhOW8qMNTzekCxBsK9e+jZDwGUoyAx4EVuODP1Ev/R2bfZOuwAzYOiNdbpmyIb+s0YrjKA4lLRG5Drzk0A2EynOODnnhm6n+Qk/NZh6+TxLZrnyI3qxkg5n2O2h1zMM32osrjWOyFFAWzbPnd4sSwUWxSqqCCglag+pOEWolOyKDCfD0b21WNbi58fLFUurA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=48GPTRoIfqVgVHh7NFUZpSyTdsDxbj0+sqOXAta33AQ=;
 b=ut36+eZkD8cxpC/+gQH3xS0zyUOk7zMqaLjFQ6KxlZ+RT8YgbGvYGhGkm2Tmy1h/5MGzEN9mom9+smZdvyCrccnd24YPIfRnRNjYk5YKH5eU+dhf3iDl+/Ga0BDXYHHPgoYY8+kKm7q/2i/yrCg920EUHDJ7oBrverkZ74ZZXJCxbs+CILGuLpb/+7oHE0Hn1VfHpf6WHXcnrSX7sAQq0W1kcV3qXSRyqTc48dONDDf7X/VBc5eO9xG+LNFIZ6A3Ki4XZv/L2Wg9Chbnlk6Gk9ASwtmhFOVqOIMBev5uapbDf/rspggFn28uBfpm1x+3OlB/kYsPS51wZS2UWTSzIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=48GPTRoIfqVgVHh7NFUZpSyTdsDxbj0+sqOXAta33AQ=;
 b=V7SLuEcIBJNdPXx8wh94W8Bzz9jscyETmTNgjp+cUscqvTSSBvufeuEGuuwbdyf/QZCUb7A/6qRZAPtpNl8PUc4h+7OfRpZvpCRa+lifeTZaNYSV4FY8l+MzeVVGKtrDAsGhlkidbugmmlDxcVxwV60YC8uxu+KEoAG6M3yWo/FEpJir6uvUvpTxrt5htchdwZ6U3Uw5t2iVqUtzFyzDiOW+t2AqG6n2vX1TcTlyLov/olGoCx9rRT1uEIfuurm1mWi/D0GCw9nupGZynLWu5Py+XPQJMslhu1s+jymO1YuyScZhbbsEGXor8Vt+ZSacZaw8apb21gqhW+A0rdNDqA==
Received: from DM6PR08CA0004.namprd08.prod.outlook.com (2603:10b6:5:80::17) by
 DS7PR12MB6357.namprd12.prod.outlook.com (2603:10b6:8:96::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.10; Wed, 11 Feb 2026 08:35:13 +0000
Received: from CY4PEPF0000E9D3.namprd03.prod.outlook.com
 (2603:10b6:5:80:cafe::4d) by DM6PR08CA0004.outlook.office365.com
 (2603:10b6:5:80::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.10 via Frontend Transport; Wed,
 11 Feb 2026 08:35:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000E9D3.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Wed, 11 Feb 2026 08:35:12 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 11 Feb
 2026 00:34:56 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 11 Feb
 2026 00:34:53 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>,
 <nicolinc@nvidia.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <jan@nvidia.com>, <jgg@nvidia.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v5 0/5] vEVENTQ support for accelerated SMMUv3 devices
Date: Wed, 11 Feb 2026 08:34:10 +0000
Message-ID: <20260211083415.133534-1-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D3:EE_|DS7PR12MB6357:EE_
X-MS-Office365-Filtering-Correlation-Id: 40b8abd8-09d3-4af3-f2ab-08de69487948
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?30MW1vuyK5vpCilLecPIq7WK850eQYxiPRcT6jAh5OzwhRxSi9PQtsPjk7RB?=
 =?us-ascii?Q?u817cQyt18ko13Npfq7SCQCfRoESR1l1V6g6jEYnG3aKPQoZhIk+on/6oixf?=
 =?us-ascii?Q?BCRAJvsvUT0cwdgo6MSSbOcNno0JvChePka4p4hJ7c8fDk4O1/fmCfTKyU6M?=
 =?us-ascii?Q?MwWzVSAAWT/nST+QI4wFJd/2iYJN73DLd4zbbVwz9cc6gluM4dY/pib+anen?=
 =?us-ascii?Q?hkscJwSH0+ffSpg+0QA9YSoAU4XeeP0MDUlbeY9bAi0mfwNgLJKObkMjEMPx?=
 =?us-ascii?Q?9DX2ICJxSA9Qw7S18cU0v2nPYEPUgm+LLiBtv/lJ91LoaEC2IaDxFc6TlopW?=
 =?us-ascii?Q?Ixz8/v288kZvCrff1Jc3r/O3jvLsWX5mQLH8CqAzfbsmKwL8UYzUBLQwbQnP?=
 =?us-ascii?Q?S5wUsqDs3qrCHSPaqRj5lk8+5Cl88UXHizWfezqIc3XuEXBe8eu8IdQufY/d?=
 =?us-ascii?Q?IC8DImG3QSrDQ9mQKqHednAiNKAW31f3b1GfiIac+Wph0KG37YhejA1eOl+p?=
 =?us-ascii?Q?CYQxppeabC80RVswPh8/Kr6dTzrCem8gmnOYYWJDuakte+pif0sLf/QAL/g9?=
 =?us-ascii?Q?f6ZNQNC+IcQvqJWlTug+w5r79euSqUDIT6GRHgJewvftEiGIfaKGUshRBQcv?=
 =?us-ascii?Q?F1ibXwh4bWOfFRydj6CAbeqFyUwnV7o20xcCv430Qp2EYkojA3npQGfU6p8g?=
 =?us-ascii?Q?Wkov0aA4bMW7Yt8OWhO6jQf0+GEiTC5wDnSUBN41O23QYnQNdrno0fx91rB8?=
 =?us-ascii?Q?fMuWLMMQ61kuyx5F/VcuxAR4eEGJ0D2pVyeIWhOGK1LMYXZfL72gp0ST9th9?=
 =?us-ascii?Q?iVoIiYr8uKe4k9/F5u5QrPALg18tnrG1moCaepo+IO52+3iZpa2JqHoa+Y+O?=
 =?us-ascii?Q?bmOIe9A2UCgKmjApE8cx6/6Ji4mpW/u0vmrKgJoJh8vXb0EeTgToDgCGXKtE?=
 =?us-ascii?Q?PFsWjrd9mu2RFNp1oOV6xPKHCQroPeZMkPtoO/cjDROTJpPXdt65F2Abf4qN?=
 =?us-ascii?Q?qkGheNLzP69yMVjFq7SZ0Ea3e5O8IbqciPt6PI3MvHSKjunGjll5wEvCj19c?=
 =?us-ascii?Q?I0RaijABhrcd/s4zQp3jykiaxOu5x0gH36v7RSaOahEpIwVDw4LiVCpmd7a0?=
 =?us-ascii?Q?bO7QmwbZvi/5tjM2TBxX9J5z41rOsEMl90hrpuKsbJkejDbVy9MFwqidVHxb?=
 =?us-ascii?Q?Oc/161XeVesbXgsAKV5wlzo+L1xgxcm7z2NyN94dQvErS/I5TVitjNgkA+Xf?=
 =?us-ascii?Q?OQYD4Fp537HsIYEE3BG6w3Q0SfYQOGLEu0kazKW9/L1AyWQXQdksibeZFSv1?=
 =?us-ascii?Q?WuWriM51CE5uvlGsU1l51DgWHf4z+pF/out2KgSHO0eGrwtjzddwurbf34Hw?=
 =?us-ascii?Q?QpqTx2pNu49Zc6TalJ91n8wEqJzqqVkFKgeJxyGbffNCWHClkJY/0ntjBDPi?=
 =?us-ascii?Q?jWoKsIbCtLdCysXBInseVsZKgMzMM3x9T7Sn8HBLl9397303jutnGlCJUBU2?=
 =?us-ascii?Q?efGo/xKllC+oG0HW0HztUwrWY+rXJoNcKVD3y7+xYwXVOQFKDckMU4hyESv0?=
 =?us-ascii?Q?fJq+XLFzc8WUe/N84mbj7OVxTe+cY6Hki3TgIF9T5zGWyxyi/81wwBP7uL75?=
 =?us-ascii?Q?QHLKVzqWFjAvm5biZh+mC2+BWf/DRbUvnbhszsQ1ja39B5KA0r/dlyCeI7R3?=
 =?us-ascii?Q?qSMTdA=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: QAqPjY2C3/UxfKHdruDg6EkjSHOkDCjBE+uRdIgbwGWE7MDg23MpJKPM3CO7hRq1moNTl3xZHk4xa6UDbBQFf/uV6ysAXrJvDmZ9Lz1O84h+YqWs+cajMteQz2GUN9xmaons17WuGaU/d/Tn6MYIirwO++z2BTiJsji9BUnQCYOQeXzz4w1FCheH3qRvAXJc7e7Z4ih4bo2roW066UytDcvVjK+ryU1YuFtsAG4+RsCn61vRz+mowM2ZGgTttMzXY/Xq0hRT/10HuopBnMwEA7YCd7ts3RcP4nmGCiqL5avizwUVdS5VmSCeVC77GSBt5I4YY/sR6i+hcW9U48KEF2Zj7Rv6+ox4DMbLgV/MiczwrLOLJtzqwsf11U+eM7aWN4m1v/mpKKoGzPf+Hvet4yBmawGSGf23It032Ig2gPsiTODofX9qOHpqbYOfCxfg
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 08:35:12.5411 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40b8abd8-09d3-4af3-f2ab-08de69487948
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6357
Received-SPF: permerror client-ip=2a01:111:f403:c107::9;
 envelope-from=skolothumtho@nvidia.com;
 helo=PH7PR06CU001.outbound.protection.outlook.com
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

Hi,

Changes from v4:
 https://lore.kernel.org/qemu-devel/20260204190008.20070-1-skolothumtho@nvidia.com/
 
 -Addressed feedback and picked up tags. Thanks!
 -Fixed missing !accel check in smmuv3_accel_alloc_veventq(patch #3)

I think this is now ready for inclusion. Please take a look and let me know.

Thanks,
Shameer

---
Background(From v2):

When accel=on is enabled for an SMMUv3 instance, the host hardware SMMUv3
may generate Stage-1 (S1) event notifications that are intended for the
vIOMMU instance in userspace.

This series adds QEMU support for receiving such host events through the
vEVENTQ interface and propagating them to the guest. The implementation
uses the vEVENTQ support provided by the IOMMUFD subsystem in the kernel.

I have tested this on a Grace platform using some hacks to generate
events. Further testing and feedback are welcome.
---

Nicolin Chen (2):
  backends/iommufd: Introduce iommufd_backend_alloc_veventq
  hw/arm/smmuv3-accel: Allocate vEVENTQ for accelerated SMMUv3 devices

Shameer Kolothum (3):
  hw/arm/smmuv3-accel: Add viommu free helper
  hw/arm/smmuv3: Introduce a helper function for event propagation
  hw/arm/smmuv3-accel: Read and propagate host vIOMMU events

 backends/iommufd.c       |  31 +++++++++
 backends/trace-events    |   1 +
 hw/arm/smmuv3-accel.c    | 144 ++++++++++++++++++++++++++++++++++++---
 hw/arm/smmuv3-accel.h    |   8 +++
 hw/arm/smmuv3-internal.h |   4 ++
 hw/arm/smmuv3.c          |  25 +++++--
 hw/arm/trace-events      |   2 +-
 include/system/iommufd.h |  12 ++++
 8 files changed, 212 insertions(+), 15 deletions(-)

-- 
2.43.0


