Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE9D6D2E02A
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 09:02:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3XFV-0007ID-71; Wed, 23 Oct 2024 05:01:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t3XFJ-0006ou-Pr
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 05:01:38 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t3XFI-0000gZ-A9
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 05:01:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=YUp+9Ok3O7O5nHbjGFIWHC4xrAB0n/7Y/kZOS+6DUio=; b=N04Ws25wdHa9PgGLgTYkDGwd2K
 +HxyozIFIvkIJOWSdiTO+BOn2xXtHudwgbaaOyt8+Loj9uvATTAbeZ2DL9cewMULYnTnPZitYnCl4
 s3CAYd6rXl7sg60O9G4WVRfLvhkbujFQ12MOhI4H+kA61iHasShoQeOawHsJTJ3oWF9Qb7ioOwXvJ
 P4Nuk2d8TKxn+vhie2Ikq5hM5L8kVZMGdElG5oCVzf3FMg6JiS4XlNkorBf/8i0mPEEyDR0hsSnJe
 SKAivD+mW1dixyBilB+ym9UP+HSPkNDdKM2WiQMDBJmgzgd7XOwdmG4WZpthWn58FjwLDju8Be3GC
 Y7WAj/0LAXrU2i+uYKW1rLbre/rJt6MzkPRvoVM+M2pPtCQCrLef80dp/RRQ8wL74CUi2ECTXkHwc
 7ZcAQsY5UrWjDKHVtBen6zrdbekqSr9KveY5flv38e1pS0u0qgRMrPI54NGjnVzGvC/atNUhMj+yv
 coZJNVrwYnjdzIwGjjuWR3HpLFZSWOI2zh355k39TuCyqZuplQMlrAJLEAuUliAhOlCCkn8rtr16b
 /Cl4PgvJanKGVTJmpyXH7RrODkCHopL7m4inoJamh9Mos1rTK6k93QhCe+EpKmBE46fPVDw31LMvg
 Lj6MAT4tln/bxt+0ADs04ANxAnSMQeItdJjxgDhVs=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t3XEe-0008EL-Nc; Wed, 23 Oct 2024 10:00:57 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: huth@tuxfamily.org,
	qemu-devel@nongnu.org
Date: Wed, 23 Oct 2024 09:58:52 +0100
Message-Id: <20241023085852.1061031-37-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241023085852.1061031-1-mark.cave-ayland@ilande.co.uk>
References: <20241023085852.1061031-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 36/36] next-cube: replace boiler-plate GPL 2.0 or later
 license text with SPDX identifier
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
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

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/m68k/next-cube.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index eefb372dca..c961d5fef6 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -4,10 +4,7 @@
  * Copyright (c) 2011 Bryce Lanham
  * Copyright (c) 2024 Mark Cave-Ayland
  *
- * This code is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published
- * by the Free Software Foundation; either version 2 of the License,
- * or (at your option) any later version.
+ * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
 #include "qemu/osdep.h"
-- 
2.39.5


