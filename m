Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 399F4C3ABD9
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 13:23:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFC4y-00006R-2e; Wed, 14 May 2025 09:23:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uFC21-0006QK-2X
 for qemu-devel@nongnu.org; Wed, 14 May 2025 09:20:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uFC1y-0003ji-Rx
 for qemu-devel@nongnu.org; Wed, 14 May 2025 09:20:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747228817;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pRM1TDvgW+RV5ttYK6nGoQgoJAfUYxhjn2bG25m9g4U=;
 b=Q/nShbn0PnAjdoyfPr76dRilGRkw1E3GjXq2qlKibU0j/1ltwbqerxmTUTRD8NI0n59DiG
 2UhHUu494JvKLJJtDguHGLPa7/JylRxN83x8B37EPz2q0JceO2uvlaXw3bydktHcsn7HIB
 /o2ITMTDleAov129lz+X6D8lixPiIBo=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-407-KMJQQO99N--QmPC5UQCM5g-1; Wed,
 14 May 2025 09:20:15 -0400
X-MC-Unique: KMJQQO99N--QmPC5UQCM5g-1
X-Mimecast-MFC-AGG-ID: KMJQQO99N--QmPC5UQCM5g_1747228814
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 052191956095; Wed, 14 May 2025 13:20:14 +0000 (UTC)
Received: from localhost (unknown [10.2.16.56])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A0D8B1953B80; Wed, 14 May 2025 13:20:13 +0000 (UTC)
Date: Wed, 14 May 2025 09:20:12 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, sunnyzhyy@qq.com,
 vsementsov@yandex-team.ru, John Snow <jsnow@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH v4 14/13] mirror: Reduce I/O when destination is
 detect-zeroes:unmap
Message-ID: <20250514132012.GA265337@fedora>
References: <20250509204341.3553601-15-eblake@redhat.com>
 <20250513220142.535200-2-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="a09RcEafyDB/LYmI"
Content-Disposition: inline
In-Reply-To: <20250513220142.535200-2-eblake@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


--a09RcEafyDB/LYmI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 13, 2025 at 05:00:45PM -0500, Eric Blake wrote:
> If we are going to punch holes in the mirror destination even for the
> portions where the source image is unallocated, it is nicer to treat
> the entire image as dirty and punch as we go, rather than pre-zeroing
> the entire image just to re-do I/O to the allocated portions of the
> image.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  block/mirror.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--a09RcEafyDB/LYmI
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmgkmIwACgkQnKSrs4Gr
c8ghOQgAtyKRBx8fxDLcwKD9v782jeLlQJdhjhUsJi2c/zkypV0KdnBIUAU//H/h
fENksWN/wHgAy5Di+MhH2u65RdjeWGapaFNAzn3WgtSP5xaGvg79QfYl7s3MNIZU
vPg6Q7HUvqn48PeAF0rnw70NrBGnMB6jTNNRsUv0ct8B1YnWE4nZ0exrV1RqzWkB
85WnyNvv/PwWZdidFGke6KNYqXK9OBz5qaO1gTNjgEzxwAeLHOotjxk3+bOfiEKH
kDr8pe9KTJ2nzf8tuasnO4TFrf75RzVUNJFWxvnmJ23dac31OmQVJ8nFFGZi2Gf/
UBwlTNC22lNdRh+wSksCQUb9nLmy+Q==
=w2iG
-----END PGP SIGNATURE-----

--a09RcEafyDB/LYmI--


