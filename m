Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10E24C5320E
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2024 21:02:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shEw9-0004sF-Qv; Thu, 22 Aug 2024 17:01:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1shEw7-0004rc-Ob
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 17:01:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1shEw4-0005kt-As
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 17:01:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724360494;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=efde3LWqOyjCFrc7ZHmggar11xXbbjmDsLhIopFuTUs=;
 b=N//lTHdZWikTmKNGk1KpdoEvSPuegbxyWiHb1sXxq9jHGDF5L0S7NZBezM+MMfWaIB4NOh
 MsIpnGqOLnc2LvSiikqxCIEc0z+5Pe1OgVNctSqLiyrQCQsr1Qa4Kvpu924By2ROg86212
 WRf/pFOLafogJXzKLPjEC+JYhzElI6o=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-401-eILpo0ajM2qU2VJ1dQXD6A-1; Thu, 22 Aug 2024 17:01:33 -0400
X-MC-Unique: eILpo0ajM2qU2VJ1dQXD6A-1
Received: by mail-oo1-f70.google.com with SMTP id
 006d021491bc7-5c2021e8656so1447788eaf.0
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2024 14:01:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724360492; x=1724965292;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=efde3LWqOyjCFrc7ZHmggar11xXbbjmDsLhIopFuTUs=;
 b=uAkFK8/JcBYaWwJdMA0ctL/p2WPUFI3bIXLiHAliXfUFDSCQMM4ZW6aLHUdkndX2yN
 HEDiRjQZ0V1NaJ0RSg104/qtnzoDuMneJksjM1I3OTe6o+3v8fr0Oo231GSGA/jcFPsT
 7R9pEduiUOlZL6aVNw4OK2u6YhGn/F/jP231EQV+4hsCiWdf3bC5U4MAS562OcMGOXf/
 vcQADQm99vyZ28jRUcsLbSNoH1OOFbXYFq9NnTte+zLUhGv8BX7pwF1kNKe1rqrDB+Sh
 K2rWcxK3TTnscyOqWGReXSmRdYYy3AuqMqf89iUuUPo6ktOpTgstaMRRwQBsjV0cnN0N
 4/Ag==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHRj72hAbfA3DNS2qHwVzTn7K/dJltXVXzinjG5DqXBaOxGRSTlTt/1peT6T2ogiL7cIvKNIyJfI9v@nongnu.org
X-Gm-Message-State: AOJu0YxGJHNITlscNwKqNFTRdRQzFAJafA2UUpUk2hjskzcvaRTutBsA
 nOo0R8MoxvCOsAb1rAo83fUdulZ/wsPOy7BCG+G5GUHgli3wn6RlZgTrP69fpr2lVwZ3R+JXtYm
 cljeZiwaHZ6JyZ7DPBGQ6W1HdnDBaFniLgMR8MvjB/c5SI/p+qRvE
X-Received: by 2002:a05:6870:158c:b0:259:88b4:976 with SMTP id
 586e51a60fabf-273cffcaa26mr3759272fac.43.1724360492233; 
 Thu, 22 Aug 2024 14:01:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtFhc7Mg/Z7Te446IWtU7SO/7j9UcaqP3Lsau2yhVkMUJ/qIZiDIqRenc0/TJYgWZm+Z8knA==
X-Received: by 2002:a05:6870:158c:b0:259:88b4:976 with SMTP id
 586e51a60fabf-273cffcaa26mr3759235fac.43.1724360491772; 
 Thu, 22 Aug 2024 14:01:31 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a67f362282sm109993785a.71.2024.08.22.14.01.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Aug 2024 14:01:31 -0700 (PDT)
Date: Thu, 22 Aug 2024 17:01:30 -0400
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 09/15] memory: Do not create circular reference with
 subregion
Message-ID: <ZsenKpu1czQGYz7m@x1n>
References: <20240627-san-v2-0-750bb0946dbd@daynix.com>
 <20240627-san-v2-9-750bb0946dbd@daynix.com>
 <CAFEAcA9KTSjwF1rABpM5nv9UFuKqZZk6+Qo4PEF4+rTirNi5fQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA9KTSjwF1rABpM5nv9UFuKqZZk6+Qo4PEF4+rTirNi5fQ@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Thu, Aug 22, 2024 at 06:10:43PM +0100, Peter Maydell wrote:
> On Thu, 27 Jun 2024 at 14:40, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
> >
> > A memory region does not use their own reference counters, but instead
> > piggybacks on another QOM object, "owner" (unless the owner is not the
> > memory region itself). When creating a subregion, a new reference to the
> > owner of the container must be created. However, if the subregion is
> > owned by the same QOM object, this result in a self-reference, and make
> > the owner immortal. Avoid such a self-reference.
> >
> > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> > ---
> >  system/memory.c | 11 +++++++++--
> >  1 file changed, 9 insertions(+), 2 deletions(-)
> >
> > diff --git a/system/memory.c b/system/memory.c
> > index 74cd73ebc78b..949f5016a68d 100644
> > --- a/system/memory.c
> > +++ b/system/memory.c
> > @@ -2638,7 +2638,10 @@ static void memory_region_update_container_subregions(MemoryRegion *subregion)
> >
> >      memory_region_transaction_begin();
> >
> > -    memory_region_ref(subregion);
> > +    if (mr->owner != subregion->owner) {
> > +        memory_region_ref(subregion);
> > +    }
> > +
> >      QTAILQ_FOREACH(other, &mr->subregions, subregions_link) {
> >          if (subregion->priority >= other->priority) {
> >              QTAILQ_INSERT_BEFORE(other, subregion, subregions_link);
> > @@ -2696,7 +2699,11 @@ void memory_region_del_subregion(MemoryRegion *mr,
> >          assert(alias->mapped_via_alias >= 0);
> >      }
> >      QTAILQ_REMOVE(&mr->subregions, subregion, subregions_link);
> > -    memory_region_unref(subregion);
> > +
> > +    if (mr->owner != subregion->owner) {
> > +        memory_region_unref(subregion);
> > +    }
> > +
> >      memory_region_update_pending |= mr->enabled && subregion->enabled;
> >      memory_region_transaction_commit();
> >  }
> 
> I was having another look at leaks this week, and I tried
> this patch to see how many of the leaks I was seeing it
> fixed. I found however that for arm it results in an
> assertion when the device-introspection-test exercises
> the "imx7.analog" device. By-hand repro:
> 
> $ ./build/asan/qemu-system-aarch64 -display none -machine none -accel
> qtest -monitor stdio
> ==712838==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> QEMU 9.0.92 monitor - type 'help' for more information
> (qemu) device_add imx7.analog,help
> qemu-system-aarch64: ../../system/memory.c:1777: void
> memory_region_finalize(Object *): Assertion `!mr->container' failed.
> Aborted (core dumped)
> 
> It may be well be that this is a preexisting bug that's only
> exposed by this refcount change causing us to actually try
> to dispose of the memory regions.
> 
> I think that what's happening here is that the device
> object has multiple MemoryRegions, each of which is a child
> QOM property. One of these MRs is a "container MR", and the
> other three are actual-content MRs which the device put into
> the container when it created them. When we deref the device,
> we go through all the child QOM properties unparenting and
> unreffing them. However, there's no particular ordering
> here, and it happens that we try to unref one of the
> actual-content MRs first. That MR is still inside the
> container MR, so we hit the assert. If we had happened to
> unref the container MR first then memory_region_finalize()
> would have removed all the subregions from it, avoiding
> the problem.
> 
> I'm not sure what the best fix would be here -- that assert
> is there as a guard that the region isn't visible in
> any address space, so maybe it needs to be made a bit
> cleverer about the condition it checks? e.g. in this
> example although mr->container is not NULL,
> mr->container->container is NULL.

If we keep looking at ->container we'll always see NULL, IIUC, because
either it's removed from its parent MR so it's NULL already, or at some
point it can start to point to a root mr of an address space, where should
also be NULL, afaiu.

> Or we could check whether the mr->container->owner is the same as the
> mr->owner and allow a non-NULL mr->container in that case.  I don't know
> this subsystem well enough so I'm just making random stabs here, though.

If with the assumption of this patch applied, then looks like it's pretty
legal a container MR and the child MRs be finalized in any order when the
owner device is being destroyed.

IIUC the MR should be destined to be invisible until this point, with or
without the fact that mr->container is NULL.  It's because anyone who
references the MR should do memory_region_ref() first, which takes the
owner's refcount.  Here if MR finalize() is reached I think it means the
owner refcount must be zero.  So it looks to me the only possible case when
mr->container is non-NULL is it's used internally like this.  Then it's
invisible and also safe to be detached even if container != NULL.

So.. I wonder whether below would make sense, on top of this existing
patch.

===8<===
diff --git a/system/memory.c b/system/memory.c
index 1c00df8305..54a9d9e5f9 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -1771,16 +1771,23 @@ static void memory_region_finalize(Object *obj)
 {
     MemoryRegion *mr = MEMORY_REGION(obj);
 
-    assert(!mr->container);
-
-    /* We know the region is not visible in any address space (it
-     * does not have a container and cannot be a root either because
-     * it has no references, so we can blindly clear mr->enabled.
-     * memory_region_set_enabled instead could trigger a transaction
-     * and cause an infinite loop.
+    /*
+     * We know the region is not visible in any address space, because
+     * normally MR's finalize() should be invoked by finalize() of the
+     * owner, which will remove all the properties including the MRs, and
+     * that can only happen when prior memory_region_ref() of the MR (which
+     * will ultimately take the owner's refcount) from elsewhere got
+     * properly released.
+     *
+     * So we can blindly clear mr->enabled, unlink both the upper container
+     * or all subregions.  memory_region_set_enabled() won't work instead,
+     * as it could trigger a transaction and cause an infinite loop.
      */
     mr->enabled = false;
     memory_region_transaction_begin();
+    if (mr->container) {
+        memory_region_del_subregion(mr->container, mr);
+    }
     while (!QTAILQ_EMPTY(&mr->subregions)) {
         MemoryRegion *subregion = QTAILQ_FIRST(&mr->subregions);
===8<===

Thanks,

-- 
Peter Xu


