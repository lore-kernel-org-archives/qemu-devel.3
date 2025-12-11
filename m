Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03128D41C1F
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 10:55:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTeJd-0007B4-9c; Thu, 11 Dec 2025 05:54:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vTeJb-0007AF-Ux
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 05:54:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vTeJZ-0005WX-ME
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 05:54:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765450467;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0y1grwpoA0+nEr5YXdr7c7I9+H7VqtMhVFS456ToAXw=;
 b=LaASiDKoLIkw5mHOF/Kzs+QxXSFBvAt36S6FSZfOJhnfkAT0c57k2KBnBBjHZS45ZyVRcN
 6+GjGxM/1bJufW05fHtN74yVQvz1CJ0OxE57snmfez7dgBmHhEnN/vrJZadtHUEAHuTLsE
 xlCU7OMpbRS2RLLNixPXtoynld8gXRY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-49-aXRwuQIRN3iTPgg-IrJA0w-1; Thu,
 11 Dec 2025 05:54:24 -0500
X-MC-Unique: aXRwuQIRN3iTPgg-IrJA0w-1
X-Mimecast-MFC-AGG-ID: aXRwuQIRN3iTPgg-IrJA0w_1765450463
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CD9471956071; Thu, 11 Dec 2025 10:54:22 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.32.156])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1ED73180057E; Thu, 11 Dec 2025 10:54:22 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id E620918007A4; Thu, 11 Dec 2025 11:54:19 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Oliver Steffen <osteffen@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Luigi Leonardi <leonardi@redhat.com>
Subject: [PATCH v2 1/5] igvm: reorganize headers
Date: Thu, 11 Dec 2025 11:54:15 +0100
Message-ID: <20251211105419.3573449-2-kraxel@redhat.com>
In-Reply-To: <20251211105419.3573449-1-kraxel@redhat.com>
References: <20251211105419.3573449-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Add a new igvm-internal.h header file.  Structs and declarations which
depend on the igvm library header go into that file.

Also declare IgvmCfg in typedefs.h, so the type can be used without
including igvm header files.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/qemu/typedefs.h        |  1 +
 include/system/igvm-cfg.h      | 12 +-----------
 include/system/igvm-internal.h | 26 ++++++++++++++++++++++++++
 include/system/igvm.h          |  2 +-
 backends/igvm-cfg.c            |  4 +++-
 backends/igvm.c                |  2 ++
 6 files changed, 34 insertions(+), 13 deletions(-)
 create mode 100644 include/system/igvm-internal.h

diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index 4a94af9665a5..416a8c9acead 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -55,6 +55,7 @@ typedef struct FWCfgState FWCfgState;
 typedef struct HostMemoryBackend HostMemoryBackend;
 typedef struct I2CBus I2CBus;
 typedef struct I2SCodec I2SCodec;
+typedef struct IgvmCfg IgvmCfg;
 typedef struct IOMMUMemoryRegion IOMMUMemoryRegion;
 typedef struct ISABus ISABus;
 typedef struct ISADevice ISADevice;
diff --git a/include/system/igvm-cfg.h b/include/system/igvm-cfg.h
index 944f23a814dd..6c07f3084082 100644
--- a/include/system/igvm-cfg.h
+++ b/include/system/igvm-cfg.h
@@ -12,19 +12,9 @@
 #ifndef QEMU_IGVM_CFG_H
 #define QEMU_IGVM_CFG_H
 
+#include "qemu/typedefs.h"
 #include "qom/object.h"
 
-typedef struct IgvmCfg {
-    ObjectClass parent_class;
-
-    /*
-     * filename: Filename that specifies a file that contains the configuration
-     *           of the guest in Independent Guest Virtual Machine (IGVM)
-     *           format.
-     */
-    char *filename;
-} IgvmCfg;
-
 typedef struct IgvmCfgClass {
     ObjectClass parent_class;
 
diff --git a/include/system/igvm-internal.h b/include/system/igvm-internal.h
new file mode 100644
index 000000000000..475a29bbf3d7
--- /dev/null
+++ b/include/system/igvm-internal.h
@@ -0,0 +1,26 @@
+/*
+ * QEMU IGVM private data structures
+ *
+ * Everything which depends on igvm library headers goes here.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef QEMU_IGVM_INTERNAL_H
+#define QEMU_IGVM_INTERNAL_H
+
+#include "qemu/typedefs.h"
+#include "qom/object.h"
+
+struct IgvmCfg {
+    ObjectClass parent_class;
+
+    /*
+     * filename: Filename that specifies a file that contains the configuration
+     *           of the guest in Independent Guest Virtual Machine (IGVM)
+     *           format.
+     */
+    char *filename;
+};
+
+#endif
diff --git a/include/system/igvm.h b/include/system/igvm.h
index 48ce20604259..8355e54e95fc 100644
--- a/include/system/igvm.h
+++ b/include/system/igvm.h
@@ -12,8 +12,8 @@
 #ifndef BACKENDS_IGVM_H
 #define BACKENDS_IGVM_H
 
+#include "qemu/typedefs.h"
 #include "system/confidential-guest-support.h"
-#include "system/igvm-cfg.h"
 #include "qapi/error.h"
 
 int qigvm_process_file(IgvmCfg *igvm, ConfidentialGuestSupport *cgs,
diff --git a/backends/igvm-cfg.c b/backends/igvm-cfg.c
index d00acf351249..001c4dc93346 100644
--- a/backends/igvm-cfg.c
+++ b/backends/igvm-cfg.c
@@ -11,8 +11,10 @@
 
 #include "qemu/osdep.h"
 
-#include "system/igvm-cfg.h"
 #include "system/igvm.h"
+#include "system/igvm-cfg.h"
+#include "system/igvm-internal.h"
+#include "system/reset.h"
 #include "qom/object_interfaces.h"
 
 static char *get_igvm(Object *obj, Error **errp)
diff --git a/backends/igvm.c b/backends/igvm.c
index 905bd8d98994..fbb8300b6d01 100644
--- a/backends/igvm.c
+++ b/backends/igvm.c
@@ -14,6 +14,8 @@
 #include "qapi/error.h"
 #include "qemu/target-info-qapi.h"
 #include "system/igvm.h"
+#include "system/igvm-cfg.h"
+#include "system/igvm-internal.h"
 #include "system/memory.h"
 #include "system/address-spaces.h"
 #include "hw/core/cpu.h"
-- 
2.52.0


