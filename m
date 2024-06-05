Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D8E3C27C53
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 11:51:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEpAk-0007Zq-AG; Wed, 05 Jun 2024 07:51:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1sEpAh-0007ZU-N4
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 07:51:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1sEpAf-0001kX-MG
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 07:51:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717588272;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TDvcn33mAJRrHsZH3YIUctVuQfI1s3efiDK+luCpfic=;
 b=f0o9GaCkC6UpgVYOtAPeAERpVKcHDh427Ym+HMyALh/VOgOanPorh7bPbB0217wIsoK5ST
 w3aidSuRlrZkBQ6tVzp5oqH9IaGgRP4uglEsJPKvNU8mLtHy/RHwl22AgR8eLe9eTGx025
 Q5uGAmmuZzEcRkaqVH04kx8yodbYSnc=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-81-mKk4zNpOM3y9PigsTzWxIQ-1; Wed, 05 Jun 2024 07:51:08 -0400
X-MC-Unique: mKk4zNpOM3y9PigsTzWxIQ-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2c1e6a08555so823592a91.0
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 04:51:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717588268; x=1718193068;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TDvcn33mAJRrHsZH3YIUctVuQfI1s3efiDK+luCpfic=;
 b=GtLT10ZzG1SiPZPrX/x5PGoZl807NQY+8njBJce1oFjWwR14TIhwDeCqXKyR2BHRgD
 l9uLWEd/0SXfEWSXE2Hyv5RvC9J5i+QO7KFe9zRL17am0Y+/pUxdmpNFJzYhMZ89SLJv
 s0v+UfMk7wcRtIcfOtFHzOkcVyFkcmvy/nsM2hgWq2IXBiyV6mlf66WrL0X28FtKbsVZ
 O3ZihR++jSexJlnx9rDZls/d394zuKQDz/eTvTj/JvDcW6h3fKXt7CvPG4tlc+R1jxBs
 Ctgpv7ShzSVxOtA0dG0cJ968ch4yvPJysNGvfPXVkamq0ivt85ZAl02RRStX1viKZl6N
 OaIw==
X-Gm-Message-State: AOJu0YwUy2IlNAlCVb72cbNPxXc+GjJvkYuVGjRxf21ip46c7FJjl/qD
 cffkeFp8nxtQcyK1U05WXWQ2AsJs1QtcIlPYrbOVua01MoG4n9KvAWFJG+c3OC1OxmITjfylJ9t
 cPoM8oGcS4WrRjed7hPQOnNnvQ8C0jgbHBBFr8NuSKMISfpBbLmLBbM+iCMsKXNuPYCGZEqGHV8
 Q51w6pHOfcMzjKmZ0tIrIQuwkmmlY=
X-Received: by 2002:a17:90a:de8f:b0:2c2:55e9:6bc8 with SMTP id
 98e67ed59e1d1-2c27cae641fmr3644333a91.0.1717588267740; 
 Wed, 05 Jun 2024 04:51:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPVTvsG2Uh8nqvnV99IouoRKsHAE8mudZHeUE//ktwgyWKm89By014T61/u8aGVuhGlhFHD5m5aOlB5Zfb43c=
X-Received: by 2002:a17:90a:de8f:b0:2c2:55e9:6bc8 with SMTP id
 98e67ed59e1d1-2c27cae641fmr3644316a91.0.1717588267375; Wed, 05 Jun 2024
 04:51:07 -0700 (PDT)
MIME-Version: 1.0
References: <20240530152223.780232-1-aesteve@redhat.com>
 <20240604181626.GA90471@fedora.redhat.com>
 <CADSE00JnHP_kM5GRUkPnvtwUxSmCYd4ko0ScS=EvpJzsSpX+mg@mail.gmail.com>
 <20240605111624.GB135899@fedora.redhat.com>
In-Reply-To: <20240605111624.GB135899@fedora.redhat.com>
From: Albert Esteve <aesteve@redhat.com>
Date: Wed, 5 Jun 2024 13:50:56 +0200
Message-ID: <CADSE00+U1PtFxaE+etcJCOb9ZmS6-_d+7iODmaJAUwBg6iqiUQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/1] vhost-user: Add SHMEM_MAP/UNMAP requests
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, slp@redhat.com, jasowang@redhat.com
Content-Type: multipart/alternative; boundary="0000000000008c4603061a232efe"
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

--0000000000008c4603061a232efe
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 5, 2024 at 1:16=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.com=
> wrote:

> On Wed, Jun 05, 2024 at 09:24:36AM +0200, Albert Esteve wrote:
> > On Tue, Jun 4, 2024 at 8:16=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat=
.com>
> wrote:
> >
> > > On Thu, May 30, 2024 at 05:22:22PM +0200, Albert Esteve wrote:
> > > > Hi all,
> > > >
> > > > This is an early attempt to have backends
> > > > support dynamic fd mapping into shared
> > > > memory regions. As such, there are a few
> > > > things that need settling, so I wanted to
> > > > post this first to have some early feedback.
> > > >
> > > > The usecase for this is, e.g., to support
> > > > vhost-user-gpu RESOURCE_BLOB operations,
> > > > or DAX Window request for virtio-fs. In
> > > > general, any operation where a backend
> > > > would need to mmap an fd to a shared
> > > > memory so that the guest can access it.
> > >
> > > I wanted to mention that this sentence confuses me because:
> > >
> > > - The frontend will mmap an fd into the guest's memory space so that =
a
> > >   VIRTIO Shared Memory Region is exposed to the guest. The backend
> > >   requests the frontend to perform this operation. The backend does n=
ot
> > >   invoke mmap itself.
> > >
> >
> > Sorry for the confused wording. It is true that the backend does not
> > do the mmap, but requests it to be done. One point of confusion for
> > me from your sentence is that I refer to the driver as the frontend,
>
> They are different concepts. Frontend is defined in the vhost-user spec
> and driver is defined in the VIRTIO spec.
>

Ah! I see. Then you may probably want to ignore some of my responses to
other mail of this series :P

Thanks for the clarification.


>
> The frontend is the application that uses vhost-user protocol messages
> to communicate with the backend.
>
> The driver uses VIRTIO device model interfaces like virtqueues to
> communicate with the device.
>
> > and the mapping is done by the VMM (i.e., QEMU).
> >
> > But yeah, I agree and the scenario you describe is what
> > I had in mind. Thanks for pointing it out. I will rephrase it
> > in follow-up patches.
>
> Thanks!
>
> >
> >
> > >
> > > - "Shared memory" is ambiguous. Please call it VIRTIO Shared Memory
> > >   Region to differentiate from vhost-user shared memory tables/region=
s.
> > >
> >
> > Ok!
> >
> >
> > >
> > > > The request will be processed by the VMM,
> > > > that will, in turn, trigger a mmap with
> > > > the instructed parameters (i.e., shmid,
> > > > shm_offset, fd_offset, fd, lenght).
> > > >
> > > > As there are already a couple devices
> > > > that could benefit of such a feature,
> > > > and more could require it in the future,
> > > > my intention was to make it generic.
> > > >
> > > > To that end, I declared the shared
> > > > memory region list in `VirtIODevice`.
> > > > I could add a couple commodity
> > > > functions to add new regions to the list,
> > > > so that the devices can use them. But
> > > > I wanted to gather some feedback before
> > > > refining it further, as I am probably
> > > > missing some required steps/or security
> > > > concerns that I am not taking into account.
> > > >
> > > > Albert Esteve (1):
> > > >   vhost-user: add shmem mmap request
> > > >
> > > >  docs/interop/vhost-user.rst |  23 ++++++++
> > > >  hw/virtio/vhost-user.c      | 106
> ++++++++++++++++++++++++++++++++++++
> > > >  hw/virtio/virtio.c          |   2 +
> > > >  include/hw/virtio/virtio.h  |   3 +
> > > >  4 files changed, 134 insertions(+)
> > > >
> > > > --
> > > > 2.44.0
> > > >
> > >
>

--0000000000008c4603061a232efe
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div><div dir=3D"ltr" class=3D"gmail_sign=
ature"><div dir=3D"ltr"><br></div></div></div></div><br><div class=3D"gmail=
_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jun 5, 2024 at 1:16=
=E2=80=AFPM Stefan Hajnoczi &lt;<a href=3D"mailto:stefanha@redhat.com">stef=
anha@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">On Wed, Jun 05, 2024 at 09:24:36AM +0200, Albert Esteve wrot=
e:<br>
&gt; On Tue, Jun 4, 2024 at 8:16=E2=80=AFPM Stefan Hajnoczi &lt;<a href=3D"=
mailto:stefanha@redhat.com" target=3D"_blank">stefanha@redhat.com</a>&gt; w=
rote:<br>
&gt; <br>
&gt; &gt; On Thu, May 30, 2024 at 05:22:22PM +0200, Albert Esteve wrote:<br=
>
&gt; &gt; &gt; Hi all,<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; This is an early attempt to have backends<br>
&gt; &gt; &gt; support dynamic fd mapping into shared<br>
&gt; &gt; &gt; memory regions. As such, there are a few<br>
&gt; &gt; &gt; things that need settling, so I wanted to<br>
&gt; &gt; &gt; post this first to have some early feedback.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; The usecase for this is, e.g., to support<br>
&gt; &gt; &gt; vhost-user-gpu RESOURCE_BLOB operations,<br>
&gt; &gt; &gt; or DAX Window request for virtio-fs. In<br>
&gt; &gt; &gt; general, any operation where a backend<br>
&gt; &gt; &gt; would need to mmap an fd to a shared<br>
&gt; &gt; &gt; memory so that the guest can access it.<br>
&gt; &gt;<br>
&gt; &gt; I wanted to mention that this sentence confuses me because:<br>
&gt; &gt;<br>
&gt; &gt; - The frontend will mmap an fd into the guest&#39;s memory space =
so that a<br>
&gt; &gt;=C2=A0 =C2=A0VIRTIO Shared Memory Region is exposed to the guest. =
The backend<br>
&gt; &gt;=C2=A0 =C2=A0requests the frontend to perform this operation. The =
backend does not<br>
&gt; &gt;=C2=A0 =C2=A0invoke mmap itself.<br>
&gt; &gt;<br>
&gt; <br>
&gt; Sorry for the confused wording. It is true that the backend does not<b=
r>
&gt; do the mmap, but requests it to be done. One point of confusion for<br=
>
&gt; me from your sentence is that I refer to the driver as the frontend,<b=
r>
<br>
They are different concepts. Frontend is defined in the vhost-user spec<br>
and driver is defined in the VIRTIO spec.<br></blockquote><div><br></div><d=
iv>Ah! I see. Then you may probably want to ignore some of my responses to<=
/div><div>other mail of this series :P</div><div><br></div><div>Thanks for =
the clarification.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex">
<br>
The frontend is the application that uses vhost-user protocol messages<br>
to communicate with the backend.<br>
<br>
The driver uses VIRTIO device model interfaces like virtqueues to<br>
communicate with the device.<br>
<br>
&gt; and the mapping is done by the VMM (i.e., QEMU).<br>
&gt; <br>
&gt; But yeah, I agree and the scenario you describe is what<br>
&gt; I had in mind. Thanks for pointing it out. I will rephrase it<br>
&gt; in follow-up patches.<br>
<br>
Thanks!<br>
<br>
&gt; <br>
&gt; <br>
&gt; &gt;<br>
&gt; &gt; - &quot;Shared memory&quot; is ambiguous. Please call it VIRTIO S=
hared Memory<br>
&gt; &gt;=C2=A0 =C2=A0Region to differentiate from vhost-user shared memory=
 tables/regions.<br>
&gt; &gt;<br>
&gt; <br>
&gt; Ok!<br>
&gt; <br>
&gt; <br>
&gt; &gt;<br>
&gt; &gt; &gt; The request will be processed by the VMM,<br>
&gt; &gt; &gt; that will, in turn, trigger a mmap with<br>
&gt; &gt; &gt; the instructed parameters (i.e., shmid,<br>
&gt; &gt; &gt; shm_offset, fd_offset, fd, lenght).<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; As there are already a couple devices<br>
&gt; &gt; &gt; that could benefit of such a feature,<br>
&gt; &gt; &gt; and more could require it in the future,<br>
&gt; &gt; &gt; my intention was to make it generic.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; To that end, I declared the shared<br>
&gt; &gt; &gt; memory region list in `VirtIODevice`.<br>
&gt; &gt; &gt; I could add a couple commodity<br>
&gt; &gt; &gt; functions to add new regions to the list,<br>
&gt; &gt; &gt; so that the devices can use them. But<br>
&gt; &gt; &gt; I wanted to gather some feedback before<br>
&gt; &gt; &gt; refining it further, as I am probably<br>
&gt; &gt; &gt; missing some required steps/or security<br>
&gt; &gt; &gt; concerns that I am not taking into account.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Albert Esteve (1):<br>
&gt; &gt; &gt;=C2=A0 =C2=A0vhost-user: add shmem mmap request<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;=C2=A0 docs/interop/vhost-user.rst |=C2=A0 23 ++++++++<br>
&gt; &gt; &gt;=C2=A0 hw/virtio/vhost-user.c=C2=A0 =C2=A0 =C2=A0 | 106 +++++=
+++++++++++++++++++++++++++++++<br>
&gt; &gt; &gt;=C2=A0 hw/virtio/virtio.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 =C2=A02 +<br>
&gt; &gt; &gt;=C2=A0 include/hw/virtio/virtio.h=C2=A0 |=C2=A0 =C2=A03 +<br>
&gt; &gt; &gt;=C2=A0 4 files changed, 134 insertions(+)<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; --<br>
&gt; &gt; &gt; 2.44.0<br>
&gt; &gt; &gt;<br>
&gt; &gt;<br>
</blockquote></div></div>

--0000000000008c4603061a232efe--


