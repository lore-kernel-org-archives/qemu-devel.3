Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 881FDCD4840
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 17:06:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMU46-0000tH-J3; Mon, 11 May 2026 13:05:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wMU43-0000r6-Cv
 for qemu-devel@nongnu.org; Mon, 11 May 2026 13:05:07 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wMU40-0007iY-E9
 for qemu-devel@nongnu.org; Mon, 11 May 2026 13:05:07 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-48e8132c6d0so11919015e9.1
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 10:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778519103; x=1779123903; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pY01G0y61H4ZgAg1sGo2nwoYnnGiNl6d8dUdjpbrmt8=;
 b=HaC7npiYVwfV8+8HoMui9vNGqsfW5yYYKne8U3PxJP2Ltz4i5Tb3npndyvwf2984jc
 B1b6W3r+LggVY4mQ6d2gRZCh0+xX5A+zmcRiQszI9mO4k5/8pvYTA5qISAX6iY+l5yFw
 KeNysppWeDusczZVXvNRKaGyeBe9/x8Wf47LdklkA9mr+IXfQ4but/iwAWU7IjoOaDbV
 /hroKFdHMDUymwXl4OPviQUKpUwNNTUzWzlrX6/J8TBVVh5El9dk+EAFlywllCR0D+tz
 iCx724clq4vfZROoG5R9XC/nnTQOsTugIYLJhqk5MSLYsUIx7OhPcNThxi+fxX5v0jaG
 30+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778519103; x=1779123903;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pY01G0y61H4ZgAg1sGo2nwoYnnGiNl6d8dUdjpbrmt8=;
 b=VD3SvRvYu/N9cHR/jXUNePaku/RQyj5/7SVtSAPs5fT5Y6ZmdDknIDM52Xp2hPTuDY
 pcBzjTW7Qvl6GLDDRoRur8icMpp8n/pDas1Sxqx87bNJ62MFkecY+aOIcFqMNthizYxh
 hp44OkMsK0mRkEclWv3OC8tEBMnMTiFQbc6IKN7qdlfOXJ78k74ipy5e2EmnWDf6gy0v
 wKAF4PJTZ6YIxMg8c7+3Nn5szu9iZNtZp5llDSSaaqkQKJ8x5aiBhRQ0wI6D3wGpnomS
 q2M7lJ+Xb3pGRnBqiKBV+gwZ/iVH5mcKWCIe3/vR3SWWiwLt7LPT8UfkBzMkdKluwYVN
 xJDg==
X-Gm-Message-State: AOJu0YyZDaDYjE/xMybT91Qm2Sx5NVRnF26vgjWIzwOQfVyjYZLi3HAp
 8yCmmqaK0Et6cUBqeNZCZKJZxbnU/Kfu5XDnMqnviHi/Nd80N0k1BK0I/qb9aVHpxGI=
X-Gm-Gg: Acq92OH+B6t/uyMbP/sf2VEoQaGfJfwe+d88BycCg0kuAxnhOcLyoYj1itK+JlhKuFy
 9GltF3A3SWZo9vApbHuHg0JMvJlNp0bmfs7VMCb9T4qS0b8nz1eK1o3LpM5MLj2Prou+12yYd0S
 pvIKLResC04jiHjiPfdhYXWUFLiTBtb4SXAO6nbyPkULSO15/6G3rgZpaW1tWiuwvANTvzyRf8l
 fzb7KmmLuBfaJC+p4toXBfAcfNZ3Zhc+7v9LFXabhsrwQqSE+eG0Isg1gEWwzhnP5FrFS9zGKSU
 pzcilxzizCYZ3w0ragoAujLx2m5h7JcOHCKQdb4jfnnI4FSiw3k7CMS9wulrk30wg4p0ChhEJ6n
 LHqQfYSAHfCLv6k+ixiaRjv9M4tcYswlmKZB4mNR+mTYMQFG1lG3El71aDxenk2+Sz1jDfgbKpp
 kwRjOrDHJTWCfPV9/ItmEyJNGZvEaBE4Br1Q==
X-Received: by 2002:a05:600c:1d18:b0:48a:8cb6:88b9 with SMTP id
 5b1f17b1804b1-48e51f44621mr389731005e9.22.1778519102584; 
 Mon, 11 May 2026 10:05:02 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e702e0c70sm217274945e9.6.2026.05.11.10.05.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 10:05:01 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id AB7E85F94E;
 Mon, 11 May 2026 18:05:00 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>
Subject: [RFC PATCH v2 02/10] scripts/expand-macro.py: helper script exploding
 macros
Date: Mon, 11 May 2026 18:04:51 +0100
Message-ID: <20260511170500.124211-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260511170500.124211-1-alex.bennee@linaro.org>
References: <20260511170500.124211-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
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

QEMU makes heavy use of C Macros which can be confusing to humans and
seems almost impossible for AI agents to follow. In the past I've
dealt with this by compiling with V=1 and manually copying and pasting
the gcc command line and appending -E to run the pre-processor step.

With the modern build system we now have a compile_commands.json so we
can automate the process with a script.

There is some trickiness involved in following the line markers so we
know where in the source file we are. To handle this we implement a
PreprocessorState object to track where in the include chain we are.
This allows us to show the including location when we dump the
expanded macro.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 scripts/expand-macro.py | 272 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 272 insertions(+)
 create mode 100755 scripts/expand-macro.py

diff --git a/scripts/expand-macro.py b/scripts/expand-macro.py
new file mode 100755
index 00000000000..581f20b9897
--- /dev/null
+++ b/scripts/expand-macro.py
@@ -0,0 +1,272 @@
+#!/usr/bin/env python3
+#
+# Automate the expansion of QEMU macros based on compile_commands.json.
+#
+# This script runs the C preprocessor over a file to expand macros
+# in a specified line range, using the compilation flags defined in
+# compile_commands.json.
+#
+# Copyright (c) Linaro 2026
+#
+import os
+import sys
+import json
+import shlex
+import subprocess
+import argparse
+import re
+
+
+def find_compile_command(target_file, compile_commands):
+    """
+    Search compile_commands to find the rule to build target_file
+    """
+    target_abs = os.path.abspath(target_file)
+    for entry in compile_commands:
+        dir_path = entry.get('directory', '.')
+        file_abs = os.path.abspath(os.path.join(dir_path, entry['file']))
+        if file_abs == target_abs:
+            return entry
+    return None
+
+
+def process_command(command_entry):
+    """
+    Strip out output related options and return a command line that will
+    run the pre-processor only.
+    """
+    command = command_entry.get('command')
+    if not command:
+        args = command_entry.get('arguments', [])
+    else:
+        args = shlex.split(command)
+
+    if not args:
+        return None
+
+    out = []
+    it = iter(args)
+    for arg in it:
+        # the -M* options all deal with generating deps
+        if arg in ('-o', '-MF', '-MQ', '-MT', '-MD', '-MP'):
+            next(it, None)  # Skip the option's argument
+            continue
+        if arg == '-c':
+            continue
+        out.append(arg)
+
+    # Enable pre-processor output, don't strip comments, trace includes
+    out.extend(['-E', '-CC', '-H'])
+    return out
+
+
+def normalize_path(raw_path, working_dir):
+    """Normalize and make paths absolute."""
+    if not os.path.isabs(raw_path):
+        return os.path.abspath(os.path.join(working_dir, raw_path))
+    return os.path.normpath(raw_path)
+
+
+class PreprocessorState:
+    """Tracks the state of the preprocessor as we parse its output."""
+    def __init__(self):
+        self.stack = []
+        self.current_path = None
+        self.current_line = 0
+        self.current_instance_id = 0
+        self.next_instance_id = 1
+        self.sections = {}
+
+    def update_on_marker(self, new_line, flags, path):
+        """Update the file stack and instance tracking based on markers."""
+        # entering new file
+        if "1" in flags:
+            if self.current_path is not None:
+                self.stack.append((self.current_path, self.current_line,
+                                   self.current_instance_id))
+            self.current_path = path
+            self.current_line = new_line
+            self.current_instance_id = self.next_instance_id
+            self.next_instance_id += 1
+            return
+
+        # leaving file
+        if "2" in flags:
+            if self.stack:
+                _, _, popped_instance_id = self.stack.pop()
+                self.current_path = path
+                self.current_line = new_line
+                self.current_instance_id = popped_instance_id
+            else:
+                self.current_path = path
+                self.current_line = new_line
+                self.current_instance_id = self.next_instance_id
+                self.next_instance_id += 1
+            return
+
+        # return to previous file without explicit flag 2
+        if self.current_path != path:
+            if self.stack and self.stack[-1][0] == path:
+                _, _, popped_instance_id = self.stack.pop()
+                self.current_path = path
+                self.current_line = new_line
+                self.current_instance_id = popped_instance_id
+            else:
+                self.current_path = path
+                self.current_line = new_line
+                self.current_instance_id = self.next_instance_id
+                self.next_instance_id += 1
+            return
+            
+        self.current_line = new_line
+
+    def get_context_string(self, target_abs, working_dir):
+        """Generate a descriptive string showing the inclusion context."""
+        if self.stack:
+            ctx_path, ctx_line, _ = self.stack[-1]
+            try:
+                rel_ctx = os.path.relpath(ctx_path, working_dir)
+            except ValueError:
+                rel_ctx = ctx_path
+            return f"{rel_ctx}:{ctx_line}"
+
+        try:
+            rel_ctx = os.path.relpath(target_abs, working_dir)
+        except ValueError:
+            rel_ctx = target_abs
+        return f"{rel_ctx} (main file)"
+
+    def add_line(self, line, line_range, target_abs, working_dir):
+        """Add a line to the sections if it is within the requested range."""
+        start_line, end_line = line_range
+        if self.current_path == target_abs:
+            if start_line <= self.current_line <= end_line:
+                if self.current_instance_id not in self.sections:
+                    ctx_str = self.get_context_string(target_abs, working_dir)
+                    self.sections[self.current_instance_id] = {
+                        "context": ctx_str,
+                        "lines": []
+                    }
+                self.sections[self.current_instance_id]["lines"].append(line)
+        self.current_line += 1
+
+
+def format_output_sections(sections, target_file, start_line, end_line):
+    """Format the accumulated sections into the final output string."""
+    output_sections = []
+    for _instance_id, data in sections.items():
+        if not data["lines"]:
+            continue
+        header = f"/* Expansion from {data['context']} */"
+        body = "\n".join(data["lines"])
+        output_sections.append(f"{header}\n{body}")
+
+    if not output_sections:
+        return (f"/* Error: No lines found for {target_file} "
+                f"in range {start_line}-{end_line} */")
+
+    return "\n/* end of expansion */\n".join(output_sections)
+
+
+def extract_range(stdout, target_file, start_line, end_line, working_dir):
+    """
+    Parse the output of the pre-processor while tracking where we
+    are in the source code from the markers so we can extract the
+    range asked for.
+    """
+    state = PreprocessorState()
+    target_abs = os.path.abspath(target_file)
+    line_range = (start_line, end_line)
+
+    # The format is undocumented but see:
+    #
+    #  gcc/c-family/c-ppoutput.c:print_line_1
+    #
+    # where 1 = entering file, 2 = leaving file
+    # and the 3 or 3 4 depends on linemap_location_in_system_header_p
+    line_marker_re = re.compile(r'^# (\d+) "(.*?)"(.*)')
+
+    for line in stdout.splitlines():
+        match = line_marker_re.match(line)
+        if match:
+            new_line = int(match.group(1))
+            raw_path = match.group(2)
+            flags = match.group(3).split()
+
+            path = normalize_path(raw_path, working_dir)
+            state.update_on_marker(new_line, flags, path)
+            continue
+
+        state.add_line(line, line_range, target_abs, working_dir)
+
+    return format_output_sections(state.sections, target_file,
+                                  start_line, end_line)
+
+
+def main():
+    """Main entry point for the script."""
+    desc = 'Expand macros in a section of a file using compile_commands.json'
+    parser = argparse.ArgumentParser(description=desc)
+    parser.add_argument('file', help='Source file to expand macros in')
+    parser.add_argument('--range', help='Line range (e.g. 100-120)')
+
+    ctx_help = ('Context file (.c) to get compilation flags from '
+                '(useful for headers)')
+    parser.add_argument('--context', help=ctx_help)
+    parser.add_argument('--compile-commands', default='compile_commands.json',
+                        help='Path to compile_commands.json')
+    parser.add_argument('--show-command', action='store_true',
+                        help='Print the modified compile command and exit')
+
+    args = parser.parse_args()
+
+    if not os.path.exists(args.compile_commands):
+        print(f"Error: {args.compile_commands} not found.", file=sys.stderr)
+        sys.exit(1)
+
+    with open(args.compile_commands, encoding="utf-8") as f:
+        compile_commands = json.load(f)
+
+    query_file = args.context if args.context else args.file
+    entry = find_compile_command(query_file, compile_commands)
+
+    if not entry:
+        print(f"Error: Could not find compile command for {query_file}",
+              file=sys.stderr)
+        sys.exit(1)
+
+    cmdline = process_command(entry)
+    if not cmdline:
+        print(f"Error: Failed to process command for {query_file}",
+              file=sys.stderr)
+        sys.exit(1)
+
+    if args.show_command:
+        print(shlex.join(cmdline))
+        sys.exit(0)
+
+    working_dir = entry.get('directory', '.')
+    result = subprocess.run(cmdline, stdout=subprocess.PIPE,
+                            stderr=subprocess.PIPE, cwd=working_dir,
+                            universal_newlines=True, check=False)
+
+    if result.returncode != 0:
+        print(f"Preprocessor failed:\n{result.stderr}", file=sys.stderr)
+        sys.exit(result.returncode)
+
+    content = result.stdout
+    if args.range:
+        try:
+            start, end = map(int, args.range.split('-'))
+            content = extract_range(content, args.file, start, end,
+                                    working_dir)
+        except ValueError:
+            print(f"Error: Invalid range format {args.range}. Use start-end.",
+                  file=sys.stderr)
+            sys.exit(1)
+
+    print(content)
+
+
+if __name__ == "__main__":
+    main()
-- 
2.47.3


