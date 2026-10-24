Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7D5606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 07:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=itx.no header.i=@itx.no header.a=rsa-sha256 header.s=mx.itx.no header.b=nK7dbZ0Z
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKVqv-0007xE-CX; Sat, 24 Oct 2026 03:07:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stian@itx.no>) id 1xKVqt-0007wz-NQ
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 03:07:39 -0400
Received: from itx-kvm-14.itxnorge.no ([91.189.121.228] helo=mx.itxnorge.no)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stian@itx.no>) id 1xKVqs-0008RG-1m
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 03:07:39 -0400
Message-ID: <8481b6eba8443d5a8a64f211870c4f6356597824.camel@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
 t=1792825656;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JBHefpQwvxbz936KN4+29amiP93zgRuq99lWzgNvxrg=;
 b=nK7dbZ0Zo14voDx8on0c14Mh3zEajWysdtzanCye1v3/Qf0yWy6znFKvUs1b2Z46AXgsec
 ldaZLHfpjJe3K+jjNi6qjQA2mRAYkK59rzEZ3cMQUBfPEytdY3y5OoTdJxxf5TOaKUt2d+
 sW4zYcQMkoSt+tzUOZnPfSb9z3NEam0=
Subject: Re: [PATCH] accel/tcg: Do not chain from a TB freed by
 tb_gen_code's flush
From: Stian Halseth <stian@itx.no>
To: Matt Turner <mattst88@gmail.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Date: Sat, 24 Oct 2026 09:07:35 +0200
In-Reply-To: <CAEdQ38HwH9=UfUsVZ68=K0ZPaq7dtgpCk=JK6TU6wb8nUd2X3Q@mail.gmail.com>
References: <20261023113245.562358-1-stian@itx.no>
 <CAEdQ38HwH9=UfUsVZ68=K0ZPaq7dtgpCk=JK6TU6wb8nUd2X3Q@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
 protocol="application/pgp-signature"; boundary="=-XeB5OTvqbUn5gqYQ9MbQ"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Received-SPF: pass client-ip=91.189.121.228; envelope-from=stian@itx.no;
 helo=mx.itxnorge.no
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--=-XeB5OTvqbUn5gqYQ9MbQ
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Matt,

On Fri, 2026-10-23 at 20:08 -0400, Matt Turner wrote:
>=20
> Thanks for tracking this down.
>=20
> I don't think the second Fixes tag is right. The stale chain comes
> from ebf7a5d294 alone: any last_tb that exited through an unpatched
> goto_tb slot gets chained after the flush, same page or not. Your
> x86_64 observation fits that. 25e5c6a320 makes it much easier to
> hit, which is worth saying in the commit message, but it didn't
> introduce the bug. I'd drop that tag.
>=20
> ebf7a5d294 has been in since v10.2.0, so this should go to stable:

Agreed, thanks. v2 drops the tag, names 25e5c6a320 in the message
instead and adds Cc: qemu-stable:
https://lore.kernel.org/qemu-devel/20261024070347.1202239-1-stian@itx.no/

/Stian



--=-XeB5OTvqbUn5gqYQ9MbQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTK1ph9OaYoND1R57zoeAEuJe36VgUCatxZNwAKCRDoeAEuJe36
VkmDAQDUX1/VTSoWVeVZ0N1H6sMZ72VmTJ2ebb//LIAhphHYAgEAsoSGr0A5fuyU
v6AMJ1zO45A8N89uWAetSvAWXJ9DMwo=
=DuAK
-----END PGP SIGNATURE-----

--=-XeB5OTvqbUn5gqYQ9MbQ--

