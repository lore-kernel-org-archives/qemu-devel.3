Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30540CD6E40
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 14:33:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRsmo-00014t-Ij; Tue, 26 May 2026 10:29:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRsmn-000130-9y
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:29:37 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRsml-0001Rm-LN
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:29:37 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-45ea19f412aso3138007f8f.3
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 07:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779805774; x=1780410574; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=an/pRd0B8ExZfKcqRxxMey7eyeY7kyVhiyHPw5sPgYQ=;
 b=Ebqe/7sMglHnSiRbc2NVRVHZI2IEPDV/ciXXDCD9Ab+P0V07lStowOppTLwcMTyGpr
 BDVL9j6R867hXR+URIB/nz68rlQ/l7Q2ZzMf5bGKjB8Xuw0SjiZIIMAwhIp6zFQwCo7l
 4LJ+o2lae1j8bP6R6ewJFZSlQZejf7O877FLHQEGbp+DLg6TIh+4FBjZczCwojAbjs1q
 f0BQRBlPmO7Sbw3nOUkdY6vsyx8T2ZyN+hTrf+vOrujDPNOOTAlZOI0Ratlnx4wKve6t
 ttzx5Tj4ajTxYjx3MTvI/hQ7mxum4OO0g9df81rPAd0GCA3kx0qHpEOOBv5c5RFktvQo
 yn5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779805774; x=1780410574;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=an/pRd0B8ExZfKcqRxxMey7eyeY7kyVhiyHPw5sPgYQ=;
 b=IP4arqlHg3XFL6gmIdrqvgiR0ZZLapaHbsYkI8SHqwBWx9+5bszN4euDNfjIqOh9y8
 4Z3k5eG3y3wVAecHzRgzX7HfqJNz0WpVyyEfrixdSOBhJiygPLS7M9K6o49Xgm3ErSTt
 fRUd7HjZhYUloVNb5aecYWlpqOI5z4nMR+ROGCMYsfxZp0fq4FtXVc3lCkBcBe7yhisf
 w13R6cywUSmiR5W9qwpghVUWJw9EipWwOlRSlrwhWfEy/W6PiS5Uh1J7dsSw1JW2qCp5
 FB7a1b96tsm+6kAvCq2b1Qb7j2NyJvXciai8Zds3qth7YswGvhqc235zIcsZd6EsC0vE
 7Tfw==
X-Gm-Message-State: AOJu0YzS0WVT3ef567t9KXIIcVrRLXa1zL1Wodg23YIBkq7N0j19mmNM
 B1DBF/SBN8kG0L5EGZOpB/Q0+R63Ks4fi35Dzz9IcgWkXY+ldJYD5JEX147WWdIGIpR4xSXaW87
 +luva
X-Gm-Gg: Acq92OGs/0JtJzAv7EmsHqULwucxX/FOqt0GNRoI+kkSPl2BnN31ayMfNTwblLFTKwW
 O8+LFchKcuPr6VkY7+EC4Dw7gjjGt0fnLPIcTL4UBw5fZ2JYaP8ddsTwJ11Ao/ORJ2SqT61iMDG
 eCQtS67KrxpjcvEm/qChXDtcUAn/CK3CH+3ZXab8wYFR28U+CR8SIDICe9+kbPvi4yO+vxMHX85
 e2bUSiVM2CEfz5jo9PPwMYNUInl644QJai0OrX+mbXHE2krcqsCTiCjPUts2jEw3muw2qKokHL0
 tk3V7meqBpxYFLDUAXlutnpWzlupS+ClfUiOH8oyZ/XvxENfYobYh7gmQYMt90K+Y76jrfqqn6+
 1ayIjfk5kVMEECpSTvd08WWHP3i06yQTDiGOkzZLv7fSrDXbAypcY8bi8ICmbz3ZbTNCxXscWIq
 2S4KhPWOsMd2fN3W1WJWB9yuyq/P20H1gY/0cxjDxKBTaicApovI+Jpq7NmG0iB7/iMEcpGK+Y6
 GsNxNUBDrnts2rBksq/jJt1pUtktoc=
X-Received: by 2002:a05:6000:41e3:b0:43d:50c:6f18 with SMTP id
 ffacd0b85a97d-45eb38a1687mr26532795f8f.11.1779805774173; 
 Tue, 26 May 2026 07:29:34 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6d70c51sm38325225f8f.36.2026.05.26.07.29.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 07:29:33 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 43/54] target/arm: Add FPMR_EL to TBFLAGS
Date: Tue, 26 May 2026 15:28:39 +0100
Message-ID: <20260526142850.2326589-44-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526142850.2326589-1-peter.maydell@linaro.org>
References: <20260526142850.2326589-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Prepare to perform access checks for direct and
indirect uses of FPMR.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260522220306.235200-13-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h               |  1 +
 target/arm/tcg/hflags.c        | 42 ++++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-a64.c |  1 +
 target/arm/tcg/translate.h     |  2 ++
 4 files changed, 46 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index e9e261eb2a..2a93de4132 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2567,6 +2567,7 @@ FIELD(TBFLAG_A64, ZT0EXC_EL, 39, 2)
 FIELD(TBFLAG_A64, GCS_EN, 41, 1)
 FIELD(TBFLAG_A64, GCS_RVCEN, 42, 1)
 FIELD(TBFLAG_A64, GCSSTR_EL, 43, 2)
+FIELD(TBFLAG_A64, FPMR_EL, 45, 2)
 
 /*
  * Helpers for using the above. Note that only the A64 accessors use
diff --git a/target/arm/tcg/hflags.c b/target/arm/tcg/hflags.c
index 7e6f8d3647..794cdf00b2 100644
--- a/target/arm/tcg/hflags.c
+++ b/target/arm/tcg/hflags.c
@@ -237,6 +237,44 @@ static int zt0_exception_el(CPUARMState *env, int el)
     return 0;
 }
 
+/*
+ * Return the exception level to which exceptions should be taken for FPMR.
+ * Compare the EnFPM bits in the "Accessing FPMR" pseudocode.  Note that
+ * the floating-point enabled check will be handled separately.
+ */
+static int fpmr_exception_el(CPUARMState *env, int el)
+{
+    switch (el) {
+    case 0:
+        if (el_is_in_host(env, 0)) {
+            if (!(env->cp15.sctlr_el[2] & SCTLR_EnFPM)) {
+                return 2;
+            }
+            break;
+        }
+        if (!(env->cp15.sctlr_el[1] & SCTLR_EnFPM)) {
+            return 1;
+        }
+        /* fall through */
+    case 1:
+        if (!(arm_hcrx_el2_eff(env) & HCRX_ENFPM)) {
+            return 2;
+        }
+        break;
+    case 2:
+        break;
+    case 3:
+        return 0;
+    default:
+        g_assert_not_reached();
+    }
+    if (arm_feature(env, ARM_FEATURE_EL3)
+        && !(env->cp15.scr_el3 & SCR_ENFPM)) {
+        return 3;
+    }
+    return 0;
+}
+
 static CPUARMTBFlags rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
                                         ARMMMUIdx mmu_idx)
 {
@@ -500,6 +538,10 @@ static CPUARMTBFlags rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
         }
     }
 
+    if (cpu_isar_feature(aa64_fpmr, env_archcpu(env))) {
+        DP_TBFLAG_A64(flags, FPMR_EL, fpmr_exception_el(env, el));
+    }
+
     return rebuild_hflags_common(env, fp_el, mmu_idx, flags);
 }
 
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index b5f953ab0a..d1a581acfd 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -10723,6 +10723,7 @@ static void aarch64_tr_init_disas_context(DisasContextBase *dcbase,
     dc->gcs_en = EX_TBFLAG_A64(tb_flags, GCS_EN);
     dc->gcs_rvcen = EX_TBFLAG_A64(tb_flags, GCS_RVCEN);
     dc->gcsstr_el = EX_TBFLAG_A64(tb_flags, GCSSTR_EL);
+    dc->fpmr_el = EX_TBFLAG_A64(tb_flags, FPMR_EL);
     dc->vec_len = 0;
     dc->vec_stride = 0;
     dc->cp_regs = arm_cpu->cp_regs;
diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index 2a586321c8..d4bcc5bad4 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -199,6 +199,8 @@ typedef struct DisasContext {
     uint8_t gm_blocksize;
     /* True if the current insn_start has been updated. */
     bool insn_start_updated;
+    /* FPMR access exception EL or 0 if enabled. */
+    uint8_t fpmr_el;
     /* Offset from VNCR_EL2 when FEAT_NV2 redirects this reg to memory */
     uint32_t nv2_redirect_offset;
 } DisasContext;
-- 
2.43.0


