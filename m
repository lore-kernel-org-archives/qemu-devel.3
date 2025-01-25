Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D259C0218C
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2025 17:05:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbjYF-0007jT-Bp; Sat, 25 Jan 2025 12:02:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbjXz-0007Ld-Ig
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 12:02:16 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbjXx-0000U8-VF
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 12:02:15 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-38634c35129so2799435f8f.3
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2025 09:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737824532; x=1738429332; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SFxXNpC5yVfbLd+sXWLwj9ZcwKFDj0iGBJJhc1kZZeQ=;
 b=TKztmODiVcQDk0CNVWfLKxXA5jb137SdOmHrZduqjKQ5uO1BfmLylYj2nyPmSx7NgT
 /YIelJeW9B6NhEAFQ2wvbw/+P/fBNX+kXL/+S216Iuojo9QqsNTWZm9OPW3331Z36j6D
 dDvCdReirJzOBxEAqlaLqQz3VLgTVklDCDq73Cr6k4UZGBlCSFOt+IK289eebi0MMdIy
 1xOipwsUeB6X/KKg3l/mKqY6gg90dzQhOnrtnR8dtMfVgV4faZ7T0U1e98df1x3VnihW
 o8ilsxNQwRRzFznl2QRGJ9bJqLe3jRrL0O0S466qJS5fJ4NQ6qbF2+ggxXIV8/pKrchR
 aTjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737824532; x=1738429332;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SFxXNpC5yVfbLd+sXWLwj9ZcwKFDj0iGBJJhc1kZZeQ=;
 b=kaBxfbKTrtBXmQZ1u82l3Rw8Gi4Vnprzg+GWuPLJg7HshcZyuhcXUq2cc2jFbdAayC
 D7zHO3nXrBlkJJjyRVkJ8DbG9qxd+6CzJ23Bi9Xp5bFzFax7ooVo2RLEnfIU7u/D78x8
 2WzNwNvwfhN73Li8d+XJWmmsoqLIV/UX9/5KSmqeMUBblHCrz7AYX2QbEDzQV+pC6ugW
 hIvf0QZm4kEpIDyvT007BrrLrqjDl1pYs2DsjLITCk9JDGLwOT0xgk9NWRsmvVbH9Y/s
 cbxNJlUWvwiE/lLxRU5IyMM+cmsETTbDvZL+rF+LHA77Ar4bXpA9Q6XF5xynoj6LYzXl
 JSog==
X-Gm-Message-State: AOJu0YwTt7gXXI3JeZtVGox9jcy/o7lLD4G8D98p7cgpJnTuz+zi4uwq
 xhL8MwLDyjCZtyu00dY6MCxZbJn4xSGd21CKRCGy2U9SWoL1FMz4BbFsnpiOg+pen38GrwEw94P
 INuQ=
X-Gm-Gg: ASbGncsm88TTBm9TaBnlsWXpqv55uCuXxkcSw56g+mSiyM7pucyDOpiERWo9q45uzvJ
 ZFCm9c1i6vvl4JoXFPVPQWr0VXxm7t8mwrHcbZiMPqbOlX0zad0GDwFor27X+x8tqIwkC794aJY
 yj4oDhztvIVuGzxbAGrQwBt8DxvZrDC56RJJlr4IZ3H3XF5W3jRrXOn8udalzUrQN4PJZo+fQC6
 kro5XpGLsVJO2g4BZPMenPkTAEOS1UKNoqNLc4Q+nj0fz+ZweuqJDPir/trjd99g6iuzyE8y/fr
 anN40tzRdKFAgCbOm8x9V5KtpjrQNKgaF88c7hLZNd+otnXnyLK24PI=
X-Google-Smtp-Source: AGHT+IFFGkIfqh2cMcDbWztbBHQXitzwJE+gpZkJs7ecNISsRijiSGAOSTdd2+U0OL1Grz/3K2EarQ==
X-Received: by 2002:a05:6000:156c:b0:385:eb85:f111 with SMTP id
 ffacd0b85a97d-38bf577f703mr38489428f8f.14.1737824530481; 
 Sat, 25 Jan 2025 09:02:10 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a1bb057sm6050952f8f.62.2025.01.25.09.02.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 25 Jan 2025 09:02:10 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 09/24] target/i386: Move has_work() from CPUClass to
 SysemuCPUOps
Date: Sat, 25 Jan 2025 18:01:10 +0100
Message-ID: <20250125170125.32855-10-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250125170125.32855-1-philmd@linaro.org>
References: <20250125170125.32855-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

Move has_work() from CPUClass to SysemuCPUOps,
restrict x86_cpu_pending_interrupt() to system.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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


