Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DFA2C54F51
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 15:39:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wp6ND-00059Z-MZ; Wed, 29 Jul 2026 11:39:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1wp6NC-00058t-Gi
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 11:39:10 -0400
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1wp6NB-0001dK-26
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 11:39:10 -0400
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-495437bb891so9276655e9.1
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2026 08:39:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785339547; x=1785944347;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yyemhKIbNDI0dfV54rPviOfcsJPqmPO4g32wuNZQnWs=;
 b=BkTkbU7AYYFKjwXYJ14RgfY+lUMZ8xfdunGUJ8kF3JG2pLkYoqFeNiOEMPTsC+ZTHn
 8I37LhLvt+HbkdC7pFzrwFIzWIgJMvc575fkPivGQa7JYszraxiRGHupZj1Tkvz3NagW
 fRi8pt8TrrsR+6InOzVuWBouXt90+dFLW8qkTL2iI1tal2ybVVD36JXsaskP8mDgA6Ca
 xHr3dHEs2F3+pnp/bSCq8uNcRAidxMec/wsy4HWbzW/Duc2vYo+NRgsA7opYaZ7Q+0Of
 AKeCtAF1UlMUdOXMQqCvH4b8uStn0jZ8t/hQYZkOSYCrV/8AebVP+Hts2vt/m0b7Gz9Q
 CQFQ==
X-Gm-Message-State: AOJu0YyeymoTjfB4oxcep/7ZxtmweSd96ZXnWdQdZVBGoYUAY1Go+wF+
 A6303YF7/2S04Hp/oZVMExqCJGrT0ouH/cYH0Lk6yOgrTXwZ3DtPYVMQSuehzxVR
X-Gm-Gg: AR+sD12hIrb9Bh9JoqM7MF2tfTFmvBz+Lbytgby7hRU+F0iNtH9lNM78GHPy4X3U5qf
 7Tsye0llBCSv6E/i6fQot84hEgoT/afIsRaA2/ryaOR2shFuHp+fUcLtP0ILt2a5uIMxSGdKJ4M
 fVdvjyoVYOcKsHa6URLVWLO3nGD9J93ftVlC3dTC6/H6J03t5QIyCt5fhwCGcCLaK2fmxvNrGxj
 zdKwyj3pnyXuTZo+f3i3/scyIIY9YUwbzGBMdhg6YHTrAPDb0E7UeBvLJqZRPRpPHfIhozNgdQz
 BDPNZ5o4q2MnsEH/GhGjn6efHKE8Bv+4Zt09aR5ZGhlunPosemJbTE1B5wK2Ftf8yNrj88iOa8A
 07xTqiJkL9ZTMHr6GScsMYqBHegTqtq9qyqBO3WvxHUeo1OxUAYCzqFhzWh8AyJXfB8emC/Q9bl
 2HWb8/qYfnT2CAYtVJle5PSsmuGioXnxGcW4nkC9K3mThz57IeFvG/dii68bfDElrRlR/yBoLy/
 tnL3fcA3/b2lCCLxeatbJWJhm5azTTB3fI2
X-Received: by 2002:a05:600c:8710:b0:492:6f5c:fd8c with SMTP id
 5b1f17b1804b1-497fd311860mr30695555e9.15.1785339547088; 
 Wed, 29 Jul 2026 08:39:07 -0700 (PDT)
Received: from localhost (89-93-216-19.hfc.dyn.abo.bbox.fr. [89.93.216.19])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496c462512dsm154633125e9.13.2026.07.29.08.39.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 08:39:06 -0700 (PDT)
Date: Wed, 29 Jul 2026 17:12:51 +0200
Subject: [PATCH 15/25] hw/arm: fuji: use the real TMP75 and LM75B
 temperature sensors
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260729-sanmiguel-bmc-locator-v1-15-c8f9a8d101f6@free.fr>
References: <20260729-sanmiguel-bmc-locator-v1-0-c8f9a8d101f6@free.fr>
In-Reply-To: <20260729-sanmiguel-bmc-locator-v1-0-c8f9a8d101f6@free.fr>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 qemu-arm@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Thomas Huth <th.huth+qemu@posteo.eu>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Emmanuel Blot <eblot@meta.com>, Emmanuel Blot <emmanuel.blot@free.fr>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785337964; l=2648;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=3Z2LgNf5NONtKdqbZ6IR/+v7877ewZwsl3F8BgLX3xg=;
 b=c4/xi9dVdrmq4Gb6hhrV7h2lN96P0ySNSmm3xHFsWb4HZHVBk9iSs4KSPx7QikBqfLxbvUfdI
 Dte8Sm01v2EADnUZ/CbogUMI0hmLbSEgk3tPZwmDb4LR3aBzhazf8Mb
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.128.50; envelope-from=eblot.ml@gmail.com;
 helo=mail-wm1-f50.google.com
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

The Fuji BMC instantiates many ti,tmp75 sensors and several NXP LM75B
sensors; the original board code approximated both with a plain TMP105
via local TYPE_TMP75 and TYPE_LM75 aliases (the latter mislabelling the
LM75B parts as LM75).

Now that hw/sensor/tmp105.h provides proper TMP75 and LM75B models, drop
the local aliases (and their guards) and instantiate the accurate
devices.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 hw/arm/aspeed_ast2600_fuji.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/hw/arm/aspeed_ast2600_fuji.c b/hw/arm/aspeed_ast2600_fuji.c
index 6dc3535f0c..fe0c294e14 100644
--- a/hw/arm/aspeed_ast2600_fuji.c
+++ b/hw/arm/aspeed_ast2600_fuji.c
@@ -15,14 +15,6 @@
 #include "hw/sensor/tmp105.h"
 #include "hw/nvram/eeprom_at24c.h"
 
-/*
- * Guard the aliases against the TYPE_TMP75 that hw/sensor/tmp105.h now defines;
- * TYPE_LM75 is guarded too for consistency (no LM75 model exists yet).
- */
-#undef TYPE_LM75
-#define TYPE_LM75 TYPE_TMP105
-#undef TYPE_TMP75
-#define TYPE_TMP75 TYPE_TMP105
 #define TYPE_TMP422 "tmp422"
 
 /* Fuji hardware value */
@@ -63,8 +55,8 @@ static void fuji_bmc_i2c_init(AspeedMachineState *bmc)
         get_pca9548_channels(i2c[40 + i], 0x76, &i2c[80 + i * 8]);
     }
 
-    i2c_slave_create_simple(i2c[17], TYPE_LM75, 0x4c);
-    i2c_slave_create_simple(i2c[17], TYPE_LM75, 0x4d);
+    i2c_slave_create_simple(i2c[17], TYPE_LM75B, 0x4c);
+    i2c_slave_create_simple(i2c[17], TYPE_LM75B, 0x4d);
 
     /*
      * EEPROM 24c64 size is 64Kbits or 8 Kbytes
@@ -74,15 +66,15 @@ static void fuji_bmc_i2c_init(AspeedMachineState *bmc)
     at24c_eeprom_init(i2c[20], 0x50, 256);
     at24c_eeprom_init(i2c[22], 0x52, 256);
 
-    i2c_slave_create_simple(i2c[3], TYPE_LM75, 0x48);
-    i2c_slave_create_simple(i2c[3], TYPE_LM75, 0x49);
-    i2c_slave_create_simple(i2c[3], TYPE_LM75, 0x4a);
+    i2c_slave_create_simple(i2c[3], TYPE_LM75B, 0x48);
+    i2c_slave_create_simple(i2c[3], TYPE_LM75B, 0x49);
+    i2c_slave_create_simple(i2c[3], TYPE_LM75B, 0x4a);
     i2c_slave_create_simple(i2c[3], TYPE_TMP422, 0x4c);
 
     at24c_eeprom_init(i2c[8], 0x51, 8 * KiB);
-    i2c_slave_create_simple(i2c[8], TYPE_LM75, 0x4a);
+    i2c_slave_create_simple(i2c[8], TYPE_LM75B, 0x4a);
 
-    i2c_slave_create_simple(i2c[50], TYPE_LM75, 0x4c);
+    i2c_slave_create_simple(i2c[50], TYPE_LM75B, 0x4c);
     at24c_eeprom_init(i2c[50], 0x52, 8 * KiB);
     i2c_slave_create_simple(i2c[51], TYPE_TMP75, 0x48);
     i2c_slave_create_simple(i2c[52], TYPE_TMP75, 0x49);

-- 
2.50.1


