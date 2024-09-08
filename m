Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5F45ECE577
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Sep 2024 02:28:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sn7dZ-0003aP-7g; Sat, 07 Sep 2024 22:26:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sn7dX-0003R4-1b
 for qemu-devel@nongnu.org; Sat, 07 Sep 2024 22:26:47 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sn7dV-00052X-Fw
 for qemu-devel@nongnu.org; Sat, 07 Sep 2024 22:26:46 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2d8a7c50607so2195143a91.1
 for <qemu-devel@nongnu.org>; Sat, 07 Sep 2024 19:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725762404; x=1726367204; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IPQ3Iuu/LAmgLlUZXWZGZIzBg2biU/xcO4whzf7Rmmg=;
 b=lHxtc0Lhyjea3wX5WTWZFzwz+eUo4PMaZSxZIBhmCAZOdxLCogbeHgRfVNPClF+nDF
 utiYWcC58SzAyroMVr8Xn5xmNwlf84HLt/5oFH0ck6wfEP3UVNeq7F3pLOPzGfbWJvgE
 5e0DNTI6DdNZKo1bOLPTXzRzEhQqLgfAipiuOU9BIv++Q7XKoqhIZpTnSSow46PwibJ2
 LSQGhl1ToDXJdv+YUAKRRzHjzc7iofw5hnq/iTLNSrqoKiz5JfbKNWQT8mE0dbJPAdeQ
 P94d7OatxumK/xQ4o0SZpfrqQEjVJuzM6i7eLzDQNnwKvj8UbB4vg7matbryuYb1KLLb
 knBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725762404; x=1726367204;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IPQ3Iuu/LAmgLlUZXWZGZIzBg2biU/xcO4whzf7Rmmg=;
 b=bMZsYFcAboAt+mFDWNq8J3Uk34kOxhG3tnLxpoteYd12A01kUrM/b9vO1opYSyDyc9
 e/ifdU+R2ztvFjsbgaybsGrITdyrZRNayblDZtDPqlHOZciG1PPw+Y24CPEioNlirqiA
 JjYr+CZblbG0O4bNRmudvtUA2Z0PSg6aHHxZnmalv9eT8nOR6xWgJVAJvpIZuKl2+IQ1
 1C6drBEQfjEzc2qDOpHaWSAWxLT3G9caaXJ3vKezax4d1qHZSAL8cM6UYmQ3uS95DK94
 6ZVc6ojzvMm87QInL0SUs1LHkALgPuTN0SHp7ZJdnr1UxSpIYYiQ4oizGmUpuSki3iNd
 ofAw==
X-Gm-Message-State: AOJu0YzhGYmXvyWjf3w2WTyjXs06QpiEC8CG1w4/cdn/oEG/GUfZyZ7v
 9Sf1z/vSVAIq2A+GcefVqApE6b+5eBTaJPfkIhDblEtT1aZqw2v0vPnyvblTyIQIW7zFbiztbyK
 g
X-Google-Smtp-Source: AGHT+IGBMUF8+1spcbwix1npOokfkEHzRs+BF18asiWY4gbuwbckJJbZT4hfWLtTMgXNGVIp2cozgw==
X-Received: by 2002:a17:90b:4a0b:b0:2d3:d414:4511 with SMTP id
 98e67ed59e1d1-2dad5022bc3mr9002725a91.24.1725762404137; 
 Sat, 07 Sep 2024 19:26:44 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2dadbfe46d4sm4084019a91.1.2024.09.07.19.26.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Sep 2024 19:26:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: zhiwei_liu@linux.alibaba.com, tangtiancheng.ttc@alibaba-inc.com,
 liwei1518@gmail.com, bmeng.cn@gmail.com
Subject: [PATCH 09/12] tcg/i386: Optimize cmpsel with constant 0 arguments
Date: Sat,  7 Sep 2024 19:26:29 -0700
Message-ID: <20240908022632.459477-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240908022632.459477-1-richard.henderson@linaro.org>
References: <20240908022632.459477-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
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

These can be simplified to and/andc, avoiding the load of
the zero into a register.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target-con-set.h |  2 +-
 tcg/i386/tcg-target-con-str.h |  1 +
 tcg/i386/tcg-target.c.inc     | 26 +++++++++++++++++++++++---
 3 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/tcg/i386/tcg-target-con-set.h b/tcg/i386/tcg-target-con-set.h
index da4411d96b..a9ff245c42 100644
--- a/tcg/i386/tcg-target-con-set.h
+++ b/tcg/i386/tcg-target-con-set.h
@@ -50,7 +50,7 @@ C_N1_I2(r, r, r)
 C_N1_I2(r, r, rW)
 C_O1_I3(x, 0, x, x)
 C_O1_I3(x, x, x, x)
-C_O1_I4(x, x, x, x, x)
+C_O1_I4(x, x, x, xO, xO)
 C_O1_I4(r, r, reT, r, 0)
 C_O1_I4(r, r, r, ri, ri)
 C_O2_I1(r, r, L)
diff --git a/tcg/i386/tcg-target-con-str.h b/tcg/i386/tcg-target-con-str.h
index cc22db227b..52142ab121 100644
--- a/tcg/i386/tcg-target-con-str.h
+++ b/tcg/i386/tcg-target-con-str.h
@@ -28,6 +28,7 @@ REGS('s', ALL_BYTEL_REGS & ~SOFTMMU_RESERVE_REGS)    /* qemu_st8_i32 data */
  */
 CONST('e', TCG_CT_CONST_S32)
 CONST('I', TCG_CT_CONST_I32)
+CONST('O', TCG_CT_CONST_ZERO)
 CONST('T', TCG_CT_CONST_TST)
 CONST('W', TCG_CT_CONST_WSZ)
 CONST('Z', TCG_CT_CONST_U32)
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index a04dc7d270..c63c3faed8 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -133,6 +133,7 @@ static TCGReg tcg_target_call_oarg_reg(TCGCallReturnKind kind, int slot)
 #define TCG_CT_CONST_I32 0x400
 #define TCG_CT_CONST_WSZ 0x800
 #define TCG_CT_CONST_TST 0x1000
+#define TCG_CT_CONST_ZERO 0x2000
 
 /* Registers used with L constraint, which are the first argument
    registers on x86_64, and two random call clobbered registers on
@@ -226,6 +227,9 @@ static bool tcg_target_const_match(int64_t val, int ct,
     if ((ct & TCG_CT_CONST_WSZ) && val == (type == TCG_TYPE_I32 ? 32 : 64)) {
         return 1;
     }
+    if ((ct & TCG_CT_CONST_ZERO) && val == 0) {
+        return 1;
+    }
     return 0;
 }
 
@@ -3119,13 +3123,29 @@ static void tcg_out_cmpsel_vec(TCGContext *s, TCGType type, unsigned vece,
                                TCGReg v0, TCGReg c1, TCGReg c2,
                                TCGReg v3, TCGReg v4, TCGCond cond)
 {
+    /*
+     * Since XMM0 is 16, the only way we get 0 into V3 and V4
+     * is via the constant zero constraint.
+     */
+    if (!v3 && !v4) {
+        tcg_out_dupi_vec(s, type, vece, v0, 0);
+        return;
+    }
+
     if (tcg_out_cmp_vec_noinv(s, type, vece, TCG_TMP_VEC, c1, c2, cond)) {
         TCGReg swap = v3;
         v3 = v4;
         v4 = swap;
     }
-    tcg_out_vex_modrm_type(s, OPC_VPBLENDVB, v0, v4, v3, type);
-    tcg_out8(s, (TCG_TMP_VEC - TCG_REG_XMM0) << 4);
+
+    if (!v3) {
+        tcg_out_vex_modrm_type(s, OPC_PANDN, v0, TCG_TMP_VEC, v4, type);
+    } else if (!v4) {
+        tcg_out_vex_modrm_type(s, OPC_PAND, v0, TCG_TMP_VEC, v3, type);
+    } else {
+        tcg_out_vex_modrm_type(s, OPC_VPBLENDVB, v0, v4, v3, type);
+        tcg_out8(s, (TCG_TMP_VEC - TCG_REG_XMM0) << 4);
+    }
 }
 
 static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
@@ -3716,7 +3736,7 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_bitsel_vec:
         return C_O1_I3(x, x, x, x);
     case INDEX_op_cmpsel_vec:
-        return C_O1_I4(x, x, x, x, x);
+        return C_O1_I4(x, x, x, xO, xO);
 
     default:
         g_assert_not_reached();
-- 
2.43.0


