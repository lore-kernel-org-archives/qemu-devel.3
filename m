Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00E84CD98CE
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 15:58:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXhmt-0002gC-4V; Thu, 11 Jun 2026 11:57:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wXhmr-0002fx-Qc
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 11:57:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wXhmp-0005TQ-Kw
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 11:57:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781193461;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0wEonq2dGt1fOHOCL85F50+fzjAb0sZKPZndRoL36SI=;
 b=AbFTfT5f4IqkyfROB8ikqvrULmRFrsqAYmwHLfj3qCKGa6MB9FNaf2sp/YyRa0kURWWZBs
 sSErMyu/1CM0OVda036c9sHnd/Yr2Q9xrT1KkxBkqUAEtO9dEuY87QcWhONBNGtQc77+GM
 K6SYRbSjxAcnWGMFBCjxTcMgvd5orI0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-287-lvwzdyWHOCmUtfAEYkCb9g-1; Thu, 11 Jun 2026 11:57:40 -0400
X-MC-Unique: lvwzdyWHOCmUtfAEYkCb9g-1
X-Mimecast-MFC-AGG-ID: lvwzdyWHOCmUtfAEYkCb9g_1781193459
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-45ef6417092so6862725f8f.2
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 08:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781193459; x=1781798259; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0wEonq2dGt1fOHOCL85F50+fzjAb0sZKPZndRoL36SI=;
 b=EVzjiNIeXQyX+pacRwLPQlxaZrxmYS1CKWtMNZO91ylc9HNtAUfADqIMmvH69X/ejK
 SBaV8H5zitIBdAPbqf7hJYJjOVdKRQpUsc7rKNjQSYZkj4Ik+KQ4rYihOVzjBB1H+GNS
 idx+L8FzueqoJ7swXiWDVpnweon2U70beOZD2yyVQXXjASXxKXg01L2ZCNjx7yRkd9KN
 6yWhkDcywSaO3rl1URuwwhCC1N0pbx8SjeASi/M9su/2m0UHFpIb2HmMVzaox+2CC1MY
 8uvCp99BcLzoX7js7waszbrk7lb5Qw6eKNvNFXC/w9QPVx7n/5TlJfSAgnynSgY5HSTy
 31CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781193459; x=1781798259;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0wEonq2dGt1fOHOCL85F50+fzjAb0sZKPZndRoL36SI=;
 b=ZTFK++YGtIaNKnHC57tWOKjV505J7wdRElRbwmhpEtsTysewrRxSVUjf3SzvYI2zkj
 deDsfMOwRfcfm3ear3OXqkoggEKJOoEO93WtPK3d+7D8iTYgsr7Swbwm5BdEWmFg44pe
 X8TJMP+UqX7W/U21PZt7uqOigScxDnvAIVMD6Lwo91DTlesPDJ9MCdQLnxQjhS7M7EzT
 NgmCnfdwenjQjqDOFc7QpELK+VgeLQBsikvh+O3og9fqqJYe2G+86WklsPjw1oo4byzu
 jvCy0SxJ/CX+4VUMWfNepy4XiVAWqg9XxK98niXvYaxyEQDXrQjOtDZCaSXPwHxWnXtW
 g/Zg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9/ivdxYH3gnGR8CdJSAVllDWffbnYip7lZ1zZmFTZq9mHZYQWJQL/A0JXsyw6C91Br9pW4UuNujj0s@nongnu.org
X-Gm-Message-State: AOJu0Yz/k+Am/0tprkmhTP92GThWL/35Z7FyjGm/paR8C/H82DODsoji
 8HCslva80S1iIMgyAHF96Nh2afjwT/5uk1RAtm8M9AfRTbS41g/RCURjLkNBBdUVDTwtsi/MfA1
 Vw7FbUwKL0NMp3IlrPTIzt/nc0kN4frfleEl3/4mWpLPQkQCslkatJ4pO
X-Gm-Gg: Acq92OHVxi0a5rI5gLu1/gglbvL7fBYccI0zydJE1UFwX9XQmsB00AZn314CKYlS+1J
 tFljozOPSE8xlKcoynnsWCd15ZWG72nqgXZf5xfdwIz7O2rEPk5zccsM9uV7BQhEtxL5P6H3Wtc
 s5uVm/VBk+/n3WMJNXAwIiQe68JP7XEJhLZ7csTSlP7L3KANuEMTvdAx/KYIu5bXFxFnFouHwKO
 PwKrgVI3iqtc524hdzJXatmEQbiKb83hoEDFHIYlAPSMMHm741OQCd0RLzAPXjlXddY5eW8gtSo
 GcbptNnd+TQ03YcMbck+F2jgByECnpf0ISw3oJ8r9vREc1xv/9X+wp5WhPVliM+8ZXDsyBaalu5
 l2Zd7Tr9B6aPyL5KqTr00Zqxk2yfEmg3VVXWQxI2x9rpdE+G+Yqbomw==
X-Received: by 2002:a5d:53d2:0:b0:45e:ed10:8e0c with SMTP id
 ffacd0b85a97d-46067599538mr4016732f8f.14.1781193459149; 
 Thu, 11 Jun 2026 08:57:39 -0700 (PDT)
X-Received: by 2002:a5d:53d2:0:b0:45e:ed10:8e0c with SMTP id
 ffacd0b85a97d-46067599538mr4016678f8f.14.1781193458554; 
 Thu, 11 Jun 2026 08:57:38 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f35eae5sm83507005f8f.33.2026.06.11.08.57.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 08:57:37 -0700 (PDT)
Date: Thu, 11 Jun 2026 11:57:34 -0400
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
Message-ID: <20260611114811-mutt-send-email-mst@kernel.org>
References: <1e9515c9-7e32-4d95-9b73-aab8bf10bddc@redhat.com>
 <20260611012217-mutt-send-email-mst@kernel.org>
 <3726a607-6cac-41f1-b402-0eed7c4e3fe3@redhat.com>
 <20260611023428-mutt-send-email-mst@kernel.org>
 <0c3f1dba-3b2c-43c5-b181-1426f6da0951@redhat.com>
 <CAFEAcA8Q9qEaZS8wCpZQ-4jpAnQ9JXvnb7iSeRTdhJ9Y3BcCRg@mail.gmail.com>
 <20260611093049-mutt-send-email-mst@kernel.org>
 <CAFEAcA-8Hv0o3PibjH=8jixsHyunH2HkOAMQVqHkGr34b1Ascg@mail.gmail.com>
 <20260611110156-mutt-send-email-mst@kernel.org>
 <CAFEAcA_2oZepwCoPS+cMgdnrSTj=mCGzdFZf5gGRHJK13yqaKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_2oZepwCoPS+cMgdnrSTj=mCGzdFZf5gGRHJK13yqaKQ@mail.gmail.com>
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

On Thu, Jun 11, 2026 at 04:29:49PM +0100, Peter Maydell wrote:
> On Thu, 11 Jun 2026 at 16:05, Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Thu, Jun 11, 2026 at 03:55:12PM +0100, Peter Maydell wrote:
> > > On Thu, 11 Jun 2026 at 15:10, Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > Yea, and I feel this is the main part:
> > > >
> > > >     The assumption here is that accesses initiated by the VM are
> > > >     driven by a device specific driver, which knows the device
> > > >     capabilities.
> > > >
> > > >
> > > > Frankly I don't get why a big hammer of disabling direct access
> > > > was taken, when all we apparently need to do is to make sure
> > > > small aligned accesses through BAR stay aligned and same size.
> > >
> > > If you say an MR is OK for direct access then in my view you are
> > > saying "any access of any kind is OK", because you're permitting
> > > the pointer to be directly returned as a host pointer from
> > > address_space_map() (at which point the caller might do anything
> > > with that memory). That is not OK for every BAR, only for ones where
> > > it's really RAM.
> > >
> >
> > What is "OK"? If the BAR is RAM and I write into it, I will overwrite
> > data guest stored there. Is that "OK"?
> 
> By "OK" I mean it behaves like RAM: any kind of load or store
> will work, at any width and any alignment.
> That is what makes
> it OK to return the pointer from address_space_map(), where
> the caller will treat it as any other C host pointer (e.g.
> assigning it to a C struct pointer and then writing to fields
> in that struct), like virtio does:
> 
>         iov[num_sg].iov_base = dma_memory_map(vdev->dma_as, pa, &len,
>                                               is_write ?
>                                               DMA_DIRECTION_FROM_DEVICE :
>                                               DMA_DIRECTION_TO_DEVICE,
>                                               MEMTXATTRS_UNSPECIFIED);
>         if (!iov[num_sg].iov_base) {
>             virtio_error(vdev, "virtio: bogus descriptor or out of resources");
>             goto out;
>         }
> [etc]
> 
> This is only safe when the pointer is something we can
> handle as if it were a pointer to normal RAM (because the
> C compiler makes no promises about only doing correctly
> aligned and sized accesses: to it, memory is memory).



Safe as in what? Work meaning what?

mmap of a device register is a standard API in Linux, it gives you a
pointer and no, it does not imply that "any access" will not make your
box go up in smoke, and never did.


> > If the BAR is RAM and I write into it, I will overwrite
> > data guest stored there. Is that "OK"?
> 
> If the guest said "please DMA to this address" then they're
> expecting you to overwrite that data, yes.

The "If the guest said" is critical here. It's not OK
at a random time and place of your choosing, and never will be.

It's exactly what I said: if we are doing what guest does,
like fixed length memcpy does,
then we are good. If instead we are replacing guest accesses
with different ones like variable length memcpy does,
we'll get issues.

> 
> Merging in your other reply:
> 
> >> The
> >> problem is that for some PCI devices (like the network card
> >> mentioned in 4a2e242bbb30's commit message) the BAR is *not*
> >> safe for arbitrary access (because the actual real host hardware
> >> inside it is not RAM).
> >
> > But we don't do arbitrary access. Why would we?
> 
> If we mark the MR as "direct access OK", then we do, or might do.

what does this might mean?

> The bug the commit is fixing is exactly that there is a codepath
> that uses the latitude that marking the MR as direct access permits.


No, the bug is that a 4 byte fixed length access was converted
to a variable length memcpy function call which started
doing single byte accesses.


> 
> > There's no such thing as "not safe for direct access" in PCI.
> > All operations are memory operations.
> > What can be unsafe is accesses of specific width and length.
> 
> I think we're talking at cross purposes here. By "safe for
> direct access" I mean exactly that arbitrary width and
> length and alignment are permitted.

This is a strong demands that QEMU simply never needs.

> This is what
> memory_region_supports_direct_access() is testing.
> If the PCI BAR can't handle arbitrary widths etc then that
> function mustn't return true for its MR.
> 
> (Though if we ever get into trying to address_space_map()
> a BAR like that something is going to go wrong anyway, because
> the "not OK for direct access" path fills and empties the bounce
> buffer by calling flatview_read() and address_space_write(),
> which aren't going to honour any theoretical alignment requirements.
> Perhaps that kind of BAR should just flat out not be one we handle
> with a ram_device MR?)


mmap of a device is a standard thing that everyone did on unix, for
decades. just don't do things, with a device, that a driver does not do.

> > > (I think there are places where we do need to be more careful about
> > > what we do with accesses to real RAM, for where we're emulating a
> > > device write to RAM that's updating a data structure shared with the
> > > guest, and things like writing multiple times can cause problems.
> > > https://lore.kernel.org/qemu-devel/CAFEAcA8dwHV8F48kb-013rxkG9kKcZhym9_qarKmoeUfeh0YWw@mail.gmail.com/
> > > is an unrelated example of that, which I haven't done detailed
> > > analysis of yet.)
> 
> > If it does not work, then QEMU is broken:
> >
> >
> > /*
> >  * Any compiler worth its salt will turn these memcpy into native unaligned
> >  * operations.  Thus we don't need to play games with packed attributes, or
> >  * inline byte-by-byte stores.
> >  * Some compilation environments (eg some fortify-source implementations)
> >  * may intercept memcpy() in a way that defeats the compiler optimization,
> >  * though, so we use __builtin_memcpy() to give ourselves the best chance
> >  * of good performance.
> >  */
> 
> Good point. (Though if I were an optimizing compiler I might
> be tempted to optimize a switch() on the length where each
> case called memmove with a fixed length argument back into a
> single call to memmove...)
> 
> I suspect your suggested flatview changes would fix that e1000
> bug. But I don't think they're the right thing for this problem.
> 
> -- PMM

Then I'd like to see an example where we have an actual good reason
to do execute arbitrary width accesses on device RAM when the
driver does not execute them, please.

-- 
MST


