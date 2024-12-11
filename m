Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C35B9E7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:51:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPS7-0000K3-MR; Wed, 11 Dec 2024 11:20:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPS5-0000J6-E5
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:20:41 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPS3-0007jd-Ul
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:20:41 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-435004228c0so31043345e9.0
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733934038; x=1734538838; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=IY8zOoALtZnJGd9D02lgKKAFGzmZzVDZQ3xBBMlHM34=;
 b=zqwNghzmbrwHuZj+5gwNxIyPhJqL+IvyIk3UKTMq1+/odZOtpFk/vkvj+Tm9S7tzdA
 njDJSLX3Ey8KIYDhBmu/2Yeuh/olSfDsZP+Niz9U2Mkaz+pq2SPn8uNArxQu9/sCFptj
 rYENTxT9T0q61HoKeTVh4AZej0VwrvoHjJC2DeLzRvran51Pih0KVI+svxCN/Xd2m3ps
 V1b+reXBA3Ttk9w14Vv/wkjP/ogF9tDaui/k0PirHYTktx1Z4d0tQCB7lz8u/cp0ZHih
 R0X9talSyC2jVGxGfFJaF/jwjIR3e0VEWedA7dXKgdeg/dSLrbxCYr82uOlBSzC/R+iY
 72wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934038; x=1734538838;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IY8zOoALtZnJGd9D02lgKKAFGzmZzVDZQ3xBBMlHM34=;
 b=RMr9ggzxUvNIxNdnjoqqf4GzohTMomgBsFLf/tZbmr0j4r1H55IGDLGXfeUCpT/tLx
 fxi/DYjK2pqG/LEATWsXFLMZnygEdnZyNK/VJarLFLew6Ssro9IhJHyx2pdHUs6RUZBx
 4NdnxKsr66ilLdzWjF1hSZi0K6ImJaqH+hnWlznquueIHCD2O0FHD2stwej1lZEzJbm3
 cxcZVudpBMb2m4xWUPdtEGjKA2Ah+iAJ4cSlFh7Nw4c4Ij0dx+i6CMDkDFrQCIipG8Db
 ZOZtMd/+B176QRolNGiF/WkjEXXuTRPIulzmY17RTVIlI7C5B9Xpb2eotFOfYp6mIudw
 M2kQ==
X-Gm-Message-State: AOJu0YzS8IHM4BnOwQPdb3x9etO1xUvNvNPcdZL4FjHLOnB+xUUK1k5n
 3Jx/r+TUlH9mpUK+SislVKCHSuZvhYbgoXqN1fwc9nS2VLOejp0ZNDkWb3rdEKCefH4UrFwlhoY
 b
X-Gm-Gg: ASbGncvM7wvqWxJ/q+5eCn8Zbw0qEBGYi7tESywEn/YFrELscE8dGkrpI2SHIKOTPzP
 DF6z7OSKScymu6uADsIimoB0rmX6bAXutvmySmhfd6k026Xe+r+lUou3FX2DyIRyCrMbTa3LCO8
 8CoMw5TKo0q9I8Wq1Q5LMAbKTDICAlg4sc2x/E3OX+AC1yTgmL0I8F3OT3HxnyTanLDIaSp6Goe
 sp/lUBrqpj0U049/djxx2d4oaFut5PEoyY0bZAnFa98L+p1hd1c8uWV7oGn
X-Google-Smtp-Source: AGHT+IGYD9kPipiYTMlbmMegKbD5JIvjAUNuGQMrGulbALQVopxxnTegzRU4enBocm0rHCsjxQr+8g==
X-Received: by 2002:a05:600c:34cc:b0:434:fbe2:4f with SMTP id
 5b1f17b1804b1-4361c430b5cmr30266215e9.23.1733934038605; 
 Wed, 11 Dec 2024 08:20:38 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434f4dfdcdfsm121460595e9.39.2024.12.11.08.20.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:20:37 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 27/72] target/mips: Set Float3NaNPropRule explicitly
Date: Wed, 11 Dec 2024 16:19:19 +0000
Message-Id: <20241211162004.2795499-28-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211162004.2795499-1-peter.maydell@linaro.org>
References: <20241211162004.2795499-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

Set the Float3NaNPropRule explicitly for Arm, and remove the
ifdef from pickNaNMulAdd().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241202131347.498124-23-peter.maydell@linaro.org
---
 target/mips/fpu_helper.h       | 4 ++++
 target/mips/msa.c              | 3 +++
 fpu/softfloat-specialize.c.inc | 8 +-------
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/target/mips/fpu_helper.h b/target/mips/fpu_helper.h
index be66f2f813a..8ca0ca7ea39 100644
--- a/target/mips/fpu_helper.h
+++ b/target/mips/fpu_helper.h
@@ -29,6 +29,7 @@ static inline void restore_snan_bit_mode(CPUMIPSState *env)
 {
     bool nan2008 = env->active_fpu.fcr31 & (1 << FCR31_NAN2008);
     FloatInfZeroNaNRule izn_rule;
+    Float3NaNPropRule nan3_rule;
 
     /*
      * With nan2008, SNaNs are silenced in the usual way.
@@ -44,6 +45,9 @@ static inline void restore_snan_bit_mode(CPUMIPSState *env)
      */
     izn_rule = nan2008 ? float_infzeronan_dnan_never : float_infzeronan_dnan_always;
     set_float_infzeronan_rule(izn_rule, &env->active_fpu.fp_status);
+    nan3_rule = nan2008 ? float_3nan_prop_s_cab : float_3nan_prop_s_abc;
+    set_float_3nan_prop_rule(nan3_rule, &env->active_fpu.fp_status);
+
 }
 
 static inline void restore_fp_status(CPUMIPSState *env)
diff --git a/target/mips/msa.c b/target/mips/msa.c
index cc152db27f9..93a9a87d76d 100644
--- a/target/mips/msa.c
+++ b/target/mips/msa.c
@@ -66,6 +66,9 @@ void msa_reset(CPUMIPSState *env)
     set_float_2nan_prop_rule(float_2nan_prop_s_ab,
                              &env->active_tc.msa_fp_status);
 
+    set_float_3nan_prop_rule(float_3nan_prop_s_cab,
+                             &env->active_tc.msa_fp_status);
+
     /* clear float_status exception flags */
     set_float_exception_flags(0, &env->active_tc.msa_fp_status);
 
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index c4d8d085a98..28db409d22c 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -505,13 +505,7 @@ static int pickNaNMulAdd(FloatClass a_cls, FloatClass b_cls, FloatClass c_cls,
     }
 
     if (rule == float_3nan_prop_none) {
-#if defined(TARGET_MIPS)
-        if (snan_bit_is_one(status)) {
-            rule = float_3nan_prop_s_abc;
-        } else {
-            rule = float_3nan_prop_s_cab;
-        }
-#elif defined(TARGET_XTENSA)
+#if defined(TARGET_XTENSA)
         if (status->use_first_nan) {
             rule = float_3nan_prop_abc;
         } else {
-- 
2.34.1


