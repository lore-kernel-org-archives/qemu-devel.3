Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC079C30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 14:35:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOeac-0004zF-Cu; Tue, 02 Jul 2024 10:34:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sOeaZ-0004yf-4C
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:34:36 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sOeaU-0007dK-Ju
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:34:34 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WD54P2jTPz6J6pG;
 Tue,  2 Jul 2024 22:33:25 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 22EA6140CB9;
 Tue,  2 Jul 2024 22:34:26 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 2 Jul 2024 15:34:25 +0100
To: <linux-cxl@vger.kernel.org>, <mst@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, <qemu-devel@nongnu.org>, Li Zhijian
 <lizhijian@fujitsu.com>
CC: <linuxarm@huawei.com>
Subject: [PATCH qemu 0/3] hw/cxl: Misc minor improvements
Date: Tue, 2 Jul 2024 15:34:22 +0100
Message-ID: <20240702143425.717452-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.122.19.247]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Before pushing on to more significant features a few unrelated patches
doing tidying up + one to avoid people setting the memory backend both
for a CXL type 3 device and as normal RAM in an attempt to get SRAT to
cover it correctly.  We've had multiple 'bug' reports from this and if
nothing else I'd like to stop getting those!

Based on master + the two DCD series Michael Tsirkin has queued.

Based-on: [PATCH v8 00/14] Enabling DCD emulation support in Qemu
Based-on: https://lore.kernel.org/qemu-devel/20240523174651.1089554-1-nifan.cxl@gmail.com/
Based-on: [PATCH qemu 0/2] hw/cxl: DCD tweaks and improvements.
Based-on: https://lore.kernel.org/qemu-devel/20240625170805.359278-1-Jonathan.Cameron@huawei.com/

Fan Ni (1):
  hw/cxl/cxl-mailbox-utils: remove unneeded mailbox output payload space
    zeroing

Jonathan Cameron (1):
  hw/cxl: Check for multiple mappings of memory backends.

Li Zhijian (1):
  hw/cxl: Get rid of unused cfmw_list

 include/hw/cxl/cxl.h       |  1 -
 hw/cxl/cxl-host.c          |  1 -
 hw/cxl/cxl-mailbox-utils.c |  7 -------
 hw/mem/cxl_type3.c         | 15 +++++++++++++++
 4 files changed, 15 insertions(+), 9 deletions(-)

-- 
2.43.0


