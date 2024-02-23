Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 727C9C5478C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 16:02:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdXxr-0006A6-5X; Fri, 23 Feb 2024 10:59:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rdXhl-0004u0-IX; Fri, 23 Feb 2024 10:43:17 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rdXhj-00065M-SK; Fri, 23 Feb 2024 10:43:17 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1dc3b4b9b62so8664845ad.1; 
 Fri, 23 Feb 2024 07:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708702993; x=1709307793; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iBXeq96+UfEXt+7jPCdQXfYO8ZB/kavEKYzoN0HqVio=;
 b=BM7uEMiAUl/JJTnb2r2ojb76PeLojduGKBvqKB0+3pfJYitlvg2YhXlw9upTW0DSjV
 7cVfrTR35MV9DHvOmi28a0xDM3Go00K3GN/bM7SVj0RZ3ViJ/bax9FTHOHFF0xr7T3DX
 nCvtUFpDwokG/tKuuBKVS8Jwj/Q05Gtp+Ln0HFMUg9aZTN6CmJYbqpXrqR+tA/sAGegl
 Lyx8AOZ+E1rF4BdGeRSVHaEO4EuMvhHg0x5IS39oI677UG+7Zxx1GSPMY/WVvXfm8ij3
 L14ALxY1RijYiVLoFTQPXeq7OdZfM5LxqBT4Vy86eFzB0t3gbS1nBYvgstG0Nksdj50X
 9Keg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708702993; x=1709307793;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iBXeq96+UfEXt+7jPCdQXfYO8ZB/kavEKYzoN0HqVio=;
 b=uv4V+aYbFGzJsHi8VjwSHwSd8Ea7TqmgIJZXWuPOS8d6q1FKUT5Qpyt5Cyowd+WAMa
 q4Tfg5/Bmt9EGtRVPd9Uj002nHrNHxxzdoxMRIR+eajyJBRLl+2S7aixm7s0azSBNdP2
 zkkkYuZr4CyaXl426x+MYo7TTOch7DeAuVQUwWtTIW1Xt3/JfM93kO870yRR8UlTg+bW
 kgM5SEoHO4y88D7FwRorGQeelKmFYHPOIOO4fnW/7BP1EF0v/dcH83yNTh6LjKnVUVdG
 ZxzHTrD/zfmX8xlquf+xwdcEHbhFdwE9BlDiA0Qb9sU+gPV9LS2OlCDIDryFyuhZ8Ifd
 xEsw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOHrsCCa7ltpwbJoRRFYXZUlI2c8rXJxPKx5Asp/vD3mhTkUdGTrkuwwPWq38VlJKEvC/pZ+SW+GX5e2aLnRHOFxG9
X-Gm-Message-State: AOJu0YyC/7tK5Ntg4ifVXAWooBU0kbBsDTB+fLAQPD3UeNk3LFtLplu7
 XSxcpM1BA2gynE1GMCHda79G/x+E5StGRKJx+zrZC3DThcEo8Zzshe1igqgO
X-Google-Smtp-Source: AGHT+IGEeeaWn74Nc/+1IMJaIJVM0TtyvoSZDh/LkcIDhJL29E/AiPTUAYZ+eicNA9MvRjSPMSIVHw==
X-Received: by 2002:a17:902:db0a:b0:1db:c113:29bb with SMTP id
 m10-20020a170902db0a00b001dbc11329bbmr130684plx.34.1708702993474; 
 Fri, 23 Feb 2024 07:43:13 -0800 (PST)
Received: from wheely.local0.net (220-235-194-103.tpgi.com.au.
 [220.235.194.103]) by smtp.gmail.com with ESMTPSA id
 h18-20020a170902f2d200b001d913992d8csm11808208plc.242.2024.02.23.07.43.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Feb 2024 07:43:13 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PULL 06/47] tests/avocado: Add ppc pseries and powernv hash MMU tests
Date: Sat, 24 Feb 2024 01:41:25 +1000
Message-ID: <20240223154211.1001692-7-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240223154211.1001692-1-npiggin@gmail.com>
References: <20240223154211.1001692-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62b.google.com
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

Reviewed-by: Cédric Le Goater <clg@kaod.org>
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


