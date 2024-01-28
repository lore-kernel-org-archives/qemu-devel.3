Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79931C47DDB
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jan 2024 04:44:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTx16-0005Zz-Lu; Sat, 27 Jan 2024 23:43:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTx10-0005D4-03
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 23:43:30 -0500
Received: from mail-qt1-x835.google.com ([2607:f8b0:4864:20::835])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTx0x-0004Ob-Rf
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 23:43:29 -0500
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-42a0454899dso24229941cf.0
 for <qemu-devel@nongnu.org>; Sat, 27 Jan 2024 20:43:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706417006; x=1707021806; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5ULlzw/hvzp5QtoX3ztN0B/xM0fq4zjWqatyCH6lWMo=;
 b=r+Ra5v12wupf5juue0xRouI7Ako/NiYuxO2wW8F/Jl2wHJvizX/8w6gdd931cp2TwI
 Lk4ecGtRGIot5whVgMpKYq6q5uO6B1BxbP6VmgmGb+yEsIeD81B23zHvjMpRW30UTrfE
 d93fzUK6C4udGfv5iSwwiFxKLLP714Rlh2xSo/PyySCzSGPceU/c+m/Q7QLZlum/2Tq2
 MA90fUEpNDoZRi0GyIzLOrwCM94gSdH02+YNhI5ZZmR0B4m949vnJtXKlsgjuTw2oKkT
 2YVo82j+URHnqYjL/inlyh015hV1oZS1NbjWXXpF3G+r4ykuzg2gV3NUogPehQnfr9fO
 LSUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706417006; x=1707021806;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5ULlzw/hvzp5QtoX3ztN0B/xM0fq4zjWqatyCH6lWMo=;
 b=hnnRT+U3W+y4AFgG2ptpeL8ZX0u3NtSeZQXJBH2tOWNmxnpFGIbCjTCMr0uVHi/sPq
 K9wEdqx3wo6+3SzblTEWX4x5cpG9IYtt43+28NK/GBhoUiEUaCUM4YeL+62mmtbsp9di
 RfR5y8pIDHZfTowxfnkqWdbgAgfUxrxx1F6hM499RNFQFAs47IFimiNPFJ2RuovFGwYt
 5pa9NCJi1DGoV9XpQAzkqLcxv2WisiHQLEMMSAuRJTUjOUm7ZCD3JpggONBxeIphuGeK
 srn29PrCY2vHk0JBmD5m1J2E2j+S9XjfRn4xKcU1iRcAhIc5BNJ/lecNmOJLm5WgoGiA
 u5bQ==
X-Gm-Message-State: AOJu0YwqfVLUASd0z8itLNtSckzIwM2hEqkUIfNUA3JFPCI9BlpCj8ov
 KzMuv1MNBWsTfkmuBr/FK8ASMR6H0DzweyxlC9VVFUU2gInYubikyEUnqD8wN2tpNmXzYGT+hgR
 jflUkbw==
X-Google-Smtp-Source: AGHT+IGiLIdW7bxqzyjBtVSc7uP8bt7l+pY24onM+Jm3/mkBSVFVAeWVhcKwAGngpd6ickTS9VI1HQ==
X-Received: by 2002:ac8:5896:0:b0:42a:8b64:4ea4 with SMTP id
 t22-20020ac85896000000b0042a8b644ea4mr3004250qta.47.1706417005880; 
 Sat, 27 Jan 2024 20:43:25 -0800 (PST)
Received: from stoup..
 (ppp121-45-131-89.bri-pow-que-bras31.tpg.internode.on.net. [121.45.131.89])
 by smtp.gmail.com with ESMTPSA id
 w24-20020a17090aaf9800b002906e09e1d1sm5631873pjq.18.2024.01.27.20.43.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Jan 2024 20:43:25 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 27/33] target/loongarch: Constify loongarch_tcg_ops
Date: Sun, 28 Jan 2024 14:42:07 +1000
Message-Id: <20240128044213.316480-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240128044213.316480-1-richard.henderson@linaro.org>
References: <20240128044213.316480-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::835;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x835.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/loongarch/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index d9ddab5b9a..d663d46b00 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -758,7 +758,7 @@ void loongarch_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 #ifdef CONFIG_TCG
 #include "hw/core/tcg-cpu-ops.h"
 
-static TCGCPUOps loongarch_tcg_ops = {
+static const TCGCPUOps loongarch_tcg_ops = {
     .initialize = loongarch_translate_init,
     .synchronize_from_tb = loongarch_cpu_synchronize_from_tb,
     .restore_state_to_opc = loongarch_restore_state_to_opc,
-- 
2.34.1


