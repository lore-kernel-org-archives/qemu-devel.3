Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48CEECCF9F8
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 10:54:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEmkT-0002nn-NH; Fri, 31 Oct 2025 06:52:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vEmkR-0002m4-A5; Fri, 31 Oct 2025 06:52:47 -0400
Received: from mail-westus3azlp170100009.outbound.protection.outlook.com
 ([2a01:111:f403:c107::9] helo=PH7PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vEmkH-0002t3-MB; Fri, 31 Oct 2025 06:52:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iML5klru9A0movI9oS4Ef+XqVzQHgb7gL4fU+TfH68nMuH6mgZyDZBtZa8oh56VEZdW/0Kldz6Tnyw9uegRZX7j+UYApnxm/ZFPJdOhwYXqZpG0NTmVEG6OQvhm3dqpexGuOby5SbdW3uN+i/DG7hdgMW/Bi3ihSwaDAzrthYqtWGyn61p9y7Z3L0Ue4Eu2JGrbJAv7cYFo1MafB0mXlRIZIa1dcdsPHdeILJjLr4DVgf4Cpl0CbIjy9iZWta0xG7Rsf2fKAO3DsYIrJ9ihat/znaZlueI70cEM7F7DQNU7tPK1BI8ctt2fHB9ZY99EyVolEH0NIjJEc+5WB9RFFvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2YTS3iXzIG+DnCnRnItzlaG1sH31jn47M1SaiNks5Ew=;
 b=Hioia6/RD/TLXFdf9dhgKg0VE5LyMMlUSiyX3aHAprandITYEYhZ5m0lMDO+EFDjxrE5XVsEtPItgjidPY7FTSV7eyaORnQB6dNS8emyf3hke+TR459k/ZR1ucbEYktohKwjux3CA4AU8Q2C17nUqPlSpsw88093zJmU8lFxQereaghHbK45Nlk6Y7i/FASmVAnwfw5XXwQryaT1AdWjsIQgTvC2WRjbfC69HVgRlpn9g9+g8rcdIkoe5ViixhKX0zEMTvi2FVVyftdNLRf9OH2s3Al5BrdToexFvOK7JZsiFdp9TEwOxuoYBML2+cDyRf7RAfktMhj3xmEdf/17rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2YTS3iXzIG+DnCnRnItzlaG1sH31jn47M1SaiNks5Ew=;
 b=tmNfBcWZxs6omwhvjGvgplVSkB8QzuOTXIc1X9hjt0lMmboeVCF3GctxfUI1JPpjlnSE8Ay4igobPbLEZb6plhD4tDBbKHlcrVztrN3zk3G34dmCIP4oMpl6hjgexSY4r2DENcIxJZH1dQKT5M9EAmxNhYhWb509SEitaldKEDOR3IR9F/O+43LnRE+WLdb8kVPMGdsKCWFynqW/xaAGwwTeW9XFNvkBWXFM8QwDhJcyL4Gpkcew4q+Q/nEUNTV1oxvGGGVRdIixij5iEQOJ+N9J3/8rY+SwgdWtBfQ6i2teXyXXVkgN4Z36OlPoU3Shc7ckC/N0wEzAeLS6vYX5Dg==
Received: from DM6PR06CA0079.namprd06.prod.outlook.com (2603:10b6:5:336::12)
 by CH2PR12MB4134.namprd12.prod.outlook.com (2603:10b6:610:a7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Fri, 31 Oct
 2025 10:52:28 +0000
Received: from CY4PEPF0000EE35.namprd05.prod.outlook.com
 (2603:10b6:5:336:cafe::20) by DM6PR06CA0079.outlook.office365.com
 (2603:10b6:5:336::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.15 via Frontend Transport; Fri,
 31 Oct 2025 10:52:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE35.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Fri, 31 Oct 2025 10:52:27 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 31 Oct
 2025 03:52:22 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 31 Oct
 2025 03:52:19 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <kjaju@nvidia.com>
Subject: [PATCH v5 02/32] backends/iommufd: Introduce
 iommufd_backend_alloc_vdev
Date: Fri, 31 Oct 2025 10:49:35 +0000
Message-ID: <20251031105005.24618-3-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE35:EE_|CH2PR12MB4134:EE_
X-MS-Office365-Filtering-Correlation-Id: 5031938c-fa5b-4ed5-0f8f-08de186b9525
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|7416014|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uxF2c+B2B5VeBj+5Ef0SQw7puq2lfiCAvmg2X7fAkq5NdDaZ8J53VwIkH7gG?=
 =?us-ascii?Q?s2TMJYZt5BY/UFdmMND+oCRcOeMo/xqXJk9QlTnAonMjcXQU8CAD65WTNhmF?=
 =?us-ascii?Q?QFpHDpKTvdJLe1FcitzdiBTzGMmOQtwUGw3mVDGb8Le5/9ELIlr0JKtvJlDl?=
 =?us-ascii?Q?rBDE3/ZO11Z+BguRG9+uZgd7MOWUKOipIjGAIdBztgPRp3SqAxfSzz5WW+pp?=
 =?us-ascii?Q?eUjO6ZOxkHBzwACQcVtLhefelVcTUmkeYnykt/8ary/aPU/3f0i21dY6I2op?=
 =?us-ascii?Q?cDBhJBliLeV2UU8khf7bLPiAPNoV3S4fXIMR9RL9BrSsniC1kifl4Gf1GTpO?=
 =?us-ascii?Q?UcGpq7W+QQYG1Rutfpm8Ym4Tnj08c8UbRkeNkdbw2++vGR6lU/v+mMgI6bon?=
 =?us-ascii?Q?gMT/hSo7m+P6UbCrMhWXDSjlifiANmddHBCmlWi16zJpRrOotM/Yii9IKTjP?=
 =?us-ascii?Q?WKDroUUsrHYBDbCzCWDGKq90g1fGUebUMjGF5OmBMwmqnzvr9bOvUiI17pv2?=
 =?us-ascii?Q?LBoKmgweXqEtVLzFMKtlasAlBCVEC8iZe8z4KNKmN2RiefFLQwhwHP3ZcYVq?=
 =?us-ascii?Q?ZZ1+k/zQDnKC7MVjU/njHYOojUa6vUUnK++g9tFt4O+dSEXsgUNl1IANYNvq?=
 =?us-ascii?Q?JTkIROU+4EwPVOVSD6JuRO3RkXAyCH51wBfpv3CRJnHfoBxAgznGvsSEhx63?=
 =?us-ascii?Q?aq988Fuuj1W0RSjq0PcCdlLhMKtp0PB3lxrFzhmJtO9sjY0d4aE6tevN5epe?=
 =?us-ascii?Q?HiRJL2j2ki1+K5YSt/tY06CrfZVESstzJKMAi3zsqM0bKTxUaDLTgNijBOrG?=
 =?us-ascii?Q?R9yLUUeSQgpSeZ/NbHlQUpkofw+kk/pvSoR+TmaHkIOgXu/VO2nuQmIIj5kj?=
 =?us-ascii?Q?H8l9kcALym1pXofiaPKaMZnrtLSD/bcfdopjdJI+N38LxPuHtS3tIIxU/kOC?=
 =?us-ascii?Q?XUYcDrGEfltmRM5wX93RQN/oSlCn+LK6o97h/ZKbX0caQBuJ255Dzcmwkkso?=
 =?us-ascii?Q?puzv9rV2qV3eYJ/QlWjUfbUvHJPHeLEm+GlSz9851FJMrJ3isxQ3xGSJ9TUn?=
 =?us-ascii?Q?ANd4xLklBzvLlWAdZ/sCqh6xXKpQ//k7FBDIDzF6MveWnk5BJvyRUjs3MhIs?=
 =?us-ascii?Q?Z9u6Zwx6umS1ohPKDg8BXtdJEWUOLVgZAhpxWPYFtRFc7mLeyPbryRC+6UN0?=
 =?us-ascii?Q?wzFD0yCJ8AbwruFJRyU1eNfCap3LhYcwbhNcypkXuUxbEcHdVZ6UIA1omArX?=
 =?us-ascii?Q?8N4n+qtrBouve4rnKKr6psZsuY3N+dQB/EEDSXDTm8wE1m5zvEmfC0mcR4rz?=
 =?us-ascii?Q?RoQSVYunPx8+d/nkCgAwA4NLcolAnNE0RffZnR3Gqd9QzZC5boi3Kc5RSVNk?=
 =?us-ascii?Q?v/AlzxxqKAj14ZeaAGb+KKhqaa0nUEnWmL2JSvlRlSZmzfY8bZRDBM/LPt+n?=
 =?us-ascii?Q?PiwLy7Gi6Y2mlKHDyQtSJAH8WIG4wG6MNKHvPk0wetoU5Z39LLlaMlhSgJXb?=
 =?us-ascii?Q?ytRPiJtWnobpdeRFtkHezECt8XXdQnmN6UTHIvr24KnZMkQTX8cWL15QVBlC?=
 =?us-ascii?Q?tv45Bh0W/eUjjSELMFs=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 10:52:27.4976 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5031938c-fa5b-4ed5-0f8f-08de186b9525
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE35.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4134
Received-SPF: permerror client-ip=2a01:111:f403:c107::9;
 envelope-from=skolothumtho@nvidia.com;
 helo=PH7PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_NONE=0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Nicolin Chen <nicolinc@nvidia.com>

Add a helper to allocate an iommufd device's virtual device (in the user
space) per a viommu instance.

While at it, introduce a struct IOMMUFDVdev for later use by vendor
IOMMU implementations.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 backends/iommufd.c       | 27 +++++++++++++++++++++++++++
 backends/trace-events    |  1 +
 include/system/iommufd.h | 12 ++++++++++++
 3 files changed, 40 insertions(+)

diff --git a/backends/iommufd.c b/backends/iommufd.c
index 3d4a4ae736..e68a2c934f 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -472,6 +472,33 @@ bool iommufd_backend_alloc_viommu(IOMMUFDBackend *be, uint32_t dev_id,
     return true;
 }
 
+bool iommufd_backend_alloc_vdev(IOMMUFDBackend *be, uint32_t dev_id,
+                                uint32_t viommu_id, uint64_t virt_id,
+                                uint32_t *out_vdev_id, Error **errp)
+{
+    int ret;
+    struct iommu_vdevice_alloc alloc_vdev = {
+        .size = sizeof(alloc_vdev),
+        .viommu_id = viommu_id,
+        .dev_id = dev_id,
+        .virt_id = virt_id,
+    };
+
+    ret = ioctl(be->fd, IOMMU_VDEVICE_ALLOC, &alloc_vdev);
+
+    trace_iommufd_backend_alloc_vdev(be->fd, dev_id, viommu_id, virt_id,
+                                     alloc_vdev.out_vdevice_id, ret);
+
+    if (ret) {
+        error_setg_errno(errp, errno, "IOMMU_VDEVICE_ALLOC failed");
+        return false;
+    }
+
+    g_assert(out_vdev_id);
+    *out_vdev_id = alloc_vdev.out_vdevice_id;
+    return true;
+}
+
 bool host_iommu_device_iommufd_attach_hwpt(HostIOMMUDeviceIOMMUFD *idev,
                                            uint32_t hwpt_id, Error **errp)
 {
diff --git a/backends/trace-events b/backends/trace-events
index 01c2d9bde9..8408dc8701 100644
--- a/backends/trace-events
+++ b/backends/trace-events
@@ -22,3 +22,4 @@ iommufd_backend_set_dirty(int iommufd, uint32_t hwpt_id, bool start, int ret) "
 iommufd_backend_get_dirty_bitmap(int iommufd, uint32_t hwpt_id, uint64_t iova, uint64_t size, uint64_t page_size, int ret) " iommufd=%d hwpt=%u iova=0x%"PRIx64" size=0x%"PRIx64" page_size=0x%"PRIx64" (%d)"
 iommufd_backend_invalidate_cache(int iommufd, uint32_t id, uint32_t data_type, uint32_t entry_len, uint32_t entry_num, uint32_t done_num, uint64_t data_ptr, int ret) " iommufd=%d id=%u data_type=%u entry_len=%u entry_num=%u done_num=%u data_ptr=0x%"PRIx64" (%d)"
 iommufd_backend_alloc_viommu(int iommufd, uint32_t dev_id, uint32_t type, uint32_t hwpt_id, uint32_t viommu_id, int ret) " iommufd=%d type=%u dev_id=%u hwpt_id=%u viommu_id=%u (%d)"
+iommufd_backend_alloc_vdev(int iommufd, uint32_t dev_id, uint32_t viommu_id, uint64_t virt_id, uint32_t vdev_id, int ret) " iommufd=%d dev_id=%u viommu_id=%u virt_id=0x%"PRIx64" vdev_id=%u (%d)"
diff --git a/include/system/iommufd.h b/include/system/iommufd.h
index 11b8413c3f..41e216c677 100644
--- a/include/system/iommufd.h
+++ b/include/system/iommufd.h
@@ -48,6 +48,14 @@ typedef struct IOMMUFDViommu {
     uint32_t viommu_id;  /* virtual IOMMU ID of allocated object */
 } IOMMUFDViommu;
 
+/*
+ * Virtual device object for a physical device bind to a vIOMMU.
+ */
+typedef struct IOMMUFDVdev {
+    uint32_t vdevice_id; /* object handle for vDevice */
+    uint32_t virt_id;  /* virtual device ID */
+} IOMMUFDVdev;
+
 bool iommufd_backend_connect(IOMMUFDBackend *be, Error **errp);
 void iommufd_backend_disconnect(IOMMUFDBackend *be);
 
@@ -73,6 +81,10 @@ bool iommufd_backend_alloc_viommu(IOMMUFDBackend *be, uint32_t dev_id,
                                   uint32_t viommu_type, uint32_t hwpt_id,
                                   uint32_t *out_hwpt, Error **errp);
 
+bool iommufd_backend_alloc_vdev(IOMMUFDBackend *be, uint32_t dev_id,
+                                uint32_t viommu_id, uint64_t virt_id,
+                                uint32_t *out_vdev_id, Error **errp);
+
 bool iommufd_backend_set_dirty_tracking(IOMMUFDBackend *be, uint32_t hwpt_id,
                                         bool start, Error **errp);
 bool iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be, uint32_t hwpt_id,
-- 
2.43.0


