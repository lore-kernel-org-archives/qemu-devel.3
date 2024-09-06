Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E801CE7B02
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 12:30:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smY6z-0006l9-HM; Fri, 06 Sep 2024 08:30:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1smY6k-0006GI-Is
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 08:30:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1smY6d-0002hE-R4
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 08:30:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725625822;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cYUuhUoOFprz5gXEjqcpnsQ4XnXl828/b8BDAMd70/c=;
 b=goa00OSqPGgU0oYgk6Iep4yGiLgDe+0VBmt1qk0xMHdHs2cW/DCKwSJmXF8I80RbFn9xf2
 2jSVUx2FeTXS9ptkxr9ZQSqcbhpVk0x6eZJrwQXHFU1pIUIhdKZbFuJAgV3L/s34RftLTd
 cPFBw15kklvexldYfAQxFCa8GF/ieyk=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-LL-ZKp7gPIuyhxbnh0VfDA-1; Fri, 06 Sep 2024 08:30:21 -0400
X-MC-Unique: LL-ZKp7gPIuyhxbnh0VfDA-1
Received: by mail-ot1-f72.google.com with SMTP id
 46e09a7af769-70f657cc663so1818252a34.1
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2024 05:30:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725625821; x=1726230621;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cYUuhUoOFprz5gXEjqcpnsQ4XnXl828/b8BDAMd70/c=;
 b=dKyANYZrt/KTRcJrb2hSPeGS+gULyR4IVxwdMfCN51wjVXbiD9wXqBYKZxYZBmYri0
 is4BkbKnseBXvxWoMcAYvSMqzUEskUwBeHojVgRVlfEUxXN8eNxZEek05L/jmqk781FF
 vPs0k1PRmHalxrnulqdJ27dWqiSvhjGor7QLgf4ipM7cTl1bdcPjeyp/xlUS7fHtMUEp
 fE5ao8TTp1kZBxH5823EAIDr0JnwTdPL8eJ7sUz141WMrDJG+kwEvRXck8bmku5o1X9W
 4NdBwSZoZBgJ79ei/l12vcZ0ph4aetZccvs8vtlZ+fG40yZNIWIgEMru8oTOW+NZJllH
 8EYw==
X-Gm-Message-State: AOJu0YxM0oFbju8AmDSi058rTfc5ERMa2KUIuCSeALk8o0ATB15J5eKN
 x09CSZzjjgc7GTQnEl2o1kFPfgAHgaLpl7MpnpVkQf2sX9NBNJvf5oN4UkV/evgNF9DvWiyDUCb
 mletNfZaXOamAhw6Kwt5sd1DPoWswRbdPHI1qfYMS8q/dcTPR20ag
X-Received: by 2002:a05:6830:2c0b:b0:710:cce7:5bbd with SMTP id
 46e09a7af769-710cce75ee5mr1768497a34.0.1725625820637; 
 Fri, 06 Sep 2024 05:30:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLeys1HL4MJZpomj+S749SEpU+sAFPYtae3Yu5aiTrGFQFaAmM1F3xm2flB4ItUIxYaaTPfg==
X-Received: by 2002:a05:6830:2c0b:b0:710:cce7:5bbd with SMTP id
 46e09a7af769-710cce75ee5mr1768473a34.0.1725625820274; 
 Fri, 06 Sep 2024 05:30:20 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c5202de5b8sm16085986d6.69.2024.09.06.05.30.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Sep 2024 05:30:19 -0700 (PDT)
Date: Fri, 6 Sep 2024 08:30:18 -0400
From: Peter Xu <peterx@redhat.com>
To: Juraj Marcin <jmarcin@redhat.com>
Cc: qemu-devel@nongnu.org, Vitaly Kuznetsov <vkuznets@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>,
 Julia Suvorova <jusual@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 qemu-stable <qemu-stable@nongnu.org>, Zhiyi Guo <zhguo@redhat.com>
Subject: Re: [PATCH v2 1/4] KVM: Dynamic sized kvm memslots array
Message-ID: <Ztr12p5CR9C6a2y3@x1n>
References: <20240904223510.3519358-1-peterx@redhat.com>
 <20240904223510.3519358-2-peterx@redhat.com>
 <CAC2qdxCW=ddmK1TLC4Agh4cGnMV60BKNpN_Nrrz-KuPbDfh-ew@mail.gmail.com>
 <ZtnVfXataavOoQp0@x1n>
 <CAC2qdxDDzmt-v4WL6HxUQDL=Dt-X2qmaVEp4FTFSKGABLfUG=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAC2qdxDDzmt-v4WL6HxUQDL=Dt-X2qmaVEp4FTFSKGABLfUG=Q@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Sep 06, 2024 at 12:54:37PM +0200, Juraj Marcin wrote:
> Hi Peter,
> 
> On Thu, Sep 5, 2024 at 6:00 PM Peter Xu <peterx@redhat.com> wrote:
> >
> > On Thu, Sep 05, 2024 at 05:32:46PM +0200, Juraj Marcin wrote:
> > > Hi Peter,
> >
> > Hi, Juraj,
> >
> > [...]
> >
> > > >  unsigned int kvm_get_max_memslots(void)
> > > >  {
> > > >      KVMState *s = KVM_STATE(current_accel());
> > > > @@ -193,15 +247,20 @@ unsigned int kvm_get_free_memslots(void)
> > > >  /* Called with KVMMemoryListener.slots_lock held */
> > > >  static KVMSlot *kvm_get_free_slot(KVMMemoryListener *kml)
> > > >  {
> > > > -    KVMState *s = kvm_state;
> > > >      int i;
> > > >
> > > > -    for (i = 0; i < s->nr_slots; i++) {
> > > > +retry:
> > > > +    for (i = 0; i < kml->nr_slots_allocated; i++) {
> > > >          if (kml->slots[i].memory_size == 0) {
> > > >              return &kml->slots[i];
> > > >          }
> > > >      }
> > > >
> > > > +    /* If no free slots, try to grow first by doubling */
> > > > +    if (kvm_slots_double(kml)) {
> > > > +        goto retry;
> > >
> > > At this point we know all previously allocated slots were used and
> > > there should be a free slot just after the last used slot (at the
> > > start of the region zeroed in the grow function). Wouldn't it be
> > > faster to return it here right away, instead of iterating through
> > > slots that should still be used again?
> >
> > Good question.
> >
> > One trivial concern is we'll then have assumption on how kvm_slots_double()
> > behaves, e.g., it must not move anything around inside, and we need to know
> 
> > that it touches nr_slots_allocated so we need to cache it.  The outcome
> > looks like this:
> >
> > ===8<===
> > diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> > index 020fd16ab8..7429fe87a8 100644
> > --- a/accel/kvm/kvm-all.c
> > +++ b/accel/kvm/kvm-all.c
> > @@ -249,9 +249,9 @@ unsigned int kvm_get_free_memslots(void)
> >  /* Called with KVMMemoryListener.slots_lock held */
> >  static KVMSlot *kvm_get_free_slot(KVMMemoryListener *kml)
> >  {
> > +    unsigned int n;
> >      int i;
> >
> > -retry:
> >      for (i = 0; i < kml->nr_slots_allocated; i++) {
> >          if (kml->slots[i].memory_size == 0) {
> >              return &kml->slots[i];
> > @@ -259,8 +259,13 @@ retry:
> >      }
> >
> >      /* If no free slots, try to grow first by doubling */
> > +    n = kml->nr_slots_allocated;
> >      if (kvm_slots_double(kml)) {
> > -        goto retry;
> > +        /*
> > +         * If succeed, we must have n used slots, then followed by n free
> > +         * slots.
> > +         */
> > +        return &kml->slots[n];
> >      }
> >
> >      return NULL;
> > ===8<===
> >
> > It's still good to get rid of "goto", and faster indeed.  Though I wished
> > we don't need those assumptions, as cons.
> >
> > One thing to mention that I expect this is extremely slow path, where I
> > don't expect to even be reached in major uses of QEMU, and when reached
> > should be only once or limited few times per VM life cycle.  The re-walks
> > here shouldn't be a perf concern IMHO, because when it's a concern we'll
> > hit it much more frequently elsewhere... many other hotter paths around.
> >
> > So far it looks slightly more readable to me to keep the old way, but I'm
> > ok either way.  What do you think?
> 
> I agree that it requires this assumption of not moving slots around,
> but I think it's intuitive to assume it when it comes to
> doubling/increasing the size of an array, realloc() and g_renew() also
> don't shuffle existing elements.
> 
> In addition, there already is such an assumption. If slots were moved
> around, pointers returned by `return &kml->slots[i];` wouldn't point
> to the same slot structure after doubling.
> 
> However, I realized there's also another problem with this return
> statement. g_renew() could have moved the whole array to a new
> address, making all the previously returned pointers invalid. This
> could be solved by either adding another layer of indirection, so the
> function returns a pointer to a single slot structure that never moves
> and the array contains pointers to these structures, or the slots need
> to be always accessed through an up-to-date pointer to the array,
> probably from another structure or through a getter function. With the
> first approach, pointers in the array could shuffle, but with the
> second one, the index of a slot must not change during the lifetime of
> the slot, keeping the assumption correct.

Note that all access to kvm slots are protected by kvm_slots_lock() which
is currently a mutex (aka, non-RCU), and we can't cache slot yet so far
because we don't know whether there's concurrent update.

Thanks,

-- 
Peter Xu


