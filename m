Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E33EC41513
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 07:25:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEl16-000793-P2; Wed, 05 Jun 2024 03:25:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1sEl15-00078k-8k
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 03:25:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1sEl13-0004EU-6l
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 03:25:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717572298;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rrgJSeCQSOMJFNSDbCmGiaGo4cr8nGAtQOhdYgKypvk=;
 b=ROH0Wz8ZcEhESjjXsML4CiNZSY8bvVsrwHpp6I/pn+Mx9HJMIr3Ff6NcUsjTwXPJKvQn1A
 x5zEvjFL5AqSbBtJLjaFzgeWwHGKSK1DQIp4pTfjpW9WLsgCp2mm/1NG7SENguq1BC8F+Z
 4Ropkbp8Vg/9IbtXmoLYf6p2oO/6qGk=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-9lT5Iy_nNjO8jRCk2uCXYw-1; Wed, 05 Jun 2024 03:24:49 -0400
X-MC-Unique: 9lT5Iy_nNjO8jRCk2uCXYw-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2c1a9e8d3b0so1905226a91.0
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 00:24:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717572288; x=1718177088;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rrgJSeCQSOMJFNSDbCmGiaGo4cr8nGAtQOhdYgKypvk=;
 b=c6I3W0plVNfxWk6EacNNm1L4oBN02ZmLvC46CV1lX1A4gHry4Ws2xvMzsEpChVfhfj
 A4FyJzRQQCi5ktz6wrsQj8F4SsWnkOMxQeu3ojSXKqLZxnIPfV/z/tQ30p6XJ3DPhokv
 9f4D5Ip6P5b9ljNyRrhZ50efk47W6UWFVeWN7vFRSlFsUsm0WyM60hezsRkIeB3XWpOr
 DqSNE4YYCM9Gzp0SUbWdMr9cqkTxyQhZ/VcaB91FELlRkydbSdX4Y7W2PLeKPkkOhn/R
 NhwyYvnJp5W9iZdVaNU9xYvczXe4ZjIsiXhZNWhAIvFzEINiKaRDHfEseAAfdr4k7c2H
 z8sQ==
X-Gm-Message-State: AOJu0YwnkNzjLniJ3sF9i9wOQltP8bMYRTsfxaVdZiqrIxik33sCyV9G
 8PSPpDYyqFufimt4MBcJuZb3+4lP2w2EpxlrQaS6KM6DAObPcFR1QSuS+5usgL3Hbz9KuYHFYga
 i116cfE56jSE5gwOfqwXH1wbeQEbYHzUcWteGtB485rVHRuoR+Z0y2V71W9mJ4Es+mFwv8ZsgU9
 r3TrSJhaqt5rsCMXH1MlZ5BisUBRUzVOZsz2A=
X-Received: by 2002:a17:90a:9f8b:b0:2c1:424c:1721 with SMTP id
 98e67ed59e1d1-2c27db002d9mr1574655a91.3.1717572288383; 
 Wed, 05 Jun 2024 00:24:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLM+DYlgbJcqOOeoHkowo0cQ1wM3rJ/Rf2l2slbY6x+16KW2eE8Dd94MFKkLYxMUG8NMu5FKPF/JCq8Gtk1F0=
X-Received: by 2002:a17:90a:9f8b:b0:2c1:424c:1721 with SMTP id
 98e67ed59e1d1-2c27db002d9mr1574642a91.3.1717572287983; Wed, 05 Jun 2024
 00:24:47 -0700 (PDT)
MIME-Version: 1.0
References: <20240530152223.780232-1-aesteve@redhat.com>
 <20240604181626.GA90471@fedora.redhat.com>
In-Reply-To: <20240604181626.GA90471@fedora.redhat.com>
From: Albert Esteve <aesteve@redhat.com>
Date: Wed, 5 Jun 2024 09:24:36 +0200
Message-ID: <CADSE00JnHP_kM5GRUkPnvtwUxSmCYd4ko0ScS=EvpJzsSpX+mg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/1] vhost-user: Add SHMEM_MAP/UNMAP requests
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, slp@redhat.com, jasowang@redhat.com
Content-Type: multipart/alternative; boundary="0000000000001a0b9a061a1f76cd"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

--0000000000001a0b9a061a1f76cd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 4, 2024 at 8:16=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.com=
> wrote:

> On Thu, May 30, 2024 at 05:22:22PM +0200, Albert Esteve wrote:
> > Hi all,
> >
> > This is an early attempt to have backends
> > support dynamic fd mapping into shared
> > memory regions. As such, there are a few
> > things that need settling, so I wanted to
> > post this first to have some early feedback.
> >
> > The usecase for this is, e.g., to support
> > vhost-user-gpu RESOURCE_BLOB operations,
> > or DAX Window request for virtio-fs. In
> > general, any operation where a backend
> > would need to mmap an fd to a shared
> > memory so that the guest can access it.
>
> I wanted to mention that this sentence confuses me because:
>
> - The frontend will mmap an fd into the guest's memory space so that a
>   VIRTIO Shared Memory Region is exposed to the guest. The backend
>   requests the frontend to perform this operation. The backend does not
>   invoke mmap itself.
>

Sorry for the confused wording. It is true that the backend does not
do the mmap, but requests it to be done. One point of confusion for
me from your sentence is that I refer to the driver as the frontend,
and the mapping is done by the VMM (i.e., QEMU).

But yeah, I agree and the scenario you describe is what
I had in mind. Thanks for pointing it out. I will rephrase it
in follow-up patches.


>
> - "Shared memory" is ambiguous. Please call it VIRTIO Shared Memory
>   Region to differentiate from vhost-user shared memory tables/regions.
>

Ok!


>
> > The request will be processed by the VMM,
> > that will, in turn, trigger a mmap with
> > the instructed parameters (i.e., shmid,
> > shm_offset, fd_offset, fd, lenght).
> >
> > As there are already a couple devices
> > that could benefit of such a feature,
> > and more could require it in the future,
> > my intention was to make it generic.
> >
> > To that end, I declared the shared
> > memory region list in `VirtIODevice`.
> > I could add a couple commodity
> > functions to add new regions to the list,
> > so that the devices can use them. But
> > I wanted to gather some feedback before
> > refining it further, as I am probably
> > missing some required steps/or security
> > concerns that I am not taking into account.
> >
> > Albert Esteve (1):
> >   vhost-user: add shmem mmap request
> >
> >  docs/interop/vhost-user.rst |  23 ++++++++
> >  hw/virtio/vhost-user.c      | 106 ++++++++++++++++++++++++++++++++++++
> >  hw/virtio/virtio.c          |   2 +
> >  include/hw/virtio/virtio.h  |   3 +
> >  4 files changed, 134 insertions(+)
> >
> > --
> > 2.44.0
> >
>

--0000000000001a0b9a061a1f76cd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div><div dir=3D"ltr" class=3D"gmail_sign=
ature"><div dir=3D"ltr"><br></div></div></div></div><br><div class=3D"gmail=
_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jun 4, 2024 at 8:16=
=E2=80=AFPM Stefan Hajnoczi &lt;<a href=3D"mailto:stefanha@redhat.com">stef=
anha@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">On Thu, May 30, 2024 at 05:22:22PM +0200, Albert Esteve wrot=
e:<br>
&gt; Hi all,<br>
&gt; <br>
&gt; This is an early attempt to have backends<br>
&gt; support dynamic fd mapping into shared<br>
&gt; memory regions. As such, there are a few<br>
&gt; things that need settling, so I wanted to<br>
&gt; post this first to have some early feedback.<br>
&gt; <br>
&gt; The usecase for this is, e.g., to support<br>
&gt; vhost-user-gpu RESOURCE_BLOB operations,<br>
&gt; or DAX Window request for virtio-fs. In<br>
&gt; general, any operation where a backend<br>
&gt; would need to mmap an fd to a shared<br>
&gt; memory so that the guest can access it.<br>
<br>
I wanted to mention that this sentence confuses me because:<br>
<br>
- The frontend will mmap an fd into the guest&#39;s memory space so that a<=
br>
=C2=A0 VIRTIO Shared Memory Region is exposed to the guest. The backend<br>
=C2=A0 requests the frontend to perform this operation. The backend does no=
t<br>
=C2=A0 invoke mmap itself.<br></blockquote><div><br></div><div>Sorry for th=
e confused wording. It is true that the backend does not</div><div>do the m=
map, but requests it to be done. One point of confusion for</div><div>me fr=
om your sentence is that I refer to the=C2=A0driver as the frontend,</div><=
div>and the mapping is done by the VMM (i.e., QEMU).</div><div><br></div><d=
iv>But yeah, I agree and the scenario you describe is what</div><div>I had =
in mind. Thanks for pointing it out. I will rephrase it</div><div>in follow=
-up patches.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
<br>
- &quot;Shared memory&quot; is ambiguous. Please call it VIRTIO Shared Memo=
ry<br>
=C2=A0 Region to differentiate from vhost-user shared memory tables/regions=
.<br></blockquote><div><br></div><div>Ok!</div><div>=C2=A0</div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">
<br>
&gt; The request will be processed by the VMM,<br>
&gt; that will, in turn, trigger a mmap with<br>
&gt; the instructed parameters (i.e., shmid,<br>
&gt; shm_offset, fd_offset, fd, lenght).<br>
&gt; <br>
&gt; As there are already a couple devices<br>
&gt; that could benefit of such a feature,<br>
&gt; and more could require it in the future,<br>
&gt; my intention was to make it generic.<br>
&gt; <br>
&gt; To that end, I declared the shared<br>
&gt; memory region list in `VirtIODevice`.<br>
&gt; I could add a couple commodity<br>
&gt; functions to add new regions to the list,<br>
&gt; so that the devices can use them. But<br>
&gt; I wanted to gather some feedback before<br>
&gt; refining it further, as I am probably<br>
&gt; missing some required steps/or security<br>
&gt; concerns that I am not taking into account.<br>
&gt; <br>
&gt; Albert Esteve (1):<br>
&gt;=C2=A0 =C2=A0vhost-user: add shmem mmap request<br>
&gt; <br>
&gt;=C2=A0 docs/interop/vhost-user.rst |=C2=A0 23 ++++++++<br>
&gt;=C2=A0 hw/virtio/vhost-user.c=C2=A0 =C2=A0 =C2=A0 | 106 +++++++++++++++=
+++++++++++++++++++++<br>
&gt;=C2=A0 hw/virtio/virtio.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=
=A02 +<br>
&gt;=C2=A0 include/hw/virtio/virtio.h=C2=A0 |=C2=A0 =C2=A03 +<br>
&gt;=C2=A0 4 files changed, 134 insertions(+)<br>
&gt; <br>
&gt; -- <br>
&gt; 2.44.0<br>
&gt; <br>
</blockquote></div></div>

--0000000000001a0b9a061a1f76cd--


