Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A538C25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 21:21:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBhki-0007Fw-B0; Mon, 27 May 2024 17:19:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBhkg-0007Ez-2G
 for qemu-devel@nongnu.org; Mon, 27 May 2024 17:19:30 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBhke-0003fG-JK
 for qemu-devel@nongnu.org; Mon, 27 May 2024 17:19:29 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6f8e9870e72so112721b3a.1
 for <qemu-devel@nongnu.org>; Mon, 27 May 2024 14:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716844767; x=1717449567; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+tOv299b1wOvISiaP9rKlGaLsZIUSXRuEACn75tv11g=;
 b=oALGhyvTqraT9xYohW9b/WUkeGVsYIJbtHCEfu9q2Sre306Hv+5wxIiFng1VPYGPYV
 G8r7OXxeKM3XStbUxChPZrK0VBLSbrJKc4eU7WqVAVnad0lW5QkEVmWxLXuAu4ULAvK0
 s6/srRcyHfQaD1FVNJ6JX4trK7UluZfcG2Sxu1miYbqDkiGulCT8kzVyrMEVc/g3FDmp
 FxfM1wRy6rboPuEDjhNeZEN6ETNA2vwbZ0r8fDiuYv4HmoJY5GTXfI5X1HCv5oKXTZbi
 LCOJjF5i8TnWxO/19Qxsppoc5dOumktluEf68VD5y26/IvaiJYN0Na6F1mobmtYtfyoe
 12rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716844767; x=1717449567;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+tOv299b1wOvISiaP9rKlGaLsZIUSXRuEACn75tv11g=;
 b=tS3V3woCGovMAQDuBbSjXZwWTycChsbrMtEaNObmx4pNZMsx9NJKzD7I0Mk2xRchSG
 0okbZOjqjyUrGM3xbrvNHaK7pc16eN6gldP3UQbH6DVKjFTMgrMyv9PCMD5wdbTyDGMH
 jfvCWQtAUhwri1mAzYzZcDmtMIk2DeVX+c8XnN/TQPtXXIAcGPYWXYRGHqKBGUshQ+F3
 e+7uXQTF4Vzn9wDbNpSvR+0uDe0iST23qswkPkNAlbLwhdesg+5o0roJI2JeHtRMXGbj
 WB4UmBc1YmE095oz4/PAZW3/iHqxBGuKzWzuHIYsl+1lQvHGYvl82cc5o7fm5WDa5BOa
 WImQ==
X-Gm-Message-State: AOJu0YzqvdBhog9A+3yxvRfon95SP1owDIYqLQD5YrFqaolsXYuoGctT
 Kpm1qU8z5Gm0QMtBipfSByiDBnuibkwh6nX+iYW0OpQS1faWrmCBGmHjyFP0nq8GiMqOEMg+xrP
 6
X-Google-Smtp-Source: AGHT+IGABcecIbpUI7g6XvyKfHXrQ4RzjcZick1H0E4kN5IwXNuPfWLL1E75b6GQoaip1QBP3Jtd+Q==
X-Received: by 2002:a05:6a20:974c:b0:1af:96e8:7b9c with SMTP id
 adf61e73a8af0-1b212e0325bmr10852510637.47.1716844767076; 
 Mon, 27 May 2024 14:19:27 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f8fd1d4d5fsm5265876b3a.165.2024.05.27.14.19.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 May 2024 14:19:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: git@xen0n.name,
	gaosong@loongson.cn
Subject: [PATCH 15/18] tcg/loongarch64: Remove temp_vec from tcg_out_vec_op
Date: Mon, 27 May 2024 14:19:09 -0700
Message-Id: <20240527211912.14060-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527211912.14060-1-richard.henderson@linaro.org>
References: <20240527211912.14060-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Use TCG_VEC_TMP0 directly.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/loongarch64/tcg-target.c.inc | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index e633d268d0..54f7bc9d14 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1834,7 +1834,6 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
 {
     TCGType type = vecl + TCG_TYPE_V64;
     TCGArg a0, a1, a2, a3;
-    TCGReg temp_vec = TCG_VEC_TMP0;
 
     static const LoongArchInsn cmp_vec_insn[16][4] = {
         [TCG_COND_EQ] = {OPC_VSEQ_B, OPC_VSEQ_H, OPC_VSEQ_W, OPC_VSEQ_D},
@@ -1976,8 +1975,8 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
                  * dupi_vec temp, a2
                  * cmp_vec a0, a1, temp, cond
                  */
-                tcg_out_dupi_vec(s, type, vece, temp_vec, a2);
-                a2 = temp_vec;
+                tcg_out_dupi_vec(s, type, vece, TCG_VEC_TMP0, a2);
+                a2 = TCG_VEC_TMP0;
             }
 
             insn = cmp_vec_insn[cond][vece];
@@ -2046,8 +2045,8 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         break;
     case INDEX_op_rotlv_vec:
         /* rotlv_vec a1, a2 = rotrv_vec a1, -a2 */
-        tcg_out32(s, encode_vdvj_insn(neg_vec_insn[vece], temp_vec, a2));
-        a2 = temp_vec;
+        tcg_out32(s, encode_vdvj_insn(neg_vec_insn[vece], TCG_VEC_TMP0, a2));
+        a2 = TCG_VEC_TMP0;
         /* fall through */
     case INDEX_op_rotrv_vec:
         insn = rotrv_vec_insn[vece];
-- 
2.34.1


