Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00284C28B2F
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 19:53:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts5dv-0006wc-Kf; Tue, 11 Mar 2025 15:52:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ts5dt-0006vR-2S
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 15:51:57 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ts5dr-0007U2-2i
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 15:51:56 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-39141ffa9fcso2529534f8f.0
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 12:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741722713; x=1742327513; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oFwca4D3Q/50Y+EiNdlUeb4C8uGX5g5cjlbCFlPGUc0=;
 b=zHFTfTa9M3TvzmY3h4pGsNlPtytJ3NijgznlQ0OPwcvKZ5msfr1Sd3IhbpqHiB5FO2
 55MwbkstQSNOP4kelTUFKks+uqZiTP5Ar8QdFH372Ovz/rPUOfMAZ8Q1XV0ThTUhIHdV
 svVA5VURE41qWkyw28yI5BpMIX8muqfG0tXo+8wT+BqhyRwbzYeyVo0dEgNUMYmlqB4G
 a8xEaahXxoWXQ+QbkrLN5KitFvHetrfmY+Bk0JUsOYNZobqOX92/Kizefq7+aUrevzVF
 NzKU0b9a93D4S88TOTpJp8Z4ZE/VdCl+pItL6ydAGXmcv0ONI3Bhv41+uvr1SE5YG1tN
 JXJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741722713; x=1742327513;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oFwca4D3Q/50Y+EiNdlUeb4C8uGX5g5cjlbCFlPGUc0=;
 b=psRNY2m6WcHogZPj4NQT30QfhYc8k7V2ZhKVEhVfyLGmdu5v0/R+PHjv6OkDcaCik5
 FakxKAwtNtKwnDOE8Se6G5+OzZXUKvdhJUCxILjuewZB7e/o60YiUpmf5pcMXOfs+OE5
 9TD9zyL/sjEZZ3FyUr/sIbN23CIY7D2jBKZzSRZZfKQjraFv0Fm1K/CbZbm25vxjzpaq
 8gbRsi5HsffVlPDhfWu0+AJKxmrqXKyWpmCtmC8fhEFMQF2Rtc46XsRqqWRYhEY50VKt
 iC+fZIHMnNaA2GH48L0KyTygwS1jFMEeNfrpyokH/YRhZGIIhS7unOxfIX4+G4/d1wcI
 /I6A==
X-Gm-Message-State: AOJu0YzSa9/VaGshiAg865GVmbggpd8641ajVsvUTGURvSDvr/jNnNH7
 zC5UszwhsOb8ZOfXkbSd5WEHA7xEi5kM2uHo3CCcIzAptX1xHWI3UAuoNFBFpJpSbLNF+W11fXK
 v2MU=
X-Gm-Gg: ASbGncvclT/ZT63AQV3blhmcKbcG7Yn37KjtBOrB5zFr1f2rUrhQPZYbGNrdb0DJF5W
 XBKh77p4seI+0tUaoE0+dy2X8R6U+cmWNNf6Rq9DLhbaWieTrmTjCFRbr6WGuOvYqJ3Zcru3/Xu
 ST+nKiIDJHHbkZre8r5fNrtc2/RMHv+8GHwYyAOl6HtZ5DaxeQB1F8nJ5SH5nYx5d3AZPPkryWp
 2x9D/k7YpNuWJogVUcz74/75YtWCyXEAbiIkXw2pcXL8beZ3UHz9B9WKwY0Cx0l2e4VgeHwmvHC
 QuIqxiR+tZUHm0zuAK/X9Mtg07+ikJ4C2+xA2re/GqpsXb0gj+yVA4CQbQIB9GASR835dEDwsBq
 77R/WgjHQNlINswdKw38=
X-Google-Smtp-Source: AGHT+IHSAq0wxQ4/CIKT+x5QwacvzO7DskLprBerZJkg8iU8psOuLSsLwz9VgGfo5S5rQuQ03NRw4A==
X-Received: by 2002:a05:6000:21c6:b0:390:de58:d7fe with SMTP id
 ffacd0b85a97d-3926c5a567bmr3955727f8f.51.1741722712827; 
 Tue, 11 Mar 2025 12:51:52 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912bfdff57sm19382499f8f.37.2025.03.11.12.51.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 11 Mar 2025 12:51:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-stable@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 06/14] hw/net/smc91c111: Don't allow data register access to
 overrun buffer
Date: Tue, 11 Mar 2025 20:51:15 +0100
Message-ID: <20250311195123.94212-7-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250311195123.94212-1-philmd@linaro.org>
References: <20250311195123.94212-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Peter Maydell <peter.maydell@linaro.org>

For accesses to the 91c111 data register, the address within the
packet's data frame is determined by a combination of the pointer
register and the offset used to access the data register, so that you
can access data at effectively wider than byte width.  The pointer
register's pointer field is 11 bits wide, which is exactly the size
to index a 2048-byte data frame.

We weren't quite getting the logic right for ensuring that we end up
with a pointer value to use in the s->data[][] array that isn't out
of bounds:

 * we correctly mask when getting the initial pointer value
 * for the "autoincrement the pointer register" case, we
   correctly mask after adding 1 so that the pointer register
   wraps back around at the 2048 byte mark
 * but for the non-autoincrement case where we have to add the
   low 2 bits of the data register offset, we don't account
   for the possibility that the pointer register is 0x7ff
   and the addition should wrap

Fix this bug by factoring out the "get the p value to use as an array
index" into a function, making it use FIELD macro names rather than
hard-coded constants, and having a utility function that does "add a
value and wrap it" that we can use both for the "autoincrement" and
"add the offset bits" codepaths.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2758
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250228191652.1957208-1-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/net/smc91c111.c | 65 +++++++++++++++++++++++++++++++++++++---------
 1 file changed, 53 insertions(+), 12 deletions(-)

diff --git a/hw/net/smc91c111.c b/hw/net/smc91c111.c
index b05970d5e1c..9ce42b56155 100644
--- a/hw/net/smc91c111.c
+++ b/hw/net/smc91c111.c
@@ -13,6 +13,7 @@
 #include "net/net.h"
 #include "hw/irq.h"
 #include "hw/net/smc91c111.h"
+#include "hw/registerfields.h"
 #include "hw/qdev-properties.h"
 #include "qapi/error.h"
 #include "qemu/log.h"
@@ -126,6 +127,13 @@ static const VMStateDescription vmstate_smc91c111 = {
 #define RS_TOOSHORT     0x0400
 #define RS_MULTICAST    0x0001
 
+FIELD(PTR, PTR, 0, 11)
+FIELD(PTR, NOT_EMPTY, 11, 1)
+FIELD(PTR, RESERVED, 12, 1)
+FIELD(PTR, READ, 13, 1)
+FIELD(PTR, AUTOINCR, 14, 1)
+FIELD(PTR, RCV, 15, 1)
+
 static inline bool packetnum_valid(int packet_num)
 {
     return packet_num >= 0 && packet_num < NUM_PACKETS;
@@ -372,6 +380,49 @@ static void smc91c111_reset(DeviceState *dev)
 #define SET_LOW(name, val) s->name = (s->name & 0xff00) | val
 #define SET_HIGH(name, val) s->name = (s->name & 0xff) | (val << 8)
 
+/*
+ * The pointer register's pointer is an 11 bit value (so it exactly
+ * indexes a 2048-byte data frame). Add the specified offset to it,
+ * wrapping around at the 2048 byte mark, and return the resulting
+ * wrapped value. There are flag bits in the top part of the register,
+ * but we can ignore them here as the mask will mask them out.
+ */
+static int ptr_reg_add(smc91c111_state *s, int offset)
+{
+    return (s->ptr + offset) & R_PTR_PTR_MASK;
+}
+
+/*
+ * For an access to the Data Register at @offset, return the
+ * required offset into the packet's data frame. This will
+ * perform the pointer register autoincrement if required, and
+ * guarantees to return an in-bounds offset.
+ */
+static int data_reg_ptr(smc91c111_state *s, int offset)
+{
+    int p;
+
+    if (s->ptr & R_PTR_AUTOINCR_MASK) {
+        /*
+         * Autoincrement: use the current pointer value, and
+         * increment the pointer register's pointer field.
+         */
+        p = FIELD_EX32(s->ptr, PTR, PTR);
+        s->ptr = FIELD_DP32(s->ptr, PTR, PTR, ptr_reg_add(s, 1));
+    } else {
+        /*
+         * No autoincrement: register offset determines which
+         * byte we're addressing. Setting the pointer to the top
+         * of the data buffer and then using the pointer wrapping
+         * to read the bottom byte of the buffer is not something
+         * sensible guest software will do, but the datasheet
+         * doesn't say what the behaviour is, so we don't forbid it.
+         */
+        p = ptr_reg_add(s, offset & 3);
+    }
+    return p;
+}
+
 static void smc91c111_writeb(void *opaque, hwaddr offset,
                              uint32_t value)
 {
@@ -518,12 +569,7 @@ static void smc91c111_writeb(void *opaque, hwaddr offset,
                                   n);
                     return;
                 }
-                p = s->ptr & 0x07ff;
-                if (s->ptr & 0x4000) {
-                    s->ptr = (s->ptr & 0xf800) | ((s->ptr + 1) & 0x7ff);
-                } else {
-                    p += (offset & 3);
-                }
+                p = data_reg_ptr(s, offset);
                 s->data[n][p] = value;
             }
             return;
@@ -673,12 +719,7 @@ static uint32_t smc91c111_readb(void *opaque, hwaddr offset)
                                   n);
                     return 0;
                 }
-                p = s->ptr & 0x07ff;
-                if (s->ptr & 0x4000) {
-                    s->ptr = (s->ptr & 0xf800) | ((s->ptr + 1) & 0x07ff);
-                } else {
-                    p += (offset & 3);
-                }
+                p = data_reg_ptr(s, offset);
                 return s->data[n][p];
             }
         case 12: /* Interrupt status.  */
-- 
2.47.1


