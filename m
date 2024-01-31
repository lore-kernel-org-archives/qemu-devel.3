Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7ACFC47258
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 12:00:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rV9Ce-0000Tp-EE; Wed, 31 Jan 2024 06:56:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rV9CU-0000B2-0p; Wed, 31 Jan 2024 06:56:19 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rV9CF-0003wN-5L; Wed, 31 Jan 2024 06:56:16 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 320E4490C5;
 Wed, 31 Jan 2024 14:56:47 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 5BE8F7026E;
 Wed, 31 Jan 2024 14:55:50 +0300 (MSK)
Received: (nullmailer pid 2263933 invoked by uid 1000);
 Wed, 31 Jan 2024 11:55:49 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 07/21] hyperv: Clean up includes
Date: Wed, 31 Jan 2024 14:55:35 +0300
Message-Id: <20240131115549.2263854-8-mjt@tls.msk.ru>
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
 ./scripts/clean-includes --git hyperv hw/hyperv/*.[ch]

All .c should include qemu/osdep.h first.  The script performs three
related cleanups:

* Ensure .c files include qemu/osdep.h first.
* Including it in a .h is redundant, since the .c  already includes
  it.  Drop such inclusions.
* Likewise, including headers qemu/osdep.h includes is redundant.
  Drop these, too.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 hw/hyperv/hv-balloon-internal.h           | 1 -
 hw/hyperv/hv-balloon-our_range_memslots.c | 1 +
 hw/hyperv/hv-balloon-our_range_memslots.h | 1 -
 hw/hyperv/hv-balloon-page_range_tree.c    | 1 +
 hw/hyperv/hv-balloon-page_range_tree.h    | 1 -
 hw/hyperv/hv-balloon.c                    | 1 +
 6 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/hyperv/hv-balloon-internal.h b/hw/hyperv/hv-balloon-internal.h
index 164c2e5825..ee53a28a26 100644
--- a/hw/hyperv/hv-balloon-internal.h
+++ b/hw/hyperv/hv-balloon-internal.h
@@ -10,7 +10,6 @@
 #ifndef HW_HYPERV_HV_BALLOON_INTERNAL_H
 #define HW_HYPERV_HV_BALLOON_INTERNAL_H
 
-#include "qemu/osdep.h"
 
 #define HV_BALLOON_PFN_SHIFT 12
 #define HV_BALLOON_PAGE_SIZE (1 << HV_BALLOON_PFN_SHIFT)
diff --git a/hw/hyperv/hv-balloon-our_range_memslots.c b/hw/hyperv/hv-balloon-our_range_memslots.c
index 99bae870f3..1505a395cf 100644
--- a/hw/hyperv/hv-balloon-our_range_memslots.c
+++ b/hw/hyperv/hv-balloon-our_range_memslots.c
@@ -7,6 +7,7 @@
  * See the COPYING file in the top-level directory.
  */
 
+#include "qemu/osdep.h"
 #include "hv-balloon-internal.h"
 #include "hv-balloon-our_range_memslots.h"
 #include "trace.h"
diff --git a/hw/hyperv/hv-balloon-our_range_memslots.h b/hw/hyperv/hv-balloon-our_range_memslots.h
index b6f592d34b..df3b686bc7 100644
--- a/hw/hyperv/hv-balloon-our_range_memslots.h
+++ b/hw/hyperv/hv-balloon-our_range_memslots.h
@@ -10,7 +10,6 @@
 #ifndef HW_HYPERV_HV_BALLOON_OUR_RANGE_MEMSLOTS_H
 #define HW_HYPERV_HV_BALLOON_OUR_RANGE_MEMSLOTS_H
 
-#include "qemu/osdep.h"
 
 #include "exec/memory.h"
 #include "qom/object.h"
diff --git a/hw/hyperv/hv-balloon-page_range_tree.c b/hw/hyperv/hv-balloon-page_range_tree.c
index e178d8b413..dfb14852f4 100644
--- a/hw/hyperv/hv-balloon-page_range_tree.c
+++ b/hw/hyperv/hv-balloon-page_range_tree.c
@@ -7,6 +7,7 @@
  * See the COPYING file in the top-level directory.
  */
 
+#include "qemu/osdep.h"
 #include "hv-balloon-internal.h"
 #include "hv-balloon-page_range_tree.h"
 
diff --git a/hw/hyperv/hv-balloon-page_range_tree.h b/hw/hyperv/hv-balloon-page_range_tree.h
index 07a9ae0da6..333772b86d 100644
--- a/hw/hyperv/hv-balloon-page_range_tree.h
+++ b/hw/hyperv/hv-balloon-page_range_tree.h
@@ -10,7 +10,6 @@
 #ifndef HW_HYPERV_HV_BALLOON_PAGE_RANGE_TREE_H
 #define HW_HYPERV_HV_BALLOON_PAGE_RANGE_TREE_H
 
-#include "qemu/osdep.h"
 
 /* PageRange */
 typedef struct PageRange {
diff --git a/hw/hyperv/hv-balloon.c b/hw/hyperv/hv-balloon.c
index 66f297c1d7..0238365712 100644
--- a/hw/hyperv/hv-balloon.c
+++ b/hw/hyperv/hv-balloon.c
@@ -7,6 +7,7 @@
  * See the COPYING file in the top-level directory.
  */
 
+#include "qemu/osdep.h"
 #include "hv-balloon-internal.h"
 
 #include "exec/address-spaces.h"
-- 
2.39.2


