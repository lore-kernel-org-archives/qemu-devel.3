Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF7BCC54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 14:41:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk3Hz-0003co-GJ; Tue, 12 Mar 2024 10:39:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rk3HZ-0003XI-9Z
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 10:39:09 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rk3HI-0007jl-41
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 10:39:04 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-29c23f53eabso1171708a91.0
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 07:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710254329; x=1710859129; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nauksK2e7Q6WDYDd+VxmoOkYOzpKhwUNqATghqi1W1o=;
 b=cE6362RLwa/WE8xuQF2uNmluduGAju8nq8RxX3QebsxMR0Wni059khizwMYdrTmVux
 A1pDsv/3e3uRmopE+bmWvYTq/uPmmNwTkT/aCigN6xzCVLprbLencDchEe2RFb3v1G8m
 Aopgz9aG6x/SW/RkjA02udf+6965mX4qxsJJ92lAEERxBCc7r836XX6/HZUKYv4KPBpl
 xhxrOO4DNzDriWJ2v0o1JV7HK89v1k9Bw3rn2dwO9aM69pnrowtsMr8Q8uEz+wl7vwOC
 iPx+uMWm9S0Dz7fUybjV5mxc+RZ5BLrmDOGSVu8BVFXQziHrXCHm/jWHhCTpC3rlU5vx
 +9NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710254329; x=1710859129;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nauksK2e7Q6WDYDd+VxmoOkYOzpKhwUNqATghqi1W1o=;
 b=FyFa7ZcnnFMrnCN1lKxZchzG/Z5ZWRgE7GEZvbUkrDw9CSQa8pmGSb0dT0hLg2YHzZ
 jwYwIXkcGWFXd02c2TJloSnbHpYIWD4IK1qFS7+x40oUIR0CRj7p/At5PNJ2rcaUrPSe
 T5g9aLhz/wMeHm0a8QCvhc0GcGaA3ovGhFWxyVXxRfP3FEYx7NbCFPvZO5cjMPsPmUGj
 vI7XU4E2U/ugC13olFzCqXKEr/zGWP/XUQ6dHxxhiss0GbrL5j1fRLs8DWriB7fXyyZV
 ToBjcu8vzQMolUZwBY9yCfsr033IR0GlEMfmrwlDXP226x8IGauCeqOkkWgMviNSGhpM
 ZMaQ==
X-Gm-Message-State: AOJu0Yz8H4HaOu419awcjAOKg0wGq81yU9i2xx58znP/iAe+6ta6PFE3
 lWdMRH/7LPXQtT6vLhdu/I2vGzr3wk60HFEI2H3xrjZ2E0u6xAFxnD5BqSahpTZwjztIcUe9ZjQ
 W
X-Google-Smtp-Source: AGHT+IGvpCf77yTRFxhE+2188kmtd9jaKw2/y0ZdzkVlBxpLo+6Sa4+H4AKsqiuLHfNY6EhB6flTsQ==
X-Received: by 2002:a17:90a:e60a:b0:29b:9f14:e18e with SMTP id
 j10-20020a17090ae60a00b0029b9f14e18emr6881687pjy.40.1710254329236; 
 Tue, 12 Mar 2024 07:38:49 -0700 (PDT)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 jx15-20020a17090b46cf00b0029baa0b1a6csm7492214pjb.24.2024.03.12.07.38.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 07:38:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 04/15] tcg/i386: Do not accept immediate operand for andc
Date: Tue, 12 Mar 2024 04:38:28 -1000
Message-Id: <20240312143839.136408-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240312143839.136408-1-richard.henderson@linaro.org>
References: <20240312143839.136408-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The transformation of andc with immediate to and is now
done generically and need not be handled by the backend.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target-con-set.h |  3 +--
 tcg/i386/tcg-target-con-str.h |  1 -
 tcg/i386/tcg-target.c.inc     | 20 +++++---------------
 3 files changed, 6 insertions(+), 18 deletions(-)

diff --git a/tcg/i386/tcg-target-con-set.h b/tcg/i386/tcg-target-con-set.h
index e24241cfa2..69d2d38570 100644
--- a/tcg/i386/tcg-target-con-set.h
+++ b/tcg/i386/tcg-target-con-set.h
@@ -40,11 +40,10 @@ C_O1_I2(r, 0, r)
 C_O1_I2(r, 0, re)
 C_O1_I2(r, 0, reZ)
 C_O1_I2(r, 0, ri)
-C_O1_I2(r, 0, rI)
 C_O1_I2(r, L, L)
+C_O1_I2(r, r, r)
 C_O1_I2(r, r, re)
 C_O1_I2(r, r, ri)
-C_O1_I2(r, r, rI)
 C_O1_I2(x, x, x)
 C_N1_I2(r, r, r)
 C_N1_I2(r, r, rW)
diff --git a/tcg/i386/tcg-target-con-str.h b/tcg/i386/tcg-target-con-str.h
index cc22db227b..0c766eac7e 100644
--- a/tcg/i386/tcg-target-con-str.h
+++ b/tcg/i386/tcg-target-con-str.h
@@ -27,7 +27,6 @@ REGS('s', ALL_BYTEL_REGS & ~SOFTMMU_RESERVE_REGS)    /* qemu_st8_i32 data */
  * CONST(letter, TCG_CT_CONST_* bit set)
  */
 CONST('e', TCG_CT_CONST_S32)
-CONST('I', TCG_CT_CONST_I32)
 CONST('T', TCG_CT_CONST_TST)
 CONST('W', TCG_CT_CONST_WSZ)
 CONST('Z', TCG_CT_CONST_U32)
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index c6ba498623..ed70524864 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -130,9 +130,8 @@ static TCGReg tcg_target_call_oarg_reg(TCGCallReturnKind kind, int slot)
 /* Constants we accept.  */
 #define TCG_CT_CONST_S32 0x100
 #define TCG_CT_CONST_U32 0x200
-#define TCG_CT_CONST_I32 0x400
-#define TCG_CT_CONST_WSZ 0x800
-#define TCG_CT_CONST_TST 0x1000
+#define TCG_CT_CONST_WSZ 0x400
+#define TCG_CT_CONST_TST 0x800
 
 /* Registers used with L constraint, which are the first argument
    registers on x86_64, and two random call clobbered registers on
@@ -203,8 +202,7 @@ static bool tcg_target_const_match(int64_t val, int ct,
         return 1;
     }
     if (type == TCG_TYPE_I32) {
-        if (ct & (TCG_CT_CONST_S32 | TCG_CT_CONST_U32 |
-                  TCG_CT_CONST_I32 | TCG_CT_CONST_TST)) {
+        if (ct & (TCG_CT_CONST_S32 | TCG_CT_CONST_U32 | TCG_CT_CONST_TST)) {
             return 1;
         }
     } else {
@@ -214,9 +212,6 @@ static bool tcg_target_const_match(int64_t val, int ct,
         if ((ct & TCG_CT_CONST_U32) && val == (uint32_t)val) {
             return 1;
         }
-        if ((ct & TCG_CT_CONST_I32) && ~val == (int32_t)~val) {
-            return 1;
-        }
         /*
          * This will be used in combination with TCG_CT_CONST_S32,
          * so "normal" TESTQ is already matched.  Also accept:
@@ -2666,12 +2661,7 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
         break;
 
     OP_32_64(andc):
-        if (const_a2) {
-            tcg_out_mov(s, rexw ? TCG_TYPE_I64 : TCG_TYPE_I32, a0, a1);
-            tgen_arithi(s, ARITH_AND + rexw, a0, ~a2, 0);
-        } else {
-            tcg_out_vex_modrm(s, OPC_ANDN + rexw, a0, a2, a1);
-        }
+        tcg_out_vex_modrm(s, OPC_ANDN + rexw, a0, a2, a1);
         break;
 
     OP_32_64(mul):
@@ -3442,7 +3432,7 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
 
     case INDEX_op_andc_i32:
     case INDEX_op_andc_i64:
-        return C_O1_I2(r, r, rI);
+        return C_O1_I2(r, r, r);
 
     case INDEX_op_shl_i32:
     case INDEX_op_shl_i64:
-- 
2.34.1


