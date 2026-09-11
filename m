Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60F1CC79FA1
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 05:17:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4tdA-0000kq-QQ; Fri, 11 Sep 2026 01:16:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1x4tc5-00009o-SN; Fri, 11 Sep 2026 01:15:52 -0400
Received: from mail-westusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c000::1] helo=BYAPR05CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1x4tc3-0005kv-EJ; Fri, 11 Sep 2026 01:15:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Apc4NCn+aYrLRoVO5chfDul7QE0otRMD5oKW+cTIZEBVtNkZe0Co4FIPOoYDgZeswRRAKDiL7KVOo9//Isb9Yj7jYUSVgnAvnRkwpJaq2xq82OHCE7sLf0hcIO5bRnIVhlVrd1X7M2pLykV9gF19Ow8T8N4flB0mokQYGk0J4R6PLS81FBIDZWvMfv/Lg1Hr8dgfBVkApO72wjzSagDfXWwyoehQ2227fkVn7WaFVJKB0VZC/c0FxnLOcc3n9xm5FFvxyYUve6i23g+qPC5JHlH/W/aznoQhxI5nbgS/J+fmK0DXVQkTpsI5Faj1J5ixvhCiV2JKnUMzgaQt6IRcNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3WCytHcN4yzaQ71AXRWv9qKmZqHdZh4ZGkeVMP+a7uI=;
 b=x4qp5OVFadmH2bF1UWnaGFvPhZWSljwlS6ISWwSGzQ/mx1FOjoE1lNZx57EVth/6dYDxi4YtiUDD5hvnt2ne3yXXaHf9W/mkY2Bg6sifyDJsUh9xisNO99DmRBffGF7zumlaSu6n1TCF7uCy5CchJqVLmW2LWA7+pWv4T9hisq+m9QWxkcpAdwSATz1NNZrsFBl5Eofj1fCTLTtkY1dDTKNSWHzilR5lB1vTU9othjtvS68gshyvka6Oopo/SGIJaxHQ7VZkJydlgNIm/ydgDfz8D/nMyIQ3JZN3OE+yDwv7eZL5i9GgQ/gQGQzHNb6aqJ75M6O1su/gTPUfpsz5QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3WCytHcN4yzaQ71AXRWv9qKmZqHdZh4ZGkeVMP+a7uI=;
 b=hGzwnRzGt/Xj8HWiKN1XnhI8k8ZpbXLyTxFV8fG2ZFDmTjQEgPrOqAUzeJ5zfdCng/yGasv1mPyZVnEQKsQsQUVwOT4yP9JaHMFpLWytt4M83UILTXB5tYmZsLzwPNr57esBGVoN+/7Wt51YT3nC5X2fKkCSU2h5BwLeZ4uqr7QlFSUdrMA6qD5WXwRVa3evtA0yW/ALJ5kAsV6WrGcjphPOPpLGItbXgtdNVTdVYgBxUijngYhRrtntoIMePiTumVwSEz8uI5bkXNIRJoUSLtmTXdV9DjMWhSdBXkGI8nocbVFpMWRdcnljHvvf3ugB7j9HbMX1mKx2tTTY+0MrfA==
Received: from BN8PR04CA0043.namprd04.prod.outlook.com (2603:10b6:408:d4::17)
 by BN9PR18MB4268.namprd18.prod.outlook.com (2603:10b6:408:11d::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.10; Fri, 11 Sep
 2026 05:15:37 +0000
Received: from BN1PEPF00018070.namprd04.prod.outlook.com
 (2603:10b6:408:d4:cafe::27) by BN8PR04CA0043.outlook.office365.com
 (2603:10b6:408:d4::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.9 via Frontend Transport; Fri, 11
 Sep 2026 05:15:37 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 BN1PEPF00018070.mail.protection.outlook.com (10.167.245.198) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.5
 via Frontend Transport; Fri, 11 Sep 2026 05:15:37 +0000
Received: from axiado.com (unknown [10.4.1.181])
 by smtp.corp.axiado.com (Postfix) with ESMTP id AE23540BFE18;
 Thu, 10 Sep 2026 22:15:35 -0700 (PDT)
From: Kuan-Jui Chiu <kchiu@axiado.com>
To: mark.caveayland@nutanix.com, philmd@oss.qualcomm.com,
 163wangjack@gmail.com, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: Kuan-Jui Chiu <kchiu@axiado.com>
Subject: [PATCH v7 13/13] tests/functional/aarch64: Add functional test for
 Axiado EVKs
Date: Thu, 10 Sep 2026 22:15:32 -0700
Message-Id: <20260911051532.2378501-14-kchiu@axiado.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260911051532.2378501-1-kchiu@axiado.com>
References: <20260911051532.2378501-1-kchiu@axiado.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00018070:EE_|BN9PR18MB4268:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: f9f00c63-5a90-4392-fdc9-08df0fc3b74b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|23010399003|36860700016|376014|18002099003|22082099003|13003099007|10067099003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: ptO3wWLq01W7NJpISQFU1U/tP14/IlWP6PwnqdBszqIm5XEFnlVKroCWTsIOr4RcJxgULG5yoOMv2e12WZ2twYq3Qg0EVs3tugbvX7MoxkxDKOUzYxzaKR0lisZrAhXg30uUa/MQA3cCaU2oKkbb/E85jncbOUHgb8JCNjsGY+yVOOLFr2pXfdudkhyjzIF/EkHD8CGjIn0nNW7FuMi8kDBaizwjxRwbIUlZWPRbBi9L7+xW2eTceecwmsGZTmhmnejZRERle/v1HZ6a0q2klcwR66T/jkPDSjsmuwU5RRfzX2I/XoA7UjeVi0/qS7jVgmkjskVVaU7E5YVPYa57N4ZZnAM9506HRjXt+s5PcmvnRQfZwWs0Z3mB5A229v1/P9zKvknAGmDtI/zYAr6Mnd2OX/IlMmBoE+O6eMn9nPvOlUTpFo2hE5luWTAaw7wzgD7wISU7K1cB9Z1uaep+7gGEy+kKc6dPKt1nliPYBXGQ93nCh3Dnf2dcfZHAM3tke3wECUYsSQ+hHOY4POsNSseV5PbisqDeqz5zaGpVSL/j8tF/VQjBc5Tawu7m401eG00DOZlY95T5oTD09b174GeqRPy7dZkWFRkJbUpUxXuYpZUBrXYbrch0C+mzDLCFzjASCNDcUT8viqsqJwlny3Efpm304fF85EWZ2hi4396xpwA9YCSF3aV9qSX+vOSPqs55drAKlUxxD1DfQ9Qu+A==
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(23010399003)(36860700016)(376014)(18002099003)(22082099003)(13003099007)(10067099003)(56012099006)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: swWNzqRcSosI8g+Xso/hh5ZzxvXmnxJm7wl3Lriyi44UTZAZdkER74Nmrr7hnR92pDbza+/K1ltlKdH3TTlbeepLP3e0EBeOJ8lYH77XSWSdUmONRsRGLi9ctmnQ05yLkpJZyfn8EymYMKcI0rBGvXqc9iR0z0/6Ay4Q9aqGLMbF0LdNS43KOVNKs7Ud2g4LaHXeQl+b0JvnkSdCJw+ECD7YOVMOXErwMsioUWWaoaIE9aSyxQt4JKfwEE0qDmQlZI0pk+Oh1MWsc6PMR5RHmhs8rlMrciFl9SnxR0MxZ3MrSrP0vZMr1NJDSpHB3PuQyFYx6qxycinOxm43eOLz+O266jzPsCKQK3E6QPQqwWP13huUzS5Y39euUKSGX/46UoWFoVTvBlC2CojWE4z4zzfvIxBRe/NDCgVxYS6Bfsn+s2S03q0TgW5wVdgQkz82
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 05:15:37.6479 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9f00c63-5a90-4392-fdc9-08df0fc3b74b
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00018070.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR18MB4268
Received-SPF: pass client-ip=2a01:111:f403:c000::1;
 envelope-from=kchiu@axiado.com;
 helo=BYAPR05CU005.outbound.protection.outlook.com
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

Introduce funtional test for boot process from the kernel to systemd

Add additional subtest to include ARM TrustedZone firmware into boot
process for ax3005-evb model

Signed-off-by: Kuan-Jui Chiu <kchiu@axiado.com>
---
 MAINTAINERS                                   |   2 +
 tests/functional/aarch64/meson.build          |   4 +
 tests/functional/aarch64/test_ax3005_evb.py   | 140 ++++++++++++++++++
 .../functional/aarch64/test_axiado_scm3003.py |  62 ++++++++
 4 files changed, 208 insertions(+)
 create mode 100755 tests/functional/aarch64/test_ax3005_evb.py
 create mode 100755 tests/functional/aarch64/test_axiado_scm3003.py

diff --git a/MAINTAINERS b/MAINTAINERS
index d55f259a36..bbc58cfcad 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1311,6 +1311,8 @@ F: hw/*/axiado*.c
 F: include/hw/arm/ax3000*.h
 F: include/hw/arm/ax3005*.h
 F: include/hw/*/axiado*.h
+F: tests/functional/arm/test_axiado_scm3003.py
+F: tests/functional/arm/test_ax3005_evb.py
 F: docs/system/arm/axiado.rst
 
 AVR Machines
diff --git a/tests/functional/aarch64/meson.build b/tests/functional/aarch64/meson.build
index f0881bed16..3e3d918486 100644
--- a/tests/functional/aarch64/meson.build
+++ b/tests/functional/aarch64/meson.build
@@ -4,6 +4,8 @@ test_aarch64_timeouts = {
   'aspeed_ast2700a1' : 600,
   'aspeed_ast2700a2' : 600,
   'aspeed_ast2700fc' : 600,
+  'ax3005_evb' : 180,
+  'axiado_scm3003' : 240,
   'device_passthrough' : 720,
   'imx8mm_evk' : 240,
   'imx8mp_evk' : 240,
@@ -33,6 +35,8 @@ tests_aarch64_system_thorough = [
   'aspeed_ast2700a1',
   'aspeed_ast2700a2',
   'aspeed_ast2700fc',
+  'ax3005_evb',
+  'axiado_scm3003',
   'device_passthrough',
   'hotplug_pci',
   'imx8mm_evk',
diff --git a/tests/functional/aarch64/test_ax3005_evb.py b/tests/functional/aarch64/test_ax3005_evb.py
new file mode 100755
index 0000000000..f240e667d4
--- /dev/null
+++ b/tests/functional/aarch64/test_ax3005_evb.py
@@ -0,0 +1,140 @@
+#!/usr/bin/env python3
+#
+# Functional test that boots an OpenBMC image on the Axiado AX3005 EVB
+#
+# Author: Kuan-Jui Chiu <kchiu@axiado.com>
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from qemu_test import LinuxKernelTest, Asset, wait_for_console_pattern
+
+
+class Ax3005EvbMachine(LinuxKernelTest):
+
+    ASSET_SDK_IMAGES = Asset(
+        ('https://github.com/axiado/openbmc/releases/download/v0.1.0/'
+         'evk-ax3005-qemu.tar.gz'),
+        'e07e89151981fb4730223dfe399a7111a0367e3c4122e21d65ef4aa8a2ba04c7')
+
+    ATF_BASE = 0x88300000
+    OPTEE_BASE = 0x88400000
+    UBOOT_BASE = 0x80000000
+    FIT_BASE = 0x80100000
+    RAMROFS_BASE = 0x80B00000
+    RAMROFS_SIZE = 0x6400000
+
+    def setUp(self):
+        super().setUp()
+
+        SDK_IMAGE_DIR = 'evk-ax3005-qemu'
+
+        self.archive_extract(self.ASSET_SDK_IMAGES)
+        self.atf_path = self.scratch_file(SDK_IMAGE_DIR,
+                                          'trusted-firmware-a/bl31.bin')
+        self.optee_path = self.scratch_file(SDK_IMAGE_DIR, 'optee/tee-raw.bin')
+        self.uboot_path = self.scratch_file(SDK_IMAGE_DIR, 'u-boot.bin')
+        self.fit_path = self.scratch_file(SDK_IMAGE_DIR, 'fitImage')
+        self.kernel_path = self.scratch_file(SDK_IMAGE_DIR, 'Image')
+        self.dtb_path = self.scratch_file(SDK_IMAGE_DIR, 'ax3005-evb-qemu.dtb')
+        self.initrd_path = self.scratch_file(
+            SDK_IMAGE_DIR, 'obmc-phosphor-initramfs-evk-ax3005-qemu.cpio.xz')
+        self.rofs_path = self.scratch_file(
+            SDK_IMAGE_DIR, 'obmc-phosphor-image-evk-ax3005-qemu.squashfs-xz')
+        self.disk_path = self.scratch_file(
+            SDK_IMAGE_DIR, 'obmc-phosphor-image-evk-ax3005-qemu.wic.qcow2')
+
+    def test_aarch64_ax3005_evb_boot(self):
+        self.require_accelerator('tcg')
+        self.set_machine('ax3005-evb')
+
+        self.RAMROFS_BASE = 0x90000000
+
+        # The SoC has nine Cadence UARTs; the console is the fourth one.
+        self.vm.set_console(console_index=3)
+        self.vm.add_args(
+            '-kernel', self.kernel_path,
+            '-dtb', self.dtb_path,
+            '-initrd', self.initrd_path,
+            '-device', 'loader,file=%s,addr=0x%x' % (self.rofs_path,
+                                                     self.RAMROFS_BASE),
+            '-drive', 'file=%s,if=sd,format=qcow2,snapshot=on' % self.disk_path,
+            '-append', 'console=ttyPS3,115200 earlycon nr_cpus=1 '
+                       'root=/dev/ram rw '
+                       'phram.phram=ramrofs,0x%x,0x%x' % (self.RAMROFS_BASE,
+                                                          self.RAMROFS_SIZE))
+
+        self.vm.launch()
+
+        self.wait_for_console_pattern('Linux version')
+        self.wait_for_console_pattern('Machine model: Axiado AX3005 EVB QEMU')
+
+        # The reservation comes from the board's modify_dtb() hook, not from
+        # the supplied DTB, which still carries the old address.
+        self.wait_for_console_pattern(
+            'OF: reserved mem: 0x0000000090000000..0x00000000963fffff')
+
+        # phram claims the reserved window and exposes it as an MTD device.
+        wait_for_console_pattern(
+            self, 'phram: ramrofs device: 0x6400000 at 0x90000000',
+            failure_message='phram: Failed to register new device')
+
+        self.wait_for_console_pattern('Run /init as init process')
+
+        # The initramfs prints this after probing the SD card for the rwfs.
+        self.wait_for_console_pattern('blkdev: /dev/mmcblk0 sector_size: 512')
+
+        # Reaching systemd proves the initramfs mounted the squashfs out of
+        # the phram window and switch_root'ed into it.
+        self.wait_for_console_pattern('Hostname set to <evk-ax3005-qemu>')
+
+    def test_aarch64_ax3005_evb_tzboot(self):
+        self.require_accelerator('tcg')
+        self.set_machine('ax3005-evb')
+
+        # The SoC has nine Cadence UARTs; the console is the fourth one.
+        self.vm.set_console(console_index=3)
+        self.vm.add_args(
+            '-device', 'loader,file=%s,addr=0x%x' % (self.atf_path,
+                                                     self.ATF_BASE),
+            '-device', 'loader,file=%s,addr=0x%x' % (self.optee_path,
+                                                     self.OPTEE_BASE),
+            '-device', 'loader,file=%s,addr=0x%x' % (self.uboot_path,
+                                                     self.UBOOT_BASE),
+            '-device', 'loader,file=%s,addr=0x%x' % (self.fit_path,
+                                                     self.FIT_BASE),
+            '-device', 'loader,file=%s,addr=0x%x' % (self.rofs_path,
+                                                     self.RAMROFS_BASE),
+            '-device', 'loader,cpu-num=0,addr=0x%x' % self.ATF_BASE,
+            '-device', 'loader,cpu-num=1,addr=0x%x' % self.ATF_BASE,
+            '-device', 'loader,cpu-num=2,addr=0x%x' % self.ATF_BASE,
+            '-device', 'loader,cpu-num=3,addr=0x%x' % self.ATF_BASE,
+            '-drive', 'file=%s,if=sd,format=qcow2,snapshot=on' % self.disk_path)
+
+        self.vm.launch()
+
+        self.wait_for_console_pattern('BL31: Initializing BL32')
+        self.wait_for_console_pattern('OP-TEE version:')
+        self.wait_for_console_pattern('Primary CPU switching to normal world')
+
+        self.wait_for_console_pattern('U-Boot 2026.04')
+        self.wait_for_console_pattern('Starting kernel')
+
+        self.wait_for_console_pattern('Linux version')
+        self.wait_for_console_pattern('Machine model: Axiado AX3005 EVB QEMU')
+
+        # phram claims the reserved window and exposes it as an MTD device.
+        wait_for_console_pattern(
+            self, 'phram: ramrofs device: 0x6400000 at 0x80b00000',
+            failure_message='phram: Failed to register new device')
+
+        self.wait_for_console_pattern('Run /init as init process')
+
+        # The initramfs prints this after probing the SD card for the rwfs.
+        self.wait_for_console_pattern('blkdev: /dev/mmcblk0 sector_size: 512')
+
+        # Reaching systemd proves the initramfs mounted the squashfs out of
+        # the phram window and switch_root'ed into it.
+        self.wait_for_console_pattern('Hostname set to <evk-ax3005-qemu>')
+
+if __name__ == '__main__':
+    LinuxKernelTest.main()
diff --git a/tests/functional/aarch64/test_axiado_scm3003.py b/tests/functional/aarch64/test_axiado_scm3003.py
new file mode 100755
index 0000000000..d18cc7795f
--- /dev/null
+++ b/tests/functional/aarch64/test_axiado_scm3003.py
@@ -0,0 +1,62 @@
+#!/usr/bin/env python3
+#
+# Functional test that boots an OpenBMC image on the Axiado SCM3003 EVK
+#
+# Author: Kuan-Jui Chiu <kchiu@axiado.com>
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from qemu_test import LinuxKernelTest, Asset, wait_for_console_pattern
+
+
+class AxiadoScm3003Machine(LinuxKernelTest):
+
+    ASSET_SDK_IMAGES = Asset(
+        ('https://github.com/axiado/openbmc/releases/download/v0.1.0/'
+         'evk-axiado-qemu.tar.gz'),
+        'a163b78ed07a43e08323395e2df63c213fbc98b8bc412083a11e94564e26548b')
+
+    def setUp(self):
+        super().setUp()
+
+        SDK_IMAGE_DIR = 'evk-axiado-qemu'
+
+        self.archive_extract(self.ASSET_SDK_IMAGES)
+        self.kernel_path = self.scratch_file(SDK_IMAGE_DIR, 'Image')
+        self.dtb_path = self.scratch_file(SDK_IMAGE_DIR,
+                                          'ax3000-scm3003-qemu.dtb')
+        self.initrd_path = self.scratch_file(
+            SDK_IMAGE_DIR, 'obmc-phosphor-initramfs-evk-axiado-qemu.cpio.xz')
+        self.disk_path = self.scratch_file(
+            SDK_IMAGE_DIR, 'obmc-phosphor-image-evk-axiado-qemu.wic.qcow2')
+
+    def test_aarch64_axiado_scm3003_boot(self):
+        self.require_accelerator('tcg')
+        self.set_machine('axiado-scm3003')
+
+        # The SoC has four Cadence UARTs; the console is the fourth one.
+        self.vm.set_console(console_index=3)
+        self.vm.add_args(
+            '-kernel', self.kernel_path,
+            '-dtb', self.dtb_path,
+            '-initrd', self.initrd_path,
+            '-drive', 'file=%s,if=sd,format=qcow2,snapshot=on' % self.disk_path,
+            '-append', 'console=ttyPS3,115200 earlycon nr_cpus=1 '
+                       'rootwait root=PARTLABEL=rofs-a')
+
+        self.vm.launch()
+
+        self.wait_for_console_pattern('Linux version')
+        self.wait_for_console_pattern('Machine model: Axiado AX3000-SCM3003')
+
+        self.wait_for_console_pattern('Run /init as init process')
+
+        # The initramfs prints this after probing the SD card for the rwfs.
+        self.wait_for_console_pattern('blkdev: /dev/mmcblk0 sector_size: 512')
+
+        # Reaching systemd proves the initramfs mounted the squashfs out of
+        # the phram window and switch_root'ed into it.
+        self.wait_for_console_pattern('Hostname set to <evk-axiado-qemu>')
+
+if __name__ == '__main__':
+    LinuxKernelTest.main()
-- 
2.34.1


