Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA74606B1B0
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 14:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.a=rsa-sha256 header.s=dkim header.b=Rd6jGprI
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRrkA-0003Qp-17; Fri, 13 Nov 2026 08:55:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <w-yf22@mails.tsinghua.edu.cn>)
 id 1xRnuo-00053w-Lz; Fri, 13 Nov 2026 04:49:51 -0500
Received: from smtp47.tsinghua.edu.cn ([101.6.4.71] helo=tsinghua.edu.cn)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <w-yf22@mails.tsinghua.edu.cn>)
 id 1xRnum-0007HV-1q; Fri, 13 Nov 2026 04:49:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding; bh=viiGAP8e3z2TV5xJPIJjEvP2kcw6fenlIY
 rS/5Ar4jw=; b=Rd6jGprIjhq0miBAc0vyC64tGn1UzEyBzQTEGXoX16ariMIhH5
 C6pSupm1YHeSUuVp0UhLITbqE3KcLyUZ8LRx4wCbBzI1iY5t1HrMV7b6tzmmEieE
 M8Mlxq1EPbPWAutVFSt5wVGQ+cI473SXXQWtHJN6P8RsmLVeJ2EU2dd4k=
Received: from ubuntu (unknown [101.5.154.165])
 by web1 (Coremail) with SMTP id yAQGZQA3qzvR3PZqgA5CAg--.9318S21;
 Fri, 13 Nov 2026 17:49:39 +0800 (CST)
From: Yifan Wang <w-yf22@mails.tsinghua.edu.cn>
To: qemu-devel@nongnu.org
Cc: Yifan Wang <w-yf22@mails.tsinghua.edu.cn>, qemu-arm@nongnu.org,
 qemu-block@nongnu.org, kvm@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Kuan-Wei Chiu <visitorckw@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 bin.meng@processmission.com, tangtao1634@phytium.com.cn,
 Chao Liu <chao.liu@processmission.com>
Subject: [RFC PATCH 19/20] tests/functional: add ROCK 5B boot tests
Date: Fri, 13 Nov 2026 17:47:53 +0800
Message-ID: <4be0c395b80a8d69b9ef975d157751fdabccb049.1794555589.git.w-yf22@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1794555588.git.w-yf22@mails.tsinghua.edu.cn>
References: <cover.1794555588.git.w-yf22@mails.tsinghua.edu.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: yAQGZQA3qzvR3PZqgA5CAg--.9318S21
X-Coremail-Antispam: 1UD129KBjvJXoWxKw1rCw4UKr48CFy5tw1xGrg_yoWxXr4rpw
 4UCr1UKr4xGF18Jr1IkFs7uF4rAw4vkFW7Jr42grZa9wnxJF1Igry5Kr1Fka43Xr9Yvasa
 kasYqr4xKFWUCaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUHa14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
 kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
 z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
 4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
 3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0V
 AKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1l
 Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErc
 IFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE14v_
 GFWl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
 WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI
 7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
 4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4U
 MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfUeVbkUU
 UUU
X-CM-SenderInfo: fzn1wj2s6ptxtovo32xlqjx3vdohv3gofq/
Received-SPF: pass client-ip=101.6.4.71;
 envelope-from=w-yf22@mails.tsinghua.edu.cn; helo=tsinghua.edu.cn
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 13 Nov 2026 08:53:54 -0500
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

From: Chao Liu <chao.liu@processmission.com>

Add tests for both boot methods, direct Linux booting and firmware
booting, and check that the boot flow works for each of them.

Signed-off-by: Chao Liu <chao.liu@processmission.com>
Signed-off-by: Yifan Wang <w-yf22@mails.tsinghua.edu.cn>
---
 MAINTAINERS                              |   1 +
 tests/functional/aarch64/meson.build     |   2 +
 tests/functional/aarch64/test_rock_5b.py | 118 +++++++++++++++++++++++
 3 files changed, 121 insertions(+)
 create mode 100755 tests/functional/aarch64/test_rock_5b.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 544d93c01d..6303b99755 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1074,6 +1074,7 @@ F: hw/timer/rockchip-hptimer.c
 F: include/hw/arm/rk3588.h
 F: include/hw/misc/rk3588-scmci.h
 F: include/hw/timer/rockchip-hptimer.h
+F: tests/functional/aarch64/test_rock_5b.py
 
 SABRELITE / i.MX6
 M: Peter Maydell <peter.maydell@linaro.org>
diff --git a/tests/functional/aarch64/meson.build b/tests/functional/aarch64/meson.build
index f0881bed16..d6b79314e6 100644
--- a/tests/functional/aarch64/meson.build
+++ b/tests/functional/aarch64/meson.build
@@ -11,6 +11,7 @@ test_aarch64_timeouts = {
   'reverse_debug' : 180,
   'rme_virt' : 1200,
   'rme_sbsaref' : 1200,
+  'rock_5b' : 180,
   'sbsaref_alpine' : 1200,
   'sbsaref_freebsd' : 720,
   'smmu' : 720,
@@ -45,6 +46,7 @@ tests_aarch64_system_thorough = [
   'reverse_debug',
   'rme_virt',
   'rme_sbsaref',
+  'rock_5b',
   'sbsaref',
   'sbsaref_alpine',
   'sbsaref_freebsd',
diff --git a/tests/functional/aarch64/test_rock_5b.py b/tests/functional/aarch64/test_rock_5b.py
new file mode 100755
index 0000000000..5789cfb2c2
--- /dev/null
+++ b/tests/functional/aarch64/test_rock_5b.py
@@ -0,0 +1,118 @@
+# Functional test for ROCK 5B SPL, U-Boot and direct Linux boot
+#
+# Copyright (C) 2026 Process Mission
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from qemu_test import Asset, QemuSystemTest, skipIfMissingCommands
+from qemu_test import exec_command, exec_command_and_wait_for_pattern
+from qemu_test import wait_for_console_pattern
+
+
+class Rock5BMachine(QemuSystemTest):
+
+    ASSET_IMAGE = Asset(
+        ('https://github.com/processmission/qemu-machine-images/releases/'
+         'download/v1.2.0/aarch64-rock-5b-v1.2.0.tar.zst'),
+        'bbec789f25a5e87adb1aeabf58294551d2a26bbf076e0041935f307a9492ce6f')
+
+    UBOOT_PATTERNS = ('U-Boot SPL 2025.01',
+                      'Trying to boot from SPI',
+                      'U-Boot 2025.01',
+                      'SF: Detected xt25f128',
+                      'SF: 12582912 bytes @ 0x400000 Read: OK',
+                      'Starting kernel')
+    LINUX_PATTERNS = ('Booting Linux on physical CPU',)
+    LINUX_APPEND = ('console=ttyS2,1500000n8 '
+                    'earlycon=uart8250,mmio32,0xfeb50000 '
+                    'rdinit=/init')
+
+    def _extract_images(self) -> None:
+        self.require_accelerator('tcg')
+        self.set_machine('rock-5b')
+        archive = self.uncompress(self.ASSET_IMAGE, target='images.tar',
+                                  format='zstd')
+        self.archive_extract(archive, format='tar')
+
+    def _boot_and_login(self, patterns: tuple[str, ...]) -> None:
+        for pattern in patterns + ('rock5b login:',):
+            wait_for_console_pattern(self, pattern, 'Kernel panic')
+        exec_command_and_wait_for_pattern(self, 'root', '# ')
+
+    def _check_guest(self, command: str) -> None:
+        # Split the marker so an echoed command cannot satisfy the check.
+        exec_command_and_wait_for_pattern(
+            self,
+            command + " && printf '\\nROCK5B_%s\\n' OK"
+                      " || printf '\\nROCK5B_%s\\n' FAIL",
+            'ROCK5B_OK', 'ROCK5B_FAIL')
+        wait_for_console_pattern(self, '# ')
+
+    def _check_board(self) -> None:
+        self._check_guest('test "$(uname -m)" = aarch64')
+        self._check_guest('test "$(grep -c ^processor /proc/cpuinfo)" -eq 8')
+        self._check_guest('test -c /dev/ttyS2 && '
+                          'test -d /sys/devices/system/cpu/cpu7')
+        self._check_guest(
+            'test "$(tr -d \'\\000\' < /proc/device-tree/model)" '
+            '= \'Radxa ROCK 5B\'')
+        self._check_guest(
+            "tr '\\000' '\\n' < /proc/device-tree/compatible | "
+            "grep -qx 'radxa,rock-5b'")
+        self._check_guest(
+            "printf 'rock5b-boot\\n' > /root/boot-check && "
+            'test "$(cat /root/boot-check)" = rock5b-boot')
+
+    def _reboot_and_poweroff(self, patterns: tuple[str, ...]) -> None:
+        exec_command(self, 'reboot -f')
+        self._boot_and_login(patterns)
+        self._check_guest('test "$(grep -c ^processor /proc/cpuinfo)" -eq 8')
+        self._check_guest('test ! -e /root/boot-check')
+
+        exec_command_and_wait_for_pattern(self, 'poweroff -f',
+                                          'reboot: Power down')
+        self.vm.wait()
+        self.assertEqual(self.vm.exitcode(), 0)
+
+    @skipIfMissingCommands('zstd')
+    def test_flash_boot(self) -> None:
+        self._extract_images()
+        firmware = self.scratch_file('images', 'u-boot-spl.bin')
+        flash = self.scratch_file('images', 'spi-nor.img')
+
+        self.vm.set_console()
+        self.vm.add_args('-accel', 'tcg', '-m', '2G', '-smp', '8',
+                         '-bios', firmware,
+                         '-drive', f'if=mtd,index=0,file={flash},'
+                                   'format=raw,snapshot=on')
+        self.vm.launch()
+        self._boot_and_login(self.UBOOT_PATTERNS)
+        self._check_board()
+        self._reboot_and_poweroff(self.UBOOT_PATTERNS)
+
+    @skipIfMissingCommands('zstd')
+    def test_direct_boot(self) -> None:
+        self._extract_images()
+
+        self.vm.set_console()
+        # 5 GiB of RAM continues above the peripheral hole at 0x100000000.
+        self.vm.add_args('-accel', 'tcg', '-m', '5G', '-smp', '8',
+                         '-kernel', self.scratch_file('images', 'Image'),
+                         '-initrd',
+                         self.scratch_file('images', 'rootfs.cpio.gz'),
+                         '-dtb',
+                         self.scratch_file('images', 'rk3588-rock-5b.dtb'),
+                         '-append', self.LINUX_APPEND)
+        self.vm.launch()
+        self._boot_and_login(self.LINUX_PATTERNS)
+        self._check_board()
+        self._check_guest('grep -q rdinit=/init /proc/cmdline')
+        self._check_guest('test -d /proc/device-tree/memory@100000000')
+        # Low RAM ends at 0xf0000000, which is 3932160 KiB.
+        self._check_guest(
+            'test "$(awk \'/^MemTotal/ {print $2}\' /proc/meminfo)" '
+            '-gt 3932160')
+        self._reboot_and_poweroff(self.LINUX_PATTERNS)
+
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
-- 
2.53.0


