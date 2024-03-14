Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21428C54E58
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Mar 2024 02:44:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkb41-0004BZ-Nt; Wed, 13 Mar 2024 22:43:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@gandalf.ozlabs.org>)
 id 1rkb3x-000468-Q2; Wed, 13 Mar 2024 22:43:21 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@gandalf.ozlabs.org>)
 id 1rkb3m-0007Oa-F6; Wed, 13 Mar 2024 22:43:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gibson.dropbear.id.au; s=202312; t=1710384178;
 bh=03iqoUpzm8H4OTZ/G4RII5H020u487IQc1QO+eAex+w=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=i0zn7Bba5LXOeLO/8kJA8IBflAakhMYM7+RvK+P9ZySbtsdKY/B5lq7C7iLTXkxa2
 rbPlaH+ja0U4fCwqRZ3ry2rjvC8qkXNC0bSO7fSb4yapCwRUCocxI4q2CbrRCKcLYl
 0cqvv+NaZh/8qcweST5GWWczzU4Zybsf6HYNwwte7q8bTst48sn/g47o/kgLp91GYg
 cv+Pp7dldW+rQVuXLukLpzyBGCEmttNOHFbrB+sRWXoFprioJbOLj7PQoSAVwBizNH
 Sg7XBfTwf1nB8dvOo+eMABU6MEFk/uu2z87F4L7SKUJg01qICWqqXkoXErhuVslJ+U
 TFPeMvlrbE6MQ==
Received: by gandalf.ozlabs.org (Postfix, from userid 1007)
 id 4TwBWQ3yRLz4wnr; Thu, 14 Mar 2024 13:42:58 +1100 (AEDT)
Date: Thu, 14 Mar 2024 13:34:38 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: Re: [PATCH v2 03/10] ppc/spapr|pnv: Remove SAO from pa-features
Message-ID: <ZfJiPpUcNt9B0i9l@zatzit>
References: <20240312131419.2196845-1-npiggin@gmail.com>
 <20240312131419.2196845-4-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="D8SlqsQjoTB4xEiS"
Content-Disposition: inline
In-Reply-To: <20240312131419.2196845-4-npiggin@gmail.com>
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=dgibson@gandalf.ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_MED=-2.3, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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


--D8SlqsQjoTB4xEiS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2024 at 11:14:12PM +1000, Nicholas Piggin wrote:
> SAO is a page table attribute that strengthens the memory ordering of
> accesses. QEMU with MTTCG does not implement this, so clear it in
> ibm,pa-features. This is an obscure feature that has been removed from
> POWER10 ISA v3.1, there isn't much concern with removing it.
>=20
> Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Usually altering a user visible feature like this without versioning
would be a no-no.  However, I think it's probably ok here: AFAICT the
feature was basically never used, it didn't work in some cases anyway,
and it's now gone away.

> ---
>  hw/ppc/pnv.c   |  2 +-
>  hw/ppc/spapr.c | 14 ++++++++++----
>  2 files changed, 11 insertions(+), 5 deletions(-)
>=20
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 0b47b92baa..aa9786e970 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -150,7 +150,7 @@ static void pnv_dt_core(PnvChip *chip, PnvCore *pc, v=
oid *fdt)
>      uint32_t page_sizes_prop[64];
>      size_t page_sizes_prop_size;
>      const uint8_t pa_features[] =3D { 24, 0,
> -                                    0xf6, 0x3f, 0xc7, 0xc0, 0x80, 0xf0,
> +                                    0xf6, 0x3f, 0xc7, 0xc0, 0x00, 0xf0,
>                                      0x80, 0x00, 0x00, 0x00, 0x00, 0x00,
>                                      0x00, 0x00, 0x00, 0x00, 0x80, 0x00,
>                                      0x80, 0x00, 0x80, 0x00, 0x80, 0x00 };
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 55263f0815..3108d7c532 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -233,17 +233,23 @@ static void spapr_dt_pa_features(SpaprMachineState =
*spapr,
>                                   PowerPCCPU *cpu,
>                                   void *fdt, int offset)
>  {
> +    /*
> +     * SSO (SAO) ordering is supported on KVM and thread=3Dsingle hosts,
> +     * but not MTTCG, so disable it. To advertise it, a cap would have
> +     * to be added, or support implemented for MTTCG.
> +     */
> +
>      uint8_t pa_features_206[] =3D { 6, 0,
> -        0xf6, 0x1f, 0xc7, 0x00, 0x80, 0xc0 };
> +        0xf6, 0x1f, 0xc7, 0x00, 0x00, 0xc0 };
>      uint8_t pa_features_207[] =3D { 24, 0,
> -        0xf6, 0x1f, 0xc7, 0xc0, 0x80, 0xf0,
> +        0xf6, 0x1f, 0xc7, 0xc0, 0x00, 0xf0,
>          0x80, 0x00, 0x00, 0x00, 0x00, 0x00,
>          0x00, 0x00, 0x00, 0x00, 0x80, 0x00,
>          0x80, 0x00, 0x80, 0x00, 0x00, 0x00 };
>      uint8_t pa_features_300[] =3D { 66, 0,
>          /* 0: MMU|FPU|SLB|RUN|DABR|NX, 1: fri[nzpm]|DABRX|SPRG3|SLB0|PP1=
10 */
> -        /* 2: VPM|DS205|PPR|DS202|DS206, 3: LSD|URG, SSO, 5: LE|CFAR|EB|=
LSQ */
> -        0xf6, 0x1f, 0xc7, 0xc0, 0x80, 0xf0, /* 0 - 5 */
> +        /* 2: VPM|DS205|PPR|DS202|DS206, 3: LSD|URG, 5: LE|CFAR|EB|LSQ */
> +        0xf6, 0x1f, 0xc7, 0xc0, 0x00, 0xf0, /* 0 - 5 */
>          /* 6: DS207 */
>          0x80, 0x00, 0x00, 0x00, 0x00, 0x00, /* 6 - 11 */
>          /* 16: Vector */

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--D8SlqsQjoTB4xEiS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEO+dNsU4E3yXUXRK2zQJF27ox2GcFAmXyYiIACgkQzQJF27ox
2Gf9Dw//QDMI4TvatHkLLng8Et2Lawb3IUB/xhbDzD9QSw6jHm2nFnBdPmnLOote
Ge/xv1j2dZoIB/hTbJ3de5HhnyQ8SHo7DHJPGp5fR7lw9HlEVhfGcKCopxnosfkq
vx2lgvbWZIaAGym8QA3PZx1vdCLu5Mf3SD/f2ZXMvREyWPpySCBkLgThDSbzlRIS
XlgExV5L+OJHXAfLPzoCgOy6nUqgTnWFNEj9cWKUNYp1ntocF79bXcXYRpvVYyDl
WXubNapkE1K97uzmm2W5ZxITQtcxQ02oCkQQKzshdCn5hSd5eOrhGPoJ5/w8u88i
dG4tIBQWOrUUUK+pClGti1EnfqWLn521AsTmxzyvu4vS6JNoYnsEaNLHV5C7tLFB
NI4DE9OPv+O4+eK7K+1C6Nw/StsTibCspoLi44Wp8QGNf2t6Bj4UmisrbhizedFy
0d/yO1rGN6ZbtaSP0dRx1R00oDL5YLwa3fG8aa4egIu6l6+KSnEYGO+akZAs8tHz
cyV1efMf2Ud0QXIsH0x3l66g7ghfgVMhJvDiEXW9+qSINzzLdh52x+4qUdHfdTSH
KeP/vfxwRIDXUflQamF+dN2hl0aTTXRdpEHI+zQfSZoCLffzd7lOmITxLBxIDbrG
1ttht55ktE+gim7MkOZ9LN46TfdEbu887KY+N8T4H15rVOen4+g=
=aSTI
-----END PGP SIGNATURE-----

--D8SlqsQjoTB4xEiS--

