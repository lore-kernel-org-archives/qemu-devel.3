Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AEB0D74EDB
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 14:59:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjIc6-0004MM-WB; Fri, 23 Jan 2026 09:58:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vjIby-0004I4-72
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 09:58:11 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vjIbv-0007nQ-7Z
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 09:58:09 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-42fbc305882so1401183f8f.0
 for <qemu-devel@nongnu.org>; Fri, 23 Jan 2026 06:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769180285; x=1769785085; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hoccyFN4VSFNY3IFMb9lpWrE3hrQlhyVLovZvI9LP+I=;
 b=rHule8hSpdeS+CGe95GaOtlSrUrqjLfFc90j9NxUZMrCmygC5zsu1vMfOPxhP9MWoK
 HeCLl2E7kEkmD00IYauw+buSV/W37jp6WMvDGTVbORRiiH7drmpD9e3oU0N948OJBXR1
 h0Evze3qrSPf36miZDYc3Ucs9JsDskIiDUO8jGFsh0O12xgZSyO7Nq9GB6H4FMQqfy69
 pRfMdSDld2YuEekGAdjz/OJ6LiArIE8uHWupygzRRv5w2jxbaaMx+6dQcbe3DPADJowj
 7cSCEnrNzmxjnGvmXdsBMZpFb13cjC7Y3UtgnbDPo7Ya2xNZ70Y2/BoryopgkWR+LM4j
 zU/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769180285; x=1769785085;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hoccyFN4VSFNY3IFMb9lpWrE3hrQlhyVLovZvI9LP+I=;
 b=H19Dg7OG9sfEJDafhOV9Xbg9wHCucrN4sEa7HSQAYqWDOUONEqZs0M2w+2b0uT1g/n
 ZVxP9UytRo7uSb9JIkU/5TQ1jfmddaYmyQoSPZLOvUQnb3OZshbLJE0wou+yvoqj3Xh5
 nhIz/SOEm6VGLZH7WHVBa6Xytp4+MCQ58qxfFfJmc3s52Yp1M/rG1lIxvw/t5EFoAj76
 GBkTP2yZ5WOR5vOyGDkI4u76WMr2BFUuN4QWvlmA4K3qGs/a+TJbuBlxV2AJQQ1iNQTL
 NjnZwV3m8SoaFUHD3kr96t/JJxEtmreCLCpnCfr/wiKg8CmwHYPhPQpeU8csFJ4vLsMj
 jA6w==
X-Gm-Message-State: AOJu0YyeUi0+Dx7jtlqrxqbJT777L8c8NE5QNHJ2bJF56fQsgD52NQzc
 43fmsA/c8P64Ho6aFYCxlA8nBfOh7vtE+GKvmSGdFK9oCB3LknKcWp90trCZp9CM3VA=
X-Gm-Gg: AZuq6aKCfX4Jjdg741b7KwB69jnVWbcKcl6lABzb1cMp69jgjUjKyMR+cRFhl0QWHXb
 R3x8uPRjNMDujuELu11KBi88AMCkqYlqr6u3WBn2Ke2ehaFd71XRonxm5L3/Gn8a9vpzFGcvAmj
 zICU/Jh+etpMkN1W/ECqC57BzGL11BUZYP2ZVQAcV3b0alZLWI7UpKFJEDzsSVPiSmRYiYCA3yJ
 Ado242bWlASYGNf6XT6uPB9BnfVqHjTYTZLu7EC4Rl8OSEsmxItuM4kHBbL+DzEJvO8n+XVwFZa
 YtQEWBOYSBKxnhdB7mgffzAfVDU3jsFR9zG9AD5KPn4HyqTvVSDRJeUTaty0q7JYHk0TWAuUQoj
 24dX5dU4xU3b2/+dsnL2vsz7RNiYxQdBp48inkxgzwCX20XJKp+dzEZNexMp6U4C2PjzJC701+t
 7gvzVdFiE1n+ZR
X-Received: by 2002:a05:6000:2913:b0:430:fbe1:3822 with SMTP id
 ffacd0b85a97d-435b1621b48mr6927553f8f.54.1769180284807; 
 Fri, 23 Jan 2026 06:58:04 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1f742d6sm7017768f8f.30.2026.01.23.06.57.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jan 2026 06:57:57 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6AF4C5F94A;
 Fri, 23 Jan 2026 14:57:51 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Joe Perches <joe@perches.com>, John Snow <jsnow@redhat.com>
Subject: [RFC PATCH v2 11/16] scripts/get_maintainer.py: initial parsing of
 MAINTAINERS
Date: Fri, 23 Jan 2026 14:57:44 +0000
Message-ID: <20260123145750.1200879-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260123145750.1200879-1-alex.bennee@linaro.org>
References: <20260123145750.1200879-1-alex.bennee@linaro.org>
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add the basic infrastructure to parse MAINTAINERS and generate a list
of MaintainerSection objects we can use later.

Add a --validate argument so we can use the script to ensure
MAINTAINERS is always parse-able in our CI.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - add __str__ function for formatting Person
---
 scripts/get_maintainer.py | 168 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 167 insertions(+), 1 deletion(-)

diff --git a/scripts/get_maintainer.py b/scripts/get_maintainer.py
index c02bf4f5b0e..696a5b55d8d 100755
--- a/scripts/get_maintainer.py
+++ b/scripts/get_maintainer.py
@@ -10,9 +10,159 @@
 #
 # SPDX-License-Identifier: GPL-2.0-or-later
 
-from argparse import ArgumentParser, ArgumentTypeError
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
+        # _missing_ is only invoked by the enum machinery if 'value' does not
+        # match any existing enum member's value.
+        # So, if we reach this point, 'value' is inherently invalid for this enum.
+        raise BadStatus(f"'{value}' is not a valid maintenance status.")
+
+
+person_re = re_compile(r"^(?P<name>[^<]+?)\s*<(?P<email>[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,})>\s*(?:@(?P<handle>\w+))?$")
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
+                if section:
+                    new_section = MaintainerSection(section, fields)
+                    entries.append(new_section)
+                    # reset for next section
+                    section = None
+                    fields = []
+            elif tag_re.match(line):
+                fields.append(line.strip())
+            else:
+                if line.startswith("-") or line.startswith("="):
+                    continue
+
+                section = line.strip()
+
+    return entries
 
 
 #
@@ -104,6 +254,12 @@ def main():
     group.add_argument('-f', '--file', type=valid_file_path,
                        help='path to source file')
 
+    # Validate MAINTAINERS
+    parser.add_argument('--validate',
+                        action=BooleanOptionalAction,
+                        default=None,
+                        help="Just validate MAINTAINERS file")
+
     # We need to know or be told where the root of the source tree is
     src = find_src_root()
 
@@ -112,6 +268,16 @@ def main():
 
     args = parser.parse_args()
 
+    try:
+        # Now we start by reading the MAINTAINERS file
+        maint_sections = read_maintainers(args.src)
+    except Exception as e:
+        print(f"Error: {e}")
+        exit(-1)
+
+    if args.validate:
+        print(f"loaded {len(maint_sections)} from MAINTAINERS")
+        exit(0)
 
 
 if __name__ == '__main__':
-- 
2.47.3


