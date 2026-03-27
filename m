Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 816F510ED660
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 11:17:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w65Bk-0006PV-IR; Fri, 27 Mar 2026 07:17:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w65Bf-0006Mg-2x
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 07:17:11 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w65Bd-0007ez-Ad
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 07:17:10 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-486fba7ce4cso20562965e9.3
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 04:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774610228; x=1775215028; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=amX7qN1Oe+nF222PYlnbVwaAHtsoUnvlRllsmPM1bzc=;
 b=o+CcN3n3r7uF5mB/W1o5vP6DRlP+E0jdPUBSYX6JwiztFPj0MODTitCOsNVEPqrs2g
 GUbTdAe1ADSta6g0T57hqd6fcZGW2xLMQsfvszZ9raT/36YfRJxUA1Kvq7H4/2cclMnw
 WRibOg/AgagdlD+lY0kCPbfA1E7O/UypBp5LzrQIhyabUumKX+RZJ4ITxeysAt4sFwZH
 OwFkNNO/sKszGtZsFGD46iriRrxpZLF9k7epEmoI+YPvDasEkxK2DJl43dLygOy8gOxT
 mtDrlQD5HVO7r1M21ROOyzWCirNkxZ6tFjplrVZR+1WnuXylQ+dhAB8P51BCJE3Cyf5e
 OVdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774610228; x=1775215028;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=amX7qN1Oe+nF222PYlnbVwaAHtsoUnvlRllsmPM1bzc=;
 b=BWrOrA2SfEn/T0y10eVwyriCRz1AvHGrh02bpbb8h1ewgWX8Rf293nWmexx38Uy6sz
 XPxSu/vf+au6DgoDTTT/JITe44Zzwz8Y8ylIlIVl81psfr2Gvn+tFHuEy8FI5VhEY1UB
 o//G0gmLQkWA3WLBfB+8L1VHS58rNfYd/ReW0C4DHV1uSfhAm+9ra7b563rNNWQHysqY
 dfINyQM32ICT6gHo/tE0YRe2O9gJRxTjqSmVBmSoAqVDECkG+UgUD8CukVn30bPt+v2z
 XeiSghrQxKoKGmAZOAC80UzQ1mYMqZjcUFoflLNX7D2ICwbTcdz+JA/3ou0UssAEihQp
 RChA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0AJCaqJeGTSqgUbMMf9Df1wZOrYnyCKwpW3i9cl/V4cYo80H7SYEz9ParV+diqAUen+ZLtCnQmZhk@nongnu.org
X-Gm-Message-State: AOJu0YzBNpABRrqsC9vqbR43EGBvcVovSBdqrNW5WPnMA2oaKSRBsqgO
 CfdaWiODATPLM7Af4+wBx8GBmiLAW8Te87CgUQyYGEutoAyC4CMYHDA5KOeZGrLjrGp5cH5k7gC
 KEwu0Fx0=
X-Gm-Gg: ATEYQzzkpSICzaOMIQmZtee91wTl1citU8Aq1LuWWK6R6dJ52M+RAfu52+9MzT9FZnm
 KYdqpUu2JdVDY5N8/N6g+hI18H5fWKVXKMCrsGe0m26Vp/GuZ65mKWBmWO2PYCavXvxXW0LXXU1
 qnng84+dTJHOna3WTuV+01qOA0Kaf9b58ocIUn8AwYMyiDoMncoUz3k/aaWCvbEg+wL+UlWF2Kh
 UjJyIGQzMRMO2+LbBUl9TakHSMPpIdUse5U5zvWiFM8FzNzzbVYNgm6prr67WrUk/Fn950TE1q0
 8eoibs4g6RTLAokPb1jou0A7m6lypkD96carLhKO9SnvqVOmpNVY8MPWHNQcozKIzwXBQK/li7r
 Hn5OI3GgIDn7ONYuvTGjsio+VFjgSjL6/wVlxI4ZucUYfRf5E5Uj95w1syA36ub5QNDjorRUm50
 lhssBdR/Y2ZELzu+2+tciPDlA06nHDWetUkMzukdVAGKWQjLLP7+0iBcoZ+oOBZRB7CdGExhDiI
 srvjS905fdS6tuR4iidltNtSxp6LBY=
X-Received: by 2002:a05:600c:4f91:b0:486:f634:ef1 with SMTP id
 5b1f17b1804b1-48727eda549mr35026215e9.17.1774610227580; 
 Fri, 27 Mar 2026 04:17:07 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b919cf2b2sm15484227f8f.18.2026.03.27.04.17.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 04:17:06 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: [PATCH v2 06/65] hw/intc/arm_gicv5: Add migration blocker
Date: Fri, 27 Mar 2026 11:16:01 +0000
Message-ID: <20260327111700.795099-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260327111700.795099-1-peter.maydell@linaro.org>
References: <20260327111700.795099-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This initial version of the GICv5 will not support migration:

 * the spec is still only at EAC level, so the data to be
   migrated might in theory change before it is finalised
 * when we add support for missing features like EL2/EL3/Realm
   we might find we want to refactor the data structures we use
 * I still need to check against the proposed KVM GICv5
   handling to see if there are any awkward mismatches
   that might affect how we want to store the data
 * it's experimental, so for pragmatic reasons I'm skipping
   it to get the initial version done faster

Install a migration blocker to enforce this.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
---
 hw/intc/arm_gicv5.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
index 3a9d566924..64bec16bdd 100644
--- a/hw/intc/arm_gicv5.c
+++ b/hw/intc/arm_gicv5.c
@@ -11,6 +11,7 @@
 #include "qapi/error.h"
 #include "qemu/log.h"
 #include "trace.h"
+#include "migration/blocker.h"
 
 OBJECT_DEFINE_TYPE(GICv5, gicv5, ARM_GICV5, ARM_GICV5_COMMON)
 
@@ -173,6 +174,7 @@ static void gicv5_realize(DeviceState *dev, Error **errp)
 {
     GICv5Common *cs = ARM_GICV5_COMMON(dev);
     GICv5Class *gc = ARM_GICV5_GET_CLASS(dev);
+    Error *migration_blocker = NULL;
 
     ERRP_GUARD();
 
@@ -181,6 +183,12 @@ static void gicv5_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    error_setg(&migration_blocker,
+               "Live migration disabled: not yet supported by GICv5");
+    if (migrate_add_blocker(&migration_blocker, errp)) {
+        return;
+    }
+
     /*
      * When we implement support for more than one interrupt domain,
      * we will provide some QOM properties so the board can configure
-- 
2.43.0


