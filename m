Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E57B606A32A
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 18:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Pm3nZ52V;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=l5aCsoJa
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVvT5-0006nV-7c; Tue, 24 Nov 2026 13:42:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xVvT3-0006n2-Ti
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 13:42:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xVvT2-0001PP-4R
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 13:42:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795545730;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=30AEXkKjLqeVxYQ/oyouIfeeA2jGldNC9PpofuUv4UY=;
 b=Pm3nZ52VuzqvbhMvbyZtCUM8AQ/vXZY+NACXeBz8n3r8GP/UBFhAO3ztSXgegxbLbxBOiI
 0xhZlHCz5oo0k8yzsINoOMb9OUx1EnkmczlIByQJnUWrHh/yXjGN4QMIq5SDiYXZYJyb3o
 QMQyQ3WObYt9wQtnTGOc3sIoWZaENNs=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131-miHBAc4oMTau6-Si0Q7r3w-1; Tue, 24 Nov 2026 18:42:08 +0000
X-MC-Unique: miHBAc4oMTau6-Si0Q7r3w-1
X-Mimecast-MFC-AGG-ID: miHBAc4oMTau6-Si0Q7r3w_1795545728
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-92179251e32so192076d6.1
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 10:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1795545728; x=1796150528; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=30AEXkKjLqeVxYQ/oyouIfeeA2jGldNC9PpofuUv4UY=;
 b=l5aCsoJaYS5RVZEL+N7IRnxKFnPNa80mZKR31iILPyC/+42SNn5DauwNXfYQGtDthS
 GJK0gpkITfF2/QPqVBPru9oh6IPljcvBrIfTRw/M1EoRM8d1ZpYCovW5z+BnKuBmpnTw
 xfDnYu4Sk+QELZ/91jRNnl2Eeo5/1gVRp2l0yDtIhf9tt7QAm2JZen3CBc1nrFxOc8TI
 iUXk7HoFLe1R9mLRRcN/klvxKYVvFHHJgvgoWW2XytnrD5VkOj8Kk4WEx0I0+xDVB5zk
 5TMSYD3sJoiVWWN5mCWMDvpmDZAaddzOdwiT5gebBMLiZ8jbu55QSGoGdsfZb5i1KkSG
 n/ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795545728; x=1796150528;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=30AEXkKjLqeVxYQ/oyouIfeeA2jGldNC9PpofuUv4UY=;
 b=W9RcqhvDe+ntB9pInrrBXZeIxeQIX203zfvH1VsaOIrhuTUby7VDl/PNzrUedjJ3Hx
 ab2SsDQcTU3cULgBe0Ed8bgAdFQGcyD2V0WixuySQwIvwPRkdNPaEqqG2XAgpcvHQmBM
 exbo6zgbjEomvUucvOT9EIHIKV45gS2LxBP6la1NooJI5jGDaeOZLa4imY7VG5+uy/TZ
 ZzcLd4OHUCLReVPJyWi5vhLpTar+nxLAMQHHAod0NKniDsOEjaj5v+ghM6uKzx6sDk86
 OjJ7nF2QTG8mExXnocJ0inXcZY4wZOiht2hur0MNyRj8HbRWk24287pmviTmsXRv2Rph
 0gsA==
X-Gm-Message-State: APuU4Z/LBVRtNiIujYFs25afqccijOWYi20zyxMdpbflGa2KId+uV2rq
 JAlLejKU7lHMYK8I6iOB/rg1oA2StGc1X+wE/39sAePGfH8/q7SR7RTHNEAYaR2k+l+h+kopaGq
 NDWHujVnXDUYiDKohLV2Dqimxv4CU6tY6pNocfVUvgtmukR+zrhO3vznd
X-Gm-Gg: AZFdTZdNhimkRi+yJeFYDx+wtUQluhbM1bodrYKAecmvzay/h2lwAV4+xemMnWAQCaz
 IZuLmCVLNa4Wg7rKo88wpzHymnlkWDnONklggXJuKi3pF+8dS8Hq3QT2OgNILgaA7J7IrWFDQTs
 wgi/D5a+SoyxzT3eQT6xykr0i9OIknbMTFEBBvdNvQ9nOtQdqDscfNcv12exURuaN1RzxdT87MW
 QmQykDEoFAk9KrZMRIX8tUZZYuGA1uTPdO51SCOksjU66Iuh/v1oZI9Sr/O1Es33a0ExEUt/6l3
 x6q5muYJpYhUfbtac0Q1A6yY/oQMbbzBcUwocfaJFmx7NYHrk93Lu6XdSRQGLDYHZNkz8ZxKDMF
 dkzUxxjfo/K10gnAjylXv+RLUk+aOwaURZKSblarpyiBC
X-Received: by 2002:a05:6214:300b:b0:921:645f:7408 with SMTP id
 6a1803df08f44-921645f7595mr83409416d6.53.1795545727825; 
 Tue, 24 Nov 2026 10:42:07 -0800 (PST)
X-Received: by 2002:a05:6214:300b:b0:921:645f:7408 with SMTP id
 6a1803df08f44-921645f7595mr83408856d6.53.1795545727211; 
 Tue, 24 Nov 2026 10:42:07 -0800 (PST)
Received: from localhost ([142.188.212.246]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-921349b456csm143598236d6.13.2026.11.24.10.42.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 10:42:06 -0800 (PST)
Date: Tue, 24 Nov 2026 13:42:05 -0500
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Rolnik <mrolnik@gmail.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: Re: memory_region_init_ram_ptr() handling of sizes that are less
 than a page
Message-ID: <awXafWB2p8VuG_Qh@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <CAFEAcA_77DxGK-26Z6=qx0a88Zd0KQgFjKgJc2CgTmm-iOzbsg@mail.gmail.com>
 <CAFEAcA-o9DoPL1D0-S3hpB1bT6iSNgy4zm1VZRSjcjxHkmUfiQ@mail.gmail.com>
 <awW88uEaJ2IKp-nY@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <CAFEAcA-PB-tPvdXc6ZMMhanN0fPi9uvGQ=XtM0h2+uxt-JnrSg@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA-PB-tPvdXc6ZMMhanN0fPi9uvGQ=XtM0h2+uxt-JnrSg@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 24, 2026 at 05:37:23PM +0000, Peter Maydell wrote:
> On Tue, 24 Nov 2026 at 16:36, Peter Xu <peterx@redhat.com> wrote:
> >
> > On Tue, Nov 24, 2026 at 03:52:22PM +0000, Peter Maydell wrote:
> > > Hi -- can I ping people on this memory subsystem question
> > > again, now that hopefully those at KVM Forum have been able
> > > to dig themselves out from any email backlog? I'm really
> >
> > Not yet for me, maybe it's because I'm slow.. :( Also because new things
> > keep coming too.
> >
> > > not sure what the intentions of the MR and RAMBlock APIs
> > > are here w.r.t. alignment...
> > >
> > > thanks
> > > -- PMM
> > >
> > > On Mon, 16 Nov 2026 at 15:03, Peter Maydell <peter.maydell@linaro.org> wrote:
> > > >
> > > > memory_region_init_ram_ptr() (and memory_region_init_ram_device_ptr())
> > > > create a MemoryRegion backed by a lump of memory provided by the caller.
> > > > They do this by calling qemu_ram_alloc_from_ptr(), passing the size
> > > > and pointer along. However, qemu_ram_alloc_from_ptr() does this,
> > > > regardless of whether it was given a host pointer or not:
> > > >
> > > >     align = qemu_real_host_page_size();
> > > >     align = MAX(align, TARGET_PAGE_SIZE);
> > > >     size = ROUND_UP(size, align);
> > > >     max_size = ROUND_UP(max_size, align);
> > > >
> > > > The result is that if the caller passed us a lump of memory that's
> > > > not a multiple of both the host and target page sizes then we create
> > > > a RAMBlock whose used_length and max_length fields claim that it's
> > > > larger than the actual backing memory. Any user of RAMBlocks that
> > > > trusts that information (such as the migration code) will then
> >
> > I don't think I fully digested everything, so I just quickly glimpsed over
> > the conext so far just to start replying something..
> >
> > One thing about migration: I don't think we will migrate these ramblocks,
> > because we need to register them via memory_region_register_ram(), and we
> > don't do that for ram pointer based MRs, AFAIU.
> 
> The atmega.c code explicitly calls
>         vmstate_register_ram(&s->sram_io, dev);
> which is why #4877 reports that we crash during migration.

Ah...

This seems a hack.  I don't see what we benefit from g_malloc0() rather
than using memory_region_init_ram(), it's hand-coding how allocation is
done.  IMO we should switch.

> 
> The TPM code does as well:
>         vmstate_register_ram(&s->ppi.ram, dev);
> but because it ensures it creates the backing ram both aligned to
> the host page size and oversized to a multiple the host page size,
> the migration code works even though it is accessing something
> larger than the MemoryRegion itself says is valid.

For this one, I think we need to allow user specify MR alignment for
APIs like memory_region_init_ram(), instead of playing trick with self
allocation with ram_pointer assignments.

Actually, I am aware of a kubevirt demand to enable 2M alignment for shmem
backends, which needs exactly the same thing.

> 
> > > > happily read or write off the end of the backing memory.
> > > >
> > > > This obviously isn't right, but is the problem:
> > > >  * that qemu_ram_alloc_from_ptr() shouldn't align if it's given
> > > >    a host pointer, and all users of RAMBlock need to be able to
> > > >    cope with unaligned base pointers and sizes?
> > > >  * that qemu_ram_alloc_from_ptr() should complain (assert?) about
> > > >    unaligned base pointers and sizes, and all callers trying to
> > > >    use it for smaller MRs need to be fixed?
> >
> > Didn't read deep into below two use cases, if they're valid
> > not-page-size-aligned ram pointer, we can't go with 2) anymore because we
> > don't want to break them?  Or.. do we?
> 
> Well, that's the question. We can probably find other ways of
> implementing the things they're trying to do with tiny ram MRs,
> if we really have to. Or we can require that (similar to what
> TPM does now) the backing store must always be aligned and
> allocated oversized so that code using the RAMBlock API can
> do that kind of page-sized overread.
> 
> I'm just not sure why the RAMBlock code is enforcing this alignment,
> i.e. what other code would we need to change if we wanted to drop it?
> Hard to make the choice if I only know the costs on one side of
> the balance.

I didn't check through ramblock code on subpage, but I feel like there can
be things off.

If above works, then we can switch these users to use the API which will be
page aligned.

I added both maintainers in CC in case they'd comment.

Cc: Michael Rolnik <mrolnik@gmail.com>
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>

Thanks,

-- 
Peter Xu


