Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD2F6CA9ED1
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 10:30:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGDHy-0000BS-Jo; Mon, 12 Oct 2026 06:29:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xGDHB-0007e2-Ul
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 06:29:07 -0400
Received: from mail-norwayeastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20f::7] helo=OSPPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xGDH6-0005Fy-TF
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 06:28:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OLnbW2bh2aAb4RynqF7Jd9xnBk2VupdPJRIICj0aff/EDZ0wgXu01FVNNo8CvTuruZ8wK6TEvC5+In/C6UI12UDsPUJ8ElZ1FurVnmNrUcv/fuPq4y4UAgyKv4wz0DklL3plsMI7rP9MxdLadpfOzdH6jnFW0PwL5toC9zJqv24G0t0La0BdT7u1ZJU5JB4UqWx6GuLj4sMqHUYMdHvJ1qje/IU20DvG4OMkP36hwl4unWe6d69lAoLwaSkaumUIuDMl4MfD3IMfFchnaS1HhmkoUQDTitOim5gOYjvzMYBSXMDBplNvID41rAIoosG6RrSggFhllHB9brHg9V1GJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Q/HDXLoyiC61Uu3uiyDBlQDft7G81VamCAO8Ca1qio=;
 b=NuHAL5MrpX+RNUyRxoI+bbLHkfTudtkXCvZU6zWcXbksuSe3y7iDKN7FZ1bn/XldAnGD/DtAtk1Xn/6B+zorZqnXSXSvFTP0v1OltrieLJdWmBJXVL66dN3g4alkTwIdMPmUVGf7m3a/mI0qIaIZzW+0lzdM8Ci/0T+87fcKrcjbCo9TMteaQLrsB4Vnbl+j+4wi2mcPl/vJ6nYrhHuXPsjmdUTUDfI9fMYs7e0Dpfg0LIm3bQErvkWtwfgoy5gjzhjWMiTfIkpBB5C8f8gjAYH+2D5pSvnWBpKJDd5DYoWQCgpMpZDe4kDckwQQ8u4deDWDQqOq9GDg7WWN0sRU9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Q/HDXLoyiC61Uu3uiyDBlQDft7G81VamCAO8Ca1qio=;
 b=eiUt9+KFctI6R32zUke32IVonm00TRqvjKsaDOuNIFeOvPq0e2nkDZcjTjkZakCL3qHK4RXi3L5ChQ1XOQZeubBqXPmHgaC14CDysgoX45vZmN1fpPfYKtPFYmbKowwChGLZ9YCMr+5TbjttB+es4huhR7f687wlOmXiUQAFgkfXhHwOlVnx5zZeaEbKeY7qpTxwukXLSF2inLxkU/x/nXAZPGs73bRXEF6cYBe1wwRqQIyT+tt3PQtgvyKJ1g7hJBV13veiPQt1Crej9GDpgVWEMDF5AyjivvaqeIikKQJ9LCMBD18vf2jGe7kG3hVxEUSidWdSbpGrpj3vKz0lSw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DB9PR08MB11921.eurprd08.prod.outlook.com
 (2603:10a6:10:614::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Mon, 12 Oct
 2026 10:28:48 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0522.008; Mon, 12 Oct 2026
 10:28:48 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Mon, 12 Oct 2026 13:28:28 +0300
Subject: [PATCH v16 20/22] tests/qtest/migration: add vhost-vsock tests for
 cpr-transfer and cpr-exec
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-up-vsock-vhost-v5-v16-20-36c38bd15ffc@virtuozzo.com>
References: <20261012-up-vsock-vhost-v5-v16-0-36c38bd15ffc@virtuozzo.com>
In-Reply-To: <20261012-up-vsock-vhost-v5-v16-0-36c38bd15ffc@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: odaki@rsg.ci.i.u-tokyo.ac.jp, bchaney@akamai.com, mst@redhat.com, 
 maciej.szmigiero@oracle.com, sgarzare@redhat.com, mark.kanda@oracle.com, 
 vsementsov@yandex-team.ru, clg@redhat.com, den@openvz.org, 
 dongli.zhang@oracle.com, farosas@suse.de, andrey.drobyshev@virtuozzo.com, 
 peterx@redhat.com, dwmw2@infradead.org, philmd@oss.qualcomm.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VI1PR03CA0043.eurprd03.prod.outlook.com
 (2603:10a6:803:50::14) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|DB9PR08MB11921:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b22da8a-97b5-43f2-e569-08df284b99f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|7416014|52116014|366016|6133799003|18002099003|22082099003|10067099003|260925021911599003|260925021311599003|260925022911599003|38350700014|56012099006|261009223027099003;
X-Microsoft-Antispam-Message-Info: zy9gmS6ck9sOafdHY5tI7kMYR+eBN23wYEJrlCUL/+HTNcGTb1pND+hacQE67X19uxDvtA1Gs4RpPTzwH7q3hk0RKZFmngDv3vVPYGN7AKm8f9IlmS13xNFfJwEB9KfxHm9NPdpGNKmDEM4e6DtJ91JDOX7kWx+plAEqWy3KKBpKWwDQ67caxb4nM7CDYcINd+ezVEdE8sKpTmwxNzTodSUezRoPutlNPPrBFe82D9jRPPsYmvIEDzkkBkx2URNxaz/clJghNkQ/lILndjKcizzuzqX/6tPfA7CJMllgsLQLd4N4dsShW8zMr5nO5vO3PVRLbQ1KBPu1yL+kpEVgFnAPCEJoRPEdJHGKnzDRXm11HaMYDDfzLCc/r1OW5autsVO4/lNC+xsPO4iFL3UY6XTWHZ8yD7nto4GuOLRwJHC4VBZbpTkwNoJ+SBqKVPXhsbm220xTqy/urnHNcvcdMUlDWFvudkKzzggdstYNTLrWs2UQkwmoSv1XA5mc3NgXOfnZA8mxg7kJhfECfrAMQBV1ESs1HX6W7GZcM5MGcE9UYV4ph/EA5UpSJaoHf8+q7N0VLhiYvvI/ir8H2rEi+DwKCCkP5Ds+ll7rrc2vXW3xHhdB9wBaTw9QkYzYJZLwk8yKQRKA1JUsGrAaSjP0Wd9ucEbonbSgXRrkMkbdAb0oO/TifsVy/69hNjMdua8ngWCsyJAr1sVa1LJV4V6wkKjd1qwyHVJWpQ71+cFBoRk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(7416014)(52116014)(366016)(6133799003)(18002099003)(22082099003)(10067099003)(260925021911599003)(260925021311599003)(260925022911599003)(38350700014)(56012099006)(261009223027099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFNmWU15VllEM052R2hET2xzVEpWd3doV05TOUdOS2V0TVRlWWRQWjcrRVl6?=
 =?utf-8?B?Uy81aFNVTzFoUjRBbzlXc3MreHltVXZJa2Q2OStEeFFJODlGTW0yd0NvYzY2?=
 =?utf-8?B?LzdxWHV2NXhVNXVwVlF2dGFuUUt4ZXAwUWNLZk9TMG8zalE5RkpxZ3BlQ1FV?=
 =?utf-8?B?eTlkZ2gyZjlvNFQ2ZHRTUDh0WEhvMi9DRHBTZkdtdmhncUtMOW1nU3RNOTJL?=
 =?utf-8?B?QXhNWDJMRER3ajNqYXFqRDU0bGVXdFJmWUZ4L05NSkR4QjdJZEI3a2dZc2Nl?=
 =?utf-8?B?d1piQUk5RWlDUk81bmZwUE1SMHUzdjJMcjB4WFhaYkVJTlFQMTNMaU82V2Js?=
 =?utf-8?B?cXBUWlZlaHBvQmFZalk1bHdEZFhVaEJqQTdoVFM5ZFNTeXY2YlF0SjVzRDRy?=
 =?utf-8?B?RVQ5QStNUmI1aEl0ZlJRSjBxWU9HemQ4ZHdUUDk0ZllMb21SVWtRcndPcTdU?=
 =?utf-8?B?bmwzcW90TmN1ZFVMSTNZQzFFaTdqZTVuNm02bFprbWF5OE5TTXh6Qm04cTQz?=
 =?utf-8?B?cTR5cEVlV2hQdTVESkN5YXJhZ2N5Z3g0KzMyYUhsakdyMU9sMzFsK2FUTnJ1?=
 =?utf-8?B?Q3VUQ00vbGxXTDBiMGRJNFB6RVVYTnNRSFc0Z1R2RDV4ZHV4NXRvNUM2VE9j?=
 =?utf-8?B?U2JJWWg0M3pUNW5nVmpiN3VmeFV2TmFjYkNsWXhHRFBiellGTHBody85Qk1l?=
 =?utf-8?B?R0RiQ2VWTFlKeFE1U0wrM3prQ2tWQ1Bpb0dpOWxPLzl1cGdUSEh6YkVkSlVJ?=
 =?utf-8?B?Q09hcXNqV2RmTFRPUG5zSW1hOFYyanU4eUErTmM4TzNkVTBaVmRTNGtiRjF6?=
 =?utf-8?B?U1A3WVh5b1hSZVpSa2FoVHArcmFqTG5qNnpTV3JhL0ZYdVI5VElQMmMrVWEw?=
 =?utf-8?B?VFVQd2c0dElaMTlJSnBQbENXZlh0NE53RGJFanphR3pjaFpTUFpqRVc2Y0kw?=
 =?utf-8?B?MWNzUTlsS0ZzaHZxQW5Eait0c1VOZWdYT1RtMmNIam1oSzUwRHcwbERwcXFP?=
 =?utf-8?B?L1BCcnFoOTMvc2FmY1FKM2tvcVNBclU3MDdEZXhRTndLZzdNbHJqYnBhcDJq?=
 =?utf-8?B?eXp0WWFuY25ldGN0aEN4NVNrTGZZVDRsc1pnWnFFWTVyZWE4NldaYjZvYXVF?=
 =?utf-8?B?eGJzUXBUOWtjeUM3eXpINVJUNnVIWkt3SnNTL1ZNZUMrM1dKT0hhNHVtclpG?=
 =?utf-8?B?djBPSjZsVUVoUFVxQzV6ckIxT3lSVDNUN0JLLzFLWXFEMHNHS0NCV0JtZWhZ?=
 =?utf-8?B?bjBsNHorTU9NaFU4RXNGc05KeGFGSmlzeXQ4UVk1eCtweThvS3lLeGdrcHV2?=
 =?utf-8?B?WkM1aExnai9VdVdBb29wOGZqRFFDTTZaWHdRVmdLVHZQL3dmREdiR0N4Z0Q1?=
 =?utf-8?B?c0xtd2NEQ3VjVzM1TFpjK2E5a3NTRXRuVEhFTGJFWE96VEdTQjBCVHNSdmJv?=
 =?utf-8?B?QlQzcDUxa0pLU0V5L25laC9ZTGVtMGpFZ3N6NHFabUNSOW1kUVVPWUg0aVk2?=
 =?utf-8?B?ZGc0aUF1MThOaDlNeDc0QWVKU051cDBhWXJHeFJpdURSa1JwWlVLbXlucTRR?=
 =?utf-8?B?R2l1bWpKejVnTW9wRnVuaHdHSFVHLzF2VkFzZGRiY1VXaEx3RkI1czM4VlZE?=
 =?utf-8?B?ZDJ1WmtBTllaUnF2SkdKUnlybG1OYU5Ld2JyMUlMOU5jRHhmTWF3UUpMV2Fo?=
 =?utf-8?B?THMzTXdidWFmS25BMXJCL000MUpRSGo2cG9lUTdrMVdIeWtWdWlmcEpXeVVF?=
 =?utf-8?B?RVVnR0JGYTk2dzVuajk3aG1KV1gwcnFtRk5KLzhtTVUxclUzSzgrOVlxM2JU?=
 =?utf-8?B?R1VSSDZ2TFUzektGVlhGMmwyNEhabzVBRGJwREgrd0lObTZNZExpMm1heXpV?=
 =?utf-8?B?U0VERFF4U2Z5dnQ5M2hkUFI5K3YraVE5UEdzRlFMb002OGsxY2FYZHNpVGN5?=
 =?utf-8?B?bEZWN1RWbEJZWW5IZE5PL0kvUlFWTFZmanJXUWsrL29JVUJHRVFlMWhOVWpi?=
 =?utf-8?B?ZWRhd2UyTWxDdDRjUndzMXZLVmZIbmdEQ0FLT1NNZjg4T0hRZjZ5elFURzFs?=
 =?utf-8?B?M05xUndqTzhHKzV3RnBFZXQrUExhRFdjMGpacHZMd2pkSzJXSzFyUTdBSDRy?=
 =?utf-8?B?cld2eVhxellXeWF1RzhjbVZKNWNvRUtrZkhsYnB6MnYvY0N2b1haL1FDTzln?=
 =?utf-8?B?S1dnUjNzSXNJRkFZTGFnR2pIRlZrbTdSalB1eHhnR2Z3MTgrT3F1QWV0ZlZv?=
 =?utf-8?B?SWNNVTU5bzYzaXc1MGUzNitMYjAvakxXdGVIcFNxUEkrTUxIR0k3V2NPU2kw?=
 =?utf-8?B?M1V5aVZZbWxBSCtqamNrUk1zaTlTYVpKb0J1OG1PKzZRVytNNFV5NjJoQk9M?=
 =?utf-8?Q?uKYfpJO4DL8YuGfQ=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b22da8a-97b5-43f2-e569-08df284b99f7
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 10:28:48.2030 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mU2e2G0+dSMnp+eZgJ/r1RHDmZAJFkaMjKwecrWQTK+cAmMYE0TtE3t+lLY2epI+H7FF96ujRf49zqNlq0ChX9RKx5T0yHvLoz5Lsdfnabc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB11921
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

Run the existing cpr-transfer and cpr-exec tests with a vhost-vsock-pci
device attached.  There's no guest involved which is driving the device,
so here we only test the QEMU side of the handoff, i.e. the vhost FD is
preserved, the device ownership is released on the source and re-acquired
on the target.

The tests need /dev/vhost-vsock on the host and a kernel supporting
VHOST_RESET_OWNER for vhost-vsock, they are skipped otherwise.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 tests/qtest/migration/cpr-tests.c | 93 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 87 insertions(+), 6 deletions(-)

diff --git a/tests/qtest/migration/cpr-tests.c b/tests/qtest/migration/cpr-tests.c
index 05c2ac1336d..3c21b79001e 100644
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
@@ -354,4 +429,10 @@ void migration_test_add_cpr(MigrationTestEnv *env)
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


