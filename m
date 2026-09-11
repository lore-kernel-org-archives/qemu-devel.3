Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68BB3C88E4C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 10:57:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4ywE-0004dL-WB; Fri, 11 Sep 2026 06:56:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x4yw3-0004Xb-PC; Fri, 11 Sep 2026 06:56:49 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x4yw2-0003EB-6D; Fri, 11 Sep 2026 06:56:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1789124163; bh=Xl5CqXqwDmrK0Vxv+IS0O+njx9A89LCKWKuO1tRaWrM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=yLdgSMeK2IOLkv6JAycagxQtJURhWVNbdh+z8QrEd2mQjSsC/TdajjPI+tiBa/+Zn
 SvfTth2NoiMse9p3XMgW0UXKRHOC8+yI+cW1/DqiAWTqF3P+hLAqT69geWgVdXyaz1
 bzoC/ZjGaiHaUtaD0Jfy5cwd5jNDA/cGd//nwZPFSBSJakY9ax+bhr9AuAnmZTDzpJ
 uy94lIN0VWt7dGHMbKQkqWDWA+T3jNqwOsYu78imrEFNw3fg4vnVlCDJn/W3vS82dE
 uk2Bv8jGIsylG7Lg6ZIwjac17kIMBXaqs3EwxJ+hq8zvSoSHmiKAYioU/qx1OmPFoD
 TTPpPetKSqmTQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 079A61D3B86;
 Fri, 11 Sep 2026 13:56:03 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id C4F61425DFD;
 Fri, 11 Sep 2026 13:56:35 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id AB59F40F11; Fri, 11 Sep 2026 13:56:35 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 4/4] hw/ppc/vof: Use qemu_tolower() instead of tolower()
Date: Fri, 11 Sep 2026 13:56:32 +0300
Message-ID: <20260911105635.955937-5-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260911105635.955937-1-mjt@tls.msk.ru>
References: <20260911105635.955937-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

When building QEMU for NetBSD ("make vm-build-netbsd"), the compiler
complains:

  In file included from /usr/include/ctype.h:100,
                 from ../src/include/qemu/osdep.h:123,
                 from ../src/hw/ppc/vof.c:12:
  ../src/hw/ppc/vof.c: In function 'path_offset':
  ../src/hw/ppc/vof.c:150:31: warning: array subscript has type 'char' [-Wchar-subscripts]
  150 |                 *at = tolower(*at);

tolower() should not be used with plain "char" variables since these
can be signed and tolower() could be implemented as a macro that uses
its parameter to index into an array. Use our wrapper qemu_tolower()
to fix this problem.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 hw/ppc/vof.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/vof.c b/hw/ppc/vof.c
index fa7b73159a0..873e967f1e4 100644
--- a/hw/ppc/vof.c
+++ b/hw/ppc/vof.c
@@ -10,6 +10,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/ctype.h"
 #include "qemu/timer.h"
 #include "qemu/range.h"
 #include "qemu/units.h"
@@ -147,7 +148,7 @@ static int path_offset(const void *fdt, const char *path)
             if (*at == '/') {
                 at = strchr(at, '@');
             } else {
-                *at = tolower(*at);
+                *at = qemu_tolower(*at);
                 ++at;
             }
     }
-- 
2.47.3


