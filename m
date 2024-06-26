Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17157C27C4F
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 20:07:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMYuC-0003h8-6l; Wed, 26 Jun 2024 16:06:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sMYuA-0003gq-D9
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 16:06:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sMYu7-0005gs-Q5
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 16:06:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719432365;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WRV7G3xdSU2emWbuPmSBBw/rw1yqdwp385XN4StZGE8=;
 b=AVzWmeQIA7A8fWOuG8uYSVNQiyBCvidiNwaXt8+H7fvIrjnJ+6siIDN/ExYHKkBsVpHXMU
 1kmdm+3CukyMDcBOdH7Zjp10Lw4TW5Pf2tsiCcBVz5fKV9C02pjbzBkYODhr5qhJQbo4xH
 ic5CQvPq1pyEZGnqM3/X0DZe5ogjnls=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-533-UE1v6AuDPyuvKuPC0h4oew-1; Wed,
 26 Jun 2024 16:06:01 -0400
X-MC-Unique: UE1v6AuDPyuvKuPC0h4oew-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2657819560B1; Wed, 26 Jun 2024 20:05:57 +0000 (UTC)
Received: from localhost (unknown [10.39.194.188])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A6D0F300021A; Wed, 26 Jun 2024 20:05:53 +0000 (UTC)
Date: Wed, 26 Jun 2024 16:05:51 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Changqi Lu <luchangqi.123@bytedance.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com,
 hreitz@redhat.com, fam@euphon.net, ronniesahlberg@gmail.com,
 pbonzini@redhat.com, pl@dlhnet.de, kbusch@kernel.org,
 its@irrelevant.dk, foss@defmacro.it, philmd@linaro.org,
 pizhenwei@bytedance.com
Subject: Re: [PATCH v6 01/10] block: add persistent reservation in/out api
Message-ID: <20240626200551.GA2529519@fedora.redhat.com>
References: <20240613071327.2498953-1-luchangqi.123@bytedance.com>
 <20240613071327.2498953-2-luchangqi.123@bytedance.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="X8JbQxexzhy1gTtD"
Content-Disposition: inline
In-Reply-To: <20240613071327.2498953-2-luchangqi.123@bytedance.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
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


--X8JbQxexzhy1gTtD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 03:13:18PM +0800, Changqi Lu wrote:
> Add persistent reservation in/out operations
> at the block level. The following operations
> are included:
>=20
> - read_keys:        retrieves the list of registered keys.
> - read_reservation: retrieves the current reservation status.
> - register:         registers a new reservation key.
> - reserve:          initiates a reservation for a specific key.
> - release:          releases a reservation for a specific key.
> - clear:            clears all existing reservations.
> - preempt:          preempts a reservation held by another key.
>=20
> Signed-off-by: Changqi Lu <luchangqi.123@bytedance.com>
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> ---
>  block/block-backend.c             | 403 ++++++++++++++++++++++++++++++
>  block/io.c                        | 163 ++++++++++++
>  include/block/block-common.h      |  40 +++
>  include/block/block-io.h          |  20 ++
>  include/block/block_int-common.h  |  84 +++++++
>  include/sysemu/block-backend-io.h |  24 ++
>  6 files changed, 734 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--X8JbQxexzhy1gTtD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmZ8dJ8ACgkQnKSrs4Gr
c8gtVgf/RlKXC3KJ/UB80gHbhBG1kXBbVPrU8CxPfmBp+ZSHW/hVFF6zUFNsbAVK
/QUAvgFIyE/2qsd5A40lkuhmvd5qsL3VYrFodYVwPj0QocPPRr/UBH5ClZtrldyo
zEE7gInKSyMOJeFL5ncsP1ivnl2U1uG99ggTso/4Y+Eoc4as+xTr1SQysV3QoKux
q/cV18X8ve5Xl9OM1uqc1whpOjs/xVJzm+gjBKo7ARVnodz2izo6hA2uh975RfIb
gFoT8ol7qFB5GrkBz2nuZ4fGO3Cnl/TjOOJhzQcld/GZIJDYsZBe0fdmkYKWYKVf
Ek/CSArxGc/VLBxRW0Q3KR0cJogFzg==
=1Dj2
-----END PGP SIGNATURE-----

--X8JbQxexzhy1gTtD--


