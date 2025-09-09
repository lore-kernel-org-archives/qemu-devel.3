Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6F3CCAC582
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 22:16:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uw6a7-0007Vx-Ff; Tue, 09 Sep 2025 18:12:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3DKbAaAYKCqcfbIPUgNVVNSL.JVTXLTb-KLcLSUVUNUb.VYN@flex--yubinz.bounces.google.com>)
 id 1uw6Yy-0007F1-QK
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 18:11:44 -0400
Received: from mail-pl1-x64a.google.com ([2607:f8b0:4864:20::64a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3DKbAaAYKCqcfbIPUgNVVNSL.JVTXLTb-KLcLSUVUNUb.VYN@flex--yubinz.bounces.google.com>)
 id 1uw6Yj-0004z0-Eh
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 18:11:40 -0400
Received: by mail-pl1-x64a.google.com with SMTP id
 d9443c01a7336-24458345f5dso85438635ad.3
 for <qemu-devel@nongnu.org>; Tue, 09 Sep 2025 15:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1757455885; x=1758060685; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=y1f9cfNY7Q/+WX35vwzn1MYw5xAv3EW6lz/FRvicoaE=;
 b=dph3YlkMIDWoOc2VLeMVUW4fV+Jfhci6QXEz+fVcHvtPj5Qm9HoeWyioqNBVw8oK/J
 iX0RpWAbModiQNNtT/ubhB2WChaHet0AaGK9bpXw+yoEtxHJv6rGcX7fMN04sARnDWsY
 qwcZuaCDba2vKLEZXzt4W6T0BYrfzJ0qqxiJk/7cWj55J5HkuwlaB1VdFS2OGoCHbHda
 YTpE4S+QClmCNTPhRyHU1+C8hn7jJmGSxfx6Aq/+EPOjQk4p2GtE9t/Mln8D3nHcxWft
 cjBlYpZcR7AefbcRhkabcel2ZSnzMJdqY1bCvfoAnDK4spHFJsuBJPyiKkSQggwoMCrC
 uz/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757455885; x=1758060685;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=y1f9cfNY7Q/+WX35vwzn1MYw5xAv3EW6lz/FRvicoaE=;
 b=cM972Zn0QhHyMelWtqtHySVLDptqavO3GdpNQt0w098ZMhjVAf2+MxDMlWkVU1l91l
 qepa0kHoFiHG+7S1FlwCd7j2198KNFy6TcGUO+u4OWHsGE1ntEtG4aNdsEL/UlnLtO9C
 csXsiq1OA4qslucoZuuv2MJXylSvDSOzyoKx0ZZJGXyduw5uoJsckAdxFFZ/yLBk65Ls
 dJHlZJwcg5+fOD7fBR8vjxFjlmy7ZtAnrQhAo2fOBjM5iMzJmbC573PMJVvRfSFf44xv
 VDnJ+bsHrmcpdMSPF33umz8XAQtuyDfFPigQbAowJ1z4tXL0stXr6QgOSBQeOpMAVIsS
 HDeg==
X-Gm-Message-State: AOJu0Yyi1COTWKNwNp370dmfp+4ra7kl+n1AzvSGB9YQC1Q1bAcHQZe9
 Zwkmc4GKk2Xq03yeTTcKGcxZ5r9cTep0i327HKXUxZA2FTGXpU4LgdOgLDPCOnwJ46aBEeaOCM6
 oNUn1GR3TK4FU4ibLFtrE0O2O+fKk8934U5cgU/6Zxdhu/z8um6GWyU4Fi3tpb7n/fzopTL0W89
 DgZwtQbCpo7pE1MlSNbIGVmfuvqxCjxhAXPFU=
X-Google-Smtp-Source: AGHT+IHpdvROGTyuB+3jBjukxYZIPmSpzYVyGYExF2kJfi3Ecdr2K2qeAL67tjQb9npMaPlbGBEyQJCv3Pw=
X-Received: from plgv4.prod.google.com ([2002:a17:902:e8c4:b0:248:dc48:282b])
 (user=yubinz job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:cf04:b0:248:79d4:93ae
 with SMTP id d9443c01a7336-25172291a1dmr147543265ad.33.1757455884979; Tue, 09
 Sep 2025 15:11:24 -0700 (PDT)
Date: Tue, 09 Sep 2025 22:10:57 +0000
In-Reply-To: <20250909-pcie-root-upstream-v1-0-d85883b2688d@google.com>
Mime-Version: 1.0
References: <20250909-pcie-root-upstream-v1-0-d85883b2688d@google.com>
X-Mailer: b4 0.14.2
Message-ID: <20250909-pcie-root-upstream-v1-2-d85883b2688d@google.com>
Subject: [PATCH 2/7] hw/pci-host: add basic Nuvoton PCIe window support
From: Yubin Zou <yubinz@google.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Tyrone Ting <kfting@nuvoton.com>, 
 Hao Wu <wuhaotsh@google.com>, qemu-arm@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>, Yubin Zou <yubinz@google.com>, 
 Titus Rwantare <titusr@google.com>
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::64a;
 envelope-from=3DKbAaAYKCqcfbIPUgNVVNSL.JVTXLTb-KLcLSUVUNUb.VYN@flex--yubinz.bounces.google.com;
 helo=mail-pl1-x64a.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 09 Sep 2025 18:12:49 -0400
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

From: Titus Rwantare <titusr@google.com>

Adds the windowing registers without address translation

Signed-off-by: Titus Rwantare <titusr@google.com>
---
 hw/pci-host/npcm_pcierc.c         | 223 +++++++++++++++++++++++++++++++++++++-
 include/hw/pci-host/npcm_pcierc.h |  77 ++++++++++++-
 2 files changed, 297 insertions(+), 3 deletions(-)

diff --git a/hw/pci-host/npcm_pcierc.c b/hw/pci-host/npcm_pcierc.c
index 3afe92e264f6ce4312e94f05b5e908840008df64..bffdec71acaba6562856b3bdd8aec07c3c153323 100644
--- a/hw/pci-host/npcm_pcierc.c
+++ b/hw/pci-host/npcm_pcierc.c
@@ -16,6 +16,193 @@
 #include "qom/object.h"
 #include "trace.h"
 
+/* Map enabled windows to a memory subregion */
+static void npcm_pcierc_map_enabled(NPCMPCIERCState *s, NPCMPCIEWindow *w)
+{
+    MemoryRegion *system = get_system_memory();
+    uint32_t size = NPCM_PCIERC_SAL_SIZE(w->sal);
+    hwaddr bar = ((uint64_t)w->sah) << 32 | (w->sal & 0xFFFFF000);
+    char name[26];
+
+    /* check if window is enabled */
+    if (!(w->sal & NPCM_PCIERC_SAL_EN)) {
+        return;
+    }
+
+    if (size > 2 * GiB || size < 4 * KiB) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Invalid PCI window size %d bytes\n",
+                      __func__, size);
+        return;
+    }
+
+    if (w->type == AXI2PCIE) {
+        snprintf(name, sizeof(name), "npcm-axi2pcie-window-%d", w->id);
+    } else if (w->type == PCIE2AXI) {
+        snprintf(name, sizeof(name), "npcm-pcie2axi-window-%d", w->id);
+    } else {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: unable to map uninitialized PCIe window",
+                      __func__);
+        return;
+    }
+
+    /* TODO: set subregion to target translation address */
+    /* add subregion starting at the window source address */
+    if (!memory_region_is_mapped(&w->mem)) {
+        memory_region_init(&w->mem, OBJECT(s), name, size);
+        memory_region_add_subregion(system, bar, &w->mem);
+    }
+}
+
+/* unmap windows marked as disabled */
+static void npcm_pcierc_unmap_disabled(NPCMPCIEWindow *w)
+{
+    MemoryRegion *system = get_system_memory();
+    /* Bit 0 in the Source address enables the window */
+    if (memory_region_is_mapped(&w->mem) && !(w->sal & NPCM_PCIERC_SAL_EN)) {
+        memory_region_del_subregion(system, &w->mem);
+    }
+}
+
+static void npcm_pcie_update_window_maps(NPCMPCIERCState *s)
+{
+    for (int i = 0; i < NPCM_PCIERC_NUM_PA_WINDOWS; i++) {
+        npcm_pcierc_unmap_disabled(&s->pcie2axi[i]);
+    }
+
+    for (int i = 0; i < NPCM_PCIERC_NUM_AP_WINDOWS; i++) {
+        npcm_pcierc_unmap_disabled(&s->axi2pcie[i]);
+    }
+
+    for (int i = 0; i < NPCM_PCIERC_NUM_AP_WINDOWS; i++) {
+        npcm_pcierc_map_enabled(s, &s->axi2pcie[i]);
+    }
+
+    for (int i = 0; i < NPCM_PCIERC_NUM_PA_WINDOWS; i++) {
+        npcm_pcierc_map_enabled(s, &s->pcie2axi[i]);
+    }
+}
+
+static NPCMPCIEWindow *npcm_pcierc_get_window(NPCMPCIERCState *s, hwaddr addr)
+{
+    NPCMPCIEWindow *window;
+
+    switch (addr) {
+    case NPCM_PCIERC_PAnSAL(0) ... NPCM_PCIERC_PAnTP(1):
+        window = &s->pcie2axi[NPCM_PCIERC_PA_WINDOW(addr)];
+        break;
+
+    case NPCM_PCIERC_APnSAL(0) ... NPCM_PCIERC_APnTP(4):
+        window = &s->axi2pcie[NPCM_PCIERC_AP_WINDOW(addr)];
+        break;
+
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: invalid window address 0x%lx\n",
+                      __func__, addr);
+        return 0;
+    }
+    return window;
+}
+
+static int npcm_pcierc_get_window_offset(NPCMPCIEWindow *w, hwaddr addr)
+{
+    if (w->type == AXI2PCIE) {
+        return addr & NPCM_PCIERC_AP_OFFSET_MASK;
+    } else if (w->type == PCIE2AXI) {
+        return addr & NPCM_PCIERC_PA_OFFSET_MASK;
+    } else {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: unable to access uninitialized PCIe window",
+                      __func__);
+        return -1;
+    }
+}
+
+static uint32_t npcm_pcierc_read_window(NPCMPCIERCState *s, hwaddr addr)
+{
+    NPCMPCIEWindow *window = npcm_pcierc_get_window(s, addr);
+    int offset;
+
+    if (!window) {
+        return 0;
+    }
+
+    offset = npcm_pcierc_get_window_offset(window, addr);
+    if (offset < 0) {
+        return 0;
+    }
+
+    switch (offset) {
+    case NPCM_PCIERC_SAL_OFFSET:
+        return window->sal;
+
+    case NPCM_PCIERC_SAH_OFFSET:
+        return window->sah;
+
+    case NPCM_PCIERC_TAL_OFFSET:
+        return window->tal;
+
+    case NPCM_PCIERC_TAH_OFFSET:
+        return window->tah;
+
+    case NPCM_PCIERC_PARAM_OFFSET:
+        return window->params;
+
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: invalid window offset 0x%x\n",
+                      __func__, offset);
+        return 0;
+    }
+}
+
+static void npcm_pcierc_write_window(NPCMPCIERCState *s, hwaddr addr,
+                                     uint64_t data)
+{
+    NPCMPCIEWindow *window = npcm_pcierc_get_window(s, addr);
+    int offset;
+
+    if (!window) {
+        return;
+    }
+
+    offset = npcm_pcierc_get_window_offset(window, addr);
+    if (offset < 0) {
+        return;
+    }
+
+    switch (offset) {
+    case NPCM_PCIERC_SAL_OFFSET:
+        window->sal = data;
+        break;
+
+    case NPCM_PCIERC_SAH_OFFSET:
+        window->sah = data;
+        break;
+
+    case NPCM_PCIERC_TAL_OFFSET:
+        window->tal = data;
+        break;
+
+    case NPCM_PCIERC_TAH_OFFSET:
+        window->tah = data;
+        break;
+
+    case NPCM_PCIERC_PARAM_OFFSET:
+        window->params = data;
+        break;
+
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: invalid window offset 0x%x\n",
+                      __func__, offset);
+    }
+
+    npcm_pcie_update_window_maps(s);
+}
+
 static uint64_t npcm_pcierc_cfg_read(void *opaque, hwaddr addr, unsigned size)
 {
     NPCMPCIERCState *s = NPCM_PCIERC(opaque);
@@ -46,6 +233,10 @@ static uint64_t npcm_pcierc_cfg_read(void *opaque, hwaddr addr, unsigned size)
         ret = s->axierr;
         break;
 
+    case NPCM_PCIERC_PAnSAL(0) ... NPCM_PCIERC_APnTP(4):
+        ret = npcm_pcierc_read_window(s, addr);
+        break;
+
     default:
         qemu_log_mask(LOG_UNIMP,
                       "%s: read from unimplemented register 0x%04lx\n",
@@ -88,6 +279,10 @@ static void npcm_pcierc_cfg_write(void *opaque, hwaddr addr, uint64_t data,
         s->axierr = data;
         break;
 
+    case NPCM_PCIERC_PAnSAL(0) ... NPCM_PCIERC_APnTP(4):
+        npcm_pcierc_write_window(s, addr, data);
+        break;
+
     default:
         qemu_log_mask(LOG_UNIMP,
                       "%s: write to unimplemented reg 0x%04lx data: 0x%lx\n",
@@ -96,6 +291,22 @@ static void npcm_pcierc_cfg_write(void *opaque, hwaddr addr, uint64_t data,
     }
 }
 
+static void npcm_pcierc_reset_pcie_windows(NPCMPCIERCState *s)
+{
+    memset(s->axi2pcie, 0, sizeof(s->axi2pcie));
+    memset(s->pcie2axi, 0, sizeof(s->pcie2axi));
+
+    for (int i = 0; i < NPCM_PCIERC_NUM_PA_WINDOWS; i++) {
+        s->pcie2axi[i].id = i;
+        s->pcie2axi[i].type = PCIE2AXI;
+    }
+
+    for (int i = 0; i < NPCM_PCIERC_NUM_AP_WINDOWS; i++) {
+        s->axi2pcie[i].id = i;
+        s->axi2pcie[i].type = AXI2PCIE;
+    }
+}
+
 static void npcm_pcierc_reset(Object *obj, ResetType type)
 {
     NPCMPCIERCState *s = NPCM_PCIERC(obj);
@@ -106,6 +317,8 @@ static void npcm_pcierc_reset(Object *obj, ResetType type)
     s->rcimsiaddr = 0;
     s->rcmsisstat = 0;
     s->axierr = 0;
+
+    npcm_pcierc_reset_pcie_windows(s);
 }
 
 static const char *npcm_pcierc_root_bus_path(PCIHostState *host_bridge,
@@ -136,6 +349,13 @@ static void npcm_pcierc_realize(DeviceState *dev, Error **errp)
     sysbus_init_irq(sbd, &s->irq);
 }
 
+static void npcm_pcierc_instance_init(Object *obj)
+{
+    NPCMPCIERCState *s = NPCM_PCIERC(obj);
+
+    npcm_pcierc_reset_pcie_windows(s);
+}
+
 static void npcm_pcierc_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -144,7 +364,7 @@ static void npcm_pcierc_class_init(ObjectClass *klass, const void *data)
 
     hbc->root_bus_path = npcm_pcierc_root_bus_path;
     dc->realize = npcm_pcierc_realize;
-    rc->phases.enter = npcm_pcierc_reset;
+    rc->phases.exit = npcm_pcierc_reset;
     set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
     dc->fw_name = "pci";
 }
@@ -153,6 +373,7 @@ static const TypeInfo npcm_pcierc_type_info = {
     .name = TYPE_NPCM_PCIERC,
     .parent = TYPE_PCIE_HOST_BRIDGE,
     .instance_size = sizeof(NPCMPCIERCState),
+    .instance_init = npcm_pcierc_instance_init,
     .class_init = npcm_pcierc_class_init,
 };
 
diff --git a/include/hw/pci-host/npcm_pcierc.h b/include/hw/pci-host/npcm_pcierc.h
index 2c817147d495fdc1d1fa4b389bad0469fd6a825e..410b34d1c1ced0e25f63fc7693d87bb625a80776 100644
--- a/include/hw/pci-host/npcm_pcierc.h
+++ b/include/hw/pci-host/npcm_pcierc.h
@@ -9,8 +9,8 @@
 /*
  * The PCIERC configuration registers must be initialised by the BMC kernel
  * during boot for PCIe to function
- * - A single window from the PCIe to the Memory controller
- * - 4 windows from the BMC to the PCIe.
+ * - A single window from PCIe to the Memory controller
+ * - 4 windows from the BMC to PCIe.
  *     1 of these five BMC-to-PCIe windows must be allocated for configuration
  *     transactions, the rest can be used for I/0 or memory transactions
  * - All BMC-to-PCIe windows are mapped to address range
@@ -34,9 +34,77 @@
 #define NPCM_PCIERC_MSISTAT             0x194 /* MSI Status Register */
 #define NPCM_PCIERC_AXI_ERROR_REPORT    0x3E0
 
+/* PCIe-to-AXI Window 0 and 1 Registers */
+/* Source address low */
+#define NPCM_PCIERC_PAnSAL(n)          (0x600 + (0x100 * (n)))
+/* Source address high */
+#define NPCM_PCIERC_PAnSAH(n)          (0x604 + (0x100 * (n)))
+/* Translation address low */
+#define NPCM_PCIERC_PAnTAL(n)          (0x608 + (0x100 * (n)))
+/* Translation address high */
+#define NPCM_PCIERC_PAnTAH(n)          (0x60C + (0x100 * (n)))
+/* Translation parameters */
+#define NPCM_PCIERC_PAnTP(n)           (0x610 + (0x100 * (n)))
+/* Get window number from address */
+#define NPCM_PCIERC_PA_WINDOW(addr)    (((addr) - 0x600) / 0x100)
+#define NPCM_PCIERC_PA_OFFSET_MASK      0xff
+
+/* AXI-to-PCIe Window 1 to 5 Registers, n in range [0,4] */
+/* Source address low */
+#define NPCM_PCIERC_APnSAL(n)          (0x820 + (0x20 * (n)))
+/* Source address high */
+#define NPCM_PCIERC_APnSAH(n)          (0x824 + (0x20 * (n)))
+/* Translation address low */
+#define NPCM_PCIERC_APnTAL(n)          (0x828 + (0x20 * (n)))
+/* Translation address high */
+#define NPCM_PCIERC_APnTAH(n)          (0x82C + (0x20 * (n)))
+/* Translation parameters */
+#define NPCM_PCIERC_APnTP(n)           (0x830 + (0x20 * (n)))
+/* Get window number from address */
+#define NPCM_PCIERC_AP_WINDOW(addr)    (((addr) - 0x820) / 0x20)
+#define NPCM_PCIERC_AP_OFFSET_MASK      0x1f
+
+/* Translation window parameters */
+#define NPCM_PCIERC_TRSL_ID(p)              ((p) & 0x7)
+#define     NPCM_PCIERC_TRSL_ID_TX_RX       0
+#define     NPCM_PCIERC_TRSL_ID_CONFIG      1
+#define NPCM_PCIERC_TRSF_PARAM(p)           (((p) >> 16) & 0xFFF)
+#define     NPCM_PCIERC_TRSF_PARAM_MEMORY   0
+#define     NPCM_PCIERC_TRSF_PARAM_CONFIG   1
+#define     NPCM_PCIERC_TRSF_PARAM_IO       2
+
+#define NPCM_PCIERC_SAL_OFFSET              0x0
+#define     NPCM_PCIERC_SAL_EN              1
+#define     NPCM_PCIERC_SAL_SIZE(addr)     (2ull << (((addr) >> 1) & 0x1F))
+#define NPCM_PCIERC_SAH_OFFSET              0x4
+#define NPCM_PCIERC_TAL_OFFSET              0x8
+#define NPCM_PCIERC_TAH_OFFSET              0xC
+#define NPCM_PCIERC_PARAM_OFFSET            0x10
+
+#define NPCM_PCIERC_NUM_PA_WINDOWS          2
+#define NPCM_PCIERC_NUM_AP_WINDOWS          5
+
 #define TYPE_NPCM_PCIERC "npcm-pcie-root-complex"
 OBJECT_DECLARE_SIMPLE_TYPE(NPCMPCIERCState, NPCM_PCIERC)
 
+typedef enum {
+    AXI2PCIE = 1,
+    PCIE2AXI
+} NPCMPCIEWindowType;
+
+/* Nuvoton PCIe translation Window */
+typedef struct NPCMPCIEWindow {
+    uint32_t sal;            /* source address low */
+    uint32_t sah;            /* source address high */
+    uint32_t tal;            /* translation address low */
+    uint32_t tah;            /* translation address high */
+    uint32_t params;         /* translation window parameters */
+
+    MemoryRegion mem;        /* QEMU memory subregion per window */
+    NPCMPCIEWindowType type; /* translation direction */
+    uint8_t id;
+} NPCMPCIEWindow;
+
 struct NPCMPCIERCState {
     PCIExpressHost parent;
 
@@ -50,6 +118,11 @@ struct NPCMPCIERCState {
     uint32_t rcimsiaddr;
     uint32_t rcmsisstat;
     uint32_t axierr;
+    /* PCIe to AXI Windows */
+    NPCMPCIEWindow pcie2axi[NPCM_PCIERC_NUM_PA_WINDOWS];
+
+    /* AXI to PCIe Windows */
+    NPCMPCIEWindow axi2pcie[NPCM_PCIERC_NUM_AP_WINDOWS];
 };
 
 #endif /* NPCM_PCIERC_H */

-- 
2.51.0.384.g4c02a37b29-goog


