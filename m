Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BEFDC3DA63
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 09:19:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVpBm-0007Ms-RA; Mon, 22 Jul 2024 05:18:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1sVpBi-00077e-Vx; Mon, 22 Jul 2024 05:18:35 -0400
Received: from esa9.hc1455-7.c3s2.iphmx.com ([139.138.36.223])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1sVpBh-00070N-9S; Mon, 22 Jul 2024 05:18:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1721639913; x=1753175913;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=P3P6o/hHWKwSk8zwfRsRoB21Dab6y8uYnsWJ5I8CG0g=;
 b=VxsXfkcuOBVm18+3qcfs6MJU1nXhDwiRFjSNxOq+yZhWyWhM3oNBEFq5
 3EZls3ZCbYyXxNa/onHEqGK2yuD1ODk13ufJjci0wX75m91ZALPqY0rbG
 Tf8LVdw/VsR/35rZzWJdOn1ExvWk0r0mD4y2kUh0UK45lO0l3ZzXx8Quc
 lGM4YlPQXLEOfQYGiyDkUwU4QTV0fXV+aREURPy5wGZCtqCU6DjN8jJJi
 SprZt804PSjOeFRenzpc5NUeGLRukkgmX7nMEDlYyKQNlJUc3ZoZV6FAM
 WW6S47vlTG35OpaNA8I1ENzxXabPImvxF9KSXiCm+VwaJ/oJK57mOQrmj g==;
X-IronPort-AV: E=McAfee;i="6700,10204,11140"; a="156406928"
X-IronPort-AV: E=Sophos;i="6.09,227,1716217200"; d="scan'208";a="156406928"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
 by esa9.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jul 2024 18:18:29 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com
 [192.168.87.59])
 by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 7FF44D29E1;
 Mon, 22 Jul 2024 18:18:27 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id CD668BF3C0;
 Mon, 22 Jul 2024 18:18:26 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 60C71E4A97;
 Mon, 22 Jul 2024 18:18:26 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.225.88])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id AFEFB1A000A;
 Mon, 22 Jul 2024 17:18:25 +0800 (CST)
To: qemu-devel@nongnu.org, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>
Cc: Yao Xingtao <yaoxt.fnst@fujitsu.com>,
	qemu-block@nongnu.org
Subject: [PATCH 2/2] nvme/ctrl: remove useless type cast
Date: Mon, 22 Jul 2024 05:17:28 -0400
Message-ID: <20240722091728.4334-3-yaoxt.fnst@fujitsu.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240722091728.4334-1-yaoxt.fnst@fujitsu.com>
References: <20240722091728.4334-1-yaoxt.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28544.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28544.006
X-TMASE-Result: 10--0.785700-10.000000
X-TMASE-MatchedRID: XZZXNV16gdtlYwkarmHZPhF4zyLyne+AVBDQSDMig9F9KJhEY+vRMWzT
 RlDGU3PzNFHfw012zdOAMuqetGVetiVvu9chHp+mavP8b9lJtWr6C0ePs7A07X1HhKzShSYnI5+
 8RXX3JMA1Fa/3I4ECZQQCyujzlKw4LGSfBBHWL0eLPQgu4pQa3cdAgcyllMB83Xfe0MShs0/fd7
 4yK5Mw3LsoH8M4EIxvhpPsVGqnTA8BxCsB8GHr28FEsV4fo4lIJMMP4MGO4TA=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
Received-SPF: pass client-ip=139.138.36.223;
 envelope-from=yaoxt.fnst@fujitsu.com; helo=esa9.hc1455-7.c3s2.iphmx.com
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

The type of req->cmd is NvmeCmd, cast the pointer of this type to
NvmeCmd* is useless.

Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>
---
 hw/nvme/ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 5b1b0cabcfc3..221818f551cd 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -4167,7 +4167,7 @@ static bool nvme_zone_matches_filter(uint32_t zafs, NvmeZone *zl)
 
 static uint16_t nvme_zone_mgmt_recv(NvmeCtrl *n, NvmeRequest *req)
 {
-    NvmeCmd *cmd = (NvmeCmd *)&req->cmd;
+    NvmeCmd *cmd = &req->cmd;
     NvmeNamespace *ns = req->ns;
     /* cdw12 is zero-based number of dwords to return. Convert to bytes */
     uint32_t data_size = (le32_to_cpu(cmd->cdw12) + 1) << 2;
-- 
2.41.0


