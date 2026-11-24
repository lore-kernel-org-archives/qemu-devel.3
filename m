Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E81606A323
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 17:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=lH5z6S45
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVuSi-0007Zo-5w; Tue, 24 Nov 2026 12:37:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xVuSa-0007YN-PR
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 12:37:41 -0500
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xVuSZ-000673-0A
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 12:37:40 -0500
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-67da3d03263so5045926d50.1
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 09:37:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795541857; cv=none;
 d=google.com; s=arc-20260327;
 b=DKWg+7zpWD3rau2BiYEHOtaAPWbiqDir93X9B7GfGwW7G4huBx/o7uQKVk8D5UzbeL
 O4w2gflM4h/DispsKOHvxZqu7omDNwc7CRnuFqy1ktPvKD392YcC1kNnpXQT4gOT8qxX
 knvwXbitUwJoo3yiF5NOIkQ8unvIsl0j2aKpNgQEIP28TO+Lfx6bs0CDwyRzl1EMa7uv
 tz/LrUQbUlOChiemRvd5elJ+oWgtLrHcEMIK4k5koquJ4dYi4IMcYCJno1dfHnOvcJDs
 yic3pm4t1F5tDAp9+1abK0YKZU+PB4ZP2klWzsmftEA8IW0HUX9geq7eVvAp7Xgjk1Kh
 Eg1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=tuB+KLwQR/r82zES/4UNJgCj5t/3fj7K8lSi6mbhI4c=;
 fh=V9shaXgrQKpgdrWsyI3maBW7BqJyQvjPGcgwBYaVpSI=;
 b=pLIMxqi5XS3v8J5ddBpmX1wOGGHnSI27V8pBhJzsnByqWAcieLGIORk2cz3ej6bcwh
 XCnDQ/OUPJJDRM74KoI7jI72z0LzQXrCaXO8FrOUTP/fIO3MWv5LgOlOJz4G2avyn4jm
 Auw3yhXm1jIQBHHQb3UNJD5KOIaFdHzXGkWfYGc22zMphjhBLESYOcYk2a1U0dhGmD5S
 HdQkj9KH73CoDrVp2iUqRxB2qPBjZG0Kh2nIOxuTRxA4kOd9cRi1ABV8tvB+NTaln8gE
 wLXBwetZLj07xF54csdxwfePSTAfuweK4e6eZQTEh9OfEYyuyo5oPU3M4FDo3yYfcVF2
 pMYg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795541857; x=1796146657; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=tuB+KLwQR/r82zES/4UNJgCj5t/3fj7K8lSi6mbhI4c=;
 b=lH5z6S45AbUy2CUP2jfGlEUQISsPeVnb16IN3fLa03ps7fNBDhNGW/u0WWQPxBdcCO
 ISrTlwjSJZcNDMCjS0fp1rda60+KdrkQdUMxZMi9hYZiPKe30u7o/RnsJ7J9wxM4wAX9
 ARK0CUn07jXcWhazPy552UXIDxSxhM89EZshxH0HQ/yk+ifUlNMx2Se9bl74W342mOXI
 2i8YAqcTqt5WBRbzuocbl7Vd/eBgwIs0bSTzDXoiYa1r2e8j+wscB16t3+C/27pqoeiS
 NZ4OQUVNr3vgmNu84HEbiuvKrzkxz3BhtOXepLlyJ9yQ6gqfIrTZHlAgnIrmEp7ay7OS
 6zLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795541857; x=1796146657;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=tuB+KLwQR/r82zES/4UNJgCj5t/3fj7K8lSi6mbhI4c=;
 b=evqwLgmGIxCYSkQyTdUPLz3oGHrbg9aCc5IOrbfQwmBVX5++g6Gm0keQHdJsrvRAtr
 9G8LN0fu3bJ9pyENXkrx+WBSCyGxgHtbzV7tuNl19+UuhtycFb3nHF86JQHMdAyQXhRk
 ooSo3QEl/gwgDePzWzdVn/PxDQK7u23aOdDf3SZaVxj/r77eSFqPdS2hkb07nsl1z3UT
 MkfEEMgrNI7u7n9ioOB14xuR6xrUQY4dr3E93UbP+6/flADoIvIWy7d4ttoc+TxLqQzk
 O+eusN/YPdxrUeI5b5RjTR7SjcZMTGtu84iXLbIlY4XoZ5qRr51Mg9qbXFphmElPWwk5
 yeAw==
X-Gm-Message-State: APuU4Z96lR1kYePLxelj1iwT5nnp3KXAF0pyOZA+SOLAtvNCSCKgwALx
 rCpbzJhOg+NA0/fPnMj26JJsvKwNDtD7yehdpNpUrze8t4jzCpgZlc3yCEHu7oZAna8czUD3GKQ
 WEtbVZ59UMJYcPnEU7GkFwBhLLv+J/rLRDW/s/yw5jg==
X-Gm-Gg: AZFdTZcGEAFBn2nW0cyAkydgBFv0PaMZ7+tPCP3IWXhqnx954FCCT7C/6G4MPaLk3IQ
 iQTFW7S7iOY5VadbWvby/Au1XyJNj+GPG3HhHgzT+md1mjLeORJSWK1ppdid/yqHbpeF85tCL9g
 QgUdi3n4S8c9vjOPqwnbO1jCD3cbWEEEs9Av2qw2nj6YAkch37Q8cGpaOoL8vVpQT4i2d9Yh+8d
 hqVD/kvDRlVUzr5gMmYSMwtAATXIfA+koeJfbS+5SG/UjRZMjqKuFyn3hFiXXAq81107QzeWnzq
 xicn5tOCf4PmuUXNfTKBitrmiZ32VyvSkU0ETa76yFXjVxTbIkEJBmfnKQVM6uksYSmqgFtHlLz
 abqjzHmRe/S2OZXoo9rTbWEW6J+wqIEbuznDaYj2ihr3TiHfLUbO0jW8SBNqGSqCag3sApqKGDh
 k1CdVRZKRYYrFNGNun1GLIcQ==
X-Received: by 2002:a05:690e:43c6:b0:67b:fd1d:4767 with SMTP id
 956f58d0204a3-67df4446b9dmr3114452d50.88.1795541857542; Tue, 24 Nov 2026
 09:37:37 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <CAFEAcA_77DxGK-26Z6=qx0a88Zd0KQgFjKgJc2CgTmm-iOzbsg@mail.gmail.com>
 <CAFEAcA-o9DoPL1D0-S3hpB1bT6iSNgy4zm1VZRSjcjxHkmUfiQ@mail.gmail.com>
 <awW88uEaJ2IKp-nY@zhexu-thinkpadt14gen5.rmtcaon.csb>
In-Reply-To: <awW88uEaJ2IKp-nY@zhexu-thinkpadt14gen5.rmtcaon.csb>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Nov 2026 17:37:23 +0000
X-Gm-Features: Aa3M54qeMoQtUcis7f1jcx1aiDdM2ns-3Lwz_KPMnWBNDPMnGAqPd1ZXWrFbHNU
Message-ID: <CAFEAcA-PB-tPvdXc6ZMMhanN0fPi9uvGQ=XtM0h2+uxt-JnrSg@mail.gmail.com>
Subject: Re: memory_region_init_ram_ptr() handling of sizes that are less than
 a page
To: Peter Xu <peterx@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb130.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 24 Nov 2026 at 16:36, Peter Xu <peterx@redhat.com> wrote:
>
> On Tue, Nov 24, 2026 at 03:52:22PM +0000, Peter Maydell wrote:
> > Hi -- can I ping people on this memory subsystem question
> > again, now that hopefully those at KVM Forum have been able
> > to dig themselves out from any email backlog? I'm really
>
> Not yet for me, maybe it's because I'm slow.. :( Also because new things
> keep coming too.
>
> > not sure what the intentions of the MR and RAMBlock APIs
> > are here w.r.t. alignment...
> >
> > thanks
> > -- PMM
> >
> > On Mon, 16 Nov 2026 at 15:03, Peter Maydell <peter.maydell@linaro.org> wrote:
> > >
> > > memory_region_init_ram_ptr() (and memory_region_init_ram_device_ptr())
> > > create a MemoryRegion backed by a lump of memory provided by the caller.
> > > They do this by calling qemu_ram_alloc_from_ptr(), passing the size
> > > and pointer along. However, qemu_ram_alloc_from_ptr() does this,
> > > regardless of whether it was given a host pointer or not:
> > >
> > >     align = qemu_real_host_page_size();
> > >     align = MAX(align, TARGET_PAGE_SIZE);
> > >     size = ROUND_UP(size, align);
> > >     max_size = ROUND_UP(max_size, align);
> > >
> > > The result is that if the caller passed us a lump of memory that's
> > > not a multiple of both the host and target page sizes then we create
> > > a RAMBlock whose used_length and max_length fields claim that it's
> > > larger than the actual backing memory. Any user of RAMBlocks that
> > > trusts that information (such as the migration code) will then
>
> I don't think I fully digested everything, so I just quickly glimpsed over
> the conext so far just to start replying something..
>
> One thing about migration: I don't think we will migrate these ramblocks,
> because we need to register them via memory_region_register_ram(), and we
> don't do that for ram pointer based MRs, AFAIU.

The atmega.c code explicitly calls
        vmstate_register_ram(&s->sram_io, dev);
which is why #4877 reports that we crash during migration.

The TPM code does as well:
        vmstate_register_ram(&s->ppi.ram, dev);
but because it ensures it creates the backing ram both aligned to
the host page size and oversized to a multiple the host page size,
the migration code works even though it is accessing something
larger than the MemoryRegion itself says is valid.

> > > happily read or write off the end of the backing memory.
> > >
> > > This obviously isn't right, but is the problem:
> > >  * that qemu_ram_alloc_from_ptr() shouldn't align if it's given
> > >    a host pointer, and all users of RAMBlock need to be able to
> > >    cope with unaligned base pointers and sizes?
> > >  * that qemu_ram_alloc_from_ptr() should complain (assert?) about
> > >    unaligned base pointers and sizes, and all callers trying to
> > >    use it for smaller MRs need to be fixed?
>
> Didn't read deep into below two use cases, if they're valid
> not-page-size-aligned ram pointer, we can't go with 2) anymore because we
> don't want to break them?  Or.. do we?

Well, that's the question. We can probably find other ways of
implementing the things they're trying to do with tiny ram MRs,
if we really have to. Or we can require that (similar to what
TPM does now) the backing store must always be aligned and
allocated oversized so that code using the RAMBlock API can
do that kind of page-sized overread.

I'm just not sure why the RAMBlock code is enforcing this alignment,
i.e. what other code would we need to change if we wanted to drop it?
Hard to make the choice if I only know the costs on one side of
the balance.

thanks
-- PMM

