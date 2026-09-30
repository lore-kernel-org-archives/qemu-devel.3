Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C9CACA5FBE
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 10:14:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBrJe-0000iH-9C; Wed, 30 Sep 2026 06:13:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xBrJc-0000hi-N3
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:13:32 -0400
Received: from mail-norwayeastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20f::7] helo=OSPPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xBrJa-00046g-8N
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:13:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vK7j3lSjiDVZ4WV1ClxiJqBN/ZosQUNeh2JjQf1zlB4/IZNRTpC9mhcPHnpWL4rcwnC0NQZ1H7qsLZ3kijXyFvVjT5SIT0DKz8peV+4oTDb50l4RkPnJFGN77J7EHEnwdHH63jq9gtZTTG+t8GLlGl33Tb0yP8g9eOd+TPMGzBZsvlLKAMl8bcV+X3w1TDw9gPClDETINNTflVkyHVGc9cRyJIJWjzkCaOBpVOXXVx+LW3zjN9+7NyqSaakR9y0vHfA+37gIwo0EotNNBqdtnpdRjQ3MlGWett81HeojVgDFYdC+ZJw7iU6Q0+avBjRvkfHnDX0E1LZzp/3EI75KAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=De18djxtHE2E9HKgY8x4Fskcmy6Hm5lIvLp+NNMBlUg=;
 b=k6ZfAYCDTY8BDr9dy1eN0OG2biY0AjELWid3H8gsaRXciy96o1VmAGmiEj8UrGzhiIxeZzmkBbzNZqaxKOxIGEFNgVyllsmQ+ATVe6Y7i/f3Jzs49nIJ5oIou9pMHzCyVY+B5NgvSgLtRlcCk2CSx4WoaTX4SaySSK/jMLtE8hunfk7nS5gc9kiV4gYDTbuBhj/a1LE9cxb+XHr9sMlHBp30yr1LAUSUtWRBUaI7JQrKU+IMYDFNhPz2yxKND/q9LpnOGPdRwbfDzxj8/4ncFg3zLuHA5zpoQd6wC1Yrhbr4f7RmeVFXOBPcTZlwAns7zLcd3zLGYHrf2/uAtWxCyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=De18djxtHE2E9HKgY8x4Fskcmy6Hm5lIvLp+NNMBlUg=;
 b=KbXrp5NOU8Urzrjsa9oPqKngRZLy2JPORjjGcowyuFiHmTvV6aLFATUabg/CI4tvMRZ+qV9I2xt5iHs1PDAsYtdjQd2jBmQybfSzSFFOJfPwMysnUH+F1U5lmKZraC+6uAoxcXFjcbRPkiYNwPsE7/QD3MjspCU65FEfPcg0JFa9pNKBA6I2MGSw366ehJSZZushQVwaoQcRBBYhOdfZ9ByGvTaQrBKyje88J2ONa6mW7Q2oQ1ONQE2RtyqFk8RQ47b9FmM3Gr+5LqSdybJMx9R6w+yRbTUX3v9NrgSSiq8cu+wVl2zVLuKAUJC2s9N8dRv3TnP7YA1YI1xOq8U7nA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AM8PR08MB6420.eurprd08.prod.outlook.com
 (2603:10a6:20b:314::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.9; Wed, 30 Sep
 2026 10:13:19 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0472.012; Wed, 30 Sep 2026
 10:13:19 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Wed, 30 Sep 2026 13:13:04 +0300
Subject: [PATCH v9 05/18] tests/qtest/migration: add test for snapshot
 rejection in CPR modes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-up-vsock-vhost-v5-v9-5-e9096f629770@virtuozzo.com>
References: <20260930-up-vsock-vhost-v5-v9-0-e9096f629770@virtuozzo.com>
In-Reply-To: <20260930-up-vsock-vhost-v5-v9-0-e9096f629770@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: andrey.drobyshev@virtuozzo.com, clg@redhat.com, mst@redhat.com, 
 sgarzare@redhat.com, maciej.szmigiero@oracle.com, dongli.zhang@oracle.com, 
 bchaney@akamai.com, philmd@oss.qualcomm.com, odaki@rsg.ci.i.u-tokyo.ac.jp, 
 farosas@suse.de, mark.kanda@oracle.com, dwmw2@infradead.org, 
 peterx@redhat.com, vsementsov@yandex-team.ru, den@openvz.org
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VIUP296CA0066.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:337::10) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AM8PR08MB6420:EE_
X-MS-Office365-Filtering-Correlation-Id: a671875d-0522-462b-e489-08df1edb7385
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|52116014|23010399003|366016|1800799024|10067099003|56012099006|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info: 9yuNaIpBUIAbvndoP2hOEYsSBqTRouB12NJ550Dgm5Ui5yfFy3ebY32EZSkh5b6j8ATvkAz7aOZjOFuUQZgrsuqpYZeqZbldnQnjIZvH6KP3jJuoDorQhTC4NuVq4FKjxYq8LVhP733AgpqZ2eVbmPG/cC3YSa+tehj41pM89L2/vsQ1TLtaXtfyyvGuyn7LZuENyeBODRbDAT3TtAgan17HCFvhl7dFTvHRUecyrYwPyezsVBr5x60KHohWtJ73yejmliF1YxUeDam6FgAc5CAQ5JHi3diAMwBIWF+2xBvFZ+VKFkJ03GSGs5+ET+ClHXzGsZ+6WQK4dMYJXwYAo+5FPzMBXY1h7isZsfkAsudQdfS6IBWj/g0p4c0Ptl0kTn7C0qlAh8rqY8kzODkTdbdnXoqiDVdeMEVg6bezYJVccUvLKBJSBafGHAk4S4hKEm7c9k5WPo4+Fh1KsvZ2n07T4hiuqhM7ankykRq//TkFgm4pubC3A8QY3D22VrfHFxoXL6ALznedBV3sJ9b+cbsgXHEgXncnRn6pGxiKy2xHqUvQQgz8rNwD5vfzOMGG9U5NJXhWY876s4eaH/ENckNGWzVFkg8t9nNncmLsRa6YlVM5GslUuee13g7dG2nu9pmU1ranMfx1J6h+T3lN2uIFxnpC/sg5QDcf/Y0HS516YI1lV0j4c+ZRVmrPAtAwp/sC/w4A38o/INfnYcn25g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(52116014)(23010399003)(366016)(1800799024)(10067099003)(56012099006)(18002099003)(22082099003)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NURQZUVsN0Y1TmVNcGlZdWViTDRpSm9EQjJHVVZPTkhGRXo5UERyS1pybm5H?=
 =?utf-8?B?QXRnQm5pR2VGc1dicFNVQnBQaXNDcy93UmpwN3ZIdGJGQmlrL0pDaEFzL3g1?=
 =?utf-8?B?cGJqRTBFZDZFcXlLeHFjTnoraWYzeVZVQW85KzNEa012bkxKSUxWWE0yRWNs?=
 =?utf-8?B?SXRKZ1FuK3o5bno1cnRGOGtSNjZ6bXprOU5kdi9HM1JFTjcxRHF4Q1ZYYmJD?=
 =?utf-8?B?Qkc0ckZDWXd2WGgzSHVEenBBSmMrVnNJTmprNUpDRitQeTk5eWo5YmNFYThL?=
 =?utf-8?B?bUl5Q29saiswa2pXaFBZSk5Dak5vWHRZUEdBOTY0Zmwzcy9vdllkdG5mZjdS?=
 =?utf-8?B?UkoyalV2aTNWeGtsOThkajczbnY1TTZaMXBrSXpuWjVIQTg5UEgxeVRtb09S?=
 =?utf-8?B?eGcvQmd6eWlYZTFlRGRxK3Z5aUVHdFcwNmowNVB5Wmp3V1VuaEdMc2VUN3Nj?=
 =?utf-8?B?RUU5UklhdkxkbnNTSlZMeG5mSDRXY3pBRjJvbThOTHpPUzB1bGFONVp0TjNh?=
 =?utf-8?B?YTJDMldMQlJXMzJWSkFlN1daQnUxTEJaZmRYdk5sMWN5RDNxK2hrVjgwSEt0?=
 =?utf-8?B?YS82ZnMvdmUxYVloTFRKaUErcjFhWUZYR0dOcWtUbExJUzlydTFPVW91RXpP?=
 =?utf-8?B?MmlYa3ZlNkpPNXRPVnRmK0pRaTZ0VmJuVGpXaHZoWWZGYy83dGNNbGxySnE2?=
 =?utf-8?B?cVZaWllhak5GMXVmVHlnT3NCbXd4SGFhOWR0UGt4c2l1b3hTeXNoUndUZDBX?=
 =?utf-8?B?by94SzRJUWJJVW4vVzkrMXk5R3Fqb0hpVzAwS3lDak1OV0F2dVBhcFM0b2pu?=
 =?utf-8?B?aUNQKzZpMWdhS200Wkx2emttd3J3dmRYMlV2OHNreFFua3U4REkvREkxZnMw?=
 =?utf-8?B?dEhKcVg3dDl3bXNmY2NOSGNKWVNSZU4zY1lUMG1FVGVkRGhPNE0yMVJWK1JX?=
 =?utf-8?B?dXJhb1QvOFBzcmFkY1piU2ExSmxQWEN0WHFPckRxaFJkVXVKSWJLUnFhbWd1?=
 =?utf-8?B?REpRSG5oWkx5dHI5YUh6SkREYktGcFhVM1Jjd3FvaWl1WmptSVB1dkdFMkkv?=
 =?utf-8?B?ek1UWml5REY0OFV4WXAzM2psZlRkN3pxQytvcFNNYXQ0aU1BYWViVUp1Q1Nh?=
 =?utf-8?B?WjJNTGlVZTVUeC9RVnNOWWpaTFJ5UmgvdVo0V0MzWXdGZDg1blRTRTlBclVH?=
 =?utf-8?B?VWRZeFp3eCtqanhBclVwMjB3UndPc2U0YVBPaVRhd29IZUsxY0NTOUdabGtn?=
 =?utf-8?B?MlpMM2tOMytHejFQRlZCL1l4SXllMkRlZGhPU3BZUVlNUVphNmRHaGlsYVNa?=
 =?utf-8?B?Mjh1QmZpS2dPMUNMcEI5cXlqZXNrTSt6Rm1jdDduV214L2pabjFRYmFVRm5m?=
 =?utf-8?B?ZFFldlQ3WVJuMHZsYVc3bjRzK1lXVERKbUVDaXFpNy85VmJLWm1rc0hVbmw1?=
 =?utf-8?B?ZFdhM3FVblVNei9EZy9KRTlyZHF1UW1kMVZsa0VDc0ovdFJUb3RqSUlaL2RT?=
 =?utf-8?B?SmVqbE10cUFmK1J5c3ZiMTlUaDhvdGw3eWFzQVpIVDA2NVRXYlMzQmlYZ3Ur?=
 =?utf-8?B?RDBtZlNKSEcvMG5JOXVwQ1BsSmp6UVNwU1BqelJ0dWJqVC9RY0c1L1V4b2F1?=
 =?utf-8?B?VjloU2F2YkoyWStTSlRYRTdzZlJSOTZaZVh6RXBYei9UQVhPbDdoUFAyam9X?=
 =?utf-8?B?NzB1NkxOay9lM0w1T1I4NGN0bnUvVHJWS2UxdjRhWk9MalBJaVVSN2ZTR0JB?=
 =?utf-8?B?K2IzNlpickVUc2hiMHY1aEJ1eEt1cTM2RmV3TFJCZlc3OGczME1ZZmFLUWRy?=
 =?utf-8?B?RXdhZU1iUmpIdHJFRDJlS21FRmZiTHlyRE8zRE5wREZSZ1hvRDN6SEhWVDhr?=
 =?utf-8?B?Y3gyVnRlWG5vL2tmbVJjSTBSdG1NWC8wTVIxM3hEQUlnUkxNZFNESnhFTUl1?=
 =?utf-8?B?SWUvL08yK3VFZDhER1FTcUEyTjBWYTZxT0NoMVRUQ3VFMUlCbDFjbFpMRHhL?=
 =?utf-8?B?QXd3cXYzeFQ3cU5zcHpIK2JKOG8rWHZBTTEvaXprWjdLWXY5NmgwY1AwU3ZP?=
 =?utf-8?B?TG1rY2xJUDRNNm9pN0cySmVodDZYZldRaEEyVXB1TVF3NkNJUEV2cmtoV0oy?=
 =?utf-8?B?MURTazcvK0t1SmZqcWtMNGQ4RDNCdjZOQzZZQk1JVFJCcG90cjY3bkg0TFkx?=
 =?utf-8?B?Rkp6NFZURG1xOHV2SmcrclQwc0F1MDhYVnVlbmJ6M0dEcmpNOGZ2SURWUHR3?=
 =?utf-8?B?UytJZG1kVFQzZGMyZ1B3VGdLM05PVG1VQTVWeDVTWlVRdkJFdzk1bFp1RGdD?=
 =?utf-8?B?eWZuYjE1N0VZNkZHQTVNcXU0cGUydHM0bzlXZzJOSGRrRDNPaWVxSFhodnh0?=
 =?utf-8?Q?6CSiN0QhdlvNhNbY=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a671875d-0522-462b-e489-08df1edb7385
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 10:13:19.5701 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mt/fn1ri3BQvHzHRR4Ps04qqGi3s7+FFmK4CEi/HBQ9pTOcvl7T9GJb04KGnB0+7uZyAg4XBaONnWyAqmWsy/9Un5d2PZE7iL+Di64bLAiY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6420
Received-SPF: pass client-ip=2a01:111:f403:c20f::7;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=OSPPR02CU001.outbound.protection.outlook.com
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


