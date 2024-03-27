Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74BA0C47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 06:21:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpMdo-0005q2-M9; Wed, 27 Mar 2024 02:20:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wafer@jaguarmicro.com>)
 id 1rpMdk-0005pY-Us
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 02:20:01 -0400
Received: from mail-psaapc01on2132.outbound.protection.outlook.com
 ([40.107.255.132] helo=APC01-PSA-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wafer@jaguarmicro.com>)
 id 1rpMdg-0007gs-V8
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 02:20:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=auk5BsfkkWxwuUx+MoTJoQ9aig2ErkbJAnVO8wbKnxboe4/kHatLwNhg6ITPlqH/N8+IT1Jm8blLpTL7denWi7jyTsxdoc0ceq7YF33I7SRmA0z0XnbLumjOfObkFtfwkNi2yH/7HMyBFPQNEH8acBaGOKQr5UzZEOCEidqo3MMA24aoWc8/HLo68ZBUAYZPdM2pIPgWWD6tSplrDe6CJzAQSShu1Tl0GAgYqyIJOoyugaFOxW08+mPEpM7lcQQrdL4PCF4/NyDvbkYtNvPWoUIlj8v2l7XfLqSHsRrNof0iUXaYgcvQt7VzUgYnAVBZImPs8NcI6I3RAeW/aQas+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7AFncNqpKvyoQYp/BcawpJ3hSkH1KSPDCTVoEd8xusA=;
 b=cXZeCROmtmHzei8vYgRtvSvJa0VXDyEpT+KTlvoApHX0P2SqJFDOsShUSqbGuF2kGkTLQ10cTvf7YBeFdMvCMHSxTFHxHWgSTJ0/VsNfgoi4bTxgART2fdOlSprld6Jw72+vLoaR5qRScNxxxS1zMKQV4h/Trjc1nfo5wKkFPHlbctmwXnMAOJJSoRNLZfYp7Q0VA6bXzislASdk6JjW+lveudoj2tvRyFhVPyeojaiKET987+VuRE04XKGILgR3KmL1n8xwtlvOhMXRKyAr2Qx7S+7WQmMLSBNzJTE+v04Ap8ZsXQVvXbz0k/GDXdM60WQbCG1Lyph4lTC1Zed0cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7AFncNqpKvyoQYp/BcawpJ3hSkH1KSPDCTVoEd8xusA=;
 b=F7gHR/7RyKEKo/X3kFRJ+DLpMYfny3+1JxGD4mCRcjrPeA7yCp4sc7t/XcvrezjhmD+SlKlRts3g8dJGieRkZdTSddvfr9MJbS7jOWgV4f4CyMbBAhsdQeuW4ZyFjsgLkTADhAjwQS4ZtYZFtlg9HsUCqosL+bXrzPKre9DWaV4DAM1S+MAQnp+kgf0egixdh3qgNYEaq4hbKDZp3y/2aza3yqKnH+BKAvP2dDr3HpHTk/fo4x5TgHtjhlaBlrnek6kNqJaXs1sOx6sZgoL39X6meWjMiHFpXXfgk0ZzN2PVHEFpp+HTlHjkp3WTfgSbzlxp1HBE5byw8s1rxRL8Tw==
Received: from PUZPR06MB4713.apcprd06.prod.outlook.com (2603:1096:301:b4::10)
 by PUZPR06MB5904.apcprd06.prod.outlook.com (2603:1096:301:113::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Wed, 27 Mar
 2024 06:14:46 +0000
Received: from PUZPR06MB4713.apcprd06.prod.outlook.com
 ([fe80::807:eccb:cfd5:e6b5]) by PUZPR06MB4713.apcprd06.prod.outlook.com
 ([fe80::807:eccb:cfd5:e6b5%3]) with mapi id 15.20.7409.031; Wed, 27 Mar 2024
 06:14:45 +0000
From: Wafer <wafer@jaguarmicro.com>
To: mst@redhat.com
Cc: qemu-devel@nongnu.org, angus.chen@jaguarmicro.com,
 Wafer <wafer@jaguarmicro.com>
Subject: [PATCH] hw/virtio: Fix packed virtqueue flush used_idx
Date: Wed, 27 Mar 2024 14:15:18 +0800
Message-Id: <20240327061518.13200-1-wafer@jaguarmicro.com>
X-Mailer: git-send-email 2.27.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0044.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::8) To PUZPR06MB4713.apcprd06.prod.outlook.com
 (2603:1096:301:b4::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB4713:EE_|PUZPR06MB5904:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u6spOka21dHCtrvLRLX+lw8ahbS2+5oy10OmtzgU6iKwUTK4Mcb/G486YqzMwQ60rycQp0yjbRLlDjgxvEV9oH6vybyy/EZYw8riGzAyzg9s2d7KCVPHmeHTsUkSyuz8vS+ZjegtMzS9hWUqSy/8YTBGdByDjLKm0O6EB3meHXcWqM2D2KxsU2oLSLMMtUzbBlNKUqyjs9i4AtQ/V2ScqzhOw8xJLbqWCt+c8vGUP5QUgGtknd0KopMUfM4evUARpVSnBx6/Z6rFIUfrtHbNmDA1EOCbYwfio8Uzj0S/1hDp5Gutv/v1Gi9Ko+iuz1ojr5yHPOlob3+A862d5Zm/0+UbWzV+sxk43j3QLLo5lw2y+2ja4RzhAtECFWprKc2DA5mcz8XonVRK3hIyJHrvc8ofaClAvZcpd2nTO1LCvmClEttlFtBNc1vO3BvVgrtaxCwS4dorcbYODqN/74NO6E4IblSG6bRVEU5Hma7aRBex7udPG/xORNe5bvGOWfZmmHAIESgnayRTmLXcf/67P6E7x0J3yy+eoxRc/tI/0ck+i5KBBuV9QxY0RGEpUCRb8NXzWx3Zcp4Acx7YucDzB6Ghwo/CbiA5kiUtpK/DkOgQJ1HEZXA6JVM6lJtQ7kj33VJ1HVOSygfL5o7/ZjOifUjBtAo0ErqmJLGKgZAt64R4sVQeNC2e/PaihiAnI8F4JZzBVTyDtneQqG+Sq18d+w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PUZPR06MB4713.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(52116005)(1800799015)(38350700005); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9Bti1fQhA1xFCsFmLlsQEQMgFTpqOR9VXHglVlnAfTQ0Xxyfr0k5mAOOCXMM?=
 =?us-ascii?Q?0miE9dl2ar3eQb6WccvO3J+6ccWRjV3g8RTLkV5n0B2tKlCG0eUfguaOIA1c?=
 =?us-ascii?Q?srUspq9lMT74LzZW4fU08bfczKdp9P7LsGVB1Iuxn3YtNgv8Zl8KbtmnKt0S?=
 =?us-ascii?Q?M1YCfyXnh3ABKQDm0nclJsmkal1F+cAXIydTD6XVdxcsL8c7OqEmEz0g4+ML?=
 =?us-ascii?Q?9e8jS7uT1aoeDHuRqA3jOIlv+1Cf6hCRCc/6LDryhlldsY4ghdG4Z0IMyNEh?=
 =?us-ascii?Q?UB3L1SFcM67tFHYzmMiS2EsJgrc5WnCBI3AqbIbq3Q1fzfhxVQRZONCu75T4?=
 =?us-ascii?Q?kvek9stRcu+ToVIUP8f2VNVSvDgs6Z/hP/hKYtU4a8qQHwXjS2+zfy5jWpqq?=
 =?us-ascii?Q?Gam3Wy9LYPl5H+Y1EOr1SFyfQJlqLDXcEmK26I/t6xyMQX+759bkKSJAL7VN?=
 =?us-ascii?Q?o9HLrttx1GOV6MiHNgFT8NtTT5HkJdcXMz94iDwCKRm3CqrMB1axb8HSIa31?=
 =?us-ascii?Q?tLYPHpFr7JVk/bybiofThxcGTAa+JotK0Z9gdikNRr4ashzK4cAOv9ETqoX9?=
 =?us-ascii?Q?52diZiUbiBQtj/QUWCD8SGiUGI6We3ZbRlDLhAxjfUHQCW8s+e0XCgtsuXSc?=
 =?us-ascii?Q?5XCojs6RewT6ovz9qGIPdnWCT2CcDXhh73e2crkAV4gVZK9qEyWM684VZFif?=
 =?us-ascii?Q?50wH70nuprS69qWmu23TkDE1zPjdjoV89VImsj8PUxuDeFEFr41KJjhKWTOG?=
 =?us-ascii?Q?i4FRPyO5hqmn2j4x5X/NCdN9cF2XumW9brJTVZonsV2h7laXMw+jw8faR5pV?=
 =?us-ascii?Q?4azbuYiJCiJl82Z6GqUzcZ/GpnV+8RrwLvtx6DtMdmsT18KM8BRYQjlYt38e?=
 =?us-ascii?Q?EdE4ALLvvVGbM5c6u0GIvb5bHyGLQvDooelrUApSu5rOdBXvANy+HiQrhKQi?=
 =?us-ascii?Q?6MYaf2XgE8quREOpsT0Z9hD9OtCWZcFQj85wl/L4+0NzfdUBMrWoxkaDtGjP?=
 =?us-ascii?Q?qaafno1/2drBk5MNuz4fXZyKlkUvXPrQg9j2ZdMS+uq5GpeHgXRNjYiIyCgR?=
 =?us-ascii?Q?0XIiByjcF/RJ9vAupIO5KcjkMw87kB9T77uaREBXfl4Fcf4lLa9lYOgutQYb?=
 =?us-ascii?Q?dKFGBfMKHeMgpeeYMKphMmidn//JJASyPb841MylJO8qgjm8Wpy7n1YOYQvl?=
 =?us-ascii?Q?gYZEtD4N5o2QFFIA5OqBQSxciUdVP7Ff3yI1xZ1GLNFZ30z+AF42ceLhMwKO?=
 =?us-ascii?Q?lAzg97pa1zlT7ZthqINd+dvOdSvgmjaR7sfJvTU8Z2zLEk9/3nSWr6HSODMg?=
 =?us-ascii?Q?Em4EQi/LBQZnhHZBBPjYEym3OwDIyAlRSS66AOwJI31kipBfxnxZeKlHT339?=
 =?us-ascii?Q?ZnC/pGBqaGf+lz5Ufs3MzboUziRTpNU22jUL8P1cx8i+QVboro7Ic5qDMa6G?=
 =?us-ascii?Q?9is342Uivbi4s+tkVF0WL8OTasXMWgJfgxqgCB7ezKH7Dzdt1F3DHPw1NJRb?=
 =?us-ascii?Q?bw7On9OF84EVIa+qYsRWjw5HiJQwM/dhX/hB6wQuyOgIpl1x7oafFzcxDl04?=
 =?us-ascii?Q?J4NFhJN7R5JDDk0Cpdg38K5Zi48Raolvi9d88P/9?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b38dca89-c74f-4d52-a36b-08dc4e2532fe
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4713.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2024 06:14:45.8289 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zqbCTgsIMe9gtYTujeFhzPZUvoInvFMp8C1g1vzQP8e36fKRZCfrP+xvPi9Nh9jWWavXsu/KK9CRW2gNt5SXog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5904
Received-SPF: pass client-ip=40.107.255.132;
 envelope-from=wafer@jaguarmicro.com;
 helo=APC01-PSA-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
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

For indirect descriptors the elelm->ndescs was one,
For direct descriptors the elele->ndesc was the numbe of entries.
elem->ndescs = (desc_cache == &indirect_desc_cache) ? 1 : elem_entries;

When flushing multiple elemes,
the used_idx should be added to all the privious numeric entry value.

Signed-off-by: Wafer <wafer@jaguarmicro.com>
---
 hw/virtio/virtio.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index d229755eae..44f1d2fcfc 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -957,12 +957,17 @@ static void virtqueue_packed_flush(VirtQueue *vq, unsigned int count)
         return;
     }
 
+    /*
+     * When the descriptor's flag was 'INDIRECT', the value of 'ndescs' is one.
+     * When the descriptor's flag was 'chain', the value of 'ndescs'
+     * is the number of entries.
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


