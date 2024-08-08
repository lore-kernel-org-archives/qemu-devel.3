Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C414C52D73
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 05:16:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbvVM-0007Kc-Tr; Thu, 08 Aug 2024 01:16:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sbvVJ-0007Bw-Tm
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 01:16:01 -0400
Received: from mail-oa1-x34.google.com ([2001:4860:4864:20::34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sbvVI-0002kn-6N
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 01:16:01 -0400
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-26b5173e861so21012fac.3
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2024 22:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723094158; x=1723698958; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NQhqFC3YWlPkCJwXValvIiJxyZnEMyHcDzM+YKLmAFI=;
 b=eCx0V04rkwT9b16jvVjxvaW5FBDRwO5mvPW6ktXKLjBJk7GX9XePD8ZX2d9FOkwFk+
 hvXP0LpmhxN6LNPBP1dJplc7N5kxC2QcQYmjKyOWBFni2DQ4smOCBL7f1xPwp2lfZkF9
 AF26Q7SCuLLy/vhKCX+PoTZ3vj77K93IA5ZxQi7kDGjM/fP+14qfWCK4Y10WrY+ZtgSi
 VqhwxfKX6jWu1zcbvIpwZcrYYjmKKZfErIq3qaXPbRiQxThoLtORij6tbbALKeRNyVn8
 0vcV52VUPrqXA39zVWlOz47qztCNochJ9VBAIex4mLNr8KCq6IQxNZ20WDhH6VvioMyl
 oWBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723094158; x=1723698958;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NQhqFC3YWlPkCJwXValvIiJxyZnEMyHcDzM+YKLmAFI=;
 b=LWunTizAnY1MtqSnS0JAPgEozKahJjuUhLR3WGFwY3JTTW/RJ4NIKx2nY06zg0ea+z
 6cNfZmcXtuBZTlfLNvIx6gwFpR5XJrbpzqq5+fO5wf6+LsXCpz6ynQWJ+tUCJgZNMtUf
 YkVgqGb6n60pq1oDYBjHLvxML+uQqfDXB2S0RX8mr7UeTK3LtQWBJ0wmM33R299zoj95
 sB1eBFtvFdBHRD0BYPQ8o4Gh2pLYPLgWDQcADk9u84tr2LaG48Ybyt5eMZRTBmxduUf9
 heP5dlaSJE0O+Qf5B2RyEj+hpmiwjlLICgJeBhyDPUFrvgUgOVGxcJaKpgFIXQ91givU
 ferA==
X-Gm-Message-State: AOJu0Yy5gdy9IOjlyqdoAmy1Li7AZHzWFTozgy3/rDfmljouOnckhVDK
 uryY6NY8V++WnmfzQcJXP7Mg+C3qw3fcSsakgPnXsKGKzA5xCH3pEvysqcGRCuniFdeEV2t0y+N
 9
X-Google-Smtp-Source: AGHT+IH37t+ai+5t+ChvS0BEBD6UwMqMOotQ98bDayuwXLz2aQcTK549Fq3Do6piNMd67JjC2bxiqA==
X-Received: by 2002:a05:6870:4191:b0:260:fd20:a885 with SMTP id
 586e51a60fabf-2692b6aa2ccmr961277fac.27.1723094158266; 
 Wed, 07 Aug 2024 22:15:58 -0700 (PDT)
Received: from amd.. ([2804:7f0:b403:720f:3e7c:3fff:fe7a:e83b])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-710cb22a455sm373484b3a.71.2024.08.07.22.15.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 22:15:57 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, alex.bennee@linaro.org, richard.henderson@linaro.org
Cc: philmd@linaro.org,
	peter.maydell@linaro.org,
	gustavo.romero@linaro.org
Subject: [PATCH v2 3/4] tests/guest-debug: Support passing arguments to the
 GDB test script
Date: Thu,  8 Aug 2024 05:15:30 +0000
Message-Id: <20240808051531.3183498-4-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240808051531.3183498-1-gustavo.romero@linaro.org>
References: <20240808051531.3183498-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::34;
 envelope-from=gustavo.romero@linaro.org; helo=mail-oa1-x34.google.com
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


