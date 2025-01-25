Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1348C0218C
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2025 17:03:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbjYL-0007pm-EX; Sat, 25 Jan 2025 12:02:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbjYH-0007mD-Fr
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 12:02:33 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbjYF-0000Wj-V5
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 12:02:33 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43618283d48so21879285e9.1
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2025 09:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737824550; x=1738429350; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=McaXcSpNynHCA9tSKGj/1Op/r9CMceoElpHx5WUOIrU=;
 b=VCQwHzafaYDHpNHTUSNhEO/n12VvMKZC/l+XP9b0XJ6H+Y2CK56yctjgx9MqUph5Kx
 oHU48Xq9AVgS1oa3s0YM/tnKLgBrRaTAy0Uyq+63zwSH+prS+OFIaBqwEPgUcEHlXfyC
 8jPdKK8fcYhNv2oNQG4G5rOiezGHt/bHbbtnVK0utDG3rFXmXqUTEZcf66H7bEHvJbif
 mbLgeY2dIJUeIIx4U2L6DcEBc/Xq8CBBvYK0lMabAS7CYKAlGEtcIVym+yWHLroaYyKz
 SQhF4LrQxyZjNOa8NcHhtaT37MT+nazWRh7rTHNPZJ+wWA+bcDZHebD5zV5/eNAuSUJY
 mraA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737824550; x=1738429350;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=McaXcSpNynHCA9tSKGj/1Op/r9CMceoElpHx5WUOIrU=;
 b=Y8ghy+YfYJumrs53tBJF5BpDKO3237guXJp5Oa+SF1aryq3f3z4xD5dK/YEt7sLqPe
 iRT0Ujo2TExi0UmFy0ggsuGA6nh7vqtJjjAPH9/LNWdS3u12uSi4OFzcAkSESGztM+rm
 K86SBUWmkEBHvIMXmNlccXrnWHxxH8rmtGi9EFWWfSqMrsvt3z98lzwsjzjv8dp7rDvX
 5pviwdIxYr94cMSAAHWVS3N9cKClCslCuawHhhYu919ihmirgtCr6lZ9o4y4sXJknxlN
 3ZRfWRWxHtvZTXTrLaOXnLr3uhcMIJz2oLkcQCsnZPa9LXJRlTCEc/9ZPlEP6h2odvk4
 eC9w==
X-Gm-Message-State: AOJu0YyJWeOVKURv85edpuwYctOfPQzFnShN8pbtjhUBgk/YONXx9Ml1
 AFWQ7O8AwRkvlxheKwsHR+UPtpdBfmRPeviXEwOikwmA2WklGHyoUPhdEgetlJSUqUcB41EJ+Mx
 W6dQ=
X-Gm-Gg: ASbGncuhgFB5VI+eysqnX+D3fylegSDVT13XYTwVm8AEEyZGJ3bj6AgNgoN1OgtVuzR
 LlQZxAZVLsh7Q/igZLORZiz3dgA4MtdLUVPCVp4RegJ3t6PZh6sB0zxTetWgagzNoWkbIf0WzhY
 l8MAyWjG17S80WRmlS86nNtBIh9MDwb+BwY7OM9cAZxeTfPm1ibIzogLgHRi7xzUETzJ/bjgsdo
 6cVkCzg03Bnm7FjYb1TSx8a2KcA0hbaT8PN/Qo0+77xyNWGFzwjKjycIkkuwNUBMJPaPzOkk/CU
 4O28IOuiuP6/7IW0ph4IKgMjd5+oKL9Y4jNXrln5Jn8Bj3ceayaF1gg=
X-Google-Smtp-Source: AGHT+IELqiZt4FNKXNQuvZhe/3Eh5kIG7eMyhRNf1ubzfCoYuTwqKy/mnOy6rkLUq8FTSSG1Uc4UYg==
X-Received: by 2002:a05:600c:3593:b0:431:55c1:f440 with SMTP id
 5b1f17b1804b1-4389144eea8mr387806845e9.30.1737824550049; 
 Sat, 25 Jan 2025 09:02:30 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd502007sm66246515e9.14.2025.01.25.09.02.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 25 Jan 2025 09:02:28 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 13/24] target/mips: Move has_work() from CPUClass to
 SysemuCPUOps
Date: Sat, 25 Jan 2025 18:01:14 +0100
Message-ID: <20250125170125.32855-14-philmd@linaro.org>
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

Move has_work() from CPUClass to SysemuCPUOps and
cpu_mips_hw_interrupts_enabled() to system.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/mips/internal.h | 4 ++--
 target/mips/cpu.c      | 4 +++-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/target/mips/internal.h b/target/mips/internal.h
index 91c786cff8a..28eb28936ba 100644
--- a/target/mips/internal.h
+++ b/target/mips/internal.h
@@ -162,8 +162,6 @@ void cpu_mips_store_cause(CPUMIPSState *env, target_ulong val);
 
 extern const VMStateDescription vmstate_mips_cpu;
 
-#endif /* !CONFIG_USER_ONLY */
-
 static inline bool cpu_mips_hw_interrupts_enabled(CPUMIPSState *env)
 {
     return (env->CP0_Status & (1 << CP0St_IE)) &&
@@ -206,6 +204,8 @@ static inline bool cpu_mips_hw_interrupts_pending(CPUMIPSState *env)
     return r;
 }
 
+#endif /* !CONFIG_USER_ONLY */
+
 void msa_reset(CPUMIPSState *env);
 
 /* cp0_timer.c */
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 47cd7cfdcef..0b3ac4e60a3 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -132,6 +132,7 @@ static vaddr mips_cpu_get_pc(CPUState *cs)
     return cpu->env.active_tc.PC;
 }
 
+#if !defined(CONFIG_USER_ONLY)
 static bool mips_cpu_has_work(CPUState *cs)
 {
     CPUMIPSState *env = cpu_env(cs);
@@ -177,6 +178,7 @@ static bool mips_cpu_has_work(CPUState *cs)
     }
     return has_work;
 }
+#endif /* !CONFIG_USER_ONLY */
 
 static int mips_cpu_mmu_index(CPUState *cs, bool ifunc)
 {
@@ -534,6 +536,7 @@ static ObjectClass *mips_cpu_class_by_name(const char *cpu_model)
 #include "hw/core/sysemu-cpu-ops.h"
 
 static const struct SysemuCPUOps mips_sysemu_ops = {
+    .has_work = mips_cpu_has_work,
     .get_phys_page_debug = mips_cpu_get_phys_page_debug,
     .legacy_vmsd = &vmstate_mips_cpu,
 };
@@ -577,7 +580,6 @@ static void mips_cpu_class_init(ObjectClass *c, void *data)
                                        &mcc->parent_phases);
 
     cc->class_by_name = mips_cpu_class_by_name;
-    cc->has_work = mips_cpu_has_work;
     cc->mmu_index = mips_cpu_mmu_index;
     cc->dump_state = mips_cpu_dump_state;
     cc->set_pc = mips_cpu_set_pc;
-- 
2.47.1


