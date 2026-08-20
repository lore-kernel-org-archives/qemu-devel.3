Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC875C5DF82
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 11:41:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx185-000180-VS; Thu, 20 Aug 2026 07:40:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wx184-00016q-0n
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 07:40:16 -0400
Received: from mail-westeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c201::3] helo=AS8PR04CU009.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wx182-0002GQ-GT
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 07:40:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dbUus8yiTUSDSwWWS1BR6GKd57sGmrpkCvgwfU+cPBW3cdBqWv8y3hYZof8pQk9rNuFHWBIBV/IXv/KADRnAzzcTMCgGIg2xiz7rwhVyS7m9QEwkyJVI0x9miJFyP+hAXk5E3Suz1Geb8BDY2sJr4C0GmrURO4Yl/Zro1RPCzD3FSCgZIRfpnV7U4jO8kza1zij0gt6dwQorgwqd/Ug4ZIJ0408nt8vQQTCN2excL2mYhNKnkR2dty2+RYh/Oq5CqaJbp6loLhHUGw6hhvZ6qxJ3THXYYT1CzPlrbdySv+RBzeqngj5TahlrlyffeL+SWFJyj7GLFKkp1DwJCRD1kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2aqx2CN3HNGVxIPYDIBmNrs8d4cZWFdlEQO4/aTfspA=;
 b=oIuHzNJMk/6FjtHZoOlMb4Sy7zKqmofHfgpLvvWCfXZPgqTWC1KrYryZ75PTbKSfi5M/q0vSOVkou9ChNdNfjevniT5SyI3jwmVn8PuorAgm83vH7noxrVt1yUFSUH2SgzRUXaWldLE052Ts1yXrfVLfYJP0++gzyfQ6ReyZJpe42bwCFoZ7f4mVYQD1RhMKTJuPl7DUeSpuqUjCwi0NsCto1lcOg7GyESNiSkjl0nIFtGDDLZWck7X3i5XA/kE63RvglozVRQxQyzO7jk4yqWQvgW5KfClMCgMVh2pFEF4IWHDZO68+2F/zkTvH4lBfFLzTN3VKh4V8fXuVcl2n5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2aqx2CN3HNGVxIPYDIBmNrs8d4cZWFdlEQO4/aTfspA=;
 b=iF2hVrD6oSVNubTr44tlgrUrKUfhSXe5iTcUAk8BBk3uPAThbdGX4xW9nLEaRYitqdGCX8PC9cKVXgJHmsxDjaqom/QC34UHOAlhU3/+ARwuRJAntEodkm9fDnF+h76X1P5EEwidfvA0p2/7ZKvbwr/xo1f3tXr2uQ3AgamCX+v1SnQiRHbV+w07ucKm6Olt9+hXKqd+4jhT8smKtwSfr33k0tCx/ioAEx9LOnzZJ1Sc000dm/NnA4mz0Zrlmo5bTh+T5pGRn3hzMjhn/+wd4tEzVzSugII30uuseVDM3+Z8P21elpQeK6e+m8a8RBFisJHxnAx90zhu3MHWjiXYLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by MI9PR08MB975321.eurprd08.prod.outlook.com
 (2603:10a6:290:c1::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Thu, 20 Aug
 2026 11:40:07 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0339.007; Thu, 20 Aug 2026
 11:40:07 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, sgarzare@redhat.com, farosas@suse.de, peterx@redhat.com,
 dongli.zhang@oracle.com, maciej.szmigiero@oracle.com, bchaney@akamai.com,
 mark.kanda@oracle.com, den@openvz.org, andrey.drobyshev@virtuozzo.com
Subject: [PATCH v4 07/10] vhost: make vhost_dev_cleanup() safe on a partially
 initialized device
Date: Thu, 20 Aug 2026 14:39:52 +0300
Message-ID: <20260820113955.509478-8-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260820113955.509478-1-andrey.drobyshev@virtuozzo.com>
References: <20260820113955.509478-1-andrey.drobyshev@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR06CA0102.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::31) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|MI9PR08MB975321:EE_
X-MS-Office365-Filtering-Correlation-Id: 21a9d995-9949-4a1c-ddd6-08defeafc8b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|23010399003|376014|7416014|1800799024|366016|38350700014|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: p6FBCiLRGS2Mz4WZTSOTn8iwvtcM6dUN7FH/zuIMQTpOPjG9wl8qB0UBG5BD3nzBO5+MQuDoK6mCoHrnxg+s5ooLy91JzIhY2ZJOB7+a0mH4XIaoWyWPQx6z5ohVoVJFJS3QcNa1oeG2PsBOn+nmZRkSBW69EY3b93MmqvKLb5xfuBhEtXCfLj1U4lIv/mbLesg5/a2CmHBnoWk4hpPXkPdlv3yxvzoM2E2Kb6itihGbx0WVTael8Jaj2YA4LbzmM9zI0SZwjaBnVffJ6hQmGizAtuW7k4CeP+PDezFb40FF+eEuBGVn67kyfXh7dSg05ThPodSblV8gCIz5khXX6N0dshrBZFTQtpCZJg1fBAcx7OUYBewiDZJWzEqWWCPig/VRp9A6gkYmVFMusBdxRV7epfGUHrALFhfrCS4KXxunbIpg47fsFhuBVRBd+f80q6iYVp3399e6eHmStvvPUlZ5QrRS7UdIK0d/WPbJsQIt+RaBdQM6tKTcFu/SqLfOEsH3y1joboo3muhAFd3G8NV4VoQ9k6RdOJx3HUE10oKtwWRquZ6Q/PlVymhBuKzCVENTtrLpOBs9J9vvHcCPq0VboHWvPuAAOlYrkkEnYQZ2NRgrNZaP/Z+xiHybe7reqm+MAjZCe8DYBvwi9D6f3lyzZwurGzyAzgA3bP9cmWV6fcSDv/RgwJelWIwb9cEhJkTq+D+00HYyOZdpJyfA7NL2EuF2cJ+dZ63v2mIrvw4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(23010399003)(376014)(7416014)(1800799024)(366016)(38350700014)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?p8AF1PMv2OzVjlxbTvdjh6ZUVZHjk2knONGs1GsRLlZdzz/7N/DfICetjCOR?=
 =?us-ascii?Q?twm2uJysE5Ppo4j8F1mbXzgHqu0393eMXmTM5R10A6QrBYeRUVUmxo1v4/0k?=
 =?us-ascii?Q?4JDIRMmsfvZ4b6lM8Fbs+/Kh+hCZT0h3gw5FiONPmTqcqkbJIoLLc6tAJz+8?=
 =?us-ascii?Q?aFtIgz0iSQ0SKB0KVCwpLmkRngjghxghJLzRobfTmrRQJWmxW6YYVDxmA218?=
 =?us-ascii?Q?7PhS5nf0pVuOjA36AmqkxI0isWbAhZMMyT8sm60JfY8E/HOsZ/k4W95P4HrA?=
 =?us-ascii?Q?n/JdbyvXdSLsQTwXRYfPj/Qp+b5rdsHxlaLpSjVdZAEXK9NWtzM81WEUiC+j?=
 =?us-ascii?Q?EjE0x3exoHpMrae94n9dRf4dzFPnwqe2m1u+Pmwi5UnbNouZ0wqnEQknhnA+?=
 =?us-ascii?Q?JD0Un8IgXFPn4PaXRFaCDCDEP274A/qNsVZr54wpS/8iJoAeen98PeZrhYgB?=
 =?us-ascii?Q?XxYDTQG1qU0UOohMDNGLBH2NujFMFyRKhpOUhXJ+qXvUGly1Cd3DR/te2RMZ?=
 =?us-ascii?Q?nr4t+8ar+mCm59MF7MkH81R0CAfkfI0CuY67HBkIELBqmuJmn96v98dz02wy?=
 =?us-ascii?Q?nVkwuZXL367X/BVOP4UzM4fuefZgoXK9CqbhU/5dXvj9r4xM4rpJft3vTY45?=
 =?us-ascii?Q?+1widUv7laAA5ZWM5VCuuT0qjSkn+1PoESer8ICcrg3RlKnN5+PpobfP+eXG?=
 =?us-ascii?Q?rDhRM+86Q+hKEr6vdJ02ko4XWlC1Xh1FpC6Jp9Dq+mGrVR6Jbac2TeTx1Kim?=
 =?us-ascii?Q?l+fLsurC/EAdnAbTYS3Phpp2DPOCWK5awmOXcFAlFSQAB8fC5P6cnZAWiAWL?=
 =?us-ascii?Q?cii/pn76OAF+elKkMvAq9uUhqC9RikFJVnXGrXql3AFBAs0g6M46JIe21glx?=
 =?us-ascii?Q?6yxSyxPAiSRPEbhPLLA6AjNEyacSJ5f/IYUf2SzcNStX44cGBebHkk46/wgQ?=
 =?us-ascii?Q?BEFIARU0aJfAJf4kEYtrQm+lPI35yZoUakG3ev5e5zM5mUTYstsYgXgz54lH?=
 =?us-ascii?Q?QrsCrKSz5iN1vBCjoIlV6s429ZVJtG3GDFsjqh1DIWzUDzwKp7p7XIQTO5Gh?=
 =?us-ascii?Q?Sp8oILMiv/Q9KsJ1UU6E2LZqmJ8XRY5qaDKToNiLE2s2yM9M2OF7xKaVkifZ?=
 =?us-ascii?Q?bHBeiZzf9Uud6ku1j+WZc27bVFcN/XIuMT4bYk5GSfz7cSpgCHc851STK7EW?=
 =?us-ascii?Q?hJleSsO6GZYkW0gScaUbCYakdZQVnQr2y89jNBPHW+bZRD5bKvzbA1pMDEfa?=
 =?us-ascii?Q?Iwa/qDs4QlrLuwD9S50N+vV1zH0vAgzNHz5FimJT8QmHJ6LLJrccK5+pv6zj?=
 =?us-ascii?Q?Pjl/PBUQyqsKXNagmtGF0jewV8rotHuFmAyvrGlNOcGSaSBr8kVDpxomc6UV?=
 =?us-ascii?Q?4QMsWnh9c4ZJKZ+H7r1tFQ+0iZcimm68JtQe/I6stXtsKalYfx0Gyrg6BAHE?=
 =?us-ascii?Q?aAeeGo2x2bGudmf7p4p69qpxR5Nn4tXdnzcZ3s9otl0ZWQwoEweQbTbT7dp4?=
 =?us-ascii?Q?oC3QHPY3GX3fSeKpWTQG2IriXTvkS6ThHr2Hgdp86nvM2Rb2YRl1d4OgGtGP?=
 =?us-ascii?Q?dLSwyuTDc0CLYkrkTxRRpzRgH1XbYJZN/dCsW4E7wpCMlbpvfCQxQp7Il8XY?=
 =?us-ascii?Q?e9ORSojxM6+dUNpfHzfddNaYopCFKFrUiuW8oOK337AaOdEgeNlKpYt3t6xp?=
 =?us-ascii?Q?xJVCeSJ4EzOlnV90V6UvIxfh203V9mTMbQdnoPWgb7BFgy4ZdgT6p0MgFSHD?=
 =?us-ascii?Q?1g+unDenXlBKbwdbZxmvVRqil1YJO+w=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21a9d995-9949-4a1c-ddd6-08defeafc8b7
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 11:40:07.4689 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HwLn/9IAW/dFbNnTs0eWc7UYevyaopLkaIkYfdRkxyhWlwR04WSE1WVWiaL7Am6qhbsyxIcVhIxxQH9Szkv1sYNVeXEAqaSzHX56zuFP6LU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI9PR08MB975321
Received-SPF: pass client-ip=2a01:111:f403:c201::3;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=AS8PR04CU009.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

A device which only went through vhost_dev_init_backend() has its VQs
not yet initialized, so vq->dev is NULL and vhost_virtqueue_cleanup()
would crash dereferencing it.  Check vq->dev before use, so that
vhost_dev_cleanup() can be called to release a device whose full
vhost_dev_init() never ran or failed along the way.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 hw/virtio/vhost.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index f9b54c46f93..2bb9a23fee4 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1648,7 +1648,7 @@ fail_call:
 static void vhost_virtqueue_cleanup(struct vhost_virtqueue *vq)
 {
     event_notifier_cleanup(&vq->masked_notifier);
-    if (vq->dev->vhost_ops->vhost_set_vring_err) {
+    if (vq->dev && vq->dev->vhost_ops->vhost_set_vring_err) {
         event_notifier_set_handler(&vq->error_notifier, NULL);
         event_notifier_cleanup(&vq->error_notifier);
     }
-- 
2.47.1


