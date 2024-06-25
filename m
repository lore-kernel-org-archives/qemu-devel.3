Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C563C3064D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 17:27:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sM9iL-000725-6a; Tue, 25 Jun 2024 13:12:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sM9hp-0006zI-2h
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 13:11:53 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sM9h6-0002cQ-QY
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 13:11:34 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4W7rrX07rDz6K6Z2;
 Wed, 26 Jun 2024 01:08:28 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 51F4F140B67;
 Wed, 26 Jun 2024 01:09:07 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 25 Jun 2024 18:09:06 +0100
To: <qemu-devel@nongnu.org>, <nifan.cxl@gmail.com>,
 <linux-cxl@vger.kernel.org>, <mst@redhat.com>, <armbru@redhat.com>
CC: <linuxarm@huawei.com>
Subject: [PATCH 2/2] hw/cxl/events: Mark cxl-add-dynamic-capacity and
 cxl-release-dynamic-capcity unstable
Date: Tue, 25 Jun 2024 18:08:05 +0100
Message-ID: <20240625170805.359278-3-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240625170805.359278-1-Jonathan.Cameron@huawei.com>
References: <20240625170805.359278-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.122.19.247]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Markus suggested that we make the unstable. I don't expect these
interfaces to change because of their tight coupling to the Compute
Express Link (CXL) Specification, Revision 3.1 Fabric Management API
definitions which can only be extended in backwards compatible way.
However, there seems little disadvantage in taking a cautious path
for now and marking them as unstable interfaces.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 qapi/cxl.json | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/qapi/cxl.json b/qapi/cxl.json
index a38622a0d1..bdfac67c47 100644
--- a/qapi/cxl.json
+++ b/qapi/cxl.json
@@ -453,6 +453,10 @@
 # @extents: The "Extent List" field as defined in Compute Express Link
 #     (CXL) Specification, Revision 3.1, Table 7-70.
 #
+# Features:
+#
+# @unstable: For now this command is subject to change.
+#
 # Since : 9.1
 ##
 { 'command': 'cxl-add-dynamic-capacity',
@@ -462,7 +466,8 @@
             'region': 'uint8',
             '*tag': 'str',
             'extents': [ 'CxlDynamicCapacityExtent' ]
-           }
+           },
+  'features': [ 'unstable' ]
 }
 
 ##
@@ -527,6 +532,10 @@
 # @extents: The "Extent List" field as defined in Compute Express
 #     Link (CXL) Specification, Revision 3.1, Table 7-71.
 #
+# Features:
+#
+# @unstable: For now this command is subject to change.
+#
 # Since : 9.1
 ##
 { 'command': 'cxl-release-dynamic-capacity',
@@ -538,5 +547,6 @@
             'region': 'uint8',
             '*tag': 'str',
             'extents': [ 'CxlDynamicCapacityExtent' ]
-           }
+           },
+  'features': [ 'unstable' ]
 }
-- 
2.43.0


