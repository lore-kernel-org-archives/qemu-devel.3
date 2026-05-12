Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B27F2CD4851
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 06:22:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMgVi-0000eh-Bn; Tue, 12 May 2026 02:22:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMgVI-0000by-17
 for qemu-devel@nongnu.org; Tue, 12 May 2026 02:22:04 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMgVG-0003sM-0X
 for qemu-devel@nongnu.org; Tue, 12 May 2026 02:22:03 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-488af96f6b2so60762135e9.0
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 23:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778566919; x=1779171719; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WSk/dEbGgvaUxswyZj17bvNUE0aNKyiM/+UL1KCae38=;
 b=r/BCHLmyK5xzvrB3/q90I5gAn8f+f/+ezOlvQR55SzUV8hP7GYPHfzaSDa3AtQp+bf
 dMruiOHQTPWcjxEtgGuQZF+Rjz7dQCuvE9KhxbeIc/0E8ub7ungJTRL9+H8GEWinU3VQ
 S9wdAP5N7M5/vpspTIp0V70tiiOVuZHJaP0RBqpcfFrhqozS0JOEGYNDHoaT64BJIvQH
 0nFTBEcCyAF9ry9AqxwF1YOPtTxitf4a0mbZZUS3nLqz8HsDo5E6Fo/XhQ7bhatkb9kq
 AqOJEBPG4ukh5tTS1atNvnMGdKecZuK0R4F38DGUy/s6ikGCKv99a3KrnY6aNpkcWhtQ
 yazA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778566919; x=1779171719;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=WSk/dEbGgvaUxswyZj17bvNUE0aNKyiM/+UL1KCae38=;
 b=ETzGJTf6g9lHuzrkHyEUAfrS5mOVjHCpJRGUXAx2oCI2u1Yz8epJg3cOxIn652hS6s
 wmtA9BbTIeaeLxK0MtIh4yXmf617TgHzftg2/WGqxkF5siZjKwkNgi0C+m0Vexw8r+Vk
 umi1lyElC4vb3xz39jp1Ev4EAvjT/iTVFNwTP/tu5dKNd21GNaN7q+I43vYpvgpLQ41O
 NL4FVA17ourjp8Jj34hP90S7XZi7AIbvuaVZlX7/5XkKYkPlh3kFmy/nrej6YRddU2KZ
 TUGwn2vnAuN1erVJihFHkiisvy3VZ26YjoVPLG92dJpdxRC+XKFI8mXDtGdnCuaE8lo9
 ftwQ==
X-Gm-Message-State: AOJu0YzcrHW8vukKQr32+gw1T6X0WCOD3CH0B2vro6vK7m9GRAYABj2E
 kSl+meYRNXyQfSFJ1UNiOB7UMdDGUprLOiz8n//24ZZC98OHEPr9XeETaolowznj0RIPde/cp46
 88fxMTV8=
X-Gm-Gg: Acq92OHbVlPoo0A5isoDUjmQD+VOrzr+58Mj2wxxPdOFRUoK7D2xYAwkcAfZX7JGtSz
 IODQQ1JqqD2XptUbmnzghUMvOnL4u7q132X8IxDfI/aqbEaeQkKRfBO9A5VuG5nzQstluM8ukuC
 bKr76SdLN2ffJbpHSvix4+AVvzDFHlRPOp201tNSjxjpBUaNTZh9pq0wabx2OKy64wNFF31dlru
 DQAdY+SQYuR59iuYdaytvTNN1DsWgoLyVbpEnIrd6PsVAwuYjogrsF5rePW4O4YyyYk16w/lus0
 x/hJ8QJTyyM/ZDvUQixdIdZH0tmp08H+qHsa8eTWGPJHlSbyJaHJqhLZjg9zneZHIAJgIq1zjzd
 hHlX479UDDLpXSFqbIyu+RnPoX01EyRQnuu0eaE9LNX3+/1YT3yVX91ghWu7jteS3nS+h7QFSdD
 /wOZPFarGvXDtIMw7A+ygGnvaN3jdpTgqiZTtL9BVpJUCWzBETyCezpU7SWCtpkUOms2G7B2mz1
 hBzQ2VyaYY=
X-Received: by 2002:a05:600c:3011:b0:48a:568f:ae6d with SMTP id
 5b1f17b1804b1-48e73f1baebmr102503375e9.8.1778566919252; 
 Mon, 11 May 2026 23:21:59 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e8e64385bsm12211345e9.12.2026.05.11.23.21.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 11 May 2026 23:21:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/41] hw/display/cirrus_vga: Fix packed-24 color-expansion
 transparent copies
Date: Tue, 12 May 2026 08:21:03 +0200
Message-ID: <20260512062142.67998-3-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260512062142.67998-1-philmd@linaro.org>
References: <20260512062142.67998-1-philmd@linaro.org>
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

From: Peter Maydell <peter.maydell@linaro.org>

For the "color expansion" subtype of raster operations, the source
pixel format is a monochrome bitmap, and the destination can be any
of 8, 16, 24 or 32bpp.

For these pattern operations, the GR2F register includes a field
which specifies how much to skip at the start of each scanline.  In
the 8, 16 and 32 bit cases, this field is 3 bits and is a count of
pixels to skip.  We get this case right.  However, for the 24 bit
case, the field is 5 bits and is a count of destination bytes to
skip.

In commit ad81218e40e27 ("depth=24 write mask fix (Volker Ruppert)")
in 2005, we updated the code to (attempt to) handle the 5-bit mask
case.  However, we don't do the right thing when the 5-bit mask
indicates that we need to skip more than 8 bits of the input bitmap:
we will right-shift the 0x80 constant completely off the right hand
side, and will be off-by-one for all the source bitmap loads.

Fix this by calculating the whole number of input bytes we need to
skip and the residual number of bits.  In the 8/16/32bpp case the
bytes to skip is always zero.

Cc: qemu-stable@nongnu.org
Fixes: ad81218e40e27 ("depth=24 write mask fix (Volker Ruppert)")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Junjie Cao <junjie.cao@intel.com>
Tested-by: Junjie Cao <junjie.cao@intel.com>
Message-ID: <20260410183249.4046456-3-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/display/cirrus_vga_rop2.h | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/hw/display/cirrus_vga_rop2.h b/hw/display/cirrus_vga_rop2.h
index 8be35ec6e20..33f9b3b6134 100644
--- a/hw/display/cirrus_vga_rop2.h
+++ b/hw/display/cirrus_vga_rop2.h
@@ -108,12 +108,34 @@ glue(glue(glue(cirrus_colorexpand_transp_, ROP_NAME), _),DEPTH)
     unsigned int col;
     unsigned bitmask;
     unsigned index;
+
+    /*
+     * Raster ops where the source is a monochrome bitmap with
+     * color expansion to 8/16/24/32bpp destination.
+     */
+
 #if DEPTH == 24
+    /*
+     * For packed-24 modes, GR2F bits [4:0] are a count of destination
+     * bytes to be suppressed for each scanline, which we keep in
+     * dstskipleft. We want to track the number of whole bytes
+     * to skip in the source (always either 0 or 1) and the number
+     * of bits within the byte to skip.
+     */
     int dstskipleft = s->vga.gr[0x2f] & 0x1f;
-    int srcskipleft = dstskipleft / 3;
+    int srcskipleftbits = (dstskipleft / 3) & 0x7;
+    int srcskipleftbytes = (dstskipleft / 3) >> 3;
 #else
-    int srcskipleft = s->vga.gr[0x2f] & 0x07;
-    int dstskipleft = srcskipleft * (DEPTH / 8);
+    /*
+     * In all other modes, GR2F bits [2:0] are a count of how many
+     * destination pixels to suppress for each scanline, which is our
+     * srcskipleftbits. We get dstskipleft, the number of bytes to
+     * skip, by multiplying this by the bytes-per-pixel. In these
+     * modes we never need to skip an entire source byte.
+     */
+    int srcskipleftbits = s->vga.gr[0x2f] & 0x07;
+    int srcskipleftbytes = 0;
+    int dstskipleft = srcskipleftbits * (DEPTH / 8);
 #endif
 
     if (s->cirrus_blt_modeext & CIRRUS_BLTMODEEXT_COLOREXPINV) {
@@ -125,7 +147,8 @@ glue(glue(glue(cirrus_colorexpand_transp_, ROP_NAME), _),DEPTH)
     }
 
     for(y = 0; y < bltheight; y++) {
-        bitmask = 0x80 >> srcskipleft;
+        bitmask = 0x80 >> srcskipleftbits;
+        srcaddr += srcskipleftbytes;
         bits = cirrus_src(s, srcaddr++) ^ bits_xor;
         addr = dstaddr + dstskipleft;
         for (x = dstskipleft; x < bltwidth; x += (DEPTH / 8)) {
-- 
2.53.0


