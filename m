Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69269C3271E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 16:42:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQrQ2-0004VD-86; Mon, 08 Jul 2024 12:40:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sQrPr-0004PR-00
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 12:40:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sQrPj-0006fe-PT
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 12:40:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720456830;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=82QSr8yMWdaSe+3MZ74RhaXd+PtGZ+J9sQJR79iB+lE=;
 b=WFmmGOB794CVjTEL9Q/WmA1VMFYtDc2K6d9MfwQkKrvkrFPlxsP5xIJNqE82mUrb8iJZNP
 E4MDeJoxSfICms3vMyTGU8iTNdqQOY9JP3crne84mcDtNz8wzoQ9s36mshlIIesyXifOfQ
 nqMq7UQwpGRLL/b015/cVzIRDDUHZrM=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-28-QmmdWftePE-yPAMcdiv9Pg-1; Mon, 08 Jul 2024 12:40:28 -0400
X-MC-Unique: QmmdWftePE-yPAMcdiv9Pg-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6b5dc283dcfso2169876d6.2
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2024 09:40:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720456828; x=1721061628;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=82QSr8yMWdaSe+3MZ74RhaXd+PtGZ+J9sQJR79iB+lE=;
 b=hr5Jv3YwR5bqdtn+j10oB9gbehZunKuNhxNFa3Eto+FqZxDg0fAHhwLSL2DTRQXDSQ
 UN0htYEsxiMaMFb/JHw5kVqEAHS9KXHnPg3q3cCjhqTYW/dmZk3bBxOw+mXFDfLBmv/B
 byTNscp1uTX3bSPA+GU+n8SXet6S4XdlYYhPtCKyXjTHxwtAh5dITGZ51lMmAlg+Cul7
 6GGfnFvs6uJn5rJj2nNZSuElatAzvk3FDprcjv4Y4kRlcWGuGw9B6sf6zBm+DPiNav7z
 ZC3BnA8NgOkq8nVJEiO5WdGVmRizH9vZOAQhc02ODDb3WXwJJfPpHxb3Mimlc0lYxOb5
 QQhg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlv2TfPniZ6RGDKgVu3qVc9ozG0n8hdFfeQdHR1Rre8U6gBEYpOmh9mjK2CRqI308dKaZaRpZzYCleLcRbOIpzkHSS7e0=
X-Gm-Message-State: AOJu0YwZ7T8yhMwVGlDEEGktIXT6qCrq+dusv2KpuJuvsIHQ5lD9ha9Z
 XlZejfzlQNaJhmNTlxazmNqvpahG8WW9avWZMCWIHYQmxATNZnQp5B7RE2OcTHpXxcqGRpkLUrd
 BA1y0N6DLbu+6iQ4Kn7p42dU918S3a1J7I1BDcTNQHTCRlf8mancm
X-Received: by 2002:ad4:4e02:0:b0:6b2:b53a:5ef3 with SMTP id
 6a1803df08f44-6b61c1b4c5cmr2433206d6.3.1720456827565; 
 Mon, 08 Jul 2024 09:40:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDi41IDyAmKj1ejW5sJeKc2k5FDuShvGEVfw0xk47bV5rseN4cyz/oGYSOj8hf/n7/E6bn8A==
X-Received: by 2002:ad4:4e02:0:b0:6b2:b53a:5ef3 with SMTP id
 6a1803df08f44-6b61c1b4c5cmr2432886d6.3.1720456827098; 
 Mon, 08 Jul 2024 09:40:27 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b61ba8d8e1sm897826d6.124.2024.07.08.09.40.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jul 2024 09:40:26 -0700 (PDT)
Date: Mon, 8 Jul 2024 12:40:23 -0400
From: Peter Xu <peterx@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
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
Subject: Re: [PATCH v2 09/15] memory: Do not create circular reference with
 subregion
Message-ID: <ZowWd7VR56QkWH3g@x1n>
References: <20240627-san-v2-0-750bb0946dbd@daynix.com>
 <20240627-san-v2-9-750bb0946dbd@daynix.com> <ZoQ8cCrPXgK8I6b6@x1n>
 <84a7b513-228c-4c8e-8519-6ab465d4e8c8@daynix.com>
 <f52c6660-3a1c-449e-93c0-07e4cefebef3@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f52c6660-3a1c-449e-93c0-07e4cefebef3@linaro.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, Jul 08, 2024 at 10:06:44AM +0200, Philippe Mathieu-Daudé wrote:
> On 6/7/24 13:59, Akihiko Odaki wrote:
> > On 2024/07/03 2:44, Peter Xu wrote:
> > > On Thu, Jun 27, 2024 at 10:37:52PM +0900, Akihiko Odaki wrote:
> > > > A memory region does not use their own reference counters, but instead
> > > > piggybacks on another QOM object, "owner" (unless the owner is not the
> > > > memory region itself). When creating a subregion, a new reference to the
> > > > owner of the container must be created. However, if the subregion is
> > > > owned by the same QOM object, this result in a self-reference, and make
> > > > the owner immortal. Avoid such a self-reference.
> > > > 
> > > > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> > > > ---
> > > >   system/memory.c | 11 +++++++++--
> > > >   1 file changed, 9 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/system/memory.c b/system/memory.c
> > > > index 74cd73ebc78b..949f5016a68d 100644
> > > > --- a/system/memory.c
> > > > +++ b/system/memory.c
> > > > @@ -2638,7 +2638,10 @@ static void
> > > > memory_region_update_container_subregions(MemoryRegion
> > > > *subregion)
> > > >       memory_region_transaction_begin();
> > > > -    memory_region_ref(subregion);
> > > > +    if (mr->owner != subregion->owner) {
> > > > +        memory_region_ref(subregion);
> > > > +    }
> > > > +
> > > >       QTAILQ_FOREACH(other, &mr->subregions, subregions_link) {
> > > >           if (subregion->priority >= other->priority) {
> > > >               QTAILQ_INSERT_BEFORE(other, subregion, subregions_link);
> > > > @@ -2696,7 +2699,11 @@ void
> > > > memory_region_del_subregion(MemoryRegion *mr,
> > > >           assert(alias->mapped_via_alias >= 0);
> > > >       }
> > > >       QTAILQ_REMOVE(&mr->subregions, subregion, subregions_link);
> > > > -    memory_region_unref(subregion);
> > > > +
> > > > +    if (mr->owner != subregion->owner) {
> > > > +        memory_region_unref(subregion);
> > > > +    }
> > > > +
> > > >       memory_region_update_pending |= mr->enabled && subregion->enabled;
> > > >       memory_region_transaction_commit();
> > > >   }
> > > 
> > > This does look like a real issue.. the patch looks reasonable to me,
> > > but I
> > > wonder whether we should start to add some good comments in code to
> > > reflect
> > > that complexity starting from this one.  The MR refcount isn't easy to
> > > understand to me.
> > > 
> > > It also lets me start to wonder how MR refcount went through until
> > > it looks
> > > like today..  It's definitely not extremely intuitive to use mr->owner as
> > > the object to do refcounting if mr itself does has its own QObject,
> > > meanwhile it has other tricks around.
> > > 
> > > E.g. the first thing I stumbled over when looking was the optimization
> > > where we will avoid refcounting the mr when there's no owner, and IIUC it
> > > was for the case when the "guest memory" (which will never be freed) used
> > > to have no owner so we can speedup DMA if we know it won't go away.
> > > 
> > > https://lore.kernel.org/qemu-devel/1450263601-2828-5-git-send-email-pbonzini@redhat.com/
> > > 
> > > commit 612263cf33062f7441a5d0e3b37c65991fdc3210
> > > Author: Paolo Bonzini <pbonzini@redhat.com>
> > > Date:   Wed Dec 9 11:44:25 2015 +0100
> > > 
> > >      memory: avoid unnecessary object_ref/unref
> > >      For the common case of DMA into non-hotplugged RAM, it is
> > > unnecessary
> > >      but expensive to do object_ref/unref.  Add back an owner field to
> > >      MemoryRegion, so that these memory regions can skip the reference
> > >      counting.
> > > 
> > > If so, it looks like it will stop working with memory-backends get
> > > involved?  As I think those MRs will have owner set always, and I wonder
> > > whether memory-backends should be the major way to specify guest
> > > memory now
> > > and in the future.  So I'm not sure how important that optimization is as
> > > of now, and whether we could "simplify" it back to always do the refcount
> > > if the major scenarios will not adopt it.
> > > 
> > > The other issue is we used owner refcount from the start of
> > > memory_region_ref() got introduced, since:
> > > 
> > > commit 46637be269aaaceb9867ffdf176e906401138fff
> > > Author: Paolo Bonzini <pbonzini@redhat.com>
> > > Date:   Tue May 7 09:06:00 2013 +0200
> > > 
> > >      memory: add ref/unref
> > > 
> > > And we still have that in our document, even though I don't think
> > > it's true
> > > anymore:
> > > 
> > >   * ...  MemoryRegions actually do not have their
> > >   * own reference count; they piggyback on a QOM object, their "owner".
> > >   * This function adds a reference to the owner.
> > > 
> > > It looks like what happened is when introduced the change, MR is not
> > > a QOM
> > > object yet.  But it later is..
> > > 
> > > I mentioned all these only because I found that _if_ we can keep mr
> > > refcounting as simple as other objects:
> > > 
> > > memory_region_ref(mr)
> > > {
> > >      object_ref(OBJECT(mr));
> > > }
> > > 
> > > Then looks like this "recursive refcount" problem can also go away.  I'm
> > > curious whether you or anyone tried to explore that path, or whether
> > > above
> > > doesn't make sense at all.
> > 
> > It unfortunately does not solve the problem.
> > 
> > The underlying problem is that the whole device must be kept alive while
> > its memory region are. Indeed MemoryRegions do have refcounts, but
> > incrementing them do not extend the lifetime of the devices (i.e., the
> > owners). The refcount of the owners must be incremented for correctness.
> > 
> > Referencing a subregion MemoryRegion from its container MemoryRegion
> > owned by the same device is an exceptional case. Incrementing the
> > refcount of the owner extends the owner's lifetime to forever.
> 
> Is it really an exceptional case?
> 
> What I'm seeing are a lot of devices creating MR and never bother
> to destroy them, so indeed owner (device) refcount never reaches 0.
> 
> Most of the time when we create MR in .instance_init/.realize,
> we neglect to implement the undo path (.instance_finalize or
> .unrealize).

Right.  The cross-reference of MR <-> device makes sense from the concept
level, but I'm not sure how much we rely on that from QEMU perspective
currently.  It complicates refcount and looks like it needs some thoughts.

One proof is, when I replied I actually tested all qemu qtests with below
patch and nothing yet explode:

===8<===
diff --git a/system/memory.c b/system/memory.c
index 2d69521360..a1d2c1f808 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -1801,26 +1801,12 @@ Object *memory_region_owner(MemoryRegion *mr)
 
 void memory_region_ref(MemoryRegion *mr)
 {
-    /* MMIO callbacks most likely will access data that belongs
-     * to the owner, hence the need to ref/unref the owner whenever
-     * the memory region is in use.
-     *
-     * The memory region is a child of its owner.  As long as the
-     * owner doesn't call unparent itself on the memory region,
-     * ref-ing the owner will also keep the memory region alive.
-     * Memory regions without an owner are supposed to never go away;
-     * we do not ref/unref them because it slows down DMA sensibly.
-     */
-    if (mr && mr->owner) {
-        object_ref(mr->owner);
-    }
+    object_ref(OBJECT(mr));
 }
 
 void memory_region_unref(MemoryRegion *mr)
 {
-    if (mr && mr->owner) {
-        object_unref(mr->owner);
-    }
+    object_unref(OBJECT(mr));
 }
===8<===

I'm not sure how much it covers dynamic destruction of devices, though,
where the device creates internal MRs to the guest address space.  I'm
actually wondering whether we have other barriers already to avoid having
any MR ops being invoked if a device was removed.

So I think above indeed would remove the cross-ref we used to have. It
might be a matter of whether that's fine for now to fix the cyclic ref
issue alone, and even if we still want some cross-ref.. whether we should
do it the old way.  I mean, the cross-ref can also be done in other forms,
and it may not block MR has its own refcounts.

Even if we want to have dev<->MR refcount, I wonder whether we should avoid
having MR refcount the device, because it looks like "sub-object refs the
parent" which sounds like a good source of cyclic refcount issue.  I wonder
whether device should ref the MR instead (when MR is dynamically created; I
am not sure whether we even need that if in Phil's comment where the MR
object is a sub-struct-field of the Device object).  Then the device can
provide a proper destroy() function to release the MRs under it, perhaps by
disabling them first (then any ops should already fail after that), then
unref the MRs with the hope that they're the last ref holder then MRs
destroys there too.

Thanks,

-- 
Peter Xu


