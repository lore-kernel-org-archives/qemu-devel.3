Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F3EFE6F08E
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2024 22:01:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6zhg-0004LL-MS; Fri, 01 Nov 2024 18:01:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t6zhe-0004Kn-79
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 18:01:10 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t6zhc-0002oH-U7
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 18:01:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=8wl31vWEym+Plbj9w5jpEhR79vNFKay4sFyDrn0ogbU=; b=xjrU9aHq+owXYS+RYQT3kWOwP5
 0ip2442C2Hp/4FuRZj6FzHshUTfVn5sUSjCSdq0vy+QYoWu9IrDRbNzVtz2Y70aqtPe3eKFVsOPju
 VGJsKff+bx/15ZJ7QOKQxTPPpOgD4mTcXbwQg7Vtn88MpGE8vQenkFgMnV0l5yC/en+Neko0S+aiM
 DDRtbStXvjeO+1unS9+YqOxEUpOrqaYXV3uO8M+DpfYUFSRkmo6zJ/ESKXFedrC53kjPOZhKwrtJQ
 epIX9MqR2kNiAmz8bUBZSgKmrhf9hjDMqoPh15nyyClIYUvAoK65HkWVrfNE1JM1LmvLG/FBw+8Yl
 BJ8pfxF9uZJ0kmr6YD1l+B3axWR7KYfuRERLQtUPmhSN7hdrVB3lWa25r5LwVe85Gm61c5AInykX7
 1mDJJJLT/+Fwd0ndyVSZk3FUy/xO6e7TbUfTDOl/gwOcQZCE4o75KqwxQzW5IAo6Oikrt5oYyGNSF
 2jEhJ6T/73akFBPU3MExJwwKx+bRaZLHYgtEW0LBYAeQYhaHld1dwJ1drIr5P0qINv7d23rTdx/T6
 NoI4YKIL+vUPZF2iMy54XR/n1grV2WLCz/znNxCIy7yJVnih0M+UDRxG42wHiIp6XOGmMlBQE5Usp
 vpRPU/N6DIlOgWLjjilt3TrmddNjCoPRGzGXMMsj8=;
Received: from [2a00:23c4:8bb8:f600:91a1:336d:3931:745]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t6zhC-0002pk-OL; Fri, 01 Nov 2024 22:00:46 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com,
	fam@euphon.net,
	qemu-devel@nongnu.org
Date: Fri,  1 Nov 2024 22:00:49 +0000
Message-Id: <20241101220052.1463805-3-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241101220052.1463805-1-mark.cave-ayland@ilande.co.uk>
References: <20241101220052.1463805-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb8:f600:91a1:336d:3931:745
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 2/5] esp.c: improve comment in esp_transfer_data()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Whilst working on the previous patch, the existing comment was not enough to
document when the TI command codepath was being used. Update and improve the
comment accordingly.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 5723290d62..36e92dcd7b 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -1032,8 +1032,9 @@ void esp_transfer_data(SCSIRequest *req, uint32_t len)
         case CMD_TI | CMD_DMA:
         case CMD_TI:
             /*
-             * Bus service interrupt raised because of initial change to
-             * DATA phase
+             * If the final COMMAND phase data was transferred using a TI
+             * command, clear ESP_CMD to terminate the TI command and raise
+             * the completion interrupt
              */
             s->rregs[ESP_CMD] = 0;
             s->rregs[ESP_RINTR] |= INTR_BS;
-- 
2.39.5


