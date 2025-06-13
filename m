Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1005BC71148
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Jun 2025 17:22:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uQ85x-0007Zj-3h; Fri, 13 Jun 2025 13:21:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uQ85v-0007ZG-P8; Fri, 13 Jun 2025 13:21:35 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uQ85t-0003Ew-Rc; Fri, 13 Jun 2025 13:21:35 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bJmKV07Vxz6L51g;
 Sat, 14 Jun 2025 01:17:02 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 447A1140371;
 Sat, 14 Jun 2025 01:21:27 +0800 (CST)
Received: from localhost (10.122.19.247) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 13 Jun
 2025 19:21:26 +0200
Date: Fri, 13 Jun 2025 18:21:25 +0100
To: Peter Maydell <peter.maydell@linaro.org>
CC: <qemu-devel@nongnu.org>, Fan Ni <fan.ni@samsung.com>, <mst@redhat.com>,
 Zhijian Li <lizhijian@fujitsu.com>, Itaru Kitayama
 <itaru.kitayama@linux.dev>, <linuxarm@huawei.com>,
 <linux-cxl@vger.kernel.org>, <qemu-arm@nongnu.org>, Yuquan Wang
 <wangyuquan1236@phytium.com.cn>, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?=
 <philmd@linaro.org>, Alireza Sanaee <alireza.sanaee@huawei.com>, Alex
 =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v15 3/4] hw/arm/virt: Basic CXL enablement on
 pci_expander_bridge instances pxb-cxl
Message-ID: <20250613182125.00004e5f@huawei.com>
In-Reply-To: <CAFEAcA9dHc8werChGk_HzXWsxqv1E4==iDPxRtCmPe9Ndr7nmA@mail.gmail.com>
References: <20250612134338.1871023-1-Jonathan.Cameron@huawei.com>
 <20250612134338.1871023-4-Jonathan.Cameron@huawei.com>
 <CAFEAcA-J+vAGfEV67PezA72rUiqpuqTBT=8hJLc1sw+xo3XHWQ@mail.gmail.com>
 <20250613162054.000003cf@huawei.com>
 <CAFEAcA9dHc8werChGk_HzXWsxqv1E4==iDPxRtCmPe9Ndr7nmA@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.19.247]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
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

On Fri, 13 Jun 2025 17:07:24 +0100
Peter Maydell <peter.maydell@linaro.org> wrote:

> On Fri, 13 Jun 2025 at 16:20, Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> >
> > On Fri, 13 Jun 2025 13:57:39 +0100
> > Peter Maydell <peter.maydell@linaro.org> wrote:
> >  
> > > On Thu, 12 Jun 2025 at 14:45, Jonathan Cameron
> > > <Jonathan.Cameron@huawei.com> wrote:  
> > > >
> > > > Code based on i386/pc enablement. The memory layout places space for 16
> > > > host bridge register regions after the GIC_REDIST2 in the extended memmap.
> > > > The CFMWs are placed above the extended memmap.
> > > >
> > > > Only create the CEDT table if cxl=on set for the machine.
> > > >
> > > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > >
> > > > ---
> > > > v15: No changes.
> > > > ---
> > > >  include/hw/arm/virt.h    |  4 ++++
> > > >  hw/arm/virt-acpi-build.c | 34 ++++++++++++++++++++++++++++++++++
> > > >  hw/arm/virt.c            | 29 +++++++++++++++++++++++++++++
> > > >  3 files changed, 67 insertions(+)  
> > >  
> > Hi Peter,
> >
> > Thanks for reviewing.
> >  
> > > Can we have some user-facing documentation, please?
> > > (docs/system/arm/virt.rst -- can just be a brief mention
> > > and link to docs/system/devices/cxl.rst if you want to put the
> > > examples of aarch64 use in there.)  
> >
> > Given the examples should look exactly like those for x86/pc, do we need
> > extra examples in cxl.rst? I guess I can add one simple arm/virt example
> > in a follow up patch without bloating that file too badly..  
> 
> That's fine too -- if the answer is "all these command lines work
> for aarch64 too", then you can just say that in cxl.rst.

I'll put an example in just to avoid people using a default
command line and getting an a55 with too small a PA range.

> 
> > Is the following sufficient for the board specific docs?
> >
> > diff --git a/docs/system/arm/virt.rst b/docs/system/arm/virt.rst
> > index 6a719b9586..10cbffc8a7 100644
> > --- a/docs/system/arm/virt.rst
> > +++ b/docs/system/arm/virt.rst
> > @@ -31,6 +31,7 @@ Supported devices
> >  The virt board supports:
> >
> >  - PCI/PCIe devices
> > +- CXL Fixed memory windows, root bridges and devices.
> >  - Flash memory
> >  - Either one or two PL011 UARTs for the NonSecure World
> >  - An RTC
> > @@ -189,6 +190,14 @@ ras
> >  acpi
> >    Set ``on``/``off``/``auto`` to enable/disable ACPI.
> >
> > +cxl
> > +  Set  ``on``/``off`` to enable/disable CXL. More details in
> > +  :doc:`../devices/cxl`. The default is off.
> > +
> > +cxl-fmw
> > +  Array of CXL fixed memory windows describing fixed address routing to
> > +  target CXL host bridges. See :doc:`../devices/cxl`.
> > +
> >  dtb-randomness
> >    Set ``on``/``off`` to pass random seeds via the guest DTB
> >    rng-seed and kaslr-seed nodes (in both "/chosen" and  
> 
> Looks OK.
> 
> > >  
> > > > @@ -220,6 +223,7 @@ static const MemMapEntry base_memmap[] = {
> > > >  static MemMapEntry extended_memmap[] = {
> > > >      /* Additional 64 MB redist region (can contain up to 512 redistributors) */
> > > >      [VIRT_HIGH_GIC_REDIST2] =   { 0x0, 64 * MiB },
> > > > +    [VIRT_CXL_HOST] =           { 0x0, 64 * KiB * 16 }, /* 16 UID */  
> > >
> > > This is going to shuffle the memory map around, even if CXL
> > > isn't enabled, which will break migration compatibility.
> > > You need to do something to ensure that the CXL region isn't
> > > included in the calculations of the base addresses for these
> > > regions if CXL isn't enabled.
> > >  
> >
> > It doesn't move any existing stuff because these are naturally aligned
> > regions so this is in a gap before the PCIE ECAM region.  
> 
> Is that true even when we have the maximum number of CPUs and
> so the max number of redistributors in that VIRT_HIGH_GIC_REDIST2
> region ?

Yes.   The gap is between that and the ECAM window.  The CXL RCRB
stuff doesn't move whether or not that is there.  Making sure it
is present does make it easier to see the gap though - hence example below.


> 
> > > >      [VIRT_HIGH_PCIE_ECAM] =     { 0x0, 256 * MiB },
> > > >      /* Second PCIe window */
> > > >      [VIRT_HIGH_PCIE_MMIO] =     { 0x0, DEFAULT_HIGH_PCIE_MMIO_SIZE },  
> > >
> > > If you're OK with having the CXL host region at the end of the
> > > list then that's a simpler way to avoid its presence disturbing
> > > the layout of the existing regions, but you might not like it
> > > being at such a high physaddr.  
> >
> > From what I recall a higher address isn't a problem I just wanted to not waste any
> > PA space at all so used the gap.
> >
> > Chunk of /proc/iomem with a random test case (in first case with the cxl bits
> > removed as obvious that doesn't start until this patch is in place).
> > Need more than 123 cpus to make the second gicv3 redist appear
> > (I've no idea why that number I just printed the threshold where
> > it was calculated to find out what I needed to wait for boot on).  
> 
> It's 123 because that's the most redistributors we can fit into
> the lower redistributor region. (We didn't really allow enough
> space in the lower memory map, which is why we need this awkward
> split setup.
> 
> (I have to run now, will look at the rest of the email next week.)
Thanks and have a good weekend.

J
> 
> -- PMM


