Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45900CF65D5
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 10:51:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkKBK-0003av-8i; Mon, 26 Jan 2026 05:50:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vkKBF-00034D-Qf; Mon, 26 Jan 2026 05:50:49 -0500
Received: from mail-westusazlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c001::2] helo=SJ2PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vkKBD-0006CY-Jl; Mon, 26 Jan 2026 05:50:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PO+BcmIiq4PQ4KDbOvmQt5X9UrsSWujSO1AmPxGVMXLneHnuuUz2cTC+grGCrTqPE8gw1GrUDTAAKmQb561lZ5YLkQE/KYmTes8CljPGPwB/y61FqwdNBBgbVRrjnHWrfsFp8eycPxXeIydymWsr/30Hev3sShzZc3TgbxzEY9IRLgzbGWhl80wA7QMVKivp0Mt+r6RLfzz4t27mzrTKuayPXTyA/KGVvRfBgqkgwJVHifjyMavEWc8DFE8iJZvrhEDIlbD5J+WdXEAKm+kWdVLQcxsmwKR0+Xa5sHIFjr4RIJVVDb3yv/9ImK89I1/OK2y/vqxTZnwf2kd/hMErTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DwWgCfTF0zXec4V3TH3IuZo8wthPdmcpjsMZjo1Rl2M=;
 b=O4KLU0iJu4dcyHf/G7DrfL+noWug9fIJ5qq4nA+yVMKzDHE4ddg4By6BcjPVYa4tAGutDLpfZTIgdRqYxuiUEakda9JZJlNqAnk+DQfZ/LJ6GNihcv5ZyCFIvQtsFkkty4t9CGWqZY2POGSCcJdRIoOwnP686Qb0zYQD8/ib+23s/TzWP6v8ufeB6TgGT6PVqT79/SiX3jYnUqyxdgMLb7TO9vohQ/pf0VKViypUgdCYDGuwdAEN4Tq1ptOf0TKiBOih2Q0nL1/gGQ4K3RInlTCzUMuRHJ7Ffdz3WjbNlBmRn0w057vSueiQies/Kix+QBB4rNXrKj5a+mR/3AEW5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DwWgCfTF0zXec4V3TH3IuZo8wthPdmcpjsMZjo1Rl2M=;
 b=OyB+mV3d+6aPpnmcdxtLNNo7Pasr7/QJhjYGSLCprzkvf7x1yjTBLcKybfYkLmYJbyPY4/fqORK6nNlgHGWLU+y6FMYh2Yd5GZmxl7LxMwnf4poaQtFhrRJTZnJUsPD0t8oVjRtdbPmfOibiSq6Ye0/WxY/VvWagcWGUwJ0llFqDoW07GamV8g0wq8A+FoNDeAqQiqzPHs8fFml2CYYR3Qg1OuwE5Q2Z99PCiCZqbc2Qp/zoxJEm+7TUEWIWH7rQTveHqbUDa5drDRtGy3Rz9Ap9F6/qStf/T4J+Zs1BA4hwTp0pnFDIm6CCH82Voxk1k5qHrIiix2tvETRqt7zkXQ==
Received: from CH2PR05CA0013.namprd05.prod.outlook.com (2603:10b6:610::26) by
 IA0PPF4D923B935.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bcd)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Mon, 26 Jan
 2026 10:50:41 +0000
Received: from CH2PEPF0000013C.namprd02.prod.outlook.com
 (2603:10b6:610:0:cafe::86) by CH2PR05CA0013.outlook.office365.com
 (2603:10b6:610::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.6 via Frontend Transport; Mon,
 26 Jan 2026 10:50:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF0000013C.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Mon, 26 Jan 2026 10:50:41 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 26 Jan
 2026 02:50:26 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 26 Jan
 2026 02:50:22 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <clg@redhat.com>, <alex@shazbot.org>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>,
 <kjaju@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v9 36/37] hw/vfio/pci: Synthesize PASID capability for
 vfio-pci devices
Date: Mon, 26 Jan 2026 10:43:33 +0000
Message-ID: <20260126104342.253965-37-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260126104342.253965-1-skolothumtho@nvidia.com>
References: <20260126104342.253965-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013C:EE_|IA0PPF4D923B935:EE_
X-MS-Office365-Filtering-Correlation-Id: 39c9afa7-4b85-4886-57af-08de5cc8c015
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|7416014|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OWo2ajdMY2ZYd1QyV2FyNTdMY2Nuam9kdFJlOWwxOEx5Wnh2U0VIZE8rWjR4?=
 =?utf-8?B?Z1FyUThkWG43MExmNTZoY0JpWnF1WmhDY2E0dWJKa3pkdTRhUml1ZkkxMUdi?=
 =?utf-8?B?TXp1UTlVNnF3SmYvWkNtZmxPR3RWRkVBc2ZKUi8yN2ZnZ1BVN0xONTZiL1N3?=
 =?utf-8?B?RFM1NjQ2aGpTaVVra0hSdzVjTERSTWNkZGpNUEYwSi9XN0RmcjJlWGU0WkVL?=
 =?utf-8?B?QXlzQ0Z3TEFDei9Namd5UENoMk9vN2E2R2RObGVycExlUzVCN2JianBaTWJF?=
 =?utf-8?B?VU5ycTVhc2llRFpVanFkUTY4NjUwZnJUOE1wYndQYzJIZE1Yc01CdnVtRmx1?=
 =?utf-8?B?M1cybE16SXFiMzhjTkVLSWdGRUFVMVR6T3dvdDdtekdLWXhBRFg5Ym9RenJa?=
 =?utf-8?B?OGVEL2Y1N2dDS1BCZ3p5TjBwR0RwbndxSVZJUDZOOHJqN0lLZE4wMjdYTUky?=
 =?utf-8?B?bkhWUWNzRTFkSmwzdGVKTlhvK0Y5NkRndmhGdEVMZC8yMTN6NUdTZTkrS3Bj?=
 =?utf-8?B?UkRSSERlS3NhSXA2cU91akJnaFVjbzJKRU1hbTdjMjFKSENzZ0gyUlN5QUhr?=
 =?utf-8?B?M2FRd3c0RnJ1ckUvMFJoRHU5VmFzRmxhWERvSDhxRW1TMjE1NGs1bFRqZHBX?=
 =?utf-8?B?eU1PNWV5M1F1NWNIcVNpSG5kRWg0clVtNkMwYVdxampPcFZabzByNGdFNXdR?=
 =?utf-8?B?U2tTWllweDRSRDRQK0p2MXdzeWVKcXA4TmluSDJyUE9HZFZRMER0S1FkaHc5?=
 =?utf-8?B?SXF0M3NoSHNaZ3laeVM0cmV0ZjJlSHBaM21tNTBmLytORjcyQ2NNa2dNdFhS?=
 =?utf-8?B?WG5JMU11VktLdThON2ZFT3h5NkRPSm5NZVU0NGhNSWpMSzVoSy9NUzRHejlC?=
 =?utf-8?B?NXBXOS9IL2tQY2VwcUdic3dqVkZoRVhMajV6N0lEMVRYcm9SV2I0ZysyeFho?=
 =?utf-8?B?SW85Y0p1aG5YaUtwRWhzSCtVckdZK0pBSkd4ZUY2NkF2cCszelF0Z20vTndr?=
 =?utf-8?B?b3lYNm4rNkV4dGtJQmNLcXdOVXZIMExmZXA2WHNtSW16clJ5Wko4TWtXd0VY?=
 =?utf-8?B?Z084RlV6S1dQMmRXOVlPSUREcWkvMEZrdDdUbThiSnUrWDhGVDRpamc2Q3RY?=
 =?utf-8?B?TGJaUkNLN2VhVEJncktsRStjSlExVkRXM2VkazVvd21NNVE4Qzh2Wk91SVhT?=
 =?utf-8?B?aHFTWW55WjZNWlFzVldQZTlzQi82OXZQVDV1eVdodUovanBsVWxNTk1LQmYr?=
 =?utf-8?B?Ymh5Y3JOVGFXNEFub25kV2xWWXpOdEQ5UHorZytyRUdQNGt5N0xNQ3lRSTha?=
 =?utf-8?B?SmF1Z2FnNktIbld5bzFUQ013eDRYN05UODVZR0lJY3lsOXRvTFJwdXgwSEwz?=
 =?utf-8?B?a2ZwQWM5UzBmTnZqdWJzWVJVVGJKNy93NEtBTjZENDRlbXhJaEJlYWd5U3Jl?=
 =?utf-8?B?K1VtMzRNa2MwZUNDYUppZVdNaGlJamwvcFF1czFYWGV6ZHJmVUJCWXUzVnYw?=
 =?utf-8?B?blprMHZrT05SM01waWNCd0t6QWtLdHBYaklEcXp6NEpBaGo0a2pHMG5JbE15?=
 =?utf-8?B?Sm1ycmJ5MWllb3Y2bWlVRk5VWXg0NTlNako3eEtTaHo0UWJGaFN4RGFZVzNp?=
 =?utf-8?B?cFplbEhnVUlTNjM3YkVqcW0xdGFsNGoySVVaMkU1ZUNFdnAzYUZ4MCt3WjFl?=
 =?utf-8?B?eXlsNDcwbVRHT1poaXVHNk9STmxtNDhDR0Z0c2FwVVFodXE3R1MzN09zRlpP?=
 =?utf-8?B?Uzg1ZkZEMFRjZDF5bittczNsZ2kxM0R4Ulcvb1pSaVJNKzFKZ0tvREM3UEFC?=
 =?utf-8?B?aUhMNFNFNGRveUFvMmdCZDhOVzlZZS9GSnpNS0xyZHczR1ErbGFVSXgwdTV5?=
 =?utf-8?B?YzdkN0FUblBFV3RCbDJ2SjNWbDdLUkZENm5WZFZkQVlWUk1NVm9CbVd3MSt4?=
 =?utf-8?B?bG9vRmdrblB6akl3NUdobzYwUmtGbEpqQnJEL0RvWWNBci9YYTdnUnZSa1Uv?=
 =?utf-8?B?SHcvbk15ZnZiQ1d2WUpFR2xnN1hIb2NUcWdsaEd3NVpMVzhzaUhocS9xbGN5?=
 =?utf-8?B?bTRmaCsyMVF3SVpqS0RmWTFvbFJkKzMvUWxPYWhZV3lGYU85VFBhQWVyUytU?=
 =?utf-8?B?VHh5dzFaT0tQb0Zkd0JwcXM4R0RpYzF1eitOazZtdVZkRURSbkIyKzF6K3Fu?=
 =?utf-8?B?U0RGM2FORmdNYnIvYUkrTWZQT3g3RUt1bjlQMktLRkpzcUpEUzd0cFZLSWlP?=
 =?utf-8?B?YSsyODZpMVZJUG94eHlnOGFkR3JBPT0=?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(7416014)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 10:50:41.7501 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39c9afa7-4b85-4886-57af-08de5cc8c015
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF4D923B935
Received-SPF: permerror client-ip=2a01:111:f403:c001::2;
 envelope-from=skolothumtho@nvidia.com;
 helo=SJ2PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=0.587, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

Add support for synthesizing a PCIe PASID extended capability for
vfio-pci devices when PASID is enabled via a vIOMMU and supported by
the host IOMMU backend.

PASID capability parameters are retrieved via IOMMUFD APIs and the
capability is inserted into the PCIe extended capability list using
the insertion helper. A new x-vpasid-cap-offset property allows
explicit control over the placement; by default the capability is
placed at the end of the PCIe extended configuration space.

If the kernel does not expose PASID information or insertion fails,
the device continues without PASID support.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/vfio/pci.c           | 75 +++++++++++++++++++++++++++++++++++++++++
 hw/vfio/pci.h           |  1 +
 hw/vfio/trace-events    |  1 +
 include/hw/core/iommu.h |  1 +
 4 files changed, 78 insertions(+)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index c734472721..36d8fbe872 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -24,6 +24,7 @@
 #include <sys/ioctl.h>
 
 #include "hw/core/hw-error.h"
+#include "hw/core/iommu.h"
 #include "hw/pci/msi.h"
 #include "hw/pci/msix.h"
 #include "hw/pci/pci_bridge.h"
@@ -2498,9 +2499,62 @@ static int vfio_setup_rebar_ecap(VFIOPCIDevice *vdev, uint16_t pos)
     return 0;
 }
 
+/*
+ * Try to retrieve PASID capability information via IOMMUFD APIs and,
+ * if supported, synthesize a PASID PCIe extended capability for the
+ * VFIO device.
+ *
+ * Use user-specified PASID capability offset if provided, otherwise
+ * place it at the end of the PCIe extended configuration space.
+ */
+static bool vfio_pci_synthesize_pasid_cap(VFIOPCIDevice *vdev, Error **errp)
+{
+    HostIOMMUDevice *hiod = vdev->vbasedev.hiod;
+    HostIOMMUDeviceClass *hiodc;
+    PasidInfo pasid_info;
+    PCIDevice *pdev = PCI_DEVICE(vdev);
+    uint16_t pasid_offset;
+
+    if (!hiod) {
+        return true;
+    }
+
+    hiodc = HOST_IOMMU_DEVICE_GET_CLASS(hiod);
+    if (!hiodc || !hiodc->get_pasid_info ||
+        !hiodc->get_pasid_info(hiod, &pasid_info) ||
+        !(pci_device_get_viommu_flags(pdev) & VIOMMU_FLAG_PASID_SUPPORTED)) {
+        return true;
+    }
+
+    /* Use user-specified offset if set, otherwise place PASID at the end. */
+    if (vdev->vpasid_cap_offset) {
+        pasid_offset = vdev->vpasid_cap_offset;
+    } else {
+        pasid_offset = PCIE_CONFIG_SPACE_SIZE - PCI_EXT_CAP_PASID_SIZEOF;
+    }
+
+    if (!pcie_insert_capability(pdev, PCI_EXT_CAP_ID_PASID, PCI_PASID_VER,
+                                pasid_offset, PCI_EXT_CAP_PASID_SIZEOF)) {
+        error_setg(errp, "vfio: Placing PASID capability at offset 0x%x failed",
+                   pasid_offset);
+        return false;
+    }
+    trace_vfio_pci_synthesize_pasid_cap(vdev->vbasedev.name, pasid_offset);
+
+    pcie_pasid_common_init(pdev, pasid_offset, pasid_info.max_pasid_log2,
+                           pasid_info.exec_perm, pasid_info.priv_mod);
+
+    /* PASID capability is fully emulated by QEMU */
+    memset(vdev->emulated_config_bits + pdev->exp.pasid_cap, 0xff,
+           PCI_EXT_CAP_PASID_SIZEOF);
+    return true;
+}
+
 static void vfio_add_ext_cap(VFIOPCIDevice *vdev)
 {
     PCIDevice *pdev = PCI_DEVICE(vdev);
+    bool pasid_cap_added = false;
+    Error *err = NULL;
     uint32_t header;
     uint16_t cap_id, next, size;
     uint8_t cap_ver;
@@ -2578,12 +2632,24 @@ static void vfio_add_ext_cap(VFIOPCIDevice *vdev)
                 pcie_add_capability(pdev, cap_id, cap_ver, next, size);
             }
             break;
+        /*
+         * VFIO kernel does not expose the PASID CAP today. We may synthesize
+         * one later through IOMMUFD APIs. If VFIO ever starts exposing it,
+         * record its presence here so we do not create a duplicate CAP.
+         */
+        case PCI_EXT_CAP_ID_PASID:
+            pasid_cap_added = true;
+            /* fallthrough */
         default:
             pcie_add_capability(pdev, cap_id, cap_ver, next, size);
         }
 
     }
 
+    if (!pasid_cap_added && !vfio_pci_synthesize_pasid_cap(vdev, &err)) {
+        error_report_err(err);
+    }
+
     /* Cleanup chain head ID if necessary */
     if (pci_get_word(pdev->config + PCI_CONFIG_SPACE_SIZE) == 0xFFFF) {
         pci_set_word(pdev->config + PCI_CONFIG_SPACE_SIZE, 0);
@@ -3756,6 +3822,8 @@ static const Property vfio_pci_properties[] = {
                      TYPE_IOMMUFD_BACKEND, IOMMUFDBackend *),
 #endif
     DEFINE_PROP_BOOL("skip-vsc-check", VFIOPCIDevice, skip_vsc_check, true),
+    DEFINE_PROP_UINT16("x-vpasid-cap-offset", VFIOPCIDevice,
+                       vpasid_cap_offset, 0),
 };
 
 #ifdef CONFIG_IOMMUFD
@@ -3913,6 +3981,13 @@ static void vfio_pci_class_init(ObjectClass *klass, const void *data)
                                           "destination when doing live "
                                           "migration of device state via "
                                           "multifd channels");
+   object_class_property_set_description(klass, /* 11.0 */
+                                          "x-vpasid-cap-offset",
+                                          "PCIe extended configuration space offset at which to place a "
+                                          "synthetic PASID extended capability when PASID is enabled via "
+                                          "a vIOMMU. A value of 0 (default) places the capability at the "
+                                          "end of the extended configuration space. The offset must be "
+                                          "4-byte aligned and within the PCIe extended configuration space");
 }
 
 static const TypeInfo vfio_pci_info = {
diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index 0f78cf9cdb..d6495d7f29 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -187,6 +187,7 @@ struct VFIOPCIDevice {
     bool defer_kvm_irq_routing;
     bool clear_parent_atomics_on_exit;
     bool skip_vsc_check;
+    uint16_t vpasid_cap_offset;
     VFIODisplay *dpy;
     Notifier irqchip_change_notifier;
     VFIOPCICPR cpr;
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index 180e3d526b..b48c4abe7a 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -40,6 +40,7 @@ vfio_pci_hot_reset_result(const char *name, const char *result) "%s hot reset: %
 vfio_pci_populate_device_config(const char *name, unsigned long size, unsigned long offset, unsigned long flags) "Device '%s' config: size: 0x%lx, offset: 0x%lx, flags: 0x%lx"
 vfio_pci_populate_device_get_irq_info_failure(const char *errstr) "VFIO_DEVICE_GET_IRQ_INFO failure: %s"
 vfio_mdev(const char *name, bool is_mdev) " (%s) is_mdev %d"
+vfio_pci_synthesize_pasid_cap(const char *name,  uint16_t offset)  "%s offset: 0x%x"
 vfio_add_ext_cap_dropped(const char *name, uint16_t cap, uint16_t offset) "%s 0x%x@0x%x"
 vfio_pci_reset(const char *name) " (%s)"
 vfio_pci_reset_flr(const char *name) "%s FLR/VFIO_DEVICE_RESET"
diff --git a/include/hw/core/iommu.h b/include/hw/core/iommu.h
index d5401a397b..86af315c15 100644
--- a/include/hw/core/iommu.h
+++ b/include/hw/core/iommu.h
@@ -20,6 +20,7 @@
 enum viommu_flags {
     /* vIOMMU needs nesting parent HWPT to create nested HWPT */
     VIOMMU_FLAG_WANT_NESTING_PARENT = BIT_ULL(0),
+    VIOMMU_FLAG_PASID_SUPPORTED = BIT_ULL(1),
 };
 
 /* Host IOMMU quirks. Extracted from host IOMMU capabilities */
-- 
2.43.0


