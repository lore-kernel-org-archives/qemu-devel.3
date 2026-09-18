Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55EB9C982DA
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 13:49:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7YwO-00037S-Me; Fri, 18 Sep 2026 09:47:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x7YwL-00036Q-VB
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 09:47:46 -0400
Received: from mail-westeuropeazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c201::6] helo=AM0PR02CU008.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x7YwK-0003Df-E6
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 09:47:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i5rSWW5pzTLeng02XP1Qn/Ncl8Zp+ChqPEuSoQGkiK6MqpTIBMbHVLrrWM2Qrw8Q1Uw0C+jIKjXvkVhgbUxFvJrfJKBACbOBLa1VJQ15U5XbcQtEmjmXQtCC4DEHx2eUH9Br0pISSL2Xu2lg0AI6MaPTCanwK+7RvspEAwFAqrLZKYF/78+y5CeXhykIk93eSuehlciUeT4j1gTrKdgVLxsL50+fUCgtKU3iGCgzxbP1fxYt5vDlXCldb7j96BMgS94vJWqIHy/ZFRx/XBaNsckErpffl9wn2FL/ybGr+R9IxeZcL6Du3lWGITKuYMQr46XBAn/cRNxtBzG5OnIkMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zFLHrTXYn30DKBGfZX9XawwQGNuxnOEL0tX4YglZD1Y=;
 b=skbhN9ju2FOPP9STQmvOvnhm0wL1bLc/W2NqO5/Y/YxFfQmzrAPg/lHgNMPXNGLi1Gm/9M0adoIb2HR/ZgGW4xMcO9cgjrqHyMMod9E7fO0mgyb3m2dOM6DT6MxiHHZTJxM/xO81xgXLW3Tv2nKcMr3SCJtmYSeUHObsw7hxK00Ug75A/t/DDEc6tH09yUZRu/hQAgn/lZUzMvj2gx6LUOiEVa2socHU9qNQ168GkXubbg+aPDVVil1+rYBFKev8nyBDjuPqXaeBNl141qZTf4jO2DHCDmP7vwp2vVWFsiSGhAETdgSaLF+L4nim5DY+uPqC7cKWlJ67XcwkxYLhEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zFLHrTXYn30DKBGfZX9XawwQGNuxnOEL0tX4YglZD1Y=;
 b=vTv678vu3WJyUFvlX23coiKSzG0fmSBEEJrFo/DI7SCa8ve4tmRe3WsZgVcY+PoMjesRkw1fvgwAeexqqqTexw+t3FvKqyqzNIjbGYu3vgPk7kkVcn9Nm2bLoaO/4EllMI9IfX4ggSWjbVNcu5Kr0F5z7aB2+B/XC40zaCn6b5ydp2DYNXiHaHYNw4xNAFXrOXLmQJG5c6JfA8XOUvVuVbdo0B82N1Kq2Eu2G5DrdVkKs+pR51IErn4Ik13WF9d8q0GOBhSy7JATmgJae7toS8FlVqFCX0vX/4R61EQM171eaIRl46MrcmasFX17STnpdi9aaRF7gU0eJ7Sua+Iq4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DB4PR08MB7933.eurprd08.prod.outlook.com
 (2603:10a6:10:37b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.5; Fri, 18 Sep
 2026 13:47:24 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0428.008; Fri, 18 Sep 2026
 13:47:24 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Fri, 18 Sep 2026 16:46:59 +0300
Subject: [PATCH v7 08/16] vhost-vsock: fix FD leak in realize()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-up-vsock-vhost-v5-v7-8-6ef9ef033c35@virtuozzo.com>
References: <20260918-up-vsock-vhost-v5-v7-0-6ef9ef033c35@virtuozzo.com>
In-Reply-To: <20260918-up-vsock-vhost-v5-v7-0-6ef9ef033c35@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: farosas@suse.de, bchaney@akamai.com, mark.kanda@oracle.com, 
 philmd@oss.qualcomm.com, vsementsov@yandex-team.ru, 
 andrey.drobyshev@virtuozzo.com, maciej.szmigiero@oracle.com, 
 dongli.zhang@oracle.com, mst@redhat.com, clg@redhat.com, peterx@redhat.com, 
 den@openvz.org, sgarzare@redhat.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VI1PR07CA0292.eurprd07.prod.outlook.com
 (2603:10a6:800:130::20) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|DB4PR08MB7933:EE_
X-MS-Office365-Filtering-Correlation-Id: 5490751c-77df-44a3-c361-08df158b5d9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|7416014|52116014|366016|56012099006|10067099003|22082099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info: ibx44JCMarS3EgotvS92KZAKKySOcTiHcbdS/c0Zb/0hSOrVZUyrwPDCLH/IVBav5IueH1NNDGHvml7Ga5MHK4q4pMp91g4/goEPpDnijkOKICb4zIGqSfetekbO2e14VyMHN5XLsQUYJBlgEZKCaKD/kDLCsTGymBilmGJprFPSbYsN/8vymGyl6F9blHEFqoec6ebwZ7rNJw9cQHvB/NwaCgyuCbuMllAnxGVtjDOV4diWMPlpjJ7oQJX3ZjEsgsb3NgoQzSY2wwO8JHoiYQUcZpUSZ+ZGou+9xFoGmOv8VjWQqMOgbl5d3d8kvF2eziVu1xGNUQxUqFlGztvBLIYxSIXhKaaPpo7KDmBU3Q+a20yE9YJPEuZYzzDD85fhRHAUd+cUxKpF/xiP5Wv/hfue5QuEYVimCoW+FD7phLjOXmtYo7I03fUfkdgMQZPcpWRARQbT3PvcYESGR2Wj45Jovzz9fyWqbz0vn+KxPu2+ROZ7cL+ZuvExvB/v+mT08r8Sf3exR3C8Q3+SjSEGtEYBk5uHiJW/maN4lD4vkMZBHBA+MCDoHeD7iLv2VcOwj2JLNw9SU1qTIn/XjbyaJhnLwjoMWJIYSJArcFjtRwRNrSMuY/Y83mMamieiNc5JDOxAORlA362YCUMKI70isr1480LcDd0HFEyCmd7VvOT+kV5rqXvsvvVWtgP5t3jROlZ3MlHyTb4OaGFJyEpTP5mzijNFj7oJcMvICusFLts=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(52116014)(366016)(56012099006)(10067099003)(22082099003)(18002099003)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3V6ZXFXVkNVZDdtV2FoNDZTcWV5YUtVY2ZhR1d2R015MDBSSXRraVZtZURx?=
 =?utf-8?B?aTgxU2JsNjQrWElNL210NktzQTc0TWtCT1RkNmlvbU5hUzk0cFRGdThsalpX?=
 =?utf-8?B?YUh2ZDdmUE1qZ0VGMThwL3FTdWpMa1lVbXlmbFlOT3ZnSXdjeUpHd1VraE5G?=
 =?utf-8?B?N1pGVm4vb0xpcm1LYzVMcTNzWkZzdllmUlBiVWFwdHB1S0FwSFA1dmVzODhR?=
 =?utf-8?B?aEhFWFlhc3lmRmppWXlsYWNoUUFmcFoyUVZMWTVmdXJuWFhBSlFBSmMvNm45?=
 =?utf-8?B?d1NORWZqdk1aWDBwZnFQRVAwYW5OeTd0OGtrL2pNWUdtQmZBYlhZanNveEdu?=
 =?utf-8?B?QzVHYTErdnNGc1B3cll0MXNTRVo0a0NzUXk4TnRicDZGbGRKQThhUjFsdEg1?=
 =?utf-8?B?cWxTUTBpbjE0N2xUaDIxYmNVM0hudmdpZHkxWnBXMWlzRU5pL0czUXUza2hM?=
 =?utf-8?B?bkJMQ25LM2c1cXVnRGUyZzNBVE12NTZVR01KSHVPT1dGTG1SNEpiSDVnQXRw?=
 =?utf-8?B?R3MxMCsrcE53TlF4TGFVRlk5MUIrNjlqVm15aXloVXRjdzd0ancwM1hvZFQ2?=
 =?utf-8?B?MkR4eVM3YU90Y0laMnZCRklPZUVOS1ZtemlVd3oxVm5tQ0lLazhGVjZyekVP?=
 =?utf-8?B?MFpFSFd0eStUWUQwM25sVWVhWHNuWUNVZ2NlV3hoeFZudUNEbmxMNkNXdmhE?=
 =?utf-8?B?M0tmZU9WbjFIeXhTZnBDVVVablhOZzRYc0ordWVGdEhhRS9HSkk4SzBicmpl?=
 =?utf-8?B?OHY5ZTRVTlpEVUtQZUtUcHd5MkhyWWhHRDRkd3liRDI5L2RMbVVRVVV3STI0?=
 =?utf-8?B?OC9Wc043aE8zeDBtajhGRGpLNEFNUTJzMmdRSkZRUUZXbmtpN2NOQ1VnSEFI?=
 =?utf-8?B?S1c1djdEdTRxUnpIZHJKL0EyZmVvUFI0UkdVU1h4VVJjLzQzOERNbnJwTXZm?=
 =?utf-8?B?SUhISXlGNmtKVWx3dHM5SXFOQ3huWTlhYkJSVXF3S3FjMUhvWERyd0gzbC9i?=
 =?utf-8?B?RGV4dURIQ3ZtMVN5U0Z3RW1WTlRHYXR0Yk1ycjFwQnNyZmZSc05laDAyTWcv?=
 =?utf-8?B?UmcvZnBPcG1Jd2hnUEdKWVBSWHM0K3RMeWUrVUl1WElldDIxUVhRdW9tbld3?=
 =?utf-8?B?cURoV3A0M0VJNS80S0FVUTJxV044NHdxbHhsZlJkOUxKN2orNDVUNnpPcnZR?=
 =?utf-8?B?OElMeWxTTWlacldVV0Uxa1lEb1FVNmxjNjFSS3hXWVBvV2JNTVJWcitNaGtl?=
 =?utf-8?B?Z2trRkxqbDQ5MnQzQjlTZ1p1UzlVdzNuUXVYdjJBV2FwSWJxb3FDZmh5VDJK?=
 =?utf-8?B?bXZIN1d0Z0VHWE8wNTZRbkgvUXRYYzcyUUc3Vy9xTmY2T1pGVkh3bEd3WnlN?=
 =?utf-8?B?c243SU8rR2NBb1FkOHVwNHYrb1kyMVJXOG5EczRrZXVzL1VjdjdMdFd1VkZn?=
 =?utf-8?B?dlhGdnRLc1Q4M2I0VUxkM2hIQ0VYbWI2dXdzcUxhcHRmNDRjM0puQnliRFVv?=
 =?utf-8?B?OU9sSXlQQTNpY3hSbkdSUElDYmlFS1QxTk80UHZWY1duMWRXWDc0RzlOM0N4?=
 =?utf-8?B?bUVPWTZ3ZGZoczhFbWI3ZFpuNzBpSjVVYUphQzBtekhiUEhxRm5tNTg1NWNQ?=
 =?utf-8?B?N1ArNzA5YTB3blU2UUh3VFpXTzErQTY0aDZ0a3RtQTBNdjR3aEMyNTJhNGgy?=
 =?utf-8?B?R0lrMEtPTzJOUU5Cam9XWXJBaTU0N091bnJSZUZTSEJhTGhGYzdRYXUwSlZQ?=
 =?utf-8?B?SEFFU2NjekVZWG56V0wwTStaSC9uNXRKTUIyYkgwUkY2bFdvU01OVk1hQlMz?=
 =?utf-8?B?SWpkb3RJK2VCQlRSSnR2RjR6enkwa1AxazhzL1hiNjBFRjdNUzJCbUJGVitN?=
 =?utf-8?B?cmJ0cVJXZDhWeWlValNrOGM5NjFERjBtazhYQ0cwREI0WWpoS2FHWWtlR2ZK?=
 =?utf-8?B?SWNiQ0IyQW9KNndReitHNVFtU3l2eUpORmtReHpMcEwzaUMrdXo4aGp0RjRa?=
 =?utf-8?B?dXZxbnBBMlFXVzE2ZEYyeFFUNjdyUVVScS90NTVTMmNUOG5NR1R2c3U0VUY1?=
 =?utf-8?B?ZUZUQnMybUE3b1hYeE1MK2hNbWFyUDNRY1lBYWF5K0t4cFhRREJqTmlXR1hW?=
 =?utf-8?B?UGZYazYrOE0wOFhySnM2QkFITXYxZit1TGE5Q2VXRkM5d2dCWnhUOXFKNEpE?=
 =?utf-8?B?MGhyQ3IwMDZ6RTc2R3h1ZXA5aVhFZXU0cHBId3hKQWpnKzRyUU9mVDdzV3Y4?=
 =?utf-8?B?blVnYnh2OFRDWmFQKzU0YUxkcG1McW5GdDNyek5wbUZSM2hBMEE2cDNJWnIx?=
 =?utf-8?B?cjVCNFl0aHRta3ZJKzBrSzFRQWs0MGQwNU52Y2pDbDkrZ1FQSkUwQldiMk1C?=
 =?utf-8?Q?lTqjUFJcMbk3DvqE=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5490751c-77df-44a3-c361-08df158b5d9a
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 13:47:22.7116 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZUd6HdxXGIybLjabU2J+wj12Zn5Of27uwcYWvs1wKnav35fyA5dTZRBVg490HAWHZfEb6KBNF34cltm4EjjEkPAIOM4+vwsE3NkfgpcmULs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB7933
Received-SPF: pass client-ip=2a01:111:f403:c201::6;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=AM0PR02CU008.outbound.protection.outlook.com
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


