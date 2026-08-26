Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74DA0C61DBD
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 07:47:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wz8Lg-0004zF-3l; Wed, 26 Aug 2026 03:47:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1wz8Le-0004yc-3q; Wed, 26 Aug 2026 03:47:02 -0400
Received: from mail-westusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c000::1] helo=BYAPR05CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1wz8Lb-0001Xd-Pt; Wed, 26 Aug 2026 03:47:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mjO1YGxa8vcNStXzHkIGKujNkAqG1ut+I+J1QuV+TQzNKXajpWHduw9PJgxaplU9pr9V3gsgb+2HUsA36DQILR9gLBqsJ+wDGrGcaHN8WVu2P8xIxwmn0XOaZyuRIgqR4BMekpisfdPBiKvtlSmCXULAbYrZ/l8c3R5HvYzIaGnlvaYwfhiQEBwsFxPxicKvjvalw90swk96REsDiwaFllBGGoVmyr3adREJqCoGIisYaifqP6UAT+0JMOqVLFTN0Sj6U/nQsQtN2ngnfSenASg5C9p38j2eJu2ShF6bsujNhm+J6B7NETRY3u231k/VCjuid2nVZ6yaqF69yhlAJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HLSg9qRSL3EUluGAqlz78mSiQvqGkxwOYz8kvmcrsZI=;
 b=k3oMtZdE8wzi5FhT4A2Ir6TgOJ7/b7Q08xkaBKMjBZ1O4Zbg8atiEMZ/+gQXEE/Aqs8bphhQ9SBZcgFQWQa03gQWODi/t6WDxebNHwhANtoucBI5ROhbVqnH+w0Te4hnh6XoFdWGi8h3sYxaRx6pwylaDit0TU2xVnIjDYQpUcz66e0dWRFo/UtEBipA6bVzYDCnATkoWtcXmNDvernk+hlFVqOjr+ehFJ916Cx4B7dnwT7UaHMk4Ga0Qv+gY02n9Pr4nlgd0DQ5tlwaLyXdbPD7j38Go+pViLCZs6wbEFd49yZDZdK46Df4tm6UxbbeRyuSwyZ/dOQDD/9yRseycA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HLSg9qRSL3EUluGAqlz78mSiQvqGkxwOYz8kvmcrsZI=;
 b=Q5QOsRiG30samPbVoGm178KlcDC8GKuXNJh0dwP/hIgMm+r8zQL7n9lfx50d+hz5ILdQNnjeVsS7FZdVyholyLUMz0prRi/UtXywKyqB8R3a5UPzVTn7FdpSTO4FZUdVHrf9CzTr6HMTCVB1uo2EezBJyzw3ySaIeDE+eQFI161Q60mDnPHH/NjQygBWc6cofJZFvpDPloMwgWcehNC5OwB0uo/9YLp+WexwzbyXx0zsgNo9Md7JYFvQuVOOJBxemcn+9L8jX+dxa6tr9tHTa3cI5c3+fxpv8ABItjMP+UCcniRMZxJDOSAZe9G82Amf6I862s5LR7FyS6RT8P9wxA==
Received: from CH3P221CA0017.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1e7::16)
 by CH0PR18MB5483.namprd18.prod.outlook.com (2603:10b6:610:182::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.8; Wed, 26 Aug
 2026 07:46:51 +0000
Received: from BL6PEPF0001AB54.namprd02.prod.outlook.com
 (2603:10b6:610:1e7:cafe::38) by CH3P221CA0017.outlook.office365.com
 (2603:10b6:610:1e7::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.8 via Frontend Transport; Wed, 26
 Aug 2026 07:46:51 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 BL6PEPF0001AB54.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.3
 via Frontend Transport; Wed, 26 Aug 2026 07:46:50 +0000
Received: from axiado.com (unknown [10.4.1.181])
 by smtp.corp.axiado.com (Postfix) with ESMTP id 211F24186B51;
 Wed, 26 Aug 2026 00:46:50 -0700 (PDT)
From: Kuan-Jui Chiu <kchiu@axiado.com>
To: 163wangjack@gmail.com, qemu-devel@nongnu.org, peter.maydell@linaro.org,
 qemu-arm@nongnu.org
Cc: Kuan-Jui Chiu <kchiu@axiado.com>
Subject: [PATCH v4 0/8] Add Axiado SoC AX3005 and EVB
Date: Wed, 26 Aug 2026 00:46:26 -0700
Message-Id: <20260826074635.2850931-1-kchiu@axiado.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB54:EE_|CH0PR18MB5483:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 0bb3399b-caef-4895-cd23-08df034630c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|1800799024|82310400026|376014|56012099006|10067099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info: FFggMSKOqmAjJB1n9ofLLdXr3QTKBpq1IuVY3rWBHYfLR33hwtXdajGi+B+rQI7DS/GPmWy0kSoFveYVPHfoLRnWp7bWKEMQOGOrphrFNHQitzqpiXwJcqAAtHJa88olnI/3C5tpdxT56++5pq2gnx8heNTjhdFeyZ9BH5GtETH/V7uggQlNbh28z7XkpRgqMCq3pzJOc82HITSVTL+iPSinCf4rPTNWJYuYBr2kqJYbjRsgPmXlPuU7/N6E2JZlpfAU1HcVz7adINzCUesdDojCBPyALTHdt6S3Dq1C/2dGcoHvajp8jOCM/Z/JZ72B6KztBpB7l49uD77/fCGQdqayN6DXLSwTsJwve7vQCsn6aOKQ/7baoKZL+EnpEiaHpQIZdRIE+K0cl1EysCshYTrLCm+mYBNAOJcdCCkWqXhS0y6xZLhMvEMtwZ5pXSArBBocLA/YWvBwk89pzdzg10AD9afIiMKDjDuUUdHpP4RTM/DebKpeG733p0uH5wQ6CYdpSy6e68e3p99LMBc29PGOa1ZYmZKvB+da2qxqmhAEjw0b/2vZbVeOMZwbXmim9JIIk/dP4yGwM8oDH4bO/nxDidYIJtuevW+uRGXxPxTNvCXbfwss8VYeQVxEBC1msmWrKPih/Lfp7lssLbmJAg==
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(1800799024)(82310400026)(376014)(56012099006)(10067099003)(18002099003)(13003099007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: dm5Uty49XrSppkHEtyf2zglmJFq6SFSftLkS0u3g6y/k+C7eFwTFcD1QYTnRowRYYCkieTMsggq3Me0ZRkZ9zLwDunu7jhEc7An25RkbMnYQTbPsuSxD2zn1M5KjR2ahPgIUhih33gVw/09kb6bj8zjyKY+BsoeBulLd8yTtV6dEmf0NWzL8GuAfn36di2ZW42v2CiB4d18k6xXTPJ7ILtr4JStnzjBDLSEYYYaVQ7s1zciSeIKYqq6llGGPVUy9s1MbiID9Y7d0Ddbp9QPVPLn9hZ32ezIIt4fAu1ZVjEQdrtfxZdiWRy0Sw8Uj2VIyRI2I7SPlizQR0BsGV3YnUSd5JvjR7Cv/LDKjGIOY5LG5uBmgBjAsWPGzY9w6q41KTwkVun5nFeJmqIRxXK7fp/rkrQqLjZce080j8nt9TxoZl8u5i9mhSwgQZV1DrXZq
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 07:46:50.8928 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bb3399b-caef-4895-cd23-08df034630c4
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB54.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR18MB5483
Received-SPF: pass client-ip=2a01:111:f403:c000::1;
 envelope-from=kchiu@axiado.com;
 helo=BYAPR05CU005.outbound.protection.outlook.com
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

This patchset introduces Axiado SoC AX3005 and evaluation board for emulation
The model for Axiado SoC AX3005 supports
  4 Cortex-A53 CPUs
  Arm Generic Interrupt Controller v3
  9 Cadence UARTs
  1 SDHCI controller with PHY
  8 Cadence GPIOs

Refer Axiado website for more product information
https://axiado.com/products/

and minor changes for the compatibility with existing AX3000 SoC model

Test plan:
1. Verified the machine "ax3005-evb" with following command

qemu-system-aarch64 \
    -m 2G \
    -machine ax3005-evb \
    -device loader,file=bl31.bin,addr=0x88300000 \
    -device loader,file=tee-raw.bin,addr=0x88400000 \
    -device loader,file=u-boot.bin,addr=0x80000000 \
    -device loader,file=fitImage,addr=0x80100000 \
    -device loader,file=obmc-phosphor-image-evk-ax3005-qemu.squashfs-xz,addr=0x80B00000 \
    -device loader,cpu-num=0,addr=0x88300000 \
    -device loader,cpu-num=1,addr=0x88300000 \
    -device loader,cpu-num=2,addr=0x88300000 \
    -device loader,cpu-num=3,addr=0x88300000 \
    -nographic \
    -serial null \
    -serial null \
    -serial null \
    -serial mon:stdio \
    -drive if=sd,file=obmc-phosphor-image-evk-ax3005-qemu.wic,format=raw

2. Run QEMU test suite
make check
Ok:                331
Fail:              0
Skipped:           17

make check-functional
Ok:                28
Fail:              0
Skipped:           7

Changes in v4:
  1. Add patch ("hw/char/cadence_uart: Reserve MMIO with dynamic size") which 
     allow other models to revise the MMIO size of Cadence UART
  2. Change the MMIO size of Cadence UART to 512 KiB in Ax3000/Ax3005 SoC to 
     resolve the overlapping region issue
  3. Add memory guard in Ax3000/Ax3005 EVK to check the memory size specified by 
     -m option and set the default_ram_size to the RAM size supported by Axiado 
     SoC

Changes in v3:
  1. Remove patch "hw/arm/ax3000-soc: Add missing class_size to TypeInfo" 
     because it was fixed by commit 4f50d637e2
     ("hw/arm/ax3000-soc: fix heap overflow from missing class_size")

Changes in v2:
  1. Add patch "hw/arm/ax3000-soc: Add missing class_size to TypeInfo" 
     to fix incorrect class size
  2. Add missing class_size "Ax3005SoCClass" to ax3005_soc_types

Kuan-Jui Chiu (8):
  hw/sd/axiado_sdhci: Add header guard
  hw/arm: Rename ax3000-boards as axiado-boards
  hw/arm/ax3000: Specify SoC name in header and variable
  hw/char/cadence_uart: Reserve MMIO with dynamic size
  hw/arm/ax3000-soc: Reserve MMIO of UART with 512 KiB
  hw/arm/ax3000-boards: Add memory guard
  hw/arm: Add Axiado SoC AX3005
  hw/arm: Add Axiado Ax3005 EVB

 MAINTAINERS                                   |   2 +
 hw/arm/ax3000-boards.c                        |  13 +-
 hw/arm/ax3000-evk.c                           |   4 +-
 hw/arm/ax3000-soc.c                           |   6 +-
 hw/arm/ax3005-evk.c                           |  64 +++++
 hw/arm/ax3005-soc.c                           | 227 ++++++++++++++++++
 hw/arm/meson.build                            |   6 +-
 hw/char/cadence_uart.c                        |   8 +-
 include/hw/arm/ax3000-soc.h                   |   2 +
 include/hw/arm/ax3005-soc.h                   | 103 ++++++++
 .../arm/{ax3000-boards.h => axiado-boards.h}  |  10 +
 include/hw/char/cadence_uart.h                |   3 +
 include/hw/sd/axiado_sdhci.h                  |   5 +
 13 files changed, 443 insertions(+), 10 deletions(-)
 create mode 100644 hw/arm/ax3005-evk.c
 create mode 100644 hw/arm/ax3005-soc.c
 create mode 100644 include/hw/arm/ax3005-soc.h
 rename include/hw/arm/{ax3000-boards.h => axiado-boards.h} (69%)

-- 
2.34.1


