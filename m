Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43273C67861
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2024 13:20:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsjUf-0001Wf-G2; Fri, 05 Apr 2024 09:20:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wafer@jaguarmicro.com>)
 id 1rsjUa-0001Tw-8M
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 09:20:28 -0400
Received: from mail-eastasiaazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c400::3] helo=HK3PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wafer@jaguarmicro.com>)
 id 1rsjUV-0003u8-Rk
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 09:20:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yiz/QQuc5aEEdnIP0AmvpK5otYuFeH+v7x/g1XRJJxxP983Rnqj16SyiVZERAzoCCWGfJ/6Jq3FjsO//GhzwmRhWCN6o1cEKQ3De59E74+2B7iA+Q2gJzLH+J/PXoL9R7f5YYX82apeMTux9oAReEEa0ob0/nWlUTjwgfpjlzkWijhgCAACQmZqsxEniBaZ70GQEekuoCxXjP5FoHIaCn6WlccBf78ZA6mgTi7brqDJ2uF8tMKe145p7d/TMNnLlHqx+q1+sqCI0w539X99zLGLY10RMo2fvIOjgIS65rtt/v1ADD/lOw9diCjSxKPLOsqZb7w9cjmlrEVl6UQqWig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LLpu1HEQUusPupyDoAJ7vNOc3peRxHNF57tI4ntavvM=;
 b=nwsEZanIf8ac/G29j+XxsDozeOczCz0dgSQuAb1pMim/ovE6NBBJAQoftHselFrzMsaudodcOCFnCPN6ur64M+pnDT8Lz37HOdFmdaspfmzDIKSDC0gy+5djt8snKgjeYha63rMOQPzc9DZwNtxGJD9UFCB095yHTJxIfz/oN3MfaDKBPjs2JCp2qBxZl0c8IevSpcTboNcduRl34WmNE+tFQI1WB30Sc9jpNcX/Zz2kOHBgqjt9m9UPsXgtTFt5gvch1g6KREfrVwxEkzZ5wcD8G2X3JmaFtW4TosYD+/7nJjO6o1YCPDcKflUZglLe7BsGBFQStnQlqyj/Qn6OsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LLpu1HEQUusPupyDoAJ7vNOc3peRxHNF57tI4ntavvM=;
 b=SReuEGXKFOEjoDTslCk/Di7m3jhj0O8LhclqgSc1JOmwjHa9ylc1RJyScwq36WhcE1EFLcqukPy5AfvlGqHxGwKlraeVJXAXzH065vabs42zYBnAUVbNpowofRmo4/WnhmCIoSapnWXyQTXfFYmetg2OChP0T5gB8U+F6NE4DQea8csc47nlB753WCtbEIAUZMyGTKCkaXf4gWZ6eqgP0os9hqRwFyyyFy4lDTz8BldTcBdiXNqmjg48okG1nSE+X6VnvzwOgbXFqeJRu8qmdE79H9tkYpDjYSkn8K99r/xBBVqiDav75WanQdmKHcQP45MeKJ5v0AtLmCpSdUNJ1g==
Received: from PUZPR06MB4713.apcprd06.prod.outlook.com (2603:1096:301:b4::10)
 by SEYPR06MB6930.apcprd06.prod.outlook.com (2603:1096:101:1e1::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 5 Apr
 2024 13:20:15 +0000
Received: from PUZPR06MB4713.apcprd06.prod.outlook.com
 ([fe80::807:eccb:cfd5:e6b5]) by PUZPR06MB4713.apcprd06.prod.outlook.com
 ([fe80::807:eccb:cfd5:e6b5%3]) with mapi id 15.20.7409.042; Fri, 5 Apr 2024
 13:20:15 +0000
From: Wafer <wafer@jaguarmicro.com>
To: eperezma@redhat.com,
	mst@redhat.com,
	jasowang@redhat.com
Cc: qemu-devel@nongnu.org, jonah.palmer@oracle.com, leiyang@redhat.com,
 angus.chen@jaguarmicro.com, Wafer <wafer@jaguarmicro.com>
Subject: [PATCH v3] hw/virtio: Fix packed virtqueue flush used_idx
Date: Fri,  5 Apr 2024 21:19:45 +0800
Message-Id: <20240405131945.6091-2-wafer@jaguarmicro.com>
X-Mailer: git-send-email 2.27.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0187.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::12) To PUZPR06MB4713.apcprd06.prod.outlook.com
 (2603:1096:301:b4::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB4713:EE_|SEYPR06MB6930:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MOnr/DzS7xfcJSLhJyHrPGvS82eA/18i8lFer9J3Ibv1UdnmAD7jkbXCqCF9+nBifq/uGN7DqtdhLi2/gQuDwpEnVA/xfjLVYbqjASjAq5o1y/Qrk23JahlIf5vdbFfwxgnEdHT4bgXFzyoNVPB4IOQuYTAeAzpHP3Vd/iERhsa81id97pzOF9YQR+u/6MLo2lEiPSsPaRsu2j6CitEyUTwUjubfU707DtZ/fqMWgq7n2HnAhsVsJ7/itG6v3LaNeRan/CPNEk8tJ4m0jMXGievAJHPq7LQr9GL6VJSfK0Aa8wC8HAgJoSfrVDGs6X2JKaosZSp7rmL8tPxfxGnv7jPensKk5hYSwqhZ/GxFc2sI3tG/cNv/Fsb3/jTBisNaCUsINgC4/dZqyTh1+DCh+vSnjFVNBHdMvwCgc8ZV25xTVDQVnW/6vjfA6iXSotjAnK4SAtCnAdnduXGwYBTK4+y67QbTdqjkj8j0cz8268Ss147rrtNHunZfuYwgjNdW1uYVzPmea60sQ7wLm705ZhBBnCsEfviwR9Nez/TgaZabyhYOz7n1aVWDFXTQFPQBHpjG71k8F9+Ekz1R/O7Ak/76t754xXP7SM9ocbIwnLYVuqrMmrCTh0wO1YyOjFuYB25jyevkogf668eqOuZTowyrygGP0MsNlql4sj2az4meCoPUL500IHkGbG/rQeo8Ui68knZbZ7/d2cVsapotemFSjwHtTK9Y9hSUPBt7hbA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PUZPR06MB4713.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(52116005)(38350700005); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/ZbJvttclUUgW7J/OXZmCq3PaeY04PkQuLV1Ib/FMM+ttwqNFh392cffV/cZ?=
 =?us-ascii?Q?CBwTIIIIO4Pf7HDPnIW8XwPhAuh57wDA1warNgRYua6xJwganyVkwG6t4gnM?=
 =?us-ascii?Q?NXyNQlE7r4pLpaGVM395vZnjUlcwLtQWq8Y9iOl2Z0Njr/ZirORROCREyFhf?=
 =?us-ascii?Q?1TgKnxnlaufXLCF1KLMifpqOST2o+Jx3SiWpcescJs5wh7F7PDjube9fi8DK?=
 =?us-ascii?Q?ICBiW82H6twuEnGdZUrYtxjtFZBk0nuLLbBvI1ANsXqg8uhzK08os/73CozF?=
 =?us-ascii?Q?+EnUqqpFcienZ6OxnTvvFv10tBmTI/hi6Fq/GhVjh7p+9tQN6AwbNmjSZfXV?=
 =?us-ascii?Q?mobvUYIXrsf5B44syFStG6dgedzZyyvKoFlownityH0ZPeKNqYD34K4HfF1b?=
 =?us-ascii?Q?UjmZlolgL1Kw/je0MgTwnuC725gcVV11MxrVeLZ2Ig3Te2pW8uVYbkdnyi5c?=
 =?us-ascii?Q?CymUPhd2QK2WsdyxoMP1RcA9E7mHevS+QSsKfX5Ycv8ttHQCNIw7ZGXrJYUd?=
 =?us-ascii?Q?LxKeJtKdvcsBtdL7CBOsDBgk4AR5cv1MhgFOQ9RBudzC4LMk8MDUxeb0Ac/P?=
 =?us-ascii?Q?SmbNLAUmB7ajGgDO3KoSR+Eh67O6ifVXtxjVapr+McZdDPhQe1sprykXdViO?=
 =?us-ascii?Q?OdQi9ihHkYMzD7SUOlq2jAtc/re5He0LECOwdwMQ2qQDWjR8n3c2nQyD3ssu?=
 =?us-ascii?Q?lEtsZqPSgQmzjq8iup83qIVneMtHhQsbq6OEsF52QytgIbgrKUedFesihboL?=
 =?us-ascii?Q?OhqN6+nPd7CKhvjgRbaEr6CWjzKjzsI94jhqfCz9SmXjQa16KN3blF+LNKUi?=
 =?us-ascii?Q?VmW3ZBwHJseMfalV94FjnxBdxZ9zeX+4wJwtKctvEkQoeNcwRbGYMYTcFrnv?=
 =?us-ascii?Q?WwxdZQTXnH2Bd2BjK0xLqg4VIDOu++FoqlGgFt8tgJD4X05CAPfkPLPy+7TS?=
 =?us-ascii?Q?AeOOTeJ+HwoSxb6GvX+ZX7zhCP16XSAuKL/AHYsIbrRQ5WbZG1tPNEVi3RjQ?=
 =?us-ascii?Q?Iono8E2Q5AOaY3Z4JtBmMKjlxL27pyWbBo3NrxB/VpVuUHkbQ5m7u9Qpn7pc?=
 =?us-ascii?Q?qmoVOPFxFzX94PZX/geOYh41c6zr+ZsdeS8DLdaszlNXjE8NuUjwuNyn1dZC?=
 =?us-ascii?Q?Mj362QVP3JPTA10XGxEIaJrmouyTtS+1dfw8eFkUeZMS1Ej7W6teoFo9U+Y+?=
 =?us-ascii?Q?lRokduJMP8u05nmKl4HOqoHrh59fsw2WoYMlRi7NkdOVVBaR/2RjzBpS4zfq?=
 =?us-ascii?Q?w9pBNmAz5ASA9+OC8uxNa4I5hFk0lItc9a7CEUNzNfxeGYKNPBRx11RWNJ+9?=
 =?us-ascii?Q?CPsRJlSIXLv9ZK632ap5LmYDmpNGLIgMBiKZZScFfm+7b4tykoTHSDDYd505?=
 =?us-ascii?Q?PXzyTDJfcujBDV+NGr0D0xYqgprJxxpduc0NCXDP82kwBnXNJcJ+T/5RNFKo?=
 =?us-ascii?Q?ntCfOEWi6r89KmA2qzzOHcCMvhd7IlBZo4j/siwa1G77GChv5Ja/q6OfG6/J?=
 =?us-ascii?Q?t7jAfTT5EbAUGOWRHJfB8hHWCpKMZ8OJo1QC5YSK+HsLV+E/AD4mSigqEWul?=
 =?us-ascii?Q?wgray4zapW4LzGQomewlzJ64DRYVfXutW6zFMuVz?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd1f33d0-8807-4bdd-5aa7-08dc557321a1
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4713.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2024 13:20:15.6228 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h1ZC9ov0k8KYgWVsVzKJOqOkdAsGqaRzs+tm8683q86ZebQGxwVYQWnFZcis7TKP2xt9i/OIMnSlkJQ6+H5jbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6930
Received-SPF: pass client-ip=2a01:111:f403:c400::3;
 envelope-from=wafer@jaguarmicro.com;
 helo=HK3PR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

If a virtio-net device has the VIRTIO_NET_F_MRG_RXBUF feature
but not the VIRTIO_RING_F_INDIRECT_DESC feature,
'VirtIONetQueue->rx_vq' will use the merge feature
to store data in multiple 'elems'.
The 'num_buffers' in the virtio header indicates how many elements are merged.
If the value of 'num_buffers' is greater than 1,
all the merged elements will be filled into the descriptor ring.
The 'idx' of the elements should be the value of 'vq->used_idx' plus 'ndescs'.

Fixes: 86044b24e8 ("virtio: basic packed virtqueue support")
Signed-off-by: Wafer <wafer@jaguarmicro.com>

---
Changes in v3:
  - Add the commit-ID of the introduced problem in commit message;

Changes in v2:
  - Clarify more in commit message;
---
 hw/virtio/virtio.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index fb6b4ccd83..cab5832cac 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -957,12 +957,20 @@ static void virtqueue_packed_flush(VirtQueue *vq, unsigned int count)
         return;
     }
 
+    /*
+     * For indirect element's 'ndescs' is 1.
+     * For all other elemment's 'ndescs' is the
+     * number of descriptors chained by NEXT (as set in virtqueue_packed_pop).
+     * So When the 'elem' be filled into the descriptor ring,
+     * The 'idx' of this 'elem' shall be
+     * the value of 'vq->used_idx' plus the 'ndescs'.
+     */
+    ndescs += vq->used_elems[0].ndescs;
     for (i = 1; i < count; i++) {
-        virtqueue_packed_fill_desc(vq, &vq->used_elems[i], i, false);
+        virtqueue_packed_fill_desc(vq, &vq->used_elems[i], ndescs, false);
         ndescs += vq->used_elems[i].ndescs;
     }
     virtqueue_packed_fill_desc(vq, &vq->used_elems[0], 0, true);
-    ndescs += vq->used_elems[0].ndescs;
 
     vq->inuse -= ndescs;
     vq->used_idx += ndescs;
-- 
2.27.0


