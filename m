Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3132B606A6C8
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 20:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=kzkP9Nl9
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUUzV-0008Ot-0E; Fri, 20 Nov 2026 15:13:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xUUzI-0008Nx-Tc
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 15:13:37 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xUUzG-0003tz-FN
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 15:13:36 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4bb666304fdso22514035e9.0
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 12:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795205612; x=1795810412; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/sUrhc/j2W+qZQYqzBP63I6cOB4pgh6BcSJJ3pmvGy4=;
 b=kzkP9Nl9UbVHQwbikQ64gcKHDSfyKwPxlBlOtCr2pxtuOPjA2eO1WZIygZW1BaakGB
 QQQFC2asS+uQUfq5Lbrf0ujTt8YsIuz/FYC0eVHsW4sJOGc6mfzp/RGh5+OoB85UE1gQ
 uAr8P2/ysBWUytwUbKzyY5Q0purJ8MvjFPOE9CjbJMudn2eyWonxYdZmYxuZ14A7wUtg
 D4amvDkmrfIYGH+iy/jxzsw5HZhstMRQxnErsjIHWyLv9hsodY6srgu/Ic4l5w8S3q1R
 zdHrSYCZYBswJuJUhtJG/X6+tsCLlUBjN3xtgcS6ijm+OXhd1f9GtsywhrJCfSrQIQjP
 HN6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795205612; x=1795810412;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/sUrhc/j2W+qZQYqzBP63I6cOB4pgh6BcSJJ3pmvGy4=;
 b=KVaAmqJ22XRFIX0QNjnlDVT0O2sQngNus6oaAS4FlAbyh/bhp50BF53DM5uxrovIMP
 +gSjukLBrSYJnzEGtIpoGjgBczSwMDetwElx/nWhEqGJLgK8os5KpKmA1iNPYJxqTZqs
 MXbpHGR/Q+tF+WqnYJ0Z+VzQPIvJnCPWhfCaIStHTtheOWKGKW5BrmlqzQnKv6V1VvTw
 CQQyqB3UpoSitHeGthCLN6Im93F68V3hd7BCkAibc2iwzAXqkgPfwJa7XitjS3FjFZd8
 NUjPxhU5Clqkn1bZlhGit2mPxxVHtw5ug3ai1M4vqi82qJROnn6I1jGyjbniJjfDt9Ir
 GoDQ==
X-Gm-Message-State: APuU4Z/ZuJtd7ixbDLB9CMqQe7vi6H9jw/dh+yd6pw6vHbCPj0sbIEvG
 9KcAuKi2sDjFDWxHcWdcOX+4nkr9qnv5mbDAlYvcUWylag/m9pgNJQRbI81ePMVyt6vPE6aicHU
 lGn1u
X-Gm-Gg: AYBFou2aMO+Yf1SQcjRqdFkmofrvY7nzmcuFs4iBU+MZ1sPozAXAFKI781oCTuHI4ol
 X8vFs3UJ3URGXVXh3f0dNiaIjhpCuuC20bZ9QNnopGr+YvDR0R//u4etlNXOaQYrayWQ7TA1NC2
 X1kEgJc76DLRZQKvidNdWDVHMN1JFAGeugXFRQg4+aUjl/3aHtALWRQECOAECi0d54iO9k0c1LF
 5xvpAcNANOZWLul3rT9wxDjKgp3EFI8ElUeHKLohGkYO+qnS8z0MinaH6NsvJX6yNoD7xTFhft6
 y1mkl5lqQSIhOqwYq0L56gHn9uYiThZvgYguOIjVbGd5v9j4+MudD5PzL4CLrNvQbYdeWFbhjLi
 z5qKyjgZ9UC43y+hIAzjLBY0GZZ4LwITMkvJUsPLCKeAaW7naGh7gNWY2i/WxCZ/8wkKXgMekiA
 Ny/pVgd4ggXjSLiuZMQqeBoyVdtsCArVwQ4HZhVHAUYJQHS4A/kViJQ3HIpM8xdrHhi9Db3WKeK
 v+m1uVr1I3dCaOOryMFrjL1VJ7XVIxx+CugSiXyECLz8WyVgtHziG79Pzw3eWJvVi6lSihUjO+D
 ED3QfjM0qR53DaAllJLAt8sE8UN7
X-Received: by 2002:a05:600c:64c6:b0:49e:6581:7baf with SMTP id
 5b1f17b1804b1-4bb887c3412mr92358195e9.2.1795205612414; 
 Fri, 20 Nov 2026 12:13:32 -0800 (PST)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884ab091sm160538705e9.11.2026.11.20.12.13.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 12:13:31 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E26165FBB2;
 Fri, 20 Nov 2026 20:05:12 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>
Subject: [PATCH 15/22] scripts/get_maintainer.py: add
 --list-absent-maintainers-since
Date: Fri, 20 Nov 2026 20:05:03 +0000
Message-ID: <20261120200511.822573-16-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261120200511.822573-1-alex.bennee@linaro.org>
References: <20261120200511.822573-1-alex.bennee@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
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

Previously people had their own scripts for cleaning up MAINTAINERS so
we might as well bake the functionality into it here.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 scripts/get_maintainer.py | 80 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/scripts/get_maintainer.py b/scripts/get_maintainer.py
index f164e2c5c55..55f961c857a 100755
--- a/scripts/get_maintainer.py
+++ b/scripts/get_maintainer.py
@@ -24,6 +24,7 @@
 from git import Repo
 from collections import Counter, defaultdict
 from csv import writer as csv_writer
+from datetime import datetime, timezone
 
 #
 # Subsystem MAINTAINER entries
@@ -572,6 +573,77 @@ def dump_maintainers_csv(src, maint_sections):
             last_contrib.get(name, ""),
         ])
 
+
+def list_absent_maintainers(src, maint_sections, since_str):
+    """
+    Pretty print a list of maintainers and reviewers whose last
+    contribution was prior to since_str, or who have never contributed.
+    """
+    people = defaultdict(lambda: {'subsystems': [], 'emails': set()})
+    for s in maint_sections:
+        if s.status not in (Status.ORPHAN, Status.OBSOLETE):
+            for p in s.maintainers + s.reviewers:
+                if s.section not in people[p.name]['subsystems']:
+                    people[p.name]['subsystems'].append(s.section)
+                people[p.name]['emails'].add(p.email)
+
+    email_to_maint = {}
+    for name, data in people.items():
+        for email in data['emails']:
+            email_to_maint[email] = name
+
+    repo = Repo(src)
+    try:
+        out = repo.git.rev_parse(f'--since={since_str}')
+        ts = int(out.split('=')[1])
+        cutoff_date = datetime.fromtimestamp(
+            ts, tz=timezone.utc
+        ).strftime('%Y-%m-%d')
+    except Exception as e:
+        print(f"Error: failed to parse date '{since_str}': {e}",
+              file=sys.stderr)
+        sys.exit(1)
+
+    _first, last_contrib = get_contributor_dates(
+        repo, people, email_to_maint
+    )
+
+    rows = []
+    for name, data in people.items():
+        last = last_contrib.get(name)
+        if last is None:
+            rows.append((name, 'Never', ', '.join(sorted(data['emails'])),
+                         ', '.join(data['subsystems'])))
+        elif last < cutoff_date:
+            rows.append((name, last, ', '.join(sorted(data['emails'])),
+                         ', '.join(data['subsystems'])))
+
+    # Sort most stale first (Never first, then earliest date, then by name)
+    rows.sort(key=lambda x: (1 if x[1] != 'Never' else 0, x[1], x[0]))
+
+    if not rows:
+        print(f"No maintainers absent since {cutoff_date} ({since_str}).")
+        return
+
+    max_name = max([len(r[0]) for r in rows] + [len('Maintainer')])
+    max_date = max([len(r[1]) for r in rows] + [len('Last Seen')])
+    max_email = max([len(r[2]) for r in rows] + [len('Email(s)')])
+
+    header = (f"{'Maintainer':<{max_name}}  "
+              f"{'Last Seen':<{max_date}}  "
+              f"{'Email(s)':<{max_email}}  "
+              f"Subsystems")
+    sep_len = max_name + 2 + max_date + 2 + max_email + 2 + len('Subsystems')
+    separator = '-' * sep_len
+
+    print(header)
+    print(separator)
+    for r in rows:
+        print(f"{r[0]:<{max_name}}  "
+              f"{r[1]:<{max_date}}  "
+              f"{r[2]:<{max_email}}  "
+              f"{r[3]}")
+
 #
 # Argument validation
 #
@@ -628,6 +700,9 @@ def parse_args():
                         action=BooleanOptionalAction,
                         default=False,
                         help="Dump maintainers summary as CSV")
+    parser.add_argument(
+        '--list-absent-maintainers-since', metavar='DATE',
+        help="List maintainers with no contributions since DATE")
 
     # We need to know or be told where the root of the source tree is
     src = find_src_root()
@@ -709,6 +784,11 @@ def main():
         dump_maintainers_csv(args.src, maint_sections)
         sys.exit(0)
 
+    if args.list_absent_maintainers_since:
+        list_absent_maintainers(args.src, maint_sections,
+                                args.list_absent_maintainers_since)
+        sys.exit(0)
+
     # Build array of Path objects representing the files
     if args.list_maintained_by or args.list_reviewed_by:
         if args.list_maintained_by:
-- 
2.47.3


