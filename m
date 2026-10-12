Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CD22CA9ED1
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 10:30:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGDHh-0007wD-Ou; Mon, 12 Oct 2026 06:29:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xGDHD-0007ed-3P
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 06:29:08 -0400
Received: from mail-swedencentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c202::7] helo=GVXPR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xGDHA-0005Eh-CA
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 06:29:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fYa6uPPAbSDNcacv/Zasb+zPwloBCAvVa4U8FOnrlvBsTEyQUa6LI6mcdUKqmjuQB8b7ZPzKIRGM/i0iLahVggCiWOB86cPQBEbtZhUNu5ZJGTbdLeCo0JO0Lm5kWnDNjTotE2dlzhf0NfukYZEmdHxx2AshrBOwoeObggvyqUDVyTZ4ikz13ho8VxZYGXYAcnADeVP4cePVCL0M57yQhZLX2sDAKEtZeFsTi2uMUD94SsvlOsXyvt1dXdJApp98m2BXPPq8jRaXuA8JRE41+uzb3FEXb370F01hynZDyxg3XMWWAyqe9AXT16HAFns4jEBnIf6RG/QJDHmy12Kk1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gWXhh68le3RfUJjypRVq8x/GzIl/qjsOycrfUzYBtG0=;
 b=H81veixiR8KKqc0dTYCPx/gi/61H8Oe8LC9kVYHmLONdHwJw46TOQQ8K1SHQ2a/Qouo1EEIMBjwBRUlxlY7g2Y8Ff9Jr/FLybPaVqZa4HmzPczbw/PRe8CVsACJTlZ6UpDG6rEYbCvJh5650OmcW2PcHnEpKWWzdtAzN6zE0/OUQqh0IMhAEW4rh+Ge+kPmJut5I8a63sV0tQbqcW6BzaxAaxYiee4xW4hwgcLbLf7hnpnuED+ki1Ug7Q+SNZYYCzxOGFyM1ALWG15VJapldwAWit7s8MTpeHUiQ6oRJK96Qe6TPICoFv0scGNkp31jRkDBGgZ5pl/4nmZS+2N6Ugw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gWXhh68le3RfUJjypRVq8x/GzIl/qjsOycrfUzYBtG0=;
 b=D2S1SEvNDliL4mjmNEvcs9cDDDVfyw63+U9gxvhRtCwKmpN6LMgyEQ1ZdhQaX/xwe34CF8xNYpuSTW0BchKq+VzB5aaoT3SGUxQjdg32SESz721RWofUCqOPJXGRQfagfRzJrumLKuxGpG7JjI6pkPuHxpDEw0qerzC8BjcrgMpuXhWc9ko8TcYn2DGzd40/FBDOlz3+jJqkLjefARsJDgORHRzlAnx9COIRI9uyjCWttG5wrDZFZ7BaRJZ3s0cb5hLUATnbnunjvNJXfb6Slf7ytWkmpinWUfYqdRG3Pvm0wioHkTwhXzlg0taRfrCaqDsahkPJdNUO7oZn7LkRTA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AM0PR08MB5523.eurprd08.prod.outlook.com
 (2603:10a6:208:17f::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.11; Mon, 12 Oct
 2026 10:28:41 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0522.008; Mon, 12 Oct 2026
 10:28:41 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Mon, 12 Oct 2026 13:28:20 +0300
Subject: [PATCH v16 12/22] vhost: make vhost_dev_cleanup() safe on a
 partially initialized device
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-up-vsock-vhost-v5-v16-12-36c38bd15ffc@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1ef964f7-19bc-44f2-24cc-08df284b95aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|52116014|1800799024|23010399003|366016|10067099003|22082099003|18002099003|261009223027099003|56012099006|38350700014;
X-Microsoft-Antispam-Message-Info: M9YgBsd6vKR31khQSsAUCKjtiiKolZQon7T+Jh5d1URBGt5o0bent8rv7lk1WRnchQIMfgRR8LWhmUBc3XA71M7b3q/9J8jPFsulBZTCKVCWVI8qP/1zD9ew7cZtGSiFYh+ayF2O1/MBkCI2mW8Un4G45VJes18ixNsHwSV1IfBSYuGmf6xVo70kOh0FNqFyFdnuLbeua9Bn4lcOCfEpN1/LW1eScTWmbF1HG9M5f/o6jWuBNbt6qn1GeN5MbNVDg0cHl1zj1TeEQSX08ugDgrAfHIm14YsQ4eEGFztq22zHnUKdB/xXfZwhEfoBOpEWQC8zzptjygjJMOZ9jgjWZdzawPmKI3+57e6gKGCAsTLBxuJL2PGucP3nSkBQRBOdq6sx20Y1Jjkjh1ncaX0iIjp8sLA9pbcbhtpIanbQ38mKZ+oOu8Xn/26ftwD4pcOAxWmulbEVkgDOU0UxQmgL1erzfSX8kqsTuElzECrp5PE8h0xfCTq7cLOXGLOhs8+gXXSZ2fBUpHe7S4XyZU+XiHmGHGQjIUbeV7v8yhqXFnQAt7UQNOn5NGTLZpyqNJdaWDlusoh6fBAhzKMHAZYcARudCZPcmCWSOwIoxrkj76JY/dqpT2Rz1a1VLAHFv3tfvU0pDFmhCjaXjts15wTDbViqvYRYgwgwMd6y3pPrMxw89CNh9fwClWEpqIWwc9+R/4HLNtY2bneMWWU15jOWYgUar0yqL37JzZ1Q0kHDgQM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(23010399003)(366016)(10067099003)(22082099003)(18002099003)(261009223027099003)(56012099006)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VmIxOGM0djRQVWUwS3l0UEpQY0V3L0oxTGVmaUVNU21LOUxSdG4vWmw2eE9s?=
 =?utf-8?B?RnAxSHhKYmgxT0hoWkx1QkNoZzNHenBVL0Z1VXVyUmw0RTJoSzZCTlFvR3Bq?=
 =?utf-8?B?b0c4SGU1WVcrVnhIUThOK2lia2QyZXB3OFFNQjU4K2FyMkpwK0RGYWJHOGRy?=
 =?utf-8?B?L2dCcHlobDRVRnh6UFR1MnBVY0xqb214Mjh6RFhxckEzNkJtTk1XeTlQOXVp?=
 =?utf-8?B?RVc5L0l5MGR0WXRGZ0NZOFJGWUlsODlJNDJqM2lLT2lrVE1iRXlQOXMvTVFV?=
 =?utf-8?B?VlFnMFBhQkM3T21WNStWSHlmVTNlM0lVTTV1WFJ0UWtZWmxpSTdrTmFnVnRE?=
 =?utf-8?B?eHB0Y3JFdXRCbERaL2M5TjYvc0kyclY0bCtMd2J4Ylc3UGl0bnZVMWsrZXpV?=
 =?utf-8?B?emQ3UUdTaW5FZDJEd0xvK3NTRDZzWVJBOTBhb2VBbmQvOVVDUy9ETFR0VmUr?=
 =?utf-8?B?dmRnMHdxZzMybWM2Y2ZQSitTL28wdTYza3ZLcFdKRU53WHlVMVNTN1VoSEd0?=
 =?utf-8?B?cWhhSWRxUzNXUmlId21WeHVqRlFmaUI4MnpmeUdtMVRMaWhpZG5QaHZ2eVhs?=
 =?utf-8?B?MkdiZ05RUkV1c3ZNU1NSbDlleFdHZU9qVnNQZjJMNEErR0d4M3c1N3FoaGlS?=
 =?utf-8?B?ekVwRnlpd01JOVNMeExKT1VPMUt0R0sza2FFaUcyVm9neElQREl0djN0c2l6?=
 =?utf-8?B?VUNaM3g2SDFuTFV2eDU3ZmFBazMrdnBJeVZISlVHWVp2U2FBVXZDcE12YmFP?=
 =?utf-8?B?STMxYm5aYy9EZm5qc21RNDNCOVZLNTQvNXFxLzRiMGhscDV3OHFVRXFlRll1?=
 =?utf-8?B?NmJ4LzJUaEkyeW0zbWRBeU5RWmZiaVV5QW5OYmtUZjdtOWRPZHV6aHB1bTNz?=
 =?utf-8?B?OEl1U1h6NTM2VE1YbVpWcG00WTlSeUlyTlVWZEwvQXFWanlzL05jS0l5dEdO?=
 =?utf-8?B?VHBtNjFIUDdGZXRPYWVGYko5a0RXU3pJNm1xa2txR1JSeTY5bm1XYW9xWHZ4?=
 =?utf-8?B?QjRTUTBJQk5vTG02aVZGdTNYQ0JHOHZXSVZZOW11NTlZV3JiSGxiblNaNUFq?=
 =?utf-8?B?K1VkM3Y3ME4zdjZ6bnJoblFNRWFhT0RqTFhoNnQwdlF6MFZVZGpHd3dnbzI1?=
 =?utf-8?B?U0VDWnVsczk4TXlhcVRFVktzbG9Cd0tlK3ZqSUY3Q1VKVEZYckJJV2ZJQm01?=
 =?utf-8?B?dU04Y3VaK3Q1Qi9zSk13OVhFZ01IbXhnVHJBK1loaW5taGp4R0x0UUVSWmQx?=
 =?utf-8?B?NjZraTI2RzB6bVpGcFdNVngybmw1cHRpRUhPSTJ0SEhaYXAvek1PZ0RmRmJt?=
 =?utf-8?B?c0tsRnpoT0lObitmdXlFcHU0RTFLdXdubTdlS1dKVE9QcWNybDYwOERURVBT?=
 =?utf-8?B?UHpCbWd5Z0VSbjBSaS9QNzB6Q0dDc1RMQVFOQ3N5OTNJY1kzTmFCOVd2SE9Z?=
 =?utf-8?B?S2xQTzgzaExHQUpyUE1KUXFic0hOeXdHZ0tQTzZpcm5BekxUdFp4S09oUVdI?=
 =?utf-8?B?TGRsaDU1R1hCM1NoR2JrR3BNRTZUYWFTK3JUZG9BUEJ4bFN3M0lFTmo2ZXJI?=
 =?utf-8?B?dDJCbE4xQlNCZnFsYUJMcHFPYVIxd1NVRVNCc0hDQWVKMnkyY3FMWjJNU0E5?=
 =?utf-8?B?WVBwNEVOekxjdjZtM1ROTUNDMnF5MlF2Nml3LzZhbnlGMnJsbVJ4VXQwR0J2?=
 =?utf-8?B?emhXOXlHNnEybExGejdITklGNmx1bzI4bWJreGkweHRacGp3aWF5U2Y1R3l1?=
 =?utf-8?B?VEcwdFNNSXRPL2lBM1lDM2E5cFQvOVpGWXFuTHBSMjdkcThhL2kxb1RKOHN5?=
 =?utf-8?B?a0RVZXpFaFJGQVNUWkt3b3VpQWxlMzRhd1NyTCtUQ0JmYzRXL0lDenRnenFH?=
 =?utf-8?B?M2RVYmVzVXlxeHhDQVpXZ0FaWVhTWEFwOVB5Rk1XV0lVNTMwVHNOeDUyTFht?=
 =?utf-8?B?ajNGZWJvTktoeURPRHBzd1E2SVdnd0FtNC9UeldwNm1NVlhZdVZtWlhOSXdm?=
 =?utf-8?B?aHpLZTNRSjQ3cUtiY3EyNEVQTjdYM1ZLSURkYjZ6YThxRVV6YlpYbTM0TGJq?=
 =?utf-8?B?L2RvRGZMYnB2QXdhRjZpOStCZ0sxc0RVUDl2VE5iQTIwOG8zaUY0VEJXeUQy?=
 =?utf-8?B?WE9MT3B6UU1HTVVJR05CVzF0Szl5R0ZPSDhtK1FtUjQ1RVJ5azhFWG0yNVJx?=
 =?utf-8?B?aDhWR0doVUgwZGltejFBbElUMXZnOWNGMTNkdDBnT0hEaWdvRS9rbmdxbTVm?=
 =?utf-8?B?QXZVUFc0U1p5TkNhN2laR0syZklKcmRheXIzOHRSS2JpdjJXTGNGV0hOazZF?=
 =?utf-8?B?SXY3UDFZZFNFTVg2YWxQQVd3TDlOZ1VDbGtEanl1VXJjbGloMGF3MkdvUHRI?=
 =?utf-8?Q?jNGU4t+N2CgI066s=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ef964f7-19bc-44f2-24cc-08df284b95aa
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 10:28:40.9660 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g3pNC3Ugt6dzKbpB4Nmd0p6JQ37u+zd6JPW5abTow1dWbq2L49xPlgAJ8WsFzcUv/6ZB5Mo27dt3tl9mc+mMAXZ04vigqQbEAVv7Pmn9Zno=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5523
Received-SPF: pass client-ip=2a01:111:f403:c202::7;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=GVXPR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

As of now, there's no way for the cleanup path to be reached with
vq->dev uninitialized.  However after a subsequent patch adding CPR
support for vhost-vsock this'll become a possibility, so let's prevent
such a crash beforehand.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 hw/virtio/vhost.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 99561ac5868..dfdfd49da3f 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1661,7 +1661,7 @@ fail_call:
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


