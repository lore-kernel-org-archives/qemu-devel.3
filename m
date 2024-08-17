Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8351C52D7D
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Aug 2024 10:27:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sfGe4-0006kO-BJ; Sat, 17 Aug 2024 06:26:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3yXrAZgUKCvwxezmtksskpi.gsquiqy-hiziprsrkry.svk@flex--tavip.bounces.google.com>)
 id 1sfGdh-0006Ft-PT
 for qemu-devel@nongnu.org; Sat, 17 Aug 2024 06:26:30 -0400
Received: from mail-pg1-x54a.google.com ([2607:f8b0:4864:20::54a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3yXrAZgUKCvwxezmtksskpi.gsquiqy-hiziprsrkry.svk@flex--tavip.bounces.google.com>)
 id 1sfGdf-0003Fe-1v
 for qemu-devel@nongnu.org; Sat, 17 Aug 2024 06:26:29 -0400
Received: by mail-pg1-x54a.google.com with SMTP id
 41be03b00d2f7-6507e2f0615so2314246a12.1
 for <qemu-devel@nongnu.org>; Sat, 17 Aug 2024 03:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1723890378; x=1724495178; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=pXYuaLkVN9XEUa9twQAaD4EBLjrrL0bAtjxvWVUlbaE=;
 b=NCcfBAIwrq0tDVJbXrDEHlgH/qHVW4GWsNWj+F2oVsPK/mkAL0P3+Cx4u0hHnjct+C
 GgmCgviWg8StIzGwPpc8MVB0cYdA2ok/At6aPOUEcShFzT6m4+MvYbjYTNR/VkYybd5t
 ouScjseWkKYYRzA7Z9y+Eu+/jT3muk9VEonVnll4bdZvGSzaFXPoXoSJVp49y1OBWiKE
 2EVhWGuQ0wY1ePVIH6PERf9AaCBfNd/EQVnadKUluWFfAEfvJY3e5CchAUW0JB7B9iW0
 QSAQgvteqdnISD2IodphFbJVjUUlZkYSqx2BwK4Xsel+rSnpzFGen3w7FjcxIo7N0pMc
 4MaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723890378; x=1724495178;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pXYuaLkVN9XEUa9twQAaD4EBLjrrL0bAtjxvWVUlbaE=;
 b=YSxf5NVjX/tadRN2rnnxKPmMOFDqz43Pg3KSkl6EWgaQhopVPoZhHqOPa89v7VFHPU
 T6VPtRVhJZtJxblRwmPAEKkNhf5Azb7YZxHhy5MlJQEX/SQbk3usGG1r05kotMsxo8uT
 WBr3Te07lwZvTvjvN5pbjj7IecZn6WMtVpkEq3ddVmH+r1wFbQT2G6ezDWRFkT/46Zzm
 S2WFIEK8S6dgcvaAcEnG+SOoLS99jzKK4mOY2piEUru6IaYdMntYn+iK3Zc7aK3BX1tH
 xMfkgflnlixQ7ZnTt/I3c7BBRV2C36Nv4Qsn6ZFdfy4KbyVXqiDwzgdsLwkMlf26Qqra
 AeMA==
X-Gm-Message-State: AOJu0YyWMG7Jekuh0GracUoD8KfHY0W2JLIz1QCtOat/LvLEYXKEG+2g
 tLWWAlGp7HHhA6qTCB6+G6/nB2kHJfoUbnQN+lrNTNLFh4AEwsWUMUKZt0qsSQ3wPBZCHmYo4ri
 yeNnck4YuwJ4FxXsdv0OeNmhwOjwtfhSOGHYLhAvc0Wq7Gz9Rq8WJbmW9Kv6ws1dgFJOM9zTqIM
 65IwnZVp5jp2WKjjUWhWIxcSAvzw==
X-Google-Smtp-Source: AGHT+IH0T4nvwG2zPXbnPodUW9H0YDQr7bAHSGr09nZruSNQs/uB9gdIMpwCmTyVi+pJuDu4LWwy2UHIBA==
X-Received: from warp10.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:750])
 (user=tavip job=sendgmr) by 2002:a05:6a02:5a4:b0:718:da6:277e with
 SMTP id
 41be03b00d2f7-7c9790eb4demr9639a12.2.1723890377114; Sat, 17 Aug 2024 03:26:17
 -0700 (PDT)
Date: Sat, 17 Aug 2024 03:25:48 -0700
In-Reply-To: <20240817102606.3996242-1-tavip@google.com>
Mime-Version: 1.0
References: <20240817102606.3996242-1-tavip@google.com>
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
Message-ID: <20240817102606.3996242-6-tavip@google.com>
Subject: [RFC PATCH v2 05/23] hw: add register access utility functions
From: Octavian Purdila <tavip@google.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, stefanst@google.com, pbonzini@redhat.com, 
 thuth@redhat.com, peter.maydell@linaro.org, marcandre.lureau@redhat.com, 
 alistair@alistair23.me, berrange@redhat.com, philmd@linaro.org, 
 jsnow@redhat.com, crosa@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::54a;
 envelope-from=3yXrAZgUKCvwxezmtksskpi.gsquiqy-hiziprsrkry.svk@flex--tavip.bounces.google.com;
 helo=mail-pg1-x54a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
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

Add register access utility functions for device models, like checking
aligned access.

Signed-off-by: Octavian Purdila <tavip@google.com>
---
 include/hw/regs.h | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 include/hw/regs.h

diff --git a/include/hw/regs.h b/include/hw/regs.h
new file mode 100644
index 0000000000..692428af12
--- /dev/null
+++ b/include/hw/regs.h
@@ -0,0 +1,34 @@
+/*
+ * Useful macros/functions for register handling.
+ *
+ * Copyright (c) 2021 Google LLC
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef HW_REGS_H
+#define HW_REGS_H
+
+#include "exec/hwaddr.h"
+
+/*
+ * reg32_aligned_access
+ * @addr: address to check
+ * @size: size of access
+ *
+ * Check if access to a hardware address is 32bit aligned.
+ *
+ * Returns: true if access is 32bit aligned, false otherwise
+ */
+static inline bool reg32_aligned_access(hwaddr addr, unsigned size)
+{
+    if (size != 4 || addr % 4 != 0) {
+        return false;
+    }
+    return true;
+}
+
+#endif /* HW_REGS_H */
-- 
2.46.0.184.g6999bdac58-goog


