Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD431C79F80
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 16:16:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2WaH-0004gW-82; Fri, 04 Sep 2026 12:16:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x2WZp-0004NJ-5x; Fri, 04 Sep 2026 12:15:44 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x2WZn-0008SI-Bt; Fri, 04 Sep 2026 12:15:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y+B3RifcILy8rUbFAa6O0+SWlvrxYXdxENbaI6HEfdtgFcvHy/Y9ZPw/Oa+Bhv9lHmjjn1iXZleh+OBftlrAd4B00+snR5GDTN2xKkNiKnIkhM4nDsMiPVMHBxoFs4Pn7Cu+B2gUk0nGuFrV2lKODXRSoscvaUrYjwTOT7jCpVspu2vo6jnGBecyeg6N2fk+y6cfccXBZh+3QAujRCAKhYk6EZUQeeXAUQXhta57LwkUYj37VPFJXrkpXprVea63aaxOrqr9OC1bs9sl9tm6dnhpL0P5yzN8PMhPslgBuOm18KCIFI1GdqiYVHtDm/IEbjn7+122U+awX9yP8EyODg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4EyKuJgR2CHH/Gi8MFjB795lyhkOioSWFK5i3NHhy1U=;
 b=rlZjE8nvsOTdvZ/4ZIFOfiZKR1A8kHw+PP3MH3XSOE1nweMTC4wPCk309SiViiX5BOM6llCcg5rqmDC7+VfdVwcNjqurtIftf51eHI/QCVKHe6/GarXsJQHW3Ec4kxuYdWYsQn1ZPIKlL1xT6e09YsBmM0WGcKyUMS2sHZMRvjR0f3J3Z5iEHvHRmNp9MjP6tYSGKxj5RPeXb7j8IPDfkH3LvDqxxpIJtxhvAgTOwGnxjvHVXKwbU+UbyXf+2G1MIaKJDF5qf0MSSHeTGkGBjjJ96kJ+Gy+TBW/vb+EVuf/E6HFiwIYoLtZqlncjuLo+54yDk9D/Jfw5XQu0W+PiDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4EyKuJgR2CHH/Gi8MFjB795lyhkOioSWFK5i3NHhy1U=;
 b=mgyYMciaGKQ2w4LlA5DKUpbY/h0YAmEsdHCPe0O+XbPTIqZDDnvKcrM3CqO8Esfw5hBc4vhxvkj2bQNrepUbPdeg1sb0MYY9DQe/HU0hmGE8Etk9sijf4e7NA0y+3YbJ9gOu0ZPpqaL8IDwbHQ+UeJRUH0bzL5fABzvKTD8SeX/ap2Py+TJWuzlUVYOgNEGNN2XyCr7bme+2tO75VZx6KFJs3+QzttYBLsbNGfmmliJEollhRxFfRMRsBTqsbZtROFyVsHsBBLtEZgnQJZTl4yOkwL09YtLQHqCPsut0lqxEkyrXyRY3QfVf7MA0E7tj+bpD2GaJQEK2epNLvu8JVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by KU2PPFE04A6CE19.apcprd02.prod.outlook.com (2603:1096:d18::46b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 16:15:36 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0382.007; Fri, 4 Sep 2026
 16:15:36 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Jean-Christophe Dubois <jcd@tribudubois.net>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Subject: [PATCH v2 10/10] tests/functional/arm: Add MCIMX6UL-EVK boot tests
Date: Sat,  5 Sep 2026 00:14:33 +0800
Message-ID: <20260904161438.3838261-11-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904161438.3838261-1-bin.meng@processmission.com>
References: <20260904161438.3838261-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PAZP264CA0120.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1ef::19) To KL1PR02MB4977.apcprd02.prod.outlook.com
 (2603:1096:820:71::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|KU2PPFE04A6CE19:EE_
X-MS-Office365-Filtering-Correlation-Id: 9da79183-3f41-402a-b397-08df0a9fc138
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|22082099003|18002099003|56012099006|3023799007|10067099003;
X-Microsoft-Antispam-Message-Info: lY5u/MQuUuKzeCPRejDB4JFarvMdq1HPosxlWSg6ZLzPN8BHwnUX1sNcjXZEz4d5Aui0gFEOOT21stnXzhVdEOtxZ2fy7+KflRXo9iIeaQ0H7+v1RJWHImJHhX4WzjAJTF9dyCfk0JdXKYtaAKo7UTc/Tk+JoR/Ne/3R0/Ot77w4/zv9iI8xzmWIGJl7VokngCx1ZJxkj/X/kKmTeIpudTbf4T3v/RF2mWL+gpr0cPhBrD7WtUAreVdmDHXgbaNpxv0T937RaL2uo6kfiiif/78UVUry1Nm6OkmquCQXQK70UOMXoF/gjOyEq300R8/JgnpFrqewW3GDXUk/RtoXB9Z0YRDQv1L+OqP4SwetoQm0mZo/oC7jNFiignC63dt+XgNsLpTZgrpbsoc//hVUkvrqqjr749njI5QJxO1kk8DfyN0mc35HbOwEsYzpC59tSwOHl+w5MEacV1p16nSnlmYGNxQWHTONclP5WwJxot+q78/tqLTnFZZR++hVQdPaVthNACbPbVgtypOZDcik45jJnUzflnvlaA78B9Qzd6SofB5XTZ23S2ZzhrYfxoqTg6WUgUuLDj88lS4VLcBjF/Ff5OPd7jf2BsJP3YhZbolVcgz0C9BIA7aTU1Rppqjb3YcFi05Yr11vow+mg/o+bDBDoHU7/GX1QxCunMTLMCc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(22082099003)(18002099003)(56012099006)(3023799007)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2YGt+hLu7j/1DsiUhMCKHUNUcpZuwvK/wF1DTWp1ZsmziEeww+jtoSD3g8Yi?=
 =?us-ascii?Q?rtxDbH9dxhSEQpKyciBJwHQ0drpdEBdrXl4VBuR9NePPqVtZpj21RdvyW7Lv?=
 =?us-ascii?Q?tXfRpMmHyyKPFpKYRmOY/zRm3+BGzExRVEotHDDg9lMw8W5rf8Q+JYjtLEkM?=
 =?us-ascii?Q?jmQ4mHfZtcLcCUtyTLwnkoqD9thMlNARUFuuf7vw9JpntMW3xkyOGYndml09?=
 =?us-ascii?Q?RdqI8t+2cT16gK/YyZvrhAnIs2QVLl3/qhMG8YAJuN8xkyNBEMm6wBb8fagX?=
 =?us-ascii?Q?lqu3Wkuabo5dPsQP+j8xVFTwePlEOULEGlJFD+bBUsJarEodYnKoM2nQRdvy?=
 =?us-ascii?Q?pGDDlKWX9bn6chFfv5ZSbfF9syO+5G6HMjTKydpBIDXB7HkjdcsVpxSD/LIK?=
 =?us-ascii?Q?ksqVBwDhHm0vxPWOP7xOloVvRFy+zx7k9PIl8G/2QcewfSHaQuvoaRT/9FTh?=
 =?us-ascii?Q?Gc02Yu0BPgSFStM+d1jnZdiOuP/r1Eukqv2XxPxtVMpmaJBNo1qR+bWFWCF4?=
 =?us-ascii?Q?Dm+O67fl2HbL29/SKxE/fa8Tp9VhSzXTtv6stkhGmX9utFbuLCtQQ5NIo0DW?=
 =?us-ascii?Q?k2jAspqpiBwydQ/AaI+PpKrh9QSb2t0l1tiFWRdp/AqWaomVwDQbtHM0MnMG?=
 =?us-ascii?Q?NeagQgpKAG9Xrr5Bu0V6ymSrytAgu74VE8Em2aDcdl0rRwjcVLjtJ5Tm5oTN?=
 =?us-ascii?Q?MVAHWnau+7/W0zKUTDy65b/lEFpaVJ66phwgFnhW+fQhefooT2j1GtThhlmj?=
 =?us-ascii?Q?Q5LnImT0iZhikrnqoBHpnlCCr8VckPtTQSamCLJSvSc1K0fAOyl9Rr4bPksF?=
 =?us-ascii?Q?QIWac7K1ZZzr3m/eoEvXUKNV+5Cayadj4+nxFHMRCyxtUOXRvA+ZSIg1tN3O?=
 =?us-ascii?Q?53z/Z5uRARxyk/Kb9doh84E/k1ql24wPUuelF0rUWT+0V43ylnQ9IfKWIkso?=
 =?us-ascii?Q?t0axfX10eYjVDc8B+5s8KFLDuH+xbblwFBSJB5amjEXyp1BUcUf2MybxAX9P?=
 =?us-ascii?Q?2l9813q9iqABuKjir9d31vq4Nq8Dz0s3mazPaAesYB79DF4FUeFfyvb/PFTW?=
 =?us-ascii?Q?ALOOnPEg8AJBhIGwo7fX88Isfskfu4xOR6zch255bXixiaYcuJ4KK19ue7mQ?=
 =?us-ascii?Q?PVq1r5fE/urDUg8uXDHkkpyGYbxANHYaTPkDCkgqLap/cfzuucRNv9t3dNod?=
 =?us-ascii?Q?FDkJDygDhDPj0tjPq4hmTb9jjW9KzFXd9SzJpPeWkzlCUxMrqZ/jcnkZtouC?=
 =?us-ascii?Q?gRYvHASsJBOKle3A+2ckt/Dcm45LNxBP1Y6RcW0kizVXSAT+OOtz29xoyTu7?=
 =?us-ascii?Q?NpJAl4FPLIp74q7GPho/DBFnflGCE0G++49jfU1ZtL7ZbxF4W3k1hZmsemPj?=
 =?us-ascii?Q?UlASXE3rD+V9jVA6AypRoNmSPaJa0zQl69u46RiJAtUfwnUSpYMH/GUzEqK9?=
 =?us-ascii?Q?Pd319E2/iZqap1aKX1T7h0Qj8JyvuiLnsRM1IeOV44JDtGHa4t0t6/JW80bw?=
 =?us-ascii?Q?U3dLSe1oj2AOJ3yyA1orNbX6QYA8N1dWmGXItji1ykfisBYz51yof26B2THh?=
 =?us-ascii?Q?6XZsL+B4JO6T2fnGpnxIsZn5m+CkKLoG7CSQ2oG8d217CArev/lKJVqgK6Kc?=
 =?us-ascii?Q?RBUOX2bHNmpbYVkgpZbqVeKTkJ9gyGLqxWkggyZUw+xm8XQHMVvK8AyCPgHe?=
 =?us-ascii?Q?TE81+UikSv1oZ6sIVJ9UyNKu9sfRA6A0Ubcsxh+ltqtxiKyWOxSo3yv2cFP4?=
 =?us-ascii?Q?WoQTGgGGOFPHYrUyQb9lH346avLK8E8=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9da79183-3f41-402a-b397-08df0a9fc138
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 16:15:36.8868 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 26h17v2AgInmNUl7A5vJbPUposXzR8fdlJ1iD07g207IJPYJC5Dg995LisM1MxLPFyMumBz+nMQ1t6NBb+1lLC2jtFUVF1VRaPH6YhqKx7o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU2PPFE04A6CE19
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

---

(no changes since v1)

 MAINTAINERS                               |  1 +
 tests/functional/arm/meson.build          |  2 +
 tests/functional/arm/test_mcimx6ul_evk.py | 69 +++++++++++++++++++++++
 3 files changed, 72 insertions(+)
 create mode 100644 tests/functional/arm/test_mcimx6ul_evk.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 9590de2509..527f41b39f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -918,6 +918,7 @@ F: include/hw/arm/fsl-imx6ul.h
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


