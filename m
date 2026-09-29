Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97285CA5FAD
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 17:25:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBbYh-000678-FD; Tue, 29 Sep 2026 13:24:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xBbYf-00066P-Vf
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 13:24:01 -0400
Received: from mail-northeuropeazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c200::5] helo=DUZPR83CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xBbYe-0002lB-At
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 13:24:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nbCuMZKgqeHDl+sWZ8jBeJVwzSN/x+hdAvdrGbsElmL8cVU7x+p2VHfxp6q8lteex5+4W9k+0VHEkfSJ8rptmvBEqArUhf94Gu8oFO5skWTb6g+XmtcUfW1SHRtXV8vL7pZrlz1qPiu9BOw3iYotH5CGlekxp9Eu9btk2ngHAhpjKCKgVWAOU56fkPhRX7ZK502OtMsnglJVIfkR0s96QbnZs8dYa7QmqpwIQoYL+jrKCUsrksCsJg7gMHw4+zj0zoKlaSV6ErpsxfRG3aGNjM/MhlN8KfHVGVXpC2nygAReurdj4bxJvYZVvDgbf7LrswIhACu3TnfCn3rmIDehnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gWXhh68le3RfUJjypRVq8x/GzIl/qjsOycrfUzYBtG0=;
 b=I4WryE40TM9xvPZTh0kJHDLOIMP4U748f6s07tEDm8FdopxCEdDsMgj0dnPlEL3cnT9JjbEKnosz4/Vc6UYinxcADrKttNLNK8Fh6K39nkCtrWhPn/570XmwZUZy51vfauN3HTLHKYJCsO3MGPUKxtG9KcpWe2dMLC81aNbKXa1xqKBBwL6tw2TN0CJzHCGsliw+qVciQmbuvUTW4ov5EHPLAAb6qJcqaKTaAr244PelBCQvm0VkgcF2rvHYLLyNnwuyqVEMgy1j/udY3BsB5NnVjmhk1VMl+aCMVw2PcoJ6BNrPEyy0IxT/lwGB1x/Qq3W43Y5j/hjETpwVKmz46g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gWXhh68le3RfUJjypRVq8x/GzIl/qjsOycrfUzYBtG0=;
 b=UnkqXhso5A8XRdcA125u7aKEPwj2QMbKTrRDRtoc7LeGQdmsJSawmbb6PAc4rco0BgqUf0P2oywVRUhR6OTlN4W5ReTcFO/OfIVyYAiBVo/XU4afzyW4drGlS85+V//zitlvNRXlsqCbQ6CPn9kphgx1bvj7tw4F1eX9o5clQLgi1a1io3ZBe/8VLFA60VcEBSooE8BbiZy62XHexxW0Es0HsoeTx+u1PGoKz5DxlO95icXZwXvJ2rB7HYuN+ChyJ5LRBUEOOjPYDAr3V84JQ/91V4+4EEz2me0ON4Nk2m78edN6Tt8fGtUdGYNJTNFGkBuwtWvrAi3/ywhe3udTDQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by MA9PR08MB435041.eurprd08.prod.outlook.com
 (2603:10a6:250:101::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.7; Tue, 29 Sep
 2026 17:23:54 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0472.012; Tue, 29 Sep 2026
 17:23:53 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Tue, 29 Sep 2026 20:23:31 +0300
Subject: [PATCH v8 12/17] vhost: make vhost_dev_cleanup() safe on a
 partially initialized device
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-up-vsock-vhost-v5-v8-12-12bcf1c0b84a@virtuozzo.com>
References: <20260929-up-vsock-vhost-v5-v8-0-12bcf1c0b84a@virtuozzo.com>
In-Reply-To: <20260929-up-vsock-vhost-v5-v8-0-12bcf1c0b84a@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, maciej.szmigiero@oracle.com, philmd@oss.qualcomm.com, 
 odaki@rsg.ci.i.u-tokyo.ac.jp, clg@redhat.com, den@openvz.org, 
 andrey.drobyshev@virtuozzo.com, mark.kanda@oracle.com, 
 vsementsov@yandex-team.ru, farosas@suse.de, peterx@redhat.com, 
 sgarzare@redhat.com, bchaney@akamai.com, dongli.zhang@oracle.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VI1PR04CA0130.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::28) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|MA9PR08MB435041:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d1a9ba3-6671-4dd6-1159-08df1e4e6f43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|376014|7416014|23010399003|1800799024|38350700014|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Lw7RCC96Cieg/+q4aqBSiIFGBxds3H5OT8Sw7mvzNL6J6j/vYlg7OtdCDlcu/QT4MNg+stBcbBZH5BaV1/ZVQAk4Sh9xTfhwwUDgyHIgR8Eah4AhpxIeUnLazzPAPoYsbaHmkjELEot4pVRKHPsi3T28uChZNU0AN3lNtbU/BRvV0bw+3QRQDjusZs8bxT9wh4cdTdzDrX6VLqbC+pmmj+TtUuPP1YsK7Z8B22hak5IR65xCA+3VEg/PduTkaFwmll0e7s5gsF0XBHi2uv2Ut1Q5VpSSKQ+nwEZDhGhXlnmmCxXxJwHRantZs5tHj7lBbBjFgpsBRmrgJ7Yts/wY8xJiHsQP/YwpOAia/IGsje29TAvJbkaBibOSq3EiKCw/JXvP4BqEPbzjRozhL8O0ifE4m2ygCzGP7UteSsdFZt6s3QiahjsNDM3ykAoJw6/bqUkTNXL5ru2iPlo5rLTGsf2xrT4iAv2O5HY7onexjnlaBIeCj9aHuTmK2ynbOrYOJ+HDHuIK4KHX0crFWn+xoIwBKS6atYz2kBLYyDZfj7QojrGa+tRTnbqILM7RIHZgLpInMoNe1J0VIgTOPLUT4Ek5slHQqXVScnPPpN4pbQ74I6bhriT/6DBhHHS5/H6p3rM3ALk+owq8IlJZ1bcilNI7A/1o4moQx95UHJ6pEbmFs3dWLfJDoxiWJjRmYg+D5FmxT4N9y79vvKKVpr71mcPqXGWvjYv1ObEqtEsbo3Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(7416014)(23010399003)(1800799024)(38350700014)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGs5VjFsRmNOWEVBZlRHUlkvWVdLekF4a1YyeUZDV1hBVG1MRlBTYnRWRUZO?=
 =?utf-8?B?OWNRdGNDMzl6WklZTHJIVy9TcGM0b1VSQkRjSjVvVUFFWDdoM2c1YlF1TnY1?=
 =?utf-8?B?NmFEOVA5N2pjczJMNUhtNlllTXBIcGpnVHVNWm9UUS8vaGZtc2pyc3JRQ25h?=
 =?utf-8?B?MXF3Mk1kNFJjT2NVbG9VYUFZQlRXL3g0NnNLWUcxZXhOODAwYmVERnJUMXdG?=
 =?utf-8?B?Q2xrcHRtSFRvZEpBUU04MGJ1MEg4TG9jbEFaY293MmEwZDVURk9QZk9oMTht?=
 =?utf-8?B?ZEZXa0ZqUEt6M0Ivb3RXeHR0QW10RU5rWlp2SFJuTFM2RkgrcUpOdlVqT25u?=
 =?utf-8?B?RTJSK1FXb2EyYUJYK2pEK25Uc0Qvb2xubXNQYWJmVU1WMGNqMVRubEdCWjVu?=
 =?utf-8?B?eTNncWd5SSsrQ2ZtQ1RNVk4vK2EyVnluU3NXdzZJYzBoWlIvMWpUbm9nY2V5?=
 =?utf-8?B?c25ScGo0NGtPdVV3bHdORFUrZGRZUXZLcGRFbG5aRGIzeURTUlpTUDArSjkv?=
 =?utf-8?B?VCtWZ2t3RGd5eGhOOXVJZjBGdDk3Y1BNZWRBSXdUVGVpSTZ0TFRtU1NzV054?=
 =?utf-8?B?SWV4SVNTeXlJWmFHWDJpY29HaDFLTUJJNWJTbzlUQ0pJSzhLNUxWY0tiU1hP?=
 =?utf-8?B?bDlCdWVaMWwwa0dUczdFdTdHdVRwWFBlY3FXN0gzL2k3VXRKc3Y2NlJ1VHQy?=
 =?utf-8?B?OFl3UUNvZE14eEE4bzJkUUQwZTVBUjNOcUFqRk1IRTZRZzZFaEVZbTVDMnZp?=
 =?utf-8?B?bllralg0QjNKenFSMzhvS2pwSXNRenMxSUlidEVPM0xZR2VFSHpHK1pBQzgy?=
 =?utf-8?B?S1FGQ0RkWWgreXlEbWZ4OVloZVRUVFdXekp6LzVoUVcvb1BOMmp0NTM3U21n?=
 =?utf-8?B?ekttNEFDVElLUzJxWjRRSlJBYTBYM3lvNUpJZkFOZGx4cE5ReXN3L1VWNzAv?=
 =?utf-8?B?Q0hHME9wYW9vVTJMaStlbjlPRVhrLy84S2RsWHc1UXE5VTdLNHlLUVcvVm9G?=
 =?utf-8?B?TVV4L1lhck9KcmlOVVJxMzhIVzVLYysyUnh4b2F2bjY0QW5NRW9IamdGazBO?=
 =?utf-8?B?WXY4QTNsNzM0WDkrbjc1OThySWg0bFJadWI2VDFYMkhUeHJubVdUeFNkOVNh?=
 =?utf-8?B?Y3ltZUJKY0ZUc1VFSWVDRUgzcHZkeXhrMld0d2tKNmNTRWhjQXlzK2YzdXNm?=
 =?utf-8?B?Z1hQMWZuRU13QWU1U2s2SWpCOXJBNGVmSDU2T3IvZkVRZWlCQkVUbWxlanlN?=
 =?utf-8?B?UUFlNXhFV2ZGL0N2d29QS01hdDBUVmNNcm40d3psazRPRHFyM1FQU0VhU0hi?=
 =?utf-8?B?TC9JS1NYMzFzUTVlMTlNVVJXdVZoMitwaUdoRVBtU3BmLzU2TDNWRzRGRmcw?=
 =?utf-8?B?QkY1cEZhMDhQcThBN0g2Rzk5Sk9Ra2g0QnJJZ1Z6RUw4WEVaKzNBYlVFOHZH?=
 =?utf-8?B?cDdOd3NNdk1sZmc5eVEzRzkzdTBnbFRiQ2daaHA5eW5nU2p0S0cvVlVTdzRF?=
 =?utf-8?B?RDF3U2h1UGNnVk1ONXBQaDhzVGd4YUFzY1lSa2tLUGNZdVVNWkZXaUhQTVFa?=
 =?utf-8?B?U096NlRJUnZaaHlveDlsM1U2TElOcFUwNUVkMS9HdERDYkkzNVZkWmJ1Mko3?=
 =?utf-8?B?TGcrNWxNWklJKy8zZWREUjB0K05DeGxlVnhxckdRQmNmSzlBa2gwZE0yZlB0?=
 =?utf-8?B?UU1RcVM3TWo1RGtmelJvTWw0YjJ0UFF3NWtmVHFHczVXVGJVWThOYjRheVFw?=
 =?utf-8?B?K3JvVGVKa3FpTFlaWXZuREQydTA0bHY3b09FbEhpNy8wSk8zTXhyMjdYdUpL?=
 =?utf-8?B?WUpTeGVPU0VyWGh4MFlQdmdlL0VtbTRFcm1PUXk2N1l6Z1l6dEhST3podE05?=
 =?utf-8?B?TGpjVEFNc3EzR3FBUG9ubzRpazlpR1JReW4zSTJPMWg3V1phY240SnJuTkpP?=
 =?utf-8?B?NEtzZDZHcndzNDRGelNLR3BSaW5kNytrNkFoVE0yTS9KSkR5L0tZWDJIQ1BI?=
 =?utf-8?B?RWhuYjZZWEV1dHUrUzd2WVFMTHZFdXR6b1psVCsvYndLUmVmbmhSZklvaWxk?=
 =?utf-8?B?YjBvNnoxUWswYzhpNmtTSkVsaTNWVTVuL21LNjhzMXpDZzZsdEtiS2dIWVoz?=
 =?utf-8?B?Z0I5WDBjaUFZZ3BRZkRtTStQTE5xV2NHcEVoRFg3UEtOSW50T0xLRFdrMkVD?=
 =?utf-8?B?YVVmaVVKMHhkdXQzd2lRVEc3QUtXR3IwVG1wbklHUWRPaGwvR1MwQmVHNDhF?=
 =?utf-8?B?bzlXeGd3Umdoa3NVL05od056bE45QjUzaDBUUDVvNnFTdGljVC9EQzBLTkh4?=
 =?utf-8?B?RzRmNTB4SW15UjM5MVhSUGo3Um9LaVZrN3hZcmlCbzlJOXgxK1ZvVUIzQXVa?=
 =?utf-8?Q?wusWMfyxY7ciXLds=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d1a9ba3-6671-4dd6-1159-08df1e4e6f43
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 17:23:53.4343 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5COAtmCw7lSHNNxiPpxfI1HMAOD+PmY+i4TeWUozgsgvRFA8SPAhsUDvkb2cCO5kdWBlA2vgToc1/HPCSRY8oN9MNeu7cwwT+B0EUpnNg/0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA9PR08MB435041
Received-SPF: pass client-ip=2a01:111:f403:c200::5;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=DUZPR83CU001.outbound.protection.outlook.com
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


