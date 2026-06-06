Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 680EECD8C88
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2026 19:53:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVx4T-00065H-43; Sat, 06 Jun 2026 15:52:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1wVx4Q-00063h-IO
 for qemu-devel@nongnu.org; Sat, 06 Jun 2026 15:52:38 -0400
Received: from fhigh-b4-smtp.messagingengine.com ([202.12.124.155])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1wVx4M-00013G-RT
 for qemu-devel@nongnu.org; Sat, 06 Jun 2026 15:52:38 -0400
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfhigh.stl.internal (Postfix) with ESMTP id EF14B7A0069;
 Sat,  6 Jun 2026 15:52:32 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Sat, 06 Jun 2026 15:52:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1780775552; x=
 1780861952; bh=oH2vw2ylL4HPw15CyrL0DBfurI7dmllX0oOBvZyy4cg=; b=N
 AXe/dJQutjDgQoOnuGJnSzDDrtSqa6eveLpm4IXP7BPAsKHM/e+DG3EpQTMvTyEm
 h/wUVNle7W1LFgfxCYQhqqU/lByjgHecPvELTo8TA8D+MM+0NhWZeCJOb4bP0zA3
 TVoUknnJttmDmOBQ1kMAsS9ldAd8nvwaMhAMtEHyEYSRlWcROxe7ZlzcGwxJRF+Y
 fd7XN+IkZtWnwMgYHqyZpGk31YiLWbWcxgJnijGNNIjTUe4mrOImTrmKA73EMZVN
 8tcQxJ6Fb30Yc/7uY8euFw1EOxXcvqzoPr0riuVvFyadscFI7Thz8S/N2IQRtXsI
 iACADfPbHZMec5Af7N0fg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1780775552; x=1780861952; bh=o
 H2vw2ylL4HPw15CyrL0DBfurI7dmllX0oOBvZyy4cg=; b=F48rLOrGeI32gwQPQ
 y38hchm33b+UlUQ8C6OIQQBpPHTG9UNoA40alMNC1XK7KHxDFY/W8Kz/extG6rQq
 yLN0izOa4rBDYiEmEmG0m7M5T66rE+HxrvoKgNrxj95QgxNUg6v0tWTZTEKFTUe1
 LTjSIL9WQwfl8+TxqiNK1BpjpVEuPw/a4i5/CA3Hl0wT/n84XqO9Ymq6jbA6H5XL
 pO2+JLQHxry9th9KybXJAmBvZM1XgkJ1BrxUA0iGpQ9W6imqtKRwzPBV6reQoJLS
 GXu+DueVMYTFYmoenqB3fYan8Dh02hni+ecN15exJzm3gXWKWPlF06g1hmmZgS1C
 Hy1cg==
X-ME-Sender: <xms:gHokalEVn5rgxMHE_ov2hs5IyyWXGodzQLHFprYHT1tEMVVEwljiTg>
 <xme:gHokahzRYFlq18pqPVheoEyQH2ZXgRdt6Iw0pkvzdr5WFhTuvNHxRknHbx6RgkX0d
 qxr_cUFADMMkAsarQrRS7iyuLcCBq2EIWmQe5KBbTDylk-POUsHV5A>
X-ME-Received: <xmr:gHokakg5Zkw9foXlG28ZKPLUwvec96bZHy7Hz1niGIYsu9e5te7R54v53x-t>
X-ME-Proxy-Cause: dmFkZTF5V5TJt4YyOidEvSaeu/MRla4xP+DmdZQhB39MOi6suQo+ewwhopiobLPZpZFZya
 cAlJGIfDtnd9YI9euUev0/BPlhx7gFnO282gf6qihxTXQ9XGsNSFgetoCcqBrBvyjHrANh
 atTdGgjKUldYBX7wk7l0Cl09WJIHvldYLH4ZomEKYEpVZT82+Oh5snshv7XK6+9Sb5cWbw
 e84vQB5olzLLZrdcgzNge+k12PyvF6W544E61zazKBZo950akvs+WrgTOdnqD9gQaa29eu
 Mvbl6jhgYAGUnVDqLD0fWkRRImSA3/gMsTXu4gQwDYtEjGvTqg8SUjhCR0pAYP3BvhiEhA
 o0U4n/Cs/RsCAN3edcWyH+zB8C+POCU5knL1zYO53K42ISlAzsJLQZ1IXhqxGrDTgUM1nj
 XtV9mA9ozLT9DUjFQEox55SoRzH8zIfxN8mhpbrCFqm9pzaYMgRT6O40ZtVyf+JHHLAEpK
 o4ZLCuoD721aDev6EdB8ZsRr0E6vWAACDZ8CDz7vmKMd2V11DMEONbKmdn1WIuUNbnqD9y
 oJCK7ieJrjD9rC56e+axSI6pmHzBXsXdemipxNwXAjgIX1LfYOH4BfZuBieTHbw/83wO5F
 BCfkD2lM5FMPYhfzWN0YVxpP3vUlIszFCiiq3XI+S1ChuZmtMkGnDSZN6Upg
X-ME-Proxy: <xmx:gHokakyXJ4aAybwL-5pHUsbY_TA3KeWkZZ3IkBVnjjB7GjcHCXxPBw>
 <xmx:gHokavIuO33fhhS1Fp8RLwVQIp-IX6z_10MFTqHZpkvrRTQX6-ubxg>
 <xmx:gHokajTqCazooYZmMWGsigTgIlrdKLG7l58o1wnyGpV7rpkv4tmojQ>
 <xmx:gHokavp5ZpaFALgOVQ3qG9kBBoWGq5dJKCfO3Pt5IhMosvfLZzV4Sw>
 <xmx:gHokavfFSekznMKDAUYHgRRPFNKWEGsUDbMwhnloW9AN7nTITpZuBnJp>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 6 Jun 2026 15:52:32 -0400 (EDT)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 80c6d66f;
 Sat, 6 Jun 2026 19:52:30 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>,
	Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v3 2/7] ati-vga: Chip-specific register handlers
Date: Sat,  6 Jun 2026 15:52:11 -0400
Message-ID: <20260606195216.2524314-3-chad@jablonski.xyz>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260606195216.2524314-1-chad@jablonski.xyz>
References: <20260606195216.2524314-1-chad@jablonski.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.155; envelope-from=chad@jablonski.xyz;
 helo=fhigh-b4-smtp.messagingengine.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_SUSPICIOUS_NTLD=0.5, RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_PDS_OTHER_BAD_TLD=0.01,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

Move read and write register handlers to chip-specific functions so that
register differences are defined in one place for each chip. This prepares
for differences that occur in CCE setup.

The only behavioral change is that the Rage 128 will now return 0 when
reading the HOST_PATH_CNTL register. This is technically more correct in
that the Rage 128 doesn't have this register.

Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
---
 hw/display/ati.c | 351 ++++++++++++++++++++++++++++-------------------
 1 file changed, 211 insertions(+), 140 deletions(-)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index b4c9086188..826c856b1c 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -277,11 +277,86 @@ static inline uint32_t ati_reg_read_offs(uint32_t reg, int offs,
     }
 }
 
+static bool ati_r128_mm_read(ATIVGAState *s, hwaddr addr, unsigned int size,
+                             uint32_t *val)
+{
+    switch (addr) {
+    case BIOS_0_SCRATCH ... BUS_CNTL - 1:
+    {
+        int i = (addr - BIOS_0_SCRATCH) / 4;
+        if (i <= 3) {
+            *val = ati_reg_read_offs(s->regs.bios_scratch[i],
+                                     addr - (BIOS_0_SCRATCH + i * 4), size);
+        }
+        break;
+    }
+    case DST_PITCH:
+        *val = s->regs.dst_pitch | s->regs.dst_tile << 16;
+        break;
+    case SRC_PITCH:
+        *val = s->regs.src_pitch | s->regs.src_tile << 16;
+        break;
+    case DEFAULT_OFFSET:
+        *val = s->regs.default_offset;
+        break;
+    default:
+        return false;
+    }
+
+    return true;
+}
+
+static bool ati_r100_mm_read(ATIVGAState *s, hwaddr addr, unsigned int size,
+                             uint32_t *val)
+{
+    switch (addr) {
+    case BIOS_0_SCRATCH ... BUS_CNTL - 1:
+    {
+        int i = (addr - BIOS_0_SCRATCH) / 4;
+        *val = ati_reg_read_offs(s->regs.bios_scratch[i],
+                                 addr - (BIOS_0_SCRATCH + i * 4), size);
+        break;
+    }
+    case HOST_PATH_CNTL:
+        *val = BIT(23); /* Radeon HDP_APER_CNTL */
+        break;
+    case MEM_SDRAM_MODE_REG:
+        *val = BIT(28) | BIT(20);
+        break;
+    case DST_PITCH:
+        *val = s->regs.dst_pitch;
+        break;
+    case SRC_PITCH:
+        *val = s->regs.src_pitch;
+        break;
+    case DEFAULT_OFFSET:
+        *val = s->regs.default_offset >> 10;
+        *val |= s->regs.default_pitch << 16;
+        *val |= s->regs.default_tile << 30;
+        break;
+    default:
+        return false;
+    }
+
+    return true;
+}
+
 static uint64_t ati_mm_read(void *opaque, hwaddr addr, unsigned int size)
 {
     ATIVGAState *s = opaque;
     uint32_t val = 0;
 
+    if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
+        if (ati_r128_mm_read(s, addr, size, &val)) {
+            return val;
+        }
+    } else {
+        if (ati_r100_mm_read(s, addr, size, &val)) {
+            return val;
+        }
+    }
+
+    /* Shared Registers */
     switch (addr) {
     case MM_INDEX:
         val = s->regs.mm_index;
@@ -300,16 +375,6 @@ static uint64_t ati_mm_read(void *opaque, hwaddr addr, unsigned int size)
                 "ati_mm_read: mm_index too small: %u\n", s->regs.mm_index);
         }
         break;
-    case BIOS_0_SCRATCH ... BUS_CNTL - 1:
-    {
-        int i = (addr - BIOS_0_SCRATCH) / 4;
-        if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF && i > 3) {
-            break;
-        }
-        val = ati_reg_read_offs(s->regs.bios_scratch[i],
-                                addr - (BIOS_0_SCRATCH + i * 4), size);
-        break;
-    }
     case GEN_INT_CNTL:
         val = s->regs.gen_int_cntl;
         break;
@@ -371,17 +436,9 @@ static uint64_t ati_mm_read(void *opaque, hwaddr addr, unsigned int size)
     case CONFIG_REG_APER_SIZE:
         val = memory_region_size(&s->mm) / 2;
         break;
-    case HOST_PATH_CNTL:
-        val = BIT(23); /* Radeon HDP_APER_CNTL */
-        break;
     case MC_STATUS:
         val = 5;
         break;
-    case MEM_SDRAM_MODE_REG:
-        if (s->dev_id != PCI_DEVICE_ID_ATI_RAGE128_PF) {
-            val = BIT(28) | BIT(20);
-        }
-        break;
     case RBBM_STATUS:
     case GUI_STAT:
         val = 64; /* free CMDFIFO entries */
@@ -436,12 +493,6 @@ static uint64_t ati_mm_read(void *opaque, hwaddr addr, unsigned int size)
     case DST_OFFSET:
         val = s->regs.dst_offset;
         break;
-    case DST_PITCH:
-        val = s->regs.dst_pitch;
-        if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
-            val |= s->regs.dst_tile << 16;
-        }
-        break;
     case DST_WIDTH:
         val = s->regs.dst_width;
         break;
@@ -472,12 +523,6 @@ static uint64_t ati_mm_read(void *opaque, hwaddr addr, unsigned int size)
     case SRC_OFFSET:
         val = s->regs.src_offset;
         break;
-    case SRC_PITCH:
-        val = s->regs.src_pitch;
-        if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
-            val |= s->regs.src_tile << 16;
-        }
-        break;
     case DP_BRUSH_BKGD_CLR:
         val = s->regs.dp_brush_bkgd_clr;
         break;
@@ -502,14 +547,6 @@ static uint64_t ati_mm_read(void *opaque, hwaddr addr, unsigned int size)
     case DP_WRITE_MASK:
         val = s->regs.dp_write_mask;
         break;
-    case DEFAULT_OFFSET:
-        val = s->regs.default_offset;
-        if (s->dev_id != PCI_DEVICE_ID_ATI_RAGE128_PF) {
-            val >>= 10;
-            val |= s->regs.default_pitch << 16;
-            val |= s->regs.default_tile << 30;
-        }
-        break;
     case DEFAULT_PITCH:
         val = s->regs.default_pitch;
         val |= s->regs.default_tile << 16;
@@ -562,20 +599,150 @@ static inline void ati_reg_write_offs(uint32_t *reg, int offs,
     }
 }
 
-void ati_reg_write(ATIVGAState *s, hwaddr addr,
-                   uint64_t data, unsigned int size)
+static bool ati_r128_reg_write(ATIVGAState *s, hwaddr addr, uint64_t data,
+                               unsigned int size)
 {
     switch (addr) {
     case BIOS_0_SCRATCH ... BUS_CNTL - 1:
     {
         int i = (addr - BIOS_0_SCRATCH) / 4;
-        if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF && i > 3) {
-            break;
+        if (i <= 3) {
+            ati_reg_write_offs(&s->regs.bios_scratch[i],
+                               addr - (BIOS_0_SCRATCH + i * 4), data, size);
+        }
+        break;
+    }
+    case GEN_INT_STATUS:
+        data &= 0x000f040fUL;
+        s->regs.gen_int_status &= ~data;
+        ati_vga_update_irq(s);
+        break;
+    case GPIO_MONID ... GPIO_MONID + 3:
+        /* Rage128p accesses DDC via MONID(1-2) with additional mask bit */
+        ati_reg_write_offs(&s->regs.gpio_monid,
+                           addr - GPIO_MONID, data, size);
+        if ((s->regs.gpio_monid & BIT(25)) &&
+            ((addr <= GPIO_MONID + 2 && addr + size > GPIO_MONID + 2) ||
+             (addr == GPIO_MONID && (s->regs.gpio_monid & 0x60000)))) {
+            s->regs.gpio_monid = ati_i2c(&s->bbi2c, s->regs.gpio_monid, 1);
         }
+        break;
+    case DST_PITCH:
+        s->regs.dst_pitch = data & 0x3fff;
+        s->regs.dst_tile = (data >> 16) & 1;
+        break;
+    case SRC_PITCH_OFFSET:
+        s->regs.src_offset = (data & 0x1fffff) << 5;
+        s->regs.src_pitch = (data & 0x7fe00000) >> 21;
+        s->regs.src_tile = data >> 31;
+        break;
+    case DST_PITCH_OFFSET:
+        s->regs.dst_offset = (data & 0x1fffff) << 5;
+        s->regs.dst_pitch = (data & 0x7fe00000) >> 21;
+        s->regs.dst_tile = data >> 31;
+        break;
+    case SRC_PITCH:
+        s->regs.src_pitch = data & 0x3fff;
+        s->regs.src_tile = (data >> 16) & 1;
+        break;
+    case DEFAULT_OFFSET:
+        s->regs.default_offset = data & 0xfffffff0;
+        break;
+    case DEFAULT_PITCH:
+        s->regs.default_pitch = data & 0x3fff;
+        s->regs.default_tile = (data >> 16) & 1;
+        break;
+    default:
+        return false;
+    }
+
+    return true;
+}
+
+static bool ati_r100_reg_write(ATIVGAState *s, hwaddr addr, uint64_t data,
+                               unsigned int size)
+{
+    switch (addr) {
+    case BIOS_0_SCRATCH ... BUS_CNTL - 1:
+    {
+        int i = (addr - BIOS_0_SCRATCH) / 4;
         ati_reg_write_offs(&s->regs.bios_scratch[i],
                            addr - (BIOS_0_SCRATCH + i * 4), data, size);
         break;
     }
+    case GEN_INT_STATUS:
+        data &= 0xfc080effUL;
+        s->regs.gen_int_status &= ~data;
+        ati_vga_update_irq(s);
+        break;
+    /*
+     * GPIO regs for DDC access. Because some drivers access these via
+     * multiple byte writes we have to be careful when we send bits to
+     * avoid spurious changes in bitbang_i2c state. Only do it when either
+     * the enable bits are changed or output bits changed while enabled.
+     */
+    case GPIO_VGA_DDC ... GPIO_VGA_DDC + 3:
+        /* FIXME: Maybe add a property to select VGA or DVI port? */
+        break;
+    case GPIO_DVI_DDC ... GPIO_DVI_DDC + 3:
+        ati_reg_write_offs(&s->regs.gpio_dvi_ddc,
+                           addr - GPIO_DVI_DDC, data, size);
+        if ((addr <= GPIO_DVI_DDC + 2 && addr + size > GPIO_DVI_DDC + 2) ||
+            (addr == GPIO_DVI_DDC && (s->regs.gpio_dvi_ddc & 0x30000))) {
+            s->regs.gpio_dvi_ddc = ati_i2c(&s->bbi2c,
+                                           s->regs.gpio_dvi_ddc, 0);
+        }
+        break;
+    case GPIO_MONID ... GPIO_MONID + 3:
+        /* FIXME What does Radeon have here? */
+        break;
+    case DST_TILE:
+        s->regs.dst_tile = data & 3;
+        break;
+    case DST_PITCH:
+        s->regs.dst_pitch = data & 0x3fff;
+        break;
+    case SRC_PITCH_OFFSET:
+        s->regs.src_offset = (data & 0x3fffff) << 10;
+        s->regs.src_pitch = (data & 0x3fc00000) >> 16;
+        s->regs.src_tile = (data >> 30) & 1;
+        break;
+    case DST_PITCH_OFFSET:
+        s->regs.dst_offset = (data & 0x3fffff) << 10;
+        s->regs.dst_pitch = (data & 0x3fc00000) >> 16;
+        s->regs.dst_tile = data >> 30;
+        break;
+    case SRC_PITCH:
+        s->regs.src_pitch = data & 0x3fff;
+        break;
+    case DEFAULT_OFFSET:
+        /* Radeon has DEFAULT_PITCH_OFFSET here like DST_PITCH_OFFSET */
+        s->regs.default_offset = (data & 0x3fffff) << 10;
+        s->regs.default_pitch = (data & 0x3fc00000) >> 16;
+        s->regs.default_tile = data >> 30;
+        break;
+    default:
+        return false;
+    }
+
+    return true;
+}
+
+void ati_reg_write(ATIVGAState *s, hwaddr addr,
+                   uint64_t data, unsigned int size)
+{
+    if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
+        if (ati_r128_reg_write(s, addr, data, size)) {
+            return;
+        }
+    } else {
+        if (ati_r100_reg_write(s, addr, data, size)) {
+            return;
+        }
+    }
+
+    /* Shared Registers */
+    switch (addr) {
     case GEN_INT_CNTL:
         s->regs.gen_int_cntl = data;
         if (data & CRTC_VBLANK_INT) {
@@ -585,12 +752,6 @@ void ati_reg_write(ATIVGAState *s, hwaddr addr,
             ati_vga_update_irq(s);
         }
         break;
-    case GEN_INT_STATUS:
-        data &= (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF ?
-                 0x000f040fUL : 0xfc080effUL);
-        s->regs.gen_int_status &= ~data;
-        ati_vga_update_irq(s);
-        break;
     case CRTC_GEN_CNTL ... CRTC_GEN_CNTL + 3:
     {
         uint32_t val = s->regs.crtc_gen_cntl;
@@ -638,41 +799,6 @@ void ati_reg_write(ATIVGAState *s, hwaddr addr,
         s->regs.dac_cntl = data & 0xffffe3ff;
         s->vga.dac_8bit = !!(data & DAC_8BIT_EN);
         break;
-    /*
-     * GPIO regs for DDC access. Because some drivers access these via
-     * multiple byte writes we have to be careful when we send bits to
-     * avoid spurious changes in bitbang_i2c state. Only do it when either
-     * the enable bits are changed or output bits changed while enabled.
-     */
-    case GPIO_VGA_DDC ... GPIO_VGA_DDC + 3:
-        if (s->dev_id != PCI_DEVICE_ID_ATI_RAGE128_PF) {
-            /* FIXME: Maybe add a property to select VGA or DVI port? */
-        }
-        break;
-    case GPIO_DVI_DDC ... GPIO_DVI_DDC + 3:
-        if (s->dev_id != PCI_DEVICE_ID_ATI_RAGE128_PF) {
-            ati_reg_write_offs(&s->regs.gpio_dvi_ddc,
-                               addr - GPIO_DVI_DDC, data, size);
-            if ((addr <= GPIO_DVI_DDC + 2 && addr + size > GPIO_DVI_DDC + 2) ||
-                (addr == GPIO_DVI_DDC && (s->regs.gpio_dvi_ddc & 0x30000))) {
-                s->regs.gpio_dvi_ddc = ati_i2c(&s->bbi2c,
-                                               s->regs.gpio_dvi_ddc, 0);
-            }
-        }
-        break;
-    case GPIO_MONID ... GPIO_MONID + 3:
-        /* FIXME What does Radeon have here? */
-        if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
-            /* Rage128p accesses DDC via MONID(1-2) with additional mask bit */
-            ati_reg_write_offs(&s->regs.gpio_monid,
-                               addr - GPIO_MONID, data, size);
-            if ((s->regs.gpio_monid & BIT(25)) &&
-                ((addr <= GPIO_MONID + 2 && addr + size > GPIO_MONID + 2) ||
-                 (addr == GPIO_MONID && (s->regs.gpio_monid & 0x60000)))) {
-                s->regs.gpio_monid = ati_i2c(&s->bbi2c, s->regs.gpio_monid, 1);
-            }
-        }
-        break;
     case PALETTE_INDEX ... PALETTE_INDEX + 3:
         if (size == 4) {
             vga_ioport_write(&s->vga, VGA_PEL_IR, (data >> 16) & 0xff);
@@ -800,18 +926,7 @@ void ati_reg_write(ATIVGAState *s, hwaddr addr,
         ati_cursor_define(s);
         break;
     case DST_OFFSET:
-            s->regs.dst_offset = data & 0xfffffff0;
-        break;
-    case DST_PITCH:
-            s->regs.dst_pitch = data & 0x3fff;
-        if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
-            s->regs.dst_tile = (data >> 16) & 1;
-        }
-        break;
-    case DST_TILE:
-        if (s->dev_id == PCI_DEVICE_ID_ATI_RADEON_QY) {
-            s->regs.dst_tile = data & 3;
-        }
+        s->regs.dst_offset = data & 0xfffffff0;
         break;
     case DST_WIDTH:
         s->regs.dst_width = data & 0x3fff;
@@ -832,28 +947,6 @@ void ati_reg_write(ATIVGAState *s, hwaddr addr,
     case DST_Y:
         s->regs.dst_y = data & 0x3fff;
         break;
-    case SRC_PITCH_OFFSET:
-        if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
-            s->regs.src_offset = (data & 0x1fffff) << 5;
-            s->regs.src_pitch = (data & 0x7fe00000) >> 21;
-            s->regs.src_tile = data >> 31;
-        } else {
-            s->regs.src_offset = (data & 0x3fffff) << 10;
-            s->regs.src_pitch = (data & 0x3fc00000) >> 16;
-            s->regs.src_tile = (data >> 30) & 1;
-        }
-        break;
-    case DST_PITCH_OFFSET:
-        if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
-            s->regs.dst_offset = (data & 0x1fffff) << 5;
-            s->regs.dst_pitch = (data & 0x7fe00000) >> 21;
-            s->regs.dst_tile = data >> 31;
-        } else {
-            s->regs.dst_offset = (data & 0x3fffff) << 10;
-            s->regs.dst_pitch = (data & 0x3fc00000) >> 16;
-            s->regs.dst_tile = data >> 30;
-        }
-        break;
     case SRC_Y_X:
         s->regs.src_x = data & 0x3fff;
         s->regs.src_y = (data >> 16) & 0x3fff;
@@ -915,13 +1008,7 @@ void ati_reg_write(ATIVGAState *s, hwaddr addr,
         s->regs.dst_height = (data >> 16) & 0x3fff;
         break;
     case SRC_OFFSET:
-            s->regs.src_offset = data & 0xfffffff0;
-        break;
-    case SRC_PITCH:
-            s->regs.src_pitch = data & 0x3fff;
-        if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
-            s->regs.src_tile = (data >> 16) & 1;
-        }
+        s->regs.src_offset = data & 0xfffffff0;
         break;
     case DP_BRUSH_BKGD_CLR:
         s->regs.dp_brush_bkgd_clr = data;
@@ -947,22 +1034,6 @@ void ati_reg_write(ATIVGAState *s, hwaddr addr,
     case DP_WRITE_MASK:
         s->regs.dp_write_mask = data;
         break;
-    case DEFAULT_OFFSET:
-        if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
-            s->regs.default_offset = data & 0xfffffff0;
-        } else {
-            /* Radeon has DEFAULT_PITCH_OFFSET here like DST_PITCH_OFFSET */
-            s->regs.default_offset = (data & 0x3fffff) << 10;
-            s->regs.default_pitch = (data & 0x3fc00000) >> 16;
-            s->regs.default_tile = data >> 30;
-        }
-        break;
-    case DEFAULT_PITCH:
-        if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
-            s->regs.default_pitch = data & 0x3fff;
-            s->regs.default_tile = (data >> 16) & 1;
-        }
-        break;
     case DEFAULT_SC_BOTTOM_RIGHT:
         s->regs.default_sc_right = data & 0x3fff;
         s->regs.default_sc_bottom = (data >> 16) & 0x3fff;
-- 
2.53.0


