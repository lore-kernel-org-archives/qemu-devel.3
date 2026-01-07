Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73E7CCF6BF2
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 07:51:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdOKS-0005Jy-CN; Wed, 07 Jan 2026 02:51:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1vdOJs-0004zt-1p
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 02:51:06 -0500
Received: from mail-westcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c112::7] helo=CY3PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1vdOJo-0003H5-Rj
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 02:51:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aUIWVzmyfSgo0yvTPyoNcmPbY3W5B+OOOjyZmlgX7ODl9+4trKp27dwLl/XN9SMMHP7w8N8EviU6it3yta1srBMwcfB+LYcB8PfXFFO6cN7mfptHiI7ndpqtvM38pTwI9p8iODJ4k8/IZyYJkv1eZFGBLT3TuzZ/1Zwxn7D+ez1BXd+f31d3cKMTa0kEp2DBEV/IgDHHnLKzynfLBJa+VAL2S+8F2qf8jpHx4PLbhX5bf6FAlaGZqVdDdpLS8boEkKwdGOuljDTOWQAzxfl7qUvVT0ETaGXVk1UFBje9v8J1TID3CKYfFEVcpZza454hyisBx9eVaR3g2exLVcL/Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t9wRna2kt1TEOV+ujrv8PI06oGs7OyuMaz1W1wJpG2o=;
 b=mdSdsVgzsqmYMrrhbqI4o3bDo/jQJDJsM3YzG6RuMJRpFbQRNiTpVnvv1QwvtGDhMmBSJ74ewZqqgNSDXB/SVpK9sfyzDOUNCtZrLjABCjfM1GmdF7KAqKA3zUtYXMd7Zqm0IYmcMMusykEitq43THweG1KfBvYVkHZoROKmFynZatDkMy5kCYH+tzOeEKN3DmCkmjXlgzO6NcDbipOFamtlfmezQMvDOINsvcaN0YOUqNOGU39fI2ouzdMosFyZSVFG2+suM8DlCFO4TS63wXpaSntBIL+CmPQGXrLsjT9p6I5wzcmcjo2yPQExyuPLHFThh5yrSvNYxhhw9Tss7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t9wRna2kt1TEOV+ujrv8PI06oGs7OyuMaz1W1wJpG2o=;
 b=3AAFcwQfSvQDplWVOB6XEs5cEXBBtLX9NAKY1AsLYu3Sbf0QWjBHIdiPcOEtdyKE0uH66NcjfZKCas0KDyhYaDSSdGWwiZ4iUEO6CadfQDTb43HsUXbkOpIf2cUzeO+hzHJrEc4KsmbqIXNyU7y9068Flvz6FU2bezIXCZrtllw=
Received: from BY3PR05CA0005.namprd05.prod.outlook.com (2603:10b6:a03:254::10)
 by BY5PR12MB4259.namprd12.prod.outlook.com (2603:10b6:a03:202::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 07:50:54 +0000
Received: from SJ1PEPF00001CEB.namprd03.prod.outlook.com
 (2603:10b6:a03:254:cafe::b7) by BY3PR05CA0005.outlook.office365.com
 (2603:10b6:a03:254::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.1 via Frontend Transport; Wed, 7
 Jan 2026 07:50:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CEB.mail.protection.outlook.com (10.167.242.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Wed, 7 Jan 2026 07:50:54 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 7 Jan
 2026 01:50:51 -0600
From: Honglei Huang <honghuan@amd.com>
To: <alex.bennee@linaro.org>, <dmitry.osipenko@collabora.com>,
 <odaki@rsg.ci.i.u-tokyo.ac.jp>, <Ray.Huang@amd.com>
CC: <mst@redhat.com>, <cohuck@redhat.com>, <pbonzini@redhat.com>,
 <qemu-devel@nongnu.org>, <honghuan@amd.com>
Subject: [PATCH RFC v4 3/3] virtio-gpu: Add ROCm capability support
Date: Wed, 7 Jan 2026 15:50:30 +0800
Message-ID: <20260107075030.3453924-4-honghuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260107075030.3453924-1-honghuan@amd.com>
References: <20260107075030.3453924-1-honghuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEB:EE_|BY5PR12MB4259:EE_
X-MS-Office365-Filtering-Correlation-Id: b5dd9bbd-32f1-4978-2c91-08de4dc17c58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PSxNEIBgnQCrd4fYt+3iN5bGCbuc/4x5D3TzyxHSbrWurgXOc8NSJ5I1+ZAH?=
 =?us-ascii?Q?29NHXTcBrvuuoMs3r+L4nFHMTyIBF6mEMdL24ynKkgtVKn159Z+VTGaAvbD9?=
 =?us-ascii?Q?OKrr9dmnF+KF6gZQk8mRGkBLei4dpKAnXerL/I8Q5otcEqKy7tw2Sxm1gjDW?=
 =?us-ascii?Q?lc1HQo4O40mYe0wmmoRd4mDTBhdFJ3x+t9BH43aKLzK1Q8ryJKRqjO1NR6J0?=
 =?us-ascii?Q?TWa5SPMwIj0lYQQU3U8oIXpu6g681eplskaehBK3jOiNZ0uSj7xQqKCFsD2s?=
 =?us-ascii?Q?Gbf/K2KYB3isA/P3e6OMcC8Q11AOxeL5B6FGB+Cl0hMb7fiaCYOP4iBXE3Gg?=
 =?us-ascii?Q?NlKDdkP9X+tcg0kml0O/ieClx7ZR93+STI98oifOcQMyi0175twjx8GPlIlN?=
 =?us-ascii?Q?sHe/oeDafO0YEJ8tkmO/w6VRBLyglOZiqO9STHTSvds8fWRiqqC0tq+UKouQ?=
 =?us-ascii?Q?Xj/PYK7XKtc4kzgsJa5ArNCspPR05JKdUlSGTUS2Eihf9IcdOz6mjMYdhoia?=
 =?us-ascii?Q?eyJ0rK0My8DcFlDWgvQgHtdg7XDX1RQ9Nxy7HmpkUYQZaVKHUgdHkqu0sbAt?=
 =?us-ascii?Q?nUiLfBQi774Z0ACV45Hcsf4YiOxfVHkc2NXRCQBTl7CRt7+apP9qo0KbSdmZ?=
 =?us-ascii?Q?EehqUGOaPYWUAv2zPqG6G7HvkiUYcyfAQzz3p5iqtru7Xlx3XvoPsf1rjILb?=
 =?us-ascii?Q?L4Bp1krPAqEXSAKQka0R7vT5dF4dpOypA9Kqq+htHhPLAjRAt+X3+8YS51SE?=
 =?us-ascii?Q?3Qz4dGzbHoPECAtCtTv+8uKx8Ah/ych5lUK4y8c+8RHpH6P+1bhDL+jJWpge?=
 =?us-ascii?Q?IsG3WR6GElI3wqWR3cH76Z1eI200WNXuFJ1Om2PtoRUyWkdIT8IObu75P/AG?=
 =?us-ascii?Q?WeEIic0gaDmj+/G6zIMo/oF6FACr1oiYqI+6AfS7MemSSgvI2XDAnE6Ec7AI?=
 =?us-ascii?Q?Xk2LjpNsk8Ub0W+RG/VfDCn2DcX+1fSz43Uq/l9tMGQM38IhsBZ501TytBwC?=
 =?us-ascii?Q?aI+wOEgsdG+ND71x5gg5JMGIBS0g8oWesg07H52QDN+L4eUiH1pnDP1Wkl+k?=
 =?us-ascii?Q?+77QZF6kO66L0RSddmLkMCjkyKg9Ex2f3Z83q2ZjJR1wa99a+TFyT5eqc58B?=
 =?us-ascii?Q?pMFF2vM1NWCwUroZl4N2mS9eiPILJ0fmhydndLIwLzy/NJAyP6QtQabBIRnq?=
 =?us-ascii?Q?37von5mpoKLjQ+TipDyp2M0ZNlP3Wy0mDCxT1DrlDwM4BJ41KaCcGhB6wlhQ?=
 =?us-ascii?Q?eHol6GaRCiqrT3Ieg7oSoESslNqlFOkdiCU7vE4PYFyYg5eEayWrWqMnKfwz?=
 =?us-ascii?Q?lFhe7QlT3ba3LQ3N0eSpjbyyRRlt7uwhP+vi1eo710LPMZJoVvfI0kT6WdFq?=
 =?us-ascii?Q?wEx1K5qqjvW6gD/GsMvyHd+J8Y4q/mAGpeRfTGHsyjBfDBZVPy0OBOHhfYww?=
 =?us-ascii?Q?UdY5XJZJNOGEmBHOGvPYWW3HWsFkdg38BdeSqG+rmasVsb7GtH1DxDQe0rwp?=
 =?us-ascii?Q?FnJ4SJKvR1CUCTIJxgOHqRrzn1ypJ9jaoP8J3cm6zHHiGHpPVhmdUQFhWtcQ?=
 =?us-ascii?Q?0lF61HDtKjBhNgdY2LY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 07:50:54.2089 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5dd9bbd-32f1-4978-2c91-08de4dc17c58
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CEB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4259
Received-SPF: permerror client-ip=2a01:111:f403:c112::7;
 envelope-from=Honglei1.Huang@amd.com;
 helo=CY3PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add support for ROCm (Radeon Open Compute) capability in virtio-gpu.
This enables GPU compute workloads using AMD's ROCm platform through
the virtio-gpu interface.

Changes include:
- Add "rocm" property to virtio-gpu-gl device
- Define VIRTIO_GPU_FLAG_ROCM_ENABLED flag
- Enable VIRGL_RENDERER_USE_ROCM flag when ROCm is enabled
- Register VIRTIO_GPU_CAPSET_ROCM (capset 8) capability
- Add virtio_gpu_rocm_enabled() helper macro

This allows guests to detect and utilize ROCm capabilities through
the virtio-gpu device when the feature is enabled.

Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 hw/display/virtio-gpu-gl.c                  |  2 ++
 hw/display/virtio-gpu-virgl.c               | 12 ++++++++++++
 include/hw/virtio/virtio-gpu.h              |  3 +++
 include/standard-headers/linux/virtio_gpu.h |  1 +
 4 files changed, 18 insertions(+)

diff --git a/hw/display/virtio-gpu-gl.c b/hw/display/virtio-gpu-gl.c
index b98ef2ef98..f059bcb177 100644
--- a/hw/display/virtio-gpu-gl.c
+++ b/hw/display/virtio-gpu-gl.c
@@ -159,6 +159,8 @@ static const Property virtio_gpu_gl_properties[] = {
                     VIRTIO_GPU_FLAG_STATS_ENABLED, false),
     DEFINE_PROP_BIT("venus", VirtIOGPU, parent_obj.conf.flags,
                     VIRTIO_GPU_FLAG_VENUS_ENABLED, false),
+    DEFINE_PROP_BIT("rocm", VirtIOGPU, parent_obj.conf.flags,
+                    VIRTIO_GPU_FLAG_ROCM_ENABLED, false),
 };
 
 static void virtio_gpu_gl_device_unrealize(DeviceState *qdev)
diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index cbfb8aca3f..5e0f465c37 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -1160,6 +1160,9 @@ int virtio_gpu_virgl_init(VirtIOGPU *g)
     if (virtio_gpu_venus_enabled(g->parent_obj.conf)) {
         flags |= VIRGL_RENDERER_VENUS | VIRGL_RENDERER_RENDER_SERVER;
     }
+    if (virtio_gpu_rocm_enabled(g->parent_obj.conf)) {
+        flags |= (VIRGL_RENDERER_USE_ROCM);
+    }
 #endif
 
     ret = virgl_renderer_init(g, flags, &virtio_gpu_3d_cbs);
@@ -1218,5 +1221,14 @@ GArray *virtio_gpu_virgl_get_capsets(VirtIOGPU *g)
         }
     }
 
+    if (virtio_gpu_rocm_enabled(g->parent_obj.conf)) {
+        virgl_renderer_get_cap_set(VIRTIO_GPU_CAPSET_ROCM,
+                                   &capset_max_ver,
+                                   &capset_max_size);
+        if (capset_max_size) {
+            virtio_gpu_virgl_add_capset(capset_ids, VIRTIO_GPU_CAPSET_ROCM);
+        }
+    }
+
     return capset_ids;
 }
diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index fe98ea0019..a099c30377 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -101,6 +101,7 @@ enum virtio_gpu_base_conf_flags {
     VIRTIO_GPU_FLAG_VENUS_ENABLED,
     VIRTIO_GPU_FLAG_RESOURCE_UUID_ENABLED,
     VIRTIO_GPU_FLAG_RESOURCE_USERPTR_ENABLED,
+    VIRTIO_GPU_FLAG_ROCM_ENABLED,
 };
 
 #define virtio_gpu_virgl_enabled(_cfg) \
@@ -125,6 +126,8 @@ enum virtio_gpu_base_conf_flags {
     (_cfg.flags & (1 << VIRTIO_GPU_FLAG_VENUS_ENABLED))
 #define virtio_gpu_resource_userptr_enabled(_cfg) \
     (_cfg.flags & (1 << VIRTIO_GPU_FLAG_RESOURCE_USERPTR_ENABLED))
+#define virtio_gpu_rocm_enabled(_cfg) \
+    (_cfg.flags & (1 << VIRTIO_GPU_FLAG_ROCM_ENABLED))
 
 struct virtio_gpu_base_conf {
     uint32_t max_outputs;
diff --git a/include/standard-headers/linux/virtio_gpu.h b/include/standard-headers/linux/virtio_gpu.h
index fe36288fe5..fe6c0f5cc4 100644
--- a/include/standard-headers/linux/virtio_gpu.h
+++ b/include/standard-headers/linux/virtio_gpu.h
@@ -315,6 +315,7 @@ struct virtio_gpu_cmd_submit {
 #define VIRTIO_GPU_CAPSET_VENUS 4
 #define VIRTIO_GPU_CAPSET_CROSS_DOMAIN 5
 #define VIRTIO_GPU_CAPSET_DRM 6
+#define VIRTIO_GPU_CAPSET_ROCM 8
 
 /* VIRTIO_GPU_CMD_GET_CAPSET_INFO */
 struct virtio_gpu_get_capset_info {
-- 
2.34.1


