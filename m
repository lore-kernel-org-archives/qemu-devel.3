Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11C53C2BA1A
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 20:16:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sK1iA-0002pI-TF; Wed, 19 Jun 2024 16:15:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sK1i9-0002oL-HF
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 16:15:17 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sK1i6-0001lb-5r
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 16:15:17 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-52ccc40e72eso122363e87.3
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2024 13:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718828111; x=1719432911; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cYO/SbAMZR8zG8WQ2uHmTCcKmd+CH0lFQCVFLcVdTQM=;
 b=pvZPpDAdOYcnNUw3JP/bBK1iEWhPvFOxb5yT5GGy4HorvmKl1OQr4JTddYZB5ZAb17
 tLE0dGFRBQZUzCVO+t7kKmoF5YT7+5pUlexsWG9cjsXbDY7yQ4DAbNZs7EDG4UgKLpH4
 fdOhVE5wMUArMV2/adTVozKegfoC9G0pOl+2FTIzkgZLydYGTCctgvq4T14E9mtO0CVV
 WFa8GTV4Sv+NysrvaXXMifnfY4+/CvyjNJTDqDFucPNjhCYA9t0iutYXSAQwknUKFR/Z
 +jqPdGytqa/Ytrp6E4tPlivNIGXmZdI71u0sZWZMCbOl5Y6n6IcqF0PMlaXHEQjLRyQS
 /PIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718828111; x=1719432911;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cYO/SbAMZR8zG8WQ2uHmTCcKmd+CH0lFQCVFLcVdTQM=;
 b=uAdGVwkZCbC3uc+Qmp+nN+yhROkueozYXYW+sfkH9J0/4lALuzZCD0sI5OshyG34M1
 o+hoK00C5EWNZDgKW9106NqU65LxojINMP8dvyFAYG1KWxYIbcmS0knGIXh+GTvxJ1vJ
 Zd1Ky/nNZqQ5Q/lu1aWkyQeJwc2t3wZaJe92Z/iPcbo+jdbWMpMBqyesdgBnR+k5akhh
 HU4wZQh8IJg3ikGlt8oEtKFoUb3JYjYogRRGZFnrg5kO53TnPorbjsvqwzGq4+gXpZzs
 0ujYXFh1Le7A/FGIn9gGlglF18Epkk6GmLzUjtU66eG9p9KnRG+/cwsH+rq+IXkS1EwO
 rYVw==
X-Gm-Message-State: AOJu0YzO9ZeOrJi3tIQTttK7VYySA4Re5nbHOjGamIASm/5Jd/7ZZ/PZ
 WRz6IiIC8L6Jmvosjspx0b1k1SiBL6COO12byWm7LKtapMfjPI4k+b8kqQh5e1T/XrdFd5zJizr
 ztwA=
X-Google-Smtp-Source: AGHT+IGqJIS3f3gf24pliSuPUuvwUB85qilEqqrxicIxL4f6BFz/lwgAICfJEhMxVYygGh3nc1+Abg==
X-Received: by 2002:a05:6512:281e:b0:52c:a88b:9997 with SMTP id
 2adb3069b0e04-52ccaa53ea8mr3263503e87.49.1718828110701; 
 Wed, 19 Jun 2024 13:15:10 -0700 (PDT)
Received: from localhost.localdomain (adsl-103.37.6.162.tellas.gr.
 [37.6.162.103]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4247101aac6sm45623235e9.0.2024.06.19.13.15.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jun 2024 13:15:10 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, rowan.hart@intel.com,
 Richard Henderson <richard.henderson@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: [RFC PATCH v3 4/5] DO NOT MERGE: add rustdoc build for gitlab pages
Date: Wed, 19 Jun 2024 23:14:01 +0300
Message-ID: <4ab9f69a8207eb9432d13da56a437f2c7cb83ef3.1718827153.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <rust-pl011-rfc-v3.git.manos.pitsidianakis@linaro.org>
References: <rust-pl011-rfc-v3.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lf1-x130.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Deploy the generated rustdocs for my personal rust qemu fork on gitlab.

The URL is:

https://rust-for-qemu-epilys-aebb06ca9f9adfe6584811c14ae44156501d935ba4.gitlab.io/pl011/index.html

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 .gitlab-ci.d/buildtest.yml | 64 +++++++++++++++++++++++++++-----------
 1 file changed, 45 insertions(+), 19 deletions(-)

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index 91c57efded..380c24897d 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -715,31 +715,57 @@ build-tools-and-docs-debian:
 # For contributor forks we want to publish from any repo so
 # that users can see the results of their commits, regardless
 # of what topic branch they're currently using
+# pages:
+#   extends: .base_job_template
+#   image: $CI_REGISTRY_IMAGE/qemu/debian:$QEMU_CI_CONTAINER_TAG
+#   stage: test
+#   needs:
+#     - job: build-tools-and-docs-debian
+#   script:
+#     - mkdir -p public
+#     # HTML-ised source tree
+#     - make gtags
+#     # We unset variables to work around a bug in some htags versions
+#     # which causes it to fail when the environment is large
+#     - CI_COMMIT_MESSAGE= CI_COMMIT_TAG_MESSAGE= htags
+#         -anT --tree-view=filetree -m qemu_init
+#         -t "Welcome to the QEMU sourcecode"
+#     - mv HTML public/src
+#     # Project documentation
+#     - make -C build install DESTDIR=$(pwd)/temp-install
+#     - mv temp-install/usr/local/share/doc/qemu/* public/
+#   artifacts:
+#     when: on_success
+#     paths:
+#       - public
+#   variables:
+#     QEMU_JOB_PUBLISH: 1
+# The Docker image that will be used to build your app
 pages:
-  extends: .base_job_template
-  image: $CI_REGISTRY_IMAGE/qemu/debian:$QEMU_CI_CONTAINER_TAG
-  stage: test
-  needs:
-    - job: build-tools-and-docs-debian
+  image: rust:latest
   script:
-    - mkdir -p public
-    # HTML-ised source tree
-    - make gtags
-    # We unset variables to work around a bug in some htags versions
-    # which causes it to fail when the environment is large
-    - CI_COMMIT_MESSAGE= CI_COMMIT_TAG_MESSAGE= htags
-        -anT --tree-view=filetree -m qemu_init
-        -t "Welcome to the QEMU sourcecode"
-    - mv HTML public/src
-    # Project documentation
-    - make -C build install DESTDIR=$(pwd)/temp-install
-    - mv temp-install/usr/local/share/doc/qemu/* public/
+    - rustup component add rustfmt
+    - DEBIAN_FRONTEND=noninteractive apt-get update -y
+    - DEBIAN_FRONTEND=noninteractive apt-get install -y python3-venv meson libgcrypt20-dev zlib1g-dev autoconf automake libtool bison flex git libglib2.0-dev libfdt-dev libpixman-1-dev ninja-build make libclang-14-dev
+    - cargo install bindgen-cli
+    - mkdir ./build/
+    - cd ./build/
+    - ../configure --enable-system --disable-kvm --target-list=aarch64-softmmu --enable-with-rust
+    - ninja "aarch64-softmmu-generated.rs"
+    - cp ./aarch64-softmmu-generated.rs ../rust/pl011/src/generated.rs.inc
+    - cd ../rust/pl011/
+    - cargo tree --depth 1 -e normal --prefix none | cut -d' ' -f1  | xargs
+      printf -- '-p %s\n'  | xargs cargo doc --no-deps --document-private-items --target x86_64-unknown-linux-gnu
+    - cd ./../..
+    - mv ./rust/pl011/target/x86_64-unknown-linux-gnu/doc ./public
   artifacts:
     when: on_success
     paths:
       - public
-  variables:
-    QEMU_JOB_PUBLISH: 1
+  rules:
+    # This ensures that only pushes to the default branch will trigger
+    # a pages deploy
+    - if: $CI_COMMIT_REF_NAME == $CI_DEFAULT_BRANCH
 
 coverity:
   image: $CI_REGISTRY_IMAGE/qemu/fedora:$QEMU_CI_CONTAINER_TAG
-- 
γαῖα πυρί μιχθήτω


