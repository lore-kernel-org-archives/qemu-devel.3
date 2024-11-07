Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C4B2D43352
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 12:36:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t91k7-0004dt-TO; Thu, 07 Nov 2024 07:36:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1t91js-0004QE-48
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 07:35:53 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1t91jq-0001ah-Fk
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 07:35:51 -0500
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XkhPY1HD8z6LDBD;
 Thu,  7 Nov 2024 20:35:45 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 17AE61403A2;
 Thu,  7 Nov 2024 20:35:49 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 7 Nov 2024 13:35:48 +0100
To: "Michael S . Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 <qemu-devel@nongnu.org>
CC: <linuxarm@huawei.com>
Subject: [PATCH 2/5] qapi/qom: Change Since entry for
 AcpiGenericPortProperties to 9.2
Date: Thu, 7 Nov 2024 12:34:43 +0000
Message-ID: <20241107123446.902801-3-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241107123446.902801-1-Jonathan.Cameron@huawei.com>
References: <20241107123446.902801-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.122.19.247]
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 frapeml500008.china.huawei.com (7.182.85.71)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This feature was only applied during the 9.2 cycle, so reflect
that rather than 9.1.

Reported-by: Daniel P. Berrangé <berrange@redhat.com>
Closes: https://lore.kernel.org/qemu-devel/ZyngEiwmYeZ-DvCy@redhat.com/
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 qapi/qom.json | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qapi/qom.json b/qapi/qom.json
index a8beeabf1f..28ce24cd8d 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -877,7 +877,7 @@
 #     complex as there may be interleaving across multiple devices
 #     and shared links in the path.
 #
-# Since: 9.1
+# Since: 9.2
 ##
 { 'struct': 'AcpiGenericPortProperties',
   'data': { 'pci-bus': 'str',
-- 
2.43.0


