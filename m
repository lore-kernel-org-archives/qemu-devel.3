Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25636606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 14:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=afmnVbVi
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJXAO-0006tp-Qj; Wed, 21 Oct 2026 10:19:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJX9w-0005GV-I9
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:19:21 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJX9t-0001jR-KO
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:19:15 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4a1df4c0966so5268305e9.1
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 07:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792592352; x=1793197152; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4GThDpdfJc/xHNYvWrrIgCDVb6YIY+HqC0bB3HJjZX8=;
 b=afmnVbViVnHVqr9zHwyz46SYCqe1vnKFcPbABEabDTLGFweC0GrmwswMjrMPwt2Uk8
 kGYqFmuGXCdtUbn4BpL0zcn6fGsgwn1Rw1+IKlCDRT+NK7mjMOpr7rkezcTIiG4QCkRN
 UZfF+89vUUffCxnmZtM8sXZ6gEjbjvTLC6Ez9VkuIcDm7YSQGt3psEsUMlEnKKjJjWEL
 +zwpj4kqbRTR053BqxoXNMg1xICa2VDfgHjpYRK2X7Ew7ufAa7dSyZS3HrGx+XeEl9kP
 Ywt1mxqqw9GNiGW/GOuF3wSNlW0VxgDHTteBIG+0eIyJRhNuBsuYn+msGxZlJu0E0a7s
 iSJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792592352; x=1793197152;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=4GThDpdfJc/xHNYvWrrIgCDVb6YIY+HqC0bB3HJjZX8=;
 b=d+7c9D/SQ+aM9SQV6EguUTwec5s78Ordbv3JKV3FuirRTvLxPZ+e/Ndzlw5wLe3Qmo
 iS+RpQYRJJ1gcJwEkdKvfXQgt8kCE2NDy6m86Fn0gjW3KkuJUNzN2Ci7JEuH7txNK+ul
 MWVSDLh8mzy/uB5Mt5P6C+kxvydlPqTcw16zARrRQ48DIM0KFNHQi73ga/wpyEg9WbYC
 VSiSzHYM88UPklC+rSxpanVgzgNgaxy+VgNw7aX7XemIynW5+n71HQEkjl8B7vr462pH
 N0jLUl41XPT1mnaBX0w4ShM+pPaqmtjFUfyXsSkAjk4zWebhSGgOqRibfqBmn7oor33z
 FSww==
X-Gm-Message-State: AFq9FYJBZgv4n0LQuSZ7mOT4yvM/LWDpmrN51m3l07wKzQBiYHYUC4mf
 ae92aHXfMlgWLjhuYcVUUf6COSv48dEFi9aGv0EAPiA51nwtzlcLVFmEBIZF5Kc9faMmRdZozmM
 crTcmaoI=
X-Gm-Gg: AYBFou20EQUA4pXPjLXajrQBzuNATv/BYkU+tVxXlAgSE55ZH2BEvdBIUL7XbXnoaoZ
 pZTAnrePJP+gpeJtfAEyBajHr7CB3yd4fub2X2Y/NoNYcy+3DLP7P/6ClgguExKqjkxL+KDzNIN
 RKoh3MZnsyTa3ofOFW6W6NW6+nmkKfD1A92FpgjzwcJugli2VJ8vXMKHp7KUJhzW74358SPD8v/
 TZ/BuCdKkfelY1hMdPCFlLnCUx/kSCbs84rSbT/wTbykpFv8g77ORFiXrbO9s91y6O2v59CoJFe
 wS15iTcDf2Evn8YJ0xu0VIzyGhURGlsFt0XnxWTAhgn9vTpv9qL9IwClu7m9P6xuF24hArwQk8u
 iZXIg397tXBW7vmuddQPr4y8Blsf4K2uLbNZOtnIpVyLS/lg2xzsEd4odKsgXPZGgjobvMwfEDT
 qg2sEdYbQxaqluQ33+RGgknFT689krsJ/rP5S45DRltx4fmBLdAxOqJn78AV90lh7MIX++0GsNV
 wGOINEUQU4EyLTzqtHXYtYZ3laadoXGZpycViyM+JBc7/2neMobEzQtnIQKuUEQcPkqKcYQNOrt
 PvdxkSB6YPQij71UFDIhYYDEnqs=
X-Received: by 2002:a05:600c:1391:b0:49f:c5aa:9ef4 with SMTP id
 5b1f17b1804b1-4a1fdd0bfdfmr44985205e9.8.1792592352092; 
 Wed, 21 Oct 2026 07:19:12 -0700 (PDT)
Received: from stoup.fritz.box (pd95f64ec.dip0.t-ipconnect.de.
 [217.95.100.236]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1f2c242dcsm147113845e9.0.2026.10.21.07.19.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 07:19:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v6 036/100] tcg: Generic expansion of tcg_gen_andc_*
Date: Wed, 21 Oct 2026 16:15:48 +0200
Message-ID: <20261021141652.363109-37-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021141652.363109-1-richard.henderson@linaro.org>
References: <20261021141652.363109-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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


