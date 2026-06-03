Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C389BCD6E56
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 03:32:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUcHy-0006Za-E5; Tue, 02 Jun 2026 23:29:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wUcHx-0006YH-2K
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 23:29:05 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wUcHt-0003ZY-Qz
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 23:29:04 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2c0bd02d97eso38274005ad.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2026 20:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780457340; x=1781062140; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dfTQIO3Td5ZnJtjFXmscxPDzamgvs+aWLTRE3ZdC8D8=;
 b=KOHXU8EXWvAODbPmDi4fBWyf+2eyOLmQVp8+JwmffPyyOjxnxnBuLMAbWXHjrMVTsu
 13Zy85KHrvxaW3227MMsPHQgs58vjYE0kJOtIW7yrd+SloJatZ5rWY1mnSvR34umyKgQ
 uuVj1VyHud/H6Pzo0vDPL5KgdWFrWuKrETuXrE/hFTIVtJ+G6zKCutatBcrNe2k5VXtb
 walykXcKc+hP+c9cpOcClqjHOuq/z2suBYpnWBSH1HFVk+lCiI+Q31p2PVTvUoFuOw7o
 OmOnAn+CjKHQ7ptEgOyCVZBeUdIP16auWdCYJJ/BrXswAPIC5IcJUwQl9QXD1cz6TqlP
 f6gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780457340; x=1781062140;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dfTQIO3Td5ZnJtjFXmscxPDzamgvs+aWLTRE3ZdC8D8=;
 b=XC+tOSQAYzaReMGTnrKE6lI9HhXzD38fuTR7l7vWzaeQqTBVNTLP+awxsSfc67iBBK
 2FlK3ZSuKbNTD9Bht4+Bg1Uth0wRcOsx3KIrLOmE/EhtKVxSUBqP5qh9rqmWMSKXFTbI
 Lhhz/B1fzjYvHXDxlTv+GMslZHj6OCGZxiebtP17EWNN0igjmVFv/8J5Png1RDpJYO99
 hrVRdOsiTOeSXYR51c+/QxKNNfqgU/XTsXovSwbo852iYnff63wRvu6iP+Fx/25zsjj2
 QkyYSVMJGdxDV+7uwLINpeAc3P7G/8H7INTIAfP8rfpyHeVbnpccd9DwGrGr9O7Bmm0V
 R/Gw==
X-Gm-Message-State: AOJu0YxlcSZbEKiKpycT5gmQV16pDpnZcnTOx7hFBo0NoC4gKkVjHv5h
 VFPmgUNqUBgt3yM+aaYXwWddK3f6eiYUzq+U+xZ1DELc5kFbimAq9zPVRJkcPRH9aVtBCE8Z2fe
 To6TLAEQ=
X-Gm-Gg: Acq92OHOL8Yg+k0a/WJKPFUnisABP7ZSD9/d2Bd3Z+47k8U8E//v0DxHq0K9CZSUMGE
 QzaU+BWOszX4mp8v2mRM1rlhk3JokN7X9CcBNt76ceRrnHw0Ke3f0FggAEWYBs6YAthwU5T1GyB
 CMFgHXf3qnavKBmaDXfeG+oFeBwac4EcN6FzasIi6S9IckK7cR6IgN1u1JHt51uhFpS1tkBBxbN
 guLeNnLQdi364sATPDR95drJY7peRx/kTAlun/91H+wHB0rWYUPcgTjtg2SHBzGS/wUAcAn/Ybg
 V611UD3ywFMgYd23NIKgwLnGohW2GHY5vWepLCahblHJbYGnARE7tet8uZqcBN3RQdOjM+jTWD3
 e2Xf7XLNQjG3eBUpDLfkrXYWYFwEk08yrYI3Q6vr/F3MLH1wTwO4FfQskqby3n6WuIRJPEO9sTF
 Y4cTCFJcWjlv5cmZN9Yj/rtl6zOkcNQzTuBBUwRhE=
X-Received: by 2002:a05:6a21:685:b0:3a2:f402:50fb with SMTP id
 adf61e73a8af0-3b49790c257mr1772805637.34.1780457340303; 
 Tue, 02 Jun 2026 20:29:00 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8428222263dsm1477831b3a.2.2026.06.02.20.28.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 20:28:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v9 05/45] target/arm: Introduce arm_init_fp_status
Date: Tue,  2 Jun 2026 20:28:14 -0700
Message-ID: <20260603032855.106930-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260603032855.106930-1-richard.henderson@linaro.org>
References: <20260603032855.106930-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Create a function to set all default controls for a float_status.
Other settings for specific FPST will be set afterward.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index a13e6dae2a..b75c6a6622 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -304,6 +304,13 @@ static void cp_reg_check_reset(gpointer key, gpointer value,  gpointer opaque)
     assert(oldvalue == newvalue);
 }
 
+static void arm_init_fp_status(float_status *s)
+{
+    memset(s, 0, sizeof(*s));
+    arm_set_default_fp_behaviours(s);
+    /* We want 0 for all other settings. */
+}
+
 static void arm_cpu_reset_hold(Object *obj, ResetType type)
 {
     CPUState *cs = CPU(obj);
@@ -626,20 +633,16 @@ static void arm_cpu_reset_hold(Object *obj, ResetType type)
         env->sau.ctrl = 0;
     }
 
+    for (int i = 0; i < FPST_COUNT; i++) {
+        arm_init_fp_status(&env->vfp.fp_status[i]);
+    }
+
     set_flush_to_zero(1, &env->vfp.fp_status[FPST_STD]);
     set_flush_inputs_to_zero(1, &env->vfp.fp_status[FPST_STD]);
     set_default_nan_mode(1, &env->vfp.fp_status[FPST_STD]);
     set_default_nan_mode(1, &env->vfp.fp_status[FPST_STD_F16]);
     set_default_nan_mode(1, &env->vfp.fp_status[FPST_ZA]);
     set_default_nan_mode(1, &env->vfp.fp_status[FPST_ZA_F16]);
-    arm_set_default_fp_behaviours(&env->vfp.fp_status[FPST_A32]);
-    arm_set_default_fp_behaviours(&env->vfp.fp_status[FPST_A64]);
-    arm_set_default_fp_behaviours(&env->vfp.fp_status[FPST_ZA]);
-    arm_set_default_fp_behaviours(&env->vfp.fp_status[FPST_STD]);
-    arm_set_default_fp_behaviours(&env->vfp.fp_status[FPST_A32_F16]);
-    arm_set_default_fp_behaviours(&env->vfp.fp_status[FPST_A64_F16]);
-    arm_set_default_fp_behaviours(&env->vfp.fp_status[FPST_ZA_F16]);
-    arm_set_default_fp_behaviours(&env->vfp.fp_status[FPST_STD_F16]);
     arm_set_ah_fp_behaviours(&env->vfp.fp_status[FPST_AH]);
     set_flush_to_zero(1, &env->vfp.fp_status[FPST_AH]);
     set_flush_inputs_to_zero(1, &env->vfp.fp_status[FPST_AH]);
-- 
2.43.0


