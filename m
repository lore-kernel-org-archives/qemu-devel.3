Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCE20C54731
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 16:12:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1siyn5-0007eJ-U5; Tue, 27 Aug 2024 12:11:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1siyn4-0007cZ-1D
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 12:11:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1siyn0-0007YH-HF
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 12:11:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724775082;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Emi7GzldYpNp3zL7GMCh31+uwJG1ZeK0oNtY8PDHCAM=;
 b=TOiO9eXrnTW2Qf64e3+nYIGxD2oFeOxVIM5b/A+dVwpaXWp+Yjl2+yZpZhKO0JASsvb8lq
 ZfjjITiTngIvaq0W14kSXz0jhclI+Gpyo2m+Bv3UZREYwbZRjYxmItK1/Is5GSBfmRh2TW
 J42xrBvpdLJ5LfKkOS88SSJVjVFOxHs=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-464-7oAtVqOGOICDFb05v_ahtg-1; Tue, 27 Aug 2024 12:11:18 -0400
X-MC-Unique: 7oAtVqOGOICDFb05v_ahtg-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-44ffce7ed6aso82213691cf.3
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2024 09:11:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724775078; x=1725379878;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Emi7GzldYpNp3zL7GMCh31+uwJG1ZeK0oNtY8PDHCAM=;
 b=ticidv1MTPNqcVcrRAwcCIn/VcY4TO709VGYSk6QmETK4OWv09yuforKKPs0KtkJdI
 xlvs/0C45NRuOzB148K1I9RNJudeZXkHKu2zAYp3KnZsExMoUedEA4TAvsFO/u/aD6uV
 sTDihKHDzhtpLdGmmkP5NRqQ4xnQGHNlkMOTDNor4GRHNIESW+wFaeegCjdtYGmLEH6y
 gXLnppuBOclvLJX0HbB7f/5I159oj+H2TZJ3ANBhpKPmT7AT/LxEOo0H7zKILE8t/wlo
 5zLGcchUjFcA2ncAz1xpbjxGn0NfDQ+MuzlaZQX/pPxwMxWl1NXkXhi0MA3xQfUbuP/q
 mZng==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQRR+bHNp7Czz6mht4Wq7Y1jp4WJHf6a12xTxqJGUes607IUg2mG1LKbG9KDyj6x4bldxv1k/OqGZa@nongnu.org
X-Gm-Message-State: AOJu0YxU6REuzN9Gck3yAMKlIXIgnwgpaPK+Oz72zxBdr4kuR1IS/6i9
 9fpuk2zMKuQaHesP0lA2tVcsdHpMsLyE0vl9IGwuFbhxmxNUr2H2sZUi7HpDUAAW9JKF+FTKza0
 ke1w5b2rHpfwxhpcdCLMQNYL9ufd0xv90d4lepp4gNAeXX7vRe5fy
X-Received: by 2002:a05:622a:4d95:b0:447:f469:b58d with SMTP id
 d75a77b69052e-455097bc89cmr155564811cf.42.1724775077689; 
 Tue, 27 Aug 2024 09:11:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZC8dHsoGQmPp4jXL6gcFd4xcw8Ev9lhouj12fkhhPHLtba3PIeFskWezv42IDgJRabMH/5A==
X-Received: by 2002:a05:622a:4d95:b0:447:f469:b58d with SMTP id
 d75a77b69052e-455097bc89cmr155564371cf.42.1724775077259; 
 Tue, 27 Aug 2024 09:11:17 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-454fe0f436dsm54534591cf.49.2024.08.27.09.11.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2024 09:11:16 -0700 (PDT)
Date: Tue, 27 Aug 2024 12:11:13 -0400
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
Message-ID: <Zs36od036pyxvQlZ@x1n>
References: <20240823-san-v4-0-a24c6dfa4ceb@daynix.com>
 <20240823-san-v4-6-a24c6dfa4ceb@daynix.com> <Zsydli9ME1u79A9X@x1n>
 <CAFEAcA_uT3Db22V=Anqci_k6zOaAV7Qua2S1OVFxW_DQyh3bAA@mail.gmail.com>
 <Zszain3SH5cl9ohH@x1n>
 <161cb8ff-1479-4fc4-8803-d665e757007a@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <161cb8ff-1479-4fc4-8803-d665e757007a@daynix.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Tue, Aug 27, 2024 at 01:14:51PM +0900, Akihiko Odaki wrote:
> On 2024/08/27 4:42, Peter Xu wrote:
> > On Mon, Aug 26, 2024 at 06:10:25PM +0100, Peter Maydell wrote:
> > > On Mon, 26 Aug 2024 at 16:22, Peter Xu <peterx@redhat.com> wrote:
> > > > 
> > > > On Fri, Aug 23, 2024 at 03:13:11PM +0900, Akihiko Odaki wrote:
> > > > > memory_region_update_container_subregions() used to call
> > > > > memory_region_ref(), which creates a reference to the owner of the
> > > > > subregion, on behalf of the owner of the container. This results in a
> > > > > circular reference if the subregion and container have the same owner.
> > > > > 
> > > > > memory_region_ref() creates a reference to the owner instead of the
> > > > > memory region to match the lifetime of the owner and memory region. We
> > > > > do not need such a hack if the subregion and container have the same
> > > > > owner because the owner will be alive as long as the container is.
> > > > > Therefore, create a reference to the subregion itself instead ot its
> > > > > owner in such a case; the reference to the subregion is still necessary
> > > > > to ensure that the subregion gets finalized after the container.
> > > > > 
> > > > > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> > > > > ---
> > > > >   system/memory.c | 8 ++++++--
> > > > >   1 file changed, 6 insertions(+), 2 deletions(-)
> > > > > 
> > > > > diff --git a/system/memory.c b/system/memory.c
> > > > > index 5e6eb459d5de..e4d3e9d1f427 100644
> > > > > --- a/system/memory.c
> > > > > +++ b/system/memory.c
> > > > > @@ -2612,7 +2612,9 @@ static void memory_region_update_container_subregions(MemoryRegion *subregion)
> > > > > 
> > > > >       memory_region_transaction_begin();
> > > > > 
> > > > > -    memory_region_ref(subregion);
> > > > > +    object_ref(mr->owner == subregion->owner ?
> > > > > +               OBJECT(subregion) : subregion->owner);
> > > > 
> > > > The only place that mr->refcount is used so far is the owner with the
> > > > object property attached to the mr, am I right (ignoring name-less MRs)?
> > > > 
> > > > I worry this will further complicate refcounting, now we're actively using
> > > > two refcounts for MRs..
> 
> The actor of object_ref() is the owner of the memory region also in this
> case. We are calling object_ref() on behalf of mr->owner so we use
> mr->refcount iff mr->owner == subregion->owner. In this sense there is only
> one user of mr->refcount even after this change.

Yes it's still one user, but it's not that straightforward to see, also
it's still an extension to how we use mr->refcount right now.  Currently
it's about "true / false" just to describe, now it's a real counter.

I wished that counter doesn't even exist if we'd like to stick with device
/ owner's counter.  Adding this can definitely also make further effort
harder if we want to remove mr->refcount.

> 
> > > > 
> > > > Continue discussion there:
> > > > 
> > > > https://lore.kernel.org/r/067b17a4-cdfc-4f7e-b7e4-28c38e1c10f0@daynix.com
> > > > 
> > > > What I don't see is how mr->subregions differs from mr->container, so we
> > > > allow subregions to be attached but not the container when finalize()
> > > > (which is, afaict, the other way round).
> > > > 
> > > > It seems easier to me that we allow both container and subregions to exist
> > > > as long as within the owner itself, rather than start heavier use of
> > > > mr->refcount.
> > > 
> > > I don't think just "same owner" necessarily will be workable --
> > > you can have a setup like:
> > >    * device A has a container C_A
> > >    * device A has a child-device B
> > >    * device B has a memory region R_B
> > >    * device A's realize method puts R_B into C_A
> > > 
> > > R_B's owner is B, and the container's owner is A,
> > > but we still want to be able to get rid of A (in the process
> > > getting rid of B because it gets unparented and unreffed,
> > > and R_B and C_A also).
> > 
> > For cross-device references, should we rely on an explicit call to
> > memory_region_del_subregion(), so as to detach the link between C_A and
> > R_B?
> 
> Yes, I agree.
> 
> > 
> > My understanding so far: logically when MR finalize() it should guarantee
> > both (1) mr->container==NULL, and (2) mr->subregions empty.  That's before
> > commit 2e2b8eb70fdb7dfb and could be the ideal world (though at the very
> > beginning we don't assert on ->container==NULL yet).  It requires all
> > device emulations to do proper unrealize() to unlink all the MRs.
> > 
> > However what I'm guessing is QEMU probably used to have lots of devices
> > that are not following the rules and leaking these links.  Hence we have
> > had 2e2b8eb70fdb7dfb, allowing that to happen as long as it's safe, and
> > it's justified by comment in 2e2b8eb70fdb7dfb on why it's safe.
> > 
> > What I was thinking is this comment seems to apply too to mr->container, so
> > that it should be safe too to unlink ->container the same way as its own
> > subregions. >
> > IIUC that means for device-internal MR links we should be fine leaving
> > whatever link between MRs owned by such device; the device->refcount
> > guarantees none of them will be visible in any AS.  But then we need to
> > always properly unlink the MRs when the link is across >1 device owners,
> > otherwise it's prone to leak.
> 
> There is one principle we must satisfy in general: keep a reference to a
> memory region if it is visible to the guest.
> 
> It is safe to call memory_region_del_subregion() and to trigger the
> finalization of subregions when the container is not referenced because they
> are no longer visible. This is not true for the other way around; even when
> subregions are not referenced by anyone else, they are still visible to the
> guest as long as the container is visible to the guest. It is not safe to
> unref and finalize them in such a case.
> 
> A memory region and its owner will leak if a memory region kept visible for
> a too long period whether the chain of reference contains a
> container/subregion relationship or not.

Could you elaborate why it's still visible to the guest if
owner->refcount==0 && mr->container!=NULL?

Firstly, mr->container != NULL means the MR has an user indeed.  It's the
matter of who's using it.  If that came from outside this device, it should
require memory_region_ref(mr) before hand when adding the subregion, and
that will hold one reference on the owner->refcount.

Here owner->refcount==0 means there's no such reference, so it seems to me
it's guaranteed to not be visible to anything outside of this device / owner.
Then from that POV it's safe to unlink when the owner is finalizing just
like what we do with mr->subregions, no?

-- 
Peter Xu


