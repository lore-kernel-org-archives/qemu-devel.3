Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70F82CA5FB1
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 10:16:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBrJh-0000jO-0F; Wed, 30 Sep 2026 06:13:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xBrJf-0000io-U7
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:13:35 -0400
Received: from mail-norwayeastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20f::7] helo=OSPPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xBrJd-00046g-EN
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:13:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XPo9RWble4E95EOjAMmopbV9kLWAJ1k7GJ2XX/hYPVXXCqfOoXDzdenUzcPsueNApUP6hF5BhNIVLxBINZxs2tFAcKjOk/qDRJy0MG6gNwCFzbZRz/DTzQSnPJOdZjxL8Euj6Xj4cyl18s842ssLJQsX3elm3M8rB7sdNT/KmjK0xdi394fPVbd6q0hDn/l+I1pLxXco8zByZi9GIUMral9h3v+i8m/IIMBlNagG5pjNdsDQBMZTzPcXyU/KeuYjSNRppky5h1gVLM9MbyZ1OIuS41mLj4z4QTjdUzVbWvHCJaPfMc9EnqEJFxKZiieMn1Gp9XKQaPIyHo0X+OfM9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3zZJ89Z45bQcI+MDgmQM5LzF7kuk0PxBH91uljpEleQ=;
 b=neG6KUUc1K7K7Kg73DT1Ied1S0iaz9jg0v9AXuYCWdyst+VV9qsDBraRYtegEittlWltYsTRW2cmRB1EJ9X5KO+2iVR/usNGzCa0MRzHJPZPwYPjz1ZdHHWU1SzbNJIByiXKtwzsudYjThRTvfMd4w6lziegLVkVMiWR+69kTss/+/l6+wcE+oHG70GNr/A5m8gFjKyd90hD9Hp1r627VN3EXT/VTMiw+inEuzQG2Mno3K8nq77OyXZ2inRZdsWi4kpA8swSmS+IcKnNJuQl+rimfHWgGcpe4wcj6XbYxY7sXTQWIoTOOHRy1Az+DVX3Dmjw8hBwI1c95+t0dkIVXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3zZJ89Z45bQcI+MDgmQM5LzF7kuk0PxBH91uljpEleQ=;
 b=zGWjJ7wmKwHLErsAlqOnrcsOo0DrzoBu9ky3kFQ7zOMUltk7U4CITmrRxuu+NE14VLOr40SqmwrwzHqwj6UbGFLZOr2FvNMXtYBYVwsXl1xpivbMlNEbB01KupddaqYFfTjNfbqslTCF1L59oCuaLLSEv95dSMXSJLwS0NmIoxtj6q1g1szGQcqra34Yttr46U7VguDVr6UW6wCEOB0L/EwwhGKt/C2IPqbP2cOM4H7+XKMybi6tq/jqOnZiGdAw7zQ3JdLPCzVSsVG2nU/IIGjcnNbBz82hGe1z7lSoRy2RFS6OlX4pJfu2qgJ3Ixrxa/iRwuR06siwBqE2ozusGw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AM8PR08MB6420.eurprd08.prod.outlook.com
 (2603:10a6:20b:314::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.9; Wed, 30 Sep
 2026 10:13:23 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0472.012; Wed, 30 Sep 2026
 10:13:23 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Wed, 30 Sep 2026 13:13:10 +0300
Subject: [PATCH v9 11/18] vhost: factor out vhost_dev_init_backend()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-up-vsock-vhost-v5-v9-11-e9096f629770@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: c5f66f28-bb3a-4ae0-9fce-08df1edb75db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|52116014|23010399003|366016|1800799024|10067099003|56012099006|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info: SL18Z2bcDYJBEWG5lVjdjsoN+c8c+pjK2zXUbINBdS3yasgDPWc/PA9jiCvWivqjZazVNmJkTIaSWyn4NffbMPqMeH7OFWmoku5UhPfDD+1SuD188H1qO/Xm+bI2gfKFVKD5r53gSZIntzJThwghD9tMy20hGyHvLtzmAwl6wrncRQGDDPzun4BymmGpaOQhq7gl0c8gcXgpwerKaVvrFUUrN1z2xHoqSKT/xqlz0kS7z2wq6AU8iHkBwexG9zwiRfDkRHnW2xsmhkRagrZwWwaww+Ctn+xdyIznnbHCxejhVwsix64zPTZnbUCV6lfKYI52N/gJ2hs7QDinTyaUTCwf4ZE+8BzQl0Bm9lWrDEBY8FLdr42LjfORDx30INXFCUFBaYSEksPhTQJt71qcHp0B1jAe93JMd4cDrb09zTnhDAi8WFhe94PG+tSucBH9Mb8bgPpYT1TCnaXsAaUKh2rwSAF4Aj2WgszloXWCqeieyusMwDUeWutJHjnbg/2R/UEFEDhEHS0JSVc9GaC+mDEbTu7cFn8Cxw0KnRpVjQxh9nZhNOxaay5btxDZ4QFwemdp899x5KBnVdUL8lcD4zoXNWToLDPMJAPgk5u/3HsRRdCkXxjwvkyG2A2JT9/yWJ70q+SkLKPmzaGzeMmuX0JjUPixtPQ5GEAjsL32b+tTQRbHJNCtdOA4WeLJbXUjGjB8rFNApe4JTy+g+AdS7KsQkECor1zs08ot5gDiNNo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(52116014)(23010399003)(366016)(1800799024)(10067099003)(56012099006)(18002099003)(22082099003)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZlVkQjUwSFlrYkM2WXVvME4zNW84dFNhbEhWTlpmTEVOVHV0TkV5MDNhTXhM?=
 =?utf-8?B?RmhVd2h1Mk53RmsrQWs3dHNRMHBPWDVVeS9kQWR0Tm11WmpqSTVCeHdjNDJF?=
 =?utf-8?B?emJtUWhacE1VRHF1UHlrUllubmE1VVZTcmJRdkV1U2x6SEViclpFdytpTzBw?=
 =?utf-8?B?eFVwRmsxY0krcmlXVlhxamZ6VjNWUGJBK3l1c3V0cE5nVys0SzE5ZGxTRTFp?=
 =?utf-8?B?MU90VU1TKzBRMUUxT3VJV1hPT3dlaWRCanc5RTBUTzVBS1BmRVNhZXBBSk9O?=
 =?utf-8?B?Nk4xTUwrRklxdHVEbWRYK3NzWG1nUG1JQzhRbElRTkh2Vm1URmNnYjNCUFY4?=
 =?utf-8?B?WFFiOWJoZlh3MHVvVVp2WGpOeE5UMlp2T3FRMFBPRTVSTzZBT2xUU0VOdTU5?=
 =?utf-8?B?d00wdzQrN1BHM1FWc1RqcXpIMDlCNW9Ccmp2SC93N1F0dDI1bGQ4ZDRDdjRz?=
 =?utf-8?B?N1NuL2xhSll0OFdCMGZVQ09QeXJYNUpSRC81U0ltVVl4K3hyV0hsL0R4dVhT?=
 =?utf-8?B?R0ZEQXRkM0JrSnQxMDFDdE5zT3oyZUZDYXNHd2tSRWdPaFJueFo1YVNORzEy?=
 =?utf-8?B?ZjJuYWdjbjZhc3RLQTZ0VE1wQUFVNFdsNExPSDlFTThJTCtJNUVFaDh5VXNo?=
 =?utf-8?B?NlpMamJNREVTbllrU1JUOEpZdnRudTRLcW1kQ3A1OUpMU0lIQXY5UWtVd3ph?=
 =?utf-8?B?Tkxsd0I5TnM1L3dlWUV3RUNiZWJ4dWhONkhYWnNEVUVBS05GT01OeEIzZzhZ?=
 =?utf-8?B?cWE2UUFvL2R3KzcwL0NvN2h6dnZVRnBaeTVwMVpTWUo4SUs3RCs0cFB4bGhK?=
 =?utf-8?B?eXM5VWdZRk4wZEhvbERJbFhqVnhwalFhVGNQa0FQZ1B0UWxTZktQbGYxMkpB?=
 =?utf-8?B?Rnl3NDM4UlNWUXJialA2dDl3cVhwbGdkQ3dkRnpDNWw4a2t1Z2RQenBzc0lN?=
 =?utf-8?B?Nlo3K1llRCswSVZqSlY2RlhFdU00dXAzR0FzdE14RWZHSTZBYkcxcVBYWXc1?=
 =?utf-8?B?VVJVZjNPZ2ZyYjk2TkFwYzVmQ0dReTFTTGxNTGgwdDlyNUVTeC9Zcmg2K2Fr?=
 =?utf-8?B?amNqbjljNXJtUHJHc3VwTm5PUWpaQzU0d3d2dzA3eUFURHkzZXBQQzZwOGtE?=
 =?utf-8?B?enh4cVVyVlJ1NVBOUllvYzg2NGpSMldBbjAyL2tOSTRhbU4zeGFJdjR5NVcz?=
 =?utf-8?B?b3dkZTZUaDU0bUxrdFRTV29DdGdOUXBtQzFjQmozcnZUKzU0aHJDRzZlNXRz?=
 =?utf-8?B?K3dPMzBmTVNKWm1JUnUrV25NaW5WYXpWL2Z4ZUt1L0I3RDk5YkRjNHRNTDAy?=
 =?utf-8?B?SDZ4TEtxUmNwamJXb2U2ZXpaR3l5SC9GeXdPOHowZUNRTEp6T1RlL1ZrQ3Bm?=
 =?utf-8?B?WUxGbXFKQ0hCeC9iVzREYkxIelpmc3YzT1pFREZtY2NodGZNZUUrL3NQbjdW?=
 =?utf-8?B?cmlTQkJ2Y3dBS0c0ZW9PRVZyZmNxSUVULzVHZHE2MjMxTnlNM1VIWmQxaloz?=
 =?utf-8?B?Y3IybFFpcTJBaHZDckxZRlNoOGxjdUtSZkJuTVN1SmgvUnVCZHQ4RkpVMWdJ?=
 =?utf-8?B?ZlYxcnNUeG9paDBuczdUa0xrSDdXaXN5ZS85SjVWek5Ec3JlN3Z1SlloQ1Aw?=
 =?utf-8?B?QVc3cnRtL1Ria2pjYTFRTnZHMUFsSlI4YWoycG9kWHRsRzhMT2crU3BCTnlC?=
 =?utf-8?B?Z2xRMkdoa29mTjRRSmljMFVLS2VBQUxPbU9LblVjRlhPV0Nsc29QamZBd21K?=
 =?utf-8?B?UTduVkdNVWVOVUJvUE1oak1hUk5XWGhrUzVLNTFwd3h2aERnazVjb1E5UHVa?=
 =?utf-8?B?RnNwR1A4bzJEVEN2c0xNaUhxbTIxRnFub0QzNnkwVjh4T1NFaW9CQlVGVHl5?=
 =?utf-8?B?dmVBLzU1MFQyMUZDcmxYM0Q3dFlLS3NPbVV3QmlZUmVoZkZGakNpMDdrcFhm?=
 =?utf-8?B?cmducGhkb0dNbVE3TXR6WWFzRGNNTTl5K2ZlWFd6RVNxelA2clFLaEdnMlRv?=
 =?utf-8?B?Ylo5QmlWV0FncEVZL0xQTUZhZjdPQU9mU3ZKNjFzS2YvVENoamN6TFZlcWZG?=
 =?utf-8?B?S2M2VDg5azd1VUFMekFXUE50U1A0RlZDUG5TZmgrYWV4RkplS2swRFMvRDhs?=
 =?utf-8?B?enF6S0dTK0NQSUJsMVdra1dnWHJmZFNNS1hQcW0xeHRMTWNhbEg3UWpNYmJp?=
 =?utf-8?B?Q21CVWw1SjJncUUwSmtpNE0zNzRmdk1IV2lreHk4YjYvN1FscytmSGp3Y2tz?=
 =?utf-8?B?VGVOQzhzOGlSUzU0MlV0Wk0zMHZ0UFUvc2xNbDdMRTVJZjV2Q1ZrdldDYjdx?=
 =?utf-8?B?ZHVBZ2Q2TS9Vc1FlTHJ5MlBWNmY0eFB0TWF5TzU4UW1XNnJLK2MwVzJsdUJ0?=
 =?utf-8?Q?Ufv3cEY5OpmUkemA=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5f66f28-bb3a-4ae0-9fce-08df1edb75db
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 10:13:23.5435 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4pr5HetaN2V9iqx+MZYlkdO7eKY1vRXFcPSHXy/U9xRLKkQWoTfLvgDkO1DStnVVrpAv0OWRq9S5LKoWg8tgbby6ecEU6gbCDVwuXTVOWbw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6420
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

Split the first part of vhost_dev_init(): selecting the backend, calling
its .vhost_init() and reading the supported features - into a new
vhost_dev_init_backend() helper, and call it from vhost_dev_init().

This is in preparation for CPR restore of vhost-vsock, which needs to learn
the backend's features at realize time to negotiate them when loading the
incoming virtio state, but also must defer taking ownership of the device
to post_load.  vhost_dev_init_backend() does exactly the pre-ownership part.

As a result VHOST_SET_OWNER now follows the feature query rather than
precedes it.  This should be safe, as no backend requires ownership before
VHOST_GET_FEATURES - the kernel and vdpa backends do not check ownership
for it, and vhost-user already does query features from its .vhost_init()
before set_owner().

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 hw/virtio/vhost.c         | 33 +++++++++++++++++++++++----------
 include/hw/virtio/vhost.h | 22 ++++++++++++++++++++++
 2 files changed, 45 insertions(+), 10 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 68a8e404818..99561ac5868 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1681,6 +1681,28 @@ static int vhost_dev_init_features(struct vhost_dev *hdev)
     return r;
 }
 
+int vhost_dev_init_backend(struct vhost_dev *hdev, void *opaque,
+                           VhostBackendType backend_type, Error **errp)
+{
+    int r;
+
+    r = vhost_set_backend_type(hdev, backend_type);
+    assert(r >= 0);
+
+    r = hdev->vhost_ops->vhost_init(hdev, opaque, errp);
+    if (r < 0) {
+        return r;
+    }
+
+    r = vhost_dev_init_features(hdev);
+    if (r < 0) {
+        error_setg_errno(errp, -r, "vhost_init_features failed");
+        return r;
+    }
+
+    return 0;
+}
+
 int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
                    VhostBackendType backend_type, uint32_t busyloop_timeout,
                    Error **errp)
@@ -1693,10 +1715,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
     hdev->vdev = NULL;
     hdev->migration_blocker = NULL;
 
-    r = vhost_set_backend_type(hdev, backend_type);
-    assert(r >= 0);
-
-    r = hdev->vhost_ops->vhost_init(hdev, opaque, errp);
+    r = vhost_dev_init_backend(hdev, opaque, backend_type, errp);
     if (r < 0) {
         goto fail;
     }
@@ -1707,12 +1726,6 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
         goto fail;
     }
 
-    r = vhost_dev_init_features(hdev);
-    if (r < 0) {
-        error_setg_errno(errp, -r, "vhost_init_features failed");
-        goto fail;
-    }
-
     limit = hdev->vhost_ops->vhost_memslots_limit(hdev);
     if (limit < MEMORY_DEVICES_SAFE_MAX_MEMSLOTS &&
         memory_devices_memslot_auto_decision_active()) {
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index 0a322efec1d..b2b644c0d1c 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -156,6 +156,28 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
                    VhostBackendType backend_type,
                    uint32_t busyloop_timeout, Error **errp);
 
+/**
+ * vhost_dev_init_backend() - set up the backend and query its features
+ * @hdev: the common vhost_dev structure
+ * @opaque: opaque ptr passed to backend (vhost/vhost-user/vdpa)
+ * @backend_type: type of backend
+ * @errp: error handle
+ *
+ * Select the backend, initialise the backend instance and read its supported
+ * features into @hdev, without issuing VHOST_SET_OWNER, setting up the
+ * virtqueues or registering the memory listener.  This is the part of
+ * vhost_dev_init() that precedes taking ownership; it can be used on its own
+ * so feature negotiation can happen before ownership is acquired (e.g. by CPR
+ * restore).
+ *
+ * On failure the backend may be left partially initialised; the caller must
+ * still call vhost_dev_cleanup() to release it.
+ *
+ * Return: 0 on success, non-zero on error while setting errp.
+ */
+int vhost_dev_init_backend(struct vhost_dev *hdev, void *opaque,
+                           VhostBackendType backend_type, Error **errp);
+
 /**
  * vhost_dev_cleanup() - tear down and cleanup vhost interface
  * @hdev: the common vhost_dev structure

-- 
2.47.1


