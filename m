Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BFFBCA600E
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 10:28:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xElJv-0003FM-9d; Thu, 08 Oct 2026 06:25:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xElJr-0003ER-Oe
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 06:25:48 -0400
Received: from mail-westeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c201::1] helo=AM0PR83CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xElJq-0000sa-8g
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 06:25:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PceZQpfLuLADQORQpeONJ1dfBqTR8LKA94vn87bzuZcBL/NJE0H7i2cH9ZlnM/0kC1IZIIfrz8/w2vkCrQ+4x+WuJ1Obi+O/gMZovFOsW8Oz7r6ie/wwa5CJ66elsuysXmoXSaOwGN0vM9OZEyrQqInJbhQpJ5yD+lxJWYGCjk0lBYEQx6SewuCWDMDprHJhQXYGXO9uThgEXTuBIQYyMAjK7UO6DQKw/QCD5Ix7cYbH+oWNlqJa87uWbtwTuzI1JCmPCBEgiXA42awOILUi7L/4sUCAS3c619vrIqHSIBbSRqYCKRyh5wpDeFjcVI0XiIyH+/Ay6S9AYPrEpcJIfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=De18djxtHE2E9HKgY8x4Fskcmy6Hm5lIvLp+NNMBlUg=;
 b=WhpOi7Pmx8h5fCKUiRGfn+5305QVne0yBy5clqm+O7DIqMu1NIT/XDhhDzbtI6XE6Ya2AFe/koGQUhYXBOq0MN9lxBALGfHtJA4BxasrrelAiuy0aBQP0czpFvIlsk51yRm1Zr57xVpdwXW35qwa/+/XLu5Nr4OmfKny6eP8qGCWH1/r0TmG3GKibj1ebnSe1MLslDYiYj24/Gbrv5yDWbk+GrcN0AKbGHqZf/3K3QgsqASljgA2uEDpmRobM+OFrG/aLWOWKHmbOyhUk/FqJrPEwmry9mm37hpSvaVeddjOZNMuHJJf+ySCX8vCPhd2WfRqLirvsmJcgeAjg+Xn4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=De18djxtHE2E9HKgY8x4Fskcmy6Hm5lIvLp+NNMBlUg=;
 b=E2qsxZreYMcZEyYxEY3FnwvaZQ2aXzZv3jxsjQWWwMQTSmgUqYf1rnSNBn0jpUoqm75tkSH6QWgcoxJWnLgRrAO3u1lI32mGvkn678hWk/2gVnMw0ZtSC6RxSq9GukZy4m7hDP+adcPQAG0CNd9Cxq1OW0IiC/IbyRV2Z/jlctAv3HdQnvCyqzgxK5omuHK2bw2kCSq1MKZdl61UF5IMZ4bzlUVZGl1vVmjhVYJMBpnib19sql4a9h1NoR4aaLAtCBiacez16R+tcP9a+m2y1X7CPFg/KecbdSRW812xxE6gy5iBnAAjFSkLf1JM1BwK49goiXSsESkqmhXVFnQpPQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by PA6PR08MB10593.eurprd08.prod.outlook.com
 (2603:10a6:102:3c8::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Thu, 8 Oct
 2026 10:25:35 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0496.010; Thu, 8 Oct 2026
 10:25:35 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Thu, 08 Oct 2026 13:25:29 +0300
Subject: [PATCH v15 05/22] tests/qtest/migration: add test for snapshot
 rejection in CPR modes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-up-vsock-vhost-v5-v15-5-301b73b3f843@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: f1d89836-5a7a-4397-56d0-08df25267d51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|52116014|23010399003|1800799024|10067099003|56012099006|38350700014|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ru7+DZF/eO3g4H4QsyzHn/T6zxL5XyJ1/IS0PV46zew60vPZy+9VXnB7NrjoxGVc2R7qPSg/gsNY/CpxuZZdENZD/GjEiEO6WtLSEU+5NcsKd3C9c5C6SDm9r2yThcnqTjBx50+gYLTwkhlz60dd6WDDXD2LY5oZXUq7mq97VhKo7lUu/IoPqLhbrVzyAYI1BIoH2WzZB53StZ1CSAyUl+IhgIl1ntVFdndjSOVtJT3U7l3VjSyurBMPW73/uJk/VWUMYxihQjj5et0ZvUFHhQrAfYyufoBljQOhiOnQfDSweN6fojgA5ZAfDWjdXQvEZRpBcZkESUD3lC1XyJMps0/ugcWCg6eKcYy3AGMP8AexokvIEQecrPjHpgUQOIp0QL/e1hoUoz4X0OwVftYr9HxgiMUDSa1bqMezf0BRHwYtiVJG/2EFicczHqtcLmMiBUQU5218zuEYS5zph6215zBDBfQZWuPDfQL72F8naHDy2xktgVqxq0KLUjdV5lLVT6fJUN6OAey4WjCw67i3BYY3PkNsAQOCGUavW3cC/LGuUvpjDe8UU6kb58IXrBoydnAzmI1TFCgWgUbOmEAErXU4Dd64QzRDxAQr95PuH31LZvJ+tvnqWKd8tlBXH0u8Ceg/8Pjy9OSKIdWsi+b+4fPwyTyLEpxM5LObBpEJ22lSI++lXzFKD2q7UpjhfpakGSedANjebUXDwmcZFofAqA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(52116014)(23010399003)(1800799024)(10067099003)(56012099006)(38350700014)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHkyQnIvZis5SVBpenRpdDN6bHJGZDFYN05LU3l6SzI1THh0TDB3TFJpYWRZ?=
 =?utf-8?B?eldjWEtiWUN6Y0RsUHh4WmZhWk5yWG5kRXB3dG9hOGpHMUdIaWx4Vnd0N0NJ?=
 =?utf-8?B?ZVZ1MlpuMENFdW1FREVUSXhqLzJDRXE2YW9URmcxK3FXc0M2QmorbHhHVkRO?=
 =?utf-8?B?TzA5U09SQjRPWFV2aXJBeGttVVl1bnNlRmNEU05iZkJJNjVtYUZHelBGVzcw?=
 =?utf-8?B?OTJjMzZTakVLQ2FIbE52alhBdFplWGViUW5WcjlHYjVKTzZpZDAvNzdFMXpU?=
 =?utf-8?B?MU1mYUF1czVBYUJDc3VVcEFNWkZhWHk4RVNXTzlNYmh4WStoNnFmSGkzWlFN?=
 =?utf-8?B?d3grcTB4L2p6S0dVRWVaNUg5RlRVYkVHMHp1cFFYeis3OTdUc1RqUDJWTEdl?=
 =?utf-8?B?Uk1maU5QUWIzRFd2b04vWUcwaW5leDF6MWxPVTJHTFdTbFh1c1RmakljaGxZ?=
 =?utf-8?B?Nm44ZU9VbERodEtIcE00UWhmQlcrZFlkcktWZ3E2ZjlvRko1bkVKenBRemJK?=
 =?utf-8?B?UWVwcGJYNHZ5RHpsNjR0MTVTS3hLdXJRWE55QmtmWkJCdE51Z0tiNmZCNVM5?=
 =?utf-8?B?ZlpUOEQ3alNWQ3FUSHBLWmtSNkhTRHNrMVJ6TWhjRHJvSDNVTDAxSDhMY3lY?=
 =?utf-8?B?NHZyOXI3bEZ5N1V6UjNFNDV5a0w5RzNLVHdWREtkVE1LZ2xnbmEwOERYUkxX?=
 =?utf-8?B?VzZTRXk5Rk9GVmZTTFVwZmgxTWF0SnlTK25CTGgyeHJkaXhZaTFraFRMeVlv?=
 =?utf-8?B?R2ZOQXBJalFJcGd0cy83a2NobUd5L0lOOTNSSnREWTN1bFVrWFBtdGViQlZ4?=
 =?utf-8?B?MmdwUnMzZ2dUZkhFbmd2TVAzeGxMRzcwdXRKV24vZUFjbFhIL3N2d2FpYjVs?=
 =?utf-8?B?UGlpUzVaZ2xSR1NYTHRSSHZDYXlQOStoVmgwcFR1cDZZNUNFU3lGRi9ENkli?=
 =?utf-8?B?MjVSRFVRajF0UWtlWE5hMFByaVg1MUczUTBXaDM4bzNXZzZlOTdKYldqSU1z?=
 =?utf-8?B?dkVIWHcvZXFuNUVhS21IckQ5MGlXbEV3VFlSbkhZOUhnQlhWZGFLZHlXbXdE?=
 =?utf-8?B?TUg5VzA5Q0tFMmFZejVUZzQ3ZXJUdzRNSU1PeUZaYWtCSktURWdMRXlmWEVU?=
 =?utf-8?B?dktGR05ONXlaMnhRZXhIVXJNTFF6eW5MRXl6YXRnU1ZZaGZYZFFIK1BBVFZT?=
 =?utf-8?B?RVlVRmlvUlgxckR6Z1NaM0FaRDdmdFBkeUFSU2EyTUpydWc3LytJK25mcFNa?=
 =?utf-8?B?dnFSazdHMTMzZ2hmYVl1VDJjNENzTWZEMnNGaE1zT1ljS1kyQnN0cnBjU3RC?=
 =?utf-8?B?Qm5QNEZjQlVCaWVHa3VqY1JmZmpVQXdzWEJBZFVKRTk0ODlpR3JTR0lUKzVY?=
 =?utf-8?B?cHp2SGNpUFRhUUM4Q2dkbW1vcFNrTzBScWlOVkxoRkhFZjJKcXFvUlRDVnVP?=
 =?utf-8?B?Ti9BWVRsSDVsZTlnSHM0WXlhc2xVVkQ1NG5PR3Y1aHRNNHN6N0ZRbDB3dGpW?=
 =?utf-8?B?UWVWL0o3T2NpYksxamJYTkRjbTRvS3pzYlN0VW51UTduQXVqM0pFOGxQaVJx?=
 =?utf-8?B?RjNBaW00NElsaEhtbHBZUlRBS3BzSlJUTlFmTlZOUXhVREs1bkk0Yy9NaFhS?=
 =?utf-8?B?bXFZU1Fjb3ZQRUV3c2w2OHFnQ2w1S0NobmtEZHpwZGwzZ242VWxEN1ZuS0gy?=
 =?utf-8?B?b1ZyTlhaK0RiM09wVU5aL21mc1ZHN1pyamlzaldBY3ovSVNwck4xc21lQVdD?=
 =?utf-8?B?V2RCUzJ4alRiTnlyQUdreThCVTFYRGlGL1VMMml3ZTJTcDBuQm1QQVBRTFVi?=
 =?utf-8?B?TkxyK0F3Ny94NStVYUpndTkvb2dnLytmaC9sY3lYQ0EwMU9Dbm96UWJxZkQ5?=
 =?utf-8?B?a2s4MmMwWGVlS081RTlkdUZTVnVJZ28rM0ZqZ0QrMjUxbkJKSldMZzRLdElm?=
 =?utf-8?B?STBqcGtzTkNYZGJoMFdsVENKaVUxcyt0cnZnTFdDakNuMGpFS2NqY1AvZHFX?=
 =?utf-8?B?dzQ0S1JTd2FoUTltZ3hoWFhMREhBNGNEaWFObHYyZXRLNlJSNHc5eXYyQW5m?=
 =?utf-8?B?enIvQTZDNU9LWEFTVmpkVnpNck9qZ0dlZGlZZVJVMGJSTXYvekg3OFZDZUZj?=
 =?utf-8?B?dkk3VUJ3N1VYK3hacCszSVBaSjZrWGdSem5Zd2tIMXhVaStvQ1BXTDU5U2Ex?=
 =?utf-8?B?eTVzVEIzZTZ4WFlUcG9kaTJLSGQ1TFVUT0F6RHNZb1FJZmo3cTkrNVlyajNS?=
 =?utf-8?B?SXZjaEJJeDMrNFBJbHFublJQQ3hZcDdRelN3ZU4zNXUxUTlmMEI3VGgyYXR1?=
 =?utf-8?B?V0xZYm5xRW9ValJRVkZVY2lCMEYzYWovMVlFZ0RXb3RsdUZRV0dQRjF1QU53?=
 =?utf-8?Q?jpJZYNo4YW6jfmwY=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1d89836-5a7a-4397-56d0-08df25267d51
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 10:25:35.3165 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 43/TRJbwtr77eAMtBAXV9AlksaWCKrvrqBshpdR4Iw1FbEr8wG0me1J6nDCooW4IhDiCcdWbd5b0Rk4KAeea5YWBVUeugs08L7TjbnRYtko=
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


