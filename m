Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3275E7718D
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2024 13:10:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPLdm-0004WF-1f; Sun, 22 Dec 2024 08:05:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tPLbM-0006Uy-Lo
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 08:02:35 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tPLbK-0000vY-DM
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 08:02:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID;
 bh=leZgDpS9WUsAyjUCvyDmqZodOxDhSEmTwUdYR1YOABQ=; b=RGRQYXlLMThT/HGFXt1orqF10L
 Jqa+jRDIwNwqiGVhy3vOFNUdSpvdzTT/94hRHeP+6LuL3jibKHIyobLnWxkjCVPCXbhsan33IvR5y
 nh4zmBZ6623CJnnPfyQY5F05CFJwibKuQjU0nOX5GP5RoPzzDhIgLXZOtUSdCQI6Y7rDl5PljhLU/
 ArpBMmr74cWG+iATGm3q7Wuf8n273OOCz59g8oed3D7ehycemesMMdJIJi1srV2p+LIBaBsSNRo7K
 vaVIus7FZqIsDCYtw821j6zvxy+aVFCNLa8r6yKPsErdc5/kDe71sjGMuPo11iAGrLUOlu7sn4v8l
 fAG//w0b9clQZeb0NfG1/6UPHM/In/zmiDCSLUlYNVx3QrvgumZFClNpG4dUXOx9tUHlgFkkIZ4vP
 aF/PHonhcgNXupWYy0JvSSsPKbwZXIZFIymJxbK4oQtktzfEuIk62pdd3SRRHxnSjIq7pgQ55+QU8
 PFrJoClYTRKsTzGYv+r5qUd6MKLyQBgm3ump/uzbVhtwRa3kfd7Xttah/myPI/h/Ls/JfJrM3k7nj
 3cXxzi04jWOW9GLV6cIlpo1B0Gj2nFjjE40+Wh6jh646ChcQmFNI7tk/KZAum6y1n+/deMcnrTVnv
 w6pZnKpxWjnk1gs3Tjg6mtPKuhAoSEQ9d45qUyII0=;
Received: from [2a02:8012:2f01:0:33a9:475d:1cd9:884]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tPLaW-0002L7-Rs; Sun, 22 Dec 2024 13:01:44 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: huth@tuxfamily.org,
	qemu-devel@nongnu.org
Date: Sun, 22 Dec 2024 13:00:12 +0000
Message-Id: <20241222130012.1013374-34-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241222130012.1013374-1-mark.cave-ayland@ilande.co.uk>
References: <20241222130012.1013374-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:33a9:475d:1cd9:884
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 33/33] next-cube: add my copyright to the top of the file
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

This series has involved rewriting and/or updating a considerable part of the
next-cube emulation so update the copyright in next-cube.c to reflect this.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Thomas Huth <huth@tuxfamily.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/m68k/next-cube.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index 2625839576..07fb868b99 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -2,6 +2,7 @@
  * NeXT Cube System Driver
  *
  * Copyright (c) 2011 Bryce Lanham
+ * Copyright (c) 2024 Mark Cave-Ayland
  *
  * This code is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published
-- 
2.39.5


