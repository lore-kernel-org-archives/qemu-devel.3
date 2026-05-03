Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DD55CD3427
	for <qemu-devel@archiver.kernel.org>; Sun,  3 May 2026 07:36:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJRN9-00083O-RY; Sun, 03 May 2026 03:36:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wJRN6-00082z-RZ
 for qemu-devel@nongnu.org; Sun, 03 May 2026 03:36:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wJRN5-0003WR-BC
 for qemu-devel@nongnu.org; Sun, 03 May 2026 03:36:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777793770;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ol6jjCc0cvYMVJdnI2W+QVeN430AK+kQr2vrJR0Z0lQ=;
 b=Fml+tSEosq96/STPvS/WDkiWTyhiSp19AgWaNRaOcw/lauSDgFeKC8GrxUaol1k35nZTSH
 m6BKcfpKcFyDGy1WYrdMmDNp1Dcej84V9omCVBBGPHDd24f4TeZoy0aCKrobWvCkX+KB5x
 UdZOUYdEnepzfg/afzhBqMWMqVW9n/I=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-645-beDU38yWMFCltsFOYgz8Og-1; Sun,
 03 May 2026 03:36:06 -0400
X-MC-Unique: beDU38yWMFCltsFOYgz8Og-1
X-Mimecast-MFC-AGG-ID: beDU38yWMFCltsFOYgz8Og_1777793765
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A339E1800364; Sun,  3 May 2026 07:36:04 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.44.48.25])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A64661800480; Sun,  3 May 2026 07:35:59 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, kvmarm@lists.linux.dev, peter.maydell@linaro.org,
 richard.henderson@linaro.org, cohuck@redhat.com, sebott@redhat.com,
 skolothumtho@nvidia.com, philmd@linaro.org
Cc: maz@kernel.org, oliver.upton@linux.dev, pbonzini@redhat.com,
 armbru@redhat.com, berrange@redhat.com, abologna@redhat.com,
 jdenemar@redhat.com
Subject: [PATCH v4 02/17] target/arm/cpu-sysregs.h.inc: Sort by name
 alphabetical order
Date: Sun,  3 May 2026 09:33:22 +0200
Message-ID: <20260503073541.790215-3-eric.auger@redhat.com>
In-Reply-To: <20260503073541.790215-1-eric.auger@redhat.com>
References: <20260503073541.790215-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

target/arm/cpu-sysregs.h.inc: Sort by name alphabetical order

Sort by register name alphabetical order. This will allow to
easily diff with the future content, automatically generated.

No functional change intended.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20251208163751.611186-3-eric.auger@redhat.com>
---
 target/arm/cpu-sysregs.h.inc | 43 ++++++++++++++++++------------------
 1 file changed, 22 insertions(+), 21 deletions(-)

diff --git a/target/arm/cpu-sysregs.h.inc b/target/arm/cpu-sysregs.h.inc
index 3d1ed40f04..d61f0d0a19 100644
--- a/target/arm/cpu-sysregs.h.inc
+++ b/target/arm/cpu-sysregs.h.inc
@@ -1,12 +1,12 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
-DEF(ID_AA64PFR0_EL1, 3, 0, 0, 4, 0)
-DEF(ID_AA64PFR1_EL1, 3, 0, 0, 4, 1)
-DEF(ID_AA64PFR2_EL1, 3, 0, 0, 4, 2)
-DEF(ID_AA64SMFR0_EL1, 3, 0, 0, 4, 5)
-DEF(ID_AA64DFR0_EL1, 3, 0, 0, 5, 0)
-DEF(ID_AA64DFR1_EL1, 3, 0, 0, 5, 1)
+DEF(CCSIDR_EL1, 3, 1, 0, 0, 0)
+DEF(CLIDR_EL1, 3, 1, 0, 0, 1)
+DEF(CTR_EL0, 3, 3, 0, 0, 1)
+DEF(DCZID_EL0, 3, 3, 0, 0, 7)
 DEF(ID_AA64AFR0_EL1, 3, 0, 0, 5, 4)
 DEF(ID_AA64AFR1_EL1, 3, 0, 0, 5, 5)
+DEF(ID_AA64DFR0_EL1, 3, 0, 0, 5, 0)
+DEF(ID_AA64DFR1_EL1, 3, 0, 0, 5, 1)
 DEF(ID_AA64ISAR0_EL1, 3, 0, 0, 6, 0)
 DEF(ID_AA64ISAR1_EL1, 3, 0, 0, 6, 1)
 DEF(ID_AA64ISAR2_EL1, 3, 0, 0, 6, 2)
@@ -15,29 +15,30 @@ DEF(ID_AA64MMFR1_EL1, 3, 0, 0, 7, 1)
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


