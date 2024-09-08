Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A306FECE579
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Sep 2024 02:27:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sn7dS-00035g-MD; Sat, 07 Sep 2024 22:26:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sn7dQ-0002vp-N3
 for qemu-devel@nongnu.org; Sat, 07 Sep 2024 22:26:40 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sn7dO-0004zK-T2
 for qemu-devel@nongnu.org; Sat, 07 Sep 2024 22:26:40 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2d86f713557so2189657a91.2
 for <qemu-devel@nongnu.org>; Sat, 07 Sep 2024 19:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725762397; x=1726367197; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u46fJy6WD0XvoquSXEHKk0WznnV96a8saQQEZkHCpG4=;
 b=NrRl0Vk/vOws/9rhkUoD35GlqoGcZOJg2Ac5p4UHBX1oA/gGgnxrHoZRNW1fwHjul2
 Op65kOh9M+xIM/9n4kBiUSnmmyFCdh4wg47kOYMJPK/kH+a/mV+b8Nl6XawVjsS1p/CK
 kSuY1Yblw1FYzENtpbbdF5oaJx0FlTvuvEOfhQyjBst055Av9gUwBoNF4fv2cQDLvYA5
 yx81TQR55MHmPWa5b1rSANM6+W4nKEhqrFzIS0x6GooMMBu4G6jWmyPQn06IkArxc2lP
 Qk5iKHkQVnbD/E8lAdm55AfK2OgfhpK0ij6nD3Ebpm1udtAgUaPSEEdvQq2hOR1e9XjP
 mj8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725762397; x=1726367197;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u46fJy6WD0XvoquSXEHKk0WznnV96a8saQQEZkHCpG4=;
 b=tUJYakRauqt4MjjRQkL1aalrIMfuxrAHC8NGtzp35hbKukfCyORU4xFyz1Zhybx0mP
 lLtKYxjQyFNluAoXzdqDbNDMNojY1sBhvtYPo0ljz8i6pPQOmdHDY+tFqJNJsP0m4zUf
 mboIt6VaItvcxL863wUx7pwhz27FVt78u/kCRmXOXQaUqJfWTEDUnPxyhWN9IuJjKu0v
 6cvd/Li2ahqk/HRQY/DZ8tqCrPIExzfiY8+gAjkbiJDkI9652zBpPewgz+4nxxf40mdY
 uWFBTd8c+xJctOfGrtCjpkVJrKeaVpcfd7rPSXCKtDeMzSfz1R3kCJuyqgZz6IUmzebg
 hnnQ==
X-Gm-Message-State: AOJu0Yyq19oQoeFUAxNpMdz69x4py90hJqYMmnv+IWH6jE9xyG0vMwIC
 TmzocBmAXb+ugkPt+8cfVCGVKIK4l0pEYoknlDbQMJ358i8NTLci+IRcaMq1Q++eGUsDpCccMfu
 q
X-Google-Smtp-Source: AGHT+IF/W4qQhs7hNRbjoEvOQXDrCsMvCTUHNERVVX7dFl/867OxoXeScJklKC4IGxGsR/Hv9Xn05A==
X-Received: by 2002:a17:90a:77ca:b0:2c9:df1c:4a58 with SMTP id
 98e67ed59e1d1-2dad5018dbfmr8906709a91.23.1725762397471; 
 Sat, 07 Sep 2024 19:26:37 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2dadbfe46d4sm4084019a91.1.2024.09.07.19.26.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Sep 2024 19:26:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: zhiwei_liu@linux.alibaba.com, tangtiancheng.ttc@alibaba-inc.com,
 liwei1518@gmail.com, bmeng.cn@gmail.com
Subject: [PATCH 03/12] tcg/i386: Split out tcg_out_vex_modrm_type
Date: Sat,  7 Sep 2024 19:26:23 -0700
Message-ID: <20240908022632.459477-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240908022632.459477-1-richard.henderson@linaro.org>
References: <20240908022632.459477-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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

Helper function to handle setting of VEXL based
on the type of the operation.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.c.inc | 38 +++++++++++++++-----------------------
 1 file changed, 15 insertions(+), 23 deletions(-)

diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 9a54ef7f8d..af71a397b1 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -711,6 +711,15 @@ static void tcg_out_vex_modrm(TCGContext *s, int opc, int r, int v, int rm)
     tcg_out8(s, 0xc0 | (LOWREGMASK(r) << 3) | LOWREGMASK(rm));
 }
 
+static void tcg_out_vex_modrm_type(TCGContext *s, int opc,
+                                   int r, int v, int rm, TCGType type)
+{
+    if (type == TCG_TYPE_V256) {
+        opc |= P_VEXL;
+    }
+    tcg_out_vex_modrm(s, opc, r, v, rm);
+}
+
 /* Output an opcode with a full "rm + (index<<shift) + offset" address mode.
    We handle either RM and INDEX missing with a negative value.  In 64-bit
    mode for absolute addresses, ~RM is the size of the immediate operand
@@ -904,8 +913,7 @@ static bool tcg_out_dup_vec(TCGContext *s, TCGType type, unsigned vece,
                             TCGReg r, TCGReg a)
 {
     if (have_avx2) {
-        int vex_l = (type == TCG_TYPE_V256 ? P_VEXL : 0);
-        tcg_out_vex_modrm(s, avx2_dup_insn[vece] + vex_l, r, 0, a);
+        tcg_out_vex_modrm_type(s, avx2_dup_insn[vece], r, 0, a, type);
     } else {
         switch (vece) {
         case MO_8:
@@ -3231,10 +3239,7 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         goto gen_simd;
     gen_simd:
         tcg_debug_assert(insn != OPC_UD2);
-        if (type == TCG_TYPE_V256) {
-            insn |= P_VEXL;
-        }
-        tcg_out_vex_modrm(s, insn, a0, a1, a2);
+        tcg_out_vex_modrm_type(s, insn, a0, a1, a2, type);
         break;
 
     case INDEX_op_cmp_vec:
@@ -3250,10 +3255,7 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
 
     case INDEX_op_andc_vec:
         insn = OPC_PANDN;
-        if (type == TCG_TYPE_V256) {
-            insn |= P_VEXL;
-        }
-        tcg_out_vex_modrm(s, insn, a0, a2, a1);
+        tcg_out_vex_modrm_type(s, insn, a0, a2, a1, type);
         break;
 
     case INDEX_op_shli_vec:
@@ -3281,10 +3283,7 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         goto gen_shift;
     gen_shift:
         tcg_debug_assert(vece != MO_8);
-        if (type == TCG_TYPE_V256) {
-            insn |= P_VEXL;
-        }
-        tcg_out_vex_modrm(s, insn, sub, a0, a1);
+        tcg_out_vex_modrm_type(s, insn, sub, a0, a1, type);
         tcg_out8(s, a2);
         break;
 
@@ -3361,19 +3360,12 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
 
     gen_simd_imm8:
         tcg_debug_assert(insn != OPC_UD2);
-        if (type == TCG_TYPE_V256) {
-            insn |= P_VEXL;
-        }
-        tcg_out_vex_modrm(s, insn, a0, a1, a2);
+        tcg_out_vex_modrm_type(s, insn, a0, a1, a2, type);
         tcg_out8(s, sub);
         break;
 
     case INDEX_op_x86_vpblendvb_vec:
-        insn = OPC_VPBLENDVB;
-        if (type == TCG_TYPE_V256) {
-            insn |= P_VEXL;
-        }
-        tcg_out_vex_modrm(s, insn, a0, a1, a2);
+        tcg_out_vex_modrm_type(s, OPC_VPBLENDVB, a0, a1, a2, type);
         tcg_out8(s, args[3] << 4);
         break;
 
-- 
2.43.0


