Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEDF1D2E011
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 03:38:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3S9M-0007CC-VA; Tue, 22 Oct 2024 23:35:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t3S95-0006zm-LL
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 23:34:52 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t3S92-0008Ls-K0
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 23:34:51 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-7ea8ecacf16so4346592a12.1
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 20:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729654482; x=1730259282; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dluUCaEndjBCunQfjOsd/2zhh5fJAnoMBhZPYS0jDTY=;
 b=jxiTD7EHEe1vKXZWUPK/MghmY4+XTNd7jibCZOgJFOnf6HEAU+9rFepKg7QZWXtD8c
 GXuzbD56PumP6FS2JQrJYYaP9is5Z0QHkZQ4je7d8Xu4gucKFa26gtoBWgAA+/Ckh9xY
 cBbBqT3qP9V10mwATKmSZ7DCoq3H5eUWKpMww5CTKnYzP8ScgG8FH8c1XgcYoSdt/h6e
 g5zgWj3zT316CnMOBeDVB3QjRSVD1s0lKSYcXw1+FPL/xC5vTwcl+q7qU9Aaub5EM7p0
 4BUn+gH7TZt0N34pkaNZUT43T3npMnbMQV07W0uAJCCWSGMeMa3slFhZQAEChXsQ+zbc
 Ikwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729654482; x=1730259282;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dluUCaEndjBCunQfjOsd/2zhh5fJAnoMBhZPYS0jDTY=;
 b=a6TZbJkp7zWi74YXG3z24VETOTJ5GFiPaUvWPKxjanbAF/fUIRRyinUX1mm3BqLECG
 sfW7PtM2t+Ancg8MJs/HHXmrKyQOW9XPKRrAsvftJIplWXBfamlz3GDwKWMlkTK8xTyk
 /FH3QfwX2uE0ohyioMfQ5ez0yj6VuwJaOBB3auJTDzg78sypHUgxkAcYzZOpwt9Cywig
 Kn/DUyprtgMb6mcAlwa72dhJabWdX6zE1DZAiSA+vT/jQ+VipKw1B3DBmc/jQsB/TI1O
 T2jfuyvyVBPXo0yA6IDcyfE8F7zclWJ+bdDF36JpAyn2560n3MhlMKJYzQHL/eKceZP5
 cDEw==
X-Gm-Message-State: AOJu0YxjAF7FifpoTiWL4lJqMIeaEOAw7tV7DDku0UC5AZn4uVU0Izm7
 QLbTCsP5MU0F61Nt+7BHWcDPFHgPF3N+pXXsfQpoqyyHgJT8o7kTdb0r7SFGLhPp252Cj2uOi1N
 r
X-Google-Smtp-Source: AGHT+IGlUeHWAq4R0B+mv3tmkTGotl+wg7E2/EjiWnpfqftkM4j+9TgyfjBF420YNSKs6PIudVITzQ==
X-Received: by 2002:a05:6a21:1709:b0:1d9:782f:8c9a with SMTP id
 adf61e73a8af0-1d978b2d8b7mr1487215637.21.1729654481654; 
 Tue, 22 Oct 2024 20:34:41 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71ec13d73b1sm5438338b3a.105.2024.10.22.20.34.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2024 20:34:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PULL 10/24] tcg/riscv: Implement vector sat/mul ops
Date: Tue, 22 Oct 2024 20:34:18 -0700
Message-ID: <20241023033432.1353830-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023033432.1353830-1-richard.henderson@linaro.org>
References: <20241023033432.1353830-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x532.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20241007025700.47259-9-zhiwei_liu@linux.alibaba.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/riscv/tcg-target.h     |  4 ++--
 tcg/riscv/tcg-target.c.inc | 41 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/tcg/riscv/tcg-target.h b/tcg/riscv/tcg-target.h
index ae10381e02..1d4d8878ce 100644
--- a/tcg/riscv/tcg-target.h
+++ b/tcg/riscv/tcg-target.h
@@ -160,8 +160,8 @@ typedef enum {
 #define TCG_TARGET_HAS_shi_vec          0
 #define TCG_TARGET_HAS_shs_vec          0
 #define TCG_TARGET_HAS_shv_vec          0
-#define TCG_TARGET_HAS_mul_vec          0
-#define TCG_TARGET_HAS_sat_vec          0
+#define TCG_TARGET_HAS_mul_vec          1
+#define TCG_TARGET_HAS_sat_vec          1
 #define TCG_TARGET_HAS_minmax_vec       0
 #define TCG_TARGET_HAS_bitsel_vec       0
 #define TCG_TARGET_HAS_cmpsel_vec       1
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 1ce2f291d3..4758555565 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -284,6 +284,16 @@ typedef enum {
     OPC_VXOR_VV = 0x2c000057 | V_OPIVV,
     OPC_VXOR_VI = 0x2c000057 | V_OPIVI,
 
+    OPC_VMUL_VV = 0x94000057 | V_OPMVV,
+    OPC_VSADD_VV = 0x84000057 | V_OPIVV,
+    OPC_VSADD_VI = 0x84000057 | V_OPIVI,
+    OPC_VSSUB_VV = 0x8c000057 | V_OPIVV,
+    OPC_VSSUB_VI = 0x8c000057 | V_OPIVI,
+    OPC_VSADDU_VV = 0x80000057 | V_OPIVV,
+    OPC_VSADDU_VI = 0x80000057 | V_OPIVI,
+    OPC_VSSUBU_VV = 0x88000057 | V_OPIVV,
+    OPC_VSSUBU_VI = 0x88000057 | V_OPIVI,
+
     OPC_VMSEQ_VV = 0x60000057 | V_OPIVV,
     OPC_VMSEQ_VI = 0x60000057 | V_OPIVI,
     OPC_VMSEQ_VX = 0x60000057 | V_OPIVX,
@@ -2376,6 +2386,26 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         set_vtype_len_sew(s, type, vece);
         tcg_out_opc_vi(s, OPC_VRSUB_VI, a0, a1, 0);
         break;
+    case INDEX_op_mul_vec:
+        set_vtype_len_sew(s, type, vece);
+        tcg_out_opc_vv(s, OPC_VMUL_VV, a0, a1, a2);
+        break;
+    case INDEX_op_ssadd_vec:
+        set_vtype_len_sew(s, type, vece);
+        tcg_out_opc_vv_vi(s, OPC_VSADD_VV, OPC_VSADD_VI, a0, a1, a2, c2);
+        break;
+    case INDEX_op_sssub_vec:
+        set_vtype_len_sew(s, type, vece);
+        tcg_out_opc_vv_vi(s, OPC_VSSUB_VV, OPC_VSSUB_VI, a0, a1, a2, c2);
+        break;
+    case INDEX_op_usadd_vec:
+        set_vtype_len_sew(s, type, vece);
+        tcg_out_opc_vv_vi(s, OPC_VSADDU_VV, OPC_VSADDU_VI, a0, a1, a2, c2);
+        break;
+    case INDEX_op_ussub_vec:
+        set_vtype_len_sew(s, type, vece);
+        tcg_out_opc_vv_vi(s, OPC_VSSUBU_VV, OPC_VSSUBU_VI, a0, a1, a2, c2);
+        break;
     case INDEX_op_cmp_vec:
         tcg_out_cmpsel(s, type, vece, args[3], a0, a1, a2, c2,
                        -1, true, 0, true);
@@ -2407,6 +2437,11 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
     case INDEX_op_xor_vec:
     case INDEX_op_not_vec:
     case INDEX_op_neg_vec:
+    case INDEX_op_mul_vec:
+    case INDEX_op_ssadd_vec:
+    case INDEX_op_sssub_vec:
+    case INDEX_op_usadd_vec:
+    case INDEX_op_ussub_vec:
     case INDEX_op_cmp_vec:
     case INDEX_op_cmpsel_vec:
         return 1;
@@ -2567,9 +2602,15 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_and_vec:
     case INDEX_op_or_vec:
     case INDEX_op_xor_vec:
+    case INDEX_op_ssadd_vec:
+    case INDEX_op_sssub_vec:
+    case INDEX_op_usadd_vec:
+    case INDEX_op_ussub_vec:
         return C_O1_I2(v, v, vK);
     case INDEX_op_sub_vec:
         return C_O1_I2(v, vK, v);
+    case INDEX_op_mul_vec:
+        return C_O1_I2(v, v, v);
     case INDEX_op_cmp_vec:
         return C_O1_I2(v, v, vL);
     case INDEX_op_cmpsel_vec:
-- 
2.43.0


