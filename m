Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 782F1CA5FA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 17:26:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBbYi-00067h-GG; Tue, 29 Sep 2026 13:24:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xBbYg-00066x-Hg
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 13:24:02 -0400
Received: from mail-francecentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20a::7] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xBbYe-0002kz-Qy
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 13:24:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rrNF03Nvq3LqGwcsjyaQH1ZWjEoLU+Au5jKgcOk/T8SAfZffvsLDp1BRcpi4htBidIM6+VxI8eOjpSaPym0EuVS0os9QG6btBAkgVNuEVoJUeg8CXX12DozExTsUo0qBsdx4wOPW8Uot5NSIB042YQFafbnzPs+dhaA/d+XLyocezhSYc6nxLYyuozLt2EZZ2zGAfpvdiFDeb3xDJiLi/dTsPHmzd1cpP8jBAqEkHPf2WlwHsqWNlVqWt4+ymlwXdrJ75/iSTENcJ0QMAtJsrpO4KMc04PmDro+OdmwR4a3tRLkGDoqRajdIcr2Pbhrb8G7+0A8ct0U4gd+WZKQWxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yIUwt1BgNYlsCPBHZAIWckK3Xdx+DTXHFrGqoEKKFiE=;
 b=AqwsWZD+cC6EL+5Z6ElcDWAkTIJFbvjSrbNqNa40Lndenwjprlp2HLj7ly/wcaRG2YY+0N1hMyWSOSMARMoklNbL4+zwxsMKLm355N8IrvjNPLbPcCXfjH7Dj2k/pPPOwIw42H3LOUZ7RJrcq8Osu1T1bjqnx6HhYkGPIB5zVQxWf/gouaMPl9//mOml6+OoUnUuRsz9BKgpzh4iHrHnw9uHBExbVHtoS1hE3XmFednFTmPAQ3V7fP626mN7yFRa9eCI4iv11eA4Q74wG48RoZgykns43i79N0cX/bDL7BOUmQX3FYObwcxRtxrSc6ysk/AF9kIf5h/Ii+eLILjSYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yIUwt1BgNYlsCPBHZAIWckK3Xdx+DTXHFrGqoEKKFiE=;
 b=Hwn0yxVMXPGaEDA4ZFWH0IL8pUuWBkuu/x4HezLwoX1Q6ff5jKn6u5M5d6kOCOaxvmaYLxBQuEGlUd2HKrlil56KOXNK5UTo5kcqMqOTjvA0/sojko8cL8WbInKXCMuvyVcgzDxNFyiUI4Q5WPuLeLXJIECaIbwryUnDlvAOGqjp2fDpqCX7jxg/esYiX78mZS9vmN5hjZednO+Nc061tmfLea6l9aAWcHkML5M65/SQCmwq6ijuonjlvkOd9l8obvUbaom+Kqf1PYYmMHOXjn1TIs3QxsodsL9bCnk0CN88Mt7/7t5QKjorVGFCRhu/gsjSAjG0aeFBItqaqgdQgg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AS8PR08MB7910.eurprd08.prod.outlook.com
 (2603:10a6:20b:50b::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.14; Tue, 29 Sep
 2026 17:23:50 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0472.012; Tue, 29 Sep 2026
 17:23:50 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Tue, 29 Sep 2026 20:23:24 +0300
Subject: [PATCH v8 05/17] tests/qtest/migration: add test for snapshot
 rejection in CPR modes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-up-vsock-vhost-v5-v8-5-12bcf1c0b84a@virtuozzo.com>
References: <20260929-up-vsock-vhost-v5-v8-0-12bcf1c0b84a@virtuozzo.com>
In-Reply-To: <20260929-up-vsock-vhost-v5-v8-0-12bcf1c0b84a@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, maciej.szmigiero@oracle.com, philmd@oss.qualcomm.com, 
 odaki@rsg.ci.i.u-tokyo.ac.jp, clg@redhat.com, den@openvz.org, 
 andrey.drobyshev@virtuozzo.com, mark.kanda@oracle.com, 
 vsementsov@yandex-team.ru, farosas@suse.de, peterx@redhat.com, 
 sgarzare@redhat.com, bchaney@akamai.com, dongli.zhang@oracle.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VI1PR04CA0130.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::28) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AS8PR08MB7910:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d523780-b78c-4fcc-a8ef-08df1e4e6c92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|52116014|1800799024|366016|10067099003|56012099006|38350700014|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: mp2y0ZrLx3khFjDS8wrI67gDbWbPRGni2UDpRp5z4UE+hnKoWLu6tinFgejIranKln8AUDeFyKX0jz//nIPFq1HxCOGNU/0j6Ya3Cpw7PnwdtaV/R+2WwmzA+eLt6FE690p6U2z3PaSWjrUlV1X+gujr3f/tD7VEJHTAo4DtP+qA+3viYEzMbNfaDfDtfLTA6hCaN3hZyomFa8l1AoX9MnvbdPAqtUgiUES4Su3i2mBKY6KRCm5u6sK39L+UTZg9Xfq5/Ns/1YK9SiEptVYJAejmU7iw0efzboN/FlkHVui6i9A6hXVjaM+5rllk4PQehj+XwtU5VKyqPqNjvxbVVi8KtyNLzKrdg/Uzk/fHu6ilGV8H57NOuXgYTDM53+yfJjtCVKFZyw+Rz2UXKW3S5tRftn4Gm3rDfGK5Bk+/0l92pQdP7/OQ5EbkHyXuaE5eZpIyCqSK3HhZF2H35NPXWKM5lCQ+Ds9Df+d2eIeJcr+MU6UrBKZMu7HHbTSfYTEYyVZPv4oQTUbs+tiopHcnnokJRyHIeyGBhbNvd4vv4x11vJbH3bw7hevwzitDcZf6X7/wOgF9bHaelypi/6K9yk6z7nsxDDoZXPbs1ckrRgsIf4u4DCFdXPFF/igpBzhUUcW7qxUsv58YTImVLnqWqgYoednwDcCrf5o4lLZE0Za1WmHGrLeI00lVE0+sFEiGJrQ8W/kWD1yrpmkP6Ox/lQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(52116014)(1800799024)(366016)(10067099003)(56012099006)(38350700014)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ui9GZWFKdTFPUWJnQnNQUmcvQ09mdGNzQi9HTzcxc0daMTZhcXJlL2NlN0lC?=
 =?utf-8?B?ajhzZ0dmNmFiaVlHbFBjM0JGVWptSjI4eUpqQ3dXUTB2TUhDVTVvRXQxZUFX?=
 =?utf-8?B?dmhmMTBsYmRya2JIMTR3ZDkzbm50ZnR6TlAyT3RsaEFoWUlZVW5ZcytPNVc4?=
 =?utf-8?B?anpkYlRnUEJobzFxTnNTRTJUKzJKS1RKdUVrNkNOcXNuWjVoTXdGcnl1aS9q?=
 =?utf-8?B?Q1BLS1pXVU1jbk5aVXp1ZkplQnN3THpuUGd4UkZDOTZvOExod2VRN3pIZXZB?=
 =?utf-8?B?NDBRNWNmVE9IZEZ5aU1nTkhwdFlLd2lWeFhVejFzMndRdElOQXhya2FPTmNm?=
 =?utf-8?B?ODVLeTFLS2ZjTURZQkpKR3gzNnIrV0U1b3FRaVpqNW95enE3cHIzL3NzaU1D?=
 =?utf-8?B?T2tZSlgwdXNIM21DREdUWnJwNE84TFZZQmFWWThsQzZOZDUzcUdNQU02akhM?=
 =?utf-8?B?bC9BN09RTi96NUpGMEpBcmFjNzYwR1NvQ3BGRFZ6ME80UXQwQlRWN1gvQ21I?=
 =?utf-8?B?WkpVdkFuaTUwQjZVVnZFeEN1cGx0RWZ1YXJ5MUNPWXNEbCtaL2RUcHljaGNu?=
 =?utf-8?B?MVRZNFZMUzd6OGwrdE82Q1V0QURHcys0bUswQndDNVBwSkZVWmxZWE13RGRZ?=
 =?utf-8?B?N3N1QVVETFY1OHozQlFuTDM2a1l4a21ESWZKTm91OVNYQnVhYjFzL0cwUTkx?=
 =?utf-8?B?YTBRVllHT2FVNkJRV0NkZ3BnSUgzdW5NZTIxN3Eyc2g5bndaK0lUUmZ6T05B?=
 =?utf-8?B?eE5ReXZLeEFuNmd2M0lTL29WelVwT1NWNzNRVXRZU1hGOVpDOTJhaUhrKzZj?=
 =?utf-8?B?bXE0Nk5IakFpVmtYWnF5NEMxWXhpSy9VS2hGVWlSTkxhVXhUUGd5WmwrYk5i?=
 =?utf-8?B?SHp0bkphYzdBTS9rYzlBT2t5dXpnL091Q3dSb0s0dERIWWFSaU5hbm9qZjN6?=
 =?utf-8?B?bE55NGhCK0FhaU9XQWticTRDZ3hSbEt5bVVSczZFZGpJVUQrTUh6UmRyU25S?=
 =?utf-8?B?K0dmbm11UDhqRWVFR0U3RDBUangvVEFKQTdBUi80cUdtVzF1ODRmWWFFbWdW?=
 =?utf-8?B?TnJKR1pjb2p0YUc2MTFjS0Q4dFJnSWZ4LzFUZHBLTWhGU1UxVGNBU0t6UTJv?=
 =?utf-8?B?LzladDh0UWdhbUx2QTVidnNwT3Q3RzhVU2plV0RLdTU4Z2hxYUwrK3ZPVU5B?=
 =?utf-8?B?dzNzbnlmanIwbTEvd2RwSFgvc3Znek1yU2ZoTVMrazBEMW0zNFIxZFBVbTNx?=
 =?utf-8?B?TlBtMjlTSEtsK21DL3VzdDVxaGZvdWZPMldhRjRuODkrMHh4VTI3a2hYaUE5?=
 =?utf-8?B?VFJsRTR5WnphR241VkNtUmZ4ZlNLTkhKY2VpZEFIaTRuODZWK2J6Z1JtM1ZJ?=
 =?utf-8?B?YjNCUkFxdFBpemRvbys1TENxb2EvY3ZkUHBKSmR1VCtuQ0psdStkQm4rU0J5?=
 =?utf-8?B?blQ0QkVsTTF5M20rL01Od0M1YkpQRGVnMU1XSnhQK0tyNDRXSDZXdDJlcC9x?=
 =?utf-8?B?a1lBYmx3aWtzT1BFT1orSVV2Z2k0ZW42cnJTU0tVVzdSbUVuQ0ZMUXdaeFN2?=
 =?utf-8?B?S1hNRDFhOXBSUHNoVkJBVlU0b1VPclZQSXZXTnVGMVVxTklHQTBoNEVqWVVj?=
 =?utf-8?B?NURLVTlUQ0F6Yi8xNTN1MWlKVDZwdGRQdUx1QXJlM2ZTcS9ZVE9CRXJhUnRr?=
 =?utf-8?B?N3p4QUpVRnplUjR2VkEvbGVnWE9VamNta3VwMmRGTVJYWmZSbjYzL3JXdTlu?=
 =?utf-8?B?dklzR3JnWnBIYVFQc3NKOFRXeEdZblpoUmN1OXQ5d1p1RGExRndIVmFKTGJ3?=
 =?utf-8?B?TTh1dC8xUUJ1RXBoYVFjMVFWRmhIcExjdnkzMVl1QTdya0RmYjBxdkx2Wm9X?=
 =?utf-8?B?ZVdieWQ0TDJlZFpYcXpNRFl3MjF1SGh6VENldnFpNzlGT0ttZ1kxSTRQc09j?=
 =?utf-8?B?ZlNLVnpNZENSeW52QkRLdzFXbmZNc0dGdWp5MXlRVENsRjNtRWc0eVRlb0ta?=
 =?utf-8?B?MlBSYi9rTjNKY21wb01LeCtCdHBMcE5udFNka1BUUTVIVGNPNUZFdDZPN1do?=
 =?utf-8?B?RjI3MEpkRzhITEtBcXFWUG8vam83d3cyL0ppbW9nMEs4Q2I4ZWJpRHMzcVJZ?=
 =?utf-8?B?SzZCc2M0dDREOHdHUGUwVjRsblhQejZOcWw4V2pjR1VnQXgxS0FUbkVONGo2?=
 =?utf-8?B?VkVHcTRVWTlsei9RNERDOFBYOGl5ZTRJM3RhQ2xVbzBJYTlMcjJzYlVpeGk3?=
 =?utf-8?B?MzVXZzVWcVdVK0JHZ0NTUXlrcFNyRDhxazFSWWJJdEtDcEVzVERxaHBrbm1s?=
 =?utf-8?B?U0ttc0dVTHdaMWRWZmRjVC9vSGR4ZGM2L0RjdlQ3L3J1cjFGMEVIZG5iQ2d5?=
 =?utf-8?Q?cvAiLoabOGNUWbko=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d523780-b78c-4fcc-a8ef-08df1e4e6c92
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 17:23:48.8793 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cgzh0EgaH83e1gWb2tGD8UnX4ONDx4sHknCJwdwz0nS0/LNLxOTVL1ymTBrSXv5ZzVr8xw3UnlB1SVm0eBdAxrvAJLtEiugG9Q2A6cr7iFc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB7910
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

Snapshots are refused whenever a CPR migration mode is set.  Add a test
which sets each of the CPR modes in turn and checks that 'savevm' and
'loadvm' fail with the corresponding error, then switches back to
'normal' mode and checks that the error is gone.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 tests/qtest/migration/cpr-tests.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/tests/qtest/migration/cpr-tests.c b/tests/qtest/migration/cpr-tests.c
index 0bec753b4ab..2be0fc8c07e 100644
--- a/tests/qtest/migration/cpr-tests.c
+++ b/tests/qtest/migration/cpr-tests.c
@@ -290,6 +290,40 @@ static void test_mode_exec(char *name, MigrateCommon *args)
     test_cpr_exec(args);
 }
 
+/* Snapshots must be refused while a CPR migration mode is set */
+static void test_mode_no_snapshot(char *name, MigrateCommon *args)
+{
+    static const char *const modes[] = {
+        "cpr-reboot", "cpr-transfer", "cpr-exec",
+    };
+    QTestState *vm = qtest_init("-nodefaults");
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
+    /* Back in normal mode the mode check no longer fires */
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
@@ -300,6 +334,8 @@ void migration_test_add_cpr(MigrationTestEnv *env)
         return;
     }
 
+    migration_test_add("/migration/mode/no-snapshot", test_mode_no_snapshot);
+
     /*
      * Our CI system has problems with shared memory.
      * Don't run this test until we find a workaround.

-- 
2.47.1


