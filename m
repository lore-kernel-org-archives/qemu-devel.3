Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 453DCC5472E
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Aug 2024 14:53:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1siEc0-0002rV-NY; Sun, 25 Aug 2024 10:53:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1siEby-0002j8-He
 for qemu-devel@nongnu.org; Sun, 25 Aug 2024 10:52:58 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1siEbw-0005vb-Su
 for qemu-devel@nongnu.org; Sun, 25 Aug 2024 10:52:58 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-7141feed424so2908058b3a.2
 for <qemu-devel@nongnu.org>; Sun, 25 Aug 2024 07:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724597575; x=1725202375; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NQhqFC3YWlPkCJwXValvIiJxyZnEMyHcDzM+YKLmAFI=;
 b=qOAVfv0GtWTKRl/q0MSkhCdxJSuAGef44rQOrCYoTj7mRyPUp7JU9G5KX6msxVsACx
 r1pJdSCjoViSkv+xoHvi3bfZqTn5F/rFyhsFUxhB4fDqbTISQB2X4hxPc3czbPo9rrPq
 sNDCBh6F+jo2CB8BVG6smYCdQ4k8/ZZ4L5PdAu3JtO0t3HmCW5AXYpH67Aj0NCrTHCiv
 Tet1hT4xWSGwM5zn72QgSfGC3Tw8T3vCucoKZPnJyICQzzWZMIQxHRr67kwcZKOijDCv
 eIHdraalqvfGBQVgm0+ahtmBOTTQfpZJ2TXRWYsjy6EwfGT/h7XdrlBmkuRaIjAdRC0Q
 l/Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724597575; x=1725202375;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NQhqFC3YWlPkCJwXValvIiJxyZnEMyHcDzM+YKLmAFI=;
 b=UQ89UvVVAfpE1j/7fce+sMqNAEECKbQRDMyODb7OiMYMkhuehJKvvl20so5gsRiwXw
 6bH7gcYaSNjfgrQjeqXkjcRmn75A4X5BOP2tCWl23TfC2bA+vhzvC33rCascBcMB1C06
 diADCejmJ2O53RLLAJgFoqpWJpsT3owlLW+FyUf/sTa6YtbwzU/CpaERXuzAM68ydPr0
 Dxkt0XcUmdfkEsf8g0BXvYvndSlBYC3AnRXzCmzNZj01+zswTwz67s+FqPBqb3fGnr/O
 k0Wzc73svdWguWmo6A4U9FKaF6PKWIrvJ3LW3Pen0tSeaY2F0qyxMH0YII5R9PL9DtXg
 Z/yg==
X-Gm-Message-State: AOJu0Yzw2Ys2V1Ez1XTg/mN1MvzG4P5JuyOVX3Y3bmO4MqT4/FF+VnQ/
 jJC7e+PoWnEZABt7UyZruYjFnUyckyYjE4vsik5xsCCNTumEbmyGivCq63tHilGJQx6TdTCkjIr
 2WkU=
X-Google-Smtp-Source: AGHT+IECMTUaaknWOmEEWOrt7TYoeRCwK11Q6dW1fcb1jIZj7TrdlwLNSOpj3fm48ummFgtRNQ3+SA==
X-Received: by 2002:a05:6a21:3a46:b0:1c6:b0cc:c50f with SMTP id
 adf61e73a8af0-1cc8b49ba5dmr7208201637.25.1724597574608; 
 Sun, 25 Aug 2024 07:52:54 -0700 (PDT)
Received: from amd.. ([2804:7f0:b400:bb79:3e7c:3fff:fe7a:e83b])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-203b0e164b8sm24698805ad.236.2024.08.25.07.52.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Aug 2024 07:52:54 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, alex.bennee@linaro.org, richard.henderson@linaro.org
Cc: philmd@linaro.org,
	peter.maydell@linaro.org,
	gustavo.romero@linaro.org
Subject: [PATCH v3 3/4] tests/guest-debug: Support passing arguments to the
 GDB test script
Date: Sun, 25 Aug 2024 14:52:07 +0000
Message-Id: <20240825145208.46774-4-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240825145208.46774-1-gustavo.romero@linaro.org>
References: <20240825145208.46774-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pf1-x42b.google.com
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

This commit adds support for passing arguments to the GDB test scripts
so it's possible to parse the args in an "argparse way" in the test
scripts launched by the runner. The arguments should be preceded by --
when passed to the runner. For example, passing "--help" arg to the
GDB_TEST_SCRIPT:

run-test.py [...] --test <GDB_TEST_SCRIPT> -- --help

The test script should not use the argparse module directly but import
arg_parser from test_gdbstub module. arg_parser then can be used just
like the argparse.ArgumentParser class:

from test_gdbstub import arg_parser

p = arg_parser(prog="test-mytest.py", description="My test.")
p.add_argument("--vowel", help="Select vowel",
               required=True, choices=['a','e','i','o','u'])
[...]

The arg_parser allows a smooth and informative exit if, for instance,
the caller of the runner script passes an invalid argument or misses a
required argument by the test script.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 tests/guest-debug/run-test.py     | 6 ++++++
 tests/guest-debug/test_gdbstub.py | 5 +++++
 2 files changed, 11 insertions(+)

diff --git a/tests/guest-debug/run-test.py b/tests/guest-debug/run-test.py
index 368ff8a890..5a091db8be 100755
--- a/tests/guest-debug/run-test.py
+++ b/tests/guest-debug/run-test.py
@@ -27,6 +27,10 @@ def get_args():
     parser.add_argument("--binary", help="Binary to debug",
                         required=True)
     parser.add_argument("--test", help="GDB test script")
+    parser.add_argument('test_args', nargs='*',
+                        help="Additional args for GDB test script. "
+                        "The args should be preceded by -- to avoid confusion "
+                        "with flags for runner script")
     parser.add_argument("--gdb", help="The gdb binary to use",
                         default=None)
     parser.add_argument("--gdb-args", help="Additional gdb arguments")
@@ -91,6 +95,8 @@ def log(output, msg):
     gdb_cmd += " -ex 'target remote %s'" % (socket_name)
     # finally the test script itself
     if args.test:
+        if args.test_args:
+            gdb_cmd += f" -ex \"py sys.argv={args.test_args}\""
         gdb_cmd += " -x %s" % (args.test)
 
 
diff --git a/tests/guest-debug/test_gdbstub.py b/tests/guest-debug/test_gdbstub.py
index 46fbf98f0c..a715c0e3f5 100644
--- a/tests/guest-debug/test_gdbstub.py
+++ b/tests/guest-debug/test_gdbstub.py
@@ -2,6 +2,7 @@
 
 """
 from __future__ import print_function
+import argparse
 import gdb
 import os
 import sys
@@ -9,6 +10,10 @@
 
 fail_count = 0
 
+class arg_parser(argparse.ArgumentParser):
+    def exit(self, status=None, message=""):
+        print("Wrong GDB script test argument! " + message)
+        gdb.execute("exit 1")
 
 def report(cond, msg):
     """Report success/fail of a test"""
-- 
2.34.1


