Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2771AC3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 19:59:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX4cM-0005ab-5G; Thu, 25 Jul 2024 15:59:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sX4cK-0005VU-RR
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 15:59:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sX4cJ-0002tz-8q
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 15:59:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721937549;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=92Vgcu5AHxv5Z65unevQP4WF0nEFZPbv+kNAVnOzly4=;
 b=JsRgxroKnXZDWhGLI2FgiWWQY9HyY0sOenYyiYYPD+JxOBKQtfxSXHOvfXVaOMezLi8lmt
 l0svAH3UV02BT330qYXQPSvybcUHO+6Bu3KOIEJEQLyMb7rLbJ24Yhgg8CmjNQeOGcsab1
 RiC8RGSm5mWRjq0w+nppbv+N5pg2/Nw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-658-qlVgJVZnO22h6l-eL-tREw-1; Thu,
 25 Jul 2024 15:57:53 -0400
X-MC-Unique: qlVgJVZnO22h6l-eL-tREw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8B2DD1955F3B; Thu, 25 Jul 2024 19:57:51 +0000 (UTC)
Received: from localhost (unknown [10.2.16.100])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D04331955F6B; Thu, 25 Jul 2024 19:57:49 +0000 (UTC)
Date: Thu, 25 Jul 2024 15:57:48 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org,
 Fam Zheng <fam@euphon.net>, qemu-block@nongnu.org
Subject: Re: [PATCH] util/async.c: Forbid negative min/max in
 aio_context_set_thread_pool_params()
Message-ID: <20240725195748.GB444989@fedora.redhat.com>
References: <20240723150927.1396456-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="vCz+oJjnFuJGFxIU"
Content-Disposition: inline
In-Reply-To: <20240723150927.1396456-1-peter.maydell@linaro.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


--vCz+oJjnFuJGFxIU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2024 at 04:09:27PM +0100, Peter Maydell wrote:
> aio_context_set_thread_pool_params() takes two int64_t arguments to
> set the minimum and maximum number of threads in the pool.  We do
> some bounds checking on these, but we don't catch the case where the
> inputs are negative.  This means that later in the function when we
> assign these inputs to the AioContext::thread_pool_min and
> ::thread_pool_max fields, which are of type int, the values might
> overflow the smaller type.
>=20
> A negative number of threads is meaningless, so make
> aio_context_set_thread_pool_params() return an error if either min or
> max are negative.
>=20
> Resolves: Coverity CID 1547605
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  util/async.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks, applied to my block tree:
https://gitlab.com/stefanha/qemu/commits/block

Stefan

--vCz+oJjnFuJGFxIU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmairjwACgkQnKSrs4Gr
c8hYgAgAsVdwIMFwvfuQ54nNXhNiYjNJh6O1dHFgnNaP3qc6EEiXAFMLMKTaHlWm
b3/JszgsoxfVof4voAFTXKnSZIrdho8zOsNymjKAvA5NBztfMDGgMdwq75P9lXq7
cwuNbOydWZSZMp49+4EXX/XnCuFy1CjOQy8ghCFCxiS7co1EBDSocnY9iBQRO/ZC
lF3q1CiQn+Hgv8rF/rRWQGX7MGxC5BxGkF02kreLiH8B4qhxKlXEjBAmHJF9SLlq
461ARdgmb9+mkq6EUcsoKsT5nJwprlzpiRaMzhDCLSNCcFdDzLtypOKsYUpNkySM
XVjyBCCrVVig9Wb4wYv8TW85ErIOPQ==
=m//w
-----END PGP SIGNATURE-----

--vCz+oJjnFuJGFxIU--


