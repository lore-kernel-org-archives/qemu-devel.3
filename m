Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 402ACD591A8
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 17:25:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tD5Ug-00008v-BW; Mon, 18 Nov 2024 12:24:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tD5UE-0008Qe-Ek
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 12:24:31 -0500
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tD5U9-0002qr-D4
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 12:24:30 -0500
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-7f43259d220so1485345a12.3
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2024 09:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731950663; x=1732555463; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O5xaWyMs57+hnnqWUIpSm0cVCeYUwv1WfgxLMkRlc7c=;
 b=kRxe7hahlMiL62pLkLGsVTJudLtvTndyHZoFp6xPyjXAhFLyM4DbaM4BxBZ56Z2SAk
 jsceYgLNjvk8KHltPvp0XpLjtZmv8GdPT+u7nBMZNGVUdZ6IV6iKECFXu76eidFowX6S
 hCBsSQLdu94B1HKpwiO9wtafD5mqxQlTJJpJJtCnwQQKH3K1wEsfh7DYtgffM3FpNwDN
 yxQkjKYcRsXoGxU7CMIFFEex5Hl1AkS4uDiQRjaatKuG7KDPHnCbBpSQOYZFtIXdr3Z7
 gOsoDJHMYcPrySNciQheE41mtpTkigiZcpaVqqMXGCbvmvWPJ23ZbQguH/NU1vRCOqPw
 S2FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731950663; x=1732555463;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O5xaWyMs57+hnnqWUIpSm0cVCeYUwv1WfgxLMkRlc7c=;
 b=JC4GFZDPoTgW9jI/NYP6f3kY8VlLBvVG00Mp5Ukjvw/9WDTNiWYGEyo+EjSv7ofsqb
 Oz2BF8TXvSsj0RyCaSDGrQ0j5xgVH6rXDHPsTHXBIV8NeBYq0yCBcxHnjuyv1JGppmx9
 gwBGHhnU0N/Z9vp+ATOGTuwC1GFGYNV7QhSBdua71B9sdKogMY03o1ihYTiL3L27JC58
 VgSBYfeItNt6T6Pcv7Eodtdz7CIM5+yczWgaFChuDce9BhSMc/xjKt+LVj6IhT0v6ac8
 Fuw66CtFBbt21JwhwyB1001YdVbkXn6NE8cKmHMQK8kAfYH0k6VMqMldLNxOFVHtfTZN
 ZSvg==
X-Gm-Message-State: AOJu0Yx9Ci9mvHMQ39iX7G5T0nVRp2ldrmzUiehKnQnfR4UJ70WoGwzE
 bUZiEfiJXKI6fLK2p4VTg51bWOHWLormDVPZkTi1A8qsFyrcynkzqf5MDZtTGaBYQax6l3+Qni6
 81Ly7ng==
X-Google-Smtp-Source: AGHT+IFd+isfj+MijvIfhlYm0YwRz6KEGHY0eaL6yeO5vKqUx6emPrFwrqa4l0559t1iCFG6uOulPQ==
X-Received: by 2002:a05:6a21:3985:b0:1dc:7907:6d67 with SMTP id
 adf61e73a8af0-1dc90bf49b3mr24723643637.40.1731950662036; 
 Mon, 18 Nov 2024 09:24:22 -0800 (PST)
Received: from linaro.. (216-180-64-156.dyn.novuscom.net. [216.180.64.156])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-211d0f55d04sm59469765ad.264.2024.11.18.09.24.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Nov 2024 09:24:21 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Andrew Melnychenko <andrew@daynix.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Thomas Huth <thuth@redhat.com>,
 alex.bennee@linaro.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 qemu-arm@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>,
 manos.pitsidianakis@linaro.org, qemu-block@nongnu.org,
 Michael Roth <michael.roth@amd.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 gustavo.romero@linaro.org, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 7/7] docs: add a how to section
Date: Mon, 18 Nov 2024 09:23:57 -0800
Message-Id: <20241118172357.475281-8-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241118172357.475281-1-pierrick.bouvier@linaro.org>
References: <20241118172357.475281-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 docs/devel/build-system.rst |   2 +
 docs/how-to/index.rst       | 146 ++++++++++++++++++++++++++++++++++++
 docs/index.rst              |   1 +
 3 files changed, 149 insertions(+)
 create mode 100644 docs/how-to/index.rst

diff --git a/docs/devel/build-system.rst b/docs/devel/build-system.rst
index d42045a2325..db444787e37 100644
--- a/docs/devel/build-system.rst
+++ b/docs/devel/build-system.rst
@@ -1,3 +1,5 @@
+.. _build:
+
 ==================================
 The QEMU build system architecture
 ==================================
diff --git a/docs/how-to/index.rst b/docs/how-to/index.rst
new file mode 100644
index 00000000000..3a9d4d777df
--- /dev/null
+++ b/docs/how-to/index.rst
@@ -0,0 +1,146 @@
+.. _how-to:
+
+------
+How to
+------
+
+This section of the manual will give you some commands to do various tasks with
+QEMU. It does not intend to be complete, but to be simple.
+
+Build
+-----
+
+First you need setup your `build environment <setup-build-env>`.
+
+Then, you can build QEMU using:
+
+::
+
+    git clone https://gitlab.com/qemu-project/qemu
+    cd qemu
+    ./configure
+    ninja -C build
+    # all binaries are in ./build
+
+By default, QEMU build is optimized. You may want to switch to debug builds
+instead (non optimized, and with more runtime checks enabled):
+
+::
+
+    ./configure --enable-debug
+
+It's recommended to use sanitizers to catch issues when developing your change.
+
+::
+
+    ./configure --enable-asan --enable-ubsan
+    # Of course, you can combine debug and sanitizers if needed
+
+You can find more information on `build page <build>`.
+
+Test
+----
+
+QEMU has a lot of tests, mainly in 4 categories:
+
+::
+
+    # run tests related to TCG. They are based on Makefiles.
+    make check-tcg
+    # run system tests, running a full VM, with avocado framework
+    make check-avocado
+    # run functional tests, running a full VM, integrated with Meson
+    make check-functional
+    # run all other tests, integrated with Meson
+    make check
+
+You can find more information on `testing page<testing>`.
+
+Use QEMU
+--------
+
+To create a 20 gigabytes disk image usable with qemu-system:
+
+::
+
+    qemu-img create system.img 20g
+
+To run an x86_64 system emulated, with 4 cpus, 8G of memory and an install iso:
+
+::
+
+    qemu-system-x86_64 -smp 4 -m 8G system.img -cdrom install.iso
+
+To boot directly a Linux Kernel:
+
+::
+
+    qemu-system-x86_64 -kernel bzImage -hda system.img -append "root=/dev/hda"
+
+To boot an aarch64 system emulated, you need to specify a UEFI and associated
+pflash. Once started, you can switch to Serial output by clicking on View ->
+Serial0.
+
+::
+
+    # UEFI can be obtained from debian package qemu-efi-aarch64.
+    # First, we need to copy a file to save UEFI variables:
+    # cp /usr/share/AAVMF/AAVMF_VARS.fd .
+    qemu-system-aarch64 \
+        -m 8G \
+        -smp 4 \
+        -M virt \
+        -cpu max \
+        -device virtio-blk-pci,drive=root \
+        -drive if=none,id=root,file=system.img \
+        -drive if=pflash,readonly=on,file=/usr/share/AAVMF/AAVMF_CODE.fd \
+        -drive if=pflash,file=AAVMF_VARS.fd \
+        -cdrom install.iso
+
+To run git using QEMU user-mode:
+
+::
+
+    qemu-x86_64 /usr/bin/git --version
+
+Contribute
+----------
+
+We recommend using `git-publish <https://github.com/stefanha/git-publish>`_ for
+contributing. You need to configure `git send-email
+<https://git-send-email.io/>`_ first.
+
+::
+
+    git checkout -b my_feature
+    ... # edit, build, test
+    # When ready to send the series...
+
+    # Add upstream QEMU repo as a remote.
+    git remote add upstream https://gitlab.com/qemu-project/qemu
+    # Fetch all new content.
+    git fetch -a upstream
+
+    # Rebase your branch on top of upstream master, and include a signoff.
+    git rebase -i upstream/master --signoff
+    # Check your patches are correct.
+    ./scripts/checkpatch.pl $(git merge-base upstream/master HEAD)..HEAD
+
+    # Send your series, you'll be given a chance to edit cover letter for it.
+    git-publish
+
+    # After review, and other changes, you can send a v2 simply by using:
+    git-publish
+
+If you need to apply locally an existing series, you can use `b4
+<https://github.com/mricon/b4>`_ (installable via pip) to retrieve it:
+
+::
+
+    b4 shazam <series_msg_id>
+    # message id is an identifier present in email sent.
+    # when using patchwork, it is the last part of a series url (2024...):
+    # https://patchew.org/QEMU/20241118021820.4928-1-joel@jms.id.au/
+
+More complete information is available on our `Submit a patch page
+<submitting-a-patch>`.
diff --git a/docs/index.rst b/docs/index.rst
index 2cad84cd77c..e275a9223dd 100644
--- a/docs/index.rst
+++ b/docs/index.rst
@@ -20,5 +20,6 @@ Welcome to QEMU's documentation!
    interop/index
    specs/index
    devel/index
+   how-to/index
    codebase/index
    glossary/index
-- 
2.39.5


