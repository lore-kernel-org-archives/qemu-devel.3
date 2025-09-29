Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3DD6CAC5B9
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 18:49:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3IvQ-0007fq-Vy; Mon, 29 Sep 2025 14:48:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v3IvP-0007fS-33
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 14:48:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v3IvM-0007xL-18
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 14:48:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759171708;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9Sn+zjcqOYgA1a/HcD8X/6wQrIk9R0rvmvvVFkp1dgE=;
 b=R6dmYKKuhzsnVJkL5OBGxNNubtNZdE/2j8qJVjLPH5BkOI7TGklmiHpFMadCL30UCxdAUT
 TCQx83HVLh15+6o4HahOR30M6dsskylAh5tdUpqUtOCBdI3L22EaJto3wkIfXRLCCp6e4X
 50lFs0m5xRA4g0nY3LWoaG7WTR2qyDw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-85-fFr4FbfXMUqUf9sdPk_FHw-1; Mon,
 29 Sep 2025 14:48:24 -0400
X-MC-Unique: fFr4FbfXMUqUf9sdPk_FHw-1
X-Mimecast-MFC-AGG-ID: fFr4FbfXMUqUf9sdPk_FHw_1759171703
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8CC3C19774DF; Mon, 29 Sep 2025 18:48:23 +0000 (UTC)
Received: from localhost (unknown [10.2.17.29])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 79F9D1800576; Mon, 29 Sep 2025 18:48:21 +0000 (UTC)
Date: Mon, 29 Sep 2025 14:48:20 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Albert Esteve <aesteve@redhat.com>
Cc: qemu-devel@nongnu.org, stevensd@chromium.org, dbassey@redhat.com,
 Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, mst@redhat.com, slp@redhat.com,
 hi@alyssa.is, Fabiano Rosas <farosas@suse.de>,
 Stefano Garzarella <sgarzare@redhat.com>, jasowang@redhat.com,
 david@redhat.com, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v8 3/7] vhost_user.rst: Add SHMEM_MAP/_UNMAP to spec
Message-ID: <20250929184820.GE81824@fedora>
References: <20250910115420.1012191-1-aesteve@redhat.com>
 <20250910115420.1012191-4-aesteve@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qIFFwQ2HTv1mqjJu"
Content-Disposition: inline
In-Reply-To: <20250910115420.1012191-4-aesteve@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


--qIFFwQ2HTv1mqjJu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 01:54:16PM +0200, Albert Esteve wrote:
> Add SHMEM_MAP/_UNMAP request to the vhost-user
> spec documentation.
>=20
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Albert Esteve <aesteve@redhat.com>
> ---
>  docs/interop/vhost-user.rst | 58 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
>=20
> diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
> index 436a94c0ee..dab9f3af42 100644
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

This is inconsistent with patch 1 where this struct field is u16. I
suggest making it u64 everywhere.

--qIFFwQ2HTv1mqjJu
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmja1HQACgkQnKSrs4Gr
c8gmegf8CUIEMDa/bAEPJtA3zt3VDjKeuPPUiln2wMKfIzGPSqc7BkD0Qvz/KwLI
sJ1ZLtWrr2BxjEXJjJAD9RpnTJF+fJ3W8s/yu78drfd/8hj3+XGPZ/m7cyEGvo1m
6QiCjL/z9X/95qFyXfGaj8mvg04+UKxaA/XEuDCz0PlqKclc9EnNygnhS+gjzHri
2FK8Ry9f+dKMbNgKeSg5FkpepIPXWMl3LsrrFnkJCmtuLkb/eIg1Jzlo8/HVCP7p
PTneYclOqxIZgRSrMChPW5fkvm0mC6c75xdqxhXL915gCJaArtMD0jmd7/M2S4+x
B2xmSnZ21ofyBCt9bbF9X46hxBHdWg==
=TzTu
-----END PGP SIGNATURE-----

--qIFFwQ2HTv1mqjJu--


