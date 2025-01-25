Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95212C02190
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2025 16:13:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbigI-0004SW-JL; Sat, 25 Jan 2025 11:06:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbigA-0004Q5-B1
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 11:06:40 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbig8-0000k1-TM
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 11:06:38 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-38a8b17d7a7so1539699f8f.2
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2025 08:06:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737821195; x=1738425995; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QmGm+j3d/J7g6/EQrq3KxGWM+Wnw1Wpe1ViwwNVT0iA=;
 b=UHbN2tToduDTkJcJ0D4GLXiIYvPDcyYJESrXCYOD/jjBj5w6cxXbr0glx0Itn3tXFC
 TveVLUIbKq/lHuX5/DS799i1fYK+FJY6evoJqXkMeAHN71NmcLxV3xpKUNsF7z5p3Ftq
 waYNsWwSE+M0prF9+uc7Sji5xgNdY+GF2P2zhu5QGexFUpt9V6ZvueBCRHepbGRXcJK5
 7/Uqsvq35+2sGxAalJ2xZ4l8HV6D8ktHNWXQu+ptCKvKtnA4mt2+NDIvGbaOTkLhskzW
 Cg0Im2DEsQ3yGCrZ3Vgd0HZDY1FotV48KQesbEeST7gK+UPNtiUbfYfLj+JEDb4RVjJ/
 adZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737821195; x=1738425995;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QmGm+j3d/J7g6/EQrq3KxGWM+Wnw1Wpe1ViwwNVT0iA=;
 b=NL4+dHO515kO8JduD4XicN3lCwnnsoEG3xUx4HFye/YgPwrUO1pHt+GjavAHw5OeNA
 NraXJFTfZd/4PJXLt/CCF92zxFSX4A4ZVWUfboAMt+cAXLrqPqHcsdF/hAXq3NViKztG
 /bA7EEbvWWk3fvDCByMiyZpVc6VIYcjUjCN0GR89XKZJpQ/q1ar/WxpXoU5IuTbwlCJx
 uMWS1ZFRct/Rvn5etgMsOiDxD4+QHNa1DJTL4zFANlk+9XN6nzYX8vFVyoDufItGectK
 enjQZpm0EEC8J0b8/GndJj0pb9lQX6eIeQ7rkp68c+5kYrSaBPpH2PfJgMOv42gNI98s
 cdmQ==
X-Gm-Message-State: AOJu0Yz5Qm4gDbaTWb+L0eMGmAeJxXAv4uOJQfp0V7nzDgqrUjxus1EP
 It08Apot+S/VlR02SHXgqLZuYhWf6N4EOjelDyCk4YL0gOgJw4JEA5oE4mSwFykAZL0dCbTxINO
 BQu4=
X-Gm-Gg: ASbGncsXKOZwzWmZzX8nhTCe4hmVJbN6ArdKPu+tkwI6f+djaBIZ6kTiqC/HIU+5ifO
 fJU5b4a3TnIA6G6TDKdHUNo03W7TvP5F8gZj4wGRTMcqCU7l80usuYfBm5qPkFh2ReYi5ABBwaj
 ocx05gTHQdWeKFvcHH6PutKD0RokjX44ZiDMHsaEVwy7wEsvKqDa4rICcEln/nOIro3Ywf3rCr9
 goo9WroSBDf5J+5l3CwqfYuop0/jQFxBqf7KqrYF5lNdD1bX6eScG8lbfgJGgO/llmnurbxdS5h
 cCu09X947D+s/YAfvTdwV1VeD1kqb3Z3WTzDUEL37QaT1RjOLyU4vdJqnrtn
X-Google-Smtp-Source: AGHT+IGhdlxDeSmJOdRt6MxTG8DF3rfQ1qXPLO1zYM1CtgyARcPlkdWxQrfw20sij04veFVv7ZZAMA==
X-Received: by 2002:a5d:47c9:0:b0:386:3e48:f732 with SMTP id
 ffacd0b85a97d-38bf5662a1amr34862909f8f.16.1737821195065; 
 Sat, 25 Jan 2025 08:06:35 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a1bb04csm5949053f8f.73.2025.01.25.08.06.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 25 Jan 2025 08:06:34 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 08/24] target/hppa: Move has_work() from CPUClass to
 SysemuCPUOps
Date: Sat, 25 Jan 2025 17:05:36 +0100
Message-ID: <20250125160552.20546-9-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250125160552.20546-1-philmd@linaro.org>
References: <20250125160552.20546-1-philmd@linaro.org>
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
 target/hppa/cpu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index b0bc9d35e4c..d5a58a03cbb 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -125,10 +125,12 @@ static void hppa_restore_state_to_opc(CPUState *cs,
     env->psw_n = 0;
 }
 
+#ifndef CONFIG_USER_ONLY
 static bool hppa_cpu_has_work(CPUState *cs)
 {
     return cs->interrupt_request & (CPU_INTERRUPT_HARD | CPU_INTERRUPT_NMI);
 }
+#endif /* !CONFIG_USER_ONLY */
 
 static int hppa_cpu_mmu_index(CPUState *cs, bool ifetch)
 {
@@ -231,6 +233,7 @@ static ObjectClass *hppa_cpu_class_by_name(const char *cpu_model)
 #include "hw/core/sysemu-cpu-ops.h"
 
 static const struct SysemuCPUOps hppa_sysemu_ops = {
+    .has_work = hppa_cpu_has_work,
     .get_phys_page_debug = hppa_cpu_get_phys_page_debug,
 };
 #endif
@@ -267,7 +270,6 @@ static void hppa_cpu_class_init(ObjectClass *oc, void *data)
                                        &acc->parent_phases);
 
     cc->class_by_name = hppa_cpu_class_by_name;
-    cc->has_work = hppa_cpu_has_work;
     cc->mmu_index = hppa_cpu_mmu_index;
     cc->dump_state = hppa_cpu_dump_state;
     cc->set_pc = hppa_cpu_set_pc;
-- 
2.47.1


