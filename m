Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4649FCA600B
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 10:28:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xElJt-0003EW-9U; Thu, 08 Oct 2026 06:25:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xElJp-0003Dv-Qw
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 06:25:45 -0400
Received: from mail-westeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c201::1] helo=AM0PR83CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xElJo-0000sa-Aa
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 06:25:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q6DHNhodybuh35ucYxQmtGF3RBd+BT4q1JKDoQCGMWblrMMFwWB203XjSggBmf1wQh1hss06Gc+9hB6tK0hGprOt3yTbLQS2obNCMZUhbU2O6fG50pnweIsAXrQF7v9QvGdG1g7bLlnn3O3xHUVp12tQgN3NxTQbvbOTrU1dstsXfv3ym66Go3ISbm1ug/W2jRpFZWojAYG03gYI/ppo/qsJHrLMDvDMX5TOpuZf/kYDm1rkxLrcAV6DMGwQ/1PiuX1f7PAt+vp1WL+edpHH2Oc4Q+apcNAZ/h/82Ig/19hg3DzG7ksruL/r+cEM68X3W4AE7+hmdniu0eMNryg7Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LsFB3FDQ+3FBoUdGrsPH789lm9GaLA45KHUm/J4Q16c=;
 b=wV6EWin1GKTwsN+Woe/lsolu/XVJ2S32UIW5REJdZhyXpBraGTfX8gIqrsAWGWSaqKH7TWk3C2X7VzmgbFmElBmaUFacFkDORNo4Drns4LQwOq4oVUqEoHAYWiuRkUZU3/TTDLY616ot7e/W7P8/ZBMedDBPLRu9LUj3JZI7tSf2v6yvXfR+jqQNrvgo+JMKcnPswryveP4GzQZ6VIDUtZjLLZbp5Q9VewqRItheJ+RZShWg44iWfPQkUk8jKzNIf6XuKaPfUOLSNrMekIRlAmnPZ+rRWkXQwVsoCbx+2UaL8xAp5PJkwQ4JUmhlilhQvSjuUDNp6v+N7kY6wYzgCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LsFB3FDQ+3FBoUdGrsPH789lm9GaLA45KHUm/J4Q16c=;
 b=WrkCT/iuC08V9jRbKXMO7FbuKEVID3Gbb32bZgej8LUbvAYOYWPYSRu9mPlTgwSre6M6jKeZ1/HFt9DZWCedAVFkXkc3WKbzJ7wrDF5J2JOPwzD1APCyaX4ERTpIa0u8fN2LzQYjaHhyO10Ipj061KTGi49fAdtsRYiTZu90XMZlb6fkxZZzfSXLgU+ImhnEX3bzqw7s3EDzdxyv3gVq3ZC5u6z+aTGUsORNc32V4dkWnow+2QqHNlwtdWPLNS71RTc7PiArmVvJJbtzO1C3fImX2d61C07eD5JnnMDECFvO/EMEcAzVeeobOMuIE9jNsGXkSMciZ1dfPIQxTfv3mw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by PA6PR08MB10593.eurprd08.prod.outlook.com
 (2603:10a6:102:3c8::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Thu, 8 Oct
 2026 10:25:34 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0496.010; Thu, 8 Oct 2026
 10:25:34 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Thu, 08 Oct 2026 13:25:28 +0300
Subject: [PATCH v15 04/22] migration: forbid snapshots under Xen
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-up-vsock-vhost-v5-v15-4-301b73b3f843@virtuozzo.com>
References: <20261008-up-vsock-vhost-v5-v15-0-301b73b3f843@virtuozzo.com>
In-Reply-To: <20261008-up-vsock-vhost-v5-v15-0-301b73b3f843@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: andrey.drobyshev@virtuozzo.com, sgarzare@redhat.com, bchaney@akamai.com, 
 den@openvz.org, farosas@suse.de, mark.kanda@oracle.com, 
 maciej.szmigiero@oracle.com, dongli.zhang@oracle.com, dwmw2@infradead.org, 
 peterx@redhat.com, philmd@oss.qualcomm.com, vsementsov@yandex-team.ru, 
 odaki@rsg.ci.i.u-tokyo.ac.jp, clg@redhat.com, mst@redhat.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VI1PR10CA0117.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::46) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|PA6PR08MB10593:EE_
X-MS-Office365-Filtering-Correlation-Id: a4c6e33e-5425-4e86-8e9f-08df25267cc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|52116014|23010399003|1800799024|10067099003|56012099006|38350700014|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Vsh65RYq+JYU3/VEyqjJenXhIN23pIerH8IbRpTs3vP/FwviOYGZ58nVXWr79jS3FQ1ZHLvX0SKLY5ZpQ6UspNL2Nn2V+Q6oUvf6CALtLudN+XBOjAXiLibHgw9b+9JPpFQj+ABRrevttu8kDOJV7/drhhy393e2UrMP5utC7/f5YHbPOampeDILyrxSOKcDmpMwebrcV1m9wPcDKUwXSTOds1i8eI138kO4FYTkHJnSBpsaVutNdmP1VPjXSinSC3oP+fZXhMBOkKz7s8RlV/l6JsRq4E5WXF5R50g7AO9lTp6Ydz5BH3yazIvi4BRN6grDIA65rWWcPtGFB9tTJyWrQ6Kgn855ldxUacbK+NSMrO9sigYIibVJD32F+9Za7MzomuZeP4kV+Hluzo5OBjSqggfW2ZXcVB6yhOFoqOx5JZiyxBJhBf5NRb6x6J/dBnGPqB3z6mUXCpmtmuJY9/bAchtR+RRRfEk22DGQUqeeFkyRIn/i02MQSFtVbdjI9Nf2z8riKxhHdN3BxYhgouwO/hU2+FeKek7RlyJJw+zPgMs8C3B4SRFHvQZ+/8/SzWk6YRYXXYW9jjU7YXCUyMjzqpJ4fDoESAIJULGRws+wecEDWMlikDj0KZ3yVXNhflutwBssoKhLB8rLW9tEBxyB3a+3RKYC2MJcDMvr+n/9+72kbiARGeGSrVEF/o23LY8zq30ARze8dQujhR5aEkzaBtG6s2Jjh9I5rF9CBw0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(52116014)(23010399003)(1800799024)(10067099003)(56012099006)(38350700014)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TjZvYVhFVEdMbHdYMCtRL1Z2YlB4Y0hwU1dmMGRQVUpsYlFRTmd0MFp6T3FS?=
 =?utf-8?B?emVCd094elVNenNscEFoeHpjNkFXTGhqU2dlZDZJZWx5bGdTTGNISUxkVDEv?=
 =?utf-8?B?eGtnbjlxRDl0RFo5YXUwTWpwa2U3RFlQTlJpOXVOZ1Y1VXNQS1hWaXFSSUdy?=
 =?utf-8?B?OW1IQlUxTkFSc2pTTWpleGwzK3JGVnlUelJ6OGt6V2FkR242V2pUQjYxaDJi?=
 =?utf-8?B?L3d3L3VmRzl6YTBEdm0rZjRwNi9objFXMnZMZUJyRzYyVnRGVithSkwvRE1K?=
 =?utf-8?B?dXF1Y3JRR255YXNpOFNhaVVvdVlZUDFSL2U0MUhsN0UwY2Y2VXhta2pNdW01?=
 =?utf-8?B?cE1yQWNHdlJ6KzRMajY0NWQxZitNRm45VElkbmVtcFRSdTV2UXExR21vMi8w?=
 =?utf-8?B?cDg1WWl2K0dJakROMmthL1lMU2VDaW42TWw5TWNLQjQ2and0YnN0Y3BaYzFo?=
 =?utf-8?B?b1RLOU14bmV5VW9aYlNNaFZWR3FhK1I5WTRvRmZnVEh4N3puUnFIekk1TlZN?=
 =?utf-8?B?aTdsTi9jbHhseUFwdTlJTjdiNko1WEM2d2p5ZDJBT3RSYmFHOXBydFNDT3l2?=
 =?utf-8?B?VEJ6dXpzWGs1L1ZqTXdwVU40WEZBWVQxVllpM0JNMDVLTlAyMkU1dUN3VXBy?=
 =?utf-8?B?Qjcvakd3bWw2amdsWHYrdmkyczF1dGdtUmRmUE44dWN2YWhWM3hRZDhKY1BV?=
 =?utf-8?B?OVZLU3ZldnZlUTZhSGE3c0JhbGFqclZ1S0U3amVSaXFqT0RCRFlRTEFwTXM0?=
 =?utf-8?B?MU92NElLeWcySHlYVUxobnNRTTFpclhWZFV5eFU4cHRKeUY1T1ZKRDZJcmdT?=
 =?utf-8?B?UFVyaDR6U2t0VGx3eE80Ym0vNE5QK1VBcDVVUWpHK0RNME1QbW9wb1F3aDk3?=
 =?utf-8?B?bTBkd0dmaXp6OHF1azhZWjdKcDhLQW11VWU0alVpNGlwbGJkMGZqQzV4OXcx?=
 =?utf-8?B?UzFyZGV5MkFwYjl6aTlMUG5OUkdXRUNKbzd2cFZnREwrN2hhNTJoYlRncTlu?=
 =?utf-8?B?d3RlWG5xdDZDOVRDd1dpTVR2SGY1MHdwSTMxdElydzZkMjU5aGJWdzVGS3hK?=
 =?utf-8?B?V0FEbEw0ems1b0FoZjNsTzNnUkE1bStvNXpsZzFoVHBUaVQyR2lvelhNenhM?=
 =?utf-8?B?TFczMU5pRWFrRVhoNUhtc0k5TzNIQUtrNkJ0RlNQVUpIQy9UdXMydXBSSGJT?=
 =?utf-8?B?ZU5WYjhFTlBIeURTSHJQV2Zha29Gb0lBam43RXJTUXFWR3E2L2hCT0ZRQVNj?=
 =?utf-8?B?b3BtR1RYdjYwMklyNjN3Uk9qYXVMZVFQMFBJYUlwbXo4Zy80dGgwcWtTdFhz?=
 =?utf-8?B?QlRMdFNIRHBOdVprbm5jakNRSUZkcmdCMUNJT1I0LzhJcTFhbGJ2K2txdHBQ?=
 =?utf-8?B?dnM4RXROalNUM1VNbUpSd21KR0FpaDg0SjNZVGFiNGRQblZmSWgreHllVGNI?=
 =?utf-8?B?ZnZPYm1RNXhmd0M5czN2WlFUc3VhbEp3bW5jMFVJZUZVbW1PNnhyMk5LNEpL?=
 =?utf-8?B?QmtHVnVoZE1hUGNSdWVTVnRiVXFyeFBzbFhTRklOUTQvOE9nSm5SUU5jTnM4?=
 =?utf-8?B?UmUxRUxVMWEyYjY4Zk1mb1VHMFZYY09XeURSVnlWcU9sUFZ6dVhKRWNYV1Zj?=
 =?utf-8?B?U011MU1uTEt5Q01DbkN3akxqVkw2UWk2endFb3dpRWtqRFMwWlg0RHlZcW81?=
 =?utf-8?B?ZGF3T05rYWJWaE5VWHAxWjllOWpwYmRkSXlvYnM0NlZnQUNvajJnbVdEKzVP?=
 =?utf-8?B?S1FSQlZ0R09NSGRiMTdaUHI1bng1SUptQTZLQ2FVS1R1RUxaSExwY0dncmYv?=
 =?utf-8?B?NG1EL1JLbFhYUHA2WjdNVVN3MEVLQkhIVnNmS2VJVC90SG5lOGhrRkVyMTBK?=
 =?utf-8?B?eWY1TFNxTW5TbzM5d0tFend0T1doOTFnVmt5NUdrSGhYOG5NSTA4UzBQSVFZ?=
 =?utf-8?B?MmVwaXB1Y0Fsa3NFbXBDQWc3dGRQNGJ2TjZYc3JaTzdoZG00SmhTOFBVRmlC?=
 =?utf-8?B?cVFtbWRCbStiVUVsVUJXY3pNSzAxNE1ZWGFYMTNEeXJxd2NvSVBHY1ZvZnVa?=
 =?utf-8?B?dHNLZEJQOHp6VDJqU21KdTRsWmJiRXFMbktIMEtGTU4wYjk0MDF3U3htVUk4?=
 =?utf-8?B?RFlqbEwvdUVZQ0RZMlRUV1ZETytlV2REUWlVVVNDSVJKOGtkYjFDWVg4emlU?=
 =?utf-8?B?cXcxRExyNUpHK0xSS25NSThlb2l2cVkvTlJueWdYWHNsdDhSMU93WTVjeE9M?=
 =?utf-8?B?VEdHY1FwODZMYmR6cllRMWNWRVcxQWxUMkZKWHNqWE9zMTFQQmdrLzRtdDFy?=
 =?utf-8?B?cUMrRTJTUEFNb2VLTXgrMUVGMUZFc3Q2RUxld3lYd0JpUlVHWVFKc1VJSkx0?=
 =?utf-8?Q?s052Jk1hlaNLA2ks=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4c6e33e-5425-4e86-8e9f-08df25267cc9
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 10:25:34.4625 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NLJdDDyZvfrN+KKONFHypDefu4JKYs8sE/I6QwhTR3dqMNLK50kfexB/T7WZJoMmQW8rdvri0nOFVmQlHj55H7GIMxrj06bShk7tRy20DAY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR08MB10593
Received-SPF: pass client-ip=2a01:111:f403:c201::1;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=AM0PR83CU005.outbound.protection.outlook.com
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

The snapshot RAM-saving path does not support Xen's memory mappings.
Refuse 'savevm' and 'loadvm' when running as a Xen device model, the
same way they are refused for CPR migration modes.

Suggested-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Acked-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 migration/options.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/migration/options.c b/migration/options.c
index 92eda90114e..0b7f393492d 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -37,6 +37,7 @@
 #include "ram.h"
 #include "options.h"
 #include "system/kvm.h"
+#include "system/xen.h"
 
 /* Maximum migrate downtime set to 2000 seconds */
 #define MAX_MIGRATE_DOWNTIME_SECONDS 2000
@@ -563,6 +564,11 @@ bool migrate_can_snapshot(Error **errp)
     MigMode mode = migrate_mode();
     int i;
 
+    if (xen_enabled()) {
+        error_setg(errp, "Snapshots are not compatible with Xen");
+        return false;
+    }
+
     if (mode != MIG_MODE_NORMAL) {
         error_setg(errp, "Snapshots are not compatible with migration mode %s",
                    MigMode_str(mode));

-- 
2.47.1


