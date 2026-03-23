Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80097F483CC
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 16:55:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4iYZ-00087R-AN; Mon, 23 Mar 2026 12:55:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w4iYM-0007Vq-8K
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 12:54:59 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w4iYK-0000iE-C9
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 12:54:58 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-43a03cb1df9so409488f8f.1
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 09:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774284894; x=1774889694; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DydaDApGQyKIZilhgXGoxyDZiKo9keH82dkobi0tCBY=;
 b=klTm8mohRg+tQYjAqjxaAxZ57AfDe+29aoguGN/juTr7Kgn06d7iaXvkXmlFdp7jOc
 4MCS35BfY+ziJslcMMzID40Ln3mwuMppBQeEqrt2ic00rDhYdRDnr1GDwwzx57RyiNlI
 65A0W46gAsmlyXFkGob4H7OnB4PjXrJkCu1YeOUXYAbikwJ4+cozVYSvuqy31m1RI+pO
 iOGjMsT6hFY+pUe4atupQ+OmgmfipFUsiGVNxZV7TVJSbw47Lf4ivZEcf9wubo36tnyX
 VYJE1uInE/6WBHCVmcGaoA6U4FawGYAwvo/zAd8kynLg2ZhyqNdR1By+DYZwcXN9L3++
 G7mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774284894; x=1774889694;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=DydaDApGQyKIZilhgXGoxyDZiKo9keH82dkobi0tCBY=;
 b=NQ9gw7JufmLBneAvwJwyLT99oYWo4N0h6YNKmiGxlCVB8sXfpV4krVQiN7vJ6PTeDY
 iQeCkRbRf8B0exGoFSdgC36e/hnlUSVdaN4QO37wN9YIhVPorsiAuAfoCoRlo955BeE0
 Y/GOEkMCX4MOi9606HFBXWlJonjU7oo+UMkJWfU+qdxBYaKuoVSZ3SUuHKt8bi90u78u
 QhdOW592j11DuxhM1StOfv5Fmb3H5pSUPs8OuY0EpMBEv8v5dRrm8z3dGR5pvpCU6iGl
 A1tMGXIq3RIJjZ2zu2oma0um3rWMYRRwPTrCKf1iRZQBEg7pJnQoMASj6mfZ8RwMU2U1
 o8GA==
X-Gm-Message-State: AOJu0Yz5N131uNoa2DEzwpXSHMKAGh+0afeA0AM3Ju+wYT3ZLwgBBG0n
 79QmUcwDiKjSJhcp5HM/uD4uL4wf9plXmBSPvHeJOccYj2MKw/pspHbTbMmUDVbXhe5wOfHn5kw
 JHPSY9A8=
X-Gm-Gg: ATEYQzyUewZvykXHGXI8xg4YLkMw/U41dyxtLuIP8OL8PR4XhVXZFs59PcxG0zwPR87
 u0NJUb42ZfnpMrHZTZb8dZpfV3gxgCJk/06i5O/pJqLACLcRiSZqSiAinv6BpTvT6dSqA6T6tq3
 Y4Va86fAe2jX+enAk0Ordrd2r3+lDVFdkIUK6A5+gLetWhj9w/LsO5UBpjG3Y54SwIxu7JTMJBL
 CIGe52h+SGnrut44bJX+8DnGyek2aE4XGbfKh0hHV5EmdGjVwXEoBsSOLE3eduvy0xIA+aupJec
 G7OD33YxChMH7fATXkqlDmZsCbk4G9e59sNeUrXkvuoi5Ip69g8qt+8NHZJRI82TJBx+uCesv0A
 AFeNgDKgAiqUnlyzdatPMjaNo6ly0pqrqhyv7y/bgc7F0Vm4FprlHosbdriWK22623oxe1LM8Ba
 0NSR6QtMfRTwKt4aIU3cm9pSMQLMeGPvo/RHCeoKRYk/MwX2G06ruhs8vf/W0ZjmZbR+xrLmaz
X-Received: by 2002:a05:6000:420c:b0:439:c62a:6dc2 with SMTP id
 ffacd0b85a97d-43b6427973bmr20347789f8f.41.1774284894237; 
 Mon, 23 Mar 2026 09:54:54 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b6470c239sm30915537f8f.27.2026.03.23.09.54.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 23 Mar 2026 09:54:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 23/27] ati-vga: Simplify pointer image handling
Date: Mon, 23 Mar 2026 17:52:14 +0100
Message-ID: <20260323165218.96607-24-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323165218.96607-1-philmd@linaro.org>
References: <20260323165218.96607-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

From: BALATON Zoltan <balaton@eik.bme.hu>

Rewrite reading of mouse pointer image. I am not sure this is entirely
correct but appears to work at least on little endian host with PPC
guests using little or big endian frame buffer (MorphOS and MacOS) but
still produces broken pointer image with Linux where I am not sure if
it is a guest driver bug or still missing something.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Message-ID: <b9de530074b954d661a0eb9b8b4ad82a66085456.1774110169.git.balaton@eik.bme.hu>
[PMD: Replaced BIT() -> BIT_ULL() in ati_cursor_draw_line()]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/display/ati.c | 57 ++++++++++++++++++++++--------------------------
 1 file changed, 26 insertions(+), 31 deletions(-)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index f74dd1efc0b..c054c9aa7a2 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -141,27 +141,24 @@ static void ati_vga_switch_mode(ATIVGAState *s)
 /* Used by host side hardware cursor */
 static void ati_cursor_define(ATIVGAState *s)
 {
-    uint8_t data[1024];
+    uint64_t data[128];
     uint32_t srcoff;
-    int i, j, idx = 0;
 
     if ((s->regs.cur_offset & BIT(31)) || s->cursor_guest_mode) {
         return; /* Do not update cursor if locked or rendered by guest */
     }
     /* FIXME handle cur_hv_offs correctly */
-    srcoff = s->regs.cur_offset -
-        (s->regs.cur_hv_offs >> 16) - (s->regs.cur_hv_offs & 0xffff) * 16;
-    for (i = 0; i < 64; i++) {
-        for (j = 0; j < 8; j++, idx++) {
-            data[idx] = vga_read_byte(&s->vga, srcoff + i * 16 + j);
-            data[512 + idx] = vga_read_byte(&s->vga, srcoff + i * 16 + j + 8);
-        }
+    srcoff = s->regs.cur_offset - (s->regs.cur_hv_offs >> 16) -
+             (s->regs.cur_hv_offs & 0xffff) * 16;
+    for (int i = 0; i < 64; i++, srcoff += 16) {
+        data[i] = ldq_le_p(&s->vga.vram_ptr[srcoff]);
+        data[i + 64] = ldq_le_p(&s->vga.vram_ptr[srcoff + 8]);
     }
     if (!s->cursor) {
         s->cursor = cursor_alloc(64, 64);
     }
     cursor_set_mono(s->cursor, s->regs.cur_color1, s->regs.cur_color0,
-                    &data[512], 1, &data[0]);
+                    (uint8_t *)&data[64], 1, (uint8_t *)&data[0]);
     dpy_cursor_define(s->vga.con, s->cursor);
 }
 
@@ -196,9 +193,9 @@ static void ati_cursor_invalidate(VGACommonState *vga)
 static void ati_cursor_draw_line(VGACommonState *vga, uint8_t *d, int scr_y)
 {
     ATIVGAState *s = container_of(vga, ATIVGAState, vga);
-    uint32_t srcoff;
+    uint32_t h, srcoff, color;
+    uint64_t abits, xbits, mask;
     uint32_t *dp = (uint32_t *)d;
-    int i, j, h, idx = 0;
 
     if (!(s->regs.crtc_gen_cntl & CRTC2_CUR_EN) ||
         scr_y < vga->hw_cursor_y || scr_y >= vga->hw_cursor_y + 64 ||
@@ -209,26 +206,24 @@ static void ati_cursor_draw_line(VGACommonState *vga, uint8_t *d, int scr_y)
     srcoff = s->cursor_offset + (scr_y - vga->hw_cursor_y) * 16;
     dp = &dp[vga->hw_cursor_x];
     h = ((s->regs.crtc_h_total_disp >> 16) + 1) * 8;
-    for (i = 0; i < 8; i++) {
-        uint32_t color;
-        uint8_t abits = vga_read_byte(vga, srcoff + i);
-        uint8_t xbits = vga_read_byte(vga, srcoff + i + 8);
-        for (j = 0; j < 8; j++, abits <<= 1, xbits <<= 1, idx++) {
-            if (vga->hw_cursor_x + idx >= h) {
-                return; /* end of screen, don't span to next line */
-            }
-            if (abits & BIT(7)) {
-                if (xbits & BIT(7)) {
-                    color = dp[idx] ^ 0xffffffff; /* complement */
-                } else {
-                    continue; /* transparent, no change */
-                }
-            } else {
-                color = (xbits & BIT(7) ? s->regs.cur_color1 :
-                                          s->regs.cur_color0) | 0xff000000;
-            }
-            dp[idx] = color;
+    abits = ldq_be_p(&vga->vram_ptr[srcoff]);
+    xbits = ldq_be_p(&vga->vram_ptr[srcoff + 8]);
+    mask = BIT_ULL(63);
+    for (int i = 0; i < 64; i++, mask >>= 1) {
+        if (vga->hw_cursor_x + i >= h) {
+            return; /* end of screen, don't span to next line */
         }
+        if (abits & mask) {
+            if (xbits & mask) {
+                color = dp[i] ^ 0xffffffff; /* complement */
+            } else {
+                continue; /* transparent, no change */
+            }
+        } else {
+            color = (xbits & mask ? s->regs.cur_color1 :
+                                    s->regs.cur_color0) | 0xff000000;
+        }
+        dp[i] = color;
     }
 }
 
-- 
2.53.0


