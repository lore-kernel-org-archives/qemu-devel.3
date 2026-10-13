Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09793CC6B1A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 19:28:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGiAV-0001ru-Ql; Tue, 13 Oct 2026 15:28:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1xGiAS-0001ps-1d
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 15:28:08 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1xGiAQ-00087F-B4
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 15:28:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=rHEF2jE77dSIuFayJcpdhhmInCgEQiWpCKJPvJzVhAs=; b=MqNjnvzCdNtU7ByNO+ZH40edWP
 LM5QiTbrkGOXRlIkwuyEGX1OW2nbARmFS4zqis66bUpSrQEDZ5nLPV6VgN7Vgun6Tf8PetFD8FuAL
 QPF8F6xdamB48+ZD4QEWkQpVk1ZXsUFWtEn9xpjXoz20Dj2KuIjl3IDUH7HV610KOjt8EFShiTtsj
 NbXKnGrsO+ml8Dr/v0EkPxNbEoud8Tccs9s7u6SqOxxL8xgmba3sXBe8S5L0C+qnhb9h8XOgX/f3E
 +MalfMSpNN5TUt6cMQVlImPPYx2cJn4BzTbVFY5+AYdh/EJPv2+5Iy0zIRzzFQGsb9HCuZXTUdjZh
 1Z8HkT4bMV0VK3XAgF6ZJFJglnZLgXgovCXaIOEDM8ToWUfUw0+6k6EkQsbRQj/lx7GywqeJpyuxI
 uHGTBZ58A071TVUAMDgES7hbVjSuH9baZHv2BhvGejYYq1rVtloSE/INGEqgEjW+NGf4UvFf/oDj3
 STgo8AUb1lEcw6nLD+/p0qZl0ECgqkQex0PKk/nKK/jm6C/K+kLz3g3ASNyE01owUpvGihpHLH5ET
 2j8QWLOGT0cfOWjY2diJGvd4X8tcBVg2RHXX+6WSqjHZNtdaBc76bA8Mo9GJaIVe31gdc9GiFWpnP
 qYkWboH4V/Z7usndjJUNEyC7oMADnqfiMCDpq9hCg=;
Received: from [2a02:8012:2f01:0:b2a5:667b:71e2:6751]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1xGi9k-001aAM-3D
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 20:27:24 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: qemu-devel@nongnu.org
Date: Tue, 13 Oct 2026 20:27:35 +0100
Message-ID: <20261013192751.196204-4-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261013192751.196204-1-mark.cave-ayland@ilande.co.uk>
References: <20261013192751.196204-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:b2a5:667b:71e2:6751
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 3/5] cuda: Include command in successful ADB replies
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
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

From: "Kirill A. Korinsky" <kirill@korins.ky>

OpenBSD and Linux expect the ADB command between the CUDA status and
reply data. QEMU omits it on success, so guests consume the first data
byte as the command and lose it from the reply.

Signed-off-by: Kirill A. Korinsky <kirill@korins.ky>
Tested-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <20261001230058.11465-4-kirill@korins.ky>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/misc/macio/cuda.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/misc/macio/cuda.c b/hw/misc/macio/cuda.c
index 312dde242ba..ccb3e1d74b0 100644
--- a/hw/misc/macio/cuda.c
+++ b/hw/misc/macio/cuda.c
@@ -431,11 +431,12 @@ static void cuda_receive_packet_from_host(CUDAState *s,
         {
             uint8_t obuf[ADB_MAX_OUT_LEN + 3];
             int olen;
-            olen = adb_request(&s->adb_bus, obuf + 2, data + 1, len - 1);
+            olen = adb_request(&s->adb_bus, obuf + 3, data + 1, len - 1);
             if (olen > 0) {
                 obuf[0] = ADB_PACKET;
                 obuf[1] = 0x00;
-                cuda_send_packet_to_host(s, obuf, olen + 2);
+                obuf[2] = data[1];
+                cuda_send_packet_to_host(s, obuf, olen + 3);
             } else {
                 /* error */
                 obuf[0] = ADB_PACKET;
-- 
2.47.3


