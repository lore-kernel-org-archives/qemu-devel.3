Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D947DFC592C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 10:57:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvZ01-0006yi-E0; Thu, 26 Feb 2026 05:53:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vvZ00-0006yN-87; Thu, 26 Feb 2026 05:53:40 -0500
Received: from mail-eastusazlp17011000f.outbound.protection.outlook.com
 ([2a01:111:f403:c100::f] helo=BL2PR02CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vvYzy-000151-QR; Thu, 26 Feb 2026 05:53:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eXtOsGfP5kzLVSLrS6IAKojPCQh43dtHZPW/PPlmj0je86E+hdtMc+0WoGf484GP2Xm2+ouh8kbDtREYx+EXHipicgU8TQz+3m3RY4J4jykkGmWSLgJPGlCi0sStqlRbI3WMpPntqiwipNfxJQHCDEcOIV24eC1GCFg6p7+FiuS04p1wyBJJvjvaZskWXg7c5dyGIxLLb2U4jHXv1Ig7rU6fovqas/5hjGnqtGyjSeKs+4FRSz+ZPmzgNHMRouf2vUOEdTqLHsEgWR0tyHVaItVd9as2CCxY0FjvDKx4yem0ywvaxJS1OW2yt8tZeM4TiY0/WG3EATLSjbz1AcZ7tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bbjzwuQlr3TunnV2CPcAmMDvTbpm0QcjsfrYU1zb37A=;
 b=FNoMyKRVs4Ke+gTil4beYN1OlFQWoeZPsalrcOPMFfTuPElkbqXPzWUX8awedhqr8nY5InURrIB/fkuIocYc490Gsvf5mlkgR7w3pRmls9k4dED1mEADLU/bIbOj6vU4lMj7c+SmGgvlBk7IYM5skXMRKeDSwxU2qlfafJBgvi4xXzBg4fOX9RStlU7fNf+ZIMcLi/pV6QnzDrMWSwfaShVMpm6POFftNKdS0EacxViKoi0RyDfrtKlrA4N3kqrPX8DnXF4dc+qiNzPcNyhEcrkZppB0Y8b1DWvHOTJkEicrE+eSvGmZcP3NIVjTdyoj1hx1KcQ2f4jcZUnDaVciJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bbjzwuQlr3TunnV2CPcAmMDvTbpm0QcjsfrYU1zb37A=;
 b=e7wISq2JSIbu9c3ybSE6HpaIkTlM9Y65CSfAmafZxsX9DN0j5Fd7PGCNylI65yurWuPxDa5KWe8a0NSNNhDHoJaSmSV624CjE+Rw0/gk00qxnXvGV6dbLe3Lx6uO1CZ4wg8pD+b2v3b6veZeL+gkzX3w9S7FYzYY3gpoFv2WNVBjHEWuicgzISYRA8v/DqiUBSGistgPKAEwHFHg/CxWA0eu5+85bj7SRMbojHIeDZ2HnZ0xgILS7kNBSvnQQyk9uB9KbUiYf4p0DoYgngaemnC3axZNec0giFJ7fmS7MZ+CT9H0t6Ebm3u9tQqlXpEpdnpWsTt6AH9lY4xz8fppiw==
Received: from DS7PR03CA0041.namprd03.prod.outlook.com (2603:10b6:5:3b5::16)
 by LV9PR12MB9759.namprd12.prod.outlook.com (2603:10b6:408:2ea::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Thu, 26 Feb
 2026 10:53:35 +0000
Received: from DM2PEPF00003FC7.namprd04.prod.outlook.com
 (2603:10b6:5:3b5:cafe::9) by DS7PR03CA0041.outlook.office365.com
 (2603:10b6:5:3b5::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.22 via Frontend Transport; Thu,
 26 Feb 2026 10:53:35 +0000
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
 15.20.9632.12 via Frontend Transport; Thu, 26 Feb 2026 10:53:34 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 02:53:12 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 02:53:09 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v3 27/32] tests/qtest/bios-tables-test: Prepare for IORT
 SMMUv3 node identifier change
Date: Thu, 26 Feb 2026 10:50:51 +0000
Message-ID: <20260226105056.897-28-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC7:EE_|LV9PR12MB9759:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e7e10f1-f4f6-48d0-018c-08de75254a3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|7416014|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: A0Tx0VbSp1K9C1xJHR8H5H/l9ScdM8NzLlOAz7qQYv/CWiOuPS0ngmY7MWeSuQBqLVcvVDBwhHlZ7SV4G+/aKByH2oD3unHyRl7VR2Q8UxdywPyuZ8EM7lWVNK2hxRmHhcOH+GQoUBfkfl7C7itMa4X2P05Ps2azY0DqhtF0e2ZNyFUcEleuAoGhc+Qhfy3hSUGCUhITHe3hnYRB+eCMff5L72RXaPZoCpqCEpsbW/K78yRYViidUFKeulxlAlldr6IN6cbCzkfPv7Gs7cH3fDZYwkjS8QOL/HZ0fQQOSF+sKuM9tUSiBTGQVsGowZ/ua2YF93ZUL46AXldLpO45CEluNKnmxtrvxW4Lqox+dmj18y1jvhGceahL8GOBGB7Wijrqlf96alqKyBj9ZcGpJbAHx/W+jy+Fve6jbMy0+Nvz23/yifhiNoXm9GSQZCRz9v+qBeix1iF/uzNvgDJC41cSj8RWy+63apimXcxk6sdzbW1hS+I+x7N3klIJu37QfJjaGH3xG5oV24EI4vk2e+sypXZhNtoeYRxVUdpvsPLt1LmjYGcGuzln/NhGCOLAJdPbrdtfqXf9uC/VFKHiu8JrVoh1lYZyEaCBvAYqE7jmLaNZ/Y7wDrM59DMuiqpPGeUYyM1AmibbFNOM0vgzbleAPyyWa77n/hWStSVWTyJkf8fbuPD2rkMoilm6W5PMOqsC04UwG+6OXO8/x6Kyv+BQOuTjJU1cpC2yDvemWhllsQx8kaGIiPzz8As7gjLoexU0Vly5VvejtqAoakWwqczkzlrEuBFYLZuooS8q/Epx5p9wGrR4NnWAnKIinto9khg6j5DrNL9HX6NbioA7Gw==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(7416014)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: c+zN3WPZUKYhNXLiW1+/tipLKAPRbEknNXlGm913/BkuanZZuUWHk8dL/uxWWKekfQA0uiC1cuTgrxSWXclCKR+jRIq3+z87uXftR07owG6qtanaADGfIO+faPNmaS2vFD8SiY3kSb/aEWvGgo3zwZCK/9elGuhxQsOnZEEHqV4zxb7FvcsujkTKVU9ZcjLVq0FCcK82WH59BWffeWCuW9x0OTI2MjDQwXAob9yFwXogO9EKAAG7KX4Jnp/IeHTalgpVZRvYq+1/kd6TjuRpYfomZtOhuYFQdSovVamlkZQAKjzxYfCoxcsucxJP+pcYtCidfjXclm1QyKXasHRNLm8UvH2rtKI5RxpIA0oB84zSVJtCLDk+gt25TQBGyaWOkIuftnMzHbtli0QX/uVag0UjfBSWDpCeDAErQFZJuSnd8w6BzEZkLEMRGnYn9JBf
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 10:53:34.9600 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e7e10f1-f4f6-48d0-018c-08de75254a3a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM2PEPF00003FC7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9759
Received-SPF: permerror client-ip=2a01:111:f403:c100::f;
 envelope-from=skolothumtho@nvidia.com;
 helo=BL2PR02CU003.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
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

The IORT SMMUv3 node Identifier field will be derived from a new
per-device "identifier" property instead of relying on enumeration
order.

Add the affected IORT blobs to allowed-diff list for bios-table tests.

Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..df5fe417c0 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,5 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/aarch64/virt/IORT.its_off",
+"tests/data/acpi/aarch64/virt/IORT.msi_gicv2m",
+"tests/data/acpi/aarch64/virt/IORT.smmuv3-legacy",
+"tests/data/acpi/aarch64/virt/IORT.smmuv3-dev",
-- 
2.43.0


