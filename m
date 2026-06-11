Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23E92CD98CE
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 15:06:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXgyh-0004tm-7h; Thu, 11 Jun 2026 11:05:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wXgyV-0004pR-Ry
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 11:05:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wXgyS-0001qp-NB
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 11:05:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781190339;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5RniOX6ixccF2AGma/e8WiMOO0iqUo0Ut3f5iyHXKVo=;
 b=ig6pAL692AeuU9gNwbJt6xjCYMMIDsy/wMlW1w3xf4sTUiDCSJLrBhFx6218y/i1Hr+9ls
 VtZCaqIXTMF9MQ3Wy20uM6CPWoxAvnX974SrmrXKtwsFeKFdb5H89GDJBaP6OjrPa1e7/V
 ivonIbj2Kk5D1Tp8mEiVPAtXlWB7lvA=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-kdD_deYEMDCy_S4f312KGg-1; Thu, 11 Jun 2026 11:05:37 -0400
X-MC-Unique: kdD_deYEMDCy_S4f312KGg-1
X-Mimecast-MFC-AGG-ID: kdD_deYEMDCy_S4f312KGg_1781190336
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-bed16fc8424so748094066b.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 08:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781190336; x=1781795136; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=5RniOX6ixccF2AGma/e8WiMOO0iqUo0Ut3f5iyHXKVo=;
 b=pfuTOH3qYbNplxvNBf7DXSXbX0lUj04FZz8lYilEEHW/eRjM+vGOYoH3THAtfT9hwa
 XYaR7rGdSUuqW6MGdV5LVgNZFAQGIXvzoxm3iqtIsn8OJ/UjL6cjF8jhY3Vkl9ub7NyM
 5HQbYxLyqu8AzN8iBrKCWw3wIcz7Q8gnRrtPjqhjHkAAJSwHZccaqVuAZ3NdGvxLKRQK
 jhc1Jq+yxOiVixqAdNkoiFmUZygP74l5fk9xWJAY+7FM0BcGtZ5VH9fqKUKqG8Z0vXXd
 xSFxQRDlqXRO5vShycaUOPZFF+tlEDdaOyMCNmtnA6EcXc0786ZpD+rFJoo7+QBR/O+l
 tgbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781190336; x=1781795136;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5RniOX6ixccF2AGma/e8WiMOO0iqUo0Ut3f5iyHXKVo=;
 b=Yc74i6aRE5Q/6GHr4dS1Fe5l6belkzj9uwUoiSyD3fqQJCe8Xn2YRd+xnwTglcEiQ2
 axjfw67ByOH4p6Jirc7tEZoyGINO+dRHOb+hsSFEQNnhbA+FltQpM38eYHPuNePF4B/L
 bMjfwiZCvCkvZz6G8aCkjlGJoJi4UIPg81M54kaYwTbTXF73jbaQBySMzaHdlvGseoRo
 WugvwxCjHbjtjouqasMurrBwADaq+9O2EEeU9YwJsDYhyLM25wyq4Vuorf5hOshyiXYK
 K5PDCX/rffjIjsCpjdzRMnyjP03aYe9kdGvjjoYgKkm2eViiSryJi8+f+ZoZSLlDru5S
 s+ew==
X-Forwarded-Encrypted: i=1;
 AFNElJ/2aViTVQiM6oG6KaI2vFW47bqB25uVC/cNUuLD2llbcOP97y0lj8DIVF/WwRFhP6erSnpuLALbfttW@nongnu.org
X-Gm-Message-State: AOJu0YxWvwSlauiRHshm5iu0ApDHgnXX2KoxKtwPOsxw18ZK5FqDwDmi
 K4HSwgkOGYIoj2hhezD6og50zSjU3voVwxk7wzilVvM58yRqW7e3i1Q1TElCPAx0lUQLGBhtNiC
 lT42wPFb+71XOTNyBr7WNlJYlFiA9nNTGGywuNQ0cMZXWHNermF1fqGfo
X-Gm-Gg: Acq92OF9POGvKsTQOyLRXBaT565HzHgRrpDjLUltDfDm9fSlndPfbomKngYciqXijT8
 YzVAiv9I18+2ghxU74tfDeNWIta5v3Yg1qzNgv9xSsH8Kl5U8TGoPPQ3W9r1QFiMnrxXXh3lHmd
 oS88+26YMY+uRPPwQcescZmiAOddRbI8asyPNb2mVAVIIVWP5hoWiJShqB4TcwvsJfjMQF/1oZn
 bYQUPd8ldeXUNlXMUSSZFd+KwPS2XRsJRUqhJjrplsmqHJOnbLkZyvkTKhwl3vNEaG1NCc19/h9
 pPPw/yOvS2QVVu2/J6tvkCkWiTU0jWf8sn5Y0Ztx64od6rFljzf5kVgaMMdLg285arsYLEze1LA
 W0s3DCI00EZ9EeHmQdxn1F+cXrCA0sYAd+CP98AtSkiWQqMwhvHnMxw==
X-Received: by 2002:a17:907:6095:b0:bfa:e08e:3f1f with SMTP id
 a640c23a62f3a-bfc863e3cccmr189044266b.24.1781190335900; 
 Thu, 11 Jun 2026 08:05:35 -0700 (PDT)
X-Received: by 2002:a17:907:6095:b0:bfa:e08e:3f1f with SMTP id
 a640c23a62f3a-bfc863e3cccmr189039566b.24.1781190335146; 
 Thu, 11 Jun 2026 08:05:35 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bfcb1608bcasm77572466b.19.2026.06.11.08.05.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 08:05:34 -0700 (PDT)
Date: Thu, 11 Jun 2026 11:05:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Gavin Shan <gshan@redhat.com>, Peter Xu <peterx@redhat.com>,
 Pavel Hrdina <phrdina@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, jugraham@redhat.com,
 shan.gavin@gmail.com, Alex Williamson <alex@shazbot.org>,
 David Hildenbrand <david@kernel.org>
Subject: Re: [PATCH RFCv1] virtio: Inherit max bounce buffer size from bus
 parent if possible
Message-ID: <20260611110156-mutt-send-email-mst@kernel.org>
References: <aimEl9QQ_LTRPLtd@x1.local>
 <20260610121026-mutt-send-email-mst@kernel.org>
 <1e9515c9-7e32-4d95-9b73-aab8bf10bddc@redhat.com>
 <20260611012217-mutt-send-email-mst@kernel.org>
 <3726a607-6cac-41f1-b402-0eed7c4e3fe3@redhat.com>
 <20260611023428-mutt-send-email-mst@kernel.org>
 <0c3f1dba-3b2c-43c5-b181-1426f6da0951@redhat.com>
 <CAFEAcA8Q9qEaZS8wCpZQ-4jpAnQ9JXvnb7iSeRTdhJ9Y3BcCRg@mail.gmail.com>
 <20260611093049-mutt-send-email-mst@kernel.org>
 <CAFEAcA-8Hv0o3PibjH=8jixsHyunH2HkOAMQVqHkGr34b1Ascg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA-8Hv0o3PibjH=8jixsHyunH2HkOAMQVqHkGr34b1Ascg@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Jun 11, 2026 at 03:55:12PM +0100, Peter Maydell wrote:
> On Thu, 11 Jun 2026 at 15:10, Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Thu, Jun 11, 2026 at 01:48:51PM +0100, Peter Maydell wrote:
> > > On Thu, 11 Jun 2026 at 13:34, Gavin Shan <gshan@redhat.com> wrote:
> > > >
> > > > Let me try to summarize what I understood. As VFIO is concerned, there
> > > > are multiple memory regions for one particular PCI BAR, and they're stacked
> > > > up. The memory regions for PCI BAR#4 of the GH100 card looks as below.
> > > >
> > > >    (qemu) info mtree
> > > >               :
> > > >    address-space: pci_bridge_pci_mem
> > > >      0000000000000000-ffffffffffffffff (prio 0, container): pci_bridge_pci
> > > >        0000042000000000-0000043fffffffff (prio 1, i/o): 0009:01:00.0 base BAR 4          <---- (1) VFIOBAR::mr
> > > >          0000042000000000-0000043fffffffff (prio 0, i/o): 0009:01:00.0 BAR 4             <---- (2) VFIOBAR::VFIORegion::mem
> > > >            0000042000000000-000004379fffffff (prio 0, ramd): 0009:01:00.0 BAR 4 mmaps[0] <---- (3) VFIOBAR::VFIORegion::VFIOMap::mem
> > > >
> > > >    (1) Its MemoryRegionOps is NULL. No data accesses are routed to this region
> > > >    (2) The data accesses routed to this region is handled by pread() and pwrite()
> > > >    (3) The data accesses routed to this region is handled by memcpy() before
> > > >        commit 4a2e242bbb.
> > > >
> > > > There are identified PCI devices who have quirks, see vfio_bar_quirk_setup().
> > > > Accesses to part of the PCI BAR have to be emulated by the extra IO regions,
> > > > something like below for rtl8168 PCI device, where two extra IO regions are
> > > > stacked up for the quirks.
> > > >
> > > >    address-space: pci_bridge_pci_mem
> > > >      0000000000000000-ffffffffffffffff (prio 0, container): pci_bridge_pci
> > > >        0000042000000000-0000043fffffffff (prio 1, i/o): 0009:01:00.0 base BAR 4          <---- (1) VFIOBAR::mr
> > > >          0000042000000000-0000043fffffffff (prio 0, i/o): 0009:01:00.0 BAR 4             <---- (2) VFIOBAR::VFIORegion::mem
> > > >            0000042000000000-000004379fffffff (prio 0, ramd): 0009:01:00.0 BAR 4 mmaps[0] <---- (3) VFIOBAR::VFIORegion::VFIOMap::mem
> > > >            0000042000000010-0000042000000014 (prio 1, i/o): 0009:01:00.0 BAR 4 quirk[0]  <---- (4) quirk[0]
> > > >            0000042000000018-000004200000001c (prio 1, i/o): 0009:01:00.0 BAR 4 quirk[1]  <---- (5) quirk[1]
> > > >
> > > > Access on 0000042000000010-0000042000000014 should be routed to region (4) quirk[0]
> > > > and access on 0000042000000018-000004200000001c should be routed to region (5) quirk[1].
> > > > However, accesses to 0000042000000000-0000042000000020 are routed to region (3) before
> > > > commit 4a2e242bbb and the data transfer is done by memcpy(), bypassing region (4) and
> > > > (5). It's not the expected behavior and why memcpy() isn't expected on device rtl8168's
> > > > PCI BAR due to the quirks, answering your question.
> > > >
> > > > With commit 4a2e242bbb applied, the accesses will be routed to the correct region.
> > >
> > > The way I read 4a2e242bbb's commit message, it isn't about things being routed
> > > to the wrong region. It's about the handling of areas which aren't in the small
> > > quirk regions but which are in the same 4K page as them. These have to
> > > be handled
> > > via the memory subsystem's "subpage" mechanism. This does route
> > > everything to the
> > > correct region, but if the region (3) is marked as "direct access is OK" then
> > > QEMU assumes that any kind of direct access is OK, i.e. this behaves
> > > like true RAM.
> > > It then does a memcpy access to a BAR that's really a bank of device registers,
> > > and this goes wrong.
> > >
> > > > Back to our case (GH100 card), there are no quirks for the PCI BAR (0009:01:00.0 BAR 4)
> > > > so it's fine mark the RAM DEVICE region as directly accessible. We perhaps needn't host
> > > > to export the capability (VFIO_REGION_INFO_CAP_DIRECT_ACCESS) suggested by you. It's
> > > > safe to mark any PCI BARs as directly accessible if they have no quirks attached. All
> > > > the devices except those listed in vfio_bar_quirk_setup() are capable of this.
> > >
> > > I still feel like there are different kinds of PCI BAR here ("this BAR is
> > > true RAM and can be accessed arbitrarily" vs "this BAR is full of registers
> > > and can't be handled that way") and the vfio code in QEMU needs to set up
> > > the memory regions differently for the two cases. For your example I think
> > > it would be fine to have direct-access even if there were some kind of
> > > quirk memory region, because for the parts of the BAR that aren't covered
> > > by a quirk overlay the underlying BAR still allows "entirely like RAM,
> > > any alignment and size is OK" accesses.
> 
> > Yea, and I feel this is the main part:
> >
> >     The assumption here is that accesses initiated by the VM are
> >     driven by a device specific driver, which knows the device
> >     capabilities.
> >
> >
> > Frankly I don't get why a big hammer of disabling direct access
> > was taken, when all we apparently need to do is to make sure
> > small aligned accesses through BAR stay aligned and same size.
> 
> If you say an MR is OK for direct access then in my view you are
> saying "any access of any kind is OK", because you're permitting
> the pointer to be directly returned as a host pointer from
> address_space_map() (at which point the caller might do anything
> with that memory). That is not OK for every BAR, only for ones where
> it's really RAM.
>

What is "OK"? If the BAR is RAM and I write into it, I will overwrite
data guest stored there. Is that "OK"?



 
> > I guess it felt safe - a vfio specific change, and emulating device
> > accesses was assumed to be slow path, anyway.
> >
> > Except it no longer is with people wanting to do direct io
> > into device BARs.
> 
> > Isn't it basically the below?
> > At least I checked asm and it produces the correct code.
> > And then the whole pile of hacks can be reverted?
> >
> >
> > diff --git a/system/physmem.c b/system/physmem.c
> > index 7bcbf87573..aab4390d40 100644
> > --- a/system/physmem.c
> > +++ b/system/physmem.c
> > @@ -3272,7 +3272,29 @@ static MemTxResult flatview_write_continue_step(MemTxAttrs attrs,
> >          uint8_t *ram_ptr = qemu_ram_ptr_length(mr->ram_block, mr_addr, l,
> >                                                 false, true);
> >
> > -        memmove(ram_ptr, buf, *l);
> > +        switch (*l) {
> > +        case 1:
> > +            __builtin_memmove(ram_ptr, buf, 1);
> > +            break;
> > +        case 2:
> > +            __builtin_memmove(ram_ptr, buf, 2);
> > +            break;
> > +        case 4:
> > +            __builtin_memmove(ram_ptr, buf, 4);
> > +            break;
> > +        case 8:
> > +            __builtin_memmove(ram_ptr, buf, 8);
> 
> Nothing says that __builtin_memmove() is required to do only a single
> access of the right size.
> memmove() can do all kinds of things.
> For instance on aarch64 if you get into the actual glibc memmove then
> a memmove of 1 byte will actually store the same byte multiple times.
> Or an architecture might decide that it's more efficient to do an
> 8-byte write with two 4-byte writes even if there is an 8-byte access
> instruction.
> 
> If and where we need to provide guarantees about "this access will
> really definitely only do this size access and it won't break it
> apart or anything like that" then we need to either be using compiler
> atomics or else inline asm.
> 
> (I think there are places where we do need to be more careful about
> what we do with accesses to real RAM, for where we're emulating a
> device write to RAM that's updating a data structure shared with the
> guest, and things like writing multiple times can cause problems.
> https://lore.kernel.org/qemu-devel/CAFEAcA8dwHV8F48kb-013rxkG9kKcZhym9_qarKmoeUfeh0YWw@mail.gmail.com/
> is an unrelated example of that, which I haven't done detailed
> analysis of yet.)
> 
> thanks
> -- PMM

If it does not work, then QEMU is broken:


/*
 * Any compiler worth its salt will turn these memcpy into native unaligned
 * operations.  Thus we don't need to play games with packed attributes, or
 * inline byte-by-byte stores.
 * Some compilation environments (eg some fortify-source implementations)
 * may intercept memcpy() in a way that defeats the compiler optimization,
 * though, so we use __builtin_memcpy() to give ourselves the best chance
 * of good performance.
 */

static inline int lduw_he_p(const void *ptr)
{
    uint16_t r;
    __builtin_memcpy(&r, ptr, sizeof(r));
    return r;
}

static inline int ldsw_he_p(const void *ptr)
{
    int16_t r;
    __builtin_memcpy(&r, ptr, sizeof(r));
    return r;
}

static inline void stw_he_p(void *ptr, uint16_t v)
{
    __builtin_memcpy(ptr, &v, sizeof(v));
}




Somehow things have worked for years without atomics,
but if you want to fix that, be my guest.


-- 
MST


