Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF01DC83F25
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 18:28:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udvEY-0001E3-4B; Mon, 21 Jul 2025 14:27:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1udvDc-0008Ho-Qe
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 14:26:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1udvDa-00049P-Er
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 14:26:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753122388;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=S7qCr/mywr2lBF0mE8j62WICb3uIxkbX40MCTC/ASow=;
 b=bRutrIrXMz2IUsupLkcoou/evI6YO5NPDt6eWPprmYI5iv/9cBd8VPXQKifidQ9SnEBTw9
 pEIsiItQ/zL2O0aL2y7OKqOMxhkNu/8bHAjYqJHR+ufGT+T81P9lbF2No7LXdHkcl2Al3h
 UbPXoH9IsP2n87btpNGdj+Ru2N7ibjk=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-333-7dvuh2_7PmGGGgCl55QRYw-1; Mon,
 21 Jul 2025 14:26:25 -0400
X-MC-Unique: 7dvuh2_7PmGGGgCl55QRYw-1
X-Mimecast-MFC-AGG-ID: 7dvuh2_7PmGGGgCl55QRYw_1753122383
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A304E1956087; Mon, 21 Jul 2025 18:26:23 +0000 (UTC)
Received: from localhost (unknown [10.2.16.31])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C764D18003FC; Mon, 21 Jul 2025 18:26:22 +0000 (UTC)
Date: Mon, 21 Jul 2025 14:26:21 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Bernd Schubert <bschubert@ddn.com>
Cc: Brian Song <hibriansong@gmail.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "armbru@redhat.com" <armbru@redhat.com>, "fam@euphon.net" <fam@euphon.net>,
 "hreitz@redhat.com" <hreitz@redhat.com>,
 "kwolf@redhat.com" <kwolf@redhat.com>
Subject: Re: [PATCH RFC 1/1] block/export: FUSE-over-io_uring Support for
 QEMU FUSE Exports
Message-ID: <20250721182621.GA69677@fedora>
References: <20250716183824.216257-1-hibriansong@gmail.com>
 <20250716183824.216257-2-hibriansong@gmail.com>
 <e13f8119-7c60-4aa6-91b0-860ac0a462f5@ddn.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="HxFcIozbUr0GIMWq"
Content-Disposition: inline
In-Reply-To: <e13f8119-7c60-4aa6-91b0-860ac0a462f5@ddn.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.926,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


--HxFcIozbUr0GIMWq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 21, 2025 at 01:51:44PM +0000, Bernd Schubert wrote:
> I need test these flags again, might be worthful for qemu as well
>=20
> 	/* These flags should help to increase performance, but actually
> 	 * make it a bit slower - reason should get investigated.
> 	 */
> 	if (0) {
> 		/* Has the main slow down effect */
> 		params.flags |=3D IORING_SETUP_SINGLE_ISSUER;
>=20
> 		// params.flags |=3D IORING_SETUP_DEFER_TASKRUN;
> 		params.flags |=3D IORING_SETUP_TASKRUN_FLAG;
>=20
> 		/* Second main effect to make it slower */
> 		params.flags |=3D IORING_SETUP_COOP_TASKRUN;
> 	}

Yes, they are interesting. Thanks for mentioning them!

An earlier attempt at enabling IORING_SETUP_SINGLE_ISSUER in QEMU (still
needs benchmarking):
https://lore.kernel.org/qemu-devel/174293621917.22751.11381319865102029969-=
0%40git.sr.ht/T/#t

Let's consider these flags as a separate patch series. I have a
benchmarking setup that can be used for measurement, so I'll take this
as a TODO item for myself to work on over the coming days.

Thanks,
Stefan

--HxFcIozbUr0GIMWq
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmh+hk0ACgkQnKSrs4Gr
c8i/Lgf/ViF8yWXPFD6qtmmFGmDNepkMTq+sRU3o9Nep4tCo16fo74/R/mXeyGBi
5lzaiAHMZrst/W+2rvUguRkw2ZJdzYLnHjPTfczeM73MSY6IAdEbFahvha2q4jRW
U8PuO7zs1lTKk7UqAOb7H7q+wi9eVBQG+2ofpmnKwuCI18qmQcQDxVpZVTOnaddj
r2KAr1zPHAZqXf7+KYrMDKYo5VbBAOuO7enRIXvHkjEc8MHtkmDQgJZW53o+jraH
dBB0M9+6qFKyChNnBNVP5aLdO9WTO2vsyNVc9sQcbGV4uLZ+qn/BEGf29ArA7oLH
L8tconjpVwZV0e5GwJogVpwuS/RS/g==
=br2d
-----END PGP SIGNATURE-----

--HxFcIozbUr0GIMWq--


