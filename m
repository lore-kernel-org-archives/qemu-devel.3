Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22B1DD1BDD2
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 17:30:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t80tJ-0000Hz-41; Mon, 04 Nov 2024 12:29:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t80sp-00083J-GT
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 12:28:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t80sn-0000TE-Rj
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 12:28:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730741331;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qtmTBH9nUwoIxrYW0EKHYqdJrQ1Dt9cCZWdrafrESwA=;
 b=KGIWyau7ORsBR64NVCWtZJbI2HmgQbQdyJkeWeVykFbiANeBH9sxM+b580bYvLZlC470I4
 T0pZe8Ks5UgSFZcW5ROoHamP8ulGwK07KdDBNUC7jurClDSZE0ahXwr0W3rLIOU3u8PmkX
 sLtPaEn4Wtnxm7oHBJ2rcfY4smCZgSk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-JcAfapVyNQCF0NnhWHFVAw-1; Mon, 04 Nov 2024 12:28:50 -0500
X-MC-Unique: JcAfapVyNQCF0NnhWHFVAw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4314c6ca114so33071255e9.1
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 09:28:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730741329; x=1731346129;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qtmTBH9nUwoIxrYW0EKHYqdJrQ1Dt9cCZWdrafrESwA=;
 b=JP9VxfRjD0wdfe5NHunUSOPYAAQHtjh8iColdKvxMA0WzCYVPrOFZfE/h6wmEBg7Ru
 GLNJrlvy/h6jxIBpAEh71yxaPyJkuKCR6bdzK7R1zrQJm9ppyimo2V+OKADQI+SRDoN/
 vNjAUT8SDBCDinBQfyxacUg4kTg857iupTHdLljwUqOV8FOOiwVGh1fX82YP6s8sySct
 2HMOpStpAZMKcSJoijVrJPAvRJ/dtwHqG0Ew0neCX/HjG9nlU7sD0wIx4l5SpSyx7ubx
 iRubuV9tn0jrunUBMM9SE0Qb0bBni+zzELjl9dW4fuc1LG3nH1UmdkOm3AEMWZNRNOEW
 RgHA==
X-Gm-Message-State: AOJu0YyzfCuWXdC5YNZJ6CJuERs5z7cOjffF1LP3jJ5pRxBOxFoKPcG4
 iyONj/zvajX28u1GY/J8CuZS6PmwNCOVSeMn1Oq2faJTws2+vGAv4Hlg2+WuP688gEMFs+cdDst
 /gJ6f4JCnAACYf99MSP7+51WBZOZuoxC/v8aH1AhC4KgrTgznBlp5mUCy9LQYTYLKhBb5OWXplf
 Ic6ND0at2djqHEWrYMu9EmJtSiwEnwR6NpG51gDFE=
X-Received: by 2002:a05:600c:4f04:b0:42c:acb0:dda5 with SMTP id
 5b1f17b1804b1-4327b6f9574mr141362675e9.1.1730741329259; 
 Mon, 04 Nov 2024 09:28:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGAHuBStURnLfYbcKDuQlvcoWwYo7TPZLJ9DbvsDyYolksHHUu89Hum8zQqG3RneWh745AqPw==
X-Received: by 2002:a05:600c:4f04:b0:42c:acb0:dda5 with SMTP id
 5b1f17b1804b1-4327b6f9574mr141362405e9.1.1730741328821; 
 Mon, 04 Nov 2024 09:28:48 -0800 (PST)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4327d5ac387sm164540165e9.1.2024.11.04.09.28.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 09:28:47 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>, Kevin Wolf <kwolf@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 39/40] dockerfiles: install bindgen from cargo on Ubuntu 22.04
Date: Mon,  4 Nov 2024 18:27:18 +0100
Message-ID: <20241104172721.180255-40-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241104172721.180255-1-pbonzini@redhat.com>
References: <20241104172721.180255-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Because Ubuntu 22.04 has a very old version of bindgen, that
does not have the important option --allowlist-file, it will
not be able to use --enable-rust out of the box.  Instead,
install the latest version of bindgen-cli via "cargo install"
in the container, following QEMU's own documentation.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/ci/setup/ubuntu/ubuntu-2204-aarch64.yaml |  1 -
 scripts/ci/setup/ubuntu/ubuntu-2204-s390x.yaml   |  1 -
 tests/docker/dockerfiles/ubuntu2204.docker       |  6 +++++-
 tests/lcitool/mappings.yml                       |  4 ++++
 tests/lcitool/refresh                            | 11 ++++++++++-
 5 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/scripts/ci/setup/ubuntu/ubuntu-2204-aarch64.yaml b/scripts/ci/setup/ubuntu/ubuntu-2204-aarch64.yaml
index dd89ba1b3a7..31078f96462 100644
--- a/scripts/ci/setup/ubuntu/ubuntu-2204-aarch64.yaml
+++ b/scripts/ci/setup/ubuntu/ubuntu-2204-aarch64.yaml
@@ -7,7 +7,6 @@
 packages:
   - bash
   - bc
-  - bindgen
   - bison
   - bsdextrautils
   - bzip2
diff --git a/scripts/ci/setup/ubuntu/ubuntu-2204-s390x.yaml b/scripts/ci/setup/ubuntu/ubuntu-2204-s390x.yaml
index 74f14d8d0fe..fdd50d03e88 100644
--- a/scripts/ci/setup/ubuntu/ubuntu-2204-s390x.yaml
+++ b/scripts/ci/setup/ubuntu/ubuntu-2204-s390x.yaml
@@ -7,7 +7,6 @@
 packages:
   - bash
   - bc
-  - bindgen
   - bison
   - bsdextrautils
   - bzip2
diff --git a/tests/docker/dockerfiles/ubuntu2204.docker b/tests/docker/dockerfiles/ubuntu2204.docker
index ce3aa39d4f3..5f8a811788a 100644
--- a/tests/docker/dockerfiles/ubuntu2204.docker
+++ b/tests/docker/dockerfiles/ubuntu2204.docker
@@ -13,7 +13,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
     eatmydata apt-get install --no-install-recommends -y \
                       bash \
                       bc \
-                      bindgen \
                       bison \
                       bsdextrautils \
                       bzip2 \
@@ -149,6 +148,11 @@ ENV LANG "en_US.UTF-8"
 ENV MAKE "/usr/bin/make"
 ENV NINJA "/usr/bin/ninja"
 ENV PYTHON "/usr/bin/python3"
+ENV CARGO_HOME=/usr/local/cargo
+ENV PATH=$CARGO_HOME/bin:$PATH
+RUN DEBIAN_FRONTEND=noninteractive eatmydata \
+  apt install -y --no-install-recommends cargo
+RUN cargo install bindgen-cli
 # As a final step configure the user (if env is defined)
 ARG USER
 ARG UID
diff --git a/tests/lcitool/mappings.yml b/tests/lcitool/mappings.yml
index 9c5ac87c1c2..c90b23a00f1 100644
--- a/tests/lcitool/mappings.yml
+++ b/tests/lcitool/mappings.yml
@@ -1,4 +1,8 @@
 mappings:
+  # Too old on Ubuntu 22.04; we install it from cargo instead
+  bindgen:
+    Ubuntu2204:
+
   flake8:
     OpenSUSELeap15:
 
diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index 0f16f4d525c..a46cbbdca41 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -137,6 +137,14 @@ fedora_rustup_nightly_extras = [
     'RUN /usr/local/cargo/bin/rustup run nightly cargo install bindgen-cli\n',
 ]
 
+ubuntu2204_bindgen_extras = [
+    "ENV CARGO_HOME=/usr/local/cargo\n",
+    'ENV PATH=$CARGO_HOME/bin:$PATH\n',
+    "RUN DEBIAN_FRONTEND=noninteractive eatmydata \\\n",
+    "  apt install -y --no-install-recommends cargo\n",
+    'RUN cargo install bindgen-cli\n',
+]
+
 def cross_build(prefix, targets):
     conf = "ENV QEMU_CONFIGURE_OPTS --cross-prefix=%s\n" % (prefix)
     targets = "ENV DEF_TARGET_LIST %s\n" % (targets)
@@ -157,7 +165,8 @@ try:
                         trailer="".join(debian12_extras))
     generate_dockerfile("fedora", "fedora-40")
     generate_dockerfile("opensuse-leap", "opensuse-leap-15")
-    generate_dockerfile("ubuntu2204", "ubuntu-2204")
+    generate_dockerfile("ubuntu2204", "ubuntu-2204",
+                        trailer="".join(ubuntu2204_bindgen_extras))
 
     #
     # Non-fatal Rust-enabled build
-- 
2.47.0


