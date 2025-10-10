Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47333CCD185
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 13:23:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7CqO-0007Hb-Ti; Fri, 10 Oct 2025 09:07:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7CqE-00073N-2X
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:07:26 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7CpN-0003yz-29
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:07:25 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-45b4d89217aso11887055e9.2
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 06:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760101586; x=1760706386; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=AViFRxi1UR+n7HL/tuBoIgMWoi1XCZA3uxO+rhCMuxA=;
 b=prT1nzujF8FSUb1WmWOSoCkr2q/BYGOylNtNmJr2vNHbH4oumzyJfsZLNOsG4F4bRB
 sqxwtfLGzf3+bPz+zcIx3geyZxsY4B+lQAC6LB59I2CDrWnj8783ksRmpycRAwMV/sVV
 lw4/UfFfarAI+DLw1R9h6lAGBlixAjLgRPZSvTmmr1623QI2mwllg+d5kNpZgHRU6mqw
 u32sjOOiVhiirxk6fH2NJwHNB4LJGoX2C6Cy9sWD/dB5razopNdf5sygWQNPM7mjIHy1
 hB+AYGr3Nk+7tYbwa+eWv+CYlx7VfBS/n0wY/h9XBRi9r23udcd3D9b6cGJb3ML2LPNv
 UxBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760101586; x=1760706386;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AViFRxi1UR+n7HL/tuBoIgMWoi1XCZA3uxO+rhCMuxA=;
 b=xAdF54+t3jJ7nJpAUloYjDKbUk/PSs6tGDQW52rwgByAba6RlZA1blg35I1P7Hj874
 TL22CAgLHx3zoHGJ5+5thX//2OxNaXE1piSIEU2COlt29Kr5zztv+ewZOFfqJ7Cd1POx
 TVG/a6k5TG3IitoyS+GdKbelK/h+xSiXVQ5xmJjre5sBLXFnIuXu2PQPnU0lf/0TKLLo
 OTLfAK5A7in2HbvhgQ+22isyynQtIEW0G29hUU7ILvgyQYq4+P1Tie/6Hy2o5g7GjPhv
 HkxI1Ay/uLrPtKars1MH2JtStlGnjH2k8FwIes+MT6ccNAd6hwl9fgMom2RWLt+1uUfr
 NDrw==
X-Gm-Message-State: AOJu0Yz2XPPeVpaNrHnm1Z+xfCUt6zgl7vw1JQYz4pSGjEwM1KuF31tQ
 mZJN5OO7jC57siTqnKNEpbjD/n3CVXZgsSOqqBai5UZk/CM2zKMzrbBqst/nNEhOfS3vWppuqvD
 Z29cv
X-Gm-Gg: ASbGncvAMZz8+6c0oUwGwQar7RI+6/Uq2LM6rjhneHZ8JZsUSJLbq1jt9tn7oZuaFw2
 wj+Zu8NMEzBEy/w8OXnDR4hl5o/fGyVl0RFVUvF9HXbov1FLrVsMZWXIBXZO2GJan5yC3kYtMDz
 Rm+Cx60NhxXR6wAtK1Bi7LmgUmme8xoUkTHmDEbcUBvIm/h0Wm8cHKv23smpXTOqSMZJmLf79DE
 udF+l1gTn/XKYYelrp/dcTRPcbRNbUMh5Zf1FOnz1ukd8Rv560YrWBHTyQjJPMa7lR4w3ynYL6U
 sVp7XAtUVkcI+bHwXEHgyz4sN+uGj30tgV/mhITxtvJdD4jY5KBIzKYn8TjHf/XPdcDKzGuqycD
 v6dtwfDNcMyp8Hn5LtF99sCTUr06LOuRIeHfYhuCWlxfohzh99O42aDrmVPtERQ==
X-Google-Smtp-Source: AGHT+IFB8+oPxhywWbh6wl8XpF3RMU9rqXGFd2H4xK4EXOwxS6nbiwoiyzq+nW6GGfYqTdEVbFSmSA==
X-Received: by 2002:a05:600c:1389:b0:46e:4be1:a423 with SMTP id
 5b1f17b1804b1-46fa9a8f9d8mr75401295e9.1.1760101586236; 
 Fri, 10 Oct 2025 06:06:26 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce583316sm4221657f8f.20.2025.10.10.06.06.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 06:06:25 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 50/76] target/arm: Implement GCSPUSHX
Date: Fri, 10 Oct 2025 14:05:01 +0100
Message-ID: <20251010130527.3921602-51-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251010130527.3921602-1-peter.maydell@linaro.org>
References: <20251010130527.3921602-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20251008215613.300150-51-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpregs.h            |  2 ++
 target/arm/cpregs-gcs.c        | 17 ++++++++++++++++
 target/arm/tcg/translate-a64.c | 37 ++++++++++++++++++++++++++++++++++
 3 files changed, 56 insertions(+)

diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
index 81d8f0e32b1..909916b7fd7 100644
--- a/target/arm/cpregs.h
+++ b/target/arm/cpregs.h
@@ -50,6 +50,7 @@ enum {
     /* Special: gcs instructions */
     ARM_CP_GCSPUSHM              = 0x0008,
     ARM_CP_GCSPOPM               = 0x0009,
+    ARM_CP_GCSPUSHX              = 0x000a,
 
     /* Flag: reads produce resetvalue; writes ignored. */
     ARM_CP_CONST                 = 1 << 4,
@@ -875,6 +876,7 @@ typedef enum FGTBit {
     DO_BIT(HFGITR, CPPRCTX),
     DO_BIT(HFGITR, DCCVAC),
     DO_REV_BIT(HFGITR, NGCSPUSHM_EL1),
+    DO_REV_BIT(HFGITR, NGCSEPP),
     DO_BIT(HFGITR, ATS1E1A),
 } FGTBit;
 
diff --git a/target/arm/cpregs-gcs.c b/target/arm/cpregs-gcs.c
index 15d383b2a41..e6c7025d02a 100644
--- a/target/arm/cpregs-gcs.c
+++ b/target/arm/cpregs-gcs.c
@@ -53,6 +53,19 @@ static CPAccessResult access_gcspushm(CPUARMState *env, const ARMCPRegInfo *ri,
     return CP_ACCESS_OK;
 }
 
+static CPAccessResult access_gcspushx(CPUARMState *env, const ARMCPRegInfo *ri,
+                                      bool isread)
+{
+    /* Trap if lock taken, and enabled. */
+    if (!(env->pstate & PSTATE_EXLOCK)) {
+        int el = arm_current_el(env);
+        if (env->cp15.gcscr_el[el] & GCSCR_EXLOCKEN) {
+            return CP_ACCESS_EXLOCK;
+        }
+    }
+    return CP_ACCESS_OK;
+}
+
 static const ARMCPRegInfo gcs_reginfo[] = {
     { .name = "GCSCRE0_EL1", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 0, .crn = 2, .crm = 5, .opc2 = 2,
@@ -103,6 +116,10 @@ static const ARMCPRegInfo gcs_reginfo[] = {
     { .name = "GCSPOPM", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 3, .crn = 7, .crm = 7, .opc2 = 1,
       .access = PL0_R, .type = ARM_CP_GCSPOPM },
+    { .name = "GCSPUSHX", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 7, .opc2 = 4,
+      .access = PL1_W, .accessfn = access_gcspushx, .fgt = FGT_NGCSEPP,
+      .type = ARM_CP_GCSPUSHX },
 };
 
 void define_gcs_cpregs(ARMCPU *cpu)
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 7783273cc1d..0df1916d28a 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2539,6 +2539,35 @@ static void gen_gcspopm(DisasContext *s, int rt)
     tcg_gen_mov_i64(cpu_reg(s, rt), value);
 }
 
+static void gen_gcspushx(DisasContext *s)
+{
+    TCGv_i64 gcspr = cpu_gcspr[s->current_el];
+    int spsr_idx = aarch64_banked_spsr_index(s->current_el);
+    int spsr_off = offsetof(CPUARMState, banked_spsr[spsr_idx]);
+    int elr_off = offsetof(CPUARMState, elr_el[s->current_el]);
+    int mmuidx = core_gcs_mem_index(s->mmu_idx);
+    MemOp mop = finalize_memop(s, MO_64 | MO_ALIGN);
+    TCGv_i64 addr = tcg_temp_new_i64();
+    TCGv_i64 tmp = tcg_temp_new_i64();
+
+    tcg_gen_addi_i64(addr, gcspr, -8);
+    tcg_gen_qemu_st_i64(cpu_reg(s, 30), addr, mmuidx, mop);
+
+    tcg_gen_ld_i64(tmp, tcg_env, spsr_off);
+    tcg_gen_addi_i64(addr, addr, -8);
+    tcg_gen_qemu_st_i64(tmp, addr, mmuidx, mop);
+
+    tcg_gen_ld_i64(tmp, tcg_env, elr_off);
+    tcg_gen_addi_i64(addr, addr, -8);
+    tcg_gen_qemu_st_i64(tmp, addr, mmuidx, mop);
+
+    tcg_gen_addi_i64(addr, addr, -8);
+    tcg_gen_qemu_st_i64(tcg_constant_i64(0b1001), addr, mmuidx, mop);
+
+    tcg_gen_mov_i64(gcspr, addr);
+    clear_pstate_bits(PSTATE_EXLOCK);
+}
+
 /*
  * Look up @key, returning the cpreg, which must exist.
  * Additionally, the new cpreg must also be accessible.
@@ -2856,6 +2885,14 @@ static void handle_sys(DisasContext *s, bool isread,
             gen_gcspopm(s, rt);
         }
         return;
+    case ARM_CP_GCSPUSHX:
+        /* Choose the CONSTRAINED UNPREDICTABLE for UNDEF. */
+        if (rt != 31) {
+            unallocated_encoding(s);
+        } else if (s->gcs_en) {
+            gen_gcspushx(s);
+        }
+        return;
     default:
         g_assert_not_reached();
     }
-- 
2.43.0


