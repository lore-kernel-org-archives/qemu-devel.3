Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA1B1CD98C7
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 21:21:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXmpO-0002cF-TC; Thu, 11 Jun 2026 17:20:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wXmpM-0002bw-Gr
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 17:20:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wXmpK-0000c9-Ca
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 17:20:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781212837;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XRZeHuzLIjvxVV+yKALeN3x3CFURZFLwr4lvNIRkp3o=;
 b=Da8/4otVAVUPn2CjpYmRVs0Qr5Xu8iqwsbfenKVQ4myTnOcd0Zqt5y7YxcWyi7MYYdF1Ct
 oFwVkyQSm0ix7r4OO2Jqb3cOicRHosui6e8B6qNQkKfBmFLGI1bUHaWh+8SRYzGk2yz93s
 Llv1lXRRY1894yN9A1rcCUmv45VIgqA=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-V_LDLbEUOyeCy8aHi5TWQQ-1; Thu, 11 Jun 2026 17:20:36 -0400
X-MC-Unique: V_LDLbEUOyeCy8aHi5TWQQ-1
X-Mimecast-MFC-AGG-ID: V_LDLbEUOyeCy8aHi5TWQQ_1781212836
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51776d4355cso31739891cf.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 14:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781212836; x=1781817636; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=XRZeHuzLIjvxVV+yKALeN3x3CFURZFLwr4lvNIRkp3o=;
 b=ELU8RAUvdvZSprjJZYscsaBTiWQOdQz5ehdnrc3CqY8lgJfzsS77ECvrkw3G0BC9uq
 W7ON2UOxC+7zXZ1NU9gNUdWaWaRFLZKG1rHwLUlqyqHqQrLsC0Eqi1XuqSrewHf+fWAN
 XGUFadaliUQWK2/fSB/vKM03LzfIw9tmIlOH9ipctJsZ/r6csXcYyMgqhOej8D77V0lp
 rkheJWgGoRxzaOfwic+Ex2DTM0DXHOztqO2qGOfkyrTiU+jfeSuhLwJT0Lktud7Mn4ou
 xsqjGFmRETBCA99j188zppgWrJKAOxxfEFcmWZDorwpBhwmNLByr/v6xtcpAaa4mrEaA
 9iAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781212836; x=1781817636;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XRZeHuzLIjvxVV+yKALeN3x3CFURZFLwr4lvNIRkp3o=;
 b=YtY3Zu0U7mtTE9EB86jVch+CoInWdmMXgy1FMGtZXfq4VxGoUEA1OO1xv9gXxVTiYe
 pTaN61Npqmpaq/bcxsuQo6Y5Qmv6kXr66CNty9rX3VEORw3cs/nQbPUQ3wSr5yve2W8h
 7T8BjPpWIrxktZyGxoqwLHQwxU8o/qxBHElRIyu0xz8DKXc0uCuzjGcQJTnVANvfsOAa
 zPDsVlgTmP+wxFN/bq1ayX/e5BjYjnsqb7zOQtc1dCU0fFUqN0k575KRgTn6IELfw7xg
 +QZYdjipvKwaAJcBr1jpw0gY2n9Jw1oDSDb6ATcuZd7bIo/oz6DQzo83Nanc8P62cJTc
 CZYg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/L9aVqhPG5c4+yjq71hKN1QRpQgRG3mEpd4trJGqK6nnYuk1/SyZzJpFGmBJvvkQJxTMycGIc7tEB1@nongnu.org
X-Gm-Message-State: AOJu0YzfsMV3geimoZoLJqRNhsMjlKDO0hf2lDtmAIn4hR1Yfwi5ik+T
 cxy0b4gDbTYUmseWP63pId2jV0klb+ugnn1UElcGuAls86YTCE/C4g3VIOOV/1ZtU2PL6uOYJaQ
 RCJerb1dSmBuQkqfYvl8hTAxz7Z74lfobEKMS8u3M2Hk2hXpuTftUmnuC
X-Gm-Gg: Acq92OFImk9l8SxdGiFD81/wV+18BEaeA8FrmX9X8qN1/yMWVbhqvlNVGM312/DfXvW
 8/GiVoBX1p5aMYJHIsET/TMRtBW4rXw8jqX1gFSy8ECKNFTDGWKFPr6+OD1PKuqIHvFTonLHNib
 qMjro6fVv2pvngrYNNas326W+qXHi5T2eJgcGeNQcbZ/FpItXnjOwWmpwq0S7pjtISgIw0gIOEX
 4OCoQXUVjjfKoq1tB2gvnRcH3yp/7C6jRBagYn0QTpVu/u2B9TkLygHES4MCZeAOnN88Ajd8oGN
 pf6ny10j1vqJPzDnsfJDYG3llxSKjTe5YDw+eDxGEiUYWx1cws1IuW6FstI2r5f70rMXRH7aroI
 b+pZW/TGZhsakBGo=
X-Received: by 2002:ac8:7e92:0:b0:517:72df:787e with SMTP id
 d75a77b69052e-517fbeb236emr5916171cf.36.1781212835450; 
 Thu, 11 Jun 2026 14:20:35 -0700 (PDT)
X-Received: by 2002:ac8:7e92:0:b0:517:72df:787e with SMTP id
 d75a77b69052e-517fbeb236emr5915631cf.36.1781212834856; 
 Thu, 11 Jun 2026 14:20:34 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-517fb83db58sm3603411cf.27.2026.06.11.14.20.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 14:20:34 -0700 (PDT)
Date: Thu, 11 Jun 2026 17:20:31 -0400
From: Peter Xu <peterx@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Gavin Shan <gshan@redhat.com>,
 Pavel Hrdina <phrdina@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, jugraham@redhat.com,
 shan.gavin@gmail.com, Alex Williamson <alex@shazbot.org>,
 David Hildenbrand <david@kernel.org>
Subject: Re: [PATCH RFCv1] virtio: Inherit max bounce buffer size from bus
 parent if possible
Message-ID: <aismn4D1wXI6tipv@x1.local>
References: <CAFEAcA-8Hv0o3PibjH=8jixsHyunH2HkOAMQVqHkGr34b1Ascg@mail.gmail.com>
 <20260611110156-mutt-send-email-mst@kernel.org>
 <CAFEAcA_2oZepwCoPS+cMgdnrSTj=mCGzdFZf5gGRHJK13yqaKQ@mail.gmail.com>
 <20260611114811-mutt-send-email-mst@kernel.org>
 <CAFEAcA9HUGfDgHjvCemPPNkp6FfvQp+4y7qCnw+ROFpG3+ybMw@mail.gmail.com>
 <20260611123952-mutt-send-email-mst@kernel.org>
 <CAFEAcA8vOMd64cCkfCyc1wNbjEY+bnhFPce-V_WbAuXrUnP8cw@mail.gmail.com>
 <20260611130037-mutt-send-email-mst@kernel.org>
 <air8hrlhrkaoJ4wi@x1.local>
 <20260611164624-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260611164624-mutt-send-email-mst@kernel.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Jun 11, 2026 at 04:52:20PM -0400, Michael S. Tsirkin wrote:
> On Thu, Jun 11, 2026 at 02:20:54PM -0400, Peter Xu wrote:
> > On Thu, Jun 11, 2026 at 01:02:34PM -0400, Michael S. Tsirkin wrote:
> > > On Thu, Jun 11, 2026 at 05:53:54PM +0100, Peter Maydell wrote:
> > > > On Thu, 11 Jun 2026 at 17:42, Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > >
> > > > > On Thu, Jun 11, 2026 at 05:16:09PM +0100, Peter Maydell wrote:
> > > > > > On Thu, 11 Jun 2026 at 16:57, Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > > > Then I'd like to see an example where we have an actual good reason
> > > > > > > to do execute arbitrary width accesses on device RAM when the
> > > > > > > driver does not execute them, please.
> > > > > >
> > > > > > That's the case we started with, with this GPU where the
> > > > > > virtio data structures are in this PCI BAR. We want the
> > > > > > virtio backend to have the freedom to say "I'm just going
> > > > > > to assume the ring buffer etc is in RAM, and I don't need to
> > > > > > care about carefully ensuring that I only do word accesses".
> > > > >
> > > > > virtio backend does not need to assume anything. any spec
> > > > > compliant guest guarantees it. any address given to
> > > > > a virtio device is ram.
> > > > 
> > > > OK, but how do we tell if the mmap() PCI BAR we have is RAM
> > > > or not ? Some of them are, some of them aren't...
> > > > 
> > > > -- PMM
> > > 
> > > We don't care? If guest asked a virtio device to access
> > > memory then that memory better support accesses guest
> > > requested, and on virtio that means any width.
> > 
> > Yes that's also my understanding that QEMU shouldn't care, if on bare metal
> > if it is a grey area with undefined behavior, then QEMU should also be fine
> > to make it undefined.
> > 
> > Only one (IMHO, very slight..) concern is, if such "undefined behavior"
> > operation may crash QEMU rather than causing a sigbus like what normally
> > would happen on a bare metal.
> 
> bus errors are uncommon on bare metal. they aren't usually
> handled all that well.

Ah, not something I was expecting to happen regularly.

In this case, the whole concern is about a possible malicious guest that
might have installed a VFIO assigned device MMIO region (which may be
register based; RAM-based is non-issue) to be a DMA target of anything.

> 
> >  I'll put that discussion at last since I
> > don't know if it's that important.
> > 
> > So taking that e1000 bug into account,
> 
> Won't the patch I sent resolve e1000 too?

If you mean:

https://lore.kernel.org/r/20260611093049-mutt-send-email-mst@kernel.org

Roughly, yes. But it is only to show the idea, not really a real patch?

I think we need to cover all the rest details (I mentioned all these in my
previous reply too below):

- we should better leave memcpy()/memmove() as before for non-ram-device,
  only do that for ram-devices

- per PeterM's comment, __builtin_memmove() may still have unwanted side
  effects (I agree, it looks broken before and maybe we were lucky?)  need
  to switch to atomics?

- two spots missing per my previous email here:

  https://lore.kernel.org/all/aimEl9QQ_LTRPLtd@x1.local/

  IIUC we should also fix these two, or is it intended to be left?

  address_space_read()
  address_space_write_rom()

> 
> > looks like we have more of such user
> > that wants explicit control over the memory operations, likely with
> > attibutes:
> > 
> > - Aligned only
> > 
> > - No vectored inst
> > 
> > - No possible duplication (perhaps it means, only use atomic access??? per
> >   PeterM's explanation in another email)
> > 
> > I wonder if we should do this by default to all IOs, I think it might have
> > an unwanted impact on general perf.  One idea is we can introduce a new bit
> > in MemTxAttrs: say, mmio_strict, which will follow above stricter rule of
> > doing IO.
> > 
> > Then for ram_device, when doing memory access we should also use the same
> > set, hence something like:
> > 
> >   if (memory_access_is_direct(mr, ...)) {
> >     if (MemTxAttrs.mmio_strict || memory_region_is_ram_device(mr)) {
> >         memmove_strict_mmio(); // or memmove_no_vector(), or ...
> >     }
> >   }
> > 
> > I also want to bring us to the same page on differenciating two things:
> > 
> > - about direct access definition: so far, I want to define this almost as
> >   "it is directly accessible from host virtual address space".  It means
> >   ram_device definitely falls into this category, so it's a sub-category
> >   only but enforces strict mmio as above
> > 
> > - bounce buffer: I want to make sure we're on the same page this is
> >   something totally solving different problem of what we're looking at for
> >   ram_device.  Essentially this is only needed if mem is not "direct
> >   access".  Otherwise we shouldn't need it (including ram_device).
> 
> 
> I think ram_device_direct_access is a hack that should go away.
> It's a work around for a memory core bug that we should just fix.

I didn't find ram_device_direct_access, if you meant ram_device_mem_ops, I
agree it'll be nice if we can avoid it.

> 
> 
> 
> > I'm not sure if above sounds reasonable.  The hope is with that we should
> > fix both this GPU and e1000 issues (e1000, and maybe other places, needs to
> > start passing MemTxAttrs.mmio_strict, though, if we want to keep the
> > default to be still fast-path to use memcpy()/memmove()?).
> > 
> > Thanks,
> > 
> > =========================
> > 
> > Two cases here on the concern:
> > 
> > (1) if fully emulated device, non-issue afaiu because whatever DMA does
> > (with vectored ops) will only apply to QEMU process (like a bounce
> > buffer..) so it won't crash,
> > 
> > (2) if it's a VFIO device (not the GPU case, but when like realtek and some
> > guest driver registers it as a DMA target), logically the guest should
> > receive a bus error, but for QEMU's case it may crash QEMU with SIGBUS:
> 
> what and why would crash qemu?

If what Alex described issue happened in commit 4a2e242bbb ("memory: Don't
use memcpy for ram_device regions"), IIUC it will crash qemu, but maybe I
was wrong.  Alex knows the best.

So in general, we don't want malicious guest to be able to DoS the host
process (hence, to me "niche security use case"..).

Thanks,

> 
> > sigbus_handler() doesn't process anything except memory failures so far, it
> > seems.  The right thing might be that we forward this sigbus to guest, but
> > I didn't check further.
> > 
> > But I don't know if it would really happen, better verify it, and even if
> > it will happen I still think it's a very niche security use case to cover
> > so far.  Doesn't seem to be a blocker to fix a real perf problem first with
> > RAM-like GPU devices.
> > 
> > -- 
> > Peter Xu
> 

-- 
Peter Xu


