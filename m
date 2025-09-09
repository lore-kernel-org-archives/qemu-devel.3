Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70CDACAC583
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 15:04:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvzss-0006mL-Dr; Tue, 09 Sep 2025 11:03:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uvzse-0006kX-Qc
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 11:03:37 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uvzsX-0001Ak-Mq
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 11:03:36 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cLn9D4gbxz67GCQ;
 Tue,  9 Sep 2025 23:02:08 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 863531401DC;
 Tue,  9 Sep 2025 23:03:18 +0800 (CST)
Received: from localhost (10.203.177.15) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 9 Sep
 2025 17:03:17 +0200
Date: Tue, 9 Sep 2025 16:03:16 +0100
To: Arpit Kumar <arpit1.kumar@samsung.com>
CC: <qemu-devel@nongnu.org>, <gost.dev@samsung.com>,
 <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>, <vishak.g@samsung.com>,
 <krish.reddy@samsung.com>, <a.manzanares@samsung.com>,
 <alok.rathore@samsung.com>, <cpgs@samsung.com>
Subject: Re: [PATCH v3 0/2] FM-API Physical Switch Command Set Support
Message-ID: <20250909160316.00000190@huawei.com>
In-Reply-To: <20250908132211.tusasxcwx45d474x@test-PowerEdge-R740xd>
References: <CGME20250904131926epcas5p2a363cf0604a4801038d32e7da5397da1@epcas5p2.samsung.com>
 <20250904131904.725758-1-arpit1.kumar@samsung.com>
 <20250905171252.00004c72@huawei.com>
 <20250908132211.tusasxcwx45d474x@test-PowerEdge-R740xd>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.15]
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
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
Reply-to:  Jonathan Cameron <jonathan.cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, 8 Sep 2025 18:52:11 +0530
Arpit Kumar <arpit1.kumar@samsung.com> wrote:

> On 05/09/25 05:12PM, Jonathan Cameron wrote:
> >On Thu,  4 Sep 2025 18:49:02 +0530
> >Arpit Kumar <arpit1.kumar@samsung.com> wrote:
> >  
> >> This patch series refactor existing support for Identify Switch Device
> >> and Get Physical Port State by utilizing physical ports (USP & DSP)
> >> information stored during enumeration.
> >>
> >> Additionally, it introduces new support for Physical Port Control
> >> of FM-API based physical switch command set as per CXL spec r3.2
> >> Table 8-230:Physical Switch. It primarily constitutes two logic:
> >> -Assert-Deassert PERST: Assert PERST involves physical port to be in
> >>  hold reset phase for minimum 100ms. No other physical port control
> >>  request are entertained until Deassert PERST command for the given
> >>  port is issued.
> >> -Reset PPB: cold reset of physical port (completing enter->hold->exit phases).
> >>
> >> Tested using libcxl-mi interface[1]:
> >> All active ports and all opcodes per active port is tested. Also, tested
> >> against possible edge cases manually since the interface currently dosen't
> >> support run time input.
> >>
> >> Example topology (1 USP + 3 DSP's->switch with 2 CXLType3 devices connected
> >> to 2 DSP's):
> >> FM="-object memory-backend-file,id=cxl-mem1,mem-path=$TMP_DIR/t3_cxl1.raw,size=256M \
> >>     -object memory-backend-file,id=cxl-lsa1,mem-path=$TMP_DIR/t3_lsa1.raw,size=1M \
> >>     -object memory-backend-file,id=cxl-mem2,mem-path=$TMP_DIR/t3_cxl2.raw,size=512M \
> >>     -object memory-backend-file,id=cxl-lsa2,mem-path=$TMP_DIR/t3_lsa2.raw,size=512M \
> >>     -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1,hdm_for_passthrough=true \
> >>     -device cxl-rp,port=0,bus=cxl.1,id=cxl_rp_port0,chassis=0,slot=2 \
> >>     -device cxl-upstream,port=2,sn=1234,bus=cxl_rp_port0,id=us0,addr=0.0,multifunction=on, \
> >>     -device cxl-switch-mailbox-cci,bus=cxl_rp_port0,addr=0.1,target=us0 \
> >>     -device cxl-downstream,port=0,bus=us0,id=swport0,chassis=0,slot=4 \
> >>     -device cxl-downstream,port=1,bus=us0,id=swport1,chassis=0,slot=5 \
> >>     -device cxl-downstream,port=3,bus=us0,id=swport2,chassis=0,slot=6 \
> >>     -device cxl-type3,bus=swport0,memdev=cxl-mem1,id=cxl-pmem1,lsa=cxl-lsa1,sn=3 \
> >>     -device cxl-type3,bus=swport2,memdev=cxl-mem2,id=cxl-pmem2,lsa=cxl-lsa2,sn=4 \
> >>     -machine cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=1k \
> >>     -device i2c_mctp_cxl,bus=aspeed.i2c.bus.0,address=4,target=us0 \
> >>     -device i2c_mctp_cxl,bus=aspeed.i2c.bus.0,address=5,target=cxl-pmem1 \
> >>     -device i2c_mctp_cxl,bus=aspeed.i2c.bus.0,address=6,target=cxl-pmem2 \
> >>     -device virtio-rng-pci,bus=swport1"
> >>
> >> Multiple Qemu Topologies tested:
> >> -without any devices connected to downstream ports.
> >> -with virtio-rng-pci devices connected to downstream ports.
> >> -with CXLType3 devices connected to downstream ports.
> >> -with different unique values of ports (both upstream and downstream).
> >>
> >> Changes from v2->v3:
> >> -cxl_set_port_type(): optimized storing of strucutre members.
> >> -namespace defines instead of enum.
> >> -Calculating size for active_port_bitmask than hardcoding to 0x20.
> >> -Defined struct phy_port directly inside struct CXLUpstreamPort as pports.
> >> -Renamed struct pperst to struct CXLPhyPortPerst.
> >> -Optimized perst member initializations for ports inside
> >>  cxl_initialize_usp_mctpcci() using active_port_bitmask.
> >>
> >> [1] https://github.com/computexpresslink/libcxlmi/commit/35fe68bd9a31469f832a87694d7b18d2d50be5b8
> >>
> >> The patches are generated against the Johnathan's tree
> >> https://gitlab.com/jic23/qemu.git and branch cxl-2025-07-03.
> >>
> >> Signed-off-by: Arpit Kumar <arpit1.kumar@samsung.com>  
> >
> >Hi Arpit,
> >
> >I'll have a go (probably next week) at rebasing this rather earlier in my tree as I'd
> >like to get this upstream without it having a dependency on the MCTP support.
> >
> >That means bring it up with the switch-cci / pcie mailbox CCI and squashing
> >the MCTP bit into the patch that brings that support up later in my tree.
> >
> >I do plan to fix up the remaining 'feature' gap on the FMAPI/MCTP/USB
> >emulation which is that it's ignoring the MTU to the host and so not
> >breaking messages up as it should.  Linux doesn't care but maybe some other
> >OS will. Not entirely sure when I'll get to that though and I'd like to
> >move your work forward before that.
> >
> >Jonathan
> >
> >  
> Hi Jonathan,
> Thanks for the review comments!
> 
> As per my understanding from CXL spec r3.2 Table 8-215: Physical Port Control
I guess table 8-230?  
> request is allowed only for switch FM interface and is prohibited for
> switch-cci/pcie mailbox CCI. However, if possible, should I be using
> cxl_initialize_mailbox_swcci() to initialize my perst members?

I always find that table really hard to understand. I'm not sure
what intent is wrt to "host mailbox" in that table.   I can't immediately think
why the FM API CCI  (thing that was switch cci in earlier specs) wouldn't support
this particular command.  You are supposed to be able to control anything via
that which is controllable for MCTP. Only exceptions should be the few
things to do with the MCTP interface itself.

Just to add to the confusion, the entry for Get Physical Port State in the
host mailbox column is "MSW = mandatory on MCTP-based CCIs for all switches that support
the FM API MCTP message type" which is odd given that mailbox isn't mctp based.

Gut feeling is that it can be implemented on the 'switch CCI'.  I'd like to do
that for now just because the MCTP stuff is going to take longer to upstream
and I'd rather your series was not queued up behind it.
 
Jonathan


> 
> Thanks,
> Arpit.
> >>
> >> Arpit Kumar (2):
> >>   hw/cxl: Refactored Identify Switch Device & Get Physical Port State
> >>   hw/cxl: Add Physical Port Control (Opcode 5102h)
> >>
> >>  hw/cxl/cxl-mailbox-utils.c                | 368 +++++++++++++++-------
> >>  include/hw/cxl/cxl_device.h               |  76 +++++
> >>  include/hw/cxl/cxl_mailbox.h              |   1 +
> >>  include/hw/pci-bridge/cxl_upstream_port.h |   9 +
> >>  4 files changed, 347 insertions(+), 107 deletions(-)
> >>  
> >  
> 


