Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEC93C88E72
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 04:36:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x73kH-0003HV-Rw; Thu, 17 Sep 2026 00:29:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73k9-0003DI-JW
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:29:07 -0400
Received: from mail-pz2-x0c.google.com ([2607:f8b0:4864:3b::c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73k3-0006oT-L4
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:29:04 -0400
Received: by mail-pz2-x0c.google.com with SMTP id
 41be03b00d2f7-cc5121bcf1aso319219a12.1
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 21:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789619336; x=1790224136; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=gn2BVo8XsZoWSxJt8C4JLF74Lt5/vzi0qWbrkJFiwyQ=;
 b=PQMaiZjSm1JL5LWKfJcI5FEV15JdzoHCs6VhS5+bkD57MbaOROgXc12zPAlP5PF/F2
 JYl5Lc5en148pByVF26UuBFeufPu+tLgoOey+mcaxeQveobZZt8YGL1lftd/PV6o0fKn
 8bu1BESNhcatZPecX7LT65tJf781+eGZCooAGqW8fnIBx6/cWj70bBihH6HMZq4jnrF8
 /ItKJN90QP73Sjbc7bP9wafpBXKpIVKJgtJvNTrpjrcbmDtlm2xv4LR1XXiv5H2CS9+V
 w/BHi4qxK2czxK/k/7I9U7J++00XclPH7w/noeOfB7hVwcWItxDK5kKQqs38BBZwW+aF
 /Mjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789619336; x=1790224136;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=gn2BVo8XsZoWSxJt8C4JLF74Lt5/vzi0qWbrkJFiwyQ=;
 b=vi+wjSteUNWKN/c1pMNdLzftTyUf9+6Y8norrnbx6/gFbEcwjt4V8zLdtXJEz0FMB+
 BelNuy9PSZ5Zy9eGQsYjZDhbqQloRRUhd2UjPIoVq9Uyi+aXA6IU49/YY3IHpBdRFL9O
 UUIsJNQdOdraNPVGXwvvTY68wgplFBfovc93fYrDOur8HTRdIrOgJTft54YipuLdBWOc
 whSbUy0BfeWMq7aCKl8oK2Lr5oKTfRgAkEciCkm0Wv6phrFOCNgERmNtQmcOWLqQD1NV
 Vd/rCbmHacE0QoQwUEYpUh2846SVKdrkGe3T7PJDGDCy9rgn05p6S7K2KOUZAS2e/Iuh
 8ftA==
X-Gm-Message-State: AFuF++mbHLm4FTRS1SI2cfD5Pp8awABGPoQHtZ6xJVBm5kO3qNDmVOoD
 jmVf9yRzmxNgY6VluDiwJZODYoK40ucjg71UGOvCI2r6OI7tiDK8txyhmv/6266ZIAujQnpa3kH
 ZEZ2nZmU=
X-Gm-Gg: AYBFou3x6b9GyqZrdNha1FIZUvKqvUidtJ2Gn+OcV2faVY5i/sqUoZ57IOZeZRI/LAm
 US2ZRx0VJdQ3yGPWilk62daipcaJFNf8UrUGW9AK3eI4wT0RhlU0T3+mFGGZl6IYYBufqm8636P
 7dxCBWoD872kY8wo21s72H25c2vsEqTTozE721atBqkTnxyOwYB7S8/gLWwBlx40iuWy78TSV+A
 O8axsVeeovT1Z+Ag30RwD7ae2GGiqo/w7cuMOn4hUcuMupMS3IyaTHniLiS52/4CJw5a3dyKL4u
 75uI0xTjgvBsjAmy4aDVQvyMl4b1cs+eXm4E+KAA+P6xxxu3bTMV+UNwgTz7X//SO9hbIsoaGx5
 SbXMpwoEn4hutIrFO3QcRYrukJoT6wexHfnM1IefruM788+4S9V6GrIbwDhqIkdXliZ1ezGpAWA
 gemKtqi5xplizjPdG30wfW3lXI3ROqZHWHZDrw5BrjjkNVrFDKGBHzBiW2MWNy5BsjnK/kcgH1J
 6RoB40=
X-Received: by 2002:a17:90a:1188:b0:39e:1ec8:adc8 with SMTP id
 98e67ed59e1d1-39e1ec8b544mr5323681a91.14.1789619335479; 
 Wed, 16 Sep 2026 21:28:55 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395d771e5sm10458984c88.15.2026.09.16.21.28.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 21:28:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 027/101] tcg: Generic expansion of tcg_gen_sari_*
Date: Wed, 16 Sep 2026 18:27:09 -1000
Message-ID: <20260917042823.542588-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917042823.542588-1-richard.henderson@linaro.org>
References: <20260917042823.542588-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x0c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
 tcg/tcg-op.c                 | 30 ++++++++++--------------------
 3 files changed, 11 insertions(+), 22 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index e8ed65d8c15..60c74688b8e 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -126,7 +126,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 void tcg_gen_andi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_ori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_xori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
-void tcg_gen_sari_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_muli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_div_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_rem_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -215,7 +214,6 @@ void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_andi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_ori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_xori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
-void tcg_gen_sari_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_muli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_div_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_rem_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index b95e51a07dc..bfd2cd4b9c8 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -10,6 +10,7 @@ DEF3(mul, TCGV, TCGV, TCGV)
 DEF2(neg, TCGV, TCGV)
 DEF3(or, TCGV, TCGV, TCGV)
 DEF3(sar, TCGV, TCGV, TCGV)
+DEF3(sari, TCGV, TCGV, TINT)
 DEF3(shl, TCGV, TCGV, TCGV)
 DEF3(shli, TCGV, TCGV, TINT)
 DEF3(shr, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 99b56361558..aabccf49a81 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -453,6 +453,16 @@ static void gen_sar(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     gen_op_ttt(INDEX_op_sar, type, dst, src1, src2);
 }
 
+static void gen_sari(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
+{
+    tcg_debug_assert(src2 >= 0 && src2 < tcg_type_size(type) * 8);
+    if (src2 == 0) {
+        gen_mov(type, dst, src1);
+    } else {
+        gen_sar(type, dst, src1, tcg_constant_internal(type, src2));
+    }
+}
+
 static void gen_shl(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     gen_op_ttt(INDEX_op_shl, type, dst, src1, src2);
@@ -574,16 +584,6 @@ void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg)
     }
 }
 
-void tcg_gen_sari_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
-{
-    tcg_debug_assert(arg2 >= 0 && arg2 < 32);
-    if (arg2 == 0) {
-        tcg_gen_mov_i32(ret, arg1);
-    } else {
-        tcg_gen_sar_i32(ret, arg1, tcg_constant_i32(arg2));
-    }
-}
-
 void tcg_gen_brcond_i32(TCGCond cond, TCGv_i32 arg1, TCGv_i32 arg2, TCGLabel *l)
 {
     if (cond == TCG_COND_ALWAYS) {
@@ -1583,16 +1583,6 @@ void tcg_gen_xori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
     }
 }
 
-void tcg_gen_sari_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
-{
-    tcg_debug_assert(arg2 >= 0 && arg2 < 64);
-    if (arg2 == 0) {
-        tcg_gen_mov_i64(ret, arg1);
-    } else {
-        tcg_gen_sar_i64(ret, arg1, tcg_constant_i64(arg2));
-    }
-}
-
 void tcg_gen_brcond_i64(TCGCond cond, TCGv_i64 arg1, TCGv_i64 arg2, TCGLabel *l)
 {
     if (cond == TCG_COND_ALWAYS) {
-- 
2.53.0


