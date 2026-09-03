Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B24ACC624A4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 11:31:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x25ao-00063j-CR; Thu, 03 Sep 2026 07:26:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x25an-00062H-9t; Thu, 03 Sep 2026 07:26:53 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x25ak-0006gK-PX; Thu, 03 Sep 2026 07:26:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qI6Clc6D12vjGKB01xMAcSCDyETV63T2wZzw0fAZ0hdNOh2WPXok41jennhvwWCH1NACI0ovwIsCShLS73Aaayv1XP7dqRiwn/Ybj4MXjeumU5xfp6B3G8Fp53mxzGrb09tgVhewJVNzswUt/qezFvKBbZXJRj6z5apt8vBirK9rsXlUvQRL9eO/q7vz3B/rvOSJX+8kKmKtUtIUY7APKZw5Q0/XPmLEmADo4IAkULX3epIeylCMvrtL+TqwWw/dnOh2MAEiN0a/WF0HfUSV0KdjyM3Gd7ymRryL9xq2igoEO0EibFrwbd4gvqPYpnm/9T/0kqxGCqTrhcOZFXaHZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YVgyN5T+BhT36Uiw/AnRFYarN4n34p2oj5w411p6Hx0=;
 b=nwlRffsy/4GhYLkHe5fVfLbQoZ0pBySrmt1Hi3ajx+sMkBaCJWWgiqu6u9zmKrCH9cej5srvltWMZMGo9nxlL+vVqa+ptSqMdFy4rjEEGXZkxphJpQm/vMiivm3JY2qP0iKLvwD3yhC1Nq+7e2LQAJib4cQes+1UdDufxv+c7oNfXj3h6TtC6Pr7B/g/9eEM2+5bEXmSdxqW0B9xOcPuF4lyCGuMeR+nJsXRGFNWL8mH4C9fnw/Pjukdse/b+aedaCB6DPd0bHnqTN0hkccjweZkudH7ad+a02krjxLoR2ii8kF8q/I/N0TuiU8qQxWzxknkhX9FybOGcTpc57ONXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YVgyN5T+BhT36Uiw/AnRFYarN4n34p2oj5w411p6Hx0=;
 b=iFse4N6fK6EddYZKEqsPHCS+Z4M8Pd6yC2zxFl38QnKchiMdymN1VHKgrbazQu4tOpnyWoW0f1GsyWIQ0ZxWnSIDqaLCJRFeacTT2d9TaN/79KFNlaKvznFiVUaMuT9i0PeQBe74ocfKgpsVavphxMpT7lRgLna5j97FoFJsm09D0iGzQ7hR/zysw1XM458dN4foRD/sVE4td/y5ZW4ehy1LI3acd/N41xEkNScPz3wioLa3c5lnBGut7K6+60I/iFWXXqN2l56GYBqiBZlA7DunMpQ3uA+h9Y9UOnsSAjziJYCx9jywfT/Tlu+cZ5OD7AGIbigD6q8vJbXFJh66Nw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by TYZPR02MB6358.apcprd02.prod.outlook.com (2603:1096:400:419::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 11:26:18 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0382.007; Thu, 3 Sep 2026
 11:26:16 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Alistair Francis <alistair@alistair23.me>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org
Subject: [PATCH 13/33] hw/ssi: Add Phytium E2000 QSPI controller
Date: Thu,  3 Sep 2026 19:24:53 +0800
Message-ID: <20260903112532.3276678-14-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903112532.3276678-1-bin.meng@processmission.com>
References: <20260903112532.3276678-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0026.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b0::11) To KL1PR02MB4977.apcprd02.prod.outlook.com
 (2603:1096:820:71::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|TYZPR02MB6358:EE_
X-MS-Office365-Filtering-Correlation-Id: 9aae019b-030f-4756-7c82-08df09ae2b76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|6133799003|5023799004|56012099006|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: grcMGkys2MUaPsakueNfmP4qRozx8rLmlZ+qpwABSvXpBHb5A6LWtCZV9xpssO6VOjdBR8Wmln4SDcTW+28jJJav6KaGdkzRYYSGB3cMnDupgIAfkUP8lE9jSUo5J9hk7r65LE0EPa5wjlX/dPbO1UsBHCp/qV5FbpPsozxmh7gI6NXpnHrvvEa2oToBgSzo3PA9ZAqvN+X9VswoetMwCy8U7+logeMJzCMvzKwfOgIZ+gdw7oY+5EFaOwMcgqqJ/SkV6aQBNYJZZWIvace76pJbG8YHSkg6qQXqEzx/QGAgdkXrZzlkcd/dk/tfWuA87SJMPyeJ/Uv7aBClvBlIfY+sce9Ou8ZPlPzmFV2s59LEa61prcbrSfZzDdJ8NvJMIIxvMkfly1LPlZCct7tkAyz33dmC5TT4YTkqZfYF8yYu1D9q5s0Chkbx1wGmdtuaBpXf4+uGwVN21eAwxzgB//dG//ovYgE6UpRRe2oLpuFoTKcW2Xlqe8BLQALQ2JGXDQUDW2P5bj9sRfRe99Hp/gl7SUKiWjV/yV84xlmV3Dru0RqRECztSOcoP1+n/vInIkRDEtU35Dn9HU99Df04StrOQN3EsxLI530AJuWlXUBKilMpO3qOCxvkXBOXNCIwu9YlVH8WI+KsYI166NDP22pr2AEfs1AmqKOVlImIAo0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(6133799003)(5023799004)(56012099006)(10067099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kk+4x3gxCb9Yty6yIlGEzw05W0hc6JPr5W+f07lxY1B/Jnkd0nyZebZ74sIL?=
 =?us-ascii?Q?Ie4RV35Dk1Qhu+0xNByywFMHJcHFiOavfTE9cQ6yXq8rNK9259WJc0DfWVej?=
 =?us-ascii?Q?Az0/v6C2ZrPJtPZq42bl59bfLTdXjdf+pOc0u4nxuIV+Ez7L7/+IHa4nhDxf?=
 =?us-ascii?Q?1DbjZj3SmKvnPm8td3Uo+p78P1obv2avIlgVtM82vTuLEsQXeQULrcOqEGtw?=
 =?us-ascii?Q?CCSdh/R9iFDizE9A8OlvYrNvU7au0TCyUR/eR7BitQgo5H03uv96hJoF722R?=
 =?us-ascii?Q?a8qYIavdKqQlGjN7i68UlVFLgmbe9Y0zaEThmM3FifAHufZB9/OPRUvuAH5B?=
 =?us-ascii?Q?GYgCw0TdGvXIEpO5Ewk55LQQJUSLVljajHcLqlBR9Z1fasid5FPJZY8BIAnh?=
 =?us-ascii?Q?e/EKLiCfypczb9fB5khZBAN9UWqIQSpuibCcZ/d3GsUQ0J7yL111aQUWxQqB?=
 =?us-ascii?Q?QE0makTbjIK+otMxCj8q+iIdgg46wLgC1K6peiDnVjwcsju9VqTn7FT3F0Uv?=
 =?us-ascii?Q?si/xp5JA3d8BZXCP+I2kXLLzfO/T9h1vgdIyDxu0DrH/NR+hvS5PGs2ZDKGy?=
 =?us-ascii?Q?a60Y64HrKdjf35SylbGt25QwW6Ez02QxapXn/3dU8BgbxQjyGGH5/2Lh3U78?=
 =?us-ascii?Q?Bb/ExYEGtQkV7RQuMVMg0krXqNaDXFjRPf7JPBy/dTGKelgDPj9yl/xtnH7k?=
 =?us-ascii?Q?gj2Y8NHYWVsMG1OI46uYfsA2tq0D+QFyGVGzJIPUqpHmx18a3RNZ75M/XX2C?=
 =?us-ascii?Q?zU34gZjuiRYbzJfiAO2JK0eUwrc7VEFN74DUkCTSGNe9JLafT+IFi8bWZNYn?=
 =?us-ascii?Q?JAzyARe4uf6yzj2tKGuQQxGtkrbTgIxi3Rl0aZp5QQZkP1H0l1mjkd1eX9bY?=
 =?us-ascii?Q?nBeE9Ngv9GuJ6oVSFQKCxQ2scymdvxmaoRPVz0kgI2jBDDGQIGu2rXmiIElU?=
 =?us-ascii?Q?g5hnQcuOOI4mawamB4LcEcqUhb9RS5qVKgTR2ac9JDLCBEhHa2U/czPvVwZz?=
 =?us-ascii?Q?G5GbecjNq0myQphgq8gqHq7BrPk18rWQjf5DizrXkgjjdSVHhINgEym526MW?=
 =?us-ascii?Q?p9ICr74GQpprxL4dW8iOjrcXtWXL/lTDMF5EQulS0SXw90x51h5GGgs95CHV?=
 =?us-ascii?Q?AhFFo3Foqz1rOLDJRdmrZl18IAhKSbJ1uu3s3YGHQS5zcB0pyP7vOnZxopA6?=
 =?us-ascii?Q?oKLsHa3OSqAwq8rx/KJY9pTuDNgGI3qO1U1MsoG8Ymx+ZxJTVyk1dqNtAUma?=
 =?us-ascii?Q?lICYWplZeyF0um+Fe/MndUQblxRYgT80GqnpIWABqAPSpEVTnnKQLYmcdPSh?=
 =?us-ascii?Q?yZ8wSzmVHBfMZ9aM9r3K/+9/Z+S5hCb4MmmWyhf0oTTyiO/5w8yfa6CJ4Bzf?=
 =?us-ascii?Q?tomtONW3zQ6PR4nR+UjmzLh7F4GWFap36FpcFHhdDTOhI4bqD9l+74A4fHUL?=
 =?us-ascii?Q?d1ga14RGWZ96N4nk1UzPZGzqzNSEjb99rodWWshS4xlP7rZhdmJSO6NNf9Wr?=
 =?us-ascii?Q?UFN4BvNq4sbxOj9Oag7nkm4QoQDTJb9jvXPH/nrgwSC2p3q+p4bZ29uXiXjI?=
 =?us-ascii?Q?qiP0FObj6wZuJNqPk5VqE/e3Wnnjq7q6sDVduTYCoMylvl6e3MsBLJzIuU2x?=
 =?us-ascii?Q?g60yRbqMRhiIbnyVPa66Vj5XBrdrdQeNno3G9XY3CXpv9NsQ0guuF0UuYLfn?=
 =?us-ascii?Q?j2aGzaU2OWfUeWwhYiIyWs8vHLewDPzitZElAuWc1WrtLSR3/WNCNfODtF9d?=
 =?us-ascii?Q?WephqfiCGjIURZHZ2CiRVzdy+ZXZoAw=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aae019b-030f-4756-7c82-08df09ae2b76
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 11:26:16.9626 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P3sLoQ47RkAYyvZrXX0eOszJIksPZ6Ubk9N7rSv4el1FydAdmjPF5nBBqWzJxC3QUMoZXS9+B06UCPSn62SVHY1VHSXDPtdu3gKbVW1rLOw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR02MB6358
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

Phytium E2000Q integrates a QSPI controller which seems to be an
in-house IP. This adds a model for it with command-port and
direct-map paths, and exposes an SSI bus and chip-select output.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

 hw/ssi/Kconfig                |   5 +
 hw/ssi/meson.build            |   1 +
 hw/ssi/phytium_qspi.c         | 398 ++++++++++++++++++++++++++++++++++
 include/hw/ssi/phytium_qspi.h |  23 ++
 4 files changed, 427 insertions(+)
 create mode 100644 hw/ssi/phytium_qspi.c
 create mode 100644 include/hw/ssi/phytium_qspi.h

diff --git a/hw/ssi/Kconfig b/hw/ssi/Kconfig
index 1bd56463c1..202c81c5ac 100644
--- a/hw/ssi/Kconfig
+++ b/hw/ssi/Kconfig
@@ -9,6 +9,11 @@ config SIFIVE_SPI
 config SSI
     bool
 
+config PHYTIUM_E2000_QSPI
+    bool
+    select REGISTER
+    select SSI
+
 config XILINX_SPI
     bool
     select SSI
diff --git a/hw/ssi/meson.build b/hw/ssi/meson.build
index 6afb1ea200..c76945ddf4 100644
--- a/hw/ssi/meson.build
+++ b/hw/ssi/meson.build
@@ -13,3 +13,4 @@ system_ss.add(when: 'CONFIG_IMX', if_true: files('imx_spi.c'))
 system_ss.add(when: 'CONFIG_IBEX', if_true: files('ibex_spi_host.c'))
 system_ss.add(when: 'CONFIG_BCM2835_SPI', if_true: files('bcm2835_spi.c'))
 system_ss.add(when: 'CONFIG_PNV_SPI', if_true: files('pnv_spi.c'))
+system_ss.add(when: 'CONFIG_PHYTIUM_E2000_QSPI', if_true: files('phytium_qspi.c'))
diff --git a/hw/ssi/phytium_qspi.c b/hw/ssi/phytium_qspi.c
new file mode 100644
index 0000000000..da7dce1d46
--- /dev/null
+++ b/hw/ssi/phytium_qspi.c
@@ -0,0 +1,398 @@
+/*
+ * Phytium E2000 QSPI controller
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
+#include "hw/ssi/phytium_qspi.h"
+
+#include "hw/core/register.h"
+#include "hw/core/irq.h"
+#include "hw/ssi/ssi.h"
+#include "migration/vmstate.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+
+REG32(FLASH_CAP, 0x00)
+REG32(RD_CFG, 0x04)
+    FIELD(RD_CFG, CMD, 24, 8)
+    FIELD(RD_CFG, ADDR_SEL, 19, 1)
+    FIELD(RD_CFG, LATENCY, 18, 1)
+    FIELD(RD_CFG, DUMMY, 4, 5)
+REG32(WR_CFG, 0x08)
+    FIELD(WR_CFG, CMD, 24, 8)
+    FIELD(WR_CFG, ADDR_SEL, 4, 1)
+    FIELD(WR_CFG, MODE, 3, 1)
+REG32(FLUSH, 0x0c)
+REG32(CMD_PORT, 0x10)
+    FIELD(CMD_PORT, CMD, 24, 8)
+    FIELD(CMD_PORT, CS, 19, 2)
+    FIELD(CMD_PORT, CMD_ADDR, 15, 1)
+    FIELD(CMD_PORT, LATENCY, 14, 1)
+    FIELD(CMD_PORT, DATA_XFER, 13, 1)
+    FIELD(CMD_PORT, ADDR_SEL, 12, 1)
+    FIELD(CMD_PORT, DUMMY, 7, 5)
+    FIELD(CMD_PORT, RW_NUM, 3, 3)
+REG32(ADDR_PORT, 0x14)
+REG32(HD_PORT, 0x18)
+REG32(LD_PORT, 0x1c)
+REG32(FUN_SET, 0x20)
+REG32(WIP, 0x24)
+REG32(WP, 0x28)
+REG32(MODE, 0x2c)
+REG32(LEGACY_CTRL, 0x30)
+
+#define PHYTIUM_E2000_QSPI_R_MAX     (A_LEGACY_CTRL / sizeof(uint32_t) + 1)
+#define PHYTIUM_E2000_QSPI_PAGE_SIZE 256
+
+struct PhytiumE2000QSPIState {
+    SysBusDevice parent_obj;
+
+    uint32_t regs[PHYTIUM_E2000_QSPI_R_MAX];
+    RegisterInfo regs_info[PHYTIUM_E2000_QSPI_R_MAX];
+    MemoryRegion direct_mr;
+    SSIBus *spi;
+    qemu_irq cs;
+    uint8_t write_buffer[PHYTIUM_E2000_QSPI_PAGE_SIZE];
+    uint32_t write_address;
+    uint16_t write_len;
+    bool write_pending;
+    bool resetting;
+};
+
+static void phytium_e2000_qspi_select(PhytiumE2000QSPIState *s)
+{
+    qemu_irq_lower(s->cs);
+}
+
+static void phytium_e2000_qspi_deselect(PhytiumE2000QSPIState *s)
+{
+    qemu_irq_raise(s->cs);
+}
+
+static void phytium_e2000_qspi_send_address(PhytiumE2000QSPIState *s,
+                                            uint32_t address,
+                                            unsigned int length)
+{
+    int shift;
+
+    for (shift = (length - 1) * 8; shift >= 0; shift -= 8) {
+        ssi_transfer(s->spi, extract32(address, shift, 8));
+    }
+}
+
+static void phytium_e2000_qspi_send_dummy(PhytiumE2000QSPIState *s,
+                                          unsigned int cycles)
+{
+    unsigned int i;
+
+    for (i = 0; i < DIV_ROUND_UP(cycles, 8); i++) {
+        ssi_transfer(s->spi, 0);
+    }
+}
+
+static void phytium_e2000_qspi_exec_port(PhytiumE2000QSPIState *s)
+{
+    uint32_t cfg = s->regs[R_CMD_PORT];
+    uint64_t tx = s->regs[R_LD_PORT] |
+                  ((uint64_t)s->regs[R_HD_PORT] << 32);
+    uint64_t rx = 0;
+    unsigned int cs = FIELD_EX32(cfg, CMD_PORT, CS);
+    unsigned int length;
+    unsigned int i;
+
+    if (cs != 0) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: command selects unwired CS%u\n",
+                      TYPE_PHYTIUM_E2000_QSPI, cs);
+        s->regs[R_LD_PORT] = 0;
+        s->regs[R_HD_PORT] = 0;
+        return;
+    }
+
+    phytium_e2000_qspi_select(s);
+    ssi_transfer(s->spi, FIELD_EX32(cfg, CMD_PORT, CMD));
+
+    if (FIELD_EX32(cfg, CMD_PORT, CMD_ADDR)) {
+        length = FIELD_EX32(cfg, CMD_PORT, ADDR_SEL) ? 4 : 3;
+        phytium_e2000_qspi_send_address(s, s->regs[R_ADDR_PORT], length);
+    }
+
+    if (FIELD_EX32(cfg, CMD_PORT, LATENCY)) {
+        phytium_e2000_qspi_send_dummy(
+            s, FIELD_EX32(cfg, CMD_PORT, DUMMY) + 1);
+    }
+
+    if (FIELD_EX32(cfg, CMD_PORT, DATA_XFER)) {
+        length = FIELD_EX32(cfg, CMD_PORT, RW_NUM) + 1;
+        for (i = 0; i < length; i++) {
+            rx = deposit64(rx, i * 8, 8,
+                           ssi_transfer(s->spi, extract64(tx, i * 8, 8)));
+        }
+    }
+
+    phytium_e2000_qspi_deselect(s);
+    s->regs[R_LD_PORT] = extract64(rx, 0, 32);
+    s->regs[R_HD_PORT] = extract64(rx, 32, 32);
+}
+
+static void phytium_e2000_qspi_ld_post_write(RegisterInfo *reg,
+                                             uint64_t value)
+{
+    PhytiumE2000QSPIState *s = PHYTIUM_E2000_QSPI(reg->opaque);
+
+    /*
+     * LD_PORT is the final staging write and commits the command assembled in
+     * CMD_PORT, ADDR_PORT, HD_PORT, and LD_PORT. register_reset() invokes the
+     * same callback, so suppress SPI side effects while installing defaults.
+     */
+    if (!s->resetting) {
+        phytium_e2000_qspi_exec_port(s);
+    }
+}
+
+static void phytium_e2000_qspi_flush_write_buffer(PhytiumE2000QSPIState *s)
+{
+    uint32_t cfg = s->regs[R_WR_CFG];
+    unsigned int address_len;
+    unsigned int i;
+
+    if (!s->write_pending) {
+        return;
+    }
+    if (!FIELD_EX32(cfg, WR_CFG, MODE)) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: FLUSH with direct writes disabled\n",
+                      TYPE_PHYTIUM_E2000_QSPI);
+        return;
+    }
+
+    phytium_e2000_qspi_select(s);
+    ssi_transfer(s->spi, FIELD_EX32(cfg, WR_CFG, CMD));
+    address_len = FIELD_EX32(cfg, WR_CFG, ADDR_SEL) ? 4 : 3;
+    phytium_e2000_qspi_send_address(s, s->write_address, address_len);
+    for (i = 0; i < s->write_len; i++) {
+        ssi_transfer(s->spi, s->write_buffer[i]);
+    }
+    phytium_e2000_qspi_deselect(s);
+
+    s->write_pending = false;
+    s->write_address = 0;
+    s->write_len = 0;
+}
+
+static uint64_t phytium_e2000_qspi_flush_pre_write(RegisterInfo *reg,
+                                                   uint64_t value)
+{
+    PhytiumE2000QSPIState *s = PHYTIUM_E2000_QSPI(reg->opaque);
+
+    if (value & BIT(0)) {
+        phytium_e2000_qspi_flush_write_buffer(s);
+    }
+    return 0;
+}
+
+static const RegisterAccessInfo phytium_e2000_qspi_regs_info[] = {
+    { .name = "FLASH_CAP", .addr = A_FLASH_CAP,
+      .rsvd = 0xfffc0000 },
+    { .name = "RD_CFG", .addr = A_RD_CFG },
+    { .name = "WR_CFG", .addr = A_WR_CFG,
+      .rsvd = 0x00fffc00 },
+    { .name = "FLUSH", .addr = A_FLUSH,
+      .rsvd = 0xfffffffe,
+      .pre_write = phytium_e2000_qspi_flush_pre_write },
+    { .name = "CMD_PORT", .addr = A_CMD_PORT,
+      .rsvd = BIT(23) },
+    { .name = "ADDR_PORT", .addr = A_ADDR_PORT },
+    { .name = "HD_PORT", .addr = A_HD_PORT },
+    { .name = "LD_PORT", .addr = A_LD_PORT,
+      .post_write = phytium_e2000_qspi_ld_post_write },
+    { .name = "FUN_SET", .addr = A_FUN_SET },
+    { .name = "WIP", .addr = A_WIP,
+      .rsvd = 0x00ffffe0 },
+    { .name = "WP", .addr = A_WP,
+      .rsvd = 0xfffc0000 },
+    { .name = "MODE", .addr = A_MODE,
+      .rsvd = 0xffff0000 },
+    { .name = "LEGACY_CTRL", .addr = A_LEGACY_CTRL,
+      .rsvd = 0xfffffeff },
+};
+
+static const MemoryRegionOps phytium_e2000_qspi_regs_ops = {
+    .read = register_read_memory,
+    .write = register_write_memory,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+        .unaligned = false,
+    },
+};
+
+static uint64_t phytium_e2000_qspi_direct_read(void *opaque, hwaddr address,
+                                               unsigned int size)
+{
+    PhytiumE2000QSPIState *s = opaque;
+    uint32_t cfg = s->regs[R_RD_CFG];
+    uint64_t value = 0;
+    unsigned int address_len;
+    unsigned int i;
+
+    phytium_e2000_qspi_select(s);
+    ssi_transfer(s->spi, FIELD_EX32(cfg, RD_CFG, CMD));
+    address_len = FIELD_EX32(cfg, RD_CFG, ADDR_SEL) ? 4 : 3;
+    phytium_e2000_qspi_send_address(s, address, address_len);
+
+    if (FIELD_EX32(cfg, RD_CFG, LATENCY)) {
+        phytium_e2000_qspi_send_dummy(
+            s, FIELD_EX32(cfg, RD_CFG, DUMMY) + 1);
+    }
+
+    for (i = 0; i < size; i++) {
+        value = deposit64(value, i * 8, 8, ssi_transfer(s->spi, 0));
+    }
+    phytium_e2000_qspi_deselect(s);
+
+    return value;
+}
+
+static void phytium_e2000_qspi_direct_write(void *opaque, hwaddr address,
+                                            uint64_t value,
+                                            unsigned int size)
+{
+    PhytiumE2000QSPIState *s = opaque;
+    uint32_t cfg = s->regs[R_WR_CFG];
+    unsigned int i;
+
+    if (!FIELD_EX32(cfg, WR_CFG, MODE)) {
+        return;
+    }
+
+    /*
+     * The direct aperture accepts multiple CPU stores for one page program.
+     * Buffer them until FLUSH supplies the transaction boundary required by
+     * the flash command.
+     */
+    if (!s->write_pending) {
+        if ((address & ~(PHYTIUM_E2000_QSPI_PAGE_SIZE - 1)) !=
+            ((address + size - 1) &
+             ~(PHYTIUM_E2000_QSPI_PAGE_SIZE - 1))) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: direct write crosses a flash page\n",
+                          TYPE_PHYTIUM_E2000_QSPI);
+            return;
+        }
+        s->write_pending = true;
+        s->write_address = address;
+        s->write_len = 0;
+    } else if (address != s->write_address + s->write_len ||
+               (s->write_address &
+                (PHYTIUM_E2000_QSPI_PAGE_SIZE - 1)) +
+               s->write_len + size > PHYTIUM_E2000_QSPI_PAGE_SIZE) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: non-contiguous direct writes before FLUSH\n",
+                      TYPE_PHYTIUM_E2000_QSPI);
+        return;
+    }
+
+    for (i = 0; i < size; i++) {
+        s->write_buffer[s->write_len++] = extract64(value, i * 8, 8);
+    }
+}
+
+static const MemoryRegionOps phytium_e2000_qspi_direct_ops = {
+    .read = phytium_e2000_qspi_direct_read,
+    .write = phytium_e2000_qspi_direct_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 8,
+        .unaligned = true,
+    },
+};
+
+static void phytium_e2000_qspi_reset(DeviceState *dev)
+{
+    PhytiumE2000QSPIState *s = PHYTIUM_E2000_QSPI(dev);
+    size_t i;
+
+    s->resetting = true;
+    for (i = 0; i < ARRAY_SIZE(phytium_e2000_qspi_regs_info); i++) {
+        register_reset(&s->regs_info[
+            phytium_e2000_qspi_regs_info[i].addr / sizeof(uint32_t)]);
+    }
+    memset(s->write_buffer, 0, sizeof(s->write_buffer));
+    s->write_address = 0;
+    s->write_len = 0;
+    s->write_pending = false;
+    s->resetting = false;
+    phytium_e2000_qspi_deselect(s);
+}
+
+static void phytium_e2000_qspi_init(Object *obj)
+{
+    PhytiumE2000QSPIState *s = PHYTIUM_E2000_QSPI(obj);
+    RegisterInfoArray *reg_array;
+
+    s->spi = ssi_create_bus(DEVICE(obj), "spi");
+    qdev_init_gpio_out_named(DEVICE(obj), &s->cs, "cs", 1);
+
+    reg_array = register_init_block32(
+        DEVICE(obj), phytium_e2000_qspi_regs_info,
+        ARRAY_SIZE(phytium_e2000_qspi_regs_info), s->regs_info, s->regs,
+        &phytium_e2000_qspi_regs_ops, false,
+        PHYTIUM_E2000_QSPI_REG_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &reg_array->mem);
+
+    memory_region_init_io(&s->direct_mr, obj,
+                          &phytium_e2000_qspi_direct_ops, s,
+                          TYPE_PHYTIUM_E2000_QSPI ".direct",
+                          PHYTIUM_E2000_QSPI_DIRECT_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->direct_mr);
+}
+
+static const VMStateDescription phytium_e2000_qspi_vmsd = {
+    .name = TYPE_PHYTIUM_E2000_QSPI,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(regs, PhytiumE2000QSPIState,
+                             PHYTIUM_E2000_QSPI_R_MAX),
+        VMSTATE_UINT8_ARRAY(write_buffer, PhytiumE2000QSPIState,
+                            PHYTIUM_E2000_QSPI_PAGE_SIZE),
+        VMSTATE_UINT32(write_address, PhytiumE2000QSPIState),
+        VMSTATE_UINT16(write_len, PhytiumE2000QSPIState),
+        VMSTATE_BOOL(write_pending, PhytiumE2000QSPIState),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static void phytium_e2000_qspi_class_init(ObjectClass *klass,
+                                          const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->vmsd = &phytium_e2000_qspi_vmsd;
+    device_class_set_legacy_reset(dc, phytium_e2000_qspi_reset);
+}
+
+static const TypeInfo phytium_e2000_qspi_info = {
+    .name = TYPE_PHYTIUM_E2000_QSPI,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(PhytiumE2000QSPIState),
+    .instance_init = phytium_e2000_qspi_init,
+    .class_init = phytium_e2000_qspi_class_init,
+};
+
+static void phytium_e2000_qspi_register_types(void)
+{
+    type_register_static(&phytium_e2000_qspi_info);
+}
+
+type_init(phytium_e2000_qspi_register_types)
diff --git a/include/hw/ssi/phytium_qspi.h b/include/hw/ssi/phytium_qspi.h
new file mode 100644
index 0000000000..c6534af16d
--- /dev/null
+++ b/include/hw/ssi/phytium_qspi.h
@@ -0,0 +1,23 @@
+/*
+ * Phytium E2000 QSPI controller
+ *
+ * Copyright (c) 2026 Process Mission
+ *
+ * Author:
+ *   Bin Meng <bin.meng@processmission.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_SSI_PHYTIUM_QSPI_H
+#define HW_SSI_PHYTIUM_QSPI_H
+
+#include "hw/core/sysbus.h"
+
+#define TYPE_PHYTIUM_E2000_QSPI "phytium-e2000-qspi"
+OBJECT_DECLARE_SIMPLE_TYPE(PhytiumE2000QSPIState, PHYTIUM_E2000_QSPI)
+
+#define PHYTIUM_E2000_QSPI_REG_SIZE    0x1000
+#define PHYTIUM_E2000_QSPI_DIRECT_SIZE 0x10000000
+
+#endif
-- 
2.53.0


