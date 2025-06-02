Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C8BDC54FB3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 16:03:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uM7cW-0007N2-2N; Mon, 02 Jun 2025 12:02:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arpit1.kumar@samsung.com>)
 id 1uM7cN-0007Ck-ON
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 12:02:33 -0400
Received: from mailout4.samsung.com ([203.254.224.34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arpit1.kumar@samsung.com>)
 id 1uM7cH-00069S-Ba
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 12:02:30 -0400
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20250602160215epoutp048d81670deb7f54dbfe4d0f6ae737e004~FRTenaCsx1881418814epoutp04W
 for <qemu-devel@nongnu.org>; Mon,  2 Jun 2025 16:02:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20250602160215epoutp048d81670deb7f54dbfe4d0f6ae737e004~FRTenaCsx1881418814epoutp04W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1748880135;
 bh=SeY7Pv4lQ5JZZ16sZo+eurikBf+a8HytnZGpjMK39rA=;
 h=From:To:Cc:Subject:Date:References:From;
 b=OQ795KidH17Jr/zozuy4yPN80uZ/ZpItMq1kjcdnZmHfhj+d6GOxrCyO8mKeMcYVj
 kUWZ0x6hNBpDOCtBnc6cq6E4gILkYEt02nit9Orz1UhDfiuyMQ7uPvYBqtnM+lcFyr
 DR5rJQYQT5gjxpblhRwu+EuhgX4QNBam/a5HtZQE=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
 epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
 20250602160215epcas5p20ee02b7dcc2b72c16ac479cb8026c7cf~FRTeCcafW0935009350epcas5p2D;
 Mon,  2 Jun 2025 16:02:15 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.177]) by
 epsnrtp03.localdomain (Postfix) with ESMTP id 4b9zBF5NHCz3hhT8; Mon,  2 Jun
 2025 16:02:13 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
 epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
 20250602140008epcas5p25fce01492de105da3cdc0aaa533f6ebc~FPo225dSR0204302043epcas5p2N;
 Mon,  2 Jun 2025 14:00:08 +0000 (GMT)
Received: from test-PowerEdge-R740xd.samsungds.net (unknown [107.99.41.79])
 by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20250602140007epsmtip2a8638a39fd2c53f4d5cea03826b71d3d~FPo1h48sV2410124101epsmtip21;
 Mon,  2 Jun 2025 14:00:07 +0000 (GMT)
From: Arpit Kumar <arpit1.kumar@samsung.com>
To: qemu-devel@nongnu.org
Cc: gost.dev@samsung.com, linux-cxl@vger.kernel.org, nifan.cxl@gmail.com,
 dave@stgolabs.net, vishak.g@samsung.com, krish.reddy@samsung.com,
 a.manzanares@samsung.com, alok.rathore@samsung.com, Arpit Kumar
 <arpit1.kumar@samsung.com>
Subject: [PATCH 0/3] FM-API Physical switch command set update
Date: Mon,  2 Jun 2025 19:29:39 +0530
Message-Id: <20250602135942.2773823-1-arpit1.kumar@samsung.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250602140008epcas5p25fce01492de105da3cdc0aaa533f6ebc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250602140008epcas5p25fce01492de105da3cdc0aaa533f6ebc
References: <CGME20250602140008epcas5p25fce01492de105da3cdc0aaa533f6ebc@epcas5p2.samsung.com>
Received-SPF: pass client-ip=203.254.224.34;
 envelope-from=arpit1.kumar@samsung.com; helo=mailout4.samsung.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.015,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The main purpose of this patch series is to enhance existing support
(Identify Switch Device & Get Physical Port State)
as well as add new support (Physical Port Control)
of FM-API based physical switch command set
as per CXL spec r3.2 Table 8-230:Physical Switch.

[Patch 1/3] stores port info during enumeration for both mailbox
and mctp based component command interface (cci).
This not only simplifies command support of Identify Switch Device (Opcode 5100h)
and Get Physical Port State (Opcode 5101h) but also provides necessary
physical port information for future additions hence [Patch 2/3].

[Patch 3/3] and final patch adds command support of Physical Port Control(Opcode 5102h).
This includes assert-deassert PERST and reset PPB based on the
requested physical port as response payload.

The patches are generated against the Johnathan's tree
https://gitlab.com/jic23/qemu.git and branch cxl-2025-03-20.

Signed-off-by: Arpit Kumar <arpit1.kumar@samsung.com>

Arpit Kumar (3):
  hw/cxl: Storing physical ports info during enumeration
  hw/cxl: Simplified Identify Switch Device & Get Physical Port State
  hw/cxl: Add Physical Port Control (Opcode 5102h)

 hw/cxl/cxl-mailbox-utils.c  | 423 +++++++++++++++++++++++++++---------
 include/hw/cxl/cxl_device.h |  36 +++
 2 files changed, 352 insertions(+), 107 deletions(-)

-- 
2.34.1


