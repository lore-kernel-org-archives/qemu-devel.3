Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C66D7C5B559
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 10:20:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uN7dr-0007NW-Ka; Thu, 05 Jun 2025 06:16:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uN7dg-0007KC-K4
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 06:16:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uN7df-0001F3-4t
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 06:16:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749118558;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ucBnDbok7v6Mu7KPseGvFTjV3duwh5RlIILFahRdtRA=;
 b=cmR6x2Fd0gacyqxuzgS4+BgUHS6Kq3I0qKMFx0TXHdy0/iQoyh6mFMupITVV0Ks86MKJv/
 DAfdXnkRBy7q7Dd/TGZygQYQEIvIctvur0n0SdpC+HW8Yi0s/qwp/0PxgSnN3EY+IcM/9a
 8ne7KmVRp4kZDON6edPjIphx/M96Pw0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-2-ET0z6OSON9ee-EVnWioRbw-1; Thu, 05 Jun 2025 06:15:57 -0400
X-MC-Unique: ET0z6OSON9ee-EVnWioRbw-1
X-Mimecast-MFC-AGG-ID: ET0z6OSON9ee-EVnWioRbw_1749118556
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a4f6ba526eso505765f8f.1
 for <qemu-devel@nongnu.org>; Thu, 05 Jun 2025 03:15:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749118555; x=1749723355;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ucBnDbok7v6Mu7KPseGvFTjV3duwh5RlIILFahRdtRA=;
 b=i4Ouwm0/cGLZS+75YPi8jBJFvxY/Hw53iruAmMea+MXEbOFABYGKEY4OmbYpgbvoRH
 /g8RjeC3ZVKy1FzQPYwRNtPPIXHn4F01enRd8cspoAEge00Jt+Yrw2L017wGU+eNAS+J
 Vk4ipH582EvqaPJYZJ73PlIE595jepyjfISPgez94wawd0ZmgOQXakAlefh8lZxnw7Kk
 wXi5hZiGVMgLCg7IiX+uXZOw7EglW10p+Gjy11IzxfL54rAHr2k+HdmSBSQs4jSo6JEU
 IisFvQ1cb1NSqnhqOWYrjPVDBARGTPrPYDsY6BcQ9SW+M54rL5yTBKuqAoDvAgUIE0/b
 erFA==
X-Gm-Message-State: AOJu0YwSBKAUaiP3iuUfTaHKuBEiadKgxSkkrQ2VPfTsZ2dfn9gtCUD/
 TNXk3Ph1M8Vpdq0GYuj0eixzhoSshFxOiMgjtcQI+aAZ8LJz/6LvhedHPZGVzOeI+8RfC9pDLQ/
 itBFnmFY75VL45ldrj5X+DtFZ2qZHNdoXh9otVcmpEEvkPCzmT0aiuuqVV5ov3wg89KpS3PhJHD
 OdGw9tK6923UCbp7UTI3pCDj8ixCS0EfDst7690/M7
X-Gm-Gg: ASbGncsYE74KT1FUTMOdUHeTkgEIuJn6jkg8yD9XVDjR2UZbeudu8W9iNfzXsK0G1Dq
 DWFy6oBhqS1FDVX5iqrOWqYDUw9IirvEqs4rg7TKp/33OuC5ZCz+kjSFT1hTo0nkPybVZvYjWe1
 ZbSbExEz053wjlQ5jTC1uxqUea3tbG+Yk6ivmiUgj2Xx5vFAAGeZ/pgz56GGdS2lmgpjSVGgcZn
 covyZeWnuATAD3l/SoMM1v40muYRKVl0kcfdT3yX72CwGaXjFDO1wpAY8xCWoTk72htz2wNEd4B
 cDK8Bxgm3+H/rQ==
X-Received: by 2002:a5d:64ca:0:b0:3a5:2ef8:3512 with SMTP id
 ffacd0b85a97d-3a52ef83894mr5001f8f.14.1749118555009; 
 Thu, 05 Jun 2025 03:15:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFo1SKYt/CPB3qSBN3ROsyBgLxh6ojXulfyhdCgyh25NH7rh/OT6u/Oi/6im8XTguM7x//2mQ==
X-Received: by 2002:a5d:64ca:0:b0:3a5:2ef8:3512 with SMTP id
 ffacd0b85a97d-3a52ef83894mr4976f8f.14.1749118554541; 
 Thu, 05 Jun 2025 03:15:54 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-451f97f797bsm20457775e9.1.2025.06.05.03.15.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Jun 2025 03:15:52 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com,
	zhao1.liu@intel.com,
	qemu-rust@nongnu.org
Subject: [PATCH 03/14] util/error: expose Error definition to Rust code
Date: Thu,  5 Jun 2025 12:15:32 +0200
Message-ID: <20250605101544.368953-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250605101544.368953-1-pbonzini@redhat.com>
References: <20250605101544.368953-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


