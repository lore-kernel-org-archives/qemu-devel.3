Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C88FC25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 21:21:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBhkg-0007Fe-OI; Mon, 27 May 2024 17:19:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBhke-0007EP-Kt
 for qemu-devel@nongnu.org; Mon, 27 May 2024 17:19:28 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBhkd-0003ei-0Y
 for qemu-devel@nongnu.org; Mon, 27 May 2024 17:19:28 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6f6911d16b4so102544b3a.3
 for <qemu-devel@nongnu.org>; Mon, 27 May 2024 14:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716844765; x=1717449565; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+aLTmgpfFJvWYbR4Ap5S/59vR+/bleRAx/rWF8KJSg8=;
 b=NW9M3PJgEjvHFfm4qAZLhgN4sSx6Pl/O8S5bKK+HdGRfq1JAz8OHD4gpsiOIgeE7lu
 XFkk6GDmf0zLw7KQuzoT8GMEvN9CyTX5Y/ynoEiTaHDx+U4VcTIqh9NoguPPaqCWn72d
 w58lwj0Z1oQ5Mqs0xW1t9W5GQ6UVXEAQ3q6aEOaYFMzCdUIsmrd9NgF62E35kpBnlc9B
 BdjfRtJIzEzFuQasAenzvffJjdBhLdhNbLrNVkf6s9w0AP7AC9w3W0ej2LUzcsB4RnC+
 q/WdYb/Wj8XfKXTNkbhX+aUra7UyHDtYWteF9KOBb+tum4YTCFrixRVgO73qisxqb5Se
 QI4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716844765; x=1717449565;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+aLTmgpfFJvWYbR4Ap5S/59vR+/bleRAx/rWF8KJSg8=;
 b=cZ4tsY6H9mLPPnRCpDdBnFtcccptvUIgL35uRMw9NgcsUPc3HB2Lvl9lDfTnB955ea
 oYf0m0cNhObbPrLqomOx3xZvv2bF07UxXVNcMH7xHciYRSNv+xC8Y333ejtRyUBnVL/f
 viq5qokds7YWHnxSZ8/z9rzMQlv0Txbim9P6vBdyyUoPS2HS0rS0oHPrHTj13GYpMVgG
 V0PLvS5JxZSPBsIQ1lypO9G7NEsV4egrVCs+8UXvVR1Y3/NghtU8XAwGE58UgAbiiQfC
 6Yg2m0pMWXyIdLTohJsUwAMnc5hoWAHvSHUcsZBRwNyXJnVqMQgW6gkdtBzaWANmEhEo
 b2ow==
X-Gm-Message-State: AOJu0YwWtBCWc9JcZGaowYW78PyHixkgViPkrLqpU+YwnUXR6i1niWPV
 LX6+SZp9W06Day/Hv9DKcp4BZWET4XQhK0PMk9DI2EO8uEqlS8ImJgUi3Oud68qXfugbTfSK/5y
 4
X-Google-Smtp-Source: AGHT+IGpKe/P3XDFFq5avfj2etyw/HpNi2brQ03f3udo6mOClYWRrV8MXULiWEbSZckJtTTOvojsEA==
X-Received: by 2002:a05:6a00:3007:b0:6ea:c634:ca0f with SMTP id
 d2e1a72fcca58-6f8f3f9f45cmr11838581b3a.21.1716844764613; 
 Mon, 27 May 2024 14:19:24 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f8fd1d4d5fsm5265876b3a.165.2024.05.27.14.19.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 May 2024 14:19:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: git@xen0n.name,
	gaosong@loongson.cn
Subject: [PATCH 12/18] tcg/loongarch64: Support LASX in tcg_out_addsub_vec
Date: Mon, 27 May 2024 14:19:06 -0700
Message-Id: <20240527211912.14060-13-richard.henderson@linaro.org>
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/loongarch64/tcg-target.c.inc | 36 ++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 47011488dd..652aa261a3 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1758,21 +1758,25 @@ static void tcg_out_dupi_vec(TCGContext *s, TCGType type, unsigned vece,
     tcg_out_dup_vec(s, type, vece, rd, TCG_REG_TMP0);
 }
 
-static void tcg_out_addsub_vec(TCGContext *s, unsigned vece, const TCGArg a0,
-                               const TCGArg a1, const TCGArg a2,
+static void tcg_out_addsub_vec(TCGContext *s, bool lasx, unsigned vece,
+                               TCGArg a0, TCGArg a1, TCGArg a2,
                                bool a2_is_const, bool is_add)
 {
-    static const LoongArchInsn add_vec_insn[4] = {
-        OPC_VADD_B, OPC_VADD_H, OPC_VADD_W, OPC_VADD_D
+    static const LoongArchInsn add_vec_insn[2][4] = {
+        { OPC_VADD_B, OPC_VADD_H, OPC_VADD_W, OPC_VADD_D },
+        { OPC_XVADD_B, OPC_XVADD_H, OPC_XVADD_W, OPC_XVADD_D },
     };
-    static const LoongArchInsn add_vec_imm_insn[4] = {
-        OPC_VADDI_BU, OPC_VADDI_HU, OPC_VADDI_WU, OPC_VADDI_DU
+    static const LoongArchInsn add_vec_imm_insn[2][4] = {
+        { OPC_VADDI_BU, OPC_VADDI_HU, OPC_VADDI_WU, OPC_VADDI_DU },
+        { OPC_XVADDI_BU, OPC_XVADDI_HU, OPC_XVADDI_WU, OPC_XVADDI_DU },
     };
-    static const LoongArchInsn sub_vec_insn[4] = {
-        OPC_VSUB_B, OPC_VSUB_H, OPC_VSUB_W, OPC_VSUB_D
+    static const LoongArchInsn sub_vec_insn[2][4] = {
+        { OPC_VSUB_B, OPC_VSUB_H, OPC_VSUB_W, OPC_VSUB_D },
+        { OPC_XVSUB_B, OPC_XVSUB_H, OPC_XVSUB_W, OPC_XVSUB_D },
     };
-    static const LoongArchInsn sub_vec_imm_insn[4] = {
-        OPC_VSUBI_BU, OPC_VSUBI_HU, OPC_VSUBI_WU, OPC_VSUBI_DU
+    static const LoongArchInsn sub_vec_imm_insn[2][4] = {
+        { OPC_VSUBI_BU, OPC_VSUBI_HU, OPC_VSUBI_WU, OPC_VSUBI_DU },
+        { OPC_XVSUBI_BU, OPC_XVSUBI_HU, OPC_XVSUBI_WU, OPC_XVSUBI_DU },
     };
     LoongArchInsn insn;
 
@@ -1783,10 +1787,10 @@ static void tcg_out_addsub_vec(TCGContext *s, unsigned vece, const TCGArg a0,
             value = -value;
         }
         if (value < 0) {
-            insn = sub_vec_imm_insn[vece];
+            insn = sub_vec_imm_insn[lasx][vece];
             value = -value;
         } else {
-            insn = add_vec_imm_insn[vece];
+            insn = add_vec_imm_insn[lasx][vece];
         }
 
         /* Constraint TCG_CT_CONST_VADD ensures validity. */
@@ -1797,9 +1801,9 @@ static void tcg_out_addsub_vec(TCGContext *s, unsigned vece, const TCGArg a0,
     }
 
     if (is_add) {
-        insn = add_vec_insn[vece];
+        insn = add_vec_insn[lasx][vece];
     } else {
-        insn = sub_vec_insn[vece];
+        insn = sub_vec_insn[lasx][vece];
     }
     tcg_out32(s, encode_vdvjvk_insn(insn, a0, a1, a2));
 }
@@ -1963,10 +1967,10 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         }
         break;
     case INDEX_op_add_vec:
-        tcg_out_addsub_vec(s, vece, a0, a1, a2, const_args[2], true);
+        tcg_out_addsub_vec(s, false, vece, a0, a1, a2, const_args[2], true);
         break;
     case INDEX_op_sub_vec:
-        tcg_out_addsub_vec(s, vece, a0, a1, a2, const_args[2], false);
+        tcg_out_addsub_vec(s, false, vece, a0, a1, a2, const_args[2], false);
         break;
     case INDEX_op_neg_vec:
         tcg_out32(s, encode_vdvj_insn(neg_vec_insn[vece], a0, a1));
-- 
2.34.1


