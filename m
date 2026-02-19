Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1BABE9A048
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 10:38:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt1Mi-0007Kh-Va; Thu, 19 Feb 2026 05:34:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vt1MT-00075g-Rn
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 05:34:22 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vt1MO-00063C-LQ
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 05:34:18 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-48371bb515eso10524765e9.1
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 02:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771497253; x=1772102053; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jonBmBAd2vKXepXDKOxHMTPQMo4nlAkRTz3mBiiL0xA=;
 b=q8YqKv3J7bdmd+4XvIYmbvaf9uPAwbR4y63JGax1u18gMXrY4DaQJk0jEhDtFhBYFr
 noy/DzuHjduIHdZv72ba9Gp+TGWxSTvxmQYtymCXI56si3TK8yaYf6nY1QH11VXVTTbd
 vQI05x9Fvn2nu96mt6HWOMbNSv+ZppYrAjjEHHmjtWu3aeBXrxAxNe29KKUwP1v+QRWi
 jF7xiHjlzM5y/pVSBY0/mhEdeGTBJlKUtZSpHMTamcm1tVTl2zJ4yabhP3cmGs+QsZKP
 Kx9LfZxERincHQscaGU9oxvptBhizegafoEIS8zwHRW5yT8lcoJkGPfE0EJm85Ue0cJa
 TUqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771497253; x=1772102053;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=jonBmBAd2vKXepXDKOxHMTPQMo4nlAkRTz3mBiiL0xA=;
 b=As3Jz5+YXEZ9ECjPKuyj6+dZ1dByFnDXk+mpKk0/gBlowfjS4KcXaAo/0DMUNS8uLx
 tG173VDtwCGM/NsZJFt7achwso8dgP028sfbbLVyENN6GB8PrAD39KNzXuUNxL0VYBph
 rpiUSBKExBbIBatrT6CJS+MZcoIyJWXp+yjCE7QJL1QMS6hS+XO4oOvyfwA4SNEzd6Vr
 M4YhsHqxsir8lxZvy7Oxjd7zPKyX2TS1If0qkLN8tg5H56/80IUM/2ENMhc4kY/zoF2I
 duAFjSTD1Vdgj9KlDTIWXkABlZcFLCOZSw/NSxP1LssdRvYNLlLiNbglSITKrs+DsTlv
 rcrw==
X-Gm-Message-State: AOJu0Yxuury9btdIbSQ2N0qdiRjTaePPWZK0bZgpAZJVllHNIncj+PEd
 nnsF/Iu7hC/9l/eXnvNBVybGSeXTbeMf/oNFJUCMtAvVoIjYCpTTBN/1WJOzOy04MbZBxh3v8rk
 +BDXk
X-Gm-Gg: AZuq6aJZ0YoME2r2ML2lMtslXQcvsqjXifZVUIj5E+FQSjv5EPWWXFg9pgUhp9Tplt+
 GkrjEkirrH7K48dNfvmQXc6QXX9Q3R1W3EcgBkyefnZuPClmQPgJkHQVvLm7/pw/stiyMPAXIqs
 eoDqCtDUZMXiFrphZJaeWajhfrG4aA/VwJtFz5ki4w0xLkmqRQlHVEAQcJu28OA7jcLjTVXmtz9
 Ut8VK93yVsraZRJpqRY7wV6vOQpX9tKs/ra6Y1MCd/aHrJq24dw4vqhJ5xPgRsgvrNt7TgvFib7
 /zfWG6txMhN4bMUm00aoPLe/Yqa3tfjKO1Y7l1NV14Xy0U5sVe1CfW7HZ1rhiT7OJIZZxNjLglY
 BB+alhYJHyOeA9XsXKuXcYAwPDspqQHmvBrNlC4HIsV3C8Ia99WqfLNJ9FA3lMDnT+oHg8nZ9WX
 RT9TaJWfmIZIKfz0JDCvpTQogv908j6dqcHM9GESfC/DxqRgBXu7cE0LxDx/1TCWHKIyOk6p2+s
 vMtYp62GLtSTkwkIN5/mzUWB5iRL84=
X-Received: by 2002:a05:600c:8b77:b0:477:af8d:203a with SMTP id
 5b1f17b1804b1-48398b6d8f7mr85582265e9.27.1771497253022; 
 Thu, 19 Feb 2026 02:34:13 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d5ebd34sm697630795e9.7.2026.02.19.02.34.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 02:34:12 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/32] target/arm: Handle SME-only CPUs in sve_vqm1_for_el_sm()
Date: Thu, 19 Feb 2026 10:33:39 +0000
Message-ID: <20260219103405.3793357-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260219103405.3793357-1-peter.maydell@linaro.org>
References: <20260219103405.3793357-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

In sve_vqm1_for_el_sm(), we implicitly assume that the CPU has SVE:
if called with sm == false for non-streaming mode, we try to return a
vector length from svq_vq.  This hits the "assert(sm)" at the bettom
of the function in an SME-only CPU where sve_vq.map is zero.

Add code to handle the "SME-only CPU not in streaming mode" case: we
report an effective VL of 128 bits, which is what the architecture
rule R_KXKNK says should be used when SVE instructions are disabled
or trapped but floating point instructions are enabled.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260202133353.2231685-7-peter.maydell@linaro.org
---
 target/arm/helper.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 373f0ebcb3..ebf185000b 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -4775,7 +4775,7 @@ int sme_exception_el(CPUARMState *env, int el)
 }
 
 /*
- * Given that SVE is enabled, return the vector length for EL.
+ * Given that SVE or SME is enabled, return the vector length for EL.
  */
 uint32_t sve_vqm1_for_el_sm(CPUARMState *env, int el, bool sm)
 {
@@ -4787,6 +4787,12 @@ uint32_t sve_vqm1_for_el_sm(CPUARMState *env, int el, bool sm)
     if (sm) {
         cr = env->vfp.smcr_el;
         map = cpu->sme_vq.map;
+    } else if (map == 0) {
+        /*
+         * SME-only CPU not in streaming mode: effective VL
+         * is 128 bits, per R_KXKNK.
+         */
+        return 0;
     }
 
     if (el <= 1 && !el_is_in_host(env, el)) {
-- 
2.43.0


