Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96491C48BC3
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Feb 2024 13:21:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbKcf-0000ri-7j; Sat, 17 Feb 2024 08:20:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rbKcN-0000nd-PG
 for qemu-devel@nongnu.org; Sat, 17 Feb 2024 08:20:37 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rbKcL-00073X-FL
 for qemu-devel@nongnu.org; Sat, 17 Feb 2024 08:20:35 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-55a035669d5so4454731a12.2
 for <qemu-devel@nongnu.org>; Sat, 17 Feb 2024 05:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708176027; x=1708780827; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=D05HukR37qOPDIi6w1Dy+uJqLHhFA5rbTwp8HNkHeWI=;
 b=OHcsa+ucYh0TsCglAasa/vhpz4wnNlPooKq50vwCWAEFOcmERIikzFGUy3IgVDiUAo
 GMqOHc9O3jqJI1QQW7sibD52/WMeHs6RCahLDlGtegJDfWt1rGJ7WnhH9oULKLFAdEd/
 MZ9mwc8mo14UM9/ZGycpKTxE2m+ULTmijfq3KHzZddzXZFKQ3/NYQRSvG4ZytAYeBXei
 jGW7Jo5wm0iNZgv5gCPCt8cDwiOtK5Nyw1WJcj7TQhChbZufOkVKlqgF0I2gaIL9S7ES
 VKG01TTt9b6TrqK4+TBazoz2Dv6OmHHlZl6tZPPARshLBbterBKfLZtxYLFnEK2Mz4fc
 8Sdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708176027; x=1708780827;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=D05HukR37qOPDIi6w1Dy+uJqLHhFA5rbTwp8HNkHeWI=;
 b=Pc1B8MyH8cqqzHvzS7wkt0jbiky/Tg8E0U9tM+NgX2VxnGLVgLO82H4LA2wbx57bqI
 LkHlsbPFJNXzTuAgM+m7UUbdVOHJ5TVHADvFZskm5yd6mBqQEJmpuUJL8e1nbHED8/dh
 bm4f3p6IKhY191513NODu704k8pbPq195miOT8HWkGkG8Vh2ZOG/2R1U3GaszCfZDjZB
 at84IRcg8vzKOgjty04Zbc8wp2hHZZE3sY2+7pdYRyROb5mO9x1ZE6A4Lfizdr5YrH8Q
 9XdPq27fY+SXfZLZThcS+flWtIMDTjEUTWVfi+Hypa1QgjESw2zFls5VSuqQjWXn1cbf
 j5Gg==
X-Gm-Message-State: AOJu0YwkRr9xv8bZJHcGyv90Xzgxa+g0srEQyTWu1ckts41BugX4w/0O
 evzscbEgNoJHxdZckGYZNtoVhXeBydctskL1JLVU/yypSMlnr7Z7nYUtD8xm/UHjudDRCMQWHyd
 3aHs=
X-Google-Smtp-Source: AGHT+IHNkq4U8FHJATEindM4S2LPPJgDFGr5X8yUjeobo3ekko6aNcwzuUGqCg9ajVcSbMoT2aqv/Q==
X-Received: by 2002:a17:906:1858:b0:a3e:127b:690e with SMTP id
 w24-20020a170906185800b00a3e127b690emr1106874eje.70.1708176026795; 
 Sat, 17 Feb 2024 05:20:26 -0800 (PST)
Received: from localhost.localdomain (adsl-245.37.6.163.tellas.gr.
 [37.6.163.245]) by smtp.gmail.com with ESMTPSA id
 hs32-20020a1709073ea000b00a3e4802b4f1sm126776ejc.217.2024.02.17.05.20.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Feb 2024 05:20:26 -0800 (PST)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>
Subject: [PATCH] Print tool binary names in ./configure --help
Date: Sat, 17 Feb 2024 15:19:34 +0200
Message-Id: <20240217131934.2638382-1-manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x52b.google.com
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

configure --help currently outputs the following line for the tools
option:

-->8-------------------------------------------------------------------
░░tcg░░░░░░░░░░░░░TCG░support░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
  tools           build support utilities that come with QEMU
░░tpm░░░░░░░░░░░░░TPM░support░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
░░u2f░░░░░░░░░░░░░U2F░emulation░support░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
---8<------------------------------------------------------------------

Which does not convey information if you don't already know what these
utilities are going to be.

This commit uses script/meson-buildoptions.py to parse the hard-coded
test binary names in meson.build and update the --help output to include
their names, like as follows:

-->8-------------------------------------------------------------------
░░tcg░░░░░░░░░░░░░TCG░support░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
  tools           build utility tool binaries like qemu-edid, qemu-img,
                  qemu-io, qemu-nbd, qemu-bridge-helper, qemu-pr-helper
░░tpm░░░░░░░░░░░░░TPM░support░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
░░u2f░░░░░░░░░░░░░U2F░emulation░support░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
---8<------------------------------------------------------------------

Since it uses the meson.build AST to find those values, only hard-coded
binary names are selected and the description is non-exhaustive.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 Makefile                      |  8 +++++--
 meson_options.txt             |  2 +-
 scripts/meson-buildoptions.py | 43 ++++++++++++++++++++++++++++++++---
 scripts/meson-buildoptions.sh |  3 ++-
 4 files changed, 49 insertions(+), 7 deletions(-)

diff --git a/Makefile b/Makefile
index 8f36990335..79ab594c4b 100644
--- a/Makefile
+++ b/Makefile
@@ -128,8 +128,12 @@ Makefile.mtest: build.ninja scripts/mtest2make.py
 .PHONY: update-buildoptions
 all update-buildoptions: $(SRC_PATH)/scripts/meson-buildoptions.sh
 $(SRC_PATH)/scripts/meson-buildoptions.sh: $(SRC_PATH)/meson_options.txt
-	$(MESON) introspect --buildoptions $(SRC_PATH)/meson.build | $(PYTHON) \
-	  scripts/meson-buildoptions.py > $@.tmp && mv $@.tmp $@
+	{ printf '{"buildoptions":'; \
+		$(MESON) introspect --buildoptions $(SRC_PATH)/meson.build 2> >(grep -v "Unable to evaluate subdir(\[\])" >&2) \
+		&& printf ',"ast":' \
+		&& $(MESON) introspect --ast $(SRC_PATH)/meson.build 2> >(grep -v "Unable to evaluate subdir(\[\])" >&2) \
+		&& printf "}" ; } \
+		| $(PYTHON) scripts/meson-buildoptions.py > $@.tmp && mv $@.tmp $@
 endif
 
 # 4. Rules to bridge to other makefiles
diff --git a/meson_options.txt b/meson_options.txt
index 0a99a059ec..53a8b6b3e2 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -58,7 +58,7 @@ option('guest_agent', type : 'feature', value : 'auto',
 option('guest_agent_msi', type : 'feature', value : 'auto',
        description: 'Build MSI package for the QEMU Guest Agent')
 option('tools', type : 'feature', value : 'auto',
-       description: 'build support utilities that come with QEMU')
+       description: 'build utility tool binaries')
 option('qga_vss', type : 'feature', value: 'auto',
        description: 'build QGA VSS support (broken with MinGW)')
 
diff --git a/scripts/meson-buildoptions.py b/scripts/meson-buildoptions.py
index 4814a8ff61..4abdfc1d05 100644
--- a/scripts/meson-buildoptions.py
+++ b/scripts/meson-buildoptions.py
@@ -24,6 +24,7 @@
 import textwrap
 import shlex
 import sys
+from collections import deque
 
 # Options with nonstandard names (e.g. --with/--without) or OS-dependent
 # defaults.  Try not to add any.
@@ -182,7 +183,7 @@ def cli_metavar(opt):
     return "CHOICE"
 
 
-def print_help(options):
+def print_help(options, tools: list[str]):
     print("meson_options_help() {")
     feature_opts = []
     for opt in sorted(options, key=cli_help_key):
@@ -212,6 +213,8 @@ def print_help(options):
     sh_print()
     for opt in sorted(feature_opts, key=cli_option):
         key = cli_option(opt)
+        if key == "tools":
+            opt["description"] += " like " + ", ".join(tools)
         help_line(key, opt, 18, False)
     print("}")
 
@@ -242,7 +245,41 @@ def print_parse(options):
     print("}")
 
 
-options = load_options(json.load(sys.stdin))
+# Returns hard-coded executables from meson.build AST
+def tool_executables(d: dict) -> list[str]:
+    def is_executable_fn_call(i: dict) -> bool:
+        if not (
+            "name" in i
+            and i["name"] == "executable"
+            and "node" in i
+            and i["node"] == "FunctionNode"
+            and "positional" in i["args"]
+            and len(i["args"]) > 0
+        ):
+            return False
+        first_arg = i["args"]["positional"][0]
+        return first_arg["node"] == "StringNode"
+
+    stack = deque([d])
+    while len(stack) > 0:
+        item = stack.popleft()
+        if isinstance(item, dict):
+            # Check if this is an `executable(....)` function call.
+            if is_executable_fn_call(item):
+                name = item["args"]["positional"][0]["value"]
+                if name not in ("qemu-keymap",):
+                    yield name
+            else:
+                stack.extend(item.values())
+            continue
+        if isinstance(item, list):
+            stack.extend(item)
+            continue
+
+
+input_string = json.load(sys.stdin)
+options = load_options(input_string["buildoptions"])
+bins = list(tool_executables(input_string["ast"]))
 print("# This file is generated by meson-buildoptions.py, do not edit!")
-print_help(options)
+print_help(options, bins)
 print_parse(options)
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index 680fa3f581..ac1fad55df 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -185,7 +185,8 @@ meson_options_help() {
   printf "%s\n" '  spice-protocol  Spice protocol support'
   printf "%s\n" '  stack-protector compiler-provided stack protection'
   printf "%s\n" '  tcg             TCG support'
-  printf "%s\n" '  tools           build support utilities that come with QEMU'
+  printf "%s\n" '  tools           build utility tool binaries like qemu-edid, qemu-img,'
+  printf "%s\n" '                  qemu-io, qemu-nbd, qemu-bridge-helper, qemu-pr-helper'
   printf "%s\n" '  tpm             TPM support'
   printf "%s\n" '  u2f             U2F emulation support'
   printf "%s\n" '  usb-redir       libusbredir support'

base-commit: da96ad4a6a2ef26c83b15fa95e7fceef5147269c
-- 
γαῖα πυρί μιχθήτω


