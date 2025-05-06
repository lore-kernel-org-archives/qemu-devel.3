Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C623C3ABBE
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 15:32:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCKGT-0006n7-VF; Tue, 06 May 2025 11:31:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uCKFk-0004jy-DD
 for qemu-devel@nongnu.org; Tue, 06 May 2025 11:30:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uCKFh-0002GE-OF
 for qemu-devel@nongnu.org; Tue, 06 May 2025 11:30:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746545436;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7fQ6WeYluQkJ2nf4iCyAUJ/ZOfYu5sbnVWHBl06N+o8=;
 b=G3HwKa3RsTSsrrdZp6Mboxf1hYAWcf9Rgmx+sMZ7wCmxl/JFj+V2FewIG8exPw58W3XuSa
 6xMqX+/i0c2FfHBpDgMKzpNC0no/FQxg8eLTRs3NSfmtS6zrwNa+rSP7IVF/5R1gL6ql85
 5OxDZd5t2HfmaFpsMTlLlUq/DrknEgU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-170-r9skhd0oMSKGekg5bhQ__A-1; Tue, 06 May 2025 11:30:34 -0400
X-MC-Unique: r9skhd0oMSKGekg5bhQ__A-1
X-Mimecast-MFC-AGG-ID: r9skhd0oMSKGekg5bhQ__A_1746545432
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43d4d15058dso40987025e9.0
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 08:30:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746545431; x=1747150231;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7fQ6WeYluQkJ2nf4iCyAUJ/ZOfYu5sbnVWHBl06N+o8=;
 b=vcbYFLC67wV6kdqCeiNgFRDWvAE2LXzBA+RAMAqZXkF7HeL7VumzMTsklbI2wVvIel
 F07zPI0xtVIJp/9EiZHYPA0E/9Ag3fDBq7Xyzai+NKeY2DPQe85F6h9qSCEmcAqiUnWI
 mZp0io7+mSFFfh1ogcAFjSP8Xvy1AZUCjDVOCZvNrzvfaMj+pw4zCI5CJVbtC78+IEOz
 PJRipq5d0agB5z6Hz7w3ukuOMbE33HV7YOlXi+6DPyoR6Qi5E/aElZKurkkaSrx9iHI4
 sJgjX9m62lsrdku9GZvyKrjp6so2AViwFrQYohLxgRswj91rv7JTAsLTGlb+4gXXbO6V
 Vp0w==
X-Gm-Message-State: AOJu0YyKgCRQ8sCOoZKyChd7lo/u4+AmSIYX3PFBQDguULU0oJwDipyY
 sy/fc9ifWS4bas+dl3Pa3xFzHn5ikaNPeaxr4R0Q7fXZaVvQN7SbiSIc9pHlSyoNc8LLj28N2xM
 3f81Nm4Mud0NyN8CDpMqsAgvJ3GwmuWZDON845QfKxN6LccEWMkNVk2pLEjpFyaf2IXQsl/FMgG
 Y4O6Vi/aovfZYmN5yoW8a5prY/QeFtjKbvCs0i
X-Gm-Gg: ASbGncuDV+/rpwi2ZZJVNmfkVk+G/KyOloQqRlX5ISOmrnm6UworTSZw8Kvo/nNu/p8
 VjGFtWvYoUfPmCke6DU0Hki6r0CHwp8YBeXWvoJtWVqdQeB3t4XF4ndscwIhVMYYQcYtpIHpQyz
 j1JHZkLxHb9lfBYsyzIitr7pAc87s8rhDh3DY8djKosZ2OsymyxrvGTfAnOjQTY71QXXvMmWvbJ
 sT5PpNUaIFVK/bLnFrN+Wp4JoxDPLS0qLXBFkWRuyns2pW6fzDuNbAEBIkG1992+K1i/naIlCGz
 9SvnJc8lIT/dF00=
X-Received: by 2002:a05:600c:1c84:b0:43c:eeee:b713 with SMTP id
 5b1f17b1804b1-441c4919f07mr82985165e9.20.1746545430642; 
 Tue, 06 May 2025 08:30:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEeulObGKUU5Cbvrjza5OI85oksU94sX+g+8DiEYj4EJ2hgEV/AaIuJ82HaJskxaOI8/inWXw==
X-Received: by 2002:a05:600c:1c84:b0:43c:eeee:b713 with SMTP id
 5b1f17b1804b1-441c4919f07mr82984935e9.20.1746545430220; 
 Tue, 06 May 2025 08:30:30 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.54.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a099ae7b45sm13808612f8f.46.2025.05.06.08.30.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 May 2025 08:30:29 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Subject: [PULL 29/30] tests: Add Dockerfile containing dependencies for
 Emscripten build
Date: Tue,  6 May 2025 17:29:24 +0200
Message-ID: <20250506152927.222671-30-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250506152927.222671-1-pbonzini@redhat.com>
References: <20250506152927.222671-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Kohei Tokunaga <ktokunaga.mail@gmail.com>

The added Dockerfile is based on the emsdk image, which includes the
Emscripten toolchain. It also cross-compiles the necessary dependencies
(glib, libffi, pixman, and zlib) for the Emscripten target environment.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Link: https://lore.kernel.org/r/8bed6e9d46ef09328a87320928b5dec575d1e435.1745820062.git.ktokunaga.mail@gmail.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 MAINTAINERS                                   |   1 +
 .../dockerfiles/emsdk-wasm32-cross.docker     | 145 ++++++++++++++++++
 2 files changed, 146 insertions(+)
 create mode 100644 tests/docker/dockerfiles/emsdk-wasm32-cross.docker

diff --git a/MAINTAINERS b/MAINTAINERS
index 02b75ea9e10..9b5e41f616c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -635,6 +635,7 @@ F: include/system/os-wasm.h
 F: os-wasm.c
 F: util/coroutine-wasm.c
 F: configs/meson/emscripten.txt
+F: tests/docker/dockerfiles/emsdk-wasm32-cross.docker
 
 Alpha Machines
 --------------
diff --git a/tests/docker/dockerfiles/emsdk-wasm32-cross.docker b/tests/docker/dockerfiles/emsdk-wasm32-cross.docker
new file mode 100644
index 00000000000..60a7d02f561
--- /dev/null
+++ b/tests/docker/dockerfiles/emsdk-wasm32-cross.docker
@@ -0,0 +1,145 @@
+# syntax = docker/dockerfile:1.5
+
+ARG EMSDK_VERSION_QEMU=3.1.50
+ARG ZLIB_VERSION=1.3.1
+ARG GLIB_MINOR_VERSION=2.84
+ARG GLIB_VERSION=${GLIB_MINOR_VERSION}.0
+ARG PIXMAN_VERSION=0.44.2
+ARG FFI_VERSION=v3.4.7
+ARG MESON_VERSION=1.5.0
+
+FROM emscripten/emsdk:$EMSDK_VERSION_QEMU AS build-base
+ARG MESON_VERSION
+ENV TARGET=/builddeps/target
+ENV CPATH="$TARGET/include"
+ENV PKG_CONFIG_PATH="$TARGET/lib/pkgconfig"
+ENV EM_PKG_CONFIG_PATH="$PKG_CONFIG_PATH"
+ENV CFLAGS="-O3 -pthread -DWASM_BIGINT"
+ENV CXXFLAGS="$CFLAGS"
+ENV LDFLAGS="-sWASM_BIGINT -sASYNCIFY=1 -L$TARGET/lib"
+RUN apt-get update && apt-get install -y \
+    autoconf \
+    build-essential \
+    libglib2.0-dev \
+    libtool \
+    pkgconf \
+    ninja-build \
+    python3-pip
+RUN pip3 install meson==${MESON_VERSION} tomli
+RUN mkdir /build
+WORKDIR /build
+RUN mkdir -p $TARGET
+RUN <<EOF
+cat <<EOT > /cross.meson
+[host_machine]
+system = 'emscripten'
+cpu_family = 'wasm32'
+cpu = 'wasm32'
+endian = 'little'
+
+[binaries]
+c = 'emcc'
+cpp = 'em++'
+ar = 'emar'
+ranlib = 'emranlib'
+pkgconfig = ['pkg-config', '--static']
+EOT
+EOF
+
+FROM build-base AS zlib-dev
+ARG ZLIB_VERSION
+RUN mkdir -p /zlib
+RUN curl -Ls https://zlib.net/zlib-$ZLIB_VERSION.tar.xz | \
+    tar xJC /zlib --strip-components=1
+WORKDIR /zlib
+RUN emconfigure ./configure --prefix=$TARGET --static
+RUN emmake make install -j$(nproc)
+
+FROM build-base AS libffi-dev
+ARG FFI_VERSION
+RUN mkdir -p /libffi
+RUN git clone https://github.com/libffi/libffi /libffi
+WORKDIR /libffi
+RUN git checkout $FFI_VERSION
+RUN autoreconf -fiv
+RUN emconfigure ./configure --host=wasm32-unknown-linux \
+    --prefix=$TARGET --enable-static \
+    --disable-shared --disable-dependency-tracking \
+    --disable-builddir --disable-multi-os-directory \
+    --disable-raw-api --disable-docs
+RUN emmake make install SUBDIRS='include' -j$(nproc)
+
+FROM build-base AS pixman-dev
+ARG PIXMAN_VERSION
+RUN mkdir /pixman/
+RUN git clone  https://gitlab.freedesktop.org/pixman/pixman /pixman/
+WORKDIR /pixman
+RUN git checkout pixman-$PIXMAN_VERSION
+RUN <<EOF
+cat <<EOT >> /cross.meson
+[built-in options]
+c_args = [$(printf "'%s', " $CFLAGS | sed 's/, $//')]
+cpp_args = [$(printf "'%s', " $CFLAGS | sed 's/, $//')]
+objc_args = [$(printf "'%s', " $CFLAGS | sed 's/, $//')]
+c_link_args = [$(printf "'%s', " $LDFLAGS | sed 's/, $//')]
+cpp_link_args = [$(printf "'%s', " $LDFLAGS | sed 's/, $//')]
+EOT
+EOF
+RUN meson setup _build --prefix=$TARGET --cross-file=/cross.meson \
+    --default-library=static \
+    --buildtype=release -Dtests=disabled -Ddemos=disabled
+RUN meson install -C _build
+
+FROM build-base AS glib-dev
+ARG GLIB_VERSION
+ARG GLIB_MINOR_VERSION
+RUN mkdir -p /stub
+WORKDIR /stub
+RUN <<EOF
+cat <<'EOT' > res_query.c
+#include <netdb.h>
+int res_query(const char *name, int class,
+              int type, unsigned char *dest, int len)
+{
+    h_errno = HOST_NOT_FOUND;
+    return -1;
+}
+EOT
+EOF
+RUN emcc ${CFLAGS} -c res_query.c -fPIC -o libresolv.o
+RUN ar rcs libresolv.a libresolv.o
+RUN mkdir -p $TARGET/lib/
+RUN cp libresolv.a $TARGET/lib/
+
+RUN mkdir -p /glib
+RUN curl -Lks https://download.gnome.org/sources/glib/${GLIB_MINOR_VERSION}/glib-$GLIB_VERSION.tar.xz | \
+    tar xJC /glib --strip-components=1
+
+COPY --link --from=zlib-dev /builddeps/ /builddeps/
+COPY --link --from=libffi-dev /builddeps/ /builddeps/
+
+WORKDIR /glib
+RUN <<EOF
+CFLAGS="$CFLAGS -Wno-incompatible-function-pointer-types" ;
+cat <<EOT >> /cross.meson
+[built-in options]
+c_args = [$(printf "'%s', " $CFLAGS | sed 's/, $//')]
+cpp_args = [$(printf "'%s', " $CFLAGS | sed 's/, $//')]
+objc_args = [$(printf "'%s', " $CFLAGS | sed 's/, $//')]
+c_link_args = [$(printf "'%s', " $LDFLAGS | sed 's/, $//')]
+cpp_link_args = [$(printf "'%s', " $LDFLAGS | sed 's/, $//')]
+EOT
+EOF
+RUN meson setup _build --prefix=$TARGET --cross-file=/cross.meson \
+    --default-library=static --buildtype=release --force-fallback-for=pcre2 \
+    -Dselinux=disabled -Dxattr=false -Dlibmount=disabled -Dnls=disabled \
+    -Dtests=false -Dglib_debug=disabled -Dglib_assert=false -Dglib_checks=false
+# FIXME: emscripten doesn't provide some pthread functions in the final link,
+#        which isn't detected during meson setup.
+RUN sed -i -E "/#define HAVE_POSIX_SPAWN 1/d" ./_build/config.h
+RUN sed -i -E "/#define HAVE_PTHREAD_GETNAME_NP 1/d" ./_build/config.h
+RUN meson install -C _build
+
+FROM build-base
+COPY --link --from=glib-dev /builddeps/ /builddeps/
+COPY --link --from=pixman-dev /builddeps/ /builddeps/
-- 
2.49.0


