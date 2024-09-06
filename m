Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24998CE7AFF
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 10:56:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smWcO-0005Mn-3L; Fri, 06 Sep 2024 06:55:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1smWcD-0005LQ-HX
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 06:54:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1smWc7-0005ii-W6
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 06:54:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725620089;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1lAWeeKmuyK0nUKhKuEX4xd7RJHvvP3giwndCZnGE+g=;
 b=Axp1DvJO13jB7lu5elX3Xj6BTUXZmWQhiX9DTgymmS2Zn4/qOx2EIrWoOiZENgf6JF+Wk/
 4eHrnH1OV6p6uu+hs5kDxwKoisB3ZDO3r9EB8QU5Jl/dcQGT89J4cCYPg0GCzwTLo6wLU9
 WHk4FgD3MzXMiOBOGhzkZKBwAjlrs2I=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-VqaIVfx9PfeWcvDfCbmrKw-1; Fri, 06 Sep 2024 06:54:48 -0400
X-MC-Unique: VqaIVfx9PfeWcvDfCbmrKw-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-45677d056c3so28962571cf.3
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2024 03:54:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725620088; x=1726224888;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1lAWeeKmuyK0nUKhKuEX4xd7RJHvvP3giwndCZnGE+g=;
 b=uc5dBiKL+ePIXtC4qMtbyy1JC+x0YOZkiqQw0lC9I30s3UIZPHtROnF5hTcFIh+PLA
 c56MPnvPUnyr/t99G+aKZbSrgnjibDKrdINehJFr8U77OyUttujmis+KCW/BOyq/VYo2
 5QYW4lnV1bbrUB6maXogDhWDwWi3J9cfGC1exNh17xqCJP04VD2vi5i3yyIsxfhZRsg6
 R0cpCeYcsnieBCVVGgVk24f74O9PBegEST+L1NdGkR94j7Yg4gf2BTJoozLlByraoDeB
 GrjvU87NPSRiorSvZLiP5zMQOSJcRsapjyq66zJucvT+9rWQm+uneV8bZsu6VNYgV4hC
 01eg==
X-Gm-Message-State: AOJu0YxIJOHqkCXH+YTjuz9LV8TgRWg7acy2AZFyY2nH+gVeRvjGf3D5
 HsAi9S0qJAzGLnTQMyKJ6gUeAMqKuJQu9e7BGugYIunXHOyuezF6pLbCnzjVlIx8BGGsCYQLbge
 dq72EFEwljMqk4v/UfRWF8LI7KewjelcR92oidrCvodU0JgBIXbmEEGYyb34xFXdYGHwA/3h87q
 eO6+OvpkASmMa2MbdBXfCRjbFCOKs=
X-Received: by 2002:a05:622a:155:b0:456:7fb5:104b with SMTP id
 d75a77b69052e-4580c4f32c9mr33913301cf.0.1725620088353; 
 Fri, 06 Sep 2024 03:54:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZxJSTkHoj45EkcMDmPjGF8CTIH28J8kRiKoTn1mkpVT8AwclWcWoB65xAN1mGaJvfGxPi3j11PHbg4LR6O7Q=
X-Received: by 2002:a05:622a:155:b0:456:7fb5:104b with SMTP id
 d75a77b69052e-4580c4f32c9mr33913001cf.0.1725620087828; Fri, 06 Sep 2024
 03:54:47 -0700 (PDT)
MIME-Version: 1.0
References: <20240904223510.3519358-1-peterx@redhat.com>
 <20240904223510.3519358-2-peterx@redhat.com>
 <CAC2qdxCW=ddmK1TLC4Agh4cGnMV60BKNpN_Nrrz-KuPbDfh-ew@mail.gmail.com>
 <ZtnVfXataavOoQp0@x1n>
In-Reply-To: <ZtnVfXataavOoQp0@x1n>
From: Juraj Marcin <jmarcin@redhat.com>
Date: Fri, 6 Sep 2024 12:54:37 +0200
Message-ID: <CAC2qdxDDzmt-v4WL6HxUQDL=Dt-X2qmaVEp4FTFSKGABLfUG=Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] KVM: Dynamic sized kvm memslots array
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Vitaly Kuznetsov <vkuznets@redhat.com>, 
 Prasad Pandit <ppandit@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, 
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>, 
 qemu-stable <qemu-stable@nongnu.org>, Zhiyi Guo <zhguo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jmarcin@redhat.com;
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

Hi Peter,

On Thu, Sep 5, 2024 at 6:00=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:
>
> On Thu, Sep 05, 2024 at 05:32:46PM +0200, Juraj Marcin wrote:
> > Hi Peter,
>
> Hi, Juraj,
>
> [...]
>
> > >  unsigned int kvm_get_max_memslots(void)
> > >  {
> > >      KVMState *s =3D KVM_STATE(current_accel());
> > > @@ -193,15 +247,20 @@ unsigned int kvm_get_free_memslots(void)
> > >  /* Called with KVMMemoryListener.slots_lock held */
> > >  static KVMSlot *kvm_get_free_slot(KVMMemoryListener *kml)
> > >  {
> > > -    KVMState *s =3D kvm_state;
> > >      int i;
> > >
> > > -    for (i =3D 0; i < s->nr_slots; i++) {
> > > +retry:
> > > +    for (i =3D 0; i < kml->nr_slots_allocated; i++) {
> > >          if (kml->slots[i].memory_size =3D=3D 0) {
> > >              return &kml->slots[i];
> > >          }
> > >      }
> > >
> > > +    /* If no free slots, try to grow first by doubling */
> > > +    if (kvm_slots_double(kml)) {
> > > +        goto retry;
> >
> > At this point we know all previously allocated slots were used and
> > there should be a free slot just after the last used slot (at the
> > start of the region zeroed in the grow function). Wouldn't it be
> > faster to return it here right away, instead of iterating through
> > slots that should still be used again?
>
> Good question.
>
> One trivial concern is we'll then have assumption on how kvm_slots_double=
()
> behaves, e.g., it must not move anything around inside, and we need to kn=
ow

> that it touches nr_slots_allocated so we need to cache it.  The outcome
> looks like this:
>
> =3D=3D=3D8<=3D=3D=3D
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 020fd16ab8..7429fe87a8 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -249,9 +249,9 @@ unsigned int kvm_get_free_memslots(void)
>  /* Called with KVMMemoryListener.slots_lock held */
>  static KVMSlot *kvm_get_free_slot(KVMMemoryListener *kml)
>  {
> +    unsigned int n;
>      int i;
>
> -retry:
>      for (i =3D 0; i < kml->nr_slots_allocated; i++) {
>          if (kml->slots[i].memory_size =3D=3D 0) {
>              return &kml->slots[i];
> @@ -259,8 +259,13 @@ retry:
>      }
>
>      /* If no free slots, try to grow first by doubling */
> +    n =3D kml->nr_slots_allocated;
>      if (kvm_slots_double(kml)) {
> -        goto retry;
> +        /*
> +         * If succeed, we must have n used slots, then followed by n fre=
e
> +         * slots.
> +         */
> +        return &kml->slots[n];
>      }
>
>      return NULL;
> =3D=3D=3D8<=3D=3D=3D
>
> It's still good to get rid of "goto", and faster indeed.  Though I wished
> we don't need those assumptions, as cons.
>
> One thing to mention that I expect this is extremely slow path, where I
> don't expect to even be reached in major uses of QEMU, and when reached
> should be only once or limited few times per VM life cycle.  The re-walks
> here shouldn't be a perf concern IMHO, because when it's a concern we'll
> hit it much more frequently elsewhere... many other hotter paths around.
>
> So far it looks slightly more readable to me to keep the old way, but I'm
> ok either way.  What do you think?

I agree that it requires this assumption of not moving slots around,
but I think it's intuitive to assume it when it comes to
doubling/increasing the size of an array, realloc() and g_renew() also
don't shuffle existing elements.

In addition, there already is such an assumption. If slots were moved
around, pointers returned by `return &kml->slots[i];` wouldn't point
to the same slot structure after doubling.

However, I realized there's also another problem with this return
statement. g_renew() could have moved the whole array to a new
address, making all the previously returned pointers invalid. This
could be solved by either adding another layer of indirection, so the
function returns a pointer to a single slot structure that never moves
and the array contains pointers to these structures, or the slots need
to be always accessed through an up-to-date pointer to the array,
probably from another structure or through a getter function. With the
first approach, pointers in the array could shuffle, but with the
second one, the index of a slot must not change during the lifetime of
the slot, keeping the assumption correct.

>
> Thanks,
>
> --
> Peter Xu
>


--=20

Juraj Marcin


