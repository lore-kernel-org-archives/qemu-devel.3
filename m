Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E15A5CD98E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 13:27:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZTol-0005Tx-9r; Tue, 16 Jun 2026 09:27:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wZToj-0005Rr-5S
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 09:27:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wZToh-0005pj-IT
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 09:27:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781616418;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bTs/ktWx3rW7HFZBOxDG+4OtZn4ymwK9rqHIbClYMpM=;
 b=FIvBg5dqIyWuQN6asXoOCqMzgBmjBdZe0d4oJO8tPAderCxlZ3yqeYu5Lq8QYE5FomcxOG
 FkfQo7ebKMmSxY4fb/XKxWceW1HmszosBMEBrmcd89EhUrjAkeDAPi21aWC60g1i109fC0
 DgRAuQLuCuIN3v4hIx6W3w4p03m2bMc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-382-z8FaUCv8NJK8EZaBdXYE4w-1; Tue,
 16 Jun 2026 09:26:52 -0400
X-MC-Unique: z8FaUCv8NJK8EZaBdXYE4w-1
X-Mimecast-MFC-AGG-ID: z8FaUCv8NJK8EZaBdXYE4w_1781616410
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 52A6019560A5; Tue, 16 Jun 2026 13:26:50 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.44.48.30])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 14DF03000203; Tue, 16 Jun 2026 13:26:43 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, kvmarm@lists.linux.dev, peter.maydell@linaro.org,
 shaju.abraham@nutanix.com, khushit.shah@nutanix.com,
 yangjinqian1@huawei.com, cohuck@redhat.com, richard.henderson@linaro.org,
 sebott@redhat.com, skolothumtho@nvidia.com, philmd@linaro.org
Cc: maz@kernel.org, oliver.upton@linux.dev, pbonzini@redhat.com,
 armbru@redhat.com, berrange@redhat.com, abologna@redhat.com,
 jdenemar@redhat.com
Subject: [RFC PATCH v6 02/17] target/arm/cpu-sysregs.h.inc: Sort by name
 alphabetical order
Date: Tue, 16 Jun 2026 15:16:49 +0200
Message-ID: <20260616132625.1732031-3-eric.auger@redhat.com>
In-Reply-To: <20260616132625.1732031-1-eric.auger@redhat.com>
References: <20260616132625.1732031-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Sort by register name alphabetical order. This will allow to
easily diff with the future content, automatically generated.

No functional change intended.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Shameer Kolothum <skolothumtho@nvidia.com>

---
v5 -> v6:
- v5 version conflicted because ID_AA64FPFR0_EL1 has been
  added

v4 -> v5:
- remove spurious CCSIDR definition
---
 target/arm/cpu-sysregs.h.inc | 44 ++++++++++++++++++------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/target/arm/cpu-sysregs.h.inc b/target/arm/cpu-sysregs.h.inc
index 6e8b335b8f..ec5a12b0f4 100644
--- a/target/arm/cpu-sysregs.h.inc
+++ b/target/arm/cpu-sysregs.h.inc
@@ -1,13 +1,12 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
-DEF(ID_AA64PFR0_EL1, 3, 0, 0, 4, 0)
-DEF(ID_AA64PFR1_EL1, 3, 0, 0, 4, 1)
-DEF(ID_AA64PFR2_EL1, 3, 0, 0, 4, 2)
-DEF(ID_AA64SMFR0_EL1, 3, 0, 0, 4, 5)
-DEF(ID_AA64FPFR0_EL1, 3, 0, 0, 4, 7)
-DEF(ID_AA64DFR0_EL1, 3, 0, 0, 5, 0)
-DEF(ID_AA64DFR1_EL1, 3, 0, 0, 5, 1)
+DEF(CLIDR_EL1, 3, 1, 0, 0, 1)
+DEF(CTR_EL0, 3, 3, 0, 0, 1)
+DEF(DCZID_EL0, 3, 3, 0, 0, 7)
 DEF(ID_AA64AFR0_EL1, 3, 0, 0, 5, 4)
 DEF(ID_AA64AFR1_EL1, 3, 0, 0, 5, 5)
+DEF(ID_AA64DFR0_EL1, 3, 0, 0, 5, 0)
+DEF(ID_AA64DFR1_EL1, 3, 0, 0, 5, 1)
+DEF(ID_AA64FPFR0_EL1, 3, 0, 0, 4, 7)
 DEF(ID_AA64ISAR0_EL1, 3, 0, 0, 6, 0)
 DEF(ID_AA64ISAR1_EL1, 3, 0, 0, 6, 1)
 DEF(ID_AA64ISAR2_EL1, 3, 0, 0, 6, 2)
@@ -17,29 +16,30 @@ DEF(ID_AA64MMFR1_EL1, 3, 0, 0, 7, 1)
 DEF(ID_AA64MMFR2_EL1, 3, 0, 0, 7, 2)
 DEF(ID_AA64MMFR3_EL1, 3, 0, 0, 7, 3)
 DEF(ID_AA64MMFR4_EL1, 3, 0, 0, 7, 4)
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
-DEF(DCZID_EL0, 3, 3, 0, 0, 7)
-- 
2.53.0


