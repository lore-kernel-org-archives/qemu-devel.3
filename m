Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 017C0C48260
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 19:48:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZyf4-0002wX-5e; Tue, 13 Feb 2024 14:41:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyf1-0002w3-Ih
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 14:41:43 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyf0-0006IE-7a
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 14:41:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CQ5UkPsbIeBr8TdR6L3O6LadqjAggrnKeQrTFsf0tRI=; b=wiwFUHptsy0+TxCVcTUcqjO2Og
 MQnXYzoO/Vqn84UfpSx4Lus8c8P4GWxbKRziFmjOuQcC1YMgZ3tompBin50gLlgsh77BgauFglvuV
 1WrcxVkMA4TLwNWI8xhuPRZvVBDvjnWbML4y55ML8ft/6Tr5Gz7t7ydpWqu95lSKKWFtsep7m/QOo
 gwshx5m2g/rGds3a5D6nCq+3sL834YJbULLHZYzsAW/IcI/Ylz7A9DYBnT2Wn8a2c4c0wsIB2mARk
 rpahQzThUA4xDieec8rv/Ju9oSkLN5kH4xFJUagVCEi+6lVlUkzaXi0liFw7eMcdBZz1W4QLZukFL
 ANHs4bs1q4+DuIOfBMsJB6+N4+PFbJ5vVRQm9ZrSRr0XBFNAqg6z/ZdCrwIGJ2UmHCilOGSogYucA
 ekrYtNicDnI3NyHu0H0+WJWaY8mPKeyuGLG/RILaDhWeoBvrk22lSIuPIyEcqRTviz4BQ4Zq7taZe
 fMz+hYy91TIBIor9n4sgjnZ5uiG+cwCF4nJEP4gXVFPlhH3FjThzz74pVk1ewBIgLCMrnfDYbVkH3
 7bmtR0CDF9jMpCfnBTvTvDgubwwt1GfkRcpav6lSSqv5jFJ48BbyPtI9k2/Ah0pYk5qX/TGGqSRuy
 tk7+XBQYCLw3ueJArHUyL2TxGIvXFd37/rOZ4xmg8=;
Received: from [2a00:23c4:8bb2:1300:c500:f104:bc51:e670]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyeH-0008m4-GH; Tue, 13 Feb 2024 19:41:01 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Date: Tue, 13 Feb 2024 19:39:35 +0000
Message-Id: <20240213194052.1162753-12-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
References: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb2:1300:c500:f104:bc51:e670
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 11/88] esp.c: remove unused case from esp_pdma_read()
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

The do_cmd variable is only set for the MESSAGE OUT and COMMAND phases i.e.
those which involve transfers from the host to the SCSI bus, and so the unused
case can be removed.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Tested-by: Helge Deller <deller@gmx.de>
Tested-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20240112125420.514425-12-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 9893840255..6191c17f10 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -187,12 +187,7 @@ static uint8_t esp_pdma_read(ESPState *s)
 {
     uint8_t val;
 
-    if (s->do_cmd) {
-        val = esp_fifo_pop(&s->cmdfifo);
-    } else {
-        val = esp_fifo_pop(&s->fifo);
-    }
-
+    val = esp_fifo_pop(&s->fifo);
     return val;
 }
 
-- 
2.39.2


