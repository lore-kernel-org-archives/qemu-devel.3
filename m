Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66BC7CA5FDD
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 13:04:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCcuy-000192-QT; Fri, 02 Oct 2026 09:03:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xCcuL-0000ov-67
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 09:02:38 -0400
Received: from mail-francecentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20a::7] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xCcuJ-0007Rf-GE
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 09:02:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OTgY7fThhexcZ5JnLf4O09qxoV7pY/6JETA2ehCnwIFHigXFH6UIl70oa9M4zl4Jaj3Vk0cSkvN5CV3LNdEwraJXctkf94Bi6R3HmD7MvQT6/i23xRAoCyT3wGfK6Pw2doa9naxaJWTMLW5174UqTxF9H01nyKYgESRLp950+jtaZnbah/Fe90Ar1jLFQwH2PW/7u9bHrL2ZSLdV1L/NJ1dGL5Lr/HIi4EbGeBxAcPL2djWbwBcw53IvNWm1Ix/0Rt0cnRtEOT4vdRKk0tg6Ql+v272SGggEqaIE0HeCuh5+ID+atGn3KcoykSClX2eIEJ4PlI4Wn9N6qeNagw5PKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3zZJ89Z45bQcI+MDgmQM5LzF7kuk0PxBH91uljpEleQ=;
 b=TNdK8J8TjFEfmgCR4eSCFEzHGGRIESBcrdrACJWMlDKu+cs6Yp8YXnjTHN/WY+mooxZecoiXk71QcDCMHQp1li8bb6nvLL9JK+ZLKMBAqKt8bQBispDGxK7s0kP2lDceQjxW8sZnDfxjsXSjKUDW33HdJHALWUxZHYypYS6JOuTI94TPxBzNSwxwvKpcrfihHAITaqbSN/MhKOEldq1Iser6NTyfyRgkw4Rlvf1XdDtQx6+ejgXqWFfGhcOo80on6VDcqwkDnO3MNY0EgTj2db2WYa44fZ2aYaoWm6Gj7eKFNYAscr7meOqe4Mz3qOgCbNyKHcRYrNcTI5D60Ouunw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3zZJ89Z45bQcI+MDgmQM5LzF7kuk0PxBH91uljpEleQ=;
 b=hrelyr/LPw0JBczO+MD92m42qebQWLPAkPnvtZqR8D/LjTU/vpBi3TzMqM6KFJEF8tkAYHyzYx78v8IPv+3O8OQswc+Y3taJzgUeY/gLUNO7uhy2PUt/zmARLyjxiT+M/9br7uhONxr7KuTRIZzeGDx8lfBerewGHxhC5QKFSjQgIr0d+qjrvWVbS2wyZvf1BbPKKS4IgHj3WZpJK4Pgg1ReasDY4qfZPocOJ/u2GRBi7uWECz66mTAm56zvXo2TYPjJfl8ZLnZz4BIZ/wX0W9gPBKEU+e4sBocp8hFT3ySlVk8yfMu/NcNNt2lfC/eULfjX76ia5xGJQZDgt5BHpQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AMCPR08MB11995.eurprd08.prod.outlook.com
 (2603:10a6:20b:76f::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.12; Fri, 2 Oct
 2026 13:02:28 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0472.012; Fri, 2 Oct 2026
 13:02:28 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Fri, 02 Oct 2026 16:02:20 +0300
Subject: [PATCH v11 11/19] vhost: factor out vhost_dev_init_backend()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-up-vsock-vhost-v5-v11-11-18fa09d8273d@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 669b859b-2ca0-458c-fae8-08df20856964
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|52116014|7416014|376014|18002099003|22082099003|38350700014|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: 2u/MsBm6PsMmzqvfsAjpDLIl3jw5SfkVhStLAV4irju2IT1nUS+BXExhNDRUI+LI9zFb4vD+aSQ3Cv4Te/pMCBQ1pDRBEA045nBttaIalnWBPHoCxbsmKanZ44a0841CHJzsJsorUQvkbNrit6o9ceEpS6kWI8on1PRntkBQQHTLFgZWjAMSD9+KfXaVvc6MiDQazg9UTPhECUma/heAQ97kQG6ckNMHCwNH3dbQKmCiYWlBFlWhvCBZM5WZHNofW6LMmNrCI5pi+WxEP1k1xvYSw4353D+AJc3Ysm4Z0z36OdcF4TLI9PBPLvT1bYZOMadDwtbHAjIfwLxd+5aA8CDcKQIjCxe13Om2s71g2nfryTO/n5z4iBB+IU87prVCtCffPt9Haqh410+YcpGH67NoITWEfQsx0Nk2nHEQ1gELMES5CYb6+FKsuf5N4fDgrD5XXaX+fRjbbH5bHIFxggO8fYkHftKVDaZOqwfrqC25TuijH8qRWxMEvSb7yexO43vtUw4ENMM95P6VL36mmxXnp5f/JAD2TDntJSMeRqwqyl4bKUNZfSfKTk/NiI2ZK7QoWAnNNxhZZYPoVBJ/x3+l2Hth3Wwnn6CS6Fj40CDeFuqJVGbnyr5u7pGdCxZDntbJkjhy7dWHhrGEeQJKFa09nGv4tsaBFASAAm4+XU6elrT6DqkJSy23EYXnjcuJR7bDDa22N+yBpi/m41mhF+IRljRpQ1s8szJfq36bf2k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(52116014)(7416014)(376014)(18002099003)(22082099003)(38350700014)(10067099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?anJ4aWJXQjNRcFpsdDRueHo0dzI3SnpJeDdRU0FhdjlDWllZREhxSWxhcUVO?=
 =?utf-8?B?eFA1TGdMY0J3dUVUaGZ2ZWo4SVYrWlhrd1E2VFVzYXBrVm9JbytHc3NtR0g4?=
 =?utf-8?B?RlhYSEg5ZEgwWEh1aTNkNWlPRzc2cDVFMmxGKzlGcFVEWi9FK3VNdkZ0QlRZ?=
 =?utf-8?B?OHdKY2s4dmhDUWVlVFdRdVAxdG1rRnRsaHFtdWlmT0lQdElaV2dqT2JWL1Fl?=
 =?utf-8?B?OHNJaUZmbnRjU1VhaWRPVmdiMWJIWHpFbnh0d21zZDNvNWtnTGs5dCtTKzFn?=
 =?utf-8?B?OTh0N3h1TzdvbmhnQUt3dkVLcVIwSVBVWkNrQjlMS3I1MUViWjJDMGVsL01C?=
 =?utf-8?B?SjNpdE1pdm1JLy93SGJ0Z2tNNWZpUituRFJlMWR3dFdGM1cvMm1tSjNVem8v?=
 =?utf-8?B?d0FWTmFPaEp5WjdDNG5lMTdhSTZNWEVLdTNCQ09SYmNOQ0kvZ1l6M3lVWEZ5?=
 =?utf-8?B?a2dBemtPaE1nV3k1R3U5cUlJMktpckRZWTBRb1FyY3U2ZGRlZnNMeUpXNHpU?=
 =?utf-8?B?WGxSSXB5V1FiZ0FoaGFlQ0tsVjJPU0VLSm5JeWN0cXZWNWtESzR4ZDhqUTBN?=
 =?utf-8?B?SkJMeWNVSlRVY1RaT0lKdEMrUzBWQm54ZDRBZzF6Z1RPNTNoYnVVSVY5SFZN?=
 =?utf-8?B?bUd3RTIzTjZFY0FmcHdBT3l4NWtnYW0wYjBLZEdmakxubVZBQnNqN1djMnl4?=
 =?utf-8?B?YUlTQjVHQXhobnluOGtFZ0lLYmJRUjFXYTZWS05BUlFubytDNk9SNUtiMHUr?=
 =?utf-8?B?WXJ0R050OXM2ejVXTFlGZmZ2V2FmZHE5N2RSUVdZUGplTHdza2EvN0psQzA1?=
 =?utf-8?B?YXpJbDhrdDNQTWRUdkpIeWROTVlUR3hWZlhUM0ttNy9UZzJLVUVaSVp2K0Zt?=
 =?utf-8?B?TFVVOUpTcEh3NXlaejRLYlJCNEJPQVRHU3pnelJodDUyaU5lYzhkZWlENCtx?=
 =?utf-8?B?aUd6UWZ1ZGVrYmo2RnBlaUpiRmplVXFPL1VENUVjcGt1U21xQlNtNmcrQWVG?=
 =?utf-8?B?eVdMTDAzYW1zbzBwUWljM21jcGFnQjl3cXNLRUpON0ZYRWsyZ2FuWWZtd3Ra?=
 =?utf-8?B?d3Z6UmRacTJ1a2VCSFdCWHZ0UGptd2NXb3ppUWs3UTZqNTc2Y3FzZjg3MU1i?=
 =?utf-8?B?bXB4R3RXY3dOQmRmaDZoZGcxMkI5TGFWTnl4d3R5WVhOZXlXY0dWL3FkN2FB?=
 =?utf-8?B?WThMODVDdXNiOElwMmJ6U24wVy9mK3Y1Q2FSbXBRUHFCNjBwSzJWcHpMMy9l?=
 =?utf-8?B?Z3ZJcWZZOUEvU2p0MUJ2TlNnMFVaOVNWa1Z3NXNSRllKT2djcGZGc2x2bzNa?=
 =?utf-8?B?UG1jR1NYU0NKZnFrY095dEFhQWJaYkV6VWdmVThnU2tsQkd4MlJ1YkVOMUVM?=
 =?utf-8?B?bEhaTkY3MEtpR2FYVjhSSW93N1VIL1NWNDZiZXRFVlhrYXZMZzZIZDhYdkxt?=
 =?utf-8?B?Rm5oL25vL2t1dlBjeEJDR0VKS05tcTB4WlV5OWdtOVNhK3hjOFhRb2dReXMy?=
 =?utf-8?B?WXZEK29YaklhdytpSXN1RVNURmV3MTcwYVhySmYwZFdkcWtPWE9jR0k4NkE3?=
 =?utf-8?B?MmR3TitNdGVkTHRVcHplelNhZ285S1lrTUwzS1FoRk5yQnR4Q0NyaDZIWlQw?=
 =?utf-8?B?WDNHZGdveGhqbXp3b1FVaDllQ3FhV0UzTEZCRTN6QlpTR2haRlF3RHd2cUhp?=
 =?utf-8?B?VGk1M1BxcUFmdzBQNmdWNTBEQkxVLzI0MjFXQ1g3K3VxQmQrTFFxTnR1R3pG?=
 =?utf-8?B?Kys4ODl0SmIreWk0QUdBekh0cVlKc1cvM01yQVBxd2o1OXpHejZYL3laeVZS?=
 =?utf-8?B?cG9STCsrMmt6a2U3VGlQczI1dndGY0RGbXNlWS9JczdGcVg3ZWpsM1dqRkk1?=
 =?utf-8?B?MG5UMFVqWWxsUk10YzVtOWJDTDQ2Ly92a0VRNzMrT1Y4OEw4TDVlRjlycEc5?=
 =?utf-8?B?Y3g2QnJ1bG9MblhxOHVrZEx2RCtCc3cxb3ZPQis3TWdDeDV3RjRCbzZMbk0v?=
 =?utf-8?B?WnN2RnJaMzhYTkxyb2pUM3I5S1hiOTJvOEk5dTloY0xvWkRYa0JxSFV2YTBa?=
 =?utf-8?B?dWlpamVzRTgrcWJIMmdmVll3ejRzaGJ4ZnBVKy9KVVlGaWJrdnd6ck1VTW4y?=
 =?utf-8?B?Z2FKbXdIYURidGdEMHcvUUdJdTBGUXJMUHRRVno3OUF3dDFkdGJDUERnVVJ1?=
 =?utf-8?B?YlNKUUk3czNObEZBMDZaQW9PWS9sWHNIVEtSQ2N6Q1c1K2lZbGt0Nm9RT1dj?=
 =?utf-8?B?eFd0clpjUWxTR243cXZVNjk4NEdHUWJaRzZMQmhyNDBOZ0xzRng4V05sTHVy?=
 =?utf-8?B?TDFvZFJFT25sUWhUM2FwZlNDdnB2YTRXeVlaMGhKb2xkUlNJazFWTlJKeTdV?=
 =?utf-8?Q?0qMlaFKk/WjeqEs8=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 669b859b-2ca0-458c-fae8-08df20856964
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 13:02:28.2173 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CPEMEyFy1GV9/aSZZc5txB2/UdLti5TSyy5RjeDbcq/s/Kt06xFbnlq21QBCRZDxJE2hu8A8M0QpegAD2Q30UEmSLHvWPbNKXSBhx1ZqtGw=
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


