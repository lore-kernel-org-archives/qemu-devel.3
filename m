Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C82AC54ED1
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 17:05:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJxiw-0005fn-Vj; Tue, 27 May 2025 13:04:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uJxiv-0005eY-AP
 for qemu-devel@nongnu.org; Tue, 27 May 2025 13:04:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uJxit-0006gg-Am
 for qemu-devel@nongnu.org; Tue, 27 May 2025 13:04:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748365458;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yPAxOWVvQVuJ1+MC8VsWb1BHfSQr4WlF8mkT7eSpGJA=;
 b=UWM8vMT1SM12XpFlG0a1wWqB55fdcQz09pHY6IEvOA22g+VGxTWhpJVyTQSZSo+3ZklQfp
 eu4UtjpuFyyiJVqvviLw6uL3BnHcDvcHcP3g/4hfeZZE7dLYVNWtGAu2NuX4RFOOrM9Li0
 qUTrRWre9u0FMyfrYocMdLBo8jiMU9M=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-199-rpxaveZdPjmLOyViu1dj4Q-1; Tue, 27 May 2025 13:04:14 -0400
X-MC-Unique: rpxaveZdPjmLOyViu1dj4Q-1
X-Mimecast-MFC-AGG-ID: rpxaveZdPjmLOyViu1dj4Q_1748365453
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-ad51ceda1d9so3647266b.1
 for <qemu-devel@nongnu.org>; Tue, 27 May 2025 10:04:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748365451; x=1748970251;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yPAxOWVvQVuJ1+MC8VsWb1BHfSQr4WlF8mkT7eSpGJA=;
 b=GXy7BTLczhQRTU6FO1UF7qfifHCfJEQONdwqT3vSCHDYZaW79Rv0+UhCK8GNLO5pSy
 2mn02UgXAjl6Iqz21/lJcPWvMF6Zl8NrZOOFx6ycN+g6zlOsHNc50LP7wBjpmDRhRnAV
 ekL4sYvG4Zf7VJp/V09w+mkLXUGkpQ/91XT1Z5Jfo62swqKIl52qswiU+yxrCv5rFYqD
 c/EoJwK+n2Q2XIx5/32qvp938z9ImTkON7EZuCnPsXkJJrM7noNQnMFCJQ2ni02hy85d
 AVoV9bzCVsLBRO0aYHaqEWCGLgZvPOYr3uc9oggQsl87HHrN9FTu/w+OLJGFvI06sIe1
 D/BA==
X-Gm-Message-State: AOJu0YyW2dBEOrQQdLxpLIxM+ON/WxsZH//4LziOhHBxUQZclkJ0aIS2
 TNY0L2JWS1zdrhpEKR/BGr6qOHrK5IiK7JkSkN+a5k0/Md0GtJzkQGmzob5Fb1g+rUDSaaBmrlO
 fPt+5xW3tgNN2TPKo6KK92r2htnnJQ3k67yRuMSccectWcs/NpfndZEFZpBnvu1gybO0Ee+FoAs
 CWhOKt6EmHKjg7nNe6R5/lV/6yYCpXhwKTflhsE7s5
X-Gm-Gg: ASbGncuNk5yYfZIiGSNjcDJx+KivY/YPdnZCWH+W+InYP3gruGoXcxxWjdYwkvdeoDH
 1DtSv4VyQ7vazBKW5llu4LaBl/wLDPRsurqm1F2P6CHwMQZ0LpJNtjO+W49omTR9x4FpRIsLwWb
 bNnIK2o8Auej4ST9zpGRmKUnFxTFagofRT3Gf8ciI5v8q+0CfZHDdQzorfuKt9nBfQ6VzXou/ct
 9EAHAK0gj61rgyZu5E5UJl3lPpD3lfI+G+jaL4FnAYIkrW8mDr6osQZZ4O2k9cwpBh/jcctl0T2
 E8mc/ewBlHTnwA==
X-Received: by 2002:a17:906:6a13:b0:ad8:908d:20f3 with SMTP id
 a640c23a62f3a-ad898a1dec8mr135268966b.28.1748365451350; 
 Tue, 27 May 2025 10:04:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlBnP3ygn/lL5vW1k/z9X5h2Z1kGwObG7A6cCf1DQnEMTDeOqBo+S86KVDMuSPOueMQA5sQg==
X-Received: by 2002:a17:906:6a13:b0:ad8:908d:20f3 with SMTP id
 a640c23a62f3a-ad898a1dec8mr135264066b.28.1748365450773; 
 Tue, 27 May 2025 10:04:10 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.46.79])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad89bb4aa63sm16036866b.161.2025.05.27.10.04.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 May 2025 10:04:10 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH 3/6] build, dockerfiles: add support for detecting rustdoc
Date: Tue, 27 May 2025 19:04:01 +0200
Message-ID: <20250527170404.1580482-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250527170404.1580482-1-pbonzini@redhat.com>
References: <20250527170404.1580482-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.907,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

rustdoc is effectively a custom version of rustc, and it is necessary to
specify it in order to run doctests from Meson.  Add the relevant configure
option and environment variables.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure                                           | 8 ++++++++
 meson.build                                         | 2 ++
 tests/docker/dockerfiles/fedora-rust-nightly.docker | 2 ++
 tests/docker/dockerfiles/ubuntu2204.docker          | 1 +
 tests/lcitool/refresh                               | 3 +++
 5 files changed, 16 insertions(+)

diff --git a/configure b/configure
index 74b3865e51e..2b2b3d65979 100755
--- a/configure
+++ b/configure
@@ -209,6 +209,8 @@ for opt do
   ;;
   --rustc=*) RUSTC="$optarg"
   ;;
+  --rustdoc=*) RUSTDOC="$optarg"
+  ;;
   --cpu=*) cpu="$optarg"
   ;;
   --extra-cflags=*)
@@ -323,6 +325,7 @@ pkg_config="${PKG_CONFIG-${cross_prefix}pkg-config}"
 sdl2_config="${SDL2_CONFIG-${cross_prefix}sdl2-config}"
 
 rustc="${RUSTC-rustc}"
+rustdoc="${RUSTDOC-rustdoc}"
 
 check_define() {
 cat > $TMPC <<EOF
@@ -660,6 +663,8 @@ for opt do
   ;;
   --rustc=*)
   ;;
+  --rustdoc=*)
+  ;;
   --make=*)
   ;;
   --install=*)
@@ -890,6 +895,7 @@ Advanced options (experts only):
   --cxx=CXX                use C++ compiler CXX [$cxx]
   --objcc=OBJCC            use Objective-C compiler OBJCC [$objcc]
   --rustc=RUSTC            use Rust compiler RUSTC [$rustc]
+  --rustdoc=RUSTDOC        use rustdoc binary RUSTDOC [$rustdoc]
   --extra-cflags=CFLAGS    append extra C compiler flags CFLAGS
   --extra-cxxflags=CXXFLAGS append extra C++ compiler flags CXXFLAGS
   --extra-objcflags=OBJCFLAGS append extra Objective C compiler flags OBJCFLAGS
@@ -1901,8 +1907,10 @@ if test "$skip_meson" = no; then
   if test "$rust" != disabled; then
     if test "$rust_host_triple" != "$rust_target_triple"; then
       echo "rust = [$(meson_quote $rustc --target "$rust_target_triple")]" >> $cross
+      echo "rustdoc = [$(meson_quote $rustdoc --target "$rust_target_triple")]" >> $cross
     else
       echo "rust = [$(meson_quote $rustc)]" >> $cross
+      echo "rustdoc = [$(meson_quote $rustdoc)]" >> $cross
     fi
   fi
   echo "ar = [$(meson_quote $ar)]" >> $cross
diff --git a/meson.build b/meson.build
index 5a2098a2e94..eebd74b1fce 100644
--- a/meson.build
+++ b/meson.build
@@ -106,6 +106,7 @@ if have_rust
 endif
 
 if have_rust
+  rustdoc = find_program('rustdoc', required: get_option('rust'))
   bindgen = find_program('bindgen', required: get_option('rust'))
   if not bindgen.found() or bindgen.version().version_compare('<0.60.0')
     if get_option('rust').enabled()
@@ -4729,6 +4730,7 @@ if have_rust
   summary_info += {'Rust target':     config_host['RUST_TARGET_TRIPLE']}
   summary_info += {'rustc':           ' '.join(rustc.cmd_array())}
   summary_info += {'rustc version':   rustc.version()}
+  summary_info += {'rustdoc':         rustdoc}
   summary_info += {'bindgen':         bindgen.full_path()}
   summary_info += {'bindgen version': bindgen.version()}
 endif
diff --git a/tests/docker/dockerfiles/fedora-rust-nightly.docker b/tests/docker/dockerfiles/fedora-rust-nightly.docker
index fe4a6ed48d6..4a033309b38 100644
--- a/tests/docker/dockerfiles/fedora-rust-nightly.docker
+++ b/tests/docker/dockerfiles/fedora-rust-nightly.docker
@@ -156,6 +156,7 @@ ENV PYTHON "/usr/bin/python3"
 RUN dnf install -y wget
 ENV RUSTUP_HOME=/usr/local/rustup CARGO_HOME=/usr/local/cargo
 ENV RUSTC=/usr/local/rustup/toolchains/nightly-x86_64-unknown-linux-gnu/bin/rustc
+ENV RUSTDOC=/usr/local/rustup/toolchains/nightly-x86_64-unknown-linux-gnu/bin/rustdoc
 ENV CARGO=/usr/local/rustup/toolchains/nightly-x86_64-unknown-linux-gnu/bin/cargo
 RUN set -eux && \
   rustArch='x86_64-unknown-linux-gnu' && \
@@ -170,6 +171,7 @@ RUN set -eux && \
   /usr/local/cargo/bin/rustup run nightly cargo --version && \
   /usr/local/cargo/bin/rustup run nightly rustc --version && \
   test "$CARGO" = "$(/usr/local/cargo/bin/rustup +nightly which cargo)" && \
+  test "$RUSTDOC" = "$(/usr/local/cargo/bin/rustup +nightly which rustdoc)" && \
   test "$RUSTC" = "$(/usr/local/cargo/bin/rustup +nightly which rustc)"
 ENV PATH=$CARGO_HOME/bin:$PATH
 RUN /usr/local/cargo/bin/rustup run nightly cargo install bindgen-cli
diff --git a/tests/docker/dockerfiles/ubuntu2204.docker b/tests/docker/dockerfiles/ubuntu2204.docker
index 4a1cf2bdff3..28a6f932430 100644
--- a/tests/docker/dockerfiles/ubuntu2204.docker
+++ b/tests/docker/dockerfiles/ubuntu2204.docker
@@ -151,6 +151,7 @@ ENV MAKE "/usr/bin/make"
 ENV NINJA "/usr/bin/ninja"
 ENV PYTHON "/usr/bin/python3"
 ENV RUSTC=/usr/bin/rustc-1.77
+ENV RUSTDOC=/usr/bin/rustdoc-1.77
 ENV CARGO_HOME=/usr/local/cargo
 ENV PATH=$CARGO_HOME/bin:$PATH
 RUN DEBIAN_FRONTEND=noninteractive eatmydata \
diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index 8474ea822f4..d3488b2679e 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -121,6 +121,7 @@ fedora_rustup_nightly_extras = [
     "RUN dnf install -y wget\n",
     "ENV RUSTUP_HOME=/usr/local/rustup CARGO_HOME=/usr/local/cargo\n",
     "ENV RUSTC=/usr/local/rustup/toolchains/nightly-x86_64-unknown-linux-gnu/bin/rustc\n",
+    "ENV RUSTDOC=/usr/local/rustup/toolchains/nightly-x86_64-unknown-linux-gnu/bin/rustdoc\n",
     "ENV CARGO=/usr/local/rustup/toolchains/nightly-x86_64-unknown-linux-gnu/bin/cargo\n",
     "RUN set -eux && \\\n",
     "  rustArch='x86_64-unknown-linux-gnu' && \\\n",
@@ -135,6 +136,7 @@ fedora_rustup_nightly_extras = [
     "  /usr/local/cargo/bin/rustup run nightly cargo --version && \\\n",
     "  /usr/local/cargo/bin/rustup run nightly rustc --version && \\\n",
     '  test "$CARGO" = "$(/usr/local/cargo/bin/rustup +nightly which cargo)" && \\\n',
+    '  test "$RUSTDOC" = "$(/usr/local/cargo/bin/rustup +nightly which rustdoc)" && \\\n',
     '  test "$RUSTC" = "$(/usr/local/cargo/bin/rustup +nightly which rustc)"\n',
     'ENV PATH=$CARGO_HOME/bin:$PATH\n',
     'RUN /usr/local/cargo/bin/rustup run nightly cargo install bindgen-cli\n',
@@ -143,6 +145,7 @@ fedora_rustup_nightly_extras = [
 
 ubuntu2204_rust_extras = [
     "ENV RUSTC=/usr/bin/rustc-1.77\n",
+    "ENV RUSTDOC=/usr/bin/rustdoc-1.77\n",
     "ENV CARGO_HOME=/usr/local/cargo\n",
     'ENV PATH=$CARGO_HOME/bin:$PATH\n',
     "RUN DEBIAN_FRONTEND=noninteractive eatmydata \\\n",
-- 
2.49.0


