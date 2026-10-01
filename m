Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00A8CCA5FB3
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 08:27:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCC88-0005Eo-Rn; Thu, 01 Oct 2026 04:27:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xCC83-0005C4-U6
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 04:27:00 -0400
Received: from mail-northeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c200::1] helo=DB3PR0202CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xCC82-0003Pc-0d
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 04:26:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l2kOHk5blyHQCdtYtHBGO97vNXK0wusJv2htyqpvpPUQJvnYeITLn7ECRALr8ijuUSBLz/nb61sCAvNcJgvv+6bf8ZFXq3LYALE8K1QtZ6I5P+DSEepEcVh10UDBMh3aQPhsv19OyUfG4jNT/i35FLk+gBKyRpyXNS4fC7c7QKo+6CYsuNmLhaO1lYzoPrUrL9C2f483UzQSCz9TKOiTnuz1WbYZEcjNyohhwoMHTGAqi6oI/X6Nll1Ru39wRCXR1EstRb3b7GraghrOd4E/lDMxvNw7In0MnyD7N1FAoqwp5CefTqoJ+HsYUyATuwtP2kSaRzSayctIh56K+utz3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gWXhh68le3RfUJjypRVq8x/GzIl/qjsOycrfUzYBtG0=;
 b=Pt65fvkSdj/E4zUjL9JwW3QfXzqoce0IhuDJCGB/lmJ/0BQqiXuD7bhPVB+iGFkUs7w1/uZA4WPFOFpvQ1Xd6xeRJEPrMiv595arlsm7dEUG7NkBV7Jj1SrmzqhFenr641NOHMGwuOK5tl+EayXkbOlIuFBABX7M5NyFc2ZnPyt0BY7tgrOT1f2dGIjZ9u5PhGaNOjqWLhg08aeIk5szLGA7sRa6cy3aQtNqujrWLvOJHUyGBox1PXi78cOZnP82BVIQEAe/4nNCZtAYNc1VuWKo+yCgwXK1gbCI2CHNl+gUPD0DWq2hi40HbMYG8ow2rUYXpagAIwVUUXnF81qMIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gWXhh68le3RfUJjypRVq8x/GzIl/qjsOycrfUzYBtG0=;
 b=yk6jwneciANAKtzhDbjMs9YaJEqIMSBKDNUL4l6reCl5fSPox3KNXIvc1ZuQGknga510KFRPF4bpQNNit2feVcyCdhtxuO0AFB1qRhpyfQiiplEhJDYZm8kL8LwFP4PHkvK6KgzeMXzJvuKtFxZohZauPcHR0V017Q2JGIKvnHbowOqxE9lKhCO+qNOeJe+/4p+hUooOhcAFm0p2GeO4+/K6lOlUWLXxxH7kegUe/9t3Fz5jDRcf4QkqfR6Kr2yVJqNIg14fpYrzzReXL8p6ge0fVQ96qmOOUn2hn03TRc0m5J6jiwrRD9wW7TCvePZXIYavfi69RbAah4WUUqOKyA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DB9PR08MB9442.eurprd08.prod.outlook.com
 (2603:10a6:10:458::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Thu, 1 Oct
 2026 08:26:49 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0472.012; Thu, 1 Oct 2026
 08:26:49 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Thu, 01 Oct 2026 11:25:12 +0300
Subject: [PATCH v10 12/18] vhost: make vhost_dev_cleanup() safe on a
 partially initialized device
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261001-up-vsock-vhost-v5-v10-12-8c094843e98b@virtuozzo.com>
References: <20261001-up-vsock-vhost-v5-v10-0-8c094843e98b@virtuozzo.com>
In-Reply-To: <20261001-up-vsock-vhost-v5-v10-0-8c094843e98b@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: den@openvz.org, odaki@rsg.ci.i.u-tokyo.ac.jp, dwmw2@infradead.org, 
 peterx@redhat.com, mst@redhat.com, sgarzare@redhat.com, 
 vsementsov@yandex-team.ru, farosas@suse.de, mark.kanda@oracle.com, 
 dongli.zhang@oracle.com, maciej.szmigiero@oracle.com, 
 philmd@oss.qualcomm.com, bchaney@akamai.com, clg@redhat.com, 
 andrey.drobyshev@virtuozzo.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VI1PR07CA0284.eurprd07.prod.outlook.com
 (2603:10a6:800:130::12) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|DB9PR08MB9442:EE_
X-MS-Office365-Filtering-Correlation-Id: e31ea358-cfbd-4d30-b158-08df1f95bb0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|52116014|376014|23010399003|18002099003|22082099003|38350700014|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: GYZSTbEm8vo6JBNhcWAV+5LoZV/hIc4YWQTp4x1cECFTPJsAfzX617B5X8oHgYXe2jZoPszp9xoNz4u7CXzMNvQFv+DkLwstXnMNBgmjKCgRBLBXWSGa6tU4HYoZAsGp2ht+oztYsjSTj+u42o23FjCOaCLBTM5EMNiz0GIaYFF4Q3EHWr38gdJSkEtQxNpoAqCiLJQWMDBNB2UjseQFY2JBo4OHWit1ndpMZTv21ehEn9xkmWOOIz3iGnELda8pl5UdjP9XEy7ttnVH3mKOk4+wxzqjFJZQ01GMXS+RvUAGDul/tOgJ1QNHzSeI3hK2Caag+bY4okCRu3a5IjgwQODU8z6Zur2rWOYnGeDu4pUYrO+b4gij74y3hALijbjnLpAl+W2SuRCWCeGePGMXwEH+rtA5WMBH3Loy+9Vc/1kNPVCJBfKIEsxrEjx3PV84nfO7v/FZ9JI/hlim+53+lNFhOpvPe0qHARq5gHchf8x0Jg84i4cnuwx95MyLys+eRnW6PJnmQ0ciXzYS5BttHzMLftYkP04t1w/1dJlI4vrFG8XsVhR1a05uqedt7mhHglnTmstAGlZYBFFxotbzrZYxMD0qqNqm2v9cGXtUY8wULUUlR+5x+Sot7n94QD1yJILxEJwFJpYVxijop1YO3ULtzqIaO8IWU+w7DAcr+G6aQWJkqwE4jSOqEUgr/0HN+seGrSttzwXEk47ImyKhp2LX4wiKcZTFSzGP8zA7L00=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014)(23010399003)(18002099003)(22082099003)(38350700014)(10067099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWJHb2JUVWFoMXpmQnpBMmxLZUUwSjljQktzbHdLbnFaaWttUHUwWDZ1UURm?=
 =?utf-8?B?VTBxSGMyek50azYraUNTSnc1SVdIWGNVcmt1alFSdWEyOXAyOGR2UVNFQVFo?=
 =?utf-8?B?WlM4eHV1MXRRaVRwMkI2dlFnUTdVYmJYT1N0cXhMUk0yVlJsR3ZSRmpLc1ZR?=
 =?utf-8?B?VnA5cWNVbzNSQ1B1aXBtQVE5M0huV3hxTllGNzZhbHBMZDFQdjRZNzRkZzVv?=
 =?utf-8?B?Rm1iTzJUVS91OGpBM251TUt5REUzMEorTWRTTVR4bFRIblpmK3FTUmRFWXFZ?=
 =?utf-8?B?SjVqaVM5MTkzL09KSVRSWkZBemltSExQVXV4RlpBRTBLN1lvU3dpODYxMFFH?=
 =?utf-8?B?NWRzOHI2KzFkSWRFZlFXUkRLZTIyL3lKb1pLbUdmL2pXOFc0ZzgyYVozdnZM?=
 =?utf-8?B?VWE2dHFEV0xKOURBUnZRZGthNFhCaXR2NFYyN3VrQW9UZTNnYXk5bmlueENW?=
 =?utf-8?B?Z01GeTJGc2h2dGxaaC9kanAvSFJvUnh2NHA3QVJJN2pwR3VRQWFlUWhuTnJP?=
 =?utf-8?B?QTd2eWh3Mkg0ZUlERTh5bEtjV1YzamxvSFVqaHA5R05iWjZOU2RxbmtacTFN?=
 =?utf-8?B?S1cxeVBHeldrQzg4Uk0vbjBZSWFFKzBnaXpuYnVhSUZxWC9GTVBzdlB2bnM1?=
 =?utf-8?B?V3dOcHg1amRUWUVtWTliQll1bVNWam8vcHZndUJ2enJkb2x0QkQ3TEhLdnp2?=
 =?utf-8?B?bmw5cXFPNldHcWxDejl2ekZ0K1crS1RyMjhYVVRLK2w1SHFvWVAwWWowL0dW?=
 =?utf-8?B?ZnlIRjhNV3BZQkZiY0NNOGhtLzVPM0V5SFNXQ0NMdzllTStQaFZncDhSVjFW?=
 =?utf-8?B?RlpSMnpxYjhSQVBJMzl6bndaM0VzT3gxd3dYQUEzeURudmxWWW9kNXQ3Ylli?=
 =?utf-8?B?MEFCbyt0cFV6U3l1RzQ3NnpIWXVnVXI1YXNjT1p4YVBvTC9GdEVPYlJBYUgv?=
 =?utf-8?B?cGNDYjh1TnVsVEVFK2ZHcnB5R1Nzd3R2UEhydElwOEl0QUYwNHlMcWRiSHI0?=
 =?utf-8?B?NnM0Y1NSSnBGQUpjdVJTb0d6VXF0elZnVkF1ZmxmZys3UnRoeGx6NStzVktQ?=
 =?utf-8?B?b1NHa2poQzE2NEFkaXpXMUFrYUxBOTAxUUd4Z1k5K2cyQXpEckMyckVWU3dv?=
 =?utf-8?B?L2hWSnNNRjVjcHNEeENLT1ZFeUxid0JldmFOTnI1RVhLbVhsVDB5OStlaUZK?=
 =?utf-8?B?djl1ZXhSY3VrbkxPVUVtQUJWVHVFQlI3a2FKd0o1RG5sR2pQOHM4ZHFOSmk5?=
 =?utf-8?B?TE44cnd5SWRWVlBodExRR0d3M1YyUzFBWFRBSWNJajB1Mkoramd3T3dnYTN5?=
 =?utf-8?B?ZU0wVkhJTndSMEhRYjczSUo2aUcyczZrdzVKZnI5eEdka2oyeFZVd2pNNmNp?=
 =?utf-8?B?MDhFajAwT0pqQUU1blBKZVVJWlFHZXV2RVl0bVRONXV6YWl2VlhBRmt5cllG?=
 =?utf-8?B?NWdlL1MxRUZ1a1VUTW9Tc2MwZzRJNDdTVVdXS3dtYVViUVZnT2VFdE9qNDFv?=
 =?utf-8?B?TTU3THIxallsV0xUSHRMNk1CMFh3Y1QzUHFHOG9zMldjYU5ESE42OFBvU29x?=
 =?utf-8?B?d1IxV09RTGtJN0hMMFVVVThMb3IxelkrWG1QK2Z0NkpyS3JnSkU2OHJ1T1RV?=
 =?utf-8?B?dFlrKzV0SVFhMjZGMXRpTkw5QWFFSVFxQ0FybGptZk4wc0t4S1QrYklXQmNP?=
 =?utf-8?B?TGNWSFBjRjlORXk4S2dsME9HRlV2N3I0RFlVT1R2azdpZjMxM1YxOERsNjFX?=
 =?utf-8?B?clI2djl2VTV1NjlTSHdVOVNlWno5MVIxRnNGemRUbGJEMTBmc2ZwY2lhQ3F4?=
 =?utf-8?B?NHUraEN3L0xRWkY5RjA2SW9qaXpVZ1hyUURsUzYvcXQ4dk84dkRVNDVIM1E2?=
 =?utf-8?B?Q1RrbFYydTk3TW9wM0dDSTlWZTFsbEYyTTh4YkNPL0IrSFE3cFN1R2p4T2t1?=
 =?utf-8?B?WVBScVA5bVAxUlV3anVyU0lKVmVPd3pOZEUrVWs3SlJHNHozZDE3MTJrOUsx?=
 =?utf-8?B?d3lpMjF6bjM1NHBINGVTU1hRMFlPRkVwd2V6SStjbUE4Z1FYczdxSlo1eFd5?=
 =?utf-8?B?ZlJMSUxUMkNzcXZTZ0hvUmwydHljUUQ2Z1NtMFk3Mjk2aVdSVlN6bHhaZjF4?=
 =?utf-8?B?eGR5UzNoK1hEU0JEUUJHcEFGUDFJY3RBemRUOTFmNmlBU3NoZmc0blVjdUZ1?=
 =?utf-8?B?endyb3ZnYzRNdVkrUFB4MXR1cGl0MHhZRWduaHVXdENlUzhBMUlBWEVqU1I3?=
 =?utf-8?B?R0dVNXRpUmorS2NEY1ByVkVlSTJhSTd4RFJ2M3V2L1BQMXZxeFFEVHlFUnls?=
 =?utf-8?B?Ymp1RGxMTjh6MUpzMWdoQk1ONk5IM0FnN1pkWWF2SWN6TkhkM1lkYjdJNThk?=
 =?utf-8?Q?/3zPw/0yyVNdGxZM=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e31ea358-cfbd-4d30-b158-08df1f95bb0d
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 08:26:45.9777 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ilitGVoyhwHTXks1HLB6OgvOBBn90w9vJirjq3uVw1iUvsaxlGEAk3uMzNAgDEkaymcPH9B4nNMYGYNNT9lxjNGp08iTJcx2nXbmSmvcwIE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB9442
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


