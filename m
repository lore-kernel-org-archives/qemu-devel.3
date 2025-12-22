Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1903BE674B6
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Dec 2025 13:57:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vXgOp-0007Uo-Lv; Mon, 22 Dec 2025 08:56:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vXgOW-0007M0-O4; Mon, 22 Dec 2025 08:56:18 -0500
Received: from mail-southcentralusazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::3] helo=SN4PR0501CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vXgOU-0004dS-Cp; Mon, 22 Dec 2025 08:56:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gNm764bKdpE6VT/JJStHzulAGXu+uAlglaYCDbyRgzK+H/neUpE5mecy6HFBy2TtVvWW0YZsKBxU/aOmfQbYzmT2yUds7r/bl419vU4a660M0twuOBD8T/uY7b1SKxRUIfZ28lcCBDDo7JqASl7O0DOqCHAV4h2M2DDazeXnf5xoMy4bwALBlen8kHvTa4Vq4pSBGhNqb7TSqjuD1007fcjb70lrW3Bmr/PgJBRfHm7foEUgOiMpKYXeB9+jv2hJtzN7jOQ1ThjvJjUW2dkZ6b7sjtAT5xtS5/azdAoCBBBVz46M2ySLr/XJrlyqbSZxPCom8P7TAEcdI8Up+E9PAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UWkhGlatNGjG4Jax61knJ1WpST7KrJ/61lcSKEwh3Og=;
 b=a81Yi5nSmEGH+vnLqjP0jTFeBelsVxf8UuQ4t9SlfVJdahvSf7HRib0hnjqj0CGa8PVmWIaPCQqHNrloZJlL/cjEXOYtH3sof6dMnJ8W6EGqFiiICwiV2+ZqFgqOvr8HlwhudgoseFmi1yGKDrM/KLOp9BPSrSyej4ojpjDnreqvUbB2ksIFgIWzQv0vGtruH0gKuRwT6cDe7YNm/CLvhzkNU+mruQuqmFYdUxdY6Fm4EoWkgorJj/furui/Eg6IIQH7Mnfk/jY9myUBwjhtg6lENH7u8gv4/YOOjZA2hqt5DDHNBFcX9ElHM01Lnk63JiAcK9vUzl44m/7dMYy+Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UWkhGlatNGjG4Jax61knJ1WpST7KrJ/61lcSKEwh3Og=;
 b=HZe0JvRdoWOJsXm9W5vhMtSXPQj60bXgNSOe1TXumee9e+iHCOmYbHsdsdW+9N9ZVodGPnFnzUXGChBInrIVnaJsgXvm3H524G/Ze2uuCxBnfL1s1lF2jwgw9CrDEL2BWWPRAmAZi/ljEVdjr9ScbQbEmnXkifpvv6nUahEpJj8UcQuNmGBr/kTef8CBhSfIl/sBDTYFOnxiB4A1nhW/jn2zCHB3yCa3Y3XrnPEre4nKEnrc6P3bFg38L2F2TKqekWCfqo7vWW1+x3vg8usQ7lYllzp/u6zIk8Rz8BhGQqVPFvKXdQ7gT00eVe+QJMd7k04ukmBKtQjRaNvl2tQ/WA==
Received: from SJ0PR05CA0015.namprd05.prod.outlook.com (2603:10b6:a03:33b::20)
 by DS7PR12MB8419.namprd12.prod.outlook.com (2603:10b6:8:e9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.11; Mon, 22 Dec
 2025 13:56:07 +0000
Received: from SJ1PEPF0000231F.namprd03.prod.outlook.com
 (2603:10b6:a03:33b:cafe::ac) by SJ0PR05CA0015.outlook.office365.com
 (2603:10b6:a03:33b::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9456.9 via Frontend Transport; Mon,
 22 Dec 2025 13:56:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF0000231F.mail.protection.outlook.com (10.167.242.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9456.9 via Frontend Transport; Mon, 22 Dec 2025 13:56:07 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 22 Dec
 2025 05:55:53 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 22 Dec
 2025 05:55:51 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <alex@shazbot.org>, <clg@redhat.com>,
 <cohuck@redhat.com>, <mst@redhat.com>, <nicolinc@nvidia.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <jgg@nvidia.com>,
 <kjaju@nvidia.com>
Subject: [PATCH 2/3] hw/net/virtio-net: Adapt hash handling to updated UAPI
Date: Mon, 22 Dec 2025 13:53:56 +0000
Message-ID: <20251222135357.143339-3-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251222135357.143339-1-skolothumtho@nvidia.com>
References: <20251222135357.143339-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231F:EE_|DS7PR12MB8419:EE_
X-MS-Office365-Filtering-Correlation-Id: 71b0435a-62ab-49d7-1095-08de4161dabb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IKj4FszupzUa4hfmNYatHP/7xHE9HxNAVBVWf77eJ1LP3Ne8xuv1RVWWyzBo?=
 =?us-ascii?Q?2O6a/f3eoZbSUzp+3hP1UgsQDQFBGd5rHUgOB3KJ6UTibsN5rwaxaZyfA3Z8?=
 =?us-ascii?Q?aCfbeooicuiW+ty6xeOy/V61585guHlrsaFZyJ5DnWIv4yxDd++Ezbr0pBOf?=
 =?us-ascii?Q?qeOXevn7QGVc7czTwDg3P0Qu/8REFQrGbZs7+TxHkzQo+NKnWhBygyyPFaQK?=
 =?us-ascii?Q?gqHIuKcPeRuzlNOMr7oXf21/czdjCyRWYvvlAhW5xsWN7f4zlHTqLI3Hnsxf?=
 =?us-ascii?Q?yfCT79oLa2D7tsgo4nfjhHfENdxVeHkKKgIdwSYBLnZOhFvyF89077tadtma?=
 =?us-ascii?Q?WkQfSryUt4kORtw4f8qZcQT7rvtPH67hi9bMFTqAriXk1Og0RwSjVBisgQUj?=
 =?us-ascii?Q?hFbDFETlKKz4Sd95O4lziShau7Eh+WB3YjwtZ2EQHaNEEVaQ3XOcZA3sCHjp?=
 =?us-ascii?Q?MgzkWPQCaT5yiovHFtyK9/GIBH72YU+zZcWawDls/BMPqk13VVUgrrkow+h3?=
 =?us-ascii?Q?LF1sjCjVf+iXKC0DJAGlFBk/LuS0Mq1y77T5s4MWdgtWCy1Xgi9N6i8s7i39?=
 =?us-ascii?Q?a2ozSqMD+/r7TpACxwI5RhhjvJ1ndVqP2tnHHdFuZ51hhPpf3Jc9Pf13/F+L?=
 =?us-ascii?Q?kej0btXUEunHsuHV7D8hQe0VPi3e7Pv2oaUKNSMTEY7ajEqnxvbjTVyYGSPL?=
 =?us-ascii?Q?+AEA5dLtgXISBS+iIUHsDmV5A5HcnfqIz9QWyOLPFd3UAt5Z6hyKmW+Zyt6m?=
 =?us-ascii?Q?oZPjz6OhSCgy40UZmbQerJsctdh6ZGO0hvEguu/QxGLGCgDBF/NlpslfdwdI?=
 =?us-ascii?Q?Fn45VbaTyeo22N8+5t54a9JTinfn3d81e4i6fZrEMY7j8p8RWJN1fun6tdTw?=
 =?us-ascii?Q?uOoNpDtOnmRW6M7/PVYyRg0TWANRfw4Vcm9kb3EIZL1tI1i5LhF+PRTDnidg?=
 =?us-ascii?Q?qbT3L1CHdoVqvLoRBQVS3g2CQbAgx3seOIyqLWiLtgMv68W0xaXsQP1ggemp?=
 =?us-ascii?Q?aum9pVW3IIEOxv+ibHcOZrj90P4ozj012oo3MmhVTyNHUpVZsDLZuDEhIwew?=
 =?us-ascii?Q?9R7B+QJBgORsYqflWXvyU9CHXEyF+GKmr3MxxQUNyqXlbEsmexoehYfDXVEU?=
 =?us-ascii?Q?GZe6WVACtYBrFgwTNaoEWvkJINQyk2tv+26M5aQiJ4XgvbNtYfdELipCRG8o?=
 =?us-ascii?Q?V+Nt16FPmF74UqByyqW4IBpCq4jxYeZtgW10QCxK9MKLDY6Uf2A5nSUgxxIL?=
 =?us-ascii?Q?0d7X7V5rMOt8YuBsrtGMjba9Ws5CamKTpesPPjbOaNAFUnraQ25frITn1nmq?=
 =?us-ascii?Q?I3H2Cc2eIATy0KwsuJWcqtzWm1X6DwAFQMiYkTcHWiGKI8ZUr0eIOuRz5BJc?=
 =?us-ascii?Q?wuL8byph9FhijnQyXxL3v2ti7jjbNPXoODbrUx8T05/8RMVtqAVMTfJPiZAl?=
 =?us-ascii?Q?yIKeKGNu6ECuzrrnFHx/csk3/XjpHxb12l7iL9KZoSRwFmBM8uMbCkw183Ps?=
 =?us-ascii?Q?EnIZCNZ7I6V4pz+fcEkeeG5raMgG7ctjwtqL68e7mgO9aDusH4t/NRG/v5WY?=
 =?us-ascii?Q?GIaKTi0ufY03uDsWMZw=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2025 13:56:07.0072 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71b0435a-62ab-49d7-1095-08de4161dabb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8419
Received-SPF: softfail client-ip=2a01:111:f403:c10d::3;
 envelope-from=skolothumtho@nvidia.com;
 helo=SN4PR0501CU005.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

The virtio_net_hdr_v1_hash layout changed in the Linux UAPI, replacing
the 32-bit hash_value field with two 16-bit fields, hash_value_lo and
hash_value_hi.

Update hash handling to populate the new fields correctly and adjust
offset and size calculations accordingly.

Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/net/virtio-net.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index ca813203d7..8a7558e278 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -1879,7 +1879,8 @@ static int virtio_net_process_rss(NetClientState *nc, const uint8_t *buf,
                                              n->rss_data.runtime_hash_types);
     if (net_hash_type > NetPktRssIpV6UdpEx) {
         if (n->rss_data.populate_hash) {
-            hdr->hash_value = VIRTIO_NET_HASH_REPORT_NONE;
+            hdr->hash_value_lo = VIRTIO_NET_HASH_REPORT_NONE;
+            hdr->hash_value_hi = VIRTIO_NET_HASH_REPORT_NONE;
             hdr->hash_report = 0;
         }
         return n->rss_data.redirect ? n->rss_data.default_queue : -1;
@@ -1888,7 +1889,8 @@ static int virtio_net_process_rss(NetClientState *nc, const uint8_t *buf,
     hash = net_rx_pkt_calc_rss_hash(pkt, net_hash_type, n->rss_data.key);
 
     if (n->rss_data.populate_hash) {
-        hdr->hash_value = hash;
+        hdr->hash_value_lo = cpu_to_le16(hash & 0xffff);
+        hdr->hash_value_hi = cpu_to_le16((hash >> 16) & 0xffff);
         hdr->hash_report = reports[net_hash_type];
     }
 
@@ -1990,10 +1992,11 @@ static ssize_t virtio_net_receive_rcu(NetClientState *nc, const uint8_t *buf,
 
             receive_header(n, sg, elem->in_num, buf, size);
             if (n->rss_data.populate_hash) {
-                offset = offsetof(typeof(extra_hdr), hash_value);
+                offset = offsetof(typeof(extra_hdr), hash_value_lo);
                 iov_from_buf(sg, elem->in_num, offset,
                              (char *)&extra_hdr + offset,
-                             sizeof(extra_hdr.hash_value) +
+                             sizeof(extra_hdr.hash_value_lo) +
+                             sizeof(extra_hdr.hash_value_hi) +
                              sizeof(extra_hdr.hash_report));
             }
             offset = n->host_hdr_len;
-- 
2.43.0


