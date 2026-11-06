Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D05606A33E
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 22:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eUUKmeyi
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPSGT-0001i4-8i; Fri, 06 Nov 2026 17:18:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xPSGQ-0001hF-T8
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 17:18:26 -0500
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xPSGP-0001DQ-GL
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 17:18:26 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 00AE440867;
 Fri,  6 Nov 2026 22:18:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 334A71F0089F;
 Fri,  6 Nov 2026 22:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794003503;
 bh=zS/XUIjIxy1Cx7ALbZBfCrVbykR5wA6xGtikRBTcLLo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=eUUKmeyiB7gJEu2aoR/bd+61rTnzpd8g9ueJxLxlTEOqqhva4QiPhAU8gYxN4CblF
 strGNOFmLVJ77p4+OBXDGbzz0ze+6FfbllyrQv5eaDz/hvyiQRyorDUdVBxvZsbHyT
 Rv51P8qPRusAPB8Mx7xDBdNQp7pT30Ab+pNkSUAQLIDg/osFRSGyFidkIoHRASkC1W
 dNlHGeReUigl+mt7zI513RsyQ6+Tz3BQPBMkURi5OlljEraCcGH1yVNjCSU6XNtI3G
 rhti0FVBwbGEbowo5nO6F0JXAm61rGJz5oTqnY5zi0KZpS4C93+t/8YmzCPTVGujdx
 zpVrqRiedHb+A==
From: Helge Deller <deller@kernel.org>
To: Peter Maydell <peter.maydell@linaro.org>,
 Keith Monahan <keith@techtravels.org>, BALATON Zoltan <balaton@eik.bme.hu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Helge Deller <deller@gmx.de>
Subject: [PATCH 1/4] target/hppa: drop dependency on ncr53c710.h
Date: Fri,  6 Nov 2026 23:18:15 +0100
Message-ID: <20261106221818.139086-2-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261106221818.139086-1-deller@kernel.org>
References: <20261106221818.139086-1-deller@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=deller@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Helge Deller <deller@gmx.de>

The HP machine uses the LASI layer and not the SCSI controller directly,
so the reference to the header file can go.

Signed-off-by: Helge Deller <deller@gmx.de>
---
 hw/hppa/machine.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index 8a3f673daf..1f6be1e34b 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -30,7 +30,6 @@
 #include "hw/pci-host/astro.h"
 #include "hw/pci-host/dino.h"
 #include "hw/misc/lasi.h"
-#include "hw/scsi/ncr53c710.h"
 #include "hw/scsi/lasi_ncr710.h"
 #include "hppa_hardware.h"
 #include "qemu/units.h"
-- 
2.54.0


