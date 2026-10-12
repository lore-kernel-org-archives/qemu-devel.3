Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E25BECA9ED1
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 10:29:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGDHO-0007iE-Ky; Mon, 12 Oct 2026 06:29:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xGDGx-0007bm-Vo
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 06:28:50 -0400
Received: from mail-francesouthazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c207::3] helo=MRWPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xGDGv-0005FA-US
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 06:28:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BVfe0zLXMQ11VOji+x8L0tTBDXi8JeYE7kIwYXJi+cLGeV5IJnwtGMLnNlv/YU1pRLOXBv4xZ/t8FVE+dNUVjST4t4AIol+qd/RPkRY5Ol/SiVh1eibKwq8Qfw1K6Q8/ij2JVwKfAv1w7a9yG0RuhfxYhuOAoNYAnLvdFkUHlZp3ErlK13hkhW8NY3YgNQXVJC+GmQunE5nOqp78hDfgr8R3AUOd3fWvWurZ06wbDA3IGcFbqtTL/P7GtmNd6GmEjBP+zRXX5167aADz+UTsPvVGPesnOnvV06cWT5GMr/Xo/m9C8E5NSG0tuYu9Qx35rjl6EHeAfrh+rUgWRKmH8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CzhhEOopcN3KOOtfWAhLZROUNYy2FrEKLzdoJ27vb+k=;
 b=kI3pMfHEW3jbubbJNBMUhHPmNqWBtT6LO5qRpEQfWbLo7a7iAJ/LKn0drHkYe5midrMEc4NgslnP4b2Nwi9KCtBQgR1qnKP+MNF/MXVfgBi/+ipSY05p4XO3pfTwfWP4VMst5ew9dE0OKj7Q4CdjJJhntcRUT6TQu34yjjEIWFegSlwKrlW/kMyKyJjuXeK4D7EELOQ3zt2Vy650uBy6+m04QFpvuw+pWVCIfgGcjFuRT6XU1vVJnO22G8ESAuXjDVrSPXV+hsQfaX5JXNiMJzYPxgvdsPtqep0ImrQerziijZ51BVhw4WGmjgwX7cSKvWqithpKIhs8JEOQj4TTlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CzhhEOopcN3KOOtfWAhLZROUNYy2FrEKLzdoJ27vb+k=;
 b=ABHMFIHzk45u2VuzlcZc760ul24iYSPbZ6zZ3d449vFvXOJLWNxb+h62Vf0JDgSo8y6IzBE1JLwka8WexpyoJEPbyuv/fiLwCxjlobu27yw/ZIdFKjSPjXit5iJ46dn/+zx2Lf5o6xicG0WsrMAe5l/z9h8jpPQAC8VW5Ev6Qy11lqdw7mzYKDQMAG5rbfmI6C+kw8j+R6FgjQqjSgT+wAHpr1bGxx2YpnArbA+X4vaZ3dBK/Wi9LuaIJ2PhAEGfSJMaedL0p5iUDzyAT/73NTpQ5Z41ogU18AzRGO5x1HpTPo17ZkRTSTJDkK4OM9e1QgIG0Bi60rL4tvyBiV51Vw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AM0PR08MB5523.eurprd08.prod.outlook.com
 (2603:10a6:208:17f::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.11; Mon, 12 Oct
 2026 10:28:32 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0522.008; Mon, 12 Oct 2026
 10:28:32 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Mon, 12 Oct 2026 13:28:10 +0300
Subject: [PATCH v16 02/22] tests/unit: add test for duplicate keys in CPR
 FD table
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-up-vsock-vhost-v5-v16-2-36c38bd15ffc@virtuozzo.com>
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
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AM0PR08MB5523:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f72b995-52fd-40f5-4297-08df284b908a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|52116014|1800799024|23010399003|366016|10067099003|22082099003|18002099003|3023799007|261009223027099003|56012099006|38350700014;
X-Microsoft-Antispam-Message-Info: hD3rkgxn7S0f8dfn/9yijIkPSeoMRyiw1eFkVhuOwSJwijr+/oXojrd0J3jtvduHJ7YKRXymAckwzv3IIUYuMQIOUBADe46yUe4w+cGDfLfGu+/U4MRXk5hwpzUGwkJfOnXtvFa5QsW4hqo9YewzwUeEFkSVJuKBIejfn/Y3AnwCQ7hFZGO5sSS7cl87coJmmvdfQ14oSc1iaW8SeUKNKDvAYhP7QOPuMmuyzY3ha1YtdSBgY+WULpdiWxI9k1BZLBjpwrENqs1v+ikiLNSgq4bS3+0rv720pDiPtN+L+6YrpNf6JBVFQ+9A8wSINUFfyBFKOGhfqHj7aAu1XESZNyfL3054RHJko159PHR4Q65yCvs3m/P5I7G9sM8GSKa/glrYy6u6AxQ/O400N9qFHFsYhHrRQmfYFtkYD6iKW5bZRLuiKXn/SRqFhrwuy940ccTz0AWeFDubH+YU/SemfrbfuZ+giQFskfczo6RNe3eWOWMkWoeGzsXd4Yblh2nl5ndHm9vYUnFTrUgei+XwiuNl567lVShLqEaVulRKAhlLhVskK8FvmDcRIYlUxhTI8knuIs4oUHDWcdVsx0aF4lFck4KwLy3YWyR5v3wPcix6tfFd9BUig87Pr08IEwQd1BBIxolu+MBCdtH0mX3ks6/lHPETgp2ZjbRND0m7RoTZrZN3PnWhyqLvdTVJ68hNxygi6HfIYTuaH0ytq5rw48vka6LTx+BjAKZ8Z5hjjws=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(23010399003)(366016)(10067099003)(22082099003)(18002099003)(3023799007)(261009223027099003)(56012099006)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGdsaEloRUUyd0ozTVN4TGJMaTgvLzBTcUJRd1VxWlN3bTZSZVlDWjJmUmho?=
 =?utf-8?B?c2w1RUFrN1FxdDNiYWZBd0Y0Um5NWW1sU3dSdXo1dCtpdFJzVnIwNnJYZjlD?=
 =?utf-8?B?VG1hNGZVUVd3NlJjSDVCOUFWRndRYk0rd2hOU2Q2ZEljdzdPTW9wNmV6d1Qw?=
 =?utf-8?B?dGk1bG1XMFY1ZGdIRUk2cDNSTjY1c1hacG12WHFPWHRnV3JicWNZdkdMWFEy?=
 =?utf-8?B?Q0pBZVZDajRsMVhnellPYW9nc0p0OXJZbW9pcE1rdzB3dGg5bXVUQlR0a1M3?=
 =?utf-8?B?emJBeWk0aVdkZFNKUzFPNjhzMWxWaCttSThDV1pHVTBzV1pBYW1wbzZVWEx5?=
 =?utf-8?B?ckVqbEZTQzFrVG1jeDh0TjZEUUlCcnhwaHdwQ1Q3VVVsc1NVTnAwd24zbFdo?=
 =?utf-8?B?ZDVHeDBLUlRIcWFjd0VlbUUvY21ac2ZDc0o3Wk5iUytqUDNpZHdST2c4dHFM?=
 =?utf-8?B?MjFlbVFuVXhoTXU2YWowcDJwZ0VmMk5GQThWY09KS09IWTErb1NBUkFXdFBB?=
 =?utf-8?B?TFUxeTBkWlh1QUx3TUNqMllpOXVrTWxNQndrbjB6NHgwSklRL05DaGhIcXFv?=
 =?utf-8?B?OWp2eGJHaTBSMGNPR0pPelRUWWs4bDJVZ3JOUFJnL3VGdkNJZHVLdTU3Mzhl?=
 =?utf-8?B?Ymo4ZmIzTHZlYmpkM09vRGQ4L2NCeTVMOW1sVlVqRW1OYzFzV1lwY2lmUXVU?=
 =?utf-8?B?MFB1SWtINDEvK1BTUWdwL2R2Zm9xS25KTHNYVDFEMXo3Nkdpc1BTYnF5ZlJ4?=
 =?utf-8?B?NmlRcXVqSTRveTBnaGpQUjZCakZwUCs2YWpLcW80b0ZUNW9YaUw2WEY3UFRV?=
 =?utf-8?B?SFNoZnp0Zk93VWYwbUpza2JCQ3NheFV0NE5PK204bnVwN28ybjN4REFJTy8z?=
 =?utf-8?B?eXZtK2dTWG9DZjlmK0dnT2d2UFFXL05DaWdyOEFockkzSFVPRTdaamw4WUZx?=
 =?utf-8?B?aDBiTGFoSEdxMmUzT241N3ByWkpQK0Y0bzJIbHNHb252ZzB5dUFZMEpCc0VN?=
 =?utf-8?B?blo5MnJOQWZ3VVZCRERndzZFajZIcHh6Y21QNVNySHF4akN0bWhBSVo0dnVJ?=
 =?utf-8?B?UnRxTTJqekdZS3ZKMVZQNFFkWFN4RktTckl6UzRQeXZBWVNRd0REczc2U1Nm?=
 =?utf-8?B?QmRBcmxUSE1yOUJETkZqQjRwdmJEZW5WZDFGUkNxYzMyL09UZHFGbkhXc09o?=
 =?utf-8?B?cStuOGpXTkdsTlNnVlV6OThwNFNYWXNNbVpQUWZkOWtHYmRva1pCay9Wc2tK?=
 =?utf-8?B?V1o2TmJvOEhKRDBLSDN0QnM1bEVtM0NrbU5TSzcwN1JFNEVCaTh4dTZOSkVE?=
 =?utf-8?B?ZnBwK0pJZ1JJZWdwUnFIRHl5Qk5GWnNLN1JCVFp1V1JPY2xFZEh6eHV0TWlJ?=
 =?utf-8?B?MWRNeUxOOUVQYWRuMFduMlpva3NaVmgyN21JQ3IyaU00cFprc0hhbEw1UXIy?=
 =?utf-8?B?RXpWTGFoU1RKQlFyRk40VFMyUzlYWENZR3JacW4xczMwa1M0ZDR0SWgwYlJn?=
 =?utf-8?B?NDFuSm9BLzAxYnZzTTJFY2o3M3crQ3ZwdU5FdEdsN0Y3UHE1VWxmVVpXRW8z?=
 =?utf-8?B?YUxzWkFtaGE1MG5ab1BiUHE4b29ybUE5OE9rRnN3R2NnejMvOE5GK21LTTR5?=
 =?utf-8?B?dG9aYTliTFJYaHYzU1JDL1BRZFJuSTJPY2tGOURoRUQ1SGw3V2ZZL3hrVEEx?=
 =?utf-8?B?Z3VzajFNM1ZGZHVORE1EZFdpYk9lYlc2bHVWb2I5M2psRlhtKzdheUxZYW51?=
 =?utf-8?B?bzFCNWg2dHVEYnltalJQWEVWU1BKK0VidFM0emNCMlZyRHBHa3VGSHZMS2FM?=
 =?utf-8?B?Tk1sbldadzJBbXFuMlUvUHF6VEZXcUVOZEcyTzVudTBBYkFNRXJYOFJlVTg2?=
 =?utf-8?B?dHNBczdpaE9GSmJEdkF1cGlHczhSU002UmdZeUdZNzliSlYya0xQVkJmZitU?=
 =?utf-8?B?eGVDbXVkQ1JxRit3dnhGL1dNK2UzOEljWUZLTlBURXRLazVOWlZxME41YWFl?=
 =?utf-8?B?QmNzMERMc2FwZGtHem5uTHVwR29xdjRKUW9JaURMb0NwelhSakUxYWpsd2h1?=
 =?utf-8?B?bmEwTG5iWU90bDAwNGFidEhSSTl3QXBlakpRYUx5bExTdndacnZrbXdFN2R5?=
 =?utf-8?B?ODI1WDEycncwSFVDVDV4YUVwd2ZFR01aY0FGYSt4c3F5bTJPcU84eHB1L1Zq?=
 =?utf-8?B?cUNvZnl6T0RQNVpjejJOTnVUNHRxaFF5UzBwUFBVTU9ZVm9tcGNJUGNtUys2?=
 =?utf-8?B?M1hkaFJVdGc3ejdxV1dNWG5KeXZFMm9GTmpkWlN2ZllKeE8wdThmOS9OMjZC?=
 =?utf-8?B?WUR5eHZadXVXelZxY3p1SlBuMXdiYXIyK2FRUFFJUi9lQXd5UVNibGN4Q3hI?=
 =?utf-8?Q?fa57B6rdu4dWyA9c=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f72b995-52fd-40f5-4297-08df284b908a
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 10:28:32.4959 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tZoKTD1aj+iS5QSnM3DKoCaBltjLHChDxXosFDTDPexbeADKHREpUxir4blYq095ZX5dBmuLLbGLLuGzmRYHF03Qgynm0TUDUU2W/bwFEAo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5523
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


