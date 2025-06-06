Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46780C61CE8
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 12:42:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNWHv-0002T9-Sh; Fri, 06 Jun 2025 08:35:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uNWHr-0002QY-Bm
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 08:35:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uNWHp-0005dG-09
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 08:35:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749213302;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ucBnDbok7v6Mu7KPseGvFTjV3duwh5RlIILFahRdtRA=;
 b=RrWv9Xsh/CEzAHxzzx7xZl64YKDPOaNIb72OPPihT75GJ5PJH5NrFn6yIyrctIAy7ECUZS
 psn6yTdPGJgxPjDMQdxEyKGofo+LCOP9B1JSfH0y0mGmyQpl3w1Bf9Xq+NU+7wz8EtG35P
 YEZMqUUn7l8lWLIcKuv+MG6mPgzpsg8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-375-uGSd6W-4M6GfS5KEoQSNGw-1; Fri, 06 Jun 2025 08:35:01 -0400
X-MC-Unique: uGSd6W-4M6GfS5KEoQSNGw-1
X-Mimecast-MFC-AGG-ID: uGSd6W-4M6GfS5KEoQSNGw_1749213300
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-451e24dfe1dso16465635e9.0
 for <qemu-devel@nongnu.org>; Fri, 06 Jun 2025 05:35:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749213300; x=1749818100;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ucBnDbok7v6Mu7KPseGvFTjV3duwh5RlIILFahRdtRA=;
 b=LxnMWOe6nYOz6S6zEvB2tDnpNLvm5hEkFm9I3c2MsSfu9iE3XrGheskcuIje9JcVOe
 qAQ+DGFC9bHQxH6ie/AkVPie3cg5bDsU5GItQD8ZMwdw+/C7kyPdlNllEEG2rGi7V6Sl
 dkvmASiGcyGJ27mmUzHZIpujUK+YznAntFomIy3i0nvjpSn5D5ngrz63MIF+rR9M7XgL
 GsPjV7U3NTLMQFroyTyFCaN1n9/YbcrOuer15WAdZSsJEoiyELDy9w0/suIMGqSIYuz5
 eQqDDsiojUd+BsYEP8mn0v0PBiWaGCfOg8+zDWuoTYwWus9k9mRnO0+eAsg0LWFHxHEw
 CKuw==
X-Gm-Message-State: AOJu0YwaeolonH6pnC4ybIzBiixRAylt8rGdYgijlxkzcU1ezezZ/TZn
 onuO39Rd0jLqliGM2UkBn4bVkRqxf5+xlk6ovbb70a73GULCmnPCk8B+pUjYubTsctE+vaMQIxs
 bU04pLLrr39NzbBVF7wyRA9KeXi5XUjAj6OZZAO8TAU9txmzb/L/6IaGAH9Dy/r3HFLqlgjULji
 nTFamxqOtEJhpWrnYH3eGwgIuCmvLizJZJlAxllClo
X-Gm-Gg: ASbGncs1jYo85671NGoN4kdn/FO3GIVpmBVkauNXcPtfDkb2bIjmDCtAEyXldAtO41F
 SfldSCf/0wd2eUohqrJZnKuTJksfHKnJnxjvlaZq7YvlaHxd/CEKr3ah4yldknnTn5q3khKhIIm
 aSm9kTKNU2PZiZjtb1v70QFLfxRtqyE4/nvQw9lA6wl7ca7c7Wp+Y6TuKrnI07Um4BK3x/5u1ls
 1zbJOM4IlVik9qv53s572tETC0USatE8vN5LlDhckZsKRGBFI1lGXSE10n9d18QX6B4oYryMBkN
 KPBxyacdk6tRTQ==
X-Received: by 2002:a05:600c:1909:b0:442:cd03:3e2 with SMTP id
 5b1f17b1804b1-45201437a77mr37750875e9.2.1749213299832; 
 Fri, 06 Jun 2025 05:34:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/Grsk6/PFJ/noJL+P4cP/Gu1gNswRy5VULEKnHCuVU90SO2t5ZvOfS8DDQ8BlJDnh8/FdXg==
X-Received: by 2002:a05:600c:1909:b0:442:cd03:3e2 with SMTP id
 5b1f17b1804b1-45201437a77mr37750625e9.2.1749213299260; 
 Fri, 06 Jun 2025 05:34:59 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a5323ae183sm1802889f8f.32.2025.06.06.05.34.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Jun 2025 05:34:57 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 03/31] util/error: expose Error definition to Rust code
Date: Fri,  6 Jun 2025 14:34:17 +0200
Message-ID: <20250606123447.538131-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250606123447.538131-1-pbonzini@redhat.com>
References: <20250606123447.538131-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This is used to preserve the file and line in a roundtrip from
C Error to Rust and back to C.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qapi/error-internal.h | 26 ++++++++++++++++++++++++++
 rust/wrapper.h                |  1 +
 util/error.c                  | 10 +---------
 3 files changed, 28 insertions(+), 9 deletions(-)
 create mode 100644 include/qapi/error-internal.h

diff --git a/include/qapi/error-internal.h b/include/qapi/error-internal.h
new file mode 100644
index 00000000000..d5c3904adec
--- /dev/null
+++ b/include/qapi/error-internal.h
@@ -0,0 +1,26 @@
+/*
+ * QEMU Error Objects - struct definition
+ *
+ * Copyright IBM, Corp. 2011
+ * Copyright (C) 2011-2015 Red Hat, Inc.
+ *
+ * Authors:
+ *  Anthony Liguori   <aliguori@us.ibm.com>
+ *  Markus Armbruster <armbru@redhat.com>,
+ *
+ * This work is licensed under the terms of the GNU LGPL, version 2.  See
+ * the COPYING.LIB file in the top-level directory.
+ */
+
+#ifndef QAPI_ERROR_INTERNAL_H
+
+struct Error
+{
+    char *msg;
+    ErrorClass err_class;
+    const char *src, *func;
+    int line;
+    GString *hint;
+};
+
+#endif
diff --git a/rust/wrapper.h b/rust/wrapper.h
index beddd9aab2f..6060d3ba1ab 100644
--- a/rust/wrapper.h
+++ b/rust/wrapper.h
@@ -60,6 +60,7 @@ typedef enum memory_order {
 #include "hw/qdev-properties-system.h"
 #include "hw/irq.h"
 #include "qapi/error.h"
+#include "qapi/error-internal.h"
 #include "migration/vmstate.h"
 #include "chardev/char-serial.h"
 #include "exec/memattrs.h"
diff --git a/util/error.c b/util/error.c
index 673011b89e9..e5bcb7c0225 100644
--- a/util/error.c
+++ b/util/error.c
@@ -15,15 +15,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
-
-struct Error
-{
-    char *msg;
-    ErrorClass err_class;
-    const char *src, *func;
-    int line;
-    GString *hint;
-};
+#include "qapi/error-internal.h"
 
 Error *error_abort;
 Error *error_fatal;
-- 
2.49.0


