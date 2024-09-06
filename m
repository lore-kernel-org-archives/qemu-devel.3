Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BADF0CE7B1C
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 14:34:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sma2A-0000lN-CJ; Fri, 06 Sep 2024 10:33:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sma29-0000gL-1s
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 10:33:57 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sma27-00073x-AD
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 10:33:56 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2054e22ce3fso20497535ad.2
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2024 07:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725633234; x=1726238034; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RG/0hzlp1e1U/X+viI7qOSSU9A8TRQ8gs/a7p+ROYlY=;
 b=zKbSTBFYS/pCAl8ro0L8bjQtugWHI7RQ5zDfKa/Jgog073b2tERZGeLhF6/8fJ+YLD
 Z1xBiaFqMi1CC4NVd02so+jcmISyh1PnSIlYEh/NO7IzO9evYrjjbpThFMBDTGCX20JO
 amXsAnm5kQEBBYFl3wCIp9K/JwfYmAxBSXCrGZ5bEQMw9xqBTvDu5OIsu0qd24ATqZwN
 mxvTMPcjHLNwU1GQfp8/bIBkq+hyFwM4hweOHNGa36sOlshXCeV80c7JxwH1pAU40Txr
 a6AM9PTIwfMJtOCs1UN8Snf88WYDByFRRQOXBcTIY7DFoYvzQaXDrjZ55Hz0IUvqZlra
 inFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725633234; x=1726238034;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RG/0hzlp1e1U/X+viI7qOSSU9A8TRQ8gs/a7p+ROYlY=;
 b=lawwpSdLBslQXFRz77BjcBnURmQbujwsGPJvNdnTpdade3O5th6lpoYOqMUyW55B+S
 N9i58c1IabhcGuOPy0hwoTOSNqhHZZwUKZe3dL9wb7PwRMt8G8W7yKYPrYqZGLMcIEm3
 rc2hHtIz2dvWB/a4dgwqCTA8fq9WWI509FkugL19YbjBllsdG07LLPoMPJosoEw+ZSOM
 B76Z9w4kVX7t+yONiWsxnZNd8jBRNpSsBFgKl/GA2vCyh/YmbaGklkAH0RPbWfZZXU56
 EhlnojdHN1fMlSpe4UL29LMKU94tWl8JjV5BHhLr0cH9CAfrfTi1/vzQBuNrI6oVLm3G
 y71w==
X-Gm-Message-State: AOJu0Yyp7qEgTGaf88DUZBqlih/nOkV4Kq75O+QvZ+bC1q6Tt6e+cECU
 p93aH6EymBS/NMLVm73M7Qvn92reEHv7WHRQcz1DK7XBhN99zL5xsWlmEfKE4EJNLMC+36cH2+L
 v
X-Google-Smtp-Source: AGHT+IHH0MvXw/K9jiSgmPiiaHBxsH+DkB8TdJ0iQ1K0ZIa6HweNZfMpBU+lUG4ohqXrNm0rUJ5Eug==
X-Received: by 2002:a17:902:db0a:b0:205:894b:b5b0 with SMTP id
 d9443c01a7336-206f054f46bmr32044795ad.33.1725633233688; 
 Fri, 06 Sep 2024 07:33:53 -0700 (PDT)
Received: from amd.. ([2804:7f0:b401:42a1:3e7c:3fff:fe7a:e83b])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-206ae913cf1sm43844425ad.28.2024.09.06.07.33.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Sep 2024 07:33:53 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, philmd@linaro.org, alex.bennee@linaro.org,
 richard.henderson@linaro.org
Cc: peter.maydell@linaro.org,
	gustavo.romero@linaro.org
Subject: [PATCH v4 3/5] tests/guest-debug: Support passing arguments to the
 GDB test script
Date: Fri,  6 Sep 2024 14:33:14 +0000
Message-Id: <20240906143316.657436-4-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240906143316.657436-1-gustavo.romero@linaro.org>
References: <20240906143316.657436-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x62d.google.com
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
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
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


