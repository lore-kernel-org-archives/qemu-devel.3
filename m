Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CB1ACCD1A3
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 12:28:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqtmt-0003wi-Jb; Wed, 18 Sep 2024 08:28:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@treblig.org>) id 1sqtms-0003wE-FD
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 08:28:02 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@treblig.org>) id 1sqtmp-0008Ak-Ij
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 08:28:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
 :Subject; bh=wznyxxNKJ1rd9+anIkNOhhOlhQ1LFcvsvDU375DO9M0=; b=jl9X1aHCK2CIVIci
 n0P+ZS2j3GSPysEN67NVm4g+qbJWHJdfOaa4eLh0lqQJJD/xXeW/6G+GxNz9eF+/UWhpm/hpqbw2Q
 aICgNXmn5aB6YvcHbCP+eJnjLKQFpzNBFp7ZFnsgnRyMIPc/q0qqfHZqBWYTckMsoT8RwDLwv+ois
 KTHJVf8LWl8uv+bsnwGUrcCQt1fmLWIk0M4XaPwx0r2cjWX6L6mAsLXWewm4tBm50O9mQ0ghsAA31
 6wPvg35y66uMmTGWPjTUVSJMZtuQgR1RCvobgeja8S5Jz6kPTSXdyta0MWeJUbdyPvGqUu3sL6E+E
 fUYJHCSf6fwpB4nzhg==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
 by mx.treblig.org with esmtp (Exim 4.96)
 (envelope-from <dave@treblig.org>) id 1sqtmk-006Hgf-1H;
 Wed, 18 Sep 2024 12:27:54 +0000
From: dave@treblig.org
To: pbonzini@redhat.com,
	berrange@redhat.com,
	eduardo@habkost.net
Cc: qemu-devel@nongnu.org,
	"Dr. David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH] hw/sysbus: Remove unused sysbus_mmio_unmap
Date: Wed, 18 Sep 2024 13:27:53 +0100
Message-ID: <20240918122753.22411-1-dave@treblig.org>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dave@treblig.org;
 helo=mx.treblig.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: "Dr. David Alan Gilbert" <dave@treblig.org>

The last use of sysbus_mmio_unmap was removed by
  981b1c6266 ("spapr/xive: rework the mapping the KVM memory regions")

Remove it.

Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>
---
 hw/core/sysbus.c    | 10 ----------
 include/hw/sysbus.h |  1 -
 2 files changed, 11 deletions(-)

diff --git a/hw/core/sysbus.c b/hw/core/sysbus.c
index ad34fb7344..e64d99c8ed 100644
--- a/hw/core/sysbus.c
+++ b/hw/core/sysbus.c
@@ -154,16 +154,6 @@ static void sysbus_mmio_map_common(SysBusDevice *dev, int n, hwaddr addr,
     }
 }
 
-void sysbus_mmio_unmap(SysBusDevice *dev, int n)
-{
-    assert(n >= 0 && n < dev->num_mmio);
-
-    if (dev->mmio[n].addr != (hwaddr)-1) {
-        memory_region_del_subregion(get_system_memory(), dev->mmio[n].memory);
-        dev->mmio[n].addr = (hwaddr)-1;
-    }
-}
-
 void sysbus_mmio_map(SysBusDevice *dev, int n, hwaddr addr)
 {
     sysbus_mmio_map_common(dev, n, addr, false, 0);
diff --git a/include/hw/sysbus.h b/include/hw/sysbus.h
index 3cb29a480e..c9b1e0e90e 100644
--- a/include/hw/sysbus.h
+++ b/include/hw/sysbus.h
@@ -82,7 +82,6 @@ qemu_irq sysbus_get_connected_irq(SysBusDevice *dev, int n);
 void sysbus_mmio_map(SysBusDevice *dev, int n, hwaddr addr);
 void sysbus_mmio_map_overlap(SysBusDevice *dev, int n, hwaddr addr,
                              int priority);
-void sysbus_mmio_unmap(SysBusDevice *dev, int n);
 
 bool sysbus_realize(SysBusDevice *dev, Error **errp);
 bool sysbus_realize_and_unref(SysBusDevice *dev, Error **errp);
-- 
2.46.0


