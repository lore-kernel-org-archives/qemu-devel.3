Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27A67C47422
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 13:21:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rURYz-0006QC-5D; Mon, 29 Jan 2024 08:20:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rURYm-0006Op-HU
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 08:20:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rURYg-0003dm-1q
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 08:20:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706534416;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yygYvpg6u5Hg6PqDkoBMNi11lZ18dSA09cRzHRO442U=;
 b=OUB1gzgWEvaTO9rU9UsDSMqFN8Qle+jEKP/xrjuXZ1aKyY0ia1I1LnqC1P8TSBS1dVu56q
 xMup/eUDaEQLd80lLnOovVJ7V8OWQ0r9P2zVLowTH6LSn04p2vW/zz9Thi6kAAMPhdeNtb
 OGGe3GNe0n913mvkr/4A3H6e47X+op4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-423-sl_eUAkrOoidZgzHjTN9XQ-1; Mon, 29 Jan 2024 08:20:12 -0500
X-MC-Unique: sl_eUAkrOoidZgzHjTN9XQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E0241869EC1;
 Mon, 29 Jan 2024 13:20:11 +0000 (UTC)
Received: from localhost (unknown [10.39.193.31])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 728A8C38;
 Mon, 29 Jan 2024 13:20:10 +0000 (UTC)
Date: Thu, 25 Jan 2024 16:32:06 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Fiona Ebner <f.ebner@proxmox.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: Re: [PATCH 2/2] virtio: Keep notifications disabled during drain
Message-ID: <20240125213206.GB58542@fedora>
References: <20240124173834.66320-1-hreitz@redhat.com>
 <20240124173834.66320-3-hreitz@redhat.com>
 <20240125180326.GA36016@fedora>
 <cd6bccd0-abca-40ec-9df0-fe5285d18d97@redhat.com>
 <cb2e1577-9079-49ea-90e4-71d57b78290f@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="MQRf9gv8Pp2Eaa2k"
Content-Disposition: inline
In-Reply-To: <cb2e1577-9079-49ea-90e4-71d57b78290f@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.29,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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


--MQRf9gv8Pp2Eaa2k
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 07:32:12PM +0100, Hanna Czenczek wrote:
> On 25.01.24 19:18, Hanna Czenczek wrote:
> > On 25.01.24 19:03, Stefan Hajnoczi wrote:
> > > On Wed, Jan 24, 2024 at 06:38:30PM +0100, Hanna Czenczek wrote:
>=20
> [...]
>=20
> > > > @@ -3563,6 +3574,13 @@ void
> > > > virtio_queue_aio_attach_host_notifier(VirtQueue *vq, AioContext
> > > > *ctx)
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aio_set_event_notifier_poll(ctx, &vq=
->host_notifier,
> > > > virtio_queue_host_notifier_aio_poll_begin,
> > > > virtio_queue_host_notifier_aio_poll_end);
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0 /*
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0 * We will have ignored notifications abou=
t new requests
> > > > from the guest
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0 * during the drain, so "kick" the virt qu=
eue to process
> > > > those requests
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0 * now.
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > > +=C2=A0=C2=A0=C2=A0 virtio_queue_notify(vq->vdev, vq->queue_index);
> > > event_notifier_set(&vq->host_notifier) is easier to understand because
> > > it doesn't contain a non-host_notifier code path that we must not tak=
e.
> > >=20
> > > Is there a reason why you used virtio_queue_notify() instead?
> >=20
> > Not a good one anyway!
> >=20
> > virtio_queue_notify() is just what seemed obvious to me (i.e. to notify
> > the virtqueue).=C2=A0 Before removal of the AioContext lock, calling
> > handle_output seemed safe.=C2=A0 But, yes, there was the discussion on =
the
> > RFC that it really isn=E2=80=99t.=C2=A0 I didn=E2=80=99t consider that =
means we must rely on
> > virtio_queue_notify() calling event_notifier_set(), so we may as well
> > call it explicitly here.
> >=20
> > I=E2=80=99ll fix it, thanks for pointing it out!
>=20
> (I think together with this change, I=E2=80=99ll also remove the
> event_notifier_set() call from virtio_blk_data_plane_start().=C2=A0 It=E2=
=80=99d
> obviously be a duplicate, and removing it shows why
> virtio_queue_aio_attach_host_notifier() should always kick the queue.)

Yes, it can be removed from start().

Stefan

--MQRf9gv8Pp2Eaa2k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmWy01YACgkQnKSrs4Gr
c8gw1ggAqyCvU2Qz/I7/rqRa8nlU59RNx/b/6ptbx2iddOKLoLFj0TqdV4jiBEDN
uysp2WAsTBuz8fsmd1HPEPG5rnaLxiFWMhShvB/3MzyTJ2fluWA88WSa+fu3WzTO
32dDqsoUBi5erYH01NEZHa94etNM7KjYMlWKnqyKnJw6pZq/g/e7qh94kbeUUQ/J
21L5RprHkVcYr6X/uzmJsXy7c6c9VSfq6QwclJ51gLD6+aIGuxGbSdsJTRQ3/D+v
6sv+kx++fZLkeSg/drQm+nKDQ0SrCHN858ST3aMpfjpECZGRjpUlPMY2F2ZMUwR4
ajpBm9ZxuvwTrlarDKp/ZzbePqMjpA==
=498P
-----END PGP SIGNATURE-----

--MQRf9gv8Pp2Eaa2k--


