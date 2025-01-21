Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 597E2C0218B
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 14:34:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taFCa-0002li-3c; Tue, 21 Jan 2025 09:26:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taFBm-0001zP-AL
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 09:25:17 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taFBj-0003Tw-27
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 09:25:09 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3862a921123so4054408f8f.3
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 06:25:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737469505; x=1738074305; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=km3kArmfsAMK0iy+xJz4rtnl5tZfE33rr6rRoUamFRE=;
 b=esELUc+iZAUrjFGWCOfV8xw8hhaKtoJauqZoaLOo4lWl+m7BDiaxuiHsX11apIorFm
 ymoIt4Stq4KdgQRiyZaX2Ea3MVPIP0HT8VK/4r1KmXlPKwQIJs5LwW0xGJ1SLSA7m6WB
 pREm4f6j1QH3cK9akG2iLCWv92WlqDEc0yKQTh8RSrdT+Cvi0k6vex489pIRRZkNIbzd
 xlaDwnvcjvpl3S4X+2bJRdugwpDWzKL3eLZQ1CRtliziSDrNIwzA6Fnm3WaDtroTvy1d
 ulVGVdGDavBa5VXX2iUxNFRoP0AOJPzCMrq98ruoE5+AL/xi1WOF2ndh7yfE++TsnDk2
 jKmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737469505; x=1738074305;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=km3kArmfsAMK0iy+xJz4rtnl5tZfE33rr6rRoUamFRE=;
 b=DK7f0/ZO5Iw09pANaj9betHjud8EYxUBndkugeuEg6zXjPdxiN+XC4ya4MoD81awM9
 XGSUA81xXIBpuxkm7JwiXHNBI7ul0Zt8n+hPXL4bPbgky/994Ju5omh4R5cqG/g9Psiz
 SdMsLxZ/7A7fi233VO1MRh2tlyuq8nbFwjdA4x//r3J6Z3nMr4SpU0qGbQS49GFOhigZ
 bJidrQChIwe26XLbMVHJ+Y9e59t17Re0BR9M+QPTyfjvI4tJO3tbjjyE00KJ9cxkEZGH
 I5qojH3WNug6664Ws7qapYwSymJZaKqfEA5y1NZVoFCRRIE0eJaAeo+LdaNyzub/zru1
 uU9A==
X-Gm-Message-State: AOJu0Yya6e43uC+7gatWUzwQVjS19S+StIdnfK2V2fW2tz8kcPutjsQ3
 Y5SP1R9QxCoHAJA/Z99dSRZXvtYPz/iKe3IHUhrw52D9/PdoaJv+PKBLRhDkyGMJ1VDMGmwjh3U
 wEcg=
X-Gm-Gg: ASbGncvhHaiFoRnoeIwQy3fyvagCGjCvYiVqOyXr4PChlKRPK7oDhwxYBONs6iLp8/V
 HtbE1veViup4LUQVtxqQ5AzTpu9TRAPx7IS2BQCJ21zjBFrtQVglonKTPPi0nJLPKcNDsYUb4sU
 V4Tidw8h6Kw9ZNmDDIV5gwMcUiIaOQr2Pz7LZkEy8bbVqLTRgNf+YZ36gt4FAtIkr1v2ibZO/tO
 /+Iy+X9P688JJyuIdwCG6t77PnE+aDk+lUvsrbJFkLVVdR+Vdy6t7JMM7/OI3imjGlYwstjMaox
 7wZV64FLaVMhDabaazG0HHwL6pMebnYjRWlVN1MNaHmS
X-Google-Smtp-Source: AGHT+IHxVyqv5FTa21nb19oJaZbD9h21zO+kugnyX2rWmBf9v4pFuURTISW5VzhmslZBx2RU/Pd5YA==
X-Received: by 2002:a5d:4f8d:0:b0:385:e5d8:3ec2 with SMTP id
 ffacd0b85a97d-38bf566f8damr11608978f8f.28.1737469504953; 
 Tue, 21 Jan 2025 06:25:04 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38bf327e1fdsm13688194f8f.94.2025.01.21.06.25.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Jan 2025 06:25:04 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org, qemu-riscv@nongnu.org,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 17/28] target/mips: Move has_work() from CPUClass to
 SysemuCPUOps
Date: Tue, 21 Jan 2025 15:23:30 +0100
Message-ID: <20250121142341.17001-18-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250121142341.17001-1-philmd@linaro.org>
References: <20250121142341.17001-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

Move has_work() from CPUClass to SysemuCPUOps and
cpu_mips_hw_interrupts_enabled() to system.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


