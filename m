Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7C4CC4451B
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jul 2026 16:17:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlUBA-0007j3-RI; Sun, 19 Jul 2026 12:15:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1wlUB9-0007i5-I7
 for qemu-devel@nongnu.org; Sun, 19 Jul 2026 12:15:47 -0400
Received: from fout-b3-smtp.messagingengine.com ([202.12.124.146])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1wlUB6-0002PE-Pg
 for qemu-devel@nongnu.org; Sun, 19 Jul 2026 12:15:47 -0400
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.stl.internal (Postfix) with ESMTP id 11C051D00055;
 Sun, 19 Jul 2026 12:15:44 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Sun, 19 Jul 2026 12:15:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1784477743; x=
 1784564143; bh=4FAA1YeB78MffOhT5E4V4ZjbqWexRwugJ+MTnRDKvHQ=; b=H
 QYgl95RCJj2kThX6IAyRjtR/HfHb85ePxjrg4VTIr7P/jzS2AMJWM5biLR7HJagW
 AeRyQIdevXU/4X7cWIvqVXd5Cz+NW39XbWXUAqBSl78CwVOZkCScgSiFEoHDgGiD
 sc9dc0zCi4gBUISQUhqDlegwRFetj2Sk01JbTtiy3Ev0n8sept+rv058sqhQ2IoO
 CmP9iClMk8mCKSKQrvh1us+r31c0SPoo31pxpO6D1yndnu4Sg+p0qefiGltiA3YV
 QGK291AtwmNu7vj8Dyw/M6cE4L39f8r49b/cfG1ZaTmbZOt9tQwHurwDt+U8aSuh
 fmcwRbXHN0jEi4Z1dSjVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm2; t=1784477743; x=1784564143; bh=4
 FAA1YeB78MffOhT5E4V4ZjbqWexRwugJ+MTnRDKvHQ=; b=fcUH+n83WtscdBRi8
 1eLxSnk2C2psHOllCaDP5aTFnKpOlem6GMXqkRdeAUirq9khPgx9Dcxhrom5Hnr4
 JU+VdkLRJh2UDkFHpJ0YKPRAjVkwNT2NAGhzUpq4Z1uTztnSG0fZuMhpH3SzM7/W
 jjVVY6pgrT7FH+tT/sl6VLRM7UxU6LbvXCgBWFNgVeo8/Kjx5TRuh2DD1X2JSkHa
 USSK4FtvEgwYhX27Dn03LLNArtqHU+R0Po0G+770bJ6jFzboAmiqmKqEzAX/E8E+
 g0eENqwRs5Furw2iURp+xvTrhhDsJhXvSwTEyQQL3lX0FhnUlL+SWoHrkXfi62Qb
 8d0vQ==
X-ME-Sender: <xms:L_hcagy9Tx8qJlZPY9cC9TdX6GYUNbCApcU4eBv0K9jx_LYpNAQHGg>
 <xme:L_hcars9rlk_-YfOq5wHeDQ41NBH2nTuu-htDjecZQSKLnALdYbQNQ6wR3RWi0Q9e
 0UAvow6hRh5hatrAtc3_zdG51gVeoqUHsJNcxgslG0ZyOoTvB6cwL8>
X-ME-Received: <xmr:L_hcavtSiAFGrIAbu7VhAl_gD7Zmo2s8_HTMomyN4AYTAQeU1skNpBPQOJo>
X-ME-Proxy-Cause: dmFkZTFX22WwMbS2sW99eCB50G1QKT6MSqCpx6iK5itrq8JxZaP0521f6QSaZn8xZ08MPO
 fOwSNa6WDSeLTJNQVc/fxMSGvDLkf+yg/0G9Q09ZIOYGIXIBd2hVswgLVRGFoWlNQkKsDF
 GdNkKsfijsKMESGF+IJc7XNHY6Tof4qnJ8h5MKF7zpjgYI3Er1oT6Sc3p82wEBVA4tVY6K
 sm0munSEzPQOSr/py3N0SGFxIhaHx4yY0PMKs1GFt63biT3SGPXDCwnyEFOs/p40onWKAs
 7IByVaX4T1Xvhqors54F3a+bmhyr13Lneen+jWeanFhb1s0umv08sceX1eK90gcHhjDIV0
 4Rka0XWhOsYme8p7DfsHz3nVuq9PgyHlCECFzwdStuggQ1fbpY9AhEbKJ6Wzkkq1nQ4/UW
 OTdVHY7E83AziXGy5nebhghhuwuaoW+JGS2gsZL/6rNQ2WZR/4QCBMybxA1Ey8Uql+AQDa
 yIthN55EUX0NcQzVOmht777c7m3aqdVoZaMILiNoiH1Yny2gtEcCr+XbMpy3OXOUv5OiyO
 HzIVGl1lwdxT7i0lSKrkWww8zgSgvEIkqJ/51lQvXFh7NsuG6GZLwMJPInaLyln741hokQ
 Teq3b0Wj4FGDDi550ImddZuzQ4AWRdlQAvW92ajmXhPh62ufwMYlPDSWx8oA
X-ME-Proxy: <xmx:L_hcaoNaxzM7SwruO_KXCIrNX0SRlqJhN4-I_uwxpxEIFFeHZr_Aeg>
 <xmx:L_hcal23WJzmUObb9VwKu1qFE26P9n0iuWsarGpmSorfAZvWCzDTqQ>
 <xmx:L_hcasMh0QBxCnrZicRakQAUJg9fH16r2PkYSjrKOAXYtVYcHukH-g>
 <xmx:L_hcat2b9-Sz3DmBTh7vUdb0Bh9RvZIaG2fXR1DPfYexDtamGihBSw>
 <xmx:L_hcah4Fjwj15YD2CHynMUHeCDJhWwStop2JHsyXHKKOeV7N5HwbkKvr>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 19 Jul 2026 12:15:43 -0400 (EDT)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 9aa342e8;
 Sun, 19 Jul 2026 16:15:40 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>,
	Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH 4/9] ati-vga: Route GPU addresses with memory controller
Date: Sun, 19 Jul 2026 12:15:31 -0400
Message-ID: <20260719161536.774061-5-chad@jablonski.xyz>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260719161536.774061-1-chad@jablonski.xyz>
References: <20260719161536.774061-1-chad@jablonski.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.146; envelope-from=chad@jablonski.xyz;
 helo=fout-b3-smtp.messagingengine.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_SUSPICIOUS_NTLD=0.5, PDS_OTHER_BAD_TLD=2, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=no autolearn_force=no
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

The r100's internal address space has mappings to the framebuffer,
PCI GART and system memory.

The framebuffer mapping is controlled by the MC_FB_LOCATION register
which contains a start and a top address.

The PCI GART is set up and mapped by the AIC_* registers. When enabled with
AIC_CTRL, addresses between AIC_LO_ADDR and AIC_HI_ADDR are translated using
the page table at AIC_PT_BASE. The physical address can then be accessed
via DMA.

If the address is outside either of these regions it is treated as a physical
address.

This is required for using the CP engine. Drivers store the ring buffer
and indirect buffer in the PCI GART area. The r100 2D engine also stores GPU
addresses in the src/dst offset registers that require routing. A future
patch integrates this into the ati_2d blit operations.

Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
---
 hw/display/ati.c      | 83 +++++++++++++++++++++++++++++++++++++++++++
 hw/display/ati_int.h  | 11 ++++++
 hw/display/ati_regs.h |  7 ++++
 3 files changed, 101 insertions(+)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index 5c1232a31f..f19a0613d7 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -277,6 +277,55 @@ static inline uint32_t ati_reg_read_offs(uint32_t reg, int offs,
     }
 }
 
+ATIMemRoute ati_mc_route(ATIVGAState *s, uint32_t gpu_addr)
+{
+    uint32_t fb_start = (s->regs.mc_fb_location & 0xffff) << 16;
+    uint32_t fb_top = s->regs.mc_fb_location | 0xffff;
+
+    /* Framebuffer */
+    if (gpu_addr >= fb_start && gpu_addr <= fb_top) {
+        uint32_t offs = (gpu_addr - fb_start) % s->vga.vram_size;
+        return (ATIMemRoute) { .is_vram = true, .addr = offs };
+    }
+
+    /* PCI GART */
+    if ((s->regs.aic_ctrl & PCIGART_TRANSLATE_EN) &&
+       /* aic_{lo,hi}_addr are page-aligned and inclusive */
+       gpu_addr >= s->regs.aic_lo_addr &&
+       gpu_addr < s->regs.aic_hi_addr + 0x1000) {
+        uint32_t pg_idx = (gpu_addr - s->regs.aic_lo_addr) >> 12;
+        uint32_t pte;
+        if (ldl_le_pci_dma(&s->dev,
+                           s->regs.aic_pt_base + pg_idx * sizeof(uint32_t),
+                           &pte, MEMTXATTRS_UNSPECIFIED)) {
+            qemu_log_mask(LOG_GUEST_ERROR, "PCI GART pte read failed\n");
+            return (ATIMemRoute) { .is_vram = false, .addr = 0 };
+        }
+        return (ATIMemRoute) {
+            .is_vram = false,
+            .addr = (pte & 0xfffff000) | (gpu_addr & 0xfff),
+        };
+    }
+
+    /* System memory */
+    return (ATIMemRoute) { .is_vram = false, .addr = gpu_addr };
+}
+
+static uint32_t ati_mc_read(ATIVGAState *s, uint32_t gpu_addr)
+{
+    ATIMemRoute route = ati_mc_route(s, gpu_addr);
+    uint32_t val;
+
+    if (route.is_vram) {
+        return ldl_le_p(s->vga.vram_ptr + route.addr);
+    }
+    if (ldl_le_pci_dma(&s->dev, route.addr, &val, MEMTXATTRS_UNSPECIFIED)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "MC DMA read failed\n");
+        return 0;
+    }
+    return val;
+}
+
 static uint64_t ati_mm_read(void *opaque, hwaddr addr, unsigned int size)
 {
     ATIVGAState *s = opaque;
@@ -542,6 +591,21 @@ static uint64_t ati_mm_read(void *opaque, hwaddr addr, unsigned int size)
         qemu_log_mask(LOG_GUEST_ERROR,
                       "Read from write-only register 0x%x\n", (unsigned)addr);
         break;
+    case AIC_CTRL:
+        val = s->regs.aic_ctrl;
+        break;
+    case AIC_PT_BASE:
+        val = s->regs.aic_pt_base;
+        break;
+    case AIC_LO_ADDR:
+        val = s->regs.aic_lo_addr;
+        break;
+    case AIC_HI_ADDR:
+        val = s->regs.aic_hi_addr;
+        break;
+    case MC_FB_LOCATION:
+        val = s->regs.mc_fb_location;
+        break;
     default:
         break;
     }
@@ -1046,6 +1110,25 @@ static void ati_mm_write(void *opaque, hwaddr addr,
             s->host_data.next = 0;
         }
         break;
+    case AIC_CTRL:
+        s->regs.aic_ctrl = data;
+        break;
+    case AIC_PT_BASE:
+        s->regs.aic_pt_base = data & 0xfffff000;
+        break;
+    case AIC_LO_ADDR:
+        s->regs.aic_lo_addr = data & 0xfffff000;
+        break;
+    case AIC_HI_ADDR:
+        s->regs.aic_hi_addr = data & 0xfffff000;
+        break;
+    case MC_FB_LOCATION:
+        /*
+         * The bottom 6 bits of fb start are hard-wired to 0
+         * and the bottom 6 bits of fb top are hard-wired to 1
+         */
+        s->regs.mc_fb_location = (data & 0xffc0ffc0) | 0x003f0000;
+        break;
     default:
         break;
     }
diff --git a/hw/display/ati_int.h b/hw/display/ati_int.h
index 0c48934d33..bb08e0c23d 100644
--- a/hw/display/ati_int.h
+++ b/hw/display/ati_int.h
@@ -95,6 +95,11 @@ typedef struct ATIVGARegs {
     uint16_t default_sc_bottom;
     uint16_t default_sc_right;
     uint32_t default_tile;
+    uint32_t aic_ctrl;
+    uint32_t aic_pt_base;
+    uint32_t aic_lo_addr;
+    uint32_t aic_hi_addr;
+    uint32_t mc_fb_location;
 } ATIVGARegs;
 
 typedef struct ATIHostDataState {
@@ -127,8 +132,14 @@ struct ATIVGAState {
     ATIHostDataState host_data;
 };
 
+typedef struct {
+    bool is_vram;
+    hwaddr addr;
+} ATIMemRoute;
+
 const char *ati_reg_name(int num);
 
+ATIMemRoute ati_mc_route(ATIVGAState *s, uint32_t gpu_addr);
 void ati_2d_blt(ATIVGAState *s);
 bool ati_host_data_flush(ATIVGAState *s);
 void ati_host_data_finish(ATIVGAState *s);
diff --git a/hw/display/ati_regs.h b/hw/display/ati_regs.h
index b813fa119e..5e9396bd7a 100644
--- a/hw/display/ati_regs.h
+++ b/hw/display/ati_regs.h
@@ -73,6 +73,10 @@
 #define MPP_TB_CONFIG                           0x01C0
 #define MPP_GP_CONFIG                           0x01C8
 #define VIPH_CONTROL                            0x01D0
+#define AIC_CTRL                                0x01D0
+#define AIC_PT_BASE                             0x01D8
+#define AIC_LO_ADDR                             0x01DC
+#define AIC_HI_ADDR                             0x01E0
 #define CRTC_H_TOTAL_DISP                       0x0200
 #define CRTC_H_SYNC_STRT_WID                    0x0204
 #define CRTC_V_TOTAL_DISP                       0x0208
@@ -477,6 +481,9 @@
 /* CRTC2_GEN_CNTL constants */
 #define CRTC2_EN                                0x02000000
 
+/* AIC_CTRL constants */
+#define PCIGART_TRANSLATE_EN                    0x00000001
+
 /* POWER_MANAGEMENT constants */
 #define PWR_MGT_ON                              0x00000001
 #define PWR_MGT_MODE_MASK                       0x00000006
-- 
2.54.0


