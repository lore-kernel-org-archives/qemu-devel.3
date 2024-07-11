Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52BE8C3DA47
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 08:56:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRpac-0003t7-Fk; Thu, 11 Jul 2024 04:55:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sRpab-0003o0-Py
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 04:55:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sRpaY-0005I9-Ua
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 04:55:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720688141;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3f5yvUOAOZqcUwmqXEuHcHfKsxYIPrhwUGS0BF8Cskc=;
 b=DmGQYO5Ce/qJ4dLubmOdHMDzHrJWoKd6oceuXPvQgt+HwZqxlZP9gNHTwxumRK1w8xR6GL
 +P/rJfJIo1zeOkeMAdro6j1ZU1XeC9dxveOHXMWttuIcYLwo4FgyO2Qt27AF8yaARuyxxQ
 e304KUGQT/rHNBdG+3WSg8Wja+RcIjo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-461-J85exb-GMfqsQa8EioFiEA-1; Thu,
 11 Jul 2024 04:55:38 -0400
X-MC-Unique: J85exb-GMfqsQa8EioFiEA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C33FD1955F3B; Thu, 11 Jul 2024 08:55:37 +0000 (UTC)
Received: from localhost (unknown [10.39.192.113])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EF1A619560AE; Thu, 11 Jul 2024 08:55:34 +0000 (UTC)
Date: Thu, 11 Jul 2024 10:55:33 +0200
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Albert Esteve <aesteve@redhat.com>
Cc: qemu-devel@nongnu.org, jasowang@redhat.com, david@redhat.com,
 slp@redhat.com, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC PATCH v2 5/5] vhost_user: Implement mem_read/mem_write
 handlers
Message-ID: <20240711085533.GG563880@dynamic-pd01.res.v6.highway.a1.net>
References: <20240628145710.1516121-1-aesteve@redhat.com>
 <20240628145710.1516121-6-aesteve@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="K6/3SoEPIJTffYoJ"
Content-Disposition: inline
In-Reply-To: <20240628145710.1516121-6-aesteve@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--K6/3SoEPIJTffYoJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 28, 2024 at 04:57:10PM +0200, Albert Esteve wrote:
> Implement function handlers for memory read and write
> operations.
>=20
> Signed-off-by: Albert Esteve <aesteve@redhat.com>
> ---
>  hw/virtio/vhost-user.c | 34 ++++++++++++++++++++++++++++++----
>  1 file changed, 30 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index 18cacb2d68..79becbc87b 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -1884,16 +1884,42 @@ static int
>  vhost_user_backend_handle_mem_read(struct vhost_dev *dev,
>                                     VhostUserMemRWMsg *mem_rw)
>  {
> -    /* TODO */
> -    return -EPERM;
> +    ram_addr_t offset;
> +    int fd;
> +    MemoryRegion *mr;
> +   =20
> +    mr =3D vhost_user_get_mr_data(mem_rw->guest_address, &offset, &fd);
> +
> +    if (!mr) {
> +        error_report("Failed to get memory region with address %" PRIx64,
> +                     mem_rw->guest_address);
> +        return -EFAULT;
> +    }
> +
> +    memcpy(mem_rw->data, memory_region_get_ram_ptr(mr) + offset, mem_rw-=
>size);

Don't try to write this from scratch. Use address_space_read/write(). It
supports corner cases like crossing MemoryRegions.

> +
> +    return 0;
>  }
> =20
>  static int
>  vhost_user_backend_handle_mem_write(struct vhost_dev *dev,
>                                     VhostUserMemRWMsg *mem_rw)
>  {
> -    /* TODO */
> -    return -EPERM;
> +    ram_addr_t offset;
> +    int fd;
> +    MemoryRegion *mr;
> +   =20
> +    mr =3D vhost_user_get_mr_data(mem_rw->guest_address, &offset, &fd);
> +
> +    if (!mr) {
> +        error_report("Failed to get memory region with address %" PRIx64,
> +                     mem_rw->guest_address);
> +        return -EFAULT;
> +    }
> +
> +    memcpy(memory_region_get_ram_ptr(mr) + offset, mem_rw->data, mem_rw-=
>size);
> +
> +    return 0;
>  }
> =20
>  static void close_backend_channel(struct vhost_user *u)
> --=20
> 2.45.2
>=20

--K6/3SoEPIJTffYoJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmaPngUACgkQnKSrs4Gr
c8gsDAgAsuJCZVnlcdAiPntW1SK7fxkZJy3Nfp+k3rY6oMQV1gmgZdKrbVjfN3al
X+NVjmaAHK+QtgBXPuv78VmCsAfJhccEo8h7QAW3AcfgnijKpW+boMwNxwIP6tsT
8459guZRf0NKb8mmMUuwxNq3WqSbMYFVTm9QzcRY4GlmuVxg6nM+880AbtcNby0F
bnLIMhXB758HZyDs6zjq3UJxr2yZiyC31TNoEIgxfeUuWVgl1pgiNmuXPLhXdR2z
NUP5VD+g4fwcuYCicteix4vhlEHWVkks70Z7WLtALjRYEh1eCwZ38wVvlCSkTlz5
In+cSMkgRFtWsyiwvo5Wi5nAY+X/Bw==
=BHev
-----END PGP SIGNATURE-----

--K6/3SoEPIJTffYoJ--


