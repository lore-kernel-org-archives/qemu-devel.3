Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D4FCD116F1
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Nov 2025 18:22:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vP36u-00033B-3t; Fri, 28 Nov 2025 13:22:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vP36k-0002zW-P3
 for qemu-devel@nongnu.org; Fri, 28 Nov 2025 13:22:15 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vP36h-00039u-JV
 for qemu-devel@nongnu.org; Fri, 28 Nov 2025 13:22:14 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-42b39d51dcfso1410527f8f.2
 for <qemu-devel@nongnu.org>; Fri, 28 Nov 2025 10:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764354122; x=1764958922; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i4XS1mjCDo4NWoAdI8vYhiDsjbq4lRngZIqqDpS45Z8=;
 b=kC4JXPROr3OXj29p/1pdA5HPPjOa8qKLI4rVm3ueUXC+oZnLgDKtz3WXRan5Z3vM9/
 QWz4UmwbK5i3x/FnOC4TlLMFvweawIGaDYxpFzL4ak57MmD/lBUjMSZRySc56AJQyjBO
 /tgpxHjl59gc9XZzA4vAfLd2FzTW4x7fA+T/DU7PxCtRIQGRRW2k2DJQvWex65udjoZB
 YA5jamsm5rsVvGoYWbxIAK0+cfavtkxYEsjImbZon79gnno4AVfcJy6HV4tXfv0BuB+w
 lnpEZd1AuqpU579OlbNvtRNdqhFEc5ZUMNBamxhIV8Go+Rnavw6yhng9KW7blzE+YtGF
 SqZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764354122; x=1764958922;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=i4XS1mjCDo4NWoAdI8vYhiDsjbq4lRngZIqqDpS45Z8=;
 b=mb9uZSwtfqU4nh9FiM8Qk+76dMOlglGganzTA36XQfDkKHceN05ZnFCYIDo8OQsYH7
 72Qhaxj2rg/IWMU9u3Uxsr37xuBdDWvCLGx+7ZQWNm+Eyz8UYOfWd/2rSMdJi9U1qhkd
 hXciqq2co4WMkTiGggo8WgWYDXl2MDlwntiSHbIQQdeuiZXKBzx9aRop5cORvync58bo
 4HUO8AOPpJN8zn3iGQ8DPxpUtw6vds4+mHmU/mwqSoqTmrZ6NiOx/MRoGQmFqW73YR7f
 uPuj4bS7iLTOPvFs8W4aTfqxmEBzPcgNZ7TXXOmLM9qY8Jn+V+bi+8/0wxzAoGqzSEpP
 qnrg==
X-Gm-Message-State: AOJu0Yw0b7LSlclAouWnMsdbWcqF3MeXzNR7nRbk0Je41LnHTI0yTaO7
 oSeO99eTDnzM4JL0csQTFVUl2YsNprlGhRekdf3NuUt59iZE3mT5UZk6VIme4Bxd4yo=
X-Gm-Gg: ASbGncvXzZ1yo1Exj46Bdok7y3WlWYxIT98J2M2ihI/CZsCrqkI/YR936Ow2Y0du2Jy
 nTrhkLnpOJX3Qp0e5Adgp8oOe351mRNYEuJbwJrVPmQCG4CPzV/igWu9f4oEx3uuXp0/dgX+TaO
 fPOBuyAzF5aCwsUWvzzVvf+2qU8MsP3T8dIEI7Sw0IXBE/nge8wMaXCabN/FXzF53pw/BMS0qAx
 vzwZ9JfktLwjF1h187NcHAf0rH/6QLL7eWxPJUY3Arq2xE8rlGKm7NhJn0l8JSaHDAlgJH+uymf
 I9Y/1vnuApFCWQ05OmUiZtQPtpMWUPULl5uKanQs1SWLaYw5UGjlP7ajEuJseE8xy/sRjyKTAOe
 2N8okyfa1TlubOwkak4ZPljTiud+MrYUdUhyOkO1E+LsArOeeGe5nKtYrBObMtYohtc+zwxIZiW
 QEwRkqqLsWrws=
X-Google-Smtp-Source: AGHT+IHJhG0r9kSDwTx8qOBPvFfgInulipzZLNqECfzKPh0CG6a9OpYaQhwzRSKCJUEOOoP6xGlUsA==
X-Received: by 2002:a5d:588b:0:b0:42b:3806:2bb5 with SMTP id
 ffacd0b85a97d-42cc1abe1fbmr33396766f8f.12.1764354121562; 
 Fri, 28 Nov 2025 10:22:01 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42e1ca8e00fsm10997483f8f.34.2025.11.28.10.21.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Nov 2025 10:21:58 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2731A5F8FE;
 Fri, 28 Nov 2025 18:21:58 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 4/5] docs/devel: update build environment setup documentation
Date: Fri, 28 Nov 2025 18:21:56 +0000
Message-ID: <20251128182157.4125745-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251128182157.4125745-1-alex.bennee@linaro.org>
References: <20251128182157.4125745-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x436.google.com
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

Bring `libvirt-ci` front and centre when discussing dependencies for
QEMU. While we are at it:

  - drop links to additional instructions (libvirt is more upto date)
  - compress pkg installs into a table
  - call out distro/upstream dep difference in a proper note

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 docs/devel/build-environment.rst | 145 ++++++++++++++++++++-----------
 1 file changed, 96 insertions(+), 49 deletions(-)

diff --git a/docs/devel/build-environment.rst b/docs/devel/build-environment.rst
index 661f6ea8504..61b2dc0d1bc 100644
--- a/docs/devel/build-environment.rst
+++ b/docs/devel/build-environment.rst
@@ -4,55 +4,103 @@
 Setup build environment
 =======================
 
-QEMU uses a lot of dependencies on the host system. glib2 is used everywhere in
-the code base, and most of the other dependencies are optional.
-
-We present here simple instructions to enable native builds on most popular
-systems.
-
-You can find additional instructions on `QEMU wiki <https://wiki.qemu.org/>`_:
-
-- `Linux <https://wiki.qemu.org/Hosts/Linux>`_
-- `MacOS <https://wiki.qemu.org/Hosts/Mac>`_
-- `Windows <https://wiki.qemu.org/Hosts/W32>`_
-- `BSD <https://wiki.qemu.org/Hosts/BSD>`_
-
-Note: Installing dependencies using your package manager build dependencies may
-miss out on deps that have been newly introduced in qemu.git. In more, it misses
-deps the distribution has decided to exclude.
-
-Linux
------
-
-Fedora
-++++++
-
-::
-
-    sudo dnf update && sudo dnf builddep qemu
-
-Debian/Ubuntu
-+++++++++++++
-
-You first need to enable `Sources List <https://wiki.debian.org/SourcesList>`_.
-Then, use apt to install dependencies:
-
-::
-
-    sudo apt update && sudo apt build-dep qemu
-
-MacOS
------
-
-You first need to install `Homebrew <https://brew.sh/>`_. Then, use it to
-install dependencies:
-
-::
-
-    brew update && brew install $(brew deps --include-build qemu)
+QEMU uses a lot of dependencies on the host system a large number of
+which are optional. At a minimum we expect to have a system C library
+(usually glibc but others can work), the glib2 library (used heavily
+in the code base) and a few other core libraries for interfacing with
+code modules and system build descriptions.
+
+We use the ``libvirt-ci`` project to handle the mapping of
+dependencies to a wide variety output formats including system install
+scripts. For example:
+
+.. code-block:: bash
+
+  # THIS FILE WAS AUTO-GENERATED
+  #
+  #  $ lcitool buildenvscript debian-13 ./tests/lcitool/projects/qemu-minimal.yml
+  #
+  # https://gitlab.com/libvirt/libvirt-ci
+
+  function install_buildenv() {
+      export DEBIAN_FRONTEND=noninteractive
+      apt-get update
+      apt-get dist-upgrade -y
+      apt-get install --no-install-recommends -y \
+              bash \
+              bc \
+              bison \
+              bzip2 \
+              ca-certificates \
+              ccache \
+              findutils \
+              flex \
+              gcc \
+              git \
+              libc6-dev \
+              libfdt-dev \
+              libffi-dev \
+              libglib2.0-dev \
+              libpixman-1-dev \
+              locales \
+              make \
+              meson \
+              ninja-build \
+              pkgconf \
+              python3 \
+              python3-venv \
+              sed \
+              tar
+      sed -Ei 's,^# (en_US\.UTF-8 .*)$,\1,' /etc/locale.gen
+      dpkg-reconfigure locales
+      rm -f /usr/lib*/python3*/EXTERNALLY-MANAGED
+      dpkg-query --showformat '${Package}_${Version}_${Architecture}\n' --show > /packages.txt
+      mkdir -p /usr/libexec/ccache-wrappers
+      ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/cc
+      ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/gcc
+  }
+
+  export CCACHE_WRAPPERSDIR="/usr/libexec/ccache-wrappers"
+  export LANG="en_US.UTF-8"
+  export MAKE="/usr/bin/make"
+  export NINJA="/usr/bin/ninja"
+  export PYTHON="/usr/bin/python3"
+
+If you instead select the ``qemu.yml`` project file you will get all
+the dependencies that the project can use.
+
+Using you system package manager
+--------------------------------
+
+.. note::
+
+   Installing dependencies using your package manager build dependencies may
+   miss out on deps that have been newly introduced in qemu.git. It
+   also misses deps the distribution has decided to exclude.
+
+Systems with Package Managers
++++++++++++++++++++++++++++++
+
+.. list-table:: Package Manager Commands
+  :widths: 10 50 40
+  :header-rows: 1
+
+  * - System
+    - Command
+    - Notes
+  * - Fedora
+    - ``sudo dnf update && sudo dnf builddep qemu``
+    -
+  * - Debian/Ubuntu
+    - ``sudo apt update && sudo apt build-dep qemu``
+    - Must enable `Sources List
+      <https://wiki.debian.org/SourcesList>`_ first
+  * - MacOS
+    - ``brew update && brew install $(brew deps --include-build qemu)``
+    - Using `Homebrew <https://brew.sh/>`_.
 
 Windows
--------
++++++++
 
 You first need to install `MSYS2 <https://www.msys2.org/>`_.
 MSYS2 offers `different environments <https://www.msys2.org/docs/environments/>`_.
@@ -104,7 +152,7 @@ build QEMU in MSYS2 itself.
     makepkg --syncdeps --nobuild PKGBUILD || true
 
 Build on windows-aarch64
-++++++++++++++++++++++++
+~~~~~~~~~~~~~~~~~~~~~~~~
 
 When trying to cross compile meson for x86_64 using UCRT64 or MINGW64 env,
 configure will run into an error because the cpu detected is not correct.
@@ -115,4 +163,3 @@ and force a cross compilation (with empty prefix).
 ::
 
     ./configure --cpu=x86_64 --cross-prefix=
-
-- 
2.47.3


