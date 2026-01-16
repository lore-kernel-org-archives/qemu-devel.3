Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7579D4A613
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 08:53:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgfWi-0005Lm-WE; Fri, 16 Jan 2026 03:49:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1vgfWh-0005L0-11
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 03:49:51 -0500
Received: from mail-centralusazon11010060.outbound.protection.outlook.com
 ([52.101.61.60] helo=DM1PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1vgfWf-0006lL-37
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 03:49:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o9G6AzmPiuNi8IV/xF03itaVBBC9ltbJj+Li2NQX4mY+cS/O89TdUsmh83Q0YFwuEfDIf7HY81x6YXwc4d0B1pbbfvySpBwZ/7lQAc2/xtjJ6AZGUpwwgUMtEbBy6PexXzt8+LZPFydAkDrxSH0JqnpK+gQ/gM9elOkZ//EOEwXt7L366keh2KdxsCf2JJeahnR4202ChSakRNJ4yWuMsemQ+q9rP5ha+tvQuJY/wNsx5z1ZwG9qSujZAED2jqr9K3NfwGdTFY8bjEEYFt6r9j/IKMUAQHeEd5Dpl7CJ66pzT0yHT7Q0HNjIS7aHy3hatvvmJnNSxEM8x+/dCq49qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M8AHasBVXhtTBO7v3AW7MDHurUWLVP7TYV61f7a/Y9Q=;
 b=AZ0BleBYaOB/nqZJC1pmzvWoQ04vlsSHsA2ttalGvVxGvxsotG0QvLIw4R+cSuZipN4rP2X8MNfct8i9k594A6uopIJTl8Eej59JOO5TLnJEZcoSplBNRMSrOoomWiOYvYDrSAI4zj21KTHd3BJ+zERYvbk2q0SGcYhIDIJyfGOZ+G6hHdYeNiu0ZpdIXbzr94PXJ0licqF1eUv7uM8qYkfeaXYTDfv8Z7g9TK84+nO8TYD59vsM1GgeUKtxicurGD3PtzURIflOX26BBHyBKlCOkxwgvsGqbCTJnunU/cxLW7SY8UncWd+HCDzRn6uGkbZQpxRW1Vu1kvPRxffPpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M8AHasBVXhtTBO7v3AW7MDHurUWLVP7TYV61f7a/Y9Q=;
 b=BNJnbw+qF+5Htbeg3TIFmu5klNhhSbzdpkoYK4WmBqH+8KH4NV2ntjGT42wO7gCLI2BqKiAO0HJ4tKnkk013JGrZ/4hL3C0HFb7sqytP2A53qL9FwGdS3ejxyr35Ufw066MqSW+0QRNOvDhJZ1GbXN+8g+RCoeAfrv0SfLUXFLg=
Received: from BN9PR03CA0495.namprd03.prod.outlook.com (2603:10b6:408:130::20)
 by IA1PR12MB6257.namprd12.prod.outlook.com (2603:10b6:208:3e7::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Fri, 16 Jan
 2026 08:44:41 +0000
Received: from BN1PEPF0000468A.namprd05.prod.outlook.com
 (2603:10b6:408:130:cafe::7a) by BN9PR03CA0495.outlook.office365.com
 (2603:10b6:408:130::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.6 via Frontend Transport; Fri,
 16 Jan 2026 08:44:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF0000468A.mail.protection.outlook.com (10.167.243.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Fri, 16 Jan 2026 08:44:41 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 16 Jan
 2026 02:44:29 -0600
From: Honglei Huang <honghuan@amd.com>
To: <alex.bennee@linaro.org>, <dmitry.osipenko@collabora.com>,
 <odaki@rsg.ci.i.u-tokyo.ac.jp>, <Ray.Huang@amd.com>
CC: <mst@redhat.com>, <cohuck@redhat.com>, <pbonzini@redhat.com>,
 <qemu-devel@nongnu.org>, <honghuan@amd.com>
Subject: [RFC v6 2/4] virtio-gpu: Remove nr_entries limit check in
 create_mapping_iov
Date: Fri, 16 Jan 2026 16:44:07 +0800
Message-ID: <20260116084409.326062-3-honghuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260116084409.326062-1-honghuan@amd.com>
References: <20260116084409.326062-1-honghuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468A:EE_|IA1PR12MB6257:EE_
X-MS-Office365-Filtering-Correlation-Id: 173e4923-f66d-4cd8-c7b5-08de54db7dbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kmvDmE1naiYu5cfqoVPVVOQPk98pjiRJvhnBvuUKX1GtIUNjmK80dnUAAlZV?=
 =?us-ascii?Q?2qKKY0Ws+J4eE658QRl5rGpBo4KRgUTNHEtus8l4+APB2jWr0qiAX+EehmK1?=
 =?us-ascii?Q?ORAmXIaTQ/5mAMW9sQcY2dbT+gurXnnzYDy44j9YvELRENHORnSEgKBzGV5b?=
 =?us-ascii?Q?ilDG3usb1aYvFeNfnJuwnD9cg9DjeqU5SQjCQ8SJ5PQFJDdQBZ4gG1szxa5C?=
 =?us-ascii?Q?GiL3q0TeNeG7/AFiOzkIttww1RCovMXqt7t3J+vY8STq9W6aLka3jLiANYNU?=
 =?us-ascii?Q?JgMZcQWdYLAcWoJOLz/p/XgNBW7L1mTNVOz5eBvoXNN7U5O0TtrHFpcpehHT?=
 =?us-ascii?Q?WMxsDvj7ky+/pevqoPrmH2wHun+3ZrnSirRPXWqLRXjiOf0C+A1vE7vpyuwM?=
 =?us-ascii?Q?j1R0tlMspoWXB+dAQi6nUK39D+YCiCDP+Ps6vPU9O8n/34KLqUHMej9lbyC7?=
 =?us-ascii?Q?tbOzT7BhKt/Ign/uDfU/JZTO8H4b1To3oirHG1Gw8yUTpMQTteAYEcw8rHbA?=
 =?us-ascii?Q?5JbF1Hp3zapFwMjf2QIP9CLL1fohYkDebdBAfKmOfLRfnAdlQQZBfIYw8OI9?=
 =?us-ascii?Q?oKCYpd5+U2NHswWAGwQrcHHqfr2mtycH8oVD5te0CY74PFbYYGSZ63OGNMbO?=
 =?us-ascii?Q?hMCr+1ydYxmSr2FfaJgEpzFSdOQogb4Uam9SWOENbQhRYUw+zi78660zYyLE?=
 =?us-ascii?Q?+EufO881WkE+9nM6nwdLiBIifND6D0V/AsUj5058x4EzwbmVFtdK1gLBY5or?=
 =?us-ascii?Q?OJVQN9Mr5kqMLjjzvAmCXTRcWv7jiHqkl0+bLFDvHeubTWecvaktVZe6G40Y?=
 =?us-ascii?Q?6T2InYD8lywT6GsRcAwTGns/TRTtLGSiHiSI8fnFjtKhp69yYr4dtv4k+ovE?=
 =?us-ascii?Q?+4wuNJhLjogAg3XGWRdKA0W1KMYZD/FHWCdr002Lx9XDofT1se0r0oNf+ouv?=
 =?us-ascii?Q?ClMZSWr+PIBqsSlo2BHOtbDAFWolerlQG3FJdguXYVc6bx126spOHjjY3MZn?=
 =?us-ascii?Q?gZM0p6xUld34MHuZcLWP8il3Ts/FVbq5jz455vtk2H5iGldb3AMNGLJx7OxC?=
 =?us-ascii?Q?Yi+2uXlOhcuGlf66Gek1rzxSO/9p/Cac7Ax7M6P+WlpfF1QmbGNpIjmW/vXI?=
 =?us-ascii?Q?+J4IISeAPbQyZbUHhiAS5ve3oglT5Y3gH39Ggh3M08mQAa3VsivijfNYSsLX?=
 =?us-ascii?Q?jhOEiUzMeo1q+/MgCYs+Ytmwe6pocf+AUZzetbnb+E5WLXo45W6oW9yNrCh5?=
 =?us-ascii?Q?FqhjVbQveuS5Ps1QysRyvZaNsKLKlnu+M9X0ZvH39qRVDsvSL9wM32NwO/3u?=
 =?us-ascii?Q?oJJEuh661Bi8CHRJe/vQePKVapXJDsgOKgrH2JuwvNZFAnEnVUGGX+OInyCX?=
 =?us-ascii?Q?vpda8JroYTXqZ68eAM6HhLwmnS6SfFCsmavi18aH6ACrCRu215hizwOpYmI5?=
 =?us-ascii?Q?kJ4/CMVwGPE6W/u2EeMxbYrK7V+h24FykYyTZ8s6FUgEOaZeYe5deBjXik71?=
 =?us-ascii?Q?QQzDJzR704K4YMMN/j3oq1emkRkibqnXMkrEmoq7mDwL0pJ0uVxMp05R9Xhn?=
 =?us-ascii?Q?hwUJ0NOfRJT1Z1+gAzElvcb/dl6DYYI3iac9vLHhx08NrSgsVvf5BYml/6PD?=
 =?us-ascii?Q?V31vU6EgcotOzz0Zxz8YxCPqvAa13N1T9KT0YLWkWsVbuDtw+wEtf99OUvyM?=
 =?us-ascii?Q?2/2SGw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 08:44:41.6814 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 173e4923-f66d-4cd8-c7b5-08de54db7dbb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6257
Received-SPF: permerror client-ip=52.101.61.60;
 envelope-from=Honglei1.Huang@amd.com;
 helo=DM1PR04CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Remove the check that limits nr_entries to 16384 in the
virtio_gpu_create_mapping_iov() function. The kernel virtio-gpu
driver does not have this limitation, and this artificial limit
in QEMU can prevent legitimate large scatter-gather list operations
from succeeding.

Remove this check to keep consistent with the kernel virtio-gpu
implementation.

Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 hw/display/virtio-gpu.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 643e91ca2a..17df148920 100644
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
-- 
2.34.1


