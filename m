Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58912EA8543
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 22:37:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzMk7-0005A6-8H; Sun, 08 Mar 2026 18:36:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzMk3-0004sZ-Fz
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 18:36:55 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzMk1-0003To-Kp
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 18:36:55 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-439af7d77f0so6948657f8f.0
 for <qemu-devel@nongnu.org>; Sun, 08 Mar 2026 15:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773009412; x=1773614212; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JktwphMN4PgnByVHqZExV/IBtMZMC5cSUKOw+j/MPNU=;
 b=WpwzuoX8YnJ2rfN4crDwgkEOskJRfK2GtY7SqS6bPHlPeBKhLSHo1COlSVSZUbVNlR
 pJI+NAwTqVfRxtx7T413Na7D12LTFsqEfUzqw7AdCo3E9Yn5LBiXObXyaDtxVNeHEFxo
 /xl9YkFEze8o+9dGcilGiszspgfe00LG8zAFxUHzDHtvDdV0uYqgIonKrwe/aO8/4WYO
 c0O7g8gXpdJQh+Corz2TVKPueYkp2TDXCN1N527uNRjeKUBn24JJwC9ETf7ongUm5BrV
 nDRwBOx5wgAVPxSS9JC8SkjM5Zh61hFaZu5rFd1/X+G/6R7UrMYaFDq5BKYztNDD1lZc
 VFzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773009412; x=1773614212;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=JktwphMN4PgnByVHqZExV/IBtMZMC5cSUKOw+j/MPNU=;
 b=dYoa19P/8S1FDIopR1Ft8Lsn/uBFX1//tsS6gdlCOYruytJWEyp4QtHSnY2570h7QE
 FiHyDwhrLkwSXi592CvwbCRsZxHezogWKJXUQETY0FibyywabtvAS+p0E2Eae309M4GR
 lmOFSm0b6S6TFa3hyAnXJtMjn6EwGmQSoNNXLc0CmjcdhCu4PlVzmayAhyJnBtW18Q7y
 bzmRqcLOSAJ42Fu7D6slWFVpEpNl/DrSmrA2jKOvKZL4gw6sgnlza5AyDe3GjWO4B/QI
 GcOKyf7Zq5Wv1yUkKL2M8zAU9V39i9UsDndkd9aURRhCsz8tPsLgF+V1RMzBS4Jac6uZ
 wUTA==
X-Gm-Message-State: AOJu0YycINkjBXpHloUPWoMivvskpL/xWtBKfHYulz0OG0hTojUZQ8/V
 UfcjxPAuFKDCz3HRdQXC1IWEGs7ZKGaVTBrMiRH8v97oG41GCBzq/jWC3cd1YPiKfRum1KdoBq+
 YR93kuHE=
X-Gm-Gg: ATEYQzw0GbWdY9VW8luH4xFEyaZh74jX2fr4Hgb2oQ7TyUmSJnQy3PbVlcI6KQqOdQd
 PzdwiIw2c5hVBObBGOhM1CcrlldRFDKhrcLxnw6TPG5ACgBTUpIH7hUOnMCZTK1Z2bXK/UM7TJK
 NN9o47goRRuOBLCSKxhQ27eCdEfLm/UC1bkRyMj55H9eYmo0WIheqKaVUdl7DwbHYLEg4R1r4V/
 m5kdVniyhTGoX6uy4MUtvABM9O6kEZ2oHe9GPwGeAvDoJKVVqOfpyzQo0lpeYkRpEG/jASvVoV0
 2refKLIIYoukEfJrSO//slLKkmrArZ+8lHM9NaDfkSmLLmZWcXoz2SdjWZqu138w2wLS93zHMBR
 H5jzr5EXneQiWzTG1jDeqdP7p8VVBP1UvamsTxs0F1JDoo0i9uwxyBs9v5ONKqTQ7vaSfKcolAA
 jKUfkGzVC5apRhe0cUjzBmkE82MJ0F6SOp8dQBC3JIWTlgm9Y09WExfn9Hu9WnDzIcz9uw8G86c
 AHeFQ==
X-Received: by 2002:a05:6000:2010:b0:439:d6ea:7cff with SMTP id
 ffacd0b85a97d-439da354a83mr18250595f8f.4.1773009411843; 
 Sun, 08 Mar 2026 15:36:51 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dada9116sm20060351f8f.14.2026.03.08.15.36.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 08 Mar 2026 15:36:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 20/49] ati-vga: Latch src and dst pitch and offset on
 master_cntl default
Date: Sun,  8 Mar 2026 23:34:04 +0100
Message-ID: <20260308223433.25503-21-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260308223433.25503-1-philmd@linaro.org>
References: <20260308223433.25503-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

From: Chad Jablonski <chad@jablonski.xyz>

Hardware testing on the Rage 128 confirms that (SRC/DST)_OFFSET,
and (SRC/DST)_PITCH are latched when (SRC/DST)_PITCH_OFFSET_CNTL bits
in DP_GUI_MASTER_CNTL are set to "default".

The earlier approach looked at the state of the (SRC/DST)_PITCH_OFFSET_CNTL
bits when offset and pitch registers were used. This meant that when
(SRC/DST)_PITCH_OFFSET_CNTL was reset to "leave alone" the old values
stored in the registers would return. This is not how the real hardware
works.

Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
Message-ID: <20260303024730.1489136-5-chad@jablonski.xyz>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/display/ati.c    |  9 +++++++++
 hw/display/ati_2d.c | 13 ++++---------
 2 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index 028efd13e19..ce23e5e48b9 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -868,6 +868,15 @@ static void ati_mm_write(void *opaque, hwaddr addr,
         s->regs.dp_datatype = (data & 0x0f00) >> 8 | (data & 0x30f0) << 4 |
                               (data & 0x4000) << 16;
         s->regs.dp_mix = (data & GMC_ROP3_MASK) | (data & 0x7000000) >> 16;
+
+        if (!(data & GMC_SRC_PITCH_OFFSET_CNTL)) {
+            s->regs.src_offset = s->regs.default_offset;
+            s->regs.src_pitch = s->regs.default_pitch;
+        }
+        if (!(data & GMC_DST_PITCH_OFFSET_CNTL)) {
+            s->regs.dst_offset = s->regs.default_offset;
+            s->regs.dst_pitch = s->regs.default_pitch;
+        }
         break;
     case DST_WIDTH_X:
         s->regs.dst_x = data & 0x3fff;
diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
index 309bb5ccb6c..a8c4c534b94 100644
--- a/hw/display/ati_2d.c
+++ b/hw/display/ati_2d.c
@@ -43,8 +43,6 @@ static int ati_bpp_from_datatype(ATIVGAState *s)
     }
 }
 
-#define DEFAULT_CNTL (s->regs.dp_gui_master_cntl & GMC_DST_PITCH_OFFSET_CNTL)
-
 void ati_2d_blt(ATIVGAState *s)
 {
     /* FIXME it is probably more complex than this and may need to be */
@@ -63,13 +61,12 @@ void ati_2d_blt(ATIVGAState *s)
         qemu_log_mask(LOG_GUEST_ERROR, "Invalid bpp\n");
         return;
     }
-    int dst_stride = DEFAULT_CNTL ? s->regs.dst_pitch : s->regs.default_pitch;
+    int dst_stride = s->regs.dst_pitch;
     if (!dst_stride) {
         qemu_log_mask(LOG_GUEST_ERROR, "Zero dest pitch\n");
         return;
     }
-    uint8_t *dst_bits = s->vga.vram_ptr + (DEFAULT_CNTL ?
-                        s->regs.dst_offset : s->regs.default_offset);
+    uint8_t *dst_bits = s->vga.vram_ptr + s->regs.dst_offset;
 
     if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
         dst_bits += s->regs.crtc_offset & 0x07ffffff;
@@ -97,14 +94,12 @@ void ati_2d_blt(ATIVGAState *s)
                        s->regs.src_x : s->regs.src_x + 1 - s->regs.dst_width);
         unsigned src_y = (s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM ?
                        s->regs.src_y : s->regs.src_y + 1 - s->regs.dst_height);
-        int src_stride = DEFAULT_CNTL ?
-                         s->regs.src_pitch : s->regs.default_pitch;
+        int src_stride = s->regs.src_pitch;
         if (!src_stride) {
             qemu_log_mask(LOG_GUEST_ERROR, "Zero source pitch\n");
             return;
         }
-        uint8_t *src_bits = s->vga.vram_ptr + (DEFAULT_CNTL ?
-                            s->regs.src_offset : s->regs.default_offset);
+        uint8_t *src_bits = s->vga.vram_ptr + s->regs.src_offset;
 
         if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
             src_bits += s->regs.crtc_offset & 0x07ffffff;
-- 
2.53.0


