Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43616D4A5EE
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 03:36:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgaan-00056h-KJ; Thu, 15 Jan 2026 22:33:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vgaal-00056D-AK
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 22:33:43 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vgaaj-0005IE-GW
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 22:33:43 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-81dbc0a99d2so814344b3a.1
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 19:33:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768534420; x=1769139220; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N59fScNT/GU69c4/pB+lZMvNhLijF5cb/1PlNGXkv0Y=;
 b=riSHIojxF1ErDeDe+8Jh+2N05Q7YymEEFYkVKmdeCdjrnve0qPFbs5fR/Svebh7CLL
 TEwTbFjqOAvfp/fYpcEhVnlWCF44UNCFAGVDM4aPB6nyZJl8PzTE77Sypd/jFtOCc6im
 ZM9bzBkLJsoyJOkhh+iH1i2JyQAPhKL9o9bGzo/PzTflVvRKZbWydPacQQQW7dQ4XeX6
 JIskJnI4vdOHwnPBqmhdqZTJcQjZ8zxb5cIFiyu5RRvaq4KWlltdbTFWRLnBTzDoGth5
 1HzSst00hIKL0owZmwPNWYictTrqHQMX3//kb+Y2P4yPs6GRwkAwjq97uo9sd7FWm5hm
 uoiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768534420; x=1769139220;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=N59fScNT/GU69c4/pB+lZMvNhLijF5cb/1PlNGXkv0Y=;
 b=XAfW5xnB5dmY3x6yOpu/qZFVioHehpQAdnlLr3OzH8PoJwbapViloUDaq0bjoCjEnL
 U/iMcleT1xGrA9EamwJkMfwvoRHWBYUtBKWZ3qy3d4JxWSWcmlW83+sOb1aH6+K88n0/
 JmE6n6ullrMdQNHHeU24UhWe8/YDFLNDkgzj2P0JfZBBa1F7tjytOY6jqxOMQkrRSWDs
 E5kUPagL96OOzFvO+zx8ysTH/qtEDOz8Sa9xPuSIQ/WhE5YCsrir0DfzZ7VYVYeRC/OF
 oV+cHrXavEOP1W0G4LLzXAl5HCXqBVsIhNiJhNxNLyTNvWiYEza2zwoiq2DZDVaRbGHF
 5qIA==
X-Gm-Message-State: AOJu0Yy9U/SvcqPiDQjcRBp38+or34+ysIdiX08ifIid3efT6QulXIvq
 Kg13YIj5olkAvEZYobzuX1hLYcixsAiTRiqPZI6AoBWGyYXUgmg+9XAevHrjx4B+JkTRv/lxJCV
 RXwWbuqdRAQ==
X-Gm-Gg: AY/fxX6nsOUTaJLBwULVX8oZaVsHJqsCOPae/U9GWaDxYwewbQuWhnjiVozV2erpGPr
 d4PqXf18ZKXrMc6eDqicZk3L3r461VY02AIfssvNpLNqze+5ZTRVP0THmZJ+9CUON905t5RgUdM
 x4mcT7KBGhvPLalH7zllMH/0hlzGssmiUtCVufGIP+X11ZLpwiinXfzSPt6J1s1KWeH5ZmAcPmN
 EnXras66mZmalma1q9jooaGlqt8jEg/lC496Pg6MBDLDiSG/EUYmjp9FcjMX86lzCZgzliTDLbz
 xkhe5OOStERsrDr4HtfCzJQvuckmSSqXS2egY9BIBIpnKlb3FhwOmucthtnkVR7FwfPF3reXCcE
 z7QW3yYo5+T4fL+jQoWc55XKcdek6U/5lmpKg7xZP8IambVfZFqX+Ggm+Pb2Jdvsy13/SQmBcHN
 bKvh1dfEOzjSlIXrc4cg==
X-Received: by 2002:a05:6a00:1788:b0:81f:3d13:e07b with SMTP id
 d2e1a72fcca58-81fa035461emr1580849b3a.43.1768534420095; 
 Thu, 15 Jan 2026 19:33:40 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-81fa12b5c67sm683372b3a.69.2026.01.15.19.33.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 19:33:39 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: ktokunaga.mail@gmail.com, berrange@redhat.com, pierrick.bouvier@linaro.org,
 thuth@redhat.com, pbonzini@redhat.com, philmd@linaro.org
Subject: [PATCH v2 06/58] tests/docker/dockerfiles: Drop wasm32 from
 emsdk-wasm-cross.docker
Date: Fri, 16 Jan 2026 14:32:12 +1100
Message-ID: <20260116033305.51162-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260116033305.51162-1-richard.henderson@linaro.org>
References: <20260116033305.51162-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

We will no longer build wasm32, so drop the docker config.
Streamline the dockerfile to hardcode TARGET_CPU as wasm64.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 .gitlab-ci.d/container-cross.yml                 |  1 -
 tests/docker/dockerfiles/emsdk-wasm-cross.docker | 15 ++++-----------
 2 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/.gitlab-ci.d/container-cross.yml b/.gitlab-ci.d/container-cross.yml
index 6bdd482b80..b376c837dc 100644
--- a/.gitlab-ci.d/container-cross.yml
+++ b/.gitlab-ci.d/container-cross.yml
@@ -90,5 +90,4 @@ wasm64-emsdk-cross-container:
   extends: .container_job_template
   variables:
     NAME: emsdk-wasm64-cross
-    BUILD_ARGS: --build-arg TARGET_CPU=wasm64
     DOCKERFILE: emsdk-wasm-cross
diff --git a/tests/docker/dockerfiles/emsdk-wasm-cross.docker b/tests/docker/dockerfiles/emsdk-wasm-cross.docker
index ecd5a02903..8a924816f9 100644
--- a/tests/docker/dockerfiles/emsdk-wasm-cross.docker
+++ b/tests/docker/dockerfiles/emsdk-wasm-cross.docker
@@ -7,7 +7,6 @@ ARG GLIB_VERSION=${GLIB_MINOR_VERSION}.0
 ARG PIXMAN_VERSION=0.44.2
 ARG FFI_VERSION=v3.5.2
 ARG MESON_VERSION=1.5.0
-ARG TARGET_CPU=wasm32
 
 FROM docker.io/emscripten/emsdk:$EMSDK_VERSION_QEMU AS build-base-common
 ARG MESON_VERSION
@@ -31,21 +30,16 @@ RUN mkdir /build
 WORKDIR /build
 RUN mkdir -p $TARGET
 
-FROM build-base-common AS build-base-wasm32
-
-FROM build-base-common AS build-base-wasm64
+FROM build-base-common AS build-base
 ENV CFLAGS="$CFLAGS -sMEMORY64=1"
 ENV CXXFLAGS="$CXXFLAGS -sMEMORY64=1"
 ENV LDFLAGS="$LDFLAGS -sMEMORY64=1"
-
-FROM build-base-${TARGET_CPU} AS build-base
-ARG TARGET_CPU
 RUN <<EOF
 cat <<EOT > /cross.meson
 [host_machine]
 system = 'emscripten'
-cpu_family = '${TARGET_CPU}'
-cpu = '${TARGET_CPU}'
+cpu_family = 'wasm64'
+cpu = 'wasm64'
 endian = 'little'
 
 [binaries]
@@ -67,14 +61,13 @@ RUN emconfigure ./configure --prefix=$TARGET --static
 RUN emmake make install -j$(nproc)
 
 FROM build-base AS libffi-dev
-ARG TARGET_CPU
 ARG FFI_VERSION
 RUN mkdir -p /libffi
 RUN git clone https://github.com/libffi/libffi /libffi
 WORKDIR /libffi
 RUN git checkout $FFI_VERSION
 RUN autoreconf -fiv
-RUN emconfigure ./configure --host=${TARGET_CPU}-unknown-linux \
+RUN emconfigure ./configure --host=wasm64-unknown-linux \
     --prefix=$TARGET --enable-static \
     --disable-shared --disable-dependency-tracking \
     --disable-builddir --disable-multi-os-directory \
-- 
2.43.0


