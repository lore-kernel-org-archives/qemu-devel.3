Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0AF6606A6F5
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 20:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=eXcKwQ1W
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUUrP-00018f-Ct; Fri, 20 Nov 2026 15:05:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xUUrI-00017h-Cc
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 15:05:20 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xUUrE-0001rt-FB
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 15:05:18 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4bb6ba3b244so12305165e9.3
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 12:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795205115; x=1795809915; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=oyzbPI743iRy9+Ha5OOjVC6jUktBEiVSMrlt36AxKx8=;
 b=eXcKwQ1WT+jYT9I0zEBDySAocwvv/nuQJIXTeBZofMX/Ia9Nftl06SxhFlKXQRAmxg
 4MUJ/jS1kWBn6du//x2MlurtC8Hn9jw8LwIMiFa+dpQXWT3WCNIXMAZ450BxM459ulAg
 T25f7Jd0Nb0BlNlDEu2Z4kBGr55hEKsuinHjNHW+A7moPLruBAscNuHtMHc3iqbypFkb
 jSkh438Q7/kFeR5rZ1ST3nssKKomRKKGp7/isUEwNbtzkRig7yzmMb94DUq9GWpcOuOe
 KQoFCsoJp/PzKzqKVdEKBczIWdev2iaJSrNEC0jIKGJjUG193u4suINLAl1rbRES1syw
 A93Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795205115; x=1795809915;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oyzbPI743iRy9+Ha5OOjVC6jUktBEiVSMrlt36AxKx8=;
 b=jSP9fWNhVkTXTZr1HSRJ5ZLr7UniKA+viEsibAA3N42gp/Ob/JyXmMYMmnOJ34VlGk
 XbXE/bkMnHyCgb+TUmc9huUUcDh3oFUOZtH7NIOoxSoY+iGM+3Iu2tZvQJzYinn0vb7D
 t79Kh1sN1X8kJwjBrj6Z4EQjMn7XBNly1CN9JRNKY0txaUVaxlnmqak/kQUxYCSwKLwS
 Vnl0z3fDtCcUcCAYn32ewoyM46bMn/X3xAgQQRIA6Q8Q4piLTlJTdh+ttRHwWWvyf7Iy
 u3hcqlMec4rYXFYTkuPbKqpxmtslD3iBCvcrLfpUyTOadFvuZAQM8wNZNUUxttnsmxuu
 VHGw==
X-Gm-Message-State: APuU4Z8gL75lz7zf+Vr0RO6qSeRGN/3j829IFBgS98dLx1Xe9vzR5MVt
 GJjs40P4/5llqxZhekabdEjAcA8Xk038EeBWgrVgjxzbzjfwc3XjCvHiOVS03NnuVqI=
X-Gm-Gg: AYBFou1skyu6Ij7Tb+k2fvlR+0eofB5oPu6KWficAsXSdLhNpEG8azex1oTU3m4Qw89
 GNtgHWKJoNC6si1KnRUEotTPlFjVYAQL5zsKiFd8bGY6Wk8QHBwhBe4q6B7QeoQa3PbJa+OwQQ2
 5CzxJflBahWAg80Ry1ibk4X4PdWzJ66Gog1FFr8ODWhr9WjYbYqG78shrENGEYKjCv9xIdTmcql
 8KNbKeN1SExrdN1PIKc+OBMzM0gDjCSuc+4BgUgSb4cMWM9MvXhZdK8ydQL8N6Ga4MGflVIYK9y
 m3Q8LMzNuvJAsMmHgKD6RY86OTzI+Wibb96RpkV/sJUGn5Aep9yCF7D910qnUXIBhGOjAAcwZiZ
 Bp5uD8ndm6Czt5UTxMBgM8cR6mqIcE38TGKuOQzYHp4cEGt2+0Wda6ge9UyQDBp09nLhZdAIAMY
 r0Bf2k2lHyCMyPugjZx7guIxeH/JYyhzYzJVBdWz0+6pPuA48P52DWLWevtV3ELLO+O1IWbrylC
 gyHCWH691/JcKInapKH7SRhcRv5rZvmvYSQwv1XJpHzHenKiFUqPyMiF6UOfqcFVj+7g3Bfmo9s
 L9pqjk4ktAWd9xijEIEHXZ6Mb3GI
X-Received: by 2002:a05:600c:848a:b0:4a1:fbd2:f689 with SMTP id
 5b1f17b1804b1-4bb8880993amr93679535e9.7.1795205114983; 
 Fri, 20 Nov 2026 12:05:14 -0800 (PST)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb9067a0e6sm7096495e9.4.2026.11.20.12.05.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 12:05:13 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D48815FA2D;
 Fri, 20 Nov 2026 20:05:11 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>
Subject: [PATCH 04/22] scripts/get_maintainer.py: add support for -f
Date: Fri, 20 Nov 2026 20:04:52 +0000
Message-ID: <20261120200511.822573-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261120200511.822573-1-alex.bennee@linaro.org>
References: <20261120200511.822573-1-alex.bennee@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
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

Now we have our sections we can add support for checking each file
against the maintainer list and gathering the ones we want. Finally we
can print the list out.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v3
  - Path and match are expensive checks
---
 scripts/get_maintainer.py | 45 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 43 insertions(+), 2 deletions(-)

diff --git a/scripts/get_maintainer.py b/scripts/get_maintainer.py
index dcf132856cc..8a018042952 100755
--- a/scripts/get_maintainer.py
+++ b/scripts/get_maintainer.py
@@ -134,6 +134,32 @@ def __init__(self, section, entries):
             else:
                 raise UnhandledTag(f"'{tag}' is not understood.")
 
+    def __str__(self) -> str:
+        entries = []
+
+        for m in self.maintainers:
+            entries.append(f"{m.name} <{m.email}> (maintainer: {self.section})")
+
+        for r in self.reviewers:
+            entries.append(f"{r.name} <{r.email}> (reviewer: {self.section})")
+
+        for l in self.lists:
+            entries.append(f"{l} (open list: {self.section})")
+
+        return "\n".join(entries)
+
+    def is_file_covered(self, filename):
+        "Is filename covered by this maintainer section"
+
+        for fx in self.files_exclude:
+            if filename.match(fx):
+                return False
+
+        for f in self.files:
+            if filename.match(f):
+                return True
+
+        return False
 
 
 
@@ -274,6 +300,11 @@ def parse_args():
 
     return parser.parse_args()
 
+
+def main():
+
+    args = parse_args()
+
     try:
         # Now we start by reading the MAINTAINERS file
         maint_sections = read_maintainers(args.src)
@@ -285,9 +316,19 @@ def parse_args():
         print(f"loaded {len(maint_sections)} from MAINTAINERS")
         sys.exit(0)
 
-def main():
+    files = []
+
+    if args.file:
+        files.extend(args.file)
+
+    for f in files:
+        rf = f.relative_to(Path(args.src))
+        relevent_maintainers = [ms for ms in maint_sections if
+                                ms.is_file_covered(rf)]
+
+        for rm in relevent_maintainers:
+            print(f"{rf}, {rm.section}")
 
-    args = parse_args()
 
 if __name__ == '__main__':
     main()
-- 
2.47.3


