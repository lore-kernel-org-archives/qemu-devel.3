Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486A2606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 07:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=KKuIkRNr
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKsWR-0006W3-MR; Sun, 25 Oct 2026 03:20:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsW3-0006Bx-DH
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:19:39 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsVz-0003gn-FK
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:19:36 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4a1b07c3c5fso19370615e9.1
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 00:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792912774; x=1793517574; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=UGuG8jzKukQymmrac3ayQ3DwMlweDNEkFJ60Q1Koets=;
 b=KKuIkRNrVPnl1gK+ipT6CNthVBQ2QyTvre0gJYqpy8nnfgNsz+U4mk2JwVE1zyvNfN
 zrmir9/D9K35Ec733/u24SFFGcsP2Qqyxktu1ze13dsus20JuYMc5Uq8jQdLDUmiUylR
 e+8joOZHqM8WS6pBR8xMpHDbSfeBYO33OsVmVi2dYCoVMy/hkBHbkirY+uQtr4t4ftPo
 sDLmatAowjQvNwhM5fug45s7WsLvWchQ4w72lRv/j90PIMlCzpYnN67S4ZpWi9HAugWK
 KvRNlsZqtDuMi/69wjoaXl7xOsA7vgNyz+c/TbCJsFNIvdzLjv446vItoWCFFAbFZ+qL
 TuvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792912774; x=1793517574;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UGuG8jzKukQymmrac3ayQ3DwMlweDNEkFJ60Q1Koets=;
 b=YVHP+AyhEgQ7z9/DzYQuLNnKeEJ/mesr6WxUaZ50Gs8mqoXBCA4ZceDpyo2x12fb1i
 g5PSWnrvnrjcnX4MSqoGdA/UoAT5XeTpFeu+90JRreijN6O2DPncjU9yYNPjMoFmX0Nh
 n83p+7E7XNcfri/aJXHRMDzAZ85BR7yP/FFra/Q6k7xk0hkkHsXMCC4GlH/Xz0VZFlpI
 27p1hTDu88aoj2jlCon5JIEdTuS4UjVYJeYnw/ApciyJk4h+8q7g0+YTco0pFOlHKaZj
 FFvb6HBTg7DlPy9PoVIgzTvoY0THJCvp8e1DJaAxqHwjjEM7S9BwI4jwLhipz0i37xpb
 gK3A==
X-Gm-Message-State: AFq9FYLSbzRXSQrkSxK3VonCaUNKd/RVQmjJMZvnzlqWnp3MAIfPn0me
 cgnr+N4ZkdtTJiepmH9uSbGyVVKTLqWJuSPj13319+eEc1EnM5VmbvZvRe21Cn6k1GkymTkIEkn
 rvjJCiEA=
X-Gm-Gg: AYBFou2EIMhTWB+LjXz0BZ6WAL4cQUbxGhrJU0BmFG/jJ1V0qvTl4FMu90XnbqXB5L1
 L1TDXXPUXNfkdO3/I86ZWQZ/6Vp3cQ8R4XJDWUFkvU+SLBhuBxGTlKIVoEzcXp4YbakHNJ+2ptQ
 7+Z7dnpMIWhLcDl5eFvikGuVPhsewVY+85pb6m9mQwTvzqSHLQKqyE2VJJE2jTbYlhzoGuuHFl1
 THkAwvs4JRvlLumhlHlRYXSNTOSZzeA6k6Cg45UYb4a+OJXsVe3RxThPxkQTwX8GEFpVpHqSMWb
 gHRR5ys12Mxa6p2Pg53CQhh/73kKvwEBEjKsupV35FOrmBZguzAVxuuv2MNq0GQMAeFkpWZHWkK
 ZiEV3+S7HfCik/a8ORH8mvSVqqDNIWj8VOB51OGJoZ9PmWUWGwY5JVB+cfFFBIo7HxZaSxzY7W3
 1rVjRNjzO4iN26ocBEmN5AzrBHZpYaxnS2dSztSLAl3Fs4L8pevm20ooKRgyk8VD4kYY5xbrKG3
 aZ91Vgg7sqtnEiNZxYkEANqQbm9xAhdNqMbVbe2lSu1JzsWplxxh7nGOQ==
X-Received: by 2002:a05:600c:8b62:b0:4a2:150f:1610 with SMTP id
 5b1f17b1804b1-4a35acd5f91mr51376275e9.23.1792912773747; 
 Sun, 25 Oct 2026 00:19:33 -0700 (PDT)
Received: from stoup ([176.95.65.245]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e4806e208sm4006309f8f.40.2026.10.25.00.19.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 00:19:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 012/100] tcg: Generic expansion of tcg_gen_sub_*
Date: Sun, 25 Oct 2026 08:17:47 +0100
Message-ID: <20261025071915.1123867-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261025071915.1123867-1-richard.henderson@linaro.org>
References: <20261025071915.1123867-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x336.google.com
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
 include/tcg/tcg-op-common.h  |  3 ---
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 13 ++++---------
 3 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 61eced5ad1..e2e8c66d01 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -212,7 +212,6 @@ void tcg_gen_st8_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st16_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
-void tcg_gen_sub_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_and_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_or_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_xor_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -315,8 +314,6 @@ void tcg_gen_st8_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st16_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st32_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
-void tcg_gen_sub_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
-
 void tcg_gen_ld8u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld8s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld16u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index faa83a09b2..51d5ec6e06 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -6,3 +6,4 @@ DEF3(addi, TCGV, TCGV, TINT)
 DEF1(discard, TCGV)
 DEF2(mov, TCGV, TCGV)
 DEF2(movi, TCGV, TINT)
+DEF3(sub, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 9544688daf..563c3bb038 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -394,13 +394,13 @@ void tcg_gen_movi(TCGType type, TCGTemp *dst, int64_t src)
     tcg_gen_op_tt(INDEX_op_mov, type, dst, tcg_constant_internal(type, src));
 }
 
-/* 32 bit ops */
-
-void tcg_gen_sub_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
+void tcg_gen_sub(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
-    tcg_gen_op3_i32(INDEX_op_sub, ret, arg1, arg2);
+    tcg_gen_op_ttt(INDEX_op_sub, type, dst, src1, src2);
 }
 
+/* 32 bit ops */
+
 void tcg_gen_subfi_i32(TCGv_i32 ret, int32_t arg1, TCGv_i32 arg2)
 {
     if (arg1 == 0) {
@@ -1493,11 +1493,6 @@ void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_st, arg1, arg2, offset);
 }
 
-void tcg_gen_sub_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    tcg_gen_op3_i64(INDEX_op_sub, ret, arg1, arg2);
-}
-
 void tcg_gen_and_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     tcg_gen_op3_i64(INDEX_op_and, ret, arg1, arg2);
-- 
2.53.0


