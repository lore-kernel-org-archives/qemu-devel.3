Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E489606A6E9
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 20:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=SHCejFkh
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUUri-0001Jn-TO; Fri, 20 Nov 2026 15:05:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xUUrK-00018H-50
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 15:05:23 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xUUrG-0001s5-6Y
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 15:05:21 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-48dfc0421d9so1256374f8f.1
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 12:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795205116; x=1795809916; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+vY10cC3QN7kEcVd1hwXNxFZPVHdyt2YGh8opEu0YvU=;
 b=SHCejFkhYViYNeB04YK480qG66YThnUdHu1JRztvHIKaTNVUHon6mvsjv0QrzDNFjR
 S0WBwaGiaJGNdJur4/XAHyE62CTPhT6hal2B4M1/1IRb/sl79CP6T0NR+Yl6dE27RJEO
 8PO+AXKS8Pf19Cgz9pkxJwv02uq5kNYvZAkAcDiyXr8NAOAwEE7EzAYeRsjV84zt4PNr
 6J8mLDJerx4V5NWTU2ymbHBP+yj7sj4ctFCri6MHboU9I5ddizWtPreQ05CU+IpdOr77
 e1uM7P+/5mywz1Crgum5ztsF6mX9H3PLVnFnKSAR9nrdeWUYklUrolIBHJzXVNWz7GAM
 WbPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795205116; x=1795809916;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+vY10cC3QN7kEcVd1hwXNxFZPVHdyt2YGh8opEu0YvU=;
 b=saXMHrGMs85showwG/KOX54gYOMhVapdE511+G0tlM6smZArya9ULWoZKaB9o6rG6z
 UWZ48rLdYdLfSrYi2WAgcGcs4HbCFDpxyfP/m8RMfmaDYP82AkwhZ/lClYXffFNeHGtg
 kCln1tzN4iP/MTfNsyoqprYDgT3jRVZvgWKaB/b7ZxhJb2Tp65gcrAlIYdoJNWWLg5Sh
 tVYUuLde46D29J+HX1vfZ+Ie8Zdm6XGX4w4uIuHbhVLovOS9BSZqlV3fgIvLuCLCc3oJ
 Ft4prsIczlb/qcPYOKVVhPU3bdiBMGrnN280mdTU+1IPlB3oQgzIYBoeHe36DHFGnp+4
 T2Bw==
X-Gm-Message-State: APuU4Z/+S4BQ6eG5Wxxd8BimagusmjnpRyDgNftPa2hdhs669vkSy+su
 OwA0UusQwcLrEML1KOHMRyvtzsZMWkb2QZqsMk7JELMwnlIncxgkEYpY1s1C/y0MIUQ=
X-Gm-Gg: AYBFou2UePNXHtiBQNJykjb7OwOcFmFgkx1aNmWrnxkqv2OXL58KpQPWuUhSbTyWyfU
 UK8RJJ1vkvL/TBmjIM1vRAhuITg/RrbG6SAzuHJqMVpFcCl9Sp1TdFsSoN1XTFrIUPF4PQ3ZeyN
 bAzhJa/xs3n+6reGGonIWRZlSpLuZCLgkjj/82PIvelNgJQrCW9nBQ42vrn6kBS9XEwu3jQ9XlD
 W5/IeZppKE+HbZzZRYmTsvv1KhK+p27vtr2tM9uWpUsYLmybJQZ5E+M9vk73ki9fWiQfkZZ76W4
 5l8Pn4OgdhZM+aikRrDW9Y6jDXJaY+brdxqDIdlF9yryaqby+V9iGACtxiKxoHiNSbB5pOhJsCh
 i5id6QeDXSC4oFMnhJ5DgPhBWPtjF9rt6cRx+D5xvJR7/JpzIl/ssJ+dRgCseLGPRtJPv9HBqCN
 8XfFy7Rl37pP9J2ihGBA9ns+j9gFiShRsMF+NALlIfuYClEXNx2IZN/ti7STy2HHRt3I4D0kMNc
 QZ4U5TCQtahcGuTxKfTw4JcB7ukcwQwjSKCji4jRIgjniXDrCMg6v/gA1/di6JKVlSk7hAEb9az
 836l+kDRMV9rvTqDenieOir7agHL5AlPO6SYrWzlSLKhPilJVQ==
X-Received: by 2002:a05:600c:1993:b0:4bb:8711:fcb9 with SMTP id
 5b1f17b1804b1-4bb88941bcemr90158275e9.33.1795205116075; 
 Fri, 20 Nov 2026 12:05:16 -0800 (PST)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab69bf680fsm8412145f8f.14.2026.11.20.12.05.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 12:05:14 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0DD945FA3D;
 Fri, 20 Nov 2026 20:05:12 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>
Subject: [PATCH 06/22] scripts/get_maintainer.py: add keyword (K:) support
Date: Fri, 20 Nov 2026 20:04:54 +0000
Message-ID: <20261120200511.822573-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261120200511.822573-1-alex.bennee@linaro.org>
References: <20261120200511.822573-1-alex.bennee@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x434.google.com
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

We use the regex module to stay compatible with the Perl compatible
regex used in the MAINTAINERS file.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 scripts/get_maintainer.py | 38 ++++++++++++++++++++++++++++----------
 1 file changed, 28 insertions(+), 10 deletions(-)

diff --git a/scripts/get_maintainer.py b/scripts/get_maintainer.py
index 597db64ea16..443fbf8e875 100755
--- a/scripts/get_maintainer.py
+++ b/scripts/get_maintainer.py
@@ -17,6 +17,7 @@
 from enum import StrEnum, auto
 from re import compile as re_compile
 from re import sub as re_sub
+from regex import compile as prec_compile
 
 #
 # Subsystem MAINTAINER entries
@@ -126,7 +127,8 @@ def __init__(self, section, entries):
             elif tag == 'W':
                 self.web.append(data)
             elif tag == 'K':
-                self.keywords.append(data)
+                match = prec_compile(data)
+                self.keywords.append(match)
             elif tag == 'T':
                 self.trees.append(data)
             elif tag == 'X':
@@ -162,6 +164,15 @@ def is_file_covered(self, filename):
 
         return False
 
+    def patch_contains_keyword(self, patch_lines):
+        "Does patch contain keyword covered by this maintainer section"
+
+        for l in patch_lines:
+            for k in self.keywords:
+                if k.findall(l):
+                    return True
+
+        return False
 
 
 def read_maintainers(src):
@@ -201,18 +212,22 @@ def read_maintainers(src):
 #
 # Helper functions for dealing with patch files
 #
+
+
 patchfile_re = re_compile(r"\+\+\+\s+(\S+)")
 
-#TODO: also return a list of keyword hits for K:?
-def extract_filenames_from_patch(patchfile):
+
+def process_patch_file(patchfile):
     """
-    Read a patchfile and return a list of files which are modified by
-    the patch.
+    Read a patchfile and return the message as a string and a list
+    of files which are modified by the patch.
     """
     file_list = []
+    msg = []
 
     with open(patchfile, 'r', encoding='utf-8') as f:
         for line in f:
+            msg.append(line)
             m = patchfile_re.match(line)
             if m:
                 # strip leading [ab]/
@@ -220,7 +235,7 @@ def extract_filenames_from_patch(patchfile):
                 as_path = Path(path.abspath(stripped))
                 file_list.append(as_path)
 
-    return file_list
+    return (msg, file_list)
 
 #
 # Helper functions for dealing with the source path
@@ -345,13 +360,16 @@ def main():
     if args.file:
         files.extend(args.file)
 
+    # unique set of maintainer sections
+    maintained: set[MaintainerSection] = set()
+
     if args.patch:
         for p in args.patch:
-            pfiles = extract_filenames_from_patch(p)
+            (msg, pfiles) = process_patch_file(p)
             files.extend(pfiles)
-
-    # unique set of maintainer sections
-    maintained: set[MaintainerSection] = set()
+            kmaint = [ms for ms in maint_sections if ms.patch_contains_keyword(msg)]
+            for m in kmaint:
+                maintained.add(m)
 
     for f in files:
         rf = f.relative_to(Path(args.src))
-- 
2.47.3


