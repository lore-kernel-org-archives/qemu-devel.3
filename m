Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14B9CE7718D
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2024 13:11:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPLdF-0000a3-KP; Sun, 22 Dec 2024 08:04:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tPLbH-0006Tq-6W
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 08:02:32 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tPLbF-0000uo-SY
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 08:02:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=JRKGDsSvTWe9iQ6fgKPmc3U+zQ5yHiKGkjYUYYLHmtM=; b=vYrz+27Egn/+hQfQW8DNCACHAK
 /DLtTBCrddCD9jimsEi9wbJN/dmCkuFuwVneT6Y/HMDZj2G2FmelaXfOYoLbS4Jw8rh30NF8ONY8l
 Uy+cbW+xXLC5a7U9H+67+7m8Jre5PnPiM9+8Z9npuKcNwbU93ex8ISoUZ8h2c6533bDoeXkzfvZDV
 NObxh2oO4SPr0EmgyJGDGPLuu/Y/XWFPQoiLrCfhTdK+wHikdPUhq8+sgVeYotJwhUHz89NAbn3rc
 DXTZOtU8ReBNxWasGHEe7fmwtjwE4/qsXXpIB+U1sIkE+npczAVVNYtAOGPSuNO17H/CaPna7qhCP
 khCh/Mqcck+cB9I93QkyfrYPO9y+6rcE02cE9BXarQgeBmzh4c2rk05Cyvbp8v+WokW40WJ2l1RKy
 vHTe1BU7n0VH5xW26EGqTCYtm/7sVc78I2Q7GDUHYMT6GR22tbeAT6ouQsJnWDUnrNnsrYAxPSxXE
 +Epvr9VPuuEJZfR5Hz4d4vFXsksUkITl/c8v/9PKdbXHhpctMiiLeO5QVBhA5dfkvhydpA0fOIMtO
 IJ6cz46bfzR+ZaX7Rd1M8UUcDGW2f+/pgUMoe3//WZZj1e9yvDy351qf2u29yFEPw/eiUa7mgwy4W
 qG67aVyDZfs2xH0lpecvgFKs4jSgTgLgxuaBo9sWM=;
Received: from [2a02:8012:2f01:0:33a9:475d:1cd9:884]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tPLaS-0002L7-VJ; Sun, 22 Dec 2024 13:01:40 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: huth@tuxfamily.org,
	qemu-devel@nongnu.org
Date: Sun, 22 Dec 2024 13:00:11 +0000
Message-Id: <20241222130012.1013374-33-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241222130012.1013374-1-mark.cave-ayland@ilande.co.uk>
References: <20241222130012.1013374-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:33a9:475d:1cd9:884
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 32/33] next-cube: rename old_scr2 and scr2_2 in
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
Reviewed-by: Thomas Huth <huth@tuxfamily.org>
---
 hw/m68k/next-cube.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index cf64f982cc..2625839576 100644
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


