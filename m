Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A04A3D1D478
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 17:12:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdtYT-0000pP-7A; Thu, 08 Jan 2026 12:12:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1vdtYO-0000n3-SC
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 12:12:10 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1vdtYN-0000DL-B5
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 12:12:08 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-29f2676bb21so30484855ad.0
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 09:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767892326; x=1768497126; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UV+nDC+Oo5TrLoCwsmUkKSCdy3gjvk4o+sIDLbsc5vg=;
 b=naSqkea07s90lIEkp4otbLeApsjeIRT2h34yR6oY4HQVk9O9wkrIjrTiwvowq1vS5R
 fxjZRcnOveI6GyFj/9yzS+RsHwOomsXldTTDgKGe7UFlX91B4RuhmqSQEzYDhAr9ImZm
 oi7jfpe/KOLtCsb+ZMxXhDnHVyP4flszfh8ZVRNpecqIcfjtszEPmvo8xeo44kveHcXz
 h/t9RgE74CbS8Psuo2GEe/Xxq9IT+LgVg1HF9RZeqB+NmWw0P/1onaDMFQDoT98ipcvo
 TSN8hNI/yld66lqYIOmHKjlLR7dh+9sUK+xqF5BuopBrR+PaW/IV0Y9tYO4/XilP9/Tz
 NKdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767892326; x=1768497126;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UV+nDC+Oo5TrLoCwsmUkKSCdy3gjvk4o+sIDLbsc5vg=;
 b=gUA3Dq5UBgXgHzR88Qs4+RJwukv7AEu+J8iw/9vCX2EK3DGYlqUxZHyouw8glZHSwo
 7zGqGDbYLp5YqBfuFLJIS0QQG6BcAYJy9K4uhtYteCl4+8AaIDF6urtvbRdndYC1eug1
 vvuwHRu1bTa6FvRe2BLKa6pKg0s8dB4rQL6nBLjTrtcKHX0K7twUnFx1rkRPFbNriOEI
 v+7hfcgiaxDdKl787fZFG2TGOZXe3yMJMBKscKX7/0iydnkzf7w2K+19b9Y9+7dIdkDM
 G18SJ5J26ErjNkRtG1v4oQFbT9uARpn9UtWk433KgZt2ImhiQ2oRzuMdsJuCwfKhF79O
 zyew==
X-Gm-Message-State: AOJu0Yx18TpOCvJejrg6DIN23E12eu3TJa+xGmP33okpATJ941qFfOD2
 7yUjYnjx4oWVULVhNu/lTVIuEDy44yCYSTAnR7nBZIVB3gdq8HZPiZ/V9WfbrFsf
X-Gm-Gg: AY/fxX5G49BGG5nvIMltCkl1boMiX2TWgLnkqyMwJOBH7h7SIeeCc/7/76bfIgKSURq
 OROz0UixPwatlD46Y8e4APdXAHyeMzM+t0NsFu1S3UBs+nCJpEtZK2GE+mRwO/fcWsblpDAXxB/
 diliQZ+WVucaw9/RB+/MBAu3GH/ET8Tp2fnOD/gGcP9A1+2N26YWu4JYW1vuOpjiEmlZlQWelWX
 8NvmGGonMsx/pLXOR+jH379peTRfenaIwGTF1LO2Hythpj2LEvnzcIL0rEpH1zXiqD3Uo00Lrw1
 FnnPFhk+K3lW8pnKPwHTnMO9LFZuIj1ZwwLVEchuJ+ZVnvgFX1YX0OTEaLYYCQO6tZb5SerOeY1
 VwX/cFZp2KhaQip9QUMtV19e4hzqKyB7QSsWsfbXg1Do8C6xwHVW8AoUrq8XIQqfrITj/pSCiWe
 O6JRgWy6GE1Q==
X-Google-Smtp-Source: AGHT+IGu0SnWrDPVC5QcHbM4uuhqB+TjyCaX7XxJLzl0ScRSjWh4fzysbWk1FZ8yhKNOxBIRmdLRdg==
X-Received: by 2002:a17:902:d708:b0:2a2:f2e6:cc54 with SMTP id
 d9443c01a7336-2a3ee424bfbmr43271035ad.4.1767892325737; 
 Thu, 08 Jan 2026 09:12:05 -0800 (PST)
Received: from ktock.. ([240d:1a:3b6:8b00:7ace:63ca:408f:4cc4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3c3a507sm82808355ad.3.2026.01.08.09.12.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 09:12:05 -0800 (PST)
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
Subject: [PATCH v4 1/4] meson: Add wasm64 support to the --cpu flag
Date: Fri,  9 Jan 2026 02:11:25 +0900
Message-ID: <91f16f0e9ae6b36fbf0c2caac510dcf855120400.1767886100.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1767886100.git.ktokunaga.mail@gmail.com>
References: <cover.1767886100.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pl1-x631.google.com
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


