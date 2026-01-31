Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F34BDD46C1D
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Jan 2026 02:02:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vm0Ib-0007QR-Mk; Fri, 30 Jan 2026 21:01:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vm0IW-0007II-50
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 21:01:17 -0500
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vm0IR-0000UJ-6H
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 21:01:13 -0500
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-c2af7d09533so1656032a12.1
 for <qemu-devel@nongnu.org>; Fri, 30 Jan 2026 18:01:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769824869; x=1770429669; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FKrFbIzO+OqhM9EqMf1DvtMtDYxv5MFzwPEplnrkp6c=;
 b=ebIkOPXZviBxdLO3F0xbnQ0twAR+qJ82m3YHFQ5rP13aoPHQndd12MjkehRc4FNokp
 35m+uEwM3E7FiSsnVb9gsoWGnxTSNXIuwjz8cU09vKKXYC5VXJpV5GsoCR+m/G6fpTk4
 Zx87sc35WB6StKjyv+/37ek3RpYre/yq7r3+WZFMrxxsiGcaPORhqwJBam8ar4YNttME
 TKSkoG9CuJ/jYQtPvWDg96WAaVOnVkoPSZMA0+gyxzqFkHWFDl/9M4h7T5Pytk5tGfkm
 lIPgHp+iQyuEfLKhbnouG4f49oA4qj3L+umZYO4pSKZ1ISn+ug1SgEJA96hxboTHK587
 gxBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769824869; x=1770429669;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FKrFbIzO+OqhM9EqMf1DvtMtDYxv5MFzwPEplnrkp6c=;
 b=N0MDF3GIBOA/fneaX59Qpa1XuSqRUKbsuaByAwqyCzwLHhqEc/Sa7yMWRHwT+us63A
 XeuyBvAKyVwp3ogiQuV2f+2ieqa11Q3V5S1aXT1w9SyxTK59IejiPBOChl4oYV9p4q9X
 2xdINdIgsFnX22j+K2jb5+LWcGpFnfvNSAuRb5tLwjYfyKK+YO8Ukq04xRhALGtuLsXh
 6g1BmRMXCXtImw2Au0Dp6Mv5kYkB5B3XNo17GaOqCKyPwUrBUqmXArea2DladgaauAxA
 qIxcQvY/frxNhINKVHO/GHJ+BQ7K9M+3+x8BaIUFsYUir8yktgbrxPI+j4Tcqdkm/sWh
 artg==
X-Gm-Message-State: AOJu0YxahdjXf1aXHWkEJjLz8qwlqJTAeJLgmFuUyZzrU34OD7gZU0WE
 jprgWYwNqmKw57kCDPF3bacFEeiaEiWYiNObdtGXwpa5M8PlGvQgwPNxu21R9Wd44ydqiEBoioM
 Y9b22
X-Gm-Gg: AZuq6aL6mxKUh9hwR6mktTGpHPx7SoHqJRfCBJWELlc3PCw4+j/OcSG3fAlxAOJ8KEg
 WlZfxGFEwF7J36qpwzmjAt30y9dJrf7EdbGCrHaIThmXQArjMvRI9F3fO7dkuuaeG96Hy53SQWL
 5wKO/8rLdMmYPwSHHiMIFYLIFW1Z/VXqb40pjurBgbMTQwVtQk6mRtcaYXEpTau2/XtjlUqp0vj
 cV+LKHCIyKHxGfCKXWwoCyH+GUjVSyr4dH5pCWBX0nQH8QBEUACNpmLgZ9vcgvhVett2XIbJ0LL
 BG+z+Mm/oE+cTsRmHdUNGICsZfltuT9x0TKMCeMRvVg1IfdW/ly3/jDc3F4G3XHzUcJ+A8N6+5B
 nm9hWdJYzo6C5wk+Y/lmOgO6tjLVwLZ6247nJSdnDliJJ0ewF8ZuH43fcTjgQXb19k7InnaqIaz
 9I1+8E2DUMApBV7U8j01/0b23excWXV2tMq/5RKh8hsSZWDdEzRH0Szt9WLnw62kTj
X-Received: by 2002:a17:903:3bc3:b0:2a7:80bf:312e with SMTP id
 d9443c01a7336-2a8d991922amr51888845ad.28.1769824869079; 
 Fri, 30 Jan 2026 18:01:09 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a88b41390bsm84697975ad.23.2026.01.30.18.01.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jan 2026 18:01:08 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 3/6] include/hw/ppc/spapr: extract SPAPR_MAX_RAM_SLOTS in a
 new header
Date: Fri, 30 Jan 2026 18:00:57 -0800
Message-ID: <20260131020100.1115203-4-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260131020100.1115203-1-pierrick.bouvier@linaro.org>
References: <20260131020100.1115203-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52e.google.com
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

Allow to include it from common code (vhost-user, in next commit), else
it pulls ppc/cpu.h which has target specifics.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/hw/ppc/spapr.h        |  8 +-------
 include/hw/ppc/spapr_common.h | 16 ++++++++++++++++
 2 files changed, 17 insertions(+), 7 deletions(-)
 create mode 100644 include/hw/ppc/spapr_common.h

diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 5476ac7ce7b..b022f8dd25d 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -4,6 +4,7 @@
 #include "qemu/units.h"
 #include "system/dma.h"
 #include "hw/core/boards.h"
+#include "hw/ppc/spapr_common.h"
 #include "hw/ppc/spapr_drc.h"
 #include "hw/mem/pc-dimm.h"
 #include "hw/ppc/spapr_ovec.h"
@@ -946,13 +947,6 @@ int spapr_rtc_import_offset(SpaprRtcState *rtc, int64_t legacy_offset);
 
 #define SPAPR_MEMORY_BLOCK_SIZE ((hwaddr)1 << 28) /* 256MB */
 
-/*
- * This defines the maximum number of DIMM slots we can have for sPAPR
- * guest. This is not defined by sPAPR but we are defining it to 32 slots
- * based on default number of slots provided by PowerPC kernel.
- */
-#define SPAPR_MAX_RAM_SLOTS     32
-
 /* 1GB alignment for hotplug memory region */
 #define SPAPR_DEVICE_MEM_ALIGN (1 * GiB)
 
diff --git a/include/hw/ppc/spapr_common.h b/include/hw/ppc/spapr_common.h
new file mode 100644
index 00000000000..d799927ff5c
--- /dev/null
+++ b/include/hw/ppc/spapr_common.h
@@ -0,0 +1,16 @@
+/*
+ * Common definitions for PPC SPAPR
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_SPAPR_COMMON_H
+#define HW_SPAPR_COMMON_H
+
+/*
+ * This defines the maximum number of DIMM slots we can have for sPAPR
+ * guest. This is not defined by sPAPR but we are defining it to 32 slots
+ * based on default number of slots provided by PowerPC kernel.
+ */
+#define SPAPR_MAX_RAM_SLOTS     32
+
+#endif /* HW_SPAPR_COMMON_H */
-- 
2.47.3


