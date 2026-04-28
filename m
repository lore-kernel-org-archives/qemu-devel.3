Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75723FF885A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 16:38:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHlR3-0004xx-36; Tue, 28 Apr 2026 12:37:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wHlR0-0004xI-P4
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 12:37:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wHlQx-0002NQ-7J
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 12:37:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777394233;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Kj25SlUsmmALKk+qbpeQMijTUk7XTBdfa7B7QV3dyMk=;
 b=YGLt/GrztQzoYG3r8XO4ZAF7sXMOAV8Fp12oyqFq2Ijj/vcmbW1NMGkFddb4MtKY6sSdG/
 RdUZWD3EuBJp2s/WCPbnmD/EhkBvVFgP4T9a43YkeHs3LxrYVSjYMOWtjCDdFZoMMiqTiP
 x2UC1DFnVQ7Sj01nSesOPhatQEKy+DU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-470-P8OMpp1lOviOWtNdeS59gA-1; Tue,
 28 Apr 2026 12:37:10 -0400
X-MC-Unique: P8OMpp1lOviOWtNdeS59gA-1
X-Mimecast-MFC-AGG-ID: P8OMpp1lOviOWtNdeS59gA_1777394228
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6893F195609E; Tue, 28 Apr 2026 16:37:08 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.74])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 59B22300756E; Tue, 28 Apr 2026 16:37:04 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>, Tomita Moeko <tomitamoeko@gmail.com>,
 qemu-trivial@nongnu.org
Subject: [PATCH] hw/vfio: Drop superfluous inclusion of hw-error.h
Date: Tue, 28 Apr 2026 18:37:02 +0200
Message-ID: <20260428163702.3224323-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.109,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

None of these files use the hw_error() function, so there is no
need to include hw-error.h here.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/vfio/device.c      | 1 -
 hw/vfio/helpers.c     | 1 -
 hw/vfio/igd.c         | 1 -
 hw/vfio/kvm-helpers.c | 1 -
 4 files changed, 4 deletions(-)

diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index 3ffd69a579b..ccf14743e95 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -24,7 +24,6 @@
 #include "hw/vfio/vfio-device.h"
 #include "hw/vfio/pci.h"
 #include "hw/core/iommu.h"
-#include "hw/core/hw-error.h"
 #include "trace.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
index 65c6dba0428..c719864b92f 100644
--- a/hw/vfio/helpers.c
+++ b/hw/vfio/helpers.c
@@ -24,7 +24,6 @@
 
 #include "exec/cpu-common.h"
 #include "hw/vfio/vfio-device.h"
-#include "hw/core/hw-error.h"
 #include "qapi/error.h"
 #include "vfio-helpers.h"
 
diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index 6aacf27284f..e091f21b6a3 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -16,7 +16,6 @@
 #include "qapi/error.h"
 #include "qapi/qmp/qerror.h"
 #include "hw/core/boards.h"
-#include "hw/core/hw-error.h"
 #include "hw/nvram/fw_cfg.h"
 #include "pci.h"
 #include "pci-quirks.h"
diff --git a/hw/vfio/kvm-helpers.c b/hw/vfio/kvm-helpers.c
index d71c9590aaa..5e73dddc418 100644
--- a/hw/vfio/kvm-helpers.c
+++ b/hw/vfio/kvm-helpers.c
@@ -25,7 +25,6 @@
 #include "system/kvm.h"
 #include "exec/cpu-common.h"
 #include "hw/vfio/vfio-device.h"
-#include "hw/core/hw-error.h"
 #include "qapi/error.h"
 #include "vfio-helpers.h"
 
-- 
2.53.0


