Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5609FD4660D
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 18:56:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgSVf-00019E-EK; Thu, 15 Jan 2026 13:55:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vgSVN-0000i0-Me
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 13:55:39 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vgSVC-0005uz-US
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 13:55:31 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-42fb0fc5aa9so675550f8f.1
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 10:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768503323; x=1769108123; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7l0287uBAbtHCtUi/PPRvwqREv4BJ1eQRFxfkS1QS7Q=;
 b=HXa1008nbLd6m59SNCib2w5Jc79OePvKMW5YnjhNtwE7fpeM4ok/SGDyy0ejaejPy6
 HIOBI6BFimP/fsVokHAAoIwtG2odS5wCPQ+Alr7gCsp1h9odOgq8c+o4ATaVcPHH9fBe
 vkj7E7DOL/0PUN9EUcBtoj6pSHoMDzt/+o6i0icJ/48ImIHW5BC70nmUhnnOyY29UAYV
 C68hvRbb/NVkRKtEDp3IkKa/ni0hdOC94Po2QgfqeLYiFmHuhdM9KBD8Cuc22dEP9ZVJ
 oe5+5lhL/MslX/ARGhG4iVnpYkn/sB3zyyle9KKhIJCCRNprT8EatRrMpbwDsNEu772i
 0rsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768503323; x=1769108123;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=7l0287uBAbtHCtUi/PPRvwqREv4BJ1eQRFxfkS1QS7Q=;
 b=Q4XMqJfUU4gyk++LhGaIrJSwS/PjUfEGofCLSYj2CkIZyFL48pvbjwGgKozHBAR1wH
 AkOIP7XhY69LRZuLU9eXZxV6Sihelo09JRZlWy+mrwddzM81YHUXjEya/mXJrxx2gEDc
 nbpnd0suI4XxL98vNBjxDiGl00B7H4bgXY/oIAq1rA0dejIJ45CO3RQh4zEJ4snBm7R8
 iZXrJVq3JAPGgs0+55/JqrRLzEnpjPryRUu0eAUxum8WiQXtl0Wgp/k3YQOiuz+XKXGu
 htoYUFmQRzwxExqUs+fy+nSYBWziVvCOG/AGnPDQZvXCAqib+6yfx1AVRE28jdvgueWi
 rYVw==
X-Gm-Message-State: AOJu0YzaF8SFFX4h+axLaxJFAgYU5MCQNkUlPOJMuEW/ZgbMWTiqI4jD
 tdSCzQBbxd82QJbY9SF2Lgl08O6FIAzqQW0+CjZxb95h2wWgp0RAtjb54k2FufY4m7LVkbuV9nF
 TZHJ3
X-Gm-Gg: AY/fxX42OTbXaG5nWPp3jCs/3sfJi1lpggo3jhgZDKZx4sC83cbOsaQughr28bTJtf+
 P4gV6qIcH2iFkw+ywuuLcAEO3vvtGEWqymXatFveRTvvZ1zacpctQuMEE62fw0+BPI1aoVJ6VU8
 HmsHf0zYMEV5VQ0TmLVWg0LEOVXCsvk/+1n+XiN0yYshNY2LYYoq0CCTmg8c4gO32hR9BcMiY6h
 aOG4hVhShtLgHFsBlHe8egZVvcf1pMPQRLEWoRqb71ECFLJrP8K4XRPgni/Qv+NlJfx+QYFfgI3
 6Ijzk4UmIIg3pIsPwaS1cc0UshjSfswlURrMdoLSPgC2dYW+N3sKv57kqqUwo3T5D64aVKTYYCm
 BTQlqoT+7+SwTPltDjNFGKbusv1a4yQKuo3I1Ak97eZU2SGvFOhp6A13w3HPyEJuI3XBOdTKr3y
 1Sn4Al/UD3ZpuxeFP5KlwHxD5+wjtTW8IIUHCEkGw0gTkZGJO0wOcPjh3fT6wYV1whGg6oxoveC
 3IVHAtMs60QHZakMssyU0TWWEYkLD7nWb3wTKrbrw/oGA==
X-Received: by 2002:a05:6000:400c:b0:430:f742:fbc7 with SMTP id
 ffacd0b85a97d-4356a0296e9mr345711f8f.14.1768503323212; 
 Thu, 15 Jan 2026 10:55:23 -0800 (PST)
Received: from mnementh.archaic.org.uk
 (f.7.f.1.7.5.e.f.f.f.c.5.d.8.2.4.0.0.0.0.0.d.1.0.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:1d0:0:428d:5cff:fe57:1f7f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356996cecasm514207f8f.26.2026.01.15.10.55.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 10:55:22 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/25] hw/arm/omap1: Remove omap_badwidth_write* calls
Date: Thu, 15 Jan 2026 18:54:57 +0000
Message-ID: <20260115185508.786428-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260115185508.786428-1-peter.maydell@linaro.org>
References: <20260115185508.786428-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
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

Complete the conversion started in the previous commit by
changing all the omap_badwidth_write* calls to open-coded
log-and-ignore behaviour.

We can delete a FIXME comment about an infinite loop, because that
only looped infinitely back before 2011 when the device was still
using absolute physical addresses.  Now that we are simply logging
the error we can clearly see that there's no loop.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/omap1.c | 64 +++++++++++++++++++++++++++++++++-----------------
 1 file changed, 42 insertions(+), 22 deletions(-)

diff --git a/hw/arm/omap1.c b/hw/arm/omap1.c
index 742ee48fcf..b28fbd64fd 100644
--- a/hw/arm/omap1.c
+++ b/hw/arm/omap1.c
@@ -235,7 +235,8 @@ static void omap_mpu_timer_write(void *opaque, hwaddr addr,
     struct omap_mpu_timer_s *s = opaque;
 
     if (size != 4) {
-        omap_badwidth_write32(opaque, addr, value);
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: write at offset 0x%" HWADDR_PRIx
+                      " with bad width %d\n", __func__, addr, size);
         return;
     }
 
@@ -344,7 +345,8 @@ static void omap_wd_timer_write(void *opaque, hwaddr addr,
     struct omap_watchdog_timer_s *s = opaque;
 
     if (size != 2) {
-        omap_badwidth_write16(opaque, addr, value);
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: write at offset 0x%" HWADDR_PRIx
+                      " with bad width %d\n", __func__, addr, size);
         return;
     }
 
@@ -472,7 +474,8 @@ static void omap_os_timer_write(void *opaque, hwaddr addr,
     int offset = addr & OMAP_MPUI_REG_MASK;
 
     if (size != 4) {
-        omap_badwidth_write32(opaque, addr, value);
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: write at offset 0x%" HWADDR_PRIx
+                      " with bad width %d\n", __func__, addr, size);
         return;
     }
 
@@ -619,7 +622,8 @@ static void omap_ulpd_pm_write(void *opaque, hwaddr addr,
     uint16_t diff;
 
     if (size != 2) {
-        omap_badwidth_write16(opaque, addr, value);
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: write at offset 0x%" HWADDR_PRIx
+                      " with bad width %d\n", __func__, addr, size);
         return;
     }
 
@@ -894,7 +898,8 @@ static void omap_pin_cfg_write(void *opaque, hwaddr addr,
     uint32_t diff;
 
     if (size != 4) {
-        omap_badwidth_write32(opaque, addr, value);
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: write at offset 0x%" HWADDR_PRIx
+                      " with bad width %d\n", __func__, addr, size);
         return;
     }
 
@@ -1052,7 +1057,8 @@ static void omap_id_write(void *opaque, hwaddr addr,
                           uint64_t value, unsigned size)
 {
     if (size != 4) {
-        omap_badwidth_write32(opaque, addr, value);
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: write at offset 0x%" HWADDR_PRIx
+                      " with bad width %d\n", __func__, addr, size);
         return;
     }
 
@@ -1124,7 +1130,8 @@ static void omap_mpui_write(void *opaque, hwaddr addr,
     struct omap_mpu_state_s *s = opaque;
 
     if (size != 4) {
-        omap_badwidth_write32(opaque, addr, value);
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: write at offset 0x%" HWADDR_PRIx
+                      " with bad width %d\n", __func__, addr, size);
         return;
     }
 
@@ -1221,7 +1228,8 @@ static void omap_tipb_bridge_write(void *opaque, hwaddr addr,
     struct omap_tipb_bridge_s *s = opaque;
 
     if (size < 2) {
-        omap_badwidth_write16(opaque, addr, value);
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: write at offset 0x%" HWADDR_PRIx
+                      " with bad width %d\n", __func__, addr, size);
         return;
     }
 
@@ -1332,7 +1340,8 @@ static void omap_tcmi_write(void *opaque, hwaddr addr,
     struct omap_mpu_state_s *s = opaque;
 
     if (size != 4) {
-        omap_badwidth_write32(opaque, addr, value);
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: write at offset 0x%" HWADDR_PRIx
+                      " with bad width %d\n", __func__, addr, size);
         return;
     }
 
@@ -1430,7 +1439,8 @@ static void omap_dpll_write(void *opaque, hwaddr addr,
     int div, mult;
 
     if (size != 2) {
-        omap_badwidth_write16(opaque, addr, value);
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: write at offset 0x%" HWADDR_PRIx
+                      " with bad width %d\n", __func__, addr, size);
         return;
     }
 
@@ -1703,7 +1713,8 @@ static void omap_clkm_write(void *opaque, hwaddr addr,
     };
 
     if (size != 2) {
-        omap_badwidth_write16(opaque, addr, value);
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: write at offset 0x%" HWADDR_PRIx
+                      " with bad width %d\n", __func__, addr, size);
         return;
     }
 
@@ -1833,7 +1844,8 @@ static void omap_clkdsp_write(void *opaque, hwaddr addr,
     uint16_t diff;
 
     if (size != 2) {
-        omap_badwidth_write16(opaque, addr, value);
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: write at offset 0x%" HWADDR_PRIx
+                      " with bad width %d\n", __func__, addr, size);
         return;
     }
 
@@ -2043,7 +2055,8 @@ static void omap_mpuio_write(void *opaque, hwaddr addr,
     int ln;
 
     if (size != 2) {
-        omap_badwidth_write16(opaque, addr, value);
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: write at offset 0x%" HWADDR_PRIx
+                      " with bad width %d\n", __func__, addr, size);
         return;
     }
 
@@ -2268,7 +2281,8 @@ static void omap_uwire_write(void *opaque, hwaddr addr,
     int offset = addr & OMAP_MPUI_REG_MASK;
 
     if (size != 2) {
-        omap_badwidth_write16(opaque, addr, value);
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: write at offset 0x%" HWADDR_PRIx
+                      " with bad width %d\n", __func__, addr, size);
         return;
     }
 
@@ -2397,7 +2411,8 @@ static void omap_pwl_write(void *opaque, hwaddr addr,
     int offset = addr & OMAP_MPUI_REG_MASK;
 
     if (size != 1) {
-        omap_badwidth_write8(opaque, addr, value);
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: write at offset 0x%" HWADDR_PRIx
+                      " with bad width %d\n", __func__, addr, size);
         return;
     }
 
@@ -2494,7 +2509,8 @@ static void omap_pwt_write(void *opaque, hwaddr addr,
     int offset = addr & OMAP_MPUI_REG_MASK;
 
     if (size != 1) {
-        omap_badwidth_write8(opaque, addr, value);
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: write at offset 0x%" HWADDR_PRIx
+                      " with bad width %d\n", __func__, addr, size);
         return;
     }
 
@@ -2691,7 +2707,8 @@ static void omap_rtc_write(void *opaque, hwaddr addr,
     time_t ti[2];
 
     if (size != 1) {
-        omap_badwidth_write8(opaque, addr, value);
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: write at offset 0x%" HWADDR_PRIx
+                      " with bad width %d\n", __func__, addr, size);
         return;
     }
 
@@ -3419,7 +3436,8 @@ static void omap_mcbsp_writew(void *opaque, hwaddr addr,
         return;
     }
 
-    omap_badwidth_write16(opaque, addr, value);
+    qemu_log_mask(LOG_GUEST_ERROR, "%s: write at offset 0x%" HWADDR_PRIx
+                  " with bad width %d\n", __func__, addr, 4);
 }
 
 static void omap_mcbsp_write(void *opaque, hwaddr addr,
@@ -3433,7 +3451,8 @@ static void omap_mcbsp_write(void *opaque, hwaddr addr,
         omap_mcbsp_writew(opaque, addr, value);
         break;
     default:
-        omap_badwidth_write16(opaque, addr, value);
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: write at offset 0x%" HWADDR_PRIx
+                      " with bad width %d\n", __func__, addr, size);
     }
 }
 
@@ -3607,7 +3626,8 @@ static void omap_lpg_write(void *opaque, hwaddr addr,
     int offset = addr & OMAP_MPUI_REG_MASK;
 
     if (size != 1) {
-        omap_badwidth_write8(opaque, addr, value);
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: write at offset 0x%" HWADDR_PRIx
+                      " with bad width %d\n", __func__, addr, size);
         return;
     }
 
@@ -3681,8 +3701,8 @@ static uint64_t omap_mpui_io_read(void *opaque, hwaddr addr,
 static void omap_mpui_io_write(void *opaque, hwaddr addr,
                                uint64_t value, unsigned size)
 {
-    /* FIXME: infinite loop */
-    omap_badwidth_write16(opaque, addr, value);
+    qemu_log_mask(LOG_GUEST_ERROR, "%s: write at offset 0x%" HWADDR_PRIx
+                  " with bad width %d\n", __func__, addr, size);
 }
 
 static const MemoryRegionOps omap_mpui_io_ops = {
-- 
2.47.3


