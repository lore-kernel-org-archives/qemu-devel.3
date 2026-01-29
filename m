Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BD3FD6B086
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 16:11:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlUbB-0001os-3m; Thu, 29 Jan 2026 11:10:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlUaj-0000Tn-GU
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:10:01 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlUaf-0006iz-IC
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:09:56 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-4327790c4e9so745677f8f.2
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 08:09:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769702992; x=1770307792; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Ht2blUch5J5UITDJcWny0wh5hUzdGhmPTt7vqIgV91o=;
 b=NEGSAaiDR4+0FreQZPgTB+cRrW/eYq174wqpZ0QVRB9RdOS7V2xN78mU4EC+KZVfk2
 7cDKF9xoHsSSVd97BoGrVkO6JPWCl4B8T7Xfh1/ZsDNQh1z6MHNgwoyt+GaZbKqJOfC/
 f2G3T7XjlHpRdmVHED/VjWOoWWT8CNdASUE+x+2NS6atgftTnYLGbzTKNbA5bm3dp+qp
 4ESxgODdu1XhkjRjRXUyHxjOEa44kXHhwp+pAyR+YkkG4QuGjP+rremKLMAYD9BvtYNO
 j//IV4QlsgLfGJPQhKTOpCfM0N+Zo6JwblgWTuueTiqD8gQtjwJeLIQC0jUOX0gpLUSk
 XIpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769702992; x=1770307792;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Ht2blUch5J5UITDJcWny0wh5hUzdGhmPTt7vqIgV91o=;
 b=Bi/Td5tQgPVft18oW0duEhjSNghmZlir8Dc9XSi/oKzVT6gZKxVspILa3wsvf9rIci
 UNnzt9gYx0NPQrpd2mT+Eo6VU3Rx9i9I4YqjYIkyRKz6uzGjHHPYXTSypBZFzgz5EG2h
 SoFu+tGoIjUbdG3ZEJkxjosdSqmKPU8a+1vDGvfs16va83reEtygrPP8lh/z9JIY49Ac
 C3vkKECWDHaa6qu1OghYvsK0hInUkAFTG1P93yY4xyHAxTpKUli9S+5HM/ZF6wvNtEIT
 JtgMO9rra9PpK07uFUh4Au85DM7Ck/aDlRs1LkAQJ02kDtf4pwn4mdKpTwSPRrHnLcBh
 F9cg==
X-Gm-Message-State: AOJu0YxkCHZrw5eCU3TAqWGwAXFlfVzaOtpY+DoI5Bi0ZvNYXBCLimnm
 NQj+w2Zf/99GKwV2s8eAilF+lyS7ov1SwEVEW5/ZnPCMQtbYdB13n2lwup1jUjMHt3KAt+37/2g
 tvEyU0as=
X-Gm-Gg: AZuq6aJsXT5dZ9Bccka50wJrVokHFxTQWyD4mLNHbrHB7ci3RwoWDXmpOJKbl+WUYXJ
 BEcbaNaqkhDqN1hKh33ucQklIWJ0hRXh0fGvvfDc54XVcUmBpEk3Ehf+Ld0CHERwe1Vvij6ck8j
 SqdpLh3o/buN4L8npBt6Ixt8Sy3OxxmoYBerWI5pc662Z3JpFvONz81F+n9n9AYVluEiruLMUbK
 KZ57ElRfXToqsUhMtEXihovLipyLTTFZSw/0AKFaYRKhOimhHGl7YD35z8uo/e7TXyCkLNVSaUh
 Dk4jPuwtK2vOL7h3Wcuf/g4pqJvOqddMoAOA/CJ+6xFtcBZD3ZkEdCODVqvrtXX+s8wCmbHvB5s
 /M5JC++4Yt6ondwHbnNvyDfbh/qdIzmvRzv+IzrfnD55945uBG30HTPxUOy8LAnpyJRql1Fff3Z
 eyhM/8ElFVWj5VdG9VbQqA8o+IsTNxOA==
X-Received: by 2002:a05:6000:2310:b0:435:a594:33dd with SMTP id
 ffacd0b85a97d-435f3aafeb2mr165515f8f.46.1769702991802; 
 Thu, 29 Jan 2026 08:09:51 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10edf62sm16762185f8f.13.2026.01.29.08.09.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 08:09:50 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 27/43] hw/arm/smmuv3: Block migration when accel is enabled
Date: Thu, 29 Jan 2026 16:09:01 +0000
Message-ID: <20260129160917.1415092-28-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260129160917.1415092-1-peter.maydell@linaro.org>
References: <20260129160917.1415092-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Shameer Kolothum <skolothumtho@nvidia.com>

Live migration is not supported when the SMMUv3 accelerator mode is
enabled. Add a migration blocker to prevent migration in this
configuration.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Message-id: 20260126104342.253965-28-skolothumtho@nvidia.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/smmuv3.c         | 6 ++++++
 include/hw/arm/smmuv3.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index e301bb467d..2be056d792 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -20,6 +20,7 @@
 #include "qemu/bitops.h"
 #include "hw/core/irq.h"
 #include "hw/core/sysbus.h"
+#include "migration/blocker.h"
 #include "migration/vmstate.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/core/qdev.h"
@@ -1925,6 +1926,11 @@ static void smmu_realize(DeviceState *d, Error **errp)
 
     if (s->accel) {
         smmuv3_accel_init(s);
+        error_setg(&s->migration_blocker, "Migration not supported with SMMUv3 "
+                   "accelerator mode enabled");
+        if (migrate_add_blocker(&s->migration_blocker, errp) < 0) {
+            return;
+        }
     }
 
     c->parent_realize(d, &local_err);
diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
index 5616a8a2be..9c39acd5ca 100644
--- a/include/hw/arm/smmuv3.h
+++ b/include/hw/arm/smmuv3.h
@@ -68,6 +68,7 @@ struct SMMUv3State {
     bool accel;
     struct SMMUv3AccelState *s_accel;
     uint64_t msi_gpa;
+    Error *migration_blocker;
 };
 
 typedef enum {
-- 
2.43.0


