Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA3BBC87FCF
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 13:59:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uivhm-0006qU-AW; Mon, 04 Aug 2025 09:58:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uiulF-0004M7-BE
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 08:58:04 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uiulD-0000SN-3u
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 08:57:52 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-76be6f0557aso3081785b3a.1
 for <qemu-devel@nongnu.org>; Mon, 04 Aug 2025 05:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754312268; x=1754917068; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VZ95h7fnUozk5YehSRRgXLq/R5cFsoMSexleWIPzr1E=;
 b=ZDYhNuqW+wAlcHHMC3E4CmqogPp14rcTk5dJCqSI7tcki+sACRQ6n4jjhvdE4Hk7xv
 LR/CuR7pDvY3ty1wgK8r+XK9rzjII+vYE8ZZXiOEk5eD/Ju+oFo8i9Tmc9atY5x2eayr
 hy5Am33F3PiVIFWuZq6Q1FykNTcznhmmwA+8Soe7qQmMZ/dtsFnFb4bkiZgQB0WzTrVb
 reflPfV4eOkUO75xfmGM5ogO4VcTk5yJI/2bL7EcqDeQnt7e23ecxlD65a1HYM/FScjB
 5AiaH+ZvSh7edISl0PFmemVX7zj6WU8Y2Yh0tdnAMi6upITv0fyjEYwMdOvvwHv1leB2
 N/Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754312268; x=1754917068;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VZ95h7fnUozk5YehSRRgXLq/R5cFsoMSexleWIPzr1E=;
 b=JvJRIMHY3yG/DmoOF0AV9pmWd4uijQHyEcLec0z1s5Y4qR1e8E6aq9N/RYuRSL1NL3
 pxBKe4dTH5U90zCHJo/5v095f9FrFr1F+3oSGTxyG3thfJHjked7KRpMNt8G9x0ckIVK
 ghJ6cP7nhPDozaatI3ujf/RRMOXbheKG1LFmsKpFaF+jhPr6T6GJaWUCdwJ8VzJNgQaD
 qFLpVHq8M4Hcr7cfn5d/bA+lFrtyGn3jCMrb164kGPHjldRxV4KlbQDzpnsoCqy5XCDr
 MQeYRkOB1pHeGbza/STdE3rR1yNoG6uu7KnmY5TFCGuUSSGr3URw3ZZjQHzS19kSyYqu
 MT0A==
X-Gm-Message-State: AOJu0YzuJVg3GP/jAZ7Xza0A+xLDk0Ki3RIzxZSQFXibme9UiXNrdyeS
 nUTpULya/3bNhgM/cJaa46tCGrIxua3W3HGe3jUuw3llwivGG8LKSPn28q7oUQ==
X-Gm-Gg: ASbGncu/RGaCHsA8A6viH0QGKOftP05lH8x1othcG+jFgiv29/Wl7w08vQ4K0tOIyHu
 /1DxQKkBqdqtq3B8r/fuSD3JSUPufbfuPF0xOd36ZAMGao/XRMP0l2uNxn+YCPkZkum6779P481
 V2eVvUxNKWMYpznlf0WQ7rEqerA28HrpQLnhdQXbSyv90pb3ykiKQXqu6aywp5sCDx8aOaDl/aW
 /d2Zkh2aNWtHg1ahZ4FUK8tLMWCD88mOJqwW5nR2oG9PcpROjJ8mpGWm8t5udGWwOLV/AifQoRx
 qxh9tibBSq3ZjQrE3+NQlg9I0p+lvpigaubqBVVPOyq3tqskHGrBEWOoQtIKXKJfSx/Akb3KHBR
 JIOOYaB7DnzeLnLraWhIS/g==
X-Google-Smtp-Source: AGHT+IHqwalA5mv0sCr7uJw+dRTdaPYl92FZAvh8o2WM2wcsVV7XqEj04qKpFnzQ6Xm6HEVr3Mkwcw==
X-Received: by 2002:a05:6a21:33a2:b0:21a:b78b:e916 with SMTP id
 adf61e73a8af0-23df9808914mr14177331637.27.1754312268503; 
 Mon, 04 Aug 2025 05:57:48 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:d117:15e5:e721:f1cd])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bcce8f800sm10488308b3a.42.2025.08.04.05.57.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Aug 2025 05:57:47 -0700 (PDT)
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, ktokunaga.mail@gmail.com
Subject: [PATCH 1/4] meson: Add wasm64 support to the --cpu flag
Date: Mon,  4 Aug 2025 21:57:14 +0900
Message-ID: <ac10a681d44665df56bf7f35660719b29654119d.1754310749.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1754310749.git.ktokunaga.mail@gmail.com>
References: <cover.1754310749.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pf1-x435.google.com
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

wasm64 target enables 64bit pointers using Emscripten's -sMEMORY64=1
flag[1]. This enables QEMU to run 64bit guests.

Although the configure script uses "uname -m" as the fallback value when
"cpu" is empty, this can't be used for Emscripten which targets to Wasm.
So, in wasm build, this commit fixes configure to require --cpu flag to be
explicitly specified by the user.

[1] https://emscripten.org/docs/tools_reference/settings_reference.html#memory64

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 configure   | 6 +++++-
 meson.build | 4 ++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/configure b/configure
index 825057ebf1..7f3893a42f 100755
--- a/configure
+++ b/configure
@@ -365,7 +365,6 @@ elif check_define __APPLE__; then
   host_os=darwin
 elif check_define EMSCRIPTEN ; then
   host_os=emscripten
-  cpu=wasm32
   cross_compile="yes"
 else
   # This is a fatal error, but don't report it yet, because we
@@ -425,6 +424,8 @@ elif check_define __aarch64__ ; then
   cpu="aarch64"
 elif check_define __loongarch64 ; then
   cpu="loongarch64"
+elif check_define EMSCRIPTEN ; then
+  error_exit "wasm32 or wasm64 must be specified to the cpu flag"
 else
   # Using uname is really broken, but it is just a fallback for architectures
   # that are going to use TCI anyway
@@ -535,6 +536,9 @@ case "$cpu" in
   wasm32)
     CPU_CFLAGS="-m32"
     ;;
+  wasm64)
+    CPU_CFLAGS="-m64 -sMEMORY64=1"
+    ;;
 esac
 
 if test -n "$host_arch" && {
diff --git a/meson.build b/meson.build
index e53cd5b413..291fe3f0d0 100644
--- a/meson.build
+++ b/meson.build
@@ -52,7 +52,7 @@ qapi_trace_events = []
 bsd_oses = ['gnu/kfreebsd', 'freebsd', 'netbsd', 'openbsd', 'dragonfly', 'darwin']
 supported_oses = ['windows', 'freebsd', 'netbsd', 'openbsd', 'darwin', 'sunos', 'linux', 'emscripten']
 supported_cpus = ['ppc', 'ppc64', 's390x', 'riscv32', 'riscv64', 'x86', 'x86_64',
-  'arm', 'aarch64', 'loongarch64', 'mips', 'mips64', 'sparc64', 'wasm32']
+  'arm', 'aarch64', 'loongarch64', 'mips', 'mips64', 'sparc64', 'wasm32', 'wasm64']
 
 cpu = host_machine.cpu_family()
 
@@ -916,7 +916,7 @@ if have_tcg
     if not get_option('tcg_interpreter')
       error('Unsupported CPU @0@, try --enable-tcg-interpreter'.format(cpu))
     endif
-  elif host_arch == 'wasm32'
+  elif host_arch == 'wasm32' or host_arch == 'wasm64'
     if not get_option('tcg_interpreter')
       error('WebAssembly host requires --enable-tcg-interpreter')
     endif
-- 
2.43.0


