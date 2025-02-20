Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2DBEC021B3
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 16:25:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl9JC-00072c-JD; Thu, 20 Feb 2025 11:21:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tl9J6-0006sf-TQ
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 11:21:48 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tl9J1-0008CT-T3
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 11:21:48 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4394a0c65fcso11713105e9.1
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 08:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740068502; x=1740673302; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WXhcf1svvtmVhYSlqVkD149sn18LK6naiEs3ZchXWvo=;
 b=O/rBfSVfBrEZfCrU8ODNiTRgfAGVmSFtBLI4d9gFOvkf3t0eoejv6x0vnLozYKMAW9
 k3cDWX5QW8zl12VIDuKmKUczTJZqm7+lG9uEKTEcHeC3aPCvun/XMU57MnE+dLQsmHkM
 sA/krD9XCN9fOs+0IifCDgh/sDxGAlPalVgDiB7BnTBtlPv2liI37bhnoF+LszqjUJjK
 IMEChqDOykMD3dtBPhxYM9d+egZjSBwDGqti7SHWZ3RIJ9O3rh3zinnDbCu+0CiZbwbK
 IZUon46PDTo/rRLwg+7L8jJY1EieWllyG+/VeZCAXlK00xwnMWOCXa8IUYBN3hl/9nCr
 RFew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740068502; x=1740673302;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WXhcf1svvtmVhYSlqVkD149sn18LK6naiEs3ZchXWvo=;
 b=wSp5EeRjMIR9Mdb+ktmQvWk6crXRqeBMh2qTD81VxluTw+bsY1zFp3KZLikVO2rzVg
 08bCWY6LmzdV/x4Otg2syYwfAZQbd9hfEUySc2em3wn3bBgaw6YEN9HbikNTk3+gXZsZ
 QCQqpW19QnI3AwXyFObZccxwtBOHHo04NeHehXDCUwOEa/4noH82SW9XMgxLJlkB3EUr
 n4SBq8sRCDX628uxISMP6g3IKlqqykpNH0M92n3mYZ8a1K3U/Knyjpq9Gm6q1U1orjgY
 NuToL/m65g2uOtrw19Pt/sGGPMtddukdYjZTHLDn+Kr11HJP01SmY2CXEoXrerhiCiCI
 CAew==
X-Gm-Message-State: AOJu0YyWRm7BLJ52HnvIId0fQdy3KCDQIuVFRgfvMdJ1Wubk+hfecvDG
 zyMx1XmhHJ4uRkQDWtJ5DdPS5CJriM2qEE7RFsAHbYZgD1dNSfBIzCfQF2da72gwobrWcv9wArQ
 X
X-Gm-Gg: ASbGncuHutlzDNF2kGC+ZAdGif8HAgsaMTPfDnK9gVGvzT5mIeFbeHO7foN5hx361G7
 yNupW/Uols4yxCePOo0RQQLY+iKDpWYakbS0oxJJ8aarI85U4Ba6CTORKbnMWG3ZUKH7wC40quQ
 rasYNowZVgPS40rQ6C3LNKaiCdPL4/8ehaWIiU1PFSSWvrzxl0X0E3dhkklunleB/tgU3rfQJmr
 sghLHKTjbjPQyFVVqJaVcDorsSJALlbZlMZdyw1we59e0Js/rYJHdtspgLKQrVB6NjaTqnTq3FT
 lQSCWTEG2Ffo8mOj0aNchA==
X-Google-Smtp-Source: AGHT+IG7GbpDWG0R43pckkpMtmSi73Ti7O0CqnwCRKBLDKiy2w+QQaYpZ0h7W/ypYaHwukZdmDOvBg==
X-Received: by 2002:a05:600c:4e87:b0:439:9274:81cd with SMTP id
 5b1f17b1804b1-439927484b2mr131345515e9.4.1740068502488; 
 Thu, 20 Feb 2025 08:21:42 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4399d55fc1asm48806415e9.35.2025.02.20.08.21.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 08:21:41 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/41] target/arm: Rename CP_ACCESS_TRAP_UNCATEGORIZED to
 CP_ACCESS_UNDEFINED
Date: Thu, 20 Feb 2025 16:20:54 +0000
Message-ID: <20250220162123.626941-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250220162123.626941-1-peter.maydell@linaro.org>
References: <20250220162123.626941-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

CP_ACCESS_TRAP_UNCATEGORIZED is technically an accurate description
of what this return value from a cpreg accessfn does, but it's liable
to confusion because it doesn't match how the Arm ARM pseudocode
indicates this case. What it does is an EXCP_UDEF with a zero
("uncategorized") syndrome value, which is what an UNDEFINED instruction
does. The pseudocode uses "UNDEFINED" to show this; rename our
constant to CP_ACCESS_UNDEFINED to make the parallel clearer.

Commit created with
sed -i -e 's/CP_ACCESS_TRAP_UNCATEGORIZED/CP_ACCESS_UNDEFINED/' $(git grep -l CP_ACCESS_TRAP_UNCATEGORIZED)

plus manual editing of the comment.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250130182309.717346-14-peter.maydell@linaro.org
---
 target/arm/cpregs.h        |  5 +++--
 target/arm/helper.c        | 30 +++++++++++++++---------------
 target/arm/tcg/op_helper.c |  6 +++---
 3 files changed, 21 insertions(+), 20 deletions(-)

diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
index fb3b84baa1e..52377c6eb50 100644
--- a/target/arm/cpregs.h
+++ b/target/arm/cpregs.h
@@ -337,13 +337,14 @@ typedef enum CPAccessResult {
     CP_ACCESS_TRAP_EL3 = CP_ACCESS_TRAP_BIT | 3,
 
     /*
-     * Access fails and results in an exception syndrome 0x0 ("uncategorized").
+     * Access fails with UNDEFINED, i.e. an exception syndrome 0x0
+     * ("uncategorized"), which is what an undefined insn produces.
      * Note that this is not a catch-all case -- the set of cases which may
      * result in this failure is specifically defined by the architecture.
      * This trap is always to the usual target EL, never directly to a
      * specified target EL.
      */
-    CP_ACCESS_TRAP_UNCATEGORIZED = (2 << 2),
+    CP_ACCESS_UNDEFINED = (2 << 2),
 } CPAccessResult;
 
 /* Indexes into fgt_read[] */
diff --git a/target/arm/helper.c b/target/arm/helper.c
index aacb53d31a2..71dead7241b 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -285,7 +285,7 @@ static CPAccessResult access_el3_aa32ns(CPUARMState *env,
 {
     if (!is_a64(env) && arm_current_el(env) == 3 &&
         arm_is_secure_below_el3(env)) {
-        return CP_ACCESS_TRAP_UNCATEGORIZED;
+        return CP_ACCESS_UNDEFINED;
     }
     return CP_ACCESS_OK;
 }
@@ -310,7 +310,7 @@ static CPAccessResult access_trap_aa32s_el1(CPUARMState *env,
         return CP_ACCESS_TRAP_EL3;
     }
     /* This will be EL1 NS and EL2 NS, which just UNDEF */
-    return CP_ACCESS_TRAP_UNCATEGORIZED;
+    return CP_ACCESS_UNDEFINED;
 }
 
 /*
@@ -2246,7 +2246,7 @@ static CPAccessResult gt_cntfrq_access(CPUARMState *env, const ARMCPRegInfo *ri,
         if (!isread && ri->state == ARM_CP_STATE_AA32 &&
             arm_is_secure_below_el3(env)) {
             /* Accesses from 32-bit Secure EL1 UNDEF (*not* trap to EL3!) */
-            return CP_ACCESS_TRAP_UNCATEGORIZED;
+            return CP_ACCESS_UNDEFINED;
         }
         break;
     case 2:
@@ -2255,7 +2255,7 @@ static CPAccessResult gt_cntfrq_access(CPUARMState *env, const ARMCPRegInfo *ri,
     }
 
     if (!isread && el < arm_highest_el(env)) {
-        return CP_ACCESS_TRAP_UNCATEGORIZED;
+        return CP_ACCESS_UNDEFINED;
     }
 
     return CP_ACCESS_OK;
@@ -2385,7 +2385,7 @@ static CPAccessResult gt_stimer_access(CPUARMState *env,
     switch (arm_current_el(env)) {
     case 1:
         if (!arm_is_secure(env)) {
-            return CP_ACCESS_TRAP_UNCATEGORIZED;
+            return CP_ACCESS_UNDEFINED;
         }
         if (!(env->cp15.scr_el3 & SCR_ST)) {
             return CP_ACCESS_TRAP_EL3;
@@ -2393,7 +2393,7 @@ static CPAccessResult gt_stimer_access(CPUARMState *env,
         return CP_ACCESS_OK;
     case 0:
     case 2:
-        return CP_ACCESS_TRAP_UNCATEGORIZED;
+        return CP_ACCESS_UNDEFINED;
     case 3:
         return CP_ACCESS_OK;
     default:
@@ -3304,7 +3304,7 @@ static CPAccessResult ats_access(CPUARMState *env, const ARMCPRegInfo *ri,
                 }
                 return CP_ACCESS_TRAP_EL3;
             }
-            return CP_ACCESS_TRAP_UNCATEGORIZED;
+            return CP_ACCESS_UNDEFINED;
         }
     }
     return CP_ACCESS_OK;
@@ -3601,7 +3601,7 @@ static CPAccessResult at_e012_access(CPUARMState *env, const ARMCPRegInfo *ri,
      * scr_write() ensures that the NSE bit is not set otherwise.
      */
     if ((env->cp15.scr_el3 & (SCR_NSE | SCR_NS)) == SCR_NSE) {
-        return CP_ACCESS_TRAP_UNCATEGORIZED;
+        return CP_ACCESS_UNDEFINED;
     }
     return CP_ACCESS_OK;
 }
@@ -3611,7 +3611,7 @@ static CPAccessResult at_s1e2_access(CPUARMState *env, const ARMCPRegInfo *ri,
 {
     if (arm_current_el(env) == 3 &&
         !(env->cp15.scr_el3 & (SCR_NS | SCR_EEL2))) {
-        return CP_ACCESS_TRAP_UNCATEGORIZED;
+        return CP_ACCESS_UNDEFINED;
     }
     return at_e012_access(env, ri, isread);
 }
@@ -4684,7 +4684,7 @@ static CPAccessResult sp_el0_access(CPUARMState *env, const ARMCPRegInfo *ri,
          * Access to SP_EL0 is undefined if it's being used as
          * the stack pointer.
          */
-        return CP_ACCESS_TRAP_UNCATEGORIZED;
+        return CP_ACCESS_UNDEFINED;
     }
     return CP_ACCESS_OK;
 }
@@ -5674,7 +5674,7 @@ static CPAccessResult sel2_access(CPUARMState *env, const ARMCPRegInfo *ri,
     if (arm_current_el(env) == 3 || arm_is_secure_below_el3(env)) {
         return CP_ACCESS_OK;
     }
-    return CP_ACCESS_TRAP_UNCATEGORIZED;
+    return CP_ACCESS_UNDEFINED;
 }
 
 static const ARMCPRegInfo el2_sec_cp_reginfo[] = {
@@ -5710,7 +5710,7 @@ static CPAccessResult nsacr_access(CPUARMState *env, const ARMCPRegInfo *ri,
     if (isread) {
         return CP_ACCESS_OK;
     }
-    return CP_ACCESS_TRAP_UNCATEGORIZED;
+    return CP_ACCESS_UNDEFINED;
 }
 
 static const ARMCPRegInfo el3_cp_reginfo[] = {
@@ -5798,7 +5798,7 @@ static CPAccessResult e2h_access(CPUARMState *env, const ARMCPRegInfo *ri,
         return CP_ACCESS_OK;
     }
     if (!(arm_hcr_el2_eff(env) & HCR_E2H)) {
-        return CP_ACCESS_TRAP_UNCATEGORIZED;
+        return CP_ACCESS_UNDEFINED;
     }
     return CP_ACCESS_OK;
 }
@@ -5896,7 +5896,7 @@ static CPAccessResult el2_e2h_e12_access(CPUARMState *env,
     }
     /* FOO_EL12 aliases only exist when E2H is 1; otherwise they UNDEF */
     if (!(arm_hcr_el2_eff(env) & HCR_E2H)) {
-        return CP_ACCESS_TRAP_UNCATEGORIZED;
+        return CP_ACCESS_UNDEFINED;
     }
     if (ri->orig_accessfn) {
         return ri->orig_accessfn(env, ri->opaque, isread);
@@ -6751,7 +6751,7 @@ static CPAccessResult access_lor_other(CPUARMState *env,
 {
     if (arm_is_secure_below_el3(env)) {
         /* UNDEF if SCR_EL3.NS == 0 */
-        return CP_ACCESS_TRAP_UNCATEGORIZED;
+        return CP_ACCESS_UNDEFINED;
     }
     return access_lor_ns(env, ri, isread);
 }
diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index fcee11e29ad..2230351a8f4 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -764,7 +764,7 @@ const void *HELPER(access_check_cp_reg)(CPUARMState *env, uint32_t key,
 
     if (arm_feature(env, ARM_FEATURE_XSCALE) && ri->cp < 14
         && extract32(env->cp15.c15_cpar, ri->cp, 1) == 0) {
-        res = CP_ACCESS_TRAP_UNCATEGORIZED;
+        res = CP_ACCESS_UNDEFINED;
         goto fail;
     }
 
@@ -869,8 +869,8 @@ const void *HELPER(access_check_cp_reg)(CPUARMState *env, uint32_t key,
     case CP_ACCESS_TRAP_EL2:
     case CP_ACCESS_TRAP_EL1:
         break;
-    case CP_ACCESS_TRAP_UNCATEGORIZED:
-        /* CP_ACCESS_TRAP_UNCATEGORIZED is never direct to a specified EL */
+    case CP_ACCESS_UNDEFINED:
+        /* CP_ACCESS_UNDEFINED is never direct to a specified EL */
         if (cpu_isar_feature(aa64_ids, cpu) && isread &&
             arm_cpreg_in_idspace(ri)) {
             /*
-- 
2.43.0


