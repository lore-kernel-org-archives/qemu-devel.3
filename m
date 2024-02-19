Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BB6DC54764
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 10:51:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc1DZ-00047r-Rp; Mon, 19 Feb 2024 05:49:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rc1DK-0003uP-DT
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 05:49:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rc1DH-00018u-O9
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 05:49:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708339771;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fWr2OAgZT98LmxsyAvoqnKXhk0XeEInN7pMEmIbCipc=;
 b=N3dZs+fVl+DXDUjs3JTNWyOu13hNId9iyLfsWZlvi3/eoi1v3mpxXwYkVgh+1qqKVQTLNK
 Usg2PGVdg0XJEnVsfUazk96a/QcCzbPkXW4DrTU0u+b+gcK/oYfR3aVrqNgVRETCHYJqlj
 VL4NnzFEuG22kDbLPqkA1o+SaL8b7Zo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-659-M6wSZLlrPOus2ekn_eAgpg-1; Mon,
 19 Feb 2024 05:49:27 -0500
X-MC-Unique: M6wSZLlrPOus2ekn_eAgpg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 477FD3C025B0;
 Mon, 19 Feb 2024 10:49:27 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.115])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7196F1C060B3;
 Mon, 19 Feb 2024 10:49:25 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: John Snow <jsnow@redhat.com>,
	qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-block@nongnu.org
Subject: [PATCH 6/7] hw/ide: Remove the include/hw/ide.h legacy file
Date: Mon, 19 Feb 2024 11:49:11 +0100
Message-ID: <20240219104912.378211-7-thuth@redhat.com>
In-Reply-To: <20240219104912.378211-1-thuth@redhat.com>
References: <20240219104912.378211-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.077,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

There was only one prototype left in this legacy file. Move it to
ide-dev.h to finally get rid of it.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 include/hw/ide.h          | 9 ---------
 include/hw/ide/ide-dev.h  | 2 ++
 include/hw/ide/internal.h | 1 -
 3 files changed, 2 insertions(+), 10 deletions(-)
 delete mode 100644 include/hw/ide.h

diff --git a/include/hw/ide.h b/include/hw/ide.h
deleted file mode 100644
index db963bdb77..0000000000
--- a/include/hw/ide.h
+++ /dev/null
@@ -1,9 +0,0 @@
-#ifndef HW_IDE_H
-#define HW_IDE_H
-
-#include "exec/memory.h"
-
-/* ide/core.c */
-void ide_drive_get(DriveInfo **hd, int max_bus);
-
-#endif /* HW_IDE_H */
diff --git a/include/hw/ide/ide-dev.h b/include/hw/ide/ide-dev.h
index de88784a25..ad55997442 100644
--- a/include/hw/ide/ide-dev.h
+++ b/include/hw/ide/ide-dev.h
@@ -181,4 +181,6 @@ typedef struct IDEDrive {
 
 void ide_dev_initfn(IDEDevice *dev, IDEDriveKind kind, Error **errp);
 
+void ide_drive_get(DriveInfo **hd, int max_bus);
+
 #endif
diff --git a/include/hw/ide/internal.h b/include/hw/ide/internal.h
index d1d3fcd23a..0fc2013374 100644
--- a/include/hw/ide/internal.h
+++ b/include/hw/ide/internal.h
@@ -7,7 +7,6 @@
  * non-internal declarations are in hw/ide.h
  */
 
-#include "hw/ide.h"
 #include "hw/ide/ide-bus.h"
 #include "hw/ide/ide-dma.h"
 
-- 
2.43.2


