Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D49FE68951
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 04:07:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6MR1-0003tp-13; Thu, 31 Oct 2024 00:05:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t6MQq-0003mk-Ue
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 00:05:13 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t6MQo-00054S-Rk
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 00:05:12 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2e2e2d09decso1245881a91.1
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 21:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730347509; x=1730952309; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GWEffwDMJmqQqCBLwXmQs/G5t8KhBeTNj8bmbTesV98=;
 b=MzooNerjm+E/rAukrg6fEbUq1DSZU+9dh/YsTMo2A22dnDCg/WtZ+mvAfoUB2m6v4k
 olz9MzGTlR6QxBGez5mMinalIjowCaWmj36INhSxBPS2VBuQPPAAsiB+0NE7rIo8JjCd
 h2ACLzzLW7EWRkbNhN0fF/D0Zox/tIOvAlwpXvW6O75Bip0KbmZMg5VMPhl2Vruhen3M
 ItrTdF+qDvfSkzWNbw+j31TMpfvtoJk7aiJIzEhlT1Vzdu+C9HGDDgzSWoD6dJaBoBed
 YBmI48nKnr7+KBkohRQVUpovWIcpkroVMNeeeEnVwc1NEhYj8xbM8hMkAmooMKRHQVNt
 DUgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730347509; x=1730952309;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GWEffwDMJmqQqCBLwXmQs/G5t8KhBeTNj8bmbTesV98=;
 b=gGfTKRSlxtBDNd/iUNuiM4fNS3T8AwdLfxBKmObce59UBPOmZxcForXRw6hpxXsfok
 4MGOyXFhpBvOm2/VdPLt26gA0hZy/CMLXh5ozNSgPy5dDPfPeOAVDOL728UNUmGdXM4/
 +SPKcVMkSfm/mU+31QYlnvy9XF6l5yzoVjrxeSncOvtYivPzeOSg9OgV5f6Ow7hS18OW
 rADB0IowN7QI6rTbf6Ud1+Lisdg+bZ0azAa3h4Ymyo4MWHqdFyjBmQPekLai6djbxSiH
 wiDxLlikGCgUzo/KBWx8ZLjy4xWTaW83y6khK4zfM838npsiS5QgTEx8LKG5EOX6HqOy
 KeSw==
X-Gm-Message-State: AOJu0YzVi9+PORBv8d+Dmn6wEN5g97SpR3A+M2oLkTUrhnWHZfSO4hjT
 ijLnfPXieW8p0FL3VWNfL2wMUVFWt5NB96Mt/rXIrqnyiGXihNZFZFgTEtc5RgdWzrZGokiXNwZ
 I9e0Wxg==
X-Google-Smtp-Source: AGHT+IHOoM3tEWzAnGhPN1UKbuZKTnRT34eQEk6fVTfJXxyEDAW6r8rADEtdNbbcSAHYBQSR/nCVhw==
X-Received: by 2002:a17:90b:510b:b0:2e2:bb32:73e7 with SMTP id
 98e67ed59e1d1-2e93e0df6d2mr1575949a91.15.1730347509245; 
 Wed, 30 Oct 2024 21:05:09 -0700 (PDT)
Received: from linaro.. (216-180-64-156.dyn.novuscom.net. [216.180.64.156])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e93db3a023sm428438a91.49.2024.10.30.21.05.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Oct 2024 21:05:08 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 12/12] docs: add information on how to setup build environments
Date: Wed, 30 Oct 2024 21:04:26 -0700
Message-Id: <20241031040426.772604-13-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241031040426.772604-1-pierrick.bouvier@linaro.org>
References: <20241031040426.772604-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102a.google.com
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

MacOS and Linux are straightforward, but Windows needs a bit more
details.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 docs/about/build-platforms.rst |   4 +-
 docs/devel/build-system.rst    | 100 +++++++++++++++++++++++++++++++++
 2 files changed, 103 insertions(+), 1 deletion(-)

diff --git a/docs/about/build-platforms.rst b/docs/about/build-platforms.rst
index 8fd7da140a3..fd1a8cabe36 100644
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
 
@@ -118,7 +121,6 @@ Optional build dependencies
   cross compilation using ``docker`` or ``podman``, or to use pre-built
   binaries distributed with QEMU.
 
-
 Windows
 -------
 
diff --git a/docs/devel/build-system.rst b/docs/devel/build-system.rst
index d42045a2325..fa5601fed82 100644
--- a/docs/devel/build-system.rst
+++ b/docs/devel/build-system.rst
@@ -595,3 +595,103 @@ Built by Makefile:
   meson.build.  The rules are produced from Meson's JSON description of
   tests (obtained with "meson introspect --tests") through the script
   scripts/mtest2make.py.
+
+.. _setup-build-env:
+
+Setup build environment
+=======================
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
+We recommend to use UCRT64 for windows-x86_64 and CLANGARM64 for windows-aarch64
+(only available on windows-aarch64 hosts).
+
+Then, you can open a windows shell, and enter msys2 env using:
+
+::
+
+    c:/msys64/msys2_shell.cmd -defterm -here -no-start -ucrt64
+    # Replace -ucrt64 by -clangarm64 or -mingw64 for other environments.
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
-- 
2.39.5


