Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7124CA1012
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Sep 2025 22:27:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuINj-0001Wi-Bj; Thu, 04 Sep 2025 18:24:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uuINc-0001V5-RG
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 18:24:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uuINH-0004xh-M8
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 18:24:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757024636;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=f57VVu5STfzYXpSSOAPl6mbL//ib+trgLvbz9yPsiqs=;
 b=KMFXHxvRQbtBzn7hI6eU81G1LVzXcwmGT9FlY9rsGxHnFY5FBGr/Yv4vY0rh7StnxMpdZy
 ED+jjyBXeXSMz07tAyNThIHVfffiwC7GVlrHmW2YTqMOXAtGV0yxIDxjay4RR91LrxKvYj
 fIaV0/k/CL1cDRp3m8Jq2fgB9qhTPJY=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-389-8Tv4p7SePamuUFl79Y8w6g-1; Thu, 04 Sep 2025 18:23:55 -0400
X-MC-Unique: 8Tv4p7SePamuUFl79Y8w6g-1
X-Mimecast-MFC-AGG-ID: 8Tv4p7SePamuUFl79Y8w6g_1757024635
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-725d32eaa99so34303146d6.2
 for <qemu-devel@nongnu.org>; Thu, 04 Sep 2025 15:23:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757024634; x=1757629434;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f57VVu5STfzYXpSSOAPl6mbL//ib+trgLvbz9yPsiqs=;
 b=XakqROlDFRQtE4RcW52eaLW0LmQppPYeTTkCV/FW60tPCUT3+7ZhDrP/c6STrJf9Sw
 YbFbe5Nxmd4RhuHr86cc5hT7mmEMy6fSTCb9NpVnnsG6HVJskRz3g4Hq8ixynsqOnJss
 RUsp/+nj8iWSUfhwICUT82CLyOGpbT4Xx5/W4PWHDCeYMMMKq6eDQB5Z0vzeCzZcC7xY
 vNBzeGlBrMbYVoLepqqZJyFmmlMvD+Pfydml5kLgcj+Rm1pDY3MoNH3r4wHzGYBLVWlu
 qSdSMAnm3164wRV/7DVJRWCLSW6jPuvOFTDCx1381nR8B1rinG6itttKY5uLJlgTEuER
 vLew==
X-Gm-Message-State: AOJu0YyhQRFVcjiwaewsaPJ74MGWzEGVPgac18W6CCE0di7zvJ4jXpu2
 y30JRaOvJ7jboSuTuPBUmF6CIjLaGE1x8FsPV2zX7A4hbUrCVv8FNJA6lweCq0znCtRz2HQhZ1I
 xMV+od4togLomjnaQhUnJs1c+CWjP9fgdCwku5cZWuRNkrJbkTMZgO8oa
X-Gm-Gg: ASbGncuFb/k2V8Ayo4zp/iT5G+DmzWvhDvz30QeppJ7PEtAu4Vl3W85zT0rXmvFwrn5
 I3Ni57/MUe9XSv/i1obahtWABUhAuNXokkDOV52QgWZx5QXKQPYio3P4x/ZSq/cTaJXn5WgJmY9
 sD8XlIplZFm3GHaYOKmKep48vkXjPvWvkv6QCcAI6Ckllk/TNPNuw6MZVd0saEFDcVqn3PzZedZ
 LChdygcScOGlCU754p+j5AjhvA96CEHXT7XZm51fFHK5RGAH7zTndWwLGHuMNflP2bNMYjU5VVu
 z+pnmG6g23O2W/of+KGB0NeBKy04k/LajdhhXCz//Kr3rziJdvnf3EFO0of+X6fBz7C8wkwfp/C
 xECHvCBwrDf3BYmv5VrDtFg==
X-Received: by 2002:a05:6214:765:b0:70f:4416:ce2c with SMTP id
 6a1803df08f44-70fac8940a3mr245519096d6.40.1757024633721; 
 Thu, 04 Sep 2025 15:23:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9gb+rvNjJrM2gtQfce5BlykSRlIKMrvO7wH3/3OVMJVOMAxFCbPJs9KPrSlmVaSUE+ZxDTw==
X-Received: by 2002:a05:6214:765:b0:70f:4416:ce2c with SMTP id
 6a1803df08f44-70fac8940a3mr245518836d6.40.1757024633264; 
 Thu, 04 Sep 2025 15:23:53 -0700 (PDT)
Received: from x1.local
 (bras-base-aurron9134w-grc-11-174-89-135-121.dsl.bell.ca. [174.89.135.121])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-720ad2cb78csm52565806d6.19.2025.09.04.15.23.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Sep 2025 15:23:52 -0700 (PDT)
Date: Thu, 4 Sep 2025 18:23:50 -0400
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 "Michael S . Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] memory: Fix leaks due to owner-shared MRs circular
 references
Message-ID: <aLoRdtk4RGNMk_fN@x1.local>
References: <20250826221750.285242-1-peterx@redhat.com>
 <CAFEAcA-4pqbqSwiHtpVnRE0taReP7evnwwTtekRMGo307NN=mQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA-4pqbqSwiHtpVnRE0taReP7evnwwTtekRMGo307NN=mQ@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Sep 02, 2025 at 11:06:13AM +0100, Peter Maydell wrote:
> On Tue, 26 Aug 2025 at 23:20, Peter Xu <peterx@redhat.com> wrote:
> >
> > Currently, QEMU refcounts the MR by always taking it from the owner.
> >
> > It's common that one object will have multiple MR objects embeded in the
> > object itself.  All the MRs in this case share the same lifespan of the
> > owner object.
> >
> > It's also common that in the instance_init() of an object, MR A can be a
> > container of MR B, C, D, by using memory_region_add_subregion*() set of
> > memory region APIs.
> >
> > Now we have a circular reference issue, as when adding subregions for MR A,
> > we essentially incremented the owner's refcount within the instance_init(),
> > meaning the object will be self-boosted and its refcount can never go down
> > to zero if the MRs won't get detached properly before object's finalize().
> >
> > Delete subregions within object's finalize() won't work either, because
> > finalize() will be invoked only if the refcount goes to zero first.  What
> > is worse, object_finalize() will do object_property_del_all() first before
> > object_deinit().  Since embeded MRs will be properties of the owner object,
> > it means they'll be freed _before_ the owner's finalize().
> >
> > To fix that, teach memory API to stop refcount on MRs that share the same
> > owner.  Because if they share the lifecycle of the owner, then they share
> > the same lifecycle between themselves, hence the refcount doesn't help but
> > only introduce troubles.
> >
> > Meanwhile, allow auto-detachments of MRs during finalize() of MRs even
> > against its container, as long as they belong to the same owner.
> >
> > The latter is needed because now it's possible to have MRs' finalize()
> > happen in any order when they share the same lifespan with a same owner.
> > In this case, we should allow finalize() to happen in any order of either
> > the parent or child MR.  Loose the mr->container check in MR's finalize()
> > to allow auto-detach.  Double check it shares the same owner.
> >
> > Proper document this behavior in code.
> >
> > This patch is heavily based on the work done by Akihiko Odaki:
> >
> > https://lore.kernel.org/r/CAFEAcA8DV40fGsci76r4yeP1P-SP_QjNRDD2OzPxjx5wRs0GEg@mail.gmail.com
> >
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> 
> I have some wordsmithing review stuff for doc and comment text
> below, but otherwise
> 
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Tested-by: Peter Maydell <peter.maydell@linaro.org>
> 
> > ---
> >  docs/devel/memory.rst |  7 +++++--
> >  system/memory.c       | 45 ++++++++++++++++++++++++++++++++++---------
> >  2 files changed, 41 insertions(+), 11 deletions(-)
> >
> > diff --git a/docs/devel/memory.rst b/docs/devel/memory.rst
> > index 57fb2aec76..a325e97d7b 100644
> > --- a/docs/devel/memory.rst
> > +++ b/docs/devel/memory.rst
> > @@ -158,8 +158,11 @@ ioeventfd) can be changed during the region lifecycle.  They take effect
> >  as soon as the region is made visible.  This can be immediately, later,
> >  or never.
> >
> > -Destruction of a memory region happens automatically when the owner
> > -object dies.
> > +Destruction of a memory region happens automatically when the owner object
> > +dies.  When there are multiple memory regions under the same owner object,
> > +the memory API will guarantee all memory regions will be properly detached
> > +and finalized one by one.  The order which memory region will be finalized
> 
> "The order in which memory regions will be finalized is not
> guaranteed."
> 
> > +first is not guaranteed.
> >
> >  If however the memory region is part of a dynamically allocated data
> >  structure, you should call object_unparent() to destroy the memory region
> > diff --git a/system/memory.c b/system/memory.c
> > index 5646547940..d7f6ad9be2 100644
> > --- a/system/memory.c
> > +++ b/system/memory.c
> > @@ -1796,16 +1796,36 @@ static void memory_region_finalize(Object *obj)
> >  {
> >      MemoryRegion *mr = MEMORY_REGION(obj);
> >
> > -    assert(!mr->container);
> > -
> > -    /* We know the region is not visible in any address space (it
> > -     * does not have a container and cannot be a root either because
> > -     * it has no references, so we can blindly clear mr->enabled.
> > -     * memory_region_set_enabled instead could trigger a transaction
> > -     * and cause an infinite loop.
> > +    /*
> > +     * Each memory region (that can be dynamically freed..) must has an
> 
> s/..//
> s/must has/must have/
> 
> > +     * owner, and it always has the same lifecycle of its owner.  It means
> > +     * when reaching here, the memory region's owner refcount is zero.
> 
> "region's owner's refcount"
> 
> > +     *
> > +     * Here it is possible that the MR has:
> > +     *
> > +     * (1) mr->container set, which means this MR can be a subregion of a
> 
> "this MR is a subregion of"
> 
> > +     *     container MR, in this case it must share the same owner
> 
> s/, in/. In/
> 
> "same owner as that container"
> 
> > +     *     (otherwise the container should have kept a refcount of this
> > +     *     MR's owner), or,
> 
> s/, or,/
> 
> (it's possible for both 1 and 2 to be true for an MR here)
> 
> > +     *
> > +     * (2) mr->subregions non-empty, which means this MR can be a container
> 
> "is a container"

I'll fix all things until here (including Clement's suggestions in the
other email).

> 
> > +     *     of other MRs (share the owner or not).
> 
> "of another MR (which might have the same owner as this MR, or
>  a different owner)"

IIUC there can be one, or more than one MRs as children.  The finalize() of
this MR should release the rest refcounts for all of them if applicable.

Latest version of this paragraph looks like this now:

     * (2) mr->subregions non-empty, which means this MR is a container of
     *     one or more other MRs (which might have the the owner as this
     *     MR, or a different owner).

If above looks good I'll go ahead and merge this patch with the fixups.

Thanks a lot to both for the careful reviews (and tests).

-- 
Peter Xu


