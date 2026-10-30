Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57495606A31D
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 13:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=JijKBCKA
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMmTj-0005PG-Cb; Fri, 30 Oct 2026 09:17:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMmSu-0002lt-Pa
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 09:16:20 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMmSs-0005WY-Lm
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 09:16:16 -0400
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-8253bc5a613so503967a34.0
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 06:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793366170; x=1793970970; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=D2fdLlvb+BRbVtRIo4uLPfcunyMOSQZp2TZDVBOzWlg=;
 b=JijKBCKAL/E9cJ6GuySvLlspRaG9k3s/g2XO0Wg/+NjOqIIQP9Xc5LxP0w/oJjwL1I
 EbikA0W2RbFyxw8HcA7Cr02xcjl101YcfdKHjTJ6vhVUFqiyBfrSwajS51vGwtzTyTZ4
 n0VC5mJqRBI7u0DL4DgI9+vkG60+WMc6PP9AAzMgUI5tpnu4SA5chzaFtd4hUSBsrous
 tntTpDLurxJoiBMN6Jv3dsqPlqQISwy9HaM9oCNPbPK/dcfNvey65E4PVXEG4q1V0b9w
 nZzPZtnnnCEpIXt2AlaWL7akbh6rQgxM6sGt3XkcgJl+Ry5yNX+C0ZJlqXTxHA8MZqEN
 abNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793366170; x=1793970970;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=D2fdLlvb+BRbVtRIo4uLPfcunyMOSQZp2TZDVBOzWlg=;
 b=GVTSpwLNsEJ8ZN/B8ZO7E0on3xrlC3jf/6XapJXeG7Pb4FsVHOSd6eL+ITyFeAZcem
 6XR0Vz46LN3cfr8YdsdYfk3qnNLGyq2bngLDYAmsHurSFGvXJio28hvq6z4yTAZ6UfIo
 GLZVy3yFaVRyURXvKNW72GqLFPcuoWoo3BV0ZfqT3P0Qw2wjvYJVqRlZpTUiY9/jOmFb
 OxM9kyiwhFP61fEaNACxzgBL/G/LhBf4hrYKbCUy9eWWtfQ5CcR5gj9Su/KZ5+ZlrAaB
 Z1NpORHhPonbtLJBktEJaehxsp/uXreZtpjnhl6picTcoUJWbNc14i1LKLPBVRXPzXhz
 l1Ew==
X-Gm-Message-State: AFq9FYKQUqsAfeBAKRtGWrjDd5CaHGqIPCJUHwrHX/9Es/uwiEgMm5NR
 pImzbSUcWhwndZkhpjKsEwOoIsLZ47sC1KpqBbagvaIDHKNQuRtbYIFDCHFS/wrX6kop+9V6ugK
 3T/TP
X-Gm-Gg: AYBFou1SAmW/NtmseWkB61oJG2RBWcmkAc1FPkcwc/xTXdilr3XDVBNSkAp6CQPGwAz
 fAqfj8ur4v4q+u8uSJ2PyJAqkabuBWYkZjgdlHU8husotMx32TKP1Z+PVHMe39upKoF4GS1e304
 cGdCv6fWZPwzm10kXc+rx53rEtnxtjIgXkGPKA4XyXQjg5JrfJ4/iKaN3CUFjhRZqvNbLurVzV3
 1oPCjF79SvSKfJe6qLtLSO2dahwGaoxfAo0ldf1bhnRqn22YOgSK1wg5FcWANG/EC41mcqj41pP
 or3SiYEe3jbYwxY9qwANGTq7i2bbcc4HZdzxXV83kuAMYEh3V3BZBXTNNwg1Tv81MKx0BU4rFxT
 pBMsI4RjSl47SidmK3b2/r3tNNotrMqt69sxWDr7hZUMbNekS2O0FJhdQ9TeXUd1yKUcNKMRGHr
 j8COHf0qE7vapuE9Rc09F6a/JTaMRO5Dkgngkqm4a1xvpPas7g3X0tSOveFqymbYlAhPPv2K1QB
 56Apd3pOMGWFdWFF+4rj0c8H9N+cAAed/kDmuJlo6ViLeGui+S8XA9pdtfHiQ+cMCI62V0D6NRn
 Pfs7RyPUGXmxBgUHPf7DhW98l+W5kA0=
X-Received: by 2002:a05:6820:858a:10b0:709:d804:88c4 with SMTP id
 006d021491bc7-714f28017c4mr909197eaf.89.1793366169933; 
 Fri, 30 Oct 2026 06:16:09 -0700 (PDT)
Received: from stoup ([50.233.235.3]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a90ae4e6bcsm1796812fac.3.2026.10.30.06.16.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 06:16:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>
Subject: [PULL 15/19] tcg/loongarch64: Import SLADD insns
Date: Fri, 30 Oct 2026 08:15:50 -0500
Message-ID: <20261030131554.41208-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261030131554.41208-1-richard.henderson@linaro.org>
References: <20261030131554.41208-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32e;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32e.google.com
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Reviewed-by: Matt Turner <mattst88@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/loongarch64/tcg-insn-defs.c.inc | 30 ++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/tcg/loongarch64/tcg-insn-defs.c.inc b/tcg/loongarch64/tcg-insn-defs.c.inc
index e907fc755f..ececc6a3dd 100644
--- a/tcg/loongarch64/tcg-insn-defs.c.inc
+++ b/tcg/loongarch64/tcg-insn-defs.c.inc
@@ -4,7 +4,7 @@
  *
  * This file is auto-generated by genqemutcgdefs from
  * https://github.com/loongson-community/loongarch-opcodes,
- * from commit 1b95bb8c443ad71e266120fd97bd227df2d8ecfc.
+ * from commit 2d84c975e8894afc8b3ee9b8559f10308a658440.
  * DO NOT EDIT.
  */
 
@@ -24,6 +24,7 @@ typedef enum {
     OPC_REVBIT_D = 0x00005400,
     OPC_SEXT_H = 0x00005800,
     OPC_SEXT_B = 0x00005c00,
+    OPC_SLADD_W = 0x00040000,
     OPC_ADD_W = 0x00100000,
     OPC_ADD_D = 0x00108000,
     OPC_SUB_W = 0x00110000,
@@ -62,6 +63,7 @@ typedef enum {
     OPC_MOD_D = 0x00228000,
     OPC_DIV_DU = 0x00230000,
     OPC_MOD_DU = 0x00238000,
+    OPC_SLADD_D = 0x002c0000,
     OPC_SLLI_W = 0x00408000,
     OPC_SLLI_D = 0x00410000,
     OPC_SRLI_W = 0x00448000,
@@ -619,6 +621,18 @@ encode_djk_insn(LoongArchInsn opc, TCGReg d, TCGReg j, TCGReg k)
     return encode_djk_slots(opc, d, j, k);
 }
 
+static int32_t __attribute__((unused)) encode_djkua2_insn(LoongArchInsn opc,
+                                                          TCGReg d, TCGReg j,
+                                                          TCGReg k,
+                                                          uint32_t ua2)
+{
+    tcg_debug_assert(d >= 0 && d <= 0x1f);
+    tcg_debug_assert(j >= 0 && j <= 0x1f);
+    tcg_debug_assert(k >= 0 && k <= 0x1f);
+    tcg_debug_assert(ua2 <= 0x3);
+    return encode_djka_slots(opc, d, j, k, ua2);
+}
+
 static int32_t __attribute__((unused))
 encode_djsk12_insn(LoongArchInsn opc, TCGReg d, TCGReg j, int32_t sk12)
 {
@@ -1426,6 +1440,13 @@ static void __attribute__((unused)) tcg_out_opc_sext_b(TCGContext *s, TCGReg d,
     tcg_out32(s, encode_dj_insn(OPC_SEXT_B, d, j));
 }
 
+/* Emits the `sladd.w d, j, k, ua2` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_sladd_w(TCGContext *s, TCGReg d, TCGReg j, TCGReg k, uint32_t ua2)
+{
+    tcg_out32(s, encode_djkua2_insn(OPC_SLADD_W, d, j, k, ua2));
+}
+
 /* Emits the `add.w d, j, k` instruction.  */
 static void __attribute__((unused)) tcg_out_opc_add_w(TCGContext *s, TCGReg d,
                                                       TCGReg j, TCGReg k)
@@ -1692,6 +1713,13 @@ static void __attribute__((unused)) tcg_out_opc_mod_du(TCGContext *s, TCGReg d,
     tcg_out32(s, encode_djk_insn(OPC_MOD_DU, d, j, k));
 }
 
+/* Emits the `sladd.d d, j, k, ua2` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_sladd_d(TCGContext *s, TCGReg d, TCGReg j, TCGReg k, uint32_t ua2)
+{
+    tcg_out32(s, encode_djkua2_insn(OPC_SLADD_D, d, j, k, ua2));
+}
+
 /* Emits the `slli.w d, j, uk5` instruction.  */
 static void __attribute__((unused)) tcg_out_opc_slli_w(TCGContext *s, TCGReg d,
                                                        TCGReg j, uint32_t uk5)
-- 
2.53.0


