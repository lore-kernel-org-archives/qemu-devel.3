Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79798D232DF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 05:33:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve56o-0004bt-Cu; Fri, 09 Jan 2026 00:32:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ve56m-0004UY-KU
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 00:32:24 -0500
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ve56k-0003jh-Uy
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 00:32:24 -0500
Received: by mail-pj1-x1044.google.com with SMTP id
 98e67ed59e1d1-34c93e0269cso1581278a91.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 21:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767936741; x=1768541541; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vX5k8URz+WxvHEs6xHVVrbyddi59Q3B4hlkFmYoIedo=;
 b=nM9Y79w8Bj5wfORdCwTltFXDeXGX1evbfPbgxZ4uEz2q2Syu3rPEflNaaR1ojLcWI4
 8A6ZGGbmXu6592WzR+c88tHzHHl0iS1rHyoxcpp50LCWp6aR54hzEpcpHIPlq8/t+Py3
 WaBuG5gemqaVa5rYHb8gLj07TwF6+SNwpgi0uaHRSDuXl5Cmd2sd/xJiu631tUtp37lC
 ay1mLRCSQ5HZuM69hftJUkoWYntAv+3utayyVT4NGmzW1QqiIWm7kGjtCK7hrjqvHKeA
 PdVoPddXBL7qA9g2iFORxcVOjrBmipi9tjKR9oTY771JqWFjaNsZ6ps7BgFYqg4gEVS7
 PcxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767936741; x=1768541541;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vX5k8URz+WxvHEs6xHVVrbyddi59Q3B4hlkFmYoIedo=;
 b=HkQqDPPp38fuW3QYP0x7U1nVcaMi73hwokyzI4AI/WutkgtpZhbFAL9mPDEYbiztcE
 ILY8OJC3a1fgLx2fxn6G4QwUzrFrkS+KeWF5z502fBE9R5DKeZFqBiYexsfr4hl9QcBg
 dUB6I9DYR+NUB9brrQYCqiyouh4aVvC2udGfs1pofmh3tdKtach16xo85f6G9y03AH4m
 Pgo41qDS5i7FNNXzqjE+Kzu2R1mz8Zxdwy1yLCCW8zTWE4r4zeGEMZ0qTxfy6lrpBBjT
 slGsMGIjf7syyvDR059lVkaDwLQCtJq5bT5fK+k+/xyrD4xHvbwJD0ypqrNfHTrJP2BS
 csgg==
X-Gm-Message-State: AOJu0YzdX3GP/tODKLtbdQyfRmEjUyqBfRc45QKwIsp411KDJ5ibcGzY
 dG58VIBqxn6J35ihmrLu7YTL7LVOgciPRfGBEGqEbK0vOmZfrEqWFn2+tZb2zIfs2hHm6P1bh2f
 DJh5vEt4=
X-Gm-Gg: AY/fxX6VY6/pQtkzyRJXPwAJRByglpyeUPYeWjPur9ghSHWIQB41WXIlQRV8d/oClQJ
 7L9zJlHb04DqY/4N9WDWFbfrC5NBII16k12hbkMOUWBty45SgxrCh3xfxYN6TP93l2AghA5djiR
 yULr7XGsLUigyufseJwCsHMgJ35BJ0O4XtUs2FtoSduLYQ3l5LlSZ2AibOZ1GSajz09tTfwEraN
 +bKw/ccPHelAd26n801icLf3hO+fnE82drIP13J8EY2EBHCq+QgxJURozjPGyHq4mqLtfMJInin
 byN3SHGYJrsrou+Bc6+Zj0RRq2bYrCN3mqwEfIOs2GDu+IAG1qM0M9xuiafgOlrHAtxgwacmzTd
 lbQSyGiuGBwtu/k8PXjfrrGDDLum9SDHccKtThqkd/KkF3uQT1SUBnjxrD+t3zsS4Fxf0Xgfn+q
 L6zspLv3rk7zbp7pazCzlAom6tGWPs5cNwj2SL+elZhzDiug9X+vtPFoi+c9TRwSln
X-Google-Smtp-Source: AGHT+IEBmyV37GAec/WyqQFRxG+M5hvGa6ciAPlYmbQO+9NH71/bBEUnmOF9AmI8lm9wamJacxsgEQ==
X-Received: by 2002:a17:90b:2247:b0:349:162d:ae0c with SMTP id
 98e67ed59e1d1-34f68b4b2admr9144548a91.4.1767936741438; 
 Thu, 08 Jan 2026 21:32:21 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f5fa93f30sm9260137a91.5.2026.01.08.21.32.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 21:32:21 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>, anjo@rev.ng,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 19/29] target/arm/tcg/translate-mve.c: make compilation unit
 common
Date: Thu,  8 Jan 2026 21:31:48 -0800
Message-ID: <20260109053158.2800705-20-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260109053158.2800705-1-pierrick.bouvier@linaro.org>
References: <20260109053158.2800705-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1044.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/tcg/translate-mve.c | 2 ++
 target/arm/tcg/meson.build     | 4 +++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/target/arm/tcg/translate-mve.c b/target/arm/tcg/translate-mve.c
index b1a8d6a65c0..e65782a4b2e 100644
--- a/target/arm/tcg/translate-mve.c
+++ b/target/arm/tcg/translate-mve.c
@@ -18,6 +18,8 @@
  */
 
 #include "qemu/osdep.h"
+
+#define TARGET_ADDRESS_BITS 32
 #include "translate.h"
 #include "translate-a32.h"
 
diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index 23986de320b..24276f24dc0 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -28,7 +28,6 @@ arm_ss.add(files(
   'gengvec.c',
   'translate.c',
   'translate-m-nocp.c',
-  'translate-mve.c',
   'm_helper.c',
   'mve_helper.c',
   'op_helper.c',
@@ -61,6 +60,7 @@ arm_common_ss.add(files(
 arm_common_system_ss.add(
   decodetree.process('vfp.decode', extra_args: '--decode=disas_vfp'),
   decodetree.process('vfp-uncond.decode', extra_args: '--decode=disas_vfp_uncond'),
+  decodetree.process('mve.decode', extra_args: '--decode=disas_mve'),
   decodetree.process('neon-shared.decode', extra_args: '--decode=disas_neon_shared'),
   decodetree.process('neon-dp.decode', extra_args: '--decode=disas_neon_dp'),
   decodetree.process('neon-ls.decode', extra_args: '--decode=disas_neon_ls'),
@@ -71,6 +71,7 @@ arm_common_system_ss.add(
   'psci.c',
   'tlb_helper.c',
   'tlb-insns.c',
+  'translate-mve.c',
   'translate-neon.c',
   'translate-vfp.c',
   'vec_helper.c',
@@ -80,6 +81,7 @@ arm_user_ss.add(files(
   'hflags.c',
   'neon_helper.c',
   'tlb_helper.c',
+  'translate-mve.c',
   'translate-neon.c',
   'translate-vfp.c',
   'vec_helper.c',
-- 
2.47.3


