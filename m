Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADBC4D74EEB
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 14:58:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjIc8-0004OJ-Va; Fri, 23 Jan 2026 09:58:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vjIby-0004Hy-0f
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 09:58:11 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vjIbw-0007nx-72
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 09:58:09 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-4359a302794so1492836f8f.1
 for <qemu-devel@nongnu.org>; Fri, 23 Jan 2026 06:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769180287; x=1769785087; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IT3Cl5TxUGOEN1KCEW5Qrx+OBPZ2zVw+Msa0gwSUxR0=;
 b=OggqncRYBUfP4c1e0OwDkRn1CqQTqSqjs8soK73D6sfbfT/c683zEMzF85iQeDDtE2
 CJdHX/0vUY+A6ZDlZ2gw3DKXI2YyhkviOCt5tNB7KRYIpDm9mG1Sk03e+YKKCr/7UztQ
 XyrtL4boYcWxtTyzkI+Gxa8tvMaWRJ+IeEATRDu8x34rxJoLaCqR+tjAEkBH82usr/YP
 DGbzhkW/MQjbuqDAGlYN/9gCHRmdosRKK4xL25+h+jIpsH/qpDEBbX32Gufi/GUfImd4
 gic1DqnDtV/fgtDlXUEXucE0njGzrdLwAn6L/v7SwI6k0rBQtNuizH9sh/WEhqi5NVPX
 l/NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769180287; x=1769785087;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IT3Cl5TxUGOEN1KCEW5Qrx+OBPZ2zVw+Msa0gwSUxR0=;
 b=SEk4pHtJGwk7QY/LgDtSU2reHzQlgPT61kquzsD2ti/p81oLqjYm2Mc/iQVxNNX0Jn
 ceBruLPkkYIker82K6TgdiZV8jdOyOTRKbCvN2LAPaMRkan88x1PLUuh115jxKCMxLcQ
 LsolGnONFuw0+eDHCnNbdpuw9j+ov0HBDRpJilK0oUa8yFmnjwQh4OHpBozSqJAgEo9b
 XleOVZ4DPTW54gxF9gGLiq3kG/oNgnY5TJNB4mOXWKtvE8utA0H1+ol8/pONAkUC6+tO
 qrCaj4KoP1CK5m9n4i+HLZRqiacdJIeCzy4ncx37OHui4OaFB54xHC2+wz6fz1Zs8iob
 gI8A==
X-Gm-Message-State: AOJu0YzFJHW6LnnSbNOCLL0PJBQnuZj9U1PqXfdsdYy406trmB+9YciX
 b71buhn7tIxfepdqziZMHklVIpvvKDjQW9RI86+HfVxkE4p1WA1dd99tZsK3b6BnzvI=
X-Gm-Gg: AZuq6aIxVcsxPLrxBq2Ssa0xd5GA0w1dpePbW/LtiNlC/NfrfMd4gbcP93oyxSV7jYr
 9Htq+71XszgtLahI43lXRjOG7ROabmzax24T1eX81C2Bi5goNRvz3C4Jv8EJaqCbepGYjDFnSEI
 3JbZfh/za6htmf94jE7jNwWhUIET+2n2Z4l4Cy0efY386NsAIhFwugGF7Fx/h5TesT95dq1AI2h
 mBKbGvr55/iF5svjHmMcbP2+xJowy62lprOVeLuIbrssK9giCk/dTiW8BpOsxhHHvZLTMKngczO
 Tg0FQv0aipsyaRw2MRUPI2VbbZ5Pg/KoiOcdiF13lrQmy5npJQLddkB+llMxOnWke1tBsO58JvN
 WombGgv/P7PuCB0HTSi62pzahwE+JwHEJdzamFRlJe/CCFymL+hO1cfOKF0F4vqpxl9XejLZUdE
 7R27224el45Lsf
X-Received: by 2002:a05:6000:601:b0:430:fdc8:8bbd with SMTP id
 ffacd0b85a97d-435b16039damr5434643f8f.41.1769180286534; 
 Fri, 23 Jan 2026 06:58:06 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1f7b41asm7647730f8f.39.2026.01.23.06.57.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jan 2026 06:58:04 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id AE8F95FAD9;
 Fri, 23 Jan 2026 14:57:51 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Joe Perches <joe@perches.com>, John Snow <jsnow@redhat.com>
Subject: [RFC PATCH v2 14/16] scripts/get_maintainer.py: add keyword (K:)
 support
Date: Fri, 23 Jan 2026 14:57:47 +0000
Message-ID: <20260123145750.1200879-15-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260123145750.1200879-1-alex.bennee@linaro.org>
References: <20260123145750.1200879-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x429.google.com
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

We use the regex module to stay compatible with the Perl compatible
regex used in the MAINTAINERS file.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 scripts/get_maintainer.py | 36 +++++++++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/scripts/get_maintainer.py b/scripts/get_maintainer.py
index f46d8f6e073..b41f5342876 100755
--- a/scripts/get_maintainer.py
+++ b/scripts/get_maintainer.py
@@ -16,6 +16,7 @@
 from enum import StrEnum, auto
 from re import compile as re_compile
 from re import sub as re_sub
+from regex import compile as prec_compile
 
 #
 # Subsystem MAINTAINER entries
@@ -124,7 +125,8 @@ def __init__(self, section, entries):
             elif tag == 'W':
                 self.web.append(data)
             elif tag == 'K':
-                self.keywords.append(data)
+                match = prec_compile(data)
+                self.keywords.append(match)
             elif tag == 'T':
                 self.trees.append(data)
             elif tag == 'X':
@@ -160,6 +162,15 @@ def is_file_covered(self, filename):
 
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
     """
@@ -194,18 +205,22 @@ def read_maintainers(src):
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
+    Read a patchfile and return the message as a string and a list of files which are modified by
     the patch.
     """
     file_list = []
+    msg = []
 
     with open(patchfile, 'r', encoding='utf-8') as f:
         for line in f:
+            msg.append(line)
             m = patchfile_re.match(line)
             if m:
                 # strip leading [ab]/
@@ -213,7 +228,7 @@ def extract_filenames_from_patch(patchfile):
                 as_path = Path(path.abspath(stripped))
                 file_list.append(as_path)
 
-    return file_list
+    return (msg, file_list)
 
 #
 # Helper functions for dealing with the source path
@@ -335,13 +350,16 @@ def main():
     if args.file:
         files.append(args.file)
 
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
         fmaint = [ms for ms in maint_sections if ms.is_file_covered(f)]
-- 
2.47.3


