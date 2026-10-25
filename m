Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B02606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 07:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=DPqcJe2g
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKsWu-0007i2-OC; Sun, 25 Oct 2026 03:20:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsWP-0006Ud-Pw
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:20:02 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsWO-0003kz-2l
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:20:01 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-48b042c0759so1202038f8f.2
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 00:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792912798; x=1793517598; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=liEtIhXZJlZoVUXFtoGAY4FFcQ90scY8UPi61nzET8M=;
 b=DPqcJe2gmSPWQKO2ENGHvZ3ygB7FqPpvqUiXKwzygDX8BM+mCMBjp2XYRqIkFCUWll
 bCjaUf1cs91homAa+h4ZU19RSqateIlWz7k3SVuvorq3+a88ILi91A7zkCuMtmAxHMtl
 zLWi9U3ekANCt3MlLoKA3BPA5ESM0ucAF9n2Da9clwj9diC7S/5mVneDaCMVvWuH288N
 0MuCd1mbv8dXP65q3EfP7FJC6Xe0j08OZQlO0OhaQMuLs7so5AfVOaBz1SZdCde3fXNe
 aFaPtMhfqrupcx+pX+raNeVs5T+DMfvUHxDPSsCrmtGOxX9UQIPoJr47L0RhjU34k1gb
 GD8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792912798; x=1793517598;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=liEtIhXZJlZoVUXFtoGAY4FFcQ90scY8UPi61nzET8M=;
 b=HbNbk7TGWZfroUUzGNKwZ4RmyrTil+Xh2eQfcnZPOAdc6SDHxZv3T/z68kHT0NhV/4
 0nrkOhRNJEfKrTeGrzyrBEMeKULgGu6zOMwD2HKRledkEkS3P4KRAxUcVc74U9B9/QHS
 cW9v9OEbiwYBgBvMNNZuq2pGJIxLdLTnLG+iFb64kcgtzRi5E4l4XM9EHy5gd8Prsy5D
 I5tlk547dFaXF7LpFtVV3p0jDRJkeYZlleR4Yw5hOWJm+DqHgA2RPh2G2yjL2isxjQvS
 wVvJZzIwAwsyzXkCogvdqA9Ec0dhIxMNylTN/wP2pzhrml8drjPcWagkk3tNa7sL6Wag
 EW4Q==
X-Gm-Message-State: AFq9FYIkzKOvjgelySlHMeuQkN5wSN+jH8W5k0SkaRriZlizJArUqe30
 u+qn3RU1v9rCA8F/fOZeSfKiGxlgzjwLYsn1WUM1GJ67eXJtWHwuNGV76987h4gvX79WChI91Ix
 8fzVyLQs=
X-Gm-Gg: AYBFou08CuCscOGoVEeqQOvxLjTZHBYIvzdYkuGLMj7X3cpYMd2iohr4ueGR5p+d10/
 ZeQjrcetHqnvmZXBr74Ou8hmgL7EifK2ZJ5hOC4Doj5BnOF2INRp8B6wVfR+nEttQW4XOckdB/Z
 JgkMF7+UEVyoQQTmVmH/lmOUADPQegwuj6xjkkHELTbBCxAEzvgJkvI5+a8Gu6659XvOs5dwQ55
 FlKmkxn3FshuuqN9qPwUIRjHcvYQYfeyWgJvC4Y+TNwmh6rkbdsT7TL8eWztqf0esp84ay/a37c
 m6nnrLVHXrwfisBFEhkPYhG94SD56kKq2hBMpOz6KceGMD0Tnh1K2NWbaSSzWs10yAIJlmMzVW4
 aMeTQHvNlpBGaJrduPg7pE22Gqrh8yzqsghaPMkQV5/7vUGiE6YKDrACsTA9h0GhIczdHT5Dip2
 zieyUYD1VwmBXoodel24mrgqTs6MBWXS4wPV7KiZxEWtE/I7UEVxFK9tWCaM8UkXlrq6+PyvfZX
 +fQVWURm64OFOhYm62axqvUwSK+7R9+kUPN2RY68U5CywFCAGNf8DRUcg==
X-Received: by 2002:a5d:5704:0:b0:48c:7caa:12cd with SMTP id
 ffacd0b85a97d-48e3eb8e543mr3894687f8f.22.1792912798311; 
 Sun, 25 Oct 2026 00:19:58 -0700 (PDT)
Received: from stoup ([176.95.65.245]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e4806e208sm4006309f8f.40.2026.10.25.00.19.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 00:19:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>
Subject: [PULL 037/100] tcg: Generic expansion of tcg_gen_eqv_*
Date: Sun, 25 Oct 2026 08:18:12 +0100
Message-ID: <20261025071915.1123867-38-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261025071915.1123867-1-richard.henderson@linaro.org>
References: <20261025071915.1123867-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x433.google.com
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
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h  |  2 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 30 ++++++++++--------------------
 3 files changed, 11 insertions(+), 22 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 70d5b991b3..4eb35775a0 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -123,7 +123,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_eqv_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_nand_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_nor_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_orc_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -200,7 +199,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* 64 bit ops */
 
-void tcg_gen_eqv_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_nand_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_nor_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_orc_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 7386332658..6a4d726b79 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -9,6 +9,7 @@ DEF3(andc, TCGV, TCGV, TCGV)
 DEF1(discard, TCGV)
 DEF3(div, TCGV, TCGV, TCGV)
 DEF3(divu, TCGV, TCGV, TCGV)
+DEF3(eqv, TCGV, TCGV, TCGV)
 DEF2(mov, TCGV, TCGV)
 DEF2(movi, TCGV, TINT)
 DEF3(mul, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 860c9678f9..c38accac75 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -437,6 +437,16 @@ void tcg_gen_divu(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     }
 }
 
+void tcg_gen_eqv(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    if (tcg_op_supported(INDEX_op_eqv, type, 0)) {
+        tcg_gen_op_ttt(INDEX_op_eqv, type, dst, src1, src2);
+    } else {
+        tcg_gen_xor(type, dst, src1, src2);
+        tcg_gen_not(type, dst, dst);
+    }
+}
+
 void tcg_gen_mov(TCGType type, TCGTemp *dst, TCGTemp *src)
 {
     if (src != dst) {
@@ -675,16 +685,6 @@ void tcg_gen_negsetcondi_i32(TCGCond cond, TCGv_i32 ret,
     tcg_gen_negsetcond_i32(cond, ret, arg1, tcg_constant_i32(arg2));
 }
 
-void tcg_gen_eqv_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    if (tcg_op_supported(INDEX_op_eqv, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_eqv, ret, arg1, arg2);
-    } else {
-        tcg_gen_xor_i32(ret, arg1, arg2);
-        tcg_gen_not_i32(ret, ret);
-    }
-}
-
 void tcg_gen_nand_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     if (tcg_op_supported(INDEX_op_nand, TCG_TYPE_I32, 0)) {
@@ -1722,16 +1722,6 @@ void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg)
     }
 }
 
-void tcg_gen_eqv_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    if (tcg_op_supported(INDEX_op_eqv, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_eqv, ret, arg1, arg2);
-    } else {
-        tcg_gen_xor_i64(ret, arg1, arg2);
-        tcg_gen_not_i64(ret, ret);
-    }
-}
-
 void tcg_gen_nand_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (tcg_op_supported(INDEX_op_nand, TCG_TYPE_I64, 0)) {
-- 
2.53.0


