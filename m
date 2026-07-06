Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD82BC43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 10:38:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wggiW-000734-N2; Mon, 06 Jul 2026 06:38:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wggi9-0006xe-7n
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 06:38:01 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wggi7-0003FE-MV
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 06:38:01 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-493bfe9f886so15658985e9.0
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 03:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783334278; x=1783939078; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QQTwqppPqiePeZawZcTwYiUXWYlSSZwaAcnX9202ai8=;
 b=spVv6VabpE+UiHDbpsgARZ8dWo/YTisg/mNhm+zC5JvPH+vTMpRASsDKj9SsVdkrz9
 TViQBRj7kB95FAuE6vJuttp+2EDGpASw76DKY1paCIxWCpXwteRD6OA+GXX6+D7W+WdA
 q4jHeL1+PXHSROe/N2QGurvjKRaOn1OD56MEmZQ6GnbM9A6TR6Notm1CeDtnfkB5DFmB
 uoygztxAkLkvXZIUCeCnYVFuRAHNr8AY/jg/O+uHbAFCnDd0Y6IvHD2kZ7Q7qHyA+17/
 X8JWwR6tdiqo+A6/R10jRYF3ouYj6DvCBCTn4PQyT8LaoJByUHdaBIeA2FP2ys8qh3ZK
 I6yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783334278; x=1783939078;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=QQTwqppPqiePeZawZcTwYiUXWYlSSZwaAcnX9202ai8=;
 b=i4zrGLObKDnE7fJSvQ5FSw0+UBJXaK4mrgneOcG+Nzq3vgNSJlq6M9114FmnXGphzl
 0H7liAJ8AzrtaBdYPO6LGyFyOu8LU/WK42wq3aHMo6uYSLJQQjvYEp81+v3Nuc75Bxke
 BIf4OnBqQDpsNzPtR2SXlSkMDunqw1nvTIijmeIKRjwE8Ww3VD75SAJJOGTaBnk16ODv
 wHRpaIHZTBm6VrV3TKU4Y1WEYRi412+gOlQpne7WG4gzZyJ0WS9y/wntyFjiO6b8Kara
 9QteGPnbEUeoB7xYcWDFlhu2Ma5RP5J+gqlmJxiP9Vu03GNik3QkuiyWJMSALdEcSdyo
 TAKg==
X-Gm-Message-State: AOJu0YynIoPCfsjr0hcuQldDngsh3qHk78JdKQNmFu7mTEdt4s5bLG66
 SIeRoXzX/PgFwEv/izSW6wn2ajCvcP6PE4FDlyRrP168uxxLfHPZ5FPspNyREJuMVYVCH5Uuafk
 AS6KsuRe7ug==
X-Gm-Gg: AfdE7clWrt9FX1GKqhwb0MgyBx6Ae+m47hElwTzvyKm7VqJ6VOdofrdGkfe2VuE8w3v
 /KP6XHXB6mKxQ4dFV6Qh60Yzsy/QYB5s1HQ78xZNtBOcv3jeceH/g0RE0JsPX3xORTCUn/PT9g/
 /PdLyiAqwoUHj2yv4B3Bf3GSq4RU4gLeEN7KTKrIhS968OsGnfXcgplCpZsLA/BTe1O/8Rtirki
 9vbnV6CauEBhwxWGTu675OkKBEH5RMd6OcF5AMs0hrueRpj/WjC67jeHATFojNFqNc5kVkzb4kl
 fO0m2SyO362kUqsdQ3uGqYAltU13uKwswT5vcVHrM5NerY8mr55NJLFfK3pfI0pBRjCwmnD196X
 GbRoj6URqUgWZZT1Noc7rS/axlwGEkeHedm8IK+fMWeOXvbg3LtKe/DpVsfHfbMR73MUv5tlW/g
 RP6qFzjjv9cUwQyL/JcCPIbckFNLdFM7pJNZcSvcU1qMCT5RdR9YeaZ4TMQDvzZ4rkZu2d3sN16
 QJEdzYPYnLd+/ulCe7VqQ==
X-Received: by 2002:a05:600c:190c:b0:490:e5c1:b8bf with SMTP id
 5b1f17b1804b1-493d1cf1be4mr97442735e9.13.1783334278252; 
 Mon, 06 Jul 2026 03:37:58 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493c63b6f1bsm329501805e9.10.2026.07.06.03.37.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 03:37:57 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/49] target/arm: Only evaluate SCR_EL3.PIEN if
 ARM_FEATURE_EL3 is present
Date: Mon,  6 Jul 2026 11:37:06 +0100
Message-ID: <20260706103752.320511-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260706103752.320511-1-peter.maydell@linaro.org>
References: <20260706103752.320511-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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

From: Oliver Upton <oupton@kernel.org>

Running KVM with (as of writing, out-of-tree) support for FEAT_S2PIE
on -cpu max gets stuck in an infinite loop of stage-2 permission faults
due to the PTW incorrectly using an effective value of 0 for S2PIR_EL2.

Similar to how S1PIE is handled, only use the IMPLEMENTATION SPECIFIC
value of 0 for S2PIR_EL2 if EL3 is implemented and PIEN=0.

Cc: qemu-stable@nongnu.org
Fixes: a811c5dafb ("target/arm: Implement get_S2prot_indirect")
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Oliver Upton <oupton@kernel.org>
Message-id: 20260626231738.947317-1-oupton@kernel.org
[PMM: removed hardcoded tab]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/ptw.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 99295954a1..a29de0385f 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -1490,9 +1490,14 @@ static int get_S2prot_indirect(CPUARMState *env, GetPhysAddrResult *result,
                   PAGE_READ | PAGE_WRITE },
     };
 
-    uint64_t pir = (env->cp15.scr_el3 & SCR_PIEN ? env->cp15.s2pir_el2 : 0);
-    int s2pi = extract64(pir, pi_index * 4, 4);
+    uint64_t pir = env->cp15.s2pir_el2;
+    int s2pi;
 
+    if (arm_feature(env, ARM_FEATURE_EL3) && !(env->cp15.scr_el3 & SCR_PIEN)) {
+        pir = 0;
+    }
+
+    s2pi = extract64(pir, pi_index * 4, 4);
     result->f.prot = perm_table[s2pi][2];
     return perm_table[s2pi][s1_is_el0];
 }
-- 
2.43.0


