Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37EA9CCF9E9
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 09:03:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE24R-0004KE-Dp; Wed, 29 Oct 2025 05:02:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vE24O-0004J6-Dv; Wed, 29 Oct 2025 05:02:16 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vE24L-00033Q-97; Wed, 29 Oct 2025 05:02:16 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id C3A0E163E60;
 Wed, 29 Oct 2025 12:01:42 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id E20DF3084A7;
 Wed, 29 Oct 2025 12:01:48 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Nir Lichtman <nir@lichtman.org>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 3/7] docs/system/keys: fix incorrect reset scaling key binding
Date: Wed, 29 Oct 2025 12:01:41 +0300
Message-ID: <20251029090148.648212-4-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251029090148.648212-1-mjt@tls.msk.ru>
References: <20251029090148.648212-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Nir Lichtman <nir@lichtman.org>

Fix incorrect key binding for resetting the graphical frontends scaling

Signed-off-by: Nir Lichtman <nir@lichtman.org>
Fixes: 15421f7113 "ui/sdl2: fix reset scaling binding to be consistent with gtk"
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 docs/system/keys.rst.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/system/keys.rst.inc b/docs/system/keys.rst.inc
index c28ae1a227..3b5307b775 100644
--- a/docs/system/keys.rst.inc
+++ b/docs/system/keys.rst.inc
@@ -21,7 +21,7 @@ while ``-display sdl,grab-mod=rctrl`` changes it to the right :kbd:`Ctrl` key.
   * - :kbd:`Ctrl+Alt+-`
     - Shrink the screen
 
-  * - :kbd:`Ctrl+Alt+u`
+  * - :kbd:`Ctrl+Alt+0`
     - Restore the screen's un-scaled dimensions
 
   * - :kbd:`Ctrl+Alt+n`
-- 
2.47.3


