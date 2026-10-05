Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C4AFCA5FFC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 15:04:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDkCN-0008Km-1i; Mon, 05 Oct 2026 11:01:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xDkCC-0008Iv-JK
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 11:01:40 -0400
Received: from mail-westeuropeazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c201::6] helo=AM0PR02CU008.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xDkCA-00058M-Nt
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 11:01:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tBpZx4bS9mOLCfzPmsHz10Ejq5KJaKgnqVkIzKEoBOq40agZiDr6zi0cDjwN3dk12aLIufUwKDkaEX0p9i7Ok4yD3RKBpyAv4ohJhuKBJG6iDBT0ZXr6iYIHtGikBP0OK18cKA7l5qpbdB+2UEywwErsE6pSRUOAySDYlaXZLkpUt+FwjqQNojFD4kufgom49/NGEkwPVgh2B6ojN0TRnjwy9+Tau806IO6eJZ3qeSIoqbPy7nxKgfjAA0dj2VWSvXbOIOeUgSmY4AESOV8+1W8Jof5Gc8mDB3iKBj4jq0NRv8YvWvHmMmcoO7jqiFSTgBAZPw/7dGqMZZ4fYvcw/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M7pz+/dwZ2x/cB6u+akczuOQxtrm3QcNryzTw5waVXI=;
 b=ZVy/fViKFp1hp0Th7zUVAoMfGYmvHj/pSHM66IvzoD3kUbJSotlpeJdUunVGzxKifjL4/vnH2toEM/j0QBQY6uCe1iZo0RBzIbzb4XF/GwKf4fo+EYADisQdC5/Yz+AR/BqZ0R76qZmCrJtDvRLRotuDt4PY+hlfEitCb9rEuv4WWFdcIm/hDLOTtUEIdkokMpzv1zh3hrzucdHsF6Oc2jOQdbyaoUjsnyRSukhiQN7q2pZvMt1+H8jdst0VlBiIxn+zKSja0qgDosqGyqKtlSXu8/8W9Nab3RdDXkBd2Pr77AV0nhxAXhXErkdpNbjYxNmZHSGthF7uA7a83NpY4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M7pz+/dwZ2x/cB6u+akczuOQxtrm3QcNryzTw5waVXI=;
 b=kyXDb7y9sc0w88Ub0jeZi3t107Ggep/1Ovnyqx8EysgL71X6LWrovyguMecTnqN+5tM7sf1Chk6ATfdJ0lpNwpiVHoBgB+eUReDwYVt8QlVD6Mk/uXAYC/FhNXZH5VSrnLwE1wJtk+1jji//UibofrmYhNUdLL3yuMR7AZSaQgKun6csxj7AdQ4A0fgrqm3Sw2JWKwm9Nxgk/ohJXfqU5Kn6NJPuLTdAm1xX1f0uqV4qN+fF/CqbMKACBaVWSF5pZP13e0nZpijVpFyNVQ5hznAWqDSpswuyuAr0RDd52uwXj5z4jyTfGMFCMRoNuLx1+fYa/lnLdTrWUagDkfk01w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by PAWPR08MB9736.eurprd08.prod.outlook.com
 (2603:10a6:102:2ea::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Mon, 5 Oct
 2026 15:01:24 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0496.010; Mon, 5 Oct 2026
 15:01:24 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Mon, 05 Oct 2026 18:00:54 +0300
Subject: [PATCH v12 15/21] vhost: release ownership in vhost_dev_cleanup()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-up-vsock-vhost-v5-v12-15-40162390c68a@virtuozzo.com>
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
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|PAWPR08MB9736:EE_
X-MS-Office365-Filtering-Correlation-Id: c6386e8f-677b-4498-e81e-08df22f185f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|1800799024|366016|23010399003|376014|38350700014|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 3s57FrPFI6j62mgk3mIgY8xjKT7B/m9h7gmuyPlQ1sxU4QZpPcZrrXtR8peIpfH1/u73zYfTQUoU0ilAe/YO90hnwpFxZpNzuroV1BIdJi76oU9UBvArKMrnMuEmbElTPrtV4NUmLTiLorHSnFI4lVUajrXr6ZK5vEtoCFoqQhpJtmitLsmiBhScoV0QquUINchDbKk06VsjIl0zn/DhkoYTg+cDe+9s7tn7/uNVTAGtGxEuU5rkvtTruYn5oQ9pCn7wWFJJftiANkywdnafQLjn9f2s5cPHrnrbNSJ6XkTW0o0Yul5YpgJdUdnvYOYsbHrJRMS0QUiV1OCMQhtkBd5OlugDMKHJviI0cgzpqTSA+JseKeRKMU9fsd/1QnLkQOimYnk+y3B2lNPWbSz3nQEhOnMZ1765RYQ8Jz6yMgfamA4G/AB0sjLrQcglU2B6OcWZ5u+YkThS/VOMG3e1Ir4fLlzyM3L0k2a4+tpvbcaF1ocCFzNBq8grKY8qmn0/pEyNvS2mUyQecOdorrrf0xlqVMAVNNgdp4hee/0pixO+dLwY3rUplCB8Ug2q33Uw2O7zyo5efEcNhWXaZ20vSm5eWDG4FQCXVTWJ43/8dxRHFCiNrBwnw/SRHqJhWZXvNKPpZM+FUNCEZpa98UcpQuGmesMVjIydrpu2IhV5jP6wYRI3BJWc4yjmarY/Yvae1sVzv2jq1gKZagcoO76votoknQmWkymIPUSIkDJ3ceI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(1800799024)(366016)(23010399003)(376014)(38350700014)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SkZueDU1UHFxZk1SeDlMY3JEUlV6S0loZGtITkwvdGh2NGlhbHkrd1F0aUNS?=
 =?utf-8?B?d3JjRDNVNXZGa1M1b3dHVkZSakFUL0lDWTh3bUNyeEdQRThkeTJEUGRCQllu?=
 =?utf-8?B?UFNXU281L2VwMTlHbkQ0VE1WM0ZGTzBnWlR6em1URFNEaWcxMW9pUnhjMi9u?=
 =?utf-8?B?bmEvdUhJMDl1M0FDV1BnVGU3MXp1dFlRTi9CWDYrdGVqOXF3eVIwbGVsN3R5?=
 =?utf-8?B?dWJYeXh1U1FxNFcrN1RDVG4xRUJBZWh6aXFwa1dvQy82bElIZ2h5U1hsc3h2?=
 =?utf-8?B?NlFaRDRueit0K3lwQWpQcmNUVHc0eE84bjUxdTN4SmtDZ2labGFtRGlkNzVt?=
 =?utf-8?B?TWh5OVN6eWo4QWhSbitjSElBclRlZlFDemhlbzl0Mm42Q2w0N3hRR3QyUk1F?=
 =?utf-8?B?RklsbEJSNlViMW84U1NRbm82ajhHMXN5UDVaU1JRNGp2WWUrV2hkQ3Y3Ylgy?=
 =?utf-8?B?NjFTM2NESTlDT2hzVm5RaDBIVnNkSEtkWG1sUWErYVcvc3h3M2FXNlJQclpO?=
 =?utf-8?B?QVRpSXU0Y21jNENuOUl1NFd2Z0J0ZEVDWlRkOU84OWMxK0F3SVlFbm5LTHlr?=
 =?utf-8?B?RnBQWlJXQkJGSXBYb24rdnU4bUYyT1ppU0czck9Pdi8zYXZsWnpHaWk4dWk4?=
 =?utf-8?B?TmVibjAxUVVHSjVzV0tTOWVsQmZKOTJ2aCsxeHpOMkk5WjJON25FZ1Erb2Vq?=
 =?utf-8?B?MFZnemVSSGl6cGQ1UXpSNVdSM0dCcG1WWXMxUlQvRlBSMmRETUUwVDZwS3h1?=
 =?utf-8?B?bEJrT2hhcEwvY1o1OCtTSkJLeFRJbWJLWXhsdWx4L3FmRlh4L0ZWVk5LbEVF?=
 =?utf-8?B?YStPbHN3L2tFaERNZGlwVTJ3SUJ4dldNb2QwNlFBZnM1OWI4N3I1b3oxZTJv?=
 =?utf-8?B?TWp3NVlzY0Q4Qkw3STVEaUFzcWxpUy8zUmpzSHdsRU1QYWtualdIL25OK2ow?=
 =?utf-8?B?ay9nMmRrZkFwL29BcDVZN1QxNUNBNkw3N054U1BTeXFuWUVQcW95WmZ1UmN1?=
 =?utf-8?B?WXo0aGRPNk1kZENuTVZ0emJHMWdDbk11b1RSOFgwZSs0QS9PWXVFV1pEcG1G?=
 =?utf-8?B?bTVudldmR1VxNVp4a0hZZnRIZjlxblhwVnowV0hJU2t1b1g3K0dVU2hBQ29P?=
 =?utf-8?B?RXE3aTkyenRQR05hdEJNSkV2VlM4RzJkdnI5ZXVxL1RjamZWMXJsNVBIamdJ?=
 =?utf-8?B?VzI3R0JvS2dta24xSno5bVBPTXVYaGJYbjVwRmxKV2h3Q0U3TUJQd1k5cHJT?=
 =?utf-8?B?ekNqMVQ5VW0zbXZOUTdxYTk1UmN5Sk83UGJHRlFxc3l6K2xCQy9ZSVN2TytR?=
 =?utf-8?B?aHhXV3ZiMWR4YXNxakJqbWRwdmF1OWZxL3NXZ1laTDhGSFpOTWtWT3hrRElD?=
 =?utf-8?B?UnJNc09oQkVaK2wwbTVvbForRG1QMCt0YkdSNHgwS0xyb0U2SUovZzM2MGI3?=
 =?utf-8?B?aVpZVWhtcngrYUY2WENWeGp4Zzc1S1VsNndjMUd0QnN4RHZkWUZtQ00zek03?=
 =?utf-8?B?K1ZLNERNb0IrWnZKN3FmSE80T3dENnFqNVA3SkxoVjU3TzlvYlJ2M3NsemN4?=
 =?utf-8?B?cWErbWN6aUVoMnFLL0JDRzZ0UXltS3hsc2poa0ovN2NhcGFDQWRVQUhPVkQv?=
 =?utf-8?B?cHZyemg0dHNGRkdqRkI4REFMUWIxVG03MDhNUDEwUDZQNWFMRHd6cDZ2dlB5?=
 =?utf-8?B?UytydmZGZ1hqakEvMzljc29vZXhsekZ0VjZ2citDYm9JdHBOZU51anduMlRG?=
 =?utf-8?B?azVoMGV6OG1mMmQ4YVR0Ync1VFNRUDc4dzczMGp6dEF0SGkxbFdOaXdSdVd2?=
 =?utf-8?B?dkZQTGY0Z05rb2ZIa2JBNDhFRlFJVlFPUE9rSjBMS1d3RC9BeVU2L1dMZEJX?=
 =?utf-8?B?dng0NTlhUXZFaWNZZCtueWtJVW9sd1VLMXVOcXJqWk50aEVKT3M2bkwwbW00?=
 =?utf-8?B?UVhHVlRiQzFCZ0JYNmw0cFdUYTJLRDRvNkUrZVJuNDN6RDJQa3dCL2lpN1ZL?=
 =?utf-8?B?ZWtGREQyTUFDakd4Q0NKK21uZlBpN2xlQlBiNnVXaUFtYWlJWHZ4V0xDMHdC?=
 =?utf-8?B?VW9DbDBtaWwvaWV0R3RxNFJJekNWUWdoSTdMaDhOYW81Y2ltZTluaHg0ZEVZ?=
 =?utf-8?B?czJ2emRxRXVlVGVMcTB0eFd2bktDbGpjVGE0b0tWQkhjT1RBV2JuSzRCbUxs?=
 =?utf-8?B?SVdhTkFoUHNtUzdXTkJCRmFMK0RidTd2SkNHYlNJQ1JydFZuZ1EzbkxXMWpj?=
 =?utf-8?B?WTFLZENhc3ZVRmFQTG1mZFhldWVsR1JOVHZ0TlVGQ0hHSG43Wm4xMkxNa0pi?=
 =?utf-8?B?aXZYNlBQRlgyVFV5YjNXQkwwWmZOVGc5Tk9XSGZKek5qUGp1OFdiaGNFRzlt?=
 =?utf-8?Q?XrWpKaA/PN4EUcLM=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6386e8f-677b-4498-e81e-08df22f185f0
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 15:01:24.0734 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EyIXFQ6LmjQj20Yf7zYK43isEgIEyjW7l/wAMt3AP/BRTwp/QAuSM4JKFvBUW6PLFBh2ysJGtp4HQVtAVo56FH07Wh32FuyzqihthyheZtI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9736
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

vhost_dev_cleanup() closes the backend FD, but that doesn't release the
device ownership taken with VHOST_SET_OWNER if the same file is open
elsewhere.  That's the case on a CPR target: the source keeps the FD,
so if the target fails after SET_OWNER, either inside vhost_dev_init()
or later in its caller, the ownership stays with the target.  Once the
source is resumed it can't take the device back, SET_OWNER fails with
EBUSY.

Track the ownership with a new 'owner' flag in struct vhost_dev, set and
cleared by vhost_dev_set_owner() and vhost_dev_reset_owner(), and issue
VHOST_RESET_OWNER in vhost_dev_cleanup() if it's set, as the common
teardown for all those paths.  That should be safe in any case: the kernel
refuses it from a non-owner, and an owner is about to close the FD anyway.

Reported-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 hw/virtio/vhost.c         | 23 +++++++++++++++++++++--
 include/hw/virtio/vhost.h |  5 +++++
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index c01ccc800cb..1241c5a954d 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1705,20 +1705,32 @@ int vhost_dev_init_backend(struct vhost_dev *hdev, void *opaque,
 
 int vhost_dev_set_owner(struct vhost_dev *hdev)
 {
+    int r;
+
     assert(hdev->vhost_ops);
     if (!hdev->vhost_ops->vhost_set_owner) {
         return -ENOSYS;
     }
-    return hdev->vhost_ops->vhost_set_owner(hdev);
+    r = hdev->vhost_ops->vhost_set_owner(hdev);
+    if (!r) {
+        hdev->owner = true;
+    }
+    return r;
 }
 
 int vhost_dev_reset_owner(struct vhost_dev *hdev)
 {
+    int r;
+
     assert(hdev->vhost_ops);
     if (!hdev->vhost_ops->vhost_reset_owner) {
         return -ENOSYS;
     }
-    return hdev->vhost_ops->vhost_reset_owner(hdev);
+    r = hdev->vhost_ops->vhost_reset_owner(hdev);
+    if (!r) {
+        hdev->owner = false;
+    }
+    return r;
 }
 
 int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
@@ -1864,6 +1876,13 @@ void vhost_dev_cleanup(struct vhost_dev *hdev)
     g_free(hdev->mem);
     g_free(hdev->mem_sections);
     if (hdev->vhost_ops) {
+        /*
+         * Release the device ownership if we hold it.  Needed e.g. for
+         * failing CPR target, so the source can re-acquire it.
+         */
+        if (hdev->owner) {
+            vhost_dev_reset_owner(hdev);
+        }
         hdev->vhost_ops->vhost_cleanup(hdev);
     }
     assert(!hdev->log);
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index 73ea130d7ee..f6e32b59ab2 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -111,6 +111,11 @@ struct vhost_dev {
     bool started;
     /* @initialized: has the full vhost_dev_init() completed? */
     bool initialized;
+    /*
+     * @owner: has this vhost_dev acquired the device ownership?
+     * Updated only by vhost_dev_set_owner()/vhost_dev_reset_owner()
+     */
+    bool owner;
     bool log_enabled;
     uint64_t log_size;
     Error *migration_blocker;

-- 
2.47.1


