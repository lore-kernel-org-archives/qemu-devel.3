Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C0F606A324
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 07:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=axiado.com header.i=@axiado.com header.a=rsa-sha256 header.s=selector1 header.b=wogNdHJ2
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTwMh-0003QW-51; Thu, 19 Nov 2026 02:15:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1xTwLX-00030T-AA; Thu, 19 Nov 2026 02:14:16 -0500
Received: from mail-westus2azlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c005::5] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1xTwLO-0004Ju-PJ; Thu, 19 Nov 2026 02:14:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MJV93IYaF9cJjkb33Ma2AMRaW6Swq56qzC3q3eBTenGK/Ci0XcQPaD3KnwvT6qnrT0Gx9460K+CuG7ZpGK1chmQPqgdFrXEyRdr+nz3Q4/ZZisyzBL0LTXWFO1pD437lCMmMXeGiZ+hVxJGhXQ+x1JHy2eLHdYrd1M+ISPz01ODv1JyiisqCV0sPF7UWPz3sF1gIsb6YC/JuBTomgLhi5mmM7fynL0O7OwtPbv3mva+JQVKXEWXlSFDfk83A0z4VJSpzvGEDW3qvSfvb3v5zXIV6TWM+OVU7ueFXZgo8aCNteR7hbdap5xRWXh0qbICZFRPPF90JDi2rv4W1DmrIPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nq/88YTCbkivSnTAqJ0IxbtgmzWJC7IOqznPodtde7o=;
 b=EBMOtBVHByc1W2E+DvCFbX5LkSKaHcI022Pgd8GseXBPLiuvnG6F8DsD03ZxpnTWE7gQtt45R9e0sMd2McjL0o1/pSxC/Fubv5bko/jsHVSjVRTRNgLplcQP31Cmch71BlAScBK8OR2iQdl/0g2xZjYNNriu0gA1BdbWzI1zqX+O+R4LfaSk+78M6Mal5xYys8b2bWNEh6K8S+ki5W+6WyGYRqcQvVnRvfQtnAZojy0KHeXQ7oy9TNrpiOa5SNPq6iefZNXMaczrF/sZHb1vEK3f6RK/eSVc+KReNBlD7xE++rtsN/8ZYVdjgZhzeyBmYegHC2US2mBtuSfhOQx9jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nq/88YTCbkivSnTAqJ0IxbtgmzWJC7IOqznPodtde7o=;
 b=wogNdHJ2mvU78fNSzwtcAuRE/0KgRJYWt7KLCe8fobo/cdZlxjl33WNuyEd0Oh6Xe2nyGWhDikuo2OgSPMSR8c5BHKAwQh3bAtjb8pegn0virK5RTY8T1nxgSfTQuiP6BiNp70Lq6cGt9zcB1/mUQYFKHvnbPu6sS7oC63NqzIMYiWg70/9HMIQUOCEq5+lZZIVSceqEvJAB4dQ39N3rxoN+nyFuRvMDI3D0/q+H298po7iVHR3agZA4/FuzDMyq4vT8OYoYPM/F0FU1be347MBDsJDcxmoERypHbWZ35VX/cPwGHK9hilVMmHG6Sb+Nskk/EO0YAvxs8ZvMfY9Qjg==
Received: from CY5PR13CA0117.namprd13.prod.outlook.com (2603:10b6:930:9::37)
 by IA0PPF74AF55D88.namprd18.prod.outlook.com (2603:10b6:20f:fc04::c24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 07:14:01 +0000
Received: from CY8PEPF0000005B.namprd21.prod.outlook.com
 (2603:10b6:930:9:cafe::50) by CY5PR13CA0117.outlook.office365.com
 (2603:10b6:930:9::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.12 via Frontend Transport; Thu,
 19 Nov 2026 07:14:01 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 CY8PEPF0000005B.mail.protection.outlook.com (10.167.247.25) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.0
 via Frontend Transport; Thu, 19 Nov 2026 07:14:00 +0000
Received: from axiado.com (unknown [10.4.1.181])
 by smtp.corp.axiado.com (Postfix) with ESMTP id CA1F84186B53;
 Wed, 18 Nov 2026 23:13:58 -0800 (PST)
From: Kuan-Jui Chiu <kchiu@axiado.com>
To: 
Cc: Kuan-Jui Chiu <kchiu@axiado.com>, mark.caveayland@nutanix.com,
 philmd@oss.qualcomm.com, 163wangjack@gmail.com, peter.maydell@linaro.org,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
Subject: [PATCH v8 00/13] Add Axiado SoC AX3005 and EVB
Date: Wed, 18 Nov 2026 23:13:40 -0800
Message-Id: <20261119071355.3520249-1-kchiu@axiado.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PEPF0000005B:EE_|IA0PPF74AF55D88:EE_
X-MS-Office365-Filtering-Correlation-Id: 84d5f055-7ee0-40c0-3860-08df460caf6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|82310400026|36860700016|376014|18002099003|261009223027099003|13003099007|56012099006|261022075727099003|261102123227099003|10067099003|261022115727099003|261022105027099003|261021121427099003|261026121527099003|261028144727099003|261026140227099003|261021123027099003;
X-Microsoft-Antispam-Message-Info: 0X0kb2kx3akWv1Zf31QhDLK0ufMj8mmRrchRIf/3l8iV9a8UTlUXEcDpzUWaJ8zqDh3u7yvxZzyewJws3vHgH83WITpSGrLTONlT1no4ClvQeouCJXXeU8+dx+dSflrkg2/PVJvG0PymxdxZ7MbTdu/nNo+feXgbvtLqfPXyGn9jyHGSvivAsp1KbtcC3XbZH/JMCqhqEeHVX9XlxD0RyCImgoBXuGKr8vP+Bwi2LCV5axvSf9p0ENHGiOFmOURGXhja3kel+RbNxvgSMVm7M5bPHXs5KenXhf7vxdUNKDhBnXZ2RIQ9aKq42OkRZ6K17OQOI8kOHbY2ktL0SliCJ1qdWEesEU45J0R13u4kX80Hpb/gcVOY4TDcYFxhIRnRd9PBJzSJvlCnWFmL4CiJ9mX3SkWUCV6oNieUxnBxHnvkP5zfNjxRDdQlNz4df+TiszjfJWN8GfSL/gW+LwKk+qxUWj0AxratfdLv4rs53jSByeuhFEpWzqVEAtfZeTfRE+ca1XgZfw2rSntHWXGzA8JGqywZvRobT+S+e5wWf9lVJXmD1E0FsgLwDJLJhVDvqL7jZTbYvFiBDWPNxImd3hn4K8lmeC/l9JD17RNAe7do8tuWKU43GEgTYXsgSSmKo/RbygHuall0mhSURt0AXw==
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(82310400026)(36860700016)(376014)(18002099003)(261009223027099003)(13003099007)(56012099006)(261022075727099003)(261102123227099003)(10067099003)(261022115727099003)(261022105027099003)(261021121427099003)(261026121527099003)(261028144727099003)(261026140227099003)(261021123027099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: rhhJBIHFjVJXuu/K/H1MA4liGDi4bVdxZqg11WZtEQzpQ1taMH9yVEU+IDDRwK3i27d0OYYU4s0uATlXQHeA6vdMg0TOxAP8072PZZn5TNvKAqKoL8tG2YibZx4qXt2vMBxoTp2mJh0SUrnxdEKpcEShLI/EOOPmQXtntB6OtBznmB4ZgqJ2ameEbsOlDgkWOfsk2eQosaybYRZzYcF4c0Wa5DkUjnAm4BebsidG+a+wKI5SHBdIk8ODExKWHNESnWw0ZIBl6owXQgbEUtICdBVx+oLxD2HLWL/i9XRHeP2UuOr8Xr2CC+fMQwXrhY/z/BKQ2x+2IOxpm8zRGyBREbUvzAIWFQzi6afiLQVUF91TdHcMfirFEFuIGir68RDBSoiZP8gyQj3wbzSIa8hwaYS+gEKNcjgRpxLID+5gq4xnqAaD2icXOMdOYZFU62pv
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 07:14:00.4748 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84d5f055-7ee0-40c0-3860-08df460caf6d
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: CY8PEPF0000005B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF74AF55D88
Received-SPF: pass client-ip=2a01:111:f403:c005::5;
 envelope-from=kchiu@axiado.com;
 helo=CO1PR03CU002.outbound.protection.outlook.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
Ok:                369
Fail:              0
Skipped:           22

make check-functional
Ok:                31
Fail:              0
Skipped:           6

Changes in v8:
  1. Fix C0103 invalid-name error during check-functional test
  2. Correct the file path of functional test in MAINTAINERS

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


