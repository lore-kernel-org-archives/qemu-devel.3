Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CA6FC0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 17:10:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcp5o-0005ot-3e; Tue, 28 Jan 2025 12:09:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tcp5l-0005oa-2K
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 12:09:37 -0500
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tcp5j-0002ix-Bf
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 12:09:36 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id A120E5C6098;
 Tue, 28 Jan 2025 17:08:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 956B1C4CEE1;
 Tue, 28 Jan 2025 17:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1738084173;
 bh=MzIYJdYE2iH9KoWXxoHCCv60+jIXnxO3BNAA4wgPLeo=;
 h=From:To:Cc:Subject:Date:From;
 b=h8SftcG0POVSQrcImFQU2NCAzheYeaTr91cNw9SXQtVq0Jtsj/FkjPOhqWjfUnr8b
 cVc5vChHvE4HrViVwAxOm4qJR3ssW6ESH4w4MktFIYBckybZdiLlZncmtvx4oC7sjm
 tYruuVfeOMQ/AXMn5GDaolEiI9J+fVreTFO7HlhDVUnx7EfvIeo6wv5W2IB2siHIsk
 B/Tnr3Pqv8ncHg38hVsBmLg4gGN9v6e+VfWA2i6F+Gcr7nmP4rpVlUyY5rKX7CsoMB
 9K9WAXIg+yiIpROPObq0gDTeoPUyIISPNGm+pgolhPjq0qsq9mPZfza6z+ED2NhO1T
 +x4dguALfV2zg==
From: deller@kernel.org
To: richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH] MAINTAINERS: Add myself as HPPA maintainer
Date: Tue, 28 Jan 2025 18:09:15 +0100
Message-ID: <20250128170914.13353-2-deller@kernel.org>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=139.178.84.217; envelope-from=deller@kernel.org;
 helo=dfw.source.kernel.org
X-Spam_score_int: -83
X-Spam_score: -8.4
X-Spam_bar: --------
X-Spam_report: (-8.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Helge Deller <deller@gmx.de>

Since I contribute quite some code to hppa, I'd like to step up and
become the secondary maintainer for HPPA beside Richard.
Additionally change status of hppa machines to maintained as I will
take care of them.

Signed-off-by: Helge Deller <deller@gmx.de>
---
 MAINTAINERS | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c5e2d6b636..62b851f766 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -251,6 +251,7 @@ F: target/hexagon/gen_idef_parser_funcs.py
 
 HPPA (PA-RISC) TCG CPUs
 M: Richard Henderson <richard.henderson@linaro.org>
+M: Helge Deller <deller@gmx.de>
 S: Maintained
 F: target/hppa/
 F: disas/hppa.c
@@ -1188,8 +1189,8 @@ HP-PARISC Machines
 ------------------
 HP B160L, HP C3700
 M: Richard Henderson <richard.henderson@linaro.org>
-R: Helge Deller <deller@gmx.de>
-S: Odd Fixes
+M: Helge Deller <deller@gmx.de>
+S: Maintained
 F: configs/devices/hppa-softmmu/default.mak
 F: hw/char/diva-gsp.c
 F: hw/display/artist.c
-- 
2.47.0


