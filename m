Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F593606A6C5
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 20:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=DVGL9ArZ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUUtW-0003SK-LK; Fri, 20 Nov 2026 15:07:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xUUrM-00018l-Ni
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 15:05:25 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xUUrI-0001sG-5V
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 15:05:24 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4a5b2be99a8so11725615e9.2
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 12:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795205117; x=1795809917; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bFGCt9iT+9nbrFOZekH+hWs9QHdIDJ+cRLdWJfu4b8A=;
 b=DVGL9ArZI773+iX9Gj+Nu+z2W3K1rAjB1U2MiHYuECOMRWlzwuWgwG5ZdreDf3Vg4F
 v9jhMUEvQbZe+Ty6ge7uyyqYOFyU7eIIuy3+N9Mu+Gq2KMb6II0Xk8jPqkbhSr5ENgA3
 9kLrVjD4OXj4+ZBvKMPJBYFoVkgfo5fa0qraTrdYoT2uc1JMe7rYjDyKub5+9k/yudGB
 AJR22crkZ50Fs9fOPDNhxroSrK4K33CBACdcJozvyYre+XeGQ+S/r2hBP+6x3V+BIN8O
 wkBTLF5C9jqospEgRnh0wh9WxhAtRNcuW1zZPuQBzkvLtPUFJ3d8dTlGX2PfmOfL50il
 u97Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795205117; x=1795809917;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bFGCt9iT+9nbrFOZekH+hWs9QHdIDJ+cRLdWJfu4b8A=;
 b=GwOTQHHRn+wTeK5cEUcG0qeAA+nuyLpbYxfKo5pyZvIPlIR5130zAsQSrI/vXSvTZS
 msFgoiDdvGQnYZqbXqR2pWKqf19j6GK4nVtWRXvzNpncJNNTiagg/sOT2yC6Lezt/7ZY
 /NU6JOW7s1qeFXxK5cVpxM2xyn9NVuuqCSQO3Y+3rd9ILwgdKzDbAlr+S8gpqcOVmqri
 5PPqkQWHSfOpjDcDu0W+TFUyM7JJfQ60knsSbZW1i9cmvtfajTq8HqNptKEyyKVeH/Bj
 a89pINRxU8zl/sFJVN+iTQxQNjrBUwCCi6XZbXqnWrmFHBjqUlbR6KvS6aamE8Hioo1C
 3vyQ==
X-Gm-Message-State: APuU4Z9i791gI1Hzi90I8HiTpX5AkMc0Al+X/sJSZ/DToeHPr34ModgL
 meMHqT3tQ3LpJJEQzjPnwsOxBR6WjJ/kygbWd2eyhT9FC9MeO37oFRS3eeRQINm7fdw=
X-Gm-Gg: AYBFou1GvyVzum7xcS+/sdqhbEybH5GGQwAEo8DUGDd98RdZHUBJ5xu5++gPqUYa3Ft
 PG7kr0YNlz5jPO3l3dAu1QhxC4pb6keOVsIZbrLeX4pXAnFAdaYKE2TT9XqvJ3OiVZ3BkzetSdD
 cXStI4dKKYzHIwJzZ4JzgG9mIz695L7yeBnjViPLB5H4R+6/LBH07RBRui1lTQY3OxagwrQ5wP5
 Bl9vfwj+qTNDwlQbMnR/Li4GkYHWBOw/ENg7hfR6Imozd8Wk1dZgs7qhIKt0i8HYlbPJCMLAUT8
 2rTDsqH1ARPH5Rz0SrggYw5JNF7YIjODXeRZUblOMvK3FrseqHGkvniK+w6uqa+mGCCNSG1u9Q4
 XE8UmFxfXPWI7dzftLtQQZbJBO1WEkMNAotqMRi6whgT5lgiOnBRvbwJYEri2lTPn5urSVy5PSG
 KdXyIEz+4cXcxVFDzvUO4oBMDvOxl0LbBF66rE7whY18s8iELmOkS+mqYlRY+Rxv3AceQtdeLIb
 IkAivBB3JdFTJllMOteRtcU+nKhTXDuaIbbT3onrz5s56mFujbr4TkCwBXxND7WDW6qGudTWn9A
 M6yhunyVvV+lS29SlW4GPrL9ifXcazqNk51v47Zbwdgne7iuKA==
X-Received: by 2002:a05:600c:638e:b0:4bb:6c5e:b006 with SMTP id
 5b1f17b1804b1-4bb887e265fmr94262605e9.3.1795205117110; 
 Fri, 20 Nov 2026 12:05:17 -0800 (PST)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb9067846esm10308455e9.4.2026.11.20.12.05.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 12:05:14 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E9A845FA2E;
 Fri, 20 Nov 2026 20:05:11 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>
Subject: [PATCH 05/22] scripts/get_maintainer.py: add support reading patch
 files
Date: Fri, 20 Nov 2026 20:04:53 +0000
Message-ID: <20261120200511.822573-6-alex.bennee@linaro.org>
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

Not so different from individual files, we just need to parse the
patch looking for the files and add them to the list. As we can parse
multiple patches we also need to ensure the final list of sections is
unique so we don't repeat ourselves.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 scripts/get_maintainer.py | 41 +++++++++++++++++++++++++++++++++++----
 1 file changed, 37 insertions(+), 4 deletions(-)

diff --git a/scripts/get_maintainer.py b/scripts/get_maintainer.py
index 8a018042952..597db64ea16 100755
--- a/scripts/get_maintainer.py
+++ b/scripts/get_maintainer.py
@@ -16,6 +16,7 @@
 from pathlib import Path
 from enum import StrEnum, auto
 from re import compile as re_compile
+from re import sub as re_sub
 
 #
 # Subsystem MAINTAINER entries
@@ -197,6 +198,29 @@ def read_maintainers(src):
 
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
@@ -321,13 +345,22 @@ def main():
     if args.file:
         files.extend(args.file)
 
+    if args.patch:
+        for p in args.patch:
+            pfiles = extract_filenames_from_patch(p)
+            files.extend(pfiles)
+
+    # unique set of maintainer sections
+    maintained: set[MaintainerSection] = set()
+
     for f in files:
         rf = f.relative_to(Path(args.src))
-        relevent_maintainers = [ms for ms in maint_sections if
-                                ms.is_file_covered(rf)]
+        fmaint = [ms for ms in maint_sections if ms.is_file_covered(rf)]
+        for m in fmaint:
+            maintained.add(m)
 
-        for rm in relevent_maintainers:
-            print(f"{rf}, {rm.section}")
+    for rm in maintained:
+       print(f"{rm}")
 
 
 if __name__ == '__main__':
-- 
2.47.3


