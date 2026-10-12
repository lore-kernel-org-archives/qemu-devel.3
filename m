Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5D9FCA9ED2
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 10:30:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGDHs-0008KD-0L; Mon, 12 Oct 2026 06:29:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xGDHA-0007dm-5c
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 06:29:04 -0400
Received: from mail-francesouthazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c207::3] helo=MRWPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xGDH6-0005FA-SY
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 06:28:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nPOcdDMR8TRsAcBe6TGQCKTiF86Q0VU+U64tN03HqZZxVxKPpjJwWvippdudBwjxxn3PFZXy3DEN8/r/8a5aiId5odzzxYWIuItXDjSvAsfjjOoeap3qxYKTku1lW/Dvcl6/33tGhujQCyt5llERyFVog2XoJgxF2XhsNkLL6gwC1atjTEi4HUloqo2/3uqjw/wI6UOb99PA3RA0+O80FjG864P7WlanF7hBq6lrFNmnn4x0oSGcTdVwWN/4+qZiqVrmfYkV62I5B2K4u24QNMLed34EwHvo/57QDI5fo6C0PQD/h9Zk0Pcu3pXdOS8fKldlNuBeBUt5DGsk05V0Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3zZJ89Z45bQcI+MDgmQM5LzF7kuk0PxBH91uljpEleQ=;
 b=h43ucVEKuLTkgDrhLvC//ptGEfMwhAqB7cEdXEb2NGdR8Mhj6B4TACKd3HMorgrPqA0yJIEt0JuZvlUHVWpCzRy4pb5pDxmfAAsryStG8FePNeioU4zq/iO4rGqMyaoQD/+2yvVENpHq0IFzvG7Ouqt6693l7QXYgnYKzJnNPWGPz15BMDEtNddVg/c4aOhgKmfLQP2NZFqqmPENFHatWjzoUrT3zCTYAEUlg7hkqGj34nLGRfl4zqKhYNWo8lqzvOcaAX5HFkcouBjU+a10Le42EQYf49OQHRsMX2gvY9OCVdOAinGdQ0TDnjyUb7sJ9nCbxuRX7VF2gW5j4RMZrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3zZJ89Z45bQcI+MDgmQM5LzF7kuk0PxBH91uljpEleQ=;
 b=uza3Wkf3Oci90vlBLyXPhqJ9+8cP7epMOl8lx5+UytCHwnavSv6XYrpXUPXrVNnamnM60fM4YbWhntds4qJ8SVW0/fGnu0qyJvRNytHdQc5W3cf8EV9iaWX8392/cU8gytqnlQ25jGCE3Myb5LwEzL2UkA/kxR9wn+NrilXx6Wtavyh9CH3ex/ae2coJYMGaJRsF64xnMdOgTg574I0WghTdTzb2DUad2rwN5aomTy3ASHoWEBIjRTW6DEs4xnn7XR9dT08Wwmy0+aDiymTRAIW5LotdhjAJWTTf7iKwOTW6Nb0oBQO4aVzBx5LZK1ktfw0dOnlkusZnnkk0eZ6CRQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AM0PR08MB5523.eurprd08.prod.outlook.com
 (2603:10a6:208:17f::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.11; Mon, 12 Oct
 2026 10:28:40 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0522.008; Mon, 12 Oct 2026
 10:28:40 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Mon, 12 Oct 2026 13:28:19 +0300
Subject: [PATCH v16 11/22] vhost: factor out vhost_dev_init_backend()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-up-vsock-vhost-v5-v16-11-36c38bd15ffc@virtuozzo.com>
References: <20261012-up-vsock-vhost-v5-v16-0-36c38bd15ffc@virtuozzo.com>
In-Reply-To: <20261012-up-vsock-vhost-v5-v16-0-36c38bd15ffc@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: odaki@rsg.ci.i.u-tokyo.ac.jp, bchaney@akamai.com, mst@redhat.com, 
 maciej.szmigiero@oracle.com, sgarzare@redhat.com, mark.kanda@oracle.com, 
 vsementsov@yandex-team.ru, clg@redhat.com, den@openvz.org, 
 dongli.zhang@oracle.com, farosas@suse.de, andrey.drobyshev@virtuozzo.com, 
 peterx@redhat.com, dwmw2@infradead.org, philmd@oss.qualcomm.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VI1PR03CA0043.eurprd03.prod.outlook.com
 (2603:10a6:803:50::14) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AM0PR08MB5523:EE_
X-MS-Office365-Filtering-Correlation-Id: 839b8b69-ef46-4d81-7cab-08df284b9531
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|52116014|1800799024|23010399003|366016|10067099003|22082099003|18002099003|261009223027099003|56012099006|38350700014;
X-Microsoft-Antispam-Message-Info: 7TQ8vIuQWQfbanLFDtKYjooozGCZ7IF5MkYqL2WdbcSVSv1jy1iC/7Gkg/08I/80BI30IDKmTRdd067zWpD+28sjUinufdqQeKgm1TjPPDOpVQLcPcYC7MxTKJpkU/P77CMGP8dsqpXoWWwJo1PD+WlYtUOjulqlt5nO7dgnCht2e0yvRhkaG3Iq+IWnhdmSKdOYzLeqcrUrrNFBJPhiiUEsUF0NaMlUBWhCmgdSdx+jCS7eU1cX23lvIwBK7JU7YbAmkutpnTGM0QAL6Hv6pV4mAqoTPWsYI7z+l/o6/HSRWLKPvaTHhv6cc8nZj1TnTLlRt8ytuPIhdFX0JledRiZKVkj9y2pwiuwZLyiAeCkER38IurBksL2rlJ05g5PXpLOC79PomxSDNSbp2mUs9F8Xb+wHwiPqZcojwE06SaYqCHB00eHNwcXjmAKxDBEKiHQnzX+3ypVUPMamSTtKnCrSSQ0kYrIGTh7mWfcm7JIP+AZC63PAAa/o1cFt/uHM5JvdaxBpumRD/hmSmNu0PPsnVNpm2XF3MCOY0dYVyXRMVnQdQcLjWtN0aPpeT5fs8SYKCRVRvQRf6NxD2K/vfLDVgO8LI2JLmZS32mChhPAROSJjwHugwIYh7u8LCNVefYrYQSQr/Jo7w6Cjd0myNwEpu/mH+gcdx8WTeSSFqVhttP8Pn39+yD2fsRE48hh8bq/KZyg5ZweC5ue7tJcbIS+CMyzXSTUt1lfwfZn9JMc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(23010399003)(366016)(10067099003)(22082099003)(18002099003)(261009223027099003)(56012099006)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDRIVmlwSml4anErVUxzZnFXaWR2N0JvdnNROXZ3YTAxVjJ6ZXlKR2VIeDcv?=
 =?utf-8?B?V0M1ZXM3ZGNtbTlYZTJGYWhJWTNIM1Z4WEtXSWV1eS9BOHR6M2Q5b21vZThs?=
 =?utf-8?B?bzJKRkhYaHFzeWJyQXMzTnRKd0NkVGMyZnVSeThFVmpWZktqUUcrVks2MkV4?=
 =?utf-8?B?Vm8wM3NrdTYvZnY5cjNQbHp6V0Nmc0dBWFcrOENleFdQQVgrVnoxK3U3MXE3?=
 =?utf-8?B?bWZPaWZXVmJla20zRUY1UmVkZW1QZndKT20vSDUvbkN1VVd4T3pzcHA5MlBM?=
 =?utf-8?B?QUxnYVUzb3ArUHVkSXdLSnJncnJaK1U0UmtUck9OcTNSdGt2VWpmMUpBdDRq?=
 =?utf-8?B?NlVWZ0VDRFpXTDFzYU5meGc4emkxWEtIUnA4NmJ3bjY5ck5qREZJSXFFcFh3?=
 =?utf-8?B?UjlpQldhZDVWQkdRWlkwL0l2R3R4VlpWOGx5U0NDTGw0aFYzcTBUSldIL3F3?=
 =?utf-8?B?UExmdm84M1FQMzhibkVhRVRpTTN4elhPWmRyb1YxK3ZRcHd1YlphL3VITVZY?=
 =?utf-8?B?MmlXTzUrVGRpbTV3WEplM3k1MERCcDQvTFlqNXMrNVRZUHgyaTBYSzRQckY5?=
 =?utf-8?B?WUlmNzVLOUk1U0I0aWcrL3BVelA4U3lmUmEzeXVsTHdRU3pVbjkrNGQxRmRU?=
 =?utf-8?B?RzRSSEF2amdWTUxkRXltM1JJSmF1UTJBWlcyUzNvcnQ2dm5aWlBpdFp4ZU1J?=
 =?utf-8?B?OVFod3BiOEliNnl0Z200VnpvcUV0YVNHTGJHYlZja0VaSFVXOU1LNkxoRnRa?=
 =?utf-8?B?M2QxTXBwdFBRSmpmbnFRblRseUhEYW1VTkNDM2JLT0k0aTRvWHU4eXJVZHA4?=
 =?utf-8?B?Yk40cDQxQ3Q2ajh2Q3J3SkxvVnQrK1VGcmhQVjJJdnYvQWtRbjMzaVdOYWVw?=
 =?utf-8?B?Y0k5UjE0KzRhZjROdm1tVEZoZkdZeWJQODdCL1A4Q3B4MlpaUDhIdCs2bHFN?=
 =?utf-8?B?UmxOR002KzZwQ3FhaTJVeS9wZ21NR1MyMHR5RUMyNUt5ZXlxRHdVT3ZtOWl1?=
 =?utf-8?B?b0ROQS82cHZYUU12UjUvc3JMN1JIVVlMaHEvZnRBcFNoSE1lZnVqMXJsTWxC?=
 =?utf-8?B?Z3dxSzNEM2lzN0ZBRGxrVXI4Y05zaVV0T2Z0cTdpOC9NVzZMQnhHYzJZdmpF?=
 =?utf-8?B?MlVWeFUvamtDanQ0dHAxbGhHd3RING1mZHB4NVJ2RTJoeVo1Z3Uva2t0TGhr?=
 =?utf-8?B?a1BEWU5yYnJIK1pRVldUdURjU0gwMTdrbFQ0ajZkY0QzcEo0cktjaWxNVWVP?=
 =?utf-8?B?cnpTdUl2aThESGtPdStWUkJvZGpNdXl3aC9jUzZTU2ZiV1hhVW5objB0YUht?=
 =?utf-8?B?TCtHNEFUaTM0ME1vem1vNUs1ajhvaHk1Q3JyNWEyQmllN3FlNVNzdi80V28w?=
 =?utf-8?B?TjE1L2RaUGpVN1hYdE8vSTRKS2VOaUxHUGRNZXU2NU9oN1RYYXJhWmtPK29o?=
 =?utf-8?B?MFp3ekZ0TGxJZTBjREY0TlVyV2dzTXhRMVdjVThsVjd1MlpoQnVCUTU3a2NS?=
 =?utf-8?B?Z0N3OFdNS2hqYURhdCtzTnd5cEZWTEczakhYbFBwUTdrZzBiRnFBVld5VWI1?=
 =?utf-8?B?ZXQ2RmJubmpPOWdSbCszYlhJVEQ3QUNxVHc0VTM4SzdLOE9jM2xjenJCQ3h0?=
 =?utf-8?B?OVFyUWwxSWwyaUd5dER0bHZzcjNvUkx5TmVCM1NwbjVNWVNnc2g1WVlzMFBv?=
 =?utf-8?B?VkFmeThPRkN1ckNHZHlOZm1iMXRHbXNxTENrT3dVeUhhSE1JNXlJWHBVUUJv?=
 =?utf-8?B?LzZmZzRmS1doKzduZnRETTZpMU9rVi91aGdnWkRtMEFxZ2k1OUNkaVhtd1Bu?=
 =?utf-8?B?cDZzQ1dXcUpBM0JZcS9ON09KMldMcEwxSHJNbXVkc2tMcFYwZlJIWnh1bHVI?=
 =?utf-8?B?WDZqTHJjcEpDV2x6QlFZb21oOXBrQTFkVy9XdEVENDFlMDc0R0NtSVlnRER1?=
 =?utf-8?B?Skw5ekxYYi91MUdLQjFEalB5NFlUalBWaFFPVG1oL2lxTUw1KzJ6aDZYUHRW?=
 =?utf-8?B?dGxkb0RsS3pTUXlGL1ZURXg5TStCUTF3K292WnFnNTNYb0dGMzBROXNJYXY1?=
 =?utf-8?B?MnQ2R0lHZ3Z1WmZiQkxuc3YzNVJOQlQrQ1BFSnhXRXhLNFBSTU8wOVlsTjZi?=
 =?utf-8?B?cWJBOVN0azVOeVVRMDhCME1NV2tmb1UrT2ZZZTNMbU1IcGh3NVgzTGhqQ3NN?=
 =?utf-8?B?UnJMSjl1WFdGWjFDVWYxdDJpRS9oTEFwL2w4MlRoeXpmbkQ3L0hOYnhlU0M1?=
 =?utf-8?B?cXBxVEZrcWRIdSt2c2VjcmRqaFNqQnFPZlZtRFFlTTZZQndhaC9FNUovcVAy?=
 =?utf-8?B?anY0c09rTGlubEtTUGJQZFdCa2tYOXJBWnN5Uk1BUkR3QXRqMDZBZzVJTTlM?=
 =?utf-8?Q?2NHj7hdj+vSDdDI0=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 839b8b69-ef46-4d81-7cab-08df284b9531
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 10:28:40.2512 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xhk+Lod43P513iWdwanzs+a+LJNE2FGi/tT3Fj+IkVB/I7bmSAuQKaZop7g9FzbACzdZkOzus0zD84vmQms16dLluKxp2sTSeMAvRh4XphQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5523
Received-SPF: pass client-ip=2a01:111:f403:c207::3;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=MRWPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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


