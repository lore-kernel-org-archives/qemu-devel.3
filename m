Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46F0FCA5FEF
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2026 17:08:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xD39q-0007dA-A8; Sat, 03 Oct 2026 13:04:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xD395-0007E1-W1; Sat, 03 Oct 2026 13:03:36 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xD393-0007C3-Jp; Sat, 03 Oct 2026 13:03:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GWE47VCuiAe89lXOiLD+EIBskJBSH66n5gV3WDVzi/cB6t5nAmj/5wJI9mD1fDonXs8aAvz30ZFsCO9w2ivsFigHmIXltkFLHwPMTNUHQ1RURl6WjcLyTK35K3tjeaPWaG17Qnk+UgJakMJces44VaM1HqnBAhJZb3ZYuciuDhxWSn42YOPXESkCsL8+LYrLaL0uIYMG21SrUkl7qFkStvqWQGW4VuHGBVArCYo9o4QMBi7CZWUW0s8qaptsgrAYMuuKDOEET6GA9ShYA02aZ4s5iBJXjGws4VPrLAmlU/JLfL0GNY4gCgZ7mkVRm6HEkImZbiCoOawuiu6LVCfUdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wA3BA7OutnYyHWGaWmJ/FtcXwKzQ8aDAvG9adRJtIHo=;
 b=fMAIpi3DRp4FyzWYwU/a0ZIofXS/fGoCFYJnK45UaEldg+qCBswNp0pRW2bRCnTDuLo8FSERFghu58sK6stzFp/nkG/Lfc7I7kENQExCMQIRLoBeVqM6S8IUelqqCX48iAPBofjanPD53dBcoKzPP7Bhv13Xoov1GoZw7MRc3pjR9uqJ9pGpJ9Fn+gaLKhdFk8CzmB88qQ0YvZC94mcduXkBtftw9rRevyTHlBav9IpGNr7c8NRnFVWSJWkYRhvgQ0tRWl9cquG5yMjVbqEy8qR43GTKRpOPZhT8EAxQmQWVrD26V5LTQvihX/jT1ZZUdGheMSCJ1A5wkVqmcA6F7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wA3BA7OutnYyHWGaWmJ/FtcXwKzQ8aDAvG9adRJtIHo=;
 b=vW8ZFT7pItDsh852TSQY3kOaKtVfsZUD3aK3DAkaOxhcMwvrx+K7huP9Z/1cyZ8dIcmbStNGMqj4ex0yJDGRedI2sv2y3uemfu+KtalXf07m2vYwQlaHq2rvC1Xlrd4SMY9sr+Vh4uGEEvOYBGVsoNbWje6mXgAlm7B4f5bkDGDogCWNrVflROksE331YE0mIyCTI0uunVsC16xk8mA/acK7fV+0gjGOVCQ6hG6ndCx76+VxCl2do33DeevNSqWS4xRJdrU1hQqE5tDTahCKo9L5GpEczjI+ItyfyBiCuhmIIVx8/7FGmy/v0qCM8qg3NV3pyqraZnM9XdHKUaBVcQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com (2603:1096:820:da::11)
 by TYSPR02MB7371.apcprd02.prod.outlook.com (2603:1096:405:39::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Sat, 3 Oct
 2026 17:03:22 +0000
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215]) by KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215%6]) with mapi id 15.21.0472.016; Sat, 3 Oct 2026
 17:03:21 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Wadim Mueller <wafgo01@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-block@nongnu.org
Subject: [PATCH v3 10/27] tests/qtest: add Cadence SDHCI ADMA pacing/MMIO
 reproducer
Date: Sun,  4 Oct 2026 01:02:00 +0800
Message-ID: <20261003170232.2450916-11-bin.meng@processmission.com>
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
X-MS-TrafficTypeDiagnostic: KL1PR02MB6257:EE_|TYSPR02MB7371:EE_
X-MS-Office365-Filtering-Correlation-Id: 17fc46eb-d687-44f0-f549-08df21703adf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|6133799003|18002099003|22082099003|56012099006|5023799004|260925021311599003|260925022911599003|260925021911599003|10067099003;
X-Microsoft-Antispam-Message-Info: e9ARo++zSyH4vLfkJodGJ/2ECVGR2zr0c2qz+9x+/W6A9DvwXpCW7fg9v/hL4wjK5X93Ueb+v5uha6251z6t10vFsIUOb1KN1zKvy8erosMhLsHQDOU0d+jqkxjFYgbdGJKT0iI0F3RnQi03xmWbPMeYIXIRMPf7RP317vlQOIu4nir59/YwizAVtMax0ibe56AUuVdwMCH2xKz51S0uKp7/hWJGU81KUFfeaaidTcCrY4gy3AYeYjrO+PtJUvGK38lvy2PoKtCI3ij1n18oYRDZmmPrw1T6BMzLqjay27JzacIzXhW6R03DdTqrghv20J1sAhNSD450EJ3FlBrKYdyTCBPAl7WnRdie+/8U8r3ac+TVbt9zu/bDrBx2J6gwDSUQ2Anf7KFNYHf7hteyJeE1xM0bzy1Odwf20sOlvF+q35RPjaC/AFk6Btva7mleeN6UKnEK5DUQvMz4BfDMAtaP0VDzvmz8iQR7ybIbG5XPa3X/sxeojm5Aow1oPf29gykNoKy+SQ7nmr9M5v7dCPCozjCej1/hOoJ/vEyDG/ELGU5A2FyuT6z6CIlwaRvIqHt4PjT20DrV8ROawApmgkqGVbVEvc2mtEumH8whT0S+VXgakTWAXnO9GhXSY03zNGmrb/AZ89JeLt7YdtBOtzu28VIYB2Ws/Vw2ymIharc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB6257.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(6133799003)(18002099003)(22082099003)(56012099006)(5023799004)(260925021311599003)(260925022911599003)(260925021911599003)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OJftIqAeEBI/39ewHlBqMAy1iKj1pdKokf9SPJpmx+HmU2nc6TJb0SJDrBbu?=
 =?us-ascii?Q?BGGN5sHxpE1M522x3nYtJMuKFbw9eZBLLd0bXcq1S8ZdkfRo4gEvPdZAXSwx?=
 =?us-ascii?Q?OOGVLNHBlkTVEy8crpOSjkiJr+l5ncO35BVWA9/kLt/E6A9zLLMkS2+PSCAx?=
 =?us-ascii?Q?Zh+H5PgsmFNh/xDCoimm6je5ZFOsLOziveYBCnYB/JY88C+2VoGjSL4uoc8J?=
 =?us-ascii?Q?qUbK6qVeFGQdslbEOSIbLGvEzQU0v3Y4dCzXf5uDCQKqeFx7Xw63hLZUwZZt?=
 =?us-ascii?Q?ZWa2kaIgxdwQzIEUeIihCdjcxYxIQV4bQYSXqbRZne8CTe4tsW54MfxNMKWV?=
 =?us-ascii?Q?tLy3BjWImJ3J/9qymfKhZEz4XMobDoIi59BwEkNhHWa0G98fj60lK1synCM1?=
 =?us-ascii?Q?ZRZR04NVWn1t1TO7u2LjXVKQCDTWMkZ8LwxBxOQRAnBDko2tVpmDE6pwv6MH?=
 =?us-ascii?Q?KZwlg653IiHenz+ZwiMUxYZ5F8PWLYYeQMx6LTgjv1vIU2yJWN2fuosmsjog?=
 =?us-ascii?Q?EnIc7vK/PcHdRRn7UPtNy3NBlNn8S79NWEWDCfW6kRgaetU2K7IP9x2WdwfU?=
 =?us-ascii?Q?a7xtXJ2EpmS4dviwEvAUQ/+w7hH8C+iF2rICGFJ51w3aw8N+u9Zkn/7t/uo5?=
 =?us-ascii?Q?ykYNpZmFTH4woV3Oe9okAWk+G8lrhaj9/sjNDk7f78hV3Q7irtDo5Mj5Orak?=
 =?us-ascii?Q?+Td6IeQpOjphbBKa0wxpaxScSuT44SlbQJSZayUG2yxFM+c0SVFOO2EA6x8w?=
 =?us-ascii?Q?G5eSwZlLiSq2TT1EHNgyNSvNJu9V/624gmykdIPmQo3v/0Tx6NwHhZEYR0lx?=
 =?us-ascii?Q?VrxbgZM16mMr1vJt1qA5khHEziTzGMldeQ0yToryUUnZwY3i3pv67aivWwbS?=
 =?us-ascii?Q?0CMo9WILAtoouuKT2mx7+nrBwQLHPcpDThKLHJX0sDW8AkvXsjhPlEjtWo+0?=
 =?us-ascii?Q?njaIH/w4OhMIECtG9kWadBHI0o2nPDOw1QS+hBxJhsc85U6pgLlrFcX1oGlZ?=
 =?us-ascii?Q?qGW1WBGbKu2Tq1O255B3/U5TZE466IH4bub7v0pu59eocNTPzacVYPH3mtQc?=
 =?us-ascii?Q?wWbVx01QIaOSAlxtVYAgaONI4HiC7Jh/Zoa9zLFF7vFDmmLqI5KMbu3nvH+L?=
 =?us-ascii?Q?9Gd9D/TLDXAH8ImIDZ8klhnLLUFFDIFEuWQ8puV6iHUumCeZDXWJbWUNUW9t?=
 =?us-ascii?Q?mgNSQFDjEbfK2a1jodtqyGfeiVGr7h1UqHnQAsRjJA8SaYQK2kMpX5Md0QLX?=
 =?us-ascii?Q?1k6oiR1OPcs4/4WhMk/Iq41Y+ZkPkYSCkavKeLc8D6cedtlEPmzQg/StSAVj?=
 =?us-ascii?Q?roWRH3hGUBANg8UmNp30OY0Gn0HsIsT3TarCmv1RUv0Hsvs0PEbIFQYsV10K?=
 =?us-ascii?Q?O0VJuFZq4jt92bXWMDncLcF/Po81uRVvgYUwH3Lfktl9L40SbEQlGsk4a+iz?=
 =?us-ascii?Q?dfKyfzBlQ6ZWU5PES9coF8PdnITL/IktVTju36Se+TBmWWyl73LsJ4olPfpO?=
 =?us-ascii?Q?HS6IAhmYy/nE8QOLCV3K2XYY7KNtI2RGh3ccW0hUtXKnyW2Hh+s8bGU25TdH?=
 =?us-ascii?Q?9zMAz9UGSdc9sZTcFdbLGGWXG+rbcLsSw4VeN/QmOSmXu8q2p7Net3TxZdwv?=
 =?us-ascii?Q?jrVCtkRI+PAOlqpJvZKsEiVD0BdiHJXVXN2ZPMAVWmU0jR9Zysdw/Z17M2qM?=
 =?us-ascii?Q?c14DMk7jG5AspnD6I7di49n2vtcBHPJvyFTHzCWP9EB58lNftR7ztZcEqsdl?=
 =?us-ascii?Q?sNqukQbomn7DU+WXhs8V302Z6W8If1Q=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17fc46eb-d687-44f0-f549-08df21703adf
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB6257.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2026 17:03:21.8999 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LAI/iAh/c/Z1inCVV3/T7Vz1qYNhht9WB0YLs9ECQj7xNr7/oIHAkwjlo4yGxyP3ZH+O0dDKBzKJCdzjIrKzfLrCPeJfyF3iU4C34YWo8Rw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR02MB7371
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Wadim Mueller <wafgo01@gmail.com>

Add an image-free qtest for the microchip-icicle-kit machine that drives
the generic SDHCI model (hw/sd/sdhci.c) through the Cadence wrapper
(hw/sd/cadence_sdhci.c, SRS window at 0x20008200) directly over MMIO
under "-accel qtest", where QEMU_CLOCK_VIRTUAL only advances when the
test steps it.

It reproduces two aspects of the ADMA2 engine objectively, without any
guest firmware:

  1. Pacing: a 12-descriptor (> SDHC_ADMA_DESCS_PER_DELAY) non-interrupt
     ADMA2 CMD18 read completes after a model-dependent number of
     SDHC_TRANSFER_DELAY virtual-clock steps, which the test reports.

  2. MMIO coupling: a chain carrying a DMA-boundary interrupt descriptor
     yields mid-chain and reschedules on the virtual clock. With the
     clock frozen, an interrupt-status read must not itself resume or
     complete the transfer. This asserts the behaviour intended by "Run
     ADMA independently of MMIO": it passes on the fixed model and fails
     on a model that resumes ADMA from an MMIO read.

The SD bring-up (CMD0/CMD8/ACMD41/CMD2/CMD3/CMD7/CMD16) and the ADMA2
descriptor-table layout mirror the pattern already used by the SDHCI
device model; SDHCI register offsets and ADMA attribute bits are
reproduced locally because sdhci-internal.h is not standalone-includable
from a qtest.

Signed-off-by: Wadim Mueller <wafgo01@gmail.com>
[bmeng: strengthen checks, reuse SDHCI helpers, verify data]
Signed-off-by: Bin Meng <bin.meng@processmission.com>


---

(no changes since v2)

Changes in v2:
- Assert bounded ADMA pacing and MMIO-independent progress
- Reuse existing SDHCI definitions and command helpers
- Verify transferred data against a known image pattern
- New

 MAINTAINERS                      |   1 +
 tests/qtest/cadence-sdhci-test.c | 282 +++++++++++++++++++++++++++++++
 tests/qtest/meson.build          |   2 +
 3 files changed, 285 insertions(+)
 create mode 100644 tests/qtest/cadence-sdhci-test.c

diff --git a/MAINTAINERS b/MAINTAINERS
index acb79a7d61..65325450e0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2425,6 +2425,7 @@ F: include/hw/sd/sd*
 F: hw/sd/core.c
 F: hw/sd/sd*
 F: hw/sd/ssi-sd.c
+F: tests/qtest/cadence-sdhci-test.c
 F: tests/qtest/fuzz-sdcard-test.c
 F: tests/qtest/sdhci-test.c
 F: tests/qtest/xilinx-zynq-sdhci-test.c
diff --git a/tests/qtest/cadence-sdhci-test.c b/tests/qtest/cadence-sdhci-test.c
new file mode 100644
index 0000000000..71c1e53333
--- /dev/null
+++ b/tests/qtest/cadence-sdhci-test.c
@@ -0,0 +1,282 @@
+/*
+ * QTest for Cadence SDHCI ADMA2 pacing / MMIO coupling on the Microchip
+ * PolarFire SoC Icicle Kit (microchip-icicle-kit).
+ *
+ * Drives the generic SDHCI model (hw/sd/sdhci.c) through the Cadence wrapper
+ * directly over MMIO under "-accel qtest", where QEMU_CLOCK_VIRTUAL only
+ * advances when the test steps it; no guest firmware runs.
+ *
+ * Copyright (c) 2026 Wadim Mueller <wafgo01@gmail.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/sd/sdhci.h"
+#include "hw/sd/sdhci-internal.h"
+
+#include "libqtest.h"
+#include "libqos/sdhci-cmd.h"
+
+/*
+ * Use the controller definitions and command helper shared with the existing
+ * SDHCI qtests so this reproducer stays in sync with the device model.
+ */
+
+/* Cadence maps the generic SDHCI (SRS) register window at base + 0x200 */
+#define SDHCI_BASE        (0x20008000ULL + 0x200)
+
+/* Scratch in PolarFire DRAM (base 0x80000000): descriptor table + target */
+#define ADMA_TABLE_ADDR   0x82000000ULL
+#define ADMA_BUF_ADDR     0x82100000ULL
+
+#define BLK_LEN           512
+#define NDESC             12      /* > SDHC_ADMA_DESCS_PER_DELAY (5) */
+#define INT_DESC          5       /* ADMA interrupt descriptor */
+#define TRANSFER_SIZE     (NDESC * BLK_LEN)
+
+/* CMDREG response-type encodings (bits [1:0]) */
+#define RESP_NONE         0x0000
+#define RESP_R2           0x0001  /* 136-bit */
+#define RESP_R48          0x0002  /* 48-bit */
+#define RESP_R1B          0x0003  /* 48-bit with busy */
+
+#define ACMD41_ARG        0x40FF8000u   /* HCS + 3.3-3.6V window */
+#define CMD8_ARG          0x000001AAu   /* VHS 2.7-3.6V + check pattern */
+
+static void fill_pattern(uint8_t *buf, size_t len)
+{
+    for (size_t i = 0; i < len; i++) {
+        buf[i] = (i * 13 + 7) & 0xff;
+    }
+}
+
+static void write_pattern(int fd)
+{
+    g_autofree uint8_t *buf = g_malloc(TRANSFER_SIZE);
+    ssize_t written;
+
+    fill_pattern(buf, TRANSFER_SIZE);
+    written = pwrite(fd, buf, TRANSFER_SIZE, 0);
+    g_assert_cmpint(written, ==, TRANSFER_SIZE);
+}
+
+static void check_adma_data(QTestState *qts)
+{
+    g_autofree uint8_t *actual = g_malloc(TRANSFER_SIZE);
+    g_autofree uint8_t *expected = g_malloc(TRANSFER_SIZE);
+
+    fill_pattern(expected, TRANSFER_SIZE);
+    qtest_memread(qts, ADMA_BUF_ADDR, actual, TRANSFER_SIZE);
+    g_assert_cmpmem(actual, TRANSFER_SIZE, expected, TRANSFER_SIZE);
+}
+
+/* Issue an SD command and wait (bounded) for Command Complete */
+static uint16_t sd_cmd(QTestState *qts, uint8_t cmd, uint32_t arg,
+                       uint16_t flags)
+{
+    uint16_t sts = 0;
+    int i;
+
+    sdhci_cmd_regs(qts, SDHCI_BASE, 0, 0, arg, 0,
+                   ((uint16_t)cmd << 8) | flags);
+
+    for (i = 0; i < 1000; i++) {
+        sts = qtest_readw(qts, SDHCI_BASE + SDHC_NORINTSTS);
+        if (sts & SDHC_NIS_CMDCMP) {
+            break;
+        }
+    }
+    g_assert_cmphex(sts & SDHC_NIS_CMDCMP, ==, SDHC_NIS_CMDCMP);
+
+    qtest_writew(qts, SDHCI_BASE + SDHC_NORINTSTS, 0xffff);  /* w1c */
+    return sts;
+}
+
+/* Bring the SD card from idle to transfer state */
+static void sd_bring_up_card(QTestState *qts)
+{
+    uint32_t rca;
+
+    g_assert_cmphex(qtest_readl(qts, SDHCI_BASE + SDHC_PRNSTS) &
+                    SDHC_CARD_PRESENT, ==, SDHC_CARD_PRESENT);
+
+    qtest_writeb(qts, SDHCI_BASE + SDHC_SWRST, SDHC_RESET_ALL);
+    qtest_writew(qts, SDHCI_BASE + SDHC_CLKCON,
+                 SDHC_CLOCK_INT_EN | SDHC_CLOCK_SDCLK_EN);
+    qtest_writew(qts, SDHCI_BASE + SDHC_NORINTSTSEN, 0xffff);
+    qtest_writew(qts, SDHCI_BASE + SDHC_ERRINTSTSEN, 0xffff);
+    qtest_writew(qts, SDHCI_BASE + SDHC_NORINTSIGEN, 0xffff);
+
+    sd_cmd(qts, 0,  0x00000000, RESP_NONE);  /* GO_IDLE_STATE */
+    sd_cmd(qts, 8,  CMD8_ARG,   RESP_R48);   /* SEND_IF_COND */
+    sd_cmd(qts, 55, 0x00000000, RESP_R48);   /* APP_CMD */
+    sd_cmd(qts, 41, ACMD41_ARG, RESP_R48);   /* SD_SEND_OP_COND */
+    sd_cmd(qts, 2,  0x00000000, RESP_R2);    /* ALL_SEND_CID */
+    sd_cmd(qts, 3,  0x00000000, RESP_R48);   /* SEND_RELATIVE_ADDR */
+
+    rca = qtest_readl(qts, SDHCI_BASE + SDHC_RSPREG0) >> 16;  /* R6 */
+
+    sd_cmd(qts, 7,  rca << 16,  RESP_R1B);   /* SELECT_CARD */
+    sd_cmd(qts, 16, BLK_LEN,    RESP_R48);   /* SET_BLOCKLEN */
+}
+
+/*
+ * Build a 32-bit ADMA2 table: per 8-byte entry word0 = (len << 16) | attr,
+ * word1 = target address.  When int_desc >= 0 that descriptor also carries
+ * the ADMA descriptor interrupt attribute, so the model yields mid-chain
+ * (rescheduling on QEMU_CLOCK_VIRTUAL) instead of running to completion.
+ */
+static void build_adma_table(QTestState *qts, int int_desc)
+{
+    for (int i = 0; i < NDESC; i++) {
+        uint8_t attr = SDHC_ADMA_ATTR_VALID | SDHC_ADMA_ATTR_ACT_TRAN;
+        uint32_t addr = (uint32_t)(ADMA_BUF_ADDR + (uint64_t)i * BLK_LEN);
+
+        if (i == int_desc) {
+            attr |= SDHC_ADMA_ATTR_INT;
+        }
+        if (i == NDESC - 1) {
+            attr |= SDHC_ADMA_ATTR_END;
+        }
+        qtest_writel(qts, ADMA_TABLE_ADDR + (uint64_t)i * 8,
+                     ((uint32_t)BLK_LEN << 16) | attr);
+        qtest_writel(qts, ADMA_TABLE_ADDR + (uint64_t)i * 8 + 4, addr);
+    }
+}
+
+/* Program the ADMA2 engine, descriptor pointer and transfer geometry */
+static void program_adma_read(QTestState *qts)
+{
+    qtest_writeb(qts, SDHCI_BASE + SDHC_HOSTCTL, SDHC_CTRL_ADMA2_32);
+    qtest_writel(qts, SDHCI_BASE + SDHC_ADMASYSADDR, (uint32_t)ADMA_TABLE_ADDR);
+    qtest_writel(qts, SDHCI_BASE + SDHC_ADMASYSADDR + 4,
+                 (uint32_t)(ADMA_TABLE_ADDR >> 32));
+    qtest_writel(qts, SDHCI_BASE + SDHC_BLKSIZE, BLK_LEN | (NDESC << 16));
+    qtest_writew(qts, SDHCI_BASE + SDHC_TRNMOD,
+                 SDHC_TRNS_DMA | SDHC_TRNS_BLK_CNT_EN |
+                 SDHC_TRNS_READ | SDHC_TRNS_MULTI);
+    qtest_writel(qts, SDHCI_BASE + SDHC_ARGUMENT, 0);  /* start block 0 */
+    qtest_writew(qts, SDHCI_BASE + SDHC_NORINTSTS, 0xffff);
+    qtest_memset(qts, ADMA_BUF_ADDR, 0xa5, TRANSFER_SIZE);
+}
+
+/* CMD18 READ_MULTIPLE_BLOCK with data present -> kicks off ADMA */
+static void kick_cmd18(QTestState *qts)
+{
+    qtest_writew(qts, SDHCI_BASE + SDHC_CMDREG,
+                 (18 << 8) | SDHC_CMD_DATA_PRESENT | RESP_R48);
+}
+
+/* Start a card-carrying icicle machine and bring the card to "tran" */
+static QTestState *icicle_start(char **tmp)
+{
+    int fd;
+    GError *err = NULL;
+    QTestState *qts;
+
+    fd = g_file_open_tmp("icicle-sdhci-XXXXXX.raw", tmp, &err);
+    g_assert_no_error(err);
+    g_assert_cmpint(fd, >=, 0);
+    g_assert_cmpint(ftruncate(fd, 1 * 1024 * 1024), ==, 0);
+    write_pattern(fd);
+    close(fd);
+
+    qts = qtest_initf("-machine microchip-icicle-kit -accel qtest "
+                      "-display none -drive if=sd,file=%s,format=raw", *tmp);
+    sd_bring_up_card(qts);
+    return qts;
+}
+
+/*
+ * Facet 1 -- pacing.  A non-interrupt chain completes after a bounded number
+ * of SDHC_TRANSFER_DELAY steps.  With 12 descriptors and a quota of five per
+ * batch, completion requires exactly three virtual-clock steps.
+ */
+static void test_adma_pacing(void)
+{
+    char *tmp = NULL;
+    QTestState *qts = icicle_start(&tmp);
+    const int expected_steps = DIV_ROUND_UP(NDESC,
+                                            SDHC_ADMA_DESCS_PER_DELAY);
+    uint16_t sts;
+    int steps = 0;
+
+    build_adma_table(qts, -1);
+    program_adma_read(qts);
+    kick_cmd18(qts);
+
+    while (!((sts = qtest_readw(qts, SDHCI_BASE + SDHC_NORINTSTS)) &
+             SDHC_NIS_TRSCMP)) {
+        qtest_clock_step(qts, SDHC_TRANSFER_DELAY);
+        steps++;
+        g_assert_cmpint(steps, <=, expected_steps);
+    }
+
+    g_assert_cmpint(steps, ==, expected_steps);
+    g_assert_cmphex(sts & SDHC_NIS_TRSCMP, ==, SDHC_NIS_TRSCMP);
+    g_assert_cmphex(sts & SDHC_NIS_ERR, ==, 0);
+    check_adma_data(qts);
+
+    g_test_message("ADMA %d descriptors: %d clock steps to Transfer Complete",
+                   NDESC, steps);
+
+    qtest_quit(qts);
+    unlink(tmp);
+    g_free(tmp);
+}
+
+/*
+ * Facet 2 -- MMIO coupling (regression for "Run ADMA independently of MMIO").
+ * With the clock frozen, a bare interrupt-status read must not resume the
+ * transfer left pending by the mid-chain interrupt descriptor: Transfer
+ * Complete must still be clear.  A model that resumes ADMA from an MMIO read
+ * completes it on that bare read and fails the assertion.
+ */
+static void test_adma_mmio_coupling(void)
+{
+    char *tmp = NULL;
+    QTestState *qts = icicle_start(&tmp);
+    uint16_t sts;
+    int steps = 0;
+
+    build_adma_table(qts, INT_DESC);
+    program_adma_read(qts);
+    kick_cmd18(qts);
+
+    qtest_clock_step(qts, SDHC_TRANSFER_DELAY);
+    qtest_clock_step(qts, SDHC_TRANSFER_DELAY);
+
+    sts = qtest_readw(qts, SDHCI_BASE + SDHC_NORINTSTS);
+    g_assert_cmphex(sts & (SDHC_NIS_DMA | SDHC_NIS_TRSCMP), ==,
+                    SDHC_NIS_DMA);
+
+    sts = qtest_readw(qts, SDHCI_BASE + SDHC_NORINTSTS);
+    g_assert_cmphex(sts & (SDHC_NIS_DMA | SDHC_NIS_TRSCMP), ==,
+                    SDHC_NIS_DMA);
+
+    while (!((sts = qtest_readw(qts, SDHCI_BASE + SDHC_NORINTSTS)) &
+             SDHC_NIS_TRSCMP)) {
+        qtest_clock_step(qts, SDHC_TRANSFER_DELAY);
+        steps++;
+        g_assert_cmpint(steps, <, 1000);
+    }
+    g_assert_cmphex(sts & SDHC_NIS_ERR, ==, 0);
+    check_adma_data(qts);
+
+    g_test_message("ADMA coupling: %d clock steps to complete after bare read",
+                   steps);
+
+    qtest_quit(qts);
+    unlink(tmp);
+    g_free(tmp);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+    qtest_add_func("/microchip/icicle/sdhci/adma-pacing", test_adma_pacing);
+    qtest_add_func("/microchip/icicle/sdhci/adma-mmio-coupling",
+                   test_adma_mmio_coupling);
+    return g_test_run();
+}
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 1fe008c9ed..29457193ed 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -311,6 +311,8 @@ qtests_riscv32 = \
 
 qtests_riscv64 = ['riscv-csr-test'] + \
   (unpack_edk2_blobs ? ['bios-tables-test'] : []) + \
+  (config_all_devices.has_key('CONFIG_MICROCHIP_PFSOC') ?
+   ['cadence-sdhci-test'] : []) + \
   (config_all_devices.has_key('CONFIG_SIFIVE_L2CC') ? ['sifive_l2cc_test'] : []) + \
   (config_all_devices.has_key('CONFIG_IOMMU_TESTDEV') and
    config_all_devices.has_key('CONFIG_RISCV_IOMMU') ?
-- 
2.53.0


