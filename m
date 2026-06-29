Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 876B1C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 12:12:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weAfo-00070Z-Dt; Mon, 29 Jun 2026 08:01:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weAfI-0006pS-QC
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 08:00:46 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weAfG-0007IQ-M2
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 08:00:39 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-493b27c7451so5768775e9.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 05:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782734437; x=1783339237; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8urwzDhTUFQ0KrU8oi3jNb2QStbtFD8dvr6JCs4oGzQ=;
 b=QI7PNM40y1xw1DIogSMAAJcDUnHDAd2l8I+ZKaolymqmI1mryp1DsGSy3rAuicP1tP
 CMMW408ayIdinS+3O5xKAPl2H05a46Yof2eiIvbQs35RUO/9XqMVoK9oNYOok92wMYMV
 M2qwiSgeeOue3XhGKmVjqiN/2f8bD+wQDimjWTC9AcpDhEj4Bg8ZZBkDXim/oIgTL4/S
 R2/m8DnS2EwHhoQLnN/Lb0/3p2nTS/aGfnudQNaW5l7ZPouwqau37KbZD/MP/qaOIiPT
 4Zu6P/iAmgTGxSO7XaUSzjwoWvpWzdz8c5hCXTxvb67yxOukpU8Q1hr9w1tsnYJiikRl
 sRPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782734437; x=1783339237;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=8urwzDhTUFQ0KrU8oi3jNb2QStbtFD8dvr6JCs4oGzQ=;
 b=RaOV5kXu50rzyN6PVq0tjaQCcEta7zw5y7k0EcYaZXfsKjmsWFmjBc2InX2DhbVSpd
 0Vw6zCnmAsin3jB1taD89W/MBgVIM6wV44pa+OO3zm0e89nJo9y1f4MPhoYFvsKByx/D
 SCW/6wPwJu5Vo0YutUW8pIQ8Q5rkF+9yYZFOHqkHR0vi83mmOeezmzGNfiDNZYb2/lrJ
 WAsJeBheEwFjXkELmv+3K+XGfbK1VkUzISuxyO01LXaKPAdCGqxf0SC0y7yQ96Ez4h5S
 aI7N3MEVul1vUGK0fxWB29FchQBHRTUr5sJyB2gkqgGPROwNdMZomiMY6tO0xBZNiXwe
 Nw7A==
X-Gm-Message-State: AOJu0Yxn0baO0qldU7H002mOutMBatrGDwy7Mvb/29G0p1dHdlE5QmLM
 GOgye18J0grwuZgT6ejdMtN3TwgZkiFlHMVd7KXx0IGulpDPPa3tRixENWtztStVuWEPCJ8LbrI
 z9oo5
X-Gm-Gg: AfdE7clj0gclbff2j0lV7KjpJSfKmIpujuLQ+xJYSHZPjrk1EXoodxYdcrN6qi/Y6sa
 mibbZ5wDnlf9mOY+xguet++ffOjg7ed5TGwcsEnG5A5sJ9wyS6rc6lLqQnG/z3jeC198Pc+dkX/
 NYLM4DdAloYMLCXoqVnnj5ZCMapxFGMVRl7KAr74Vxx4zBDeDNHi6Epea7fZYS5VSYxG3MTXy+f
 9+S9TOUEHKz12Lz64vOeOeo+AdSi53PFWKtRVUR8lL1JkuP0GBwVskIbpBPCUKevR9Js9MvEQGh
 X8cpMvhZW9GaPioZCVKWRBEkbvVBJMuHUhIeRm1NDhZhXgLr71lbKRfilLlcIMhUHYOiTviPCRI
 tLN9TucoXOYLuhovhrFRYEt+6cjkv3zHNNA1TTUxfLsBfTOAOtjka5kteWZWLUL9v2leFmXp79w
 thuD5pHD61aPq8BEj8/Edpy57Ux9WPFCv4XZFKId5sEj6uwhrKh8y7vZUzRirofLvpna0BwNvMw
 nfKWs05MrN+cAglVRPmMlAH/k6iOxA1
X-Received: by 2002:a05:6000:250a:b0:46f:8561:fe60 with SMTP id
 ffacd0b85a97d-46f85620156mr16548709f8f.17.1782734436885; 
 Mon, 29 Jun 2026 05:00:36 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-473dddcb295sm8753061f8f.35.2026.06.29.05.00.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 05:00:36 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/54] target/arm: Enable SCTLR_EL1.EnFPM for user-only
Date: Mon, 29 Jun 2026 12:59:40 +0100
Message-ID: <20260629120032.1645265-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260629120032.1645265-1-peter.maydell@linaro.org>
References: <20260629120032.1645265-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

We advertised linux-user support for FPMR without actually
enabling access to the register as the kernel must do.

Fixes: 2430d49a17c9 ("target/arm: Enable FEAT_FPMR for -cpu max")
Reported-by: Dillon Sharlet <dsharlet@google.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260618040718.572950-2-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 86aae36ae5..128c78f6cf 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -421,6 +421,10 @@ static void arm_cpu_reset_hold(Object *obj, ResetType type)
         env->cp15.mdscr_el1 |= 1 << 12;
         /* Enable FEAT_MOPS */
         env->cp15.sctlr_el[1] |= SCTLR_MSCEN;
+        /* Enable FEAT_FPMR */
+        if (cpu_isar_feature(aa64_fpmr, cpu)) {
+            env->cp15.sctlr_el[1] |= SCTLR_EnFPM;
+        }
         /* For Linux, GCSPR_EL0 is always readable. */
         if (cpu_isar_feature(aa64_gcs, cpu)) {
             env->cp15.gcscr_el[0] = GCSCRE0_NTR;
-- 
2.43.0


