Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7307DCD5BB8
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 19:19:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smI0y-0004vl-54; Thu, 05 Sep 2024 15:19:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1smI0H-0002AP-L9
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 15:18:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1smI0F-0000kA-VU
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 15:18:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725563926;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=anrY+uT3YvPP5XVRLMw+m17A/UoXs8U2tG0VlgGZmQs=;
 b=GaZKlBZjWEdu03fcqnL3TVpcwxBLkGUHKlwhhrNNocjlKJmLKmI+RFiYJxk3Qxqt6kIKsN
 MxTiZkU1NwYrmwqlxoql0pyAgtBwztfkt7C198v8FV+8cs350nu+kU04MBzQ5zgQlvFn4A
 59IvxUa6ISbVNT8KOFNinQHodF+zmqo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-201-ZwlrAh75MQGYcEgoMIwrFw-1; Thu,
 05 Sep 2024 15:18:43 -0400
X-MC-Unique: ZwlrAh75MQGYcEgoMIwrFw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1BAB11977021; Thu,  5 Sep 2024 19:18:42 +0000 (UTC)
Received: from localhost (unknown [10.2.16.181])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CFB801956086; Thu,  5 Sep 2024 19:18:40 +0000 (UTC)
Date: Thu, 5 Sep 2024 15:18:39 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Albert Esteve <aesteve@redhat.com>
Cc: qemu-devel@nongnu.org, jasowang@redhat.com, david@redhat.com,
 slp@redhat.com, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC PATCH v2 5/5] vhost_user: Implement mem_read/mem_write
 handlers
Message-ID: <20240905191839.GG1922502@fedora>
References: <20240628145710.1516121-1-aesteve@redhat.com>
 <20240628145710.1516121-6-aesteve@redhat.com>
 <20240711085533.GG563880@dynamic-pd01.res.v6.highway.a1.net>
 <CADSE00L=U4jmEvosaSt=a2EQ654kfh4cKzNLQFpFXX==pHZ0Hg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ProaZxhGQc1nxrDs"
Content-Disposition: inline
In-Reply-To: <CADSE00L=U4jmEvosaSt=a2EQ654kfh4cKzNLQFpFXX==pHZ0Hg@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
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


--ProaZxhGQc1nxrDs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 04, 2024 at 03:01:06PM +0200, Albert Esteve wrote:
> On Thu, Jul 11, 2024 at 10:55=E2=80=AFAM Stefan Hajnoczi <stefanha@redhat=
=2Ecom>
> wrote:
>=20
> > On Fri, Jun 28, 2024 at 04:57:10PM +0200, Albert Esteve wrote:
> > > Implement function handlers for memory read and write
> > > operations.
> > >
> > > Signed-off-by: Albert Esteve <aesteve@redhat.com>
> > > ---
> > >  hw/virtio/vhost-user.c | 34 ++++++++++++++++++++++++++++++----
> > >  1 file changed, 30 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> > > index 18cacb2d68..79becbc87b 100644
> > > --- a/hw/virtio/vhost-user.c
> > > +++ b/hw/virtio/vhost-user.c
> > > @@ -1884,16 +1884,42 @@ static int
> > >  vhost_user_backend_handle_mem_read(struct vhost_dev *dev,
> > >                                     VhostUserMemRWMsg *mem_rw)
> > >  {
> > > -    /* TODO */
> > > -    return -EPERM;
> > > +    ram_addr_t offset;
> > > +    int fd;
> > > +    MemoryRegion *mr;
> > > +
> > > +    mr =3D vhost_user_get_mr_data(mem_rw->guest_address, &offset, &f=
d);
> > > +
> > > +    if (!mr) {
> > > +        error_report("Failed to get memory region with address %"
> > PRIx64,
> > > +                     mem_rw->guest_address);
> > > +        return -EFAULT;
> > > +    }
> > > +
> > > +    memcpy(mem_rw->data, memory_region_get_ram_ptr(mr) + offset,
> > mem_rw->size);
> >
> > Don't try to write this from scratch. Use address_space_read/write(). It
> > supports corner cases like crossing MemoryRegions.
> >
>=20
> I am having issues getting the address space from the vhost_dev struct to
> feed
> address_spave_read/write() function with the first parameter. But I found
> mr->ops.
> Would something like this perhaps be enough?
>=20
> ```
>     mr->ops->read_with_attrs(mr->opaque, mem_rw->guest_address,
>                              &mem_rw->data, mem_rw->size,
>                              MEMTXATTRS_UNSPECIFIED);
> ```

You can use dev->vdev->dma_as to get the AddressSpace for
address_space_read/write():

  struct vhost_dev {
      VirtIODevice *vdev;
 =20
  struct VirtIODevice
  {
      ...
      AddressSpace *dma_as;

>=20
>=20
> >
> > > +
> > > +    return 0;
> > >  }
> > >
> > >  static int
> > >  vhost_user_backend_handle_mem_write(struct vhost_dev *dev,
> > >                                     VhostUserMemRWMsg *mem_rw)
> > >  {
> > > -    /* TODO */
> > > -    return -EPERM;
> > > +    ram_addr_t offset;
> > > +    int fd;
> > > +    MemoryRegion *mr;
> > > +
> > > +    mr =3D vhost_user_get_mr_data(mem_rw->guest_address, &offset, &f=
d);
> > > +
> > > +    if (!mr) {
> > > +        error_report("Failed to get memory region with address %"
> > PRIx64,
> > > +                     mem_rw->guest_address);
> > > +        return -EFAULT;
> > > +    }
> > > +
> > > +    memcpy(memory_region_get_ram_ptr(mr) + offset, mem_rw->data,
> > mem_rw->size);
> > > +
> > > +    return 0;
> > >  }
> > >
> > >  static void close_backend_channel(struct vhost_user *u)
> > > --
> > > 2.45.2
> > >
> >

--ProaZxhGQc1nxrDs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmbaBA8ACgkQnKSrs4Gr
c8iUyggAgiMuGg+r0c092l+qZl5TS1t+2lAyfx/uQ2RAMwXxN9vdKd9DSybjseJ9
GXO/FSAKz7+ZLZhf4i6NR7It13c2qxZdksOxVrOMidGJ0lBC/YaB5TVbH/IHedtU
kdmoynnCDHh5ocEiLBCiAujwvbFmYBwUeJ4Ku7brjc+o8rjXHsEL+mRr4ZVSNr+q
w9pST5ftkEWZA59nYN68TF7pZuDZQgQsqoU4yJxEvEkYQ+7zfBDapJTlwofnsSme
XJE4812+2rNPyKDBeY1uGqSxXJRYRQuH12nbBo0E0duDmcw3F+EAKggsRKHTY1rX
knqfTpfNNOy/B8GgQCr6BNd6Du6M6w==
=+Bdx
-----END PGP SIGNATURE-----

--ProaZxhGQc1nxrDs--


