Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC331C3DA61
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 12:26:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYPRx-0008Lk-0e; Mon, 29 Jul 2024 08:26:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sYPRu-0008Bk-FT
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 08:25:58 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sYPRs-0000S2-AS
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 08:25:58 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-42816ca782dso13961115e9.2
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 05:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722255955; x=1722860755; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZK5JAGCjpfD8w3xC2MXUI2a9OHNwAL8t7/Yak8e0bRA=;
 b=OFsPWItwQoQtxzM+Zusj7LHMqmw7str7UJs5Ad5Svd6aWPzOcTp2fCX8QZBqEmH1SF
 32asNGZtSA6Cmab8aCYl9dAbj64sgPtOo07pk2wZfbTKeU2/I1DZXuH+zhmFQcFWXH1G
 QQgbA3pppoOT/CvWI59GbXtVpGRcB9TpRGZ1GT3hOLQQnwcaNaboH09ItfnasoLeIfvA
 ZRAkwhTGGNQNOv2cdXTUPjHeGgAU2+TH3ZkN8uT8hAeMhRaMzuT7z7bzrCp6f54DSlA4
 3EMVNQ4EIu5aFpsTM+Z9j1sSyHLdbaoam8y7oflBd0giqKCUfmJ9ZvUW8caV91L/RsDk
 gERA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722255955; x=1722860755;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZK5JAGCjpfD8w3xC2MXUI2a9OHNwAL8t7/Yak8e0bRA=;
 b=uOC9nq9xR7nTidPPpOl2jIG37y6BcQ5atfLDtiJMf/e2LLv1rUFQRXcMuC5xrI/TRm
 HRRLvbykTYvyV+SfLI/ztpLjjjcweKKMK3Tx32UdGqWzY6xEdHmyH8omyXV6Mjet1DBz
 eszda0WGZ5ZKk/DfKk8tLHb7G2zfOL5aZxH6JOITlkU/1DqgPSUCstn7zFAarBXn+KFE
 Ghg/KMgCGuvfsbJbFBKKQVOWbriueGDgTi6f/KSyp5FicInWmrmTmgEiWc1uBcuPnub7
 xef87t2eJ1e2RlDhx9/SvwaMPZzHX6d2a4b60g0AVMF2wus4aEnVI31m4yCcc5liVvAN
 xp4g==
X-Gm-Message-State: AOJu0Yzlz05HP1l1poNo8FqVi0MQUJ22lWw5DxnHhMJ9JixnvXtIpF2r
 t7DPB8qkettKwkO/kajbuFJo8D1InNAR2bSHekheB2GASnyu2A2LmhGAXEEWEHzf0j5sAqYMw+P
 3
X-Google-Smtp-Source: AGHT+IETiLdbubbewx5pwd9yKj/aEDZNqOHd+Gd7l57cVai77lfw+sSP+EDodX5zQoTJlz9zmDB8Ow==
X-Received: by 2002:a05:600c:4511:b0:426:8884:3781 with SMTP id
 5b1f17b1804b1-42811dd1089mr48447205e9.24.1722255954526; 
 Mon, 29 Jul 2024 05:25:54 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-428057b5f69sm177694415e9.39.2024.07.29.05.25.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jul 2024 05:25:54 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
Subject: [RFC] pythondeps: Split sphinx_rtd_theme into its own group
Date: Mon, 29 Jul 2024 13:25:53 +0100
Message-Id: <20240729122553.2501133-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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

Currently we have "sphinx" and "sphinx_rtd_theme" in a single
group in pythondeps.toml. This means that mkvenv will try to
install them both at once, which doesn't work if sphinx_rtd_theme
depends on a version of Sphinx which is newer than the system
one, even if the "sphinx" we're installing at the same time
would satisfy that dependency. For instance this:

 sphinx = { accepted = ">=8.0.0rc1", installed = "8.0.0rc1", canary = "sphinx-build" }
 sphinx_rtd_theme = { accepted = ">=2.1.0rc1", installed = "2.1.0rc1" }

fails like this:

mkvenv: Creating non-isolated virtual environment at 'pyvenv'
mkvenv: checking for meson>=1.1.0
mkvenv: installing meson==1.2.3
mkvenv: checking for sphinx>=8.0.0rc1
mkvenv: checking for sphinx_rtd_theme>=2.1.0rc1
mkvenv: installing sphinx==8.0.0rc1, sphinx_rtd_theme==2.1.0rc1
ERROR: Cannot install sphinx-rtd-theme==2.1.0rc1 and sphinx==8.0.0rc1 because these package versions have conflicting dependencies.
ERROR: ResolutionImpossible: for help visit https://pip.pypa.io/en/latest/topics/dependency-resolution/#dealing-with-dependency-conflicts

*** Ouch! ***

Could not provide build dependency 'sphinx==8.0.0rc1':
 • Python package 'sphinx' version '4.3.2' was found, but isn't suitable.
 • A suitable version could not be obtained from PyPI.

(where 4.3.2 is the system version of sphinx on my system).

Avoid this problem by splitting sphinx_rtd_theme into its own
group in pythondeps, so we can install the new sphinx into the
venv first and the sphinx_rtd_theme afterwards.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
I'm just bumbling around in the dark here, hence the RFC tag: maybe
there's a better way to fix this? I ran into this when I was trying
to test the fix for https://gitlab.com/qemu-project/qemu/-/issues/2458
and wanted a newer Sphinx to test with. Unless you also install
the newer RTD theme the new Sphinx will emit some deprecation warnings
about things the theme is doing.
---
 configure       | 7 +++++--
 pythondeps.toml | 3 +++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/configure b/configure
index 019fcbd0ef7..7f9cfbffa2c 100755
--- a/configure
+++ b/configure
@@ -973,9 +973,12 @@ if test "$download" = "enabled" ; then
 fi
 
 if test "$docs" != "disabled" ; then
-    if ! $mkvenv ensuregroup \
+    if ! ( $mkvenv ensuregroup \
          $(test "$docs" = "enabled" && echo "$mkvenv_online_flag") \
-         ${source_path}/pythondeps.toml docs;
+         ${source_path}/pythondeps.toml docs && \
+         $mkvenv ensuregroup \
+         $(test "$docs" = "enabled" && echo "$mkvenv_online_flag") \
+         ${source_path}/pythondeps.toml docs-theme );
     then
         if test "$docs" = "enabled" ; then
             exit 1
diff --git a/pythondeps.toml b/pythondeps.toml
index f6e590fdd86..fdf5579c43e 100644
--- a/pythondeps.toml
+++ b/pythondeps.toml
@@ -24,6 +24,9 @@ meson = { accepted = ">=1.1.0", installed = "1.2.3", canary = "meson" }
 [docs]
 # Please keep the installed versions in sync with docs/requirements.txt
 sphinx = { accepted = ">=3.4.3", installed = "5.3.0", canary = "sphinx-build" }
+
+[docs-theme]
+# Please keep the installed versions in sync with docs/requirements.txt
 sphinx_rtd_theme = { accepted = ">=0.5", installed = "1.1.1" }
 
 [avocado]
-- 
2.34.1


