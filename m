Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF0D606A31B
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 07:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=X1LvkveA
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKsW5-0006C3-4K; Sun, 25 Oct 2026 03:19:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsVt-00069r-5F
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:19:31 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsVr-0003fd-6m
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:19:28 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-48b042c0759so1201965f8f.2
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 00:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792912766; x=1793517566; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=QUBV/T5H1EW7Sa8l/o0Bmxiwjq5c81CKQ4jUfqzuS10=;
 b=X1LvkveAOAaBwQ60kh2C5L4C59E1cOed82k49nhkAnlmoAZX0PiUmuIHeBzgeNta+N
 I+Nhhu+wGUxwpv1B32+qoq4jo9LsaQraa3pGlW5bXcw56v0dLrzaWSdXKTww0f+tMsUY
 mNnb5TEXCv9izApqOYEbym/Lt4ImuchdkKyaNtWfsHxs2bQwjqtTMNvdy0SOqRZNdhga
 R2mRhu/Sb2pFlMk6sGnMVQhC5doXdFN5UJ7celxJy5Z2eor8Gqx0vC7w5pPcTPaxR0cM
 B9Fr3IfymBjlh4czR6V2RtkRg1UJiZ/k0C9dcNueOs3XGxshyntNClF1ROHbZYhLVk8d
 h0xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792912766; x=1793517566;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QUBV/T5H1EW7Sa8l/o0Bmxiwjq5c81CKQ4jUfqzuS10=;
 b=UjJBuTF31WiKuV4rmNPDNeMc7hfyORH5Zar+VPA569drKf2fYUflArG9UonoPva9Zj
 W1erqj0M4G0YZBelLmeeUfIz436AU+ruiM3UznaIRoNUZC6N+AnQ89U3rlC+vnUDh2Vj
 QhyGWcFN49Mmvs0uCxBwRaJUbNdH1JjVaAAdPJ0E/dSDzXnoTJhxRmhSpzdHTdPcP2dV
 0Fb7ZdbB5EG+TPl4iDleZiyR8Axe1djtHs6Vo8cBCiiXLWlIG2CNQNWqTLLeO3GKPKjm
 XOydlDomyrPcYkv/0YBzARkonyZ1LKqahzWzazcI5T24T2PdBnL/qfl1QcdD/J629YTu
 bUog==
X-Gm-Message-State: AFq9FYKUUb/+WYF+fL4EnjdPbsTVX8WaaNjDOl9pF5gYlQUSPlS1/Db1
 1UVgjFgTuq0Isi4YeJu/aiAOERJ9SPqqOjKhEHRjJpar1xtxO3C4E6PdHUO63gqAqvRfujBrSZP
 s34tl1S4=
X-Gm-Gg: AYBFou1Y8hmU9Cv3Okf0wmLWtnGGCaSGIIEeC8Mi8vIEX2cmza8K8fumeH8X71Nx6Ph
 Yns/OrSIFtZFLjFSbREVW0PoWCrSwVAklK+z6ZSKLU6t/Wdlg3Vv6ZTe1030fz7jeISlUL1lWlt
 tC4IW1RsU1UniPJOvtRdpEKNyRbAfcaAydaFMjdVmeo0CZJ+jkiDDvzDAr9bBC+8fvvbGScfrxe
 W/jd15G2CUBP4FsyusWXvaEv3hynlmxA5ksRsmA+s+jVVPRJBgFoPegcI9ezO7zi4yth4RwbJjQ
 Up2L+lJ5miTqRaSD6eVIucvy2rzEIijsyy3jimbw/xps76XY1W3xS2Eupa9bfESrtH2u4fAP+Jp
 9M4EwVbfskbnTIj/63up66ZQ7kPRHbef30AU4tk4YQ3gTHFci5v6j3gU4+OJTeOseFa2rtsrstZ
 Gm8OGJ/HAB1WeiK2RwUgEjBURorYN+Qp5BohFvy0+ckO6j8F7xV0PdgvrIW1ZZCxtVvmqM7Zpvz
 lvu+sUyyqQ0OBuJO/iZwon6pNshHKuWsJfIHrpUeM7yRlFFtxwxeTVcDw==
X-Received: by 2002:adf:e003:0:20b0:48e:2a04:4ea3 with SMTP id
 ffacd0b85a97d-48e3eb46777mr3710595f8f.8.1792912765825; 
 Sun, 25 Oct 2026 00:19:25 -0700 (PDT)
Received: from stoup ([176.95.65.245]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e4806e208sm4006309f8f.40.2026.10.25.00.19.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 00:19:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 004/100] tcg: Annotate functions in tcg-internal.h with
 QEMU_*_NONNULL
Date: Sun, 25 Oct 2026 08:17:39 +0100
Message-ID: <20261025071915.1123867-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261025071915.1123867-1-richard.henderson@linaro.org>
References: <20261025071915.1123867-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x429.google.com
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

Reviewed-by: Matt Turner <mattst88@gmail.com>
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


