Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2F2CCD1297
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Nov 2025 14:20:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJBgp-0003v1-FH; Wed, 12 Nov 2025 09:19:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1vJ5gm-0000Wj-G4
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 02:54:48 -0500
Received: from mail-northcentralusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c105::1] helo=CH1PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1vJ5gk-00037O-Ih
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 02:54:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qJG/sJHVZ7TUr7tps1ykxRZ8nRJEmXVM2ODA8eDtLC8lZSR6cksM8mXXj3IDV1zUd+WK/bLMhmXyuC1ObPeREAdfVKZP4PPerX/JvHy9gKAIul7ZXNNjbkk0TfM1LHC+QLDE1mIADoiftOu9bjXHR1vWB9vw6ycgqOJmpJFSzjIcxQC9brl98pOY8kERMjXm7YOzlzXhkoBCTESNumNlZ5YDTnaRhXAIvdQ1o+BdejBvnzpOESEKGXTy+2DF2ICV+3qaNXPfBXKJTERG1xIaNr4J75YvZpgdFMOe3NKlNERnOGcqSCFERY3DXxqC5ww6SojwzzjcTmXa/Aqy4s7hdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iFu4503ISJFeKGv67QIVk9I8pXGL+xv1E4okLu5nYIY=;
 b=EPeVg68VAP+QteUdrsItoKZyMGbGAhY8XE5pelzZ/nqHAMFTv3XJ+2QB10igZ3Jx1P58szcuDCLCcnKQ+Q99k37rgNAoW0PcNZAk0ZTPERropT7IwxpRNcU/ZXXlzf/edy/uFQedhoiE+UH3fSa99OKi3yFmZtNdzUyBPiPKr50hF8rrSMSGpHnjhvSgASgamojBTzt3tBrbm/lw3oodqi06wms52OvepHLsQhUUhpoNA3J3CRDs5O7w/qtoKfcoeo9dRQUpODCR4t1RWzW9GpqJKWhZEVgMm4MRokOnoLyNTHR7hVy/NjZFOdgRlmMtwnNIT7txpmbcZ4gVWwa3Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iFu4503ISJFeKGv67QIVk9I8pXGL+xv1E4okLu5nYIY=;
 b=g2c3I+Mu6i4T5oP/mGYKhREbJYMpN9LrOJ4X8cYIOTJxwZnqm5F+1Zp7a4YzTA+dH/FamDbxQoue4s1djSBwKVrrbaW0DygxgfEfkrXEAduRhQVrkhGQYzCNJHWYIWONYb7ic4YJogYreHy62pVey70Rlv7D/lCKm6p6a3/b31c=
Received: from BYAPR02CA0021.namprd02.prod.outlook.com (2603:10b6:a02:ee::34)
 by DS2PR12MB9637.namprd12.prod.outlook.com (2603:10b6:8:27b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 07:54:41 +0000
Received: from MWH0EPF000A6731.namprd04.prod.outlook.com
 (2603:10b6:a02:ee:cafe::bc) by BYAPR02CA0021.outlook.office365.com
 (2603:10b6:a02:ee::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.15 via Frontend Transport; Wed,
 12 Nov 2025 07:54:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A6731.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 07:54:40 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 11 Nov
 2025 23:54:37 -0800
From: Honglei Huang <honghuan@amd.com>
To: <alex.bennee@linaro.org>, <dmitry.osipenko@collabora.com>,
 <Ray.Huang@amd.com>
CC: <odaki@rsg.ci.i.u-tokyo.ac.jp>, <mst@redhat.com>, <cohuck@redhat.com>,
 <pbonzini@redhat.com>, <qemu-devel@nongnu.org>, Honglei Huang
 <honghuan@amd.com>
Subject: [PATCH 3/3] virtio-gpu: Add VIRTIO_GPU_F_RESOURCE_USERPTR feature
 support
Date: Wed, 12 Nov 2025 15:54:14 +0800
Message-ID: <20251112075414.3719917-4-honghuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251112075414.3719917-1-honghuan@amd.com>
References: <20251112075414.3719917-1-honghuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6731:EE_|DS2PR12MB9637:EE_
X-MS-Office365-Filtering-Correlation-Id: d5d295cb-f665-4dc7-2da7-08de21c0bc3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UZlY0Sr8LxjtwD6rLyg6NHjxTW0gBron0H856hivB7XIXtvL4i3ycWa9QCG+?=
 =?us-ascii?Q?EXhlWsc6ymN40PMjN7P+4TgbccuxPYPR5j3sk/saro+nxH1lu08RD+SQrzKP?=
 =?us-ascii?Q?2GR4fHkEcHKNh3IbRLL6XWjc0msHZrZ+3XiBhLtqE/fCgOeLpeiWueqS2GX7?=
 =?us-ascii?Q?8f+viqoqJyrx+UaXxNL9P8fg3XJWnwQZ8eFicFUFMN8fzeoRC52uH5iSSc22?=
 =?us-ascii?Q?ep/MaNvmwubWzcc4C2qLV/enzRNd3EC1BFRhwKR7bsXqhFK7YqdV1IdYZkw3?=
 =?us-ascii?Q?nPzdhwyA/Xzsk89903S/WFMUFG3zLUTunJ9rFjaU8elqzT/miLI0UrGxIuH9?=
 =?us-ascii?Q?v5B5ZR2CZfUWU0Qy2daRXCTO7HurNnL6G+OZ6JYcHIHknes6mpDWw1BBo5dN?=
 =?us-ascii?Q?lw+xmQ902tRFL8/H9gzcS91wDH52+rDLiw8rHd7Q4xL+YWPtmo6f0Aw0a/Z5?=
 =?us-ascii?Q?4rzMru5FNfAfpF1F7qNrjfeDcHDPT800W0KJ9NSeJwPRCdbYHjv7OuN025hI?=
 =?us-ascii?Q?HyKalMTKk+n4+9uVHOIpYMnCeN9ZCqzf8M/Eju5wchVDaYJJT707tRqVZrIZ?=
 =?us-ascii?Q?JTOvdvHlHX25Yxdck0bB872lyLrNwn9ruh2ZqCEBTPjtQCrEEpVHCfv9mZjH?=
 =?us-ascii?Q?Q1/fjk+WpxldzOXftOVhK+GjvakPBNq/1t392wa81bUgt+z5Nas2IRxsW8gF?=
 =?us-ascii?Q?zvk4xIuvlrLyl6uDOPSq7Hk849oRFJFoq4hy1HZcHUNPMthfPOr+QUzCqBwW?=
 =?us-ascii?Q?iDP6U0dxMKXjZ89ynYPxiWGiiOXlT7MSYaiGj+NMngl/xTShRo8qkKnOM3qK?=
 =?us-ascii?Q?PxYtf2p0K9BQXezdbPDm6NwpBZjKJrdc7nlQugsWRVB8Wmzk9OM8HPuzlqiF?=
 =?us-ascii?Q?ZDkargKeUcJwpg24//Fu1E1BOowm7HfuM98jZiiLH3l2SfAI2qvNFELtV6Oe?=
 =?us-ascii?Q?zwt5c2MCr391i2Iwi6GagS5l2B77auAAf17ph8lXKtuUIgs2m2MJgJCAjncI?=
 =?us-ascii?Q?j9LuIW6DzQnc+GFdyAteg807Slwr6LAVZzvRLkvZkSIgiURhrd5k9jJ6/aEj?=
 =?us-ascii?Q?ZI30fUXl8G6TaEW7UmBbdKAnZ7jUfIcBl7NiNrQiBsHV95F4hlbZaFXBLc91?=
 =?us-ascii?Q?BIdPGWRTiEKzeJHQBDIKOOFVLV+NnUd3By74cXz73XL1mcfyBO630g9gArGQ?=
 =?us-ascii?Q?ryrI1h/SS79HanJR/v8McOvSqwV1zpph2SQGZ2KwshkzyiqnjBFpssOZ9XOH?=
 =?us-ascii?Q?ew5kiPEK3lp+8zNxr1Rr6yDAM264KPpIzWjggfoOsY5AWVpYWoDgmrE5MhV4?=
 =?us-ascii?Q?lDLKPm3iZQFNlmS6tEobHnCyaWUvsTko+TfkrJJBs0eIwDjXvYJ1smJVPmnF?=
 =?us-ascii?Q?E19Vt82DtYQ1HIDAaJL+4PWsCL3y2UUrJYRgSlHFW7hI1zllBhw2ZfrWWaV0?=
 =?us-ascii?Q?XJ5j2BXYlzhGoZaBlNTNxgVZzlC/nZLfm2Re9D3sG2s4CLkuwjfS4RphgQuL?=
 =?us-ascii?Q?ch1Y7YUStp1V2HN0iBEfmcZq/YH3sm7G+uyYfEAVDBXbX90F9AzShoTBIiT6?=
 =?us-ascii?Q?CpZP0eyBlMVAquNe7tc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 07:54:40.7544 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5d295cb-f665-4dc7-2da7-08de21c0bc3f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6731.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9637
Received-SPF: permerror client-ip=2a01:111:f403:c105::1;
 envelope-from=Honglei1.Huang@amd.com;
 helo=CH1PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 12 Nov 2025 09:19:05 -0500
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

This patch introduces support for the VIRTIO_GPU_F_RESOURCE_USERPTR feature
in virtio-gpu implementation:

- Add VIRTIO_GPU_F_RESOURCE_USERPTR feature flag definition
- Implement resource_userptr property as a configurable option
- Add VIRTIO_GPU_FLAG_RESOURCE_USERPTR_ENABLED configuration flag
- Enable feature negotiation when resource_userptr is enabled

Usage:
  -device virtio-gpu-gl,userptr=on

This feature allows virtio-gpu to support user pointer resources,
enhancing memory management capabilities for GPU virtualization
scenarios.

Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 hw/display/virtio-gpu-base.c                | 3 +++
 hw/display/virtio-gpu.c                     | 2 ++
 include/hw/virtio/virtio-gpu.h              | 3 +++
 include/standard-headers/linux/virtio_gpu.h | 2 ++
 4 files changed, 10 insertions(+)

diff --git a/hw/display/virtio-gpu-base.c b/hw/display/virtio-gpu-base.c
index 7269477a1c..f013a4ece6 100644
--- a/hw/display/virtio-gpu-base.c
+++ b/hw/display/virtio-gpu-base.c
@@ -264,6 +264,9 @@ virtio_gpu_base_get_features(VirtIODevice *vdev, uint64_t features,
     if (virtio_gpu_resource_uuid_enabled(g->conf)) {
         features |= (1 << VIRTIO_GPU_F_RESOURCE_UUID);
     }
+    if (virtio_gpu_resource_userptr_enabled(g->conf)) {
+        features |= (1 << VIRTIO_GPU_F_RESOURCE_USERPTR);
+    }
 
     return features;
 }
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 956dc811fa..5f1dc80060 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1685,6 +1685,8 @@ static const Property virtio_gpu_properties[] = {
                      256 * MiB),
     DEFINE_PROP_BIT("blob", VirtIOGPU, parent_obj.conf.flags,
                     VIRTIO_GPU_FLAG_BLOB_ENABLED, false),
+    DEFINE_PROP_BIT("userptr", VirtIOGPU, parent_obj.conf.flags,
+                    VIRTIO_GPU_FLAG_RESOURCE_USERPTR_ENABLED, false),
     DEFINE_PROP_SIZE("hostmem", VirtIOGPU, parent_obj.conf.hostmem, 0),
     DEFINE_PROP_UINT8("x-scanout-vmstate-version", VirtIOGPU, scanout_vmstate_version, 2),
 };
diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index c820247db8..ff68f3c451 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -101,6 +101,7 @@ enum virtio_gpu_base_conf_flags {
     VIRTIO_GPU_FLAG_VENUS_ENABLED,
     VIRTIO_GPU_FLAG_RESOURCE_UUID_ENABLED,
     VIRTIO_GPU_FLAG_HSAKMT_ENABLED,
+    VIRTIO_GPU_FLAG_RESOURCE_USERPTR_ENABLED,
 };
 
 #define virtio_gpu_virgl_enabled(_cfg) \
@@ -125,6 +126,8 @@ enum virtio_gpu_base_conf_flags {
     (_cfg.flags & (1 << VIRTIO_GPU_FLAG_VENUS_ENABLED))
 #define virtio_gpu_hsakmt_enabled(_cfg) \
     (_cfg.flags & (1 << VIRTIO_GPU_FLAG_HSAKMT_ENABLED))
+#define virtio_gpu_resource_userptr_enabled(_cfg) \
+    (_cfg.flags & (1 << VIRTIO_GPU_FLAG_RESOURCE_USERPTR_ENABLED))
 
 struct virtio_gpu_base_conf {
     uint32_t max_outputs;
diff --git a/include/standard-headers/linux/virtio_gpu.h b/include/standard-headers/linux/virtio_gpu.h
index 6c54cb745f..321477598e 100644
--- a/include/standard-headers/linux/virtio_gpu.h
+++ b/include/standard-headers/linux/virtio_gpu.h
@@ -65,6 +65,8 @@
  */
 #define VIRTIO_GPU_F_CONTEXT_INIT        4
 
+#define VIRTIO_GPU_F_RESOURCE_USERPTR    5
+
 enum virtio_gpu_ctrl_type {
 	VIRTIO_GPU_UNDEFINED = 0,
 
-- 
2.34.1


