Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E924C44506
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 02:58:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi1Pd-0007sH-M0; Thu, 09 Jul 2026 22:56:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wi1Pc-0007oF-7U
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 22:56:24 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wi1Pa-0008Nq-H0
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 22:56:23 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-84864b41122so242175b3a.2
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 19:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783652181; x=1784256981; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Wi3p1TVuJVJ680l4qAEP9wnb79xMffISMjnAZHtuzWo=;
 b=Llnoy+qGMm9LZvB6PuytPgmF2Mtiea5nlYgk0JLpAK1WaDMSJB0ZSpQQq6/Gu2QB9A
 gzDkA3y6kpW10gm/xKB86hmOoBXOTfeJt2o3H9kPRSrVWlvAzcR7fXfNza9/dF+ums/L
 p9SiSjazCAWLM1ufPfeiHk/ch9K9oWb/xloQQz4MDEjfWJEH+/de6CqqxS2r4eNrQOuI
 Jw7nmOQTX8jBEQnMis2/a+199xYhPkEshMXa008eCoRE4DoGxMrLAOTFEFoFMIdPKqe6
 Y1YqxAduMvFXE8xhTEDzU12cU513SURguXvnDk8PptLDpfeKrmzbSqreVLOL3eU70qr2
 jE0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783652181; x=1784256981;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Wi3p1TVuJVJ680l4qAEP9wnb79xMffISMjnAZHtuzWo=;
 b=i5ADpW5QRpwpXrWHUdHLs4+a1M9z1sisZnl+EhNDuuJF9rRYK+fi/AODwJNtdZFA+Z
 Zs/hsFBgG7pGS44px5P/BdXPntiYN4WYeLkery9ng3v4S/c5FLZ5mdGxW4c67RQwmt8D
 2gRG1bzIDrayhL/9e11O1lvLMUH7Anv9qthNErBTQuSXwHvktwFk6YIZ5JaUHZ6dBzfn
 F9Ba/QTxG8ouWJ2llpTrWSoMtMdE7iGgIRX9QOTANjkPAs1fn/GAdr8pLW8S2tGKPFIA
 wc71/aQJpY20nFFzfyk2P7IF0VwVs4NHbao5cOSW2vCyhwm71bdSovKjT0zMBydpnYj7
 1rfQ==
X-Gm-Message-State: AOJu0YwgKZlwif3/HsOEJEFLc5eK1qLtuHcHiKblx9pssUknyrGJPDtv
 fzzz7HXR+mi+JKVjuH+rIcDmQdlEz/SsLrxUIAkEI9vZ2rsNrBkiseZO/8puRA==
X-Gm-Gg: AfdE7cmsA6V9mcbXPJhVGTJDxA2x6kzTqtmG/PXnTrljDt+LlVOUX3OpYPpEk9kb+RU
 d+M6bSLGjJvh1SMDi3PTzDuK4l2vY2GGZsQDzrF0wxp/uhbgB8EV8FZepQZnRzZlfURqVx0vg4w
 nG0LPqOri78Es7+gwXLK/oftmv7xU+AqNaYMHh3joTWSWXwQ2d9tsebwhopaImXLLVNod2lZ1jT
 82iJY6IbzYZ3jGWwkdsnssPrbhOuBegTw6SXO1tIMJy1LsiVh8NE/CCITH2ubEj4uK7SB6LuQG3
 K/0fyKUS73+W77D118wQFvsCGOW5kw8EQ03NN6aPWNqdJTR0K19TahcS/M7LMpUmeDj8xZAHJeF
 2DQ7Ou6oJxltWcJhylcFPrj4S2yL8xGi6jgEgEByR1ehcFhRsxnFnnYd6tkXuw+ayoIhxinlw7/
 Kmhh3OoJ1Z+BhfACK2vT1xarT38kSxNSA=
X-Received: by 2002:a05:6a20:12d0:b0:3bf:b68f:4682 with SMTP id
 adf61e73a8af0-3c0bce1eb4cmr11627304637.7.1783652181133; 
 Thu, 09 Jul 2026 19:56:21 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ca5af6e04fcsm4576769a12.4.2026.07.09.19.56.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 19:56:20 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 13/40] target/riscv: tidy up riscv_sysemu_ops
Date: Fri, 10 Jul 2026 12:54:58 +1000
Message-ID: <20260710025525.1704417-14-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260710025525.1704417-1-alistair.francis@wdc.com>
References: <20260710025525.1704417-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x434.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

monitor_get_register at this moment has a TCG exclusive implementation
for RISC-V, even though the callback is supposed to be arch independent.
Until we address how KVM is going to implement it we need to filter it out
in cpu.c.

Same goes for get_phys_addr_debug - it has a TCG only implementation and
KVM can't use it for now.  It would also need to be filtered out, but
since we're at it, let's convert it to the newer 'translate_for_debug'
API too.  Same restrictions apply.

Suggested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260703180538.3346781-8-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h            |  3 ++-
 target/riscv/cpu.c            |  6 ++++--
 target/riscv/monitor.c        |  2 ++
 target/riscv/tcg/cpu_helper.c | 14 ++++++++++----
 4 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index ecf2913d42..18fbd4edb6 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -665,7 +665,8 @@ void riscv_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
                                      MMUAccessType access_type,
                                      int mmu_idx, MemTxAttrs attrs,
                                      MemTxResult response, uintptr_t retaddr);
-hwaddr riscv_cpu_get_phys_addr_debug(CPUState *cpu, vaddr addr);
+bool riscv_cpu_translate_for_debug(CPUState *cs, vaddr addr,
+                                   TranslateForDebugResult *result);
 bool riscv_cpu_exec_interrupt(CPUState *cs, int interrupt_request);
 void riscv_cpu_swap_hypervisor_regs(CPURISCVState *env);
 int riscv_cpu_claim_interrupts(RISCVCPU *cpu, uint64_t interrupts);
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index cae4e96232..d17ba0474a 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2693,11 +2693,13 @@ static int64_t riscv_get_arch_id(CPUState *cs)
 
 static const struct SysemuCPUOps riscv_sysemu_ops = {
     .has_work = riscv_cpu_has_work,
-    .get_phys_addr_debug = riscv_cpu_get_phys_addr_debug,
     .write_elf64_note = riscv_cpu_write_elf64_note,
     .write_elf32_note = riscv_cpu_write_elf32_note,
-    .monitor_get_register = riscv_monitor_get_register_legacy,
     .legacy_vmsd = &vmstate_riscv_cpu,
+#ifdef CONFIG_TCG
+    .translate_for_debug = riscv_cpu_translate_for_debug,
+    .monitor_get_register = riscv_monitor_get_register_legacy,
+#endif
 };
 #endif
 
diff --git a/target/riscv/monitor.c b/target/riscv/monitor.c
index 3e89dcaf7c..7aacd1d89c 100644
--- a/target/riscv/monitor.c
+++ b/target/riscv/monitor.c
@@ -245,6 +245,7 @@ void hmp_info_mem(Monitor *mon, const QDict *qdict)
     mem_info_svxx(mon, env);
 }
 
+#ifdef CONFIG_TCG
 static bool reg_is_ulong_integer(CPURISCVState *env, const char *name,
                                  target_ulong *val, bool is_gprh)
 {
@@ -379,3 +380,4 @@ int riscv_monitor_get_register_legacy(CPUState *cs, const char *name,
 
     return -EINVAL;
 }
+#endif
diff --git a/target/riscv/tcg/cpu_helper.c b/target/riscv/tcg/cpu_helper.c
index 2db07f5dfb..885b4172c0 100644
--- a/target/riscv/tcg/cpu_helper.c
+++ b/target/riscv/tcg/cpu_helper.c
@@ -1779,7 +1779,8 @@ static void raise_mmu_exception(CPURISCVState *env, target_ulong address,
     env->two_stage_indirect_lookup = two_stage_indirect;
 }
 
-hwaddr riscv_cpu_get_phys_addr_debug(CPUState *cs, vaddr addr)
+bool riscv_cpu_translate_for_debug(CPUState *cs, vaddr addr,
+                                   TranslateForDebugResult *result)
 {
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
@@ -1789,17 +1790,22 @@ hwaddr riscv_cpu_get_phys_addr_debug(CPUState *cs, vaddr addr)
 
     if (get_physical_address(env, &phys_addr, &prot, addr, NULL, 0, mmu_idx,
                              true, env->virt_enabled, true, false)) {
-        return -1;
+        return false;
     }
 
     if (env->virt_enabled) {
         if (get_physical_address(env, &phys_addr, &prot, phys_addr, NULL,
                                  0, MMUIdx_U, false, true, true, false)) {
-            return -1;
+            return false;
         }
     }
 
-    return phys_addr;
+    *result = (TranslateForDebugResult) {
+        .physaddr = phys_addr,
+        .lg_page_size = TARGET_PAGE_BITS,
+        .attrs.debug = 1,
+    };
+    return true;
 }
 
 void riscv_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
-- 
2.54.0


