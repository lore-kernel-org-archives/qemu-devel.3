Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95D99C47258
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jan 2024 04:44:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTx0U-0004nP-0z; Sat, 27 Jan 2024 23:42:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTx0S-0004nG-SR
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 23:42:56 -0500
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTx0Q-0004LT-4x
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 23:42:56 -0500
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2954b34ddd0so313455a91.0
 for <qemu-devel@nongnu.org>; Sat, 27 Jan 2024 20:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706416973; x=1707021773; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n3i8WIPnfJe6OJ/KMGjZPX6qT+eI0MPf6OW8gP6VkEI=;
 b=Eac12R1P1SS7QNLIlhoXAB2DrTLsmI3mNNHKhz2fC2aXwvJZsLSYgL7vYOnx+pCFC5
 opH6J4/nh6VL2J+/2hayD4cbYd+cg2IpyZvF2AkBC+mqeBtA62h8/yzb5P8pFUHY7fsN
 DLPw26vRRL/XMRgoPAXLtf6fTkSPXZMQxtUrR8Mjq4gGO2Ipj6WYvqhjeh59T8ORogjw
 KkzHjPdemJZ0hb8jmRhNrT8tT9WKWTondfPXUN7hs0ALAESP1A7cKTotbrxFSgEwYFMC
 Be56iirMIe2OPO/hwxrtZTGh408yQ3U7X8W0c8xk06fOqB12fNRL6XmXr9Xcv+xyWITz
 7Jgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706416973; x=1707021773;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n3i8WIPnfJe6OJ/KMGjZPX6qT+eI0MPf6OW8gP6VkEI=;
 b=l+2hnQawIk6CFp2vA8mud6BSyg511B/UZJY2U6pt0exXoXfMbdNlU1aIV6ZcDhb6Te
 ycQSpU0fkSTqTFooZjp2zogdUwLziICSliQN4/fffNIh8TOMZnnvT/Nb2B3cXa/fDrp7
 K/AcFlGg9pGnkIgkXJDW1SoeNBH1UwQ0eypfR3ixNsT7W6slK6onbbOGlwtEyMMlOAGp
 Lde9+zD6BHVNzUMJk9rT/6odj+uSheZle6mHhD8WVK7WzdDm/MhUg2xO/cTfQ+oWAKMr
 A4Rc0upBgGpm5kwhZqv0nnC+78tKXTuICE5d1EYEJvgBGb2mt7opJ++Ab6bRkIn6t9i6
 B5tg==
X-Gm-Message-State: AOJu0YyIwMCgV9DX7lJgm30BqnRlHg/HYUxqCPJtnKpoKDac7vPJpP6R
 ZOWsAIDl6uWBO/YAA4AfreVqsgyp7fagerJhyOXYm0b500yd80hUm8wwlsu6M7gYMNLZkV3/8pJ
 52vBZAw==
X-Google-Smtp-Source: AGHT+IE1opL2eZ7d3MUOOou62+xihPi04M9omeaSYm9yLz4uRBTQENcKUkjFviVMb1LuF/VsQnXz6A==
X-Received: by 2002:a17:90b:1d8a:b0:28f:f6fa:55a7 with SMTP id
 pf10-20020a17090b1d8a00b0028ff6fa55a7mr1661308pjb.2.1706416972788; 
 Sat, 27 Jan 2024 20:42:52 -0800 (PST)
Received: from stoup..
 (ppp121-45-131-89.bri-pow-que-bras31.tpg.internode.on.net. [121.45.131.89])
 by smtp.gmail.com with ESMTPSA id
 w24-20020a17090aaf9800b002906e09e1d1sm5631873pjq.18.2024.01.27.20.42.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Jan 2024 20:42:52 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 14/33] tests/tcg: Factor out gdbstub test functions
Date: Sun, 28 Jan 2024 14:41:54 +1000
Message-Id: <20240128044213.316480-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240128044213.316480-1-richard.henderson@linaro.org>
References: <20240128044213.316480-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

Both the report() function as well as the initial gdbstub test sequence
are copy-pasted into ~10 files with slight modifications. This
indicates that they are indeed generic, so factor them out. While
at it, add a few newlines to make the formatting closer to PEP-8.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-Id: <20240109230808.583012-3-iii@linux.ibm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/guest-debug/run-test.py                 |  7 ++-
 tests/guest-debug/test_gdbstub.py             | 56 +++++++++++++++++++
 tests/tcg/aarch64/gdbstub/test-sve-ioctl.py   | 34 +----------
 tests/tcg/aarch64/gdbstub/test-sve.py         | 33 +----------
 tests/tcg/multiarch/gdbstub/interrupt.py      | 47 ++--------------
 tests/tcg/multiarch/gdbstub/memory.py         | 39 +------------
 tests/tcg/multiarch/gdbstub/registers.py      | 41 ++------------
 tests/tcg/multiarch/gdbstub/sha1.py           | 38 ++-----------
 .../multiarch/gdbstub/test-proc-mappings.py   | 39 +------------
 .../multiarch/gdbstub/test-qxfer-auxv-read.py | 37 +-----------
 .../gdbstub/test-thread-breakpoint.py         | 37 +-----------
 tests/tcg/s390x/gdbstub/test-signals-s390x.py | 42 +-------------
 tests/tcg/s390x/gdbstub/test-svc.py           | 39 +------------
 13 files changed, 94 insertions(+), 395 deletions(-)
 create mode 100644 tests/guest-debug/test_gdbstub.py

diff --git a/tests/guest-debug/run-test.py b/tests/guest-debug/run-test.py
index b13b27d4b1..368ff8a890 100755
--- a/tests/guest-debug/run-test.py
+++ b/tests/guest-debug/run-test.py
@@ -97,7 +97,12 @@ def log(output, msg):
     sleep(1)
     log(output, "GDB CMD: %s" % (gdb_cmd))
 
-    result = subprocess.call(gdb_cmd, shell=True, stdout=output, stderr=stderr)
+    gdb_env = dict(os.environ)
+    gdb_pythonpath = gdb_env.get("PYTHONPATH", "").split(os.pathsep)
+    gdb_pythonpath.append(os.path.dirname(os.path.realpath(__file__)))
+    gdb_env["PYTHONPATH"] = os.pathsep.join(gdb_pythonpath)
+    result = subprocess.call(gdb_cmd, shell=True, stdout=output, stderr=stderr,
+                             env=gdb_env)
 
     # A result of greater than 128 indicates a fatal signal (likely a
     # crash due to gdb internal failure). That's a problem for GDB and
diff --git a/tests/guest-debug/test_gdbstub.py b/tests/guest-debug/test_gdbstub.py
new file mode 100644
index 0000000000..1bc4ed131f
--- /dev/null
+++ b/tests/guest-debug/test_gdbstub.py
@@ -0,0 +1,56 @@
+"""Helper functions for gdbstub testing
+
+"""
+from __future__ import print_function
+import gdb
+import sys
+
+fail_count = 0
+
+
+def report(cond, msg):
+    """Report success/fail of a test"""
+    if cond:
+        print("PASS: {}".format(msg))
+    else:
+        print("FAIL: {}".format(msg))
+        global fail_count
+        fail_count += 1
+
+
+def main(test, expected_arch=None):
+    """Run a test function
+
+    This runs as the script it sourced (via -x, via run-test.py)."""
+    try:
+        inferior = gdb.selected_inferior()
+        arch = inferior.architecture()
+        print("ATTACHED: {}".format(arch))
+        if expected_arch is not None:
+            report(arch.name() == expected_arch,
+                   "connected to {}".format(expected_arch))
+    except (gdb.error, AttributeError):
+        print("SKIP: not connected")
+        exit(0)
+
+    if gdb.parse_and_eval("$pc") == 0:
+        print("SKIP: PC not set")
+        exit(0)
+
+    try:
+        test()
+    except:
+        print("GDB Exception: {}".format(sys.exc_info()[0]))
+        global fail_count
+        fail_count += 1
+        import code
+        code.InteractiveConsole(locals=globals()).interact()
+        raise
+
+    try:
+        gdb.execute("kill")
+    except gdb.error:
+        pass
+
+    print("All tests complete: %d failures".format(fail_count))
+    exit(fail_count)
diff --git a/tests/tcg/aarch64/gdbstub/test-sve-ioctl.py b/tests/tcg/aarch64/gdbstub/test-sve-ioctl.py
index ee8d467e59..a78a3a2514 100644
--- a/tests/tcg/aarch64/gdbstub/test-sve-ioctl.py
+++ b/tests/tcg/aarch64/gdbstub/test-sve-ioctl.py
@@ -8,19 +8,10 @@
 #
 
 import gdb
-import sys
+from test_gdbstub import main, report
 
 initial_vlen = 0
-failcount = 0
 
-def report(cond, msg):
-    "Report success/fail of test"
-    if cond:
-        print ("PASS: %s" % (msg))
-    else:
-        print ("FAIL: %s" % (msg))
-        global failcount
-        failcount += 1
 
 class TestBreakpoint(gdb.Breakpoint):
     def __init__(self, sym_name="__sve_ld_done"):
@@ -64,26 +55,5 @@ def run_test():
 
     gdb.execute("c")
 
-#
-# This runs as the script it sourced (via -x, via run-test.py)
-#
-try:
-    inferior = gdb.selected_inferior()
-    arch = inferior.architecture()
-    report(arch.name() == "aarch64", "connected to aarch64")
-except (gdb.error, AttributeError):
-    print("SKIPPING (not connected)", file=sys.stderr)
-    exit(0)
 
-try:
-    # Run the actual tests
-    run_test()
-except:
-    print ("GDB Exception: %s" % (sys.exc_info()[0]))
-    failcount += 1
-    import code
-    code.InteractiveConsole(locals=globals()).interact()
-    raise
-
-print("All tests complete: %d failures" % failcount)
-exit(failcount)
+main(run_test, expected_arch="aarch64")
diff --git a/tests/tcg/aarch64/gdbstub/test-sve.py b/tests/tcg/aarch64/gdbstub/test-sve.py
index afd8ece98d..84cdcd4a32 100644
--- a/tests/tcg/aarch64/gdbstub/test-sve.py
+++ b/tests/tcg/aarch64/gdbstub/test-sve.py
@@ -6,20 +6,10 @@
 #
 
 import gdb
-import sys
+from test_gdbstub import main, report
 
 MAGIC = 0xDEADBEEF
 
-failcount = 0
-
-def report(cond, msg):
-    "Report success/fail of test"
-    if cond:
-        print ("PASS: %s" % (msg))
-    else:
-        print ("FAIL: %s" % (msg))
-        global failcount
-        failcount += 1
 
 def run_test():
     "Run through the tests one by one"
@@ -54,24 +44,5 @@ def run_test():
             report(str(v.type) == "uint64_t", "size of %s" % (reg))
             report(int(v) == MAGIC, "%s is 0x%x" % (reg, MAGIC))
 
-#
-# This runs as the script it sourced (via -x, via run-test.py)
-#
-try:
-    inferior = gdb.selected_inferior()
-    arch = inferior.architecture()
-    report(arch.name() == "aarch64", "connected to aarch64")
-except (gdb.error, AttributeError):
-    print("SKIPPING (not connected)", file=sys.stderr)
-    exit(0)
 
-try:
-    # Run the actual tests
-    run_test()
-except:
-    print ("GDB Exception: %s" % (sys.exc_info()[0]))
-    failcount += 1
-
-print("All tests complete: %d failures" % failcount)
-
-exit(failcount)
+main(run_test, expected_arch="aarch64")
diff --git a/tests/tcg/multiarch/gdbstub/interrupt.py b/tests/tcg/multiarch/gdbstub/interrupt.py
index c016e7afbb..90a45b5140 100644
--- a/tests/tcg/multiarch/gdbstub/interrupt.py
+++ b/tests/tcg/multiarch/gdbstub/interrupt.py
@@ -8,19 +8,7 @@
 #
 
 import gdb
-import sys
-
-failcount = 0
-
-
-def report(cond, msg):
-    "Report success/fail of test"
-    if cond:
-        print("PASS: %s" % (msg))
-    else:
-        print("FAIL: %s" % (msg))
-        global failcount
-        failcount += 1
+from test_gdbstub import main, report
 
 
 def check_interrupt(thread):
@@ -59,6 +47,9 @@ def run_test():
     Test if interrupting the code always lands us on the same thread when
     running with scheduler-lock enabled.
     """
+    if len(gdb.selected_inferior().threads()) == 1:
+        print("SKIP: set to run on a single thread")
+        exit(0)
 
     gdb.execute("set scheduler-locking on")
     for thread in gdb.selected_inferior().threads():
@@ -66,32 +57,4 @@ def run_test():
                "thread %d resumes correctly on interrupt" % thread.num)
 
 
-#
-# This runs as the script it sourced (via -x, via run-test.py)
-#
-try:
-    inferior = gdb.selected_inferior()
-    arch = inferior.architecture()
-    print("ATTACHED: %s" % arch.name())
-except (gdb.error, AttributeError):
-    print("SKIPPING (not connected)", file=sys.stderr)
-    exit(0)
-
-if gdb.parse_and_eval('$pc') == 0:
-    print("SKIP: PC not set")
-    exit(0)
-if len(gdb.selected_inferior().threads()) == 1:
-    print("SKIP: set to run on a single thread")
-    exit(0)
-
-try:
-    # Run the actual tests
-    run_test()
-except (gdb.error):
-    print("GDB Exception: %s" % (sys.exc_info()[0]))
-    failcount += 1
-    pass
-
-# Finally kill the inferior and exit gdb with a count of failures
-gdb.execute("kill")
-exit(failcount)
+main(run_test)
diff --git a/tests/tcg/multiarch/gdbstub/memory.py b/tests/tcg/multiarch/gdbstub/memory.py
index fb1d06b7bb..532b92e7fb 100644
--- a/tests/tcg/multiarch/gdbstub/memory.py
+++ b/tests/tcg/multiarch/gdbstub/memory.py
@@ -9,18 +9,7 @@
 
 import gdb
 import sys
-
-failcount = 0
-
-
-def report(cond, msg):
-    "Report success/fail of test"
-    if cond:
-        print("PASS: %s" % (msg))
-    else:
-        print("FAIL: %s" % (msg))
-        global failcount
-        failcount += 1
+from test_gdbstub import main, report
 
 
 def check_step():
@@ -99,29 +88,5 @@ def run_test():
 
     report(cbp.hit_count == 0, "didn't reach backstop")
 
-#
-# This runs as the script it sourced (via -x, via run-test.py)
-#
-try:
-    inferior = gdb.selected_inferior()
-    arch = inferior.architecture()
-    print("ATTACHED: %s" % arch.name())
-except (gdb.error, AttributeError):
-    print("SKIPPING (not connected)", file=sys.stderr)
-    exit(0)
 
-if gdb.parse_and_eval('$pc') == 0:
-    print("SKIP: PC not set")
-    exit(0)
-
-try:
-    # Run the actual tests
-    run_test()
-except (gdb.error):
-    print("GDB Exception: %s" % (sys.exc_info()[0]))
-    failcount += 1
-    pass
-
-# Finally kill the inferior and exit gdb with a count of failures
-gdb.execute("kill")
-exit(failcount)
+main(run_test)
diff --git a/tests/tcg/multiarch/gdbstub/registers.py b/tests/tcg/multiarch/gdbstub/registers.py
index 688c061107..b3d13cb077 100644
--- a/tests/tcg/multiarch/gdbstub/registers.py
+++ b/tests/tcg/multiarch/gdbstub/registers.py
@@ -7,20 +7,11 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
 import gdb
-import sys
 import xml.etree.ElementTree as ET
+from test_gdbstub import main, report
+
 
 initial_vlen = 0
-failcount = 0
-
-def report(cond, msg):
-    "Report success/fail of test."
-    if cond:
-        print("PASS: %s" % (msg))
-    else:
-        print("FAIL: %s" % (msg))
-        global failcount
-        failcount += 1
 
 
 def fetch_xml_regmap():
@@ -75,6 +66,7 @@ def fetch_xml_regmap():
 
     return reg_map
 
+
 def get_register_by_regnum(reg_map, regnum):
     """
     Helper to find a register from the map via its XML regnum
@@ -84,6 +76,7 @@ def get_register_by_regnum(reg_map, regnum):
             return entry
     return None
 
+
 def crosscheck_remote_xml(reg_map):
     """
     Cross-check the list of remote-registers with the XML info.
@@ -144,6 +137,7 @@ def crosscheck_remote_xml(reg_map):
         elif "seen" not in x_reg:
             print(f"{x_reg} wasn't seen in remote-registers")
 
+
 def initial_register_read(reg_map):
     """
     Do an initial read of all registers that we know gdb cares about
@@ -214,27 +208,4 @@ def run_test():
         complete_and_diff(reg_map)
 
 
-#
-# This runs as the script it sourced (via -x, via run-test.py)
-#
-try:
-    inferior = gdb.selected_inferior()
-    arch = inferior.architecture()
-    print("ATTACHED: %s" % arch.name())
-except (gdb.error, AttributeError):
-    print("SKIPPING (not connected)", file=sys.stderr)
-    exit(0)
-
-if gdb.parse_and_eval('$pc') == 0:
-    print("SKIP: PC not set")
-    exit(0)
-
-try:
-    run_test()
-except (gdb.error):
-    print ("GDB Exception: %s" % (sys.exc_info()[0]))
-    failcount += 1
-    pass
-
-print("All tests complete: %d failures" % failcount)
-exit(failcount)
+main(run_test)
diff --git a/tests/tcg/multiarch/gdbstub/sha1.py b/tests/tcg/multiarch/gdbstub/sha1.py
index 416728415f..1ce711a402 100644
--- a/tests/tcg/multiarch/gdbstub/sha1.py
+++ b/tests/tcg/multiarch/gdbstub/sha1.py
@@ -7,19 +7,11 @@
 #
 
 import gdb
-import sys
+from test_gdbstub import main, report
+
 
 initial_vlen = 0
-failcount = 0
 
-def report(cond, msg):
-    "Report success/fail of test"
-    if cond:
-        print("PASS: %s" % (msg))
-    else:
-        print("FAIL: %s" % (msg))
-        global failcount
-        failcount += 1
 
 def check_break(sym_name):
     "Setup breakpoint, continue and check we stopped."
@@ -35,6 +27,7 @@ def check_break(sym_name):
 
     bp.delete()
 
+
 def run_test():
     "Run through the tests one by one"
 
@@ -57,28 +50,5 @@ def run_test():
     # finally check we don't barf inspecting registers
     gdb.execute("info registers")
 
-#
-# This runs as the script it sourced (via -x, via run-test.py)
-#
-try:
-    inferior = gdb.selected_inferior()
-    arch = inferior.architecture()
-    print("ATTACHED: %s" % arch.name())
-except (gdb.error, AttributeError):
-    print("SKIPPING (not connected)", file=sys.stderr)
-    exit(0)
 
-if gdb.parse_and_eval('$pc') == 0:
-    print("SKIP: PC not set")
-    exit(0)
-
-try:
-    # Run the actual tests
-    run_test()
-except (gdb.error):
-    print ("GDB Exception: %s" % (sys.exc_info()[0]))
-    failcount += 1
-    pass
-
-print("All tests complete: %d failures" % failcount)
-exit(failcount)
+main(run_test)
diff --git a/tests/tcg/multiarch/gdbstub/test-proc-mappings.py b/tests/tcg/multiarch/gdbstub/test-proc-mappings.py
index 04ec61d219..564613fabf 100644
--- a/tests/tcg/multiarch/gdbstub/test-proc-mappings.py
+++ b/tests/tcg/multiarch/gdbstub/test-proc-mappings.py
@@ -3,20 +3,7 @@
 This runs as a sourced script (via -x, via run-test.py)."""
 from __future__ import print_function
 import gdb
-import sys
-
-
-n_failures = 0
-
-
-def report(cond, msg):
-    """Report success/fail of a test"""
-    if cond:
-        print("PASS: {}".format(msg))
-    else:
-        print("FAIL: {}".format(msg))
-        global n_failures
-        n_failures += 1
+from test_gdbstub import main, report
 
 
 def run_test():
@@ -37,26 +24,4 @@ def run_test():
     # report("/sha1" in mappings, "Found the test binary name in the mappings")
 
 
-def main():
-    """Prepare the environment and run through the tests"""
-    try:
-        inferior = gdb.selected_inferior()
-        print("ATTACHED: {}".format(inferior.architecture().name()))
-    except (gdb.error, AttributeError):
-        print("SKIPPING (not connected)")
-        exit(0)
-
-    if gdb.parse_and_eval('$pc') == 0:
-        print("SKIP: PC not set")
-        exit(0)
-
-    try:
-        # Run the actual tests
-        run_test()
-    except gdb.error:
-        report(False, "GDB Exception: {}".format(sys.exc_info()[0]))
-    print("All tests complete: %d failures" % n_failures)
-    exit(n_failures)
-
-
-main()
+main(run_test)
diff --git a/tests/tcg/multiarch/gdbstub/test-qxfer-auxv-read.py b/tests/tcg/multiarch/gdbstub/test-qxfer-auxv-read.py
index 926fa962b7..00c26ab4a9 100644
--- a/tests/tcg/multiarch/gdbstub/test-qxfer-auxv-read.py
+++ b/tests/tcg/multiarch/gdbstub/test-qxfer-auxv-read.py
@@ -6,18 +6,8 @@
 #
 
 import gdb
-import sys
+from test_gdbstub import main, report
 
-failcount = 0
-
-def report(cond, msg):
-    "Report success/fail of test"
-    if cond:
-        print ("PASS: %s" % (msg))
-    else:
-        print ("FAIL: %s" % (msg))
-        global failcount
-        failcount += 1
 
 def run_test():
     "Run through the tests one by one"
@@ -26,28 +16,5 @@ def run_test():
     report(isinstance(auxv, str), "Fetched auxv from inferior")
     report(auxv.find("sha1"), "Found test binary name in auxv")
 
-#
-# This runs as the script it sourced (via -x, via run-test.py)
-#
-try:
-    inferior = gdb.selected_inferior()
-    arch = inferior.architecture()
-    print("ATTACHED: %s" % arch.name())
-except (gdb.error, AttributeError):
-    print("SKIPPING (not connected)", file=sys.stderr)
-    exit(0)
 
-if gdb.parse_and_eval('$pc') == 0:
-    print("SKIP: PC not set")
-    exit(0)
-
-try:
-    # Run the actual tests
-    run_test()
-except (gdb.error):
-    print ("GDB Exception: %s" % (sys.exc_info()[0]))
-    failcount += 1
-    pass
-
-print("All tests complete: %d failures" % failcount)
-exit(failcount)
+main(run_test)
diff --git a/tests/tcg/multiarch/gdbstub/test-thread-breakpoint.py b/tests/tcg/multiarch/gdbstub/test-thread-breakpoint.py
index e57d2a8db8..4d6b6b9fbe 100644
--- a/tests/tcg/multiarch/gdbstub/test-thread-breakpoint.py
+++ b/tests/tcg/multiarch/gdbstub/test-thread-breakpoint.py
@@ -6,18 +6,8 @@
 #
 
 import gdb
-import sys
+from test_gdbstub import main, report
 
-failcount = 0
-
-def report(cond, msg):
-    "Report success/fail of test"
-    if cond:
-        print ("PASS: %s" % (msg))
-    else:
-        print ("FAIL: %s" % (msg))
-        global failcount
-        failcount += 1
 
 def run_test():
     "Run through the tests one by one"
@@ -29,28 +19,5 @@ def run_test():
     frame = gdb.selected_frame()
     report(str(frame.function()) == "thread1_func", "break @ %s"%frame)
 
-#
-# This runs as the script it sourced (via -x, via run-test.py)
-#
-try:
-    inferior = gdb.selected_inferior()
-    arch = inferior.architecture()
-    print("ATTACHED: %s" % arch.name())
-except (gdb.error, AttributeError):
-    print("SKIPPING (not connected)", file=sys.stderr)
-    exit(0)
 
-if gdb.parse_and_eval('$pc') == 0:
-    print("SKIP: PC not set")
-    exit(0)
-
-try:
-    # Run the actual tests
-    run_test()
-except (gdb.error):
-    print ("GDB Exception: %s" % (sys.exc_info()[0]))
-    failcount += 1
-    pass
-
-print("All tests complete: %d failures" % failcount)
-exit(failcount)
+main(run_test)
diff --git a/tests/tcg/s390x/gdbstub/test-signals-s390x.py b/tests/tcg/s390x/gdbstub/test-signals-s390x.py
index ca2bbc0b03..b6b7b39fc4 100644
--- a/tests/tcg/s390x/gdbstub/test-signals-s390x.py
+++ b/tests/tcg/s390x/gdbstub/test-signals-s390x.py
@@ -7,19 +7,7 @@
 #
 
 import gdb
-import sys
-
-failcount = 0
-
-
-def report(cond, msg):
-    """Report success/fail of test"""
-    if cond:
-        print("PASS: %s" % (msg))
-    else:
-        print("FAIL: %s" % (msg))
-        global failcount
-        failcount += 1
+from test_gdbstub import main, report
 
 
 def run_test():
@@ -42,31 +30,7 @@ def run_test():
     gdb.Breakpoint("_exit")
     gdb.execute("c")
     status = int(gdb.parse_and_eval("$r2"))
-    report(status == 0, "status == 0");
+    report(status == 0, "status == 0")
 
 
-#
-# This runs as the script it sourced (via -x, via run-test.py)
-#
-try:
-    inferior = gdb.selected_inferior()
-    arch = inferior.architecture()
-    print("ATTACHED: %s" % arch.name())
-except (gdb.error, AttributeError):
-    print("SKIPPING (not connected)", file=sys.stderr)
-    exit(0)
-
-if gdb.parse_and_eval("$pc") == 0:
-    print("SKIP: PC not set")
-    exit(0)
-
-try:
-    # Run the actual tests
-    run_test()
-except (gdb.error):
-    print("GDB Exception: %s" % (sys.exc_info()[0]))
-    failcount += 1
-    pass
-
-print("All tests complete: %d failures" % failcount)
-exit(failcount)
+main(run_test)
diff --git a/tests/tcg/s390x/gdbstub/test-svc.py b/tests/tcg/s390x/gdbstub/test-svc.py
index 804705fede..17210b4e02 100644
--- a/tests/tcg/s390x/gdbstub/test-svc.py
+++ b/tests/tcg/s390x/gdbstub/test-svc.py
@@ -3,20 +3,7 @@
 This runs as a sourced script (via -x, via run-test.py)."""
 from __future__ import print_function
 import gdb
-import sys
-
-
-n_failures = 0
-
-
-def report(cond, msg):
-    """Report success/fail of a test"""
-    if cond:
-        print("PASS: {}".format(msg))
-    else:
-        print("FAIL: {}".format(msg))
-        global n_failures
-        n_failures += 1
+from test_gdbstub import main, report
 
 
 def run_test():
@@ -35,26 +22,4 @@ def run_test():
     gdb.execute("si")
 
 
-def main():
-    """Prepare the environment and run through the tests"""
-    try:
-        inferior = gdb.selected_inferior()
-        print("ATTACHED: {}".format(inferior.architecture().name()))
-    except (gdb.error, AttributeError):
-        print("SKIPPING (not connected)")
-        exit(0)
-
-    if gdb.parse_and_eval('$pc') == 0:
-        print("SKIP: PC not set")
-        exit(0)
-
-    try:
-        # Run the actual tests
-        run_test()
-    except gdb.error:
-        report(False, "GDB Exception: {}".format(sys.exc_info()[0]))
-    print("All tests complete: %d failures" % n_failures)
-    exit(n_failures)
-
-
-main()
+main(run_test)
-- 
2.34.1


