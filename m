Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C3ADC79FA1
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 05:17:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4td6-0000cj-0N; Fri, 11 Sep 2026 01:16:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1x4tc2-00008L-52; Fri, 11 Sep 2026 01:15:46 -0400
Received: from mail-southcentralusazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::3] helo=SN4PR0501CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1x4tby-0005iM-Bb; Fri, 11 Sep 2026 01:15:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B2OlQy0fGyB2EZsIetaqchpwL1nnt9Ia7X/JTM/MklUbJfJCodczSolDfQ4tE3N8sKu85938lLEaKLHRsHqtERGMv1f2/pb3hnJrItZkib1YRiMbSnlMyNtFkrV1LVKGmMfkPyo9tyW9aLNHEXy0li56nRXwY1Y8VSKhqoRL9ap2sBxa1hkUCVjLVJm2+HE8zWJPD7FzQLDchlPWSwA5Rphuu+PvCtRZBDqU3pE4dHlB6AZT4qTCpXC1wk00N9rewozbLb7sO0/0HT492uAAG6/h5hcAxuJZtjaqOsPpfVvS4jOitiPGuZolYvr5EoxsSMtqEMBJ0iNLcBLF6yaWjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XUp3e111L1m5VnBOpBej6x0kg6vsvuyISMQITXFyC94=;
 b=uvMYP+rWFuIhLUf+iGjIzn0hEJz0lcAEvqr4a761ZZbjTxudHfuZ2FxqXFlaGmG3UWsWLQxM5660BV+F1kSh9WHIdR+BPMsv4y5lmN6LH+yhHUyp4SGEDOIl0hJqr+Ey1MPlq/coK2ZMEzVWXlJ4Ii+ZoYHHH36k5rDQkdpcUkE7rmvgSlRME4l2IlcdNwGGiGx7rlwl0C8JUuVEf5DdpHGgkH12DEaEcq5cWOw8Qm/ahJkzPO0UMHEG6cKYqQdhn8RsTL1708BHo1pleYMb+N8f5NOvZVmdyA8uDWLnF0XaYZBA+uIs89dn/9B8c2LV5uQbKbBCTOQPehx59APtfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XUp3e111L1m5VnBOpBej6x0kg6vsvuyISMQITXFyC94=;
 b=XlyqzuxF3ZkmggPshKAHe5uImy5NK9MoVfej7euXNOkT7BtutF1VrBZPXr1hdUs/jmlYmyQF1wAeZ257xeQYD71Wi2xHsIRn0UVoPQthEBBcZ9qpqEQEUojGmbSva9RNaaJPOrrbW70S81ZDl9bGvaG+jtVAh1gcS9iB5tU9SissciWkYrF+8x1zbcmTEDzfa2eSpWBd+HaO+NjfFaToVIotOWOV/suv1koIa+VenzO5RQtIwucq6P9R0aF16u8wUMJTUE2pxttxBWChNiMN4nZ1AL2TGwe90j3+ypZUMyHAztsNvzswhCMurUgcfykTaLOdYDrYo43tLmQf+rY1kg==
Received: from BY5PR04CA0007.namprd04.prod.outlook.com (2603:10b6:a03:1d0::17)
 by CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 05:15:35 +0000
Received: from MWH0EPF000A672E.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::4c) by BY5PR04CA0007.outlook.office365.com
 (2603:10b6:a03:1d0::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.9 via Frontend Transport; Fri, 11
 Sep 2026 05:15:35 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 MWH0EPF000A672E.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.5
 via Frontend Transport; Fri, 11 Sep 2026 05:15:34 +0000
Received: from axiado.com (unknown [10.4.1.181])
 by smtp.corp.axiado.com (Postfix) with ESMTP id 391914186B51;
 Thu, 10 Sep 2026 22:15:34 -0700 (PDT)
From: Kuan-Jui Chiu <kchiu@axiado.com>
To: mark.caveayland@nutanix.com, philmd@oss.qualcomm.com,
 163wangjack@gmail.com, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: Kuan-Jui Chiu <kchiu@axiado.com>
Subject: [PATCH v7 00/13] Add Axiado SoC AX3005 and EVB
Date: Thu, 10 Sep 2026 22:15:19 -0700
Message-Id: <20260911051532.2378501-1-kchiu@axiado.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672E:EE_|CO6PR18MB4484:EE_
X-MS-Office365-Filtering-Correlation-Id: ae2dd5fa-5170-4a72-c82b-08df0fc3b583
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|36860700016|82310400026|56012099006|18002099003|10067099003|13003099007;
X-Microsoft-Antispam-Message-Info: AyT7FgY/zoWc3TFC2k6MiJofvfvkfDEke37bheLt2oB6Npd1YLOz6qyubywAwZiSpVBYscynBnH5eezk0hHhhIR6xNfEzcASsng0H+Tu52Nb25zZeK1HDNjQ0DY5ZgEmhHgEtQSLQlX62a+3b5s0ffZk0xKnNDXLEJwG2h5PC7mUowLL8kt3LLHVlT+Hmk6HxqDo3Hl5x5AJCIy7DVCRd8GgXOyHDn2C8csLTPgzN5WKM/JnSy50oUFCNaAxsHWb9p5vq3pkKBoqnS4xR4v3aUYLZ9BE+KOCurkKB8+pHLiHTHXnwh1mmAkAqOfzorb0qNP9FfD6cdLm/NidP2xvknOF8uFjNnEOyGde5TQ+SDwcdXgCdijsFhxk4vFEXYAxW0mTS5GIC/fbnMPLtA3liLQCxw7sKyOV0DXWhL4zEwUb+96Ga9WxiL6CXfzCG5lRbjtv64tkvCIV/8tBKwOQdJpP6F46ufVj5lQAxjQTX+PAYujz1LHLfW1Dwu/ZVL/llq9ytzObktU4HwBMMHKQPp/nUwgtkzmo5rl0EquFNbot8pI60FktufB2kTklqjdkjvK3iEyBfQqlVcNZv/jKHqRGkR+NkluknA+KONDMriZks/feuyTcze/qsZwdyPvFxsTxpg7m8kh1wO45a81+kQ==
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(36860700016)(82310400026)(56012099006)(18002099003)(10067099003)(13003099007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: l6M6Y7FZjVQk4YUz6a61jjy2lGh/mZTwTBVRNdZ+TLU4ZWrsVDR4+886p1dweDhsbNRd8pnE/H2W/JP4EVmu8TGE+xEfyghAmEasa+OzoaDqvZtzZC8dyyjN3pPSC99p1OJNAK2Ix3nvtRT40Wg0jLl2Dk8NPbB+YeZ1GZuwaZiBDp5UXaMFuIEQ9lD4f7z0ZQ7QY1UvfAxvfawfHGnmnC1tUAaeDn9+DVlWrito7ikFQdWcC3WW2HfgUD9Sz65BwGWHIJANcCHv3CS8r1I3tmO7KGALwOYEYP/RaFVawYi2JSy2AxVnAFaipPK7jujlyAQKF1WmUUSgpx71rq7Dlb19VdqJnby19RMY548Zsa4k8s+3GjXQFJr24kMfvkSbDbYiYtjdOCpwtqGt9jmmbQC0R/b5A/MfOPQwfS/YzHFzKefojU7EH+On3Ejjbe/B
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 05:15:34.7363 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae2dd5fa-5170-4a72-c82b-08df0fc3b583
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A672E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR18MB4484
Received-SPF: pass client-ip=2a01:111:f403:c10d::3;
 envelope-from=kchiu@axiado.com;
 helo=SN4PR0501CU005.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Changes in v7:
  1. Add patch ("hw/arm/ax3000-soc: Revise variables accodring to QEMU idioms")
     to revise the name of the first member in struct and remove redundant
     typedef keyword
  2. Add Prasad Bolisetty into maintainer list
  3. Fix typo

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
     ("hw/arm/ax3000-boards: Remove redundant pointer from struct") to create
     SoC instance during init() and remove redundant pointer from struct
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

Kuan-Jui Chiu (13):
  hw/char/cadence_uart: Reduce the size of MMIO to 0x80
  hw/char/cadence_uart: Add BXRS register definition
  hw/arm/ax3000-soc: Enable BXRS support of CADENCE UART
  hw/arm: Rename ax3000-boards as axiado-boards
  hw/arm/ax3000: Specify SoC name in header and variable
  hw/arm/ax3000-boards: Add memory guard
  hw/arm/ax3000-boards: Add modify_dtb for discontiguous memory
  hw/arm/ax3000-boards: Remove redundant pointer from struct
  hw/arm/ax3000-soc: Revise variables accodring to QEMU idioms
  hw/arm: Add Axiado SoC AX3005
  hw/arm: Add Axiado Ax3005 EVB
  docs/system/arm: Document Axiado boards
  tests/functional/aarch64: Add functional test for Axiado EVKs

 MAINTAINERS                                   |   6 +
 docs/system/arm/axiado.rst                    | 128 ++++++++++
 docs/system/target-arm.rst                    |   1 +
 hw/arm/ax3000-boards.c                        |  71 +++++-
 hw/arm/ax3000-evk.c                           |   4 +-
 hw/arm/ax3000-soc.c                           |   5 +-
 hw/arm/ax3005-evk.c                           | 115 +++++++++
 hw/arm/ax3005-soc.c                           | 226 ++++++++++++++++++
 hw/arm/meson.build                            |   6 +-
 hw/char/cadence_uart.c                        |  17 +-
 include/hw/arm/ax3000-soc.h                   |  13 +-
 include/hw/arm/ax3005-soc.h                   | 102 ++++++++
 .../arm/{ax3000-boards.h => axiado-boards.h}  |  10 +-
 include/hw/char/cadence_uart.h                |   4 +-
 tests/functional/aarch64/meson.build          |   4 +
 tests/functional/aarch64/test_ax3005_evb.py   | 140 +++++++++++
 .../functional/aarch64/test_axiado_scm3003.py |  62 +++++
 17 files changed, 889 insertions(+), 25 deletions(-)
 create mode 100644 docs/system/arm/axiado.rst
 create mode 100644 hw/arm/ax3005-evk.c
 create mode 100644 hw/arm/ax3005-soc.c
 create mode 100644 include/hw/arm/ax3005-soc.h
 rename include/hw/arm/{ax3000-boards.h => axiado-boards.h} (71%)
 create mode 100755 tests/functional/aarch64/test_ax3005_evb.py
 create mode 100755 tests/functional/aarch64/test_axiado_scm3003.py

-- 
2.34.1


