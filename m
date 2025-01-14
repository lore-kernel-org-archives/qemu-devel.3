Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C92CE77188
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 11:41:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXfFs-0005Bz-RT; Tue, 14 Jan 2025 06:38:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tXfFm-000587-BX
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 06:38:39 -0500
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tXfFj-0005Ri-T4
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 06:38:38 -0500
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-aaf57c2e0beso1100757266b.3
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 03:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736854714; x=1737459514; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+v1cfKfMBYv6DUpTxzbC+rrsyIR6JwY8WQ4dxVeT55E=;
 b=e4xNvvd6HHVl/A+QyPhQgtpOMf4+LPG7T5G0/DufTHnG3SxzGAi7QNXPpq4FVMMWH1
 ZyVHRBNc+w+tp6E8y4IMkPL+Kcafh80WI+dFCp0af4DnLOg1npuc1Qa+Zmw4Alg5vFpa
 5ikOg8XsCkmBjWzOHkmyPiZ7fHMC+RwABorWii+d692DJhdmGXogMF7qW7R94hBYPpQm
 A9VfkVGjRMDSmEYoS+Uqu5bSmX0m20BYaDRBI5BUPydWk8VjGQKmZjoU0gIN5Oq8TEjC
 VRHRsQW9Dk+gfyjuP6HyykxhM5FlMGxQrq+b8C0N+GLKJBkFnemmmQx8O+53wg36MYXg
 1oSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736854714; x=1737459514;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+v1cfKfMBYv6DUpTxzbC+rrsyIR6JwY8WQ4dxVeT55E=;
 b=tPx1EnsaKrIFr6fPoelAGVLrZOxHMSFYs0a8eV3Ne15Hfg52TRrV9ntFqGWmEN/1z2
 FP7jfbnjYfL4p2M5F9rvw7gZr3ED4EZG7h4IuwiWHqHNXuKGy0vYb9edQGwnWuQWdLgQ
 7SGFLg2RzjDNTB3UbmuUrX69ACyw+tZ/Ndv9pPSMjg6TC24srzDOieY7Blq0fu1IeAX3
 uPBqnIhBhVQRLEhItBFSaSG2OLUlNgiqFjSC0SpywB4EjhWSFgBHYmAuAKYX8kzrSdEU
 HWm4vWnjy0BOwTsXkIus42x/Cvq98NE/tPdmZlclpfb4gx6ahUYedv3A60ki9pFWrPY9
 qADw==
X-Gm-Message-State: AOJu0YwhOWAgKnlk+8SzEO1X1QpCsPc+3OZLuL3uBDrUVUfizeDjcCfC
 9GpCSArRq3NfFWjpHkPOfa4EKTsgqa9MpfjFXYwW4EHVRXuWecZSC/Uv7ET9cB4=
X-Gm-Gg: ASbGnctGgKi0thudB10df5Vbp3igZOPuOmlw7B+zF7aU85upydSqESyve3W/rBXDHPb
 UE4QjMexQzB/OTcHOMPMmL4sDf6rp93rqwcSC5tpdNvN39dRGvI2cF4F1dOfsCGN8UtJh8Z7wPc
 lEv73hF8VlxyOPdmVl08l3vGSHgtGDowhE0rvd4nSFrns6LJfcm2pG8Ye/IZib53qVjHOb0qWdD
 BipEbJUaGMftqa4P5XEJFbeYLW7eivdl+0m7qqquAE4B7TfTs+dlKM=
X-Google-Smtp-Source: AGHT+IFhyu5aC/CBWM4VQnIFvHJjTVE3RyDOGdlZ/ddzvT4hfmh9AfxUAC7CvIaHkfu8MNsIno4Hgg==
X-Received: by 2002:a17:907:7ea1:b0:ab2:e76a:a51a with SMTP id
 a640c23a62f3a-ab2e76aaedbmr1593940766b.31.1736854714219; 
 Tue, 14 Jan 2025 03:38:34 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c9564848sm612649366b.125.2025.01.14.03.38.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 03:38:33 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 07A855FCB9;
 Tue, 14 Jan 2025 11:38:25 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Weil <sw@weilnetz.de>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v2 34/37] docs/devel: add information on how to setup build
 environments
Date: Tue, 14 Jan 2025 11:38:18 +0000
Message-Id: <20250114113821.768750-35-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250114113821.768750-1-alex.bennee@linaro.org>
References: <20250114113821.768750-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_SBL_A=0.1 autolearn=ham autolearn_force=no
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

MacOS and Linux are straightforward, but Windows needs a bit more
details.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20241209183104.365796-5-pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 docs/about/build-platforms.rst   |   4 +-
 docs/devel/build-environment.rst | 118 +++++++++++++++++++++++++++++++
 docs/devel/index-build.rst       |   1 +
 3 files changed, 122 insertions(+), 1 deletion(-)
 create mode 100644 docs/devel/build-environment.rst

diff --git a/docs/about/build-platforms.rst b/docs/about/build-platforms.rst
index d8b0445157..482b09819c 100644
--- a/docs/about/build-platforms.rst
+++ b/docs/about/build-platforms.rst
@@ -29,6 +29,9 @@ The `Repology`_ site is a useful resource to identify
 currently shipped versions of software in various operating systems,
 though it does not cover all distros listed below.
 
+You can find how to install build dependencies for different systems on the
+:ref:`setup-build-env` page.
+
 Supported host architectures
 ----------------------------
 
@@ -130,7 +133,6 @@ Optional build dependencies
   cross compilation using ``docker`` or ``podman``, or to use pre-built
   binaries distributed with QEMU.
 
-
 Windows
 -------
 
diff --git a/docs/devel/build-environment.rst b/docs/devel/build-environment.rst
new file mode 100644
index 0000000000..f133ef2e01
--- /dev/null
+++ b/docs/devel/build-environment.rst
@@ -0,0 +1,118 @@
+
+.. _setup-build-env:
+
+Setup build environment
+=======================
+
+QEMU uses a lot of dependencies on the host system. glib2 is used everywhere in
+the code base, and most of the other dependencies are optional.
+
+We present here simple instructions to enable native builds on most popular
+systems.
+
+You can find additional instructions on `QEMU wiki <https://wiki.qemu.org/>`_:
+
+- `Linux <https://wiki.qemu.org/Hosts/Linux>`_
+- `MacOS <https://wiki.qemu.org/Hosts/Mac>`_
+- `Windows <https://wiki.qemu.org/Hosts/W32>`_
+- `BSD <https://wiki.qemu.org/Hosts/BSD>`_
+
+Note: Installing dependencies using your package manager build dependencies may
+miss out on deps that have been newly introduced in qemu.git. In more, it misses
+deps the distribution has decided to exclude.
+
+Linux
+-----
+
+Fedora
+++++++
+
+::
+
+    sudo dnf update && sudo dnf builddep qemu
+
+Debian/Ubuntu
++++++++++++++
+
+You first need to enable `Sources List <https://wiki.debian.org/SourcesList>`_.
+Then, use apt to install dependencies:
+
+::
+
+    sudo apt update && sudo apt build-dep qemu
+
+MacOS
+-----
+
+You first need to install `Homebrew <https://brew.sh/>`_. Then, use it to
+install dependencies:
+
+::
+
+    brew update && brew install $(brew deps --include-build qemu)
+
+Windows
+-------
+
+You first need to install `MSYS2 <https://www.msys2.org/>`_.
+MSYS2 offers `different environments <https://www.msys2.org/docs/environments/>`_.
+x86_64 environments are based on GCC, while aarch64 is based on Clang.
+
+We recommend to use MINGW64 for windows-x86_64 and CLANGARM64 for windows-aarch64
+(only available on windows-aarch64 hosts).
+
+Then, you can open a windows shell, and enter msys2 env using:
+
+::
+
+    c:/msys64/msys2_shell.cmd -defterm -here -no-start -mingw64
+    # Replace -ucrt64 by -clangarm64 or -ucrt64 for other environments.
+
+MSYS2 package manager does not offer a built-in way to install build
+dependencies. You can start with this list of packages using pacman:
+
+Note: Dependencies need to be installed again if you use a different MSYS2
+environment.
+
+::
+
+    # update MSYS2 itself, you need to reopen your shell at the end.
+    pacman -Syu
+    pacman -S \
+        base-devel binutils bison diffutils flex git grep make sed \
+        ${MINGW_PACKAGE_PREFIX}-toolchain \
+        ${MINGW_PACKAGE_PREFIX}-glib2 \
+        ${MINGW_PACKAGE_PREFIX}-gtk3 \
+        ${MINGW_PACKAGE_PREFIX}-libnfs \
+        ${MINGW_PACKAGE_PREFIX}-libssh \
+        ${MINGW_PACKAGE_PREFIX}-ninja \
+        ${MINGW_PACKAGE_PREFIX}-pixman \
+        ${MINGW_PACKAGE_PREFIX}-pkgconf \
+        ${MINGW_PACKAGE_PREFIX}-python \
+        ${MINGW_PACKAGE_PREFIX}-SDL2 \
+        ${MINGW_PACKAGE_PREFIX}-zstd
+
+If you want to install all dependencies, it's possible to use recipe used to
+build QEMU in MSYS2 itself.
+
+::
+
+    pacman -S wget
+    wget https://raw.githubusercontent.com/msys2/MINGW-packages/refs/heads/master/mingw-w64-qemu/PKGBUILD
+    # Some packages may be missing for your environment, installation will still
+    # be done though.
+    makepkg -s PKGBUILD || true
+
+Build on windows-aarch64
+++++++++++++++++++++++++
+
+When trying to cross compile meson for x86_64 using UCRT64 or MINGW64 env,
+configure will run into an error because the cpu detected is not correct.
+
+Meson detects x86_64 processes emulated, so you need to manually set the cpu,
+and force a cross compilation (with empty prefix).
+
+::
+
+    ./configure --cpu=x86_64 --cross-prefix=
+
diff --git a/docs/devel/index-build.rst b/docs/devel/index-build.rst
index 0023953be3..0745c81a26 100644
--- a/docs/devel/index-build.rst
+++ b/docs/devel/index-build.rst
@@ -8,6 +8,7 @@ some of the basics if you are adding new files and targets to the build.
    :maxdepth: 3
 
    build-system
+   build-environment
    kconfig
    docs
    qapi-code-gen
-- 
2.39.5


