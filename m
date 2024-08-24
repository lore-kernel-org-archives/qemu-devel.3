Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FED1C52D6F
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Aug 2024 16:10:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shtKa-000720-Is; Sat, 24 Aug 2024 12:09:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1shtKM-0006QC-5F
 for qemu-devel@nongnu.org; Sat, 24 Aug 2024 12:09:24 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1shtKI-0005yn-Sw
 for qemu-devel@nongnu.org; Sat, 24 Aug 2024 12:09:20 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a83562f9be9so291246366b.0
 for <qemu-devel@nongnu.org>; Sat, 24 Aug 2024 09:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724515757; x=1725120557; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ArPQRo3JWTXoZ9aDQjC++E+MK4nlwcv8B+/ljFpf3L0=;
 b=s9wuRvNwuieL0iLNSqsTwWpWum0uZtGBjpRzaXoq0nP1KjwfNWpzUM59KH7v1JwEOZ
 eP+PJBGgziFCXqx3edosmXKIuRTNosNssPFY2iPWmfXTi2DoLrXljSA/8L+Rv3QwvscE
 MytdNz5LcAeg9shS+ek+crtRa9Ce7WFqqgmlhEdsqTfLdy5hO6VHqn6dn0SnDZz13CqZ
 CdUoD9eN8qHEJVEAAfH3y+8nQ9h+HJAMkCMoO6nmCaZoXZGYXkzEtL70XWdUi10XdDL3
 qppfe/uM5+GfUCf8ZFtJX6o2fj6RX3LE6tvvWlegPOAwjNj9CtfSP3KayFTrMfbFNdvY
 WhsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724515757; x=1725120557;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ArPQRo3JWTXoZ9aDQjC++E+MK4nlwcv8B+/ljFpf3L0=;
 b=NmL29O1IpcKslRGvTpooI3gbbJLJLeKgZLfGuQmtPw4mJTgKPCePViZofwM3065wGI
 HYXWhRSlif4GXWFEy+LAwVIV2Bb382jHqPgbV3EsM/OSs3VkB3NdcizENwVOfrdPInX9
 YdZRWdqlyOlajDsav8PK0HD6caIOMTDUvoqznjoscyK3p0NLinIGrte17S7lFrq34DFh
 JTZye2BCIVNpaIrfv+YxHbMEffkS0wYen56DO6GCMeopbCQijhYHtmkUoj7W/yNxtoGp
 2Cko3D9PsXBlJXf5mGyxRxOLNR4n5ETFkmlBzX8/ZzwCyg0jQLWp/QKCaDk8v5LoJrTZ
 5KtA==
X-Gm-Message-State: AOJu0YxUHKL1UWQihJxAvg64REld7OPpy9mdNMzGSUZ5r1RbNP01JSb1
 eoakzxiz4wvHJeYhPfgbgMLULfdDivQWXz3E6fUL9S9yzfg21ZsSck74qd6sVWUBP6yTp7KRysu
 k
X-Google-Smtp-Source: AGHT+IE0kUGFXc3dCBoS+Nd2KwctWKWbaM1hRAF1GYPDqonTdPU1mls0LOzsKun7rcCfmUdKUKlLYg==
X-Received: by 2002:a17:907:2d94:b0:a86:9602:f4b with SMTP id
 a640c23a62f3a-a86a54cf91fmr346665166b.63.1724515757003; 
 Sat, 24 Aug 2024 09:09:17 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.198.30])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a868f4f41edsm418951366b.199.2024.08.24.09.09.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 24 Aug 2024 09:09:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, Cleber Rosa <crosa@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Huacai Chen <chenhuacai@kernel.org>, Beraldo Leal <bleal@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 6/7] tests/functional: Convert nanomips Malta avocado tests
Date: Sat, 24 Aug 2024 18:08:27 +0200
Message-ID: <20240824160829.27655-7-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240824160829.27655-1-philmd@linaro.org>
References: <20240824160829.27655-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Straight forward conversion. Update the SHA1 hashes to
SHA256 hashes since SHA1 should not be used anymore nowadays.

  $ QEMU_TEST_ALLOW_UNTRUSTED_CODE=1 \
        make check-functional-mipsel
  ...
  ▶ 4/4 test_mipsel_malta.MaltaMachineConsole.test_mips_malta32el_nanomips_16k_up   OK
  ▶ 4/4 test_mipsel_malta.MaltaMachineConsole.test_mips_malta32el_nanomips_4k       OK
  ▶ 4/4 test_mipsel_malta.MaltaMachineConsole.test_mips_malta32el_nanomips_64k_dbg  OK
  ▶ 4/4 test_mipsel_malta.MaltaMachineYAMON.test_mipsel_malta_yamon                 OK
  4/4 qemu:func-thorough+func-mipsel-thorough+thorough / func-mipsel-mipsel_malta   OK   9.95s   4 subtests passed

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/avocado/boot_linux_console.py   | 59 ---------------------------
 tests/functional/test_mipsel_malta.py | 51 +++++++++++++++++++++++
 2 files changed, 51 insertions(+), 59 deletions(-)

diff --git a/tests/avocado/boot_linux_console.py b/tests/avocado/boot_linux_console.py
index 10457743d1..0756e49ded 100644
--- a/tests/avocado/boot_linux_console.py
+++ b/tests/avocado/boot_linux_console.py
@@ -179,65 +179,6 @@ def test_mips_malta_cpio(self):
         # Wait for VM to shut down gracefully
         self.vm.wait()
 
-    def do_test_mips_malta32el_nanomips(self, kernel_path_xz):
-        kernel_path = self.workdir + "kernel"
-        with lzma.open(kernel_path_xz, 'rb') as f_in:
-            with open(kernel_path, 'wb') as f_out:
-                shutil.copyfileobj(f_in, f_out)
-
-        self.vm.set_console()
-        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE
-                               + 'mem=256m@@0x0 '
-                               + 'console=ttyS0')
-        self.vm.add_args('-no-reboot',
-                         '-kernel', kernel_path,
-                         '-append', kernel_command_line)
-        self.vm.launch()
-        console_pattern = 'Kernel command line: %s' % kernel_command_line
-        self.wait_for_console_pattern(console_pattern)
-
-    def test_mips_malta32el_nanomips_4k(self):
-        """
-        :avocado: tags=arch:mipsel
-        :avocado: tags=machine:malta
-        :avocado: tags=endian:little
-        :avocado: tags=cpu:I7200
-        """
-        kernel_url = ('http://mipsdistros.mips.com/LinuxDistro/nanomips/'
-                      'kernels/v4.15.18-432-gb2eb9a8b07a1-20180627102142/'
-                      'generic_nano32r6el_page4k.xz')
-        kernel_hash = '477456aafd2a0f1ddc9482727f20fe9575565dd6'
-        kernel_path_xz = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
-        self.do_test_mips_malta32el_nanomips(kernel_path_xz)
-
-    def test_mips_malta32el_nanomips_16k_up(self):
-        """
-        :avocado: tags=arch:mipsel
-        :avocado: tags=machine:malta
-        :avocado: tags=endian:little
-        :avocado: tags=cpu:I7200
-        """
-        kernel_url = ('http://mipsdistros.mips.com/LinuxDistro/nanomips/'
-                      'kernels/v4.15.18-432-gb2eb9a8b07a1-20180627102142/'
-                      'generic_nano32r6el_page16k_up.xz')
-        kernel_hash = 'e882868f944c71c816e832e2303b7874d044a7bc'
-        kernel_path_xz = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
-        self.do_test_mips_malta32el_nanomips(kernel_path_xz)
-
-    def test_mips_malta32el_nanomips_64k_dbg(self):
-        """
-        :avocado: tags=arch:mipsel
-        :avocado: tags=machine:malta
-        :avocado: tags=endian:little
-        :avocado: tags=cpu:I7200
-        """
-        kernel_url = ('http://mipsdistros.mips.com/LinuxDistro/nanomips/'
-                      'kernels/v4.15.18-432-gb2eb9a8b07a1-20180627102142/'
-                      'generic_nano32r6el_page64k_dbg.xz')
-        kernel_hash = '18d1c68f2e23429e266ca39ba5349ccd0aeb7180'
-        kernel_path_xz = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
-        self.do_test_mips_malta32el_nanomips(kernel_path_xz)
-
     def test_aarch64_xlnx_versal_virt(self):
         """
         :avocado: tags=arch:aarch64
diff --git a/tests/functional/test_mipsel_malta.py b/tests/functional/test_mipsel_malta.py
index f31f96b012..c283653eae 100755
--- a/tests/functional/test_mipsel_malta.py
+++ b/tests/functional/test_mipsel_malta.py
@@ -14,9 +14,60 @@
 from qemu_test import QemuSystemTest, Asset
 from qemu_test import interrupt_interactive_console_until_pattern
 from qemu_test import wait_for_console_pattern
+from qemu_test.utils import lzma_uncompress
 from zipfile import ZipFile
 
 
+class MaltaMachineConsole(QemuSystemTest):
+
+    KERNEL_COMMON_COMMAND_LINE = 'printk.time=0 '
+
+    ASSET_KERNEL_4K = Asset(
+        ('http://mipsdistros.mips.com/LinuxDistro/nanomips/'
+         'kernels/v4.15.18-432-gb2eb9a8b07a1-20180627102142/'
+         'generic_nano32r6el_page4k.xz'),
+        '019e034094ac6cf3aa77df5e130fb023ce4dbc804b04bfcc560c6403e1ae6bdb')
+    ASSET_KERNEL_16K = Asset(
+        ('http://mipsdistros.mips.com/LinuxDistro/nanomips/'
+         'kernels/v4.15.18-432-gb2eb9a8b07a1-20180627102142/'
+         'generic_nano32r6el_page16k_up.xz'),
+        '3a54a10b3108c16a448dca9ea3db378733a27423befc2a45a5bdf990bd85e12c')
+    ASSET_KERNEL_64K = Asset(
+        ('http://mipsdistros.mips.com/LinuxDistro/nanomips/'
+         'kernels/v4.15.18-432-gb2eb9a8b07a1-20180627102142/'
+         'generic_nano32r6el_page64k_dbg.xz'),
+        'ce21ff4b07a981ecb8a39db2876616f5a2473eb2ab459c6f67465b9914b0c6b6')
+
+    def do_test_mips_malta32el_nanomips(self, kernel_path_xz):
+        kernel_path = os.path.join(self.workdir, 'kernel')
+        lzma_uncompress(kernel_path_xz, kernel_path)
+
+        self.set_machine('malta')
+        self.vm.set_console()
+        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE
+                               + 'mem=256m@@0x0 '
+                               + 'console=ttyS0')
+        self.vm.add_args('-cpu', 'I7200',
+                         '-no-reboot',
+                         '-kernel', kernel_path,
+                         '-append', kernel_command_line)
+        self.vm.launch()
+        console_pattern = 'Kernel command line: %s' % kernel_command_line
+        wait_for_console_pattern(self, console_pattern)
+
+    def test_mips_malta32el_nanomips_4k(self):
+        kernel_path_xz = self.ASSET_KERNEL_4K.fetch()
+        self.do_test_mips_malta32el_nanomips(kernel_path_xz)
+
+    def test_mips_malta32el_nanomips_16k_up(self):
+        kernel_path_xz = self.ASSET_KERNEL_16K.fetch()
+        self.do_test_mips_malta32el_nanomips(kernel_path_xz)
+
+    def test_mips_malta32el_nanomips_64k_dbg(self):
+        kernel_path_xz = self.ASSET_KERNEL_16K.fetch()
+        self.do_test_mips_malta32el_nanomips(kernel_path_xz)
+
+
 class MaltaMachineYAMON(QemuSystemTest):
 
     ASSET_YAMON_ROM = Asset(
-- 
2.45.2


