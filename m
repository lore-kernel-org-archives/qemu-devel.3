Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39971CA0EEB
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 18:26:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoQz3-0004uH-F3; Tue, 19 Aug 2025 14:22:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uoQz2-0004tl-0p; Tue, 19 Aug 2025 14:22:56 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uoQz0-0003lz-4B; Tue, 19 Aug 2025 14:22:55 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2445805aa2eso46766095ad.1; 
 Tue, 19 Aug 2025 11:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755627772; x=1756232572; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m3ANe70t7odIvNSjekeC3CnCW0I6T4H5dpW4Ym224S4=;
 b=dH/mLsmuoDVkHFQf5Le+tEAyL+mbFrvXbwXTt8Mf/H8jI1Oe+j+xX40iI5Ef/0/cNk
 GKLaYXHi7WC14MQFmRxZl9ybt6O40VIvzYwCsITICVQVchPPFAwcKEsWshu75XOVIoOS
 BfOVPJE4JuBK9kSxk4gkAvZGv66DkUdJ1tmHPAvIm5XRCRNUNDOPhsQO2mRYlGWuO+3O
 bDjGjpyRqV+W60Rzap7tUPWL+IPak/B4F3X6UdBtne71jugtJo+a8mhefk9PZIWhLUad
 2bEf0KN3nC3CXGzwHEqo4J2O9ytCOJorJQgVRvLYdgV2yghOo3UHrsADDDOatqyJkKRQ
 Uwbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755627772; x=1756232572;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m3ANe70t7odIvNSjekeC3CnCW0I6T4H5dpW4Ym224S4=;
 b=OB3rVW/r9oWkc9PcxvhR5UvYhD6ZRBiolMxIYbIxO0FSQBiIQi2TfpnJQw9XYxEvV6
 sJAGx41tad2uXg3eeF04rf3Cg6ByQUOtepNnc8dISOeVldSHuL1CtUNF4RE92WdjQZJQ
 s7WocjFPha9WdNHAmaBYgNEDfZ7IwYM9Y5uEEQ/css1p7Mg6/Xk3YTiLzt3F1VQ2kpe/
 4T79wdkwoP4VqzDCI60rMN4vV/KjxQ4hE2lb2cnjxnvPcJRuMek4h36hIm/ObQOKrq4/
 FQSnMy27VhHNnK12WIfCnr84VGW0PapRT6dOx18rSdjUTIUkz6Jr4yIxLeNoD+OP5+Js
 VQIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIBRiD0nRRKGpySP3TYk8/JVRMIVrhUGhl3OukQbQVsajs+Hkz5f+Z8xDv81E8/Tq9Xtezu4TuMxz10g==@nongnu.org,
 AJvYcCVoAjy5GdKg2l/E/IbvehYhPAjDn4fAbzFlCJdSsMaOzyZIs7z1YYCJ5uinYHpCccHIjjyU/YxxYQ==@nongnu.org
X-Gm-Message-State: AOJu0Yz1g26ZsDVrpt0vaos/XAnIBfHqLjbLSHBp/d2W1OuahLM4uwvG
 3KCVT9eDs/qdEPsEKCz7biwgAbLY2O8vVlg1tFqzM7FD9k3qYvJT1pYvrf8o5ZFs
X-Gm-Gg: ASbGncucTCqnYU1OpEwWoUgtlZtrBZZcLDG+ViOJ9j6uFtRQfCX+ul9Fjmc5LOntV97
 nMvaYU5sTkort48o4Vfxun2bYnK0Wia+d1Pberx+7lyPqEz6HpzbxOdoytBuRVyajyK5CSBn7dG
 TFMEGzCq8k8B7fKwGD4TM9fLlnuQIjh6oRiVN2iicUAhaxsPuBXGMQ3lysnNAgGulRSBDOI/97W
 RZE2C2imDAtdhiydSOJdhbiQ38CrBnGwv1fISXZlTYhhqwa+Hho6TB78WtaSB0ElRGwbGxS+KF2
 LZzRTkLsPDDcRpQ9p4kkOIxEazBvoJ4YC4TfsP8tkHq5v5SPUzuA7u2Hn+CB0LnzV/UO1qCYRNQ
 6yI5XLpSULjE6sl94Wu2C3g==
X-Google-Smtp-Source: AGHT+IFSOfmqmQwlY5FKYTKLcAxqFVoAIzlmCFXkkROj2pLEYm36aa1f5uLBEAVXs7zJRrt1Bdnxfg==
X-Received: by 2002:a17:903:3bcb:b0:23f:fa79:15d0 with SMTP id
 d9443c01a7336-245e04b8650mr52168525ad.46.1755627771666; 
 Tue, 19 Aug 2025 11:22:51 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:29ce:ef58:c2c9:e52f])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-245ed33b4c2sm3725125ad.25.2025.08.19.11.22.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Aug 2025 11:22:50 -0700 (PDT)
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 WANG Xuerui <git@xen0n.name>, Aurelien Jarno <aurelien@aurel32.net>,
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, Stefan Weil <sw@weilnetz.de>,
 qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, ktokunaga.mail@gmail.com
Subject: [PATCH 03/35] dockerfiles: Add support for wasm64 to the wasm
 Dockerfile
Date: Wed, 20 Aug 2025 03:21:32 +0900
Message-ID: <d995965f035f6a3ec57382497b204a425f7efaf2.1755623521.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1755623521.git.ktokunaga.mail@gmail.com>
References: <cover.1755623521.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pl1-x631.google.com
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

This commit fixes Dockerfile of the wasm build to support both of wasm32 and
wasm64 build. Dockerfile takes the following build arguments and use these
values for building dependencies.

- TARGET_CPU: target wasm arch (wasm32 or wasm64)
- WASM64_MEMORY64: target -sMEMORY64 mode (1 or 2)

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 MAINTAINERS                                   |  2 +-
 ...2-cross.docker => emsdk-wasm-cross.docker} | 29 ++++++++++++++-----
 2 files changed, 23 insertions(+), 8 deletions(-)
 rename tests/docker/dockerfiles/{emsdk-wasm32-cross.docker => emsdk-wasm-cross.docker} (85%)

V1:
- This commit is under review in another patch series so please ignore it
  here.

diff --git a/MAINTAINERS b/MAINTAINERS
index a07086ed76..433a44118d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -647,7 +647,7 @@ F: include/system/os-wasm.h
 F: os-wasm.c
 F: util/coroutine-wasm.c
 F: configs/meson/emscripten.txt
-F: tests/docker/dockerfiles/emsdk-wasm32-cross.docker
+F: tests/docker/dockerfiles/emsdk-wasm-cross.docker
 
 Alpha Machines
 --------------
diff --git a/tests/docker/dockerfiles/emsdk-wasm32-cross.docker b/tests/docker/dockerfiles/emsdk-wasm-cross.docker
similarity index 85%
rename from tests/docker/dockerfiles/emsdk-wasm32-cross.docker
rename to tests/docker/dockerfiles/emsdk-wasm-cross.docker
index 60a7d02f56..4b41be62ab 100644
--- a/tests/docker/dockerfiles/emsdk-wasm32-cross.docker
+++ b/tests/docker/dockerfiles/emsdk-wasm-cross.docker
@@ -1,14 +1,17 @@
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
+ARG WASM64_MEMORY64=0
 
-FROM emscripten/emsdk:$EMSDK_VERSION_QEMU AS build-base
+FROM emscripten/emsdk:$EMSDK_VERSION_QEMU AS build-base-common
+ARG TARGET_CPU
 ARG MESON_VERSION
 ENV TARGET=/builddeps/target
 ENV CPATH="$TARGET/include"
@@ -33,8 +36,8 @@ RUN <<EOF
 cat <<EOT > /cross.meson
 [host_machine]
 system = 'emscripten'
-cpu_family = 'wasm32'
-cpu = 'wasm32'
+cpu_family = '${TARGET_CPU}'
+cpu = '${TARGET_CPU}'
 endian = 'little'
 
 [binaries]
@@ -46,6 +49,16 @@ pkgconfig = ['pkg-config', '--static']
 EOT
 EOF
 
+FROM build-base-common AS build-base-wasm32
+
+FROM build-base-common AS build-base-wasm64
+ARG WASM64_MEMORY64
+ENV CFLAGS="$CFLAGS -sMEMORY64=${WASM64_MEMORY64}"
+ENV CXXFLAGS="$CXXFLAGS -sMEMORY64=${WASM64_MEMORY64}"
+ENV LDFLAGS="$LDFLAGS -sMEMORY64=${WASM64_MEMORY64}"
+
+FROM build-base-${TARGET_CPU} AS build-base
+
 FROM build-base AS zlib-dev
 ARG ZLIB_VERSION
 RUN mkdir -p /zlib
@@ -56,17 +69,19 @@ RUN emconfigure ./configure --prefix=$TARGET --static
 RUN emmake make install -j$(nproc)
 
 FROM build-base AS libffi-dev
+ARG TARGET_CPU
+ARG WASM64_MEMORY64
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
-    --disable-raw-api --disable-docs
+    --disable-raw-api --disable-docs WASM64_MEMORY64=${WASM64_MEMORY64}
 RUN emmake make install SUBDIRS='include' -j$(nproc)
 
 FROM build-base AS pixman-dev
-- 
2.43.0


