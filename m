Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 007F8D2502E
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Jan 2026 20:08:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vf1Yh-0007jn-Qd; Sun, 11 Jan 2026 14:57:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vf1YM-0006tm-Vg; Sun, 11 Jan 2026 14:56:48 -0500
Received: from mail-southcentralusazlp170130001.outbound.protection.outlook.com
 ([2a01:111:f403:c10c::1] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vf1YJ-0003t9-SO; Sun, 11 Jan 2026 14:56:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JaaYdR5fW5TeNwF15wehOracih/p/6yZWbmP7kJpad8Fjcx9YLWXXBqccvvQ2ZjZRjpLRw23a9z/u68fX2JVHePzu4Syxordks1sVcMlvO6yJ6uM8GU6U5ZhNd2cuXxr6fd0zIMAWeV5vr6eLRfz+8hw+8zySu++kPf+5FGXucGDAQIm2xpb48A/b36v3azP/LtbkT//ebxqa8H/v3D2/pVIkDbmPySr7sXYk2VeTpSVmWdIQCxFJ6FF/88MA+PhWYxy7etCBSGGHn3WXhId5Mh7II0F1dMBRrrm3/PKXmn7PruBcMbIxYzLZ4pyLldHdqKDXUYyWZGiCBhsD1p3Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CgWDqzAjcAT2MQSCn1+aWaHlAigvooUNSv+S3EHnCEI=;
 b=s5uerYnrMQYhwdAcPddedeDRPIgo25qBJklA9MRPL1ECqHxEVxPppqhsWhCV9CFBx/wf/hVhEylAov+z8WbmoPoIH7IJ27IhM2v0WG3+8155wJ/tmei6S8U53wi9/Qq8u8O7lryJD4RLGPfifUPn0k8Ecsb8dK6sFQ5dSVKeJqtNrB9PVRzbc9GMZoMiZ7/luj9kzIavJ8hGSzagYAlk4cSr9tdCI903MHcIC1Xyc+QFux9zQRLT3tzJnYdbzi9hzj8xQvDX61YcSpp6RTlR2eF8cckMSahfvud4mmyZD8wzWB7InSmex4JqRymWOvDO3KlBRKefKaw1y9kusbEqCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CgWDqzAjcAT2MQSCn1+aWaHlAigvooUNSv+S3EHnCEI=;
 b=qtqU+LOPTOQc/4H4eM4gCKtqCOsin+rhUQ1r45uCOOfYMsEvfKJDvjud7Ujbxu+mqcEesXko62v8A7ZQZYQhAD8VdebCI+9WJOJB382mHoiFKEaOFlRU9+3wk2HtfL5QuH/gMyZbET3v7fTh8v2NXzOI1q8DfYzQvxbyMmv7WDcz2UK+zr5F8Yblw7FbhWAtPEEdgHta/M3iVfucFTju6Xc37pLEm7ltGw7+lblU2CwNsy2DzAoixkxqwdrYwLTqv0YCRoCF0T+QMm1Gz24Xo/P1gzvIWuNGmhB5C1+wiHOURM1bC0pymXuTaJhXtGXOqN5J4Pe/vb0v293aJGvZUg==
Received: from SA1PR03CA0015.namprd03.prod.outlook.com (2603:10b6:806:2d3::22)
 by CH3PR12MB9429.namprd12.prod.outlook.com (2603:10b6:610:1c9::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Sun, 11 Jan
 2026 19:56:37 +0000
Received: from SN1PEPF0002BA4F.namprd03.prod.outlook.com
 (2603:10b6:806:2d3:cafe::dc) by SA1PR03CA0015.outlook.office365.com
 (2603:10b6:806:2d3::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Sun,
 11 Jan 2026 19:56:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002BA4F.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Sun, 11 Jan 2026 19:56:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 11 Jan
 2026 11:56:31 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 11 Jan
 2026 11:56:26 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <clg@redhat.com>, <alex@shazbot.org>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>,
 <kjaju@nvidia.com>
Subject: [PATCH v7 09/36] hw/arm/smmuv3-accel: Restrict accelerated SMMUv3 to
 vfio-pci endpoints with iommufd
Date: Sun, 11 Jan 2026 19:52:55 +0000
Message-ID: <20260111195508.106943-10-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260111195508.106943-1-skolothumtho@nvidia.com>
References: <20260111195508.106943-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4F:EE_|CH3PR12MB9429:EE_
X-MS-Office365-Filtering-Correlation-Id: e1839cb7-ef2b-4e41-a0b5-08de514b8776
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024|7416014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y2dzYmpFYVNzaUpkSlMvS09YUjdqaGVsanlpNzAxb0lrQnRnLzFmeDJET1hq?=
 =?utf-8?B?amd0dWRLQkhvNjIxckdDbUdHWjJ4dEdYNThqcXloeW1IT3JWNXE5K3NORDZK?=
 =?utf-8?B?ZC90d1FLUlY1dHVnTnA0anhhUGREV0VKajJqOVNHNU94Q1ZrY3BPT2tpN0t1?=
 =?utf-8?B?b294TVJxY2REUStNOEFMNUdGRDV0aENuemFyVndDWVk3RklYM3VjcXFBUkNI?=
 =?utf-8?B?c3ZBWVp2cDFrWkYvaW1qQUlrS29Zb2N2S2VmcTZoWHZ0MFFOUU4xT0hxUmNJ?=
 =?utf-8?B?a0oxVDE1ZXMvYXZVZzRObkdMYW14aTNyMjhDQ1pSV3diZDgySWltOSszOGFJ?=
 =?utf-8?B?OE1PVjFCNVNzRkl4Q1ZZSUE3Z2VEeVRiOXZjd2RodlB6Mkp0eXVmU1F3aEpW?=
 =?utf-8?B?VTlxS3hFcU9qVWUwYnFBRllPaTZtUDZVZ29sY2tSdzBGMWIvOEVNaUJYWDVw?=
 =?utf-8?B?YkF5MkY0dTVJclphY2tvSHg5alkrdWI4NmJTYmh5enNkZ2JWejRJeTlzOUFO?=
 =?utf-8?B?WWNvUE9xdGwwc2JoTERRQllYWFhKQzF2bWVJSXhlZnFlN0EwUEhZVmUxMWdY?=
 =?utf-8?B?M0hvcnhha3FXU29xNzRFUEhJaW9RTmQwcmhnYlJBVVRIcitJOW1YRGpMWTBM?=
 =?utf-8?B?bWlWQUlWKzE3dlpaTk5OQSs0YzVEbFVyWTF4NklCaG91RG8vMnRGMVJJSjYv?=
 =?utf-8?B?anVHTVg0MVZQKzJqS09GRXZmSWxsdzNnRzY4WUZhQVFnaGUxSTFYUEUweTRp?=
 =?utf-8?B?ZjdhUWlBNHBJVVk1aGY0d2JCcmdtZ1gyRzhWRlBveVRzaVJjTjViQ0pQaURy?=
 =?utf-8?B?QnVsNzF4VkVBZEV1VFRZUGU5bGdGUVkzSDEvd1FWbFhCMHJKazhuUElnakRz?=
 =?utf-8?B?bGs5YXczeGZKU1d4WE5FTkF5Y0RvNERyY3RDWG80YzNyWjhoZ2I4aWk1NHVC?=
 =?utf-8?B?cmZRVlR6K2FpWVdmcFN0NVpaeGpNNWovWUdnK0ZYK1lEZTA1RTZqSjk3M2Nr?=
 =?utf-8?B?dExSZ0ZKdFNQZm9qOENJN2tVdDdSQnhuR3V1cm5PZDY2U3pmWFJwVW1Jak1H?=
 =?utf-8?B?cFMwSm5YQkdpRnQ0ZVNjdEZJcE5aN3BsK3lHcnVjdWpkalJqMHdCU2EwSkhz?=
 =?utf-8?B?Vm9wTGdRNlRUUWYxUTM4QkVDNG52Nm1DcXNUd2xNbzltR0pTZTVYN2FtUnoy?=
 =?utf-8?B?enRiZ2dSdFZ0a2VkSWRsZGxseE01eVM4cktEaXZWSXp1YzBmVTIyQW5pL0p2?=
 =?utf-8?B?Y29LbmtiSU5TeFhtaGVpdjdCaUZONnM4RUw4amNzUXhBWVd0N2YzbWp2am5a?=
 =?utf-8?B?TjZFaUphU3ZzVUpTV2ZOYUZOeloyQ2N4V3FRd3NpWmdCTGMrWkhDWWloZnlQ?=
 =?utf-8?B?S0JRQURqeStabDBacTR0anh3MmJ0TGFnbHBrUDVKdTNNdVNpUkJxdEJMNUZS?=
 =?utf-8?B?WFhJamlkYjdITHZGQXdSWWZCRm9WaW1kY3dWNWRuVmZtbVNVaDVpaVNMN3M4?=
 =?utf-8?B?a1ZvcVZhNFJad0lqZVUzQUR2MnVtbU9ORmVCanY1bVd0NjB4aWdSY1RDT2Nq?=
 =?utf-8?B?bVhZWEdCeU03UHQ2R2dNdG8wbE9JRENUbHJKYnVaZ2lJOU5uYzdKcHNDMytK?=
 =?utf-8?B?cEV5NWN5Z2d5eHNWWmZjUk5KYlI5T3pYei9EZHA4R1JqVzc3WlRuRFIrWFNC?=
 =?utf-8?B?Zy9wN1o0NExrK3RTaWEvSnBBdzFpd1h4QlhZTGZocloxMDNRbE8zOFoyUzJr?=
 =?utf-8?B?NStuSWN2YUJkWXhDYWRTRENxNE13elg2Z0Y2N0taa2dWVENjcUhBTTVqMC9i?=
 =?utf-8?B?UENuVmR2akZPK21oNnZMNHdZYncrR2dSb3cycWE5YkEvRzdPbzArd2NpeXBT?=
 =?utf-8?B?THdpVTNDdmlqM0RGZkd5T3V2eGI5ZU8zL2N6c0p3ZUpxQ29vRnY0VU83djBt?=
 =?utf-8?B?YkQwVFFnRWVWd0ppbmtkTHo1TGI5Zituc25UTnhQYjhaY2hoSG91T1M4OEVY?=
 =?utf-8?B?Tzh1WHd5SEZLN0gyaWxHNWVzeUpUTW0xSUdEZFRMb2JRVlRyR1RIMkpJZXdO?=
 =?utf-8?B?cjBqR2d6T0NpaG1yeEdiRzYyWW1OSG45QW5yTE1Jb1FlclpPS3VYUDhodXNH?=
 =?utf-8?Q?f57w=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024)(7416014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2026 19:56:36.8710 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1839cb7-ef2b-4e41-a0b5-08de514b8776
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9429
Received-SPF: permerror client-ip=2a01:111:f403:c10c::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=SA9PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=0.001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Accelerated SMMUv3 is only meaningful when a device can leverage the host
SMMUv3 in nested mode (S1+S2 translation). To keep the model consistent
and correct, this mode is restricted to vfio-pci endpoint devices using
the iommufd backend.

Non-endpoint emulated devices such as PCIe root ports and bridges are also
permitted so that vfio-pci devices can be attached downstream. All other
device types are unsupported in accelerated mode.

Implement supports_address_space() callback to reject all such unsupported
devices.

This restriction also avoids complications with IOTLB invalidations. Some
TLBI commands (e.g. CMD_TLBI_NH_ASID) lack an associated SID, making it
difficult to trace the originating device. Allowing emulated endpoints
would require invalidating both QEMU’s software IOTLB and the host’s
hardware IOTLB, which can significantly degrade performance.

A key design choice is the address space returned for accelerated vfio-pci
endpoints. VFIO core has a container that manages an HWPT. By default, it
allocates a stage-1 normal HWPT, unless vIOMMU requests for a nesting
parent HWPT for accelerated cases.

VFIO core adds a listener for that HWPT and sets up a handler
vfio_container_region_add() where it checks the memory region.

 -If the region is a non-IOMMU translated one (system address space), VFIO
  treats it as RAM and handles all stage-2 mappings for the core allocated
  nesting parent HWPT.

 -If the region is an IOMMU address space, VFIO instead enables IOTLB
  notifier handling and translation replay, skipping the RAM listener and
  therefore not installing stage-2 mappings.

For accelerated SMMUv3, correct operation requires the S1+S2 nesting
model, and therefore VFIO must take the "system address space" path so
that stage-2 mappings are properly built. Returning an alias of the
system address space ensures this happens. Returning the IOMMU address
space would omit stage-2 mapping and break nested translation.

Another option considered was forcing a pre-registration path using
vfio_prereg_listener() to set up stage-2 mappings, but this requires
changes in VFIO core and was not adopted. Returning an alias of the
system address space keeps the design aligned with existing VFIO/iommufd
nesting flows and avoids the need for cross-subsystem changes.

In summary:
 - vfio-pci devices(with iommufd as backend) return an address space
   aliased to system address space.
 - bridges and root ports return the IOMMU address space.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3-accel.c | 77 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 76 insertions(+), 1 deletion(-)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index b2eded743e..2fcd301322 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -7,8 +7,13 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 
 #include "hw/arm/smmuv3.h"
+#include "hw/pci/pci_bridge.h"
+#include "hw/pci-host/gpex.h"
+#include "hw/vfio/pci.h"
+
 #include "smmuv3-accel.h"
 
 /*
@@ -37,6 +42,48 @@ static SMMUv3AccelDevice *smmuv3_accel_get_dev(SMMUState *bs, SMMUPciBus *sbus,
     return accel_dev;
 }
 
+/*
+ * Only allow PCIe bridges, pxb-pcie roots, and GPEX roots so vfio-pci
+ * endpoints can sit downstream. Accelerated SMMUv3 requires a vfio-pci
+ * endpoint using the iommufd backend; all other device types are rejected.
+ * This avoids supporting emulated endpoints, which would complicate IOTLB
+ * invalidation and hurt performance.
+ */
+static bool smmuv3_accel_pdev_allowed(PCIDevice *pdev, bool *vfio_pci)
+{
+
+    if (object_dynamic_cast(OBJECT(pdev), TYPE_PCI_BRIDGE) ||
+        object_dynamic_cast(OBJECT(pdev), TYPE_PXB_PCIE_DEV) ||
+        object_dynamic_cast(OBJECT(pdev), TYPE_GPEX_ROOT_DEVICE)) {
+        return true;
+    } else if ((object_dynamic_cast(OBJECT(pdev), TYPE_VFIO_PCI))) {
+        *vfio_pci = true;
+        if (object_property_get_link(OBJECT(pdev), "iommufd", NULL)) {
+            return true;
+        }
+    }
+    return false;
+}
+
+static bool smmuv3_accel_supports_as(PCIBus *bus, void *opaque, int devfn,
+                                     Error **errp)
+{
+    PCIDevice *pdev = pci_find_device(bus, pci_bus_num(bus), devfn);
+    bool vfio_pci = false;
+
+    if (pdev && !smmuv3_accel_pdev_allowed(pdev, &vfio_pci)) {
+        if (vfio_pci) {
+            error_setg(errp, "vfio-pci endpoint devices without an iommufd "
+                       "backend not allowed when using arm-smmuv3,accel=on");
+
+        } else {
+            error_setg(errp, "Emulated endpoint devices are not allowed when "
+                       "using arm-smmuv3,accel=on");
+        }
+        return false;
+    }
+    return true;
+}
 /*
  * Find or add an address space for the given PCI device.
  *
@@ -47,15 +94,43 @@ static SMMUv3AccelDevice *smmuv3_accel_get_dev(SMMUState *bs, SMMUPciBus *sbus,
 static AddressSpace *smmuv3_accel_find_add_as(PCIBus *bus, void *opaque,
                                               int devfn)
 {
+    PCIDevice *pdev = pci_find_device(bus, pci_bus_num(bus), devfn);
     SMMUState *bs = opaque;
     SMMUPciBus *sbus = smmu_get_sbus(bs, bus);
     SMMUv3AccelDevice *accel_dev = smmuv3_accel_get_dev(bs, sbus, bus, devfn);
     SMMUDevice *sdev = &accel_dev->sdev;
+    bool vfio_pci = false;
 
-    return &sdev->as;
+    if (pdev && !smmuv3_accel_pdev_allowed(pdev, &vfio_pci)) {
+        /* Should never be here: supports_address_space() filters these out */
+        g_assert_not_reached();
+    }
+
+    /*
+     * In the accelerated mode, a vfio-pci device attached via the iommufd
+     * backend must remain in the system address space. Such a device is
+     * always translated by its physical SMMU (using either a stage-2-only
+     * STE or a nested STE), where the parent stage-2 page table is allocated
+     * by the VFIO core to back the system address space.
+     *
+     * Return the shared_as_sysmem aliased to the global system memory in this
+     * case. Sharing address_space_memory also allows devices under different
+     * vSMMU instances in the same VM to reuse a single nesting parent HWPT in
+     * the VFIO core.
+     *
+     * For non-endpoint emulated devices such as PCIe root ports and bridges,
+     * which may use the normal emulated translation path and software IOTLBs,
+     * return the SMMU's IOMMU address space.
+     */
+    if (vfio_pci) {
+        return shared_as_sysmem;
+    } else {
+        return &sdev->as;
+    }
 }
 
 static const PCIIOMMUOps smmuv3_accel_ops = {
+    .supports_address_space = smmuv3_accel_supports_as,
     .get_address_space = smmuv3_accel_find_add_as,
 };
 
-- 
2.43.0


