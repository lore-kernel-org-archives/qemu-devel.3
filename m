Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB240C02198
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 10:35:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkKwI-0003Q2-Qk; Tue, 18 Feb 2025 05:34:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tkKwG-0003Kg-Hk
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 05:34:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tkKwE-0000vC-U2
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 05:34:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739874888;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eqXsQdCyETVXBDyc8fKkkKFuREbDRKhk0jWSXS4PFWM=;
 b=DAmdV0qxTd1g6yeIfTYcgYgnwAdjOcAVXMk7WXcVqbOcZVA9WaNYZQZeGyVjPXEoZzZhde
 asllmaYDFv3oQyF+2IOCQsMQW+AB0JWP5/99p+tYxI91ridap4g+ZDvDmn/pLWMzW1ax7b
 QXAKVUWMpwIC2mo6GLXVHAwpTe939nI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-631-NU4gyrGJN-GvkXY6WPqIlQ-1; Tue,
 18 Feb 2025 05:34:44 -0500
X-MC-Unique: NU4gyrGJN-GvkXY6WPqIlQ-1
X-Mimecast-MFC-AGG-ID: NU4gyrGJN-GvkXY6WPqIlQ_1739874883
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3DF13190F9E7; Tue, 18 Feb 2025 10:34:43 +0000 (UTC)
Received: from localhost (unknown [10.2.16.24])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A9A55180056F; Tue, 18 Feb 2025 10:34:41 +0000 (UTC)
Date: Tue, 18 Feb 2025 18:34:39 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Albert Esteve <aesteve@redhat.com>
Cc: qemu-devel@nongnu.org, slp@redhat.com, stevensd@chromium.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>, david@redhat.com,
 hi@alyssa.is, mst@redhat.com, jasowang@redhat.com
Subject: Re: [PATCH v4 6/9] qmp: add shmem feature map
Message-ID: <20250218103439.GJ10767@fedora>
References: <20250217164012.246727-1-aesteve@redhat.com>
 <20250217164012.246727-7-aesteve@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="TChyE5AXsiAIdZ8m"
Content-Disposition: inline
In-Reply-To: <20250217164012.246727-7-aesteve@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--TChyE5AXsiAIdZ8m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2025 at 05:40:09PM +0100, Albert Esteve wrote:
> Add new vhost-user protocol
> VHOST_USER_PROTOCOL_F_SHMEM feature to
> feature map.
>=20
> Signed-off-by: Albert Esteve <aesteve@redhat.com>
> ---
>  hw/virtio/virtio-qmp.c | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--TChyE5AXsiAIdZ8m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAme0Yj4ACgkQnKSrs4Gr
c8i0AAgApwlztiuH7LjiCE+m+8Bhbu72GfGu9tHCDKYMa3iFzBFkFDMuQKCRxUec
KLXWSldfRnt2EJa4epKSwBzLszzqlO88zonGqVA8JYT1C1YJJ4qK/rcr4E3ITNNM
7UIC4efU4295VKYLU6zWHEo4hw1fJ+GLOKfS4MlkP7QlyjcbPLjyOHZGd6aankcg
f3ZShrmIGaKNyJvV1eemrQoGnkoUCi5KLWJMwpU2cpTAEpoB5e6yQCAQpgejIBUk
gpuqBkEf+KVK++D9mYEkm4nIKJ0cBbPjdh+joaAR0P/KRnllv5I7s3T+98syMpI8
uRyteCCTXma46F9xTdWIf6uCLuOMEA==
=DSer
-----END PGP SIGNATURE-----

--TChyE5AXsiAIdZ8m--


