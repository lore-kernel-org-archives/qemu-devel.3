Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51D55CAC598
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 18:14:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uya4T-00033A-0I; Tue, 16 Sep 2025 14:06:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uya4N-0002lc-T7
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 14:06:23 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uya4M-0001ZZ-Bn
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 14:06:23 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-45df0cde41bso42690325e9.3
 for <qemu-devel@nongnu.org>; Tue, 16 Sep 2025 11:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758045981; x=1758650781; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=B9VWGWlrF6zveqvRpxABw2S4ZXxummG73G7IdiTB2A8=;
 b=qAhTRsB1TM5oCQTGEgZ8QdgqQ7O2PP37Vz7xsmhhqMItDYxDLUnkOYhuMSWhuqiC0p
 GBTUt/uFUjHoz6qJw1Ao61WKRQr3zRquoL6vgpPi9c7UOIcgNa3kPnwUidtufX3qfeH/
 PP4vYse3UFESnrJvyMafzG4wszid2ErBhwYNM3ir1UolafED98l7EG/z8KF5H8YBZlni
 39WGahXaBR9BTzRWyL0oxo5b2hWI4+Wu74jUL008q73ACJCPHiSr/cMSRUm/rW47BiTD
 /72DJS03UZnao6XVqBtkeqvXs1cF8OUPXL2bf/KW4UJ5ZKdLgq8DHXBuYVj/+SOEZIm2
 +UGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758045981; x=1758650781;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B9VWGWlrF6zveqvRpxABw2S4ZXxummG73G7IdiTB2A8=;
 b=oITTznOgxV91ooH2tXjoMfcoXmVwVLmKWTVpC10moROHrD2ze85k494ovuElylKkpF
 Niwzoo1wDMIU8s/ZIH8N3EDsv+8sHVeejs425CXFxhwp/tCQcOem/jnBq7RdwrliNepm
 gQqQaDdom/Zi5a7IwCJjOSQDbagYUu5ocFUY7+xGHBnhxqY+Hrs4Xmw5FnPIGnXLwdyO
 TMdaZM83FNX57qX62g5cUQACnz+kQTUjg1BDvtRm2x+BW/h3C2u+xljLXjhBEV5enl0m
 fnIlQv/ZYWnx1aNM8lYxEMD/sFZXD466g7/u62u065yZ4JbYq7cWWNIJJOVq2SsRor9g
 otxg==
X-Gm-Message-State: AOJu0Yxy24JtY+Z5wPDIfE36FS0SCtFVlK5lqd3Co0ML5Aav14Qs9fpP
 tVp202am6cd4zioD1WGb0p1Y7yG7b+Yk1GYqQj9X9TjB4DTchRdkSJsyqbDUqogM5cCqfOHlG17
 WldQY
X-Gm-Gg: ASbGncswDVZNMCQHjJ2tPxIbGJ+Gxrajcc576qx0ADX9b6gAYV34gmAubbRQImbNNVt
 OuV16zG1sRE62sJ+vVSpgjS/QFtgM9A+G1O78kXifp7M3zVgDqg98QbEJwE6YtSQ0H/p09TFlYD
 Rnxt3BuzpHcVFYIDg2FaIhi+h5052djibXSEmuE2Otirona3oa4p7gUzxFVw4CriEJy0NnKBaYP
 saQQu6qH//UTuzmbyZWt5SeGClzlnWxZZWJLU2HJS56GdX48epL+WetmgegEb9mPK1SN2U3zO6W
 uHZCVGbUvjNzdwSSpfjM/ykxu+iLw0S9Ab0HOZ4O9qmoygAhVcVDIQAnfzQ5HzoCeJvYMrXhqkl
 8NV+Q3MxYXWkVvhSbaEvnmekw3+r8
X-Google-Smtp-Source: AGHT+IGYbbABcBZc08Kl12APH7TUL6GkgzWTjce7VqfuDj0XtlwXmkvsX3eKRgYsXlAt2BhYUgwsPg==
X-Received: by 2002:a05:600c:8712:b0:45d:e110:e68d with SMTP id
 5b1f17b1804b1-45f211d076bmr176709875e9.11.1758045980835; 
 Tue, 16 Sep 2025 11:06:20 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e760775880sm23033286f8f.2.2025.09.16.11.06.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Sep 2025 11:06:20 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/36] target/arm: Skip permission check from
 arm_cpu_get_phys_page_attrs_debug
Date: Tue, 16 Sep 2025 19:05:41 +0100
Message-ID: <20250916180611.1481266-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916180611.1481266-1-peter.maydell@linaro.org>
References: <20250916180611.1481266-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Do not require read permission when translating addresses
for debugging purposes.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250830054128.448363-7-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/ptw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index d37c0ce0f1d..5d85610de29 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -3646,7 +3646,7 @@ static hwaddr arm_cpu_get_phys_page(CPUARMState *env, vaddr addr,
         .in_mmu_idx = mmu_idx,
         .in_space = arm_mmu_idx_to_security_space(env, mmu_idx),
         .in_debug = true,
-        .in_prot_check = PAGE_READ,
+        .in_prot_check = 0,
     };
     GetPhysAddrResult res = {};
     ARMMMUFaultInfo fi = {};
-- 
2.43.0


