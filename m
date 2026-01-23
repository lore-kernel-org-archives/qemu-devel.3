Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40771D74EDB
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 14:59:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjIc4-0004Lp-UD; Fri, 23 Jan 2026 09:58:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vjIbx-0004HP-Al
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 09:58:09 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vjIbt-0007nH-TV
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 09:58:08 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-48039fdc8aeso12235355e9.3
 for <qemu-devel@nongnu.org>; Fri, 23 Jan 2026 06:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769180284; x=1769785084; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fVSKpNPUZ7Pn8NvtgX597pdEcglY2QSI3FLRYMr2zlE=;
 b=IPppnvoqDgf1+GdoaI+idsrvDrMcJnLKePJEbd3P7/IVCo7T8Qc8NfkdCFCTNxQcTn
 kxTjRL+PCHrg6HAJJFI7nu3sZK3fPo3qGDRmFmqWxGy/gqXvEK33TeSI5S3Xza91R7Z9
 eC4WASw+/xkP3rbuzKgSFY4ySOWFeyP6Oh7LgCPRwAPv1IzxEAQGApqjvkPk5IVvguVL
 JCrdg02gDgvuCwoW+k96pjbuZE/6VCtaV77ueiNAcePdVeeq6KJ+oc9VBWx65Kf/C61D
 ImZXoDCSrFTkx/ANqwB70ANicYjHzmozbTasc4xeGbib6QZSdX9nlVlrFdXIWgtrOCo3
 Q6yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769180284; x=1769785084;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fVSKpNPUZ7Pn8NvtgX597pdEcglY2QSI3FLRYMr2zlE=;
 b=Nmqqr6JTbhq2M66/YZPBFobggj0QMMoCJkHqZ5vehQDaWKpjH0adMimtj9B6VHJ7Gm
 U4WOLJl52h2/0Cv4Zia1Q//XlV7nlFR9ol7aK/YDy5AMLrs0OiMXe6FH4C1Li668/TCf
 0utcyomFPRqKbfNVUA7QLbqY494iPlQkQD6PiTLtc7xhXZ2iP6N4ecFlsXVvqQnq4LfF
 ClFUoT8FiO43vtt3BIoGK0FTKrb0hjMEIBFLaZ1TXvAzE7OolJ4UTlP2OLr4si/GcCgE
 pIyHfRSwkzZQrPXcksMew6PE6h129xxE6p41M81lVEXISCwD1Mt+0/7wAbcMcJz+6aPX
 txIA==
X-Gm-Message-State: AOJu0YwCz2R5XjWaJpQF4AbKVWZLqacznqyWcaKgdPt7WFd7aOvUU/M3
 tfzeZ9/BtM501Gy/QsdVEAD+rV4ypYjgLtLFrjjs3A7C2WJB8QT/0BauWa8yEtXSthM=
X-Gm-Gg: AZuq6aKXCklxe0N/ts0HhS92Dm0AJSfPS0eVuww6Y9vV0q7zvud0koLFczBMfUHML4h
 4HPWmcdUV3EjZ3HgolqpRZ9e6qetrnN/A1uK/ztmePYwm7WY4eG/CYl3eEPXXK0VHpn0Ikm5SGO
 z80k+ovHaepiVTMjPkoR2zqPrh2qAgvZVh1jXtDmj0QbwI6M1Tg0RzPamkpuM3GEvb1rTIKXUv8
 itWA+BtKs9yVEpSutSHug3QYKANjNCPCp1mOy2/5PAdJ0zv9LG0N7bER9zma0WzcGZYcqlFF7/g
 wQ+1Fvwoj0xsTbHzjCgBBpCUgj8VWFIzxW7QjprTxg5QV/YJ+3C5BKZegMgTjO5Z0D4tekkjbPw
 uzN/znSxi/hrFRR9kivtm27vj11O61ZqdvzfDQeh+6ScDAGNyPnheEQFcRL+mjQ/QB9FLLqpKn2
 pOuVdi6wgtvM2P
X-Received: by 2002:a05:600c:6085:b0:477:7ab8:aba with SMTP id
 5b1f17b1804b1-4804c943cecmr53610645e9.1.1769180284358; 
 Fri, 23 Jan 2026 06:58:04 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4804dbaa3ecsm22969465e9.10.2026.01.23.06.57.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jan 2026 06:57:57 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 55D2F5F92E;
 Fri, 23 Jan 2026 14:57:51 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Joe Perches <joe@perches.com>, John Snow <jsnow@redhat.com>
Subject: [RFC PATCH v2 10/16] scripts/get_maintainer.py: resolve the source
 path
Date: Fri, 23 Jan 2026 14:57:43 +0000
Message-ID: <20260123145750.1200879-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260123145750.1200879-1-alex.bennee@linaro.org>
References: <20260123145750.1200879-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
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

We will need this to automagically find MAINTAINERS. Use the same
logic as the perl script by looking for expected files and
directories.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - don't hack add_argument twice just to display default
  - whitespace fix
  - don't default to required
---
 scripts/get_maintainer.py | 74 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/scripts/get_maintainer.py b/scripts/get_maintainer.py
index 2b8fc7ae9ee..c02bf4f5b0e 100755
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
+    script_dir = path.dirname(path.abspath(__file__))
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
@@ -26,7 +80,21 @@ def valid_file_path(arg):
     return Path(path.abspath(arg))
 
 
+def valid_src_root(arg):
+    """
+    Checks if arg is a valid QEMU source root or raise ArgumentTypeError.
+    """
+    abs_path = path.abspath(arg)
+    if not is_qemu_src_root(abs_path):
+        raise ArgumentTypeError(f"Path '{arg}' is not a valid QEMU source tree")
+    return abs_path
+
+
 def main():
+    """
+    Main entry point for the script.
+    """
+
     parser = ArgumentParser(description='Extract maintainer information. ')
 
     # We can either specify patches or an individual file
@@ -36,6 +104,12 @@ def main():
     group.add_argument('-f', '--file', type=valid_file_path,
                        help='path to source file')
 
+    # We need to know or be told where the root of the source tree is
+    src = find_src_root()
+
+    parser.add_argument('--src', type=valid_src_root, default=src,
+                        help=f'Root of QEMU source tree{" (default: " + src + ")" if src else ""}')
+
     args = parser.parse_args()
 
 
-- 
2.47.3


