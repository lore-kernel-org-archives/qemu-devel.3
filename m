Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F329C3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 09:19:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVpBi-00076S-NP; Mon, 22 Jul 2024 05:18:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1sVpBg-00074R-VP
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 05:18:32 -0400
Received: from esa8.hc1455-7.c3s2.iphmx.com ([139.138.61.253])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1sVpBe-00070C-MZ
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 05:18:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1721639910; x=1753175910;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ZvFvlkZKdi5W69jVbhfr83v0lCFGwEMMmPywyanuR5c=;
 b=Or6N4EAxdm4Hd5U9IY+Zw9nflaGc3VKS/95g9LqYwhshE/PsaArQXVx+
 DDHzFcIcZKb48xdhmoHUsJL3VnBQXrOo2hRGXGsNdvJyF69d656FmrBJT
 mnNqGmvbeJGvuuOYJJbdllkqorzpmMktO8HZbKLgJxS3OCos1R+hKZPLV
 8PwwvJ5PmVypCO/WyTj6vgEDHD5sDbg+QIue8+66nCvQ/rEPRBLwNv3kB
 o1lOXib2B0LXNzYu98HLAbULVUrNJobu3XIntcnrD58cTYjz6uuhKHCUb
 JO8xl8chSYwxiQ8y7RoZ0RePAiNeG4bT6yRdzMfzG60fqQZljDEQ1VDYM g==;
X-IronPort-AV: E=McAfee;i="6700,10204,11140"; a="156131696"
X-IronPort-AV: E=Sophos;i="6.09,227,1716217200"; d="scan'208";a="156131696"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
 by esa8.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jul 2024 18:18:24 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com
 [192.168.87.60])
 by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id DC63BD424D
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 18:18:21 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 3B26DD772C
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 18:18:21 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id C41EA20077821
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 18:18:20 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.225.88])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 1D4001A000A;
 Mon, 22 Jul 2024 17:18:20 +0800 (CST)
To: qemu-devel@nongnu.org, Huacai Chen <chenhuacai@kernel.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Yao Xingtao <yaoxt.fnst@fujitsu.com>
Subject: [PATCH 1/2] mips/loongson3_virt: remove useless type cast
Date: Mon, 22 Jul 2024 05:17:27 -0400
Message-ID: <20240722091728.4334-2-yaoxt.fnst@fujitsu.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240722091728.4334-1-yaoxt.fnst@fujitsu.com>
References: <20240722091728.4334-1-yaoxt.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28544.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28544.006
X-TMASE-Result: 10--5.976700-10.000000
X-TMASE-MatchedRID: v71phiYrRiEa66IW4jMGMZU7Bltw5qVLwTlc9CcHMZerwqxtE531VIPc
 XuILVCbaWQbTJ68QuVgWYr4WijAYQ5cFdomgH0lnFEUknJ/kEl6YwzE9E8g5OfoLR4+zsDTtFEA
 kLaTcFnqI/UV79dj9Nmav4DJCbJGDAYupYlXdWF9CiCqLP1WREA==
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

The type of kernel_entry, kernel_low and kernel_high is uint64_t, cast
the pointer of this type to uint64_t* is useless.

Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>
---
 hw/mips/loongson3_virt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/mips/loongson3_virt.c b/hw/mips/loongson3_virt.c
index 4ad36f0c5b64..408e3d7054cd 100644
--- a/hw/mips/loongson3_virt.c
+++ b/hw/mips/loongson3_virt.c
@@ -355,8 +355,8 @@ static uint64_t load_kernel(CPUMIPSState *env)
 
     kernel_size = load_elf(loaderparams.kernel_filename, NULL,
                            cpu_mips_kseg0_to_phys, NULL,
-                           (uint64_t *)&kernel_entry,
-                           (uint64_t *)&kernel_low, (uint64_t *)&kernel_high,
+                           &kernel_entry,
+                           &kernel_low, &kernel_high,
                            NULL, 0, EM_MIPS, 1, 0);
     if (kernel_size < 0) {
         error_report("could not load kernel '%s': %s",
-- 
2.41.0


