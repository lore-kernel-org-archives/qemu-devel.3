Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA60AC47DDB
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 16:11:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUUDZ-0007uk-Fr; Mon, 29 Jan 2024 11:10:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rUUDY-0007tw-3H
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 11:10:40 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rUUDW-0002ft-8l
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 11:10:39 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-33ae42033e2so1601927f8f.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 08:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706544636; x=1707149436; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mowSEhOgZzKcBJ9VgVtTRlxzjWwdK68BxpCMYQUxiN0=;
 b=lmcCmhTHDetvdOhRlWjNYi1CZdPAaeTIPyXhq2T2hE+OUX1FY4czayaWTVUbT7hRaw
 qSNfHuQX6k07s2qFHuoNCqJ1HXPpipIM17/nl3h/mCvhkTir7yBbDDGSRllNilR89v4C
 ozO7HCnKqx2AurLg42N+1wZGbQzYkD05jCfahdDCuTUi5kqRdg0y9wopa0UBeQo19d6P
 yXO1+MUAdIsSxfqej9tTuy4jvFaA7NEGRJ9c3UbOoxY2DGFK/Ddjkqy8CiE4XUHsptJ4
 RpOofLM4IJAJi2F4THkIClK/mLKsBmKqkJLKT55yomM7EBKzdFigoeJ6m9hr+EHbTi4o
 wc1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706544636; x=1707149436;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mowSEhOgZzKcBJ9VgVtTRlxzjWwdK68BxpCMYQUxiN0=;
 b=rrouMjA/74+8yEjvT5FY3DTgdAaZRFAhWIw1ecDPhKotxXrn6JkBJfVPB79X8xug9G
 QKDEOGrfRx1SVpknDkY3Jqx3RVNxKi0b2M0IjlxkGdAOU0Q6NS5AUkrhOrM2ZF12ZrUA
 fTJuKkxPwuCKxsfdcwmOj3GdkDFhgTl5eCNMBRD+49Y/kueptrkLDIco9IlaRCHj9/Q1
 eO5ePIiraNrIF1s+Y8GVHkCym1uynneNiHYrfeh9WU46880pgmt8ecKrV6CCwXoMJjVo
 wvlghdSH8bSmVINttLK0u8t/Sa6kMAiO4bTj6mYPX6CqFqKSl/PipDCS2LhHHMXuPgEm
 OiLg==
X-Gm-Message-State: AOJu0Yw/1Z8Q8wmvFmbvbJ3VFQlNCXFrzkeC/NqeQUa/ytCn92l23dOk
 25vcwpbza/n8RcRxcQLwCzMXY0e40eYFO0KhQWLkSIhjeNu3XAQGf2WhfuhO1wXB/9cRFPNB16z
 lado=
X-Google-Smtp-Source: AGHT+IHJwGRqrJQIzllR5ddrn3Ul9ubdSRjAryKPH1AK1kiGYvbhTuS0azJwZJUfuup1+2wfPCWY3w==
X-Received: by 2002:a05:6000:1544:b0:33a:ed19:9f37 with SMTP id
 4-20020a056000154400b0033aed199f37mr3033204wry.47.1706544636095; 
 Mon, 29 Jan 2024 08:10:36 -0800 (PST)
Received: from localhost.localdomain (adsl-245.37.6.163.tellas.gr.
 [37.6.163.245]) by smtp.gmail.com with ESMTPSA id
 co6-20020a0560000a0600b0033af4df8e1esm1219957wrb.47.2024.01.29.08.10.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 08:10:35 -0800 (PST)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	qemu-block@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v3 3/6] hw/arm/xen_arm.c: convert DPRINTF to trace events and
 error/warn reports
Date: Mon, 29 Jan 2024 18:09:38 +0200
Message-Id: <fe5e3bd54231abe933f95a24e0e88208cd8cfd8f.1706544115.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1706544115.git.manos.pitsidianakis@linaro.org>
References: <cover.1706544115.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Tracing DPRINTFs to stderr might not be desired. A developer that relies
on trace events should be able to opt-in to each trace event and rely on
QEMU's log redirection, instead of stderr by default.

This commit converts DPRINTFs in this file that are used for tracing
into trace events. Errors or warnings are converted to error_report and
warn_report calls.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/arm/trace-events |  5 +++++
 hw/arm/xen_arm.c    | 23 +++++++++++------------
 2 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index 0ff41e6c78..fd0d92762e 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -65,3 +65,8 @@ z2_lcd_enable_disable_result(const char *result) "LCD %s"
 z2_aer915_send_too_long(int8_t msg) "message too long (%i bytes)"
 z2_aer915_send(uint8_t reg, uint8_t value) "reg %d value 0x%02x"
 z2_aer915_event(int8_t event, int8_t len) "i2c event =0x%x len=%d bytes"
+
+# xen_arm.c
+xen_create_virtio_mmio_devices(int i, int irq, uint64_t base) "Created virtio-mmio device %d: irq %d base 0x%"PRIx64
+xen_init_ram(uint64_t machine_ram_size) "Initialized xen ram with size 0x%"PRIx64
+xen_enable_tpm(uint64_t addr) "Connected tpmdev at address 0x%"PRIx64
diff --git a/hw/arm/xen_arm.c b/hw/arm/xen_arm.c
index a5631529d0..32776d94df 100644
--- a/hw/arm/xen_arm.c
+++ b/hw/arm/xen_arm.c
@@ -34,6 +34,7 @@
 #include "hw/xen/xen-hvm-common.h"
 #include "sysemu/tpm.h"
 #include "hw/xen/arch_hvm.h"
+#include "trace.h"
 
 #define TYPE_XEN_ARM  MACHINE_TYPE_NAME("xenpvh")
 OBJECT_DECLARE_SIMPLE_TYPE(XenArmState, XEN_ARM)
@@ -91,8 +92,9 @@ static void xen_create_virtio_mmio_devices(XenArmState *xam)
 
         sysbus_create_simple("virtio-mmio", base, irq);
 
-        DPRINTF("Created virtio-mmio device %d: irq %d base 0x%lx\n",
-                i, GUEST_VIRTIO_MMIO_SPI_FIRST + i, base);
+        trace_xen_create_virtio_mmio_devices(i,
+                                             GUEST_VIRTIO_MMIO_SPI_FIRST + i,
+                                             base);
     }
 }
 
@@ -101,6 +103,7 @@ static void xen_init_ram(MachineState *machine)
     MemoryRegion *sysmem = get_system_memory();
     ram_addr_t block_len, ram_size[GUEST_RAM_BANKS];
 
+    trace_xen_init_ram(machine->ram_size);
     if (machine->ram_size <= GUEST_RAM0_SIZE) {
         ram_size[0] = machine->ram_size;
         ram_size[1] = 0;
@@ -117,15 +120,10 @@ static void xen_init_ram(MachineState *machine)
     memory_region_init_alias(&ram_lo, NULL, "xen.ram.lo", &ram_memory,
                              GUEST_RAM0_BASE, ram_size[0]);
     memory_region_add_subregion(sysmem, GUEST_RAM0_BASE, &ram_lo);
-    DPRINTF("Initialized region xen.ram.lo: base 0x%llx size 0x%lx\n",
-            GUEST_RAM0_BASE, ram_size[0]);
-
     if (ram_size[1] > 0) {
         memory_region_init_alias(&ram_hi, NULL, "xen.ram.hi", &ram_memory,
                                  GUEST_RAM1_BASE, ram_size[1]);
         memory_region_add_subregion(sysmem, GUEST_RAM1_BASE, &ram_hi);
-        DPRINTF("Initialized region xen.ram.hi: base 0x%llx size 0x%lx\n",
-                GUEST_RAM1_BASE, ram_size[1]);
     }
 }
 
@@ -158,7 +156,7 @@ static void xen_enable_tpm(XenArmState *xam)
 
     TPMBackend *be = qemu_find_tpm_be("tpm0");
     if (be == NULL) {
-        DPRINTF("Couldn't fine the backend for tpm0\n");
+        error_report("Couldn't find tmp0 backend");
         return;
     }
     dev = qdev_new(TYPE_TPM_TIS_SYSBUS);
@@ -168,7 +166,7 @@ static void xen_enable_tpm(XenArmState *xam)
     sysbus_realize_and_unref(busdev, &error_fatal);
     sysbus_mmio_map(busdev, 0, xam->cfg.tpm_base_addr);
 
-    DPRINTF("Connected tpmdev at address 0x%lx\n", xam->cfg.tpm_base_addr);
+    trace_xen_enable_tpm(xam->cfg.tpm_base_addr);
 }
 #endif
 
@@ -179,8 +177,9 @@ static void xen_arm_init(MachineState *machine)
     xam->state =  g_new0(XenIOState, 1);
 
     if (machine->ram_size == 0) {
-        DPRINTF("ram_size not specified. QEMU machine started without IOREQ"
-                "(no emulated devices including Virtio)\n");
+        warn_report("%s non-zero ram size not specified. QEMU machine started"
+                    " without IOREQ (no emulated devices including virtio)",
+                    MACHINE_CLASS(object_get_class(OBJECT(machine)))->desc);
         return;
     }
 
@@ -194,7 +193,7 @@ static void xen_arm_init(MachineState *machine)
     if (xam->cfg.tpm_base_addr) {
         xen_enable_tpm(xam);
     } else {
-        DPRINTF("tpm-base-addr is not provided. TPM will not be enabled\n");
+        warn_report("tpm-base-addr is not provided. TPM will not be enabled");
     }
 #endif
 }
-- 
γαῖα πυρί μιχθήτω


