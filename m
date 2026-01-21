Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2747EC44508
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 17:56:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vicQW-00081r-UW; Wed, 21 Jan 2026 12:55:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vicQV-0007xE-5v; Wed, 21 Jan 2026 12:55:31 -0500
Received: from mail-westus3azlp170100009.outbound.protection.outlook.com
 ([2a01:111:f403:c107::9] helo=PH7PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vicQT-00011S-Ck; Wed, 21 Jan 2026 12:55:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M92ixPd/i9qMyznxBZevuRMTXmMQ2dWRBVNJKbZf2knubDsy4LrPkTfSksJ1wOpdWxrYII2Wyi5FrtZVJPDG4TElx2XZBHjizIs4sCaW7BI1UUpahVPlNFA7c5C53rpZv3+iSuaAdRu1xtpDxCR0js1oFylCAE8k6/my1gorZvZxQbz/b2cyhMcAGnc+EFN0bXs1lIaf+3qhnLECu2X6/8oG74dQ/O/oj/ysfYNQXexjM55Wa8AjAvmXckcVpKdJ4r9s6UKZtf0ilkSLrVtthI5JI6/ykO2E5y3o/hNkwobHGgMEese5qndXcbmnrxg8J947PjI2N818dMkhB+rdnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TTIwjt1gOPpcKklu4rXxoF7zGNlWrWPuD4ZGhLf5xZs=;
 b=hxudjcEhDx/597lUv9bxPzZqF0+kin1XzKlKtAfJDqqh0hSizI9cIR2vE4vwReN75xKcNCffxKNwxvj1JV8j9raukZh0y8flXmz4ACa+znI0aXOLzycKFvh3HaY5zqhj0nFmWnnnyzUM1Fc0n2WMbk54idwKSka0/sN07pTZceQ/TMm/VzkZk5lqXx8adfLr+oktwzuRPk4ejBJFeysAJPj+Amm71wJQzydsDGPimuSkl7HZ41kbCreZYHg/qb/gRH+FaTmU7Pf8hJGWQKa+o+zyoiTEtMKkA5uOcgSsyFe40nsC+zQ7DJT0AcAghx4fvQ27ACDglgcUKpzjycEXpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TTIwjt1gOPpcKklu4rXxoF7zGNlWrWPuD4ZGhLf5xZs=;
 b=gV/3ODufddI20uPt1DNraeHJaNkHDXDw4Y0CAdstBIPsUFrrz0dt6649T+sQgs6HuwZAzRMLkzGr2Gf8tX8fql+Hdoy8264IXwZG4ZLWAu0wceWZMuE3dCiJ7Nt71EYnqAQ0Zuyrayl6dJrfEsXNBNWnwPSQqFTm6/4zWPQHeqXNVgaHdbLVX88Sc0u6xdqKnzQdJ+dxXIKvto9wiMz3ejurVmH5UqcYAlDCzvot7k50uqaY2yB4maeAfogwZhSdIfKgdInC/DC0/D7jooY5hukq8MNFltjSp7vv4d6w2a2Fd3d/UT3GUw/90dIWpRX1qvwY6u6ki+v5j6vtociJbw==
Received: from SJ0PR13CA0227.namprd13.prod.outlook.com (2603:10b6:a03:2c1::22)
 by MN2PR12MB4422.namprd12.prod.outlook.com (2603:10b6:208:265::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 17:55:20 +0000
Received: from SJ1PEPF00002313.namprd03.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::2e) by SJ0PR13CA0227.outlook.office365.com
 (2603:10b6:a03:2c1::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.2 via Frontend Transport; Wed,
 21 Jan 2026 17:55:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00002313.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 17:55:20 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 09:55:01 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 09:54:56 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <clg@redhat.com>, <alex@shazbot.org>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>,
 <kjaju@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v8 02/37] backends/iommufd: Introduce
 iommufd_backend_alloc_vdev
Date: Wed, 21 Jan 2026 17:52:07 +0000
Message-ID: <20260121175248.87649-3-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002313:EE_|MN2PR12MB4422:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cb66c1c-859f-48b9-474f-08de59163e3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|7416014|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LS/d6ZIO6DPRxgPaWXcvZTzvqskNDpvPnnqDlN1cqG5e/hOMJ4BSEtwgVjHK?=
 =?us-ascii?Q?B4wDjy2EoXAuEs9zOlNrpIOcqcH3ZRt5/wBOStNTUGM6SCkexQ60mCO/fP6B?=
 =?us-ascii?Q?4vp8N1Sy1zkvitV7ubJFqLmW9OUb9HfgAWRLpjmHkua3HK3UNeYNJwCKHozC?=
 =?us-ascii?Q?iBSAhKDAhIILZTfC6E7e8aQ2h9B2PcPKDuD8VFCTOmROC+2itWBa/E73De8G?=
 =?us-ascii?Q?q5eb8r/NEdl7ZLzv9dnJ3nLyeth9W0eWaM0eyK+sNCmU/ZdbYrkIZ51YQ2w7?=
 =?us-ascii?Q?IdgnqsunElH7DocuX/B24KJ5xvUPUUwZ6T2gLyUZb9JFiCiK5SbVEYKpfNsv?=
 =?us-ascii?Q?9safN9UwcT0wVos3y/Z8naQc8n9Z4xE/1kbA/XD/jdxPEdo5zTutWOkDTWHn?=
 =?us-ascii?Q?fux4eTebN6xFjMKeDpwUDo9NHMpm8GFAvhuOrmvRrLop/rN+W/5+WkDcwaSr?=
 =?us-ascii?Q?sreraPxrE58AsNoLHjCCzFuor6UB0Jc2eSSgcrCr+Me84Ekd54zIxC6+mfNW?=
 =?us-ascii?Q?RN4k/1UobbZNy76G85SR5ltHzCa+vBefd7bRiYUAnCv6mbEQVGrUTHZb0M1v?=
 =?us-ascii?Q?nd4PGTbl7/V167q0luJvobIbX50dFPIKpxAXkVTpFxY+8HoaY0yuKFtEDnnV?=
 =?us-ascii?Q?yzDYae7oqA3OsuvMLIBCsG/KPTl6fzrellzrVMWKlst26R3kC/Tw04dnFMgp?=
 =?us-ascii?Q?VnM+1i0nsja48NAoT3qeukwMuuiqYkXMAQq7deWn4fgAntF7Hu8CV750dBEI?=
 =?us-ascii?Q?5LtK2QWCdWGYR9307JSqUIZ7Oqm6URUwDCv/GyC6voRul6LMc3gIXRDQOqqp?=
 =?us-ascii?Q?SHrxbNAWmjc71/3Wf2PrWMJRz3AxHKy2BsXhACtmTO5sBdotJrLr55UQ1GMb?=
 =?us-ascii?Q?d1s5QJIMMv/NVS8//AY+IrnBAyQGBP4MZ1r/mH/FUdgwqp3QeTEEHW/EvVLY?=
 =?us-ascii?Q?MbdrkCMkXDmzLtuPegr3cq7BaH1eDmtZKwGHEBHBlrwJMG2uPPL20eiofyht?=
 =?us-ascii?Q?Pr8yliuViRO15fLNoAof8EfDbla9gHEJvhoQ7WL5JQQi8PxKmlPbT9JOywB1?=
 =?us-ascii?Q?hhxiNGo0Xys+GiYII4M807xpC1pqsCPZHAsg33ULq36l2aYTVGIOTX1liXyC?=
 =?us-ascii?Q?khPN0zcZzLEqsqfmQBCz0qoZtBnGvPyMbIyWTOM2JseCgIHob+GUNAbmCVtG?=
 =?us-ascii?Q?/fNZfBtqAxTilqnJ7+B5PYrwGOenuZGS2Z9LTFLxCQfZHtmm2p4sWeiXtgbe?=
 =?us-ascii?Q?XfLacoBYyx/fJZ5Ggt/IXT8rkpU0RkmBqhOWDyEZqYPsTnYmaPi9wx5LaIEB?=
 =?us-ascii?Q?Q8XNPOUr9/oFU/qaS/OfMMPIiZKlOqQuqvYFJvCCUr3o+PASojVQOdTW2Vs9?=
 =?us-ascii?Q?J56VWIAW9Nk6cxibzK4MI8+MpI1Ajp9svvT+CJoHGyOwVfXGAEcSjeZzHBIR?=
 =?us-ascii?Q?j6xg91V5NCZOB2ib3oz1LInxnFMt08A1RiAbxTersZHoIdxoCj+aIUmWWVo6?=
 =?us-ascii?Q?xVizhGl0jmWjh3w4aqf6gYaNRDWzGZsldZBHbaBezmUY24O/ywPJvRcXCnJS?=
 =?us-ascii?Q?8BnpqG8lDa5YrdBMWMrn00/faTcsN9qfLMb8jvVLnwt69ig47eDjWc7yuRoc?=
 =?us-ascii?Q?oWGIoxSh+xqQBP/GVWWX3MJlBnRMIDENPxBwsmvGjKzENXweUX48I92iGnX6?=
 =?us-ascii?Q?avUGNg=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 17:55:20.1134 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cb66c1c-859f-48b9-474f-08de59163e3d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002313.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4422
Received-SPF: permerror client-ip=2a01:111:f403:c107::9;
 envelope-from=skolothumtho@nvidia.com;
 helo=PH7PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.069,
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
Tested-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 backends/iommufd.c       | 27 +++++++++++++++++++++++++++
 backends/trace-events    |  1 +
 include/system/iommufd.h | 12 ++++++++++++
 3 files changed, 40 insertions(+)

diff --git a/backends/iommufd.c b/backends/iommufd.c
index c65dc41d71..e3a3c1480e 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -473,6 +473,33 @@ bool iommufd_backend_alloc_viommu(IOMMUFDBackend *be, uint32_t dev_id,
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
index 1ae94c4290..14a7ecf5aa 100644
--- a/backends/trace-events
+++ b/backends/trace-events
@@ -22,3 +22,4 @@ iommufd_backend_set_dirty(int iommufd, uint32_t hwpt_id, bool start, int ret) "
 iommufd_backend_get_dirty_bitmap(int iommufd, uint32_t hwpt_id, uint64_t iova, uint64_t size, uint64_t flags, uint64_t page_size, int ret) " iommufd=%d hwpt=%u iova=0x%"PRIx64" size=0x%"PRIx64" flags=0x%"PRIx64" page_size=0x%"PRIx64" (%d)"
 iommufd_backend_invalidate_cache(int iommufd, uint32_t id, uint32_t data_type, uint32_t entry_len, uint32_t entry_num, uint32_t done_num, uint64_t data_ptr, int ret) " iommufd=%d id=%u data_type=%u entry_len=%u entry_num=%u done_num=%u data_ptr=0x%"PRIx64" (%d)"
 iommufd_backend_alloc_viommu(int iommufd, uint32_t dev_id, uint32_t type, uint32_t hwpt_id, uint32_t viommu_id, int ret) " iommufd=%d type=%u dev_id=%u hwpt_id=%u viommu_id=%u (%d)"
+iommufd_backend_alloc_vdev(int iommufd, uint32_t dev_id, uint32_t viommu_id, uint64_t virt_id, uint32_t vdev_id, int ret) " iommufd=%d dev_id=%u viommu_id=%u virt_id=0x%"PRIx64" vdev_id=%u (%d)"
diff --git a/include/system/iommufd.h b/include/system/iommufd.h
index bc4acd1e8b..567dfb7b1d 100644
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


