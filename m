Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEF63C3DA5D
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 05:55:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWrRp-0005ti-IG; Thu, 25 Jul 2024 01:55:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1sWrRn-0005lh-6y
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 01:55:27 -0400
Received: from esa8.hc1455-7.c3s2.iphmx.com ([139.138.61.253])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1sWrRk-0006Cb-MF
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 01:55:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1721886924; x=1753422924;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=9ujSvd0zJhEIPXUzE24m+pcOZthTL15sfms1Y715el0=;
 b=t+Qp46Ab5jqQ6sfAzqCFxOoHg2hWMPDpMScSVt7ozFvqrmNzmVpqK2N9
 RVAnov3s2cgz3WDZaL2QfhSru4XFCZ0+RUKsNvuuDHLLJofPyWFGPg00V
 Mdabsln5LJP4sGVdKfBIgsmLMhmJR6xix0z7L2WFJixnwyk50Rxrix+Nr
 7mtAZ3C8I3oSQfVPlJ6udZmSX/ZXs21gEoR/C4NQBIjd/WMR4eZm2GZPd
 wdnzWmJSqnWnjS+dkqaYScnpsDolx4feeBYMHm99HjFM5m0aK/tRS7TQU
 sMS7E80PLBU4Cz2p5i1LrBCpqOzvvYd2bDXoaBWd7bUW20UkxzcQ5qK8w Q==;
X-IronPort-AV: E=McAfee;i="6700,10204,11143"; a="156486993"
X-IronPort-AV: E=Sophos;i="6.09,235,1716217200"; d="scan'208";a="156486993"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
 by esa8.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jul 2024 14:55:21 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com
 [192.168.87.58])
 by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 63FFCD801F
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2024 14:55:19 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id AE9B6D8BAF
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2024 14:55:18 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 40FFD200897C7
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2024 14:55:18 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.225.88])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id E182B1A000A;
 Thu, 25 Jul 2024 13:55:17 +0800 (CST)
To: qemu-devel@nongnu.org
Cc: Yao Xingtao <yaoxt.fnst@fujitsu.com>
Subject: [PATCH] scripts/coccinelle: New range.cocci
Date: Thu, 25 Jul 2024 01:54:47 -0400
Message-ID: <20240725055447.14512-1-yaoxt.fnst@fujitsu.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28550.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28550.005
X-TMASE-Result: 10--8.409100-10.000000
X-TMASE-MatchedRID: /Sl7yZT/bBLUm6Z+Xo4l3Do39wOA02LhyiKgKtIyB4rcPQu44z7O5NAO
 OSAF0cTNUh5maKIJAx8bYA1xraQblC/7QU2czuUNA9lly13c/gFSuvtBzlaEqLs3Yh2IOCYzm0I
 5Q/LYFVp7MSP7SLpuGCYjJHuLr7WemTaP8DfBDAWeAiCmPx4NwBnUJ0Ek6yhjxEHRux+uk8h+IC
 quNi0WJOX0vX5tzOgwZbrpuSlaQsmRdj19zxdZJ7ryUM76bJG3ftwZ3X11IV0=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
Received-SPF: pass client-ip=139.138.61.253;
 envelope-from=yaoxt.fnst@fujitsu.com; helo=esa8.hc1455-7.c3s2.iphmx.com
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
Reply-to:  Yao Xingtao <yaoxt.fnst@fujitsu.com>
From:  Yao Xingtao via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This is the semantic patch from commit 7b3e371526 "cxl/mailbox: make
range overlap check more readable"

Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>
---
 scripts/coccinelle/range.cocci | 49 ++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 scripts/coccinelle/range.cocci

diff --git a/scripts/coccinelle/range.cocci b/scripts/coccinelle/range.cocci
new file mode 100644
index 000000000000..21b07945ccb2
--- /dev/null
+++ b/scripts/coccinelle/range.cocci
@@ -0,0 +1,49 @@
+/*
+  Usage:
+
+    spatch \
+           --macro-file scripts/cocci-macro-file.h \
+           --sp-file scripts/coccinelle/range.cocci \
+           --keep-comments \
+           --in-place \
+           --dir .
+
+  Description:
+    Find out the range overlap check and use ranges_overlap() instead.
+
+  Note:
+    This pattern cannot accurately match the region overlap check, and you
+    need to manually delete the use cases that do not meet the conditions.
+
+    In addition, the parameters of ranges_overlap() may be filled incorrectly,
+    and some use cases may be better to use range_overlaps_range().
+*/
+
+@@
+expression E1, E2, E3, E4;
+@@
+(
+- E2 <= E3 || E1 >= E4
++ !ranges_overlap(E1, E2, E3, E4)
+|
+
+- (E2 <= E3) || (E1 >= E4)
++ !ranges_overlap(E1, E2, E3, E4)
+|
+
+- E1 < E4 && E2 > E3
++ ranges_overlap(E1, E2, E3, E4)
+|
+
+- (E1 < E4) && (E2 > E3)
++ ranges_overlap(E1, E2, E3, E4)
+|
+
+- (E1 >= E3 && E1 < E4) || (E2 > E3 && E2 <= E4)
++ ranges_overlap(E1, E2, E3, E4)
+
+|
+- ((E1 >= E3) && (E1 < E4)) || ((E2 > E3) && (E2 <= E4))
++ ranges_overlap(E1, E2, E3, E4)
+)
+
-- 
2.41.0


