Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 738C1CAC59A
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 14:14:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uysvK-00070z-Ty; Wed, 17 Sep 2025 10:14:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uysvD-0006wk-9i
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 10:14:14 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uysv7-0008Ov-Tb
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 10:14:10 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cRgh80vw7z6GDLx;
 Wed, 17 Sep 2025 22:12:24 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 3295B140371;
 Wed, 17 Sep 2025 22:13:57 +0800 (CST)
Received: from SecurePC-101-06.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 17 Sep 2025 16:13:56 +0200
To: Michael Tsirkin <mst@redhat.com>, <qemu-devel@nongnu.org>,
 <shiju.jose@huawei.com>
CC: <armbru@redhat.com>, Fan Ni <fan.ni@samsung.com>,
 <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>, Ravi Shankar
 <venkataravis@micron.com>
Subject: [PATCH qemu for 10.2 0/5] cxl: r3.2 specification events updates.
Date: Wed, 17 Sep 2025 15:13:50 +0100
Message-ID: <20250917141355.293217-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.122.19.247]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 frapeml500008.china.huawei.com (7.182.85.71)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
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

Hi Michael,

This is the 1st CXL set that I think is ready for upstream.
They are lightly tweaked and rebased from the first part of:
https://lore.kernel.org/qemu-devel/20250811085530.2263-1-shiju.jose@huawei.com/
[PATCH v6 0/8] hw/cxl: Update CXL events to rev3.2 and add maintenance support for memory repair features

I've split that series up as the two parts were only slightly connected.

The initial rework was a request from Markus from an earlier version.

Shiju Jose (5):
  qapi: cxl: Refactor CXL event injection for common commands arguments
  hw/cxl/events: Update for rev3.2 common event record format
  hw/cxl/events: Updates for rev3.2 general media event record
  hw/cxl/events: Updates for rev3.2 DRAM event record
  hw/cxl/events: Updates for rev3.2 memory module event record

 qapi/cxl.json               | 151 +++++++++++++++++++++++++--------
 include/hw/cxl/cxl_device.h |   7 +-
 include/hw/cxl/cxl_events.h |  38 +++++++--
 hw/cxl/cxl-events.c         |   3 +-
 hw/cxl/cxl-mailbox-utils.c  |   3 +-
 hw/mem/cxl_type3.c          | 163 ++++++++++++++++++++++++++++++++++--
 hw/mem/cxl_type3_stubs.c    |  41 ++++++++-
 7 files changed, 347 insertions(+), 59 deletions(-)

-- 
2.48.1


