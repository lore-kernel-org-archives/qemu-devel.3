Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A90606A31B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 09:29:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOtlw-0006oN-6i; Thu, 05 Nov 2026 04:28:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xOtlu-0006nw-UE
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 04:28:38 -0500
Received: from mail-pg1-f170.google.com ([209.85.215.170])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xOtls-0006x1-Fs
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 04:28:38 -0500
Received: by mail-pg1-f170.google.com with SMTP id
 41be03b00d2f7-cc147d86bebso292540a12.0
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 01:28:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793870915; x=1794475715;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=81LMFnXNkVBsPiHYzPBdhJHEHa6ngHS1FUyReoYZJfU=;
 b=j65YyirimvhqP+e2I5eyNyNXTCSa9CnEQjUu1gKNupFZy0lVJy61N7286xwHXe3TOv
 UrPTCqQSJeNVWfRzS1S3+qi8Wsyz9IbP5vpqyueiIQugYizjY7fXmX6P6WQNLvUuImaf
 9s8z/xD8b4h3U7WzXZd1wvPAyyrywLjPv/zIZYXmoko2MYrGHk3tZJwtQW9XraEZV1X4
 iObl1SmZNFhWtvNauh+KeVxU/856boi33PsWhpiahLJbOxclFF2ku9G2DJNDd0K1wtV2
 0ijfJL5TX8jUIySYtwdOHZbQP6AEiAL0Z8us2lsS9ic1PNJ50qVAon3vsYPlSxvdiObZ
 wm+Q==
X-Gm-Message-State: APuU4Z9SAdP5CouXmwVuXyStuGmitfHvu2ApmwVFEmsswGQ4eOsxIvwq
 n2RVkfdh9M3mXEoUP5IhQirRbWspBJVPDRIDB9Iibq6I25k6CrKPAjRJ4q4jg6mxQDI=
X-Gm-Gg: AYBFou0a7ZiJ8dK8uI7v5pd5RGoLW9y/3qon+XAtIPgVpopwF1A2SZlmhM1wvQV0CnG
 51+/MFujc+/thOcCB8nRyMDT1Nnm3Ditmbo7Hcu1/9DyiJ6vW8vx18GfHc74xNlhBumCPbIwQcC
 7HbVfgfOyMsIGsXlg65zCzdzukEBtvVj46AgDUObh1Q5PCXqf8blYPEF5lruH5M78W9bPiY+sUA
 9+p/VdgkKfqZnneLTK1AnIYU6eVEWsWMIRiJUhKP0LmBN3k9guxyaH3MHp86+GGeFS93anrHM9S
 T5J73nnRgF+0Aa6ZqKal44ybprvKOnZ8983uYs2hAbj/y9wrPIJXoZ2NWebPlQS8fov/IZIHpAw
 Z2aOtXYqWlorxKPPIyMM30kr1cZOkaGwgWuJf18L7gr2VkrLFCe8pxX2fZUQhp4TrsPojCn947R
 iJHzdp5I6rgwG4YjHm+rOhFXOodMoZorQ2ShVw/r66OKsoO0NG/hUe941dFCPtac/Le4m5ejiVg
 qOVu6MMPVAqK4hoPl+DluMJUpRhLebN4/DMvqwgpxwDK9MlI1bkvlgQd0LEgE6daJefbrnaM61Y
 cRZ9r6FEnldmBNDhr9H8Sq9tA+N5tvCYCfSbSStUQtkMIuWgJHXGrX8FTiNUmF22+cFk7ChOqI8
 d
X-Received: by 2002:a17:90b:3cc7:b0:3ae:3b3d:c617 with SMTP id
 98e67ed59e1d1-3b0afc64579mr1671344a91.29.1793870914894; 
 Thu, 05 Nov 2026 01:28:34 -0800 (PST)
Received: from localhost (118-163-122-149.hinet-ip.hinet.net.
 [118.163.122.149]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b0b31638fdsm3090889a91.8.2026.11.05.01.28.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 01:28:34 -0800 (PST)
Date: Thu, 05 Nov 2026 17:25:45 +0800
Subject: [PATCH 06/16] hw/sensor: tmp421: implement register write masks,
 one-shot and N-factor
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-sensor-tmp421-v1-6-c46853f5e1f0@free.fr>
References: <20261105-sensor-tmp421-v1-0-c46853f5e1f0@free.fr>
In-Reply-To: <20261105-sensor-tmp421-v1-0-c46853f5e1f0@free.fr>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, eblot@meta.com, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 qemu-arm@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Emmanuel Blot <emmanuel.blot@free.fr>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793870743; l=5041;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=th0BNPuLtBgK0HCmTvU0Ku8z2E6KSY0kShjV+vGaOoA=;
 b=GEqE7/FhvctPDBGn5D4B7rKpWjumCg+M3j6SCP8ecrq6NXYMBCSKrMW2fzQnn25JOLirPbIXa
 K3EDj9ovzRtDCOFTXH7GnOQZejq9BFsnCbJKAv8noG/p9ri58XoG7NL
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.215.170; envelope-from=eblot.ml@gmail.com;
 helo=mail-pg1-f170.google.com
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
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
index 5bb5043839..8c789a2a09 100644
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
@@ -45,6 +55,7 @@ struct TMP421State {
     /*< public >*/
 
     int16_t temperature[4];
+    uint8_t n_correct[3];   /* remote channels only */
 
     uint8_t status;
     uint8_t config[2];
@@ -86,6 +97,8 @@ OBJECT_DECLARE_TYPE(TMP421State, TMP421Class, TMP421)
 #define TMP421_CONVERSION_RATE_REG      0x0B
 #define TMP421_ONE_SHOT                 0x0F
 
+#define TMP421_N_CORRECT                0x21
+
 #define TMP421_RESET                    0xFC
 #define TMP421_MANUFACTURER_ID_REG      0xFE
 #define TMP421_DEVICE_ID_REG            0xFF
@@ -204,6 +217,11 @@ static void tmp421_read(TMP421State *s)
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
@@ -234,15 +252,29 @@ static void tmp421_reset(TMP421State *s);
 
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
@@ -292,6 +324,24 @@ static int tmp421_event(I2CSlave *i2c, enum i2c_event event)
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
@@ -306,6 +356,10 @@ static const VMStateDescription vmstate_tmp421 = {
         VMSTATE_INT16_ARRAY(temperature, TMP421State, 4),
         VMSTATE_I2C_SLAVE(parent_obj, TMP421State),
         VMSTATE_END_OF_LIST()
+    },
+    .subsections = (const VMStateDescription * const []) {
+        &vmstate_tmp421_n_correct,
+        NULL
     }
 };
 
@@ -317,6 +371,7 @@ static void tmp421_reset(TMP421State *s)
      * The measured temperatures are not cleared: they model the physical
      * input the ADC re-samples after reset, and boards may preset them.
      */
+    memset(s->n_correct, 0, sizeof(s->n_correct));
     s->pointer = 0;
     s->config[0] = 0;
     s->config[1] = sc->config2_reset;

-- 
2.53.0-Meta


