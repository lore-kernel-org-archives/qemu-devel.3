Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE3EFC982C1
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 04:37:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x73rY-0004lq-18; Thu, 17 Sep 2026 00:36:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73r0-00041S-Jo
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:36:12 -0400
Received: from mail-pz2-x10.google.com ([2607:f8b0:4864:3b::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73qx-0007xi-HY
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:36:09 -0400
Received: by mail-pz2-x10.google.com with SMTP id
 d2e1a72fcca58-86212a185dcso429564b3a.1
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 21:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789619766; x=1790224566; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=qUs/LcFAdg6jp5g2jRJRQ/pPNVGY8IkuWcSKApGt5sM=;
 b=sNZ+55RXwLvoPBMmu5AihQaG+O8nqh7q0kT1JGFFUsGXWH+lI0nnwA7SC42OumiI/V
 EtevpmwYApdJBFmLx9fuSgRzaBqw2u21mxpDZybJaM8Uyie6w0DQyXSLRsiwWnS0F4Kq
 o9qm2syDv4124sRBnBxis+Lba0q75g+9DOPCvWUw9stNpC36lfYGYua5rr5z4Z3SHyXM
 By8rTwaTtiGSmljVBWRyn91yrmpyT5gWgmBYkGNM78r+26A3Pe3DdcSPCYaJGjdiEitZ
 PLH7ktNc0UbFXxbYU54tO1deJUqp8K3SMi7ijhsNmgRPXDCygHN0iB+IkPOJZl1wc3l4
 CJHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789619766; x=1790224566;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=qUs/LcFAdg6jp5g2jRJRQ/pPNVGY8IkuWcSKApGt5sM=;
 b=OdesMDb7NOo8/rO0Q/KM1Wmb5xmMK4oMO0DYCFUgD4+IS215QgERuvImQcuyMUhBSY
 DLlusHZDW2CviUqdlfpb/90Nqfrkx2rG97tjjKc0a9bLDhy8w0q/bC5vDGNaG31bFJmy
 sdD0bRHfiZPDl6o31WzjQ65MQRTr/Aadm7lqGMj8FglgHp0x9rks0XjA+1Tqk7+czjAL
 AFCtNjbqnnsNR1S86VcZfZBXbalO+LDGIGKgA7BLldbErQEtkK/dxkF5f4WIPDKF9WWv
 L7JzVFkM757x/gRytNAnYEscSG4swriN/c7if2HQlFlggnutt3GIzD2/9YNrYAbSwWAB
 PKrA==
X-Gm-Message-State: AFuF++lz3QD2Q7+amMwjhUPF0lQSt1eoXT9A101zmoybnDFVl9HHgUL6
 YuphQ1W3dD6WyI39iT7OdIu9yWTm8kRAzmdGZCwxJkri+BcngWAhdM7nhepgT+kXj9VAXxbTJ57
 lc0bALdM=
X-Gm-Gg: AYBFou2+4zJAUetEEKYRNjYkB7suINkNBPcSSaEQ16SPp9wScrM/oNTwcNZOjgAgM6l
 6Lkv4fjkbuiZXmW1KTyXErbGVn0hkg0RNGRHKK15dijbRtkDT2tJDBhw9aXnxJ5wsXwKKgbuKaY
 tcUUQ9b19S1AcfiF5OnprBVexQNL7uDQhA0UvS+hnz/ZK2LPpRoomaWJNBRkw9qp7sRo0kZ2o7b
 7lds7hmmRRgHz6HOX5vRxUrj53s6SVu8xyXYM+Tnht4FksjwbUiSm4AGV+hLCGWUdOWifRFcOv4
 xoEiR2IB9o453mXOU/CXZu10nVEm97Z6pnRGEeYlXO2+W0PRiPZN2cjYkEEWDYVPaNMrcw41FEs
 lSWWIdTPhsj6CpMWRW7XVyzNpBunTTSiMi+MXu5Zvih9RgWn2yVv7hpRNoPB3Skk63+pvbh+6n6
 y2IRoXXcgvk1Hqb0D7IXelkEqJtwW/+pPnoP9zHre9bmTqnLmhzL6vV1iu9rIYCDguTDmidHXcb
 T5OuCjB1nNWJedG0vU=
X-Received: by 2002:a05:6300:68c8:10b0:3dd:7a8b:2e88 with SMTP id
 adf61e73a8af0-3dd7a8b2efbmr1231494637.15.1789619764409; 
 Wed, 16 Sep 2026 21:36:04 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395d13ee7sm10764267c88.8.2026.09.16.21.36.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 21:36:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 094/101] tcg: Generic expansion of tcg_gen_ld16s_*
Date: Wed, 16 Sep 2026 18:28:16 -1000
Message-ID: <20260917042823.542588-95-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917042823.542588-1-richard.henderson@linaro.org>
References: <20260917042823.542588-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x10.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h  |  2 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 16 ++++++----------
 3 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 925d6c1a2ae..75e124b8091 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -141,7 +141,6 @@ void tcg_gen_revbit32_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_dup_i32(unsigned vece, TCGv_i32 out, TCGv_i32 in);
 
 void tcg_gen_ld16u_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset);
-void tcg_gen_ld16s_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset);
 
 void tcg_gen_st8_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st16_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
@@ -168,7 +167,6 @@ void tcg_gen_st16_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st32_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 void tcg_gen_ld16u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
-void tcg_gen_ld16s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld32u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld32s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 14b545c4b50..c4078ca5a1a 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -33,6 +33,7 @@ DEF3(eqv, TCGV, TCGV, TCGV)
 DEF3(ld, TCGV, TCGv_ptr, tcg_target_long)
 DEF3(ld8s, TCGV, TCGv_ptr, tcg_target_long)
 DEF3(ld8u, TCGV, TCGv_ptr, tcg_target_long)
+DEF3(ld16s, TCGV, TCGv_ptr, tcg_target_long)
 DEF2(mov, TCGV, TCGV)
 DEF2(movi, TCGV, TINT)
 DEF6(movcond, TCGCond, TCGV, TCGV, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 1a22c0d71ff..5c644c06609 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -909,6 +909,12 @@ static void gen_ld8u(TCGType type, TCGTemp *dst,
     gen_op_tti(INDEX_op_ld8u, type, dst, base, ofs);
 }
 
+static void gen_ld16s(TCGType type, TCGTemp *dst,
+                      TCGTemp *base, tcg_target_long ofs)
+{
+    gen_op_tti(INDEX_op_ld16s, type, dst, base, ofs);
+}
+
 static void gen_mov(TCGType type, TCGTemp *dst, TCGTemp *src)
 {
     if (src != dst) {
@@ -1518,11 +1524,6 @@ void tcg_gen_ld16u_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i32(INDEX_op_ld16u, ret, arg2, offset);
 }
 
-void tcg_gen_ld16s_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset)
-{
-    tcg_gen_ldst_op_i32(INDEX_op_ld16s, ret, arg2, offset);
-}
-
 void tcg_gen_st8_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset)
 {
     tcg_gen_ldst_op_i32(INDEX_op_st8, arg1, arg2, offset);
@@ -1546,11 +1547,6 @@ void tcg_gen_ld16u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_ld16u, ret, arg2, offset);
 }
 
-void tcg_gen_ld16s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset)
-{
-    tcg_gen_ldst_op_i64(INDEX_op_ld16s, ret, arg2, offset);
-}
-
 void tcg_gen_ld32u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset)
 {
     tcg_gen_ldst_op_i64(INDEX_op_ld32u, ret, arg2, offset);
-- 
2.53.0


