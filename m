Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BD7FCCF2D5
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 10:06:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhm9C-0003j7-BJ; Mon, 19 Jan 2026 05:06:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vhm8z-0003em-Jy
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 05:05:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vhm8x-0005hs-D2
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 05:05:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768817154;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dOAZ2fmc+JRLbJzpsXOAPndmlMK09NdqTgXifko76YE=;
 b=aEIIWDyNMqLkuVf8kGZaajHoFyduLJrOH3bAI0Ru3ZcNEFuTMS+eDigP+CKmB+e6m7bh4z
 r6YZlH7DS53hHszDw0DyMgBpkSr63tbDrW9ry4xWFLEZqsyb9TG6wcHeBPIiiqdFpwo+qx
 boZpdMu/vzJDR+yLBc3c5Yuhzjg4+lk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-350-oWmLI3SuNmGbIRVlLsZCzA-1; Mon,
 19 Jan 2026 05:05:49 -0500
X-MC-Unique: oWmLI3SuNmGbIRVlLsZCzA-1
X-Mimecast-MFC-AGG-ID: oWmLI3SuNmGbIRVlLsZCzA_1768817149
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D38551955DD8
 for <qemu-devel@nongnu.org>; Mon, 19 Jan 2026 10:05:43 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.3])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 678F619540E1
 for <qemu-devel@nongnu.org>; Mon, 19 Jan 2026 10:05:43 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8678521E66D2; Mon, 19 Jan 2026 11:05:37 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/5] Normalize header guard symbol definition
Date: Mon, 19 Jan 2026 11:05:36 +0100
Message-ID: <20260119100537.463312-5-armbru@redhat.com>
In-Reply-To: <20260119100537.463312-1-armbru@redhat.com>
References: <20260119100537.463312-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.077,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

We commonly define the header guard symbol without an explicit value.
Normalize the exceptions.

Done with scripts/clean-header-guards.pl.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/exec/tlb-common.h     | 3 ++-
 include/hw/misc/xlnx-cfi-if.h | 3 ++-
 include/qemu/mem-reentrancy.h | 2 +-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/exec/tlb-common.h b/include/exec/tlb-common.h
index 03b5a8ffc7..1bfc278d69 100644
--- a/include/exec/tlb-common.h
+++ b/include/exec/tlb-common.h
@@ -16,8 +16,9 @@
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
+
 #ifndef EXEC_TLB_COMMON_H
-#define EXEC_TLB_COMMON_H 1
+#define EXEC_TLB_COMMON_H
 
 #define CPU_TLB_ENTRY_BITS (HOST_LONG_BITS == 32 ? 4 : 5)
 
diff --git a/include/hw/misc/xlnx-cfi-if.h b/include/hw/misc/xlnx-cfi-if.h
index 5010401517..b1012beb4d 100644
--- a/include/hw/misc/xlnx-cfi-if.h
+++ b/include/hw/misc/xlnx-cfi-if.h
@@ -7,8 +7,9 @@
  *
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
+
 #ifndef XLNX_CFI_IF_H
-#define XLNX_CFI_IF_H 1
+#define XLNX_CFI_IF_H
 
 #include "qemu/help-texts.h"
 #include "qom/object.h"
diff --git a/include/qemu/mem-reentrancy.h b/include/qemu/mem-reentrancy.h
index 07cafd4717..86e377c0c0 100644
--- a/include/qemu/mem-reentrancy.h
+++ b/include/qemu/mem-reentrancy.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
 
 #ifndef QEMU_MEM_REENTRANCY_H
-#define QEMU_MEM_REENTRANCY_H 1
+#define QEMU_MEM_REENTRANCY_H
 
 typedef struct MemReentrancyGuard {
     bool engaged_in_io;
-- 
2.52.0


