Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B03606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 13:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=HQLqhL+N
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTJI6-0002JK-L1; Tue, 17 Nov 2026 08:32:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xTJHy-0002Gu-Po
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 08:32:02 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xTJHu-0000MW-J4
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 08:31:57 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-492f0a1b685so3168238f8f.0
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 05:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794922312; x=1795527112; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=blQPNSaTmzJc1fXNWV0nxOVvq9hHCI/3Ss3b4cRuZZo=;
 b=HQLqhL+NgohUPxClcaDzStQjvDevuAP++NgpdKLF5QqhLJ46ZjDO7GagQzAoI953ZX
 TCG4ydbPOFW70TLLPiDz6QdLneGiYevd+u46ifQfZPp9GdOFMfeWVb7+0LgZlV/CUD/x
 CHgGORMeqSh8G0IxnOv7BYsavGtovaT//zDozHeYvWx9hzhEXZB81HflK8M3pnyl49wO
 GjpAzLcgtrMNRV++LI6MoX3uIuHw127773E58+48c9KCuNiaBAlI9d36n9GOXjYUBBya
 3qZcQnK8jKYt7BDqnjx163xw7QrXBjDRqg88mxMKb8tI50UTq3rlIRlLyc3MO/jhnQBl
 J9eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794922312; x=1795527112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=blQPNSaTmzJc1fXNWV0nxOVvq9hHCI/3Ss3b4cRuZZo=;
 b=QVKsIMvDTo/HBxsyDP+9LHSDeH9agPNfoja11CgTOGrDCCuJasB9Qk/rXlbyEh/SN9
 8QlxCIanJiv8IffAidl3yPcbjKC5R7fxwCy+KxvFMxmlx7ywJ1ZU5w1CIAH0LrzAypv2
 Hnh6DD942nQowTfPBLBrlnrhVxblvXL3EEzIaQs3FaZZYKRF7i8ArVcSFwVmFuudq4/C
 ROW4xLkaa4NwLhrJTa2n6TR/0rOvEEtetbP7w3mPKDl7tX/HaDxgtPhPoG/SR2LXExBr
 Qh27XaPfQxt+GC85XWnqG/c6ayuFdJoWNsHT8n024o2mlFGFhn1B8Bul6wTeQTU4zpyG
 WLkA==
X-Gm-Message-State: APuU4Z+ZDRBeiN98WZ3kJSddd2oTT/cPj5ly2nyQhFds3Vn33s3IPFc9
 Fw7Hz2q0kY88DCUG7n5VcqhlMDNIqLtrZ0I9mJgz4PvfTDg9vVB5XhRPZY6guTdLjTNa2gv0Gy0
 Oc3I2TgE=
X-Gm-Gg: AZFdTZeiU9pajJaitY39jbb21qowTcs4QdeZm1n10rn6mNbuUr7+ugrnTtcd2sDncM3
 xekR1+itbbGa6Uvabcak3H17xL44jikzS5rugjJZY51aBfeTvhSfYZKWnNVkmGPYPetfwGE4oLf
 Ha21lKva9wIoDrdjW8OW6wli5QDkyjw+2u6JUdAuPQCs99YLwoT0uOQ5nH0v4fl23mwJS7s35OB
 qqbWMwFNt9O9IREYcUc/zbPpfcroXZ/30fSFtvQ7GqZBOjENw8zJJg9HXp519L9/Um+e3uz6zI+
 mNiX25XzMrPx27PslKsnO/8iUWe+1+5mUYXLUBGe7b/BTlC1RXcNqmAj+z7EWmIiRTnzVur4Wdd
 /5Te2MewBrbFt2r37I6/PpiR6Ih4WXKdwrUd8oWqe9Ngf2vgRMa/CxJHdGPfgUliCNDY5XlwSk9
 wiP8LfAXQ00tt8m5Aa7qEZ3fIqVy9Mf5jWpcmOUPK3oEP6bSzTIOAQFwr8URCedKHQKdGRM6DfY
 Oj53UCjN6mguMt3amooyQQKAOeyBP3tqdqhLUpWHSxY1x0OiGYT7TArwjDwsTRfpL9hGXG4yxx4
 oy+0+60JZu/ZkqpviPISNbTU5d3NQNnMMZymFWUKdTKPAa3gqDj8Qljgy3iIzabqkDRQVYIYLWF
 5+b1HQcmg4gsrtUza6skvJhgXAYgHuoW7DA==
X-Received: by 2002:a05:6000:428a:b0:491:8462:20be with SMTP id
 ffacd0b85a97d-49c70de380emr31783060f8f.12.1794922312185; 
 Tue, 17 Nov 2026 05:31:52 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c609c8a77sm28516886f8f.49.2026.11.17.05.31.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 05:31:51 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 1/8] Revert "meson: rewrite scripts/qemu-version.sh directly in
 meson.build"
Date: Tue, 17 Nov 2026 13:31:42 +0000
Message-ID: <20261117133149.2108068-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261117133149.2108068-1-peter.maydell@linaro.org>
References: <20261117133149.2108068-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
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

This reverts commit ab78ac76f44a1241e76fd32d248df62d83f1ea58.

The change to create the version header in meson.build loses
the dependency needed for the header file to be built when
it doesn't exist. This means that:

 * if you delete the build/qemu-version.h file, an incremental
   rebuild fails, rather than recreating it
 * if you do an incremental rebuild from a build tree that
   pre-dates ab78ac76f44a, it doesn't have qemu-version.h,
   and the rebuild fails

Revert the commit so we can think about how we want to address this.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20261106155858.3779237-2-peter.maydell@linaro.org
---
 meson.build               | 29 +++++++++--------------------
 include/qemu/version.h    |  8 --------
 scripts/qemu-version.h.in |  1 -
 scripts/qemu-version.sh   | 25 +++++++++++++++++++++++++
 4 files changed, 34 insertions(+), 29 deletions(-)
 delete mode 100644 scripts/qemu-version.h.in
 create mode 100755 scripts/qemu-version.sh

diff --git a/meson.build b/meson.build
index d7bcb581c18..93da3e6f2bd 100644
--- a/meson.build
+++ b/meson.build
@@ -78,7 +78,6 @@ have_user = have_linux_user or have_bsd_user
 ############
 
 sh = find_program('sh')
-git = find_program('git', required: false)
 python = import('python').find_installation()
 
 cc = meson.get_compiler('c')
@@ -3561,25 +3560,15 @@ tracetool_depends = files(
   'scripts/tracetool/__init__.py',
 )
 
-qemu_pkgversion = get_option('pkgversion')
-git_describe_version = [git, 'describe', '--match', 'v*', '--dirty']
-if qemu_pkgversion == '' and git.found() and fs.exists('.git') and \
-    run_command(git_describe_version, check: false).returncode() == 0
-  # Refresh the version at build time, so that "make" after a commit updates it.
-  qemu_version = vcs_tag(input: 'scripts/qemu-version.h.in',
-                         output: 'qemu-version.h',
-                         command: git_describe_version,
-                         fallback: '')
-else
-  # Unlike vcs_tag(), which always defines QEMU_PKGVERSION, leave it out if
-  # empty.  include/qemu/version.h then omits the parentheses from
-  # QEMU_FULL_VERSION.
-  qemu_version_data = configuration_data()
-  if qemu_pkgversion != ''
-    qemu_version_data.set_quoted('QEMU_PKGVERSION', qemu_pkgversion)
-  endif
-  qemu_version = configure_file(output: 'qemu-version.h', configuration: qemu_version_data)
-endif
+qemu_version_cmd = [find_program('scripts/qemu-version.sh'),
+                    meson.current_source_dir(),
+                    get_option('pkgversion'), meson.project_version()]
+qemu_version = custom_target('qemu-version.h',
+                             output: 'qemu-version.h',
+                             command: qemu_version_cmd,
+                             capture: true,
+                             build_by_default: true,
+                             build_always_stale: true)
 genh += qemu_version
 
 hxdep = []
diff --git a/include/qemu/version.h b/include/qemu/version.h
index dd0f937f30c..38405495c0e 100644
--- a/include/qemu/version.h
+++ b/include/qemu/version.h
@@ -7,14 +7,6 @@
 #ifndef QEMU_VERSION_H
 #define QEMU_VERSION_H
 
-/* qemu-version.h defines QEMU_PKGVERSION only if it is not empty.  */
 #include "qemu-version.h"
 
-#ifdef QEMU_PKGVERSION
-#define QEMU_FULL_VERSION QEMU_VERSION " (" QEMU_PKGVERSION ")"
-#else
-#define QEMU_PKGVERSION ""
-#define QEMU_FULL_VERSION QEMU_VERSION
-#endif
-
 #endif
diff --git a/scripts/qemu-version.h.in b/scripts/qemu-version.h.in
deleted file mode 100644
index b62d4c22652..00000000000
--- a/scripts/qemu-version.h.in
+++ /dev/null
@@ -1 +0,0 @@
-#define QEMU_PKGVERSION "@VCS_TAG@"
diff --git a/scripts/qemu-version.sh b/scripts/qemu-version.sh
new file mode 100755
index 00000000000..3f6e7e6d41d
--- /dev/null
+++ b/scripts/qemu-version.sh
@@ -0,0 +1,25 @@
+#!/bin/sh
+
+set -eu
+
+dir="$1"
+pkgversion="$2"
+version="$3"
+
+if [ -z "$pkgversion" ]; then
+    cd "$dir"
+    if [ -e .git ]; then
+        pkgversion=$(git describe --match 'v*' --dirty) || :
+    fi
+fi
+
+if [ -n "$pkgversion" ]; then
+    fullversion="$version ($pkgversion)"
+else
+    fullversion="$version"
+fi
+
+cat <<EOF
+#define QEMU_PKGVERSION "$pkgversion"
+#define QEMU_FULL_VERSION "$fullversion"
+EOF
-- 
2.43.0


