Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F617CCF9EB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 12:57:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE5ib-0006E3-IL; Wed, 29 Oct 2025 08:56:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wafer@jaguarmicro.com>)
 id 1vE5iY-0006CR-71
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 08:55:59 -0400
Received: from mail-japaneastazon11022095.outbound.protection.outlook.com
 ([52.101.126.95] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wafer@jaguarmicro.com>)
 id 1vE5iM-0004Ob-Ik
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 08:55:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IMxcWCZVKO5CPwAUD99Nwv5QZKAzoQgLAdOgKfXwH429ADjVCa74N6kwRdryTlTt2JoM4v35jxYnn+Xwk+/KS4p7el77XloKnfPwHDUuxPweVC07Z95t9kVs06ITASZv19Qg1Ss07GldG2I182harXSbAcPCc6paofm56S0hwZlTwOyhRGMfd6IlyVKW4mQ4lADD6u6O+k6daJItyRHZdI6anTdpvP/Pq8xgR2kuXHSTkJMAivg4Etfu1AKOthv1XljjIww3W4BcwnB/dj4qsW4M5pTHIwt5aDi99y9XWCVry6MUj3SHqhdGmCheodsY7n1gOv9mdxSrqfAw6eGbgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A+bOglag1LxYyWCf5oe2swxsbmzBWE0DnEEbjJ4MnX8=;
 b=tz0hP7QESjcGOZsJjO24uFLZN+t+U3WdyZtxK1ftjS5tzjaYQvhXbXInCJRgFtV25DPrmFrTqzYrwEudD8eD+PE7VLxfiYgLsTQuzNqe8sm32bL31a2ljvvsOftKg+teO5KloS3Ntb+6bhahtLI5z8Y4rIrtxMTk22HfThGiNka9CjtLkc20cVJJmZzKN9z5PcVa/UgVRtO5SP8UqtkpvZpQI/xncn+pdPXOLRdo0aF8FZL4Dn/NicMRQ3TgZLR35ZmQkFUdhYh9/wW6htbY+Z+52niiMrPGoiLc5yuoXm3J9lKX1oqC6hm+5OFqQYt7HOTXQbkugJtJICTbcirTHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A+bOglag1LxYyWCf5oe2swxsbmzBWE0DnEEbjJ4MnX8=;
 b=mJfbWSnO7K+FmvLxaIkjsOFw2ZkH8YRlxuuzTVTyQWnLTtAQDLRWlgyaxCZGgKV26VbVhDhjBlevsBRm1svgswOVomj6KOu1hWfiDYmF7zIQkLd/s1OTJgcEXpLi2f4UDkvdt+UB/uXGZb7D2KkRJ+a3HBGEMf9TP3XbPVZX/V1K6826yc8NiBw+sppuLnUdizx+SxfavDBFxdpVLWn6q1WQHoeDVc7+oyFzaP8ShMJy3O7/o7BcdboqBusdw45tzI3Vq/CZDiEjmrdAcE2WtZhJcrYkPdYs/9i/EclMv+DZb/TxYBGqad0bI9YbJwfz+BFvG2IBICk38eB7zN+yag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from PUZPR06MB4713.apcprd06.prod.outlook.com (2603:1096:301:b4::10)
 by JH0PR06MB6414.apcprd06.prod.outlook.com (2603:1096:990:10::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Wed, 29 Oct
 2025 12:50:31 +0000
Received: from PUZPR06MB4713.apcprd06.prod.outlook.com
 ([fe80::1b36:28b0:4e5:de66]) by PUZPR06MB4713.apcprd06.prod.outlook.com
 ([fe80::1b36:28b0:4e5:de66%6]) with mapi id 15.20.9275.013; Wed, 29 Oct 2025
 12:50:30 +0000
From: Wafer Xie <wafer@jaguarmicro.com>
To: eperezma@redhat.com,
	mst@redhat.com,
	qemu-devel@nongnu.org
Cc: jasowang@redhat.com,
	angus.chen@jaguarmicro.com,
	wafer@jaguarmicro.com
Subject: [PATCH] vdpa: fix cannot get vring base when stopping a vhost-vdpa
 device with multiple queues
Date: Wed, 29 Oct 2025 20:50:01 +0800
Message-Id: <20251029125001.15086-1-wafer@jaguarmicro.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0074.apcprd02.prod.outlook.com
 (2603:1096:4:90::14) To PUZPR06MB4713.apcprd06.prod.outlook.com
 (2603:1096:301:b4::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB4713:EE_|JH0PR06MB6414:EE_
X-MS-Office365-Filtering-Correlation-Id: bdfaea1d-dca6-41d7-469e-08de16e9be26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aSkLBHMeDUJKncpTVLIwnTae/pKxkvG8gZUeOg19ZZzr30gLJ7rh2GBCnHRd?=
 =?us-ascii?Q?ktDaM4/IJLjxhPQllAXGTUwztGYvjgeIWcQtTgcVzpcrPhO26k5lv7y8WcqM?=
 =?us-ascii?Q?ex3ZvM1xdER+gpxO2wEnLo9pV47nWrvIhqGPBQ08p9athLxSo0LpnXusc35X?=
 =?us-ascii?Q?1gcq0MipgiB8w75Oi27DOQsQfjFk/rxgZ2UFAdBx0VtyzGbKENtDnjaAPeNy?=
 =?us-ascii?Q?UMbJsP0Y36nPExU9GlkKGAe24m/4ls/t7GJ9Poqckje3LAaFUQHByg5sZ3q7?=
 =?us-ascii?Q?LbHsSff2ieaWGLRUqgbBSROj0BQ9qxrLDwHUg9ztYE57VR6STeiDjJHxYNuA?=
 =?us-ascii?Q?jyTYQ8q4/gUaR+Mhj7JtHd69oycfKxzFVZkuqsluZq8u2lQT5QQFZ1IRsjl5?=
 =?us-ascii?Q?XGUDFCpB3B2fvHCK/Dilu7yaAwStCa/0tzqUPrp8QcYs4wn//dmdX8krFAjo?=
 =?us-ascii?Q?WP3MArM0G3O6JRW8fIBCzgOisrI7VCbbqMgR9vDB3/wujTxd13IAHhuMVAKl?=
 =?us-ascii?Q?BFej85b2wyoo1mNr8VrMRO5bOPi7X17zZ0D56q3Vak2gLW4iYvBkv2g9IpTj?=
 =?us-ascii?Q?I0kNJev7ly6obDpDIhVqMiFQ3QXYTqAT78ggyF0KSHE41HLbJ5l66tmnenfR?=
 =?us-ascii?Q?eDmYGIifLj58FYz2NsUX2wL0kJlVVL/M1USxdl8fUIHX4OhnN24jo9DpwwgR?=
 =?us-ascii?Q?rrk2iAI0pVX3OpNznil3PBenb3wCTC7LIhZWVwio8LN7aRzBFXXfRaSn6Yzx?=
 =?us-ascii?Q?RD3+qQGoaE3N27hD1BzUIW82tV3g/unEoaGyMuVfmz7hzJHQ/exKPLuAQ4gK?=
 =?us-ascii?Q?gW+ZaRPPyZdow0WWIqDixSsF/UVxTJ9863+Vuv+COwkg9zHVsJrcWNH9283y?=
 =?us-ascii?Q?kOqiDqtB3t/js7iVtl85d4Tm1XD2vVF/rxXJ09ZXC9pTbYTTh8EgBOSyxuFG?=
 =?us-ascii?Q?/yHKhvD1Jw75rAXjMRts95QSX1ot+93jZqaE4w8UhPnxwJDdPV2oPhOJcmtY?=
 =?us-ascii?Q?l8HptflUJDv9rPR4BaUu8sENV4C7ILc3DGj/GmV7XSO9UBggzPRhS8JKQiWE?=
 =?us-ascii?Q?5z+ThAFJO++W9OQNXlKTiIJbPBnEWR1eLowuDqGTNSBcbQXeu+802eTzmcvX?=
 =?us-ascii?Q?yESZvPj4GwqyJmqZWnJ5lglldq5E24bt/iEGtBuO5TEaGgtG9R/0PxPd/Evd?=
 =?us-ascii?Q?wcSP5NJSFJEBg9L3LKntLTab5eR95ajlc/mOVDICi4ZAMzN5yJrfVZ/tUhJ9?=
 =?us-ascii?Q?/GS6JOQ0M8NeqBCYRcwv87d09XLstdKVOiB44mspfNdm2NYNRzVDaHoegvev?=
 =?us-ascii?Q?l4D2HB8BN3GGQzriMe8pHfo7yD0oRMhHi/Wi08IH/VPNFCn5ryALAQ60CSai?=
 =?us-ascii?Q?xS0QdgU+Gb+sQaZUVWHjMvqCsh9+xh2NWHiQFh2Nxq4EE7oCrqYf59J/LmSh?=
 =?us-ascii?Q?h8gCRw8VsXny3NyFAGWS+HY1Z/rQsE6LrnTjLq5KS2NUfk6CpJg0v1GLkJNt?=
 =?us-ascii?Q?UDh3y968/mpP6wTr5Z2NZUxYBqpKgXnaBwSc?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PUZPR06MB4713.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZWgeB6Z7WD7Qi1FVJHWnBINC8/3jtAR9Tzhl+fVyIoT6kU5e9rXg3ygwKLW1?=
 =?us-ascii?Q?Toul9K7jYNKdipKcUwoYZkjGeCfShHT0vLDY6Drry/AoI89jV1I0MjGvZupw?=
 =?us-ascii?Q?bBs4CxKcU/QmKPGfIpfEGHbsSS7/Jk68kgjDwyT7xYS4kQwGqfd/IwugiZry?=
 =?us-ascii?Q?SwW4OC9wNz8jFEbvMFgq5Gb5zD5lGW9GDKS5PSp/+zqEfqn8xNz02Vth/w4J?=
 =?us-ascii?Q?5HQyRSDWxwXWA3ka67yPtC8LQ2nLnfr0m2Qzvsr/0eVjERWkcASiocHBPqZZ?=
 =?us-ascii?Q?cuNwgfTgytj8PnmDUVzZcMyosMsoE0q7elPwB7DC5mITu1Irwrw7bhZfKzlh?=
 =?us-ascii?Q?ny7rWkQRJT4HzIotS/Zm9g4D99L4la4e6UnSs5TGVZ5yCCVicdkpjHeNVqpu?=
 =?us-ascii?Q?x3Wki234ILpWW7bRQmFNYG94rKlSVgqYiuPUFkr5kY8gdIp5/B+S1Kd/V0Jy?=
 =?us-ascii?Q?kIOP16Qa36Qe1GHqtJgnBO77Bz357rVaIJA40x7ZYphyQzpThyHE/wa9fbqH?=
 =?us-ascii?Q?XwmPdq7S6J2ND5led6HS8UCRZmRNNR2zAygCwF2gSDJMjBJAxe818Fy7blbF?=
 =?us-ascii?Q?3I9LSCJeBIy3640iFEnU4Z8zE1ufs9GnvliYUCnymYf5ZbpUhl8DStu3J7RG?=
 =?us-ascii?Q?13agyW45MoCDYnyxwBDP8RE9+gcvdF26g3vlOp9qTD3U868zBgJKz/IDiYPi?=
 =?us-ascii?Q?7B1E0EgJ1xLmbGxHW7iQHPMGkOixOuf35T7jMup7hZ0RLGX2nsn/aJk+kW4z?=
 =?us-ascii?Q?V9mviFq1NDK0ESN1wGraw798EyBl65tBAOY8ADyy6/KNfuwfqJxPjfqiT6nJ?=
 =?us-ascii?Q?+dGbYFDHtTbH16G9DeVHjh9ehmlmkt0QxbTMcrvMy1/sQG+sdSMZEkowul4n?=
 =?us-ascii?Q?dlS7doMyP39Wl+GwWf9Q7omTFofWOgRU4AaQwQbeqdgpmjEvgtvAPFEGGHYA?=
 =?us-ascii?Q?ysKrhGXD66+mkuaJn/EjzDE7HUEDOP7ZOsLNh8G3J84rRiZD0BLYC0s+L/KW?=
 =?us-ascii?Q?gLZ1+1hNz/jXhspr7Lz2wzpU3aIOyDX2qujv33mKHqMBmVzkErB1l0mW4hyJ?=
 =?us-ascii?Q?G4mqsnJgmvNbkrnoea4QfgT+txTWoZSBnmsrxViIBJlm7FXXGXQzL4KhkvbB?=
 =?us-ascii?Q?s4s9HqvLpMH0XG/MQU4+zuk9GII7+kWUAOijDZH8sVcKrnMXObTC+1LzD+Yl?=
 =?us-ascii?Q?wqIhZLN62iOJtalJbN3K+o9H+yqvS5jrUBJTH/NwjlpMuo0iw/A4HQTNrLIv?=
 =?us-ascii?Q?jbN5iv28nOstIVFpLWh7tBigPi83JrBAPvtPZA6jUw6xKhBYcqOo+0w1z16i?=
 =?us-ascii?Q?B7er+OdCp5gOcz+8iZC9Fs7nM7rRnPGWmUuftNi2BBDPEU+5T6kRdrxIGTL3?=
 =?us-ascii?Q?j7MZUByACUox3tKT0fyMIS4ZUYSC1y2eOe+l5H2xfsdKs0uSDryvIJ6QN49E?=
 =?us-ascii?Q?DAIem/GNkW60GWgWzak1be18kU567ChwQ871NS6q6CfOx78bJdFJJ9m797aq?=
 =?us-ascii?Q?tyjQHBGKcKLyw7O7QDPLqvsd3QVXje4e1k7RJwHEzxE3VTL59TewzZl8glUv?=
 =?us-ascii?Q?Cs1PcoUbnag6yQ8ONoHxux0RpEohYKrElt2DTGBn?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdfaea1d-dca6-41d7-469e-08de16e9be26
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4713.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 12:50:30.7947 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CiX99VgvY52UYPt2NsoBBW1SuXiFygpYyWx94ClP5+hTid88nbnhBhzO1tqVG8/S/FXFg/aInj8XWxGM/lYXIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6414
Received-SPF: pass client-ip=52.101.126.95; envelope-from=wafer@jaguarmicro.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

When stopping a vhost-vdpa device, only the first queue pair is marked as suspended,
while the remaining queues are not updated to the suspended state.
As a result, when stopping a multi-queue vhost-vdpa device,
the following error message will be printed.

qemu-system-x86_64:vhost VQ 2 ring restore failed: -1: Operation not permitted (1)

qemu-system-x86_64:vhost VQ 3 ring restore failed: -1: Operation not permitted (1)

Fixes: b6662cb7 ("vdpa: add vhost_vdpa->suspended parameter")

Signed-off-by: Wafer Xie <wafer@jaguarmicro.com>
---
 hw/virtio/vhost-vdpa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index 7061b6e1a3..2d5e6aca74 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -1481,7 +1481,7 @@ static int vhost_vdpa_get_vring_base(struct vhost_dev *dev,
         return 0;
     }
 
-    if (!v->suspended) {
+    if (!v->suspended && vhost_vdpa_first_dev(dev)) {
         /*
          * Cannot trust in value returned by device, let vhost recover used
          * idx from guest.
-- 
2.34.1


