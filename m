Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C20FD2E010
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 03:38:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3S9N-0007DV-HQ; Tue, 22 Oct 2024 23:35:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t3S97-00070f-Rz
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 23:34:54 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t3S92-0008Lf-Kw
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 23:34:53 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-7cd8803fe0aso4246006a12.0
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 20:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729654480; x=1730259280; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F16mOGOCEtDulhf7gkD6+zfYNl/76OFFUvZQ0M86ofc=;
 b=CkP9uyJ0djKTevcrWj1IDZak6H3ZnCWW0T5g4X7o0BxnDRdw1oZ0i8GEfxAlUXyDAu
 4BHfd69DfTqRVB/t5lRCueXr1LxVxNlaM1RaOI5+MH1HadVWkw+DE1KmSNYGEDu+iupj
 0uJP+kgemV+DRBnTTeOz55V+HFwCod8VGaXzekAov8F3Pogrbu48KcKEEnGlAfZZz4La
 pN+FhgdoKBa245iDyw+VDUn/pgwHNhtVi4AId/egD4qCoZqcLKphvTiCS7V+GWbOSJQ5
 0iMoQqHY/vxRL/qw6OIcOtaciblzMQEwMs4W45/wWdtfqSAw14Z05WsR5/RLgIOOxwJE
 C69g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729654480; x=1730259280;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F16mOGOCEtDulhf7gkD6+zfYNl/76OFFUvZQ0M86ofc=;
 b=Ka3J8sOep8EQAgNkzLEQK+UnPdQQ1QRsOCwbbjJBaeCXrIuzXcfkRvLYcpAY0O9qdJ
 SJfnh5BDX291Vjr3QS6eYC3LsNDjtcEcCvZ86H2iwK9PK/9sjr9hDHVbgBDARwinanrd
 Z+967BkTYSPSRJE954CLJ/yU8vi/am4Gwg5c1ZeoMNypEvL+If13mPukk6gmotfbVWuQ
 NHLnsgZ3TH98EHaBRS8ze0y06iAbmCEqjOyGjs/AmPrVzel4iZv/Vkk869xd7JW2zfy7
 wcSfvgBR8oO+jpaqeIZ4AZsCJ827KkSrFsUpTStqM6JRdBaiiEn05i/+uofCYRpPmDPb
 qz7w==
X-Gm-Message-State: AOJu0YxuwwvFhm1KlYxopbpRdl7iFilJN13n2mLPnIo8UdaCaSLg87Lg
 rFDmqUbFEOvJRauCfZUXaa7ariHuawoO0Y0NVQT7Y46fY07DWgTiRUnDipb9l30bag9I7YyC13D
 Q
X-Google-Smtp-Source: AGHT+IHMj4O9Fa/Vo8nra90ljdYNkyU0O58RdSv0Yho1TASRMomV+Zqrcx6UKCAKH5tCFYQYj4OawQ==
X-Received: by 2002:a05:6a20:d503:b0:1d8:fc13:2399 with SMTP id
 adf61e73a8af0-1d978b24100mr1478483637.16.1729654480043; 
 Tue, 22 Oct 2024 20:34:40 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71ec13d73b1sm5438338b3a.105.2024.10.22.20.34.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2024 20:34:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PULL 08/24] tcg/riscv: Implement vector neg ops
Date: Tue, 22 Oct 2024 20:34:16 -0700
Message-ID: <20241023033432.1353830-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023033432.1353830-1-richard.henderson@linaro.org>
References: <20241023033432.1353830-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
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
Message-ID: <20241007025700.47259-8-zhiwei_liu@linux.alibaba.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/riscv/tcg-target.h     | 2 +-
 tcg/riscv/tcg-target.c.inc | 7 +++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/tcg/riscv/tcg-target.h b/tcg/riscv/tcg-target.h
index 94034504b2..ae10381e02 100644
--- a/tcg/riscv/tcg-target.h
+++ b/tcg/riscv/tcg-target.h
@@ -152,7 +152,7 @@ typedef enum {
 #define TCG_TARGET_HAS_nor_vec          0
 #define TCG_TARGET_HAS_eqv_vec          0
 #define TCG_TARGET_HAS_not_vec          1
-#define TCG_TARGET_HAS_neg_vec          0
+#define TCG_TARGET_HAS_neg_vec          1
 #define TCG_TARGET_HAS_abs_vec          0
 #define TCG_TARGET_HAS_roti_vec         0
 #define TCG_TARGET_HAS_rots_vec         0
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 1893c419c6..ce8d6d0293 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -276,6 +276,7 @@ typedef enum {
     OPC_VADD_VV = 0x57 | V_OPIVV,
     OPC_VADD_VI = 0x57 | V_OPIVI,
     OPC_VSUB_VV = 0x8000057 | V_OPIVV,
+    OPC_VRSUB_VI = 0xc000057 | V_OPIVI,
     OPC_VAND_VV = 0x24000057 | V_OPIVV,
     OPC_VAND_VI = 0x24000057 | V_OPIVI,
     OPC_VOR_VV = 0x28000057 | V_OPIVV,
@@ -2367,6 +2368,10 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         set_vtype_len(s, type);
         tcg_out_opc_vi(s, OPC_VXOR_VI, a0, a1, -1);
         break;
+    case INDEX_op_neg_vec:
+        set_vtype_len_sew(s, type, vece);
+        tcg_out_opc_vi(s, OPC_VRSUB_VI, a0, a1, 0);
+        break;
     case INDEX_op_cmp_vec:
         tcg_out_cmpsel(s, type, vece, args[3], a0, a1, a2, c2,
                        -1, true, 0, true);
@@ -2397,6 +2402,7 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
     case INDEX_op_or_vec:
     case INDEX_op_xor_vec:
     case INDEX_op_not_vec:
+    case INDEX_op_neg_vec:
     case INDEX_op_cmp_vec:
     case INDEX_op_cmpsel_vec:
         return 1;
@@ -2550,6 +2556,7 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_dupm_vec:
     case INDEX_op_ld_vec:
         return C_O1_I1(v, r);
+    case INDEX_op_neg_vec:
     case INDEX_op_not_vec:
         return C_O1_I1(v, v);
     case INDEX_op_add_vec:
-- 
2.43.0


