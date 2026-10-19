Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8C3606A31B
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 19:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=EMgBb2Wk
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIt1o-0001BV-RE; Mon, 19 Oct 2026 15:28:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xIt17-0000Z5-Nq
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 15:27:29 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xIt14-00039F-Of
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 15:27:29 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4a1ec92f655so165415e9.0
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 12:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792438045; x=1793042845; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=uLzrwa3UCJm3iGwHPs8vk66ruAnFlJlFOLTn6u459o4=;
 b=EMgBb2WkfDPu2bsKVVw97HnQ2r3iE/sR0viGGVmbaFZmG/6FRc/x9eQJ2dN4/pPSlm
 7Qwfx1/wq24mDu8o2ETpPOmg2hNDv0REqYY4lVf1MqB03VR7Ya/gCQl/ZO9P643wzJ9t
 X1L0FEAB9Nu8+byBqssRHxFu6FdHythGp3iQfBwaAh28BVVWAzHqGeQNY9DtE3xtcpTH
 +1mJoqijojVTpMIfjqNmIYUWCBN+SwAnt1f753apCBAhZPp2tpP+NW220sCT1rGFmN3U
 dp3+3czNq9IWwKOu4vxWtwcZTboqbLu1xBaMwsjdj3t4OYp+g7q2YeHfdZxfSs5hNCsh
 /xfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792438045; x=1793042845;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uLzrwa3UCJm3iGwHPs8vk66ruAnFlJlFOLTn6u459o4=;
 b=xRGALnYW5VrP/qZ+AL7cv/ynYUwJN+Hsd/BMosgCTE5hekMQ4ELNNQgS7ebbUmNwzV
 77b2i3o26XJeaHpQxWFjZM8MVX/LOyWUCXEZOS8NMwtxBK1S3XZ687ZzNgEaXMHzAj7H
 az+DtGWM0xMu7PG2yVQP644etTSm47HpY8wNs9Kav+gwjUqC91791Tf+i6qP/Z8uMHty
 5ClVG/CHrMNJp2B4isDs5JnZrKE/C++SiJIdgckjYGPPepzK1GxoEDNBNCgeagSZBJub
 QfvwmoR2A1SaHwAY/fNPNpyk6M+QwtR30v/DS2b7wznRoxQAZKvEdV45h8xH5V/VHsxP
 4ARg==
X-Gm-Message-State: AFq9FYIA1SJi+kGhuw6GLbDK+nXHVf6hBlqyxPZppUHRc0tr7S8GC4TI
 lKKiI32SBAtO844YHNqDIociv3RkpvImcYf8QxOhOcmRJKaBwG9Szq7e69+1VclyluA=
X-Gm-Gg: AYBFou0KR99F4tND2iat6OI+kYk/gmODPhz6h6JD0k0qG0mB3CgPUxhX2fp/gHjmu5q
 ialECC/XXe2tBDBrj0EfSWv+yuP4iZgeBjfzPtCTJjZ8t4Y8LZYEtAXygM+TjEw/R2A3wykhlDq
 pqP85gcWWH9KwOwtxyivnVv/nuZZA0w6JYpOqhG15C2+8DCJoX55ne0LdzHxvwyGqdOBbWBfUYm
 wi7VWy7aMwi20mRBN8zRZuF94+OtivO8pK3NrFj3NcOLfuvC05WNKcoP96CcUQ4Bt9UqGK3jsq+
 g2/eZQ1VrA7DRcW3QxBwMAwzWLPM6v4u8DCU0if9qukoWykPOkdQnV4bwPsZZOLQGX97XeHGN2h
 p5IXzJXvwiZPgLeZFQHMTFor8D0MtQ9SfCpAJQaYEXHg27mrPt27MqX6RxtijbS83hluVtOWxc4
 vDY/iRxaASRFZnrgdpaiwCEBk4MmemBYvgvJa6qe+WObMY0DRu7/5Y5QyVZl/y2erQxEC2eQ==
X-Received: by 2002:a05:600c:3e10:b0:49e:6581:7baf with SMTP id
 5b1f17b1804b1-4a1f4c700c2mr1814575e9.2.1792438045048; 
 Mon, 19 Oct 2026 12:27:25 -0700 (PDT)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1df370381sm134059165e9.1.2026.10.19.12.27.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 12:27:20 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4728D5FD52;
 Mon, 19 Oct 2026 20:27:06 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, Thomas Huth <th.huth+qemu@posteo.eu>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Peter Xu <peterx@redhat.com>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Kyle Evans <kevans@freebsd.org>, Keith Busch <kbusch@kernel.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Zhao Liu <zhao1.liu@intel.com>,
 Ani Sinha <anisinha@redhat.com>, Anders Roxell <anders.roxell@linaro.org>,
 qemu-arm@nongnu.org, Song Gao <gaosong@loongson.cn>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, qemu-s390x@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brad Smith <brad@comstyle.com>, Brian Cain <brian.cain@oss.qualcomm.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Klaus Jensen <its@irrelevant.dk>, John Snow <jsnow@redhat.com>
Subject: [PATCH v3 12/19] tests/functional: teach tuxrun about launching gdb
 tests
Date: Mon, 19 Oct 2026 20:26:57 +0100
Message-ID: <20261019192704.3220373-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261019192704.3220373-1-alex.bennee@linaro.org>
References: <20261019192704.3220373-1-alex.bennee@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
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

We then tweak the common tuxrun code to over an alternative "launch
via gdbstub" helper which reuses the existing code but:

  - needs a vmlinux with symbols
  - drops kaslr because it doesn't play nice with symbols
  - extend qargs with stuff normally added by vm.launch
  - passes kargs directly
  - runs with the gdb run-test script
  - log the run-test output to the console log
  - makes --binary not mandatory

Message-ID: <20260930164649.433573-13-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v3
  - mention the nokaslr in the commit message
  - add a comment about it to the shared kernel args
  - drop unused failcount
  - remove stale comment about hbreak
  - always delete the watch point pass or fail
  - fix unbalanced tuple in sh4's direct call of fetch_tuxrun_assets
  - simplify the symbol to watchpoint logic
  - drop the mandatory --binary
  - make the command copy and paste friendly
v2
  - add self.vm._machine to qargs
  - drop leading spaces in print () calls
  - add register read tests
  - use gdb.Breakpoint for hwbreak as for swbreak
  - drop flaky symbol evaluation, verify hit_count instead
  - explicit gdb.BP_BREAKPOINT for CatchBreakpoint
---
 .../functional/gdb-scripts/kernel_gdb_test.py | 162 ++++++++++++++++++
 tests/functional/qemu_test/tuxruntest.py      |  97 ++++++++++-
 tests/functional/sh4/test_tuxrun.py           |   4 +-
 tests/guest-debug/run-test.py                 |  14 +-
 4 files changed, 261 insertions(+), 16 deletions(-)
 create mode 100644 tests/functional/gdb-scripts/kernel_gdb_test.py

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
index ca1589fea37..6ad421e897d 100644
--- a/tests/functional/qemu_test/tuxruntest.py
+++ b/tests/functional/qemu_test/tuxruntest.py
@@ -9,7 +9,9 @@
 #
 # SPDX-License-Identifier: GPL-2.0-or-later
 
+import logging
 import os
+import subprocess
 
 from qemu_test import QemuSystemTest
 from qemu_test import exec_command_and_wait_for_pattern
@@ -18,7 +20,8 @@
 
 class TuxRunBaselineTest(QemuSystemTest):
 
-    KERNEL_COMMON_COMMAND_LINE = 'printk.time=0'
+    # nokaslr is needed for gdb tests but it makes things simpler anyway
+    KERNEL_COMMON_COMMAND_LINE = 'printk.time=0 nokaslr'
     # Tests are ~10-40s, allow for --debug/--enable-gcov overhead
     timeout = 100
 
@@ -55,17 +58,20 @@ def wait_for_console_pattern(self, success_message, vm=None):
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
@@ -83,9 +89,15 @@ def prepare_run(self, accel, kernel, disk, drive, dtb=None, console_index=0):
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
@@ -132,10 +144,77 @@ def common_tuxrun(self,
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
+                          haltmsg="reboot: System halted",
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
+            "--qargs", " ".join(qargs),
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
index e74bb489ee1..48a5261618d 100755
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


