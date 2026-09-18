Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB594C982D8
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 13:48:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7YwI-000359-2P; Fri, 18 Sep 2026 09:47:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x7YwG-00034b-73
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 09:47:40 -0400
Received: from mail-westeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c201::1] helo=AM0PR83CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x7YwE-0003Dj-9g
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 09:47:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EaeoCjV7JAnrEaT0nALDTc1jvRiB4utGX4wQ4XDsEORHrd6JEpuQ+KP2eIVCpU2+LAEU2FHmAxLG0PHOeJIWjfxihOrDu0y/sZI+fnlIXb4NW+l46DvOwoVnwO36GpD0UWeSUlDCx+2Zx43FLFGwgcbbiMCRp3s+dTL4VJiB1LUKrKcEks7/eZVmZ2QerbYXbrUeNURMMR74tX0+LsinVNgMi5wC+hYoaNBFN0SEcXPzoARDwgSaAY6XwlmPZERg58a0JJxUrM5ZvOy+mpMGuQT8/5n7UVcQ0g4+gQZ88csPH3pjdgzrCKPlXGV6opE4k7BIFnmHzV1Z2YjT4rrGkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=chkHLlGXrJZpLjIIJhq/GNtNS3qSBj8b/AaDEcpcerM=;
 b=uwHifae5zu2N2eMtUBpn+gFONv6CLcSK3tjNnmI1d+NKmRFDTKYiS7bb6Vl/cvcHhzl8U4cSEnWUMUJghqMSQaqw6KZuMzEBCG1NnWHBvWfc23CnPj8uTdWLMVGnXhn3ksqaUEE+WxHmqjxHqfzxXeW/lt96b62QWGKPeEgyi3uxB4yIouZ4Yd44H9LJ+u/KnHpcDSSS3x4F0Mepc4urPhDPYx2IIJwHp2p9/Pg4ovdaqwqFnpoQW/5PEDHru8M+S1l5PmPAPTuYPIK6Q+wKzQ7P/M0cf2e2y5fJVTUV2g61lMABJL8DBSfr0f3zU2FRr0NPdg1aFm13hC34JEDgdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=chkHLlGXrJZpLjIIJhq/GNtNS3qSBj8b/AaDEcpcerM=;
 b=GDGeG563BQKXaxt+fFcm5jhGU/svsvCmyYhnMG/1Lyzlx9sPnDfxv+YLccV5QPOVdqp8z6RacU9HYf2TaSHZdk0cwhRkA0ISOz9K2DCtPtZz8kM4Kil37OEWbxxZbCd/2WhbvH019bBsKl7beNeHaK51XXWt5Nzb+R86J4qEyTRP2LtLt/iUGHYk1m9w/z+gh3uD8rJrnr77NwjAqlxG5dePaL/NMnV6d/Yha8sg5RZ9eZKGpLFOAPnzLIryhnQtPvUdddee5m6IZl0ji1LINLqk5ZtWtowBbQQvEq4a2l75pbGB0SVYyQgx9EVhDEo1DwwvyBXcGD2qzku0GXrlxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DB8PR08MB5483.eurprd08.prod.outlook.com
 (2603:10a6:10:11b::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.5; Fri, 18 Sep
 2026 13:47:30 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0428.008; Fri, 18 Sep 2026
 13:47:30 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Fri, 18 Sep 2026 16:47:06 +0300
Subject: [PATCH v7 15/16] tests/qtest/migration: add vhost-vsock tests for
 cpr-transfer and cpr-exec
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-up-vsock-vhost-v5-v7-15-6ef9ef033c35@virtuozzo.com>
References: <20260918-up-vsock-vhost-v5-v7-0-6ef9ef033c35@virtuozzo.com>
In-Reply-To: <20260918-up-vsock-vhost-v5-v7-0-6ef9ef033c35@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: farosas@suse.de, bchaney@akamai.com, mark.kanda@oracle.com, 
 philmd@oss.qualcomm.com, vsementsov@yandex-team.ru, 
 andrey.drobyshev@virtuozzo.com, maciej.szmigiero@oracle.com, 
 dongli.zhang@oracle.com, mst@redhat.com, clg@redhat.com, peterx@redhat.com, 
 den@openvz.org, sgarzare@redhat.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VI1PR07CA0292.eurprd07.prod.outlook.com
 (2603:10a6:800:130::20) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|DB8PR08MB5483:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b4ab38f-c5ca-4985-b91f-08df158b620c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|366016|376014|52116014|1800799024|23010399003|6133799003|10067099003|56012099006|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info: hMpgYOXUnR0zvOTZJWA95JXwRjSJLmBAkIVxfErG047O+m0Do2oVph0y726sK5PoVzbPUEirKAiJJ+s1ECFtsVrAzU5ya7Hey61Tl8EAl9o9zCa5I2Pyjc9F+HSzWH7zQQgJTk2iU+jHq65MP53J/DyRnACtBCD8UCEpL2oMH83UUIp7tDbKtDsu7jxE1jIxLvY0HfApkzOmrPtS+fKpqDhSX2JK8wibXUNZ7x+gdpJvlyRNUH25vIRA0zEA8wZmq1gfffhFAIpHkARZA2pAkesLgD8gyBQv98r/jlarCL9oMTMoXqwx82pv1YvxpAgm35D/llQ/HYgUk67mg8KqQBdujWfmVBjp8+XLwrZN8HAA27MXJ0YrFDECwjTNFY9I3JbTFuUvOGCpZnsmunb+dBSGv0YGZauogeJ6Dlo/+0kBcEJvs1Wd53lynT/DRG//sFz4fAy80PzRIcJhT4LiJV99i4J+bCWGJEqsT76kpBIkXEMxhUrxwQcJkWu6HhkSvchcFO1oPLNY9JZF1fCdF803Hk+A2+h3XiY24iCraXKqJMSrsff1rJaUy0FLajhGW/NrSan51mMrfrEccWw2YMSrs03nxvYZVr8paW0KqE15jRIJmkiHfHeo3foOsSsTsllNzk1t0+il6CpN4MXO8Jb8T35M/VZEjqJJQiAJ/kxfx7elFpak9BK+lWhKyRtSTufFL1AscEkolxA4XjYdsAAyNUBn03KkGBxe2PepuDA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(366016)(376014)(52116014)(1800799024)(23010399003)(6133799003)(10067099003)(56012099006)(18002099003)(22082099003)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WEc2VWlBMDdYRG0zRWxDaXM4dVZlYXVOTnBBUzJHcm1ZYnhpbnVxOTJHVldY?=
 =?utf-8?B?OHo0OVlteWdaTHFsWjgrMUZDOUh2OFpzTHpTOVE0RTA5dS95eFNZRkU2cEkw?=
 =?utf-8?B?QXJsWTBiTi9tSkRnUTU4QnkveTFyakJkNWdGcElFcVZ6dnVBdTNhbFdVMHFG?=
 =?utf-8?B?aVBWUHN0VkFxeTBLNlRFb2t3WDQ5dlczWi9mL1pBV2JLMEhwODlmbmpUNGdF?=
 =?utf-8?B?SGcrdnB6SVNZbUFEdmJqUDlIUW5RM3RYdjNOS2RPR2dFQkhGWVk0c1BMU1U4?=
 =?utf-8?B?NTB6dmtYN2VpbzdLSDBBVVhnejRqKzg1TldIR3pQaG1PZkkvWVgrNmROMGpG?=
 =?utf-8?B?cDlhTW4wbldnaVB1NGxFUFI1VVZRaGcwaE5qTkdJNktrMlZ4ejRSaTNYUmFy?=
 =?utf-8?B?bkxTOHdzSE85YzV6emJjcytEUlN4aWRRaVowVCtmZW1RL0VBc0VqZDFjNVVU?=
 =?utf-8?B?YmJGRXIwWlIvcmFNTmVmYUxWTHhNZ3FVcEZFdjNySmdoZlBINnBoWnd0Nnc5?=
 =?utf-8?B?d3lWdm9ycElJRUdtM2trWEJITHZUQ2ZzNjBHUjhIcWVkRTBwcmMwMDFkOXNs?=
 =?utf-8?B?ZmdRODVTSHRFWmVJSzlQZktJU0VyTG1XemExK1BHZUpoZGo1Zm51R01WVDFj?=
 =?utf-8?B?dDJSUWFrYUZhWXdVNlpmSXVwRCtYOGNKVE5WeStSMjlEcUswdHltMWR3MldS?=
 =?utf-8?B?ZEVpTnk5czM2MHpXTVhJc1ZiTmFUbUZURy9qa2o1czFtY2FSa2d5bHNlYnhB?=
 =?utf-8?B?ZE1pemNtM01kRkxpV3lrRVUvQ243eGJRVFlOSXBDRlFCZ1lYNnlYV1BCa1BJ?=
 =?utf-8?B?Q2lUb3pOYTBQR25BUDZVRGR0bUR2SkpwNmQrbTJMTVR4MUpuSGVXYnhGSC9x?=
 =?utf-8?B?UlI3OWlaM2hSdWl0SWdZK1NDK0ZxUVVWNjMxK1JPSWJKUWNNVXdtVXdkejFH?=
 =?utf-8?B?ME13WldQSUt5WTRqbWVWeEQ2TXZEaGkwandkSlFFOFhsZFYrd1ZrQXdIMXJN?=
 =?utf-8?B?dmdTVy93RjVXdThJdTdmeERvYVhwYlZFSUoraDlUU1NDZnJ2R212cXRHRG1n?=
 =?utf-8?B?MFB3QVZ5YUhPTUdEeE51T0tCbnFQTko4dXg5OFcyTmhubFNMTUJoR3VoVU1W?=
 =?utf-8?B?YlpoZ1NmUUZMOEFTM1MrRGphWFdhQ0hDdU1QRXF4L1psbkhXSzVkRVZlUEpX?=
 =?utf-8?B?TGJsbWU0VlBqV25SdXQ2ZWRnTkNyc2ZydkdvMjBsMmgwcnlCYWdPdVRUMXdy?=
 =?utf-8?B?eVZxQk8yT1lLWldJczRpZ0Z3TG5WM2w4N1RaR0RhWHdoOXRQN0VGcnhsa3Nt?=
 =?utf-8?B?dmlTbkJkcWVDYXdnMGptcEE1UXNuM2NhT1NzMkdNcjdjanIyU3dTblhjUzg5?=
 =?utf-8?B?ZzArS2xaWTVsYzdlYjVFb0tpN0ZRdDJ6SVlpVFpabVQ2SjMweVpkTjR0WkJr?=
 =?utf-8?B?UVluUUhEeSt2UXdOYVRPQUs0aW1mUWJrS29VeWVOUDFSaHVXYzkvQUtqQ3Q1?=
 =?utf-8?B?WCtHSE1ROG04THN1QjJkUXRoVEFvVy9ZYks3Y1FzMEx0ZEsyZDgzWnhBaTBZ?=
 =?utf-8?B?NjZlSk5sQUdXaVRiLy9sQXYxeDBLQ1ZlYnV6MFJqYmVjS3V1UXVZQjlnK1Ur?=
 =?utf-8?B?TnpPenliYzljV0tZWlB0b09LQ3FGS3dPbEFXWElBZHBITXFDdXVJeTZBb2lu?=
 =?utf-8?B?WFEzeFF6QUZ3VnlncnBEYmpiaEV2MXFjN2N0eGhoSUwyNThqVTdMY09XbElM?=
 =?utf-8?B?R2JGRGRkTnRCNm0yTFpKQ2ZBdks3c214eVhjaGJqUDF4ZitNUHZwTWI3U29G?=
 =?utf-8?B?M09rY3lEMnJ5Mk4xc0F6ZHkyeFhHaUFjM01LUlJhT29wQ3VOWVE0Z0JOV0Q4?=
 =?utf-8?B?UU1pemFzY2d6WE84dStyUERVY3lhLzJYbnFhdTVYOVMwSU9nSVhFZDhhUmNU?=
 =?utf-8?B?My9IdmpMR2EwTDdYR1lvOGpRTjJsWklvUEVPSGVreXBEMjVXRGNFa2JjdU11?=
 =?utf-8?B?WEVPYW8reVNQVjdnZ2xaR2tORWZNUWdvRE9lVVh0Q2gvOXRLQzZGMmdlVmxw?=
 =?utf-8?B?TkxIaUZrV3ZOM3IzOFJOeXl4M2pFeUdQR0tGVW14c0JuQWN5eWtXbHpOTlhy?=
 =?utf-8?B?c0pWY0ZVOGY5MjRoV1pZRkpEdWd3S0VGUCs5MlZDWFh6WnE4MmQxL013Y2xv?=
 =?utf-8?B?VnA0S3FQSWE2WDFZeGQ1K1dWeUtobnBkdWtxK0FPRDVtdndQRUl5R0NLTEht?=
 =?utf-8?B?NE40QVpXMUxBc3BuV2xSUGFId25SSzcrV3JUVnhIVERaSEpaVFIxRHgyY3VR?=
 =?utf-8?B?RVpuK2Zuc1Nha0R6OG5lMmVoSWl5OUcvTDFvcG5WRzBaTEhlU1NmSmovSHpj?=
 =?utf-8?Q?xkju9n8L6u+7ifQs=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b4ab38f-c5ca-4985-b91f-08df158b620c
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 13:47:30.0782 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: idGkB1JBSmHJlc2C0S/6PfRvj1AYywssIoXr2Xj6a8NsBnxmyF7x8dX/sIbylmsylW1GMM6SjmJNHO38IQXDCZOsnBdy5wB9TAVJfs+vflE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5483
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

Run the existing cpr-transfer and cpr-exec tests with a vhost-vsock-pci
device attached.  There's no guest involved which is driving the device,
so here we only test the QEMU side of the handoff, i.e. the vhost FD is
preserved, the device ownership is released on the source and re-acquired
on the target.

The tests need /dev/vhost-vsock on the host and a kernel supporting
VHOST_RESET_OWNER for vhost-vsock, they are skipped otherwise.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 tests/qtest/migration/cpr-tests.c | 93 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 87 insertions(+), 6 deletions(-)

diff --git a/tests/qtest/migration/cpr-tests.c b/tests/qtest/migration/cpr-tests.c
index a5255193101..245ab39f54b 100644
--- a/tests/qtest/migration/cpr-tests.c
+++ b/tests/qtest/migration/cpr-tests.c
@@ -19,6 +19,13 @@
 #include "qobject/qjson.h"
 #include "qobject/qlist.h"
 
+#ifdef CONFIG_LINUX
+#include <sys/ioctl.h>
+#include <linux/vhost.h>
+#endif
+
+/* We expect this CID to be unassigned on the host */
+#define VHOST_VSOCK_TEST_DEV "vhost-vsock-pci,guest-cid=4000000000"
 
 static char *tmpfs;
 
@@ -101,14 +108,17 @@ static int test_transfer(MigrateCommon *args, const char *cpr_channel,
  * migration, and cannot connect synchronously to the monitor, so defer
  * the target connection.
  */
-static void test_mode_transfer_common(MigrateCommon *args, bool incoming_defer)
+static void test_mode_transfer_common(MigrateCommon *args, bool incoming_defer,
+                                      const char *dev_opts)
 {
     g_autofree char *cpr_path = g_strdup_printf("%s/cpr.sock", tmpfs);
     g_autofree char *mig_path = g_strdup_printf("%s/migsocket", tmpfs);
     g_autofree char *uri = g_strdup_printf("unix:%s", mig_path);
     g_autofree char *opts_target = NULL;
 
-    const char *opts = "-machine aux-ram-share=on -nodefaults";
+    g_autofree char *opts = g_strdup_printf("-machine aux-ram-share=on "
+                                            "-nodefaults %s",
+                                            dev_opts ? dev_opts : "");
     g_autofree const char *cpr_channel = g_strdup_printf(
         "cpr,addr.transport=socket,addr.type=unix,addr.path=%s",
         cpr_path);
@@ -154,12 +164,12 @@ static void test_mode_transfer_common(MigrateCommon *args, bool incoming_defer)
 
 static void test_mode_transfer(char *name, MigrateCommon *args)
 {
-    test_mode_transfer_common(args, false);
+    test_mode_transfer_common(args, false, NULL);
 }
 
 static void test_mode_transfer_defer(char *name, MigrateCommon *args)
 {
-    test_mode_transfer_common(args, true);
+    test_mode_transfer_common(args, true, NULL);
 }
 
 static void set_cpr_exec_args(QTestState *who, MigrateCommon *args)
@@ -276,20 +286,85 @@ static void *test_mode_exec_start(QTestState *from, QTestState *to)
     return NULL;
 }
 
-static void test_mode_exec(char *name, MigrateCommon *args)
+static void test_mode_exec_common(MigrateCommon *args, const char *dev_opts)
 {
     g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
                                            FILE_TEST_FILENAME);
+    g_autofree char *opts = g_strdup_printf("-machine aux-ram-share=on "
+                                            "-nodefaults %s",
+                                            dev_opts ? dev_opts : "");
     args->uri = uri;
     args->start_hook = test_mode_exec_start;
 
     args->start.only_source = true;
-    args->start.opts_source = "-machine aux-ram-share=on -nodefaults";
+    args->start.opts_source = opts;
     args->start.mem_type = MEM_TYPE_MEMFD;
 
     test_cpr_exec(args);
 }
 
+static void test_mode_exec(char *name, MigrateCommon *args)
+{
+    test_mode_exec_common(args, NULL);
+}
+
+/*
+ * A vhost-vsock device can be handed over across CPR only if the host
+ * exposes /dev/vhost-vsock and its kernel supports VHOST_RESET_OWNER
+ * for it.  Skip the test otherwise.
+ */
+static bool vhost_vsock_cpr_check(void)
+{
+#ifdef CONFIG_LINUX
+    bool set_owner, reset_owner;
+    int fd;
+
+    if (!qtest_has_device("vhost-vsock-pci")) {
+        g_test_skip("vhost-vsock-pci device is not available");
+        return false;
+    }
+
+    fd = open("/dev/vhost-vsock", O_RDWR);
+    if (fd < 0) {
+        g_test_skip("/dev/vhost-vsock is not available");
+        return false;
+    }
+
+    set_owner = ioctl(fd, VHOST_SET_OWNER) == 0;
+    reset_owner = ioctl(fd, VHOST_RESET_OWNER) == 0;
+    close(fd);
+
+    if (!set_owner) {
+        g_test_skip("VHOST_SET_OWNER is not supported for vhost-vsock");
+        return false;
+    }
+
+    if (!reset_owner) {
+        g_test_skip("VHOST_RESET_OWNER is not supported for vhost-vsock");
+        return false;
+    }
+
+    return true;
+#else
+    g_test_skip("vhost-vsock is Linux only");
+    return false;
+#endif
+}
+
+static void test_mode_transfer_vhost_vsock(char *name, MigrateCommon *args)
+{
+    if (vhost_vsock_cpr_check()) {
+        test_mode_transfer_common(args, false, "-device " VHOST_VSOCK_TEST_DEV);
+    }
+}
+
+static void test_mode_exec_vhost_vsock(char *name, MigrateCommon *args)
+{
+    if (vhost_vsock_cpr_check()) {
+        test_mode_exec_common(args, "-device " VHOST_VSOCK_TEST_DEV);
+    }
+}
+
 /* Snapshots must be refused while a CPR migration mode is set */
 static void test_mode_no_snapshot(char *name, MigrateCommon *args)
 {
@@ -348,4 +423,10 @@ void migration_test_add_cpr(MigrationTestEnv *env)
                            test_mode_transfer_defer);
         migration_test_add("/migration/mode/exec", test_mode_exec);
     }
+
+    /* The vhost-vsock handoff doesn't need KVM */
+    migration_test_add("/migration/mode/transfer/vhost-vsock",
+                       test_mode_transfer_vhost_vsock);
+    migration_test_add("/migration/mode/exec/vhost-vsock",
+                       test_mode_exec_vhost_vsock);
 }

-- 
2.47.1


