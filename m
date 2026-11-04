Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE39606A31B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 15:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=KLBdPA+V
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOd8g-0001kK-28; Wed, 04 Nov 2026 10:43:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xOd8c-0001it-NU; Wed, 04 Nov 2026 10:42:59 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xOd8Z-0001Gk-Jj; Wed, 04 Nov 2026 10:42:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iaHUqqlbJbX9GSCFpsP+rs6BwJGgaB2WLl5WW6oJxu6itP3qRvklU+qQs4F9ODGw5QsJ8nmWEvwF+INLtc46jyzikxOO+Dh4zEWu14GDM2CN+/xjOSCP8Ay2RuKKSfGq/J+/yWRhUin2k60p+IajPFgAbl3zHaabXl1//GYrzhSPat+LhGCcwZx1hW+Ub0Z43c5tjPvtc0eu5gV+5HvpbJqBsy+1RtwpL06WWZpWn92EwAmLEf+oygCB25K5BUYQ6b7aayzUMUkLP/wxaSK6czNkduBWUztMeb8MJVvhUkxLcoqp07lEkrqgsM1KlUu1Jwahpz0jDesJBVT7ZnfGUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U+xSailkeQQWcAojrTIjhZyx2WdMKq0nx/fD8MA/Shk=;
 b=qDJuWueTX7TUw7YrN1rO5Xn1YBJQvoisQ1H2sle9nt3eeBQz92Dn49veqPD+j2XCkzz9472YO2gwF2SQnQ13vF6lVJ79HwFahmE7cmWAAfxlmO6lHwhHojjqZdz0FFkwD1dMBnp5o08JiiaPdwchxU/XxfmRr+Wzj9Gxq0MDAmlhJGGa0rl2lsxmfZ9URn74kPzMuwXBdgyAAapFD6zcwpOI1WTV9NJS0NeqLAtQFdJ5F3Ao3jfbn9X0n6tz+rJeOrg5f/AFWleqXML8upyV/qiX4ORvtoK5g5reMWZqNtTgPOqrN4v6pLK4dB4TQVd0nXUycJWGYStatoooEwxVTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U+xSailkeQQWcAojrTIjhZyx2WdMKq0nx/fD8MA/Shk=;
 b=KLBdPA+VqOvhcntM3bs+tHv0rrrBJcYMVyW0z3XvcF9WsLuaBsN0kcpen9MTqV8xWQ7B1Urro1OqkGghuMlnXdA+++7yk0px/vpqRgbJsvc8bcTwj+EKeTFpSR6rVsGGRFbCsuf1ldjUpGDS5JXIXFX/wAvMHYvQmaNMSyLC7SmtWt5KD8jhGS2cRKalhQusckEYlQZTyBRrut7o0hzZKfFm5hr4R7VzekpbG2UCE0aVTm7CbPKSc4LzUboOgyQsFQ5lCjH2YFzIEzk0J7hUqh8XOZaty4unTli8DQltVOBsL2eWQAi0IflQYxuAL7mUrwhxDjs8o9t5b+82NbpgJQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com (2603:1096:405:2c::12)
 by SEZPR02MB7162.apcprd02.prod.outlook.com (2603:1096:101:190::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Wed, 4 Nov 2026
 15:42:50 +0000
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10]) by TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10%5]) with mapi id 15.21.0592.009; Wed, 4 Nov 2026
 15:42:49 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Conor Dooley <conor.dooley@microchip.com>, Conor Dooley <conor@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Sebastian Huber <sebastian.huber@embedded-brains.de>, qemu-riscv@nongnu.org
Subject: [PATCH v5 13/26] hw/rtc: Add PolarFire SoC RTC model
Date: Wed,  4 Nov 2026 23:41:40 +0800
Message-ID: <20261104154207.641511-14-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261104154207.641511-1-bin.meng@processmission.com>
References: <20261104154207.641511-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0056.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36b::16) To TYZPR02MB7121.apcprd02.prod.outlook.com
 (2603:1096:405:2c::12)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR02MB7121:EE_|SEZPR02MB7162:EE_
X-MS-Office365-Filtering-Correlation-Id: 79c86d9d-fda2-44cd-e6b6-08df3a8a47bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|260925021311599003|260925021911599003|260925022911599003|56012099006|261022105027099003|261021121427099003|261009223027099003|261021123027099003|261022075727099003|261102123227099003|261022113327099003|261026121527099003|261026140227099003|261028144727099003|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: P+jM1ssxIdJAUBifRjyX7c90Tbocr0KDZst1Y7BcvgTbtpjkqEI/pklv7ygONUBnaTHqv12Mvo1CvdzueZ8m0MnJ+80T1j8Jxgn7R1Q8eKh3MJpT2U5SmU+8NAZJTe0M9VhbGmRWZI11/yAqtMplLS+FicAVa9j+3nRlzAaeAc0PGuKv7zeh6JlRamR96/Wj5CITFDjsgb3GRDoc2g1V2rHjWQvJvhn6NM28j+mltqQNcXLg7Jh0dV98I5fppFU5G4W5Rs9ExEZySWURd7qntAJ/qY+fFx9WoEDBe9FxpOFacHYFY1rzJ64Jr0TXlSptk/Z4SydZzeLTVwhZYqS2LUbkSp/FoQmpx4Hrxfw8P34bKbKCjIDL3qLTlQ2z31lkAZ4pDIjYa8NO/0EzcLjylgWJ+FP3ORHPAicq6F4YPEoJkJt8I5WL9ImwqHoJuHHVN9nzSBCb2fbHyyYoy9lL0JQ+nNheT2VykyUuXjzXcoAqK1DdIZxadJZ6ehCZUuF4fbKh34IbdXpc5YML1snVj8Vq/jW9r3BRtrpjj/w0EwJZbcblL/S0oLTvWaSwNk/Iod9EQzVae9HyTFoR4GHubtv7BI9fuHRr2+OATAe2HhBYcR1Txea4F+TFa6dpnowcxsyuyd48GDfImmvOFImwOofwwjquwMOaweuiUQWOb3w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR02MB7121.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(260925021311599003)(260925021911599003)(260925022911599003)(56012099006)(261022105027099003)(261021121427099003)(261009223027099003)(261021123027099003)(261022075727099003)(261102123227099003)(261022113327099003)(261026121527099003)(261026140227099003)(261028144727099003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SeU7u555nEhN+qXIE2gX698Yj9gCa2yqCg1oWKpF0HQkUZ/KQYf7UImYpy63?=
 =?us-ascii?Q?BcpZ8v4D8Zl0E3VEm/m1ItJRowsc1MKq2RyGkMRLR9+Ohv1aTcVOO3b6pq/y?=
 =?us-ascii?Q?1ajF8U9Zif5IeB1BmqQs9DgktfjQMC1N7kFu1GYHlpCkVaGnzrJRw+Supa8q?=
 =?us-ascii?Q?Ojksbr7sPpP4ZdYci9RaGXd3zdRq27HcvMTddmBK+rpRZE3Qon1/FQdLKyhv?=
 =?us-ascii?Q?xT8B5+q9l0fv5AIn3KeqqtfoXFeUnr9hEiNipdLfS/6oI4qnuIq0Ggpu7wE8?=
 =?us-ascii?Q?TXf3PxKHxHvxQCIi3nglwgTEytkUTOj77MWjzI6NhiJt4cMuRvXx7I0EJLyK?=
 =?us-ascii?Q?HUu4HBWOIHnnMmSV5o5mlLzeLymQ8H5Wl4xvDTUkAnJwyGhKaQwywCN2Dwvz?=
 =?us-ascii?Q?fAzhnbNS7UgnvpRiQO6XKJn5r0tkNfwRlnBE6QoVJZpUIaZvdePQX5kPR5d+?=
 =?us-ascii?Q?/NQwh2OFahCy6eNIc5je9+i+rulclAN4wWZndx8EKJEMOzrYG6dwb9RBimSc?=
 =?us-ascii?Q?jBkDAEhEM/86+MZjjOROPSi2Gl4oNpMScTugYIWDLmiieHEsWPCDpVLEWuxh?=
 =?us-ascii?Q?0Lkl68Pc21wUR5NtfZ2g+agkS/Nlez3c6InNiokd6LBQqV5Y2cFTw43O27yw?=
 =?us-ascii?Q?zYpW+47bb35RqHC0AE1U7Zwehd46baFTlWcxkJXFl5wVBDaASU4+jmHmhNXA?=
 =?us-ascii?Q?a+ezKzDJ2cnbNF2LSesw+uggI7UklaqTRG0VNeRtAH8/ut281dfVyFGirsYu?=
 =?us-ascii?Q?vBjRICGk88yisZ+zngwsbhNtO9YmMPeIxVyrPASWJEaA+r3yM+7iMS8uJV8P?=
 =?us-ascii?Q?XgWmq9HYuVPXocWehxbx21xYfwuwP1N7f6iFqEJOggTK+USOamHhTwPh7qAB?=
 =?us-ascii?Q?SsBqJdLRXYbOcbirJ9wP27j5NugCCpSEiFhy2yzXF52mO7ugaLOhhKDGHPbJ?=
 =?us-ascii?Q?fVgp/5cEDrpM9vlJuFKEyd+Gr/GoMab+2DEzQDCiQtEShtA9+GILIGWqO1o7?=
 =?us-ascii?Q?9aH+z7CE/Cc94miIvozWfU/BZRPTcxoFz7UiQ8JCM1fdeAxLnz5xr34TLKTt?=
 =?us-ascii?Q?eXUHaT5NFPOTTfhx0TmUHiEtVP5f20pCo49KmhyPK8lpbD/5Z8ziSBg9j9ZN?=
 =?us-ascii?Q?vrfgK2lRiPBth9D3786MG7Ov6SC04YRik+xfWaAw1MrFRJBrvNho8tXj8HM5?=
 =?us-ascii?Q?nmc16yX66UiG2c36GnvoqdEP1l74mmIsHyi5uvyhR30ktYNEIyRWvNjrJJKt?=
 =?us-ascii?Q?3mdVQAp9VC3yoZGBxLpy5UpNHiuQOY2aohNZ6ZJg301PA3XU5hbH6IQsDp8n?=
 =?us-ascii?Q?1wHbipQl4WjXgyvOy2Y5g1cXUgfsDUkeZlGyuZK+T1NuBr8EaC8R8ns7Ida6?=
 =?us-ascii?Q?tf80d98BxGiy2gIH2+M72T/rvA+fl8ifZfF7jr1WqJFyDVvODNmUaI/LjFd/?=
 =?us-ascii?Q?YMtyCB8q2bgOIcupPYkaP032aOOFIKEk6O2MC7C4VB91zw/MUTwTTDHVvaU2?=
 =?us-ascii?Q?MxTVaYX3CFCCSIGTg/S6jv2MnqfrXrBtwh1OQEREqo2ly/0V/+O4wWO7R37u?=
 =?us-ascii?Q?fyRkNEzAenk+4YDkUO1HFrg0EhbzAv+bsqJfJrLe43l5xkY7Co6STSYU2Y2/?=
 =?us-ascii?Q?dAu9krGgUlvd3f+wnOVy2oTJtR00tM68fKyWzDWPvvp03q5JSo3b59kh3c8c?=
 =?us-ascii?Q?PYo2EkRVCv8bOLNjNqChNrKaYiBUFgCsxiKV7SMsovWFIPNi2PpHQlc1yWRH?=
 =?us-ascii?Q?/f5w7ey+txpVzKMtz5lmkFKP1C58zaw=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79c86d9d-fda2-44cd-e6b6-08df3a8a47bd
X-MS-Exchange-CrossTenant-AuthSource: TYZPR02MB7121.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 15:42:49.5152 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GKGrP9aQpIizGj1DThE3xr458YMyZAGlYDhczM/ap0btkg7fR6vYaTZjCcNte96WdmfjwqGkQUVi2hC1isKqE7ZRRo1q4ztvOhvcC/9Zb4Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR02MB7162
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=bin.meng@processmission.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The PolarFire SoC exposes an RTC with binary and calendar modes,
programmable prescaling, alarms, and wakeup and match interrupts.

Add a standalone device model with explicit MMIO handling for time,
commands, alarms, interrupt state, reset, and migration. Add its
Kconfig and Meson entries and list it under the PolarFire SoC
maintainer section.

Reset the device to its documented hardware values, with the binary
counter stopped at zero.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
Tested-by: Conor Dooley <conor.dooley@microchip.com>

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
index 3c305d570f..a4e33654ef 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1827,11 +1827,13 @@ F: hw/char/mchp_pfsoc_mmuart.c
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


