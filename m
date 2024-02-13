Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18171C48260
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 20:05:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZyxm-00018Z-If; Tue, 13 Feb 2024 15:01:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyxa-00010b-TT
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 15:01:02 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyxY-0001pd-Nb
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 15:00:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ZCNugVb7WxY59bZ+uR6Pp0z4WpoZ+ACglW7b8SjGukM=; b=FrVMlI+2PXjxP/xH21mb4rAMFP
 TlAfogi7sctyFuYByCnmKDdGtEOstWJYtUxrdf27ad+qU0J7EgXWDx32DRJXS89i9qcbLVDaAOr1h
 jYLg1vl7c5DC7wyP9bbpbRz6OrB6pxfud4sns1Ge59/UDCNV/6z3Ka6ZB3VPwElSDlai5nC/sAbWd
 cso+rfYC5APQhjqQ31UZNEVH8iM/kAP+DuM3YPKMiwf7Rx3OXfdLINB1ECXflLMMQIfE4jS8Y2EFn
 4r1cHrICNyJ38BFlAfGfMxFtPWl1X/r9Ph9VWIBhNmKEv/QO0xNCBOfrmRRLZBtidh0o/LZO8fGOy
 eUnLApMzuytqOKzyjs5ygzBvR/hS1LD1kVFKQFycgLkitH1CCKNLLy3UiBoVotF0tyrEwavA0guVC
 VCbsShUCOdv3z8emhAAgcRgWr9UO+qUOGvB/xYXLx92gt33YbKTRBmUbqFwOqAZi1Y1MfDpBCQfIz
 tMNlVx4Q22UYtoqpEsd5cc4SLdH7XjL2Pk+C0QLUGtehte6LUyRuL65lgbU18mYtMOMT+EyYgv+tv
 puRY8jejyMhR7oYQ0Wc3wKINqvP98mg3kPVLPVB/Lb51psAxpsUselRUdUlFlMKGHB01XFcpHcXkf
 K0mZovzRUHVsLX5ybsa22mySO83GbnyLsZ7AzwEGs=;
Received: from [2a00:23c4:8bb2:1300:c500:f104:bc51:e670]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZygk-0008m4-MV; Tue, 13 Feb 2024 19:43:33 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Date: Tue, 13 Feb 2024 19:40:21 +0000
Message-Id: <20240213194052.1162753-58-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
References: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb2:1300:c500:f104:bc51:e670
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 57/88] esp.c: rename data_in_ready to to data_ready
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

This field is currently used to handle deferred interrupts for the DATA IN phase
but the code will soon be updated to do the same for the DATA OUT phase.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Tested-by: Helge Deller <deller@gmx.de>
Tested-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20240112125420.514425-58-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c         | 8 ++++----
 include/hw/scsi/esp.h | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 5061c9d5a1..73c723afcc 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -328,7 +328,7 @@ static void do_command_phase(ESPState *s)
              * Switch to DATA IN phase but wait until initial data xfer is
              * complete before raising the command completion interrupt
              */
-            s->data_in_ready = false;
+            s->data_ready = false;
             esp_set_phase(s, STAT_DI);
         } else {
             esp_set_phase(s, STAT_DO);
@@ -859,12 +859,12 @@ void esp_transfer_data(SCSIRequest *req, uint32_t len)
     s->async_len = len;
     s->async_buf = scsi_req_get_buf(req);
 
-    if (!to_device && !s->data_in_ready) {
+    if (!to_device && !s->data_ready) {
         /*
          * Initial incoming data xfer is complete so raise command
          * completion interrupt
          */
-        s->data_in_ready = true;
+        s->data_ready = true;
         s->rregs[ESP_RINTR] |= INTR_BS;
         esp_raise_irq(s);
     }
@@ -1241,7 +1241,7 @@ const VMStateDescription vmstate_esp = {
         VMSTATE_UINT32_TEST(mig_cmdlen, ESPState, esp_is_before_version_5),
         VMSTATE_UINT32(do_cmd, ESPState),
         VMSTATE_UINT32_TEST(mig_dma_left, ESPState, esp_is_before_version_5),
-        VMSTATE_BOOL_TEST(data_in_ready, ESPState, esp_is_version_5),
+        VMSTATE_BOOL_TEST(data_ready, ESPState, esp_is_version_5),
         VMSTATE_UINT8_TEST(cmdfifo_cdb_offset, ESPState, esp_is_version_5),
         VMSTATE_FIFO8_TEST(fifo, ESPState, esp_is_version_5),
         VMSTATE_FIFO8_TEST(cmdfifo, ESPState, esp_is_version_5),
diff --git a/include/hw/scsi/esp.h b/include/hw/scsi/esp.h
index 6f942864a6..1036606943 100644
--- a/include/hw/scsi/esp.h
+++ b/include/hw/scsi/esp.h
@@ -40,7 +40,7 @@ struct ESPState {
     uint8_t lun;
     uint32_t do_cmd;
 
-    bool data_in_ready;
+    bool data_ready;
     uint8_t ti_cmd;
     int dma_enabled;
 
-- 
2.39.2


