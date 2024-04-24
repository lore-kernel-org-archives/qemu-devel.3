Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10681C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 20:22:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzj7e-000440-IJ; Wed, 24 Apr 2024 16:21:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1rzj7a-00043p-Ti
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 16:21:38 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1rzj7Y-0004ZU-Pd
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 16:21:38 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id CDF1561885;
 Wed, 24 Apr 2024 23:21:37 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 93F6EBE6D3;
 Wed, 24 Apr 2024 23:21:30 +0300 (MSK)
Received: (nullmailer pid 1465571 invoked by uid 1000);
 Wed, 24 Apr 2024 20:21:30 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-tivial@nongnu.org, Song Gao <gaosong@loongson.cn>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH] target/loongarch/cpu.c: typo fix: expection
Date: Wed, 24 Apr 2024 23:21:06 +0300
Message-Id: <20240424202106.1465526-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

Fixes: 1590154ee437 ("target/loongarch: Fix qemu-system-loongarch64 assert failed with the option '-d int'")
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 target/loongarch/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 203a349055..294bdbfa93 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -92,7 +92,7 @@ void G_NORETURN do_raise_exception(CPULoongArchState *env,
 {
     CPUState *cs = env_cpu(env);
 
-    qemu_log_mask(CPU_LOG_INT, "%s: expection: %d (%s)\n",
+    qemu_log_mask(CPU_LOG_INT, "%s: exception: %d (%s)\n",
                   __func__,
                   exception,
                   loongarch_exception_name(exception));
-- 
2.39.2


