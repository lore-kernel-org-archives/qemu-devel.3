Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C802CD6E55
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 07:01:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUfaC-0004YY-Tj; Wed, 03 Jun 2026 03:00:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wUfa9-0004To-LA
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 03:00:05 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wUfa7-0006Mq-Ex
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 03:00:05 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-c8588ec1b44so2933875a12.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 00:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780470002; x=1781074802; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mdktWbjeb6VlessgA96IHNIsEfmQLs2g6k25G78KNk4=;
 b=IjKzLlk5RSDVcfCuzSKChmK1SEM9X4ghJT+IFv+vM4KwoBK4RhxYNaR4GN7U6lB1Pv
 vZbbllwTMYrXPAa+jbBBUBn/FacoR/dBY9IrXErYQP5Hj5K8oGLG7mQnlE8IYTJ4aO9f
 CffseybB9duibaA/Q9ln28bDpV8Itx/iWvLGUaZ1BddAnN1AFZxuiZIwKOneLl65fYoF
 bIlz0uOqY+w8QtvFWRWwUkBqFclt+I7odVR4rnFBPr5c9R6HhqUO+eMpdEFLlmjQ7lQp
 jqj+hucfX+ENhRGb3cqLC31cjTk+atwM/1lW0oQCXPLlDDvBj6rr3YrQRIaK6WB6wCNs
 hGMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780470002; x=1781074802;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mdktWbjeb6VlessgA96IHNIsEfmQLs2g6k25G78KNk4=;
 b=XkQSoyFH8c5lNet4IVcpcvIwQcKKH0SBc0e7gZu7ffIKiUc1BMtiNZUBgRjn4zsxJ5
 xawS687Ap+wHynrCGZpp7PWdEmnpbP3pvTTj+Mg9he4yMLd+RIW6DTyJKI3Akdy9mpdI
 meCe/szCY6QK5CTfthcrcaABIruqiPjCJHD1/+b6t/W0enDdOAs4nEpJM5mXSr5GxOKJ
 vkRtNMElKf0goYA/GewN5vyTJsyVBgUPXfHc4zBwLeua1evNyk9BoAVoU71Im7RyBIIj
 C0bYYBG3bZ24YUSjitTRChDFc0afs4qSCdpwQcKEXFii2xkyi8xwsbLmu3/nfRg1Y8gx
 /Djw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8aYMqmQih32/KC9ZLPoPzwHSyR4qhP9MgcGJX318GWxgJy+rUsJbDsw2sTyL+yxaNKNfYwrHkwPSZD@nongnu.org
X-Gm-Message-State: AOJu0Yz4kZ9EjqpGtCYQ3xYBBplD29LEOgft0ZwsSDhQL2Ti16dX9jHd
 IM6e1dkfEwWuvQozJDkb6c9wRg+4o96M7bmDHJSUfpXr3+KD68vMdcoN
X-Gm-Gg: Acq92OEZCxID2UiY4a28hajMEvlPy3INiqLhEP75JWvPhzKqh0ig3djYUGzhgWDIJxK
 ghM+aspuHOdGili5SwLlbafUwPgPw6urn7ZXM2mnZhP+/9iY2M2wSi3zTgrcv9Mt71Sp6334hZ9
 wKBhCVvTHsDCTCaRdUu2zcDYFn5aGQqeWQ+NmdOtULXljvOqwgwp/EthYwHfQwCi/JjfATygCG2
 SaulrniUL2TYW6c/i0tydsaEWXMctPNoucwbk6sRDGjDcFOGf80cTLMtIfkXCgFUu/79lp+nbYm
 oiZeRCSsAxKc0IACH2HIYPw7HMNOIHmmOTWuvLoNbkqyA583ty8NqyA2SkoJ/koRr6ho5em0xC0
 qDz3eGBllqihsLJor71TpURl0yXchJFm6J1ul3eY9Piu/DDRWFc8ivIpA/KokCCsqptyD0z24a4
 gQXox0qzWxRJpFsalJkuXJ8z3cqxF2iDykEIynLsHl1OY6RiXWif+tBEAJl8y+cP9ZzNCCiciay
 s971zp+ahr5Uy4RCIJUFojMpkV0pTif75Jp4/2FgavO8+WHRAjXf52Jmr9Sgk8A
X-Received: by 2002:a05:6a20:9185:b0:3b4:640c:7225 with SMTP id
 adf61e73a8af0-3b49798adadmr2433945637.46.1780470001872; 
 Wed, 03 Jun 2026 00:00:01 -0700 (PDT)
Received: from donnager-debian.. ([45.124.203.15])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c85df033887sm1283261a12.2.2026.06.02.23.59.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 00:00:01 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: Alistair Francis <alistair.francis@wdc.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Andrew Jones <andrew.jones@oss.qualcomm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Michael Ellerman <mpe@kernel.org>,
 Joel Stanley <jms@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v8 09/12] tests/functional/riscv64: Add tt-atlantis tests
Date: Wed,  3 Jun 2026 16:28:53 +0930
Message-ID: <20260603065859.592063-10-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260603065859.592063-1-joel@jms.id.au>
References: <20260603065859.592063-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=joel.stan@gmail.com; helo=mail-pg1-x52b.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 MAINTAINERS                                  |  1 +
 tests/functional/riscv64/meson.build         |  1 +
 tests/functional/riscv64/test_opensbi.py     |  4 ++
 tests/functional/riscv64/test_tt_atlantis.py | 57 ++++++++++++++++++++
 4 files changed, 63 insertions(+)
 create mode 100755 tests/functional/riscv64/test_tt_atlantis.py

diff --git a/MAINTAINERS b/MAINTAINERS
index e52aa769c9ae..f4b7e7fd43a6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1793,6 +1793,7 @@ S: Supported
 F: docs/system/riscv/tt_*.rst
 F: hw/riscv/tt_*.c
 F: include/hw/riscv/tt_*.h
+F: tests/functional/riscv64/test_tt_*.py
 
 AMD Microblaze-V Generic Board
 M: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
diff --git a/tests/functional/riscv64/meson.build b/tests/functional/riscv64/meson.build
index b996c89d7df9..c4456fabd757 100644
--- a/tests/functional/riscv64/meson.build
+++ b/tests/functional/riscv64/meson.build
@@ -13,5 +13,6 @@ tests_riscv64_system_quick = [
 tests_riscv64_system_thorough = [
   'boston',
   'sifive_u',
+  'tt_atlantis',
   'tuxrun',
 ]
diff --git a/tests/functional/riscv64/test_opensbi.py b/tests/functional/riscv64/test_opensbi.py
index d077e40f4278..0f8beb7e7a8c 100755
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
index 000000000000..48abd5cd27c2
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
2.47.3


