Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A4A8CC6B3A
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 15:12:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHN6V-0005n8-BZ; Thu, 15 Oct 2026 11:10:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xHN6T-0005mb-K8
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 11:10:45 -0400
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xHN6R-0001gP-HJ
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 11:10:45 -0400
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4a1880e1bf1so20493715e9.1
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 08:10:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792077042; x=1792681842;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AXWD4+zwD5+znWTjB90+sqSvptsRhK2GKfreGaEa0pg=;
 b=OxKv4uba7FeSvu/dgDX3NHZxICDRB+/G8KNg6Chm2xkrt1Wz6llqNnGu8EQ4aMVeeO
 Wv0rThyI6mpFdthepKY4K4zDwZjAj5UDbfMoMdNle94PZ2XrTGghM9JSr4M25rR2fkEI
 /pjAc1Iyh5wQt0g7ZQ/+hHHz+sLs/w1OkjSKXaTktIPCUeD4MLb1Ow97YATOV/SOwboK
 4vuujMEMr7WLeIllayxxYyG1yyVg9hcisjsOrS/eCAr3D2AP8cElvmnVnWccz55Cpopz
 nTM8inxVk0EQdRZxYjmjkqI3DMFMEt8cvi3SdZn2vjLpg1sh/yAGvoPX5KuiX5ay14tp
 pKtw==
X-Gm-Message-State: AFq9FYK76VWnOfj6FQUqtohydkHniIffpJ3HuEqCeE8gKTJ7AW4I7NXw
 e32lziQ0moIHiiiv7B9KROOcksT4wU5j0fooJoN1lepELsBhPtexvg9lG0Q9AQ==
X-Gm-Gg: AYBFou2vx7rrMLVClHz6Mi39XW/H/YDz4VZNo1STPBe2ZP5oO83VAtPc4HKTdSJ2Pxs
 aCDmYesLyQ4jfOMnnR6mXo0Q7XexzP6e2HZb1PJDcoFkNz2IuPzT5slMT1DJpgWsIedYE49F+7O
 qEoNtzJoT+RKT+5b+8wZvLPYEaQkJe/7AEGMgnb7dp/4Wh9C/Q57XCKReOdC5zPZxRDcMKcFCax
 yxA6/81gtA78CrpZn8p3mXhvdNhj5E83OHHRoNJcuYqA1oD7p0Up8VyI8FX+Fqg1+NrUZecOFiN
 CiAjgyi2OCHJsp+YL7Tm8i9GiGdm/wRKav5jKPsWYAPXilHmBVu67VNU1jhjgYiPISYJ7u69PwP
 VO2TYGLzbonrxWWD0IyQX6WzY5VFzM40e2OvwwsbgeMnrH9vZLYOcZ3QIedxDVATZ0lXVMXizw6
 vp+fRClOVq9WEHZ+GV4bBdxsb3fo/elXHDEjS1QIueGUeGWiX5fPwZIfbOdhrFBLdxnlA5qpdDD
 Ka2Jrw2dnFS48V48riqzLYi7Rllr5MtADihsu7ft9BDvw==
X-Received: by 2002:a05:600c:e549:20b0:4a1:9438:719e with SMTP id
 5b1f17b1804b1-4a1943872ecmr225766815e9.9.1792077041969; 
 Thu, 15 Oct 2026 08:10:41 -0700 (PDT)
Received: from localhost (89-93-216-19.hfc.dyn.abo.bbox.fr. [89.93.216.19])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1bdbb4a30sm74559955e9.15.2026.10.15.08.10.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 08:10:35 -0700 (PDT)
Date: Thu, 15 Oct 2026 13:57:44 +0200
Subject: [PATCH 06/22] hw/sensor: tmp421: implement register write masks,
 one-shot and N-factor
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-bmc-clemente-v1-6-bf591886b5b6@free.fr>
References: <20261015-bmc-clemente-v1-0-bf591886b5b6@free.fr>
In-Reply-To: <20261015-bmc-clemente-v1-0-bf591886b5b6@free.fr>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 qemu-arm@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Emmanuel Blot <emmanuel.blot@free.fr>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792065465; l=5041;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=cin5ptKk8HcvGgeoKuQLp36sHnFJYgrk5/pmB0x+vAw=;
 b=QVwfojw1gxHqFWDhmpboOeQ8XeQotUnSJWdU1soj9tRyGgP8yR88CckaOWS9vd63aY3K2anfT
 9/LII9Zitq+AP137nHCV0UN+LUGkrRX7vG1Q5rFOUkVUw5CGOO6+l46
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.128.51; envelope-from=eblot.ml@gmail.com;
 helo=mail-wm1-f51.google.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
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

Mask out reserved and absent-channel bits on writes to the two
configuration registers and the conversion rate, accept the one-shot
trigger, and back the per-remote-channel N-factor correction registers
with real storage. The N-factor state migrates through an optional
subsection.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 hw/sensor/tmp421.c | 65 +++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 60 insertions(+), 5 deletions(-)

diff --git a/hw/sensor/tmp421.c b/hw/sensor/tmp421.c
index 8bacd7d05e..9e1249afb8 100644
--- a/hw/sensor/tmp421.c
+++ b/hw/sensor/tmp421.c
@@ -22,6 +22,16 @@
  *
  * You should have received a copy of the GNU General Public License along
  * with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ * Limitations:
+ * - Conversions are instantaneous. The conversion-rate register and the
+ *   shutdown bit are stored but do not decide when a measurement appears,
+ *   and a one-shot write is accepted without scheduling anything: a read
+ *   always returns a fresh value.
+ * - The N-factor correction registers are stored and never applied. The model
+ *   has no ideality factor to correct for.
+ * - The sensor-fault OPEN bit and the PVLD bit of the temperature low byte are
+ *   never set, so neither an open circuit nor a low supply is reported.
  */
 
 #include "qemu/osdep.h"
@@ -44,6 +54,7 @@ struct TMP421State {
     /*< public >*/
 
     int16_t temperature[4];
+    uint8_t n_correct[3];   /* remote channels only */
 
     uint8_t status;
     uint8_t config[2];
@@ -85,6 +96,8 @@ OBJECT_DECLARE_TYPE(TMP421State, TMP421Class, TMP421)
 #define TMP421_CONVERSION_RATE_REG      0x0B
 #define TMP421_ONE_SHOT                 0x0F
 
+#define TMP421_N_CORRECT                0x21
+
 #define TMP421_RESET                    0xFC
 #define TMP421_MANUFACTURER_ID_REG      0xFE
 #define TMP421_DEVICE_ID_REG            0xFF
@@ -203,6 +216,11 @@ static void tmp421_read(TMP421State *s)
         s->buf[s->len++] = tmp421_temp_low(s, s->pointer - TMP421_TEMP_LSB0);
         return;
     }
+    if (s->pointer >= TMP421_N_CORRECT && s->pointer < TMP421_N_CORRECT + 3) {
+        unsigned idx = s->pointer - TMP421_N_CORRECT;
+        s->buf[s->len++] = idx + 1 < sc->nchannels ? s->n_correct[idx] : 0;
+        return;
+    }
 
     switch (s->pointer) {
     case TMP421_MANUFACTURER_ID_REG:
@@ -233,15 +251,29 @@ static void tmp421_reset(TMP421State *s);
 
 static void tmp421_write(TMP421State *s)
 {
+    TMP421Class *sc = TMP421_GET_CLASS(s);
+
+    if (s->pointer >= TMP421_N_CORRECT && s->pointer < TMP421_N_CORRECT + 3) {
+        unsigned idx = s->pointer - TMP421_N_CORRECT;
+        if (idx + 1 < sc->nchannels) {
+            s->n_correct[idx] = s->buf[0];
+        }
+        return;
+    }
+
     switch (s->pointer) {
-    case TMP421_CONVERSION_RATE_REG:
-        s->rate = s->buf[0];
-        break;
     case TMP421_CONFIG_REG_1:
-        s->config[0] = s->buf[0];
+        s->config[0] = s->buf[0] &
+                       (TMP421_CONFIG_RANGE | TMP421_CONFIG_SHUTDOWN);
         break;
     case TMP421_CONFIG_REG_2:
-        s->config[1] = s->buf[0];
+        s->config[1] = s->buf[0] & sc->config2_reset;
+        break;
+    case TMP421_CONVERSION_RATE_REG:
+        s->rate = s->buf[0] & 0x07;
+        break;
+    case TMP421_ONE_SHOT:
+        /* starts a conversion in shutdown; conversions are immediate here */
         break;
     case TMP421_RESET:
         tmp421_reset(s);
@@ -291,6 +323,24 @@ static int tmp421_event(I2CSlave *i2c, enum i2c_event event)
     return 0;
 }
 
+static bool tmp421_n_correct_needed(void *opaque)
+{
+    TMP421State *s = opaque;
+
+    return s->n_correct[0] || s->n_correct[1] || s->n_correct[2];
+}
+
+static const VMStateDescription vmstate_tmp421_n_correct = {
+    .name = "TMP421/n-correct",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = tmp421_n_correct_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT8_ARRAY(n_correct, TMP421State, 3),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static const VMStateDescription vmstate_tmp421 = {
     .name = "TMP421",
     .version_id = 0,
@@ -305,6 +355,10 @@ static const VMStateDescription vmstate_tmp421 = {
         VMSTATE_INT16_ARRAY(temperature, TMP421State, 4),
         VMSTATE_I2C_SLAVE(parent_obj, TMP421State),
         VMSTATE_END_OF_LIST()
+    },
+    .subsections = (const VMStateDescription * const []) {
+        &vmstate_tmp421_n_correct,
+        NULL
     }
 };
 
@@ -316,6 +370,7 @@ static void tmp421_reset(TMP421State *s)
      * The measured temperatures are not cleared: they model the physical
      * input the ADC re-samples after reset, and boards may preset them.
      */
+    memset(s->n_correct, 0, sizeof(s->n_correct));
     s->pointer = 0;
     s->config[0] = 0;
     s->config[1] = sc->config2_reset;

-- 
2.53.0-Meta


