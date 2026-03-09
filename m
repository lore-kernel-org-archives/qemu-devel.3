Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ED6DF417F3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 15:59:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzczV-0005KY-Io; Mon, 09 Mar 2026 11:57:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzczA-0004M1-OK
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:57:36 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzcz9-0000r6-6F
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:57:36 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4853510b4f3so22819515e9.0
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 08:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773071853; x=1773676653; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QpWkjwMhJW7fy/PrD8/KH6aDfGrjV4YP9KEmKtnuVuY=;
 b=dkgAr0hWb2/IVpjVxBXfRuZpcL/dWCmHC3G3TrAVXsSXcPAtcAZFTSIDcEEvkcC4VM
 Ux4afpt9yzdBkJP8sEPU16R6LMwEY8V1uEdupB0gPSGGJwvWg4zrXBW9Wd/yJhNJZXjD
 gD2RdGrj4B1Dc4KAAwnr6rn+lw0uVhZ1GkhHMiUOGn4bXcNGcVNeiikDfxAfpugQZgoH
 iYq5jnBvu+My+mAeafI3QRGjcrQk5P9T1A6p4gj+PGJ8TlYeAiIkARt4ldmZFxod/Fgn
 +WYFgex1r/heWRRdLsjvOmSXaCdc1hVcXgELn08HEhv/c7swUAtT0DYtx0gWmt0AnJ94
 1gOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773071853; x=1773676653;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=QpWkjwMhJW7fy/PrD8/KH6aDfGrjV4YP9KEmKtnuVuY=;
 b=WMe7rF4TQvXCAMZ1lJ5Y4v072s/84XiT1lSjBOG0Wku97IDMzdmq56yKN6hSN3ZBxY
 a6rJk/DpCQAkyXFxvkBaY51w+0vgLA981MlDO72tjDK816GwohZaD20mWZ9vUlV/+0Ne
 siudjVdgTs8EehnVO2DzsKHiDA/4BEmbLhvV45KS0hoWfvn7iWupbCtFqCyhlEA6gW5k
 WHSkc9p2QiGon1Jjn8elFzwpBirVn1ra7XzUJlkd2nuphr+1kuknTXg+Zif6VmLNuOhX
 cDxpQJAeM/xY/hsm8w6nW4mtNZAzLK7X1xTKOmaRlilXit6fGHd7Pc4jGAWRWLNZEDFN
 SCXw==
X-Gm-Message-State: AOJu0Yy98zqqOuvkUpLff5hLUNDAvnYklV6q6utmtZs1vezMHCMfZAEM
 C3JBNTHQBk2uGTrSan94Mn53HA468fkW0Rq+QBoqtXF3/KI+mvB34/iBiT++XSldAu9bFdDQhOu
 7Nkr08oI=
X-Gm-Gg: ATEYQzyrJKCIJ/apzc5BM16niPULIrOHEiebjNrK2SjHv85mcJkXVHFYRqxYplB8SnM
 cFFqLPTLy4lhSFxO3l1dbhbn/1xGwL7GrEOVi/0SSLpnCI7A/HomfD77bWw3GIbGmkn/jkVwGLs
 bJjPDbApL4UGp9+0IZ0yNgRrU5TGedk6KjAoSK3h8Lg5be0C6UCDS0nsuCV6Z40n96FKI8VMOSr
 jdEbh/6/It2kWOHZgje5k3HokeXuDUScn5dPrCBiXgXpk2T+HtiSkRo44VH0iZKgh7Xp+UuoHLt
 tG751JIOglWG8MXImfxqabjOe55PiZqjsBwKHl9M4l6AgX5MB1p2aI81pPdF7QYspcGfdjLQzXQ
 MDsbdDemgok+jqHuXrpLBPpFfWLXa8uQc9zbaD8G7rPHOJGrXfeGvRNjzsywdQRU9/2GAU6Epr8
 srAGFIe04elolkjSaEcoxW4ZPhY37bcP4wlR3RnMc8BFF0tYPm/pjybzlkUyS9/VT/h+9QUEnG
X-Received: by 2002:a05:600c:1d24:b0:485:39b9:96a1 with SMTP id
 5b1f17b1804b1-48539b998d8mr84484145e9.19.1773071853316; 
 Mon, 09 Mar 2026 08:57:33 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485245dc298sm93876405e9.15.2026.03.09.08.57.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Mar 2026 08:57:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 46/49] ati-vga: Do not access pixel outside the screen
Date: Mon,  9 Mar 2026 16:52:16 +0100
Message-ID: <20260309155219.62400-47-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309155219.62400-1-philmd@linaro.org>
References: <20260309155219.62400-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

We check end of screen before writing the pixel but before that
complement color also accesses screen pixel so we have to check before
that. This fixes a segmentation fault with guest_hwcursor when pointer
is partially out of screen at lower right corner.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Chad Jablonski <chad@jablonski.xyz>
Message-ID: <26db0715a6b9f6504f394010513facc9a37882ad.1773009887.git.balaton@eik.bme.hu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/display/ati.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index 2c649e940b3..05cf507bd47 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -214,6 +214,9 @@ static void ati_cursor_draw_line(VGACommonState *vga, uint8_t *d, int scr_y)
         uint8_t abits = vga_read_byte(vga, srcoff + i);
         uint8_t xbits = vga_read_byte(vga, srcoff + i + 8);
         for (j = 0; j < 8; j++, abits <<= 1, xbits <<= 1, idx++) {
+            if (vga->hw_cursor_x + idx >= h) {
+                return; /* end of screen, don't span to next line */
+            }
             if (abits & BIT(7)) {
                 if (xbits & BIT(7)) {
                     color = dp[idx] ^ 0xffffffff; /* complement */
@@ -224,9 +227,6 @@ static void ati_cursor_draw_line(VGACommonState *vga, uint8_t *d, int scr_y)
                 color = (xbits & BIT(7) ? s->regs.cur_color1 :
                                           s->regs.cur_color0) | 0xff000000;
             }
-            if (vga->hw_cursor_x + idx >= h) {
-                return; /* end of screen, don't span to next line */
-            }
             dp[idx] = color;
         }
     }
-- 
2.53.0


