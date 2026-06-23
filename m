Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42B48CDB46F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 15:47:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wc3LF-0002cZ-Td; Tue, 23 Jun 2026 11:47:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3dqo6agwKCg82pqxwt78tup2v33v0t.r315t19-stAt0232v29.36v@flex--nabihestefan.bounces.google.com>)
 id 1wc3LB-0002cF-CU
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 11:47:10 -0400
Received: from mail-dy1-x134a.google.com ([2607:f8b0:4864:20::134a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3dqo6agwKCg82pqxwt78tup2v33v0t.r315t19-stAt0232v29.36v@flex--nabihestefan.bounces.google.com>)
 id 1wc3L8-0001sJ-M5
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 11:47:09 -0400
Received: by mail-dy1-x134a.google.com with SMTP id
 5a478bee46e88-30c5b9f6a51so449397eec.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 08:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1782229623; x=1782834423; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=8E4nNUsqa1KuMpRI2VNBAm9t5gxkCY6C1HE+EDwknjg=;
 b=sha0tyP8iH81S4u9fB6bERIqVNt+BzGfe+7d9yUdJqgomZscVSOA8idQdzj9AqoTcG
 7JnfXgmI1lm7azbWS6YUe6mzJSeHXtS13z7ZW35PeIZRsc71C4IQWJ6PNnSuh4ew8lfU
 lkYwFoot7rRPvAYaBSAq3VR6Zx4zN1EDFNpnN0QB+yFfidvN23LYNSB25NiL5juN0hFg
 QcFD6eLxXhAIzTHHrGnljOt5RkuyiNRAybeEw8+A1lMh241n5AIingkxhxOWBUOv75v9
 aXtcuOvJ6AwGrS9iqD7oyw3TiXEFuGRrDIECUFhETDMnFZy6wFUi4ALlVCH/w45RimAJ
 +pUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782229623; x=1782834423;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8E4nNUsqa1KuMpRI2VNBAm9t5gxkCY6C1HE+EDwknjg=;
 b=Lx7wKF31jXod/E0dEJehp2rcQ1M56S9ZoNhEOp62bpXOzl7eOb9mg8QOZu87Jsdm8h
 d/po+4hknyMQm9kFBMy8m9vNLJiF1X3ZjAyTjjqeHreW0UjZGt+bcI7Lj0QbgYwXQIAU
 6zYQGKetu62qg5g/PPkWidLBTPh3UEUpnLSX+zmxDeEyuj9tx/Jjui9CrU7rcitnjVCE
 tn1APccXrpt4BUn/AEgYWmusGDRVXmgwE5S9uifhlUQeHBAtmr0SatMoqsep/gb8weYL
 uI0euS3zAUjeWSPOXDi6QgvXWwBC3AfR5DhtRwLac5v4KxZfed2bvQfO9uBw810jWX/z
 C/Uw==
X-Forwarded-Encrypted: i=1;
 AFNElJ98FrAXyz7FhCGL99fUwJXaCEG6ha3L7J2Hu/94GaWwU77zfLxxQArbAD7iqYnF/GKRDre6DD1HUo8m@nongnu.org
X-Gm-Message-State: AOJu0YzazrplcIYH+NL1UtdIe7JWYofizobEbU8ut9ZikKy5pL5CpGvy
 9oPwh92XWZIKvPipKeyD4Wgmv1krbBx8RfX9s5UA33fiBb/vQiJsmNHDjIOzwhXc3ls2Ry7UjXI
 fAuaITrS/ljnNS920U9sJqFgG+rhLyw==
X-Received: from dyhd2.prod.google.com ([2002:a05:7300:8282:b0:30c:6672:4fc1])
 (user=nabihestefan job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7301:2202:b0:30b:f376:76e9 with SMTP id
 5a478bee46e88-30c556420a4mr2305773eec.17.1782229622810; 
 Tue, 23 Jun 2026 08:47:02 -0700 (PDT)
Date: Tue, 23 Jun 2026 15:46:59 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.786.g65d90a0328-goog
Message-ID: <20260623154659.3137518-1-nabihestefan@google.com>
Subject: [PATCH] build: Use meson b_sanitize option for sanitizers
From: Nabih Estefan <nabihestefan@google.com>
To: pbonzini@redhat.com
Cc: alex.bennee@linaro.org, laurent@vivier.eu, deller@gmx.de, 
 pierrick.bouvier@oss.qualcomm.com, marcandre.lureau@redhat.com, 
 berrange@redhat.com, philmd@mailo.com, zhao1.liu@intel.com, 
 qemu-devel@nongnu.org, Nabih Estefan <nabihestefan@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::134a;
 envelope-from=3dqo6agwKCg82pqxwt78tup2v33v0t.r315t19-stAt0232v29.36v@flex--nabihestefan.bounces.google.com;
 helo=mail-dy1-x134a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

Refactor sanitizer configuration to use Meson's built-in `b_sanitize`
option instead of manually adding flags to `qemu_cflags` and `qemu_ldflags`.
This ensures that sanitizer flags are correctly passed to both C and Rust
targets, fixing linker errors when Rust and UBSan are both enabled.

Explicitly parse `--enable-ubsan`, `--enable-asan`, and `--enable-tsan`
in `configure` and map them to `-Db_sanitize` meson option. Remove
redundant custom options from `meson_options.txt`.

How to test:
`./configure --target-list=aarch64-softmmu --enable-ubsan --enable-rust
 && make -j all`

Before this change it will fail at the end of make, since the linker will have
different flags, after this change it will link properly

Signed-off-by: Nabih Estefan <nabihestefan@google.com>
---
 configure                           | 35 ++++++++++++++++++
 linux-user/meson.build              |  6 +++-
 meson.build                         | 55 +++++++++++++----------------
 meson_options.txt                   |  7 +---
 scripts/meson-buildoptions.sh       |  9 -----
 tests/functional/x86_64/meson.build |  2 +-
 tests/unit/meson.build              |  2 +-
 7 files changed, 67 insertions(+), 49 deletions(-)

diff --git a/configure b/configure
index d8bc10060e..579df2f2c8 100755
--- a/configure
+++ b/configure
@@ -281,6 +281,9 @@ cfi="false"
 # which requires knowing whether --static is enabled.
 pie=""
 static="no"
+ubsan="false"
+asan="false"
+tsan="false"
 
 # Preferred compiler:
 #  ${CC} (if set)
@@ -746,6 +749,18 @@ for opt do
   ;;
   --wasm64-32bit-address-limit)
   ;;
+  --enable-ubsan) ubsan="true"
+  ;;
+  --disable-ubsan) ubsan="false"
+  ;;
+  --enable-asan) asan="true"
+  ;;
+  --disable-asan) asan="false"
+  ;;
+  --enable-tsan) tsan="true"
+  ;;
+  --disable-tsan) tsan="false"
+  ;;
   # everything else has the same name in configure and meson
   --*) meson_option_parse "$opt" "$optarg"
   ;;
@@ -1939,6 +1954,26 @@ if test "$skip_meson" = no; then
 
   # QEMU options
   test "$rust" != "disabled" && meson_option_add "-Drust=$rust"
+
+  # Translate asan/ubsan/tsan to b_sanitize
+  sanitizers=""
+  if test "$ubsan" = "true" && test "$asan" = "true"; then
+    sanitizers="undefined,address"
+  elif test "$ubsan" = "true"; then
+    sanitizers="undefined"
+  elif test "$asan" = "true"; then
+    sanitizers="address"
+  fi
+  if test "$tsan" = "true"; then
+    if test -n "$sanitizers"; then
+      error_exit "TSAN is not supported with other sanitizers"
+    fi
+    sanitizers="thread"
+  fi
+  if test -n "$sanitizers"; then
+    meson_option_add "-Db_sanitize=$sanitizers"
+  fi
+
   test "$cfi" != false && meson_option_add "-Dcfi=$cfi" "-Db_lto=$cfi"
   test "$docs" != auto && meson_option_add "-Ddocs=$docs"
   test -n "${LIB_FUZZING_ENGINE+xxx}" && meson_option_add "-Dfuzzing_engine=$LIB_FUZZING_ENGINE"
diff --git a/linux-user/meson.build b/linux-user/meson.build
index 332847a621..d48887efb6 100644
--- a/linux-user/meson.build
+++ b/linux-user/meson.build
@@ -34,8 +34,12 @@ endif
 
 syscall_nr_generators = {}
 
+# gen-vdso doesn't play well with sanitizers. It originally didn't get them due
+# to the way we passed sanitizer flags. Now that they're being passed through
+# meson wen need to override it.
 gen_vdso_exe = executable('gen-vdso', 'gen-vdso.c',
-                          native: true, build_by_default: false)
+                          native: true, build_by_default: false,
+                          override_options: ['b_sanitize=none'])
 gen_vdso = generator(gen_vdso_exe, output: '@BASENAME@.c.inc',
                      arguments: ['-o', '@OUTPUT@', '@EXTRA_ARGS@', '@INPUT@'])
 
diff --git a/meson.build b/meson.build
index e026851309..417c27002c 100644
--- a/meson.build
+++ b/meson.build
@@ -541,43 +541,35 @@ if get_option('safe_stack') and coroutine_backend != 'ucontext'
   error('SafeStack is only supported with the ucontext coroutine backend')
 endif
 
-if get_option('asan')
-  if cc.has_argument('-fsanitize=address')
-    qemu_cflags = ['-fsanitize=address'] + qemu_cflags
-    qemu_ldflags = ['-fsanitize=address'] + qemu_ldflags
-  else
-    error('Your compiler does not support -fsanitize=address')
-  endif
+sanitize = get_option('b_sanitize')
+
+if sanitize.contains('address')
+  # Meson handles -fsanitize=address automatically
 endif
 
-if get_option('ubsan')
+if sanitize.contains('undefined')
   # Detect static linking issue with ubsan:
   # https://gcc.gnu.org/bugzilla/show_bug.cgi?id=84285
-  if cc.links('int main(int argc, char **argv) { return argc + 1; }',
-              args: [qemu_ldflags, '-fsanitize=undefined'])
-    qemu_cflags += ['-fsanitize=undefined']
-    qemu_ldflags += ['-fsanitize=undefined']
-
-    # Suppress undefined behaviour from function call to mismatched type.
-    # In addition, tcg prologue does not emit function type prefix
-    # required by function call sanitizer.
-    if cc.has_argument('-fno-sanitize=function')
-      qemu_cflags += ['-fno-sanitize=function']
-    endif
-  else
+  if not cc.links('int main(int argc, char **argv) { return argc + 1; }',
+                  args: [qemu_ldflags, '-fsanitize=undefined'])
     error('Your compiler does not support -fsanitize=undefined')
   endif
+
+  # Suppress undefined behaviour from function call to mismatched type.
+  # In addition, tcg prologue does not emit function type prefix
+  # required by function call sanitizer.
+  if cc.has_argument('-fno-sanitize=function')
+    qemu_cflags += ['-fno-sanitize=function']
+  endif
 endif
 
-# Thread sanitizer is, for now, much noisier than the other sanitizers;
-# keep it separate until that is not the case.
-if get_option('tsan')
-  if get_option('asan') or get_option('ubsan')
+if sanitize.contains('thread')
+  if sanitize.contains('address') or sanitize.contains('undefined')
     error('TSAN is not supported with other sanitizers')
   endif
   if not cc.has_function('__tsan_create_fiber',
-                         args: '-fsanitize=thread',
-                         prefix: '#include <sanitizer/tsan_interface.h>')
+                          args: '-fsanitize=thread',
+                          prefix: '#include <sanitizer/tsan_interface.h>')
     error('Cannot enable TSAN due to missing fiber annotation interface')
   endif
   tsan_warn_suppress = []
@@ -588,8 +580,7 @@ if get_option('tsan')
   if cc.has_argument('-Wno-tsan')
     tsan_warn_suppress = ['-Wno-tsan']
   endif
-  qemu_cflags = ['-fsanitize=thread'] + tsan_warn_suppress + qemu_cflags
-  qemu_ldflags = ['-fsanitize=thread'] + qemu_ldflags
+  qemu_cflags += tsan_warn_suppress
 endif
 
 # Detect support for PT_GNU_RELRO + DT_BIND_NOW.
@@ -2482,7 +2473,7 @@ if have_tcg
   config_host_data.set('CONFIG_TCG_INTERPRETER', tcg_arch == 'tci')
 endif
 config_host_data.set('CONFIG_TPM', have_tpm)
-config_host_data.set('CONFIG_TSAN', get_option('tsan'))
+config_host_data.set('CONFIG_TSAN', sanitize.contains('thread'))
 config_host_data.set('CONFIG_USB_LIBUSB', libusb.found())
 config_host_data.set('CONFIG_VDE', vde.found())
 config_host_data.set('CONFIG_VHOST', have_vhost)
@@ -2639,7 +2630,7 @@ if rdma.found()
 endif
 
 have_asan_fiber = false
-if get_option('asan') and \
+if sanitize.contains('address') and \
    not cc.has_function('__sanitizer_start_switch_fiber',
                          args: '-fsanitize=address',
                          prefix: '#include <sanitizer/asan_interface.h>')
@@ -4768,7 +4759,9 @@ summary_info += {'memory allocator':  get_option('malloc')}
 summary_info += {'avx2 optimization': config_host_data.get('CONFIG_AVX2_OPT')}
 summary_info += {'avx512bw optimization': config_host_data.get('CONFIG_AVX512BW_OPT')}
 summary_info += {'gcov':              get_option('b_coverage')}
-summary_info += {'thread sanitizer':  get_option('tsan')}
+summary_info += {'address sanitizer': sanitize.contains('address')}
+summary_info += {'undefined behavior sanitizer': sanitize.contains('undefined')}
+summary_info += {'thread sanitizer':  sanitize.contains('thread')}
 summary_info += {'CFI support':       get_option('cfi')}
 if get_option('cfi')
   summary_info += {'CFI debug support': get_option('cfi_debug')}
diff --git a/meson_options.txt b/meson_options.txt
index a07cb47d35..d61c0241cc 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -99,12 +99,7 @@ option('tcg_interpreter', type: 'boolean', value: false,
        description: 'TCG with bytecode interpreter (slow)')
 option('safe_stack', type: 'boolean', value: false,
        description: 'SafeStack Stack Smash Protection (requires clang/llvm and coroutine backend ucontext)')
-option('asan', type: 'boolean', value: false,
-       description: 'enable address sanitizer')
-option('ubsan', type: 'boolean', value: false,
-       description: 'enable undefined behaviour sanitizer')
-option('tsan', type: 'boolean', value: false,
-       description: 'enable thread sanitizer')
+
 option('stack_protector', type: 'feature', value: 'auto',
        description: 'compiler-provided stack protection')
 option('cfi', type: 'boolean', value: false,
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index c003985047..8d3b992ed7 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -21,7 +21,6 @@ meson_options_help() {
   printf "%s\n" '  --disable-relocatable    toggle relocatable install'
   printf "%s\n" '  --docdir=VALUE           Base directory for documentation installation'
   printf "%s\n" '                           (can be empty) [share/doc]'
-  printf "%s\n" '  --enable-asan            enable address sanitizer'
   printf "%s\n" '  --enable-block-drv-whitelist-in-tools'
   printf "%s\n" '                           use block whitelist also in tools instead of only'
   printf "%s\n" '                           QEMU'
@@ -54,8 +53,6 @@ meson_options_help() {
   printf "%s\n" '  --enable-trace-backends=CHOICES'
   printf "%s\n" '                           Set available tracing backends [log] (choices:'
   printf "%s\n" '                           dtrace/ftrace/log/nop/simple/syslog/ust)'
-  printf "%s\n" '  --enable-tsan            enable thread sanitizer'
-  printf "%s\n" '  --enable-ubsan           enable undefined behaviour sanitizer'
   printf "%s\n" '  --firmwarepath=VALUES    search PATH for firmware files [share/qemu-'
   printf "%s\n" '                           firmware]'
   printf "%s\n" '  --iasl=VALUE             Path to ACPI disassembler'
@@ -238,8 +235,6 @@ _meson_option_parse() {
     --disable-af-xdp) printf "%s" -Daf_xdp=disabled ;;
     --enable-alsa) printf "%s" -Dalsa=enabled ;;
     --disable-alsa) printf "%s" -Dalsa=disabled ;;
-    --enable-asan) printf "%s" -Dasan=true ;;
-    --disable-asan) printf "%s" -Dasan=false ;;
     --enable-attr) printf "%s" -Dattr=enabled ;;
     --disable-attr) printf "%s" -Dattr=disabled ;;
     --audio-drv-list=*) quote_sh "-Daudio_drv_list=$2" ;;
@@ -521,14 +516,10 @@ _meson_option_parse() {
     --disable-tpm) printf "%s" -Dtpm=disabled ;;
     --enable-trace-backends=*) quote_sh "-Dtrace_backends=$2" ;;
     --with-trace-file=*) quote_sh "-Dtrace_file=$2" ;;
-    --enable-tsan) printf "%s" -Dtsan=true ;;
-    --disable-tsan) printf "%s" -Dtsan=false ;;
     --enable-u2f) printf "%s" -Du2f=enabled ;;
     --disable-u2f) printf "%s" -Du2f=disabled ;;
     --enable-uadk) printf "%s" -Duadk=enabled ;;
     --disable-uadk) printf "%s" -Duadk=disabled ;;
-    --enable-ubsan) printf "%s" -Dubsan=true ;;
-    --disable-ubsan) printf "%s" -Dubsan=false ;;
     --enable-usb-redir) printf "%s" -Dusb_redir=enabled ;;
     --disable-usb-redir) printf "%s" -Dusb_redir=disabled ;;
     --enable-valgrind) printf "%s" -Dvalgrind=enabled ;;
diff --git a/tests/functional/x86_64/meson.build b/tests/functional/x86_64/meson.build
index 1ed10ad6c2..54af748f15 100644
--- a/tests/functional/x86_64/meson.build
+++ b/tests/functional/x86_64/meson.build
@@ -24,7 +24,7 @@ tests_x86_64_system_quick = [
 # interacts badly with the sanitizer; this means the memlock
 # test (which checks via /proc for whether pages were locked)
 # will always fail on a sanitizer build, so don't run it.
-if not get_option('asan')
+if not sanitize.contains('address')
   tests_x86_64_system_quick += [ 'memlock' ]
 endif
 
diff --git a/tests/unit/meson.build b/tests/unit/meson.build
index 01cc540a45..b0ba64d0ec 100644
--- a/tests/unit/meson.build
+++ b/tests/unit/meson.build
@@ -147,7 +147,7 @@ if have_system
   # Some tests: test-char, test-qdev-global-props, and test-qga,
   # are not runnable under TSan due to a known issue.
   # https://github.com/google/sanitizers/issues/1116
-  if not get_option('tsan')
+  if not sanitize.contains('thread')
     if host_os != 'windows'
         tests += {
           'test-char': ['socket-helpers.c', qom, io, chardev]
-- 
2.55.0.rc0.786.g65d90a0328-goog


