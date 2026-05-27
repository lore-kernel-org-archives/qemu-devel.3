Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A963FCD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 20:16:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSKfT-0008SS-2P; Wed, 27 May 2026 16:15:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSKf5-0008Ex-0j
 for qemu-devel@nongnu.org; Wed, 27 May 2026 16:15:32 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSKf2-0005hi-NW
 for qemu-devel@nongnu.org; Wed, 27 May 2026 16:15:30 -0400
Received: by mail-wr1-x444.google.com with SMTP id
 ffacd0b85a97d-43d76dd4ee8so7374427f8f.2
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 13:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779912927; x=1780517727; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b8I4Uj8QzoYfgxdM3WVJzGYEDhLFU1gsMiq89h2j04Y=;
 b=XDFwQHo0k2oD+p8403JXgsdeKnR8HsoArOjrehWwUsTfgXu0bcycS2Tn211A22+8a9
 jOQWfsisoJ5xuexyAsAJpi3bl44o8DgUnrQ4wpnztMJP9joczWHMXRiFvZ6QWM68nEtg
 w8DJIEt8L86VkJV06f0L7PeW5n1SP2Tvw2YtAm9N9gkHrTtEPr5vr0eMLXJRl03VTDew
 joNSc1YWzzY9ACTG6RaR3JKMpK01Xl+HJDhjtcHmQIJbsAqAMvw1+ShsgvKMONiCMphC
 +fD9ptuR9X2cr0sKgJZ4n/cPByZg8og6zNHkbMV0qT/fPI/4t0Cp+uRhmKvR1x5aMqlS
 xZaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779912927; x=1780517727;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=b8I4Uj8QzoYfgxdM3WVJzGYEDhLFU1gsMiq89h2j04Y=;
 b=CJg7uYO59W649QcLyNvCMdSj9icnmCesjQkLsTFrwumTJdsMpxHHYkBeZ/nkSi5Tzg
 X7S2ooT9Emf6fPBzmfcCqsQLrDvxJ+m7Bg3efP73m6BiW7UsVX4M+wLdq2439MSkX4Ax
 ZNEWZvH01YSspVX9WNkIJfFIAjXI7UlIalrkvdLjXDdzPLJrVDXPOUYAPSg7GKkHi/GR
 yM1qAUkCaC0wzokQbXVsHyT5BUiToISWOXzTkbyLBtbiNiC4L/1FYYioxN9aQXu7oeSV
 5h1/RDryLAYdicEDJ5BwgvDVSGoOa/7OvWqA/GORYIgPpXipOGCLalPPA1dys/wO9NEf
 9gxA==
X-Gm-Message-State: AOJu0YzK0AWN0fEMR3ssVbrUXXJopS9txwbTyNACOLId6hYXW7heDKdo
 l4636AhPtchCGUq9FGRQqfVY4YCxE3QMdfD+zA0fYKyXY+WutKxBYDfSeTD7NqNrNdJQynG8W19
 6vvv7n6yxCGyv
X-Gm-Gg: Acq92OFB2/cJnSwaiBQCDOEFyDlnZl+OWVfDi4DcZ0cI6pmMZrfLgYapl99SZtC0ks0
 ei2t0zhIKHzWAPP1wA6dV1Yixq5Epui4dMe4sm93YeFTCmsN+fFVUe2FDveCCCH4rlGO3oW5lth
 VorBHVHqaAd2WI2nBDtmAIgAEex3A/Skbdh0CY0bpevwI8AmI0ri4GjxayLR8azCYU4AhuRQd59
 BBxFvNBX2vIwnTJ8hTpj6aSxLGzynA0Y2fDxjt8gKXJKhqmof4BLiS1r4rMXGCF9vNOFx4oq46k
 LPl5QY9Zh+t1b5S5yBbieaFwTZOS/QRlRnB+XNDK/A3aFQ+SwnzyS+W6Z6wR5D1APwpnsnTkoGj
 2U6/GP8m4DOBWeBKky/+53esNNmsoN3qM3KG7eCrMQqPLtCimdQ2/cEf+fIWYI3fR2lsqeIvWz/
 ukUMBdKOF5ByLgKSHkw9J/McEOJ5Wr83F2KeJWzNXDmR5RCdxFDXc6+mCwNdQX33R/zQ==
X-Received: by 2002:a05:6000:400d:b0:43d:71b:204b with SMTP id
 ffacd0b85a97d-45eb38c2367mr43530079f8f.39.1779912927037; 
 Wed, 27 May 2026 13:15:27 -0700 (PDT)
Received: from m17.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45edb5c1e59sm7714019f8f.33.2026.05.27.13.15.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 27 May 2026 13:15:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-riscv@nongnu.org, Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 Anton Johansson <anjo@rev.ng>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Christoph Muellner <christoph.muellner@vrull.eu>,
 Djordje Todorovic <djordje.todorovic@htecgroup.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v11 12/12] tests/functional: Add RISC-V endianness test
Date: Wed, 27 May 2026 22:13:48 +0200
Message-ID: <20260527201348.29511-13-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260527201348.29511-1-philmd@linaro.org>
References: <20260527201348.29511-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x444.google.com
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

From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>

Add functional test for the RISC-V 'big-endian' CPU property.

Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/functional/riscv64/meson.build        |  1 +
 tests/functional/riscv64/test_endianness.py | 57 +++++++++++++++++++++
 2 files changed, 58 insertions(+)
 create mode 100644 tests/functional/riscv64/test_endianness.py

diff --git a/tests/functional/riscv64/meson.build b/tests/functional/riscv64/meson.build
index b996c89d7df..5871211e899 100644
--- a/tests/functional/riscv64/meson.build
+++ b/tests/functional/riscv64/meson.build
@@ -11,6 +11,7 @@ tests_riscv64_system_quick = [
 ]
 
 tests_riscv64_system_thorough = [
+  'endianness',
   'boston',
   'sifive_u',
   'tuxrun',
diff --git a/tests/functional/riscv64/test_endianness.py b/tests/functional/riscv64/test_endianness.py
new file mode 100644
index 00000000000..9e0b3b7db5c
--- /dev/null
+++ b/tests/functional/riscv64/test_endianness.py
@@ -0,0 +1,57 @@
+#!/usr/bin/env python3
+#
+# Functional tests for RISC-V big-endian support
+#
+# Copyright (c) 2026 MIPS
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from qemu_test import QemuSystemTest, Asset
+from qemu_test import wait_for_console_pattern
+
+
+class RiscvBigEndian(QemuSystemTest):
+    """
+    Tests for RISC-V runtime big-endian data support.
+
+    Uses a bare-metal RV64 ELF that detects data endianness at runtime
+    by storing a 32-bit word and reading back byte 0. Prints "ENDIAN: BE"
+    or "ENDIAN: LE" to the NS16550A UART on the virt machine.
+    """
+
+    timeout = 10
+
+    ASSET_BE_TEST = Asset(
+        'https://github.com/MIPS/linux-test-downloads/raw/main/'
+        'riscvbe-baremetal/be-test-bare-metal.elf',
+        '9ad51b675e101de65908fadbac064ed1d0564c17463715d09dd734db86ea0f58')
+
+    def _run_bare_metal(self, big_endian=False):
+        self.set_machine('virt')
+        kernel = self.ASSET_BE_TEST.fetch()
+        self.vm.add_args('-bios', 'none')
+        self.vm.add_args('-kernel', kernel)
+        if big_endian:
+            self.vm.add_args('-cpu', 'rv64,big-endian=on')
+        self.vm.set_console()
+        self.vm.launch()
+        expected = 'ENDIAN: BE' if big_endian else 'ENDIAN: LE'
+        wait_for_console_pattern(self, expected)
+
+    def test_bare_metal_littleendian(self):
+        """
+        Boot bare-metal ELF on virt with default little-endian CPU.
+        Expects "ENDIAN: LE" on UART.
+        """
+        self._run_bare_metal(big_endian=False)
+
+    def test_bare_metal_bigendian(self):
+        """
+        Boot bare-metal ELF on virt with big-endian=on CPU property.
+        Expects "ENDIAN: BE" on UART.
+        """
+        self._run_bare_metal(big_endian=True)
+
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
-- 
2.53.0


