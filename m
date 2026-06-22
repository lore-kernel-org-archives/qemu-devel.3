Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2263CCDB46F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 06:07:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbXnS-00053p-ER; Mon, 22 Jun 2026 02:06:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wbXmt-0004wF-7K
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 02:05:40 -0400
Received: from mail-westus3azon11021118.outbound.protection.outlook.com
 ([40.107.208.118] helo=PH0PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wbXmq-0006eb-EQ
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 02:05:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J+QM2zjYrGwZnLjfpw0qfwht0vY6pqJxUvaEz1GfMrK2cCSIMkKHYHRVKMHCXe65PbkOiMOcP8sAZBg4hX60s2ujJGUsEzUJ5mS4pnm3UAm717k3LCnnIOI04mDNnbOn85rhoaMbY+du9M0SvuynavVakVcDmJ0X6dnz3xyKaojsozSCj7yMWTLjX40ILqVv2gAaxcCoONiiVCD+GAxBiUvqLkDfDNK2WzG4JZk8sQvbUieCwJLfFqEaaV1nzS46o5cgFjla2v7fApicrAtlaIKUjNdGyL7Hw7PrA7XGR1+xVACopZVhHZScS7krxS6KKG8zFWLXOgzSFRpzPa6k/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X/c5F7oNZvEh2F81KzW5AjqNNbkwMgtrbXfIadftc/w=;
 b=PhJuLrqvIkFFV3d/S6w58T5hZtIzdeC6NXzjGet0oR2ZSe9J+Tqh/4J6IKDYW+YYTjraf5L5itRNkQfAU0cX9B/mVa0cj7U8o0d+TvjqMXaY6O5cJik791vpN9oi6y/ZjEjSfWJnxLnHKOhkZyUGSUT92is4UDtKObDBf4BGICCmJLBLRwM0ut0BPA2hDXJuqlI+BGrOPuBgqWyDOWstg1cRLkqAyDhP5h3/AMrcZsqXEmZHETF0JAY/mtq5X/WXWfx6boFQTQpmjR5byWzxobHsj5o/OvE55oE+ZtFwbZFztARGONml+flU5r10QfO6EvOyX1b63MQmy8KgCXUTSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X/c5F7oNZvEh2F81KzW5AjqNNbkwMgtrbXfIadftc/w=;
 b=fD17e98M048kUqo6MBAl0LCOF3ehQWQQQ0NQ6R6tt9GivyNQ41uM/If5tgXmZ95rV6dWMmeR9bxmiHYlPQm52TIAVNrFQiBqoybqKGItd1lGQwDf5zwTz7zhu5avt8NK8ljPJ05yf6ONXl6gbfS67n5LwvFUCg1ZKtBwyWNLdfnm+DOIPGhUKmEbcfT3f2MR1om95U1jDjIVQz5MxoUPafaWIaVHnXq/fixDI0qzhS03ZEjtOCCChQgxYF4if7SHdKupY1Y7tK15ba6Le4UBr25B5h23Mir0wRgGp2jXpAAVwrJncYM7np73WUgmPkweck9B9UYuC6dAOcuz1SGJKQ==
Received: from PH0PR07CA0052.namprd07.prod.outlook.com (2603:10b6:510:e::27)
 by MW5PR18MB5812.namprd18.prod.outlook.com (2603:10b6:303:1ab::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Mon, 22 Jun
 2026 06:05:12 +0000
Received: from SN1PEPF000397B4.namprd05.prod.outlook.com
 (2603:10b6:510:e:cafe::80) by PH0PR07CA0052.outlook.office365.com
 (2603:10b6:510:e::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.19 via Frontend Transport; Mon,
 22 Jun 2026 06:05:11 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 SN1PEPF000397B4.mail.protection.outlook.com (10.167.248.58) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.10
 via Frontend Transport; Mon, 22 Jun 2026 06:05:11 +0000
Received: from axiado.com (unknown [10.4.1.181])
 by smtp.corp.axiado.com (Postfix) with ESMTP id 39CB34186B51;
 Sun, 21 Jun 2026 23:02:27 -0700 (PDT)
From: Kuan-Jui Chiu <kchiu@axiado.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org, philmd@oss.qualcomm.com
Cc: Kuan-Jui Chiu <kchiu@axiado.com>
Subject: [PATCH v6 0/8] Add Axiado SoC AX3000 and EVK board
Date: Sun, 21 Jun 2026 23:04:58 -0700
Message-Id: <20260622060507.83195-1-kchiu@axiado.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B4:EE_|MW5PR18MB5812:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 42a2abe1-6e40-4b75-d6f1-08ded0243863
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|36860700016|82310400026|3023799007|56012099006|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info: xBBj5JYAHJhf4siyY8DYV3ZL5iQhcKbrjpm3r+v5MWRTM51HOEmTLRKX4Uzo8E+uLwGxMIHBYCHvVWvqnhSpE388oWZx4WSFGtYQPqzXaI46qT52Vh7bMB1OmAinaHjt5Ktv+Gmgmfk31OThR4qxT0kMHGYmDJK8nnG3Y2YrTAZpTUTlgtZSt2z0+sMstC/ARzD844XwEkfK9OLD4LSBbrSKpA5DY0KTE5MolwVm4+cl+ZVCHmjjKOn77mHBJXfDli1MutRywT4W6sLDBF4mBvF4l39l1jTbt+OQRACRoLDs7zbYnHqJn8+0pqqPOf58RM7nQJTswYXKEZbBAh+wtRcNUt1U/w7SkDqUKkE5HmLw7okkNNQL5LX5AVkDOxiPouos5uDuMjEBdeYF4F8lLYmLQZZHcSiydEvCuE0lbDuhCMe4avE72Lrg2i0eN7OFsTeZObra9t77TsAFr3M7V5wOzq1EpWtiOrj8jBkXTZcjpQM+81tf6ACDUgqZfIWYkI3jdcT5MRrrnuYfHBTobMFbFCFfMyBXOFtGiZ14XHmqC6LtnSYtgmOV8KDSkz2rBB2Wddhs+AsO1weYmoctWaf5HB1mQKLdrTDikhNgL+/7pXgf0vDtmDHS4hhans0VUcHxTRhsAu/5DPKqyeAmkw==
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(36860700016)(82310400026)(3023799007)(56012099006)(18002099003)(13003099007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Fik3spE1cTwske2bOi0AcRRn/WaTyegQCzKuxrABT/XxR8YffqHKbfDOpOFoYm8sbQtZsD8R+E7CxJADQ6t1jNIY6IgmN5e4VSth2N1WBqVajqEQJrXuapgqkxdFW2Dq44ygfu2PqayIrbke9w1dicI7R8XiGPDfM8ebec8GO68H5gCHX6kGaxSQ+N0cM4dxFQFFbdpQ8ZXMMvQtOPyWTuLbSYQopltqirdWnUqYomgHe+JP4tRYWX3n/tgVMFavxF1s3HNKJfkHkImSsZOOWNwzBBgEU904FTPgMNiddaxwSPt0oPlwFrWqUmuAaokMFpbG5U4icashq8e9DuTe3bgSeAw7lQ9WXv3HTdqHy0aTPLelvhBzfFopm0dwhc+QgrK5NZj+8ZdGBiXJG+CmwD0Qvcd8EwnSfgc/x64+xA7yGsVdGDH35Ye5mqiI4esG
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 06:05:11.5028 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42a2abe1-6e40-4b75-d6f1-08ded0243863
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR18MB5812
Received-SPF: pass client-ip=40.107.208.118; envelope-from=kchiu@axiado.com;
 helo=PH0PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

Changes in v6:
  1. Add qemu_log_mask(LOG_UNIMP) into axiado_clk and axiado_sdhci for
     unimplemented registers
  2. Revise header of axiado_sdhci
  3. Add "const" to temporary data structures

Changes in v5:
  1. Include Reviewed-by tag in reviewed patches
  2. Add arm_load_kernel() in ax3000-boards
  3. Add axiado_clk to support AXIADO_CLK

Changes in v4:
  1. Remove ERRP_GUARD from axiado_sdhci
  2. Optimize ISR update function of cadence gpio with logical operation

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

Kuan-Jui Chiu (8):
  hw/arm: Add Axiado SoC AX3000
  hw/misc: Add AX3000 clock control
  hw/arm: ax3000-soc: Enable Ax3000 clock control
  hw/sd: Add Axiado SD host controller with eMMC PHY
  hw/arm: ax3000-soc: Enable Axiado SD host controller
  hw/arm: Add Axiado EVK SCM3003
  hw/gpio: Add Cadence GPIO controller
  hw/arm: ax3000-soc: Enable Cadence GPIO controllers

 MAINTAINERS                    |   9 +
 hw/arm/Kconfig                 |  15 ++
 hw/arm/ax3000-boards.c         |  56 +++++++
 hw/arm/ax3000-evk.c            |  27 +++
 hw/arm/ax3000-soc.c            | 238 +++++++++++++++++++++++++++
 hw/arm/meson.build             |   6 +
 hw/gpio/Kconfig                |   3 +
 hw/gpio/cadence_gpio.c         | 292 +++++++++++++++++++++++++++++++++
 hw/gpio/meson.build            |   1 +
 hw/gpio/trace-events           |   5 +
 hw/misc/Kconfig                |   3 +
 hw/misc/axiado_clk.c           |  77 +++++++++
 hw/misc/meson.build            |   3 +
 hw/sd/Kconfig                  |   4 +
 hw/sd/axiado_sdhci.c           | 117 +++++++++++++
 hw/sd/meson.build              |   1 +
 include/hw/arm/ax3000-boards.h |  28 ++++
 include/hw/arm/ax3000-soc.h    |  98 +++++++++++
 include/hw/gpio/cadence_gpio.h |  55 +++++++
 include/hw/misc/axiado_clk.h   |  26 +++
 include/hw/sd/axiado_sdhci.h   |  21 +++
 21 files changed, 1085 insertions(+)
 create mode 100644 hw/arm/ax3000-boards.c
 create mode 100644 hw/arm/ax3000-evk.c
 create mode 100644 hw/arm/ax3000-soc.c
 create mode 100644 hw/gpio/cadence_gpio.c
 create mode 100644 hw/misc/axiado_clk.c
 create mode 100644 hw/sd/axiado_sdhci.c
 create mode 100644 include/hw/arm/ax3000-boards.h
 create mode 100644 include/hw/arm/ax3000-soc.h
 create mode 100644 include/hw/gpio/cadence_gpio.h
 create mode 100644 include/hw/misc/axiado_clk.h
 create mode 100644 include/hw/sd/axiado_sdhci.h

-- 
2.34.1


