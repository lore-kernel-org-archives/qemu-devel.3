Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 177B6C0218D
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2025 16:07:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbigN-0004fm-P0; Sat, 25 Jan 2025 11:06:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbigJ-0004UQ-Ht
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 11:06:49 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbigI-0000l3-3L
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 11:06:47 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-436ce2ab251so19732115e9.1
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2025 08:06:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737821204; x=1738426004; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=srYqpBi+i1JHdcQoMXjqQayhwRKKfnrZUrD1yEs/h/w=;
 b=RBW5FcgW4VuHVfxx2aldE3jDYLYgjLtGzSURw3WzaOJ+eWgyFDscuX0hTdX5xlSpvx
 zVUbL35L0fCu/7DbddAG0QUmPoZGgDXR/Ddw1d76Gzj3LrfNraT00BiC/oiG9PzSd0jW
 LuWtPi83GPblKgzvGuaXRmieRB/kNmfvqLi1rDfaznxmWHPP5H4ug6snDxHBwxZ32GUN
 EMvHDR3V/ozwhV9rq1Fq9FuV2DFDE7kr0jRLAQT+MJgBnv9MmmWTmNt1IXyvpDjyPYGJ
 HC2BaRdWeyihaWXjOU2IdgUQP2k5+r9OCDxf3HoebxjzQC4qJW9fwyN+D4a+1GWtjOXF
 4GBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737821204; x=1738426004;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=srYqpBi+i1JHdcQoMXjqQayhwRKKfnrZUrD1yEs/h/w=;
 b=Z5X6Ky7o5KotnesYb16wWMWoxN75Kx1dHWIdZ0ytsc9a6KCouUH5kMajlF6y0xVosc
 k5f482nJolX7sBu8C87lbmJnJEES5K/jkUM2AV86hfoRANyUh7vnVl+GKFIe/S962/o0
 iTWFqD2oCL0jxKhpgeFZO4+4ieqXJJ8gRwG3V0XvtfZ3QHAkiTZNHBMQABBd86ausHHm
 3EDPuMNktGbV/oWXfOjhR4E1lDbFQGAitqLY3mM3Ywl8BSzI8F/+iDkh5xuR5j00Fypp
 /R7/jcu0K0vyl+0tpC6bK7XGc2CAK+8ucJ/t2pZVa1kGHueeCnazECGrNLhF+KJJBSfi
 0Rqg==
X-Gm-Message-State: AOJu0YxPS3hLE5E95ZlWXSlMORK9jXS9B8s5ZZyvBFG4TGJvSIzQcHTt
 /nbQeE4tF4mbr50KNPQ/xvf/kP6LQqg6EF1f+zyarZiXMZDsN5vEXffTUoOVJmaHDDtuk+/lEKB
 gC88=
X-Gm-Gg: ASbGncsFR27Kj/FiO2YUAG9hp7+Zo1Sio2wrqQFUrIlRgm4VERckYO6W8/mc9sgsI3F
 Mcz2SEf4NEHWxWbCxP3LFheFPJQW4tw301o5TGaOdJzrO4JP/PLbBs6NUa8GyM85AWMTdthOugX
 yRyuUyUhgeh6/dRn5TRXtg0GyL2XFyT+1grHA+p43pAI5C4uEAdYd2ucxX6JSZ10HFjk9tmfVLX
 AlSxRvi0um9vuUi/OtDh3SFTiKWOj341nk6fqe069oQX2iDhfwgf6upqz5TFp0GmLHo+DEbYs7e
 ZF4oI+bO3TDg0O6DhMq6pLUlgkZctTpYXlRpbbmaRiLXUvKRYoiFRxvxK8LO
X-Google-Smtp-Source: AGHT+IEWu2i+YTLFqeAb4LRThmyQu41nXXGb1bDpdviB9wmM9QVgvklg2o1ID5kzpelR00ORWj2XiQ==
X-Received: by 2002:a05:600c:4e07:b0:434:a802:e99a with SMTP id
 5b1f17b1804b1-438913bec32mr310554025e9.4.1737821204358; 
 Sat, 25 Jan 2025 08:06:44 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd4fa3efsm66192825e9.2.2025.01.25.08.06.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 25 Jan 2025 08:06:43 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 10/24] target/loongarch: Move has_work() from CPUClass to
 SysemuCPUOps
Date: Sat, 25 Jan 2025 17:05:38 +0100
Message-ID: <20250125160552.20546-11-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250125160552.20546-1-philmd@linaro.org>
References: <20250125160552.20546-1-philmd@linaro.org>
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
 target/loongarch/cpu.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index d611a604704..20aba0e1fff 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -349,11 +349,9 @@ static void loongarch_restore_state_to_opc(CPUState *cs,
 }
 #endif /* CONFIG_TCG */
 
+#ifndef CONFIG_USER_ONLY
 static bool loongarch_cpu_has_work(CPUState *cs)
 {
-#ifdef CONFIG_USER_ONLY
-    return true;
-#else
     bool has_work = false;
 
     if ((cs->interrupt_request & CPU_INTERRUPT_HARD) &&
@@ -362,8 +360,8 @@ static bool loongarch_cpu_has_work(CPUState *cs)
     }
 
     return has_work;
-#endif
 }
+#endif /* !CONFIG_USER_ONLY */
 
 static int loongarch_cpu_mmu_index(CPUState *cs, bool ifetch)
 {
@@ -835,6 +833,7 @@ static const TCGCPUOps loongarch_tcg_ops = {
 #include "hw/core/sysemu-cpu-ops.h"
 
 static const struct SysemuCPUOps loongarch_sysemu_ops = {
+    .has_work = loongarch_cpu_has_work,
     .write_elf64_note = loongarch_cpu_write_elf64_note,
     .get_phys_page_debug = loongarch_cpu_get_phys_page_debug,
 };
@@ -860,7 +859,6 @@ static void loongarch_cpu_class_init(ObjectClass *c, void *data)
                                        &lacc->parent_phases);
 
     cc->class_by_name = loongarch_cpu_class_by_name;
-    cc->has_work = loongarch_cpu_has_work;
     cc->mmu_index = loongarch_cpu_mmu_index;
     cc->dump_state = loongarch_cpu_dump_state;
     cc->set_pc = loongarch_cpu_set_pc;
-- 
2.47.1


