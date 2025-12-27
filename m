Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01DDAE8FDCD
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 13:23:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZUFa-0006yh-Se; Sat, 27 Dec 2025 08:22:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1vZUFX-0006yP-9L
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 08:22:27 -0500
Received: from collins.uni-paderborn.de ([2001:638:502:c003::14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1vZUFV-00079h-66
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 08:22:27 -0500
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: qemu-devel@nongnu.org
Cc: kbastian@mail.uni-paderborn.de,
	kbastian@rumtueddeln.de
Subject: [PATCH] MAINTAINERS: Change email and status of TriCore
Date: Sat, 27 Dec 2025 14:21:35 +0100
Message-ID: <20251227132135.4886-1-kbastian@mail.uni-paderborn.de>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IMT-Source: Extern
X-IMT-rspamd-score: -15
X-UPB-Report: Action: no action, RCVD_TLS_ALL(0.00), FROM_HAS_DN(0.00),
 FROM_EQ_ENVFROM(0.00), MID_CONTAINS_FROM(1.00), LOCAL_OUTBOUND(0.00),
 TO_DN_NONE(0.00), TO_MATCH_ENVRCPT_ALL(0.00), MIME_GOOD(-0.10),
 NEURAL_HAM(0.00), BAYES_HAM(-2.99), RCVD_VIA_SMTP_AUTH(0.00), ARC_NA(0.00),
 ASN(0.00), RCVD_COUNT_ONE(0.00), MIME_TRACE(0.00), RCPT_COUNT_THREE(0.00),
 R_MISSING_CHARSET(0.50),
 Message-ID: 20251227132135.4886-1-kbastian@mail.uni-paderborn.de
X-IMT-Spam-Score: 0.0 ()
X-IMT-Authenticated-Sender: uid=kbastian,ou=People,o=upb,c=de
Received-SPF: pass client-ip=2001:638:502:c003::14;
 envelope-from=kbastian@mail.uni-paderborn.de; helo=collins.uni-paderborn.de
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
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

I'm no longer employed at the university of Paderborn. This also means
my time available for QEMU has reduced significantly. Thus, I'm dropping
the status to odd fixes.

Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
---
I'm losing access to my kbastian@mail.uni-paderborn.de account with the 01st of
January 2026. So I'm kind of late. Who takes this patch into their tree? Do I have
to send a PR myself?

Thanks,
Bastian

 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 63e9ba521b..fc9a67c410 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -419,8 +419,8 @@ F: include/hw/xtensa/xtensa-isa.h
 F: configs/devices/xtensa*/default.mak
 
 TriCore TCG CPUs
-M: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
-S: Maintained
+M: Bastian Koppelmann <kbastian@rumtueddeln.de>
+S: Odd Fixes
 F: target/tricore/
 F: hw/tricore/
 F: include/hw/tricore/
-- 
2.52.0


