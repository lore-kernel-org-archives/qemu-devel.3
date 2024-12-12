Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E386AE77180
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 11:51:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLhgK-0003MQ-JU; Thu, 12 Dec 2024 06:48:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tLhg8-0002rC-Mt
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 06:48:25 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tLhg7-0007OI-Co
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 06:48:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=bvY1uyqfDSve5G72JqQ8LUzLGJB3lyOoOElhjWLwLuo=; b=kFbKtSP7DCd4wKOlWj9YFf86rQ
 4Z372LCFb/1S06QRu0VmF156ezKhsS0V5C94yto/exhPRd7anMb2CLj1o2TqI7kbdw37ZeHsjNmEo
 8REU19vx0ULShaBVi2205Pq95VGQd2RP243HjlkQYQZoVCHd8bedLOySEmHF5nYZhDvmrmE+KGT5I
 pzwYkGYzVOXSfbr6sN3U7COJK9R7Oj9Sg4+75lo9ZcdBO+MyBBuDvDIM8yCBWulkge66omGDdKTcb
 M0v1dPzEuD0IL7Bj86HevB5qmw8VIpzZ1nU4WuWQV1dmZvHjlaDc6E6hUifRJlqIyj/g4/24CDvW5
 rYn8hh72juqspYrytHAUK/OtSfRktHMKc6lF0Uhdx7sDIDUVP/GFG6TSVgHsxGteUYobH+p+LxCZ9
 kCQ4lJ6d6Nr+HSPDqvolTL4BjZ4JH1Up0koepvN2drfCAbTC+7PAYYR8kDZM4LY66oFaIGpEW8BYC
 wkI8i1Q1mLCzwlj8UmSbHHAAxo5/N0S/H2/NwKKuXOvkI/vQsSmlki3+1PfGrD27kS/q5y9qun1zS
 jFyscI1yEv1xkmeOiTAK5KqFDKeHHVUVb87nReS1g+V2SePL6k6Xmh8MinIevbu3zctvMducY/c3h
 0PNZCmGvZz3MIfH6ARwdrQsJ/EBmT0LlZ9eYowMwM=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tLhfR-00070a-5m; Thu, 12 Dec 2024 11:47:41 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: huth@tuxfamily.org,
	qemu-devel@nongnu.org
Date: Thu, 12 Dec 2024 11:46:19 +0000
Message-Id: <20241212114620.549285-34-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241212114620.549285-1-mark.cave-ayland@ilande.co.uk>
References: <20241212114620.549285-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 33/34] next-cube: add my copyright to the top of the file
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
---
 hw/m68k/next-cube.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index 7b0769c0d3..1e96bb02f8 100644
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


