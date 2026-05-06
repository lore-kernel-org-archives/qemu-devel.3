Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 065A8CD3447
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 14:09:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKcvO-0002iN-So; Wed, 06 May 2026 10:08:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcv3-0002Br-JK
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:08:09 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcv1-000237-TT
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:08:09 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-449d6c68ed8so5006473f8f.0
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 07:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778076485; x=1778681285; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wbr7TSm9rrQFY/Tg9TLQeycsBQGCDHg2nKtliBN7mQk=;
 b=llABpTZ0oA0ej3mn5NltxzV+8/IXyryGAJt1Js5Z8NxV6jukwkxnOGQMQu8OGA2XN7
 mC+sTYBarnJoDr2npRHkbxaqNfIIpp4JFIFM9HDD6uUsV44j0kcsOWHdE8p5TmVVuHzN
 WTVtCXPfJdm7XFExFeSJCtMS4GdktvTOz0qdl8Nf6TYI7zl4gVM9H0M7x/632PxG1qYu
 XiErv2vSu9Z2PED+vQFf5LSKqnTIHES5UaqVpYZW0u5/itoCEjLm7EHUO3hDVRvxzdpt
 1g+sqxN7eCKWmFOJCvch21xrl7uMFl4AJHpo0wEwZqzc6i5DjRJNtmAY3XcvNEU8Vptz
 gMyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778076485; x=1778681285;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=wbr7TSm9rrQFY/Tg9TLQeycsBQGCDHg2nKtliBN7mQk=;
 b=M7Bu8FSpWc+PS1Irk/1YRNSSNVcZMP11rRynTonV7SRV+mBdtIoUONe1CCGzdQb0M2
 D8a/Pslw6faedGYY5snOoMhyHB5UVA972J8+CCc19Fa9P1tMQ3qPTnEYW7YqWxMKwLtI
 NflrmYj0pmZTCcV8nOdPngHQ1AaJ1VnPcyP1gOACofcqVuxXvGIf8yXeadthCMtPU40L
 FA4fys7GzMjLlQn9mvdC3psyBCCw6soFGH/ZSUfRVqng6WHamNdHBXYvDYAM25FJ58q8
 qJ6rHFp+vwY+23gEYiP8ioHnX5GvdGm1l63vhHSTmqw+DbYyCcuDm5WRkaZ6OshocrCV
 U13A==
X-Gm-Message-State: AOJu0Yx45N6V2czYisBwY4e56bwyw6nTm4XPtRFoAIQl31jcYkX+r2tN
 tx8GTXaT/gCmD2iDXmfhwyx6rdr0PeIpFExOgrXwHXT6dotiGoRWpQmIufS4/vwqrTjoN3KfGpk
 TDIc8Edk=
X-Gm-Gg: AeBDietONGO9C8VzJ+PR8vbIhyichjU6duNFOztITGdDY3CrHqUKaXwAHsqDABHj9Ak
 HvQVKFQcqhG4eDE6ghvZIyv4lD90dOq2M2G+JYyx22mL6k4HLg19tXujzTC8fdE4h8EAfKdAkfR
 puBMziUUZWssL05z87berJUssiohpWsPjqBTis545AeKR4je53tMiL3xts66v1BxuGK82Y174dH
 9+2hqZfl3S1pB0j/hfl90x9fVEMPCrveq0JAdC+BA9Ogiw1Si/NKqt0h7a+3fCXGXnJmLGniWFH
 wte1DDQlGJj87C4Oa6G9egejyyUI8KE9PTZszqOguIDQm+IAYDG4rMU+CN85BQwdUY22hgvKSRw
 hwcak3B6wrc3aMrLF7uezBFManSC5vzBjPGh0v/o9vV3L5OCeVr2UncgyKx+a9nQPySIUssKPPL
 Pgjua7iMWQS85WVHlYdB4j28fvhSQQkxQWkmJ/JTBTIp4qYSBX5S0bH/y60lEpdWNjjhfrm0ubw
 Rel2q0FjhU=
X-Received: by 2002:a05:6000:2386:b0:44f:f2d5:a401 with SMTP id
 ffacd0b85a97d-4515d99f5f9mr6028020f8f.37.1778076485013; 
 Wed, 06 May 2026 07:08:05 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45055960aa2sm12349586f8f.29.2026.05.06.07.08.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 May 2026 07:08:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 096/110] target/riscv: Iterate vCPUs using CPU_FOREACH() macro
Date: Wed,  6 May 2026 15:55:08 +0200
Message-ID: <20260506135524.20617-97-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506135524.20617-1-philmd@linaro.org>
References: <20260506135524.20617-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

Most code iterates over vCPUs using the CPU_FOREACH()
macro. Prefer cpu_env(cpu) over &cpu->env.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-Id: <20260415215539.92629-9-philmd@linaro.org>
---
 hw/riscv/boot.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
index 9086793b7a7..ae2f86c7ceb 100644
--- a/hw/riscv/boot.c
+++ b/hw/riscv/boot.c
@@ -505,10 +505,11 @@ void riscv_setup_direct_kernel(hwaddr kernel_addr, hwaddr fdt_addr)
 {
     CPUState *cs;
 
-    for (cs = first_cpu; cs; cs = CPU_NEXT(cs)) {
-        RISCVCPU *riscv_cpu = RISCV_CPU(cs);
-        riscv_cpu->env.kernel_addr = kernel_addr;
-        riscv_cpu->env.fdt_addr = fdt_addr;
+    CPU_FOREACH(cs) {
+        CPURISCVState *env = cpu_env(cs);
+
+        env->kernel_addr = kernel_addr;
+        env->fdt_addr = fdt_addr;
     }
 }
 
-- 
2.53.0


