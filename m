Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0375C43602
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 18:42:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfMLJ-0007GO-DT; Thu, 02 Jul 2026 14:40:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wfMLA-00078k-2g
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 14:40:49 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wfMKp-0005MJ-RC
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 14:40:46 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-493b27c7451so9214225e9.0
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 11:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783017626; x=1783622426; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mkoXpIbTWhp23z0tfD91aY5yZBlUpXNBZ010xFJTbHA=;
 b=uSz9G05bc32/nGTqv7CG00N9umNwy3p8EwMMv1+IhHV3XndopjZFuyAFFO392sQl+z
 /4j4rA6eNcl6J1oLWVQjIGXO5vvv3v2JBHo8pLaKJ/iKIJo2eX/F0NYUtCGKWn5vbTbp
 XSOKFe/yNlwUtFa0c12tKwBsffCigyBvABtQcbaVPJ4aQ5rBGUl6vJXX/QNf7BDjURD8
 gs4eE7JMw1yTVYjtIJn3QRrvyHAdvb2kDAcUXE8Djdsbhj8gbc/j8tMdCJKyTmjko90Z
 mr/aI/SsvnRRGwAkSJ6sBGa4vua+re6KgNU2GO8pUqkOY7CO9tH/lLgrvRXhInZc1yrh
 HCug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783017626; x=1783622426;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=mkoXpIbTWhp23z0tfD91aY5yZBlUpXNBZ010xFJTbHA=;
 b=WOHnHxXsMB6KXwNHSXiFP8KmSVf3mcDO+qQF/ruMcyNOuOoPbm5e9lORwU+61wXrtT
 E0JnnSoq5fhAvAy21eDBWL70TZabKwgN8hfa7F0qH3dG15r1djfLWsVAZXnrIv7miU3j
 NbrspfAKmT4zi7iXWKq9pugqrV8ijDKNF1Ya8/dN9XXZDVAQgjPwP7lc8I8WSbrie4HL
 YKcbS7uSha0x48QmKNuQdVELXhkiMLDQyInypJx71plp26i5gQQs/r9E/l2NtY8PZjOb
 YQnv+1J1kd4F5lBbHhcrcxfcSJEjkjzw1x/yKNtRv/pzf6cKTZadr4IMTA+vVFnrAGq4
 iy7Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ81D3VXMSPcBOdlwG/Susb6SyrlkLk/Lx82gNpGsPuLWCC138Qzf4euIinT6OIFmqTG4lAnlhZET7mR@nongnu.org
X-Gm-Message-State: AOJu0YyUKP5/UOHrUr4qZx3DDAr2EB8WnFqy0anvctaCJv/S43A4xW6o
 gDZQaLxFCpNwBzt8cLgTBB7c+uIFr1YII4FdgoxY/eQi/Pjs41jSilDryZpCbkh8XoY=
X-Gm-Gg: AfdE7ckV8+wkgv4g3pgnDplKy7+eV0VsXa8HkmHVvcc07+Lf2u5UnROSQ19LZSvjS/H
 tqCGau9WRIkITFWY9oCTT7e/Lckxs+lO/es7HWU6tyx2oIwdLTMo7wGKOiiqMRDBUq8Pm+fVtSh
 uh4hm3nhMRMLkX9W4EnsRQq/y4aES8HMpL0YJz0CXmorH6Hdj0Z+NQQFQoQ8+MRX9LYPYPju1HE
 rIxknEa98cRMrcdoHEi6t7HJ3ZSZSfAF+fbaBfl04VNGflmZHkG4zMg+KQ6RBfz+LC0wrren9i1
 mt4K6mXole7Q5qDB61/C84MGtgzd0AGqho2LDuQWNYukO9XuBr2Rc8e4ys8FWrzIC8tVLqteHQd
 +IGe9blEzcsto4Hte2GRjmjPYVXdnCEx9rp0tkt8IQMpeesjW72S7IcHprlf6MvTXIIlzBpmJ0H
 Umk0dfPA/IeBpx2GuIPmaWClnDiZ6V8xiMK8G0+e+dAxQep1BRS1fwKZkO6YwbUl6+arAuiLAwg
 nEaRVmwYiSdZJDmKCQ93w==
X-Received: by 2002:a05:600c:3b2a:b0:492:6f5c:fd8c with SMTP id
 5b1f17b1804b1-493c9b62894mr14907795e9.15.1783017626304; 
 Thu, 02 Jul 2026 11:40:26 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-477db8a4a09sm11628213f8f.13.2026.07.02.11.40.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 11:40:25 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 06/11] target/arm: Handle NSACR.NSASEDIS in HCPTR accesses
Date: Thu,  2 Jul 2026 19:40:14 +0100
Message-ID: <20260702184019.3431139-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260702184019.3431139-1-peter.maydell@linaro.org>
References: <20260702184019.3431139-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

In cptr_el2_read() and cptr_el2_write()  we have code that implements the
"HCPTR.{TCP10,TCP11} behave as RAO/WI from NonSecure when NSACR.cp10 is
0" behaviour.  There is a similar requirement for HCPTR.TASE: if
NSACR.NSASEDIS is 1 then CPACR.ASEDIS behaves as RAO/WI in NS.

This doesn't matter to us yet because we don't currently implement
ASEDIS or NSASEDIS. But we're about to do that, so add the handling
to cptr_el2_read() and cptr_el2_write().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 926c9ed516..f645860e4f 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -4094,11 +4094,18 @@ static void cptr_el2_write(CPUARMState *env, const ARMCPRegInfo *ri,
     /*
      * For A-profile AArch32 EL3, if NSACR.CP10
      * is 0 then HCPTR.{TCP11,TCP10} ignore writes and read as 1.
+     * Similarly, if NSACR.NSASEDIS is 1 then HCPTR.TASE behaves as RAO/WI.
      */
     if (arm_feature(env, ARM_FEATURE_EL3) && !arm_el_is_aa64(env, 3) &&
-        !arm_is_secure(env) && !FIELD_EX32(env->cp15.nsacr, NSACR, CP10)) {
-        uint64_t mask = R_HCPTR_TCP11_MASK | R_HCPTR_TCP10_MASK;
-        value = (value & ~mask) | (env->cp15.cptr_el[2] & mask);
+        !arm_is_secure(env)) {
+        if (!FIELD_EX32(env->cp15.nsacr, NSACR, CP10)) {
+            uint64_t mask = R_HCPTR_TCP11_MASK | R_HCPTR_TCP10_MASK;
+            value = (value & ~mask) | (env->cp15.cptr_el[2] & mask);
+        }
+        if (FIELD_EX32(env->cp15.nsacr, NSACR, NSASEDIS)) {
+            uint64_t mask = R_HCPTR_TASE_MASK;
+            value = (value & ~mask) | (env->cp15.cptr_el[2] & mask);
+        }
     }
     env->cp15.cptr_el[2] = value;
 }
@@ -4108,12 +4115,18 @@ static uint64_t cptr_el2_read(CPUARMState *env, const ARMCPRegInfo *ri)
     /*
      * For A-profile AArch32 EL3, if NSACR.CP10
      * is 0 then HCPTR.{TCP11,TCP10} ignore writes and read as 1.
+     * Similarly, if NSACR.NSASEDIS is 1 then HCPTR.TASE behaves as RAO/WI.
      */
     uint64_t value = env->cp15.cptr_el[2];
 
     if (arm_feature(env, ARM_FEATURE_EL3) && !arm_el_is_aa64(env, 3) &&
-        !arm_is_secure(env) && !FIELD_EX32(env->cp15.nsacr, NSACR, CP10)) {
-        value |= R_HCPTR_TCP11_MASK | R_HCPTR_TCP10_MASK;
+        !arm_is_secure(env)) {
+        if (!FIELD_EX32(env->cp15.nsacr, NSACR, CP10)) {
+            value |= R_HCPTR_TCP11_MASK | R_HCPTR_TCP10_MASK;
+        }
+        if (!FIELD_EX32(env->cp15.nsacr, NSACR, NSASEDIS)) {
+            value |= R_HCPTR_TASE_MASK;
+        }
     }
     return value;
 }
-- 
2.43.0


