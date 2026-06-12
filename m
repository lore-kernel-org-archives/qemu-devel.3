Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB2A5CD98CE
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 16:51:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wY56h-0001ib-46; Fri, 12 Jun 2026 12:51:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wY56e-0001ht-Np
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 12:51:44 -0400
Received: from mail-northeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c200::1] helo=DB3PR0202CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wY56d-0000Xb-6T
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 12:51:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d/eISw7ZwB8rTXOEb9Lo4FfSXro8rKjQUF4VQM64OUwxVKHmYaM7JrNKmakwKS5qWrwA8SxIs39i45rrn+LVSux0xy35DxqBYWONJBWc/ZLlQspaCiuGPaFjQHq2we20GpO+tO8BZKFNBCPBvZbWLYSHfEeaxrBCv0YcQUCi7/9ZYZqLXFLvERbn6Gxxp1iDiDEhy3bY4k+xC/Ex4AkDfZXdMpA1UCh9h9GB0mVh6/kJRaJYHwxlmWGU0JOi3HjOqrD5kETms2Qea4jik1Mx/SUVa2eMQDDZp6i4oFsxRE1NBCs73lRYDNhqWTbvU6HAqOygcbwwVidKzgWd5jPDWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vDugQUPP29UYpvgCk4+YO0ju6oEs2yA79qbBpCfF+Mo=;
 b=UKg/RqcX6pILIY8Hv8wet587zcHpqKOl59avCzfEMSUlqoNarmd8D6ydsyVOiA6Boy9hyXkXm3Vji/nsN4xTc2IeyI7n3erFedtAM3y3BRgsEYWwYq67RpdoL3y3tU3Uqv+OIyZK6UH/WxuiTOAVmbtvHUyyPH9QbGAjC3XJLR+ONRTmNsO9TwtRjjpeLFGAik2iuh56zvBIH5vz8/NfBmfglRqEkb06Iy34tmGdvNGSmcrzIsRgUqj0MvOSsCxTK8YLrfI45TF8rxHDz4S/R2+GjZmtZuuDLO6QbO/ksxykkwxOAnl7cY+2O3Uyn2aQwJIee5vS0d4SReMCU1WZTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vDugQUPP29UYpvgCk4+YO0ju6oEs2yA79qbBpCfF+Mo=;
 b=e/ZcpR/SwVna85a+nQGO4qf6vc0SiKEc/rWiFW+oIGIGhfZkq3tqt27uEEQp6+yuBe7XYso37FVdI9f5MtAbf+2g97pioSdzo63bZJCTYuCi7WyW4uiOmHu57YopG6YE7jMrblDAtc84cMS9JmWkTCQ6Z9gPD8g/fyTv3tcJeG3TVavYidI5oC6imRYdtfHfpt50+Y548Ia38MLOJYowyy9jI2wgc6Ea5kYePunsRBN+JBncWFfcS3wDniSRs2DzNvaPRgRWLr6SQmO7XMgDjKUwaUyayiLfGQ+cd9SKVaR7Nt/vuJMH9JonxVOahXc+JpqYAvSIuZM4VzeX0UdD9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by PAWPR08MB9097.eurprd08.prod.outlook.com
 (2603:10a6:102:330::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.18; Fri, 12 Jun
 2026 16:51:24 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%5]) with mapi id 15.21.0113.013; Fri, 12 Jun 2026
 16:51:24 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, sgarzare@redhat.com, farosas@suse.de, peterx@redhat.com,
 maciej.szmigiero@oracle.com, bchaney@akamai.com, mark.kanda@oracle.com,
 den@openvz.org, andrey.drobyshev@virtuozzo.com
Subject: [PATCH 5/5] vhost-vsock: don't reset connections during CPR
Date: Fri, 12 Jun 2026 19:51:10 +0300
Message-ID: <20260612165110.431376-6-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260612165110.431376-1-andrey.drobyshev@virtuozzo.com>
References: <20260612165110.431376-1-andrey.drobyshev@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0202CA0021.eurprd02.prod.outlook.com
 (2603:10a6:803:14::34) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|PAWPR08MB9097:EE_
X-MS-Office365-Filtering-Correlation-Id: a00b5ff5-a118-411a-d013-08dec8a2d65d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|52116014|1800799024|56012099006|22082099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info: JxBJWTHA7L/M3uYsEht1PLaERDmgDxhplf3XofP0nMj4fWQLZNudb+1CUr+kt0lSulRcGOOZQVKcQvZtCHffxPG4WORHXQm+eVePX8sb/HAdULOHZtZqwC8wzWAuFw1hm/Ia3E7LpUs4t59qEzbOfHXL1se/oaCl15U7TOA8fkUVRuMwK1eDkDyx33JFCI1Fe0/o5vAgQL7HYUkEnhY43dyZSg5dV313CQJakOaBqdgCGV5mZ7h4UN7qTjNT+VB22NBj8LKpPCNw0lERecT3/nsob+xnusq6lSy/Pcq5EfzRLJ+BZ34RvwpDNpqGscYyj766xmO+ejInbsCtj4HJ5XrKkR/YIb0xycZkcX5tYZGEF3kvxz1rpjPQra0PNtbzsDL0aXFcUgZxvf+/Sw2GK7tBY8SrZyKxafujMRb6ajq/RezKLg+XJw/wi5OvFLGLuPxscwwbyJXIxwOWDzWCFWVUes4BAf4WSE87mGci8t7d99/9W7FcLvu+5TPlQiyyIfeHiFxT/OR7/64kieP4qsyF/p0b9dvH1zIgfJ8pzdDpAdfX72scdPWJCeWeX1yl2KAAL/WX7mYGLZm4spQ+77Xx/VkZXiznH79mn7qK9At5+ROxPbbAvxIbfjwq3GH2ZOQkQcg4x13z1lG+3ggo81UIjcCr88Nde34BR8R6cBiPwELMH3tmshQfNgJaAC50jlMXxceJKLlD7rt7Y7arqb1b6N1HIlrG5k6Vc5NbxxyBzkoAdriRtIUK+nSihuze
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(52116014)(1800799024)(56012099006)(22082099003)(18002099003)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?X92kJysj1ygjQQngRm9FDOPqfy44sq8Djhc3MwEa+4P0BLEmIb/CbgnLD1jA?=
 =?us-ascii?Q?vE/URJy4pf9etGlRohCu89DuOQrcbtTrHXJH2LMD9fNXIZMFQjnSUDGpcy+w?=
 =?us-ascii?Q?uJbEQWwQkLU5Qi/XIr7jq4gFtf0VYnLL5lYz17ZsblufFLuVBLMW3HqGPv0R?=
 =?us-ascii?Q?1R8zUK7MBauUmwleuOxHzqRLw6C2CTho7rS+1PCwqV0Guq3iYehIEHRsvKX4?=
 =?us-ascii?Q?uImrDu9A2jiTG28ncdtoQzgkFTdi4G3HzVYvmVgdGuxe6gSxPeuooLShgon+?=
 =?us-ascii?Q?leYnY/izZZ9VZMvF07Qmsf07hL3/PtDfq7QJT7KsT0NVJeLjFAeMw7BTG80D?=
 =?us-ascii?Q?+O48rt6ODwJ+x6eLKzC68L8HH3JZ7vBto5teank7oTLuHJFZssPd0N+jV1Dc?=
 =?us-ascii?Q?Z7kLAmXTxHmIoWvuJo0LnQbomzf1DgSKUJKfjsicQkhTa7/PQK+CyNDzBdtO?=
 =?us-ascii?Q?e+ZlDSSH8YzsGGpZzZyioY7pc+4rvtMn437N5IORZNIegtu3whNymScUitJ+?=
 =?us-ascii?Q?7Z2zpPU8WjozgfL/fDtLRtIYG7Of8MSG7meX6i1KxC836m1xup9WlUGzcVzk?=
 =?us-ascii?Q?GiaDsth2t4QFce81IW59eWjU1/Nt6e4khDD21ZmgxnIT53YTZHuPNCq8p/lb?=
 =?us-ascii?Q?k1tYwMHbB53WCDrrbrcjeLTX7WEbOzN0Aa/8Cy6dbyJQq/M6SBxTqarALN2d?=
 =?us-ascii?Q?cf3kRdgboF0/DTUUv6KxpAJt2Q5OHMWs1f9XGDr91gMkFstZuwK4B/tfpHwe?=
 =?us-ascii?Q?d0T/n9oWzchpA6gdDbkybMjIfE8inO48CA47/FpBm3WvSUoRLm/WTcAPx6j6?=
 =?us-ascii?Q?6fk4eD1/GnEzD5ZOzkaixh/vCdBT+1uXOlJlDLx4gvBxoPV0XS5i34+IeNva?=
 =?us-ascii?Q?fegcx55595N4wPpE/HQi8pR80yJCsw2/rloDv4oRZyG4/WGlWI2ZcO3wpX1Z?=
 =?us-ascii?Q?AZzAvw/AgTRRxch6Pemk2N0pRBYxYGL8D+DDMnFFK8jfsLavvX7co2zDmnNI?=
 =?us-ascii?Q?Z5ZKf4+3UKCY3srEOP1io18eM/PCrNXbiF/0d1YnR4y8VII+vaOY1jOxFH2P?=
 =?us-ascii?Q?X5h9Jo84r8djLC8n26lve/rQidKXgJ2PiiH4i6VLtTs/CYhuSLk8LTZ/zU/t?=
 =?us-ascii?Q?vogzZcZuhl2Xu60rZHGcoT3RVwwAHi/fKlbAPhhQ7c4SI86ECWoWIxLqUtM/?=
 =?us-ascii?Q?d4LGDshKKILTFmrR9HWfyVUPcnh2jncMqa963ZYu44Pc5LSxQhPmNShtSSxH?=
 =?us-ascii?Q?2gXJaX0AVu14SDOKccq5wXSOPpb36Uo2IADNhlcFIoKNnHnJtLg6hxHBQsxr?=
 =?us-ascii?Q?Skqe9M1afW9y+EuP2POCcDLfLms/UYE3kW9PUscwaR1VKLpIBf3EFxvew9EQ?=
 =?us-ascii?Q?czKO5EPQrx036bQiltixg7Fp6gEezmjY8ou3N0/AiA2ECJUaowlgougDvcfY?=
 =?us-ascii?Q?5dhhBhOj1Rq49iFEXuuT49UTasTBi9IoTWQ3njncxvD5QSTwfNzT9PHjYGAD?=
 =?us-ascii?Q?XIVM89ieB4EnTLDKY8TYal7C7h4FFvn81UE+Zk7gnHeUuGwQPP93vferDzpe?=
 =?us-ascii?Q?WQau3iQ8+xy7ZmHOHO3mS8WUrpvVi1NlttOwzqg6ff8/SzR+KXfVU6yr3Pm/?=
 =?us-ascii?Q?0wmFh9jXCO6yelqmnOInZe/q+jqtQOljI24V257+8eYcS8GFYaefhZw5Dt8g?=
 =?us-ascii?Q?wL/2KBBwan1x1p8fP6h2s/nvB3IwobpQ6fMJdF+FmsG8V8SFWUObN8Xe3x+Q?=
 =?us-ascii?Q?bw/lqVgVOYMBn/qTzNfgBsK4rajzHOU=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a00b5ff5-a118-411a-d013-08dec8a2d65d
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 16:51:24.1032 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fs9IozQ0YNlG8u1mlqRL7/lVwSu0CQeosNsgICcjKKB2NhzQVvIQInjuM7yekqdsHulFkrb/JUAu7JhDIEajS63wQ03VEMJf8gUGUhEBDv0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9097
Received-SPF: pass client-ip=2a01:111:f403:c200::1;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=DB3PR0202CU003.outbound.protection.outlook.com
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

Migration target with a vhost-vsock device in the .post_load() hook issues
VIRTIO_VSOCK_EVENT_TRANSPORT_RESET event to the guest.  This results into
the guest tearing down all its vsock connections.  That reset exists
because after a normal migration the cid may change.

However it's not true for CPR-style migration.  In this case cid remains
the same, and we want the connections to persist.  Thus, let's customize
the .post_load() hook to skip the common transport reset part in this case.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 hw/virtio/vhost-vsock.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
index 90926f95fe1..623b0c6a314 100644
--- a/hw/virtio/vhost-vsock.c
+++ b/hw/virtio/vhost-vsock.c
@@ -109,6 +109,19 @@ static uint64_t vhost_vsock_get_features(VirtIODevice *vdev,
     return vhost_vsock_common_get_features(vdev, requested_features, errp);
 }
 
+static int vhost_vsock_post_load(void *opaque, int version_id)
+{
+    /*
+     * For CPR the guest cid is unchanged, so don't reset vsock connections
+     * (the cid-change reset would otherwise tear them all down).
+     */
+    if (cpr_is_incoming()) {
+        return 0;
+    }
+
+    return vhost_vsock_common_post_load(opaque, version_id);
+}
+
 static const VMStateDescription vmstate_virtio_vhost_vsock = {
     .name = "virtio-vhost_vsock",
     .minimum_version_id = VHOST_VSOCK_SAVEVM_VERSION,
@@ -118,7 +131,7 @@ static const VMStateDescription vmstate_virtio_vhost_vsock = {
         VMSTATE_END_OF_LIST()
     },
     .pre_save = vhost_vsock_common_pre_save,
-    .post_load = vhost_vsock_common_post_load,
+    .post_load = vhost_vsock_post_load,
 };
 
 static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
-- 
2.47.1


