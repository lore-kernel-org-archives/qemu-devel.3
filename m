Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9292C5321E
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2024 13:35:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1siZs7-00087N-8e; Mon, 26 Aug 2024 09:35:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1siZs0-00085p-3s
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 09:34:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1siZry-0005BY-5Y
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 09:34:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724679291;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=305+QUTalz8Ndh6MzQ7NlEqrdm4DaUbVWF5Wj3rrf+w=;
 b=Ye6wD/Y2s7fSHjcqRIhw7CX0VyACSJ6vLgcIs38seqxrKFEXbzegiRLmF28+uI/IX5L6oG
 hv48oQpkbz4yoHOQKvt+1O5Dob08EbxpkdINHuSD1DWqrr3Kb3dQi/I/piZ6QEXJn4VzvL
 Ee/mKQ9rEv3S8f17hrVIh3/af1D1JHE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-211-a9ztc2ksN-mR4E-jSFNoQQ-1; Mon,
 26 Aug 2024 09:34:48 -0400
X-MC-Unique: a9ztc2ksN-mR4E-jSFNoQQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D460819560A6; Mon, 26 Aug 2024 13:34:45 +0000 (UTC)
Received: from localhost (unknown [10.2.16.107])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7B89719560A3; Mon, 26 Aug 2024 13:34:44 +0000 (UTC)
Date: Mon, 26 Aug 2024 09:34:43 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-stable@nongnu.org,
 kwolf@redhat.com, hreitz@redhat.com, berrange@redhat.com,
 andrey.drobyshev@virtuozzo.com, alexander.ivanov@virtuozzo.com,
 den@virtuozzo.com, vsementsov@yandex-team.ru
Subject: Re: [PATCH for-9.1] nbd/server: CVE-2024-7409: Avoid use-after-free
 when closing server
Message-ID: <20240826133443.GA851041@fedora.redhat.com>
References: <20240822143617.800419-2-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="QtnutkrSdUuN/2f5"
Content-Disposition: inline
In-Reply-To: <20240822143617.800419-2-eblake@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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


--QtnutkrSdUuN/2f5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 09:35:29AM -0500, Eric Blake wrote:
> Commit 3e7ef738 plugged the use-after-free of the global nbd_server
> object, but overlooked a use-after-free of nbd_server->listener.
> Although this race is harder to hit, notice that our shutdown path
> first drops the reference count of nbd_server->listener, then triggers
> actions that can result in a pending client reaching the
> nbd_blockdev_client_closed() callback, which in turn calls
> qio_net_listener_set_client_func on a potentially stale object.
>=20
> If we know we don't want any more clients to connect, and have already
> told the listener socket to shut down, then we should not be trying to
> update the listener socket's associated function.
>=20
> Reproducer:
>=20
> > #!/usr/bin/python3
> >
> > import os
> > from threading import Thread
> >
> > def start_stop():
> >     while 1:
> >         os.system('virsh qemu-monitor-command VM \'{"execute": "nbd-ser=
ver-start",
> +"arguments":{"addr":{"type":"unix","data":{"path":"/tmp/nbd-sock"}}}}\'')
> >         os.system('virsh qemu-monitor-command VM \'{"execute": "nbd-ser=
ver-stop"}\'')
> >
> > def nbd_list():
> >     while 1:
> >         os.system('/path/to/build/qemu-nbd -L -k /tmp/nbd-sock')
> >
> > def test():
> >     sst =3D Thread(target=3Dstart_stop)
> >     sst.start()
> >     nlt =3D Thread(target=3Dnbd_list)
> >     nlt.start()
> >
> >     sst.join()
> >     nlt.join()
> >
> > test()
>=20
> Fixes: CVE-2024-7409
> Fixes: 3e7ef738c8 ("nbd/server: CVE-2024-7409: Close stray clients at ser=
ver-stop")
> CC: qemu-stable@nongnu.org
> Reported-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  blockdev-nbd.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--QtnutkrSdUuN/2f5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmbMhHMACgkQnKSrs4Gr
c8jyLwf/eykgdK0IMH8UiLskGOtb7rPHCMSF3GtxOAgkWpqZM3RqYaFFrO0uN779
NT6VxOjjtFqjbjaFzTiPlwIgl5UbHhfYc6tVheTQfQwJCOWWpYidvs6ys1OffjPY
PC6SusErHLcjpstajzAnlbeV/0HPBdwAhm2i3apTZa8Vu7uarz+VJSVD3AC3wAgq
Ja9VLpNlMjNtZT6w0DNnGV/dOZr20XZXCCo3I+trJ1CPHGugqfe8wK4aoecVu/4u
/D2UNjafDw9bU3aQ4W+0Cu8RJWyvBU2c2b7+PVVam6ZqOJtV0vcDTiF1XuNRrYVs
NB6LT6XwwCxYOOywmYNbOz9RWrSIuA==
=Csrz
-----END PGP SIGNATURE-----

--QtnutkrSdUuN/2f5--


