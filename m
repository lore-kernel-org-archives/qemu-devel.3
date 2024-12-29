Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ADD4E7718B
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Dec 2024 08:35:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tRoku-0003Ds-DO; Sun, 29 Dec 2024 03:34:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1tRoks-0003Df-0M
 for qemu-devel@nongnu.org; Sun, 29 Dec 2024 03:34:34 -0500
Received: from mail-ed1-f45.google.com ([209.85.208.45])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1tRokp-0006pa-Lv
 for qemu-devel@nongnu.org; Sun, 29 Dec 2024 03:34:33 -0500
Received: by mail-ed1-f45.google.com with SMTP id
 4fb4d7f45d1cf-5d3e829ff44so17149942a12.0
 for <qemu-devel@nongnu.org>; Sun, 29 Dec 2024 00:34:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735461270; x=1736066070;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=h+Hgu87QsLK6oJkMYANGR40GgxgsQMwzSa6Z0tHkt8Q=;
 b=oa+axaAWBsytAq8POBSXkGA8Zc17mz8xtIpoUJihuMrblFsevclGzaVozNVy+8mTW3
 LyEIpmE2KHk4xkjXimBe9V9xYtIXyNaXjLQ8OUrpwa86mVeQ43C2Z5mIwuynmcXf3jwy
 98lHjmtGcmnY3jOZTV9OFoWiHcLujXhrbC5zfuvc5actA7lv8j8GadptZd88AQ20eVdS
 5yQjC99bfU7veSMT3t4ULirTu4t+cJo8BgJoKcB0Q2CDPDU5kstSY3yc1iPeX0/fbYlF
 whaetjdHvENQz2Le5R5ilzZ04PI9GK+KTxnxBUcFCHN5xUZ1gxit52FwGioi5HZLjK3g
 WJKA==
X-Gm-Message-State: AOJu0YyRk91NC/9frW8cPkiB9xSHyH0MgumDEh13ELkcdqlji1aaL3d7
 ENmPpkgaw2+URmPp9Ie7QHSBCHRDsvXt9gtGXd/ADeE/rkpqn0ppFB29xg==
X-Gm-Gg: ASbGncvAeX5AKyrdgGIvA0Q4W6P6WwfJHB1LIFwzeOQ3kzJD4wU4JTJtCWTEhkjf9BN
 +zwQDzaADrFqLKoPwPjoxYXn+VZXSndUu/cj0vk8cNqYL/rpKa1Wt8oSe6qj56UTKC/sVgo26Mk
 bIF4E9jRCNtDOtprHvNVhbeRaCI7SEEZDjrm2ijjQU/H2OXIoVKOcL5+ut1160sjxM1EkvT1/Hg
 QonHADaTRWZa/95FFnW/XUAbwkKqMevS1Q0q34fHiAjK1l8+AfLH6sofFRHAwiK8MQblaEG6zoU
 KFc=
X-Google-Smtp-Source: AGHT+IGe26rvNUP4FoE0de5LEY9RgUif4tHW9vgOZw8JRsi2x9TQahwCvkwhMoc9l0dkXhMyUk8PKw==
X-Received: by 2002:a05:6402:e0a:b0:5d0:c9e6:30ba with SMTP id
 4fb4d7f45d1cf-5d81e8c12b4mr27466081a12.12.1735461269781; 
 Sun, 29 Dec 2024 00:34:29 -0800 (PST)
Received: from tpx1.. (ip-109-42-49-90.web.vodafone.de. [109.42.49.90])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d80675a6ddsm13030664a12.3.2024.12.29.00.34.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Dec 2024 00:34:28 -0800 (PST)
From: Thomas Huth <huth@tuxfamily.org>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH] tests/functional/test_rx_gdbsim: Use stable URL for
 test_linux_sash
Date: Sun, 29 Dec 2024 09:34:19 +0100
Message-ID: <20241229083419.180423-1-huth@tuxfamily.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.208.45; envelope-from=th.huth@gmail.com;
 helo=mail-ed1-f45.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.156, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Signed-off-by: Thomas Huth <huth@tuxfamily.org>
---
 tests/functional/test_rx_gdbsim.py | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/tests/functional/test_rx_gdbsim.py b/tests/functional/test_rx_gdbsim.py
index 20623aa51c..49245793e1 100755
--- a/tests/functional/test_rx_gdbsim.py
+++ b/tests/functional/test_rx_gdbsim.py
@@ -21,13 +21,16 @@ class RxGdbSimMachine(QemuSystemTest):
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
@@ -36,7 +39,7 @@ def test_uboot(self):
         """
         self.set_machine('gdbsim-r5f562n8')
 
-        uboot_path = self.uncompress(self.ASSET_UBOOT)
+        uboot_path = self.ASSET_UBOOT.fetch()
 
         self.vm.set_console()
         self.vm.add_args('-bios', uboot_path,
-- 
2.47.1


