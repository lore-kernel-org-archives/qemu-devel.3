Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEBFFC54FB3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 14:28:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJYlt-0003Ex-QV; Mon, 26 May 2025 10:25:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uJYlN-0002ul-Jn
 for qemu-devel@nongnu.org; Mon, 26 May 2025 10:25:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uJYlK-0007qA-Fv
 for qemu-devel@nongnu.org; Mon, 26 May 2025 10:25:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748269509;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ucBnDbok7v6Mu7KPseGvFTjV3duwh5RlIILFahRdtRA=;
 b=bxB1hSDgag3OTURYoqRcw7BzZvCJLZkcv9P14y4OqjfZ1rSUso0ZYgmwIG3jc4khfXK9mq
 eNJ+Xn0HXak2/e7+yfDLXjyuEhSxorXX6DbPM+cGgnB6BMOxYXg0wwl23gm9vxlSGuFYPB
 6VFt1BH2kegZEB9Qu6Fvd+fgLSJ9+Tw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-539-4QdVIxRjPTus1MlpgY1ULg-1; Mon, 26 May 2025 10:25:08 -0400
X-MC-Unique: 4QdVIxRjPTus1MlpgY1ULg-1
X-Mimecast-MFC-AGG-ID: 4QdVIxRjPTus1MlpgY1ULg_1748269507
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-44b1f5b91c1so17453505e9.1
 for <qemu-devel@nongnu.org>; Mon, 26 May 2025 07:25:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748269506; x=1748874306;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ucBnDbok7v6Mu7KPseGvFTjV3duwh5RlIILFahRdtRA=;
 b=ipG1jyV8/OqRWZ/Mp4z+N2QIL0S7O/SKgKjcczz8P13m1wTBVotRFH59Nz9xO//aJz
 qKKEMsOBPzs3U2qBstI2OLkdO4bvjT+5QzStMQARapGDMG4PTt+KwnUO3dInsd41KZ17
 cGu07aB8u5XsaMraz+SVU9hjg7UIqdEMa9c36vmdph35cvo13UroVU24Sv0rSE09Fscn
 jAwRD9Bn9Xco/P+BkwsX3fP8oWs/FVWlJop2F+kovveXYbVIBbJWxpw7cxUXonRfgvEQ
 3P310jqITZg76W7/MKjo+DgZakXYy29obbuZOUwu8lBg1XgRIt0mEmd3kIY8Zz2+FksV
 1L4Q==
X-Gm-Message-State: AOJu0YwnmvLormza6ZtK9k/VXJwgd4gdKVFAJk9wX4GY7zJxVtGTnfzM
 niU9OUS8ZTcCkEzm0G9wYVjpuIJl31W03G7d99Akx9O0Gdksfv05uvRYdx6kGm9wLg5nymyhAit
 YLXprP4Rkb6H+8fpGrPDdjDGrI6VOvl0/9pOZqXPbxbF5JnzWr57QJrVizk+qzmjumC6N9GlwjA
 bgxLF+SGh+MLxFKInzusyRbhXNApy1Lwj/6CYzofxG
X-Gm-Gg: ASbGnctBiJ8rvv5HhDHSvx/klAmuKpS9Q139623IeVJiqV6dtMdoc+Go8NDSo+HzCiq
 Gpt7m03E5KOYdv3wX8KDDJrb0re3sN1UHqYlaYUjUbUyn5t1ZqIMuEn4VLkgNqoryPO7C+bKD3F
 kMFVFJSP+/2OjzEmDX8YhrcaKTqaJbYtzdtDMGsLhjvAAbhmU+F4RuQSY9MPsKPXG7rUUco6WGw
 sifyT+8Om66GM2wiSgMdRM6HR+IXJF7Ia5k/v5m+/4tVhNa72NmtMuKwVoXHmDjZedoAeqtl5tO
 rX9ZpHXgFO4Nuw==
X-Received: by 2002:a05:600c:1d0d:b0:43c:f44c:72a6 with SMTP id
 5b1f17b1804b1-44c9160702fmr93560335e9.2.1748269506421; 
 Mon, 26 May 2025 07:25:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFF4prXa7demfxOifhhcdzpzGpK3l+oYECeyNWEqlGlLWMYhrm6WWLfbf5CyRl6gHIbHjLr/g==
X-Received: by 2002:a05:600c:1d0d:b0:43c:f44c:72a6 with SMTP id
 5b1f17b1804b1-44c9160702fmr93560005e9.2.1748269505868; 
 Mon, 26 May 2025 07:25:05 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.46.79])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4c8455e7dsm8965827f8f.9.2025.05.26.07.25.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 May 2025 07:25:04 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com,
	qemu-rust@nongnu.org
Subject: [PATCH 04/12] util/error: expose Error definition to Rust code
Date: Mon, 26 May 2025 16:24:47 +0200
Message-ID: <20250526142455.1061519-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250526142254.1061009-1-pbonzini@redhat.com>
References: <20250526142254.1061009-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.903,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


