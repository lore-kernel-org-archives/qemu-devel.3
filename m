Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A17FC3ABB2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2024 16:56:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqF1D-0004Wq-PA; Mon, 16 Sep 2024 12:56:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sqF1C-0004W6-49
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 12:56:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sqF19-0006qM-K0
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 12:56:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726505760;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gEjsWsVIRGI6BJNvyUbYDEohXBTCJ5WCpfK1eRXRiMc=;
 b=JSTRZQ6MQqBAv7EAQerXkYaumyU2Septh+3hJKEGBYeJpPb2sqroQrKBWZNFjWW+zE85pk
 0huKy4s0OYWSJJl2T4Fhd6+SejIyOw9um7lY/0EXGSSlR2vY1WDU/44WE+CKbH0kWhzEIY
 Jhiq09O+278ZgVOQyr4gTXRmqX3qvgc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-482-Xz74hy2ZNTOF3DAnga4w1w-1; Mon,
 16 Sep 2024 12:55:59 -0400
X-MC-Unique: Xz74hy2ZNTOF3DAnga4w1w-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D084D1955D48; Mon, 16 Sep 2024 16:55:57 +0000 (UTC)
Received: from localhost (unknown [10.2.16.252])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0BFDA1956086; Mon, 16 Sep 2024 16:55:55 +0000 (UTC)
Date: Mon, 16 Sep 2024 18:55:54 +0200
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Albert Esteve <aesteve@redhat.com>
Cc: qemu-devel@nongnu.org, slp@redhat.com, hi@alyssa.is, mst@redhat.com,
 Stefano Garzarella <sgarzare@redhat.com>, david@redhat.com,
 stevensd@chromium.org, jasowang@redhat.com
Subject: Re: [PATCH 0/3] Document SHMEM vhost-user requests
Message-ID: <20240916165554.GD521955@fedora.home>
References: <20240912144432.126717-1-aesteve@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="TTYGSIlri4ypp21r"
Content-Disposition: inline
In-Reply-To: <20240912144432.126717-1-aesteve@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--TTYGSIlri4ypp21r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 04:44:29PM +0200, Albert Esteve wrote:
> As a continuation of the
> "Add SHMEM_MAP/UNMAP requests" patch [1],
> I wanted to split vhost-user spec
> parts into a separate patch, so that
> it could be reviewed and integrated
> separately. Having the specs upstreamed
> would help others to add support for
> these new vhost-user requests on
> their systems.
>=20
> This is such documentation-only patch.

The spec changes do not mention that exposing VIRTIO Shared Memory
Regions can lead to problems when other vhost-user devices attempt to
access those memory addresses. Please either introduce MEM_READ/WRITE
and explain its use or document that front-ends must forward mappings to
back-ends so that VIRTIO Shared Memory Regions can be accessed.

>=20
> [1] - https://lore.kernel.org/all/20240628145710.1516121-1-aesteve@redhat=
=2Ecom/T/
>=20
> Albert Esteve (3):
>   vhost_user.rst: Add SHMEM_MAP/_UNMAP to spec
>   vhost_user.rst: Align VhostUserMsg excerpt members
>   vhost_user.rst: Add GET_SHMEM_CONFIG message
>=20
>  docs/interop/vhost-user.rst | 72 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 72 insertions(+)
>=20
> --=20
> 2.45.2
>=20

--TTYGSIlri4ypp21r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmboYxoACgkQnKSrs4Gr
c8il7Qf/WF/41JvXBZ94o926lyG4DIJtklX++9pvKsWrxCYVYwtb5lPM5x/o1BK7
b0TB3R8SDcUwIVGw2rPfOaEuozuPg9v+wx+a0CCr9kzx+TIjkiQk/paEXjbcBWTw
bnq5EbmOKfBIPpQiJvNRWa+gaG3GcTfbyUgsF7U7GkCsDAbHM+rVpLr2CPwnCeW/
o95iG+eFlS2wTU2Nd//i/u8SYQ4faft96UjsusDPZdE54uzPNO2c6M9t90rALbP+
iHMaa22B2bF1bPz1nVeYbj3CU7iOqVWqMFazzTAN+pRgntIPgs8G3ryx/W5en3nT
eZSmhUn9C7JhfV1A+Wce4onewIA/bw==
=iqxh
-----END PGP SIGNATURE-----

--TTYGSIlri4ypp21r--


