Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE90A606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 18:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=iddOgLV2
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRZns-0006CR-Mc; Thu, 12 Nov 2026 13:45:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xRZni-000639-3c; Thu, 12 Nov 2026 13:45:34 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xRZne-0003dh-3Z; Thu, 12 Nov 2026 13:45:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1794509113; bh=BE51UgrGdVo4lbgb4ETKy4l1u2NvIZGz/w1s6R7MEjI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=iddOgLV2Rrt+aFEM3kRgnK4g3Y6oWECTxhWSJiNsXkziV3XhEgdhnCOM17fitjBKz
 K3Ygne3KRKYOdrjQ7cuuN8CTniepswxgDdYMnII5dEW6tIXDxZxbVFNi4JyC5RhwsQ
 iipaGKY5Uy9c5r8EYlnguuoqOnuFldv/Cl+hPuvfeXCLQ/aE1CrEWq4NpzhKBflWit
 AfZvMK8S85K/8I9YcXW8q2bArNGJfsLJhDakCB6vmtnVBMnveN6e3iC2Apch+qfNYh
 GJqKQhSY5pGWldYXHHMY5vXemQKdWnymkZDNLRqEqXwV0iio9w0MD8cPMuCw14pyl0
 6F9ESGd5vfD5A==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 859841E5D1F;
 Thu, 12 Nov 2026 21:45:13 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 7ED5745AAD9;
 Thu, 12 Nov 2026 21:45:13 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 55B03B7C54; Thu, 12 Nov 2026 21:45:13 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 4/6] MAINTAINERS: fix typo in Gerd's name
Date: Thu, 12 Nov 2026 21:45:07 +0300
Message-ID: <20261112184513.2324634-5-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261112184513.2324634-1-mjt@tls.msk.ru>
References: <20261112184513.2324634-1-mjt@tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Alex Bennée <alex.bennee@linaro.org>

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Gustavo Romero <gromero@redhat.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index fa0c6d0c9bc..3d53e104c5b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2945,7 +2945,7 @@ F: tests/qtest/vmgenid-test.c
 
 VM Launch Update
 M: Ani Sinha <anisinha@redhat.com>
-M: Gerd Hoffman <kraxel@redhat.com>
+M: Gerd Hoffmann <kraxel@redhat.com>
 S: Maintained
 F: hw/misc/vmlaunchupdate.c
 F: include/hw/misc/vmlaunchupdate.h
-- 
2.47.3


