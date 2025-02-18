Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70264C021AD
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 10:34:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkKvO-0001tx-OQ; Tue, 18 Feb 2025 05:33:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tkKvM-0001ta-F4
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 05:33:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tkKvJ-0000qW-0H
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 05:33:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739874831;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pUsqBn6fYn0uyn1QmYU6H7O/9MIeee2D5sCh6guc9qI=;
 b=P6JvRkgJcoRHs1LXqpQBM/09He81sDyyZpL+7alAM1tflDIKZxUgBBrc3H++mrBe0HVb4r
 TIEyeBifjppBqoBKySqdXtVfXu7OETp1JvZdBYyCTasfb9JW3iuoTg2xYb3587dS6KHKxQ
 286FkUSksnNaysWAggtmWj9JXt/y1kM=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-657-3glkvNaBN42NxoD1gBlc4A-1; Tue,
 18 Feb 2025 05:33:48 -0500
X-MC-Unique: 3glkvNaBN42NxoD1gBlc4A-1
X-Mimecast-MFC-AGG-ID: 3glkvNaBN42NxoD1gBlc4A_1739874828
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 87B701903080; Tue, 18 Feb 2025 10:33:47 +0000 (UTC)
Received: from localhost (unknown [10.2.16.24])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8B7E21800362; Tue, 18 Feb 2025 10:33:44 +0000 (UTC)
Date: Tue, 18 Feb 2025 18:33:42 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Albert Esteve <aesteve@redhat.com>
Cc: qemu-devel@nongnu.org, slp@redhat.com, stevensd@chromium.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>, david@redhat.com,
 hi@alyssa.is, mst@redhat.com, jasowang@redhat.com
Subject: Re: [PATCH v4 5/9] vhost_user.rst: Add GET_SHMEM_CONFIG message
Message-ID: <20250218103342.GI10767@fedora>
References: <20250217164012.246727-1-aesteve@redhat.com>
 <20250217164012.246727-6-aesteve@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="NH0KEZagrvp2FAPb"
Content-Disposition: inline
In-Reply-To: <20250217164012.246727-6-aesteve@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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


--NH0KEZagrvp2FAPb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2025 at 05:40:08PM +0100, Albert Esteve wrote:
> Add GET_SHMEM_CONFIG vhost-user frontend
> message to the spec documentation.
>=20
> Reviewed-by: Alyssa Ross <hi@alyssa.is>
> Signed-off-by: Albert Esteve <aesteve@redhat.com>
> ---
>  docs/interop/vhost-user.rst | 39 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--NH0KEZagrvp2FAPb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAme0YgYACgkQnKSrs4Gr
c8ikSQf/fj49jiSN8HpzFDH0C4ww5FkyF+IfYHWllNdcoH0LtRvc0PYNpBAdzP+B
MI+BTkky7bFJrMXlEAPCPGUbD7hGI0G3nzeHFOKhHGkLwA/0sutgu3ajeLaSd5ka
zZWm/YotVzCRhX0E3hHCYP/yU4EM4CVIWaD/wlB4N2wH9fac2MpybYB6rPrhIQe4
eKSesvKuArseNlt75YnupODp7PJB87WEVg6sEGzVy58ILpCbkHOk9fbTiEMqE0G5
wjRs6YtrS+RS3xZFyMa6spfTrk7r0UkwbajFS2lJLHw/3GS7I7uF1KIWtCYVUd0L
rk7Drugj015ujcygLbNQzNthISALJQ==
=nZMb
-----END PGP SIGNATURE-----

--NH0KEZagrvp2FAPb--


