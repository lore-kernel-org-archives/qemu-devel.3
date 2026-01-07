Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13C30CF6BF0
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 07:20:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdNpQ-0007zb-2n; Wed, 07 Jan 2026 02:19:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1vdNpO-0007xf-Je
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 02:19:34 -0500
Received: from mail-westus3azlp170100009.outbound.protection.outlook.com
 ([2a01:111:f403:c107::9] helo=PH7PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1vdNpM-00049A-B2
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 02:19:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ncyzRQehtPB6TeohcSgU8Os/ZVPfzDW9sxxVGCiuotrO5jJJI2VEKI6xzR+ofE7/lJjE3tn2XrJLiuxUU3gujExFsJEoUT85jt+0soG47SzVXXv3Ys+MWI7ZF9v3ngvVa2GQdualMxT6ojAPTT7ukTFONfI+gLq/feUY0wiTE5kQpn5V6D3N3rpAoYnIO+IVk9oe6Wut64Lt63D+bZEjKtgduAkxHWkfvTgW67DXDf9X3fUKyFe1p1BUKJWl0nsxFWutCMM4XmEqeaHDlhQxplN3l6wJWCjo76XRjyDp9fRhA+d+cQsziKAyCnrsO2ULwnwyvQ3xxGG8V4tAWSDt5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t9wRna2kt1TEOV+ujrv8PI06oGs7OyuMaz1W1wJpG2o=;
 b=FymEa+ofl4s0X/ATwzTAetnEoLgfnMI/ha72/1X0oIPK6ZBm+icMfKlfGjK9He0ccz4CUCGciCLkutXHHuwgpNm6wmJaXmv4phqxtH/CO3oaW7hhp4NJjdcnd7h7Sf1Y345HzTQskF6nZl1nJ6qVqJTMEjf+wHEwRCOMaj7hLJSsffXCrxjGvJdYwuEp/M6N6dzQoX5W/8AsujyLvxII8WG/Rfck3Lt3qzuUUcnp2uco6DzEQggQUCKLKyxWARPjKlX9OAFFIS/vA+CsFSsdWZZdDhwa8Q+Q8gDUhbMpePPR6+6z7MvuY0ErBrkwx+IB9cp72qKIXJDwnd0yLa9vNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t9wRna2kt1TEOV+ujrv8PI06oGs7OyuMaz1W1wJpG2o=;
 b=0OMjxbcAGW9+pP6HT2HxJvtn0fkQo1nJsSQRdNhBgN8srswvX2a5Tg/EO51ekWz1Zh6paUYm8F0EqE97a51VkN7F2JKFKzY6IN/+AU/KSoXnquHv74ytu/Lfv+tLpzkKTTNVeKaDWrecQSRvA6JE6+muQfNlHE4WpMs+JDynwu8=
Received: from BN9PR03CA0074.namprd03.prod.outlook.com (2603:10b6:408:fc::19)
 by MN2PR12MB4408.namprd12.prod.outlook.com (2603:10b6:208:26c::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 07:19:27 +0000
Received: from BN3PEPF0000B06E.namprd21.prod.outlook.com
 (2603:10b6:408:fc:cafe::14) by BN9PR03CA0074.outlook.office365.com
 (2603:10b6:408:fc::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.2 via Frontend Transport; Wed, 7
 Jan 2026 07:19:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B06E.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.0 via Frontend Transport; Wed, 7 Jan 2026 07:19:27 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 7 Jan
 2026 01:19:24 -0600
From: Honglei Huang <honghuan@amd.com>
To: <alex.bennee@linaro.org>, <dmitry.osipenko@collabora.com>,
 <odaki@rsg.ci.i.u-tokyo.ac.jp>, <Ray.Huang@amd.com>
CC: <mst@redhat.com>, <cohuck@redhat.com>, <pbonzini@redhat.com>,
 <qemu-devel@nongnu.org>, <honghuan@amd.com>
Subject: [PATCH v3 3/3] virtio-gpu: Add ROCm capability support
Date: Wed, 7 Jan 2026 15:18:58 +0800
Message-ID: <20260107071858.3452614-4-honghuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260107071858.3452614-1-honghuan@amd.com>
References: <20260107071858.3452614-1-honghuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06E:EE_|MN2PR12MB4408:EE_
X-MS-Office365-Filtering-Correlation-Id: 14b6fa03-07b7-4c6f-31fd-08de4dbd1794
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?P7neKo1YIJHicmjmCZNG6tj+4kyOcx5V+vDHWvjVn6wdEGD2dv6wmkFEUb3O?=
 =?us-ascii?Q?3BqyGrxdQuGB8lmit2pijOCOhl2hXH6PUYnN2LSEhAZ46rgX/xE/2DiL/Ar9?=
 =?us-ascii?Q?oCVTf4d5rXSgF0EdtaQebh4azNRCR7SPsZ9bm+7oD561P9IafYHu0Q4WBLq+?=
 =?us-ascii?Q?dHN+QbPZyLh6HYPcN/nH8+Soz4iu5QaXAe76s3v7t5walUKJgMQqpUjcul7l?=
 =?us-ascii?Q?d9srjnzj2Y/ezyPR78ElW71c2bwWgakFRdEoKmU+sHbWANCg09kIvxiJIkFM?=
 =?us-ascii?Q?SYQykBCzGdja7zdZXnlbxbiUBHq4wNOrPKd4any7wkMEDEQRsz/RJoOSmjdn?=
 =?us-ascii?Q?Ykhqn2Tu0xiIKbyhcqHfWOhXh66Fouegtl2f/83hvZVc46ug4L1/jqHCBtjS?=
 =?us-ascii?Q?/3rKHsbFTy0DpdEPXd5XVePuZoEqm5A1vxVUKWOHTdmc3OM50GLbz8dVWnaf?=
 =?us-ascii?Q?3TA41dXi6ludv/ADmLdSYWR7hkFPNO9O2H51cyrhu3vek5anAgpjJFHfnvgd?=
 =?us-ascii?Q?5hA5ZTNdktxyLkdF7Sck9bevHgAcj8ZlRfvqw485vv1nCUIE4lS14u6MlSL9?=
 =?us-ascii?Q?87qNgY3xPoz72x7rUSyuyHlV4rF6sL3Lz/yahvLKylo64JzUNhXq0OwdW2XK?=
 =?us-ascii?Q?7BXQdGCCeda75sGeuFHFIsyjpg8WI9na1iJRRi39hhyiUKSPdUBSFzJTNT3q?=
 =?us-ascii?Q?1s9QLxWqMCFXc1KCf5Srl8ArUnxA6Qvbfka7QD/evHpRCMxLs2fGcYL6uq3p?=
 =?us-ascii?Q?mc0h2POSls/UUM/bzElxFChXzidwg4CBNkGRR0eeBtJvHU+ZQ+HnAFhZ1vxR?=
 =?us-ascii?Q?z3mEOy2SdeMdRQOAyGsJrsJCPrVHi/KBG9zfzZ0VGy0veKDe8spfads0BXYI?=
 =?us-ascii?Q?ZjoGV4jWCFS35iy7qIOiMQmtyOChAysOGJXE+0LvvAAGJ3EAeU//8edQQXTq?=
 =?us-ascii?Q?qNbdOS7+n6trQNB0qkiPhwtiib69FVoJwIEOmlIdegR6RlzStck6M9jjvMB5?=
 =?us-ascii?Q?AoafXqaa24ZogHteoQ1PZO797s1YvRI3OWkP7Yd/XFai+WSu8VavhSzCkdJc?=
 =?us-ascii?Q?LGpUbDk3xtqL7Mo8BTybqeroHwv2CGx/bo/wTREbRFVPAk6BwmxmQD//DCGi?=
 =?us-ascii?Q?IlnGE+hKiq4Pk0+CTTgSONaERcoRNWr9Xx9YO2hkATICQH3ytV0OEKZKU5PU?=
 =?us-ascii?Q?Cn+XmTWq9chWf1MnFkBIbsP51EU6dOP+ub8sI2S/PtkAxYKaWYp9EW5He4SZ?=
 =?us-ascii?Q?PigpwqZhrSH+lDCfsCQCxOIMY+AH4YT4A+gMU43Xtw80duOrLcWXJfFkzwWY?=
 =?us-ascii?Q?AGkjP3R0We9DifkTZBYB5Bl8lBr//b/ujWO+nqYJ505heSNff6dZLbo9Hh/z?=
 =?us-ascii?Q?wLipefbHMK//Z2Wb/F8IzhdvbVheu7yRfWh8SKjJ2Cv3Jzi4juTQPWQkTIs1?=
 =?us-ascii?Q?KpVdrY8D+ZAlBKPVnaMLjm/lx76W7q+riXZO+GE71/jArtvGRqTvOt6byTAe?=
 =?us-ascii?Q?qr/buMlzy2EBViY7o9vJZWFu0/PznbuwRGc63PApFmL3/HjMglGyl61dMMom?=
 =?us-ascii?Q?Hsz8KSoF/dv2TnpvidA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 07:19:27.2512 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14b6fa03-07b7-4c6f-31fd-08de4dbd1794
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4408
Received-SPF: permerror client-ip=2a01:111:f403:c107::9;
 envelope-from=Honglei1.Huang@amd.com;
 helo=PH7PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


