Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF522CC6B24
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 04:58:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGr3V-00073g-9x; Wed, 14 Oct 2026 00:57:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xGr33-0006do-4r; Wed, 14 Oct 2026 00:57:06 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xGr31-0008Iu-Gd; Wed, 14 Oct 2026 00:57:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UO9mer9eFUgDR60hLxP4nGPrwg9SU9F9xVPvEBso2iZskoF6Gdz9yx51VtA4zIxRscRhXIMSShoEsgN/r0WrHtXMtVWx+OsjotbWR8RFBQm8ddVScSmId6hlgYD0tXhaYkSmaYVVHxT9nvNmBKRHOpbIFAfzbV5/REWCbpvDEhkoT1CIF67JLiyNBC5JauZxQvB6WxaTWXDWn/CS1QpA6z0FrsRWm4FHCeaIR6Do8qN8eBUeEGnzYanQ7MyZCA1aFZth+X3w5NmpcQT4OSUpQ1zy6nnhaFlaPt0+ecSxihGQnmloLEpiIzse1d5hOvNzpxYsF1hqALT/Cd+4ZXVuhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O5KMwy4Pc5Y4icVrOajL7pGIUEB4A1B+Oz92x4eWxn8=;
 b=zIHTdldcH/9CRilDL37BgwugaoNf7AzE/Qv62xNwu82metbaI2PoUsf5QmD0RJyVx81JekElBm9l5XlUzCeZCXhgNAg5TPMR2Ha5SYWNLGHrn8zvr3aB5kGAOyeKKazstWdtg23lVBHBfkgdzhhn/pJGJn/i+h+nk3mY00Uiw+MT5upQkQYmrX977FpvliCGQnDPweA8XN93Vk+Jv/BWxKJn14BHutdYYFg3Qm9PypXj4iu+dot5YAon6HXCBkyWBpa3xfYaNcUfaeAvVL/W58kfXg3QbsUfXFiQ55r0rG743CJQlHik/IrO+GZ4lrMx1QcFDoSuTTzRlaXtrXbYQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O5KMwy4Pc5Y4icVrOajL7pGIUEB4A1B+Oz92x4eWxn8=;
 b=qCV3cQu4P/k0j2fv9pzbV6N0ix7q6tkUAjbwurh7f9dWWu4S8cEcqSoecu4adLo7qzupDG505AIsUbwHYe0igcarEdoEkWD8F5xOQ/wtzwZvFopqTV2iDcDZmr4rHeiSbw3X6aAUBF5pVgZXU8fKPH8VqdE7OUcUInlf8o5/S1UVRDlVp30zQOzzqg5E8F/cK0qrWCMc7fZJtWOmRA8gz9J5vzAjaiKN/3QPKYnALMFIPxDciAyZWEyEEdhfgypWi1AYiibJqXlMfRtJ7RTvqINOBNjW0QdzfP56yZlaiQ9pBti769kdhj+tOdJDcm7GVWwnWVtYGTLvtHwfNfWDSg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com (2603:1096:820:da::11)
 by JH0PR02MB7213.apcprd02.prod.outlook.com (2603:1096:990:67::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Wed, 14 Oct
 2026 04:56:47 +0000
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215]) by KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215%6]) with mapi id 15.21.0496.021; Wed, 14 Oct 2026
 04:56:47 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Bernhard Beschow <shentey@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Subject: [PATCH v4 10/10] tests/functional/arm: Add MCIMX6UL-EVK boot tests
Date: Wed, 14 Oct 2026 12:56:00 +0800
Message-ID: <20261014045605.399684-11-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261014045605.399684-1-bin.meng@processmission.com>
References: <20261014045605.399684-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0051.jpnprd01.prod.outlook.com
 (2603:1096:400:17f::7) To KL1PR02MB6257.apcprd02.prod.outlook.com
 (2603:1096:820:da::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB6257:EE_|JH0PR02MB7213:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e025876-3ac8-4e62-4aa2-08df29af8cfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|10067099003|22082099003|260925022911599003|18002099003|260925021911599003|3023799007|260925021311599003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: DMHe9Y/3bZeu257sZq8ZH2dZsmxo+gJ2dO3UiENghBOjtrgZaI70oCWjxIXRluOoE9yQBhBMaRkt38zjO6zhkKSoxieqq+ebuo+SVA/7ygvfp25uuBg4F7bpni7KNlO1A+Ut3Clo0S6t2KpTd/mKq7/WJcGpu4mgX4SlOnvmsjVpDheu6/gnkYIJ3la+eUX8oxKnLz5IsJs4yah1yYeIoLpBzLhmCepdCpeF52tL8SMsrDe7ufueazPt/VyEujHZTNUl/17LQ32Mb0H+I5Qn3X+NVry9oueAFcRlucTTdceUzeypeg6qQXNesPq4tRTEORLoyFitYb/AQKqnS7lR1wHkugTP0oRFBFUqyYaWL67t4gcELlIq9hRCbt2bzikcUIigY0o+o14lTki6kq4g9ax4bcgrpqT7kK3w22fswdFM/k8u2HJmP7eytHJ5NbqUNBoMEOX921JYtroFYv32+s6qlwmXtGBVv+LYiEUX+wiGBXeGa/XUbBVdsFWw2QzdN/lDGhcmfdb6xpcewf4bEjMxid2xZ3ehTyhQqmVoAR3boF4XKzfdRFcqfrN6ZPAm+DHoI6zy3IBEYBrSZvxSd3htfwmdRUApqMcoeOpdyOneijtGid8CyWM49twYkD0NhFs1eJcTd+FSqlraEvO+ZGen8Sjk6ZWYfAo5sJEkxjQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB6257.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(10067099003)(22082099003)(260925022911599003)(18002099003)(260925021911599003)(3023799007)(260925021311599003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?e81x0UkXLZn9rH5ztjBd0XPtVrSbeRyFLxah1tFzDutKuZ4nMyGQHwhg2WG4?=
 =?us-ascii?Q?ydINtvHVqY3J3GEJQAEE7GzqiFjaA9XmOb1PZv0nMhK35NHqIo1GxEpZoWHr?=
 =?us-ascii?Q?lVlMj6QQ8NxcyQuAzvrTfw3EijZDIC7ucUwt26xVYFh9DzjPDfnmLZjLiYGV?=
 =?us-ascii?Q?VeI8jFNbBptEubqBoixE84/3SuA9wLiIpW5vAfg5E38BetAsY3t6v7J+QA5+?=
 =?us-ascii?Q?iGkk4EhFxzF37MfwXfyrkQwOYzdo0RI8IlLFFzkI8rKpNz/LBJueYo65mJ4o?=
 =?us-ascii?Q?9z8vVfK90f7SA76wX9DBM0qS2p7wlwNzqAJt4NrzL2mHgkw0g0iaQ6VfuTsl?=
 =?us-ascii?Q?awFY9ycweSlbkg7u7bTMRkdbL1HoSkjRQdxfP+o2uCe1ESV/xxWa2TB8XXPN?=
 =?us-ascii?Q?b9pjiKjVcbZgR1+omzkDyGRkgJPoopdz524++quDdwb1gj8s53l8xfCgQvxn?=
 =?us-ascii?Q?WKuENcIom34rWY2Mk8j/C6Juw6UeCvVE/YmyPTDYlZreKOtK1/EsDoUfiiw7?=
 =?us-ascii?Q?ldBGicWGB5iEjERkHLbD38E8Ka/jG3J+XIwTwwfGdTjguCxdg0cmCx2F2BFx?=
 =?us-ascii?Q?OT/nYvJSVNFlJZP0omAXg8YhFvWoDaros3sb8iAaoSGptP+lqv5a4yaFuLsf?=
 =?us-ascii?Q?B5GPJkQ3W2WKF8SSiE27BKRGpfTOmiwdicLjXGWDCyhGTjvyC9C+wcN/+yB5?=
 =?us-ascii?Q?ESKxlYWIbzechCSxSt/znxBixLXhr8Y78+EjY3X+2RAxaBo9cZ5Wh/sbQbjN?=
 =?us-ascii?Q?OJAhuoot8lSBmWdkceLb2Bs8BLdMnh0fIPm9R7eOlKzJ4A6tbiok2uSMQwKB?=
 =?us-ascii?Q?+jwMoqBvbusQQ0V0yatHgW+gjoNC22In3XzskudrQ5UNTFeSHJ1ipSv2uAI5?=
 =?us-ascii?Q?H/dLcErhZTpUk4jX1ZTsfbbURAT4A20bqilfsHZTwrjRYWX+WWPgrICN7/tM?=
 =?us-ascii?Q?K50OCDcPGNkKFtB1BQMr7a+0bRXSWkOHiMmWb6oVzQLjpH9dYdVXbozY5UTN?=
 =?us-ascii?Q?Dy+EDb8m9hzKJYYDJOCdt7737OdrCvXya3/hZV3q+fHQfWwsB0bq8G1UvP2g?=
 =?us-ascii?Q?pXL8fLYdjayqaM9fichvjXPgMiZJcOU4va1qgYVEGNjbyi7/TzE4L3MQt/V/?=
 =?us-ascii?Q?FEokDFs/V82zb1ZBfYyVWNML3MlNRsuabfIBT2Tp75oJFoHDBkr3PxkzUm+j?=
 =?us-ascii?Q?2alryGYaTq34HXIXS3nLa6kYPxAzsDYjmM+yuDIP6U/q4F2uPNuV+GdlzGQI?=
 =?us-ascii?Q?DLmuxSYieowk7xyJqGrpa7oXTVzNQl2IkLruT7O1CpghN05XLucv5kvxE125?=
 =?us-ascii?Q?qEFcvMae4YlktngHHroTEfU3MYZ/gek6MKHo+Wf3UqC6zPrPD8itUP48ouup?=
 =?us-ascii?Q?I/o2hOeG5+u+N6+g5iKjNSm4AIPNz34mifm5JG7bWPtqBsd4mOEyaLjZO0Yt?=
 =?us-ascii?Q?aaGV0iUZFohdc7MaUtT6eIRQ7F7IcCOyGz2Eq8SFgt8Mu7LQmRQmCC9jeWhx?=
 =?us-ascii?Q?2UI5E50z4t09kRY9RFte8SLrZPvMmKfD/dZlV1gAsXzXQiI0e/RipvxhKQ3y?=
 =?us-ascii?Q?aSKKcm0gnZ3nz2I2Hys/nljXavyC5J0yHaWQVC5+O2nQ3YgaaoTtiMaQfu2n?=
 =?us-ascii?Q?GHH2JDi67A1sXgenrssx1WUVkQyiBK+dMTQyXJxTvVb6L7040UQIemz6dCrT?=
 =?us-ascii?Q?AlouZFIfU6/B+04xMGZNh6MWRCQwWQvGaOzHtv+lQDSBi8nZvIjieGO29aJP?=
 =?us-ascii?Q?qcZ2tc642Cu2pee4EZ8Oow6ZA6K0aL4=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e025876-3ac8-4e62-4aa2-08df29af8cfb
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB6257.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 04:56:47.2821 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H2X6pCpXIBxpqbig6eGrwYi19Qx09u3iD4zkWo4MJ7WdUK9CJdj+0HRP510U5XSjb0rrKioCe/PWFsMp4g1X8F7P60QNMv2K9/btFJmO9no=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR02MB7213
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=bin.meng@processmission.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Reviewed-by: Bernhard Beschow <shentey@gmail.com>

---

Changes in v4:
- Make the functional test script executable

 MAINTAINERS                               |  1 +
 tests/functional/arm/meson.build          |  2 +
 tests/functional/arm/test_mcimx6ul_evk.py | 69 +++++++++++++++++++++++
 3 files changed, 72 insertions(+)
 create mode 100755 tests/functional/arm/test_mcimx6ul_evk.py

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
new file mode 100755
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


