Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 426EFE77188
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 10:04:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTI3c-0002br-2Q; Thu, 02 Jan 2025 05:04:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTI3a-0002bN-CT
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 05:03:58 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTI3Y-0006iv-Ie
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 05:03:58 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43634b570c1so80279535e9.0
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 02:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735812232; x=1736417032; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+IfUZXZTSx3E5XkEnYiVjxXKMhiznWJF3OIbSSa3FoE=;
 b=yP5a5EqMgl8JpF1wtSuANxrUHUFL4sGYQEoy1Gm4/r4PW5+PwGB3jxc1rMoBwuN3fW
 tujUGlAZTpBGmuTOcSpr6QfExZMhnL5PwlMUfg+ApmCCH7BRoKQmylV6tmGV3kHXUxCD
 u7rNBOcdqCR3mUak4/8W6R3InpHPJV4byv4bpxujvz/uCxtln7R3SesUbd1Ow19SNtCV
 6sKb+81jTX/7cLQM5mdb4rJ7OKJIjl3guYVF7R3A1elZsMZKE5sVTmTmeqFnIaY/FtaM
 yGUja12ZL9lpGLWH4ryPZPfxq4b/JHLRiiMNVWJZ+gZVVxXG8dtw2u+r8iPOq+WZ3AVh
 uKgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735812232; x=1736417032;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+IfUZXZTSx3E5XkEnYiVjxXKMhiznWJF3OIbSSa3FoE=;
 b=ZXGJd/ltP2LM2imljlNdCoxL9+15+9xfMGNnDAIn16FwCegho8D53tqrOUWjry7DkT
 5yk63hu9whNArUMQfjSso+xK9P7vP1WpsRQy/h3McYLgHyvxXOoTt5LDaAEQfT/KEh/j
 Me1+nnZV9EgvTqtfcGRIfazNLJ93nTdFs+O2sSTo9R0q5jympitYu4eSCUE4aH5b1+sv
 /loatnYGy7dGEbX4sKXfv5c66h+WfYT2tNu+oeaCN4x9UHLD5PTV2rcd80lQINjTCeta
 BsJNzFCx6/LmK7gNQizDvoYNJHYu9e/0CR35YAHGPaD1tC/dsXVtDIiUBEhL02OqVqul
 eFyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXY6h3QZqPNVv2/0LSeXlMFzLL6zl26wrBJw2sUrnwqR2icli/D/yO25KN4EwRc3OjmEKSqlds2O1df@nongnu.org
X-Gm-Message-State: AOJu0YzCIavzZAlaX8T1gDUvh7S0tg3HQPBzYJanv4Bqr7APLnAnKll/
 xXyOERn7sdD6qPwB3u1/wNMKcDhUBXcUn2FycpgaDIX4VnRiEWAv/w1bI3tN0mk=
X-Gm-Gg: ASbGncuTx+c4xA8BF1D5jXLh5nNTu+QPkDHODg5ryuWBcH4h3UQR5bKdW9vU1G9bWc/
 ATqiUKc8lSSVgT9XHC7lWKCvxCwhWvVcglK8cxR/KSt11ermc/kXMlDEQjndMXaFZjiDx+8rXWZ
 0Lj0OHLUWtfHGcahASyqPZPkY9plSBd/iyxXuS0aQFlucQznLDK7CACLLzJD25c11ZUUzgFH5aO
 QBKxsQhQnvqWnQnWXTWUC+ajYQLqZFG/sYmlcbJsIQ85KyU2ZleEk8eSVFRrvxDy3DOzwH7xvtR
 mqlXviH7M00eHuI9z1+itfGKGNJPj9o=
X-Google-Smtp-Source: AGHT+IFRRg2IsQfAxFuEMENodLvYbytjl1KrTs8+xyHQ7elpqzQGnN3H70SOLV5uyOHOsH+i3g5ZYw==
X-Received: by 2002:a05:600c:6b09:b0:434:eb86:aeca with SMTP id
 5b1f17b1804b1-43675cb208bmr419108485e9.10.1735812232152; 
 Thu, 02 Jan 2025 02:03:52 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c8a6ca5sm38587349f8f.86.2025.01.02.02.03.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 02 Jan 2025 02:03:51 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Thomas Huth <thuth@redhat.com>,
	qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Helge Deller <deller@gmx.de>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v6 2/2] tests: Add functional tests for HPPA machines
Date: Thu,  2 Jan 2025 11:03:40 +0100
Message-ID: <20250102100340.43014-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250102100340.43014-1-philmd@linaro.org>
References: <20250102100340.43014-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add quick firmware boot tests (less than 1sec) for the
B160L (32-bit) and C3700 (64-bit) HPPA machines:

  $ make check-functional-hppa
  ...
  4/4 qemu:func-quick+func-hppa / func-hppa-hppa_seabios    OK 0.22s 2 subtests passed

Remove the duplicated B160L test in qtest/boot-serial-test.c.

Suggested-by: Helge Deller <deller@gmx.de>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Helge Deller <deller@gmx.de>
Tested-by: Helge Deller <deller@gmx.de>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS                           |  1 +
 tests/qtest/boot-serial-test.c        |  2 --
 tests/functional/meson.build          |  4 +++
 tests/functional/test_hppa_seabios.py | 35 +++++++++++++++++++++++++++
 tests/qtest/meson.build               |  2 +-
 5 files changed, 41 insertions(+), 3 deletions(-)
 create mode 100755 tests/functional/test_hppa_seabios.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 2101b512175..770bbf9f233 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1203,6 +1203,7 @@ F: include/hw/pci-host/astro.h
 F: include/hw/pci-host/dino.h
 F: pc-bios/hppa-firmware.img
 F: roms/seabios-hppa/
+F: tests/functional/test_hppa_seabios.py
 
 LoongArch Machines
 ------------------
diff --git a/tests/qtest/boot-serial-test.c b/tests/qtest/boot-serial-test.c
index 7759e8c9702..7ea24855072 100644
--- a/tests/qtest/boot-serial-test.c
+++ b/tests/qtest/boot-serial-test.c
@@ -184,8 +184,6 @@ static const testdef_t tests[] = {
     { "microblazeel", "petalogix-ml605", "", "TT",
       sizeof(kernel_plml605), kernel_plml605 },
     { "arm", "raspi2b", "", "TT", sizeof(bios_raspi2), 0, bios_raspi2 },
-    /* For hppa, force bios to output to serial by disabling graphics. */
-    { "hppa", "B160L", "-vga none", "SeaBIOS wants SYSTEM HALT" },
     { "aarch64", "virt", "-cpu max", "TT", sizeof(kernel_aarch64),
       kernel_aarch64 },
     { "arm", "microbit", "", "T", sizeof(kernel_nrf51), kernel_nrf51 },
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 24f7f8f2f1c..71810a3aa82 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -104,6 +104,10 @@ tests_avr_system_thorough = [
   'avr_mega2560',
 ]
 
+tests_hppa_system_quick = [
+  'hppa_seabios',
+]
+
 tests_i386_system_thorough = [
   'i386_tuxrun',
 ]
diff --git a/tests/functional/test_hppa_seabios.py b/tests/functional/test_hppa_seabios.py
new file mode 100755
index 00000000000..a44d1a3eebe
--- /dev/null
+++ b/tests/functional/test_hppa_seabios.py
@@ -0,0 +1,35 @@
+#!/usr/bin/env python3
+#
+# SeaBIOS boot test for HPPA machines
+#
+# Copyright (c) 2024 Linaro, Ltd
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from qemu_test import QemuSystemTest
+from qemu_test import wait_for_console_pattern
+
+class HppaSeabios(QemuSystemTest):
+
+    timeout = 5
+    MACH_BITS = {'B160L': 32, 'C3700': 64}
+
+    def boot_seabios(self):
+        mach = self.machine
+        bits = self.MACH_BITS[mach]
+        self.vm.set_console()
+        self.vm.launch()
+        self.machine
+        wait_for_console_pattern(self, f'SeaBIOS PA-RISC {bits}-bit Firmware')
+        wait_for_console_pattern(self, f'Emulated machine:     HP {mach} ({bits}-bit')
+
+    def test_hppa_32(self):
+        self.set_machine('B160L')
+        self.boot_seabios()
+
+    def test_hppa_64(self):
+        self.set_machine('C3700')
+        self.boot_seabios()
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index c5a70021c50..ab296a97a78 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -140,7 +140,7 @@ qtests_alpha = ['boot-serial-test'] + \
 
 qtests_avr = [ 'boot-serial-test' ]
 
-qtests_hppa = ['boot-serial-test'] + \
+qtests_hppa = \
   qtests_filter + \
   (config_all_devices.has_key('CONFIG_VGA') ? ['display-vga-test'] : [])
 
-- 
2.47.1


