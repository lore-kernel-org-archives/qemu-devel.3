Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26CCDC4829A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 08:04:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZnkZ-0004ny-Pf; Tue, 13 Feb 2024 03:02:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rZnkX-0004mo-LP; Tue, 13 Feb 2024 03:02:41 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rZnkW-0007LQ-7r; Tue, 13 Feb 2024 03:02:41 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 6A6924CBD6;
 Tue, 13 Feb 2024 11:01:57 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 933847CF24;
 Tue, 13 Feb 2024 11:01:52 +0300 (MSK)
Received: (nullmailer pid 160923 invoked by uid 1000);
 Tue, 13 Feb 2024 08:01:51 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 13/15] system: Move memory_ldst.c.inc to system
Date: Tue, 13 Feb 2024 11:01:49 +0300
Message-Id: <20240213080151.160839-14-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240213080151.160839-1-mjt@tls.msk.ru>
References: <20240213080151.160839-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: BALATON Zoltan <balaton@eik.bme.hu>

This file is only used by system/physmem.c so move them together.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 memory_ldst.c.inc => system/memory_ldst.c.inc | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename memory_ldst.c.inc => system/memory_ldst.c.inc (100%)

diff --git a/memory_ldst.c.inc b/system/memory_ldst.c.inc
similarity index 100%
rename from memory_ldst.c.inc
rename to system/memory_ldst.c.inc
-- 
2.39.2


