Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AEE0C3ABB2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2024 16:35:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqEgx-0001pi-Gi; Mon, 16 Sep 2024 12:35:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sqEgv-0001nw-Lg
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 12:35:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sqEgt-0004jJ-K5
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 12:35:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726504505;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ehvEwUUnMFOLibJSVplM93zbOeX9JuQyX2i4fXlCatw=;
 b=hTcWg3JMGNdQB88T4UHAhXmrd/DMFswpRAfop259EFMDNd21DnOrY17aL/dccRRttruhI1
 5wq5nMz/tH9sj+vFiVqC43a17gg6vOv4558FNcLNxcTnfpR7TfCe/R9WuG7RYPjepnqzZv
 gwos8gN73dviLvnJANqiVRaxeLunbI4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-132-g9ZJVCoQNE6BlRYqb3yOiA-1; Mon,
 16 Sep 2024 12:35:01 -0400
X-MC-Unique: g9ZJVCoQNE6BlRYqb3yOiA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E0BF11955D65; Mon, 16 Sep 2024 16:34:59 +0000 (UTC)
Received: from localhost (unknown [10.2.16.252])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6CEC419560A3; Mon, 16 Sep 2024 16:34:58 +0000 (UTC)
Date: Mon, 16 Sep 2024 18:34:56 +0200
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Albert Esteve <aesteve@redhat.com>
Cc: qemu-devel@nongnu.org, slp@redhat.com, hi@alyssa.is, mst@redhat.com,
 Stefano Garzarella <sgarzare@redhat.com>, david@redhat.com,
 stevensd@chromium.org, jasowang@redhat.com
Subject: Re: [PATCH 3/3] vhost_user.rst: Add GET_SHMEM_CONFIG message
Message-ID: <20240916163456.GB521955@fedora.home>
References: <20240912144432.126717-1-aesteve@redhat.com>
 <20240912144432.126717-4-aesteve@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="OCCr/wQvTdDBsS39"
Content-Disposition: inline
In-Reply-To: <20240912144432.126717-4-aesteve@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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


--OCCr/wQvTdDBsS39
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 04:44:32PM +0200, Albert Esteve wrote:
> Add GET_SHMEM_CONFIG vhost-user frontend
> message to the spec documentation.
>=20
> Signed-off-by: Albert Esteve <aesteve@redhat.com>
> ---
>  docs/interop/vhost-user.rst | 39 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
>=20
> diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
> index ec898d2440..fb7b27ce94 100644
> --- a/docs/interop/vhost-user.rst
> +++ b/docs/interop/vhost-user.rst
> @@ -348,6 +348,19 @@ Device state transfer parameters
>    In the future, additional phases might be added e.g. to allow
>    iterative migration while the device is running.
> =20
> +VIRTIO Shared Memory Region configuration
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> ++-------------+---------+------------+----+--------------+
> +| num regions | padding | mem size 0 | .. | mem size 255 |
> ++-------------+---------+------------+----+--------------+
> +
> +:num regions: a 32-bit number of regions

What is the purpose of this field? Does it indicate the number of mem
size elements (i.e. the array can be truncated if there are fewer than
256 elements) or the number of non-zero length elements?

> +
> +:padding: 32-bit
> +
> +:mem size: 64-bit size of VIRTIO Shared Memory Region
> +
>  C structure
>  -----------
> =20
> @@ -372,6 +385,7 @@ In QEMU the vhost-user message is implemented with th=
e following struct:
>            VhostUserShared object;
>            VhostUserTransferDeviceState transfer_state;
>            VhostUserMMap mmap;
> +          VhostUserShMemConfig shmem;
>        };
>    } QEMU_PACKED VhostUserMsg;
> =20
> @@ -1054,6 +1068,7 @@ Protocol features
>    #define VHOST_USER_PROTOCOL_F_XEN_MMAP             17
>    #define VHOST_USER_PROTOCOL_F_SHARED_OBJECT        18
>    #define VHOST_USER_PROTOCOL_F_DEVICE_STATE         19
> +  #define VHOST_USER_PROTOCOL_F_SHMEM                20
> =20
>  Front-end message types
>  -----------------------
> @@ -1728,6 +1743,30 @@ Front-end message types
>    Using this function requires prior negotiation of the
>    ``VHOST_USER_PROTOCOL_F_DEVICE_STATE`` feature.
> =20
> +``VHOST_USER_GET_SHMEM_CONFIG``
> +  :id: 44
> +  :equivalent ioctl: N/A
> +  :request payload: N/A
> +  :reply payload: ``struct VhostUserShMemConfig``
> +
> +  When the ``VHOST_USER_PROTOCOL_F_SHMEM`` protocol feature has been
> +  successfully negotiated, this message can be submitted by the front-end
> +  to gather the VIRTIO Shared Memory Region configuration. Back-end will

"Back-end will" -> "The back-end will"

> +  respond with the number of VIRTIO Shared Memory Regions it requires, a=
nd
> +  each shared memory region size in an array. The shared memory IDs are
> +  represented by the index of the array. The information returned shall

"index of the array" -> either "array index" or "index of the array
element".

> +  comply with the following rules:
> +
> +  * The shared information will remain valid and unchanged for the entire
> +    lifetime of the connection.
> +
> +  * The Shared Memory Region size must be a multiple of the page size
> +    supported by mmap(2).
> +
> +  * The size may be 0 if the region is unused. This can happen when the
> +    device does not support an optional feature but does support a featu=
re
> +    that uses a higher shmid.
> +
>  Back-end message types
>  ----------------------
> =20
> --=20
> 2.45.2
>=20

--OCCr/wQvTdDBsS39
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmboXjAACgkQnKSrs4Gr
c8gIAgf/SwRnwHcW93Q52Z6pxBbIC8Wy7N08UULi3JhcgmyK5XEQhZ4WZbzAAHHN
9psXKjGQ+jk4wTUETCNgoxfRcB1IHKnYVS/uap7jaRpg11ZjkXUE8Lu2J2qrNLUw
ilfmajJMJr5165RbsKA4c4YG06L85JXm9k0XdwVo51LuT9mRwOD8o3S30tPaDJtZ
6xbnYDhzr8L8dhG6jW7MiE2KTuGJIPUZ96oCe8JpoE9tiN8a+NgGyydwOfgejZ3s
LqdCkgFIGMt7Lb9T8mLWqAvdBGfvw9Q0dn5F6p8QV+psiILBU2tPUBdMu65BVUXm
95ofr8yAw7orPH7El581/UDaCpCmPA==
=nAF2
-----END PGP SIGNATURE-----

--OCCr/wQvTdDBsS39--


