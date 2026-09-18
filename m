Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DAB0C982DA
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 13:48:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7YwV-00039L-Ja; Fri, 18 Sep 2026 09:47:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x7YwT-00038p-QC
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 09:47:53 -0400
Received: from mail-westeuropeazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c201::6] helo=AM0PR02CU008.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x7YwS-0003Df-Az
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 09:47:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BkC6+UIOdqlJqwoD787v+AvFyHdkzpLegiYkXunPzI5US1dUCZdvtHad6BfGg6k3BlwubqEaeBrdPKu3uBftaHGCizXeLcqHkD1RqAToMZJLKlTPlAKfjHKByPjXre+2tTrWckyh+r65TjBu1lZZMEpqgUj8Q+ZsB70AYfh23fBv39ctATA/knpy2PXdi0oLSAjSLwWc5FsZAhznA3OfmynOxZ0fsBSfmNAtds9SfCHVKw8rLLZUx9OlI4CIAfUGDpq5t2nBBTxEm2iw1d3oiWdAZUyYEXnxFRi+8BOIBXaw2im/ePYHrCzhMcj8w2dNytC0jx5NlkxbQD+sqvlTpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gWXhh68le3RfUJjypRVq8x/GzIl/qjsOycrfUzYBtG0=;
 b=XR3XzoYtSQd5Gzo08hIIlgRNbdMYc2Tm6P9oHXTQPbVr/XPnvPv9VL2byoAKh4W5IjjnQNMY48F8fdM6KaGtNibKP4y9LLXHQ55lZL/KIa6LXdJkiw1rU3r3K/k5iph1cjs7UUQzEy8pbmwU/UoI43zH8ekarn2vizG/ZQWzC/WUKLCESiIgPW05fGfiu6WpOz+NRx5g7devynuPkqqI9/ehgsGJ+T0dZXvvAReL9UXBv3euq894i3D2rafBai+QJbRRfiqwtbVPyeDSEy4RNCK2PebRUwTLdWaXp7xDOyMuv7Gm8UQzyrIeXiIE2FUwhDUAa7/HM3IoPAmULNNjYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gWXhh68le3RfUJjypRVq8x/GzIl/qjsOycrfUzYBtG0=;
 b=Q1m47cDF9+mE9hQPiXPzEa9oKsgoUDv38pk7VL0N4PfHfs8nty32vlXcc2zVlSGrBH72Dw6bxaj/8sTP3b+5pcQ4Swe/i1EI+38SfWuUCtEYWv8Zb8xfXjTqrc1ggHG5sKmXgihrOi2cv3mdNTJUwlpRdpooI76KmxLDbsp1M1VJO5+FxJGVEQksdDEem5ev6nzHrAOZ9jPUqhHN2ZSxs7isjZSY9PF1O9H43wLi5I3pkMBjT2L8glMoV/RRVNhedXneSaRkZShVoqHBT/M3QsAD352uYLjMV196owprYV7v/m2hnPQGLKvhpe8h75sRwzFEGIQgHb3NY/ZutLSidw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DB4PR08MB7933.eurprd08.prod.outlook.com
 (2603:10a6:10:37b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.5; Fri, 18 Sep
 2026 13:47:26 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0428.008; Fri, 18 Sep 2026
 13:47:26 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Fri, 18 Sep 2026 16:47:02 +0300
Subject: [PATCH v7 11/16] vhost: make vhost_dev_cleanup() safe on a
 partially initialized device
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-up-vsock-vhost-v5-v7-11-6ef9ef033c35@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 42ac2c91-7a03-4eef-e950-08df158b5f36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|7416014|52116014|366016|56012099006|10067099003|22082099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info: hHHsERS9OHSV+osBPliUa7kQv3K6lE+Tnm0BOVNM+DDS+535ZSE1F6JpL73uW7LhD6nfrXZSqY1ZlQifPJr0hmyxPxMxqBK9HXnKzQZ7c6N+iI11JpryqSo+Y8Ie0+qBY08II4dNNgaAs5MXzV6+Nye+aYKXWNLEodY5kDyA90zkQM72MdCHo4pi5Nb18NVqTC2XcElwUkAYNhEiG5FPquGIZr4G3qB3rGAnbGqZ9E4iZKhotmWhRmn1sV1xQ8+wLffMcmailoLe3rnFyF0x8wczcrmbh7rffOGmskhVL5yBCY7/kvtJ9G25f++wObZOHX6aQ9CwBkbOzrp0szuVEvA6RdKrZNtQJqtCEQsdIwPwIWCIdBayN/G9jGucOm4GEGjC1Q5XhoQT2AgXQhrcPHurJmeNntrC37ZfNgbT3R0pqujA2PvTByXiUhRIgStBUg+Ek1liMAWLsfu+G4gHKL/c2P49A4A1mi7FSKk05v+rZGIUx4lD9NiYvQralvJUa2bwk4jgYvJ/ZadiPqHE+RhPxqWWOu7Wl1U5sUOWDuMzyddhoMbMOjcV5Na/NRPYVIfwJR3Fr1mX9qJieb0ZuF7PvRkcVvSGL15HnpZZ5gOdzRmoD39c5ts9q5fPUTzG3AhRDDpINfWwY5oyDSFUrWVZMc5ChxlioWeOoMDhy5HX9YwgHwz0jABFcrh4O9Z73eXAHJ02a6Ok4jD6Ij2vK2SeqN7pfBpEbkD7apipJcU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(52116014)(366016)(56012099006)(10067099003)(22082099003)(18002099003)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWh4UU5vNXhOQXNLYUJjclhPWlYrdklLOEcyc1NqdDdhc045ZHZjMGtwOE9o?=
 =?utf-8?B?V05BMG1EWU0xaVB4TTdyQlRTUGxlQjUvK3lXL1BmQlJvQ1dxcS9QUm01U1Y0?=
 =?utf-8?B?VVZTV216T1JhTUVqZXpmNGFjR0VOMzA1SFZMOTJockltUVdiTFRTVkl3MGxx?=
 =?utf-8?B?Y3FDTEp1S1kzdy9MV2dML291cGkyclJEVVltQVVqaHAxbkxRWFZUZFA2Y0w3?=
 =?utf-8?B?ZXltTHZ4YUhYSnBveUo2UVhTbTcxaDgxL2huY25pcnlKRXhCOHlpenBtcHRH?=
 =?utf-8?B?bXUyUW1Remp3MDh4d3loSlQvT09abis0UkNrWGdTR0NmU0t4ZHIySVVMdjNG?=
 =?utf-8?B?dlZKUHNxeDBJL0pCcVZ3dnFFcUFLNit0NTVuaDE5MkFITzA5SzJMODlWZER1?=
 =?utf-8?B?cU9CNG5qZmVDSkNEZzN4bHh3MURKU0tGV010OEU4RVdHbkpDcDlkOXlOTUpZ?=
 =?utf-8?B?M0VoUWdzNzE2OUpvWjBKWXRVNDU0THpLS2lpQ2NlVU9XWUIzcmF6REkrQlJN?=
 =?utf-8?B?OWRJK21JZmxxaEZ6Qk1OUy9IRWtjbzAwRm1LQ3d5d29TWUtXbWFXMnN3bVp5?=
 =?utf-8?B?MTRDd0NUQ0YzQmtCdkZESjFweWxOdXIrcGY5WGt5eGE3YVFzSDlJbTlBbTRS?=
 =?utf-8?B?eU1kWGdtSlA4SkFObHdvTWV3VTRWcWJlVGtyMDhtOXVtUVhyZmhBRUt1Z3h3?=
 =?utf-8?B?bVR0VFBNdHlhUVhpZGRSRStqS2IrcFpKZFV2elZnRm41RkhadkhyNTFUVE40?=
 =?utf-8?B?Y2Y5MjF1S05NUFc3UEU1QUxEQ0drZk9wcTVacE5CTk9qbzJLRXpHRUhwdUNt?=
 =?utf-8?B?TGE2cmZLVHRoeTI5VUtsc1E0K2lYaGwxLytSdWlLWjhFZThYamJTL01xTmM0?=
 =?utf-8?B?dk5ZcWlQckJkUCtLdnltbThNdTJodE1mZnFDRzZZNi82S2Rqd2d1YVVYcG5K?=
 =?utf-8?B?NUp3OUluQWRxVmxMcEh3aWV6RDhjT0o3ci9MZ1pxSUdta2p2eUFWY0lBRENO?=
 =?utf-8?B?SnJscGVaQjY0NEhKNFpZOTJvYndpYTltWkNEYlFqKzJXdnNGbXFaUlowVUsr?=
 =?utf-8?B?NVVTL3RJb1lXbEx2S21iTDNhNG96TFhxYmZkWjJLdzhHVlhRSXBueTZjaTBm?=
 =?utf-8?B?dFA4d0cwdmJ1QWcvVEFJNWxQZHpiTDZqTjd2alpCd0FBOU45OXgxZmZDTDlD?=
 =?utf-8?B?MDNuOEsySDd0YWZ5cS9JT2RVUDRndEZiTGtCUGVFWE1oSE9BVDFEemZVdnEr?=
 =?utf-8?B?VVk4Z1c5eXkwUE4vZVhxTlk5TzZudyt4MUdwVjRUQzkwSDlGWm5UbE9LbGtS?=
 =?utf-8?B?OU5EVmV0NjZ6dWJHQitDeElXR1ZjeTdybHlGVUhkYmlTeUdaZXBQakNaZUxR?=
 =?utf-8?B?VEtxUVprUVprOE9kNy90VUlXTmdrOFFBOThVVUp5dEpwMzFISm5SZ3hGWUE0?=
 =?utf-8?B?dyt5VVl4aUx0b3REaVJWOVB3VjFQVThSa0FqbGFUK0VhOU4wYVZWMUlUSlNQ?=
 =?utf-8?B?cFlUcnV1eG94c1pRNzFWZmlOMTJPQzFTRy9rVkpBdWg0OFZVVXpTSjEyT0Fp?=
 =?utf-8?B?YXR6K0t0RU1VaThBNmR4QlBneFhWcXYraGtSYUFpUTUxN2dFM2kwMEgwaVVN?=
 =?utf-8?B?WnJlRHhncDZhNmNhQzE1dmo2YVpNVEtqQXY4U1V5Q29GYm9paThTR0FZb3R1?=
 =?utf-8?B?VUJvT2ZLKzYvMzlLOEZyODVPME9EaXJNZWNKaXcxTWVRWUxmRzd6UjZhd1Ja?=
 =?utf-8?B?NzY2WFlSQk9TblN3cHlTUTNYenYrb0d6THduaW8wZFhKZFc4cUxLd0NBbzZR?=
 =?utf-8?B?OGNHbjVWWGJ2NDBQNlVDRC9ZS3pQNnpUMG9PeVFIQTcvTUxJZEhvc1pQdXVP?=
 =?utf-8?B?VWtGdStWWHIyN0JYNVY1OWNDdWxmVGlIaDBpenZKaDRXL1BScFdET2hYQjYz?=
 =?utf-8?B?dVJ3SDl1c0FTc08yM0dqdTlWQVYyQ2tIY3VoWjRPckgwekdOQlhBK0xMWkxo?=
 =?utf-8?B?aVd3ZHdnTi94bUp6ZEp0c3FFcXlyK29HTnhOcmt5cmR4b2FTTlpGNHRkL2JQ?=
 =?utf-8?B?dDdmYlhUcStEZW05ZmFsQ1QrRUZWTHU1S0lRdWhxSk9Ed2tZU3hzb1UwMHBV?=
 =?utf-8?B?VXZnZFBaelNSQ0ROckpEelZhUzgzc1pCMkN4R0Iya1ZKbGlTZDBpNzZxdEYz?=
 =?utf-8?B?cGxoTnlPbkUzejBmc3BrOCtWNGFaUGFENXVnV3ZGK1JmOGJ0eHBCZGpiYjJ3?=
 =?utf-8?B?RFB3YWRLT2RLNEhveUw2L05JQVJocmNoN0Y0RC9peXBWeXJlMjd6VFVteUxi?=
 =?utf-8?B?bDl2b013QktrcFZYaHM5NVZyNzdnM20yMW50Vm9OTnNKS0RjakhQZ0VNemZ3?=
 =?utf-8?Q?9pMkkqQ35PIJyST4=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42ac2c91-7a03-4eef-e950-08df158b5f36
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 13:47:25.4511 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WWjZD4/bs8XJD/oYgMG3P1gLS/LtDzoF6ezfVryG+78DNVpwL9EIvRZMZuXpTwg5Mh+DnQ6fyq1oyAbaxxLraKZ8PqtmgIn9Lzwesdu/nu8=
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


