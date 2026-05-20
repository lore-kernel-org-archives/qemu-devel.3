Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCB59CD5BAA
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 16:22:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPjgI-0006Kt-H0; Wed, 20 May 2026 12:22:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wPjfu-0005qe-OK
 for qemu-devel@nongnu.org; Wed, 20 May 2026 12:21:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wPjfm-0008UJ-9u
 for qemu-devel@nongnu.org; Wed, 20 May 2026 12:21:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779294087;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YF5aWONhslK61UxnSzkuh8Pk2hNGcw48dh3ZUZxcAis=;
 b=DvL0rxhVE+g7ISuoffOXNql1iN07SNc25doZr/Obdakaqm/FsQXdrP/Nx492PM0WBFZFaq
 GuOcYP5p2oXeAzR8un4errcW+JeDy98RUUjv4bxIDmBnX9OcCjdb6/iDGQhKWfPFAnlDFL
 /HCZUlMNT2SiHEd076NcbiAty92YdWk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-584-8_MsUdJJNr6BRU6EherKvA-1; Wed,
 20 May 2026 12:21:25 -0400
X-MC-Unique: 8_MsUdJJNr6BRU6EherKvA-1
X-Mimecast-MFC-AGG-ID: 8_MsUdJJNr6BRU6EherKvA_1779294084
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 50CBC1956080; Wed, 20 May 2026 16:21:24 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.34.136])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8F82A19560A2; Wed, 20 May 2026 16:21:22 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 02/11] hw/vfio: Drop superfluous inclusion of hw-error.h
Date: Wed, 20 May 2026 18:21:06 +0200
Message-ID: <20260520162115.1613601-3-clg@redhat.com>
In-Reply-To: <20260520162115.1613601-1-clg@redhat.com>
References: <20260520162115.1613601-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/20260428163702.3224323-1-thuth@redhat.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/device.c      | 1 -
 hw/vfio/helpers.c     | 1 -
 hw/vfio/igd.c         | 1 -
 hw/vfio/kvm-helpers.c | 1 -
 4 files changed, 4 deletions(-)

diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index 3ffd69a579b8ac135ef729d3d836c8545e36786b..ccf14743e954bdf23b76d4e4c3ab2647a428f050 100644
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
index 65c6dba0428954170ce8a889edffa34ce9b24b13..c719864b92fb5b73170218a10c1eb66fdbe2edaa 100644
--- a/hw/vfio/helpers.c
+++ b/hw/vfio/helpers.c
@@ -24,7 +24,6 @@
 
 #include "exec/cpu-common.h"
 #include "hw/vfio/vfio-device.h"
-#include "hw/core/hw-error.h"
 #include "qapi/error.h"
 #include "vfio-helpers.h"
 
diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index 6aacf27284f86da401fdd67e359500dd0545222b..e091f21b6a3aea0013e0b3094d2ca13588200c98 100644
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
index d71c9590aaa53dc4e436987a34575f57a6397c6b..5e73dddc418b51475c78489189bd1ba8f2b3038d 100644
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
2.54.0


