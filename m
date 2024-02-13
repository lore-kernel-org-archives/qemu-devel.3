Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A4E0C4829A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 20:11:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZz0N-0004E9-4R; Tue, 13 Feb 2024 15:03:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyzr-0003TC-BG
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 15:03:15 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyzn-00029K-VB
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 15:03:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2jpEwFF0iWK0ipjHESSVnu863cezPVN31mvVo4kKl7k=; b=GHAac6CtGWCrYeiIJJD9PRwrvF
 VNrY6YztYjDxzoCiZgfSHW/MXJhOfhAzwWtKAqZkpFoYEdQ+dAo7RaEb+6CC0F6SjUjiIB6hRN/iu
 6fmiLBKwtb7aJHasgTn6HdffNXcNfPBVJNvA10xmyyM7MQNr77epjzpueZgdOp3sLKTKqbMb9Juxu
 piS108BY+TA21NMiZnV6WUaEr4amfYErlrV/dirrjWZbv4aPr8LwRadqsZ262GHXFQcQ2IiuzabpY
 neMXQPXkwjWybPuBjYRxZGPQcXNjrUUg8AwFJMMSBvXm/dksev5Zh523vamjVqiw19HmHOG3wLsj1
 Dan9vsHJiBK9pzEfSNgVf39UwE5cOIoGUOQaVyyvcVF5Zfu64S6V7bDeTTlXLfvUdSrr1dgenQrME
 Mjh5eBrRTKKcKGEScpS4+DFk2HxtKJtCYubFXyuMbzxCZOmv5BCSUuW7sz+t1Lf/uOepAQDmyeidN
 O2jTkCafBxe3KPzVaNKgpts4U6wkm2Oxv5GFfZVTqGuTm7babRDkekXRYVQy9S7C9JAWKZdLH6esR
 g88LqOsgqLDi8YyejQ+Jf/ldTChvTn7NWx+CjARGv+U35xfxYnLqeuhdj2gHSUQszhMG8W8ZYGu70
 Z5H/GIQsK6sbdf3p8v1XdFQsQrgJagxe7hW5+3Ay8=;
Received: from [2a00:23c4:8bb2:1300:c500:f104:bc51:e670]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyi2-0008m4-Le; Tue, 13 Feb 2024 19:44:50 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Date: Tue, 13 Feb 2024 19:40:49 +0000
Message-Id: <20240213194052.1162753-86-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
References: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb2:1300:c500:f104:bc51:e670
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 85/88] esp.c: rename irq_data IRQ to drq_irq
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

The IRQ represented by irq_data is actually the DRQ (DMA request) line so rename
it accordingly.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Tested-by: Helge Deller <deller@gmx.de>
Tested-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20240112125420.514425-86-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c         | 8 ++++----
 include/hw/scsi/esp.h | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 5583b3eb56..fb68606f00 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -62,13 +62,13 @@ static void esp_lower_irq(ESPState *s)
 
 static void esp_raise_drq(ESPState *s)
 {
-    qemu_irq_raise(s->irq_data);
+    qemu_irq_raise(s->drq_irq);
     trace_esp_raise_drq();
 }
 
 static void esp_lower_drq(ESPState *s)
 {
-    qemu_irq_lower(s->irq_data);
+    qemu_irq_lower(s->drq_irq);
     trace_esp_lower_drq();
 }
 
@@ -1062,7 +1062,7 @@ void esp_hard_reset(ESPState *s)
 static void esp_soft_reset(ESPState *s)
 {
     qemu_irq_lower(s->irq);
-    qemu_irq_lower(s->irq_data);
+    qemu_irq_lower(s->drq_irq);
     esp_hard_reset(s);
 }
 
@@ -1489,7 +1489,7 @@ static void sysbus_esp_realize(DeviceState *dev, Error **errp)
     }
 
     sysbus_init_irq(sbd, &s->irq);
-    sysbus_init_irq(sbd, &s->irq_data);
+    sysbus_init_irq(sbd, &s->drq_irq);
     assert(sysbus->it_shift != -1);
 
     s->chip_id = TCHI_FAS100A;
diff --git a/include/hw/scsi/esp.h b/include/hw/scsi/esp.h
index 39b416f538..c6e8b64e20 100644
--- a/include/hw/scsi/esp.h
+++ b/include/hw/scsi/esp.h
@@ -25,7 +25,7 @@ struct ESPState {
     uint8_t rregs[ESP_REGS];
     uint8_t wregs[ESP_REGS];
     qemu_irq irq;
-    qemu_irq irq_data;
+    qemu_irq drq_irq;
     uint8_t chip_id;
     bool tchi_written;
     int32_t ti_size;
-- 
2.39.2


