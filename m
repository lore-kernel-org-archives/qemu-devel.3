Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9AEBCA5FBA
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 10:16:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBrJh-0000jU-D9; Wed, 30 Sep 2026 06:13:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xBrJg-0000jC-Fs
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:13:36 -0400
Received: from mail-westeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c201::1] helo=AM0PR83CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xBrJf-00045T-1F
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:13:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cLk5YA6MYmlLEATEgLScYpcX2xnfE6rSTDvsAEdY3nzoB9Gk4RvyxE8GN4nKo34H8PexO+4w0zHOOsFNMdB2tItfpfIGRn4YJs0O0irHWVrhp8CFny96Y9+a0pvc3ARoxa5so6l3NHi+bQVfFQSabG1nrwVYwVLWxFDdPA9NtW/eOI+0TQvQarQVd6TP0Zaj6/UKZXh3jp0B+3Zr+CaTam0JpiN7tvvlnRukz4rEOmG3gtgFsFK26UTcux5h+aDEcUU1ViHNK69u42o6Jm83nzyX7xeFq3f+1iGVZyNpQjYg3LxVf80X1L4+G6vCN1AWmuXcvI/47XWoBxiaJ5aJOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gWXhh68le3RfUJjypRVq8x/GzIl/qjsOycrfUzYBtG0=;
 b=Qk00MolcGqLmMTmiH9XJ+F4WPHw2EHeHh9oTTLtmzOK1ZHY5gB39sgFmuxEKN3odg2S6EuCt7V7GxatXeEyXBSMeALVd5kW2qlSY8XnajAlXmQ+QZ0GXrFR0N2FfaeuotfiC7fB5LUbkIk0wQkvDDmMfxi7k25F/KB0RshCFxzYKio2La684hwAdZWqciab7eBMqUsKBuR3A3ESoGVq75s8LBjJQHPi73J89gKgsj2CBPdnes+MjEHOj1oBHgdeCauZBsvKctLaM3VglAXcxwvCmCz40W6sSI9PdRPat0y3dLjWeSYKvzLV3QJafXw2eYIMNP9AiuqPPnyN/srYd5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gWXhh68le3RfUJjypRVq8x/GzIl/qjsOycrfUzYBtG0=;
 b=Q6qjfFuLECOq+a8smmy0DpW9lxCLF0cIVuGWYdmVN25pMdEk1vU61z9xyq9mNQc/0OJoc9WBVd+8LAj6wO/gB9jEazMmS1bb2G4dBkUZhKxRCe7cDX7ikqcceATeXZEKqifqkTqGzAvj0KES36RqIQXVfQMYRzmP7QDY/RfUC3T/zIKfzGqneR7e4RGscd9N0QqNvRzRmHHaHdb4/Ro72RbV2xm6B++jWjehlKgmWH5Pr4Stu43RADtsewpsOsMEPUN0a+20poeQ5RaKl4EBDsdm1z+1sm8Xp0UVPCjEBft/j1XZnTmDfZ82UBDiPyvIpsm4+GYnCplZRMAOzXbfBg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AM8PR08MB6420.eurprd08.prod.outlook.com
 (2603:10a6:20b:314::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.9; Wed, 30 Sep
 2026 10:13:24 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0472.012; Wed, 30 Sep 2026
 10:13:24 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Wed, 30 Sep 2026 13:13:11 +0300
Subject: [PATCH v9 12/18] vhost: make vhost_dev_cleanup() safe on a
 partially initialized device
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-up-vsock-vhost-v5-v9-12-e9096f629770@virtuozzo.com>
References: <20260930-up-vsock-vhost-v5-v9-0-e9096f629770@virtuozzo.com>
In-Reply-To: <20260930-up-vsock-vhost-v5-v9-0-e9096f629770@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: andrey.drobyshev@virtuozzo.com, clg@redhat.com, mst@redhat.com, 
 sgarzare@redhat.com, maciej.szmigiero@oracle.com, dongli.zhang@oracle.com, 
 bchaney@akamai.com, philmd@oss.qualcomm.com, odaki@rsg.ci.i.u-tokyo.ac.jp, 
 farosas@suse.de, mark.kanda@oracle.com, dwmw2@infradead.org, 
 peterx@redhat.com, vsementsov@yandex-team.ru, den@openvz.org
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VIUP296CA0066.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:337::10) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AM8PR08MB6420:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b3c2726-5bd8-43e5-2daf-08df1edb764c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|52116014|23010399003|366016|1800799024|10067099003|56012099006|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info: JaF7MiJEX9TT/QqtCM/Z2HR+z7EA/JOwifPv0nNzmIAcG3m4lHhiH1wLRHSmS/kKF8+vYFZ9hXYwxa2o3MGBDwLUHSdnuv7bCV0QPhjwT1qaMpeHIfIZSK79GdDqLte21m7HrDGhMyJGP66PUF+edUUpK0kc/uE4C12g3Q7vaVPJsWgwjqLRqLN5Db+H/o83gQYrrzDR3DA9T9XkaoCVw+afVB0HewPk3ZmvzTl81Fj+/s5YVl0r1jhg28XZ7+vnj6Ue50xOGItbNrqc8PmeX1jGTsBJYN6HnchudJMzf+9GKmnoikQWGvJIdMkrIYaHrRNKWxlSrP4uJKaUOHLDd+V9LklsjDW7ZivN6GtwfLGuhTUZSALBcSI4mkX7GuTmfa7KzKemuiedrhhgmn3zIsvK/UTS9Cgxo0+jNzD8C9WcJnHtL2tshTvmLNQcQij7sgXBxv1l73CNOP1/132d0PemotMhe3e0TbSsmDebpoq3BAVgF7bI2yBiG+AGBgjydilB6XFRik6ifOvsbLU+5k5AWH5AUioLztMOPSRN5hX2Yf4W71kgo3jBaeHZdBYQHxOfB1q4zIiIrtfPwg63woe24u6CWgS57YE+NT7ecPQvQMf/+pmnTFwzP/nkVOqCJjYx5c411lIJMwj0ZcCHbP0MAV7FT9NxQMaiCpq3xNFkQi7PjY/gVZdKAGDGuPWaVkscPtqgmZKZbClhDpnGh8t7sawGSvEOMZnhAttttMM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(52116014)(23010399003)(366016)(1800799024)(10067099003)(56012099006)(18002099003)(22082099003)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bkFweHdKQWswL3FnYVR1K2p3YzhJSWVDWUxWdDRmTkVEa1drZWVvMmZPUVM4?=
 =?utf-8?B?cm5USXNJOG5weHVvbDNoZDkvc3NjcHJ4c0oxejFmTGExUVdZSFhqNTF5VTMw?=
 =?utf-8?B?TTVWb0dqYmx1VCtzVUtJQ3JIc0pPS3NGUURCbzZOTzIwT2F3SmgvNzZkU2U2?=
 =?utf-8?B?MTIvYU8yZ0kwTU90RzRZQ2VkZC82QUROUzFwTHJ0azU0ZjhaVnNqVjNQNTA3?=
 =?utf-8?B?RjlBRXo0bFlXNnJSL3IxNEUzTEJ1eGVGODZxdXh2MU9CYWQxUzJ3THc3Sllj?=
 =?utf-8?B?REFxWGNjdDVtaSt1TnA4RHJTeTRVQ05kYWdvVEtFa0hQR3hWREZib0QwS1pN?=
 =?utf-8?B?TVFiK3B1RVM0S0xGa3FkOW5rclY5N1hwcUhTaXNpTWltajhRcmU0cTAvM1dZ?=
 =?utf-8?B?aXFzYTJKcnA2T0YyV2JGamM0blNQL25QSjRiYldkc0FwSVM4ZUMrb2crL3FO?=
 =?utf-8?B?c2oxZ2dVS0N5eWtKak1pNVZXcFNQc2FnVFp3RUlUWTFEMk1pUlVvN3JNRmJF?=
 =?utf-8?B?SkxzN3Q4dW5lU2tNZjJtNnBGaVdoTmFGWjdNZC9BUVV6NTdjczNaRGZXcVhk?=
 =?utf-8?B?Y1lTLzUyWE96TmhXTDNpQUJkTFBTK3AvckxlY3Z2QVZYbGlFNFlib1lDZXJR?=
 =?utf-8?B?TFJWZTdiQ1pBOC9xYzRRbWlFOHk4VUZCRVFyeXdvV01tVEt5bUhxWHR1Rlh5?=
 =?utf-8?B?K2dLUEFaSnpvSzAzVGhmQkZZYWkrRUMyZnhEaXBhK2EvTllMQ3pNbVRrbDlz?=
 =?utf-8?B?THJjUzlsSEhuR1NlUnZGNGplclo1dlhCRm1GVWErV21nMzQ5OHBKT1h4K0N1?=
 =?utf-8?B?VHhiMXIvekJZaVNoQ3FZVEtwY3N0Qmgvc0pKTVBJU2Y0VkdSblVJc1lNMzV4?=
 =?utf-8?B?SEpKWW9HQWYvZXlCMFJIb3VlMjdmaWM0UE5lWFNnOEppa09FZjhLSk5MVERX?=
 =?utf-8?B?eHh1MXFQb3Vnc2hBU09NbUJNQXJkRTF6ekhvaWc1UUxIc3QvbGZvTkM1cDYx?=
 =?utf-8?B?L1dIWTRwKzVrR0M4dmVubDZ3bEpVWENTbGEzdHpBUFBwYi9vYTI0SUk2dXhO?=
 =?utf-8?B?ZGlnemExRFJNbnJSemNpZ2JtU3hJN1dETFU4Yk0vSUQrMndFY1AxQmpTMHVR?=
 =?utf-8?B?Vzh3Q1F3T1ZaVk4xTDQrcEhiZmJNNTNpRHdqMThYZHE0Vlp0bHNSbU1QSHNn?=
 =?utf-8?B?RzJDSXRzWDYxa244ZzF2TnVML0JKTnpKVjQ4ZGg2RjdGbDJmOFNsTFQ0cUdo?=
 =?utf-8?B?eUEzR2NCdmthYkFXOXlEU1FJazllZW05ZDFGZnVxNnJLQjIzS3k3eUFFRzdV?=
 =?utf-8?B?dEhSMHlTZmtGSERZait5dWM2ZnhZZWd4WHVrWGZhWFBnVUFzR2pNUW84eDBr?=
 =?utf-8?B?MXpDRkxzNEhPdm00TUtvVmNveVA3S1k4QUNxa2RCK0ErOFBTV21jY1JKNFFH?=
 =?utf-8?B?NHpCc1czdG12eTRES3NKUC9TenpKU1JRWER0b1FBTzRWQm9BU3ZlRWpCTzFK?=
 =?utf-8?B?ZjJhd0pMZngxa3RiTjhMdVpGaVoxNTNYZGJNMDh3MENoS1RTd3dpZEkrWVdl?=
 =?utf-8?B?S2FOa1VSZloyb2JNbnI0c1czVkV1TEx1ZXdWeFphUTlBbmk0cDJzNTgybzU2?=
 =?utf-8?B?N2RkNWU1NDRIVXZtUU9LcHBHV2IzZmorVkJzY2F1eXN6YzFibFhiVFBsZDZj?=
 =?utf-8?B?bStFb3creElZSldmR2VMRXdkWDIzVWw0YlVja3ZGWFVaZ3Zhb0VtNlp0Z0lQ?=
 =?utf-8?B?b0JqMWdBSlZGK3crdHpSSXVrMUpPU3o5dFRjNTdtRllqRGM1cFNIY1hFTEdI?=
 =?utf-8?B?WnF5eERlQ2JwYS95OElKRUpKT2xIYkJubzlRTWFvY28yMlMyUWxlaGNSczVN?=
 =?utf-8?B?ck9TN1cvMHhnQVFvRWtHa1h1QU0zd2Nicmo0ZkhNZGtENm9hWGFFSXovZktJ?=
 =?utf-8?B?TlZyZXkxaGYwVGMvVnV0TzhWaU9TUDdqN084OS84dGdBNzVVTWN4UmROUzdJ?=
 =?utf-8?B?aUJyTEhBNC9GTGhQSHY5QU1IUEF1ajJLZ1daV1ZIZ3k2Zkdwa3lhRVMxTDVT?=
 =?utf-8?B?em5jaTlMQW1nWFF2OTQ3QTJOeis2YmQ3U3VFdEw4R0lnR3ZET1dtdUJwWTR6?=
 =?utf-8?B?U1AwUHdSdjMzMFB1dUxEMnRZU2RYUVpTWUpDalhKTTNzZU9SejI1R1ZnVFNT?=
 =?utf-8?B?cFBKR0tyRHRGRXVNUUdMUWgva3NsVmtEVWhoMEVsYWZyRTJSQjBPUjR2U0tJ?=
 =?utf-8?B?aFp3dStOeUh3L3g5WEN4ODJTZ3huZ3N3bFJ5U2Q1ekgyNGZXbE9JVU5lWXBq?=
 =?utf-8?B?K1ZENlVHaWsvdmZXYmF6U05YdjhwazZHeDFXOFN0cWtVN0RFYlJWb1lGSUhy?=
 =?utf-8?Q?Gx46bAcJlBinU3YQ=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b3c2726-5bd8-43e5-2daf-08df1edb764c
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 10:13:24.3122 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JKDm/+5RSAXpwaYsYYAop1wheMZCaYpoWNLAilSJ3+vfoNKPt2EERb0d50VOMy0edrFVjJ85sow4eenHC6SBaeOsUCpB3NwsA4MMV3MZKeU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6420
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


