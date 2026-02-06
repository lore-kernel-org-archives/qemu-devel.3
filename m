Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70857EE20A6
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 14:57:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voNCU-00048S-NB; Fri, 06 Feb 2026 09:52:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1voN9v-0000Tw-2K; Fri, 06 Feb 2026 09:50:12 -0500
Received: from mail-westcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c112::7] helo=CY3PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1voN9s-0007Jp-AQ; Fri, 06 Feb 2026 09:50:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QdCC9Np4sH37mMex4OSwcXEkSob+//nH8RFT5QNMUmjq//QywBWhORgo8POYgujWN5u+2KlqluechWpfdpiqEXm5xicBLgcapJdHVlIwIOLG4b2H/vKCe/8slMZXnUxRYd9zQxGxEHbKzIx0xmtc5yyXfqARnq1kxwzu81fC56WWEHwSuYv2YAkPqdnF3Lr3j0h8EqyixJKwJaxrmwZGTuUgDlrcOv9uNwgEY58hS0hIEabyYGwl5jiZfThvJ31SjsU3qO1oFhjzsLzsshOUIWGfuTsIq3AaFxiFpKq/yZzqEPf5r0dwRBO4OtXlFax9WBjDG6rN70/QL53lSAGaig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TiFWHIEJf/wX1nEJC2PGg+tUAC2jcBfMp/VH2AqW/+8=;
 b=qNgaOSfpZNdg4OR7cAzw/g6TcgkwhdvNr04j6FOctNljv7hnV6ehtjRXtqBkpU90nhUFUCzXjAGO4ibBZwpgGH/+lXdPyDk6r1Ay6e335sYWck0qVM//Cn33aoFhacx8UNShx7eAB0+EiHCrE2CprlX+Kr7eGjmktK4I4XmxQIcdx+AcaqJoxW4wqFFacdQFasP2Y59Y+KK09G/zF00dhI2rVkm+KVlPgEgDr3qeR1IStS+CwUZfhopqyG47mIS6Lrgv2/KkCvC2qBjyygYCMV7VLR/134j2PwA/DT/tzujmvizliWMf/HiXvjS7MsOqRdKoyNU1cPFE2kdWzn424g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TiFWHIEJf/wX1nEJC2PGg+tUAC2jcBfMp/VH2AqW/+8=;
 b=dINykUexyLAFKdUDmiiBxL8N+1QBN2FgnZfKWUOCrCZhe2JzClg5c4d/FKuWViUkASAssAfMOxu2RQm02A5Bzvk9X3W1c01g4LdZAZTGFAF/MK7HgIVq+nrzK/83r2zb51587xJ08fmcbn3K3Jiil4FGg93GoY8t9431RomSoCnqTUpJE102PCsBeMDDBHW40KkXKwvaXmRf/pR1CFrKefVmGSnXRRKhCGHKq9kewZRpSA3gKmNEViRMb3//13nb3inD09inEQ7kdyZhzexcyiHzdrZy3DsIMrcajPRvVF+efjSjCsMuwM+xeeo8TGNTV5R6gpcQn6zGkz7/lIWT8g==
Received: from BY5PR13CA0016.namprd13.prod.outlook.com (2603:10b6:a03:180::29)
 by CY8PR12MB8412.namprd12.prod.outlook.com (2603:10b6:930:6f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Fri, 6 Feb
 2026 14:49:58 +0000
Received: from CO1PEPF000066E9.namprd05.prod.outlook.com
 (2603:10b6:a03:180:cafe::9e) by BY5PR13CA0016.outlook.office365.com
 (2603:10b6:a03:180::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.15 via Frontend Transport; Fri,
 6 Feb 2026 14:50:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000066E9.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Fri, 6 Feb 2026 14:49:56 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Feb
 2026 06:49:32 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Feb
 2026 06:49:29 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v2 07/24] hw/arm/smmuv3-accel: Wire CMDQV ops into accel
 lifecycle
Date: Fri, 6 Feb 2026 14:48:06 +0000
Message-ID: <20260206144823.80655-8-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260206144823.80655-1-skolothumtho@nvidia.com>
References: <20260206144823.80655-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E9:EE_|CY8PR12MB8412:EE_
X-MS-Office365-Filtering-Correlation-Id: 41b140c0-1808-45d7-09d4-08de658efeb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xDgtfNdX6Yzbf4BFZ1xMOULSEVn/njcTUBhJV9DKyUI6+ElJBtZTzl2A5i1k?=
 =?us-ascii?Q?vI8sF13g7owzxeGsUnVe1mUaTorB+ep9kBDQB6ktyyBsnclu1rF7RvVY2xf8?=
 =?us-ascii?Q?dJUFRjWzwQeK8ziZtUSVR/+TDHN/CN/6izuRNKFVVaziDW2IUk4p3ccT3R3P?=
 =?us-ascii?Q?3QMCDpkqfAH6omETpCjho7nNxgXJiRluv+Cz+hgvCGm52KZuiX+FbHqXy3qm?=
 =?us-ascii?Q?4+QnGqPJ+jKxYLf3i+GxHB2lsVnjfDnZjX8hQJkYMy6YToArg4zPqI5Ma2EJ?=
 =?us-ascii?Q?M/fDANuSZKnYw2lgK8RtkB0hvn2b9dyrCOUnBcdFGb1HrWq1FJFCgIe9Dzaj?=
 =?us-ascii?Q?XSu4LbDgl1z34HQUmawVSh3hAWE0KVT/KjCiZHW7exEaGppB6sW1cLBB9/nE?=
 =?us-ascii?Q?OnGsbCUn9y4BM7BLylTIc5Gd2wE5+vW4zYOu2lcwkeyVXXmf2OeJbPKN4csj?=
 =?us-ascii?Q?RUNrVY4H4/vPvcZJs6UYP6NpgGSFh3LWwHQ/EP+WpA3mLEbYRi9pQo5+u2Lr?=
 =?us-ascii?Q?Xou1f0+kxjTT/zyOcsd7ittY8fVhInY+SVK0atwrMAwQoWI+o8pljFEEDzGW?=
 =?us-ascii?Q?PSorBIektPgPoGAmdw1BMyMht5LYQ9PDpdmTiINbcvwmBdeIAYk8wgSSfoz8?=
 =?us-ascii?Q?Qajir5oIwpolXHYy5uALVKPZtRdr6o4dUviEBw8671e63GMENDShnepmszz4?=
 =?us-ascii?Q?cjY8O1CB405JQ/FzzItA/oSbAfIAc5QbylKeFrlh8CS/DUudTi46FaLNpVUg?=
 =?us-ascii?Q?XszUarNP5slAVkd9tn7kS4lWkCS062z5xQJ+Lcta0gNryK9UTxqlH0gYEHy0?=
 =?us-ascii?Q?DindCvzgA9pKV3OQwviiv8usHJMYHR/DeVBH1zuHRFTO7gLUR4YkGHBnRCT6?=
 =?us-ascii?Q?HvNuhzlz6Lk33zmHvAswWkbxddQPQoYIqRFRh8Qsrcq4pM531UVsfpALQ6/u?=
 =?us-ascii?Q?ZRgypLzp+/0gqx7xRiFstfK436H8pEKfnaUTmSynI8D89n1WgHjy1h6EDj63?=
 =?us-ascii?Q?qmDL4aeDQ2fTcq3DW0u0i6UjQBOxmM+MVBFStxqibg6GbZsL/6jdc7WZkYK6?=
 =?us-ascii?Q?aFHToI6idAbWrMSwtoHlK/X18hfJSv/1Qr2toG0TGqxhozBGxlutmMLwpoQ8?=
 =?us-ascii?Q?AhZFXr7BKPTGhd9ZXeisNSl4T9XbPrq2EzxFpw0Q1VCggVKlN+OjNhAT+6CE?=
 =?us-ascii?Q?PYJyrhB0kguL/KtJniSojcTQgSSCb+W4WGKZpQdOIDi+usm2HfN0nMkEUmW9?=
 =?us-ascii?Q?iyguY2CNJd05A9+S0o6ci22osGf8RZ/g5KYq5h7u0vCPc3oOjLxDmnNJN8DC?=
 =?us-ascii?Q?45kxLpCYf2aUsZaWIpak+wvm1A+bTLvGJYBWRdjzlK3OALx+Y1uMPM9tXgvD?=
 =?us-ascii?Q?98Ny43oac9i2vA+BU6kkiOvNW49ReTvejccq0SkVLI6o0d482IveeVIDvABB?=
 =?us-ascii?Q?1ZOaRxEDUDUv36qqQhaKwBFLEjKY4eEHIjo1p4mbVneQS1E1pNkP2ppwCTnw?=
 =?us-ascii?Q?B4N8/pnqBcqXSkYNfAnr7RPbas3M9hjqYgW58UjtgjjpMDVSyn9K4I/6ybx8?=
 =?us-ascii?Q?2W28PFMJ6LAyK/UhQ4F6Kd4fjvAYbNTjArev81sKJriLDCljmqe6whLrSOto?=
 =?us-ascii?Q?1R1n5oGfp7nnvgidHH/WBp8fPbI8hArcEwAGWQopTp2FKJoherCfZusVSXGQ?=
 =?us-ascii?Q?8OoBjA=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: JpglPKnOV+Bl9lvm76pZwp4FYCpfj38bEig8fYzsNhG6ZY5hZrPlWgdoXf0gVQv/Fk86dUJlR2ENctwnYwmq9U0wgUXoNX/HFM8xyGRcepGh76qvmtbirsgNpIBVA68Y0f9tNHgRCVgI24UNnnsB/+4zewKwEtgBGf+HXrAITscFy9feyFBqbif+9BcxGfuIERUwATyzhiyRy+kBbeAOdHs8AIhuTr4ZuyG8oYbMJkp94Hkr3pvqWhfYovJ4cvfAQmZmwcTBSFky1XMG+3QEAKkr1K+cKEj9EXS4fE6Xh48BcNt+eh1HW5xH6UJSl3GyozgrkaBrbspLHhLo7QNWl4u/1jHW1D0ASpxrXbuhwOzijH3DMATsvksF8Qhv+WBcxpQ6beJoCuLHWB8nlurz3ie5EYAJT0IHpxlER6VOPP6yX/yiJG3xJdstXWu1oZ3e
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 14:49:56.4588 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41b140c0-1808-45d7-09d4-08de658efeb1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8412
Received-SPF: permerror client-ip=2a01:111:f403:c112::7;
 envelope-from=skolothumtho@nvidia.com;
 helo=CY3PR05CU001.outbound.protection.outlook.com
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

Integrate CMDQV ops support into the accelerated SMMUv3 path. When CMDQV
is enabled, the backend ops are used to initialize CMDQV state and to
allocate the vIOMMU instance. The current implementation connects the
Tegra241 CMDQV backend, but does not enable functional support yet.

No functional changes intended.

Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3-accel.c   | 65 ++++++++++++++++++++++++++++++++++++-----
 hw/arm/smmuv3-accel.h   |  5 ++++
 hw/arm/smmuv3.c         |  1 +
 include/hw/arm/smmuv3.h |  2 ++
 4 files changed, 66 insertions(+), 7 deletions(-)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 9036b14601..b1a8ab79b5 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -18,6 +18,7 @@
 
 #include "smmuv3-internal.h"
 #include "smmuv3-accel.h"
+#include "tegra241-cmdqv.h"
 
 /*
  * The root region aliases the global system memory, and shared_as_sysmem
@@ -520,6 +521,7 @@ smmuv3_accel_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
                           Error **errp)
 {
     SMMUv3AccelState *accel = s->s_accel;
+    const SMMUv3AccelCmdqvOps *cmdqv_ops = accel->cmdqv_ops;
     struct iommu_hwpt_arm_smmuv3 bypass_data = {
         .ste = { SMMU_STE_CFG_BYPASS | SMMU_STE_VALID, 0x0ULL },
     };
@@ -530,12 +532,24 @@ smmuv3_accel_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
     uint32_t viommu_id, hwpt_id;
     IOMMUFDViommu *viommu;
 
-    if (!iommufd_backend_alloc_viommu(idev->iommufd, idev->devid,
-                                      IOMMU_VIOMMU_TYPE_ARM_SMMUV3, s2_hwpt_id,
-                                      NULL, 0, &viommu_id, errp)) {
+    if (cmdqv_ops && (!cmdqv_ops->alloc_viommu || !cmdqv_ops->alloc_veventq)) {
+        error_setg(errp, "CMDQV vIOMMU allocation not supported");
         return false;
     }
 
+    if (cmdqv_ops) {
+        if (!cmdqv_ops->alloc_viommu(s, idev, &viommu_id, errp)) {
+            return false;
+        }
+    } else {
+        if (!iommufd_backend_alloc_viommu(idev->iommufd, idev->devid,
+                                          IOMMU_VIOMMU_TYPE_ARM_SMMUV3,
+                                          s2_hwpt_id, NULL, 0, &viommu_id,
+                                          errp)) {
+            return false;
+        }
+    }
+
     viommu = g_new0(IOMMUFDViommu, 1);
     viommu->viommu_id = viommu_id;
     viommu->s2_hwpt_id = s2_hwpt_id;
@@ -565,13 +579,21 @@ smmuv3_accel_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
         goto free_bypass_hwpt;
     }
 
+    if (cmdqv_ops && !cmdqv_ops->alloc_veventq(s, errp)) {
+        goto free_veventq;
+    }
+
     /* Attach a HWPT based on SMMUv3 GBPA.ABORT value */
     hwpt_id = smmuv3_accel_gbpa_hwpt(s, accel);
     if (!host_iommu_device_iommufd_attach_hwpt(idev, hwpt_id, errp)) {
-        goto free_veventq;
+        goto free_cmdqv_veventq;
     }
     return true;
 
+free_cmdqv_veventq:
+    if (cmdqv_ops && cmdqv_ops->free_veventq) {
+        cmdqv_ops->free_veventq(s);
+    }
 free_veventq:
     smmuv3_accel_free_veventq(accel);
 free_bypass_hwpt:
@@ -579,7 +601,11 @@ free_bypass_hwpt:
 free_abort_hwpt:
     iommufd_backend_free_id(idev->iommufd, accel->abort_hwpt_id);
 free_viommu:
-    iommufd_backend_free_id(idev->iommufd, viommu->viommu_id);
+    if (cmdqv_ops && cmdqv_ops->free_viommu) {
+        cmdqv_ops->free_viommu(s);
+    } else {
+        iommufd_backend_free_id(idev->iommufd, viommu->viommu_id);
+    }
     g_free(viommu);
     accel->viommu = NULL;
     return false;
@@ -865,8 +891,17 @@ bool smmuv3_accel_attach_gbpa_hwpt(SMMUv3State *s, Error **errp)
 
 void smmuv3_accel_reset(SMMUv3State *s)
 {
-     /* Attach a HWPT based on GBPA reset value */
-     smmuv3_accel_attach_gbpa_hwpt(s, NULL);
+    SMMUv3AccelState *accel = s->s_accel;
+
+    if (!accel) {
+        return;
+    }
+    /* Attach a HWPT based on GBPA reset value */
+    smmuv3_accel_attach_gbpa_hwpt(s, NULL);
+
+    if (accel->cmdqv_ops && accel->cmdqv_ops->reset) {
+        accel->cmdqv_ops->reset(s);
+    }
 }
 
 static void smmuv3_accel_as_init(SMMUv3State *s)
@@ -886,6 +921,22 @@ static void smmuv3_accel_as_init(SMMUv3State *s)
     address_space_init(shared_as_sysmem, &root, "smmuv3-accel-as-sysmem");
 }
 
+bool smmuv3_accel_cmdqv_init(SMMUv3State *s, Error **errp)
+{
+    SMMUv3AccelState *accel = s->s_accel;
+
+    if (!accel || !s->tegra241_cmdqv) {
+        return true;
+    }
+
+    accel->cmdqv_ops = tegra241_cmdqv_ops();
+    if (!accel->cmdqv_ops || !accel->cmdqv_ops->init) {
+        error_setg(errp, "CMDQV support not available");
+        return false;
+    }
+    return accel->cmdqv_ops->init(s, errp);
+}
+
 void smmuv3_accel_init(SMMUv3State *s)
 {
     SMMUState *bs = ARM_SMMU(s);
diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
index ca087240e5..33da37bfc1 100644
--- a/hw/arm/smmuv3-accel.h
+++ b/hw/arm/smmuv3-accel.h
@@ -74,6 +74,7 @@ bool smmuv3_accel_issue_inv_cmd(SMMUv3State *s, void *cmd, SMMUDevice *sdev,
 void smmuv3_accel_idr_override(SMMUv3State *s);
 bool smmuv3_accel_alloc_veventq(SMMUv3State *s, Error **errp);
 void smmuv3_accel_reset(SMMUv3State *s);
+bool smmuv3_accel_cmdqv_init(SMMUv3State *s, Error **errp);
 #else
 static inline void smmuv3_accel_init(SMMUv3State *s)
 {
@@ -110,6 +111,10 @@ static inline bool smmuv3_accel_alloc_veventq(SMMUv3State *s, Error **errp)
 static inline void smmuv3_accel_reset(SMMUv3State *s)
 {
 }
+static bool smmuv3_accel_cmdqv_init(SMMUv3State *s, Error **errp)
+{
+    return true;
+}
 #endif
 
 #endif /* HW_ARM_SMMUV3_ACCEL_H */
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 148af80efd..7858bf2c33 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -2034,6 +2034,7 @@ static void smmu_realize(DeviceState *d, Error **errp)
 
     smmu_init_irq(s, dev);
     smmuv3_init_id_regs(s);
+    smmuv3_accel_cmdqv_init(s, errp);
 }
 
 static const VMStateDescription vmstate_smmuv3_queue = {
diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
index 26b2fc42fd..87926f8cb3 100644
--- a/include/hw/arm/smmuv3.h
+++ b/include/hw/arm/smmuv3.h
@@ -73,6 +73,8 @@ struct SMMUv3State {
     bool ats;
     uint8_t oas;
     uint8_t ssidsize;
+    /* Support for NVIDIA Tegra241 SMMU CMDQV extension */
+    bool tegra241_cmdqv;
 };
 
 typedef enum {
-- 
2.43.0


