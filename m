Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37B7ACD8CA8
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 08:43:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXxTr-0003vp-Jq; Fri, 12 Jun 2026 04:43:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wXxTq-0003vh-9u
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 04:43:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wXxTo-0003Bk-F7
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 04:43:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781253787;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CiQsaORxtMIvHq95jZcjcnF36rd1YYR82LOVNgV3M+Q=;
 b=h8d3WuOEDyJzMt3/m1R30CdCVoAfLvhL1R3lPR9PgcE3CVWSDpttttDTfpwaI3UzwFoMnN
 Xk/obQy/CBnloAKgmh3rtUEVVcBOUidg6O11Pi0/BVW7FNa1aWMqrUnIqFLS2Bz78HreTr
 afj/PTQgxdC550VlEPxeYrn51zFtooE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-AKCFif8GMXm8HRbtqWXo1w-1; Fri, 12 Jun 2026 04:43:05 -0400
X-MC-Unique: AKCFif8GMXm8HRbtqWXo1w-1
X-Mimecast-MFC-AGG-ID: AKCFif8GMXm8HRbtqWXo1w_1781253784
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-490bde3d239so4306345e9.1
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2026 01:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781253784; x=1781858584; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CiQsaORxtMIvHq95jZcjcnF36rd1YYR82LOVNgV3M+Q=;
 b=leV3HJP4gqnBu5nb/WXRZ9vvgbAMJRFojoDyFIGBj14dIln8S8HIQ6ntlcphBJm9xY
 u8E9a3Q7symVHoeF3+d4C2rytTWOrT5qklSLO2i2zfD7yKUWQTvNQxTBHtJZsUakr6ql
 WmyF4V48677nEOmQGird1uBd10QLl5tJP+f5e64wMZ1lwNliB8Oa1543G/fVPmgobfNV
 aldDGsAMb9fQqj3Q45pOy077UvyzJPoFi/FfcNdvSqJtmpmAu0dsoai7B62BijPQ2bsR
 Oqa5h8vrcOnxRcwtGuUeZuUVRZXibgStDm/Rtu5roxFB/5XrRczi8FaN+ldR8fXBazYc
 Rqbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781253784; x=1781858584;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CiQsaORxtMIvHq95jZcjcnF36rd1YYR82LOVNgV3M+Q=;
 b=EPievysyYdWblwjS0gxxJ1IU3VQDIUMvPS+hOgr7YAyeaXRyWrlnzvfEqgPjJfsPPt
 nJTRkUAaKR4pBXStqLJOdcvv6LaenG5rJK6SqwwymIstkzZzJtEFIfl8u61E3/oUN22A
 Laji06OhOYCDIXd4p22v6wsqLB3Zr02Ozr0/Yz5RJ7eJyxRHHbSELW8D0OYGy78MvcPA
 t3lgsVpkVIU7Y6l6Mx4jj5KkcoGwGuTb0Y1VCRmTtK2QaVnyrr3hcCfW7T4Sm0QBHosn
 TAkpNvX9MZeeHD82+7WskA4URz0cs9oANDYMhJN/rB9Vjwh8+Wit+M2SM126lYIfR/SD
 sXDw==
X-Forwarded-Encrypted: i=1;
 AFNElJ89SOarLQo0+EznzFYdOrtLqjSLcNjepGVqd+vr3z7zhnunr41pRG0Zg/1b8ZZLV5BjPCCBuUjzGTFz@nongnu.org
X-Gm-Message-State: AOJu0Yz4H0Mx+1EnGOxBM9+UZM7C5dcc2Jn3fYbBPFXARNSor6A5jqU5
 WWNbQ/sF++mZD6j5NBYTTdKDq9dZ9JyuxpnWrg6Owh07ABX2+Jb7jCwfipSESIA2U5NtISchT6e
 LFjdX8w9raRR4jMqUCXXD8SgwNx4mWBDUEOkxQBXnqN92Oax5Mjv4UjqN
X-Gm-Gg: Acq92OFVM7uUfACFaOO2t6dV6+AyQ2eYKl9EFVbc9DuXVvo3nBIikHdvMm0ZYaPhoWW
 qrqCkJLMAQz9/FtGaE2JRJleJ3GLsRBwz8shnNn4rRCreRP4nC//kyzFzJRSuIU0e9UEvwqh1r1
 V4SQxaSF3+33D+a33y2DFnPIvgknzafSMlQsHRo8ZgUUi1UzqQNm4IfxagIaqDXSjz2UdOfmBzh
 rmNAXfKBmPBePGX2gsbtGPFDrsJpfJoaVKWc+V3UDKsI3em4KJL6WUGu87WjpKP3CNK/1/7RRiZ
 5YnRINo7/+NREsvc1vFz1aqpGNzMr9embaRtOPS76pPnNlrMC4iwluOk6ZJRLwK52aKNCrYlf5Q
 PQ/gitJhmHZIAu7nMRQYaSMZ4pc/Y9dSwt1UOJfNEAzo=
X-Received: by 2002:a05:600c:820c:b0:490:bcf6:46bf with SMTP id
 5b1f17b1804b1-490ec4cdf95mr21839285e9.9.1781253784338; 
 Fri, 12 Jun 2026 01:43:04 -0700 (PDT)
X-Received: by 2002:a05:600c:820c:b0:490:bcf6:46bf with SMTP id
 5b1f17b1804b1-490ec4cdf95mr21838565e9.9.1781253783662; 
 Fri, 12 Jun 2026 01:43:03 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2e6a8fsm3701992f8f.37.2026.06.12.01.43.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 01:43:03 -0700 (PDT)
Date: Fri, 12 Jun 2026 04:43:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gavin Shan <gshan@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>,
 Pavel Hrdina <phrdina@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, jugraham@redhat.com,
 shan.gavin@gmail.com, Alex Williamson <alex@shazbot.org>,
 David Hildenbrand <david@kernel.org>
Subject: Re: [PATCH RFCv1] virtio: Inherit max bounce buffer size from bus
 parent if possible
Message-ID: <20260612044147-mutt-send-email-mst@kernel.org>
References: <20260610095712-mutt-send-email-mst@kernel.org>
 <aimEl9QQ_LTRPLtd@x1.local>
 <20260610121026-mutt-send-email-mst@kernel.org>
 <1e9515c9-7e32-4d95-9b73-aab8bf10bddc@redhat.com>
 <20260611012217-mutt-send-email-mst@kernel.org>
 <3726a607-6cac-41f1-b402-0eed7c4e3fe3@redhat.com>
 <20260611023428-mutt-send-email-mst@kernel.org>
 <0c3f1dba-3b2c-43c5-b181-1426f6da0951@redhat.com>
 <CAFEAcA8Q9qEaZS8wCpZQ-4jpAnQ9JXvnb7iSeRTdhJ9Y3BcCRg@mail.gmail.com>
 <ec32c5ae-782c-4c83-8432-23d979552fbe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec32c5ae-782c-4c83-8432-23d979552fbe@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Jun 12, 2026 at 02:25:07PM +1000, Gavin Shan wrote:
> On 6/11/26 10:48 PM, Peter Maydell wrote:
> > On Thu, 11 Jun 2026 at 13:34, Gavin Shan <gshan@redhat.com> wrote:
> > > 
> > > Let me try to summarize what I understood. As VFIO is concerned, there
> > > are multiple memory regions for one particular PCI BAR, and they're stacked
> > > up. The memory regions for PCI BAR#4 of the GH100 card looks as below.
> > > 
> > >     (qemu) info mtree
> > >                :
> > >     address-space: pci_bridge_pci_mem
> > >       0000000000000000-ffffffffffffffff (prio 0, container): pci_bridge_pci
> > >         0000042000000000-0000043fffffffff (prio 1, i/o): 0009:01:00.0 base BAR 4          <---- (1) VFIOBAR::mr
> > >           0000042000000000-0000043fffffffff (prio 0, i/o): 0009:01:00.0 BAR 4             <---- (2) VFIOBAR::VFIORegion::mem
> > >             0000042000000000-000004379fffffff (prio 0, ramd): 0009:01:00.0 BAR 4 mmaps[0] <---- (3) VFIOBAR::VFIORegion::VFIOMap::mem
> > > 
> > >     (1) Its MemoryRegionOps is NULL. No data accesses are routed to this region
> > >     (2) The data accesses routed to this region is handled by pread() and pwrite()
> > >     (3) The data accesses routed to this region is handled by memcpy() before
> > >         commit 4a2e242bbb.
> > > 
> > > There are identified PCI devices who have quirks, see vfio_bar_quirk_setup().
> > > Accesses to part of the PCI BAR have to be emulated by the extra IO regions,
> > > something like below for rtl8168 PCI device, where two extra IO regions are
> > > stacked up for the quirks.
> > > 
> > >     address-space: pci_bridge_pci_mem
> > >       0000000000000000-ffffffffffffffff (prio 0, container): pci_bridge_pci
> > >         0000042000000000-0000043fffffffff (prio 1, i/o): 0009:01:00.0 base BAR 4          <---- (1) VFIOBAR::mr
> > >           0000042000000000-0000043fffffffff (prio 0, i/o): 0009:01:00.0 BAR 4             <---- (2) VFIOBAR::VFIORegion::mem
> > >             0000042000000000-000004379fffffff (prio 0, ramd): 0009:01:00.0 BAR 4 mmaps[0] <---- (3) VFIOBAR::VFIORegion::VFIOMap::mem
> > >             0000042000000010-0000042000000014 (prio 1, i/o): 0009:01:00.0 BAR 4 quirk[0]  <---- (4) quirk[0]
> > >             0000042000000018-000004200000001c (prio 1, i/o): 0009:01:00.0 BAR 4 quirk[1]  <---- (5) quirk[1]
> > > 
> > > Access on 0000042000000010-0000042000000014 should be routed to region (4) quirk[0]
> > > and access on 0000042000000018-000004200000001c should be routed to region (5) quirk[1].
> > > However, accesses to 0000042000000000-0000042000000020 are routed to region (3) before
> > > commit 4a2e242bbb and the data transfer is done by memcpy(), bypassing region (4) and
> > > (5). It's not the expected behavior and why memcpy() isn't expected on device rtl8168's
> > > PCI BAR due to the quirks, answering your question.
> > > 
> > > With commit 4a2e242bbb applied, the accesses will be routed to the correct region.
> > 
> > The way I read 4a2e242bbb's commit message, it isn't about things being routed
> > to the wrong region. It's about the handling of areas which aren't in the small
> > quirk regions but which are in the same 4K page as them. These have to
> > be handled
> > via the memory subsystem's "subpage" mechanism. This does route
> > everything to the
> > correct region, but if the region (3) is marked as "direct access is OK" then
> > QEMU assumes that any kind of direct access is OK, i.e. this behaves
> > like true RAM.
> > It then does a memcpy access to a BAR that's really a bank of device registers,
> > and this goes wrong.
> > 
> 
> Ok, thanks for your followup and explanation. I also spent some time going through
> system/memory.h and system/physmem.c. I think I fully understood the issue now. There
> are two concerning paths as mentioned by Peter Xu in another reply: (a) vCPU accessors
> like address_space_rw(), address_space_write_rom(), address_space_ldq(), address_space_stq()
> and their variants; (b) functions used in the DMA path like address_space_map() and
> address_space_unmap().
> 
> For (a), memmove() and memcpy() are used, and they can be replaced something else that
> is safe. However, the replacement in (a) can't fix the issue existing in (b). In (b),
> the host's pointer is returned by address_space_map() and the memory block (perhaps not
> a real RAM block) can be accessed in all means after that. I guess we have to ensure
> the memory region is a real RAM block before the pointer can be returned in (b). Otherwise,
> we still fall back to the bounce buffer in (b).


No guest will DMA into a "non RAM block". Whatever is a DMA target, is a
'real RAM block'.

> > > Back to our case (GH100 card), there are no quirks for the PCI BAR (0009:01:00.0 BAR 4)
> > > so it's fine mark the RAM DEVICE region as directly accessible. We perhaps needn't host
> > > to export the capability (VFIO_REGION_INFO_CAP_DIRECT_ACCESS) suggested by you. It's
> > > safe to mark any PCI BARs as directly accessible if they have no quirks attached. All
> > > the devices except those listed in vfio_bar_quirk_setup() are capable of this.
> > 
> > I still feel like there are different kinds of PCI BAR here ("this BAR is
> > true RAM and can be accessed arbitrarily" vs "this BAR is full of registers
> > and can't be handled that way") and the vfio code in QEMU needs to set up
> > the memory regions differently for the two cases. For your example I think
> > it would be fine to have direct-access even if there were some kind of
> > quirk memory region, because for the parts of the BAR that aren't covered
> > by a quirk overlay the underlying BAR still allows "entirely like RAM,
> > any alignment and size is OK" accesses.
> > 
> 
> Agreed. If the PCI BAR is a 'real RAM block' is determined by hardware vendor. I
> think the solution proposed by Michael is a nice one as this specific case is concerned:
> A flag (capability) is returned by nvgrace_gpu_vfio_pci driver to indicate that the
> PCI BAR is a 'real RAM block' and tolerant to all kinds of memory accessor. QEMU marks
> the memory region for this PCI BAR as directly accessible. Alternatively, qemu also
> can determine the capability by the PCI device's vendor/device/subsystem/version information
> in hw/vfio/region.c.
> 


I sent it before I understood the issue.

> > -- PMM
> > 
> 
> Thanks,
> Gavin


