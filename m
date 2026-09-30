Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32DA6CA5FC7
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 16:47:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBxSe-0001MY-M4; Wed, 30 Sep 2026 12:47:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xBxSa-0001Eg-Gd
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 12:47:14 -0400
Received: from mail-wr2-x0f.google.com ([2a00:1450:4864:30::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xBxSW-00035O-0I
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 12:47:10 -0400
Received: by mail-wr2-x0f.google.com with SMTP id
 ffacd0b85a97d-482f635552aso4371385f8f.2
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 09:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790786826; x=1791391626; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2SM5rF7Jmxa0V3al/33JKCdndeOa0J9QZz5CKDg3Mbc=;
 b=n7qRDIguA07Kvd+8tq0Jz3o2VO7zzVDcF/W/Nyre2T966zwMCvJ5b6pwuYeiJhR0DP
 yBPA9+RLaW56AggR0ZCYREvCNKxh65jDTQUYbimaJSg6tCtDNApDPZc3TfyGriw7hmgV
 Bk2aYvX+Bn/avpL+HYABnVUFoUZcLrsiSjTyCuCPm26ayYgya091sXBVI/aQiaEA1iWc
 XyH09T4pAgKm2CKJ0BavvCGhx7WfkUAM2GKxgkV9UGdv8kTtD8xNR9yI4gKO3Tnwt4ZE
 40XAcYaUqu2rHzhxitVj2l6sdc9yMrzjni+WfrV4/ORu4f96fwJmaxKPPv1Dy0kaLcjz
 Ouow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790786826; x=1791391626;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2SM5rF7Jmxa0V3al/33JKCdndeOa0J9QZz5CKDg3Mbc=;
 b=Oo0cEdJzm/XqEGGSr7zfAdm4BY430ZD/U38HI4c+hznRW6PrmxQ+b8hN4HVEUWfkN3
 KM5+90p9n0dwRUi4oSV6alVS5bcnN7KPGwFxEJhcSlYJiWua2IIrY6X9I1B6m5VWn6e8
 ZWHADXY+xcC3BsXFTeDDRPvWpts6CLQy+L6zjIi3xZcO0LALECnWZAaMW8v0pO3V3lkd
 W9g52R8G/BdKj30hCBWXU6Uh7/5VWpaebq8MGsT8uIFHVHUsk2UZ//JmZlry4UmrX5EQ
 ttbTLcwAkzfULM2ZBtLJ3L1HtTEaOom4pxLaR+FAEwu+kiDX+4Xgzo07tj9YTmIuhHfT
 +4sg==
X-Gm-Message-State: AFq9FYLxjK0Twy+DNzlmKM8tXQ5hwowSJ7tfgieleLcL8IBPTeLZMJD6
 11GGRS+XGu7A3P3LOucFcyrNYBTi9jE5wc23+cuM53vAika6lZnzBGzO7/nemrpI+zw=
X-Gm-Gg: AYBFou0e2DdZfbzVS9TLsSUdSLvm4n1SpNGZz0nUelhLfgOtc8Gqy8Dz3P50p+k/nih
 vexZManK1RBjwlY0NWF0ulKp9nH17bltoIG5pyk42AJQwmMHeunnRfGhchYE1Fscqe1RPRq4NOW
 RI9jtK7yxJ5FpA9DFwTzqs2glZ7Q2OdVMF8auk66ErmQVii2ymEsMVr9Yw7XFWljLKUQj7/MOt3
 roGqacuHHNyLtR5jNrrDGJ/KHWCyHgUASxLYcfYXtWsmq7LnJz1BxCAUBYTEWgh5E8FgwwikiDd
 +4ZRInt5Oq8hk1FRywL9kt5cFyYPM0z2ldlv50hYosZwHLhb1f+wlGLoCwRq+5hh/CAeg+WGVpi
 3r1Ek460zgLyVrH/0jCh2vNtDGlTmmVtv1W+KNRT7pxdhbesKvBuGmzuyqqA4SQgX5mm4PDIxZK
 CUGartqbOhgjWBDh4dHA95KebqXokIWK14mSkq0sqR5c0O0u1spPRJXemFhZ+AhXPQ1lXa0g==
X-Received: by 2002:a5d:5d87:0:b0:488:5db4:791e with SMTP id
 ffacd0b85a97d-48b024c1fc7mr4258044f8f.11.1790786826153; 
 Wed, 30 Sep 2026 09:47:06 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b0692b1c9sm238794f8f.27.2026.09.30.09.46.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 09:47:02 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E74286199F;
 Wed, 30 Sep 2026 17:46:50 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Song Gao <gaosong@loongson.cn>,
 Ani Sinha <anisinha@redhat.com>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 John Snow <jsnow@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Cornelia Huck <cohuck@redhat.com>, Thomas Huth <th.huth+qemu@posteo.eu>,
 Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Brad Smith <brad@comstyle.com>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Anders Roxell <anders.roxell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Klaus Jensen <its@irrelevant.dk>
Subject: [PATCH 12/13] tests/functional: teach tuxrun about launching gdb tests
Date: Wed, 30 Sep 2026 17:46:48 +0100
Message-ID: <20260930164649.433573-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260930164649.433573-1-alex.bennee@linaro.org>
References: <20260930164649.433573-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:30::f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr2-x0f.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This resurrects the hand run test script from d84842be6c5 (tests:
remove test-gdbstub.py) and modernises it to use the shared test
infrastructure for run-test.

We then tweak the common tuxrun code to over an alternative "launch
via gdbstub" helper which reuses the existing code but:

  - needs a vmlinux with symbols
  - passes kargs directly
  - runs with the gdb run-test script
  - log the run-test output to the console log

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .../functional/gdb-scripts/kernel_gdb_test.py | 157 ++++++++++++++++++
 tests/functional/qemu_test/tuxruntest.py      |  92 +++++++++-
 2 files changed, 240 insertions(+), 9 deletions(-)
 create mode 100644 tests/functional/gdb-scripts/kernel_gdb_test.py

diff --git a/tests/functional/gdb-scripts/kernel_gdb_test.py b/tests/functional/gdb-scripts/kernel_gdb_test.py
new file mode 100644
index 00000000000..5ca9aa43de3
--- /dev/null
+++ b/tests/functional/gdb-scripts/kernel_gdb_test.py
@@ -0,0 +1,157 @@
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
+failcount = 0
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
+def check_break(sym_name):
+    "Setup breakpoint, continue and check we stopped."
+    sym, ok = gdb.lookup_symbol(sym_name)
+    bp = gdb.Breakpoint(sym_name)
+
+    gdb.execute("c")
+
+    # hopefully we came back
+    end_pc = gdb.parse_and_eval('$pc')
+    print ("%s == %s %d" % (end_pc, sym.value(), bp.hit_count))
+    bp.delete()
+
+    # can we test we hit bp?
+    return end_pc == sym.value()
+
+
+# We need to do hbreak manually as the python interface doesn't export it
+def check_hbreak(sym_name):
+    "Setup hardware breakpoint, continue and check we stopped."
+    sym, ok = gdb.lookup_symbol(sym_name)
+    gdb.execute("hbreak %s" % (sym_name))
+    gdb.execute("c")
+
+    # hopefully we came back
+    end_pc = gdb.parse_and_eval('$pc')
+    print ("%s == %s" % (end_pc, sym.value()))
+
+    if end_pc == sym.value():
+        gdb.execute("d 1")
+        return True
+    else:
+        return False
+
+
+class WatchPoint(gdb.Breakpoint):
+
+    def get_wpstr(self, sym_name):
+        "Setup sym and wp_str for given symbol."
+        self.sym, ok = gdb.lookup_symbol(sym_name)
+        wp_addr = gdb.parse_and_eval(sym_name).address
+        self.wp_str = '*(%(type)s)(&%(address)s)' % dict(
+            type = wp_addr.type, address = sym_name)
+
+        return(self.wp_str)
+
+    def __init__(self, sym_name, type):
+        wp_str = self.get_wpstr(sym_name)
+        super(WatchPoint, self).__init__(wp_str, gdb.BP_WATCHPOINT, type)
+
+    def stop(self):
+        end_pc = gdb.parse_and_eval('$pc')
+        print ("HIT WP @ %s" % (end_pc))
+        return True
+
+
+def do_one_watch(sym, wtype, text):
+
+    wp = WatchPoint(sym, wtype)
+    gdb.execute("c")
+    report_str = "%s for %s (%s)" % (text, sym, wp.sym.value())
+
+    if wp.hit_count > 0:
+        report(True, report_str)
+        wp.delete()
+    else:
+        report(False, report_str)
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
+        super(CatchBreakpoint, self).__init__(sym_name)
+        self.sym, ok = gdb.lookup_symbol(sym_name)
+
+    def stop(self):
+        end_pc = gdb.parse_and_eval('$pc')
+        print ("CB: %s == %s" % (end_pc, self.sym.value()))
+        if end_pc == self.sym.value():
+            report(False, "Hit final catchpoint")
+
+
+def run_test():
+    "Run through the tests one by one"
+
+    print ("Checking we can step the first few instructions")
+    step_ok = 0
+    for i in range(3):
+        if check_step():
+            step_ok += 1
+
+    report(step_ok == 3, "single step in boot code")
+
+    print ("Checking HW breakpoint works")
+    break_ok = check_hbreak("kernel_init")
+    report(break_ok, "hbreak @ kernel_init")
+
+    # Can't set this up until we are in the kernel proper
+    # if we make it to run_init_process we've over-run and
+    # one of the tests failed
+    print ("Setup catch-all for run_init_process")
+    cbp = CatchBreakpoint("run_init_process")
+    cpb2 = CatchBreakpoint("try_to_run_init_process")
+
+    print ("Checking Normal breakpoint works")
+    break_ok = check_break("wait_for_completion")
+    report(break_ok, "break @ wait_for_completion")
+
+    print ("Checking watchpoint works")
+    check_watches("system_state")
+
+
+main(run_test)
diff --git a/tests/functional/qemu_test/tuxruntest.py b/tests/functional/qemu_test/tuxruntest.py
index ca1589fea37..e6b32fbcab2 100644
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
@@ -18,7 +20,7 @@
 
 class TuxRunBaselineTest(QemuSystemTest):
 
-    KERNEL_COMMON_COMMAND_LINE = 'printk.time=0'
+    KERNEL_COMMON_COMMAND_LINE = 'printk.time=0 nokaslr'
     # Tests are ~10-40s, allow for --debug/--enable-gcov overhead
     timeout = 100
 
@@ -55,17 +57,20 @@ def wait_for_console_pattern(self, success_message, vm=None):
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
@@ -83,9 +88,15 @@ def prepare_run(self, accel, kernel, disk, drive, dtb=None, console_index=0):
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
@@ -132,10 +143,73 @@ def common_tuxrun(self,
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
+        cmd = [
+            str(run_script),
+            "--qemu", self.qemu_bin,
+            "--qargs", " ".join(qargs),
+            "--kargs", self.kcmd_line,
+            "--binary", "",
+            "--symbols", str(vmlinux),
+            "--test", str(test_script),
+            "--gdb", gdb_path,
+        ]
+
+        self.log.info(f"run-test: {' '.join(cmd)}")
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
-- 
2.47.3


