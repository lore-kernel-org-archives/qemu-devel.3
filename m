Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97E9EC44506
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 07:37:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjBD7-0006Ia-7P; Mon, 13 Jul 2026 03:36:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wjBD3-0006HR-4U
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 03:36:13 -0400
Received: from mail-westusazon11022091.outbound.protection.outlook.com
 ([52.101.43.91] helo=SJ2PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wjBCz-0002vW-TA
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 03:36:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fDOja4Cq26xmoVy7qbWTAGwJwuzwEdYa7XUPFfXNEz7vkkYuuKtAKWWje6Lm24eovye8Z1R99+jsgnB/hmT0dt5D2S67oR3t/Ze5cE8xrfEHGMpHykbcHJdNDssT5Kypcgb5N2P+mlKop+epSziQXn9DjKW5XoS+CMyCI4mVl8SkURjjXKkJttq1f3d6KQ/EHb1YkwggEpdHRUM8Im2V5sCi0Vbzu5fKvTEVwA/C1lcrZMpdSrXb6op63c437whAo0kVAVD4D2XSGGWeC9AAdOqYpidsIKFSjArdHqEiVT3/kKy6PcGCyHZwJaQ+Dl9W9rSWUtFcBe1s4loIhcU6cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DtH5fVZh8ijssOHUPo0kxzLNoN0Tu57AmxZT7Y/ZHsg=;
 b=aLUecCScDX26a7tvraJl/9znV55+j8c9ZT0mtbpKNtTngsDnGiRKSyylEpiP57qgKfOAoB7SJFwUdBappD0XeIUwclDqC2ezbCrI9UQ7vMysSnFp8DXa8Le72TbvcJCOKR+Je6QzB90HEkKvDE/1CqmarmaGz0QBqw3BIsVXcwCaa5MrMk5JrEsdPcxOVsz/KW8QbdhmzIcrLNXwK8PqkL/KuRgGO4CtBWc731/Rz4XxF47w+bK9KlcdyL8Sm76OnN86psH0brGgoHvaRBsLpD2aUS5aNiG0jyehfm4EGROYRwnzmpNtPooHkvy2kDiQUZcoyuCJKHDAgQh53JnyiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DtH5fVZh8ijssOHUPo0kxzLNoN0Tu57AmxZT7Y/ZHsg=;
 b=sXPff3BL5ofmxbvp/4zT9vMYO3n5OYcSN7AB5O8kQ1rCJykVRIFKX6Cq97aM/N/0gN+yBaH2pzFHhDJXrShs23Umi1mGadBY+ckI3Ad5Apm4vzOEibCYqz8qWSdm50Wq//i/JGOBfN+mEbt32rYTRMsy1QnKD6npnCjAWgdqtX4XzWyzT/Ww+jOdSx/LyWEIZTa9U0xlAnbpQ4KlDo5v/ShIDiSJEYRU52BPOUI46s0CIGpIaVrvKrvsuKFTSmjzJxRV8ICU8e/3VjCzB6rJHpBTX/Z6SihHQ4H4d1NRCCUafTej3v8b4mWHiASQXHVvltUZHiuha+MjG3NOg4mIgQ==
Received: from BY5PR03CA0004.namprd03.prod.outlook.com (2603:10b6:a03:1e0::14)
 by LV3PR18MB6129.namprd18.prod.outlook.com (2603:10b6:408:27b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.19; Mon, 13 Jul
 2026 07:30:59 +0000
Received: from BY1PEPF0001AE1C.namprd04.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::47) by BY5PR03CA0004.outlook.office365.com
 (2603:10b6:a03:1e0::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.19 via Frontend Transport; Mon,
 13 Jul 2026 07:30:59 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 BY1PEPF0001AE1C.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.9
 via Frontend Transport; Mon, 13 Jul 2026 07:30:59 +0000
Received: from axiado.com (unknown [10.4.1.181])
 by smtp.corp.axiado.com (Postfix) with ESMTP id B0FB14186B52;
 Mon, 13 Jul 2026 00:30:58 -0700 (PDT)
From: Kuan-Jui Chiu <kchiu@axiado.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org, philmd@oss.qualcomm.com
Cc: Kuan-Jui Chiu <kchiu@axiado.com>
Subject: [PATCH v7 0/8] Add Axiado SoC AX3000 and EVK board
Date: Mon, 13 Jul 2026 00:30:25 -0700
Message-Id: <20260713073033.3883619-1-kchiu@axiado.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1C:EE_|LV3PR18MB6129:EE_
X-MS-Office365-Filtering-Correlation-Id: d161eb7d-6a71-4e68-a667-08dee0b0af27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|23010399003|1800799024|36860700016|13003099007|3023799007|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: qBIpNeYmIJozRvZhh4/w8V+cwz/5r4gQ3Xspdoqypv3ugCF3ow16/KvnXnHqyE+05J/Mix7Q8urply37MpfKwxVf1aCxtL+wJHb2S3w4VkEVGqqYmJGYEH+QOq4H3QMYNQwdkvj8U6+uB17eH1vo+ihclklaclhU/6sEOPbeBBY5jgcgBThgo/YuxnNT8r1uGvWqBVs2ck8J+BQTZUu5l1+UqurTrn4Irc4il9c4PIVW0yUDgAld8va5WN5RtLrCI1nDK6vo9dQR7WoJs2wcKGuC9vqq6twZtcGJ6Nvo42QHBijuzyZEd4pXXOWyXcn9Wfg7BiPSXdrG9H/NZbNweIFEnjNTLhFNhLWg5OhVR6FS2+Ro5gp84/JiHVyZ7QCuhAhC9x+7bEJIfYJJ01V2L84NVKJ/L4Bv/7W9XQHoBWoPC5kNZQfOavxkD7CZSgNgaeAlHZwAOiLsNqpPke7QxoEOrjEYzBU2/KzGzx3szkkIcLGQLRcGbm2zR0vFps6rWyt5E99HdFCh9jFWhApznNP0cgZU6OfbZDNyyS4fKFltJX3bFdlKOrM0ZItn0FKoWfTI6xMmyZiJeNNwLs9i4Bxj5oQ//AINtXBKlmPnyO7rbilShkYKWyOfsEzzFVrLfuwuUGsec9ytFzKhXCyBig==
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(23010399003)(1800799024)(36860700016)(13003099007)(3023799007)(56012099006)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +fTI+oBd6jv8g3F/4371rgOhetrSz3YY7OULqozhgYZlS02DQgs1QinwhG8OliU4Bf6LNDG2PnBcfRhXzqq80XdP7493vrjUjzRBvepSWG4Stsoopbgdxo7r+w2HmQzY7tpbqNW3UIaeNR/oyDvkby8B9M/6BL2DUnxie0TFU0BKopAacQQtgs9UsECYizMqn9F2WJle2IuOCXlu/+p0Xj/G/pnaOEBVH5jAjD4ilY3xYKUHqhJSCf/z+X237D9PHuAp6s7m9eOEKJnd5HdLrgKZVQIoe+w//dFv4tCHfGnwgPnX2L9rEe+04yT73sTMomG7mP7gHLdkeln0KrIynBaruSqmAmpi0aRIMOmrM5KdshA6f4OaMTdqZ9hyKpsFYwNWuJSMcw6THJ40+wycWnYFXQWb37gX8v2gTKRdJ+JJS4MOHKPb2wDdIPKKajVK
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 07:30:59.0216 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d161eb7d-6a71-4e68-a667-08dee0b0af27
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE1C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR18MB6129
Received-SPF: pass client-ip=52.101.43.91; envelope-from=kchiu@axiado.com;
 helo=SJ2PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
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

Refer Axiado website for more product information
https://axiado.com/products/

Test plan:
1. Verified the machine "axiado-scm3003" with following command

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

2. Run QEMU test suite
make check
Ok:                326
Fail:              0
Skipped:           20

make check-functional
Ok:                26
Fail:              0
Skipped:           8

Changes in v7:
  1. Create SD device only if -drive argument is present

Changes in v6:
  1. Add qemu_log_mask(LOG_UNIMP) into axiado_clk and axiado_sdhci for
     unimplemented registers
  2. Revise header of axiado_sdhci
  3. Add "const" to temporary data structures

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
 hw/arm/ax3000-soc.c            | 242 +++++++++++++++++++++++++++
 hw/arm/meson.build             |   6 +
 hw/gpio/Kconfig                |   3 +
 hw/gpio/cadence_gpio.c         | 292 +++++++++++++++++++++++++++++++++
 hw/gpio/meson.build            |   1 +
 hw/gpio/trace-events           |   5 +
 hw/misc/Kconfig                |   3 +
 hw/misc/axiado_clk.c           |  77 +++++++++
 hw/misc/meson.build            |   3 +
 hw/sd/Kconfig                  |   4 +
 hw/sd/axiado_sdhci.c           | 117 +++++++++++++
 hw/sd/meson.build              |   1 +
 include/hw/arm/ax3000-boards.h |  28 ++++
 include/hw/arm/ax3000-soc.h    |  98 +++++++++++
 include/hw/gpio/cadence_gpio.h |  55 +++++++
 include/hw/misc/axiado_clk.h   |  26 +++
 include/hw/sd/axiado_sdhci.h   |  21 +++
 21 files changed, 1089 insertions(+)
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


