Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EBFCC02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 01:35:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfqkW-0005NS-Au; Wed, 05 Feb 2025 20:32:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <37hCkZwgKCuMbZMFTYXMLTTLQJ.HTRVJRZ-IJaJQSTSLSZ.TWL@flex--wuhaotsh.bounces.google.com>)
 id 1tfqk0-0005Dd-J3
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 20:31:41 -0500
Received: from mail-pj1-x104a.google.com ([2607:f8b0:4864:20::104a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <37hCkZwgKCuMbZMFTYXMLTTLQJ.HTRVJRZ-IJaJQSTSLSZ.TWL@flex--wuhaotsh.bounces.google.com>)
 id 1tfqjv-0006uv-Qt
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 20:31:37 -0500
Received: by mail-pj1-x104a.google.com with SMTP id
 98e67ed59e1d1-2f81a0d0a18so709958a91.3
 for <qemu-devel@nongnu.org>; Wed, 05 Feb 2025 17:31:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1738805487; x=1739410287; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=NiNNDrxtbn3MfU51n0qcg9RV04+RKFFNZ2cs0/SK/DI=;
 b=qloyxw0/lBHf56vGdL/qx86NrRpVaGj58EKL/dBSFMu4TB95K5iXMw5uPxgfxp3x6d
 uTgKvKflEy5O/Luw8IBrs+Nm5lXWPo2IC1vY+8ir5/d/LUqoLSkrsJHHcE4i5UmGRe6X
 C7kbmECkjvsG7k1UhWbYi+yv9u8bmL41QvWH9URYGVZehSoliLCVRNDTLZzVHwb0bNvL
 zp6AADZ//QoNf86fR62eEKzi3mwcxo43IoNdFZ0coNkbK7vdXBdOMesaJHqzNY+TeQrU
 rJV668E73eu5rRLg5LdUor4zVBGKZ/hQy+B0rY55CJjaGYg2likUNROwwXngfuLTJjGf
 l7Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738805487; x=1739410287;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NiNNDrxtbn3MfU51n0qcg9RV04+RKFFNZ2cs0/SK/DI=;
 b=HrW4EF3DeCtC/eLvsIwYrLTTFDs1FoC+ak/aYhymmqmEvsS0loyeqxol2KG1HQxxJ6
 nWEfsmhe6lwVv/LrMrWH0sNu+8VPho7NKQVveQ2CKNWvCVbxNTIH46uLme4tH65AuuHN
 bVzb6omHGeW7kUsOeeGUsXcGeenIbMCECq6YgKHVXo/FilqnNxT8lNoPJWaoCniJPcVx
 iUjP6fRcFrTB7PSbcdkf6xcEPHZpasJySEy5Shkwl4WFxxCBYQ3Z5uvpf1HJ1oLly8Wr
 tdFa67waEXv05iMz/dpzl5BXcT5r7trvRm4LTBuyFBmmwd4Fi3PDzfX5Djgpizfd/Ucr
 VqWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmoHxEiaPA1ZYAPALbct3CHwgY99wgn0cVQoFNUxEn7fw1lkXEMwVE5USmzEQC6PvazZeVdhSwFipA@nongnu.org
X-Gm-Message-State: AOJu0YyGbtgRrjS54/aymIdxx/U+eRcopgsmWoHFKPMjULrpPzYos9kl
 R3EfNnlnr2HALlZFUPZ6hl/5bvNaz4612minrUUrkAsrrrwzPeYFB4RgOpop4tk4fN9YO6vlUGU
 n1b7fH1HhtQ==
X-Google-Smtp-Source: AGHT+IFN/BdICHF10rZB+KK9PyMbvvIXfiOXpo8wSxejgjklqbZs88C1lDcrn6H+HFOWkZXdmFjIqbyECr1lTg==
X-Received: from pfaq11.prod.google.com ([2002:a05:6a00:a88b:b0:729:9f1:663e])
 (user=wuhaotsh job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:3908:b0:729:c7b:9385 with SMTP id
 d2e1a72fcca58-73035103911mr6650154b3a.6.1738805486684; 
 Wed, 05 Feb 2025 17:31:26 -0800 (PST)
Date: Wed,  5 Feb 2025 17:30:58 -0800
In-Reply-To: <20250206013105.3228344-1-wuhaotsh@google.com>
Mime-Version: 1.0
References: <20250206013105.3228344-1-wuhaotsh@google.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250206013105.3228344-11-wuhaotsh@google.com>
Subject: [PATCH v3 10/17] hw/misc: Rename npcm7xx_clk to npcm_clk
From: Hao Wu <wuhaotsh@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, wuhaotsh@google.com, 
 venture@google.com, Avi.Fishman@nuvoton.com, kfting@nuvoton.com, 
 hskinnemoen@google.com, titusr@google.com, 
 chli30@nuvoton.corp-partner.google.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::104a;
 envelope-from=37hCkZwgKCuMbZMFTYXMLTTLQJ.HTRVJRZ-IJaJQSTSLSZ.TWL@flex--wuhaotsh.bounces.google.com;
 helo=mail-pj1-x104a.google.com
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

NPCM7XX and NPCM8XX have a different set of CLK registers. This
commit changes the name of the clk files to be used by both
NPCM7XX and NPCM8XX CLK modules.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Hao Wu <wuhaotsh@google.com>
---
 hw/misc/meson.build                           | 2 +-
 hw/misc/{npcm7xx_clk.c => npcm_clk.c}         | 2 +-
 include/hw/arm/npcm7xx.h                      | 2 +-
 include/hw/misc/{npcm7xx_clk.h => npcm_clk.h} | 6 +++---
 4 files changed, 6 insertions(+), 6 deletions(-)
 rename hw/misc/{npcm7xx_clk.c => npcm_clk.c} (99%)
 rename include/hw/misc/{npcm7xx_clk.h => npcm_clk.h} (98%)

diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 554eb8df5b..edd36a334d 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -69,7 +69,7 @@ system_ss.add(when: 'CONFIG_IMX', if_true: files(
   'imx_rngc.c',
 ))
 system_ss.add(when: 'CONFIG_NPCM7XX', if_true: files(
-  'npcm7xx_clk.c',
+  'npcm_clk.c',
   'npcm_gcr.c',
   'npcm7xx_mft.c',
   'npcm7xx_pwm.c',
diff --git a/hw/misc/npcm7xx_clk.c b/hw/misc/npcm_clk.c
similarity index 99%
rename from hw/misc/npcm7xx_clk.c
rename to hw/misc/npcm_clk.c
index 46f907b61c..2bcb731099 100644
--- a/hw/misc/npcm7xx_clk.c
+++ b/hw/misc/npcm_clk.c
@@ -16,7 +16,7 @@
 
 #include "qemu/osdep.h"
 
-#include "hw/misc/npcm7xx_clk.h"
+#include "hw/misc/npcm_clk.h"
 #include "hw/timer/npcm7xx_timer.h"
 #include "hw/qdev-clock.h"
 #include "migration/vmstate.h"
diff --git a/include/hw/arm/npcm7xx.h b/include/hw/arm/npcm7xx.h
index 2e708471ec..e80fd91f20 100644
--- a/include/hw/arm/npcm7xx.h
+++ b/include/hw/arm/npcm7xx.h
@@ -23,7 +23,7 @@
 #include "hw/gpio/npcm7xx_gpio.h"
 #include "hw/i2c/npcm7xx_smbus.h"
 #include "hw/mem/npcm7xx_mc.h"
-#include "hw/misc/npcm7xx_clk.h"
+#include "hw/misc/npcm_clk.h"
 #include "hw/misc/npcm_gcr.h"
 #include "hw/misc/npcm7xx_mft.h"
 #include "hw/misc/npcm7xx_pwm.h"
diff --git a/include/hw/misc/npcm7xx_clk.h b/include/hw/misc/npcm_clk.h
similarity index 98%
rename from include/hw/misc/npcm7xx_clk.h
rename to include/hw/misc/npcm_clk.h
index 5ed4a4672b..0aef81e10c 100644
--- a/include/hw/misc/npcm7xx_clk.h
+++ b/include/hw/misc/npcm_clk.h
@@ -13,8 +13,8 @@
  * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
  * for more details.
  */
-#ifndef NPCM7XX_CLK_H
-#define NPCM7XX_CLK_H
+#ifndef NPCM_CLK_H
+#define NPCM_CLK_H
 
 #include "exec/memory.h"
 #include "hw/clock.h"
@@ -177,4 +177,4 @@ struct NPCM7xxCLKState {
 #define TYPE_NPCM7XX_CLK "npcm7xx-clk"
 OBJECT_DECLARE_SIMPLE_TYPE(NPCM7xxCLKState, NPCM7XX_CLK)
 
-#endif /* NPCM7XX_CLK_H */
+#endif /* NPCM_CLK_H */
-- 
2.48.1.362.g079036d154-goog


