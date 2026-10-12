Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03CFFCA9ED1
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 15:06:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGHb3-0006Lm-Hp; Mon, 12 Oct 2026 11:05:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xGHb2-0006Kp-4f
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 11:05:48 -0400
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xGHaz-0006sd-PB
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 11:05:47 -0400
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4a140e7405dso23466425e9.3
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 08:05:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791817544; x=1792422344;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yBWuUC9nCHI6TiTYFhtomTYUcrNr6zcNAyZPSG6aMfs=;
 b=WN6MOVIcqb6HMa0DZgfFovuPc3OWBaUfLx5dvupOadPL3xIrLgpTVKbEaFI5EHmbM9
 9y8woGRpUzbIr6ww64Omk2cnR2v+h0QQcVM9rNWINAkt9MLH+zhmDpJC2W6RUibTLhnX
 Ni84oj3mXBcN9MIRdOySanN5k4Hyg27iNubDQsdqXk75XQgxWIMv0IlqricC/i65KbfK
 ZPDAxJRIc/rcwgpx3yQC6GbPFksFEmZUMjTMvhVdPMRLCqrAShyYxXKXJUPH0rouU2AD
 k17i8zekUIelcR7va+B95Zu+xsT/sOld1hg25B3s9eKbh4woLSmt1z79PVCSLPVkS/lb
 apYg==
X-Gm-Message-State: AFq9FYKAtqMqPyZCaxTLLXZOgG5nacDucUzYsLp2pSkJ+5hsLAJkd1v1
 DoL9s1RiIK1QONd9Y+fyKJ2Fz6lvDb8ClYLgfKinTjlLxAaEN1BmIpX3Jl9wFkZL
X-Gm-Gg: AYBFou2GutWnhcUzDDcUIJGDokVo5Ji+eT5tIz1fsJ4muwn6Elg2KFOr+XLLEoeivuh
 ws5FlBGHlW3VuCxIG0x0f7gXQjLtO5FjtY+bYfHjl67VdqYPyrCblOsu4YwpJcD3ndjcARD/lo5
 fgTSCrJGkf+49tVozRbExyvFak6LgX+tHybiWdpFT+5gVc0AkrH1fFsd9Wr11IUvQ0Re/bSn2XD
 Lg8YONvYlLWTof8e7mZF9T3ZlkEQgSepZmCRtfLexYzFBxRoGP8UU9ZOr8gxYeJdkoacGNpP+Vi
 WtOHxVWtkHNvPo/4kFr2SCkFis5PYT3ZNNd3DEp71T6PMefPzYUZ0b/saL9BI/wiGkbClSCfxMc
 4/T5XCPjrbHVPonG5rQc0nPzobxJKenrhPchtzGPWH2ghs6dqkIy4bnVsJlUjohznkJwvlEF/Y5
 PsjED1R0X7B3HQH+SObMHoXqkRWj7jbEvGmM6fjWxWJAy1lp4K92EPuW53SKRBrhM3+3W5bSgTZ
 SWRULeDaEcJ2ldaSJ01g6HXwj+a1U7oajC24nOPKJm9jpc=
X-Received: by 2002:a05:600c:8216:b0:49d:34:420d with SMTP id
 5b1f17b1804b1-4a18e4b0465mr189633135e9.20.1791817544008; 
 Mon, 12 Oct 2026 08:05:44 -0700 (PDT)
Received: from localhost (89-93-216-19.hfc.dyn.abo.bbox.fr. [89.93.216.19])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48db9adeacdsm19780958f8f.55.2026.10.12.08.05.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 08:05:43 -0700 (PDT)
Date: Mon, 12 Oct 2026 16:32:06 +0200
Subject: [PATCH v2 13/50] hw/rtc: ds1338: program the clock from the time
 registers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-bmc-minerva-v2-13-4c3dff084ec9@free.fr>
References: <20261012-bmc-minerva-v2-0-4c3dff084ec9@free.fr>
In-Reply-To: <20261012-bmc-minerva-v2-0-4c3dff084ec9@free.fr>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-arm@nongnu.org, 
 Patrick Leis <venture@google.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Emmanuel Blot <emmanuel.blot@free.fr>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791815520; l=6063;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=94bqjrDMcc1+WPuTzltyln162tXTYcpioUu3J7GfTG8=;
 b=Ab8IyJ+26HOnO/VQvMmxjXe8L1DGO1Wfug/tXwVZZ70AYbgAuUGxzSBGPKyQ6W6DALFdKz66P
 12uQXxQ9mWFC/kUqvuSo445HrqvidWeiC3ua4fwJ6Gxs0F9heSsXhcx
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.128.52; envelope-from=eblot.ml@gmail.com;
 helo=mail-wm1-f52.google.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Emmanuel Blot <emmanuel.blot@free.fr>
From:  Emmanuel Blot via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

A write to a time register rebuilt a struct tm from the current date,
substituted the field being written and folded the result back into
the offset. Every byte of a multi-byte transfer was therefore
normalised against the fields the guest had not written yet: a date of
31 programmed while the month register still held a 30-day month moved
the clock into the following month.

Keep the written value in the register file and derive the offset from
the file as a whole. This needs the registers refreshed on a
START_SEND, as the hardware does on any START.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 hw/rtc/ds1338.c | 116 ++++++++++++++++++++++++++++++--------------------------
 1 file changed, 63 insertions(+), 53 deletions(-)

diff --git a/hw/rtc/ds1338.c b/hw/rtc/ds1338.c
index 7eaa663113..862e03bd32 100644
--- a/hw/rtc/ds1338.c
+++ b/hw/rtc/ds1338.c
@@ -8,6 +8,12 @@
  *
  * Contributions after 2012-01-13 are licensed under the terms of the
  * GNU GPL, version 2 or (at your option) any later version.
+ *
+ * Limitations:
+ * - Writing the seconds register does not reset the internal countdown chain,
+ *   so the sub-second phase of the clock is not modelled.
+ * - Leap years follow the Gregorian rule, where the parts stop at 2100: they
+ *   derive the leap year from the two-digit year alone.
  */
 
 #include "qemu/osdep.h"
@@ -75,6 +81,41 @@ static const VMStateDescription vmstate_ds1338 = {
     }
 };
 
+/* Reconstruct a struct tm from the BCD time registers in nvram. */
+static void ds1338_time_from_regs(DS1338State *s, struct tm *now)
+{
+    qemu_get_timedate(now, s->offset);
+    now->tm_sec = from_bcd(s->nvram[0] & 0x7f);
+    now->tm_min = from_bcd(s->nvram[1] & 0x7f);
+    if (s->nvram[2] & HOURS_12) {
+        int tmp = from_bcd(s->nvram[2] & (HOURS_PM - 1));
+        if (s->nvram[2] & HOURS_PM) {
+            tmp += 12;
+        }
+        if (tmp % 12 == 0) {
+            tmp -= 12;
+        }
+        now->tm_hour = tmp;
+    } else {
+        now->tm_hour = from_bcd(s->nvram[2] & (HOURS_12 - 1));
+    }
+    now->tm_mday = from_bcd(s->nvram[4] & 0x3f);
+    now->tm_mon = from_bcd(s->nvram[5] & 0x1f) - 1;
+    now->tm_year = from_bcd(s->nvram[6]) + 100;
+}
+
+static void ds1338_resync_from_regs(DS1338State *s)
+{
+    struct tm now;
+    int user_wday;
+
+    ds1338_time_from_regs(s, &now);
+    s->offset = qemu_timedate_diff(&now);
+    qemu_get_timedate(&now, s->offset);
+    user_wday = (s->nvram[3] & 7) - 1;
+    s->wday_offset = (user_wday - now.tm_wday + 7) % 7;
+}
+
 static void ds1338_capture_current_time(DS1338State *s)
 {
     /* Capture the current time into the secondary registers
@@ -123,16 +164,16 @@ static int ds1338_event(I2CSlave *i2c, enum i2c_event event)
     DS1338State *s = DS1338(i2c);
 
     switch (event) {
-    case I2C_START_RECV:
-        /* In h/w, capture happens on any START condition, not just a
-         * START_RECV, but there is no need to actually capture on
-         * START_SEND, because the guest can't get at that data
-         * without going through a START_RECV which would overwrite it.
-         */
-        ds1338_capture_current_time(s);
-        break;
     case I2C_START_SEND:
         s->addr_byte = true;
+        /* fall through */
+    case I2C_START_RECV:
+        /*
+         * In h/w the time is transferred to the user registers on any START
+         * condition, so a write modifies the running time rather than
+         * whatever the last read left behind.
+         */
+        ds1338_capture_current_time(s);
         break;
     default:
         break;
@@ -167,51 +208,20 @@ static int ds1338_send(I2CSlave *i2c, uint8_t data)
         return 0;
     }
     if (s->ptr < 7) {
-        /* Time register. */
-        struct tm now;
-        qemu_get_timedate(&now, s->offset);
-        switch(s->ptr) {
-        case 0:
-            /* TODO: Implement CH (stop) bit.  */
-            now.tm_sec = from_bcd(data & 0x7f);
-            break;
-        case 1:
-            now.tm_min = from_bcd(data & 0x7f);
-            break;
-        case 2:
-            if (data & HOURS_12) {
-                int tmp = from_bcd(data & (HOURS_PM - 1));
-                if (data & HOURS_PM) {
-                    tmp += 12;
-                }
-                if (tmp % 12 == 0) {
-                    tmp -= 12;
-                }
-                now.tm_hour = tmp;
-            } else {
-                now.tm_hour = from_bcd(data & (HOURS_12 - 1));
-            }
-            break;
-        case 3:
-            {
-                /* The day field is supposed to contain a value in
-                   the range 1-7. Otherwise behavior is undefined.
-                 */
-                int user_wday = (data & 7) - 1;
-                s->wday_offset = (user_wday - now.tm_wday + 7) % 7;
-            }
-            break;
-        case 4:
-            now.tm_mday = from_bcd(data & 0x3f);
-            break;
-        case 5:
-            now.tm_mon = from_bcd(data & 0x1f) - 1;
-            break;
-        case 6:
-            now.tm_year = from_bcd(data) + 100;
-            break;
-        }
-        s->offset = qemu_timedate_diff(&now);
+        /*
+         * Time register. The write lands in the register file and the clock
+         * is then rebuilt from it as a whole: a transfer that programs the
+         * date before the month it belongs to must not be normalised away
+         * against the month still held from the previous date.
+         *
+         * TODO: Implement CH (stop) bit.
+         */
+        static const uint8_t valid[7] = {
+            0x7f, 0x7f, 0x7f, 0x07, 0x3f, 0x1f, 0xff
+        };
+
+        s->nvram[s->ptr] = data & valid[s->ptr];
+        ds1338_resync_from_regs(s);
     } else {
         if (s->ptr == k->ctrl_addr) {
             /* Control register: reserved bits read back as zero. */

-- 
2.50.1


