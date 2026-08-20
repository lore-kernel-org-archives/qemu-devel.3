Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5997C5DF88
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 10:27:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwzzM-0004Hh-Ez; Thu, 20 Aug 2026 06:27:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wwzzK-0004HZ-Bi
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 06:27:10 -0400
Received: from mail-westusazlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c001::2] helo=SJ2PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wwzzI-00037V-F3
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 06:27:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t9KCiLjV2CL12DDuaGlfc5yQ5jUlLODAIgBigNk/EAl+fxBCef1E/T2biiQ2R4saouYmnIC9kKyZpdt4ayThvj69WMEAo1LTRCbWuju4ZYnyGU3fWwESDJqJTHq16qMc61Ue7RaKju0X6VSFWbVBQVhRWC5VZXIJLa4UCm1Vnm+obAq2vQzAw4l9Gk/XmZ8cyg4aDVYVBsRfpNsAJMcNsQhlNdXweVdUsRFtkox2TL8sOwj8rsELYfy2H0g5iwScBqaB+TOLwReYqe6g8uwO2o07taKqnwiFyOlXYL9DAXIZlp0bbkKkhJc9DL1NSzMvkibR1sm1cWc56GKndpAWGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R/O+h2vDLK5uMkzgSzh4KstCtxj3c6aXxdHRv98WwFo=;
 b=xYNAnuA3F1AXeLUwO9LjCw2cW4ilTLXiTzbmQnsX94e/kSto04+MyY8XqWJ433wisyaXv/VH4sVMBL2FfsTakOaj84nhBq5vefs9Vt02TfWCIimyj1u0SQ7kN7d+x6vxrbt6jD3X6CF895Ua2PjK8H2Ky95KMxrx5nsllFDySujttaSslxT5m1srx0UM+MXGnq+wkTbgg6hHU9UInHskrJodYQENsGBuf0YyskOuIJG1TtEH7uYR7kaLLq0KhsHlYuGaiEbwIr8iH1nvCW4RsH1BY/w/ZqGPmskKMKJnUG5+6W6kK30llOBOJI8beE77jaKhUFhr6t4uRu+BGXPRpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R/O+h2vDLK5uMkzgSzh4KstCtxj3c6aXxdHRv98WwFo=;
 b=K56+Fq9vQXeF0g6ekE3LTt/D3rROs8H2aSARC97POTzOOYkjBwikgDMBt4ZfUhavBzZeaEgqFyJmQSKjtGNpalR84AwW5aO3uHNJg5jJqOaqO6f/eYZ9+y0TGlJykrx8yohYU3Gax88CX0lwmwBkG+1/7PfGK3a8gm+Z1x3cij9/l2F/ahfhhCPgt8OtsUMXID+uFFZiqObJwjNhpivwSH0kK211XbURhEU4gVaHO4BBUJdH8c8DT8CI4s7zagzmrmTWVw69sB3XibhcK5kV5kRarxpb+XR+9VE1oWIAOuyGJr9+gRUGOT7QVLaHChZonL6dlI5E4wy3I3hAjsKaZA==
Received: from SJ0PR03CA0152.namprd03.prod.outlook.com (2603:10b6:a03:338::7)
 by DM3PPF65F9F888E.namprd18.prod.outlook.com (2603:10b6:f:fc00::6a8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Thu, 20 Aug
 2026 10:27:01 +0000
Received: from SJ1PEPF00002319.namprd03.prod.outlook.com
 (2603:10b6:a03:338:cafe::82) by SJ0PR03CA0152.outlook.office365.com
 (2603:10b6:a03:338::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Thu, 20
 Aug 2026 10:27:00 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 SJ1PEPF00002319.mail.protection.outlook.com (10.167.242.229) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.3
 via Frontend Transport; Thu, 20 Aug 2026 10:27:00 +0000
Received: from axiado.com (unknown [10.4.1.181])
 by smtp.corp.axiado.com (Postfix) with ESMTP id C72794186B51;
 Thu, 20 Aug 2026 03:26:59 -0700 (PDT)
From: Kuan-Jui Chiu <kchiu@axiado.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Cc: Kuan-Jui Chiu <kchiu@axiado.com>
Subject: [PATCH v1 0/5] Add Axiado SoC AX3005 and EVB
Date: Thu, 20 Aug 2026 03:21:27 -0700
Message-Id: <20260820102132.361642-1-kchiu@axiado.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002319:EE_|DM3PPF65F9F888E:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 76d9ed3f-220e-46fc-64e2-08defea59200
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|18002099003|56012099006|13003099007|10067099003;
X-Microsoft-Antispam-Message-Info: /jNgSlvQhXSAlgIxIPVbLibXdaPWncLg2VjIBpF/nPXQInqV8ARg4M7O8xhnqyntFkDCsIyPPC2yhXnzBKlBfI9e72YV0DwQzV4UMeELSl1D536OCM/s2TFMHDX4p5WmXEjdRcbL26mxEGGvVgSb1ZM7DTBTyRAQYvFTzMCjDQLuC2hu/n1HPp5i1cLziD0+opWHsyJtXLmfLz5h9nxxvcA7ybmBU359EyxO+fEfHdwJWvI7BKHUd/FXAjMBE/uoLEwBgEe13Ld7SI+C+6Nf26gDG6jySyV28TnM0elwHSgYmqVjcElSm3vzPT1nNUkxXW1b0N8SydwI4g9Zia5phbk7p0RDNhWC5efoaIL2KpY6/kbjrN1k3fbSZxLcIeV8mVtxVAKIqPXy7TVe35mOoMjxheUwGjJV6hnbRJWCRK0r26QgmtzmvYsfIb8VkGbUYueru2RJ6BFANj3DHr3SCUSkIa3jFCnguVd38Dp0iy0Z0QnIcA1OHMpskQlzdFO92wFzvn7TZ4iNAJj1ZqBciso5CCGpbXZKja5wErvvS6837pjD4UUNGt/WgA+P5jXVZ2hNe24Ek9XsagXXxTnS9gO+2AV0+dCm8Vgka7hMPiQwDaXfm91aAgbLsFp9pq0kZLqg/Iwv5/oSeZ+Si9A4uQ==
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(18002099003)(56012099006)(13003099007)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: o+Be2bJTrAoIGOAgBQh0qMpHFuyjZkJhQWTjxFr8uPFZ5aL4DNnf8V2fXMGONPWHMFOKzXx+lqlqZ7/MJ0l8MAX40/tQferA3mB0j/DP1S8l4Ku0oGuAjAa7ci53hbRGGST6Pj1CSBtIsPiTUGG9d3yUiNn64G/qHhXGmK4J8cAnZHKSRJNndcD8D+VZU/vjg7WIpseZkWRAvameUdBTpeTh0NN7pSmfeYstzaibizHXQFhmxKqqNhXBx9yBavmT9KKGtszS+NoGhfmgr4+hWmL/CSEz2AlANYJObS6rAULRpJKaZWV5ISWygax9omrj7PWmz78/0difMqq2rIE43x+qE41ZtPiVEHM0GPOrvmqPhKM8qyPuVV2S0VwhHTdJrTzZNSm6hjaIRkVRYO8im/jlBgTYLB0DNtrApaDfutC7Wp5SpIxWx5WQlEiGaJKq
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 10:27:00.5301 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76d9ed3f-220e-46fc-64e2-08defea59200
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002319.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF65F9F888E
Received-SPF: pass client-ip=2a01:111:f403:c001::2;
 envelope-from=kchiu@axiado.com;
 helo=SJ2PR03CU001.outbound.protection.outlook.com
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
 hw/arm/ax3005-soc.c                           | 224 ++++++++++++++++++
 hw/arm/meson.build                            |   6 +-
 include/hw/arm/ax3005-soc.h                   | 102 ++++++++
 .../arm/{ax3000-boards.h => axiado-boards.h}  |  10 +
 include/hw/sd/axiado_sdhci.h                  |   5 +
 10 files changed, 408 insertions(+), 8 deletions(-)
 create mode 100644 hw/arm/ax3005-evk.c
 create mode 100644 hw/arm/ax3005-soc.c
 create mode 100644 include/hw/arm/ax3005-soc.h
 rename include/hw/arm/{ax3000-boards.h => axiado-boards.h} (69%)

-- 
2.34.1


