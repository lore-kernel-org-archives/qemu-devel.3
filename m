Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65138C6FD1F
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Mar 2024 17:15:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnM0f-0004Fm-Vv; Thu, 21 Mar 2024 13:15:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rnM0d-0004FB-4a
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 13:15:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rnM0b-0006si-Fb
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 13:15:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711041316;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1KSGTchd580cYd4dbbZVRfeAGQy4t+Px2RCVYO9fBOA=;
 b=RPF6G9EbYHICG6Fn0gjpOZpCPGUcigxiOHi4LEpKlw9BHxdUYQ1FhTpqv0HRcAqqb5k5lO
 f4NWntJp17C2l+1u+NBGVK24kEVqN9j2zKTvl9GbwVYfH/bZ2uUcaklrlPMxAlg+oTsMXu
 wgrXEQ4N2mEb1D/szQ5AerT+JEMxOl4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-251-8O9_TjOyP866HmGNEJEfpQ-1; Thu,
 21 Mar 2024 13:15:14 -0400
X-MC-Unique: 8O9_TjOyP866HmGNEJEfpQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CA82B1C0515C
 for <qemu-devel@nongnu.org>; Thu, 21 Mar 2024 17:15:13 +0000 (UTC)
Received: from localhost (unknown [10.39.194.39])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3124810189;
 Thu, 21 Mar 2024 17:15:12 +0000 (UTC)
Date: Thu, 21 Mar 2024 13:15:07 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH] coroutine: reserve 5,000 mappings
Message-ID: <20240321171507.GB1537715@fedora>
References: <20240320181232.1464819-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="6ILooQJJ3/0NNwu2"
Content-Disposition: inline
In-Reply-To: <20240320181232.1464819-1-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.372,
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


--6ILooQJJ3/0NNwu2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 02:12:32PM -0400, Stefan Hajnoczi wrote:
> Daniel P. Berrang=E9 <berrange@redhat.com> pointed out that the coroutine
> pool size heuristic is very conservative. Instead of halving
> max_map_count, he suggested reserving 5,000 mappings for non-coroutine
> users based on observations of guests he has access to.
>=20
> Fixes: 86a637e48104 ("coroutine: cap per-thread local pool size")
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  util/qemu-coroutine.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)

Discussed with Kevin and applied to my block tree:
https://gitlab.com/stefanha/qemu/commits/block

Stefan

--6ILooQJJ3/0NNwu2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmX8axsACgkQnKSrs4Gr
c8iBoAf+K2uncoMa0RaHdAhllTHCXDhaTvKKlz6Hx87WIfvMBOmECKxy80cMX+Ro
ZhBeWshJxH5U+TcKde4/YLirUXRWc21v0VWx7tW4U9Q0YO3xNnLMTAFYVnMPWG8j
IAo7q6mwWezV/Zvd3OPiBacYL5edeC2jcTjA/D8kK9MnesQSr5ZRhM3DhhC0THGi
86S07hPuIQaFlKQYBcUxyJAs4a8egppSuYRE4lneF77QTwVDunXo8xZMpe1fOlXF
E8uGZnDM3wcorj2WrlWv5JpRrC93GqPEEBtZWeXg8rn/aTFfQHuHYN1K5FRwx0xo
DpoDk8t36CV/JHHmm8yrBaBEZ8LOPQ==
=umYY
-----END PGP SIGNATURE-----

--6ILooQJJ3/0NNwu2--


