Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F4156C3ABB2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2024 16:30:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqEbY-0001XJ-CF; Mon, 16 Sep 2024 12:29:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sqEbV-0001Ut-M3
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 12:29:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sqEbS-00041a-Ix
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 12:29:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726504167;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RYEy5iug9xn3D4xWzZA0CnEb/lj2T4uKXrK9yzW70LM=;
 b=MuGckZYt5/qvGnF3w4GmUGiPolkT9uWn1HBAWcQ65drcLpV53UGWbbD18Ywt0Vg438AGff
 ljtiueJyCF16k1cvkkNiaGSjTFU1M65XAC2NbC7Z6vbiPfelLeDkWzMeF76SIDcroWh8po
 phxiFYG8EIHvKoJu19O6z9PzHD9yhoY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-695-RRQ-byQhPLqoLpp5kNwBRQ-1; Mon,
 16 Sep 2024 12:29:22 -0400
X-MC-Unique: RRQ-byQhPLqoLpp5kNwBRQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 324FB196CE1D; Mon, 16 Sep 2024 16:29:21 +0000 (UTC)
Received: from localhost (unknown [10.2.16.252])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1683D19560AF; Mon, 16 Sep 2024 16:29:18 +0000 (UTC)
Date: Mon, 16 Sep 2024 18:29:17 +0200
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Albert Esteve <aesteve@redhat.com>
Cc: qemu-devel@nongnu.org, slp@redhat.com, hi@alyssa.is, mst@redhat.com,
 Stefano Garzarella <sgarzare@redhat.com>, david@redhat.com,
 stevensd@chromium.org, jasowang@redhat.com
Subject: Re: [PATCH 1/3] vhost_user.rst: Add SHMEM_MAP/_UNMAP to spec
Message-ID: <20240916162917.GA521955@fedora.home>
References: <20240912144432.126717-1-aesteve@redhat.com>
 <20240912144432.126717-2-aesteve@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="s1momRX91/Fx6ukP"
Content-Disposition: inline
In-Reply-To: <20240912144432.126717-2-aesteve@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
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


--s1momRX91/Fx6ukP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 04:44:30PM +0200, Albert Esteve wrote:
> Add SHMEM_MAP/_UNMAP request to the vhost-user
> spec documentation.
>=20
> Signed-off-by: Albert Esteve <aesteve@redhat.com>
> ---
>  docs/interop/vhost-user.rst | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>=20
> diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
> index d8419fd2f1..d680fea4a3 100644
> --- a/docs/interop/vhost-user.rst
> +++ b/docs/interop/vhost-user.rst
> @@ -369,6 +369,7 @@ In QEMU the vhost-user message is implemented with th=
e following struct:
>            VhostUserConfig config;
>            VhostUserVringArea area;
>            VhostUserInflight inflight;
> +          VhostUserMMap mmap;
>        };
>    } QEMU_PACKED VhostUserMsg;
> =20
> @@ -1859,6 +1860,36 @@ is sent by the front-end.
>    when the operation is successful, or non-zero otherwise. Note that if =
the
>    operation fails, no fd is sent to the backend.
> =20
> +``VHOST_USER_BACKEND_SHMEM_MAP``
> +  :id: 9
> +  :equivalent ioctl: N/A
> +  :request payload: fd and ``struct VhostUserMMap``

Where is struct VhostUserMMap defined? Please keep patches
self-contained and in a logical order so they can be reviewed linearly.

Otherwise:
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

> +  :reply payload: N/A
> +
> +  This message can be submitted by the backends to advertise a new mappi=
ng
> +  to be made in a given VIRTIO Shared Memory Region. Upon receiving the =
message,
> +  The front-end will mmap the given fd into the VIRTIO Shared Memory Reg=
ion
> +  with the requested ``shmid``. A reply is generated indicating whether =
mapping
> +  succeeded.
> +
> +  Mapping over an already existing map is not allowed and request shall =
fail.
> +  Therefore, the memory range in the request must correspond with a vali=
d,
> +  free region of the VIRTIO Shared Memory Region. Also, note that mappin=
gs
> +  consume resources and that the request can fail when there are no reso=
urces
> +  available.
> +
> +``VHOST_USER_BACKEND_SHMEM_UNMAP``
> +  :id: 10
> +  :equivalent ioctl: N/A
> +  :request payload: ``struct VhostUserMMap``
> +  :reply payload: N/A
> +
> +  This message can be submitted by the backends so that the front-end un=
-mmap
> +  a given range (``shm_offset``, ``len``) in the VIRTIO Shared Memory Re=
gion
> +  with the requested ``shmid``. Note that the given range shall correspo=
nd to
> +  the entirety of a valid mapped region.
> +  A reply is generated indicating whether unmapping succeeded.
> +
>  .. _reply_ack:
> =20
>  VHOST_USER_PROTOCOL_F_REPLY_ACK
> --=20
> 2.45.2
>=20

--s1momRX91/Fx6ukP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmboXN0ACgkQnKSrs4Gr
c8jHNAgAsyeEMFc7SGsiXcHEP2QUnvq0/xCFlTjvQ7yKi/NazkSy0CU9m6fBK/73
sJtcp4qgCCE9shPn0D8kyt3jt1zPU7dcpOHck160nugQljG6MEBWp49fWjb/l1vh
sWVyge+fdw1rrrmZpHYMVKqxNBfgmUOyeRxBfLvGGDgKBD4nU44gtsgIwgb/08H5
8Vy160wUWPh0rn3WXr9GNFN2zOUICT8+TMjJ/lBxXKNsi3vIV1RBlYuooJ3kWARW
Hp8P/WinBVeFVULx9w4OcHetw6Zvzz33kZwbOAkpVn3TkmFpEc8w3zqeRKSuKVXs
AJV7XL1FOgPHn4kyxG+XeKBn9Bnceg==
=4AE1
-----END PGP SIGNATURE-----

--s1momRX91/Fx6ukP--


