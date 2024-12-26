Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DED55E77188
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Dec 2024 08:25:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQj9F-0007IC-Tx; Thu, 26 Dec 2024 03:23:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3ahJtZwgKCoU53qjx21qpxxpun.lxvznv3-mn4nuwxwpw3.x0p@flex--wuhaotsh.bounces.google.com>)
 id 1tQj9E-0007HZ-3Q
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 03:23:12 -0500
Received: from mail-pl1-x64a.google.com ([2607:f8b0:4864:20::64a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3ahJtZwgKCoU53qjx21qpxxpun.lxvznv3-mn4nuwxwpw3.x0p@flex--wuhaotsh.bounces.google.com>)
 id 1tQj9A-0000XA-La
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 03:23:10 -0500
Received: by mail-pl1-x64a.google.com with SMTP id
 d9443c01a7336-2166855029eso75272875ad.0
 for <qemu-devel@nongnu.org>; Thu, 26 Dec 2024 00:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1735201387; x=1735806187; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=G3x5K8zsn6Y1xJmAh6tP7pJX4NJthEKLJvAizkBq/wM=;
 b=TUKliKit3FcuoWnBFHHA4MEUBYtpGRJMElLEhGU6Vn4gGDjSIJk+fi5emtAsQDUtXZ
 US5dZ1V57jhbqzKMh5t1MZTb7JI4eLIphZ2Y7uzYK0qIER26pwVnyATQRD95/CCZ0g7C
 tEpY2cVD5g61lcQCicd5QST3qek8iY+2N3QEgVrsvfKiabPPIsWcAtLIxmE/u5jidkm3
 LVp/w3kLa0deosoG8AWPRVeT2jAHQ5vru7FQavjCzjrTg5HeTZEbA53njeHFTSot5EOZ
 5UDg5H/PO/6BnMQLN4g33R5Pm5vwBEPWLv4//xj/RNbvIHHMBZdqP5KIhMIy9ijviSDl
 hnyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735201387; x=1735806187;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=G3x5K8zsn6Y1xJmAh6tP7pJX4NJthEKLJvAizkBq/wM=;
 b=WDvMcmHwt7eYLjQR9q8wKdkYTJbeF1vszXfZWOPnG71mSM9ZVGw6mdFLfN0xi7VxgD
 wfkQGaovOuNokfwaKqM5VBNXFUI3039GroHW65nyMx7BIvoaC06rfOUeRwia+AHWbaG8
 bBTtl1CliSyI0AXccE/mC9ej43sOaxL9YJs2mfoUpLdrMgysZI+TUS98GBBd7stqTbDZ
 FgSCcUjr16mOLsj0BPH40U9tYrHQxVNcPvnfdqRJXW4GV/vGPHGQI0JgcnPa9MpdJC5t
 buqFUi2+fdjUR+E9VHwYtKgTfZ3v+Lt+T9j5DAqD3E+R2d73CWhaXYRN1spX52gO1e8F
 hrRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVadhsMtvUIGiBbUMYsbOQNcYL+MeiiwLgc8DMD1CgZKJIGi9zRKQPFB94DIJ1ALEcvgoZxJb2mM5NV@nongnu.org
X-Gm-Message-State: AOJu0YwfEStfm5wniKhAFRqTQkOsWvDC6kZhURNXGKOEhFpCTMHeL9zv
 U8BGo9RHwiS+rp6jXdpc3uRXZa6HQb5CZtymNTtLa//hyqnq1Dak1xronIXM+sGQWirlmNG7o9+
 3iHFab8M/qg==
X-Google-Smtp-Source: AGHT+IGTaO62s79c/w/n8ZHzogaTrXNWYdiRkkh8HdUPDv2HCrtk+Wh07mgklGrvZCSeeQrbwvbUoRUSQ0Lvsg==
X-Received: from pgmo10.prod.google.com ([2002:a63:5d4a:0:b0:8ae:4cf4:372])
 (user=wuhaotsh job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:3a94:b0:1e0:c378:6f5b with SMTP id
 adf61e73a8af0-1e5e081c6b2mr40197644637.38.1735201386984; 
 Thu, 26 Dec 2024 00:23:06 -0800 (PST)
Date: Thu, 26 Dec 2024 08:22:24 +0000
In-Reply-To: <20241226082236.2884287-1-wuhaotsh@google.com>
Mime-Version: 1.0
References: <20241226082236.2884287-1-wuhaotsh@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241226082236.2884287-6-wuhaotsh@google.com>
Subject: [PATCH 05/17] hw/misc: Rename npcm7xx_gcr to npcm_gcr
From: Hao Wu <wuhaotsh@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Avi.Fishman@nuvoton.com, 
 kfting@nuvoton.com, titusr@google.com, mimik-dev@google.com, 
 hskinnemoen@google.com, venture@google.com, pbonzini@redhat.com, 
 jasowang@redhat.com, alistair@alistair23.me, Hao Wu <wuhaotsh@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::64a;
 envelope-from=3ahJtZwgKCoU53qjx21qpxxpun.lxvznv3-mn4nuwxwpw3.x0p@flex--wuhaotsh.bounces.google.com;
 helo=mail-pl1-x64a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

NPCM7XX and NPCM8XX have a different set of GCRs and the GCR module
needs to fit both. This commit changes the name of the GCR module.
Future commits will add the support for NPCM8XX GCRs.

Signed-off-by: Hao Wu <wuhaotsh@google.com>
---
 hw/misc/meson.build                           | 2 +-
 hw/misc/{npcm7xx_gcr.c => npcm_gcr.c}         | 2 +-
 include/hw/arm/npcm7xx.h                      | 2 +-
 include/hw/misc/{npcm7xx_gcr.h => npcm_gcr.h} | 6 +++---
 4 files changed, 6 insertions(+), 6 deletions(-)
 rename hw/misc/{npcm7xx_gcr.c => npcm_gcr.c} (99%)
 rename include/hw/misc/{npcm7xx_gcr.h => npcm_gcr.h} (96%)

diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index d02d96e403..9bab048849 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -68,7 +68,7 @@ system_ss.add(when: 'CONFIG_IMX', if_true: files(
 ))
 system_ss.add(when: 'CONFIG_NPCM7XX', if_true: files(
   'npcm7xx_clk.c',
-  'npcm7xx_gcr.c',
+  'npcm_gcr.c',
   'npcm7xx_mft.c',
   'npcm7xx_pwm.c',
   'npcm7xx_rng.c',
diff --git a/hw/misc/npcm7xx_gcr.c b/hw/misc/npcm_gcr.c
similarity index 99%
rename from hw/misc/npcm7xx_gcr.c
rename to hw/misc/npcm_gcr.c
index 07464a4dc9..826fd41123 100644
--- a/hw/misc/npcm7xx_gcr.c
+++ b/hw/misc/npcm_gcr.c
@@ -16,7 +16,7 @@
 
 #include "qemu/osdep.h"
 
-#include "hw/misc/npcm7xx_gcr.h"
+#include "hw/misc/npcm_gcr.h"
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "qapi/error.h"
diff --git a/include/hw/arm/npcm7xx.h b/include/hw/arm/npcm7xx.h
index 4e0d210188..510170471e 100644
--- a/include/hw/arm/npcm7xx.h
+++ b/include/hw/arm/npcm7xx.h
@@ -24,7 +24,7 @@
 #include "hw/i2c/npcm7xx_smbus.h"
 #include "hw/mem/npcm7xx_mc.h"
 #include "hw/misc/npcm7xx_clk.h"
-#include "hw/misc/npcm7xx_gcr.h"
+#include "hw/misc/npcm_gcr.h"
 #include "hw/misc/npcm7xx_mft.h"
 #include "hw/misc/npcm7xx_pwm.h"
 #include "hw/misc/npcm7xx_rng.h"
diff --git a/include/hw/misc/npcm7xx_gcr.h b/include/hw/misc/npcm_gcr.h
similarity index 96%
rename from include/hw/misc/npcm7xx_gcr.h
rename to include/hw/misc/npcm_gcr.h
index c0bbdda77e..9b4998950c 100644
--- a/include/hw/misc/npcm7xx_gcr.h
+++ b/include/hw/misc/npcm_gcr.h
@@ -13,8 +13,8 @@
  * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
  * for more details.
  */
-#ifndef NPCM7XX_GCR_H
-#define NPCM7XX_GCR_H
+#ifndef NPCM_GCR_H
+#define NPCM_GCR_H
 
 #include "exec/memory.h"
 #include "hw/sysbus.h"
@@ -70,4 +70,4 @@ struct NPCM7xxGCRState {
 #define TYPE_NPCM7XX_GCR "npcm7xx-gcr"
 OBJECT_DECLARE_SIMPLE_TYPE(NPCM7xxGCRState, NPCM7XX_GCR)
 
-#endif /* NPCM7XX_GCR_H */
+#endif /* NPCM_GCR_H */
-- 
2.47.1.613.gc27f4b7a9f-goog


