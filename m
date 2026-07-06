Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FA72C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 10:41:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wggii-0007HE-Az; Mon, 06 Jul 2026 06:38:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wggib-00079r-Vh; Mon, 06 Jul 2026 06:38:30 -0400
Received: from mail-westus3azlp170100009.outbound.protection.outlook.com
 ([2a01:111:f403:c107::9] helo=PH7PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wggia-0003TL-BQ; Mon, 06 Jul 2026 06:38:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qbk1eMzQXjoQwm6EonPnyyQ/4Y1uT/LLxV49hF2A2nHf5Lr3zNPADb5Vm7pKKf6mPxo/dYY6p7MgcplJACQbJVnv6mz6GD7GeMAn4G7IHm+cah+bDG/+jaB1eqQtsIpt3g7uf82De2G0FF0IwJkC1RgVizxt7djiJM//dnBb5ZKEodiP+XqzidwHjabAUZslG7/hvlACtY9FU3zNFGw/xtIAGCJ6briIjbwZMJOnQeFbhhpgVvLneX7QCCH1WewrR0LbvrJ0xsNvljHTk1G1brqdKFGRL156RsXhuuaQFwVZDB2INH+xcZxcJTfU9KPBeapdZR6KTmHw6FLv3r3iRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2JBmYzEzfAfcibhNjNORgourSBS34TWVv2ETKSpO7bQ=;
 b=YcHoA7f3f4bcDTJCOQD4v0n1tpUWSPyRQ42bD9chNNH2L4Uc6kee3bg70P5CkrFX2DMsQa85AW2xPCULKfR4sjWqCCwNKH6S1z274Q8/GaOOhsvoeYGW0gGUyHw5ucaMp59A12/2tEE7q7CR9z2uvVCAUaqbZxaeCxMT5Iq0pZMc5u3/3IayNtoJQgD5n06oIcFWksZ9TzwXzUMQ5u9f6GTx4X5lW72LSCmyj6CXBYov5YGpjVp8rm9Jd3GkuVqkaZaoE0zGaJ087H9+TVUJFCKIRsNFe3beXLo7DriycutZKkSD5AoWnxYcCavb9OCVdrXlwC8QrOcOan/jJZ51uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2JBmYzEzfAfcibhNjNORgourSBS34TWVv2ETKSpO7bQ=;
 b=UlRyU4Se++lQuE17cu+G5nLINGeWhq7IVWkPoNhZEnCcgHyjeXXqfTSX6R2szaTddK5lWFF5oR9WA2ai+zCoIqSehBUosgpT2nCXQawRrXZFJh1QX5Zul+91CLqCTHo+TP8RG+8k+9QGjMWGp6f//dRKOdX4njrEXkXm/EWMFHS2p/h2Vx3J0dbGFlClUchZ2CyM9lIRkwQ0XdYnlGJS7uSwX4CG8NyzbYp2LK2A6SGsLuSKdLLQAZRXQu5HDvUzZH+kLCz8PFsTtsRknj/lz6NhMKQ+THO8KSPfYCw/dyyW79qZ8OySaeyAXkhXAvuxmjJwyL89tzZGxv6Kh0KNYQ==
Received: from SJ0PR03CA0061.namprd03.prod.outlook.com (2603:10b6:a03:331::6)
 by DM3PR12MB9392.namprd12.prod.outlook.com (2603:10b6:0:44::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.11; Mon, 6 Jul 2026 10:38:20 +0000
Received: from SJ1PEPF000026CA.namprd04.prod.outlook.com
 (2603:10b6:a03:331:cafe::27) by SJ0PR03CA0061.outlook.office365.com
 (2603:10b6:a03:331::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Mon, 6
 Jul 2026 10:38:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000026CA.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 6 Jul 2026 10:38:20 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 6 Jul
 2026 03:38:03 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 6 Jul
 2026 03:38:00 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <nicolinc@nvidia.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <jan@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [PATCH] backends/iommufd: Fix dev_id and type order in viommu trace
Date: Mon, 6 Jul 2026 11:36:52 +0100
Message-ID: <20260706103653.84243-1-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026CA:EE_|DM3PR12MB9392:EE_
X-MS-Office365-Filtering-Correlation-Id: 852f85b1-d811-45fe-f923-08dedb4ab26a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|23010399003|1800799024|36860700016|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: oXCqihT8MWMkCNEuhbTi+svpZoRk3Gu4RQJTSzjD2IVe2FKT2SmIp1FtAIS0DmeBsY24VzYj2qGeTu2vYZeZKdm8WJX2gAlT6zZ4stjdDSW0bAQwG6FTgJyGs/MzFUYcw6ROUCABxy5iyTOgegter9hndY7Lj5FXa1Ztu1ThspVKiQlOBHKzhk1+5dR+GcNF37sj05lcs7seRY8jcEqNTLenwanjRqL8ny3wjeKPO7o0ThAw8y+Bj4TT+YKR3iVxljZ5+dFK3l3bkEnesqiSEG764bWeTqHcmFXct5mTjLXurp9HRWqlea6EjwRXpj0kH3k+CTathx7lKaIYZEcYhnkhgwd8wufddbx2ZhaFIe4q9XO7oONy5re4zSoYmyLdxcayAUAyTJMg23HjcAfLH2FGlluqVkJDL1yY5zH4MgPTRHULARMHsbDkwZrGvb1AVE8sxBStTP6mxnxw1oOOEHTplI8Q2s1Vc126MIczEeJEa4AwYk08znpoXe6z+VQ0YNOYTeixtzLhSSccagHmOGIGc8oi3giLZxhCXCDf4rONm2F0DiedwdSMkZCO/sbbk/HKfj0i1IBWwtpnddJjlJG/7b0yDrHaJPEZfpyfGHAgXI6tMzLXRlP198Vzdtzgmb4tIjXArJtUn6peKSfaugYQRSxLOL3BY+y/Vfrwd6yMQR8ZYWfTwQ07tEIJPqmhudcUBFpmkH/AFxTfyhm2ng==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(23010399003)(1800799024)(36860700016)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hRpwLJB4DSzV/EdS1nXzysRycDEyoGId4968xYvEjpP1+kUpR9HCp9QSPR+w4H7R8xBfXJmAk84qXPPrC2xtNfuQyUONzlcagO/FYmNMfMknVm6kYhW6QVatRlo/e95i76LyJueZqIMhYJFe+FmlvCta2iGy2yQHKSMirntKL/rySvWjVs3AYAcFiIwgBCkkLmkqAS42L3gE8iHI5hVOwhIcz8IqNYkgdQx5TXEAkhrOSj0vZgkCCMqJFLvkpJyW4CHfZKbwz3h7SNLGanBLfqorTOgu/jJUcguGk+6zZc7E4FtpzumGJgqvTWK5GEYsjUG8F5otFmpJAfoUXy3PhCav3SgI6MiNOkUY3xmN6FaY5bgi0VoVNzL515SlAc9fA6XBGffRLeJpTxdBG5jr97Iyj2EhNbYHHWGrQ/4rt2H7y3qDbv5XQCLnZmZwozWJ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 10:38:20.0331 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 852f85b1-d811-45fe-f923-08dedb4ab26a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026CA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9392
Received-SPF: permerror client-ip=2a01:111:f403:c107::9;
 envelope-from=skolothumtho@nvidia.com;
 helo=PH7PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

The trace event receives dev_id before type, but its format string prints
them in the wrong order. Correct the order.

Fixes: f2d31df0d925 ("backends/iommufd: Introduce iommufd_backend_alloc_viommu")
Reported-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 backends/trace-events | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/backends/trace-events b/backends/trace-events
index b63420b73e..009a25b0be 100644
--- a/backends/trace-events
+++ b/backends/trace-events
@@ -21,7 +21,7 @@ iommufd_backend_free_id(int iommufd, uint32_t id, int ret) " iommufd=%d id=%d (%
 iommufd_backend_set_dirty(int iommufd, uint32_t hwpt_id, bool start, int ret) " iommufd=%d hwpt=%u enable=%d (%d)"
 iommufd_backend_get_dirty_bitmap(int iommufd, uint32_t hwpt_id, uint64_t iova, uint64_t size, uint64_t flags, uint64_t page_size, int ret) " iommufd=%d hwpt=%u iova=0x%"PRIx64" size=0x%"PRIx64" flags=0x%"PRIx64" page_size=0x%"PRIx64" (%d)"
 iommufd_backend_invalidate_cache(int iommufd, uint32_t id, uint32_t data_type, uint32_t entry_len, uint32_t entry_num, uint32_t done_num, uint64_t data_ptr, int ret) " iommufd=%d id=%u data_type=%u entry_len=%u entry_num=%u done_num=%u data_ptr=0x%"PRIx64" (%d)"
-iommufd_backend_alloc_viommu(int iommufd, uint32_t dev_id, uint32_t type, uint32_t hwpt_id, uint64_t data_ptr, uint32_t data_len, uint32_t viommu_id, int ret) " iommufd=%d type=%u dev_id=%u hwpt_id=%u data_ptr=0x%"PRIx64" data_len=0x%x viommu_id=%u (%d)"
+iommufd_backend_alloc_viommu(int iommufd, uint32_t dev_id, uint32_t type, uint32_t hwpt_id, uint64_t data_ptr, uint32_t data_len, uint32_t viommu_id, int ret) " iommufd=%d dev_id=%u type=%u hwpt_id=%u data_ptr=0x%"PRIx64" data_len=0x%x viommu_id=%u (%d)"
 iommufd_backend_alloc_vdev(int iommufd, uint32_t dev_id, uint32_t viommu_id, uint64_t virt_id, uint32_t vdev_id, int ret) " iommufd=%d dev_id=%u viommu_id=%u virt_id=0x%"PRIx64" vdev_id=%u (%d)"
 iommufd_viommu_alloc_eventq(int iommufd, uint32_t viommu_id, uint32_t type, uint32_t veventq_id, uint32_t veventq_fd, int ret) " iommufd=%d viommu_id=%u type=%u veventq_id=%u veventq_fd=%u (%d)"
 iommufd_backend_alloc_hw_queue(int iommufd, uint32_t viommu_id, uint32_t queue_type, uint32_t index, uint64_t addr, uint64_t size, uint32_t queue_id, int ret) " iommufd=%d viommu_id=%u queue_type=%u index=%u addr=0x%"PRIx64" size=0x%"PRIx64" queue_id=%u (%d)"
-- 
2.43.0


