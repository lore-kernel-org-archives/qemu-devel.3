Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ADAFC48292
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 16:51:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVaDG-0006Ch-AJ; Thu, 01 Feb 2024 11:46:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+16c2638fe4346fda554c+7466+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1rVaAo-0002q7-1C
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 11:44:22 -0500
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+16c2638fe4346fda554c+7466+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1rVaAj-0002TS-5z
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 11:44:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
 Cc:Content-Type:Content-ID:Content-Description;
 bh=cI5cE7Mqa56oXquPAqcBShZgLjDP9Pq4cQYsmEeMuWM=; b=B8+9GumPRaJbx6e32Ayg9CfCSA
 JECO8B0ZJpuXiEoajR1EeOJZSm8kviU3lu9Zs+FvIDjXwbiqvwMNBeUX2BMU3xGcujo158OTX5LYS
 xS0CqCJPLDITACwjSbQzfS6TzCyVKtdoN9IWg8XRpz45vtUJCvP4pecITKoSjgX+op1hvkY+TmqMP
 NOcNcW3f1awp3xdSYgkT37qBrdcLrg7ARWAtf0YrwEhBSh7E7+FahG64HhUnaRl5VmFVeiVWSSdCl
 S3VwFLtBNy7KAQj3dzFaoq9+CHikoDAeVTa3KiaRpLitf7YKP1GW4rEZDXDpjhHIzDj12p5dKOYW3
 FYFVeNBA==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
 by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
 id 1rVaAf-0000000GIdh-2ji3 for qemu-devel@nongnu.org;
 Thu, 01 Feb 2024 16:44:15 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.97.1 #2 (Red
 Hat Linux)) id 1rVaAg-00000003ION-2pbn for qemu-devel@nongnu.org;
 Thu, 01 Feb 2024 16:44:14 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: qemu-devel@nongnu.org
Subject: [PULL 37/47] hw/net/lasi_i82596: Re-enable build
Date: Thu,  1 Feb 2024 16:44:02 +0000
Message-ID: <20240201164412.785520-38-dwmw2@infradead.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240201164412.785520-1-dwmw2@infradead.org>
References: <20240201164412.785520-1-dwmw2@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Received-SPF: none client-ip=2001:8b0:10b:1236::1;
 envelope-from=BATV+16c2638fe4346fda554c+7466+infradead.org+dwmw2@casper.srs.infradead.org;
 helo=casper.infradead.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

From: David Woodhouse <dwmw@amazon.co.uk>

When converting to the shiny build-system-du-jour, a typo prevented the
last_i82596 driver from being built. Correct the config option name to
re-enable the build. And include "sysemu/sysemu.h" so it actually builds.

Fixes: b1419fa66558 ("meson: convert hw/net")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2144
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 hw/net/lasi_i82596.c | 1 +
 hw/net/meson.build   | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/net/lasi_i82596.c b/hw/net/lasi_i82596.c
index 6a3147fe2d..09e830ba5f 100644
--- a/hw/net/lasi_i82596.c
+++ b/hw/net/lasi_i82596.c
@@ -14,6 +14,7 @@
 #include "qapi/error.h"
 #include "qemu/timer.h"
 #include "hw/sysbus.h"
+#include "sysemu/sysemu.h"
 #include "net/eth.h"
 #include "hw/net/lasi_82596.h"
 #include "hw/net/i82596.h"
diff --git a/hw/net/meson.build b/hw/net/meson.build
index 9afceb0619..2b426d3d5a 100644
--- a/hw/net/meson.build
+++ b/hw/net/meson.build
@@ -33,7 +33,7 @@ system_ss.add(when: 'CONFIG_MARVELL_88W8618', if_true: files('mv88w8618_eth.c'))
 system_ss.add(when: 'CONFIG_CADENCE', if_true: files('cadence_gem.c'))
 system_ss.add(when: 'CONFIG_STELLARIS_ENET', if_true: files('stellaris_enet.c'))
 system_ss.add(when: 'CONFIG_LANCE', if_true: files('lance.c'))
-system_ss.add(when: 'CONFIG_LASI_I82596', if_true: files('lasi_i82596.c'))
+system_ss.add(when: 'CONFIG_LASI_82596', if_true: files('lasi_i82596.c'))
 system_ss.add(when: 'CONFIG_I82596_COMMON', if_true: files('i82596.c'))
 system_ss.add(when: 'CONFIG_SUNHME', if_true: files('sunhme.c'))
 system_ss.add(when: 'CONFIG_FTGMAC100', if_true: files('ftgmac100.c'))
-- 
2.43.0


