Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B57606A334
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 20:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=yGh08uDU
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUUsg-0001k9-5e; Fri, 20 Nov 2026 15:06:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xUUrL-00018Y-Qj
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 15:05:25 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xUUrI-0001sS-56
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 15:05:23 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-490c3ae81d3so832256f8f.2
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 12:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795205118; x=1795809918; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=D78EPv3KIejmnCkL+D6GWJcStqhHxiOw9ZH8c0CKxAQ=;
 b=yGh08uDUQJL4UZW7ZFtMn+5vn9Zls/IAMV7yHd+a5A1nehkMPI7USZ/MhSowDGECnW
 YtI8jSYX7lwdvQgvAuXM4JnzrV5QzbG8wGpuOPRhKllwVum80OlziCmssh5SkQeVDK2B
 nOxTSlOR3pUeSim2MYxrqObd9Nq+uoznIPhlGOkaZWJ0zgbWpNcrS7P/iYzxEBAUWJWL
 m1spCMj6wWQLQvVQnkUTQDmRBuo/uH0o00JruALU7s7BB2g8lDZHFCI8Av3cmrNJHVku
 UKl99hewD+hS/vfP6A8Dy0Gp07SVG3w/f1oQLvPKirv6SCk8xCa6O6fBP9w/Bbx+nwRf
 omVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795205118; x=1795809918;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=D78EPv3KIejmnCkL+D6GWJcStqhHxiOw9ZH8c0CKxAQ=;
 b=CUPZ1xhM6+wEKDO7VzMStYHB/WKEIrNp/FvfxAr8qG3T5eNNzkjpLonEsjZ0j6Oa13
 LQJVEkTsGR15gAtAqTMkMS/R9SYGYNDY1PdrNGbr6baYbnS2PjV4wqXbrNEyjELJy0zh
 U51Elhh+JJYUFUzlaL9JbPO+HM0IV3XCQ6eOvE2N2j8QzNaSI0Pz5gXJIg2sG/w+IZus
 66no9QQlHA6BYEC6QZnwE/d6nnFUAIWzJqAQXwgbc98QwwJarF/lzoYXQ3GLLoyEfF8y
 Tlhxtw3ANL2MC+40QGF8acB1imfdfc2eWneVBNCopZ6W5pm4Kgo3vzR/bsu6ofyCHUt2
 5/CA==
X-Gm-Message-State: APuU4Z/H7G7oMM6zQgsJ6TblGUMKC4qT4WxDsEU204HoEHu1pxHPAG6v
 3DIqEXIPO7fLzku8E8WFbwxFBG3Kso1Dw+Pa19h3yr5MVCNY2C9sEw3qMR3fwxQKOoQzHqR7WUg
 FLw3U
X-Gm-Gg: AZFdTZcE8OtLPKZd3skapd8Fv48M5nH7xOnhAy4KMas+GIHFQOGzv1hqJIze9pLQAd9
 hCM5BPxB7jkBPRGiBKz1CIW7FsNMhqY6ORTnI9Jt/QgOmR+7UJ5rQo+IxHs6Sf5i4h+8HGGkMYM
 7/GQ8xNlaxGgwwIeCTj/0qnU7NwlROFEW6ShTXYdpwGjBRvic+3VP8pBZluOFztVr4/cohaLiam
 KI7n4gA3MqUnIlSmR1mlxAlmfLt7ek4QyCjDhNNmi9QhHq5P9f+iBbZ1Ybp1zpHUGXZiYgg2Saj
 8NfeM364bnc0BBE5pIL5RnUMeQThmyXHog13zUYdps1oTHNolLRavW3mvJgNejDKpwVzAfbvhqQ
 8VR9Xt9IwzszThOzVc7M+J0mp4oGYGeUi++d4m4CMBYsIxnHJV0WC86fDL2w/FPYzQo9aMgepy6
 5+BhJc5jDl3owbZB1smiYBQHXm45vJx90ZChDjH6nG7lytOElXNV2dmId+HJz00XC22ZigRyCGS
 lvfW8Z6Hk4V2/NI4qW0umvEeR5y4FVcaghc8Y0a3xRSFISU4/ew+1j0n9Li209SmugfvgHQ5zCk
 ANFhNjW/BHldSe8yUscRrvg8Xb7j
X-Received: by 2002:a05:6000:29ce:b0:4a4:b2c8:c969 with SMTP id
 ffacd0b85a97d-4abb0e46a49mr6502277f8f.20.1795205118403; 
 Fri, 20 Nov 2026 12:05:18 -0800 (PST)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab69bf61ddsm6849462f8f.12.2026.11.20.12.05.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 12:05:17 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8761D5FB29;
 Fri, 20 Nov 2026 20:05:12 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>
Subject: [PATCH 11/22] scripts/get_maintainer.py: add support for gitlab
 handles
Date: Fri, 20 Nov 2026 20:04:59 +0000
Message-ID: <20261120200511.822573-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261120200511.822573-1-alex.bennee@linaro.org>
References: <20261120200511.822573-1-alex.bennee@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x435.google.com
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Since the last posting of this series we now have added a mapping for
names to gitlab handles. Mirror the perl scripts support by adding a
mapping function and using it.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 scripts/get_maintainer.py | 81 +++++++++++++++++++++++++++++++--------
 1 file changed, 64 insertions(+), 17 deletions(-)

diff --git a/scripts/get_maintainer.py b/scripts/get_maintainer.py
index 63983064013..e56a9238ec2 100755
--- a/scripts/get_maintainer.py
+++ b/scripts/get_maintainer.py
@@ -71,6 +71,39 @@ def _missing_(cls, value):
         raise BadStatus(f"'{value}' is not a valid maintenance status.")
 
 
+#
+# Helpers for GitLab handles
+#
+
+
+def load_gitlab_handles(src):
+    """
+    Load GitLab handle to name mappings from .gitlab-map-auto and
+    .gitlab-map-manual. Returns a dictionary mapping name to handle.
+    """
+    name_to_handle = {}
+    for mapfile in ['.gitlab-map-auto', '.gitlab-map-manual']:
+        p = path.join(src, mapfile)
+        if path.exists(p):
+            with open(p, 'r', encoding='utf-8') as f:
+                for line in f:
+                    if not line.startswith('#'):
+                        parts = line.rstrip('\r\n').split('\t', 1)
+                        if len(parts) == 2:
+                            name_to_handle[parts[1]] = parts[0]
+    return name_to_handle
+
+
+def map_gitlab_handle(name, gitlab_map):
+    """
+    Lookup GitLab handle for a real name, stripping quotes.
+    """
+    if not gitlab_map or not name:
+        return None
+    clean_name = name.replace('"', '')
+    return gitlab_map.get(clean_name)
+
+
 person_re = re_compile(r"^(?P<name>[^<]+?)\s*<(?P<email>[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,})>$")
 
 
@@ -81,7 +114,7 @@ class BadPerson(Exception):
 class Person:
     "Class representing a maintainer or reviewer and their details"
 
-    def __init__(self, info):
+    def __init__(self, info, gitlab_map=None):
         match = person_re.search(info)
 
         if match is None:
@@ -89,10 +122,19 @@ def __init__(self, info):
 
         self.name = match.group('name')
         self.email = match.group('email')
+        if gitlab_map is not None:
+            self.handle = map_gitlab_handle(self.name, gitlab_map)
+        else:
+            self.handle = None
 
     def __str__(self):
         return f"{self.name} <{self.email}>"
 
+    def format_role(self, role: str) -> str:
+        if self.handle:
+            return f"{role}, gitlab:@{self.handle}"
+        return role
+
 
 class MaintainerSection:
     "Class representing a section of MAINTAINERS"
@@ -102,7 +144,7 @@ def _expand(self, pattern):
             pattern = f"{pattern}*"
         return re_compile(fn_translate(pattern))
 
-    def __init__(self, section, entries):
+    def __init__(self, section, entries, gitlab_map=None):
         self.section = section
         self.status = Status.UNKNOWN
         self.maintainers = []
@@ -118,10 +160,10 @@ def __init__(self, section, entries):
             (tag, data) = e.split(": ", 2)
 
             if tag == "M":
-                person = Person(data)
+                person = Person(data, gitlab_map=gitlab_map)
                 self.maintainers.append(person)
             elif tag == "R":
-                person = Person(data)
+                person = Person(data, gitlab_map=gitlab_map)
                 self.reviewers.append(person)
             elif tag == "S":
                 self.status = Status(data)
@@ -147,10 +189,12 @@ def __str__(self) -> str:
         entries = []
 
         for m in self.maintainers:
-            entries.append(f"{m.name} <{m.email}> (maintainer: {self.section})")
+            role = m.format_role(f"maintainer: {self.section}")
+            entries.append(f"{m} ({role})")
 
         for r in self.reviewers:
-            entries.append(f"{r.name} <{r.email}> (reviewer: {self.section})")
+            role = r.format_role(f"reviewer: {self.section}")
+            entries.append(f"{r} ({role})")
 
         for l in self.lists:
             entries.append(f"{l} (open list: {self.section})")
@@ -183,11 +227,10 @@ def patch_contains_keyword(self, patch_lines):
         return False
 
 
-def read_maintainers(src):
+def read_maintainers(src, gitlab_map=None):
     """
     Read the MAINTAINERS file, return a list of MaintainerSection objects.
     """
-
     mfile = path.join(src, 'MAINTAINERS')
     entries = []
 
@@ -198,7 +241,7 @@ def read_maintainers(src):
         for line in f:
             if not line.strip():  # Blank line found, potential end of a section
                 if section and fields:
-                    new_section = MaintainerSection(section, fields)
+                    new_section = MaintainerSection(section, fields, gitlab_map)
                     entries.append(new_section)
                 # reset for next section
                 section = None
@@ -212,7 +255,7 @@ def read_maintainers(src):
                 section = line.strip()
 
         if section and fields:
-            new_section = MaintainerSection(section, fields)
+            new_section = MaintainerSection(section, fields, gitlab_map)
             entries.append(new_section)
 
     return entries
@@ -258,6 +301,7 @@ class GitOptions:
     min_sig: int
     max_maint: int
     min_percent: int
+    gitlab_map: dict = None
 
 
 def rank_signers(git_opts, all_signers, total_commits):
@@ -289,7 +333,7 @@ def rank_signers(git_opts, all_signers, total_commits):
 sig_line_re = re_compile(r"^\s*[\w-]+-by:\s*(?P<person_info>.*)", IGNORECASE)
 
 
-def extract_signers(commit_message):
+def extract_signers(commit_message, gitlab_map=None):
     """
     Return a list of Persons found in commit.
     """
@@ -298,7 +342,7 @@ def extract_signers(commit_message):
         match = sig_line_re.match(line)
         if match:
             try:
-                p = Person(match.group('person_info'))
+                p = Person(match.group('person_info'), gitlab_map=gitlab_map)
                 signers.append(p)
             except BadPerson:
                 continue
@@ -324,7 +368,8 @@ def extract_from_git(git_opts, src_file):
     all_signers = []
 
     for c in commits:
-        all_signers.extend(extract_signers(f"{c.message}"))
+        all_signers.extend(extract_signers(f"{c.message}",
+                                           git_opts.gitlab_map))
 
     ranked = rank_signers(git_opts, all_signers, len(commits))
     results = []
@@ -481,8 +526,9 @@ def main():
     args = parse_args()
 
     try:
-        # Now we start by reading the MAINTAINERS file
-        maint_sections = read_maintainers(args.src)
+        # We need the gitlab map before we read the MAINTAINERS file
+        gitlab_map = load_gitlab_handles(args.src)
+        maint_sections = read_maintainers(args.src, gitlab_map)
     except Exception as e:
         print(f"Error: {e}")
         sys.exit(-1)
@@ -558,13 +604,14 @@ def main():
                               since=args.git_since,
                               min_sig=args.git_min_signatures,
                               max_maint=args.git_max_maintainers,
-                              min_percent=args.git_min_percent)
+                              min_percent=args.git_min_percent,
+                              gitlab_map=gitlab_map)
 
         for f in files:
             gmaint = extract_from_git(git_opts, f)
 
             for (person, role) in gmaint:
-                print(f"{person} ({role})")
+                print(f"{person} ({person.format_role(role)})")
 
 
 if __name__ == '__main__':
-- 
2.47.3


