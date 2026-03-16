Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5862FEFCBD4
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 07:11:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2273-0000dG-6Z; Mon, 16 Mar 2026 03:11:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w226V-00080F-KF; Mon, 16 Mar 2026 03:11:07 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w226U-0007oa-2h; Mon, 16 Mar 2026 03:11:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1773645003; bh=TkWaQgp9jhEp4k+GJCTApTpP59lyB+/awqTiFbyQpNI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Kwbz+yYN6uebNR0D36PRxQ6n7JEfKC8f59NEHSiUQTO4+3nNKY5lZURtxMk9yqDIn
 kBewDwxEqU1EjuvksZvuCveTWengp2MB98osmDcMItbDMAkEIG5GZJuxlCsCkPjzU5
 kRRnQxy3OzSiahSyN0l47qraZ5YMA9U0aQSGGEj+UMjMS3vEa85L4Yaas3xCi55kNx
 ofGv1hXFMVHNNVv+UNwGRWIeJvnwvpYIvVrmos/WhIjO/BJBl4y3FQtP1Fu/u+ECet
 all0k2+ktHy55Pn+bVn/euE9gJ9n6W5szks4f2NBAcoqEAn4HO0xPKE12ONnO4UMkV
 yiUym39s53t7w==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 442E7193C2F;
 Mon, 16 Mar 2026 10:10:03 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 43753380057;
 Mon, 16 Mar 2026 10:10:06 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>,
	qemu-trivial@nongnu.org
Subject: [PULL 13/14] meson.build: do not check for epoll.h (CONFIG_EPOLL)
Date: Mon, 16 Mar 2026 10:10:01 +0300
Message-ID: <20260316071005.91624-14-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260316071005.91624-1-mjt@tls.msk.ru>
References: <20260316071005.91624-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The only place where we used CONFIG_EPOLL was linux-user,
which now enables it unconditionally.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 meson.build | 1 -
 1 file changed, 1 deletion(-)

diff --git a/meson.build b/meson.build
index a0f5e900be..264a1c4b72 100644
--- a/meson.build
+++ b/meson.build
@@ -2595,7 +2595,6 @@ config_host_data.set('CONFIG_FSFREEZE', qga_fsfreeze)
 config_host_data.set('CONFIG_FSTRIM', qga_fstrim)
 
 # has_header
-config_host_data.set('CONFIG_EPOLL', cc.has_header('sys/epoll.h'))
 config_host_data.set('CONFIG_LINUX_MAGIC_H', cc.has_header('linux/magic.h'))
 valgrind = false
 if get_option('valgrind').allowed()
-- 
2.47.3


