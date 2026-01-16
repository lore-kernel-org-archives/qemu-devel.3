Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21582D48986
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 11:19:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vghqw-0007Oa-G0; Fri, 16 Jan 2026 06:18:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vghqu-0007Ni-Sw
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 06:18:52 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vghqt-0005mh-7Z
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 06:18:52 -0500
Received: by mail-wm1-x341.google.com with SMTP id
 5b1f17b1804b1-47ee76e8656so22837575e9.0
 for <qemu-devel@nongnu.org>; Fri, 16 Jan 2026 03:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768562329; x=1769167129; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LWngYNpKVOutwMoJmRt3Ydc7XaZnIpLSQMBHhtCpGe8=;
 b=mQu5F+DRpWbDcC1NNgfdjICjUyVW+QCfaeaRG20p7FJvXsohZbrZxt7hyrMlOpCAn0
 co/UN3g8B9ICQG7Tn8KMIzaNCSUTEhsv/zag5E4YNy2UgqL9sj+y1kaR/qk5hKHdLO2O
 2yK43pqNh0ZYFivN3wGESuCiSTpSqi4FbGE36kl7c7S1HlzLwh6ZU2pQKUBr1NWzVufy
 8hXDOh70m4Mmlf9DxxAap+ZPyOinWq/Ej3eR7l7aUUna+L1IuaKmr3ZVVlgQ2ZkjhLDO
 LLRqBrPVA04Y/DT6u1pJoD39zceGCfqDb7/8GfTlX/aoSgpX2mYrGNNIIebqNbue0G0t
 Y8Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768562329; x=1769167129;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=LWngYNpKVOutwMoJmRt3Ydc7XaZnIpLSQMBHhtCpGe8=;
 b=CUf7d3R0fvmUS2ApwcORYYenEix9751i6uqlhKMPsoNN2R4YsTglnwEDAll/pPVs1i
 A0+nX+2XBW/Jj1qnBQlOM9hKzxuaauYLkCfZD1bst5qaV3dy9MMdFvRKDFTgDLOR6dqn
 zKrmloKqHm0cS0L1fLUjJfaTlB1QifIX3pSo0Va2uxd7CX6SbKaFqDRSOSlY8kHRdcM/
 Kq/OIOHg47VnCFjcDW5xYozpjS9yYQJSKVYhVDZ+dCHVAAhvymUdvtehf/HvPThnlwzK
 SIqspsEbJg7zaaEj2v21tP1fcb3vtKBCJ21e2AEG5v/Z2uMDaXXd5mA78GAPFppXZxFe
 M9kw==
X-Gm-Message-State: AOJu0YyOEaL44uPd8OHjTYyXUUHukbmtJmb6eeKnWpASZTXVPh6eFQ6q
 HA6mJwXimF46gW8pOtt21TAthTOZ2cNWmZmksEPmCKoe3OdPancoYr1o5R6vRwedDHEuNQzwkKl
 +xykjFsA=
X-Gm-Gg: AY/fxX5bFr0KuOBKxJob1CCO3esupvtNRx0x81DMLIDixSt28f6WEjEg8THqAF45iv/
 EqoPo8KyBGBDPMDwLQUffL0koDIxHNutM6RGhk5GAwPZnJ2IcFPizYoIsE38EyxPZhoyd8y2Jbv
 Jicsj47geKQ5c0BJtzvS6zQUQ0oaHIIZUMG/9ucihcG47ph08Q8z+PBhNnMW+wcLbRjw3ag2v9Q
 ODA0OVOX2TDNjdgF2QwctM4Qp4PbAJ4gGATwfVA89v5fDNluaVsYIew19bRGZb+8mAo2VOa2cya
 DqHwKeI4OmuSCBQ/1toIqOFpG1mrfv7280veRf5hBZ+Jbn2LvQX5D7os8rVBO7/fxnawdpowymW
 jyhKTJP7qT0IsZ9jWQdpcjUpWHqTsNe+hkHL9GcN9ov1cTXagmp94PyWy0o9ChrjrqOntSxUOiK
 xgOaQIiM0J1DpG0vxJMR+3Ud9MceWJ4yluFr8DKwQhZTB080XITqy9RgxRUwNlFmaa0nZyKnU=
X-Received: by 2002:a05:6000:2203:b0:431:92e:1d44 with SMTP id
 ffacd0b85a97d-43569980e80mr3082678f8f.20.1768562329377; 
 Fri, 16 Jan 2026 03:18:49 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356996cf58sm4614145f8f.22.2026.01.16.03.18.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 16 Jan 2026 03:18:48 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/30] dockerfiles: Add support for wasm64 to the wasm
 Dockerfile
Date: Fri, 16 Jan 2026 12:17:43 +0100
Message-ID: <20260116111807.36053-7-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260116111807.36053-1-philmd@linaro.org>
References: <20260116111807.36053-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x341.google.com
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

From: Kohei Tokunaga <ktokunaga.mail@gmail.com>

This commit fixes Dockerfile of the wasm build to support both of wasm32 and
wasm64 build. Dockerfile takes the following build argument and use it for
building dependencies.

- TARGET_CPU: target wasm arch (wasm32 or wasm64)

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3f21342f50e0412a32143fe21ecc0d8db95b3f37.1768308374.git.ktokunaga.mail@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS                                   |  2 +-
 ...2-cross.docker => emsdk-wasm-cross.docker} | 26 ++++++++++++++-----
 2 files changed, 20 insertions(+), 8 deletions(-)
 rename tests/docker/dockerfiles/{emsdk-wasm32-cross.docker => emsdk-wasm-cross.docker} (89%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4ddbfba9f01..de8246c3ffd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -683,7 +683,7 @@ F: include/system/os-wasm.h
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
index 1f08eb0b855..ecd5a029037 100644
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
2.52.0


