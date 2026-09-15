Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 869A0C88E75
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 21:01:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6aH6-0001Uc-Qz; Tue, 15 Sep 2026 17:01:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x6aGf-0001M5-Tw
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 17:00:43 -0400
Received: from mail-francesouthazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c207::3] helo=MRWPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x6aGd-000102-Uf
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 17:00:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w8hvw701H/L/hm76mshJyfjYhyla6yGPWtaAY5TvpmSQjBjf/eL0ylOAj4luugYp87/XKCk2ZPEs8tS0Dqo83VlQofklLq5x2WmpeZxiDJuY350t30m+1rhOg4o/Vr3aPA2XSr2Nz+wEqOgNmBJVkwuSGDegkGM9Jt79GElX9xAwUhPLJCkpG5mUBJjYa/p3IsG/nIwmKBIvfQ+SmCfDD3kDn1ZGCrLx/Ab4bROk94bx6kzqWdEHKIYcuXpDjiPQLPiPXNRN6eP1yuDhY/oGWwwwhuVnEsnRFjFt+WDe61HPz+VwNK1ypSuxJ10rfDAGVoWAWvjtaxN6Zfz+lWJlHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b1BPlhQEjh1ve1t5MaJwKpaCjZIQvshKVhE9sp4dYpE=;
 b=p6ZoJv2PqvEYRK9IcnPA85CLJhlRmF4leYE6rAuzDVu957uMsbohYdPHQslK+hP03GFBjHOxpbdPsN9HwMbXDQsA+NgVAguJ4HiQmiRUrQhq7slmO+D4xGvqERlXjn4ctB0XMPN8kJQ44dA3O8TZishBrUwZ4jPzllz7PPPuwQjrJM8CkgFkzzr04j4Q77o4Ta48zxxixKATtOtSCFz6l31PKhSTtM+AFdznJappPjEaklSIUoAe/jV9Z5aOBTHpklbjUfk158/0x3RING4HpWx0ihhiYuAYmYZoFCxFsEzOP81WijBmHCxLwY4ojp78FoA0hqqw2voaY8IYhiGSAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b1BPlhQEjh1ve1t5MaJwKpaCjZIQvshKVhE9sp4dYpE=;
 b=GZ3659LXgRdT0/ElYcYOTcT70M8sQ9ZZmtiIDQEbTKbWVhWEnAZLIVbUzRcQQ+7IQ1dtpE6RVGh6mWzWlCdjZR0FKnJDrIZR6ug6AsksWR/OEEtZT3YqhsYmR7WhY52QR1+YJOo9+PWvhdIv8kkESxiTbK3NWUcSaENCn4t7o17nX/8trJO6hWI7+THVqhBAYv2ilPxL93P0JDfcFOPeXpzXB6LqurVqnUnRP7JxPY7dD0hJHLJ76LuiHBMuHJqEc+sO1Xl5HqJZ8YMeI4hVjSclOjftJeX7g4GoHTNwpZd9Rd46j8MT1lwkYKLVVp5csW8p3Vl4NfMqJiXvzqXYBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by PAWPR08MB11454.eurprd08.prod.outlook.com
 (2603:10a6:102:50b::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.8; Tue, 15 Sep
 2026 21:00:31 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0428.008; Tue, 15 Sep 2026
 21:00:31 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Tue, 15 Sep 2026 23:59:38 +0300
Subject: [PATCH v6 02/14] tests/unit: add test for duplicate keys in CPR FD
 table
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-up-vsock-vhost-v5-v6-2-4d31b2dc6afd@virtuozzo.com>
References: <20260915-up-vsock-vhost-v5-v6-0-4d31b2dc6afd@virtuozzo.com>
In-Reply-To: <20260915-up-vsock-vhost-v5-v6-0-4d31b2dc6afd@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: bchaney@akamai.com, mark.kanda@oracle.com, farosas@suse.de, 
 den@openvz.org, clg@redhat.com, sgarzare@redhat.com, 
 philmd@oss.qualcomm.com, maciej.szmigiero@oracle.com, mst@redhat.com, 
 dongli.zhang@oracle.com, peterx@redhat.com, andrey.drobyshev@virtuozzo.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VI1PR04CA0053.eurprd04.prod.outlook.com
 (2603:10a6:802:2::24) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|PAWPR08MB11454:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b0a5e29-f8ad-4d0e-4d08-08df136c60bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|52116014|1800799024|376014|23010399003|56012099006|3023799007|10067099003|22082099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info: yJ+KWzazP2c92dEgWsr3ksrxvStSHQCy0UO6p8hpjVcGd4ayO8Fde4RJYop4r2qsnLjWN4+7eNnGUJh0HtPVyWc6fuWT5Ub7LlJOy6B19fCK+EN0ysOP3bjALHnwCRKT0ybzwVgD0U0AD7PZcoa0WGnV1jFee4Qomm/q3HTUWvJOJQh1nOEgd+e3V4VIktg5DkxFUL6QwVVmUNGdfx78mKq+MeDHMl54tQ/ExUqhXR841l9RBXPkcqVzUyoMbBXXdR3Etck39Sa+QCkYbSz7ZlStV3I6atk1DxEK8uCTcqtAjodPPiCPj0dA6YwWMOPer/6mMKLRUT2ULrolkQDKk4w/EfGv5Uos1Kaorrf1CZa3owD/+HZbcx4LdZns4esIYY0T/XM3g0eupMS4md40ZyeFJizPe4U5/kndgLECulBNbYA1GIqsfC8300vzZrMjFqdjBUZXqbs5rTYOxez4lqHaPHzQfuAg6YgP3SfhzfYoB67kpYHnw8QYR5ExPMZ80ZluM7NhfTGdW/OC/xGJyAzkQb64nsWYF816kwBhJWAqRopSC5A1a+r5sriWaWadeNZbSiBHbgmh5FkZiSW10MeR7tF4ChBOt3lnrVkUKfnluYNUKVhi/+dw8MrKm3d4i1bQKUwuw7buB8ICt8btrFSCdwpri+elB4zdzlQ0mThdryVOI1kvuha5nA4tkyEhg2F+aynyhR+dqrdsRQ+WS4xe+SBceDHZ8xksVz+ue+8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(52116014)(1800799024)(376014)(23010399003)(56012099006)(3023799007)(10067099003)(22082099003)(18002099003)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nndra1N4S1RTclVwUmxiTU0yNCsvcUptK1NBM2xMNzFjcldRSTlkOTVWQStH?=
 =?utf-8?B?dXU1cHZyWW5BVzd1aTZPWnVkL0x0UUQwc2VLSlROWDFFdSsvbUp2UVE1dmZz?=
 =?utf-8?B?anZZbkVBdnNsekJVdmNpbmpTWlJxRnkycTYybWg1SWEvaUhvamVzcXlSWnd4?=
 =?utf-8?B?SlVacy9HTG9DUHFzVXBMeUlScW9RRlp3MUl1NHYvY0MrSEQ3b2crWXl5L21h?=
 =?utf-8?B?WXZUZHNlZUR0L3cwTFIxbGk3ZjJidkRjWmJqcld5NG5DM2ZTb2tKMnpzSEJv?=
 =?utf-8?B?bjJqUFRQWGxGbzJNK0V5V1FmVm5icS8zTlh0bHU4TGpjeVNidmM5WWdpK2hB?=
 =?utf-8?B?YllFMUVZZ3B4L2NCUDcvSGx3dGFLM1NhRXlHQ3MvTFgvck9FdnBIR2dYVHd3?=
 =?utf-8?B?Vk9ZU3J5TEs1OHRNd0U0QzlFamE4Ky9wNEgvb1EwcFEwVHhVN1N3L0liUUVF?=
 =?utf-8?B?elpRSWhZNytsVFNXU3VTMUliRkllb0hZNTZ5LzJqN1pxWThETlVnTzgyVlpp?=
 =?utf-8?B?YkRLY1Bxb05kSlJidUMzVGFSbEVtVlRxdjdkc0UwVTZxM1VVUnlMNzBWc09C?=
 =?utf-8?B?aFBFZU9pc2VCYVJPRis2STFnNmdsdS9EYU1HSkV3SzhHZlRvTjdjd3JTT0E4?=
 =?utf-8?B?NHBReGNYbE9oVjZjR1VvQ0Q2MzYyZ2U0ZURCM1h2M2ZyNzRFWnhoUTBWckho?=
 =?utf-8?B?ZkZQbVlXK2IvSDljSUlvQVJnQXl0c2NrOHJocUdDTWJaNTBDZyttLzhacGZi?=
 =?utf-8?B?OEZtVHBleHdHSngzQU1ycGlPSElxamFXMHlBTXZtRjBEMmtJUGpCbTFDMm85?=
 =?utf-8?B?TDdWSG04V25WZCtkandMQlZ1NWt1YjQ3ZHQ0Q3pXanpwWnQxbFRpcG4vQitM?=
 =?utf-8?B?THlBc2x5aFIwanZVNHQrZThSS2F2MWJNYzh1cW0wNTZqdEc4L3BWRDZacFJp?=
 =?utf-8?B?QTdDb2Z4am1lK0gxYm5FeUlQa2R1azgxQktBVGY5VUNXaTI5UGsrWitPOFJN?=
 =?utf-8?B?U0RSckpZN0QzMDVzOEowRENtOERMVVluZTBRbitaRC9tME1CZWVKNFRnQnNq?=
 =?utf-8?B?RDU5bU52a05pMVA1S2lNZStSaXBoampsZ1RwZWZScFJuZm0rM252MTZjcjNE?=
 =?utf-8?B?cXhQdWRXWTQ1WlZ3T2o3alkzVHdVR2p6N3ZTckpqN1hQUnNhKzRZS2xja3Bu?=
 =?utf-8?B?SWl3WmR6eFdidEFQdk83ODBTMlk3ODIzSnVzcjF0MUd6RmhIcGpiZDBxZ0Er?=
 =?utf-8?B?cXJ0T1I3UFE2TGRWNUlBN0Y1d3pTc3RNWlM4S3R5bkw0NUE2c3RXYkNIY2NG?=
 =?utf-8?B?NUhYUUsydFZXRU1Dd0tQWElERjVTQU1MdGprQnhLM2duM1NlUmZQQWpFSm0w?=
 =?utf-8?B?dmdKeDk3ZmJsT0VtNUxxaUVuUGdEVFhwRTZXQzNGbWZYa2RqQ0E5Vm1BK1hG?=
 =?utf-8?B?NEI4Nml3SGhxSnl3d29sNC9QNEpibDBralhvOXVFWFYwYXFOOVROdWJtUGpy?=
 =?utf-8?B?Vk5ubDhncGc1bTdrWnBRUUgvM2FUYithbVh4bmZmVDltLzViM3dUeHRiUHRs?=
 =?utf-8?B?ZlNZZk82NkFnOFdkeDNYZ3FhMTlLOHpPYnRZcm1URHB2U1NMektQWVVweUky?=
 =?utf-8?B?dVRaQWljS2lRd0MxQjhPN2c3bDZXejJDT2xIQWF0ZElwcUJrRmErMUFuZ3g1?=
 =?utf-8?B?SjJQTUd2b2dmOVhPS0dEbzlRTlVCUFZaTzh5QjN1NUwzek5kMDUvSG1tQWs3?=
 =?utf-8?B?dTlBOW4zSmNySjNOVHJMWHJFVzdzY3VXb3pKVS9taXJiUlZ0MURxNE5oOG5G?=
 =?utf-8?B?VEw0dFB3WlBJTk9WVkxYMStjM3JSMGhZK0NvNSt0d3VrRU53TG43Y1FJYXcv?=
 =?utf-8?B?MC82c3llNkRRdWtkd2FMTDBuNVh0N2lZdzhPWU5ZYXNqd3lhajhRUEo3R0kr?=
 =?utf-8?B?bjhkbXNXcWZoUjJ5NXArWmNBSW1YMkVQbnBNRnIybmtPOXBzZGpsSkhDbDVY?=
 =?utf-8?B?UTRCQ0tKUFFVTEdpQ1FkcDJmc2hWbVdnaThEeUpQR1l2aGozSWRwaFM0TjBD?=
 =?utf-8?B?VGh0Sjk3NWMvTVpWTFFXc05DdHZLeW9xaUx5TEZUOTBRNzR3LzlOaEpoKzU0?=
 =?utf-8?B?T0d3NDJ1ZW5aaUlENkpCeEZzU29aQmVIYWV1c3JVaTh0NVg2UWpwS0NqU2Rq?=
 =?utf-8?B?MHQ4YzdtekxoTHJoM0NlY3RMS1ZVYXJqOXdmNElPMmJZa2N3dUNuNDlmSG00?=
 =?utf-8?B?TUJOQ2FkRGFmbHU4aGJXZXRkZUNJcFFBNGVIbWtXZlR6TkZGakZKMW14WHR2?=
 =?utf-8?B?QkNLZVZPbUpjVW44YXBSclErMzNjUGFoa09rTEVoODU0VUFRc0N2cTFrZTFv?=
 =?utf-8?Q?vmqrrKHhEPDCDkRc=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b0a5e29-f8ad-4d0e-4d08-08df136c60bf
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 21:00:31.1791 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: okMAU5JPIKj7g2ROp9L6ZiMkZtHMv4fJy+coFkVNA4BJyQwpBGwfQmkDQET52jK0IBPbLcMzoaOZaP+gayndFNOaihZaYEh8b0jbewo+r8Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB11454
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
index e47bc7225ab..8d229ff60e6 100644
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


