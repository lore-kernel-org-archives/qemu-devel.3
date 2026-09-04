Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFAF1C79F89
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 12:55:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2TQG-0001dS-Fz; Fri, 04 Sep 2026 08:53:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TQE-0001cD-OE
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 08:53:34 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TQC-0000g7-Bc
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 08:53:34 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-49b392ccaacso15290375e9.2
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 05:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788526411; x=1789131211; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=VZ56hUm46ZCsuRXrdJuTj9n6DQWjKkAlV/0A2Puo6Pg=;
 b=Nof3NlXFOfCKy0Kw177+cO2etV4LjrGywiXO5T4PkwAwxRd4kXEkQ46uvuYc6XiZ2r
 N4No7iaKC3aNSaod4uokF36j1qn5fhSqXiQMbI6UCqnwJEpCX0iVJeTEYQ/N32DUSxaR
 0qVC0GsglsHUjy3gFWnyO3EGnCG8+FWjsX6OzmExU6+TO/cnxpOpYOqGKXrQ/J7FeG5g
 FONHvWTL1dv974svy6hxhYOaZIDsi9li76S4q63JIzqMnh1y3Zq6KytxmbexafbO1oKA
 7eDAkNyLWWw0+jLVw8RVWUr7dQML3k266piYh6zPnBbUHXmnz3IIumi0krvbmkeVIE/U
 JZYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788526411; x=1789131211;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VZ56hUm46ZCsuRXrdJuTj9n6DQWjKkAlV/0A2Puo6Pg=;
 b=VUURtqqzSEfSZ44JHIHnZex2vnrzaPe4mkDbQDjh0OV0DFDfyuolQcLCtwc2oRYe13
 cxFxSEQQLYF56yLzEhFrgtjTMUswV3wcWpzKF4L4cV63ZFHzV2kt8wcUOQaunBU59aJs
 YFzbVI7/aHgP/4DemCh9WHUVKo5yRmnt1W9STXdrjwet1dOAb1qf+ttK+HNyF5Pg0cku
 3Bjqkvnk4XmLFPfzku1GgeZku38WEKpTK/sKLvYgh23InR4wtM/nyZqVd47ALwNwwHuI
 qKPfAWU2/k2dublfechrGSz/FWxLzEVVur2IHCxt6xyeYbMnFKoKkEtOWvhJl0USDrr0
 AMSg==
X-Gm-Message-State: AFuF++n6AhU4bnUqQU+vKG9IS+uVHe3kxj8sV10RAozbLY/FKCVfmrR0
 VmZRBLoi8AGMrJMjgwvsamMf269rTfNTm9dCBzC/HQFk1qDPOFpaIkcNAqiwgTBdwto=
X-Gm-Gg: AYBFou2AcAavlnWPKQUft2kZhW891ZWnj9uNinPdOJa0PYEcEQ5jB5lKH5FWuu10ONf
 m3VT0Aw2hdlqacCx32CsxEO91SN21PsKSTTT5ToR5ezix5cEB6L2HlF8PhPt6lBJgCZ4fc8orZ6
 2ExBusSa1YQE+iaVCe/muQWWs5sD4ySYuAR1+sazec2VsCrmCVSQhlJSOd2vvSCgjejt0527qub
 UZny+wAdsq/bMDBdoV5h5I4/hDEHAx0PkFeZ8erFlUen6StxsCXMKCTkxXKDt+xQ5/K2W6AlzSj
 Vw/F9tYVRmxBwfNbVOan/ZTrAIego947fOomaBfrRi3AT3Air2MtYX4L4MLRVQvWnE6S9hT6/Eh
 YnS8QrTAdiJhW1aI/Vwip9qbSFcBfcWgxeEd2JGWnUodrhmj4Mp5W0Rv8I4AW25eKk38zRtfxaf
 17F/ahOiqRDQNA+cdoTrqwHeQWEoK356B4DXxmFAZIOPEqtARiZCWmOAfbiQEo
X-Received: by 2002:a05:600c:1f87:b0:49b:47b3:d6d with SMTP id
 5b1f17b1804b1-49cf825c7e8mr51908535e9.10.1788526410758; 
 Fri, 04 Sep 2026 05:53:30 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee5d4938sm151913635e9.2.2026.09.04.05.53.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 05:53:26 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 26B1661E2D;
 Fri, 04 Sep 2026 13:46:15 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Aniket Sahu <asahu1x@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 101/105] tests/tcg/meson.build: implement ./configure
 -cross-cc-* options
Date: Fri,  4 Sep 2026 13:45:55 +0100
Message-ID: <20260904124604.2207440-102-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260904124604.2207440-1-alex.bennee@linaro.org>
References: <20260904124604.2207440-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

When a user set explicit cross cc, we ensure it's available and working.
When a user set explicit cross cflags, we ensure they work with default
or overriden cross_cc.

Made the first implementation with a single meson option (array), which
proved to be absolutely unreadable.
By having one option per target, we directly detect issue at configure
time, either for user, or when iterating on all our targets. This
ensures user can't mispell any target name, and that we can't forget any
new one in the future.
Also, it shows them in the configuration summary, which is a bonus.

Since we now only need to know compiler to write tcg tests, we can
simply alias -cross-prefix-* options to compiler override.

Examples
--------

wrong architecture:
$ ./configure --cross-cc-bad='cc'
../meson.build:1:0: ERROR: Unknown option: "tcg_tests_cross_cc_bad"

wrong option:
$ ./configure --cross-cc-cflags-aarch64='-bad-option'
../tests/tcg/meson.build:228:10: ERROR: Command `/usr/bin/aarch64-linux-gnu-gcc /home/pbouvier/.work/qemu/tests/tcg/test_cc.c -bad-option -static -nostdlib -r -o /dev/null` failed with status 1.
A full log can be found at /qemu/build/meson-logs/meson-log.txt

cross compile with clang (fails at the moment, since some tests have
compilation errors with it):
$ ./configure --target-list=aarch64-linux-user --cross-cc-aarch64='clang' --cross-cc-cflags-aarch64='-target aarch64-linux-gnu'
  User defined options
  ...
    tcg_tests_cross_cc_aarch64      : clang
    tcg_tests_cross_cflags_aarch64  : -target aarch64-linux-gnu

Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260827221506.91574-102-pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/configure b/configure
index aa98cf39584..1973f023b1e 100755
--- a/configure
+++ b/configure
@@ -227,19 +227,6 @@ for opt do
   ;;
   --extra-ldflags=*) EXTRA_LDFLAGS="$EXTRA_LDFLAGS $optarg"
   ;;
-  --cross-cc-*[!a-zA-Z0-9_-]*=*) error_exit "Passed bad --cross-cc-FOO option"
-  ;;
-  --cross-cc-cflags-*) cc_arch=${opt#--cross-cc-cflags-}; cc_arch=${cc_arch%%=*}
-                      eval "cross_cc_cflags_${cc_arch}=\$optarg"
-  ;;
-  --cross-cc-*) cc_arch=${opt#--cross-cc-}; cc_arch=${cc_arch%%=*}
-                eval "cross_cc_${cc_arch}=\$optarg"
-  ;;
-  --cross-prefix-*[!a-zA-Z0-9_-]*=*) error_exit "Passed bad --cross-prefix-FOO option"
-  ;;
-  --cross-prefix-*) cc_arch=${opt#--cross-prefix-}; cc_arch=${cc_arch%%=*}
-                    eval "cross_prefix_${cc_arch}=\$optarg"
-  ;;
   --without-default-features) default_feature="no"
   ;;
   --wasm64-32bit-address-limit) wasm64_memory64="2"
@@ -631,9 +618,19 @@ for opt do
   ;;
   --extra-ldflags=*)
   ;;
-  --cross-cc-*)
+  --cross-cc-*[!a-zA-Z0-9_-]*=*) error_exit "Passed bad --cross-cc-FOO option"
+  ;;
+  --cross-cc-cflags-*) arch=${opt#--cross-cc-cflags-}; arch=${arch%%=*}
+                       meson_option_add "-Dtcg_tests_cross_cflags_${arch}=${optarg}"
+  ;;
+  --cross-cc-*) arch=${opt#--cross-cc-}; arch=${arch%%=*}
+                meson_option_add "-Dtcg_tests_cross_cc_${arch}=${optarg}"
+  ;;
+  --cross-prefix-*[!a-zA-Z0-9_-]*=*) error_exit "Passed bad --cross-prefix-FOO option"
   ;;
-  --cross-prefix-*)
+  # cross-prefix is just used as a syntactic sugar for -cross-cc.
+  --cross-prefix-*) arch=${opt#--cross-prefix-}; arch=${arch%%=*}
+                    meson_option_add "-Dtcg_tests_cross_cc_${arch}=${optarg}gcc"
   ;;
   --enable-docs) docs=enabled
   ;;
diff --git a/meson_options.txt b/meson_options.txt
index f9604a6c192..292625af08a 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -391,3 +391,92 @@ option('containers', type: 'boolean', value: true,
        description: 'use containers to cross compile tcg tests')
 option('container_command', type: 'string',
        description: 'command to build/run containers')
+
+option('tcg_tests_cross_cc_aarch64', type: 'string',
+       description: 'cc for aarch64 tcg tests')
+option('tcg_tests_cross_cflags_aarch64', type: 'string',
+       description: 'cflags for aarch64 tcg tests')
+option('tcg_tests_cross_cc_aarch64_be', type: 'string',
+       description: 'cc for aarch64_be tcg tests')
+option('tcg_tests_cross_cflags_aarch64_be', type: 'string',
+       description: 'cflags for aarch64_be tcg tests')
+option('tcg_tests_cross_cc_alpha', type: 'string',
+       description: 'cc for alpha tcg tests')
+option('tcg_tests_cross_cflags_alpha', type: 'string',
+       description: 'cflags for alpha tcg tests')
+option('tcg_tests_cross_cc_arm', type: 'string',
+       description: 'cc for arm tcg tests')
+option('tcg_tests_cross_cflags_arm', type: 'string',
+       description: 'cflags for arm tcg tests')
+option('tcg_tests_cross_cc_hexagon', type: 'string',
+       description: 'cc for hexagon tcg tests')
+option('tcg_tests_cross_cflags_hexagon', type: 'string',
+       description: 'cflags for hexagon tcg tests')
+option('tcg_tests_cross_cc_hppa', type: 'string',
+       description: 'cc for hppa tcg tests')
+option('tcg_tests_cross_cflags_hppa', type: 'string',
+       description: 'cflags for hppa tcg tests')
+option('tcg_tests_cross_cc_i386', type: 'string',
+       description: 'cc for i386 tcg tests')
+option('tcg_tests_cross_cflags_i386', type: 'string',
+       description: 'cflags for i386 tcg tests')
+option('tcg_tests_cross_cc_loongarch64', type: 'string',
+       description: 'cc for loongarch64 tcg tests')
+option('tcg_tests_cross_cflags_loongarch64', type: 'string',
+       description: 'cflags for loongarch64 tcg tests')
+option('tcg_tests_cross_cc_m68k', type: 'string',
+       description: 'cc for m68k tcg tests')
+option('tcg_tests_cross_cflags_m68k', type: 'string',
+       description: 'cflags for m68k tcg tests')
+option('tcg_tests_cross_cc_mips', type: 'string',
+       description: 'cc for mips tcg tests')
+option('tcg_tests_cross_cflags_mips', type: 'string',
+       description: 'cflags for mips tcg tests')
+option('tcg_tests_cross_cc_mips64', type: 'string',
+       description: 'cc for mips64 tcg tests')
+option('tcg_tests_cross_cflags_mips64', type: 'string',
+       description: 'cflags for mips64 tcg tests')
+option('tcg_tests_cross_cc_mips64el', type: 'string',
+       description: 'cc for mips64el tcg tests')
+option('tcg_tests_cross_cflags_mips64el', type: 'string',
+       description: 'cflags for mips64el tcg tests')
+option('tcg_tests_cross_cc_or1k', type: 'string',
+       description: 'cc for or1k tcg tests')
+option('tcg_tests_cross_cflags_or1k', type: 'string',
+       description: 'cflags for or1k tcg tests')
+option('tcg_tests_cross_cc_ppc64', type: 'string',
+       description: 'cc for ppc64 tcg tests')
+option('tcg_tests_cross_cflags_ppc64', type: 'string',
+       description: 'cflags for ppc64 tcg tests')
+option('tcg_tests_cross_cc_ppc64le', type: 'string',
+       description: 'cc for ppc64le tcg tests')
+option('tcg_tests_cross_cflags_ppc64le', type: 'string',
+       description: 'cflags for ppc64le tcg tests')
+option('tcg_tests_cross_cc_riscv64', type: 'string',
+       description: 'cc for riscv64 tcg tests')
+option('tcg_tests_cross_cflags_riscv64', type: 'string',
+       description: 'cflags for riscv64 tcg tests')
+option('tcg_tests_cross_cc_s390x', type: 'string',
+       description: 'cc for s390x tcg tests')
+option('tcg_tests_cross_cflags_s390x', type: 'string',
+       description: 'cflags for s390x tcg tests')
+option('tcg_tests_cross_cc_sh4', type: 'string',
+       description: 'cc for sh4 tcg tests')
+option('tcg_tests_cross_cflags_sh4', type: 'string',
+       description: 'cflags for sh4 tcg tests')
+option('tcg_tests_cross_cc_tricore', type: 'string',
+       description: 'cc for tricore tcg tests')
+option('tcg_tests_cross_cflags_tricore', type: 'string',
+       description: 'cflags for tricore tcg tests')
+option('tcg_tests_cross_cc_x86_64', type: 'string',
+       description: 'cc for x86_64 tcg tests')
+option('tcg_tests_cross_cflags_x86_64', type: 'string',
+       description: 'cflags for x86_64 tcg tests')
+option('tcg_tests_cross_cc_xtensa', type: 'string',
+       description: 'cc for xtensa tcg tests')
+option('tcg_tests_cross_cflags_xtensa', type: 'string',
+       description: 'cflags for xtensa tcg tests')
+option('tcg_tests_cross_cc_xtensaeb', type: 'string',
+       description: 'cc for xtensaeb tcg tests')
+option('tcg_tests_cross_cflags_xtensaeb', type: 'string',
+       description: 'cflags for xtensaeb tcg tests')
diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 2458a231f5f..9cf632d2717 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -180,6 +180,8 @@ foreach target, plan: tcg_tests
     continue
   endif
 
+  cc_arch = target.replace('-linux-user', '').replace('-softmmu', '')
+
   # Detect duplicated executables/tests, and report an error to force user to
   # choose how to deal with it.
   built_tests = {}
@@ -197,16 +199,35 @@ foreach target, plan: tcg_tests
   endforeach
 
   cc = find_program(plan['cc'], required : false)
+  cc_cflags = []
+
+  check_flags = []
+  check_required = false
+  cross_cc = get_option('tcg_tests_cross_cc_' + cc_arch)
+  if cross_cc != ''
+    # we make sure cross cc exists
+    cc = find_program(cross_cc, required: true)
+    check_required = true
+  endif
+  cross_cflags = get_option('tcg_tests_cross_cflags_' + cc_arch)
+  if cross_cflags != ''
+    cc_cflags = cross_cflags.split()
+    # and that cross cc can compile programs
+    check_flags = cc_cflags
+    check_required = true
+  endif
+
   cc_from_system = cc.found()
   has_cc = cc.found()
   if has_cc
-    check_flags = ['-static']
     if target.endswith('softmmu')
-      check_flags = ['-nostdlib', '-ffreestanding', '-r']
+      check_flags += ['-nostdlib', '-ffreestanding', '-r']
+    else
+      check_flags += ['-static']
     endif
 
     cmd = run_command([cc, files('test_cc.c'), check_flags, '-o', '/dev/null'],
-                      check: false)
+                      check: check_required)
     has_cc = cmd.returncode() == 0
     cc_from_system = has_cc
   endif
@@ -333,9 +354,9 @@ foreach target, plan: tcg_tests
         endif
       endif
 
-      cflags = []
+      cflags = cc_cflags
       if 'cflags' in setup
-        cflags = setup['cflags']
+        cflags += setup['cflags']
       endif
 
       if 'cc_feat' in setup
-- 
2.47.3


