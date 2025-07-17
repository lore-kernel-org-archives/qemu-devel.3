Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05E9AC83F1B
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 10:55:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucMH4-00082N-5S; Thu, 17 Jul 2025 06:55:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ucMGV-0007Xi-S7; Thu, 17 Jul 2025 06:55:03 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ucMGT-0003Bo-Rl; Thu, 17 Jul 2025 06:55:03 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 60ACB137E24;
 Thu, 17 Jul 2025 13:54:35 +0300 (MSK)
Received: from think4mjt.origo (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 5070524926E;
 Thu, 17 Jul 2025 13:54:43 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 Vasant Hegde <vasant.hegde@amd.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.19 24/26] amd_iommu: Remove duplicated definitions
Date: Thu, 17 Jul 2025 13:54:38 +0300
Message-ID: <20250717105442.735202-9-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <qemu-stable-7.2.19-20250717135416@cover.tls.msk.ru>
References: <qemu-stable-7.2.19-20250717135416@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>

No functional change.

Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
Message-Id: <20250617150427.20585-8-alejandro.j.jimenez@oracle.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
(cherry picked from commit 5959b641c98b5ae9677e2c1d89902dac31b344d9)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index 15ed663001..c8d1a6d353 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -204,10 +204,6 @@
 /* Completion Wait data size */
 #define AMDVI_COMPLETION_DATA_SIZE    8
 
-#define AMDVI_COMMAND_SIZE   16
-/* Completion Wait data size */
-#define AMDVI_COMPLETION_DATA_SIZE    8
-
 #define AMDVI_COMMAND_SIZE   16
 
 #define AMDVI_INT_ADDR_FIRST    0xfee00000
-- 
2.47.2


