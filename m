Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14C1DC02183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 10:47:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYNOX-0008Nv-JY; Thu, 16 Jan 2025 05:46:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1tYNOG-0008Ly-JK
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 05:46:21 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1tYNOD-00068b-EU
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 05:46:20 -0500
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YYfd50RXvz6L5Rb;
 Thu, 16 Jan 2025 18:44:41 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 0BF421409EA;
 Thu, 16 Jan 2025 18:46:14 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 16 Jan
 2025 11:46:13 +0100
Date: Thu, 16 Jan 2025 10:46:12 +0000
To: Fan Ni <nifan.cxl@gmail.com>
CC: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 "a.manzanares@samsung.com" <a.manzanares@samsung.com>,
 "anisa.su887@gmail.com" <anisa.su887@gmail.com>, "dave@stgolabs.net"
 <dave@stgolabs.net>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [ISSUE] memdev cannot be enabled after reboot due to failed
 dvsec range check [QEMU setup]
Message-ID: <20250116104612.00000ea0@huawei.com>
In-Reply-To: <Z4g-iMVj4D2sUE20@smc-140338-bm01>
References: <Z4bJdCliETI_t2DL@fan>
 <80665bcd-7d6e-4f7a-9ab4-e292486f2681@fujitsu.com>
 <Z4g-iMVj4D2sUE20@smc-140338-bm01>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 frapeml500008.china.huawei.com (7.182.85.71)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -59
X-Spam_score: -6.0
X-Spam_bar: ------
X-Spam_report: (-6.0 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-1.793, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Wed, 15 Jan 2025 23:02:32 +0000
Fan Ni <nifan.cxl@gmail.com> wrote:

> On Wed, Jan 15, 2025 at 01:06:24AM +0000, Zhijian Li (Fujitsu) wrote:
> > Cced QEMU,
> > 
> > Hi Fan,
> > 
> > I recalled we had a reboot issue[1] months ago
> > I guess your issue was caused by some registers not reset during reboot.
> > 
> > [1] https://lore.kernel.org/linux-cxl/20240409075846.85370-1-lizhijian@fujitsu.com/
> >   
> Hi Zhijian,
> Thanks for the pointer. With the fix applied, the issue goes away.

Note that as per the thread above, that fix is not sufficient which
is why I dropped it again from my trees.

Reset is not currently well handled by the qemu code.
I'm happy to look at patches to fully support it but that fix needs
to be complete and not break any other cases.

Jonathan


> 
> Fan
> > 
> > On 15/01/2025 04:30, Fan Ni wrote:  
> > > Hi,
> > > 
> > > Recently, while testing cxl with qemu setup, I found the memdev cannot
> > > be enabled successfully after reboot.
> > > 
> > > Here is the setup and the steps I have tried.
> > > 
> > > QEMU:
> > > https://gitlab.com/qemu-project/qemu.git
> > > branch: master
> > > commit: 8032c78e556cd0baec111740a6c636863f9bd7c8
> > > 
> > > Kernel:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/
> > > branch: next
> > > 2f84d072bdcb7d6ec66cc4d0de9f37a3dc394cd2
> > > 
> > > Steps to reproduce the issue.
> > > 1.  start the vm with cxl pmem device attached directly to RP.
> > > 2. Load the cxl drivers cxl_acpi cxl_core cxl_pci cxl_port cxl_mem, etc.
> > > Everyting works expected, the memory is corrected enabled and shown with
> > > cxl list.
> > > 3. Reboot the VM (run reboot command inside vm, no shutdown);
> > > 4. Load the cxl drivers as in step 2. the cxl pmem is not correctly enabled.
> > > 
> > > dmesg shows some error as below:
> > > -------------------------------
> > > [   17.131729] cxl_core:cxl_hdm_decode_init:443: cxl_pci 0000:0d:00.0: DVSEC Range0 denied by platform
> > > [   17.135267] cxl_pci 0000:0d:00.0: Range register decodes outside platform defined CXL ranges.
> > > [   17.138428] cxl_core:cxl_bus_probe:2073: cxl_port endpoint2: probe: -6
> > > [   17.141104] cxl_core:devm_cxl_add_port:936: cxl_mem mem0: endpoint2 added to port1
> > > [   17.143703] cxl_mem mem0: endpoint2 failed probe
> > > [   17.145324] cxl_core:cxl_bus_probe:2073: cxl_mem mem0: probe: -6
> > > [   17.171416] cxl_core:cxl_detach_ep:1499: cxl_mem mem0: disconnect mem0 from port1
> > > ------------------------------
> > > Compare the step 2 and 4 with debug info. we can see,
> > > In step 2, when entry function: cxl_hdm_decode_init().
> > > 
> > > (gdb) p *info
> > > $2 = {mem_enabled = false, ranges = 0, port = 0xffff8881097eac00, dvsec_range = {{start = 0, end = 0}, {start = 0, end = 0}}}
> > > 
> > > The info struct is from cxl_dvsec_rr_decode(), where if mem_enabled is
> > > not enabled, it will return directly without reading dvsec range, so
> > > ranges == 0.
> > > This is what happened in step 2: no dvsec ranges are provided to the function for checking.
> > > 
> > > When init the hdm decoder in cxl_hdm_decode_init function, the memory enable bit will be set.
> > > 
> > > In step 4, after reboot, the enabled memory enable bit sustained and the dvsec range
> > > register will be read from the device in cxl_dvsec_rr_decode.
> > > So when entrying cxl_hdm_decode_init(),
> > > ------------------------------------
> > > $2 = {mem_enabled = true, ranges = 1, port = 0xffff888103c77400, dvsec_range = {{start = 0, end = 536870911}, {start = 0, end = 0}}}
> > > Breakpoint 2 at 0xffffffffc0657bbe: file drivers/cxl/core/pci.c, line 416.
> > > ------------------------------------
> > > It will cause the dvsec_range_allowed() failing as the range from dvsec range
> > > registers starts at address zero [0, 512], which does not match the hpa range
> > > stored in cxld->hpa_range, causing the issue.
> > > 
> > > ------------------------------------
> > > Thread 1 hit Breakpoint 4, dvsec_range_allowed (dev=0xffff888108af9848,
> > >      arg=0xffffc9000059f9b0) at drivers/cxl/core/pci.c:265
> > > 265		if (!(cxld->flags & CXL_DECODER_F_RAM))
> > > (gdb) b 268
> > > Breakpoint 5 at 0xffffffffc0657d31: file drivers/cxl/core/pci.c, line 271.
> > > (gdb) p /x cxld->hpa_range
> > > $5 = {start = 0xa90000000, end = 0xb8fffffff}
> > > (gdb) p /x *dev_range
> > > $7 = {start = 0x0, end = 0x1fffffff}
> > > (gdb)
> > > ------------------------------------
> > > The hpa_range is set when parsing the cfmws in __cxl_parse_cfmws.
> > > 
> > > Any throughts?
> > > 
> > > Open question: do we need to update the dvsec range register after we parse the
> > > cfmws to make the two above match.  
> 


