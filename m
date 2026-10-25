Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9219606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 07:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=CM6qc6cJ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKsWF-0006HD-AQ; Sun, 25 Oct 2026 03:19:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsWB-0006Ew-AV
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:19:47 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsW9-0003ia-KB
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:19:47 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-48e47347279so250999f8f.1
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 00:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792912784; x=1793517584; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LbZawIqinvZ8+sAk4f0dvI6uKnMn+HebWQ+xcbT8z6Q=;
 b=CM6qc6cJCxnahbMSP9dx8l64gfaZf4dpMmX0vx3x6bcdGjvJExNo0GY9aAP8rd9RiI
 1jSAe0sbOJZX0pQ7TmjWkaBPd5HuLmDtUiph6y5Zk22WR3E70ripFTwFsddtpvhcMTaT
 kaosDkPzrboqHBvAbwgH5Af0irnMiYzalWa7UhqO/Vq2XdctnDsomyFnmQ2NhligSk4c
 Rhic5A2UGQPbZKQ3lMm5g1tb08Jj0U32l11zfsnoMauwm6JzbIZTnM7qTDvrymDB/sLs
 wzv2Y2lqfsdcUH9tjU9EL7d/2+bE6rQGvzZ5NTLXYQEC26ID14WLZf85GKIoNUODtulA
 oU5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792912784; x=1793517584;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LbZawIqinvZ8+sAk4f0dvI6uKnMn+HebWQ+xcbT8z6Q=;
 b=SjLcu36BV7cDq5ViPSQgmVcijeeGBaz8hdbVInaSvL+abCVxdvOrdvu6ewdl7tsIJm
 m8olpqCjEyzbQpmiPRd5kDwONts62KGR4hOxyPaiEbU6m+y+U2rtFFmGaVbXqKEq9GRZ
 WNj5zBUNMgwm4F9Z8HaE1lXVFeRiOGdpAaZtHBiL1KXWvrVr+ijUVkrabG1qQOIAyR8i
 i9+osLRyj+DOakR4BPzsCyvusF56TgMxSY7Ur07AIggi7XFV0ekJ7GM6jOcv1qw96so0
 7AqjcyrP6YbBFfwmrIUWIIz1owpfLE3KZxW6ufhQRlzkXwaDhnz0QgDQt6mN39d8dqgs
 2/wA==
X-Gm-Message-State: AFq9FYL7Un/H/GRpBq4ZnDY6GZcrM+zknhxYFlgr9rI81W26PdhvkyTi
 p5OenXsARacU37iZaqej4JPsW+NrwbiHbCyUK3FlkExWECimZmCCWg0kG+F9LRxKksgsvHtRQpt
 UeAnogNM=
X-Gm-Gg: AYBFou2gq8h37HULwuizgWqZ6VzzeqfRZoaxPGAcKw6Q79b+zRM1w8uhZRSadiszJdz
 EWVYTxAZIwZsfTL6gOWybLYRc0mckdHbh5TLzLQYRtGUfUHqesi7HmN0d5Or32++8SJh08R1JnQ
 WaT3uGCRuz2FIYieMiRs8CGCCmOLscUhbPmtb9jx9nTZqNeiI2HXJPa+tsr1NWP9bZMxUD5B2xx
 l0cPYe8ar/uzYxfb1lcNgi+srb5+gcjFAaqYT5PUbiZg/QQuiLu7oA4Wyu8vOMgPIR/xTWvrlJP
 vUpRQf78dHGNx+/NCoJJHWhUbbtMlaI0DeyfqM4OFNRpp3ESLpRidh2nrxM5zcsd6uPqRy7MJ0v
 P+Cx2mIYCEhIMakoQ5nntd1aAuLpkB++rfJgJtcjTaLObJu11ZrIQNOHN9zySat2Z+vDX/KpGSs
 oolrj6wcZj/IIjPCuFF0tEXcznKnMDyE8kxDatxD419XytvQ/atS+GsWLvU3P6hCUblobvZO6Bg
 olbs+buOgcU/0rANq7OZNrWuRMQGvsaDljxqjooz9hoLcUoYl+qO1y9vc72IKYsXI+TVCkwXv/T
 7QM=
X-Received: by 2002:a05:6000:4313:b0:487:13f:f612 with SMTP id
 ffacd0b85a97d-48e3eb94194mr6073679f8f.37.1792912784191; 
 Sun, 25 Oct 2026 00:19:44 -0700 (PDT)
Received: from stoup ([176.95.65.245]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e4806e208sm4006309f8f.40.2026.10.25.00.19.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 00:19:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 022/100] tcg: Generic expansion of tcg_gen_mul_*
Date: Sun, 25 Oct 2026 08:17:57 +0100
Message-ID: <20261025071915.1123867-23-richard.henderson@linaro.org>
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
 include/tcg/tcg-op-common.h  |  2 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 15 +++++----------
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 74cff518ce..76e67acab8 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -210,7 +210,6 @@ void tcg_gen_st8_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st16_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
-void tcg_gen_mul_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg);
 
 /* 64 bit ops */
@@ -311,7 +310,6 @@ void tcg_gen_ld32u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld32s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
-void tcg_gen_mul_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 
 /* Size changing operations.  */
 
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 96bd6abd74..c1273a1019 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -7,6 +7,7 @@ DEF3(and, TCGV, TCGV, TCGV)
 DEF1(discard, TCGV)
 DEF2(mov, TCGV, TCGV)
 DEF2(movi, TCGV, TINT)
+DEF3(mul, TCGV, TCGV, TCGV)
 DEF2(neg, TCGV, TCGV)
 DEF3(or, TCGV, TCGV, TCGV)
 DEF3(sar, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 07e7c83ffb..1e85ff545b 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -399,6 +399,11 @@ void tcg_gen_movi(TCGType type, TCGTemp *dst, int64_t src)
     tcg_gen_op_tt(INDEX_op_mov, type, dst, tcg_constant_internal(type, src));
 }
 
+void tcg_gen_mul(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    tcg_gen_op_ttt(INDEX_op_mul, type, dst, src1, src2);
+}
+
 void tcg_gen_neg(TCGType type, TCGTemp *dst, TCGTemp *src)
 {
     tcg_gen_op_tt(INDEX_op_neg, type, dst, src);
@@ -601,11 +606,6 @@ void tcg_gen_negsetcondi_i32(TCGCond cond, TCGv_i32 ret,
     tcg_gen_negsetcond_i32(cond, ret, arg1, tcg_constant_i32(arg2));
 }
 
-void tcg_gen_mul_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    tcg_gen_op3_i32(INDEX_op_mul, ret, arg1, arg2);
-}
-
 void tcg_gen_muli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
     if (arg2 == 0) {
@@ -1493,11 +1493,6 @@ void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_st, arg1, arg2, offset);
 }
 
-void tcg_gen_mul_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    tcg_gen_op3_i64(INDEX_op_mul, ret, arg1, arg2);
-}
-
 void tcg_gen_andi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
 {
     /* Some cases can be optimized here.  */
-- 
2.53.0


