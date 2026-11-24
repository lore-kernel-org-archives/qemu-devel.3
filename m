Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9604606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 16:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hVPdXT9w;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=dbI0U7wk
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVtVA-0006ix-L4; Tue, 24 Nov 2026 11:36:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xVtV8-0006he-Lg
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 11:36:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xVtV6-0006eC-Vh
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 11:36:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795538171;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ISWZuHQndtj0QMk5zA8Cau3i7FiJpjmBbuCP6OdUqUU=;
 b=hVPdXT9wzHu5QHpk2bCj+gWAhu20APC3OsWINlUuA9+sIvKPEwgORoKY6AccyokttEQu2G
 ejODODRN3hiIxIrTAdnWm/F/AWbLyOXuexwX2xSx994D8LhZXZdGmaxT/MJlDRXk34i/g7
 458Juumm65onmMEQ6+3G6U55EnpuObY=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-394-cKGcOPvAOuqBIHbz7KpMPg-1; Tue, 24 Nov 2026 16:36:06 +0000
X-MC-Unique: cKGcOPvAOuqBIHbz7KpMPg-1
X-Mimecast-MFC-AGG-ID: cKGcOPvAOuqBIHbz7KpMPg_1795538165
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-7d2cb77c7abso573365137.3
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 08:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1795538165; x=1796142965; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ISWZuHQndtj0QMk5zA8Cau3i7FiJpjmBbuCP6OdUqUU=;
 b=dbI0U7wk5q4rOEDooFuY6qFBUzMZshU/B80ltfun2pHam5/2K/JaRSXuXryTehMv4V
 rulXwXUWPOlol+tpow170ea+4MJ2DO0V1sM/+Ig4qjiDN24lrHhZqz8v+yu75OODUXhl
 9mUwygEbcktNXJkrzI1W/GqJEbOTj6BbKlPgsJrUrC7yYFCXyYiBZAnsFT2vRxvDqAYM
 d/J/EgB3E7LQi9rWkGRxAhS7iGxDY0qybWtURVmYg7K/0zwaBHtEbnT2FuZWYiga2fsz
 ESrDEWwAI7zVGdvNoVFNUjymeOXfxxI+tafHnjDaAgvMFoh09zM1cYnhTMATQEaajuUC
 B4cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795538165; x=1796142965;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ISWZuHQndtj0QMk5zA8Cau3i7FiJpjmBbuCP6OdUqUU=;
 b=GF/MHN4N+3g8Ba7nBjjh5rAXxu7SHAjBoaM4Tf/fwj7IzAPHwgumVufJtWFccPR4+6
 KqPOSg1RwhthCg2QOK/v2bHnF6/j8MtWikEmsCLBKDSOR5VmMH30Sz43YBxbfjW2xLTb
 FweU1LVZbgt6FegUZ/TBDfcwKSvqCRT26vrMTSMS1WD7Y9k8IRwR18gh1wkYrym4RNAA
 b+7NqOgbJssj4A0+/i+HCsI5qny8t9Kd462lhk0/cUOlxeqiCfBMDG+//och3DeIl4Mn
 brvcsMDGKjlRkoRTXQg1U7p97U2CXQ+s3lU0LE4qBb1Y9dLTkvZslXPvFX++2+e896qv
 LhGg==
X-Gm-Message-State: APuU4Z9lwIGnxR0lp/f8JgiYZbITxCcC2AfStmuDmkPHciG1jLtPklFm
 9nWOHJ4Jcwixj7PSnL/I6QY4kdWkaack8hIZQO6YUDRthLdf7r671/Ufe+l3JTCqdrrCU5jhOKl
 DVpe6uANPIFD1OfTaDNvMeADcS7t7AYj2d1Vp3A48FDvjbJftWRKA1E46
X-Gm-Gg: AZFdTZddTaIruwlckqhiN/orX6JAG0iu4/H2yLIGPOEhcS3frNh0A3sYbUem9H0D1JX
 q/6P/kd2GinV2Bo/26+GZuUB6uHMD8ASW6Pc50N7rk7QZCISXI6CiaR/5lkXFVD2OtTDwW+fhSk
 0zxz1XySkJz1Z9Rlxw16mDVWaZXZF0jjT3+yHbATEXcByZW1LxI4s+85KiKIX4olNJEGW2+ZNql
 Ytg03+e4cOmeSI0EeWGRLMxYOsS6OwdEZLm4T4as7phNl2uw05czVVMl1AKKpvy8AHU+tHIy1kf
 qkubvMNtR5I0w/AoQPAuW1I7gxK+Ltizl//LOpPnhu1iBrAswfJrpXSrOd3FtrBZYUV3Bfj+Rgu
 ZaWSoGlEWyOOTnb7dDz5oUosCGmIOE5QSwj/+/85Evxrx
X-Received: by 2002:a05:6102:688c:b0:7cc:2cef:b341 with SMTP id
 ada2fe7eead31-7d72b35f75emr6534092137.4.1795538165220; 
 Tue, 24 Nov 2026 08:36:05 -0800 (PST)
X-Received: by 2002:a05:6102:688c:b0:7cc:2cef:b341 with SMTP id
 ada2fe7eead31-7d72b35f75emr6534046137.4.1795538164659; 
 Tue, 24 Nov 2026 08:36:04 -0800 (PST)
Received: from localhost ([142.188.212.246]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-92134a0f5d7sm140165756d6.37.2026.11.24.08.36.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 08:36:04 -0800 (PST)
Date: Tue, 24 Nov 2026 11:36:02 -0500
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: Re: memory_region_init_ram_ptr() handling of sizes that are less
 than a page
Message-ID: <awW88uEaJ2IKp-nY@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <CAFEAcA_77DxGK-26Z6=qx0a88Zd0KQgFjKgJc2CgTmm-iOzbsg@mail.gmail.com>
 <CAFEAcA-o9DoPL1D0-S3hpB1bT6iSNgy4zm1VZRSjcjxHkmUfiQ@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA-o9DoPL1D0-S3hpB1bT6iSNgy4zm1VZRSjcjxHkmUfiQ@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 24, 2026 at 03:52:22PM +0000, Peter Maydell wrote:
> Hi -- can I ping people on this memory subsystem question
> again, now that hopefully those at KVM Forum have been able
> to dig themselves out from any email backlog? I'm really

Not yet for me, maybe it's because I'm slow.. :( Also because new things
keep coming too.

> not sure what the intentions of the MR and RAMBlock APIs
> are here w.r.t. alignment...
> 
> thanks
> -- PMM
> 
> On Mon, 16 Nov 2026 at 15:03, Peter Maydell <peter.maydell@linaro.org> wrote:
> >
> > memory_region_init_ram_ptr() (and memory_region_init_ram_device_ptr())
> > create a MemoryRegion backed by a lump of memory provided by the caller.
> > They do this by calling qemu_ram_alloc_from_ptr(), passing the size
> > and pointer along. However, qemu_ram_alloc_from_ptr() does this,
> > regardless of whether it was given a host pointer or not:
> >
> >     align = qemu_real_host_page_size();
> >     align = MAX(align, TARGET_PAGE_SIZE);
> >     size = ROUND_UP(size, align);
> >     max_size = ROUND_UP(max_size, align);
> >
> > The result is that if the caller passed us a lump of memory that's
> > not a multiple of both the host and target page sizes then we create
> > a RAMBlock whose used_length and max_length fields claim that it's
> > larger than the actual backing memory. Any user of RAMBlocks that
> > trusts that information (such as the migration code) will then

I don't think I fully digested everything, so I just quickly glimpsed over
the conext so far just to start replying something..

One thing about migration: I don't think we will migrate these ramblocks,
because we need to register them via memory_region_register_ram(), and we
don't do that for ram pointer based MRs, AFAIU.

> > happily read or write off the end of the backing memory.
> >
> > This obviously isn't right, but is the problem:
> >  * that qemu_ram_alloc_from_ptr() shouldn't align if it's given
> >    a host pointer, and all users of RAMBlock need to be able to
> >    cope with unaligned base pointers and sizes?
> >  * that qemu_ram_alloc_from_ptr() should complain (assert?) about
> >    unaligned base pointers and sizes, and all callers trying to
> >    use it for smaller MRs need to be fixed?

Didn't read deep into below two use cases, if they're valid
not-page-size-aligned ram pointer, we can't go with 2) anymore because we
don't want to break them?  Or.. do we?

The 1st one sounds reasonable on its own, it's a matter of whether we need
those use cases, IMO.

Thanks,

> >
> > This came to my attention via
> >  https://gitlab.com/qemu-project/qemu/-/work_items/4877
> > which reports that trying to migrate the AVR 'uno' machine runs
> > into this because it creates an "sram-as-io" MemoryRegion backed
> > by a local allocation which is less than a page.
> >
> > Related is
> >  https://gitlab.com/qemu-project/qemu/-/work_items/4663
> > which reports that the tpm-tis-device doesn't work under hvf, because
> > that device creates a non-aligned RAM MR with memory_region_init_ram_ptr(),
> > and the hvf code fails with an error when it sees a non-aligned
> > lump of RAM.
> >
> > I'm not sure which direction we should be going in trying to fix these.
> >
> > thanks
> > -- PMM
> 

-- 
Peter Xu


