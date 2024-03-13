Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DAA6C54791
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 18:31:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkTNT-0007lu-Pt; Wed, 13 Mar 2024 14:30:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thomas@t-8ch.de>) id 1rkTND-0007kM-7T
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 14:30:51 -0400
Received: from todd.t-8ch.de ([159.69.126.157])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thomas@t-8ch.de>) id 1rkTNA-00016h-FF
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 14:30:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
 t=1710354633; bh=uMO6Nm3s6pTXwozpOl7YuSfWTfjdYkYi+h1hy8fvNUg=;
 h=From:Date:Subject:To:Cc:From;
 b=QNnsTXVKSvtX0Fc+kQEfPYyTEBLjQ84NnGQffO164RqwuYo5zOS++5b90nOCXzlfo
 FjsgxBE/rShRvR8fNm9YC1IaHooZ+IORRHbXZwEYwNDsOnUQ1X7174HCdoaegvQTSq
 jUvi4NqB6GbxXFgTUR9KWlaXQ90F4WQoJWJMeTo4=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Date: Wed, 13 Mar 2024 19:30:31 +0100
Subject: [PATCH] docs/specs/pvpanic: mark shutdown event as not implemented
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240313-pvpanic-note-v1-1-7f2571cdaedc@t-8ch.de>
X-B4-Tracking: v=1; b=H4sIAMbw8WUC/x3MTQqAIBBA4avIrBP8qYiuEi1Ex5qNioYE4t2Tl
 t/ivQYFM2GBnTXIWKlQDANyYmBvEy7k5IZBCTULLTVPNZlAlof4IPdGW9yckutiYCQpo6f33x1
 n7x+cx1p9XgAAAA==
To: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Cc: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710354633; l=897;
 i=thomas@t-8ch.de; s=20221212; h=from:subject:message-id;
 bh=uMO6Nm3s6pTXwozpOl7YuSfWTfjdYkYi+h1hy8fvNUg=;
 b=s5lNMdrsWMspLfP1OMJMwGw6da/W7BYmKDy0K9MpfrADRxgylcvoTAYZvWC9VoOiwy3HsInW2
 siyQchfRrthA4gTqgYsvhtXXbmR3ThvA8iaOvCrRo/mxTb5puwsZog0
X-Developer-Key: i=thomas@t-8ch.de; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
Received-SPF: pass client-ip=159.69.126.157; envelope-from=thomas@t-8ch.de;
 helo=todd.t-8ch.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Mention the fact that this event is not yet implemented
to avoid confusion.
As requested by Michael.

Signed-off-by: Thomas Weißschuh <thomas@t-8ch.de>
---
 docs/specs/pvpanic.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/specs/pvpanic.rst b/docs/specs/pvpanic.rst
index 61a80480edb8..b0f27860ec3b 100644
--- a/docs/specs/pvpanic.rst
+++ b/docs/specs/pvpanic.rst
@@ -29,7 +29,7 @@ bit 1
   a guest panic has happened and will be handled by the guest;
   the host should record it or report it, but should not affect
   the execution of the guest.
-bit 2
+bit 2 (to be implemented)
   a regular guest shutdown has happened and should be processed by the host
 
 PCI Interface

---
base-commit: ba49d760eb04630e7b15f423ebecf6c871b8f77b
change-id: 20240313-pvpanic-note-fa3ce8d2165a

Best regards,
-- 
Thomas Weißschuh <thomas@t-8ch.de>


