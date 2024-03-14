Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3595EC54E66
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Mar 2024 02:43:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkb3z-00048q-Sf; Wed, 13 Mar 2024 22:43:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@gandalf.ozlabs.org>)
 id 1rkb3x-000469-Q6; Wed, 13 Mar 2024 22:43:21 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@gandalf.ozlabs.org>)
 id 1rkb3m-0007OX-Dz; Wed, 13 Mar 2024 22:43:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gibson.dropbear.id.au; s=202312; t=1710384178;
 bh=iNE3Zs3fc6erURONGwAp+OcLysgJTyaeeic/HRLPYrE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=U89Q4V1twcwI2cpEMGj5mfWXd5PqEZUOl3GOMijuj9tGnA/h0OVZ0aXSu+Zoh0CFU
 /EDTi/BU4re9rVyaTnERxO0CeCGRdHFQZ3x4r2+jcttmaWy9jDcTY2BINQlC2B45oY
 spPCBvbOdOYG819L5Lf6ENghn/4zllCHXWCb2DoVsnIgLxYm+h5xdvMnTuleaM4k2X
 t57UupOF06w8wczGpWCMAX5+AfSydpZVYfYHU0fcTfqYjzL8w36OmhE3U2ejikRz8t
 vYLYa1D9L0c8rC+sIwS2L1OWEG8sRXVXWv7rB87jiYcWtqshQb6EqHFlzQmJ91xt8S
 4oewlg+59JJjA==
Received: by gandalf.ozlabs.org (Postfix, from userid 1007)
 id 4TwBWQ455Fz4wqM; Thu, 14 Mar 2024 13:42:58 +1100 (AEDT)
Date: Thu, 14 Mar 2024 13:35:36 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: Re: [PATCH v2 04/10] ppc/spapr: Remove copy-paste from pa-features
Message-ID: <ZfJieDXnHwqlSjzW@zatzit>
References: <20240312131419.2196845-1-npiggin@gmail.com>
 <20240312131419.2196845-5-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="NErrRBGQga85G5Sf"
Content-Disposition: inline
In-Reply-To: <20240312131419.2196845-5-npiggin@gmail.com>
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=dgibson@gandalf.ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=no autolearn_force=no
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


--NErrRBGQga85G5Sf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2024 at 11:14:13PM +1000, Nicholas Piggin wrote:
> TCG does not support copy/paste instructions. Remove it from
> ibm,pa-features. This has never been implemented under TCG or
> practically usable under KVM, so it won't be missed.

As with the previous patch, the specific circumstances here justify
breaking the general rule.

>=20
> Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  hw/ppc/spapr.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 3108d7c532..4192cd8d6c 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -237,6 +237,10 @@ static void spapr_dt_pa_features(SpaprMachineState *=
spapr,
>       * SSO (SAO) ordering is supported on KVM and thread=3Dsingle hosts,
>       * but not MTTCG, so disable it. To advertise it, a cap would have
>       * to be added, or support implemented for MTTCG.
> +     *
> +     * Copy/paste is not supported by TCG, so it is not advertised. KVM
> +     * can execute them but it has no accelerator drivers which are usab=
le,
> +     * so there isn't much need for it anyway.
>       */
> =20
>      uint8_t pa_features_206[] =3D { 6, 0,
> @@ -260,8 +264,8 @@ static void spapr_dt_pa_features(SpaprMachineState *s=
papr,
>          0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 24 - 29 */
>          /* 30: MMR, 32: LE atomic, 34: EBB + ext EBB */
>          0x80, 0x00, 0x80, 0x00, 0xC0, 0x00, /* 30 - 35 */
> -        /* 36: SPR SO, 38: Copy/Paste, 40: Radix MMU */
> -        0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 36 - 41 */
> +        /* 36: SPR SO, 40: Radix MMU */
> +        0x80, 0x00, 0x00, 0x00, 0x80, 0x00, /* 36 - 41 */
>          /* 42: PM, 44: PC RA, 46: SC vec'd */
>          0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 42 - 47 */
>          /* 48: SIMD, 50: QP BFP, 52: String */

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--NErrRBGQga85G5Sf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEO+dNsU4E3yXUXRK2zQJF27ox2GcFAmXyYm8ACgkQzQJF27ox
2GeU9RAAlW3rkKkiT3uR0gESZhscuhRuoF3ytXfm9pOLBl6lkisgU6H997WIgpB0
uFZ6FAPI963VpFQhT8WWw8TGdbKKS9w3QYmZhjTWisCwGaiKJNWnMf3oS+6xsgrD
A3OWNJXr79a9XkGcGG4lM0N4WOU9LJR8srD72Pn1TfTmMkfmwMzitwV/Fx/743Xd
8FELi1RNuzcZgKSaid7rbTD90gnvMrXnuh+MQsM6QCJ7pWjyCMZ+U9FSnQqg7PGx
OPspMRHuKOPdQ9Hbz1sSYw1mn9UFnVjh0/MIx01RsIU2UIP1fmxyIsad3UVYYFPB
Oh2c6GF3CD0Iua1kPQjKL0YyMe3MdD86vccUyE+9JBGEtqUJWQZWr91gYNS6suad
jik+yv8PpbFdhzaA4OVxA7UvxactCz2k8uiQR6y8ghtjtrbrBNAs0iphmuAk82HF
TJrJc3gEz8zd7QQx3HPd4ZTxCoO4lVc4KTecGfwgaG/i+S83q/fMGU8XsCu4MFuY
+PN43uTJBemOLlpKmJ7TWPvfKPhP7uGYewc7l5qaNOhjWjV+4ubMCxyCQmCvYkrv
W6UqCIL6e1ML0aLxcTk5XrHKiuHoStX9vMVX0JMdtTWhpe67fR/qyDvucwdB2CYz
RlfHOeJlrn8mU+1ZYkFK3h6zUAbz9vQIM8p/yCgURZqf/Qexn/o=
=tKtv
-----END PGP SIGNATURE-----

--NErrRBGQga85G5Sf--

