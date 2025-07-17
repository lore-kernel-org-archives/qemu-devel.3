Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43F99C83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 10:36:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucLx7-0001ec-7v; Thu, 17 Jul 2025 06:35:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ucLwx-0001az-2r
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 06:34:54 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ucLwt-0000ty-0e
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 06:34:50 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-612b67dcb89so344685a12.1
 for <qemu-devel@nongnu.org>; Thu, 17 Jul 2025 03:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752748485; x=1753353285; darn=nongnu.org;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=yFco6wbG2s9n8e9Zcr8B8cpTuT6McsW35wCCJ4LaBoQ=;
 b=WymhV4dA7ZkJoh8l74Spy5Wa0Le/aJT3sFwBikUmY3AkmAIt1ILqkOedynYpZqDV0q
 M3/8YHJDtvI7L0LqwGOFk7hcDYKiSbmCSHgCxsn2Nt5nAxmmW7FB9VRWGPq0xb/IpEBw
 wirxwqDb8vp0vad0zV8ZeEg75EjAG2NZ0Lxe6suFCNjO2l4P5ZiGqq6gOLbUMYuCO/eH
 nFmf4WqJveM7z8U6QQhDDbhycvt18LtPbi+ZyVL7TDcXgr9ueBYl0uxCvCt5gQ10WDqm
 NR31Djf1cfFE4d/w7vmXlK/EyZG+JERnS23OVyiI8jvuqZf3WbOItkBU9j+gw3QxhqzB
 j4WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752748485; x=1753353285;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yFco6wbG2s9n8e9Zcr8B8cpTuT6McsW35wCCJ4LaBoQ=;
 b=t87BbkFBLDCMXNPjsD1AXF8kqn+7wp82JlKkkXaFeCnLEySwzAOsUXOuq/in5krnqx
 kTtHTWX2FLuNpJSaMlKLx21kDKsgJpaNTqCk8v4STZhlx1MNoX2TZFmQbpe+JOrTXkTY
 5TznCvfE4QY6hekDaO4ehzG9m175/WMPn/qxz87nj39B/lbNDeTLrqXPSoCYHotkY+T3
 4zgaRHarqfIuFr7N9vKfHZXEJhW21RyHQRvuoYW2hu4DUn9FDQaaFOL2h+l5fPMuStny
 H2QvqMkmXfwIKa1kmr9C/DY/9jD4iOFLahTIBcUl4dd3/Rw8XOw4WGGE5jYxwTj3ogBD
 CzjA==
X-Gm-Message-State: AOJu0YyTSgYNlEnlwMJJxzOU5pxx7c0T2VgJK0PGT6Du7aksEbCLk6cY
 6ium7AvzYk8CBKiGOcOjJMRTc7mKGRVH5n1LQZ0G+igTfyS5NFbKY/vxUHqfaaoNGMqVdEWG0v7
 rYcaq
X-Gm-Gg: ASbGncunDyrsRlY08ITjik4FDxhU4jojfyVUZPSLfo+FETB9+STSho0gmm6tIUh9gPC
 ugOQFCZcuPg2IQUPZZUKCD4RldrapCYEiY/qLuAxqV/CSUuEkbAW+b9HeNuf40hhgLwAICO9/0Y
 WsPDm8GM8EU/9H3l+k09RodLFHqcJDmxrkyAe/YwSfw72uWUlGec1gmpRng9hjKdj9y6We/kh0K
 NMTuviDmCjG4W0vcsTC+k+UEhSmzYc6k69QcYw/J/OuxSAdU/7lUkskJRdtihIuVto8iqOwt8Or
 mJVn/ZHSsYWCPRmS7IUtprXZ/lh8Cj9EhiHsd2QDoMu9zSsGnF4FvzQQsgvC4KNjOKUEFXbfMg/
 eR4yHqIlwALSYhRWoQeB0O8c51qXI0lzibbtKddsXIW+xXUjYUeWANJh0OsdApmcjOxc=
X-Google-Smtp-Source: AGHT+IFnMK5rOfIgg302kCDbowNUy/XyEZW6eRsSX+kfbtM1YouzPzz/CsUoMBVV6KFygl75f3XhhQ==
X-Received: by 2002:a17:907:724c:b0:adf:f8f4:2001 with SMTP id
 a640c23a62f3a-ae9ce17e6e4mr619908966b.49.1752748484760; 
 Thu, 17 Jul 2025 03:34:44 -0700 (PDT)
Received: from [127.0.1.1] (ppp-2-86-210-241.home.otenet.gr. [2.86.210.241])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae6e7e910c7sm1359903166b.15.2025.07.17.03.34.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Jul 2025 03:34:44 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Thu, 17 Jul 2025 13:34:13 +0300
Subject: [PATCH v2] tests/functional: add --debug CLI arg
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250717-functional_tests_debug_arg-v2-1-4f0d991e16f7@linaro.org>
X-B4-Tracking: v=1; b=H4sIAKTReGgC/42NQQqDMBBFryKzbopRjNpV71FEJjrGgCQyidIi3
 r2pJ+jyPT7vHxCILQV4ZAcw7TZY7xIUtwyGGZ0hYcfEUORFlddSiWlzQ0wjXPpIIYZ+JL2ZHtk
 IxByrSem2rCtIgZVpsu8r/uoSzzZEz5/ra5c/+1d2l0IKhe0wqqaUjdbPxTpkf/dsoDvP8wuV7
 Y0WxQAAAA==
X-Change-ID: 20250716-functional_tests_debug_arg-aa0a5f6b9375
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Gustavo Romero <gustavo.romero@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6716;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=kuB2kczn0vndbsEeJ/d23J9QMoUfsyaY3u/yfUzFhn8=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQm9lTkhEK2RjOGZzWGhFZ2k2TGtVWUlWOXRPdGJHCmFyVzVrMXdrMmp4MUVQS1V3
 MmlKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKYUhqUnd3QUt
 DUkIzS2Nkd2YzNEowQUEyRUFDTktCRm1zMkFxa29GU0htNzR4bXRlUkRnVWd1Z1ZQR2hJNHovcQ
 pMRWVnM3NTZThLQ1haWDFVZjNVRU85UFJOcGhGZU5KclQ4Z1pSbFo5N25qNjRINmw5Zll3MllJd
 mFsT0JRbldTCnhBcHVSZEtydUx3Vll6cTJQNS93MGIyL3A2MjFRVGQ2MzVsS25TanM0SnVGOXFp
 Q3MxUE9GM1pLTGVWNVpKTlcKdG41cUpPa3JBdFRJdHNrcXVvemlyT3grd05mNUJoRlAwM3hjL2x
 xNDNHVzFyZnhPWlQ3aFZkNmFVZURTbkN1TAp1ZXBTcThQc0JGZExxV3IxK2JRM3dXaXdFZVVQWn
 psM2grYzFTMUpzb0lOMjB3SHRtblFlVnJ5TllYb3MvUEF0CnlpOWgyQkRON3JJL3d2M2lVdmh5a
 HpoMStEMHp1NFBLZk9nMDVwb2xjWlhMQXEzQ1RPNUlxYndscllhTGRTWnYKTzJqV0dtaC9GeWhG
 REIxV0xKbTR1Zi9sVWo2R1RmYU14WkMyMVJyazEwbmZYajdKUSs1dlFTV3p0VHB5b2pmYwplWWQ
 rOTlxQzVzR3MyUG1HVytYVGpTNlhHVGlGZFdsSnc0Z1hIWnZYM1hEMUEzVm4vUTlHOUpqSDNMU2
 QramNiCnF6d3ppU3lQR3F0WnFMdFY5eGtNMnhHcFp6c3cwQUVpaUd4SEoyU2txckdMK0VVZm1sM
 Th2bk9FNzhpMUhkaWUKY0pBOFBYVmZ2VHZRKy9LV2MxSUl6Qk5QdFhlR0tESlUwM2NmUU4raW9P
 aWNTZlVacHBYa2JLYnk4YlNkQnlUdgpFMUt0QnMyTEtwN0RvVjN6NUVLR3doR21Da2V4NnZRaVA
 5cmJMbG0vblBMVzFneFk4YndZUlR2eWJwRzRKNDdICmNKNlJIQT09Cj1FMFpLCi0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x52b.google.com
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

Add argument parsing to functional tests to improve developer experience
when running individual tests. All logs are printed to stdout
interspersed with TAP output.

Example usage, assuming current build directory with qemu source code in
the parent directory (see docs/devel/testing/functional.rst for details):

  $ export PYTHONPATH=../python:../tests/functional
  $ export QEMU_TEST_QEMU_BINARY="$(pwd)/qemu-system-aarch64"
  $ ./pyvenv/bin/python3 ../tests/functional/test_aarch64_virt.py --help
  usage: test_aarch64_virt [-h] [-d]

  QEMU Functional test

  options:
    -h, --help   show this help message and exit
    -d, --debug  Also print test and console logs on stdout. This will
                 make the TAP output invalid and is meant for debugging
                 only.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
Changes in v2:
- Store stdout handler in `self` object (thanks Daniel)
- Deduplicate handler removal code (Daniel)
- Amend commit description to mention PYTHONPATH (thanks Alex)
- Link to v1: https://lore.kernel.org/qemu-devel/20250716-functional_tests_debug_arg-v1-1-6a9cd68318bb@linaro.org
---
 docs/devel/testing/functional.rst      |  2 ++
 tests/functional/qemu_test/testcase.py | 48 +++++++++++++++++++++++++++++++---
 2 files changed, 47 insertions(+), 3 deletions(-)

diff --git a/docs/devel/testing/functional.rst b/docs/devel/testing/functional.rst
index 9e56dd1b1189216b9b4aede00174c15203f38b41..9d08abe2848277d635befb0296f578cfaa4bd66d 100644
--- a/docs/devel/testing/functional.rst
+++ b/docs/devel/testing/functional.rst
@@ -63,6 +63,8 @@ directory should be your build folder. For example::
   $ export QEMU_TEST_QEMU_BINARY=$PWD/qemu-system-x86_64
   $ pyvenv/bin/python3 ../tests/functional/test_file.py
 
+By default, functional tests redirect informational logs and console output to
+log files. Specify the ``--debug`` flag to also print those to standard output.
 The test framework will automatically purge any scratch files created during
 the tests. If needing to debug a failed test, it is possible to keep these
 files around on disk by setting ```QEMU_TEST_KEEP_SCRATCH=1``` as an env
diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qemu_test/testcase.py
index 2082c6fce43b0544d4e4258cd4155f555ed30cd4..3ecaaeffd4df2945fb4c44b4ddef6911527099b9 100644
--- a/tests/functional/qemu_test/testcase.py
+++ b/tests/functional/qemu_test/testcase.py
@@ -11,6 +11,7 @@
 # This work is licensed under the terms of the GNU GPL, version 2 or
 # later.  See the COPYING file in the top-level directory.
 
+import argparse
 import logging
 import os
 from pathlib import Path
@@ -31,6 +32,20 @@
 from .uncompress import uncompress
 
 
+def parse_args(test_name: str) -> argparse.Namespace:
+    parser = argparse.ArgumentParser(
+        prog=test_name, description="QEMU Functional test"
+    )
+    parser.add_argument(
+        "-d",
+        "--debug",
+        action="store_true",
+        help="Also print test and console logs on stdout. This will make the"
+        " TAP output invalid and is meant for debugging only.",
+    )
+    return parser.parse_args()
+
+
 class QemuBaseTest(unittest.TestCase):
 
     '''
@@ -196,6 +211,16 @@ def assets_available(self):
         return True
 
     def setUp(self):
+        path = os.path.basename(sys.argv[0])[:-3]
+        args = parse_args(path)
+        self.stdout_handler = None
+        if args.debug:
+            self.stdout_handler = logging.StreamHandler(sys.stdout)
+            self.stdout_handler.setLevel(logging.DEBUG)
+            formatter = logging.Formatter(
+                "%(asctime)s - %(name)s - %(levelname)s - %(message)s"
+            )
+            self.stdout_handler.setFormatter(formatter)
         self.qemu_bin = os.getenv('QEMU_TEST_QEMU_BINARY')
         self.assertIsNotNone(self.qemu_bin, 'QEMU_TEST_QEMU_BINARY must be set')
         self.arch = self.qemu_bin.split('-')[-1]
@@ -215,12 +240,17 @@ def setUp(self):
             '%(asctime)s - %(levelname)s: %(message)s')
         self._log_fh.setFormatter(fileFormatter)
         self.log.addHandler(self._log_fh)
+        if self.stdout_handler:
+            self.log.addHandler(self.stdout_handler)
 
         # Capture QEMUMachine logging
         self.machinelog = logging.getLogger('qemu.machine')
         self.machinelog.setLevel(logging.DEBUG)
         self.machinelog.addHandler(self._log_fh)
 
+        if self.stdout_handler:
+            self.machinelog.addHandler(self.stdout_handler)
+
         if not self.assets_available():
             self.skipTest('One or more assets is not available')
 
@@ -230,11 +260,18 @@ def tearDown(self):
         if self.socketdir is not None:
             shutil.rmtree(self.socketdir.name)
             self.socketdir = None
-        self.machinelog.removeHandler(self._log_fh)
-        self.log.removeHandler(self._log_fh)
+        for handler in [self._log_fh, self.stdout_handler]:
+            if handler is None:
+                continue
+            self.machinelog.removeHandler(handler)
+            self.log.removeHandler(handler)
 
     def main():
         path = os.path.basename(sys.argv[0])[:-3]
+        # If argparse receives --help or an unknown argument, it will raise a
+        # SystemExit which will get caught by the test runner. Parse the
+        # arguments here too to handle that case.
+        parse_args(path)
 
         cache = os.environ.get("QEMU_TEST_PRECACHE", None)
         if cache is not None:
@@ -292,6 +329,8 @@ def setUp(self):
         fileFormatter = logging.Formatter('%(asctime)s: %(message)s')
         self._console_log_fh.setFormatter(fileFormatter)
         console_log.addHandler(self._console_log_fh)
+        if self.stdout_handler:
+            console_log.addHandler(self.stdout_handler)
 
     def set_machine(self, machinename):
         # TODO: We should use QMP to get the list of available machines
@@ -398,5 +437,8 @@ def set_vm_arg(self, arg, value):
     def tearDown(self):
         for vm in self._vms.values():
             vm.shutdown()
-        logging.getLogger('console').removeHandler(self._console_log_fh)
+        console_log = logging.getLogger("console")
+        console_log.removeHandler(self._console_log_fh)
+        if self.stdout_handler:
+            console_log.removeHandler(self.stdout_handler)
         super().tearDown()

---
base-commit: f96b157ebb93f94cd56ebbc99bc20982b8fd86ef
change-id: 20250716-functional_tests_debug_arg-aa0a5f6b9375

--
γαῖα πυρί μιχθήτω


