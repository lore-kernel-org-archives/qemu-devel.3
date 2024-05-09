Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 557CAC25B10
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2024 03:29:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4uRl-0003ct-Bi; Wed, 08 May 2024 23:27:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1s4uRj-0003c2-LX
 for qemu-devel@nongnu.org; Wed, 08 May 2024 23:27:51 -0400
Received: from esa8.hc1455-7.c3s2.iphmx.com ([139.138.61.253])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1s4uRh-00045y-4J
 for qemu-devel@nongnu.org; Wed, 08 May 2024 23:27:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1715225269; x=1746761269;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=V+2KLvDv9pwq0N0vM09uKZi6Z3QabzNKsE0t4w071Vk=;
 b=UBjWalaK0A8aJ5aI1Lkgxe9A8YHZLM40rJr3kh3xe8M+Ya1oQO92nkmD
 tmRGGbsx/wo56B24kke4fK2iE8Xs5RTwyQP02GFjEzBRUo9SNIxO+eD/P
 4bq6+zMj1scNCMlJRpYdzVOT8YSws/2yWuJK88a1HdSWbp9yV2x8Feq3x
 bVZLcWLhp4FXz6OpVB5nf+xSZXQD8psT5H4ZrSOEC/fm0SMvoy209W2fw
 dpoPL7XDYJ3zHKZP9dA+HaSoK7bdsRpFeYjvAdZMVAa2AtYxCRYURRv2Q
 jedxhN2AFvoL2BtUlTlvcKQyTLiJECaU8z0rC05HW4crILIsWEKFnpa3C A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11067"; a="145716358"
X-IronPort-AV: E=Sophos;i="6.08,146,1712588400"; d="scan'208";a="145716358"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
 by esa8.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 May 2024 12:27:43 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com
 [192.168.83.64])
 by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 47F84C6905
 for <qemu-devel@nongnu.org>; Thu,  9 May 2024 12:27:41 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 836BF12ED79
 for <qemu-devel@nongnu.org>; Thu,  9 May 2024 12:27:40 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id EB6B42009327E
 for <qemu-devel@nongnu.org>; Thu,  9 May 2024 12:27:39 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 09A3F1A0002;
 Thu,  9 May 2024 11:27:38 +0800 (CST)
To: Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>
Cc: Hailiang Zhang <zhanghailiang@xfusion.com>, qemu-devel@nongnu.org,
 Zhang Chen <chen.zhang@intel.com>, Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH 1/3] migration/colo: Minor fix for colo error message
Date: Thu,  9 May 2024 11:31:04 +0800
Message-Id: <20240509033106.1321880-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28372.002
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28372.002
X-TMASE-Result: 10-1.852500-10.000000
X-TMASE-MatchedRID: r52rw5mZIl/a0OexaGjzmk7nLUqYrlslFIuBIWrdOeMiB3Nk/d/KP9Mv
 z+IPE7DW7hkjCJvdG+GFlygKFYYohzcpdZ3fQiLdFEUknJ/kEl6YwzE9E8g5OfoLR4+zsDTtF/a
 6QWbgQ20w9Tcsf0lwWRjfnFEtGkerg5AmD1NbZsNAWJgUvcuLccO36joBbyZeZqlPjeT2ZU5Zzo
 rPpYG7KZ1Cla4Jc50r1JscoP4eslSGk+xUaqdMDwHEKwHwYevbwUSxXh+jiUgkww/gwY7hMA==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
Received-SPF: pass client-ip=139.138.61.253;
 envelope-from=lizhijian@fujitsu.com; helo=esa8.hc1455-7.c3s2.iphmx.com
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

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 migration/migration.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 6502e169a3..b4a09c561c 100644
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


