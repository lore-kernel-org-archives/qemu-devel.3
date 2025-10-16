Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C103CCD199
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 15:05:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9PWa-0002Cm-2p; Thu, 16 Oct 2025 11:04:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v9PWY-0002CF-TS
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 11:04:15 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v9PWP-0001AQ-8q
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 11:04:14 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-47117e75258so83775e9.2
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 08:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760627042; x=1761231842; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EO8zY+f+eRKXz2hwkLNT6XbeCb6L/izof5+RV6C6SZU=;
 b=aIAhFNZHi8uracppwjbLISKwfsxFQWFzRd3bZIL8alzPEoe0233AYGMXfd7RGlA7MS
 DYH5CaIJo6BLS69oqA49RJYXrYW6WipWSNWFSJ7TMe5qOGtksPIiQWlloN3lFXZBg+6Z
 6YRsFjDMf+iqpFuIDXPvqrdhe2WBvaB6vo16fFMH5iB919TNT5cWOmU9vuEdEKgzBWLu
 Mxx32IjB3cPfh+/su3oLhLoVsrqxpHtQbfex02k1Ut+3zCt6ATsmrzpJtKCC/tb2wfI7
 0Q5hjq7Iy907EHNm4NzrC1PGhE5fmjpBG+pNdm+g/PSV9zeQZ4NWqAGVhnLgZgQf36tr
 PjKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760627042; x=1761231842;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EO8zY+f+eRKXz2hwkLNT6XbeCb6L/izof5+RV6C6SZU=;
 b=adyQSmtASoh1OPZHeQ6Ij0ioNYxDPhjbVxnSEggsjFwsUVW3NUMUKE1d4MQSExdpX2
 ukLzCIB197/Tq/oQRarMrhg+FHFm6qxHySSzucIMGbQM95BQg5CvoXrlgrjMfSHYSUqk
 2p13QGqGY4bp138YKplHk4a16OuwAgmfzhKzzAU1sNHJv7i+Mo0GgqAR/zRm0+ddeAWz
 5iauwFDXmE46vXSCRkVnXK86UaEM9I6d1jFit2jdxWL8lux4buILqIMREZDWAClR0Ybf
 o4YRRTdsNaMyYDjDEzb0ZzAKVu9HJPZr1lQzHLpuFaDRi3U+F2dApK2jQX4+PXcOqObm
 IjTw==
X-Gm-Message-State: AOJu0YwKa9DpuwNprqZYsQvgjI83+pv99XkxFlyNgur+b5aie+nQmGGV
 JcxR3XlXe9A2GAsEAAckh7DR2r7ZcC1zSIXyKCkwDehGMPcyCJ1Jj2Aq7qjtQtSZVdk=
X-Gm-Gg: ASbGnctSo7YE1qhduuVwye/UD5o6dafixdePhWKI1aGOje/jN8W9bdlRWG8nUg18QTf
 IQinA4uRtts5XyDbsb74fi59oKEbOSUZSPLjdUZg+bFBZSPc3CFxLcoZJVZpQp46g33n6FdJycG
 FatB/oiRE7f9iBSgUsGN/n7P15kDfMMzXs0/7ql67wp/pBi1uLSWygImUsnuYng26g9drPDIOaK
 HJtneZosR9ivU6FvjaLhU3kvV+No7lrc8GztvYBbUFqc1/jrlT9sgnLkbV/bsW2EoTAhUcePxW4
 jEcuTGfjsPgim5dPsP8p+0ZSL/Z58Vh/o6xAeHZh4IN09g4u48nH/knRoldYRlSD+WQyUL8OCIY
 uoKj7GNxnhIVDAoRxJZr3q1QexqctuopPv34QgwPxG3fwdK0YLOg8Y9S8oJTitdX9qoHGgK6TIp
 2KHG2VTlM+RbE=
X-Google-Smtp-Source: AGHT+IGIZvjzA47nkAowGslp4cd0HOEMBBO80cepdDIGX03OPwrZ5tK31tlJpdKnPlF1bdv608L+dg==
X-Received: by 2002:a05:600c:3513:b0:46f:b340:75e7 with SMTP id
 5b1f17b1804b1-471178748a9mr2504435e9.8.1760627042213; 
 Thu, 16 Oct 2025 08:04:02 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4710f28a920sm21361185e9.7.2025.10.16.08.03.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Oct 2025 08:03:59 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8C2245F87A;
 Thu, 16 Oct 2025 16:03:57 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Levon <john.levon@nutanix.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Thomas Huth <thuth@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PATCH 01/11] gitlab: use template for ubuntu-24.04-aarch64 jobs
Date: Thu, 16 Oct 2025 16:03:46 +0100
Message-ID: <20251016150357.876415-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251016150357.876415-1-alex.bennee@linaro.org>
References: <20251016150357.876415-1-alex.bennee@linaro.org>
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

Most of the test is pure boilerplate so to save ourselves from
repetition move all the main bits into a minimal copy of
native_build_job_template but without the caching.

We keep all the current allow_fail and configure setups but do take
the opportunity to replace the -j`nproc --ignore=40` hack with
something that almost, but not quite, saturates the machine its being
built on.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .../custom-runners/ubuntu-24.04-aarch64.yml   | 230 ++++++++----------
 1 file changed, 96 insertions(+), 134 deletions(-)

diff --git a/.gitlab-ci.d/custom-runners/ubuntu-24.04-aarch64.yml b/.gitlab-ci.d/custom-runners/ubuntu-24.04-aarch64.yml
index d26c7827f45..46db9ae0138 100644
--- a/.gitlab-ci.d/custom-runners/ubuntu-24.04-aarch64.yml
+++ b/.gitlab-ci.d/custom-runners/ubuntu-24.04-aarch64.yml
@@ -2,150 +2,112 @@
 # setup by the scripts/ci/setup/ubuntu/build-environment.yml task
 # "Install basic packages to build QEMU on Ubuntu 24.04"
 
+.ubuntu_aarch64_template:
+  extends: .custom_runner_template
+  needs: []
+  stage: build
+  tags:
+    - ubuntu_24.04
+    - aarch64
+  rules:
+    - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
+    - if: "$AARCH64_RUNNER_AVAILABLE"
+  before_script:
+    - source scripts/ci/gitlab-ci-section
+    - section_start setup "Pre-script setup"
+    - JOBS=$(expr $(nproc) - 4)
+    - section_end setup
+  script:
+    - mkdir build
+    - cd build
+    - section_start configure "Running configure"
+    - ../configure $CONFIGURE_ARGS ||
+          { cat config.log meson-logs/meson-log.txt && exit 1; }
+    - section_end configure
+    - section_start build "Building QEMU"
+    - make --output-sync -j"$JOBS"
+    - section_end build
+    - section_start test "Running tests"
+    - if test -n "$MAKE_CHECK_ARGS";
+      then
+        make -j"$JOBS" $MAKE_CHECK_ARGS ;
+      fi
+    - section_end test
+
 ubuntu-24.04-aarch64-all-linux-static:
- extends: .custom_runner_template
- needs: []
- stage: build
- tags:
- - ubuntu_24.04
- - aarch64
- rules:
- - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
- - if: "$AARCH64_RUNNER_AVAILABLE"
- script:
- - mkdir build
- - cd build
- # Disable -static-pie due to build error with system libc:
- # https://bugs.launchpad.net/ubuntu/+source/glibc/+bug/1987438
- - ../configure --enable-debug --static --disable-system --disable-pie
-   || { cat config.log meson-logs/meson-log.txt; exit 1; }
- - make --output-sync -j`nproc --ignore=40`
- - make check-tcg
- - make --output-sync -j`nproc --ignore=40` check
+  extends: .ubuntu_aarch64_template
+  variables:
+    # Disable -static-pie due to build error with system libc:
+    # https://bugs.launchpad.net/ubuntu/+source/glibc/+bug/1987438
+    CONFIGURE_ARGS: --enable-debug --static --disable-system --disable-pie
+    MAKE_CHECK_ARGS: check-tcg
 
 ubuntu-24.04-aarch64-all:
- extends: .custom_runner_template
- needs: []
- stage: build
- tags:
- - ubuntu_24.04
- - aarch64
- rules:
- - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
-   when: manual
-   allow_failure: true
- - if: "$AARCH64_RUNNER_AVAILABLE"
-   when: manual
-   allow_failure: true
- script:
- - mkdir build
- - cd build
- - ../configure
-   || { cat config.log meson-logs/meson-log.txt; exit 1; }
- - make --output-sync -j`nproc --ignore=40`
- - make --output-sync -j`nproc --ignore=40` check
+  extends: .ubuntu_aarch64_template
+  variables:
+    MAKE_CHECK_ARGS: check
+  rules:
+    - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
+      when: manual
+      allow_failure: true
+    - if: "$AARCH64_RUNNER_AVAILABLE"
+      when: manual
+      allow_failure: true
 
 ubuntu-24.04-aarch64-without-defaults:
- extends: .custom_runner_template
- needs: []
- stage: build
- tags:
- - ubuntu_24.04
- - aarch64
- rules:
- - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
-   when: manual
-   allow_failure: true
- - if: "$AARCH64_RUNNER_AVAILABLE"
-   when: manual
-   allow_failure: true
- script:
- - mkdir build
- - cd build
- - ../configure --disable-user --without-default-devices --without-default-features
-   || { cat config.log meson-logs/meson-log.txt; exit 1; }
- - make --output-sync -j`nproc --ignore=40`
- - make --output-sync -j`nproc --ignore=40` check
+  extends: .ubuntu_aarch64_template
+  variables:
+    CONFIGURE_ARGS: --disable-user --without-default-devices --without-default-features
+    MAKE_CHECK_ARGS: check
+  rules:
+    - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
+      when: manual
+      allow_failure: true
+    - if: "$AARCH64_RUNNER_AVAILABLE"
+      when: manual
+      allow_failure: true
 
 ubuntu-24.04-aarch64-alldbg:
- extends: .custom_runner_template
- needs: []
- stage: build
- tags:
- - ubuntu_24.04
- - aarch64
- rules:
- - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
- - if: "$AARCH64_RUNNER_AVAILABLE"
- script:
- - mkdir build
- - cd build
- - ../configure --enable-debug
-   || { cat config.log meson-logs/meson-log.txt; exit 1; }
- - make clean
- - make --output-sync -j`nproc --ignore=40`
- - make --output-sync -j`nproc --ignore=40` check
+  extends: .ubuntu_aarch64_template
+  variables:
+    CONFIGURE_ARGS: --enable-debug
+    MAKE_CHECK_ARGS: check-tcg
 
 ubuntu-24.04-aarch64-clang:
- extends: .custom_runner_template
- needs: []
- stage: build
- tags:
- - ubuntu_24.04
- - aarch64
- rules:
- - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
-   when: manual
-   allow_failure: true
- - if: "$AARCH64_RUNNER_AVAILABLE"
-   when: manual
-   allow_failure: true
- script:
- - mkdir build
- - cd build
- - ../configure --disable-libssh --cc=clang --cxx=clang++ --enable-ubsan
-   || { cat config.log meson-logs/meson-log.txt; exit 1; }
- - make --output-sync -j`nproc --ignore=40`
- - make --output-sync -j`nproc --ignore=40` check
+  extends: .ubuntu_aarch64_template
+  variables:
+    CONFIGURE_ARGS: --cc=clang --cxx=clang++ --enable-ubsan
+    MAKE_CHECK_ARGS: check
+  rules:
+    - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
+      when: manual
+      allow_failure: true
+    - if: "$AARCH64_RUNNER_AVAILABLE"
+      when: manual
+      allow_failure: true
 
 ubuntu-24.04-aarch64-tci:
- needs: []
- stage: build
- tags:
- - ubuntu_24.04
- - aarch64
- rules:
- - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
-   when: manual
-   allow_failure: true
- - if: "$AARCH64_RUNNER_AVAILABLE"
-   when: manual
-   allow_failure: true
- script:
- - mkdir build
- - cd build
- - ../configure --enable-tcg-interpreter
-   || { cat config.log meson-logs/meson-log.txt; exit 1; }
- - make --output-sync -j`nproc --ignore=40`
+  extends: .ubuntu_aarch64_template
+  variables:
+    CONFIGURE_ARGS: --enable-tcg-interpreter
+    MAKE_CHECK_ARGS: check
+  rules:
+    - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
+      when: manual
+      allow_failure: true
+    - if: "$AARCH64_RUNNER_AVAILABLE"
+      when: manual
+      allow_failure: true
 
 ubuntu-24.04-aarch64-notcg:
- extends: .custom_runner_template
- needs: []
- stage: build
- tags:
- - ubuntu_24.04
- - aarch64
- rules:
- - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
-   when: manual
-   allow_failure: true
- - if: "$AARCH64_RUNNER_AVAILABLE"
-   when: manual
-   allow_failure: true
- script:
- - mkdir build
- - cd build
- - ../configure --disable-tcg --with-devices-aarch64=minimal
-   || { cat config.log meson-logs/meson-log.txt; exit 1; }
- - make --output-sync -j`nproc --ignore=40`
- - make --output-sync -j`nproc --ignore=40` check
+  extends: .ubuntu_aarch64_template
+  variables:
+    CONFIGURE_ARGS: --disable-tcg --with-devices-aarch64=minimal
+    MAKE_CHECK_ARGS: check
+  rules:
+    - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
+      when: manual
+      allow_failure: true
+    - if: "$AARCH64_RUNNER_AVAILABLE"
+      when: manual
+      allow_failure: true
-- 
2.47.3


