Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2395560A260B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 20:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=xfX5giId
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUUtO-0002m5-I4; Fri, 20 Nov 2026 15:07:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xUUrM-00018m-Sv
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 15:05:25 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xUUrJ-0001t3-Tj
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 15:05:24 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-4a358881793so720163f8f.0
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 12:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795205120; x=1795809920; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=z2kFpE0C+lXr/H0GvwmT9pPfQ6YqOL7EnJXbOGH3WGA=;
 b=xfX5giIde5cWlTwN4az4mglKCDAIeMH9JSDWFzaLqpIthBuYHtDqfPI35ST4rbGEOC
 I51G9fGQS6VPebN9QBcKBlNheWWsnr/iwCykh2cBA4qXr2hhkqxMis4wvGm/nijG1znu
 Ow7DQZY3rJAxHNZsmBod6x07uImTnNAeWX+rgFjWdvvDQ1kwDvC0wfNg4yhUXN1nnnXI
 oYKg1bKz6ZdJ3dvomt21t48DXQkvXfzF24X42Qr+2H4qVRpNOAoc+UPlj4p+7tsFyaAf
 jX9Et5mmQdABz7n0cFqUxODNbu/n/rRz7OCtXqA/xPc3wH8jhoYeWVC/297nAV382ZCy
 v9EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795205120; x=1795809920;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=z2kFpE0C+lXr/H0GvwmT9pPfQ6YqOL7EnJXbOGH3WGA=;
 b=GltDVGj3j6vXcJo+Ja0e2uJiL7D672X91pBXUJso5kUmgWglGwJ77PAnNeR2w4lwXG
 TJGWD49Rfo7LZOm/UxEIWonEy+gZ4qhWZtmY25CTZz63lD/FkxohKi047zUo4lDPy0nl
 0b7mdwBdFG4xpztjQLQEXcj0LswOolugftGOV5l80pzd6nYsh3BcSQLOXyGNLiAHFdGD
 6S84c7cU43Hc1Be0KT+WbVu6s0X+43qmAv0ZGT+Eao+zFlO+yChU1xZtxsUImEYY4xmM
 +P0AeSpp7LmuhbgsQGpir0mqNoJACW5c6jhOObmDc5Q0vEjpei4yopS9sTAejo6xmwcS
 9eJw==
X-Gm-Message-State: APuU4Z9nDCmQ7xPE6KdNuiy/TCJj4j+p8QoImnIzYqrnOzaFDHTAZ1lU
 ci9H1028nMBT9ac1alw96pYRutt4+OIhm7AY7XP3hRggNZ8c9Ze/tHzwa6udLpWMO78=
X-Gm-Gg: AZFdTZcw6Hk+cPpMVAJDXY/xyxPFWowgAyV4mGzv4v9g6zM6taK2+bN2LJMbHYRl4s+
 1nQpjvhmIvuc1g5f4dCv+FFbYu89WHz1cnIvcyGrxynjx0bI1GKdMOOKgLzy3xiUfV+jfrZAOtX
 LjEIu3qzOx5xyJCpghcOzVU217V0jzw5TOmOm+SSbKbErxu6SHo43gGcPCK7mAQAQZQq19DYXpL
 QydLrW7113xGnlkzmsaHUfhNW+wMYQwLql4yfPS1n+kxH7L/S6IUjFIbGIgEZVYrgsb0yjPFhhF
 TtxSWQTyXJtDdFVtfYQxdf2ydBlk0b+fVNxIrm02JQ1kYQ2WVI/SvJI96eWraMeKEJqQxbP+g/S
 FmgRq5RDYy20guY9mIOn9OCm1RPn1EfPdAKJIfbP1zMW1m9m2fbn5pM2AdV3L5Q8blHd1fGc+jk
 cYIevObcS4X19IrHoVn8vDjNRp7YnZwCtgy+hEjVpA6EizeOh4t1WlYWu3eklKlqxJ2Hg7J8Etz
 B2YKkJjOjjTlLdq6/fxp4OiINpMdCT6fkP2ZapF2J26FUDst6nQb3G+TmxvHUn6rGm5ACUj189O
 4tBZXeb3+Ly6QjIjQic4h28qvVwn
X-Received: by 2002:a05:6000:2310:b0:4a2:ee0f:4fa3 with SMTP id
 ffacd0b85a97d-4abad6a4224mr10107124f8f.8.1795205119854; 
 Fri, 20 Nov 2026 12:05:19 -0800 (PST)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab69bf61b8sm6868603f8f.19.2026.11.20.12.05.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 12:05:17 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9D1435FB2B;
 Fri, 20 Nov 2026 20:05:12 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>
Subject: [PATCH 12/22] scripts/get_maintainer.py: implement
 --noroles/--norolestats
Date: Fri, 20 Nov 2026 20:05:00 +0000
Message-ID: <20261120200511.822573-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261120200511.822573-1-alex.bennee@linaro.org>
References: <20261120200511.822573-1-alex.bennee@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x432.google.com
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

The main purpose of this is for the git cc script invocation to get a
clean list of email addresses. The handling is slightly different as
we don't force roles to True if rolestats is specified. It
doesn't matter as --noroles doesn't attempt to display stats anyway.

As the default inverted options are slightly different in python
ArgParse I've again added alias options to maintain compatibility with
the perl script.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 scripts/get_maintainer.py | 36 ++++++++++++++++++++++++++++++++----
 1 file changed, 32 insertions(+), 4 deletions(-)

diff --git a/scripts/get_maintainer.py b/scripts/get_maintainer.py
index e56a9238ec2..a3f64a4b2a0 100755
--- a/scripts/get_maintainer.py
+++ b/scripts/get_maintainer.py
@@ -376,7 +376,7 @@ def extract_from_git(git_opts, src_file):
 
     for person, count, percent in ranked:
         role = f"commit_signer: {count}/{len(commits)}={percent:.0f}%"
-        results.append((person, role))
+        results.append((person, role, count, percent, len(commits)))
 
     return results
 
@@ -507,6 +507,18 @@ def parse_args():
     parser.add_argument('--git-min-percent', default=5,
                         help='minimum percentage of commits to tagged as a maintainer (default: 5)')
 
+    # Roles and Statistics options
+    parser.add_argument('--roles', action=BooleanOptionalAction,
+                        default=True,
+                        help="Show roles (default: roles on)")
+    parser.add_argument('--noroles', dest='roles', action='store_false',
+                        help="Do not show roles (alias for --no-roles)")
+    parser.add_argument('--rolestats', action=BooleanOptionalAction,
+                        default=True,
+                        help="Show statistics in git roles (default: stats on)")
+    parser.add_argument('--norolestats', dest='rolestats', action='store_false',
+                        help="Do not show stats in git roles (alias)")
+
     # Output options
     class SetFileSummary(Action):
         def __call__(self, parser, namespace, values, option_string=None):
@@ -593,9 +605,16 @@ def main():
             for m in fmaint:
                 maintained.add(m)
 
+    recipients = {}
     if not args.file_summary:
         for rm in maintained:
-            print(f"{rm}")
+            if args.roles:
+                print(f"{rm}")
+            else:
+                for p in rm.maintainers + rm.reviewers:
+                    recipients.setdefault(p.email, p)
+                for l in rm.lists:
+                    recipients.setdefault(l, l)
 
     # Git fallback
     if args.git or (args.git_fallback and len(maintained) == 0):
@@ -610,8 +629,17 @@ def main():
         for f in files:
             gmaint = extract_from_git(git_opts, f)
 
-            for (person, role) in gmaint:
-                print(f"{person} ({person.format_role(role)})")
+            for (person, role, count, percent, total) in gmaint:
+                if not args.roles:
+                    recipients.setdefault(person.email, person)
+                else:
+                    if not args.rolestats:
+                        role = "commit_signer"
+                    print(f"{person} ({person.format_role(role)})")
+
+    if not args.roles and not args.file_summary:
+        for r in recipients.values():
+            print(f"{r}")
 
 
 if __name__ == '__main__':
-- 
2.47.3


