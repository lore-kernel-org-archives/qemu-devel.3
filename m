Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CD90C36010
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Apr 2025 15:17:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1oAt-00023H-LU; Mon, 07 Apr 2025 11:14:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u1nln-00028P-HZ; Mon, 07 Apr 2025 10:48:16 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u1nll-0001gg-If; Mon, 07 Apr 2025 10:48:15 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-736c3e7b390so3997413b3a.2; 
 Mon, 07 Apr 2025 07:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744037291; x=1744642091; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eS7eXR/+DdOMAXfY7Q+DNRv1hMrXf+iqTPbLWHVDLlk=;
 b=Na4t6OQM4boJIp/Pmewa0k6IlmjtZh0gl2hejofMfN/Yqpn2ZWZmpds8aIIsjAL5Xd
 lIwJwlDe/XL5n6n7hJ7fHL8+arRk1ucvSJW20Wo7t1iQuSIhaUUFiVQYAc6OJNbOFJi2
 VYnYaOsRfsAn7eNLQAL1GAAZz2DCAmbBR/zgBIt1EEl6dVkt4h+qLotvPiBZp7sK+U3p
 ZZpHihQe8upZFE7Bn3Wamc+m6IIfgDj6NOhFoDgOKCUvK+a+FvF9VyGRcNr9i3YTh0sx
 BmQqok1OA0NSaBkgS1AC7MuLqTSCHErbIK7twmPKSW1mXyUIaMKzBdAYr2XU58nimEib
 C6rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744037291; x=1744642091;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eS7eXR/+DdOMAXfY7Q+DNRv1hMrXf+iqTPbLWHVDLlk=;
 b=GBEP4SGJYp/Pssz88SAlEMwrCPGYr84bJ96zcHh/gaPmyHqLNF/P/VHST9EDLLe9pt
 +fMz0OCRiH8CEpT23QaTX93fIxi85gsZcwx0YRSu9VtoWK2qiMnGQAn7EAElsocSoSo1
 PB5Up84RIy4wc9qqWJUYaAxSytn1pYlpYqCFUXQ62INLyyfGyn+0tq4uIDtAbVRx026u
 rbP4Vsg1xShYwkKG/pYm6UhEIY34nazwX6REzyCSFjca81oiFCSQJfl+izH/2TRAnjqD
 MX2dNA14baLgqCYX0PrXZvNtiLRkS1pVs2rzz7m3arbOYI4IXXedi9rBw0CGI8BBdiA/
 qhnw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0cUSr5qhh/T7nxJbwgKYHHHOhvRDw4hxoku80pdmkkdbq5ALgqllzEX8Wl9ApeAW7lDHkgzBkIqG7Ow==@nongnu.org,
 AJvYcCWQMCESvO2hHcYIhGY5fDd1ByKxAo6TEt2AsrHeuLP1FJWLdTpRtU0xkWUR8WV2xIZkZW47q+D4iQ==@nongnu.org,
 AJvYcCWrG4cNOkTv86pOr8ZXVpsyQWAcDcWGQVG+9nEbs2HvC1iUqXAMb+H3IXbzlpJi1clk6IjGZcFSvnl6+Q==@nongnu.org
X-Gm-Message-State: AOJu0Yyb1LP+VgxJNU88QzupFvexAuAcWOOHqmN74Tn0q1Hitggxkufh
 kflNT8te3HUHGkUUGOZhQqsW44aciNr5Tf0W7nQxKQcbr0+EQYZfumWcefjg
X-Gm-Gg: ASbGncv7oDgKvIp77bjWk6Fd1YjJWAvIVmX59mvGTBIDpnODqOcgPZ06Zq3JwNwhxhH
 mVLUmu6kv4O7MgFCPZ3bB719olx/abTHs71iJL6xYeLluHCVKGxqS6LbuQ8z8i6mJTtmIJGmqAq
 Z+DrSmAlfrrCkNOMKi0drZzzJ8QiPGRDhJvKZ0KevIjl3AliFIAXfHTzNHB8i6UGlbB9AbHd9yE
 Ln+TaHzKMNwf6SuhnXNF+I0aBzK1Vq7y3IgPw4XmCG55CtY9W1snhVWxgaBSM5ub7qBZ9PSNJQc
 7PqRLS9f8cSVZQ1ejk1JKmnmhD4paW0FQPdtYdubSGP9MycMmTx74WvmNQx8Bg==
X-Google-Smtp-Source: AGHT+IEBJV8PXN2+xgPpGnGGxW+rcmF9NYagYDrP8jIyQSc8TCL+FbPaJa4t0px/C7vZ0Fzdop2MCQ==
X-Received: by 2002:a05:6a00:1411:b0:732:5164:3cc with SMTP id
 d2e1a72fcca58-739e711fcf5mr16357894b3a.19.1744037290570; 
 Mon, 07 Apr 2025 07:48:10 -0700 (PDT)
Received: from localhost.localdomain ([240d:1a:3b6:8b00:8768:486:6a8e:e855])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-739d97ef3c2sm8856960b3a.59.2025.04.07.07.48.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 07:48:10 -0700 (PDT)
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 qemu-riscv@nongnu.org, qemu-arm@nongnu.org
Subject: [PATCH 05/10] meson: Add wasm build in build scripts
Date: Mon,  7 Apr 2025 23:45:56 +0900
Message-Id: <04b7137a464e0925e2ae533bbde4fcdfe0dfe069.1744032780.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1744032780.git.ktokunaga.mail@gmail.com>
References: <cover.1744032780.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 07 Apr 2025 11:14:07 -0400
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

has_int128_type is set to false on emscripten as of now to avoid errors by
libffi. And tests aren't integrated with Wasm execution environment as of
now so this commit disables tests.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 configs/meson/emscripten.txt  |  6 ++++++
 configure                     |  7 +++++++
 meson.build                   | 14 ++++++++++----
 meson_options.txt             |  2 +-
 scripts/meson-buildoptions.sh |  2 +-
 5 files changed, 25 insertions(+), 6 deletions(-)
 create mode 100644 configs/meson/emscripten.txt

diff --git a/configs/meson/emscripten.txt b/configs/meson/emscripten.txt
new file mode 100644
index 0000000000..054b263814
--- /dev/null
+++ b/configs/meson/emscripten.txt
@@ -0,0 +1,6 @@
+[built-in options]
+c_args = ['-Wno-unused-command-line-argument','-g','-O3','-pthread']
+cpp_args = ['-Wno-unused-command-line-argument','-g','-O3','-pthread']
+objc_args = ['-Wno-unused-command-line-argument','-g','-O3','-pthread']
+c_link_args = ['-Wno-unused-command-line-argument','-g','-O3','-pthread','-sASYNCIFY=1','-sPROXY_TO_PTHREAD=1','-sFORCE_FILESYSTEM','-sALLOW_TABLE_GROWTH','-sTOTAL_MEMORY=2GB','-sWASM_BIGINT','-sEXPORT_ES6=1','-sASYNCIFY_IMPORTS=ffi_call_js','-sEXPORTED_RUNTIME_METHODS=addFunction,removeFunction,TTY,FS']
+cpp_link_args = ['-Wno-unused-command-line-argument','-g','-O3','-pthread','-sASYNCIFY=1','-sPROXY_TO_PTHREAD=1','-sFORCE_FILESYSTEM','-sALLOW_TABLE_GROWTH','-sTOTAL_MEMORY=2GB','-sWASM_BIGINT','-sEXPORT_ES6=1','-sASYNCIFY_IMPORTS=ffi_call_js','-sEXPORTED_RUNTIME_METHODS=addFunction,removeFunction,TTY,FS']
diff --git a/configure b/configure
index 02f1dd2311..a1fe6e11cd 100755
--- a/configure
+++ b/configure
@@ -360,6 +360,10 @@ elif check_define __NetBSD__; then
   host_os=netbsd
 elif check_define __APPLE__; then
   host_os=darwin
+elif check_define EMSCRIPTEN ; then
+  host_os=emscripten
+  cpu=wasm32
+  cross_compile="yes"
 else
   # This is a fatal error, but don't report it yet, because we
   # might be going to just print the --help text, or it might
@@ -526,6 +530,9 @@ case "$cpu" in
     linux_arch=x86
     CPU_CFLAGS="-m64"
     ;;
+  wasm32)
+    CPU_CFLAGS="-m32"
+    ;;
 esac
 
 if test -n "$host_arch" && {
diff --git a/meson.build b/meson.build
index 41f68d3806..bcf1e33ddf 100644
--- a/meson.build
+++ b/meson.build
@@ -50,9 +50,9 @@ genh = []
 qapi_trace_events = []
 
 bsd_oses = ['gnu/kfreebsd', 'freebsd', 'netbsd', 'openbsd', 'dragonfly', 'darwin']
-supported_oses = ['windows', 'freebsd', 'netbsd', 'openbsd', 'darwin', 'sunos', 'linux']
+supported_oses = ['windows', 'freebsd', 'netbsd', 'openbsd', 'darwin', 'sunos', 'linux', 'emscripten']
 supported_cpus = ['ppc', 'ppc64', 's390x', 'riscv32', 'riscv64', 'x86', 'x86_64',
-  'arm', 'aarch64', 'loongarch64', 'mips', 'mips64', 'sparc64']
+  'arm', 'aarch64', 'loongarch64', 'mips', 'mips64', 'sparc64', 'wasm32']
 
 cpu = host_machine.cpu_family()
 
@@ -353,6 +353,8 @@ foreach lang : all_languages
       # endif
       #endif''')
     # ok
+  elif compiler.get_id() == 'emscripten'
+    # ok
   else
     error('You either need GCC v7.4 or Clang v10.0 (or XCode Clang v15.0) to compile QEMU')
   endif
@@ -514,6 +516,8 @@ ucontext_probe = '''
 supported_backends = []
 if host_os == 'windows'
   supported_backends += ['windows']
+elif host_os == 'emscripten'
+  supported_backends += ['fiber']
 else
   if host_os != 'darwin' and cc.links(ucontext_probe)
     supported_backends += ['ucontext']
@@ -2962,7 +2966,7 @@ config_host_data.set('CONFIG_ATOMIC64', cc.links('''
     return 0;
   }''', args: qemu_isa_flags))
 
-has_int128_type = cc.compiles('''
+has_int128_type = host_os != 'emscripten' and cc.compiles('''
   __int128_t a;
   __uint128_t b;
   int main(void) { b = a; }''')
@@ -4456,7 +4460,9 @@ subdir('scripts')
 subdir('tools')
 subdir('pc-bios')
 subdir('docs')
-subdir('tests')
+if host_os != 'emscripten'
+  subdir('tests')
+endif
 if gtk.found()
   subdir('po')
 endif
diff --git a/meson_options.txt b/meson_options.txt
index 59d973bca0..6d73aafe91 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -34,7 +34,7 @@ option('fuzzing_engine', type : 'string', value : '',
 option('trace_file', type: 'string', value: 'trace',
        description: 'Trace file prefix for simple backend')
 option('coroutine_backend', type: 'combo',
-       choices: ['ucontext', 'sigaltstack', 'windows', 'auto'],
+       choices: ['ucontext', 'sigaltstack', 'windows', 'auto', 'fiber'],
        value: 'auto', description: 'coroutine backend to use')
 
 # Everything else can be set via --enable/--disable-* option
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index 3e8e00852b..cbba2f248c 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -80,7 +80,7 @@ meson_options_help() {
   printf "%s\n" '  --tls-priority=VALUE     Default TLS protocol/cipher priority string'
   printf "%s\n" '                           [NORMAL]'
   printf "%s\n" '  --with-coroutine=CHOICE  coroutine backend to use (choices:'
-  printf "%s\n" '                           auto/sigaltstack/ucontext/windows)'
+  printf "%s\n" '                           auto/fiber/sigaltstack/ucontext/windows)'
   printf "%s\n" '  --with-pkgversion=VALUE  use specified string as sub-version of the'
   printf "%s\n" '                           package'
   printf "%s\n" '  --with-suffix=VALUE      Suffix for QEMU data/modules/config directories'
-- 
2.25.1


