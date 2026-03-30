Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 724E51061B18
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 22:29:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7L6h-0007LP-Io; Mon, 30 Mar 2026 18:29:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w7L6g-0007LH-M4
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 18:29:14 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w7L6e-0008Dj-A6
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 18:29:14 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-66c17372965so1662189a12.1
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2026 15:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774909750; x=1775514550; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FflxTOp8GpZOCZjnv6fTG88S37ESb46HSTNo50IoX+g=;
 b=KB/FwhwXjdlIVtsUPwMFPApgzV86OS5jNo9HeEX7xAwkED859u1meKtEf62PanufyK
 sE8wIlW4ZEjcvz4HXg21cJJBWq/enizc7VhJ/kaNUWT8IkAsCVhXtni2/hkqB5teXak0
 ZR1xZFcyg1kDDngNtawjo0In1opxMRLNkz+W9ctV+BlNGyERswXuQXO/e1tSYSrc0QkS
 ZKik2tHZI1XRYtx+WWNNlZXfA0AfdRTLNEmo2P6fTq4E3W/KFs8qUlsm5BnMZd3SDNdt
 XrCokBLfxQCJjfgO2Hd/OyIeBQ/9A1vmpqk9JY6SbbGluRmiL4qoH6drMPzJ4HsWiKEm
 UV9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774909750; x=1775514550;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FflxTOp8GpZOCZjnv6fTG88S37ESb46HSTNo50IoX+g=;
 b=TKTbbJw7nlWcJXXgdzBbLRqR1GVILtVgruMcUtDOTXhKYGAZheZLLzL3RQJuUFmkEP
 qgP+SP6UDQQg4nzg8wEkUb2L9+tStXnk2jxQQXSF5z9IOIqV42nGxz5dDs2GNEj5Cyyh
 tDhw0xEuyPbZDhzXcmgYdMgxXdqGjWsmWJG8M9HpDXM8lJ8FjIod8N7M6n6esMwvRLOg
 AG3dQTyF8d17yxT/6sSSyxgwUNKxOlobP0ZaAHsAxGbic3Mps6YJnxXwvxsbJbTpCndI
 h1yRRniLtQQsLv1M48kdctWa5TxUD4rycIcsZcnp/z9s6B8s99poNZWkoU3QOIJEpuXD
 s7xA==
X-Gm-Message-State: AOJu0YwkSeu1lI1Ox9WAhxgOvq1S/gk1pktLcjjRaye9mPg5i0Cd8Ss0
 Ck77H2OWf0Sv1M+GlmMbldwh0ByqpuxtG/A5TBLOeYwRspQqm8wevEx541MVdmMuxe0bd7JxSAo
 IEaEuYKU=
X-Gm-Gg: ATEYQzzNjSpvS5GsQPVji8s6YJejKnoV0UUOJ5F0fu7hf64RO1rJbHLQCkRX8fjJdQw
 skCMlcoyZm5MGseS8qu0+YQgjGRTSo2I0UgQAsOyP2iS4odWi+Ct+Re2kLq9l7c1Sw3/T6kdkzf
 XqaQMwovs4bo6LsVZeUC/CCy8kljP3wM9GIP8UZbgSAObh3FneTi0xSTow+r/NUPicbRYZss9bP
 1yQoXoTCdhTVmkPofiUhvq+rPsUPhktpWXNTCA4PJDbSLus/+USt3DX/d7SiuHA3UB1gK+mxuPA
 Ud4yNZ7wCLimLZXqN/PLt7jhj+osGq7KqapnoaPwPDgy9wjOHsf1KZXhcTunC81pGIviDOcLKza
 nP7xSkmgsg52UfyT4ZZE89EsFvEcA6ruFsznrQTEh75psmwT2Cqn6aEdS6Cj/PN6F8WaAzFFlay
 Jy/wxDadBrW8HPgagVpPBsnjs=
X-Received: by 2002:a05:6402:4618:b0:669:d766:6c93 with SMTP id
 4fb4d7f45d1cf-66b28c6ada7mr6491307a12.16.1774909749504; 
 Mon, 30 Mar 2026 15:29:09 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-66c07ab1634sm1015164a12.16.2026.03.30.15.29.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 15:29:07 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E026D5F713;
 Mon, 30 Mar 2026 23:29:06 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [RFC PATCH] hw/display: modernise the vga debug code (!!GenAI!!)
Date: Mon, 30 Mar 2026 23:28:59 +0100
Message-ID: <20260330222900.982404-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <6c3214ac-1679-d9db-2fed-c934fde8ddf2@eik.bme.hu>
References: <6c3214ac-1679-d9db-2fed-c934fde8ddf2@eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x535.google.com
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

Remove dead code, replace debug prints with trace points.

Link: https://patchew.org/QEMU/20260330140656.46FE55969F2@zero.eik.bme.hu/
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
As an experiment I prompted Gemini with the thread contents and asked
it to make the changes. It cost about 9p in inference and I would
argue this barely counts as copyrightable as it is a simple
transformation of existing patterns.
---
 hw/display/vga.c        | 89 ++++++++---------------------------------
 hw/display/trace-events | 11 +++++
 2 files changed, 27 insertions(+), 73 deletions(-)

diff --git a/hw/display/vga.c b/hw/display/vga.c
index ee7d97b5c21..081a3b2576c 100644
--- a/hw/display/vga.c
+++ b/hw/display/vga.c
@@ -40,9 +40,6 @@
 #include "migration/vmstate.h"
 #include "trace.h"
 
-//#define DEBUG_VGA_MEM
-//#define DEBUG_VGA_REG
-
 bool have_vga = true;
 
 /* 16 state changes per vertical frame @60 Hz */
@@ -201,9 +198,6 @@ static void vga_precise_update_retrace_info(VGACommonState *s)
     int vretr_end_line;
 
     int dots;
-#if 0
-    int div2, sldiv2;
-#endif
     int clocking_mode;
     int clock_sel;
     const int clk_hz[] = {25175000, 28322000, 25175000, 25175000};
@@ -245,40 +239,9 @@ static void vga_precise_update_retrace_info(VGACommonState *s)
     r->hend = r->hstart + hretr_end_char + 1;
     r->htotal = htotal_chars;
 
-#if 0
-    div2 = (s->cr[VGA_CRTC_MODE] >> 2) & 1;
-    sldiv2 = (s->cr[VGA_CRTC_MODE] >> 3) & 1;
-    printf (
-        "hz=%f\n"
-        "htotal = %d\n"
-        "hretr_start = %d\n"
-        "hretr_skew = %d\n"
-        "hretr_end = %d\n"
-        "vtotal = %d\n"
-        "vretr_start = %d\n"
-        "vretr_end = %d\n"
-        "div2 = %d sldiv2 = %d\n"
-        "clocking_mode = %d\n"
-        "clock_sel = %d %d\n"
-        "dots = %d\n"
-        "ticks/char = %" PRId64 "\n"
-        "\n",
-        (double) NANOSECONDS_PER_SECOND / (r->ticks_per_char * r->total_chars),
-        htotal_chars,
-        hretr_start_char,
-        hretr_skew_chars,
-        hretr_end_char,
-        vtotal_lines,
-        vretr_start_line,
-        vretr_end_line,
-        div2, sldiv2,
-        clocking_mode,
-        clock_sel,
-        clk_hz[clock_sel],
-        dots,
-        r->ticks_per_char
-        );
-#endif
+    trace_vga_update_retrace_info(htotal_chars, vtotal_lines,
+                                  vretr_start_line, vretr_end_line,
+                                  dots, r->ticks_per_char);
 }
 
 static uint8_t vga_precise_retrace(VGACommonState *s)
@@ -358,9 +321,7 @@ uint32_t vga_ioport_read(void *opaque, uint32_t addr)
             break;
         case VGA_SEQ_D:
             val = s->sr[s->sr_index];
-#ifdef DEBUG_VGA_REG
-            printf("vga: read SR%x = 0x%02x\n", s->sr_index, val);
-#endif
+            trace_vga_read_sr(s->sr_index, val);
             break;
         case VGA_PEL_IR:
             val = s->dac_state;
@@ -386,9 +347,7 @@ uint32_t vga_ioport_read(void *opaque, uint32_t addr)
             break;
         case VGA_GFX_D:
             val = s->gr[s->gr_index];
-#ifdef DEBUG_VGA_REG
-            printf("vga: read GR%x = 0x%02x\n", s->gr_index, val);
-#endif
+            trace_vga_read_gr(s->gr_index, val);
             break;
         case VGA_CRT_IM:
         case VGA_CRT_IC:
@@ -397,9 +356,7 @@ uint32_t vga_ioport_read(void *opaque, uint32_t addr)
         case VGA_CRT_DM:
         case VGA_CRT_DC:
             val = s->cr[s->cr_index];
-#ifdef DEBUG_VGA_REG
-            printf("vga: read CR%x = 0x%02x\n", s->cr_index, val);
-#endif
+            trace_vga_read_cr(s->cr_index, val);
             break;
         case VGA_IS1_RM:
         case VGA_IS1_RC:
@@ -467,9 +424,7 @@ void vga_ioport_write(void *opaque, uint32_t addr, uint32_t val)
         s->sr_index = val & 7;
         break;
     case VGA_SEQ_D:
-#ifdef DEBUG_VGA_REG
-        printf("vga: write SR%x = 0x%02x\n", s->sr_index, val);
-#endif
+        trace_vga_write_sr(s->sr_index, val);
         s->sr[s->sr_index] = val & sr_mask[s->sr_index];
         if (s->sr_index == VGA_SEQ_CLOCK_MODE) {
             s->update_retrace_info(s);
@@ -498,9 +453,7 @@ void vga_ioport_write(void *opaque, uint32_t addr, uint32_t val)
         s->gr_index = val & 0x0f;
         break;
     case VGA_GFX_D:
-#ifdef DEBUG_VGA_REG
-        printf("vga: write GR%x = 0x%02x\n", s->gr_index, val);
-#endif
+        trace_vga_write_gr(s->gr_index, val);
         s->gr[s->gr_index] = val & gr_mask[s->gr_index];
         vbe_update_vgaregs(s);
         vga_update_memory_access(s);
@@ -511,9 +464,7 @@ void vga_ioport_write(void *opaque, uint32_t addr, uint32_t val)
         break;
     case VGA_CRT_DM:
     case VGA_CRT_DC:
-#ifdef DEBUG_VGA_REG
-        printf("vga: write CR%x = 0x%02x\n", s->cr_index, val);
-#endif
+        trace_vga_write_cr(s->cr_index, val);
         /* handle CR0-7 protection */
         if ((s->cr[VGA_CRTC_V_SYNC_END] & VGA_CR11_LOCK_CR0_CR7) &&
             s->cr_index <= VGA_CRTC_OVERFLOW) {
@@ -873,9 +824,7 @@ void vga_mem_writeb(VGACommonState *s, hwaddr addr, uint32_t val)
     uint32_t write_mask, bit_mask, set_mask;
     int plane = 0;
 
-#ifdef DEBUG_VGA_MEM
-    printf("vga: [0x" HWADDR_FMT_plx "] = 0x%02x\n", addr, val);
-#endif
+    trace_vga_vram_write(addr, val);
     /* convert to VGA memory offset */
     memory_map_mode = (s->gr[VGA_GFX_MISC] >> 2) & 3;
     addr &= 0x1ffff;
@@ -945,9 +894,7 @@ void vga_mem_writeb(VGACommonState *s, hwaddr addr, uint32_t val)
     if (sr(s, VGA_SEQ_MEMORY_MODE) & VGA_SR04_CHN_4M) {
         if (mask) {
             s->vram_ptr[(addr << 2) | plane] = val;
-#ifdef DEBUG_VGA_MEM
-            printf("vga: chain4: [0x" HWADDR_FMT_plx "]\n", addr);
-#endif
+            trace_vga_vram_write((addr << 2) | plane, val);
             s->plane_updated |= mask; /* only used to detect font change */
             memory_region_set_dirty(&s->vram, addr, 1);
         }
@@ -1021,10 +968,7 @@ do_write:
     ((uint32_t *)s->vram_ptr)[addr] =
         (((uint32_t *)s->vram_ptr)[addr] & ~write_mask) |
         (val & write_mask);
-#ifdef DEBUG_VGA_MEM
-    printf("vga: latch: [0x" HWADDR_FMT_plx "] mask=0x%08x val=0x%08x\n",
-           addr * 4, write_mask, val);
-#endif
+    trace_vga_vram_latch_write(addr << 2, write_mask, val);
     memory_region_set_dirty(&s->vram, addr << 2, sizeof(uint32_t));
 }
 
@@ -1660,11 +1604,10 @@ static void vga_draw_graphic(VGACommonState *s, int full_update)
         s->cursor_invalidate(s);
     }
 
-#if 0
-    printf("w=%d h=%d v=%d line_offset=%d cr[0x09]=0x%02x cr[0x17]=0x%02x linecmp=%d sr[0x01]=0x%02x\n",
-           width, height, v, line_offset, s->cr[9], s->cr[VGA_CRTC_MODE],
-           s->params.line_compare, sr(s, VGA_SEQ_CLOCK_MODE));
-#endif
+    trace_vga_draw_graphic(width, height, v, s->params.line_offset,
+                           s->cr[9], s->cr[VGA_CRTC_MODE],
+                           s->params.line_compare, sr(s, VGA_SEQ_CLOCK_MODE));
+
     addr1 = (s->params.start_addr * 4);
     y_start = -1;
     d = surface_data(surface);
diff --git a/hw/display/trace-events b/hw/display/trace-events
index 4bfc457fbac..c6591c90ca8 100644
--- a/hw/display/trace-events
+++ b/hw/display/trace-events
@@ -130,6 +130,17 @@ vga_std_read_io(uint32_t addr, uint32_t val) "addr 0x%x, val 0x%x"
 vga_std_write_io(uint32_t addr, uint32_t val) "addr 0x%x, val 0x%x"
 vga_vbe_read(uint32_t index, uint32_t val) "index 0x%x, val 0x%x"
 vga_vbe_write(uint32_t index, uint32_t val) "index 0x%x, val 0x%x"
+vga_vram_read(uint64_t addr, uint32_t val) "addr 0x%"PRIx64" val 0x%x"
+vga_vram_write(uint64_t addr, uint32_t val) "addr 0x%"PRIx64" val 0x%x"
+vga_vram_latch_write(uint64_t addr, uint32_t mask, uint32_t val) "addr 0x%"PRIx64" mask 0x%08x val 0x%08x"
+vga_read_sr(uint32_t index, uint32_t val) "index 0x%x, val 0x%x"
+vga_write_sr(uint32_t index, uint32_t val) "index 0x%x, val 0x%x"
+vga_read_gr(uint32_t index, uint32_t val) "index 0x%x, val 0x%x"
+vga_write_gr(uint32_t index, uint32_t val) "index 0x%x, val 0x%x"
+vga_read_cr(uint32_t index, uint32_t val) "index 0x%x, val 0x%x"
+vga_write_cr(uint32_t index, uint32_t val) "index 0x%x, val 0x%x"
+vga_draw_graphic(uint32_t w, uint32_t h, uint32_t v, uint32_t line_offset, uint32_t cr09, uint32_t cr17, uint32_t linecmp, uint32_t sr01) "w=%u h=%u v=%u line_offset=%u cr[0x09]=0x%02x cr[0x17]=0x%02x linecmp=%u sr[0x01]=0x%02x"
+vga_update_retrace_info(uint32_t htotal, uint32_t vtotal, uint32_t vretr_start, uint32_t vretr_end, uint32_t dots, uint64_t ticks_per_char) "htotal %u, vtotal %u, vretr_start %u, vretr_end %u, dots %u, ticks/char %"PRIu64
 
 # cirrus_vga.c
 vga_cirrus_read_io(uint32_t addr, uint32_t val) "addr 0x%x, val 0x%x"
-- 
2.47.3


