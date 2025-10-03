Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17A4DCCA471
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 14:20:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4gcj-0004Hw-NW; Fri, 03 Oct 2025 10:19:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1v4gcf-0004GP-6L
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 10:19:01 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1v4gcR-0000Mj-Qj
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 10:19:00 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-782e93932ffso2205772b3a.3
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 07:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759501119; x=1760105919; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m3Lu2NRplrZgk9XtswV/IDslanVCiuqlvqdTW9TG0Qc=;
 b=h3MkHqIHb3VoSOOaP1cJpkGEyVnLMDAmzqhmEl8lI24CToJFCHtinGULGH8rq7CCBj
 DC2GfEtMcMIiO4P85npx89PSuQvePFAgZmtSFix+zPOA4qhy74/6qQN1lZiZrW/jWLzr
 B2EMxVe2XSNG0rOKHgJF7gFlN5CbmHrxjjPsuYWOcI9soXF5XauEK5O/1KOa/FcpHmxO
 kI2TC/Le9Ndzq5Tl60d/b5SLi8A6lS9JbECL0tcGTYaUyjhBLW3MZDnijVUCvo/Hj2YB
 Os3sNCDFoPFGfIJq2SgrbU0KHvOMkJKKThVLqZoshZQZFYV5bgtXeLhBZIqBN8KHBoqm
 nC8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759501119; x=1760105919;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m3Lu2NRplrZgk9XtswV/IDslanVCiuqlvqdTW9TG0Qc=;
 b=OPHmjd6GZl6uP6anUC9NgGzna10mNPOWKOtfAByL6OAz1t5PvIinS/7J5yJphGpI6X
 Qt9M7P0f76MBW2jChAXGu/ej+yMPz4XsrF+KEuFSkNT3/6pWry4fDIPmh9MqkVrmP+gp
 1taQmfY2OU3A6VaP9cd20oBoZJyB5Hq3xqTBDi+WZ/xf+JjfHmr446qchcrxQtB7HavI
 Cj4UigMu8e/uS7lgAx0WJRgs5Lxl6c8kw5cD5gwRwbvlsefLFot0Pnxnimvkrs3hL+f7
 9bv9ZbBtEDjnd6+yq+794S+8RIABC563bcBPfnsz/1tmNfAUHDFy6QQdQ0A9lufg8uzz
 Sk4Q==
X-Gm-Message-State: AOJu0YyJqKtKjIRpUj35PibrmK+YSTuTTofIuF3NgNdevLXwKWTVgIIW
 50156OXyYpYQSN7s6XuzTHHhjgs5ATz8ulwbyEa4rAI2xSzeMIZ8c4sHWNY3fYEs7BfDyIXCrO1
 9JJCv
X-Gm-Gg: ASbGncta8IJthlEz40goNv1E7Ef/OWOtHO4FQq7nnSIjjG4QXJrgGzr1339x+37F9Gu
 egF+KZiD1sbxtPmvd4j36T2K4ZG/m2csbbDtiWP4Z/UHd9ZnsXOIqGGzZ1hpzSEvII7kRVntrj+
 KEuGq0Bf75663C8ncXR9BqY7NbRtdAriUEXAqwYY9HCmjV2y38MUGX7KtqXb00ZwcQPppG0iTW4
 eBs69yxlPl+kAZG2OvTkiCLx0dUNERUIGG1+RKYI4hVj4uSh2kAxlnq68C3dld0/SpzhxpU6S68
 44qFh7uCD9CFnqJDcJMwaKqY7IEr2x2sEDi0cTv/RKRgPc9Gb32fR7fq10xpYW4ebQhJDND+Mgf
 hbTkNFy4I0tQ1tiQgSDKohxXKq9GEFRCY+scfD2Gik4QjlFkJctidmfeW
X-Google-Smtp-Source: AGHT+IFfagNNFUgmZw+spC/tK+ESmvXYqtVwKmKABCCzx77SO3I5Kms/p0tJQ5OwST4G8B5VH3LZHg==
X-Received: by 2002:a17:903:1b25:b0:28e:756c:7082 with SMTP id
 d9443c01a7336-28e9a546d94mr38020825ad.15.1759501119300; 
 Fri, 03 Oct 2025 07:18:39 -0700 (PDT)
Received: from gromero0.. ([186.215.59.111]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-28e8d1d5635sm51759645ad.102.2025.10.03.07.18.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 07:18:38 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, alex.bennee@linaro.org, thuth@redhat.com,
 berrange@redhat.com
Cc: qemu-arm@nongnu.org,
	gustavo.romero@linaro.org
Subject: [PATCH v6 4/9] tests/functional: Add GDB class
Date: Fri,  3 Oct 2025 14:18:15 +0000
Message-Id: <20251003141820.85278-5-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251003141820.85278-1-gustavo.romero@linaro.org>
References: <20251003141820.85278-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Add GDB class, which provides methods to run GDB commands and capture
their output. The GDB class is a wrapper around the pygdbmi module and
interacts with GDB via GDB's machine interface (MI).

Acked-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 tests/functional/qemu_test/__init__.py |  1 +
 tests/functional/qemu_test/gdb.py      | 88 ++++++++++++++++++++++++++
 2 files changed, 89 insertions(+)
 create mode 100644 tests/functional/qemu_test/gdb.py

diff --git a/tests/functional/qemu_test/__init__.py b/tests/functional/qemu_test/__init__.py
index 6e666a059f..60d19891bf 100644
--- a/tests/functional/qemu_test/__init__.py
+++ b/tests/functional/qemu_test/__init__.py
@@ -18,3 +18,4 @@
     skipIfMissingImports, skipIfOperatingSystem, skipLockedMemoryTest
 from .archive import archive_extract
 from .uncompress import uncompress
+from .gdb import GDB
diff --git a/tests/functional/qemu_test/gdb.py b/tests/functional/qemu_test/gdb.py
new file mode 100644
index 0000000000..05e4c29c2a
--- /dev/null
+++ b/tests/functional/qemu_test/gdb.py
@@ -0,0 +1,88 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# A simple interface module built around pygdbmi for handling GDB commands.
+#
+# Copyright (c) 2025 Linaro Limited
+#
+# Author:
+#  Gustavo Romero <gustavo.romero@linaro.org>
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or
+# later.  See the COPYING file in the top-level directory.
+
+import re
+
+
+class GDB:
+    """Provides methods to run and capture GDB command output."""
+
+
+    def __init__(self, gdb_path, echo=True, suffix='# ', prompt="$ "):
+        from pygdbmi.gdbcontroller import GdbController
+        from pygdbmi.constants import GdbTimeoutError
+        type(self).TimeoutError = GdbTimeoutError
+
+        gdb_cmd = [gdb_path, "-q", "--interpreter=mi2"]
+        self.gdbmi = GdbController(gdb_cmd)
+        self.echo = echo
+        self.suffix = suffix
+        self.prompt = prompt
+        self.response = None
+        self.cmd_output = None
+
+
+    def get_payload(self, response, kind):
+        output = []
+        for o in response:
+            # Unpack payloads of the same type.
+            _type, _, payload, *_ = o.values()
+            if _type == kind:
+                output += [payload]
+
+        # Some output lines do not end with \n but begin with it,
+        # so remove the leading \n and merge them with the next line
+        # that ends with \n.
+        lines = [line.lstrip('\n') for line in output]
+        lines = "".join(lines)
+        lines = lines.splitlines(keepends=True)
+
+        return lines
+
+
+    def cli(self, cmd, timeout=32.0):
+        self.response = self.gdbmi.write(cmd, timeout_sec=timeout)
+        self.cmd_output = self.get_payload(self.response, kind="console")
+        if self.echo:
+            print(self.suffix + self.prompt + cmd)
+
+            if len(self.cmd_output) > 0:
+                cmd_output = self.suffix.join(self.cmd_output)
+                print(self.suffix + cmd_output, end="")
+
+        return self
+
+
+    def get_addr(self):
+        address_pattern = r"0x[0-9A-Fa-f]+"
+        cmd_output = "".join(self.cmd_output) # Concat output lines.
+
+        match = re.search(address_pattern, cmd_output)
+
+        return int(match[0], 16) if match else None
+
+
+    def get_log(self):
+        r = self.get_payload(self.response, kind="log")
+        r = "".join(r)
+
+        return r
+
+
+    def get_console(self):
+        r = "".join(self.cmd_output)
+
+        return r
+
+
+    def exit(self):
+        self.gdbmi.exit()
-- 
2.34.1


