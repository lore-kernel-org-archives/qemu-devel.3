Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB901C5475B
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 01:12:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfUy0-0008Nx-6x; Wed, 28 Feb 2024 20:12:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rfUxy-0008Ng-9u
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 20:12:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rfUxw-0005mY-Ft
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 20:12:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709169123;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aUzMz0fg2zMtCCfqhZs/aP6ZIRc5VyOH7QSpwvXOIWQ=;
 b=ZlKD2O/ViOcrwsNVoCYauw1z6TJuOtMD80u4OiYIsWHlSD8HnSqqw3j1VRYUd6/zGSoqHO
 eP30FqhOvNApLGtp7519tlMuaEz5Gd9orbbD/IoQA7Lx4JGRXQHBmTNlgtu7V7ncITwaNl
 gRl5PLkTbcqnFjfFZUyxfI2VHLM3dcY=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-dqFMm3F2NbqWom6f3gpbrg-1; Wed, 28 Feb 2024 20:12:01 -0500
X-MC-Unique: dqFMm3F2NbqWom6f3gpbrg-1
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-563de65ac5dso97813a12.1
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 17:12:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709169120; x=1709773920;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aUzMz0fg2zMtCCfqhZs/aP6ZIRc5VyOH7QSpwvXOIWQ=;
 b=ojFqphKjFSBQK3Y6mEMUXO3q90VZ2Zp1ZIgwNyl7G3SKhjanxBek6tjYcTBTzRniIL
 c496Vv6kyitRQ45vGdY8bjXw24NluT4qa1b5xP8jzo8UJQWQiY/ClrXDzfbHi/6tlpx7
 UP35P7wCWWEwPyYVfnPykNw4moqgA382A5naJkRN/pbJ3vYZLmo6Sx8ymhcLFqCUHLtC
 Gdt/Hrgeamjqd5a/FYc/NL44QKYgCvqDUwZIFPlB14bFAIbqXhfcFWiVWMm/azwLW3rj
 0ErU4pXdNuEX16IkWn3+Mf0gni5x/GxHe2WittPl/ufhRFsA+pNYraJxT2WmrqsSalql
 t3Pw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgoG31I1FQpW9vjqVr05kV9wlUUBceZzP9RRItSfbfefO3aXsABgxeDfY7t5q5EEHfoDqHpAhXldGaOpfJuH8SS7Fl/J0=
X-Gm-Message-State: AOJu0Yx8vecnfTAdhzMynudHyXfDotQADk9noU3IFL23RbfzPCdlTO03
 MnGYw1df8sbSwYXjtZP78tkzgFCAXpql5Cz6jGsXKdin7+FUwZAL6AK8wsFuZBQM1o3d9COifQT
 UNe51Pqf1RpgLtNopE0zuODLa87dS8LMWxxpjHvajwxf+racnUzlo
X-Received: by 2002:a17:902:b181:b0:1dc:7721:94c2 with SMTP id
 s1-20020a170902b18100b001dc772194c2mr680166plr.0.1709169120681; 
 Wed, 28 Feb 2024 17:12:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE7e/LR+JXcGsCHo9PMy8WkrS+6Lzo9CLYqlHi4XVgAvmQpjOQfnDORsgPLHTGM3hJkuUd7CA==
X-Received: by 2002:a17:902:b181:b0:1dc:7721:94c2 with SMTP id
 s1-20020a170902b18100b001dc772194c2mr680149plr.0.1709169120283; 
 Wed, 28 Feb 2024 17:12:00 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 w16-20020a1709026f1000b001dc90b62393sm88054plk.216.2024.02.28.17.11.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Feb 2024 17:11:59 -0800 (PST)
Date: Thu, 29 Feb 2024 09:11:53 +0800
From: Peter Xu <peterx@redhat.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Mattias Nissler <mnissler@rivosinc.com>
Subject: Re: [PATCH, v2] physmem: avoid bounce buffer too small
Message-ID: <Zd_Z2f-5_l3rXNbp@x1n>
References: <20240228125939.56925-1-heinrich.schuchardt@canonical.com>
 <fb6ef90d-4a3e-4bdd-8516-8b15c1f2329f@linaro.org>
 <b9937680-8c0b-46f6-86ef-55139562e2c4@canonical.com>
 <CAFEAcA_Bshua2BQTfOb3D1aF27ayELEt9TcQM8hkQdKaih3xHw@mail.gmail.com>
 <9c64be5c-25b8-421d-966a-bdac03dfe37c@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9c64be5c-25b8-421d-966a-bdac03dfe37c@canonical.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Feb 28, 2024 at 08:07:47PM +0100, Heinrich Schuchardt wrote:
> On 28.02.24 19:39, Peter Maydell wrote:
> > On Wed, 28 Feb 2024 at 18:28, Heinrich Schuchardt
> > <heinrich.schuchardt@canonical.com> wrote:
> > > 
> > > On 28.02.24 16:06, Philippe Mathieu-Daudé wrote:
> > > > Hi Heinrich,
> > > > 
> > > > On 28/2/24 13:59, Heinrich Schuchardt wrote:
> > > > > virtqueue_map_desc() is called with values of sz exceeding that may
> > > > > exceed
> > > > > TARGET_PAGE_SIZE. sz = 0x2800 has been observed.

Pure (and can also be stupid) question: why virtqueue_map_desc() would map
to !direct mem?  Shouldn't those buffers normally allocated from guest RAM?

> > > > > 
> > > > > We only support a single bounce buffer. We have to avoid
> > > > > virtqueue_map_desc() calling address_space_map() multiple times.
> > > > > Otherwise
> > > > > we see an error
> > > > > 
> > > > >       qemu: virtio: bogus descriptor or out of resources
> > > > > 
> > > > > Increase the minimum size of the bounce buffer to 0x10000 which matches
> > > > > the largest value of TARGET_PAGE_SIZE for all architectures.
> > > > > 
> > > > > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > > > > ---
> > > > > v2:
> > > > >      remove unrelated change
> > > > > ---
> > > > >    system/physmem.c | 8 ++++++--
> > > > >    1 file changed, 6 insertions(+), 2 deletions(-)
> > > > > 
> > > > > diff --git a/system/physmem.c b/system/physmem.c
> > > > > index e3ebc19eef..3c82da1c86 100644
> > > > > --- a/system/physmem.c
> > > > > +++ b/system/physmem.c
> > > > > @@ -3151,8 +3151,12 @@ void *address_space_map(AddressSpace *as,
> > > > >                *plen = 0;
> > > > >                return NULL;
> > > > >            }
> > > > > -        /* Avoid unbounded allocations */
> > > > > -        l = MIN(l, TARGET_PAGE_SIZE);
> > > > > +        /*
> > > > > +         * There is only one bounce buffer. The largest occuring
> > > > > value of
> > > > > +         * parameter sz of virtqueue_map_desc() must fit into the bounce
> > > > > +         * buffer.
> > > > > +         */
> > > > > +        l = MIN(l, 0x10000);
> > > > 
> > > > Please define this magic value. Maybe ANY_TARGET_PAGE_SIZE or
> > > > TARGETS_BIGGEST_PAGE_SIZE?
> > > > 
> > > > Then along:
> > > >     QEMU_BUILD_BUG_ON(TARGET_PAGE_SIZE <= TARGETS_BIGGEST_PAGE_SIZE);
> > > 
> > > Thank you Philippe for reviewing.
> > > 
> > > TARGETS_BIGGEST_PAGE_SIZE does not fit as the value is not driven by the
> > > page size.
> > > How about MIN_BOUNCE_BUFFER_SIZE?
> > > Is include/exec/memory.h the right include for the constant?
> > > 
> > > I don't think that TARGET_PAGE_SIZE has any relevance for setting the
> > > bounce buffer size. I only mentioned it to say that we are not
> > > decreasing the value on any existing architecture.
> > > 
> > > I don't know why TARGET_PAGE_SIZE ever got into this piece of code.
> > > e3127ae0cdcd ("exec: reorganize address_space_map") does not provide a
> > > reason for this choice. Maybe Paolo remembers.
> > 
> > The limitation to a page dates back to commit 6d16c2f88f2a in 2009,
> > which was the first implementation of this function. I don't think
> > there's a particular reason for that value beyond that it was
> > probably a convenient value that was assumed to be likely "big enough".
> > 
> > I think the idea with this bounce-buffer has always been that this
> > isn't really a code path we expected to end up in very often --
> > it's supposed to be for when devices are doing DMA, which they
> > will typically be doing to memory (backed by host RAM), not
> > devices (backed by MMIO and needing a bounce buffer). So the
> > whole mechanism is a bit "last fallback to stop things breaking
> > entirely".
> > 
> > The address_space_map() API says that it's allowed to return
> > a subset of the range you ask for, so if the virtio code doesn't
> > cope with the minimum being set to TARGET_PAGE_SIZE then either
> > we need to fix that virtio code or we need to change the API
> > of this function. (But I think you will also get a reduced
> > range if you try to use it across a boundary between normal
> > host-memory-backed RAM and a device MemoryRegion.)
> 
> If we allow a bounce buffer only to be used once (via the in_use flag), why
> do we allow only a single bounce buffer?
> 
> Could address_space_map() allocate a new bounce buffer on every call and
> address_space_unmap() deallocate it?
> 
> Isn't the design with a single bounce buffer bound to fail with a
> multi-threaded client as collision can be expected?

See:

https://lore.kernel.org/r/20240212080617.2559498-1-mnissler@rivosinc.com

For some reason that series didn't land, but it seems to be helpful in this
case too if e.g. there can be multiple of such devices.

Thanks,

-- 
Peter Xu


