Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EEE5C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 16:26:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udtK4-0000Wk-1m; Mon, 21 Jul 2025 12:25:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1udtJ1-0005fU-OF
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 12:23:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1udtIy-0001b7-LT
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 12:23:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753115035;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UXj8l7+pXf3A3kuFGI9aHSWMoaqzu3lAyL6p7MvggMc=;
 b=Oh1yFiF7+4cizlAc94EloCM4yaBD8bC1RdsQCJlFoojegdn3GFMBv0UX3YofX2OCG5Lymt
 uJzRUm0fZt1fb1X9lIyqtWgwQsVqAkvhPxTR21K3+TnO2P8ObknvDZQa4rmR6m/ntP+eEn
 GvQs6oesKqj3vzgqxLfrEyeBg9/a6Qg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-600-lvBA7Z0eOBm8rwaCm-FKSw-1; Mon,
 21 Jul 2025 12:23:48 -0400
X-MC-Unique: lvBA7Z0eOBm8rwaCm-FKSw-1
X-Mimecast-MFC-AGG-ID: lvBA7Z0eOBm8rwaCm-FKSw_1753115027
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2D7AB1800447; Mon, 21 Jul 2025 16:23:47 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.19])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BBEF8195608D; Mon, 21 Jul 2025 16:23:44 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Glenn Miles <milesg@linux.ibm.com>, Michael Kowal <kowal@linux.ibm.com>,
 Gautam Menghani <gautam@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 24/50] ppc/xive2: Improve pool regs variable name
Date: Mon, 21 Jul 2025 18:22:07 +0200
Message-ID: <20250721162233.686837-25-clg@redhat.com>
In-Reply-To: <20250721162233.686837-1-clg@redhat.com>
References: <20250721162233.686837-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.926,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Glenn Miles <milesg@linux.ibm.com>

Change pregs to pool_regs, for clarity.

[npiggin: split from larger patch]

Signed-off-by: Glenn Miles <milesg@linux.ibm.com>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Michael Kowal <kowal@linux.ibm.com>
Tested-by: Gautam Menghani <gautam@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20250512031100.439842-25-npiggin@gmail.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/intc/xive2.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index f810e716dee3..1f4713dabeb1 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -1044,13 +1044,12 @@ again:
 
     /* PHYS updates also depend on POOL values */
     if (ring == TM_QW3_HV_PHYS) {
-        uint8_t *pregs = &tctx->regs[TM_QW2_HV_POOL];
+        uint8_t *pool_regs = &tctx->regs[TM_QW2_HV_POOL];
 
         /* POOL values only matter if POOL ctx is valid */
-        if (pregs[TM_WORD2] & 0x80) {
-
-            uint8_t pool_pipr = xive_ipb_to_pipr(pregs[TM_IPB]);
-            uint8_t pool_lsmfb = pregs[TM_LSMFB];
+        if (pool_regs[TM_WORD2] & 0x80) {
+            uint8_t pool_pipr = xive_ipb_to_pipr(pool_regs[TM_IPB]);
+            uint8_t pool_lsmfb = pool_regs[TM_LSMFB];
 
             /*
              * Determine highest priority interrupt and
@@ -1064,7 +1063,7 @@ again:
             }
 
             /* Values needed for group priority calculation */
-            if (pregs[TM_LGS] && (pool_lsmfb < lsmfb_min)) {
+            if (pool_regs[TM_LGS] && (pool_lsmfb < lsmfb_min)) {
                 group_enabled = true;
                 lsmfb_min = pool_lsmfb;
                 if (lsmfb_min < pipr_min) {
-- 
2.50.1


