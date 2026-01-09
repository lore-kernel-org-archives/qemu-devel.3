Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6051D232E1
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 05:35:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve56x-0004xZ-6L; Fri, 09 Jan 2026 00:32:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ve56v-0004tr-I2
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 00:32:33 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ve56t-0003lw-Oa
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 00:32:33 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-7b22ffa2a88so2145995b3a.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 21:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767936750; x=1768541550; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/eYQagYuoCfAlqFeCaUdGzlYOnEG4VrhzQi7faL14lM=;
 b=znb8ruMCofos8c0AEt8+j1TyJh4q+3LlGwWATZrAKrjaTMb7WAAhC+sdsOhVDXG2Om
 W1UU3azIkJlJEIJ+eAeYY2wb+PIMY5yaVHu11gCigwLDlH2gyGUqnb75dn7EK09MTH7v
 ITT8ZeNKfkR4h1bYasxZGuzrqcvcrAG2XlAejPxdheYxoioqsx6ApEid7+B1lQ8ctG0p
 eR0RJ8U5hR3/ibJ9ZbC1gAdcg/yhEXwpjXv9F0237IehYpvIIRJF+nKZS5Rp47s8bH8I
 YF4F/SxdDy2KbTwe945Ud6d7pHkT2MKwj0i7isHt8QmH5i9r3fj2Gt3GPd8biSGnWaJd
 n0rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767936750; x=1768541550;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/eYQagYuoCfAlqFeCaUdGzlYOnEG4VrhzQi7faL14lM=;
 b=gszUzcnWOqTQEEkRDPOFI1AhDtvL4ZjLb33DJEvsB5YLP2fRRIKFGEyhUfXZ9XpOJW
 Bn2kX7xHRNWcTUoqwc7hsmGRRocpfWMtzKbVtH3xpan4LrQIMfKYTDGCUpkSQfv1VxbC
 yGwnyJQtX6uof7kwaP5Jq5TVYOz7e4WI0AQePqGIPdSNvKam2cL+pOorGjb1zdalWfeQ
 oVCTFGUdGNOMs3HVu24c9ThtdNKXK4Bsw/vUOCjJ6mU2ThT7nhrnF++ckILdJE/Oetsx
 wNCK0n+B3qUkbXQEgsU134/alvJzHH9r1OSJibAr6jvp9fkmIX9QgoEgh19Sa9h2zqP+
 lWHA==
X-Gm-Message-State: AOJu0Yx38Ygx/B9nHSiW8zBsac5gy+B1NhGMH14gudbuKll+KFOfr7Vy
 dCDm2TOdF67R2x0OzfddVS/rDeoPjzkCVTBWm7UuplV+jbUXXBbF2FK1cUldy3yRsiE6nn7gGuY
 RQF2i
X-Gm-Gg: AY/fxX5YokC0NQnDnjXl1+4lgrATD1NA1BFqAsw4tWYpJ1IvH7rXeMRiewkxoql1fKY
 hsBGvG1vct7BSf8Dg9LplVrVjicvmDOREmo75f3p26YsSgYAeBwYfaG/CWYC1JEqw4qpLEkGhGv
 DzLtFn6tJuyXIVlPI3XJwuiy8IAAMPmWvbpdz+iHWsG++mjmsJFfFpa+veKGxsnDEbukYVii/Wb
 RJSPPFylnZRAVH/DySfzrLtnHTRqTaBhe+qCQ9MW1EicvsKwTxWCkyFeyHuxmzu7TG+Yxq3acQz
 wBjWOZIgFcfck36jMF1LbPuUwkDtMBiZA+Glxsx88KtyKzJ8gv35N/L0soYBT+1bKzPOmXPlz3k
 D1+ufR3ZN5BLb9GVopIHUMs2ogAaJWFazbEUNbw9sd/6v8aCv0G0nIX5oX7xygvwk2Ln3IETVaR
 D2SMbOa2mRY3RaBAEvjwUyqUkAhYer6Rq+VCFoYtN8Fvm7Lm8Qyk6VPHmZFwr/pv58
X-Google-Smtp-Source: AGHT+IEmPXsPnuPkMGuRbgiq+jV8vGZx+xmpfdXexUlvSKxy8CxgTys1NmiruFWUgd+x23p3mkN7lA==
X-Received: by 2002:a05:6a20:7490:b0:389:8f3f:50ce with SMTP id
 adf61e73a8af0-3898f9af60amr7873266637.56.1767936750311; 
 Thu, 08 Jan 2026 21:32:30 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f5fa93f30sm9260137a91.5.2026.01.08.21.32.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 21:32:29 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>, anjo@rev.ng,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 29/29] target/arm/tcg/translate.c: make compilation unit common
Date: Thu,  8 Jan 2026 21:31:58 -0800
Message-ID: <20260109053158.2800705-30-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260109053158.2800705-1-pierrick.bouvier@linaro.org>
References: <20260109053158.2800705-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42e.google.com
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

We can finally make translate.c common.

This is the only file using TCGv as well, so we need to set .tcgv_type
in arm_get_tb_cpu_state() accordingly, to not break bisection with this
series. Indeed, we will now have a different TCGv type at runtime when
calling gen_aa32_*_internal_*() compared to before for aarch64 targets.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/tcg/hflags.c    | 1 +
 target/arm/tcg/translate.c | 1 +
 target/arm/tcg/meson.build | 7 ++++++-
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/target/arm/tcg/hflags.c b/target/arm/tcg/hflags.c
index 5c9b9bec3b2..2b06b75b581 100644
--- a/target/arm/tcg/hflags.c
+++ b/target/arm/tcg/hflags.c
@@ -693,5 +693,6 @@ TCGTBCPUState arm_get_tb_cpu_state(CPUState *cs)
         .pc = pc,
         .flags = flags.flags,
         .cs_base = flags.flags2,
+        .tcgv_type = is_a64(env) ? TCGV_TYPE_I64 : TCGV_TYPE_I32
     };
 }
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 3cd05682ce8..1bd763025e8 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -20,6 +20,7 @@
  */
 #include "qemu/osdep.h"
 
+#define TARGET_ADDRESS_BITS 32
 #include "translate.h"
 #include "translate-a32.h"
 #include "qemu/log.h"
diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index a2a636ef14a..9d50f8b5001 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -25,7 +25,6 @@ arm_ss.add(when: 'TARGET_AARCH64', if_false: files('stubs32.c'))
 
 arm_ss.add(files(
   'cpu32.c',
-  'translate.c',
   'm_helper.c',
   'mve_helper.c',
 ))
@@ -55,6 +54,10 @@ arm_common_ss.add(files(
 ))
 
 arm_common_system_ss.add(
+  decodetree.process('a32.decode', extra_args: '--static-decode=disas_a32'),
+  decodetree.process('a32-uncond.decode', extra_args: '--static-decode=disas_a32_uncond'),
+  decodetree.process('t32.decode', extra_args: '--static-decode=disas_t32'),
+  decodetree.process('t16.decode', extra_args: ['-w', '16', '--static-decode=disas_t16']),
   decodetree.process('vfp.decode', extra_args: '--decode=disas_vfp'),
   decodetree.process('vfp-uncond.decode', extra_args: '--decode=disas_vfp_uncond'),
   decodetree.process('mve.decode', extra_args: '--decode=disas_mve'),
@@ -71,6 +74,7 @@ arm_common_system_ss.add(
   'psci.c',
   'tlb_helper.c',
   'tlb-insns.c',
+  'translate.c',
   'translate-m-nocp.c',
   'translate-mve.c',
   'translate-neon.c',
@@ -84,6 +88,7 @@ arm_user_ss.add(files(
   'neon_helper.c',
   'op_helper.c',
   'tlb_helper.c',
+  'translate.c',
   'translate-m-nocp.c',
   'translate-mve.c',
   'translate-neon.c',
-- 
2.47.3


