Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8653DC61DD6
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 10:22:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1i6R-0000RE-Cj; Wed, 02 Sep 2026 06:21:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1x1i6M-0000QB-Hk; Wed, 02 Sep 2026 06:21:55 -0400
Received: from mail-eastusazlp17011000f.outbound.protection.outlook.com
 ([2a01:111:f403:c100::f] helo=BL2PR02CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1x1i6K-0006ZF-A4; Wed, 02 Sep 2026 06:21:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dl2J02aD1H5IX2GM2GRBMO/uKYynJwOVKgFwikqh0XWCN2uGtuu9Oe3HGrPUeDesc68tCe6LsR25V5Fe+EjNJPnA/6YC04rPr1O3Sar2XC1y04/orHwS0Gil70EQVS/yc9qePKql/bwOSKaWRS8hlwfr8y6M9A9/okOcdyOTQkNnX+nwq3RLfzNtx7dVyVjiuWwQi05bcHOYyKhkcodMvYD7tubF6Sp6pMPpij4ZJQX1SeHXM4AT8VDYWfN4CKKcAAfAP9X75pgAkn82IW2zqJm7VjasafsqbgbTIy/xWV8jHC1yiKqTqYN4VZb7I+0ndkT8Yjz3/X00HTWZn0fy4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i6F8XgcNuMCMH1jtrJEppo3WJqnjtGHQ9IZcckd1dj0=;
 b=d24IO8OskWX9N5xH+ze7WyD8IP1MzrMeJqEGIIenP5FhVAzfN3xWmtjweG4Vf97/sfX9VGnlLwhOH0Wb/d88SaA4aUg/YEZVvC1qpsusqPrmGhjrtyNkbNY2uDh2jBIqo2jWXdqZ4A+2z4Tpo6G+hMGe0Uu5GaxygsJR14RMbH4N60EcIfbNqA7JVWokbYyOOTMD0l7HlEmXSU82kN24Ikj6aXdNARQmtD3DpchF01TSJuZjh7T6Ig9syHW6NG7lVCTNo32CBcSq7AS5q+I2l94b35+/FPP9X14n3cMvuCGQjfXQj4SwU7yIEJI11U8RF6tMS/d/DcY+Dfbsx8TcQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i6F8XgcNuMCMH1jtrJEppo3WJqnjtGHQ9IZcckd1dj0=;
 b=VMyxXTLX/UA966x2MugNrdw1XXRbPOYcB+zMnXfa6e/49xauEhhxZY3fNRb/HhxKnHnBXEsWkeFB8qS/hgTpcq5ymEr4DT2eOiGD6NX8XaApDSXAIABg+Q7/2908h3C1aenjiKNAWbvvf3WDsGXjbSQEpdQNQOdqkjjj1cZ7ZlFDDDuxSjIE8m3rfgny2xgpWVE7v/TCBgs470aFyBDuzQVy6MDXGVgTyZlV8B7D61dvMu9ueADKvFlRtJw3AoaYoZ/XsdSKsnNFgxzxOiM8kj38udVIAzMG7xPlgCQZwef9+OaYhV6O5L1P7oTcw37sBrhmMLkIjSYDZ434y0RJ1Q==
Received: from BY1P220CA0007.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::13)
 by DS4PPF4C1E661CE.namprd18.prod.outlook.com (2603:10b6:f:fc00::a97)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 10:21:45 +0000
Received: from MWH0EPF000A672E.namprd04.prod.outlook.com
 (2603:10b6:a03:59d:cafe::88) by BY1P220CA0007.outlook.office365.com
 (2603:10b6:a03:59d::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Wed, 2
 Sep 2026 10:21:44 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 MWH0EPF000A672E.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.8
 via Frontend Transport; Wed, 2 Sep 2026 10:21:44 +0000
Received: from axiado.com (unknown [10.4.1.181])
 by smtp.corp.axiado.com (Postfix) with ESMTP id EBB6A4186B53;
 Wed,  2 Sep 2026 03:21:43 -0700 (PDT)
From: Kuan-Jui Chiu <kchiu@axiado.com>
To: philmd@oss.qualcomm.com, 163wangjack@gmail.com, qemu-devel@nongnu.org,
 peter.maydell@linaro.org, qemu-arm@nongnu.org
Cc: Kuan-Jui Chiu <kchiu@axiado.com>
Subject: [PATCH v5 00/13] Add Axiado SoC AX3005 and EVB
Date: Wed,  2 Sep 2026 03:21:32 -0700
Message-Id: <20260902102134.3039174-1-kchiu@axiado.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672E:EE_|DS4PPF4C1E661CE:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a04b3ef-c0ef-46ec-457b-08df08dbfd02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|1800799024|376014|13003099007|56012099006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: GtzrvgM6YKPRSanxnDCBwbvxStkBkxEBI34zr0FNy7MSwQb7wIa2VDWpAq8u7Kq2o3GCSEvL0aXVEdsJI9M9dlnUO/TKkYghUPTG39fJ7709v7kq4l7sCKuDMmsfCCgRu7speoww6kWRhSvXLTzir9Dt10bfOSyyo6LKmPVdHLLY9Q6hYYY3HO/BhPpZNiGN7QUzVajj/uaYVzoyNLtDeEXcFH+Uo6GtjAltcSGZ5E07YCv5TP8dXpXStBPsL+YLJrbV44l7hLzbFbKAid3chizzD6ui4ZlJapmhrNoXAg9SK0XmU/5+W0kVKpvCeC9PWilxFsZ1QT/VHm4CYGslHSWIrD4EZRbxLw+iNDCB2SOli51fiNfl5d1tROAln1jrcD9oje/7WOZZGT11KcGA5hi1N/XqTi6fRCmeM2wlSha4FHkPZON4r0vaQzDnckDK6TpqWaMUPMdpRNSiembnCUKgowqfEoKF2wZrSLLN4KgkVcLfLzAgiePO8mjBmvwKv5diEMQ7WelpAOSip0eaPE2tk9F1wFHhi3T0umCfPHRk179i+y7+7knIlhlPIj1d+/rQ6BVEkC89rPGhZnk2bpn6whBCl89DBb8ors4FhMIdcPvtbHLs643AtOuGo7n6nq+nrHcuTgIXI7tjUTUoYnf3tun2Ui2fEGLpD6AGiLs=
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(1800799024)(376014)(13003099007)(56012099006)(10067099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5m0Lf2vny0n2YuU94VKTt2VhJ5oeAC5iynDm4IzCcMn96WgJ+LQBeZEfu8gZ5GQIndzT+TNDgMiOrQNuOhGiBjCor84eIY2WGfouhoX0MAGZeNQz0uXTyXEb8ZtCooYAS1XSYjUh0oUTKYCOnMRD0q4BBpdIJ4OA76ia+1aie+JgL9X7e+fh+E7g0cRNBm6KQlXMxyjEKV4EFukBBEmQTx/5muc3djCIg/tbcfX29MYg+oPuue0HqEDfnkiWrhd9cTANtKU0qNItPS3HqckaYrXogbDAIzM87UeWZlGMjL159yWotbehHIcSRiUqzLPDEHMiwjCeOINI6BngvcSYW+OuCehXvd1Qv02JkiZ4JxY52DCYu+pwnsrqXfbTkBU3tiWoMCvWPf/Ks4KulxTVwcIo1rqL+WIXFjJSW/m9LWR/6ysHP2F6qhbTT/C5L2zM
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 10:21:44.4659 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a04b3ef-c0ef-46ec-457b-08df08dbfd02
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A672E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF4C1E661CE
Received-SPF: pass client-ip=2a01:111:f403:c100::f;
 envelope-from=kchiu@axiado.com;
 helo=BL2PR02CU003.outbound.protection.outlook.com
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
Ok:                331
Fail:              0
Skipped:           17

make check-functional
Ok:                30
Fail:              0
Skipped:           7

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

Kuan-Jui Chiu (13):
  hw/char/cadence_uart: Reduce the size of MMIO to 0x80
  hw/char/cadence_uart: Add BXRS register definition
  hw/arm/ax3000-soc: Enable BXRS support of CADENCE UART
  hw/sd/axiado_sdhci: Add header guard
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
 hw/arm/ax3005-evk.c                           | 117 +++++++++
 hw/arm/ax3005-soc.c                           | 226 ++++++++++++++++++
 hw/arm/meson.build                            |   6 +-
 hw/char/cadence_uart.c                        |  17 +-
 include/hw/arm/ax3000-soc.h                   |   1 +
 include/hw/arm/ax3005-soc.h                   | 102 ++++++++
 .../arm/{ax3000-boards.h => axiado-boards.h}  |  10 +-
 include/hw/char/cadence_uart.h                |   4 +-
 include/hw/sd/axiado_sdhci.h                  |   5 +
 tests/functional/aarch64/meson.build          |   4 +
 tests/functional/aarch64/test_ax3005_evb.py   | 140 +++++++++++
 .../functional/aarch64/test_axiado_scm3003.py |  62 +++++
 18 files changed, 889 insertions(+), 19 deletions(-)
 create mode 100644 docs/system/arm/axiado.rst
 create mode 100644 hw/arm/ax3005-evk.c
 create mode 100644 hw/arm/ax3005-soc.c
 create mode 100644 include/hw/arm/ax3005-soc.h
 rename include/hw/arm/{ax3000-boards.h => axiado-boards.h} (71%)
 create mode 100755 tests/functional/aarch64/test_ax3005_evb.py
 create mode 100755 tests/functional/aarch64/test_axiado_scm3003.py

-- 
2.34.1


