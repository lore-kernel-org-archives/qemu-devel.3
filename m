Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 764F0C87FCD
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 09:42:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufEwB-0008JN-S9; Fri, 25 Jul 2025 05:41:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ufEvu-0007vz-RF
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 05:41:46 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ufEvs-0006NG-LF
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 05:41:42 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-ae3be3eabd8so426152466b.1
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 02:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753436498; x=1754041298; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=R12CwYsYaoDPuMu9oLrbneP+jbQddhEatX0ucdtMTlI=;
 b=Hm9JClivvimN+oQxEV5q8lQZwWAtraNFuoBvdFFxPdNw14/80kK0s53hFNaIrooTBV
 2GIccWvW4wmvPGlviyTmyAoK3Wxgr3FkDxZ/WoS3PzPuShoHIRA/N7rfb3+2uvMos6yI
 wVjN9KIlV1vPLnBLvBYkEyeKx6fiIBXH6G8Q5Vw3bzR9mMu1ledUODUswGqit69NSkQo
 jOIXUL0viAdz7Yi61ViEyjNpY2fRAbJg6dd7J26vbHIV0IO6rJY5NtUHx+0g0kUADCdf
 wrHXcSb4GXGGBsznwjr4Ah2cbkgnc+t/YURmvMR8fJYENDBAg6Qm/1oxVOAEIuE9vpvO
 RBJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753436499; x=1754041299;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R12CwYsYaoDPuMu9oLrbneP+jbQddhEatX0ucdtMTlI=;
 b=jXBWrsjId+O5ZwT07qPq1VWsVcCgxxrX6/OAfcAzo6leIIhg1/WdqHIAXEXognON2k
 WUy9h7mZ8ZLZwyvDNZ7Syn/F69ejrUMwHXhlWbHhJ6S9xruVqMNZCrRxhUF8pd1+0zNn
 LwkmxHAQ1zDBATfWlY0bVDYieI7dQYER9vbLCUZ0yHmEGna/iuY13/i1jFhoOBRcN8w1
 0eIU/bz+Lr7xqo4zx3G28qi2Y7Th+nmnaE8rRhfM2pY2Br07SaenyrLfqjjHtwZn78my
 kyRrY+NQ880dDcG0iSDo8UgSB4UAtchbrNq6/WHitZj7KtoI+i0ihYzq6pGE9G3aJDSr
 9TIw==
X-Gm-Message-State: AOJu0Yx0oEURw3UJMvwvSg2ly3ZeVOcRdyqtWMcz3n5YSbzI+TuTQ5Hk
 +4Nqpbx3Nr5mhLgX52Fpr/hyn8ovZBl08WPMLyUnDki/y31TwluExugcBlpOCoPan5nSu2kTlCJ
 LL6GN
X-Gm-Gg: ASbGncul51JPgxzTUTI3AKIT4VE4tJGrw18Cfh6/8ssFQVlX5/fIWEn4hT0MTBiAZAP
 FntmH30wn1DDcOupfLL2LpYF8KJZLtNy8NnUTlJAxG1sVcM/Lc6FSq1yWO67ShEohaYpWVHobre
 zkS6Ybfo5jDtmle7nmCjywCZzKb0UjU8Xog0uBarMTkPBnrXNhwQWQNNLbaGL2kHqWVS+ZAPASl
 RHOzLlrwTqKUQMdtj0Ib8SOvGGxzgEgIYRlBSYLvpBz0NcK/XDuuKaa/x1QBlMIlSkVJHRx8bZu
 k1v52s7nPoN+kbHaCGqNk719i9hsgm0qLaDQtmVfuoXCfMQ8tKf2XMFaXZYYRjZG8SR97KpDB+q
 8iAVFPkDjL+3oQ7q80s3s5ysU8ZouKxHjDd63TJh07DfVcSrmdNnlQFY1kVOZNXSB3hk=
X-Google-Smtp-Source: AGHT+IE6Ifwlhv4VwQxV7JJf5/osdrZRDRfQIWyFI8zpUrGoJXlMSUR4/qoOaSDtBEzmZhclQvDm+Q==
X-Received: by 2002:a17:907:1c17:b0:ae3:d0fe:a35e with SMTP id
 a640c23a62f3a-af61c8ae363mr163237366b.11.1753436498435; 
 Fri, 25 Jul 2025 02:41:38 -0700 (PDT)
Received: from [127.0.1.1] (ppp-2-86-210-241.home.otenet.gr. [2.86.210.241])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-af47ff42fc5sm243280266b.143.2025.07.25.02.41.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Jul 2025 02:41:37 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Fri, 25 Jul 2025 12:41:22 +0300
Subject: [PATCH v3 1/4] tests/functional: add --debug CLI arg
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250725-functional_tests_debug_arg-v3-1-b89921baf810@linaro.org>
References: <20250725-functional_tests_debug_arg-v3-0-b89921baf810@linaro.org>
In-Reply-To: <20250725-functional_tests_debug_arg-v3-0-b89921baf810@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Gustavo Romero <gustavo.romero@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6552;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=wzGRiYiFLh7FI47HaxpmpAOmaNwmxjp+OV9Rwk9bGuA=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQm9nMUZQL3FDUUxCTXRIZnlPZWlaUitCbllwQnVOCk9XVTlicHpLS01DMnNWbndW
 citKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKYUlOUlR3QUt
 DUkIzS2Nkd2YzNEowTDJZRUFDYVdZMXEyc1FKSlh4bzFvdTAva2d3VHRWUVhhMnAxTnQxbEJ2bw
 pndnFnRWM4UnpoSG01UDBrUHJKRG1wdk40eHhHS2pwOFIyamVEbVg1MWhmNHRlWjRYb2FWb3Rpa
 nlOMkRQaUoyClpkamwvSjN6R0dZQStxVTVBbzRlek1meVFVbDZGa2V6S2JuUE5JNm5zMmVsV2ZB
 d0VnenBDY09DTStnSEJOZXkKanQzbzVMcnl6UkZJWG14VWl0TXZMNmljQ1JxMVJ5elFtL08wLzl
 VZXlVS2c1NVVOOXlMOUVXT0hUVVNRQ09OKwpRaEVxbEV5L2xmQWhpbXRhVmI3SUdzWkcyRXZhVF
 dhcmZkcm5YbVpUdXJlcFJ5Zy85QjJvcDVkT2VGdENXalAyCjRseHBrUTdLRVZjNHZkOEhEb1hre
 Gw3M05KQTd2VWgrMzZyU3pnQ09tQ0cwck5Wdk9MdVhON0lJdWRKS0QrWGYKNHZ2bkd2MXF0dVlT
 dXBYUy9KdVI5QUhueW9jVGYvSWdzSCtjV2FhZjVyNTNwS1NoaWgxcGdpNVRqKzI1Ty9pcgptWDZ
 pV3hwVGM1U3RNMnlDamQzdnpBWEJRRHk0dDJYOVpQcVVxUnlpSnppZ0JyYlJDWXlVdjVlYUJsVG
 dqSnBLCjVITkpIMUNDUEYycWMxTkFCZVFyRnpDTmVmQytvTFpEUjZ4bXQ5bFhnaEhEcWY5ek5BM
 HF0c2ZzOUNLZU1INHAKVlRpODBzM2RMbmo1dkR4UW5PWFVBTzhqemMyeEUxZmx1Z0dsQVV1VU5O
 ZlZyR0hsaWdDbFJaRDBRQ3d6MnZhZQovemgveEVMU2ttRURqTDFGOHljQ2NNeklPM1BOMjY2Nzl
 FcTZBMDE1ZGh0K3g2QzdHb0RLRFd0ODdwRFN0eU9uCmNHQ0ZEUT09Cj1QejE0Ci0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x62e.google.com
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
 docs/devel/testing/functional.rst      |  2 ++
 tests/functional/qemu_test/testcase.py | 54 +++++++++++++++++++++++++++++++---
 2 files changed, 52 insertions(+), 4 deletions(-)

diff --git a/docs/devel/testing/functional.rst b/docs/devel/testing/functional.rst
index 3728bab6c0c4b0cbacd00744bdb5c1462c71d7a8..2725633e09104db3912ec6167bbda652f40aa969 100644
--- a/docs/devel/testing/functional.rst
+++ b/docs/devel/testing/functional.rst
@@ -63,6 +63,8 @@ directory should be your build folder. For example::
   $ export QEMU_TEST_QEMU_BINARY=$PWD/qemu-system-x86_64
   $ pyvenv/bin/python3 ../tests/functional/test_file.py
 
+By default, functional tests redirect informational logs and console output to
+log files. Specify the ``--debug`` flag to also print those to standard output.
 The test framework will automatically purge any scratch files created during
 the tests. If needing to debug a failed test, it is possible to keep these
 files around on disk by setting ``QEMU_TEST_KEEP_SCRATCH=1`` as an env
diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qemu_test/testcase.py
index 2a78e735f1604f21efd18e38ee0d586496d6b38c..eedca7f1ad29c9e654cf56535acf9639d679f5c4 100644
--- a/tests/functional/qemu_test/testcase.py
+++ b/tests/functional/qemu_test/testcase.py
@@ -11,6 +11,7 @@
 # This work is licensed under the terms of the GNU GPL, version 2 or
 # later.  See the COPYING file in the top-level directory.
 
+import argparse
 import logging
 import os
 from pathlib import Path
@@ -33,6 +34,28 @@
 
 
 class QemuBaseTest(unittest.TestCase):
+    debug: bool = False
+
+    """
+    Class method that initializes class attributes from given command-line
+    arguments.
+    """
+    @staticmethod
+    def parse_args():
+        test_name = os.path.basename(sys.argv[0])[:-3]
+        parser = argparse.ArgumentParser(
+            prog=test_name, description="QEMU Functional test"
+        )
+        parser.add_argument(
+            "-d",
+            "--debug",
+            action="store_true",
+            help="Also print test and console logs on stdout. This will make "
+            "the TAP output invalid and is meant for debugging only.",
+        )
+        args = parser.parse_args()
+        QemuBaseTest.debug = args.debug
+        return
 
     '''
     @params compressed: filename, Asset, or file-like object to uncompress
@@ -197,6 +220,14 @@ def assets_available(self):
         return True
 
     def setUp(self):
+        self.stdout_handler = None
+        if QemuBaseTest.debug:
+            self.stdout_handler = logging.StreamHandler(sys.stdout)
+            self.stdout_handler.setLevel(logging.DEBUG)
+            formatter = logging.Formatter(
+                "%(asctime)s - %(name)s - %(levelname)s - %(message)s"
+            )
+            self.stdout_handler.setFormatter(formatter)
         self.qemu_bin = os.getenv('QEMU_TEST_QEMU_BINARY')
         self.assertIsNotNone(self.qemu_bin, 'QEMU_TEST_QEMU_BINARY must be set')
         self.arch = self.qemu_bin.split('-')[-1]
@@ -216,12 +247,17 @@ def setUp(self):
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
 
@@ -231,15 +267,19 @@ def tearDown(self):
         if self.socketdir is not None:
             shutil.rmtree(self.socketdir.name)
             self.socketdir = None
-        self.machinelog.removeHandler(self._log_fh)
-        self.log.removeHandler(self._log_fh)
-        self._log_fh.close()
+        for handler in [self._log_fh, self.stdout_handler]:
+            if handler is None:
+                continue
+            self.machinelog.removeHandler(handler)
+            self.log.removeHandler(handler)
+            handler.close()
 
     def main():
         warnings.simplefilter("default")
         os.environ["PYTHONWARNINGS"] = "default"
 
         path = os.path.basename(sys.argv[0])[:-3]
+        QemuBaseTest.parse_args()
 
         cache = os.environ.get("QEMU_TEST_PRECACHE", None)
         if cache is not None:
@@ -297,6 +337,8 @@ def setUp(self):
         fileFormatter = logging.Formatter('%(asctime)s: %(message)s')
         self._console_log_fh.setFormatter(fileFormatter)
         console_log.addHandler(self._console_log_fh)
+        if self.stdout_handler:
+            console_log.addHandler(self.stdout_handler)
 
     def set_machine(self, machinename):
         # TODO: We should use QMP to get the list of available machines
@@ -403,6 +445,10 @@ def set_vm_arg(self, arg, value):
     def tearDown(self):
         for vm in self._vms.values():
             vm.shutdown()
-        logging.getLogger('console').removeHandler(self._console_log_fh)
+        console_log = logging.getLogger("console")
+        console_log.removeHandler(self._console_log_fh)
         self._console_log_fh.close()
+        if self.stdout_handler:
+            console_log.removeHandler(self.stdout_handler)
+            self.stdout_handler.close()
         super().tearDown()

-- 
2.47.2


