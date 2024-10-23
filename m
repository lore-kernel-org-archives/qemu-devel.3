Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E0F9D2E02B
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 09:07:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3XFM-00073W-I0; Wed, 23 Oct 2024 05:01:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t3XFJ-0006nA-A3
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 05:01:37 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t3XFH-0000gV-R9
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 05:01:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=Kt3DF77J7u9ygeIOtT6f2eEtNvXaiodXXADYjic7OP4=; b=BFzKC2I+XWT3ahEywSp5U8f4pd
 psHuvupDxIq3Zxtwb/sx6CD3Rdq6HTBOTOLw9KnQOCINP5IZmG3rTj1bSyqI12l7DAePAde7UvXTt
 dyNYA1L2+BzB0A6R16n4bpUR8Ya6sqUCHhR14Ney57pXbgb2+1HtnjRm7KSObvyZ29VHQ9iTGLOBp
 c4wjQ5K0nR1I0INZxKP2H5/bkTcWIiMGTemO6H6jfp5NOxIFhSFNQDJEr4RLCKf6RbehLEtMmJHnw
 1/L0SP8I1GIuBkOP6LptGtxkGFDozQX86bQEOcWXbLotN7+9aivBNWYKjX/i3V4qy6gjPRJHjEXCS
 5dNkvpXjwKHJC3iU38FeBXKvDFkT+VXY2nZfmOqouH8gAZzYE/2M4PQzxOuGTuIEFv8HmtDnRbOsP
 R7alj98zblEqAU7VsP73BCp6xTtAWB4XlWc5twpDgW8FyLqr7MIRvFvJlBxJcO/6D4DC7xsL3Jc+U
 4btxEWqr2P+6khBMq1iTtHryfSxpQuWrceXE3LSWRipxJomdW7sAw7+VuzyElkqOtFs/m/ANITVqu
 IgOTDWToVLoxix7Y08WvvnEdUj9kl1Dpx8l+y9A7rKQBShOskoEEaLEyXa6C9jE6QVu1yu/YV/Usv
 GaKvvXm+3UQRqPiLkqMvYjyKkbciTcAtoy2p0x48U=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t3XEa-0008EL-B4; Wed, 23 Oct 2024 10:00:56 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: huth@tuxfamily.org,
	qemu-devel@nongnu.org
Date: Wed, 23 Oct 2024 09:58:51 +0100
Message-Id: <20241023085852.1061031-36-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241023085852.1061031-1-mark.cave-ayland@ilande.co.uk>
References: <20241023085852.1061031-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 35/36] next-cube: add my copyright to the top of the file
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
---
 hw/m68k/next-cube.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index ece63f20b1..eefb372dca 100644
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


