Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96CA7CCF9EB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 21:18:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDUaQ-0002Y0-1D; Mon, 27 Oct 2025 17:17:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vDUa3-0002V0-1N
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 17:16:48 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vDUZr-00050i-Vw
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 17:16:42 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 367CE620C3;
 Mon, 27 Oct 2025 21:16:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26491C113D0;
 Mon, 27 Oct 2025 21:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1761599785;
 bh=VeL3ZXV3FK5/cHF42CD+YyZEYgcAswTH8PNBcOcNxOg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=PXRlRFU+N+ewBFJVWma7J1YRm/+FKeobqtxS6ANUqsQPSmUhHeyKdqeJYdtsD1RNw
 +cszmlyFCRHrvsAs0LIUz0oWMu/CJNNoJ9p8x9ASrNAVF9sWb/PdAgvgqsWiw0Jsx0
 0EAWJr011PYEsShdXCS8xeyZeE6B+X/xpuOmSqQQV0dD/W0vi05Id1mUOYqekNS70v
 b7vkWy1cm5zjROlwRKir0YIkb04DaJhC2pkgyAUgAoWOqUoM0asU0Rq7n+7pVlEdkv
 zGJwC79NS2/2qKv00iI/wnbAPv8l/1e1CrWbwqjzW1g8fuLHRRdfAvzkTxQ+v1vwe8
 b6kb9MM8LosfQ==
From: deller@kernel.org
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fam Zheng <fam@euphon.net>,
 Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, deller@gmx.de
Subject: [PULL 08/11] hw/hppa: Add NCR 710 SCSI driver to LASI chip Kconfig
 entry
Date: Mon, 27 Oct 2025 22:16:00 +0100
Message-ID: <20251027211603.7141-9-deller@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251027211603.7141-1-deller@kernel.org>
References: <20251027211603.7141-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Helge Deller <deller@gmx.de>

The LASI chip is a multi I/O chip used in many older PA-RISC machines.
It includes functionality for NCR710 SCSI, serial, parallel, audio,
i82596 networking and PS/2 ports.

Add the functionality for NCR710_SCSI to the LASI Kconfig option
and move over the relevant parts from the generic HPPA_B160L Kconfig
option to get the dependency right.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 hw/hppa/Kconfig | 2 --
 hw/misc/Kconfig | 5 +++++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/hppa/Kconfig b/hw/hppa/Kconfig
index cab21045de..9ede4d1140 100644
--- a/hw/hppa/Kconfig
+++ b/hw/hppa/Kconfig
@@ -17,7 +17,5 @@ config HPPA_B160L
     select IDE_CMD646
     select MC146818RTC
     select LSI_SCSI_PCI
-    select LASI_82596
-    select LASIPS2
     select PARALLEL
     select ARTIST
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 4e35657468..fccd735c24 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -212,6 +212,11 @@ config VIRT_CTRL
 
 config LASI
     bool
+    select LASI_82596
+    select LASIPS2
+    select NCR710_SCSI
+    select PARALLEL
+    select SERIAL_MM
 
 config ALLWINNER_SRAMC
     bool
-- 
2.51.0


