Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C79E7CD5BDF
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 16:40:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smFWS-0000pM-1J; Thu, 05 Sep 2024 12:39:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1smFWQ-0000nP-Gc
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 12:39:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1smFWO-0002Js-H3
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 12:39:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725554386;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=X9x4IbQIBu9VmI0K5lRViQG1BzZZd6avUZKFt8/UKRo=;
 b=C9EfUMhhahtBG9geYqrHYI9dS5XeP1ooTKrqX8cKvAVg9uHQwQ5914zauzZi1DoLsQYiSe
 aFitc42dSmUV+3HIL5QmxyJQV8cijFNdEn6Ui9I9CbVoKQy++Ta8AYW3axH4aYfOjCxH+T
 hqIP02NgyPEQos+N0tb9wr5XwdgIN3A=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-349-o3OXxg5qM-i972Zvn5-r1w-1; Thu,
 05 Sep 2024 12:39:43 -0400
X-MC-Unique: o3OXxg5qM-i972Zvn5-r1w-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 01107195608C; Thu,  5 Sep 2024 16:39:41 +0000 (UTC)
Received: from localhost (unknown [10.2.16.181])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A96111955F45; Thu,  5 Sep 2024 16:39:38 +0000 (UTC)
Date: Thu, 5 Sep 2024 12:39:37 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Albert Esteve <aesteve@redhat.com>
Cc: David Stevens <stevensd@chromium.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Alyssa Ross <hi@alyssa.is>,
 qemu-devel@nongnu.org, jasowang@redhat.com, david@redhat.com,
 slp@redhat.com, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [RFC PATCH v2 0/5] vhost-user: Add SHMEM_MAP/UNMAP requests
Message-ID: <20240905163937.GE1922502@fedora>
References: <20240628145710.1516121-1-aesteve@redhat.com>
 <87bk34i4dy.fsf@alyssa.is>
 <CAD=HUj7av_8Epkd0Fe0eWR7Z4bZMTuvTNgqzYoQcOzFQ82wvOg@mail.gmail.com>
 <20240712014407-mutt-send-email-mst@kernel.org>
 <CAD=HUj7iDbwnojq5a68s6B3S8z4vtpCa=B=9+ZBVYZV50zG+5g@mail.gmail.com>
 <CADSE00K=8SCghVxbP+7Awy6tGHtP3JyYy-5MAAMjrpv+bVC=6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="wAfIK5UTc7+cwjgA"
Content-Disposition: inline
In-Reply-To: <CADSE00K=8SCghVxbP+7Awy6tGHtP3JyYy-5MAAMjrpv+bVC=6Q@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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


--wAfIK5UTc7+cwjgA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 03, 2024 at 10:42:34AM +0200, Albert Esteve wrote:
> Hello all,
>=20
> Sorry, I have been a bit disconnected from this thread as I was on
> vacations and then had to switch tasks for a while.
>=20
> I will try to go through all comments and address them for the first
> non-RFC drop of this patch series.
>=20
> But I was discussing with some colleagues on this. So turns out rust-vmm's
> vhost-user-gpu will potentially use
> this soon, and a rust-vmm/vhost patch have been already posted:
> https://github.com/rust-vmm/vhost/pull/251.
> So I think it may make sense to:
> 1. Split the vhost-user documentation patch once settled. Since it is tak=
en
> as the official spec,
>     having it upstreamed independently of the implementation will benefit
> other projects to
>     work/integrate their own code.
> 2. Split READ_/WRITE_MEM messages from SHMEM_MAP/_UNMAP patches.
>     If I remember correctly, this addresses a virtio-fs specific issue,
> that will not
>     impact either virtio-gpu nor virtio-media, or any other.

This is an architectural issue that arises from exposing VIRTIO Shared
Memory Regions in vhost-user. It was first seen with Linux virtiofs but
it could happen with other devices and/or guest operating systems.

Any VIRTIO Shared Memory Region that can be mmapped into Linux userspace
may trigger this issue. Userspace may write(2) to an O_DIRECT file with
the mmap as the source. The vhost-user-blk device will not be able to
access the source device's VIRTIO Shared Memory Region and will fail.

> So it may make
> sense
>     to separate them so that one does not stall the other. I will try to
> have both
>     integrated in the mid term.

If READ_/WRITE_MEM is a pain to implement (I think it is in the
vhost-user back-end, even though I've been a proponent of it), then
another way to deal with this issue is to specify that upon receiving
MAP/UNMAP messages, the vhost-user front-end must update the vhost-user
memory tables of all other vhost-user devices. That way vhost-user
devices will be able to access VIRTIO Shared Memory Regions mapped by
other devices.

Implementing this in QEMU should be much easier than implementing
READ_/WRITE_MEM support in device back-ends.

This will be slow and scale poorly but performance is only a problem for
devices that frequently MAP/UNMAP like virtiofs. Will virtio-gpu and
virtio-media use MAP/UNMAP often at runtime? They might be able to get
away with this simple solution.

I'd be happy with that. If someone wants to make virtiofs DAX faster,
they can implement READ/WRITE_MEM or another solution later, but let's
at least make things correct from the start.

Stefan

>=20
> WDYT?
>=20
> BR,
> Albert.
>=20
> On Tue, Jul 16, 2024 at 3:21=E2=80=AFAM David Stevens <stevensd@chromium.=
org> wrote:
>=20
> > On Fri, Jul 12, 2024 at 2:47=E2=80=AFPM Michael S. Tsirkin <mst@redhat.=
com> wrote:
> > >
> > > On Fri, Jul 12, 2024 at 11:06:49AM +0900, David Stevens wrote:
> > > > On Thu, Jul 11, 2024 at 7:56=E2=80=AFPM Alyssa Ross <hi@alyssa.is> =
wrote:
> > > > >
> > > > > Adding David Stevens, who implemented SHMEM_MAP and SHMEM_UNMAP in
> > > > > crosvm a couple of years ago.
> > > > >
> > > > > David, I'd be particularly interested for your thoughts on the
> > MEM_READ
> > > > > and MEM_WRITE commands, since as far as I know crosvm doesn't
> > implement
> > > > > anything like that.  The discussion leading to those being added
> > starts
> > > > > here:
> > > > >
> > > > >
> > https://lore.kernel.org/qemu-devel/20240604185416.GB90471@fedora.redhat=
=2Ecom/
> > > > >
> > > > > It would be great if this could be standardised between QEMU and
> > crosvm
> > > > > (and therefore have a clearer path toward being implemented in ot=
her
> > VMMs)!
> > > >
> > > > Setting aside vhost-user for a moment, the DAX example given by Ste=
fan
> > > > won't work in crosvm today.
> > > >
> > > > Is universal access to virtio shared memory regions actually mandat=
ed
> > > > by the virtio spec? Copying from virtiofs DAX to virtiofs sharing
> > > > seems reasonable enough, but what about virtio-pmem to virtio-blk?
> > > > What about screenshotting a framebuffer in virtio-gpu shared memory=
 to
> > > > virtio-scsi? I guess with some plumbing in the VMM, it's solvable i=
n a
> > > > virtualized environment. But what about when you have real hardware
> > > > that speaks virtio involved? That's outside my wheelhouse, but it
> > > > doesn't seem like that would be easy to solve.
> > >
> > > Yes, it can work for physical devices if allowed by host configuratio=
n.
> > > E.g. VFIO supports that I think. Don't think VDPA does.
> >
> > I'm sure it can work, but that sounds more like a SHOULD (MAY?),
> > rather than a MUST.
> >
> > > > For what it's worth, my interpretation of the target scenario:
> > > >
> > > > > Other backends don't see these mappings. If the guest submits a v=
ring
> > > > > descriptor referencing a mapping to another backend, then that
> > backend
> > > > > won't be able to access this memory
> > > >
> > > > is that it's omitting how the implementation is reconciled with
> > > > section 2.10.1 of v1.3 of the virtio spec, which states that:
> > > >
> > > > > References into shared memory regions are represented as offsets =
=66rom
> > > > > the beginning of the region instead of absolute memory addresses.
> > Offsets
> > > > > are used both for references between structures stored within sha=
red
> > > > > memory and for requests placed in virtqueues that refer to shared
> > memory.
> > > >
> > > > My interpretation of that statement is that putting raw guest physi=
cal
> > > > addresses corresponding to virtio shared memory regions into a vring
> > > > is a driver spec violation.
> > > >
> > > > -David
> > >
> > > This really applies within device I think. Should be clarified ...
> >
> > You mean that a virtio device can use absolute memory addresses for
> > other devices' shared memory regions, but it can't use absolute memory
> > addresses for its own shared memory regions? That's a rather strange
> > requirement. Or is the statement simply giving an addressing strategy
> > that device type specifications are free to ignore?
> >
> > -David
> >
> >

--wAfIK5UTc7+cwjgA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmbZ3skACgkQnKSrs4Gr
c8gXiQgAhpT7cCP5CFXkqMcWCcRF9gfuAZx7UyfQiShQiFTMIHV1MZczsj7r3pv6
ywn4I7b/gLJBmBLOlNEvOmVlt0pYgpc2NguDVU0qHYEOTlgUhvEMo03vtzN++OT+
CTk2uOqS7K7SKVh721LuocrEmmjAz7GQ3gQ5EZJstcY9moWmAKl6PgbTf4vb6yDQ
4972EBY0UwItApxBJ/UobcPB70G61meUBrx7bWnEeBpaclTBGDbS8O6AYzBACUoq
qqDhJF7Wo8kAYjmerQpEDubffVqfUk55SkpiHdKwmFXqrUHggnXGHcJQNxqG52lm
d2YGGCRfAGGGzXohddCbuHnxBtfUDw==
=DYM5
-----END PGP SIGNATURE-----

--wAfIK5UTc7+cwjgA--


