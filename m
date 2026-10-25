Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212F3606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 07:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=UShLuMFK
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKsWC-0006FQ-KW; Sun, 25 Oct 2026 03:19:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsW8-0006D2-7L
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:19:45 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsW6-0003hx-HP
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:19:43 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-48df4f540ebso1024357f8f.3
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 00:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792912781; x=1793517581; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nt7M+Qo+bKAyzoRWzFOzjrG9FV0vc6Mdvvx89qq85cY=;
 b=UShLuMFKxuSpyotCQbXc5MoPTRgHY84p69mzbtxQFdDHVKLmS6caaPDLb+ntHvbOvm
 5Q+uElSbQq7wd9kV0eP/mF6Bw3ChSo6SBjcQyZoTbV93OqhLjYKdV3KrrcjGX4T62KYk
 KI9JmloqN4exqVWzpgsDZIevMkS80SFLgEjbBPnzezcwuFbEMnSWZWYoAyFqJ87xL5cW
 g5yxuB8SYnvHYUJ8sViyFuBOaw02ABJBa/j9mdVcYAxYo/Omc/wHp3KvBlBEKIFG9HCl
 GYF4NEITb78TOQE25Uys++APptJJpJfL4Kcl260BeAMnoT5fRM+BhnVBfCoLo1xrFYE+
 8IVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792912781; x=1793517581;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nt7M+Qo+bKAyzoRWzFOzjrG9FV0vc6Mdvvx89qq85cY=;
 b=xpfLAsMgNDax4wPI5urIQRTWS4paqLO+0Xduus32l2AkCQWUHTAM03F8hUi1nfugOW
 sRz71O8TGeFp00RezLCsGqu9ej9PbkToAWGTMFBVp+V8BG/Zvn9Iji44PcawksJaE6z4
 z+sN+zD4Z1wdn82tjVA2gpfB1PfZ4qt5k+F0FRykqF9YIrdmDSVpoxw/hgWPpjspbbV7
 E2CziXhTrgtcZh5HzarDMwCLxzVqB1M8/97Gr4NDmYeglVh1o/lzuWkg7kNQdXrtXtl3
 NrWUzkQ+yPTnGChouuNdXbidT4f9STw8tFuEvRMSXC0XVNeuPL2zoFB3kvjMamRbFsxf
 msaQ==
X-Gm-Message-State: AFq9FYKbFmuu6yWJrHrH1g18MyhQEQ4HaquF9NCttk0e8Cmxz/Gl4gq5
 +i1N/SF1mk2ROYY+hg06d3KVL5VnmzcNnjRXGTQ9zREibEkZwBZciQWX5Bq/7U0q7ZN4Ftj4sjZ
 1nM2cccw=
X-Gm-Gg: AYBFou1o2CYHMsEZZEruZx+M177QosbkXmuPEREm/JhP8LvfGusdooDUjkBYWh1Bqut
 ChRjo0pZ/XfqoFv7R0rBNgUvfoMeLJR4u8ZZvv7fGir14Roh0ffokdkSX3eUg9TWU5zAZNJ/t3w
 meeay1xvk8FgovnXHpGO8ZYYI+ZRsS8tAKV5hpQrPdGeb9whVSXwzTUJNCvisjf+ddOIfH8NpSz
 MC7uHkfb00FwujJub2tUU/iO/t6xpIlrA+4iwjNrNXQ3fZzMpDm0tXxMtO9ChTDoAeDN0OJTV7n
 GdKYMVqoFknVcOkN1gxYr4yZeaDcBTWpqqgmApo9bq4UF8eGpJCZAwJen+QBog5hUmw30IecpU+
 h19ryLgTN24+ngZiWonjRSbc+5oKjHNxk5Qxz5dopXk5KrsZH6ZlJE4+wcQ/EavmRAE9yjGOzm1
 8cd4eR3tWvHQkPx3X6V/M9W+RPS9u+ErP2VIxd8OQS8IhhUAtUXVGppsKmVz0prJ6GymDz4ORda
 WTA1NEbGabB7vZXx59qnR46mO5BYi5Ao9KbmFMMfeKIcVFCT0PaqOVGLnuW5o/IKvOeK8yn6a6p
 Rzw=
X-Received: by 2002:a05:6000:2408:b0:48d:fbf4:895e with SMTP id
 ffacd0b85a97d-48e3eb86626mr7649566f8f.11.1792912780783; 
 Sun, 25 Oct 2026 00:19:40 -0700 (PDT)
Received: from stoup ([176.95.65.245]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e4806e208sm4006309f8f.40.2026.10.25.00.19.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 00:19:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 019/100] tcg: Generic expansion of tcg_gen_shl_*
Date: Sun, 25 Oct 2026 08:17:54 +0100
Message-ID: <20261025071915.1123867-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261025071915.1123867-1-richard.henderson@linaro.org>
References: <20261025071915.1123867-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42c.google.com
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
 include/tcg/tcg-op-common.h  |  2 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 15 +++++----------
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 7ff99a7671..e1c59b1915 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -210,7 +210,6 @@ void tcg_gen_st8_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st16_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
-void tcg_gen_shl_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_shr_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_sar_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_mul_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -314,7 +313,6 @@ void tcg_gen_ld32u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld32s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
-void tcg_gen_shl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_shr_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_sar_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_mul_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index ad298b7e30..3e6dd1eaf9 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -9,6 +9,7 @@ DEF2(mov, TCGV, TCGV)
 DEF2(movi, TCGV, TINT)
 DEF2(neg, TCGV, TCGV)
 DEF3(or, TCGV, TCGV, TCGV)
+DEF3(shl, TCGV, TCGV, TCGV)
 DEF3(sub, TCGV, TCGV, TCGV)
 DEF3(subi, TCGV, TCGV, TINT)
 DEF3(subfi, TCGV, TINT, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 5a0c7246d1..7cbfcad24a 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -409,6 +409,11 @@ void tcg_gen_or(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     tcg_gen_op_ttt(INDEX_op_or, type, dst, src1, src2);
 }
 
+void tcg_gen_shl(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    tcg_gen_op_ttt(INDEX_op_shl, type, dst, src1, src2);
+}
+
 void tcg_gen_sub(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     tcg_gen_op_ttt(INDEX_op_sub, type, dst, src1, src2);
@@ -500,11 +505,6 @@ void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg)
     }
 }
 
-void tcg_gen_shl_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    tcg_gen_op3_i32(INDEX_op_shl, ret, arg1, arg2);
-}
-
 void tcg_gen_shli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
     tcg_debug_assert(arg2 >= 0 && arg2 < 32);
@@ -1493,11 +1493,6 @@ void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_st, arg1, arg2, offset);
 }
 
-void tcg_gen_shl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    tcg_gen_op3_i64(INDEX_op_shl, ret, arg1, arg2);
-}
-
 void tcg_gen_shr_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     tcg_gen_op3_i64(INDEX_op_shr, ret, arg1, arg2);
-- 
2.53.0


