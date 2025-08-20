Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A39FCA0EDC
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 20:36:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uopXa-00018J-EB; Wed, 20 Aug 2025 16:36:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uopXX-00017l-Qn
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 16:36:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uopXW-0007h8-8F
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 16:36:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755722169;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SPxi9fCQLQzzZSVIdZN3G83N2/H1ZnJQin2Ay5j8TfY=;
 b=ilGlXBqUVe9/C75/l8qckaAI6QJ1WGLa/Hfb2GzAy2npDjn0F6fguM18L0Er3UCmE6K5wr
 OKdEmJAjQtDED1anlAepm/TyjzZ90mMT3wnS06Vw4bmz4RXoenaUICA6fthagM+eKiDQAa
 0VMbkjG7VxHLuDtr4h7bMIGrZsyYHaw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-538-YiKLZWEHPUmCXupGfinHYA-1; Wed,
 20 Aug 2025 16:36:07 -0400
X-MC-Unique: YiKLZWEHPUmCXupGfinHYA-1
X-Mimecast-MFC-AGG-ID: YiKLZWEHPUmCXupGfinHYA_1755722165
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 85A191800280; Wed, 20 Aug 2025 20:36:05 +0000 (UTC)
Received: from localhost (unknown [10.2.16.103])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9985019560B2; Wed, 20 Aug 2025 20:36:04 +0000 (UTC)
Date: Wed, 20 Aug 2025 16:35:58 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH] hw/virtio: rename vhost-user-device and make user
 creatable
Message-ID: <20250820203558.GA131655@fedora>
References: <20250820195632.1956795-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="m/Bxad+RBNy/9uYR"
Content-Disposition: inline
In-Reply-To: <20250820195632.1956795-1-alex.bennee@linaro.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--m/Bxad+RBNy/9uYR
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 20, 2025 at 08:56:32PM +0100, Alex Benn=E9e wrote:
> We didn't make the device user creatable in the first place because we
> were worried users might get confused. Rename the device to make its
> nature as a test device even more explicit. While we are at it add a
> Kconfig variable so it can be skipped for those that want to thin out
> their build configuration even further.
>=20
> Signed-off-by: Alex Benn=E9e <alex.bennee@linaro.org>
> ---
>  docs/system/devices/vhost-user.rst            | 20 +++++++------------
>  include/hw/virtio/vhost-user-base.h           |  2 +-
>  ...ice-pci.c =3D> vhost-user-test-device-pci.c} | 17 +++++++---------
>  ...user-device.c =3D> vhost-user-test-device.c} |  9 +++------
>  hw/virtio/Kconfig                             |  5 +++++
>  hw/virtio/meson.build                         |  5 +++--
>  6 files changed, 26 insertions(+), 32 deletions(-)
>  rename hw/virtio/{vhost-user-device-pci.c =3D> vhost-user-test-device-pc=
i.c} (77%)
>  rename hw/virtio/{vhost-user-device.c =3D> vhost-user-test-device.c} (87=
%)

It's okay to rename this device since no one today can use
vhost-user-device without modifying QEMU's source code anyway.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--m/Bxad+RBNy/9uYR
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmimMa4ACgkQnKSrs4Gr
c8iOtwf8CQqY3A6ByLX/skN50UknbwuwCayKmADniv85ObtDyKPlEjeRfq5JwYS7
uaAp2F2hPaZS43HeByVGyihJaZNQiQU9KpekiJF4UJ+as8mxa2lFzdI1dJof0D1A
iiDF6q+BhOogpAFq8t+/L61l1xLvvryU1WoP+TkAzuH03CAFhGPsnX5J64rGD8si
XhVA46bdEt3l8gbCEEEaqSVxS7AbyL9ci/EjI4rku4bIgYR8xR44cneRLE1+r7QP
gatB8+cyWgcvM+CscKeTJTuGqBSgTQu6Zh0TxOjx59p1F/0H3nK0hx8QIcexBAJ4
8eHb/SyR6bVIPxvVqeOfsMBlJwrU3w==
=XrFb
-----END PGP SIGNATURE-----

--m/Bxad+RBNy/9uYR--


