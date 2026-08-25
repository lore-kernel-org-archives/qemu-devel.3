Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E96DFC61CE2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 02:12:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wygeJ-0004y3-DF; Mon, 24 Aug 2026 22:12:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1wygeH-0004pW-Cq; Mon, 24 Aug 2026 22:12:25 -0400
Received: from mail-centralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c111::5] helo=DM1PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1wygeF-0005qI-Jn; Mon, 24 Aug 2026 22:12:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wi1VRN9Ehtz+opl/6RBw/5LiTuNjDagPh2l8eX2m39FXiLq6Mlz0MqeuJR1sNZ91N/mRbljyVBILlMGHgGTc9xt1Id2+N4BXgZs7yt/USYfzoBspohVFMdV0YQr43gd80TJ6iRFofrdWgD7SeKzih/J005/THMK4zlF5RQ9BR2U3rJD6wWI34GG2pcR0/kbzmW36iwgKVHRrDQr2tv+nfSAlVolqGLkQU187c8L93U9w8b33OGqRr4rJBKzxCI0h8ui9XVeMn5UdTFJrkaPEjptrV45NLww9DFABRe0Np3x/lZHr3Q1oTUf3d7m3GV2siqKt84nlNK/MMCmu6PBDtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=16fg2PWeoL/9urNrfYbkPpteq8DL8s3DGn2ZmNHlgck=;
 b=DazXqHe9V3aZ/yAxgSWUsW7qBHGS2o1UoUJSKZEVGR8xuEMDOsnIwMlcSGsXHlBgfBNyxOHDFDAzsuFFemv1GTSbGeo2ziEAIdxKv6NmoLt20POsZE1m1w7+mYc+5JKrHfSu+f4PBb216ox5qwmzDL+2ZdZjPQtR9HhYf/UQKm/0yQRBZ4wjtHwvsILmwE580pTzskMhaCX0q8M0NcZji83kd2ShN5fpTsBB/8YM5kyWB0wI1OCL4vmjGppzWbxSPMUb4eTprobxwUh+TtkwErKOl/mA7aBVfLyZbupxmqODqvi27AVrYSFtr/yF4dp87L8tJTcW0DAqD3YB09BV9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=16fg2PWeoL/9urNrfYbkPpteq8DL8s3DGn2ZmNHlgck=;
 b=oFzK633ObkqZLxncI1w4ciOF+R40aEUeg4pxBN955HIk5cXvgOlSB4y48f83sGpl2TjMXVSSxXUhyJ0OLefnisyX5r0hPaOo2W3PuPmTLaE5ZjOBNSgK7vHuXeRCpruISmffeWwqleXqs2+VReC0IDr5/QzjoOqrGwBzqffzTqC9lt3EYrY8mMU5RIr3+zEfHWOMl36OvGQWj+YYfbpHCriV7Zm3tq+pJrCzriuBHLD9xaOB8ceIv0ySHmUwOiLCkykZDASELORyoqRZt3EjeZCNYWYjnBHvwgoYBTtw8pEWRZ7toE6w1oCY1gFefv2bGp0nOVPYlgGvd+LrzGf4iw==
Received: from SA1P222CA0175.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c4::21)
 by PH8PR18MB988357.namprd18.prod.outlook.com (2603:10b6:510:3a0::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 02:12:17 +0000
Received: from SA2PEPF00003AE5.namprd02.prod.outlook.com
 (2603:10b6:806:3c4:cafe::a3) by SA1P222CA0175.outlook.office365.com
 (2603:10b6:806:3c4::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.12 via Frontend Transport; Tue,
 25 Aug 2026 02:12:17 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 SA2PEPF00003AE5.mail.protection.outlook.com (10.167.248.5) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.3
 via Frontend Transport; Tue, 25 Aug 2026 02:12:17 +0000
Received: from axiado.com (unknown [10.4.1.181])
 by smtp.corp.axiado.com (Postfix) with ESMTP id 918D74186B51;
 Mon, 24 Aug 2026 19:12:16 -0700 (PDT)
From: Kuan-Jui Chiu <kchiu@axiado.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org, qemu-arm@nongnu.org,
 163wangjack@gmail.com
Cc: Kuan-Jui Chiu <kchiu@axiado.com>
Subject: [PATCH v3 0/5] Add Axiado SoC AX3005 and EVB
Date: Mon, 24 Aug 2026 19:11:50 -0700
Message-Id: <20260825021155.2475879-1-kchiu@axiado.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE5:EE_|PH8PR18MB988357:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 020f8642-d038-4329-af48-08df024e4979
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|23010399003|82310400026|13003099007|10067099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: VGIH1S19LcAPle9IvVhpamVDQoR2aSHOG1CjOvZEpVeumV1oAUroLTCNsuZdgwTgC7WHM6up/igVhUuSWxSPZj/N2LKs2fQv0ZNY+lI9VqcRkEAJt7Tey+09F86qtsluN99LtA2rpbJLkUkGDB/a+p4QrAttkgMeQ5iS3DmeY77zEDXDBu9NIcEsAUaRe6JizYJTJYqlIqQEIM3HFI6lG3YqWc55USuvremUfXNnLSLgrbkA732Q87Eiw5VLrviRp7Ia7KdvrbhXrFxriFqiGa3SvN7HJ+b7WhdJZnrTgeVbANKi/Nch9vrKui0uNGbuACZTJIztWXBf875Z9n7Um0vBt4yXYnkmUSSzOAHcHPlAn8ohRWjfd/ht+lKFVLyVjEUCPmy8OgRsGUBW0R6+BY793UioAJPnngttmVJ/TxYtkTLKyIal5mXz8sBaSXC3BODq5b0vH2yw48KzXuh6wje1t9EsdtMdnlTPnK+KB6kkrKCqt3N1sfdy1u0mpS7ZpzkMDcKXU+55fKRWFvmV/1y2qDv3cYZJIZAERXYJsn3oUY2bdiSr5krSqGdt2credHIojuypFpGTvVzRYZoltKv6YeSEH+b2fOYkIdS36S33K9I5BcT6I90q4J9xeyGB5RNqLEbtW/VH9VMPMG8+og==
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(23010399003)(82310400026)(13003099007)(10067099003)(56012099006)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: omQzDIMw1qX1nIfd3eLECSaBsxtc+M4hiZdyjZvLQpWEwy60Mhi3wJKoicAIB8TsE3XzidUYdwEYKa12viImZPZhfWiJEaTkwtDI3YjrASl/bc4XeC+e9QaXro146XFaQAj5+KUUk7BHA8S0lQS1XlPrR5lTb/cvNoCCsavE8fZmq2boeXOUIajpDcWd2CELpkDkx/XEGPwBP8Kw5Xs26nEZghyfAPWqwovXKEFVSJC8QVB18DVwZA6Ifv6Ktwr45tx2YK3KnZ49qaXyylRk4i/xub5SYc9oD+nozz3hH1iN+5ZPZfngZCMQkPomIghC2T29R3VDrUDY4MKdkSQOp3aWNP/5n+C0ZOjNIwC6TjBQ2HrRFQLbxL39sv8QGnyNOjp4K7AER491vwO3/crZ0YzWUJyGL16hyJrlnb1+fdMAWXz2giwAQTpsmEOKmwAd
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 02:12:17.2067 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 020f8642-d038-4329-af48-08df024e4979
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR18MB988357
Received-SPF: pass client-ip=2a01:111:f403:c111::5;
 envelope-from=kchiu@axiado.com;
 helo=DM1PR04CU001.outbound.protection.outlook.com
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

Changes in v3:
  1. Remove patch "hw/arm/ax3000-soc: Add missing class_size to TypeInfo" 
     because it was fixed by commit 4f50d637e2
     ("hw/arm/ax3000-soc: fix heap overflow from missing class_size")

Changes in v2:
  1. Add patch "hw/arm/ax3000-soc: Add missing class_size to TypeInfo" 
     to fix incorrect class size
  2. Add missing class_size "Ax3005SoCClass" to ax3005_soc_types

Kuan-Jui Chiu (5):
  hw/sd/axiado_sdhci: Add header guard
  hw/arm: Rename ax3000-boards as axiado-boards
  hw/arm/ax3000: Specify SoC name in header and variable
  hw/arm: Add Axiado SoC AX3005
  hw/arm: Add Axiado Ax3005 EVB

 MAINTAINERS                                   |   2 +
 hw/arm/ax3000-boards.c                        |   4 +-
 hw/arm/ax3000-evk.c                           |   4 +-
 hw/arm/ax3000-soc.c                           |   4 +-
 hw/arm/ax3005-evk.c                           |  55 +++++
 hw/arm/ax3005-soc.c                           | 225 ++++++++++++++++++
 hw/arm/meson.build                            |   6 +-
 include/hw/arm/ax3005-soc.h                   | 102 ++++++++
 .../arm/{ax3000-boards.h => axiado-boards.h}  |  10 +
 include/hw/sd/axiado_sdhci.h                  |   5 +
 10 files changed, 409 insertions(+), 8 deletions(-)
 create mode 100644 hw/arm/ax3005-evk.c
 create mode 100644 hw/arm/ax3005-soc.c
 create mode 100644 include/hw/arm/ax3005-soc.h
 rename include/hw/arm/{ax3000-boards.h => axiado-boards.h} (69%)

-- 
2.34.1


