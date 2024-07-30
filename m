Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04909C3DA7F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 22:21:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYvCl-0006dK-48; Tue, 30 Jul 2024 18:20:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sYvCj-0006Yu-WD
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 18:20:26 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sYvCi-0006m2-Co
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 18:20:25 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-427b1d4da32so1835325e9.0
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 15:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722378022; x=1722982822; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jz7Ox8GZ4fBgHa8IWcCtoxPXphT3ERQSEGlUxQOFD08=;
 b=DM2fmEKVt93XKNnMwiPXKkQrEpwf5+VqSjrqJtZ05bWrtoaOnCFpf6yOpZ8yQ1trYf
 89LFLezi/ZgmozIah5i+pzX6sZzJpE0KswYKDgQkhKFdGTAg2liPrp3HntGU3OUdKuP8
 atCq8BcQ3gDJUuxxPS7bQF469bjB2sIq3U9gLSjFYljggQON/6QD56XhkdxcKTAxF4I+
 yCZNluWg0SNKeMsEn/c6yIUC5t5K2UGEfMqzOvcsNBjbChCinotfPAgYPa6f2kbhJl0h
 /kvMmR3CIRCp2CtP5kbNrr7PFuHOVJsswuuOPGfaZYeE9Ie1vjoMNtOD2rL4bPBgZLrd
 Dmaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722378022; x=1722982822;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jz7Ox8GZ4fBgHa8IWcCtoxPXphT3ERQSEGlUxQOFD08=;
 b=K7k1OCodBH9ye7+M7fSymGiJspLEeUJIo3e8lQvz2DakyNE+LptsfQgPzycAowoDxQ
 5y5/7ktDtqXoSFwthLzqpFgW0ImBzPgHuYC5VCqDY1pvF8dsWLtdzFllFCzorllUoCQR
 wl8jDFJqFaLQsAX7/aiaTRTSMphKdZIn2jf/fSf+JxdmBH+ur8NLrm9e3LZHqxlMssZi
 S0yb3frgLHoFTKTMRpXFT05GnWtnZH2c4rifwsTRt7IsEZQpP5zxjhoSs7/hpx4/zwP+
 sQAioWjuB1hUSRfvaQ5dyJ3bDQlwMzNncng2p8DV3aEXHWkgTh9PikqresgRJLSvl0+A
 ktUw==
X-Gm-Message-State: AOJu0Yza0GZ+5t3k6jAdERa5bgFAI+zsJuKGjVRbCDd/l8lMvhpvNLOy
 oxymqwWBx+ljIrypvnc5qZHrDIzyPQXB1hu0kF8zXdfsPw4si46+jBSD8lKkP/TExJoYKSxYZ9C
 0DDQ=
X-Google-Smtp-Source: AGHT+IGPMSzFTghrT3dvoTCVKkW3HeoG/18N9Mqvne+z0VR6Unk6wUd3x/p3lBPLAYLo4EfYEGfiUQ==
X-Received: by 2002:a5d:69cf:0:b0:367:89b0:f584 with SMTP id
 ffacd0b85a97d-36b8c8df022mr2162689f8f.11.1722378022645; 
 Tue, 30 Jul 2024 15:20:22 -0700 (PDT)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36b3685810csm15585144f8f.71.2024.07.30.15.20.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Jul 2024 15:20:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 5/6] tests/avocado: test_arm_emcraft_sf2: handle RW
 requirements for asset
Date: Wed, 31 Jul 2024 00:19:56 +0200
Message-ID: <20240730221957.34533-6-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730221957.34533-1-philmd@linaro.org>
References: <20240730221957.34533-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

From: Cleber Rosa <crosa@redhat.com>

The asset used in the mentioned test gets truncated before it's used
in the test.  This means that the file gets modified, and thus the
asset's expected hash doesn't match anymore.  This causes cache misses
and re-downloads every time the test is re-run.

Let's make a copy of the asset so that the one in the cache is
preserved and the cache sees a hit on re-runs.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20240726134438.14720-9-crosa@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/avocado/boot_linux_console.py | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tests/avocado/boot_linux_console.py b/tests/avocado/boot_linux_console.py
index b8b0a4df10..2929aa042d 100644
--- a/tests/avocado/boot_linux_console.py
+++ b/tests/avocado/boot_linux_console.py
@@ -401,14 +401,16 @@ def test_arm_emcraft_sf2(self):
                    'fe371d32e50ca682391e1e70ab98c2942aeffb01/spi.bin')
         spi_hash = '65523a1835949b6f4553be96dec1b6a38fb05501'
         spi_path = self.fetch_asset(spi_url, asset_hash=spi_hash)
+        spi_path_rw = os.path.join(self.workdir, os.path.basename(spi_path))
+        shutil.copy(spi_path, spi_path_rw)
 
-        file_truncate(spi_path, 16 << 20) # Spansion S25FL128SDPBHICO is 16 MiB
+        file_truncate(spi_path_rw, 16 << 20) # Spansion S25FL128SDPBHICO is 16 MiB
 
         self.vm.set_console()
         kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE
         self.vm.add_args('-kernel', uboot_path,
                          '-append', kernel_command_line,
-                         '-drive', 'file=' + spi_path + ',if=mtd,format=raw',
+                         '-drive', 'file=' + spi_path_rw + ',if=mtd,format=raw',
                          '-no-reboot')
         self.vm.launch()
         self.wait_for_console_pattern('Enter \'help\' for a list')
-- 
2.45.2


