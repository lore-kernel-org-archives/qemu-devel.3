Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 501E0C79FB6
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 10:57:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4FyF-00042p-2h; Wed, 09 Sep 2026 06:56:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1x4FyB-00040F-NH; Wed, 09 Sep 2026 06:55:59 -0400
Received: from mail-eastus2azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c110::3] helo=BN8PR05CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1x4Fy9-0004FS-LN; Wed, 09 Sep 2026 06:55:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ilj6xSUfMKLALosue30tc29bW+ttryHu0LnGaCq6W0zF3dNOL1y2QJmdFYbZ75IlgPbt27KnwJlnkSM7hq18N2NFgiA2GVn75+Ce4wo+4/lrxgwnUu2MCO3pQj4BHrYYhuShOY6IER36BO+HyE4ISh0VU/KKHfR0+wkociSui3cfJimAE0QOiRwJqVGijmIqMX9yDcbUyjyksRcHw/IYSta7WriwJdYkkaF7rlMYY3T+WwGDZz6ZbmheWOLnWXQNJvflASgz5qo+l6+mYGTXu7wN1oSvyPjG0wQqH/5fTrpDX4RPC7G9KfYFsZY3XKx06ANwN7M+79CVqfnRMt+sIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ESdEqbH+Tg3G3/YtiZAkH4fkmCAVP5pNR4Vxkhhi7xg=;
 b=ot2WDLX3Gz55skQ7iLzWOxBsGKe9IaYhMJKVsJnVyvxDVrJwnTNkgkTyCBDX51tdRDrI4BFOzoTlk7T34M/m+pqAf84gHxW7kqxFQBca1Yr0X+VXujHgXG7YWX4gUNcY2Sd5RMOOJdwHpYDxasruVaxB9JW9xEkQ6ZTAAKfhivv9SOlc3+PlpgGoM5ouq7DsqmF/qmkYydQmuaGwodkq6AXKc7sbng8ujNWDByY2uz0GuYx13d4QmJHCuO+0K0uE1dFRU+Xor+8XQcRTPUmSwTpBy0MC406fsE/wX7i+SAXA/tQHD213RKnCtW6cLYIPV5a0dQmKyUpwrqwM1T2BFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ESdEqbH+Tg3G3/YtiZAkH4fkmCAVP5pNR4Vxkhhi7xg=;
 b=AAYp44Jp4qaJjWmwkwef3iTDNwCtEE6wKtrmWNhE4Eqw6DiUZkMGSIB3eppWW8h4MyJZZy5D8AzMcJhKMXAWRtokluS0ijtdHjzAOcNbXnB3aiYCsFjUSp2WBkHkef+L0alOGAknNVDjXd97skKjqvL6hdQ3+O5xgu8WA/dZ/+Yvmvt8tegTHVlQAGGqBJEnZOqd06P6RIVGMal9dU+5k+VIEt5sK1XUDEmwRKYMSQ1T58h+fBsWFcc3PeR7j7q4zF7T8DSDA5Aiv5bYGm3haMq+vWrDSl8wn4VaYVkRHZ5/ywvITx+qBp7Igy6bOOMFQIc+ATZ7BDiW9LqRaBB2Lg==
Received: from BN9PR03CA0639.namprd03.prod.outlook.com (2603:10b6:408:13b::14)
 by BL1PR18MB4374.namprd18.prod.outlook.com (2603:10b6:208:31d::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.13; Wed, 9 Sep
 2026 10:55:49 +0000
Received: from BN1PEPF00018548.namprd05.prod.outlook.com
 (2603:10b6:408:13b:cafe::35) by BN9PR03CA0639.outlook.office365.com
 (2603:10b6:408:13b::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.8 via Frontend Transport; Wed, 9
 Sep 2026 10:55:49 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 BN1PEPF00018548.mail.protection.outlook.com (10.167.248.7) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.5
 via Frontend Transport; Wed, 9 Sep 2026 10:55:48 +0000
Received: from axiado.com (unknown [10.4.1.181])
 by smtp.corp.axiado.com (Postfix) with ESMTP id 110364186B53;
 Wed,  9 Sep 2026 03:55:48 -0700 (PDT)
From: Kuan-Jui Chiu <kchiu@axiado.com>
To: philmd@oss.qualcomm.com, 163wangjack@gmail.com, qemu-devel@nongnu.org,
 peter.maydell@linaro.org, qemu-arm@nongnu.org
Cc: Kuan-Jui Chiu <kchiu@axiado.com>
Subject: [PATCH v6 00/12] Add Axiado SoC AX3005 and EVB
Date: Wed,  9 Sep 2026 03:55:27 -0700
Message-Id: <20260909105543.1478008-1-kchiu@axiado.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00018548:EE_|BL1PR18MB4374:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b2a9825-9f11-413a-d5f8-08df0e60e879
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|23010399003|13003099007|10067099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: kVy/KDSqCBJ1OQEh6k8U+p4GsdtrujyKqnLu8mjwVIL4XHEpNKFZhupIer9FKlLk8Zlxd3yGLmlne6TaAJqyN6iQQ2r59tSelEtNfBkl+PW3reh/pK0JfneiOL/EQ3MWBk0jsQeqrrvXdrmjJB116B3RL4Q+J/BvYLC3IC9x1yTcZUOIKwleFIzk+Q9jOjwUFrA7g3e6/+MPUgKDLmroRDVqu0nVCjIXjBic2P0Nd4v85Fh+dmESjdUw7FHK9umzEcRwqzvRcwqPSzwRhtIUXh6qPwzhieJPRI9jGyRqC/fLub9/H96uZ01zehsFuZXfp15Oa1tWygzZ9nbu/R5eZglAIBw/30/p5fb11xMxOwBHPot5cfZG8lnIwh8zvkcv4l9HjYAoqipQFaY1a4i1GCvmAnmYD03xIthh9fB/elj5LKkOLECnRhR4d4u7/q2u50/C+bI7odryqHNI+Ju0u6hsS034eBNh2VOKS76HgZQ4N+XTNF1VHlyKuy3ONW+y2K0ha9IODgaFxDbdNGLxDmPYnmrCs40O9dp3/JCN9ODQsyEp7pBWqBEIoAvfz92M0Qrww/LOxbXU32wmzCPJRkzYTuFSb7oT6ih3WKyNRa/2hYz4ulcbbggck+DykFUmTQsFL0hwKK4Y7NpPN4apYA==
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(23010399003)(13003099007)(10067099003)(56012099006)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: POJJToYmK7pqRLsLsUc9YH88+1yYE5WozFKSzCoPZMgjn2hg6TpUjcikkGMNxgFlR5WKZYFmi+PNZXRqUv2DobPUlY6VglgKNyJUgNSFGY6fQfvrhq4bbMuvpZe+S+4D3+sT4xmXqRVtsJZB3iTLjbf+KX8ja3tRN2ycftHW72UPLMP5aT/yPfKLhEK1F3qn+BT6YKHY0M35Rx/2rqRvK/TIUJedd3GMrIbaa7Lf6Np538CR0wUDUx+SXILaEBK4SNJSuoF9+DzttXqeJqy9UOxbbuX0M/j0Q9PJluzTYOIufooLF8orYKGm2PMSt+0Imy7sNIYR8vVH+1U3vDT0c1OIRqsRXEKfD1pQDAgqRYHkCBF+x5xXb2zTN8ZMk7uHNaH7TvQ1qjaFI29HfQUYCoVEbGSbZAJ7l7M96WNXxu2HvKvKek2h9szOHpVkU8HR
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 10:55:48.8165 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b2a9825-9f11-413a-d5f8-08df0e60e879
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00018548.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR18MB4374
Received-SPF: pass client-ip=2a01:111:f403:c110::3;
 envelope-from=kchiu@axiado.com;
 helo=BN8PR05CU002.outbound.protection.outlook.com
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
    -drive if=sd,file=obmc-phosphor-image-evk-ax3005-qemu.wic.qcow2,format=qcow2

2. Run QEMU test suite
make check
Ok:                360
Fail:              0
Skipped:           21

make check-functional
Ok:                31
Fail:              0
Skipped:           6

Changes in v6:
  1. Drop patch ("hw/sd/axiado_sdhci: Add header guard") since it had been
     merged
  2. Remove redundant machines-qom.h

Changes in v5:
  1. Add patch ("hw/char/cadence_uart: Add BXRS register definition") to add
     BXRS register into CADENCE UART model and add new property to control this
     feature.
  2. Drop patch ("hw/char/cadence_uart: Reserve MMIO with dynamic size")
  3. Add patch ("hw/arm/ax3000-soc: Enable BXRS support of CADENCE UART") to
     enable BXRS support in Ax3000 SoC
  4. Add patch ("hw/char/cadence_uart: Reduce the size of MMIO to 0x80") to
     change the MMIO size to 0x80 from 0x1000.
  5. Add patch for Ax3000 SoC
     ("hw/arm/ax3000-boards: Add modify_dtb for discontiguous memory") to fix
     memory issue while -dtb option is applied
  6. Add patch for Ax3000 SoC
     ("hw/arm/ax3000-boards: Remove redundant pointor from struct") to create
     SoC instance during init() and remove redundant pointor from struct
  7. Add document for Axiado SoCs and EVKs
  8. Add functional test for Axiado SoCs and EVKs

Changes in v4:
  1. Add patch ("hw/char/cadence_uart: Reserve MMIO with dynamic size") which
     allow other models to revise the MMIO size of Cadence UART
  2. Change the MMIO size of Cadence UART to 512 KiB in Ax3000/Ax3005 SoC to
     resolve the overlapping region issue
  3. Add memory guard in Ax3000/Ax3005 EVK to check the memory size specified by
     -m option and set the default_ram_size to the RAM size supported by Axiado
     SoC

Changes in v3:
  1. Remove patch ("hw/arm/ax3000-soc: Add missing class_size to TypeInfo")
     because it was fixed by commit 4f50d637e2
     ("hw/arm/ax3000-soc: fix heap overflow from missing class_size")

Changes in v2:
  1. Add patch "hw/arm/ax3000-soc: Add missing class_size to TypeInfo"
     to fix incorrect class size
  2. Add missing class_size "Ax3005SoCClass" to ax3005_soc_types


Kuan-Jui Chiu (12):
  hw/char/cadence_uart: Reduce the size of MMIO to 0x80
  hw/char/cadence_uart: Add BXRS register definition
  hw/arm/ax3000-soc: Enable BXRS support of CADENCE UART
  hw/arm: Rename ax3000-boards as axiado-boards
  hw/arm/ax3000: Specify SoC name in header and variable
  hw/arm/ax3000-boards: Add memory guard
  hw/arm/ax3000-boards: Add modify_dtb for discontiguous memory
  hw/arm/ax3000-boards: Remove redundant pointor from struct
  hw/arm: Add Axiado SoC AX3005
  hw/arm: Add Axiado Ax3005 EVB
  docs/system/arm: Document Axiado boards
  tests/functional/aarch64: Add functional test for Axiado EVKs

 MAINTAINERS                                   |   5 +
 docs/system/arm/axiado.rst                    | 128 ++++++++++
 docs/system/target-arm.rst                    |   1 +
 hw/arm/ax3000-boards.c                        |  71 +++++-
 hw/arm/ax3000-evk.c                           |   4 +-
 hw/arm/ax3000-soc.c                           |   5 +-
 hw/arm/ax3005-evk.c                           | 115 +++++++++
 hw/arm/ax3005-soc.c                           | 226 ++++++++++++++++++
 hw/arm/meson.build                            |   6 +-
 hw/char/cadence_uart.c                        |  17 +-
 include/hw/arm/ax3000-soc.h                   |   1 +
 include/hw/arm/ax3005-soc.h                   | 102 ++++++++
 .../arm/{ax3000-boards.h => axiado-boards.h}  |  10 +-
 include/hw/char/cadence_uart.h                |   4 +-
 tests/functional/aarch64/meson.build          |   4 +
 tests/functional/aarch64/test_ax3005_evb.py   | 140 +++++++++++
 .../functional/aarch64/test_axiado_scm3003.py |  62 +++++
 17 files changed, 882 insertions(+), 19 deletions(-)
 create mode 100644 docs/system/arm/axiado.rst
 create mode 100644 hw/arm/ax3005-evk.c
 create mode 100644 hw/arm/ax3005-soc.c
 create mode 100644 include/hw/arm/ax3005-soc.h
 rename include/hw/arm/{ax3000-boards.h => axiado-boards.h} (71%)
 create mode 100755 tests/functional/aarch64/test_ax3005_evb.py
 create mode 100755 tests/functional/aarch64/test_axiado_scm3003.py

-- 
2.34.1


