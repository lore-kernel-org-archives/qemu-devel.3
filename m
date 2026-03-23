Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD083F483CC
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 16:54:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4iXq-0005j5-Tw; Mon, 23 Mar 2026 12:54:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w4iXi-0005Yf-Dz
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 12:54:22 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w4iXg-0000dI-2h
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 12:54:18 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-43b40003d13so2722084f8f.2
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 09:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774284854; x=1774889654; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=eVldjBV0nVVV4/9MikBff2Nx48pteq1xXd1LtYfWGrc=;
 b=PjBY0ljQpLILOVf/sTmYU3ffLeFxGuFrtetmRuncziLR8ZASdnTHJxSbYKp56Oaf8s
 f56/w27+L/tDgBAuH3f7ZfSA4ktdk77Q5v5btNiDl4E1fcd5ekKzR/9Go8X3jvWR+k3B
 m2E71joXjPrQHf5Cz7Ox1Su8szFAJVoaUWOAPl/bo1J5Sp2gqeXPJjNdJMZ3/vIXTJhY
 zpTbUxxUGSvZGdy2PZas1hkLZgfhsjd0noqTpKteLEqRqSwMb+sRw+vrDtzLmOU/ICOt
 6EJxr6UUFBGINNAefCCMXpnD/UfnEoTsmytTUdgPKNjO+L1+8KRI3+qeVesdmMFb7QdT
 zHXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774284854; x=1774889654;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=eVldjBV0nVVV4/9MikBff2Nx48pteq1xXd1LtYfWGrc=;
 b=JHPSk+HbQMN3Q55mwRleXY2/QTVMlkEFgMxSCXQCrlv3AgZ38FHJXLnGDn8j5P7rt1
 m4dofKMMEDdNVMNNeHU3uayPDm4ME0S2+1oItUinbO0rbzmvMw+8dY64FeXrR1Sq+VT2
 hKLqZebjVEHiLpB6NwQvcxxVUjlTUByABnZ3XkJ3gnc/Btlz8jslk2QgWLRjvLEozkAK
 foxu9W94NPSEorF8hoJ2Zr05qlC904idKiVDRfpJ9W+bsgnF46hYoWnP28yLlgZrMqTd
 DmjtaAYX4H4AeHPMaHT0J1Ik40noUx6xk/v8vmOf71/Bg2Sdyq65pjwmfb1+gsd30E8e
 XvYg==
X-Gm-Message-State: AOJu0YxDYZX12nbII5OGu5+h9NxR5yEN7ti23edCHjv0DnWH7oTxvU6D
 qMOS1EOy6rzKlesderRf+NqgwXq9tbZTv3Yf+1JiIOLprX0H3VLYk9p1PfRln/0xPaTUAZqof7K
 Lr+VO0HQ=
X-Gm-Gg: ATEYQzy2GddFlSli2Ogj47sO0WfuPwqtxi5H1VXaVeb1Q8BlsmIlrUZq8VVTrvmDta+
 uWI2i0yPS3OVBoPqeJdwg0Jm0hcCbh5RkrSZHBpq0quioCe1xl1VSuCw/qOHWjBnS84RtdyhElE
 7soCvdhIhF/K2wpUzMWaNBV+a/nNA58dOw8GKqLHFvWWgYAoof55Z/Fe7o9Xd2g8gIhhHh2LWx/
 qGrh148un0bIw+e3dvW0trkMqk+tNtyiGCDTRm6mSPhRXF0DH4N7LNPXmX+0/SjZDmqAVzPGmE7
 kcHxpXVkig3isXVJVyUBoZUZj0itzNBi6Z8A07Kh0PWlfLge6JkRi6jx7D4IBD9unNXdFOtdzzD
 TrgbrWrDhJSwKQn4XkE8cFjIzp+d/In2zjcgbS8yWby73Ho+tfLW0LdDgcIJYIeLh8oH6RdVt0Q
 B5MaS8RNkrzwnp8uoHnhOV3vJiL1xzk25r9JM9n+kboboXXTuVOkyllW1UczvT2hT711mVMEgW
X-Received: by 2002:a05:6000:26c8:b0:439:bcb8:54b7 with SMTP id
 ffacd0b85a97d-43b6424b9eemr19335140f8f.15.1774284853906; 
 Mon, 23 Mar 2026 09:54:13 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b64714e2esm33143191f8f.32.2026.03.23.09.54.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 23 Mar 2026 09:54:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 17/27] ati-vga: Fix colors when frame buffer endianness does
 not match host
Date: Mon, 23 Mar 2026 17:52:08 +0100
Message-ID: <20260323165218.96607-18-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323165218.96607-1-philmd@linaro.org>
References: <20260323165218.96607-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

When writing pixels we have to take into account if the frame buffer
endianness matches the host endianness or we need to swap to correct
endianness. This caused wrong colors e.g. with PPC Linux guest that
uses big endian frame buffer when running on little endian host.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Tested-by: Chad Jablonski <chad@jablonski.xyz>
Reviewed-by: Chad Jablonski <chad@jablonski.xyz>
Message-ID: <759ed5e3b019cce94e9a4ef003f1fc2e0cea2ec1.1774110169.git.balaton@eik.bme.hu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/display/ati_2d.c | 40 +++++++++++++++++++++++++++++-----------
 1 file changed, 29 insertions(+), 11 deletions(-)

diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
index 37fe6c17ee9..0cbbdc33f47 100644
--- a/hw/display/ati_2d.c
+++ b/hw/display/ati_2d.c
@@ -50,6 +50,7 @@ typedef struct {
     bool host_data_active;
     bool left_to_right;
     bool top_to_bottom;
+    bool need_swap;
     uint32_t frgd_clr;
     const uint8_t *palette;
     const uint8_t *vram_end;
@@ -89,6 +90,7 @@ static void setup_2d_blt_ctx(const ATIVGAState *s, ATI2DCtx *ctx)
     ctx->host_data_active = s->host_data.active;
     ctx->left_to_right = s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT;
     ctx->top_to_bottom = s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM;
+    ctx->need_swap = HOST_BIG_ENDIAN != s->vga.big_endian_fb ? true : false;
     ctx->frgd_clr = s->regs.dp_brush_frgd_clr;
     ctx->palette = s->vga.palette;
     ctx->dst_offset = s->regs.dst_offset;
@@ -131,6 +133,17 @@ static void setup_2d_blt_ctx(const ATIVGAState *s, ATI2DCtx *ctx)
             (ctx->top_to_bottom ? 'v' : '^'));
 }
 
+static uint32_t make_filler(int bpp, uint32_t color)
+{
+    if (bpp < 24) {
+        color |= color << 16;
+        if (bpp < 15) {
+            color |= color << 8;
+        }
+    }
+    return color;
+}
+
 static bool ati_2d_do_blt(ATI2DCtx *ctx, uint8_t use_pixman)
 {
     QemuRect vis_src, vis_dst;
@@ -255,7 +268,7 @@ static bool ati_2d_do_blt(ATI2DCtx *ctx, uint8_t use_pixman)
 
         switch (ctx->rop3) {
         case ROP3_PATCOPY:
-            filler = ctx->frgd_clr;
+            filler = make_filler(ctx->bpp, ctx->frgd_clr);
             break;
         case ROP3_BLACKNESS:
             filler = 0xffUL << 24 | rgb_to_pixel32(ctx->palette[0],
@@ -268,10 +281,12 @@ static bool ati_2d_do_blt(ATI2DCtx *ctx, uint8_t use_pixman)
                                                    ctx->palette[5]);
             break;
         }
-
         DPRINTF("pixman_fill(%p, %ld, %d, %d, %d, %d, %d, %x)\n",
                 ctx->dst_bits, ctx->dst_stride / sizeof(uint32_t), ctx->bpp,
                 vis_dst.x, vis_dst.y, vis_dst.width, vis_dst.height, filler);
+        if (ctx->need_swap) {
+            bswap32s(&filler);
+        }
 #ifdef CONFIG_PIXMAN
         if (!(use_pixman & BIT(0)) ||
             !pixman_fill((uint32_t *)ctx->dst_bits,
@@ -325,11 +340,8 @@ void ati_2d_blt(ATIVGAState *s)
 bool ati_host_data_flush(ATIVGAState *s)
 {
     ATI2DCtx ctx, chunk;
-    uint32_t fg = s->regs.dp_src_frgd_clr;
-    uint32_t bg = s->regs.dp_src_bkgd_clr;
     unsigned bypp, pix_count, row, col, idx;
     uint8_t pix_buf[ATI_HOST_DATA_ACC_BITS * sizeof(uint32_t)];
-    uint32_t byte_pix_order = s->regs.dp_datatype & DP_BYTE_PIX_ORDER;
     uint32_t src_source = s->regs.dp_mix & DP_SRC_SOURCE;
     uint32_t src_datatype = s->regs.dp_datatype & DP_SRC_DATATYPE;
 
@@ -360,21 +372,27 @@ bool ati_host_data_flush(ATIVGAState *s)
     }
 
     bypp = ctx.bpp / 8;
-
+    pix_count = ATI_HOST_DATA_ACC_BITS;
     if (src_datatype == SRC_COLOR) {
-        pix_count = ATI_HOST_DATA_ACC_BITS / ctx.bpp;
-        memcpy(pix_buf, &s->host_data.acc[0], sizeof(s->host_data.acc));
+        pix_count /= ctx.bpp;
+        memcpy(pix_buf, s->host_data.acc, sizeof(s->host_data.acc));
     } else {
-        pix_count = ATI_HOST_DATA_ACC_BITS;
         /* Expand monochrome bits to color pixels */
+        uint32_t byte_pix_order = s->regs.dp_datatype & DP_BYTE_PIX_ORDER;
+        uint32_t fg = make_filler(ctx.bpp, s->regs.dp_src_frgd_clr);
+        uint32_t bg = make_filler(ctx.bpp, s->regs.dp_src_bkgd_clr);
+
+        if (ctx.need_swap) {
+            bswap32s(&fg);
+            bswap32s(&bg);
+        }
         idx = 0;
         for (int word = 0; word < 4; word++) {
             for (int byte = 0; byte < 4; byte++) {
                 uint8_t byte_val = s->host_data.acc[word] >> (byte * 8);
                 for (int i = 0; i < 8; i++) {
                     bool is_fg = byte_val & BIT(byte_pix_order ? i : 7 - i);
-                    uint32_t color = is_fg ? fg : bg;
-                    stn_he_p(&pix_buf[idx], bypp, color);
+                    stn_he_p(&pix_buf[idx], bypp, is_fg ? fg : bg);
                     idx += bypp;
                 }
             }
-- 
2.53.0


