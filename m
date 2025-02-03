Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4654C02192
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 18:56:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tf1by-00063o-UU; Mon, 03 Feb 2025 13:55:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tf1bx-00063W-3j
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 13:55:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tf1bv-00064q-BC
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 13:55:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738608954;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/cwjyogzDGRVb4aXt3lvU8E6FGz7TqrIDASwPXHmJuQ=;
 b=MdGowA9Swu/dsZCBYz4TtbbRon8pHDu6TMqKx+NSyawGpljBMiJaaCumg7m4jtOhWqG+Sd
 pPOIsddf8y0NvSDQnsRjQRARtJ4zuZasOnfl7+hRulT+Q1W6j/8OnlQ/igZyGSEd8dFkGP
 Vm+ytHZVjSGA6VvqOV83W6dqOVpTxi0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-121-n-L98LByPlGighkClSKZEQ-1; Mon,
 03 Feb 2025 13:55:52 -0500
X-MC-Unique: n-L98LByPlGighkClSKZEQ-1
X-Mimecast-MFC-AGG-ID: n-L98LByPlGighkClSKZEQ
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AD03E18009FD; Mon,  3 Feb 2025 18:55:51 +0000 (UTC)
Received: from localhost (unknown [10.2.16.131])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D82781800360; Mon,  3 Feb 2025 18:55:50 +0000 (UTC)
Date: Mon, 3 Feb 2025 13:55:49 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, hreitz@redhat.com, pkrempa@redhat.com,
 peterx@redhat.com, farosas@suse.de, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 09/15] block: Support inactive nodes in blk_insert_bs()
Message-ID: <20250203185549.GK268514@fedora>
References: <20250130171240.286878-1-kwolf@redhat.com>
 <20250130171240.286878-10-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="iGUlqcgj5YAcoH33"
Content-Disposition: inline
In-Reply-To: <20250130171240.286878-10-kwolf@redhat.com>
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


--iGUlqcgj5YAcoH33
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 30, 2025 at 06:12:40PM +0100, Kevin Wolf wrote:
> Device models have a relatively complex way to set up their block
> backends, in which blk_attach_dev() sets blk->disable_perm =3D true.
> We want to support inactive images in exports, too, so that
> qemu-storage-daemon can be used with migration. Because they don't use
> blk_attach_dev(), they need another way to set this flag. The most
> convenient is to do this automatically when an inactive node is attached
> to a BlockBackend that can be inactivated.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/block-backend.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--iGUlqcgj5YAcoH33
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmehETUACgkQnKSrs4Gr
c8hM0gf9HUcbBVUZuUQbLOeoHhUEqqVF86YtTMv+0ezprr11+lY9/d/JtmzGNA5p
nK6OC8MOKolbeu2pqGbM65efSoc9siLORBiaTpJ+2WB3Dye93trDP4o11tsnLsgT
2bFWmWrdTO9dBodt91O/4u2H16kLplL9ZuupXGtdunBMEMr0cIHFDi+MaAo+xMAf
7c0JOjq1CoHY7g2v/QbVr/XSVUAzfWJU0MqgwE8+dEn1KnvSx7nfrVp2FSeGihoc
MFVaGx8rO+s5rTLMdSMEYLgHRJs+eigFnrZsxXMmHb8uxefLMA8hQoAZLkA00OIw
hhSVA2RQvVwXTDb/YBKDuA1P6MNBvA==
=p27q
-----END PGP SIGNATURE-----

--iGUlqcgj5YAcoH33--


