Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78718606A6C0
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 20:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=pJU1Dz/K
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUUsY-0001RW-VN; Fri, 20 Nov 2026 15:06:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xUUrI-00017k-DM
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 15:05:20 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xUUrE-0001ro-0n
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 15:05:18 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4a2000d5fb1so7642285e9.1
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 12:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795205114; x=1795809914; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=KNVSdZ0AXBHzjmT6EZIpKKKmzaZoj2AtIwXKa7oDaf4=;
 b=pJU1Dz/KWVVPzZcH95jC3QU7Tu/XFjxZnvDVDnA3EFO/VRULXmaQ7EnL0pXKq6R7H2
 pMNRqW8GGddWT9bjpqzVKKMzrG0fmjrm8nubhxNUZSHz9M95TstOfxQz6dgD2YlK2Jdi
 k+ylb/Y3nxw3pLRxM783XMDys3D/ISI8LQmiOBFEwAItWNfmxIHWQgNhvh7ZSR1fNbOX
 DjrAjSo9ulYY+Baa+bBo6RVCTElRaX0rT3Uoc66C3xTkCuUOql7WUOOBM2hE+dRY8hj/
 Iv37pWSIm/G+yyQ58Q+3uG9zyV7VmQQFptx1R3TCTqqSekt2qnfsYNaMEV3PvUOyAS6P
 Z/8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795205114; x=1795809914;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KNVSdZ0AXBHzjmT6EZIpKKKmzaZoj2AtIwXKa7oDaf4=;
 b=zS9BmemGp+138DTDrbGle8rygJLGYHCplQ7tSoPZXUsE3YRnN6XXNhrlxGpP38o5tz
 EhQYoFWn0Cue4q/BkZNRjV4wTvyu9EV393mDzVERjRUO5MlHRYhu3AdhOiLP4BMpD7wj
 unr19tliRqk+yJVc9P8BxJ6wNAfpDoMWhJZ0ibbnxUrhG6SQFIyrbnq+GksLh5evI2TP
 XnQahUXvmkkp66dXPs9jlITIzQ4NSxyO7pzVtzNX6d09rphEQagOKeokuzB2THuHo/TZ
 aVohMIS2GSjW+SmUZ2udiuEk41K2d4ROa4VMoCUGhzQ+D3t0b1ez360zROuwzQmuaLqm
 R7cw==
X-Gm-Message-State: APuU4Z9bCiQuQ/JgaKs1bO9vu0hu+l2FM2ZtO+zp4PI2LLk7dqZjXVKG
 pUkXBuS8Kq/FnzO0fijsyyrGtinWz/kAntU2Bcfxy6nbdgLQyphAUQG0v8/G7xe4Cuc=
X-Gm-Gg: AYBFou3W0OEucKscPCpWM3n4+0zWmNhebdLhOQO6TpjT46wS5FQQQOBh6+gkrYRz1ZY
 AJppHiKJko6Wcm3O97JINCIBpF4VOvfbwK2oqZW9NXUrhwdhr7Fy79uX2ERoDEHmzpRbP+8jnvz
 Mflrw1XU3PGzZwbzfia4BrxWOMaPUCYXdNkTUsgVJeTmTcIgu/0dwzn5R3QeR47fbPTEwko592m
 SFGWlKNzQxGHT089d8USGwHASX5UP40kRx0MeONapHkVMf2oN/9aDl+igecM0ep6DYkhjN1fw/N
 dsbsbpwR6DkY/dd+G3iVBD0Tw8j/ZytAhEM6MzG+cjprxw5IFllqkYMCBVLQZvetXr0pdn2hlC3
 xBFEI14ZxLBdZntFJj3tK5qp4pgP50YxyH7JCyJ1j96Whd68tx+iNATyBYq0TLTPrSlJCiyk2Aa
 clQ5vXD555Z9jVGWwWmLWqd+WgBtPj0Qf3QbUJYXJvM4Uh+YkOFc+CEUnah2kbWy1WCRxxknGKp
 V3XafWBcQLz8od/mjs1ib5BGRQebr0IJPMxL6ktbkkzt0cgrAWftY6rOa12Gasf2ZV13BPOvqUD
 gsoioNt1aETSWFvhYKXrBmTZZSVB
X-Received: by 2002:a05:600c:a08b:b0:4bb:6651:9eda with SMTP id
 5b1f17b1804b1-4bb88922ca4mr88343765e9.14.1795205114197; 
 Fri, 20 Nov 2026 12:05:14 -0800 (PST)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb8538b3a7sm159376295e9.3.2026.11.20.12.05.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 12:05:12 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8F0D65F9D0;
 Fri, 20 Nov 2026 20:05:11 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>
Subject: [PATCH 01/22] scripts/get_maintainer.py: minimal argument parsing
Date: Fri, 20 Nov 2026 20:04:49 +0000
Message-ID: <20261120200511.822573-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261120200511.822573-1-alex.bennee@linaro.org>
References: <20261120200511.822573-1-alex.bennee@linaro.org>
X-Archived-By: <archiver.kernel.org>
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

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v3
  - treat dir as valid as well (as git ls-files lists it)
  - move arg parse into own function (parse_args)
  - set files nargs as + for more flexibility
  - use python3
---
 scripts/get_maintainer.py | 49 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100755 scripts/get_maintainer.py

diff --git a/scripts/get_maintainer.py b/scripts/get_maintainer.py
new file mode 100755
index 00000000000..47673a5013f
--- /dev/null
+++ b/scripts/get_maintainer.py
@@ -0,0 +1,49 @@
+#!/usr/bin/env python3
+#
+# get_maintainer.py: Print selected MAINTAINERS information
+#
+# usage: scripts/get_maintainer.py [OPTIONS] <patch>
+#        scripts/get_maintainer.py [OPTIONS] -f <file>
+#
+# (c) 2025, Alex Bennée <alex.bennee@linaro.org>
+#           based on get_maintainers.pl
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from argparse import ArgumentParser, ArgumentTypeError
+from os import path
+from pathlib import Path
+
+
+def valid_file_path(arg):
+    """
+    Checks if arg exists and is a regular file or raises ArgumentTypeError.
+    """
+    if not path.exists(arg):
+        raise ArgumentTypeError(f"File '{arg}' does not exist.")
+    if not path.isfile(arg) and not path.isdir(arg):
+        raise ArgumentTypeError(f"Path '{arg}' is not a regular file.")
+    return Path(path.abspath(arg))
+
+
+def parse_args():
+    """
+    Create and parse the arguments.
+    """
+    parser = ArgumentParser(description='Extract maintainer information. ')
+
+    # We can either specify patches or an individual file
+    group = parser.add_mutually_exclusive_group()
+    group.add_argument('patch', nargs='*', type=valid_file_path,
+                       help='path to patch file')
+    group.add_argument('-f', '--file', type=valid_file_path, nargs = "+",
+                       help='path to source file(s)')
+
+    return parser.parse_args()
+
+def main():
+
+    args = parse_args()
+
+if __name__ == '__main__':
+    main()
-- 
2.47.3


