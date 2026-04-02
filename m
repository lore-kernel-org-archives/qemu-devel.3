Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4F0ED6AB10
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 22:01:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8Q3C-0001Ki-Fb; Thu, 02 Apr 2026 17:58:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1w8Q2t-0000NI-60
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 17:57:47 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1w8Q2p-0007JD-2r
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 17:57:45 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-b980785a0bfso172392366b.3
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2026 14:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775167061; x=1775771861; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3QUCwdkuO2ukE+OVkddbR6FN57t2sGozQkOLPCowkRI=;
 b=Fip32msWJEeslLeHjhrXiw2ps5zxmkBU662j11oRjuPjSRCgz1KT/9ubSKOxRUQh1H
 6VTJ7D9D4PSSSTXSr/eOnOJudTo7oNy1yiBeStYtbITIXShko0fWrzgroWElYD/UneRZ
 zUxEeA27YfsVQ8EJt7tCTAXyZz5t0MxEjWdZ4xab6q4DIHnrwHI/d1OKi1p9FfvIJmLV
 xxlhZ1lMjXK10Q7uLqzrtsZO8kRf2mJuWIFiOueR+jQi1atuox6Cq0esRP5VOyAUkRlB
 1aDcrR0fbMmqRn9iKN21ZJeZgwmKhNGQf5Wx3bRM+j6plaucFgk8Ppr4ttURhL/P1RF3
 HNIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775167061; x=1775771861;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3QUCwdkuO2ukE+OVkddbR6FN57t2sGozQkOLPCowkRI=;
 b=LeL6K9tseoeV74dPVlMw7GI3gbl5mGInAEj6UKHmgkCDXDd0HdVXlIENd1GKJ74WIC
 JEihCcYCGrHFdhow+KsFARyxposJtrKljk2fdXDN9Fxv534JzCoSNi49+l6Nvktymw4o
 FC8OrFsELyvpIbHbEc6v/Po9GkxT8psLY427EHH6KfUCjxzWlYr+Ux1uDzNhr87CeY1D
 hD0EB9plpgQy5bdGyAVWuGKwsqnFWBmlVkXMNvWebm48iMi7sJ7x3iJmetADpmM1PRWZ
 UfIRz7biPTiw0FWI2b8gkDPT624/pCxY726CoNDGlaGt2aP9enHSUpwNPwxP239jU26E
 nMvw==
X-Gm-Message-State: AOJu0YyDPDtADNtufpbTrf7bYwiRCtTxNJJTJUM4QmQt6LCprchwVHd1
 0cs22uuayZGW97Go2hT0R+vE88S+I9+Lrqwr/gw3dmn+ay17ZEzpR+S3h/Zeldov
X-Gm-Gg: ATEYQzw5bh6lm6wLe6UdPOSUjeZ9HpjF6tmDCxPKDApJQ5Jm8QZEurbd6AX6E1+jNjZ
 guH5w/vlxcvJN2EPUaGjxllLGiMLiv+UP6KVq2NQuj7lWeCDQ+CoyKXTZcHi7AVnenDveaGZC0Q
 ZNoP0KVFEpC5a5HmgFaLCnoaRrWvLRDMdLMuUfxGtLDQPiRrM/iSDptGjy7Vid17lYdF1P9vDrR
 LE2+zPov+wmCoyN6HPTTdRsZDadduQ/1L4m45Y7hLZOGkFWrJntddd5xpO8zB2025cmVlwG+uPM
 yRiExgkBJFUDHhScNDJoodeGnDZlBVqzw2LIZn9rD4H6Zi4FbMbw9nq3kp01Pa5XRj946okkq27
 Yc7lQPoPiybjGN9WmjGDPvnYWaYk5I7uqFFdsaIEIfDzNi0zK9vGgHOyQu6AwMGkIAiJJPR+3Fd
 yEkZdFVipOMJj3LsB80Bzy1+ZcMKr0ijBRTpcIrEADK+qORv6FeTUgHwzF5YFGT4zWH+VFhMFTK
 FFxgBEG
X-Received: by 2002:a17:907:6d18:b0:b97:554:f12e with SMTP id
 a640c23a62f3a-b9c672ff622mr22578166b.14.1775167060843; 
 Thu, 02 Apr 2026 14:57:40 -0700 (PDT)
Received: from thinkpad-t470s.. (93-143-182-244.adsl.net.t-com.hr.
 [93.143.182.244]) by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-b9c3cac0e1asm134009166b.27.2026.04.02.14.57.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2026 14:57:40 -0700 (PDT)
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org, peter.maydell@linaro.org,
 artem_mygaiev@epam.com, volodymyr_babchuk@epam.com,
 takahiro.nakata.wr@renesas.com,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Ruslan_Ruslichenko@epam.com, balaton@eik.bme.hu
Subject: [PATCH v3 33/33] tests/functional: Add functional tests for
 arm-generic-fdt machine
Date: Thu,  2 Apr 2026 23:56:18 +0200
Message-ID: <20260402215629.745866-34-ruslichenko.r@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260402215629.745866-1-ruslichenko.r@gmail.com>
References: <20260402215629.745866-1-ruslichenko.r@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-ej1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>

This patch adds functional tests for the new `arm-generic-fdt` machine type.
It introduces two new test suites:

1. test_arm_generic_fdt.py: Validates the firmware boot chain (TF-A and
   EDK2). It checks the console output for specific patterns indicating
   successful execution of BL1, BL2, BL31, and UEFI stages.

2. test_arm_generic_fdt_alpine.py: Validates a full OS boot by launching
   an Alpine Linux ISO and waiting for the welcome message.

To support these tests, two pre-compiled Device Tree Blob (DTB) files are
added to `tests/data`.

The tests reuse the existing firmware assets and Alpine ISO infrastructure
from the sbsa-ref tests.

Signed-off-by: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
---
 .../arm-generic-fdt/arm64-sbsa-guest.dtb      | Bin 0 -> 673 bytes
 .../aarch64/arm-generic-fdt/arm64-sbsa-hw.dtb | Bin 0 -> 5290 bytes
 tests/functional/aarch64/meson.build          |   2 +
 .../aarch64/test_arm_generic_fdt.py           | 114 ++++++++++++++++++
 .../aarch64/test_arm_generic_fdt_alpine.py    |  61 ++++++++++
 5 files changed, 177 insertions(+)
 create mode 100644 tests/data/dtb/aarch64/arm-generic-fdt/arm64-sbsa-guest.dtb
 create mode 100644 tests/data/dtb/aarch64/arm-generic-fdt/arm64-sbsa-hw.dtb
 create mode 100755 tests/functional/aarch64/test_arm_generic_fdt.py
 create mode 100755 tests/functional/aarch64/test_arm_generic_fdt_alpine.py

diff --git a/tests/data/dtb/aarch64/arm-generic-fdt/arm64-sbsa-guest.dtb b/tests/data/dtb/aarch64/arm-generic-fdt/arm64-sbsa-guest.dtb
new file mode 100644
index 0000000000000000000000000000000000000000..5f2a1e9b2826eec45ed97e6dd704649a05d0af4c
GIT binary patch
literal 673
zcmZuuJx|0i40R8LjsXD+Gtw;#SBZ~>u>%r210zx{4c9=LRB?)cf5SiGkFYT#>@=y4
za+VVN*)R69@_F#{1u**nfNSzg@@I68=^W8v>j8@IA^dX}3GI;IO)>k7PbPKlJ=>_$
zyb&K#d~3ArUzfN-QF`@A85%4bhsws7-xk^i8PPE3l;S(a)gIquNmVr;U=mj7fSh1$
zyjOg4GfyjW=Rr%HA-g`3DVKL)?Q9um?L}~%Gj9Dhl*jr#VOEm)4-;HZaGP+RU!7Be
zjNkJnQ7<RRM$W~6ryQO;axS-XxIS{OwsW{|=CR*zg>1A{<%{yDoh@5!orix}@kH4L
u>UUL2WembX)U{WL2};*?BIuP-;ME#J<CUlpq$3VU(_^6ifKEOu`m|p^QBCmx

literal 0
HcmV?d00001

diff --git a/tests/data/dtb/aarch64/arm-generic-fdt/arm64-sbsa-hw.dtb b/tests/data/dtb/aarch64/arm-generic-fdt/arm64-sbsa-hw.dtb
new file mode 100644
index 0000000000000000000000000000000000000000..c483e24ea72b6df80098030b0469beefbf1f3db4
GIT binary patch
literal 5290
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

literal 0
HcmV?d00001

diff --git a/tests/functional/aarch64/meson.build b/tests/functional/aarch64/meson.build
index 7ea8c22b04..637400496d 100644
--- a/tests/functional/aarch64/meson.build
+++ b/tests/functional/aarch64/meson.build
@@ -41,6 +41,8 @@ tests_aarch64_system_thorough = [
   'sbsaref',
   'sbsaref_alpine',
   'sbsaref_freebsd',
+  'arm_generic_fdt',
+  'arm_generic_fdt_alpine',
   'smmu',
   'tcg_plugins',
   'tuxrun',
diff --git a/tests/functional/aarch64/test_arm_generic_fdt.py b/tests/functional/aarch64/test_arm_generic_fdt.py
new file mode 100755
index 0000000000..061140fa89
--- /dev/null
+++ b/tests/functional/aarch64/test_arm_generic_fdt.py
@@ -0,0 +1,114 @@
+#!/usr/bin/env python3
+#
+# Functional test that boots a kernel and checks the console
+#
+# Based on test_arm_generic_fdt.py
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from qemu_test import QemuSystemTest, Asset
+from qemu_test import wait_for_console_pattern
+from qemu_test import interrupt_interactive_console_until_pattern
+
+from pathlib import Path
+
+def fetch_firmware(test):
+    """
+    Flash volumes generated using:
+
+    Toolchain from Debian:
+    aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0
+
+    Used components:
+
+    - Trusted Firmware         v2.12.0
+    - Tianocore EDK2           edk2-stable202411
+    - Tianocore EDK2-platforms 4b3530d
+
+    """
+
+    # Secure BootRom (TF-A code)
+    fs0_path = test.uncompress(Aarch64ArmGenericFdtMachine.ASSET_FLASH0,
+                                format="xz")
+
+    # Non-secure rom (UEFI and EFI variables)
+    fs1_path = test.uncompress(Aarch64ArmGenericFdtMachine.ASSET_FLASH1,
+                                format="xz")
+
+    for path in [fs0_path, fs1_path]:
+        with open(path, "ab+") as fd:
+            fd.truncate(256 << 20)  # Expand volumes to 256MiB
+
+    test.vm.add_args(
+        "-blockdev", f"driver=file,filename={fs0_path},node-name=pflash0",
+        "-blockdev", f"driver=file,filename={fs1_path},node-name=pflash1",
+    )
+
+
+class Aarch64ArmGenericFdtMachine(QemuSystemTest):
+    """
+    As firmware runs at a higher privilege level than the hypervisor we
+    can only run these tests under TCG emulation.
+    """
+
+    timeout = 180
+
+    # SBSA_FLASH0.fd.xz
+    ASSET_FLASH0 = Asset(
+            'https://share.linaro.org/downloadFile?id=kyoMLGC9zXa4oA7',
+            '76eb89d42eebe324e4395329f47447cda9ac920aabcf99aca85424609c3384a5')
+
+    # SBSA_FLASH1.fd.xz
+    ASSET_FLASH1 = Asset(
+        'https://share.linaro.org/downloadFile?id=Dj1HRXnDnKtU6Nj',
+        'f850f243bd8dbd49c51e061e0f79f1697546938f454aeb59ab7d93e5f0d412fc')
+
+    current_dir = Path(__file__).resolve().parent
+
+    hw_dtb_path = current_dir.parent.parent/ "data" / "dtb" / "aarch64" / \
+                    "arm-generic-fdt" / "arm64-sbsa-hw.dtb"
+
+    dtb_path = current_dir.parent.parent/ "data" / "dtb" / "aarch64" / \
+                    "arm-generic-fdt" / "arm64-sbsa-guest.dtb"
+
+    def test_edk2_firmware(self):
+
+        self.set_machine(f'arm-generic-fdt')
+
+        fetch_firmware(self)
+
+        self.vm.add_args('-machine', f'hw-dtb={self.hw_dtb_path}')
+        self.vm.add_args('-dtb', str(self.dtb_path))
+
+        self.vm.add_args('-device', "bochs-display")
+        self.vm.add_args('-device', "bochs-display")
+
+        self.vm.add_args('-d', 'guest_errors,unimp')
+        self.vm.set_console()
+        self.vm.launch()
+
+        # TF-A boot sequence:
+        #
+        # https://github.com/ARM-software/arm-trusted-firmware/blob/v2.8.0/\
+        #     docs/design/trusted-board-boot.rst#trusted-board-boot-sequence
+        # https://trustedfirmware-a.readthedocs.io/en/v2.8/\
+        #     design/firmware-design.html#cold-boot
+
+        # AP Trusted ROM
+        wait_for_console_pattern(self, "Booting Trusted Firmware")
+        wait_for_console_pattern(self, "BL1: v2.12.0(release):")
+        wait_for_console_pattern(self, "BL1: Booting BL2")
+
+        # Trusted Boot Firmware
+        wait_for_console_pattern(self, "BL2: v2.12.0(release)")
+        wait_for_console_pattern(self, "Booting BL31")
+
+        # EL3 Runtime Software
+        wait_for_console_pattern(self, "BL31: v2.12.0(release)")
+
+        # Non-trusted Firmware
+        wait_for_console_pattern(self, "UEFI firmware (version 1.0")
+        interrupt_interactive_console_until_pattern(self, "QEMU SBSA-REF Machine")
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
diff --git a/tests/functional/aarch64/test_arm_generic_fdt_alpine.py b/tests/functional/aarch64/test_arm_generic_fdt_alpine.py
new file mode 100755
index 0000000000..0589f260a4
--- /dev/null
+++ b/tests/functional/aarch64/test_arm_generic_fdt_alpine.py
@@ -0,0 +1,61 @@
+#!/usr/bin/env python3
+#
+# Functional test that boots a kernel and checks the console
+#
+# Based on test_arm_generic_fdt_alpine.py
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from qemu_test import QemuSystemTest, Asset, skipSlowTest
+from qemu_test import wait_for_console_pattern
+from test_arm_generic_fdt import fetch_firmware
+
+from pathlib import Path
+
+class Aarch64ArmGenericFdtAlpine(QemuSystemTest):
+
+    ASSET_ALPINE_ISO = Asset(
+        ('https://dl-cdn.alpinelinux.org/'
+         'alpine/v3.17/releases/aarch64/alpine-standard-3.17.2-aarch64.iso'),
+        '5a36304ecf039292082d92b48152a9ec21009d3a62f459de623e19c4bd9dc027')
+
+    current_dir = Path(__file__).resolve().parent
+
+    hw_dtb_path = current_dir.parent.parent/ "data" / "dtb" / "aarch64" / \
+        "arm-generic-fdt" / "arm64-sbsa-hw.dtb"
+
+    dtb_path = current_dir.parent.parent/ "data" / "dtb" / "aarch64" / \
+        "arm-generic-fdt" / "arm64-sbsa-guest.dtb"
+
+
+    # This tests the whole boot chain from EFI to Userspace
+    # We only boot a whole OS for the current top level CPU and GIC
+    # Other test profiles should use more minimal boots
+    def boot_alpine_linux(self):
+        self.set_machine('arm-generic-fdt')
+
+        fetch_firmware(self)
+        iso_path = self.ASSET_ALPINE_ISO.fetch()
+
+        self.vm.set_console()
+        self.vm.add_args('-machine', f'hw-dtb={self.hw_dtb_path}')
+        self.vm.add_args('-dtb', str(self.dtb_path))
+        self.vm.add_args(
+            "-device", f"ide-cd,bus=ahci.0,unit=0,drive=cdrom0",
+        )
+        self.vm.add_args(
+            "-drive", f"file={iso_path},if=none,id=cdrom0",
+        )
+        self.vm.add_args('-device', "bochs-display")
+        self.vm.add_args('-netdev', "user,id=net0")
+        self.vm.add_args('-device', "e1000e,netdev=net0")
+
+        self.vm.launch()
+        wait_for_console_pattern(self, "Welcome to Alpine Linux 3.17")
+
+    def test_alpine_linux(self):
+        self.boot_alpine_linux()
+
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
-- 
2.43.0


