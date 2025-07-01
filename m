Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54204C7EE30
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 16:27:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWdoL-0002hJ-AU; Tue, 01 Jul 2025 12:26:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uWdoH-0002fv-C0; Tue, 01 Jul 2025 12:26:17 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uWdoE-000661-4A; Tue, 01 Jul 2025 12:26:16 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bWpKx4yqXz6L57n;
 Wed,  2 Jul 2025 00:25:41 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id D2B00140393;
 Wed,  2 Jul 2025 00:26:04 +0800 (CST)
Received: from localhost (10.122.19.247) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 1 Jul
 2025 18:26:04 +0200
Date: Tue, 1 Jul 2025 17:26:02 +0100
To: Eric Auger <eric.auger@redhat.com>
CC: <qemu-devel@nongnu.org>, Fan Ni <fan.ni@samsung.com>, Peter Maydell
 <peter.maydell@linaro.org>, <mst@redhat.com>, Zhijian Li
 <lizhijian@fujitsu.com>, Itaru Kitayama <itaru.kitayama@linux.dev>,
 <linuxarm@huawei.com>, <linux-cxl@vger.kernel.org>, <qemu-arm@nongnu.org>,
 "Yuquan Wang" <wangyuquan1236@phytium.com.cn>, Philippe
 =?ISO-8859-1?Q?Mathieu-Dau?= =?ISO-8859-1?Q?d=E9?= <philmd@linaro.org>, Alex
 =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH qemu v16 3/5] hw/arm/virt: Basic CXL enablement on
 pci_expander_bridge instances pxb-cxl
Message-ID: <20250701172602.0000740a@huawei.com>
In-Reply-To: <954f10cf-3de4-4067-878c-f0bb07e9dbe0@redhat.com>
References: <20250625161926.549812-1-Jonathan.Cameron@huawei.com>
 <20250625161926.549812-4-Jonathan.Cameron@huawei.com>
 <128e59be-4038-4a19-8cca-3be3d6446e0e@redhat.com>
 <20250701165222.0000068f@huawei.com>
 <954f10cf-3de4-4067-878c-f0bb07e9dbe0@redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.19.247]
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 frapeml500008.china.huawei.com (7.182.85.71)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, 1 Jul 2025 18:12:39 +0200
Eric Auger <eric.auger@redhat.com> wrote:

> Hi Jonathan,
> On 7/1/25 5:52 PM, Jonathan Cameron wrote:
> > On Tue, 1 Jul 2025 17:34:36 +0200
> > Eric Auger <eric.auger@redhat.com> wrote:
> >  
> >> Hi Jonathan,
> >>
> >> On 6/25/25 6:19 PM, Jonathan Cameron via wrote:  
> >>> Code based on i386/pc enablement.
> >>> The memory layout places space for 16 host bridge register regions after
> >>> the GIC_REDIST2 in the extended memmap. This is a hole in the current
> >>> map so adding them here has no impact on placement of other memory regions
> >>> (tested with enough CPUs for GIC_REDIST2 to be in use.)
> >>>
> >>> The CFMWs are placed above the extended memmap.  Note the confusing
> >>> existing variable highest_gpa is the highest_gpa that has been allocated
> >>> at a particular point in setting up the memory map.
> >>>
> >>> The cxl_devices_state.host_mr is provides a small space in which to place    
> >> s/is//  
> > Fixed. Thanks.  
> >>> the individual host bridge register regions for whatever host bridges are
> >>> allocated via -device pxb-cxl on the command line. The existing dynamic
> >>> sysbus infrastructure is not reused because pxb-cxl is a PCI device not
> >>> a sysbus one but these registers are directly in the main memory map,
> >>> not the PCI address space.
> >>>
> >>> Only create the CEDT table if cxl=on set for the machine. Default to off.
> >>>
> >>> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >>> ---
> >>> @@ -1895,6 +1917,9 @@ static void virt_set_memmap(VirtMachineState *vms, int pa_bits)
> >>>      if (device_memory_size > 0) {
> >>>          machine_memory_devices_init(ms, device_memory_base, device_memory_size);
> >>>      }
> >>> +    vms->highest_gpa = cxl_fmws_set_memmap(ROUND_UP(vms->highest_gpa + 1,
> >>> +                                                    256 * MiB),
> >>> +                                           BIT_ULL(pa_bits)) - 1;    
> >> in hw/cxl/cxl-host.c, there seems to be a loop on fw windows? I guess
> >> those windows only exist if cxl option is set. In the positive,
> >> highest_gpa will be changed only if the option is set, which is fine.
> >> Indeed we have requested_ipa_size = 64 - clz64(vms->highest_gpa). So we
> >> shall not modify this if cxl is not set.  
> so do you confirm highest_gpa is unchanged in case cxl/fmw option is not
> set ?
> >>
> >> What I am a bit concerned with is that it"consumes" some high memory
> >> without making it explicit in extended_memmap. Shouldn't we book some
> >> dedicated space there? Sorry I am jumping very late in the review, maybe
> >> turning things worse & noisy :-( Eric  
> > No problem with late review - whilst it looks late we had a several year
> > gap at one point in updating this series!
> >
> > How much to book?  It's effectively infinite much like device memory.
> > Would be odd to book the minimum which is 256MiB given any useful system
> > is going to have a lot more than that (they are usually a few TiB but
> > may be much larger than that).
> >
> > Would a comment after 
> >    [VIRT_HIGH_PCIE_MMIO] =     { 0x0, DEFAULT_HIGH_PCIE_MMIO_SIZE }, 
> > such as
> >    /* Any CXL Fixed memory windows come here */
> > be enough?  
> yes at least it deserves a comment I think. Then it must be understood
> that it may prevent new regions from being added in the high mem range.
> I am definitively not the most knowledgeable guy to decide whether it is
> critical. I have not checked CCA impact on the layout for instance.

Current CXL isn't migratable but when we fix that I guess this will
mean that we need to version any new features that need space
in the high memory map to only be enabled on newer machines if
CXL is also enabled.  For now migration isn't relevant to CXL/qemu
usecases but it soon will be.

Jonathan

> 
> Thanks
> 
> Eric
> >
> >  
> >  
> 
> 


