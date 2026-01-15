Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49A57D33A00
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 08:28:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgIi9-0006A5-EF; Thu, 15 Jan 2026 03:28:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1vgIi7-00069R-0E
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 03:28:07 -0500
Received: from mail-eastus2azlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c110::1] helo=BN1PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1vgIi5-0001Xd-13
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 03:28:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sTwQ/sQ+u1HyIXrf6YpqdqLuo+BI84HGTTImcF5e14L9s3dB2kYNJHXDipaUMIiEwniX/4D2zQ9AmFTqD6Xh6KWssvf+Dyi1ckt4aeXXI0t+v38DVvFTrXMnTWZcENZAvYACS2iNlMgk4hRsQx9JrV73pMk7UPkemYxcAyci75SbvDl3+26j9KNmSq6/TIlKEyoqbti3XRoBSzWyKxx13++fjCBj6UmxoRDCvVWLYbiEWy20qBq49mi4QWdPskEjopLYkH/JXM+bndjOpZaMVv7xbYMtvwAChJYUZd5xvaIJ3LObIGYex8DrEBGx+Yr/kKPML4EshZzuBg39kIrpwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M8AHasBVXhtTBO7v3AW7MDHurUWLVP7TYV61f7a/Y9Q=;
 b=c4G3AImlvwx7ktf4OB3u/ICRDu/H2RprTiq+6kXM3+Tdp9+AGBc5j3HdJVMYjPkg8hWpi/jyrT4Dg+a/rFEdzngvzZkR+TqfzOp/zWMvksbBc2BJ7t3KLv57vjc9sjjTBJX0Jhb+KmcS0J7g6l6KdhqSpfu+h9Rh/kcLMrQ3mxzVzvJ1JYmvBbx5f4k6wtuoLs9QfQK69aHFCfO9PCjWjBaqOYxR+v+G/ltE0KOx7oZyoVJbLQ+blzOExb4NM6OldrLvB7ppo9Sk+j8FiDAF8Vvg7aWapLUuio6qgq8CHlN5vpK2OUXovc4j85XpDAVgGEAvbvwU+G6b0H7f0VBtVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M8AHasBVXhtTBO7v3AW7MDHurUWLVP7TYV61f7a/Y9Q=;
 b=J4+VuGcJVGqARu2FBKzUAsPuUWdzE5WdyUh1+wpEsdSgxbqsea9z4iPzv0uAyYZ2aImcHDgMbdQ7U0BJgBtoVWR6II7MuI9VzSw2q8sIll7CnaniyG4aM6xb6FJ9RAh3OKyYRrdmOFFScNph/c+9yWw8Nt/L/y19ZClFi33YR4I=
Received: from BN1PR13CA0012.namprd13.prod.outlook.com (2603:10b6:408:e2::17)
 by DS4PR12MB9636.namprd12.prod.outlook.com (2603:10b6:8:27f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Thu, 15 Jan
 2026 08:28:00 +0000
Received: from BN2PEPF000044A3.namprd02.prod.outlook.com
 (2603:10b6:408:e2:cafe::46) by BN1PR13CA0012.outlook.office365.com
 (2603:10b6:408:e2::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.2 via Frontend Transport; Thu,
 15 Jan 2026 08:27:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A3.mail.protection.outlook.com (10.167.243.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Thu, 15 Jan 2026 08:28:00 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 15 Jan
 2026 02:27:57 -0600
From: Honglei Huang <honghuan@amd.com>
To: <alex.bennee@linaro.org>, <dmitry.osipenko@collabora.com>,
 <odaki@rsg.ci.i.u-tokyo.ac.jp>, <Ray.Huang@amd.com>
CC: <mst@redhat.com>, <cohuck@redhat.com>, <pbonzini@redhat.com>,
 <qemu-devel@nongnu.org>, <honghuan@amd.com>
Subject: [PATCH v5 2/4] virtio-gpu: Remove nr_entries limit check in
 create_mapping_iov
Date: Thu, 15 Jan 2026 16:27:37 +0800
Message-ID: <20260115082739.174224-3-honghuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260115082739.174224-1-honghuan@amd.com>
References: <20260115082739.174224-1-honghuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A3:EE_|DS4PR12MB9636:EE_
X-MS-Office365-Filtering-Correlation-Id: ca01efc9-8099-4a7d-6645-08de540ffe8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Am8vDf+ltPlZlLv/0gNvKfABSBrd7Hucwe68Mh9fsPMzxJM48qhNmBOE68rE?=
 =?us-ascii?Q?MwG7Frxo/chUfP3w4udzfuzkFcGNjmEzDPRIfUEg3TW2U1bJRPKvVg+cqSaX?=
 =?us-ascii?Q?AxBKpsn8yJlDE98sZn10mlqkKZ6HBTs5EW+qfxHtAQfpDi+pU8UOUiSSP8x3?=
 =?us-ascii?Q?GEsnTSw8/tuj2cOst9DqPqywlHwlk21y9qMSIuDUj2YMbSY0mIovA8C1eQgF?=
 =?us-ascii?Q?EK57spUtac4EES3aquNahwL6T/mZJ45wF2IXdJehN8IVc+yqzpus0EEG5N/C?=
 =?us-ascii?Q?idrHM9BMijh8oki3nV02cY860Tf75Qm6VOdaI6YIEkSEgNYSjw9bpH8L0xEB?=
 =?us-ascii?Q?GSAyz0L4NkDA5ZL7mjjsD9t4Q7ab5ujvdbrB2fkMB9OTrTP4Xt+0gt1GR8jl?=
 =?us-ascii?Q?+80sCJzsU+VXLSC91UDzoc6aBadFnbStDlYNDdlDypiT4Raof1bNZzNPNgC1?=
 =?us-ascii?Q?PdTbmS9osRaoGU1F7ELJ1dzyHzDE2ugX60I/wwMzLkVzJ139niQ4BDAsspMG?=
 =?us-ascii?Q?B8Lsk04KqDRBt666NcKM+pwGEc35+iPYuxf9MyIoYTJVYXvhiYyR8tcMRjGT?=
 =?us-ascii?Q?lh2TL2LxJj7W7aBGCEYqI/AIplVGCkIuLfVrK//IogV2YQYgfUrV28XfPABN?=
 =?us-ascii?Q?oHwn7JYMdHxEfUXBJ2yRNYD4zpQyoJsDam0haHMEWFZFqaylnZsGck4NKp87?=
 =?us-ascii?Q?beIX7hm6Pv3Lf9lRzSMExkgakUkeMsvnv9HJuatQW1MSSqYQkM1xAjzcLJtm?=
 =?us-ascii?Q?+N5abAxJ/fJjDOgTa9sJk/djbFnUstCKfl+tSlWJoXdv2RMsjerlYTr8liR5?=
 =?us-ascii?Q?fxF8/+WhlCM6TQ7Xx0WzaX3EC2nSGIU6VMsJzZDpTP+iqs991Fc8awhwFnyK?=
 =?us-ascii?Q?HXtoyTEUMv90J0lQLCdMnuldtXcTv0YS+GC104QmnPOm/D7fAJyb0BDpwvJQ?=
 =?us-ascii?Q?qfBlDMhOAF33Qx5+bLq2LDvGKx8Bl2jZG7ApEW9uTeXyHKjmI6fwDUgvLvAI?=
 =?us-ascii?Q?0cizJK0XkIr6q3SoOH4nPt4YVqv0DV4/ou/gwIEv1wCsb1vTbqTkcLAIljhk?=
 =?us-ascii?Q?XyfXVucqoOx0JkOhi4ipSdvUa/i/W468wzAz4UQnoBMeA154NCX2SKGhP/MK?=
 =?us-ascii?Q?y7ZHU9tK+UxAmmYUtpSmPQVcqchfWVLY87QXgDw/G/hRVQ55eZQlyI6wDsMO?=
 =?us-ascii?Q?xguDnDufnv3mo8NG4cXFsLnq5qZJY/DkCGQXnrEa2z0AN1vQvjxgZwdpRrXX?=
 =?us-ascii?Q?Rg/Np8IFc8XKk7UOqtrgAJqWxv+m5dmgHKpI7sSG7g8F8FfC4ZN+/t3Pc6G+?=
 =?us-ascii?Q?hteHRjEEw33I+ixpdwNQCM5cXN62B2FrFfYzYZeihlut9C75BSR/pAt5PvCL?=
 =?us-ascii?Q?uvu/VuPKuOcbbnKNOWBR7U7bh1LXz3hkAMoWajuBCGKmY0jGDyugmpUp6Mul?=
 =?us-ascii?Q?TJTXv2xujf1pNk/BNEg+aIufZ3BxeRR+redMcV74SkOqIFP4I6aQor8cpQ2I?=
 =?us-ascii?Q?4pp/asMT8pbBVIaTZKXkZsmMn5ISuRLrfNCD26oHE6l3Yyp2Q1ee6RJUOWrX?=
 =?us-ascii?Q?0emmLQ6XZH+IMH5XUYbkzb09FS7Bi/KKF9b/DgqBXjbRyu0VwIQKyPMnDUOu?=
 =?us-ascii?Q?2/HiX7XLmg/roevYIFSU0Lajzv511N07VIw+YcEhGI08zVOZI4ESqXm6EJtK?=
 =?us-ascii?Q?opKM+Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 08:28:00.4748 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca01efc9-8099-4a7d-6645-08de540ffe8e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9636
Received-SPF: permerror client-ip=2a01:111:f403:c110::1;
 envelope-from=Honglei1.Huang@amd.com;
 helo=BN1PR04CU002.outbound.protection.outlook.com
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


