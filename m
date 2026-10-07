Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6815ACA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:35:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENwj-0005Fv-KX; Wed, 07 Oct 2026 05:28:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xENCP-0001RN-E0
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 04:40:42 -0400
Received: from mail-northeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c200::3] helo=DU2PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xENCN-0006sq-GO
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 04:40:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r5NxKUqRCtoHxsurqcBn5vX4+8QUqa1HpY9aZu7YWZpZPfaqgY/k/oikdNFsdIp2FQuPqrrjNBRTZ5pTJlY/E2RcEIPhAR/ZeVs+hBgG7Y/ajwT/bssabb8c73q2/pFxf/VmL9fMkGDGtPMgW5eA3UMM5wMj5L23cLIi620GgEJTxtRSZTrQsYik8iQl4pPn7Y2yc2Tq8UAY06/rSCT3DIjEqPJGupGjkF/aZOPx5GBf5VYaeRHuGsVjEsJWKBZyREHoFdJfVsJUjTxGcJE+WQVZuOJVOc+zVLyeLCNElsRLMrBM7G9ZTDcjEufTeAUSYkdWATcQRj0XMoKFJFq7mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7akkkYroBrhZAFPEJjEP1mVuhaoduihrCDQwGIK8mXQ=;
 b=f+ES/a9K2Qq2HoUKDVTyaOeeurZtnXPMHJ2GWuMV55RizFuKv0bhks5sshUtxlD38x/bej46mJvk5Fxo6k9OHGcP6yqctwR0OwjQEYfAen/hYsCScrAQk/iWX0IQLVsygnPCf+jUtXAmao7HonfSwLkmDoKi6twc1u6dvQs9tLyjgwMA0HyzUad+1BEXWqu+9z2JRKyhQPpAF5FcaqpiPnC3tJPfbq0PaPDEvd+v9yoTrrWl44+ntgpVtgajZL2jl3EPuDOV8jzwou1WRnF92eDXMGHGHPFO4JLWN7fKZ0gyo/5M2cmWc7W3pE1TtF8Y6TS1WeA+E/k9BRHyIKmVGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7akkkYroBrhZAFPEJjEP1mVuhaoduihrCDQwGIK8mXQ=;
 b=BAPfLSWqxe4/k9rd5kDbUjPiSA85Quafdexu6JLOb9CLwKdtXne+8jCQ9WsxVVDVHH+yeqMbYui6EpKBGgiGSL8UJsD6fUAAVQA5Qmepblu2A1GIkzTCubVF1kYSW5gcUEXSYHAWpPhhfOKDm67rXH5iBzB+3eUlN2/S4uxBflEgyIdQ7QB4oMH8wsKXcZxdj/h1ndx8BIPGrd9CEPNc/jDBK2cmmaJ8VzLuZAlzWpTmkNleUck7wdLOWxDCD8jf0vOeG3q+u72C32/+L/T4T+jUUT3kH3BKLlNe15Ap6kCr2H6NxisjjP/TWK+DQV+iTJrXetgVuqQI2Z7/8eYtIw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DB3PR08MB9058.eurprd08.prod.outlook.com
 (2603:10a6:10:430::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 08:40:10 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0496.010; Wed, 7 Oct 2026
 08:40:09 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Wed, 07 Oct 2026 11:40:11 +0300
Subject: [PATCH v14 18/22] vhost: release ownership on exit
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261007-up-vsock-vhost-v5-v14-18-e16de9962df0@virtuozzo.com>
References: <20261007-up-vsock-vhost-v5-v14-0-e16de9962df0@virtuozzo.com>
In-Reply-To: <20261007-up-vsock-vhost-v5-v14-0-e16de9962df0@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: dwmw2@infradead.org, mst@redhat.com, vsementsov@yandex-team.ru, 
 farosas@suse.de, peterx@redhat.com, dongli.zhang@oracle.com, den@openvz.org, 
 andrey.drobyshev@virtuozzo.com, mark.kanda@oracle.com, sgarzare@redhat.com, 
 maciej.szmigiero@oracle.com, odaki@rsg.ci.i.u-tokyo.ac.jp, 
 philmd@oss.qualcomm.com, bchaney@akamai.com, clg@redhat.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VI6PEPF00000236.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::8ee) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|DB3PR08MB9058:EE_
X-MS-Office365-Filtering-Correlation-Id: 94990ecf-92fe-4604-65db-08df244e98b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|376014|23010399003|366016|1800799024|10067099003|56012099006|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info: OMs1uzi64TMi1N6JFUQwV6fxS3HSdkb1StI6oZMuCetq9YoUExsRmmYhFqrKH7nQlDjDJxxaPlX0wamVYMYGcn99kjxvIJ8z0laW6shbdN2Pf8cxy3YCTNKoj1fpt8h/YxCIdhzE4F6P3GyD6d4x/MyUiBZbFTv3nUA/IBRfEPgbwy04tmWbMqEuCqkMaTqAN3V5lThAPMePijunEiRXg8AI5B4FPyamM4aJOhhO3WTi8sbEAlHLs5oa6xdFuFdEXrJoQFfxIJaEOgLfiuJpXtx/oz3L8ImfB3JvfcfyQRCO6KLfIGaKjZIWVxn6hFXavxCBFO5qO7EhftyHmjUaRUDeqnR9OxaL8jWJui41vADeAoNPIi0CJvGPerYR/VDjX9h2Z8YLo+JTTAseuUwySO1dj5u2lqpVOA2EUphrV/HAgOYVLABT7ngPgU2hBR3d9fWwhlZQDUCMG3E2hnCGzpLQP/2JbzXcB5/L/em/Ts8MOo2sDabFocwjmDV7qBmiPftQIgOAURZ1I2jFLz6OLxn+b5A7Qr2QxZKW+GGASnDC9KYOtFOpqIeNVclWFfvGRCccF8IEHe0AvACGxalx1qpr9JJH11yMRaA9W+Fs/sfjFnb4JllFeINc1F08kxU+GaC5QU/XIHekw1XtMDBzLQ77QIBO10Z8RymTXUNeTf/f0dhm8LjtS92v4tRZqEnU4a+7ITMcatGFZD5quaqCCsNQVCXOdM16Xn/9Y5Mu//c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(376014)(23010399003)(366016)(1800799024)(10067099003)(56012099006)(18002099003)(22082099003)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WjZRR0dqNGlRQjdka3MwZ1VMSmwrb2x2V3dSSm1YMHd1QkVCTWlSWkhuS1Bz?=
 =?utf-8?B?WnpTeHBUY3FVMWdpUUxuMFpxUlp4cVQ1d3dYclA2eGdpaCt3dGtlR3p1RU5P?=
 =?utf-8?B?K2F6TkhySmkwUTNESTFxNjBNMmJJQ09WQkVYMi83ZFJHSDV0ZzJDdXVjTUtX?=
 =?utf-8?B?bElyZjJ2Q1JsZTFQQWJ6eXIreSt1UUQzeDJlV2t4bFRhSy84WVNaNlAvWVAx?=
 =?utf-8?B?UUorZGZuaVBaT2dqcTBPdmZnbmRzZFgxM01qeEpTdzByaUplUjVGN3NFbTYx?=
 =?utf-8?B?bHJMdWlsU3lCeWJVSFJIeXpyOHVkV3Z0RHcwZTlyTFRYTyt5TVNsd0dVM29L?=
 =?utf-8?B?Nm9OWU11ZjF0blZRbzd2RUcxWENIRDhNWHh3MGRvOFBrNzZQYm9FQ3hHMHcz?=
 =?utf-8?B?YTgrM2hiWEtBdnpjZURieGdnajBCdE05dVB6bDY3L25mSGpERXA4dnNVd1Vs?=
 =?utf-8?B?dDcvNnFZcUV6SVo1NXdwQXB4UkxORDdCTWJzUlErYzlHZVZ5TTR2Tis1bnJr?=
 =?utf-8?B?RTk3KzJ6WG0xNUpUeS9zaDV3b2RCdVJUWWRTY1NSYytpcllpcTJBeTE0K1Ru?=
 =?utf-8?B?L2V6MGlmT2d2OGxOMXBwbjJNZGVudTFtYW9RRU1HaWg3bUdVbE9aT1dKUWFi?=
 =?utf-8?B?V1IwOUFUbWM2L1pSY0pwOWJxYysxdjFmZGpSNytSLzRPUnpjMTcwc2U4d08r?=
 =?utf-8?B?Qk5uZ0pXR2FUcURvNWJYaXh6VThEOENhV1kwN3dkSU8yL0xvMzYvbTN6QTdj?=
 =?utf-8?B?MGhKb2xzTm43TnVYTm9heS9yQlk0ZWJ3VUtkelU4MFpPK1RLd2R5UjN2dmhO?=
 =?utf-8?B?WUtQNHAvVExnMnJjNUZXK09BZXVOWVdObmV4aSszYk5FNHREMEJsbmRySWVW?=
 =?utf-8?B?czJVZUZmdmFxWEVsWHpnUGdSakZoY0FEZVN4ZW8xdzdtZldwZ2NhUzFzSlFV?=
 =?utf-8?B?L1lkTytITWJ6OEJ1RCtVS056UWdBd3pmSEhKVVAxVTcyR0VrSzY1UmpOSVFq?=
 =?utf-8?B?SUlYdkZRTENSdGtKWkdUemkrWXhwYlVzUUZ6U1NTdThkLy85VlFxQ0k4WFNF?=
 =?utf-8?B?YUxyQkMyU1RlQnZUcjBhYWx6alBXRC93akNmdzdzTUlWckUxcmU3cGtXVGxG?=
 =?utf-8?B?bTNPSDRkaFZ5azBWRThGbUppTENjRmFWY3EzWVhsbWQyRnZ6b2JwZG9mMmVa?=
 =?utf-8?B?SzVMWW8vWXU0ckdzbldTOFQ2NnFlNS82LytwbHphZWp4RC9zTGswQUNMNmFp?=
 =?utf-8?B?UFI0Y0UrRkZBQW9iSUxMdDBNQmJ5RnF1RHRkK0dFazNuM3ZjSVBBVVB2R0pP?=
 =?utf-8?B?Z1RUQzRranNpRzlQQldGR3lwclhObG9sdm92TWNFd3RQOFBvK0RqVGRSVUZq?=
 =?utf-8?B?S1lnUGZRYTFaWjVqeCs4QTgvQ0UwdU96aFl6dXBrUTBvYjFtd3NRakw2NWVJ?=
 =?utf-8?B?UnpWeUdwNkFGcGNpTjZmdXBucFBUOUt4V0g3SUhaS2RHd0FjVitEaytpTUhR?=
 =?utf-8?B?RUQwd3lwWEFoeGhKc0F1WFp5UzZldlVMVnJtUlg1MzRvTHFDeDY1OTMrV05D?=
 =?utf-8?B?K3pRajVDY1dDMWdjb1hxYW5MYVZjWmpUMVE5QzZyMG42UFRHVnA0bTBucDRq?=
 =?utf-8?B?QzJXcFlKQ24zVDNicGt3UDF2Qnc0NHp0MUdhODhMVGNaajZrdEYwUlBrbzZh?=
 =?utf-8?B?OGtzYWVHZ2JvVHdBZVhoRDl1VVExeUJDL25zYkN3NUp5MXVQbm9TRUhQSlRp?=
 =?utf-8?B?NEltSDlqNzZ6N0ZSaS9ZZERiSnVKLzF2NURMMFVPN0ZVVS9FZ2pCVmlHclRF?=
 =?utf-8?B?RHhzSUM0NjZwelVBelhEaGxlZ2NOaEVqZmU4cE5BcERQb200NHY1OGNEczVO?=
 =?utf-8?B?R2ZMMTI1SGhuT3Z6Q2diczZveVdHaWxHOW1neURGMEpzYmhRb2V0TkNQVEZ1?=
 =?utf-8?B?aGVvQnhxSlFXdm1jdWZtMENJRC9oMkxjeTBMMGJBZVQzN0VjcVdia3NyWnh5?=
 =?utf-8?B?S3V3UXhjWjE2Z0hpVkJUQ0tyN0ovWHZjQ0ZrbCs0dktELzM3S3hXM2wrQytK?=
 =?utf-8?B?VWlVVUFWOE56V2p2M2EzYUNXQWFWTGtQd29Td0RuVkFHeHVYQjRTejlTMzRP?=
 =?utf-8?B?U3JvVUhNWTQwbnZRVzFsdUcyRG5naGJiVmVsVlJGY2wyV0tMNmxOYm1rNGI4?=
 =?utf-8?B?aVFXcm0zaDNlb09jTG1wMlNzc0NuT0pjQURQOHJUeTBObE9waGNoTXBPZk1V?=
 =?utf-8?B?bDJaeVBZQUY0K0hJLzA4cnVRRXRQSGo4QTc3QXZIMHcvcCt4WldpUWI1eGFH?=
 =?utf-8?B?TmUxY3dhRUE1TkI3ZThkZEJHRFVCcjkxSUlNU1gxNGR0OStMWWVYQlpudTdy?=
 =?utf-8?Q?6EHor/swSzDKjCjk=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94990ecf-92fe-4604-65db-08df244e98b5
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 08:40:09.9032 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nZ0XFzUgofscclTuOkwEaOr7K/KmCKdoQ1zw+2IRtdJRUAbkpys12YaexqyTtQfixPBdMWmbUtFWkW9jGSHqXMdlY7uwD6IAYnkLy9oTK3k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR08MB9058
Received-SPF: pass client-ip=2a01:111:f403:c200::3;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=DU2PR03CU002.outbound.protection.outlook.com
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
always reach vhost_dev_cleanup(): a target which has loaded the state
but hasn't been started yet, e.g. one started with -S, may be quit
normally, with the source being resumed instead.  Devices aren't
unrealized on quit, so the ownership stays with the dead process.  The
source still holds the FD, so the kernel never releases the device, and
the source can't take it back after being resumed -> SET_OWNER fails
with EBUSY.

Add an exit notifier to each vhost_dev, registered for its lifetime,
that releases the ownership if still held.  This covers every orderly
exit.  A target killed with SIGKILL or crashing still leaves the device
unrecoverable.

Reported-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 hw/virtio/vhost.c         | 22 ++++++++++++++++++++++
 include/hw/virtio/vhost.h |  2 ++
 2 files changed, 24 insertions(+)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 36e82bc14f0..29007d52d18 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -31,6 +31,7 @@
 #include "system/dma.h"
 #include "system/memory.h"
 #include "system/ramblock.h"
+#include "system/system.h"
 #include "trace.h"
 
 /* enabled until disconnected backend stabilizes */
@@ -73,6 +74,21 @@ static int vhost_migration_notify(NotifierWithReturn *notifier,
     return 0;
 }
 
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
+    if (hdev->owner && vhost_dev_reset_owner(hdev) < 0) {
+        error_report("vhost: cannot release device ownership on exit");
+    }
+}
+
 unsigned int vhost_get_max_memslots(void)
 {
     unsigned int max = UINT_MAX;
@@ -1843,6 +1859,8 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
     hdev->log_enabled = false;
     hdev->started = false;
     memory_listener_register(&hdev->memory_listener, &address_space_memory);
+    hdev->exit_notifier.notify = vhost_exit_notify;
+    qemu_add_exit_notifier(&hdev->exit_notifier);
     migration_add_notifier_modes(&hdev->migration_notifier,
                                  vhost_migration_notify,
                                  BIT(MIG_MODE_CPR_TRANSFER) |
@@ -1896,6 +1914,10 @@ void vhost_dev_cleanup(struct vhost_dev *hdev)
         memory_listener_unregister(&hdev->memory_listener);
         QLIST_REMOVE(hdev, entry);
     }
+    if (hdev->exit_notifier.notify) {
+        qemu_remove_exit_notifier(&hdev->exit_notifier);
+        hdev->exit_notifier.notify = NULL;
+    }
     migration_remove_notifier(&hdev->migration_notifier);
     migrate_del_blocker(&hdev->migration_blocker);
     g_free(hdev->mem);
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index 14484b8de24..b9ec00f9b0a 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -117,6 +117,8 @@ struct vhost_dev {
      * Updated only by vhost_dev_set_owner()/vhost_dev_reset_owner()
      */
     bool owner;
+    /* @exit_notifier: releases the ownership at exit, vhost_exit_notify() */
+    Notifier exit_notifier;
     /*
      * @migration_notifier: releases the ownership when an incoming
      * migration fails, vhost_migration_notify()

-- 
2.47.1


