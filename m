Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12ED3606A326
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 08:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=TJOXYZo7
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPFMF-0002iN-Mc; Fri, 06 Nov 2026 03:31:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1xPFM5-0002hv-N5
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 03:31:26 -0500
Received: from mail-centralusazlp170110009.outbound.protection.outlook.com
 ([2a01:111:f403:c111::9] helo=DM5PR21CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1xPFM4-0008PY-1d
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 03:31:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PgmiwUmoXqanHkHUcnCG5WD6M7FojIJqAbeUrvCxA3JMBjzuh0eG/3qbho4K7zsGcFem1Lz7vauyL9mqwVDnCCa2/qdCxd6ZzJVUTHB5OVnyKFqlgoVlEdCRJQaJLx30yQZjakqxMCAsdcL0QlU6/xDV8t9BH6N3cbGHIjUQSQYMBfKWBDnPr0q39hs2JXha4Unwg9DvpYvBqDAoioHPwOWpQPdpjGSFrn7BugrGWh1GcN6ovPv+w7wFsG9p/Mlx8U8qYFoRZMdZ6+xlta0rzObn5ENvbHtf4bjs0gPcSPAwL3R5NgYeSMu3dlOf6weEp0ICCLfjjpWDAM3fUu6OrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gpHcolD1dsow4jY2u/bnDb2WiBiKrIENucXRKo9TYEs=;
 b=Y8adXgBc6rlNQBlU5fMhU3HqNn65UcBkvIkVpjzn9VbaLSsOEnLtQ5RQHjJOJTa7uwE/DtGjNRbPUKciLGZkU2knO67fU99IhNphjAlnQHAGrs/IzucTjod2pzuN+D+jy+8LbjWTRLbY6Gp53wJ2h2a11ej/iBVXEomlGS7WbxX8cGiJQOprNUTmUo1EhBhFp8WaMsl9e5hdW8Gn3a9AzG461UZdeGE5lMA9soJjzqf6eFnoPQ4JEoRR7oKjdm0IstRuYnytHxpggtI7PE5h/oWWsZo1mk8Y37OAIcLYadBhFgJhKyQYHLI3rRNSDLCklZne+GbWGygzca4QrySCuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gpHcolD1dsow4jY2u/bnDb2WiBiKrIENucXRKo9TYEs=;
 b=TJOXYZo70qCiH7J7ZF8oWkzpcylh6FHZxXyQFAo0wc1D13qY9rtghLyzjw/LpjQaJplW0gAihmYaEshpRfFESEXf7WVG/fnFV07v86ktXzy1CGEL/C6TustLdReR3bDi8uSje9qZNabuHhXg3u/1zjgqsX2WPp3WIE2RsbNMVRQ=
Received: from MW4PR02CA0016.namprd02.prod.outlook.com (2603:10b6:303:16d::22)
 by SJ0PR12MB6990.namprd12.prod.outlook.com (2603:10b6:a03:449::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 08:27:40 +0000
Received: from SJ1PEPF000037A6.namprd04.prod.outlook.com
 (2603:10b6:303:16d:cafe::87) by MW4PR02CA0016.outlook.office365.com
 (2603:10b6:303:16d::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Fri, 6
 Nov 2026 08:27:39 +0000
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
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 08:27:39 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 6 Nov
 2026 02:27:36 -0600
From: Honglei Huang <honghuan@amd.com>
To: <alex.bennee@linaro.org>, <dmitry.osipenko@collabora.com>,
 <odaki@rsg.ci.i.u-tokyo.ac.jp>, <Ray.Huang@amd.com>
CC: <mst@redhat.com>, <cohuck@redhat.com>, <pbonzini@redhat.com>,
 <qemu-devel@nongnu.org>, <honghuan@amd.com>
Subject: [RFC PATCH v7 4/5] virtio-gpu: add readonly blob definitions to Linux
 headers
Date: Fri, 6 Nov 2026 16:27:10 +0800
Message-ID: <20261106082711.813336-5-honghuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037A6:EE_|SJ0PR12MB6990:EE_
X-MS-Office365-Filtering-Correlation-Id: 15de9427-b44a-4f94-5c20-08df3bdfd1b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|22082099003|18002099003|10067099003|56012099006|11063799006|261026121527099003|261102123227099003|261028144727099003|261026140227099003|261009223027099003|261021121427099003|261009221227099003|261022105027099003;
X-Microsoft-Antispam-Message-Info: cXbeW00XUEurbUXQsBz/d769HVFazRbR4KnVkyxMs/mZ3q1NycY5faeQdHblDeck26bPlqOEXyQkMBl3orbZNmPMQWEDhxLbDOfLZQJLBWR//FsY3WlFx9CttBWoKDTxi4qfEqhLyhYCSeD41r9sNl2FPE8alUgROGpq3o5ZhdhGR0QsxWslQ0Dt7JK9ypN6o1h/GPSsHJ+i/ZGX54H3FnMcyFLY90UrZ8x/IW/P4XGC3+7g18hXHpJbOhxqXZ3Q2NLgkEVFz978aTFX838zUm8QKv0FipEcpHPVKYD1ro/yaTDTuaBZGESuF9yTE9c0I7z5B4WNgDCPeHVlGpo7lXdqJ0GJniF/672pVCEag9Co0X2Pa6U8VABc/WqT6a/YQMTa/Drz+218VeU6g/qcXt0o6XEOg40RMQHjCR9PvhMz3+TcjPAL40yOVNb/Y62zyBcWj9PPdYdPwC+hTJ7RM5tT5s09riLl1xNa5DWoVlFpP6uxxqNS8ZlFtCs8PZGD2alnjS6suKJG8DRJyk9mFGam/h7hfvb3YNy+AdRR0Nn4bbye3zdi6ao0EVQtFs/CWPO1C/+0hwgBAJkPwgz6fl8UVJ6zqPBPEcKAnxyiMPRA0Gn6LEVFkpYT3SK141vyCbkV3G6xRnxvQ7H8vwVY7Hhh1FXZErlE07cjitj1w2OcsMTe/WS8RKqHrMiNYgobZmxyNofqghr8vSgVU3rCTw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006)(261026121527099003)(261102123227099003)(261028144727099003)(261026140227099003)(261009223027099003)(261021121427099003)(261009221227099003)(261022105027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZONXTwyO2fVDr8lDha50eXJE/m5f1qjB9OoCmHLnED5kyn9jliFMD9qbywzbWhBcqUFsye+6CtvgVy1KyfC3xq5jXkP0uEW+xLGObLvN/URCqTiOC0ZgOFmrJMGbp7ey42aCHIS29C5p9rQSujD7ci40WM0VwlYXzmQ+JjOSRbot2r1VFGRgr4xscj6u+pURfEU9dKS6FGZ7e9QyvZdpJMKUlRa0v/MfgoZ4nhbvGc0Gl3VmE/rePsaETXhhI+3s9KlwdYXi17Oh8JG5lJbFlSnEDVwMiNaRPybTTTQPus/ZEkzXia0khaIY4YGjiSn6VvSwkTX6oZeCtDs+QhiCrSD3NwqZfvaFQ6sxXLfFMaHYho7oYCoOQLcE2W8jt2vy8OiVbhRPwgYPR5sFhSFyHFQfgsI5kmT2msv6GqbK9eRU2V7EoFUU9jI6cBXb5krI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 08:27:39.0690 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15de9427-b44a-4f94-5c20-08df3bdfd1b5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000037A6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6990
Received-SPF: pass client-ip=2a01:111:f403:c111::9;
 envelope-from=Honglei1.Huang@amd.com;
 helo=DM5PR21CU001.outbound.protection.outlook.com
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

Add VIRTIO_GPU_F_BLOB_READONLY and VIRTIO_GPU_BLOB_FLAG_USE_READONLY
to the imported virtio-gpu header.

Mirror the kernel UAPI definitions needed by readonly blob support.
This is a targeted header update, not a full Linux header resync.

Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 include/standard-headers/linux/virtio_gpu.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/standard-headers/linux/virtio_gpu.h b/include/standard-headers/linux/virtio_gpu.h
index 976bd225875..7a91181287e 100644
--- a/include/standard-headers/linux/virtio_gpu.h
+++ b/include/standard-headers/linux/virtio_gpu.h
@@ -72,6 +72,7 @@
  * must be aligned to that value.
  */
 #define VIRTIO_GPU_F_BLOB_ALIGNMENT      5
+#define VIRTIO_GPU_F_BLOB_READONLY       6
 
 enum virtio_gpu_ctrl_type {
 	VIRTIO_GPU_UNDEFINED = 0,
@@ -415,6 +416,7 @@ struct virtio_gpu_resource_create_blob {
 #define VIRTIO_GPU_BLOB_FLAG_USE_MAPPABLE     0x0001
 #define VIRTIO_GPU_BLOB_FLAG_USE_SHAREABLE    0x0002
 #define VIRTIO_GPU_BLOB_FLAG_USE_CROSS_DEVICE 0x0004
+#define VIRTIO_GPU_BLOB_FLAG_USE_READONLY     0x0008
 	/* zero is invalid blob mem */
 	uint32_t blob_mem;
 	uint32_t blob_flags;
-- 
2.34.1


