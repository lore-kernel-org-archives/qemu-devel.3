Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32B85EE6B69
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 22:20:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voUAg-00066x-BA; Fri, 06 Feb 2026 17:19:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1voUAd-00064A-MX
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 17:19:23 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1voUAb-0007C6-Ux
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 17:19:23 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-81f4ba336b4so2150332b3a.1
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 14:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770416360; x=1771021160; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FKrFbIzO+OqhM9EqMf1DvtMtDYxv5MFzwPEplnrkp6c=;
 b=j8ztdZ2AwAgLiS4tpFtziacHtW7A8c1p+vtHYSbHMDi8k5SqqWy50KmU2cRqcOuSVX
 h19hVBKUsNyrnv/E4qcb8HkGt8nL33JDnE73Rl82qbc3UGvJxYOtZsZR+0wDXaaKdS9i
 3S/PL1BIoYyL9ccmKGAMgt9lzCZTj0uu393c1vOmcuek2aGuAWeG3Z/RsZHXnsFOm1yF
 5gYKIhg7Ria2Tveqdgr116DyyHte59/h4w1laaFpbhZBvd3u1o7No4333+xDiKr/b39I
 NOvjS6laY4TR4+v+CJaR9hpz8D+ca5dw6f+Foqhjvz6YtFWCmKDxAxBgCuOVBt4EfgcP
 l2qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770416360; x=1771021160;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FKrFbIzO+OqhM9EqMf1DvtMtDYxv5MFzwPEplnrkp6c=;
 b=SrAkXPyIa6GawYJnx60qR9AvVNRQJD9zxGhyepL8sTJi4ENg/1xvLHY/ei/VNS7AAW
 Mrjy3T9E84CqVcN5yWc1V9YiSJsE6JlJmTPkZK3N8rOQbo+gjUoSf75ul+zJHMNm9iew
 hDleKf8dDu0p6fc53TqNctjYmEB4POYFiGbTAukOqlW/X9pwivWIAdap1W/M5LXQPCDe
 Y7EyXQSpsuelc9+kDzwS8q504di/Ps+WQEtFEkbCKn0ptqJP19C6OpYWYrjjukQ39Zuq
 QkaXeWh9jgERXqEwxRB0YGcrBW48e0W2MpAYbEyWH3dzks8zOg8JXLmVtSXBXwmAORzf
 cB5Q==
X-Gm-Message-State: AOJu0YxEzDR3qIdmW2uJfYg/0Afk+I1B6spQYLEdBLIEPnaAbNEevnHM
 4kHyCS+yNH+r6UbYjaDf3sSzP7bOsEniDM9YL92c59a2Sn2pjc0x6an+DxB1nZdAQ0ism13IleV
 HlZmG
X-Gm-Gg: AZuq6aKpjAT/9/Q1Dp8RpElF/udZQcqEnvtuV1iQkug1epbpq6ltAo4ZnTrkbF4UL7m
 L2ddGcDd6NotonfZBntMiv/cR59wCgTJrcVqq14oxq3mXpQMc+1LTpM5L+ba/NkD4VIdYxh71ue
 ijhX9OJPbigpT/B0PCb+NUaLL5Rkd3/yXGOD3ZP8S1sAM4GHSi+Fzmv8T/5wem+9r46scQWGbJT
 zEW5u8RXyD49arjJiiv4V6jkcGZyvaMLkAcW7CvxMLUrd/1yleRABRtAGOtXBgrWEeOTly4M3bX
 w+108qihVB1AcMYfuSYTjMhwXR8ml7R11ZUz3ab6lpBi0jK5TppItePSvFdlAUvzYDSxmLTToqd
 WArOAp+WrTXGrWgukqpdRwC4n8ota3m0fESuVApSfZU4YAiN5buTLeQG8xJ4rdhwcvU1eX9s+SO
 1ZsuL/7gjJlY3DeaPQArAC/FWDLcA9JexekTjqrH8PvN+r5/CkZdUO7sGyAhfpH5jB
X-Received: by 2002:a05:6a21:138f:b0:38d:f623:f876 with SMTP id
 adf61e73a8af0-393ad41a179mr3681972637.79.1770416360419; 
 Fri, 06 Feb 2026 14:19:20 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a95bff42f7sm13316575ad.68.2026.02.06.14.19.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Feb 2026 14:19:20 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, stefanha@redhat.com,
 richard.henderson@linaro.org, qemu-ppc@nongnu.org
Subject: [PATCH v5 6/9] include/hw/ppc/spapr: extract SPAPR_MAX_RAM_SLOTS in a
 new header
Date: Fri,  6 Feb 2026 14:19:05 -0800
Message-ID: <20260206221908.1451528-7-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260206221908.1451528-1-pierrick.bouvier@linaro.org>
References: <20260206221908.1451528-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x429.google.com
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


