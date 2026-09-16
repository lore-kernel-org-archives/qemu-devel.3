Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF231C982C3
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:12:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6pQu-000840-JW; Wed, 16 Sep 2026 09:12:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pQp-0007WK-Sb
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:12:11 -0400
Received: from mail-pz2-x10.google.com ([2607:f8b0:4864:3b::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pQn-00021P-Kk
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:12:11 -0400
Received: by mail-pz2-x10.google.com with SMTP id
 41be03b00d2f7-cc1cebad4adso735308a12.1
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 06:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789564328; x=1790169128; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=zppA5F7u5jRNskJwrLWeML9tlG0yJ4S2s1Br5DXJWCE=;
 b=DgHI/NFZnrEmbFX7CecLLAXfZmwfBUjIFKmi1iFk17GqTThpYzwe5yFWLEkSWhnPBV
 418XhtpGU8yaysCgmBNNsk9+JWuGbCFUZwWLDXotffecuiVgjBkeCyXoL46Lx+AyG3Zz
 3MU8u8Rs8Vb4PDDChosvB3Hd6wx33I+MWY4DVn3ODmMN36pi7CmtzXO/NhHE4Scn/sOH
 rmX6/nUKKacmsS7iUHPD3UjpGs3pGjt2IqLSLW323QT63VaLUegc5fzfbEsnB9mSu336
 G2UIgShHVrBYCNSXSvuwfcnPxucvxlsSqLjYMyO7EGSDX7EYzCd6fe9oArwRKikjzYCG
 cdhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789564328; x=1790169128;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=zppA5F7u5jRNskJwrLWeML9tlG0yJ4S2s1Br5DXJWCE=;
 b=i8hFuTiC0c+vmemcTGcdIbNFy+qu8Y0hWWZEns/oHUQ1PUZ3ZdD11cUPIPExFUFSTc
 YVReoP/lhl6cDU984ZMehfrAhJOOwX/z6E1G6811pGGbAyeevnI2db53qy4V4BJ8Fqlr
 81H3eKF1pupqAX9rJOkKjbf2FRqD8QdtnnkaX+7GaNRdRokAAWblp/U24lkeu9UJLj1m
 aVHmUiqYTU7YlJErGf1752Ns8zHZTM28fAb3YYTXgnLpO6+RqJkQh40Bx24UgCoIZ8Q3
 YVp2Oz0yW5ipowMDACbfCQP1rYhMl3I+WXPgRvn89pUwnopu551cc++k4IAuvaoO0xGZ
 0hnA==
X-Gm-Message-State: AFuF++nbUDuYNmi3C/UcjmB23UgV1ooY/LMUFh00hepSFQnP5p5D4aXD
 EFeMwVVxAK3IJ9T0/IUh0WQk5SD+n2m377eSSWpHvwCIkRvutu3Sr/0Yx8peFaGGEI3ogKtp6z2
 5ir9K/Os=
X-Gm-Gg: AYBFou0yU1cjJaMcDd311AP3rHiqAOR+J8T8RQhNwUOmcAa8bX7yT5fecMqbU3gzgnW
 IdrNzrb27trcjRc2xnG+VS3XVgf1wIOea4d9QyLXS90Y8qOxZNj3Ii1O5j7DJpQIEHc5mAQOek7
 c2FrDlDMNDuRPCc/FYR6NXF7StkvD7yBsd1gL41eof0nyXsryhPfsepJzdpG3j5/NjCJo77UUpt
 vB+Wr5d8A8uhc1MTgSQSNKU2mvlwZmyy8JmVWlIvdl0lx9l4fio/8svnhPYUZHxMbzdoogyN3qr
 CgwwdI1q4OKX7uyNO1oKDz1tFrHtoJLdSYLUaLz+DUDqiHXGRvZ9dRyl4ZzCEcHQLfgBikpU5OP
 6S5kQJj3f9JipHIz2ZiTzY6sfhAWuux/JpYsL9+5OcyrsyYsqtCxXqgvOIqHNugtb6eKN5KKT/b
 MxxZXwOsarmQ+eufacUgnNH5fVXSLA9IWG6HUJbLU1IiWTIoZTExB1yMCEHEB645+EsAyJ6zsLf
 mLsUms=
X-Received: by 2002:a17:90b:3c42:b0:398:c150:e7b3 with SMTP id
 98e67ed59e1d1-39e1e24fa59mr7095815a91.4.1789564328004; 
 Wed, 16 Sep 2026 06:12:08 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:845c:f507:397b:9b72])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5b22b74sm7873110eec.30.2026.09.16.06.12.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 06:12:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 92/92] tcg: Annontate functions in tcg-internal.h with
 QEMU_*_NONNULL
Date: Wed, 16 Sep 2026 03:04:07 -1000
Message-ID: <20260916130409.3382710-93-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916130409.3382710-1-richard.henderson@linaro.org>
References: <20260916130409.3382710-1-richard.henderson@linaro.org>
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
 tcg/tcg-internal.h | 38 +++++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/tcg/tcg-internal.h b/tcg/tcg-internal.h
index e35440dc8c0..2620c23b448 100644
--- a/tcg/tcg-internal.h
+++ b/tcg/tcg-internal.h
@@ -41,53 +41,55 @@ extern unsigned int tcg_max_ctxs;
 #endif
 
 void tcg_region_init(size_t tb_size, int splitwx, unsigned max_threads);
-bool tcg_region_alloc(TCGContext *s);
-void tcg_region_thread_initial_alloc(TCGContext *s);
-void tcg_region_prologue_set(TCGContext *s);
+QEMU_ARG_NONNULL bool tcg_region_alloc(TCGContext *s);
+QEMU_ARG_NONNULL void tcg_region_thread_initial_alloc(TCGContext *s);
+QEMU_ARG_NONNULL void tcg_region_prologue_set(TCGContext *s);
 
-static inline void *tcg_call_func(TCGOp *op)
+QEMU_RET_ARG_NONNULL static inline void *tcg_call_func(TCGOp *op)
 {
     return (void *)(uintptr_t)op->args[TCGOP_CALLO(op) + TCGOP_CALLI(op)];
 }
 
-static inline const TCGHelperInfo *tcg_call_info(TCGOp *op)
+QEMU_RET_ARG_NONNULL static inline const TCGHelperInfo *tcg_call_info(TCGOp *op)
 {
     return (void *)(uintptr_t)op->args[TCGOP_CALLO(op) + TCGOP_CALLI(op) + 1];
 }
 
-static inline unsigned tcg_call_flags(TCGOp *op)
+QEMU_ARG_NONNULL static inline unsigned tcg_call_flags(TCGOp *op)
 {
     return tcg_call_info(op)->flags;
 }
 
-static inline TCGv_i64 TCGV128_LOW(TCGv_i128 t)
+QEMU_RET_ARG_NONNULL static inline TCGv_i64 TCGV128_LOW(TCGv_i128 t)
 {
     return temp_tcgv_i64(tcgv_i128_temp(t) + HOST_BIG_ENDIAN);
 }
 
-static inline TCGv_i64 TCGV128_HIGH(TCGv_i128 t)
+QEMU_RET_ARG_NONNULL static inline TCGv_i64 TCGV128_HIGH(TCGv_i128 t)
 {
     return temp_tcgv_i64(tcgv_i128_temp(t) + !HOST_BIG_ENDIAN);
 }
 
 bool tcg_target_has_memory_bswap(MemOp memop);
 
-TCGTemp *tcg_temp_new_internal(TCGType type, TCGTempKind kind);
+QEMU_RET_NONNULL TCGTemp *tcg_temp_new_internal(TCGType type, TCGTempKind kind);
 
 /*
  * Locate or create a read-only temporary that is a constant.
  * This kind of temporary need not be freed, but for convenience
  * will be silently ignored by tcg_temp_free_*.
  */
-TCGTemp *tcg_constant_internal(TCGType type, int64_t val);
+QEMU_RET_NONNULL TCGTemp *tcg_constant_internal(TCGType type, int64_t val);
 
-TCGOp *tcg_gen_op1(TCGOpcode, TCGType, TCGArg);
-TCGOp *tcg_gen_op2(TCGOpcode, TCGType, TCGArg, TCGArg);
-TCGOp *tcg_gen_op3(TCGOpcode, TCGType, TCGArg, TCGArg, TCGArg);
-TCGOp *tcg_gen_op4(TCGOpcode, TCGType, TCGArg, TCGArg, TCGArg, TCGArg);
-TCGOp *tcg_gen_op5(TCGOpcode, TCGType, TCGArg, TCGArg, TCGArg, TCGArg, TCGArg);
-TCGOp *tcg_gen_op6(TCGOpcode, TCGType, TCGArg, TCGArg,
-                   TCGArg, TCGArg, TCGArg, TCGArg);
+QEMU_RET_NONNULL TCGOp *tcg_gen_op1(TCGOpcode, TCGType, TCGArg);
+QEMU_RET_NONNULL TCGOp *tcg_gen_op2(TCGOpcode, TCGType, TCGArg, TCGArg);
+QEMU_RET_NONNULL TCGOp *tcg_gen_op3(TCGOpcode, TCGType, TCGArg, TCGArg, TCGArg);
+QEMU_RET_NONNULL TCGOp *tcg_gen_op4(TCGOpcode, TCGType, TCGArg, TCGArg,
+                                    TCGArg, TCGArg);
+QEMU_RET_NONNULL TCGOp *tcg_gen_op5(TCGOpcode, TCGType, TCGArg, TCGArg,
+                                    TCGArg, TCGArg, TCGArg);
+QEMU_RET_NONNULL TCGOp *tcg_gen_op6(TCGOpcode, TCGType, TCGArg, TCGArg,
+                                    TCGArg, TCGArg, TCGArg, TCGArg);
 
 void vec_gen_2(TCGOpcode, TCGType, unsigned, TCGArg, TCGArg);
 void vec_gen_3(TCGOpcode, TCGType, unsigned, TCGArg, TCGArg, TCGArg);
@@ -95,8 +97,10 @@ void vec_gen_4(TCGOpcode, TCGType, unsigned, TCGArg, TCGArg, TCGArg, TCGArg);
 void vec_gen_6(TCGOpcode opc, TCGType type, unsigned vece, TCGArg r,
                TCGArg a, TCGArg b, TCGArg c, TCGArg d, TCGArg e);
 
+QEMU_RET_ARG_NONNULL
 TCGOp *tcg_op_insert_before(TCGContext *s, TCGOp *op,
                             TCGOpcode, TCGType, unsigned nargs);
+QEMU_RET_ARG_NONNULL
 TCGOp *tcg_op_insert_after(TCGContext *s, TCGOp *op,
                            TCGOpcode, TCGType, unsigned nargs);
 
-- 
2.53.0


