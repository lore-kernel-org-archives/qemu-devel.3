Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7228EE77180
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 11:49:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLhgM-0003ci-7E; Thu, 12 Dec 2024 06:48:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tLhg8-0002rB-DC
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 06:48:24 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tLhg7-0007OG-2S
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 06:48:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=yDUqbhK+yyZq/AEK/ZwrzDwySLUDyaRf+dqIeCdUbqs=; b=Cl8ipg880ZNrRcHr573vy6LglH
 NUtSxnsCmMGXrxipHR5wxAx6qp/ZVDigqcjthSfx6FMQSdO949EPTFvyukSLCLbbZaNc/MmJnx4Qc
 JeJAEGSIUJBgqwKIHump7L2SVwDzQHiPH2msNaYmpXmVIKQx+6NGrONWdJqonva3SiRfeWwHrA9h6
 1+aWCYke3KBPlnc3lTzG4xZKrWK11dLYPd67xTeprVL13Vmc2ZCQhe/A9DETe2v0nD6OJFBHrtFRf
 r34LLWnJTDVFG34JM8r+AXbzwE+yWlzVQiOeY8bHf2Mjz8YkwVZd624rczRreqMFRXsqeK63HjXDq
 K1TBM6zxFupRVkEGzIIFG0wHMWhYPRsT4Vr83EKfdIQOsqsQHTcO3ynN5ozf4R+FX1/tSF+Uxp6Ir
 6vN/7uU1hQsUYioPojyWb4bBrWSBwwJoqMj79WVAigO/NHZuA0+F5Q4mfbFGm/8AhfzCBHdOkhcSu
 reKJqtmIOi2DFDgf6SaJIOd7xBYwsYE/WrXdRds1KhKGKN0I/pcy5vIPxQNsgcR8mUq3KZNtAX84M
 G/hyKBaTvSov7TCzCNMIhavnXoezm8pEf7+3okecTNDh5S6v4IrHQA7Q8xn4fXEXI0ReNs3au10tN
 +pNQxXnhADfZnIEO4KErAqXpng8aai4t9y80LFHb0=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tLhfN-00070a-9U; Thu, 12 Dec 2024 11:47:41 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: huth@tuxfamily.org,
	qemu-devel@nongnu.org
Date: Thu, 12 Dec 2024 11:46:18 +0000
Message-Id: <20241212114620.549285-33-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241212114620.549285-1-mark.cave-ayland@ilande.co.uk>
References: <20241212114620.549285-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 32/34] next-cube: rename old_scr2 and scr2_2 in
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
index 12d31dfaad..7b0769c0d3 100644
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


