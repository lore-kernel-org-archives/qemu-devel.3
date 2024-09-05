Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97428CD5BC9
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 15:57:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smEqw-0003qN-S5; Thu, 05 Sep 2024 11:56:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1smEqu-0003ng-TZ
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 11:56:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1smEqt-0003XA-AH
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 11:56:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725551811;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gIxbWX0JkGJYKHVaBvcyezrsYHVu6WgcjYkFKoWKmhw=;
 b=cg8YiUsK+UnmEBKHaniNJg9a8InOQeBhjf+lJY0LkgQEkbhNaIO2ObD/dKrX7je9btQyPc
 3m9+6nToSsv3VA179CUWGDGtbUJqgRWplLGiYmULKiJrTMxWVpUp6jOdzhOCsFjgahNZbo
 T5pXI5bLbCED2sytRElEp9TiiIjNTnw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-232-rwd_9QedP0mkVXanT6UuVQ-1; Thu,
 05 Sep 2024 11:56:48 -0400
X-MC-Unique: rwd_9QedP0mkVXanT6UuVQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 61E8F1955E75; Thu,  5 Sep 2024 15:56:47 +0000 (UTC)
Received: from localhost (unknown [10.2.16.181])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6793E3001D06; Thu,  5 Sep 2024 15:56:45 +0000 (UTC)
Date: Thu, 5 Sep 2024 11:56:43 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: David Stevens <stevensd@chromium.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Alyssa Ross <hi@alyssa.is>,
 Albert Esteve <aesteve@redhat.com>, qemu-devel@nongnu.org,
 jasowang@redhat.com, david@redhat.com, slp@redhat.com,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [RFC PATCH v2 0/5] vhost-user: Add SHMEM_MAP/UNMAP requests
Message-ID: <20240905155643.GD1922502@fedora>
References: <20240628145710.1516121-1-aesteve@redhat.com>
 <87bk34i4dy.fsf@alyssa.is>
 <CAD=HUj7av_8Epkd0Fe0eWR7Z4bZMTuvTNgqzYoQcOzFQ82wvOg@mail.gmail.com>
 <20240712014407-mutt-send-email-mst@kernel.org>
 <CAD=HUj7iDbwnojq5a68s6B3S8z4vtpCa=B=9+ZBVYZV50zG+5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="+hyDKIidNNInbQW+"
Content-Disposition: inline
In-Reply-To: <CAD=HUj7iDbwnojq5a68s6B3S8z4vtpCa=B=9+ZBVYZV50zG+5g@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--+hyDKIidNNInbQW+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 16, 2024 at 10:21:35AM +0900, David Stevens wrote:
> On Fri, Jul 12, 2024 at 2:47=E2=80=AFPM Michael S. Tsirkin <mst@redhat.co=
m> wrote:
> >
> > On Fri, Jul 12, 2024 at 11:06:49AM +0900, David Stevens wrote:
> > > On Thu, Jul 11, 2024 at 7:56=E2=80=AFPM Alyssa Ross <hi@alyssa.is> wr=
ote:
> > > >
> > > > Adding David Stevens, who implemented SHMEM_MAP and SHMEM_UNMAP in
> > > > crosvm a couple of years ago.
> > > >
> > > > David, I'd be particularly interested for your thoughts on the MEM_=
READ
> > > > and MEM_WRITE commands, since as far as I know crosvm doesn't imple=
ment
> > > > anything like that.  The discussion leading to those being added st=
arts
> > > > here:
> > > >
> > > > https://lore.kernel.org/qemu-devel/20240604185416.GB90471@fedora.re=
dhat.com/
> > > >
> > > > It would be great if this could be standardised between QEMU and cr=
osvm
> > > > (and therefore have a clearer path toward being implemented in othe=
r VMMs)!
> > >
> > > Setting aside vhost-user for a moment, the DAX example given by Stefan
> > > won't work in crosvm today.
> > >
> > > Is universal access to virtio shared memory regions actually mandated
> > > by the virtio spec? Copying from virtiofs DAX to virtiofs sharing
> > > seems reasonable enough, but what about virtio-pmem to virtio-blk?
> > > What about screenshotting a framebuffer in virtio-gpu shared memory to
> > > virtio-scsi? I guess with some plumbing in the VMM, it's solvable in a
> > > virtualized environment. But what about when you have real hardware
> > > that speaks virtio involved? That's outside my wheelhouse, but it
> > > doesn't seem like that would be easy to solve.
> >
> > Yes, it can work for physical devices if allowed by host configuration.
> > E.g. VFIO supports that I think. Don't think VDPA does.
>=20
> I'm sure it can work, but that sounds more like a SHOULD (MAY?),
> rather than a MUST.
>=20
> > > For what it's worth, my interpretation of the target scenario:
> > >
> > > > Other backends don't see these mappings. If the guest submits a vri=
ng
> > > > descriptor referencing a mapping to another backend, then that back=
end
> > > > won't be able to access this memory
> > >
> > > is that it's omitting how the implementation is reconciled with
> > > section 2.10.1 of v1.3 of the virtio spec, which states that:
> > >
> > > > References into shared memory regions are represented as offsets fr=
om
> > > > the beginning of the region instead of absolute memory addresses. O=
ffsets
> > > > are used both for references between structures stored within shared
> > > > memory and for requests placed in virtqueues that refer to shared m=
emory.
> > >
> > > My interpretation of that statement is that putting raw guest physical
> > > addresses corresponding to virtio shared memory regions into a vring
> > > is a driver spec violation.
> > >
> > > -David
> >
> > This really applies within device I think. Should be clarified ...
>=20
> You mean that a virtio device can use absolute memory addresses for
> other devices' shared memory regions, but it can't use absolute memory
> addresses for its own shared memory regions? That's a rather strange
> requirement. Or is the statement simply giving an addressing strategy
> that device type specifications are free to ignore?

My recollection of the intent behind the quoted section is:

1. Structures in shared memory that point to shared memory must used
   relative offsets instead of absolute physical addresses.
2. Virtqueue requests that refer to shared memory (e.g. map this page
   from virtiofs file to this location in shared memory) must use
   relative offsets instead of absolute physical addresses.

In other words, shared memory must be relocatable. Don't assume Shared
Memory Regions have an absolute guest physical address. This makes
device implementations independent of the guest physical memory layout
and might also help when Shared Memory Regions are exposed to guest
user-space where the guest physical memory layout isn't known.

Stefan

--+hyDKIidNNInbQW+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmbZ1LsACgkQnKSrs4Gr
c8iinAf9E0fUKNCgemoKb0dps6XYeP43rtLkyqQd5+IOp3GpocVTYG8N50FFl0S3
/WRdf7vn5+X943ItUGLKwGjssz2rkFIj3tfzREQxsbUqEMTRgUSZQTeiF4NYzbaZ
sDhXTEE0YonIjRlpl2lnNv+kENlUArXljvZZLDzJmQFJsmfvW3eLDoXMWPUh9+33
da62RN9cQxOcRAuwsj9YyORyEV1zrkncma5ER85Q2IkpOQ13qG0cg71E1eDGXCnD
MbKCt+TlAesJX2fj3zN5eCVMvXfQmG6MQjNsAEkh/n/X5A/7oZh6K4r5H5sc2mxh
o6krOhTKR6zx3E/OUsnJJtDhtZJb0Q==
=OD4/
-----END PGP SIGNATURE-----

--+hyDKIidNNInbQW+--


