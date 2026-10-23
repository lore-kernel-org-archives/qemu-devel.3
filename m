Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D67F606A31B
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 18:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=aNgrrwDm
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKJeQ-0006jC-Fj; Fri, 23 Oct 2026 14:05:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xKJeK-0006en-5k
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 14:05:52 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xKJeH-0004Xt-ET
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 14:05:51 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-48e09aa5264so701449f8f.2
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 11:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792778748; x=1793383548; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ep/MdTcpefjL1P0npbhGNCmUr1FN7KJjDGzev6ywPo4=;
 b=aNgrrwDmicPGGQzzmy4reUHxNVTqQQF+4IaDikezn7ybhGzoipVr9O9j1JUFwXhNNW
 J1x47LwL38kXSnENSFvY4oOyhtescyxmwy6eXXBXd9vBscFoCtJXosL7ciVeYrAJ4Y/F
 JTbRygpKQZvCdLO8y/xDHAuzFXhDQwyR7XioexnaXw1bz/7WjYwPAIvditaPhT5NREZz
 23c/aGOw4AZvyR2ed7nfetiff/FFtyHe0oZAM51zSmxZCEEVT/SGgfj53fLlNvsL4XdI
 AdppcYM6psuUXiL+1m8u/8RxY2WlCOVqIDvyY0Is+IMdiT2BXxLUI01Xyg1Ucg0UHdwz
 bk5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792778748; x=1793383548;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ep/MdTcpefjL1P0npbhGNCmUr1FN7KJjDGzev6ywPo4=;
 b=0SawSnXx2s655wxGKRfhGwKepn1kd/udLS6rrWHXfcZCVMbndnEO2DOPAv88SBzvwv
 hy6oRQLUNY6bzKXMLa4msbKtkvKwh/4fw5vsXQDWd7B+0nit4geQJk+Kj52+nRzCtH/T
 mw3NoYB3bnRQcBbIbjtQiPzUvesi5aczl7kqE7Cst5q5c0zlRIPPUAyWvZ7XrlIrAxrA
 CWTSAIRX0wVlD4ldJTdMtSHlofntE2BBwZgNYHaRU3MUUZIomTCXZcDt99BU30k/T8Jw
 rF6zG8PokmShji4kyyFOp0KnFWiMeWTHICJKbzbMSa1lmLetgQIX+UGE6w7vbx6qbjqN
 Bm9g==
X-Gm-Message-State: AFq9FYK6KLbjtqEMVXdYzTLykCLTDDIxFFyGCLq3g4+4HTazGrR/FFmF
 Pq9f5/9JfIfyEyxIT5ywxASb1Xfy98p4TRNvrkW8Rr0262+Cwwkuz98P1O3EPWn4C2Y=
X-Gm-Gg: AYBFou0eE1tKdI4zKbVDnfVEyKT8W18sS0yZEbNEUmg55sZSP2YDRJe6MO/ir4RZUMK
 IakOaDQbVb6aPTjAfd+6zbt7571SJ0MMnAV0oRYyy4Qrgo0vNb3L1Fib/5Swhxkk/tVLymghyvl
 ipIbr3cy9Ax6BxusLEkjEestfeIUNN6zkctl1W+6MtRWKo9LnsYyed3kXgN0lHQa/SgqcUmFH/N
 ymlkjpHxiYR7mTv+i5+z8BMlKQ7fwzVASkN9Xfp+pC+l4VRtfQN3TvRGJDLcmwZI7jkF0VlAcEH
 gYTjkZ/oIdQfyVCIdmz/dC4OiEvrNQ2l7hH39sh1NkZ5WkPCDLTPafjiPt9vdL1b5XVr34hg3SO
 4PSPQEYfiU8/u+9TiDkKldVpOVuqYRblpzemR5750z3OM9hUTPyRBWKaA4L9Re7L20O2WHCk5qP
 8oqjeJtkSBMSghMBq7oI8zdVTKCNERVoqn/Y+SE8f8Wadp6D79vPy3Z3AWmcaAwY5TIUPvlRvFp
 bUj24EDsqgHVe3sd790LZPuC4Ss/K05c4v2kZ70+DZe2phgP5D6tns=
X-Received: by 2002:a5d:6f0e:0:b0:48a:f59f:8b70 with SMTP id
 ffacd0b85a97d-48e385bce08mr4980879f8f.46.1792778747756; 
 Fri, 23 Oct 2026 11:05:47 -0700 (PDT)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3d3eefacsm1418382f8f.9.2026.10.23.11.05.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 11:05:44 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B4629610A0;
 Fri, 23 Oct 2026 19:05:40 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Thomas Huth <th.huth+qemu@posteo.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>
Subject: [PULL 12/19] tests/functional: teach tuxrun about launching gdb tests
Date: Fri, 23 Oct 2026 19:05:30 +0100
Message-ID: <20261023180539.1574134-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261023180539.1574134-1-alex.bennee@linaro.org>
References: <20261023180539.1574134-1-alex.bennee@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x429.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This resurrects the hand run test script from d84842be6c5 (tests:
remove test-gdbstub.py) and modernises it to use the shared test
infrastructure for run-test.

We then tweak the common tuxrun code to offer an alternative "launch
via gdbstub" helper which reuses the existing code but:

  - needs a vmlinux with symbols
  - drops kaslr because it doesn't play nice with symbols
  - extend qargs with stuff normally added by vm.launch
  - passes kargs directly
  - runs with the gdb run-test script
  - log the run-test output to the console log
  - makes --binary not mandatory

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-ID: <20261019192704.3220373-13-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/functional/gdb-scripts/kernel_gdb_test.py b/tests/functional/gdb-scripts/kernel_gdb_test.py
new file mode 100644
index 00000000000..f457ccdcbf4
--- /dev/null
+++ b/tests/functional/gdb-scripts/kernel_gdb_test.py
@@ -0,0 +1,162 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Generic Kernel GDB script to verify functionality:
+#  - Single-stepping
+#  - Hardware breakpoints
+#  - Software breakpoints
+#  - Watchpoints
+#
+# It relies on fairly common kernel points to break at and symbols for
+# the kernel. Address space randomisation (kaslr) needs to be disabled.
+#
+# Copyright (c) 2026 Linaro Limited
+#
+# Author:
+#  Alex Bennée <alex.bennee@linaro.org>
+#
+# This is launched by the tuxrun functional tests via tests/guest-debug/run-test.py
+
+import gdb
+from test_gdbstub import main, report
+
+def parse_registers():
+    """Parse 'info registers' into a name -> value dictionary."""
+    regs = {}
+    for line in gdb.execute("info registers", to_string=True).splitlines():
+        parts = line.split()
+        if len(parts) >= 2:
+            regs[parts[0]] = parts[1]
+    return regs
+
+
+def check_step():
+    "Step an instruction, check it moved."
+    start_pc = gdb.parse_and_eval('$pc')
+    gdb.execute("si")
+    end_pc = gdb.parse_and_eval('$pc')
+
+    return not (start_pc == end_pc)
+
+
+def check_reg_updates(regs_start):
+    regs_end = parse_registers()
+
+    changed = [k for k in regs_start
+               if k in regs_end and regs_start[k] != regs_end[k]]
+
+    report(len(changed) > 0, f"{len(changed)} registers changed.")
+
+
+def check_break(sym_name):
+    "Setup breakpoint, continue and check we stopped."
+    bp = gdb.Breakpoint(sym_name)
+    gdb.execute("c")
+    res = bp.hit_count == 1
+    bp.delete()
+
+    return res
+
+
+def check_hbreak(sym_name):
+    "Setup hardware breakpoint, continue and check we stopped."
+    bp = gdb.Breakpoint(sym_name, type = gdb.BP_HARDWARE_BREAKPOINT)
+    gdb.execute("c")
+    res = bp.hit_count == 1
+    bp.delete()
+
+    return res
+
+
+class WatchPoint(gdb.Breakpoint):
+
+    def __init__(self, sym_name, type):
+        super(WatchPoint, self).__init__(sym_name, gdb.BP_WATCHPOINT, type)
+
+    def stop(self):
+        end_pc = gdb.parse_and_eval('$pc')
+        print("HIT WP @ %s" % (end_pc))
+        return True
+
+
+def do_one_watch(sym, wtype, text):
+
+    wp = WatchPoint(sym, wtype)
+    gdb.execute("c")
+    report_str = "%s for %s" % (text, sym)
+
+    if wp.hit_count > 0:
+        report(True, report_str)
+    else:
+        report(False, report_str)
+
+    wp.delete()
+
+
+def check_watches(sym_name):
+    "Watch a symbol for any access."
+
+    # Should hit for any read
+    do_one_watch(sym_name, gdb.WP_ACCESS, "awatch")
+
+    # Again should hit for reads
+    do_one_watch(sym_name, gdb.WP_READ, "rwatch")
+
+    # Finally when it is written
+    do_one_watch(sym_name, gdb.WP_WRITE, "watch")
+
+
+class CatchBreakpoint(gdb.Breakpoint):
+    def __init__(self, sym_name):
+        super(CatchBreakpoint, self).__init__(sym_name, type = gdb.BP_BREAKPOINT)
+        self.sym, ok = gdb.lookup_symbol(sym_name)
+
+    def stop(self):
+        end_pc = gdb.parse_and_eval('$pc')
+        print("CB: %s == %s" % (end_pc, self.sym.value()))
+        if end_pc == self.sym.value():
+            report(False, "Hit final catchpoint")
+
+
+def run_test():
+    "Run through the tests one by one"
+
+    # get the initial register state
+    regs_start = parse_registers()
+
+    print("Checking we can step the first few instructions")
+    step_ok = 0
+    for i in range(3):
+        if check_step():
+            step_ok += 1
+
+    report(step_ok == 3, "single step in boot code")
+
+    # check some registers changed
+    print("Checking register access works")
+    check_reg_updates(regs_start)
+
+    print("Checking HW breakpoint works")
+    break_ok = check_hbreak("kernel_init")
+    report(break_ok, "hbreak @ kernel_init")
+
+    # Can't set this up until we are in the kernel proper
+    # if we make it to run_init_process we've over-run and
+    # one of the tests failed
+
+    print("Setup catch-all for run_init_process")
+    cbp = CatchBreakpoint("run_init_process")
+
+    # We should see wait_for_completion called right at the start of
+    # kernel_init
+    print("Checking Normal breakpoint works")
+    break_ok = check_break("wait_for_completion")
+    report(break_ok, "break @ wait_for_completion")
+
+    print("Checking watchpoint works")
+    check_watches("system_state")
+
+    # check we didn't hit the end
+    report(cbp.hit_count == 0, "CatchBreakpoint not hit")
+
+
+main(run_test)
diff --git a/tests/functional/qemu_test/tuxruntest.py b/tests/functional/qemu_test/tuxruntest.py
index ca1589fea37..44b14ab6d48 100644
--- a/tests/functional/qemu_test/tuxruntest.py
+++ b/tests/functional/qemu_test/tuxruntest.py
@@ -9,7 +9,10 @@
 #
 # SPDX-License-Identifier: GPL-2.0-or-later
 
+import logging
 import os
+import shlex
+import subprocess
 
 from qemu_test import QemuSystemTest
 from qemu_test import exec_command_and_wait_for_pattern
@@ -18,7 +21,8 @@
 
 class TuxRunBaselineTest(QemuSystemTest):
 
-    KERNEL_COMMON_COMMAND_LINE = 'printk.time=0'
+    # nokaslr is needed for gdb tests but it makes things simpler anyway
+    KERNEL_COMMON_COMMAND_LINE = 'printk.time=0 nokaslr'
     # Tests are ~10-40s, allow for --debug/--enable-gcov overhead
     timeout = 100
 
@@ -55,17 +59,20 @@ def wait_for_console_pattern(self, success_message, vm=None):
                                  failure_message='Kernel panic - not syncing',
                                  vm=vm)
 
-    def fetch_tuxrun_assets(self, kernel_asset, rootfs_asset, dtb_asset=None):
+    def fetch_tuxrun_assets(self, kernel_asset, rootfs_asset,
+                            dtb_asset=None, vmlinux_asset=None):
         """
         Fetch the TuxBoot assets.
         """
         kernel_image =  kernel_asset.fetch()
         disk_image = self.uncompress(rootfs_asset)
         dtb = dtb_asset.fetch() if dtb_asset is not None else None
+        vmlinux = self.uncompress(vmlinux_asset) if vmlinux_asset is not None else None
 
-        return (kernel_image, disk_image, dtb)
+        return (kernel_image, disk_image, dtb, vmlinux)
 
-    def prepare_run(self, accel, kernel, disk, drive, dtb=None, console_index=0):
+    def prepare_run(self, accel, kernel, disk, drive,
+                    dtb=None, console_index=0, append = True):
         """
         Setup to run and add the common parameters to the system
         """
@@ -83,9 +90,15 @@ def prepare_run(self, accel, kernel, disk, drive, dtb=None, console_index=0):
         if accel:
             self.vm.add_args('-accel', accel)
 
-        self.vm.add_args('-kernel', kernel,
-                         '-append', self.kcmd_line,
-                         '-blockdev', blockdev)
+        if kernel:
+            self.vm.add_args('-kernel', kernel)
+
+        # When using the gdb run script we might not want to include
+        # the kcmd line directly in the QEMU args.
+        if append:
+            self.vm.add_args('-append', self.kcmd_line)
+
+        self.vm.add_args('-blockdev', blockdev)
 
         # Sometimes we need extra devices attached
         if self.extradev:
@@ -132,10 +145,76 @@ def common_tuxrun(self,
         special with the command line we can process most things using
         the tag metadata.
         """
-        (kernel, disk, dtb) = self.fetch_tuxrun_assets(kernel_asset, rootfs_asset,
-                                                       dtb_asset)
+        (kernel, disk, dtb, _) = self.fetch_tuxrun_assets(kernel_asset,
+                                                          rootfs_asset,
+                                                          dtb_asset)
 
         self.prepare_run(accel, kernel, disk, drive, dtb, console_index)
         self.vm.launch()
         self.run_tuxtest_tests(haltmsg)
         os.remove(disk)
+
+    def common_tuxrun_gdb(self,
+                          kernel_asset,
+                          vmlinux_asset,
+                          rootfs_asset,
+                          accel=None,
+                          dtb_asset=None,
+                          drive="virtio-blk-device",
+                          console_index=0):
+        """
+        Common path for LKFT tests under gdb. Unlike the common_tuxrun
+        function we need to launch with the gdb test script and deal
+        with munging the arguments for that especially.
+        """
+        (kernel, disk, dtb, vmlinux) = self.fetch_tuxrun_assets(kernel_asset,
+                                                                rootfs_asset,
+                                                                dtb_asset,
+                                                                vmlinux_asset)
+
+        gdb_path = os.getenv("QEMU_TEST_GDB")
+        run_script = self.data_file('..', 'guest-debug','run-test.py')
+        test_script = self.data_file('gdb-scripts', 'kernel_gdb_test.py')
+
+        # Instead of launching QEMU via the functional test machinery
+        # we need to launch it with the gdb run script. We utilise the
+        # existing prepare_run machinery to build the command line but
+        # we pass the kernel args separately to avoid horrible string
+        # escaping.
+
+        self.prepare_run(accel, kernel, disk, drive, dtb,
+                         console_index, append = False)
+
+        # the functional test machinery adds more stuff for handling
+        # console redirection which we need to do manually.
+
+        qargs = self.vm.args
+        qargs.extend(["-display", "none", "-serial", "stdio"])
+
+        # and the machine type
+        if self.vm._machine is not None:
+            qargs.extend(["-machine", self.vm._machine])
+
+        cmd = [
+            str(run_script),
+            "--qemu", self.qemu_bin,
+            "--qargs", shlex.join(qargs),
+            "--kargs", self.kcmd_line,
+            "--symbols", str(vmlinux),
+            "--test", str(test_script),
+            "--gdb", gdb_path,
+        ]
+
+        log_cmd = " ".join(f'"{arg}"' if ' ' in arg else arg for arg in cmd)
+        self.log.info(f"run-test: {log_cmd}")
+
+        res = subprocess.run(cmd, text=True,
+                             stdout=subprocess.PIPE,
+                             stderr=subprocess.STDOUT)
+
+        if res.stdout:
+            console_logger = logging.getLogger('console')
+            console_logger.info(res.stdout)
+
+        self.assertEqual(res.returncode, 0,
+                         f"run-test.py failed ({res.returncode}):\n")
diff --git a/tests/functional/sh4/test_tuxrun.py b/tests/functional/sh4/test_tuxrun.py
index 42b503585b2..07c7ee6e03b 100755
--- a/tests/functional/sh4/test_tuxrun.py
+++ b/tests/functional/sh4/test_tuxrun.py
@@ -31,8 +31,8 @@ def test_sh4(self):
 
         # The test is currently too unstable to do much in userspace
         # so we skip common_tuxrun and do a minimal boot and shutdown.
-        (kernel, disk, dtb) = self.fetch_tuxrun_assets(self.ASSET_SH4_KERNEL,
-                                                       self.ASSET_SH4_ROOTFS)
+        (kernel, disk, dtb, _) = self.fetch_tuxrun_assets(self.ASSET_SH4_KERNEL,
+                                                          self.ASSET_SH4_ROOTFS)
 
         # the console comes on the second serial port
         self.prepare_run(None, kernel, disk,
diff --git a/tests/guest-debug/run-test.py b/tests/guest-debug/run-test.py
index afde0e2c008..6f858f2d0b7 100755
--- a/tests/guest-debug/run-test.py
+++ b/tests/guest-debug/run-test.py
@@ -26,8 +26,7 @@ def get_args():
     parser.add_argument("--qargs", help="Qemu arguments for test")
     parser.add_argument("--pargs", help="Program arguments for test")
     parser.add_argument("--kargs", help="Kernel args to --append")
-    parser.add_argument("--binary", help="Binary to debug",
-                        required=True)
+    parser.add_argument("--binary", help="Binary to debug")
     parser.add_argument("--symbols", help="Symbol file for binary to debug")
     parser.add_argument("--test", help="GDB test script")
     parser.add_argument('test_args', nargs='*',
@@ -86,8 +85,10 @@ def format_cmd(cmd):
         qemu_cmd.extend(shlex.split(args.qargs))
 
     if "system" in args.qemu:
-        # for system mode we assume qargs has set-up for binary
-        qemu_cmd.append(args.binary)
+        # for system mode we assume qargs has set-up for binary if
+        # indeed we have set one.
+        if args.binary:
+            qemu_cmd.append(args.binary)
         if not args.no_suspend:
             qemu_cmd.append("-S")
         qemu_cmd.extend(["-gdb", f"unix:path={socket_name},server=on"])
@@ -116,7 +117,10 @@ def format_cmd(cmd):
     inferior = subprocess.Popen(qemu_cmd)
 
     # Now launch gdb with our test and collect the result
-    gdb_cmd = [args.gdb, args.binary]
+    gdb_cmd = [args.gdb]
+
+    if args.binary:
+        gdb_cmd.append(args.binary)
     if args.gdb_args:
         gdb_cmd.extend(shlex.split(args.gdb_args))
 
-- 
2.47.3


