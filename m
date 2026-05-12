Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EADACD4851
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 06:25:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMgY8-00042S-85; Tue, 12 May 2026 02:25:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMgXM-00038g-3X
 for qemu-devel@nongnu.org; Tue, 12 May 2026 02:24:15 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMgXJ-0005eX-H7
 for qemu-devel@nongnu.org; Tue, 12 May 2026 02:24:11 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-488b0e1b870so86228805e9.2
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 23:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778567040; x=1779171840; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4LsJakp8b2CBC0mN45Pmy8Xk77w3/GigkSKwpcUu2kc=;
 b=PYjhuF7Fr7J9JDXSrLHF9D5fiXWAEj0yHjKHCnhYDiCnuWRiSZoNvBWoMVUV2Do9t2
 6EBeFlG3srWeBFqXkdkFr0ljpdOSND1De4r7ctDPYUFf0bViuQoz8M5cQiAo1yPWqiB8
 Vuw0p7gVh1ZjNDR1MJnrZ+dauVpZBbxhPjss9MaKZSHBst6/coxbw2uN54+wk/K8TfCU
 Yt9CmolkiC1q5DIb+W20MLdd7Azpxqzx9PRQK2yQY8KtMIjtwuoF2zh5Sx6rckP7mPxY
 z/reNChknNvB+oTWBpd/3vYhvI28mq0MQBYhLaeY9zIQNOjnHopeHPxKZ4IYYLb1K7wz
 lajQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778567040; x=1779171840;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=4LsJakp8b2CBC0mN45Pmy8Xk77w3/GigkSKwpcUu2kc=;
 b=G5y+SKCCbcN4V8iUZQr7xFGAzcJs0PQUjMM5kWjh5WDF564MNvvDKEazcu6sMPk38O
 SzBHqlk6gI7XczZYjfOjpCG9T883AIkK9tTlTXAoEurL3YA/NlC16swCOnYxkzeDa01e
 sA76f/rsSJP19+g+El3GODxElgIyYMRexnuPyReXvr8zu/4qm4bKVb6dzMtuCd9wwKP8
 /bH8hnCM9UiEszt62vZFXAm8hRzZZ2lEugbLlS0eNpoY95jS5RatdgEumLc4aBqkVWL+
 7XJ3bW8FqufRZSAU/pbJxQ9CHEazTjZxXAOMzQ0ebneXUKAWZn+mx0ytN15HuLL9w3v7
 kQhQ==
X-Gm-Message-State: AOJu0YwesZeh9EbUT9Zw8IXM6QWuMI80gV9z5bbpTC9goQwabinGWR2t
 ocWgGwRB5QzHlQWkNmr3TwwI2XqU+QoAf3rjl9W7zq6xWm8sezi7+aM2FnJqzGw3Abc54goX3vx
 H9+hoKl4=
X-Gm-Gg: Acq92OFRjFN35yMSQoEw62UnSU4RDKxyQ6EIFnCmC2e1JjagCb13j04XZG3PXF6/kNg
 H6k+82sCsRaYuhBR+LuHqmGPLi+HfwyeAxsD6lRRih7lDjZyMqqgWovp8pvVuxlwxxXz8vE/9si
 1xF80spPZMTx27WhtBUD3VDttLvrp0lx5+xIWq6Rxwh5dCTTwaItQ8u7ApEfxQ0NHPYKYWTdDjU
 SZW6RfTjTUf5E8fCCBDHJv7Jmhm6nPtCJ+IHGga5FBL5nafxfwIkCK4Rrc7jyM4cHmRen0yZPEj
 NWbvK5Dttp6rTtmnDmzO7RzMJCpxOuMpyKOkv2M/Fw8vmxLGUoY2jPciNtwUqqokmyeBotTcodU
 EjUEzyOZ2lBwQR6vKv1PUvLIt4F7p7+pRt05VEL8rKj5Xz1tEGCEkqiZLpRZygB3+Q8O/xctit2
 Dcmq7M38cJjJsOSjlazsANxvYi+vRw2HQ31Sf22ZHq+8wlA706zNhWnutJ7d3uFse3P5QeF2nb
X-Received: by 2002:a05:600c:8115:b0:48a:9540:1a3a with SMTP id
 5b1f17b1804b1-48e51e196f9mr436472625e9.8.1778567039353; 
 Mon, 11 May 2026 23:23:59 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4548ec6b00fsm33341512f8f.11.2026.05.11.23.23.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 11 May 2026 23:23:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/41] target: Rename cpu_get_phys_page_{,attrs_}debug
Date: Tue, 12 May 2026 08:21:20 +0200
Message-ID: <20260512062142.67998-20-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260512062142.67998-1-philmd@linaro.org>
References: <20260512062142.67998-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

From: Peter Maydell <peter.maydell@linaro.org>

Rename cpu_phys_page_debug() and cpu_phys_page_attrs_debug() to
cpu_phys_addr_debug() and cpu_phys_addr_attrs_debug().

Commit created with:
 sed -i -e 's/cpu_get_phys_page_debug/cpu_get_phys_addr_debug/g;s/cpu_get_phys_page_attrs_debug/cpu_get_phys_addr_attrs_debug/g' $(git grep -l cpu_get_phys_page)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260417173105.1648172-10-peter.maydell@linaro.org
Message-ID: <20260430093810.2762539-11-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/core/cpu.h       | 8 ++++----
 hw/core/cpu-system.c        | 6 +++---
 hw/i386/vapic.c             | 4 ++--
 hw/xtensa/sim.c             | 2 +-
 hw/xtensa/xtfpga.c          | 2 +-
 monitor/hmp-cmds.c          | 2 +-
 plugins/api.c               | 2 +-
 system/physmem.c            | 2 +-
 target/sparc/mmu_helper.c   | 6 +++---
 target/xtensa/xtensa-semi.c | 2 +-
 10 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index c9fea797435..75e47768d43 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -739,7 +739,7 @@ enum CPUDumpFlags {
 void cpu_dump_state(CPUState *cpu, FILE *f, int flags);
 
 /**
- * cpu_get_phys_page_attrs_debug:
+ * cpu_get_phys_addr_attrs_debug:
  * @cpu: The CPU to obtain the physical page address for.
  * @addr: The virtual address.
  * @attrs: Updated on return with the memory transaction attributes to use
@@ -751,11 +751,11 @@ void cpu_dump_state(CPUState *cpu, FILE *f, int flags);
  *
  * Returns: Corresponding physical page address or -1 if no page found.
  */
-hwaddr cpu_get_phys_page_attrs_debug(CPUState *cpu, vaddr addr,
+hwaddr cpu_get_phys_addr_attrs_debug(CPUState *cpu, vaddr addr,
                                      MemTxAttrs *attrs);
 
 /**
- * cpu_get_phys_page_debug:
+ * cpu_get_phys_addr_debug:
  * @cpu: The CPU to obtain the physical page address for.
  * @addr: The virtual address.
  *
@@ -764,7 +764,7 @@ hwaddr cpu_get_phys_page_attrs_debug(CPUState *cpu, vaddr addr,
  *
  * Returns: Corresponding physical page address or -1 if no page found.
  */
-hwaddr cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
+hwaddr cpu_get_phys_addr_debug(CPUState *cpu, vaddr addr);
 
 /** cpu_asidx_from_attrs:
  * @cpu: CPU
diff --git a/hw/core/cpu-system.c b/hw/core/cpu-system.c
index 93dc861083c..05c126ecb6b 100644
--- a/hw/core/cpu-system.c
+++ b/hw/core/cpu-system.c
@@ -55,7 +55,7 @@ bool cpu_get_memory_mapping(CPUState *cpu, MemoryMappingList *list,
     return false;
 }
 
-hwaddr cpu_get_phys_page_attrs_debug(CPUState *cpu, vaddr addr,
+hwaddr cpu_get_phys_addr_attrs_debug(CPUState *cpu, vaddr addr,
                                      MemTxAttrs *attrs)
 {
     hwaddr paddr;
@@ -73,11 +73,11 @@ hwaddr cpu_get_phys_page_attrs_debug(CPUState *cpu, vaddr addr,
     return paddr;
 }
 
-hwaddr cpu_get_phys_page_debug(CPUState *cpu, vaddr addr)
+hwaddr cpu_get_phys_addr_debug(CPUState *cpu, vaddr addr)
 {
     MemTxAttrs attrs = {};
 
-    return cpu_get_phys_page_attrs_debug(cpu, addr, &attrs);
+    return cpu_get_phys_addr_attrs_debug(cpu, addr, &attrs);
 }
 
 int cpu_asidx_from_attrs(CPUState *cpu, MemTxAttrs attrs)
diff --git a/hw/i386/vapic.c b/hw/i386/vapic.c
index 3738031a055..225f19a75c7 100644
--- a/hw/i386/vapic.c
+++ b/hw/i386/vapic.c
@@ -173,7 +173,7 @@ static int find_real_tpr_addr(VAPICROMState *s, CPUX86State *env)
      * virtual address space for the APIC mapping.
      */
     for (addr = 0xfffff000; addr >= 0x80000000; addr -= TARGET_PAGE_SIZE) {
-        paddr = cpu_get_phys_page_debug(cs, addr);
+        paddr = cpu_get_phys_addr_debug(cs, addr);
         if (paddr != APIC_DEFAULT_ADDRESS) {
             continue;
         }
@@ -305,7 +305,7 @@ static int update_rom_mapping(VAPICROMState *s, CPUX86State *env, target_ulong i
 
     /* find out virtual address of the ROM */
     rom_state_vaddr = s->rom_state_paddr + (ip & 0xf0000000);
-    paddr = cpu_get_phys_page_debug(cs, rom_state_vaddr);
+    paddr = cpu_get_phys_addr_debug(cs, rom_state_vaddr);
     if (paddr == -1) {
         return -1;
     }
diff --git a/hw/xtensa/sim.c b/hw/xtensa/sim.c
index 994460d0414..32eb16442f0 100644
--- a/hw/xtensa/sim.c
+++ b/hw/xtensa/sim.c
@@ -41,7 +41,7 @@ static uint64_t translate_phys_addr(void *opaque, uint64_t addr)
 {
     XtensaCPU *cpu = opaque;
 
-    return cpu_get_phys_page_debug(CPU(cpu), addr);
+    return cpu_get_phys_addr_debug(CPU(cpu), addr);
 }
 
 static void sim_reset(void *opaque)
diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
index 5e509216df8..256497e162d 100644
--- a/hw/xtensa/xtfpga.c
+++ b/hw/xtensa/xtfpga.c
@@ -192,7 +192,7 @@ static uint64_t translate_phys_addr(void *opaque, uint64_t addr)
 {
     XtensaCPU *cpu = opaque;
 
-    return cpu_get_phys_page_debug(CPU(cpu), addr);
+    return cpu_get_phys_addr_debug(CPU(cpu), addr);
 }
 
 static void xtfpga_reset(void *opaque)
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index db92d6cb86b..b37a9985c0d 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -771,7 +771,7 @@ void hmp_gva2gpa(Monitor *mon, const QDict *qdict)
         return;
     }
 
-    gpa  = cpu_get_phys_page_debug(cs, addr & TARGET_PAGE_MASK);
+    gpa  = cpu_get_phys_addr_debug(cs, addr & TARGET_PAGE_MASK);
     if (gpa == -1) {
         monitor_printf(mon, "Unmapped\n");
     } else {
diff --git a/plugins/api.c b/plugins/api.c
index 0c348a789b2..4b6fad49998 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -619,7 +619,7 @@ bool qemu_plugin_translate_vaddr(uint64_t vaddr, uint64_t *hwaddr)
 #ifdef CONFIG_SOFTMMU
     g_assert(current_cpu);
 
-    uint64_t res = cpu_get_phys_page_debug(current_cpu, vaddr);
+    uint64_t res = cpu_get_phys_addr_debug(current_cpu, vaddr);
 
     if (res == (uint64_t)-1) {
         return false;
diff --git a/system/physmem.c b/system/physmem.c
index c58d940e807..652b03ad5f5 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -4041,7 +4041,7 @@ int cpu_memory_rw_debug(CPUState *cpu, vaddr addr,
         MemTxResult res;
 
         page = addr & TARGET_PAGE_MASK;
-        phys_addr = cpu_get_phys_page_attrs_debug(cpu, page, &attrs);
+        phys_addr = cpu_get_phys_addr_attrs_debug(cpu, page, &attrs);
         asidx = cpu_asidx_from_attrs(cpu, attrs);
         /* if no physical page mapped, return an error */
         if (phys_addr == -1)
diff --git a/target/sparc/mmu_helper.c b/target/sparc/mmu_helper.c
index 34b212a7aa5..e1abd520c49 100644
--- a/target/sparc/mmu_helper.c
+++ b/target/sparc/mmu_helper.c
@@ -366,20 +366,20 @@ void dump_mmu(CPUSPARCState *env)
     for (n = 0, va = 0; n < 256; n++, va += 16 * 1024 * 1024) {
         pde = mmu_probe(env, va, 2);
         if (pde) {
-            pa = cpu_get_phys_page_debug(cs, va);
+            pa = cpu_get_phys_addr_debug(cs, va);
             qemu_printf("VA: " TARGET_FMT_lx ", PA: " HWADDR_FMT_plx
                         " PDE: " TARGET_FMT_lx "\n", va, pa, pde);
             for (m = 0, va1 = va; m < 64; m++, va1 += 256 * 1024) {
                 pde = mmu_probe(env, va1, 1);
                 if (pde) {
-                    pa = cpu_get_phys_page_debug(cs, va1);
+                    pa = cpu_get_phys_addr_debug(cs, va1);
                     qemu_printf(" VA: " TARGET_FMT_lx ", PA: "
                                 HWADDR_FMT_plx " PDE: " TARGET_FMT_lx "\n",
                                 va1, pa, pde);
                     for (o = 0, va2 = va1; o < 64; o++, va2 += 4 * 1024) {
                         pde = mmu_probe(env, va2, 0);
                         if (pde) {
-                            pa = cpu_get_phys_page_debug(cs, va2);
+                            pa = cpu_get_phys_addr_debug(cs, va2);
                             qemu_printf("  VA: " TARGET_FMT_lx ", PA: "
                                         HWADDR_FMT_plx " PTE: "
                                         TARGET_FMT_lx "\n",
diff --git a/target/xtensa/xtensa-semi.c b/target/xtensa/xtensa-semi.c
index 28dfb29cbd3..9a6a9c8b4e4 100644
--- a/target/xtensa/xtensa-semi.c
+++ b/target/xtensa/xtensa-semi.c
@@ -215,7 +215,7 @@ void HELPER(simcall)(CPUXtensaState *env)
             uint32_t len_done = 0;
 
             while (len > 0) {
-                hwaddr paddr = cpu_get_phys_page_debug(cs, vaddr);
+                hwaddr paddr = cpu_get_phys_addr_debug(cs, vaddr);
                 uint32_t page_left =
                     TARGET_PAGE_SIZE - (vaddr & (TARGET_PAGE_SIZE - 1));
                 uint32_t io_sz = page_left < len ? page_left : len;
-- 
2.53.0


