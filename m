Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE659CA5FCE
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 08:30:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCC8V-0005lu-NM; Thu, 01 Oct 2026 04:27:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xCC80-0005BQ-J0
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 04:26:58 -0400
Received: from mail-northeuropeazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c200::5] helo=DUZPR83CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xCC7z-0003Pj-0v
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 04:26:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F6dD4/4ZtrPq9AaREjTJi5p1Wllg4ezNyKuES7a962XY3hRk7ZBFNgE6EBjGOGPG0a6di1HidiDD++3jKrVTfbgM/eT/7I8bFU3mDu37vQ7jUHHzIKBRXg5wOzOdxJvgmmz34sUThG/3D3cHE0GM0hmnCVqBgFPlQjhuDBrA3NKKEGSP9jIkrGtc1U299MmeMK7GAmYFmr9cJ1ry+eiHsFyP3tVr4JDvsDijO4hIabAJMJVx/gIJqSruu9ZyD9UKgWK/ncpcIcJByCVlfsB68hFPtKpcd3gJumCstM+ePLF1ZQeC9V9R0Jvbr6Q+8sT2XJ4EhfH1MZJoegIxZFAI6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=De18djxtHE2E9HKgY8x4Fskcmy6Hm5lIvLp+NNMBlUg=;
 b=D3REixRz2Dkn0oE0/5rVcd5O9X/a0gTv+g/eOR+Vol/QROS7hnu6K6rLVN1dt/JJVWijQ4duUwa4Spdl9ukqZgsIgnZtZHE4GUD4BhNZtcteE/o4wVWiyR3OcAKztlvVx2av8ivHAxQkfLfwRNoheRvKaY71NZMSn4rJ8F1tDwW3TTR/X/suv5dnNZNxbVisHIcAtHqCwrs/JcF3Ogaw1gWqmMvJaFfQVodiE8iRNFurk4wlw0Bzv+bTqfmVvl9z1LQ1ncp1E2Zgn2E2sajrZxlSQry2B/wjv1L3kOp0VkyfmQJvEHIIl/59UTPQICTtO4c+CHLe0szWcJ07KPQFYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=De18djxtHE2E9HKgY8x4Fskcmy6Hm5lIvLp+NNMBlUg=;
 b=pclBZezCLAs4SDAFaSOwUm+pG+Z4TRKbjZzz1iUVO30lE+goAQTfsX6HqmsyRLnf/4jiO1LPYHVNTx/7oFGkGW6vXBqWu6kCrc7K/QKH3zU4LfFNQjJVZYT5YuelNCCMOXww6l0D7nLefTJdLwcYXBgIOpxfC4QOk1ddW0gcdSAz/RBeAB1d9gqRRlvSbRD0gGQvlbhGwEw6+1zdxfVakMDeWG0/RJlSNEZ4jDgwCkYytj17q7sMuO0jWkuJlCP3h8O7OGkqg9cInWtv5dhWTGtUOup5jDxJvKqgToRsujmU37pRDYSpteOjVAMqLJ5rjaxcLg8A4qDmKiD4TY2v0g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DB4PR08MB9261.eurprd08.prod.outlook.com
 (2603:10a6:10:3fa::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 1 Oct
 2026 08:26:42 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0472.012; Thu, 1 Oct 2026
 08:26:42 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Thu, 01 Oct 2026 11:25:05 +0300
Subject: [PATCH v10 05/18] tests/qtest/migration: add test for snapshot
 rejection in CPR modes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261001-up-vsock-vhost-v5-v10-5-8c094843e98b@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 641afb3a-b611-42d1-2628-08df1f95b823
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|52116014|7416014|376014|1800799024|10067099003|18002099003|22082099003|56012099006|38350700014;
X-Microsoft-Antispam-Message-Info: P2OE67XsShtY8UlKcV7CsIGJZHxAu03U4+h2cgf85VoY8gGAdqGWzKn008/SdRZv28JoAw6PnblYcWebhhlqqp4qESPymqgW9f51ctGJKFev4x+lJB9n4pDGz56pKYf3hDe71d8qAfcKY5PMynS9rT1jg9pmR6WReAKylv2NPOaCa5xDv5zjWuye54B2i5VRlwRZhe2fqIbjEaAtQ4pRO2se/hvVEAcGjCR9JRngSSZK62/W7GJD8gpAJLsN8kwIIqEuHoEcksNfygoB7nP/4h2kX9Qdctta5ADBkrF4fxNh6x2/p+cGg7lQj/SEXonjXbNQ9gK1na9N4vGDijJ1BcXAHFW1ysGYUjqjMCQ01vtxcjrL5pjz3uYUf5f+qv12+XHq8mzjd6BaFZpwfDmXc7hRTyGmETOAOPy/w+j7vwwxA0wbwJK4YdvMcdqRtOeg/YaTVj8k/DHodywHW5Xjwj5yNBIhkEd10okyh0RqCPeKE/6Eq8xn0YUsKb/kmnSbVrtUSbIMy1bo0OG4PVDsPBaTfSmBa0sY5nOefYhPaZ4X2rOOikjx+NtZtc5qdoPT2wF4ZMrqawWeFUHlMfeuZH0TGhd4qTMnvaBg1kF/EF3OvbfCqnedpW7gXqFRoz53WIxTQIKJ0AFIilV/kcl0fee4UT7oIzKWgktOpOyQSlh3/a/D8Jj1c9eMIjE2TOrsuIIgZJ2j5dM9dK3pNRoOAw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(52116014)(7416014)(376014)(1800799024)(10067099003)(18002099003)(22082099003)(56012099006)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Unp2N2V0TXU5NUFRNmFoVEZGaXVyYzhBUUZtL292OW1YZ1djdDl2bkdIYXVs?=
 =?utf-8?B?MG5OKytLTVkvMjhkeWQ0OHN4N1pLTGk1bHBHQ0NrbEtpS3RQUnZEL0lVTFlm?=
 =?utf-8?B?cWlBcTUwU3NnczloZ2p1V2xFdktycG1pSDBRVDdnQXBPRldTb0VMMkNQZjhi?=
 =?utf-8?B?Y0dHMUNRM2pzYStyK2lqVzFBT2lRQmpIS3NMMnRLRnhINjVQOU9oQktRZmlw?=
 =?utf-8?B?Z0JVOUVHS0tGaUozSmpKYkJ4dWFxQ2oxd2MyOVA4bGNPSVVrVzJMZHFob3Fr?=
 =?utf-8?B?Q21nZ1lwN0Q3RlErSU1uWVZiSU9jenJzM1dpZjljYlFpQnFINitIZFlnUmhB?=
 =?utf-8?B?QzBYSmZwb2NlS0k1NkozRGFJMWRDc1Q1VWR0WEhQL0dVYjBGUGxJTmQ3c0k3?=
 =?utf-8?B?RGQ1Z2pEMHpKNEJseXJwaEVsVTVuYmRHNUNLTEtXK1ZoOTBvM2Irbm5FLyty?=
 =?utf-8?B?ekt4UlVCZWwwM2swY3E4aTAyK3FISHNkVWxCMlJaNk5YZ2ttWWQzbEw4Nzg5?=
 =?utf-8?B?QzV4MFg3c1JnYk4wL0lVMWUwL2UwRW9Qa1NHTCtLU2pGRitJWURVTGV0QS80?=
 =?utf-8?B?UWJmRXJFdTROV3dmMGYzWkdST0NNUXRxbHU2eHg5d3hhV1VqM1J1TThndThB?=
 =?utf-8?B?c3RxNWV1ejkvd2VTRG1udGpBcDhXNW1iWXJqTzdXMkVTL3BRdm5vb0MyMmlF?=
 =?utf-8?B?NUpqNVRUOHJvdTY0c0tiQ05CNEwzSnp2R2d0bWkwQ09QamQ0aEdmcmdidzlX?=
 =?utf-8?B?eXk4cUQ3UlNmWU1henVHY0htV1dYcHh4NUhkMGJsd1NTM3V3T3M4ODI2ZXNY?=
 =?utf-8?B?N2k1MlVXRC9Ub2J0Z3ZramxDcTYxV2FKTUNOT053SFNWckZSa0ZNL1lEN0Q3?=
 =?utf-8?B?RjB4K0hCeVFublROM1A3MmhLR0xmS3lkSVpqQ2FKZU4ycUdTclRjL1ppWEM5?=
 =?utf-8?B?N3UzRmVLVjZZM25ERGxodjR2K0JWeDVlVXhRRndVREVMSGJZM0NicEhONHlm?=
 =?utf-8?B?ZnZwNmltUFc0RXJ6UU9qT3Yvc3NNaStMdTByaHEzc2ovVGxNVlROdnJ3L2JW?=
 =?utf-8?B?RERTUGFhaUpsQVdLcnJrcmNqMlphcVkrRkZXZWtoYWdpb3dUQ1dnU3lCV1lB?=
 =?utf-8?B?ak0zOFJETllaeWNlQjVUUVNPNldkc0dLajcwWCtuZzVvdGpLbFhwSFI0WDNx?=
 =?utf-8?B?ZEFHWjVtU3FRT0JaRHRteTN1NTd3UHNodVhKM0ZFRHY3ZGl4RkJZN3B0Mk52?=
 =?utf-8?B?UG02Znk2ejJYZER3VDh3MStWL3BqM2o2RjBqalhOcnBxaE1UK1BDTUFlRUl6?=
 =?utf-8?B?Q2Z4N3ZBbXozeXFTaXVVNU84S3JpNW1OZ0NrY01MdlpSTzkzN0FQS042WHQ0?=
 =?utf-8?B?SnVvOWFTZlFTVWcxMW9HSml5TmVzeXVEYURRVVZmbjRJT2lRTHpoYllUZ0t4?=
 =?utf-8?B?QUlXb2lQWnBBZEhlOFB5RU8vZXErZUZlSFJsNEFoUS9mMDhKNTBuMnlVQzhX?=
 =?utf-8?B?UUI4aXFQT1Y0VitkNUxTeU1GU3plRGhrMHpRQnBWcTh3WThsSkdRNGEwclUw?=
 =?utf-8?B?SVlVejgxUEh0bzRTMFBZUmFuN052Q1VNNTlvblg1dlhQdVlvdHFudlRKZ0dK?=
 =?utf-8?B?QUNWMVNBYmc5cjFVRUlwRlduN2RPd0hpY1kvZHdzUy9pdU5vSWdBSFFDSXcw?=
 =?utf-8?B?MFpsQTVGTTBvUitjMFJESkQ3d1NNOGIrb0NIOW9GWVBmQXgwQWw4OFF1ckhH?=
 =?utf-8?B?bzg0UW1YUm9pN2VlOTZUVm8rQ1gxTzlPTU8yRSs2OWNGOFBrak5JYWsvQnBW?=
 =?utf-8?B?cVhYVnJ2Q1A0dWN5RkY4RVYrUTdDUmNBbnh4SE5DWTRuVUxlWDlOeExwY2JJ?=
 =?utf-8?B?Z2dWc01wbzJPREgzUE1wdXFHMitTMGQ0Si8xT3o5STlRSGVRRTc1aS9WV0Zs?=
 =?utf-8?B?ZzZSRklQeDQ1ZnczUTFYa0liZ2wyWmNEL1l1c0lOZmxGQ3lQcmJjT254WFY4?=
 =?utf-8?B?MndLdTJrV0s3TEQ3WEpmdGJOV2lGdWtyOElFbFVzT1NzdTM2ZFNnUm5JSWlq?=
 =?utf-8?B?V0Y3S3B3Skk3VldGaEE0YUNVOVQyYlZNQnlrUzJ0SlhIbU95dlQrSmJuNCt4?=
 =?utf-8?B?V0g4d1F6a055aCtGMFhUSlBCWjltUytwUENsVk1NQVhQYVBhYnoyZ1plcjdH?=
 =?utf-8?B?ZWp3cW4yTHJyQ2pndzJFdVBKNW53VitFcElpSHVvRkd6dDVRNlpFV0JuZndp?=
 =?utf-8?B?S1VXeGc1MkJMOWdZdzlvR0FhclYvdFgrN1dLY25ROHVXODRaWGtRRndScENC?=
 =?utf-8?B?R3hHcDBwaXovNzBUR3RkRGxyMjlBd1pLZnlBUlJBWGhYTmVmbCtOWHk2dzZI?=
 =?utf-8?Q?ElsRNKrKp7HDKcvA=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 641afb3a-b611-42d1-2628-08df1f95b823
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 08:26:41.1485 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yJA7BrE60cRqmNK/SFTerRnAeVL4P3HR1yVN9ZCd7QNaI97jK0rwdVZXLXiXdU/871mlKQyXgeJov9k5CM4DaKlLY02HGPOHKh3PQGN/0X4=
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

Snapshots are refused whenever a CPR migration mode is set.  Add a test
which sets each of the CPR modes in turn and checks that 'savevm' and
'loadvm' fail with the corresponding error, then switches back to
'normal' mode and checks that the error is gone.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 tests/qtest/migration/cpr-tests.c | 40 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/tests/qtest/migration/cpr-tests.c b/tests/qtest/migration/cpr-tests.c
index 0bec753b4ab..05c2ac1336d 100644
--- a/tests/qtest/migration/cpr-tests.c
+++ b/tests/qtest/migration/cpr-tests.c
@@ -290,6 +290,44 @@ static void test_mode_exec(char *name, MigrateCommon *args)
     test_cpr_exec(args);
 }
 
+/* Snapshots must be refused while a CPR migration mode is set */
+static void test_mode_no_snapshot(char *name, MigrateCommon *args)
+{
+    static const char *const modes[] = {
+        "cpr-reboot", "cpr-transfer", "cpr-exec",
+    };
+    QTestState *vm = qtest_init("-nodefaults -machine none");
+    char *out;
+    int i;
+
+    for (i = 0; i < ARRAY_SIZE(modes); i++) {
+        g_autofree char *expected = g_strdup_printf(
+            "Snapshots are not compatible with migration mode %s", modes[i]);
+
+        migrate_set_parameter_str(vm, "mode", modes[i]);
+
+        out = qtest_hmp(vm, "savevm snap");
+        g_assert_nonnull(strstr(out, expected));
+        g_free(out);
+
+        out = qtest_hmp(vm, "loadvm snap");
+        g_assert_nonnull(strstr(out, expected));
+        g_free(out);
+    }
+
+    /*
+     * The check should no longer fire in normal mode.  savevm still fails
+     * (there's no block device for storing the snapshot).  We just check
+     * that it's not the mode error any more.
+     */
+    migrate_set_parameter_str(vm, "mode", "normal");
+    out = qtest_hmp(vm, "savevm snap");
+    g_assert_null(strstr(out, "not compatible with migration mode"));
+    g_free(out);
+
+    qtest_quit(vm);
+}
+
 void migration_test_add_cpr(MigrationTestEnv *env)
 {
     tmpfs = env->tmpfs;
@@ -300,6 +338,8 @@ void migration_test_add_cpr(MigrationTestEnv *env)
         return;
     }
 
+    migration_test_add("/migration/mode/no-snapshot", test_mode_no_snapshot);
+
     /*
      * Our CI system has problems with shared memory.
      * Don't run this test until we find a workaround.

-- 
2.47.1


