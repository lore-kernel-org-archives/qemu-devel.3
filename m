Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C721CD98F7
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 10:14:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wa9l9-0005wn-8D; Thu, 18 Jun 2026 06:14:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wa9l7-0005uy-HD
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 06:14:05 -0400
Received: from mail-northcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c105::7] helo=CH4PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wa9l5-0006Y2-QQ
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 06:14:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dYekQ9riNYpmcrzAF65qctqmWQbqsMH5+u0grxGRmdrveFQuez9NyH2mPXFWzpYSrrh6IKEVipu7Iz6v8pTYPUW8sONsRxJa8DVc9OzeAhOzCjvXcwKxQ8yDnz9lcCKlHXxllmzDlvPtAFO3MrpZJEl2wz9dJfVtOXQuScHRuPk8MuNDdye3cBbLnFtWHTLT3DtY5HzIIDt4CHftLI5lbUYIqroLIR8dJ3p7QlbprCPPzBq8IUNMwPyTjZ2BE5yv0AhlrCSPF20YQT9jFYckDW9hXN+atayW+KXWKZu1EMmnH0EBmTbSTjdM//aVqJcUtjUCGDrzTnSf2dPsNzqVBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lgRxNZeHfWavQNdD7AYspsQTlKU2fd/aTYNJvqBeXAQ=;
 b=SWRE8hrLcR57r4Uc53fTi2WhBLSWRA6GnNv1AnQIpHxcrWqPoItG/yJhdSqk2At7QaJPYs7JCyla3s64n71alodP01LWwJsMbE10eqrUH6VpEnhQr684P62VqTwjWFYBfiY7GxCjc3PYhOW9+ZGEGFUwUfmT3khtv9uoryHV3shs6mSohkWJA/PbfzWnS+9Z5qoADtwVzPHcCayBl96Ckl78MjsAuO7cVqb8bcVkihJW3TfE0cjZtBaY7KDrbzSkVAiYL6B9aZRP7wcWUMRAz8bmRu3pQF80R8XNe8vbZY/KmokuwZ+zwhAeVq8TsOF0eVSHqmkS/4Wg93tRs28Wnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lgRxNZeHfWavQNdD7AYspsQTlKU2fd/aTYNJvqBeXAQ=;
 b=lFs39tl7ZXcApT+tqN20WdEXYSV+HabaLkC/IltUF4t6Vixg8Dw8l87hb/gFC7jgLUnxJYblYtkuNUwB6ghDAjMEoS6GwxDNo4MMsLNAtfbGBYFvUt1kNDUV4XKcANFt+e/WHcGxtJ0PzsxRUYQ7PP4W08OBdwESPEqJWcbzUJmwssXYwNJmZMqdIFUpMMPBPRckF/ygQn6Lg6iEfZuUhxsGH5V7YmEwdwL/FsaySIJs7cXZ5P7mgT0NEILbvp++t+3x6g9x9d7hyMr0Sq/psQTrxMVyLhpHx3IxqCT5NAoxrg3TxTddXa0z/rWNJSGMyjj15Mbi+d/Sy3RqxhzIjg==
Received: from MN2PR03CA0008.namprd03.prod.outlook.com (2603:10b6:208:23a::13)
 by IA3PR18MB927625.namprd18.prod.outlook.com (2603:10b6:208:545::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.16; Thu, 18 Jun
 2026 10:14:00 +0000
Received: from BL02EPF0001A101.namprd05.prod.outlook.com
 (2603:10b6:208:23a:cafe::ae) by MN2PR03CA0008.outlook.office365.com
 (2603:10b6:208:23a::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.11 via Frontend Transport; Thu,
 18 Jun 2026 10:14:00 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 BL02EPF0001A101.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.8
 via Frontend Transport; Thu, 18 Jun 2026 10:13:58 +0000
Received: from axiado.com (unknown [10.4.1.181])
 by smtp.corp.axiado.com (Postfix) with ESMTP id 3757A4186B58;
 Thu, 18 Jun 2026 03:10:18 -0700 (PDT)
From: Kuan-Jui Chiu <kchiu@axiado.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Cc: Kuan-Jui Chiu <kchiu@axiado.com>
Subject: [PATCH v5 0/8] Add Axiado SoC AX3000 and EVK board
Date: Thu, 18 Jun 2026 03:12:41 -0700
Message-Id: <20260618101249.2926976-1-kchiu@axiado.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A101:EE_|IA3PR18MB927625:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 322c0cb1-e9c1-43cd-6c31-08decd225022
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|1800799024|82310400026|3023799007|13003099007|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: HTac1Ghc+DeuHg3GO7a82hQtt5kKrLbDrU6XPmlMV9cMvKp0e6iWNhruCAvwQ/U+MTgvReJKMfeBTlt67t/1vkn3rfqwExEdTGVr8oh9KDN2R5AsmaRpkqWLC5hmA4XcShy6klwXdK/fsH8UR1vN/ZoFLMAERvY7cwZHK7nEDy0zw17d8bmnjSB3f32U1hs9B+CqTcUF70XlmaicnYK6qIS80uMkPInrd6LyeUJQMLs+c5q+o4hTq3z36gQYiRWBdqhXXW8rGcsZMlOw7aTG4YNyxNWMKNGOM+iFP0YwD5F+3nfAgPjRPauSCjNKLeC5xWU6FplUC7xkVDQWPEMOZtFDO5UAJT1xec/vZvPdQRB4XoaB+kQEH4XkZJuAolDVE4Y0KyRp5I9Af/Imv9ozo3j1WZC4QDy7G4Lx+WLp/gDG+jmhs/QxPCKTVYd+b9yRDLEm+beoMSMWWTpK+NlN2xX/M6Wl6Z44ebDLz/5zcrgTLYQeTroyJoDvDSAM5VJndXSg7qhks2TaIoqxtY10vNvXdcboaDiHdX8QjR9bd/ZysI35RVnAl3gp2ZPz+mHWkhdw36Pm2wLFww04DCj9FIV2SaaJc6BvJ0/ik2esV72misxlRJe4px0xNtFJ9r4ekchvDoPfgrxo1YE9bKUOWKbtbtCFGGlex+FcGDXtCYwBISPWOFf9ezK9wfrvHkFc
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(1800799024)(82310400026)(3023799007)(13003099007)(56012099006)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: QJOFg1GyyaTRLHVBDG2udjrz7fgTWNsOa+3SVrsHkyMCfbP3CTiGduxzyLtOUqShUpkEL5Gs+0SRxKwUwDmUKh3ZbBtQBy96i2E5KTb0ARG5/xNQYDnmSUF/AZYKij2G73N1wcuGEF6JWWRqlnJa0cMTjk479Ap1IDrXHjG1aX6prUB500XC/6e9Ps1L6cid0mEXfh5EgOvZHu187VO54ywCIEA4apGFwLKP8Q/Sycn//9kGEooSj92gFOEGm9dShT5uQ0IdxtyzAlc3k6HxVb+DKfSxnajuf5MgiD3a2Kj35oCnNvkbsvQkOJMEOSx+zkPz55KvC9bT45C6jYV4kwyGjPlKF1k6xtCGMXLeAyz3AGwa0c0HHy2HYVSXd2GFw+QgXJT3SU7lCBNxOOQ5BAHbAkdiqLpiQOqxj/K6db3ztgTVQ+pQNh2gaPjWmndb
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 10:13:58.8514 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 322c0cb1-e9c1-43cd-6c31-08decd225022
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A101.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR18MB927625
Received-SPF: pass client-ip=2a01:111:f403:c105::7;
 envelope-from=kchiu@axiado.com;
 helo=CH4PR04CU002.outbound.protection.outlook.com
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

This patchset introduces Axiado SoC AX3000 and a EVK SCM3003 for emulation
The model for Axiado SoC AX3000 supports
  4 Cortex-A53 CPUs
  Arm Generic Interrupt Controller v3
  4 Cadence UARTs
  1 SDHCI controller with PHY
  8 Cadence GPIOs

Verified the machine "axiado-scm3003" with following command

qemu-system-aarch64 \
    -m 4G \
    -machine axiado-scm3003 \
    -device loader,file=u-boot.bin,addr=0x3C000000,cpu-num=0 \
    -nographic \
    -serial null \
    -serial null \
    -serial null \
    -serial mon:stdio \
    -drive if=sd,file=obmc-phosphor-image-evk-axiado-qemu.wic,format=raw

Refer Axiado website for more product information
https://axiado.com/products/

Changes in v5:
  1. Include Reviewed-by tag in reviewed patches
  2. Add arm_load_kernel() in ax3000-boards
  3. Add axiado_clk to support AXIADO_CLK

Changes in v4:
  1. Remove ERRP_GUARD from axiado_sdhci
  2. Optimize ISR update function of cadence gpio with logical operation

Changes in v3:
  1. Add a new patch for Axiado SD host controller
  2. Fill in valid/impl parameters of MemoryRegionOps in
     ax3000-soc/cadence_gpio/axiado_sdhci
  3. Follow C99 standard to declare variable in for-loop
  4. Remove comment "TBD" from empty function
  5. Define marco for bit definition in axiado_sdhci
  6. Move object_initialize_child() to instance_init() from realize() in
     axiado_sdhci
  7. Remove callback of get_default_cpu_type() from ax3000-soc and set
     type of CPU to A53
  8. Update the command to run "axiado-scm3003" in QEMU

Changes in v2:
  1. Move axiado-* to ax3000-* in hw/arm and include/hw/arm
  2. Add axiado_sdhci to support AXIADO_SDHCI
  3. Move implementation for eMMC PHY device to axiado_sdhci
  4. Use UNIMP to create dummy device "timerctrl"
  5. Add cadence_gpio to support CADENCE_GPIO
  6. Enable Cadence GPIO controllers on AX3000 SoC

Kuan-Jui Chiu (8):
  hw/arm: Add Axiado SoC AX3000
  hw/misc: Add AX3000 clock control
  hw/arm: ax3000-soc: Enable Ax3000 clock control
  hw/sd: Add Axiado SD host controller with eMMC PHY
  hw/arm: ax3000-soc: Enable Axiado SD host controller
  hw/arm: Add Axiado EVK SCM3003
  hw/gpio: Add Cadence GPIO controller
  hw/arm: ax3000-soc: Enable Cadence GPIO controllers

 MAINTAINERS                    |   9 +
 hw/arm/Kconfig                 |  15 ++
 hw/arm/ax3000-boards.c         |  56 +++++++
 hw/arm/ax3000-evk.c            |  27 +++
 hw/arm/ax3000-soc.c            | 238 +++++++++++++++++++++++++++
 hw/arm/meson.build             |   6 +
 hw/gpio/Kconfig                |   3 +
 hw/gpio/cadence_gpio.c         | 292 +++++++++++++++++++++++++++++++++
 hw/gpio/meson.build            |   1 +
 hw/gpio/trace-events           |   5 +
 hw/misc/Kconfig                |   3 +
 hw/misc/axiado_clk.c           |  73 +++++++++
 hw/misc/meson.build            |   3 +
 hw/sd/Kconfig                  |   4 +
 hw/sd/axiado_sdhci.c           | 114 +++++++++++++
 hw/sd/meson.build              |   1 +
 include/hw/arm/ax3000-boards.h |  28 ++++
 include/hw/arm/ax3000-soc.h    |  98 +++++++++++
 include/hw/gpio/cadence_gpio.h |  55 +++++++
 include/hw/misc/axiado_clk.h   |  26 +++
 include/hw/sd/axiado_sdhci.h   |  21 +++
 21 files changed, 1078 insertions(+)
 create mode 100644 hw/arm/ax3000-boards.c
 create mode 100644 hw/arm/ax3000-evk.c
 create mode 100644 hw/arm/ax3000-soc.c
 create mode 100644 hw/gpio/cadence_gpio.c
 create mode 100644 hw/misc/axiado_clk.c
 create mode 100644 hw/sd/axiado_sdhci.c
 create mode 100644 include/hw/arm/ax3000-boards.h
 create mode 100644 include/hw/arm/ax3000-soc.h
 create mode 100644 include/hw/gpio/cadence_gpio.h
 create mode 100644 include/hw/misc/axiado_clk.h
 create mode 100644 include/hw/sd/axiado_sdhci.h

-- 
2.34.1


