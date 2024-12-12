Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0397FE7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 11:50:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLhgM-0003bu-53; Thu, 12 Dec 2024 06:48:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tLhg9-0002sH-Iu
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 06:48:27 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tLhg7-0007OM-LK
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 06:48:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=64a6R+THUE1vG6dBHDl+GyoKtpAm/lobYJpjaZjJ/6w=; b=lfKDPb+TeRdGZDe6SZghQCBXSh
 7UFyPUJLnzXj7hTMSGjutq2n4GYn1163R+yfnvRifHB14WnffNXaSwCWz0L3y7A3DOpo9V4ZbDNva
 Dm3CGlBCbXpfwIhsnq0gqNMyl4KV3Core5/G74xBonkMrf9mab2ezgEyOTELFaFz/UYaNBHoLYx9m
 C32EhvLpbt5usG6Y90dy1ppSwpjeASoo89pswjiw2XkxzGxpS7ErSgQvU1IfnFW68nG+hk6nbESWR
 KE/GU8L0BbBV9Xl0hao6T2bLdLJqgL8QOk0P3a50mN6zxqFiZkoBZTDsAd2TqAucu5/9Jzi6/fHwe
 YObz/lNQvl5v0Y5hAqwubUWnaUVQvUBCsEdvbklnybkxA5+biZuJ/5T7OQ8/T2UNwXR7oxwqxhrXn
 YS/fGvHozdS349vCaQ0X+MVSO5XXjgRQXwRe4MMqzDqfxT3RqdOy9wfPTn8mCH+6N69aubsKrF0GJ
 hBT5+GauPZZu+CsyaZsh8SUwemhxxJxyc7yvp3et5GYCEOt/fqRS2WRq3ncrHS4wJ03mVC/md2XdY
 jjFGHCGbsrHuVO//yBijEzzOzRSNmChM2fXaXCVJSgRKkfbXQqlnRzXrol23FkhAaPsrvDlFsCAPp
 e9Q0pzzLhm6Py7JIfjCt5JigiI0jjWYiJlLfpZWFE=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tLhfR-00070a-FX; Thu, 12 Dec 2024 11:47:41 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: huth@tuxfamily.org,
	qemu-devel@nongnu.org
Date: Thu, 12 Dec 2024 11:46:20 +0000
Message-Id: <20241212114620.549285-35-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241212114620.549285-1-mark.cave-ayland@ilande.co.uk>
References: <20241212114620.549285-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 34/34] next-cube: replace boiler-plate GPL 2.0 or later
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
index 1e96bb02f8..3c2f3e295c 100644
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


