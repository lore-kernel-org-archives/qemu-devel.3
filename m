Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DEFC606A326
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 15:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Jo08Ml6l
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPMLM-0002XQ-H6; Fri, 06 Nov 2026 10:59:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xPMLJ-0002Wq-Oj
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 10:59:05 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xPMLH-0001WG-RS
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 10:59:05 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4a1b07c3c5fso7393865e9.1
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 07:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793980742; x=1794585542; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eMCiXJrlNPfloco8FxEb07UVfI7zgL9Lqq7x5MvEf7M=;
 b=Jo08Ml6l/FdwwhmJ019g3LfPQNXwcUgFIlFbIYy420CJ9ZqPNwNEvs3qc2GLuGGmt6
 o4mujX40yWp9YSlkO/Arzza/JF51H1yQlO+XTcIGl+4cPuPicXML1rBIax7I/bCtgajx
 /1cXO5AQGwHAG5GzxsokmrT88hQJHQMHPPZdZoGcVPo/xyUcYVZ+J9VNsd8pWfBPSVxE
 XInoVeMyIXqiU6VF43xBZdVNe6Oi6xxX2iCiIgAHiIIFEmt6NDcfaIigo+94JdBbrGgS
 TpqtHwMj2h7mM5yId+u0opmXA3aM8+uQzucgQae3JWsh3U+sIGnpr+z7vRwalnUCnsyT
 J1dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793980742; x=1794585542;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=eMCiXJrlNPfloco8FxEb07UVfI7zgL9Lqq7x5MvEf7M=;
 b=rPzyPLzbOXIxSReTYIQPDm4Un35NSpO48febCE7/dWA93m0zQPSyud8cGYDD/JP1km
 wpYpo2zSC2YZf6YRAnmUkaNCentxCrvZ65DWw+EGt7u0t+ianlI9VToLULApjRtF1P12
 df7hXQ4IFttd5xJQWAFaB6K+b8WvGvY4vZ1tzzsaRqpkxiQs/fP8CHOgFvu45Cvq/l5P
 gteSeb0XwQWKZl+UCGpo/uDRDsAUjx0BRAZB8xvwI+ZA3fGkUcQ4sv/J3vE+hhzpRoQ7
 S8SoJ0KUnDQ3owsaNwZ585zdI6DVfbJmRr2XhwMTQLveh0bmeSrU5WOLNQLHDr67eVgn
 u2Eg==
X-Gm-Message-State: APuU4Z8liHIZrArrB2KLKw4V8HJgjgsOTlmnhHr9J1YKwarwu0GEnr3l
 xXjZRY8fmtSeoVeD1OVA//JPXp5wR0o7Zyz/wwALPvmxw8VXSlugcmat1rWbPceBm9g2iL8q9lt
 6zN+s7Iw=
X-Gm-Gg: AYBFou3Jct8ATkwAS4659rqXhy9otZVmTp4a97Jd5tw7Fc3QTMkVcJ8fSd7yAASIgEN
 Cg/zOsIXBzc8ExBBGNqHk4cET9U6MjsJe99sQtQltfyDnxOzVOvrYpWwnIwh25MSIERWZovVsr/
 dfH24gWkVTykfNIbRLmHynDfjXOLhZpHaTHwMSYIsMZhytX6S8FA/VNOjSG2r/8sBw8b1J7fUoR
 nh65RdOdY90e6WeFvYyB4l5cY2BvxoShg1xcxjppyM4hMPYq+nWm4oMNIdAEAlPoNE2lt4FzGBP
 9k/Jd4T8PE8Cp2dxJOevaynOF9d2nYby6qunM9FiFDHlaKcs19c6ulfEObRt2a5nla/Y2m3l5QJ
 1uFH1kA0sbJ2WzlDyG1miiab6ilWC2SW15KHkpdQrLllpSIlmSeIurZdosiSfqXIQk+tRB0+MBA
 89Sf7U4KaMW9pCNGUN4FMVjskEK95J/KPiQKuuxKPH8ruqtLFBXptWZ4C1MjRYt4QvCvpQPpPYA
 AqOxsMVjXtLZDgpo6uSh6Ms96NhZUhq8l0T/YDGBgXFRQUqyoxAeujBDQ3E4rIYthoq9uf9Sy0q
 DfG/e0bTGfFWhZdBfw184zBBJwQgoU85wzOopwv1urHM/U44LcKquq8WmiqiYjMt1wvy17wUWi3
 LF5oe7iWrnGtbDC6YKiDen0EAML5ZFAGehg==
X-Received: by 2002:a05:600c:4444:b0:4a1:cfa7:e968 with SMTP id
 5b1f17b1804b1-4b6df9bec76mr47826905e9.21.1793980742055; 
 Fri, 06 Nov 2026 07:59:02 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b6e168f331sm80661395e9.3.2026.11.06.07.59.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 07:59:01 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>,
 "Pierrick Bouvier" <pierrick.bouvier@oss.qualcomm.com>,
 "John Snow" <jsnow@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Philippe Mathieu-Daude" <philmd@mailo.com>
Subject: [PATCH 1/2] Revert "meson: rewrite scripts/qemu-version.sh directly
 in meson.build"
Date: Fri,  6 Nov 2026 15:58:57 +0000
Message-ID: <20261106155858.3779237-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261106155858.3779237-1-peter.maydell@linaro.org>
References: <20261106155858.3779237-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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


