Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB972CD98DA
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 19:45:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wY7nu-0002hG-S5; Fri, 12 Jun 2026 15:44:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex@shazbot.org>)
 id 1wY7ns-0002gj-Vf; Fri, 12 Jun 2026 15:44:32 -0400
Received: from fout-a8-smtp.messagingengine.com ([103.168.172.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex@shazbot.org>)
 id 1wY7np-0004TD-Ix; Fri, 12 Jun 2026 15:44:31 -0400
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
 by mailfout.phl.internal (Postfix) with ESMTP id A2813EC01DC;
 Fri, 12 Jun 2026 15:44:26 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-09.internal (MEProxy); Fri, 12 Jun 2026 15:44:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1781293466;
 x=1781379866; bh=HuXYP+Aj3laQcHpMTers+ERgOBjBPCFBB/8Noddz7ZM=; b=
 MPZDzgi7FcDRroNjkUGXdb1thYcuMLqkL4oPWR4LO1/FEkzkR6SsRYP0k1Ns3gzn
 BKcJQAr+fiW2iW1c0tBFLaoeHI0k5J1ZATNPTQRKEtr+zKEWB6HaDz/q9+J+XFFX
 xCSNERazrqI/GQaahG3Hrpfshm+AYsU5ea1g3IjhWucyq7SW2m/trQQhoB2beO+G
 wk8o/odnK5m8rVLM+oOrPo6/fGBad9WAszQfKzhlAis+48L/SBJGaProqFMzGjRZ
 qcOZchKJlb9RbNz0OOqWh1oBfuJhEIVl9eq1XrEewVhCUknmzNOD703rQiCmrB95
 1W0fUP2VFYEpM6w/92h50w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781293466; x=
 1781379866; bh=HuXYP+Aj3laQcHpMTers+ERgOBjBPCFBB/8Noddz7ZM=; b=T
 6WRknST308l4yYHe7ssjOhGpMFkZGwPk8wBs6ASEV/iGVkKKF0YmsNHHnt9QJ/Vs
 WbT9kLTi7/v47JTvHss5m8vJAH3BZpAYZEdk5v8PBLbIAMlGOexbW4bXHozVYRQm
 yo6KjDjV/2hZFBMSeclBby+0C4dfRH3vPc9qb9ujuXU4NHNw4sM+cBhH2kABwPpl
 Rukg7iUSBizPCc+a0VNw1GRSfn5j3tbAyAb1MCdB7qItq1mofKTUMu+AiZLKj+wm
 ZOfyP88CES+yXMqn64jCBmI2mYQnAdcJh3LpBzmqoQVrwSsh7ANusiwN6wLQVY3N
 N1ky6kdzmwi+BkhmOawpw==
X-ME-Sender: <xms:mmEsagYyp_8AHS6qce7UY5D2YHsolMnuyZNu6K216JRcG6s2eWZLLA>
 <xme:mmEsanSDjllOxbW40OVXvum6RdAftIaP_hQpPhgXLdG3cJSNQ4GAHK4I2ky01QCqb
 oFnBfao0WjqBKxQIHwL1eKNR5t_6h8wbHvoWPS_FShbZAluMXiyEQ>
X-ME-Received: <xmr:mmEsan9Lg8Lw2j4o5Z5Vl4yQQykiD39m6ur6U5ljpPB3Fypz_mHBjUFIwsI>
X-ME-Proxy-Cause: dmFkZTF2u0RqDkegq/YU7MpUcVqqmaiI5X1YON9MTXR4DJ80XiijTlz03NdkMNOyCpD2qA
 Vo8DbVTg5bZ4JqIRdqKq6KA4Cmk+TK6lOJDSIPC7cJJ9A869Dv6KZS3KTiHulqLC8JOihu
 PSxCiUtmhAqBEBtgNJOXZFxgHUaoSAQGBEcF5UiKyGwfDZ81o6/TGra03pUDQFRKMsbm29
 hnbte6ukIMuKjmO1WHa0B3Ad9KeTWiiihI9DK2EhdXS9RRPCuq2JB7bzmbsrW19zum1f3p
 2RJMdh1QFMifm5L+mINyFtZtxYDKv0YARDUg7/lChMc2Kz29mfAoszK4m5uZhlmzJ8ErWZ
 u7mOm97zwgVVXaYQKcjxAT1TS8BOZNinvVnWFb/ReW267FsfcnoSoAfSyZFx3NnVFLLk0t
 XUErkKOgdB5LejvYhF3ztcfMPCNGPNyZ7jy3U0dwNPTOkNMj6arElj2Blae0p24C4QMpP1
 +jLanUxpzLxLsyqHUASEE87oVHUHDuIqV4PasfGqqhIgex/3Knvkp4gOejVvZe8SmEB1Kw
 rhBSyTB4qNvJ+oCIPmf+S0uNqzH+nFMVANV/sN89MExVM4n7G+vyMVR+u83X1WMcWw+EYi
 SZDbcYNvejGxx45ls4/dZdK15Fdp9mM2vDn0DpPHficmdJxaxgMeFsBiXgRg
X-ME-Proxy: <xmx:mmEsavipAEBJabm57vV3GFofPVWmI57J3SZoqn--fJMIw5ryjtmdFw>
 <xmx:mmEsagZo7mFZKk5CDDWIJMCxTHnWXb0doRoiG6pawp95LECYaDWJ1A>
 <xmx:mmEsas_rLTBJ97KtJHEJUMtswIAff3nqCNQwIa6Wox3WOGBEJhuyIg>
 <xmx:mmEsaqP3x_AHe1GQeUUXDUtare8xkF9yogCih4xjVgmF_J2W3v9sIw>
 <xmx:mmEsaod8_twuJ8F3YfDToQqGOkFHWzb7Wk1E19IrbFWwd9LBkZG-TdSf>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Jun 2026 15:44:25 -0400 (EDT)
Date: Fri, 12 Jun 2026 13:44:23 -0600
From: Alex Williamson <alex@shazbot.org>
To: Peter Xu <peterx@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Gavin Shan <gshan@redhat.com>, Pavel Hrdina
 <phrdina@redhat.com>, "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?="
 <berrange@redhat.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 jugraham@redhat.com, shan.gavin@gmail.com, David Hildenbrand
 <david@kernel.org>, alex@shazbot.org
Subject: Re: [PATCH RFCv1] virtio: Inherit max bounce buffer size from bus
 parent if possible
Message-ID: <20260612134423.648c335a@shazbot.org>
In-Reply-To: <aismn4D1wXI6tipv@x1.local>
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
 <aismn4D1wXI6tipv@x1.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=103.168.172.151; envelope-from=alex@shazbot.org;
 helo=fout-a8-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, 11 Jun 2026 17:20:31 -0400
Peter Xu <peterx@redhat.com> wrote:

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
> 
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

Trying to figure out where to jump into this thread.  4a2e242bbb was
required because memcpy will be optimized to use instructions that
shouldn't target MMIO.  IIRC, in the case of the RTL NIC we were
getting SSE instructions to MMIO.  At the time, we weren't thinking
about P2P DMA, the virtualized access was a result of the quirks for
RTL causing the trap into QEMU rather than directly accessing through
the mmap.  Performance and bulk transfers were not a priority.

Alignment was really not a consideration.  The commit log even refers
to unaligned accesses.  It was just a matter of chunking to the maximum
width available for the size.

If a more optimized path is now necessary, I'd just recommend not using
something like memcpy or memmove, make sure it's restricted to
operations that are valid for MMIO address spaces.  Bouncing through
QEMU should not introduce RAM-specific memory optimizations.  Thanks,

Alex

