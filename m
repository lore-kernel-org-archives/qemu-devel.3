Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA333C61DBD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 09:53:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wztGm-0002ma-Re; Fri, 28 Aug 2026 05:53:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@posteo.eu>) id 1wztGl-0002mC-K9
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 05:53:07 -0400
Received: from mout01.posteo.de ([185.67.36.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@posteo.eu>) id 1wztGj-00045n-Vu
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 05:53:07 -0400
Received: from submission (posteo.de [185.67.36.169]) 
 by mout01.posteo.de (Postfix) with ESMTPS id F2C60240027
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 11:53:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.eu;
 s=1984.8680eb; t=1787910782;
 bh=KTF9PZfQbeayuWZmdjvcuipqCwuoiZfFVHPb0TvnpJw=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:
 Content-Transfer-Encoding:From;
 b=mEbMASKd+0MILbvCuZ1xeRDrfUZadSSVHFZmQPEOguYJu0k9hTLwTgUQdIShcSpHC
 dd1bKnWo88WdQzZ/j7Lhyx+w0bNgdjvISJAseC73jm0SzArGSb4VMIyjLtOE1sK5It
 hmice2oBhbPey3alCRr+j8LO9eMEnYCWXfszRgB5GPeue7EYKU3u++BheC06nWss8z
 K4FztXL/xRwt7P3RdnE7bQlsXVDDu71yKnlg9+mVuooNHhmRTTDL5YyOqwhUfsTpTe
 TWVKS9hXTE3wIEfBWXaFo+egNz4h4qaFz6gSjMgzpgNhKSpNsRtGX/RxBkc1RX9MIx
 pqNZvf3mZ1nOw==
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 4hWYbf1mbmz6twj;
 Fri, 28 Aug 2026 11:53:02 +0200 (CEST)
From: Thomas Huth <th.huth@posteo.eu>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PATCH 3/3] MAINTAINERS: Mark the next-cube machine as "Orphan"
Date: Fri, 28 Aug 2026 09:53:02 +0000
Message-ID: <20260828095241.118458-4-th.huth@posteo.eu>
In-Reply-To: <20260828095241.118458-1-th.huth@posteo.eu>
References: <20260828095241.118458-1-th.huth@posteo.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=185.67.36.65; envelope-from=th.huth@posteo.eu;
 helo=mout01.posteo.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

I never manage to get this machine to a fully usable state, and in the
course of time I also lost interest in this machine. Mark it as
"Orphan" to set expectations right and make place for somebody else
to take over.

Signed-off-by: Thomas Huth <th.huth@posteo.eu>
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6c18b8a419..a6db951b59 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1418,8 +1418,7 @@ F: include/hw/m68k/mcf*.h
 F: tests/functional/m68k/test_mcf5208evb.py
 
 NeXTcube
-M: Thomas Huth <th.huth+qemu@posteo.eu>
-S: Odd Fixes
+S: Orphan
 F: hw/m68k/next-*.c
 F: hw/display/next-fb.c
 F: include/hw/m68k/next-cube.h
-- 
2.55.0


