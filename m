Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14E3DC02199
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 01:34:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfqkU-0005MK-DU; Wed, 05 Feb 2025 20:32:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <35RCkZwgKCtoSQD6KPODCKKCHA.8KIMAIQ-9ARAHJKJCJQ.KNC@flex--wuhaotsh.bounces.google.com>)
 id 1tfqjt-0005Ci-7i
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 20:31:40 -0500
Received: from mail-pj1-x104a.google.com ([2607:f8b0:4864:20::104a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <35RCkZwgKCtoSQD6KPODCKKCHA.8KIMAIQ-9ARAHJKJCJQ.KNC@flex--wuhaotsh.bounces.google.com>)
 id 1tfqjk-0006tT-4o
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 20:31:26 -0500
Received: by mail-pj1-x104a.google.com with SMTP id
 98e67ed59e1d1-2fa032b17c3so847399a91.1
 for <qemu-devel@nongnu.org>; Wed, 05 Feb 2025 17:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1738805477; x=1739410277; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=nhDHNsqOuHIuugitVBKeEkbSBRDrJD2r9kXRQvXzHqw=;
 b=tSEtZEHfM/AcFuNAGKhTFgQZQ5Y10ASIhVPrG9KvMt0khbH9o1Ka6P2ogmBI/knO57
 MnW5Gi33+eW2NSw1Pt8LQFgakPcCMtPXlOvHDd/qroGHoveoIf/wiEPqXgRkMywqrc2e
 SsCXgmpuC2RFn5Z7mxWIqz45tcRoV1n5BLo5mp1HD57IpyyqG/9ErpkxlSe6wLHbesGv
 ew/iZJshlI8LsobtEasf5U9wTe9qJRmiFlXxQAKQbaHxH38XJlI0LxjJs/xly+VBS/mx
 7PTc1wrxjeuoX9Xdx/KRrVARlLnyWUpOrjeCEnq4FpNqEV8lcW4AiPZGX0yhKJe6v1rL
 HMyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738805477; x=1739410277;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nhDHNsqOuHIuugitVBKeEkbSBRDrJD2r9kXRQvXzHqw=;
 b=P+KVvRBQdG6kc9fg3vnXmcp0T/OPKYx89RyU+LnmANSu2fN1xnYtf2/8Sra4w5x2D3
 ciEQYjn8GfWzmxNB3RLiPts3p85XilFJNBIr9dI3sNK1+XNe1CDb7QdN36BGB5y2+DpZ
 ljDiBLIypKI3ms5eqRJkaDuGueewuNZaMORMxkDBCLzpnlZQz845iOuhA3cRF/8hYfgF
 CayLfuj1Fqz3rUcOzWjowo7mpE6I2kW93z6P1jE9VdiR8bt9+oYM2bYIQl3x+lLpv6ii
 BE3q1fDSCTg3ZLLhWEAaRowBImFCl400V5G4wVULaN6ZBI2v2qgeREdlM7AA1SjX0HgN
 fCqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOoFy029EDcrHbFTgMD0u+Rscfrx6hIqnGGs0NAVV3jkDTpgn01H8y/6lCLofY3/UrhAL7tc/p/LHG@nongnu.org
X-Gm-Message-State: AOJu0Yzh0BI6INje2CoN+WFJ3TM0OS4XVK7NsJyYTNg54sSyxF/UYbAs
 pxGcFR45+Bpc90QRuX7O1wuGpQRlPiQcuCjGU2UBnt5kCPwIjeqZhI1SRyPDpKolGqZ78VuccYf
 wdcEPvIhzTg==
X-Google-Smtp-Source: AGHT+IEXppVfR3dzc5kyS1SP6009VS5pj/GBMZJao/whnPwpPwHn7GzZVA2jZOr1Fj7rWsmrExpH6BC/IXtvrA==
X-Received: from pjbpd11.prod.google.com ([2002:a17:90b:1dcb:b0:2ef:79ee:65c0])
 (user=wuhaotsh job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:17d1:b0:2ee:df70:1ff3 with SMTP id
 98e67ed59e1d1-2f9e06a1b1dmr9626179a91.0.1738805477505; 
 Wed, 05 Feb 2025 17:31:17 -0800 (PST)
Date: Wed,  5 Feb 2025 17:30:52 -0800
In-Reply-To: <20250206013105.3228344-1-wuhaotsh@google.com>
Mime-Version: 1.0
References: <20250206013105.3228344-1-wuhaotsh@google.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250206013105.3228344-5-wuhaotsh@google.com>
Subject: [PATCH v3 04/17] hw/misc: Rename npcm7xx_gcr to npcm_gcr
From: Hao Wu <wuhaotsh@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, wuhaotsh@google.com, 
 venture@google.com, Avi.Fishman@nuvoton.com, kfting@nuvoton.com, 
 hskinnemoen@google.com, titusr@google.com, 
 chli30@nuvoton.corp-partner.google.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::104a;
 envelope-from=35RCkZwgKCtoSQD6KPODCKKCHA.8KIMAIQ-9ARAHJKJCJQ.KNC@flex--wuhaotsh.bounces.google.com;
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

NPCM7XX and NPCM8XX have a different set of GCRs and the GCR module
needs to fit both. This commit changes the name of the GCR module.
Future commits will add the support for NPCM8XX GCRs.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
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
index 55f493521b..554eb8df5b 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -70,7 +70,7 @@ system_ss.add(when: 'CONFIG_IMX', if_true: files(
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
2.48.1.362.g079036d154-goog


