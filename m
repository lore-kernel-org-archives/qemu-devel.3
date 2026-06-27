Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ECB3C43458
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jun 2026 15:44:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wdVBn-00066B-HW; Sat, 27 Jun 2026 11:43:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wdVBl-00065D-Ih; Sat, 27 Jun 2026 11:43:25 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wdVBi-0005bT-Nv; Sat, 27 Jun 2026 11:43:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LIOxIbmm1RILaUFXyttkaanhV2/9bN3eQ3NBh4fBKbI3DDK797q6SjvP1AsC467I5gBBzRp2Z+ku0JwDrz+58wAUGcLxLKUBFsEfP4Cp5udExQKXF1EVbt+LMajmszkwnkfNFJ5r+c36/sOGsWCx2POclvJbGFmEECgnWJI+ZBxTNo3nKc2Wedpf9j9mbGP2R2NdafL7TuQ7Hr8BG4ruvWku02zFKsipzlQr8IBDzn5PiT5ihXys1HQdSsF8OnDY2NIkGw6PMh0Q8ltqz/zURj3MXYd1vavuy/B/LJjf7A5MxlK8Pw5k3HVEx8bimwaXtpdqa5ZnrC0VjVAzWC5nNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zvsPLgVJQ8hcOtXU/ebNfq6l+E1aNr6NIvI+NtRg0F8=;
 b=I4nGiEHYlkhXAvXTUhpCiVyzvFvvQNU3+qfA0vQ3c+O64pwsjc6TIJVCNcDgum2Kkj1irskrmNIWks0diMGIXoOewsUZqYdsEfe7MU6FnaBbjIefJ0uRFTM+Z6NBfK2jo/mLHv/K9iYeKHL5MQsd5v/jof85PZ4FjbiWbXtqs4EVwh/XgQi5m0hzvKnoVBkkopf8MVJW1A0Tx3CDUCEHwZGmhxyWiEMOGNnvmeyLoFAmgVDlgDfEQUI8o1U8AOrqZvgkI1zmA78ODclhNmUDJELfcNyk5o6bOFN+W3EXonp0if6rmRL6ikqRWIX2ef13/ew0eVecmVeJRoIYyX5nvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zvsPLgVJQ8hcOtXU/ebNfq6l+E1aNr6NIvI+NtRg0F8=;
 b=H2Plt3qhQfb+y7HX9UTU0KHu8bspvB4XoEbK18oyq8N/oKX3FmaeQx9A0yTAkIXVH8xSAG4G6xOJ/2FIU6v/KcD04X1OkSZ5dYo+6BObm/mkZW7dVZllBXSlVvMxYwdYF+/Ck96++GcNthIAn+lqaPZ9CUIfoJSO9iXAOpDnz9oXKwTIrkxXLLGuIdZutfYTBor+ehDwxZQR4pfvjmaEFs7hIY0HuOiIvNIBd+TiIZWWXqVC2dN5QLlf40IdALUtwD+kbVxT2XjxsuBETe4s5oKwWceLh7hVTOJ9RXW9eaUpN62p5XFK8W6kVL3xaj2LbJTH1rhOhNXYZKSbJnleOQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by OSQPR02MB8797.apcprd02.prod.outlook.com (2603:1096:604:429::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.18; Sat, 27 Jun
 2026 15:42:43 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0159.018; Sat, 27 Jun 2026
 15:42:43 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-arm@nongnu.org
Subject: [PATCH 1/1] hw/arm: xlnx-zcu102: Fix up DTB for direct Linux boot
Date: Sat, 27 Jun 2026 23:42:25 +0800
Message-Id: <20260627154225.863984-2-bin.meng@processmission.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260627154225.863984-1-bin.meng@processmission.com>
References: <20260627154225.863984-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI3PR03CA0014.apcprd03.prod.outlook.com
 (2603:1096:4:297::15) To KL1PR02MB4977.apcprd02.prod.outlook.com
 (2603:1096:820:71::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|OSQPR02MB8797:EE_
X-MS-Office365-Filtering-Correlation-Id: 3862391c-7803-41b1-b53d-08ded462ba4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|34096008|1800799024|23010399003|366016|586017|376014|3023799007|5023799004|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: APw31lJj942V8elSPeJXcrVLDOpku7hUjuhqWmFFA+U0ckxMjuvIuX0yFutv2UjO819gZYCws4dGOZqivN/l3sBUOlLlaJMFtzFTD8dvAEEnj5Teel3AFi8m5KZAprG0MxjGWMNKmzi2boB2UJ85dgbomHhraKjiqVFnzDUBNfnX3GGuTP8z0nO5aUnYSlHzwSUpkuu03OnzX9j6s1ZqdjfxJTKK1WWriuA0q6ZjgjQq94SwyKSRcVyi94VPz8VO8bIgNQ/dzdXPTBH2cvdmyoRdEouD11RmJITf+xen9hDJoUlawkOAC2g7yqPNdNrD3HPTvaU78wxVnO6ZAK+KAqmnHlu84YjopPQ45zwHKee3GOWvdQKxy+tON8/8n1SmRRyLg33/4Ksk5Xy/UihkE1aJ6joKgu3W1uPrfs5kyICGpfj8EEuwA95e6UTfUwRDuFFFpmQmKHvt6afJyFHsTVY86dl6PXl8UM/xC2ihRBrjzPpymxKMgGmJRB7H2Z9E9q49CTQSpO0lBtlmhHyySAg4Aub2TIkoltswwAzhSC9cExwcO42acIZ8kdKub5RnSKwjgKcsRfiBWX99Nfg0iPQlggKW7gJAxYYaJ/LkZA5rXB+P3Gd/PNPT67Uy/vB3fU2THFkYYzaRSuowT/S/VoAz/Ylw7B0VM9J7MSck5cI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(34096008)(1800799024)(23010399003)(366016)(586017)(376014)(3023799007)(5023799004)(56012099006)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6gVv5bzBEuReArOHZXnrqbBMW8l55TgvJ9t/XXekWu4rBsq1m1cMZZVhzabj?=
 =?us-ascii?Q?tIaRGTqU6uD5pFe4N7dWotQ8yE9nS23Kbm1rc+kqqdLrxbGZ5801LMTF56R5?=
 =?us-ascii?Q?e6xosgoxXe+L/EdyXFSw6p60miRqA7Fhz5trzJvyw1EfZ0+PPzBL4wryN8MM?=
 =?us-ascii?Q?vSH4/Nz/NpGfHVzlDU12Wkyac5jcwh2dVnE/iSho3RXBRdff/1WaA3uFlVe6?=
 =?us-ascii?Q?T5sX1vs2MhDSdYkpE64F0YXypZjUKE+lNsGu+FynyxFjtagTkHam5RfNi9S8?=
 =?us-ascii?Q?JLEpawpDcQlqhRXF7Hs9Q+ReO+orW5t7Falex9dwzgNz4iJ90q5VRLKIWKFW?=
 =?us-ascii?Q?ixHelnW3BaR/tEXaWFlmkows59+E9K+1OquaUjNuRjE3osobhRflmemnvb8W?=
 =?us-ascii?Q?oQImOGz774lxuBX1c7k6zEgkmnLk7mOaeIPNSATfscKr43pG3ArbczUMWYXG?=
 =?us-ascii?Q?V8vhqzeqQWb1I6HIYxgoFYy43nQE7pPlYicrmtBC2vM65Vl7OH/fpgwQO2lW?=
 =?us-ascii?Q?WhbvA0MTNrA0Ji6shOH4P/vJQ0IZUhbIVP3QXPajyw6f2lZngheFtdipWDrB?=
 =?us-ascii?Q?iuW19hxVLD1h/9u7egobRi0wbsmMPUCs8bk3X1jrSZFrDAqPLSVbl0YR0Caf?=
 =?us-ascii?Q?K0bDBOKqZX42ItjdEeLXebTBSnXmwErs+v6yt2dUDnNqdBIWjsuv6q5zuXZp?=
 =?us-ascii?Q?h+26QvBIjTY4odPj4f5MRvjRblN4txW8kQIle6DcHQdFtLxmYYSiiVw819eo?=
 =?us-ascii?Q?+G5CtpmyTPp+5x4dtwHD2BJ7ux2a+ao2HwdIYGthWblFHLOiKJNfJFMyocYD?=
 =?us-ascii?Q?8TueCFP85eVsKqIsJIyOhW0JhQngov2g8xIgsra4k4ts7Tn1qdgqBRFkabU+?=
 =?us-ascii?Q?M2CMulxZFD35mdvcc/PImxS18FBsOAo1A0Zpdr/eI6DF7hD+lvyNz9dTL22n?=
 =?us-ascii?Q?oE8Hzj5lMQtE1y8fsPsad1yS/EkgFkRX6CRYSV1KgSjzsRj836ekb+RciwHI?=
 =?us-ascii?Q?0rqTbhAFrOY5rC/ulrf6DeTGoXXoS2X1ZsvydY14y8akfdfH1cVD4yyjZZdz?=
 =?us-ascii?Q?DfUAJ1mHLCF4k3CknmHrqbORHNlLpC+0EO/fkiLh8TZBRbiKZyHLNzFuFRoO?=
 =?us-ascii?Q?uYhreIcfCrxOGlUDtJby6diiLCwldWG1QAgyfRNza5W8Tl+YwQQ7kacfH3R+?=
 =?us-ascii?Q?TF2xhuCBSiIJYK0l9+cvPaAN/0wqlpcFm64HN2RrotM46lLh0yiF0LbQNThU?=
 =?us-ascii?Q?I1AXaUvhdu7GjmXNFnkAsCdW0TBVmLcplbSfjAcf2u7bc+ochmL7JqfB6MHj?=
 =?us-ascii?Q?aKDkHEeg1cVfLnwTN0wpf0gOZ+nWcA/OjQGuG8sHdT1VlqTsFthpgsW8CriM?=
 =?us-ascii?Q?0kbqnKP4PTRZ6zC5Li3GuLFJFtg+slm9okHoq0yBB5+QMNbeQfIgmVQQKslM?=
 =?us-ascii?Q?ozlL3MNQaWSOXq5I74t0rjDIsObcg2b1Zd875M8R2Yy2qMpbuE0HREwAeiiq?=
 =?us-ascii?Q?6d9T2qybJe9/NcB9aOcEWHPYB6mKNAs8+7pUl6Q9Jg6e6rvRHa7nvC5XXH61?=
 =?us-ascii?Q?9LgcMrEA9+JgEdoaBbfGyljTppJZQbunuLY0pmi4Ivm9F1IRdyuHC2+22M2r?=
 =?us-ascii?Q?LxZ7WS1b+8HDril66hNrXQAdiTSNm94SStWml9kM8D1qLhraorsN9otL2ZbD?=
 =?us-ascii?Q?nBa8lXZtXE0aN5w1XBG/hmGk4mXEeDkDDWS7wYKFsfrpmq1RmAJHB44dqmkA?=
 =?us-ascii?Q?gAOr4/13DzMoH8nt9qP7isqj6bp6rAg=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3862391c-7803-41b1-b53d-08ded462ba4f
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2026 15:42:43.2085 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ry1zU8rTRCcyOgRBk2Zen282BBxGnYk47uuaGAfz7cdNRKdVIkYau+cYu3ee8G2dCNN8+oxzD/+EXIqvsWfpu80B2UFeW9cecw3NnGaK4aU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR02MB8797
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=bin.meng@processmission.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 WEIRD_QUOTING=0.001 autolearn=ham autolearn_force=no
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

Real-board ZCU102 DTBs describe the UART, SDHCI and GQSPI nodes
in terms of ZynqMP PM firmware providers for clocks, resets, power
domains and pin control. QEMU does not model those runtime firmware
providers, so using such a DTB with -kernel currently requires users
to edit the DTB before Linux can probe the boot-critical devices.

Add a board DTB fix-up for direct kernel boot that removes those
provider-only properties from the boot-critical nodes and rewrites
their clocks to fixed reference clocks already present in the DTB.
This keeps the user command line using the Buildroot-generated DTB
while limiting the compatibility adjustment to devices modeled by
QEMU.

Document the direct boot flow, the SD and QSPI image layout details,
and the remaining firmware and real-board peripheral limitations.

Signed-off-by: Bin Meng <bin.meng@processmission.com>

---

 docs/system/arm/xlnx-zcu102.rst | 139 +++++++++++++++++++++++++++++++-
 hw/arm/xlnx-zcu102.c            | 109 +++++++++++++++++++++++++
 2 files changed, 247 insertions(+), 1 deletion(-)

diff --git a/docs/system/arm/xlnx-zcu102.rst b/docs/system/arm/xlnx-zcu102.rst
index 534cd1dc88..41ddd15592 100644
--- a/docs/system/arm/xlnx-zcu102.rst
+++ b/docs/system/arm/xlnx-zcu102.rst
@@ -4,8 +4,30 @@ Xilinx ZynqMP ZCU102 (``xlnx-zcu102``)
 The ``xlnx-zcu102`` board models the Xilinx ZynqMP ZCU102 board.
 This board has 4 Cortex-A53 CPUs and 2 Cortex-R5F CPUs.
 
+Supported devices
+-----------------
+
+The machine is based on QEMU's Xilinx ZynqMP SoC model and includes
+the following Processing System devices:
+
+ * Cortex-A53 APU and Cortex-R5F RPU CPU cores
+ * Generic Interrupt Controller
+ * DDR memory
+ * On-chip memory
+ * Cadence UARTs
+ * Cadence GEM Ethernet controllers
+ * SDHCI controllers
+ * SPI controllers
+ * GQSPI controller
+ * RTC
+ * CAN controllers
+ * USB controllers
+ * SATA controller
+ * DMA controllers
+ * BBRAM and eFUSE devices
+
 Machine-specific options
-""""""""""""""""""""""""
+------------------------
 
 The following machine-specific options are supported:
 
@@ -17,3 +39,118 @@ virtualization
   Set ``on``/``off`` to enable/disable emulating a guest CPU which implements the
   Arm Virtualization Extensions. The default is ``off``.
 
+Boot options
+------------
+
+The ``xlnx-zcu102`` machine can start a Linux kernel directly with
+``-kernel``. It does not provide a ZynqMP BootROM flow for loading a
+Xilinx boot image from SD or QSPI flash, so images such as ``boot.bin``
+or ``qspi.bin`` cannot be passed alone and expected to boot like they
+would on real hardware.
+
+QEMU does not generate a built-in device tree for this machine. Pass a DTB
+with ``-dtb``. For direct Linux boot with a real-board ZCU102 DTB, QEMU
+applies compatibility adjustments for the boot-critical UART, SDHCI and
+GQSPI nodes so that Linux can use the devices modeled by QEMU without
+requiring user-side DTB edits.
+
+This is not the same as emulating the complete ZynqMP firmware stack. The
+DTB can still contain non-boot devices that depend on board peripherals,
+external clock chips, power domains, pin control, or firmware services
+that QEMU does not model.
+
+Direct Linux boot with Buildroot
+--------------------------------
+
+Buildroot has a ZCU102 defconfig. Buildroot 2026.05 release is tested at the
+time of writing. From the Buildroot source tree:
+
+.. code-block:: bash
+
+  $ make zynqmp_zcu102_defconfig
+  $ make
+
+The generated files are in ``output/images/``. The examples below use:
+
+ * ``Image``
+ * ``zynqmp-zcu102-rev1.0.dtb``
+ * ``sdcard.img``
+ * ``qspi.bin`` if QSPI flash probing is desired
+
+QEMU's SD card model requires a power-of-two image size. Work on a copy
+of the Buildroot SD image and resize the copy, not the original output:
+
+.. code-block:: bash
+
+  $ cp output/images/sdcard.img sdcard-qemu.img
+  $ qemu-img resize -f raw sdcard-qemu.img 128M
+
+The real-board DTB enables the SDHCI controller at ``mmc@ff170000``.
+In QEMU this is SD index 1, so attach the SD card with
+``if=sd,index=1``.
+
+Boot Linux with the Buildroot kernel and the native Buildroot DTB:
+
+.. code-block:: bash
+
+  $ qemu-system-aarch64 -M xlnx-zcu102 -m 2G -nographic \
+      -kernel output/images/Image \
+      -dtb output/images/zynqmp-zcu102-rev1.0.dtb \
+      -append "earlycon=cdns,mmio,0xff000000,115200n8 \
+               console=ttyPS0,115200 root=/dev/mmcblk0p2 rw rootwait" \
+      -drive file=sdcard-qemu.img,if=sd,index=1,format=raw
+
+This should get the kernel booting all the way to the Buildroot login
+prompt on ``ttyPS0``.
+
+QSPI flash
+----------
+
+The board creates two PS SPI NOR flashes first and the ZynqMP GQSPI
+flashes after them. Therefore the first GQSPI flash is
+``if=mtd,index=2``. The remaining GQSPI flash backends use indices 3, 4
+and 5.
+
+The Buildroot ``qspi.bin`` image is smaller than the 64 MiB
+``n25q512a11`` flash model. To attach it as the first GQSPI flash,
+place it in a 64 MiB raw backing file:
+
+.. code-block:: bash
+
+  $ qemu-img create -f raw qspi-cs0.img 64M
+  $ dd if=output/images/qspi.bin of=qspi-cs0.img bs=1M conv=notrunc
+
+Add the following drive to the direct Linux boot command above:
+
+.. code-block:: bash
+
+      -drive file=qspi-cs0.img,if=mtd,index=2,format=raw
+
+With this drive attached, Linux should probe the ZynqMP GQSPI
+controller and register the SPI NOR partitions from the DTB, for
+example ``qspi-fsbl-uboot``, ``qspi-linux``, ``qspi-device-tree`` and
+``qspi-rootfs``.
+
+The default Buildroot ``qspi.bin`` is a boot image, not a root
+filesystem image. The default DTB's ``qspi-rootfs`` partition is also
+too small for Buildroot's ``rootfs.ext2``. Booting with the root
+filesystem in QSPI flash therefore requires a custom image layout and
+matching DTB changes.
+
+Known limitations
+-----------------
+
+The machine does not emulate the complete real-board firmware stack.
+In particular:
+
+ * ZynqMP BootROM boot-mode selection is not modeled.
+ * Passing the Buildroot ``boot.bin`` with ``-bios`` does not boot Linux.
+ * Attaching ``qspi.bin`` as an MTD drive without ``-kernel`` does not
+   boot from QSPI flash.
+ * ZynqMP PM firmware services are not modeled. For direct Linux boot,
+   QEMU adjusts the supplied DTB only for the boot-critical UART, SDHCI
+   and GQSPI nodes.
+ * Other real-board DTB nodes can still defer or fail probing when they
+   depend on devices that are not present in the QEMU model, such as
+   external I2C clock generators, board sensors, some GPIO consumers,
+   PHYs, or non-boot DMA/display paths.
diff --git a/hw/arm/xlnx-zcu102.c b/hw/arm/xlnx-zcu102.c
index 4e48970274..839e4e90d5 100644
--- a/hw/arm/xlnx-zcu102.c
+++ b/hw/arm/xlnx-zcu102.c
@@ -26,6 +26,7 @@
 #include "system/device_tree.h"
 #include "qom/object.h"
 #include "net/can_emu.h"
+#include <libfdt.h>
 
 struct XlnxZCU102 {
     MachineState parent_obj;
@@ -43,6 +44,112 @@ struct XlnxZCU102 {
 #define TYPE_ZCU102_MACHINE   MACHINE_TYPE_NAME("xlnx-zcu102")
 OBJECT_DECLARE_SIMPLE_TYPE(XlnxZCU102, ZCU102_MACHINE)
 
+static bool zcu102_fdt_get_phandle(void *fdt, const char *node_path,
+                                   uint32_t *phandle)
+{
+    int offset;
+
+    offset = fdt_path_offset(fdt, node_path);
+    if (offset < 0) {
+        return false;
+    }
+
+    *phandle = fdt_get_phandle(fdt, offset);
+    return *phandle != 0;
+}
+
+static void zcu102_fdt_nop_prop(void *fdt, const char *node_path,
+                                const char *prop)
+{
+    int ret;
+    int offset;
+
+    offset = fdt_path_offset(fdt, node_path);
+    if (offset < 0) {
+        return;
+    }
+
+    ret = fdt_nop_property(fdt, offset, prop);
+    if (ret < 0 && ret != -FDT_ERR_NOTFOUND) {
+        error_report("%s: Couldn't nop %s/%s: %s", __func__, node_path,
+                     prop, fdt_strerror(ret));
+        exit(1);
+    }
+}
+
+static void zcu102_fdt_fixup_clocks(void *fdt, const char *node_path,
+                                    uint32_t phandle)
+{
+    if (fdt_path_offset(fdt, node_path) < 0) {
+        return;
+    }
+
+    qemu_fdt_setprop_cells(fdt, node_path, "clocks", phandle, phandle);
+}
+
+static void zcu102_fdt_fixup_qemu_direct_boot_nodes(void *fdt)
+{
+    uint32_t pss_ref_clk;
+    int i, j;
+
+    static const char * const provider_props[] = {
+        "power-domains",
+        "resets",
+        "assigned-clocks",
+        "assigned-clock-rates",
+        "assigned-clock-parents",
+        "pinctrl-names",
+        "pinctrl-0",
+    };
+    static const char * const direct_boot_nodes[] = {
+        "/axi/serial@ff000000",
+        "/axi/serial@ff010000",
+        "/axi/mmc@ff170000",
+        "/axi/spi@ff0f0000",
+    };
+
+    /*
+     * The Linux ZCU102 DTB inherits these boot-critical nodes from
+     * arch/arm64/boot/dts/xilinx/zynqmp.dtsi:
+     *
+     *   uart0: serial@ff000000
+     *   uart1: serial@ff010000
+     *   sdhci1: mmc@ff170000
+     *   qspi: spi@ff0f0000
+     *
+     * zynqmp.dtsi, zynqmp-clk-ccf.dtsi and zynqmp-zcu102-revA.dts
+     * wire them to PM firmware-backed clock, reset and pinctrl providers.
+     * Linux reaches that firmware through zynqmp_pm_invoke_fn() in
+     * drivers/firmware/xilinx/zynqmp-core.c; examples include
+     * zynqmp_pm_query_data() for drivers/clk/zynqmp/clkc.c,
+     * zynqmp_pm_reset_assert() for drivers/reset/reset-zynqmp.c, and
+     * zynqmp_pm_pinctrl_request() for drivers/pinctrl/pinctrl-zynqmp.c.
+     *
+     * Direct kernel boot has no PM firmware stage for those calls. Bypass the
+     * firmware-backed providers for just these nodes and describe their clocks
+     * as fixed inputs, avoiding a QEMU model of the runtime PM firmware.
+     *
+     * The Linux ZynqMP clock description defines pss-ref-clk as a 33.333333 MHz
+     * fixed clock with #clock-cells = <0>. Use it as a conservative direct-boot
+     * fallback for both clock inputs of these devices. That satisfies the
+     * existing two clock-names entries while keeping the DTB independent from
+     * the firmware-backed ZynqMP clock controller.
+     */
+    if (!zcu102_fdt_get_phandle(fdt, "/pss-ref-clk", &pss_ref_clk)) {
+        return;
+    }
+
+    for (i = 0; i < ARRAY_SIZE(direct_boot_nodes); i++) {
+        for (j = 0; j < ARRAY_SIZE(provider_props); j++) {
+            zcu102_fdt_nop_prop(fdt, direct_boot_nodes[i], provider_props[j]);
+        }
+    }
+
+    zcu102_fdt_fixup_clocks(fdt, "/axi/serial@ff000000", pss_ref_clk);
+    zcu102_fdt_fixup_clocks(fdt, "/axi/serial@ff010000", pss_ref_clk);
+    zcu102_fdt_fixup_clocks(fdt, "/axi/mmc@ff170000", pss_ref_clk);
+    zcu102_fdt_fixup_clocks(fdt, "/axi/spi@ff0f0000", pss_ref_clk);
+}
 
 static bool zcu102_get_secure(Object *obj, Error **errp)
 {
@@ -98,6 +205,8 @@ static void zcu102_modify_dtb(const struct arm_boot_info *binfo, void *fdt)
         }
         g_strfreev(node_path);
     }
+
+    zcu102_fdt_fixup_qemu_direct_boot_nodes(fdt);
 }
 
 static void bbram_attach_drive(XlnxBBRam *dev)
-- 
2.34.1


