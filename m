Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C179CA5FF1
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 09:07:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDIAZ-00062j-JN; Sun, 04 Oct 2026 05:06:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xDIAG-0005w5-1u; Sun, 04 Oct 2026 05:05:50 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xDIAE-0005jn-3p; Sun, 04 Oct 2026 05:05:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KEU872r4Td/jh6UA+Coe58zpsZBJeRJhrXne7J1kGMxoaT1kCzXHFoOf3IGHwZRrzNo3phcKsxMv6BlJlL6Z8o2VwyBB0O6mo5mGsAyIh/jkU4mvP9hY1pHPg/cHR0dEnXXZ3LQ7PRCNa3litbArhNbu2Phhln1uSKwB7slfMRplEUkb8G1Qm1T/3C1Rq91psmQ6d+oXXJnhlQEkRliVycm/b3tRY02QFyQGq9bhLzXj4BPl9dOgvv3Hi+lsHX6ixYR8wyUY1IsvRwWLbcIpe3jX6u35djjzFUfJ11fm3fd/QVopkCILKm3J9DKTU6x6lV7O/looAG6Vcb93cIQgPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yh5X8wGl8OrCGvnmgUF0t/fwzjzm4IAYgU7cl60UpsA=;
 b=D8CCN0ebouRu5cYJeHzD73DZeHLOzXEwlG6a2Y82384MncRJigeKVkWTpHf71KIrQKuBGQ/1iihwhSQOkPbWuhPXGhl8dWAWTo1Zh2qBXOnTfF9GbFI42irPjaqHjAZHaUYQo2QtMR1rXvy+7B2O0fOU2maLoYihqJeGQyyMMsJgFZyrpSjU+P6BQfp+HF93Na+khAklKHJdDnBkhBd55o316fIgoQ9nGcVqX8ti0Q745501qCUftKbLZwp4pMQCbKLlEnulJu2Xm9In5BrXv+ZhF+oS4fGN7Ka6/k5DBeCEa7wQs3qSmkafRD3ZeZJEBmYcEbdVAwUq390OPoJYRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yh5X8wGl8OrCGvnmgUF0t/fwzjzm4IAYgU7cl60UpsA=;
 b=PVsoce0pk0Exn7xO5acCjdEQaaLekSqhWADfHdkfvGW0St5x2VumaW3yY8FHwN8PtJ1gp+FCsSLrfSLdyc2D3BnFPvtB1jjpo4AB3Oj/bfz8uuzlMlZXrcZCPUMhrk/bp29B4/GNIN/V4dFB4vT4ddK7gyz+Ge8S4x6vgjwKCWyNhalzLnw5w6otER9Bxz2AiNJPpXUbVupNsSl/zqJK97C+CL7mmwOidQpQb7BaQYq4w80qDg//XPCN64sngHB26olZpoNF5HORW71KmERecLtw10xuSr9Tzbokr0OhkVeEQQuO+/qSeN3RoZf9S2Ny/Kz5F3qewP3aUYJj6OicLg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com (2603:1096:820:da::11)
 by TYPPR02MB8958.apcprd02.prod.outlook.com (2603:1096:405:382::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Sun, 4 Oct
 2026 09:05:37 +0000
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215]) by KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215%6]) with mapi id 15.21.0472.016; Sun, 4 Oct 2026
 09:05:37 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Jean-Christophe Dubois <jcd@tribudubois.net>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Subject: [PATCH v3 10/10] tests/functional/arm: Add MCIMX6UL-EVK boot tests
Date: Sun,  4 Oct 2026 17:04:55 +0800
Message-ID: <20261004090500.3082641-11-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261004090500.3082641-1-bin.meng@processmission.com>
References: <20261004090500.3082641-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0002.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:386::20) To KL1PR02MB6257.apcprd02.prod.outlook.com
 (2603:1096:820:da::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB6257:EE_|TYPPR02MB8958:EE_
X-MS-Office365-Filtering-Correlation-Id: cf850e5c-87f0-49c7-70b9-08df21f6a7be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|56012099006|260925022911599003|260925021911599003|260925021311599003|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: dmTh1smHMuIY0dFZZned6IWLF2vB/e7i0NcqXz1vrnaVgRRis4abpgmfnxtmZpMHHtZuzdJOmDVWzK5hNJws9fTcrfkhR6xt3frykREhrbp+VMYTwG1ab1ur2xBu1QXT9htu4LBppWQFkBNkPgjXXNHIgql5hwi7TZ+81r3vmyHiw2G9HhJVXhQ5JyDRXxEvWG+8evlWUAaPrEQJvmyV1HRVOP12Ptr8Y+Smrz0weOuf5mnV9UYAKr+ZA0RhTa2rbFMNRZdpWtPR18hmrn9wM8JgkuckLTpzt4qz43Sq/HV/TujySN3fk2BBUesHtGbfRbtCkyTnUdRmXlTdlNR5KjvM3q2BDMUY7M6znrk542hqZpVbXGV8CPQ5lHnullLc/VqckN/qGchMvQXvwfwgZg99xOTfEjxjVtk+cbbd4PpcGFLEJeZORcyNJ3gEDnoh/vbP9Vsm0lrjvQUgN2AmMXd3r03TIiBrhvlT0bpNT4b5xf41VAUwOQvUxyocN5KOi0w1StZNUIqM2ZF9Zxu9eosHXCuWaZfcp0X8vAC1x/zFNPOjyGDRUgmldXuy/vuZ0sx1BpZ3iPHPWcKb0NYwwWzKHTad1hx3xq1xwtHnSSpx1ODUyrl7nYVQtMtxFYjiee/tNU/Xak4TRI5eou4I3eFFst3iWnofDVSEF6Y/p2c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB6257.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(56012099006)(260925022911599003)(260925021911599003)(260925021311599003)(10067099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BqqQowIJcq+HU5Hperxjvotu4av3MhqIFeTAUcoRBcjtw6X15vkRW6UKTVUb?=
 =?us-ascii?Q?f1ysYnXkeHfzKloFK114fTomui0kFVHX2ugqTfE1LFVYm+OshbS/QdBcloN6?=
 =?us-ascii?Q?jLfpVyMlVcLnyEWYs1FoMsLPYU9y6RzZiBg52tJRUuT72ORdwwnA7kMqZ9vW?=
 =?us-ascii?Q?6QEV4vsYWa71obk/XyPu0mntPS7vMc9LPRDvBdABpgnfNIHNo/I3HE+yA9yr?=
 =?us-ascii?Q?4hOUis/cxuQ2ccfYv1pL/FsBxl0VyA70q3wyZZz2Ypu6cFIE4dHpxoPvt8F1?=
 =?us-ascii?Q?FItFA87mtxkRunE6o6VlQ//11beLXrBhf2tHbWsvPLovhVNTuRRlbqUdAOIs?=
 =?us-ascii?Q?TZYwz4wNxug9iADk0ajcHoUmUe6avbrXSznCYEb3BspyVrvjlQIMa80/fjTr?=
 =?us-ascii?Q?mP3QuXThLMJ5wPH9q2ksLIAWqLSM1SJUryBG4Tx91+680zfmT01/a39spGnl?=
 =?us-ascii?Q?c0wikNRftR93A3iMR09VTf9mOAW+QIecMUP4SqKSPvoSZpfOhilVlHmxuV7Z?=
 =?us-ascii?Q?kA284h/F5H9PnGV4Qqqf8CuBd8G7F8f4/iD/Ij5sOW6qzCsguAhPzY8Mp19a?=
 =?us-ascii?Q?XSZap6w3wRyhOQsQx7MFIQxMltSVLDBl1dbANl8y2kB2QDJNbPZhZ6WhswXb?=
 =?us-ascii?Q?eXXCiXXU2fpL9aqi7ws5wPNM9L1ng5tCNNI2n1s8Oh0c8pJB3jzPSii2v7I6?=
 =?us-ascii?Q?y9b0MlG/NmH2pV4aAk+7wgVT3nGsiQden9qehRLXZQ5KRYsgpCFn3vDaAT/x?=
 =?us-ascii?Q?tX39IhOGDlB/O+6Z+Ww51/uSyImYV6CN/AfBPvM+tFxzLEI0cJRI9f1GgEoQ?=
 =?us-ascii?Q?vfaJNpIS11iI/hOeGxTZrt5XLFJn9lKpZsEHdJkZPDlrTlKfmefEkUmE5F03?=
 =?us-ascii?Q?0GbpD1g65wJTY/awkMpfAvSOI1/uklhYikI1iX9lJp1uaalwCx/30/ql80SC?=
 =?us-ascii?Q?sLWUT8nc9ZhGMmjHITho6t2LaT5Bb796o6EJZ1UK9Llj5/YGQ7fKKTpV9CC+?=
 =?us-ascii?Q?bXv91Wgmv//bf2PUDjDfDnr+8eduXWzPcoA7tObRNARpdZp9qLdP/RLZHQdt?=
 =?us-ascii?Q?mtg9PlxIllfAw4JQu53Y/A+H1f9YhJlOxlEnLk7tQNSAXwwpeFCUP+huE4TA?=
 =?us-ascii?Q?HUFhJJ2QrqpcBIM4MZkAsvhliESuMEzCdGoK+JY02CgPSq8R4vpNCEFZ0F3X?=
 =?us-ascii?Q?vyxzlZN0ZXCVDayNay8gqmPfannVhoar5Bq7x+0G3Od9jGcTPkGJSP3ciwXq?=
 =?us-ascii?Q?zgJQHuACKmpm/nY7tbg3FePfC4IXwxE6Z+OOdajsvW0/udv1zEaRx/I/irQK?=
 =?us-ascii?Q?mhXRLk2j1zlpC4vdxkKuHr3MTbzdAJcbTbiSsIGYgiGyK7YduVLfM4hqWgA+?=
 =?us-ascii?Q?/vZhH0EuU8Yabl2Mb15xq6quxfrfw0UAdqSckLDvQuR1wNskt0YvUOC9Ctzx?=
 =?us-ascii?Q?7oHTvE09i1Xd7JhhiGkH6HZkVb4/QsdqvP3pCiGwwKP3j6+ExXLsw0ZGdzDO?=
 =?us-ascii?Q?kkDf1hnWR/H6O+K6pd2p7L4nPp3bFSpXptbOPx2628A2uZDef2KnJmfN3ung?=
 =?us-ascii?Q?FSU8yce3y8IqEOOkg0oMUauGik6utD2J7X1DnPvhGEg85JgmK4+YmWFyKfiA?=
 =?us-ascii?Q?mPA+1Is8ac/z2N6fli91vQ+UxWNHGyCTXbU6v8iULk63LWIdBmjjtNph9zAP?=
 =?us-ascii?Q?vBVC6zcE3OOUuw2B5cjEAI6DyXA4VVc9qexuaBwtT1NPRShHRwzb0tmhpPdW?=
 =?us-ascii?Q?QM3Q0U6ngq+NJlwoiWAR9g9e+d8vr6s=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf850e5c-87f0-49c7-70b9-08df21f6a7be
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB6257.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2026 09:05:37.1211 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4tFUr8a3+ohklXAhwPDzYy5cGi5NhMPBZRsW5GI+ZXfv7vKRqbfTcx0ptQVIynQW/bqeafmxhNweJdFjF9EW6q4F57h4LW5O06OOozSeIIo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYPPR02MB8958
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=bin.meng@processmission.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
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

The MCIMX6UL-EVK machine supports loading U-Boot proper with the
generic loader and booting Linux directly, but neither path has
functional coverage.

Add a versioned Buildroot asset containing U-Boot, a Linux kernel,
the board DTB, and a 128 MiB SD card image. Exercise both boot paths
and verify that they reach the Buildroot login prompt.

Signed-off-by: Bin Meng <bin.meng@processmission.com>

---

(no changes since v1)

 MAINTAINERS                               |  1 +
 tests/functional/arm/meson.build          |  2 +
 tests/functional/arm/test_mcimx6ul_evk.py | 69 +++++++++++++++++++++++
 3 files changed, 72 insertions(+)
 create mode 100644 tests/functional/arm/test_mcimx6ul_evk.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 40232cb65e..3f8f0608c0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -922,6 +922,7 @@ F: include/hw/arm/fsl-imx6ul.h
 F: include/hw/display/imx6ul_lcdif.h
 F: include/hw/misc/imx6ul_ccm.h
 F: docs/system/arm/mcimx6ul-evk.rst
+F: tests/functional/arm/test_mcimx6ul_evk.py
 
 MCIMX7D SABRE / i.MX7
 M: Peter Maydell <peter.maydell@linaro.org>
diff --git a/tests/functional/arm/meson.build b/tests/functional/arm/meson.build
index 61b00932db..d8b1408b13 100644
--- a/tests/functional/arm/meson.build
+++ b/tests/functional/arm/meson.build
@@ -20,6 +20,7 @@ test_arm_timeouts = {
   'bpim2u' : 500,
   'collie' : 180,
   'cubieboard' : 360,
+  'mcimx6ul_evk' : 240,
   'orangepi' : 540,
   'quanta_gsj' : 240,
   'raspi2' : 120,
@@ -59,6 +60,7 @@ tests_arm_system_thorough = [
   'emcraft_sf2',
   'integratorcp',
   'max78000fthr',
+  'mcimx6ul_evk',
   'microbit',
   'orangepi',
   'quanta_gsj',
diff --git a/tests/functional/arm/test_mcimx6ul_evk.py b/tests/functional/arm/test_mcimx6ul_evk.py
new file mode 100644
index 0000000000..0b4dcd5a94
--- /dev/null
+++ b/tests/functional/arm/test_mcimx6ul_evk.py
@@ -0,0 +1,69 @@
+#!/usr/bin/env python3
+#
+# Functional tests for the NXP MCIMX6UL-EVK machine
+#
+# Copyright (c) 2026 Process Mission
+#
+# Author:
+#   Bin Meng <bin.meng@processmission.com>
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from qemu_test import Asset, LinuxKernelTest, skipIfMissingCommands
+
+
+class MCIMX6ULEVKMachine(LinuxKernelTest):
+
+    ASSET_BUILDROOT = Asset(
+        ('https://github.com/processmission/qemu-machine-images/releases/download/'
+         'v1.0.0/arm-mcimx6ul-evk-v1.0.0.tar.zst'),
+        'a08f2b5dae139cf73cfa601c9df9316356a07a5dc59c74d99f30ebee61c405fb')
+
+    def _prepare_images(self):
+        self.set_machine('mcimx6ul-evk')
+
+        archive_path = self.uncompress(
+            self.ASSET_BUILDROOT,
+            target='arm-mcimx6ul-evk-v1.0.0.tar',
+            format='zstd')
+        self.archive_extract(archive_path, format='tar')
+
+        sdcard_path = self.scratch_file('images', 'sdcard.img')
+        self.vm.set_console()
+        self.vm.add_args(
+            '-m', '512M',
+            '-snapshot',
+            '-drive', f'file={sdcard_path},format=raw,if=sd,index=1',
+            '-no-reboot')
+
+    @skipIfMissingCommands('zstd')
+    def test_uboot_boot(self):
+        self._prepare_images()
+
+        uboot_path = self.scratch_file('images', 'u-boot.bin')
+        self.vm.add_args(
+            '-device', f'loader,file={uboot_path},addr=0x87800000,cpu-num=0')
+        self.vm.launch()
+
+        self.wait_for_console_pattern('U-Boot 2024.07')
+        self.wait_for_console_pattern('Starting kernel ...')
+        self.wait_for_console_pattern('buildroot login:')
+
+    @skipIfMissingCommands('zstd')
+    def test_linux_boot(self):
+        self._prepare_images()
+
+        self.vm.add_args(
+            '-kernel', self.scratch_file('images', 'zImage'),
+            '-dtb', self.scratch_file('images',
+                                      'imx6ul-14x14-evk.dtb'),
+            '-append',
+            'console=ttymxc0,115200 root=/dev/mmcblk1p2 rootwait rw')
+        self.vm.launch()
+
+        self.wait_for_console_pattern('Linux version')
+        self.wait_for_console_pattern('buildroot login:')
+
+
+if __name__ == '__main__':
+    LinuxKernelTest.main()
-- 
2.53.0


