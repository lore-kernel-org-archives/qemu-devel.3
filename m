Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4CEEC624D4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 05:53:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x20Ne-0006Zd-H1; Thu, 03 Sep 2026 01:52:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1x20Nb-0006Yz-8j
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 01:52:55 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1x20NZ-0006Mp-D4
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 01:52:55 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-85377c8bc96so2203690b3a.3
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 22:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788414772; x=1789019572; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:sender:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=fEazz1nkDaT5UFz2ceWV2jlVqHjpqNIgj/Y/2cpVwZ4=;
 b=g5FNB2UduhaYuRyinaWdRcri0G1jvdVPyOTqVWbefDU7AVKBjijEyaU3uO3DplYccJ
 0oJSXGOi2ckxW9cwRV6CXYEYMxY3i5xGOgNjKy3Re5nf7Eo5QTIoB5VkGRT8bqor6eUX
 KHiUMdwgOI/eABKhiY7KCnyCjLTQfioxUZr2SaikbMwWr2JfRHGgWKSjWZeztexQAVup
 XegGgPYWzKDuQjlD8YlDOtYgrgZTsHOtR+Whv4hxzHIaB1c3qQoOGTi7WWFxhChG7Keg
 ADmoTK/guF3mCSHzzCkTFddiXWKVqBa7QTadvLnXTxAqU10+hCjFqiFKmFLviy9+ek84
 XAxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788414772; x=1789019572;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fEazz1nkDaT5UFz2ceWV2jlVqHjpqNIgj/Y/2cpVwZ4=;
 b=WuGz/xDwLcBh8alHAKiWH6nwWtdfBwWb5RhNmjLlicZ5NFPNEVFwUiaGuYOnolBe6Y
 hV1bGv0RKZa+BRDsOMYCPylZq/XX0vNDegb563V/ptdmCpM9kZNxGCBThrPHkm4RhB1c
 CL48rYY0bCHrPiNaWqOQL8NJsqIwawa3c7vJzIAYlSdBKJaPVuHZHeSXnk7xR79S/F2f
 NlEaUJbLYZefYAkiXbLeC2bypa0uuZLskF4ho4tQW9mg8el/Ibo3FsoU4mhG/7t7uTem
 r3VC6vz1ySgMIvYIO6WvnGEJSs3cNLWWjTCBFMmC9DWUQ2wMJnm0kw5W99vmPtS6KRFd
 mUlg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzCzR5GAc/f0L6zUFBOXHywAraUtYdFQWh/o1ya+ViLjn6c6AleOr8mHT4enQbZqJ8le5IRewkQ7Jwe@nongnu.org
X-Gm-Message-State: AFuF++nPyEJiN0NlVEaI2XoSQnT0iW8BXAexCnSEBwcJziMJ8QaTqGlF
 tO1QNKpRDYh88/0RGNXr0SQ4jIpXoYUgMaDrrM4f1uIqpH0+pPY3CLmd
X-Gm-Gg: AYBFou3b/oJkjqnHm+XjNgFxGWVgCbrFIr7HnH9qUS+vVuBHX4HXTMh0KOKN0L2U7WY
 KflDuAeS0Th6ovRQ2+DPREG67Ka8eMKzPglxOqaLtjQP9LkVXONSLj0tUXfPrTkVr7UCxFQMXsY
 tL1MIgMWm1MZJ0u0FqwL+kgxjP830OFgO6fqObMdJA3eeIEXjmPYyDmA6YfTrm6IhP5GfqCmoPj
 iW3X/NUGVKfWfehF018bjfXkxD/NFaGISyWFDYWPQVuey+KbZYX593BTJV+UK1kMuWfyXFnG6LT
 8Z8JqDPbog+ti18R8AI7L2w9ciNckLn0yLoGhA+JTq3+l2/9C0pjng9vVMIy7t8XmrGiuIXGovJ
 htduvbxTuQ8TJ4AZcfE8iuytkrjstsCKbn17h7rAtxE+1zXdfPdg4vY8yfWZK4ZqDECOQdpvqUi
 aMHmjdqt1Ny9HJmrCkcycOlpgxQbWUgSkgFmBfIK9tSyRf6gbaqDaRYDNtvlVqQgw5VvGzFK21P
 VMyk0q54kr+yX/Ab5JqA+Fw0S9yUruhaoaWa1pcQC/LDYd/lQzxvlYsVFARIwK3XDd8XrB5GgdX
 ypZOSlIiQdcNzO/jHqqJ
X-Received: by 2002:a05:6a21:134b:b0:3c4:4272:b400 with SMTP id
 adf61e73a8af0-3d9ae8e1ee9mr16994282637.18.1788414771759; 
 Wed, 02 Sep 2026 22:52:51 -0700 (PDT)
Received: from donnager-debian.. ([180.150.112.50])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1431990a39bsm2770619c88.3.2026.09.02.22.52.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 22:52:50 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Michael Ellerman <mpe@kernel.org>,
 Portia Stephens <portias@oss.tenstorrent.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v3 05/16] hw/intc/sifive_plic: Take a MemoryRegion for the
 created device
Date: Thu,  3 Sep 2026 15:21:19 +0930
Message-ID: <20260903055131.257903-6-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260903055131.257903-1-joel@jms.id.au>
References: <20260903055131.257903-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=joel.stan@gmail.com; helo=mail-pf1-x435.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

sifive_plic_create() maps the device it creates into system_memory,
which prevents its use by SoCs that map devices into their own memory
container.

Add a MemoryRegion parameter and map the device into it instead of
calling sysbus_mmio_map(). All callers pass system_memory, so there is
no change in behaviour.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 include/hw/intc/sifive_plic.h | 4 ++--
 hw/intc/sifive_plic.c         | 7 ++++---
 hw/riscv/k230.c               | 3 ++-
 hw/riscv/microchip_pfsoc.c    | 3 ++-
 hw/riscv/shakti_c.c           | 3 ++-
 hw/riscv/sifive_e.c           | 2 +-
 hw/riscv/sifive_u.c           | 3 ++-
 hw/riscv/virt.c               | 1 +
 8 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/include/hw/intc/sifive_plic.h b/include/hw/intc/sifive_plic.h
index 32973dbf281e..064754c3f628 100644
--- a/include/hw/intc/sifive_plic.h
+++ b/include/hw/intc/sifive_plic.h
@@ -76,8 +76,8 @@ struct SiFivePLICState {
     qemu_irq *s_external_irqs;
 };
 
-DeviceState *sifive_plic_create(hwaddr addr, char *hart_config,
-    uint32_t num_harts,
+DeviceState *sifive_plic_create(MemoryRegion *container,
+    hwaddr addr, char *hart_config, uint32_t num_harts,
     uint32_t hartid_base, uint32_t num_sources,
     uint32_t num_priorities, uint32_t priority_base,
     uint32_t pending_base, uint32_t enable_base,
diff --git a/hw/intc/sifive_plic.c b/hw/intc/sifive_plic.c
index 9c84ff06a9fd..90f17e6ee724 100644
--- a/hw/intc/sifive_plic.c
+++ b/hw/intc/sifive_plic.c
@@ -473,8 +473,8 @@ type_init(sifive_plic_register_types)
 /*
  * Create PLIC device.
  */
-DeviceState *sifive_plic_create(hwaddr addr, char *hart_config,
-    uint32_t num_harts,
+DeviceState *sifive_plic_create(MemoryRegion *container,
+    hwaddr addr, char *hart_config, uint32_t num_harts,
     uint32_t hartid_base, uint32_t num_sources,
     uint32_t num_priorities, uint32_t priority_base,
     uint32_t pending_base, uint32_t enable_base,
@@ -499,7 +499,8 @@ DeviceState *sifive_plic_create(hwaddr addr, char *hart_config,
     qdev_prop_set_uint32(dev, "context-stride", context_stride);
     qdev_prop_set_uint32(dev, "aperture-size", aperture_size);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
-    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, addr);
+    memory_region_add_subregion(container, addr,
+        sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0));
 
     plic = SIFIVE_PLIC(dev);
 
diff --git a/hw/riscv/k230.c b/hw/riscv/k230.c
index 1ef4260c5391..6b0f0453c80b 100644
--- a/hw/riscv/k230.c
+++ b/hw/riscv/k230.c
@@ -134,7 +134,8 @@ static DeviceState *k230_create_plic(int base_hartid, int hartid_count)
     plic_hart_config = riscv_plic_hart_config_string(hartid_count);
 
     /* Per-socket PLIC */
-    return sifive_plic_create(memmap[K230_DEV_PLIC].base,
+    return sifive_plic_create(get_system_memory(),
+                              memmap[K230_DEV_PLIC].base,
                               plic_hart_config, hartid_count, base_hartid,
                               K230_PLIC_NUM_SOURCES,
                               K230_PLIC_NUM_PRIORITIES,
diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index a6026776d4de..1f6d9f5ae1ed 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -282,7 +282,8 @@ static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
     plic_hart_config = riscv_plic_hart_config_string(ms->smp.cpus);
 
     /* PLIC */
-    s->plic = sifive_plic_create(memmap[MICROCHIP_PFSOC_PLIC].base,
+    s->plic = sifive_plic_create(system_memory,
+        memmap[MICROCHIP_PFSOC_PLIC].base,
         plic_hart_config, ms->smp.cpus, 0,
         MICROCHIP_PFSOC_PLIC_NUM_SOURCES,
         MICROCHIP_PFSOC_PLIC_NUM_PRIORITIES,
diff --git a/hw/riscv/shakti_c.c b/hw/riscv/shakti_c.c
index 86ff8f8fcaab..62052bf7c61e 100644
--- a/hw/riscv/shakti_c.c
+++ b/hw/riscv/shakti_c.c
@@ -115,7 +115,8 @@ static void shakti_c_soc_state_realize(DeviceState *dev, Error **errp)
 
     sysbus_realize(SYS_BUS_DEVICE(&sss->cpus), &error_abort);
 
-    sss->plic = sifive_plic_create(shakti_c_memmap[SHAKTI_C_PLIC].base,
+    sss->plic = sifive_plic_create(system_memory,
+        shakti_c_memmap[SHAKTI_C_PLIC].base,
         (char *)SHAKTI_C_PLIC_HART_CONFIG, ms->smp.cpus, 0,
         SHAKTI_C_PLIC_NUM_SOURCES,
         SHAKTI_C_PLIC_NUM_PRIORITIES,
diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
index 0ea444f43bc5..81d7995ddcfb 100644
--- a/hw/riscv/sifive_e.c
+++ b/hw/riscv/sifive_e.c
@@ -214,7 +214,7 @@ static void sifive_e_soc_realize(DeviceState *dev, Error **errp)
         memmap[SIFIVE_E_DEV_MROM].base, &s->mask_rom);
 
     /* MMIO */
-    s->plic = sifive_plic_create(memmap[SIFIVE_E_DEV_PLIC].base,
+    s->plic = sifive_plic_create(sys_mem, memmap[SIFIVE_E_DEV_PLIC].base,
         (char *)SIFIVE_E_PLIC_HART_CONFIG, ms->smp.cpus, 0,
         SIFIVE_E_PLIC_NUM_SOURCES,
         SIFIVE_E_PLIC_NUM_PRIORITIES,
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 6bbf2c4504d8..632194a06ea1 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -774,7 +774,8 @@ static void sifive_u_soc_realize(DeviceState *dev, Error **errp)
     plic_hart_config = riscv_plic_hart_config_string(ms->smp.cpus);
 
     /* MMIO */
-    s->plic = sifive_plic_create(memmap[SIFIVE_U_DEV_PLIC].base,
+    s->plic = sifive_plic_create(system_memory,
+        memmap[SIFIVE_U_DEV_PLIC].base,
         plic_hart_config, ms->smp.cpus, 0,
         SIFIVE_U_PLIC_NUM_SOURCES,
         SIFIVE_U_PLIC_NUM_PRIORITIES,
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 8fd742181e28..a7b5af4e4c88 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -561,6 +561,7 @@ static DeviceState *virt_create_plic(const MemMapEntry *memmap, int socket,
 
     /* Per-socket PLIC */
     return sifive_plic_create(
+             get_system_memory(),
              memmap[VIRT_PLIC].base + socket * memmap[VIRT_PLIC].size,
              plic_hart_config, hart_count, base_hartid,
              VIRT_IRQCHIP_NUM_SOURCES,
-- 
2.47.3


