Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07E30CD98CC
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 22:01:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXnRz-0008I2-Ve; Thu, 11 Jun 2026 18:00:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wXnRd-0008GH-BZ
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 18:00:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wXnRZ-0005Kz-Cj
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 18:00:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781215204;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UrL+Uqr2Z6AKmkeO+s2/4F6LvSFLjRcHdB8v91WoUHY=;
 b=Iq0FKtYsonIz02EH6Hnth+pFPp318dUD1zW7kfBOLeCiDZUWkx9EoK92p0P8cySAfS2QOJ
 7wzcNVOoT3wwmemGu+/tkJmp77A6PBR2FrII+vDtMploWRgX3ghBlZM5xlnLxMxA5XFvsb
 ORDvY/qrp9turamXyuigb7+W5t0bCkA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-199-Fsu2nRBWNGu0yHTgeiQfbQ-1; Thu, 11 Jun 2026 18:00:02 -0400
X-MC-Unique: Fsu2nRBWNGu0yHTgeiQfbQ-1
X-Mimecast-MFC-AGG-ID: Fsu2nRBWNGu0yHTgeiQfbQ_1781215202
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-490b37e1f48so1694205e9.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 15:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781215202; x=1781820002; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=UrL+Uqr2Z6AKmkeO+s2/4F6LvSFLjRcHdB8v91WoUHY=;
 b=h6rcXHWHVjmZC+NpULStys26kv4kUXONE7GFG2R8otkjVM9UYu13BVq5A2f3gdJWVL
 U4xZ9e7+FGdN8FQM30CCtEWYidoyAJdqEOBwSfNTVH6E1dBbzRG9QFPl/Xbuoozp4n4M
 qb0Fcqy8j9TsiawMHTzgQdRBshB9GpxakzmSF2SVpYt30dfwfeK4UAWby1ugHsZAqKM3
 2XOj+wqfQhg69tT0RKzFFo0+OylTC6TY5JJOUiiFQx6Z8/vbWICaz6kj2SniFS+ZKzkp
 4hVwbf/ETK3bbQQYyX2r3rAJvXyLn4+P4j22umNgVCSl0W/BHxXXKtBcbeFzBHwWfKOt
 NWoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781215202; x=1781820002;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UrL+Uqr2Z6AKmkeO+s2/4F6LvSFLjRcHdB8v91WoUHY=;
 b=ofzOZvg8zuWVyFSHeL/eIhaXomSJ4atYjPLDvzaUf4nT9v0vedLFt98bNBMvRx4It8
 qD0udP7yK884iGfcFWy6Lqbtah1e8+V0EI+81RictIQ6oo4g7rLYVq8hWKowWyggGBQN
 GcN19xxFIbLKXWj62Bxa9awZ0yXIZlFiItm8t65d8YQp4RijZc6C/BRtKviTvHemYOKn
 1lBULc+PX41IaYU8IDl1PnPXZ7DZSE5jmnPchOism58rWr0kDkJ432lIG3PKirIapQAS
 tCey8UJX7fFaw/2yjlC6DYRxoMjRPOC95TMINdCnjidPFBhSX2Dt7ATk8ZsK2JGxiXPz
 G/Hw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/AMRg+KsV30yBDC16ChGkOH2OmlQbGPrpfJ54ibbfUVB2/N2Vr4I8IEjJOEFHaBDB6DYH2ryTDktI+@nongnu.org
X-Gm-Message-State: AOJu0YzUPE8GPDkkH+bbTFnXBaSPSz2U2+dLaEFChloi9/dH8r5RUxTk
 F42BGlNvCuUwWIiNau15T0FZmejXCqx6rZAZxgKuPwnHyaQNE1svJXfBrtnI9J31aeKDSY4oOO5
 fXkhj1c9331QaehrMFPbxJpFGm/nYsWqKoueeJChQL/3G4lanSkUM+2tB
X-Gm-Gg: Acq92OHB4H5kVTsssweFQshAUo86+P/BwycycjrJPcUSjueZIA2Oiv3cu34mfvB4vgM
 I76j1UKNhNeTAkbwN+7MyFYlvALTlb7SVPZ34qTYsaVIlbYy2/w5fXAxXQoHo1VJNOvzjwd14Zf
 wTgfGAIW2pvGU1JFEHdxg/hKWVoWm5onEI4rVuhfTEZsRHDjcpXLSmW627mWX2wsJeqHvxQKiGW
 9/rKbsVFCzeOCmRUGSM3Fgx7vd7TlO+1eTKSDRgvumnb18ObrrT2+9geO1Z8ihLI5cNGJsPf1kc
 2JqU8F/C/0OHWKGSQW5raaazRUVwy3d/+BKZXKzOpZe5NWAnNP6HAv4rWKp2U5rocurVQ9Yuh0L
 5pbWHtFBslGATnnsa7UzBxKinGy2nnFKIH1lulZrnnLs=
X-Received: by 2002:a05:600c:8b5c:b0:490:c6c2:bdc2 with SMTP id
 5b1f17b1804b1-490e55b6f4bmr64448695e9.4.1781215201571; 
 Thu, 11 Jun 2026 15:00:01 -0700 (PDT)
X-Received: by 2002:a05:600c:8b5c:b0:490:c6c2:bdc2 with SMTP id
 5b1f17b1804b1-490e55b6f4bmr64448335e9.4.1781215200917; 
 Thu, 11 Jun 2026 15:00:00 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490e2d0475asm155734575e9.12.2026.06.11.14.59.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 15:00:00 -0700 (PDT)
Date: Thu, 11 Jun 2026 17:59:57 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Gavin Shan <gshan@redhat.com>,
 Pavel Hrdina <phrdina@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, jugraham@redhat.com,
 shan.gavin@gmail.com, Alex Williamson <alex@shazbot.org>,
 David Hildenbrand <david@kernel.org>
Subject: Re: [PATCH RFCv1] virtio: Inherit max bounce buffer size from bus
 parent if possible
Message-ID: <20260611172830-mutt-send-email-mst@kernel.org>
References: <20260611110156-mutt-send-email-mst@kernel.org>
 <CAFEAcA_2oZepwCoPS+cMgdnrSTj=mCGzdFZf5gGRHJK13yqaKQ@mail.gmail.com>
 <20260611114811-mutt-send-email-mst@kernel.org>
 <CAFEAcA9HUGfDgHjvCemPPNkp6FfvQp+4y7qCnw+ROFpG3+ybMw@mail.gmail.com>
 <20260611123952-mutt-send-email-mst@kernel.org>
 <CAFEAcA8vOMd64cCkfCyc1wNbjEY+bnhFPce-V_WbAuXrUnP8cw@mail.gmail.com>
 <20260611130037-mutt-send-email-mst@kernel.org>
 <air8hrlhrkaoJ4wi@x1.local>
 <20260611164624-mutt-send-email-mst@kernel.org>
 <aismn4D1wXI6tipv@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aismn4D1wXI6tipv@x1.local>
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

On Thu, Jun 11, 2026 at 05:20:31PM -0400, Peter Xu wrote:
> On Thu, Jun 11, 2026 at 04:52:20PM -0400, Michael S. Tsirkin wrote:
> > On Thu, Jun 11, 2026 at 02:20:54PM -0400, Peter Xu wrote:
> > > On Thu, Jun 11, 2026 at 01:02:34PM -0400, Michael S. Tsirkin wrote:
> > > > On Thu, Jun 11, 2026 at 05:53:54PM +0100, Peter Maydell wrote:
> > > > > On Thu, 11 Jun 2026 at 17:42, Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > >
> > > > > > On Thu, Jun 11, 2026 at 05:16:09PM +0100, Peter Maydell wrote:
> > > > > > > On Thu, 11 Jun 2026 at 16:57, Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > > > > Then I'd like to see an example where we have an actual good reason
> > > > > > > > to do execute arbitrary width accesses on device RAM when the
> > > > > > > > driver does not execute them, please.
> > > > > > >
> > > > > > > That's the case we started with, with this GPU where the
> > > > > > > virtio data structures are in this PCI BAR. We want the
> > > > > > > virtio backend to have the freedom to say "I'm just going
> > > > > > > to assume the ring buffer etc is in RAM, and I don't need to
> > > > > > > care about carefully ensuring that I only do word accesses".
> > > > > >
> > > > > > virtio backend does not need to assume anything. any spec
> > > > > > compliant guest guarantees it. any address given to
> > > > > > a virtio device is ram.
> > > > > 
> > > > > OK, but how do we tell if the mmap() PCI BAR we have is RAM
> > > > > or not ? Some of them are, some of them aren't...
> > > > > 
> > > > > -- PMM
> > > > 
> > > > We don't care? If guest asked a virtio device to access
> > > > memory then that memory better support accesses guest
> > > > requested, and on virtio that means any width.
> > > 
> > > Yes that's also my understanding that QEMU shouldn't care, if on bare metal
> > > if it is a grey area with undefined behavior, then QEMU should also be fine
> > > to make it undefined.
> > > 
> > > Only one (IMHO, very slight..) concern is, if such "undefined behavior"
> > > operation may crash QEMU rather than causing a sigbus like what normally
> > > would happen on a bare metal.
> > 
> > bus errors are uncommon on bare metal. they aren't usually
> > handled all that well.
> 
> Ah, not something I was expecting to happen regularly.
> 
> In this case, the whole concern is about a possible malicious guest that
> might have installed a VFIO assigned device MMIO region (which may be
> register based; RAM-based is non-issue) to be a DMA target of anything.
> 
> > 
> > >  I'll put that discussion at last since I
> > > don't know if it's that important.
> > > 
> > > So taking that e1000 bug into account,
> > 
> > Won't the patch I sent resolve e1000 too?
> 
> If you mean:
> 
> https://lore.kernel.org/r/20260611093049-mutt-send-email-mst@kernel.org
> 
> Roughly, yes. But it is only to show the idea, not really a real patch?
> 
> I think we need to cover all the rest details (I mentioned all these in my
> previous reply too below):
> 
> - we should better leave memcpy()/memmove() as before for non-ram-device,
>   only do that for ram-devices
> 
> - per PeterM's comment, __builtin_memmove() may still have unwanted side
>   effects (I agree, it looks broken before and maybe we were lucky?)  need
>   to switch to atomics?
> 
> - two spots missing per my previous email here:
> 
>   https://lore.kernel.org/all/aimEl9QQ_LTRPLtd@x1.local/
> 
>   IIUC we should also fix these two, or is it intended to be left?
> 
>   address_space_read()
>   address_space_write_rom()
> 
> > 
> > > looks like we have more of such user
> > > that wants explicit control over the memory operations, likely with
> > > attibutes:
> > > 
> > > - Aligned only
> > > 
> > > - No vectored inst
> > > 
> > > - No possible duplication (perhaps it means, only use atomic access??? per
> > >   PeterM's explanation in another email)
> > > 
> > > I wonder if we should do this by default to all IOs, I think it might have
> > > an unwanted impact on general perf.  One idea is we can introduce a new bit
> > > in MemTxAttrs: say, mmio_strict, which will follow above stricter rule of
> > > doing IO.
> > > 
> > > Then for ram_device, when doing memory access we should also use the same
> > > set, hence something like:
> > > 
> > >   if (memory_access_is_direct(mr, ...)) {
> > >     if (MemTxAttrs.mmio_strict || memory_region_is_ram_device(mr)) {
> > >         memmove_strict_mmio(); // or memmove_no_vector(), or ...
> > >     }
> > >   }
> > > 
> > > I also want to bring us to the same page on differenciating two things:
> > > 
> > > - about direct access definition: so far, I want to define this almost as
> > >   "it is directly accessible from host virtual address space".  It means
> > >   ram_device definitely falls into this category, so it's a sub-category
> > >   only but enforces strict mmio as above
> > > 
> > > - bounce buffer: I want to make sure we're on the same page this is
> > >   something totally solving different problem of what we're looking at for
> > >   ram_device.  Essentially this is only needed if mem is not "direct
> > >   access".  Otherwise we shouldn't need it (including ram_device).
> > 
> > 
> > I think ram_device_direct_access is a hack that should go away.
> > It's a work around for a memory core bug that we should just fix.
> 
> I didn't find ram_device_direct_access, if you meant ram_device_mem_ops, I
> agree it'll be nice if we can avoid it.

Yes. Simply revert 4a2e242bbb that adds that.

> > 
> > 
> > 
> > > I'm not sure if above sounds reasonable.  The hope is with that we should
> > > fix both this GPU and e1000 issues (e1000, and maybe other places, needs to
> > > start passing MemTxAttrs.mmio_strict, though, if we want to keep the
> > > default to be still fast-path to use memcpy()/memmove()?).
> > > 
> > > Thanks,
> > > 
> > > =========================
> > > 
> > > Two cases here on the concern:
> > > 
> > > (1) if fully emulated device, non-issue afaiu because whatever DMA does
> > > (with vectored ops) will only apply to QEMU process (like a bounce
> > > buffer..) so it won't crash,
> > > 
> > > (2) if it's a VFIO device (not the GPU case, but when like realtek and some
> > > guest driver registers it as a DMA target), logically the guest should
> > > receive a bus error, but for QEMU's case it may crash QEMU with SIGBUS:
> > 
> > what and why would crash qemu?
> 
> If what Alex described issue happened in commit 4a2e242bbb ("memory: Don't
> use memcpy for ram_device regions"), IIUC it will crash qemu, but maybe I
> was wrong.  Alex knows the best.
> 
> So in general, we don't want malicious guest to be able to DoS the host
> process (hence, to me "niche security use case"..).
> 
> Thanks,
> 
> > 
> > > sigbus_handler() doesn't process anything except memory failures so far, it
> > > seems.  The right thing might be that we forward this sigbus to guest, but
> > > I didn't check further.
> > > 
> > > But I don't know if it would really happen, better verify it, and even if
> > > it will happen I still think it's a very niche security use case to cover
> > > so far.  Doesn't seem to be a blocker to fix a real perf problem first with
> > > RAM-like GPU devices.
> > > 
> > > -- 
> > > Peter Xu
> > 
> 
> -- 
> Peter Xu


