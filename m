Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B026083622
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 13:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=axQlx6tl
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOEfP-0003oQ-2V; Tue, 03 Nov 2026 08:35:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xOEfN-0003o1-U8
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 08:35:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xOEfL-0006EQ-9e
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 08:35:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793712906;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oDoxwrgcbjMVR5LQ9PrcjIus2yk3AbEUb/8t9LqXqDE=;
 b=axQlx6tlnuMqhu0R0JfOAc+zWmbssRohViOjBeR8gLqOFjMp+64B4RiczhmZxheVwlMLGp
 DywCwCUOoQu+HjMas8c9I9ZSsGt2r1mRkxaLpiCfc9eBCFhVncIjrQVRhRNaquqgoc13/Q
 tChQ7BvGEK2yRC0Ukuq1of7DtO1jNdo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-398-izl3t-fJPiaCoARDnRObAA-1; Tue,
 03 Nov 2026 08:35:04 -0500
X-MC-Unique: izl3t-fJPiaCoARDnRObAA-1
X-Mimecast-MFC-AGG-ID: izl3t-fJPiaCoARDnRObAA_1793712903
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CC885195606F
 for <qemu-devel@nongnu.org>; Tue,  3 Nov 2026 13:35:03 +0000 (UTC)
Received: from pbonzini-thinkpadx1carbon6th.rmtit.csb
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2631D1955F73
 for <qemu-devel@nongnu.org>; Tue,  3 Nov 2026 13:35:02 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 09/10] include: introduce qemu/version.h
Date: Tue,  3 Nov 2026 14:35:00 +0100
Message-ID: <20261103133500.2295582-2-pbonzini@redhat.com>
In-Reply-To: <20261103133500.2295582-1-pbonzini@redhat.com>
References: <20261103133500.2295582-1-pbonzini@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In preparation for moving some of the qemu-version.sh logic to meson
and the preprocessor, create a wrapper header for the generated
qemu-version.h.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qemu/version.h               | 12 ++++++++++++
 bsd-user/main.c                      |  2 +-
 linux-user/main.c                    |  2 +-
 monitor/qmp-cmds-control.c           |  2 +-
 qemu-img.c                           |  2 +-
 qemu-io.c                            |  2 +-
 qemu-nbd.c                           |  2 +-
 qga/main.c                           |  2 +-
 scsi/qemu-pr-helper.c                |  2 +-
 storage-daemon/qemu-storage-daemon.c |  2 +-
 system/vl.c                          |  2 +-
 tools/i386/qemu-vmsr-helper.c        |  3 +--
 tools/qemu-vnc/qemu-vnc.c            |  2 +-
 util/module.c                        |  2 +-
 ui/cocoa.m                           |  2 +-
 15 files changed, 26 insertions(+), 15 deletions(-)
 create mode 100644 include/qemu/version.h

diff --git a/include/qemu/version.h b/include/qemu/version.h
new file mode 100644
index 00000000000..38405495c0e
--- /dev/null
+++ b/include/qemu/version.h
@@ -0,0 +1,12 @@
+/*
+ * QEMU version strings
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef QEMU_VERSION_H
+#define QEMU_VERSION_H
+
+#include "qemu-version.h"
+
+#endif
diff --git a/bsd-user/main.c b/bsd-user/main.c
index 29ee59de2cf..6720dbde6f8 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -25,7 +25,7 @@
 #include "qemu/help-texts.h"
 #include "qemu/units.h"
 #include "qemu/accel.h"
-#include "qemu-version.h"
+#include "qemu/version.h"
 #include <machine/trap.h>
 
 #include "qapi/error.h"
diff --git a/linux-user/main.c b/linux-user/main.c
index 60a695b7ca3..2f0c0a50c8a 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -21,7 +21,7 @@
 #include "qemu/help-texts.h"
 #include "qemu/units.h"
 #include "qemu/accel.h"
-#include "qemu-version.h"
+#include "qemu/version.h"
 #include <sys/syscall.h>
 #include <sys/resource.h>
 #include <sys/shm.h>
diff --git a/monitor/qmp-cmds-control.c b/monitor/qmp-cmds-control.c
index 8fe0876a3da..bc938712f3d 100644
--- a/monitor/qmp-cmds-control.c
+++ b/monitor/qmp-cmds-control.c
@@ -25,7 +25,7 @@
 #include "qemu/osdep.h"
 
 #include "monitor-internal.h"
-#include "qemu-version.h"
+#include "qemu/version.h"
 #include "qapi/compat-policy.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-control.h"
diff --git a/qemu-img.c b/qemu-img.c
index edf75e43aba..766d8540bfe 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -27,7 +27,7 @@
 
 #include "qemu/help-texts.h"
 #include "qemu/qemu-progress.h"
-#include "qemu-version.h"
+#include "qemu/version.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-block-core.h"
 #include "qapi/qapi-visit-block-core.h"
diff --git a/qemu-io.c b/qemu-io.c
index 598d5b1c9ca..b5f2ae631a4 100644
--- a/qemu-io.c
+++ b/qemu-io.c
@@ -34,7 +34,7 @@
 #include "block/block_int.h"
 #include "trace/control.h"
 #include "crypto/init.h"
-#include "qemu-version.h"
+#include "qemu/version.h"
 
 #define CMD_NOFILE_OK   0x01
 
diff --git a/qemu-nbd.c b/qemu-nbd.c
index fa28609d7dc..4f7e965edba 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -46,7 +46,7 @@
 #include "crypto/init.h"
 #include "crypto/tlscreds.h"
 #include "trace/control.h"
-#include "qemu-version.h"
+#include "qemu/version.h"
 
 #ifdef CONFIG_SELINUX
 #include <selinux/selinux.h>
diff --git a/qga/main.c b/qga/main.c
index fd19c7037db..06358cb213c 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -30,7 +30,7 @@
 #include "qemu/help_option.h"
 #include "qemu/sockets.h"
 #include "qemu/systemd.h"
-#include "qemu-version.h"
+#include "qemu/version.h"
 #ifdef _WIN32
 #include <windows.h>
 #include <objbase.h>
diff --git a/scsi/qemu-pr-helper.c b/scsi/qemu-pr-helper.c
index 1f97a5c4bfe..7629f364045 100644
--- a/scsi/qemu-pr-helper.c
+++ b/scsi/qemu-pr-helper.c
@@ -50,7 +50,7 @@
 #include "qobject/qstring.h"
 #include "io/channel-socket.h"
 #include "trace/control.h"
-#include "qemu-version.h"
+#include "qemu/version.h"
 
 #include "block/thread-pool.h"
 
diff --git a/storage-daemon/qemu-storage-daemon.c b/storage-daemon/qemu-storage-daemon.c
index 50dbfbd97ae..b2e29f00054 100644
--- a/storage-daemon/qemu-storage-daemon.c
+++ b/storage-daemon/qemu-storage-daemon.c
@@ -43,7 +43,7 @@
 #include "qapi/qobject-input-visitor.h"
 
 #include "qemu/help-texts.h"
-#include "qemu-version.h"
+#include "qemu/version.h"
 #include "qemu/cutils.h"
 #include "qemu/config-file.h"
 #include "qemu/error-report.h"
diff --git a/system/vl.c b/system/vl.c
index 7ae6a8298fc..e7b759d5442 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -37,7 +37,7 @@
 #include "qobject/qdict.h"
 #include "qobject/qstring.h"
 #include "qobject/qjson.h"
-#include "qemu-version.h"
+#include "qemu/version.h"
 #include "qemu/cutils.h"
 #include "qemu/help_option.h"
 #include "qemu/hw-version.h"
diff --git a/tools/i386/qemu-vmsr-helper.c b/tools/i386/qemu-vmsr-helper.c
index f12fd3c3e81..fac7fbe6b61 100644
--- a/tools/i386/qemu-vmsr-helper.c
+++ b/tools/i386/qemu-vmsr-helper.c
@@ -34,7 +34,7 @@
 #include "qemu/module.h"
 #include "qemu/error-report.h"
 #include "qemu/config-file.h"
-#include "qemu-version.h"
+#include "qemu/version.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qemu/log.h"
@@ -42,7 +42,6 @@
 #include "io/channel.h"
 #include "io/channel-socket.h"
 #include "trace/control.h"
-#include "qemu-version.h"
 #include "rapl-msr-index.h"
 
 #define MSR_PATH_TEMPLATE "/dev/cpu/%u/msr"
diff --git a/tools/qemu-vnc/qemu-vnc.c b/tools/qemu-vnc/qemu-vnc.c
index c915589ca7e..a668f3f734d 100644
--- a/tools/qemu-vnc/qemu-vnc.c
+++ b/tools/qemu-vnc/qemu-vnc.c
@@ -15,7 +15,7 @@
 #include "qemu/option.h"
 #include "qemu/log.h"
 #include "qemu/main-loop.h"
-#include "qemu-version.h"
+#include "qemu/version.h"
 #include "ui/vnc.h"
 #include "crypto/secret.h"
 #include "crypto/tlscredsx509.h"
diff --git a/util/module.c b/util/module.c
index 8f8e6994f11..6de9ff2e411 100644
--- a/util/module.c
+++ b/util/module.c
@@ -23,7 +23,7 @@
 #include "qemu/config-file.h"
 #include "qapi/error.h"
 #ifdef CONFIG_MODULE_UPGRADES
-#include "qemu-version.h"
+#include "qemu/version.h"
 #endif
 #include "trace.h"
 
diff --git a/ui/cocoa.m b/ui/cocoa.m
index 4587547c98c..36a72d36238 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -44,7 +44,7 @@
 #include "qapi/qapi-commands-machine.h"
 #include "qapi/qapi-commands-misc.h"
 #include "system/blockdev.h"
-#include "qemu-version.h"
+#include "qemu/version.h"
 #include "qemu/cutils.h"
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
-- 
2.56.0


