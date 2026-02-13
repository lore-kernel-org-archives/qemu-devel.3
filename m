Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EAEDEDF153
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 10:44:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqqdv-00086I-8j; Fri, 13 Feb 2026 05:43:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vqqds-00085p-Uq; Fri, 13 Feb 2026 05:43:20 -0500
Received: from mail-southcentralusazlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::1] helo=SN4PR2101CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vqqdr-0006Uz-Cw; Fri, 13 Feb 2026 05:43:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ONxKWEArVzj0piFFCmQKbjAlqMkEp89Zh7VhUMtk44ahVbTSMMM6PNJ31v498U0SChxKCnVu5hql2DQAUix7B8KdmQBDJwDbvo0FjIF8GQ/Swlq394pwNgm1La1V808wch+W5II9ks9JxBZ5oqDZYLwa876CRktqzanL57vYQkaughmhsTDxdWQufn9Q1+lx/58FWG5L3qNlA2vV1ALaKMNb4vzS9m/VxMDEVEULGab5hGbogq0JvZJkUN8k0yDtuAJ+zStF3d/Fl//O2Eik5I/TwexneTRW6XUwON0iNQo5Shp8zPUSqO6f08Ku8vnpR48S5TPr0Z+X6R7q6oTiJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mHglJ2abxkStR6QvbiuUFMQSQepPlq05MA7T7PE8KFw=;
 b=BOsY1CCc8A+BZTyViTIaEr6hvipPNvsvyO/pKajloSBblldjv+azzSr1esNt/hFUYjOQmqDTrxRyQCeZ99mMq/SdZ1NqaixWm9NSlM50ik7jhXMyKCrZlkuf2MAUDeflDiPmQr1/oxmWyipw/fruSu8SrVPKEHYbYc3Adx4OIx5/Xxqt6UFWr8hB8r7vglKRre5P5TyNV8Ur5MGPIdEC9pA5aa12cKt+oVvQUSBqz/oadtVdlYCs/TwNbI3ZEys49t2T3LFnCDYb1THqaALaD9X+zFyEDcs4w4Smz9aT00O3eQN7+A5EasFm2W8yZQFTVUxG+48Am7GtDXCMq7q47g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mHglJ2abxkStR6QvbiuUFMQSQepPlq05MA7T7PE8KFw=;
 b=b0R2A/h8TA8L26ArnxYRz7tKcyxOD7LZGmwX/yiz2DMv/5zSj3jvjNjKrzFpeLejt5ZPtx+nwGWwAAyMwosW6nE7EI2hUbisC0YMpyH2cJG0i9DOgFI4GIFmHAsN8glw70nPkY6zb1bj+vS3hdZZ1zs55Pqj0UivWFVNyFNEqxla+U1iV2FdWoyWI7pLQhwyLdeV2duXKwHfNGxWxtqOExcQRnf+POAvy5kY2ZF6JcayVTNSmXVJZT3H2hLnIy2Tc4c0JpEzK9pIuXZfnbFdc5zCEv4D0r2SRLUDsqj36C9wWPts6dxzXF5cepLKjlh4yR4PRjTpxGs3gtaYRrsIuQ==
Received: from CH5P220CA0015.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::9)
 by DM4PR12MB8500.namprd12.prod.outlook.com (2603:10b6:8:190::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Fri, 13 Feb
 2026 10:43:11 +0000
Received: from CH1PEPF0000AD80.namprd04.prod.outlook.com
 (2603:10b6:610:1ef:cafe::69) by CH5P220CA0015.outlook.office365.com
 (2603:10b6:610:1ef::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.13 via Frontend Transport; Fri,
 13 Feb 2026 10:43:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000AD80.mail.protection.outlook.com (10.167.244.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Fri, 13 Feb 2026 10:43:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 13 Feb
 2026 02:42:58 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 13 Feb
 2026 02:42:54 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>,
 <nicolinc@nvidia.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <jan@nvidia.com>, <jgg@nvidia.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v6 2/5] hw/arm/smmuv3-accel: Add viommu free helper
Date: Fri, 13 Feb 2026 10:39:39 +0000
Message-ID: <20260213103942.142823-3-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260213103942.142823-1-skolothumtho@nvidia.com>
References: <20260213103942.142823-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD80:EE_|DM4PR12MB8500:EE_
X-MS-Office365-Filtering-Correlation-Id: 678b1bc7-2031-4e0a-0c2d-08de6aecaf09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oTZc7JIdYhXL/DPLMdd5lq4dPh4OpUbGWtSKNvF2e7npxpNLtrTN9CWRXFo4?=
 =?us-ascii?Q?ccRIWEaIhkhWzoG/WDtQRfMPC1xD0BjVjVzdjOrSb7Uin+I50Fnl+IxmQm9H?=
 =?us-ascii?Q?Nw2AMza0ADkijlnHxxZDL8A0psaJhC0iTBOehvZMA1AUzcjbtC1DqgohPQ7Q?=
 =?us-ascii?Q?8ntLJF++UCK7BsYvYOx92FtGhSBksJ2M3AFeYYFPNym7axILU52BmJb5LDdE?=
 =?us-ascii?Q?tKleJEp2ZAsIfdT5gG0Bihg+MPd6/AiI1BBANOFtogzUVmL0/Sk7U6YcK9qj?=
 =?us-ascii?Q?jYRsLA314EYwtkDt9YxfYMaLqI3ilHFYIkPKgoI+pTwYmf/NMs6JbgGlOVQw?=
 =?us-ascii?Q?uSzvHts+p8ld9LhayKPsRonU85POkhh0we1C4ogWdduvPJIf7qIHJJnKEW55?=
 =?us-ascii?Q?MZ2jxSfQ6X6YrCDpJC8Nxxc2jmK8AgHUFoLxe52aY6L8kHGdUymKJ1twN3GL?=
 =?us-ascii?Q?ybduI3VtoD/0RySyabloNdjFpGBC95t8wH1pPGRqvVCgjNRpxy14hgKNPtsX?=
 =?us-ascii?Q?WJMLs711wraUY2p0KZCVAG9Eey1K9yh6VsbC1WDcj6IoirhNHZjZcspaCk3U?=
 =?us-ascii?Q?HUWryAWEWt+y8a5u6MqRdrD+LP9/gBe0PPGyVddhyKU7gApGjwSsbkBNT8Kf?=
 =?us-ascii?Q?7+VTivw+Dnboe5fNQjg8dXy4LjhRhnwHuwD+KQrkUHa4umu4Or4jxZMchhSF?=
 =?us-ascii?Q?IRaVsvKIKXg3WPbcJ8aWMzE7ecV3aq7E/t+ySHbT+S1Awl4jTsk++tesN7+J?=
 =?us-ascii?Q?Tmom83ZHeibrYUqpgqE4Kyv96s8qXqyeqsAWJbLIESLtlRK/xA1/o8eaa1oN?=
 =?us-ascii?Q?6Hpu7AaJywoqLSeHe4Wt80OmwHZNjR3DmOB9WX9dIpLvHxvcMrAqwxiupTfR?=
 =?us-ascii?Q?0fbQalCt21oAiHpos3V9/R7MXKANGhHypULG2osMt61IsYS+tDQm9ATd/ayk?=
 =?us-ascii?Q?n3oIm/7qo4AuH15uwKdJMq8DQGU7jTphmSVbI6yB+5CWiefhkSwkcRlbToJL?=
 =?us-ascii?Q?9Ye8q4K+w0qNGKNoxwpwtuxFtlMfPsrJPmseTYHEvlhk6zFPCZY+ZGk37gOr?=
 =?us-ascii?Q?ekNGnFBpHmvmKFFTx4jesCs3adabbSRJWR7krYp8n14sFZKnmTTpdsiurjWB?=
 =?us-ascii?Q?GydUuUTkSQv+ouUOhxRjLBbSswWEPc2YdvA5DO2YER9YgJj79GENCfBUpaGw?=
 =?us-ascii?Q?yGXB7vJ3AbQAnMmsVVoQKC2OB4+rk2CaiCtumuNpDvkdBMuqicKCZbOJX0Zj?=
 =?us-ascii?Q?gj4tIXfD9N9rP9i6+ovdnkDzdqH/8WLNDcd7IZIEkry8jREoh/5NCYpH2ET/?=
 =?us-ascii?Q?97YjQNd8Ljeo9iozazNIxZQJmFABecOIS8wozT+PEOj0DTqUSAVbyqUtnsKW?=
 =?us-ascii?Q?xACCvHSazKFX//bNqD0+NqSpYV5e02rIcpjf/oOv96yNqczOrY+PwjKq9jIA?=
 =?us-ascii?Q?wWcKScORiagV3CWEM92CARmN1prxG8wcAssOLfSqvAVJgxi/GXawAHXC/gmz?=
 =?us-ascii?Q?5dd9m1WxC0lRo6nVaEkSRM2/m+isDdPVJouna4HgFnL3Nh60H9YStDE71Ogm?=
 =?us-ascii?Q?3fAlwc2CtsuEm7MoKk0I9CEXf32BKRCR7hczqKdmRCifAzLfigAXOqMKER+O?=
 =?us-ascii?Q?7udgaOsAj0bPUonfsbtQIQ/Kq0Ezdb+ZjqkmnqxHvnMe7FZRRX2g3xcOvGGh?=
 =?us-ascii?Q?3yIK/Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bLyjio69L/nvMUx1PbtqXmcxwz5kxGpOE43PyxZE8g+eIaVGHVqoozsQBCNmV5Zf+88vAYHKPdBhL4sOJ23WnpNxKdi8pCamyXOajf7OdDDikg/z8Ue46MEs3sId88fGQqesqBIxK3py3A4bQ8MhWAIzuG+gAhG1fz3Q2HUXseem68A9XWY0Mx/XPp7LU5C9LRgX+jE5JjcaT7uYqrq9GubKLaIVJferT3fRyeTgmsRvNawp0IJOCn0ssK/Lvz0puurX12J8NXOq520SXQ54kPOKZyUuqgkE54OroR6EbhDeCsita38CrzYj5NQ0FBrivEE/c8aMmMfAfnUducEio0L8IVKZD3c4U+iHkiB0X4augD9nC7RnSrVtXiPmVBwYPDDdbqZqVKagOHdPc6P0IuFHEOMuWZkIsy6/pF2Md21Qzff3bo/SP03wod4kC7yX
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 10:43:11.3238 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 678b1bc7-2031-4e0a-0c2d-08de6aecaf09
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD80.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8500
Received-SPF: permerror client-ip=2a01:111:f403:c10d::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=SN4PR2101CU001.outbound.protection.outlook.com
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

Move viommu teardown into a helper function and use it from the
last device removal path. No functional change.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
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


