Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C254CA600B
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 10:27:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xElKY-0003XX-Kh; Thu, 08 Oct 2026 06:26:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xElK8-0003JB-M7
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 06:26:05 -0400
Received: from mail-francecentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20a::7] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xElK6-00014o-V2
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 06:26:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u7HKzE96mP2q57xSK2APij+ATmD8YCy9ozBdiPAVoT5+MN0W0/WkSRczPTbqjIIbzJgee8l38e+sPERikG71wagnD+ZeMebmWGGLMQMWjdGAVSckNm8VGUGia2nWQiajCrXn2e3fVU2nsG8ytxKgJq6wgSS6yWcrv4TkG6Iq63w744LV5kAnxH38a6UxkeoTmb/e7gJvUbrv91uCPite4Z/sfAwAVTwibgcLAUox1iqyWqt+IQvpIRav8YG8XIE6RNc8FHggGkA0GBQWJ8VxeCXhClvOIxurP61JCScQuMrel0whtfNMltwQtSsEaWhFYl6kJClbZqr17D8u9kX3lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DkWSP5iHeNPooTfaQGFctO+s+RsJwS6RPzOYySingVo=;
 b=hnZY7Bw8OTlHM2nRuOM98RRiBLElxa3QUQUXF3d2OUbvEuDXIvxoxgFV/U/gm+ofjoxZMdGnSMMT1T9y0Bihd49b6a/iv0TWOo5u2q2o1wc1V1koXlGKDGpFBh+jqMvWEiDMmdPqqraIcvoBZefQfCAc1tNOIQS5UJ3PPFOzqjMSKjSpltdFl2XM/mt4RG3OKyF3SxlRPGWuSGD308TbC20UJ5B6/9sy4cQRipM0S1yQ0cywZQjecXJ/MfGnAgOnyae3H9lXCgk9UhpY2klV7rQH+Omh3YQYnEAf5GrhsnlgMO1vZgDcI91tSBY+n6jOUTNWScFITMdKWmkEjU7A7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DkWSP5iHeNPooTfaQGFctO+s+RsJwS6RPzOYySingVo=;
 b=Y01s6bvFnjuxAIHIeM8JNcaBZpRn0gydZDPA4bIGMbDQefQaceWe8mKvitYgEU1d6LRn1A9fFK30l2Orfv0ob98XafSANtkDzaDu6lAlAEPsEa0pYO7JqTUusvPW1wStoC1l0Xz/j9YMX1g3uGd6X54mFeiORdtucRuOtGEBw6tEA8YOzzNjLzxzQ0W8TzSl0eUM4R8V7M0S11t/wFSG2Zj8WTxpX9cjx0MkOQ7GU6AuNtNB6xi3vUJ7MIJnKovzz0a+XN3lSeDd5OT7W3vlG84cpQas30oiVdyphDLEP5H2/Lqz4koHvwKZhxhKEPEq+UdBdtjndbnp5pj1zinZug==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AS8PR08MB10270.eurprd08.prod.outlook.com
 (2603:10a6:20b:637::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.14; Thu, 8 Oct
 2026 10:25:48 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0496.010; Thu, 8 Oct 2026
 10:25:48 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Thu, 08 Oct 2026 13:25:41 +0300
Subject: [PATCH v15 17/22] vhost: release ownership when the incoming
 migration fails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-up-vsock-vhost-v5-v15-17-301b73b3f843@virtuozzo.com>
References: <20261008-up-vsock-vhost-v5-v15-0-301b73b3f843@virtuozzo.com>
In-Reply-To: <20261008-up-vsock-vhost-v5-v15-0-301b73b3f843@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: andrey.drobyshev@virtuozzo.com, sgarzare@redhat.com, bchaney@akamai.com, 
 den@openvz.org, farosas@suse.de, mark.kanda@oracle.com, 
 maciej.szmigiero@oracle.com, dongli.zhang@oracle.com, dwmw2@infradead.org, 
 peterx@redhat.com, philmd@oss.qualcomm.com, vsementsov@yandex-team.ru, 
 odaki@rsg.ci.i.u-tokyo.ac.jp, clg@redhat.com, mst@redhat.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VI1PR10CA0117.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::46) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AS8PR08MB10270:EE_
X-MS-Office365-Filtering-Correlation-Id: 8923e785-8276-4a46-3cff-08df25268368
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|7416014|52116014|10067099003|56012099006|22082099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info: FdE3PVNz9rqrhAKZ7+NDjTWQxefu3X4dXZ4jmMt98agGPlgvTkezU5VPPfDes/cZa8qQoN15aliPee6H29lLlszRVYBcxg5229wPnu26l/6bSC4hJxYkF+XvCKcsHPjAta/hELTNKltEX2MRjGymJMwgvLQ8Ho/I/hRYcwKxikwPhofb4rFJ3puuSgtcyYYntHZhJ9B5GYlRcaXL9XvTxB7HLt5zI9/Le1/Q9H7pw4GDsR6Yxh99UFVrrSP6f0iWDTSN62dbi5C8tS5cOCjgnDPQyiAkQ6CyVGLkPdeBVnjIzhhvq24+aEPmJ8EYu0hIrnJIJRFSG3vyzBOmYubPwzBJkc/CIFHvh/OcN0axv+1uw7Q99JHL+VG0a/pRDOkh+yrZR1jYZhVf1P3FIdtiAeQoZRs/ZACN5ZtfqfYFSeFmn3W/Im6tx4cK4EJODpSIcg/sIFcJuASBXt6NXhsGj0IwsmWG8YEyb1BM8XSjOpCc287GUZzJCjqprF6zudchpi4/ieTZZIqJsieRvpZSen24nCTi2M4oaJfCsLA6AevMoN4zXpA11KGPZcZzUBqG97gIk6nfvbF01XpfmqSy2NANtJrw/mJzSx4yKYdU+GRgaLJD7iMoXCZ+EmZU1pRwEg0iO3ozysg/2zbmb/0lBaZ/nc8FZXY6Pzea6O2ngot+qQgaiJH7ovpYPZgIaryRwCAGsokml0zkoeyneJJw0FSnI+SmD9J0iYFaVeD9tso=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(52116014)(10067099003)(56012099006)(22082099003)(18002099003)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WC9xMVIzbUpjQ3NFS3RpZHA3WmNudG8vQjM5YmN6TGtxUlRmRzdPdUhMM1Zp?=
 =?utf-8?B?aUVkTksvK0xjRGs5R2hnUVFXQ3h5QWVCRXRkbldjVkdRYkVoVDFDNFJ6UWFj?=
 =?utf-8?B?bkhCdzBRV2laSFd4RHVURS82U0hwcmtlZkgwdlQ3bS9Qbjg2RjMveDF6T1N1?=
 =?utf-8?B?cEJzTTh5cmMrQ2Y4Y2tvcEJ4TFFiM0JFVkhXVUtTRCttV0lYMFhodjJUZjlW?=
 =?utf-8?B?SVltbkNIb1hsbitzNFRnS1NKcUhNbEhxc1k0UmVPYnF3cEdCRWNhak1XVXJu?=
 =?utf-8?B?NXNGR3EybVN0OFhJV21ncG5EbStKNE5wZ1pnT0dVU1FOZEJ1SVJubXd6OFIr?=
 =?utf-8?B?d3VPSDEwSk02UXQvRVVlZnhvM0crRE9yNDcvbTF0U2g0Ulpsc2dOTm5yZ1Rw?=
 =?utf-8?B?bTYwOW0wdDdEdGFVdXdGdnFBbkYwVElEZk1RTGwvRG9PMEZSQ3VRZ1NsaDEy?=
 =?utf-8?B?VkNwUWdQTS8xMDQvZ21VK1V3cTNCNm9vUVVsNmFvNUVoUTJoR3Q5dDlqUXdE?=
 =?utf-8?B?N1ZIc2JnWnR6SjVrakN0T1JxUWNXMW9XOW5wQzdhM1dxZkpnUHh0M2ZEanhO?=
 =?utf-8?B?M0RNQTB4NXVXVGpNK1h1T2F0QnRMWjdaMGZWUk52eGRReFloRGZvZFc0Uk5H?=
 =?utf-8?B?dFpobG4zY3lUVHUwVTdhb3JTNXl2L3hHRmlvL2w0YUIwelNiTVpkVjF6SWw1?=
 =?utf-8?B?VXNwRG9VckFMYTJ1M2ROVWRKdmZ3VU1adlpmb2t2RldEK1FKUmhRSWVBb0xY?=
 =?utf-8?B?Qkh0WWVReXhYY2Z3eStWK1hPTzNqeVZ5ajVhOGZWNTJmY3hkeGwwakdFK2Q3?=
 =?utf-8?B?dC9abVdJRzZ4L0dGNlMwYlRBcXhhdTBHbEs4M3A2aDlZNzlBMWdJYlFQVnU3?=
 =?utf-8?B?Umt6NG1RS0NPUlNlb0wzeU5OTmxpTXJDejZNcWlZYWJtYjBuM09oTVQ0bjZj?=
 =?utf-8?B?VFUvRUxTMjk3V1BJTFdKYnYrMytCWW56amxWcndiYnltdDV4WVhoRG9qc0xU?=
 =?utf-8?B?Ymc2MGpvMWw3K296YWZLYjRZLzRCSmNqZFVPU2R1aE5Cci9BYndHMFZ2dC9M?=
 =?utf-8?B?NnpqTE1UWEdGc2Y1UmFvWkV1LzZDcVBqSUt5QXVLSU56Nmk5Z2t6SWsyYmxU?=
 =?utf-8?B?U0xJZDUwclpIQnU4OUp5YkFHTE9BK2IwZU9LQUlhRU5PU1lKWk42aGdqbUNq?=
 =?utf-8?B?T1pqendHZGlVKzdQWkgzVTZYRERvMUIvS0pjaUt6T3h6SHptZU5Ec0tkMlIw?=
 =?utf-8?B?RFRDdnllWVVQdnpVTUNucXhUKzJ0NE1JbEpnNmdwbCtwaU9MY2hpcFJGQ2Q0?=
 =?utf-8?B?T1RWKzIzRWU1VXU5K0psVlUxM1V1OEFEMUtwUEhnSWVWRUVmNTZySUl4Mi9l?=
 =?utf-8?B?cDhkL3Q2THdKbVUyaWVRekNPdmVkd0hhM0FlVm5pMCtYOE90U25SRWFPenBW?=
 =?utf-8?B?SDl5dU5VaGxMSkNQaEJweUw4ZXVOdHBrOGZQdnVrdlZVRkxna3hyTitHMzM5?=
 =?utf-8?B?UmY0d1RpbHl0YnJOaXpublZCUjNzZDVJeGl0RmwxcjNIL0FmdlZjeWxhbHFu?=
 =?utf-8?B?YVpnTUdHdzVpWWhPbnN0a0swUWgrcVJ6NWxhZmp6SCtwWExhWERyQm84NjlF?=
 =?utf-8?B?L1l4TFNKUkwvNDlRbVpPWVZHZ0RnZy9MQ0t2Wm9ORDdKTEM4ZnB4L0l4WXNY?=
 =?utf-8?B?ZjFwaUtVeCt0ZFZVK1FSa1J2WVZPeTlLelVET2g3czJQSjNDS2NPTmEyNnJI?=
 =?utf-8?B?dUpwVzRmRzlLK1VmOXh4cENMZ0pkbFBlTWFndDdIVGgxK1VYRmI5MkJzSXdK?=
 =?utf-8?B?VHVkeVJycTBnQ2gwSWVKUWtOaDlCVWhjRnZmRWZVZUZheXhUaGllU2oybVlT?=
 =?utf-8?B?YWcwSUJDNyttZk1zd044WThzREx3bXhiNTRXVE1pd3dYTXNnN0JMNnlHRWZm?=
 =?utf-8?B?MjBrR3dtRktNYjZsYlFGR0F2c3lNQ0krY1hkL0lsVzkrZGVjWDF3VnU5SHgx?=
 =?utf-8?B?R3pvQ0N2c0Z3QjZyc2xxWlFwVUxiZUJsQTBYWVlUL2djTTluQUxUd3IxMEJi?=
 =?utf-8?B?Y25HTDYwd3NyTGk4L29JZllhSXRVMEZyZU90MXR1M1FpaDYyUEJXZytGZmRv?=
 =?utf-8?B?NXc0dXA0UFd1cXRZeTRqZkFFWWRWdDFtTEFabVp4a0Q1U3ZnQTZGNUZScVBG?=
 =?utf-8?B?V0ozYzFpcGlSZ3NoLytsenJVZ3VCWEoyRVN2S2FUbjJITUZ1YzdvRmhBRnpk?=
 =?utf-8?B?NkdETG1UbmJBR0hHZ0kxUXgvU3BDZXc4TzZ0Q0JtWVZsTG1RTU02eDAxOWdt?=
 =?utf-8?B?R1BHakcrcXpjU3JHa0hmWkJFNmMyZjhJUVI5NnFwaEpHVDM3dVNTYUFpUFVT?=
 =?utf-8?Q?dV/hCKiEnZLvnfuI=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8923e785-8276-4a46-3cff-08df25268368
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 10:25:45.8262 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kB9+hWOkhY7YMwMR/ypvh0y3T2nWlWeYcGsgdI8rZFkd9WZsJLXAzYS4mx7KRRKVoAE/KVX1TTxLkCptJv0LnYUY8WaUY4xm3ZR+fce3Ldc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB10270
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

A CPR target that has taken the device ownership in post_load() doesn't
always reach vhost_dev_cleanup(): a subsequent load error, e.g. a
truncated migration stream footer, makes QEMU exit() right away, and the
ownership stays with the dead process.  The source still holds the FD,
so the kernel never releases the device, and the source can't take it
back after being resumed -> SET_OWNER fails with EBUSY.

Releasing the ownership at exit isn't enough either: with the
return-path capability the target reports the failure to the source
before exiting, and the source resumes right away, racing with the
target's exit for the ownership.  And with exit-on-error=false the
target doesn't exit at all.

Add a migration notifier to each vhost_dev, registered for its lifetime
for the CPR modes, that releases the ownership if still held on
MIG_EVENT_INCOMING_FAILED.  It runs before the failure is published in
any way.

Reported-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 hw/virtio/vhost.c         | 23 +++++++++++++++++++++++
 include/hw/virtio/vhost.h |  6 ++++++
 2 files changed, 29 insertions(+)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 8fd0af42a0a..4310e1b43f5 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -26,6 +26,7 @@
 #include "hw/virtio/vhost-user.h"
 #include "hw/mem/memory-device.h"
 #include "migration/blocker.h"
+#include "migration/misc.h"
 #include "migration/qemu-file-types.h"
 #include "system/dma.h"
 #include "system/memory.h"
@@ -72,6 +73,23 @@ static void vhost_dev_try_release_owner(struct vhost_dev *hdev,
     }
 }
 
+/*
+ * A CPR target takes the device ownership in post_load().  If the load
+ * fails afterwards, release it before the source learns about the failure
+ * and resumes, so that the source can take the device back.
+ */
+static int vhost_migration_notify(NotifierWithReturn *notifier,
+                                  MigrationEvent *e, Error **errp)
+{
+    struct vhost_dev *hdev = container_of(notifier, struct vhost_dev,
+                                          migration_notifier);
+
+    if (e->type == MIG_EVENT_INCOMING_FAILED) {
+        vhost_dev_try_release_owner(hdev, "incoming migration failure");
+    }
+    return 0;
+}
+
 unsigned int vhost_get_max_memslots(void)
 {
     unsigned int max = UINT_MAX;
@@ -1842,6 +1860,10 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
     hdev->log_enabled = false;
     hdev->started = false;
     memory_listener_register(&hdev->memory_listener, &address_space_memory);
+    migration_add_notifier_modes(&hdev->migration_notifier,
+                                 vhost_migration_notify,
+                                 BIT(MIG_MODE_CPR_TRANSFER) |
+                                 BIT(MIG_MODE_CPR_EXEC));
     QLIST_INSERT_HEAD(&vhost_devices, hdev, entry);
 
     /*
@@ -1891,6 +1913,7 @@ void vhost_dev_cleanup(struct vhost_dev *hdev)
         memory_listener_unregister(&hdev->memory_listener);
         QLIST_REMOVE(hdev, entry);
     }
+    migration_remove_notifier(&hdev->migration_notifier);
     migrate_del_blocker(&hdev->migration_blocker);
     g_free(hdev->mem);
     g_free(hdev->mem_sections);
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index f6e32b59ab2..14484b8de24 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -3,6 +3,7 @@
 
 #include "net/vhost_net.h"
 #include "hw/virtio/vhost-backend.h"
+#include "qemu/notify.h"
 #include "hw/virtio/virtio.h"
 #include "system/memory.h"
 
@@ -116,6 +117,11 @@ struct vhost_dev {
      * Updated only by vhost_dev_set_owner()/vhost_dev_reset_owner()
      */
     bool owner;
+    /*
+     * @migration_notifier: releases the ownership when an incoming
+     * migration fails, vhost_migration_notify()
+     */
+    NotifierWithReturn migration_notifier;
     bool log_enabled;
     uint64_t log_size;
     Error *migration_blocker;

-- 
2.47.1


