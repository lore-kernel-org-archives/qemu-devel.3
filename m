Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E200CCCA476
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 14:18:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v68QF-0005kh-W8; Tue, 07 Oct 2025 10:12:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v68QD-0005jM-R5
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:12:10 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v68Pw-0002Ao-Sz
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:12:09 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-46e33b260b9so60036305e9.2
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 07:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759846307; x=1760451107; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YvaAiIpUTRX/gYF6Gfnj94PkiqKiJfkJbqMb6/0vpZg=;
 b=XCszyjYtlfBm3cwd96yxW2HCSU+PqJV6FklFlUB2RK4P8v0RC+/lOeCYRWLB/ffWlf
 txLHB7RZ59YHDs0WENuH/pPWi5kC4a0Y/jVhL5w9bDfrr2CheOT+ZnY7CqgYAY2nNutZ
 I1hterN39xGAOjuejYDszg7DXoibON5/Z5D9+Ku1rdzM9z0uJo30AEbxh082ph3kmxqj
 enlwoKAvwXH5OxcJjuCpydj/vVvTZd8883hjuzYfaYVXhojC2pIIsFJ+t7FAvAcduM94
 tJruyvlqjiXZo2zO7Rxj2FWl5pTbreJVASjc5dx9DOUKnqHgkWAxLMqVU3kPxPpQbi2t
 B8NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759846307; x=1760451107;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YvaAiIpUTRX/gYF6Gfnj94PkiqKiJfkJbqMb6/0vpZg=;
 b=dHE4dn+sLxopnLi1/DRRwt7mmzG1eLAqtj56NGiezxqCa//rdl6X6M7bPWDHhHH/E3
 iMtejjAWV6d4vM+smKA3HLBWDDi2pcvMNV9FHOcZoqr0c+J2/+loE7Khr/7M/Pbu4LoK
 YOS3CNVQIa9DPLd8pOpKNljiA2eJycqfM39j4s9nHTQo5Dd7dEgOhd/PKrS/tV2XVNpl
 oY+EpP5RVmJDYGRMPUevfusCeUwbqQ8wiXaLBysYF3FKqP7fQsla/YgfHyH0lZ2bduVT
 yq+wHnT7UfXXDlBUlkKU8e6N5JfxZ5Yv9SfC1vj03DG2bGxKUom7LBGJSgkn0dEzpjAq
 YwSw==
X-Gm-Message-State: AOJu0YyxWjOPCQANt9uKscBjisR6vpTmd+OUZbF/xgBYSpdxMvt0/bVQ
 aMQDk7OqmfYrV3/QqAl4m4c1U/ynfyiQIf9kDqanTd04Do/wmp89q3uVeQOGNxhc64Ufv7Aj9Dk
 coQ17
X-Gm-Gg: ASbGncvLbbi1uinUFTOg6i09PDEkXPPlKogiUomZlsAkxi/tGycsVasx9R6EFzrW7PO
 LJlPAxVpafA/AiMB6ZA29bHwmgghVRuDWFtFtZGfvwXXJl1lejksblEaSiJeJi3hmtFqSy96yLJ
 g1Wi1lnCOTjhf4s+SWBcHvXRl1dTGP+KsgKbVA+E+DvAtthcmr+mufgGxZf4IoPSCbfk1Syo39b
 qDMwAtBM0wwOAehMoasVwuQ0A60vYnmsM4HYPSGBL3gb1IKJbiQRll4RqxAgZot1Ozn4K5s83pb
 2jptbMkyasGRVpQYcyxrdC/iYUcI6YQU0URBx70VYN5393GU0RPHudZfciZX+syydYRdOLBYS2c
 nBAn2yUPzci/FcmwKk9XDKUlLRVg5B9bjbNgq90EuJhYMOHlFKn1+8t4ipJwrh9cIPLk=
X-Google-Smtp-Source: AGHT+IG/6X7UbulqBZqSNBJpBZbETjkcCa5R6gBGoXoUn1CWIamGYybT+R+kf7YMFU4g8Pidp8qoZA==
X-Received: by 2002:a05:600c:46d1:b0:46e:4c02:c2f9 with SMTP id
 5b1f17b1804b1-46e71157990mr114133035e9.36.1759846306773; 
 Tue, 07 Oct 2025 07:11:46 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e78c5d290sm167037135e9.0.2025.10.07.07.11.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Oct 2025 07:11:46 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 20/62] hw/arm/xlnx-versal-virt: virtio: refactor creation
Date: Tue,  7 Oct 2025 15:10:40 +0100
Message-ID: <20251007141123.3239867-21-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251007141123.3239867-1-peter.maydell@linaro.org>
References: <20251007141123.3239867-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

From: Luc Michel <luc.michel@amd.com>

Refactor the creation of virtio devices. Use the accessors provided by
the Versal SoC to retrieve the reserved MMIO and IRQ space. Those are
defined in the VersalMap structure.

Signed-off-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20250926070806.292065-20-luc.michel@amd.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/xlnx-versal.h |  3 +++
 hw/arm/xlnx-versal-virt.c    | 31 ++++++++++++-------------------
 hw/arm/xlnx-versal.c         | 26 ++++++++++++++++++++++++++
 3 files changed, 41 insertions(+), 19 deletions(-)

diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
index d3ce13e69de..af47acb288f 100644
--- a/include/hw/arm/xlnx-versal.h
+++ b/include/hw/arm/xlnx-versal.h
@@ -102,6 +102,9 @@ void versal_bbram_attach_drive(Versal *s, BlockBackend *blk);
 void versal_ospi_create_flash(Versal *s, int flash_idx, const char *flash_mdl,
                               BlockBackend *blk);
 
+qemu_irq versal_get_reserved_irq(Versal *s, int idx, int *dtb_idx);
+hwaddr versal_get_reserved_mmio_addr(Versal *s);
+
 int versal_get_num_can(VersalVersion version);
 int versal_get_num_sdhci(VersalVersion version);
 
diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index d96f3433929..b981d012558 100644
--- a/hw/arm/xlnx-versal-virt.c
+++ b/hw/arm/xlnx-versal-virt.c
@@ -271,37 +271,30 @@ static void create_virtio_regions(VersalVirt *s)
     int i;
 
     for (i = 0; i < NUM_VIRTIO_TRANSPORT; i++) {
-        char *name = g_strdup_printf("virtio%d", i);
-        hwaddr base = MM_TOP_RSVD + i * virtio_mmio_size;
-        int irq = VERSAL_RSVD_IRQ_FIRST + i;
+        hwaddr base = versal_get_reserved_mmio_addr(&s->soc)
+            + i * virtio_mmio_size;
+        g_autofree char *node = g_strdup_printf("/virtio_mmio@%" PRIx64, base);
+        int dtb_irq;
         MemoryRegion *mr;
         DeviceState *dev;
         qemu_irq pic_irq;
 
-        pic_irq = qdev_get_gpio_in(DEVICE(&s->soc.fpd.apu.gic), irq);
+        pic_irq = versal_get_reserved_irq(&s->soc, i, &dtb_irq);
         dev = qdev_new("virtio-mmio");
-        object_property_add_child(OBJECT(&s->soc), name, OBJECT(dev));
+        object_property_add_child(OBJECT(s), "virtio-mmio[*]", OBJECT(dev));
         sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
         sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, pic_irq);
         mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
         memory_region_add_subregion(&s->soc.mr_ps, base, mr);
-        g_free(name);
-    }
 
-    for (i = 0; i < NUM_VIRTIO_TRANSPORT; i++) {
-        hwaddr base = MM_TOP_RSVD + i * virtio_mmio_size;
-        int irq = VERSAL_RSVD_IRQ_FIRST + i;
-        char *name = g_strdup_printf("/virtio_mmio@%" PRIx64, base);
-
-        qemu_fdt_add_subnode(s->fdt, name);
-        qemu_fdt_setprop(s->fdt, name, "dma-coherent", NULL, 0);
-        qemu_fdt_setprop_cells(s->fdt, name, "interrupts",
-                               GIC_FDT_IRQ_TYPE_SPI, irq,
+        qemu_fdt_add_subnode(s->fdt, node);
+        qemu_fdt_setprop(s->fdt, node, "dma-coherent", NULL, 0);
+        qemu_fdt_setprop_cells(s->fdt, node, "interrupts",
+                               GIC_FDT_IRQ_TYPE_SPI, dtb_irq,
                                GIC_FDT_IRQ_FLAGS_EDGE_LO_HI);
-        qemu_fdt_setprop_sized_cells(s->fdt, name, "reg",
+        qemu_fdt_setprop_sized_cells(s->fdt, node, "reg",
                                      2, base, 2, virtio_mmio_size);
-        qemu_fdt_setprop_string(s->fdt, name, "compatible", "virtio,mmio");
-        g_free(name);
+        qemu_fdt_setprop_string(s->fdt, node, "compatible", "virtio,mmio");
     }
 }
 
diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index f5f98a3030d..23aac709dc4 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -154,6 +154,13 @@ typedef struct VersalMap {
     } cfu;
 
     VersalSimplePeriphMap crl;
+
+    /* reserved MMIO/IRQ space that can safely be used for virtio devices */
+    struct VersalReserved {
+        uint64_t mmio_start;
+        int irq_start;
+        int irq_num;
+    } reserved;
 } VersalMap;
 
 static const VersalMap VERSAL_MAP = {
@@ -220,6 +227,8 @@ static const VersalMap VERSAL_MAP = {
     },
 
     .crl = { 0xff5e0000, 10 },
+
+    .reserved = { 0xa0000000, 111, 8 },
 };
 
 static const VersalMap *VERSION_TO_MAP[] = {
@@ -1422,6 +1431,23 @@ void versal_ospi_create_flash(Versal *s, int flash_idx, const char *flash_mdl,
                        flash_idx + 1, cs_line);
 }
 
+qemu_irq versal_get_reserved_irq(Versal *s, int idx, int *dtb_idx)
+{
+    const VersalMap *map = versal_get_map(s);
+
+    g_assert(idx < map->reserved.irq_num);
+
+    *dtb_idx = map->reserved.irq_start + idx;
+    return versal_get_irq(s, *dtb_idx);
+}
+
+hwaddr versal_get_reserved_mmio_addr(Versal *s)
+{
+    const VersalMap *map = versal_get_map(s);
+
+    return map->reserved.mmio_start;
+}
+
 int versal_get_num_can(VersalVersion version)
 {
     const VersalMap *map = VERSION_TO_MAP[version];
-- 
2.43.0


