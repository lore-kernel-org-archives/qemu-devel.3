Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010AA606A320
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 07:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=axiado.com header.i=@axiado.com header.a=rsa-sha256 header.s=selector1 header.b=WyHR2Ggq
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTwN7-0004N3-O3; Thu, 19 Nov 2026 02:15:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1xTwLb-00032n-Df; Thu, 19 Nov 2026 02:14:21 -0500
Received: from mail-eastus2azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c110::3] helo=BN8PR05CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1xTwLU-0004Ki-Vs; Thu, 19 Nov 2026 02:14:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y8RGjV4qGLibM9o8fUvzHKQlA5h90g6xNUbQI7N7R6yUp3f1sjVcftbG1YRUsKarlX6ZCVIoVgRBVpWGpU45JR/502ZlfEcE4GSnh250LQHctQvbEz+imanKIGelt8/zLhE7DU7fk7fOhSRzaKHD5MXkXSn/00v+YbRxBVepdf9rQwleqqhLb//mLGuSGymObwI5gNTk47Nq4TAMKAhTk/doX4VmOu+5tiRC8C46G2VAuU1uCkPHGpj76zSIWVNJKqq+GxGPV8WZv0Xl6WGsJduqCsuVUJ9JrxBvTe4r3eVlwPlxwuSuZa/F6VahtcgDwyslUSgbVgP9yXkAPSjE0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QyGTO8HFkCr42AlG0oUck+6+PJ07QAYqRMJhZZSWrYU=;
 b=RAfMsiSdoEr4W48D95KtxTJ8shK9yBBoHrubnCieZvF0DqMnagWFdXy/QdpKjfzyZNOQC+iBS1EYXTrpwE0AbJqELbeFpCmxWvIooroDSsn3gly7eXqMyjKkh0e/8zoBRRsMbNEKBb7b8QKhnMzTIjr73ScEo/rYZjHONsEocjJr2HuXlUyRgYWmRq7KENztmftovP5bH7G7It+ZeyaENYugIFVghwpxZkXpeJielvCjDz3UZ0oE/y/JS2oMDvYeBHS9zhrIe2um9mvGzuOZVVjz1MUb7vSGFs441dAnIIutkE5CJ4IRydwokCKvfXWVTSEsKCI5iSMTt+t4MTpfCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QyGTO8HFkCr42AlG0oUck+6+PJ07QAYqRMJhZZSWrYU=;
 b=WyHR2GgqeHWyxGteEyc6guocTYpaXg8tm++ZvYjYTBNzXvWR4rT/Xorqf77ASGO9Q83Tnu9RjvkL+/cTnppObqA56hygbBomLU4KUmBf2GI+mSbjJOshwxvPPbr1GjId9nsXD/bRh6f7vrr01M3+SZz0P1bdjALNzTSmS40Rfxvmww5o0QuJl+sBzwMPb5xQ3ouQ5TIAa+uAYPH822nVUTwLngJBeqEzJyN2X5dxFtCjz5HIcBO8Nkp4YAXQkyMG5NF0swqZJR369drtRSNgXniLHLL1P9btOKTrpGApvPZMRHBNOUk8UC3nTO2/LoEQTotv0wbyX4KNpHgKMXjWZw==
Received: from CY5PR13CA0127.namprd13.prod.outlook.com (2603:10b6:930:9::40)
 by PH0PR18MB999692.namprd18.prod.outlook.com (2603:10b6:510:122::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 07:14:02 +0000
Received: from CY8PEPF0000005B.namprd21.prod.outlook.com
 (2603:10b6:930:9:cafe::77) by CY5PR13CA0127.outlook.office365.com
 (2603:10b6:930:9::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.10 via Frontend Transport; Thu,
 19 Nov 2026 07:14:02 +0000
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
 via Frontend Transport; Thu, 19 Nov 2026 07:14:02 +0000
Received: from axiado.com (unknown [10.4.1.181])
 by smtp.corp.axiado.com (Postfix) with ESMTP id 19A7740BFE18;
 Wed, 18 Nov 2026 23:14:00 -0800 (PST)
From: Kuan-Jui Chiu <kchiu@axiado.com>
To: 
Cc: Kuan-Jui Chiu <kchiu@axiado.com>, mark.caveayland@nutanix.com,
 philmd@oss.qualcomm.com, 163wangjack@gmail.com, peter.maydell@linaro.org,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
Subject: [PATCH v8 13/13] tests/functional/aarch64: Add functional test for
 Axiado EVKs
Date: Wed, 18 Nov 2026 23:13:53 -0800
Message-Id: <20261119071355.3520249-14-kchiu@axiado.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261119071355.3520249-1-kchiu@axiado.com>
References: <20261119071355.3520249-1-kchiu@axiado.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PEPF0000005B:EE_|PH0PR18MB999692:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 39e1a1b9-5c8e-4fd1-d665-08df460cb071
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|23010399003|1800799024|376014|18002099003|22082099003|6133799003|261009223027099003|13003099007|260925021911599003|260925021311599003|56012099006|261026121527099003|261026140227099003|260925022911599003|261102123227099003|261028144727099003|261021121427099003|261022075727099003|261021123027099003|261022115727099003|261022105027099003|10067099003;
X-Microsoft-Antispam-Message-Info: UFf0SUPtagfICrQujVtolkhmKYHPZL4DEW6i/qfBVGqK5YEabThqxkyvSbZto4ZqPPiKLJfz3chPf7+De8dU+cdxZeLLUdhbHbLLMNYqJXS+vT+fWQ3VwyIOeCuFtkekdK+kMxyp9A7y7XPWoLR34c98T+1InXbVVfqB5JPGhPdUEy0V/7u5tcMZS6jadqQ14BCNq3wiQJFgfKdixmvXV2qzEWjo1Qw39RYDJxiz+dHeX1hm0qT1Pmj+ZWkLgFshv6QN9DAhHA8zLeuQLToviMQBuqQkZD2Z9f+TkB4Y597Voqgi9cwItqojCDfUm/a+PEpn6SaTwoj4p1Qau3NuNi7vy3hYNJO95GQNQcPTJQS0EVGycsShAyRpifexbByr7PYEIiAL2VYOKLA6gKewUdc3jVjd6D9608/x4CbgJyjEe5yTVaNfVNFH4etQPmswNJg/W1NDSz5TND39X4Uepkoa11XCw8QeLYqpvOqtyhAY+JnVNsvSEQaXzx8Z1zLEykNKBqmrgBhGKulVxhzbHN0kGqLjL8rf9Qw+7VP6aZTHCihtl3xvnJahj+RiXw0FKVVf+qZLOY59t/brqxSUzozcLGqpMB14hMmm2STf+DahINNRfqmsxMWhC+B8eqibeHY+2hT+ZcP/LDrQDN0BR7L/uwnpjww0Sjx9QiH7IK7ibKiPt3J/voBmSoUVDKfzVFzrVfGQem1apKD7v2AHkw==
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(23010399003)(1800799024)(376014)(18002099003)(22082099003)(6133799003)(261009223027099003)(13003099007)(260925021911599003)(260925021311599003)(56012099006)(261026121527099003)(261026140227099003)(260925022911599003)(261102123227099003)(261028144727099003)(261021121427099003)(261022075727099003)(261021123027099003)(261022115727099003)(261022105027099003)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vzprqCHq1od+IEZhOBkS9EprinVNvcy7Jzner8HGXQvnMJ4gDr+hRxwr4AyWlHx0UDlzsAxEopx/hFIQyTMp0GR9Q4frUZYmnNcFdj8umzA+wRlrardfhIA4r79jV+XD60CF6itVu4gCHfwJ88GSQcDnEQKQQvkmdS4xsYurT/iOlcYZZqunV362ovQi6rjIYkVG7xp7aN4hczNnvrw1wSCVplSCs1Dn/miFfAwe7lWgl0qT2Y6B2YDOJYyDfmQUXuL6zPTIfTI4YCtWAjc2dRumpaMCyPqimJ+2gnnVMYh4caDpVkcZWR/dT3lSVQco/ZdX4VSwHVsYu0oIrb0i99XpG8GhqPaY68iOrjU0cEs+wRAr6Un+GETLzjR9q9lmvrqrlj0xo9gyfz3zOxhpXEL94gcivRT7jE22TidZpn8x9AnX4eBJCYtpsHKWC9Dm
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 07:14:02.1882 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39e1a1b9-5c8e-4fd1-d665-08df460cb071
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: CY8PEPF0000005B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR18MB999692
Received-SPF: pass client-ip=2a01:111:f403:c110::3;
 envelope-from=kchiu@axiado.com;
 helo=BN8PR05CU002.outbound.protection.outlook.com
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
index 53e15069ed..297c8685d6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1333,6 +1333,8 @@ F: hw/*/axiado*.c
 F: include/hw/arm/ax3000*.h
 F: include/hw/arm/ax3005*.h
 F: include/hw/*/axiado*.h
+F: tests/functional/aarch64/test_axiado_scm3003.py
+F: tests/functional/aarch64/test_ax3005_evb.py
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
index 0000000000..5ca75b1599
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
+        sdk_image_dir = 'evk-ax3005-qemu'
+
+        self.archive_extract(self.ASSET_SDK_IMAGES)
+        self.atf_path = self.scratch_file(sdk_image_dir,
+                                          'trusted-firmware-a/bl31.bin')
+        self.optee_path = self.scratch_file(sdk_image_dir, 'optee/tee-raw.bin')
+        self.uboot_path = self.scratch_file(sdk_image_dir, 'u-boot.bin')
+        self.fit_path = self.scratch_file(sdk_image_dir, 'fitImage')
+        self.kernel_path = self.scratch_file(sdk_image_dir, 'Image')
+        self.dtb_path = self.scratch_file(sdk_image_dir, 'ax3005-evb-qemu.dtb')
+        self.initrd_path = self.scratch_file(
+            sdk_image_dir, 'obmc-phosphor-initramfs-evk-ax3005-qemu.cpio.xz')
+        self.rofs_path = self.scratch_file(
+            sdk_image_dir, 'obmc-phosphor-image-evk-ax3005-qemu.squashfs-xz')
+        self.disk_path = self.scratch_file(
+            sdk_image_dir, 'obmc-phosphor-image-evk-ax3005-qemu.wic.qcow2')
+
+    def test_aarch64_ax3005_evb_boot(self):
+        self.require_accelerator('tcg')
+        self.set_machine('ax3005-evb')
+
+        ramrofs_base = 0x90000000
+
+        # The SoC has nine Cadence UARTs; the console is the fourth one.
+        self.vm.set_console(console_index=3)
+        self.vm.add_args(
+            '-kernel', self.kernel_path,
+            '-dtb', self.dtb_path,
+            '-initrd', self.initrd_path,
+            '-device', 'loader,file=%s,addr=0x%x' % (self.rofs_path,
+                                                     ramrofs_base),
+            '-drive', 'file=%s,if=sd,format=qcow2,snapshot=on' % self.disk_path,
+            '-append', 'console=ttyPS3,115200 earlycon nr_cpus=1 '
+                       'root=/dev/ram rw '
+                       'phram.phram=ramrofs,0x%x,0x%x' % (ramrofs_base,
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
index 0000000000..4d80931b4d
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
+        sdk_image_dir = 'evk-axiado-qemu'
+
+        self.archive_extract(self.ASSET_SDK_IMAGES)
+        self.kernel_path = self.scratch_file(sdk_image_dir, 'Image')
+        self.dtb_path = self.scratch_file(sdk_image_dir,
+                                          'ax3000-scm3003-qemu.dtb')
+        self.initrd_path = self.scratch_file(
+            sdk_image_dir, 'obmc-phosphor-initramfs-evk-axiado-qemu.cpio.xz')
+        self.disk_path = self.scratch_file(
+            sdk_image_dir, 'obmc-phosphor-image-evk-axiado-qemu.wic.qcow2')
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


