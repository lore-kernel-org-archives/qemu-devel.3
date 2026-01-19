Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B7A5CCF2E6
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 11:17:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhnEn-0008SU-SJ; Mon, 19 Jan 2026 06:16:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vhnEl-0008QY-U7
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 06:15:59 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vhnEj-0000M2-5W
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 06:15:59 -0500
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dvntT62xzzHnH8j;
 Mon, 19 Jan 2026 19:15:13 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
 by mail.maildlp.com (Postfix) with ESMTPS id 7F28040539;
 Mon, 19 Jan 2026 19:15:43 +0800 (CST)
Received: from SecurePC-101-06.huawei.com (10.122.19.247) by
 dubpeml500005.china.huawei.com (7.214.145.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 19 Jan 2026 11:15:42 +0000
To: Michael Tsirkin <mst@redhat.com>, <qemu-devel@nongnu.org>,
 <shiju.jose@huawei.com>, <armbru@redhat.com>
CC: <linuxarm@huawei.com>, <linux-cxl@vger.kernel.org>, Ravi Shankar
 <venkataravis@micron.com>
Subject: [PATCH qemu v4 0/5] cxl: r3.2 specification event updates.
Date: Mon, 19 Jan 2026 11:15:37 +0000
Message-ID: <20260119111542.788389-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.122.19.247]
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 dubpeml500005.china.huawei.com (7.214.145.207)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Chances since v3:
https://lore.kernel.org/qemu-devel/20260114142713.617806-1-Jonathan.Cameron@huawei.com/
Update references in the documentation for related commands as well as the
structures. (Markus)

Changes since v2:
https://lore.kernel.org/all/20260102151512.460766-1-Jonathan.Cameron@huawei.com/
Thanks to Markus Armbruster.
- Expand LD acronym.  Given the spec definition is acronyms soup, just
  expand to Logical Device and let people go enjoy the specification if
  they want to know what that actually means!
- Update spec references elsewhere in the qapi commands and data types
  so they all refer to r3.2 rather than just the new bits.

v2: Cover letter,

Hi Michael,

This is a rebase/resend of:
https://lore.kernel.org/qemu-devel/20250917141355.293217-1-Jonathan.Cameron@huawei.com/
which I think slipped through the cracks for 10.2.

Original cover letter:

This is the 1st CXL set that I think is ready for upstream.
They are lightly tweaked and rebased from the first part of:
https://lore.kernel.org/qemu-devel/20250811085530.2263-1-shiju.jose@huawei.com/
[PATCH v6 0/8] hw/cxl: Update CXL events to rev3.2 and add maintenance support for memory repair features

I've split that series up as the two parts were only slightly connected.

The initial rework was a request from Markus from an earlier version.

Shiju Jose (5):

Shiju Jose (5):
  qapi: cxl: Refactor CXL event injection for common commands arguments
  hw/cxl/events: Update for rev3.2 common event record format
  hw/cxl/events: Updates for rev3.2 general media event record
  hw/cxl/events: Updates for rev3.2 DRAM event record
  hw/cxl/events: Updates for rev3.2 memory module event record

 qapi/cxl.json               | 180 ++++++++++++++++++++++++++----------
 include/hw/cxl/cxl_device.h |   7 +-
 include/hw/cxl/cxl_events.h |  38 ++++++--
 hw/cxl/cxl-events.c         |   3 +-
 hw/cxl/cxl-mailbox-utils.c  |   3 +-
 hw/mem/cxl_type3.c          | 163 ++++++++++++++++++++++++++++++--
 hw/mem/cxl_type3_stubs.c    |  41 +++++++-
 7 files changed, 362 insertions(+), 73 deletions(-)

-- 
2.48.1


