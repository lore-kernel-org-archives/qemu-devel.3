Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26BD8CEBF76
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2024 06:15:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1su4Ck-00058g-F9; Fri, 27 Sep 2024 02:11:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1su4Cf-0004lp-3h; Fri, 27 Sep 2024 02:11:45 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1su4Cd-0003Gj-Gv; Fri, 27 Sep 2024 02:11:44 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 8B1BD92D19;
 Fri, 27 Sep 2024 09:10:51 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 06E2014670B;
 Fri, 27 Sep 2024 09:11:22 +0300 (MSK)
Received: (nullmailer pid 573362 invoked by uid 1000);
 Fri, 27 Sep 2024 06:11:21 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH 08/27] qemu-img: simplify --repair error message
Date: Fri, 27 Sep 2024 09:11:02 +0300
Message-Id: <20240927061121.573271-9-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240927061121.573271-1-mjt@tls.msk.ru>
References: <20240927061121.573271-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 qemu-img.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 1bd88fcf63..9157a6b45d 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -859,8 +859,9 @@ static int img_check(const img_cmd_t *ccmd, int argc, char **argv)
             } else if (!strcmp(optarg, "all")) {
                 fix = BDRV_FIX_LEAKS | BDRV_FIX_ERRORS;
             } else {
-                error_exit(argv[0], "Unknown option value for -r "
-                           "(expecting 'leaks' or 'all'): %s", optarg);
+                error_exit(argv[0],
+                           "--repair (-r) expects 'leaks' or 'all' not '%s'",
+                           optarg);
             }
             break;
         case OPTION_OUTPUT:
-- 
2.39.5


