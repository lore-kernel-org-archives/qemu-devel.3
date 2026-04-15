Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF3A2F43821
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 14:31:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wD1Gm-0000o0-GA; Wed, 15 Apr 2026 10:31:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1wD1Gi-0000nh-66
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 10:31:04 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1wD1Gd-0006bM-Tr
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 10:31:03 -0400
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fwk7V0srbzJ46BV;
 Wed, 15 Apr 2026 22:29:58 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
 by mail.maildlp.com (Postfix) with ESMTPS id 5F5114056B;
 Wed, 15 Apr 2026 22:30:41 +0800 (CST)
Received: from SecurePC-101-06.huawei.com (10.123.51.176) by
 dubpeml500005.china.huawei.com (7.214.145.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 15 Apr 2026 15:30:40 +0100
To: <linux-cxl@vger.kernel.org>, <qemu-devel@nongnu.org>, <mst@redhat.com>,
 Fan Ni <nifan.cxl@gmail.com>
CC: <linuxarm@huawei.com>, <venkataravis@micron.com>
Subject: [PATCH] MAINTAINERS: Update CXL maintainers entry including adding
 linux-cxl list
Date: Wed, 15 Apr 2026 15:30:39 +0100
Message-ID: <20260415143040.22223-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.123.51.176]
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 dubpeml500005.china.huawei.com (7.214.145.207)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The CXL maintainers entry needs an update.
For a while convention has been to +CC linux-cxl@vger.kernel.org to get
better coverage for CXL aspects so formalize that with an L entry.

Drop Fan as he has not been at Samsung for a while now.
Switch my email address over to my kernel.org one.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

---

I'll look to add some more reviewer / maintainers in the coming months as
I'm not keen on being the sole person for this one given fairly high level
of activity. Note the email address change doesn't mean I'll be less active
on this!

---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index ad215eced84d..1fb25f8637eb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3190,8 +3190,8 @@ F: tests/qtest/migration/cpr*
 F: docs/devel/migration/CPR.rst
 
 Compute Express Link
-M: Jonathan Cameron <jonathan.cameron@huawei.com>
-R: Fan Ni <fan.ni@samsung.com>
+M: Jonathan Cameron <jic23@kernel.org>
+L: linux-cxl@vger.kernel.org
 S: Supported
 F: hw/cxl/
 F: hw/mem/cxl_type3.c
-- 
2.51.0


