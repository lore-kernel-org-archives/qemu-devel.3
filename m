Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF2B2C47DB3
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 11:59:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rV9Cx-0001JQ-VD; Wed, 31 Jan 2024 06:56:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rV9Cw-0001IY-Rb; Wed, 31 Jan 2024 06:56:46 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rV9Cv-00041W-5m; Wed, 31 Jan 2024 06:56:46 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B8080490CE;
 Wed, 31 Jan 2024 14:56:47 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id EED4F70277;
 Wed, 31 Jan 2024 14:55:50 +0300 (MSK)
Received: (nullmailer pid 2263960 invoked by uid 1000);
 Wed, 31 Jan 2024 11:55:49 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 16/21] backends/hostmem: Fix block comments style
 (checkpatch.pl warnings)
Date: Wed, 31 Jan 2024 14:55:44 +0300
Message-Id: <20240131115549.2263854-17-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240131115549.2263854-1-mjt@tls.msk.ru>
References: <20240131115549.2263854-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

While re-indenting code in host_memory_backend_memory_complete(),
we triggered various "Block comments use a leading /* on a separate
line" warnings from checkpatch.pl. Correct the comments style.

Fixes: e199f7ad4d ("backends: Simplify host_memory_backend_memory_complete()")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 backends/hostmem.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/backends/hostmem.c b/backends/hostmem.c
index 30f69b2cb5..987f6f591e 100644
--- a/backends/hostmem.c
+++ b/backends/hostmem.c
@@ -344,9 +344,11 @@ host_memory_backend_memory_complete(UserCreatable *uc, Error **errp)
     unsigned long lastbit = find_last_bit(backend->host_nodes, MAX_NODES);
     /* lastbit == MAX_NODES means maxnode = 0 */
     unsigned long maxnode = (lastbit + 1) % (MAX_NODES + 1);
-    /* ensure policy won't be ignored in case memory is preallocated
+    /*
+     * Ensure policy won't be ignored in case memory is preallocated
      * before mbind(). note: MPOL_MF_STRICT is ignored on hugepages so
-     * this doesn't catch hugepage case. */
+     * this doesn't catch hugepage case.
+     */
     unsigned flags = MPOL_MF_STRICT | MPOL_MF_MOVE;
     int mode = backend->policy;
 
@@ -363,7 +365,8 @@ host_memory_backend_memory_complete(UserCreatable *uc, Error **errp)
         return;
     }
 
-    /* We can have up to MAX_NODES nodes, but we need to pass maxnode+1
+    /*
+     * We can have up to MAX_NODES nodes, but we need to pass maxnode+1
      * as argument to mbind() due to an old Linux bug (feature?) which
      * cuts off the last specified node. This means backend->host_nodes
      * must have MAX_NODES+1 bits available.
@@ -391,7 +394,8 @@ host_memory_backend_memory_complete(UserCreatable *uc, Error **errp)
         }
     }
 #endif
-    /* Preallocate memory after the NUMA policy has been instantiated.
+    /*
+     * Preallocate memory after the NUMA policy has been instantiated.
      * This is necessary to guarantee memory is allocated with
      * specified NUMA policy in place.
      */
-- 
2.39.2


