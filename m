Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46217606A326
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 08:58:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOtHI-0003E3-CJ; Thu, 05 Nov 2026 03:57:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xOtHG-0003DU-Sj
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 03:56:58 -0500
Received: from mail-dy1-f182.google.com ([74.125.82.182])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xOtHF-0003bz-3f
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 03:56:58 -0500
Received: by mail-dy1-f182.google.com with SMTP id
 5a478bee46e88-33fb4680717so2930040eec.1
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 00:56:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793869015; x=1794473815;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/7vqyfsfQSXKfw69CwuMNDomx2TM2p1e+fdBs9WDTis=;
 b=Q5qQyFgrg2CYDeKTvwtBRbBHsc+fKbHwLGJ7gZ6M2G1bI0GqcKL2JEkZJWLFt2JUG3
 1WU95Wu20EGOu3SfEm1YMCGSVTEDuhfjEJ5dEe/AqQuBayo8tr33iWLKKbmrU9AMVM28
 mgvQuIWAIW+E8a5PCVc4rCjwWFlzK3oSREGSRsysoq4d0KMt2zbhWDACqXHLywLn8MlS
 GvCAdhUGSwks214faZTmyAErldEBqBl/Xgjg44T5VXAoHFWJsYIq2JfmPezM5Aw5yjTY
 K78JyNMxfahZqf0WWrL/A3uTmhYmPxe1LK1whKVYhwjsrooYTnqTgCOkuiC8Z+CUGAGf
 8r8Q==
X-Gm-Message-State: APuU4Z+clZKwMxHTfb2LQB9FQIdCW2WGNvJR7gobC6teue7nMx/3ZucM
 d+W9dMIFiigvQfacfkqm6jFCXUpTR6oykBHbwhWDCPZHmZ4/AfkpLSTjxQQIEe8Qkq8=
X-Gm-Gg: AYBFou1zUQ24rYSPTinTbjtYMOs68f7X87exECsaxQMOo4SnfgKjysxHWHB60RcvlLk
 d/zAU0DOD7/OjpHw9Ia+OiZmF33YlvbTTAcUwKGBswlF+IRjbfpXOhkb5rdsdfKV90Cn4ZxUDJA
 GTneVczQBLcJvNvgXmtsYYF6nt2vztA0j5f+REQHpLB8IfyicB2VFlps1xN5WXNwklrspXqHKaT
 a7s8UIrQFnGxsjI7rwKxjJFoEwjU5K7kbJRhzLqa2lvlCh+L0bSpno1RrPTiMj3cS1AdwlHEsuU
 r9b9rQDS3DfE9flHnLaZoD/TpV9h3Nx/MQPUs+/FAZrk/4UJNBf75yadvlFk20z4s4nVCTpQHEd
 mqLYuVrjNNvGlu22MbA0i8xETVU/2LGHlbd+8ts8oifje+/DvpvRCN1/2WQMfw8NDfp+/p9Bio+
 BOylNS1seoz2MrBN7MUXiZ7ozmNqdgtvHTAsObg6zGxoQslKAfA+YbkZYU+8htKqlh0VBaFQjEL
 Tp4lWFORtFrwq7C9Oa/KQNFC7C2qUWtvKROJrR10IpfjbovxjbHnfhbL4UcMfH3PPtS6ekpa3si
 r+vMRWRvUvp/gzElZ1B7pzqbMmcuU9vqF8m9BX7CKLxpx+WiDjLpBgCzVWgKcvsZh+RK2+9VmlK
 g3UE2yQ==
X-Received: by 2002:a05:7300:cc9e:b0:36e:c01b:2e7c with SMTP id
 5a478bee46e88-36ec01b30d3mr356272eec.6.1793869014982; 
 Thu, 05 Nov 2026 00:56:54 -0800 (PST)
Received: from localhost (118-163-122-149.hinet-ip.hinet.net.
 [118.163.122.149]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36ca3785430sm20796681eec.3.2026.11.05.00.56.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 00:56:54 -0800 (PST)
Date: Thu, 05 Nov 2026 16:50:37 +0800
Subject: [PATCH 01/19] hw/rtc: ds1338: program the clock from the time
 registers
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-rtc-ds1339-v1-1-50a8dc463ee8@free.fr>
References: <20261105-rtc-ds1339-v1-0-50a8dc463ee8@free.fr>
In-Reply-To: <20261105-rtc-ds1339-v1-0-50a8dc463ee8@free.fr>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, eblot@meta.com, 
 Emmanuel Blot <emmanuel.blot@free.fr>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793868639; l=6068;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=uej/UOj+V/lpxWjtnR1AN5iwpDxP7F3nxb3Qip3BUmg=;
 b=W3ycztXUaDdqSbDXU5XN5lZGQGuKCp0ZqX9qS3X16uF2dScitCQNn4rHBhK+CVUBnpHOEBidT
 vCurS/8l4SVBAZM90Lpp96MPvFKcOlmPjE4U1bAp0udOL4FArQcO996
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=74.125.82.182; envelope-from=eblot.ml@gmail.com;
 helo=mail-dy1-f182.google.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Emmanuel Blot <emmanuel.blot@free.fr>
From:  Emmanuel Blot via qemu development <qemu-devel@nongnu.org>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
2.53.0-Meta


