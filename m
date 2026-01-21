Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F27ECC44506
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 17:57:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vicQO-0007Va-AU; Wed, 21 Jan 2026 12:55:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vicQN-0007Rk-0L; Wed, 21 Jan 2026 12:55:23 -0500
Received: from mail-southcentralusazlp170130001.outbound.protection.outlook.com
 ([2a01:111:f403:c10c::1] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vicQL-000104-E7; Wed, 21 Jan 2026 12:55:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RpGGdP3d0aa3x+zBlgkoNlEg7jh3K4Tenf0OedVQ3msamCXPfgvw9sPjz+aX0GgnVhlgxxMbWVz8g/EENj4n4E9IxzE0jui6+Q3VSZP8cSykhxM69bJtQPqlFlLGZU48+bP5wqdKajZZ3+0uIaRMOD/zpca+S3LEykwIYvK9Jxc+LJAbrwsFCoqDti+sH6eTHw7Z5QULekytZwBG6Bd5a52ln/g45bVevulUFx/XWtQz7J39Nck24ufRwzXigRp6JwWtRxncUWe4Zd1D+QyFWHcS/DHfyEEm9GKQNKkZIDhcjP7oZ89Yu4CxiJwe9ZQkj7NgcnDRqrQmRx3LA7b99g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ItAZUsrNP/kQbD1XLZycfFYOYS11uWOEy8QUfDmF3zM=;
 b=BnDutuvOZn68erL37hpYPH0mn12SQgaYUfMc0PbaLv2SqDr6pJyBer18QSovF7QOyxmiHVt3HEwSgSi3kS1qgCohc7PPYEfWe/IWFp3ma7ZhYRv6tMWAIo/UlE6X/MpZ8kDDEF1FsHDi79kge0v8Nc6ejf2A3sStYoHbRbJ1Fxj/m3Ure1XhZMZug7NPeCSHh+An/rGr90fn2llNPqTYFx0SNEdmPE+YhClCk3h1BbJjHPCel3p193b/GYtnF4ycUZoJ4UDwzVjh4byW1/ZnIdy0KIIejZKeflKH7+ZA9sSS3Ad1CSCC8scOiChloOPXSNoeICS0nPSDcEbUNDvlkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ItAZUsrNP/kQbD1XLZycfFYOYS11uWOEy8QUfDmF3zM=;
 b=msvRoXJfpYxz8t1Sg01LfyTBC7hHk2dv3Ibh4ntrZqUUridYEGyXWkdgkHjUAhk6dqxxXh4nesMlSl0bUu4QyPvdwL7EXwbIU//9KXdks1vuAioTyPRWvkXu4wcQ/IP6ntgsGGz4k7euuQMjS7caLTEeQqNm5zBEkITUqMO156r0CNWEgwuJcgZVYkkeJgzfJDs46q0QTNwih4zzw9W5iW36xE3NARHpYX0m0pP7RYKfhGc4vwyTI3V40tFf3ZTXkP8wYOjtvQelAZ87TGWhibCK9NVVCRoUvxRarhbzCj1+oKvN0ETdGcheYWNK8A24nbOweaoWrk7Cx/KBS3iBNQ==
Received: from BN1PR13CA0030.namprd13.prod.outlook.com (2603:10b6:408:e2::35)
 by DS7PR12MB5912.namprd12.prod.outlook.com (2603:10b6:8:7d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Wed, 21 Jan
 2026 17:55:13 +0000
Received: from BN2PEPF000044A6.namprd04.prod.outlook.com
 (2603:10b6:408:e2:cafe::89) by BN1PR13CA0030.outlook.office365.com
 (2603:10b6:408:e2::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.3 via Frontend Transport; Wed,
 21 Jan 2026 17:55:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000044A6.mail.protection.outlook.com (10.167.243.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 17:55:13 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 09:54:55 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 09:54:50 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <clg@redhat.com>, <alex@shazbot.org>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>,
 <kjaju@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v8 01/37] backends/iommufd: Introduce
 iommufd_backend_alloc_viommu
Date: Wed, 21 Jan 2026 17:52:06 +0000
Message-ID: <20260121175248.87649-2-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260121175248.87649-1-skolothumtho@nvidia.com>
References: <20260121175248.87649-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A6:EE_|DS7PR12MB5912:EE_
X-MS-Office365-Filtering-Correlation-Id: 97fe4c36-d4c8-4474-dee7-08de59163a38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|7416014|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tksRDDX1aJXXNfDtBu+xJ7ZCpLGkA7PIB3duGqq5t2Ef2cDOYa7O05E0ryp/?=
 =?us-ascii?Q?J6zyY6kHtvfaa5iT0UolZ5RapRJdPulTEdP6dylGhRuvoZG2TnH3GISgja5i?=
 =?us-ascii?Q?ZTvyFrXzdNL0dkgvi2cn0C7qGtPu3Fag4BiUqGB1t98EhgH2IpE09/45rTvq?=
 =?us-ascii?Q?mY+97UJKXCah3MyVxMWPoEVIFhJL9WGbjMSt8VLZFfH+AIvGcQkFsjjDpKNz?=
 =?us-ascii?Q?MMIYE6Z6YR/TRZK+JBOmNx1SgoatYhpsIQcuiPjYwhFeLw1Asl2voGJybxra?=
 =?us-ascii?Q?Xp+bgoCmYSnQ3TXtviaSNYtvOl/2UMpkljW9l+3nx7UVm9e/C5ODa0OTsXx1?=
 =?us-ascii?Q?jiqU/5SWeduGM4HZtlurIJNk1juJWGPFMcosSlXJkvT2VP3ZYKmSr6DUYGcw?=
 =?us-ascii?Q?iXfpzUFzCTSeSVHlt01SsOvgroytdsLawboI1hz9C9/TnVtVXT/4AFsmQCte?=
 =?us-ascii?Q?MwVb5OasPl2HJMJkD14BdqV5faJgOaWwUbQpaPR+BL0+jP62z0xgsOuwSkl2?=
 =?us-ascii?Q?4Zj2L9emkABYgCsoOJ5nFK/4YaL4FUMCvDQkz/DAyK8qPSOPHtu/baKXy5So?=
 =?us-ascii?Q?zmtJTUv+8/gkGc0poUQCnI/uILvr3hiV3Cw955q3Q3SK0aYSN76Xl36VRYtc?=
 =?us-ascii?Q?3BOSCoom43Etl4++kCICnTB1PPWI4mWyONkslSJ2NohuMYXc23B99kCuZ0uQ?=
 =?us-ascii?Q?L5LW8CLPpLc9LKNAB+/j5Qkhe2RKNb6GJJJ7he/oK22zJZnJGKGsI5F3sRQ7?=
 =?us-ascii?Q?Gizu1ZpmTLfRc1PVeuG3pcq2ofIx4XZ1NAiK0xVljUZttyiPoYReHp3hFZUo?=
 =?us-ascii?Q?GXhbP19mDpoDVDH+/rh18Bzk0LgXjlwPjj63vv4JLM4wk/GzckVL5LBJPeWu?=
 =?us-ascii?Q?jmCmU0R/4xNzCn38puQAd9qkEMLD8UBKiwly7ogCZWDMhC2YtsV4lGukvzuK?=
 =?us-ascii?Q?rf5bYYmBFahbmu6bObBhSPCQPcIQeJvEwcgvMR/qWfOO9NUul7XKycQVuAf4?=
 =?us-ascii?Q?ZsJUE1hAbr1+3GY/4hIfw2wUiGeHDubR1XhdQuBsqjchUXabUbOw2YbHhYK3?=
 =?us-ascii?Q?Ap1wEGkUFo1DUeaFcI4dajJB4EblKJ9R54y7Nrw6YVSUWVhu6UgwE3OKNabw?=
 =?us-ascii?Q?T1kmmQrgmXBabsJ+kcV5fgTA7MkDHYp8GN4Wtz9cxnDu2vyaElzAUllSiz9T?=
 =?us-ascii?Q?UMH5xtWsLw61Wph8Q7KmVqcffJB5CCyVsZrk9f+DvzJa9E91oxo0W+WiiwMJ?=
 =?us-ascii?Q?rv23JF7DftQjCE+h0XfAboKKiXn2sJs0+ZDddMGb27rSzfsyh4BAkfdf/ry0?=
 =?us-ascii?Q?o1mLgARFnCmzU4xoXs+LlLx0nAhAw3q+8oqHDPJh17+xrWulefGyzTuQow3R?=
 =?us-ascii?Q?vbGg6KDlbILRvbgJ2K8hCbuFdLLJMYjePsVC1P3coThhtNwM02yg46bKfTKw?=
 =?us-ascii?Q?4PFlRxUewIhbIOhG/e7fZF5fRWNLgZPRpKcvH34AYQX37aDMhmNRi0XhrntO?=
 =?us-ascii?Q?ISpk/k5EsVvBkxkpur597aqfKPhHO0YjkG0RtijRx0TjXgkdegb+9aT8Hgkw?=
 =?us-ascii?Q?9l0Lnp/La8hp/z7D5sm0k4945a3HDq1Up8qE8fohX8iIgQgWFZtScmkYEuJ/?=
 =?us-ascii?Q?Zn7MioxoTuMRautIjVETK9SzQCMhsz9vgqWVqIpXNpzaSXU5NOQnvoXochAD?=
 =?us-ascii?Q?ibOd/w=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 17:55:13.2330 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97fe4c36-d4c8-4474-dee7-08de59163a38
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5912
Received-SPF: permerror client-ip=2a01:111:f403:c10c::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=SA9PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.069,
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

From: Nicolin Chen <nicolinc@nvidia.com>

Add a helper to allocate a viommu object.

Also introduce a struct IOMMUFDViommu that can be used later by vendor
IOMMU implementations.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Tested-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 backends/iommufd.c       | 26 ++++++++++++++++++++++++++
 backends/trace-events    |  1 +
 include/system/iommufd.h | 14 ++++++++++++++
 3 files changed, 41 insertions(+)

diff --git a/backends/iommufd.c b/backends/iommufd.c
index 086bd67aea..c65dc41d71 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -447,6 +447,32 @@ bool iommufd_backend_invalidate_cache(IOMMUFDBackend *be, uint32_t id,
     return !ret;
 }
 
+bool iommufd_backend_alloc_viommu(IOMMUFDBackend *be, uint32_t dev_id,
+                                  uint32_t viommu_type, uint32_t hwpt_id,
+                                  uint32_t *out_viommu_id, Error **errp)
+{
+    int ret;
+    struct iommu_viommu_alloc alloc_viommu = {
+        .size = sizeof(alloc_viommu),
+        .type = viommu_type,
+        .dev_id = dev_id,
+        .hwpt_id = hwpt_id,
+    };
+
+    ret = ioctl(be->fd, IOMMU_VIOMMU_ALLOC, &alloc_viommu);
+
+    trace_iommufd_backend_alloc_viommu(be->fd, dev_id, viommu_type, hwpt_id,
+                                       alloc_viommu.out_viommu_id, ret);
+    if (ret) {
+        error_setg_errno(errp, errno, "IOMMU_VIOMMU_ALLOC failed");
+        return false;
+    }
+
+    g_assert(out_viommu_id);
+    *out_viommu_id = alloc_viommu.out_viommu_id;
+    return true;
+}
+
 bool host_iommu_device_iommufd_attach_hwpt(HostIOMMUDeviceIOMMUFD *idev,
                                            uint32_t hwpt_id, Error **errp)
 {
diff --git a/backends/trace-events b/backends/trace-events
index e1992ba12f..1ae94c4290 100644
--- a/backends/trace-events
+++ b/backends/trace-events
@@ -21,3 +21,4 @@ iommufd_backend_free_id(int iommufd, uint32_t id, int ret) " iommufd=%d id=%d (%
 iommufd_backend_set_dirty(int iommufd, uint32_t hwpt_id, bool start, int ret) " iommufd=%d hwpt=%u enable=%d (%d)"
 iommufd_backend_get_dirty_bitmap(int iommufd, uint32_t hwpt_id, uint64_t iova, uint64_t size, uint64_t flags, uint64_t page_size, int ret) " iommufd=%d hwpt=%u iova=0x%"PRIx64" size=0x%"PRIx64" flags=0x%"PRIx64" page_size=0x%"PRIx64" (%d)"
 iommufd_backend_invalidate_cache(int iommufd, uint32_t id, uint32_t data_type, uint32_t entry_len, uint32_t entry_num, uint32_t done_num, uint64_t data_ptr, int ret) " iommufd=%d id=%u data_type=%u entry_len=%u entry_num=%u done_num=%u data_ptr=0x%"PRIx64" (%d)"
+iommufd_backend_alloc_viommu(int iommufd, uint32_t dev_id, uint32_t type, uint32_t hwpt_id, uint32_t viommu_id, int ret) " iommufd=%d type=%u dev_id=%u hwpt_id=%u viommu_id=%u (%d)"
diff --git a/include/system/iommufd.h b/include/system/iommufd.h
index 1392706b83..bc4acd1e8b 100644
--- a/include/system/iommufd.h
+++ b/include/system/iommufd.h
@@ -38,6 +38,16 @@ struct IOMMUFDBackend {
     /*< public >*/
 };
 
+/*
+ * Virtual IOMMU object that represents physical IOMMU's virtualization
+ * support
+ */
+typedef struct IOMMUFDViommu {
+    IOMMUFDBackend *iommufd;
+    uint32_t s2_hwpt_id; /* ID of stage 2 HWPT */
+    uint32_t viommu_id;  /* virtual IOMMU ID of allocated object */
+} IOMMUFDViommu;
+
 bool iommufd_backend_connect(IOMMUFDBackend *be, Error **errp);
 void iommufd_backend_disconnect(IOMMUFDBackend *be);
 
@@ -59,6 +69,10 @@ bool iommufd_backend_alloc_hwpt(IOMMUFDBackend *be, uint32_t dev_id,
                                 uint32_t data_type, uint32_t data_len,
                                 void *data_ptr, uint32_t *out_hwpt,
                                 Error **errp);
+bool iommufd_backend_alloc_viommu(IOMMUFDBackend *be, uint32_t dev_id,
+                                  uint32_t viommu_type, uint32_t hwpt_id,
+                                  uint32_t *out_hwpt, Error **errp);
+
 bool iommufd_backend_set_dirty_tracking(IOMMUFDBackend *be, uint32_t hwpt_id,
                                         bool start, Error **errp);
 bool iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be, uint32_t hwpt_id,
-- 
2.43.0


