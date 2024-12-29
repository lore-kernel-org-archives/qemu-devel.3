Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B759E77191
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Dec 2024 07:36:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tRnim-0001CS-3a; Sun, 29 Dec 2024 02:28:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1tRniG-0007cB-AS
 for qemu-devel@nongnu.org; Sun, 29 Dec 2024 02:27:48 -0500
Received: from mail-ej1-f48.google.com ([209.85.218.48])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1tRniE-0002Wi-Sn
 for qemu-devel@nongnu.org; Sun, 29 Dec 2024 02:27:48 -0500
Received: by mail-ej1-f48.google.com with SMTP id
 a640c23a62f3a-aaf57c2e0beso23398366b.3
 for <qemu-devel@nongnu.org>; Sat, 28 Dec 2024 23:27:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735457265; x=1736062065;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6c+6XcbVtB2vqqzGJAKMAXsg3ZBXmuneXOWCq5giJbQ=;
 b=iuiybkpVPPCpXJpm1/7Vhru90Y3qknS62mjLauJjQv30imVSUF4R6ONItgrDwiF8gN
 BLD3t+27lpE26xyVUg46tBEUoaUt6DbX6FN4gjYsF7CxS0UfNHLAKeM2zn6fGG29l0/w
 9RFDJjL1ckEoqNuWwzrdZ33hkmhz398ZSDva0SYRc0VTDrKIohFwhOzYOkN+0okpvpEx
 Tj7mLSE8p/V4srlcLjbS4S56/OjtwCKxJqLRrEnfRMKBPD0txQvVsYqVGZKuMxiInsTa
 j7RNxkpIRvdu26oZt8HCSfWt5rIuzP4ClXRhoNu6u+Wo5LloPR2zjI+/vzQqLU7QcAka
 MuOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWf9i7+P6rv58hngO1H8ne5nRPqxht5Li38IB4kctGhish4nK2AzaMv9LjnZ9jeVH/iyCOAxgsvwsri@nongnu.org
X-Gm-Message-State: AOJu0Yy0N6PYSwcFs6SC8q9cM5W6JOizsaftMBPF5bJd1z/zndNGkUMq
 9qaJ52st4+RVfv5tv7GmWchaMs7dj+r16UqL2ikpx28eyxazh9je
X-Gm-Gg: ASbGncsAg1USwV38D7BaTr2cfQkAS0cf9mdSnNK/NkosZRMAkoTdXUau9VbCRS9a8ah
 +mL2LJI58vKj6IkGq4vfnwr3G47HpNcukJtZ68E+t1e5Ac1cdB9A/Lk4BaKt5C6hzxuic6troOH
 aW2M7GymOe9FwV/N/eyOqgaZaU1w0/fx3GAQP0MiOTSgid/P1QxHPu+9uRuio44XqGOxxB9RzFs
 kHE602eLm9mlk88o/0MhRZrowY5sSoUK1XHIS+QeeCfuRNZykTRBIJrFRexRt30iy8Np8bcthn2
 uLI=
X-Google-Smtp-Source: AGHT+IGJr0AUtJYDjZBp60jy2IDosGHIXjqTvumQEGwH1FwCtEVHYd56CHQRtEuPa62Fxx2th1ai4Q==
X-Received: by 2002:a17:906:4795:b0:aa6:ab70:4a78 with SMTP id
 a640c23a62f3a-aac3355ea10mr2438685666b.37.1735457265398; 
 Sat, 28 Dec 2024 23:27:45 -0800 (PST)
Received: from tpx1.. (ip-109-42-49-90.web.vodafone.de. [109.42.49.90])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aac0e895194sm1329218666b.70.2024.12.28.23.27.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Dec 2024 23:27:44 -0800 (PST)
From: Thomas Huth <huth@tuxfamily.org>
To: Stefan Hajnoczi <stefanha@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PULL 34/35] next-cube: rename old_scr2 and scr2_2 in
 next_scr2_rtc_update()
Date: Sun, 29 Dec 2024 08:25:25 +0100
Message-ID: <20241229072526.166555-35-huth@tuxfamily.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241229072526.166555-1-huth@tuxfamily.org>
References: <20241229072526.166555-1-huth@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.218.48; envelope-from=th.huth@gmail.com;
 helo=mail-ej1-f48.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.156, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Rename them to old_scr2_rtc and scr2_rtc to reflect that they contain the previous
and current values of the SCR2 RTC bits.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Thomas Huth <huth@tuxfamily.org>
Message-ID: <20241222130012.1013374-33-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Thomas Huth <huth@tuxfamily.org>
---
 hw/m68k/next-cube.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index 360a46c32e..513ce5844b 100644
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
2.47.1


