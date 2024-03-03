Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C35D9C54E49
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Mar 2024 05:48:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgegf-0006OH-LO; Sun, 03 Mar 2024 00:47:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rgegb-0006NZ-D4
 for qemu-devel@nongnu.org; Sun, 03 Mar 2024 00:46:57 -0500
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rgegZ-0003TG-Or
 for qemu-devel@nongnu.org; Sun, 03 Mar 2024 00:46:57 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id D186560D30;
 Sun,  3 Mar 2024 05:46:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ACCBC43390;
 Sun,  3 Mar 2024 05:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1709444814;
 bh=8SYw1jn1vfJ84+dFSZug51KEovglt1a3pWdQ04RPSG8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=MeAgrqSixaU2qs8KUDhbOM10Gals7fS+SoZgK+IQNn8hT01zYQOcCpDXI6KlbIfvF
 qgAHlG9r4+bwVZcW76gjhFZIU4XvePfpOStyeyB1gFlnIU/OBWOWY4RjdpMF6G+JIx
 ZXLPyNC0Ni5AsgLmSk531rlF7XuSPNhl97re/eH1LQOvirSh9GQMtfv4Jp1ARZhWkL
 4hE/PWaY1gfl+tia3CdgWGNFcYW+wbX27pWque2GHLaxgEYQYc7giY6svIhZqhsVKE
 F2pxHQT3HXbyyxY9e7eRbLMNXtIn7ZxNcSNqC1ioDoR4+H/8jBerCL+hjJwmbhn06Q
 nDZ9kf/3FrNqw==
From: deller@kernel.org
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: deller@gmx.de
Subject: [PULL 4/5] pc-bios/README: Add information about hppa-firmware
Date: Sun,  3 Mar 2024 06:46:44 +0100
Message-ID: <20240303054645.3004-5-deller@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240303054645.3004-1-deller@kernel.org>
References: <20240303054645.3004-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=deller@kernel.org; helo=dfw.source.kernel.org
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 pc-bios/README | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/pc-bios/README b/pc-bios/README
index b8a0210d24..7ffb2f43a4 100644
--- a/pc-bios/README
+++ b/pc-bios/README
@@ -75,3 +75,9 @@
   initialize and run boot images stored in SPI flash, but may grow more
   features over time as needed. The source code is available at:
   https://github.com/google/vbootrom
+
+- hppa-firmware.img (32-bit) and hppa-firmware64.img (64-bit) are firmware
+  files for the HP-PARISC (hppa) architecture.
+  They are built form the SeaBIOS-hppa sources, which is a fork of SeaBIOS
+  adapted for hppa.
+  SeaBIOS-hppa is available at https://github.com/hdeller/seabios-hppa
-- 
2.44.0


