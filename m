Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B639CA5FC1
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2026 04:41:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCrY5-0006uR-Jd; Sat, 03 Oct 2026 00:40:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xCrY3-0006tq-GV; Sat, 03 Oct 2026 00:40:35 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xCrY0-00021R-OR; Sat, 03 Oct 2026 00:40:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ujJC57dR5QPIdaZeWEeMmMiCB7udtsmOM3bXOIPMP61usnTkpXIs42YjvmjfOK4cvd0IuVBht8TtsME4Z+441xJ2laCl7NDOXlw2Q9Xqz+UgqL5PtiVQqFCOuyuVQ5LcIUvpgWPUFbmLmhyT0AKyUd6qtKqR/26mbOkM+mimS3VpXCXtO932P3S1J9BVpKUSOtJg9RUeh5kXVxqbiulIac2eIUpGpfofqfI5Q+WUwh7u3F+33WI3T4DCYMMYQQpoqHU9Vg6Z10MIoGmulRfuGfBxZ8Vdq/DS5rh1B+B+uRKlEAbOClT+Qjr2Wepxx6dcFuUI/O5KeREfSllvjWdNNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WAe9O6ICRjLqfoHtzomwRERWIzHoWcvbdyiTNX2zNkI=;
 b=PW4FeDoQYFAeVXjpU3wPo03XKOsdlL0t7CzZxjsjuD6nf/qCDO3zjOcFo/OESh6/0pyle9sousysAjrQPBwseiQC/2ALHgrviS7E/IiqxVxPi7cLKd1mUtLi8jbayEI2Xn+Xn2QiEeP8kkUXMP0RmEji3MOa9fzSpBqnuRD7lryoWHaJKWeTHiZ0CHqJzw2FoQ/zVrwwW/iDEGRNIwdIAbNBU9kXA6VLgjJPWgkG04DOTUjGgcRXp2RWWElUswYfmZMwGH1N3TgFhtJfddYcC3hPO86Q/Ib8Bh/2t3zlKGKeBerWcn6iSsUrY8IByrkzfV7A2InDIrX5Q6ds9uVymw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WAe9O6ICRjLqfoHtzomwRERWIzHoWcvbdyiTNX2zNkI=;
 b=RNTnC2MT4ocxCCdDAU3E5l3ZU5Ex7VUyw9MdmAPzi2StAhODKOUykWW2oZbIHnPcFX4bfL9xvQY/UEIgjSph1egkMXKHLb/XMYZg6BnlnuMP+YGqb38BuDlQ9SyzqANnGwU6dKqcmyNSIu8Kxis2yxJo9vQEE7+9fviLiAIl2pZlpiv1+zqWjjmomXrurvCJqv1MGxBvPxbpMyzfmmhr7H9YJOS9bhtdfBfjkARkgUir1035VVQza3R/lgFK8M1ARUKfVSZEjapnnbMJVA3bcoQtGDX1M1S5Z/GRK2+g1/55EEdB7SaUjPoDzN6GldKWxVKqY6OHm32AC5NffOJP1w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com (2603:1096:820:da::11)
 by KU2PPF9FCEC1095.apcprd02.prod.outlook.com (2603:1096:d18::461)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.27; Sat, 3 Oct
 2026 04:40:22 +0000
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215]) by KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215%6]) with mapi id 15.21.0472.016; Sat, 3 Oct 2026
 04:40:22 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-arm@nongnu.org
Subject: [PATCH v2] hw/arm: xlnx-zcu102: Fix up DTB for direct Linux boot
Date: Sat,  3 Oct 2026 12:39:52 +0800
Message-ID: <20261003043953.1277518-1-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0112.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37b::7) To KL1PR02MB6257.apcprd02.prod.outlook.com
 (2603:1096:820:da::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB6257:EE_|KU2PPF9FCEC1095:EE_
X-MS-Office365-Filtering-Correlation-Id: 1859899b-043e-4499-b95c-08df21086f34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|18002099003|6133799003|3023799007|10067099003|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info: IuAkDZWKZqjsaj5XKAjEblCLVYye0gbHPU7BXqnQ53V+gkBsfkc7+7XRgTHFE2YSTq5ybtIDhU/m4Yeigql0lRwlcgfuwcccsM1MtGrmGjZ41sXwtsOvVLsHBoCXKIDCRJ/TWIJQenP0Dg4oHywgzZq66pA8Bs/Ga9vcCqq8EpKz8dYxNtWWlVZrXuskfuf2VtSsVmJ9qF5HjA2XSjKfF30WOwtY8WsVGHyA6jgTEg4jkKELhPCOmW6V5s3QS/F9Lcih4FMglzKOgEH20N9A6plm+H1tGT92X6Icn0LTdyBXTlQ0DpczYBAURtCMQ45ydQWt4sY1lI1pAaBAYbfHn8FrxcOkHcSkBxzuoMdWX2JxIQ+5eGloo4SPJ0gGGok7KoYhMKs1GuFslUyHdaDV6Bdl+BQOKZYvo/aTfMs/0FfqIaM5lqGaDJdJd7WmGLkEBCBfmbqIT08sxYCxlRCMJEhuMXJKvMMmjLws0CPflz4Lj829PSykvDmhTEAyv9lAOxrqN+MAMGceo3ZLzGxG68xrZR5CDlmw/pXL4TDiLqjwCvKx7loVJygiH8uD2rp9Qw+LKSq4JLHM6vOeqkn0eMNHUFoKwTc4EtK4qmI0YnQPlJc/BQghiprSCmz/lJ3Vs9kUKNOIcKR97ei3LvjKSKCj2aWpQmdaxfl/QcfMH+Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB6257.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(18002099003)(6133799003)(3023799007)(10067099003)(5023799004)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fFMU+EeqWiso7GST+P9XF0XCPi+8eDaBEF8DrdsMO6rY0UzPRrCReQEpiTGH?=
 =?us-ascii?Q?ciBAMAxhqzYHoen8SRDlROI8ws5dQ0PGgtrm3OMo0/bpUZMkvWoFWAFOOjYZ?=
 =?us-ascii?Q?x1H0Zud8aE/rpFh7Hu3L2jCsyR82A7Wd5dTsDsBW9MC5omQ5HcUjtWDEfZeN?=
 =?us-ascii?Q?/Vs7mDbk2KX2niUoH7levGryhTPDeA/mzlrKnftAgPSQpNXmW+EdSpz/jjU4?=
 =?us-ascii?Q?guZ82gpVWJh4iyVLb0KP1gBA0rdzRB7qOtG6c5Q8H8ikCHYtdty17h7jMz38?=
 =?us-ascii?Q?N2tAqd07ydhucb7LW5iwCNKmofBDG4Fmb3Z20LzXC8RHaMs1IuEALwawMywg?=
 =?us-ascii?Q?TdrWtVID/xuN3tVSKBFVImvIcD7F7bb8pPV51Pgai0qSTK43LEbLa/ww9NPG?=
 =?us-ascii?Q?aRySkuKkw/q2fkEU99JngMq5aJEz1rU/DpLNHzf4ZzUcwlcTXbE1zHHhv4L9?=
 =?us-ascii?Q?meahS4yH314Ax70jrgfCb3/aqwnLUvyBk8+uxJfudCMhcopudXTNZO0UUqYQ?=
 =?us-ascii?Q?K2ACW/xtB2awThSS8DFaMRXDqf0X6cWKlEZJks601Mz5A+o25LvLKrFMUFc4?=
 =?us-ascii?Q?LpIZPQMzc6YZyAGJUTkrpFexBbFXyaWjikJYr0Y20eLyy/G4/eBwk2r/veWf?=
 =?us-ascii?Q?G5968ISLEQ7vgt+kFzAWU+i3NoxcCpQeynws8B++7KTi1XKQ8zXq+6N8qLUo?=
 =?us-ascii?Q?X2NEG00TmYEE7DLTr+fS33cjeAvkCXICXCOK5KekdiHjqEtWgfaIE/tBNdt/?=
 =?us-ascii?Q?/xKpX9wPxzgQ0qpiGouCPiZ7fuO6rCrBJjOK8osdtJrmYMt0OJ8WE3X7dTEr?=
 =?us-ascii?Q?h1tuHDnHbPhz399HWxp2wNsMJF+ejdrxfGlerXuEVmk1PiRoZNgtTCgCjg50?=
 =?us-ascii?Q?5TJ3nrKfWCCFGvHwsdhWk0mwoXQ6cZAmepCIp16c4dQDQd85g87hjSJefNzr?=
 =?us-ascii?Q?Wt3Yd/26FLJwCy3J9Ox6NQybCZxjLFNLkC71JT/r4J9iseN6Nu/X+5GtmcCQ?=
 =?us-ascii?Q?KYzA+xPfKlJJBzxgZs/OuGG8GKfohLVOlawlN7O7FLvTayDzJX/tlQCSDanx?=
 =?us-ascii?Q?5Jv7iidFZBQvlgR9USwX4wLYWK/AdJHEsfwQ01QyKQCGyqvBOTVezDW6xamn?=
 =?us-ascii?Q?FcQtv1xvPPWDrG9OdtDArYAoROPpfjXulXM17odjcOoCzgP+vCQAwXkPvPFH?=
 =?us-ascii?Q?lah9/imJ1O2gdV6Ae2KWlOVRkemmlL8wmAF8wCkYd9+3NMrh42vWAMvpFqkO?=
 =?us-ascii?Q?itZs5j3uPKYWtSOp/aJPw0hmv3IB8BTKcr+akDlhDLRZKoDylImUljoREyTq?=
 =?us-ascii?Q?ext6FTFD1qS2ojog4jIl1J4bLJm84FC+ZS4zamlioeYGQObK22qOytUVw7+n?=
 =?us-ascii?Q?V9orBPfOwQTCVIfEIzSwjpZxZpmca7Bmuxc4Q/g3r9AyQybTnb7j6zHSzlYT?=
 =?us-ascii?Q?dhtgEwonLQXihamPfwo/1520OXs5xjbrLcyRD1QGGzqtnczNEXyDUMH569F9?=
 =?us-ascii?Q?y63og/jJW7ztvY8r6lW+wYkjTKyb5gpGMJYcuTQBSVeVMGcEinJkKje6Eiyj?=
 =?us-ascii?Q?floFmuKNU7RuXAhdRJhXSfzL7Jq05ilnV8IbpfVb75kyiXXuzYYmDuqYIlxM?=
 =?us-ascii?Q?2f/WI5vqxGDtkAro5+A8RWB2TSu3EYC/BrpVeUhPk4rWkydWqGrvqsz6l9qq?=
 =?us-ascii?Q?5DBSf6V+xSFcW+cRaOwbel0anzp8AbQSnnOafm+cNPWnCUCCKXC1i9Q1fI5d?=
 =?us-ascii?Q?Fv5AI+KOvpPC54wA6lEoQC8J+dKIWOI=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1859899b-043e-4499-b95c-08df21086f34
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB6257.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2026 04:40:22.1693 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hkqy7hLi6aioUSgieHr24w/F/eikBNiBv3ldEv3O7wfJ4uTa2BrZp+QOud6Xv2aL4wIWjf82kPTGcNMoQzxs9DuATIPioDaQl+kg62+NGZ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU2PPF9FCEC1095
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=bin.meng@processmission.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, WEIRD_QUOTING=0.001 autolearn=ham autolearn_force=no
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

Changes in v2:
- Restrict DTB fixups only when direct Linux kernel boot

 docs/system/arm/xlnx-zcu102.rst | 139 +++++++++++++++++++++++++++++++-
 hw/arm/xlnx-zcu102.c            | 112 +++++++++++++++++++++++++
 2 files changed, 250 insertions(+), 1 deletion(-)

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
index bb59621854..953281dca2 100644
--- a/hw/arm/xlnx-zcu102.c
+++ b/hw/arm/xlnx-zcu102.c
@@ -25,6 +25,7 @@
 #include "system/device_tree.h"
 #include "qom/object.h"
 #include "net/can_emu.h"
+#include <libfdt.h>
 
 struct XlnxZCU102 {
     MachineState parent_obj;
@@ -42,6 +43,112 @@ struct XlnxZCU102 {
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
@@ -97,6 +204,11 @@ static void zcu102_modify_dtb(const struct arm_boot_info *binfo, void *fdt)
         }
         g_strfreev(node_path);
     }
+
+    /* Run the DTB callback only for direct Linux kernel booting */
+    if (binfo->is_linux) {
+        zcu102_fdt_fixup_qemu_direct_boot_nodes(fdt);
+    }
 }
 
 static void bbram_attach_drive(XlnxBBRam *dev)
---
base-commit: 9ded45a67ff5daa7f30264bc8a9868b420da2a54
branch: zcu102

-- 
2.53.0


