Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C363D2E029
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 09:02:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3XFE-0006IU-O1; Wed, 23 Oct 2024 05:01:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t3XFA-0005ut-KX
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 05:01:29 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t3XF0-0000gC-2n
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 05:01:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=3EbIROTZd4e52z2Z0DQSIJIiPTukBp63B6OrJktQ+WU=; b=G7/USuMSSXbx9HO71jGPDt6w74
 usVsimefUwf07buiMr6jnJBc5w8FKy/XSSYDR1rlgm/pt/hwSaSi3gFdQiKVUGYg6HR/j1kZJByJc
 NFax361luma3xsC8aUxdrnR9t7upZHZizG3znJxedMujkweEVFfpLegz0Kue36HlrhZk1aaVRhG0F
 wKfYh09MZXCpeDqL9g2wN6xJGbQautyTVgUwCzFhMXRkLCHIMAp6lb3LDwA0GTldxkCV3y7YHJMZ/
 1l+/qYNYG/poa3oolZp1ZasyxOAGOhU16o0d53GslC91GuSenh4POLaYF+aldBbp/TwX3YueppE0V
 JLNhlo/HASA0rOVeRRNoNW5DmyJgRyjQM1YMQFpJrcbKyXFuE/35W/fKaIRM2zVYc26sEoD3DsHud
 Sv925U8AZ3RenCypF8pKOHO82EtUXrCpGlfP+y3B81W+nQU1/PXHS7UglLAEHjKYJtpnYnmUmzpWg
 hbvz+9mnHd4W0lZMNLNrQvPyq8ezRW6DTQNb9HHByzb1DL3QGtZcf+XwLHuZNL7IY8cDfjRDV2geu
 mGobWPTKgcqCde1BttiVZQv4gmDxbtb9vipesIQNDHmaU+sdSKnyZb+hItfPVPeouuIVlln4zGiNr
 8PUmgGgTabcwXs0hRcuphAl9kq7fc7Alz3ZJ9FtyY=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t3XEZ-0008EL-N7; Wed, 23 Oct 2024 10:00:52 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: huth@tuxfamily.org,
	qemu-devel@nongnu.org
Date: Wed, 23 Oct 2024 09:58:50 +0100
Message-Id: <20241023085852.1061031-35-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241023085852.1061031-1-mark.cave-ayland@ilande.co.uk>
References: <20241023085852.1061031-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 34/36] next-cube: rename old_scr2 and scr2_2 in
 next_scr2_rtc_update()
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

Rename them to old_scr2_rtc and scr2_rtc to reflect that they contain the previous
and current values of the SCR2 RTC bits.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/m68k/next-cube.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index 076c9d1f3a..ece63f20b1 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -177,17 +177,17 @@ static void next_scr2_led_update(NeXTPC *s)
 
 static void next_scr2_rtc_update(NeXTPC *s)
 {
-    uint8_t old_scr2, scr2_2;
+    uint8_t old_scr2_rtc, scr2_rtc;
 
-    old_scr2 = extract32(s->old_scr2, 8, 8);
-    scr2_2 = extract32(s->scr2, 8, 8);
+    old_scr2_rtc = extract32(s->old_scr2, 8, 8);
+    scr2_rtc = extract32(s->scr2, 8, 8);
 
-    if (scr2_2 & 0x1) {
+    if (scr2_rtc & 0x1) {
         /* DPRINTF("RTC %x phase %i\n", scr2_2, rtc->phase); */
         /* If we are in going down clock... do something */
-        if (((old_scr2 & SCR2_RTCLK) != (scr2_2 & SCR2_RTCLK)) &&
-                ((scr2_2 & SCR2_RTCLK) == 0)) {
-            if (scr2_2 & SCR2_RTDATA) {
+        if (((old_scr2_rtc & SCR2_RTCLK) != (scr2_rtc & SCR2_RTCLK)) &&
+                ((scr2_rtc & SCR2_RTCLK) == 0)) {
+            if (scr2_rtc & SCR2_RTDATA) {
                 qemu_irq_raise(s->rtc_data_irq);
             } else {
                 qemu_irq_lower(s->rtc_data_irq);
-- 
2.39.5


