Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 169CFF46104
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 13:02:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4ev6-0002QC-9b; Mon, 23 Mar 2026 09:02:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w4etQ-00026V-ID; Mon, 23 Mar 2026 09:00:46 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w4etM-0006a9-U4; Mon, 23 Mar 2026 09:00:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1774270805; bh=UQQqlbJaJ5RkZK2i0A2EQ3HVrs2A4S5hB5+rTVk2aq4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=x/zVH4MBvhDeX4f51snbttxJTRmhvLK0/98RWrlHk+f5xo5Mg8cNkDtylvdOy1Ngh
 ULUT2r9IN2Cuiu8xPBRhufMZTZtaOHkBsmY3FLizrZRaSsznmOnhgsKfTly5/NpqrG
 gblG0QXaGnUZNF2y6wYq5ktIcN5RrixCZkjTMR9eNM9vhiNokIAmtlqcTEMFXpLUn1
 blqToNN3Y0U8zw1BgA13dyUXGznxZxg9bl7u5eJjAzm3IWtC0rMcbqvlcO7X/9vCR5
 rpcU/eZxZCSnPQwxGnszgHnZ2cf69C12cyTsqGLClhDwl0R93M85j4030gssE7N2q5
 jiaFQTLEotN2Q==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 13CF2196971;
 Mon, 23 Mar 2026 16:00:05 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id D404638515E;
 Mon, 23 Mar 2026 16:00:21 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: xieyi <xieyi@kylinos.cn>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 1/4] tests: fix typo in char unit test comment
Date: Mon, 23 Mar 2026 16:00:13 +0300
Message-ID: <20260323130021.376393-2-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260323130021.376393-1-mjt@tls.msk.ru>
References: <20260323130021.376393-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

From: xieyi <xieyi@kylinos.cn>

Signed-off-by: xieyi <xieyi@kylinos.cn>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 tests/unit/test-char.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/unit/test-char.c b/tests/unit/test-char.c
index 2869c4e09d..b88b557133 100644
--- a/tests/unit/test-char.c
+++ b/tests/unit/test-char.c
@@ -710,7 +710,7 @@ static void char_hub_test(void)
         /*
          * Now we are good to go, first repeat "lost" sequence, which
          * was already consumed and drained by the ring buffers, but
-         * pipe have not recieved that yet.
+         * the pipe has not received it yet.
          */
         ret = qemu_chr_fe_write(&chr_fe, (void *)"thisisit", 8);
         g_assert_cmpint(ret, ==, 8);
-- 
2.47.3


