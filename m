Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6694FC47DB3
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 12:01:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rV9Ch-0000fc-0x; Wed, 31 Jan 2024 06:56:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rV9CX-0000Kf-Nc; Wed, 31 Jan 2024 06:56:23 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rV9CV-0003yA-Dj; Wed, 31 Jan 2024 06:56:20 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 7D80F490CA;
 Wed, 31 Jan 2024 14:56:47 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id B43FB70273;
 Wed, 31 Jan 2024 14:55:50 +0300 (MSK)
Received: (nullmailer pid 2263948 invoked by uid 1000);
 Wed, 31 Jan 2024 11:55:49 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 12/21] include: Clean up includes
Date: Wed, 31 Jan 2024 14:55:40 +0300
Message-Id: <20240131115549.2263854-13-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240131115549.2263854-1-mjt@tls.msk.ru>
References: <20240131115549.2263854-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Peter Maydell <peter.maydell@linaro.org>

This commit was created with scripts/clean-includes:
 ./scripts/clean-includes --git include include/*/*.h include/*/*/*.h

All .c should include qemu/osdep.h first.  The script performs three
related cleanups:

* Ensure .c files include qemu/osdep.h first.
* Including it in a .h is redundant, since the .c  already includes
  it.  Drop such inclusions.
* Likewise, including headers qemu/osdep.h includes is redundant.
  Drop these, too.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 include/hw/arm/raspberrypi-fw-defs.h | 1 -
 include/hw/mem/memory-device.h       | 1 -
 include/hw/ppc/spapr_nested.h        | 1 -
 include/hw/xen/xen-hvm-common.h      | 1 -
 include/qemu/qtree.h                 | 1 -
 include/ui/rect.h                    | 2 --
 6 files changed, 7 deletions(-)

diff --git a/include/hw/arm/raspberrypi-fw-defs.h b/include/hw/arm/raspberrypi-fw-defs.h
index 4551fe7450..579cf0d554 100644
--- a/include/hw/arm/raspberrypi-fw-defs.h
+++ b/include/hw/arm/raspberrypi-fw-defs.h
@@ -10,7 +10,6 @@
 #ifndef INCLUDE_HW_MISC_RASPBERRYPI_FW_DEFS_H_
 #define INCLUDE_HW_MISC_RASPBERRYPI_FW_DEFS_H_
 
-#include "qemu/osdep.h"
 
 enum rpi_firmware_property_tag {
     RPI_FWREQ_PROPERTY_END =                           0,
diff --git a/include/hw/mem/memory-device.h b/include/hw/mem/memory-device.h
index a1d62cc551..e0571c8a31 100644
--- a/include/hw/mem/memory-device.h
+++ b/include/hw/mem/memory-device.h
@@ -14,7 +14,6 @@
 #define MEMORY_DEVICE_H
 
 #include "hw/qdev-core.h"
-#include "qemu/typedefs.h"
 #include "qapi/qapi-types-machine.h"
 #include "qom/object.h"
 
diff --git a/include/hw/ppc/spapr_nested.h b/include/hw/ppc/spapr_nested.h
index d383486476..d312a5d61d 100644
--- a/include/hw/ppc/spapr_nested.h
+++ b/include/hw/ppc/spapr_nested.h
@@ -1,7 +1,6 @@
 #ifndef HW_SPAPR_NESTED_H
 #define HW_SPAPR_NESTED_H
 
-#include "qemu/osdep.h"
 #include "target/ppc/cpu.h"
 
 /*
diff --git a/include/hw/xen/xen-hvm-common.h b/include/hw/xen/xen-hvm-common.h
index 4e9904f1a6..4b1d728f35 100644
--- a/include/hw/xen/xen-hvm-common.h
+++ b/include/hw/xen/xen-hvm-common.h
@@ -1,7 +1,6 @@
 #ifndef HW_XEN_HVM_COMMON_H
 #define HW_XEN_HVM_COMMON_H
 
-#include "qemu/osdep.h"
 #include "qemu/units.h"
 
 #include "cpu.h"
diff --git a/include/qemu/qtree.h b/include/qemu/qtree.h
index 69fe74b50d..dc2b14d258 100644
--- a/include/qemu/qtree.h
+++ b/include/qemu/qtree.h
@@ -42,7 +42,6 @@
 #ifndef QEMU_QTREE_H
 #define QEMU_QTREE_H
 
-#include "qemu/osdep.h"
 
 #ifdef HAVE_GLIB_WITH_SLICE_ALLOCATOR
 
diff --git a/include/ui/rect.h b/include/ui/rect.h
index 68f05d78a8..7ebf47ebcd 100644
--- a/include/ui/rect.h
+++ b/include/ui/rect.h
@@ -4,8 +4,6 @@
 #ifndef QEMU_RECT_H
 #define QEMU_RECT_H
 
-#include <stdint.h>
-#include <stdbool.h>
 
 typedef struct QemuRect {
     int16_t x;
-- 
2.39.2


