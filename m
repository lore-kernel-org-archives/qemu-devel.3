Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76315CA5FF0
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2026 17:08:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xD3As-0000Pm-Lj; Sat, 03 Oct 2026 13:05:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xD39G-0007GL-Dk; Sat, 03 Oct 2026 13:03:55 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xD39C-0007Ds-AC; Sat, 03 Oct 2026 13:03:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pth5xM0dm4o3AD1DqwLJHiKSQO1w/33qxbj9EiscigFekX5xWi++roiHc9SNJuEJ5cU4EqF8tr77SD/9xo/rNyZE6EdNZIbhfFhN4DYkZpYBFtJ88SjMv2cU2hny4KLNeMArP62IFEBB416DK0q4M7JNepaM6ARO9YWEnH9RnQsYxZQoSx6zQD//IAzENuc1KmEomgNbmA46wVEQsL4is5yPfGSwwPAkQ56VRrYhFxAvch4ZJfmdKMAZnD316wmRnCc+ruJp0S4r3uKPFuWfbd/t6ko9QkxpjQ76mekdqeOmsl28B2cCUOveGMk+/CbIzyx2x8WaxjPfejm6Y2Ta+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ptKTNmPcNCKuxW70KmXI7j27gJCTxhu92faVWTurgo=;
 b=jdW69gcTPRt/u9qT3BatpoIMZ/74ZAqpo6PiAHic43GvoBSy4aWXIYAjjARrrvbgW0WEl0w5SushyAMYtBC7Y7HvZhcAB1NFuUaFAeDPiE8vA81YRImAeH6KxeMNZ2B/p/gEsyxHwf3a39lWK6ck3F2vJD41CSGHGWpJwabA7oun4TmamfPSHw9erySQeft95yH+bj/PCB/KeGv69XNluXDQw33pUGHYeyrArgWxYvLczpRzTRsJA7IphkMHQtDsge016oQ+THqts+26O/ivO410y8lV/Ky1Y7nkYYeKHSDEjKIlAXyr4F56D4Mf3tSBfHx6s7VCl32rxiXqJsz/3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ptKTNmPcNCKuxW70KmXI7j27gJCTxhu92faVWTurgo=;
 b=rjGPQLAjRoovoCTa61zuxYE/oIPhsxyfWPR0XdwJgyJFGwQb/R7ADimEAhnrsXJ+2RN9MPr5BI+Ow/x6GaeS2Te/12r+SdnVP4mpqCph+nUtOQHMrxz2zW3wIIcnzeK7U7JDy6eWMH9yUhgrUdoQbMK4F2Pi8kDTkBTi1qMxO8Eq0XdpiRX5AkZIicajfE0+4vHMk4XVlMMB2OHccfEfY88j0CQtjDEHXh/UUECkG76RUBBXEJIi6TkRnIrRUqv/i+o5DwON+lCb8mF0eeX8Lr/PeR8LL9E9oAIFb9aExiO5tOEp11TAXeb9EdLIdkXJLxWrw90Xpc21AGAoSIboFg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com (2603:1096:820:da::11)
 by TYZPR02MB6993.apcprd02.prod.outlook.com (2603:1096:405:29::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Sat, 3 Oct
 2026 17:03:38 +0000
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215]) by KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215%6]) with mapi id 15.21.0472.016; Sat, 3 Oct 2026
 17:03:38 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Conor Dooley <conor@kernel.org>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Sebastian Huber <sebastian.huber@embedded-brains.de>, qemu-riscv@nongnu.org
Subject: [PATCH v3 16/27] tests/qtest: Add PolarFire SoC RTC coverage
Date: Sun,  4 Oct 2026 01:02:06 +0800
Message-ID: <20261003170232.2450916-17-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261003170232.2450916-1-bin.meng@processmission.com>
References: <20261003170232.2450916-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0100.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37b::14) To KL1PR02MB6257.apcprd02.prod.outlook.com
 (2603:1096:820:da::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB6257:EE_|TYZPR02MB6993:EE_
X-MS-Office365-Filtering-Correlation-Id: 148b822b-8290-4c99-9865-08df217044ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|18002099003|22082099003|10067099003|260925022911599003|260925021911599003|260925021311599003|56012099006;
X-Microsoft-Antispam-Message-Info: A+r/Wd8n5WLZKYwEbd0PnM2M41OOKWodfQEunEEu0FcffrB0ZBiLoDq0oU2OBBxdg+X1b+c/AeFTTuqmrJgBqG75VfHLd2WMu+BhtnEmEKaBCLrRjr2lHxuMQDN5v1mELTpoOCQ9dSnKpFCSEHMSlYb233xYeu/HHNtS0GlfGwjCL2Pb6+2bq1dogumF3SQEUL2avdNFCqnlITy81V8JDQFFwZKtm2HiMdPk/xyF5EHY5aMVxJZuwNf6RE57qAXVWclU9k6SCiQ68GtmQgegNIPNQkq+TtEiVVhZgrvXrp+k0MDGTn+F/fzAq529NdbTO3Gx0J5Dw6kQfasvQ00Ax7gQDzMBy1qhI0wSWTYg575v7izSOiQ2eWf1fhYIWmicLIEAMe4X0VYNk7aW+XAQxgxPBzGTcaTrjeSNKtWh62+6B9gLcKklIv5bTFQr792p5MFgklU5VJDV66zul9dviP0sFWSKIw7HCxnCEOCM2HwCBtD5kWqLDdchOaentJ7ltJYyhohadNoFXI8TEnwiTog0hytyTj4dknB31QnlM9zAP4/kXohvOQior1t9/tObkbFq4KJyI1yPxxBtxxVaCGz/O4aR4bR8IHZHFD60UKTPuBQbkPEC7mcycwQBgQOxdt7iugz3ckD2JpIWrDOAN07zQoKG5aCpcTivyyXAcdk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB6257.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(18002099003)(22082099003)(10067099003)(260925022911599003)(260925021911599003)(260925021311599003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?g7rBdIS6UhMvdjEhtH1aHHxN2IJBrRl8j3tuIIf/1bPa6Hva/uw7osnpPx4W?=
 =?us-ascii?Q?cm1A/C/uI/1Bcc2qjfhCrAwFY694a2ILRN7e3eWa5iH6plfdR9xNHPx+4tr1?=
 =?us-ascii?Q?GoQc0H+JLx5Zuw969v7Wnri1JsHE8BFIbNsbHN4K84D9Ee+TYzBZX1IXjRjC?=
 =?us-ascii?Q?NWuHlP7yHsPlRr6dVXoQ7IwMGFrOI8hGKWw237+0tsFyg2LwEt/0L+UiZens?=
 =?us-ascii?Q?CGlHnZPyGMAXLZH1h8NtG4mxQs2McEmko30Y7lnnNrqYtgX0EPAFI6DuY/9h?=
 =?us-ascii?Q?Gfo2amItjG3CDvY22rm8Is1QWkhj+v75XtQb1SshmdflHo7eLIKfoTNZVioe?=
 =?us-ascii?Q?AgRpRlnSgH0WxMiAHmfcaE8TUXGhMf+PbAvxNMZKFwgaN+l41WxaOVHZbuhm?=
 =?us-ascii?Q?pda1S0lLpwvqz/bTF4zu7Sa3+MXIUJAfEoWlO7LPjsf+/pTs+UqJ9MF8F0JS?=
 =?us-ascii?Q?0D4k5TlKcBC2hFLYOZQEGCSxUSZZ85/VsKYQGHJVBte1OcUmGS7k8I4IREl4?=
 =?us-ascii?Q?3qEAmrw6y8w8uhqv0M6NFseuwFiLjwex99E40Z5yaRl7iok/8gNJLRUetR7c?=
 =?us-ascii?Q?gQl1hn3u67nSnXF+jZiRCFSbUGQsxkjw8tpxVOQuP9/+l7RyCY7Heyz0j5Qi?=
 =?us-ascii?Q?y7uUIDNwrC/Z61vpzwWE+lvZwhm1vdFj2d8921Lz/XftYdwmbxY1dTQvbWNw?=
 =?us-ascii?Q?gHcsSfWn4H09a531AedfCCGcPP7/9QvTga3Ssf4Q4f7b3Xdn9EZNXroYd8FD?=
 =?us-ascii?Q?xn9/UUD5ApUcfKpk8RXkvmSHAMp0VVXCB/njX7XcpUQbudETVeuES1GpyGVW?=
 =?us-ascii?Q?knOifvi73cxAej/k+NgL5MKadxNR8pTvNwKCy3gZQuMOXH6smeP9VnQO3eZ5?=
 =?us-ascii?Q?c7wLLMBX/yu2sGHJ2c9sh2v8rYgIFfV/5/8xw1C8z/j2x3K63lx648PfA0Xn?=
 =?us-ascii?Q?SaIVJz71ZWVYv04A4D+OBH1Krshtcj+/kxaDT/ppFmAZBIXNFFOsmSK5Sfwp?=
 =?us-ascii?Q?0U2xI/f2Me6MJRPBCxmJ/bKy52Bt3kUnBkyfgJ0V9UPVmtMBq/H3HP/UB7m3?=
 =?us-ascii?Q?a/IKhT7KQMgPfU/Xjk0qZcW5nZVUulQyyKBAEYcB7p/iNNM0THnqLzkB2RQA?=
 =?us-ascii?Q?/IbSaVvoJSBF//Ry4OfnbQ8I9RCOu5XDZCN5JjeGDaUmJHNhFMIjJFaCtt9h?=
 =?us-ascii?Q?4QVLVWv5UFkWT4U7pkMQZa6BbRyB1NjSCG+pTcqD6agnnBOnUVSI3rRIXUkx?=
 =?us-ascii?Q?4sy8BoOqFYe9p/0GO3b2NC46bwA1lizkETR6/6G4+SQvcuRgguEWMLesdphs?=
 =?us-ascii?Q?CgBWC5daplXcNMKltdfpSx5nU9zj/h233A6zYWZx9DkyMXv/ZpplcG9JCR0Y?=
 =?us-ascii?Q?swTMJhjKnHasmZb9p/qm1JxEQV4rfqTYmZPaA98wGRq2O3aMuOfjM2BvadtO?=
 =?us-ascii?Q?R63gILiQurcpirQeDDZiYI+1BcMGGxnWD4nMhpj32lJEcx8wCuB6h57Acyhm?=
 =?us-ascii?Q?A1r41UP3S9FG/uS1EXnbYTrz1oLDro5v4UF+BdHy6Vh6DUF8V9CPb/EdZxet?=
 =?us-ascii?Q?jFL8EBjoTeLOkJSiSofHujgpf3x/Y1pJFN7+IflL7G1uaTm2YKvYkctlGGgH?=
 =?us-ascii?Q?vPCG2FWV0cB7H95C2/Lz84IpPWT+reFYQ6Ph7QQqTSqMHria7+SjsHNbyBDK?=
 =?us-ascii?Q?0dLwgsGrKss8Jz/LRoYW0EZK0+UeKJn2PmhfK2MXGtrd7pXrr4ewyd0mhXcH?=
 =?us-ascii?Q?d1iDoYZpl7i0ji0IFaoX9K+7h9/GuUA=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 148b822b-8290-4c99-9865-08df217044ea
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB6257.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2026 17:03:38.7447 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WejiYc3bdqhUpHpefOLL/c0jb4wbvGPWA6OMkMkBD7cPCkvpY33tWv0iUiRkTVy+lmdEgtgDwXp61xzSMRVC0qLfEITxoiUj4UEtnogj0+E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR02MB6993
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=bin.meng@processmission.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Exercise RTC register masks, binary counter, upload and stop controls,
alarm and wakeup interrupt behavior, reset state, and PLIC wiring on
the Icicle Kit.

Also verify RTC state and pending interrupt migration, including streams
from QEMU versions that predate the RTC device.

Signed-off-by: Bin Meng <bin.meng@processmission.com>

---

(no changes since v2)

Changes in v2:
- Expect the documented hardware state after RTC reset

 MAINTAINERS                       |   1 +
 tests/qtest/mchp_pfsoc_rtc_test.c | 315 ++++++++++++++++++++++++++++++
 tests/qtest/meson.build           |   5 +-
 3 files changed, 320 insertions(+), 1 deletion(-)
 create mode 100644 tests/qtest/mchp_pfsoc_rtc_test.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 2ea76ad1cd..12ffbd560e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1810,6 +1810,7 @@ F: include/hw/misc/mchp_pfsoc_dmc.h
 F: include/hw/misc/mchp_pfsoc_ioscb.h
 F: include/hw/misc/mchp_pfsoc_sysreg.h
 F: include/hw/rtc/mchp_pfsoc_rtc.h
+F: tests/qtest/mchp_pfsoc_rtc_test.c
 
 Shakti C class SoC
 L: qemu-riscv@nongnu.org
diff --git a/tests/qtest/mchp_pfsoc_rtc_test.c b/tests/qtest/mchp_pfsoc_rtc_test.c
new file mode 100644
index 0000000000..ed96c15faa
--- /dev/null
+++ b/tests/qtest/mchp_pfsoc_rtc_test.c
@@ -0,0 +1,315 @@
+/*
+ * QTest testcase for the Microchip PolarFire SoC RTC
+ *
+ * Copyright (c) 2026 Process Mission
+ *
+ * Author:
+ *   Bin Meng <bin.meng@processmission.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/bitops.h"
+#include "qemu/bswap.h"
+#include "qemu/timer.h"
+#include "libqtest.h"
+#include "migration/migration-qmp.h"
+#include "migration/migration-util.h"
+
+#define RTC_BASE            0x20124000
+#define RTC_CONTROL         0x00
+#define RTC_MODE            0x04
+#define RTC_PRESCALER       0x08
+#define RTC_ALARM_LOWER     0x0c
+#define RTC_ALARM_UPPER     0x10
+#define RTC_COMPARE_LOWER   0x14
+#define RTC_COMPARE_UPPER   0x18
+#define RTC_DATETIME_LOWER  0x20
+#define RTC_DATETIME_UPPER  0x24
+#define RTC_RUNNING         BIT(0)
+#define RTC_STOP            BIT(1)
+#define RTC_ALARM_ON        BIT(2)
+#define RTC_ALARM_OFF       BIT(3)
+#define RTC_UPLOAD          BIT(5)
+#define RTC_MATCH           BIT(7)
+#define RTC_WAKEUP_CLEAR    BIT(8)
+#define RTC_WAKEUP_SET      BIT(9)
+#define RTC_UPDATED         BIT(10)
+#define RTC_WAKEUP_ENABLE   BIT(1)
+#define RTC_WAKEUP_RESET    BIT(2)
+#define RTC_WAKEUP_CONTINUE BIT(3)
+#define RTC_PRESCALER_MASK  0x03ffffff
+#define RTC_UPPER_MASK      0x3fffffff
+#define PLIC_BASE           0x0c000000
+#define PLIC_PENDING        0x1000
+#define PLIC_RTC_PENDING    (BIT(16) | BIT(17))
+#define ENVM_BASE           0x20220000
+#define HSS_HEADER_SIZE     0x100
+#define HSS_HEADER_JUMP     0x1000006f
+#define HSS_PAYLOAD_BASE    (ENVM_BASE + HSS_HEADER_SIZE)
+#define HSS_PAYLOAD_SIZE    8
+
+static QTestState *microchip_icicle_kit_start_rtc(const char *firmware)
+{
+    return qtest_initf(
+        "-machine microchip-icicle-kit -smp 5 -m 2G -bios \"%s\" "
+        "-rtc clock=vm", firmware);
+}
+
+static QTestState *microchip_icicle_kit_start_ext(const char *qemu_var,
+                                                  const char *firmware)
+{
+    g_autofree char *args = g_strdup_printf(
+        "-machine microchip-icicle-kit -smp 5 -m 2G -bios \"%s\"",
+        firmware);
+
+    return qtest_init_ext(qemu_var, args, NULL, true);
+}
+
+static char *create_firmware(void)
+{
+    uint8_t firmware[HSS_HEADER_SIZE + HSS_PAYLOAD_SIZE] = { 0 };
+    static const uint8_t payload[] = {
+        0x13, 0x00, 0x00, 0x00,
+        0x6f, 0x00, 0x00, 0x00,
+    };
+    char *path;
+    int fd;
+    ssize_t written;
+    unsigned int i;
+
+    stl_le_p(&firmware[0], HSS_HEADER_JUMP);
+    stl_le_p(&firmware[4], HSS_PAYLOAD_SIZE);
+    for (i = 0; i < 5; i++) {
+        stl_le_p(&firmware[8 + i * sizeof(uint32_t)], HSS_PAYLOAD_BASE);
+    }
+    memcpy(&firmware[HSS_HEADER_SIZE], payload, sizeof(payload));
+
+    fd = g_file_open_tmp("microchip-icicle-kit-XXXXXX", &path, NULL);
+    g_assert_cmpint(fd, >=, 0);
+
+    written = write(fd, firmware, sizeof(firmware));
+    g_assert_cmpint(written, ==, sizeof(firmware));
+    close(fd);
+
+    return path;
+}
+
+static uint64_t rtc_read_binary_count(QTestState *qts)
+{
+    uint64_t count = qtest_readl(qts, RTC_BASE + RTC_DATETIME_LOWER);
+
+    count |= (uint64_t)qtest_readl(qts,
+                                   RTC_BASE + RTC_DATETIME_UPPER) << 32;
+    return count;
+}
+
+static void test_rtc(void)
+{
+    g_autofree char *firmware = create_firmware();
+    QTestState *qts = microchip_icicle_kit_start_rtc(firmware);
+    uint32_t control;
+
+    unlink(firmware);
+    qtest_irq_intercept_out_named(qts, "/machine/soc/rtc", "sysbus-irq");
+
+    g_assert_cmphex(qtest_readl(qts, RTC_BASE + RTC_CONTROL), ==, 0);
+    g_assert_cmphex(rtc_read_binary_count(qts), ==, 0);
+    qtest_clock_step(qts, 2 * NANOSECONDS_PER_SECOND);
+    g_assert_cmphex(rtc_read_binary_count(qts), ==, 0);
+
+    qtest_writel(qts, RTC_BASE + RTC_MODE, UINT32_MAX);
+    qtest_writel(qts, RTC_BASE + RTC_PRESCALER, UINT32_MAX);
+    g_assert_cmphex(qtest_readl(qts, RTC_BASE + RTC_MODE), ==, 0xf);
+    g_assert_cmphex(qtest_readl(qts, RTC_BASE + RTC_PRESCALER), ==,
+                    RTC_PRESCALER_MASK);
+    qtest_writel(qts, RTC_BASE + RTC_MODE, 0);
+
+    qtest_writel(qts, RTC_BASE + RTC_CONTROL, RTC_STOP);
+    g_assert_cmphex(qtest_readl(qts, RTC_BASE + RTC_CONTROL) &
+                    RTC_RUNNING, ==, 0);
+    qtest_clock_step(qts, 2 * NANOSECONDS_PER_SECOND);
+    g_assert_cmphex(rtc_read_binary_count(qts), ==, 0);
+
+    qtest_writel(qts, RTC_BASE + RTC_DATETIME_LOWER, 42);
+    qtest_writel(qts, RTC_BASE + RTC_DATETIME_UPPER, 0);
+    qtest_writel(qts, RTC_BASE + RTC_CONTROL, RTC_UPLOAD);
+    g_assert_cmphex(rtc_read_binary_count(qts), ==, 42);
+    g_assert_cmphex(qtest_readl(qts, RTC_BASE + RTC_CONTROL) &
+                    (RTC_UPLOAD | RTC_UPDATED), ==, RTC_UPDATED);
+
+    qtest_writel(qts, RTC_BASE + RTC_CONTROL, RTC_RUNNING);
+    qtest_clock_step(qts, NANOSECONDS_PER_SECOND);
+    g_assert_cmphex(rtc_read_binary_count(qts), ==, 43);
+    qtest_writel(qts, RTC_BASE + RTC_CONTROL, RTC_WAKEUP_SET);
+    g_assert_true(qtest_get_irq(qts, 0));
+    qtest_writel(qts, RTC_BASE + RTC_CONTROL, RTC_WAKEUP_CLEAR);
+    g_assert_false(qtest_get_irq(qts, 0));
+
+    qtest_writel(qts, RTC_BASE + RTC_ALARM_LOWER, 45);
+    qtest_writel(qts, RTC_BASE + RTC_ALARM_UPPER, 0);
+    qtest_writel(qts, RTC_BASE + RTC_COMPARE_LOWER, UINT32_MAX);
+    qtest_writel(qts, RTC_BASE + RTC_COMPARE_UPPER, RTC_UPPER_MASK);
+    qtest_writel(qts, RTC_BASE + RTC_MODE,
+                 RTC_WAKEUP_ENABLE | RTC_WAKEUP_CONTINUE);
+    qtest_writel(qts, RTC_BASE + RTC_CONTROL, RTC_ALARM_ON);
+    g_assert_false(qtest_get_irq(qts, 0));
+    g_assert_false(qtest_get_irq(qts, 1));
+    control = qtest_readl(qts, RTC_BASE + RTC_CONTROL);
+    g_assert_cmphex(control & RTC_ALARM_ON, ==, RTC_ALARM_ON);
+    qtest_writel(qts, RTC_BASE + RTC_CONTROL, control | RTC_ALARM_OFF);
+    g_assert_cmphex(qtest_readl(qts, RTC_BASE + RTC_CONTROL) &
+                    RTC_ALARM_ON, ==, 0);
+    qtest_clock_step(qts, 2 * NANOSECONDS_PER_SECOND);
+    g_assert_false(qtest_get_irq(qts, 0));
+    g_assert_false(qtest_get_irq(qts, 1));
+
+    qtest_writel(qts, RTC_BASE + RTC_DATETIME_LOWER, 43);
+    qtest_writel(qts, RTC_BASE + RTC_CONTROL, RTC_UPLOAD);
+    qtest_writel(qts, RTC_BASE + RTC_CONTROL, RTC_ALARM_ON);
+    qtest_clock_step(qts, 2 * NANOSECONDS_PER_SECOND);
+    g_assert_true(qtest_get_irq(qts, 0));
+    g_assert_true(qtest_get_irq(qts, 1));
+    g_assert_cmphex(qtest_readl(qts, RTC_BASE + RTC_CONTROL) & RTC_MATCH,
+                    ==, RTC_MATCH);
+    qtest_writel(qts, RTC_BASE + RTC_CONTROL, RTC_ALARM_OFF);
+    g_assert_false(qtest_get_irq(qts, 0));
+    g_assert_false(qtest_get_irq(qts, 1));
+
+    qtest_writel(qts, RTC_BASE + RTC_DATETIME_LOWER, 0);
+    qtest_writel(qts, RTC_BASE + RTC_DATETIME_UPPER, 0);
+    qtest_writel(qts, RTC_BASE + RTC_CONTROL, RTC_UPLOAD);
+    qtest_writel(qts, RTC_BASE + RTC_ALARM_LOWER, 2);
+    qtest_writel(qts, RTC_BASE + RTC_MODE,
+                 RTC_WAKEUP_ENABLE | RTC_WAKEUP_RESET |
+                 RTC_WAKEUP_CONTINUE);
+    qtest_writel(qts, RTC_BASE + RTC_CONTROL, RTC_ALARM_ON);
+    qtest_clock_step(qts, 2 * NANOSECONDS_PER_SECOND);
+    g_assert_true(qtest_get_irq(qts, 0));
+    g_assert_cmphex(rtc_read_binary_count(qts), ==, 0);
+    g_assert_cmphex(qtest_readl(qts, RTC_BASE + RTC_CONTROL) &
+                    RTC_ALARM_ON, ==, RTC_ALARM_ON);
+    qtest_writel(qts, RTC_BASE + RTC_CONTROL, RTC_WAKEUP_CLEAR);
+    qtest_clock_step(qts, 2 * NANOSECONDS_PER_SECOND);
+    g_assert_true(qtest_get_irq(qts, 0));
+    g_assert_cmphex(rtc_read_binary_count(qts), ==, 0);
+    qtest_writel(qts, RTC_BASE + RTC_CONTROL, RTC_ALARM_OFF);
+    g_assert_false(qtest_get_irq(qts, 0));
+    g_assert_false(qtest_get_irq(qts, 1));
+
+    qtest_system_reset(qts);
+    g_assert_cmphex(qtest_readl(qts, RTC_BASE + RTC_CONTROL), ==, 0);
+    g_assert_cmphex(qtest_readl(qts, RTC_BASE + RTC_MODE), ==, 0);
+    g_assert_cmphex(qtest_readl(qts, RTC_BASE + RTC_PRESCALER), ==, 0);
+    g_assert_false(qtest_get_irq(qts, 0));
+    g_assert_false(qtest_get_irq(qts, 1));
+
+    qtest_quit(qts);
+}
+
+static void test_rtc_plic(void)
+{
+    g_autofree char *firmware = create_firmware();
+    QTestState *qts = microchip_icicle_kit_start_rtc(firmware);
+
+    unlink(firmware);
+
+    qtest_writel(qts, RTC_BASE + RTC_DATETIME_LOWER, 42);
+    qtest_writel(qts, RTC_BASE + RTC_DATETIME_UPPER, 0);
+    qtest_writel(qts, RTC_BASE + RTC_CONTROL, RTC_UPLOAD);
+    qtest_writel(qts, RTC_BASE + RTC_CONTROL, RTC_RUNNING);
+    qtest_writel(qts, RTC_BASE + RTC_ALARM_LOWER, 43);
+    qtest_writel(qts, RTC_BASE + RTC_ALARM_UPPER, 0);
+    qtest_writel(qts, RTC_BASE + RTC_COMPARE_LOWER, UINT32_MAX);
+    qtest_writel(qts, RTC_BASE + RTC_COMPARE_UPPER, RTC_UPPER_MASK);
+    qtest_writel(qts, RTC_BASE + RTC_MODE,
+                 RTC_WAKEUP_ENABLE | RTC_WAKEUP_CONTINUE);
+    qtest_writel(qts, RTC_BASE + RTC_CONTROL, RTC_ALARM_ON);
+    qtest_clock_step(qts, NANOSECONDS_PER_SECOND);
+
+    g_assert_cmphex(qtest_readl(qts, PLIC_BASE + PLIC_PENDING + 8) &
+                    PLIC_RTC_PENDING, ==, PLIC_RTC_PENDING);
+
+    qtest_quit(qts);
+}
+
+static void test_machine_migration(void)
+{
+    g_autofree char *firmware = create_firmware();
+    const char *old_qemu = g_getenv("QTEST_QEMU_BINARY_OLD");
+    QTestState *from;
+    QTestState *to = qtest_initf(
+        "-machine microchip-icicle-kit -smp 5 -m 2G "
+        "-bios \"%s\" -incoming defer "
+        "-rtc clock=vm", firmware);
+
+    qtest_irq_intercept_out_named(to, "/machine/soc/rtc", "sysbus-irq");
+
+    /* Allow an older QEMU source to exercise migration compatibility */
+    if (old_qemu) {
+        from = microchip_icicle_kit_start_ext("QTEST_QEMU_BINARY_OLD",
+                                              firmware);
+    } else {
+        from = microchip_icicle_kit_start_rtc(firmware);
+        qtest_writel(from, RTC_BASE + RTC_DATETIME_LOWER, 0x23456789);
+        qtest_writel(from, RTC_BASE + RTC_DATETIME_UPPER, 1);
+        qtest_writel(from, RTC_BASE + RTC_CONTROL, RTC_UPLOAD);
+        qtest_writel(from, RTC_BASE + RTC_CONTROL, RTC_RUNNING);
+        qtest_writel(from, RTC_BASE + RTC_ALARM_LOWER, 0x2345678b);
+        qtest_writel(from, RTC_BASE + RTC_ALARM_UPPER, 1);
+        qtest_writel(from, RTC_BASE + RTC_COMPARE_LOWER, UINT32_MAX);
+        qtest_writel(from, RTC_BASE + RTC_COMPARE_UPPER, RTC_UPPER_MASK);
+        qtest_writel(from, RTC_BASE + RTC_MODE,
+                     RTC_WAKEUP_ENABLE | RTC_WAKEUP_CONTINUE);
+        qtest_writel(from, RTC_BASE + RTC_CONTROL, RTC_ALARM_ON);
+        qtest_writel(from, RTC_BASE + RTC_CONTROL, RTC_WAKEUP_SET);
+        qtest_writel(from, RTC_BASE + RTC_PRESCALER, 999999);
+    }
+
+    unlink(firmware);
+
+    migrate_incoming_qmp(to, "tcp:127.0.0.1:0", NULL, "{}");
+    migrate_qmp(from, to, NULL, NULL, "{}");
+    wait_for_migration_complete(from);
+
+    if (old_qemu) {
+        g_assert_cmphex(qtest_readl(to, RTC_BASE + RTC_CONTROL), ==, 0);
+        g_assert_cmphex(qtest_readl(to, RTC_BASE + RTC_PRESCALER), ==, 0);
+        g_assert_false(qtest_get_irq(to, 0));
+        g_assert_false(qtest_get_irq(to, 1));
+    } else {
+        g_assert_cmphex(rtc_read_binary_count(to), ==, 0x123456789);
+        g_assert_cmphex(qtest_readl(to, RTC_BASE + RTC_CONTROL) &
+                        (RTC_RUNNING | RTC_ALARM_ON), ==,
+                        RTC_RUNNING | RTC_ALARM_ON);
+        g_assert_cmphex(qtest_readl(to, RTC_BASE + RTC_PRESCALER), ==,
+                        999999);
+        g_assert_true(qtest_get_irq(to, 0));
+        g_assert_false(qtest_get_irq(to, 1));
+        qtest_writel(to, RTC_BASE + RTC_CONTROL, RTC_WAKEUP_CLEAR);
+        g_assert_false(qtest_get_irq(to, 0));
+        qtest_clock_step(to, 2 * NANOSECONDS_PER_SECOND);
+        g_assert_cmphex(rtc_read_binary_count(to), ==, 0x12345678b);
+        g_assert_true(qtest_get_irq(to, 0));
+        g_assert_true(qtest_get_irq(to, 1));
+        qtest_writel(to, RTC_BASE + RTC_CONTROL, RTC_ALARM_OFF);
+        g_assert_false(qtest_get_irq(to, 0));
+        g_assert_false(qtest_get_irq(to, 1));
+    }
+
+    qtest_quit(from);
+    qtest_quit(to);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_add_func("/mchp_pfsoc_rtc/registers", test_rtc);
+    qtest_add_func("/mchp_pfsoc_rtc/plic", test_rtc_plic);
+    qtest_add_func("/mchp_pfsoc_rtc/migration",
+                   test_machine_migration);
+
+    return g_test_run();
+}
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 29457193ed..fb3dcb200b 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -312,7 +312,8 @@ qtests_riscv32 = \
 qtests_riscv64 = ['riscv-csr-test'] + \
   (unpack_edk2_blobs ? ['bios-tables-test'] : []) + \
   (config_all_devices.has_key('CONFIG_MICROCHIP_PFSOC') ?
-   ['cadence-sdhci-test'] : []) + \
+   ['cadence-sdhci-test',
+    'mchp_pfsoc_rtc_test'] : []) + \
   (config_all_devices.has_key('CONFIG_SIFIVE_L2CC') ? ['sifive_l2cc_test'] : []) + \
   (config_all_devices.has_key('CONFIG_IOMMU_TESTDEV') and
    config_all_devices.has_key('CONFIG_RISCV_IOMMU') ?
@@ -432,6 +433,8 @@ qtests = {
   'migration-test': test_migration_files + migration_tls_files + migration_colo_files,
   'sifive_l2cc_test': files('migration/migration-qmp.c',
                            'migration/migration-util.c'),
+  'mchp_pfsoc_rtc_test': files('migration/migration-qmp.c',
+                               'migration/migration-util.c'),
   'pxe-test': files('boot-sector.c'),
   'pnv-xive2-test': files('pnv-xive2-common.c', 'pnv-xive2-flush-sync.c',
                           'pnv-xive2-nvpg_bar.c'),
-- 
2.53.0


