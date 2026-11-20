Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31735606A33C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 20:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=TN3EDQvm
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUUrv-0001LO-Uv; Fri, 20 Nov 2026 15:06:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xUUrI-00017i-GB
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 15:05:20 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xUUrE-0001rn-DP
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 15:05:18 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4bb64ef5a00so10526195e9.3
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 12:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795205114; x=1795809914; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6vJvZVxBKZzRtbxWnOsgZqyRwKJ20bvpsbw2Y7ZSf0Y=;
 b=TN3EDQvmiz4JVh53EwCaeIiEuG9oM/KQ5llyBSFvx49Lm3kMb++QZGvzeuNFuNj0nM
 LP7zqSf4jrk3J8WTye7CbOVkc1UFHEZbPgChQZ7AAq8PDVtCTrJFCZMhW1TGbGkQs+FL
 28XP1Dg6Dom6RIYJneaFhHaIN585DKOHmPkigXymcOw5KOJ4PYJztsrcai5/nDIQZZfY
 /WyHBO/UYDAincwSg4VFtZS8T110ZuetbK+58qMNxWxpNYip3IczTIsUf8ACljk5IVTS
 XClMB+irz2dxq6VZm5cZyPSMlIFejBA4NxXZbViwyMATmKCO1MjRmTQ4OindOaoOFC2K
 2Hkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795205114; x=1795809914;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6vJvZVxBKZzRtbxWnOsgZqyRwKJ20bvpsbw2Y7ZSf0Y=;
 b=VI1Y4gHuuP40P7Du8c34lFrYK+2t8/ckEPCvg5/ZLjge3vfmvi0qYPcmbBKvbskHJB
 iuVKTKYQc2sr+Vnc1sEKWFTLEER3KZWSfZ7YKNRXZvPjohEfcWvcVztxsdG4BQtS+DCY
 3u0DE2iGtwunLUKsX2PeKFC2uXYWT1sgSA4am4atJKrExLkcfm0DoPN71tWz7c8DRKTB
 rFKjqgWGAMg6pjrYx7hml9MDYC24GFro2Aior0vPKOhvo2zLvy7Mfwe1ZRYrvuSK2jJt
 SBkcnMPIBRAoQq84Jquekj6VxZM/RwcxSG4ntZRXt3+Svj7I8BhSNXlN1JLURqZxW7c5
 bcRQ==
X-Gm-Message-State: APuU4Z9NUUZzKoxSg/eQ0e83U+hXhIOq2L7tNbKC4RI5mlGvC34mkMvI
 0a4eCTcXdSl1NXRUTE5d7fHdfkf3MX80KFYG8+0ouTxdGxg09zp85U9r3O9ldK70Zwg=
X-Gm-Gg: AYBFou2zI4qqWEXJUBTHhoBCGyy6I3Z7FRh+dd9OkgBmAhSDTwCcujSiHnq2fql8wtS
 8hJtynWtrR6T2bYEKLCjt2x6LP9yvquG2JfPb69Idt7pCtAVV5jF9bzrFuMUbaVLHEhd68mSWvE
 rdWhujcdLxugbKMh+cDvuJOGV2L/0rp9KnjuXK50ughpPvLjUjyx5qkRg/777+fVFMDp4FnB+Ua
 NFy/Rh0OY/4Tyms5N4t5j2HMuOjla1UUN3SL19vXDo4MG6YO4rCrgEkfU87ASPvDMrj+RrEDkbO
 xeozGSfN2i08MqqUsGUFmghxPdlNIoBCuXWu+5/dOy+IO6Ajnf00JzNEtqxz/mbNP+Ag2fSAZG8
 MClO85neQ7wiPC98O+uo79f/gFo9a1RQJlkliwt5SPuX8hcR5BKZdkcWMaUfAoHPbsyNGTZrvY6
 FdPpQRyYSOdIgfAK4bNSFIEOPl7L4B97QD7rWS3Fc4+Fweoynh9wkIk2/J7LQDIZ42uV+nHiSoI
 z5gu/LBsquTh4Mg6jeBfD1A6d62y6s6G1H+wQ4OloFM8UGXHEBJNzh/TGgrVkJ1XFEuimLIiHO9
 vH8sm/XpxwPd7fsWPcHkqHZuxtDN
X-Received: by 2002:a05:600c:5249:b0:4bb:665c:a078 with SMTP id
 5b1f17b1804b1-4bb8893a89bmr93920215e9.28.1795205113705; 
 Fri, 20 Nov 2026 12:05:13 -0800 (PST)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884865b1sm111302915e9.5.2026.11.20.12.05.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 12:05:12 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A5BB85F9D9;
 Fri, 20 Nov 2026 20:05:11 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>
Subject: [PATCH 02/22] scripts/get_maintainer.py: resolve the source path
Date: Fri, 20 Nov 2026 20:04:50 +0000
Message-ID: <20261120200511.822573-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261120200511.822573-1-alex.bennee@linaro.org>
References: <20261120200511.822573-1-alex.bennee@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
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

We will need this to automagically find MAINTAINERS. Use the same
logic as the perl script by looking for expected files and
directories.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - don't hack add_argument twice just to display default
  - whitespace fix
  - don't default to required
v3
  - fix conflicts from parse_args()
  - return src in a Path()
---
 scripts/get_maintainer.py | 71 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/scripts/get_maintainer.py b/scripts/get_maintainer.py
index 47673a5013f..794e96d4ae8 100755
--- a/scripts/get_maintainer.py
+++ b/scripts/get_maintainer.py
@@ -15,6 +15,60 @@
 from pathlib import Path
 
 
+#
+# Helper functions for dealing with the source path
+#
+
+
+def is_qemu_src_root(directory):
+    """
+    Checks if the given path appears to be the root of a QEMU source tree,
+    based on the presence of key files and directories.
+    """
+    if not path.isdir(directory):
+        return False
+
+    required_files = ['COPYING', 'MAINTAINERS', 'Makefile', 'VERSION']
+    required_dirs = ['docs', 'linux-user', 'system']
+
+    for f in required_files:
+        if not path.isfile(path.join(directory, f)):
+            return False
+    for d in required_dirs:
+        if not path.isdir(path.join(directory, d)):
+            return False
+    return True
+
+
+def find_src_root():
+    """
+    Walks up the directory tree from the script's location
+    to find the QEMU source root.
+    Returns the absolute path of the root directory if found, or None.
+    """
+    script_dir = path.dirname(path.abspath(__file__)) # FIXME, breaks python-send-buffer
+    current_dir = script_dir
+
+    while True:
+        if is_qemu_src_root(current_dir):
+            return current_dir
+
+        # Move up to the parent directory
+        parent_dir = path.dirname(current_dir)
+
+        # If we reached the filesystem root and haven't found it, stop
+        if parent_dir == current_dir:
+            break
+
+        current_dir = parent_dir
+
+    return None
+
+#
+# Argument validation
+#
+
+
 def valid_file_path(arg):
     """
     Checks if arg exists and is a regular file or raises ArgumentTypeError.
@@ -26,6 +80,16 @@ def valid_file_path(arg):
     return Path(path.abspath(arg))
 
 
+def valid_src_root(arg):
+    """
+    Checks if arg is a valid QEMU source root or raise ArgumentTypeError.
+    """
+    abs_path = path.abspath(arg)
+    if not is_qemu_src_root(abs_path):
+        raise ArgumentTypeError(f"Path '{arg}' is not a valid QEMU source tree")
+    return Path(abs_path)
+
+
 def parse_args():
     """
     Create and parse the arguments.
@@ -39,8 +103,15 @@ def parse_args():
     group.add_argument('-f', '--file', type=valid_file_path, nargs = "+",
                        help='path to source file(s)')
 
+    # We need to know or be told where the root of the source tree is
+    src = find_src_root()
+
+    parser.add_argument('--src', type=valid_src_root, default=src,
+                        help=f'Root of QEMU source tree{" (default: " + src + ")" if src else ""}')
+
     return parser.parse_args()
 
+
 def main():
 
     args = parse_args()
-- 
2.47.3


