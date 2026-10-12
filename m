Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 751A0CA9ED2
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 10:30:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGDHf-0007tL-Kb; Mon, 12 Oct 2026 06:29:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xGDH6-0007dO-HY
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 06:29:01 -0400
Received: from mail-francesouthazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c207::3] helo=MRWPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xGDH3-0005FA-Tn
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 06:28:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qNgIN10OPzQ9pFCWB0fvDSccFz1ovoCRvNenJVvG1A/Q8unku/Bkaqljh4Tx2wMjEJel4kc2/HVwDEgybt3syyUJchWd2m85sC2tJwblzVEclrBHUgpibgdEkdvE7/QXcwISBXc3Ov8gg0MijOhcswpAyk8Uj1sfF+PfpJyHPmRECao2OOmC1DdWF08L3KPrNrbjtmAuQURHUDVmwmNyUuosKoO86RiC4HNCAIXZfMNY1Ts/qIzHU6l6Qrur8F8QSzQdXEhsUMmZvH21uLN/GUPIcSSZxAfJvUAIyUdrmRP72r+dcgq+GlLnSMFxX35QSZeZpkqcULvp0xK1c1pbmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zFLHrTXYn30DKBGfZX9XawwQGNuxnOEL0tX4YglZD1Y=;
 b=dO1RpOi1CkC6bKuTTK+s1TtW1tHlKtB2QkiEVh1MLBOZpelNoQIV2TbgaptFUueQWDqCuWXuwU80iphywlZqFLHG8gPE1ZchuyVcbnpKlyO1H3YRYoDC9weYeN+0+vQHagn60oCMw+3Xna4bRp8Va7myEnTmdhWq2/7lSiUgTojXOPtGsws837uJWS2xwj7UNaafF30Dvp+4sSq7oFMx/s7FA47/e1VyqxUDkT2mwpXWKEPcSqShyOjDQZ60xIjvNKHmGdPNpCZfmU7RVccjxCgfkfysj1G/Cgkgp+FSgwE+ZVsaz/EKyE4c6NwqJO643aMYFKq2GuoOiNqmdiHxJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zFLHrTXYn30DKBGfZX9XawwQGNuxnOEL0tX4YglZD1Y=;
 b=cf7M1yB6lb3xIrCu61V0MqX8dI9ip8GrPp2bdo8MMqWwjEEphEhZE17oxlnTCnBHUOdbZuJiPUi8pva8Y8omSczVDO3h9l64538cKQ97CE7LyIIDibpxdLOUWhgzk/0IHCENxfSwIxtU+ES71ut4D1BdWYdacUdw0ZodUXdf1ZpEnwrupnnxJe7m3ma4fbyq51dMy+zyBZxm16R545UBsOJscF24hu68mljUNS9tygZAQZn3cH2sCLpxnLMFfZYoVNFfjnSFF71HVwfE5nrEUgqcsaGSPDrZPuJyRNoNTRHx+l55K0OhYBshYI2iYZmshpkwg5kF2Wq6SHZv08UP/Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AM0PR08MB5523.eurprd08.prod.outlook.com
 (2603:10a6:208:17f::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.11; Mon, 12 Oct
 2026 10:28:38 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0522.008; Mon, 12 Oct 2026
 10:28:38 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Mon, 12 Oct 2026 13:28:17 +0300
Subject: [PATCH v16 09/22] vhost-vsock: fix FD leak in realize()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-up-vsock-vhost-v5-v16-9-36c38bd15ffc@virtuozzo.com>
References: <20261012-up-vsock-vhost-v5-v16-0-36c38bd15ffc@virtuozzo.com>
In-Reply-To: <20261012-up-vsock-vhost-v5-v16-0-36c38bd15ffc@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: odaki@rsg.ci.i.u-tokyo.ac.jp, bchaney@akamai.com, mst@redhat.com, 
 maciej.szmigiero@oracle.com, sgarzare@redhat.com, mark.kanda@oracle.com, 
 vsementsov@yandex-team.ru, clg@redhat.com, den@openvz.org, 
 dongli.zhang@oracle.com, farosas@suse.de, andrey.drobyshev@virtuozzo.com, 
 peterx@redhat.com, dwmw2@infradead.org, philmd@oss.qualcomm.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VI1PR03CA0043.eurprd03.prod.outlook.com
 (2603:10a6:803:50::14) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AM0PR08MB5523:EE_
X-MS-Office365-Filtering-Correlation-Id: 583a7330-a943-491a-656d-08df284b9447
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|52116014|1800799024|23010399003|366016|10067099003|22082099003|18002099003|261009223027099003|56012099006|38350700014;
X-Microsoft-Antispam-Message-Info: RRmWLK7IkZxzlI+cgHjOBl5NwLo+zNCIPifvAuXNbhUDB37RBHaEBnZhyxwxu9tOboih5GVWj4yOr/Y4V5y0mztjnCkNWI+v3LUIz+DYIJZItSHFs95g66GCFBuMWqUBYpLVcmTOrdQDQ3cDqbQFOP+NOo3L89CfsHVdNKrfsMjR7qrxH4F75TJ9cMl8MVBEwGYIgZkpAMqXoN4uY588R7FoBFtbTxXaFNu4PYtcJQu+Ys2fDmhPBiBpJDktjL2ZDKyHa9kiKIK4ZqRb+MXmxbaYEWVMky/K0Am1lQpFcsrrzfGSkbzIGnWuebINZbRBm6gWBksRZ7jeqZD3ufnQeAy22pIo1KgHah6VQNrU6emsuRdoq1ikUHXe63iZbOFUS4ARJWWKaa2QHZCqNbnK0Hj7pSzW3EqM6G5dItBpLITE8fnt/lpZ42jJR3zlvTXglaIR9l0Q5LcPP28zkAwQvZ/esrqWwhfs5QtHVQyhVUpHrBWZBcdOs9M7LBHbjv9cHBjOsRvRAhbwkoerKlGoqZ7Cse/bkMu9M7ZYWhoyUNFNw1tGlf+9dS6rq5Gd3myEo91s3Lv33M/LV0mccR5c3zfd3Re2hAZQRpCjd15TPb3kRDMO6powE/jLsqzaxe3WRIWkOsS5OTAIKXKCtIsusKHdCXpUMAZ+k8MuW/c2E4SLkty4n5BO6/JqFNbIUfi6JoTqC+D6EAYZvYh34kprLs0Yt/rhQJxlGQDNeDLktLc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(23010399003)(366016)(10067099003)(22082099003)(18002099003)(261009223027099003)(56012099006)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nnh4emNFOXJXUkhCdVJnSzd2NWcyNlJ0MzdqQllROWY1Y283Ny9ueDBEZFlJ?=
 =?utf-8?B?VG85WkI0b1RkcG5GSVM3bmdieUkzNHpiQUR0R1NleHppOGh4Uk4vMkMrOUtD?=
 =?utf-8?B?cGJXTHN1RS9DYkNxbkxsRno5Z0xHVkZ0SmZURnV5cEhORm5iSm10QXZJd1VZ?=
 =?utf-8?B?KzBPdXNRZTd1T0NhMmpRTWpDeHovYmw0Z2hydmw2dXFSbW9GU0xYVjc4citQ?=
 =?utf-8?B?cmJNeGJnZG5jRUVpT3h2QzUzVHJySDdzUkdEY0JiVkZWS29SSEtUYytOMkln?=
 =?utf-8?B?MVEzUGFqYjRHTzBHdENZbEloTE1QZElidjFTWmpVVCt1bWpnK0NHWVVZcCtr?=
 =?utf-8?B?VmhSa1JHNDBpQTVqQjNKUDc5UmplaHdRUFF1UkJKWDJKYzc0dTFtRTVqdDVK?=
 =?utf-8?B?NVhRdU1taGR4bDlweEZ2blZMR2YxRWUvSjQ3dUhxSVZrdy9NSU5ST0FybWxJ?=
 =?utf-8?B?NWVoblorWmtkVzRyRDlxU0tkUzFGTTlFQXgzczFNQ0RHZncyWVdYVEZIbDk2?=
 =?utf-8?B?VlQ1Mlh5KzFuSXRyTW5PbFV0V0NDNVN1K0x4TjFOMHJpVWtqci81NGRaSUdr?=
 =?utf-8?B?QXd4UUNFOHlyZm1HcDRCUmVhQzF3eXdsclZLeC8yWnJDeHl6bWRKem53Mjd4?=
 =?utf-8?B?Yk10eXRIdElNem5qbERVaHN1Rzhjbnh1aGNlTnluR2VLZGV2WEU1aHNIOFRY?=
 =?utf-8?B?bGRJRWt0M2EvT0RpeVZTdUJKYnBDSEZNT2tIK2VhZ3dPR1Q0YjZJelcwUGd3?=
 =?utf-8?B?OC83Y2l1MmR3dXR1VEEvaUJBOWFaVnFwYk4zL0VkN0pRMTlvYlBwNW41cTZ3?=
 =?utf-8?B?RDVFa2hEZGxrcG1jZ3VZbkZDTDZXemkzYmhjQklhR1FkTjBhUmhHbjhzbWdw?=
 =?utf-8?B?THU5MjhkMGNIMGdPaUVYeEJUSVlNTTl1cmVFNUlYbDJBeXRuMncxbkcrYnNL?=
 =?utf-8?B?ZDEydC9wOStTbVc0QU9XL2Vya2ZSRDkzWFZQWmpMeEdJYUJjY2t0UXBUZXRS?=
 =?utf-8?B?TkxGaW9xRHBYVW9Fb0hzMGN4Qm9sR3NHeHdrNFBhTzFnVXllWXRRMVZ3c21I?=
 =?utf-8?B?Sm1oUzdhNmhXK3h3RUZDV2ViMk1teitOaDRCeDBFKzNkQjREUnYwQzlpdGFt?=
 =?utf-8?B?VW5yK04zNlFDaHArTUVYNWZnZWpoSUhaMlJFK2NKbnlSSkNsbnp4WjB2TXRH?=
 =?utf-8?B?anJkY2swSERWL0hUZjc3bkNTNThoMkZIa1puVFhwYmt0a0lUMEZPVjk2Um5k?=
 =?utf-8?B?REVDendQMURPUGMvdnA0WHY0TG0zQWgyMXltb1JCbEk1RnBQSHQvSGg0ak1H?=
 =?utf-8?B?THA2ZUlnRnhYMnZIVi9nR050T1BQM1FlQXo3WnNxeFE5YXlhVG91V2R4Yldn?=
 =?utf-8?B?SkhNcExVRTBFTzEvZGxRMUFHUWJHL0s2QVdKTk1ZcndMSHZOejZJSjJIcGh5?=
 =?utf-8?B?QWcvTlUyYTByN0Y4dm5rdm5wYkREK1MwbUlKck92bjZCdWZjVHJYVlEyZVcz?=
 =?utf-8?B?SmhmYU5tKzRHT2Vic2dITzR2dWxtMUgvaWhDUnlrWlBQSnJHc1FydVliLzZU?=
 =?utf-8?B?QnhrU2RNYWRmUGgvK3FBbzgvQ2VsWW1mY3c1M2Yzbi95dVF2TGdBMXNiUXdl?=
 =?utf-8?B?WDNiMFJ1R2FXWWtiVjVxYW5KWmpGRVBhc1oxNjdLWnNDWmxoN3V6disxaTVs?=
 =?utf-8?B?b0l1VzJ4a3FEM21lT0VKNnBId3JGa0dhdkFQV0lJOHhpZFpjNVd5VFhkRlFm?=
 =?utf-8?B?NEJ6eU94eFQ0WkdxZzE4OGRSN05hQk5OSDJ6NEo4VmFUMmhkOXowSi9kbGg5?=
 =?utf-8?B?TTFPQUt5cXl5VHdHdkRVRENzS0F3dGtSb0ttUnF1cVRQT3NQUkd6M0lhbVRx?=
 =?utf-8?B?cFJJUmFoSDh0STJ4NWNqcUhMSnRuMlFqaEx6ZUk3RmJ1aU9neEZzZlh0aUJn?=
 =?utf-8?B?dHlFazhxeUxIS211QllQRVZEK3VoaGNVZXBFSXp3OHhyS25BSEhaU1hyVjhM?=
 =?utf-8?B?ZVcxLzUwdldvcjFBV285M0p1djl2bVdDOUR1SWIyZ0dzN1dzMkduZTI3SW1D?=
 =?utf-8?B?Mjlrcnl2TUgrc0RMYjVWQnRpd3ZOM1k0VlhLdTBlZFQyY0xkaUdXZlJCanpo?=
 =?utf-8?B?UDdwM3AvMmdOc1ZQS2VVSWRZckcrdE9UUC9CaCtnSDkvQVJUWFlhcFVkMzNv?=
 =?utf-8?B?Q3E4TGFsaU56bGZUYnFjYzNJdUJFWm44U2RCODk5RHNSdGo2eDIxTEFTNk1S?=
 =?utf-8?B?TzU5RFkxWDQ1cVVPSjNjaVJ6VGx6OTB4T2JDSlo3cTU4L0g3N0N4RVQzT2dU?=
 =?utf-8?B?dEZmNm5YRk5GT2VuZ1hidlpTN1NWUHpxektLRVplTE5RdFc3aC9BZGJXUVJi?=
 =?utf-8?Q?WrJjsl90wQ0ReAyI=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 583a7330-a943-491a-656d-08df284b9447
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 10:28:38.6710 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4/L2ohD7rC8Est6XIHFLP5q9EZz+Z0az2q+UnUczulMBuuGp2R3HJfJcabl7xt/xD5XHKbrrRtsrc03JYdVbPmi5h2iLXFdl0NJ/ti7T67c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5523
Received-SPF: pass client-ip=2a01:111:f403:c207::3;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=MRWPR03CU001.outbound.protection.outlook.com
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

In vhost_vsock_device_realize(), after unsuccessful call to
qemu_set_blocking(vhostfd, false), vhostfd gets leaked.  Let's close it
explicitly in this case.  CPR-saved FDs don't get automatically closed,
thus it is safe both for vhostfd obtained from cpr_find_fd() and from
open(/dev/vhost-vsock).

Fixes: 384c2561bddf ("vhost-vsock: set vhostfd to non-blocking mode")
Fixes: 701544cfaf46 ("hw: replace qemu_set_nonblock()")
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 hw/virtio/vhost-vsock.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
index c582ac9fcc8..3ec20d87606 100644
--- a/hw/virtio/vhost-vsock.c
+++ b/hw/virtio/vhost-vsock.c
@@ -176,20 +176,17 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
             error_prepend(errp, "vhost-vsock: unable to parse vhostfd: ");
             goto err_blocker;
         }
-
-        if (!qemu_set_blocking(vhostfd, false, errp)) {
-            goto err_blocker;
-        }
     } else {
         vhostfd = open("/dev/vhost-vsock", O_RDWR);
         if (vhostfd < 0) {
             error_setg_file_open(errp, errno, "/dev/vhost-vsock");
             goto err_blocker;
         }
+    }
 
-        if (!qemu_set_blocking(vhostfd, false, errp)) {
-            goto err_blocker;
-        }
+    if (!qemu_set_blocking(vhostfd, false, errp)) {
+        close(vhostfd);
+        goto err_blocker;
     }
 
     vhost_vsock_common_realize(vdev);

-- 
2.47.1


