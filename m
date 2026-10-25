Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC53606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 07:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=CURjefzs
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKsWX-0006mM-Tf; Sun, 25 Oct 2026 03:20:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsWP-0006Th-Ls
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:20:02 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsWN-0003ko-Ro
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:20:01 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-48441a2ba1bso1202629f8f.1
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 00:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792912797; x=1793517597; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cYkqfLOE+S4Jq+BJgKTeHc7upTRpGkLmpZUDX78umOU=;
 b=CURjefzsYcSW+5z+u95jtXf4/4GETV241NEEgq2zsiKyb1dTISGN8sdkkJSg7a8hKM
 xIlR3lRCHstZcfEWFpvt47I3/avoMzAFyhO61C+rV+mGwAb9KWsKsxWvSXO0Jnr9rvpv
 fdNpLSMQRC74dg+cuwRUGX7/RBClIazfAfuLclMk3hmOLWAvWapHYPAwLSd79RsXxOfl
 Q/6/LTRD6q/rr0rGVTov4js0PxOr/feZ5fVh2N9SyCgtULK+iClj/1XKSpKrKkDg0YHi
 NpT9RB8FhwMhbkWqOnsygcWZrrfoB2aPuy7pXINpnNLSocxwT97bUgl5tcK4AbpiIYjp
 WN8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792912797; x=1793517597;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=cYkqfLOE+S4Jq+BJgKTeHc7upTRpGkLmpZUDX78umOU=;
 b=rcOMar6k6Y9/1XIWjX1pXBimoC/8daNPxHhAyjJfH8jMeSsAIL/ZhKfeW6bqg1GBYh
 +XiUahIMPOQhmm7nGBH3YEmvdFf79QdwXQQghPEen4WqrG7fkM8KAM5SPnc//01V3HeK
 OyaCvBIv5Z/9uRL0klZ0dEaa2yV0scMkKxtRie1+SkuNPOEE6lqBRojyaGMOCh2N4oAh
 cFWGa+QBNUzBCS+mfQZJ6Ru398+WQhfklGfEBIqA7Fw8BoTztTYjIOGRmjQ4ZfxzX9e+
 38PwS44stgURb5YOtSCbS8J3FGkT65SXpttPdcnFrp2LrqK4pNSzBHLk/MIu3dW/7P3I
 HnBw==
X-Gm-Message-State: AFq9FYL/08MY+SncF4hnnnnjfZOXw1PvMBWqn9Kr7jR7IHXDrTRqRkAL
 Yur0aku6y+AhNYM3CnamH6d8KbZmlvNb7rpgn1+Hjczp4bh5Z649/6RX0/mLiJ3Nd5ESl+yBxO7
 r9CyGy/c=
X-Gm-Gg: AYBFou2d4Aitr56Gb40nm1pdavSZn76UsTkDsjoLv1ftveP28UhuN8NGAfa9z9Bx4EI
 O4xtOkyv4Os+BD3AYtu/K3h7vgL52V5AmRf2k21+C6zminu5yvyxvHxBVfgP67b5ohi2I3429N9
 bP6EcIikTM7PeIWB0NfexQwDTnWBQebsv9sM/IR0UgQNOtCb6YREqdV3ezzBrbI8zvZI7n9zwON
 Wy7BiE8xhBEm/qzReP5k9UbIcWKRyoRbHY26wmTIf6meXIgSSbzGJlvwNicARWJNQ0Lr61wixec
 HEQDUSqlfCCy+Gy8wSuLK65nUHEz+gab3V43FjOjI82TO6qRYQ9DVv1FGtBVp4SlAKbM6PfTCae
 7f76ZK836MGeRHzeixIj1jLI81VgFpbJ1efCwCaoB1Gf5VQpHADt3v+Ghix/it8Vaw87AsSKVng
 tbcg5irbsA0nv0g6nnTeAN5HPRpnwo6oAsKt+bwAbjLNatACd8N0LjZzalpl/t5hc3ir8Zvcmha
 rmnWjyli42jiy0dMqU7hg7mPdJJJwQeL6pMbta+q6uK+KBLrk8VnxWKuTo=
X-Received: by 2002:a05:6000:4910:b0:487:767:b301 with SMTP id
 ffacd0b85a97d-48e3eba5e15mr5719852f8f.57.1792912797401; 
 Sun, 25 Oct 2026 00:19:57 -0700 (PDT)
Received: from stoup ([176.95.65.245]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e4806e208sm4006309f8f.40.2026.10.25.00.19.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 00:19:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>
Subject: [PULL 036/100] tcg: Generic expansion of tcg_gen_andc_*
Date: Sun, 25 Oct 2026 08:18:11 +0100
Message-ID: <20261025071915.1123867-37-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261025071915.1123867-1-richard.henderson@linaro.org>
References: <20261025071915.1123867-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h  |  2 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 36 ++++++++++++------------------------
 3 files changed, 13 insertions(+), 26 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index d4d670dfed..70d5b991b3 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -123,7 +123,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_andc_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_eqv_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_nand_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_nor_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -201,7 +200,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* 64 bit ops */
 
-void tcg_gen_andc_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_eqv_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_nand_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_nor_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index cfa19a0a81..7386332658 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -5,6 +5,7 @@ DEF3(add, TCGV, TCGV, TCGV)
 DEF3(addi, TCGV, TCGV, TINT)
 DEF3(and, TCGV, TCGV, TCGV)
 DEF3(andi, TCGV, TCGV, TINT)
+DEF3(andc, TCGV, TCGV, TCGV)
 DEF1(discard, TCGV)
 DEF3(div, TCGV, TCGV, TCGV)
 DEF3(divu, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index fa6c152164..860c9678f9 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -392,6 +392,18 @@ void tcg_gen_andi(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
     }
 }
 
+void tcg_gen_andc(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    if (tcg_op_supported(INDEX_op_andc, type, 0)) {
+        tcg_gen_op_ttt(INDEX_op_andc, type, dst, src1, src2);
+    } else {
+        g_autoptr(TCGTemp) tmp = tcg_temp_new_ebb(type);
+
+        tcg_gen_not(type, tmp, src2);
+        tcg_gen_and(type, dst, src1, tmp);
+    }
+}
+
 void tcg_gen_discard(TCGType type, TCGTemp *src)
 {
     tcg_gen_op1(INDEX_op_discard, type, temp_arg(src));
@@ -663,18 +675,6 @@ void tcg_gen_negsetcondi_i32(TCGCond cond, TCGv_i32 ret,
     tcg_gen_negsetcond_i32(cond, ret, arg1, tcg_constant_i32(arg2));
 }
 
-void tcg_gen_andc_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    if (tcg_op_supported(INDEX_op_andc, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_andc, ret, arg1, arg2);
-    } else {
-        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-        tcg_gen_not_i32(t0, arg2);
-        tcg_gen_and_i32(ret, arg1, t0);
-        tcg_temp_free_i32(t0);
-    }
-}
-
 void tcg_gen_eqv_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     if (tcg_op_supported(INDEX_op_eqv, TCG_TYPE_I32, 0)) {
@@ -1722,18 +1722,6 @@ void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg)
     }
 }
 
-void tcg_gen_andc_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    if (tcg_op_supported(INDEX_op_andc, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_andc, ret, arg1, arg2);
-    } else {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        tcg_gen_not_i64(t0, arg2);
-        tcg_gen_and_i64(ret, arg1, t0);
-        tcg_temp_free_i64(t0);
-    }
-}
-
 void tcg_gen_eqv_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (tcg_op_supported(INDEX_op_eqv, TCG_TYPE_I64, 0)) {
-- 
2.53.0


