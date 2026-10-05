Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 166BFCA5FFC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 15:04:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDkCJ-0008KB-AA; Mon, 05 Oct 2026 11:01:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xDkC7-0008Hi-Jj
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 11:01:36 -0400
Received: from mail-norwayeastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20f::7] helo=OSPPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xDkC6-00056Z-4H
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 11:01:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wXHctsY3hMD/739CMqQYgOj6xhz/4CgZYvWyOyg/9TB7Eh0JwUOCJwfgNWEyq+OH9N4IgBOX9d3n6SQtJskjoen+fWJOmVIBFMOCNfB5NF6bSaAg8Qzt5QfXV1wxVlGJuzVgRbbQUoC24bQlQ8UKXdaiATWsHQWINJevtvh+G4PiLTsJ1DP50uJVxQKaatkCZN7fbKXYcGzZGmh+xnED0NMCm5SXEPBlyQOqKvrm6aTcdntXI+4HlN62y3y2Cv6qgeZB4ECDoLQi8otvDY4U4xNyigyOwF6RZe9AQTComSLJidpkvIiYn/DBYm3kBW8NzUkVPchfDalT+uqKDmqY5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gWXhh68le3RfUJjypRVq8x/GzIl/qjsOycrfUzYBtG0=;
 b=t2nBDb6U87unUeBibtGOj7z2PxL0vgL3VM/vZRMbrbV4yQHC4i5rK7zIdFYjsfNnicdaa1TEVG88V6+qgRPWpCTLb3zUS8tRr15Js8bKbNRvnVC/mkdFqDS7XNqhZNpa589y4C46HtVK0URphdKVwdgOu08CCHogoYTpX7wKXdhEdvG3Ja81oaPSye4ceJuS1QPWm7wE4xDg/EV/JVQo9l2PPSpRYY29n+oM2bLzWYc/TdOFZ4D3gkAlxHjhN4dE2VMRs4lcKeXOoji7aCpeKI+xbTGnxLW6RM76uuJBfmmLEwO4JqJF4/+ighb+ctcOni7BiP8VW9GWPf7eWJfmiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gWXhh68le3RfUJjypRVq8x/GzIl/qjsOycrfUzYBtG0=;
 b=pAq3r1ciMh+PNgdyJt3CkJl057803lu9RGvpI0ecQKRZ+XP7LVNvMYkB1wwp6Sbk7ScIRwAtuIonkWgRnsgk+9jLzViV++pkNd7V3ylWx1DW1ummEZtOIRLS7kWPK0F8YzP7qARy8HxQSop9iOTOd8j40Ym5QqNI/E2uhZujrkpgWFScRXMF/+Y2SVhT4wvdPzyvFfvToS/E4nn8xN7BDkYk0uw9/GWjcJxJvNiQv/SkUXjU/336B01+yXn4bAp8QOyP8Kc6H8GpZpKNvsrLyP1N0X7G4+1DXszOdeDDgg6L5ioUjOCPBY/G3vr+3gLiin7TfZkegoQf6HZObYTjAQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AS1PR08MB7452.eurprd08.prod.outlook.com
 (2603:10a6:20b:4dc::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.14; Mon, 5 Oct
 2026 15:01:20 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0496.010; Mon, 5 Oct 2026
 15:01:20 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Mon, 05 Oct 2026 18:00:51 +0300
Subject: [PATCH v12 12/21] vhost: make vhost_dev_cleanup() safe on a
 partially initialized device
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-up-vsock-vhost-v5-v12-12-40162390c68a@virtuozzo.com>
References: <20261005-up-vsock-vhost-v5-v12-0-40162390c68a@virtuozzo.com>
In-Reply-To: <20261005-up-vsock-vhost-v5-v12-0-40162390c68a@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: vsementsov@yandex-team.ru, clg@redhat.com, odaki@rsg.ci.i.u-tokyo.ac.jp, 
 mark.kanda@oracle.com, bchaney@akamai.com, mst@redhat.com, 
 sgarzare@redhat.com, peterx@redhat.com, philmd@oss.qualcomm.com, 
 maciej.szmigiero@oracle.com, dongli.zhang@oracle.com, den@openvz.org, 
 dwmw2@infradead.org, farosas@suse.de, andrey.drobyshev@virtuozzo.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: WA0P291CA0014.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::19) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AS1PR08MB7452:EE_
X-MS-Office365-Filtering-Correlation-Id: 4099b55a-dea9-41af-2165-08df22f183e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|52116014|23010399003|18002099003|22082099003|38350700014|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: RZTtNGrHkXanA12N7nTy3cr7TSlT2Uc/K0Bf5ewKu2A+AwYpCjepR/0r468XMM2lLL1ZafrTRo4zBzfkFdC5CkjslEvEB2lra9Og1Thzinx+9gI0ZWmUo8KBFyhonvlvHNZoWaXJy4LLk+BWdjv0yCA4TcD8+rY+KfQWrSJ6HzOpEVThvl3q7OVhu2FIDaAJgaRbp88hYHW3pfmPHVDHkycDwf93ruWy64aFndmDRwlCwXlq5DN4DuxHofDfImnYHKBnGTbUtaz1yfkXnyARRPy3cjs4fOZbu5YCTLtpAH/WbheiuTLykf7arN8/1KfwDrGOQtE8uRCszIHKH9ySqqeo+9JkT+wxYIA4j0xEElR466QBov5l2zcsJ5sUNNUHgBSkfRTVre15bakBbofgXqvQFmP1e0dCf9vJ3+im96ef8PoNOobnx6x7f8xVb3hU1pALDyxYCNuHT7ODUTNx1Lk1QcP9/B+ACxQDaLubgIX4eZsDwIMQwNtqgwCyaKQ13jI0NHKKK8aKeW06KN7B4k12CveJi/JJyN8aGV1teMhtHDhVV4q2M5LbfEHloFH0kC2Wevm6uBixpj/KmZ8bxRlkc4GDLy9oFtrLU9KRYv0K7EZJhtwZBcqnU/hN6tfhcXgSQiMkn7OQC4q6/S/yfszhcoNCmFqqPHCEggGzgdXo3bUolii/OHIU4MC0mQPm+AgMd7jxZjq45pPfuKfCmT1jPgZqDOXgTZYmKcPBg8k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(52116014)(23010399003)(18002099003)(22082099003)(38350700014)(56012099006)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1ZGbHo5YXpudjQ0WlROOW9TUm1lUkFvV0Qyb3RadWZVSk1SSEJZVVpNbU5Y?=
 =?utf-8?B?MFY3WjMzN1RyTmcvbllCL2ppblB6cWxNZ05oYktuSE5pTFd4elpVeE9lU2R3?=
 =?utf-8?B?MGZaR1ZoYkhxUlhPL2JPYlNrazJGbkllbzg2dDdleEpmSVhzM1QwZTV4MTJy?=
 =?utf-8?B?YkV5ZjhSVmtjNmZ3T2lEaTMxVzJmODlCRCszSE1VV0YycU8zMWNxblZpS2Zk?=
 =?utf-8?B?elV0dzRzNFFrc2ZkUEJaaGFodk0rRXdEUEFWdTJ5U3dEQlg1cS9pTGpVMU5v?=
 =?utf-8?B?OUxaejFpeXlyclVzbEppMVhvWVI5b1k2UjlET0ovd3ZQMFFwcVBUbXpYMGlW?=
 =?utf-8?B?M2k0SWRXUGpFY040YklYYUw1Znk3bGtBVDZEOVVPQ1E4WEFsclQ0SEFva3ZJ?=
 =?utf-8?B?cXcxN1hyVGg1T24wYWRXTGYwMFBoWHlXRjB4K0pSRmhYODRLM1EzcHlraVMy?=
 =?utf-8?B?dmU4UjNVSXhiVlN2c2ZiY3hRdGpSSEdIZVl3RjdXQlVIYTZEaWZET2VGSmx1?=
 =?utf-8?B?YkJUNlFJNWI3eURxaFJVbDdSM2QrcHpkQ2hjazRYdUR5NFliaXFRVjJUa0VL?=
 =?utf-8?B?Z2I2K0tnL0VhL3ZFeW5zclhyeHovTUhEN2gzR3ExT2EwMTJHbTFiNEF2WG1V?=
 =?utf-8?B?V1BoNTA0L3RJeDJNQTFHMUhoMFBTanlNTVMxTlFEM1VGVlJzV1EveEV6YXR2?=
 =?utf-8?B?bkRGWkxiL3BRVS9udXN6S1c1MjVCYVAwRVVxL1hIRjFDWVJLbnJjUVY5dlV2?=
 =?utf-8?B?NmQ5ZFRPb2pVVkVDTnF5Y0NwOHZWYXZpdkJhQktyZTJnYzFubTlrQ0tCeENq?=
 =?utf-8?B?eXVyRHJ3TG03WS9NVnlPd215K0Jrb3J5WW53aWtoS2x0dHY2akNXNzI2SDdj?=
 =?utf-8?B?MkdBbGQxYXRtWDhObWFKQmZCVkt1VjZLMW5nSDNwOWFsNmVrVWl1bks5azd4?=
 =?utf-8?B?WldkSzZaWW41eWdOSERQUms2OHo3SlpCY1lRUS95M05hVnpQa0RRWlIyakdO?=
 =?utf-8?B?b0EwRmFoU0Z2YTRxQmFFYjAzMkJSNjhkUDZXTUFEZ25NM2laN0M5T1l4Mloz?=
 =?utf-8?B?a0FUdzd5NGJLUVcvdlRUM0daU2ZIRlVOYkpwOWNXdU9YSG5iQ1dMQzltN3cx?=
 =?utf-8?B?YkV1Y0ZueUw0S3MxMGR2RVFVQ0FCc3RjSDNFZ2hEM1RyRU1XbHhNNnRFQkVj?=
 =?utf-8?B?VW1QOW00UmFEN2JVbmZsUVM5NmJiVy9MbWpOTXkzNzBuVWhJb2c2MWFiZlpK?=
 =?utf-8?B?bEFpOG9KbGo4NnMreDVmeTg3YXVGZy9QM1RXSzZ5a1RVZGw3WjlqNWM4dEJ2?=
 =?utf-8?B?QkNhaUhxOEdwdGoxaG5RZkJKdXl6VXl5YzZHeFRFVEx0R0VDY1c2dXVMakN1?=
 =?utf-8?B?L2JEUTI2QytTVVd5WG9BREhFOVhJMWtnM0dRMzFNcHhIZkUvc3hDRS9LbFpw?=
 =?utf-8?B?b2dMWVZ3UTFSMWlNSUF6M1V1VFY1QThiK04zQy9sbW15OGdMNW90TDIzdmRJ?=
 =?utf-8?B?UDJVaFNLL2ZuSGw2MHRDTTlNYldwSGtDaS9lUjg2d3RoMFVVS2hoUzhDVDZx?=
 =?utf-8?B?NjdKR3RBc09BZkI0Z2ZUVkxYM0pzbEZ4NEF3L0pVbjVSWVlGRTB6SDJlY1Ir?=
 =?utf-8?B?SG1BeHN0QlBkTVI1ZlZiQkhsemQ2TnhWWmxPV0RMUXpEYVBOZ3BZd25kVnh0?=
 =?utf-8?B?a1l0THlybHMyR1VnQmJXMnlDSDZ4cllwQ1hodEdMSXQyS2R1dXI0dkR2YnZp?=
 =?utf-8?B?RkNkaHUzOVJkUGdYamhGSnVzOE9iWXIzVWdsTzJWMEUzS0pUOUhGaDRZclly?=
 =?utf-8?B?L3MwRkp5NWhHQmtYd0JGaHFVMjB1dVBJSGhUSGR3MDd6cUEwYUpDWDZjZkJw?=
 =?utf-8?B?UkhrRnVtOW9YaU9CbnpPdFNyQUNSV1RPQ1MzVHdwYTN0SnNlWmtrTC9sUWJo?=
 =?utf-8?B?andTTUd4ZnQ2RmIzUzE4RjlLRHB5VFQzbUM5cC91N3FXcGJCaE5SWXVjODF6?=
 =?utf-8?B?bXRKQWhHK3hTQ3ZJaDJQM3VIclVtdFBlNFZYME9KWjE1L05EeFZXQWkyNUNC?=
 =?utf-8?B?amc1R1MyQXF1a3Iyc2Z5RGw1UmYxSCt0TGxYU1g2NDM1dzZUaFZ1eEhzd1lT?=
 =?utf-8?B?N1FEck5TOFF5Smw3UFA5OXZ1UVV2cnBSQ3pnNmN2MjNVQm03WElHcUxEUXB3?=
 =?utf-8?B?dWt2SHUwZDhMcEVaayszL3RGK1VqalJCeHd6Rm1aZ1Y5aXRaY3NVWm90K3lp?=
 =?utf-8?B?Ri9zOTVRdWpUS3htNjY3ZUUwd3FnR0hJNmQrMVZlTU4rRzdjNXFteWRIN1ZC?=
 =?utf-8?B?TXVKU3VaNzc5Q2hwTGNRYk1ncGphditIVVdHNG1xZTFJRVBLSEVoZ0RYZm12?=
 =?utf-8?Q?U/RmJRvRRMgqOb/A=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4099b55a-dea9-41af-2165-08df22f183e0
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 15:01:20.5830 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Oc5lLQ3bfXV7Llwogn6ZOKdPpq88tEqHy2AtQd4lPBEAWoYoI8TQ/2yYhyQIEshXzTzzGbVpNdlrij3wHjGBmswpnbLIgCpFPHgxbbambE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR08MB7452
Received-SPF: pass client-ip=2a01:111:f403:c20f::7;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=OSPPR02CU001.outbound.protection.outlook.com
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


