Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA2E5CA5FA7
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 17:24:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBbYd-00064o-LK; Tue, 29 Sep 2026 13:23:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xBbYc-00064I-BD
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 13:23:58 -0400
Received: from mail-francecentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20a::7] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xBbYa-0002kz-Gc
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 13:23:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zKBgcVYIKuhzFjTlboteIuiifvzwRskP2KPEJBhYbfq1ftE4OflcYOASeFYqc1kyRPa7VVwHTBVbI2cf44Lz9VN6caVFyn8C0SFgC9Xh0R2VIJwJbQVJHgxMMvbfPtmVzBY+tUBZsQHeMj/7QiHRSO2xz0rQNq3TPwqDksqlIOr13CdKqlfgusthfGiTRFCaKkAzuma430YFQOEFqnQUnWD9RovjWy6Rm/lTbhD2EkoQwtP7uB1jxKsonEmzmeTgjJCRAw2aEcN8qIasSsG4lKd72OGerkK/8d8b2JF1kBf0HjNdjcODSsVqhUaFJqfireY4vlRSzyE2bKduk34f4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CzhhEOopcN3KOOtfWAhLZROUNYy2FrEKLzdoJ27vb+k=;
 b=uKT91q7inqQdNPnWvo1j4R7+otqZQNYIT7wC2kjZ9zrnDWfggfxk/TPX+WIZqisYo8izS85UNguipk0KjMce62k8B+ffJ6Yy6Fj2sZX96+NSqMVARo+n/qyLPV+r2brI20GyHklgTTzJBfYL8h7WK07UxtYI2hTCdtgKNAkAWJrNFLGCab7J7TEIeE9bdpSY2Vusg6GUIrRxj+dcSl36lNVjr7l5XClz1HhuIVpKpR1hyIye8uqGR9FP+t1YjzgoE5lY38LO9m1TjdL0+amCEK3J9SqUCUT/P10hBK1r8vALBCBmzvGCSrTKE+Awj8SS8mw7JLtmEn3roAF4o2m5Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CzhhEOopcN3KOOtfWAhLZROUNYy2FrEKLzdoJ27vb+k=;
 b=0O2jHIFVO1JFei9TwOq1yF/yUFaFP3Hm4d9q68h8Rj19FDJya8JJeo9qXsyweKZiEfDs2WCJdnQGAS5182wkixNczD5506bX4VZGboak/ZoAb73wnoLLFxd/tr3rJLkccLfmsaqOsB66Xm5cm8zHACucQdT2hdNqwKsQZF8vi7bgk681ob4w4eTSgw1OfeeDwHVKk+h6OTe9gmEtCavtIN9Kl6v7qPyshOQSCUQvY9ma+9wbGHExHOnB008Y7idjR9wf8fa/am/FPZ7scfE9NGFBYRujjVJYGuIkJLjHxXg2RndRQMlsjJiC+bq2tJ/2213lqFxUsLgPB6WIHBR5IA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AS8PR08MB7910.eurprd08.prod.outlook.com
 (2603:10a6:20b:50b::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.14; Tue, 29 Sep
 2026 17:23:47 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0472.012; Tue, 29 Sep 2026
 17:23:47 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Tue, 29 Sep 2026 20:23:21 +0300
Subject: [PATCH v8 02/17] tests/unit: add test for duplicate keys in CPR FD
 table
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-up-vsock-vhost-v5-v8-2-12bcf1c0b84a@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 63781b8e-a071-4ebd-7e2f-08df1e4e6b7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|52116014|1800799024|366016|10067099003|56012099006|3023799007|38350700014|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 4VohJvZ17q6EO8kwlDMbobvdZUdylSDHasVtb7H5CEAbxzud3A7zBa8sCLLczKcck/cY/f7BBj+dqQHDfQi83NBrBs1ZAAkJtHq96QFAEnvJSmcRYlJiWvOS/A9gTIB5fVFqlW3bAiz8B4KqLevo/SZi35DtRFZ5I9Jmu5LMZD10kkviKW0BM1RIQmvh4KE31Oc3c+cf4s55R+9GTAe0UQClqH0OmXz8x8d6k/EBi9OrouCvQ9bqU6cDhaPEAfr6TA5rbDhuO6yVlvpYqKtsM4FPRp3/NsyaA1uQfna27M9A2D2oOwAz7YUitonKvHd5NgWw0m03yuKZKMeYvZOeWhVw9kMqbaV0DSsRmnGhS1HQmyIjixNJr3XXwhSM7euhgFHhMhFVeEQkttlYwXicUHvlIs37tbm9ghMexHYiYw0s8AaZOwKdpemLP3QomzKgW/FjjRu0p8q7Y9i0Ngy1VBMQvMqaDbAdb1pJ5GYlbtnqy2N1QoLa6fyzYeHbs08vkb4dPOzWbYzZtB2Yxr1g/htqrKojl8VShFWl/4Jx+32bpR44VOkTL4H+t9N3ZtWCM2rJPk0L6xCOLgMkwOAqC6Rh6q90KHgh6lNB80+MPKm5w8RrCZ6aJBkfsKLUgumABPjbXTH3E5hAccnAQebkg9tM2/7+LBh8PLY3PR2D2xq68ft4SfGnhBvVbzjTdpCQ8CW6m1P7I3GWRXupCCEDg0Je3sm5GdpTLvXKB7sXypU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(52116014)(1800799024)(366016)(10067099003)(56012099006)(3023799007)(38350700014)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHowYlQwNlZDdFFidmFrVm5hMHZsTm9yUUpNMUV5Tm1hR3dXc1lPNEtDdTM5?=
 =?utf-8?B?MHJSVzA3YWozZnZXTlJkTmhJeFFyUmtaR3QzWUFMcGYreVIzc1lpS0U1dHlE?=
 =?utf-8?B?ZDhiRzgveFB3VjdURzBuWThPQU95OFBFazBnQVJ1TjR0WVI2MlhZTEUyeWdW?=
 =?utf-8?B?QU9aM001YVFPZ05QdHJEU3VvVHZDaUhJdGlHMjdVVHdXeFFVT0IyS0FlRmFr?=
 =?utf-8?B?SVRKeDErZXlHa2lPeExScElSVnkrMFFCZWx5NU9DL1daTG93NlJ0d01xcDVn?=
 =?utf-8?B?YTBhQjVPZkhjbUpYK1VxMGFoN2E1eFpwMUNpeGYyWEZLbnZjY3hNOGR4RHJw?=
 =?utf-8?B?eTBoKzd1NnM1QUR4SGtIemE1eXZocGNBWTNPb2xheG94TW5iblZqWDhDLzNT?=
 =?utf-8?B?QUU4blRwWXRweHpjSit4TnVTNzlNajZ2RVpLeXVpUTZ2WFp2dXF5ZS9DOVNN?=
 =?utf-8?B?VUh6ckYxaU05dFUyaXVmb3k1bG5hcXV2N0d0SjFKbzdVZ3lCOEh5ZDFsaVBw?=
 =?utf-8?B?RVZCTmVzcjZqRlJpRmRrVlZSSm5GY2c4TFdOVXlDTmozb1pQNGVGY0t1dmtW?=
 =?utf-8?B?cDU3bDlxT1U4WC9QdkdJcFVwOEN0RDg2UWdGSmozK2ZGVnpEZHRxM0NNc2lo?=
 =?utf-8?B?OWI3ZjVQYnJXV2hrVUdFQklFdUtRZXVDNGxndHgwM1p3eTBWQ2w5aytCTUdx?=
 =?utf-8?B?T0xPdm4zbXF4OXh2dU5LL3RwbE9UTHJSUTJ5Zm9wNGliNmRMVW9KZy8rRzhM?=
 =?utf-8?B?WWY5K2FCY1hweitCRm1sRjRDTXNJM25maHZzUU0zYVQ2MW05VmJMY1BGd1Vz?=
 =?utf-8?B?ZGlZV05nZ0s0SFJCek5idUpqN1JXamVGTHh5RkdoYlZuekEyYnZtSURkOWZ3?=
 =?utf-8?B?QzJ2bjFFMWkvOXk2ZnZQR0d4U0NPVHhqNWRVOElyMTk5TGt2R0FUS1lmRUpn?=
 =?utf-8?B?K2tndUJFbDlmR2FGMUw4djZNUXlBSkYvNzk3ZTZWZ2U0RUZhS2RRM2JPQ2hy?=
 =?utf-8?B?SFBpdjNwdURQOE9mVmtibDlCL1Y3eUs2ZVY0VkpkV0hRZjcwQjl2eDlsV0xU?=
 =?utf-8?B?R3Bha2RXVGF4TW45QmxESTZhKzVxWmRSMXJJMDB0eXBrcXZSMzIyQndVc2c3?=
 =?utf-8?B?bnUvemg5aUJJOGVZb3lIUkl0byt2S09Vb3I1dG5pRUdqR3ZnWXo5WDVVVEZP?=
 =?utf-8?B?WE53TkpkUXJFb2U4UitHRlhnTmxtenpuNDAxc2h3bGVnUlB6QVNYYTVYMkJr?=
 =?utf-8?B?WTUrbEwrMFJuWFNXeVZSZ0hZeEhkOUlpS0RnL0JrVzNCR0FHclhpeGVhdGpO?=
 =?utf-8?B?RmNKRUJNVGZ5UlI2WDhxY1Q1NFZyb1ZoUXBaNU1JanhvajFHSkRLYnY2Nm1n?=
 =?utf-8?B?d3FrUFgyNzJ6SVhaU0J1aGwzaHdLRkdLWmdHQ2FydnNpeE1XNlFCNVg3L3Bq?=
 =?utf-8?B?LzdieFhmdEtVOHFtbGRkTnBybFl3N2N5Ti8weFU1aDk1MkYycWZUc2Q5L1hI?=
 =?utf-8?B?cnFSV2VNMHd0MjVUNWRTMUx5c05CaG16MXNNYTMrd0Q5bzRXU0FMdUQ2YUYz?=
 =?utf-8?B?UkVza1hTUXcvalN5ejVvZ1VvcCtsTDdXSE5kMkpyOW8xbjBhRzJWK1hTT3ll?=
 =?utf-8?B?UEh0b3ZVTGF6dUk2MnJRdEVuOXhuVDUwSlE3aU90RHJSczFqRDRxTXc0NXdj?=
 =?utf-8?B?TklXMXFOamFWSzVXcFYwUGs1V0t5WkRaNG5vYjJRU0MwSi9sMzltSlk4LytM?=
 =?utf-8?B?a1BBTzVyUTQ3U0hyd1BKNCtZWnJ1cHNJeHhtMU01eEdVenV2OXdVb1k0ZlJW?=
 =?utf-8?B?NldsWXNSMXhPTVFvVUt4UndFTlNsV09XVXlnaFlzVmhmSFlDYTFJb2NXeitn?=
 =?utf-8?B?NEhzS1RnaHljQXZURW9Td2NKdlFXZmk2TlUyWWdVQnBpZW9KN3o5WkRmRDY0?=
 =?utf-8?B?RFZOMXhzOFZRUkptT2U2UW1GZ3o5YzFMS05iUS9KUjdLNHJoT01hcVY1Szlz?=
 =?utf-8?B?a1k0TENOdTU0ei9VZ2IwMXl6TTA4RlRZTXN4NVh0R2VyOUVkTkpiU2I1dklL?=
 =?utf-8?B?Y1puaEkwWkNJREpMV2xUMW1RZFlZUTRRQ2lzR3pMVGwvSndIY1BEbHdyMDZv?=
 =?utf-8?B?NlhLMjE1UWRDT09mMnArNkZVYmNzbldmWmppZ25BNHo4cmpCSEk0dHlIKysz?=
 =?utf-8?B?VzdDS2c1L3l5NDd4Y1pBWTczWDQrRkpKYkFLa05YQm5RS0ltMkhPbGNqK2cv?=
 =?utf-8?B?QWtwMkZpRS9odElCZ09qZENyeEcvQzJLVVFxeU45N0ptWEpvcTd2ZGozdmFB?=
 =?utf-8?B?Q3YrdWxJV3YrTGxRYjFDODlzbTk4VUYwQ3UrdFZIbFE4em95cXVNcWRsby9J?=
 =?utf-8?Q?I5qYxp87YwNBf+iQ=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63781b8e-a071-4ebd-7e2f-08df1e4e6b7b
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 17:23:47.0347 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hwGANYL1tedRUUbZOsaZaK3OEaIc8pWXaewaxiFMlCHS5eORJa6Fejx9iVgkw44pIqNZJegQI6WEGXAd9f/GYA6YDRHWrDg16+CS4DcxJGk=
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


