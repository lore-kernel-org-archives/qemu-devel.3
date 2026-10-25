Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D44606A31E
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 07:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=sB1/6CHG
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKsWD-0006Fi-CI; Sun, 25 Oct 2026 03:19:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsVt-00069q-5F
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:19:29 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsVq-0003fU-71
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:19:28 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-48dfdd0678dso1499370f8f.0
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 00:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792912764; x=1793517564; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=gMNOyu4vCRvNe/Wj/zJ73wBk+1455f3dNauSaPJgNSE=;
 b=sB1/6CHGZi3wZa/3+NFDUgb9viYQZmJh8KDEgRd1x/iQmL3q8FakDuqVIB3XYqF3WB
 WHtRu+EDb54xc4BbPhC0qBspPOzY6068b8+P3st8tQ+UI6pQjhB3Z6IMU71wGu4UXuQ+
 iBke0rRW3q9bQ8f7FBSrrnxfPXtHANmlhxXsMJA3qVRdya9bj1ps0YphujvHP+cZRs5q
 9PYeECQpNPL97R8cmjQ1wJnIcaD+1DtZptUl61jWYq4+WLVuq3g5WrwSE13VnBxzydKU
 fUNvPFmyxs0frhsGteK+vskRc+soBdovzX1lO3aBByKDLgeGIovvUnB6Iky41eIoYbXi
 DiHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792912764; x=1793517564;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gMNOyu4vCRvNe/Wj/zJ73wBk+1455f3dNauSaPJgNSE=;
 b=J2ibuIbfYtr5dRFeo9Iogjn7lJmK+ORwqQSBqkmFhPISBWZ4fGwooJgt4QpEUvSXgc
 IPTXl4bg6WafsVZZsNy72oxma8Tm9k0EPGZFIZUiBhfPMln9pZVUMrvRianRnF8OVF5T
 SrsinbrKNhD2PKMvjx4AWkk0XJwE2Jfg66BX+BiYA9W3XBbVYkLIV50z/1MD79AtgMb6
 uZs8eyVLehRSvkAljCPZPqATVXN8GYxTxlIZCFcpCum166JpryXETQNTwSPkbnEtQU8S
 LLG11hRBjbiz4aQTfkVDCk8BDa55JB16IyyCn66/MVpLZkNwwYiOZbxWTphVklQ9lMaY
 6xSQ==
X-Gm-Message-State: AFq9FYLviEIfnVYfs8fMAlYjU35Tt8scUEWGbmJvHbZ+9F8rTsKJXrCE
 /efv2C+1i0Zjhc215cOvTSyI0sQTLJlTf1HsjpTd7BuKTtwdp026jVXv/dbDKZDBQ5RJyMe8/sg
 G/CoLykc=
X-Gm-Gg: AYBFou0pkZ4IBUGVjAEYJJqbh5fkjawlUdG3uCfqLA5sknc0wqTyNEDKR4it3+g0tf9
 Ki50dnvyjQ0zSDoYGjBaD+YBhFKBszSQ1dpdy3L3XDUkqFA+7UqAFmc2NvLPQ0+jPlaaLzY9Kd8
 R73ELAWRmA2BysyB17zcKrRY3TKM/sLBOTaopeIpwmhif/dvUooNTxQxXmsxSZyAImOaEz1eri5
 95sV0tBO6FECes5T/35IlTikahI9GMe1xCNLKb8Sekz+1BHVbmtVLsGmmTZu6bREXVJ0p0HDIpq
 5KOcelgAtRuXa0mewqoxpCTdIrFtWV1QxzS8yjqIjQXBP88tKEtfD1U3fv0D8CDZMwDPi0n9FKt
 egBRroYPS8HyuaMdUZeigfsfbdyXHxJIEs0MIOWgK+dR5cQ0JTFOei1vfCpdhkqZSxnYBZqX3aN
 UkBjIAoy1GXYz0osBxP8onTXr8QNZpQ1Gf39/h1ZwCDWdNNkFRL1DDIRkpoSnQIJkMVcjts0f0D
 VfWdKJHE9wmC0IMxfNg1GwuPRmQ5+vHSIx9Qu4nc1vmztSvtDIkB46OUQ==
X-Received: by 2002:adf:e68b:0:b0:48e:2948:6fe3 with SMTP id
 ffacd0b85a97d-48e3ebb003emr3770951f8f.39.1792912764357; 
 Sun, 25 Oct 2026 00:19:24 -0700 (PDT)
Received: from stoup ([176.95.65.245]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e4806e208sm4006309f8f.40.2026.10.25.00.19.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 00:19:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 003/100] tcg: Annotate functions in tcg-op-mem.h with
 QEMU_*_NONNULL
Date: Sun, 25 Oct 2026 08:17:38 +0100
Message-ID: <20261025071915.1123867-4-richard.henderson@linaro.org>
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
 include/tcg/tcg-op-mem.h | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/tcg/tcg-op-mem.h b/include/tcg/tcg-op-mem.h
index ea35a02fb4..29e7c02f25 100644
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


