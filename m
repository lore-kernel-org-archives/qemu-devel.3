Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B2BEC5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 17:44:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjjfR-0003mo-99; Mon, 11 Mar 2024 13:42:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rjjf4-0003XS-SY
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 13:42:10 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rjjf3-0007RK-2f
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 13:42:06 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6e6082eab17so4249266b3a.1
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 10:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710178923; x=1710783723; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qeSHK80EhLg2UFHrD4A9Wejbe45HGPILp3WXNbs1+Gg=;
 b=m21FOnuqbxGSpSe8QnUU73H6Ql5x+HrtfKizTOGTXGuMPFeU59dnerXzuYWEx6mRus
 /HUIAnNckATtfIhyHOhw4YBXQcbcBlyHykSRjdcp6YZo/QMB+I0ojzaLQ19rFKWej6q5
 M2HisrYjIRN8JsZqx56dOWFXoXw6hzzSQVyVFxj4anc5YKRD7LnKTq97pOmb/MLopN3m
 XsqWcqmaltaipTeq6Nz3LyYP7oEfiyxyO9mkQzQKySFvzuQa9fSGSkHscnlvVzhR0GIC
 A4wP1cNBuen5gAXhCWAtXUTUsz1p2MdyT438TRYzHd8lPRDCbnw2CYoZ7gCgEEMdh2mK
 Z15A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710178923; x=1710783723;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qeSHK80EhLg2UFHrD4A9Wejbe45HGPILp3WXNbs1+Gg=;
 b=LrR/qGWzz4U+Fn3Y+T547k2W0EUJvCweBkaRup35AWnHdU2rNE2UH/68KbcHECyUyM
 HgrKaKwSQ0yyq1DTWJKvBSiNF6QMKwa59xlwCTFHaqVBStcfGmXVg37xDWfjb5N0p65N
 zPwZgw9+vFo8uBYZ7UW+Fo9OPcYyZXfkZq1kzuWJPwxf+VqIIUX2e5mEPUTcceXM/LFo
 uqIhmYQvsdBDU6kO5dFqJtagiZmcvMaQRfWJIKBpVNphlm4LDhxUa7PGf+X3sZSrNPI5
 wiGGSR4ijCom8EgffqA9Pii5YBZcHDnlh2lCN7q/0QilDdVg0ycm5M/bYtPYDyKDKDtK
 Duhw==
X-Gm-Message-State: AOJu0Yw+k0u0iqVDWwGl8J1/zX7PCfI6bu2rvsP1scYWV2pZI4x2uUy5
 rHA+co9y9Hi+00eQkmKqIb1H6OBKxt45IzfmVfP1o0XZ2avRlYjnICWmx+ozscc=
X-Google-Smtp-Source: AGHT+IHGQWAaxsZtgzkETkkuaFLblyFRr8Tgd6HFQeOMY1sa066PPD8IdYR8kL4JR3pvu3Zxdok4OA==
X-Received: by 2002:a05:6a00:228e:b0:6e6:878b:fbc3 with SMTP id
 f14-20020a056a00228e00b006e6878bfbc3mr1234061pfe.32.1710178922958; 
 Mon, 11 Mar 2024 10:42:02 -0700 (PDT)
Received: from wheely.local0.net ([118.208.155.46])
 by smtp.gmail.com with ESMTPSA id
 a18-20020a62d412000000b006e67b4d7b74sm4593187pfh.197.2024.03.11.10.41.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 10:42:02 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH v4 16/24] tests/avocado: reverse_debugging.py verify addresses
 between record and replay
Date: Tue, 12 Mar 2024 03:40:18 +1000
Message-ID: <20240311174026.2177152-17-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240311174026.2177152-1-npiggin@gmail.com>
References: <20240311174026.2177152-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42f.google.com
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

gdb is only attached in the replay phase, and the recorded trace is
single-stepped to build up an address map that is used to then verify
reverse-step and reverse-continue.

This change attaches gdb in the record phase, and builds the address
map by single-stepping the live machine. That address map is then
verified by single-stepping the replay, and then used for the same
reverse debug verification.

This is a stronger verifcation between the record and the replay phases,
as well as providing some testing of gdb operation in record mode.

x86_64 has some problems with single-stepping here, so add a flag to
avoid some of the new checks.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/avocado/reverse_debugging.py | 66 ++++++++++++++++++++++++------
 1 file changed, 53 insertions(+), 13 deletions(-)

diff --git a/tests/avocado/reverse_debugging.py b/tests/avocado/reverse_debugging.py
index e76cf54ad7..a790c342a8 100644
--- a/tests/avocado/reverse_debugging.py
+++ b/tests/avocado/reverse_debugging.py
@@ -45,7 +45,7 @@ def run_vm(self, record, shift, args, replay_path, image_path, port):
         else:
             logger.info('replaying the execution...')
             mode = 'replay'
-            vm.add_args('-gdb', 'tcp::%d' % port, '-S')
+        vm.add_args('-gdb', 'tcp::%d' % port, '-S')
         vm.add_args('-icount', 'shift=%s,rr=%s,rrfile=%s,rrsnapshot=init' %
                     (shift, mode, replay_path),
                     '-net', 'none')
@@ -87,6 +87,17 @@ def check_pc(self, g, addr):
         if pc != addr:
             self.fail('Invalid PC (read %x instead of %x)' % (pc, addr))
 
+    @staticmethod
+    def gdb_cont(g):
+        g.cmd(b'c')
+
+    @staticmethod
+    def gdb_cont_nowait(g):
+        # The avocado GDBRemote does not have a good way to disconnect or
+        # continue without waiting for a reply, so open-code our own here.
+        data = g.encode(b'c')
+        g._socket.send(data)
+
     @staticmethod
     def gdb_step(g):
         g.cmd(b's', b'T05thread:01;')
@@ -99,7 +110,7 @@ def gdb_bstep(g):
     def vm_get_icount(vm):
         return vm.qmp('query-replay')['return']['icount']
 
-    def reverse_debugging(self, shift=7, args=None):
+    def reverse_debugging(self, shift=7, args=None, x86_workaround=False):
         logger = logging.getLogger('replay')
 
         # create qcow2 for snapshots
@@ -117,11 +128,40 @@ def reverse_debugging(self, shift=7, args=None):
         replay_path = os.path.join(self.workdir, 'replay.bin')
         port = find_free_port()
 
+        steps = []
+
         # record the log
         vm = self.run_vm(True, shift, args, replay_path, image_path, port)
+        logger.info('connecting to gdbstub')
+        g = gdb.GDBRemote('127.0.0.1', port, False, False)
+        g.connect()
+        r = g.cmd(b'qSupported')
+        if b'qXfer:features:read+' in r:
+            g.cmd(b'qXfer:features:read:target.xml:0,ffb')
+
+        if self.vm_get_icount(vm) != 0:
+            self.fail('icount does not start at zero')
+
+        # save the addresses of the first STEPS instructions executed
+        logger.info('stepping forward')
+        for i in range(self.STEPS):
+            pc = self.get_pc(g)
+            logger.info('saving position %x' % pc)
+            steps.append(pc)
+            self.gdb_step(g)
+            if x86_workaround and i == 0 and self.vm_get_icount(vm) == 0:
+                logger.warn('failed to take first step, stepping again')
+                self.gdb_step(g)
+        if self.vm_get_icount(vm) != self.STEPS:
+            self.fail('icount (%d) does not match number of instructions stepped' % self.vm_get_icount(vm))
+
+        logger.info('continue running')
+        self.gdb_cont_nowait(g)
+
         while self.vm_get_icount(vm) <= self.STEPS:
             pass
         last_icount = self.vm_get_icount(vm)
+        logger.info('shutdown...')
         vm.shutdown()
 
         logger.info("recorded log with %s+ steps" % last_icount)
@@ -139,23 +179,23 @@ def reverse_debugging(self, shift=7, args=None):
         if b'ReverseContinue+' not in r:
             self.fail('Reverse continue is not supported by QEMU')
 
+        # Try single stepping
         logger.info('stepping forward')
-        steps = []
-        # record first instruction addresses
-        for _ in range(self.STEPS):
-            pc = self.get_pc(g)
-            logger.info('saving position %x' % pc)
-            steps.append(pc)
+        for addr in steps:
+            # verify addresses match what initial execution saw
+            self.check_pc(g, addr)
             self.gdb_step(g)
+            logger.info('found position %x' % addr)
 
-        # visit the recorded instruction in reverse order
+        # Try reverse stepping
         logger.info('stepping backward')
         for addr in steps[::-1]:
             self.gdb_bstep(g)
+            # verify addresses match what initial execution saw
             self.check_pc(g, addr)
             logger.info('found position %x' % addr)
 
-        # visit the recorded instruction in forward order
+        # Step forward again
         logger.info('stepping forward')
         for addr in steps:
             self.check_pc(g, addr)
@@ -175,7 +215,7 @@ def reverse_debugging(self, shift=7, args=None):
         # continue - will return after pausing
         # This could stop at the end and get a T02 return, or by
         # re-executing one of the breakpoints and get a T05 return.
-        g.cmd(b'c')
+        self.gdb_cont(g)
         if self.vm_get_icount(vm) == last_icount - 1:
             logger.info('reached the end (icount %s)' % (last_icount - 1))
         else:
@@ -213,7 +253,7 @@ def test_x86_64_pc(self):
         :avocado: tags=machine:pc
         """
         # start with BIOS only
-        self.reverse_debugging()
+        self.reverse_debugging(x86_workaround=True)
 
     def test_x86_64_q35(self):
         """
@@ -221,7 +261,7 @@ def test_x86_64_q35(self):
         :avocado: tags=machine:q35
         """
         # start with BIOS only
-        self.reverse_debugging()
+        self.reverse_debugging(x86_workaround=True)
 
 class ReverseDebugging_AArch64(ReverseDebugging):
     """
-- 
2.42.0


