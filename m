Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1000CD2D108
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 13:55:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vferW-0003Gl-Lq; Tue, 13 Jan 2026 08:55:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1vferU-0003GV-Rq
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 08:55:08 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1vferT-0000YI-4v
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 08:55:08 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2a0bb2f093aso51850295ad.3
 for <qemu-devel@nongnu.org>; Tue, 13 Jan 2026 05:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768312506; x=1768917306; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iU/mkCd8lSJXdjfaFgASvcWxf6nZ4ct5ah9im64aH+o=;
 b=UB2wUXsHFva6EMx/d6yI+zIZJIGDQ8LUsLqpJoMISBxbMY24ZDbyDygdsr1UUThU8/
 OkCYJqRvHWUTHAJcVCNHtCYoKbY4GZGZsTKYc8y0mJFxcmD02FIdpLePvRQyWgkfu4wq
 bNKoNFQLZy788swh5H123Ojhi/SkYj3H2w2+Dhhap7zgFXwk+PHFvD1Cvt7Lz8iYMKgx
 wPh5ngt24mTzsLsHUEm/mhUXcRxDntkPD4CMmlDsnLp8FNLogs2f8izCBAvaAq3abKrp
 zDQvjBT3va6p2msPS5ZwBgMFZt2Gw2Sea5gvzuZVr/LA+9I0IPpCNWhwAbNRMjlwl3CZ
 YL4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768312506; x=1768917306;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iU/mkCd8lSJXdjfaFgASvcWxf6nZ4ct5ah9im64aH+o=;
 b=lIOLZA+CqWYbqiHDFZpN7kdloAUQvAGao9ZYfGvFx9j+cb1iDO17Rc4YtuhTb+mK3+
 YSWLvsF9V5alTBHjSk1uNHqa8beccXV/DvaKc3D6nPvhyoIGHN16n6KCRdnpgYVuPdaZ
 zty7H/S+9AtMBqS8lP8kMX9ohLYO70zRUHlE8M4XJIAYfaoUWTj0CfsiXjzT9kqOV3jB
 ZbtmTr3KJJaor+Ul0/pH6TYbZWfIrAwR+zLlp4X6gysUfgi6X2EC+zLDaQmRrHgyN3VA
 fDKGOdGQxWrE44wl3FvlT5k8LdYvEkakcKrJXjnh3Hj7juvODfiyP2i0b4v+UIB3pM0A
 CPpA==
X-Gm-Message-State: AOJu0YzB9oW2CUsxRvNy+2Ra3IxEwUGD4U4Vze1blVwFTrkPqgXifYTq
 JsiME1puFuzKw8tUAw4X74vyOqbuG5rQe+a9r9RUjpwjCrp/HshjkIsBM0++qUIS
X-Gm-Gg: AY/fxX6cfLWsdw38C6H11QEZPnLT5k4NOIPISPe5KLs1nJG4gdhGGWEFkv/sftRFZ4o
 uv48k3PVtl7zJAls+Ex1GQ4k4GnEah2jNAZ1NfTwqp6p4uoO/jptIXQkAJKlRIWgmaB0SXbxvzJ
 Cf7iajbeGcFw9D1NMYIbfCLdw/ZkasC3qR5vUfxXFzUuxyB6GgluLDaqC8tOraVpvu2vwPxECKs
 JJxqdIq+oJ5LYbTiAXhO3GIdKG6BDq5GAT8xOc+x5dgDG/MVXi1HaV5RHHtHjYpgwOGU/8sWENZ
 vq4MvPXMUJpsfnn0GHK2qLkXcdVGKBBoGhSq9S3V/WUfAnN+evqQ0i5WCyLRVM5uUvnes7ShWWP
 fj69NWCRcVYFzMK6uq7yRCFEDeeJeUhOTtBGHOsRCZwa2IQkBYMVCAP39JAaQZu39nMunqAZOjs
 eqsihNLj0Pfw==
X-Google-Smtp-Source: AGHT+IHFTcBO0rKJ3ElnxEZCc2IDGYW9i1qtmonAPXqeWHU+YI/WAhFkzTOCfrsIG72ZEo0esMIxDA==
X-Received: by 2002:a17:903:3c4d:b0:2a0:de4f:c99 with SMTP id
 d9443c01a7336-2a3ee4378f8mr164682305ad.9.1768312505602; 
 Tue, 13 Jan 2026 05:55:05 -0800 (PST)
Received: from ktock.. ([240d:1a:3b6:8b00:eb29:7536:a39f:7476])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3c3a2eesm38240465ad.6.2026.01.13.05.55.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 05:55:05 -0800 (PST)
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v5 3/4] dockerfiles: Add support for wasm64 to the wasm
 Dockerfile
Date: Tue, 13 Jan 2026 22:54:30 +0900
Message-ID: <3f21342f50e0412a32143fe21ecc0d8db95b3f37.1768308374.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1768308374.git.ktokunaga.mail@gmail.com>
References: <cover.1768308374.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This commit fixes Dockerfile of the wasm build to support both of wasm32 and
wasm64 build. Dockerfile takes the following build argument and use it for
building dependencies.

- TARGET_CPU: target wasm arch (wasm32 or wasm64)

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 MAINTAINERS                                   |  2 +-
 ...2-cross.docker => emsdk-wasm-cross.docker} | 26 ++++++++++++++-----
 2 files changed, 20 insertions(+), 8 deletions(-)
 rename tests/docker/dockerfiles/{emsdk-wasm32-cross.docker => emsdk-wasm-cross.docker} (89%)

V5:
- Removed -sMEMORY64 from the environment variables (e.g. CFLAGS) in the
  QEMU compilation stage.
- Updated the Dockerfile to build dependencies always with -sMEMORY64=1 for
  wasm64 target. The final QEMU compilation can be lowered to wasm32 by
  using configure's --wasm64-32bit-address-limit flag which enables
  Emscripten's MEMORY64=2.

diff --git a/MAINTAINERS b/MAINTAINERS
index 9a55b649e8..22974fdd73 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -671,7 +671,7 @@ F: include/system/os-wasm.h
 F: os-wasm.c
 F: util/coroutine-wasm.c
 F: configs/meson/emscripten.txt
-F: tests/docker/dockerfiles/emsdk-wasm32-cross.docker
+F: tests/docker/dockerfiles/emsdk-wasm-cross.docker
 
 Alpha Machines
 --------------
diff --git a/tests/docker/dockerfiles/emsdk-wasm32-cross.docker b/tests/docker/dockerfiles/emsdk-wasm-cross.docker
similarity index 89%
rename from tests/docker/dockerfiles/emsdk-wasm32-cross.docker
rename to tests/docker/dockerfiles/emsdk-wasm-cross.docker
index 1f08eb0b85..ecd5a02903 100644
--- a/tests/docker/dockerfiles/emsdk-wasm32-cross.docker
+++ b/tests/docker/dockerfiles/emsdk-wasm-cross.docker
@@ -1,14 +1,15 @@
 # syntax = docker/dockerfile:1.5
 
-ARG EMSDK_VERSION_QEMU=3.1.50
+ARG EMSDK_VERSION_QEMU=4.0.10
 ARG ZLIB_VERSION=1.3.1
 ARG GLIB_MINOR_VERSION=2.84
 ARG GLIB_VERSION=${GLIB_MINOR_VERSION}.0
 ARG PIXMAN_VERSION=0.44.2
-ARG FFI_VERSION=v3.4.7
+ARG FFI_VERSION=v3.5.2
 ARG MESON_VERSION=1.5.0
+ARG TARGET_CPU=wasm32
 
-FROM docker.io/emscripten/emsdk:$EMSDK_VERSION_QEMU AS build-base
+FROM docker.io/emscripten/emsdk:$EMSDK_VERSION_QEMU AS build-base-common
 ARG MESON_VERSION
 ENV TARGET=/builddeps/target
 ENV CPATH="$TARGET/include"
@@ -29,12 +30,22 @@ RUN pip3 install meson==${MESON_VERSION} tomli
 RUN mkdir /build
 WORKDIR /build
 RUN mkdir -p $TARGET
+
+FROM build-base-common AS build-base-wasm32
+
+FROM build-base-common AS build-base-wasm64
+ENV CFLAGS="$CFLAGS -sMEMORY64=1"
+ENV CXXFLAGS="$CXXFLAGS -sMEMORY64=1"
+ENV LDFLAGS="$LDFLAGS -sMEMORY64=1"
+
+FROM build-base-${TARGET_CPU} AS build-base
+ARG TARGET_CPU
 RUN <<EOF
 cat <<EOT > /cross.meson
 [host_machine]
 system = 'emscripten'
-cpu_family = 'wasm32'
-cpu = 'wasm32'
+cpu_family = '${TARGET_CPU}'
+cpu = '${TARGET_CPU}'
 endian = 'little'
 
 [binaries]
@@ -56,13 +67,14 @@ RUN emconfigure ./configure --prefix=$TARGET --static
 RUN emmake make install -j$(nproc)
 
 FROM build-base AS libffi-dev
+ARG TARGET_CPU
 ARG FFI_VERSION
 RUN mkdir -p /libffi
 RUN git clone https://github.com/libffi/libffi /libffi
 WORKDIR /libffi
 RUN git checkout $FFI_VERSION
 RUN autoreconf -fiv
-RUN emconfigure ./configure --host=wasm32-unknown-linux \
+RUN emconfigure ./configure --host=${TARGET_CPU}-unknown-linux \
     --prefix=$TARGET --enable-static \
     --disable-shared --disable-dependency-tracking \
     --disable-builddir --disable-multi-os-directory \
@@ -140,6 +152,6 @@ RUN sed -i -E "/#define HAVE_POSIX_SPAWN 1/d" ./_build/config.h
 RUN sed -i -E "/#define HAVE_PTHREAD_GETNAME_NP 1/d" ./_build/config.h
 RUN meson install -C _build
 
-FROM build-base
+FROM build-base-common
 COPY --from=glib-dev /builddeps/ /builddeps/
 COPY --from=pixman-dev /builddeps/ /builddeps/
-- 
2.43.0


