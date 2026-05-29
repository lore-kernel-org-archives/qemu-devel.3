Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E56ECD5BD2
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 08:30:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSsbb-0001eG-8C; Fri, 29 May 2026 04:30:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wSsbP-0001QE-1Y
 for qemu-devel@nongnu.org; Fri, 29 May 2026 04:29:59 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wSsbM-0005SI-Ft
 for qemu-devel@nongnu.org; Fri, 29 May 2026 04:29:58 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-49048e043e5so58567195e9.1
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 01:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780043395; x=1780648195; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=icgEPrF2PyrBaUqEkggw3Y3TmAdUSPZeT980MGVssa8=;
 b=qftbTid84zn7a1WAe8r07b1eU5mS/dWGYqIphyb8PR0Jnmtwzr386QqGCXdevS1yuF
 mBQncINz7AP6L9pVeIYuzNz1tgQnNoyOcD5EuVkYXD6s4C1OwJl49iqPbRz+ZFTQW5n1
 kgkDRAWxSqGdsI3KGDmcwk8ZUoIHWwHoUblmSb88iLc+N2HyBkj/HOhuWU/UHQUwGbIC
 fwuz3/bgRPxOvPEsdEQh6HsoMEnGn1AbvWAUEquSGiQUmCMFNbjswUN7QgtJIx/6EJAC
 P4KpdctgvVf4OQKvhgJvBqwyOFby9iWD04jfD8D2lSXlFcKls0vyLNyNNSsziupA6XA/
 P/nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780043395; x=1780648195;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=icgEPrF2PyrBaUqEkggw3Y3TmAdUSPZeT980MGVssa8=;
 b=TOvOi8ReVNvglPkqsZD1ANq85Eez0se6Yy5d2u4/qP631KnOkeW08cVfpVKjfmgmbi
 FXhTQMx2nvXdHAHBOmodbr+mcvn/v05ZUKJPeRFRXEHyJFmbJNchv5aS92u7kPC2p7Mk
 1wvsDngkHzRzmHM5t6BlDZ5lkEkLajNR2YKPszFdWz+wM1DD82Vjb40DACySELNR9Um/
 ADZDsuFZc3n1FdheVfyjyV8Hjyy3OI0y2Z3kQd6P1DB+Jzlh+Nc1kK+g1yBuMZJH4D+Q
 BYIvnYv/zQ8cK90nY7SlwOLPMNF45mLnIo7tdPAz4o+dCGl+rXIATZg6Swi1Wd4crlMn
 V51A==
X-Gm-Message-State: AOJu0YzPbSRrS1JgRGt7P8b3FzlXhlCYoYGxoojx9IR1bkbKo/cR5n2u
 E2pTXdVVoDQamvflFUZz+NclcdJ6YIYKt/SvdRCzE2/ONhM2eA/qmPX+RwXRfxRT4NbWaL121Vf
 mqE4g
X-Gm-Gg: Acq92OHw0uVh6ytWsd/jlmDCM9cDM04FpJREyfIarkKvt9tDYEca4VgqoZAEbkZVIdd
 oxKvEiN68ft4ZohvE6vslBbTLjBbF4uj4UyFSTeVhUEavGM4sfpnTTNexNylnAys7oaXp4sr3oF
 KcG2acff+pqhd8eg2VEp3CD5gpGjlRW3XIQf7WojoELnigLIkSG+ajedRpGQGEy5X44rwb/0EHy
 3+UM0Tm3hl40G2EEy45s+yTd4txuKijEMLDK4exi0Iu/pu3lvt9gxQVGpHS+0jRsaKExoTxzUmO
 59IEDNK9XWjn2PEiexX/D7nwDNjewCNHnAHV8ULO2B0LvMaexGtKFkCZ7OHmdcKKx/+fkql3MpW
 rZ7i/zez6glAdGR22MTcwFmpcNePNmUh6RiVR8e/1pbra+v/c7Ll+s27t2xUGLoUu1jI3/p8DvE
 3wcFxntY58gTMMJI28QRhiGmI/HIVB7EXjXA==
X-Received: by 2002:a05:600c:644:b0:485:9a50:3370 with SMTP id
 5b1f17b1804b1-4909c07b4c7mr20113755e9.8.1780043394760; 
 Fri, 29 May 2026 01:29:54 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909c0498e0sm12827755e9.0.2026.05.29.01.29.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 01:29:52 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E1C3160E17;
 Fri, 29 May 2026 09:29:48 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>, qemu-arm@nongnu.org,
 kvm@vger.kernel.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v7 7/8] target/arm: handle the WFE trap case
Date: Fri, 29 May 2026 09:29:46 +0100
Message-ID: <20260529082948.363931-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260529082948.363931-1-alex.bennee@linaro.org>
References: <20260529082948.363931-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
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

Now WFE can actually suspend on A-profile we also need to handle when
its trapped. To do this we need to pass the instruction size so we can
deal with the is_16bit syndrome encoding.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v6
  - defer calculating target_el until after the early return
---
 target/arm/tcg/helper-defs.h   |  2 +-
 target/arm/tcg/op_helper.c     | 16 +++++++++++++++-
 target/arm/tcg/translate-a64.c |  2 +-
 target/arm/tcg/translate.c     |  2 +-
 4 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/target/arm/tcg/helper-defs.h b/target/arm/tcg/helper-defs.h
index a05f2258f29..ebdf09be38a 100644
--- a/target/arm/tcg/helper-defs.h
+++ b/target/arm/tcg/helper-defs.h
@@ -54,7 +54,7 @@ DEF_HELPER_2(exception_swstep, noreturn, env, i32)
 DEF_HELPER_2(exception_pc_alignment, noreturn, env, vaddr)
 DEF_HELPER_1(setend, void, env)
 DEF_HELPER_2(wfi, void, env, i32)
-DEF_HELPER_1(wfe, void, env)
+DEF_HELPER_2(wfe, void, env, i32)
 DEF_HELPER_2(wfit, void, env, i32)
 DEF_HELPER_1(yield, void, env)
 DEF_HELPER_1(pre_hvc, void, env)
diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index b803c9bf162..060b155d559 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -574,7 +574,7 @@ static int64_t gt_calc_next_event_stream(CPUARMState *env)
 }
 #endif
 
-void HELPER(wfe)(CPUARMState *env)
+void HELPER(wfe)(CPUARMState *env, uint32_t insn_len)
 {
 #ifdef CONFIG_USER_ONLY
     /*
@@ -592,11 +592,25 @@ void HELPER(wfe)(CPUARMState *env)
      */
     CPUState *cs = env_cpu(env);
     ARMCPU *cpu = env_archcpu(env);
+    uint32_t excp;
+    int target_el;
 
     if (qatomic_xchg(&env->event_register, false)) {
         return;
     }
 
+    /* We might sleep, so now we check to see if we should trap */
+    target_el = check_wfx_trap(env, true, &excp);
+    if (target_el) {
+        if (env->aarch64) {
+            env->pc -= insn_len;
+        } else {
+            env->regs[15] -= insn_len;
+        }
+        raise_exception(env, excp, syn_wfx(1, 0xe, 0, false, WFE, insn_len == 2),
+                        target_el);
+    }
+
     /*
      * If the CPU has entered the exclusive region we could sleep
      * until the global monitor moves from Exclusive to Open Access.
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index ec03eaa3bbd..a4603e1a5c7 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -10961,7 +10961,7 @@ static void aarch64_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
          */
         case DISAS_WFE:
             gen_a64_update_pc(dc, 4);
-            gen_helper_wfe(tcg_env);
+            gen_helper_wfe(tcg_env, tcg_constant_i32(4));
             tcg_gen_exit_tb(NULL, 0);
             break;
         case DISAS_WFI:
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index c10cc382d15..1f554f6c271 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -6836,7 +6836,7 @@ static void arm_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
             tcg_gen_exit_tb(NULL, 0);
             break;
         case DISAS_WFE:
-            gen_helper_wfe(tcg_env);
+            gen_helper_wfe(tcg_env, tcg_constant_i32(curr_insn_len(dc)));
             /*
              * The helper can return if the event register is set, so we
              * must go back to the main loop to check for events.
-- 
2.47.3


