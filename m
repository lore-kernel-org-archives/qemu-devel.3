Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE3C606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 07:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=LhbmI9zs
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKsfX-0004Ch-Ij; Sun, 25 Oct 2026 03:29:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsd7-0008VI-R9
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:27:03 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsd6-0004cE-4k
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:26:57 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4a214c5c4c0so14890565e9.3
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 00:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792913215; x=1793518015; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=i/AH5B2OjNsOhTogWEH0XnxXxXTldLEYEpRrnqfWpYE=;
 b=LhbmI9zsyXxjan/+j2gYadNoOiismCnUFNNyhTD4+f8g0pqqXBxSwKuB/bFPeCAOAS
 RzLV2uOt6EXpIPzaNYxgCZ8X9ND5HinF/haBOkeoDJxYxrdhRiDPmXVgiC0iLKauETjj
 7JgXWsCLV/hZrhHL17zMQWS3ht/2c9Nk1Zq64G9s/xATI3liRr89GiBa0HaRbsxNyQCd
 wpy/27jwRQTK2Y/C276dGhhmLAhLKl4kZWu8E4XSVcNRSB9mNBu+Llp7k8Tj7F83vWnt
 uGb5EoYOJlutWA8kcvi9s/cOUSlqez01jgQTd6ZPx1Ytxt6oJY8tg1NcONboRG2Tm6QD
 wXLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792913215; x=1793518015;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=i/AH5B2OjNsOhTogWEH0XnxXxXTldLEYEpRrnqfWpYE=;
 b=QdT9Z15IM0XJKjklMuaRkrWSkKYDd+bnWlZN2RO4pcVr8lFBJGALsE77L6WGKM1f82
 aln3jQSm685nuphY1QmdbCwPHZP0BdGQ+kOLVHSOe0kil6X0ccxQkCSM1yjZnJsk8wXb
 MQo0Jm9GkWJfsPxCROIQyB2Nxmh7oEgiTzyoOe3IpRLptXZiY9c/U+oHVrgwyViBUtxf
 6YDdW0gQUdu3th8R6AIy/IwnduqsGuCHMVGKffRDeGZbN0/q2fVdNnxR7AepN40BrYV8
 Qe29+5MGx9mgJSzVXZVHjME9FL/mUYpHw3dq2pXAgId+rft4TsW9MEcegGXmBH7Q2y9R
 BQjA==
X-Gm-Message-State: AFq9FYJOI3fHdXpPg7UfPZkBW7yuML6HflTx19GfB/eKoeQBOUFDTTe4
 8FLLM+vyYaJfg6DU70nmOq0bhCS7uvNWFDp7yRqPuoNcUykBiQbmSJfaqFMCEfjRtoRvhKI1Dqz
 vkoD3C4E=
X-Gm-Gg: AYBFou36giReM89X8UxlRHNKFL4Oh6hKKbVyXuPSZlT7ubDZVJtRvTIl6HUdRTZfosq
 VTJKo3dVaX54vcs6FYmYBredKdAhZxTjuzuJxoNtD1m47wOZw3cYrDpLFzlXaImLBkZjJmHvThZ
 TxDMSIiciCnOwEyZvuYeDz942Yb3LI1Yp+G3+Mp9j5QqPh2f7wGvFS3tytJAuFymlksuON9b073
 g+XH2WPwQr3dzNGNKQgTywcpI7Q3oNFwgn7mVlPgVb+P2VJQxyjIsqWo+QyaTyAAq/dJpo7kpSX
 FEMHZsei6JtUPEIa+L3PZNzzv/AhBr3ijC7JmppulixlEIaKGsDGDc9eAYGbSLTMqBhLdL2Fi5d
 K20qf+xCUnqGn85fcspjTdlnC7xo2tFj4SMUFgDJzP3TKPH/vo67h+eKvRwH8IfwhI39sffVGbp
 zJ8ttSuchI/Sw/3GhTTVY91H8w4/KjjN5Xnw5UA3Dt+pIZPBLCAmbZuo7mSZ1A31HWzcow58Glz
 gwezuYSmGphaGww81rRgiMMhkhORAJctXRqkZPBlVSZMdcjGYcbWPu59lk=
X-Received: by 2002:a05:600c:3487:b0:4a1:fba8:b13d with SMTP id
 5b1f17b1804b1-4a35ac8c231mr63522485e9.9.1792913214771; 
 Sun, 25 Oct 2026 00:26:54 -0700 (PDT)
Received: from stoup ([176.95.65.245]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a359fc1207sm82923745e9.1.2026.10.25.00.26.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 00:26:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>
Subject: [PULL 093/100] tcg: Generic expansion of tcg_gen_st8_*
Date: Sun, 25 Oct 2026 08:19:08 +0100
Message-ID: <20261025071915.1123867-94-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261025071915.1123867-1-richard.henderson@linaro.org>
References: <20261025071915.1123867-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x334.google.com
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
 tcg/tcg-op.c                 | 15 +++++----------
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 469b925fe0..cd66b0d7de 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -140,7 +140,6 @@ void tcg_gen_revbit32_i32(TCGv_i32 ret, TCGv_i32 arg);
 /* Replicate a value of size @vece from @in to all the lanes in @out */
 void tcg_gen_dup_i32(unsigned vece, TCGv_i32 out, TCGv_i32 in);
 
-void tcg_gen_st8_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st16_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* 64 bit ops */
@@ -159,7 +158,6 @@ void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg);
 /* Replicate a value of size @vece from @in to all the lanes in @out */
 void tcg_gen_dup_i64(unsigned vece, TCGv_i64 out, TCGv_i64 in);
 
-void tcg_gen_st8_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st16_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st32_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 514967f91d..90bcf9e5ab 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -71,6 +71,7 @@ DEF3(shri, TCGV, TCGV, TINT)
 DEF3(smax, TCGV, TCGV, TCGV)
 DEF3(smin, TCGV, TCGV, TCGV)
 DEF3(st, TCGV, TCGv_ptr, tcg_target_long)
+DEF3(st8, TCGV, TCGv_ptr, tcg_target_long)
 DEF3(sub, TCGV, TCGV, TCGV)
 DEF3(subi, TCGV, TCGV, TINT)
 DEF6(sub2, TCGV, TCGV, TCGV, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index ea0d281902..6925b1ef2d 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1257,6 +1257,11 @@ void tcg_gen_st(TCGType type, TCGTemp *val, TCGTemp *base, tcg_target_long ofs)
     tcg_gen_op_tti(INDEX_op_st, type, val, base, ofs);
 }
 
+void tcg_gen_st8(TCGType type, TCGTemp *dst, TCGTemp *base, tcg_target_long ofs)
+{
+    tcg_gen_op_tti(INDEX_op_st8, type, dst, base, ofs);
+}
+
 void tcg_gen_sub(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     tcg_gen_op_ttt(INDEX_op_sub, type, dst, src1, src2);
@@ -1408,11 +1413,6 @@ void tcg_gen_revbit32_i32(TCGv_i32 ret, TCGv_i32 arg)
     }
 }
 
-void tcg_gen_st8_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset)
-{
-    tcg_gen_ldst_op_i32(INDEX_op_st8, arg1, arg2, offset);
-}
-
 void tcg_gen_st16_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset)
 {
     tcg_gen_ldst_op_i32(INDEX_op_st16, arg1, arg2, offset);
@@ -1430,11 +1430,6 @@ void tcg_gen_ld32s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_ld32s, ret, arg2, offset);
 }
 
-void tcg_gen_st8_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
-{
-    tcg_gen_ldst_op_i64(INDEX_op_st8, arg1, arg2, offset);
-}
-
 void tcg_gen_st16_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
 {
     tcg_gen_ldst_op_i64(INDEX_op_st16, arg1, arg2, offset);
-- 
2.53.0


