Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62B26CA5FDD
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 13:03:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCcuU-0000qH-Ow; Fri, 02 Oct 2026 09:02:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xCcuC-0000nW-K0
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 09:02:29 -0400
Received: from mail-northeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c200::3] helo=DU2PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xCcuA-0007Qg-Vd
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 09:02:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qdEsoalSiLwWi6/gQyEsWNeKL9BOlg7NGSFkIJdC2FTY+J26F1K0A1LncGp41FjCCxWfqjBUVXplC5ztUysVHg78xX9PFMc6TwoNiokWoLMy6qwNj+15FpEw1DULtX3QffpASyCLaAgrVGYx44+mK950qdX8uC1Tecf1MCFaEvGNZz8jTLiZyOM7K+yg8PS9DQwDdBoQQyWY/yfb4SiDwBjPnn/v0+jEQhJjkms+nVO1QkYg1Hvp3MY7VpyG77xX/Q1xaRLE86Q8JJlu6+NVtXoOOMyu5PQ1bZYJoHAg/48J2PnMer04XiY7coomlbfUKzA4Sbi//5G7TF5zcqYocw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CzhhEOopcN3KOOtfWAhLZROUNYy2FrEKLzdoJ27vb+k=;
 b=rwsvhylRORZaa4Krc+D03XNDKqxCu533RU48NFOyCO0hC//6HG2ARNI+jVKOqxRj3kJORl0vQA5y4IQ74TCe5MyPr7at1fJD/y6WEMzo9CHDibaxpZvVpaLXYW8+HsLbdSGnHSAFMmCsHweP/e8PMKxgLamdQ21kf+eozzCAeQ3iI1kSkRMuaSHNCRMHfixAQn8vIHGWOq999PncrzQN6cX0gA3PkYNKfnGh9aSfhQxIyVae4eBgcIcKT1pagsRpCN/+3QSfbjxo/3bM1+lu8wSYFoMQadnYTpWk7CkSGjlvUulUp8Nj/48lGsc41t4n0QxHBkEgwLC/QhYbhxfclg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CzhhEOopcN3KOOtfWAhLZROUNYy2FrEKLzdoJ27vb+k=;
 b=zxccnG8c2XPhk6GUbPzid38oTmFUAeky+JV+ZRREucw/iDi60L2WN9TMu9l+QCOHOTKo8+8NT0l27dA8qBlTIVX9OvJlNm6IB7QgRD+hdMJG1CKQzyjScaYALgmE9jXr4YTVLxfIhehIJ3JvALo6JdlY2Nl2I/oUnKNbWe/QqPQf5TMVBndez0E/+VcLol5t1pfhVNmXdDU6t8ZA9Of0vBozwNzO19XlA3GRk+7lqFwydBM54TCLgbuge5oAbuWQZiLjrhS8fgyNltZGCw1RGSjDHXHYU0mlSaRFS8YXfldEL2awdC89bwB8cWBccnWF/5Kk7g2G1bk7qhJJWXT6Dw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by MIWPR08MB013052.eurprd08.prod.outlook.com
 (2603:10a6:290:e8::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Fri, 2 Oct
 2026 13:02:21 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0472.012; Fri, 2 Oct 2026
 13:02:21 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Fri, 02 Oct 2026 16:02:11 +0300
Subject: [PATCH v11 02/19] tests/unit: add test for duplicate keys in CPR
 FD table
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-up-vsock-vhost-v5-v11-2-18fa09d8273d@virtuozzo.com>
References: <20261002-up-vsock-vhost-v5-v11-0-18fa09d8273d@virtuozzo.com>
In-Reply-To: <20261002-up-vsock-vhost-v5-v11-0-18fa09d8273d@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: farosas@suse.de, andrey.drobyshev@virtuozzo.com, bchaney@akamai.com, 
 dongli.zhang@oracle.com, vsementsov@yandex-team.ru, philmd@oss.qualcomm.com, 
 maciej.szmigiero@oracle.com, mst@redhat.com, dwmw2@infradead.org, 
 mark.kanda@oracle.com, sgarzare@redhat.com, den@openvz.org, 
 odaki@rsg.ci.i.u-tokyo.ac.jp, peterx@redhat.com, clg@redhat.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VIUP296CA0042.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:34d::6) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|MIWPR08MB013052:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fce9306-f35e-48a9-db97-08df20856538
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|7416014|52116014|23010399003|366016|38350700014|10067099003|56012099006|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: XLQ+yXZ1D+Bf7GB9X2w82JMP4Uw44X37/Gx3gnslyLqD1ekQ6CTzAXW3N281n/DNB5W2pvEKBc6ssG5cXKhKPYLRW5Y6QTcUi9ja+m9vlhCsojLUcSgzYEFIn8xJR4D9MDSwwu9fLtL2rXlmFROeS8dGe96wO2byt6Y4M5cXIar01t4Cm6ypTttZmxeKmf/9RerRJnKzn4hzHHRHeFe4/eymDRgBVhCNRpwhT+kbIrBDS6cuaImqdLwqn36YHz8PFDhOslqndNNHJJYtOA3/xR2N94HLAqx4MEJjodO/kIYPYLacJb5qVBV+TYpx8r0O9tRGvJJrMMt4w5oSwjATb5/5Dmw9rVbUihgEs9i2KFFi0JojfVyvDDCLcjNQGiWsdHw/50tRje+i8GHB3mrwvfRRvqS8Sm3BOFSPiGK4DGfcQpJc5DOLYm7Jgksz36u2IINn8uv3Nvg+d85YNgWw/hja87HhZJ2ahpPreMnfwI/IeSFjIFahgomJciJCB5rC5j9BMYceV1VfdZNP+EPNZl4NH6I64WxxC8+KEffJxSsM2XFJHzkjpFTI9FRqAWvzy4HTtqEtQlEAGqwaX7Dsw5YyunEpqzTXmGGc4hTD2k7+dpxWNQ8X+Pxn8iWr0eA5YQ10QwUqavyfZffT80bOVdJiz9UyrrgJC5ITGbzrSsOU9F5/fs88eTQp62o00kWMYAeKeR3Rbc8rdwQj++gCd7ioafn/CEUxihleDR1XqCA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(7416014)(52116014)(23010399003)(366016)(38350700014)(10067099003)(56012099006)(3023799007)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWJMUmtpZlNlT1NPSFdJeTU5VkFNbGZhdG10RTlESHRmODc4ak5GcENVa3B6?=
 =?utf-8?B?c2ZteTVKUTBFWUtseXpScjByTjQ1TklaQjNlVG50NTlPcHo4VXJEd3FKekVE?=
 =?utf-8?B?QTY0MGNrM2kwMUV2QTZ0Y3JzRi9LYkxMc09iQk9FQ2dLQytDOHBDMHZOZVZ2?=
 =?utf-8?B?bUk1TGV6b05QVEtaN0EveEtCazh5cFB5MExOWmJIRnM2MDYrREsyRVpmNlE0?=
 =?utf-8?B?RjJuYW8xVjhlU2NFOHlUeHI2dWEzUzFUemRKV2ZFekRQNTNNT1B5NXZOdnhs?=
 =?utf-8?B?RnlNV0VZWHcxdWtUUHRxNi9vR3MxVnE5WVBuTVhnZ0RwOVRvbENRVGZtdWtv?=
 =?utf-8?B?dlJqN0hXdjhmTkN4MitzUDhNMmp5WWZ3NUJFY0VpRFdHNmw4OFl0dFM3QmhZ?=
 =?utf-8?B?ekxpNXNvamtmdUtyZXlodXd2MDUvVEpCaFpqMStlbGtPU0I5WHFjQXNZTUZU?=
 =?utf-8?B?aWMrbHcreUQ2bG9wZXpYeHh4c3c1bDB5SlY4eWZwMWpKUVZ6TUs3dEllZUJB?=
 =?utf-8?B?bm9NR1BvRDhzelpVMUVsZnRqYi9COWw2ak9yT3NmN05WRS9xWldlVTI3ZU1V?=
 =?utf-8?B?Uy9ITlB0ZkxsNGNuSWJrNW1tTUdrY3RnaitCZ3doQ2RKYW5lNCs0WGFlM0J3?=
 =?utf-8?B?YXVkNm9UOXl2QnZVbmI5MWVDaldXUXQwdHlUQ0hqdDFXK083Ujl5QkpUTjVp?=
 =?utf-8?B?SkcxUksyakYwTUltdDdjMWk5MklJalZMZGJJNW9NMVFFVjZOdUt4dGFQRU1E?=
 =?utf-8?B?SE1VSUV3djlKZkVBOE9ZbjRodkttYzFob25mY3F1YTRVaHpkQy90cXNLTFd2?=
 =?utf-8?B?VDdPY3RZUUJZN3dwTzFPb2cyRmoyS2szeXNYdEpuOForSHNuMzFlY21hN0Iz?=
 =?utf-8?B?VXFsSDNRQys1a0FZSWF6N2paYmovc1EzNWdNRXlEWTU2d291T0ZveEtBMFU3?=
 =?utf-8?B?Zm93TG5Rc3pxVnZLR3B6SGNUenF2aHpGbDR2N0hOVVcyVGs2NjA0a1g3dGJ3?=
 =?utf-8?B?S0l4TFNxcFFNWG5IV1JaeFpEUHhRbDRvbnJLZDZCcTJSYUpLNTBXaElzSzhu?=
 =?utf-8?B?WlVod2RiUVN6UmhxOFhpdTdsSjNhVDVtUDc0aGlaYTk5MUd2SEN0eGx0QWp1?=
 =?utf-8?B?MGcwT2cvSXh2OEhVbU5xa2MvNitqdnQ4M21BaVp3dndVQWd5T2xzNGhxY0k3?=
 =?utf-8?B?Q3BYTUg1MEx4U3BFL0tuSW1NMGk5cnVidndvc3dpWXNGRjdDRlhaM0VITVFu?=
 =?utf-8?B?K0phM0RSNVo2NHpCMTlvV2crZmhRRTFkb0k2dnBFcnZLbmVpckdPY2ZBZnVX?=
 =?utf-8?B?QnpwSmRpc29VZ0xyYXVLMll1a1pSMnEyOEZ4cWdOQit1SmVIbHNBR2lnckV4?=
 =?utf-8?B?QitjZFF1enRzLzB0MWo3S1l0WksrdStzZ0s5V2k5bzNTNzNuY0NpQkdyVXVG?=
 =?utf-8?B?bDJ2MTgxUjIrS25acEhWbTNjNDYzQnhCNmEzUlVud2JrZXVDUlNzdjkwdE5n?=
 =?utf-8?B?MlF4UitXRG0xbXZ6SXU4amZiVjA4TmtOeTVyd1BhK1R5aXpjc3hFNGEzTkxo?=
 =?utf-8?B?QUFmdjdBUHgrZWQ5d0JUUHBnUWpzcGlkZnA1YVdpWTYxVXVEd2gvbWtlaWRh?=
 =?utf-8?B?YVBhRndTSTRUeFpmNGpsTDk1WVJ4MkxORXhkcGJqNVp3STdFRGlBNzBURXFY?=
 =?utf-8?B?T3E1ZjMyVWV6KzFKK3lGbllEK2pZWnUvTkFHYWp2TW11aUI4YnlGdXNOUy9Z?=
 =?utf-8?B?d2JHb01Edlc4OU9XcjkxWWc3OGpQTTlhaUZaODZXVVRRSVNhQkF0L0o3cXhx?=
 =?utf-8?B?TFE2dmpyT0RHdHh3dGgvZXFmOU4vWHpTY0NtM1lFVXJKbG1YOUVKQnNwZTUv?=
 =?utf-8?B?QzdlV2hmSmtYalJuQzhINUt2RGN1ZkhuMENmaWU4QlZPekdNcStDaEwyS0JG?=
 =?utf-8?B?VlREU0kxVkxtZzlsWUlhckptWUxaZHNyM3J2bkZCSUdvbzYvbmh5RGtjcEZT?=
 =?utf-8?B?MVlLeTBJSXRrbnQrRS85azFtZVRrNWQrUXh1S2xBVHFMeUNKWVpZb2p5Z3F1?=
 =?utf-8?B?WGhMbnYvTHlyajdYZjRGUzFWZnlwaE1FQnVmVWVpZWV6bzliM2ptZERZRzJh?=
 =?utf-8?B?V29VNDIvcHE4YkU1bVV3eU5zL1d1UHM4bHJzcU0zV3RUY00vK3Q4WlRMVTdL?=
 =?utf-8?B?WDR6Y3c3WU53SVU2MjF2TTdhNmVXc0ppNlNqb2Y1Z25kRStEMVFML29HdFNQ?=
 =?utf-8?B?NnR2SFYwQTJVM0tQRFhFOEZIblExTEVGWUNkcVdReEVMUlpQN1JFdTl1bGRO?=
 =?utf-8?B?c0hLcG95TE9FODBtMFYyYmY3Y2VYeEpjTHh4ZFYyNS9VTFdZbmdJVHJGSmx2?=
 =?utf-8?Q?EggQx3beXVYtFZic=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fce9306-f35e-48a9-db97-08df20856538
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 13:02:21.2257 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iDKxcjkSVvQA5N8gYkuQfoAufOSfKNWFLGAeyk8pR3PgpdbAoLdMmRNoTSYlMfvIHod2eFJ657PEJKHIZTqjW1wwXVKRAZkyyrErbs8/yg4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MIWPR08MB013052
Received-SPF: pass client-ip=2a01:111:f403:c200::3;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=DU2PR03CU002.outbound.protection.outlook.com
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


