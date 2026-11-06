Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6B6606D803
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 08:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=S9QnEwiD
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPFIg-0000jF-WD; Fri, 06 Nov 2026 03:27:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1xPFIY-0000h4-BZ
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 03:27:47 -0500
Received: from mail-westusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c001::5] helo=BYAPR05CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1xPFIV-0007xZ-Ap
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 03:27:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HVegY1PiSV5dE1TFy7S1oA9YCeiwJfisHYo0rIDvlNiPnTjFHUJK8aS/NQcksR3StxaWXCx+xY1PVsy8unSW3L0Ldq+mlbshZ53ZpDMNEjnxu/LkdBh7x7YHNZqzyG5usvJgo6mN+yKrMucf+qmibVizIUDGPd451tS5k/AJDc7MOphW2jvc7FHyUgpQkagPWXAb8Gbklt73eOEuH6ycU2gwvUnyaH9++kwBVkbSh9TqYpQAMWbPvp4UGkwJY4xRUNqr4DFuJFVS7BxrSTpUgTUG1XmXxWlap3eL509QJEw98J9SGpHCQCm/HDuBNHh09RMt3PIGCe8k+H6oWlrtyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gpt0cw0/QFuMty5kbbqPwgT5Aaq0YcJ+lvlzEDd5V6Y=;
 b=Ih+G8Vn9v9uZiM9ZvjDF4afV3R4pFivC5Cv0fS5D7mO5X3PR2Doslho/LV8/f9nBiZol0lba2sK1nD13mWakdl1GFY6+LGUapMRGr/Wy/KKdNuuAtb4nz446VoLALSBIaW+vsoIb4RfbSTA1KC8MfU+IgCrP6MZUUUDizUrOIbG4VM8S1kz7ZOeMWF2R3y/4WMWwbf1PPHKQSvPvVXMvCfRAccHxmwJ3oTGNeax86rPyHz8l9xnFGYhOYzbP14kYYE8gnwbFiEU5ksbDeAZvvAuCGmS2zbzbp1sqw1XWkpVRpudf+AQJFfKChCYfEUpA5eeZAxqiOWfdHJSVp80iuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gpt0cw0/QFuMty5kbbqPwgT5Aaq0YcJ+lvlzEDd5V6Y=;
 b=S9QnEwiDht9aINn6pj/jKvYUaq/DAToGzZOsD6wAPNP1NonnvwFcdcQE2y811dvSm+267kECcz+5yELyQqpJLp9LDEjTsQwGFqeHqFI+h4Ti60UghPgcDTlYcawNzbyVlhG3DwVbUr2AsURFR5KoaZfR9NSQFiRXkej0U7vRyR8=
Received: from PH5P220CA0001.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:34a::8)
 by DS0PR12MB7656.namprd12.prod.outlook.com (2603:10b6:8:11f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Fri, 6 Nov
 2026 08:27:34 +0000
Received: from SJ1PEPF000037A7.namprd04.prod.outlook.com
 (2603:10b6:510:34a:cafe::6c) by PH5P220CA0001.outlook.office365.com
 (2603:10b6:510:34a::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Fri, 6
 Nov 2026 08:27:34 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000037A7.mail.protection.outlook.com (10.167.244.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 08:27:33 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 6 Nov
 2026 02:27:31 -0600
From: Honglei Huang <honghuan@amd.com>
To: <alex.bennee@linaro.org>, <dmitry.osipenko@collabora.com>,
 <odaki@rsg.ci.i.u-tokyo.ac.jp>, <Ray.Huang@amd.com>
CC: <mst@redhat.com>, <cohuck@redhat.com>, <pbonzini@redhat.com>,
 <qemu-devel@nongnu.org>, <honghuan@amd.com>
Subject: [RFC PATCH v7 2/5] virtio-gpu: Add ROCm capability support
Date: Fri, 6 Nov 2026 16:27:08 +0800
Message-ID: <20261106082711.813336-3-honghuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261106082711.813336-1-honghuan@amd.com>
References: <20261106082711.813336-1-honghuan@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037A7:EE_|DS0PR12MB7656:EE_
X-MS-Office365-Filtering-Correlation-Id: a1241d25-8df6-42ed-7254-08df3bdfceac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|82310400026|36860700016|261009223027099003|261021121427099003|11063799006|56012099006|5023799004|10067099003|18002099003|261102123227099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: SnZ2adN8acFCwsWs0/Hqz8k7nbBo4jiJeQXBeG8Gi/ytqT/FVutKU2LKXLIodd9hVEpWQ5YSLxohuei9ULm7rBXHH6sSf33hLzcRNc1AglKsQ5OaDZfhheIV26IQU5h3DZp7ylO67/E1miXsCyc+eORUNC+CRU41DaJNL1APPrSHkAeqOgHtxgWiLnu8Cm+TaylbVhaBusF1/M1763wuDpHbkf+Dp7qTRxrOwI3y41M5+eXDvOs7NfgnCBfGTCOyNQsO/JmdeviwDnH3xUXENOmWAbg6LEFjdPEUsWCXIGUgKremo7oxlbOuD6Er5Cwxy4P1cOrAXUytLfi3T/KKMTOfh7jgoCjdnBE1xAqvSDPUeEalZytHU0V91MdmQI4XU9ZHWyUQq5m0x+EDQJZs24S/LpWEhe+8uLyuDGxSjAhhlWxTAyyVitSEYqQouA6XXfs4ydi8wpbSLcpGXIjjnRhCnjbB/dBLKt895mbtQv3zNZ1X5s4Auc1LmGUVGq+5lz2kktPSSImzlTzOGdLPplxmhJdnVp+uL7FlinnnTxuAeKw7i0Zt/yduRoYSFBx0SDh7gHErDrilePzYGLCcz6AOJB/toN8Jdfadv4Vw7xv/FoHEwF7946ZGZntWc/lzRvu+4KBfUFrMFV7NIc+d9S4YOP+QMqu6snS4syuEVZBB8V+C/laA6nVHp9Anm2sMaHM5VUsqC6HVxMozsfLeIg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(82310400026)(36860700016)(261009223027099003)(261021121427099003)(11063799006)(56012099006)(5023799004)(10067099003)(18002099003)(261102123227099003)(22082099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: KII/ZPilrfiG6l5SUoGK4wDl//P5RA0zhgxiR8ZPFPbuNd9Yx9+TgSiUmpo4F3c4R4kFTDI00OfMXi2F2zJ3lqvrLQEgWZVqkU15MnIP7EFrSh6FTBGP//tjZyXGu1OWe89IUyQxpyiY/3SpYVVYZ3pWOJz8AE+FwepnarF/ghKrt8zEmXTI6Z2Xm3Xwg+7z7eQ3zjLf+5nuwpEQ92jVAKrcjXRK9Itq+iEwoLbhX6TmFQjm2POD1XwucdrsVKNcMG6XslcHiU1flKV0hq53WgAKsR2XYBA5hhGZHkbhuTpq7xWXNzwCjhS5br85VdhCBeMxYRmUn6+ng+e9SPeobN8TxJOuXfqyGnzRyE1sRqdkBX15YBzYH4FCvQLi3ym0ZAIvWJIS2GzGNpcZ2tfIJXDvy5I62XZT0pwZppFFwkOc18JSP4jIeItNo3U2+5B2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 08:27:33.9782 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1241d25-8df6-42ed-7254-08df3bdfceac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000037A7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7656
Received-SPF: pass client-ip=2a01:111:f403:c001::5;
 envelope-from=Honglei1.Huang@amd.com;
 helo=BYAPR05CU005.outbound.protection.outlook.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add support for ROCm (Radeon Open Compute) capability in virtio-gpu.
This enables GPU compute workloads using AMD's ROCm platform through the
virtio-gpu interface.

Changes include:
- Add "rocm" property to virtio-gpu-gl device
- Define VIRTIO_GPU_FLAG_ROCM_ENABLED flag
- Enable VIRGL_RENDERER_USE_ROCM flag when ROCm is enabled
- Add virtio_gpu_rocm_enabled() helper macro

This allows guests to detect and utilize ROCm capabilities through the
virtio-gpu device when the feature is enabled.

Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 hw/display/virtio-gpu-gl.c     |  2 ++
 hw/display/virtio-gpu-virgl.c  | 17 +++++++++++++++++
 include/hw/virtio/virtio-gpu.h |  3 +++
 3 files changed, 22 insertions(+)

diff --git a/hw/display/virtio-gpu-gl.c b/hw/display/virtio-gpu-gl.c
index 2b7a41c4664..d1f11a5bb92 100644
--- a/hw/display/virtio-gpu-gl.c
+++ b/hw/display/virtio-gpu-gl.c
@@ -170,6 +170,8 @@ static const Property virtio_gpu_gl_properties[] = {
                     VIRTIO_GPU_FLAG_VENUS_ENABLED, false),
     DEFINE_PROP_BIT("drm_native_context", VirtIOGPU, parent_obj.conf.flags,
                     VIRTIO_GPU_FLAG_DRM_ENABLED, false),
+    DEFINE_PROP_BIT("rocm", VirtIOGPU, parent_obj.conf.flags,
+                    VIRTIO_GPU_FLAG_ROCM_ENABLED, false),
 };
 
 static void virtio_gpu_gl_device_unrealize(DeviceState *qdev)
diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index f71f287d948..f3512337d05 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -1514,6 +1514,14 @@ static int virtio_gpu_virgl_init(VirtIOGPU *g)
             return -EINVAL;
         }
     }
+    if (virtio_gpu_rocm_enabled(g->parent_obj.conf)) {
+#ifdef VIRGL_RENDERER_USE_ROCM
+        flags |= VIRGL_RENDERER_USE_ROCM;
+#else
+        error_report("rocm requires a ROCm-enabled virglrenderer");
+        return -EINVAL;
+#endif
+    }
 #endif
 
     ret = virgl_renderer_init(g, flags, &virtio_gpu_3d_cbs);
@@ -1615,5 +1623,14 @@ GArray *virtio_gpu_virgl_get_capsets(VirtIOGPU *g)
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
index 631dfc63a4d..3c5119ce0e4 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -112,6 +112,7 @@ enum virtio_gpu_base_conf_flags {
     VIRTIO_GPU_FLAG_VENUS_ENABLED,
     VIRTIO_GPU_FLAG_RESOURCE_UUID_ENABLED,
     VIRTIO_GPU_FLAG_DRM_ENABLED,
+    VIRTIO_GPU_FLAG_ROCM_ENABLED,
 };
 
 #define virtio_gpu_virgl_enabled(_cfg) \
@@ -136,6 +137,8 @@ enum virtio_gpu_base_conf_flags {
     (_cfg.flags & (1 << VIRTIO_GPU_FLAG_VENUS_ENABLED))
 #define virtio_gpu_drm_enabled(_cfg) \
     (_cfg.flags & (1 << VIRTIO_GPU_FLAG_DRM_ENABLED))
+#define virtio_gpu_rocm_enabled(_cfg) \
+    (_cfg.flags & (1 << VIRTIO_GPU_FLAG_ROCM_ENABLED))
 
 struct virtio_gpu_base_conf {
     uint32_t max_outputs;
-- 
2.34.1


