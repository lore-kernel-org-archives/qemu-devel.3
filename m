Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4E00E9A04E
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 09:03:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vszvE-00050Y-MH; Thu, 19 Feb 2026 04:02:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vszv3-0004zB-Jk; Thu, 19 Feb 2026 04:01:57 -0500
Received: from mail-southcentralusazlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::1] helo=SN4PR2101CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vszv2-0002Pi-7M; Thu, 19 Feb 2026 04:01:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tI/CtfDp23B51qZHd/jv+M06sCD/4SqDEG3L050hdmReoFYgdW1RtW3sNDCT/iof+42XzjUdclxHpiD8/Vm+yPpED78irIi8sID1WKKmVok9/79shGlew4VodvBUeziag37t4C1crGtbkL2aFz0D6TbNELFUUyfxzAH9FY7tu2KKR8wOz4aFM+5y3kiP+xH0gmwoRqprZB8v4PCLdJ3AxLnkNoUrEE5vP9LZnzHI5rT8zF6hfq20vBjsNXYQcKUwELMUMy9+PYfRAeYUOPgcJkYlvfJcOq5x+mTo4JSU0Qz4dpth5ogjlU0Tf1F45U+W8vXx52X4i4v0akZ02pD2RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a7I/7El4fdID0nN4B4A0S9QpxBwfSm8gU/rzCLAlJMs=;
 b=avE+MkTYrHc8aC/KXyXgC45gN725/OTRaUbmcAS9W/6SJBd22jC4uB2fTy95Mf7hZF88b83L0ZS3quPVYrGIdI7D4ofb6azSgOFCMoIEfSrSUuqnh7XZK11imxhGabo9QlGSyUtPqATognlb8rwIoIegQyTaauvaGQpkqW5gYOKuqyNPfjXtGWlwkRGaHyub/RACbFUyV5t4ZAgoY/efqN0ZeC9x7mfUygm2ej8eh0fmd39GhMPREhvZ+o2mGLnXpfd7wi8ivAYJjAADlb/4ajPwxtPDY9ZoSbkKfAK3SC6FqGQdC8ArF5tKFj7wFzYez1no7a4YiVWy8Aim33H0CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a7I/7El4fdID0nN4B4A0S9QpxBwfSm8gU/rzCLAlJMs=;
 b=bJWQuLNQdoiAuT9JnW9st7J5M+5gYrPjO3DX2r6aPAawx/kNyXeq8iYnQNYeYfvwRg5ng8GOiqjq87PoT4zcRhQ5fG3E/QyGkRDIWRQeEjx3T7JT9pak3FO8Kzbu83I/1khLYMiClTjhL1n673Q2CtllKva22PyR+vfn2WsXu8uMm3ywcnppGdv4yQAzZgij+Co+lZez6cfnS/E6A9dVucgv/9OrLm2WaAi9bwASLb3ShvWDGR9Un3VYpXNaoq3sp+nez7egUIj87f+W9QRDVPJcIBI47K4J+umiTm5T73ndhvNmcYPnpw4dIx6eEyY6b9vNGG/RRct8IFXR2wdZFw==
Received: from SN7PR04CA0007.namprd04.prod.outlook.com (2603:10b6:806:f2::12)
 by LV3PR12MB9216.namprd12.prod.outlook.com (2603:10b6:408:1a5::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.15; Thu, 19 Feb
 2026 09:01:50 +0000
Received: from SA2PEPF00003F66.namprd04.prod.outlook.com
 (2603:10b6:806:f2:cafe::3d) by SN7PR04CA0007.outlook.office365.com
 (2603:10b6:806:f2::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.15 via Frontend Transport; Thu,
 19 Feb 2026 09:01:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00003F66.mail.protection.outlook.com (10.167.248.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 19 Feb 2026 09:01:48 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 19 Feb
 2026 01:01:35 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 19 Feb
 2026 01:01:32 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>,
 <nicolinc@nvidia.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <jan@nvidia.com>, <jgg@nvidia.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v7 2/5] hw/arm/smmuv3-accel: Add viommu free helper
Date: Thu, 19 Feb 2026 09:01:00 +0000
Message-ID: <20260219090103.33697-3-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260219090103.33697-1-skolothumtho@nvidia.com>
References: <20260219090103.33697-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F66:EE_|LV3PR12MB9216:EE_
X-MS-Office365-Filtering-Correlation-Id: 591a4b04-aa0e-43eb-8f90-08de6f958413
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4kaLTWWMkuOmkkp3q8WyPmjLYXB6FHv8j9H5QoEQy/8yvMjRK7VmZmFD2S3a?=
 =?us-ascii?Q?djNG9WkAe5Aq7OkxT5InCptio7bZXa6QfbpXb5zeBw48iXjJCEuJDui0K+UD?=
 =?us-ascii?Q?KKHxlV+VM+pdUfhNOFbkpQiYdiWl5I0n7ii0k/OvKgC6xphWVd2Yp13ejYr1?=
 =?us-ascii?Q?Tzs8MjBQxnYZuivvPug5hBjC3tgGqx9oig1x9+9Sn+5GXhvL1agH/m1bApiL?=
 =?us-ascii?Q?/tVmc852U8nNqMiRDtW0VhPOGCYYVEsb4VIIWb2QbX+PDYkDXlKcA5UVcC8A?=
 =?us-ascii?Q?/3cYGdDD92TSM9IrnLC1y1XN58wPFLvKKM0tp411+IVUxu8/44UuUKknYqEB?=
 =?us-ascii?Q?PedWe7RUrC+/DMhn15WSqKLvAK08YgeFRjESQUJJggi0LwgH6zp9bo5Bovxk?=
 =?us-ascii?Q?NEjEwKNzHmWFKJmvHUGlKSwsmZglI9R+RuawDjkAjKignZCVl5KkOweGunhK?=
 =?us-ascii?Q?pq11cvRASimNVUhyhQfjv8zuByJasSJznTOLg6GSeUKCuEVgLuFIMF6JtSu9?=
 =?us-ascii?Q?atXXxdvYw+SGl6eRdQF4NtRyRIisbql2nGZttVcGlnEG0Ph+YjWvb0WDb944?=
 =?us-ascii?Q?ea4rlVv29qND720epyu6uXJoSLossElQ7erhNAl8sObA5lIDUre1Y9ZFsS7b?=
 =?us-ascii?Q?kmWaBucxkMWY3H0vY8rrHiSxX0cd0iIKqSwr+IO48H9vuUnYda0xOrPf2ERY?=
 =?us-ascii?Q?LS+PzWeuqTGHL0ZzvrXyy2V8BlJAloIKgaN3mWo3MmDrXKeeTMN8kuTO5ecC?=
 =?us-ascii?Q?J8qE0pwG0lTLoV/gMA3bAfwj/mPbvII2qKHnBO3gbR86S1l9fBJeIEGfQ1WY?=
 =?us-ascii?Q?nT/jK3l/SUu2ZHM9KUHqgzSvOMVHBwYWLjBDiTOE7WKupZn5OPuddIxtCcZK?=
 =?us-ascii?Q?p0t1WAfGLJ/Om/bVVRSRedrJp0yOs421CsISDzR7ifQJWvejcphAZwiQyctQ?=
 =?us-ascii?Q?posY/Ck81V4mpI6AIHWYnd3mmK2wZ6y0IzEgH0SyWcmQL2cWAsYPhMzcxS7u?=
 =?us-ascii?Q?oyWzAmw59Tjt6IjjlTkXeIvbBtr8g8k3V3vGlndF9QVAD2VMw2SWphfwNhRm?=
 =?us-ascii?Q?L7KJ2/7jPvoeG+q6X763FcLp69Okwefa8hzNwT6ROkJzrOu5SWUdlcMUM4cW?=
 =?us-ascii?Q?bvq9iwrIok+kk6H6zYBJ44J1wJ/4X1u6GhRY3gj2XTf42pcCMvnHvSQWeKr8?=
 =?us-ascii?Q?q0C+1sc6le/tLfQg75BlJHZjLG99r8N7AQ6GmRk9cJFFg8oywFYpQnZ8B6B2?=
 =?us-ascii?Q?Hg8VJDtpObCcnGDRgTXkBpQlBj+gnk1cGSV39ZM4+5JHu0ELPPO2APgdyhMn?=
 =?us-ascii?Q?pdRYnb4vSJ2k07pwS3FoMZMPhk9Dz++rKHm39++QCHkUJrUq4zwLhnVOLByJ?=
 =?us-ascii?Q?peOyNVWm25qQ0fswardOmLm7zqClXBR9Y4kg2XAGzrLaXO4zhn1ubU2aT/sF?=
 =?us-ascii?Q?h+Yi48aCVyalndNqA1K2Qle4zACZfo18OK5Sfg2jjzEug3AZS6R14eQoXyTj?=
 =?us-ascii?Q?wvwNjiyowOr/wfUd5/bnVR9piMfebE/wNbhPtyLJwPh1MG9TW+QCMbpQfMOf?=
 =?us-ascii?Q?e9LgtP6lGV9MERvki63kARsba8dYArSZXgvitn5tIEgF5+NK7REZFIoXqhq7?=
 =?us-ascii?Q?o/fzWHothNfHrkwJGkgcHJp4X1Fix5TzbAfX2YrYre3BmandN2yKB1mxgE/p?=
 =?us-ascii?Q?Wfa8zw=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5qcg4ncVKvUL1lkcFHZ1d/uKODAbeFLImWrc3bDMs6uLwIoV3IP7ZemVWouVpDbVyYTvPoHiKANE++0k85s+kHEsyCY5nYCjInus7GyNDrmvFAYKpbhfLLhAXYpIgRC2zMsqS8Lv/qnXFDPtu+o7GzsvFUTI0qPZLUpo7Irj9853SB87uimU6GaGlmf/VfUhVI+FPEYCpfVoGq4OqM4KgpK9Kuzas9XbV5fZKTEnHlndFASJyeWie3oE1D8Fm3bFJKr5EtJknQnsI41fQRNWRT67Fszf/48v461P3xTkVmmpn+zkt8K3r8PAvy6/i4oLxNjzuAtWhaaj7T00M0kktJ+WbFgsNg8tsadgx3PT3i8AApWpcpzyO9JkgFBnm2A8E/a3dBDMo+JPA0AHzjQUg+/KdX7m4gcCctCVqWSHmW3fgN1ZUHjdMOQNbf8Nj2nw
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 09:01:48.8357 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 591a4b04-aa0e-43eb-8f90-08de6f958413
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9216
Received-SPF: softfail client-ip=2a01:111:f403:c10d::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=SN4PR2101CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
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

Move viommu teardown into a helper function and use it from the
last device removal path. No functional change.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3-accel.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index f5cd4df336..c19c526fca 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -390,6 +390,20 @@ bool smmuv3_accel_issue_inv_cmd(SMMUv3State *bs, void *cmd, SMMUDevice *sdev,
                    sizeof(Cmd), &entry_num, cmd, errp);
 }
 
+static void smmuv3_accel_free_viommu(SMMUv3AccelState *accel)
+{
+    IOMMUFDViommu *viommu = accel->viommu;
+
+    if (!viommu) {
+        return;
+    }
+    iommufd_backend_free_id(viommu->iommufd, accel->bypass_hwpt_id);
+    iommufd_backend_free_id(viommu->iommufd, accel->abort_hwpt_id);
+    iommufd_backend_free_id(viommu->iommufd, accel->viommu->viommu_id);
+    g_free(viommu);
+    accel->viommu = NULL;
+}
+
 static bool
 smmuv3_accel_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
                           Error **errp)
@@ -549,12 +563,7 @@ static void smmuv3_accel_unset_iommu_device(PCIBus *bus, void *opaque,
     trace_smmuv3_accel_unset_iommu_device(devfn, idev->devid);
 
     if (QLIST_EMPTY(&accel->device_list)) {
-        iommufd_backend_free_id(accel->viommu->iommufd, accel->bypass_hwpt_id);
-        iommufd_backend_free_id(accel->viommu->iommufd, accel->abort_hwpt_id);
-        iommufd_backend_free_id(accel->viommu->iommufd,
-                                accel->viommu->viommu_id);
-        g_free(accel->viommu);
-        accel->viommu = NULL;
+        smmuv3_accel_free_viommu(accel);
     }
 }
 
-- 
2.43.0


