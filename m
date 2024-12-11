Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36780E77182
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:20:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPRy-0000FL-0M; Wed, 11 Dec 2024 11:20:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPRu-0000DL-71
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:20:30 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPRs-0007gt-4L
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:20:29 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-434a852bb6eso66240395e9.3
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733934026; x=1734538826; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CQjRicSg/XdHnvLYpOYP7psZ4EG5XIl4wxja3fhCd1M=;
 b=Bhh0bEpME3bKFrEtMe+SBaQYO6t/Epy8JMJjA/L5AJ3SPQN+dmvFzb73oyeL2VOepR
 WkFxnnsJ/35nQfUe6RjtAohlH45ekjmxG9kQaVB1nOMVFmA57Mmtm9P1oT2sZmhuuFY6
 v3g2V0ZkeVP4upRmtzoSgrrb6wSmRdgdrqjScRhXderCP75T6K+jCCENayLpUXnLJkus
 GTzPIbivolsA/WGr2EADz0pye9ZDjI+BQPFcJz0XAU9hUfI5SofWLWqhmzeDjXOxcWWZ
 7RvtZHcggvioDLgbJnn4YmyWs6ZH1jmvkABCPw0gG1AXPAtrKjAKzjpHlYO2Z7lP6L3I
 cFNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934026; x=1734538826;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CQjRicSg/XdHnvLYpOYP7psZ4EG5XIl4wxja3fhCd1M=;
 b=Ozyuy7T3rY8vuBiOcWyM9+sLzdLirZcQkDaDikvk63Cin4ct2HOY+7AEUqEatKpAWF
 3XWSE+EeFvs+3pthZuFDxdwfAUwM7v6Jng4U0EkPF4pM7YpbD42oYvUMICNayuWry1s+
 nAW+Js4fWT4wNVtCljRHou8iCeYVkAYvI7K9M5oJknmPxHdB0PKs4r+J1apTzTsea72I
 8a1eC07Ez63FYNOHYm21vOL0ELlnGlaWsnC0yF0y9ug8Pm/IQhJvIeM77D9knxAwWscT
 3qkRSW7yO/PNsCCsf/Z4gHAP5aoGfLHx2JhzBuAmSpXdeXDiNOtzegmKERUY2zRZlzAN
 Ilew==
X-Gm-Message-State: AOJu0YysuS2PyXM3vunLK8/WX8qHCoYQzS5iZPPncoi/bvNU2RZyd71g
 Uq/gK/9i2kfct6XwW8Gd1xX1wFPs/YF9q26AWFauPqvW2hnlRLcqQlCBqkWKz3zkEXJbLn3SmMt
 Z
X-Gm-Gg: ASbGnctadv6rQ3zzRUURV3V/qKT+CFN2iXRWum2Nf8gxr++5ouc8JtkiOFYJaKCltit
 kgT/8eZQxKE8Wdmy+W75TshhVq0LP2z9o0D7g8aDlC5z+3DcuzLFhg5uioYBSGsbAj0SJlYSokk
 Oa2OUSb9vAKqks7TMt3YkSGQnNydWmFfKnFxNvZ36S+PSyDWGpoetOn4A/GvDMac0kpSLcEgEGh
 ssZA2H0cJQ4qE1V0ssZHeCUQ7c8tuQqKGAL/9ljVuWDUFhw0ERKlnbPj35U
X-Google-Smtp-Source: AGHT+IGKkyCTGismVk1cmEz9ugWa/XTFjU+N/gh5NKLd5yjFhRDEPhNDifYAagPiN4abwtKPyxxBaw==
X-Received: by 2002:a05:600c:4e4b:b0:434:a0bf:98ea with SMTP id
 5b1f17b1804b1-4361c35cc4bmr27283155e9.9.1733934026456; 
 Wed, 11 Dec 2024 08:20:26 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434f4dfdcdfsm121460595e9.39.2024.12.11.08.20.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:20:25 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/72] target/xtensa: Set FloatInfZeroNaNRule explicitly
Date: Wed, 11 Dec 2024 16:19:07 +0000
Message-Id: <20241211162004.2795499-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211162004.2795499-1-peter.maydell@linaro.org>
References: <20241211162004.2795499-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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

Set the FloatInfZeroNaNRule explicitly for the xtensa target,
so we can remove the ifdef from pickNaNMulAdd().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241202131347.498124-11-peter.maydell@linaro.org
---
 target/xtensa/cpu.c            | 2 ++
 fpu/softfloat-specialize.c.inc | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index 6f9039abaee..3163b758235 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -133,6 +133,8 @@ static void xtensa_cpu_reset_hold(Object *obj, ResetType type)
     reset_mmu(env);
     cs->halted = env->runstall;
 #endif
+    /* For inf * 0 + NaN, return the input NaN */
+    set_float_infzeronan_rule(float_infzeronan_dnan_never, &env->fp_status);
     set_no_signaling_nans(!dfpu, &env->fp_status);
     xtensa_use_first_nan(env, !dfpu);
 }
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index 7e57e85348b..3062d19402d 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -489,7 +489,7 @@ static int pickNaNMulAdd(FloatClass a_cls, FloatClass b_cls, FloatClass c_cls,
         /*
          * Temporarily fall back to ifdef ladder
          */
-#if defined(TARGET_XTENSA) || defined(TARGET_HPPA) || \
+#if defined(TARGET_HPPA) || \
     defined(TARGET_I386) || defined(TARGET_LOONGARCH)
         /*
          * For LoongArch systems that conform to IEEE754-2008, the (inf,zero,nan)
-- 
2.34.1


