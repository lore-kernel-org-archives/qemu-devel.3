Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B22FBCCD193
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 13:27:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vApuu-000527-WC; Mon, 20 Oct 2025 09:27:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vAput-00051V-Tw
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 09:27:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vApur-0000Lx-L8
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 09:27:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760966829;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YB/Z9ejQFZAvtrInvkuwb8JbrNKabRnYiGvdSXku0pk=;
 b=H0RUIdOiZKtZAq2IcYUsbfwKf5WsweunJcuNMg27MSQ+8aMB9cU2W1tCRFfboXfO1lnHc4
 LwwHREURIBNDJN8BU9ouAxlHn0kCg0+GO/McXUaPAJagUNruT0rJXiKaEytqsehd8NnN1Z
 T1lZxQNpf7J2Kxd8d9tiA7AjCUU6GyU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-324-LxrD6kRzOR-iHZUtkY3HwQ-1; Mon,
 20 Oct 2025 09:27:04 -0400
X-MC-Unique: LxrD6kRzOR-iHZUtkY3HwQ-1
X-Mimecast-MFC-AGG-ID: LxrD6kRzOR-iHZUtkY3HwQ_1760966823
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C9E881801BC0; Mon, 20 Oct 2025 13:27:02 +0000 (UTC)
Received: from localhost (unknown [10.2.16.105])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 25A9519560AD; Mon, 20 Oct 2025 13:27:00 +0000 (UTC)
Date: Mon, 20 Oct 2025 09:27:00 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Albert Esteve <aesteve@redhat.com>
Cc: qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 hi@alyssa.is, david@redhat.com, jasowang@redhat.com,
 dbassey@redhat.com, stevensd@chromium.org,
 Stefano Garzarella <sgarzare@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, slp@redhat.com,
 manos.pitsidianakis@linaro.org
Subject: Re: [PATCH v10 3/7] vhost_user.rst: Add SHMEM_MAP/_UNMAP to spec
Message-ID: <20251020132700.GB115852@fedora>
References: <20251016143827.1850397-1-aesteve@redhat.com>
 <20251016143827.1850397-4-aesteve@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="s16N+T6nFgz6FRhL"
Content-Disposition: inline
In-Reply-To: <20251016143827.1850397-4-aesteve@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--s16N+T6nFgz6FRhL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 04:38:23PM +0200, Albert Esteve wrote:
> Add SHMEM_MAP/_UNMAP request to the vhost-user
> spec documentation.
>=20
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> Signed-off-by: Albert Esteve <aesteve@redhat.com>
> ---
>  docs/interop/vhost-user.rst | 58 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
>=20
> diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
> index 436a94c0ee..8143d56419 100644
> --- a/docs/interop/vhost-user.rst
> +++ b/docs/interop/vhost-user.rst
> @@ -350,6 +350,27 @@ Device state transfer parameters
>    In the future, additional phases might be added e.g. to allow
>    iterative migration while the device is running.
> =20
> +MMAP request
> +^^^^^^^^^^^^
> +
> ++-------+---------+-----------+------------+-----+-------+
> +| shmid | padding | fd_offset | shm_offset | len | flags |
> ++-------+---------+-----------+------------+-----+-------+
> +
> +:shmid: a 8-bit shared memory region identifier
> +
> +:fd_offset: a 64-bit offset of this area from the start
> +            of the supplied file descriptor
> +
> +:shm_offset: a 64-bit offset from the start of the
> +             pointed shared memory region
> +
> +:len: a 64-bit size of the memory to map
> +
> +:flags: a 64-bit value:
> +  - 0: Pages are mapped read-only
> +  - 1: Pages are mapped read-write
> +
>  C structure
>  -----------
> =20
> @@ -375,6 +396,7 @@ In QEMU the vhost-user message is implemented with th=
e following struct:
>            VhostUserInflight inflight;
>            VhostUserShared object;
>            VhostUserTransferDeviceState transfer_state;
> +          VhostUserMMap mmap;
>        };
>    } QEMU_PACKED VhostUserMsg;
> =20
> @@ -1057,6 +1079,7 @@ Protocol features
>    #define VHOST_USER_PROTOCOL_F_XEN_MMAP             17
>    #define VHOST_USER_PROTOCOL_F_SHARED_OBJECT        18
>    #define VHOST_USER_PROTOCOL_F_DEVICE_STATE         19
> +  #define VHOST_USER_PROTOCOL_F_SHMEM                20
> =20
>  Front-end message types
>  -----------------------
> @@ -1865,6 +1888,41 @@ is sent by the front-end.
>    when the operation is successful, or non-zero otherwise. Note that if =
the
>    operation fails, no fd is sent to the backend.
> =20
> +``VHOST_USER_BACKEND_SHMEM_MAP``
> +  :id: 9
> +  :equivalent ioctl: N/A
> +  :request payload: fd and ``struct VhostUserMMap``
> +  :reply payload: N/A
> +
> +  When the ``VHOST_USER_PROTOCOL_F_SHMEM`` protocol feature has been
> +  successfully negotiated, this message can be submitted by the backends=
 to
> +  advertise a new mapping to be made in a given VIRTIO Shared Memory Reg=
ion.
> +  Upon receiving the message, the front-end will mmap the given fd into =
the
> +  VIRTIO Shared Memory Region with the requested ``shmid``.
> +  If ``VHOST_USER_PROTOCOL_F_REPLY_ACK`` is negotiated, and
> +  back-end set the ``VHOST_USER_NEED_REPLY`` flag, the front-end
> +  must respond with zero when operation is successfully completed,
> +  or non-zero otherwise.
> +
> +  Mapping over an already existing map is not allowed and requests shall=
 fail.
> +  Therefore, the memory range in the request must correspond with a vali=
d,
> +  free region of the VIRTIO Shared Memory Region. Also, note that mappin=
gs
> +  consume resources and that the request can fail when there are no reso=
urces
> +  available.

If you respin this series or send follow-up patches, please extend this
to mention that mappings are automatically unmapped by the frontend
across device reset. This behavior is already implemented in the patch
series but needs to be part of the spec so that spec implementors are
aware of it.

> +
> +``VHOST_USER_BACKEND_SHMEM_UNMAP``
> +  :id: 10
> +  :equivalent ioctl: N/A
> +  :request payload: ``struct VhostUserMMap``
> +  :reply payload: N/A
> +
> +  When the ``VHOST_USER_PROTOCOL_F_SHMEM`` protocol feature has been
> +  successfully negotiated, this message can be submitted by the backends=
 so
> +  that the front-end un-mmaps a given range (``shm_offset``, ``len``) in=
 the
> +  VIRTIO Shared Memory Region with the requested ``shmid``. Note that the
> +  given range shall correspond to the entirety of a valid mapped region.
> +  A reply is generated indicating whether unmapping succeeded.
> +
>  .. _reply_ack:
> =20
>  VHOST_USER_PROTOCOL_F_REPLY_ACK
> --=20
> 2.49.0
>=20

--s16N+T6nFgz6FRhL
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmj2OKQACgkQnKSrs4Gr
c8i9pQf8DvJuVEGUndPRrSKKTpXDlxYc6yqZi6gx1iY2kjaeotGbE1J2BF2uwOfu
D8GMuXvjTImJfi16YEFfGBVso0XGXFtD3omlwf+hg0PmxBrIphRBZzy0jrDbBbuQ
ptUfKFOCOu3p1r9YkEb4oIOi2fwaiBih+MBU1xyiYLqb/ZSuTPwseZedRxEfIiva
ZFYdE/auCWN98JoxyHSssSfXgU+wo0ZqBraONVe5th3qJbP97bBr1QvvDfuQKdd8
WN/d8TvnrzGP+neYRq+VBsrRx6aOw8E7wKkPGcD3VI0e8O7/hBSKiQTFkUx/kde3
67wzhOb7lnNGYcVOdH7kmK0yksUmEw==
=u9cd
-----END PGP SIGNATURE-----

--s16N+T6nFgz6FRhL--


