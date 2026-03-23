Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9D6AF483D7
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 16:55:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4iYS-0007Vn-20; Mon, 23 Mar 2026 12:55:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w4iY8-000779-Al
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 12:54:46 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w4iY6-0000hR-Od
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 12:54:44 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-48540d21f7dso35881405e9.0
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 09:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774284881; x=1774889681; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=XhjdKcFonryL9/cN+szncOyrJjS51ht311b0sqzgNHI=;
 b=SKYWq9e73S5Hgynf4GCrdkgWI6nszDoMQxwntk95KKBKEY9XcAut/HXIkjkxnvgmNX
 SiHa4uIZ9rvQRIjWjQa1D3cXFPsiP5+jo+mwKJ2+WPpK1348DwWoLzsyFcZBBmvdvSqE
 MllzMWmTOVdFYR67XpfVCc2M3Ele1P/rt37dNK585xlDnDHoGPuvW+y1GddZ2J+cRLYa
 PB/S9xO0flLNIYCbZBnGiUBpqCkbk2YclfF7dtvam00exDqrqEI/JY5xu2iLotnoeV+d
 g0waholsciAS6I4twmUksLO9DUG6lm7JMcbd8+nZxB3ZNZNkPVfnTm67SzXYogwyPd8d
 m+7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774284881; x=1774889681;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=XhjdKcFonryL9/cN+szncOyrJjS51ht311b0sqzgNHI=;
 b=QF11rTDxEBm88s3E/qH3P83O+fIxzbNl61G7zJ05gQHJEwn8TFhzU3KIPTDi639vPs
 SHSODfENP+GFOX1UlS9KeyXOyK1HkHH4egvVBdYpKmgAzV86KwFLOGz4XSqBw1vS0giF
 IN8ItUznuaxu1Q00GYXr4xTBiH6p7v5GXzbqpLikWkk9NM0eP3emU+5iowscHMFmvypf
 AyWIjFM04XbXbhIY2vQTC9vLJPnAbGkLZNpCG532XmjxCxWA2Fnm905wSBbQ07w4GiVT
 opei6ZREOeBL0kgSn0xLkf0DuVTqv87rawzc4S6R+UlTAwopiq2zUwxFKrFNIwSKqKP6
 Mkng==
X-Gm-Message-State: AOJu0YxRockme1V9O1Hvxw3e3b4Koj2E+owX9eQlGlSS6IUDP2NQzS9t
 KElYMyEHcnj8P0vWUePsHr4uyHt3KWTuSBtbdchEga+2mG3xLOqEOf+TRhDURyiKIAWtRQOkEcJ
 CaP03LKY=
X-Gm-Gg: ATEYQzxILAxJU62R47EZ0xKFzcq/82kyLLgUW3hEyFz9jdXp3vpOlGZelwmJijI4F1z
 DQ34Bvdpbh1ltcjKSQ9AvxShZ8Y+/l4hDtctqGkQYswWHEXbUmcfUyR8FFUEeL758OF/rKZnRDm
 Pe74o/ovgZ6Ov0XCSXkdtnYP8xwIZ555HCh9UyMth4gBx+G1YQKJcSI9nrbO9ohoiTO2epeZFHN
 1N7GFm3QFMT/Gmd8FKLWNhNKzBtShMTgwVehzb242s/XHlanNc4dSzDasIS0XbRDntxTutUwaZB
 9oMVqteffnJeqyjyh2x1USWP65tnvrMr/L05q33msDAimRRK4ai0gWK3DSv9AWYwPb71UfxGdU5
 dnHYHsjm9qg5GUvilm3R5UFRI86tLGEWdh4rt5EEK+4exI8ntUtjXhLhZRutO31s4NXuEDJsko+
 n8ZFbx2SIqEavp3WWxw+shaivmGVJ0gTRKBBu4BgSofKcNofIpgWTr4LGfRxc8CtVaoaSZ6boq
X-Received: by 2002:a05:600c:3f0d:b0:483:6d42:25c6 with SMTP id
 5b1f17b1804b1-486ff033f97mr193078895e9.23.1774284880918; 
 Mon, 23 Mar 2026 09:54:40 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486f8b949e1sm601085695e9.9.2026.03.23.09.54.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 23 Mar 2026 09:54:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 21/27] ati-vga: Fix display updates in non-32 bit modes
Date: Mon, 23 Mar 2026 17:52:12 +0100
Message-ID: <20260323165218.96607-22-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323165218.96607-1-philmd@linaro.org>
References: <20260323165218.96607-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

The memory_region_set_dirty used to mark changes should use stride
value in vram which is normally only the same as surface_stride in 32
bit modes. This caused missed updates in 8 and 16 bit modes.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Chad Jablonski <chad@jablonski.xyz>
Message-ID: <6e1b83ef3fe7a1ebc246b474eb2b0c7cd05d5deb.1774110169.git.balaton@eik.bme.hu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/display/ati_2d.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
index cf2d4a08e29..23527b2c505 100644
--- a/hw/display/ati_2d.c
+++ b/hw/display/ati_2d.c
@@ -70,6 +70,7 @@ static void ati_set_dirty(VGACommonState *vga, const ATI2DCtx *ctx)
 {
     DisplaySurface *ds = qemu_console_surface(vga->con);
 
+    (void)ds;
     DPRINTF("%p %u ds: %p %d %d rop: %x\n", vga->vram_ptr, vga->vbe_start_addr,
             surface_data(ds), surface_stride(ds), surface_bits_per_pixel(ds),
             ctx->rop3 >> 16);
@@ -78,8 +79,8 @@ static void ati_set_dirty(VGACommonState *vga, const ATI2DCtx *ctx)
         vga->vbe_regs[VBE_DISPI_INDEX_YRES] * vga->vbe_line_offset) {
         memory_region_set_dirty(&vga->vram,
                                 vga->vbe_start_addr + ctx->dst_offset +
-                                ctx->dst.y * surface_stride(ds),
-                                ctx->dst.height * surface_stride(ds));
+                                ctx->dst.y * ctx->dst_stride,
+                                ctx->dst.height * ctx->dst_stride);
     }
 }
 
-- 
2.53.0


