Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A131C3DA64
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 07:35:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZQL9-0002RZ-0s; Thu, 01 Aug 2024 03:35:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <huangwenyuu@outlook.com>)
 id 1sZOY7-000670-Mm
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 01:40:27 -0400
Received: from mail-japaneastazolkn19010007.outbound.protection.outlook.com
 ([52.103.43.7] helo=TY3P286CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <huangwenyuu@outlook.com>)
 id 1sZOY5-0000Hn-TE
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 01:40:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y62ugUyAxXZsLI0Jc4F7M4y/euzDLOLCpJCNOaSlyl7xMw1q39XoX5C3+Hmdzmx28U6cYQ6mTUDAWWmOjDZ+IC0BK7SBrnYZEuqzhFc9o/j9MLDAb2BG+NSUVmsh6UOjJ1yCtiDKrluO1DwaJPPJDgk+U/T90U/VM1gQjqjUMiqy/jcdjl9793BXU4Eac3Qa0XWT5WiqgNGS1nEPY4DixRIr+kTwOVdBKF/ezqYPLvoc0IGl67EBMdEtmmHEobPIa8pxDHAYOSqpA2xxTwJGOBd0BKpm3IW9JYaMCWUq82AciOCUBGEqAGX/Q7qPnHWOMuXAkKmsDYiF1mQomZo7Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vui7lRF/9oAhPSfpV8XMH4Wv3GXoEOSQvGa+5vxowzU=;
 b=sb2I/LNutVNlHBkfgFHJunjr0hEO2oaOpooK4x/1n+FQnti9ICT8CJ4nInlOirngXzy3SwmNVOWQFgk+Yh2xGkZnlUdjgGheKftg4Ph54FnTl/XdYPFHYmNK56m4vHjPEz8zHxZgkhnLoc0aSgNrRoOjb61UojrVwjx19ClhvlhmrQ4y1svmzHtjO+zCTXq0F8J/Jgi8ToLMXjUdF3B7fT9zXfpJpuuCdHFVbZZqqD5fFhkD47lHfWXPi6R4QoLjwjEMMhU72QXxOwwbyVllnVnobIqH0EKjQmJAp4stcg4ieWQoFSW39f00ibG/QtjWHvusBOlKDHdvq+vLOF3SQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vui7lRF/9oAhPSfpV8XMH4Wv3GXoEOSQvGa+5vxowzU=;
 b=Cm3VOlUQCaobFfvzM0OTm1WRzM/LfPAUiaMW5Gh9tNXxVAQPGJANA3+Uro/+Bq6pDf+JFxWnhYgqhojV4VWrIKBsACiPdxN9N5gcQP04lx4GSaPQGy92b4lQ4A+6L4BBJLFHdO7mLMhOeCKe9UADna1EJPS8la0dWUnc3H78mthdfJqqCr2heMbIUYsRmdjzXEQB+YjUDO/rN4kMgfR8uTpDCcn4L7V5nBeHykf3vxqZWqBqOq0X+vvz+uY4/cXJg//xyOUdPHFxWrv+XJODkl9thDZMy4O5YTIk/P8zhn/8Y1y3HUKBdNpf2jW0v3aOj7uDB1KaYPxSlxi1hTf9jA==
Received: from TYBP286MB0365.JPNP286.PROD.OUTLOOK.COM (2603:1096:404:8022::15)
 by TY1P286MB3181.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:2e4::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Thu, 1 Aug
 2024 05:35:16 +0000
Received: from TYBP286MB0365.JPNP286.PROD.OUTLOOK.COM
 ([fe80::948f:9ea:14f6:1f5e]) by TYBP286MB0365.JPNP286.PROD.OUTLOOK.COM
 ([fe80::948f:9ea:14f6:1f5e%6]) with mapi id 15.20.7807.026; Thu, 1 Aug 2024
 05:35:16 +0000
From: Wenyu Huang <huangwenyuu@outlook.com>
To: mst@redhat.com,
	qemu-devel@nongnu.org
Cc: huangwenyuu@outlook.com
Subject: [PATCH] Cleanup: rename virtio_split_packed_update_used_idx
Date: Thu,  1 Aug 2024 01:35:12 -0400
Message-ID: <TYBP286MB036536B9015994AA5F3E4495ACB22@TYBP286MB0365.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [1CTvf/sxOZY9sH7Hnaa4I6NWQyu2ZyhR]
X-ClientProxiedBy: SI1PR02CA0034.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::10) To TYBP286MB0365.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:8022::15)
X-Microsoft-Original-Message-ID: <20240801053512.25778-1-huangwenyuu@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYBP286MB0365:EE_|TY1P286MB3181:EE_
X-MS-Office365-Filtering-Correlation-Id: 89bbbd4f-3190-4bb9-f8d5-08dcb1ebb8f7
X-MS-Exchange-SLBlob-MailProps: Cq7lScuPrnpXB0xcNeDVdJIgd0h0Wm5onx2dxdB74NOio1nCkB3wnBMb4nwPtDJVsgcPYrzem1xBM8/mncG5kq5fU4n8GO72/7+1paEyfqlBoRFr33TXjGpX4YuZezlKvAAe1fsDhdxBzYlSs0UiW9YfQk2vmcxXOuuVp99L2jbxFGz7zmyzDlsMiIpyjjn4VurBY9gM/2ATqyLskcpjeB9aTYcU9gv6ytnkxdCXONt7VtuVc82E7/NZgPaWj8h7Wye8e01S1y4myZb4F5h8Wzj/ZAAwVJ1mZ43u1Xc4Gg7/SU27rTE3dJJ35W5KKD1iEDrJVIOvN82obDcEjL6eaznlei75Kh35lXrp4OUare77X/HtFXhRSwPiDREr1gfhdXPgfos04+28oySAkAANEz0taRcE8W+/LX0t8A+wtPnuL4HI4L15Rm8tw856HfBCydU7d5dl/L8lSLtIir0r3LinncuVXsA4r96QViNm3gmhB1voVN9FskxtYeTMOj7pON7DKHHwICWZr29ZwWiwENF/sZxB1N3LyWvCQ+pDB/uLqNNqFuFuK0HN1bCXt0gi7welWOQqX8hrlQe2QJU/HkvZk+kwzNyua/aZ6p9gBkRENdiVUV5TpitjvBoj7SPfmgSwY64PiFTeUaA6Z8BpjmRyyxthc+jpDk/kKNcPNXy99CKTWQoWbJM60QQH9xGyflxMi/ZsH9rYsDPLFRCGy+RznyUqReo5ddr9t8LZHiv00XC1NO0H1J8A0hxAcTZfSpPK6Qy8aEE=
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|461199028|5072599009|8060799006|19110799003|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info: qk7+xqizqxwzvRt8+e0wFwDlE9EUYKPf5tHFGcw/eZ6P2CjHG6sdk9pkKfbmdWIEP+VZR29h8JgSc3/VhLoV30k15CYlM+nsWxXhrTIm9lFOFHBSJMZ7Mz8DjoaUozUOPp2KsvHbafEYoUYGa+qT5isZ3mOp4bXz9lHHH/NF8gu+7hR48caDAtd8X8zlaN5cURPkU04ESHHHVUTDte7UE3jpNNKqVzhphSI711OAcpI7V1MHJTAcs8tUQZn7kh4S+1Kfzwb9tqynKGtd6WJUahxPZ9P/QV76P5IQp/nX+jaQz1OLPCbVnkmpGhN2XNSaWgj6Ab3D0KknzMxor1wq0HvG43QB/KjjlOCUm3wR0/nlL1tMzdlU+pJID/j3MlNuiV0MQPX9ms+MPeYPoByu2gU/YfNXTjcyxXfnKCXUuPehspi2CZMV2DD/MopPrQeGFd/ThsvnQI5E9u9mKCpUVsD5/QBv4vETxISew4m6+gQ7DBH39epUMz5kzAaa3XLMaDTV/yBJcRu0RaMO0kTCsn4nr/cZwlm5IfsPPPM3sr8RTKPiM+Dr2DOOCl+eN1Bz6FpyOtZDbcmYtBFzfQ1NF7LVGJxJSKNVM/bgxNMgtO+2MqX0+ZqdG+8pVmDKgXe/+mCMjSB0CWvXmYP1vEnjGsewodrpRr3lbb14pt7IobmX6JiRbnyZY9CPjjgfObWirMtOlCkvC0RmaEbmWy4Cyw==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TTFC3H836CScOEXKKphyXFVwN5gM6ijuIzej7eC5lBIgnYlWDPkPIYArHu1c?=
 =?us-ascii?Q?Q1zjuj7VU0S5F3tLVR8TUz3WnyekuUmFLERYNHNO2F/aeaJC23wC1vMPXBuL?=
 =?us-ascii?Q?7PxQ4PDYb0bFOILx3MjhzGoVdCVT0NUUVwz39j4OLAUOUa7zQPJrdO7vSxz2?=
 =?us-ascii?Q?CZq7n/UzIM8DSYi8dLCASwx7R+SeC97T9Wf059hsoQZ9MIhVjncudPySCFD5?=
 =?us-ascii?Q?tESxWBRR4hnnFPHnIoYAP6GTKRVEsDGyqaEcLrDPO3VuzVvr7kYmXkpf3d22?=
 =?us-ascii?Q?kHobNEhwWiZl/6StuG3/32hvM9tC8cqOdhCsCCZ+R903xaO43b6VSm3tXfdO?=
 =?us-ascii?Q?p2l9TDxJQESu74FUrRxmEyl+Xk3JDkKu0x/Ua2/HIE4jtny79bdnBUWBTc4J?=
 =?us-ascii?Q?852hlMQeL4ZJE9Mh3R9Oyui3ASLrbEO+Ev/eWzle4VxMooFjFlnPfvFMjLy6?=
 =?us-ascii?Q?XCRZhW9fjtaD6/1+bwzrXqWhaKS4zmpESYSf4Kt7FsZ9xj8mYwQ7rCav8QCI?=
 =?us-ascii?Q?vD8WP0z9bPfVGIJOf7vY5o+CBeSjFEYm/Mvo3HBGiLn+lpmB/sOkFkf+h666?=
 =?us-ascii?Q?0y19pOitONUv90ZY6U/9oMVb79QUAnx4lZ/CIWDm78e+5/e4tdkx1OPybf5d?=
 =?us-ascii?Q?i2trJmPoM2uIBq8B3QcMxxhtT4yFMyeAYFStVQspWJh58uVJzls91I/WUD6f?=
 =?us-ascii?Q?FOL/+tFjbtn4eR47mmSuUeazc/lUS1a2v/ji402mSVmlGM0h67k8Xi7Sdbaw?=
 =?us-ascii?Q?rujXuKcZr6DQSLmnVbVpzGoWPNwbUKH0EVWnmksNzFqbcIFQ21Kl1TARtHuz?=
 =?us-ascii?Q?mYjI4Zk4Iocq1dUKk3xBglt/knecL6NDGNGwwJPPUyKyFb5KCkpP2zSPZWE4?=
 =?us-ascii?Q?Px3NP4WrCxEa83w9+3Yf3D4tyr45/StdXyU2FUGuzL3EENsS+rB59hM4aTb2?=
 =?us-ascii?Q?Nf4FLPxhPCmRIwuB2TWXIxCc3xSyAKvn5hR0g0TM1mFOroOJ9uZgWNcGhxi+?=
 =?us-ascii?Q?15As4yxXfFr1dAaTljbBDl6Gmt2dOqhomY2zCA+C8/gKROoRVZT0W5iKYouS?=
 =?us-ascii?Q?UTzbXqTZ9K8gjZkeoY7RjP7NMbkUrFTdXsL+8vJkZcz/QDM9GoKs1gnDBa9F?=
 =?us-ascii?Q?8Z5MeCJfuf2GPtIQmBHWPrX8nJ2o+SsX6a0w3tVRuMLV0rrCKKgytcjdFaeh?=
 =?us-ascii?Q?QnGpgIh5NXAYXN1Wru6G+0BtqwQk/xL+cEbkP8bR21ozqjnZ5KZT0Mh3ZI0u?=
 =?us-ascii?Q?B8QTAblNspVy9YNsOSOn?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89bbbd4f-3190-4bb9-f8d5-08dcb1ebb8f7
X-MS-Exchange-CrossTenant-AuthSource: TYBP286MB0365.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 05:35:16.2581 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1P286MB3181
Received-SPF: pass client-ip=52.103.43.7; envelope-from=huangwenyuu@outlook.com;
 helo=TY3P286CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 01 Aug 2024 03:35:07 -0400
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

virtio_split_packed_update_used_idx should be
virtio_queue_split_update_used_idx like
virtio_split_packed_update_used_idx.

Signed-off-by: Wenyu Huang <huangwenyuu@outlook.com>
---
 hw/virtio/virtio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 397c261c3c..5836f680f0 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -3609,7 +3609,7 @@ static void virtio_queue_packed_update_used_idx(VirtIODevice *vdev, int n)
     return;
 }
 
-static void virtio_split_packed_update_used_idx(VirtIODevice *vdev, int n)
+static void virtio_queue_split_update_used_idx(VirtIODevice *vdev, int n)
 {
     RCU_READ_LOCK_GUARD();
     if (vdev->vq[n].vring.desc) {
@@ -3622,7 +3622,7 @@ void virtio_queue_update_used_idx(VirtIODevice *vdev, int n)
     if (virtio_vdev_has_feature(vdev, VIRTIO_F_RING_PACKED)) {
         return virtio_queue_packed_update_used_idx(vdev, n);
     } else {
-        return virtio_split_packed_update_used_idx(vdev, n);
+        return virtio_queue_split_update_used_idx(vdev, n);
     }
 }
 
-- 
2.43.0


