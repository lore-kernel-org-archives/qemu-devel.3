Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6106ACF8859
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 13:26:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vM4eq-0007cJ-Lx; Thu, 20 Nov 2025 08:25:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vM4en-0007Tp-Im; Thu, 20 Nov 2025 08:25:05 -0500
Received: from mail-westusazlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c001::2] helo=SJ2PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vM4el-0002Nz-TI; Thu, 20 Nov 2025 08:25:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GZ94zNpQjASzs4fp9KWrIEcaxJq+uNIgnMyO+qCmnJA+BtzutX+tfeOJ7j+b4/KM2KUXaE7tjZuIAl+ETSK2eBs6pPSbX4mXD7KuMTRzuWrdn3FZ5P9CTuBT0LUrOY61zOtqhnwt/FPip7dS0yasDBWnOcVu5+8RHFg1Cedhr83ZzlETRPVbynL+mls4R9ohuXJ5tVIifmHgq3Y8NzR0ATjHxp0DOhFhigTBHfhYRmTwrnsa4+moCbEenNmTwLd2RcVHulPS+Sh6Jt1vKAj3tyZjCv4+14kC7W3mDWP/oG5JRsQ+tqGp/mnlsFdgBBXDxByCprRT2YHuoz7XcIsmLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XFFNlOwVnf/7KrJ9Ii4BmOqoUXOVLHXeHQ3u9BxtzUQ=;
 b=RpnMp5LGHoOvb+3Noa7kRxgwdHUzd5XL6Bt4hJOGw0+u9EsuLYPLbXx0iw1vLM1bZqbzHu9EmliAPogdA5DOVfmhFyC59MH5hO8sy4sL8ERATNsGg9Bs0fOXGELWvUJhlSxu2tOSUTPNIiQ97SXdNWW2YwGCBVR0UBtRh0mzPboJBKmG1VloXtd5osL8m2MoVj+NRkMMwVVv8Mm+HoalJh0GFdh4TVMJa0VcxOXRFoi5A69blTl552OeC00ioWz5vRznbyUbXq9CjCrA9Ph2OaBGgXO/iTUrLuBFzPmRWcF7ua3dcBBtOmYWUsD+UwiBbClh8h/KcYz3g1EB9GZW+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XFFNlOwVnf/7KrJ9Ii4BmOqoUXOVLHXeHQ3u9BxtzUQ=;
 b=kZ+pMlM7LiwTeXpReykm5kV6Xyuw9ywmBEfmBwVdO4AOSrm03pj4N6b/+LpD9vXxtLAGtJcl4XeY4xlJG4ttWJ0bPeEOJprCc67iQpKeziHJHNtvmJhnE+rVZRUfpPNC1OyK+vyPII9tOp7o1WVvgrh7+7O8qXeZonLqfPJMJIUeNNBIkHST1waGJ9pZ0uZKEkCg50WnJ+G1D/E6AGzXrXYS3xzehoOhZku9W1E1XyDzepxHxl/mPcLuLmeRzbm5ca6pqoDPJ6Uzz0+EQkgHQyQFj4Blz17xmg7NzL8n4yqMwSec8mAnvpgVjQpaK+j+FhbaJtqBgoN0Qyp/254Skw==
Received: from CH0PR03CA0306.namprd03.prod.outlook.com (2603:10b6:610:118::35)
 by IA1PR12MB6434.namprd12.prod.outlook.com (2603:10b6:208:3ae::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 13:24:57 +0000
Received: from CH1PEPF0000A34A.namprd04.prod.outlook.com
 (2603:10b6:610:118:cafe::11) by CH0PR03CA0306.outlook.office365.com
 (2603:10b6:610:118::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.11 via Frontend Transport; Thu,
 20 Nov 2025 13:24:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000A34A.mail.protection.outlook.com (10.167.244.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 13:24:57 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 05:24:44 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 05:24:41 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <kjaju@nvidia.com>
Subject: [PATCH v6 20/33] hw/arm/smmuv3-accel: Get host SMMUv3 hw info and
 validate
Date: Thu, 20 Nov 2025 13:22:00 +0000
Message-ID: <20251120132213.56581-21-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251120132213.56581-1-skolothumtho@nvidia.com>
References: <20251120132213.56581-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34A:EE_|IA1PR12MB6434:EE_
X-MS-Office365-Filtering-Correlation-Id: eeb0cf72-c74b-405e-a0a1-08de28383364
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6Le3UXUzlCc5JPPvjNVmE1s4DwCJsA81NpT90xWaiyyaC2UtLPjaepsU+Pl1?=
 =?us-ascii?Q?Gi/yHMHw8cfUnsn6aAsWatBdkUX3mLqGYqX8WDmu3PzIqR3S6HPs2clIgeSz?=
 =?us-ascii?Q?KWkB7/Dg/0YETEuAPotp/tFneA4SH0WjjmGCmmV1FZTUgY9+8e5DNeG+v3RJ?=
 =?us-ascii?Q?kQhV4kj6D4FysTo33KJ/t/Vc8eYsQdDyUAYHncSuNb2nY0bEssiBlD+50ow8?=
 =?us-ascii?Q?0D/I59AArmzJWQz78WpitFxJwJVtRl05huo+ooxLgzxT5/AINO38ql0V6Isj?=
 =?us-ascii?Q?FdCL/Ufvcs0nVPjNkPqUGPWGNkfBg1YV3cEKatjy4OAEeTAchs9e+UWLBLQu?=
 =?us-ascii?Q?qj6iJ0zjhnl3QYvBlTjMS+q+An4Arf9Vvi4liOR8C0wFdZY96IgEeak6HWb1?=
 =?us-ascii?Q?Gy9Bj94Pugdn9beAWd1H8DWQbLcTADKAFXtyA1vGdJlirMOWuTOmFjpPeW3B?=
 =?us-ascii?Q?Wm6d89vUspT/nogCGCpr8AGo9Rt7f30fXjUCThj93sSedj+tigAavFDx0ou5?=
 =?us-ascii?Q?dEc640t0P2e/gyB2Wbx02DLY8ORYyycteGUnltK77YWfQXVCSFDfoKERCdqK?=
 =?us-ascii?Q?6iCobZX3jDjEtbg/pLVudUL76vGeXV/JOOxwHLXlETdfKrq5wIifpA3fTZtp?=
 =?us-ascii?Q?vXMRI6FVWXoPIL3UsgITdDkCEXOhuTS4iw3wEnZGa7uS7jUZKzskmVj3juqX?=
 =?us-ascii?Q?C8Fd1EL5p3olKi7TIQWnpgg9mT/l5uXO9UHXB4rsZPRmiHc69IWTcfMeAIKK?=
 =?us-ascii?Q?v/qY9XLxC9VBrousjJTl+eFIyV2/k8yIamATFynn44mnlIbZPchCbUxshPhT?=
 =?us-ascii?Q?ypichDDg0uJPRpXlUaWVs255smnsy6yVXCHYzei9RuzmDZSRn1ieWe6Lwlya?=
 =?us-ascii?Q?1/bZlzc9HE5MO9q7OlCg3wHcnUQ0raAPFH71z/pE0FKt3VOnX6BmoeK+/hq4?=
 =?us-ascii?Q?mEGdHR6dRbzrua9+v7AiBqc56NRodfrlZ3YLnG6TaheQOtCosa8cgoTtc6Ww?=
 =?us-ascii?Q?i44mExzeMGysVNhmSEGiCkeh2l/fXcA388EqEwvGFlek2Mg70dQtL6mZ6r0m?=
 =?us-ascii?Q?efiUhjyvVDz3J/QhNRvlgy8wWTOWTCbbURb7d+ahux1T1ON361ePs/W6fb7H?=
 =?us-ascii?Q?9GmKGjq4ort5qBPsHeCg3G0kRD/9IDi18u18YE2RIT7tasAY++Gj+ctLLjkp?=
 =?us-ascii?Q?gFjJCOI5ugoACDmrpT2hnV3RLsjHry5rzPc2lxebnFlxmGMFIMrMGkjVoTCb?=
 =?us-ascii?Q?x8fuK9Cw35mIqgJe1cwK7xPkucO8UL23vzcFqJVGtwi7uB6TzoVMrzYJzSkG?=
 =?us-ascii?Q?ktYUJt8pmsreJUElRTtYOHbK3gk+CPtsXfku7DW7TqQWEIJw885eegnGbZam?=
 =?us-ascii?Q?Y8tXsaaNHPd6AqcGIFNvoIw03zrjLUEwbYOTLvtlNXNQZv8AYLEfpCEdxQyR?=
 =?us-ascii?Q?TFN6J7/0TzcXlSnh3UN4tGmyNoSdiG9+9+9/zszGcBI8/uoZLfqPr0/U79RJ?=
 =?us-ascii?Q?smdbfueoVTy36Cdq5TCBHtYdSsfbncgGAa/edzYQZjo2ON8RTj3aVMf+eMhu?=
 =?us-ascii?Q?wo/p5vN59AIIV8LLlOc=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 13:24:57.7158 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eeb0cf72-c74b-405e-a0a1-08de28383364
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A34A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6434
Received-SPF: permerror client-ip=2a01:111:f403:c001::2;
 envelope-from=skolothumtho@nvidia.com;
 helo=SJ2PR03CU001.outbound.protection.outlook.com
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
basic accelerated SMMUv3 support. AIDR is not checked, as hardware
implementations often provide a mix of architecture features regardless
of the revision reported in AIDR.

Note that SSIDSIZE check will be added later when support for PASID is
introduced.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3-accel.c | 95 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index a7291e75f1..aae7840c40 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -27,6 +27,93 @@
 static MemoryRegion root, sysmem;
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
 static SMMUv3AccelDevice *smmuv3_accel_get_dev(SMMUState *bs, SMMUPciBus *sbus,
                                                PCIBus *bus, int devfn)
 {
@@ -352,6 +439,14 @@ static bool smmuv3_accel_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
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
     if (s->s_accel) {
         goto done;
     }
-- 
2.43.0


