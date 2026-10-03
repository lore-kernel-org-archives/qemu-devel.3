Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3374CA5FED
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2026 17:07:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xD3C1-0004PZ-Hm; Sat, 03 Oct 2026 13:06:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xD399-0007Fo-QN; Sat, 03 Oct 2026 13:03:49 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xD396-0007CD-Ro; Sat, 03 Oct 2026 13:03:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WjJEAHi552fSLO4vwjMw7FbWGzrz5VYooAzNNPwNVJK9IGwTHoY7pIFBWDayWC+gjTMK/QjbERwi+RfTzge3MjKcLFcHJaoT4XGoJQwUo37JA7W+WGnQWh/HBXqR0DquEW8PaeZVcIHLAujMeNZKZhjAjLDb3tDsmHXB8tdKFWWGTJRyQ+v+FdsXrSSMUtNk8TfULvXpc1jSuNK2ZtLlHu2xQRkUr6mML+XUszXah+nf/E94EItWjvClo+lzXQT8NgdyBAn/2dtR5euQblFKCbMU23pnNhQcIK+yvH7JDdM9TUxQFyGwt8XpmcY4BNpi0RIyjPHUbsY1GTSQ4aG86g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3j9310wvllERaQXHHLmrww5t++/gj5jz7a5oVsoXX1E=;
 b=rKnT3wTAb3c2ykhMvlebBnc3ix5PxZ7DMChLIdo5/Be9nJoRqh3TCYsYoHOXWwur/rvXsu9dDHvX/kzGiZsXo+Z9hDt2XWRaOP3OB+/cXLXmx+Slh7S5Tk/0aibEQVXQ5GBsYJ95kenSoOwe6yOoA3EsQUiO0PtHUjpS4fYGMjHppV44edMWDkFbeddf9Yi8Xg9toqF8CFl/FenpSA/PUAPaHjq5+4ZQxpK62ZkGNG+Y25oRRcyMYdrLEvnjIAk3nqqei2bi1UgW0NOepiUua3FCA4TT1pd3c1gFflL4ZwEY/ptxnIYWPstzJ4JCMDn8IdyMHYuCkFRdaJUBvoHKhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3j9310wvllERaQXHHLmrww5t++/gj5jz7a5oVsoXX1E=;
 b=ru3tsMNHxY+Vu1wWi/A1wBErUVlbTTD5su2FstRi/hA1MIzIDPzgeC9ibIpm49Z6HeBkdVl7lX7Rcj/vtzcJNzewNqgS//leTbWpKXobpo4j/maH/4XuTJ9lNQjDZtbyQLbGnhDARmt/XINzxnRxqgBspHRwF7ZdVJQjIJgutGsaXkYvHTfQbXZZOv5oyPRzu5YyAfRpneI8C0ZmxapQJCePblDjHX2MeG7vza418EKBW0M7UjkJOo7Xq2dO2RdZp1SX8bZngs0U19Sf+23vVotJYItvEFyW5jEB2LafthL+vOmPBFor2lGTq6mFKqHxuFsv5uSSKbhKBT9cRFUrTw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com (2603:1096:820:da::11)
 by TYZPR02MB5788.apcprd02.prod.outlook.com (2603:1096:400:1d0::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Sat, 3 Oct
 2026 17:03:32 +0000
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215]) by KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215%6]) with mapi id 15.21.0472.016; Sat, 3 Oct 2026
 17:03:32 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Conor Dooley <conor@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Sebastian Huber <sebastian.huber@embedded-brains.de>, qemu-riscv@nongnu.org
Subject: [PATCH v3 14/27] hw/rtc: Add PolarFire SoC RTC model
Date: Sun,  4 Oct 2026 01:02:04 +0800
Message-ID: <20261003170232.2450916-15-bin.meng@processmission.com>
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
X-MS-TrafficTypeDiagnostic: KL1PR02MB6257:EE_|TYZPR02MB5788:EE_
X-MS-Office365-Filtering-Correlation-Id: 00294328-83f0-4633-0800-08df21704110
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|6133799003|10067099003|260925022911599003|260925021911599003|260925021311599003|56012099006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: ST5xu3MyhLJL8LyquuF9Z7+xLS+pwhVnuhxpQCV6hllgi/cpDykRqHpZeKEdVAT8dMKxXcNvn0hSvPPuHMWzj2UqGBtYK//I8VeIG50WEfmwGSm4JJcOF32YlPuZU1jc5a/DWuCIZuvzGSQBV1PTVt1OqL9Th0texrEw8jgo9cqQFz8iBPSgPpHX8QC0PIDRGRAWn1EbRaQ0XmnUwz/bKUJC/GEFNQluOtV25Tob5zIUIqUuwpoGwStqkCyJaMN+mMcWVoQY6i1kmDjb1/hUvViVSLVqIZgLRdSv7dmtr/v2Y8Wi3qANuXQ+FS9HbW0yIy89Nq0MUH42Mm3uQT3PKR0iqIYIfUzrw9E/730y16tLrOYvW+m/eLTv6csTaYt5D+/mnwQTjhf8mk/f9TiMsGEyBnHaZ3ps56qPoKVuItR0I+dFMilSWbqBiMjWTBxf1+nCHqni+v1NXqfyF5Ps3HEyy94/Tj/66il5tz+5B2GkePhMSpDy/MlQlzRUeGG2khaLCz4DEhXvbLDgsCOp2b/HTyVn9lAGHs947nY3VhCWK8BIL7keVILdaAJOpmRvpzB1LfUh0gOZN1Ne9iNPBDJKhTrFqC5Jo94Q+vYLJVT7q+zJC4uJGpdvtFPe4YUuzyyAHSUXVWJktyP1HzNoI5OrvgbGxeA2UWLbwVGicME=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB6257.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(6133799003)(10067099003)(260925022911599003)(260925021911599003)(260925021311599003)(56012099006)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XvlcT/Pi7W92SzbS0PvuKTFDToRMe2IwcJanPMhOYVEEyeHi2Lmjl+L8XD2w?=
 =?us-ascii?Q?YdyLyGO43vZqdH4GWePbjRDemywY/yTFSYr60TRpZPeh2Tly7v158VY/kNeE?=
 =?us-ascii?Q?TCGZV7EfmviRkJKMTSaxFra1DViGFJR9xG1wSlqG+uHPh1OjC+0O5ZmasCbh?=
 =?us-ascii?Q?u3yK5W18hubY/3nkRlp5dTxoxSWd6ctEsPywhB721uqjmVig0Ieu0FUTxmw4?=
 =?us-ascii?Q?AlwvvnaHwwOWxtK+U53R9jIqfnLKadFVNAVvC6kOMUAcTApSmb0sjecz5TWN?=
 =?us-ascii?Q?iZQbDYoW6ZO5SMgRPbYz7xF4AbL0rqhuTfZYFgKawfSkU8IW1DpSYvWdcLWs?=
 =?us-ascii?Q?ZKMsiVeRWl85iynYwIPDVuWs/LLVrDUbIV7gkQAlGOEChoG34qbChRz+bI5x?=
 =?us-ascii?Q?QpF1tVQ833CR6HmCdu1d4qVtEKDKlULoIIsM/FzoeGlw78EL3Pu5oJhGC1IM?=
 =?us-ascii?Q?XbYkMFhR9BO+nUXQytX8nPBNL0YvvmeQxi2cJ2uhW04OENR2eKTH+nHKVlWI?=
 =?us-ascii?Q?uPYBuc6xDTLiVHNxmuKt4clsbquVCwyzrT+kY7uyPWX9iy+suByNDDrBUTji?=
 =?us-ascii?Q?6Zo77h7KSadYxa3R4nXbMfBqFD0Su2SqgeEcCYNeDc1pYSGnr1m13JTszDYa?=
 =?us-ascii?Q?4bUFHNkVdLO1T0rL6udOsacdohyUvPxb9gShFORfAemQ0Pip9qYhmJ59dGkL?=
 =?us-ascii?Q?vTnVPzMgiPnNTPOIrUld5/vJ7fT8vBfeBcLanXqnafSo678a9ZExXbGAjVRZ?=
 =?us-ascii?Q?n0gejWTV6vY6xAqoq3teREn6LT4vQUf0qV05jMtUDtTAwkw38Nl90Bw8bObT?=
 =?us-ascii?Q?Flgt7Me4nITRA4kH/2KNeODAb0JW8ccXzQtR1wlcVSC7pgDuo3O5dHG9TGG0?=
 =?us-ascii?Q?UwuqXDfjMQPVn1NocTVTAhJ+NmyZ7vfWXcAuQSwDuX7gCrv7cje7vMulpGJb?=
 =?us-ascii?Q?J4WXvfayOeTgvGYF/X7oKmm7VrYMi7jts1EdBtDLHdUdsRN9xWOPNpp3Q8Cv?=
 =?us-ascii?Q?aOaQhgnoDdAWm44jCU+Mxfle/GuRcrMRtJKWsfYiN3yyv2u9XhSTimamsvvH?=
 =?us-ascii?Q?2ZtFo7Ezgzy34a23WGANjrkMR0eT/UwT9nAda+aaJDy9cKNFf4daUAHIZiow?=
 =?us-ascii?Q?tPXDmvHT787jBI98qCmjrnmNuFfvgx2NvxQa8PmHCEJq4evuNXhIbNWr/uSr?=
 =?us-ascii?Q?TbSVfaStTby7wH0x6LiwoYE4uBi/jxMWwKdSM7fXz7/u+7a8DIlNFp6USdW9?=
 =?us-ascii?Q?/V00PvWZxN5Rkr6ojjA5Gsw84k1bjgEYTSL18LF9owriOY3PvM+Hx78+smr4?=
 =?us-ascii?Q?+Jpi5MSsZqk1vVe+I0tTdJPlT8HBQ37R9eEgB6LNxmPM5fbV5TF4gP7BOYoe?=
 =?us-ascii?Q?/IN4zNBQqXdwTXWjxkF+u5++XAGyc4xGKZqu0VIjf1JeONoM7FWZTOuPSTXR?=
 =?us-ascii?Q?aucOiKTueRelBoNCSE/Jpm3uB+hzElxWKGC/QvWhMjqN88jUhVWqZVaCIrH2?=
 =?us-ascii?Q?/q9jd3/k22vLYU0BWsx78FDVKxfbgflihycOSuoRPg9opoDqj6fGn5DiEemx?=
 =?us-ascii?Q?k9tq0amATnAmPCerMZ5nXPfM4XwI+BW8+Lo6A07JQrrAUc/OPtaHn4aiYnce?=
 =?us-ascii?Q?WzfgJ5tln3WOrJF+qaksMELFx3Yr7TcAHp56H2lDmRhrtyu1RnF+1G4LLnZu?=
 =?us-ascii?Q?WeIA0VlwJunbqT8h4wUyq3OUQq6C69eqYexYy7DQom4yVTXVqRZEXEnU4vXw?=
 =?us-ascii?Q?0YI83pNetT6whKv0C8k5LgY6XV66PTw=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00294328-83f0-4633-0800-08df21704110
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB6257.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2026 17:03:32.2945 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CUsniSg9TU0eVmwh7ofuDCBTV8zgwR0QNzFVQi/c12fjlcq44djzY3TNGlxEWFuGH+XFRhucOcq48kza3Flb2iS8Xf36zEmKa4jigCB6h8I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR02MB5788
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=bin.meng@processmission.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
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

The PolarFire SoC exposes an RTC with binary and calendar modes,
programmable prescaling, alarms, and wakeup and match interrupts.

Add a standalone device model with explicit MMIO handling for time,
commands, alarms, interrupt state, reset, and migration. Add its
Kconfig and Meson entries and list it under the PolarFire SoC
maintainer section.

Reset the device to its documented hardware values, with the binary
counter stopped at zero.

Signed-off-by: Bin Meng <bin.meng@processmission.com>

---

(no changes since v2)

Changes in v2:
- Reset the RTC to the documented hardware values
- Use the Resettable API instead of a legacy reset handler

 MAINTAINERS                     |   2 +
 include/hw/rtc/mchp_pfsoc_rtc.h |  46 +++
 hw/rtc/mchp_pfsoc_rtc.c         | 477 ++++++++++++++++++++++++++++++++
 hw/rtc/Kconfig                  |   3 +
 hw/rtc/meson.build              |   1 +
 5 files changed, 529 insertions(+)
 create mode 100644 include/hw/rtc/mchp_pfsoc_rtc.h
 create mode 100644 hw/rtc/mchp_pfsoc_rtc.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 65325450e0..2ea76ad1cd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1803,11 +1803,13 @@ F: hw/char/mchp_pfsoc_mmuart.c
 F: hw/misc/mchp_pfsoc_dmc.c
 F: hw/misc/mchp_pfsoc_ioscb.c
 F: hw/misc/mchp_pfsoc_sysreg.c
+F: hw/rtc/mchp_pfsoc_rtc.c
 F: include/hw/riscv/microchip_pfsoc.h
 F: include/hw/char/mchp_pfsoc_mmuart.h
 F: include/hw/misc/mchp_pfsoc_dmc.h
 F: include/hw/misc/mchp_pfsoc_ioscb.h
 F: include/hw/misc/mchp_pfsoc_sysreg.h
+F: include/hw/rtc/mchp_pfsoc_rtc.h
 
 Shakti C class SoC
 L: qemu-riscv@nongnu.org
diff --git a/include/hw/rtc/mchp_pfsoc_rtc.h b/include/hw/rtc/mchp_pfsoc_rtc.h
new file mode 100644
index 0000000000..17bc6ddcdc
--- /dev/null
+++ b/include/hw/rtc/mchp_pfsoc_rtc.h
@@ -0,0 +1,46 @@
+/*
+ * Microchip PolarFire SoC RTC
+ *
+ * Copyright (c) 2026 Process Mission
+ *
+ * Author:
+ *   Bin Meng <bin.meng@processmission.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_RTC_MCHP_PFSOC_RTC_H
+#define HW_RTC_MCHP_PFSOC_RTC_H
+
+#include "hw/core/sysbus.h"
+#include "qemu/timer.h"
+#include "qom/object.h"
+
+#define TYPE_MCHP_PFSOC_RTC "mchp.pfsoc.rtc"
+OBJECT_DECLARE_SIMPLE_TYPE(MchpPfSoCRtcState, MCHP_PFSOC_RTC)
+
+#define MCHP_PFSOC_RTC_REGS 28
+
+struct MchpPfSoCRtcState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion iomem;
+    qemu_irq irq_wakeup;
+    qemu_irq irq_match;
+    QEMUTimer *alarm_timer;
+
+    int64_t tick_offset;
+    int64_t tick_offset_vmstate;
+    uint64_t frozen_count;
+    uint64_t read_latch;
+    bool running;
+    bool alarm_enabled;
+    bool wakeup_pending;
+    bool match_pending;
+    bool updated;
+    bool read_latch_valid;
+
+    uint32_t regs[MCHP_PFSOC_RTC_REGS];
+};
+
+#endif /* HW_RTC_MCHP_PFSOC_RTC_H */
diff --git a/hw/rtc/mchp_pfsoc_rtc.c b/hw/rtc/mchp_pfsoc_rtc.c
new file mode 100644
index 0000000000..f5068b15ef
--- /dev/null
+++ b/hw/rtc/mchp_pfsoc_rtc.c
@@ -0,0 +1,477 @@
+/*
+ * Microchip PolarFire SoC RTC
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
+#include "hw/rtc/mchp_pfsoc_rtc.h"
+#include "hw/core/irq.h"
+#include "migration/vmstate.h"
+#include "qemu/cutils.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "system/rtc.h"
+#include "system/system.h"
+
+#define RTC_MMIO_SIZE               0x1000
+#define RTC_CONTROL_MASK            0x000007ff
+#define RTC_MODE_MASK               0x0000000f
+#define RTC_PRESCALER_MASK          0x03ffffff
+#define RTC_ALARM_UPPER_MASK        0x000007ff
+#define RTC_UPPER_MASK              0x3fffffff
+#define RTC_CALENDAR_MASK           0x000000ff
+
+#define RTC_CONTROL                 0x00
+#define RTC_CONTROL_START_RUNNING   BIT(0)
+#define RTC_CONTROL_STOP            BIT(1)
+#define RTC_CONTROL_ALARM_ON        BIT(2)
+#define RTC_CONTROL_ALARM_OFF       BIT(3)
+#define RTC_CONTROL_RESET           BIT(4)
+#define RTC_CONTROL_UPLOAD          BIT(5)
+#define RTC_CONTROL_DOWNLOAD        BIT(6)
+#define RTC_CONTROL_MATCH           BIT(7)
+#define RTC_CONTROL_WAKEUP_CLEAR    BIT(8)
+#define RTC_CONTROL_WAKEUP_SET      BIT(9)
+#define RTC_CONTROL_UPDATED         BIT(10)
+
+#define RTC_MODE                    0x04
+#define RTC_MODE_CLOCK_CALENDAR     BIT(0)
+#define RTC_MODE_WAKEUP_ENABLE      BIT(1)
+#define RTC_MODE_WAKEUP_RESET       BIT(2)
+#define RTC_MODE_WAKEUP_CONTINUE    BIT(3)
+
+#define RTC_PRESCALER               0x08
+#define RTC_ALARM_LOWER             0x0c
+#define RTC_ALARM_UPPER             0x10
+#define RTC_COMPARE_LOWER           0x14
+#define RTC_COMPARE_UPPER           0x18
+#define RTC_DATETIME_LOWER          0x20
+#define RTC_DATETIME_UPPER          0x24
+#define RTC_SECONDS                 0x30
+#define RTC_MINUTES                 0x34
+#define RTC_HOURS                   0x38
+#define RTC_DAY                     0x3c
+#define RTC_MONTH                   0x40
+#define RTC_YEAR                    0x44
+#define RTC_WEEKDAY                 0x48
+#define RTC_WEEK                    0x4c
+#define RTC_SECONDS_COUNT           0x50
+#define RTC_MINUTES_COUNT           0x54
+#define RTC_HOURS_COUNT             0x58
+#define RTC_DAY_COUNT               0x5c
+#define RTC_MONTH_COUNT             0x60
+#define RTC_YEAR_COUNT              0x64
+#define RTC_WEEKDAY_COUNT           0x68
+#define RTC_WEEK_COUNT              0x6c
+
+#define RTC_REG(offset) ((offset) / sizeof(uint32_t))
+
+static uint64_t mchp_pfsoc_rtc_get_count(MchpPfSoCRtcState *s)
+{
+    if (!s->running) {
+        return s->frozen_count;
+    }
+
+    return s->tick_offset +
+           qemu_clock_get_ns(rtc_clock) / NANOSECONDS_PER_SECOND;
+}
+
+static void mchp_pfsoc_rtc_set_count(MchpPfSoCRtcState *s, uint64_t count)
+{
+    if (s->running) {
+        s->tick_offset = (int64_t)count -
+            qemu_clock_get_ns(rtc_clock) / NANOSECONDS_PER_SECOND;
+    } else {
+        s->frozen_count = count;
+    }
+}
+
+static void mchp_pfsoc_rtc_update_irq(MchpPfSoCRtcState *s)
+{
+    qemu_set_irq(s->irq_wakeup, s->wakeup_pending);
+    qemu_set_irq(s->irq_match, s->match_pending);
+}
+
+static void mchp_pfsoc_rtc_schedule_alarm(MchpPfSoCRtcState *s);
+
+static void mchp_pfsoc_rtc_alarm(void *opaque)
+{
+    MchpPfSoCRtcState *s = opaque;
+    bool periodic = s->regs[RTC_REG(RTC_MODE)] & RTC_MODE_WAKEUP_RESET;
+
+    s->alarm_enabled = periodic;
+    s->match_pending = true;
+    if (s->regs[RTC_REG(RTC_MODE)] & RTC_MODE_WAKEUP_ENABLE) {
+        s->wakeup_pending = true;
+    }
+    if (s->regs[RTC_REG(RTC_MODE)] & RTC_MODE_WAKEUP_RESET) {
+        mchp_pfsoc_rtc_set_count(s, 0);
+    }
+    if (!(s->regs[RTC_REG(RTC_MODE)] & RTC_MODE_WAKEUP_CONTINUE)) {
+        s->frozen_count = mchp_pfsoc_rtc_get_count(s);
+        s->running = false;
+    }
+    mchp_pfsoc_rtc_update_irq(s);
+    if (periodic) {
+        mchp_pfsoc_rtc_schedule_alarm(s);
+    }
+}
+
+static void mchp_pfsoc_rtc_schedule_alarm(MchpPfSoCRtcState *s)
+{
+    uint64_t compare_mask;
+    uint64_t target;
+    uint64_t now;
+    uint64_t delta;
+
+    timer_del(s->alarm_timer);
+    if (!s->alarm_enabled || !s->running ||
+        (s->regs[RTC_REG(RTC_MODE)] & RTC_MODE_CLOCK_CALENDAR)) {
+        return;
+    }
+
+    compare_mask = s->regs[RTC_REG(RTC_COMPARE_LOWER)] |
+        ((uint64_t)(s->regs[RTC_REG(RTC_COMPARE_UPPER)] &
+                    RTC_UPPER_MASK) << 32);
+    if (compare_mask != MAKE_64BIT_MASK(0, 62)) {
+        return;
+    }
+
+    target = s->regs[RTC_REG(RTC_ALARM_LOWER)] |
+        ((uint64_t)(s->regs[RTC_REG(RTC_ALARM_UPPER)] &
+                    RTC_ALARM_UPPER_MASK) << 32);
+    now = mchp_pfsoc_rtc_get_count(s);
+    if (target <= now) {
+        mchp_pfsoc_rtc_alarm(s);
+        return;
+    }
+
+    delta = target - now;
+    if (delta > INT64_MAX / NANOSECONDS_PER_SECOND) {
+        return;
+    }
+    timer_mod(s->alarm_timer,
+              qemu_clock_get_ns(rtc_clock) + delta * NANOSECONDS_PER_SECOND);
+}
+
+static void mchp_pfsoc_rtc_control_write(MchpPfSoCRtcState *s,
+                                         uint32_t value)
+{
+    uint64_t count;
+
+    value &= RTC_CONTROL_MASK;
+    if (value & RTC_CONTROL_UPDATED) {
+        s->updated = false;
+    }
+    if (value & RTC_CONTROL_RESET) {
+        mchp_pfsoc_rtc_set_count(s, 0);
+        s->updated = true;
+    }
+    if (value & RTC_CONTROL_UPLOAD) {
+        count = s->regs[RTC_REG(RTC_DATETIME_LOWER)] |
+            ((uint64_t)(s->regs[RTC_REG(RTC_DATETIME_UPPER)] &
+                        RTC_UPPER_MASK) << 32);
+        mchp_pfsoc_rtc_set_count(s, count);
+        s->updated = true;
+    }
+    if (value & RTC_CONTROL_DOWNLOAD) {
+        count = mchp_pfsoc_rtc_get_count(s);
+        s->regs[RTC_REG(RTC_DATETIME_LOWER)] = count;
+        s->regs[RTC_REG(RTC_DATETIME_UPPER)] = count >> 32;
+    }
+    if ((value & RTC_CONTROL_START_RUNNING) && !s->running) {
+        s->tick_offset = (int64_t)s->frozen_count -
+            qemu_clock_get_ns(rtc_clock) / NANOSECONDS_PER_SECOND;
+        s->running = true;
+    }
+    if ((value & RTC_CONTROL_STOP) && s->running) {
+        s->frozen_count = mchp_pfsoc_rtc_get_count(s);
+        s->running = false;
+    }
+    if (value & RTC_CONTROL_ALARM_OFF) {
+        s->alarm_enabled = false;
+        s->wakeup_pending = false;
+        s->match_pending = false;
+        timer_del(s->alarm_timer);
+    } else if (value & RTC_CONTROL_ALARM_ON) {
+        s->alarm_enabled = true;
+    }
+    if (value & RTC_CONTROL_WAKEUP_CLEAR) {
+        s->wakeup_pending = false;
+        s->match_pending = false;
+    }
+    if (value & RTC_CONTROL_WAKEUP_SET) {
+        s->wakeup_pending = true;
+    }
+
+    mchp_pfsoc_rtc_update_irq(s);
+    mchp_pfsoc_rtc_schedule_alarm(s);
+}
+
+static uint32_t mchp_pfsoc_rtc_control_read(MchpPfSoCRtcState *s)
+{
+    uint32_t value;
+
+    value = s->running ? RTC_CONTROL_START_RUNNING : 0;
+    if (s->alarm_enabled) {
+        value |= RTC_CONTROL_ALARM_ON;
+    }
+    if (s->match_pending) {
+        value |= RTC_CONTROL_MATCH;
+    }
+    if (s->updated) {
+        value |= RTC_CONTROL_UPDATED;
+    }
+    return value;
+}
+
+static uint32_t mchp_pfsoc_rtc_datetime_lower_read(MchpPfSoCRtcState *s)
+{
+    s->read_latch = mchp_pfsoc_rtc_get_count(s);
+    s->read_latch_valid = true;
+    return (uint32_t)s->read_latch;
+}
+
+static uint32_t mchp_pfsoc_rtc_datetime_upper_read(MchpPfSoCRtcState *s)
+{
+    uint64_t count = s->read_latch_valid ? s->read_latch :
+                     mchp_pfsoc_rtc_get_count(s);
+
+    s->read_latch_valid = false;
+    return (count >> 32) & RTC_UPPER_MASK;
+}
+
+static uint64_t mchp_pfsoc_rtc_read(void *opaque, hwaddr offset,
+                                    unsigned size)
+{
+    MchpPfSoCRtcState *s = opaque;
+
+    switch (offset) {
+    case RTC_CONTROL:
+        return mchp_pfsoc_rtc_control_read(s);
+    case RTC_DATETIME_LOWER:
+        return mchp_pfsoc_rtc_datetime_lower_read(s);
+    case RTC_DATETIME_UPPER:
+        return mchp_pfsoc_rtc_datetime_upper_read(s);
+    case RTC_MODE:
+    case RTC_PRESCALER:
+    case RTC_ALARM_LOWER:
+    case RTC_ALARM_UPPER:
+    case RTC_COMPARE_LOWER:
+    case RTC_COMPARE_UPPER:
+    case RTC_SECONDS:
+    case RTC_MINUTES:
+    case RTC_HOURS:
+    case RTC_DAY:
+    case RTC_MONTH:
+    case RTC_YEAR:
+    case RTC_WEEKDAY:
+    case RTC_WEEK:
+    case RTC_SECONDS_COUNT:
+    case RTC_MINUTES_COUNT:
+    case RTC_HOURS_COUNT:
+    case RTC_DAY_COUNT:
+    case RTC_MONTH_COUNT:
+    case RTC_YEAR_COUNT:
+    case RTC_WEEKDAY_COUNT:
+    case RTC_WEEK_COUNT:
+        return s->regs[RTC_REG(offset)];
+    default:
+        qemu_log_mask(LOG_UNIMP, "%s: unimplemented device read "
+                      "(size %d, offset 0x%" HWADDR_PRIx ")\n",
+                      __func__, size, offset);
+        return 0;
+    }
+}
+
+static void mchp_pfsoc_rtc_write(void *opaque, hwaddr offset,
+                                 uint64_t value, unsigned size)
+{
+    MchpPfSoCRtcState *s = opaque;
+    bool update_alarm = false;
+
+    switch (offset) {
+    case RTC_CONTROL:
+        mchp_pfsoc_rtc_control_write(s, value);
+        return;
+    case RTC_MODE:
+        s->regs[RTC_REG(offset)] = value & RTC_MODE_MASK;
+        update_alarm = true;
+        break;
+    case RTC_PRESCALER:
+        s->regs[RTC_REG(offset)] = value & RTC_PRESCALER_MASK;
+        break;
+    case RTC_ALARM_LOWER:
+    case RTC_COMPARE_LOWER:
+        s->regs[RTC_REG(offset)] = value;
+        update_alarm = true;
+        break;
+    case RTC_ALARM_UPPER:
+        s->regs[RTC_REG(offset)] = value & RTC_ALARM_UPPER_MASK;
+        update_alarm = true;
+        break;
+    case RTC_COMPARE_UPPER:
+        s->regs[RTC_REG(offset)] = value & RTC_UPPER_MASK;
+        update_alarm = true;
+        break;
+    case RTC_DATETIME_LOWER:
+        s->regs[RTC_REG(offset)] = value;
+        break;
+    case RTC_DATETIME_UPPER:
+        s->regs[RTC_REG(offset)] = value & RTC_UPPER_MASK;
+        break;
+    case RTC_SECONDS:
+    case RTC_MINUTES:
+    case RTC_HOURS:
+    case RTC_DAY:
+    case RTC_MONTH:
+    case RTC_YEAR:
+    case RTC_WEEKDAY:
+    case RTC_WEEK:
+        s->regs[RTC_REG(offset)] = value & RTC_CALENDAR_MASK;
+        break;
+    case RTC_SECONDS_COUNT:
+    case RTC_MINUTES_COUNT:
+    case RTC_HOURS_COUNT:
+    case RTC_DAY_COUNT:
+    case RTC_MONTH_COUNT:
+    case RTC_YEAR_COUNT:
+    case RTC_WEEKDAY_COUNT:
+    case RTC_WEEK_COUNT:
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "%s: unimplemented device write "
+                      "(size %d, value 0x%" PRIx64
+                      ", offset 0x%" HWADDR_PRIx ")\n",
+                      __func__, size, value, offset);
+        return;
+    }
+
+    if (update_alarm) {
+        mchp_pfsoc_rtc_schedule_alarm(s);
+    }
+}
+
+static const MemoryRegionOps mchp_pfsoc_rtc_ops = {
+    .read = mchp_pfsoc_rtc_read,
+    .write = mchp_pfsoc_rtc_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = { .min_access_size = 4, .max_access_size = 4 },
+};
+
+static void mchp_pfsoc_rtc_reset_hold(Object *obj, ResetType type)
+{
+    MchpPfSoCRtcState *s = MCHP_PFSOC_RTC(obj);
+
+    timer_del(s->alarm_timer);
+    s->running = false;
+    s->alarm_enabled = false;
+    s->wakeup_pending = false;
+    s->match_pending = false;
+    s->updated = false;
+    s->read_latch_valid = false;
+    memset(s->regs, 0, sizeof(s->regs));
+
+    s->tick_offset = 0;
+    s->frozen_count = 0;
+    s->read_latch = 0;
+    mchp_pfsoc_rtc_update_irq(s);
+}
+
+static int mchp_pfsoc_rtc_pre_save(void *opaque)
+{
+    MchpPfSoCRtcState *s = opaque;
+    int64_t delta = qemu_clock_get_ns(rtc_clock) /
+                    NANOSECONDS_PER_SECOND -
+                    qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) /
+                    NANOSECONDS_PER_SECOND;
+
+    s->tick_offset_vmstate = s->tick_offset + delta;
+    return 0;
+}
+
+static int mchp_pfsoc_rtc_post_load(void *opaque, int version_id)
+{
+    MchpPfSoCRtcState *s = opaque;
+    int64_t delta = qemu_clock_get_ns(rtc_clock) /
+                    NANOSECONDS_PER_SECOND -
+                    qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) /
+                    NANOSECONDS_PER_SECOND;
+
+    s->tick_offset = s->tick_offset_vmstate - delta;
+    s->read_latch_valid = false;
+    mchp_pfsoc_rtc_update_irq(s);
+    mchp_pfsoc_rtc_schedule_alarm(s);
+    return 0;
+}
+
+static const VMStateDescription vmstate_mchp_pfsoc_rtc = {
+    .name = TYPE_MCHP_PFSOC_RTC,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .pre_save = mchp_pfsoc_rtc_pre_save,
+    .post_load = mchp_pfsoc_rtc_post_load,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(regs, MchpPfSoCRtcState,
+                             MCHP_PFSOC_RTC_REGS),
+        VMSTATE_INT64(tick_offset_vmstate, MchpPfSoCRtcState),
+        VMSTATE_UINT64(frozen_count, MchpPfSoCRtcState),
+        VMSTATE_BOOL(running, MchpPfSoCRtcState),
+        VMSTATE_BOOL(alarm_enabled, MchpPfSoCRtcState),
+        VMSTATE_BOOL(wakeup_pending, MchpPfSoCRtcState),
+        VMSTATE_BOOL(match_pending, MchpPfSoCRtcState),
+        VMSTATE_BOOL(updated, MchpPfSoCRtcState),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static void mchp_pfsoc_rtc_init(Object *obj)
+{
+    MchpPfSoCRtcState *s = MCHP_PFSOC_RTC(obj);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+
+    memory_region_init_io(&s->iomem, obj, &mchp_pfsoc_rtc_ops, s,
+                          TYPE_MCHP_PFSOC_RTC, RTC_MMIO_SIZE);
+    sysbus_init_mmio(sbd, &s->iomem);
+    sysbus_init_irq(sbd, &s->irq_wakeup);
+    sysbus_init_irq(sbd, &s->irq_match);
+    s->alarm_timer = timer_new_ns(rtc_clock, mchp_pfsoc_rtc_alarm, s);
+}
+
+static void mchp_pfsoc_rtc_finalize(Object *obj)
+{
+    MchpPfSoCRtcState *s = MCHP_PFSOC_RTC(obj);
+
+    timer_free(s->alarm_timer);
+}
+
+static void mchp_pfsoc_rtc_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+
+    rc->phases.hold = mchp_pfsoc_rtc_reset_hold;
+    dc->vmsd = &vmstate_mchp_pfsoc_rtc;
+}
+
+static const TypeInfo mchp_pfsoc_rtc_info = {
+    .name = TYPE_MCHP_PFSOC_RTC,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(MchpPfSoCRtcState),
+    .instance_init = mchp_pfsoc_rtc_init,
+    .instance_finalize = mchp_pfsoc_rtc_finalize,
+    .class_init = mchp_pfsoc_rtc_class_init,
+};
+
+static void mchp_pfsoc_rtc_register_types(void)
+{
+    type_register_static(&mchp_pfsoc_rtc_info);
+}
+
+type_init(mchp_pfsoc_rtc_register_types)
diff --git a/hw/rtc/Kconfig b/hw/rtc/Kconfig
index 315b0e4ecc..0d53546adc 100644
--- a/hw/rtc/Kconfig
+++ b/hw/rtc/Kconfig
@@ -14,6 +14,9 @@ config M48T59
 config PL031
     bool
 
+config MCHP_PFSOC_RTC
+    bool
+
 config MC146818RTC
     depends on ISA_BUS
     bool
diff --git a/hw/rtc/meson.build b/hw/rtc/meson.build
index 6c87864dc0..4a666bfc94 100644
--- a/hw/rtc/meson.build
+++ b/hw/rtc/meson.build
@@ -3,6 +3,7 @@ system_ss.add(when: 'CONFIG_DS1338', if_true: files('ds1338.c'))
 system_ss.add(when: 'CONFIG_M41T80', if_true: files('m41t80.c'))
 system_ss.add(when: 'CONFIG_M48T59', if_true: files('m48t59.c'))
 system_ss.add(when: 'CONFIG_PL031', if_true: files('pl031.c'))
+system_ss.add(when: 'CONFIG_MCHP_PFSOC_RTC', if_true: files('mchp_pfsoc_rtc.c'))
 system_ss.add(when: ['CONFIG_ISA_BUS', 'CONFIG_M48T59'], if_true: files('m48t59-isa.c'))
 system_ss.add(when: 'CONFIG_XLNX_ZYNQMP', if_true: files('xlnx-zynqmp-rtc.c'))
 
-- 
2.53.0


