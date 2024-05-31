Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01A13C25B75
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 06:14:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCvWV-00040M-69; Fri, 31 May 2024 02:13:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1sCvWP-0003yk-Cs
 for qemu-devel@nongnu.org; Fri, 31 May 2024 02:13:50 -0400
Received: from esa6.hc1455-7.c3s2.iphmx.com ([68.232.139.139])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1sCvWN-0006gY-F3
 for qemu-devel@nongnu.org; Fri, 31 May 2024 02:13:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1717136028; x=1748672028;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=zOrG5nL7sj8c2PAFPO5ajZsnXzp1fBu9mcV/Tl5hyq0=;
 b=Pihm7DER0XMcI/8vTuEyDjHXGPj91psEfla2XeQFtqhKlQjE87IkobWa
 hL8o3nDvP/5dFo4vqDGCB874AEM67noTXKM3RrVLnqO53mMX7L1/VtWVj
 ncO2wkLHpyLgOuzkgj5cx1TvPtUYo5iyQVneVafgUL+9yv+l+0H3vAwki
 fueLNPxYrs4DGg/I0ryXjBpL/ji+D9VrrY3hSc6+rApZ+AIqWE5WdCCx7
 024eGTrmgEWwnjZVvsKZpcHpsHEH5xmgZfkZWJhUEVY8rqESZK8Sa+lN5
 O0GS8+RBj/RJvnIJzRZdRfOnndnfr+DmlRZn3Jre3NBXWhFDrIuNdqCdn A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="162847266"
X-IronPort-AV: E=Sophos;i="6.08,203,1712588400"; d="scan'208";a="162847266"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
 by esa6.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 May 2024 15:13:41 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com
 [192.168.83.65])
 by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id A4A20CD6E3
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 15:13:38 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id E8B38D5604
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 15:13:37 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 75EDF21CB2F
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 15:13:37 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id A2F1F1A000A;
 Fri, 31 May 2024 14:13:36 +0800 (CST)
To: qemu-devel@nongnu.org
Cc: fan.ni@samsung.com, jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
 Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH] cxl: Get rid of unused cfmw_list
Date: Fri, 31 May 2024 14:13:17 +0800
Message-Id: <20240531061317.865673-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28420.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28420.005
X-TMASE-Result: 10-7.221300-10.000000
X-TMASE-MatchedRID: HyBr+9HIEaxyeiFPOFIChC0UvD/exuSeT5ysQDj6eFmOVdQAiMmbZ87F
 l0igGfZUSUQWNWP9oCy12HagvbwDji/7QU2czuUNA9lly13c/gE/Ff5CERZ4s3wo4j2I0uMKo8W
 MkQWv6iV3LAytsQR4e1cppCzPq+1UsjvNV98mpPONH2f4xCl6E7zJzOMWskDwkj0HIfV2979fLF
 KMGcObee/1WebgI1lXy3hZ3qDjsrMOYyK1rEtv/gMwxaUMm86ivxp/Q03XTWw=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
Received-SPF: pass client-ip=68.232.139.139;
 envelope-from=lizhijian@fujitsu.com; helo=esa6.hc1455-7.c3s2.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Reply-to:  Li Zhijian <lizhijian@fujitsu.com>
From:  Li Zhijian via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

There is no user for this member. All '-M cxl-fmw.N' options have
been parsed and saved to CXLState.fixed_windows.

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 hw/cxl/cxl-host.c    | 1 -
 include/hw/cxl/cxl.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
index c5f5fcfd64d0..926d3d3da705 100644
--- a/hw/cxl/cxl-host.c
+++ b/hw/cxl/cxl-host.c
@@ -335,7 +335,6 @@ static void machine_set_cfmw(Object *obj, Visitor *v, const char *name,
     for (it = cfmw_list; it; it = it->next) {
         cxl_fixed_memory_window_config(state, it->value, errp);
     }
-    state->cfmw_list = cfmw_list;
 }
 
 void cxl_machine_init(Object *obj, CXLState *state)
diff --git a/include/hw/cxl/cxl.h b/include/hw/cxl/cxl.h
index 75e47b686441..e3ecbef03872 100644
--- a/include/hw/cxl/cxl.h
+++ b/include/hw/cxl/cxl.h
@@ -43,7 +43,6 @@ typedef struct CXLState {
     MemoryRegion host_mr;
     unsigned int next_mr_idx;
     GList *fixed_windows;
-    CXLFixedMemoryWindowOptionsList *cfmw_list;
 } CXLState;
 
 struct CXLHost {
-- 
2.29.2


