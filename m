Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44343D1714C
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 00:14:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t32VV-0000Ei-5e; Mon, 21 Oct 2024 20:12:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t32V3-000052-6E
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 20:11:49 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t32Uy-0005Uh-Qo
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 20:11:48 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-20c7ee8fe6bso47877225ad.2
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 17:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729555902; x=1730160702; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F16mOGOCEtDulhf7gkD6+zfYNl/76OFFUvZQ0M86ofc=;
 b=UGJTP61REZJsfISa6Cxk8Fj8LnGJyGSoAtREALjQXa1J7YV+EFWr9s58Ak5WxTv7IZ
 f8GlVL+qK4KuGL9U+qG77n87EbJm+XUd2SqrA1wWkOHYxrt+LQHk0AQcrAhpop4vcpVA
 i+vd5YZeXlVOiug8Atb1OV2m06SN0JubSyZ+AAIeblpLCnLhXUAX1raMacf7H552iobI
 k+SHdM8UapBb3vrrYv4/y6I1sU0BTRITyLeqTnesFG/r0ctgln+ONWGsIOrwaucmraIC
 4a42WpaO2LPzvx8H0N05ofLwzCqVA+55066JDMsvLGXgDUbw0yMZc2oshoqLc7XDxdYa
 JKIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729555902; x=1730160702;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F16mOGOCEtDulhf7gkD6+zfYNl/76OFFUvZQ0M86ofc=;
 b=Q8qyYFuo3nP8PuXoR2W7GRjx3NekFbh7ziW/2zVHojcAqhTLnv4kwlArNdN2vfaODY
 7xSqf2kbNVfbWgimNP0XN+YqwALpHy/IFBrx4qpnTeKhHZ7Wk1SqBTzV25iBN3v4h4TY
 JKzm2Ot1xQ8q7DJY/Myze/oMzMUGMknu2uqnQoTTMBlY1CuSTfLf0A9p2awRIFVdHOC6
 sLghgWZOuzcBfYvTIdERkiYajQfZi9YyxngsFXwCPUeTn5mYHRTAl4pgtQ78xk0rCNa7
 O8xviYTUGpTHBxUrcXa7hk6yZ1SUuKgXiKfHU2qwn2U6sjADkF0nqWFsp6KG9/CfOzVp
 9Eng==
X-Gm-Message-State: AOJu0Yx2br7TpWUgaWMPzmwAHSOjF1vDCeDJMS+Ay7aHE+4FiFbjYB2b
 yESaLc4ExJ4RwwRDZE/WlEZw76FprXezu/qpp1Sdx0G3KPS4KxzzMcqCjaC67GdDHHJO3X6RWGp
 1
X-Google-Smtp-Source: AGHT+IGJVXgvVgNTHhZf5YiRVhUWmL7cqyYMWu3Z8VvX6LjUPm1gkMVtHbsjXtytNf1BgbTnj9ya5Q==
X-Received: by 2002:a17:902:da90:b0:20b:951f:6dff with SMTP id
 d9443c01a7336-20e59aa0261mr193502755ad.0.1729555902376; 
 Mon, 21 Oct 2024 17:11:42 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20e7f0f6462sm31681145ad.272.2024.10.21.17.11.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2024 17:11:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, dbarboza@ventanamicro.com, alistair23@gmail.com,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH v7 08/14] tcg/riscv: Implement vector neg ops
Date: Mon, 21 Oct 2024 17:11:28 -0700
Message-ID: <20241022001134.828724-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241022001134.828724-1-richard.henderson@linaro.org>
References: <20241022001134.828724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


