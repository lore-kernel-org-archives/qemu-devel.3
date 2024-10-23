Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FBFBD2E010
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 03:37:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3S9P-0007Hw-Eq; Tue, 22 Oct 2024 23:35:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t3S97-00070c-6T
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 23:34:54 -0400
Received: from mail-oa1-x2d.google.com ([2001:4860:4864:20::2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t3S92-0008MH-Js
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 23:34:52 -0400
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-288916b7fceso3303495fac.3
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 20:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729654484; x=1730259284; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6H4o7TRLnsRJPcQeLHBRIU6aVhm6+5BjLCNGhX0wWuw=;
 b=zHBIlF/riyALBTzr9CAPlIHcmw4ptJhMorK6KHMzVGi3iTWkCJKS2L9oD6sK3fnLYd
 m3EItOQBeEm8ZFihOhkZg9aBsaSp+yfBtg/7vdGAnmbEhza6AlLBfhWmGsnJUF8M1HVx
 Ghsil5c6a/E64I/G0vHXjzjwPF8l3M4MdOGEqqfSKgcjl7s2G9CDRjr7Mx0N+P5Ql7UD
 zTCc0FOJo1V/3HzxAB8AUtuSy8Fmghvvpr2SPSIPietMVFZBJ4gD1D1TkC4vY4bHoEGd
 zsWPeo2CHmPyyCc0HdcAsvMpOTgEQmkDy1uTyKmnc3z0JSovdL0Vof8hxBruU3wvtocq
 DTWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729654484; x=1730259284;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6H4o7TRLnsRJPcQeLHBRIU6aVhm6+5BjLCNGhX0wWuw=;
 b=ag7VEbBnGHZtqRSE/HcIHYLUxQymA+5+Reu+GZiCDJ6vzzWfXLpduxbLIZNdOs0IE9
 UrRJ+wLjmdNQE+dRkPFLLiO0cvs8dsIByJRF9jW3UnFOodB7E5y0RyEYmDeNOmpHJj6F
 Rhujd2hNK+gELmOeSod4cHjLaOM+m/6bwzDVKnwK1WvCVNo2E0QqeuXbv2BcLHa9u7Fo
 SWwoS9hR5JHDXPFCJEvbUHUapRMO4EEICLTQucxsbG/2t4G74j52zUWNOt3m42gYoCLm
 RhS8oe0FULzVFOBV94kT3MJ8MuzC/8PdPrq7IttgvgTUpta3E53XvyA/8ktXCdmSyMD/
 oGfg==
X-Gm-Message-State: AOJu0YzE2UM/Hkp9F33ru4E2X7lVGDHeeoUKfS04rPmChRQz85aIjFSN
 wLvofjFfH8zh8n/M0SCOQjOmrIid7PJV41keOnXbqW0dzQO4OHLktRDIbSuHGZ4j6xjpoFk9Fv0
 a
X-Google-Smtp-Source: AGHT+IHIQi5O7QYjCB1K7p0ZwMYnn2a2UNFIfsvpC9QSlEvCKcoFoQVykXvGV3BSCcF/Kktqkx3dMQ==
X-Received: by 2002:a05:6870:80d0:b0:28c:8476:dd76 with SMTP id
 586e51a60fabf-28ccb63865amr1306800fac.29.1729654483982; 
 Tue, 22 Oct 2024 20:34:43 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71ec13d73b1sm5438338b3a.105.2024.10.22.20.34.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2024 20:34:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PULL 13/24] tcg/riscv: Implement vector roti/v/x ops
Date: Tue, 22 Oct 2024 20:34:21 -0700
Message-ID: <20241023033432.1353830-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023033432.1353830-1-richard.henderson@linaro.org>
References: <20241023033432.1353830-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2d.google.com
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

From: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>

Signed-off-by: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
Reviewed-by: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Message-ID: <20241007025700.47259-12-zhiwei_liu@linux.alibaba.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/riscv/tcg-target.h     |  6 +++---
 tcg/riscv/tcg-target.c.inc | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/tcg/riscv/tcg-target.h b/tcg/riscv/tcg-target.h
index 76d30e789b..e6d66cd1b9 100644
--- a/tcg/riscv/tcg-target.h
+++ b/tcg/riscv/tcg-target.h
@@ -154,9 +154,9 @@ typedef enum {
 #define TCG_TARGET_HAS_not_vec          1
 #define TCG_TARGET_HAS_neg_vec          1
 #define TCG_TARGET_HAS_abs_vec          0
-#define TCG_TARGET_HAS_roti_vec         0
-#define TCG_TARGET_HAS_rots_vec         0
-#define TCG_TARGET_HAS_rotv_vec         0
+#define TCG_TARGET_HAS_roti_vec         1
+#define TCG_TARGET_HAS_rots_vec         1
+#define TCG_TARGET_HAS_rotv_vec         1
 #define TCG_TARGET_HAS_shi_vec          1
 #define TCG_TARGET_HAS_shs_vec          1
 #define TCG_TARGET_HAS_shv_vec          1
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 2c78ea6507..f8331e4688 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -2488,6 +2488,34 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         set_vtype_len_sew(s, type, vece);
         tcg_out_vshifti(s, OPC_VSRA_VI, OPC_VSRA_VX, a0, a1, a2);
         break;
+    case INDEX_op_rotli_vec:
+        set_vtype_len_sew(s, type, vece);
+        tcg_out_vshifti(s, OPC_VSLL_VI, OPC_VSLL_VX, TCG_REG_V0, a1, a2);
+        tcg_out_vshifti(s, OPC_VSRL_VI, OPC_VSRL_VX, a0, a1,
+                        -a2 & ((8 << vece) - 1));
+        tcg_out_opc_vv(s, OPC_VOR_VV, a0, a0, TCG_REG_V0);
+        break;
+    case INDEX_op_rotls_vec:
+        set_vtype_len_sew(s, type, vece);
+        tcg_out_opc_vx(s, OPC_VSLL_VX, TCG_REG_V0, a1, a2);
+        tcg_out_opc_reg(s, OPC_SUBW, TCG_REG_TMP0, TCG_REG_ZERO, a2);
+        tcg_out_opc_vx(s, OPC_VSRL_VX, a0, a1, TCG_REG_TMP0);
+        tcg_out_opc_vv(s, OPC_VOR_VV, a0, a0, TCG_REG_V0);
+        break;
+    case INDEX_op_rotlv_vec:
+        set_vtype_len_sew(s, type, vece);
+        tcg_out_opc_vi(s, OPC_VRSUB_VI, TCG_REG_V0, a2, 0);
+        tcg_out_opc_vv(s, OPC_VSRL_VV, TCG_REG_V0, a1, TCG_REG_V0);
+        tcg_out_opc_vv(s, OPC_VSLL_VV, a0, a1, a2);
+        tcg_out_opc_vv(s, OPC_VOR_VV, a0, a0, TCG_REG_V0);
+        break;
+    case INDEX_op_rotrv_vec:
+        set_vtype_len_sew(s, type, vece);
+        tcg_out_opc_vi(s, OPC_VRSUB_VI, TCG_REG_V0, a2, 0);
+        tcg_out_opc_vv(s, OPC_VSLL_VV, TCG_REG_V0, a1, TCG_REG_V0);
+        tcg_out_opc_vv(s, OPC_VSRL_VV, a0, a1, a2);
+        tcg_out_opc_vv(s, OPC_VOR_VV, a0, a0, TCG_REG_V0);
+        break;
     case INDEX_op_cmp_vec:
         tcg_out_cmpsel(s, type, vece, args[3], a0, a1, a2, c2,
                        -1, true, 0, true);
@@ -2537,6 +2565,10 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
     case INDEX_op_shri_vec:
     case INDEX_op_shli_vec:
     case INDEX_op_sari_vec:
+    case INDEX_op_rotls_vec:
+    case INDEX_op_rotlv_vec:
+    case INDEX_op_rotrv_vec:
+    case INDEX_op_rotli_vec:
     case INDEX_op_cmp_vec:
     case INDEX_op_cmpsel_vec:
         return 1;
@@ -2695,6 +2727,7 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_shli_vec:
     case INDEX_op_shri_vec:
     case INDEX_op_sari_vec:
+    case INDEX_op_rotli_vec:
         return C_O1_I1(v, v);
     case INDEX_op_add_vec:
     case INDEX_op_and_vec:
@@ -2715,10 +2748,13 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_shlv_vec:
     case INDEX_op_shrv_vec:
     case INDEX_op_sarv_vec:
+    case INDEX_op_rotlv_vec:
+    case INDEX_op_rotrv_vec:
         return C_O1_I2(v, v, v);
     case INDEX_op_shls_vec:
     case INDEX_op_shrs_vec:
     case INDEX_op_sars_vec:
+    case INDEX_op_rotls_vec:
         return C_O1_I2(v, v, r);
     case INDEX_op_cmp_vec:
         return C_O1_I2(v, v, vL);
-- 
2.43.0


