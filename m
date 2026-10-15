Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E293CC6B33
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 10:27:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHIfE-0002MU-NT; Thu, 15 Oct 2026 06:26:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xHIeg-0001hD-Hp
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:25:54 -0400
Received: from mail-wr1-f53.google.com ([209.85.221.53])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xHIec-0003nA-31
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:25:44 -0400
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-48bbb06e746so863464f8f.3
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 03:25:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792059939; x=1792664739;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=W5PhRPYjPeVIiLmDaG68Pb9QynlP1yOMDtzh8f0rn+Q=;
 b=ZNoLSB+FLD2t/NtRY7LGHil3jaCIic1mMS0HaR2AbHV1SNO4VCUb0wj1L+SnFB+7bT
 dPslLNKg5VlQwksPrxRsDseVdgfukDID6UbtRvNzqDWuIpNJBYbNq/NDxwHK9zXp6YA0
 MTGFZmiCgTsDQ5i41vhWxET6uo3zl65YeGcAQaQ1bsB3ivR3gMN4uuawwpAwCxc5Gla8
 vglggt6j6cyGfpxPol8x+1NuT9jjdMf2/p7XMyHc86IF0Q0W8On+FXX7geB2wFZ9/6E3
 zAf3pj8/JDymUT++fNwN4Xn4IhXAACFYRYQSCPl5HgQINt0aWWemr27SrLdht8cXeVd9
 ei7Q==
X-Gm-Message-State: AFq9FYKEGL5maGBtBcznqsbRruisj47dlAIpyFU+9doN0AHMzXPLkfZ6
 enbw2v6eqasEyGjel7GrvpwfTzMFyN7lAoE5DLOBMwJmgNcxEo8gzgS9mQmTIUwq
X-Gm-Gg: AYBFou3WrtUOSHpXyrvE4pBaKIOFvBh6DwSkxKtdtXYWgbZ6K89miclN2l5MqZtnKvo
 3mVDF1Af3y3j2VXeIUh1iEjw8Cg8snZO1D/IjYQTdPL/e4j1J4XBCzpOByfxxh3PrpYGkH/+d+M
 hm1o8RRHAzD8sfyWIV8Eab/hTkVQsDFuo4tFTU58bqP3nqsefHT7h1qC3EGp2FTtr4ranZUwWju
 llO4dy5FG1ZcNdPiRRbK0Rzysvds3jurKo0m4MmbgBGJRpUn3dgr6EUMxOd0EwWq154ZSV4Hkae
 6T8M9g8dgr6xcPcsYp4jcezxPaEoWLDGNyfmadp9JllSGay/bvWh87VZjLoQtRBgeU0plHEfeAM
 uoYegGNKr9npYWimwv/L02RSEJ+QbrJ0l37bYW8Y9UhCZG3iTJaWu/u3cm3RG6PgnyQYswB27RB
 Zw32Sv4Uv31ArW+Uk8e03m8STdHcHmTRxWKFeVE+xxrG4/yeSSIelwAUIYK/LTpTRUeFb7iWlIz
 TdOaT62MdImuhFPqVgNSVpk2TlZWKl29hXNu/3Nb/DtJw==
X-Received: by 2002:a05:6000:4694:b0:48c:67d8:abd1 with SMTP id
 ffacd0b85a97d-48dba9be288mr25519734f8f.13.1792059939384; 
 Thu, 15 Oct 2026 03:25:39 -0700 (PDT)
Received: from localhost (89-93-216-19.hfc.dyn.abo.bbox.fr. [89.93.216.19])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de0967affsm16109509f8f.1.2026.10.15.03.25.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 03:25:38 -0700 (PDT)
Date: Thu, 15 Oct 2026 11:28:01 +0200
Subject: [PATCH v3 14/50] hw/rtc: ds1338: implement the DS1338 clock-halt bit
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-bmc-minerva-v3-14-7d50c8a108e5@free.fr>
References: <20261015-bmc-minerva-v3-0-7d50c8a108e5@free.fr>
In-Reply-To: <20261015-bmc-minerva-v3-0-7d50c8a108e5@free.fr>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792056475; l=4398;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=Kzt6qfQ8xw5u2qhWKCAbs8upbxPA4Z4PtksNYulDrzo=;
 b=zIeN5UVvq13Nz2bsi2czZzqePs3GsxgGsdMwKogSUbKN2sAf7mp21XbHwLdmaLu+l9l+DVJSl
 xNaVjnGC9L9ARGqYeN1dsKxLbY7Cul0qUuzYJnF8SlYXRl8YE3WF57Z
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.221.53; envelope-from=eblot.ml@gmail.com;
 helo=mail-wr1-f53.google.com
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


