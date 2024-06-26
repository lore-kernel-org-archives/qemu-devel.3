Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D187C27C4F
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 20:48:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMZXw-0002lI-JM; Wed, 26 Jun 2024 16:47:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sMZXu-0002l0-5K
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 16:47:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sMZXs-0004dw-4f
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 16:47:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719434831;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VBVEaI3KfJuc6ghHFifDdlN2Su7dQQ8C38Pk+4rcGtQ=;
 b=JzXZ2QZEzGS9Qvs1oc1LOnJIUyb+IxTyxwNTQOh07jYGQSdvV6mSVgD6mKK5CRoYWUGeiK
 xAB48ynI7dZnPfHJ5iCst7mMrjG2RxXpPII7ocjgn+fRCUMuw0TPVa3JU1ix2Sbt96DFH8
 SaYV2p2FidbB9mcct8DmLO5u9LNfuXc=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-648-AtTXvNjkM528Oq-w3aiuHA-1; Wed,
 26 Jun 2024 16:47:05 -0400
X-MC-Unique: AtTXvNjkM528Oq-w3aiuHA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8731819560BD; Wed, 26 Jun 2024 20:47:01 +0000 (UTC)
Received: from localhost (unknown [10.39.192.29])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DE8AF1955E82; Wed, 26 Jun 2024 20:46:59 +0000 (UTC)
Date: Wed, 26 Jun 2024 16:46:57 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Changqi Lu <luchangqi.123@bytedance.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com,
 hreitz@redhat.com, fam@euphon.net, ronniesahlberg@gmail.com,
 pbonzini@redhat.com, pl@dlhnet.de, kbusch@kernel.org,
 its@irrelevant.dk, foss@defmacro.it, philmd@linaro.org,
 pizhenwei@bytedance.com
Subject: Re: [PATCH v6 02/10] block/raw: add persistent reservation in/out
 driver
Message-ID: <20240626204657.GB2529519@fedora.redhat.com>
References: <20240613071327.2498953-1-luchangqi.123@bytedance.com>
 <20240613071327.2498953-3-luchangqi.123@bytedance.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="VlhUPVfnvw52bF5H"
Content-Disposition: inline
In-Reply-To: <20240613071327.2498953-3-luchangqi.123@bytedance.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.207,
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


--VlhUPVfnvw52bF5H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 03:13:19PM +0800, Changqi Lu wrote:
> Add persistent reservation in/out operations for raw driver.
> The following methods are implemented: bdrv_co_pr_read_keys,
> bdrv_co_pr_read_reservation, bdrv_co_pr_register, bdrv_co_pr_reserve,
> bdrv_co_pr_release, bdrv_co_pr_clear and bdrv_co_pr_preempt.
>=20
> Signed-off-by: Changqi Lu <luchangqi.123@bytedance.com>
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> ---
>  block/raw-format.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 56 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--VlhUPVfnvw52bF5H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmZ8fkEACgkQnKSrs4Gr
c8juUAgAul+5j0nGoiUcxiADgaOahbI1nV3k1M49FuKFZ3ddwC5k0YAnLZ1ohf3d
CuZZOJF5Z+rVSGtXcfzciFO474pyPRDtbOaBCv1/JnPGmvOeA6GMTLJWwjobBic+
/uASTpcv9drDmIY/xbGxjGSfIiSPtF3JUPSlLBj7CmewGRK1NnOnzMO+JKsCxBxD
iJwEtctETrhYqpv0Sz5KZL4WEyLKIsikA4t7agSX3FJZuC9Tcs0eqZc4RJcfRCqH
+mBF4HNzvNgz463R8HQsUnfKGH09QwJL8QJCNwa4bHrb7zFoc4jZ9laojlok8iH0
S2l+t6hwQDikfpmZH40n9LZShkZWww==
=6vaJ
-----END PGP SIGNATURE-----

--VlhUPVfnvw52bF5H--


