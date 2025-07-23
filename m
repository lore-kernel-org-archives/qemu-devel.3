Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9421C83F1A
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Jul 2025 12:44:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueYoS-0001is-OY; Wed, 23 Jul 2025 08:43:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1ueYoP-0001fT-0a
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 08:43:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1ueYoL-0007nr-Ue
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 08:43:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753274583;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fxd0GFjNmm2+s4yc8LDe4TD5IBaER9bX0nC9h441VTE=;
 b=Htv3KCAfTDYb+5eaX8HchTtaT02smGYRLnLqvL1MOr3UbhzxjaH0QR/eY3y/anx62sRbQZ
 MljA9wlOk9imWFCntl2qydOZL+4S8NSZfRBHiMln9sUUvFE2nXS5A4330cELhBKp1zHWnc
 NH3TPW5iEldfpSjRmrEByWOxikEMBt8=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-464-HyYruc65MiyU5O27UdguKw-1; Wed, 23 Jul 2025 08:43:02 -0400
X-MC-Unique: HyYruc65MiyU5O27UdguKw-1
X-Mimecast-MFC-AGG-ID: HyYruc65MiyU5O27UdguKw_1753274581
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-235e7550f7bso69666505ad.3
 for <qemu-devel@nongnu.org>; Wed, 23 Jul 2025 05:43:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753274580; x=1753879380;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fxd0GFjNmm2+s4yc8LDe4TD5IBaER9bX0nC9h441VTE=;
 b=H2q9IflYxykKQIhR//Exp7lQymGtXp/aLyqBAon3Y49q8IltNKa2XF4Ta1e2YK+x0K
 IlwGsIb088hHOloL8gAiYv5CeJJRIQdiFnl4JvIM6FzdMCtTmDufC65zmaqEU0u2isn/
 KrVs4dTfS6Cmo7+Ln9+SK+jqfEGTlWWqjuMcOQ0nfp61102wx7RCTUIUSVSL4hDSlXK7
 FsMffcifD0H6FV6v8h593VD0AFg1F0hDeCevsGeafr+XsLrxUbEq3EDewgrTjDb9ezB+
 LszD/zTdKEKwc4VjYvrjpN73O5cYczm/Gu4zOQdfaydKUEkKGHez9zzIhMRlWDxHhg5r
 /aIw==
X-Gm-Message-State: AOJu0Yx5AdwfaOUT4uPCTDZjmtpnUSlo4ZJiWo88lGu7cheMtJGh5N1u
 uYqKSYtSlYAMFQrDKV3UiErYL5CqHoLbEjRLbyQGnf435ZAWbJmFjDKxpXHJ2sfye2u4Yr5pJnO
 Gx6vr1+aZo44ZU0QJ6uUey4FfhHHEzKeLEn4oBz1yjoUzXvpVZ3kFC7E3zZPzDjHSmVaOhGg4lh
 A3abymvkHjGIn6711VufScckM16+498zxTakCA/Fg=
X-Gm-Gg: ASbGnct8FiaJ4+Eaz+gN45lZatntocvlJFkHzOOtVTjg8r/0bHwYpqMOXsZpZDug8uB
 gJYJdTxcf6EcE9Y89i0oxZHfLwuV7B21QP6sc+GbFXG74Ckl47FMN0KaBeAsABoYHZtBaT3IVmD
 dfWmcR31xm2L0jvMCLcMab
X-Received: by 2002:a17:903:40c5:b0:234:8a4a:adad with SMTP id
 d9443c01a7336-23f98203dd9mr38192535ad.26.1753274580494; 
 Wed, 23 Jul 2025 05:43:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESUONHpEr1LKlyohQEDR1+CaVFnQHSfozONqYLvoZjv16d6twO3UuP4Ta1mvDM5pAYaVdm/9bO6jDP5vUXHg8=
X-Received: by 2002:a17:903:40c5:b0:234:8a4a:adad with SMTP id
 d9443c01a7336-23f98203dd9mr38192275ad.26.1753274580122; Wed, 23 Jul 2025
 05:43:00 -0700 (PDT)
MIME-Version: 1.0
References: <20250723121920.1184928-1-aesteve@redhat.com>
 <f35f2cfc-2bc1-40b4-8dd2-f7ac34cbd317@linaro.org>
In-Reply-To: <f35f2cfc-2bc1-40b4-8dd2-f7ac34cbd317@linaro.org>
From: Albert Esteve <aesteve@redhat.com>
Date: Wed, 23 Jul 2025 14:42:48 +0200
X-Gm-Features: Ac12FXyCXGqK92sb4J1cjG9PArQkpk1laGdtXjLxHcVNzC94asEIwoL27ZsbVFo
Message-ID: <CADSE00Lp0W_nsUqqTz7=JmyzLuJjMdOq8WkFXeBAtOxe-yDCPg@mail.gmail.com>
Subject: Re: [RFC] memory.c: improve refcounting for RAM vs MMIO regions
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, 
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 peterx@redhat.com, 
 Laurent Vivier <lvivier@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.377,
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

On Wed, Jul 23, 2025 at 2:32=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> Hi,
>
> On 23/7/25 14:19, Albert Esteve wrote:
> > In the last version of the SHMEM MAP/UNMAP [1] there was a
> > comment [2] from Stefan about the lifecycle of the memory
> > regions.
> >
> > After some discussion, David Hildenbrand proposed
> > to detect RAM regions and handle refcounting differently
> > to clear the initial concern. This RFC patch is
> > meant for gathering feedback from others
> > (i.e., Paolo Bonzini and Peter Xu).
> >
> > [1] https://patchwork.ozlabs.org/project/qemu-devel/list/?series=3D4601=
21
> > [2] https://patchwork.ozlabs.org/comment/3528600/
> >
> > ---
> >
> > This patch enhances memory_region_ref() and memory_region_unref()
> > to handle RAM and MMIO memory regions differently, improving
> > reference counting semantics.
> >
> > RAM regions now reference/unreference the memory region object
> > itself, while MMIO continue to reference/unreference the owner
> > device as before.
> >
> > An additional qtest has been added to stress the memory
> > lifecycle. All tests pass as these changes keep backward
> > compatibility (prior behaviour is kept for MMIO regions).
> >
> > Signed-off-by: David Hildenbrand <david@redhat.com >
> > Signed-off-by: Albert Esteve <aesteve@redhat.com>
> > ---
> >   system/memory.c            | 22 +++++++++++++----
> >   tests/qtest/ivshmem-test.c | 50 +++++++++++++++++++++++++++++++++++++=
+
> >   2 files changed, 67 insertions(+), 5 deletions(-)
> >
> > diff --git a/system/memory.c b/system/memory.c
> > index 5646547940..48ab6e5592 100644
> > --- a/system/memory.c
> > +++ b/system/memory.c
> > @@ -1826,6 +1826,14 @@ Object *memory_region_owner(MemoryRegion *mr)
> >
> >   void memory_region_ref(MemoryRegion *mr)
> >   {
> > +    /* Regions without an owner are considered static. */
> > +    if (!mr || !mr->owner) {
> > +        return;
> > +    }
> > +    if (mr->ram) {
> > +        object_ref(OBJECT(mr));
> > +        return;
> > +    }
> >       /* MMIO callbacks most likely will access data that belongs
> >        * to the owner, hence the need to ref/unref the owner whenever
> >        * the memory region is in use.
> > @@ -1836,16 +1844,20 @@ void memory_region_ref(MemoryRegion *mr)
> >        * Memory regions without an owner are supposed to never go away;
>
> What are the use cases for MRs without QOM owner?

Not sure if you are asking about the logic or the actual usecases
where these MRs would make sense.

Regarding the logic, note the early return at the beginning of the
function, so that this comment is kept valid. In short, nothing
changes.

Regarding the usecases for these type of memories, I can think of
system memory or container regions as examples. But there are
certainly more experienced people in this thread that can answer you
better than me.

BR,
Albert.

>
> >        * we do not ref/unref them because it slows down DMA sensibly.
> >        */
> > -    if (mr && mr->owner) {
> > -        object_ref(mr->owner);
> > -    }
> > +    object_ref(mr->owner);
> >   }
> >
> >   void memory_region_unref(MemoryRegion *mr)
> >   {
> > -    if (mr && mr->owner) {
> > -        object_unref(mr->owner);
> > +    /* Regions without an owner are considered static. */
> > +    if (!mr || !mr->owner) {
> > +        return;
> > +    }
> > +    if (mr->ram) {
> > +        object_unref(OBJECT(mr));
> > +        return;
> >       }
> > +    object_unref(mr->owner);
> >   }
>


