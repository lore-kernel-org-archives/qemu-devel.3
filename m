Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECA11CA5FD4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 13:03:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCcun-00014e-Px; Fri, 02 Oct 2026 09:03:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xCcuR-0000ti-EX
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 09:02:46 -0400
Received: from mail-francecentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20a::7] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xCcuO-0007Rf-Lt
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 09:02:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g/eu3fWYsvL0MWYR3G0C2hQsF8udcgWcY7mYoSu4XQwOjCW2txY5IF4AO93OSwmfOGiV64hzb1yGMx2kRp7X9HZ60+HlbG4RDDtBGcstS4m2vXgQNCOZ8cKq6GePVoNmY03nikq0R/O4IBXZkuXM19GY8xc8hOa4O9GOblmn/A0p/7GxtyoKDvNKvTQFoHQIv4Py+fIcQIm2wYWxgj+ia2Hh3ugHmN3V3RrhLcFuOPsY67xLOfrepzwyiHGakDXGQthm9CIJDHWsZmeu2fX+LR1FpYSfTQHJqp1LDSb2xxB07S1GCE+KZM+q4ppiEKP95Q2beVvi9edd/xNxOA22pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MwrMOjbNDkBKfvJaT15RqDxDYeominibToCZs4sNc1I=;
 b=SS8qAEj008O5EnU5BLKpu0dV9tlpnR7FWJQzdhmZ0+LVPYIYfooQuGDBaLawAOoI6UgsX4e4GAIlTqDAMNfRuhV8DpFDSWp+JCGoBolvXxrpd4C4if1WH/A2c41Pfi98jwukqrnXCRONX9pXoHOOn8OiSt2DodoVSYGhl1SYphFMtUqmbWGPSTAoqBWUtwzBULwQ4SzBNjthkg/kvEB8nL9b3IF+qBFAmjLes5X6GzWkJWg0HrYH1zsFGhvXoysP3M/xnFpK2cmJuriFldCyVKXqZHdp5TQFz4nZjyglE1AH49AZ7F5gNwe4p0l4QjCkTfEXIbkiIZL9gpVl9NleLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MwrMOjbNDkBKfvJaT15RqDxDYeominibToCZs4sNc1I=;
 b=PYJPm78e3SBLrZwo/fkIccYhgGBmVHi1kU4gIX2E9CfgumqffaxKYPZeg5lznXonj3mcMHgmuBQ9F4aTHPbDg9EV9nwUfQ6rKVEG0XmrktPI8pP7B+a7cPaO3uIh2q7kEVcruMNX/cXguCUZRllVHOLimm+yrBcH+5KUAmtl8zqNyOEwxWLQEomOPP0fJVpfHlHhYc5/LSmamjEtij9L12nZiq6WJDpbmPlGCQbC4uJyVRGZBbf0tnNMbnNwTaSSCpg3dAP6+szpsRFu0JM8lGeGZTMpGBV4QpFQkW8NBk2olbWH1Dhm/7YgmbrIHnDGGAljHuknNCpbrIezz6Rw5A==
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
Date: Fri, 02 Oct 2026 16:02:26 +0300
Subject: [PATCH v11 17/19] vhost-vsock: hand off device ownership across
 CPR
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-up-vsock-vhost-v5-v11-17-18fa09d8273d@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 406221bd-31b4-4c17-c723-08df20856bfe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|52116014|7416014|376014|18002099003|22082099003|38350700014|6133799003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: OXm4Pda0Xl2XicEqjKyJuytfciej3JgQwARfMu9NH0fy2ggMlmOaP4AnC3Myd1wjgLsyMmEHIn3OHhpO4QVn99H89Wg4uLnzWENONcuocKwMCH6vrf3yCABTZ+ppUFk6f0S7JqTibFRHYy9tXsCw8JIYwTKI6w3qTbORtMwvD07b3xSpy/yixEj/9V3T87cTXjhU+4DDoo0Sm4+KURhasVpn501jfTEKXRd9svGltF9wUCo1axyTYamSaH5fhdog3a98qzWBKR3TrOtX93X4oOkwkN5VEPADerT6fC5agfY9OJ805yMxNF+fgRb+JTIiKJUi3F6pmXWX8UfRdKGSOWFnsz+Jpy3zZMEMBKeMeIDmueCdxN80m5w118WyE7GcsJ5cI/IoWteYm9b1WDH7l5aSW9mzNZOBc3ToXNmdTFajA//g8diZcUpa6fKRyQQxHejoNUsMBN7c27vossegAowBGuezb6yC82r1jKHF9HzqshkuFcT+zWBCMkpuWUWBAanUJAqz3JvtGKgMxex/HF1wZzt8NTsL9MIEc4JecF06LFizGJ4LJNVVf+9YlUQHaaUPcYDwopAvI9Qy01KW38eZ5yHlxZ7Xq7+4lYAwwB3sQL9dANSqBrwUDHD+M4+QG+H9JA1uzjOYWPOHLR36UdJ6fqJZIuYQpym7sVE9EQESP0rltzSbi9VfPEl/K4J0VmTFdaS+Cj8NJiL5QEMKr9M5pbKJ0f0zd1tjKMvdt9E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(52116014)(7416014)(376014)(18002099003)(22082099003)(38350700014)(6133799003)(10067099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QllYT2FUMWliWmZqSjhBSmVrdXcrNE9vT2cvbWZFWWZJNllIUmFZWGlOYTRz?=
 =?utf-8?B?VkxlR2I2YU9QZlJzYzVERkd4MjM3U3d5OW5FUnNzUHdmRWlKV282UnBJSHZx?=
 =?utf-8?B?bERZa0FqVkNVenZQZGdCbXJQRm5mVllmZEgvUXZXUVNreGk5VTZqaVFQaGdU?=
 =?utf-8?B?bUFDZjhSSDVicGRIQ3NkRmgxNnVBT0RJbnB0MllnelZ6WU95QkRmbkJCdFdn?=
 =?utf-8?B?SmFSbFBsaGU3RkJmbmVOdnhELzd1ZVFLZ2FvSVBJMlFLenNmV21tSnlmQjk3?=
 =?utf-8?B?TklOMVFMSzlnVXgxUjM0alcyQUNzeEJPdkJWVVhOeWQ0by9wWWovUXRqczZo?=
 =?utf-8?B?K29rRElLTWg1OVMwcWcyYkpheGpWR2R6dXR4VUQ2OG01ajNOSEJ0clFTSXYy?=
 =?utf-8?B?SWJCdTUxM1Q1TGxwM0hVUmtkM1BoZEdhaGFvU05DV3JLdEMyVGZDcWY2QVIw?=
 =?utf-8?B?ZHduY3ViTHVwZkdOY2ljRllIMDZhYlBlSW5GaHJWYmgyeHR1OVg2bWRpbWhk?=
 =?utf-8?B?VmEzKzNnaWVLc0FtamthalZ5Mm4rNTBMREdKWmZKTlp4bGVHT01OZ3RMYWdT?=
 =?utf-8?B?dFJJOW96S1RiSzIzNlNJRmlURmRpMG9ma1pya2xpNFRZVWF6ZkorRWUzRm1w?=
 =?utf-8?B?dGRjQngvY28xZVl0QkhUNDV3dTFybFdObnEvSDVVYjMxRERscUhYNng5WVQ4?=
 =?utf-8?B?U3NySmx6OG5KbllQZFpnWnhveFkrRDhEZFEzTVpvaGxkRGozMWRaeUtLVjBw?=
 =?utf-8?B?dTlMR0xHQU1nMTNMVHdVSEl0RnZvUkRQM0VpUHBRV01iSXRDRW9wcWQ1T002?=
 =?utf-8?B?Z0dpbStlVkRBM1BBSFV6WDF5VWNnckxveHRvejVqbHJmc2FjMU9LNXlML0ZQ?=
 =?utf-8?B?b1hDbTV2SDFqT1Vpcm11ZUkvNE9tTWpMbG82cFJicjU5cnhoNXp1ZVdxNlZp?=
 =?utf-8?B?bWhmdFNaUVFyREZkRkFqRmFkNVVadG1JdU1yaE9QRnlXYjhnK2NlK09ka3Jl?=
 =?utf-8?B?RVIycEExYkFTY0FUL0l6bW1VT3JCWnJ0S3JZRkhUeXZGK1pYcWFPK1RlWDNV?=
 =?utf-8?B?ejRxa3JTV1hRMDlRNVlxbHVodklSSTVwSGpKZEtmU20ySUNkOVdkUUJYeEs0?=
 =?utf-8?B?anFUSWtNUFFXWlIxdVhmVXFBWFBoeExhK2JSa3RoNEoxVjNtL3NaZHFmQnBJ?=
 =?utf-8?B?cUZWcGxlY3Buc2hETlZNK0E2Rk5lUjl1K2xJTVBrNng2SGc5cVZFSjgzNnhL?=
 =?utf-8?B?RlVCTzcyV1c1NGdSaHVWZnliVWhQZlJORit0K2NMQ0JkbDFSVTZJMk5ucHZy?=
 =?utf-8?B?d3hEY2V6a1Jtb0ltR0xNZzdNcmxDRGpqcWtQVVQrQy9aR0N2MnAvSUs5R3dH?=
 =?utf-8?B?K3NEQmpYSkJLbG9DYVpSZGk4eDdCZGFPdjQ5c2JqZVpvM3VzblpHVWNHeVdV?=
 =?utf-8?B?emh3ZjVPYnNZUkJzMTFrM2VWaDRiN0p1R3pVRTYvWHN4U3lkeHlSQmVQY1pq?=
 =?utf-8?B?NHhaM1hQaDRmc0pFQ0dLSHk2N1Rxcjh0ZUUxTGt1aXpVcitUNlhnMHZWNVc1?=
 =?utf-8?B?K28xVmNUVS9pN1RKSHZoWUl4QTl2R096bllLQ3oyNnprMk4rT1NMRFR2a2lC?=
 =?utf-8?B?SzdKQUQvTXdxaHVJR2ZVSlp1amp4Z0JxNUtIUFlzS2FxdFdkZ0hiM2h0U0or?=
 =?utf-8?B?cmJXWjkyckdxbTZBUnFMRFphYWxzZmlQTEJaaks2RnNpbU9FcW0yNHN4Q2Zw?=
 =?utf-8?B?MXNZZ2kyd0JSTUp6Z3JETHp0RGtMa0xLdlFuemMwL0RpbjQwMXF6eDNKRXAx?=
 =?utf-8?B?cEwwRm9vQ0xlWlgxbXEzaDh4YnRpampaZkY4RVdqckVFYjhqQW9YUHhqRkZU?=
 =?utf-8?B?bHZKZlBOdmNDejc1eHJ5V3o5Q0lnUjVLaVFmdXZmbG1QeHEzbUxZU0ZJN2kz?=
 =?utf-8?B?TVk0Zjg5cnBuYkxoU3pncHVlUjYrUXkxNFRTbWhib0psYlRwZ2VJZ2pURWxQ?=
 =?utf-8?B?TFR2TmdBS1dFTVYza3h4S0twRmFFQnp2MDE4dVhvRWhkUWU1SGFVMHhoTW9T?=
 =?utf-8?B?NFk3WmUxa1lZRmt5NTNNRUlzSEpxTjU3OXk2cmM2OFpjQTd5Ym45eWVUdTdK?=
 =?utf-8?B?ZGsycVJybmsvdW5vdlpHelRhdnd2NlJ4ZThQWnlDeGJBUzVtbzZjMjhLc01U?=
 =?utf-8?B?US8zTENKaWRKL0gxd0M1MDZJTUFtYnZlbWxmQXRpRWNQcVIzem1Iejdoa0FN?=
 =?utf-8?B?am9UVmd1QlBqN3U3WjFVZnBjZDJyeUliUmlLc3R1YnZIMG9hMWdMSVprVDAw?=
 =?utf-8?B?bk1RNVZIbE5nWkI0cWVhWXNWdzV6QzBEMXY1c3EvM2xNMnlNNXUyR1hDZjdv?=
 =?utf-8?Q?OglRY8j923xkONDo=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 406221bd-31b4-4c17-c723-08df20856bfe
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 13:02:32.5950 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bf+Wm9rOg8nhN3DlIdRedAmyy1bqnQXWaPAi6IN9pJf9I2O+eQVEZmh+hkFfgbvNwZeWX8ERkKdfr5mepK2WWKrlxxakY+lEvECH+C5lPOY=
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

The previous patches reuse the source vhost FD on the destination,
however both source and target still call vhost_dev_init() (VHOST_SET_OWNER)
in realize().  For cpr-transfer the destination realizes while the source
still owns the shared FD, so its SET_OWNER would fail - ownership has to be
handed over explicitly.

Do this through the device's CPR vmstate hooks.  Namely, release device
ownership in pre_save, reclaim in post_load, re-acquire on restart:

  - .pre_save() releases ownership on the source (VHOST_RESET_OWNER) once
    the VM is stopped, for the FD-preserving CPR modes (cpr-transfer and
    cpr-exec).

  - .realize(), for an incoming CPR, only sets up the virtio device and
    queries the backend features by calling vhost_dev_init_backend().
    It doesn't take device ownership and doesn't touch the VQs which
    still-running source might use.  The full init is deferred to
    .post_load().

  - .post_load() reclaims it on the destination: the full vhost_dev_init()
    (VHOST_SET_OWNER) on the preserved FD, plus sets the guest cid, before
    the device is started at vm_start.

  - .set_status() refuses to start a device whose init hasn't completed
    yet (incoming CPR before post_load).

  - .set_status() re-acquires ownership before starting the device if
    pre_save released it and this QEMU is about to run the guest again:
    the migration failed, or it completed and the management resumed the
    source (e.g. cpr-transfer target died).

With the handoff in place, lift the CPR blocker.

Note: this requires kernel side support of VHOST_RESET_OWNER operation
for vhost-vsock.  Otherwise CPR attempt fails in .pre_save().

Suggested-by: Dongli Zhang <dongli.zhang@oracle.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 hw/virtio/vhost-vsock.c         | 157 ++++++++++++++++++++++++++++++++--------
 include/hw/virtio/vhost-vsock.h |   2 +-
 2 files changed, 128 insertions(+), 31 deletions(-)

diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
index 6e89007b2ce..65ba573da4d 100644
--- a/hw/virtio/vhost-vsock.c
+++ b/hw/virtio/vhost-vsock.c
@@ -21,7 +21,6 @@
 #include "hw/virtio/vhost-vsock.h"
 #include "monitor/monitor.h"
 #include "migration/cpr.h"
-#include "migration/blocker.h"
 #include "migration/misc.h"
 
 static void vhost_vsock_get_config(VirtIODevice *vdev, uint8_t *config)
@@ -85,14 +84,46 @@ static char *vhost_vsock_cpr_name(DeviceState *dev)
 static int vhost_vsock_set_status(VirtIODevice *vdev, uint8_t status)
 {
     VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(vdev);
+    VHostVSock *vsock = VHOST_VSOCK(vdev);
     bool should_start = virtio_device_should_start(vdev, status);
     int ret;
 
+    /*
+     * During CPR, on target the full vhost_dev_init() is deferred to
+     * post_load.  Refuse to start a half-initialised device rather than
+     * issue vhost ioctls on it.
+     */
+    if (should_start && !vhost_dev_is_initialized(&vvc->vhost_dev)) {
+        error_report("vhost-vsock: refusing to start, device init incomplete");
+        return 0;
+    }
+
     if (vhost_dev_is_started(&vvc->vhost_dev) == should_start) {
         return 0;
     }
 
     if (should_start) {
+        /*
+         * vsock->owner_reset is only set in .pre_save() on CPR migration
+         * source, after a successful RESET_OWNER op.  If we end up here
+         * with this flag set - that means that either CPR migration failed,
+         * or we got 'cont' cmd from the management (e.g. cpr-transfer
+         * target died).  In either case, we need to re-acquire device
+         * ownership.
+         *
+         * On failure leave the device stopped.  The next start attempt
+         * (guest driver reset, VM stop/cont) retries.
+         */
+        if (vsock->owner_reset) {
+            ret = vhost_dev_set_owner(&vvc->vhost_dev);
+            if (ret < 0) {
+                error_report("vhost-vsock: cannot re-acquire device "
+                             "ownership: %s", strerror(-ret));
+                return 0;
+            }
+            vsock->owner_reset = false;
+        }
+
         ret = vhost_vsock_common_start(vdev);
         if (ret < 0) {
             return 0;
@@ -123,8 +154,44 @@ static uint64_t vhost_vsock_get_features(VirtIODevice *vdev,
     return vhost_vsock_common_get_features(vdev, requested_features, errp);
 }
 
+static int vhost_vsock_pre_save(void *opaque)
+{
+    VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(opaque);
+    VHostVSock *vsock = VHOST_VSOCK(opaque);
+    int ret;
+
+    ret = vhost_vsock_common_pre_save(opaque);
+    if (ret) {
+        return ret;
+    }
+
+    /*
+     * Release the device ownership now for CPR migration.  The device is
+     * already stopped at pre_save, and destination reclaims it by calling
+     * VHOST_SET_OWNER in post_load.
+     */
+    if (cpr_incoming_needed(NULL) && migration_is_running() &&
+        !vsock->owner_reset) {
+        ret = vhost_dev_reset_owner(&vvc->vhost_dev);
+        if (ret < 0) {
+            error_report("vhost-vsock: vhost_reset_owner failed: %s",
+                         strerror(-ret));
+            return ret;
+        }
+        vsock->owner_reset = true;
+    }
+
+    return 0;
+}
+
 static int vhost_vsock_post_load(void *opaque, int version_id)
 {
+    VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(opaque);
+    VirtIODevice *vdev = VIRTIO_DEVICE(opaque);
+    g_autofree char *cpr_name = vhost_vsock_cpr_name(DEVICE(opaque));
+    Error *local_err = NULL;
+    int vhostfd, ret;
+
     /*
      * Only reset vsock connections for non-CPR migration.  For CPR the
      * guest cid is unchanged, and the cid-change reset would otherwise
@@ -134,6 +201,35 @@ static int vhost_vsock_post_load(void *opaque, int version_id)
         return vhost_vsock_common_post_load(opaque, version_id);
     }
 
+    /*
+     * CPR restore case.  The source released device ownership in its
+     * pre_save.  Complete the handoff here, before the device is started
+     * at vm_start.  Init vhost device on preserved FD, issue
+     * VHOST_SET_OWNER on it, and restore the guest cid.
+     */
+    vhostfd = cpr_find_fd(cpr_name, 0);
+    if (vhostfd < 0) {
+        error_report("vhost-vsock: could not find restored vhost FD");
+        return -1;
+    }
+
+    ret = vhost_dev_init(&vvc->vhost_dev, (void *)(uintptr_t)vhostfd,
+                         VHOST_BACKEND_TYPE_KERNEL, 0, &local_err);
+    if (ret < 0) {
+        error_report_err(local_err);
+        cpr_delete_fd(cpr_name, 0);
+        return ret;
+    }
+
+    ret = vhost_vsock_set_guest_cid(vdev);
+    if (ret < 0) {
+        error_report("vhost-vsock: unable to set guest cid: %s",
+                     strerror(-ret));
+        vhost_dev_cleanup(&vvc->vhost_dev);
+        cpr_delete_fd(cpr_name, 0);
+        return ret;
+    }
+
     return 0;
 }
 
@@ -145,7 +241,7 @@ static const VMStateDescription vmstate_virtio_vhost_vsock = {
         VMSTATE_VIRTIO_DEVICE,
         VMSTATE_END_OF_LIST()
     },
-    .pre_save = vhost_vsock_common_pre_save,
+    .pre_save = vhost_vsock_pre_save,
     .post_load = vhost_vsock_post_load,
 };
 
@@ -171,37 +267,24 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    /*
-     * CPR migration of a vhost-vsock device is not supported yet: the
-     * device ownership is not handed over, so the target fails to set
-     * up its device.  Fail the migration early and gracefully instead.
-     */
-    error_setg(&vsock->migration_blocker,
-               "vhost-vsock: CPR migration is not supported");
-    if (migrate_add_blocker_modes(&vsock->migration_blocker,
-                                  BIT(MIG_MODE_CPR_TRANSFER) |
-                                  BIT(MIG_MODE_CPR_EXEC), errp) < 0) {
-        return;
-    }
-
     if (cpr_incoming) {
         /* Reuse the fd handed over from the source QEMU */
         vhostfd = cpr_find_fd(cpr_name, 0);
         if (vhostfd < 0) {
             error_setg(errp, "vhost-vsock: could not find restored vhost FD");
-            goto err_blocker;
+            return;
         }
     } else if (vsock->conf.vhostfd) {
         vhostfd = monitor_fd_param(monitor_cur(), vsock->conf.vhostfd, errp);
         if (vhostfd == -1) {
             error_prepend(errp, "vhost-vsock: unable to parse vhostfd: ");
-            goto err_blocker;
+            return;
         }
     } else {
         vhostfd = open("/dev/vhost-vsock", O_RDWR);
         if (vhostfd < 0) {
             error_setg_file_open(errp, errno, "/dev/vhost-vsock");
-            goto err_blocker;
+            return;
         }
     }
 
@@ -210,19 +293,37 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
         if (cpr_incoming) {
             cpr_delete_fd(cpr_name, 0);
         }
-        goto err_blocker;
+        return;
     }
 
     vhost_vsock_common_realize(vdev);
 
-    ret = vhost_dev_init(&vvc->vhost_dev, (void *)(uintptr_t)vhostfd,
-                         VHOST_BACKEND_TYPE_KERNEL, 0, errp);
-    if (ret < 0) {
+    if (!cpr_incoming) {
+        ret = vhost_dev_init(&vvc->vhost_dev, (void *)(uintptr_t)vhostfd,
+                             VHOST_BACKEND_TYPE_KERNEL, 0, errp);
+        if (ret < 0) {
+            /*
+             * vhostfd is closed by vhost_dev_cleanup, which is called
+             * by vhost_dev_init on initialization error.
+             */
+            goto err_virtio;
+        }
+    } else {
         /*
-         * vhostfd is closed by vhost_dev_cleanup, which is called
-         * by vhost_dev_init on initialization error.
+         * CPR restore case: only learn the backend feature set now, but
+         * defer taking ownership or touching VQs (the still-running source
+         * might be using them).  The full vhost_dev_init()/VHOST_SET_OWNER
+         * is done later in post_load.
          */
-        goto err_virtio;
+        ret = vhost_dev_init_backend(&vvc->vhost_dev,
+                                     (void *)(uintptr_t)vhostfd,
+                                     VHOST_BACKEND_TYPE_KERNEL, errp);
+        if (ret < 0) {
+            /* vhost_dev_init_backend() does not close the fd on error */
+            goto err_vhost_dev;
+        }
+
+        return;
     }
 
     ret = vhost_vsock_set_guest_cid(vdev);
@@ -232,7 +333,7 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
     }
 
     /* Register the fd for a future CPR after a fully successful realize */
-    if (!cpr_incoming && !cpr_save_fd(cpr_name, 0, vhostfd, errp)) {
+    if (!cpr_save_fd(cpr_name, 0, vhostfd, errp)) {
         goto err_vhost_dev;
     }
 
@@ -247,22 +348,18 @@ err_vhost_dev:
     }
 err_virtio:
     vhost_vsock_common_unrealize(vdev);
-err_blocker:
-    migrate_del_blocker(&vsock->migration_blocker);
 }
 
 static void vhost_vsock_device_unrealize(DeviceState *dev)
 {
     VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(dev);
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
-    VHostVSock *vsock = VHOST_VSOCK(dev);
     g_autofree char *cpr_name = vhost_vsock_cpr_name(dev);
 
     /* This will stop vhost backend if appropriate. */
     vhost_vsock_set_status(vdev, 0);
 
     cpr_delete_fd(cpr_name, 0);
-    migrate_del_blocker(&vsock->migration_blocker);
     vhost_dev_cleanup(&vvc->vhost_dev);
     vhost_vsock_common_unrealize(vdev);
 }
diff --git a/include/hw/virtio/vhost-vsock.h b/include/hw/virtio/vhost-vsock.h
index a964d57e1bc..6e1c39383ef 100644
--- a/include/hw/virtio/vhost-vsock.h
+++ b/include/hw/virtio/vhost-vsock.h
@@ -29,7 +29,7 @@ struct VHostVSock {
     /*< private >*/
     VHostVSockCommon parent;
     VHostVSockConf conf;
-    Error *migration_blocker;   /* CPR migration is not supported */
+    bool owner_reset;           /* CPR released ownership; needs re-acquire */
 
     /*< public >*/
 };

-- 
2.47.1


