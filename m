Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB9FCCA5FE3
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 13:05:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCcwe-0002NM-8p; Fri, 02 Oct 2026 09:05:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xCcuN-0000qR-RG
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 09:02:42 -0400
Received: from mail-francecentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20a::7] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xCcuL-0007Rf-Vm
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 09:02:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OO+/c6Fa7pRrxUwhZ7EQoSHFlDv3uKkkfW7FiYnBfKDfVKfk/hbmFh3gkkXkyN4iiChZCYOM0OvRdJesj2HbyvuIlLNIfQOCgc6mSK1VCfoqWChCMASrKDNJW5UMmsq2VfpiK2Otrwqgj4tRs5a6wyCaYKaw8aX3GFoB2yO3M9fk3NYl6j0HDgvMkAytWhUx8UPaOraOhZ+JWBz9xndxnUaK+G92G49Y01K+Pv2ykm8oB0TObK4a5I4DjE+dpJX9Pb1/Qb69XcA5bHTrS5eCqDn/KzqzTIBbVYVbzGG6w1yKAh+jcIlibIFjwLucugorJ/3Clqk+t3yceSZLM6nAVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sHHQWvyyQn6+5Euuhy9WC7KjNkJ48X/h0f0vPBXju+8=;
 b=ffDQ5emEDQr71uRZEi+ykDlO+jYY5IIrjTwvfypp8vKs24+RU4NDmvFKuzok7z0sXvDO5jNmrBr2e3b1/92NCUAu12F6yI2rI6AzxVrfJ3V3UrL2uFcjZQ+/hC/7aytz0yWjd3FG3rqYQFej1kB6Q+LyMXl0ejVMXKxbJ69wlyxXHZhD3iMyjgZHiwIiHU7g4tzC2hkKWK/yH/WeVXxLRlURj1Bhgp7m0VydOZFgu6xKndRYsDtD+yXNzyiaZVsBBE3Pdzl39fSHxmk7mu+YUW/G78+QR5WsAzoCqh1KRem0yOShKjnJk/jK65IHy+dBgRD/v8QCNDwDYCHTwB2VSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sHHQWvyyQn6+5Euuhy9WC7KjNkJ48X/h0f0vPBXju+8=;
 b=kb/PoOG8rQuL+TeF6zIwMw8n4htYuI8wHAC0Gx76Wbii1GZOXgIEiBfnEd1hPOtGrQM8zh7Y4ncYiRcE59+nr/bGwvMDTjQtWx9xwb4pgyzVHNci3x4SkFvWzMe21iRzPCivxdttHdMT2IukeOF9de2mwlzQuCbFiA92IzAC8zIpjHoMuZZidaWZ05B8PAM7UVu6NiAfyF2Jcn5wWwv+vJBQvkwreRQ+i+D2S9qkLdXRfKvfVmA5BHgufjJHALkN4wVfFIGoMcmIo6iXoDw3teaPOgsR/TfEXoDgU3wN2mPZsKs2P/KaN1aEEWRdBmsxFlKDEGpsZRERK8nhUjzt9w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AMCPR08MB11995.eurprd08.prod.outlook.com
 (2603:10a6:20b:76f::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.12; Fri, 2 Oct
 2026 13:02:33 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0472.012; Fri, 2 Oct 2026
 13:02:33 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Fri, 02 Oct 2026 16:02:25 +0300
Subject: [PATCH v11 16/19] vhost: release ownership on exit
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-up-vsock-vhost-v5-v11-16-18fa09d8273d@virtuozzo.com>
References: <20261002-up-vsock-vhost-v5-v11-0-18fa09d8273d@virtuozzo.com>
In-Reply-To: <20261002-up-vsock-vhost-v5-v11-0-18fa09d8273d@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: farosas@suse.de, andrey.drobyshev@virtuozzo.com, bchaney@akamai.com, 
 dongli.zhang@oracle.com, vsementsov@yandex-team.ru, philmd@oss.qualcomm.com, 
 maciej.szmigiero@oracle.com, mst@redhat.com, dwmw2@infradead.org, 
 mark.kanda@oracle.com, sgarzare@redhat.com, den@openvz.org, 
 odaki@rsg.ci.i.u-tokyo.ac.jp, peterx@redhat.com, clg@redhat.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VIUP296CA0042.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:34d::6) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AMCPR08MB11995:EE_
X-MS-Office365-Filtering-Correlation-Id: e829768f-38f6-4afd-a247-08df20856b90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|52116014|7416014|376014|18002099003|22082099003|38350700014|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: MY87gpx3/rlFs2eoyTWLiRxEM61qbZq0sml/N6YO6/ZrcwUQQ+dPtRTkUEVXp3fR3opDuwZm7Z8pbnd2UdyMATcAr4O+LZyvyrGx3ERKA6enx0BEA7tUQkpWCs/MqZKukY4NNglu/2DG27gWMCKbq/I81VudGcs629F+ECKScJN0ByRI0/Rtaay7JX1J6te6JHINzhY0F6N7JDmxrRQgE9Wk61825AsD0xLQBLoAbkaXf6tiF7bk+sFa4pIKlQMRh5zN6LJT9VBQSS4abeTkCia+s7HeWvriscqj1lQrS9+rdEUrshnfX7RnkIZJjrH04Q3GhxUIzjwownFNxG7diu5HwtzveFMN7JdgY4N59faYZ74iwBpWt8m9M6zB144VHFXBHcrAxtCrDyBGxY/IKjDUIi3KuRJePXQDVrqG3tTP+OjtgBFnI5qecgg3f5aLqzV8BXkHbYHVb/GMZrZHhZwBT2m089hEGEIHUE0egQQgNp4+VTeYROiZRf+KwO4cjb8A+pMdZ0r1FcLCm2U/whY7m2m06WbLLjK5pZjeDg7B3mXt0xcHANMKVjxhIm9lJqLOMh61/z6jhNC1H2PWeFdZ8khg9RZVvsRlSRKv935esEB3AWwfYfZ51f2cM8poODCtKBLwUhAQnRgwa9i50DrbtXqYRoAzovb5hlQ/X0UR1QjNbrLmswor/Xe91q3MdWCll1l5OZr87z90o2cFx9BO9nS1ZfE8Dj30GPWtiJA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(52116014)(7416014)(376014)(18002099003)(22082099003)(38350700014)(10067099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHJoQUJxSGh4ZHFpNjdiaUV1LzJ1NUx3SktTemI0VlVYTjFYbmk5cnAybytu?=
 =?utf-8?B?QlZnblhScm9ycGNmR2RrQzc0RzFrc1NhaHVyMktraDM2RkNoUXVwaWZSZWNQ?=
 =?utf-8?B?K2hlUTZ1RVViYXRselpVYXhRMjVjTXM1TFBCY1Zsd2lweGw3MkhIYzJUQTZ3?=
 =?utf-8?B?Q29iSGk4M1FvcVRvRXBCSG1TSU1CWUtJN3dxVUlaaTZ6SnEzOVJlNjc3dTFi?=
 =?utf-8?B?TFR5dDBSYmhIakxqaTZYd3drVkl0MDV4UnFHY3VPMmw0blk3NXMzYlJBZTg4?=
 =?utf-8?B?Z2ZIT0taMmtmc3Btek1QRFlDWlArWGQrUzZ5OWFlVnJ2ZU1naWE4VmJQSGxN?=
 =?utf-8?B?NXdDUHVkeWJTbmFodEEwS3RDMlJhL3lRZXVudHdURFlmL2wzaTU5cGJmVVJl?=
 =?utf-8?B?QThUSEpRdkxqN1I5K3RxV0MxVHg0NGxnY1ZTUVJUSk1IeTEzUDd1NXZNMTZh?=
 =?utf-8?B?ZndNN08rczVMeWRMaFF0dzNCZ09ueUJwOEtUWmtEWUhBZk9NaSt3eEVlMFVy?=
 =?utf-8?B?Rk9WYWtIb0lPV2txNXRObmdzZkd0bkhKcDVhUXhRcGFYSmJZMmpDUnprUkdG?=
 =?utf-8?B?K21Dam54UHd3ZjFjbDRxdUQ4NWwwWGNsMU5ubmRXZ1dSUlVnMnlnbitzRENt?=
 =?utf-8?B?eHJkZUJPZWFqeDQ1a2twdEpjMXFNOGptdHl2MlAxZVlRY2hDQzZiSUUxVytG?=
 =?utf-8?B?bUVMUWxlVjRQd2hMRDBBQ2FaU09tQnk1cURNT1BJQjVob1hQL2U5R25oRldx?=
 =?utf-8?B?TGNRTFJIQjVWeEl1ZkhVMHhyWGNHM2lDZ1hremNiUXkyRW9aY2ljY2FHQmhI?=
 =?utf-8?B?SjFTckpmOUtBeFBPK1IvZ1lCbys2Y3hOcFhDSUk1ZlVSUm5mRjZiWUMxTm1l?=
 =?utf-8?B?NjJ5VkdSajZrdmppMlpqU1MrMzM0cldSV3JzMTBmRWFOZzhHbFpTeHdRdDVs?=
 =?utf-8?B?OEhISlJFeVJpdUlrTmpRblR6R1pNdnQ5dm1Od3dIU3NXZnpRNmZLcE1XcGxL?=
 =?utf-8?B?M296UkpTbXAxMVFKYU5YNXQ4UGNUTytER1pzSVkxTHJERWxLR1ppMFhqT2dW?=
 =?utf-8?B?d3BqWjZlMmF0Mm9tTkJML01QWFY4V2l2OFRTWmY1N1FGb0tYWUJjdWNhT3F2?=
 =?utf-8?B?U25wUU5Bd0JONUo1R3NabVViM0YrYTJGcms2M1VDQXlZR3RlbjIrQ2hhT0Rv?=
 =?utf-8?B?VDh1ZGxlV1IwZmlsUFllaTdzOTFMR2xJV25TaGRHVDhxcThKM1FVUW5RWnJv?=
 =?utf-8?B?YjJ4OTE2U1cvUWkxbnk1ZzFXWWtnWlJGNVB5ZmorMDZSamw4TFFldFZCNmRG?=
 =?utf-8?B?N3hUWjJHN3ZvV3ZMeXFHT01OTjJwZ1dMYmdBUU1pMzZNNnFsNUpmWjBsR0Ro?=
 =?utf-8?B?aG9rQUp3NG1Tc3B3M09uODNuUFlxeTEzOTRWc0FPNHdyUExWSDB3cXdqOVd1?=
 =?utf-8?B?dmF1RVFwVFBaQ3pYMnQxN05iZWZraWh2TjYxRlZwTjI0RjJENTl3TFNrbWQv?=
 =?utf-8?B?NUx4YWxEUmNmK2pQVlJsSSt2UkNsZVMwU2JlM29CRUVLbFRvTlpCOWpQa2JP?=
 =?utf-8?B?MWtrOWI0QnV0dzhLRytzNjQ5WUtQRzJSYzBVQitOZ0I2d0VSamdZTHdoVUZt?=
 =?utf-8?B?Q3JCdVYzQ2VtMGdzeGxkT0dvcjZNcnBaTmp2N0Rib0VOQXU1emNJdDBjU25l?=
 =?utf-8?B?b3kvbm9QVE5HSkQ0S2VlUXFnbCtITCtBR3BKcHo2U2FJNUhqbGlPR2xpV0JC?=
 =?utf-8?B?MHdrWTd5bU9jUUlCMGw5VHhoYXdXT3dTT1BOTzExckcwYWJ0TkdueWhBRytw?=
 =?utf-8?B?R3J4VVRwVWc2NVFQUURDOGJTWHF0MDFpQWlVdzVIeS90K0xOK05mUWlJQTdO?=
 =?utf-8?B?Nk55ZUtkUVpEUUtMRno4bENxUXlBZ0lGRlU0M0UxNFg5MlRGajFvU2YzaUJQ?=
 =?utf-8?B?eXdzNWxobE5TR1pJT2tJVDBQNCt5RnlhTzFYUW1QQkU1Um1ZWG5GUE1jeExR?=
 =?utf-8?B?M25MVHArNWNqazZlaWpVMXFCdjAzSm9PcHJCU2NrMFk5a2crak5HVUl6aXUx?=
 =?utf-8?B?TTR1dExWVkEwMGp1aEx6R3F4TitLQ2Y4UGxyM25jUjN6VGdrQW5aNEQvR2ho?=
 =?utf-8?B?Sk1MeDRUWkkrY0FpS2M3ZlJLU1dCR2dybCtWaXlKYllxZjFyMDk4TmFGZzdH?=
 =?utf-8?B?R2V1UHRtamd2RENKRG1Qa3lJTGZyZjhMOUhScG93VXFHT1pOVytrc0Z6NWFV?=
 =?utf-8?B?K2pZZTZWbVJQZWtpT2llQUMydFNvbnE4UEpiZE0yWE5DbTJuN0FSa1VQN1hk?=
 =?utf-8?B?RTJ0UjVydm9LT010SENSdU1vTFU4Q2sybjkrRW5YNEcxdUgwVWI1Vit6ZjJi?=
 =?utf-8?Q?K5M1c3w0L62921JY=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e829768f-38f6-4afd-a247-08df20856b90
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 13:02:31.8590 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7kA5hgCdsEfIGX1wdgZksZDEYOc6LjdsCC1+tWbcL7N2LE39zlntC6+TiJm4Z3vtqANSbYRX+4GKoWoCXaMCtUz2D1gBWtUUn2EdrZ2XOIE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMCPR08MB11995
Received-SPF: pass client-ip=2a01:111:f403:c20a::7;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=PA4PR04CU001.outbound.protection.outlook.com
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

A CPR target that has taken the device ownership in post_load() doesn't
always reach vhost_dev_cleanup(): a subsequent load error, e.g. a
truncated migration stream footer, makes QEMU exit() right away, and the
ownership stays with the dead process.  The source still holds the FD,
so the kernel never releases the device, and the source can't take it
back after being resumed -> SET_OWNER fails with EBUSY.

Add an exit notifier to each vhost_dev, registered for its lifetime,
that releases the ownership if still held.  This covers every orderly
exit, which is every failure QEMU detects itself.  A target killed with
SIGKILL or crashing still leaves the device unrecoverable.

Reported-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 hw/virtio/vhost.c         | 22 ++++++++++++++++++++++
 include/hw/virtio/vhost.h |  3 +++
 2 files changed, 25 insertions(+)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 1241c5a954d..60cbb763e35 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -30,6 +30,7 @@
 #include "system/dma.h"
 #include "system/memory.h"
 #include "system/ramblock.h"
+#include "system/system.h"
 #include "trace.h"
 
 /* enabled until disconnected backend stabilizes */
@@ -53,6 +54,21 @@ static QLIST_HEAD(, vhost_dev) vhost_log_devs[VHOST_BACKEND_TYPE_MAX];
 static QLIST_HEAD(, vhost_dev) vhost_devices =
     QLIST_HEAD_INITIALIZER(vhost_devices);
 
+/*
+ * Release the ownership of the vhost devices still held at exit(), so that
+ * another process sharing the backend FDs (e.g. the CPR source) can take
+ * them over.
+ */
+static void vhost_exit_notify(Notifier *notifier, void *data)
+{
+    struct vhost_dev *hdev = container_of(notifier, struct vhost_dev,
+                                          exit_notifier);
+
+    if (hdev->owner) {
+        vhost_dev_reset_owner(hdev);
+    }
+}
+
 unsigned int vhost_get_max_memslots(void)
 {
     unsigned int max = UINT_MAX;
@@ -1823,6 +1839,8 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
     hdev->log_enabled = false;
     hdev->started = false;
     memory_listener_register(&hdev->memory_listener, &address_space_memory);
+    hdev->exit_notifier.notify = vhost_exit_notify;
+    qemu_add_exit_notifier(&hdev->exit_notifier);
     QLIST_INSERT_HEAD(&vhost_devices, hdev, entry);
 
     /*
@@ -1872,6 +1890,10 @@ void vhost_dev_cleanup(struct vhost_dev *hdev)
         memory_listener_unregister(&hdev->memory_listener);
         QLIST_REMOVE(hdev, entry);
     }
+    if (hdev->exit_notifier.notify) {
+        qemu_remove_exit_notifier(&hdev->exit_notifier);
+        hdev->exit_notifier.notify = NULL;
+    }
     migrate_del_blocker(&hdev->migration_blocker);
     g_free(hdev->mem);
     g_free(hdev->mem_sections);
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index f6e32b59ab2..6bd19d1d51b 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -3,6 +3,7 @@
 
 #include "net/vhost_net.h"
 #include "hw/virtio/vhost-backend.h"
+#include "qemu/notify.h"
 #include "hw/virtio/virtio.h"
 #include "system/memory.h"
 
@@ -116,6 +117,8 @@ struct vhost_dev {
      * Updated only by vhost_dev_set_owner()/vhost_dev_reset_owner()
      */
     bool owner;
+    /* @exit_notifier: releases the ownership at exit, vhost_exit_notify() */
+    Notifier exit_notifier;
     bool log_enabled;
     uint64_t log_size;
     Error *migration_blocker;

-- 
2.47.1


