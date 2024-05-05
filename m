Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A74FC4345F
	for <qemu-devel@archiver.kernel.org>; Sun,  5 May 2024 17:16:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3fST-0001v0-Ah; Sun, 05 May 2024 13:15:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@treblig.org>) id 1s3fSG-0001qT-0J
 for qemu-devel@nongnu.org; Sun, 05 May 2024 13:15:23 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@treblig.org>) id 1s3fS1-0005ic-4H
 for qemu-devel@nongnu.org; Sun, 05 May 2024 13:15:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
 :Subject; bh=dFPS7Oal1lrCOrfCkqIetV7yrx9zbnK4KyW+11VM5yo=; b=DNjckBOtkSMt/zKD
 ZxPSd/o84tiJQo5KRC1JXJAinWzHsHCOAjStttbGwfCcIk41C+XOhE2oEogKk77CRbXCBjM2pSbsH
 EmFq45dy++D73W5z1SATSja0p6poOPrQjT0l6UweJ7DrU7SWTFj66IZIRG0CnzVnVMyrJF59PXHNq
 s9YNqEaDBSI25Eb4EN8cvOisl3BPrgzEJyWkgKDuJo2b9sLwv4JBUqJR8EWv9mHr8jNAcZ+IcBXdy
 J/UuXkvRWdESjKJEmPbm5tF00QJ++0+DzUrBfYisZ2kJRghp6JHuG337d8NS/b3ARruNns7HUD0zc
 yRqptzLH8KcT+IsBVA==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
 by mx.treblig.org with esmtp (Exim 4.96)
 (envelope-from <dave@treblig.org>) id 1s3fRy-004nca-0t;
 Sun, 05 May 2024 17:14:58 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: peter.maydell@linaro.org,
	laurent@vivier.eu
Cc: qemu-devel@nongnu.org,
	"Dr. David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH 5/7] hw/arm/bcm2836: Remove unusued struct 'BCM283XClass'
Date: Sun,  5 May 2024 18:14:42 +0100
Message-ID: <20240505171444.333302-6-dave@treblig.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240505171444.333302-1-dave@treblig.org>
References: <20240505171444.333302-1-dave@treblig.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dave@treblig.org;
 helo=mx.treblig.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

This struct has been unused since
Commit f932093ae165 ("hw/arm/bcm2836: Split out common part of BCM283X
classes")

Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>
---
 hw/arm/bcm2836.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
index db191661f2..40a379bc36 100644
--- a/hw/arm/bcm2836.c
+++ b/hw/arm/bcm2836.c
@@ -18,18 +18,6 @@
 #include "target/arm/cpu-qom.h"
 #include "target/arm/gtimer.h"
 
-struct BCM283XClass {
-    /*< private >*/
-    DeviceClass parent_class;
-    /*< public >*/
-    const char *name;
-    const char *cpu_type;
-    unsigned core_count;
-    hwaddr peri_base; /* Peripheral base address seen by the CPU */
-    hwaddr ctrl_base; /* Interrupt controller and mailboxes etc. */
-    int clusterid;
-};
-
 static Property bcm2836_enabled_cores_property =
     DEFINE_PROP_UINT32("enabled-cpus", BCM283XBaseState, enabled_cpus, 0);
 
-- 
2.45.0


