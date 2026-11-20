Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DAC8606A6C4
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 20:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=RrtG4jq6
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUUtT-00039Z-NI; Fri, 20 Nov 2026 15:07:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xUUrN-00018q-F4
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 15:05:25 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xUUrJ-0001sa-Tn
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 15:05:25 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-49a92144733so708414f8f.0
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 12:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795205119; x=1795809919; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Dle+Zp+BbDLFOA/MH7EafCGd6d041LZjZYEk4N9v81o=;
 b=RrtG4jq6jYh3Djfyy1AJwg1YgrN5HCjRgaTLCC2lAVU+UeAvAPhveEQD2C8ATE9ro0
 eKtCAs321f29fk2zw6juFNH5z2Wo/vywGeRc/Xjp1cdgSs4mdpNaKdyuk162nbhVWA/F
 Qa4y39Z/upx2FTYfOgbKwzBHBZYIxG1piC4sBaRo7qXpy0lx1teB3p75Rwm2gCLojnze
 klEoVA+rAxaNW+lLCWhRjfzser3/lnRAuc/AG49eejJquiycXy3k5zM3mTNWAInp2fLQ
 HUra/uZSVUopW5G86ZE09w2g6khS9hCqBYrERUxOaTBheA6Wf1ga8dwME2ei9FmI+E1R
 dmLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795205119; x=1795809919;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Dle+Zp+BbDLFOA/MH7EafCGd6d041LZjZYEk4N9v81o=;
 b=IiSB4oIGZCvTyfQfY3nhypFn2Ffx8Kg9SLYp4hyUmVnmGYMgPZ0Y0NJ02fZ3CUAA0k
 k1YBNe213bs54OZITK8e8Ui4p+UJjUfB8yheVO/+tE/wUJ6rb7/7CmRAhKHVVxzP4iFg
 0RY4Odj1DwfJN2UQOmxkgcRgBk90vGh2DX61j4cdG3Dfa1lUROJdchkzcCfw+TbpKVFp
 Xj23dRiXIFj0rYBw4hdYEr5UUF9T96FjGtf2vuB7zzT19Y6jZhVuOslIhwjRFLtPmCuX
 y9sqERSj1Ysz6SB18LI0gBJM/ME4ziykml+NyIyiKjIq12skkyOV6qmgUNOPpWbgeMdg
 tJpA==
X-Gm-Message-State: APuU4Z+KAnJjJT0+s4TXFUZDX9mlcmeEdmm7AbJRlE85hmVyfU2zQrkv
 nGOHFJaLkXo63eMqttpFg4+T4AOpOJ5OG8NIVmQane0Z+3Cn6EEG1L/JUR/uApUI/Wg=
X-Gm-Gg: AZFdTZeXpp/aotKWkSTRsaox3QekDrTyoO2bUl3tYprXtqG2idICxTikx86nzSHQ3Il
 IXBoyM6boqH4w3Yd2POw0AiDco8DSMUZU5xNli8S2P5xkHrPbjA1nwJRQF6+u0CEIdX9HjQOGe2
 dQaq9l3TlVTH0FjLWFuYIf+8wpHx/+qtq2E5Pi3M8rrn3AruZTK+gs9b0zcOQPdCh0YBxH4la7m
 ls2xML8PGzx+Q1AZjtiaAUXjQl9zdJQOqsYWFrpuu/La4ol2NY067eyL7ceHZ+1u+22s3tbvkdr
 sdJK+xCNpwVJl1h/O+OBhjJH2RIkB5ZuYXj7OFq4MK3LMeUZtCfYBSQBRlRUM2bP0amdBcUonsg
 75u+txnJb383PqMptSzKaJLQVwgVcpPaEx6cq9bFx4UJpwOua5VmbY5ibo075Z5qUBqY6bAZT52
 1hQLYAjRq8kZ7/921PMGgsXDgXlneKqLy14n4NDfs2JfKCHDyOpTf2qzf/SGlptSY7/GEttZInN
 NO5tYIKnoA1wkwwo2tp7f0Wm/HYAfRx1vO5KUAUeOLAqnqUC9CPTu0MrCK1xOyB0xPfwU3Icjuh
 xvI8HEgJwjmyA74vJAnoPmH8U8k5
X-Received: by 2002:a05:6000:2308:b0:49b:587:121a with SMTP id
 ffacd0b85a97d-4abb36787afmr9073355f8f.16.1795205119264; 
 Fri, 20 Nov 2026 12:05:19 -0800 (PST)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6c61e53asm7888669f8f.59.2026.11.20.12.05.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 12:05:14 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id BCBA35FA0D;
 Fri, 20 Nov 2026 20:05:11 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>
Subject: [PATCH 03/22] scripts/get_maintainer.py: initial parsing of
 MAINTAINERS
Date: Fri, 20 Nov 2026 20:04:51 +0000
Message-ID: <20261120200511.822573-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261120200511.822573-1-alex.bennee@linaro.org>
References: <20261120200511.822573-1-alex.bennee@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x436.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add the basic infrastructure to parse MAINTAINERS and generate a list
of MaintainerSection objects we can use later.

Add a --validate argument so we can use the script to ensure
MAINTAINERS is always parse-able in our CI.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v3
  - use sys.exit in preference
  - properly skip preamble
  - clean up some pylint warnings
v2
  - add __str__ function for formatting Person
---
 scripts/get_maintainer.py | 175 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 174 insertions(+), 1 deletion(-)

diff --git a/scripts/get_maintainer.py b/scripts/get_maintainer.py
index 794e96d4ae8..dcf132856cc 100755
--- a/scripts/get_maintainer.py
+++ b/scripts/get_maintainer.py
@@ -10,9 +10,166 @@
 #
 # SPDX-License-Identifier: GPL-2.0-or-later
 
-from argparse import ArgumentParser, ArgumentTypeError
+import sys
+from argparse import ArgumentParser, ArgumentTypeError, BooleanOptionalAction
 from os import path
 from pathlib import Path
+from enum import StrEnum, auto
+from re import compile as re_compile
+
+#
+# Subsystem MAINTAINER entries
+#
+# The MAINTAINERS file is an unstructured text file where the
+# important information is in lines that follow the form:
+#
+# X: some data
+#
+# where X is a documented tag and the data is variously an email,
+# path, regex or link. Other lines should be ignored except the
+# preceding non-blank or underlined line which represents the name of
+# the "subsystem" or general area of the project.
+#
+# A blank line denominates the end of a section.
+#
+
+tag_re = re_compile(r"^([A-Z]):")
+
+
+class UnhandledTag(Exception):
+    "Exception for unhandled tags"
+
+
+class BadStatus(Exception):
+    "Exception for unknown status"
+
+
+class Status(StrEnum):
+    "Maintenance status"
+
+    UNKNOWN = auto()
+    SUPPORTED = 'Supported'
+    MAINTAINED = 'Maintained'
+    ODD_FIXES = 'Odd Fixes'
+    ORPHAN = 'Orphan'
+    OBSOLETE = 'Obsolete'
+
+    @classmethod
+    def _missing_(cls, value):
+        # _missing_ is only invoked by the enum machinery if 'value'
+        # does not match any existing enum member's value. So, if we
+        # reach this point, 'value' is inherently invalid for this
+        # enum.
+        raise BadStatus(f"'{value}' is not a valid maintenance status.")
+
+
+person_re = re_compile(r"^(?P<name>[^<]+?)\s*<(?P<email>[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,})>$")
+
+
+class BadPerson(Exception):
+    "Exception for un-parsable person"
+
+
+class Person:
+    "Class representing a maintainer or reviewer and their details"
+
+    def __init__(self, info):
+        match = person_re.search(info)
+
+        if match is None:
+            raise BadPerson(f"Failed to parse {info}")
+
+        self.name = match.group('name')
+        self.email = match.group('email')
+
+    def __str__(self):
+        return f"{self.name} <{self.email}>"
+
+
+class MaintainerSection:
+    "Class representing a section of MAINTAINERS"
+
+    def _expand(self, pattern):
+        if pattern.endswith("/"):
+            return f"{pattern}*"
+        return pattern
+
+    def __init__(self, section, entries):
+        self.section = section
+        self.status = Status.UNKNOWN
+        self.maintainers = []
+        self.reviewers = []
+        self.files = []
+        self.files_exclude = []
+        self.trees = []
+        self.lists = []
+        self.web = []
+        self.keywords = []
+
+        for e in entries:
+            (tag, data) = e.split(": ", 2)
+
+            if tag == "M":
+                person = Person(data)
+                self.maintainers.append(person)
+            elif tag == "R":
+                person = Person(data)
+                self.reviewers.append(person)
+            elif tag == "S":
+                self.status = Status(data)
+            elif tag == "L":
+                self.lists.append(data)
+            elif tag == 'F':
+                pat = self._expand(data)
+                self.files.append(pat)
+            elif tag == 'W':
+                self.web.append(data)
+            elif tag == 'K':
+                self.keywords.append(data)
+            elif tag == 'T':
+                self.trees.append(data)
+            elif tag == 'X':
+                pat = self._expand(data)
+                self.files_exclude.append(pat)
+            else:
+                raise UnhandledTag(f"'{tag}' is not understood.")
+
+
+
+
+def read_maintainers(src):
+    """
+    Read the MAINTAINERS file, return a list of MaintainerSection objects.
+    """
+
+    mfile = path.join(src, 'MAINTAINERS')
+    entries = []
+
+    section = None
+    fields = []
+
+    with open(mfile, 'r', encoding='utf-8') as f:
+        for line in f:
+            if not line.strip():  # Blank line found, potential end of a section
+                if section and fields:
+                    new_section = MaintainerSection(section, fields)
+                    entries.append(new_section)
+                # reset for next section
+                section = None
+                fields = []
+            elif tag_re.match(line):
+                fields.append(line.strip())
+            else:
+                if line.startswith("-") or line.startswith("="):
+                    continue
+
+                section = line.strip()
+
+        if section and fields:
+            new_section = MaintainerSection(section, fields)
+            entries.append(new_section)
+
+    return entries
 
 
 #
@@ -103,6 +260,12 @@ def parse_args():
     group.add_argument('-f', '--file', type=valid_file_path, nargs = "+",
                        help='path to source file(s)')
 
+    # Validate MAINTAINERS
+    parser.add_argument('--validate',
+                        action=BooleanOptionalAction,
+                        default=None,
+                        help="Just validate MAINTAINERS file")
+
     # We need to know or be told where the root of the source tree is
     src = find_src_root()
 
@@ -111,6 +274,16 @@ def parse_args():
 
     return parser.parse_args()
 
+    try:
+        # Now we start by reading the MAINTAINERS file
+        maint_sections = read_maintainers(args.src)
+    except Exception as e:
+        print(f"Error: {e}")
+        sys.exit(-1)
+
+    if args.validate:
+        print(f"loaded {len(maint_sections)} from MAINTAINERS")
+        sys.exit(0)
 
 def main():
 
-- 
2.47.3


