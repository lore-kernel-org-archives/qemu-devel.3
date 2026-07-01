Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E801C43327
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 10:21:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wes33-0004re-Gq; Wed, 01 Jul 2026 06:20:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wes31-0004nf-L2
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 06:20:03 -0400
Received: from mail-dl1-x1234.google.com ([2607:f8b0:4864:20::1234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wes2z-00052G-Hx
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 06:20:03 -0400
Received: by mail-dl1-x1234.google.com with SMTP id
 a92af1059eb24-13b392c721cso49438c88.0
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2026 03:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782901200; x=1783506000; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dUOpRDTToMD5PsAczk1hbVZqaMH7r1LSgV3yyuN2LIU=;
 b=D+duxDdBG4r/6uJwIFIt7cuB+E4JY4BE6bLq41WFMFJg86T8e7NOyOxS7a9QyM0kue
 EfIEyNkIePWqOH2bSIAUGP6yyxzW0cKMxp1hhrb5jCEwZfER5HTXa39vhAWoHnTSnZyJ
 Afcupyv8OphvUhqsy77kujAEsG6kiCoqZ3PJqhv1mDqHhdljPrK42AhebzQFn5MRbdft
 tpWL4WL5gxD+XUStbAnkr/L+TjiQvErgoObyplofNeSVE7xpjTDfbnAsLmHzCvofKEbk
 Rp9rl1R4tKKm7KhnRR3YsBROxNtaVYx2bz1MVLbgqWZFlP2Ic9Wod4U01f1Gm+md1uow
 mj9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782901200; x=1783506000;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dUOpRDTToMD5PsAczk1hbVZqaMH7r1LSgV3yyuN2LIU=;
 b=USoJhV5X164ZVaWUrs8Je0kIGmQVVD6ohM6xisWb6OyEt5g0iLqkqnA65yzDLCvN2j
 SW85D9JGngdOZXqj+O8BKLwt1+5gwmBscw2y7pVMK5VvVHebow20xF8gmHF5mNsWBAJh
 7VrM3q+3EChcJ64fuaWFgml9Qtky1oeB7r3+OFLCnRHfyfr0O7dzKpSTKsliA2pFN/N/
 4Y28GokSAlkOZHmUrwkKWc122z0BB+9ge/jXrBzgSsid7PPvDrOqKLkXlWJmoXjVLGRq
 WDwe3Ow2M8InJ8hM7Utk9fQRbZzUsVjJnVAjsGTUcUGb7C8OGl6/rsZm0Ibdpqw+4l1Q
 iduw==
X-Gm-Message-State: AOJu0Yy4xN1pv6nVZ7GvusBssvVsbmk62dfKBeSeZxWfVkVYjmB5cm1P
 TmqSulNa3L4XY+jARWYozWn2ncExB7RDOC7FQgqLg67MYc+dFxZDNHlXnhnZzQ==
X-Gm-Gg: AfdE7cmFZHJudUAPhq4V1IkbRSIIaFbqphjT+CWKOYX0KRNlksVk3gvL2Vw5yIiFdN0
 Ez0h1mvM2L5c+qEcWjJxTCIwPQy+hiqN/S6jR15G1u5Vj1gPkOkviLG7RmL7W0QqpX2JVh5NWU5
 X1cFg0x4nmoQytM9B3J1CXTbNTXbS1QZLlvBLgx1dbuwYI0Q/ewDzpTtzDyqCE1v+vu03W4zRi3
 T9X38Vko/+4BeIPIBmCecEipi3QehHxPOXA86ByUjag3qdZXTQuFVvF5McJvQsRpHbtSNs+P2Am
 gI2nQeEe6JM38auH79167oKXwbmtzT4tcIj2MmkkkLI9HlOi0T/XgLs6Rw1voQ5RgEVJPJeveCf
 6OnSr7EaUf+WO4438BoS4O48S7cCQzlhtwp+bTtTq6o7MW0XWmvRKb42SmOsOVhsonO2aI1UBau
 zkjyOLvVDejSZ2pLHAQOqKRgPnheOMG4I6xPO1TH2msg==
X-Received: by 2002:a05:7022:51f:b0:137:8bc2:f501 with SMTP id
 a92af1059eb24-13b36d6d48bmr946352c88.7.1782901199922; 
 Wed, 01 Jul 2026 03:19:59 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b2ab2e0e3sm19355047c88.7.2026.07.01.03.19.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 03:19:59 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>, Joel Stanley <joel@jms.id.au>
Subject: [PULL 35/39] tests/functional/riscv64: Add tt-atlantis tests
Date: Wed,  1 Jul 2026 20:17:48 +1000
Message-ID: <20260701101752.2522962-36-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701101752.2522962-1-alistair.francis@wdc.com>
References: <20260701101752.2522962-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1234;
 envelope-from=alistair23@gmail.com; helo=mail-dl1-x1234.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Nicholas Piggin <npiggin@gmail.com>

Add OpenSBI and Linux boot tests for the tt-atlantis machine. Based on
tests/functional/riscv64/test_sifive_u.py.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
Message-ID: <20260630024952.1520546-10-joel@jms.id.au>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 MAINTAINERS                                  |  1 +
 tests/functional/riscv64/meson.build         |  1 +
 tests/functional/riscv64/test_opensbi.py     |  4 ++
 tests/functional/riscv64/test_tt_atlantis.py | 57 ++++++++++++++++++++
 4 files changed, 63 insertions(+)
 create mode 100755 tests/functional/riscv64/test_tt_atlantis.py

diff --git a/MAINTAINERS b/MAINTAINERS
index a6d1e1f676..78e48ae8df 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1801,6 +1801,7 @@ S: Supported
 F: docs/system/riscv/tt_*.rst
 F: hw/riscv/tt_*.c
 F: include/hw/riscv/tt_*.h
+F: tests/functional/riscv64/test_tt_*.py
 
 AMD Microblaze-V Generic Board
 M: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
diff --git a/tests/functional/riscv64/meson.build b/tests/functional/riscv64/meson.build
index 5871211e89..c9d4c090fb 100644
--- a/tests/functional/riscv64/meson.build
+++ b/tests/functional/riscv64/meson.build
@@ -14,5 +14,6 @@ tests_riscv64_system_thorough = [
   'endianness',
   'boston',
   'sifive_u',
+  'tt_atlantis',
   'tuxrun',
 ]
diff --git a/tests/functional/riscv64/test_opensbi.py b/tests/functional/riscv64/test_opensbi.py
index d077e40f42..0f8beb7e7a 100755
--- a/tests/functional/riscv64/test_opensbi.py
+++ b/tests/functional/riscv64/test_opensbi.py
@@ -28,6 +28,10 @@ def test_riscv_sifive_u(self):
         self.set_machine('sifive_u')
         self.boot_opensbi()
 
+    def test_riscv_tt_atlantis(self):
+        self.set_machine('tt-atlantis')
+        self.boot_opensbi()
+
     def test_riscv_virt(self):
         self.set_machine('virt')
         self.boot_opensbi()
diff --git a/tests/functional/riscv64/test_tt_atlantis.py b/tests/functional/riscv64/test_tt_atlantis.py
new file mode 100755
index 0000000000..48abd5cd27
--- /dev/null
+++ b/tests/functional/riscv64/test_tt_atlantis.py
@@ -0,0 +1,57 @@
+#!/usr/bin/env python3
+#
+# Functional test that boots a Linux kernel on a Tenstorrent Atlantis machine
+# and checks the console
+#
+# Copyright (c) Linaro Ltd.
+# Copyright 2026 Tenstorrent
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from qemu_test import Asset, LinuxKernelTest
+
+
+class TTAtlantis(LinuxKernelTest):
+
+    ASSET_KERNEL = Asset(
+        'https://storage.tuxboot.com/kernels/6.11.9/riscv64/Image',
+        '174f8bb87f08961e54fa3fcd954a8e31f4645f6d6af4dd43983d5e9841490fb0')
+    ASSET_ROOTFS = Asset(
+        ('https://github.com/groeck/linux-build-test/raw/'
+         '9819da19e6eef291686fdd7b029ea00e764dc62f/rootfs/riscv64/'
+         'rootfs.ext2.gz'),
+        'b6ed95610310b7956f9bf20c4c9c0c05fea647900df441da9dfe767d24e8b28b')
+
+    def do_test_riscv64_tt_atlantis(self, connect_disk):
+        self.set_machine('tt-atlantis')
+        kernel_path = self.ASSET_KERNEL.fetch()
+        rootfs_path = self.uncompress(self.ASSET_ROOTFS)
+
+        self.vm.set_console()
+        kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE + 'earlycon=sbi '
+
+        if connect_disk:
+            kernel_command_line += 'root=/dev/vda panic=-1 noreboot rootwait '
+            self.vm.add_args('-device',
+                             'virtio-blk,drive=drive0,serial=0x1234,bus=pcie.0')
+            self.vm.add_args('-drive',
+                             f'file={rootfs_path},if=none,id=drive0,format=raw')
+            pattern = 'Boot successful.'
+        else:
+            kernel_command_line += 'panic=0 noreboot '
+            pattern = 'Cannot open root device'
+
+        self.vm.add_args('-kernel', kernel_path,
+                         '-append', kernel_command_line,
+                         '-no-reboot')
+
+        self.vm.launch()
+        self.wait_for_console_pattern(pattern)
+
+    def test_riscv64_tt_atlantis(self):
+        # tt-atlantis machine has no PCI host yet, so no disk
+        self.do_test_riscv64_tt_atlantis(False)
+
+
+if __name__ == '__main__':
+    LinuxKernelTest.main()
-- 
2.54.0


