Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F007CF64B1
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 04:18:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMdIO-00020P-IV; Fri, 21 Nov 2025 21:24:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMdIH-0001qV-Ke; Fri, 21 Nov 2025 21:24:09 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMdHL-000565-MR; Fri, 21 Nov 2025 21:24:05 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 267DB16C6F3;
 Fri, 21 Nov 2025 16:51:56 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 74C8F321990;
 Fri, 21 Nov 2025 16:52:04 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, "Richard W.M. Jones" <rjones@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.1.3 27/76] block/curl.c: Fix CURLOPT_VERBOSE parameter type
Date: Fri, 21 Nov 2025 16:51:05 +0300
Message-ID: <20251121135201.1114964-27-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.1.3-20251121155857@cover.tls.msk.ru>
References: <qemu-stable-10.1.3-20251121155857@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: "Richard W.M. Jones" <rjones@redhat.com>

In commit ed26056d90 ("block/curl.c: Use explicit long constants in
curl_easy_setopt calls") we missed a further call that takes a long
parameter.

Reported-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Richard W.M. Jones <rjones@redhat.com>
Message-ID: <20251013124127.604401-1-rjones@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit ad97769e9dcf4dbdaae6d859176e5f37fd6a7c66)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/block/curl.c b/block/curl.c
index 1102a3aa2f..cbfb847dc4 100644
--- a/block/curl.c
+++ b/block/curl.c
@@ -524,7 +524,7 @@ static int curl_init_state(BDRVCURLState *s, CURLState *state)
 #endif
 
 #ifdef DEBUG_VERBOSE
-        if (curl_easy_setopt(state->curl, CURLOPT_VERBOSE, 1)) {
+        if (curl_easy_setopt(state->curl, CURLOPT_VERBOSE, 1L)) {
             goto err;
         }
 #endif
-- 
2.47.3


