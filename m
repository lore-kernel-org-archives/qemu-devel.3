Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3419CAC599
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 08:19:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyQt6-0004GJ-6L; Tue, 16 Sep 2025 04:18:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arpit1.kumar@samsung.com>)
 id 1uyQsl-000452-HF
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 04:17:54 -0400
Received: from mailout2.samsung.com ([203.254.224.25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arpit1.kumar@samsung.com>)
 id 1uyQsg-00047Q-Pb
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 04:17:46 -0400
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20250916080800epoutp025c28ca8fe93514388953038d14e0034d~ltNqjn63g2166721667epoutp02-
 for <qemu-devel@nongnu.org>; Tue, 16 Sep 2025 08:08:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20250916080800epoutp025c28ca8fe93514388953038d14e0034d~ltNqjn63g2166721667epoutp02-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1758010080;
 bh=y1JlxKtBcraILgiqQi3sQKAPEKRSzGXNW3wWAGbNN44=;
 h=From:To:Cc:Subject:Date:References:From;
 b=dOeiRE8AAB/yrlLCJVZt/Xc9pqe/Go7+DuUsEdv+e2yMn0jFH+EpDMAFUW1GnkEuY
 fPjhd4jOaER4qQYgxyFkcVV2soUcqjuj0HnpG9oFzM6ixE6MEAnyqIUSQHw/erlLfp
 +NIV+svdxRAyRv9nMcsWk2VQqEkKESI4Fenm2F2w=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
 epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
 20250916080759epcas5p18c29390ff8b0d03596dc94fef4aaea6a~ltNpgjZYH2548225482epcas5p14;
 Tue, 16 Sep 2025 08:07:59 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.88]) by
 epsnrtp01.localdomain (Postfix) with ESMTP id 4cQvf644Qsz6B9m7; Tue, 16 Sep
 2025 08:07:58 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
 epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
 20250916080757epcas5p2db403c9648f7818b22413d90acb4fdd4~ltNoBn1so0225002250epcas5p2r;
 Tue, 16 Sep 2025 08:07:57 +0000 (GMT)
Received: from test-PowerEdge-R740xd.samsungds.net (unknown [107.99.41.79])
 by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20250916080756epsmtip18316b3ef4e2107be77723512d03aad12~ltNmnj1WK1310913109epsmtip1P;
 Tue, 16 Sep 2025 08:07:56 +0000 (GMT)
From: Arpit Kumar <arpit1.kumar@samsung.com>
To: qemu-devel@nongnu.org
Cc: gost.dev@samsung.com, linux-cxl@vger.kernel.org, dave@stgolabs.net,
 Jonathan.Cameron@huawei.com, vishak.g@samsung.com, krish.reddy@samsung.com,
 a.manzanares@samsung.com, alok.rathore@samsung.com, cpgs@samsung.com, Arpit
 Kumar <arpit1.kumar@samsung.com>
Subject: [PATCH v4 0/2] FM-API Physical Switch Command Set Support
Date: Tue, 16 Sep 2025 13:37:34 +0530
Message-Id: <20250916080736.1266083-1-arpit1.kumar@samsung.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250916080757epcas5p2db403c9648f7818b22413d90acb4fdd4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CPGSPASS: Y
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250916080757epcas5p2db403c9648f7818b22413d90acb4fdd4
References: <CGME20250916080757epcas5p2db403c9648f7818b22413d90acb4fdd4@epcas5p2.samsung.com>
Received-SPF: pass client-ip=203.254.224.25;
 envelope-from=arpit1.kumar@samsung.com; helo=mailout2.samsung.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.035,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This patch series refactor existing support for Identify Switch Device
and Get Physical Port State by utilizing physical ports (USP & DSP)
information stored during enumeration.

Additionally, it introduces new support for Physical Port Control
of Physical Switch Command Set as per CXL spec r3.2 Section 7.6.7.1.3.
It primarily constitutes two logic:
    -Assert-Deassert PERST: Assert PERST involves physical port to be in
     hold reset phase for minimum 100ms. No other physical port control
     request are entertained until Deassert PERST command for the given
     port is issued.
    -Reset PPB: cold reset of physical port (completing enter->hold->exit
     phases).

Tested using libcxl-mi interface[1]:
All active ports and all opcodes per active port is tested. Also, tested
against possible edge cases manually since the interface currently dosen't
support run time input.

Typical Qemu topology
(1 USP + 3 DSP's in a switch with 2 CXLType3 devices connected to the 2 DSP's):
FM="-object memory-backend-file,id=cxl-mem1,mem-path=$TMP_DIR/t3_cxl1.raw,size=256M \
    -object memory-backend-file,id=cxl-lsa1,mem-path=$TMP_DIR/t3_lsa1.raw,size=1M \
    -object memory-backend-file,id=cxl-mem2,mem-path=$TMP_DIR/t3_cxl2.raw,size=512M \
    -object memory-backend-file,id=cxl-lsa2,mem-path=$TMP_DIR/t3_lsa2.raw,size=512M \
    -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1,hdm_for_passthrough=true \
    -device cxl-rp,port=0,bus=cxl.1,id=cxl_rp_port0,chassis=0,slot=2 \
    -device cxl-upstream,port=2,sn=1234,bus=cxl_rp_port0,id=us0,addr=0.0,multifunction=on, \
    -device cxl-switch-mailbox-cci,bus=cxl_rp_port0,addr=0.1,target=us0 \
    -device cxl-downstream,port=0,bus=us0,id=swport0,chassis=0,slot=4 \
    -device cxl-downstream,port=1,bus=us0,id=swport1,chassis=0,slot=5 \
    -device cxl-downstream,port=3,bus=us0,id=swport2,chassis=0,slot=6 \
    -device cxl-type3,bus=swport0,memdev=cxl-mem1,id=cxl-pmem1,lsa=cxl-lsa1,sn=3 \
    -device cxl-type3,bus=swport2,memdev=cxl-mem2,id=cxl-pmem2,lsa=cxl-lsa2,sn=4 \
    -machine cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=1k \
    -device i2c_mctp_cxl,bus=aspeed.i2c.bus.0,address=4,target=us0 \
    -device i2c_mctp_cxl,bus=aspeed.i2c.bus.0,address=5,target=cxl-pmem1 \
    -device i2c_mctp_cxl,bus=aspeed.i2c.bus.0,address=6,target=cxl-pmem2 \
    -device virtio-rng-pci,bus=swport1"

Tested multiple Qemu topologies:
        -without any devices connected to downstream ports.
        -with virtio-rng-pci devices connected to downstream ports.
        -with CXLType3 devices connected to downstream ports.
        -with different unique values of ports (both upstream and downstream).

Changes from v3 (https://lore.kernel.org/qemu-devel/20250909160316.00000190@huawei.com/T/):
        -Namespaced the defines with cleaner prefix for Get Physical Port State 
         Port Information Block members.
        -switch CCI implementation instead of switch FM interface as per
         Jonathan's review comments, hence moved perst members initializations
         from: cxl_initialize_usp_mctpcci() -> cxl_initialize_mailbox_swcci().

[1] https://github.com/computexpresslink/libcxlmi/commit/35fe68bd9a31469f832a87694d7b18d2d50be5b8

The patches are generated against the Johnathan's tree
https://gitlab.com/jic23/qemu.git and branch cxl-2025-07-03.

Signed-off-by: Arpit Kumar <arpit1.kumar@samsung.com>

Arpit Kumar (2):
  hw/cxl: Refactored Identify Switch Device & Get Physical Port State
  hw/cxl: Add Physical Port Control (Opcode 5102h)

 hw/cxl/cxl-mailbox-utils.c                | 368 +++++++++++++++-------
 include/hw/cxl/cxl_device.h               |  76 +++++
 include/hw/cxl/cxl_mailbox.h              |   1 +
 include/hw/pci-bridge/cxl_upstream_port.h |   9 +
 4 files changed, 348 insertions(+), 106 deletions(-)

-- 
2.34.1


