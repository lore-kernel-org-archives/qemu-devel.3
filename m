Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E38DECA5FB3
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 08:27:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCC89-0005Fi-Eb; Thu, 01 Oct 2026 04:27:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xCC7y-0005Ai-GL
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 04:26:56 -0400
Received: from mail-northeuropeazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c200::5] helo=DUZPR83CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xCC7w-0003Pj-3F
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 04:26:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i+oBoiEX3PQ2pYhG0bd+weZj0Oih0EutI6O9m1oEsqa8o5DHW6VLcOd+/YtPBHlNctO5fjDfyZBbhOFLxSD6Bx+UW8fZpwy+5HDzOcAJUBoLQ7wJHUFekOU+aNksaH9Wuyc5MrEnHb2aWYeZiXR2LuVCbC5LdTPPSGiWt7izau+3acrUgip+G3hTOMcoN8atKb/zhnpDl/duRkB+b0fVodb19e6ZTsbbNyOUcmIQ276qh/BClMZ4+8E8T50i4qROs2j6uTGNv0CKnQr/VbGJ9LTJcKVjKuqXpXG1LSz5afeG05fXYAkejdLBiuTYidyHNbB3mbtAunG5HuKL9L0U7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CzhhEOopcN3KOOtfWAhLZROUNYy2FrEKLzdoJ27vb+k=;
 b=iZ1TbRC/5isBxfWoI7nHfbSavh2iXZ+v8Qg+bHucrFR5bImHfV4WbcsfFhwEd/o6ZetuR2L95X2LGH3Mnv785kFgo4/xJZaD/O19HMbwbbCpwjU4AKT2dEIMZqay2+9zAMgxDhvrTc4nBuZl5qnRr6ib4w3HlNEA4m8kIPpwbcoas08Rl2Y8/r9Ft8K8K4EcQLrANjlyKUELCiUhjP9jDboLmx86mM8guJ++KDOECQRUhXZ3AQUI72g0UJ9KQOTrED0QKZniwnBARVHHov83sw0NKOSpDnOgYNmbEIXee27l6erztZZFDjzwIgXMo+cqyQB3F3xrEnv22FBhVFrlaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CzhhEOopcN3KOOtfWAhLZROUNYy2FrEKLzdoJ27vb+k=;
 b=XlxsndKCYQ1lOz7bd1+T9R2/kFOwCx6P57lD+Byg+f8gubFbYb0lA9XTh7hJUu2xwM1c+Yi+B3D1wJtOTbocE7Gvu+YM1F0YFh6UdLT7RbpNF8XlQNpi9lyOMC3Fh0y6eGyvVxqprGDxNy9p7SllRBcxMVZK5+Ku+yFYy32DBqe31wXkTu0Qd7A7/zALvlIcxrl5YVIZJaC+fCPoQW7OoIJ2+wouek2SvGJtA7osPu1jIOMxrgcTmXgeA0sPbAsn126YuqH7U985rrnju2Flp5PsTNGJme5KJc7eu1voDz9ag6aZX5dX+gYbmpW5E72xGs+llNAj+93LO8+tKaySJw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DB4PR08MB9261.eurprd08.prod.outlook.com
 (2603:10a6:10:3fa::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 1 Oct
 2026 08:26:39 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0472.012; Thu, 1 Oct 2026
 08:26:39 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Thu, 01 Oct 2026 11:25:02 +0300
Subject: [PATCH v10 02/18] tests/unit: add test for duplicate keys in CPR
 FD table
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261001-up-vsock-vhost-v5-v10-2-8c094843e98b@virtuozzo.com>
References: <20261001-up-vsock-vhost-v5-v10-0-8c094843e98b@virtuozzo.com>
In-Reply-To: <20261001-up-vsock-vhost-v5-v10-0-8c094843e98b@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: den@openvz.org, odaki@rsg.ci.i.u-tokyo.ac.jp, dwmw2@infradead.org, 
 peterx@redhat.com, mst@redhat.com, sgarzare@redhat.com, 
 vsementsov@yandex-team.ru, farosas@suse.de, mark.kanda@oracle.com, 
 dongli.zhang@oracle.com, maciej.szmigiero@oracle.com, 
 philmd@oss.qualcomm.com, bchaney@akamai.com, clg@redhat.com, 
 andrey.drobyshev@virtuozzo.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VI1PR07CA0284.eurprd07.prod.outlook.com
 (2603:10a6:800:130::12) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|DB4PR08MB9261:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c440ac0-6c73-4524-2355-08df1f95b6ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|52116014|7416014|376014|1800799024|10067099003|3023799007|18002099003|22082099003|56012099006|38350700014;
X-Microsoft-Antispam-Message-Info: urKZsQwSjNA/jDJLC5EQKaWFA1SrHIUPGOC51+zlhJeevrAbRIir8JQbQ0GmGdevMDaqLRXkUWjyV87zbV+s0Ul4FboB8mviioKHwvx9Zu0CWrfZNrE+/nw5CniGWCyNqv3IiCjXtlcLl0XxvhWJvJoBc8xW85gjjqk9LKt1U7CleYwT7ImxrF8oAXk9qmM2U58z8PJfLEM/YDXSbfQsZONUI/Chb9hRVUKegFw9LbmoB3pteDDS05hTSlhHYzgzFY4yO2T8hvC5+BHBAaNEEQ2pphVsy+zXq54liszNYPar2GkmSahhP4D7pz+h4tnYTyARRl3peRf23ihIVuGpQu6KHmEmGIiv88WPgyYs06fHsnwn3LWpUsGxa8jhEmgOapMsrPqU1uOH2J9u8jPUlUFJzO5HYPCxVqP59GnOqY0XfNBZXxTkSvyGwwW3C0OSxryF0gFYwraIYxtwB4H/BguOgipIPumQJSPN0d6rJc6eQLLchyoTiemqoWVgEgzlQcvbgXQuvE6vuhFkMKQvwQy3YYm8gjEpDSSATJQPaWR//gvxNBFr2mz6kfnY+ZjBPosT77cFxyQWYpFo3iE6eBdxIjBhZp049R8YyE9GgACJod7cVCFR4grYBA4sz0DGkkeho2cj817LQ13chiDu+o/vr3f0BKFNqkxVNNPnr3X1Z1WxEKWGSDejvTtAJqU+ohJeUoumF53LJERfB7g+H8WCMYWPlguCUGtMPgSI23o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(52116014)(7416014)(376014)(1800799024)(10067099003)(3023799007)(18002099003)(22082099003)(56012099006)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWFxU2VnZXBKNHNoZ0hNZmh2L1FiQ1ZXVit5T1JJSHdDK1ZSd3VhcS9YcVcy?=
 =?utf-8?B?bkNvNkd3dHBLU0k5QkcraXhMWC9vU3l6S0VTZ1VPYXAwMlZoMnd5ODZyNGtB?=
 =?utf-8?B?d0QzYnJTNkh4V3h2c2ZBaGdyTmxxV1lJNDgwSXZWYSt0a0o4MDc4Q0FrclVt?=
 =?utf-8?B?S3VLcS8rc1l4UXh5UjB3V2xsSk13WnlrZTVMaStBcndHKzZWakdmN3Rrd2hs?=
 =?utf-8?B?UFFkekFRR1lWeFJXcXhSTis4SklMUXk4RUcwMG5hVWpwSzUvQThRWFRXK29B?=
 =?utf-8?B?UFhWbEN5SkYrNkFqanZhYzFSVGpkZGJkT0xIN2lkRFJibmJ2enlSaXB4Mlc5?=
 =?utf-8?B?aHdJOEdSeWhwaklrOWJldUdUQ0V5U3pad1JKZS81OXhJWVhFMHUxN0xvUU9v?=
 =?utf-8?B?OUZyYnI2eE0rWmRTVHE1RUVIVmVYUUNvK01zV3IxcE9QVUNiNWVLcTJsb2g3?=
 =?utf-8?B?MVlsOXpFSUQrV09GRy9KL0VXcGg0azBIMnZVek5LcFd5akMxcGdybDRISEtz?=
 =?utf-8?B?UU9xRDI5eno4akVrOHJnRUg4TEFrUkNPUmlXbHRBWDRYa0hLMVJQaW5TK3JV?=
 =?utf-8?B?U1VKWWhSaW05Ty9aVEY4WDJtd3Byc3k5d24xWlVyZ2dSZDFtcWwxR3NkUmhy?=
 =?utf-8?B?OTZDblMxdWtaVFkrQWhOK01FZVZqZDZpbTlyNVhOc0lmTXRnN3hmTXBxTVpU?=
 =?utf-8?B?N0d4N1l3WW9COWlyekJKeHNKc1l6amxBRGtkNk5ZZEhZbU1oMktTR3RJVVJm?=
 =?utf-8?B?cms5cTV1L0QrTkNLc2Y2RzBBVFlCaC82WTNMMDBOenVnaGFNVTBhaXRsbG9Y?=
 =?utf-8?B?b01uWXRYZG1uaVRiOFpCK1grazlFcERnZitydFRnNkZ2WlhKMlIrTDdNSUh5?=
 =?utf-8?B?WTZ3YmpBd200R0M4Q2hGZXlmUUhydTYxVHNyWjVpc0VuaUMxK2lnUTNadTlV?=
 =?utf-8?B?WHlacTNWTFV4MjBWWExCWUM4SCs1Y0FJV3Z5bXc2NGppRWNwYWlBNmhXbVly?=
 =?utf-8?B?UkNFOWFtWXByRENLRVE3ZEhhOGZOajVjZlhHRjY5MzYvcmtCejdJS1E1YWlV?=
 =?utf-8?B?LzM1eFQ1Rmt2MlhuTG83eTVIakEvM3l3NXNCVy9idVJOTUplZnRCeXYyNVAx?=
 =?utf-8?B?c0NYSlJmdWhrS0JJY1l2cDZRVVloSitCdzBlVlI0TjlKNnhsZGhCOEozSmJG?=
 =?utf-8?B?OXcxakFWNWIvUExuNUdCZXRhbkxoVDJ1YnIzaDB6R1l1VVV2Y3I5WWR3dnZj?=
 =?utf-8?B?QStqZEl6VmhYTHBzYXpaL1R5eFVwTERaZTBET1QxRG1WU0tQMVlLTXB0Mis2?=
 =?utf-8?B?bWVpbnRGRTJQSG8zK0xTdnN6aHA4cEZncW85RXZzVTdlbUZWd0RDT0hyUTE4?=
 =?utf-8?B?eW00QVg5VWR1KytwZjNoRGNIOFpsNktleHVtTTF1TitabXdHTVdhUDZaQ2k0?=
 =?utf-8?B?NTFVaC9EZVZHNnZrWlhXVFdMYW14WEpURlQxbmtFRU55UVplc0VMdElsWmw3?=
 =?utf-8?B?T0tjd1l0T2xYMEt6SlpyR0RiV1NyRlUraGdQUFpIQUdROU5IVHBsS1FITVpQ?=
 =?utf-8?B?azl3SmpmSDh4L3BFZ1lFT0xOeG5nSXZFVHRRSjZ0RG92czVjS00rdFVjWnZi?=
 =?utf-8?B?TitOSWZHcVFRMGgzYWlOZW1HdStUeUxVWWRmM1lIVDkyUEcyZ2puYnkyR2ts?=
 =?utf-8?B?TkpSQ1pNenpJenE4RFRJSzdKVkx2VjJvd3FaRmlLcEhsNE9FWDRIem5WV1h6?=
 =?utf-8?B?bE92Zk1kNjJsR2F2OU5lQVFlNDNvbE5mcTBydXNuZ3NBOEowUHU0TXRpVjN0?=
 =?utf-8?B?VXd4Y3FWUXh1VW16aFo0bTJlak1jQlJDamdjdXF3MC9YUTVJc1R6STRqNUFV?=
 =?utf-8?B?QzNTc2QyT0lOUy9UaHhIT3V5UDRTcVkwc0Y3THlRYVF5clRUT1JrV05teUYx?=
 =?utf-8?B?dkU2eVVFWDVkZUltRDhpNHpmOHRLWG5heng5L1RzcG9zOUo1bHVZcmd0ekhn?=
 =?utf-8?B?b09MNHltejY4Tks0aXYrYjluUnZxUjFPSU1UUmptNUZsaTNKNkdteEVjbFpP?=
 =?utf-8?B?a0c0M2pyNk9Hc2Z4SjZlVDQvU1M1eElWYytyVUpLWXNCakU0Q2dmcmJQRzhG?=
 =?utf-8?B?cmgxME5tZ0xpVDBhT1k5MDJjRDFNcjBPc2xNTFo1NTg5QkUxYjJNSGp0VjZq?=
 =?utf-8?B?cmIzUlZmK3lzcndsVktHajN2K0lIMS9TK0NXTER1MnpibjRsRWtNOXQvSFlx?=
 =?utf-8?B?dkRoVS9ocnN1bm1ZNUFaaWNPMlNRMVdScnBBcDdjYXlDaTlxeEhicTdrbDV2?=
 =?utf-8?B?dkxaNGRVS3RtN0hsMndNUGpOS2o1L1pDc1Q1bTVGdU9HZTFVTHh5NTFjdTZE?=
 =?utf-8?Q?AUDUEFFnUlGuYPRY=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c440ac0-6c73-4524-2355-08df1f95b6ed
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 08:26:39.0830 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xbZYaJfZzsQO0oOtqjUNOOLnlF8AjHf7+7khVI7f/rLLSGUSVU6nnbEM7C4sl6GMBbSzXV0X0TYISrKy/+6Cqbv0bnDQBqQRfj3foSMuJvI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB9261
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


