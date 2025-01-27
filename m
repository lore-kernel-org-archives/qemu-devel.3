Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2000EC02188
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 14:26:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcQ4N-0006iG-RT; Mon, 27 Jan 2025 09:26:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tcQ47-0005qH-4d; Mon, 27 Jan 2025 09:26:17 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tcQ45-0003K0-BJ; Mon, 27 Jan 2025 09:26:14 -0500
Received: from localhost.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by isrv.corpit.ru (Postfix) with ESMTP id A698DE0F84;
 Mon, 27 Jan 2025 17:25:41 +0300 (MSK)
Received: by localhost.tls.msk.ru (Postfix, from userid 1000)
 id 9DEB751D9D; Mon, 27 Jan 2025 17:18:03 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.2.1 28/41] tests/functional/test_rx_gdbsim: Use stable URL
 for test_linux_sash
Date: Mon, 27 Jan 2025 17:17:42 +0300
Message-Id: <20250127141803.3514882-28-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.2.1-20250127154029@cover.tls.msk.ru>
References: <qemu-stable-9.2.1-20250127154029@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Yoshinori said [*] URL references on OSDN were stable, but they
appear not to be. Mirror the artifacts on GitHub to avoid failures
while testing on CI.

[*] https://www.mail-archive.com/qemu-devel@nongnu.org/msg686487.html

Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Reported-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-ID: <20200630202631.7345-1-f4bug@amsat.org>
[huth: Adapt the patch to the new version in the functional framework]
Message-ID: <20241229083419.180423-1-huth@tuxfamily.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
(cherry picked from commit ec2dfb7c389b94d71ee825caa20b709d5df6c166)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
(Mjt: fixup for missing v9.2.0-421-g65d35a4e27a8 "tests/functional: convert tests to new uncompress helper")

diff --git a/tests/functional/test_rx_gdbsim.py b/tests/functional/test_rx_gdbsim.py
index 5687f756bb..7daf1571c4 100755
--- a/tests/functional/test_rx_gdbsim.py
+++ b/tests/functional/test_rx_gdbsim.py
@@ -25,13 +25,16 @@ class RxGdbSimMachine(QemuSystemTest):
     KERNEL_COMMON_COMMAND_LINE = 'printk.time=0 '
 
     ASSET_UBOOT = Asset(
-        'https://acc.dl.osdn.jp/users/23/23888/u-boot.bin.gz',
-        '7146567d669e91dbac166384b29aeba1715beb844c8551e904b86831bfd9d046')
+        ('https://github.com/philmd/qemu-testing-blob/raw/rx-gdbsim/rx/gdbsim/'
+         'u-boot.bin'),
+        'dd7dd4220cccf7aeb32227b26233bf39600db05c3f8e26005bcc2bf6c927207d')
     ASSET_DTB = Asset(
-        'https://acc.dl.osdn.jp/users/23/23887/rx-virt.dtb',
+        ('https://github.com/philmd/qemu-testing-blob/raw/rx-gdbsim/rx/gdbsim/'
+         'rx-gdbsim.dtb'),
         'aa278d9c1907a4501741d7ee57e7f65c02dd1b3e0323b33c6d4247f1b32cf29a')
     ASSET_KERNEL = Asset(
-        'http://acc.dl.osdn.jp/users/23/23845/zImage',
+        ('https://github.com/philmd/qemu-testing-blob/raw/rx-gdbsim/rx/gdbsim/'
+         'zImage'),
         'baa43205e74a7220ed8482188c5e9ce497226712abb7f4e7e4f825ce19ff9656')
 
     def test_uboot(self):
@@ -40,9 +43,7 @@ def test_uboot(self):
         """
         self.set_machine('gdbsim-r5f562n8')
 
-        uboot_path_gz = self.ASSET_UBOOT.fetch()
-        uboot_path = os.path.join(self.workdir, 'u-boot.bin')
-        gzip_uncompress(uboot_path_gz, uboot_path)
+        uboot_path = self.ASSET_UBOOT.fetch()
 
         self.vm.set_console()
         self.vm.add_args('-bios', uboot_path,
-- 
2.39.5


