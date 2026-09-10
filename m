Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D5CCC79F9F
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 18:17:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4jIr-00042r-FA; Thu, 10 Sep 2026 14:15:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x4jIo-0003vr-Al
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 14:15:14 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x4jIl-00073P-PX
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 14:15:14 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49ccfd61ecaso1314065e9.3
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 11:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789064110; x=1789668910; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tZcQDE9NLA8D1/7Rk7TIcfTc7fMZq6HAOUgnPmCd/Z4=;
 b=XKaQX6x3Yc30q5dIWbEFUNpslmGzi/Ojd+YV3i9ZLYqReCBJ4nT3ZxAVqo8eSb6BOq
 LlXXX2IegkUZAJfqVeIZcf7R/ay12ZRbo2fWUfHb4mVEAXHWUO7MypA1+u9hJhmNyAIf
 VQ/pvPuOsKb/1h3KCYxlMLHdQJchRbPaWnesB19ycDDg2ViM3LzrhwsRgKrMsaEnFlFY
 i7KII4HpxP6l3p2sIoFn6yJz4QYFugxG9WSD8YACWIMqBKtmBM82VV2cd7q17dq61mwS
 8gUnjvetdIri+KLU6wsltQ5/13F5zTiJ/aHpw9qS9G00oaP5koBiLJghNzD1+gY1BGmi
 OsYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789064110; x=1789668910;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tZcQDE9NLA8D1/7Rk7TIcfTc7fMZq6HAOUgnPmCd/Z4=;
 b=JUR/OtRTZE3tKN9cSNt90uOJbU7SlsJ/p+D3I9CfVlSQ5Vzf3sx7ndyEyFsZZdYqix
 7h9TQVHejhKSlNvDH77QJqfXlU9MC9ObaefhsKzXA5VFZ+Ntk2DsnDsoDrJVcv6q4WDf
 vooEdwCjF9cMGWTVKU9gELcf+W9XMWuN60gX8rOzXCe2BE70yU7gkGgka4cVx3xPQXm4
 fZfynUgvTlhXTGRvLhxiIHru8uKZ2qK2QnMUhlreqMIhm6wTlJ46LqvQOMLxJ6vYnHRf
 mPignUfefZeHmfAXUI+OB0d3nkLu041dWTCjc6jJAKguQpMm5SjRjKzPOynbmeVqbZUj
 5s+A==
X-Gm-Message-State: AFuF++nsHJyyBB85eZa7Q0YUKW1qaane3GLMtWlQ/WGenniseBcWzKma
 Ncu4YcLB0Acma10g+nu3IOHzCJLbr20dVmZYVyXTmV7WjGZlgepYLtlv6fdFrt7VQEc=
X-Gm-Gg: AYBFou2eI1bXIv9+3CxrQlg0f8HQFDoU2WAxIzx7GocS7rY5ClyEdTX3sKgM72uiRG5
 p4X601mpsPYXTJDED1UswEKSBcHTTNVKGeeoT9SFSn2lBOG4RvymxY68+5jDqRLWGq+u+Z4q0zS
 XVa/MWCCEnzFfMIJkJCYKpIFqyXE+b29xclAtPfHzch6GngYocNcJ5qXDpcesihl9y4T1migNbw
 Fpncun+b1l6iojMTUWszGtW5DL345o6RVKqm6F/il1mT1s5TTiPeTVguSO2IpPJx6QU3hvuCWKz
 mHArP34Vo9GdEsbUAq0btSyxMUEvL7BfAt1UGCsnb3dR5nsvFCe4i5WzaQ0x/wbVpiyG8CeqXw6
 XNbYr9BQshVHPv5m2qZWknCrUNO9rXIjQEVbKnPC8Q0RJH7oA6bZakCiCQ3aao5OfpOZ0473Io5
 JPnHqi5sNUKaB60p4ptMbpph5XY11eEBdMkIkV3cQPzqZGOeRi9/wy8qAaxkk17ovPQVKchxk=
X-Received: by 2002:a05:600c:3ba9:b0:49c:fa21:e73e with SMTP id
 5b1f17b1804b1-49e619c0558mr2627255e9.20.1789064110082; 
 Thu, 10 Sep 2026 11:15:10 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e61a7a604sm1717985e9.3.2026.09.10.11.15.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 11:15:06 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 248195F915;
 Thu, 10 Sep 2026 19:15:05 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Brad Smith <brad@comstyle.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Song Gao <gaosong@loongson.cn>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, John Snow <jsnow@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 Brian Cain <brian.cain@oss.qualcomm.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Kyle Evans <kevans@freebsd.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>
Subject: [PATCH 1/9] scripts/meson-buildoptions.sh: update missing options
Date: Thu, 10 Sep 2026 19:14:56 +0100
Message-ID: <20260910181504.1010916-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260910181504.1010916-1-alex.bennee@linaro.org>
References: <20260910181504.1010916-1-alex.bennee@linaro.org>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This should have been updated when the meson check-tcg changes where
made. Include it now.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 scripts/meson-buildoptions.sh | 142 ++++++++++++++++++++++++++++++++++
 1 file changed, 142 insertions(+)

diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index 5a67e59a167..67c5e33b011 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -10,7 +10,13 @@ meson_options_help() {
   printf "%s\n" '  --block-drv-rw-whitelist=VALUE'
   printf "%s\n" '                           set block driver read-write whitelist (by default'
   printf "%s\n" '                           affects only QEMU, not tools like qemu-img)'
+  printf "%s\n" '  --container-command=VALUE'
+  printf "%s\n" '                           command to build/run containers'
+  printf "%s\n" '  --container-registry=VALUE'
+  printf "%s\n" '                           container registry to cache from'
+  printf "%s\n" '                           [registry.gitlab.com/qemu-project/qemu]'
   printf "%s\n" '  --datadir=VALUE          Data file directory [share]'
+  printf "%s\n" '  --disable-containers     use containers to cross compile tcg tests'
   printf "%s\n" '  --disable-coroutine-pool coroutine freelist (better performance)'
   printf "%s\n" '  --disable-debug-info     Enable debug symbols and other information'
   printf "%s\n" '  --disable-hexagon-idef-parser'
@@ -77,6 +83,94 @@ meson_options_help() {
   printf "%s\n" '  --rtsig-map=VALUE        default value of QEMU_RTSIG_MAP [NULL]'
   printf "%s\n" '  --smbd=VALUE             Path to smbd for slirp networking'
   printf "%s\n" '  --sysconfdir=VALUE       Sysconf data directory [etc]'
+  printf "%s\n" '  --tcg-tests-cross-cc-aarch64=VALUE'
+  printf "%s\n" '                           cc for aarch64 tcg tests'
+  printf "%s\n" '  --tcg-tests-cross-cc-aarch64-be=VALUE'
+  printf "%s\n" '                           cc for aarch64_be tcg tests'
+  printf "%s\n" '  --tcg-tests-cross-cc-alpha=VALUE'
+  printf "%s\n" '                           cc for alpha tcg tests'
+  printf "%s\n" '  --tcg-tests-cross-cc-arm=VALUE'
+  printf "%s\n" '                           cc for arm tcg tests'
+  printf "%s\n" '  --tcg-tests-cross-cc-hexagon=VALUE'
+  printf "%s\n" '                           cc for hexagon tcg tests'
+  printf "%s\n" '  --tcg-tests-cross-cc-hppa=VALUE'
+  printf "%s\n" '                           cc for hppa tcg tests'
+  printf "%s\n" '  --tcg-tests-cross-cc-i386=VALUE'
+  printf "%s\n" '                           cc for i386 tcg tests'
+  printf "%s\n" '  --tcg-tests-cross-cc-loongarch64=VALUE'
+  printf "%s\n" '                           cc for loongarch64 tcg tests'
+  printf "%s\n" '  --tcg-tests-cross-cc-m68k=VALUE'
+  printf "%s\n" '                           cc for m68k tcg tests'
+  printf "%s\n" '  --tcg-tests-cross-cc-mips=VALUE'
+  printf "%s\n" '                           cc for mips tcg tests'
+  printf "%s\n" '  --tcg-tests-cross-cc-mips64=VALUE'
+  printf "%s\n" '                           cc for mips64 tcg tests'
+  printf "%s\n" '  --tcg-tests-cross-cc-mips64el=VALUE'
+  printf "%s\n" '                           cc for mips64el tcg tests'
+  printf "%s\n" '  --tcg-tests-cross-cc-or1k=VALUE'
+  printf "%s\n" '                           cc for or1k tcg tests'
+  printf "%s\n" '  --tcg-tests-cross-cc-ppc64=VALUE'
+  printf "%s\n" '                           cc for ppc64 tcg tests'
+  printf "%s\n" '  --tcg-tests-cross-cc-ppc64le=VALUE'
+  printf "%s\n" '                           cc for ppc64le tcg tests'
+  printf "%s\n" '  --tcg-tests-cross-cc-riscv64=VALUE'
+  printf "%s\n" '                           cc for riscv64 tcg tests'
+  printf "%s\n" '  --tcg-tests-cross-cc-s390x=VALUE'
+  printf "%s\n" '                           cc for s390x tcg tests'
+  printf "%s\n" '  --tcg-tests-cross-cc-sh4=VALUE'
+  printf "%s\n" '                           cc for sh4 tcg tests'
+  printf "%s\n" '  --tcg-tests-cross-cc-tricore=VALUE'
+  printf "%s\n" '                           cc for tricore tcg tests'
+  printf "%s\n" '  --tcg-tests-cross-cc-x86-64=VALUE'
+  printf "%s\n" '                           cc for x86_64 tcg tests'
+  printf "%s\n" '  --tcg-tests-cross-cc-xtensa=VALUE'
+  printf "%s\n" '                           cc for xtensa tcg tests'
+  printf "%s\n" '  --tcg-tests-cross-cc-xtensaeb=VALUE'
+  printf "%s\n" '                           cc for xtensaeb tcg tests'
+  printf "%s\n" '  --tcg-tests-cross-cflags-aarch64=VALUE'
+  printf "%s\n" '                           cflags for aarch64 tcg tests'
+  printf "%s\n" '  --tcg-tests-cross-cflags-aarch64-be=VALUE'
+  printf "%s\n" '                           cflags for aarch64_be tcg tests'
+  printf "%s\n" '  --tcg-tests-cross-cflags-alpha=VALUE'
+  printf "%s\n" '                           cflags for alpha tcg tests'
+  printf "%s\n" '  --tcg-tests-cross-cflags-arm=VALUE'
+  printf "%s\n" '                           cflags for arm tcg tests'
+  printf "%s\n" '  --tcg-tests-cross-cflags-hexagon=VALUE'
+  printf "%s\n" '                           cflags for hexagon tcg tests'
+  printf "%s\n" '  --tcg-tests-cross-cflags-hppa=VALUE'
+  printf "%s\n" '                           cflags for hppa tcg tests'
+  printf "%s\n" '  --tcg-tests-cross-cflags-i386=VALUE'
+  printf "%s\n" '                           cflags for i386 tcg tests'
+  printf "%s\n" '  --tcg-tests-cross-cflags-loongarch64=VALUE'
+  printf "%s\n" '                           cflags for loongarch64 tcg tests'
+  printf "%s\n" '  --tcg-tests-cross-cflags-m68k=VALUE'
+  printf "%s\n" '                           cflags for m68k tcg tests'
+  printf "%s\n" '  --tcg-tests-cross-cflags-mips=VALUE'
+  printf "%s\n" '                           cflags for mips tcg tests'
+  printf "%s\n" '  --tcg-tests-cross-cflags-mips64=VALUE'
+  printf "%s\n" '                           cflags for mips64 tcg tests'
+  printf "%s\n" '  --tcg-tests-cross-cflags-mips64el=VALUE'
+  printf "%s\n" '                           cflags for mips64el tcg tests'
+  printf "%s\n" '  --tcg-tests-cross-cflags-or1k=VALUE'
+  printf "%s\n" '                           cflags for or1k tcg tests'
+  printf "%s\n" '  --tcg-tests-cross-cflags-ppc64=VALUE'
+  printf "%s\n" '                           cflags for ppc64 tcg tests'
+  printf "%s\n" '  --tcg-tests-cross-cflags-ppc64le=VALUE'
+  printf "%s\n" '                           cflags for ppc64le tcg tests'
+  printf "%s\n" '  --tcg-tests-cross-cflags-riscv64=VALUE'
+  printf "%s\n" '                           cflags for riscv64 tcg tests'
+  printf "%s\n" '  --tcg-tests-cross-cflags-s390x=VALUE'
+  printf "%s\n" '                           cflags for s390x tcg tests'
+  printf "%s\n" '  --tcg-tests-cross-cflags-sh4=VALUE'
+  printf "%s\n" '                           cflags for sh4 tcg tests'
+  printf "%s\n" '  --tcg-tests-cross-cflags-tricore=VALUE'
+  printf "%s\n" '                           cflags for tricore tcg tests'
+  printf "%s\n" '  --tcg-tests-cross-cflags-x86-64=VALUE'
+  printf "%s\n" '                           cflags for x86_64 tcg tests'
+  printf "%s\n" '  --tcg-tests-cross-cflags-xtensa=VALUE'
+  printf "%s\n" '                           cflags for xtensa tcg tests'
+  printf "%s\n" '  --tcg-tests-cross-cflags-xtensaeb=VALUE'
+  printf "%s\n" '                           cflags for xtensaeb tcg tests'
   printf "%s\n" '  --tls-priority=VALUE     Default TLS protocol/cipher priority string'
   printf "%s\n" '                           [NORMAL]'
   printf "%s\n" '  --with-coroutine=CHOICE  coroutine backend to use (choices:'
@@ -281,6 +375,10 @@ _meson_option_parse() {
     --disable-cocoa) printf "%s" -Dcocoa=disabled ;;
     --enable-colo-proxy) printf "%s" -Dcolo_proxy=enabled ;;
     --disable-colo-proxy) printf "%s" -Dcolo_proxy=disabled ;;
+    --container-command=*) quote_sh "-Dcontainer_command=$2" ;;
+    --container-registry=*) quote_sh "-Dcontainer_registry=$2" ;;
+    --enable-containers) printf "%s" -Dcontainers=true ;;
+    --disable-containers) printf "%s" -Dcontainers=false ;;
     --enable-coreaudio) printf "%s" -Dcoreaudio=enabled ;;
     --disable-coreaudio) printf "%s" -Dcoreaudio=disabled ;;
     --with-coroutine=*) quote_sh "-Dcoroutine_backend=$2" ;;
@@ -517,6 +615,50 @@ _meson_option_parse() {
     --disable-tcg) printf "%s" -Dtcg=disabled ;;
     --enable-tcg-interpreter) printf "%s" -Dtcg_interpreter=true ;;
     --disable-tcg-interpreter) printf "%s" -Dtcg_interpreter=false ;;
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
     --tls-priority=*) quote_sh "-Dtls_priority=$2" ;;
     --enable-tools) printf "%s" -Dtools=enabled ;;
     --disable-tools) printf "%s" -Dtools=disabled ;;
-- 
2.47.3


