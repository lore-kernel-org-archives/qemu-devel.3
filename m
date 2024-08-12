Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF09DC3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2024 02:45:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdL33-000226-If; Sun, 11 Aug 2024 22:44:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ethan84@andestech.com>)
 id 1sdL32-000202-56; Sun, 11 Aug 2024 22:44:40 -0400
Received: from 60-248-80-70.hinet-ip.hinet.net ([60.248.80.70]
 helo=Atcsqr.andestech.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ethan84@andestech.com>)
 id 1sdL2z-00026T-CL; Sun, 11 Aug 2024 22:44:39 -0400
Received: from mail.andestech.com (ATCPCS31.andestech.com [10.0.1.89])
 by Atcsqr.andestech.com with ESMTPS id 47C2i94i080514
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 Aug 2024 10:44:09 +0800 (+08)
 (envelope-from ethan84@andestech.com)
Received: from ethan84-VirtualBox (10.0.12.12) by ATCPCS31.andestech.com
 (10.0.1.89) with Microsoft SMTP Server (TLS) id 14.3.498.0; Mon, 12 Aug 2024
 10:44:10 +0800
Date: Mon, 12 Aug 2024 10:44:03 +0800
To: Alistair Francis <alistair23@gmail.com>
CC: <qemu-devel@nongnu.org>, <richard.henderson@linaro.org>,
 <pbonzini@redhat.com>, <peterx@redhat.com>, <david@redhat.com>,
 <philmd@linaro.org>, <palmer@dabbelt.com>, <alistair.francis@wdc.com>,
 <bmeng.cn@gmail.com>, <liwei1518@gmail.com>,
 <dbarboza@ventanamicro.com>, <zhiwei_liu@linux.alibaba.com>,
 <qemu-riscv@nongnu.org>
Subject: Re: [PATCH v8 5/8] hw/misc/riscv_iopmp: Add API to set up IOPMP
 protection for system memory
Message-ID: <Zrl285mkcFd8BO75@ethan84-VirtualBox>
References: <20240715095702.1222213-1-ethan84@andestech.com>
 <20240715101228.1247759-1-ethan84@andestech.com>
 <CAKmqyKN-YavB364d4wmwBBSi7TpsE1Y5CebvUCSi=CzfjWsJDQ@mail.gmail.com>
 <ZrXrXhJWoCeVqwtu@ethan84-VirtualBox>
 <CAKmqyKPPp2Dhti9KMPa=jgYyGJzgMsiGYMFSVTbMmpsrnaRsDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKmqyKPPp2Dhti9KMPa=jgYyGJzgMsiGYMFSVTbMmpsrnaRsDQ@mail.gmail.com>
User-Agent: Mutt/2.1.4 (2021-12-11)
X-Originating-IP: [10.0.12.12]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 47C2i94i080514
Received-SPF: pass client-ip=60.248.80.70; envelope-from=ethan84@andestech.com;
 helo=Atcsqr.andestech.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, RDNS_DYNAMIC=0.982,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, TVD_RCVD_IP=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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
Reply-to:  Ethan Chen <ethan84@andestech.com>
From:  Ethan Chen via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Aug 12, 2024 at 10:47:33AM +1000, Alistair Francis wrote:
> [EXTERNAL MAIL]
> 
> On Fri, Aug 9, 2024 at 8:11 PM Ethan Chen <ethan84@andestech.com> wrote:
> >
> > On Thu, Aug 08, 2024 at 02:23:56PM +1000, Alistair Francis wrote:
> > >
> > > On Mon, Jul 15, 2024 at 8:13 PM Ethan Chen via <qemu-devel@nongnu.org> wrote:
> > > >
> > > > To enable system memory transactions through the IOPMP, memory regions must
> > > > be moved to the IOPMP downstream and then replaced with IOMMUs for IOPMP
> > > > translation.
> > > >
> > > > The iopmp_setup_system_memory() function copies subregions of system memory
> > > > to create the IOPMP downstream and then replaces the specified memory
> > > > regions in system memory with the IOMMU regions of the IOPMP. It also
> > > > adds entries to a protection map that records the relationship between
> > > > physical address regions and the IOPMP, which is used by the IOPMP DMA
> > > > API to send transaction information.
> > > >
> > > > Signed-off-by: Ethan Chen <ethan84@andestech.com>
> > > > ---
> > > >  hw/misc/riscv_iopmp.c         | 61 +++++++++++++++++++++++++++++++++++
> > > >  include/hw/misc/riscv_iopmp.h |  3 ++
> > > >  2 files changed, 64 insertions(+)
> > > >
> > > > diff --git a/hw/misc/riscv_iopmp.c b/hw/misc/riscv_iopmp.c
> > > > index db43e3c73f..e62ac57437 100644
> > > > --- a/hw/misc/riscv_iopmp.c
> > > > +++ b/hw/misc/riscv_iopmp.c
> > > > @@ -1151,4 +1151,65 @@ iopmp_register_types(void)
> > > >      type_register_static(&iopmp_iommu_memory_region_info);
> > > >  }
> > > >
> > > > +/*
> > > > + * Copies subregions from the source memory region to the destination memory
> > > > + * region
> > > > + */
> > > > +static void copy_memory_subregions(MemoryRegion *src_mr, MemoryRegion *dst_mr)
> 
> Maybe `alias_memory_subregions()` or `link_memory_subregions()`
> instead of `copy_memory_subregions()`.

Thanks for the suggestion. I will clarify it.

> 
> > > > +{
> > > > +    int32_t priority;
> > > > +    hwaddr addr;
> > > > +    MemoryRegion *alias, *subregion;
> > > > +    QTAILQ_FOREACH(subregion, &src_mr->subregions, subregions_link) {
> > > > +        priority = subregion->priority;
> > > > +        addr = subregion->addr;
> > > > +        alias = g_malloc0(sizeof(MemoryRegion));
> > > > +        memory_region_init_alias(alias, NULL, subregion->name, subregion, 0,
> > > > +                                 memory_region_size(subregion));
> > > > +        memory_region_add_subregion_overlap(dst_mr, addr, alias, priority);
> > > > +    }
> > > > +}
> > >
> > > This seems strange. Do we really need to do this?
> > >
> > > I haven't looked at the memory_region stuff for awhile, but this seems
> > > clunky and prone to breakage.
> > >
> > > We already link s->iommu with the system memory
> > >
> >
> > s->iommu occupies the address of the protected devices in system
> > memory. Since IOPMP does not alter address, the target address space
> > must differ from system memory to avoid infinite recursive iommu access.
> >
> > The transaction will be redirected to a downstream memory region, which
> > is almost identical to system memory but without the iommu memory
> > region of IOPMP.
> >
> > This function serves as a helper to create that downstream memory region.
> 
> What I don't understand is that we already have target_mr as a
> subregion of downstream, is that not enough?
>

Did you mean the target_mr in iopmp_setup_system_memory? It specifies
the container that IOPMP wants to protect. We don't create 
separate iommus for each subregion. We create a single iommu for the
entire container (system memory).

The access to target_mr (system memory) which has iommu region of 
IOPMP, will be translated to downstream which has protected device 
regions.

Thanks,
Ethan Chen

