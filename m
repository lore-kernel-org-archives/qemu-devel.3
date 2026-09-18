Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5199FC982D8
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 14:25:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7ZW4-0005lM-TZ; Fri, 18 Sep 2026 10:24:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x7ZW2-0005kh-Fn
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 10:24:38 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x7ZW0-0007p0-9s
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 10:24:38 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49cd5462b69so4734485e9.1
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2026 07:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789741475; x=1790346275; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=50aCxFdjvgOonBzfwDq4lxvq9N8Gbe3Y6UNEwMKBtjw=;
 b=k7Y1GKLIREnj+KxWU2n4iL8HmkmMJ4Ax2qkibrGUJ+Fa6Z5EyeOMTxZGetO4g2paNH
 8ca7ieHgLgKlm3vY2J0HaNiVxqES3RwNBImI14v3wJzjtKYYc/fHODzT6alOMJtFDAxh
 nsV+Jauwd00DHpWPw6eBtowT9Z8KZ5SvfLW91iRG2zSphrpL+JD1+xdETVIftPKLvCkZ
 7ydhiphzDII4iff044us602w394Zql5gy40mBEqGdMy610Xg7OB5Oq0eTCoTrUHYxzRr
 eTz9TJFFWScX9uOt3SR32xrCEuZ76f5X5PXPDT5dZiLR86NnjPhPnX/i9Q+twUPQc2mt
 Kgvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789741475; x=1790346275;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=50aCxFdjvgOonBzfwDq4lxvq9N8Gbe3Y6UNEwMKBtjw=;
 b=v2+npf/m83U2LB3UHU8s/TGfpajTNN5cqpsyDv+ZnCS4+y7X+y0iLTbS5DTokP6r1b
 tvUunkiYzYA/wTF+10wOROpM861jT24YNiSgewwqwB6RY7JVruab8ZlfIfzKHpSa3fkI
 RSayu24xTVnNgmulKv5Ji9tSlevdfkz4CTbdWqrEKaSd2QA9MHi0DoPinbX0tXGWOVTT
 gQAfufhpGl/Fne12dkTp8fwcC2s6tf1CU5vb6mrIUDwZWUl/vBRQIcA9yYW87XO60iQ3
 fplaJ8xPcT78pq1zNC7F1RpkvjwP1KWKEO0sUKrmzxnlCmFdwphywIMe/qpLBxrJ1a9x
 4HdA==
X-Gm-Message-State: AFuF++m1e0dL06Ty7Urbn7PLFgwj0t8Ki1eXpAgV2hEB8Mznv9udKTGy
 L2p+6Vjd1qJViGcjTM1C/rldEpEjcUfUKMJwQtX1BINWPRpOR6Kgevr+AB20lX8qEtA=
X-Gm-Gg: AYBFou3B8rBrNQAZwF/MVfSn/baIfzxDyza6eFQc7Z11pOxYL5EGbhtg9cqnHsiGAy3
 j8xnfPpXScpH/rChSSFQPhOaFCLBmALmW793CFlsMjmHOqgrdHtJL2syYia9PvVvWvtavz/oCwq
 5/5yFNdEuy8Oh/TGBZqSfz93MRELpUiHvQ3fux//Sa9np8ARuwR7fE1DiQoS2ULhtIxd821Z2Zm
 6M2M12NDHBD1uih3NTsYeu+ECqBVKDTM1/xkgj15J2jfu7cPSpw0fGAEEed5LF8TUp6kaykI2L5
 Uwv+IxRodjLfKHYk/uL2z2HPdLqb8uchisUYj00GYd7Wj0c4A31Seevr690JEHs2wWrFkJrtkP2
 +L38Lg79P5RVKSgrwSL9WuimOeErtPDbgRNJiAh3o1yULNBwrbE5pZ7Hw07CAfGGa5TRWFLAfEs
 b5QCpuJMGrzC3SiqXQ+dhB47mpwgKU7L4sK6ro87tdpJC+y8PqXx9SVuD3LmhYFv0oRqH9fJ4p
X-Received: by 2002:a05:600c:1986:b0:49b:9105:cdaf with SMTP id
 5b1f17b1804b1-49fc56cb2f7mr63463755e9.8.1789741474629; 
 Fri, 18 Sep 2026 07:24:34 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fc79bdc35sm59367035e9.0.2026.09.18.07.24.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 07:24:30 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B545D5F948;
 Fri, 18 Sep 2026 15:24:29 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Subject: [PULL 01/17] scripts: update meson-buildoptions.sh
Date: Fri, 18 Sep 2026 15:24:12 +0100
Message-ID: <20260918142429.336497-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260918142429.336497-1-alex.bennee@linaro.org>
References: <20260918142429.336497-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::10;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm2-x10.google.com
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

This wasn't run because the automatic trigger is fickle. We don't want
to expose all the tcg-test-cross-cc options to help as we already have
processing via --cross-cc-ARCH so we tweak the CONFIGURE_HELP filter
in the update script.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260917185322.3457036-1-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/scripts/meson-buildoptions.py b/scripts/meson-buildoptions.py
index 9e3a75c8b11..a2bfff9c4bf 100644
--- a/scripts/meson-buildoptions.py
+++ b/scripts/meson-buildoptions.py
@@ -56,6 +56,7 @@
 # Options that configure prints help for, so we can skip
 CONFIGURE_HELP = {
     "gdb",
+    "tcg_tests_cross",
 }
 
 # Builtin options that should be definable via configure.  Some of the others
@@ -194,7 +195,7 @@ def print_help(options):
         key = cli_help_key(opt)
         # The first section includes options that have an arguments,
         # and booleans (i.e., only one of enable/disable makes sense)
-        if opt["name"] in CONFIGURE_HELP:
+        if any(opt["name"].startswith(h) for h in CONFIGURE_HELP):
             pass
         elif require_arg(opt):
             metavar = cli_metavar(opt)
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index ba3c9de216b..4ad8c1c5d35 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -10,7 +10,10 @@ meson_options_help() {
   printf "%s\n" '  --block-drv-rw-whitelist=VALUE'
   printf "%s\n" '                           set block driver read-write whitelist (by default'
   printf "%s\n" '                           affects only QEMU, not tools like qemu-img)'
+  printf "%s\n" '  --container-command=VALUE'
+  printf "%s\n" '                           command to build/run containers'
   printf "%s\n" '  --datadir=VALUE          Data file directory [share]'
+  printf "%s\n" '  --disable-containers     use containers to cross compile tcg tests'
   printf "%s\n" '  --disable-coroutine-pool coroutine freelist (better performance)'
   printf "%s\n" '  --disable-debug-info     Enable debug symbols and other information'
   printf "%s\n" '  --disable-hexagon-idef-parser'
@@ -195,7 +198,7 @@ meson_options_help() {
   printf "%s\n" '  spice-protocol  Spice protocol support'
   printf "%s\n" '  stack-protector compiler-provided stack protection'
   printf "%s\n" '  tcg             TCG support'
-  printf "%s\n" '  tests           build test suite'
+  printf "%s\n" '  tests           Build the test suite'
   printf "%s\n" '  tools           build support utilities that come with QEMU'
   printf "%s\n" '  tpm             TPM support'
   printf "%s\n" '  u2f             U2F emulation support'
@@ -282,6 +285,9 @@ _meson_option_parse() {
     --disable-cocoa) printf "%s" -Dcocoa=disabled ;;
     --enable-colo-proxy) printf "%s" -Dcolo_proxy=enabled ;;
     --disable-colo-proxy) printf "%s" -Dcolo_proxy=disabled ;;
+    --container-command=*) quote_sh "-Dcontainer_command=$2" ;;
+    --enable-containers) printf "%s" -Dcontainers=true ;;
+    --disable-containers) printf "%s" -Dcontainers=false ;;
     --enable-coreaudio) printf "%s" -Dcoreaudio=enabled ;;
     --disable-coreaudio) printf "%s" -Dcoreaudio=disabled ;;
     --with-coroutine=*) quote_sh "-Dcoroutine_backend=$2" ;;
@@ -518,9 +524,53 @@ _meson_option_parse() {
     --disable-tcg) printf "%s" -Dtcg=disabled ;;
     --enable-tcg-interpreter) printf "%s" -Dtcg_interpreter=true ;;
     --disable-tcg-interpreter) printf "%s" -Dtcg_interpreter=false ;;
-    --tls-priority=*) quote_sh "-Dtls_priority=$2" ;;
+    --tcg-tests-cross-cc-aarch64=*) quote_sh "-Dtcg_tests_cross_cc_aarch64=$2" ;;
+    --tcg-tests-cross-cc-aarch64-be=*) quote_sh "-Dtcg_tests_cross_cc_aarch64_be=$2" ;;
+    --tcg-tests-cross-cc-alpha=*) quote_sh "-Dtcg_tests_cross_cc_alpha=$2" ;;
+    --tcg-tests-cross-cc-arm=*) quote_sh "-Dtcg_tests_cross_cc_arm=$2" ;;
+    --tcg-tests-cross-cc-hexagon=*) quote_sh "-Dtcg_tests_cross_cc_hexagon=$2" ;;
+    --tcg-tests-cross-cc-hppa=*) quote_sh "-Dtcg_tests_cross_cc_hppa=$2" ;;
+    --tcg-tests-cross-cc-i386=*) quote_sh "-Dtcg_tests_cross_cc_i386=$2" ;;
+    --tcg-tests-cross-cc-loongarch64=*) quote_sh "-Dtcg_tests_cross_cc_loongarch64=$2" ;;
+    --tcg-tests-cross-cc-m68k=*) quote_sh "-Dtcg_tests_cross_cc_m68k=$2" ;;
+    --tcg-tests-cross-cc-mips=*) quote_sh "-Dtcg_tests_cross_cc_mips=$2" ;;
+    --tcg-tests-cross-cc-mips64=*) quote_sh "-Dtcg_tests_cross_cc_mips64=$2" ;;
+    --tcg-tests-cross-cc-mips64el=*) quote_sh "-Dtcg_tests_cross_cc_mips64el=$2" ;;
+    --tcg-tests-cross-cc-or1k=*) quote_sh "-Dtcg_tests_cross_cc_or1k=$2" ;;
+    --tcg-tests-cross-cc-ppc64=*) quote_sh "-Dtcg_tests_cross_cc_ppc64=$2" ;;
+    --tcg-tests-cross-cc-ppc64le=*) quote_sh "-Dtcg_tests_cross_cc_ppc64le=$2" ;;
+    --tcg-tests-cross-cc-riscv64=*) quote_sh "-Dtcg_tests_cross_cc_riscv64=$2" ;;
+    --tcg-tests-cross-cc-s390x=*) quote_sh "-Dtcg_tests_cross_cc_s390x=$2" ;;
+    --tcg-tests-cross-cc-sh4=*) quote_sh "-Dtcg_tests_cross_cc_sh4=$2" ;;
+    --tcg-tests-cross-cc-tricore=*) quote_sh "-Dtcg_tests_cross_cc_tricore=$2" ;;
+    --tcg-tests-cross-cc-x86-64=*) quote_sh "-Dtcg_tests_cross_cc_x86_64=$2" ;;
+    --tcg-tests-cross-cc-xtensa=*) quote_sh "-Dtcg_tests_cross_cc_xtensa=$2" ;;
+    --tcg-tests-cross-cc-xtensaeb=*) quote_sh "-Dtcg_tests_cross_cc_xtensaeb=$2" ;;
+    --tcg-tests-cross-cflags-aarch64=*) quote_sh "-Dtcg_tests_cross_cflags_aarch64=$2" ;;
+    --tcg-tests-cross-cflags-aarch64-be=*) quote_sh "-Dtcg_tests_cross_cflags_aarch64_be=$2" ;;
+    --tcg-tests-cross-cflags-alpha=*) quote_sh "-Dtcg_tests_cross_cflags_alpha=$2" ;;
+    --tcg-tests-cross-cflags-arm=*) quote_sh "-Dtcg_tests_cross_cflags_arm=$2" ;;
+    --tcg-tests-cross-cflags-hexagon=*) quote_sh "-Dtcg_tests_cross_cflags_hexagon=$2" ;;
+    --tcg-tests-cross-cflags-hppa=*) quote_sh "-Dtcg_tests_cross_cflags_hppa=$2" ;;
+    --tcg-tests-cross-cflags-i386=*) quote_sh "-Dtcg_tests_cross_cflags_i386=$2" ;;
+    --tcg-tests-cross-cflags-loongarch64=*) quote_sh "-Dtcg_tests_cross_cflags_loongarch64=$2" ;;
+    --tcg-tests-cross-cflags-m68k=*) quote_sh "-Dtcg_tests_cross_cflags_m68k=$2" ;;
+    --tcg-tests-cross-cflags-mips=*) quote_sh "-Dtcg_tests_cross_cflags_mips=$2" ;;
+    --tcg-tests-cross-cflags-mips64=*) quote_sh "-Dtcg_tests_cross_cflags_mips64=$2" ;;
+    --tcg-tests-cross-cflags-mips64el=*) quote_sh "-Dtcg_tests_cross_cflags_mips64el=$2" ;;
+    --tcg-tests-cross-cflags-or1k=*) quote_sh "-Dtcg_tests_cross_cflags_or1k=$2" ;;
+    --tcg-tests-cross-cflags-ppc64=*) quote_sh "-Dtcg_tests_cross_cflags_ppc64=$2" ;;
+    --tcg-tests-cross-cflags-ppc64le=*) quote_sh "-Dtcg_tests_cross_cflags_ppc64le=$2" ;;
+    --tcg-tests-cross-cflags-riscv64=*) quote_sh "-Dtcg_tests_cross_cflags_riscv64=$2" ;;
+    --tcg-tests-cross-cflags-s390x=*) quote_sh "-Dtcg_tests_cross_cflags_s390x=$2" ;;
+    --tcg-tests-cross-cflags-sh4=*) quote_sh "-Dtcg_tests_cross_cflags_sh4=$2" ;;
+    --tcg-tests-cross-cflags-tricore=*) quote_sh "-Dtcg_tests_cross_cflags_tricore=$2" ;;
+    --tcg-tests-cross-cflags-x86-64=*) quote_sh "-Dtcg_tests_cross_cflags_x86_64=$2" ;;
+    --tcg-tests-cross-cflags-xtensa=*) quote_sh "-Dtcg_tests_cross_cflags_xtensa=$2" ;;
+    --tcg-tests-cross-cflags-xtensaeb=*) quote_sh "-Dtcg_tests_cross_cflags_xtensaeb=$2" ;;
     --enable-tests) printf "%s" -Dtests=enabled ;;
     --disable-tests) printf "%s" -Dtests=disabled ;;
+    --tls-priority=*) quote_sh "-Dtls_priority=$2" ;;
     --enable-tools) printf "%s" -Dtools=enabled ;;
     --disable-tools) printf "%s" -Dtools=disabled ;;
     --enable-tpm) printf "%s" -Dtpm=enabled ;;
-- 
2.47.3


