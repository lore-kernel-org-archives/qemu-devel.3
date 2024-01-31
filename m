Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72E13C48285
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 20:08:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVGsS-0001XL-M8; Wed, 31 Jan 2024 15:08:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rVGsP-0001TU-2Y
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 15:08:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rVGsK-0004M5-UB
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 15:08:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706731678;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y5Mf0qi5Hxy/Lp/l8KyUig46jKudaG9NcB/nMFKvtz0=;
 b=jCtvg3mVDtk+6uQQoc+DgY1J7D3T8mWbXq/Jvx8oqmRF0+KmEaY6rciEbXw9ulKSLfzgfv
 /Z9EKQgERBhCy2gbS7Op8Fa2UBEN13L0VEvNnAbb8FCIoYrDQlBtXa2psk3Ylt9vAyvSYJ
 +ZE+zscCXJNiFSVprmLIP4Y77I5a3Qk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-228-TeB18FYjM_K01HKZs_Yteg-1; Wed, 31 Jan 2024 15:07:56 -0500
X-MC-Unique: TeB18FYjM_K01HKZs_Yteg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2D2AC83FC21;
 Wed, 31 Jan 2024 20:07:56 +0000 (UTC)
Received: from localhost (unknown [10.39.192.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 866862166B31;
 Wed, 31 Jan 2024 20:07:55 +0000 (UTC)
Date: Wed, 31 Jan 2024 15:07:53 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, sgarzare@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH] blkio: Respect memory-alignment for bounce buffer
 allocations
Message-ID: <20240131200753.GA396296@fedora>
References: <20240131173140.42398-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="0qFIV7VvXMUDAuuP"
Content-Disposition: inline
In-Reply-To: <20240131173140.42398-1-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--0qFIV7VvXMUDAuuP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 06:31:40PM +0100, Kevin Wolf wrote:
> blkio_alloc_mem_region() requires that the requested buffer size is a
> multiple of the memory-alignment property. If it isn't, the allocation
> fails with a return value of -EINVAL.
>=20
> Fix the call in blkio_resize_bounce_pool() to make sure the requested
> size is properly aligned.
>=20
> I observed this problem with vhost-vdpa, which requires page aligned
> memory. As the virtio-blk device behind it still had 512 byte blocks, we
> got bs->bl.request_alignment =3D 512, but actually any request that needed
> a bounce buffer and was not aligned to 4k would fail without this fix.
>=20
> Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/blkio.c | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--0qFIV7VvXMUDAuuP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmW6qJkACgkQnKSrs4Gr
c8jFFAgAwjMmH6I9PkJ48D4vJEGJQHCZuV+lCiiwtp00iqdyBLwJCgWQeXt+KYrr
MpJM7WJzTFE19ts5Ia9BGtdjWXu9qQV+flhEJ7SzbJVYWdeBK8MRBhUz7CtlOk/u
yVus/2JXvIpsYuO4dnTV2DVI8hERo+qxnWkQHmEu0m2M7NQHhvaZunEInT9T7yvS
9xfZvkwJiu8oAPD8asjgZgew9Vc+uGs1CWg8xfBItb1JeU/mV8GmWgMoKW/eLa8y
YvySInSfDaB16aAbqk3D+kwvryYyrDkyQw1j29p8qJKB0pNxmbfSpEJMAJDC7MO4
149dW4wsdSblMqp6JE0QITIvV+CV7g==
=4DoC
-----END PGP SIGNATURE-----

--0qFIV7VvXMUDAuuP--


