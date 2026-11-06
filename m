Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFEA606D805
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 08:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=uHOH1xDF
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPFIy-0000oD-Nr; Fri, 06 Nov 2026 03:28:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1xPFIb-0000hj-1g
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 03:27:49 -0500
Received: from mail-westcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c112::7] helo=CY3PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1xPFIZ-0007xp-3W
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 03:27:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aC0JRn78WJ33Uawq9usOghrWfvd1R/xyV2eeIABJvrDIssEb5NCBV/8h6i/fm8wNgiQ7vqvLO10S0zFcgGsAHOJSJHXskhyogOxmOXKGugFrbT5yiflSvWXRzGPSFniaxxjFMiVEDQ2quz18cGF7E/HsuZnRvq6f78ILMkq1RcNmhgZT7GSC+N6ObpXkefJ0RbRVKPi079sOa05+ooF/hUH6gGhaBJ+tenw2JYDXKj6fcVBoTeOXuvz5TxssJHQ1Da6bOApFeThHQaD0XT3jTffMXpsMNAhSSzJyxTWB6vA4oGc5fO36zAQDQuJ9BmQpTr3KSWSbjYVni11etBp8Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HFUFJXPjCgDYuSeVg40/p9PZN6wt4J3C0IFZQyrIeIQ=;
 b=yBSUOcFUoagWq+f17G6is+vdtA31kKz+RnmjQy8j99bXxXaAmuBZkA1J5D+NwntdkluM1UGR+dgfVT2Y5k/NBo+4f3eAoATAESvMc8oPRuwhtjqCkJHjuuNoHAzVfOx1RRJkthEWIglFpT266WhEIh4Dsgw0Wbqfz9Z72VWzeGKDLiP/woLyYNvtQxY+qOh93n/tfeYJHoDGn6TJFvRhk4/je8/FZawXR2zesXS4ImnNVceh/uT7orJyCNBH57QlNN4J9Nmkrlso7JpVKEMI5513xuY+u57QkqW0LKFLtjLVOZf8spEU7rqxn+cqYONV5jiYdx7Ukv78dtODrvhV0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HFUFJXPjCgDYuSeVg40/p9PZN6wt4J3C0IFZQyrIeIQ=;
 b=uHOH1xDFgTprhAsEQFg017ZCPWWIkrCl1aUCa0s3JNVY8I0UiuD3q3lWWcSes3IYsCBfEp2hKw0lg8ZcC1hpS4JrOFCtPJYCDgI2R2c4KR0iPBtvDWnnYP+SKPCkLgA3LL/75+mIgI56wd106XdxDtGTRh5kyAar5+uy9VO8UUg=
Received: from MW4PR02CA0007.namprd02.prod.outlook.com (2603:10b6:303:16d::33)
 by PH7PR12MB5593.namprd12.prod.outlook.com (2603:10b6:510:133::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Fri, 6 Nov
 2026 08:27:42 +0000
Received: from SJ1PEPF000037A6.namprd04.prod.outlook.com
 (2603:10b6:303:16d:cafe::a7) by MW4PR02CA0007.outlook.office365.com
 (2603:10b6:303:16d::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Fri, 6
 Nov 2026 08:27:41 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000037A6.mail.protection.outlook.com (10.167.244.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 08:27:41 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 6 Nov
 2026 02:27:38 -0600
From: Honglei Huang <honghuan@amd.com>
To: <alex.bennee@linaro.org>, <dmitry.osipenko@collabora.com>,
 <odaki@rsg.ci.i.u-tokyo.ac.jp>, <Ray.Huang@amd.com>
CC: <mst@redhat.com>, <cohuck@redhat.com>, <pbonzini@redhat.com>,
 <qemu-devel@nongnu.org>, <honghuan@amd.com>
Subject: [RFC PATCH v7 5/5] virtio-gpu: advertise readonly blobs for ROCm
Date: Fri, 6 Nov 2026 16:27:11 +0800
Message-ID: <20261106082711.813336-6-honghuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037A6:EE_|PH7PR12MB5593:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d804a37-5d85-445e-6c4a-08df3bdfd338
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|23010399003|261026121527099003|22082099003|18002099003|3023799007|10067099003|261102123227099003|11063799006|261028144727099003|261026140227099003|5023799004|261022105027099003|261021121427099003|56012099006|261009223027099003;
X-Microsoft-Antispam-Message-Info: MowyUdr42JKU2C1i1XrwQbuPCDaHmn/P3eWI/8MQbbroqxnOmVC8b1YG5Ky8l5jrpC63LFo5ll6pS/WG8vNBzclYIcgL9eDvZCbiwGwqFDUuRFcg7eH64BBJVcMHddmVXUZai+f0AV1GJByVNibwU5ARdIt8nL15tmru7XAgAiqtnFPu6w275ifmT15fdz9VEMLxXW10asYpYnR5grlkJUbtE4rjI0VMqvbNXLMWNup1Mc/KnYLv4rMFFH9hZ8nkv1RWpGqMUw9txeza+3OKGUK7kJ0OWmZ7tMWHulG5xECxH2sV0exznTwpU4LXqqUKQH1a5YTcE7R+/7tXd2Awd96HYR6e/ULL8yT87k9jd50YuSydnYVxXUBGnYpKdFHu2XCF6FrbicFdik+RfnBpCqNR/OoKxY2fsMKNvdjmz5iPw7DdkZdZupko+0oSSJ7/ma7aLox9EjV0CHInbVB24waUJrv7n2FKSMJEyf3rdtdS9mgsade7iKQzeEplroTOPk7mFa96tRlwnG9tOjIHjE1r+5GX6Q0Ir6PRN65MHMLDso6BYiWZ645y0ZLszw2qVz/KFjnRDhUbUsocOeFJ59tDCkbUaYOtWEbYtHjxfevBEKFnkL30CLqdpmy2AfkLNfnzr6IiqCxM/909NrKHTG52ZBuxGdMGOVf/jjCJFTFC6hF1BPf/T9ly7LPmo4lNa8yBsgu3jW8HQRYG5sB9Hg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(23010399003)(261026121527099003)(22082099003)(18002099003)(3023799007)(10067099003)(261102123227099003)(11063799006)(261028144727099003)(261026140227099003)(5023799004)(261022105027099003)(261021121427099003)(56012099006)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DNdJgQTvSZrOJETZzd9MIz1R7vgrtf9zY2RQyQOJ6Z4mkZXwWp35tM8A200w4ev//t9HGCQ1+5FvE0vL4EPPlF4SnvD3CNKjnGjEyFPuiRoGeQ7cDAsWmbBUYXakv3YX3mgtc4PfoBZ73Ns5UnuP7WkSiMOhLlGDNWmrJTEbH5gbzaQ8t6rRlzZ088aXWZt1F8UODCQ6eTN4Lf2iZUQlnmeM637s6AnDxAWCREt3lBlLTv8AmNYoCZnBKID2Equuvruk3ILT5AfwzA5hkUjM+vJQM4RNgzDE6ThqF6TM4AHlSemouYlZGPdt1td/Wys1gfx6dCCQTpRIfkaE8RaQRTZ2nXbwcd3W72nc3fWYQUioydQaFiZWIG5ew91Nj2+1gEsVe5DbA2OSt24zkva4j+MEeXHwP7sg/ZSD/Te5DrCL9f7GX/55KZDYy7D6yeUd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 08:27:41.6068 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d804a37-5d85-445e-6c4a-08df3bdfd338
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000037A6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5593
Received-SPF: pass client-ip=2a01:111:f403:c112::7;
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

Mark readonly blobs available when the ROCm capset is present, and
advertise the feature only for ROCm devices with blob support enabled.
Treat readonly registration support as part of the paired ROCm backend.

Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 hw/display/virtio-gpu-base.c   | 4 ++++
 hw/display/virtio-gpu-virgl.c  | 3 +++
 include/hw/virtio/virtio-gpu.h | 3 +++
 3 files changed, 10 insertions(+)

diff --git a/hw/display/virtio-gpu-base.c b/hw/display/virtio-gpu-base.c
index 270fbaae102..b6333e67c0f 100644
--- a/hw/display/virtio-gpu-base.c
+++ b/hw/display/virtio-gpu-base.c
@@ -269,6 +269,10 @@ virtio_gpu_base_get_features(VirtIODevice *vdev, uint64_t features,
     }
     if (virtio_gpu_blob_enabled(g->conf)) {
         features |= (1 << VIRTIO_GPU_F_RESOURCE_BLOB);
+        if (virtio_gpu_rocm_enabled(g->conf) &&
+            virtio_gpu_blob_readonly_enabled(g->conf)) {
+            features |= (1 << VIRTIO_GPU_F_BLOB_READONLY);
+        }
     }
     if (virtio_gpu_context_init_enabled(g->conf)) {
         features |= (1 << VIRTIO_GPU_F_CONTEXT_INIT);
diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index f3512337d05..87ee7ac57c4 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -1593,6 +1593,7 @@ GArray *virtio_gpu_virgl_get_capsets(VirtIOGPU *g)
     uint32_t capset_max_ver, capset_max_size;
     GArray *capset_ids;
 
+    g->parent_obj.conf.flags &= ~(1 << VIRTIO_GPU_FLAG_BLOB_READONLY_ENABLED);
     capset_ids = g_array_new(false, false, sizeof(uint32_t));
 
     /* VIRGL is always supported. */
@@ -1629,6 +1630,8 @@ GArray *virtio_gpu_virgl_get_capsets(VirtIOGPU *g)
                                    &capset_max_size);
         if (capset_max_size) {
             virtio_gpu_virgl_add_capset(capset_ids, VIRTIO_GPU_CAPSET_ROCM);
+            g->parent_obj.conf.flags |=
+                1 << VIRTIO_GPU_FLAG_BLOB_READONLY_ENABLED;
         }
     }
 
diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index 3c5119ce0e4..dacf70b41a6 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -113,6 +113,7 @@ enum virtio_gpu_base_conf_flags {
     VIRTIO_GPU_FLAG_RESOURCE_UUID_ENABLED,
     VIRTIO_GPU_FLAG_DRM_ENABLED,
     VIRTIO_GPU_FLAG_ROCM_ENABLED,
+    VIRTIO_GPU_FLAG_BLOB_READONLY_ENABLED,
 };
 
 #define virtio_gpu_virgl_enabled(_cfg) \
@@ -139,6 +140,8 @@ enum virtio_gpu_base_conf_flags {
     (_cfg.flags & (1 << VIRTIO_GPU_FLAG_DRM_ENABLED))
 #define virtio_gpu_rocm_enabled(_cfg) \
     (_cfg.flags & (1 << VIRTIO_GPU_FLAG_ROCM_ENABLED))
+#define virtio_gpu_blob_readonly_enabled(_cfg) \
+    (_cfg.flags & (1 << VIRTIO_GPU_FLAG_BLOB_READONLY_ENABLED))
 
 struct virtio_gpu_base_conf {
     uint32_t max_outputs;
-- 
2.34.1


