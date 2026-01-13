Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FE59D2D105
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 13:56:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vferP-0003AC-Dx; Tue, 13 Jan 2026 08:55:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1vferN-00039e-QI
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 08:55:01 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1vferM-0000MP-3F
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 08:55:01 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2a081c163b0so48903395ad.0
 for <qemu-devel@nongnu.org>; Tue, 13 Jan 2026 05:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768312499; x=1768917299; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UV+nDC+Oo5TrLoCwsmUkKSCdy3gjvk4o+sIDLbsc5vg=;
 b=h12rjZEVUYKvQQIOvRazeMhPsRwIA2hTuj3HxnJ2GTT7q6TdQZ2s3R3ZDgxKWcclfL
 ogj50msIGnLfpPLoM7H27f7u5DDyZQN82LXMh0qJylb4W/z6X1ixDmNaE33hYpwf63nw
 wRO3yhLdbaS4lU3pdMxOqUCPa7k5IwSb7VE5zOO8tT3IjaPvsNSe4xWR8HCSSlHEfljB
 TWMHp1Hyzgpl6pV6lkHWLYRuSBx4qHSYlUcJUI/ogGwNkdN4BLVOdT+DwMa+vqLk9TlY
 MHD/Q4s7MXMhWv8NBhn23W2UpksC7fOHwKMP+oT8jF0PoD2m63Rc2xUxXYaFM1gPgqnV
 LdfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768312499; x=1768917299;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UV+nDC+Oo5TrLoCwsmUkKSCdy3gjvk4o+sIDLbsc5vg=;
 b=SYaebn0FDQy4Q3d/JgkIbD4eBOWLQJ2/4AHL+Ygh2+GpnCReVREM4vj+0Kvn8Y1n42
 HWaLCS4coSnzU3Mwjsd9UrRWyQlUYcBxK7SUatpdlLzc0Tapca0lvDg7Bc5yvS7tqLhb
 HFRabBS+xjx8xkmBtN5xNojBGIxcuRDlZ64cjyefga+GbEG3Il1nUoDu7Pe4R8dSOECR
 m/2EgEJ1+fyAKrJdFi3+8Gsy/w0EzuUKaUmgpVEaABWnLV4Bv9Z7o/UOx6w9/KFVi6yJ
 8QbpjtDuDE0CXlMkAli+bDTKEU+YurFCQ2nUAq1A6anDxYgH+gwmpJ3tbRI00sB6659/
 /uXg==
X-Gm-Message-State: AOJu0YykKmLR3kWXcF26tZHBVpcyM13nueZ8JxTFJOKCEIlQJrrIj8yu
 sEYLAdc7dqE4xGfXUeUGO1H6/msSvdteV6dXA8qCGwbuFwQXGTfN0zIuMEBbupSU
X-Gm-Gg: AY/fxX5EDexiK0+iXMrl2kKpx3u+FndztgUbR0Z+/p+PLaIuRc6kfNiZsbK8PYLteN3
 XlTGx4QrcOagSMjU5PI5UrMXp8XmWO0RUIFBUSjWF9ED5XWS1TlyjbXj2mTvGHBKJxNpQRaZuPa
 puYWEYTZpiJP+OQXaLjxoBUPfiiS6Kvl2vinWuUQhO1A13I1uXm0rZSmt6JBwZIEFSrlGvavpDN
 xho08dMXzP7Ir5FLRQL2xV71UuHUXIHgJwOv9jjtj/awQfbgAh/6yKiNP+X2ebc+RT1BXVCOW95
 CdhPt86rdowIdbTBPWaCiKFLSdO/LcJj0ysIbFUtPRHmeGPed6z4pk4sEYNHc39zal7BbzwV1Bw
 G178G4IRBpgFKCxbsDFzATC5un+SfBKDFCIkfQ3cdQgn8rtK5VL0EkdoJsZrero+Uxc5gJjC/0i
 TZ0OXJLTBR0A==
X-Google-Smtp-Source: AGHT+IFX8ZYUN7T6V//J5KlGZIda5ht1KbDs1O0wITEkOzZUNqMwhFlnKFg7/yS8+h3lQ7qkWfD3ZA==
X-Received: by 2002:a17:903:b90:b0:2a0:b461:c883 with SMTP id
 d9443c01a7336-2a3ee4900e1mr199312895ad.45.1768312498596; 
 Tue, 13 Jan 2026 05:54:58 -0800 (PST)
Received: from ktock.. ([240d:1a:3b6:8b00:eb29:7536:a39f:7476])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3c3a2eesm38240465ad.6.2026.01.13.05.54.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 05:54:58 -0800 (PST)
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v5 1/4] meson: Add wasm64 support to the --cpu flag
Date: Tue, 13 Jan 2026 22:54:28 +0900
Message-ID: <91f16f0e9ae6b36fbf0c2caac510dcf855120400.1768308374.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1768308374.git.ktokunaga.mail@gmail.com>
References: <cover.1768308374.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pl1-x635.google.com
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

wasm64 target enables 64bit pointers using Emscripten's -sMEMORY64=1
flag[1]. This enables QEMU to run 64bit guests.

Although the configure script uses "uname -m" as the fallback value when
"cpu" is empty, this can't be used for Emscripten which targets to Wasm.
So, in wasm build, this commit fixes configure to require --cpu flag to be
explicitly specified by the user.

[1] https://emscripten.org/docs/tools_reference/settings_reference.html#memory64

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 configure   | 6 +++++-
 meson.build | 4 ++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/configure b/configure
index 55e0bd3425..92bfc5f976 100755
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
@@ -419,6 +418,8 @@ elif check_define __aarch64__ ; then
   cpu="aarch64"
 elif check_define __loongarch64 ; then
   cpu="loongarch64"
+elif check_define EMSCRIPTEN ; then
+  error_exit "wasm32 or wasm64 must be specified to the cpu flag"
 else
   # Using uname is really broken, but it is just a fallback for architectures
   # that are going to use TCI anyway
@@ -519,6 +520,9 @@ case "$cpu" in
   wasm32)
     CPU_CFLAGS="-m32"
     ;;
+  wasm64)
+    CPU_CFLAGS="-m64 -sMEMORY64=1"
+    ;;
 esac
 
 if test -n "$host_arch" && {
diff --git a/meson.build b/meson.build
index db87358d62..d072473243 100644
--- a/meson.build
+++ b/meson.build
@@ -51,7 +51,7 @@ qapi_trace_events = []
 bsd_oses = ['gnu/kfreebsd', 'freebsd', 'netbsd', 'openbsd', 'dragonfly', 'darwin']
 supported_oses = ['windows', 'freebsd', 'netbsd', 'openbsd', 'darwin', 'sunos', 'linux', 'emscripten']
 supported_cpus = ['ppc', 'ppc64', 's390x', 'riscv32', 'riscv64', 'x86', 'x86_64',
-  'arm', 'aarch64', 'loongarch64', 'mips64', 'sparc64', 'wasm32']
+  'arm', 'aarch64', 'loongarch64', 'mips64', 'sparc64', 'wasm32', 'wasm64']
 
 cpu = host_machine.cpu_family()
 
@@ -914,7 +914,7 @@ if have_tcg
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


