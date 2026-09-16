Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE267C88E5C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:13:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6pQz-00005i-Bz; Wed, 16 Sep 2026 09:12:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pQp-0007Tk-BZ
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:12:11 -0400
Received: from mail-oi2-x10.google.com ([2607:f8b0:4864:32::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pQm-00021F-7Q
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:12:11 -0400
Received: by mail-oi2-x10.google.com with SMTP id
 5614622812f47-4b37a29bf27so404073b6e.2
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 06:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789564327; x=1790169127; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=mvlxbvvBT6L4tozjt59kyDDd3bACtbqGjYtcp/gb1fc=;
 b=xcPPC4uPibwrR3a454FF15FO8zWWHfAYTh0L0WeyfoEq+fZM1QnIUZzreDDsFDC3to
 TMZWOUK41Lm5wHqTd99UrAuguxc98Yz2P3s3FRXjPwCiXTq6+8Z4S+xnIrtqjz5sC0L9
 kSA3goegMITM5RuB4biCQnVplZcQB/0Ov9L9nRG1wLX19gdzQvcUJfp0oHrMStFBr9fB
 P5y7ygmQj/3HDoFBHvuoqL1K1Xlswqb7DvebCLtIiJvmbzbl4cN4opKs6bT+gCW66ly5
 xWgIqsGs1zmCQ4H7M9hME0if8mISLF/e90FZtTOCRYhDjz2jMCng3k/KQW7fOVflDp7n
 6agg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789564327; x=1790169127;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=mvlxbvvBT6L4tozjt59kyDDd3bACtbqGjYtcp/gb1fc=;
 b=rmutMLfcIuEKrTvr5C/Ak4pfVflwWnPBJ0fXEaQEv0DMhEXODBKHu9paCyI6zyfFNS
 +4xpXOQwov/pXymhPe2cbQWEI9ko9A2u7y0Am9/sxd73WadQ8odQRXywcypGgdADzZtb
 dO8zHJwXXh6adSeiXmGHHk8HicWbPGBiYSIhVmR/TSMh3X340rak8AtUEKXMM/8XHf1z
 amGImqmYmyAtLACJQ+3GwHF78nEuUNHoLS10VccDsL9Ptvawbl9htx9tK2Voz5Hebpfj
 2gtcFy0HYH1gEFU5RHh+kbOHMEvIIH/u+WstrOU0ctL8M1YA4VBp+8ThrPKtpQbQAzLJ
 jISg==
X-Gm-Message-State: AFuF++m250zjjKgO3fy4cvwQgnp1yA1YCOd3VtqOvR/s468/EaM9U2qm
 rcXiYz1JiNItP25Otdur2cY4UjaFV64it/oeX/WotgxxCVYN1Ktp3SbcZhiFP+QSUYPlKpvdvR/
 S02UYAMo=
X-Gm-Gg: AYBFou2oLH1IA55n6azZbREi/bthTKDSt87Y3PELHK4cOhzRyhPjMCdyysJpYqSgvAW
 mYS0npATSm4+gmWgbxdQ9uwvYhkuYmWZuGm+L8MdsBiRyBERy/Z1ZpcJ5CDPVlOIbK3EXMJ1We8
 D/JPz+DAb9wEHjtaZDuBdrJLQwZ7bfZaocvxI2MhatakDWmTkl1S9/V4EisMuB2iCwyns5ffu+x
 ZOOpd83dH0ghpNVV9wnVQl3AC3wG74gheEzA0NjlQhJIPtxgrAX3s+C45i+XIlX/XkWOTxOaDuw
 6JxTcFGZKLO4EXnHv1mpUDnfbO+eaLdxhmjaWzyNTP1s278gsW3iCQddm+7aQA/MWU2iT62XsG9
 eArdxxBnjBKtBnQDE636cNOT3O95x73W8l4YUKaZoFDVzjclTWUEUk3sp26KqyBwcsjShr4U2w7
 TAy4vzH4mPaiXBccaeuAdCg/pRq8PS3KtKnz+XQEdenKZ2MlhEWA5vOozUNKaP1K5K62kR8hzcK
 svn/IEgZJ/h5WcU6w==
X-Received: by 2002:a05:6808:30aa:b0:4c3:b3e:4e72 with SMTP id
 5614622812f47-4ca4a2ee24amr3442029b6e.12.1789564326836; 
 Wed, 16 Sep 2026 06:12:06 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:845c:f507:397b:9b72])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5b22b74sm7873110eec.30.2026.09.16.06.12.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 06:12:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 91/92] tcg: Annontate functions in tcg-op-mem.h with
 QEMU_*_NONNULL
Date: Wed, 16 Sep 2026 03:04:06 -1000
Message-ID: <20260916130409.3382710-92-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916130409.3382710-1-richard.henderson@linaro.org>
References: <20260916130409.3382710-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:32::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi2-x10.google.com
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
 include/tcg/tcg-op-mem.h | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/tcg/tcg-op-mem.h b/include/tcg/tcg-op-mem.h
index ea35a02fb40..29e7c02f256 100644
--- a/include/tcg/tcg-op-mem.h
+++ b/include/tcg/tcg-op-mem.h
@@ -28,50 +28,50 @@ typedef TCGv_i64 TCGv_va;
 #error
 #endif
 
-static inline void
+QEMU_ARG_NONNULL static inline void
 tcg_gen_qemu_ld_i32(TCGv_i32 v, TCGv_va a, TCGArg i, MemOp m)
 {
     tcg_gen_qemu_ld_i32_chk(v, tcgv_va_temp(a), i, m, TCG_TYPE_VA);
 }
 
-static inline void
+QEMU_ARG_NONNULL static inline void
 tcg_gen_qemu_st_i32(TCGv_i32 v, TCGv_va a, TCGArg i, MemOp m)
 {
     tcg_gen_qemu_st_i32_chk(v, tcgv_va_temp(a), i, m, TCG_TYPE_VA);
 }
 
-static inline void
+QEMU_ARG_NONNULL static inline void
 tcg_gen_qemu_ld_i64(TCGv_i64 v, TCGv_va a, TCGArg i, MemOp m)
 {
     tcg_gen_qemu_ld_i64_chk(v, tcgv_va_temp(a), i, m, TCG_TYPE_VA);
 }
 
-static inline void
+QEMU_ARG_NONNULL static inline void
 tcg_gen_qemu_st_i64(TCGv_i64 v, TCGv_va a, TCGArg i, MemOp m)
 {
     tcg_gen_qemu_st_i64_chk(v, tcgv_va_temp(a), i, m, TCG_TYPE_VA);
 }
 
-static inline void
+QEMU_ARG_NONNULL static inline void
 tcg_gen_qemu_ld_i128(TCGv_i128 v, TCGv_va a, TCGArg i, MemOp m)
 {
     tcg_gen_qemu_ld_i128_chk(v, tcgv_va_temp(a), i, m, TCG_TYPE_VA);
 }
 
-static inline void
+QEMU_ARG_NONNULL static inline void
 tcg_gen_qemu_st_i128(TCGv_i128 v, TCGv_va a, TCGArg i, MemOp m)
 {
     tcg_gen_qemu_st_i128_chk(v, tcgv_va_temp(a), i, m, TCG_TYPE_VA);
 }
 
 #define DEF_ATOMIC2(N, S)                                               \
-    static inline void N##_##S(TCGv_##S r, TCGv_va a, TCGv_##S v,       \
-                               TCGArg i, MemOp m)                       \
+    QEMU_ARG_NONNULL static inline void                                 \
+    N##_##S(TCGv_##S r, TCGv_va a, TCGv_##S v, TCGArg i, MemOp m)       \
     { N##_##S##_chk(r, tcgv_va_temp(a), v, i, m, TCG_TYPE_VA); }
 
 #define DEF_ATOMIC3(N, S)                                               \
-    static inline void N##_##S(TCGv_##S r, TCGv_va a, TCGv_##S o,       \
-                               TCGv_##S n, TCGArg i, MemOp m)           \
+    QEMU_ARG_NONNULL static inline void                                 \
+    N##_##S(TCGv_##S r, TCGv_va a, TCGv_##S o, TCGv_##S n, TCGArg i, MemOp m) \
     { N##_##S##_chk(r, tcgv_va_temp(a), o, n, i, m, TCG_TYPE_VA); }
 
 DEF_ATOMIC3(tcg_gen_atomic_cmpxchg, i32)
-- 
2.53.0


