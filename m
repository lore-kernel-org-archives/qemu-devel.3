Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36A26CFA469
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Nov 2025 02:48:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMHBX-0003N4-5B; Thu, 20 Nov 2025 21:47:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1vMHBU-0003Ll-0l
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 21:47:40 -0500
Received: from mail-eastusazlp17011000f.outbound.protection.outlook.com
 ([2a01:111:f403:c100::f] helo=BL2PR02CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1vMHBS-0006IZ-7C
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 21:47:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=omhLHXIiMQe5bMFQtjCoSVzhZ2X3KtbNXRS9c38CgPJw3iotYHY43icDL7NA34CsIV2fI3H5qmpN2tNWEbvUMyz95GcikUpLwNcSSLjfLDOqv35snXzV8rP/wqNRG6D0SZKrKQcYgIDjMNUD7O6ykwh+bh38qiol/G5idE0kwdgvxmGmCqEIoHp1Qc6zHpGQHDcVKlsWbmngQqBHNYN8F9UIa8xNxFtNVEXsD6bmXmL71cqcid3ug6KA6pZEpA39NwnseA4sMgDvKbRs2TiPrQ2FGspPvH45H50NyaQuc9kg1LmCeOgl/QcUP1M+9wf7eWy1mkuxy/D74SqRUrlemQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5PvWLbkGhF4b3pCvDcCFf4px+MW6AQfawLN7JWaGFlM=;
 b=T5jjkmGe/CdeOjlwxTJKvP84mYbD+rvJVZ8xawIgNr62lptRwLJ//sBXeYje76TGuYjMvs1TmJfVblTZjFuE7criactCEtf0X7VOyXXo7x6NLqC2hrkbDA2vmnb6FmDHCYRkKEZclt6OrC7VNcBFJro9Xu04hhMwB0MgQ6yy1XVEeL5Niplin+j3erWBb6P2GYTRoBumc42spCWlr9jh88EA/fQRI40qZ+oCZB3GoeDRTIWc9TvZu0pVMScBcJJR0IO2AaBdGLsCOG3xD8DmYcVBIhy6LBx94mpFwBlh3Qo/JVcZi68TAHrU5zmFcOYfrtGbpcvur3lhFaQLa16HCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5PvWLbkGhF4b3pCvDcCFf4px+MW6AQfawLN7JWaGFlM=;
 b=aJpBniXMj0MkyVpDqiFODAa3lSyv/rGsoDzxQXrzYyY8aFaIs/M0ZPHVzSpemdYXcAAis1sPRzrGl3YDVsm99HTmsY27BF+hC/yoJSM5gfPIsB81GnY08REw3CtIq7B/G7BFwM5mFyMcF8U+dqvSZs68/Sw/9HX/wRK/m3C56Ss=
Received: from BLAPR03CA0007.namprd03.prod.outlook.com (2603:10b6:208:32b::12)
 by LV2PR12MB5968.namprd12.prod.outlook.com (2603:10b6:408:14f::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Fri, 21 Nov
 2025 02:47:33 +0000
Received: from BL02EPF0002992C.namprd02.prod.outlook.com
 (2603:10b6:208:32b:cafe::25) by BLAPR03CA0007.outlook.office365.com
 (2603:10b6:208:32b::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Fri,
 21 Nov 2025 02:47:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0002992C.mail.protection.outlook.com (10.167.249.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Fri, 21 Nov 2025 02:47:33 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 20 Nov
 2025 18:47:29 -0800
From: Honglei Huang <honghuan@amd.com>
To: <alex.bennee@linaro.org>, <dmitry.osipenko@collabora.com>,
 <odaki@rsg.ci.i.u-tokyo.ac.jp>
CC: <mst@redhat.com>, <cohuck@redhat.com>, <pbonzini@redhat.com>,
 <qemu-devel@nongnu.org>, <Ray.Huang@amd.com>, Honglei Huang
 <honghuan@amd.com>
Subject: [v2 1/3] virtio-gpu: Add support for VIRTIO_GPU_BLOB_FLAG_USE_USERPTR
 flag
Date: Fri, 21 Nov 2025 10:47:03 +0800
Message-ID: <20251121024705.1403042-2-honghuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251121024705.1403042-1-honghuan@amd.com>
References: <20251121024705.1403042-1-honghuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992C:EE_|LV2PR12MB5968:EE_
X-MS-Office365-Filtering-Correlation-Id: ab290739-7476-443d-ea30-08de28a8528f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2lBNGhxrD2y6g/vhtrWYWsEQ47zvDvW+YWUxdNPU6Eb0aTHOdt/N3sZHor3j?=
 =?us-ascii?Q?sygD9EK14se+u9Y5tfHl68/RXImptIS/H/SANUbv85mgJJoia3wCjBCc6Ylb?=
 =?us-ascii?Q?K2bvtgkGnl1UIbWoHFRxV9xUgPZ4vr6+SyBA5wDwdmXYcQmBWoK180rKFvDR?=
 =?us-ascii?Q?hqFghfjfTfpz1dBlcGeKm8XzLxTSoGOzP7Vo2KSmmQh+lnpiiZqaB3Mdyv9y?=
 =?us-ascii?Q?phUrIxaO6kISjmFHNRK+9StpuWHsebbjp9mk6Ps9KMXdxQ5xORSQOJWjgIog?=
 =?us-ascii?Q?c+c/gxdzd0/zOqCfQdL3TXLccmY9MBJXcs808Uf+YFt4lth0MOZLqPz+hufT?=
 =?us-ascii?Q?IQ4Q/kYNCqtxw5cH1nr1acWgUtu2P0Haaedr76VygIEbW4UL9D0eBSjQO4Np?=
 =?us-ascii?Q?qG2XOonSO9/J/9XdN01KeANRSjZSqFWx63pbcgkdBu/FoyrfuscWGu/LuqdO?=
 =?us-ascii?Q?vDYX0qJsFHHWiHGuxwt36CoZW1x9N4+FDDybVsj6TV/oSyw+r/bKK3l+0mD5?=
 =?us-ascii?Q?zW+6bcxvDQRvy611SzckGL3hbG6AcXpBt4T+ZHTCKcHhLMD0IoevpVYw9PTW?=
 =?us-ascii?Q?ajHDA6lrA9Uavl0Mb3mk9gmmaiWo2u74B4HNISz+P/Y7WTz9DVV4YmACLXGi?=
 =?us-ascii?Q?sbFsIsVIV72s+fZKoQKiuLbBgz1CklY1ZZMyAn3YxqQmEJL7dtHnLsKiQyBE?=
 =?us-ascii?Q?Zn1p3oECj2wW1WBoExHvMcMU5Bx8JWMGuLZValPzXl3DZUHGtLPQr9r08ZMr?=
 =?us-ascii?Q?R/sRXE4Nw5VngNgSMvEmoI04nACdArNRK4hHc+ey9XD+O4p9ZOBDFKPgLlwG?=
 =?us-ascii?Q?+t7QfZ6/FJzU1FjbwZdE+P17gLZIQEnlN8mE43ZcUvokbIq7uqiQxQz302pQ?=
 =?us-ascii?Q?7Aer848p7xtxZxKG9fHBJ0NYVoTcqzeLkxXkFmohf2Lj5ArZjMHNUjqSNi69?=
 =?us-ascii?Q?LxuDu84cj8Qmdm8Z4H2+7kqWDLp0jq39kLqXqmjmaPpZ8vln4aAdTDZ4DTWc?=
 =?us-ascii?Q?1R1k/0qZyGmQ64w1YtnH8ljXeu/zvFOHI9n6wAEHb6ScHrtGyw2oflTqVZR0?=
 =?us-ascii?Q?0XFT0oKnutnibNTKePgr+ISZ5h9NV2FSPxO0KVYNBlhoXNjaq2wNL1oHHqCU?=
 =?us-ascii?Q?HHEOHi0HP+YaxUyIXdLPnSu202ixJeCFQvqSC4XP86fqRFveZtfgcXRQI+ry?=
 =?us-ascii?Q?wRf96bIu7Qw3wH9X57OlEid/Mx8jU7Xi2mwq6cqkL/gEs403e+HO8KMeMT2F?=
 =?us-ascii?Q?PvZTBoQqe1997DhCVUF6pfNjeWuNWN6GfuW2AVd4QqW/g5mKUU6MIeuSddhE?=
 =?us-ascii?Q?9mwOLZr0lcQChxb0I79pnN7RJ32bxAj1F3kPmM/UUvF+3Jp8vOjcpiCEpJ0N?=
 =?us-ascii?Q?2umrmRd0GqjH9RZ46LzPcpZwz6/NZnD30QYt32tzk5JBDcHS1NJjKymkoWNF?=
 =?us-ascii?Q?/VUeuHk0vRBrlOQNug2xl9X6SLx/yrdwAsrbEy5T4QiuPPCeOfNzUbanjvCU?=
 =?us-ascii?Q?CjRHbpGOkw4OXMf+bF5k3UY46fQI2k1swB7fkFXpMhRMTaYB1XMNK2DwdxVE?=
 =?us-ascii?Q?bD4Xsyi2zKRA2yBL8qE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 02:47:33.7548 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab290739-7476-443d-ea30-08de28a8528f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5968
Received-SPF: permerror client-ip=2a01:111:f403:c100::f;
 envelope-from=Honglei1.Huang@amd.com;
 helo=BL2PR02CU003.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add support for the USE_USERPTR blob flag in virtio-gpu to enable
user pointer mapping for blob resources. This allows guest applications
to use user-allocated memory for GPU resources more efficiently.

Changes include:
- Add VIRTIO_GPU_BLOB_FLAG_USE_USERPTR flag definition
- Enhance blob resource creation to handle userptr flag properly
- Remove arbitrary nr_entries limit (16384) in mapping creation
- Add conditional handling for userptr vs regular blob mapping
- Support guest_blob_mapped parameter for virgl renderer
- Fix value check issue in virtio-gpu

This enables more flexible memory management between guest and host
for GPU virtualization scenarios.

Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 hw/display/virtio-gpu-virgl.c               | 2 +-
 hw/display/virtio-gpu.c                     | 7 -------
 include/standard-headers/linux/virtio_gpu.h | 1 +
 3 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index 07f6355ad6..c927275c79 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -705,7 +705,7 @@ static void virgl_cmd_resource_create_blob(VirtIOGPU *g,
         ret = virtio_gpu_create_mapping_iov(g, cblob.nr_entries, sizeof(cblob),
                                             cmd, &res->base.addrs,
                                             &res->base.iov, &res->base.iov_cnt);
-        if (!ret) {
+        if (ret != 0) {
             cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
             return;
         }
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 43e88a4daf..956dc811fa 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -808,13 +808,6 @@ int virtio_gpu_create_mapping_iov(VirtIOGPU *g,
     size_t esize, s;
     int e, v;
 
-    if (nr_entries > 16384) {
-        qemu_log_mask(LOG_GUEST_ERROR,
-                      "%s: nr_entries is too big (%d > 16384)\n",
-                      __func__, nr_entries);
-        return -1;
-    }
-
     esize = sizeof(*ents) * nr_entries;
     ents = g_malloc(esize);
     s = iov_to_buf(cmd->elem.out_sg, cmd->elem.out_num,
diff --git a/include/standard-headers/linux/virtio_gpu.h b/include/standard-headers/linux/virtio_gpu.h
index 00cd3f04af..b85e781a2d 100644
--- a/include/standard-headers/linux/virtio_gpu.h
+++ b/include/standard-headers/linux/virtio_gpu.h
@@ -405,6 +405,7 @@ struct virtio_gpu_resource_create_blob {
 #define VIRTIO_GPU_BLOB_FLAG_USE_MAPPABLE     0x0001
 #define VIRTIO_GPU_BLOB_FLAG_USE_SHAREABLE    0x0002
 #define VIRTIO_GPU_BLOB_FLAG_USE_CROSS_DEVICE 0x0004
+#define VIRTIO_GPU_BLOB_FLAG_USE_USERPTR      0x0008
 	/* zero is invalid blob mem */
 	uint32_t blob_mem;
 	uint32_t blob_flags;
-- 
2.34.1


