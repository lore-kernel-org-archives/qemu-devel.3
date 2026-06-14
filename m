Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 407BCCD98C5
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 16:10:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYnPg-0005wl-Ag; Sun, 14 Jun 2026 12:10:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYnPd-0005vj-Kc
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 12:10:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYnPb-0002Fz-61
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 12:10:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781453413;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7fBkYk2d3OSFSJGDjlk5dFGGvPl09b4wUdi2Ocv59BI=;
 b=SU8aI9TPTWgdRnv4szOiPzNgOsubDah9toueZ8yYi5m/5YzqOy5/jBcvUTRi95lw8fS4rW
 HRMAHX23PY8KpJpUeW9meWBSFQb6sh8QU/jIMP7O/08sXAWdEfXu0OePZ5qN7nYzOZePsA
 x7SLZiejXErTEYWkgzATAFcLq4Ca6xc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-VZWsVQODONifqdozSrEwnw-1; Sun, 14 Jun 2026 12:10:12 -0400
X-MC-Unique: VZWsVQODONifqdozSrEwnw-1
X-Mimecast-MFC-AGG-ID: VZWsVQODONifqdozSrEwnw_1781453411
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-45eef10d5ebso1320721f8f.0
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 09:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781453411; x=1782058211; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=7fBkYk2d3OSFSJGDjlk5dFGGvPl09b4wUdi2Ocv59BI=;
 b=m7pH6YZ/mujEkqmclasd7ANbd3BbQdWw9/tSNUJvEIfOJJsdb88KGRfW+lBsiw3Aaq
 5WalA0CsEaElHnosGwSGzwoPQ48hTUHPjgOdjlod8tdlDtcM5RhKDzPI61r2RsmGbrb2
 JB6c8UvMJJ0ym7Wq9ov+bgWYR/VYtdhKDG2hvFMhqKtAYNHhWcW6ZOgsGwz05WuQZBV0
 qEL9aqNVnwwqX2rvL9qgG3r3DHOlAcinF2WsXDWXOutDwUBefesLURISVTivysust84G
 Wu+YahoWWLlBV008CHu8av3swvl5fWc/By7DdAt/7PY8+SuiSsMo2YODlEYlD3ayke8H
 5EQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781453411; x=1782058211;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7fBkYk2d3OSFSJGDjlk5dFGGvPl09b4wUdi2Ocv59BI=;
 b=ljGD1ZgmOuhTwXU7mJpX+6keyjQJUkf8t2pBJI5uendK/+f+WclmKp9HduuUJRuQXM
 0CzjAF10yRlGdpDs6nLsXpG8rTnxvv/9cJQYcSObE7mF6OTpwoPDp+3Bx0a1EWPN0rz+
 5RBplb7FEpt41/3i1UP5MCT6cu/c/ggoEaM/Xm0t+MG1NY+Qd1UEAQwOh4M/i945IvTl
 NfeoFkvGichsN9hcAXLN+a13FAaJjTVWjSOzTtVj1TYMNVStE5Br+UOLLaf4powx6wfD
 qlSAgdk+YW2zbxC2ErcB6cGiuXNFEPp0aebFukr6GyGkbnBo/NMwODkSdOWLm39Bvlzd
 MPAw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/zCR8fFRAnRFfqkVUw+YT9MjEanBYGMAxmT932JTJl6B4Ra6qagg28keNjA+/YL+qujmLWJAIu5PdS@nongnu.org
X-Gm-Message-State: AOJu0YxoVCEqpH5pjwJYXxlaC9WTDCsiKUmVJM+DZ4HL9MghzI+51oKe
 wONoyjGl6EAazxx3n9LErDy7tsQRJyCsQB8sXnT86bPE91K5OEgZ/iJnIbx1sILUPTVKjJDAW7v
 XUBCb6jZTE5qt5IJu5JG24dIa1xy6TAwkJacWjkPNAHpfwazUDKFQbnmX
X-Gm-Gg: Acq92OEP+MQHaSLtT5XyhJRUh5JWnhtCVwcNeZoyyYYDM9vbAfcJuGSQdKKifYeXS4C
 1/5EA5bUAXpR4XRDvyj3Ni82geC95/jQys3nHBBJZ8NiRfiXSkPK5mVbAuqKtsnU/1NahremDT6
 7kA+TZQfJw+8vGpsrVaQ+dsxmmGCWINdAcjEsiJZlf9zWmdEeGm9xjdVzrWtshm2fO3M3EjXu23
 nryOdrTHAD/65ngCDMxFpDeU6NEwT2SL2m72abjrvyZopK6WqDeA5Amge4F/EffnfZRzyXzdMLo
 dXSI3VK5CjVqHk8Xf9SPYuWG1NEu1tx46ap3vrulob76AMYXbGvAL0YUqdL9OcfRDvbL74XWieM
 vbcup3iF/OSnJShFI5uiksNi3i9AEFLVaJRtkAFptE7w=
X-Received: by 2002:a05:6000:258a:b0:460:6596:e238 with SMTP id
 ffacd0b85a97d-460769303d3mr8329584f8f.23.1781453410639; 
 Sun, 14 Jun 2026 09:10:10 -0700 (PDT)
X-Received: by 2002:a05:6000:258a:b0:460:6596:e238 with SMTP id
 ffacd0b85a97d-460769303d3mr8329540f8f.23.1781453410036; 
 Sun, 14 Jun 2026 09:10:10 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2c5266sm28775391f8f.29.2026.06.14.09.10.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 09:10:09 -0700 (PDT)
Date: Sun, 14 Jun 2026 12:10:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alex Williamson <alex@shazbot.org>
Cc: Peter Xu <peterx@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Gavin Shan <gshan@redhat.com>, Pavel Hrdina <phrdina@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, jugraham@redhat.com,
 shan.gavin@gmail.com, David Hildenbrand <david@kernel.org>
Subject: Re: [PATCH RFCv1] virtio: Inherit max bounce buffer size from bus
 parent if possible
Message-ID: <20260614120757-mutt-send-email-mst@kernel.org>
References: <CAFEAcA_2oZepwCoPS+cMgdnrSTj=mCGzdFZf5gGRHJK13yqaKQ@mail.gmail.com>
 <20260611114811-mutt-send-email-mst@kernel.org>
 <CAFEAcA9HUGfDgHjvCemPPNkp6FfvQp+4y7qCnw+ROFpG3+ybMw@mail.gmail.com>
 <20260611123952-mutt-send-email-mst@kernel.org>
 <CAFEAcA8vOMd64cCkfCyc1wNbjEY+bnhFPce-V_WbAuXrUnP8cw@mail.gmail.com>
 <20260611130037-mutt-send-email-mst@kernel.org>
 <air8hrlhrkaoJ4wi@x1.local>
 <20260611164624-mutt-send-email-mst@kernel.org>
 <aismn4D1wXI6tipv@x1.local> <20260612134423.648c335a@shazbot.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260612134423.648c335a@shazbot.org>
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

On Fri, Jun 12, 2026 at 01:44:23PM -0600, Alex Williamson wrote:
> On Thu, 11 Jun 2026 17:20:31 -0400
> Peter Xu <peterx@redhat.com> wrote:
> 
> > On Thu, Jun 11, 2026 at 04:52:20PM -0400, Michael S. Tsirkin wrote:
> > > On Thu, Jun 11, 2026 at 02:20:54PM -0400, Peter Xu wrote:  
> > > > On Thu, Jun 11, 2026 at 01:02:34PM -0400, Michael S. Tsirkin wrote:  
> > > > > On Thu, Jun 11, 2026 at 05:53:54PM +0100, Peter Maydell wrote:  
> > > > > > On Thu, 11 Jun 2026 at 17:42, Michael S. Tsirkin <mst@redhat.com> wrote:  
> > > > > > >
> > > > > > > On Thu, Jun 11, 2026 at 05:16:09PM +0100, Peter Maydell wrote:  
> > > > > > > > On Thu, 11 Jun 2026 at 16:57, Michael S. Tsirkin <mst@redhat.com> wrote:  
> > > > > > > > > Then I'd like to see an example where we have an actual good reason
> > > > > > > > > to do execute arbitrary width accesses on device RAM when the
> > > > > > > > > driver does not execute them, please.  
> > > > > > > >
> > > > > > > > That's the case we started with, with this GPU where the
> > > > > > > > virtio data structures are in this PCI BAR. We want the
> > > > > > > > virtio backend to have the freedom to say "I'm just going
> > > > > > > > to assume the ring buffer etc is in RAM, and I don't need to
> > > > > > > > care about carefully ensuring that I only do word accesses".  
> > > > > > >
> > > > > > > virtio backend does not need to assume anything. any spec
> > > > > > > compliant guest guarantees it. any address given to
> > > > > > > a virtio device is ram.  
> > > > > > 
> > > > > > OK, but how do we tell if the mmap() PCI BAR we have is RAM
> > > > > > or not ? Some of them are, some of them aren't...
> > > > > > 
> > > > > > -- PMM  
> > > > > 
> > > > > We don't care? If guest asked a virtio device to access
> > > > > memory then that memory better support accesses guest
> > > > > requested, and on virtio that means any width.  
> > > > 
> > > > Yes that's also my understanding that QEMU shouldn't care, if on bare metal
> > > > if it is a grey area with undefined behavior, then QEMU should also be fine
> > > > to make it undefined.
> > > > 
> > > > Only one (IMHO, very slight..) concern is, if such "undefined behavior"
> > > > operation may crash QEMU rather than causing a sigbus like what normally
> > > > would happen on a bare metal.  
> > > 
> > > bus errors are uncommon on bare metal. they aren't usually
> > > handled all that well.  
> > 
> > Ah, not something I was expecting to happen regularly.
> > 
> > In this case, the whole concern is about a possible malicious guest that
> > might have installed a VFIO assigned device MMIO region (which may be
> > register based; RAM-based is non-issue) to be a DMA target of anything.
> > 
> > >   
> > > >  I'll put that discussion at last since I
> > > > don't know if it's that important.
> > > > 
> > > > So taking that e1000 bug into account,  
> > > 
> > > Won't the patch I sent resolve e1000 too?  
> > 
> > If you mean:
> > 
> > https://lore.kernel.org/r/20260611093049-mutt-send-email-mst@kernel.org
> > 
> > Roughly, yes. But it is only to show the idea, not really a real patch?
> > 
> > I think we need to cover all the rest details (I mentioned all these in my
> > previous reply too below):
> > 
> > - we should better leave memcpy()/memmove() as before for non-ram-device,
> >   only do that for ram-devices
> > 
> > - per PeterM's comment, __builtin_memmove() may still have unwanted side
> >   effects (I agree, it looks broken before and maybe we were lucky?)  need
> >   to switch to atomics?
> > 
> > - two spots missing per my previous email here:
> > 
> >   https://lore.kernel.org/all/aimEl9QQ_LTRPLtd@x1.local/
> > 
> >   IIUC we should also fix these two, or is it intended to be left?
> > 
> >   address_space_read()
> >   address_space_write_rom()
> > 
> > >   
> > > > looks like we have more of such user
> > > > that wants explicit control over the memory operations, likely with
> > > > attibutes:
> > > > 
> > > > - Aligned only
> > > > 
> > > > - No vectored inst
> > > > 
> > > > - No possible duplication (perhaps it means, only use atomic access??? per
> > > >   PeterM's explanation in another email)
> > > > 
> > > > I wonder if we should do this by default to all IOs, I think it might have
> > > > an unwanted impact on general perf.  One idea is we can introduce a new bit
> > > > in MemTxAttrs: say, mmio_strict, which will follow above stricter rule of
> > > > doing IO.
> > > > 
> > > > Then for ram_device, when doing memory access we should also use the same
> > > > set, hence something like:
> > > > 
> > > >   if (memory_access_is_direct(mr, ...)) {
> > > >     if (MemTxAttrs.mmio_strict || memory_region_is_ram_device(mr)) {
> > > >         memmove_strict_mmio(); // or memmove_no_vector(), or ...
> > > >     }
> > > >   }
> > > > 
> > > > I also want to bring us to the same page on differenciating two things:
> > > > 
> > > > - about direct access definition: so far, I want to define this almost as
> > > >   "it is directly accessible from host virtual address space".  It means
> > > >   ram_device definitely falls into this category, so it's a sub-category
> > > >   only but enforces strict mmio as above
> > > > 
> > > > - bounce buffer: I want to make sure we're on the same page this is
> > > >   something totally solving different problem of what we're looking at for
> > > >   ram_device.  Essentially this is only needed if mem is not "direct
> > > >   access".  Otherwise we shouldn't need it (including ram_device).  
> > > 
> > > 
> > > I think ram_device_direct_access is a hack that should go away.
> > > It's a work around for a memory core bug that we should just fix.  
> > 
> > I didn't find ram_device_direct_access, if you meant ram_device_mem_ops, I
> > agree it'll be nice if we can avoid it.
> > 
> > > 
> > > 
> > >   
> > > > I'm not sure if above sounds reasonable.  The hope is with that we should
> > > > fix both this GPU and e1000 issues (e1000, and maybe other places, needs to
> > > > start passing MemTxAttrs.mmio_strict, though, if we want to keep the
> > > > default to be still fast-path to use memcpy()/memmove()?).
> > > > 
> > > > Thanks,
> > > > 
> > > > =========================
> > > > 
> > > > Two cases here on the concern:
> > > > 
> > > > (1) if fully emulated device, non-issue afaiu because whatever DMA does
> > > > (with vectored ops) will only apply to QEMU process (like a bounce
> > > > buffer..) so it won't crash,
> > > > 
> > > > (2) if it's a VFIO device (not the GPU case, but when like realtek and some
> > > > guest driver registers it as a DMA target), logically the guest should
> > > > receive a bus error, but for QEMU's case it may crash QEMU with SIGBUS:  
> > > 
> > > what and why would crash qemu?  
> > 
> > If what Alex described issue happened in commit 4a2e242bbb ("memory: Don't
> > use memcpy for ram_device regions"), IIUC it will crash qemu, but maybe I
> > was wrong.  Alex knows the best.
> > 
> > So in general, we don't want malicious guest to be able to DoS the host
> > process (hence, to me "niche security use case"..).
> 
> Trying to figure out where to jump into this thread.  4a2e242bbb was
> required because memcpy will be optimized to use instructions that
> shouldn't target MMIO.


It only does it when the length is not known though.
If you do a memcpy with a fixed length it just emits
move.


>  IIRC, in the case of the RTL NIC we were
> getting SSE instructions to MMIO.  At the time, we weren't thinking
> about P2P DMA, the virtualized access was a result of the quirks for
> RTL causing the trap into QEMU rather than directly accessing through
> the mmap.  Performance and bulk transfers were not a priority.
> 
> Alignment was really not a consideration.  The commit log even refers
> to unaligned accesses.  It was just a matter of chunking to the maximum
> width available for the size.
> 
> If a more optimized path is now necessary, I'd just recommend not using
> something like memcpy or memmove, make sure it's restricted to
> operations that are valid for MMIO address spaces.  Bouncing through
> QEMU should not introduce RAM-specific memory optimizations.  Thanks,
> 
> Alex

-- 
MST


