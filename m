Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7479BFD8FC3
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 15:58:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvdiV-0005OQ-7N; Thu, 26 Feb 2026 10:55:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vvdiQ-0005MW-2T
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 10:55:50 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vvdiO-0003lD-Dv
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 10:55:49 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-439857ec679so900151f8f.2
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 07:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772121347; x=1772726147; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=72QGaHRSSUmNZ4fPR2Rby3J+3BzAqdEiwb7T+/2jw7g=;
 b=AAhpa6igk64L/lkF0NLVBYoBABU3dAYuwnLJjBNjXcABovVlAdZwZzQSkpZL+Wbf0/
 7OAuZQ2WyER/ekDk+bcy+WEDOAR4eJbskyv2ITJUPYU+mfThGbtcxs2DRD2oQJYr/tAP
 b0bnBV5nBxJf3LH80b7yoxFOAHOu7jdD0VV3EHIC5yw70P0qYGAoBmM9Vx2my68kdINn
 5mq18XY0NlVi7X3VDdFnhrrLmJfAwmY1Z0sCcPJppQmDK4uzw4OCk9WIr0PWSweNEzI4
 jyHy9xK4pjiqa5k39ut/pLEFrT8QRCVBQe+Wk5Ak66b+FC1qDfxGktJ0dxX6MHbVc81u
 uHRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772121347; x=1772726147;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=72QGaHRSSUmNZ4fPR2Rby3J+3BzAqdEiwb7T+/2jw7g=;
 b=URmOmru49owkmBKSNZBnbyO3eWnV3QuHeHhOTKJyN2wOCrB/joodcs6J1dfIWz0ebq
 gtj71vXIxdC1OTmdTTB7wbcUnB4MF7x+d+jkPMdtuCQdPsZVubA2zHYcLLbp5YGYDDji
 4QdztVmlYTZa3fq+9Pq0KaHr/0zJcCMZt/SiO+2WsNVTZHPUzvQoIC3tinLaPGfsBZWc
 T/NFSc+jrRjpOlYIPCD+X1oD0LzuWMuwtu64rvry45qVk65oM9EvF9PHSSIJRNXY+Caz
 0MajagWuLiKS3KZDmUZW+BX6mCHlVN9DCbqj31s2r/QN4HiCRvo/h7avcD2cfAK3eMTD
 O9/w==
X-Gm-Message-State: AOJu0YxhDNhrGHfRxul9yQCp45DGKsz2bjZpmK20EQhQFPpWMeuHIbHX
 BveVWfV/QdVKXspFO0VbITuUmY1eLP3QAUiUQ1WHuObHvDnPh7Su8BwrWjPIjhXAChDsocYspRN
 Az2Op
X-Gm-Gg: ATEYQzxjbYR6aKvVS2hv5VcmkDwZQ7+5njLSJKYJu5pbIjAwRcb7FtWVJywOK8Y0b0W
 YBvqOGyZ7wL7V5fiWwYkz0gvgYzINCow/3KSkXrZcnZ5o0VIHmsto2edu32xWxuljM/ypmLGcIH
 6JkOjRTQ9cR+LweAQConjOPPQN8YuN+YskbITd90xTA6N5QjrX2UP7R1Cqk9nQJKtnf+TAoznHm
 yxroH45FlBCZd80LaF8fi2ETk3hPBLeskgM+OskLTisLJnTyZOFMjDRaAkyoW1wsSDWxG+FHEBk
 gKkuU1xBM0hxIiaSeJ+8SJIxi1u9LlIJ6MIbfKQ1kLX2/CaczqzjXFfrbqdu5Kd+5PVYnPiFEpV
 2RSEh93AeAE8Zgju53pa7C09MK7IGGeF2HXO9bfia5D6iq6ifBET5dU25Zq/qnXxbxdFDnovYB5
 a885pqp0ODIuPkdwQIP7SsJg/lq1d0erGrhnso/AakgfCaA7SVoeZeBW5zFvh6K1H1cbEbAB2Ho
 e5QwEOTCuIvSFN7BNj/OXWbzsBbcBU=
X-Received: by 2002:a05:6000:1866:b0:439:8580:18e with SMTP id
 ffacd0b85a97d-439943083f6mr9034507f8f.55.1772121346761; 
 Thu, 26 Feb 2026 07:55:46 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4399c75b8afsm407235f8f.23.2026.02.26.07.55.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Feb 2026 07:55:46 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/20] hw/misc/allwinner-cpucfg: Remove use of ARM_CPU() cast
 macro
Date: Thu, 26 Feb 2026 15:55:24 +0000
Message-ID: <20260226155535.1171290-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260226155535.1171290-1-peter.maydell@linaro.org>
References: <20260226155535.1171290-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

allwinner_cpucfg_cpu_reset() doesn't access ARM CPU internal
fields: no need to cast, pass a generic CPU pointer along.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260225034720.41495-1-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/misc/allwinner-cpucfg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/misc/allwinner-cpucfg.c b/hw/misc/allwinner-cpucfg.c
index 3a1526bda0..f8dbfdd120 100644
--- a/hw/misc/allwinner-cpucfg.c
+++ b/hw/misc/allwinner-cpucfg.c
@@ -84,7 +84,7 @@ static void allwinner_cpucfg_cpu_reset(AwCpuCfgState *s, uint8_t cpu_id)
 
     trace_allwinner_cpucfg_cpu_reset(cpu_id, s->entry_addr);
 
-    ARMCPU *target_cpu = ARM_CPU(arm_get_cpu_by_id(cpu_id));
+    CPUState *target_cpu = arm_get_cpu_by_id(cpu_id);
     if (!target_cpu) {
         /*
          * Called with a bogus value for cpu_id. Guest error will
@@ -92,7 +92,7 @@ static void allwinner_cpucfg_cpu_reset(AwCpuCfgState *s, uint8_t cpu_id)
          */
         return;
     }
-    bool target_aa64 = arm_feature(&target_cpu->env, ARM_FEATURE_AARCH64);
+    bool target_aa64 = arm_feature(cpu_env(target_cpu), ARM_FEATURE_AARCH64);
 
     ret = arm_set_cpu_on(cpu_id, s->entry_addr, 0,
                          CPU_EXCEPTION_LEVEL_ON_RESET, target_aa64);
-- 
2.43.0


