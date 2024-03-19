Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78434C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 02:16:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmP1d-0001wT-8n; Mon, 18 Mar 2024 22:16:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruansy.fnst@fujitsu.com>)
 id 1rmP1a-0001vi-Lt
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 22:16:23 -0400
Received: from esa8.hc1455-7.c3s2.iphmx.com ([139.138.61.253])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruansy.fnst@fujitsu.com>)
 id 1rmP1X-0006A7-Go
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 22:16:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1710814579; x=1742350579;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=yPlnyuafCMnxZOVk/wucZ8tlPEnzOIwrkzZs/ScR5RE=;
 b=SyZ5Ri7gPqWGZUa+nSPXgf6ovvh3n5ub3WRfDPT+YsEn5dS5gUAxZuIf
 QXcLzf4fu8LFG50gS1bu6Bz4QUYS9ai5M2YW+I45EBwDNOdqOKjpzhlPF
 BlHMjL4lZmTmtdnQcNBh7U3hxBuehaC3ZuTIC90bautOuNq/IQwE94eYv
 zj3zPkc/PBYM652vJ3fgk5l+RjoKT0hEgGSdw1ReM5t0tjLSr/ezRkcFB
 TEDs8EaZxgfZnuR57w7FHMLp5K0T5eI6zCl8voESsRXYxwCOQwmsTo4IX
 XSP0lPX0i5tsohfIxt2g35SbDT1h5Um+2JD7i3Bc4TcO8IlVXG/duu23n Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="140654468"
X-IronPort-AV: E=Sophos;i="6.07,135,1708354800"; d="scan'208";a="140654468"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
 by esa8.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Mar 2024 11:16:15 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com
 [192.168.83.64])
 by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id F0D12FBD81
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 11:16:12 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 2F1615439D
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 11:16:12 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 6D9992009327B
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 11:16:11 +0900 (JST)
Received: from irides.g08.fujitsu.local (unknown [10.167.226.114])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id B6E601A006C;
 Tue, 19 Mar 2024 10:16:10 +0800 (CST)
To: dave@treblig.org
Cc: qemu-devel@nongnu.org, jonathan.cameron@huawei.com,
 Yao Xingtao <yaoxt.fnst@fujitsu.com>
Subject: [PATCH] monitor/hmp-cmds-target.c: append a space in error message in
 gpa2hva()
Date: Tue, 19 Mar 2024 10:16:10 +0800
Message-Id: <20240319021610.2423844-1-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28260.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28260.004
X-TMASE-Result: 10--8.990700-10.000000
X-TMASE-MatchedRID: e2rJ4fMNACUvKBNTYKG+pfCCu8kVj0TRwwrHF5pwze/k++hGM2nSex2r
 rGe8rZbLkZbSbjboRzfmn3xyPJAJoh2P280ZiGmR30kDaWZBE1QfimmlcABuN5soi2XrUn/J8m+
 hzBStanvIM9mETCO70yAHAopEd76vzWazWPdB3mankz5ZjAR9f+qGb+L8R3+jEY3iCjDhDKY6hF
 HaHCl56g==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
Received-SPF: pass client-ip=139.138.61.253;
 envelope-from=ruansy.fnst@fujitsu.com; helo=esa8.hc1455-7.c3s2.iphmx.com
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
Reply-to:  Shiyang Ruan <ruansy.fnst@fujitsu.com>
From:  Shiyang Ruan via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Yao Xingtao <yaoxt.fnst@fujitsu.com>

In qemu monitor mode, when we use gpa2hva command to print the host
virtual address corresponding to a guest physical address, if the gpa is
not in RAM, the error message is below:

(qemu) gpa2hva 0x750000000
Memory at address 0x750000000is not RAM

a space is missed between '0x750000000' and 'is'.

Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>
---
 monitor/hmp-cmds-target.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/monitor/hmp-cmds-target.c b/monitor/hmp-cmds-target.c
index 9338ae8440..ff01cf9d8d 100644
--- a/monitor/hmp-cmds-target.c
+++ b/monitor/hmp-cmds-target.c
@@ -261,7 +261,7 @@ void *gpa2hva(MemoryRegion **p_mr, hwaddr addr, uint64_t size, Error **errp)
     }
 
     if (!memory_region_is_ram(mrs.mr) && !memory_region_is_romd(mrs.mr)) {
-        error_setg(errp, "Memory at address 0x%" HWADDR_PRIx "is not RAM", addr);
+        error_setg(errp, "Memory at address 0x%" HWADDR_PRIx " is not RAM", addr);
         memory_region_unref(mrs.mr);
         return NULL;
     }
-- 
2.27.0


