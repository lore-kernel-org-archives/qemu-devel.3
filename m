Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64FD6CA6007
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:32:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENwi-0005AR-IQ; Wed, 07 Oct 2026 05:28:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xENCF-0001H4-VX
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 04:40:28 -0400
Received: from mail-francesouthazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c207::3] helo=MRWPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xENC7-0006j4-W0
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 04:40:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=byZFujmhjJc9oOqXqecjUrFdUt9s2M0hoJZuQxKHQaTInZjiSCQ1U5kDM+86iT7M4m+kbntM5vrBR7Tj+Nnl7pt7G0E5yEiYw9JZTxmprUUKr342wqu4Uu1w5hZK7fI6UjnhcGPtN8zyssfPs7huM8xnhxEwSCxS2it1tkYuko/UuzfHlBKxdyoLJCXvUpIzXHRBSZLAUjszuE91iM71b/s9d3OAXYI+diKCH+xgoOVP/TdzpPVOxmaP/YTSzfMRa1Oyv1qzC0nA2B86CjzI34yyKyQ35oqLv206+rLgx9Qc7HB7O8YtkTthunXInrhjUBMpvvojFHL7cGxfe9EgKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CzhhEOopcN3KOOtfWAhLZROUNYy2FrEKLzdoJ27vb+k=;
 b=hOR3T3ZgY4ss817aTt8k2mgRjvz2RzIth/rGKjTIB6kkM/jP/gMB98kax+gJAIAEkwKqdh7/kaQiJGIJoYTjTW+5frdB5VuBHRpxTV8fYr3+3rc1bYyJ7RFqTxVZurLKXUd01+79vHxlrlFwi9X4fv4TI5JqvkdsJbxL9LGr5JIUtMSfBNJ88aVsSUG/uFXbviNDaoQnAoY8i5M8Zv7Na09k/4q+XQK2DbjfD7/8fzkxUbfhODy3Gx6LIbPQWjF6QiS9V4G4O5AhSvTc80oy+oivntj1Rssaza2wZyk20Atgd7OuZi/6xly+BfhSss7d4dyb/2BrTfaqQG2S31gE2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CzhhEOopcN3KOOtfWAhLZROUNYy2FrEKLzdoJ27vb+k=;
 b=WKSOgwFdfhufkZWG1sLwyzIPvS4UJTIebk8hdwy2inlXK1sOjaEV+UZC7I0lIyQL/eD0fr9/QdzGCvYzgwwinMce/sPP72Kwpyst1uu7vzcGlRtW+nfsgCL32H1FRGodm8NHEXOZw3WHY9v5y7V5+QcpWEZS4KnvuxfIB5HQHGKER7xQd2D3276+ePS3Jq983x4FmfH8IU7FydMW6HpbbeNQsjERrh5A0gK0Lmmb/Ynsg3XtHMuCambsV4Ggi1VpNwJV5ziikBEocA3+7vTt9nnhMY3MLwD1UjfQkC3bTzyEHJlZK6kzwXaX9d1hNJ40jOQEgR5s/VM7MqJP8hVkRg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AM9PR08MB6292.eurprd08.prod.outlook.com
 (2603:10a6:20b:2d8::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 08:39:59 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0496.010; Wed, 7 Oct 2026
 08:39:59 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Wed, 07 Oct 2026 11:39:55 +0300
Subject: [PATCH v14 02/22] tests/unit: add test for duplicate keys in CPR
 FD table
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261007-up-vsock-vhost-v5-v14-2-e16de9962df0@virtuozzo.com>
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
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AM9PR08MB6292:EE_
X-MS-Office365-Filtering-Correlation-Id: ad35e31e-5325-4283-4213-08df244e9200
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|7416014|52116014|1800799024|23010399003|38350700014|56012099006|22082099003|10067099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: NxYblAzVW6WbVHglei+BR3TliX5E019GubldXVKhULSFllBKq/cA59hx6ZITwBm6ZfBQhRTjVlOLURcwIbg4SQuNIrVBcIfSY3ikdFeU94yoQy3zAlIWD8oSLzbRZ09DL3KMmyveZkcaYyxKbEQB1xWJp9m4XlqEbODtNz1mjpyJfpzzZ8Yp4uGO9X1zd9aZV+8g87MhMQ3JpWcPlugG9wt99xJRTbGvh13hU0GEuh4rle5ZQ4ITfzDA3mAtFx4Ikmsy1AvJNlBZFp/ujeDYTdg+EGCzIlOCXU5IhwGLqFuCi8irPclYEzHoZGN7pbM/Ekx3F8NVUuKuSdGuNzbUzkt8AVg1B//VtN+d4va5nrmYUjTSRuJl4TMNEMisgrXCJcpqZRcC74JdPsmsMyL1EWY/y3K99elj7nmbQXN5XYF7FTBF9Zb0Odzhg//kibTJKIn7MT9i+KPmzl0ceJyf9TEgB5wdF6u/aKt2zJiW6OapfaVHmcAdTD7/VZw1n9FmewXkWm9sSBOAkdSJSdLFkWUKHC7QigZGo9VXrdyEIAQzixsaX1uOxkLj6y2gseF5w2/ko5n8OVVWtRwbo1DKAfqD3w6MVGX/7QuMxvCT/Tx5dD4/Jtupl8xCX4LjNNO/awrQ0qbX0RTvUkD/vRIjUEozM7CaBiUZ/w4a32s754y7LCCtKTFaqIPALJK5hxWszfggv5nsb7e1jN3uGVe7VkiXVfB7Fy2g2f+wzkHvcLI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(7416014)(52116014)(1800799024)(23010399003)(38350700014)(56012099006)(22082099003)(10067099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TENncUh0cE1oQmJ5a2JNQlIvMCtHbkZEVFd1RTd1Wk4yckZOYTNDOEdGb0RN?=
 =?utf-8?B?WEFNZFZiVHJSK3d4UDdCc29sSFN0RHZZOEUyN25oZGx2UlhSc2ViQWRjVUc0?=
 =?utf-8?B?aUpWNElkMmdDYndtcUVZTTc4UmhhMmpkZitwT29hYnV5bDJQMkMwcGRCSFp0?=
 =?utf-8?B?RFc5WWdwZjNvRnJFS1dkSjc3Y2dyVWVaSzAzK0xQWVdjeUM4THFRNUdFM2tY?=
 =?utf-8?B?U3hoemQvaXkzL0JaY2NIenVEV1dZK01ZRk9FclNJNVArOWxtYW8vbDhwV3U1?=
 =?utf-8?B?ZTU0eDd2S0ZYUUh2YVFJaXgxbXk1N2R4RzB3eG9GOWUxNUZOOTdRQTJPd2dD?=
 =?utf-8?B?NG9MSGx0ZG44V01TR3A1cDhkN2NtSSs5VVJQQTFqSnhKY0xSNklnVXRPeTg1?=
 =?utf-8?B?T3ZyOXhET3RocVZUbVEyUHdJWjI0YTBkZlNyS3loOFJRSThVWHVQWDNKbkhK?=
 =?utf-8?B?dUppSTNnbVZzT0hvdXkvRWs2Tlh4OVJPUWt1WlVJekRWclhxKzgwVWVwV0xQ?=
 =?utf-8?B?dWpod3RYaGxwYktsd1UwVG5YTUxxdHlqYmJLTjBjMGVnL3RVakl0WW9rUVlR?=
 =?utf-8?B?dCs0WXZiQmJEMWRybncwSWxOVmlNSnpkYXAzNWs4S3FvTUdTVFVoR2xUK011?=
 =?utf-8?B?NUhhOXBXVGNhcy81blRzUEdhb3h2QnpmUWxqRGY2R1pwWXQwQVZWbGpFRkVO?=
 =?utf-8?B?TFBnZGJ3ekRhVFEzMTFwcWxKN2N4T2ROdkpLemJ6Wi9VMkhJYWV4RXVnczdJ?=
 =?utf-8?B?bXNSWVlSTUNCZHdJYmR3WXFKSEpVSVpZVDJiYmI3LzluNEV4bXJUb2ZCaExt?=
 =?utf-8?B?T0FhSDQwYjNhUkFYWmdVUlJhcjkvbzF6dVVob3FPYkZaVythNU8vTDRDQitF?=
 =?utf-8?B?VUZTWFh5Q25Gdnc0dHN6Y0Z2MHo0SlZkOTk1WWg5eE5JZzhNMy91bENtNjdt?=
 =?utf-8?B?OEY1emlFT1U2WDRGU0sxaWsrWG84cWcxL2FURnZJeDFvWWJOTUIzR293V1ZW?=
 =?utf-8?B?VitlQmVPREZXcWxacU1QR3pmbUh4T0FOK2x3YjU1ZUl2RjVRdE50dFFUUzZh?=
 =?utf-8?B?Y0VGUDNqOVIydmNBanpUWUhYa3d5bDhKV0QyKytXNWJ2V24rYytKZUNMWnVW?=
 =?utf-8?B?Q0dOSG1ha3RtYmNxUWlVaFJzZDZaSlptTzZDN2lKaG1SeDIyVGRyRTYyK2VB?=
 =?utf-8?B?SlZ0R3d1LzY1NEsxRkM2SXlIditnUDdVMXhxMFVDcXRQVUp3c0RhWWR1eG1B?=
 =?utf-8?B?Z1E5KzVHUUs1RlJpcGZRV3BwRW1LMVNaOFRaNzFma1BxUS9vTlJjWGFZMUdx?=
 =?utf-8?B?NzEvd1N5bzNyRHoybW1vREpBanZ0cC8vNlNCMGhVQWRHVFk0cjVLdzgwVWUy?=
 =?utf-8?B?WXhETENsVEhIMmtIOHJJdk9jTUJSeU5ieFg1RWozdFVYREZNZ1ZXdTMrMlVY?=
 =?utf-8?B?MzBvTTZNa2pLTTNuNVhMYlNEMk5XR1dHT0NJRHRSZmxtNmN2U2dUUjR2NWdW?=
 =?utf-8?B?V3ptcmR0ODVKSjBoQ3NNNExGVkJCQ0hONUM5NzcvckExclZML3krVFo5MVI4?=
 =?utf-8?B?T2lKM0hUem1OWXFYKzBTVHlKMW5ISGp6UFNjVlN6dWtZZnJzVEJEZHZmd3Nz?=
 =?utf-8?B?TEo2elhNTVRSM1RJTUl0SjNlRXNEYWJueVJwaXVKZkZHcTZIQzVCVnVMYW9s?=
 =?utf-8?B?cGg3ck51M1ptbUkvS2dycm5NSEhLZCtCMkpiT0haZHF5aGlKYlUweXVRb1RD?=
 =?utf-8?B?OUxNUzJBTElWTUIyQXFLU0FDcWhOR2dlaWV2bGthOHM1SXJYQmE1c1oyWXB5?=
 =?utf-8?B?eWxNNC9xZzdPTnptV2JmQU1CS1FyUTNqQzdCa2JqTWFDT0daUGVSYW9GQUFW?=
 =?utf-8?B?RGJwbGY2VTRTZ29GbExOQjJESG5XU1ljSFgyY3g4SkJWZnp6MjRWOUdFaFYz?=
 =?utf-8?B?cnpzSVdvbnc4YXFYVzVkaWxvb2JlVndlWUh0WGFXRWk1bmpZbm0wcXh6K0JK?=
 =?utf-8?B?eTdJVEpFUENwVXlNQ0JaREpacXBMWHlhMkVLUzhOeHZDWk9jd2JTWWRxb1U4?=
 =?utf-8?B?UDB2WTd5N05XalZwUko5dEtzM2UrMHZZS096cnZQUWpUTGpDeWNnQTZZUjVq?=
 =?utf-8?B?VFZjWmxnblhES2xtTkxEVlA0Tzl4QWtuM0xrb3l5NkErUnJXVnNuZEdZdDBv?=
 =?utf-8?B?YnA1YXFCR3FoSTlwM2VORkNoelJIQnVaQTVrdzlGRlQzNVFFVkc3b0haQ0ZK?=
 =?utf-8?B?WS9ZQ3VHZTFsbnlWY1NwVlE3dEhhOER3Zk00U3AwZlU5SWVtTVAxeEg0eXAr?=
 =?utf-8?B?VUFTV0YwMlA5emx5ZXJMVTFWZWJ0cDBVd1lRYjdDaXdGd3hIN1VNa291RjRU?=
 =?utf-8?Q?uNAl5DJMiK9fb+Xg=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad35e31e-5325-4283-4213-08df244e9200
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 08:39:58.7269 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +gjcfuW7EPe0K/XDPRv8v4jNsr3Bubb6rjChkyYc9MuNHhqDV0uwY3zOLffnTFlbwAZyCEiR1ZPiGiueDRrAYMZvC5DRBWvlPkC2uhVw4C4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6292
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


