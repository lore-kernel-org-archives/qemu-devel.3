Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE872C61DD6
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 10:24:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1i8l-0004V2-S2; Wed, 02 Sep 2026 06:24:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1x1i8k-0004Su-2U; Wed, 02 Sep 2026 06:24:22 -0400
Received: from mail-westus2azlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c005::5] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1x1i8h-00076d-I7; Wed, 02 Sep 2026 06:24:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ao4kLk8ievRh781zTqFrfWB2Q6K77IYMi1CFeb5sOnu1Ms9QQBykzzTIeTY9CU6xuS6g2njz86y/K8olXCepQhU7WQaewvIuDeuLT8rRIBgEmqijNCAHb91r8O6z2KetpfpDaEUhKKVAND8UxrkZ3IIiazMgY9xQ6XhfM5EHdg64TyeU2Xyh+84v4QqojNmEgPtBfo0gQ8HthUw4OpFsscxvmpeDYq7hrRXY/unUx4l6HNXzzIE3r8qN8p2BJMMfrVgMDDbFBXEjiwAN5T8B6mfZtZBzjQdfuyhsU+DGj7Z9rsISRc5WrLU7Yep7dM2ps1fWv3os08JGWDbFOOPdQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uKSEWyakXctqj/xn0xX2OTgr0amMWF6FZvakTWaQd+w=;
 b=TUORdeJzYRs1SBtd9tPNvfauPd2cThwCR8BClezvg9T4C79J36k/2f5N3jhsjc8SdFb0+hz4Od2S0oMbMlMwcsGYK3ogxliKuKYtQEbJxxMS184H1hjKxDQi3bfFtBpTXPDd/XQ43DF7ntmi+yqfcjlF5IMAemqJxGITixuSVzAWTOnug+ar9ffEZpmbxPOe+HzYQGJzI3aUUoYcA47xFfZCGQ56n/rQxgx+NVhFbRznK3mkdJvSIW9vvB2zHkBumVO+wu0EACDUZg/qjSUSrucpRi+SGxfYAZXiK0byr9n9X/f573OdpUf1Nzq29PdYevyAWDNPMRukn0pm8PFt7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uKSEWyakXctqj/xn0xX2OTgr0amMWF6FZvakTWaQd+w=;
 b=dZYQsv9Rkcl40kCCHpLkz5z3mOdSbpt30VK3Kjt+M1pJiwmWg2fNaAixvZY+7Pa4zPH3B+P/y3DpghtevzZUdZgl+hiXUNg6OktuhSZs0J6zaPR+dUkLxJ9VGxSVMddzvzfjfE8Yj97r7kmWlh7XNC0WzngG17NVwEL/TqZQElTyQm4CbwmfeJAsWRxSlR8WoWOC7BAxHBOnIjwkfk45tIPstvXNvSa+HrrIN8+WrOv4X3d9s/u5ivnKpHaBi2cwIuwonQ8VgU4TCd7uPQvaO5+eN2Ukn24A0Jrx2DzUhipncdWFA9S6aNJ6bN3KzgKXF4qOmbDntfiODCp5LHdiQA==
Received: from SN7PR04CA0029.namprd04.prod.outlook.com (2603:10b6:806:f2::34)
 by SN7PR18MB5316.namprd18.prod.outlook.com (2603:10b6:806:2dd::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 10:24:12 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10b6:806:f2:cafe::99) by SN7PR04CA0029.outlook.office365.com
 (2603:10b6:806:f2::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Wed, 2
 Sep 2026 10:24:12 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.8
 via Frontend Transport; Wed, 2 Sep 2026 10:24:12 +0000
Received: from axiado.com (unknown [10.4.1.181])
 by smtp.corp.axiado.com (Postfix) with ESMTP id AC5BD4186B53;
 Wed,  2 Sep 2026 03:24:11 -0700 (PDT)
From: Kuan-Jui Chiu <kchiu@axiado.com>
To: philmd@oss.qualcomm.com, 163wangjack@gmail.com, qemu-devel@nongnu.org,
 peter.maydell@linaro.org, qemu-arm@nongnu.org
Cc: Kuan-Jui Chiu <kchiu@axiado.com>
Subject: [PATCH v5 13/13] tests/functional/aarch64: Add functional test for
 Axiado EVKs
Date: Wed,  2 Sep 2026 03:24:08 -0700
Message-Id: <20260902102408.3039411-1-kchiu@axiado.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|SN7PR18MB5316:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 84d73752-fedf-490f-5ce2-08df08dc551c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|23010399003|376014|18002099003|13003099007|6133799003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: p1o6Qa38uFsEefOR5OtshO2WG8nIDqG1l4iBD1utEEKrHLZjNd1O0V1NRdTt2ib++X3HJiu+2U2/NPGsc6Rn14fMbhbjbhYvMAo92RKfNtBcdR3ZCbBxiQpn10otN7RQknEZWSJTKKrYqavgjm5GLoYH0tMfH1xkfxl7P1QAZeDjSq2+Mhq7i4KdL/n8yP3uhOm8cYjq6gkt8mydFBIXjcdk31EQpGaMVqCAHF1DsI9txWJ6xZstLG8xHBhN+Gc9kLi/nuobfpfSPkPjyXHqIjivrq04ArlGpSfKzlfTfV/NsweFNoNbbaNE0atY6cgCc6QmpL++aBieuh/0kWpN03Bh4YCW2KZi899+kNkBjS6KryRVj0thHm1JlGc+ZH/VdVWHI+WnO4ijLKcwoiYZIP/BL+fmVVj9EHGxZ7mRh/evWH6KsOz/T5FGRZUSFS44ECaJMBb3Hnsfnhvd+k025t8xT9qtcQD4B5hge5HA0FqvLrwb8BgevbWR3CLAKtzr/lA0IY7jylM4Cm88MdEUMvlFgt77pHK3jxQfUGpIl+PjlOBMoSEtgcVLSfAG4pNSq6g1ouZTgI9oRGcOmXmisMpO04givSuTnxq6BS7AIgSnRfnSjZLEFqvMEkUQjkINsCUv5deCFeVuugBcDQ8EwE/9D1wfGt+wBFcEBaqLVRp7QqpGypjQ5zbpRI06pRsPRX9Vkr3uzV/PW7zaFvNC3w==
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(23010399003)(376014)(18002099003)(13003099007)(6133799003)(56012099006)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LxvZWuRJfZNwpU6R5QtlG7Q7v3x8jqeKqxmIRrtIXz845JZDznltyFt027GRDtVECNLJ34X+Upss0ERj6GdLXRUhC/QdMd8gM2JMO/PP1xYcK/UARQObtx8KDqXhgIYDys7TG5x7ITLOIbIgkyQFRJxFlfX1pPblBDMlXsujzps9QwkuEoLC3uu4mpEeNO6ICFJhQ2cbR30Emq+5Axey6gob7ipwmUtpwq6INZFM5oRZwrOyofzan9HGpFhVRfxjiW6ko0U8qHvDCUHvYTw42B6Cgf4/BoE7rwuX8laUDMJ7cZprc/xGZHAdWVt2KvM5LKUbXq9REJuKot1WfRiRYVPcg836jOmikQzgG3NyA3gGfNxJVPyRWbyE5fB3ZGxLRdCCU59hadJN4ziL4Ml7EcZxY+h32J2/suVu3RSFiknkDxyHlzFbI6zuLKaNsHc7
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 10:24:12.2398 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84d73752-fedf-490f-5ce2-08df08dc551c
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR18MB5316
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
index baa2d2efbb..64dbfc5078 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1319,6 +1319,8 @@ F: hw/*/axiado*.c
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


