Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40C19C48BC3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 08:34:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbz2f-0000Ax-VB; Mon, 19 Feb 2024 03:30:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rbz2e-0000Ah-7L; Mon, 19 Feb 2024 03:30:24 -0500
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rbz2c-00029R-5t; Mon, 19 Feb 2024 03:30:23 -0500
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6e45c92a199so490080b3a.2; 
 Mon, 19 Feb 2024 00:30:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708331420; x=1708936220; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YLpVpr4lXcxtiYkgYwO8f+zCCPIx0i1aEW37ifuFYyc=;
 b=dJ9LIgGrSZtDWeH6cpbKYf5Pz+vYT5wklrHsx6g3VMg9gqEE6mB61tnGu8q+IhKIEN
 Ir0a40OvcGZVfE3BCECG1H1Zg4YdTRlXiW5uj2Z1Md1QvIFpxZJPFdgNwrtCShQnx6q6
 axphbS1Z+hGMibzjJ6bnr/maWjdfRToETihQ9XIATGPGuyC/LZFQajUu/7nsNZm2poT8
 b9AhDkkHsezuoCN6Ug2Pqi+dsAVGuxtyLdV1lBxoPEmZdOhqi7DtbPWOknxRpaZae0wx
 Mni/GwCHN1ARM/aVckB6qMR4Mx7P0NKXpqNw87vXLxABxg3Qr3crUzWG80mEBCec89mj
 8Ung==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708331420; x=1708936220;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YLpVpr4lXcxtiYkgYwO8f+zCCPIx0i1aEW37ifuFYyc=;
 b=Gno69+GaUFgAJfAXELAXfQjcusU/xB79lKpG6icLMFGOUbDy9+glgPDuPNnu8I9jjn
 iLgU6TiVsS+HO3P7gQaSJUx0fcsdB+ckI2+l+tNJZCRGxtcpvXz33gjMPqdnjnjKfTvK
 IIwCLg50UczoitTrCvqiBNYWjHIHPc19ykQgaMbFdDhqCueEtDE1aQaPUXL9TqEdvp9w
 AUR33dIx3jmZ8xJwn5ktW5yn0YaSBQrvWQNbLCjXz/DfA+zkjoFriodmjJRJkWU6CrKE
 8OJOhsMVDfqyZ/v+12mXaaJmdm+3luVxubOezj+ZHwheGMn5IYOnsGtM5orPOa9xKkKL
 6n0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCU05BB2sB8NYu3Jlakk+H5DbxuVEHmGLbaV0P551+b/M7LfMA8QRUaKb/p0kS7A4dmHk1y4373cx7LSkICH4ElfDv7A
X-Gm-Message-State: AOJu0YxVxGUJbtdhc4bWi8KFoK2z7dwQWw5wL6Z1BkqJFI1JLkD0WyhH
 txBezuhYMTHjkUzUjoNP6RbRjGjSMsVqm2S+NQpIhcgbZUZ3brqIAToHOO8X
X-Google-Smtp-Source: AGHT+IEgPExjIy3KTTTGifVJiow8bNNYhS32M7iedLVLAWUz7LU+RKTxtjAHcr7xR2ahA1iyoM4ZCQ==
X-Received: by 2002:a05:6a21:3941:b0:1a0:86af:510b with SMTP id
 ac1-20020a056a21394100b001a086af510bmr12422485pzc.32.1708331420271; 
 Mon, 19 Feb 2024 00:30:20 -0800 (PST)
Received: from wheely.local0.net ([1.146.38.93])
 by smtp.gmail.com with ESMTPSA id
 mo7-20020a1709030a8700b001db5ecd115bsm3838348plb.276.2024.02.19.00.30.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Feb 2024 00:30:20 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PULL 06/49] tests/avocado: Add ppc pseries and powernv hash MMU tests
Date: Mon, 19 Feb 2024 18:28:55 +1000
Message-ID: <20240219082938.238302-7-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240219082938.238302-1-npiggin@gmail.com>
References: <20240219082938.238302-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

POWER CPUs support hash and radix MMU modes. Linux supports running in
either mode, but defaults to radix. To keep up testing of QEMU's hash
MMU implementation, add some Linux hash boot tests.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/avocado/ppc_powernv.py | 23 +++++++++++++++++++----
 tests/avocado/ppc_pseries.py | 20 +++++++++++++++++---
 2 files changed, 36 insertions(+), 7 deletions(-)

diff --git a/tests/avocado/ppc_powernv.py b/tests/avocado/ppc_powernv.py
index d0e5c07bde..4342941d5d 100644
--- a/tests/avocado/ppc_powernv.py
+++ b/tests/avocado/ppc_powernv.py
@@ -12,11 +12,11 @@
 class powernvMachine(QemuSystemTest):
 
     timeout = 90
-    KERNEL_COMMON_COMMAND_LINE = 'printk.time=0 '
+    KERNEL_COMMON_COMMAND_LINE = 'printk.time=0 console=hvc0 '
     panic_message = 'Kernel panic - not syncing'
     good_message = 'VFS: Cannot open root device'
 
-    def do_test_linux_boot(self):
+    def do_test_linux_boot(self, command_line = KERNEL_COMMON_COMMAND_LINE):
         self.require_accelerator("tcg")
         kernel_url = ('https://archives.fedoraproject.org/pub/archive'
                       '/fedora-secondary/releases/29/Everything/ppc64le/os'
@@ -25,9 +25,8 @@ def do_test_linux_boot(self):
         kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
 
         self.vm.set_console()
-        kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE + 'console=hvc0'
         self.vm.add_args('-kernel', kernel_path,
-                         '-append', kernel_command_line)
+                         '-append', command_line)
         self.vm.launch()
 
     def test_linux_boot(self):
@@ -54,6 +53,22 @@ def test_linux_smp_boot(self):
         wait_for_console_pattern(self, console_pattern, self.panic_message)
         wait_for_console_pattern(self, self.good_message, self.panic_message)
 
+    def test_linux_smp_hpt_boot(self):
+        """
+        :avocado: tags=arch:ppc64
+        :avocado: tags=machine:powernv
+        :avocado: tags=accel:tcg
+        """
+
+        self.vm.add_args('-smp', '4')
+        self.do_test_linux_boot(self.KERNEL_COMMON_COMMAND_LINE +
+                                'disable_radix')
+        console_pattern = 'smp: Brought up 1 node, 4 CPUs'
+        wait_for_console_pattern(self, 'hash-mmu: Initializing hash mmu',
+                                 self.panic_message)
+        wait_for_console_pattern(self, console_pattern, self.panic_message)
+        wait_for_console_pattern(self, self.good_message, self.panic_message)
+
     def test_linux_smt_boot(self):
         """
         :avocado: tags=arch:ppc64
diff --git a/tests/avocado/ppc_pseries.py b/tests/avocado/ppc_pseries.py
index a8311e6555..74aaa4ac4a 100644
--- a/tests/avocado/ppc_pseries.py
+++ b/tests/avocado/ppc_pseries.py
@@ -12,11 +12,11 @@
 class pseriesMachine(QemuSystemTest):
 
     timeout = 90
-    KERNEL_COMMON_COMMAND_LINE = 'printk.time=0 '
+    KERNEL_COMMON_COMMAND_LINE = 'printk.time=0 console=hvc0 '
     panic_message = 'Kernel panic - not syncing'
     good_message = 'VFS: Cannot open root device'
 
-    def do_test_ppc64_linux_boot(self):
+    def do_test_ppc64_linux_boot(self, kernel_command_line = KERNEL_COMMON_COMMAND_LINE):
         kernel_url = ('https://archives.fedoraproject.org/pub/archive'
                       '/fedora-secondary/releases/29/Everything/ppc64le/os'
                       '/ppc/ppc64/vmlinuz')
@@ -24,7 +24,6 @@ def do_test_ppc64_linux_boot(self):
         kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
 
         self.vm.set_console()
-        kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE + 'console=hvc0'
         self.vm.add_args('-kernel', kernel_path,
                          '-append', kernel_command_line)
         self.vm.launch()
@@ -62,6 +61,21 @@ def test_ppc64_linux_smp_boot(self):
         wait_for_console_pattern(self, console_pattern, self.panic_message)
         wait_for_console_pattern(self, self.good_message, self.panic_message)
 
+    def test_ppc64_linux_hpt_smp_boot(self):
+        """
+        :avocado: tags=arch:ppc64
+        :avocado: tags=machine:pseries
+        """
+
+        self.vm.add_args('-smp', '4')
+        self.do_test_ppc64_linux_boot(self.KERNEL_COMMON_COMMAND_LINE +
+                                      'disable_radix')
+        console_pattern = 'smp: Brought up 1 node, 4 CPUs'
+        wait_for_console_pattern(self, 'hash-mmu: Initializing hash mmu',
+                                 self.panic_message)
+        wait_for_console_pattern(self, console_pattern, self.panic_message)
+        wait_for_console_pattern(self, self.good_message, self.panic_message)
+
     def test_ppc64_linux_smt_boot(self):
         """
         :avocado: tags=arch:ppc64
-- 
2.42.0


