Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2F5ECCA470
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 02:07:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v48hl-0006uX-0H; Wed, 01 Oct 2025 22:06:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1v48hf-0006tL-E8
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 22:05:57 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1v48h6-0004vG-PM
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 22:05:55 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-27c369f8986so4588245ad.3
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 19:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759370713; x=1759975513; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2jPSIPajWmCSdEgDckhGxRC3Fx6a7Y2qPrhYAvCWPhk=;
 b=gEwLULUZXgFrTVi8hb6fWvAq8nw3Vnnz2elNvjEhr7Ci+BUCr/aU4o/SoD7BfS7Vv4
 cTy2RplZiIXH+zNoewXNCpptVj+pABToVO24B0wtQDZmnacmBuHmh5/SpklIFbMrRwG0
 gvYAQdZcsSgj3XheqK8uO5RsWtjfsvqt0NZ6ydC4nYd+dXYrqSOj7POu3N2NamU7Hgck
 +9jj5aKxqOV5IsfZR7V4cz+fEAnPE0BnUYd2P+ks6zIK6rSHwRcJx4PYIEFaRy93g1zx
 nwqX2MPlICDQRHW/obHnzmV2sn5Xxo6yRTG7l1YOgj1z9E86+xae4KKR/UV5C3jbEtFR
 pt8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759370713; x=1759975513;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2jPSIPajWmCSdEgDckhGxRC3Fx6a7Y2qPrhYAvCWPhk=;
 b=DIK287J8hb5hOjO+IVaKoK6yFYqIWuG+zk/B/inu9Gs/Iqvx7Y5M3LRqOpiKh19EHw
 OJniCsycw8tLwBLTUN2AAFn6w74p1FAcxW3adazHLJIBdDAOZBBPJMKmCEsEOhv8vCVx
 wUe/r5M3ujdOikcvyFn9DkIxsHhzezQ0g4Bds+4dUPftK7W4Jgjk8KTja9gfBTfi0yeS
 bavlmnNebzoGNDaraoWC6QSLWfvDKMpTTK7LzAEyeykCA5bHeBg4htyfJbJuT7uq+k76
 klLmg1+Qv9TotTYWNza6ghGPGCeUshlB1A03ELofVdtdP8RmGY2MuAGV2eMdvVyYIpp4
 Uycw==
X-Gm-Message-State: AOJu0Yy0dn+HVRZTHYLE+LKqbkGECtvtGMZSNV1yt/o6I1mAL7eusbik
 H9GKp/AsWQ2bw6XO9DuandkdTf1znPgnkvsShd3PSeckcXX9FYrO4f1kZJEsxhCFii7uyU0C6EB
 Zndbe
X-Gm-Gg: ASbGnctwzgcw0h2RaG/FWa/EkbaQWO3MiAmOkzSu4NSZh6ZW4XzA0ZwQR2CUjQBoG7Z
 PiRh89XJz7IbqhW50xyE8CbXN3z0V4d+DU4pvWy77Tg7iBYUfYiIeRs8CZSeUxPCWhYhsW0al3y
 10el76+J1dV9EFjyY0wHAZ5XFmaa4dx1RaAVf+V4825UZw8qzeRh66524wo/2cyTpez9zcbKZOg
 lyPZ7fjJLsjdY7VfGQWQn8UIqdB4tZLUCYA+JOqI4si8ej5+edm+bC5iRlEeDZarC7IerugwQ6X
 4Krl+2H87up8FQdMleQAlAnSjKSeJJ1iEjBeZv9VmTsCd0JWOvP/9tjp35kQEmp3+D5gWd9PMiZ
 g1HHnOr7HxEuGZgeX8FnBcT4tW/4Kl74sEBDah+IlA66C46hdeWwI94xE
X-Google-Smtp-Source: AGHT+IFpqWT1vfLJovisGQpKLFOIn7qFlLRUeGtt/NJdFm/6KtvMuYiXVsnwNgDpH7ypv53tJkCh6Q==
X-Received: by 2002:a17:903:288:b0:275:1833:96e5 with SMTP id
 d9443c01a7336-28e7f2b6018mr73891845ad.24.1759370712623; 
 Wed, 01 Oct 2025 19:05:12 -0700 (PDT)
Received: from gromero0.. ([186.215.59.111]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-28e8d1d95bdsm9476735ad.119.2025.10.01.19.05.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Oct 2025 19:05:12 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, alex.bennee@linaro.org, thuth@redhat.com,
 berrange@redhat.com
Cc: qemu-arm@nongnu.org,
	gustavo.romero@linaro.org
Subject: [PATCH v5 8/9] tests/functional: Adapt reverse_debugging to run w/o
 Avocado
Date: Thu,  2 Oct 2025 02:04:31 +0000
Message-Id: <20251002020432.54443-9-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251002020432.54443-1-gustavo.romero@linaro.org>
References: <20251002020432.54443-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x62b.google.com
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

This commit removes Avocado as a dependency for running the
reverse_debugging test.

The main benefit, beyond eliminating an extra dependency, is that there
is no longer any need to handle GDB packets manually. This removes the
need for ad-hoc functions dealing with endianness and arch-specific
register numbers, making the test easier to read. The timeout variable
is also removed, since Meson now manages timeouts automatically.

reverse_debugging now uses the pygdbmi module to interact with GDB, if
it's available in the test environment, otherwise the test is skipped.
GDB is detect via the QEMU_TEST_GDB env. variable.

This commit also significantly improves the output for the test and
now prints all the GDB commands used in sequence. It also adds
some clarifications to existing comments, for example, clarifying that
once the replay-break is reached, a SIGINT is captured in GDB.

reverse_debugging is kept "skipped" for aarch64, ppc64, and x86_64, so
won't run unless QEMU_TEST_FLAKY_TESTS=1 is set in the test environment,
before running 'make check-functional' or 'meson test [...]'.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 tests/functional/reverse_debugging.py | 138 ++++++++++++++------------
 1 file changed, 74 insertions(+), 64 deletions(-)

diff --git a/tests/functional/reverse_debugging.py b/tests/functional/reverse_debugging.py
index 7fd8c7607f..f06996089a 100644
--- a/tests/functional/reverse_debugging.py
+++ b/tests/functional/reverse_debugging.py
@@ -1,19 +1,22 @@
-# Reverse debugging test
-#
 # SPDX-License-Identifier: GPL-2.0-or-later
 #
+# Reverse debugging test
+#
 # Copyright (c) 2020 ISP RAS
+# Copyright (c) 2025 Linaro Limited
 #
 # Author:
 #  Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
+#  Gustavo Romero <gustavo.romero@linaro.org> (Run without Avocado)
 #
 # This work is licensed under the terms of the GNU GPL, version 2 or
 # later.  See the COPYING file in the top-level directory.
-import os
+
 import logging
+import os
 from subprocess import check_output
 
-from qemu_test import LinuxKernelTest, get_qemu_img
+from qemu_test import LinuxKernelTest, get_qemu_img, GDB, skipIfMissingEnv, skipIfMissingImports
 from qemu_test.ports import Ports
 
 
@@ -29,9 +32,7 @@ class ReverseDebugging(LinuxKernelTest):
     that the execution is stopped at the last of them.
     """
 
-    timeout = 10
     STEPS = 10
-    endian_is_le = True
 
     def run_vm(self, record, shift, args, replay_path, image_path, port):
         logger = logging.getLogger('replay')
@@ -54,47 +55,16 @@ def run_vm(self, record, shift, args, replay_path, image_path, port):
         return vm
 
     @staticmethod
-    def get_reg_le(g, reg):
-        res = g.cmd(b'p%x' % reg)
-        num = 0
-        for i in range(len(res))[-2::-2]:
-            num = 0x100 * num + int(res[i:i + 2], 16)
-        return num
-
-    @staticmethod
-    def get_reg_be(g, reg):
-        res = g.cmd(b'p%x' % reg)
-        return int(res, 16)
-
-    def get_reg(self, g, reg):
-        # value may be encoded in BE or LE order
-        if self.endian_is_le:
-            return self.get_reg_le(g, reg)
-        else:
-            return self.get_reg_be(g, reg)
-
-    def get_pc(self, g):
-        return self.get_reg(g, self.REG_PC)
-
-    def check_pc(self, g, addr):
-        pc = self.get_pc(g)
-        if pc != addr:
-            self.fail('Invalid PC (read %x instead of %x)' % (pc, addr))
-
-    @staticmethod
-    def gdb_step(g):
-        g.cmd(b's', b'T05thread:01;')
-
-    @staticmethod
-    def gdb_bstep(g):
-        g.cmd(b'bs', b'T05thread:01;')
+    def get_pc(gdb: GDB):
+        return gdb.cli("print $pc").get_addr()
 
     @staticmethod
     def vm_get_icount(vm):
         return vm.qmp('query-replay')['return']['icount']
 
-    def reverse_debugging(self, shift=7, args=None):
-        from avocado.utils import gdb
+    @skipIfMissingImports("pygdbmi") # Required by GDB class
+    def reverse_debugging(self, gdb_arch, shift=7, args=None):
+        from qemu_test import GDB
 
         logger = logging.getLogger('replay')
 
@@ -124,68 +94,108 @@ def reverse_debugging(self, shift=7, args=None):
         with Ports() as ports:
             port = ports.find_free_port()
             vm = self.run_vm(False, shift, args, replay_path, image_path, port)
-        logger.info('connecting to gdbstub')
-        g = gdb.GDBRemote('127.0.0.1', port, False, False)
-        g.connect()
-        r = g.cmd(b'qSupported')
-        if b'qXfer:features:read+' in r:
-            g.cmd(b'qXfer:features:read:target.xml:0,ffb')
-        if b'ReverseStep+' not in r:
+
+        try:
+            logger.info('Connecting to gdbstub...')
+            self.reverse_debugging_run(vm, port, gdb_arch, last_icount)
+            logger.info('Test passed.')
+        except GDB.TimeoutError:
+            # Convert a GDB timeout exception into a unittest failure exception.
+            raise self.failureException("Timeout while connecting to or "
+                                        "communicating with gdbstub...") from None
+        except Exception:
+            # Re-throw exceptions from unittest, like the ones caused by fail(),
+            # skipTest(), etc.
+            raise
+
+    @skipIfMissingEnv("QEMU_TEST_GDB")
+    def reverse_debugging_run(self, vm, port, gdb_arch, last_icount):
+        logger = logging.getLogger('replay')
+
+        gdb_cmd = os.getenv('QEMU_TEST_GDB')
+        gdb = GDB(gdb_cmd)
+
+        r = gdb.cli("set architecture").get_log()
+        if gdb_arch not in r:
+            self.skipTest(f"GDB does not support arch '{gdb_arch}'")
+
+        gdb.cli("set debug remote 1")
+
+        c = gdb.cli(f"target remote localhost:{port}").get_console()
+        if not f"Remote debugging using localhost:{port}" in c:
+            self.fail("Could not connect to gdbstub!")
+
+        # Remote debug messages are in 'log' payloads.
+        r = gdb.get_log()
+        if 'ReverseStep+' not in r:
             self.fail('Reverse step is not supported by QEMU')
-        if b'ReverseContinue+' not in r:
+        if 'ReverseContinue+' not in r:
             self.fail('Reverse continue is not supported by QEMU')
 
+        gdb.cli("set debug remote 0")
+
         logger.info('stepping forward')
         steps = []
         # record first instruction addresses
         for _ in range(self.STEPS):
-            pc = self.get_pc(g)
+            pc = self.get_pc(gdb)
             logger.info('saving position %x' % pc)
             steps.append(pc)
-            self.gdb_step(g)
+            gdb.cli("stepi")
 
         # visit the recorded instruction in reverse order
         logger.info('stepping backward')
         for addr in steps[::-1]:
-            self.gdb_bstep(g)
-            self.check_pc(g, addr)
             logger.info('found position %x' % addr)
+            gdb.cli("reverse-stepi")
+            pc = self.get_pc(gdb)
+            if pc != addr:
+                logger.info('Invalid PC (read %x instead of %x)' % (pc, addr))
+                self.fail('Reverse stepping failed!')
 
         # visit the recorded instruction in forward order
         logger.info('stepping forward')
         for addr in steps:
-            self.check_pc(g, addr)
-            self.gdb_step(g)
             logger.info('found position %x' % addr)
+            pc = self.get_pc(gdb)
+            if pc != addr:
+                logger.info('Invalid PC (read %x instead of %x)' % (pc, addr))
+                self.fail('Forward stepping failed!')
+            gdb.cli("stepi")
 
         # set breakpoints for the instructions just stepped over
         logger.info('setting breakpoints')
         for addr in steps:
-            # hardware breakpoint at addr with len=1
-            g.cmd(b'Z1,%x,1' % addr, b'OK')
+            gdb.cli(f"break *{hex(addr)}")
 
         # this may hit a breakpoint if first instructions are executed
         # again
         logger.info('continuing execution')
         vm.qmp('replay-break', icount=last_icount - 1)
         # continue - will return after pausing
-        # This could stop at the end and get a T02 return, or by
-        # re-executing one of the breakpoints and get a T05 return.
-        g.cmd(b'c')
+        # This can stop at the end of the replay-break and gdb gets a SIGINT,
+        # or by re-executing one of the breakpoints and gdb stops at a
+        # breakpoint.
+        gdb.cli("continue")
+
         if self.vm_get_icount(vm) == last_icount - 1:
             logger.info('reached the end (icount %s)' % (last_icount - 1))
         else:
             logger.info('hit a breakpoint again at %x (icount %s)' %
-                        (self.get_pc(g), self.vm_get_icount(vm)))
+                        (self.get_pc(gdb), self.vm_get_icount(vm)))
 
         logger.info('running reverse continue to reach %x' % steps[-1])
         # reverse continue - will return after stopping at the breakpoint
-        g.cmd(b'bc', b'T05thread:01;')
+        gdb.cli("reverse-continue")
 
         # assume that none of the first instructions is executed again
         # breaking the order of the breakpoints
-        self.check_pc(g, steps[-1])
+        pc = self.get_pc(gdb)
+        if pc != steps[-1]:
+            self.fail("'reverse-continue' did not hit the first PC in reverse order!")
+
         logger.info('successfully reached %x' % steps[-1])
 
         logger.info('exiting gdb and qemu')
+        gdb.exit()
         vm.shutdown()
-- 
2.34.1


