Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93BBFE77188
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Dec 2024 14:18:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQofa-0008WA-Oi; Thu, 26 Dec 2024 09:16:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsogomonian@astralinux.ru>)
 id 1tQofX-0008VN-Lt; Thu, 26 Dec 2024 09:16:55 -0500
Received: from mail-gw02.astralinux.ru ([195.16.41.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsogomonian@astralinux.ru>)
 id 1tQofV-0007GU-JV; Thu, 26 Dec 2024 09:16:55 -0500
Received: from gca-msk-a-srv-ksmg02.astralinux.ru (localhost [127.0.0.1])
 by mail-gw02.astralinux.ru (Postfix) with ESMTP id 2983A1F46F;
 Thu, 26 Dec 2024 17:16:48 +0300 (MSK)
Received: from new-mail.astralinux.ru (gca-yc-ruca-srv-mail05.astralinux.ru
 [10.177.185.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mail-gw02.astralinux.ru (Postfix) with ESMTPS;
 Thu, 26 Dec 2024 17:16:46 +0300 (MSK)
Received: from rbta-msk-lt-328534.astralinux.ru (unknown [10.177.20.66])
 by new-mail.astralinux.ru (Postfix) with ESMTPA id 4YJrKV0vRmz1c0sM;
 Thu, 26 Dec 2024 17:16:45 +0300 (MSK)
From: Tigran Sogomonian <tsogomonian@astralinux.ru>
To: peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 sdl.qemu@linuxtesting.org
Cc: Tigran Sogomonian <tsogomonian@astralinux.ru>
Subject: [PATCH] hw/misc: cast nand_getio value to uint64_t
Date: Thu, 26 Dec 2024 17:16:26 +0300
Message-Id: <20241226141626.28722-1-tsogomonian@astralinux.ru>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: tsogomonian@astralinux.ru
X-KSMG-AntiSpam-Info: LuaCore: 49 0.3.49
 28b3b64a43732373258a371bd1554adb2caa23cb, {Tracking_internal2},
 {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1; new-mail.astralinux.ru:7.1.1;
 astralinux.ru:7.1.1, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 190076 [Dec 26 2024]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.7
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.0.7854,
 bases: 2024/12/26 12:50:00 #26919000
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 1
Received-SPF: pass client-ip=195.16.41.108;
 envelope-from=tsogomonian@astralinux.ru; helo=mail-gw02.astralinux.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

s->buswidth = nand_flash_ids[s->chip_id].width >> 3;
<= 16 >> 3 <= 2.
x <= s->ioaddr[offset] << (s->buswidth << 3)
<= max_uint8_t << 16
With x << 24 overflow is possible.
Other cases are similar.
Thus, need to cast return value to uint64_t.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Tigran Sogomonian <tsogomonian@astralinux.ru>
---
 hw/misc/omap_gpmc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/misc/omap_gpmc.c b/hw/misc/omap_gpmc.c
index 67158eb164..b0a48c71de 100644
--- a/hw/misc/omap_gpmc.c
+++ b/hw/misc/omap_gpmc.c
@@ -139,8 +139,8 @@ static uint64_t omap_nand_read(void *opaque, hwaddr addr,
         if (size == 2) {
             return v;
         }
-        v |= (nand_getio(f->dev) << 16);
-        v |= (nand_getio(f->dev) << 24);
+        v |= ((uint64_t)nand_getio(f->dev) << 16);
+        v |= ((uint64_t)nand_getio(f->dev) << 24);
         return v;
     case OMAP_GPMC_16BIT:
         v = nand_getio(f->dev);
@@ -151,7 +151,7 @@ static uint64_t omap_nand_read(void *opaque, hwaddr addr,
         if (size == 2) {
             return v;
         }
-        v |= (nand_getio(f->dev) << 16);
+        v |= ((uint64_t)nand_getio(f->dev) << 16);
         return v;
     default:
         abort();
-- 
2.30.2


