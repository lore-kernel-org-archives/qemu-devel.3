Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3A40F43688
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 09:58:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDfxo-0003ca-QR; Fri, 17 Apr 2026 05:58:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c.speich@avm.de>)
 id 1wDfxC-0002qB-1D; Fri, 17 Apr 2026 05:57:38 -0400
Received: from mail.avm.de ([2001:bf0:244:244::119])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c.speich@avm.de>)
 id 1wDfx9-000385-Fu; Fri, 17 Apr 2026 05:57:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
 t=1776419846; bh=SRP0r66lkPbAsXef7wraN73YdZHRb8aL7UMn1EI5U3Q=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=R98l8PsuL/yWR09LLVXQ6ScreJePL0C6Aj7xtTdXrjSQJIZmvLwu13Ep/steuNdP8
 N5TQw3Uhe+DD++DaHZ711S8QK5gA7qHeq3yzCLFjYw7U6CU4Vlqsqb+vIxbRUDir+Y
 gDEMMW+uYtcHsg7NMC+PjM1xEueP2RkmydvBiuMA=
Received: from [172.16.0.1] (helo=mail.avm.de)
 by mail.avm.de with ESMTP (eXpurgate 4.55.2)
 (envelope-from <c.speich@avm.de>)
 id 69e20406-1e6c-7f0000032729-7f000001b2d8-1
 for <multiple-recipients>; Fri, 17 Apr 2026 11:57:26 +0200
Received: from mail-notes.avm.de (mail-notes.avm.de [172.16.0.1])
 by mail.avm.de (Postfix) with ESMTP;
 Fri, 17 Apr 2026 11:57:26 +0200 (CEST)
Received: from [127.0.1.1] ([172.17.89.139])
 by mail-notes.avm.de (HCL Domino Release 14.0FP4)
 with ESMTP id 2026041711572446-2980 ;
 Fri, 17 Apr 2026 11:57:24 +0200 
From: Christian Speich <c.speich@avm.de>
Date: Fri, 17 Apr 2026 11:51:40 +0200
Subject: [PATCH v4 7/7] hw/sd: Update trace events for buf+len data
MIME-Version: 1.0
Message-Id: <20260417-sdcard-performance-b4-v4-7-119e66be10c2@avm.de>
References: <20260417-sdcard-performance-b4-v4-0-119e66be10c2@avm.de>
In-Reply-To: <20260417-sdcard-performance-b4-v4-0-119e66be10c2@avm.de>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Bin Meng
 <bmeng.cn@gmail.com>, qemu-block@nongnu.org, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Yanan Wang <wangyanan55@huawei.com>, Zhao Liu
 <zhao1.liu@intel.com>, Christian Speich <c.speich@avm.de>
X-Mailer: b4 0.14.2
X-MIMETrack: Itemize by SMTP Server on ANIS1/AVM(Release 14.0FP4|March 10,
 2025) at 17.04.2026 11:57:24,
 Serialize by Router on ANIS1/AVM(Release 14.0FP4|March 10, 2025) at
 17.04.2026 11:57:26, Serialize complete at 17.04.2026 11:57:26
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-purgate-ID: 149429::1776419846-48727373-546759EF/0/0
X-purgate-type: clean
X-purgate-size: 6295
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for
 further information)
X-purgate: clean
Received-SPF: pass client-ip=2001:bf0:244:244::119;
 envelope-from=c.speich@avm.de; helo=mail.avm.de
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

After switching sdbuf and sdcard over to use buf+len instead of single
byte operation, the trace events need to be updated.

This patch updates sdbus_{read,write} and sdcard_write_data to output the
buffer that is worked on.

sdcard_read_data is left unchanged, as it did not print the read byte
before anyways.

Signed-off-by: Christian Speich <c.speich@avm.de>
---
 hw/sd/core.c       | 27 +++++++++++++++++++++++++--
 hw/sd/sd.c         | 19 +++++++++++++++----
 hw/sd/trace-events |  6 +++---
 3 files changed, 43 insertions(+), 9 deletions(-)

diff --git a/hw/sd/core.c b/hw/sd/core.c
index 594c5e011ba30940a33799f9032c92494ee0ca19..eaa186fbfca3cdf000c200c3a844aac373ba7fec 100644
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
index d1ff9badb39b699ce734a533ccebfab894958d2d..13039187fcda2444d1b4aa173ab64c601bc71924 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -2690,11 +2690,22 @@ static bool sd_generic_read_data(SDState *sd, void *buf, size_t *len)
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
     int i;
-    const uint8_t *value = buf;
 
     if (!sd->blk || !blk_is_inserted(sd->blk)) {
         return length;
@@ -2709,9 +2720,9 @@ static size_t sd_write_data(SDState *sd, const void *buf, size_t length)
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
index 4ec52d2a81995ddf8d4ebef9dcc79224c90a2982..c6811f3a08e018fc45ec4f259b5895998b86bd77 100644
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
2.43.0


