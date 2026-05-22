Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC8ACCD5BB3
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 22:11:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQXz3-0000eh-2x; Fri, 22 May 2026 18:04:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQXxq-0007kf-MY
 for qemu-devel@nongnu.org; Fri, 22 May 2026 18:03:36 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQXxl-0008Ds-VX
 for qemu-devel@nongnu.org; Fri, 22 May 2026 18:03:29 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-3698e34a567so6988158a91.2
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 15:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779487404; x=1780092204; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eX9nT6P6ieYs1JPdLRJX+B2w+q8WWuzFbgrsBLUu95o=;
 b=M5/fxxyRbGkepskaeAjAMmLKnHINrNTelLH0SPLez83EPyockyTkLJpr+2U3ILOt6Q
 iVX/ajBblg3uSvTBnKoDjMuXyGaiummgZSnrwxlQOH0AsLF9SKz0smM78hMF+NHYjEyB
 GQBAWmPIfSqZ3CnckfeL+jgiPyUQZFMpYIKew2bcxT9fHmg/aH6riUiOhZtDJmxOuMoB
 pVSFDUNqFoAnMWkqdmiHh4QEwd+scO9GCUpNgHdxc5bIYNNaRt/Qjn33nGhEthuf5m6x
 sqM/wWtoxJfY6sX/rtdERzM+7/msN4fzqOc6PP+eWCAwYUJ4MZSs3sqT1gakEPnUSp6D
 ohgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779487404; x=1780092204;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eX9nT6P6ieYs1JPdLRJX+B2w+q8WWuzFbgrsBLUu95o=;
 b=qhdliMsBMppI4j7Oy04psOi+hw4Q8yMVe/vtGb4ezoilHtTmyPhfPdSbMOi9ZRTZ+W
 FkZyAxN581rQtZISda7Ik8r/OXR84e3YINyEJA8OD3aJb+zEpttStGHC+jFuOuOMH/B8
 iYcR9rSu1w1CpA6wThoD5MbxquueOiJ2siGzOp+6QSIktGKjqs5M7NVW5lFThvUjxU6K
 FyXfoBUJT0dYgyXydzLUqscySVALVjUnybFHMrl6E1u3eVFH5oVHORM9xSN6Jv4JburR
 Ai4P2w4CQh04GiYxtm6au4JcU/yo8GddSZ1YHP28Se3gNnn1oCUQ6o2x2YAWqWP7Dksk
 XW7A==
X-Gm-Message-State: AOJu0Yz89URGLpdrsTLrChO6AAt4NxPm48hEsX3PEEEuHdAiCgazMFAN
 AXvqnO/R0MrMQqG4gpKCkaj1p3roOIVuw65BZpk3vFv9IV4hx4+vhz+szeUW8PxUJcDywG3rg3m
 xtcOA
X-Gm-Gg: Acq92OHN1CbthpKIsOzElZ6xcTqpRjR3xc/aPyudnze8GVv9801L5FvyGf2IBfymFGB
 tRmzI5qr1DQtD5gTnKnkvtHziaA7cLLfYufTwvAjcdcQtQfDb6r4kzG1EHUuuRU0Hg9G5oE8OIP
 0U3WXhBzkoegq9FfLNIcCxjA792dU8Jr713DFxmawK2ReN8hFNDhKhjzc6maS6LmRf4Rc2YeVUQ
 zCeKZ6zUjC7fkMwQ3wdR6+fuoJRZ9ikSnTU42WnXh57/O0kcnm+JxjujhFpHoIXZT4IO97gtcj+
 AATL5fvGjx/B4XWQWxQWyYGTWfFLexlhNogaa+zkV6OMeQPFYYb9Kl64MfRDvv6ccIJzsk9WWbu
 qUS78DIJgcndNapUHsqdA1lhQJjI0wrCvpeX1Hm5uY53LcLcBWhO7A1m3B7DZp9EYU6JmYiBLiq
 8UZRpcFhI35YPOigkKZ2M8lKEiCmnc6vgWaMFsMX5gcGowvtWWrA==
X-Received: by 2002:a17:90b:564f:b0:368:ed92:6f3 with SMTP id
 98e67ed59e1d1-36a677ce506mr4642084a91.18.1779487403930; 
 Fri, 22 May 2026 15:03:23 -0700 (PDT)
Received: from stoup.. ([50.78.183.177]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a6772f486sm1726789a91.2.2026.05.22.15.03.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 15:03:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v7 15/64] target/arm: Dump FPMR when present
Date: Fri, 22 May 2026 15:02:17 -0700
Message-ID: <20260522220306.235200-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260522220306.235200-1-richard.henderson@linaro.org>
References: <20260522220306.235200-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 84b2cc70e2..facd4def38 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -972,8 +972,12 @@ static void aarch64_cpu_dump_state(CPUState *cs, FILE *f, int flags)
         qemu_fprintf(f, "    FPU disabled\n");
         return;
     }
-    qemu_fprintf(f, "     FPCR=%08x FPSR=%08x\n",
+    qemu_fprintf(f, "     FPCR=%08x FPSR=%08x",
                  vfp_get_fpcr(env), vfp_get_fpsr(env));
+    if (cpu_isar_feature(aa64_fpmr, cpu)) {
+        qemu_fprintf(f, " FPMR=0x%" PRIx64, env->vfp.fpmr);
+    }
+    qemu_fprintf(f, "\n");
 
     if (cpu_isar_feature(aa64_sme, cpu) && FIELD_EX64(env->svcr, SVCR, SM)) {
         sve = sme_exception_el(env, el) == 0;
-- 
2.43.0


