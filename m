Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72728C47258
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 11:58:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rV9Cv-0001ET-Kr; Wed, 31 Jan 2024 06:56:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rV9Ct-0001Cj-Qo; Wed, 31 Jan 2024 06:56:43 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rV9Cs-00041E-9J; Wed, 31 Jan 2024 06:56:43 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A9D9E490CD;
 Wed, 31 Jan 2024 14:56:47 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id DFCB170276;
 Wed, 31 Jan 2024 14:55:50 +0300 (MSK)
Received: (nullmailer pid 2263957 invoked by uid 1000);
 Wed, 31 Jan 2024 11:55:49 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 15/21] misc: Clean up includes
Date: Wed, 31 Jan 2024 14:55:43 +0300
Message-Id: <20240131115549.2263854-16-mjt@tls.msk.ru>
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
 ./scripts/clean-includes --git misc net/af-xdp.c plugins/*.c audio/pwaudio.c util/userfaultfd.c

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
 audio/pwaudio.c    | 1 -
 net/af-xdp.c       | 1 -
 plugins/core.c     | 1 -
 plugins/loader.c   | 1 -
 util/userfaultfd.c | 1 -
 5 files changed, 5 deletions(-)

diff --git a/audio/pwaudio.c b/audio/pwaudio.c
index 3ce5f6507b..3b14e04fbb 100644
--- a/audio/pwaudio.c
+++ b/audio/pwaudio.c
@@ -11,7 +11,6 @@
 #include "qemu/osdep.h"
 #include "qemu/module.h"
 #include "audio.h"
-#include <errno.h>
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include <spa/param/audio/format-utils.h>
diff --git a/net/af-xdp.c b/net/af-xdp.c
index 6c65028fb0..38e600703a 100644
--- a/net/af-xdp.c
+++ b/net/af-xdp.c
@@ -13,7 +13,6 @@
 
 #include "qemu/osdep.h"
 #include <bpf/bpf.h>
-#include <inttypes.h>
 #include <linux/if_link.h>
 #include <linux/if_xdp.h>
 #include <net/if.h>
diff --git a/plugins/core.c b/plugins/core.c
index 49588285dd..ee2fa41af9 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -27,7 +27,6 @@
 #include "tcg/tcg.h"
 #include "tcg/tcg-op.h"
 #include "plugin.h"
-#include "qemu/compiler.h"
 
 struct qemu_plugin_cb {
     struct qemu_plugin_ctx *ctx;
diff --git a/plugins/loader.c b/plugins/loader.c
index 734c11cae0..9768b78eb6 100644
--- a/plugins/loader.c
+++ b/plugins/loader.c
@@ -33,7 +33,6 @@
 #ifndef CONFIG_USER_ONLY
 #include "hw/boards.h"
 #endif
-#include "qemu/compiler.h"
 
 #include "plugin.h"
 
diff --git a/util/userfaultfd.c b/util/userfaultfd.c
index fdff4867e8..1b2fa949d4 100644
--- a/util/userfaultfd.c
+++ b/util/userfaultfd.c
@@ -18,7 +18,6 @@
 #include <poll.h>
 #include <sys/syscall.h>
 #include <sys/ioctl.h>
-#include <fcntl.h>
 
 typedef enum {
     UFFD_UNINITIALIZED = 0,
-- 
2.39.2


