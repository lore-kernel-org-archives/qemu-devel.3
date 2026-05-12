Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FA9DCD484E
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 06:22:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMgW0-0000s2-VX; Tue, 12 May 2026 02:22:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMgVu-0000mG-T0
 for qemu-devel@nongnu.org; Tue, 12 May 2026 02:22:43 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMgVp-0004Be-Ik
 for qemu-devel@nongnu.org; Tue, 12 May 2026 02:22:41 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-43eb05b1875so2991388f8f.3
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 23:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778566954; x=1779171754; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=e9Ch+50Vvu+y+CEmf0cTw7Jm9O7lEL4i3plSrCUI1YE=;
 b=CbS+akE5Xl2unl07VpifiTJtiyh1P7YDmxUF1qH6lxeTPoO8XzR3Ct9Ig7PjpWn/HA
 Nx1IeRgI1wagsXJpE4kVSZpZZ3Wuac7BMP6WlXGoZ/HANZbawEh2pxtguN8GBlaMH90i
 y1xII2bucDg3QnFtlJj88UvxyewNYs3+qUeSNsMIgurp2KP6B14rMOyORIR1CDFC6CqM
 pk8a1JJS3YZd0fHLLGb3qGDz1VXtvsreYdv7CEmtlYaVeKYN8BuZEtG81nRIs/cd3AH4
 n4TG6Tf6UGuoKeE1ZWJGjwfMl7D6Z+AKmQTx7/owcnzIFaW9dsZ0mWKF53cUY9ySaOwM
 43xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778566954; x=1779171754;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=e9Ch+50Vvu+y+CEmf0cTw7Jm9O7lEL4i3plSrCUI1YE=;
 b=f0/o4oRUUnqi+mfwq5qm3vpPf92Qi0dSjRYZ8FVy3lL6ipZxyWsFo0vRTpIfPQ+2sl
 Ky8aNPxhN6YQTTk0BYC+8UisfaaUtgowC8kZT3HeqZ/UFpW3ruFB8KwSCbJTKEVZmAcX
 CfEk4dhGiQkPlr/IJOEYwjk/P6UWeFtdJ2o6o9aGMV/073jeooF7nA6tXKi2Wctf2o17
 ubpKC5TgnJJVwGP0Ep8UO6noN75FOEwxuN30hmtmaqQ5lO8hlwHNTRLqvqMpKXT8tzJv
 yCSlQAtK15bZPxHVjPmXQRXSJyiWgLa8RZHleNWb5BVKZq1LGO7coe3rvxOTktI/1kyz
 NLwQ==
X-Gm-Message-State: AOJu0Ywnof2oPsf8PMPgLrYOXF8KJt+BXnif+OaCB+bvKiztz2jOOeyL
 DyG3ZBw7Y6gFcep7Gjk9TSfVm+vDBNroginp4MPHWeaBq2R9vrfwnm1mpJIYH+yG6bcyQB5Iitk
 NET4hnjU=
X-Gm-Gg: Acq92OGxc/7khK8Bwy77liwXwHcRoe7O+qnCFq08ygmdgpbjA9FNJZMlO8RIJfrsQvM
 lFMuyd7ciGhWRglvdTMLAd0eXAc4tJ2ASYXLHI/FbADzAy1a15eRtE5dZ09v+tHj2T7Ec/LZTvl
 9J6t5qwsCUcZHy1uz53TBwdXZiQAj9VNS5hC6tFO3sVmIrMotNFh/dGrzEogpUYgtSMKIfBCUOP
 MUosT9QQGo2H1VTHTZIX8vuWTe5O0KctB2lypPYREFqpgf5NwNutZPD50ABjhnEDXxLfspR6NtE
 BHgjR3RvMHv3EmGHkludVjTr6kYYzE8nfSLaFcz3tjC4A7QYjc9eK7NZQpOEzZIMe8SdPdo+2JE
 rZGPFF0CRRmZO9b4cxwZ0kfdaqlB8dQHAEauAJwI/ZgvL5Q1c+rYJL8Yiah34z1tsO5vdhL50fW
 LZLl1JTjNIRoA00juZRqyhB/xD8lktDDKntbPnSuUIjjpWAVehhC4RNeqlWWsggC0vw8d0x4g1
X-Received: by 2002:a05:6000:2903:b0:455:d927:1b30 with SMTP id
 ffacd0b85a97d-4568c47c928mr18374538f8f.28.1778566954310; 
 Mon, 11 May 2026 23:22:34 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-454919c13c9sm29754513f8f.27.2026.05.11.23.22.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 11 May 2026 23:22:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/41] hw/sd: Update trace events for buf+len data
Date: Tue, 12 May 2026 08:21:08 +0200
Message-ID: <20260512062142.67998-8-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260512062142.67998-1-philmd@linaro.org>
References: <20260512062142.67998-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

From: Christian Speich <c.speich@avm.de>

After switching sdbuf and sdcard over to use buf+len instead of single
byte operation, the trace events need to be updated.

This patch updates sdbus_{read,write} and sdcard_write_data to output the
buffer that is worked on.

sdcard_read_data is left unchanged, as it did not print the read byte
before anyways.

Signed-off-by: Christian Speich <c.speich@avm.de>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260417-sdcard-performance-b4-v4-7-119e66be10c2@avm.de>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/core.c       | 27 +++++++++++++++++++++++++--
 hw/sd/sd.c         | 18 +++++++++++++++---
 hw/sd/trace-events |  6 +++---
 3 files changed, 43 insertions(+), 8 deletions(-)

diff --git a/hw/sd/core.c b/hw/sd/core.c
index 594c5e011ba..eaa186fbfca 100644
--- a/hw/sd/core.c
+++ b/hw/sd/core.c
@@ -24,6 +24,7 @@
 #include "hw/sd/sd.h"
 #include "qemu/module.h"
 #include "qapi/error.h"
+#include "qemu/cutils.h"
 #include "sdmmc-internal.h"
 #include "trace.h"
 
@@ -43,6 +44,26 @@ static SDState *get_card(SDBus *sdbus)
     return SDMMC_COMMON(kid->child);
 }
 
+static void sdbus_write_dump(const char *bus_name, const void *buf, size_t len)
+{
+    g_autoptr(GString) str = NULL;
+
+    if (trace_event_get_state_backends(TRACE_SDBUS_WRITE)) {
+        str = qemu_hexdump_line(NULL, buf, len, 8, 0);
+        trace_sdbus_write(bus_name, str->str);
+    }
+}
+
+static void sdbus_read_dump(const char *bus_name, const void *buf, size_t len)
+{
+    g_autoptr(GString) str = NULL;
+
+    if (trace_event_get_state_backends(TRACE_SDBUS_READ)) {
+        str = qemu_hexdump_line(NULL, buf, len, 8, 0);
+        trace_sdbus_read(bus_name, str->str);
+    }
+}
+
 uint8_t sdbus_get_dat_lines(SDBus *sdbus)
 {
     SDState *slave = get_card(sdbus);
@@ -109,7 +130,7 @@ void sdbus_write_byte(SDBus *sdbus, uint8_t value)
 {
     SDState *card = get_card(sdbus);
 
-    trace_sdbus_write(sdbus_name(sdbus), value);
+    sdbus_write_dump(sdbus_name(sdbus), &value, 1);
     if (card) {
         SDCardClass *sc = SDMMC_COMMON_GET_CLASS(card);
 
@@ -121,6 +142,7 @@ void sdbus_write_data(SDBus *sdbus, const void *buf, size_t length)
 {
     SDState *card = get_card(sdbus);
 
+    sdbus_write_dump(sdbus_name(sdbus), buf, length);
     if (card) {
         SDCardClass *sc = SDMMC_COMMON_GET_CLASS(card);
 
@@ -145,7 +167,7 @@ uint8_t sdbus_read_byte(SDBus *sdbus)
 
         sc->read_data(card, &value, 1);
     }
-    trace_sdbus_read(sdbus_name(sdbus), value);
+    sdbus_read_dump(sdbus_name(sdbus), &value, 1);
 
     return value;
 }
@@ -166,6 +188,7 @@ void sdbus_read_data(SDBus *sdbus, void *buf, size_t length)
             length -= read;
         }
     }
+    sdbus_read_dump(sdbus_name(sdbus), buf, length);
 }
 
 bool sdbus_receive_ready(SDBus *sdbus)
diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index b49b83b96e8..92cf8aed58f 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -2647,6 +2647,18 @@ static bool sd_generic_read_data(SDState *sd, void *buf, size_t *len)
     return false;
 }
 
+static void sdcard_write_data_dump(const char *proto, const char *cmd_desc,
+                                   uint8_t cmd, uint32_t offset,
+                                   const void *buf, size_t len)
+{
+    g_autoptr(GString) str = NULL;
+
+    if (trace_event_get_state_backends(TRACE_SDCARD_WRITE_DATA)) {
+        str = qemu_hexdump_line(NULL, buf, len, 8, 0);
+        trace_sdcard_write_data(proto, cmd_desc, cmd, offset, str->str);
+    }
+}
+
 static size_t sd_write_data(SDState *sd, const void *buf, size_t length)
 {
     unsigned int partition_access;
@@ -2666,9 +2678,9 @@ static size_t sd_write_data(SDState *sd, const void *buf, size_t length)
     if (sd->card_status & (ADDRESS_ERROR | WP_VIOLATION))
         return length;
 
-    trace_sdcard_write_data(sd->proto->name,
-                            sd->last_cmd_name,
-                            sd->current_cmd, sd->data_offset, value[0]);
+    sdcard_write_data_dump(sd->proto->name,
+                           sd->last_cmd_name,
+                           sd->current_cmd, sd->data_offset, buf, length);
     switch (sd->current_cmd) {
     case 24:  /* CMD24:  WRITE_SINGLE_BLOCK */
         if (sd_generic_write_data(sd, buf, &length)) {
diff --git a/hw/sd/trace-events b/hw/sd/trace-events
index 4ec52d2a819..c6811f3a08e 100644
--- a/hw/sd/trace-events
+++ b/hw/sd/trace-events
@@ -15,8 +15,8 @@ bcm2835_sdhost_update_irq(uint32_t irq) "IRQ bits 0x%x"
 
 # core.c
 sdbus_command(const char *bus_name, uint8_t cmd, uint32_t arg) "@%s CMD%02d arg 0x%08x"
-sdbus_read(const char *bus_name, uint8_t value) "@%s value 0x%02x"
-sdbus_write(const char *bus_name, uint8_t value) "@%s value 0x%02x"
+sdbus_read(const char *bus_name, const char *hexdump) "@%s data %s"
+sdbus_write(const char *bus_name, const char *hexdump) "@%s data %s"
 sdbus_set_voltage(const char *bus_name, uint16_t millivolts) "@%s %u (mV)"
 sdbus_get_dat_lines(const char *bus_name, uint8_t dat_lines) "@%s dat_lines: %u"
 sdbus_get_cmd_line(const char *bus_name, bool cmd_line) "@%s cmd_line: %u"
@@ -54,7 +54,7 @@ sdcard_unlock(void) ""
 sdcard_req_addr(uint32_t req_arg, uint64_t addr) "req 0x%" PRIx32 " addr 0x%" PRIx64
 sdcard_read_block(uint64_t addr, uint32_t len) "addr 0x%" PRIx64 " size 0x%x"
 sdcard_write_block(uint64_t addr, uint32_t len) "addr 0x%" PRIx64 " size 0x%x"
-sdcard_write_data(const char *proto, const char *cmd_desc, uint8_t cmd, uint32_t offset, uint8_t value) "%s %20s/ CMD%02d ofs %"PRIu32" value 0x%02x"
+sdcard_write_data(const char *proto, const char *cmd_desc, uint8_t cmd, uint32_t offset, const char *hexdump) "%s %20s/ CMD%02d ofs %"PRIu32" data %s"
 sdcard_read_data(const char *proto, const char *cmd_desc, uint8_t cmd, uint32_t offset, uint64_t size, uint32_t blklen) "%s %20s/ CMD%02d ofs %"PRIu32" size %"PRIu64" blklen %" PRIu32
 sdcard_set_voltage(uint16_t millivolts) "%u mV"
 sdcard_ext_csd_update(unsigned index, uint8_t oval, uint8_t nval) "index %u: 0x%02x -> 0x%02x"
-- 
2.53.0


