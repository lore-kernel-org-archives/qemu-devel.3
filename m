Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3FDCC3ABBC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 15:34:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCKFv-0005Fm-Lw; Tue, 06 May 2025 11:30:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uCKFh-0004Xk-GW
 for qemu-devel@nongnu.org; Tue, 06 May 2025 11:30:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uCKFe-0002Fg-5g
 for qemu-devel@nongnu.org; Tue, 06 May 2025 11:30:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746545433;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8ct+iZ6ldjipZB0WBqqo1Lr+PnrNl25dJilmjNEGR3A=;
 b=VI0mcoVikd1yxKKAPFC/mF77jFwogGY4mGrdY+dVhC6EWux1czYiSDC4MMWDOMrR9P5sMe
 /a32L139lL45cjyWZG7t4NgeBmzxIz/3+pymNRxdujhjooNhtLorEx6sO8uuesuoIC0KP6
 az+NkKmPcaQYQTqCT8T6/ytUElW3ySU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-63dK4VWYPsifTLTw2PeSqw-1; Tue, 06 May 2025 11:30:31 -0400
X-MC-Unique: 63dK4VWYPsifTLTw2PeSqw-1
X-Mimecast-MFC-AGG-ID: 63dK4VWYPsifTLTw2PeSqw_1746545430
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a0b1f6815dso289903f8f.3
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 08:30:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746545429; x=1747150229;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8ct+iZ6ldjipZB0WBqqo1Lr+PnrNl25dJilmjNEGR3A=;
 b=N8AMVBmuwldtioMbauA3N4PGXw/Yi3Z+1q5usE7V24c/R5LEa+y5H8dWzsTVZ8bTac
 Igy3ToYBTxLo+Jp666+8x62ueAtfVfRnYzrG8hDLmy4vLgmle/RMyiMGEz8mnBGDSrgX
 Skv6b3fr5ZNI+7EcL07gQ++3FExENA5PT3QtlNH1CUq/j5Fug6zkF0lZGnwxz0dbfR8D
 6EY6J0Py4MqMGXZaG0on2PN51orgdPJVnnADyRLRKSqgRXiyRzBaTZ1KqYBOrzs90hK/
 fzfKgLmtXTRF3tteTO17ls5d6MWGqTy51xKvxVmKNz83Ds93bxwa1qafWJPuctINmGYr
 GJgw==
X-Gm-Message-State: AOJu0Yy+J0u8rH/1V3bfXELdX/PJ38tTjmrxfxonJFtqsFZS9swSEF4m
 xyOieynhzfzfbv7nV1iO/m9q1pSk/z4CE9rMLQUJzHAuOprQM2Dqq92DJW9yMcNxWL5f1ShNSDr
 Uj6qkiNFpRKErTRPevyFWn8SZ2qvuDkx95+spRKnscHv0brEqXny/cbnJHNgpqBABcDDEUMU73r
 cbjr2T1i8exkg1YTxvum55CHHipHWFUqxzcn01
X-Gm-Gg: ASbGncvP3BZoSp+XOGB5NAqXvLYtNdo8Z63GAR7g7W21Sre/24NywU2Of/51Z8J/Bjn
 Q2qfmV+bWI71tHzzyxn8NwxhmMn0Et+eQjwOvyF9GwIp8CgJ+YA1B0CMKnIl3PuAhJeZvo0sjvz
 WtEEavKtknTEyVwh89VVKnDA8UOyJD6tzLdkXxEWvT5pkEE3kKzLpHI5PbUJIBIDPJoREDpEFuN
 ruH7WRNqcNxVWfbUqhouJ0PGKgaE8lruW8JESTurwXxeAtxXopPAzqH4kv5H9w/3QfT2OUDrJf9
 I2tRhuuYz1xuvOc=
X-Received: by 2002:a05:6000:2503:b0:39e:e557:7d9 with SMTP id
 ffacd0b85a97d-3a0ac0c9ab1mr2843126f8f.5.1746545429626; 
 Tue, 06 May 2025 08:30:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhYWTMHa4seAly1Yha10/WayXMhlVshsRbn/GwKUjQodTBinfh9UqeCqVZt0TH+ZLpjMjtLA==
X-Received: by 2002:a05:6000:2503:b0:39e:e557:7d9 with SMTP id
 ffacd0b85a97d-3a0ac0c9ab1mr2843090f8f.5.1746545429055; 
 Tue, 06 May 2025 08:30:29 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.54.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b8a286c4sm171483035e9.25.2025.05.06.08.30.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 May 2025 08:30:26 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Subject: [PULL 28/30] meson: Add wasm build in build scripts
Date: Tue,  6 May 2025 17:29:23 +0200
Message-ID: <20250506152927.222671-29-pbonzini@redhat.com>
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

has_int128_type is set to false on emscripten as of now to avoid errors by
libffi. Tests are disabled on emscripten because they rely on host
features that aren't supported by emscripten (e.g. fork and unix
socket).

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Link: https://lore.kernel.org/r/ad03b3b180335f59e785e930968077bf15c46260.1745820062.git.ktokunaga.mail@gmail.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 MAINTAINERS                   |  1 +
 configure                     |  7 +++++++
 meson.build                   | 29 ++++++++++++++++++++++++-----
 configs/meson/emscripten.txt  |  8 ++++++++
 meson_options.txt             |  2 +-
 scripts/meson-buildoptions.sh |  2 +-
 6 files changed, 42 insertions(+), 7 deletions(-)
 create mode 100644 configs/meson/emscripten.txt

diff --git a/MAINTAINERS b/MAINTAINERS
index 55c47fcd378..02b75ea9e10 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -634,6 +634,7 @@ S: Maintained
 F: include/system/os-wasm.h
 F: os-wasm.c
 F: util/coroutine-wasm.c
+F: configs/meson/emscripten.txt
 
 Alpha Machines
 --------------
diff --git a/configure b/configure
index 40705afdf57..2ce8d29fac2 100755
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
index 8eb3de5d68d..27f11501528 100644
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
@@ -470,7 +472,10 @@ endif
 # instead, we can't add -no-pie because it overrides -shared: the linker then
 # tries to build an executable instead of a shared library and fails.  So
 # don't add -no-pie anywhere and cross fingers. :(
-if not get_option('b_pie')
+#
+# Emscripten doesn't support -no-pie but meson can't catch the compiler
+# warning. So explicitly omit the flag for Emscripten.
+if not get_option('b_pie') and host_os != 'emscripten'
   qemu_common_flags += cc.get_supported_arguments('-fno-pie', '-no-pie')
 endif
 
@@ -514,6 +519,8 @@ ucontext_probe = '''
 supported_backends = []
 if host_os == 'windows'
   supported_backends += ['windows']
+elif host_os == 'emscripten'
+  supported_backends += ['wasm']
 else
   if host_os != 'darwin' and cc.links(ucontext_probe)
     supported_backends += ['ucontext']
@@ -902,6 +909,10 @@ if get_option('tcg').allowed()
     if not get_option('tcg_interpreter')
       error('Unsupported CPU @0@, try --enable-tcg-interpreter'.format(cpu))
     endif
+  elif host_arch == 'wasm32'
+    if not get_option('tcg_interpreter')
+      error('WebAssembly host requires --enable-tcg-interpreter')
+    endif
   elif get_option('tcg_interpreter')
     warning('Use of the TCG interpreter is not recommended on this host')
     warning('architecture. There is a native TCG execution backend available')
@@ -2962,7 +2973,9 @@ config_host_data.set('CONFIG_ATOMIC64', cc.links('''
     return 0;
   }''', args: qemu_isa_flags))
 
-has_int128_type = cc.compiles('''
+# has_int128_type is set to false on Emscripten to avoid errors by libffi
+# during runtime.
+has_int128_type = host_os != 'emscripten' and cc.compiles('''
   __int128_t a;
   __uint128_t b;
   int main(void) { b = a; }''')
@@ -3775,6 +3788,8 @@ if have_block
   # os-win32.c does not
   if host_os == 'windows'
     system_ss.add(files('os-win32.c'))
+  elif host_os == 'emscripten'
+    blockdev_ss.add(files('os-wasm.c'))
   else
     blockdev_ss.add(files('os-posix.c'))
   endif
@@ -4516,7 +4531,11 @@ subdir('scripts')
 subdir('tools')
 subdir('pc-bios')
 subdir('docs')
-subdir('tests')
+# Tests are disabled on emscripten because they rely on host features that aren't
+# supported by emscripten (e.g. fork and unix socket).
+if host_os != 'emscripten'
+  subdir('tests')
+endif
 if gtk.found()
   subdir('po')
 endif
diff --git a/configs/meson/emscripten.txt b/configs/meson/emscripten.txt
new file mode 100644
index 00000000000..4230e88005f
--- /dev/null
+++ b/configs/meson/emscripten.txt
@@ -0,0 +1,8 @@
+[built-in options]
+c_args = ['-pthread']
+cpp_args = ['-pthread']
+objc_args = ['-pthread']
+# -sPROXY_TO_PTHREAD link time flag always requires -pthread even during
+# configuration so explicitly add the flag here.
+c_link_args = ['-pthread','-sASYNCIFY=1','-sPROXY_TO_PTHREAD=1','-sFORCE_FILESYSTEM','-sALLOW_TABLE_GROWTH','-sTOTAL_MEMORY=2GB','-sWASM_BIGINT','-sEXPORT_ES6=1','-sASYNCIFY_IMPORTS=ffi_call_js','-sEXPORTED_RUNTIME_METHODS=addFunction,removeFunction,TTY,FS']
+cpp_link_args = ['-pthread','-sASYNCIFY=1','-sPROXY_TO_PTHREAD=1','-sFORCE_FILESYSTEM','-sALLOW_TABLE_GROWTH','-sTOTAL_MEMORY=2GB','-sWASM_BIGINT','-sEXPORT_ES6=1','-sASYNCIFY_IMPORTS=ffi_call_js','-sEXPORTED_RUNTIME_METHODS=addFunction,removeFunction,TTY,FS']
diff --git a/meson_options.txt b/meson_options.txt
index 0b4115e733a..cc66b46c636 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -34,7 +34,7 @@ option('fuzzing_engine', type : 'string', value : '',
 option('trace_file', type: 'string', value: 'trace',
        description: 'Trace file prefix for simple backend')
 option('coroutine_backend', type: 'combo',
-       choices: ['ucontext', 'sigaltstack', 'windows', 'auto'],
+       choices: ['ucontext', 'sigaltstack', 'windows', 'wasm', 'auto'],
        value: 'auto', description: 'coroutine backend to use')
 
 # Everything else can be set via --enable/--disable-* option
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index d76a239130a..8a67a14e2e2 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -80,7 +80,7 @@ meson_options_help() {
   printf "%s\n" '  --tls-priority=VALUE     Default TLS protocol/cipher priority string'
   printf "%s\n" '                           [NORMAL]'
   printf "%s\n" '  --with-coroutine=CHOICE  coroutine backend to use (choices:'
-  printf "%s\n" '                           auto/sigaltstack/ucontext/windows)'
+  printf "%s\n" '                           auto/sigaltstack/ucontext/windows/wasm)'
   printf "%s\n" '  --with-pkgversion=VALUE  use specified string as sub-version of the'
   printf "%s\n" '                           package'
   printf "%s\n" '  --with-suffix=VALUE      Suffix for QEMU data/modules/config directories'
-- 
2.49.0


