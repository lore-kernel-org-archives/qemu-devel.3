Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC0E606A319
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 14:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=S9pT5d0F
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJX7z-00034l-3s; Wed, 21 Oct 2026 10:17:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJX7q-00033t-D2
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:17:06 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJX7o-0001Tx-Nb
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:17:06 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4a180fbeef5so5979675e9.1
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 07:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792592223; x=1793197023; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+v9XHDF5ShyLMW0zG5TC9qa5KKqObnwfP1BvKkRvK3I=;
 b=S9pT5d0FqGqZxgvhT4jdqD2NaDgKfTLnQguFnTf7JOQJizONINhMSoJY6EZ75wB834
 9patkOFebzJPrOJ7pwYPc49B1HCuHWqFdrKyo58MMEWb/Pm95UTCihmqZouQ0J7y/Nqw
 X0qVvoEYmi6dtNjUVmeYveXXIxFsWaV77008239HRvE/zolG7tJd77x4wI7h2jrnOGUr
 ywKOZYC/zs6fYMKmS8FwZ1aVaAlCyjjSUjX/f+RbBSqFGNIOneg4wXav6fSeL1QSrT9b
 lFdzdxkRkJlbrxDZcXEywvvHmCghHpz2GRyQCMgHunvmYyfYCdZmTal8pde35xlAundt
 mzOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792592223; x=1793197023;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+v9XHDF5ShyLMW0zG5TC9qa5KKqObnwfP1BvKkRvK3I=;
 b=SVvhdIipA2gdW30oeR+P5YNPn36a9hKmzz/uOXL8mNfVmNrlLE1kpvbFUB6wVnHnLq
 07eB/K0JzAx5InnDVBvjXz3AIZrALBFJk8zOP34ksuXzakcyD7XPHaGxLOEk1hUIQ19W
 4Tlv+T95GM7ykXsqYhvUZjVid19TgiivkyEM/NbLNsHqAl3CEQjyt/VsgPr4qFAbx9kg
 infx9XarnpqNzLGnmYczZD18XvDaixbc8s6cifvSzQ/wLMzvPOKLrv4uv8Jdfrp9xJUs
 q+aL/chnTa3g3UX5g5tew0/2FVjBPUgqMJg2htDtF99gt0LzyXMb+mSdOpBeAWXnQQoA
 B4uA==
X-Gm-Message-State: AFq9FYKEBKbnEX6GLKTrYdTsiySNz5DGJKumZBxsS72o9x4RrfnyTPdf
 rMo9CvHxL0BjtkWpcY69ul/hRCdicwEy4OmcLB3/b5xiDBglq4QOVFVRkixAwx1QGiF/JdAuYvF
 OSCWcOec=
X-Gm-Gg: AYBFou0V0QTHmyaaPaOf6WuZAG7CqPE/dChz3v+Hfmdrjuv2xNQUgaSUyrT90X3od2K
 blwemyZKKzfUnPD6Mry/0nBIqtUlyt1MOLDylXs6Vkn2D38EocoRjWtCYaCcd2d0EDFNS1h7E5q
 2RB6JvA5XxshxBW6Ds+eoW86T4hSPSuJf/LxeIpH1YyX4g4JlR4HD3ftWqc8PbMri4tzkMkTSj1
 GHIRdTLq4WigefPliFN9TdaW3Bs6JkCU93LjvI1Baw2sayGTwJMYi1x8vxyGZI3A4+AbZYw+cBu
 DwgPRH5c3WmlYwiYpNt+VQcZkXr3Jptf+GROV9jZPPVlwTcqNsycSvilsvsGTUnCnGBsHSy0bER
 t6oe79BxrbjqIM7QPURML9L4NUQXVfZAW7Spyyb4GauWmbOVNxw8caAUiDsxP1+IIo/hfj5qucL
 prP2U1Lr0g0gz5pGyP3XzSMwA9fpKurPQ0aK0DuKnUax3X4qPpi0hI2xLR0K4bdr3TOt0eXQSLG
 tq6qbmR/Z5q/JATcl21EXrKw75yok4njtKfOMRud5kjodTfkY8tR5AnoAsJnLbzLR6y3coXIgkd
 zVXCVNfWWl0Vlkcl7i3YqiAlHN4=
X-Received: by 2002:a05:600c:b86:b0:4a0:1fb9:2f51 with SMTP id
 5b1f17b1804b1-4a1fdd2fa6cmr48825155e9.14.1792592223207; 
 Wed, 21 Oct 2026 07:17:03 -0700 (PDT)
Received: from stoup.fritz.box (pd95f64ec.dip0.t-ipconnect.de.
 [217.95.100.236]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1f2c242dcsm147113845e9.0.2026.10.21.07.17.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 07:17:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v6 004/100] tcg: Annontate functions in tcg-internal.h with
 QEMU_*_NONNULL
Date: Wed, 21 Oct 2026 16:15:16 +0200
Message-ID: <20261021141652.363109-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021141652.363109-1-richard.henderson@linaro.org>
References: <20261021141652.363109-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32b.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-internal.h | 38 +++++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/tcg/tcg-internal.h b/tcg/tcg-internal.h
index e35440dc8c..2620c23b44 100644
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


