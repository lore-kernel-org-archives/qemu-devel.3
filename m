Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04350D0C85E
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 11:39:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfcjc-0002go-Dp; Tue, 13 Jan 2026 06:38:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vfcjW-0002eS-Si; Tue, 13 Jan 2026 06:38:46 -0500
Received: from mail-centralusazlp170110009.outbound.protection.outlook.com
 ([2a01:111:f403:c111::9] helo=DM5PR21CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vfcjV-0003n4-IG; Tue, 13 Jan 2026 06:38:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xYvdRug9cfqYOJRCzscHttSW1kALvfVHsnAMzeQp3Bn40FrHM8SKPXZUPcta7VqrmTHncVsf5f/SC0FHxgMcfr3fUM08przSCdxG8uBMAQqhEvPQ3/cVwWOEkq+4Tu+7PAs0n6e6v2chQtfE0O7yp/TcNUHn5NMw5QvsKK4n3J79oMvbHHka60FOxQSGvE6pEP06mzxWEiUzSg6U7KQgB1UQiUUyYT29XlBhFzEwzfoHrnQFIrVTK2xmIFy/CGeHbMOUNo2bqKN5igPSODYTeESgKYYOxMuJJ2mNHKqcTWEzalLux//vhGEeiHNWhGbqAopdkTcc/D/qnkWHhrsYdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NT14EKgEERD5tuxBjBCNFuMg3VDRNysl3RX4Zx8mF10=;
 b=d9pQMH0/kshQYMMZt5BR1i0irRfBqISmdfDdMgVM6xdf2rEfcx3NADDdC0Ho3Sn87PijwXS6Fz3I1thOmGWZv+p8O2YEig8U4NXl/cN6TaaJ6OoGsr+2VNvZVJaVjPLLTRMYU+a5P0rUhstt3fgFxeutCPrg8Bgi0wRvI0toR0WbtQGt//QlhThNfExj7rLUMExJWDbXDI/jn2Z6DA/frH25AF8qu6LBmXS6qZVQ031rqXNoqGq6pBqKAUQQdoRvL5rOioHtcCdc5CYZZELyQYA2rpE5s61ybUcHNmfRCG/OwJ37cmFgiIVM1LbL3IN+RySWl9ZwDwoS1MhkxrlczQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NT14EKgEERD5tuxBjBCNFuMg3VDRNysl3RX4Zx8mF10=;
 b=A3/7oFXHcWXvXxtsGAMXH6kJVdjNY++SuH6LAKoyZi/JIGXK0HhyW6w6gPTExnelZz0FrPDbT1LT6Ijk1Y6GD1M781T4w2XeEeSkEqTRM5lovY5xEOQbCIbrI9uQX/LXai9Cydg/1xO/A8bEe+i1m8gyYMXWRKA+lEMTuNKtJ2NLhBminQuKfvl96QPhEKAAHU6C/Cy58o+gb5R3CpPFaYyE15oNLgQfj6K63qxfCDHnXEygCFudY+TQEThqh4cEKctryTy7vI1NxLdh7o+TfHjhERM/p6MTmHWDBtT8b5VhMibeaNbRJU2Lry6onuXjT8cU2iZUmIBOMVGXuFgrog==
Received: from BL6PEPF00016419.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1004:0:8) by CH1PPF6D0742E7B.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::613) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Tue, 13 Jan
 2026 11:38:41 +0000
Received: from BL6PEPF0001AB50.namprd04.prod.outlook.com
 (2a01:111:f403:f903::4) by BL6PEPF00016419.outlook.office365.com
 (2603:1036:903:4::a) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Tue,
 13 Jan 2026 11:38:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB50.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Tue, 13 Jan 2026 11:38:40 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 13 Jan
 2026 03:38:24 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 13 Jan
 2026 03:38:21 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <alex@shazbot.org>, <clg@redhat.com>,
 <cohuck@redhat.com>, <mst@redhat.com>, <nicolinc@nvidia.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <jgg@nvidia.com>,
 <kjaju@nvidia.com>, Jason Wang <jasowang@redhat.com>
Subject: [PATCH v2 2/4] hw/net/virtio-net: Adapt hash handling to updated UAPI
Date: Tue, 13 Jan 2026 11:37:52 +0000
Message-ID: <20260113113754.1189-3-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260113113754.1189-1-skolothumtho@nvidia.com>
References: <20260113113754.1189-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB50:EE_|CH1PPF6D0742E7B:EE_
X-MS-Office365-Filtering-Correlation-Id: e1a12ed2-07aa-4647-a09c-08de52984cbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013|7142099003; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9+6yZa8LlNzzzioWiJTH0ivLi186efVr5f1gmdUcFSoBecLhRuAeHMoYdnf2?=
 =?us-ascii?Q?AH0DQ4Chc+XGGu1DGaTXBytbw+YHiCZ1u8AZIcSZHPvsfmx25i6SuYVXHgc2?=
 =?us-ascii?Q?W6YFNH71i7vdWExD7wERgAd7GpGGRnygK8omgbbVDwqRx6RZrZZGWnAqtcfB?=
 =?us-ascii?Q?IzALVMF6yWaEi39kesGeL9a7xCjwXM1G6eY8sPKJKN2mYelay+cC7a2mA9XF?=
 =?us-ascii?Q?c/EZFQ+yx7UU4J03blAVcwHwIeNgp5c709KrZ8yX/dyyfbrqm3406H/BxPSl?=
 =?us-ascii?Q?6UOP14jHqVKt5DZvIMUjKUWpvkAKKoDrNebyXF7VrD//m8Qd2eEaBco89FXb?=
 =?us-ascii?Q?NyeHPgsMv6y/yCbjT9oBL6ScV3TKXi94uHpfcB7Jcpwc9OEu92zhJHaE5mII?=
 =?us-ascii?Q?ieoj3H70/0yyROiDYoECzzTFfyR012J1/b65ZBZMxb2sZVkmBzGr5RO7ZhCY?=
 =?us-ascii?Q?gL3DgLhXf4EYxUaJpHbIKa2+LujiBE5yKcfwiGX0vAn2Wt3289Ys+ArggaOt?=
 =?us-ascii?Q?EytvayXvgFGV9B3P/I+7jr5PKC6QGgSUG/V3G6kSR1/eG1M0JZ5uSgOOnCdC?=
 =?us-ascii?Q?5BrPmubGKRYe2A0H+h2P8a9T6XauCUOeKQqE0zu2dH1H7ys6kc0wJQhexmpH?=
 =?us-ascii?Q?Q5t7+gBoFxQlVk3Sr/f4xpOwQXrb0cfeMKOjjnx9MWkqyVpe5qetbYj/t95s?=
 =?us-ascii?Q?XNyEKax1dFhJWtzYFzPD3Wz8UOXaBgSKRUBc+0arb/eo0XFsY0cAaGZTRs/M?=
 =?us-ascii?Q?IfWImbJJLqLJsLd2FBNmqgLsgg5xOCAGG29HtlUMW22Xw5yyfLBMf/FsR0/S?=
 =?us-ascii?Q?k8+Q32aaao8FJli9Px0c0ED9zY3n+BXfuTE/wCrZBBUaEsJOT+gIv8pFrPGd?=
 =?us-ascii?Q?DrA80TmRFrodXFNU2kISvy1rAcjhIXb2PHujj2PG8OrFBhJPtCcdCk0GwWjn?=
 =?us-ascii?Q?GH+8BBxzfG9cOuI41TjP5Lq6xsw9h5q8mWYwa3Zy56bKHAhONq963LAwjlh8?=
 =?us-ascii?Q?4dDUnoy/pUcIzyM3ta3uOm9RQoY9wlxjaWYz/ZSKi8aFa1PzSJ7wKeGExOpv?=
 =?us-ascii?Q?dSOpVQsJz6kgVDBrgIazDfMWU3xCQeoZPdFlDVmn/fjcu7aBUjTQ5wuTnz6+?=
 =?us-ascii?Q?u2wU9b1lwAdLbfYswtdt69eEsEAxqUI7+5IdUhKptVwN2AXaVngBAmaf5d+f?=
 =?us-ascii?Q?AKCgsY0OiHZEAiDKKMuYYiyGa6ION+GEnWCPfkCanBG1qHb119GnBvaxZKRz?=
 =?us-ascii?Q?jwAMk4x/02auVXkgoqGZF0IqqV2n8zbXCYlDQpBp0oXAfLMRpjqUXftI/3jv?=
 =?us-ascii?Q?6wDYxi0beaUUbGh6wJD+q1UVILB8QMpmOCwlay5ahgOKaClIJxHh9/h+ryO3?=
 =?us-ascii?Q?JvWCKYrx6W1KJySucHZv1xWlgKt0OK9x3Nu+Oorrri76l5qiLJnwcykpwZ71?=
 =?us-ascii?Q?WE295h64el2lrwqJBciGqS2GG1IHX00yZ3M5PtALmWmV5EzFhxUpBh3wtiV1?=
 =?us-ascii?Q?C3pr6ag4/A0HmJGmjTkOZXMIvDQIhP3VLjXD9mhiTDvhgLK//WaBk8es3cKe?=
 =?us-ascii?Q?bUuI4HLXrnz5/+uei9s=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013)(7142099003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 11:38:40.7205 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1a12ed2-07aa-4647-a09c-08de52984cbe
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB50.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF6D0742E7B
Received-SPF: permerror client-ip=2a01:111:f403:c111::9;
 envelope-from=skolothumtho@nvidia.com;
 helo=DM5PR21CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

The virtio_net_hdr_v1_hash layout changed in the Linux UAPI, replacing
the 32-bit hash_value field with two 16-bit fields, hash_value_lo and
hash_value_hi.

Update hash handling to populate the new fields correctly and adjust
offset and size calculations accordingly.

Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/net/virtio-net.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 317f1ad23b..512a7c02c9 100644
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


