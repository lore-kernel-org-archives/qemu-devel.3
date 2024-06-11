Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D63CBC25B76
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 10:35:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGyps-0003S8-PN; Tue, 11 Jun 2024 06:34:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sGypr-0003RW-0h
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 06:34:39 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sGypo-0002md-W9
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 06:34:38 -0400
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2eabd22d3f4so66168331fa.1
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2024 03:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718102074; x=1718706874; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cYO/SbAMZR8zG8WQ2uHmTCcKmd+CH0lFQCVFLcVdTQM=;
 b=Sj2u9UBv3jFm4XOU58dyn0fc7Q/1M0ZbsDXLFUaUpe8w1sFk1mN2cw1/E6XtVXQu0g
 PK5ui7s226CvdIQMC+Bl13EHsufyugMh7FdEwcIRRPI3Sr1leZtapr7aNa0+xAVYaCwB
 dPPHLhmfzC2r0W8XRoKG2qqDrU+pRtq/txtFstY45DXEuFOvjwzkaQIsW1ZClQoR4mjS
 Qld55SubFuAQxE2F2ixduYdW/g651x5BV6Z7QkSy9KDovCYLgiEj8pnuPhgBZcDZbwhc
 ha4QQxWH7EocYrgDdq+HtmxOatVRKVzFpFyaSPsWvt9OtjJ1uJKpVwXGxCWzNwXl056T
 jHtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718102075; x=1718706875;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cYO/SbAMZR8zG8WQ2uHmTCcKmd+CH0lFQCVFLcVdTQM=;
 b=g4IihlgzuF+rKBuAA4KRZgLfKkEPAYl3AHATvtA8zTBgcX2zuAnlhuQGbV6EGRtAEZ
 NRVjkBeCuNDN+XAluuywjKIRmlmGmE3o4qL7TAmcpSglUfuG37NExfpDFRIiKyuduEjI
 +1mEa91Wrh+cQkinZjWRDUxvE3jC3/ui06MrD6jogui2CIS+a3lqx2ZEL7l8YVcB7K9S
 /Di8ElKo764Gq2mxg5juNzwSEcdjqkq4lB/e0O9lshAIu1U7D6Lj/2xKf9hgFNduNgd3
 GfCS2OT24NNKYguSzyRAzgf/e5gzcUbjVXf8HB6Qtg+gu9GJhQoHs+J+bNWcB1zW2p+s
 09Sw==
X-Gm-Message-State: AOJu0Yw/8z5q7NaDf5WqSqLJlJw53wJiN1CYIFU72hxFCS+TWZ3kmR+B
 BCA9oH3AHNbk3Hy9zkoVWCJ9JH8JgwQVfw/SDF2kL1K+sflq11qIbr10WPscZaVQ7UsGrnAlQJU
 WhhM=
X-Google-Smtp-Source: AGHT+IFC5+1D7XvmEsZgZtabqqCNvHKCtxURDeXBjcZs+juzpClB+NllS7MyNTY1BF43uB498j7dqQ==
X-Received: by 2002:a2e:a791:0:b0:2eb:da22:ee7 with SMTP id
 38308e7fff4ca-2ebda2210a1mr55824711fa.12.1718102074450; 
 Tue, 11 Jun 2024 03:34:34 -0700 (PDT)
Received: from localhost.localdomain (adsl-33.37.6.162.tellas.gr.
 [37.6.162.33]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42232e71865sm30878795e9.46.2024.06.11.03.34.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 03:34:34 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: [RFC PATCH v2 4/5] DO NOT MERGE: add rustdoc build for gitlab pages
Date: Tue, 11 Jun 2024 13:33:33 +0300
Message-ID: <69e016883dea71ba10207d3f33845aa681d5d24d.1718101832.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <rust-pl011-rfc-v2.git.manos.pitsidianakis@linaro.org>
References: <rust-pl011-rfc-v2.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lj1-x22e.google.com
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


