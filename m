Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26663D68BCD
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 16:42:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBzOG-0007EK-N3; Fri, 15 Nov 2024 11:41:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tBzNr-0006fX-LE
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 11:41:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tBzNq-0002O1-4t
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 11:41:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731688881;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R9drXR6Ude9Syf7XBgbJFTV9jiXiqgiqWNTd79QJqvw=;
 b=Ro4lcg7hidbLeLSLXRgRGZ5x8P8XYxb48kmgJVGHMj1fSZoiscH3mUxrwla63Hq05hDuJP
 0Pbuca2nwN6LrlL7nO0zL56yweW+QdB2YDUww7DojSYqdfHPB2ZMm/WKKi2jDGN0ue2tV/
 GDdrP3PoH3YM9HfJW/9EBnH1DV2Il4M=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-rPKb8cCfOXK6365n2uWKgQ-1; Fri, 15 Nov 2024 11:41:19 -0500
X-MC-Unique: rPKb8cCfOXK6365n2uWKgQ-1
X-Mimecast-MFC-AGG-ID: rPKb8cCfOXK6365n2uWKgQ
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-539e13b8143so887074e87.0
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2024 08:41:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731688873; x=1732293673;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R9drXR6Ude9Syf7XBgbJFTV9jiXiqgiqWNTd79QJqvw=;
 b=T+xYvhdT0JLK8iaOS3Nk7DwGxb+I9kB18xnmNrOnkLf+EFZLZDCRZTAFopO7uRrfTe
 sUbQY2V2AG2gvhGL9V4/InKxEJplZ6XBZLBeHDSJulu5vHHkKa4HpmloIVOfV1w3UBQV
 ZMoMebOK3UiCJDBc3IrqV3tI2TZQ3w4BR4aDPeqOiU43AdusQlHQnjCiE9vd+EipZR5R
 wymBT1MxJ3fkB5bCrXCP+1bkXwf46AK1OryOochkLOyUPFmILiIe6Dl+aXC5Q1LpMDWe
 w9lzv41QiJL4cqFZQbXLtLYGyGIPtG0Xdwmcj5zbHZ0ZB6MimV2BhPXfZym7Bzb4Wf8b
 T7mQ==
X-Gm-Message-State: AOJu0YwkNfyT01JOqFRsDj15L6y27umW3bVQqF+MWrw5GxuA7bjoGVy5
 zFzs3Vn03TEyp7uX1Z2G4zJBQHR+zPnb7mhoGZMJsaFTTZijaff2QkpntIueEu0ao7eJn7k1M9Y
 d6A2o4c2pr9haJ6aHrX7XyxgWxSsvh1Tbs9k7LFTroVp42adYLHYlxdyQ7Wm7i/r1eZLTaxDiZQ
 HUb66SfdQR/mG4V8Nk7RLoCSfNdb3VRUjYyb0XQvs=
X-Received: by 2002:a05:6512:a8b:b0:53d:a4ff:31d7 with SMTP id
 2adb3069b0e04-53dab3bf5a5mr1798644e87.40.1731688872742; 
 Fri, 15 Nov 2024 08:41:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFBxdEuDpU02hegQikxa2pwFvauIp8Gy2nDC9GIpzg2YewMmP3fd8pNPe7EWiYWovEJeeHCLQ==
X-Received: by 2002:a05:6512:a8b:b0:53d:a4ff:31d7 with SMTP id
 2adb3069b0e04-53dab3bf5a5mr1798622e87.40.1731688872258; 
 Fri, 15 Nov 2024 08:41:12 -0800 (PST)
Received: from [192.168.10.3] ([151.49.84.243])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432dab78881sm58647175e9.13.2024.11.15.08.41.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2024 08:41:09 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org, berrange@redhat.com, junjie.mao@hotmail.com,
 manos.pitsidianakis@linaro.org, kwolf@redhat.com
Subject: [PATCH 11/12] rust: ci: add job that runs Rust tools
Date: Fri, 15 Nov 2024 17:40:24 +0100
Message-ID: <20241115164025.1917618-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241115163944.1917393-1-pbonzini@redhat.com>
References: <20241115163944.1917393-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.12,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Code checks, as well as documentation generation, are not yet tied
to "make check" because they need new version of the Rust toolchain
(even nightly in the case of "rustfmt").  Run them in CI using the
existing nightly-Rust container.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .gitlab-ci.d/static_checks.yml                | 23 +++++++++++++++++++
 .../dockerfiles/fedora-rust-nightly.docker    |  4 ++++
 tests/lcitool/refresh                         |  4 ++++
 3 files changed, 31 insertions(+)

diff --git a/.gitlab-ci.d/static_checks.yml b/.gitlab-ci.d/static_checks.yml
index ad9f426a52f..f6f22875265 100644
--- a/.gitlab-ci.d/static_checks.yml
+++ b/.gitlab-ci.d/static_checks.yml
@@ -46,3 +46,26 @@ check-python-tox:
     QEMU_JOB_OPTIONAL: 1
   needs:
     job: python-container
+
+check-rust-tools-nightly:
+  extends: .base_job_template
+  stage: test
+  image: $CI_REGISTRY_IMAGE/qemu/fedora-rust-nightly:$QEMU_CI_CONTAINER_TAG
+  script:
+    - source scripts/ci/gitlab-ci-section
+    - section_start test "Running Rust code checks"
+    - cd build
+    - pyvenv/bin/meson devenv -w ../rust ${CARGO-cargo} fmt --check
+    - make clippy
+    - make rustdoc
+    - section_end test
+  variables:
+    GIT_DEPTH: 1
+  needs:
+    - job: build-system-fedora-rust-nightly
+      artifacts: true
+  artifacts:
+    when: on_success
+    expire_in: 2 days
+    paths:
+      - rust/target/doc
diff --git a/tests/docker/dockerfiles/fedora-rust-nightly.docker b/tests/docker/dockerfiles/fedora-rust-nightly.docker
index 9180c8b5222..a8e4fb279a7 100644
--- a/tests/docker/dockerfiles/fedora-rust-nightly.docker
+++ b/tests/docker/dockerfiles/fedora-rust-nightly.docker
@@ -155,6 +155,7 @@ ENV PYTHON "/usr/bin/python3"
 RUN dnf install -y wget
 ENV RUSTUP_HOME=/usr/local/rustup CARGO_HOME=/usr/local/cargo
 ENV RUSTC=/usr/local/rustup/toolchains/nightly-x86_64-unknown-linux-gnu/bin/rustc
+ENV CARGO=/usr/local/rustup/toolchains/nightly-x86_64-unknown-linux-gnu/bin/cargo
 RUN set -eux && \
   rustArch='x86_64-unknown-linux-gnu' && \
   rustupSha256='6aeece6993e902708983b209d04c0d1dbb14ebb405ddb87def578d41f920f56d' && \
@@ -165,10 +166,13 @@ RUN set -eux && \
   ./rustup-init -y --no-modify-path --profile default --default-toolchain nightly --default-host ${rustArch} && \
   chmod -R a+w $RUSTUP_HOME $CARGO_HOME && \
   /usr/local/cargo/bin/rustup --version && \
+  /usr/local/cargo/bin/rustup run nightly cargo --version && \
   /usr/local/cargo/bin/rustup run nightly rustc --version && \
+  test "$CARGO" = "$(/usr/local/cargo/bin/rustup +nightly which cargo)" && \
   test "$RUSTC" = "$(/usr/local/cargo/bin/rustup +nightly which rustc)"
 ENV PATH=$CARGO_HOME/bin:$PATH
 RUN /usr/local/cargo/bin/rustup run nightly cargo install bindgen-cli
+RUN $CARGO --list
 # As a final step configure the user (if env is defined)
 ARG USER
 ARG UID
diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index 51012783c0f..6720516b942 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -121,6 +121,7 @@ fedora_rustup_nightly_extras = [
     "RUN dnf install -y wget\n",
     "ENV RUSTUP_HOME=/usr/local/rustup CARGO_HOME=/usr/local/cargo\n",
     "ENV RUSTC=/usr/local/rustup/toolchains/nightly-x86_64-unknown-linux-gnu/bin/rustc\n",
+    "ENV CARGO=/usr/local/rustup/toolchains/nightly-x86_64-unknown-linux-gnu/bin/cargo\n",
     "RUN set -eux && \\\n",
     "  rustArch='x86_64-unknown-linux-gnu' && \\\n",
     "  rustupSha256='6aeece6993e902708983b209d04c0d1dbb14ebb405ddb87def578d41f920f56d' && \\\n",
@@ -131,10 +132,13 @@ fedora_rustup_nightly_extras = [
     "  ./rustup-init -y --no-modify-path --profile default --default-toolchain nightly --default-host ${rustArch} && \\\n",
     "  chmod -R a+w $RUSTUP_HOME $CARGO_HOME && \\\n",
     "  /usr/local/cargo/bin/rustup --version && \\\n",
+    "  /usr/local/cargo/bin/rustup run nightly cargo --version && \\\n",
     "  /usr/local/cargo/bin/rustup run nightly rustc --version && \\\n",
+    '  test "$CARGO" = "$(/usr/local/cargo/bin/rustup +nightly which cargo)" && \\\n',
     '  test "$RUSTC" = "$(/usr/local/cargo/bin/rustup +nightly which rustc)"\n',
     'ENV PATH=$CARGO_HOME/bin:$PATH\n',
     'RUN /usr/local/cargo/bin/rustup run nightly cargo install bindgen-cli\n',
+    'RUN $CARGO --list\n',
 ]
 
 ubuntu2204_bindgen_extras = [
-- 
2.47.0


