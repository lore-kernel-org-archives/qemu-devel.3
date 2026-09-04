Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E07A9C79F80
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 05:22:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2MN9-0001yS-Uc; Fri, 04 Sep 2026 01:21:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1x2MN6-0001fP-1I
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 01:21:53 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1x2MN3-0001Tz-UR
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 01:21:51 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-852c481415fso617219b3a.3
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 22:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788499308; x=1789104108; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1AJlQQl2lGGGEThdzd1vHf5VHQwoFN0axGoGG12sW6E=;
 b=VCoKhF9vAG5bF8X6Q2Qd1hb88vpTvw1AR3Nd5Uo6uMM8EY2kxMWKH0mu62xWCO9QmU
 Y7i5Psye5hy2x16ZHxTfFmfY2rO2VsElHjEpxFeYdAvPw4MvXVNK34ybOLE+0bk9NqvK
 2r4u2/PJxAbBtqCYLOFgEi556/wn4HKtmbxNQKiuYdAoRnem4LBJeqFxDOwo9wIBHpqo
 9700lzVPkiGuUOWr0cGdzl2onxO2n8JAcoHANxyoIskeMOxXbfvZsApYOpJhnJ2VKtjw
 acmc2doBid1di30IW3rE5op2IgcU/EOs7IwwYAnu+nlwcQIBhzcob9STCyZ3fEJa/n4W
 UMrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788499308; x=1789104108;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1AJlQQl2lGGGEThdzd1vHf5VHQwoFN0axGoGG12sW6E=;
 b=m88W7XD4KdhUn/lYEQA1aVm9Lmer6eNLIrOIETznaGRAbSf6baKv0KJZywwR4ES5A3
 xBKGkwnuK0rTholoMNzuOspFfETFvlxG8efu088jUFQkfkl5wtRS4XyX1e+Ef8ANxxQE
 2SRoFWPYblP12+lLS8qxLsYwJmIQ7PCnye29BOKf47fGRyd1Ky1/mNfAIpiZv+GFzVNw
 R/oO0jeJScKjgTEJj3vww6nun7ze0H+8Z3I8gUC0Vp13FPTvY5kHuHFRumOnQUS4QW4B
 qg8Jwy61egBdhFVCghSQvqA+wMJwbLuv+WsKRiVWK1KV8BNqlsf3J/U8oh2ct+3b7MFl
 Ckbg==
X-Gm-Message-State: AFuF++lMH8T6IT8U+Fpxn6yxwqjvVCR/Iou/h/xPDKTza8zaJqSIG1cO
 bfqnyk6Kd6/YDXh9KCVo7vWd51LlTmftqymfoNt8Bu4KXVYug7gTfFVQhMDg+A==
X-Gm-Gg: AYBFou0fCVqa3Zqj5UkcyHq96qyx/miSjvisJGI3ob1xsP8PvYNvAlVo6PAnUafnNFo
 C9+yZ8EaZBtn83foTN87m9EvN1M5bdopC08ftqythtctfePwoQBIYRUyNnfNstS1K0bimO2ravN
 Hus2kwlvgj6CM1FMRb7qm29HDJ6SScYbjnQNhbHXu0jZicrQ0zxVEMhEbUtI/itzGORj9RJCJnL
 FhwekY9AF3CUL+AAWWGVnCu6kw8NRnpYj+xWsuso8039JWsfSqCtgDzQ27uNjq/zThI8idgT6Wm
 RbSuDpmIbyJGoPUn2OMPBDYERj95NNyUuxmcedG1DeDFYlpJxCvHVLqG0uJ0OZHw4Q7QHcKd084
 hdMLTJpQ61yIkZhiKdgs9ncVqRlxIIOHpytKbluci/t7bfr0QpZhKI3lltU/bfXDAO2SBOpCHkq
 ULXhQUK4YBS7qRQfUByUCMu0L93qZpU3ZC7ZAVnvOTfs13B8dpsOYGEjsKR9qm/EUw2SFgOLFIj
 8thsg==
X-Received: by 2002:a05:6a00:4c96:b0:857:7337:5db8 with SMTP id
 d2e1a72fcca58-8616ae4e171mr5516928b3a.22.1788499308452; 
 Thu, 03 Sep 2026 22:21:48 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc455445e34sm402147a12.15.2026.09.03.22.21.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 22:21:47 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Chao Liu <chao.liu@processmission.com>
Subject: [PULL 36/47] hw/intc/sifive_plic: Take a MemoryRegion for the created
 device
Date: Fri,  4 Sep 2026 15:19:32 +1000
Message-ID: <20260904051943.799041-37-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904051943.799041-1-alistair.francis@wdc.com>
References: <20260904051943.799041-1-alistair.francis@wdc.com>
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

From: Joel Stanley <joel@jms.id.au>

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
Reviewed-by: Chao Liu <chao.liu@processmission.com>
Message-ID: <20260903055131.257903-6-joel@jms.id.au>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
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
index 32973dbf28..064754c3f6 100644
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
index 9c84ff06a9..90f17e6ee7 100644
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
index 309619dabf..1e4ca38579 100644
--- a/hw/riscv/k230.c
+++ b/hw/riscv/k230.c
@@ -133,7 +133,8 @@ static DeviceState *k230_create_plic(int base_hartid, int hartid_count)
     plic_hart_config = riscv_plic_hart_config_string(hartid_count);
 
     /* Per-socket PLIC */
-    return sifive_plic_create(memmap[K230_DEV_PLIC].base,
+    return sifive_plic_create(get_system_memory(),
+                              memmap[K230_DEV_PLIC].base,
                               plic_hart_config, hartid_count, base_hartid,
                               K230_PLIC_NUM_SOURCES,
                               K230_PLIC_NUM_PRIORITIES,
diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index d34d8182b1..edd29626fa 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -281,7 +281,8 @@ static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
     plic_hart_config = riscv_plic_hart_config_string(ms->smp.cpus);
 
     /* PLIC */
-    s->plic = sifive_plic_create(memmap[MICROCHIP_PFSOC_PLIC].base,
+    s->plic = sifive_plic_create(system_memory,
+        memmap[MICROCHIP_PFSOC_PLIC].base,
         plic_hart_config, ms->smp.cpus, 0,
         MICROCHIP_PFSOC_PLIC_NUM_SOURCES,
         MICROCHIP_PFSOC_PLIC_NUM_PRIORITIES,
diff --git a/hw/riscv/shakti_c.c b/hw/riscv/shakti_c.c
index 4f99d78327..3b6efd25be 100644
--- a/hw/riscv/shakti_c.c
+++ b/hw/riscv/shakti_c.c
@@ -113,7 +113,8 @@ static void shakti_c_soc_state_realize(DeviceState *dev, Error **errp)
 
     sysbus_realize(SYS_BUS_DEVICE(&sss->cpus), &error_abort);
 
-    sss->plic = sifive_plic_create(shakti_c_memmap[SHAKTI_C_PLIC].base,
+    sss->plic = sifive_plic_create(system_memory,
+        shakti_c_memmap[SHAKTI_C_PLIC].base,
         (char *)SHAKTI_C_PLIC_HART_CONFIG, ms->smp.cpus, 0,
         SHAKTI_C_PLIC_NUM_SOURCES,
         SHAKTI_C_PLIC_NUM_PRIORITIES,
diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
index fa77f28152..35ed7f42a4 100644
--- a/hw/riscv/sifive_e.c
+++ b/hw/riscv/sifive_e.c
@@ -212,7 +212,7 @@ static void sifive_e_soc_realize(DeviceState *dev, Error **errp)
         memmap[SIFIVE_E_DEV_MROM].base, &s->mask_rom);
 
     /* MMIO */
-    s->plic = sifive_plic_create(memmap[SIFIVE_E_DEV_PLIC].base,
+    s->plic = sifive_plic_create(sys_mem, memmap[SIFIVE_E_DEV_PLIC].base,
         (char *)SIFIVE_E_PLIC_HART_CONFIG, ms->smp.cpus, 0,
         SIFIVE_E_PLIC_NUM_SOURCES,
         SIFIVE_E_PLIC_NUM_PRIORITIES,
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 0f0370b8c5..b7d5e7b4da 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -772,7 +772,8 @@ static void sifive_u_soc_realize(DeviceState *dev, Error **errp)
     plic_hart_config = riscv_plic_hart_config_string(ms->smp.cpus);
 
     /* MMIO */
-    s->plic = sifive_plic_create(memmap[SIFIVE_U_DEV_PLIC].base,
+    s->plic = sifive_plic_create(system_memory,
+        memmap[SIFIVE_U_DEV_PLIC].base,
         plic_hart_config, ms->smp.cpus, 0,
         SIFIVE_U_PLIC_NUM_SOURCES,
         SIFIVE_U_PLIC_NUM_PRIORITIES,
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 186d266b29..f3a1cc5ba3 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -560,6 +560,7 @@ static DeviceState *virt_create_plic(const MemMapEntry *memmap, int socket,
 
     /* Per-socket PLIC */
     return sifive_plic_create(
+             get_system_memory(),
              memmap[VIRT_PLIC].base + socket * memmap[VIRT_PLIC].size,
              plic_hart_config, hart_count, base_hartid,
              VIRT_IRQCHIP_NUM_SOURCES,
-- 
2.55.0


