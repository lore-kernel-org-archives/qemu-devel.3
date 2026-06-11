Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F8BECD98C7
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 20:53:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXmO8-0003hi-G4; Thu, 11 Jun 2026 16:52:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wXmO7-0003ha-EE
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 16:52:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wXmO4-0001lz-Cb
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 16:52:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781211146;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=C0vhcoTFIC+ddov7CaJ6rewHgDFN6M5JFyVBN+p38zg=;
 b=UYMAlOF7v+yGP0m5OVTkxAa0RMbxknIWVaLhDEK2x5z9MeHhsDSWrt44nMl6gju8fOXfLQ
 ZjB0TrMG89RZ5Bb7PNPA9T/lYYZlp8y0Xg3JEOXDJKknWi5l0aWHnWiSHZk8PK1wRsQRNO
 UoVqCCMI53X/p6RWkle5oFDHi25KxmM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-9pDAfWl5OtG6wpWRjbpwiA-1; Thu, 11 Jun 2026 16:52:25 -0400
X-MC-Unique: 9pDAfWl5OtG6wpWRjbpwiA-1
X-Mimecast-MFC-AGG-ID: 9pDAfWl5OtG6wpWRjbpwiA_1781211144
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-45eebc943bfso794531f8f.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 13:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781211144; x=1781815944; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=C0vhcoTFIC+ddov7CaJ6rewHgDFN6M5JFyVBN+p38zg=;
 b=ZqKxuPc3KX9ZcXvHRtyOGEsjZXKK+IiHf/jAettvTN1b3me1dj0IBUGWFXOAvL0D1W
 0tP7fj/iatBNItD6h4PWo3PX6upZiE+wstDF8HW1d7rsyTraApCqNUBVKqH4oBk1Y35T
 9SV4IRHQZ+d7i2H46Pn6KSwmYOIHyJRbP4T72Qd957wIPALK/mTJUILEnX9qLssoJOR7
 rkO2kjGL7r3Ar9ucZFBmhosjQrZ7wWmq5eSbCTIbwJ0CO8MaSZ0s4zCpk+IN8PM88eut
 h5eahwq63zoUs30KhETZ0xa1byeMUrF1r7pp2jphXDjluLpYN6Odjj8nv0O62gSTUfog
 SdaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781211144; x=1781815944;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C0vhcoTFIC+ddov7CaJ6rewHgDFN6M5JFyVBN+p38zg=;
 b=NL28bd3F6FYKi6sU46bxL5kbsiCjOBcTl9Hvn/GRbr5vvWG8ngY/N6gkkPurkpewAF
 kD5Ym4XEZLQozWdhxUvDZWCXRAIDiPtvOhjRLjtNNZNUxQUgibwu7S/Mhkcf6qyPsxov
 E7ZaCOpnvgBDycHDBA1WNvou8MQjCcGvJpOmH7AFoU5Dcq8vigVFCuxKyGey/GpBqzL8
 4fzqwJ0lIl28rCilFsRKes4skiL1J40FHFf/0WaR076fh60Ks2N1Ok5Mkaq4TZE2VLuk
 X73jqRFXZVrNouiJGdQdXOz9rYFYrsRX/8aJ+EuaM8pkg+qmwfhwVB/Zq1HDbdvtCCwZ
 e5Zw==
X-Forwarded-Encrypted: i=1;
 AFNElJ84iT6rRweQ5NJFd+BQAVGxF51HVoD+CKwSMEsUBV7PfG7E58V97eBjpO/DUs4RlnWa+rJ4tH/7G8j4@nongnu.org
X-Gm-Message-State: AOJu0YzwZX8hENRlaHAUHH1Hl0J1zz3gQk6C12iV5Qy9uAVRj0zNhLcv
 zAZd623ezQbbVbs6OE4oDU9o5b21szTU+jbXU1l3gW+rB41usm6Te4a1nE7deWUP8CMSg4tmzsn
 dnoULEB2wiOk0rUCMNvg6iezFfcZV6UpZ5W8XQt37Yz2LD0OWVqrQlSPl
X-Gm-Gg: Acq92OFUsr11zkSYT69IwZv43EepS+3UPR+rsx8McoLAQzoKHH9SwlUvyQfZL3qLpwe
 L8Ooy5F4FS9m2lb5zXLY1aPh+IGO0iowLwrp0eU0QRtcEBnA9ChB2nNtzacolOEJcNZOiZSoKDB
 Y4oEhsfRKgAuDk7ZHba66/JJVSIk9JxykAwbJkjr1pe9Z5lpTPugq14TW2gaGcbyTAcmRYlNY2J
 OU/82AcIYBRpalkNgxjKJQPVMJak5jthZXm5gkHQIMCPw0FeedPBOfigHh8z+hQ4YL2nNXsbDuk
 xUOcu3hhrtPj7oh3QmhPgapR8LRPdnT6BmX7BBfwIKk5b7NqjLOSrhLOPFAl9pPLyWaH10ax6oC
 JZCS9sN4NMYwyA9bUJfti92yro2+iKZa2cssj3CjFz+8=
X-Received: by 2002:a5d:5848:0:b0:460:1c93:6eb6 with SMTP id
 ffacd0b85a97d-4606d0239femr390978f8f.20.1781211144153; 
 Thu, 11 Jun 2026 13:52:24 -0700 (PDT)
X-Received: by 2002:a5d:5848:0:b0:460:1c93:6eb6 with SMTP id
 ffacd0b85a97d-4606d0239femr390955f8f.20.1781211143615; 
 Thu, 11 Jun 2026 13:52:23 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606c0fc493sm1745039f8f.25.2026.06.11.13.52.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 13:52:23 -0700 (PDT)
Date: Thu, 11 Jun 2026 16:52:20 -0400
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
Message-ID: <20260611164624-mutt-send-email-mst@kernel.org>
References: <20260611093049-mutt-send-email-mst@kernel.org>
 <CAFEAcA-8Hv0o3PibjH=8jixsHyunH2HkOAMQVqHkGr34b1Ascg@mail.gmail.com>
 <20260611110156-mutt-send-email-mst@kernel.org>
 <CAFEAcA_2oZepwCoPS+cMgdnrSTj=mCGzdFZf5gGRHJK13yqaKQ@mail.gmail.com>
 <20260611114811-mutt-send-email-mst@kernel.org>
 <CAFEAcA9HUGfDgHjvCemPPNkp6FfvQp+4y7qCnw+ROFpG3+ybMw@mail.gmail.com>
 <20260611123952-mutt-send-email-mst@kernel.org>
 <CAFEAcA8vOMd64cCkfCyc1wNbjEY+bnhFPce-V_WbAuXrUnP8cw@mail.gmail.com>
 <20260611130037-mutt-send-email-mst@kernel.org>
 <air8hrlhrkaoJ4wi@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <air8hrlhrkaoJ4wi@x1.local>
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

On Thu, Jun 11, 2026 at 02:20:54PM -0400, Peter Xu wrote:
> On Thu, Jun 11, 2026 at 01:02:34PM -0400, Michael S. Tsirkin wrote:
> > On Thu, Jun 11, 2026 at 05:53:54PM +0100, Peter Maydell wrote:
> > > On Thu, 11 Jun 2026 at 17:42, Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Thu, Jun 11, 2026 at 05:16:09PM +0100, Peter Maydell wrote:
> > > > > On Thu, 11 Jun 2026 at 16:57, Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > > Then I'd like to see an example where we have an actual good reason
> > > > > > to do execute arbitrary width accesses on device RAM when the
> > > > > > driver does not execute them, please.
> > > > >
> > > > > That's the case we started with, with this GPU where the
> > > > > virtio data structures are in this PCI BAR. We want the
> > > > > virtio backend to have the freedom to say "I'm just going
> > > > > to assume the ring buffer etc is in RAM, and I don't need to
> > > > > care about carefully ensuring that I only do word accesses".
> > > >
> > > > virtio backend does not need to assume anything. any spec
> > > > compliant guest guarantees it. any address given to
> > > > a virtio device is ram.
> > > 
> > > OK, but how do we tell if the mmap() PCI BAR we have is RAM
> > > or not ? Some of them are, some of them aren't...
> > > 
> > > -- PMM
> > 
> > We don't care? If guest asked a virtio device to access
> > memory then that memory better support accesses guest
> > requested, and on virtio that means any width.
> 
> Yes that's also my understanding that QEMU shouldn't care, if on bare metal
> if it is a grey area with undefined behavior, then QEMU should also be fine
> to make it undefined.
> 
> Only one (IMHO, very slight..) concern is, if such "undefined behavior"
> operation may crash QEMU rather than causing a sigbus like what normally
> would happen on a bare metal.

bus errors are uncommon on bare metal. they aren't usually
handled all that well.

>  I'll put that discussion at last since I
> don't know if it's that important.
> 
> So taking that e1000 bug into account,

Won't the patch I sent resolve e1000 too?

> looks like we have more of such user
> that wants explicit control over the memory operations, likely with
> attibutes:
> 
> - Aligned only
> 
> - No vectored inst
> 
> - No possible duplication (perhaps it means, only use atomic access??? per
>   PeterM's explanation in another email)
> 
> I wonder if we should do this by default to all IOs, I think it might have
> an unwanted impact on general perf.  One idea is we can introduce a new bit
> in MemTxAttrs: say, mmio_strict, which will follow above stricter rule of
> doing IO.
> 
> Then for ram_device, when doing memory access we should also use the same
> set, hence something like:
> 
>   if (memory_access_is_direct(mr, ...)) {
>     if (MemTxAttrs.mmio_strict || memory_region_is_ram_device(mr)) {
>         memmove_strict_mmio(); // or memmove_no_vector(), or ...
>     }
>   }
> 
> I also want to bring us to the same page on differenciating two things:
> 
> - about direct access definition: so far, I want to define this almost as
>   "it is directly accessible from host virtual address space".  It means
>   ram_device definitely falls into this category, so it's a sub-category
>   only but enforces strict mmio as above
> 
> - bounce buffer: I want to make sure we're on the same page this is
>   something totally solving different problem of what we're looking at for
>   ram_device.  Essentially this is only needed if mem is not "direct
>   access".  Otherwise we shouldn't need it (including ram_device).


I think ram_device_direct_access is a hack that should go away.
It's a work around for a memory core bug that we should just fix.



> I'm not sure if above sounds reasonable.  The hope is with that we should
> fix both this GPU and e1000 issues (e1000, and maybe other places, needs to
> start passing MemTxAttrs.mmio_strict, though, if we want to keep the
> default to be still fast-path to use memcpy()/memmove()?).
> 
> Thanks,
> 
> =========================
> 
> Two cases here on the concern:
> 
> (1) if fully emulated device, non-issue afaiu because whatever DMA does
> (with vectored ops) will only apply to QEMU process (like a bounce
> buffer..) so it won't crash,
> 
> (2) if it's a VFIO device (not the GPU case, but when like realtek and some
> guest driver registers it as a DMA target), logically the guest should
> receive a bus error, but for QEMU's case it may crash QEMU with SIGBUS:

what and why would crash qemu?

> sigbus_handler() doesn't process anything except memory failures so far, it
> seems.  The right thing might be that we forward this sigbus to guest, but
> I didn't check further.
> 
> But I don't know if it would really happen, better verify it, and even if
> it will happen I still think it's a very niche security use case to cover
> so far.  Doesn't seem to be a blocker to fix a real perf problem first with
> RAM-like GPU devices.
> 
> -- 
> Peter Xu


