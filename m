Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 411E4C83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 20:51:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaKed-0003ai-D7; Fri, 11 Jul 2025 16:47:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uaKdv-0003Jx-7J
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 16:46:55 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uaKdr-0003iy-Co
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 16:46:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID;
 bh=DaL2mqf1oOve9B6MZryX4sutK73zfpe2Dc7xtYjrFJs=; b=ZYrybVF1RBK1cuFdvY7qR20nyt
 to/TQsd0mZRwQehxRvsJ+8So2bgVm8quY8kuspVrgDpod3A7v0C0LKXn0TnZpQe77GGpi1xWEZONm
 ZMdI4/Vz9bQBi7Gr1BOKU/0B81rtZH0rI2oN0nwUtV+Hxb27QssJb6PSz4tu7RcG+l6BQxJQu6mO+
 lwDE5S6EDPra5TDzvAPHvirKjUIBd/wqYmy4wo7ihBDCLQwHsnfNvI28Cmnz6a+RYimFpEZc0CBiY
 /J4b21ng8kcb4kUVyf1I/C2WokFWgUCM5wmdWKxZzcFF/Vai4+qY8KZDYLTHAKbBsefAwUe0HXDAg
 CJPrf9HYO7QQIPIVXtQLGxXwcxkmFoP+kK8sGjJqe3ZfmBmO5CurwU3j2oCxNplW9xzEQwahKFNcT
 uf8lIYP6HNDnTmXb+QnnlQ4wou8858LhQJlqzUFNCgIoyVRcKSvveZq8hchljsSVSUQNXpU4n53/U
 PhlvUdp3sQ2Z9esY89yl5zE15KDtjgA8dl/jRCU4PAR9uKn8g1Rps+e4npv8Xqy1vieUkkl/7Rv9d
 08nzkKovZMrf2zXObk8a2fW0rsqO1XaHyY635nZPjcDbzDQzcgWca4LR+nD3Go3PYSu0eLv199mJ2
 WRkS5/5rZ4PPcuY3JWBuOj1N48u5b17I+Lx/fyUqc=;
Received: from [2a02:8012:2f01:0:d1ff:478a:c096:2d0c]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uaKcC-000Bmy-IV; Fri, 11 Jul 2025 21:45:04 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com,
	fam@euphon.net,
	qemu-devel@nongnu.org
Date: Fri, 11 Jul 2025 21:46:31 +0100
Message-Id: <20250711204636.542964-3-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250711204636.542964-1-mark.cave-ayland@ilande.co.uk>
References: <20250711204636.542964-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:d1ff:478a:c096:2d0c
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 2/7] esp.c: improve comment in esp_transfer_data()
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


