Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C70606A335
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 18:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jbD0LDAu
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xP1zO-0001wt-Mm; Thu, 05 Nov 2026 13:15:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xP1zK-0001wY-S4
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 13:15:04 -0500
Received: from mail-dy1-x1336.google.com ([2607:f8b0:4864:20::1336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xP1zH-0005Fr-1z
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 13:15:01 -0500
Received: by mail-dy1-x1336.google.com with SMTP id
 5a478bee46e88-36a18fc7a38so2818498eec.1
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 10:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793902497; x=1794507297; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=54QiAGJ4S2aXZee0pnGYxbqmMzUlPa+3h8prkSYwPOk=;
 b=jbD0LDAu7smFBwn5dMvwrG43ycQL8bRuuCd+fM8CkcaLZbnpnon3wxO+K/Fkaa7KT+
 Q/LT04A8fFq4dlmz1IX9hi7gLa4U6nIPJ09QnGripjfQXWklFeG19fEqE4lfA4PSntXr
 4nw4ayD8wz6q9DrnwufcheDIvoeUQy9/0kQY5tXGWHWKzanIVf73BkOxIVnynHnZ7Gbe
 HnKMFs/5cIxVZV8NWbLX90rdxiWQFFqQjPXta4X6ZySEa4L8NOQ6wVq/F4oNnoGeqELm
 9VlinPzvniaQMz7G7W7tZ8OVmzkF16P7XMBFsdurkEH9NAiPjZFNnPYKisKvg21Wq+FL
 hAbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793902497; x=1794507297;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=54QiAGJ4S2aXZee0pnGYxbqmMzUlPa+3h8prkSYwPOk=;
 b=cxYGn9nByn9tKT975XK4oolro9756WdTBq60V989nQPDec+I1aiQI5/fMMBE0XG8b7
 SzKdBtrB5LW877ZcyGvPa8C3sX1y2pRMSB5vUny1d11Oivl3Hz61QSdU3yMSwOZuNRrL
 P4cT/aVSS6Q9LiaMdMJf1i8pBYHHjJmtjJyIeOPCd3Fkx/J65vo8wob6nce6MweUaEJe
 eKWvT0uDSq/0cEW3W1i6bL0zK96u9qC5C6W1jjvpNIQvj6pSkq0R4wxxjDpu3vp6fVEr
 E+B0/6YaCfLwQYw6mz2ggeu6cw7S2KMm6Kd5toVQnt0YlHr03gDAtn11gbye/BERiZFr
 HfIw==
X-Gm-Message-State: APuU4Z+aQncTL9izWLgN/p119bXqh4PpOdClSAxx3sz5/lyP99m453B3
 t6bDmwkpDnhwQVCgPO/WIAkhxSjsse6EbSpby6aenxYcn50O+H01RHzxrOJa/l5ZBnU=
X-Gm-Gg: AYBFou3c9Jlzp+9Ifh1Z2huwMP7iZITmOcUHsPG0ttRERWQBpOuQgydmpnJeEz7Ebyp
 Nw38gAmZQs2gYBX/Ai5yN1nqBloPPHKqZSojFFcBzh59Zyo79ZogxrSGlFzPle31fSzdfTRa+Pw
 XdArgHjpuNijgLXPUilQcmcUejmCLpnB+NEcEZavPv8T74Ot5o27DBvxh4fHn7O4rduQxuHOtPQ
 Az1MeuD3U8JfcHU4ZJWmzltStQxH/A0f0iuT1JPVeRgXqMLpMBfI4H7oMZkpSOnfxehjEMtJNun
 dAD9TqTZc9AGoOLJoWlEE3T2ogqm+I2m4Oxc2W5RLQi4eOhaRLJ+o9xcSqNz1RgEqQ/T1d4HKOZ
 J2NWjpwh7ipq4LOkH+2pJGaGYNUxH7amIyMkwQI3XVf9PTE7pih+5/MYkBYK9xFI5sN/ovZtcNH
 CFSg7raNFX/mdW4fOt/E8tHFfyhnBUFG2vDmYrj/aF9hUj1rhN4KLKDNJRZQqPXWR75k8zFcGcg
 jBydCbxz6j8qX7WAVUgQj6l2SBDPZxV14Sadsd+4XjKqyfgzi8Vlktp6PwLCAk6/iEiuLtVNroQ
 zJTdytEKccV7HxiEpP182o6ckUp1dVL/WlCEeKK2Zm2O7i1bdChzpwU8qsG2uPKsKfIYoA==
X-Received: by 2002:a05:7022:3f04:b0:16b:fdbf:4a9c with SMTP id
 a92af1059eb24-1ac5ac4cd7emr30862998c88.23.1793902497161; 
 Thu, 05 Nov 2026 10:14:57 -0800 (PST)
Received: from DESKTOP-Q716RM7 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-1b245c6f0dcsm25150323c88.21.2026.11.05.10.14.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 10:14:56 -0800 (PST)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>
Subject: [PATCH] meson: generate qemu-version.h with a custom target
Date: Fri,  6 Nov 2026 02:14:48 +0800
Message-ID: <20261105181449.1691-1-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1336;
 envelope-from=luoyonggang@gmail.com; helo=mail-dy1-x1336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

configure_file() writes qemu-version.h at setup time. That result is
not a ninja edge, so a missing header is never rebuilt and compiles
that include it do not order on it. Generate the header with
custom_target and list it in genh. scripts/qemu-version.py reads
scripts/qemu-version.h.in and substitutes -version. An empty
pkgversion drops the QEMU_PKGVERSION line.

Link: https://lore.kernel.org/qemu-devel/CAFEAcA8bGODxRfRzrimhGN1v2HtcWvApRsyucemZbMUUBVkYwA@mail.gmail.com/

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 meson.build             | 14 +++++++++-----
 scripts/qemu-version.py | 26 ++++++++++++++++++++++++++
 2 files changed, 35 insertions(+), 5 deletions(-)
 create mode 100644 scripts/qemu-version.py

diff --git a/meson.build b/meson.build
index d7bcb581c1..78cbc91296 100644
--- a/meson.build
+++ b/meson.build
@@ -3574,11 +3574,15 @@ else
   # Unlike vcs_tag(), which always defines QEMU_PKGVERSION, leave it out if
   # empty.  include/qemu/version.h then omits the parentheses from
   # QEMU_FULL_VERSION.
-  qemu_version_data = configuration_data()
-  if qemu_pkgversion != ''
-    qemu_version_data.set_quoted('QEMU_PKGVERSION', qemu_pkgversion)
-  endif
-  qemu_version = configure_file(output: 'qemu-version.h', configuration: qemu_version_data)
+  # custom_target is a genh source, so consumers order on qemu-version.h
+  # and ninja recreates it when the template or pkgversion changes.
+  qemu_version = custom_target(
+    'qemu-version.h',
+    input: files('scripts/qemu-version.h.in'),
+    output: 'qemu-version.h',
+    capture: true,
+    command: [python, files('scripts/qemu-version.py'),
+              '-version', qemu_pkgversion, '@INPUT@'])
 endif
 genh += qemu_version
 
diff --git a/scripts/qemu-version.py b/scripts/qemu-version.py
new file mode 100644
index 0000000000..a10cc5e03c
--- /dev/null
+++ b/scripts/qemu-version.py
@@ -0,0 +1,26 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+# Usage: scripts/qemu-version.py -version PKGVERSION INPUT
+# @VCS_TAG@ in INPUT is replaced with PKGVERSION. An empty PKGVERSION
+# drops that line.
+
+import argparse
+import sys
+
+parser = argparse.ArgumentParser()
+parser.add_argument('-version', default='')
+parser.add_argument('input')
+args = parser.parse_args()
+
+version = args.version
+with open(args.input, 'rb') as template_file:
+    template = template_file.read()
+if version:
+    version = version.replace('\\', '\\\\').replace('"', '\\"')
+    template = template.replace(b'@VCS_TAG@', version.encode('utf-8'))
+    sys.stdout.buffer.write(template)
+else:
+    kept = [line for line in template.splitlines(True)
+            if b'@VCS_TAG@' not in line]
+    sys.stdout.buffer.write(b''.join(kept) if kept else b'\n')
-- 
2.55.0.windows.3


