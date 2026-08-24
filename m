Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AAA2C5DF97
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 03:07:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyL0L-0006bm-0t; Sun, 23 Aug 2026 23:05:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wyL0J-0006ar-1x
 for qemu-devel@nongnu.org; Sun, 23 Aug 2026 23:05:43 -0400
Received: from mail-eastusazlp17011000f.outbound.protection.outlook.com
 ([2a01:111:f403:c100::f] helo=BL2PR02CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wyL0F-0003zX-PN
 for qemu-devel@nongnu.org; Sun, 23 Aug 2026 23:05:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q5s14/15I2G8daZqOO/Trbt8c73gGwhocKjjtKAAezR6Qv8z6N5k31m+JBM4Q1L4SCd9TFaGU5nX0WWCYn1QHyFMoxXx+PpfBOF7hpdMsRpcPRYexSL+tNI04ljkNw1KvjiJ5bQpkPI894QHqlPao1M9QVludXgH0OS7CJrVUOkRBBSPNma/ala2XQJpUeriTbeHbUeGms7HBbARrhWWuuf0Xb8E+DnNB6pG8vkzK2v5mstvwWGnFe/s1KsXEyg27F/pjBZa2vCRZ39m6WiWMEMrgfpKDA02XUCMyPzKBYEawQbCz5NlaPL9Maod7QfuqqRauS4NFsjrUS4KcLDsqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OtazpKQZatAodbV+nIhMMb/FfQcr1jDX0HIcRHcFM8E=;
 b=sVylVWIbTICbWYQn9ptzCoELKDa5+DDLvkiZlfM9o2MHpoHv2LABgjSX2YJRxC6ofNsaWwjuo7YBQ0P7vshFH2VqXpaSv4yjS6YtLwLNA7CPT8ze00SvIs0qSW/iLEAhEa+mTTsX6Ofbti7OenMeSlfP/QLMnBkej99sznNIva5/OnjtpmwIRbrOCCJdgUIQbXRCeMiazLePmG9XiKCPVuuIl2UVErkdq7PVwIGQxNuw/ob2mIJKn+NxpPMWvVj7IrWGLa+mmrwiXhzVHRl0IqYoAfZPLG8kB5KLF7ZDDquH793GWqy08TopIKURgOmKPtGlnEd9/Tfx8EL1lfXefA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OtazpKQZatAodbV+nIhMMb/FfQcr1jDX0HIcRHcFM8E=;
 b=lj+HG3R1ctumOx6/PogU4a7OfKs1ArI74Go7KLsJDBmcP61K26wPImdoGZZmbznavctLUrelxnLRdTqPSwVmTOy2ekUVNjwQ8lui4F4HFsz26jYzn62ZGytANytGo8m5TMU3b4EW/E8wP/XmUFRi0saQjiBGQpZggXBBOKLQ7YJ3Szmn1FQupFOPj5I/KzXLZDWfZrICjEHG4zsNalJ4B1L7nMkgPqDFzPQZFK93xdcYtxfq/ml1+7uK8a2rYcNFoAS5KthKp99Hhc9R1CQy5x+0mPl/n/ffdloQy7EAxhc/KigtNHcAmYDJ2x2yep7kLpkQCdQSlV71RimhrfOaZw==
Received: from DS1PR02CA0011.namprd02.prod.outlook.com (2603:10b6:8:452::19)
 by DS4PPF7D4D8EFA4.namprd18.prod.outlook.com (2603:10b6:f:fc00::aa8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 03:05:35 +0000
Received: from CY4PEPF0000FCBE.namprd03.prod.outlook.com
 (2603:10b6:8:452:cafe::9e) by DS1PR02CA0011.outlook.office365.com
 (2603:10b6:8:452::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.12 via Frontend Transport; Mon,
 24 Aug 2026 03:05:35 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 CY4PEPF0000FCBE.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.3
 via Frontend Transport; Mon, 24 Aug 2026 03:05:35 +0000
Received: from axiado.com (unknown [10.4.1.181])
 by smtp.corp.axiado.com (Postfix) with ESMTP id 7F0B14186B53;
 Sun, 23 Aug 2026 20:05:34 -0700 (PDT)
From: Kuan-Jui Chiu <kchiu@axiado.com>
To: 163wangjack@gmail.com,
	qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Cc: Kuan-Jui Chiu <kchiu@axiado.com>
Subject: [PATCH v2 0/6] Add Axiado SoC AX3005 and EVB
Date: Sun, 23 Aug 2026 20:04:59 -0700
Message-Id: <20260824030505.1969726-1-kchiu@axiado.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBE:EE_|DS4PPF7D4D8EFA4:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: cb9ccbee-8100-4d26-8f08-08df018c9115
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|36860700016|82310400026|376014|13003099007|18002099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: S50y33AlMJUIroAnKlW2n4A2nHZQFHgXOEkTUQnxhdglJkxf0aIq8k56dC2jZ9NHok5JiD+H6NCslGRzTbcQDMiceTBHmETXjFYpqrmjxAx5hLv2TfGa/qBiHOjuJ91NvEZjF1tAD6XIUFZLFyAnxNd5/cdHgLVgQ9RvhvwDycf3gn1GlLAV7EQ/9uIE/O9V9TXlGncy2JXt09Szg3GV3Z4UxuH1qnW5MV8D9cafE76HM49Ps6x3zB9baaWYOm2zOmSs1mEiD815ijVubBX26IdCHcTWRYb4EyFs3fTcRFoVbwrAvVNBP6xqU8fbTHMnFwHVTv459PIbraxU6rAs6pdjqTU61X6dBMtABhHqYnUiI/yhR/n4jzyasF3WcwL5hTvnxghfzIst9Hw4jTfNukD6TZZHFud5aphGr4kLPQqBAtvyZ3uRdA7aBpZZbgKMsVa3QCuRl0L16ci0prvatnjMvy95gUMO5brBr+6yKgurSAk2f9LjPUl2HanHMIX5l2+BShbD2cNbAlHYtINyk9WrI6yJwdJRlaRur4wp6/Lv7Sy33vtQhmgQs8D9D3MwaUA55+ZJZGCnQ02j+jjv3rFIjgC7Pp2YFJpjZ1RdABo+Rbu3UX5c8vBFzg1Bh5QyX2/ngeg5+Q3mC/XkFESJlQ==
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(36860700016)(82310400026)(376014)(13003099007)(18002099003)(10067099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: SFYcrjeLh/TbuuwJ+n2eDMGt9QC23G4cdaoarJmFgv1jAQASErJyKB1wdkF944e6wRAa1xGHovCAUvbt8vGVNy1Tg4mxspJgc8zAVjvoVZI4Frp40jbbJ8sZv6FGfYcoGJx/VsKgJ29F7rf5fmurOmozT5PxbeBje4pd1zBLAp52WDo5PFSLgKegHBwr7vcvb1fWI+wIQNchONUGoA/S8+cctUqIFLFzhl+heOKmEx7O4pPwiwetXIx++tKstM8F0iT/mbhmM74fT6OYh/XkKEVrrbgEVyIJ5xEVLJA8lEYu3tvm/kCsoydvgAuk2/DfwKk7aC6eCRL8rI74Oo+CGLElCPqy/7mU8vF9kIUpw6H1wI5rZqZd7T2nJ4DfUMVyzJebJkBv8phUrj952GzxEQmqGrBsDC1cuv1bVHtSUH1pn1sZ2n0I4JCH+TlnRslH
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 03:05:35.0122 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb9ccbee-8100-4d26-8f08-08df018c9115
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCBE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF7D4D8EFA4
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

Changes in v2
  1. Add patch "hw/arm/ax3000-soc: Add missing class_size to TypeInfo" 
     to fix incorrect class size
  2. Add missing class_size "Ax3005SoCClass" to ax3005_soc_types

Kuan-Jui Chiu (6):
  hw/sd/axiado_sdhci: Add header guard
  hw/arm: Rename ax3000-boards as axiado-boards
  hw/arm/ax3000-soc: Add missing class_size to TypeInfo
  hw/arm/ax3000: Specify SoC name in header and variable
  hw/arm: Add Axiado SoC AX3005
  hw/arm: Add Axiado Ax3005 EVB

 MAINTAINERS                                   |   2 +
 hw/arm/ax3000-boards.c                        |   4 +-
 hw/arm/ax3000-evk.c                           |   4 +-
 hw/arm/ax3000-soc.c                           |   5 +-
 hw/arm/ax3005-evk.c                           |  55 +++++
 hw/arm/ax3005-soc.c                           | 225 ++++++++++++++++++
 hw/arm/meson.build                            |   6 +-
 include/hw/arm/ax3005-soc.h                   | 102 ++++++++
 .../arm/{ax3000-boards.h => axiado-boards.h}  |  10 +
 include/hw/sd/axiado_sdhci.h                  |   5 +
 10 files changed, 410 insertions(+), 8 deletions(-)
 create mode 100644 hw/arm/ax3005-evk.c
 create mode 100644 hw/arm/ax3005-soc.c
 create mode 100644 include/hw/arm/ax3005-soc.h
 rename include/hw/arm/{ax3000-boards.h => axiado-boards.h} (69%)

-- 
2.34.1


