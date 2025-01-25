Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C433C0218D
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2025 17:04:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbja0-00025j-Gj; Sat, 25 Jan 2025 12:04:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbjYr-0000gg-S6
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 12:03:13 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbjYq-0000bi-Ft
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 12:03:09 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4363ae65100so33566465e9.0
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2025 09:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737824587; x=1738429387; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vwxPouX1MPfj+qZCG+Ip7+cwlRNTkTH48zQoUyHbOFI=;
 b=KDEzypIcXrdoCIYcpCPP6yYxhl1MT7p9KxqvgOsHpzd9eJG4njXzq5VidXys2KL6Yq
 EooTy+pmkOd7OCDDBVQmhnpIF8o4hRG1iTH8X2fJxm4e5TDR+kOUWF/sKjWLl5lBtqYn
 aIqMiVifgOt45viUePBzs0yEYF1dE/WAvmlbZ979yZG9JOpgATwthgo8enkk8od9JYrM
 6PJjFMHUoAF5w9x+GAsV7CvCx7bWHZkI/EsaVlTGnTk5rSFwulKfkAlPh7uELQGH2XeJ
 jyztagl7X5jO7ghFbheUECdut6QvfZIWCcZ5LBgws29kEM/f/9ADw/cPaVQUyMeEW35L
 XdOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737824587; x=1738429387;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vwxPouX1MPfj+qZCG+Ip7+cwlRNTkTH48zQoUyHbOFI=;
 b=wJtrFsQPk41MHn0sfMHIOSplgbZilp2u5DYVZXsJl0A4D9beVAR6JTR/AsuSfgVLn7
 ZQ++CewR4lGQVT53e6iRTZgOxDGe58do5AwWTqZMFgh9fZmM2PNz9LE5Az62BWijzU8i
 wJ4p1/lDTSuZeuvNVckiQ3HvxTm300ZfDWbBznHCy4LJJX5j+pRVaT3qzFrTU5tpBR/8
 o727OH2gHmavIVRVtdOOOtro9oIpGQF8fr3ta9PFLC+ldMGjkpd/cAqduB2lcLPRCPy3
 y6wpY73K2+OXULQgDmgNu3gPiX6gf4niDRgm9ZRswpu3kFMsUX76xybrHS9ewMmoXjFB
 4L9Q==
X-Gm-Message-State: AOJu0YyBmb3LELvnUjTLpSo3rLocrZK8cKSqzIFlDV4ffmYpHl0Rqs/d
 G9KbPknBzX1UHAi/YgE4s6PalLUqmFExh852n04IKgQC8qVEKQ91Qb1xxkyVfLAA9MPJIvzuNCe
 J+pw=
X-Gm-Gg: ASbGncu5Dm6s3//Pjgtr9lHXZkuVYPlQLWe8AkofkBcu8R97fktuEWcOX0Zm1MhLiEq
 OJnwaN1VsTJsWCk5Fs3fyz1DpO2c6oKOEQN62oujxJyotyOPnp2BnkAdjUMb2aS/R1fz3HUXGHF
 zT0HdRMJoX6jVGrg4OLCWmBzC1XKtKycKk+LEaJSrXsVjog3xI3wvBkvGQB5LlderHILYY4KV6V
 wB7MzOx13SpbPgeT/HKUumJv21/g38lnfxqxHpxb3lvATj5DbjsJfx2AWRrlT+sv0AVSnLCcnDX
 /31mlvoVO6ebEtudCBKwJ74V/56vHBH2Ol4s79/3/vZ7iZEel4FOisI=
X-Google-Smtp-Source: AGHT+IHFBz6zGckxsY2quSxGcS6859Z+cQ6pBzEFu5wft7n93wdqwbHJFtGsb9cyytYxfM4MbE2y0g==
X-Received: by 2002:a05:600c:8712:b0:434:a802:e9a6 with SMTP id
 5b1f17b1804b1-438913ce0b7mr350273185e9.7.1737824586746; 
 Sat, 25 Jan 2025 09:03:06 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd507dc9sm67320765e9.19.2025.01.25.09.03.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 25 Jan 2025 09:03:05 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 20/24] target/sh4: Move has_work() from CPUClass to
 SysemuCPUOps
Date: Sat, 25 Jan 2025 18:01:21 +0100
Message-ID: <20250125170125.32855-21-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250125170125.32855-1-philmd@linaro.org>
References: <20250125170125.32855-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sh4/cpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
index 24a22724c61..80a66e1f1d6 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -82,12 +82,12 @@ static bool superh_io_recompile_replay_branch(CPUState *cs,
     }
     return false;
 }
-#endif
 
 static bool superh_cpu_has_work(CPUState *cs)
 {
     return cs->interrupt_request & CPU_INTERRUPT_HARD;
 }
+#endif /* !CONFIG_USER_ONLY */
 
 static int sh4_cpu_mmu_index(CPUState *cs, bool ifetch)
 {
@@ -243,6 +243,7 @@ static const VMStateDescription vmstate_sh_cpu = {
 #include "hw/core/sysemu-cpu-ops.h"
 
 static const struct SysemuCPUOps sh4_sysemu_ops = {
+    .has_work = superh_cpu_has_work,
     .get_phys_page_debug = superh_cpu_get_phys_page_debug,
 };
 #endif
@@ -279,7 +280,6 @@ static void superh_cpu_class_init(ObjectClass *oc, void *data)
                                        &scc->parent_phases);
 
     cc->class_by_name = superh_cpu_class_by_name;
-    cc->has_work = superh_cpu_has_work;
     cc->mmu_index = sh4_cpu_mmu_index;
     cc->dump_state = superh_cpu_dump_state;
     cc->set_pc = superh_cpu_set_pc;
-- 
2.47.1


