Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2390CA5FA7
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 17:25:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBbYf-00065x-FC; Tue, 29 Sep 2026 13:24:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xBbYd-00064t-SV
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 13:23:59 -0400
Received: from mail-northeuropeazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c200::5] helo=DUZPR83CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xBbYb-0002lB-7t
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 13:23:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OvGvs1+njYq1fnsx3sTgv37Ts81ep9yP5rKZKvi9ZEJ+mSmmNjB00CLBVlOtBVeC42v8oChmjp9p7jdEoptIo0DEytReLV4PtAcOk97RgN2twIgMZa3+PEp24Kmwm/4XVITZ27Ib2j8Fq0GFoLMZc1nSXW2PAVGhCdGw1bV92teag0JY5AWP2/+j7vXsI9S2WVWbVi8P1wCVyxHU64SBaCzmEUYqYA4g63So+og2ctqqsw/7Sxha6JWgjiwkuWTeKlMefDlnEgS0/MkItyNB23gTQXoBE+gqCpaNmeLbOdy+TCKouuwiYsaramyEz535WbzALnwLZ++JbUldm7kcPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3zZJ89Z45bQcI+MDgmQM5LzF7kuk0PxBH91uljpEleQ=;
 b=VSrWh/gJ7pqAkEfIisGoTrbQ337SGhUg+6VHjk1aiYLTum49UrLG0fX2dtZMmgv3k28LpJU/zEqA7/XxggfUhwfJ2MwvEbi6Caqk4Yl6fxxmbHfexoKn4VBNUDv1IXdXg+K4lKOhpNICB3HNCMRUh2CZy7kuHMkfqFlnz4El4bZTMMyeVC0miu6gie4tFgJ6NvdJT4aiqUVbyoHWim93D8A58X4c9q6mzCYGz1udUyOMz0itvzFipHfu5/NdmvHUbGtVAKwSs+rmZvchlunWKyrt3GPulx9l7sWIH6qvUaxe/H1jL3niMlQLO7EszSyN0phl90b1UkiqM94abTMSVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3zZJ89Z45bQcI+MDgmQM5LzF7kuk0PxBH91uljpEleQ=;
 b=Ohm4WWSAI/fG1BDAzF0oxk5nGfr7yp3DYFHGNvyorfRJDWf9ISmNJ9K0d+EEx/blXAVjYoa5mjkwxbWAtW/Tqss4HaqlZaBJ9k2BzT/znQeHH4ppTqJ1fut02i+v3N8DuRQMExyAvH2M2Ec2dtnDJwPx989CD9/bP7PfJQvqniM1lGH5Pp0eXRxgKaiEXHLHoBETW1Ny6ZK68K0C8HHCHYaSdNpH4gaTlVmsAvDeiHZaXCCvlG7NkB+Iebwp1lWgnPGXGD3sZLW7FWn1QDUBsS+GDbfyLGMl/v5AOUq6sa7xFujW5AGInutC+Syz9Ypxo+cpVHfKLpQFUec2t0xErg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by MA9PR08MB435041.eurprd08.prod.outlook.com
 (2603:10a6:250:101::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.7; Tue, 29 Sep
 2026 17:23:52 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0472.012; Tue, 29 Sep 2026
 17:23:52 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Tue, 29 Sep 2026 20:23:30 +0300
Subject: [PATCH v8 11/17] vhost: factor out vhost_dev_init_backend()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-up-vsock-vhost-v5-v8-11-12bcf1c0b84a@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4ff9544f-99c8-4a6e-b1d4-08df1e4e6eb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|376014|7416014|23010399003|1800799024|38350700014|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: /6PZcp0fzCPSOm23T8TMIKYF9wc1YbeTLtHkJkLHXvgRasT+LlLP6vFNvK3hSoW3+VaIh45f+J+YP4e0WFfl36tUBnodS4lJQo8wJeMmiaet7SMHsBi8w90AEBsFp9KmNpz33EtIjjLPy2CMXi0BKZASjuXWqzkCN4eS6Iu1BO2O20qB02FeNXtM7wHuGQ7bh9Aql0rN12Fd6R27npsU219qgd9RGeG2+9Cga+84Zr/rKh5M7enLdDA5vTvOoc3EtBgfGEbiuXQ4gr4pHYYTi6nr68s1zpYwS+lu45FXQGdjHpv1Te7OdexJEhfpIQsY6BirRXYNOYZFW8qeupu1Sc4rZbV9GFgizj85lDoq9fx1v3Tp395fbvp1bR5Ur+aHir6zIClIK8xRBmaG/7OvYyIpYVCCqbF9Cvu8e6/q/Q5+g0Aa3XcH1js//rcaH0WyKDW2dpAsqILumnIL+zs+Cglg8oKIxP+fCS9DiToj1d+b9UIjrDnLI+HYCfWjpkyzFdU9vJRrxMRR7pz32vzIrSvLBCsw23P9WTZ1BM/vQncwal51IFdu2aqaJlufaFvME74HDy12kcApjEaFiA2D1Gksf4Bd+cbGyro4rVDMVkisVfKlbyBnheM6LC0UlBXJr9Jah44hDsMLhEvRhKMjmhkTVEqZNjXEKaAJlOqxme6i6K7BU8sGrDF8FMUYfCjwFbnDitfikhR5OXotIegZ1LX4fBswLJ1zQy3asiVWiY0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(7416014)(23010399003)(1800799024)(38350700014)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cXVWbEdLeEVtenVRU3oxWEdGMjZGUHo2ck9GK2VzendDRHdMQXQ4MlhqUlJB?=
 =?utf-8?B?TmxRdXJyM1krSG4yU2lKR1VGU1lXRlpQenJTZmY1R1o0QWdxSEYyY0ZkcFpY?=
 =?utf-8?B?MGxNY1JJSEI4SENsWGFUOHIxQUxsRDl1K3dua2c0MWVZVEFHNXlsSXpJZzJh?=
 =?utf-8?B?QnpEcCtuaFZSWDgySERiRHJPdHhMU1E2am1YSXV2K3k1S1dOaUNmS3ExUG9r?=
 =?utf-8?B?T01mMVc2VDd1Tnlvem1EVWlaTk5IdjEwdktrNjU0OUZiOGx6OFhlUmI4ZEcr?=
 =?utf-8?B?Z3k3aW9ScWw2S0ZaNExrMVQ5dHB4d0xQN01hWkFOb0dIOUh0T3JnckJ1Q1li?=
 =?utf-8?B?cTY2bHhXRE1YeUlnZGJwQkhJUklyZ0hFSmZublpYVjdNZlpPMHB4OFM1ZTRC?=
 =?utf-8?B?MFVKTlNhR0NYWE1hQTFDZDgzWW5sTkg1WjdzYlNreVRPTDB5cTQzNUZMdWdk?=
 =?utf-8?B?Z0o5VnpTYVArU3dNZzFuN2NDclBEeCt6Q2UvQ3VIdDBWZ0U0QW90YzlMWUI3?=
 =?utf-8?B?TE9GY3NFTHA2VGdVT2JBL2hhV1hPeTYreUdrU1NUV2RaRXVPaGJ6a1RKNzBa?=
 =?utf-8?B?ZVoxV3Q5VUFGdThaOXBPRlFWWmc2MjVkeUtVeXl1aDQ5OXM3SUE4NHgxdCtJ?=
 =?utf-8?B?QXRTTjBieWlHREI1dnA1eUhjNnNKdDhiWFB4VWkyTHYrbVg5UHBFZFNKalYz?=
 =?utf-8?B?L2ZHNjc0bzZWWklFWDN5bUw5a09WS3hVR3dEdk1jQ3lhQVR3WXFuNFhkcWNk?=
 =?utf-8?B?dU15N29VelFJNHRFUFlla3pSaXRIU1RDR0FEbVFyaS9SUnlDSUFGL0YrZXE3?=
 =?utf-8?B?dElXNmJVNnFsaFdzRDdiRU9ZdmxsU0pOZHl3RkRUZjNMekxWa1R6aDBzcC9y?=
 =?utf-8?B?ay9Mbk42YnhTTThrVnYrbjhNeUl5U1BXbzUxZUdIdW5vTFNKYU01dnFjT25D?=
 =?utf-8?B?Mjkvb3dmbXA0TWUzaXk2N3p2S1RPN2dZbU12UEwvK0VnbTJjb3ZPcFBpc1Bn?=
 =?utf-8?B?dEpnZ1p3TnF3SmNoY2Q0NENLazN3SHhVcE1jYVlKQjFFRWFvMmdXeWxMV1Ra?=
 =?utf-8?B?Wis4THNocUFOWkZxN1pyMFg0ZzRNb0JjaTRJbkZBejVGZFIyRC9NbmxhaEk3?=
 =?utf-8?B?WkZkUXo2dDk2ZkhubDF5YnNLVjE2T1VTcDluZklzTXpmUXhIZ2VWL3piVlY4?=
 =?utf-8?B?anpDbHptWlBJc05UcEYyTWhxVy9WVmE1RUd5dTFaeFdKMnZ2aGhOZ0IzUlJW?=
 =?utf-8?B?REYxbkxteHYrRGNXNGZ6MjBWUWVEWjBtYkRwa2FTUlFwVllzSU5URXIyaGpz?=
 =?utf-8?B?S2lHNjY1Y1JDTWxZYUF3QW93RFNWSUhrZm8vekJGODhQcWhZeCs2cHd2c1ZB?=
 =?utf-8?B?MWpReHNjVStDZXZ6ZmduQmppZ3JUanRBd0FWVWJrcHcxRjJKWjl6V3lZUEFU?=
 =?utf-8?B?VkphOTVxeFg0SmJ6K2psbjZpRVJkNEZ3bk54ZWFzZHBzUE9yOVpyYzc4N1Vq?=
 =?utf-8?B?S2tFMkJWNlVRVllXU3dxSzBEUTZmMjZDdThxazVrSW82SDJBdjVrR29zdHV1?=
 =?utf-8?B?WFNuSkRqczVURWV2N09yWUZyanZibHJSRFhjdFpMNzBleGFNWWJJaU45cEgv?=
 =?utf-8?B?eHE1aEpHSHJsMDdLZnAwWmdhc3VUUDNWaGlhRkUrSy8wVDhqZEJ3NU81cENT?=
 =?utf-8?B?TEhBWjRhRi9mbWcyUnVsTW1aaDZVdTIxSmlrcjZZMXdSZ3ZOQ1dZaGxvdUFW?=
 =?utf-8?B?RE5wRWJTcW1BWGNZSVJRQXQ0aEJyYUJZam1mZXlCSjdyRS94d3oyZVhKVktq?=
 =?utf-8?B?aURhb3hWOW54ZDYzR3N1cUhORTQ5YmptNUQraUJkZWtQTWtPQlYxcnJRRGlG?=
 =?utf-8?B?NWE3KzVRZ3diQS9FYTh0ZDdVNEw5bnJibHpEQzcwV2o2b0lIY0Q4MmZ2dzFB?=
 =?utf-8?B?VDlaQURGenNMVHFpMjZ3OGRESEZDV0VjTjQ3aDNSUmw4R3dFSGVNR25aVGVq?=
 =?utf-8?B?bjFZa1FBbU1EVVYrbEJXVHVWM2lCSnhDdkNSbnlIUW9CYk11bkJqdlRyWk1J?=
 =?utf-8?B?UXc5bHNRZmM3NVh0dEcxQy9lS2NqRTVrSFJEbWphcm14Q0VRRTJYNENyK2JI?=
 =?utf-8?B?TitiT0E1Nm9TK1hIeXRFV2hielBsV1FFRUg5RzExazltMmZiOWQ5M3JpN3FM?=
 =?utf-8?B?alNHSHd6Q0xpaFJkQ0ZKb1UxUEVWL21VZkd4bExxSzh3OTFuamdVRVBDUHF6?=
 =?utf-8?B?elY5ZmFva2VkMmV4UC9tUVRpcytvbUs3djdPbWpsZjBhemFYU25QUWdPUEFY?=
 =?utf-8?B?cVVPeFhQaEd5Rm5xR3IwQ3RGYTh0MUlsTDNJOExLUVJoTjBQUHhHUzFTSUFt?=
 =?utf-8?Q?Y6zZftpXETkYvtD8=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ff9544f-99c8-4a6e-b1d4-08df1e4e6eb9
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 17:23:52.5028 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mzt5AOajFx7wNG2jwdBWzNrUQElAyeAoZQAtFlr3UxEHyzjij9Qk3BoJeQQuJBcIY2nz4Lq5u7zuxikCMlQNxVycfUZfAcc6mkHQHKJbEik=
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


