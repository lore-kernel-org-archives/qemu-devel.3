Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7944210F92F0
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 18:53:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7eCS-0000BC-Q0; Tue, 31 Mar 2026 14:52:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1w7eCR-0000Am-G3
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 14:52:27 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1w7eCP-0001Wt-R8
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 14:52:27 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 5590F6012B;
 Tue, 31 Mar 2026 18:52:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 251B5C2BCB3;
 Tue, 31 Mar 2026 18:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774983144;
 bh=Ec6DQD/OQuHtghpvnNFaaEE9BbZX6HqByqSmYLEdqeA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=DrehgWKwUx7J+TVoevWeajSefsLbsHa9Q3o5LIyEZmcLXk9hmjDgaqidl13AiLQrQ
 nr3cDnrZ0xUc1+GXGZAUZPeJnzAUVF8EUvIpaMA24WMK6be10wbLtaNUbX6Ng7k+H2
 NBInUhpCSpDjzFrMfi+IzpWXDjs2UlsoqvDk6VAm6lwJNrNy7N4OoR8DgXrzX8Gp0o
 x7dScK5hkw27Vx/82+LhT1piLWEWTWMPisK1WIiE4Lcn7VswZy4RlP4j0vulTOJA1J
 OAKtHK40C0QBetDLGlYMq0bfFX68wxMJrV5GXB8tirw8jOxJYFhMETqM9ORdeEB0ON
 SsESmjGfbpVvg==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 1/8] hw/pci-host/astro: Make astro address arrays accessible
 for other users
Date: Tue, 31 Mar 2026 20:52:12 +0200
Message-ID: <20260331185219.12187-2-deller@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331185219.12187-1-deller@kernel.org>
References: <20260331185219.12187-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Helge Deller <deller@gmx.de>

Move the tables out of astro_realize(). This is needed because follow-up
patches will need those tables.

Signed-off-by: Helge Deller <deller@gmx.de>
---
 hw/pci-host/astro.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/hw/pci-host/astro.c b/hw/pci-host/astro.c
index 6cc0b35070..46d8530538 100644
--- a/hw/pci-host/astro.c
+++ b/hw/pci-host/astro.c
@@ -37,6 +37,11 @@
 #include "qom/object.h"
 #include "exec/target_page.h"
 
+static const int elroy_hpa_offsets[ELROY_NUM] = {
+            0x30000, 0x32000, 0x38000, 0x3c000 };
+static const char elroy_rope_nr[ELROY_NUM] = {
+            0, 1, 4, 6 }; /* busnum path, e.g. [10:6] */
+
 /*
  * Helper functions
  */
@@ -843,10 +848,6 @@ static void astro_realize(DeviceState *obj, Error **errp)
 
     /* Create Elroys (PCI host bus chips).  */
     for (i = 0; i < ELROY_NUM; i++) {
-        static const int elroy_hpa_offsets[ELROY_NUM] = {
-                    0x30000, 0x32000, 0x38000, 0x3c000 };
-        static const char elroy_rope_nr[ELROY_NUM] = {
-                    0, 1, 4, 6 }; /* busnum path, e.g. [10:6] */
         int addr_offset;
         ElroyState *elroy;
         hwaddr map_addr;
-- 
2.53.0


