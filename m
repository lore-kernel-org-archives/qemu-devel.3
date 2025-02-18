Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FC82C021AA
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 11:01:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkLL9-0001YY-48; Tue, 18 Feb 2025 06:00:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tkLL7-0001Y0-7I
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 06:00:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tkLL5-0003c0-HV
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 06:00:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739876428;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eKBnA1TnbEhZVSjSUDSP2sQhUFsDFp5FDx8HitczdtM=;
 b=WOFx+eaCrdE9KAgfAPo5EuBNhwk9M/8WCiYY+odIIHUsYdq2oZhZJXiwa+4aj8rxMAQsZP
 etdXelvtkrz6vc+jn10zDnMVVE5ig6du3nsqmEpMovvlk1WIOLF3tzO5T6M3atJBfbg3Xg
 MESC4mytsuoyW2obFnC2pgEN9jCePD0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-618-uswFftkfMHa5njUh5ERz6g-1; Tue,
 18 Feb 2025 06:00:21 -0500
X-MC-Unique: uswFftkfMHa5njUh5ERz6g-1
X-Mimecast-MFC-AGG-ID: uswFftkfMHa5njUh5ERz6g_1739876420
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7A7C819783B2; Tue, 18 Feb 2025 11:00:20 +0000 (UTC)
Received: from localhost (unknown [10.2.16.24])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5AB9D1800361; Tue, 18 Feb 2025 11:00:19 +0000 (UTC)
Date: Tue, 18 Feb 2025 19:00:17 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Albert Esteve <aesteve@redhat.com>
Cc: qemu-devel@nongnu.org, slp@redhat.com, stevensd@chromium.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>, david@redhat.com,
 hi@alyssa.is, mst@redhat.com, jasowang@redhat.com
Subject: Re: [PATCH v4 9/9] vhost_user.rst: Add MEM_READ/WRITE messages
Message-ID: <20250218110017.GM10767@fedora>
References: <20250217164012.246727-1-aesteve@redhat.com>
 <20250217164012.246727-10-aesteve@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="lsn8N0RWa2sb4g8M"
Content-Disposition: inline
In-Reply-To: <20250217164012.246727-10-aesteve@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


--lsn8N0RWa2sb4g8M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2025 at 05:40:12PM +0100, Albert Esteve wrote:
> Add MEM_READ/WRITE request to the vhost-user
> spec documentation.
>=20
> Signed-off-by: Albert Esteve <aesteve@redhat.com>
> ---
>  docs/interop/vhost-user.rst | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>=20
> diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
> index 96156f1900..9f7a2c4cf7 100644
> --- a/docs/interop/vhost-user.rst
> +++ b/docs/interop/vhost-user.rst
> @@ -391,6 +391,7 @@ In QEMU the vhost-user message is implemented with th=
e following struct:
>            VhostUserTransferDeviceState transfer_state;
>            VhostUserMMap mmap;
>            VhostUserShMemConfig shmem;
> +          VhostUserMemRWMsg mem_rw;

Is this struct defined anywhere in the spec?

>        };
>    } QEMU_PACKED VhostUserMsg;
> =20
> @@ -1938,6 +1939,38 @@ is sent by the front-end.
>    given range shall correspond to the entirety of a valid mapped region.
>    A reply is generated indicating whether unmapping succeeded.
> =20
> +``VHOST_USER_BACKEND_MEM_READ``
> +  :id: 11
> +  :equivalent ioctl: N/A
> +  :request payload: ``struct VhostUserMemRWMsg``
> +  :reply payload: N/A
> +
> +  When the ``VHOST_USER_PROTOCOL_F_SHMEM`` protocol feature has been
> +  successfully negotiated, this message can be submitted by the backends=
 to
> +  read a memory region that has failed to resolve a translation due to an
> +  incomplete memory table, after another device called
> +  ``VHOST_USER_BACKEND_SHMEM_MAP`` for the same region on a shared
> +  descriptor file.
> +
> +  This mechanism works as a fallback for resolving those memory
> +  accesses and ensure that DMA works with Shared Memory Regions.
> +
> +``VHOST_USER_BACKEND_MEM_WRITE``
> +  :id: 12
> +  :equivalent ioctl: N/A
> +  :request payload: ``struct VhostUserMemRWMsg``
> +  :reply payload: N/A
> +
> +  When the ``VHOST_USER_PROTOCOL_F_SHMEM`` protocol feature has been
> +  successfully negotiated, this message can be submitted by the backends=
 to
> +  write a memory region that has failed due to resolve a translation an
> +  incomplete memory table  after another device called
> +  ``VHOST_USER_BACKEND_SHMEM_MAP`` for the same region on a shared
> +  descriptor file.
> +
> +  This mechanism works as a fallback for resolving those memory
> +  accesses and ensure that DMA works with Shared Memory Regions.
> +
>  .. _reply_ack:
> =20
>  VHOST_USER_PROTOCOL_F_REPLY_ACK
> --=20
> 2.48.1
>=20

--lsn8N0RWa2sb4g8M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAme0aEAACgkQnKSrs4Gr
c8g2Xgf/Y9f2Fk3ZycnuKfYgJqBKixmdPwEt82JuOftbd6ToqAQeDLwFpZHlXx7D
52NTNnxpPZtE6uEWJdA40KerR39a+UKpqKKO61nSUKvnv+ERl7eVziNELtU3AcQc
XpbpZQgUJzysGqtxEsqUJjOo+5Gn93+5mciGbXuqFvA38GWT36HmTH5nouT3bwYH
YbMtG/vGhxJypzwi2Fjaq455mKrLHWwotxpsfAtkBftJ+EEII41X8/YHvisK1uWp
vfBMmTx1g3euimkXsHhpH0Z8eRyS1BQLKfsD2FXeexugBViWfk3grie2CLiZp4He
yDQ4s2inExHoIyc6/eOBmClXDSZlRQ==
=0qVu
-----END PGP SIGNATURE-----

--lsn8N0RWa2sb4g8M--


