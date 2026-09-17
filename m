Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F153C88E72
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 18:53:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7HEo-0007bL-2K; Thu, 17 Sep 2026 14:53:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x7HEk-0007b7-UG
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 14:53:36 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x7HEi-0004rx-Rd
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 14:53:34 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49ccead2aecso6232435e9.0
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 11:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789671210; x=1790276010; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=aVp9tA1RvLMP9FcJIPSR8LQzb3AJzr6I8aeJVALKBKo=;
 b=eParfU+4CPRROAMaBWt2/0it8d46BMZcsNQmGA7U2ekG+9EGKLolV9boFOB5bqfMEX
 mCmLBP/TBCZYgac6T92v0TFEn7AiC1p3NttivJgLHlocdnmMdjEx9ipayZrspsLZyL0Q
 jItWvtgF9sIYOlpxdNSoAqGxDjQNBuASbIPwB/WJR/kBf14PB2x8PKWzQr/SCqf9FC4h
 /9Y2ThMtDxEVMj0qob8RLi67goa0/4y5czOsKHUUWsU7l0etkYexFMKnFtvCP8nBJ2Kj
 JT+5WQS5Lkbki9vLHemTzNK2CoTmOvxkZvp15KyTuZ+E9C5WVVoyXwJ2IbWAPzq1fWjh
 XtwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789671210; x=1790276010;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=aVp9tA1RvLMP9FcJIPSR8LQzb3AJzr6I8aeJVALKBKo=;
 b=d4jkE+RTXnENmG1SaGthJP9BLl0/0AZ/uc4xAEV5a61lwsV7tu7mAuhuSW2egfbE0d
 udQJcraRml+W8OJHMeoleyGpk+m7ha5C8kXi3MkDGDmC4bH0Zb9bcpm7DPrBbTfEd52C
 MzCuu7jhR6RnT6zA2P6WRSt9wVvsf8xpQMkA0MExGy5c4th3u8noQpSNb7oWFMPGPEKg
 vTGhM9hItiGHvswpTq4YB8JMnQE0KbuQxpw2hqxrvc7N468ThdFv3FwPyQVdTICoYm+H
 ZNFYqXUjslAn4FMIuZZJmMrp8ccGK/l50DRz9mvCB5P37+5dQS7jgQuFrNoYMSDfBEku
 SlLQ==
X-Gm-Message-State: AFuF++l9rq4isf6eGWm6OuFzbhBd77SANwlzGpU74cCGReKc1Rpfaf8U
 8r//jtCGH1Mm53fYYUAbAJZQn0J93AJELZw9WH3Oob55sTcaStQ4GzFIV3y6bYVira8=
X-Gm-Gg: AYBFou361zEs+ObEKgJkAnQ9/EcpyjEjyi8RoifEb26+uXtp1TUOQkba7Lg/m3/PTih
 MpRDhk3Omq5nhJX0gnDvaaQgD1HtpSoDAN4IdPSobVjwnZNe6AOei0kAPOseW8yMBRSg5oQYfor
 Got0uTcXU/5O9PcPWGj5p84mz3x94ZUsuLXIUXhY2gmRlOvaDGIj0ZksJ+qw6DXya8mtkUXM5aX
 NgI36qMl0781GCKvWKFKG0gul/KCVufMRjOF8GWo7CUYUWEYRCZYwzoHG50TDT6DaWpaH5XGnNi
 FExX6ms7htj5bWdoX1Mxtq7T9f+c/F0J01mw7em63w9IGvDCRgu0yz1sNGhkSty8ol0u6Yq3CaW
 fnNKMBTAab1eIJ/B1roEIkoc63hUt4DHDQRsf2IgHtzndKfswxRxiVSgcc48lf56N8TPmzeANZp
 tWnBJgMUMvX62rCPIl5Moov9P6Jquy1b9vd7f61c4IYgupN+3CBlSiumSLHR6qlh9IGeMEReY=
X-Received: by 2002:a05:600d:8485:10b0:49f:bc43:9e96 with SMTP id
 5b1f17b1804b1-49fbc43a0a0mr54675595e9.8.1789671209800; 
 Thu, 17 Sep 2026 11:53:29 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fbd2160c2sm99781815e9.6.2026.09.17.11.53.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 11:53:29 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id DDFA35F872;
 Thu, 17 Sep 2026 19:53:27 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@oss.qualcomm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Subject: [PATCH] scripts: update meson-buildoptions.sh
Date: Thu, 17 Sep 2026 19:53:22 +0100
Message-ID: <20260917185322.3457036-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
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

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
For PR:
  - I'll stack this at the front of the PR I roll tomorrow.
---
 scripts/meson-buildoptions.py |  3 +-
 scripts/meson-buildoptions.sh | 54 +++++++++++++++++++++++++++++++++--
 2 files changed, 54 insertions(+), 3 deletions(-)

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


