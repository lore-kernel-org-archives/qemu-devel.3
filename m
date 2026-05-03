Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46093FF886F
	for <qemu-devel@archiver.kernel.org>; Sun,  3 May 2026 06:00:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJPrN-0001Gn-90; Sun, 03 May 2026 01:59:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <54weasels@gmail.com>)
 id 1wJM6H-0004xB-36
 for qemu-devel@nongnu.org; Sat, 02 May 2026 21:58:29 -0400
Received: from mail-dy1-x132f.google.com ([2607:f8b0:4864:20::132f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <54weasels@gmail.com>)
 id 1wJM6F-0000Z3-F2
 for qemu-devel@nongnu.org; Sat, 02 May 2026 21:58:28 -0400
Received: by mail-dy1-x132f.google.com with SMTP id
 5a478bee46e88-2dee127b3c5so7234327eec.1
 for <qemu-devel@nongnu.org>; Sat, 02 May 2026 18:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777773505; x=1778378305; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1QR6NDChDJEAzSKlkW2JjzGfYbC4Be2Ip1t74TmvjhY=;
 b=Vz37szzR8bQ6naELtPV/XOkFeIUJo0n3mzZkwFIDoZjxsWgV17tZ3ES2aCzNcV2wbf
 SrmhIgD8xYy4KJFUR17SrgZ7KvOnyh4caOyNHTypstU5v3sUfdcwDKu4nrDr5I+0VPSR
 WC1egrFmYc+gygzdJH4D3neICq94cnmpTqN9Z9EAsE9ksBhmDnhwFCH254iz5y+Px7QC
 WI5WtYT1sza6Glh3Rx8kTaOdL/yoQvMlp3bT+TwFCvqVGGtS9r8kA521Wm6p2EC+8tdp
 sciTS/QJERzTQEPqrlw7/MDeclRXmE1oB+12QR3c9fC+c14eoTvkSt479DPodUvy6cGq
 GEig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777773505; x=1778378305;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1QR6NDChDJEAzSKlkW2JjzGfYbC4Be2Ip1t74TmvjhY=;
 b=fuJHemPjd89ZDRLZGOJZikxFiQWaoIHJIXoE/2IUF+n7WRbGF+NkhpHknzoDaaCFzt
 jOGmVMubp2Qj4L/4H8beQ7SsbbeW66koipZuD6C5C6CGeSCbBjULe2ctzCHuH01VhTKg
 zAFNGNxFXjMOx6mNU0l1F2arhLMsE7jsKZpZdz9vSZlcFXHAwIAaCcVS5A/PyQylOTuF
 rJ8QupkkM9pADmLMJDb8d58K/t2M0VU7GHi27X5sHiA1/zNuWUAXOD7B6roLZsEE+RYz
 QObwKNQI9i7lu0Sbclubbc7ju72FGQQ7Q4BYlnfDHLR7PTvdxBw3EJSOJaFIuHcZ76uA
 Q70g==
X-Gm-Message-State: AOJu0YzU6SOg1Qn7dJCYG2tVcgMSiMtMbrJrM/b0wdjBFgoSb4j690Xm
 rliT36O1zUevmoDiGJ5vxxFX+wgDOJwdNoMNoOzu8bpUYZCmVGBftAyXKTZHDw==
X-Gm-Gg: AeBDiesfeMVJmqQHTac2+I2VLkEzn7PYADQEbQX+S1Xi3qTtJ5H8fIcCfh939XEWEw2
 GjXpbSf/49Hg6uhv40hzbIdQEPSbTTOmRVdAq39qJ+XPOGsp0qfKkDbzJB8iIqqFJq8mUBqjvFn
 8R2pwi0CUHBR8RLC0L6dU/ZOSIaSths/mgwJKBJPbYxdMoWeCcjpFqF9r49ipTC5R3/rr6+WjfG
 zCfA93LHdj9mrKWb+roqN3rtRD3dajGmlKOz0D8zEGPiF2/IRdeiQIQAN4crA7R1e2V8yl+jRQP
 yYAxI7G7vxGBbjLLbF6su5TS1rBSjYtsN0OFxhKHJwQnDNuEz1sJrwcoknWyrCG5wI0UXhqHhrb
 Y68lVq9ibIv/9bCMi9RmIBeH/Vk0F2Aj+5wpg2ZSlERUdINUJpwPXaZ2GZc1rXoACs59mf0Pjow
 rbpyjsTkgDJsOK8ZLTwkUBReRAeIX0grBA7cNP+k76+fBiYL15pw==
X-Received: by 2002:a05:7300:a18a:b0:2c5:60d0:701e with SMTP id
 5a478bee46e88-2efb79cc45amr2300616eec.3.1777773505012; 
 Sat, 02 May 2026 18:58:25 -0700 (PDT)
Received: from newsled.lan ([76.133.142.170]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ee38d79eb9sm14361735eec.8.2026.05.02.18.58.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 02 May 2026 18:58:24 -0700 (PDT)
From: 54weasels <54weasels@gmail.com>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
	thuth@redhat.com,
	54weasels <54weasels@gmail.com>
Subject: [PATCH 7/7] tests/functional: Add Sun-3 firmware boot and diagnostic
 test
Date: Sat,  2 May 2026 18:57:56 -0700
Message-ID: <20260503015756.99176-8-54weasels@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260503015756.99176-1-54weasels@gmail.com>
References: <20260503015756.99176-1-54weasels@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::132f;
 envelope-from=54weasels@gmail.com; helo=mail-dy1-x132f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 03 May 2026 01:59:20 -0400
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

This adds an integration test that downloads the Sun-3/60 Boot PROM, initializes the machine, and ensures the self-test successfully routes to TTY A.

Signed-off-by: 54weasels <54weasels@gmail.com>
---
 tests/functional/m68k/meson.build   |  1 +
 tests/functional/m68k/test_sun3.py  | 34 +++++++++++++++++++++++++++++
 tests/functional/qemu_test/asset.py | 11 +++++-----
 3 files changed, 41 insertions(+), 5 deletions(-)
 create mode 100755 tests/functional/m68k/test_sun3.py

diff --git a/tests/functional/m68k/meson.build b/tests/functional/m68k/meson.build
index 679faaf86d..601c28d863 100644
--- a/tests/functional/m68k/meson.build
+++ b/tests/functional/m68k/meson.build
@@ -9,5 +9,6 @@ tests_m68k_system_thorough = [
   'nextcube',
   'replay',
   'q800',
+  'sun3',
   'tuxrun',
 ]
diff --git a/tests/functional/m68k/test_sun3.py b/tests/functional/m68k/test_sun3.py
new file mode 100755
index 0000000000..f441184616
--- /dev/null
+++ b/tests/functional/m68k/test_sun3.py
@@ -0,0 +1,34 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#!/usr/bin/env python3
+#
+# Functional test that boots a Sun-3 machine and checks its serial console.
+#
+# Copyright (c) 2026
+#
+
+
+import os
+from qemu_test import QemuSystemTest, Asset
+from qemu_test import wait_for_console_pattern
+
+class Sun3Machine(QemuSystemTest):
+    timeout = 60
+
+    ASSET_PROM = Asset(
+        'https://github.com/54weasels/sun3_60/raw/main/bootprom/boot_1810_01.BIN',
+        '471bf34cc9313814726c2e3506d85a13291603e37b45aaffa71bc1154a2d4851'
+    )
+
+    def test_m68k_sun3_boot(self):
+        self.set_machine('sun3')
+        prom_path = self.ASSET_PROM.fetch()
+
+        # Sun-3 maps TTY A to serial_hd(3)
+        self.vm.set_console(console_index=3)
+        self.vm.add_args('-bios', prom_path)
+        self.vm.launch()
+
+        wait_for_console_pattern(self, '>')
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
diff --git a/tests/functional/qemu_test/asset.py b/tests/functional/qemu_test/asset.py
index 51a434b2b7..eac1e60536 100644
--- a/tests/functional/qemu_test/asset.py
+++ b/tests/functional/qemu_test/asset.py
@@ -223,11 +223,12 @@ def fetch(self):
             raise AssetError(self, "Download retries exceeded", transient=True)
 
         try:
-            # Set these just for informational purposes
-            os.setxattr(str(tmp_cache_file), "user.qemu-asset-url",
-                        self.url.encode('utf8'))
-            os.setxattr(str(tmp_cache_file), "user.qemu-asset-hash",
-                        self.hash.encode('utf8'))
+            if hasattr(os, 'setxattr'):
+                # Set these just for informational purposes
+                os.setxattr(str(tmp_cache_file), "user.qemu-asset-url",
+                            self.url.encode('utf8'))
+                os.setxattr(str(tmp_cache_file), "user.qemu-asset-hash",
+                            self.hash.encode('utf8'))
         except OSError as e:
             self.log.debug("Unable to set xattr on %s: %s", tmp_cache_file, e)
 
-- 
2.50.1 (Apple Git-155)


