Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A97BC83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 14:44:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubKPs-0002zj-LU; Mon, 14 Jul 2025 10:44:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arpit1.kumar@samsung.com>)
 id 1ubIr3-0000MZ-HD
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 09:04:26 -0400
Received: from mailout1.samsung.com ([203.254.224.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arpit1.kumar@samsung.com>)
 id 1ubIqy-0004sW-Hw
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 09:04:25 -0400
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20250714130410epoutp01911e61e4ce5cee2bdc8bcba2929c5076~SH9_27UIu2341823418epoutp01V
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 13:04:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20250714130410epoutp01911e61e4ce5cee2bdc8bcba2929c5076~SH9_27UIu2341823418epoutp01V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1752498250;
 bh=STj9hqclOjcRpIvcs4IUPY0vGcojEPv3/KD0z0+QD1A=;
 h=From:To:Cc:Subject:Date:References:From;
 b=Nb53fn8vg+qIVkETt8KDWZjOo+qZSHREBxDV+dWWbFA6YzofATY/+POGvRQSkpBoZ
 1IIwaxWFIxul0lcwaXctVXjcQkAbVdb9pSRpEUxxSrrNAFw3BDCI/Zq3UMs298H/dO
 xYjRYtl6atb8ocT9S+P0miIKLx5NlgCVAx8fTwW0=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
 epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
 20250714130410epcas5p2237911c82560ad16b15dd351641dc6b4~SH9_dp04U0632306323epcas5p21;
 Mon, 14 Jul 2025 13:04:10 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.86]) by
 epsnrtp01.localdomain (Postfix) with ESMTP id 4bgjFP2Dzqz6B9m4; Mon, 14 Jul
 2025 13:04:09 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
 epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
 20250710144348epcas5p1842ad24e3de24dd7048b0db9dfbe6455~Q6v1XAbYH2661926619epcas5p1D;
 Thu, 10 Jul 2025 14:43:48 +0000 (GMT)
Received: from test-PowerEdge-R740xd.samsungds.net (unknown [107.99.41.79])
 by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20250710144347epsmtip23509616a42021b0f9572e7496c31a534~Q6vz3acz81607016070epsmtip2y;
 Thu, 10 Jul 2025 14:43:47 +0000 (GMT)
From: Arpit Kumar <arpit1.kumar@samsung.com>
To: qemu-devel@nongnu.org
Cc: gost.dev@samsung.com, linux-cxl@vger.kernel.org, nifan.cxl@gmail.com,
 dave@stgolabs.net, Jonathan.Cameron@huawei.com, vishak.g@samsung.com,
 krish.reddy@samsung.com, a.manzanares@samsung.com, alok.rathore@samsung.com,
 cpgs@samsung.com, Arpit Kumar <arpit1.kumar@samsung.com>
Subject: [PATCH v2 0/2] FM-API Physical switch command set support
Date: Thu, 10 Jul 2025 20:13:36 +0530
Message-Id: <20250710144338.2839512-1-arpit1.kumar@samsung.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250710144348epcas5p1842ad24e3de24dd7048b0db9dfbe6455
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CPGSPASS: Y
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250710144348epcas5p1842ad24e3de24dd7048b0db9dfbe6455
References: <CGME20250710144348epcas5p1842ad24e3de24dd7048b0db9dfbe6455@epcas5p1.samsung.com>
Received-SPF: pass client-ip=203.254.224.24;
 envelope-from=arpit1.kumar@samsung.com; helo=mailout1.samsung.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

This patch series refactor existing support for Identify Switch Device
and Get Physical Port State by utilizing physical ports (USP & DSP)
information stored during enumeration. Additionally, it introduces new
support for Physical Port Control of FM-API based physical switch
command set as per CXL spec r3.2 Table 8-230:Physical Switch.

This v2 patch series addresses feedback from v1 and incorporates some 
new changes. It merges [PATCH 1/3] and [PATCH 2/3] from the v1 series,
resulting in total of two patches in this patch series.

Change log [PATCH v2 1/2]:
-namespace defines intead of enum for current_port_config_state.
-Relocates all defines & enums to include/hw/cxl/cxl_device.h for
 improved readibility.
-Total number of unique physical ports defined as 256 since the length
 of number of physical ports given in CXL r3.2 Table 7-16 is 1 byte. Thus,
 dropping any dependencies on virtual heirarchy throughout the implementation
 as the request is per switch.
-Moves struct phy_port to CXLUpstreamPort avoiding cci specific handling of
 physical ports hence making it more reasonable.
-Utilizes pci_for_each_device_under_bus() to store downstream ports info.
-Declarations at the beginning of the function.

Change log [PATCH v2 2/2]:
-cxl_find_port_dev() now locates device objects for both USP and DSP as physical
 port control request includes all physical ports.
-Replaces qemu_mutex_lock with QEMU_LOCK_GUARD.
-Holding reset phase for 100ms added as backgroung operation using qemu_thread_create().
-Updates naming function/variables names as suggested by using lower_case style
 wherever apt.
-Removes CCI sepcific implementation for Assert-Deassert PERST & Reset as it is port
 wise and utilize struct phy_port stored in CXLUpstreamPort as per [PATCH 1/2].
-Changes made does not lock up other emulations.

Logic behind physical port control request:
-Assert-Deassert PERST: Assert PERST involves physical port to be in hold reset phase
 for minimum 100ms. No other physical port control request are entertained until Deassert
 PERST command for the given port is issued.
-Reset PPB: cold reset of physical port (completing enter->hold->exit phases).

The Physcial port control request is tested through libcxl-mi interface. It tests 
all active ports and all opcodes per active port. Since it does not support run time input,
all other possible edge cases were tested manually:
https://github.com/computexpresslink/libcxlmi/pull/31

Qemu Topology used and it's results:
-without any devices connected to downstream ports - success
-with virtio-rng-pci devices connected to downstream ports - success
-with CXLType3 devices connected to downstream ports - failure
-with different unique values of ports (both upstream and downstream) - success

Below given topology is an example topology with 3 downstream ports and 1 upstream port.
It has one virtio-rng-pci device connected to downstream port 4.
FM="-object memory-backend-file,id=cxl-mem1,mem-path=$TMP_DIR/t3_cxl1.raw,size=256M \
    -object memory-backend-file,id=cxl-lsa1,mem-path=$TMP_DIR/t3_lsa1.raw,size=1M \
    -object memory-backend-file,id=cxl-mem2,mem-path=$TMP_DIR/t3_cxl2.raw,size=16M \
    -object memory-backend-file,id=cxl-lsa2,mem-path=$TMP_DIR/t3_lsa2.raw,size=1M \
    -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1,hdm_for_passthrough=true \
    -device cxl-rp,port=0,bus=cxl.1,id=cxl_rp_port0,chassis=0,slot=2 \
    -device cxl-upstream,port=2,sn=1234,bus=cxl_rp_port0,id=us0,addr=0.0,multifunction=on, \
    -device cxl-switch-mailbox-cci,bus=cxl_rp_port0,addr=0.1,target=us0 \
    -device cxl-downstream,port=0,bus=us0,id=swport0,chassis=0,slot=4 \
    -device cxl-downstream,port=4,bus=us0,id=swport1,chassis=0,slot=5 \
    -device cxl-downstream,port=8,bus=us0,id=swport2,chassis=0,slot=6 \
    -machine cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=1k \
    -device i2c_mctp_cxl,bus=aspeed.i2c.bus.0,address=4,target=us0 \
    -device i2c_mctp_cxl,bus=aspeed.i2c.bus.0,address=5,target=us0 \
    -device i2c_mctp_cxl,bus=aspeed.i2c.bus.0,address=6,target=us0 \
    -device virtio-rng-pci,bus=swport1"
   
Observation/Finding:
The assert-deassert and reset PPB operation fails when downstream ports are connected
to a CXLType3 device as it would mean device reset instead of switch port reset.

The patches are generated against the Johnathan's tree
https://gitlab.com/jic23/qemu.git and branch cxl-2025-03-20.

Signed-off-by: Arpit Kumar <arpit1.kumar@samsung.com>

Arpit Kumar (2):
  hw/cxl: Refactored Identify Switch Device & Get Physical Port State
  hw/cxl: Add Physical Port Control (Opcode 5102h)

 hw/cxl/cxl-mailbox-utils.c                | 364 +++++++++++++++-------
 include/hw/cxl/cxl_device.h               |  92 ++++++
 include/hw/pci-bridge/cxl_upstream_port.h |   4 +
 3 files changed, 352 insertions(+), 108 deletions(-)

-- 
2.34.1


