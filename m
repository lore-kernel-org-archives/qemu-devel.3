Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF1CDC531D0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 03:11:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wn6Jy-0004gP-9B; Thu, 23 Jul 2026 23:11:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wn6Jv-0004W9-WE
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 23:11:32 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wn6Ju-0000Uv-9A
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 23:11:31 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-ca00f126b7eso969553a12.2
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 20:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784862689; x=1785467489; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SAyYUmifYabZlR5CRo10gOux2eBGZPMIZfd2TBGiSro=;
 b=NpwLWKxACrKljYkTN5NV+zSvuLAsBJrV9KxzmqKKzNvIcOssGwGvaXTXEFzADqNlp1
 cv0nExupOPYvjsP2W5kZW/92i1C+IMtb717sEps+JpgOUPB4KUp7+dhkGorPt1NX/4R1
 +3uMyvaaqmlE5VYjkIzXcCBcCuAjHhO2FyjsQ4yTrtgobQWLNFjs/1zb93NGb3S21KKi
 bhEwdnKLJF+Bbfw6pdLJXUs7CoM9OK75cUGWoz97cHQKeGj7nqFCqvJWTFbPnfzfveoi
 eIFWkCHzLL69RzOfTpW58RN3PAJ+DFP4LXCc9hJ/ftWyonJn5VhaVbJaLDAjTmQYnmA6
 g6UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784862689; x=1785467489;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=SAyYUmifYabZlR5CRo10gOux2eBGZPMIZfd2TBGiSro=;
 b=sEyBoG6/WZQ5fZWKqGXKL0Ye0BleeU/n9UNxVyE/Awtp6P3SAqbH5g8/G1TtVrkjsO
 eygPs8M60Au/WsT0qTUiKYYMgo2rRDs3h/DpdCyxp38UZLTOenjXoAVrCMkFAcgZ3EXf
 +nz819vvjjLoAlm5gtPSxyRfgfazqOL8yLQqlXrlT5dg55HrjXjMM/8KhazhB4vpG+R1
 V6WeL9iCErY8mp01HkzabW6vV/oGkQKw+PDeiDajdmcGp1dk3qFRgLIpZxx4Wuc/gd7q
 iHAStltQoUChM6Xs1wZq4RcBsFsyKECMNfbtMlvmJWh/sqhD218kk14xEeywX8iLrptk
 PKBg==
X-Gm-Message-State: AOJu0Yy+A0GqmiZnuulRYLv1hH+Aba7Qu4N3FoEdqBdUU0yuejb4WFVk
 IC09srmPdo4OVEeL3AD6et2xO7lMevRgow9U4gKjGVg/Z+aG2yQ7xCusllTd3gKyI8aleuiMzpc
 sc/X8
X-Gm-Gg: AR+sD12qveKgwqyfikBWQjT8CGzCPhUufrvlF9/I6+MRY+Fcv8UEhtqKEdTOCbEjVKl
 WurVYnRw5KtqLqOw1M3NKcC/x1TnCcoLBOCWwy1ZNRv/6lVv9XOwGCcEpMjRRs08171xzm0ec7f
 aSAFPfv+USHz3omHCwaoZe3Mv+8tpgbHjVVf1w+EhpBSvhEhCv+ZU2w/jrAPSNV5Z8fjLuZzVaE
 JT6tgTrZ6YdkX51hVL+DCPk6ilMVaCTGEFG6Z1QFCCTqWPwsOr0IzoO3HpoQK1uDbEcfxjdGS10
 D/4A1kwtRq8TH61QsLsNz0xGWHbAHVSVvV0IzflnQgW6MXJzUgwn6+XcmbAwOxMsLdb8CAPhmS/
 iqr1Xa2yFFMZH9RRZpuyxXmzoHoge/hWXf9fiMPx5tAJ06Ul9ijWPVFbgOizY/Bbb5CBO7L3zaQ
 enjWBkK4FMyg15/ycT2uTiBnqSQ3tiGQk2XUZERQJvE3TE
X-Received: by 2002:a05:6a20:914d:b0:3c3:a804:8eed with SMTP id
 adf61e73a8af0-3c44b2030f5mr6619728637.56.1784862688871; 
 Thu, 23 Jul 2026 20:11:28 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbb8f0d872bsm3617697a12.7.2026.07.23.20.11.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 20:11:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 5/6] target/arm: Implement SCR_EL3.TID5
Date: Thu, 23 Jul 2026 20:11:22 -0700
Message-ID: <20260724031123.76597-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260724031123.76597-1-richard.henderson@linaro.org>
References: <20260724031123.76597-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52d.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 022a63a511..c92df41707 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5485,8 +5485,21 @@ static const ARMCPRegInfo dcpodp_reg[] = {
 static CPAccessResult access_tid5(CPUARMState *env, const ARMCPRegInfo *ri,
                                   bool isread)
 {
-    if ((arm_current_el(env) < 2) && (arm_hcr_el2_eff(env) & HCR_TID5)) {
-        return CP_ACCESS_TRAP_EL2;
+    switch (arm_current_el(env)) {
+    case 1:
+        if (arm_hcr_el2_eff(env) & HCR_TID5) {
+            return CP_ACCESS_TRAP_EL2;
+        }
+        /* fall through */
+    case 2:
+        if (env->cp15.scr_el3 & SCR_TID5) {
+            return CP_ACCESS_TRAP_EL3;
+        }
+        break;
+    case 3:
+        break;
+    default:
+        g_assert_not_reached();
     }
 
     return CP_ACCESS_OK;
-- 
2.43.0


