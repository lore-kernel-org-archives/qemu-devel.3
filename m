Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3D1FC48BC4
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Feb 2024 23:49:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZg1e-0003EL-B3; Mon, 12 Feb 2024 18:47:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rZg1b-0003DM-DL
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 18:47:47 -0500
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rZg1Z-00009G-MI
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 18:47:47 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 67A646117F;
 Mon, 12 Feb 2024 23:47:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96713C433C7;
 Mon, 12 Feb 2024 23:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1707781664;
 bh=WnjkRHA+PxnhJ2hwB5R3kLTKfKDbD/nEu0xgZtuTRoo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=qK8sptLUwpqCTNq0KQuzt7qTgWluuaAde/dvq2R74mYNtf6cfKXVhTQ8grqrzCabd
 42mAGvt/1Iaa3iadQRlxigB2XoPYM9W7qIfJ06IhO5Oo8zwDdeEBl4za1vTEttF4lu
 pnQzVhJs5yheUr1y++MwxoCIY8C1Z3O7aVkyZNQ0Bc07VQQCV9Q/Vu9b6VxiWw2QF5
 zLbtgPtsrOZCcieNUu//yAzB+XKaTIcyOwMAGgFYWqEdVpMNIm/lXVrn85XyYKnqbH
 GDoMQxZnl6yRCbOY0OzgvO/Ns5WXh524gK5BEb8i+3Fji+4KlhwrGxo8ZQecj39pTJ
 BSK0Z7lt2dJQg==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Sven Schnelle <svens@stackframe.org>, Jason Wang <jasowang@redhat.com>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 10/12] hw/net/tulip: add chip status register values
Date: Tue, 13 Feb 2024 00:47:21 +0100
Message-ID: <20240212234723.222847-11-deller@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240212234723.222847-1-deller@kernel.org>
References: <20240212234723.222847-1-deller@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=139.178.84.217; envelope-from=deller@kernel.org;
 helo=dfw.source.kernel.org
X-Spam_score_int: -78
X-Spam_score: -7.9
X-Spam_bar: -------
X-Spam_report: (-7.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.774,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Sven Schnelle <svens@stackframe.org>

Netbsd isn't able to detect a link on the emulated tulip card. That's
because netbsd reads the Chip Status Register of the Phy (address
0x14). The default phy data in the qemu tulip driver is all zero,
which means no link is established and autonegotation isn't complete.

Therefore set the register to 0x3b40, which means:

Link is up, Autonegotation complete, Full Duplex, 100MBit/s Link
speed.

Also clear the mask because this register is read only.

Signed-off-by: Sven Schnelle <svens@stackframe.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Helge Deller <deller@gmx.de>
Tested-by: Helge Deller <deller@gmx.de>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 hw/net/tulip.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/net/tulip.c b/hw/net/tulip.c
index 6d4fb06dad..1f2ef20977 100644
--- a/hw/net/tulip.c
+++ b/hw/net/tulip.c
@@ -421,7 +421,7 @@ static uint16_t tulip_mdi_default[] = {
     /* MDI Registers 8 - 15 */
     0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
     /* MDI Registers 16 - 31 */
-    0x0003, 0x0000, 0x0001, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+    0x0003, 0x0000, 0x0001, 0x0000, 0x3b40, 0x0000, 0x0000, 0x0000,
     0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
 };
 
@@ -429,7 +429,7 @@ static uint16_t tulip_mdi_default[] = {
 static const uint16_t tulip_mdi_mask[] = {
     0x0000, 0xffff, 0xffff, 0xffff, 0xc01f, 0xffff, 0xffff, 0x0000,
     0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
-    0x0fff, 0x0000, 0xffff, 0xffff, 0xffff, 0xffff, 0xffff, 0xffff,
+    0x0fff, 0x0000, 0xffff, 0xffff, 0x0000, 0xffff, 0xffff, 0xffff,
     0xffff, 0xffff, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
 };
 
-- 
2.43.0


