Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40842606A319
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 14:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Rk0xpXcZ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJXA6-0005On-13; Wed, 21 Oct 2026 10:19:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJX90-0004bP-3j
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:18:20 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJX8x-0001ZU-Qm
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:18:17 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-49d05d51553so5737215e9.2
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 07:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792592294; x=1793197094; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qa3LHO8Fhi0BDuKOQTvQC4b74siYIGQ54SUOzZRc8j8=;
 b=Rk0xpXcZOcH1Fgzw0WCts4rVDrzdjZjf19V7WywoFPa5eoLZ4B8hSeFNps+nmx2rxZ
 ZUAg331RMV/FWmADjOuEKybaIIuT1fu3GGiBACoV+ADt9RwLMK7PoQ2r19CfNQzEpBke
 /VcqmJTax3H/YM5uFPce4Q+BvJOB6VfOx7Cit2ZstZtgGXZqxrk5SMRrqb8b8Qm1c/mQ
 GsrWgvp3KvXTr7ZeHKmITngulFRWVjaMfrYGFXuLGqfNF9M1ObqdsV4UVzWZMqgmELee
 rI20UPwTw3VXsVWmgHIFUxCcmSL/OdATIAuHbMJc30yflrlAvCgS8fFFeO07k1e1nB59
 tKyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792592294; x=1793197094;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qa3LHO8Fhi0BDuKOQTvQC4b74siYIGQ54SUOzZRc8j8=;
 b=LhQofVjcPruZtg1DGpORgytuUsjYtQoMGKSRktqWo0kNuaOIcuUEeK6IJp1RAeZ89m
 dzlYdvMIQOtRlPEq513l0KId8Bui5jycjJJm9TFkL9YIN24ALjYkSjCT1g4qkfI4/25c
 LLi5qNAScX/vOxxz1BaniZuIgBeXxOzsgMbyRuUpUW+ygcHw9c9h96RyymXAsKglS/Hn
 ByPtMB5BHajNqWEr3Of/3I311P5a47SakEbKPBpO6WFGxCCvgIoWeU5ZjibmTpQUM4P7
 TTMc9guIUgexcga/2oPDpDBEQpXJkccsfRw8XBxu/vdmDcl8nXLzcBOiwZX0mdG7jS3z
 oXCQ==
X-Gm-Message-State: AFq9FYJuouwnas17EugzoJqGG8cKR6BxKswzW1ssufN/QMhRYEcxLY84
 ooSv2SRQsVhIDmpdVTCkm9JH2NjyNmqRCTDl3gkcBRMBYE9vWkphbaYkk/fhVJvrnYEH82BrKi6
 hGYny1Ck=
X-Gm-Gg: AYBFou05Oujhm6y7zH9F2l6/vB/vzin+LgjpPx6ldUprMKkwg3vj5M3Sgu31JqwbyGr
 XAE5PIGpjDvR3Zhs+QEWsd4kE2OO/yL/g1JDrHFWeA/1uP94wZWazGdpo3QiZu4B6SwSb0SCHgl
 N21cJ3rbmkwFJZY+/6s1raezg7Zz5MOqlyb/9yAc+HSgFik0syu1y/T4S5UsC+oP2c1yKpzagGf
 C3G3C6NVbOiLJ07hgB/30jFqVnkgG+9Hn/KEyxwON7eASjVuo0bpCC7ikoIdDcKywRCqGGq5dS/
 liz+NJ1wrz8LMmkkw0iGt1E4d4ij9Vsj5gJKIXDa9N1pxVK3GL4TmETT5C9zQ0OTsZlGNiYZBE5
 Y0TtUguEqXrC0qhlkPKpCaQpZJlR9qj/kmmQU8/Q+ovh4tejuw43AOFBHyUqOuZbEqE1Pw559xF
 t45a+qHne7Bm39GalNvILs6Wy46ACKDIQ0BHh4PfABNXsqBWyyaBKfngzUbin7BIS0WsBHR8I4/
 ttMjxVMxMj7vLHBAMmKmTAaSkknT1+EIQjJMoptY8GX57TeaHwzMfjpZlX2IuErEvRIjOs/VOhj
 vhhTq8Iz/uztqh+HSQRYfQqOZ9M=
X-Received: by 2002:a05:600c:46d3:b0:4a0:5b:7bc0 with SMTP id
 5b1f17b1804b1-4a1fdd19e23mr47360115e9.21.1792592294187; 
 Wed, 21 Oct 2026 07:18:14 -0700 (PDT)
Received: from stoup.fritz.box (pd95f64ec.dip0.t-ipconnect.de.
 [217.95.100.236]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1f2c242dcsm147113845e9.0.2026.10.21.07.18.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 07:18:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v6 021/100] tcg: Generic expansion of tcg_gen_sar_*
Date: Wed, 21 Oct 2026 16:15:33 +0200
Message-ID: <20261021141652.363109-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021141652.363109-1-richard.henderson@linaro.org>
References: <20261021141652.363109-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32c.google.com
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
 include/tcg/tcg-op-common.h  |  2 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 15 +++++----------
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 96d351e634..74cff518ce 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -210,7 +210,6 @@ void tcg_gen_st8_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st16_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
-void tcg_gen_sar_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_mul_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg);
 
@@ -312,7 +311,6 @@ void tcg_gen_ld32u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld32s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
-void tcg_gen_sar_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_mul_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 
 /* Size changing operations.  */
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 573a4963b4..96bd6abd74 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -9,6 +9,7 @@ DEF2(mov, TCGV, TCGV)
 DEF2(movi, TCGV, TINT)
 DEF2(neg, TCGV, TCGV)
 DEF3(or, TCGV, TCGV, TCGV)
+DEF3(sar, TCGV, TCGV, TCGV)
 DEF3(shl, TCGV, TCGV, TCGV)
 DEF3(shr, TCGV, TCGV, TCGV)
 DEF3(sub, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 3c98d204d4..07e7c83ffb 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -409,6 +409,11 @@ void tcg_gen_or(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     tcg_gen_op_ttt(INDEX_op_or, type, dst, src1, src2);
 }
 
+void tcg_gen_sar(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    tcg_gen_op_ttt(INDEX_op_sar, type, dst, src1, src2);
+}
+
 void tcg_gen_shl(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     tcg_gen_op_ttt(INDEX_op_shl, type, dst, src1, src2);
@@ -530,11 +535,6 @@ void tcg_gen_shri_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
     }
 }
 
-void tcg_gen_sar_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    tcg_gen_op3_i32(INDEX_op_sar, ret, arg1, arg2);
-}
-
 void tcg_gen_sari_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
     tcg_debug_assert(arg2 >= 0 && arg2 < 32);
@@ -1493,11 +1493,6 @@ void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_st, arg1, arg2, offset);
 }
 
-void tcg_gen_sar_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    tcg_gen_op3_i64(INDEX_op_sar, ret, arg1, arg2);
-}
-
 void tcg_gen_mul_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     tcg_gen_op3_i64(INDEX_op_mul, ret, arg1, arg2);
-- 
2.53.0


