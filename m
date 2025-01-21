Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04BB3C02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 14:30:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taFBU-0001Ks-S0; Tue, 21 Jan 2025 09:24:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taFBT-0001Ge-57
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 09:24:51 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taFBQ-0003Dr-8z
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 09:24:50 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-38a8b35e168so3978366f8f.1
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 06:24:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737469486; x=1738074286; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1OW6/o4DCFgT3ilwuV2iLRLfLVBrhuRs1sUZEij4GK4=;
 b=AFVie4bxAX3IOVeGygVIgIKoeLvoMBdGwL5hxqZJGRca3iKS99wMO3B+z5oGyEjeYt
 t0vn4XxTEwydUeuEuyUHEdFPAVyjiHZaNUyUSBBQvLZliiF66MJQpWbvWntGfCCvzE+Y
 XBbhr7xSX93lWpJNuvw3R4q5LXiBH4Tqd/bLVapkCc5I9rS5+4O6OXr07/nV+qeX0GlH
 qSMdkO9z4hsV7Yqs4hSKvPkUIZYsznoce+DwhA4XVu4dyO8TMH6hsp6cOn1qZfBBB8kP
 3Ob0iyBcn88LrAs8gVbebfAnwNMoujnKeGjk6JI83Xfn4tYHaEl408SdIUyr2Pafrghg
 ufaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737469486; x=1738074286;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1OW6/o4DCFgT3ilwuV2iLRLfLVBrhuRs1sUZEij4GK4=;
 b=N3CL+njYXZ2ENF79xNDFJvKcCPamQRO8/zW0xnE4/wepBIvADqfOnAeW9UHKGcjHiL
 jvwLBi7iZpqwZR5V9WKBkfDnyjGaaAEAsUroFCPgQTXWa/arVC+N532BCAEMw4JKTCJq
 CwWZ86+jT6JBe3VfJexlLVjIJF0yqGdNvV6D3fijA70uDo3XOHLnEQ1+YhcqOplPaVA3
 nLQ5oC7Ysjbx321DYQDdvjf1htDQ7wA/aX3g1jSINX17lLywLdp2bGcp4bnxFTIWgEYB
 PtwUB4H5mcsrQ2CvOK+mivT7ncYIdrcYr+TrJWQVIgCu++k4zif3JbhDGj8m4qhbTei5
 5B3A==
X-Gm-Message-State: AOJu0YxQXP5DFKE6IWwL7kU9i8Memweo+Z9Jepuqi0Zbk/qVVmhcIaT6
 Sv/6Wze2PWtzMdN/k9CEmc6LExj9TE9scLUGIThpoefqf2qSpkIJLlWuaujhv+L/uz2rPu7a3KI
 tXzQ=
X-Gm-Gg: ASbGncuwaMcudGbKeqYZT+WMYZcIUJAkWtawh+vq05bsRNBxrzIEE33cugtSkDOO6Hi
 36E6XYBk0igkCoo6DfPCATV/sG2zHxyiQLrotzCf0KG9zDCWuSePhb8p6ayBcEVZzWxtHVgGOFx
 K6sogNqYnbzJhpwf9SGKZD+5xrGDoEkCPpb8YyrF4KtYvULhVWIeiNm/RFhrW3agnTNZU/srXB+
 Xp2qye3a6w54gVIWUSshZ0SR4vdB8gj3TixU+bp2ItSOYqFTLXqf2+MOiuiZvZKVGfkgPCxuESv
 fECM5PimXIZ5nPelf7w5YcJBS5f7fuRhwDm4pgOrmnK6
X-Google-Smtp-Source: AGHT+IFtX5g/GjBbUB8jJEpboAIbX7nsBc2mIcKl0+bFua6BeE629tSoqVI5R6ihsJ3W5Zz1ZAkiSw==
X-Received: by 2002:a05:6000:18ab:b0:38a:49c1:8345 with SMTP id
 ffacd0b85a97d-38bec542923mr19873328f8f.18.1737469486020; 
 Tue, 21 Jan 2025 06:24:46 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4389041fec5sm184339285e9.19.2025.01.21.06.24.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Jan 2025 06:24:45 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org, qemu-riscv@nongnu.org,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 13/28] target/i386: Move has_work() from CPUClass to
 SysemuCPUOps
Date: Tue, 21 Jan 2025 15:23:26 +0100
Message-ID: <20250121142341.17001-14-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250121142341.17001-1-philmd@linaro.org>
References: <20250121142341.17001-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

Move has_work() from CPUClass to SysemuCPUOps,
restrict x86_cpu_pending_interrupt() to system.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/cpu.h | 4 ++--
 target/i386/cpu.c | 8 +++-----
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index b26e25ba15e..869b8598cd5 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2289,8 +2289,6 @@ struct X86CPUClass {
 extern const VMStateDescription vmstate_x86_cpu;
 #endif
 
-int x86_cpu_pending_interrupt(CPUState *cs, int interrupt_request);
-
 int x86_cpu_write_elf64_note(WriteCoreDumpFunction f, CPUState *cpu,
                              int cpuid, DumpState *s);
 int x86_cpu_write_elf32_note(WriteCoreDumpFunction f, CPUState *cpu,
@@ -2313,6 +2311,8 @@ void x86_cpu_list(void);
 int cpu_x86_support_mca_broadcast(CPUX86State *env);
 
 #ifndef CONFIG_USER_ONLY
+int x86_cpu_pending_interrupt(CPUState *cs, int interrupt_request);
+
 hwaddr x86_cpu_get_phys_page_attrs_debug(CPUState *cpu, vaddr addr,
                                          MemTxAttrs *attrs);
 int cpu_get_pic_interrupt(CPUX86State *s);
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 1b9c11022c4..51faba4e0b4 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -8256,16 +8256,15 @@ static vaddr x86_cpu_get_pc(CPUState *cs)
     return cpu->env.eip + cpu->env.segs[R_CS].base;
 }
 
+#if !defined(CONFIG_USER_ONLY)
 int x86_cpu_pending_interrupt(CPUState *cs, int interrupt_request)
 {
     X86CPU *cpu = X86_CPU(cs);
     CPUX86State *env = &cpu->env;
 
-#if !defined(CONFIG_USER_ONLY)
     if (interrupt_request & CPU_INTERRUPT_POLL) {
         return CPU_INTERRUPT_POLL;
     }
-#endif
     if (interrupt_request & CPU_INTERRUPT_SIPI) {
         return CPU_INTERRUPT_SIPI;
     }
@@ -8286,14 +8285,12 @@ int x86_cpu_pending_interrupt(CPUState *cs, int interrupt_request)
                      (env->eflags & IF_MASK &&
                       !(env->hflags & HF_INHIBIT_IRQ_MASK))))) {
             return CPU_INTERRUPT_HARD;
-#if !defined(CONFIG_USER_ONLY)
         } else if (env->hflags2 & HF2_VGIF_MASK) {
             if((interrupt_request & CPU_INTERRUPT_VIRQ) &&
                    (env->eflags & IF_MASK) &&
                    !(env->hflags & HF_INHIBIT_IRQ_MASK)) {
                         return CPU_INTERRUPT_VIRQ;
             }
-#endif
         }
     }
 
@@ -8304,6 +8301,7 @@ static bool x86_cpu_has_work(CPUState *cs)
 {
     return x86_cpu_pending_interrupt(cs, cs->interrupt_request) != 0;
 }
+#endif /* !CONFIG_USER_ONLY */
 
 int x86_mmu_index_pl(CPUX86State *env, unsigned pl)
 {
@@ -8544,6 +8542,7 @@ static const Property x86_cpu_properties[] = {
 #include "hw/core/sysemu-cpu-ops.h"
 
 static const struct SysemuCPUOps i386_sysemu_ops = {
+    .has_work = x86_cpu_has_work,
     .get_memory_mapping = x86_cpu_get_memory_mapping,
     .get_paging_enabled = x86_cpu_get_paging_enabled,
     .get_phys_page_attrs_debug = x86_cpu_get_phys_page_attrs_debug,
@@ -8577,7 +8576,6 @@ static void x86_cpu_common_class_init(ObjectClass *oc, void *data)
 
     cc->class_by_name = x86_cpu_class_by_name;
     cc->parse_features = x86_cpu_parse_featurestr;
-    cc->has_work = x86_cpu_has_work;
     cc->mmu_index = x86_cpu_mmu_index;
     cc->dump_state = x86_cpu_dump_state;
     cc->set_pc = x86_cpu_set_pc;
-- 
2.47.1


