Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A47F9C54FAA
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 13:09:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjIQN-0004e6-Bd; Wed, 28 Aug 2024 09:09:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sjIQF-00049g-TN
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 09:09:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sjIQB-000715-Rb
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 09:09:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724850550;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iuM79O4Hv78iWBIWnJ3/Kio2nK78UC7bS9uS/gG4KLI=;
 b=cKtJwxGQnemQd3BJcKRX0fuBxwTALbrIwyPIlbKPeyF1EeWXL1KiP441u6Ps/Jira6RZqe
 hKSnFTmQLyy5zt4OY662rr9CAjL2S9V2LT+G/JNat4HBUklKrR1WjsSM6GwfejtGyY5vx3
 drVxbGI3+nCBbHZD+7u4eJbjOHpbloA=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-FsI5De4LNmakgYBul3ntSg-1; Wed, 28 Aug 2024 09:09:09 -0400
X-MC-Unique: FsI5De4LNmakgYBul3ntSg-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-44ff196bbfaso86108551cf.3
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2024 06:09:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724850549; x=1725455349;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iuM79O4Hv78iWBIWnJ3/Kio2nK78UC7bS9uS/gG4KLI=;
 b=mhbuMbGsTsowuZnfqsmKJ9n/px0IN6eA1yQmY1svUujxoIj45WJviePUH80HVMcN5w
 lakzw5yIJTGRe1kWfVq3tFEIGdUoWjglUhm61MTDdezOnYtNEvixvkqRJE5v5CpUaL+K
 H7L0DNWng1/Gb0AOwmmVISCTLpJFLPmDivaZXrVNueQ4btpJAp/Olsa0BoWnUchwSH+u
 t+VP1BOOdxw/SibSVDz9bjsc8xfE/MY68RSLMj7dIXATcjOUQhamvlxx3byfdmczFn6T
 wDAoPKqzo7eOAioQU1HG49b8aP3X5opN9iJe7ADeFl3zL8LeJedH0qoQ3kj79BvaG0t2
 2rCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWr40cST++PX66ckdurYiapouhhhdC2TH0v3Et6xp3LzTw2kjMzwzWKXRWo4tITG0PUGPwrUUBbESQH@nongnu.org
X-Gm-Message-State: AOJu0YzBRKw61U+Z/zUTZg3VEuzcimCFvkPpj962kwX4oEUZhk8DTqVc
 dE8sowUpmYltesSqUhly/l+s2bshzTbgBCYV9Rdh0HqLgFTURaZiPuPtcmE4dfuW3JCJA3wnIat
 P/gcGSPvKoY+/43myxvjrx8Xvz42Ow0luqHTdX8MI82nQZlGWzJmt
X-Received: by 2002:ac8:7112:0:b0:455:b4a:b108 with SMTP id
 d75a77b69052e-4550b4ab226mr145525671cf.20.1724850548674; 
 Wed, 28 Aug 2024 06:09:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWCASlwggnP35I2tuRG/t8XXAT6Mgf2M9YWje+Q91sqYI8c2tjD5GpJrx2iZt6o2UWY4dx2g==
X-Received: by 2002:ac8:7112:0:b0:455:b4a:b108 with SMTP id
 d75a77b69052e-4550b4ab226mr145525391cf.20.1724850548208; 
 Wed, 28 Aug 2024 06:09:08 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-454fe1b78absm61354971cf.86.2024.08.28.06.09.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2024 06:09:07 -0700 (PDT)
Date: Wed, 28 Aug 2024 09:09:04 -0400
From: Peter Xu <peterx@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, John Snow <jsnow@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org
Subject: Re: [PATCH v4 6/7] memory: Do not create circular reference with
 subregion
Message-ID: <Zs8hcLPU62Hj8x-W@x1n>
References: <20240823-san-v4-0-a24c6dfa4ceb@daynix.com>
 <20240823-san-v4-6-a24c6dfa4ceb@daynix.com> <Zsydli9ME1u79A9X@x1n>
 <CAFEAcA_uT3Db22V=Anqci_k6zOaAV7Qua2S1OVFxW_DQyh3bAA@mail.gmail.com>
 <Zszain3SH5cl9ohH@x1n>
 <161cb8ff-1479-4fc4-8803-d665e757007a@daynix.com>
 <Zs36od036pyxvQlZ@x1n>
 <de2229bc-876e-47b2-8a59-18fe7ffe3936@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <de2229bc-876e-47b2-8a59-18fe7ffe3936@daynix.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Wed, Aug 28, 2024 at 02:33:59PM +0900, Akihiko Odaki wrote:
> On 2024/08/28 1:11, Peter Xu wrote:
> > On Tue, Aug 27, 2024 at 01:14:51PM +0900, Akihiko Odaki wrote:
> > > On 2024/08/27 4:42, Peter Xu wrote:
> > > > On Mon, Aug 26, 2024 at 06:10:25PM +0100, Peter Maydell wrote:
> > > > > On Mon, 26 Aug 2024 at 16:22, Peter Xu <peterx@redhat.com> wrote:
> > > > > > 
> > > > > > On Fri, Aug 23, 2024 at 03:13:11PM +0900, Akihiko Odaki wrote:
> > > > > > > memory_region_update_container_subregions() used to call
> > > > > > > memory_region_ref(), which creates a reference to the owner of the
> > > > > > > subregion, on behalf of the owner of the container. This results in a
> > > > > > > circular reference if the subregion and container have the same owner.
> > > > > > > 
> > > > > > > memory_region_ref() creates a reference to the owner instead of the
> > > > > > > memory region to match the lifetime of the owner and memory region. We
> > > > > > > do not need such a hack if the subregion and container have the same
> > > > > > > owner because the owner will be alive as long as the container is.
> > > > > > > Therefore, create a reference to the subregion itself instead ot its
> > > > > > > owner in such a case; the reference to the subregion is still necessary
> > > > > > > to ensure that the subregion gets finalized after the container.
> > > > > > > 
> > > > > > > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> > > > > > > ---
> > > > > > >    system/memory.c | 8 ++++++--
> > > > > > >    1 file changed, 6 insertions(+), 2 deletions(-)
> > > > > > > 
> > > > > > > diff --git a/system/memory.c b/system/memory.c
> > > > > > > index 5e6eb459d5de..e4d3e9d1f427 100644
> > > > > > > --- a/system/memory.c
> > > > > > > +++ b/system/memory.c
> > > > > > > @@ -2612,7 +2612,9 @@ static void memory_region_update_container_subregions(MemoryRegion *subregion)
> > > > > > > 
> > > > > > >        memory_region_transaction_begin();
> > > > > > > 
> > > > > > > -    memory_region_ref(subregion);
> > > > > > > +    object_ref(mr->owner == subregion->owner ?
> > > > > > > +               OBJECT(subregion) : subregion->owner);
> > > > > > 
> > > > > > The only place that mr->refcount is used so far is the owner with the
> > > > > > object property attached to the mr, am I right (ignoring name-less MRs)?
> > > > > > 
> > > > > > I worry this will further complicate refcounting, now we're actively using
> > > > > > two refcounts for MRs..
> > > 
> > > The actor of object_ref() is the owner of the memory region also in this
> > > case. We are calling object_ref() on behalf of mr->owner so we use
> > > mr->refcount iff mr->owner == subregion->owner. In this sense there is only
> > > one user of mr->refcount even after this change.
> > 
> > Yes it's still one user, but it's not that straightforward to see, also
> > it's still an extension to how we use mr->refcount right now.  Currently
> > it's about "true / false" just to describe, now it's a real counter.
> > 
> > I wished that counter doesn't even exist if we'd like to stick with device
> > / owner's counter.  Adding this can definitely also make further effort
> > harder if we want to remove mr->refcount.
> 
> I don't think it will make removing mr->refcount harder. With this change,
> mr->refcount will count the parent and container. If we remove mr->refcount,
> we need to trigger object_finalize() in a way other than checking
> mr->refcount, which can be achieved by simply evaluating OBJECT(mr)->parent
> && mr->container.
> 
> > 
> > > 
> > > > > > 
> > > > > > Continue discussion there:
> > > > > > 
> > > > > > https://lore.kernel.org/r/067b17a4-cdfc-4f7e-b7e4-28c38e1c10f0@daynix.com
> > > > > > 
> > > > > > What I don't see is how mr->subregions differs from mr->container, so we
> > > > > > allow subregions to be attached but not the container when finalize()
> > > > > > (which is, afaict, the other way round).
> > > > > > 
> > > > > > It seems easier to me that we allow both container and subregions to exist
> > > > > > as long as within the owner itself, rather than start heavier use of
> > > > > > mr->refcount.
> > > > > 
> > > > > I don't think just "same owner" necessarily will be workable --
> > > > > you can have a setup like:
> > > > >     * device A has a container C_A
> > > > >     * device A has a child-device B
> > > > >     * device B has a memory region R_B
> > > > >     * device A's realize method puts R_B into C_A
> > > > > 
> > > > > R_B's owner is B, and the container's owner is A,
> > > > > but we still want to be able to get rid of A (in the process
> > > > > getting rid of B because it gets unparented and unreffed,
> > > > > and R_B and C_A also).
> > > > 
> > > > For cross-device references, should we rely on an explicit call to
> > > > memory_region_del_subregion(), so as to detach the link between C_A and
> > > > R_B?
> > > 
> > > Yes, I agree.
> > > 
> > > > 
> > > > My understanding so far: logically when MR finalize() it should guarantee
> > > > both (1) mr->container==NULL, and (2) mr->subregions empty.  That's before
> > > > commit 2e2b8eb70fdb7dfb and could be the ideal world (though at the very
> > > > beginning we don't assert on ->container==NULL yet).  It requires all
> > > > device emulations to do proper unrealize() to unlink all the MRs.
> > > > 
> > > > However what I'm guessing is QEMU probably used to have lots of devices
> > > > that are not following the rules and leaking these links.  Hence we have
> > > > had 2e2b8eb70fdb7dfb, allowing that to happen as long as it's safe, and
> > > > it's justified by comment in 2e2b8eb70fdb7dfb on why it's safe.
> > > > 
> > > > What I was thinking is this comment seems to apply too to mr->container, so
> > > > that it should be safe too to unlink ->container the same way as its own
> > > > subregions. >
> > > > IIUC that means for device-internal MR links we should be fine leaving
> > > > whatever link between MRs owned by such device; the device->refcount
> > > > guarantees none of them will be visible in any AS.  But then we need to
> > > > always properly unlink the MRs when the link is across >1 device owners,
> > > > otherwise it's prone to leak.
> > > 
> > > There is one principle we must satisfy in general: keep a reference to a
> > > memory region if it is visible to the guest.
> > > 
> > > It is safe to call memory_region_del_subregion() and to trigger the
> > > finalization of subregions when the container is not referenced because they
> > > are no longer visible. This is not true for the other way around; even when
> > > subregions are not referenced by anyone else, they are still visible to the
> > > guest as long as the container is visible to the guest. It is not safe to
> > > unref and finalize them in such a case.
> > > 
> > > A memory region and its owner will leak if a memory region kept visible for
> > > a too long period whether the chain of reference contains a
> > > container/subregion relationship or not.
> > 
> > Could you elaborate why it's still visible to the guest if
> > owner->refcount==0 && mr->container!=NULL?
> > 
> > Firstly, mr->container != NULL means the MR has an user indeed.  It's the
> > matter of who's using it.  If that came from outside this device, it should
> > require memory_region_ref(mr) before hand when adding the subregion, and
> > that will hold one reference on the owner->refcount.
> > 
> > Here owner->refcount==0 means there's no such reference, so it seems to me
> > it's guaranteed to not be visible to anything outside of this device / owner.
> > Then from that POV it's safe to unlink when the owner is finalizing just
> > like what we do with mr->subregions, no?
> 
> An object is alive during instance_finalize even though its refcount == 0.
> We can't assume all memory regions are dead even if owner->refcount == 0
> because of that.

When you referred to "an object", do you mean the MR being finalized here?

IIUC when the MR reaches its finalize(), it should mean it's not live
anymore.

We have two forms of MR usages right now: either embeded in another Object
/ Device, or dynamically, like VFIOQuirk.

When used embeded, the MR is only finalized when being removed from the
object's property list, that should only happen when the object / device
triggered finalize().  Since the MR will use the owner->refcount so I
suppose it means the MR is not live anymore.

When used dynamically, object_unparent() is needed but that should only
happen when the object / owner is during finalize(), per document:

        If however the memory region is part of a dynamically allocated
        data structure, you should call object_unparent() to destroy the
        memory region before the data structure is freed.  For an example
        see VFIOMSIXInfo and VFIOQuirk in hw/vfio/pci.c.

Then the MR is also not live.

> In particular, docs/devel/memory.rst says you can call object_unparent()
> in the instance_finalize of the owner. This assumes a memory region will
> not vanish during the execution of the function unless object_unparent()
> is already called for the memory region.

Yes, the MR will not vanish during finalize() of the owner object. However
I don't think it's "live"?  Again, it's based on my definition of
"liveness" as "taking one refcount of its owner", here the owner refcount
is zero.  IOW, I don't expect it to be accessible anywhere from any address
space (e.g. address_space_map()), because they'll all use
memory_region_ref() and that'll ultimately stops the owner from being
finalized.

Thanks,

-- 
Peter Xu


