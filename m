Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0B15C87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 23:34:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhzC6-0004L3-2a; Fri, 01 Aug 2025 19:29:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhz8y-0007ZU-Tr
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 19:26:33 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhz8t-0005yl-Rv
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 19:26:32 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-b391ca6146eso2167134a12.3
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 16:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754090786; x=1754695586; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N7GETELPD3VGF6/REM63Q115JGqnxMS395y7OJ9SbQ4=;
 b=UtbeL64Q4oEwONbZrVuq/W3RUvdtptWnpoxfcocB/uWZ0nH7eeFWEf42whHT0eDZvx
 PMpAZ7FLjQV8evWj1MNYLAHkJOiYCQf9AiQG2zd0YUt+K2SIcQlgR4dgyDYNzGSY+f+X
 K9sVorIkMcLhK0oN+wLur9Yx19FGdx1KFq3kgNcTUALyDppvFHO4UVwZmaQqYSqpK43I
 qRuv8x1jv1djMz0WJLrK6NPhMp8rIPzV9QFBRoyHyVSVATD6mjA9DdTcLkp29Uat0p40
 Y3t58In4CLoF9042gBVQEz+lSfCVF+N3JtWZIcY7db7j2G8CDxQYnj8hA0ciLFPC5biL
 ZMrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754090786; x=1754695586;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N7GETELPD3VGF6/REM63Q115JGqnxMS395y7OJ9SbQ4=;
 b=id8rwB1cv5cdyCjj06A/UWc1QuoMe/cCwHeZ5UBH1a9oDaSAHyynaSMR2OblPmhYcU
 NkK+gtLfdx2gHGHnmg/N7PQVcnfFi9r3qzGf/r2PSpY8hsemw7vz/DO8lSPCm0kvw2S2
 o8R2K+gfqNJ/V39vjtqIFhCdXO0xCSoPddJTPfP1Lep+Naq74mZtxpkWmICity77mSDM
 hsN7d5uOTHQqPxYElv8yP9QZciz6qQLa2szrsVjkFzCCzSh7dm6nPYnHAbisPpq/Tc4N
 zFVcwBKUG+OMkOwGy7VSrshXthFJxQC++1q9kb5IJ0tIHnH8BkUZMZ3H0w0OFZBszI4z
 5HpA==
X-Gm-Message-State: AOJu0Yyp0A0cvU89RkWu5OjOm4HCYB1XkBAFv/CqTy7DEXOy0RxGLHsN
 dyl9Los4o7x7nRIFoJW9mfzZbTSIBZlpz6lfPjtEameV42lpB2VBVXPJIPGvPkAYomsQvrJInL9
 9D5epYNk=
X-Gm-Gg: ASbGncsIK+8If7Jt/7h9WZ85mAcjQQGSqmpvmGjYhPSHR3yqd97ulqwq5+u79VBUDzN
 pIiE0LQzroUUKlTpGB/DAFIzFTXFBq0M9993S0lSMaUxwldzo4KS9jJpFKH2Lnzo2LcL438q5AN
 XGmBC8pl2G6TfWP+d3y7hJ+XcqPW5xGBx3YFOdRntq/7p+0uu/qb1ZI2TMK5bTamkHJGshhzwEK
 m/vo0duqdRPP4YDTib5qvO8hdN7vRtDzpPHy3dkDW9H0K++auLqrEXQ4v9+Y1lDBew5xtsIWORF
 ESTJFO4F0xkSsGs2t2Xo/M318GXJecnWtgl4gG8kGVAjFe3zzKRD2pO91z3aMRg1N02PkWtv08F
 WJthgTBbalTdiny6WGV2eW/PfsnBqX9Gy
X-Google-Smtp-Source: AGHT+IH2af2WInt5f2Qq+AzuMxiJX5IfdBZc7F36cB9L/iI/rwfU7tZ/q2Wk1+nFJgN4BKGnIZSH2g==
X-Received: by 2002:a17:90b:390f:b0:313:176b:3d4b with SMTP id
 98e67ed59e1d1-321162c8d4cmr1720581a91.22.1754090786452; 
 Fri, 01 Aug 2025 16:26:26 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3207eca6d3asm5628217a91.23.2025.08.01.16.26.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Aug 2025 16:26:26 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, richard.henderson@linaro.org,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Weiwei Li <liwei1518@gmail.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, philmd@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 11/11] semihosting/arm-compat-semi: compile once in system
 and per target for user mode
Date: Fri,  1 Aug 2025 16:26:09 -0700
Message-ID: <20250801232609.2744557-12-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250801232609.2744557-1-pierrick.bouvier@linaro.org>
References: <20250801232609.2744557-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x534.google.com
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

We don't have any target dependency left in system mode, so we can
compile once.

User mode depends on qemu.h, which is duplicated between linux and bsd,
so we can't easily compile it once.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 semihosting/meson.build | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/semihosting/meson.build b/semihosting/meson.build
index bb0db323937..99f10e2e2bb 100644
--- a/semihosting/meson.build
+++ b/semihosting/meson.build
@@ -12,9 +12,10 @@ system_ss.add(when: 'CONFIG_SEMIHOSTING', if_true: files(
   'stubs-system.c',
 ))
 system_ss.add(when: 'CONFIG_ARM_COMPATIBLE_SEMIHOSTING',
+  if_true: files('arm-compat-semi.c'),
   if_false: files('arm-compat-semi-stub.c'))
 
 specific_ss.add(when: ['CONFIG_SEMIHOSTING', 'CONFIG_USER_ONLY'],
                 if_true: files('syscalls.c'))
-specific_ss.add(when: ['CONFIG_ARM_COMPATIBLE_SEMIHOSTING'],
+specific_ss.add(when: ['CONFIG_ARM_COMPATIBLE_SEMIHOSTING', 'CONFIG_USER_ONLY'],
 		if_true: files('arm-compat-semi.c'))
-- 
2.47.2


