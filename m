Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33E3ECD6E4A
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 06:34:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUIhS-0005fz-17; Tue, 02 Jun 2026 02:34:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wUIhQ-0005ei-Bt
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 02:34:04 -0400
Received: from mail-northcentralusazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c105::5] helo=CH5PR02CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wUIhN-0004bV-KS
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 02:34:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qUwbZ+NBrByJZBPGvYPWpTnne4iq1CpCaYzm4+ZmabImNF99Dqf4CBrvPlY7NUAhxxFvyLdv4CbnP8K0AfGPxw8Z5q2uVr0+T74lmCCgX/QCmp4XTpPC+incBqLNzH6LrpMCpTAc5xYxA5/nJurSsc76BXMxGigHbkbUmxtAs9Q1jUPuJm6eilLr9tPnxaGR8PUIC/jUoO4xluThc2buV1wGPCsXgzfYcy/hBaaa8dbmO8Vx8vvTwumi5DCVbgigtHPSiCYQoxB4yM3i8XnQ2LDpDaNvDxOzd1cMsGD93S4s/S9eAnE7/lwNUXmlMIIwgM6mwGXwzOE7gzekoFOycg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=30BKSGEx7wUt2BqOUayY9hDIi+7MXDrYhDR/Zv68GxQ=;
 b=M7O+qqdQJAHn0YJMBOaqlYOPZxPi4jOwaN0xUDgfGmKbVBzm13hFBTAJWSkAnPv94z145fuajNN+me36YG9bX/AoW7FbCfour/9uhY/ZGGunvRfgqm0W1RQaPUXYmwZlEuIM1Yz0FCLRh3lS+Co7XxRKOA08xzeghFSgz9SlIIe4YXWycbihEzvtH6hDZzKwQ+Kvf2GMn1GXWm3PYP5nxU3ygx45ZsXi5CqkD9ZZV62hVRwvIB7/+kDzzepkBsq8m0qA/eQuFGnIrCbeEfMPvJ8FNdr1A79hEI13yicukJ5LUfsjk+ZKCM6LrrgCkQH2nY3DyY8oxqBtpFlM6i/5Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=30BKSGEx7wUt2BqOUayY9hDIi+7MXDrYhDR/Zv68GxQ=;
 b=Th6clpU3dcPaOdU+LpUXwQuGFandU+t2y0cZxXno6OXgxKjq1Zp8dfd0A4d/x7ypTfsZ6GvdJRzmJIBO8Lm2A7ZxrK+yFDyqbBd5p5KyKXpVhewwMNZhJaSE/hsJE/MHwJZSIWV/g5/6PCsLhCWc2GF9ss2rnFq01C3FwKxDG3j/pUHh03Ta/P/ofgTBbIh2ePoOALjNYsdyKbbBL50RN2eWMPQ6iuWZshFFqnQ2eCDSvh2AAyaEojjmiwlyotp08HY7jy5JJiIxaVX2k+6CWjxG4C+IXnJsx+C2TnmNTj6gSaS6JXBg39XHLejfrC7w4itRgyFdJhRJGJebfppATg==
Received: from BN0PR04CA0199.namprd04.prod.outlook.com (2603:10b6:408:e9::24)
 by DS4PPF671D35114.namprd18.prod.outlook.com (2603:10b6:f:fc00::a9e)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.16; Tue, 2 Jun
 2026 06:33:55 +0000
Received: from BL02EPF0002992C.namprd02.prod.outlook.com
 (2603:10b6:408:e9:cafe::64) by BN0PR04CA0199.outlook.office365.com
 (2603:10b6:408:e9::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.16 via Frontend Transport; Tue, 2
 Jun 2026 06:33:54 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 BL02EPF0002992C.mail.protection.outlook.com (10.167.249.57) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.5 via
 Frontend Transport; Tue, 2 Jun 2026 06:33:54 +0000
Received: from axiado.com (vm-swbuild01.axiadoRD [10.4.1.181])
 by smtp.corp.axiado.com (Postfix) with ESMTP id 4A43C4186B51;
 Mon,  1 Jun 2026 23:31:29 -0700 (PDT)
From: Kuan-Jui Chiu <kchiu@axiado.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Cc: Kuan-Jui Chiu <kchiu@axiado.com>
Subject: [PATCH v3 0/6] Add Axiado SoC AX3000 and EVK board
Date: Mon,  1 Jun 2026 23:33:44 -0700
Message-Id: <20260602063350.3623723-1-kchiu@axiado.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992C:EE_|DS4PPF671D35114:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: b074c816-6845-400c-1f10-08dec070eae9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|34020700016|376014|82310400026|36860700016|13003099007|56012099006|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: LrFuXNNk5VPa4zoxVTtySUDA5cf0xpUdKfU/VDqZWfjgsqlverN2AEyA20Y7NTIa5YmCLcfwE4N1G+jGdMotNH+BlzbRw3dYNNuDaWc05Qov+jwqPPQEwmyEPKODzlsWi2UgkloUQFJszur4fAewfksoRWGBtbc/kzGEwi/eGkmseWZNWvUSobUILAvH0QN71pQ2tatLA8eO1afFegrW5FEwR9UQKFXS+ystvbHhznXfVW9FG5WnNlBZdgMjAIxrZjVc80yR3xV56b+L+SCSxzuNKqFmnLqAlF4LOrFDcxSGnQXwFyoEh5PJ9Rs/tIItJ2Xo20TLlaZKWv+ensqPUJgyAhQ5sAMNCQ7xqIrHJzIZzcGW9AHuuZFICcdOjL2Y1cBdNL2+V6on1Zc80PzZkluykYh1xHnmy0azqoIjh4lFaVdXpAqsCBjDSPPFzGr2JUrhIvyYsFzuxFXUllHX65MdWzo2Z4xEfINgPHiIHSvL8ckQNlFPVFXsDi2GMTHM01y+NbVcASxQLSVpi6sIi2k7L7OzgkTt/AHeTwSxYlyQkh5REXqJSwG/CvmGxprOU1HfKgQH48+v0agfu69FFGWI0n6gGfEKmHbHYH+4qQZcWj8o9G8w64k4d6OtPqt0SwMD14Fqu0+2kGeOYEMs8mZUa11BSHHahROx9UZvOh6AHdwsIEXBLlqY7YAUn89V
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(34020700016)(376014)(82310400026)(36860700016)(13003099007)(56012099006)(18002099003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5tXMrenVCHUlujMhNw+3vhf+5myGU2qkzLkwEvr8ENh+hRh4OY08kRFW66A5I+aYfuZEEwInvZs5LQXAygB9tplAxrkXk0DFB2iKdDDbwkO689CL1GphMNfr7taGnkmrPETI0JxMpuMEqGwjri0z20VoRQJA5mY7OjkWkIAjESYRDXCyK/Nq7vmeADDAppV4UY/zaGUqmVH0xgetltY8bVXQ8HH2gu/Hgher7hWdwcfYdlR/WTz6NvY++wx1MuXhPiBPdCgjBCXnSVPJkIDuYsjALtWm39MhAqxpwMfteclgT/ndC4wDdqZJr8kpsDJJ3SeWV5jduObH5qLW1SPxT+XdT2pAcLUyy1vaaW7HJAjM1/0IggaRvjk7MG6RB40WqnLtBDmdudD9bmhMp4F8qLY2SI1U4X7gQg3VvNs2neMG0oKDh8eGmjEdb11HmmUC
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 06:33:54.1470 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b074c816-6845-400c-1f10-08dec070eae9
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF671D35114
Received-SPF: pass client-ip=2a01:111:f403:c105::5;
 envelope-from=kchiu@axiado.com;
 helo=CH5PR02CU005.outbound.protection.outlook.com
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
 hw/arm/ax3000-boards.c         |  47 +++++
 hw/arm/ax3000-evk.c            |  27 +++
 hw/arm/ax3000-soc.c            | 267 ++++++++++++++++++++++++++++
 hw/arm/meson.build             |   6 +
 hw/gpio/Kconfig                |   3 +
 hw/gpio/cadence_gpio.c         | 307 +++++++++++++++++++++++++++++++++
 hw/gpio/meson.build            |   1 +
 hw/gpio/trace-events           |   5 +
 hw/sd/Kconfig                  |   4 +
 hw/sd/axiado_sdhci.c           | 115 ++++++++++++
 hw/sd/meson.build              |   1 +
 include/hw/arm/ax3000-boards.h |  28 +++
 include/hw/arm/ax3000-soc.h    |  99 +++++++++++
 include/hw/gpio/cadence_gpio.h |  55 ++++++
 include/hw/sd/axiado_sdhci.h   |  21 +++
 17 files changed, 1009 insertions(+)
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


