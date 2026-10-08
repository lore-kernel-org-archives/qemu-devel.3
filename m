Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F371CA600B
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 10:26:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xElJo-0003Dg-Mc; Thu, 08 Oct 2026 06:25:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xElJm-0003DM-UH
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 06:25:43 -0400
Received: from mail-westeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c201::1] helo=AM0PR83CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xElJl-0000sa-AW
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 06:25:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O+tYNGVV7ivYmzJtO8YM/vjYvikbq42FOW656BpU6cV2osf/UmMqYGcy+E1cHCF4RUl1GtSs2Ru8AH0GCAzhDdBa1BRK46kYmXc9G859HIgpwoci7IOwEoze5ICBGJApMcgkGAXZcFzDeG0UKXw1pjh7mNHG9jC41So17AdCN2YuzDD0wRsW+Yld3m+6PqYZU4QPrHO6HoxfZcmp8HMtGPv6RH4Gmu19hTOrBWPd/rUE6+lD2crwh8VvAhaPLzo5Utx8wJV/N1cOVhSH79vS2BpOBTDwdrp5mhGLRIFsEgvCZdPYnManNWYT3lkRYUGuiuvNf/44cUF8M+PW4hClMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CzhhEOopcN3KOOtfWAhLZROUNYy2FrEKLzdoJ27vb+k=;
 b=a6FkcL22Lb5oZAQVAQ5IpyiqqIdfe8NWFhfUpmH7Y4dXGrEtw2rFYZ4yUIUqkdCGrSRdQbllCkaLYU7WxLbN8YMeyxfarUhpysjy2F4UxFUK43p+DzeaGG7s9GdCCO6KPW0KfBarkBh6ObdwF+tOy4dFni1WFRJtg00if2Tlrv0f0LFTbONLcZ/TGeMvFAX8Ogpp1Q+mVqQnVgFcb6Jvo2KmrCbMrAyPpt3oeCFxemkZo9u86mqx5b6Yw6UpeoFBNWsK5FpOSZcV4wYJq6mwEACvA0aKsKKvrIL1RRDewePgeYRJETq0IdDByIlQ1XL3H1/pSh2sRiTpSFEnPOneHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CzhhEOopcN3KOOtfWAhLZROUNYy2FrEKLzdoJ27vb+k=;
 b=DqyUnufsdtjj2DNW95PjInJ/9AB6CvQdRavJnUmY5AuJGS/0nmxEfII2HGiWPeB7vnd+XJutmYmZvelgRMi7SqZbR1lyVZscsIcVqQcLkpLX5rV1JOBHEsd/ej4oX5Ol/a5J7/wHvDMugZ+QAhQ50nQKe5cQF8FgNqh+qzvWE9LDgAntr4mlK8gX9aNhWfbTDU9ludhXd6HQufg8HZn1oScyqUht0vC1OY3kQCv+rN1VCbPBBg5iJpTcmcFr0YIjkMHIUSjq30a01TR7UFuadDnww2zbmLzv0SUfuEF2Xa+gj8g0GvmE5TfDYNEnEKyuS7lOy3s4SEw9CCK4SuMpng==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by PA6PR08MB10593.eurprd08.prod.outlook.com
 (2603:10a6:102:3c8::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Thu, 8 Oct
 2026 10:25:32 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0496.010; Thu, 8 Oct 2026
 10:25:32 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Thu, 08 Oct 2026 13:25:26 +0300
Subject: [PATCH v15 02/22] tests/unit: add test for duplicate keys in CPR
 FD table
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-up-vsock-vhost-v5-v15-2-301b73b3f843@virtuozzo.com>
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
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|PA6PR08MB10593:EE_
X-MS-Office365-Filtering-Correlation-Id: d8153bdc-e2ad-4ec2-6819-08df25267b70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|52116014|23010399003|1800799024|10067099003|56012099006|38350700014|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: BKO0NNygGzG3aoDwdQspyNm+MXybcuWC4hLJNq8u+zkckXDdptFH5iE3FBvhr3BjDMUecSJZbqO3Z+qhftyaW0miHrqE6FQs3mSd2spFR+b5Yd4dHTascjeaiyASm4yhiRUkry1u+hjSrh095RxBk/dDQk7z9tnCmP+CwnJBvvj/6IzBgu+1cgsHgpyWaf8536zGzqFCAxU7Q59PjTC5un7RRNbL52bL/CbAkPfZTkSnL8vpRl15V/v1Xt4pY3LhkLOKdGHlAtNoI2FQBBCKHaLkg8xIXKwqoRYRYLZidGp0hp92SHRbfzeMtyIwjRmEbOBDuDIyRFVp4x9wNQ4O/yJ736Dw0r+Wym3sEPtxT4BzfAetRj0LwPC8HbpQAenMqPCCJRvkDI3qO2v8uDclOflBR52crcL4Fr4ejb5L6QoveLz3qE0IobbTu99OknswH5GkpGGQZ/f24LDWgoxEeBSUKBK5iroiuqstS5fOvGyocpB/ejjeHPLZq2NhoIe4JiatFyDCaerwLeb0gytvZuEM7te+VKMadm7g2to5NFIAbL5ljEJfZRLXalyqeM46xjy97RNQUePme+IYlgE3Lmwux9opicr3/ZxZ73A5cJVnBOC3p7XMiKhPT3bR1iKDOOz1k3oElIwCZHUbtyojdPb+uU9mbwcVuqIIaKI3MkgFZzOjgvNTakaJF7JAcJJN3QtTUwU3xPUrdATyEWWJ/2HBFVTMp3njEcn87PPq4P8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(52116014)(23010399003)(1800799024)(10067099003)(56012099006)(38350700014)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHhCMHpQRll5VmtNeE9saEhNWUtGTDMrTjVHVE5DS2cxb3o0Q0tIaGpTdFNw?=
 =?utf-8?B?em9BN1lnNisxancyam1NWUNlbUxuMEVEWFoxZWlvUUpNOEQybnhTQ2V4djRH?=
 =?utf-8?B?WkRnNnNGSW50QkxzejQrRnZLOTdMb3k1aWtqTHNTeGlkYWplQno1MXZFYkJQ?=
 =?utf-8?B?bTk5OUh5OWNXejZtNUhQWFlsd2s0UCtodVNQNzdBTlZmSkh3L0NUSHZXNjll?=
 =?utf-8?B?M0ozRm9WOVY5VS9lUzZuUVRhZWoyN0U4ZE4ya1FOZUcyOTBUNHZtdlBYZjFq?=
 =?utf-8?B?K2oxdVhWNk1xT0xRbFQ5VEhXZzg5TmxiNEw4bnVrdzZBbC9DdHJnOGc4Z3ZZ?=
 =?utf-8?B?d2g1L2FySnlEeHdPYXhCMDFsNnhKL3lrSkR3UzREYmh3RnVCc3pOTmF5ckxa?=
 =?utf-8?B?NDRNMEtwZVBjT0o4dXBNSzUzU3ZOK0NPbXdXOXdnVEdvdHYxYVF2YW9xbjJm?=
 =?utf-8?B?QSsyQ0N6RnAzZi9KbkllWi9kSU03djgyYkUzTGJTaXFOZWl3VndDV0Q5Wlht?=
 =?utf-8?B?NHk2OUxiNFZXdHBqY1RxY0dXc3hSMDNKRVhQMGRDVzJva2pPOVZYeUxDbTZy?=
 =?utf-8?B?OXVhMXgwYngyZms4cXhqV1JTZUN0cFFyMEVBdSs5Q3Z0TVc0N1lhb29yN0N0?=
 =?utf-8?B?cHM4YmR5WnMwYlNWdGFrNkFJTFBOeFU2c1VZSW1mZy9BeWIxN0crUTduWE95?=
 =?utf-8?B?UUc2MXNhZmRVL3JDYWhrUzkvRm9kaFFKOWNDdlJkMXBWMVZncEtSaEx2ZkFY?=
 =?utf-8?B?N08xSWxEaXpPZDlvVmdPT25pVWx6ejlQZlNhRklPRUMvTmlUTVY0N2VTRko5?=
 =?utf-8?B?dStiRVpjOHFMazdFa0k5cWRrRllGTzNwQUFuZExSK251Q0hHanpsRURxRnZO?=
 =?utf-8?B?RjZWMEFxNXIvV3F0MkppVkVUMjFTcXpKMEZvak84UnREenRpZWpXV2hObFBF?=
 =?utf-8?B?TXNpRFcwREZDUWd5a2VDZ0hkbE5VYkhnMnduVTZLSWVrZzNYdk4yQlNoci9h?=
 =?utf-8?B?YTdPT1lkNU9OTUZuNzVlRllFeXdLSmkzUzk3bDZXY1J6eHI1K3A4MGNoNUs1?=
 =?utf-8?B?Y3Q4TlVNeXdZcG5VMkFBaTd2a3pvN2o1S3hibkVVckRhUmNVeHdJRFJUdUlI?=
 =?utf-8?B?b0d3ZGNUejh6OHp6K2JVL0JBQXNlR0NsaTVUSXNVN0E0dktmQXJMbmRkdVdi?=
 =?utf-8?B?UW1iZ3FNSmJRSnlHa3NJeGVUSVkwNFp2ZklMMnlrOHk4R3l4SFFTUDRZTEww?=
 =?utf-8?B?Z3ZNQURKSzNtV3QzMkhYcC9VdE5wdFNsbFhNVTBuT0JYUDBmQ3dieHpVVEwx?=
 =?utf-8?B?K1JkbFJERmZJTlhPZExSTmRMMXJsU1Z2b0w0QW96SnVMdnA1S3U0NnRhRGxz?=
 =?utf-8?B?RUZSbHpLZUpIM1IvdFA5QlltRmVyRmlxSHJsbUhRdk9XdzBkdWZFUmZTb0x0?=
 =?utf-8?B?ZGJLYzhDbUJLTnNqZS9LOHJFMW13NmtFMzlaWUVMWmJ4WStVSmVFbnEwekRZ?=
 =?utf-8?B?SG1yeXJ4Y2hhdGh0TG1lZlV1a2t2eHBNbkZyOHhLUU9hZzI1N0FsZ1RScEJu?=
 =?utf-8?B?ZldMc0VjOWh3ZHFBOWxrZ0pWdm0zV0J5UytCUDQvMmxrVDhqWlMydy8vYlVI?=
 =?utf-8?B?d1pYVDV2SS9PNkJRNVBtWXdKeHN3ZUd6T3MwOVMvWEs2YWk2dVpiKzZ3MEI1?=
 =?utf-8?B?RWVUV2RwbktLRk8xSnhXTTd4c1p3cTlrYldHYUxkTlUwSTNQcU5lNERmeisz?=
 =?utf-8?B?cnBEQ0FpVGVxU3N4YWpFT1E2Q0tJcjlwdWVSUGwzd29JZXNTL0djS3NGTUd4?=
 =?utf-8?B?bUh0Wkp3RWZOTmxYVGdwYm04M3FKU2p5V3MxcXV2TVNHVjNQc0ovNVd6bjhq?=
 =?utf-8?B?TkxITzZNQ0pSYXpDMlhabnZiUWlFOWZrUjh2bWhhQUNVa3dpWk1zcVBJSDBI?=
 =?utf-8?B?SXBEbkRrZ09CcHdSYXNhdjNrZ210eFpMMzFPRW40Szg3RHlUK1NFbyt1N1NG?=
 =?utf-8?B?akZiT3JMOU5iWk1GMjU2NmFETUhqdTdNMFdWVU9XaTRsT3NUVWpvbkg4MHdu?=
 =?utf-8?B?SWNKeTU5ZzdEaFFWbkVtcW5jUDM0dm1KbDNGWmZUL0UzODlvOVdvcHZlWkkw?=
 =?utf-8?B?WDZTY2puQ1laTTBBamZBZ3VvQlZpdmQwaG1mN09Tc241TTRKeWpVaUJodS9v?=
 =?utf-8?B?N3hrZXlVWHlXZUROQkVrWVMwd3czeFA2MEo5ZTRzdzU0SU1HVGtIK3dzWTk3?=
 =?utf-8?B?Skk5VjRyME5CWm4rNm0wdzBlOEZNVDdLWjBTRnRTM0ZuazhKbG1qZzZ6ODM2?=
 =?utf-8?B?SkVRdEh6V2tBcFM1c1lpeFA0Y1NldHV0WTcwcloyQ0VEbWpVVzVZT3U1Y1FV?=
 =?utf-8?Q?3iGNfyBUT/oAXFX8=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8153bdc-e2ad-4ec2-6819-08df25267b70
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 10:25:32.2913 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jh6SzxHrpsiHSPwRC8UfeHosEXMdw28XZpPUGFsY+Rj0qVQSo1VKWeV/3dKkv70zCz6RVrbn2T8jHCaAMXK9IIuBf/6mYhG49Nm5nVxqrn8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR08MB10593
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

cpr_save_fd() now refuses to register an FD under a (name, id) key which
is already taken.  Add a test which checks that 2nd registration fails
with an error while the 1st one is left intact, that different names
or ids don't clash, and that the key can be reused once deleted.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 tests/unit/meson.build |  1 +
 tests/unit/test-cpr.c  | 98 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 99 insertions(+)

diff --git a/tests/unit/meson.build b/tests/unit/meson.build
index d17435c1877..5d2b413fcab 100644
--- a/tests/unit/meson.build
+++ b/tests/unit/meson.build
@@ -140,6 +140,7 @@ if have_system
     'test-bufferiszero': [],
     'test-smp-parse': [qom, meson.project_source_root() / 'hw/core/machine-smp.c'],
     'test-vmstate': [migration, io],
+    'test-cpr': [migration, io, meson.project_source_root() / 'migration/cpr.c'],
     'test-yank': ['socket-helpers.c', qom, io, chardev],
     'test-ram-discard-manager': [
       'test-ram-discard-manager.c',
diff --git a/tests/unit/test-cpr.c b/tests/unit/test-cpr.c
new file mode 100644
index 00000000000..dfc6b1f2ec0
--- /dev/null
+++ b/tests/unit/test-cpr.c
@@ -0,0 +1,98 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Unit tests for the CPR fd table
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "migration/cpr.h"
+#include "migration/vmstate.h"
+#include "monitor/monitor.h"
+#include "hw/vfio/vfio-cpr.h"
+
+/* Stubs for the parts of migration/cpr.c that these tests don't exercise */
+
+const VMStateDescription vmstate_cpr_vfio_devices = {
+    .name = "cpr vfio devices",
+    .fields = (const VMStateField[]) {
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+QEMUFile *cpr_transfer_output(MigrationChannel *channel, Error **errp)
+{
+    g_assert_not_reached();
+}
+
+QEMUFile *cpr_transfer_input(MigrationChannel *channel, Error **errp)
+{
+    g_assert_not_reached();
+}
+
+QEMUFile *cpr_exec_output(Error **errp)
+{
+    g_assert_not_reached();
+}
+
+QEMUFile *cpr_exec_input(Error **errp)
+{
+    g_assert_not_reached();
+}
+
+bool cpr_exec_persist_state(QEMUFile *f, Error **errp)
+{
+    g_assert_not_reached();
+}
+
+bool cpr_exec_has_state(void)
+{
+    return false;
+}
+
+void cpr_exec_unpreserve_fds(void)
+{
+}
+
+int monitor_fd_param(Monitor *mon, const char *fdname, Error **errp)
+{
+    g_assert_not_reached();
+}
+
+static void test_cpr_fd_duplicate(void)
+{
+    Error *err = NULL;
+
+    g_assert_true(cpr_save_fd("dup", 0, 10, &error_abort));
+
+    /* A second registration of the same (name, id) key must be refused */
+    g_assert_false(cpr_save_fd("dup", 0, 11, &err));
+    g_assert_nonnull(err);
+    g_assert_nonnull(strstr(error_get_pretty(err), "already registered"));
+    error_free(err);
+
+    /* and the first registration must be left intact */
+    g_assert_cmpint(cpr_find_fd("dup", 0), ==, 10);
+
+    /* A different id or name is a different key */
+    g_assert_true(cpr_save_fd("dup", 1, 12, &error_abort));
+    g_assert_true(cpr_save_fd("other", 0, 13, &error_abort));
+    g_assert_cmpint(cpr_find_fd("dup", 1), ==, 12);
+    g_assert_cmpint(cpr_find_fd("other", 0), ==, 13);
+
+    /* Once deleted, the key can be registered again */
+    cpr_delete_fd("dup", 0);
+    g_assert_cmpint(cpr_find_fd("dup", 0), ==, -1);
+    g_assert_true(cpr_save_fd("dup", 0, 14, &error_abort));
+    g_assert_cmpint(cpr_find_fd("dup", 0), ==, 14);
+
+    cpr_delete_fd("dup", 0);
+    cpr_delete_fd("dup", 1);
+    cpr_delete_fd("other", 0);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+    g_test_add_func("/cpr/fd/duplicate", test_cpr_fd_duplicate);
+    return g_test_run();
+}

-- 
2.47.1


