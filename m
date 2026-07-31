Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33AF2C5516D
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 12:39:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpmWI-0001HG-N3; Fri, 31 Jul 2026 08:39:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1wpmWD-0001Gi-Vs
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 08:39:18 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1wpmWC-0001CU-JB
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 08:39:17 -0400
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-47fd4ee0b01so270407f8f.2
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 05:39:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785501555; x=1786106355;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yyemhKIbNDI0dfV54rPviOfcsJPqmPO4g32wuNZQnWs=;
 b=fJp9xwm7AePGphqlX1Z4tyf+aslLETVaoXG1QDP7jYYYlfgzOsIEMztH017XdpfvAX
 xdbkiLEFcihA3CExGg5gpBwLX+nnSPFGvY7HSNK3H3VES0kmCJgeodH0ceONqyHlAGwZ
 aVxMCq7V6dd57smIc35qBd6/93biXze0yre+FtRTybEN5OssD7kF/ibkTW6MsmaM4Ke0
 hhEUcxCIz5vitatvUzxMaCQWtUcdSr+gJrfBNHuyCnk5R/gg8xFuQzaf40ORHB1Lynlq
 Un4i+6/IRnoDVfwVjmODLolzjntH9to8irFxpLaaEw6RAXKK/M4OISF30UjRpqojvVtG
 De9g==
X-Gm-Message-State: AOJu0Yy8p7hg3J8HzZ+0Lz4mQwjSQWdOj7jhZvmTlq4klYR9NTe4R1iX
 CEtrIG7gY6UjgYcVglFF4QlQMeZgYBsCvfMBL+R7RFigE4uGu9T9y7wAPxRqTqwq
X-Gm-Gg: AR+sD11Scw2UPkSUgSUtXOwzSEaNRlmpebPCgQA/uhLlady8vstskLVTK11vKD6rc3w
 1XeX6aikkAkdlVsj0DPtkEReeJB6BdVgRUFdGRZ0hn8Se22vL0mDr22hbtl/bXE/jA1tec6KWxH
 JfT6nx5p8AfAd+xDnlYZX8ZZ3a3zrUHSrjfLhTu1B8dn9igdB+9VBK92Q0+FKvYU2YqIb5rfWbV
 QOpCOAax0J7fqw4g1lpXkXJM4eZPEP6GjU5IuzeUXojccNT9An1c9VSzkb/WA4lLeg7F4cLUB9o
 augcAYLRGNpFfcd12Assq1wiml8sCSuivlzMphP7soY+NPZtBZvis86+LN0ODMjFyunPgH/iduc
 Wx72LL4ToUiof+Yv1MHsMCYLpwc8B4EDuuXD0jB0rCRA3NBVi/MTzkGC7BiU41KgWXi0vFmWpMo
 X/InfsYKMd0SYzig+vs+67GXsBU7UHApivUNUjfcmDlBaYPN+eA/zndjOFTqmANmDYSZfN/TX7r
 gpe4flkcvq4rdg6htmvmO2ADJRFDRDyfhpwNvPs3TRxM/Q=
X-Received: by 2002:a05:6000:2983:20b0:47f:91e3:3cc9 with SMTP id
 ffacd0b85a97d-47fd2b4d7edmr3474816f8f.39.1785501554967; 
 Fri, 31 Jul 2026 05:39:14 -0700 (PDT)
Received: from localhost (89-93-216-19.hfc.dyn.abo.bbox.fr. [89.93.216.19])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd41d1756sm4392990f8f.4.2026.07.31.05.39.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 05:39:13 -0700 (PDT)
Date: Fri, 31 Jul 2026 12:45:14 +0200
Subject: [PATCH v2 15/25] hw/arm: fuji: use the real TMP75 and LM75B
 temperature sensors
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-sanmiguel-bmc-locator-v2-15-1266926ba769@free.fr>
References: <20260731-sanmiguel-bmc-locator-v2-0-1266926ba769@free.fr>
In-Reply-To: <20260731-sanmiguel-bmc-locator-v2-0-1266926ba769@free.fr>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 qemu-arm@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Thomas Huth <th.huth+qemu@posteo.eu>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Emmanuel Blot <eblot@meta.com>, Emmanuel Blot <emmanuel.blot@free.fr>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785494708; l=2648;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=3Z2LgNf5NONtKdqbZ6IR/+v7877ewZwsl3F8BgLX3xg=;
 b=+6EGiMAiJiKOZgQXC2/o8zVfWfockVOhBAh/ANeR5rmBrmI5HeHIRHxY9S4xchwipkuvm6Qer
 7NIm7ZrVwqzBRtBaQselErhYZAkDh3fGQ7tmJYqqL9uaU1vUpGI+AAp
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.221.47; envelope-from=eblot.ml@gmail.com;
 helo=mail-wr1-f47.google.com
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


