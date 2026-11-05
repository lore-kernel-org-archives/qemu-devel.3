Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978E5606A31B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 09:29:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOtmJ-0007AL-Nu; Thu, 05 Nov 2026 04:29:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xOtmH-00076N-1j
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 04:29:01 -0500
Received: from mail-pg1-f182.google.com ([209.85.215.182])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xOtmF-0006yI-47
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 04:29:00 -0500
Received: by mail-pg1-f182.google.com with SMTP id
 41be03b00d2f7-cdb628232d2so24633a12.0
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 01:28:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793870937; x=1794475737;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=m9zQSOewUBeGGhmPONHFHebxBVsiYOdk+rPiNV2Yw/M=;
 b=VQ5/DgDRN7XmaiIe51HpdrNfajwqqf6A4l6zIoR1TAh31jQnSDppdpoe3hfA7RonQk
 sie7hggo9LNw2jbRfuAW/kAD3/NTTwIn8mT/nT2UTVdMIauXg/xz8x5A/s8ExtAmQcOk
 VddPOWp7rGccn5SbGdJQJ/+vW9Jmq0gbWXKdjBE3KThhiqwUItiTM24z7vPDEUPwCK+K
 Rfk8PoxXaHbA3vyv4M1g4U9hBGMqcRhzolmXsVnzIdZgx2qKcuV7DdWu4NUyUsjQ67Ai
 E7Bf8fhg8/G9hXqDDgIDZ+9TkktEkvhVqE5H2MHT93D9WCIBG5rZxSlfVLrvjIMZE6bH
 P5ug==
X-Gm-Message-State: APuU4Z8TcXbmXpN46m1gP899hv9iP7IGoWu8YgGdqOq1yMQQNNc+7WG7
 l3CcrSdgqVlpd2OPAYpafaKjgzS9NZpxVCaUvCxri4UZB4pjrxXD80uys6gGemipCV8=
X-Gm-Gg: AYBFou34aHtemDXWh55HKhMYUnwBRxV0Za1WB5IqlI1k3aUbMSwPuFnTaHl73y+G7Gz
 w2shGq/73cUA6wLCW7aed4XCBicbdM1tmyPPwnbvSJ9eWxgmxxBSti4PWu7W5qcp03x5+n1gmq5
 gIzcsZ5gfsHjnUkTAw+dvNoccUClJbVe3Z+O5e4qZizY2QcIId58zLTezQdhqIyMEx7W+Jw7rI2
 asUGl2wd3yhI3zYNNNoNI57fwIMn7tjbQ3C4mGrEgO14DzhiMxqiKW12YEyqHtIuo/BJlghQjzo
 iPaLS6ggqH8lizvEaclY+UNK0K41XRSA50Hy1p1ZAWqKnog7zASXpCk+Bd8pkAIdEpGCo1uNSC0
 0R5twYVMkPGzqzUW2EHr9V4Lh0YrroBa+ravWzicqpuVbe+p7cgV6wtk6Hp/Db+59qtbs/9QEX7
 4FJbR+6GQUaKsuhlT2knKLpB2gCCVAv/+ysvzHbNOydYq+cMEnNWjNFvGKIsrEXIuOUiFeq4Tag
 yo2kQ/lkJ4NzBZr9ZZOyzpjkeDMMifDr5q013JFX20tDiHlZN6ySW0lY0DdNAKKyFhF0jxpZp3q
 UdDiUcYe9XSnAXFxR5YlXoE7oaGKFriV0NFmQrCvSSm+9ujGl56UESx7jGRL9U14JTjASAxXqTn
 r
X-Received: by 2002:a17:90b:2ecc:b0:3ac:6fcf:91d2 with SMTP id
 98e67ed59e1d1-3ae897c64fbmr16442723a91.19.1793870937365; 
 Thu, 05 Nov 2026 01:28:57 -0800 (PST)
Received: from localhost (118-163-122-149.hinet-ip.hinet.net.
 [118.163.122.149]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b094dec0e3sm3395847a91.1.2026.11.05.01.28.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 01:28:57 -0800 (PST)
Date: Thu, 05 Nov 2026 17:25:48 +0800
Subject: [PATCH 09/16] hw/sensor: tmp421: migrate the exact measurement
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-sensor-tmp421-v1-9-c46853f5e1f0@free.fr>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793870743; l=3784;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=s1Fn+bQ71xnXmSCzvqiaHUL+siL1Ys4lowpPQMHLKzs=;
 b=3FvekpxYMe4VR/ANlwP5iRX3fI30QPDBLKgXmyV5rAG/xkCUSnh0H5gT6X1Rb5xI8NUJ7Bvy9
 Un2c0ll6GKLDc3CsXoorIotp6ru0WgS/2lOlGtfwmrq7DwVSrQEHkxO
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.215.182; envelope-from=eblot.ml@gmail.com;
 helo=mail-pg1-f182.google.com
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

The register form the stream carries only resolves a sixteenth of a
degree, so a temperature set through the property does not survive a
round trip unless it happens to fall on that grid.

Add a subsection holding the measurement itself, sent only when the
register form cannot reproduce it. A stream from a sensor holding an
expressible value -- the usual case, boards preset whole degrees --
therefore stays loadable by a QEMU that knows nothing of it.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 hw/sensor/tmp421.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 58 insertions(+), 2 deletions(-)

diff --git a/hw/sensor/tmp421.c b/hw/sensor/tmp421.c
index 943295240d..1966301d7a 100644
--- a/hw/sensor/tmp421.c
+++ b/hw/sensor/tmp421.c
@@ -60,6 +60,7 @@ struct TMP421State {
 
     /* migration only: the register form the stream carries */
     int16_t temperature[4];
+    bool temp_mc_loaded;
 
     uint8_t status;
     uint8_t config[2];
@@ -380,6 +381,56 @@ static const VMStateDescription vmstate_tmp421_n_correct = {
     }
 };
 
+/*
+ * That form only resolves a sixteenth of a degree, so the measurement itself
+ * travels in a subsection -- sent only when the register form cannot
+ * reproduce it, which leaves the usual stream loadable by a QEMU that does
+ * not know the subsection.
+ */
+static bool tmp421_temp_mc_needed(void *opaque)
+{
+    TMP421State *s = opaque;
+    bool ext_range = s->config[0] & TMP421_CONFIG_RANGE;
+    int32_t offset = ext_range ? TMP421_EXT_OFFSET : 0;
+
+    /*
+     * The register form reproduces a measurement when the conversion divides
+     * exactly and the encoder had nothing to clamp. Asking the decoder
+     * instead would settle the question with the function whose result the
+     * subsection exists to protect, and hide any error it has.
+     */
+    for (unsigned channel = 0; channel < ARRAY_SIZE(s->temp_mc); channel++) {
+        int32_t scaled = s->temp_mc[channel] * 256;
+
+        if (scaled % 1000 ||
+            (uint16_t)(scaled / 1000 + offset) != tmp421_encode(s, channel)) {
+            return true;
+        }
+    }
+
+    return false;
+}
+
+static int tmp421_temp_mc_post_load(void *opaque, int version_id)
+{
+    TMP421State *s = opaque;
+
+    s->temp_mc_loaded = true;
+    return 0;
+}
+
+static const VMStateDescription vmstate_tmp421_temp_mc = {
+    .name = "TMP421/temperature-mc",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = tmp421_temp_mc_needed,
+    .post_load = tmp421_temp_mc_post_load,
+    .fields = (const VMStateField[]) {
+        VMSTATE_INT32_ARRAY(temp_mc, TMP421State, 4),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 /*
  * The stream carries the register form of the measurement: that is what a
  * QEMU predating the millidegree state writes, and what it expects back.
@@ -399,9 +450,13 @@ static int tmp421_post_load(void *opaque, int version_id)
 {
     TMP421State *s = opaque;
 
-    for (unsigned channel = 0; channel < ARRAY_SIZE(s->temp_mc); channel++) {
-        s->temp_mc[channel] = tmp421_decode(s, s->temperature[channel]);
+    if (!s->temp_mc_loaded) {
+        for (unsigned channel = 0; channel < ARRAY_SIZE(s->temp_mc);
+             channel++) {
+            s->temp_mc[channel] = tmp421_decode(s, s->temperature[channel]);
+        }
     }
+    s->temp_mc_loaded = false;
 
     return 0;
 }
@@ -424,6 +479,7 @@ static const VMStateDescription vmstate_tmp421 = {
         VMSTATE_END_OF_LIST()
     },
     .subsections = (const VMStateDescription * const []) {
+        &vmstate_tmp421_temp_mc,
         &vmstate_tmp421_n_correct,
         NULL
     }

-- 
2.53.0-Meta


