Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E430CD8C9D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 18:21:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXk1d-0006Y6-58; Thu, 11 Jun 2026 14:21:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wXk1Z-0006XC-3F
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 14:21:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wXk1V-0003Ct-0Z
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 14:21:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781202059;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0WLt1Fk1RQDczmAZOq2+lKfmteOOCS1rLgGIB4ASalI=;
 b=NG137qGoeV8vfEvYJ0ywSxHa4qs+xrbKgodjKGdQ9L+PIf+OOxJe+caajMoxB2Zvgtvnix
 QaxMgZB8gPxt5Q27nDlJMlB0vbu9/QmbE/cCClYzwasEl1GdLl+kgvJk/li3d1tmWTAm6H
 7p6QwGayTKed4WeoNLRvbg3hA7soxso=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-36-U0aaBcstNkmJMk6k4w6yAw-1; Thu, 11 Jun 2026 14:20:58 -0400
X-MC-Unique: U0aaBcstNkmJMk6k4w6yAw-1
X-Mimecast-MFC-AGG-ID: U0aaBcstNkmJMk6k4w6yAw_1781202057
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-5177b8df670so1345211cf.2
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 11:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781202057; x=1781806857; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0WLt1Fk1RQDczmAZOq2+lKfmteOOCS1rLgGIB4ASalI=;
 b=VTsdVy6HfXhiDMX/J+GkfX2/6kADhKDrXz3L9j4e4zhNZjpeVDFtC82TaZru/vTgx3
 s7PFRpCFqKfqWjXkH57SBED1PsNJWnEAZ1Ppx4+GTRMLX0ATRmZCCFDG+rTjRbvPewlu
 juJV6B3wpCVEe9BYkVFqWtkz60Z0bZUlptlotm81WY1BdXxmZMb1gKtDp5bSQozmBL+q
 P91IcBHPmI446yIPUW5hEWnIkFTnlaN/cGb8X/zZZB1/g8FAcyRJNW0xpBsuycMifmov
 836xoP851SPd3mfKrXsB/CDAGiv844D6Icg+TWMi4DyZzCwdm5zrV4XlRdW3csengIFd
 h/Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781202057; x=1781806857;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0WLt1Fk1RQDczmAZOq2+lKfmteOOCS1rLgGIB4ASalI=;
 b=C4I4u3DAS1l/j4YspxRRtNtsL4wfpLtAJKPaj/6JPOdHJp0NHmR5Oy5P9Of2dw0UXu
 +PwF8+mjRW3tJCNN44x6CPee7ckBrmzS5nlBRaDEbOg9q/qFfvnHwlinlsrc2BNAX5LP
 2k73dQ/ld8DGEdioVdGJjWcaGbHGEOXAeo1S7X2W8YtTiINpDZt/uK+3OjTIlHvVQk6Y
 DFiReT8FpSggw/J+d/EawlHHfJPYw+RYUcCoTO3HB+JSDy2eFcwlzca/3RihstDDT/mf
 qTjNVj1SZMe9lEDf8Ql+vQDjw/j6g/6rDjMJH2S7vZ89byRxKqm6A07X3sPCoX3CiVYA
 9YmQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8zSbVHGyZWemU/nRVImPAovgz3oIC7g78i2yI6yzLR8FHAbYnXfUOpBLJS0y2+WdgweQvCn9sxMOG4@nongnu.org
X-Gm-Message-State: AOJu0YwmlXG7D11fdqwlYf5/lfZ7hZbN4+tQ0W6gE2yXcaqGZvJmgJnT
 fsrQ1M+iTwsW2wdAH6RcMYxte6aWrqzt1nOfbD2VTmOqNSVOhH3YTzwfzwEdcMV5llfRJim3r20
 lAOivZ7f+pALsAytiakKAzV9kuj0IjiKeeQa/lb0JvXKE9V4Sy/xnB5cu
X-Gm-Gg: Acq92OHR5XbkOAB+QxlJlkrDxiN1FIGIt2UYTbyIGHAREk5DTg7XJmJYwQccAPH0fZ4
 4LT4bkaucKkAFGnGk6P/5lBpvrWwsAFvkOSTL3sJUxb9jcbU6Kl7hLUPao/ZyAy6fPCi2k+4D5r
 jHleSbbeov2TyeOtE90+Z2sn6O4W/6McoJFz22O7+mhgnwhtakE3yug7iDFkND4VmrpA7HzCVZh
 yIic0EDJ4QouZe8VP2XCFMszwmcw7LcshlU7m1YapFsnoJt1P54kC2ARFszElUFKPCHrQjtpPWz
 uBUQ5gm8reJ5fVK29MNWVDdt/bSC3xWt2YcsfsXY856q26YSSHLukGUj55BmT8I2AI5LodZl+6U
 WknoOquHDbwu+HyY=
X-Received: by 2002:ac8:7d52:0:b0:516:eaf9:f6f1 with SMTP id
 d75a77b69052e-517edd2fb18mr59854961cf.13.1781202057239; 
 Thu, 11 Jun 2026 11:20:57 -0700 (PDT)
X-Received: by 2002:ac8:7d52:0:b0:516:eaf9:f6f1 with SMTP id
 d75a77b69052e-517edd2fb18mr59854421cf.13.1781202056591; 
 Thu, 11 Jun 2026 11:20:56 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8d302114676sm785016d6.20.2026.06.11.11.20.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 11:20:56 -0700 (PDT)
Date: Thu, 11 Jun 2026 14:20:54 -0400
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
Message-ID: <air8hrlhrkaoJ4wi@x1.local>
References: <CAFEAcA8Q9qEaZS8wCpZQ-4jpAnQ9JXvnb7iSeRTdhJ9Y3BcCRg@mail.gmail.com>
 <20260611093049-mutt-send-email-mst@kernel.org>
 <CAFEAcA-8Hv0o3PibjH=8jixsHyunH2HkOAMQVqHkGr34b1Ascg@mail.gmail.com>
 <20260611110156-mutt-send-email-mst@kernel.org>
 <CAFEAcA_2oZepwCoPS+cMgdnrSTj=mCGzdFZf5gGRHJK13yqaKQ@mail.gmail.com>
 <20260611114811-mutt-send-email-mst@kernel.org>
 <CAFEAcA9HUGfDgHjvCemPPNkp6FfvQp+4y7qCnw+ROFpG3+ybMw@mail.gmail.com>
 <20260611123952-mutt-send-email-mst@kernel.org>
 <CAFEAcA8vOMd64cCkfCyc1wNbjEY+bnhFPce-V_WbAuXrUnP8cw@mail.gmail.com>
 <20260611130037-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260611130037-mutt-send-email-mst@kernel.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

On Thu, Jun 11, 2026 at 01:02:34PM -0400, Michael S. Tsirkin wrote:
> On Thu, Jun 11, 2026 at 05:53:54PM +0100, Peter Maydell wrote:
> > On Thu, 11 Jun 2026 at 17:42, Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Thu, Jun 11, 2026 at 05:16:09PM +0100, Peter Maydell wrote:
> > > > On Thu, 11 Jun 2026 at 16:57, Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > Then I'd like to see an example where we have an actual good reason
> > > > > to do execute arbitrary width accesses on device RAM when the
> > > > > driver does not execute them, please.
> > > >
> > > > That's the case we started with, with this GPU where the
> > > > virtio data structures are in this PCI BAR. We want the
> > > > virtio backend to have the freedom to say "I'm just going
> > > > to assume the ring buffer etc is in RAM, and I don't need to
> > > > care about carefully ensuring that I only do word accesses".
> > >
> > > virtio backend does not need to assume anything. any spec
> > > compliant guest guarantees it. any address given to
> > > a virtio device is ram.
> > 
> > OK, but how do we tell if the mmap() PCI BAR we have is RAM
> > or not ? Some of them are, some of them aren't...
> > 
> > -- PMM
> 
> We don't care? If guest asked a virtio device to access
> memory then that memory better support accesses guest
> requested, and on virtio that means any width.

Yes that's also my understanding that QEMU shouldn't care, if on bare metal
if it is a grey area with undefined behavior, then QEMU should also be fine
to make it undefined.

Only one (IMHO, very slight..) concern is, if such "undefined behavior"
operation may crash QEMU rather than causing a sigbus like what normally
would happen on a bare metal.  I'll put that discussion at last since I
don't know if it's that important.

So taking that e1000 bug into account, looks like we have more of such user
that wants explicit control over the memory operations, likely with
attibutes:

- Aligned only

- No vectored inst

- No possible duplication (perhaps it means, only use atomic access??? per
  PeterM's explanation in another email)

I wonder if we should do this by default to all IOs, I think it might have
an unwanted impact on general perf.  One idea is we can introduce a new bit
in MemTxAttrs: say, mmio_strict, which will follow above stricter rule of
doing IO.

Then for ram_device, when doing memory access we should also use the same
set, hence something like:

  if (memory_access_is_direct(mr, ...)) {
    if (MemTxAttrs.mmio_strict || memory_region_is_ram_device(mr)) {
        memmove_strict_mmio(); // or memmove_no_vector(), or ...
    }
  }

I also want to bring us to the same page on differenciating two things:

- about direct access definition: so far, I want to define this almost as
  "it is directly accessible from host virtual address space".  It means
  ram_device definitely falls into this category, so it's a sub-category
  only but enforces strict mmio as above

- bounce buffer: I want to make sure we're on the same page this is
  something totally solving different problem of what we're looking at for
  ram_device.  Essentially this is only needed if mem is not "direct
  access".  Otherwise we shouldn't need it (including ram_device).

I'm not sure if above sounds reasonable.  The hope is with that we should
fix both this GPU and e1000 issues (e1000, and maybe other places, needs to
start passing MemTxAttrs.mmio_strict, though, if we want to keep the
default to be still fast-path to use memcpy()/memmove()?).

Thanks,

=========================

Two cases here on the concern:

(1) if fully emulated device, non-issue afaiu because whatever DMA does
(with vectored ops) will only apply to QEMU process (like a bounce
buffer..) so it won't crash,

(2) if it's a VFIO device (not the GPU case, but when like realtek and some
guest driver registers it as a DMA target), logically the guest should
receive a bus error, but for QEMU's case it may crash QEMU with SIGBUS:
sigbus_handler() doesn't process anything except memory failures so far, it
seems.  The right thing might be that we forward this sigbus to guest, but
I didn't check further.

But I don't know if it would really happen, better verify it, and even if
it will happen I still think it's a very niche security use case to cover
so far.  Doesn't seem to be a blocker to fix a real perf problem first with
RAM-like GPU devices.

-- 
Peter Xu


