Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABD26C27C43
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 21:21:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBhkZ-0007Ae-FG; Mon, 27 May 2024 17:19:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBhkX-00079N-J2
 for qemu-devel@nongnu.org; Mon, 27 May 2024 17:19:21 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBhkV-0003cp-AN
 for qemu-devel@nongnu.org; Mon, 27 May 2024 17:19:21 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6f4ed9dc7beso133205b3a.1
 for <qemu-devel@nongnu.org>; Mon, 27 May 2024 14:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716844758; x=1717449558; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qr9QrkkbS3DLNP2flOzNz6V1gGD5UBleYXp2ByqRSSQ=;
 b=k0WlpivPGRwSTDMuZzQ04K780U2x3L2QzS470p5lVe2Mp30YQHZmtFqlFT2jDLkYIy
 90XC4ngocw2RCtoyu2yggJiszDLWttWUCTbL/rM3dOraHr5G3Y4bI/Akwqsmq9x2ZFO9
 ZHJkkcs/SxJxNmJKBy7tFyQXwKn/LexG7bEaC1LFE4BhN+k/q87yOMsYtzPl4lQURZSi
 IHFTLinUzcHnGzagX00BPO2yNTZBUZWbPHkyTwe2bejwND2c3yIBxZ1Td1Vn6tyN/xWM
 eEf4tf4EtzwuYO24d1T3wlqMZXWNZ8zCbb2mSg+amDaFv06PNLFDXTvdNUtzcvFiEFE9
 USoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716844758; x=1717449558;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qr9QrkkbS3DLNP2flOzNz6V1gGD5UBleYXp2ByqRSSQ=;
 b=rJtHiqv+arPCW5aqzQ9nySJC6HSnE9nKAZW8rN/tGZUZ2H3NmUO1LYU3+TAAjGzpmw
 h2Uu6PXKbDky33coC/mDcB2VSS0BwNhPjSVJt0pRjcbF7LLvEbWueJifhY24FrPUwHDg
 LequRcuf4jrnu87dMdTdXpU0mIawi1SEk2A17zlwK3pCIOboOBEhvxVrheCesFRD9v5J
 bdX7OHtBs50LnJ3X5mE6KpJLbs+a7vGOhGMGdynFQd5KgIvvItKgIYMgzhzWOdovTXs0
 NONr3s8PfbFRhOWR1Ir+7zs8oC0UEkuaUnzHzmWdMPlJjm4Q7/dpiQTEBvd3rmXQw3hd
 zdfg==
X-Gm-Message-State: AOJu0YwigcyAKa2WjMdRogyWcfuG2gk3XDmGSU+9VFXVDnDRYSupJMiU
 i6waTRYn69YqrsOnY4VbYpjaW8O470C0lRVIk7NXgzrVFhhZvAaivkzoJJQQ9MWHBwqfaxeSGJO
 Z
X-Google-Smtp-Source: AGHT+IHJNfVhX5Xwq586HULQcs8erLUZO8Kt+4vTz56O6/N0alX1hBLHLYSb6Mqy2vYbNRKQdnvI2Q==
X-Received: by 2002:a05:6a00:1d93:b0:6ff:7ea6:d5ae with SMTP id
 d2e1a72fcca58-6ff7ea70f30mr8772233b3a.6.1716844757859; 
 Mon, 27 May 2024 14:19:17 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f8fd1d4d5fsm5265876b3a.165.2024.05.27.14.19.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 May 2024 14:19:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: git@xen0n.name,
	gaosong@loongson.cn
Subject: [PATCH 04/18] tcg/loongarch64: Support TCG_TYPE_V64
Date: Mon, 27 May 2024 14:18:58 -0700
Message-Id: <20240527211912.14060-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527211912.14060-1-richard.henderson@linaro.org>
References: <20240527211912.14060-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

We can implement this with fld_d, fst_d for load and store,
and then use the normal v128 operations in registers.
This will improve support for guests which use v64.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/loongarch64/tcg-target.h     | 2 +-
 tcg/loongarch64/tcg-target.c.inc | 8 ++++++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/tcg/loongarch64/tcg-target.h b/tcg/loongarch64/tcg-target.h
index 29e4860d20..990bad1d51 100644
--- a/tcg/loongarch64/tcg-target.h
+++ b/tcg/loongarch64/tcg-target.h
@@ -171,7 +171,7 @@ typedef enum {
 
 #define TCG_TARGET_HAS_tst              0
 
-#define TCG_TARGET_HAS_v64              0
+#define TCG_TARGET_HAS_v64              (cpuinfo & CPUINFO_LSX)
 #define TCG_TARGET_HAS_v128             (cpuinfo & CPUINFO_LSX)
 #define TCG_TARGET_HAS_v256             0
 
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index de5369536e..980ea10211 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -321,6 +321,7 @@ static bool tcg_out_mov(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg)
             }
         }
         break;
+    case TCG_TYPE_V64:
     case TCG_TYPE_V128:
         tcg_out_opc_vori_b(s, ret, arg, 0);
         break;
@@ -838,6 +839,7 @@ static void tcg_out_ld(TCGContext *s, TCGType type, TCGReg dest,
         }
         break;
     case TCG_TYPE_I64:
+    case TCG_TYPE_V64:
         if (dest < TCG_REG_V0) {
             tcg_out_ldst(s, OPC_LD_D, dest, base, offset);
         } else {
@@ -869,6 +871,7 @@ static void tcg_out_st(TCGContext *s, TCGType type, TCGReg src,
         }
         break;
     case TCG_TYPE_I64:
+    case TCG_TYPE_V64:
         if (src < TCG_REG_V0) {
             tcg_out_ldst(s, OPC_ST_D, src, base, offset);
         } else {
@@ -1880,8 +1883,8 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     a2 = args[2];
     a3 = args[3];
 
-    /* Currently only supports V128 */
-    tcg_debug_assert(type == TCG_TYPE_V128);
+    /* Currently only supports V64 & V128 */
+    tcg_debug_assert(type == TCG_TYPE_V64 || type == TCG_TYPE_V128);
 
     switch (opc) {
     case INDEX_op_st_vec:
@@ -2394,6 +2397,7 @@ static void tcg_target_init(TCGContext *s)
     tcg_regset_reset_reg(tcg_target_call_clobber_regs, TCG_REG_S9);
 
     if (cpuinfo & CPUINFO_LSX) {
+        tcg_target_available_regs[TCG_TYPE_V64] = ALL_VECTOR_REGS;
         tcg_target_available_regs[TCG_TYPE_V128] = ALL_VECTOR_REGS;
         tcg_regset_reset_reg(tcg_target_call_clobber_regs, TCG_REG_V24);
         tcg_regset_reset_reg(tcg_target_call_clobber_regs, TCG_REG_V25);
-- 
2.34.1


