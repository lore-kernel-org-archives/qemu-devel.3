Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9B94D3B7EA
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Dec 2025 16:39:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSeFm-0001wM-Gi; Mon, 08 Dec 2025 11:38:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vSeFZ-0001tq-Sw
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 11:38:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vSeFY-0002bv-B4
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 11:38:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765211891;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2TuIPOQE/PovodmeZSRPKeP3cZ5zAKS8BSXNq4hDcLQ=;
 b=LI2c3jYkZ2x3guoelqZsWE4JXi3HUHx2Ns41PNFQUxNt4cJTjpFcywpAVVqxuDdTmK1zid
 pThXFNSaAio9dlXhpltyHCiB8O9o5lA1xnpt2DmBZsu8uboRVyaObeibQubvYuAQj6N3PH
 t3ITZ8zBcEpE+s2FheBreRDrSK+bOYI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-132-p3fsvPGVNAGU__jcCFdNWA-1; Mon,
 08 Dec 2025 11:38:08 -0500
X-MC-Unique: p3fsvPGVNAGU__jcCFdNWA-1
X-Mimecast-MFC-AGG-ID: p3fsvPGVNAGU__jcCFdNWA_1765211887
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7805719560B6; Mon,  8 Dec 2025 16:38:07 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.22.88.78])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CBACF30001A5; Mon,  8 Dec 2025 16:38:04 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, cohuck@redhat.com, sebott@redhat.com
Cc: maz@kernel.org
Subject: [PATCH 2/3] target/arm/cpu-sysregs.h.inc: Sort by name alphabetical
 order
Date: Mon,  8 Dec 2025 17:37:04 +0100
Message-ID: <20251208163751.611186-3-eric.auger@redhat.com>
In-Reply-To: <20251208163751.611186-1-eric.auger@redhat.com>
References: <20251208163751.611186-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

target/arm/cpu-sysregs.h.inc: Sort by name alphabetical order

Sort by register name alphabetical order. This will allow to
easily diff with the future content, automatically generated.

No functional change intended.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 target/arm/cpu-sysregs.h.inc | 40 ++++++++++++++++++------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/target/arm/cpu-sysregs.h.inc b/target/arm/cpu-sysregs.h.inc
index 2bb2861c62..3c892c4f30 100644
--- a/target/arm/cpu-sysregs.h.inc
+++ b/target/arm/cpu-sysregs.h.inc
@@ -1,12 +1,10 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
-DEF(ID_AA64PFR0_EL1, 3, 0, 0, 4, 0)
-DEF(ID_AA64PFR1_EL1, 3, 0, 0, 4, 1)
-DEF(ID_AA64PFR2_EL1, 3, 0, 0, 4, 2)
-DEF(ID_AA64SMFR0_EL1, 3, 0, 0, 4, 5)
-DEF(ID_AA64DFR0_EL1, 3, 0, 0, 5, 0)
-DEF(ID_AA64DFR1_EL1, 3, 0, 0, 5, 1)
+DEF(CLIDR_EL1, 3, 1, 0, 0, 1)
+DEF(CTR_EL0, 3, 3, 0, 0, 1)
 DEF(ID_AA64AFR0_EL1, 3, 0, 0, 5, 4)
 DEF(ID_AA64AFR1_EL1, 3, 0, 0, 5, 5)
+DEF(ID_AA64DFR0_EL1, 3, 0, 0, 5, 0)
+DEF(ID_AA64DFR1_EL1, 3, 0, 0, 5, 1)
 DEF(ID_AA64ISAR0_EL1, 3, 0, 0, 6, 0)
 DEF(ID_AA64ISAR1_EL1, 3, 0, 0, 6, 1)
 DEF(ID_AA64ISAR2_EL1, 3, 0, 0, 6, 2)
@@ -14,28 +12,30 @@ DEF(ID_AA64MMFR0_EL1, 3, 0, 0, 7, 0)
 DEF(ID_AA64MMFR1_EL1, 3, 0, 0, 7, 1)
 DEF(ID_AA64MMFR2_EL1, 3, 0, 0, 7, 2)
 DEF(ID_AA64MMFR3_EL1, 3, 0, 0, 7, 3)
-DEF(ID_PFR0_EL1, 3, 0, 0, 1, 0)
-DEF(ID_PFR1_EL1, 3, 0, 0, 1, 1)
-DEF(ID_DFR0_EL1, 3, 0, 0, 1, 2)
+DEF(ID_AA64PFR0_EL1, 3, 0, 0, 4, 0)
+DEF(ID_AA64PFR1_EL1, 3, 0, 0, 4, 1)
+DEF(ID_AA64PFR2_EL1, 3, 0, 0, 4, 2)
+DEF(ID_AA64SMFR0_EL1, 3, 0, 0, 4, 5)
+DEF(ID_AA64ZFR0_EL1, 3, 0, 0, 4, 4)
 DEF(ID_AFR0_EL1, 3, 0, 0, 1, 3)
-DEF(ID_MMFR0_EL1, 3, 0, 0, 1, 4)
-DEF(ID_MMFR1_EL1, 3, 0, 0, 1, 5)
-DEF(ID_MMFR2_EL1, 3, 0, 0, 1, 6)
-DEF(ID_MMFR3_EL1, 3, 0, 0, 1, 7)
+DEF(ID_DFR0_EL1, 3, 0, 0, 1, 2)
+DEF(ID_DFR1_EL1, 3, 0, 0, 3, 5)
 DEF(ID_ISAR0_EL1, 3, 0, 0, 2, 0)
 DEF(ID_ISAR1_EL1, 3, 0, 0, 2, 1)
 DEF(ID_ISAR2_EL1, 3, 0, 0, 2, 2)
 DEF(ID_ISAR3_EL1, 3, 0, 0, 2, 3)
 DEF(ID_ISAR4_EL1, 3, 0, 0, 2, 4)
 DEF(ID_ISAR5_EL1, 3, 0, 0, 2, 5)
-DEF(ID_MMFR4_EL1, 3, 0, 0, 2, 6)
 DEF(ID_ISAR6_EL1, 3, 0, 0, 2, 7)
+DEF(ID_MMFR0_EL1, 3, 0, 0, 1, 4)
+DEF(ID_MMFR1_EL1, 3, 0, 0, 1, 5)
+DEF(ID_MMFR2_EL1, 3, 0, 0, 1, 6)
+DEF(ID_MMFR3_EL1, 3, 0, 0, 1, 7)
+DEF(ID_MMFR4_EL1, 3, 0, 0, 2, 6)
+DEF(ID_MMFR5_EL1, 3, 0, 0, 3, 6)
+DEF(ID_PFR0_EL1, 3, 0, 0, 1, 0)
+DEF(ID_PFR1_EL1, 3, 0, 0, 1, 1)
+DEF(ID_PFR2_EL1, 3, 0, 0, 3, 4)
 DEF(MVFR0_EL1, 3, 0, 0, 3, 0)
 DEF(MVFR1_EL1, 3, 0, 0, 3, 1)
 DEF(MVFR2_EL1, 3, 0, 0, 3, 2)
-DEF(ID_PFR2_EL1, 3, 0, 0, 3, 4)
-DEF(ID_DFR1_EL1, 3, 0, 0, 3, 5)
-DEF(ID_MMFR5_EL1, 3, 0, 0, 3, 6)
-DEF(CLIDR_EL1, 3, 1, 0, 0, 1)
-DEF(ID_AA64ZFR0_EL1, 3, 0, 0, 4, 4)
-DEF(CTR_EL0, 3, 3, 0, 0, 1)
-- 
2.52.0


