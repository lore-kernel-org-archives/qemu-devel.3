Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64622CD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 10:41:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRpDl-0005Kd-UG; Tue, 26 May 2026 06:41:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wRpDk-0005KT-8f
 for qemu-devel@nongnu.org; Tue, 26 May 2026 06:41:12 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wRpDi-00027B-N5
 for qemu-devel@nongnu.org; Tue, 26 May 2026 06:41:11 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4DE0F600B0;
 Tue, 26 May 2026 10:41:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46EB61F000E9;
 Tue, 26 May 2026 10:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779792069;
 bh=ay++dyQnKXbH+XfSz5o2KQB5TLdVCaktCp8ARxfP3yg=;
 h=From:To:Cc:Subject:Date;
 b=IKt3nA9LoYRY3dnnMMf5VHoQ7cgHDvigAqTHBkqiffqZUdR88wyv+mF89YmJsknWY
 LjOKQM5Aw1sS285IOe8HuufoKFsW9vUMB2mqWw+BEjXF2fCG9EQQ+ZwLVMvhwmSScD
 RnroMQCJw0TkjOzvNks6n/Syihg/ZjFzbpqR0XfFFVNUlNns8TgGK5l6u/3RAKxTVk
 sRtdBQmXj8y5mHgRM5l7UQC/Ao0lat0qmJLDAgJu1BoAbBeRYGw3fX0gxSpt4gn8uZ
 /tDFYMpFZaiK6X8M3wlz2otR/sz0uPsPYHsbTwgSELGisb5TpKdsRofwnFlpI9iDV8
 xfKQabQCiLAqw==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
Subject: [PATCH] linux-user: Fix typo in function documentation for
 pgb_addr_set()
Date: Tue, 26 May 2026 12:41:02 +0200
Message-ID: <20260526104102.5283-1-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

The third parameter is called guest_hiaddr.

Signed-off-by: Helge Deller <deller@gmx.de>
---
 linux-user/elfload.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 0e757787d2..f7625c0952 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -848,7 +848,7 @@ static bool pgb_try_mmap_set(const PGBAddrs *ga, uintptr_t base, uintptr_t brk)
  * pgb_addr_set:
  * @ga: output set of guest addrs
  * @guest_loaddr: guest image low address
- * @guest_loaddr: guest image high address
+ * @guest_hiaddr: guest image high address
  * @identity: create for identity mapping
  *
  * Fill in @ga with the image, COMMPAGE and NULL page.
-- 
2.54.0


