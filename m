Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 854A6C79F82
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 15:58:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2WJG-0004AT-3k; Fri, 04 Sep 2026 11:58:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x2WJE-00048Y-KR; Fri, 04 Sep 2026 11:58:32 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x2WJB-0004Pg-5n; Fri, 04 Sep 2026 11:58:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sF3VOOnRC1VTVPBGKFyuPM6btT+29g/f4JBoUNi+n7xrCOIsEUcykg1gLS7TGFR6jtIYyZK7oo/vjN+oIzmRnKRRmjSG+2xy/tDdA7PJYeQosaO1xjlLqsOWuT1soUNTpQVMvnPEajRxiPWX8ozI6O0Z+GIvLdGNgslQj9hTDk9WTN5vyP01Ejr5DWXl8L18d/tW++Fng/NiYtmHkgCEtQGNCE6f+4h7IzkYMA3+FCY2qgD3TfcT42Dnkg1i03SJlEcuTp6ULsJPPks50fmRQjHnR51p8OO/wKCbcajj+GO/Q907EnTzvgofH8rk0ba5DUmiviHshKnzqx1SbT0xYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WxRbew+7+7lPh2Y2ZoQKFobtu827A192KxmHS+ndfxA=;
 b=H0Ay2namXkOdexIzBQ+2v9XmOW0+Hx3+uspHCzur+yYSKGise0SBhv8jsDfYYNbuVW2z1IkBp+MNF+fWINElCRf8ek9+2g8NzRwGPKegjcTXuWqZzfD1Q3F41+paVF2yaXM0NlFGhZPa+tdVlYr3bPDXadMGflU8tY4NBLQto/fXB2eKZ5ogVwBMhuSjWmoYqBgDCokaXisGdPLNJ7At4smoSU6htkTSv3vgzoH/9VgiQT26Y+Gab2Fr7EbzCoOvffAsDfXEhfTanmdRSy1ZhfOMK0ZT6zvwAlydo02iJhAR64m60vBA5pXJ4uP4qLb3U5uVhUXmHtEeztBywhGQQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WxRbew+7+7lPh2Y2ZoQKFobtu827A192KxmHS+ndfxA=;
 b=h2F4oNzaler9fc5GKRJiZs4lVXjpGmW/XfTc9duFzpjh6IrI+9O6Q3w4z+xG+fkhD7qri/IQwyBL1wJ9UgJMMehYXB2QEbCGGo/TfFyH2XUdYqoLKsuitzjxwf3UP5PofwA2j2FPTFLjJoKTWdQ/WCpb2jwzs1UYciM2hgpn6/X53Hv2aqBVf10SIIpTgdByRn/e0K9kJQxxFjY670dpMWqVXPG/b1DB3p9mxh9CJcqbkjgQrhON7dNX18vBkM6aNenlxPRJXPbJvQgT5h8KIM0+tZVBTKECMwCc4d4Lx81XuwW0YBnW8PQ1ZFncca8yGWF+tRBqAxKjY/9aRIP7wA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by TYPPR02MB9175.apcprd02.prod.outlook.com (2603:1096:405:394::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 15:58:19 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0382.007; Fri, 4 Sep 2026
 15:58:18 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Alistair Francis <alistair@alistair23.me>, Bin Meng <bmeng.cn@gmail.com>,
 Chao Liu <chao.liu@processmission.com>, Conor Dooley <conor@kernel.org>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Markus Armbruster <armbru@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Sebastian Huber <sebastian.huber@embedded-brains.de>,
 Thomas Huth <thuth@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 qemu-arm@nongnu.org, qemu-block@nongnu.org, qemu-riscv@nongnu.org
Subject: [PATCH v2 00/24] hw/riscv: Restore Microchip PolarFire SoC Icicle Kit
 firmware boot
Date: Fri,  4 Sep 2026 23:57:19 +0800
Message-ID: <20260904155758.3833179-1-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0020.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b0::13) To KL1PR02MB4977.apcprd02.prod.outlook.com
 (2603:1096:820:71::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|TYPPR02MB9175:EE_
X-MS-Office365-Filtering-Correlation-Id: 05785a61-2e96-4267-aaa2-08df0a9d563b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|7416014|376014|6133799003|5023799004|56012099006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: CbMPQ1KSKqZ61tzbtji6eJddD0YbNi2p95eqkeBgAYR6zaeCtw7VVCnirLmTgFrZ0p8CA3ommE7yZedZ6+9W89kItgNdYITAwtE6HDhSrL1WMl1F2X+HsxSkzgm57wgldyad+Xk9yKcOr4HAmry7pQeq6dZiM9Ogx8A4NvaYCmoNhD6GQKxJtV0RX0buWYDp+JV48L7ovPlaiT2ScDYqyYir3hO+PNwhmRCSexET0gSM2um3xDA+5cxLV4ESdwyHA7XBDDGqoOzvIQUw2o08YW2JtpdCutCdT/36ZHpM749MqDZ3FfoXeD5fj8E/us0TzM2tnad2heg14Y11n0kF4oR1ePVAsvzG0F0TNFPx9XMJMwRBJnCUYOvntSQtonXCBDmKR+fOdhr++Dn2UtlaNy3Y9G6BugU2+rp8EI+i1/v0t7SdemNcyaTpETY/k+B+owIOoOuuL+T/YYrAMGgjQ4/NlBpBZIHfO+6g9plo1VvT273I2z2ARRx1p7tRGdAeobJzcOe5aQkvaD7f3K+JPUvX34VvEIjpV0mvmHNe/bq3fVJXb4ckaIGeI7YbId0Zwq3IJL5HPc9jofGema1wAUudfMC+Aa1B8irOxRFXnd2oCXKbhklNDdL7rtrY4JECUlsOjRdveAs+Z0yfz8V3fnffRzbiErfRprBuQGHjJjs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(6133799003)(5023799004)(56012099006)(10067099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/YlwLreCTm2D6CArMu9CqdfTQOlVitZ4N2g1XIYgqM6KM3nUtGXRkheACK4n?=
 =?us-ascii?Q?IYKbNDQaAooj2Lj/v6OgWG0Wx2AhEQ0lBckGTzMuMv5513b0MNJo1rOnX8du?=
 =?us-ascii?Q?w0SQ1mMxCyMS26apLs9meVeraQrA2vHEDy9BMWfECl2vb9fJQgJa/bF15V2+?=
 =?us-ascii?Q?z6EcgI/cTgls+s0XyS49GyJvg5Ci4FOhl1KS5stklf7Ub3SJ7ajK+9MasThO?=
 =?us-ascii?Q?67JKshPE7hCs70E8/1qK0x2spVzil4E0SQao4TFQS9SUBgz2RvJeq6RPKL07?=
 =?us-ascii?Q?h338gX5Khn0/p5lIPf7VvQYb0DQMkU8uD+OD2UwRfYgonaPok67X9aO9H1PG?=
 =?us-ascii?Q?5wS0iPVhaup/4q9a3hX4zj43JLwMmJBCpGS5lIUlL0w059oCqryooXUp36Vk?=
 =?us-ascii?Q?UrAaSPUEZVGlsHdIET8L69KAAtMA/Zvdz85RYFL/qyotDmWfgex74UTCm0rF?=
 =?us-ascii?Q?0K/BR33a6tNkyChnfciHSXoIdMAzW3s1tG03H1PFHKa1t+OWapxbszZS1Ruc?=
 =?us-ascii?Q?3hjIkEvAKyASyaQBKHxllipnpDg0LAsd6FvTnpBFDoMfbAMI07sYnX0gMG6B?=
 =?us-ascii?Q?k48KfAmJK6IHUX2tGtlk+uElNQmROpYWknuUDFXUfukUCijx5tPzVFFQcgVs?=
 =?us-ascii?Q?sWeHtagpGekQoDGQF3C4zcL59eumE4OUJ1lmC+4dfbm9IwYct+W+2fUd7pd1?=
 =?us-ascii?Q?tphTOew70fxt/8AKqj7UhwSKbk9uliaamPNqFlr7ptuMn1lt1gR+PQGNGGIx?=
 =?us-ascii?Q?iUhRlNzW5EEc6O/3SPksElVCZKt/8wv5zdxMzT2zOUOYlVjZ5JdgG6rmU0dJ?=
 =?us-ascii?Q?9c1ABWtnZhl5RTAdkeuvdu3Pgo1dDCItIWaQ6rSR08tR4silA1ugbpDr8myV?=
 =?us-ascii?Q?HfUw6LEPtRBxW/Kv21tLByUdqaRHXYXQEOG+djf7kRBqlrlCWswUDOqVF5Wc?=
 =?us-ascii?Q?Qe7iPZ6rMEzXRb7u52vC0vCEgWu+aLjJxAFy+ctm8BXpV8hvQfEuh9Ts2Kld?=
 =?us-ascii?Q?dkYuVx7I3w4BIe1KTtmUGo9O164JhYlhHkBq8ltGATKLktPpioGXc2+XeKDS?=
 =?us-ascii?Q?uEg0sG4ezSdu2JbBPQ+W44C8X+A8VoK0NCu14Xuy/re9TzCVuJxTUaJ4pZXE?=
 =?us-ascii?Q?V8QN8B0fnhfe6qtNa8SPSBtNi17XeFuAd/A60ewjYPHx9TNj7VxG579N7KOi?=
 =?us-ascii?Q?eypZ3eZeMurVJzUJL7xKxOVMtcINXuq5k76KmPeAsjnEdHKtZeCMcuaPPwwz?=
 =?us-ascii?Q?lxKp4GuOUYzpe70xmsB+Shit4sc+wGsYHRaRGPJnAWrOAUc+GZwMXc5i/vvU?=
 =?us-ascii?Q?jmoT5Idinpd0YZ0YTTr9iaJLhGhFKy8c50wnlJkBPMa0oulmgTAhe5En900n?=
 =?us-ascii?Q?WLziQgSDJXfHKPrKcWziVlc/k/A+KFgcsNsMGb2U4VqxjPAv2gxDakqaxRXy?=
 =?us-ascii?Q?IwTWC8ofke4eqLUJp60gHSCFpaelGzNqfheT+jkl3O1YaH8oWvKkVxvzBW7Q?=
 =?us-ascii?Q?w8sWmKLdsNTemqZWHD97RQW0UvLPhFXwMsgG0K487OJOGgkjjlPZHiNAR8wA?=
 =?us-ascii?Q?xE2o/JksVsXiRJlth/Ivxf0aTRXcJQJFs2Adra8YEkmW/Slni9OuqE/uB2mC?=
 =?us-ascii?Q?PUwLdwWYJuYYhpMLz6dSsHlUlYIUF9SJVmcWZsxMySwx6b8Op0jk4sKIMJcu?=
 =?us-ascii?Q?qoaOBQLb/7wSrECNqgsBrmkZd6ctAtZIBCg3iNMfzgd2X0UmwbVMVOx52Wxj?=
 =?us-ascii?Q?h3ERxpyr57RU51Pw2aKmHW28dYksXb4=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05785a61-2e96-4267-aaa2-08df0a9d563b
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 15:58:18.5247 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5NkHB4KP/p7lLIZS934+kgF5lRf0lIpwb9sDUTp0Cm5la0C2fEyZ7K50NFBMtphLH8HV9zIrRkqmmptBlizloI8Ozctx9Ggh2p6vveYMcHE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYPPR02MB9175
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


The microchip-icicle-kit machine was originally validated with an older
Hart Software Services (HSS) firmware stack. HSS v2024.06 cannot boot
through U-Boot to Linux because several firmware-visible parts of the
PolarFire SoC are missing or incomplete.

The first failure occurs before the UART is initialized because the L2
zero window is not mapped. HSS then needs additional L2 cache controller
and DDR training behavior. Later boot stages exercise system services,
the RTC, SDHC version 4 DMA, and high-capacity SD card block sizing,
along with the complete DDR aliases. The existing models ither reject
these accesses or expose behavior that does not match the hardware
specifications.

This series restores the complete firmware boot flow. With these
changes, QEMU boots the HSS v2024.06 eNVM image, loads its U-Boot
payload from an SD card, and reaches the Buildroot 2026.05 Linux
login prompt.

The changes are organized around the firmware boot sequence:

* Correct the L2-LIM size, map the L2 zero window, and provide the DMC
  status transitions required by HSS DDR initialization.
* Model the documented L2CC Config, WayEnable, and WayMask registers,
  and resize L2-LIM as cache ways are enabled.
* Complete SDHCI version 4 support used by the Cadence controller,
  including Host Control 2, SDMA system addressing, 64-bit ADMA2
  descriptors, and SDMA boundary continuation.
* Run ADMA from a bounded timer-driven engine instead of performing work
  from command or unrelated MMIO accesses.  This keeps DMA progress
  independent of guest register traffic and avoids consuming a polling
  deadline inside the command write.
* Keep SDHC and SDXC memory transfers at their fixed 512-byte block
  size, and advertise the Cadence controller's 64-bit system bus
  support.
* Add the PolarFire SoC serial-number system service and RTC, and honor
  the system-service notification control bit.
* Correct the DDR aliases and fix the board topology at its physical
  configuration of 2 GiB of RAM and five harts.
* Document direct and HSS boot, add focused qtests and a full firmware
  functional test, and restore the machine's Supported maintainer
  status.

Testing performed:

* Built qemu-system-riscv64 and the documentation.
* Passed various newly added qtests.
* Booted HSS v2024.06, U-Boot, and Buildroot 2026.05 Linux to the login
  prompt using the functional-test image.

The functional test downloads this versioned image archive:

https://github.com/processmission/qemu-machine-images/releases/download/
v1.0.0/riscv64-microchip-icicle-kit-v1.0.0.tar.zst

When restoring the HSS boot support, 3 potential bugs were identified in
the upstream HSS source codes that either blocks the DDR training from
succeed or traps in a multi-core race at the very beginning or after
a succesfully DDR training but stuck at OpenSBI/U-Boot hand-off. There
are already bug reports filed aginst various upstream projects.

Changes in v2:
- Use the Resettable API instead of a legacy reset handler
- tests/qtest: add Cadence SDHCI ADMA pacing/MMIO reproducer
- Assert bounded ADMA pacing and MMIO-independent progress
- Reuse existing SDHCI definitions and command helpers
- Verify transferred data against a known image pattern
- Make 64-bit system bus support a device property
- hw/riscv: pfsoc: Enable 64-bit SDHCI system bus support
- Reset the RTC to the documented hardware values
- Expect the documented hardware state after RTC reset
- MAINTAINERS: Move Conor Dooley to PolarFire SoC reviewer
- Drop sdhci patches that are already merged

Bin Meng (23):
  hw/riscv: pfsoc: Correct the L2LIM maximum mapped size
  hw/riscv: pfsoc: Map the L2 zero device window
  hw/misc: pfsoc: Support DDR training with newer HSS
  hw/misc: pfsoc: Model L2 cache controller registers
  hw/riscv: pfsoc: Couple L2CC to L2-LIM
  tests/qtest: Add PolarFire SoC L2CC coverage
  hw/sd: sdhci: Run ADMA independently of MMIO
  hw/sd: sd: Keep high-capacity memory blocks at 512 bytes
  hw/sd: cadence: Add 64-bit system bus property
  hw/riscv: pfsoc: Enable 64-bit SDHCI system bus support
  hw/misc: pfsoc: Model PolarFire SoC serial number service
  hw/rtc: Add PolarFire SoC RTC model
  hw/riscv: pfsoc: Add PolarFire SoC RTC to Icicle Kit
  tests/qtest: Add PolarFire SoC RTC coverage
  hw/misc: pfsoc: Honor PolarFire service notification requests
  hw/riscv: pfsoc: Correct PolarFire SoC DDR aliases
  hw/riscv: pfsoc: Fix Icicle Kit RAM size at 2 GiB
  hw/riscv: pfsoc: Fix Icicle Kit hart count at five
  docs/system/riscv: Document Icicle Kit HSS boot
  docs/system/riscv: pfsoc: Document CLINT topology for direct Linux
    boot
  tests/functional/riscv64: Add Icicle Kit firmware boot test
  MAINTAINERS: Add PolarFire SoC Icicle Kit maintainer
  MAINTAINERS: Move Conor Dooley to PolarFire SoC reviewer

Wadim Mueller (1):
  tests/qtest: add Cadence SDHCI ADMA pacing/MMIO reproducer

 MAINTAINERS                                   |  13 +-
 docs/system/riscv/microchip-icicle-kit.rst    | 129 ++++-
 include/hw/misc/mchp_pfsoc_dmc.h              |   6 +
 include/hw/misc/mchp_pfsoc_ioscb.h            |   8 +
 include/hw/misc/mchp_pfsoc_l2cc.h             |  31 ++
 include/hw/riscv/microchip_pfsoc.h            |   7 +
 include/hw/rtc/mchp_pfsoc_rtc.h               |  46 ++
 include/hw/sd/cadence_sdhci.h                 |   1 +
 hw/misc/mchp_pfsoc_dmc.c                      | 273 +++++++++-
 hw/misc/mchp_pfsoc_ioscb.c                    | 174 ++++++-
 hw/misc/mchp_pfsoc_l2cc.c                     | 231 +++++++++
 hw/misc/mchp_pfsoc_sysreg.c                   |   9 +-
 hw/riscv/microchip_pfsoc.c                    |  94 ++--
 hw/rtc/mchp_pfsoc_rtc.c                       | 477 ++++++++++++++++++
 hw/sd/cadence_sdhci.c                         |  11 +
 hw/sd/sd.c                                    |  43 +-
 hw/sd/sdhci.c                                 | 143 ++++--
 tests/qtest/cadence-sdhci-test.c              | 282 +++++++++++
 tests/qtest/mchp_pfsoc_l2cc_test.c            | 221 ++++++++
 tests/qtest/mchp_pfsoc_rtc_test.c             | 315 ++++++++++++
 hw/misc/Kconfig                               |   3 +
 hw/misc/meson.build                           |   1 +
 hw/riscv/Kconfig                              |   2 +
 hw/rtc/Kconfig                                |   3 +
 hw/rtc/meson.build                            |   1 +
 tests/functional/riscv64/meson.build          |   2 +
 .../riscv64/test_microchip_icicle_kit.py      |  56 ++
 tests/qtest/meson.build                       |   6 +
 28 files changed, 2429 insertions(+), 159 deletions(-)
 create mode 100644 include/hw/misc/mchp_pfsoc_l2cc.h
 create mode 100644 include/hw/rtc/mchp_pfsoc_rtc.h
 create mode 100644 hw/misc/mchp_pfsoc_l2cc.c
 create mode 100644 hw/rtc/mchp_pfsoc_rtc.c
 create mode 100644 tests/qtest/cadence-sdhci-test.c
 create mode 100644 tests/qtest/mchp_pfsoc_l2cc_test.c
 create mode 100644 tests/qtest/mchp_pfsoc_rtc_test.c
 create mode 100644 tests/functional/riscv64/test_microchip_icicle_kit.py

---
base-commit: d2843fbf80260e4346c856819e8cea11768c9d0e
branch: icicle-kit

-- 
2.53.0


