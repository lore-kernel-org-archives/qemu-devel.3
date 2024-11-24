Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A752FE668BC
	for <qemu-devel@archiver.kernel.org>; Sun, 24 Nov 2024 17:09:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFG5K-0003if-AV; Sun, 24 Nov 2024 12:07:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <e183da80d390cfd7d55bdbce92f0ff6e3e5cdced@kylie.crudebyte.com>)
 id 1tFG5J-0003iS-3Q; Sun, 24 Nov 2024 12:07:45 -0500
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <e183da80d390cfd7d55bdbce92f0ff6e3e5cdced@kylie.crudebyte.com>)
 id 1tFG5H-0005Gg-Bk; Sun, 24 Nov 2024 12:07:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=NTS/m9q0lUtbEO9KOENkH2r7ycV71tXpqWTqX6H4Evg=; b=tTsC1
 YP7nGEshAs4GVfYC8xbsUEuK/Q0X5/FQmpCXT6Z7qYTegul4moU4xJ1LWUxJA4HZerbT2nVn6XjHR
 KhH4oN/lQ62ScthNK0YwSjNIIiqz8Q19RwD68Z2AgcJo8BbUAr6TqW+mp+gAeUG3LHOGHYcGFdbe3
 SIFIsaOvlSGHYItVslQRO9s/0v7w3+bddtDUGFayhl5ZL8q5kQ0XVlEJ45lMUQlxLBkrEaOMy3FK3
 E5dhT/qP18v73DX510Jwomnu0U9PUg8qVxf1P83n6arJRnh/6gHBPKHWfdxzS+IfgvFpUPHFjbOlP
 cAWO7gbMiMk1SfFI6jkRKSyCibCCsXuPoQPRgjFgwmDWdcSviQ1bQhnWFuYdUpCAc9nppDOuUmka+
 /eTcMW+V/S7Zu2hadMBohi1yek3Tn7KL9n2gS6V7WBaF4nKFHqhIVPsq5Ed7FdTdV7cXH9z5O9iEe
 SBmxFY3VR4n2v++58p5YtrlKkQlxRuggD1YEVv/pcJdEQvy5P8rZAVOGO4cEHDnxxZZ+f6cquFZ2Z
 k33qDKkSVw1/Hzi94RaLRx0AbcRy0jy9VDMXi28J9rVXU+eGDc165xH2O9o2/lVUmu1PZapucCGMF
 f1z0ufuXeWuazXWeiSGHSDcj7eSfIAUJ+IcK1GMJEr9qn4Qr6Ctuutx1zpXiU4=;
Message-Id: <e183da80d390cfd7d55bdbce92f0ff6e3e5cdced.1732465720.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1732465720.git.qemu_oss@crudebyte.com>
References: <cover.1732465720.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Sun, 24 Nov 2024 15:49:55 +0100
Subject: [PATCH 3/6] tests/9p: add missing Rgetattr response name
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
    Greg Kurz <groug@kaod.org>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=e183da80d390cfd7d55bdbce92f0ff6e3e5cdced@kylie.crudebyte.com;
 helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

'Tgetattr' 9p request and its 'Rgetattr' response types are already used
by test client, however this response type is yet missing in function
rmessage_name(), so add it.

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 tests/qtest/libqos/virtio-9p-client.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qtest/libqos/virtio-9p-client.c b/tests/qtest/libqos/virtio-9p-client.c
index c61632fcd3..98b77db51d 100644
--- a/tests/qtest/libqos/virtio-9p-client.c
+++ b/tests/qtest/libqos/virtio-9p-client.c
@@ -235,6 +235,7 @@ static const char *rmessage_name(uint8_t id)
         id == P9_RMKDIR ? "RMKDIR" :
         id == P9_RLCREATE ? "RLCREATE" :
         id == P9_RSYMLINK ? "RSYMLINK" :
+        id == P9_RGETATTR ? "RGETATTR" :
         id == P9_RLINK ? "RLINK" :
         id == P9_RUNLINKAT ? "RUNLINKAT" :
         id == P9_RFLUSH ? "RFLUSH" :
-- 
2.39.5


