Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B62FCA5FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 15:03:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDkC3-0008Fa-RZ; Mon, 05 Oct 2026 11:01:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xDkBs-0008EJ-Uq
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 11:01:23 -0400
Received: from mail-westeuropeazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c201::6] helo=AM0PR02CU008.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xDkBq-00056n-0n
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 11:01:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ah+wEZI1CXg2P+VpamvGRRBxsnP+p8NqP/r0DVy0JV6MGM6sCfPLZ4ZpsllnN7EFijP4fQafyF49PUxpIq2vCR+waPoGtV24av6I7n2xlnQCyVclbPYgSB7jEAtS8vHB2AGCc/eXa6Jt1k/zxU+l4L2vWKUlyAL7EGnWJ46SDfeYpEeoI2dBYya8hw4caMiWoGDqEFbXm+gfx+DkIm5B4URBSBJLoli0NdM+OnxC/6W3XUg02M2m+F8219+iJbTdrt/NcetJWgCOW03bHgG76UIckhACiDSRKCsoY/GVmNZhE6RRH+hrULBxjwbgPbaXeLw3wK+hJHKQmo8D+Voj+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=De18djxtHE2E9HKgY8x4Fskcmy6Hm5lIvLp+NNMBlUg=;
 b=LZQsFgfq2Z5mBItCTAOnxusM4QrJCnhnwgdBszIwcEFVRSgXQQc9l9tfsfOpl6yfo1wCKR1DqofGkI7ddLVHf5xTmTVcpp0T1pbC+jGL5axYdtlER/DDrq67vxQGkBfqyGd9LoreKBB4mCI0rDjM6lsARmkU04IJnea0TKqVIPBZ+NdPumzeGc2f+iKwMuDuUgupwT1BJ59ljFOvpFjXjkgr/0ifbZNBpAak5wK1CMU6CQKZtMNn+mHFaURaK2LeMXCVqkHAjILlPDtmKCDXdfHhkvB0rMrtD5ESRbVRSgGn6T/faNFylPoC12uKoLW0BASOsx2/KH+P50vey8N0NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=De18djxtHE2E9HKgY8x4Fskcmy6Hm5lIvLp+NNMBlUg=;
 b=GZyGcwLb6XOhHyQxkDcdP/IRH0ppwOLtVn6AXsEQ4X2VnLstb5cTM9TYjqdLPBJiQh4nxT79WkDLRhYJU4OVzfQr7guufzrs9ZI/tuN7aRU/CNf+OZLlc2+aFvruSoFQB/Qou9T6psbPMgvnPi34Qh6XcjO2r26PDWyuhXwgWnGTF3lkz4NdM9YCJHWcCCdIybQBnScnx6TOdudROwXSznrR6pNmCpIeBdzYQ8dMPnzM2Vrl4qXdw9A4TsVm9O3kC6+Ia0/nZ7lvtCVER4+s7MVDVZzhcpY18N4CFExn25p2ZJOuemWBpK4lcMtUjwkwxWKbqbcBhP+YcYmH+Rs/BQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by PAWPR08MB9736.eurprd08.prod.outlook.com
 (2603:10a6:102:2ea::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Mon, 5 Oct
 2026 15:01:13 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0496.010; Mon, 5 Oct 2026
 15:01:13 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Mon, 05 Oct 2026 18:00:44 +0300
Subject: [PATCH v12 05/21] tests/qtest/migration: add test for snapshot
 rejection in CPR modes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-up-vsock-vhost-v5-v12-5-40162390c68a@virtuozzo.com>
References: <20261005-up-vsock-vhost-v5-v12-0-40162390c68a@virtuozzo.com>
In-Reply-To: <20261005-up-vsock-vhost-v5-v12-0-40162390c68a@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: vsementsov@yandex-team.ru, clg@redhat.com, odaki@rsg.ci.i.u-tokyo.ac.jp, 
 mark.kanda@oracle.com, bchaney@akamai.com, mst@redhat.com, 
 sgarzare@redhat.com, peterx@redhat.com, philmd@oss.qualcomm.com, 
 maciej.szmigiero@oracle.com, dongli.zhang@oracle.com, den@openvz.org, 
 dwmw2@infradead.org, farosas@suse.de, andrey.drobyshev@virtuozzo.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: WA0P291CA0014.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::19) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|PAWPR08MB9736:EE_
X-MS-Office365-Filtering-Correlation-Id: f34d04c1-b6e4-46eb-1197-08df22f17f6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|1800799024|366016|23010399003|376014|38350700014|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: fPUVugmETYc3kaQ1YpqCJkzL7QjjTv0sm6zAZJkaj5294jl8KAi1WqIcq0a6gL+q52aWyTtGDu2qCj4SBN3AdnPd6brmdV/bfu1nWnhFfnHu1ryeruUZAXeCifsfHez5yxxp5loN6fL+IJfy2cFRmJye+yqVXWNAqe5YRcAZ6u3cbvL72ef2pmNvGFG3mb+Nr4hsrULOsZuqyGC45oUVDuosynkmyPOY9++nMwYVLX8Gh1fkYuZCaZ3otUrHfcSzsu1NhaZiiHzSzCIzAApOG8+T2swK6S4eX1BXfoFbApABxliEFrt1BfYFJSAc1C3lwVODYL2jeSkIukIfNXlilBZFS2IJzZ0reLrbV5etEzgifZcfUz+DbbREnMOuJBjnjo97E+Xz2qTy4I/UMwzbAECMx6biNrkmraOXu/jRmzbJMdriKzYA0McTo2r36XylJQMqgNLDHKVU0GNRDY8fDwEwsXQs21APH6oygC72n6bnlq02B09oa53B2OGk9Ldku+YVwdz/fxrgMro3pW+4XPVur/cIYuPSvS3U+PJY8AVOLl38JKko0kf9QIQNBgMFjlI+wp8vAlKwRJiP8+h0h/rBhvnec9i8l9VTV2iWbK79o1Uc+7IJDLSiXdpkZ8xk+Aa7jwQCSVsGjkgBMUARF1TdoHC4ZkgvvgH9+qIlidTHM8pgR/mGwkI0HMKCMC/xFzIVQliholWLs/KPyifWpA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(1800799024)(366016)(23010399003)(376014)(38350700014)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWVQQVA0TUNadjJnSnUyVzVrclRoODFMMTluU2pOYURDR3hKY3h4UW5tTHVs?=
 =?utf-8?B?aER0S0g1WUF6cjRmN05NcDNHZ3JaUEt0Uk5pdFZjM3pnQW1iOW9HYm5MeUIz?=
 =?utf-8?B?OFExSnV6aXNiU3NvMlE4YkZLSnhHTVRMaHBYNHEzeWQ1ZFNRL1l0SVlnbG11?=
 =?utf-8?B?eXI5ZEsrUkFyYlVHTDFkWVZlcDhUZ3lsbTJ3U21NTFJGbm82emRGRm1KU25R?=
 =?utf-8?B?a2xiUGl3TWtUSDEvSGhqN3J1K0YyaHBRaUozQUNzMEJHRmZWYURtZVNKRHh0?=
 =?utf-8?B?QXh0N25XRnZHdXJXWmpWZG91Q2JqaEFQSGtjajRWbTMvTmJsN0RwQVVnam9a?=
 =?utf-8?B?K1dWM1dMRjdqMUtjOXRYNjR6eGhWZWhVTXJKNThpeE96dXZrWFB0aktzbjFG?=
 =?utf-8?B?Lzc5djBld0xVZm1zQUczQmZJNklzc1V1bGZHWWF1OGR1ZERZZWV0VXd4UzJa?=
 =?utf-8?B?TVU4alVMaGdpcHU1OExQaXJ5bGlKVkxWRkIyYnZaQ0NESlRmdFZSUVRLdTZX?=
 =?utf-8?B?WDNsT1V1ZEVuSVV3WWd0Nm14Skt1SGowanhBMk56WjhlbmgvMnJtNW1qWUJy?=
 =?utf-8?B?ZDRKczdaZklwV2NMdDE4Q1pXWHZaWllsSElESTVvcXhCMjAvWFlTNGlmdjlD?=
 =?utf-8?B?WVU3M0ZHNytVaXFjV1k0OEdwaU16TVU0ZThvY1MrYmptVHRQMkVHdFM2U09M?=
 =?utf-8?B?STJnbXQ0MDNIMVhkTUZaTnVSNFJDSURvY1NXYTl6YytHcEV3YkM3dW5NWTNP?=
 =?utf-8?B?cU9EQ0oxck9Fdm05RGZPMVBPQjYyWTV6KzlRZGZIYkQ3YlF5bUhkUXVSYjZJ?=
 =?utf-8?B?bkdQdHk2NlpHKzNqTGFISFlkNnZGaG1UbDBGYTZZcG5ZMDl1L1BndmZ1WTNs?=
 =?utf-8?B?dEl0aTNaK0pYS0JsL3dibEd0YjhlUVo4RXhhaXVITjNERjB2NHJDMHhjUi9W?=
 =?utf-8?B?c2Z3dWRQYzNZTFl5N1pUOEY2NUVvMHZlWDBzb3MxSFRRQlAxQVJjYkFLVDlH?=
 =?utf-8?B?dDh6aExVYTBJMEVIbERtYUNqejlIeWs5UHdKdFNhYTNmZk1mMUNNSFZPSmg2?=
 =?utf-8?B?MU1yR0RNeStYMDdhRmpIMUJONUxCZVI1aGN4UTJvSmc5aVdGSWRUZTFZRUM5?=
 =?utf-8?B?RUcxUmVwVXlpUGk2aXY4N2FXdm0wRGNiTU1ua1llM0NRN3haUW96M1JkNDlh?=
 =?utf-8?B?TGhtR0kwTHZ1SDgvUVBMc3llMWZMWHZ1WEJhSmUwUExSN3BLYVpSaVBiMStJ?=
 =?utf-8?B?VXpPcUttU2tLRlRNcEJtREoxdUFWQWFOcGNvR05HaFZUUGxDeU5oZjNyVmYr?=
 =?utf-8?B?eFFtMnBuZXp6aGFZNXhTbGxjcnhLdkZUWjZyVW1ESlJkaTJqMlhuSFBRQW9U?=
 =?utf-8?B?MTljLzZ0YmZaMjdSWldvOWIvSmZBTUMxVCt5SmFnbU1vL0FYTC82a21vRCtz?=
 =?utf-8?B?SlB5VTduaVNpZ01yejZDKzFaMDA3dUVqbEtQakxjTFFMZHI4ZmlvWjFvUU1t?=
 =?utf-8?B?SXMveUhGUHdDaGRYa08xNUFremhVQ2dsK3p6TEd4Q0plUVhsYjVXMFJNVzVR?=
 =?utf-8?B?TmNJaUQrQTlhVkRHaGNwZHRBNGtMaGFQS0oya1A3NE1qaVdENDF2cU1HaTll?=
 =?utf-8?B?UElTK1dVY1Bxdi9CRGpQM2R0cTllcFcvVE5nNmpRbm5SS3hzWUpVNkVRM2xw?=
 =?utf-8?B?Qm5NWWNYenlhdEkraTJVNXI3VVA1UFFDOGNKeHpIM2pCcVNYWlJ5YWY0QkFN?=
 =?utf-8?B?YUxxaXB6aW45Vm9KWXdWK2pnN1dYeUs0U0dDVTdvMGJWazBrR2xzZ09GMEcr?=
 =?utf-8?B?N0Fta1kyTDJ0a1YzWk5RWnY4N1AxRDQrWm9PcFJZelJSd3RoS3lmalZRelBl?=
 =?utf-8?B?ejlrTmY5bFZhNXBCNVRzOWZQVlN2Z3VEZG5QbFdtTWJUL2w3ZmNsVEN1MHN2?=
 =?utf-8?B?TWlxQ3dQVVh2bE9FM1RkRmhDSG1ITGxaaU93SndhZ0R1ZWFjUE9oY3h1bDdz?=
 =?utf-8?B?OUNGV1VuWTZFUUFpeDQrWkNodm84SDEvNis2eW85MTNFU2grWE4yY2VBMVgw?=
 =?utf-8?B?bGtDRzcyN0U4UWlXL3d6Y1NTOWdmZW5PVFZjckQvMHZRWUl6dDFCS1JvSzFP?=
 =?utf-8?B?U0tUOXVLY3RHZ2d0cFRVUEtiSFE0OEh5RGRjckV1ZFpYQnBNR0FCaFQ0TGIw?=
 =?utf-8?B?eitMaHNRQ1ptOUNvYUg1bDk3cDZEWlRrZk5oZHkzZE1ScmhldDhpYWttL2tP?=
 =?utf-8?B?a0lSblNtT1Y2SnhydHNQWkJ4dEVFNSttdWhROGxMaTkxYXVXci9vTldHUm9n?=
 =?utf-8?B?bXFCWFpKN3BDNkxoNW0rSW5hYU13OS9sR3RUSk80ODl4Q3lpd0ZRV04xaEFJ?=
 =?utf-8?Q?Iq/ydaj9MOBzRCWA=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f34d04c1-b6e4-46eb-1197-08df22f17f6c
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 15:01:13.1308 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fe0LqpQK0nVW6NY7wukYt9yip0GxKPqKSAmnK5wz/rsHONwf9sJXAiw558Vz8aQqdQ8t8to/PB07UOAy+EIBwf63MwjoPSjhYa6Jlq3K/4s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9736
Received-SPF: pass client-ip=2a01:111:f403:c201::6;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=AM0PR02CU008.outbound.protection.outlook.com
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


