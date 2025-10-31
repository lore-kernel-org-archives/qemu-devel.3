Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71C52CCF9F8
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 10:57:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEmmd-0006ou-SD; Fri, 31 Oct 2025 06:55:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vEmlx-0004dx-8Z; Fri, 31 Oct 2025 06:54:26 -0400
Received: from mail-westcentralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c112::5] helo=CY7PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vEmlt-000309-GY; Fri, 31 Oct 2025 06:54:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tyj40cu2LPcrNsktlzSYJ5z4Qdx57jBrv39LFpMEpkD8cKnLVSTuNFgQrEXTug3ijmpi3szEcnTWCL4v2PpK13nNPj+aO2pCwSU/HEP8nqxait9PXQu82rfL9SzvmOxWqPvl3Jq6uWuFYGEcVVbVWGan80SR85VG3TMR0zCak6Qk2zXShuQHwl+UNcNBaPBguiM9jN7YwUgrJGO3SY5nbLRggjQSfDniJIcaH1SA72qGqSL/wW0EIa3DZnuF4SsJ515D/MGPg8qFXjoxviIOPw0Xw+ruq7llYo83Ch14dKJS1zUJ5aB9/9nCcMeUYQcd8tnAsEd0qxh4jeHipQwZAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0UoTXKGRWRZ1acBaSwjtyZR0MJqqaY87u1SXDQ374/c=;
 b=KXEf5xXvrMas6QQy+4wNvQ6m941iORKFM7FwtxYirc3meSY233xakhv00Eq/LYbP3Em/XmGY6ukRGDzeELsDORrmgZ7SXHXf0YGBQowKHJPCz8nGrKPbB7RdsDpSGYUHOpN8KALrBnEY7Afofnou5CsDMX50UabmsFRB32NSKbLz+b7SPYtqgvoaSg0DTUrqjOCNdcToCC0+ah8MZc6xKW4p/HsU3tpHFQTdE7mpJmAtH49UB1I5TIuD5Cnqs65LZ7jn3OPSX/rxcWFupOjpMdiEOENFAsUX5h/z3fd/RiAhGmMZaIK0zfXDCijkYwVWnMalJIo5U+brfkPv865eVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0UoTXKGRWRZ1acBaSwjtyZR0MJqqaY87u1SXDQ374/c=;
 b=IXhLPb92C8w9lWx07Z6IDJelpmtCS5VGxvfRKrvM6QFyYP4OQbDvE7CzmKMUKpjqZOvs8W1w+lc1jtnF+IM8xspsNPWqJrS635xuIIq8bqvI0deYolY3VXjMiuVzP0FrGWCXm3ZSIX3uE2flzLNnROIqSqiFSLtCglW43ji5zvRNnlGGRvSIP5OlQ91Fu5Qs6LAYsH459wa2l6mwm3dhg61eJtFpt72dGe8Qx2WxeevHbXILAsQXahy+63DU6jOEAneMVzS3xvu3k233gSoAQAJFqPH5Di4oL0CKzdChOKGIpnULoybewJwlizEjQPPYZjJiKBbWF0m4821noFiY+w==
Received: from BL1PR13CA0109.namprd13.prod.outlook.com (2603:10b6:208:2b9::24)
 by IA4PR12MB9835.namprd12.prod.outlook.com (2603:10b6:208:54f::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Fri, 31 Oct
 2025 10:54:09 +0000
Received: from BL02EPF0001A104.namprd05.prod.outlook.com
 (2603:10b6:208:2b9:cafe::d6) by BL1PR13CA0109.outlook.office365.com
 (2603:10b6:208:2b9::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.6 via Frontend Transport; Fri,
 31 Oct 2025 10:54:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A104.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Fri, 31 Oct 2025 10:54:09 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 31 Oct
 2025 03:54:02 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 31 Oct
 2025 03:53:58 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <kjaju@nvidia.com>
Subject: [PATCH v5 19/32] hw/arm/smmuv3-accel: Get host SMMUv3 hw info and
 validate
Date: Fri, 31 Oct 2025 10:49:52 +0000
Message-ID: <20251031105005.24618-20-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A104:EE_|IA4PR12MB9835:EE_
X-MS-Office365-Filtering-Correlation-Id: c3e10b33-28cd-4031-73aa-08de186bd21f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yY3q9zdj/2qyeMtK1Yfoakt0scraZrUg3Nj8rFnfSjsmdQFUEbtRf7bcchyQ?=
 =?us-ascii?Q?mR7MfeDEII5yoWfbEkkTKpsTAIDtzqwraPVnvD4poD/TqEMhSIH1t3CIpJ03?=
 =?us-ascii?Q?qnefWHTbvqTr8wxHQkMIeD4q5aIa6Qfu05bMygWGX4GX3Y+ECnXUbGbrC6Ck?=
 =?us-ascii?Q?Ir5PY+ttJ5m+AqFQN7zUGo4etC28kk+lFZIQkGxgz0enD/Hw+/QguaiEwEvZ?=
 =?us-ascii?Q?2MwA4NwmpnvidHPVOACA8or0y6J9f2FLyERkl2FwYy2pnMBB6+wKB+t5luHz?=
 =?us-ascii?Q?PIkDQLZmprXg+5TBmIXr4lsI2MQmFr/PV3Lm6B4uhv7OqmoB3UhRtdaEZnZ9?=
 =?us-ascii?Q?SlONGNAniLutAprWm5oIf6Iv4jD5bifijpF+pWLUzkZB8+ZwgJmyOIvVuiYp?=
 =?us-ascii?Q?X258VquJGpxlSTzafvBf2GK4lNnc5kcnZoC80n0TFgQFTMdy/8Fw9pWAetmB?=
 =?us-ascii?Q?t4O+kE5u/K2b9YPEvBIKpq+dw5ZPu+kpkRvNadr3D93MfJUb+5EXWkYsmbdr?=
 =?us-ascii?Q?hs2yhQVeAukLeLSW2HVITmBfnD1lmACSe7FO0YdgDD9q125MWe2ogaaz9nph?=
 =?us-ascii?Q?0EAMBKFPchT1LilvfXHCcUGRvGMqKQ3DF1DE1z3lTJizOxReUPotYp5aARmE?=
 =?us-ascii?Q?s/1Ycr48sOw0+pwgxoX0mLQvrfocNcB+LwYULw7dO0LDz+4wCnte2LWIxEwh?=
 =?us-ascii?Q?AGaS5M/OdGGeO/PZuBKFdmoOyeY3Jy/A8Q0d/i6DFuHJaHMUPesuh+0son+v?=
 =?us-ascii?Q?rpRgyHJuXdEn041fPji/Bv/2Hs1x4lXgTUKr/t79MAdlHA6bTtejJjS9SCaY?=
 =?us-ascii?Q?mjaZPZ3fnO6B/dfFevh1YOqp66hfZbmI/g2houCVj4I9/bYzXzrw0zjch2fD?=
 =?us-ascii?Q?5TnZLW46ndA3cJxP3fpQj9sU0iYd1YDB7XGsEu2VTW6ITWMO0bsZGCYNExz1?=
 =?us-ascii?Q?TzPFpuC6vhTH4Zd1jrl3EXinHIdpMz95gvrw2wZuOn/wwD2DG+uJUUkHR3gR?=
 =?us-ascii?Q?hlwJjMGIgMYKV4ojM47i+OcNqs7XD6WRAJOFbOwA5MHLjU+4bRA7el+YIvLz?=
 =?us-ascii?Q?R3TuOpgD3xn8LjY8ejOkQcvAQJtmZSpKBIeD8IjuzYz/RRE/mz2yZrHwsXPt?=
 =?us-ascii?Q?QmX510ZPlYm6JI4HeCrhAplkRWRVUoUPVzbmpKPgeZ1rGWAxamDQZU64dLzF?=
 =?us-ascii?Q?CmwY+t8A//m/s27yoZNRxKLcR8OR2iY2kfi+qnjBNsbm12qEmHBnUdL4BtMp?=
 =?us-ascii?Q?sceoK6vTRSuCFyxs9cmKyrikBBbbgK8NULGjaQkppNkRfm53jJ8AxNJJD4tm?=
 =?us-ascii?Q?Qm1ce2EdzOKTxEFRaD/HjRyHzZQIv6j96aIBApPN9uKAanF/AUWWzQ3RwPMp?=
 =?us-ascii?Q?P68G7DlYdI4lw+XUsu8YT+qbwWjX3SHTSXZc6/qdaZW/4q3Y3z5uXUUx3esi?=
 =?us-ascii?Q?HadNZyZTFkMp8J46/AVwARAvws/FOZCCLdczJGiG5T+nLU3ETCPFa6mpyVNz?=
 =?us-ascii?Q?h3lDdiuuivZicyq26nLx+dILx9W3iEQAffrbP1O30w4GQ0g+t9ILxuI5Uxs+?=
 =?us-ascii?Q?QdiyZ6ua1QGqJGfANDE=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 10:54:09.7314 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3e10b33-28cd-4031-73aa-08de186bd21f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A104.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9835
Received-SPF: permerror client-ip=2a01:111:f403:c112::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=CY7PR03CU001.outbound.protection.outlook.com
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

Just before the device gets attached to the SMMUv3, make sure QEMU SMMUv3
features are compatible with the host SMMUv3.

Not all fields in the host SMMUv3 IDR registers are meaningful for userspace.
Only the following fields can be used:

  - IDR0: ST_LEVEL, TERM_MODEL, STALL_MODEL, TTENDIAN, CD2L, ASID16, TTF
  - IDR1: SIDSIZE, SSIDSIZE
  - IDR3: BBML, RIL
  - IDR5: VAX, GRAN64K, GRAN16K, GRAN4K

For now, the check is to make sure the features are in sync to enable
basic accelerated SMMUv3 support.

Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3-accel.c | 100 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 100 insertions(+)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index a2deda3c32..8b9f88dd8e 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -28,6 +28,98 @@ MemoryRegion root;
 MemoryRegion sysmem;
 static AddressSpace *shared_as_sysmem;
 
+static bool
+smmuv3_accel_check_hw_compatible(SMMUv3State *s,
+                                 struct iommu_hw_info_arm_smmuv3 *info,
+                                 Error **errp)
+{
+    /* QEMU SMMUv3 supports both linear and 2-level stream tables */
+    if (FIELD_EX32(info->idr[0], IDR0, STLEVEL) !=
+                FIELD_EX32(s->idr[0], IDR0, STLEVEL)) {
+        error_setg(errp, "Host SMMUv3 differs in Stream Table format");
+        return false;
+    }
+
+    /* QEMU SMMUv3 supports only little-endian translation table walks */
+    if (FIELD_EX32(info->idr[0], IDR0, TTENDIAN) >
+                FIELD_EX32(s->idr[0], IDR0, TTENDIAN)) {
+        error_setg(errp, "Host SMMUv3 doesn't support Little-endian "
+                   "translation table");
+        return false;
+    }
+
+    /* QEMU SMMUv3 supports only AArch64 translation table format */
+    if (FIELD_EX32(info->idr[0], IDR0, TTF) <
+                FIELD_EX32(s->idr[0], IDR0, TTF)) {
+        error_setg(errp, "Host SMMUv3 doesn't support AArch64 translation "
+                   "table format");
+        return false;
+    }
+
+    /* QEMU SMMUv3 supports SIDSIZE 16 */
+    if (FIELD_EX32(info->idr[1], IDR1, SIDSIZE) <
+                FIELD_EX32(s->idr[1], IDR1, SIDSIZE)) {
+        error_setg(errp, "Host SMMUv3 SIDSIZE not compatible");
+        return false;
+    }
+
+    /* QEMU SMMUv3 supports Range Invalidation by default */
+    if (FIELD_EX32(info->idr[3], IDR3, RIL) !=
+                FIELD_EX32(s->idr[3], IDR3, RIL)) {
+        error_setg(errp, "Host SMMUv3 doesn't support Range Invalidation");
+        return false;
+    }
+
+    /* QEMU SMMUv3 supports GRAN4K/GRAN16K/GRAN64K translation granules */
+    if (FIELD_EX32(info->idr[5], IDR5, GRAN4K) !=
+                FIELD_EX32(s->idr[5], IDR5, GRAN4K)) {
+        error_setg(errp, "Host SMMUv3 doesn't support 4K translation granule");
+        return false;
+    }
+    if (FIELD_EX32(info->idr[5], IDR5, GRAN16K) !=
+                FIELD_EX32(s->idr[5], IDR5, GRAN16K)) {
+        error_setg(errp, "Host SMMUv3 doesn't support 16K translation granule");
+        return false;
+    }
+    if (FIELD_EX32(info->idr[5], IDR5, GRAN64K) !=
+                FIELD_EX32(s->idr[5], IDR5, GRAN64K)) {
+        error_setg(errp, "Host SMMUv3 doesn't support 64K translation granule");
+        return false;
+    }
+
+    /* QEMU SMMUv3 supports architecture version 3.1 */
+    if (info->aidr < s->aidr) {
+        error_setg(errp, "Host SMMUv3 architecture version not compatible");
+        return false;
+    }
+    return true;
+}
+
+static bool
+smmuv3_accel_hw_compatible(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
+                           Error **errp)
+{
+    struct iommu_hw_info_arm_smmuv3 info;
+    uint32_t data_type;
+    uint64_t caps;
+
+    if (!iommufd_backend_get_device_info(idev->iommufd, idev->devid, &data_type,
+                                         &info, sizeof(info), &caps, errp)) {
+        return false;
+    }
+
+    if (data_type != IOMMU_HW_INFO_TYPE_ARM_SMMUV3) {
+        error_setg(errp, "Wrong data type (%d) for Host SMMUv3 device info",
+                     data_type);
+        return false;
+    }
+
+    if (!smmuv3_accel_check_hw_compatible(s, &info, errp)) {
+        return false;
+    }
+    return true;
+}
+
 static bool
 smmuv3_accel_alloc_vdev(SMMUv3AccelDevice *accel_dev, int sid, Error **errp)
 {
@@ -356,6 +448,14 @@ static bool smmuv3_accel_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
         return true;
     }
 
+    /*
+     * Check the host SMMUv3 associated with the dev is compatible with the
+     * QEMU SMMUv3 accel.
+     */
+    if (!smmuv3_accel_hw_compatible(s, idev, errp)) {
+        return false;
+    }
+
     if (!smmuv3_accel_dev_alloc_viommu(accel_dev, idev, errp)) {
         error_append_hint(errp, "Device 0x%x: Unable to alloc viommu", sid);
         return false;
-- 
2.43.0


