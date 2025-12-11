Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9209FD41C24
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 18:02:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTkzC-0000mE-Ko; Thu, 11 Dec 2025 13:01:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vTkz4-0000ff-Nw
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 13:01:46 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vTkz0-00060y-Pj
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 13:01:45 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-42b47f662a0so254984f8f.0
 for <qemu-devel@nongnu.org>; Thu, 11 Dec 2025 10:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765476100; x=1766080900; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LidZloD1YOJfGlaIqFd+HDx8s5jEhhnCWmmrV/Nz338=;
 b=sHJT2tNbLdTH+q5xZL8JEPhhV0A2keyXRUNipY4lPl/KuZDlQ4Z5MST4xLmLwdUcGL
 85xbdeN3dKjZnKcPpGdNGg+kjcds6f12vj9kQW5jWsesR4rTeUUPGBXhNFRUvde6Ws60
 Kvu3aXd2FRsDjljhFt5iZ772JDMqCKDMvtOrykOYp0cNZBS5HWnVNZACRM1sOTzvG8eA
 z2KXHAS6iqYKJ3yfcTolNG3VbgzheuVES5jvHc9qXhxMU5EPk5yIsGRocFTDxRujvAvF
 brDZx/UgJxIenK4uHjfnvGHW9D7Rjti9LTnbIv9l904+scKF9D7PfzENQQaEvYky5a3Q
 MFug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765476100; x=1766080900;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LidZloD1YOJfGlaIqFd+HDx8s5jEhhnCWmmrV/Nz338=;
 b=XgXInxLeobD0JTcfvlzJljheirtyFQWJDsBQcH/6Dp7HKcZPHWpOX49+khyPKNqzuZ
 MPxWwUaQu0vQIxhvR0EY6/7JMTwGgKilbSORrPhu7LrJy/i2fBUNT8b0MlMcDtPiZjmx
 xVrDd0nMYX8BNgrsVDhng2aAYuQRmlN/jVcPxDtXNmDWdlk5fewZgtugVaRp3sYikMJt
 zFTkpFaSCjorZV4Q8SR3O7YO4XbQgwzL7CpOjpeIhxHQBzb58zpnxxwJVPI+ZX1KNn3g
 xjpQ8Skjk6YBDZ8j6izxS/ZvFGvAkxCBx8E9fW34Av5CctSsyFIggECjGW+DocpHVB1Q
 jCyQ==
X-Gm-Message-State: AOJu0YwUybj/oR/c6pIQqcANc+7G3oNClWMm7qj18TnNTlOU1jvO1+Y7
 fLB2M4K8sq0NPOLVlYJ0aRDWMPHyyUfM7mqIi9GMa1SH8+35SZlv36PpZvWoHrvPxvk=
X-Gm-Gg: AY/fxX4xeuPK2DrEftTzUqXe+NlYC+1a41whP+3jSvUxQWPPptoW9GVEu78kGP1Y/Lc
 ojGQEjUN8/KBICKopLDQeReLwAT+bkTWx/fxFHH6Z4zeci78FQLLLCdDHp15Np+wDZhRy/vrLuq
 uBn28Y9bWbI4WpEYAF2YJl1p2UiV33hyu+TEljalhk78OVSJOcjnsAnT4Rp27usekeLgwdjBWXm
 wspdsauTOGdaG+ptivH/pBstPiU0XhcNHScVy02R2Ja1AeUYDgtWAhXA6COTx8F+xHpaubRSBpS
 lsKmrnJH1j1h1MbeUGV5h6InH77yBLDXFfhUmIAllCMSg19OnbWSXZFj4eLGExYz+DNA1L26kpy
 nqsuotC+nxz16AkMCDqXDhwh/ZuQTLLnLw4FAcc2c7wIaeRsgptBKiX/cl4jn7brMRTtNVhOtsh
 k8+sqE2oBPRWo=
X-Google-Smtp-Source: AGHT+IFzdkqmGlzmCjDTC7QqrtJPRwCSWmgSvoFYb0mNxPz2tNOIee+DiLxvG3GJ2tvPAY2BNxGgzw==
X-Received: by 2002:a5d:5f88:0:b0:42f:8817:7ee with SMTP id
 ffacd0b85a97d-42fab28c9b3mr4134595f8f.31.1765476098785; 
 Thu, 11 Dec 2025 10:01:38 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42fa8b9b259sm6863545f8f.41.2025.12.11.10.01.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Dec 2025 10:01:36 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 53FD35F943;
 Thu, 11 Dec 2025 18:01:33 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>
Subject: [RFC PATCH 8/9] scripts/get_maintainer.py: add support reading patch
 files
Date: Thu, 11 Dec 2025 18:01:31 +0000
Message-ID: <20251211180132.3186564-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251211180132.3186564-1-alex.bennee@linaro.org>
References: <20251211180132.3186564-1-alex.bennee@linaro.org>
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

Not so different from individual files, we just need to parse the
patch looking for the files and add them to the list. As we can parse
multiple patches we also need to ensure the final list of sections is
unique so we don't repeat ourselves.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 scripts/get_maintainer.py | 47 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 42 insertions(+), 5 deletions(-)

diff --git a/scripts/get_maintainer.py b/scripts/get_maintainer.py
index bf45865438e..daeefecef64 100755
--- a/scripts/get_maintainer.py
+++ b/scripts/get_maintainer.py
@@ -15,6 +15,7 @@
 from pathlib import Path
 from enum import StrEnum, auto
 from re import compile as re_compile
+from re import sub as re_sub
 
 #
 # Subsystem MAINTAINER entries
@@ -187,6 +188,29 @@ def read_maintainers(src):
 
     return entries
 
+#
+# Helper functions for dealing with patch files
+#
+patchfile_re = re_compile(r"\+\+\+\s+(\S+)")
+
+#TODO: also return a list of keyword hits for K:?
+def extract_filenames_from_patch(patchfile):
+    """
+    Read a patchfile and return a list of files which are modified by
+    the patch.
+    """
+    file_list = []
+
+    with open(patchfile, 'r', encoding='utf-8') as f:
+        for line in f:
+            m = patchfile_re.match(line)
+            if m:
+                # strip leading [ab]/
+                stripped = re_sub(r'^[^/]*/', '', m.group(1))
+                as_path = Path(path.abspath(stripped))
+                file_list.append(as_path)
+
+    return file_list
 
 #
 # Helper functions for dealing with the source path
@@ -305,14 +329,27 @@ def main():
         print(f"loaded {len(maint_sections)} from MAINTAINERS")
         exit(0)
 
-    relevent_maintainers = None
+    # Build array of Path objects representing the files
+    files = []
 
     if args.file:
-        relevent_maintainers = [ms for ms in maint_sections if
-                                ms.is_file_covered(args.file)]
+        files.append(args.file)
+
+    if args.patch:
+        for p in args.patch:
+            pfiles = extract_filenames_from_patch(p)
+            files.extend(pfiles)
+
+    # unique set of maintainer sections
+    maintained: set[MaintainerSection] = set()
+
+    for f in files:
+        fmaint = [ms for ms in maint_sections if ms.is_file_covered(f)]
+        for m in fmaint:
+            maintained.add(m)
 
-    for rm in relevent_maintainers:
-        print(rm)
+    for rm in maintained:
+        print(str(rm))
 
 
 if __name__ == '__main__':
-- 
2.47.3


