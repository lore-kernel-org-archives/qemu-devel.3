Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C7B1C79F82
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 18:08:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2YK2-0003sh-9M; Fri, 04 Sep 2026 14:07:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1x2YJs-0003gZ-0H; Fri, 04 Sep 2026 14:07:23 -0400
Received: from mail-centralusazlp170110009.outbound.protection.outlook.com
 ([2a01:111:f403:c111::9] helo=DM5PR21CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1x2YJq-0001pU-GG; Fri, 04 Sep 2026 14:07:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VC9dplyxISGIhXOmscEyJRARxsYiwhMaLvFg/cb/LvWm056+/bkFgZKmuXuA9QhI9mg4CaY0Ym+eRZ28wtguPOMDPQ2IDlh1g3s2kx79TjDmQQ0GlHgt9ko6X28mYgUlQBq6w7zRMMeflAExpFc+LkAtQ5jGnKmh2uEeTq5loCRBKHBmaLxNXFgRvRvEE8Ya1KMBrnpGpWGvhCdiUs9n0hdl8O4Elw+GUR+Y+Rmcx3Ekqgo+88A80xfKIW/HSK+5GRE2YXOH/u9fUzg9DN8us6OanQoWzeQEU5FGuBsOucuTU+gZB3R5ysBRHIIxgAYIre2h8MB7/KU4K1qg1RmaVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oPla5zRQB9oPyQujhIddRJBfM4g26SMRyQd0O+dk7iY=;
 b=ZHynmjsdpeERymumBN3zntQwtMQM5op9bA66k4VuFXB7sgdwqMKP/DeQVOGrsWZPxtJ9t7QXrFgPYHdyFsgWjP5OPhyzkk7MApGT5ijEkxPGhIGV0v+MobywgRJaemcE7+I9Kt6JqNDDamMda1RLeYiVk/yIRf661DZzhTE+kBHUBgR91SXXuI/2ilFfhRWGYJgc7qsJ7CRvPdDG9tBEZcUtnd8jhcr8sQL3QmndDtLM993vDXpHSsWeJ8JgeANj/4D6fyhFtAVyD83B+ht3CllpUd2BeAyv8xCvMMmbOgXUTApDG7cEcn/7gZ89902ZdWzFgjQTH3Dzf6ZBRHSpnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oPla5zRQB9oPyQujhIddRJBfM4g26SMRyQd0O+dk7iY=;
 b=m5JdFZe7xWCSz0wAEu/TX1z5Eu8R23HVVkNBMg53/6rXWJ1CodTntgoXlyN+Fl1cCwva2QGoLI8L4OUIbbKor01SVEYNLg7IX1gYCHz0U+JMwBmolOXb6SXpKIOpU9ID8dE3tsABnFp/qNzVE7NpCMdxsinjRpIKm934tc4ni/TJ+4ztlsM3Hy6VL3sV7ZZrMAmnlbmZnxngNeDaCi0xLmtcozicg+qyK0qnuUYvPKGAua4Wj6kzSkum8RUCg4blD7LAKSgTGEBiqKMpkcPQnB65lg4F9UJlDyHft4HvPhDO0LS8wZpyCO2FcAxVAJkS+gjCTbh2xjtGItLrL9u2Xg==
Received: from CH5PR04CA0022.namprd04.prod.outlook.com (2603:10b6:610:1f4::19)
 by IA1PR12MB6164.namprd12.prod.outlook.com (2603:10b6:208:3e8::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 18:07:07 +0000
Received: from BL02EPF00029927.namprd02.prod.outlook.com
 (2603:10b6:610:1f4:cafe::35) by CH5PR04CA0022.outlook.office365.com
 (2603:10b6:610:1f4::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.13 via Frontend Transport; Fri, 4
 Sep 2026 18:07:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF00029927.mail.protection.outlook.com (10.167.249.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Fri, 4 Sep 2026 18:07:06 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 4 Sep
 2026 11:06:45 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 4 Sep
 2026 11:06:42 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>,
 <nicolinc@nvidia.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <jan@nvidia.com>, <jgg@ziepe.ca>, <ankita@nvidia.com>, <aniketa@nvidia.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <skolothumtho@nvidia.com>
Subject: [RFC PATCH 6/7] hw/arm/smmuv3-accel: Request dirty tracking on the
 nesting parent
Date: Fri, 4 Sep 2026 19:05:12 +0100
Message-ID: <20260904180513.248396-7-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260904180513.248396-1-skolothumtho@nvidia.com>
References: <20260904180513.248396-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00029927:EE_|IA1PR12MB6164:EE_
X-MS-Office365-Filtering-Correlation-Id: c298be0a-d71a-4615-c4d6-08df0aaf54ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|1800799024|376014|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: nURWbA8A4+7NYaEK/mKuXskIoLbPJkGFawcukY26Ms4826igH2PAcIqlrs0FkNw1Z6EspvxCOEn/rNdnso2vsUzYybi5kIM718SymWus/wKRUHKEdeV/HRb20Ju/zLnJx7cGU9s0OMGgTVQi8iS7RHwJuMxcIiXnpUB+kAiz7SdiZAB00pWF7+u7ewc9ki1jW133UuSURcxta6bjeRKwkStYcZWQ2Hg7howYsyfPQtoi3vpD6OkDjg/zFLd7bstLHUi34qLm9VjyOxljL/Z8RlvCCbmSzZ7m0aFRuImqIpwZ1PZmmMB3GykA7jwjnNH/mvjtR9vnEYk8fUFYrsF34IIjmPueIds4QE1JGDo79bqmr3ofexpx5xYAd7+5P9lhql8ljtomGlXH7OGZ1mCPNtykgftRLFkbo/WziFTiufc2rbGVpvdKX+6cB8yEdIxFZLoAmCxQIFra52zP+3pdn996qghTGnCslHjSn7UX8uio5PhdXmdJ5Um6AQCNHR0yeSsv9+WmMaTK4Vkmozel55YsOI2jshk1JcbXwEiKnEoj3jhSj7NxAFGR5v/WeTMlIURrWwskf9Mlo7bzPuTmu14u+Npo3Eez2ftzqNdwr8SyW560o6XAjOwvN9MJSzIEjM0DgMTYH+aQI35ClHEOYCC8PRQ0B4WRcgAb5SXP9tSyhJmc2V1ZlEINPS80nvwndyDdiK2iG8wqZagkWWmcgg==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(376014)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vZ0uYhCskg+I2js3owo3RPqGqZuk/s46+5yj0KxEHFNbLikECN4Nqea0o0pnsAMKYMlsk2kg5VrccGFASHKR6WZfhpxluwxxGL97g2q9AXVekr50ud6itYXOPCxXTQrEJSFzZaU7dGyHfv74SIJ5lAHuXPukRW1PK8Rj9hIjfRLrzJdBE7QqhuklbqcTijyzdKFl/HlqkDBySKI3QwPwMbVwbrKlu+mimmcXxukUZfQInlk5Z0ShtF7coc2I89ia2FOHrC5wC0/g95kG4e4y+wpLDAT9MtW0fdsD3eFX+kFdAr63aLmeh2TXsJbPvdxFsyhmr8OYhM6PJ9mpQi//NbgqesSzMk8iHxt4COqZhZ9PMPZ3tpbhZyjR9SeRXLuvAEVTEKcA7CtqwcwCJX806WCJLUXNsZ5v4KnkGAKxVuq9aGzYNyC5CTBPzfjIwre4
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 18:07:06.8572 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c298be0a-d71a-4615-c4d6-08df0aaf54ef
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00029927.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6164
Received-SPF: permerror client-ip=2a01:111:f403:c111::9;
 envelope-from=skolothumtho@nvidia.com;
 helo=DM5PR21CU001.outbound.protection.outlook.com
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

With accel=on the guest owns Stage 1, so the Stage 2 nesting parent is the
only page table the host can track guest writes through.

VFIO only asks for IOMMU_HWPT_ALLOC_DIRTY_TRACKING on the nesting parent
when the vIOMMU sets VIOMMU_FLAG_WANT_NESTING_DIRTY_TRACKING, which
smmuv3-accel does not, so the parent is allocated plain.

Set the flag.

Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3-accel.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index b653f3f4ce..3f83b505d0 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -1037,6 +1037,12 @@ static uint64_t smmuv3_accel_get_viommu_flags(void *opaque)
     SMMUState *bs = opaque;
     SMMUv3State *s = ARM_SMMUV3(bs);
 
+    /*
+     * The guest owns Stage 1, so the Stage 2 parent is the only page table
+     * the host can track guest writes through.
+     */
+    flags |= VIOMMU_FLAG_WANT_NESTING_DIRTY_TRACKING;
+
     if (smmuv3_pasid_supported(s)) {
         flags |= VIOMMU_FLAG_PASID_SUPPORTED;
     }
-- 
2.43.0


