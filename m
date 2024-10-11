Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1476D24470
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2024 17:22:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szJ4V-0001BE-9E; Fri, 11 Oct 2024 13:04:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1szJ4R-0000wP-1q
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 13:04:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1szHe4-0007GZ-Qw
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 11:33:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728660816;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KBP8KN72yksxoMR09OnifWIQasn/XHHahVLEHBRRsYY=;
 b=dOl1DUXFnJWMjto16Y5VeMThHsoVXrYY59ynHDTU3jJi/38zWbns3uzUAf/dsSgn86uDz0
 4DZUkl0sDlmBnwyJG/Iwn9kJmbPIhROFZZhzcn0d79dXHrG/s70oi9Dv10PRPGuyfDm7a3
 BFQzwDKpq2ONUX9O8sbrGKHyiJ7tsCg=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-GCXhOHDAP0yfvDGpAF_SGQ-1; Fri, 11 Oct 2024 11:33:35 -0400
X-MC-Unique: GCXhOHDAP0yfvDGpAF_SGQ-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-5c92ad674aeso1522382a12.3
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2024 08:33:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728660813; x=1729265613;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KBP8KN72yksxoMR09OnifWIQasn/XHHahVLEHBRRsYY=;
 b=EzKoiy67qTykp/SbaGJFdrtDKbOcIigQ1uaah0vfDJc6kcqY98LWWkpF6NqIhQBZzV
 HUWQ0a+qkddLPaH7rCRZw0+orcVanEZMO+xlg7UzeLCqSur7TMo9PudrW7EftHYOb91Z
 V7BNULPPSesgLk5UZU94KRUd3ewzTRW/xRbZETuITN5qcg+IjwZW4nTHIylmeuOL3h2a
 qOkPJBJxZxQsxtQEq4IX6S8jHgFATG6+vi1UNjiNRjJjpdoREGcNNgSYPLaBOmj2LGuL
 djtLRk9o6r7+oIagx+ujs7y0R7YW1pB0JSGTjxWVHEQNCGuKW6cOymIk0sz1mghlZ90J
 3rJg==
X-Gm-Message-State: AOJu0YzsZiw8armi0F+nwLCF3hJdssQYiK0/aSO7FV7K1qkqpQl3lPkw
 kkxKlNIAIXCxLcDzDXwRUS68GzjlM7wl0M6uhGD+K1u6yJL6Kjyp/l3o64sBKYnCsyTyZzdFKlq
 p1MSzZ92ts6fCH6LXl2qaUxWfLVB0y0YFMeVS5N/EkGrW+jvC42G22G6nzvYnyIYGAT0NmdNU+H
 rgIy2RnKEgyNteSb4nZE1qoNTGQ7a5UTjIeo3jRRY=
X-Received: by 2002:a17:907:7fa1:b0:a99:6363:8a21 with SMTP id
 a640c23a62f3a-a99b93a78eemr265671366b.11.1728660812964; 
 Fri, 11 Oct 2024 08:33:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFk4EzJhEJFviC6Y/lsuY8koaKe4BUw02G/7eMI9Ddn5ocDpbrxNP8HBtdzrePTmajAg7kbHg==
X-Received: by 2002:a17:907:7fa1:b0:a99:6363:8a21 with SMTP id
 a640c23a62f3a-a99b93a78eemr265668666b.11.1728660812419; 
 Fri, 11 Oct 2024 08:33:32 -0700 (PDT)
Received: from avogadro.local ([151.81.124.37])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a99a7f28079sm222607666b.85.2024.10.11.08.33.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2024 08:33:31 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL v3 14/18] dockerfiles: add a Dockerfile using a nightly Rust
 toolchain
Date: Fri, 11 Oct 2024 17:32:22 +0200
Message-ID: <20241011153227.81770-15-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241011153227.81770-1-pbonzini@redhat.com>
References: <20241011153227.81770-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.15,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This will be useful in order to test QEMU's Rust code with nightly
clippy.  It can also be used to check that the code builds, until the
minimum supported Rust version is lowered enough to allow enabling Rust
in other Dockerfiles too.

Use a separate container, instead of the Fedora one, to avoid that
CI breaks for everyone if for some reason the rustup build turns out
to be shaky.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Acked-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .../dockerfiles/fedora-rust-nightly.docker    | 173 ++++++++++++++++++
 tests/lcitool/refresh                         |  26 +++
 2 files changed, 199 insertions(+)
 create mode 100644 tests/docker/dockerfiles/fedora-rust-nightly.docker

diff --git a/tests/docker/dockerfiles/fedora-rust-nightly.docker b/tests/docker/dockerfiles/fedora-rust-nightly.docker
new file mode 100644
index 00000000000..e642db163c7
--- /dev/null
+++ b/tests/docker/dockerfiles/fedora-rust-nightly.docker
@@ -0,0 +1,173 @@
+# THIS FILE WAS AUTO-GENERATED
+#
+#  $ lcitool dockerfile --layers all fedora-40 qemu
+#
+# https://gitlab.com/libvirt/libvirt-ci
+
+FROM registry.fedoraproject.org/fedora:40
+
+RUN dnf install -y nosync && \
+    printf '#!/bin/sh\n\
+if test -d /usr/lib64\n\
+then\n\
+    export LD_PRELOAD=/usr/lib64/nosync/nosync.so\n\
+else\n\
+    export LD_PRELOAD=/usr/lib/nosync/nosync.so\n\
+fi\n\
+exec "$@"\n' > /usr/bin/nosync && \
+    chmod +x /usr/bin/nosync && \
+    nosync dnf update -y && \
+    nosync dnf install -y \
+               SDL2-devel \
+               SDL2_image-devel \
+               alsa-lib-devel \
+               bash \
+               bc \
+               bison \
+               brlapi-devel \
+               bzip2 \
+               bzip2-devel \
+               ca-certificates \
+               capstone-devel \
+               ccache \
+               clang \
+               ctags \
+               cyrus-sasl-devel \
+               daxctl-devel \
+               dbus-daemon \
+               device-mapper-multipath-devel \
+               diffutils \
+               findutils \
+               flex \
+               fuse3-devel \
+               gcc \
+               gcovr \
+               gettext \
+               git \
+               glib2-devel \
+               glib2-static \
+               glibc-langpack-en \
+               glibc-static \
+               glusterfs-api-devel \
+               gnutls-devel \
+               gtk-vnc2-devel \
+               gtk3-devel \
+               hostname \
+               jemalloc-devel \
+               json-c-devel \
+               libaio-devel \
+               libasan \
+               libattr-devel \
+               libbpf-devel \
+               libcacard-devel \
+               libcap-ng-devel \
+               libcmocka-devel \
+               libcurl-devel \
+               libdrm-devel \
+               libepoxy-devel \
+               libfdt-devel \
+               libffi-devel \
+               libgcrypt-devel \
+               libiscsi-devel \
+               libjpeg-devel \
+               libnfs-devel \
+               libpmem-devel \
+               libpng-devel \
+               librbd-devel \
+               libseccomp-devel \
+               libselinux-devel \
+               libslirp-devel \
+               libssh-devel \
+               libtasn1-devel \
+               libubsan \
+               liburing-devel \
+               libusbx-devel \
+               libxdp-devel \
+               libzstd-devel \
+               llvm \
+               lttng-ust-devel \
+               lzo-devel \
+               make \
+               mesa-libgbm-devel \
+               meson \
+               mtools \
+               ncurses-devel \
+               nettle-devel \
+               ninja-build \
+               nmap-ncat \
+               numactl-devel \
+               openssh-clients \
+               pam-devel \
+               pcre-static \
+               pipewire-devel \
+               pixman-devel \
+               pkgconfig \
+               pulseaudio-libs-devel \
+               python3 \
+               python3-PyYAML \
+               python3-numpy \
+               python3-opencv \
+               python3-pillow \
+               python3-pip \
+               python3-sphinx \
+               python3-sphinx_rtd_theme \
+               python3-zombie-imp \
+               rdma-core-devel \
+               sed \
+               snappy-devel \
+               socat \
+               sparse \
+               spice-protocol \
+               spice-server-devel \
+               swtpm \
+               systemd-devel \
+               systemtap-sdt-devel \
+               tar \
+               tesseract \
+               tesseract-langpack-eng \
+               usbredir-devel \
+               util-linux \
+               virglrenderer-devel \
+               vte291-devel \
+               which \
+               xen-devel \
+               xorriso \
+               zlib-devel \
+               zlib-static \
+               zstd && \
+    nosync dnf autoremove -y && \
+    nosync dnf clean all -y && \
+    rm -f /usr/lib*/python3*/EXTERNALLY-MANAGED && \
+    rpm -qa | sort > /packages.txt && \
+    mkdir -p /usr/libexec/ccache-wrappers && \
+    ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/cc && \
+    ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/clang && \
+    ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/gcc
+
+ENV CCACHE_WRAPPERSDIR "/usr/libexec/ccache-wrappers"
+ENV LANG "en_US.UTF-8"
+ENV MAKE "/usr/bin/make"
+ENV NINJA "/usr/bin/ninja"
+ENV PYTHON "/usr/bin/python3"
+RUN dnf install -y wget
+ENV RUSTUP_HOME=/usr/local/rustup CARGO_HOME=/usr/local/cargo
+ENV RUSTC=/usr/local/rustup/toolchains/nightly-x86_64-unknown-linux-gnu/bin/rustc
+RUN set -eux && \
+  rustArch='x86_64-unknown-linux-gnu' && \
+  rustupSha256='6aeece6993e902708983b209d04c0d1dbb14ebb405ddb87def578d41f920f56d' && \
+  url="https://static.rust-lang.org/rustup/archive/1.27.1/${rustArch}/rustup-init" && \
+  wget "$url" && \
+  echo "${rustupSha256} *rustup-init" | sha256sum -c - && \
+  chmod +x rustup-init && \
+  ./rustup-init -y --no-modify-path --profile default --default-toolchain nightly --default-host ${rustArch} && \
+  chmod -R a+w $RUSTUP_HOME $CARGO_HOME && \
+  /usr/local/cargo/bin/rustup --version && \
+  /usr/local/cargo/bin/rustup run nightly rustc --version && \
+  test "$RUSTC" = "$(/usr/local/cargo/bin/rustup +nightly which rustc)"
+ENV PATH=$CARGO_HOME/bin:$PATH
+RUN /usr/local/cargo/bin/rustup run nightly cargo install bindgen-cli
+# As a final step configure the user (if env is defined)
+ARG USER
+ARG UID
+RUN if [ "${USER}" ]; then \
+  id ${USER} 2>/dev/null || useradd -u ${UID} -U ${USER}; fi
diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index a78219f7bc5..1ae0962f04c 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -116,6 +116,26 @@ debian12_extras = [
     "ENV QEMU_CONFIGURE_OPTS --enable-netmap\n"
 ]
 
+# Based on the hub.docker.com/library/rust Dockerfiles
+fedora_rustup_nightly_extras = [
+    "RUN dnf install -y wget\n",
+    "ENV RUSTUP_HOME=/usr/local/rustup CARGO_HOME=/usr/local/cargo\n",
+    "ENV RUSTC=/usr/local/rustup/toolchains/nightly-x86_64-unknown-linux-gnu/bin/rustc\n",
+    "RUN set -eux && \\\n",
+    "  rustArch='x86_64-unknown-linux-gnu' && \\\n",
+    "  rustupSha256='6aeece6993e902708983b209d04c0d1dbb14ebb405ddb87def578d41f920f56d' && \\\n",
+    '  url="https://static.rust-lang.org/rustup/archive/1.27.1/${rustArch}/rustup-init" && \\\n',
+    '  wget "$url" && \\\n',
+    '  echo "${rustupSha256} *rustup-init" | sha256sum -c - && \\\n',
+    "  chmod +x rustup-init && \\\n",
+    "  ./rustup-init -y --no-modify-path --profile default --default-toolchain nightly --default-host ${rustArch} && \\\n",
+    "  chmod -R a+w $RUSTUP_HOME $CARGO_HOME && \\\n",
+    "  /usr/local/cargo/bin/rustup --version && \\\n",
+    "  /usr/local/cargo/bin/rustup run nightly rustc --version && \\\n",
+    '  test "$RUSTC" = "$(/usr/local/cargo/bin/rustup +nightly which rustc)"\n',
+    'ENV PATH=$CARGO_HOME/bin:$PATH\n',
+    'RUN /usr/local/cargo/bin/rustup run nightly cargo install bindgen-cli\n',
+]
 
 def cross_build(prefix, targets):
     conf = "ENV QEMU_CONFIGURE_OPTS --cross-prefix=%s\n" % (prefix)
@@ -139,6 +159,12 @@ try:
     generate_dockerfile("opensuse-leap", "opensuse-leap-15")
     generate_dockerfile("ubuntu2204", "ubuntu-2204")
 
+    #
+    # Non-fatal Rust-enabled build
+    #
+    generate_dockerfile("fedora-rust-nightly", "fedora-40",
+                        trailer="".join(fedora_rustup_nightly_extras))
+
     #
     # Cross compiling builds
     #
-- 
2.46.2


