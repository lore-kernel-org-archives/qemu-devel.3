Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A579BC71157
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Jun 2025 06:13:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRm2w-00024g-H9; Wed, 18 Jun 2025 02:13:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uRm2j-00022C-9Y
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 02:13:05 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uRm2g-0003x8-05
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 02:13:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=D9v47uSKLc62w6V16v9gIwfPdnVxFlgtiRE0Zg4WsaQ=; b=vrY3eSS0t4bFLuWPuf+FrcuCAG
 buNOuViNYdKKAJsm+tPdWqrylgBBC650hdepL4EUu9yskWMJirafYaKYIZYj/dOhObi4aKhyPGkgW
 8P3t4IthTXaOhONWoDUzip/5c+1HayWNMJq6rflhirGXYllAKAi24Mo7WxOdaWXMvla20qN6MpxPQ
 lawE4ZUK4LpnnkN4AGuWouYyxbEoIlz31fH5SUSMdXzlIV9+fHXK+7FMI6Z1HEXoqj+w83UiPGmqt
 Dfmy6/4fDjtceuMMio5dXCbwbhrUBtIBuMsVwJhKvY3HGbRUBpe8YHwR4xXImWSP68w/6UbDPAPcj
 PQSzYPYE3rego5dZzINsC3gasuyNDU1G2lPJiCU3N4RvgA1lEQr267F6WAZ9VA023Pz9w6nNeI1BT
 rBtAUpsLRkeT3x7XAVWUan/rnTl/6+rL0doTo3TaDnkr4aVFWgQ4g4NIsmLni78iY9/ZMt9zEbRLJ
 wd7RfX+j6Jb/kxpr/s0b1cELBnRWxFJB2p2hoJCc5Q0Je2GdT/mtanY9gOBZobLWK9fU0o0pQGwyL
 +3UZ1lUeSKuTepePEz2UgPs05bPbBqqkgk048QxEBJsKVXLT1tPdT1WUGXBUqRmJIN88yiuLwIlzI
 XzD6vstCYWDP71vX/MZw9WbHI5I4ZGpCgEXmdnaWk=;
Received: from [2a02:8012:2f01:0:737f:96a4:fe2:308c]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uRm18-0007ok-Qh; Wed, 18 Jun 2025 07:11:26 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com,
	fam@euphon.net,
	qemu-devel@nongnu.org
Date: Wed, 18 Jun 2025 07:12:44 +0100
Message-Id: <20250618061249.743897-3-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250618061249.743897-1-mark.cave-ayland@ilande.co.uk>
References: <20250618061249.743897-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:737f:96a4:fe2:308c
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 2/7] esp.c: improve comment in esp_transfer_data()
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
index 9181c8810f..62ba406149 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -1029,8 +1029,9 @@ void esp_transfer_data(SCSIRequest *req, uint32_t len)
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


