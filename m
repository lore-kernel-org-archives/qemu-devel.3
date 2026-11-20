Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23174606A332
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 20:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=CXKCjqjm
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUUtM-0002cQ-U1; Fri, 20 Nov 2026 15:07:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xUUrN-00018o-Ed
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 15:05:25 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xUUrJ-0001sU-Sq
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 15:05:24 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4bb70074ab2so13766955e9.0
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 12:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795205119; x=1795809919; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=JwZgYflTBmTwWzdwzA79/NwfbZ5mHHiPAcyhniuwBBw=;
 b=CXKCjqjm8YZzasq9hdetYnR83vuEiN+QUDManmDjZPIgdyTB665M8pOjbIscFOQ5FS
 IoLn06gB7dbCjDE4F+289OryJAbVdBKSfwM7+mFjl8F8m/iWolQ7gVaY5FIUfUmyMpaV
 FSumPx62sRBttWMme5X7hjGDhvIBrPvA6jf0wCSTB4SZxe6OY5oS60vZrtE4HRM2/t3x
 vOrNFyayT6l85CNVGrcvHIBVIvqo8f6mP6ANzmtoZ0W+YtbjQ9vfqHteVSuM/NN/oB40
 nUkIBAfDlW3mhGFVnRtBh2wEfrYclfuqryr0yO8onvg/UXVqjImi7gwWapCAnAOAdktE
 V7Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795205119; x=1795809919;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JwZgYflTBmTwWzdwzA79/NwfbZ5mHHiPAcyhniuwBBw=;
 b=HF10dMUVYXo0X5WBAI7s4O+WgFKTeUYg8M4lB1ZwZBAYFeTtu0jlHji7ruKHCpDnTu
 pPqQDUUx8dAWqbkc0IdXS39TG3XtR2bIjbRtDlPls1o5gpgxzWfq/smo2GmDa07sKebl
 WWXuXGuEvb7o9HQ3nXhZ70b4Bl76fHqsdR9mdbxNixVGwq925zkMHxvTy0xUOdmhloDy
 h3NQ34JTFAj+M/90GCW66Lz4+RrKjZczp8Aqipd0GquSTbfDboo081uLsK2vj/eFM61v
 jRVXnao0ISlRijF3a+VNW2toangssKVjaQz/Mz+++1QaJZF3/5EfUd0gO2obwLt2ASQL
 EcmQ==
X-Gm-Message-State: APuU4Z9IveWicrimnJh28UjmaUIJC5xUa/zfN4nNW52qaA81F5i1M/PN
 QxV9k39Y0+BZdk6fGXxsDLgcXiY8lM19X7wAhsZ2LhclzRMJHsQ2cJtOw1N/FCmUgcmiF802Ptw
 J0G2r
X-Gm-Gg: AYBFou2VgJbPgf3sn0jx3aYBGCEk1RuZbuWem0jnnj/U8jYfzN0diIg0c7ueLN1BHkL
 ZjfGb7wDFlVCEIaww5mBg6I2IDPQXnhADuquy0DyGZzdEZxnbjiqRpG0qc9CcbTghOzgxepuOwE
 mNGklMBHjO2r0dCh+vm2wWpfk6laFep+DRyrnZLYgkX4rEQ9SXQ+2vDM5sxIu5DusLHa3cp7mc8
 zNcDYeT2XtMN/+POX7x4CcjaJDm7v6Y7VZvRjufGlvf851075d18eIVVueDLz6KYuNRkHn5QD2i
 +X5SVRraHRbQ715oQB0tU7MQpsIGPzQ2P+BhSsdR9WwgiUzikxjD18+Ebf4BV0XCTxYOW3TM922
 5+krukWFhp0rnaxFYrq6QyCOVSSs6xG4SgURprgai3gjKhV6juHp/nxwT8NgSSwPh90GmdvmyIX
 NN9yXRu0bZiiSGtb302wN2NQotR+0kLuKLN9lP57qPaVnhI8YKzsV4zHr3HSpAeZSMB6fkBykv5
 OZYZqLoU2Qp8URv/HCSml3i1ptflzwi19bak8ZOmmblBKkafYDlqtWdARe4Z7bFi5reydC0+Afl
 x4RjIxlZpoG7keB7ILXg6SgHsJBj
X-Received: by 2002:a05:600c:a0b:b0:4b7:6a8b:9df2 with SMTP id
 5b1f17b1804b1-4bb8882432bmr93218915e9.25.1795205118745; 
 Fri, 20 Nov 2026 12:05:18 -0800 (PST)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853a9687sm158182785e9.10.2026.11.20.12.05.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 12:05:14 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 247495FA4B;
 Fri, 20 Nov 2026 20:05:12 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>
Subject: [PATCH 07/22] scripts/get_maintainer.py: implement basic git fallback
 support
Date: Fri, 20 Nov 2026 20:04:55 +0000
Message-ID: <20261120200511.822573-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261120200511.822573-1-alex.bennee@linaro.org>
References: <20261120200511.822573-1-alex.bennee@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
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

Implement the basic --git fallback support which also needs
--git-since and the various knobs to control the minimum and maximum
signatures to look for.

As the default inverted options are slightly different in python
ArgParse I've added alias options to maintain compatibility with the
perl script.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 scripts/get_maintainer.py | 132 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 131 insertions(+), 1 deletion(-)

diff --git a/scripts/get_maintainer.py b/scripts/get_maintainer.py
index 443fbf8e875..ae97c755de2 100755
--- a/scripts/get_maintainer.py
+++ b/scripts/get_maintainer.py
@@ -12,12 +12,16 @@
 
 import sys
 from argparse import ArgumentParser, ArgumentTypeError, BooleanOptionalAction
+from dataclasses import dataclass
 from os import path
 from pathlib import Path
 from enum import StrEnum, auto
 from re import compile as re_compile
 from re import sub as re_sub
+from re import IGNORECASE
 from regex import compile as prec_compile
+from git import Repo
+from collections import Counter
 
 #
 # Subsystem MAINTAINER entries
@@ -237,6 +241,96 @@ def process_patch_file(patchfile):
 
     return (msg, file_list)
 
+#
+# Helpers for querying git
+#
+
+
+@dataclass
+class GitOptions:
+    repo: Repo
+    singers: bool
+    since: str
+    min_sig: int
+    max_maint: int
+    min_percent: int
+
+
+def rank_signers(git_opts, all_signers, total_commits):
+    """
+    Counts signer occurrences and returns a list of (Person, count, percent).
+    """
+    if total_commits == 0:
+        return []
+
+    # Count by email to handle duplicates/mailmap issues
+    counts = Counter(s.email for s in all_signers)
+
+    # Keep a map of email -> Person object for the most recent name used
+    email_to_person = {p.email: p for p in all_signers}
+
+    ranked_results = []
+
+    # Sort by count descending, then take the top N
+    for email, count in counts.most_common(git_opts.max_maint):
+        percent = min(100.0, (count / total_commits) * 100)
+        if percent >= git_opts.min_percent:
+            person = email_to_person[email]
+            ranked_results.append((person, count, percent))
+
+    return ranked_results
+
+
+# regex to extract name/email from *-by: tags
+sig_line_re = re_compile(r"^\s*[\w-]+-by:\s*(?P<person_info>.*)", IGNORECASE)
+
+
+def extract_signers(commit_message):
+    """
+    Return a list of Persons found in commit.
+    """
+    signers = []
+    for line in commit_message.splitlines():
+        match = sig_line_re.match(line)
+        if match:
+            try:
+                p = Person(match.group('person_info'))
+                signers.append(p)
+            except BadPerson:
+                continue
+    return signers
+
+
+def extract_from_git(git_opts, src_file):
+    """
+    Extract 'maintainers' from examining the git history of a file.
+    Return an array of Person/role tuples.
+    """
+    repo = git_opts.repo
+
+    # use the porcelain to fetch the log
+    hashes = repo.git.log('--follow', f"--since={git_opts.since}",
+                          "--format=%H", '--', src_file).splitlines()
+
+    if len(hashes) <= 0:
+        return []
+
+    commits = [repo.commit(h) for h in hashes]
+
+    all_signers = []
+
+    for c in commits:
+        all_signers.extend(extract_signers(f"{c.message}"))
+
+    ranked = rank_signers(git_opts, all_signers, len(commits))
+    results = []
+
+    for person, count, percent in ranked:
+        role = f"commit_signer: {count}/{len(commits)}={percent:.0f}%"
+        results.append((person, role))
+
+    return results
+
 #
 # Helper functions for dealing with the source path
 #
@@ -337,6 +431,27 @@ def parse_args():
     parser.add_argument('--src', type=valid_src_root, default=src,
                         help=f'Root of QEMU source tree{" (default: " + src + ")" if src else ""}')
 
+    # Git Options
+    parser.add_argument('--git', action=BooleanOptionalAction,
+                        default=False,
+                        help="Include recent git *-by: signers (default: don't)")
+    parser.add_argument('--nogit', dest='git', action='store_false',
+                        help="Disable git signers (alias for --no-git)")
+    parser.add_argument('--git-since', default="1-year-ago",
+                        help='git history to use when falling back (default: 1-year-ago)')
+    parser.add_argument('--git-fallback',
+                        action=BooleanOptionalAction, default=True,
+                        help='use git when no exact MAINTAINERS pattern (default: fallback)')
+    parser.add_argument('--nogit-fallback', dest='git_fallback',
+                        action='store_false',
+                        help="Do not fallback to git (alias)")
+    parser.add_argument('--git-min-signatures', default=1,
+                        help='number of signatures required (default: 1)')
+    parser.add_argument('--git-max-maintainers', default=5,
+                        help='maximum number of git derived maintainers to add (default: 5)')
+    parser.add_argument('--git-min-percent', default=5,
+                        help='minimum percentage of commits to tagged as a maintainer (default: 5)')
+
     return parser.parse_args()
 
 
@@ -372,7 +487,7 @@ def main():
                 maintained.add(m)
 
     for f in files:
-        rf = f.relative_to(Path(args.src))
+        rf = f.relative_to(args.src)
         fmaint = [ms for ms in maint_sections if ms.is_file_covered(rf)]
         for m in fmaint:
             maintained.add(m)
@@ -380,6 +495,21 @@ def main():
     for rm in maintained:
        print(f"{rm}")
 
+    # Git fallback
+    if args.git or (args.git_fallback and len(maintained) == 0):
+        repo = Repo(args.src)
+        git_opts = GitOptions(repo=repo, singers=args.git,
+                              since=args.git_since,
+                              min_sig=args.git_min_signatures,
+                              max_maint=args.git_max_maintainers,
+                              min_percent=args.git_min_percent)
+
+        for f in files:
+            gmaint = extract_from_git(git_opts, f)
+
+            for (person, role) in gmaint:
+                print(f"{person} ({role})")
+
 
 if __name__ == '__main__':
     main()
-- 
2.47.3


