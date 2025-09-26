Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EECBCCAC5BA
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 05:18:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v20p9-0004sx-VT; Fri, 26 Sep 2025 01:16:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1v20p4-0004pb-5G
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 01:16:46 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1v20ov-00061p-3x
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 01:16:45 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-b555b0fb839so1298381a12.3
 for <qemu-devel@nongnu.org>; Thu, 25 Sep 2025 22:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758863788; x=1759468588; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YK36azP6oOgCQtElb4HgeO0m9NeDE6FMPmb4sfTtQPg=;
 b=mMx6BhwK82iQYoLM10RuvAfgG6/HPnlNFbQCDFL+EhxuaMICIL+8JPU9HeY7Onhr96
 2uOIV9F5bmRPL7Syo88tR7dYfoaCW5G6HCWpP95Hdlh8RQImZW5aU/f2c72lpnB5FbDV
 wsppa6O1urII/x1JzBhrJw8qmBVdzvDM5qHvvuX4UpdUNMos6aTeym/57Uj8IyDXkad3
 3+waMFZcPLzfoSiBgeZbUDY/JI1cmGqKYiKz2ZufXexpiJd2yJlM4IwwPOhTSIN/9rJc
 YoBzmEAmYULB7Wao6k0EMGPmm1vPVTKEC8OXicntVzOEI6ShR+kWdRLJai6Z3w/G7crb
 /qYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758863788; x=1759468588;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YK36azP6oOgCQtElb4HgeO0m9NeDE6FMPmb4sfTtQPg=;
 b=sfE4TKjOPdbUEyi7EkZfkjuyTOVgK/UxfK7ySNIb/3VtSCNc6Ia1ynqPFnjacrP0+o
 h0jCioOQKbNBqP7vR5WFnhsNRXqt5lEQZSUkAz2OQzcXfwkZTKuFk9XTa7mLKpVDguoW
 5LgYh2TdL94zkI5cHcbCz13pdu9OdKYyPdz4yKn4JaRW6+/g0qTtcEWY2uLYN30ZeQaO
 wEtujvI9lkRt7FKlGoEw8+RsgIDlxVvOn1CeTA+7dkh0x750Ra0BsfDEjbxvraty/uKL
 ddalvX3gU4ZpF8TW18+XAhgLvkg99JuyQvkaTxA71pkUE9hqbTwWzWtjjkFVIRwl4QiG
 Z2ww==
X-Gm-Message-State: AOJu0YxiYOfNq+YD8mlzos50n7DxP3wqyOFHowtXymC0Ike1Xm88UohT
 wT/F4LdT4aQtsY+9h+fDPB/tjnGHjA27uTIxjzxCqx/S5yVFcrDg4svWZnGHBYwfvKZ7N0M3s1L
 Yfb8/
X-Gm-Gg: ASbGncsWRnbEX6Dq9y7ySCLAuIBqPIw0Fy4Xu0XxPogf+A3bDBjomOhyTL+YEneY4G0
 E1xKS7A9plJTmMFmbzl7MRfbazXLZgEy9LChL5PpefRLwyDEaWzsnM2jwP/CQbxuFZC6Va9u3do
 arU6QYmS3ZxYPvKCU2/HLohS9Uia0FB15vlZuwct0uZvfAoyaMmk9pk+LCpdE5cm6NcRB+IuD70
 8fjyVgw2UwP3s19ca4brABmL0xxIr57udqWpg+IrwEQWUdflRRDMiB0HgJgSQfXam8u3RjX6sDV
 h/OnpyATB5gq+HfGgB2qHtCQTApPvzhqM/WXXE/prabs52Re+agxMEKLcvDIIwFG06pX2YO70cT
 FFvOU0wwYCUglxHb3MIKCg2EZWGIwwmXTYvMKJL5g7puM/XPSRMlD/kr1o8pdQcbuiW7n
X-Google-Smtp-Source: AGHT+IH+Q9C1XpS4cbBUrNuuddIisnUeD8gMNtxRGplXbkIoZXsBEjwQDoZv+BMrrmtBKAJrXYVjRg==
X-Received: by 2002:a17:903:3c26:b0:264:ede2:683d with SMTP id
 d9443c01a7336-27ed4adb732mr60136045ad.56.1758863788431; 
 Thu, 25 Sep 2025 22:16:28 -0700 (PDT)
Received: from gromero0.. (189-47-45-49.dsl.telesp.net.br. [189.47.45.49])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-27ed672a51fsm42160085ad.63.2025.09.25.22.16.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Sep 2025 22:16:28 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, alex.bennee@linaro.org, thuth@redhat.com,
 berrange@redhat.com
Cc: qemu-arm@nongnu.org, gustavo.romero@linaro.org,
 manos.pitsidianakis@linaro.org, peter.maydell@linaro.org
Subject: [PATCH v4 8/9] tests/functional: Adapt reverse_debugging to run w/o
 Avocado
Date: Fri, 26 Sep 2025 05:15:41 +0000
Message-Id: <20250926051542.104432-9-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250926051542.104432-1-gustavo.romero@linaro.org>
References: <20250926051542.104432-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pg1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 tests/functional/reverse_debugging.py | 127 +++++++++++++-------------
 1 file changed, 61 insertions(+), 66 deletions(-)

diff --git a/tests/functional/reverse_debugging.py b/tests/functional/reverse_debugging.py
index 7fd8c7607f..4e4200dd48 100644
--- a/tests/functional/reverse_debugging.py
+++ b/tests/functional/reverse_debugging.py
@@ -1,19 +1,23 @@
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
+from pygdbmi.constants import GdbTimeoutError
 from subprocess import check_output
 
-from qemu_test import LinuxKernelTest, get_qemu_img
+from qemu_test import LinuxKernelTest, get_qemu_img, GDB, skipIfMissingEnv
 from qemu_test.ports import Ports
 
 
@@ -29,9 +33,7 @@ class ReverseDebugging(LinuxKernelTest):
     that the execution is stopped at the last of them.
     """
 
-    timeout = 10
     STEPS = 10
-    endian_is_le = True
 
     def run_vm(self, record, shift, args, replay_path, image_path, port):
         logger = logging.getLogger('replay')
@@ -53,49 +55,11 @@ def run_vm(self, record, shift, args, replay_path, image_path, port):
         vm.launch()
         return vm
 
-    @staticmethod
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
-
     @staticmethod
     def vm_get_icount(vm):
         return vm.qmp('query-replay')['return']['icount']
 
     def reverse_debugging(self, shift=7, args=None):
-        from avocado.utils import gdb
-
         logger = logging.getLogger('replay')
 
         # create qcow2 for snapshots
@@ -124,68 +88,99 @@ def reverse_debugging(self, shift=7, args=None):
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
+            self.reverse_debugging_run(vm, port, last_icount)
+            logger.info('Test passed.')
+        except GdbTimeoutError:
+            self.fail("Connection to gdbstub timeouted...")
+
+    @skipIfMissingEnv("QEMU_TEST_GDB")
+    def reverse_debugging_run(self, vm, port, last_icount):
+        logger = logging.getLogger('replay')
+
+        gdb_cmd = os.getenv('QEMU_TEST_GDB')
+        gdb = GDB(gdb_cmd)
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
+            pc = gdb.cli("print $pc").get_addr()
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
+            pc = gdb.cli("print $pc").get_addr()
+            if pc != addr:
+                logger.info('Invalid PC (read %x instead of %x)' % (pc, addr))
+                self.fail('Reverse stepping failed!')
 
         # visit the recorded instruction in forward order
         logger.info('stepping forward')
         for addr in steps:
-            self.check_pc(g, addr)
-            self.gdb_step(g)
             logger.info('found position %x' % addr)
+            pc = gdb.cli("print $pc").get_addr()
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
+        pc = gdb.cli("print $pc").get_addr()
         if self.vm_get_icount(vm) == last_icount - 1:
             logger.info('reached the end (icount %s)' % (last_icount - 1))
         else:
             logger.info('hit a breakpoint again at %x (icount %s)' %
-                        (self.get_pc(g), self.vm_get_icount(vm)))
+                        (pc, self.vm_get_icount(vm)))
 
         logger.info('running reverse continue to reach %x' % steps[-1])
         # reverse continue - will return after stopping at the breakpoint
-        g.cmd(b'bc', b'T05thread:01;')
+        gdb.cli("reverse-continue")
 
         # assume that none of the first instructions is executed again
         # breaking the order of the breakpoints
-        self.check_pc(g, steps[-1])
+        pc = gdb.cli("print $pc").get_addr()
+        if pc != steps[-1]:
+            self.fail("'reverse-continue' did not hit the first PC in reverse order!")
+
         logger.info('successfully reached %x' % steps[-1])
 
         logger.info('exiting gdb and qemu')
+        gdb.exit()
         vm.shutdown()
-- 
2.34.1


