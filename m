Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13E85FF8869
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 12:57:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHLUd-0000B8-TI; Mon, 27 Apr 2026 08:55:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHLO4-0008BO-SO
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 08:48:35 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHLNw-0005ic-IS
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 08:48:27 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-48334ee0aeaso107050985e9.1
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 05:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777294099; x=1777898899; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SJipAdayGX2WmDgNJX5wmrQEzJn24e51it/1vwkX3Wc=;
 b=E/5Uhj41hYMgHZgZiwdEoch0re3/CdhFcr0ImjNNuMcDfb5EPWrzI4jzz3k5CfuyGo
 DcWh9APqwo7jyuu0e7bECE4WPFTN9RiDJqMzC/vKP95p/P+5N+WleMpsphgrugx04cHM
 poHUvccowcx3dnXsX2tYMT2ZxYWIPkdbe73I2w3NOuklakSuPMbsuX0nACYeSfVKDyqr
 99mY5Bf+IrXHy4qNPtkSsgLd68Z/bU8zsxquMyLM7gyIwWDIEw0mUNLp6jxi5ZVJROok
 eMbzEKwuU2KJJp8vGrQel0QFUIxGY4mpAmFaCGvwCLdiuXqdWbOLkmfWHZV+30NnyY79
 gX2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777294099; x=1777898899;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=SJipAdayGX2WmDgNJX5wmrQEzJn24e51it/1vwkX3Wc=;
 b=PpUKJZoaGuCwErdsY3GjZMprtUIz+hze80W4hcn8WmkK6NeSd3YST/Z/9oZOK+HTPE
 3b4ZU9jT/JAIx0K2nTfJ2se3lxkbJjNkBCAz5KmN3zoWYbxukiFuVp3J09KXVuBM3s8L
 80ha5jwUPoZxBtf+Q+9opjh9jfmb5PNZpkuWO5UN1ZHOjXN2PjHYS2W7rAebu8p8Cmxq
 LpvBK1bbOqxQX5cy7m4X/QdLFEkDtQan0UWjUe0At+HLUXYZNS4Ogmcrzgm8vmDlPtN9
 Uy8oSszAJpfSpJZml1quUFualpUm4qpGm3nIGq8Vv58tJyHLpE6KD8dl7EkrV7HrkkQZ
 OBhg==
X-Gm-Message-State: AOJu0YwPQk5ihNwcQCa7WBuTnGNJxyWuQ2ZnBeOQvdnUjst7lc0fiZPm
 KE4w8oZALnxfMyNfyX7J+H0X5dGWNih3wkT9jec8lcHqPztliHOwJgZDEgsl+tbz1wFJlICmG4j
 2//VF
X-Gm-Gg: AeBDievF8E9VHZ7kv7mk7SieMeTELN8SU9BD1umk1cfON3Hm9/f+lvJ+zBuyQodm7oc
 22PsUelxfgOPRsFOdjL4nzcTWHO6bXs6fTwhZSTtMfx2fsoMwA3thFG5c/VCcQGUKCLkqqu5qTL
 mMNuqN8KyeRFScgyC0rQZH8Nyf289RJ/TY0lyHICfHQI5VrWEKbG6IhGa3TacPvfCsb2uyCoPkx
 BIoWsN50moY4wz7KDP4583KtSqfnWiV2JQGTH4C1lW7qFO4nakXXWD0SSrN+YcOoghrSHf1WUAL
 Uc1+QGMhJcanSc+GCrNsz7lHKNrjgjYPmliHQFHAAdpCxW1PA2DhVVi0rqzvbzk9uYagQ+AYdM1
 nghI3OAxj4pph5+9CR+tx+eF058Hf8IuHptiNxDO1Hv5eejlEesEAmV32LcIt1YtXOY4QvA4ohH
 VrPZ2ime5k1DpGaX5Iz/JQXzbBrgMe4I87z17b2Y3NLhbr3Q1zY9N9n0W//jX+X4VgBTuXOI0n0
 HbNFRCN22vQXP2sczpv3TVwmvXqBDzUmP9wjYMpSyjYt+AXNbWq
X-Received: by 2002:a05:600c:6296:b0:483:64b4:79da with SMTP id
 5b1f17b1804b1-488fb7923a9mr565782035e9.26.1777294098551; 
 Mon, 27 Apr 2026 05:48:18 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488ffc5e3f4sm448974115e9.2.2026.04.27.05.48.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 05:48:17 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 42/63] target/arm: migrate system/cp trap syndromes to
 registerfields
Date: Mon, 27 Apr 2026 13:47:16 +0100
Message-ID: <20260427124738.966578-43-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427124738.966578-1-peter.maydell@linaro.org>
References: <20260427124738.966578-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

From: Alex Bennée <alex.bennee@linaro.org>

Migrate syn_aa64_sysregtrap and co-processor register trap syndromes
to the registerfields API. The co-processor syndromes are split
between single and duel register moves.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20260422125250.1303100-3-alex.bennee@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/syndrome.h | 124 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 102 insertions(+), 22 deletions(-)

diff --git a/target/arm/syndrome.h b/target/arm/syndrome.h
index 517fb2368b..29462aa103 100644
--- a/target/arm/syndrome.h
+++ b/target/arm/syndrome.h
@@ -78,7 +78,7 @@ enum arm_exception_class {
 
 /* Generic syndrome encoding layout for HSR and lower 32 bits of ESR_EL2 */
 FIELD(SYNDROME, EC, 26, 6)
-FIELD(SYNDROME, IL, 25, 1)
+FIELD(SYNDROME, IL, 25, 1) /* IL=1 for 32 bit instructions */
 FIELD(SYNDROME, ISS, 0, 25)
 
 typedef enum {
@@ -172,7 +172,7 @@ static inline uint32_t syn_aa64_smc(uint32_t imm16)
 static inline uint32_t syn_aa32_svc(uint32_t imm16, bool is_16bit)
 {
     uint32_t res = syn_set_ec(0, EC_AA32_SVC);
-    res = FIELD_DP32(res, SYNDROME, IL, is_16bit ? 0 : 1);
+    res = FIELD_DP32(res, SYNDROME, IL, !is_16bit);
     res = FIELD_DP32(res, ISS_IMM16, IMM16, imm16);
     return res;
 }
@@ -203,58 +203,138 @@ static inline uint32_t syn_aa64_bkpt(uint32_t imm16)
 static inline uint32_t syn_aa32_bkpt(uint32_t imm16, bool is_16bit)
 {
     uint32_t res = syn_set_ec(0, EC_AA32_BKPT);
-    res = FIELD_DP32(res, SYNDROME, IL, is_16bit ? 0 : 1);
+    res = FIELD_DP32(res, SYNDROME, IL, !is_16bit);
     res = FIELD_DP32(res, ISS_IMM16, IMM16, imm16);
     return res;
 }
 
+/*
+ * ISS encoding for an exception from MSR, MRS, or System instruction
+ * in AArch64 state.
+ */
+FIELD(SYSREG_ISS, ISREAD, 0, 1) /* Direction, 1 is read */
+FIELD(SYSREG_ISS, CRM, 1, 4)
+FIELD(SYSREG_ISS, RT, 5, 5)
+FIELD(SYSREG_ISS, CRN, 10, 4)
+FIELD(SYSREG_ISS, OP1, 14, 3)
+FIELD(SYSREG_ISS, OP2, 17, 3)
+FIELD(SYSREG_ISS, OP0, 20, 2)
+
 static inline uint32_t syn_aa64_sysregtrap(int op0, int op1, int op2,
                                            int crn, int crm, int rt,
                                            int isread)
 {
-    return (EC_SYSTEMREGISTERTRAP << ARM_EL_EC_SHIFT) | ARM_EL_IL
-        | (op0 << 20) | (op2 << 17) | (op1 << 14) | (crn << 10) | (rt << 5)
-        | (crm << 1) | isread;
+    uint32_t res = syn_set_ec(0, EC_SYSTEMREGISTERTRAP);
+    res = FIELD_DP32(res, SYNDROME, IL, 1);
+
+    res = FIELD_DP32(res, SYSREG_ISS, OP0, op0);
+    res = FIELD_DP32(res, SYSREG_ISS, OP2, op2);
+    res = FIELD_DP32(res, SYSREG_ISS, OP1, op1);
+    res = FIELD_DP32(res, SYSREG_ISS, CRN, crn);
+    res = FIELD_DP32(res, SYSREG_ISS, RT, rt);
+    res = FIELD_DP32(res, SYSREG_ISS, CRM, crm);
+    res = FIELD_DP32(res, SYSREG_ISS, ISREAD, isread);
+
+    return res;
 }
 
+/*
+ * ISS encoding for an exception from an MCR or MRC access
+ * (move to/from co-processor)
+ */
+FIELD(COPROC_ISS, ISREAD, 0, 1)
+FIELD(COPROC_ISS, CRM, 1, 4)
+FIELD(COPROC_ISS, RT, 5, 5)
+FIELD(COPROC_ISS, CRN, 10, 4)
+FIELD(COPROC_ISS, OP1, 14, 3)
+FIELD(COPROC_ISS, OP2, 17, 3)
+FIELD(COPROC_ISS, COND, 20, 4)
+FIELD(COPROC_ISS, CV, 24, 1)
+
 static inline uint32_t syn_cp14_rt_trap(int cv, int cond, int opc1, int opc2,
                                         int crn, int crm, int rt, int isread,
                                         bool is_16bit)
 {
-    return (EC_CP14RTTRAP << ARM_EL_EC_SHIFT)
-        | (is_16bit ? 0 : ARM_EL_IL)
-        | (cv << 24) | (cond << 20) | (opc2 << 17) | (opc1 << 14)
-        | (crn << 10) | (rt << 5) | (crm << 1) | isread;
+    uint32_t res = syn_set_ec(0, EC_CP14RTTRAP);
+    res = FIELD_DP32(res, SYNDROME, IL, !is_16bit);
+
+    res = FIELD_DP32(res, COPROC_ISS, CV, cv);
+    res = FIELD_DP32(res, COPROC_ISS, COND, cond);
+    res = FIELD_DP32(res, COPROC_ISS, OP2, opc2);
+    res = FIELD_DP32(res, COPROC_ISS, OP1, opc1);
+    res = FIELD_DP32(res, COPROC_ISS, CRN, crn);
+    res = FIELD_DP32(res, COPROC_ISS, RT, rt);
+    res = FIELD_DP32(res, COPROC_ISS, CRM, crm);
+    res = FIELD_DP32(res, COPROC_ISS, ISREAD, isread);
+
+    return res;
 }
 
 static inline uint32_t syn_cp15_rt_trap(int cv, int cond, int opc1, int opc2,
                                         int crn, int crm, int rt, int isread,
                                         bool is_16bit)
 {
-    return (EC_CP15RTTRAP << ARM_EL_EC_SHIFT)
-        | (is_16bit ? 0 : ARM_EL_IL)
-        | (cv << 24) | (cond << 20) | (opc2 << 17) | (opc1 << 14)
-        | (crn << 10) | (rt << 5) | (crm << 1) | isread;
+    uint32_t res = syn_set_ec(0, EC_CP15RTTRAP);
+    res = FIELD_DP32(res, SYNDROME, IL, !is_16bit);
+
+    res = FIELD_DP32(res, COPROC_ISS, CV, cv);
+    res = FIELD_DP32(res, COPROC_ISS, COND, cond);
+    res = FIELD_DP32(res, COPROC_ISS, OP2, opc2);
+    res = FIELD_DP32(res, COPROC_ISS, OP1, opc1);
+    res = FIELD_DP32(res, COPROC_ISS, CRN, crn);
+    res = FIELD_DP32(res, COPROC_ISS, RT, rt);
+    res = FIELD_DP32(res, COPROC_ISS, CRM, crm);
+    res = FIELD_DP32(res, COPROC_ISS, ISREAD, isread);
+
+    return res;
 }
 
+/*
+ * ISS encoding for an exception from an MCRR or MRRC access
+ * (move to/from co-processor with 2 regs)
+ */
+FIELD(COPROC_R2_ISS, ISREAD, 0, 1)
+FIELD(COPROC_R2_ISS, CRM, 1, 4)
+FIELD(COPROC_R2_ISS, RT, 5, 5)
+FIELD(COPROC_R2_ISS, RT2, 10, 5)
+FIELD(COPROC_R2_ISS, OP1, 16, 4)
+FIELD(COPROC_R2_ISS, COND, 20, 4)
+FIELD(COPROC_R2_ISS, CV, 24, 1)
+
 static inline uint32_t syn_cp14_rrt_trap(int cv, int cond, int opc1, int crm,
                                          int rt, int rt2, int isread,
                                          bool is_16bit)
 {
-    return (EC_CP14RRTTRAP << ARM_EL_EC_SHIFT)
-        | (is_16bit ? 0 : ARM_EL_IL)
-        | (cv << 24) | (cond << 20) | (opc1 << 16)
-        | (rt2 << 10) | (rt << 5) | (crm << 1) | isread;
+    uint32_t res = syn_set_ec(0, EC_CP14RRTTRAP);
+    res = FIELD_DP32(res, SYNDROME, IL, !is_16bit);
+
+    res = FIELD_DP32(res, COPROC_R2_ISS, CV, cv);
+    res = FIELD_DP32(res, COPROC_R2_ISS, COND, cond);
+    res = FIELD_DP32(res, COPROC_R2_ISS, OP1, opc1);
+    res = FIELD_DP32(res, COPROC_R2_ISS, RT2, rt2);
+    res = FIELD_DP32(res, COPROC_R2_ISS, RT, rt);
+    res = FIELD_DP32(res, COPROC_R2_ISS, CRM, crm);
+    res = FIELD_DP32(res, COPROC_R2_ISS, ISREAD, isread);
+
+    return res;
 }
 
 static inline uint32_t syn_cp15_rrt_trap(int cv, int cond, int opc1, int crm,
                                          int rt, int rt2, int isread,
                                          bool is_16bit)
 {
-    return (EC_CP15RRTTRAP << ARM_EL_EC_SHIFT)
-        | (is_16bit ? 0 : ARM_EL_IL)
-        | (cv << 24) | (cond << 20) | (opc1 << 16)
-        | (rt2 << 10) | (rt << 5) | (crm << 1) | isread;
+    uint32_t res = syn_set_ec(0, EC_CP15RRTTRAP);
+    res = FIELD_DP32(res, SYNDROME, IL, !is_16bit);
+
+    res = FIELD_DP32(res, COPROC_R2_ISS, CV, cv);
+    res = FIELD_DP32(res, COPROC_R2_ISS, COND, cond);
+    res = FIELD_DP32(res, COPROC_R2_ISS, OP1, opc1);
+    res = FIELD_DP32(res, COPROC_R2_ISS, RT2, rt2);
+    res = FIELD_DP32(res, COPROC_R2_ISS, RT, rt);
+    res = FIELD_DP32(res, COPROC_R2_ISS, CRM, crm);
+    res = FIELD_DP32(res, COPROC_R2_ISS, ISREAD, isread);
+
+    return res;
 }
 
 static inline uint32_t syn_fp_access_trap(int cv, int cond, bool is_16bit,
-- 
2.43.0


