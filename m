Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5939CCD199
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 15:06:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9PWT-0002Bj-MI; Thu, 16 Oct 2025 11:04:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v9PWS-0002Bb-Sy
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 11:04:08 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v9PWN-0001A4-Tw
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 11:04:08 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4710ff3ae81so3418375e9.0
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 08:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760627040; x=1761231840; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W0x6s7dJTtXqf7qyTS5AFXH1QH8sqfuQfSpFJBVT5Bc=;
 b=jNrFEw5zFoC4gfUn9b8BU/j4vVgGo7ik84gEea8iHj84xEC+OyVjRyZuyjsliEs9X+
 W9rTmGVR61C4xnQrVAShp4guC0ms4HTkymgBJ2P3iGvzyXFusNkxjHuPHZM++wHKzq0r
 gxd5R90z2TBXi8gLNf0+y24Kb+53E2OIAQbV0+RRTlfSAFxK0V4S8fI25Atxzm7WIj4y
 K5AuE2nqF2slXuLAdZUsxqiLC++Z9MlV1Z4bvic/wldwImQqOKp9tjfsTkAdOZEDcWWF
 tjoWh5gtAcRdGAPDFhMFuQzqPiOHuZo+ReMF/GmbROO6Pg1R2HohtQrstXJLtgN5rKIh
 cWmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760627040; x=1761231840;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W0x6s7dJTtXqf7qyTS5AFXH1QH8sqfuQfSpFJBVT5Bc=;
 b=a3wbZJFO1BLkiJh0zQ0fyoaFjwuIX7//CBpYKOOwwyn8AFsnavXC79Vsx4VrDPEkBM
 Y67MVtjOsaXyLj3qBgRH2Y2/qc57LfKAWpvGsjHuld9gVyqa/kx/lEi3QLG4HxPDrhyl
 c17asIfN9Bh2PtpllBYz1GtDbyuTwa29xuj/LT4MSWXFrQWxl8QjXJS0Im271AU04OuB
 SRC6Mma/KNlNUbTd8HHknHCISG+y85JLqDfKNJmmlXkVrcBqJXbR5yiToHXJ8qXV0cd7
 z8ToWoGVH2f7pXE0K0ZJCnHl4jXHuTK+fIRCZ6ImsUJKLiK82G2Yf04l5M24Z8D2mrED
 q8Jw==
X-Gm-Message-State: AOJu0YwZcuYAaQiPgviMwC0KvKYVVvWHUFkEytxkRCLvIS8xi0WVE9At
 i42CzpjDe4FoXS/hzdcBJf1r9WRGXyd3pPilrqUAd85sJqOJyGuYpzbLKQNecWuK+Ak=
X-Gm-Gg: ASbGncuTLmFHMg0ZjFY+Ebe4D0QvL4BxWsF5wrIJr2JVNY5VIrbF6tGPctR2xRLkn4z
 cCEiz1Ubkh3IFaLeEvjVeHKO1nhqIzlZGKucirZ9mSZ9SO4oAqE677Usm06LK+aztjf2s6zQiQ1
 g4j5pNb6VLH1SvW8VXqoMeFcSe+CYQsIV8iys7ZpxcHFlOASnFKGrE/7RRKUN09Admo7Fn1Cw3o
 um30Nxha0AJoXd4YO7zGSjiqFfwS+hsL4lYwhSpMyqvkh3k5lj/bXmHa3RQOBnlMhyp8kWk1Xn8
 40MqrO8jbBHd1NeS1JR2RVNXtq/jbcUDa3zH1pL/lJ9Ko7pyug1WkWpVcea+AEujrIG9xcX8lEW
 FZrNS9p3chU7+3rUwoY+dHL34t1ibz1+NlVBlVVdzBZRv4N0yu8597NYtUy8HfGjQMXT0jRiZZT
 CRGUKQ
X-Google-Smtp-Source: AGHT+IGaotG52V3vLou9TtMvJuKkTHgM3OvrcgXpKfg2DViKUrt9lJlvcdKa52jx1kTc293B1y4MIQ==
X-Received: by 2002:a05:600c:b8d:b0:46e:1a14:a81b with SMTP id
 5b1f17b1804b1-47117925ce1mr2242205e9.36.1760627039801; 
 Thu, 16 Oct 2025 08:03:59 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-471144b5d48sm32265055e9.9.2025.10.16.08.03.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Oct 2025 08:03:58 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A823F5FA6C;
 Thu, 16 Oct 2025 16:03:57 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Levon <john.levon@nutanix.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Thomas Huth <thuth@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PATCH 02/11] gitlab: drop aarch32 runner and associated bits
Date: Thu, 16 Oct 2025 16:03:47 +0100
Message-ID: <20251016150357.876415-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251016150357.876415-1-alex.bennee@linaro.org>
References: <20251016150357.876415-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
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

While working out what hoops to jump through to get a full set of
aarch32 packages installed on the aarch64 runner it was pointed out 32
bit host support is deprecated. As the extra packages where needed for
system emulation (marked deprecated since 8.0!) there didn't seem much
point keeping this in.

While the full expunging of 32 bit host support will probably be done
for 11.0 we can at least reduce the CI burden a bit now.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .gitlab-ci.d/custom-runners.yml               |   1 -
 .../custom-runners/ubuntu-24.04-aarch32.yml   |  25 ----
 scripts/ci/setup/ubuntu/build-environment.yml |  17 ---
 .../setup/ubuntu/ubuntu-2204-armhf-cross.yml  | 127 ------------------
 4 files changed, 170 deletions(-)
 delete mode 100644 .gitlab-ci.d/custom-runners/ubuntu-24.04-aarch32.yml
 delete mode 100644 scripts/ci/setup/ubuntu/ubuntu-2204-armhf-cross.yml

diff --git a/.gitlab-ci.d/custom-runners.yml b/.gitlab-ci.d/custom-runners.yml
index 3eb8216d571..142fbf4a242 100644
--- a/.gitlab-ci.d/custom-runners.yml
+++ b/.gitlab-ci.d/custom-runners.yml
@@ -31,4 +31,3 @@
 include:
   - local: '/.gitlab-ci.d/custom-runners/ubuntu-24.04-s390x.yml'
   - local: '/.gitlab-ci.d/custom-runners/ubuntu-24.04-aarch64.yml'
-  - local: '/.gitlab-ci.d/custom-runners/ubuntu-24.04-aarch32.yml'
diff --git a/.gitlab-ci.d/custom-runners/ubuntu-24.04-aarch32.yml b/.gitlab-ci.d/custom-runners/ubuntu-24.04-aarch32.yml
deleted file mode 100644
index 75029c9187e..00000000000
--- a/.gitlab-ci.d/custom-runners/ubuntu-24.04-aarch32.yml
+++ /dev/null
@@ -1,25 +0,0 @@
-# All ubuntu-24.04 jobs should run successfully in an environment
-# setup by the scripts/ci/setup/ubuntu/build-environment.yml task
-# "Install basic packages to build QEMU on Ubuntu 24.04"
-
-ubuntu-24.04-aarch32-all:
- extends: .custom_runner_template
- needs: []
- stage: build
- tags:
- - ubuntu_24.04
- - aarch32
- rules:
- - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
-   when: manual
-   allow_failure: true
- - if: "$AARCH32_RUNNER_AVAILABLE"
-   when: manual
-   allow_failure: true
- script:
- - mkdir build
- - cd build
- - ../configure --cross-prefix=arm-linux-gnueabihf-
-   || { cat config.log meson-logs/meson-log.txt; exit 1; }
- - make --output-sync -j`nproc --ignore=40`
- - make --output-sync -j`nproc --ignore=40` check
diff --git a/scripts/ci/setup/ubuntu/build-environment.yml b/scripts/ci/setup/ubuntu/build-environment.yml
index 6042750cb4d..0f8ec5fab04 100644
--- a/scripts/ci/setup/ubuntu/build-environment.yml
+++ b/scripts/ci/setup/ubuntu/build-environment.yml
@@ -47,21 +47,4 @@
         - ansible_facts['distribution'] == 'Ubuntu'
         - ansible_facts['distribution_version'] == '24.04'
 
-    - name: Install armhf cross-compile packages to build QEMU on AArch64 Ubuntu 24.04
-      package:
-        name:
-          - binutils-arm-linux-gnueabihf
-          - gcc-arm-linux-gnueabihf
-          - libblkid-dev:armhf
-          - libc6-dev:armhf
-          - libffi-dev:armhf
-          - libglib2.0-dev:armhf
-          - libmount-dev:armhf
-          - libpcre2-dev:armhf
-          - libpixman-1-dev:armhf
-          - zlib1g-dev:armhf
-      when:
-        - ansible_facts['distribution'] == 'Ubuntu'
-        - ansible_facts['distribution_version'] == '24.04'
-        - ansible_facts['architecture'] == 'aarch64'
 
diff --git a/scripts/ci/setup/ubuntu/ubuntu-2204-armhf-cross.yml b/scripts/ci/setup/ubuntu/ubuntu-2204-armhf-cross.yml
deleted file mode 100644
index 0cc34cd10b9..00000000000
--- a/scripts/ci/setup/ubuntu/ubuntu-2204-armhf-cross.yml
+++ /dev/null
@@ -1,127 +0,0 @@
-# THIS FILE WAS AUTO-GENERATED
-#
-#  $ lcitool variables --cross-arch armv7l ubuntu-2204 qemu
-#
-# https://gitlab.com/libvirt/libvirt-ci
-
-packages:
-  - bash
-  - bc
-  - bison
-  - bsdextrautils
-  - bzip2
-  - ca-certificates
-  - ccache
-  - dbus
-  - debianutils
-  - diffutils
-  - exuberant-ctags
-  - findutils
-  - flex
-  - gcc
-  - gcovr
-  - gettext
-  - git
-  - hostname
-  - libglib2.0-dev
-  - libpcre2-dev
-  - libsndio-dev
-  - libspice-protocol-dev
-  - llvm
-  - locales
-  - make
-  - meson
-  - mtools
-  - ncat
-  - ninja-build
-  - openssh-client
-  - pkgconf
-  - python3
-  - python3-numpy
-  - python3-opencv
-  - python3-pillow
-  - python3-pip
-  - python3-sphinx
-  - python3-sphinx-rtd-theme
-  - python3-tomli
-  - python3-venv
-  - python3-yaml
-  - rpm2cpio
-  - sed
-  - socat
-  - sparse
-  - swtpm
-  - tar
-  - tesseract-ocr
-  - tesseract-ocr-eng
-  - xorriso
-  - zstd
-  - gcc-arm-linux-gnueabihf
-  - libaio-dev:armhf
-  - libasan6:armhf
-  - libasound2-dev:armhf
-  - libattr1-dev:armhf
-  - libbpf-dev:armhf
-  - libbrlapi-dev:armhf
-  - libbz2-dev:armhf
-  - libc6-dev:armhf
-  - libcacard-dev:armhf
-  - libcap-ng-dev:armhf
-  - libcapstone-dev:armhf
-  - libcmocka-dev:armhf
-  - libcurl4-gnutls-dev:armhf
-  - libdaxctl-dev:armhf
-  - libdrm-dev:armhf
-  - libepoxy-dev:armhf
-  - libfdt-dev:armhf
-  - libffi-dev:armhf
-  - libfuse3-dev:armhf
-  - libgbm-dev:armhf
-  - libgcrypt20-dev:armhf
-  - libglib2.0-dev:armhf
-  - libglusterfs-dev:armhf
-  - libgnutls28-dev:armhf
-  - libgtk-3-dev:armhf
-  - libibumad-dev:armhf
-  - libibverbs-dev:armhf
-  - libiscsi-dev:armhf
-  - libjemalloc-dev:armhf
-  - libjpeg-turbo8-dev:armhf
-  - libjson-c-dev:armhf
-  - liblttng-ust-dev:armhf
-  - liblzo2-dev:armhf
-  - libncursesw5-dev:armhf
-  - libnfs-dev:armhf
-  - libnuma-dev:armhf
-  - libpam0g-dev:armhf
-  - libpipewire-0.3-dev:armhf
-  - libpixman-1-dev:armhf
-  - libpng-dev:armhf
-  - libpulse-dev:armhf
-  - librbd-dev:armhf
-  - librdmacm-dev:armhf
-  - libsasl2-dev:armhf
-  - libsdl2-dev:armhf
-  - libsdl2-image-dev:armhf
-  - libseccomp-dev:armhf
-  - libselinux1-dev:armhf
-  - libslirp-dev:armhf
-  - libsnappy-dev:armhf
-  - libspice-server-dev:armhf
-  - libssh-dev:armhf
-  - libsystemd-dev:armhf
-  - libtasn1-6-dev:armhf
-  - libubsan1:armhf
-  - libudev-dev:armhf
-  - liburing-dev:armhf
-  - libusb-1.0-0-dev:armhf
-  - libusbredirhost-dev:armhf
-  - libvdeplug-dev:armhf
-  - libvirglrenderer-dev:armhf
-  - libvte-2.91-dev:armhf
-  - libxen-dev:armhf
-  - libzstd-dev:armhf
-  - nettle-dev:armhf
-  - systemtap-sdt-dev:armhf
-  - zlib1g-dev:armhf
-
-- 
2.47.3


