Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C908CAC582
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 17:17:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvfTn-00053z-N7; Mon, 08 Sep 2025 13:16:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3Vg-_aAYKCr0wlwxvujrrjoh.frpthpx-ghyhoqrqjqx.ruj@flex--titusr.bounces.google.com>)
 id 1uvfTh-00051j-53
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 13:16:30 -0400
Received: from mail-pl1-x64a.google.com ([2607:f8b0:4864:20::64a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3Vg-_aAYKCr0wlwxvujrrjoh.frpthpx-ghyhoqrqjqx.ruj@flex--titusr.bounces.google.com>)
 id 1uvfTX-0005O6-Gp
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 13:16:27 -0400
Received: by mail-pl1-x64a.google.com with SMTP id
 d9443c01a7336-24b0e137484so39209175ad.0
 for <qemu-devel@nongnu.org>; Mon, 08 Sep 2025 10:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1757351767; x=1757956567; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Owet0KKZ+Ay9IhSxXmIgSGbu9Ps4JZDubm+QzFTqcM4=;
 b=XL2SP/BbMiXJEKgIpeO4I/u8Bc//dgIBmxW9NZYCm2oo/p2s3AFzTNwDUib5VPyHpG
 Vw6Fc0l4lj//2VZFKTkUg5sMFDuGlawtu4/C1bxSay3IaIVwMY2SeMKTrj4862tDeqnk
 cDuPrSg2PUbGW1ivecsoZ3XfrKZ23Ddv6L2cp9qgNPtBROT+oxEgUBGATIQjpbW3XkL5
 iXF+vK4SWZGL4wwuSZzbW7yQ1I1m/hYEitPSXn+7XY1yLs9qnNDQuvoVUjApZgM/6t0L
 s+/+anFh6mJukQD7FXEC/HDnlW8PUBhTLQ/hLQ7glQ+fUFGWn8uL0rmZ15Aj6Ltrp7Fb
 QPcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757351767; x=1757956567;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Owet0KKZ+Ay9IhSxXmIgSGbu9Ps4JZDubm+QzFTqcM4=;
 b=OkOlZaXk6J8mPrUd50Jm52r550fYcN5sXTfPRbzTCS3fMAhV3DT0JdD7us8OZFnp9M
 dghwovSjUMNvODGLltyXN0q9FPcFpuYZizSGdqZGqxsZ/Lqrck+8hXMtMGloEHU27uOQ
 fi15O1fbb58foijjBoNVFXkBI5nK1vBqzjIaaSEB2cXFtEuQKrzLBHQXveLIQUc0+RNG
 IgMVKfueh/gi6KxL08Ga+FUdEYyxBQPiXqS3gvvlWuhZJO1L3Da8ltfnO5h1zLavhbKh
 SWSTIGL4TafdgIxXLeOL6DIslp0mRIaSxWm37VBADMIMVjX2NVHj6mNW4P6lhWoyxBg/
 D5iA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcYQAdhHoW1Co4w+vmmeWyaYmMt3H/RvLbyGU/IJ7kkjTdx8R8RPmTJxrCkbFYLGdpAjWKI1qXyjTF@nongnu.org
X-Gm-Message-State: AOJu0Ywrgvp2M03Jf4oqvR/HQq5Sp9ExLbATVq0C4jw7l0oEL0w34TFe
 9vI9rSeR9tHX2yTe0TwMAEkGBKL5sBsn22rfhbL+Fe7osBGP3Krtade4OsU4MjAaxudye8rqz9a
 5Ws/rhw==
X-Google-Smtp-Source: AGHT+IElg8FgXHYCmigCvjCbRO88TOF+GTxPpHpFE909Y5HPlSXbphEDtd+FFrlxYc8k2r3J2st+gclgVe8=
X-Received: from plble5.prod.google.com ([2002:a17:902:fb05:b0:24c:822e:349c])
 (user=titusr job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:e742:b0:24c:ea1c:1176
 with SMTP id d9443c01a7336-25172291d04mr126730105ad.38.1757351766800; Mon, 08
 Sep 2025 10:16:06 -0700 (PDT)
Date: Mon,  8 Sep 2025 17:15:56 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250908171557.1510538-1-titusr@google.com>
Subject: [PATCH 1/2] hw/sensor: add stub for ADM1266 blackbox
From: Titus Rwantare <titusr@google.com>
To: philmd@linaro.org, wuhaotsh@google.com, bhillier@google.com
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kfting@nuvoton.com, 
 Titus Rwantare <titusr@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::64a;
 envelope-from=3Vg-_aAYKCr0wlwxvujrrjoh.frpthpx-ghyhoqrqjqx.ruj@flex--titusr.bounces.google.com;
 helo=mail-pl1-x64a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=unavailable autolearn_force=no
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

This patch fixes a bug that causes a kernel panic when calling ADM1266_BLACKBOX_INFORMATION.

Log Message:

adm1266 5-0042: Could not read blackbox!
Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: adm1266_nvmem_read+0x168/0x170

Signed-off-by: Titus Rwantare <titusr@google.com>
---
 hw/sensor/adm1266.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/hw/sensor/adm1266.c b/hw/sensor/adm1266.c
index 9017ce6116..1112f78d19 100644
--- a/hw/sensor/adm1266.c
+++ b/hw/sensor/adm1266.c
@@ -75,6 +75,12 @@ typedef struct ADM1266State {
 static const uint8_t adm1266_ic_device_id[] = {0x03, 0x41, 0x12, 0x66};
 static const uint8_t adm1266_ic_device_rev[] = {0x08, 0x01, 0x08, 0x07, 0x0,
                                                 0x0, 0x07, 0x41, 0x30};
+static const uint8_t adm1266_blackbox_info[] = {
+    0x04,       /* length */
+    0x00, 0x00, /* latest ID */
+    0x00,       /* latest record index */
+    0x00        /* latest record count */
+};
 
 static void adm1266_exit_reset(Object *obj, ResetType type)
 {
@@ -125,6 +131,17 @@ static uint8_t adm1266_read_byte(PMBusDevice *pmdev)
         pmbus_send(pmdev, adm1266_ic_device_rev, sizeof(adm1266_ic_device_rev));
         break;
 
+    case ADM1266_BLACKBOX_CONFIG:
+        break;
+
+    case ADM1266_READ_BLACKBOX:
+        break;
+
+    case ADM1266_BLACKBOX_INFORMATION:
+        pmbus_send(pmdev, adm1266_blackbox_info,
+                   sizeof(adm1266_blackbox_info));
+        break;
+
     default:
         qemu_log_mask(LOG_UNIMP,
                       "%s: reading from unimplemented register: 0x%02x\n",
@@ -154,6 +171,9 @@ static int adm1266_write_data(PMBusDevice *pmdev, const uint8_t *buf,
         pmbus_receive_block(pmdev, (uint8_t *)s->mfr_rev, sizeof(s->mfr_rev));
         break;
 
+    case ADM1266_BLACKBOX_CONFIG:
+    case ADM1266_READ_BLACKBOX:
+    case ADM1266_BLACKBOX_INFORMATION:
     case ADM1266_SET_RTC:   /* do nothing */
         break;
 
-- 
2.51.0.384.g4c02a37b29-goog


