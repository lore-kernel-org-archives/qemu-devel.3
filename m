Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 194DFC25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 03:47:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7S4O-0001Lq-NU; Wed, 15 May 2024 23:46:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1s7S4M-0001G6-Py
 for qemu-devel@nongnu.org; Wed, 15 May 2024 23:46:14 -0400
Received: from esa9.hc1455-7.c3s2.iphmx.com ([139.138.36.223])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1s7S4G-0003Ie-QJ
 for qemu-devel@nongnu.org; Wed, 15 May 2024 23:46:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1715831168; x=1747367168;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=80rS40WcKBkE0ShoPSMJANqVZD0Lt8DUQZoeiqCrb80=;
 b=Jb+evdrIs63anRWipXTExdD/qvm8F0yX1vSjr3spwmCyMsQ9ffF0ULN5
 WPugLD+EK5XYvDGOIWmm/bBhax240HGUbkC1CYTyzN7zkcIWap0RvSz5M
 3tJ4PCKDYherQNKe2QVJ8q/OUZkDZVYgUp0jIv7fGULb7kE0/xeyOy6vk
 /xc2V5i7ri4HLWvmgsO2iW96UF8gHJ1TRVUnJZ9dVu9c9sg+JwF/SIHzM
 GLOqCfKHRCXsit+2FhOU6jPoQCFM+1HHwBOqaDv0JLD21XavrFxHgYlY3
 oVMFd4Zxq8T3VCaBELS19xUwFzGbADndOot8OfHWgS9cd3p+2oW/vadT/ w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="146913477"
X-IronPort-AV: E=Sophos;i="6.08,163,1712588400"; d="scan'208";a="146913477"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
 by esa9.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 May 2024 12:46:04 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com
 [192.168.87.60])
 by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id C99B2D648E
 for <qemu-devel@nongnu.org>; Thu, 16 May 2024 12:46:02 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 0763FD620F
 for <qemu-devel@nongnu.org>; Thu, 16 May 2024 12:46:02 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 8940820094AC3
 for <qemu-devel@nongnu.org>; Thu, 16 May 2024 12:46:01 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id AA0C51A000A;
 Thu, 16 May 2024 11:46:00 +0800 (CST)
To: Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>
Cc: Hailiang Zhang <zhanghailiang@xfusion.com>, qemu-devel@nongnu.org,
 Zhang Chen <chen.zhang@intel.com>, Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH v2 1/3] migration/colo: Minor fix for colo error message
Date: Thu, 16 May 2024 11:45:15 +0800
Message-Id: <20240516034517.1353664-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28390.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28390.004
X-TMASE-Result: 10-1.852500-10.000000
X-TMASE-MatchedRID: r52rw5mZIl/a0OexaGjzmk7nLUqYrlslFIuBIWrdOeMiB3Nk/d/KP9Mv
 z+IPE7DW7hkjCJvdG+GFlygKFYYohzcpdZ3fQiLdFEUknJ/kEl5lVdRvgpNpe/oLR4+zsDTt8fx
 dFDBKE7vJOzo0zoh97WQnezFgF/2/XS8HAdWoUGtuskiWFW5u+j2emWw3Bruvi2iFBFgmW/iwDU
 DWeIN2KcoD/lj6mZtg1JscoP4eslSGk+xUaqdMDwHEKwHwYevbwUSxXh+jiUgkww/gwY7hMA==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
Received-SPF: pass client-ip=139.138.36.223;
 envelope-from=lizhijian@fujitsu.com; helo=esa9.hc1455-7.c3s2.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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
Reply-to:  Li Zhijian <lizhijian@fujitsu.com>
From:  Li Zhijian via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

- Explicitly show the missing module name: replication
- Fix capability name to x-colo

Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Zhang Chen <chen.zhang@intel.com>
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
V2: Collected reviewed-by tags
---
 migration/migration.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 5cfe420a76..0feb354e47 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -517,13 +517,13 @@ void migration_incoming_disable_colo(void)
 int migration_incoming_enable_colo(void)
 {
 #ifndef CONFIG_REPLICATION
-    error_report("ENABLE_COLO command come in migration stream, but COLO "
-                 "module is not built in");
+    error_report("ENABLE_COLO command come in migration stream, but the "
+                 "replication module is not built in");
     return -ENOTSUP;
 #endif
 
     if (!migrate_colo()) {
-        error_report("ENABLE_COLO command come in migration stream, but c-colo "
+        error_report("ENABLE_COLO command come in migration stream, but x-colo "
                      "capability is not set");
         return -EINVAL;
     }
-- 
2.31.1


