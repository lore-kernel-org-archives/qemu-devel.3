Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13845C54798
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Mar 2024 22:36:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgXxU-0006DD-BO; Sat, 02 Mar 2024 17:35:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rgXxK-0006AG-Gg
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 17:35:46 -0500
Received: from sin.source.kernel.org ([145.40.73.55])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rgXxE-0003h1-TC
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 17:35:44 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 099C0CE0E15;
 Sat,  2 Mar 2024 22:35:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51706C433F1;
 Sat,  2 Mar 2024 22:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1709418931;
 bh=kjP1Pa/oNAtFAL8Kl/hLJlc6NmMlJfTBR36+ya8MznM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=jL27EwkuYjUc3ekYCpiHgB3zL6f4BdGtmUNaC45VpbumciW4A5cCWdEVDRkLJ1zAM
 1qssfmqgNNs7ERcMw23hq6no2//0j/DqSwWmc3rTVagTCXE0RaBIQBcJdMkZiojT67
 7ijjnS0Z8lMS2Wg5KGpC2XFz73KaJpW9yBciqfigP+EgcioNDGszcdtMhiwR/zHDC6
 Oa7GVz1n4hoz4cIfZ8GWYMQ2cO8uPbzq8oFrAsvR2d1WpGsR0KlppKLwW9aUU3a17Q
 4+08SjSq9rJ97LMLpTgGJWz2caVR0DX5BHb6+aGk7OmYmrbGiyFCk21gsJYWf9+Ms3
 5Wqkdpwwa1Lcw==
From: deller@kernel.org
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH 3/5] pc-bios/meson: Add hppa-firmware64.img blob
Date: Sat,  2 Mar 2024 23:35:22 +0100
Message-ID: <20240302223524.24421-4-deller@kernel.org>
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

Add the missing 64-bit hppa firmware blob so that it gets installed.

Signed-off-by: Helge Deller <deller@gmx.de>
Fixes: 7c0dfcf9395e ("target/hppa: Update SeaBIOS-hppa to version 16")
---
 pc-bios/meson.build | 1 +
 1 file changed, 1 insertion(+)

diff --git a/pc-bios/meson.build b/pc-bios/meson.build
index e67fa433a1..0760612bea 100644
--- a/pc-bios/meson.build
+++ b/pc-bios/meson.build
@@ -73,6 +73,7 @@ blobs = [
   'qemu_vga.ndrv',
   'edk2-licenses.txt',
   'hppa-firmware.img',
+  'hppa-firmware64.img',
   'opensbi-riscv32-generic-fw_dynamic.bin',
   'opensbi-riscv64-generic-fw_dynamic.bin',
   'npcm7xx_bootrom.bin',
-- 
2.44.0


