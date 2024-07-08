Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3D40C3271E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 08:12:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQjU7-0000uK-2V; Mon, 08 Jul 2024 04:12:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sQjU5-0000q8-RC
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 04:12:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sQjU3-0008Tg-Ba
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 04:12:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720426346;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jN6gMjA58+s2QbXbotoAvc7SnH4kY+ca2jKvcfPnvII=;
 b=Ke/1eDozKfx8Q9ApZT/pIWrxnJ02+vv4IdFtm7AyHtrrePcAOhq55awvV70aFMQdMcafaQ
 uq3UDXdUSDZAX4IfiGIOvt4urOoeTouWgRDqdS6qrxu01m6OhF/M87CxjEqIib4N750TcE
 Wm+QXNw1qtifRHtpnlPyozQ9gcYBj6I=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-59-bQKFDX_hPMeDlx0dFIFjrg-1; Mon,
 08 Jul 2024 04:12:22 -0400
X-MC-Unique: bQKFDX_hPMeDlx0dFIFjrg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 286961936192; Mon,  8 Jul 2024 08:12:19 +0000 (UTC)
Received: from localhost (unknown [10.39.192.131])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2BD951955F40; Mon,  8 Jul 2024 08:12:15 +0000 (UTC)
Date: Mon, 8 Jul 2024 10:12:14 +0200
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Changqi Lu <luchangqi.123@bytedance.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com,
 hreitz@redhat.com, fam@euphon.net, ronniesahlberg@gmail.com,
 pbonzini@redhat.com, pl@dlhnet.de, kbusch@kernel.org,
 its@irrelevant.dk, foss@defmacro.it, philmd@linaro.org,
 pizhenwei@bytedance.com
Subject: Re: [PATCH v7 08/10] hw/nvme: enable ONCS and rescap function
Message-ID: <20240708081214.GD38033@dynamic-pd01.res.v6.highway.a1.net>
References: <20240705105614.3377694-1-luchangqi.123@bytedance.com>
 <20240705105614.3377694-9-luchangqi.123@bytedance.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="lzI3xZ6eXj8Vi0v2"
Content-Disposition: inline
In-Reply-To: <20240705105614.3377694-9-luchangqi.123@bytedance.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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


--lzI3xZ6eXj8Vi0v2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 05, 2024 at 06:56:12PM +0800, Changqi Lu wrote:
> This commit enables ONCS to support the reservation
> function at the controller level. Also enables rescap
> function in the namespace by detecting the supported reservation
> function in the backend driver.
>=20
> Signed-off-by: Changqi Lu <luchangqi.123@bytedance.com>
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> ---
>  hw/nvme/ctrl.c       | 3 ++-
>  hw/nvme/ns.c         | 5 +++++
>  include/block/nvme.h | 2 +-
>  3 files changed, 8 insertions(+), 2 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--lzI3xZ6eXj8Vi0v2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmaLn14ACgkQnKSrs4Gr
c8ib0wgAqy3JLOBZ3AQ+oWiAvkWotbRIYpJVUQ6uYPy+aPqn1vtjJaOKz2cceXqf
hnU99hBfTeBj/CEFN/iCeA2acMklE9Xs96x9CK6cIzXORzufz6bhanzh0yWj8Mwi
Esi6lWAoq733RV2Jn+DMmwCavvZlxMDKPUZBy+F+Iy/DfLKAEEPS3/DJIaXsLCSM
hSi520OuEHc5a417r7V6FX3EkrGuZX0Q99s3ypFJCnJxmOMRH94JxNtd8DJwcnqQ
vrfKk76bQr0+eP6CtFAp85z0EwsvcB0t8CdL+sU4Bp/GURZuQQT/z4g/zGK4qzr4
FppZxoRsBRXyiXJSJcAZ5Tcc66urRg==
=lbPA
-----END PGP SIGNATURE-----

--lzI3xZ6eXj8Vi0v2--


