Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81DACC7115B
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Jun 2025 07:46:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUhIz-0004PL-Fa; Thu, 26 Jun 2025 03:45:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uUhIx-0004Og-Iq
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 03:45:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uUhIq-0001vV-Vg
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 03:45:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750923948;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UIa3DkdPiYbEQRu+bEiCZZDWHR5v/uJ1aistawXdiBM=;
 b=UFU5jF+Jv9wnvEwdUFGUOuLdFymxymHgKJ+JMlJxCDK1S1RFVBKqAtm82XO9QbPtUXcyov
 FKHTdCBsw8b3kWJLf/zIqdtqHz2SAkJAo1kJ41Y50DlaU7nFnGKFvd0PyqOsuPexvtpQSm
 dnsMigx55B0XyLtmX+hne28XIl2Pqrw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-630-hoi7p12ROfSxZpSsb9b2Mw-1; Thu,
 26 Jun 2025 03:45:45 -0400
X-MC-Unique: hoi7p12ROfSxZpSsb9b2Mw-1
X-Mimecast-MFC-AGG-ID: hoi7p12ROfSxZpSsb9b2Mw_1750923944
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4A4DB1808985; Thu, 26 Jun 2025 07:45:44 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.51])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5A610180045B; Thu, 26 Jun 2025 07:45:42 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 John Levon <john.levon@nutanix.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 04/25] vfio: add license tag to some files
Date: Thu, 26 Jun 2025 09:45:08 +0200
Message-ID: <20250626074529.1384114-5-clg@redhat.com>
In-Reply-To: <20250626074529.1384114-1-clg@redhat.com>
References: <20250626074529.1384114-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: John Levon <john.levon@nutanix.com>

Add SPDX-License-Identifier to some files missing it in hw/vfio/.

Signed-off-by: John Levon <john.levon@nutanix.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250623093053.1495509-1-john.levon@nutanix.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/trace.h      | 3 +++
 hw/vfio/Kconfig      | 2 ++
 hw/vfio/meson.build  | 2 ++
 hw/vfio/trace-events | 2 ++
 4 files changed, 9 insertions(+)

diff --git a/hw/vfio/trace.h b/hw/vfio/trace.h
index 5a343aa59cc9b7aa76df9d900acbeec17a95f046..b34b61ddb285cedc250f35a2b77966b0d64e463b 100644
--- a/hw/vfio/trace.h
+++ b/hw/vfio/trace.h
@@ -1 +1,4 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
 #include "trace/trace-hw_vfio.h"
diff --git a/hw/vfio/Kconfig b/hw/vfio/Kconfig
index 7cdba0560aa821c88d3420b36f86020575834202..91d9023b79b594975c6c5f65273011b89240691c 100644
--- a/hw/vfio/Kconfig
+++ b/hw/vfio/Kconfig
@@ -1,3 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
 config VFIO
     bool
     depends on LINUX
diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
index 73d29f925ff5c668518698effc3e48cdf71c3a9a..63ea39307601cce4b0783766f68c4cf8d9af71f9 100644
--- a/hw/vfio/meson.build
+++ b/hw/vfio/meson.build
@@ -1,3 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
 vfio_ss = ss.source_set()
 vfio_ss.add(files(
   'listener.c',
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index f06236f37b72cc64868456be3a5a58fdb5beb829..e1728c4ef64acfc4a377dfc4711cad35c03a51b7 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -1,4 +1,6 @@
 # See docs/devel/tracing.rst for syntax documentation.
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
 
 # pci.c
 vfio_intx_interrupt(const char *name, char line) " (%s) Pin %c"
-- 
2.49.0


