Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 172BFC4829F
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 20:04:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZz0d-0004on-Sq; Tue, 13 Feb 2024 15:04:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZz0B-0003vQ-B5
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 15:03:35 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZz09-0002An-NN
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 15:03:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cfhlzrwDQ8CNlxP8yl8X90lb9cN5al37GV4VXNcU3zQ=; b=R+pzdNrFNxUWjp1xxkBCUk0gjl
 CzIknfmMnFuBuhd/7389yd97398Fz1/Yt2uPxAQu12HBdqa1d7cnRksO0m8OF1BjC04Gyn9J3dXnK
 ewt26HJjC5/137KZIdbF1gzNqoETQXncxe6g1Tbte0Wpi6iUuKminMX05p1jEIZ8MgadKfFAvzgvo
 9hgCaJlYJuEbZSrTiWCxc4IiGfOul1doVNNDSw2N4/fJC2JWJVryRMWWLvEEaudYy36I5I94BGIn/
 wPnqRJlBf2U6ZuXz+hLtuGHqjXVdWu31aU07+hjF0G6noQ1pBVqDuAOunUWRV2DejezB74yKyMJwY
 6wU3fh2IZo//TPbjGAufkjGLCN0cTIkHXrdRL4EUaOc9na+PJST29yiOZH+r8nG8tpVNTV+qzu7fz
 Bqpk2RIUxJnUYcgfaCI3y4moeyv0kUwYBU6NI+qrSgM7cRMwYOwSv6f5W+dfFqn1pZbA9LcAYA5Px
 qoke+BzRjiShU9UD9J6l1ltE83ji65MZNzzPBp+ttks41OsyDttC42g3U/zScWEUk+G711drpm9YH
 bUuEPIsjHBmxifL/w5Sb2NA/39Jezm7FiFUImKhSDFgOOzadpGjUh2XI4rRax+9nRqq3tK9lyKUgg
 ttN6/xdtf8oiNuL6oqOb2ZpeAkM4s6mxZe30UIq+s=;
Received: from [2a00:23c4:8bb2:1300:c500:f104:bc51:e670]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZygh-0008m4-3c; Tue, 13 Feb 2024 19:43:30 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Date: Tue, 13 Feb 2024 19:40:20 +0000
Message-Id: <20240213194052.1162753-57-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
References: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb2:1300:c500:f104:bc51:e670
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 56/88] esp.c: remove unused PDMA callback implementation
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Note that this is a migration break for the q800 machine because the extra PDMA
information is no longer included.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Tested-by: Helge Deller <deller@gmx.de>
Tested-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20240112125420.514425-57-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c         | 55 ++++---------------------------------------
 include/hw/scsi/esp.h |  6 -----
 2 files changed, 5 insertions(+), 56 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index bdbdb209f7..5061c9d5a1 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -223,11 +223,6 @@ static void esp_pdma_write(ESPState *s, uint8_t val)
     esp_set_tc(s, dmalen);
 }
 
-static void esp_set_pdma_cb(ESPState *s, enum pdma_cb cb)
-{
-    s->pdma_cb = cb;
-}
-
 static int esp_select(ESPState *s)
 {
     int target;
@@ -377,7 +372,7 @@ static void handle_satn(ESPState *s)
         s->dma_cb = handle_satn;
         return;
     }
-    esp_set_pdma_cb(s, DO_DMA_PDMA_CB);
+
     if (esp_select(s) < 0) {
         return;
     }
@@ -400,7 +395,7 @@ static void handle_s_without_atn(ESPState *s)
         s->dma_cb = handle_s_without_atn;
         return;
     }
-    esp_set_pdma_cb(s, DO_DMA_PDMA_CB);
+
     if (esp_select(s) < 0) {
         return;
     }
@@ -424,7 +419,7 @@ static void handle_satn_stop(ESPState *s)
         s->dma_cb = handle_satn_stop;
         return;
     }
-    esp_set_pdma_cb(s, DO_DMA_PDMA_CB);
+
     if (esp_select(s) < 0) {
         return;
     }
@@ -497,7 +492,6 @@ static void esp_do_dma(ESPState *s)
             s->cmdfifo_cdb_offset += n;
         }
 
-        esp_set_pdma_cb(s, DO_DMA_PDMA_CB);
         esp_raise_drq(s);
 
         switch (s->rregs[ESP_CMD]) {
@@ -551,7 +545,6 @@ static void esp_do_dma(ESPState *s)
             n = MIN(fifo8_num_free(&s->cmdfifo), n);
             fifo8_push_all(&s->cmdfifo, buf, n);
 
-            esp_set_pdma_cb(s, DO_DMA_PDMA_CB);
             esp_raise_drq(s);
         }
         trace_esp_handle_ti_cmd(cmdlen);
@@ -597,7 +590,6 @@ static void esp_do_dma(ESPState *s)
             s->async_len -= n;
             s->ti_size += n;
 
-            esp_set_pdma_cb(s, DO_DMA_PDMA_CB);
             esp_raise_drq(s);
 
             if (s->async_len == 0 && fifo8_num_used(&s->fifo) < 2) {
@@ -644,7 +636,6 @@ static void esp_do_dma(ESPState *s)
             s->async_len -= len;
             s->ti_size -= len;
             esp_set_tc(s, esp_get_tc(s) - len);
-            esp_set_pdma_cb(s, DO_DMA_PDMA_CB);
             esp_raise_drq(s);
 
             if (s->async_len == 0 && fifo8_num_used(&s->fifo) < 2) {
@@ -805,11 +796,6 @@ static void esp_do_nodma(ESPState *s)
     }
 }
 
-static void esp_pdma_cb(ESPState *s)
-{
-    esp_do_dma(s);
-}
-
 void esp_command_complete(SCSIRequest *req, size_t resid)
 {
     ESPState *s = req->hba_private;
@@ -1229,33 +1215,6 @@ static int esp_post_load(void *opaque, int version_id)
     return 0;
 }
 
-/*
- * PDMA (or pseudo-DMA) is only used on the Macintosh and requires the
- * guest CPU to perform the transfers between the SCSI bus and memory
- * itself. This is indicated by the dma_memory_read and dma_memory_write
- * functions being NULL (in contrast to the ESP PCI device) whilst
- * dma_enabled is still set.
- */
-
-static bool esp_pdma_needed(void *opaque)
-{
-    ESPState *s = ESP(opaque);
-
-    return s->dma_memory_read == NULL && s->dma_memory_write == NULL &&
-           s->dma_enabled;
-}
-
-static const VMStateDescription vmstate_esp_pdma = {
-    .name = "esp/pdma",
-    .version_id = 0,
-    .minimum_version_id = 0,
-    .needed = esp_pdma_needed,
-    .fields = (const VMStateField[]) {
-        VMSTATE_UINT8(pdma_cb, ESPState),
-        VMSTATE_END_OF_LIST()
-    }
-};
-
 const VMStateDescription vmstate_esp = {
     .name = "esp",
     .version_id = 6,
@@ -1290,10 +1249,6 @@ const VMStateDescription vmstate_esp = {
         VMSTATE_UINT8_TEST(lun, ESPState, esp_is_version_6),
         VMSTATE_END_OF_LIST()
     },
-    .subsections = (const VMStateDescription * const []) {
-        &vmstate_esp_pdma,
-        NULL
-    }
 };
 
 static void sysbus_esp_mem_write(void *opaque, hwaddr addr,
@@ -1342,7 +1297,7 @@ static void sysbus_esp_pdma_write(void *opaque, hwaddr addr,
         esp_pdma_write(s, val);
         break;
     }
-    esp_pdma_cb(s);
+    esp_do_dma(s);
 }
 
 static uint64_t sysbus_esp_pdma_read(void *opaque, hwaddr addr,
@@ -1363,7 +1318,7 @@ static uint64_t sysbus_esp_pdma_read(void *opaque, hwaddr addr,
         val = (val << 8) | esp_pdma_read(s);
         break;
     }
-    esp_pdma_cb(s);
+    esp_do_dma(s);
     return val;
 }
 
diff --git a/include/hw/scsi/esp.h b/include/hw/scsi/esp.h
index 0207fdd7a6..6f942864a6 100644
--- a/include/hw/scsi/esp.h
+++ b/include/hw/scsi/esp.h
@@ -51,7 +51,6 @@ struct ESPState {
     ESPDMAMemoryReadWriteFunc dma_memory_write;
     void *dma_opaque;
     void (*dma_cb)(ESPState *s);
-    uint8_t pdma_cb;
 
     uint8_t mig_version_id;
 
@@ -150,11 +149,6 @@ struct SysBusESPState {
 #define TCHI_FAS100A 0x4
 #define TCHI_AM53C974 0x12
 
-/* PDMA callbacks */
-enum pdma_cb {
-    DO_DMA_PDMA_CB = 4
-};
-
 void esp_dma_enable(ESPState *s, int irq, int level);
 void esp_request_cancelled(SCSIRequest *req);
 void esp_command_complete(SCSIRequest *req, size_t resid);
-- 
2.39.2


