Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFD47C369D7
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 10:11:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7X4o-000781-G3; Wed, 23 Apr 2025 06:11:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1u7X4m-00077D-SH; Wed, 23 Apr 2025 06:11:32 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1u7X4k-00036F-Fw; Wed, 23 Apr 2025 06:11:32 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id A33F655D239;
 Wed, 23 Apr 2025 12:11:27 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id LPSV24Hed0Zm; Wed, 23 Apr 2025 12:11:25 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id B243A55C592; Wed, 23 Apr 2025 12:11:25 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH] hw/intc/i8259: Remove unused DEBUG_PIC define
To: qemu-devel@nongnu.org,
    qemu-trivial@nongnu.org
Cc: Michael S. Tsirkin <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <20250423101125.B243A55C592@zero.eik.bme.hu>
Date: Wed, 23 Apr 2025 12:11:25 +0200 (CEST)
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The debug printfs were converted to traces so this define is now unused.

Fixes: 0880a87300 (i8259: convert DPRINTFs into trace)
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/intc/i8259.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/hw/intc/i8259.c b/hw/intc/i8259.c
index d88b20f40b..6a204f7d21 100644
--- a/hw/intc/i8259.c
+++ b/hw/intc/i8259.c
@@ -32,10 +32,7 @@
 #include "trace.h"
 #include "qom/object.h"
 
-/* debug PIC */
-//#define DEBUG_PIC
-
-//#define DEBUG_IRQ_LATENCY
+/*#define DEBUG_IRQ_LATENCY*/
 
 #define TYPE_I8259 "isa-i8259"
 typedef struct PICClass PICClass;
-- 
2.41.3


