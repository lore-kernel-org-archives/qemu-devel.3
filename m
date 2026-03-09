Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A394FF41808
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 16:01:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzd0P-0006S9-Fh; Mon, 09 Mar 2026 11:58:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzcz3-00047V-KR
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:57:30 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzcz2-0000ql-3W
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:57:29 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4806cc07ce7so136747335e9.1
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 08:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773071846; x=1773676646; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=P6b3kfLb5C5KN4L7wqKNdzZRULJ5wfyOi/20ivvG1AI=;
 b=LTJUrE4CmWjr1+YPTN6B78TZZ3SIFc34tDtynKAezn5ERp37ctwxIXn1h4jHOWN2E0
 41kkHIGKXr82Nvh1jJENacP+konTC90CcMkFtUqZNJ1aazMqSlyX5Ufsp8ncnyy6rnvw
 Or7jYcujAa05DpqobiiU3r0yuALcGlfd+PVO/Up/0GFClX292qAjfUxdz1q6imO9EM7O
 ppYL4/mjWDutwvYdSxow7B0oiAJYdHQsYLjjHmSQ+v1iSuCxrr2IE1DhOXa1YZBtLRfP
 3xEDT8KzAMp8k7yeJXYsMtZ/arYqjFjLo3okkoRV6X+zq3J52ePvMZo5+GyL8rdY94qT
 VBlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773071846; x=1773676646;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=P6b3kfLb5C5KN4L7wqKNdzZRULJ5wfyOi/20ivvG1AI=;
 b=LPR/O4Ua6DtRN9xa/maT80EK9uDotRreKwdLFKRiFpuJpDgG+8fQuB8UhL/FeBpDBp
 ubggmIgZvpsoptiazjiRPkw1iOFG6N91MPrfla1vg74lI8LEiYWjCGqwYyvyALjU3Z0s
 4ysIdRbVIhJHSnXsGVmtmEIrRL12ytdkFkKnztZFRTqkBxNTGyYDv1ilh35QfMgj4KhK
 2YJNBDEnnV8GZT/0EZlHpdes81598zP+20BQpoKtpp4kUI0kWnUjgaHidDTnhdr1sUA5
 +kPd1RGnEw9KZQd1zVKbEJ00uuHPSNj3YnDAqVJhFOTRWOfXL+MlXQkmM4tGt/4+CdL5
 BYKA==
X-Gm-Message-State: AOJu0YyAvOZEGPrv69vROo17ud5N/FVyzlWMI+vhRI4fFa9uwQ4QZRcv
 QxYTYQ18ZaOtLqflctB1QfvpDmCJNDMNDcKXUXxDRDLULQi0F4cTpW9sBkTKi3e6r6XOoxUbQyv
 oxOvQ1OE=
X-Gm-Gg: ATEYQzwsCaFt8uDD6HyHMTWCQOVp+chljzqXRI8mm4Z67ADcY0aE4br2V8dTTUUB03v
 Tj6i3KNnWMmiK5DxQwtmrKRE9j8Q4auhA95grXcywQ+qxbveRYz7sSKT3qLh5Ucs1WZrcPcUEjN
 UJDcZRHRK2BVjC/7ZVsY2crQqgNDZrbr2guDxTQ0zNeWNPXPxvXZNO1KxteF0ebbNmV0ZUF3zzq
 Jtlldm2DYBs6GsQAqnmJhHlCFVtOM5vIURZzWfKvxcn6OyatE6Eh1JlbDU0oGU20D8mEtwLfcBq
 yk6dVlbmc9CH3e5jEjAibAq47WiGjDVDoQC18NC9IMglKC+jr74znlgB25yTJW/FHnaNU4jL8f9
 HNDcIsYPr22Qh0oYxpEkhQt5stQJFJ3m/qEafo80+gWBeoFLfm3BesEltNdb71T7ia4WixZ4kPM
 W2qZHdpi67Zz2hTUzSjcCUjFKSakx7Fur49EX1RplZ2pAc5WcVUSvK+JCtW9+doSXAeNg45AGtC
 Z8kciso9YQ=
X-Received: by 2002:a05:600c:b93:b0:479:1b0f:dfff with SMTP id
 5b1f17b1804b1-48526923bd3mr183562405e9.10.1773071846251; 
 Mon, 09 Mar 2026 08:57:26 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48541a6bbcesm1188195e9.3.2026.03.09.08.57.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Mar 2026 08:57:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 45/49] ati-vga: Simplify hw cursor drawing
Date: Mon,  9 Mar 2026 16:52:15 +0100
Message-ID: <20260309155219.62400-46-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309155219.62400-1-philmd@linaro.org>
References: <20260309155219.62400-1-philmd@linaro.org>
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

Avoid calculating index at every step when we can just count the
position.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Chad Jablonski <chad@jablonski.xyz>
Message-ID: <90b49357b6bf80bcf8962331575ffd16a96b706a.1773009887.git.balaton@eik.bme.hu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/display/ati.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index bb9e0bba282..2c649e940b3 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -198,7 +198,7 @@ static void ati_cursor_draw_line(VGACommonState *vga, uint8_t *d, int scr_y)
     ATIVGAState *s = container_of(vga, ATIVGAState, vga);
     uint32_t srcoff;
     uint32_t *dp = (uint32_t *)d;
-    int i, j, h;
+    int i, j, h, idx = 0;
 
     if (!(s->regs.crtc_gen_cntl & CRTC2_CUR_EN) ||
         scr_y < vga->hw_cursor_y || scr_y >= vga->hw_cursor_y + 64 ||
@@ -213,10 +213,10 @@ static void ati_cursor_draw_line(VGACommonState *vga, uint8_t *d, int scr_y)
         uint32_t color;
         uint8_t abits = vga_read_byte(vga, srcoff + i);
         uint8_t xbits = vga_read_byte(vga, srcoff + i + 8);
-        for (j = 0; j < 8; j++, abits <<= 1, xbits <<= 1) {
+        for (j = 0; j < 8; j++, abits <<= 1, xbits <<= 1, idx++) {
             if (abits & BIT(7)) {
                 if (xbits & BIT(7)) {
-                    color = dp[i * 8 + j] ^ 0xffffffff; /* complement */
+                    color = dp[idx] ^ 0xffffffff; /* complement */
                 } else {
                     continue; /* transparent, no change */
                 }
@@ -224,10 +224,10 @@ static void ati_cursor_draw_line(VGACommonState *vga, uint8_t *d, int scr_y)
                 color = (xbits & BIT(7) ? s->regs.cur_color1 :
                                           s->regs.cur_color0) | 0xff000000;
             }
-            if (vga->hw_cursor_x + i * 8 + j >= h) {
+            if (vga->hw_cursor_x + idx >= h) {
                 return; /* end of screen, don't span to next line */
             }
-            dp[i * 8 + j] = color;
+            dp[idx] = color;
         }
     }
 }
-- 
2.53.0


