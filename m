Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56871606A326
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 08:57:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOtHS-0003Et-Bt; Thu, 05 Nov 2026 03:57:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xOtHP-0003Ed-RC
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 03:57:08 -0500
Received: from mail-dl1-f51.google.com ([74.125.82.51])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xOtHM-0003ct-Vs
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 03:57:07 -0500
Received: by mail-dl1-f51.google.com with SMTP id
 a92af1059eb24-1adbf62dd31so2256757c88.0
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 00:57:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793869023; x=1794473823;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=W5PhRPYjPeVIiLmDaG68Pb9QynlP1yOMDtzh8f0rn+Q=;
 b=F8upNVt6goXfFXABenLOv99jC7ko6geev8EMYyU8gVHay9ZGEOTc9iTVXL0XkD1A0v
 MCrvlRQtjAa7yfE9CP4jIPH3cuZM9YuA5EpCjwLIsezIm5p2ZMd80oI6gpWapMv2wnVY
 BgDXoQNr6vhHl+Rg8Te7yewRkoWXgsKUAgAAJuFKLQXN8vInewzvb1HdsnhKxdMwruly
 YK9Ca6sr63AJq10KUwzvXoLUaslcFnnlhdWo5HrRFZLx1pkurtkAwqD1dcnfOAQY950O
 mqfwf4Y/zRwBY0OjzsLe4UKdrjED+fEqZ/Q+ye6q3LeNie/Q0xuAbA6N1YTkPSdAayEl
 +lpQ==
X-Gm-Message-State: APuU4Z+IvE6m7vdWRjH4BXU/k5+A9w23TzCLEe642joHYn7o4NolZUrv
 nK+Uy/fg2ijbf2D+NB53clbAshT2IjCy6EFSKVSWcwPDISXA9AHXNWWeMX0mqJFpzdE=
X-Gm-Gg: AYBFou3xGrXxpNGg/pC2qhtGsH8404Bfg7ZtP5T+ZrZpQfbWQ6MRP/QxCxTEmPNeZmD
 MFFX5BPT691nQXdNdmadGYCaB6B4ptL8Ru6ardE8HPseO+KwLR6qHaxwwTTZiBnwcvCUb4949P0
 vsYslZl6FhjUQIR7iay8PhjxVAB5+wez8AKglYOji7o68VSkdAGH7Ft/sBoDrS2IwKy0tKAGm13
 gvqfVfEQgo3s+TgN7Vg4Sd7fQCdjcYtr4pOuDE21mb1Dmo9gqU4HQK0CEOixcVKDHI8D6HIibRq
 qnur4BGlcS2T+nS4M+FL8Ec+wVakRpJknmhrhjbBbRYAfgs1fB9VJUb0WZiWeqKfKcQcJStofOf
 9MDp+eGUB9xPdJqWIw7+roWIfeA7djCKvVnE0fwzI932obc2I3jXOVGSLCcEXw9lylTvuQxfkRZ
 4aDoHb+ZGcSkXZ8R6WOUpHgtiJ5cgjLnEyGd9JzNK6sO25nJxc2v0Dl2KzyWg24u6OLj8vqGtdp
 HoQ3DPkAMv3TZXVqqcFh1F77CfQhBIRYf5dXGFJt5DXbTpi82WriyfhY2J9EiE8wCVERSn0mfa7
 FZiYQgWEmu6KIw+4fYapk9Zgwu8aWC9NuovmOzPCKUe5uDkZ6pFKaXMTj4rowhLYWwkhp2NPznx
 uHvl0Cg==
X-Received: by 2002:a05:701b:464d:b0:1b2:3497:5998 with SMTP id
 a92af1059eb24-1b2349759cfmr14192551c88.36.1793869022715; 
 Thu, 05 Nov 2026 00:57:02 -0800 (PST)
Received: from localhost (118-163-122-149.hinet-ip.hinet.net.
 [118.163.122.149]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b245c69c3fsm14372246c88.20.2026.11.05.00.57.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 00:57:02 -0800 (PST)
Date: Thu, 05 Nov 2026 16:50:38 +0800
Subject: [PATCH 02/19] hw/rtc: ds1338: implement the DS1338 clock-halt bit
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-rtc-ds1339-v1-2-50a8dc463ee8@free.fr>
References: <20261105-rtc-ds1339-v1-0-50a8dc463ee8@free.fr>
In-Reply-To: <20261105-rtc-ds1339-v1-0-50a8dc463ee8@free.fr>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, eblot@meta.com, 
 Emmanuel Blot <emmanuel.blot@free.fr>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793868639; l=4398;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=Kzt6qfQ8xw5u2qhWKCAbs8upbxPA4Z4PtksNYulDrzo=;
 b=D6bt+csvS76ioaeBh+q8lcfldQbu0J2Z4fQPbP4aMkA6pxXARfKRsyxtq11Kb71lfxMqQNUvt
 /39SvxXYuD9CL9WgKjjY5rFuxN9gDU2XLDcUpViU740q4u4lYThsBAi
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=74.125.82.51; envelope-from=eblot.ml@gmail.com;
 helo=mail-dl1-f51.google.com
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

Bit 7 of the seconds register disables the oscillator, and the guest is
expected to clear it before trusting the time. The bit was masked away
on every write, so it always read back zero and the clock never
stopped.

The reset value stays clear rather than set as on real hardware,
keeping the model's convention that the clock comes up running and
synchronised with the host.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 hw/rtc/ds1338.c | 36 +++++++++++++++++++++++++++++++-----
 1 file changed, 31 insertions(+), 5 deletions(-)

diff --git a/hw/rtc/ds1338.c b/hw/rtc/ds1338.c
index 862e03bd32..79bcff4599 100644
--- a/hw/rtc/ds1338.c
+++ b/hw/rtc/ds1338.c
@@ -14,6 +14,7 @@
  *   so the sub-second phase of the clock is not modelled.
  * - Leap years follow the Gregorian rule, where the parts stop at 2100: they
  *   derive the leap year from the two-digit year alone.
+ * - The model comes up with the clock running; real hardware comes up halted.
  */
 
 #include "qemu/osdep.h"
@@ -53,6 +54,7 @@ struct DS1338State {
     uint8_t nvram[NVRAM_SIZE];
     int32_t ptr;
     bool addr_byte;
+    bool osc_stopped;   /* oscillator halted: time is frozen */
 };
 
 struct DS1338Class {
@@ -64,11 +66,12 @@ struct DS1338Class {
     uint8_t osf_addr;       /* register holding the OSF flag */
     uint8_t osf_mask;       /* OSF bit within osf_addr */
     uint8_t ctrl_reset;     /* control-register power-on value */
+    uint8_t ch_mask;        /* Clock-halt bit in the seconds reg */
 };
 
 static const VMStateDescription vmstate_ds1338 = {
     .name = "ds1338",
-    .version_id = 2,
+    .version_id = 3,
     .minimum_version_id = 1,
     .fields = (const VMStateField[]) {
         VMSTATE_I2C_SLAVE(parent_obj, DS1338State),
@@ -77,6 +80,7 @@ static const VMStateDescription vmstate_ds1338 = {
         VMSTATE_UINT8_ARRAY(nvram, DS1338State, NVRAM_SIZE),
         VMSTATE_INT32(ptr, DS1338State),
         VMSTATE_BOOL(addr_byte, DS1338State),
+        VMSTATE_BOOL_V(osc_stopped, DS1338State, 3),
         VMSTATE_END_OF_LIST()
     }
 };
@@ -122,6 +126,11 @@ static void ds1338_capture_current_time(DS1338State *s)
      * which will be actually read by the data transfer operation.
      */
     struct tm now;
+
+    if (s->osc_stopped) {
+        return;
+    }
+
     qemu_get_timedate(&now, s->offset);
     s->nvram[0] = to_bcd(now.tm_sec);
     s->nvram[1] = to_bcd(now.tm_min);
@@ -213,15 +222,30 @@ static int ds1338_send(I2CSlave *i2c, uint8_t data)
          * is then rebuilt from it as a whole: a transfer that programs the
          * date before the month it belongs to must not be normalised away
          * against the month still held from the previous date.
-         *
-         * TODO: Implement CH (stop) bit.
          */
         static const uint8_t valid[7] = {
             0x7f, 0x7f, 0x7f, 0x07, 0x3f, 0x1f, 0xff
         };
+        uint8_t mask = valid[s->ptr];
+        bool halt = s->osc_stopped;
 
-        s->nvram[s->ptr] = data & valid[s->ptr];
-        ds1338_resync_from_regs(s);
+        if (s->ptr == 0) {
+            mask |= k->ch_mask;
+            if (k->ch_mask) {
+                halt = data & k->ch_mask;
+            }
+        }
+
+        if (halt && !s->osc_stopped) {
+            /* CH set: freeze the counters before the register is stored. */
+            ds1338_capture_current_time(s);
+            s->nvram[k->osf_addr] |= k->osf_mask;
+        }
+        s->nvram[s->ptr] = data & mask;
+        s->osc_stopped = halt;
+        if (!halt) {
+            ds1338_resync_from_regs(s);
+        }
     } else {
         if (s->ptr == k->ctrl_addr) {
             /* Control register: reserved bits read back as zero. */
@@ -253,6 +277,7 @@ static void ds1338_reset_hold(Object *obj, ResetType type)
     s->nvram[k->ctrl_addr] = k->ctrl_reset;
     s->ptr = 0;
     s->addr_byte = false;
+    s->osc_stopped = false;
 }
 
 static void ds1338_class_init(ObjectClass *klass, const void *data)
@@ -275,6 +300,7 @@ static void ds1338_class_init(ObjectClass *klass, const void *data)
     dsc->osf_addr   = DS1338_CONTROL;
     dsc->osf_mask   = CTRL_OSF;
     dsc->ctrl_reset = DS1338_CTRL_RESET;
+    dsc->ch_mask = SECONDS_CH;
 }
 
 static const TypeInfo ds1338_types[] = {

-- 
2.53.0-Meta


