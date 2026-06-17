Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 481BECD98EE
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 08:56:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZm3q-0002S5-1H; Wed, 17 Jun 2026 04:55:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wZm3n-0002RJ-P3
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 04:55:47 -0400
Received: from mail-westusazon11022078.outbound.protection.outlook.com
 ([52.101.43.78] helo=SJ2PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wZm3l-0005f6-Uw
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 04:55:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dnmxAvKT+lsrTx5Zb79R9/qQxqHIRjLyDEY27+kZljhPGeMifu4D+7bmx2hgDZOMTUxjylUhriCp4zPJD1L0KVh3iqSnybDIhdzJPjVAPWLgyJEm85NO9SG/xOO9BQ825/U/bR05nVFrjENaAd33HaQL3VOxNxaLieU0ePnRmD0XCQ3BI2FNDcZEHOCWSzD+c9g0ZVcu9R/h8eX7hEA97pd8xXB3dIZCsXrgY68mkYDAP9JRZQpXm3Ug1ysZaVjeidMRgiDxsqa3msbu9bMxygF3M7tHSM3igwjbk4TTPg1sxB9VNCChwuol7eD4RE4GypKHvIirVlgovgE7y65LOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4AiZpXH/JcbXMqZwstjIRIxND8zXkrImDaCnngimUrI=;
 b=jMrAHPNTdHsns9WdbE1Xw3BaSqLU6zUp5OaRVOH3f7ffLl0r3yYccS2WWjD7T3FFWc/9wmnE7Fpsft+SqtHgnDCb+lNpi/Tu5p/7HM9FfCoiB1mitdCjBYmSoX3yLGLF60aWkBn+JQxXofqE1D8Cd/o1G/IKw89I1nXapvVdzQwSFPnmWkxbjwfZBD6Lq+Bd+FHcGmE0n38Nm/Jw6iPjuLyuSFClo4VLFQZxxgsUcVbhcwkenSxFdejiAJo79I2aNKdkciePMrVmf1RBGO4KpvxHXOF2q5iyF4gfXeQOAinx7h+6r6dcJtpF6Q+lrEXngui/8/bfRYYYbo43TQpwDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4AiZpXH/JcbXMqZwstjIRIxND8zXkrImDaCnngimUrI=;
 b=wxCpMSC2yyl5B810hs5U2J8SJy9xPDCGltu2CKUH3I33Tub4mGoucevmefAsALXmtokHaqaFA5dd84cieMPg/6hzpY0xEUIxFLqzighpGSlSjAcfbQbfdvaCf5SRmxuG1dY9Gg9G8wIhgxL/nM48wTb5GS8uhu18yCPRQ0Mkxou0nLT57v8OOqOifof5Wt/ND2SMV7ubQT37Mn3wHSEXWrSQUe0pLpjs67eUqqMLyFRMk7/buBCAgm9kMwxCcsXNBGsV+wNObWVxTqAUvVd80+Mn+dcujFU72rdrUx6r1a5eIIHpDff8+Kxay8PJH3Er4xRLfH3se8+W7PazMIf4nw==
Received: from SJ0PR05CA0130.namprd05.prod.outlook.com (2603:10b6:a03:33d::15)
 by SA1PR18MB4806.namprd18.prod.outlook.com (2603:10b6:806:1dd::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 08:50:39 +0000
Received: from SJ1PEPF00002325.namprd03.prod.outlook.com
 (2603:10b6:a03:33d:cafe::3c) by SJ0PR05CA0130.outlook.office365.com
 (2603:10b6:a03:33d::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.11 via Frontend Transport; Wed,
 17 Jun 2026 08:50:39 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 SJ1PEPF00002325.mail.protection.outlook.com (10.167.242.88) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.8
 via Frontend Transport; Wed, 17 Jun 2026 08:50:38 +0000
Received: from axiado.com (unknown [10.4.1.181])
 by smtp.corp.axiado.com (Postfix) with ESMTP id 993E64186B51;
 Wed, 17 Jun 2026 01:47:59 -0700 (PDT)
From: Kuan-Jui Chiu <kchiu@axiado.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Cc: Kuan-Jui Chiu <kchiu@axiado.com>
Subject: [PATCH v4 0/6] Add Axiado SoC AX3000 and EVK board
Date: Wed, 17 Jun 2026 01:50:22 -0700
Message-Id: <20260617085030.2586072-1-kchiu@axiado.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002325:EE_|SA1PR18MB4806:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 2d5c2601-8094-4dcc-4030-08decc4d8172
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|1800799024|376014|36860700016|3023799007|56012099006|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info: xiVxTa96+Vpf2VvVjVSkQCusdnYFtDWo7XGD5LP01b8pplZoN3nbY6dFsTdYY8oA0f1o5R8fzNJYYhtGTbmDR3YkE3VeBtvFkek+IPvQ0eXHoYaPKZYUPokFkL26q2Bnthn/G8yVUl1mFW7ZpqYzAQlk0YjNyrXtWB8rCMPkmIxiNDjYbe/SPMNjOQQcFWQQIQZIL30UBZ01FSXPhdYt3J3rc0Eftaa+3j6Js5jcHx2lyBoePgjUJuRyw345qCkem3QU5d+qruVMmju95mQrqDKF6UQnCjHl8Q6r8G9T2Mo6sbYX+CViTAwAr0o0TIsnY0FdYH+6Hmfoz3jaspCuvdKWB8NipzC84VHxMgNZwW1/1Y/pwMqxo1SelzN3XdPXNZaUPHF8U5f3b67SIirR/dCOlHCqPO59f/tYDmiOOfraLKXv4K5wZ779wmr9UrL+K3ADC+yU2F+8RGL8abAZfW+bDI+ASQlMQHYKfWOmpb5jTOSpn+HKDiygwB1mUbKmHTyZAyTRfHk81avUeZEOVYHZ7Zj7kGt4g1gEgUqnx08PTD5EUAQzLs+K+fI5Z5V7I/458Eafh7gwHsfunFAA3fE8lL7QuVeJyZGxo0/xaGbNnvmmyBpZKmNu+bVbWckgaIRNSy5/Ub8b+QqeqA94y9R8EZS60NPOouMw4WnQ/nYFIQukyoNbTniYdcJ/MPY3
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(1800799024)(376014)(36860700016)(3023799007)(56012099006)(18002099003)(13003099007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: OEG6iVcS/oLBul0OKRwV+VZgasFjH1VcmCg0HxAlJ2l9r1ASxq01Kh5tMpp4JQDlz9AXG55lsqFbhP/X8S7CPke7ts/WWes3qPKZaePOj6fDealRK1Q15gN/4SmVMOBghzz13SfsKPaKwdibPZCEWm9N+rpCZtQnwHyQVVMR4Pcow1HQRx5frLJ/bmdKr+DOgtWOC1mTRDVBhVztDmlf75bitXMXtWwfMbu1cfC3KzEZg+BLo+iVIYNQJLjVph+meSIVWjlaVy7c4FkOZCC7HSIRmIwW+/WK1ZkwkHsh51FoCIcdUNDTzQAlwI9iVCx8TAnh770qdwvSXKfKpT9tFDmNZEnqzTJ4umDR8ulln4ol424eqRd2o4VFGiliLda8Yb/T9gdLxCb5+03cE8C/30Bx29ZhtlVG4KlRh4a9amHJ6+QqjoE7gWlGVpG7VaDU
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 08:50:38.9031 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d5c2601-8094-4dcc-4030-08decc4d8172
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002325.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR18MB4806
Received-SPF: pass client-ip=52.101.43.78; envelope-from=kchiu@axiado.com;
 helo=SJ2PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

Changes in v4:
  1. Remove ERRP_GUARD from axiado_sdhci
  2. Optimize ISR update function of cadence_gpio with logical operation

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

Kuan-Jui Chiu (6):
  hw/arm: Add Axiado SoC AX3000
  hw/sd: Add Axiado SD host controller with eMMC PHY
  hw/arm: ax3000-soc: Enable Axiado SD host controller
  hw/arm: Add Axiado EVK SCM3003
  hw/gpio: Add Cadence GPIO controller
  hw/arm: ax3000-soc: Enable Cadence GPIO controllers

 MAINTAINERS                    |   9 +
 hw/arm/Kconfig                 |  14 ++
 hw/arm/ax3000-boards.c         |  47 ++++++
 hw/arm/ax3000-evk.c            |  27 +++
 hw/arm/ax3000-soc.c            | 267 ++++++++++++++++++++++++++++++
 hw/arm/meson.build             |   6 +
 hw/gpio/Kconfig                |   3 +
 hw/gpio/cadence_gpio.c         | 292 +++++++++++++++++++++++++++++++++
 hw/gpio/meson.build            |   1 +
 hw/gpio/trace-events           |   5 +
 hw/sd/Kconfig                  |   4 +
 hw/sd/axiado_sdhci.c           | 114 +++++++++++++
 hw/sd/meson.build              |   1 +
 include/hw/arm/ax3000-boards.h |  28 ++++
 include/hw/arm/ax3000-soc.h    |  99 +++++++++++
 include/hw/gpio/cadence_gpio.h |  55 +++++++
 include/hw/sd/axiado_sdhci.h   |  21 +++
 17 files changed, 993 insertions(+)
 create mode 100644 hw/arm/ax3000-boards.c
 create mode 100644 hw/arm/ax3000-evk.c
 create mode 100644 hw/arm/ax3000-soc.c
 create mode 100644 hw/gpio/cadence_gpio.c
 create mode 100644 hw/sd/axiado_sdhci.c
 create mode 100644 include/hw/arm/ax3000-boards.h
 create mode 100644 include/hw/arm/ax3000-soc.h
 create mode 100644 include/hw/gpio/cadence_gpio.h
 create mode 100644 include/hw/sd/axiado_sdhci.h

-- 
2.34.1


