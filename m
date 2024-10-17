Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22989D3C520
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 16:29:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1TM2-0006Al-Ep; Thu, 17 Oct 2024 12:28:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t1TM1-0006AV-Ia
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 12:28:01 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t1TLz-00011q-Hi
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 12:28:00 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4315e9e9642so4666435e9.0
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2024 09:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729182478; x=1729787278; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DqbMicWOexpAEqZM48k3Pc+0QrbxcOh2qP4EZpZQqiw=;
 b=RLnPds7wdz30sLeYQiIHk5X3hfu9GcyzJhAJWp+TMR5hgxpHM/MURtJINp4I0+eWh0
 3kezA7dj0p5H4xivSZeI12cRUbMBmhwg7s0qe+++haAMz5W7C7IHH+vvNlQ+mwmdbvj/
 fYsUN90UzM19NbWK2Ia+V1XniIHDLgvw1ULXiFcqstDST2ZAPmvC1OryeMmtBEE+kqfH
 AcH9dnH3Up+rKqqpeBX5WiQ3/j6iL93rq9UloL2xKzRTV3sSO6YUWX392qWiU14r6Lh/
 +Gd4Fw0B9WFlMVq7wv1pDETXaAKwsQKfxgyfHzM//5lDQgdoxxXQRGSp9vuiSnHbAmjB
 eVCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729182478; x=1729787278;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DqbMicWOexpAEqZM48k3Pc+0QrbxcOh2qP4EZpZQqiw=;
 b=BaCw0lC+jHzYcGJXGd7YafErnlSnikfyI9AeWSLwtCwpdyWTfONCNo1kpxEVIkIxvy
 ja54oN7BWHLk22XJLVwrRyUzGX7LHAyZjLjmnWWRW9NRt4CLOPH+vBOYCG7NB3MmAV4g
 +mqlw+1/qw3R1M+PLaS4m0x4Y/+456JwI183w0/Uq56+TRsBgK5ZbtxOna/TRobM8c+e
 5zs2pfO+2LMn9ULgc+3Qwknn4Sp4ELvwfsAC6BRkmJU2CJo/dkRZFGKHXAYHKDwlyg6I
 VL0j8/qXJTjuOAxH1yUeGQ+FNtO/fycJjriiH/P845v4+l8kdRAwjRUu6jyBpISEhJf4
 Qpbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGvTxuG9O84SWuw6uiCHnGtHjA+j5k8cUkPRmSSkcHBpONl9yh6mdUPFiGocSonAFHVMmFkImGiDJY@nongnu.org
X-Gm-Message-State: AOJu0YxJeYBZmRxdXnAE9sZw5TijBD+5EdNXWT6NMAG4GiQq752EMyg7
 n9Us0s5qGq5syx6a5Qfls4J/+QpmDBmvr/+eTT05KZSdipnXKE1HPfPlu2/31U4=
X-Google-Smtp-Source: AGHT+IHK76GeH06rmDR26RCr5AbYLpiOdTkOoph9M6J6lhadnQNs54+kEa6vUBEZe6HfLRw5w1r06w==
X-Received: by 2002:a05:600c:510d:b0:42c:bd4d:e8ba with SMTP id
 5b1f17b1804b1-4311ded1c9dmr192995025e9.8.1729182477604; 
 Thu, 17 Oct 2024 09:27:57 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-431606d5910sm206785e9.43.2024.10.17.09.27.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2024 09:27:57 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] hw/sd/omap_mmc: Don't use sd_cmd_type_t
Date: Thu, 17 Oct 2024 17:27:55 +0100
Message-Id: <20241017162755.710698-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

In commit 1ab08790bb75e4 we did some refactoring of the SD card
implementation, which included a rearrangement of the sd_cmd_type_t
enum values.  Unfortunately we didn't notice that this enum is not
used solely inside the SD card model itself, but is also used by the
OMAP MMC controller device.  In the OMAP MMC controller, it is used
to implement the handling of the Type field of the MMC_CMD register,
so changing the enum values so that they no longer lined up with the
bit definitions for that register field broke the controller model.
The effect is that Linux fails to boot from an SD card on the "sx1"
machine.

Give omap-mmc its own enum which we can document as needing to match
the encoding used in this device's register, so it isn't sharing
sd_cmd_type_t with the SD card model any more.  We can then move
sd_cmd_type_t's definition out of sd.h and into sd.c, which is the
only place that uses it.

Cc: qemu-stable@nongnu.org
Fixes: 1ab08790bb75 ("hw/sd/sdcard: Store command type in SDProto")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/sd/sd.h |  8 --------
 hw/sd/omap_mmc.c   | 22 ++++++++++++++++------
 hw/sd/sd.c         |  8 ++++++++
 3 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/include/hw/sd/sd.h b/include/hw/sd/sd.h
index d35a839f5ef..f2458f37b3c 100644
--- a/include/hw/sd/sd.h
+++ b/include/hw/sd/sd.h
@@ -75,14 +75,6 @@ typedef enum  {
     UHS_III             = 3,    /* currently not supported */
 } sd_uhs_mode_t;
 
-typedef enum {
-    sd_spi,
-    sd_bc,     /* broadcast -- no response */
-    sd_bcr,    /* broadcast with response */
-    sd_ac,     /* addressed -- no data transfer */
-    sd_adtc,   /* addressed with data transfer */
-} sd_cmd_type_t;
-
 typedef struct {
     uint8_t cmd;
     uint32_t arg;
diff --git a/hw/sd/omap_mmc.c b/hw/sd/omap_mmc.c
index 91e9a3f1c6a..1d4e30e6b7b 100644
--- a/hw/sd/omap_mmc.c
+++ b/hw/sd/omap_mmc.c
@@ -103,6 +103,7 @@ static void omap_mmc_fifolevel_update(struct omap_mmc_s *host)
     }
 }
 
+/* These must match the encoding of the MMC_CMD Response field */
 typedef enum {
     sd_nore = 0,	/* no response */
     sd_r1,		/* normal response command */
@@ -112,8 +113,17 @@ typedef enum {
     sd_r1b = -1,
 } sd_rsp_type_t;
 
+/* These must match the encoding of the MMC_CMD Type field */
+typedef enum {
+    SD_TYPE_BC = 0,     /* broadcast -- no response */
+    SD_TYPE_BCR = 1,    /* broadcast with response */
+    SD_TYPE_AC = 2,     /* addressed -- no data transfer */
+    SD_TYPE_ADTC = 3,   /* addressed with data transfer */
+} MMCCmdType;
+
 static void omap_mmc_command(struct omap_mmc_s *host, int cmd, int dir,
-                sd_cmd_type_t type, int busy, sd_rsp_type_t resptype, int init)
+                             MMCCmdType type, int busy,
+                             sd_rsp_type_t resptype, int init)
 {
     uint32_t rspstatus, mask;
     int rsplen, timeout;
@@ -128,7 +138,7 @@ static void omap_mmc_command(struct omap_mmc_s *host, int cmd, int dir,
     if (resptype == sd_r1 && busy)
         resptype = sd_r1b;
 
-    if (type == sd_adtc) {
+    if (type == SD_TYPE_ADTC) {
         host->fifo_start = 0;
         host->fifo_len = 0;
         host->transfer = 1;
@@ -433,10 +443,10 @@ static void omap_mmc_write(void *opaque, hwaddr offset,
         for (i = 0; i < 8; i ++)
             s->rsp[i] = 0x0000;
         omap_mmc_command(s, value & 63, (value >> 15) & 1,
-                (sd_cmd_type_t) ((value >> 12) & 3),
-                (value >> 11) & 1,
-                (sd_rsp_type_t) ((value >> 8) & 7),
-                (value >> 7) & 1);
+                         (MMCCmdType)((value >> 12) & 3),
+                         (value >> 11) & 1,
+                         (sd_rsp_type_t) ((value >> 8) & 7),
+                         (value >> 7) & 1);
         omap_mmc_update(s);
         break;
 
diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index a5d2d929a8a..b2e2d58e013 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -71,6 +71,14 @@ typedef enum {
     sd_illegal = -2,
 } sd_rsp_type_t;
 
+typedef enum {
+    sd_spi,
+    sd_bc,     /* broadcast -- no response */
+    sd_bcr,    /* broadcast with response */
+    sd_ac,     /* addressed -- no data transfer */
+    sd_adtc,   /* addressed with data transfer */
+} sd_cmd_type_t;
+
 enum SDCardModes {
     sd_inactive,
     sd_card_identification_mode,
-- 
2.34.1


