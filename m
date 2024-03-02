Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13A82C54798
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Mar 2024 22:36:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgXxM-0006AQ-7k; Sat, 02 Mar 2024 17:35:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rgXxI-00069o-KU
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 17:35:45 -0500
Received: from sin.source.kernel.org ([145.40.73.55])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rgXxE-0003h8-T7
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 17:35:43 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 68032CE0EA2;
 Sat,  2 Mar 2024 22:35:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD5BEC43390;
 Sat,  2 Mar 2024 22:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1709418932;
 bh=4Eqf7vy3Pugx/18Mi19bIFh3nWbHySqNUjbMF2ic1G4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=JZgjJ7xg9LojlUBYoXgQFguxrSGR8kudqlu5RQC85dBSm2MtDQ4zq7yzJW6FU665j
 c3iL/n3Nhdl9mRWksCRheuVcNi/6SwsMT/TxFcstbME8fAy9r96OLt8PdLjcQXLnFC
 6dCcXfCK0GPqyk+dYaP2DL8gk4Fd9INzR8Vu+JHftDqUWYhOf4qshuhABr3+VTXt/D
 /mpinCUuE6jSPG8quMv1OdAXSuyRL5asXOaIDb4fzWsv9+EIJE8hkw9V0nXrzMoocW
 XKiHXvdeOypwQQItopkCm3qipGvrqE1UYrOEWu5QJAIr7ex2RxKxZm9KbCMrGm2dtU
 1Km0HlHe0yBgw==
From: deller@kernel.org
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH 4/5] pc-bios/README: Add information about hppa-firmware
Date: Sat,  2 Mar 2024 23:35:23 +0100
Message-ID: <20240302223524.24421-5-deller@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240302223524.24421-1-deller@kernel.org>
References: <20240302223524.24421-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=145.40.73.55; envelope-from=deller@kernel.org;
 helo=sin.source.kernel.org
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.094,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Signed-off-by: Helge Deller <deller@gmx.de>
---
 pc-bios/README | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/pc-bios/README b/pc-bios/README
index b8a0210d24..6ffc46006e 100644
--- a/pc-bios/README
+++ b/pc-bios/README
@@ -75,3 +75,9 @@
   initialize and run boot images stored in SPI flash, but may grow more
   features over time as needed. The source code is available at:
   https://github.com/google/vbootrom
+
+- hppa-firmware.img (32-bit) and hppa-firmware64.img (64-bit) are firmware
+  files for the HP-PARISC (hppa) architecture.
+  The are built form the SeaBIOS-hppa sources, which is a fork of SeaBIOS
+  adapted for hppa.
+  SeaBIOS-hppa is available at https://github.com/hdeller/seabios-hppa
-- 
2.44.0


