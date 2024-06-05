Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3671CC25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 11:17:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEod9-0002XU-Iu; Wed, 05 Jun 2024 07:16:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sEod7-0002X3-HV
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 07:16:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sEod5-0000Ud-Uz
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 07:16:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717586190;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b1HQhOSMQm0NA4BhtjOg10yMxvnBJMg/NKmz8LEix3Y=;
 b=EYCjr3jkUf2yWQ/qhU1Gxl6n9PUlJ7uAsFC7fxsey05/lI26Wb5nLviVKm8k83dV9SVWd1
 Nuqna/BtmWdP57I84HTokIZAfjM1ZYQ9bH7EOI80JLta8OFfRiwKe3HwH4/jRIhYd4/Bfy
 rVxe5hp4D4KEZi8551XfLTTNieHj/0w=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-378-tn7THxoROlmLTGu3ILMrIg-1; Wed,
 05 Jun 2024 07:16:28 -0400
X-MC-Unique: tn7THxoROlmLTGu3ILMrIg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B2A14195DE4B
 for <qemu-devel@nongnu.org>; Wed,  5 Jun 2024 11:16:27 +0000 (UTC)
Received: from localhost (unknown [10.39.195.133])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 33D7819560A1; Wed,  5 Jun 2024 11:16:25 +0000 (UTC)
Date: Wed, 5 Jun 2024 07:16:24 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Albert Esteve <aesteve@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, slp@redhat.com, jasowang@redhat.com
Subject: Re: [RFC PATCH 0/1] vhost-user: Add SHMEM_MAP/UNMAP requests
Message-ID: <20240605111624.GB135899@fedora.redhat.com>
References: <20240530152223.780232-1-aesteve@redhat.com>
 <20240604181626.GA90471@fedora.redhat.com>
 <CADSE00JnHP_kM5GRUkPnvtwUxSmCYd4ko0ScS=EvpJzsSpX+mg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="3Yspl1lHFEx92/Dg"
Content-Disposition: inline
In-Reply-To: <CADSE00JnHP_kM5GRUkPnvtwUxSmCYd4ko0ScS=EvpJzsSpX+mg@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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


--3Yspl1lHFEx92/Dg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 05, 2024 at 09:24:36AM +0200, Albert Esteve wrote:
> On Tue, Jun 4, 2024 at 8:16=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.c=
om> wrote:
>=20
> > On Thu, May 30, 2024 at 05:22:22PM +0200, Albert Esteve wrote:
> > > Hi all,
> > >
> > > This is an early attempt to have backends
> > > support dynamic fd mapping into shared
> > > memory regions. As such, there are a few
> > > things that need settling, so I wanted to
> > > post this first to have some early feedback.
> > >
> > > The usecase for this is, e.g., to support
> > > vhost-user-gpu RESOURCE_BLOB operations,
> > > or DAX Window request for virtio-fs. In
> > > general, any operation where a backend
> > > would need to mmap an fd to a shared
> > > memory so that the guest can access it.
> >
> > I wanted to mention that this sentence confuses me because:
> >
> > - The frontend will mmap an fd into the guest's memory space so that a
> >   VIRTIO Shared Memory Region is exposed to the guest. The backend
> >   requests the frontend to perform this operation. The backend does not
> >   invoke mmap itself.
> >
>=20
> Sorry for the confused wording. It is true that the backend does not
> do the mmap, but requests it to be done. One point of confusion for
> me from your sentence is that I refer to the driver as the frontend,

They are different concepts. Frontend is defined in the vhost-user spec
and driver is defined in the VIRTIO spec.

The frontend is the application that uses vhost-user protocol messages
to communicate with the backend.

The driver uses VIRTIO device model interfaces like virtqueues to
communicate with the device.

> and the mapping is done by the VMM (i.e., QEMU).
>=20
> But yeah, I agree and the scenario you describe is what
> I had in mind. Thanks for pointing it out. I will rephrase it
> in follow-up patches.

Thanks!

>=20
>=20
> >
> > - "Shared memory" is ambiguous. Please call it VIRTIO Shared Memory
> >   Region to differentiate from vhost-user shared memory tables/regions.
> >
>=20
> Ok!
>=20
>=20
> >
> > > The request will be processed by the VMM,
> > > that will, in turn, trigger a mmap with
> > > the instructed parameters (i.e., shmid,
> > > shm_offset, fd_offset, fd, lenght).
> > >
> > > As there are already a couple devices
> > > that could benefit of such a feature,
> > > and more could require it in the future,
> > > my intention was to make it generic.
> > >
> > > To that end, I declared the shared
> > > memory region list in `VirtIODevice`.
> > > I could add a couple commodity
> > > functions to add new regions to the list,
> > > so that the devices can use them. But
> > > I wanted to gather some feedback before
> > > refining it further, as I am probably
> > > missing some required steps/or security
> > > concerns that I am not taking into account.
> > >
> > > Albert Esteve (1):
> > >   vhost-user: add shmem mmap request
> > >
> > >  docs/interop/vhost-user.rst |  23 ++++++++
> > >  hw/virtio/vhost-user.c      | 106 ++++++++++++++++++++++++++++++++++=
++
> > >  hw/virtio/virtio.c          |   2 +
> > >  include/hw/virtio/virtio.h  |   3 +
> > >  4 files changed, 134 insertions(+)
> > >
> > > --
> > > 2.44.0
> > >
> >

--3Yspl1lHFEx92/Dg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmZgSQcACgkQnKSrs4Gr
c8hN5wf9HgFrSi4owTNxaQvmG3RBjmryGJf6jUcyfO1XoRApaaU2lCEi3oc71PCr
uIoPRkKLvM3aIzTGFD8hEtUk7kQWsziimwJ0FWnho7OLFcOOuWwP6NmdnucbGZPe
X6XogvfOZ86t5ZNb4F6Y0iSS6dZAWsQn7B3J9JkmWZD34+eiEnA0au5QZQ3blDFh
kiufnicxpgLDt7ntVYdcbXKQrK35FPpCOI4GQVhfJUEQsELhCc1vY13EfKI8iyfZ
vyCfCDmoDRvOFtya9pJjgNNWPG0Lwa3/rnzAr95HrWaOhBeqRzY6SPaKDa8Cgqk+
O8PDNZs6aGo6mQfhEHmZ1nHckrx7Vw==
=MZn2
-----END PGP SIGNATURE-----

--3Yspl1lHFEx92/Dg--


