Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88A6FC27C4F
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 20:55:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMZfi-0004rS-EM; Wed, 26 Jun 2024 16:55:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sMZfh-0004rH-0Y
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 16:55:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sMZff-0006T9-Ip
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 16:55:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719435314;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Q0/0BuU7AuVzHzLa0zMypCTBGwoBkwfTtssoa9w9xU0=;
 b=V1ML9qR0cnc7g/9wf+ZNyGBzOiUOjY1ovDNYPIKr7lIdjgNsbe1pkCIFOb8H971gpQonHL
 6qpOG7s54eiYvXps+6BCD99tsT4NqLkTKW/waMcp6lGjNepV1IvgwoUj83+l3y01SDN54a
 ryXS0LX4CSVzSwaN1/dzercMVDv16cw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-298-A6OHa_RUMz-bjO5u45Y8oA-1; Wed,
 26 Jun 2024 16:55:11 -0400
X-MC-Unique: A6OHa_RUMz-bjO5u45Y8oA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F3F0919560AF; Wed, 26 Jun 2024 20:55:07 +0000 (UTC)
Received: from localhost (unknown [10.39.192.29])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 722021956087; Wed, 26 Jun 2024 20:55:06 +0000 (UTC)
Date: Wed, 26 Jun 2024 16:55:04 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Changqi Lu <luchangqi.123@bytedance.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com,
 hreitz@redhat.com, fam@euphon.net, ronniesahlberg@gmail.com,
 pbonzini@redhat.com, pl@dlhnet.de, kbusch@kernel.org,
 its@irrelevant.dk, foss@defmacro.it, philmd@linaro.org,
 pizhenwei@bytedance.com
Subject: Re: [PATCH v6 04/10] scsi/util: add helper functions for persistent
 reservation types conversion
Message-ID: <20240626205504.GD2529519@fedora.redhat.com>
References: <20240613071327.2498953-1-luchangqi.123@bytedance.com>
 <20240613071327.2498953-5-luchangqi.123@bytedance.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="T/pc96+KM8qEpxtS"
Content-Disposition: inline
In-Reply-To: <20240613071327.2498953-5-luchangqi.123@bytedance.com>
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


--T/pc96+KM8qEpxtS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 03:13:21PM +0800, Changqi Lu wrote:
> This commit introduces two helper functions
> that facilitate the conversion between the
> persistent reservation types used in the SCSI
> protocol and those used in the block layer.
>=20
> Signed-off-by: Changqi Lu <luchangqi.123@bytedance.com>
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> ---
>  include/scsi/utils.h |  8 +++++
>  scsi/utils.c         | 81 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 89 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--T/pc96+KM8qEpxtS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmZ8gCgACgkQnKSrs4Gr
c8jiAAf/RwysrYd1T5ezYs9qMKHltmnVGxrro0PudVzeLSnS8SclBaOZzOBgEFzM
Tap0t7EWY8tR7R8zxnBNR72tu0hUVtBL2UXOpPsNKutGlbP5ahFod5tkeZ/J29PM
qHzvyDuF16z9q+o7yp89hRP0U2z3YmxIuyTfA//wA0+i/gFXpN2S5Nt68wKpk9s5
CjgHqRVVYngWI3RvB0Bb3FsFQMKXJdEkDvbwNYXS3tWTigs1i6FHVg+KkZ6uVI4r
kll7pu+PCaTItKrAjTPeMlE+HboQ5GrjliUsZw3bMUbV/z4zrtoQ+pTAF2lfsQo4
dECQPsMjw6qC4yQ6aO2LN9USJI+vCA==
=ImYt
-----END PGP SIGNATURE-----

--T/pc96+KM8qEpxtS--


