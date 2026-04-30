Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D7C4FF886F
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 09:24:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wINce-0000u5-1S; Thu, 30 Apr 2026 05:23:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wINcc-0000tt-35
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 05:23:50 -0400
Received: from mail-westcentralusazon11020081.outbound.protection.outlook.com
 ([40.93.198.81] helo=CY7PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wINca-0006x4-J0
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 05:23:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i6rzZhx1tZh+xJDYs/Q+BuVD5DPtWP2H3+1AMwDKJbIM8TRs3rK6gfU9efuEItLL6/5kzO33+1o0TEwWGY45++B/8XFqzEW4aCRYanEGfRfv1WaBxAWUy+2OuVlAH6fytF88VhSfIu450ggj+geqCOly9jCDwIsOrF1d8LUPZXfKVZMWIu0Gj06zbszwF8xdv2vHwQlhvtNv6jYOarpmqiMEkt4MKJO5ghiFk/EibVMniIMy0drSuU7wPmoBkMaHL34+6qmsLCpXFAP6NaDh/qifklwNoSzLtHotzkdTTTrXWxcBIw6xL2aE/NaryvCq93oa8KrtuPX7JepVLF5pUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uner3fED+QGDhIJ92JsXZGrGRk70hboN3SM5K69yCps=;
 b=O6LIw9XvuarviXA808IlKkxbGyMu/xhUxx26SyCgdxJw54/RiLK2qpQRXb7zkawcXcYRQWTMBbDQYvqtFxITD7vJoPIurAS7li2TDj1wCztZW96kghwKiVJxOJhV5gMgbqMEZCZa5AJ5DM8HE0xdvfH/r20CH9L7pFdTJ7OIuf/e5YYAwu5mCxG96sAZ040by1AsZAK45Nc79UMKRLQGKA5w16tbL0I6JlwTqgaDELhfFmVxtw9gXGinYqSc9kn2J0LI3+0SVwMWaKBNVFvcRoWpjmKURu7Mb0PPkBbuK+5GynWvFAMgWax3FjKj8QTlxfRpNx+WS9znZFMzhkt3eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uner3fED+QGDhIJ92JsXZGrGRk70hboN3SM5K69yCps=;
 b=DFBlQgaCpeD9dJ6b2TnBaSiae4obnWwtV48zW1aKTc/rkSwYw0UrhHb+vOw3JcEzY/rLlbjbYInNdoq3x3+REuFz/Nd/+diMDUNPWuw7Jv3t1Ol2+S2XYFQ0sQc7j+chxWZImqG/JLauh5Lt8w+aLPX1VaoBQvPod/0N8nAksIVzevUQ7dgJ3Iq6gsPQaruIyfyeulN+C/TI+O/ktqzKPI8BodbvZ3X+0ZJE7LPzwU2CMtTRF41XhC9taCcGerRFxlQcQ/NF5/2IZoNWyfU7/1aSJMJ9LU9AVyluLTR8bwcU1OpOq87NdJqXX5RmKQIZ1gJQl1jqO3gp3fukWC/0dQ==
Received: from SJ0PR03CA0236.namprd03.prod.outlook.com (2603:10b6:a03:39f::31)
 by CO6PR18MB3827.namprd18.prod.outlook.com (2603:10b6:5:353::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 09:18:42 +0000
Received: from SJ5PEPF00000209.namprd05.prod.outlook.com
 (2603:10b6:a03:39f:cafe::f4) by SJ0PR03CA0236.outlook.office365.com
 (2603:10b6:a03:39f::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.30 via Frontend Transport; Thu,
 30 Apr 2026 09:18:41 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 SJ5PEPF00000209.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.18
 via Frontend Transport; Thu, 30 Apr 2026 09:18:41 +0000
Received: from axiado.com (vm-swbuild01.axiadoRD [10.4.1.181])
 by smtp.corp.axiado.com (Postfix) with ESMTP id 15A0F4186B51;
 Thu, 30 Apr 2026 02:16:49 -0700 (PDT)
From: Kuan-Jui Chiu <kchiu@axiado.com>
To: qemu-devel@nongnu.org
Cc: Kuan-Jui Chiu <kchiu@axiado.com>
Subject: [PATCH v2 0/4] Add Axiado SoC AX3000 and EVK board
Date: Thu, 30 Apr 2026 02:18:28 -0700
Message-Id: <20260430091832.1846637-1-kchiu@axiado.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000209:EE_|CO6PR18MB3827:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 35f8a92d-5f17-4be4-8abc-08dea6997894
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|34020700016|82310400026|1800799024|56012099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info: 8j7nYilX3B/HgX1iNEneAx8K6wjipTe36P0vHrNJVuyVkFiQZKeY+iyVPQuOrbWm/VG/VM8Jj4+6k8CX/H0qSf2ABNTPdqXgvnuDpQpWjaIdtoopZghaPu1VBWIl5AZfuUsAa2Dbnmq2c16iYX38vL12NjTAd2ekYLLb7MfkkQDUALHNfMKtOn543EoYKyH6bE1KdeVZ0xrElwNP9hjPw9sLwwCJoFtVBd6xpOjPj+/fQ0CGc6RKVyXMBv0v15f0NZlK6iE9D53vqepxX+yLf6ACMMznCkrSfWosf6zr3INUOp0zQ0XgWpsy7atY0QqPcpOxM3r8M0F94U9VURN5mw8kiAi5++3CP8hSSed/iAop7s2KLEAJW1rH+/XBCzlItBnJAP2hgt+9vX31cQEIvQ9U2fEXw41cZdh4qX8ekabIpH+kPfVkai0BjDpFcVdncz2TBvIk0ITwXxDbKWeyE8q4J1uQpDHRsNTO1gBLW0wo0KTzoR2CeVzPDNWRir7FI/5abqVB0rNdEaxPc6V6F2CCD7Z8z3JoFdEAAlhc/SUNBc82H9rMMshgiwiSeE7dWfN5wcTDPo5qMf7Ejb0dM2IMJyK9PNz+c7RHtbM0+7eOITB+0jlCz+6nLqLx1ChuPM4AA4WyKl4qOl9xxCR5xkJXMjbXcjpouhPsYY1YKZA4jdBvdRMdS38DhM0VVUA1j0Elb4DPPf4zjHaEFDDYRyRsxbwN9b2L/xCGoeGA5jo=
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(34020700016)(82310400026)(1800799024)(56012099003)(18002099003)(13003099007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: S+hEEuK/QdMhMrSsda+kd/ZPyTCVHI7EeHfRMM2anbvzHb2dkaUkCFY+HXGoJ26MYjTX8+AH7nmyks47VMcIzWNt9dsqX/WG46MeGV9KIgKeKVspTC4nN87LCLg7+iH3bylka/9VBWgb+S7OITvRzDgHL8s1x+Cx3SyYgDH6d2UGMDcpYO0QE8cTTaN61npn6nQTHGeVRksxnb2Uz/CNimj9vqkB3IJ5bBzV6enJsEJ/PJXLoN6YXtH8+MR3pnOnXJSmlQ6gbG9GcoqSgIAcllH6aJB8nh0YRrxllTDphz+fRKO6kMcEPPrSI8zU17y8M0XX/LMnY6G0g/neYpAgSnG7R/jqOSC9suQXqqhF83k+AVDJzb7SMjsBBxnHqiSpPoUbRjB7Iwwohgo5tAQkApw3sZKyIQvTLf1g0QVYj5Z5LnHsno4Mf4kFstplqeJe
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 09:18:41.5902 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35f8a92d-5f17-4be4-8abc-08dea6997894
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000209.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR18MB3827
Received-SPF: pass client-ip=40.93.198.81; envelope-from=kchiu@axiado.com;
 helo=CY7PR03CU001.outbound.protection.outlook.com
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
    -drive if=sd,file=obmc-phosphor-image-evk-axiado-github.wic,format=raw

Refer Axiado website for more product information
https://axiado.com/products/

Changes in v2:
  1. Move axiado-* to ax3000-* in hw/arm and include/hw/arm
  2. Add axiado_sdhci to support AXIADO_SDHCI
  3. Move implementation for eMMC PHY device to axiado_sdhci
  4. Use UNIMP to create dummy device "timerctrl"
  5. Add cadence_gpio to support CADENCE_GPIO
  6. Enable Cadence GPIO controllers on AX3000 SoC

Kuan-Jui Chiu (4):
  hw/arm: Add Axiado SoC AX3000
  hw/arm: Add Axiado EVK SCM3003
  hw/gpio: Add Cadence GPIO controller
  hw/arm: ax3000-soc: Enable Cadence GPIO controllers

 MAINTAINERS                    |   9 +
 hw/arm/Kconfig                 |  14 ++
 hw/arm/ax3000-boards.c         |  52 ++++++
 hw/arm/ax3000-evk.c            |  27 +++
 hw/arm/ax3000-soc.c            | 262 +++++++++++++++++++++++++++
 hw/arm/meson.build             |   6 +
 hw/gpio/Kconfig                |   3 +
 hw/gpio/cadence_gpio.c         | 312 +++++++++++++++++++++++++++++++++
 hw/gpio/meson.build            |   1 +
 hw/gpio/trace-events           |   5 +
 hw/sd/Kconfig                  |   4 +
 hw/sd/axiado_sdhci.c           | 100 +++++++++++
 hw/sd/meson.build              |   1 +
 include/hw/arm/ax3000-boards.h |  28 +++
 include/hw/arm/ax3000-soc.h    |  99 +++++++++++
 include/hw/gpio/cadence_gpio.h |  66 +++++++
 include/hw/sd/axiado_sdhci.h   |  21 +++
 17 files changed, 1010 insertions(+)
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


