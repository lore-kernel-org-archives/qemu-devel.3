Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E02A3CDB471
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 14:27:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbfbc-0002QL-GW; Mon, 22 Jun 2026 10:26:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wbfbb-0002Or-6P
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 10:26:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wbfbX-0007hP-6L
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 10:26:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782138385;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Pgdab2ow9J8wzVQo0TYavOwRInHAfzhjbIbiDlaayqc=;
 b=Zsy09t9unaynPzLs2st12WV5v7gEtT6x2QoLokVpMqKGPbqKQocyPndvGcSZqXZoNwWWWj
 WoC3O5eOzsVwrucmdtSoEBvkSB93CiNPBysGgFe7Pl/2MM4NYxnNMkvbDRgz79ooX16joX
 vStwhLmgTv5+MrKqp+OpQFUEugglJNI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-2-yUUUda5GNMaKvjs8WOcfOQ-1; Mon,
 22 Jun 2026 10:26:21 -0400
X-MC-Unique: yUUUda5GNMaKvjs8WOcfOQ-1
X-Mimecast-MFC-AGG-ID: yUUUda5GNMaKvjs8WOcfOQ_1782138380
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 70E301955F75; Mon, 22 Jun 2026 14:26:19 +0000 (UTC)
Received: from localhost (unknown [10.2.16.166])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3C3233001D85; Mon, 22 Jun 2026 14:26:18 +0000 (UTC)
Date: Mon, 22 Jun 2026 10:26:17 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, anjo@rev.ng,
 ale@rev.ng
Subject: Re: [PATCH] target/hexagon: use cmd_array() instead of get_id()
Message-ID: <20260622142617.GA148097@fedora>
References: <20260622052120.2626472-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="jJ2wJxDCDQBlSL0B"
Content-Disposition: inline
In-Reply-To: <20260622052120.2626472-1-brian.cain@oss.qualcomm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


--jJ2wJxDCDQBlSL0B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 21, 2026 at 10:21:20PM -0700, Brian Cain wrote:
> get_id() returns the compiler's short name not a program.
> Passing it directly as the command for the idef-parser preprocessing
> custom_target happened to work for native gcc/clang builds but
> breaks under cross compilers such as emcc or any ccache-wrapped compiler.
>=20
> Link: https://lore.kernel.org/qemu-devel/CAJSP0QWzQEgoYMCgZX+9jCvrV6O3Rqn=
A+df1DpT2R6MZvVXiNg@mail.gmail.com/
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/meson.build | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--jJ2wJxDCDQBlSL0B
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmo5RggACgkQnKSrs4Gr
c8gR+AgAkxfd6CSYv4wLnOvgZUGrOT+0iG52jwxKEi7CqEIhDKnE3sUH1SLoxYx4
h286e1RYRco01+RItiQmnK3+JxVU5YxBCXQIEAmzB5JOCQI3b9bx5o27Qoe4MIBm
uwh82yZ9bKAl0lz8cRuwNWPL6K6XVyQcpRIWbIFMmQtyWIpaFxOCsUaQHt39gOhv
Mau+/giETzOwn4/0/jFqulNCdZXVQIBMbmJaNHADFXR4rmqNi0ZDHzk2l7pXWD6E
9PUH8kfzb43SeEBmXsuvfeDBljvICWr4W2Q8cL7C3LXKv18GqNclL94gAmv2NQsk
eezl4GYPKuY1k0/cRFwsCVkebEYgNQ==
=/5D0
-----END PGP SIGNATURE-----

--jJ2wJxDCDQBlSL0B--


