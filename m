Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36A35C47DB3
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 16:11:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUUDX-0007tT-Eg; Mon, 29 Jan 2024 11:10:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rUUDW-0007su-Av
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 11:10:38 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rUUDT-0002fC-Rs
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 11:10:38 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-40e76109cdeso39732685e9.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 08:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706544633; x=1707149433; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jJrBQU8/K6RcUc2wQkGztYkcJD87aocyjGftJaoYKA0=;
 b=tPwvBNfjQftF9lSMkLN6yX0x7futwdawheS9hnB5bOF38AymN1dH2I/4Qnp1QqGrNG
 GKhPEiKV+9BCux3znCoz5npr2JfA359RWdVODSY8yJ36vc+OLxncvMqoyV3ahP8BPmln
 nhwN1FepkMpwjOlugdSWGKQ33rJmUkmIakExhUujbaIpd2XizrUPvEhXcQW/ij9PNjaR
 BF6IWrWZbwTWWLZn0K47Y2M37eY0z13vrAy72g4oHY9yBC0PSi7TCFX6VDSU3ykY6VLu
 Bm81LWoQVKNkAIiVrGWgJ1NDwkh02TNrxHikaYJRJ5yPsiGczntEubGb1S+WgX/b8COZ
 DOeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706544633; x=1707149433;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jJrBQU8/K6RcUc2wQkGztYkcJD87aocyjGftJaoYKA0=;
 b=j43mMQYGrYX9r+PYI+hfYIQJxd1dkO7RndtXQy/rR1vga3FETvTKRrFueP8HJsWXlY
 aSn2TL3wGXHCkVyKf3e44QFoKA6UIaG8IBi/qm9n/lxdC2Mmvcw6md2NveyqAmTh0IG2
 kv5OAD5c4e/HCe2Tv7+mIhyuzA6rtUXnVnSM2eZMfd7LHGj0vEGkfONRnfFUbJbzvdhm
 buKIELxK+2uhKliRcNDAI86DR5DmMf7a5dUJniZ7+9R47VcvE2yO4NsY4TPkkQMGc95i
 f6YSDbh8OF3/RmZmwxo3reQYZov27OYGIDGP6cHfSh+mjCgsnb2PBK5vUeRM0Jx998BR
 zrZA==
X-Gm-Message-State: AOJu0YwhC+j8nDxDd3Temz0UmCNVCKpnr1mH4V+guGdyvw1oujQY6pWT
 tEW2Uo9Y5gYrv6V3TfANiLzl2IhjNahf1lWarOpFAFygfBwSfTX4IK9u6NQGmtizN5CS23nUBue
 yWI8=
X-Google-Smtp-Source: AGHT+IGXEoIx/U9hfmpuCmgUgsEf0NYzJpBVKS4fOt1eKkdo5k209ufGMqzBoqKCECT5c24IOvKp7A==
X-Received: by 2002:a05:600c:4711:b0:40e:f67d:d5f9 with SMTP id
 v17-20020a05600c471100b0040ef67dd5f9mr2509964wmo.4.1706544633645; 
 Mon, 29 Jan 2024 08:10:33 -0800 (PST)
Received: from localhost.localdomain (adsl-245.37.6.163.tellas.gr.
 [37.6.163.245]) by smtp.gmail.com with ESMTPSA id
 co6-20020a0560000a0600b0033af4df8e1esm1219957wrb.47.2024.01.29.08.10.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 08:10:33 -0800 (PST)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	qemu-block@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v3 2/6] hw/arm/z2: convert DPRINTF to trace events and guest
 errors
Date: Mon, 29 Jan 2024 18:09:37 +0200
Message-Id: <799c5141c5751cf2341e1d095349612e046424a8.1706544115.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1706544115.git.manos.pitsidianakis@linaro.org>
References: <cover.1706544115.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Tracing DPRINTFs to stderr might not be desired. A developer that relies
on trace events should be able to opt-in to each trace event and rely on
QEMU's log redirection, instead of stderr by default.

This commit converts DPRINTFs in this file that are used for tracing
into trace events. DPRINTFs that report guest errors are logged with
LOG_GUEST_ERROR.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/arm/trace-events |  7 +++++++
 hw/arm/z2.c         | 27 ++++++++-------------------
 2 files changed, 15 insertions(+), 19 deletions(-)

diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index 7c56943215..0ff41e6c78 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -58,3 +58,10 @@ smmuv3_inv_notifiers_iova(const char *name, uint16_t asid, uint16_t vmid, uint64
 # strongarm.c
 strongarm_uart_update_parameters(const char *label, int speed, char parity, int data_bits, int stop_bits) "%s speed=%d parity=%c data=%d stop=%d"
 strongarm_ssp_read_underrun(void) "SSP rx underrun"
+
+# z2.c
+z2_lcd_reg_update(uint8_t cur, uint8_t i_0, uint8_t i_1, uint8_t i_2, uint32_t value) "cur_reg = 0x%x, buf = [0x%x, 0x%x, 0x%x], value = 0x%x"
+z2_lcd_enable_disable_result(const char *result) "LCD %s"
+z2_aer915_send_too_long(int8_t msg) "message too long (%i bytes)"
+z2_aer915_send(uint8_t reg, uint8_t value) "reg %d value 0x%02x"
+z2_aer915_event(int8_t event, int8_t len) "i2c event =0x%x len=%d bytes"
diff --git a/hw/arm/z2.c b/hw/arm/z2.c
index a67fba2cfd..eb2ff8dbc8 100644
--- a/hw/arm/z2.c
+++ b/hw/arm/z2.c
@@ -27,13 +27,7 @@
 #include "exec/address-spaces.h"
 #include "qom/object.h"
 #include "qapi/error.h"
-
-#ifdef DEBUG_Z2
-#define DPRINTF(fmt, ...) \
-        printf(fmt, ## __VA_ARGS__)
-#else
-#define DPRINTF(fmt, ...)
-#endif
+#include "trace.h"
 
 static const struct keymap map[0x100] = {
     [0 ... 0xff] = { -1, -1 },
@@ -119,6 +113,8 @@ static uint32_t zipit_lcd_transfer(SSIPeripheral *dev, uint32_t value)
 {
     ZipitLCD *z = ZIPIT_LCD(dev);
     uint16_t val;
+
+    trace_z2_lcd_reg_update(z->cur_reg, z->buf[0], z->buf[1], z->buf[2], value);
     if (z->selected) {
         z->buf[z->pos] = value & 0xff;
         z->pos++;
@@ -126,22 +122,19 @@ static uint32_t zipit_lcd_transfer(SSIPeripheral *dev, uint32_t value)
     if (z->pos == 3) {
         switch (z->buf[0]) {
         case 0x74:
-            DPRINTF("%s: reg: 0x%.2x\n", __func__, z->buf[2]);
             z->cur_reg = z->buf[2];
             break;
         case 0x76:
             val = z->buf[1] << 8 | z->buf[2];
-            DPRINTF("%s: value: 0x%.4x\n", __func__, val);
             if (z->cur_reg == 0x22 && val == 0x0000) {
                 z->enabled = 1;
-                printf("%s: LCD enabled\n", __func__);
+                trace_z2_lcd_enable_disable_result("enabled");
             } else if (z->cur_reg == 0x10 && val == 0x0000) {
                 z->enabled = 0;
-                printf("%s: LCD disabled\n", __func__);
+                trace_z2_lcd_enable_disable_result("disabled");
             }
             break;
         default:
-            DPRINTF("%s: unknown command!\n", __func__);
             break;
         }
         z->pos = 0;
@@ -211,14 +204,12 @@ static int aer915_send(I2CSlave *i2c, uint8_t data)
 
     s->buf[s->len] = data;
     if (s->len++ > 2) {
-        DPRINTF("%s: message too long (%i bytes)\n",
-            __func__, s->len);
+        trace_z2_aer915_send_too_long(s->len);
         return 1;
     }
 
     if (s->len == 2) {
-        DPRINTF("%s: reg %d value 0x%02x\n", __func__,
-                s->buf[0], s->buf[1]);
+        trace_z2_aer915_send(s->buf[0], s->buf[1]);
     }
 
     return 0;
@@ -228,14 +219,12 @@ static int aer915_event(I2CSlave *i2c, enum i2c_event event)
 {
     AER915State *s = AER915(i2c);
 
+    trace_z2_aer915_event(s->len, event);
     switch (event) {
     case I2C_START_SEND:
         s->len = 0;
         break;
     case I2C_START_RECV:
-        if (s->len != 1) {
-            DPRINTF("%s: short message!?\n", __func__);
-        }
         break;
     case I2C_FINISH:
         break;
-- 
γαῖα πυρί μιχθήτω


