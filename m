Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A552FD10372
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Nov 2025 02:03:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vO4ro-00012w-H1; Tue, 25 Nov 2025 21:02:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1vO4rl-0000vx-Th
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 21:02:46 -0500
Received: from mail-southcentralusazlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::1] helo=SN4PR2101CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1vO4rj-0002Zd-8F
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 21:02:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s214Ur19/cJTi7a1S9gD+FjWFHMNbqLUkfJ5ZlQ8lcDOpGtfLnJz8LWBkQGDyO6khjM7VTX66qbZKFgHb3PU8O8OnKUT1xtI5f/Eb1X+wMNt49uHUqeK4P3V6ra0HX3tNgQuryVBA7XPwBGntbWFk1SnIS6wHNcoKJfuF75Gf1/ev0ovjOsOS3HoeLULcENZy95UyvkTvCSUMDn13qJJOZ1vYAyLDh8Tkhv3x70Ry3pZHk9bebm4OuFZLcOMUxD/X+MjbOT/tpv9/SXhpehlSzi8/W+FeX0DhKIJIGB7IjE4hOs8i3TLLeNbXrz8jW0FGBvCk7NuSbVFACkY1WSfew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q7Tn0BkLKu+HeQ1JqYp33MBxN2ExdmuRRhuYwCIUWhE=;
 b=HxQv6dJhjXZtwGISRbFziV0u2hWBH2srQsw09PB2ibz5tiAENl0DUFk2GwDbbQ7a5KefVDxhJ4hzOi2nDpNNf47XAQt9CXbmQQ5tEfFmrumwvRdd2IeYAcLVC/Ng+62ZU8rHxavCnKOlD/04tFwXmMlMSE051dv2UZfOCWAxni6j3roT2iDdOqAfPX08rMU7i4iXlm/snrPfU868pCvTzNnjBtorD9HMDqdFMoPBYKfAjxjvxi9idYCXHS9B63+lE30t+J4Gxj06bYf7NC65driPEhw2P31V1wEVN9QM5C9JjnCGOHt9XBK2nlCZjFRqFhdCzOlwt8o3mMAu2EsJWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q7Tn0BkLKu+HeQ1JqYp33MBxN2ExdmuRRhuYwCIUWhE=;
 b=TxxG2+hG1fzOAxB62AMOWMhCeytrSVvwVGzt6iJWJ+RvSwa+Ny9tgZbC8zCRysqOMclNzMdToAQkmZ1yuKGgUW7qz5VXXiaeui40n6vhwhdZif8cgSgmjfE+D8kt7OfH5lTo+pk3NtM+ye4O1/EPHyZIEmdnBisi9dwsZzFcsbY=
Received: from CH5P221CA0008.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1f2::24)
 by SN7PR12MB7953.namprd12.prod.outlook.com (2603:10b6:806:345::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Wed, 26 Nov
 2025 02:02:38 +0000
Received: from CH3PEPF00000009.namprd04.prod.outlook.com
 (2603:10b6:610:1f2:cafe::a5) by CH5P221CA0008.outlook.office365.com
 (2603:10b6:610:1f2::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.12 via Frontend Transport; Wed,
 26 Nov 2025 02:02:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000009.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Wed, 26 Nov 2025 02:02:38 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 25 Nov
 2025 20:02:35 -0600
From: Honglei Huang <honghuan@amd.com>
To: <alex.bennee@linaro.org>, <dmitry.osipenko@collabora.com>,
 <odaki@rsg.ci.i.u-tokyo.ac.jp>, <armbru@redhat.com>
CC: <mst@redhat.com>, <cohuck@redhat.com>, <pbonzini@redhat.com>,
 <qemu-devel@nongnu.org>, <Ray.Huang@amd.com>, Honglei Huang
 <honghuan@amd.com>
Subject: [v6 2/2] virtio-gpu: use consistent error checking for
 virtio_gpu_create_mapping_iov
Date: Wed, 26 Nov 2025 10:02:08 +0800
Message-ID: <20251126020208.2449414-3-honghuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251126020208.2449414-1-honghuan@amd.com>
References: <20251126020208.2449414-1-honghuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000009:EE_|SN7PR12MB7953:EE_
X-MS-Office365-Filtering-Correlation-Id: c1444a66-69f3-4269-3af5-08de2c8fe020
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OPrcKpfAuEMF3TKzWYbkVsp6nIeBu2AffyofH8pMS3k0uozTSMnXmrdgVAha?=
 =?us-ascii?Q?g7T7sUK7trzfauXNyXLUGPSQPaD15rAogQVKO5KsMUAr6wETZXyIQS9GUxEi?=
 =?us-ascii?Q?/r0ahmjCkqEX9Zxqi9ZtmZKMOzJPX8vX08VnqWT/O70NTAYJNzNwR8LEmyE/?=
 =?us-ascii?Q?d7V3A+NeFauMb07FbCIORO/YPTMoJChW9MOUath9xy1X5IGZ8PsZrYtMTki8?=
 =?us-ascii?Q?RtWgLHc0LNB2zik11k98E56HKSbsBYF7p5Vt1+g0gXQHTlOEzVHBzadW5ejO?=
 =?us-ascii?Q?dx1VntUVgmcS2J+dc19aaLyUiAUwTv0U7Rn5e+BivpGzKnc1Qdr4KT4klhRk?=
 =?us-ascii?Q?DNaHxk+MYWb9f+8+982zENYQ06Jr2rHUvrhARzfKbFe3F+VtX5D/mewMDLx6?=
 =?us-ascii?Q?jVjeyb/DCm4ErvJS9HAREhjBPkyYS2SFfRveHHEiMEJNyrwf7XodnKVDtNfo?=
 =?us-ascii?Q?BUs9FjNH3roLzJl8zU/CZFCDiQHxu0Md7L2TxvIZB2GL0P6S+sfD3Z0wTFwl?=
 =?us-ascii?Q?/3o7KDd3MWcu4g3wi50ubdbiM39Ll4aNQl3PYqWq8VGgcrHR2Kkf4ZQzEul2?=
 =?us-ascii?Q?6PW1cub0bLIxXdWNBoJBY4SJ1Dm14YZq5MZmqiyNS6AQvtAAtFOFi415Qd+i?=
 =?us-ascii?Q?Zlml5ZlLnsyhUOBehJyFD/BT1Ky0sP0dWvB4mbqbfrS7or5XVUm1EpfgaP01?=
 =?us-ascii?Q?InKMxk7aqpxGhFUdgjIO2DB2KkQzPadxCUqBBv/dwMkoQPnIjDB6gkeRQVxD?=
 =?us-ascii?Q?v5Xr0/B1FuO9MJ3RV2QFG/RElw1+xBLcGT95Gon6nRmCcuRz+mHS3k7mo3B2?=
 =?us-ascii?Q?4CidOgSdMjhf+a6Rpk3biMOo1XhOnPgJzAGqujl4RxfVJM0Ro19if7YTdQeB?=
 =?us-ascii?Q?fw+tbQWK3WXgFNjtbqspHmVISACw/z5FAlweRgdMv2Hz2xz2zDGTMWtY6dwE?=
 =?us-ascii?Q?IjTjnY6Q8dYm8Z/TBl7lEC/hC03QLXdfWXIWOeJ08gBOprT/6pTkbdwo/MQ2?=
 =?us-ascii?Q?SqU/wOdoW9o6x1ednbY7SbAG/TR+YbdE/MRbKEYbDARllTTIDcbzWp87RnBr?=
 =?us-ascii?Q?WXutWtsRU7U6LW9r8SPpwY9UWoMu+XzeuPdCAe2nOdF2sbU3y1+WZNlAPTqj?=
 =?us-ascii?Q?Q7g+YFQ6fgKPbbf7HL2Ufyw5hKp29vX5thfWO7zpU3+T8kXYC1G2EJegylnN?=
 =?us-ascii?Q?EiA+0/SAAxY+Nwxl6TkpjQ41d2mNUfzEAQKa/K1tvokORbtsObPCvzEmDJiL?=
 =?us-ascii?Q?LgkIuuq+jfFBrcVyrZo/RrWBMWNKrA5ltpXZpOhdm2OB6fJrsPun39atw1VT?=
 =?us-ascii?Q?U2tHwqlRSQN8GhCCejnFUfYZ8jTsQn83Az7VGlefHV/4/L0wE/I5VBfD1GMN?=
 =?us-ascii?Q?tg1KK3l+bUjFJVyfC8eCXaDt6QbphPcUuOv98YrG6toDuSvf5eE5JXUDCm2d?=
 =?us-ascii?Q?j3SNurWkeckk5Lzm19oXJFkd3KkdKQaL8LL18DUS4kUud84uVmksRJflRCmB?=
 =?us-ascii?Q?+DPU1cSTtCyDMqtrZ1ZuxWADwdJ7y+KChtUtowshMkE5PfBgcV2oQ1DmWK0L?=
 =?us-ascii?Q?hLGkk/NDynME5nUqkz0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 02:02:38.4783 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1444a66-69f3-4269-3af5-08de2c8fe020
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000009.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7953
Received-SPF: permerror client-ip=2a01:111:f403:c10d::1;
 envelope-from=Honglei1.Huang@amd.com;
 helo=SN4PR2101CU001.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.152,
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

Unify error checking style for virtio_gpu_create_mapping_iov() across the
codebase to improve consistency and readability.

virtio_gpu_create_mapping_iov() returns 0 on success and negative values
on error. The original code used inconsistent patterns for checking errors:
- Some used 'if (ret != 0)' in virtio-gpu-virgl.c and virtio-gpu.c
- Some used 'CHECK(!ret, cmd)' in virtio-gpu-rutabaga.c

For if-statement checks, change to 'if (ret < 0)' which is the preferred
QEMU coding convention for functions that return 0 on success and negative
on error. This makes the return value convention immediately clear to code
readers.

For CHECK macro usage in virtio-gpu-rutabaga.c, keep the original
'CHECK(!ret, cmd)' pattern as it is more concise and consistent with other
error checks in the same file.

Updated locations:
- hw/display/virtio-gpu-virgl.c: virgl_resource_attach_backing()
- hw/display/virtio-gpu-virgl.c: virgl_cmd_resource_create_blob()
- hw/display/virtio-gpu.c: virtio_gpu_resource_create_blob()
- hw/display/virtio-gpu.c: virtio_gpu_resource_attach_backing()

Signed-off-by: Honglei Huang <honghuan@amd.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 hw/display/virtio-gpu-virgl.c | 4 ++--
 hw/display/virtio-gpu.c       | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index e60e1059df..6ebd9293e5 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -557,7 +557,7 @@ static void virgl_resource_attach_backing(VirtIOGPU *g,
 
     ret = virtio_gpu_create_mapping_iov(g, att_rb.nr_entries, sizeof(att_rb),
                                         cmd, NULL, &res_iovs, &res_niov);
-    if (ret != 0) {
+    if (ret < 0) {
         cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
         return;
     }
@@ -701,7 +701,7 @@ static void virgl_cmd_resource_create_blob(VirtIOGPU *g,
         ret = virtio_gpu_create_mapping_iov(g, cblob.nr_entries, sizeof(cblob),
                                             cmd, &res->base.addrs,
                                             &res->base.iov, &res->base.iov_cnt);
-        if (ret != 0) {
+        if (ret < 0) {
             cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
             return;
         }
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 0a1a625b0e..1038c6a49f 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -352,7 +352,7 @@ static void virtio_gpu_resource_create_blob(VirtIOGPU *g,
     ret = virtio_gpu_create_mapping_iov(g, cblob.nr_entries, sizeof(cblob),
                                         cmd, &res->addrs, &res->iov,
                                         &res->iov_cnt);
-    if (ret != 0) {
+    if (ret < 0) {
         cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
         g_free(res);
         return;
@@ -931,7 +931,7 @@ virtio_gpu_resource_attach_backing(VirtIOGPU *g,
 
     ret = virtio_gpu_create_mapping_iov(g, ab.nr_entries, sizeof(ab), cmd,
                                         &res->addrs, &res->iov, &res->iov_cnt);
-    if (ret != 0) {
+    if (ret < 0) {
         cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
         return;
     }
-- 
2.34.1


