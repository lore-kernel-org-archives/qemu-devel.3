Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D16ACCF9EE
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 09:03:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE24d-0004T7-PB; Wed, 29 Oct 2025 05:02:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vE24c-0004Sr-5E; Wed, 29 Oct 2025 05:02:30 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vE24V-000362-Np; Wed, 29 Oct 2025 05:02:29 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 180A1163E63;
 Wed, 29 Oct 2025 12:01:43 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 419623084AA;
 Wed, 29 Oct 2025 12:01:49 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 6/7] hw/xen: Avoid non-inclusive language in params.h
Date: Wed, 29 Oct 2025 12:01:44 +0300
Message-ID: <20251029090148.648212-7-mjt@tls.msk.ru>
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

From: Thomas Huth <thuth@redhat.com>

Copy the latest version of Xen's params.h to the QEMU repository:

https://xenbits.xen.org/gitweb/?p=xen.git;a=commitdiff;h=0291089f6ea81690f37035a124d54c51fa7ba097#patch8

With this patch, we get rid of a non-inclusive word in the comment
there.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Acked-by: Anthony PERARD <anthony.perard@vates.tech>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 include/hw/xen/interface/hvm/params.h | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/include/hw/xen/interface/hvm/params.h b/include/hw/xen/interface/hvm/params.h
index a22b4ed45d..99c40b4287 100644
--- a/include/hw/xen/interface/hvm/params.h
+++ b/include/hw/xen/interface/hvm/params.h
@@ -246,16 +246,11 @@
 #define HVM_PARAM_VM_GENERATION_ID_ADDR 34
 
 /*
- * Set mode for altp2m:
- *  disabled: don't activate altp2m (default)
+ * Get mode for altp2m:
+ *  disabled: altp2m not active (default)
  *  mixed: allow access to all altp2m ops for both in-guest and external tools
  *  external: allow access to external privileged tools only
  *  limited: guest only has limited access (ie. control VMFUNC and #VE)
- *
- * Note that 'mixed' mode has not been evaluated for safety from a
- * security perspective.  Before using this mode in a
- * security-critical environment, each subop should be evaluated for
- * safety, with unsafe subops blacklisted in XSM.
  */
 #define HVM_PARAM_ALTP2M       35
 #define XEN_ALTP2M_disabled      0
-- 
2.47.3


