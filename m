Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3871EDEBF5
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 22:23:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxY89-0004ks-IE; Tue, 03 Mar 2026 17:22:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vxY87-0004k9-Tu
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 17:22:16 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vxY85-0002Sb-CP
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 17:22:15 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4836f363ad2so72946375e9.1
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 14:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772576532; x=1773181332; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xkqwSLJa0xJ6zHaGrPgGg+nUA0PuvLRB97+M4LUsZGQ=;
 b=D1iTiR2sMRz6OQzV5+2eYDLMaTYzciSCoAAADfZBq2Pi1ns+dDb1VWacNTQ/Y9UiDE
 7XKH5PioyIe+fpVqy5T7JindBqNhWe4oCcTcDV8sEsgt4JP0OWC4W1tAIOaRR2yl5D8K
 dH5QwQclpGUQYCtii0XTuUskgf8EEmnTVHu5hLys0xzgBWrpAlu60KwivSGE7/evpVuN
 8YNJxF+wBq85pmmVPnwC3DPpooPpYzeZ5WBK/C4kdmSWJkShLRjAQHNejigxrE5D5bEU
 0ikmQKy+RKCZh5LNrShgtAGfgLCPHqb/ra1xOjEPIdjE0ZKqavPtxYEwiarhbZRQp3Zv
 jeCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772576532; x=1773181332;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xkqwSLJa0xJ6zHaGrPgGg+nUA0PuvLRB97+M4LUsZGQ=;
 b=ORUZ4f0aK+YLXxkpRpZGkoIWkDim7//ieC1m4RME2Ffu5l82cgaaAXxXOL/yrBmLro
 0YvmaYI7RV3v5O9qNalx2QhCmjYbV87QK53sqw5QOFBEvIaE1rD6AUkMZNKRloqQ/kGH
 owfMI4CYJsnK8zzA1sP5aldt8uW+4K1os6ghCfyIWaG7EzNWi5a+X3G6NjY462N8NU3E
 o7wDRqkblVRLCEY1tMqpchQLLd5b/q6ih+C8XAP6KFqFXDU1gElM0vXPUET0lOrFvAW8
 hwyB9D0boxCbBQueJn/jPTSyQQI8+I93Jb0XBaSMaWwANJT1ESzz+ehnHHkM1FRbAueC
 jwfw==
X-Gm-Message-State: AOJu0YxIbV+t/8Aw79ubQXtL7Yi9LpQ7ehBBdbAmGYLgUXrBvKgdIYAU
 3L1k19P6lvE42W16ckBl61J0klNmLWEhKTm2xxRYlTBNXrxWUTXhzTM510E/vw==
X-Gm-Gg: ATEYQzyOlsYjt5zlaCCqCQg78MMEuGO74FopbE758SehpPgV+G4nI17YzGNnymtxb6H
 vvh95RtZ2RGmCOoxRP3O7lqdwbrl+hseDy5roD07PaLCY8wCXxzDiWYwT9IjuHgpE3tx87bpWPZ
 rEd8cWs9GyjmalzisjMZ0MrL39TWliph/Rwl8dETxZWL7CcLzVuPa0brkXff8fFi15vGNXTt524
 LnTWuNSf5WcdIykoSmk7fqO9tpY81XD2ttBFIWdM2B+0Ttht1oajnGIAmh+mtk5OSWEbJsusYe0
 PRbTMpJAB5NNk/35s3t5/nyM3yFlkkdSunaJoEOkmlkPoieN50JPcotgmQgMvN0TWGaCYdaxUSw
 1HE7rBlprLEWIy+Dmi5Uvir74DeMLpwKsMMozH3khpYKTfdEnFtiROBws4cyATT6fqi6PkEoKKV
 eMB/ruQ/5hwjFRJYr5hjk6i0Qps0Aj3dhiq1LZP7ZITPRenHwZHuccaEffjt7s85UkfHd3k28SW
 q0A+B2DJFm7CP+pZe4wR0TvbJwXW8U=
X-Received: by 2002:a05:600c:3f14:b0:477:a54a:acba with SMTP id
 5b1f17b1804b1-483c9c02f13mr333689115e9.17.1772576531415; 
 Tue, 03 Mar 2026 14:22:11 -0800 (PST)
Received: from Provence
 (dynamic-2a02-3100-1c79-b600-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:1c79:b600:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485187c81adsm7577715e9.6.2026.03.03.14.22.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2026 14:22:11 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Steven Lee <steven_lee@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Troy Lee <leetroy@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>, qemu-arm@nongnu.org,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Peter Maydell <peter.maydell@linaro.org>, Joel Stanley <joel@jms.id.au>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v2 08/13] hw/char/serial: Add constants for Line Control
 Register
Date: Tue,  3 Mar 2026 23:21:38 +0100
Message-ID: <20260303222143.142741-9-shentey@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260303222143.142741-1-shentey@gmail.com>
References: <20260303222143.142741-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Substitute some magic numbers by named constants for slightly improved
readability.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/char/serial.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/hw/char/serial.c b/hw/char/serial.c
index f73de1ae4f..485b98f03f 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -39,6 +39,11 @@
 #include "hw/core/qdev-properties-system.h"
 
 #define UART_LCR_DLAB   0x80    /* Divisor latch access bit */
+#define UART_LCR_SB     0x40    /* Set break */
+#define UART_LCR_EPS    0x10    /* Even parity select */
+#define UART_LCR_PEN    0x08    /* Parity enable */
+#define UART_LCR_NSTB   0x04    /* Number of stop bits */
+#define UART_LCR_WLS    0x03    /* Word length select */
 
 #define UART_IER_MSI    0x08    /* Enable Modem status interrupt */
 #define UART_IER_RLSI   0x04    /* Enable receiver line status interrupt */
@@ -153,23 +158,23 @@ static void serial_update_parameters(SerialState *s)
 
     /* Start bit. */
     frame_size = 1;
-    if (s->lcr & 0x08) {
+    if (s->lcr & UART_LCR_PEN) {
         /* Parity bit. */
         frame_size++;
-        if (s->lcr & 0x10)
+        if (s->lcr & UART_LCR_EPS)
             parity = 'E';
         else
             parity = 'O';
     } else {
             parity = 'N';
     }
-    if (s->lcr & 0x04) {
+    if (s->lcr & UART_LCR_NSTB) {
         stop_bits = 2;
     } else {
         stop_bits = 1;
     }
 
-    data_bits = (s->lcr & 0x03) + 5;
+    data_bits = (s->lcr & UART_LCR_WLS) + 5;
     frame_size += data_bits + stop_bits;
     /* Zero divisor should give about 3500 baud */
     speed = (s->divider == 0) ? 3500 : (float) s->baudbase / s->divider;
@@ -430,7 +435,7 @@ static void serial_ioport_write(void *opaque, hwaddr addr, uint64_t val,
             int break_enable;
             s->lcr = val;
             serial_update_parameters(s);
-            break_enable = (val >> 6) & 1;
+            break_enable = !!(val & UART_LCR_SB);
             if (break_enable != s->last_break_enable) {
                 s->last_break_enable = break_enable;
                 qemu_chr_fe_ioctl(&s->chr, CHR_IOCTL_SERIAL_SET_BREAK,
@@ -676,7 +681,7 @@ static int serial_post_load(void *opaque, int version_id)
         }
     }
 
-    s->last_break_enable = (s->lcr >> 6) & 1;
+    s->last_break_enable = !!(s->lcr & UART_LCR_SB);
     /* Initialize fcr via setter to perform essential side-effects */
     serial_write_fcr(s, s->fcr_vmstate);
     serial_update_parameters(s);
-- 
2.53.0


