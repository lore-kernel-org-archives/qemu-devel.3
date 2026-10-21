Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47FF606A319
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 07:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=itx.no header.i=@itx.no header.a=rsa-sha256 header.s=mx.itx.no header.b=ixkuX/hE
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJQzD-0002yN-Dj; Wed, 21 Oct 2026 03:43:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stian@itx.no>) id 1xJQzB-0002yB-ES
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 03:43:45 -0400
Received: from itx-kvm-14.itxnorge.no ([91.189.121.228] helo=mx.itxnorge.no)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stian@itx.no>) id 1xJQz8-00033Y-84
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 03:43:45 -0400
Message-ID: <0da65c5ba0e9b84d17c88cfca01af4c788f00766.camel@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
 t=1792568619;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AqmgqfHH4AQim8A/LM85o2U4Ma4hDKDyGZXuSJ58dgQ=;
 b=ixkuX/hEGOutayhV3/ZzSLisFdttsf/EczV2YhOH57UFKNoGdnES68Iu8Nci+c196RVCCJ
 4LjUkDKGl50mT1FJymN1QjgqnpQBUZLTpd4Er5oeWboLwoDbRbDUnkgCSvE+suAeqAu9iv
 efmjQVBgzZT7irJ9r57RjDhmhXnx+gY=
Subject: Re: [PATCH v2 7/7] linux-user/sparc: Report HWCAP_SPARC_CRYPTO for
 crypto CPU feature
From: Stian Halseth <stian@itx.no>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko
 <atar4qemu@gmail.com>, Richard Henderson <richard.henderson@linaro.org>, 
 Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, Pierrick
 Bouvier <pierrick.bouvier@oss.qualcomm.com>, Eric Biggers
 <ebiggers@kernel.org>
Date: Wed, 21 Oct 2026 09:43:38 +0200
In-Reply-To: <20261021064640.3591682-8-stian@itx.no>
References: <20261021064640.3591682-1-stian@itx.no>
 <20261021064640.3591682-8-stian@itx.no>
Content-Type: multipart/signed; micalg="pgp-sha512";
 protocol="application/pgp-signature"; boundary="=-lqc/ZBikupAk1wbXMZhN"
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--=-lqc/ZBikupAk1wbXMZhN
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

Found a problem that comes with patch 7 and glibc multiarch builds.

As soon as HWCAP_SPARC_CRYPTO is visible, glibc chooses the niagara4
routines (SPARC T4 and later), and on the sun4u model with +crypto they
die with SIGILL.

glibc's niagara4 memcpy/memset use block-init stores (ASI 0xe2,
ASI_BLK_INIT_QUAD_LDD_P).=A0gen_st_asi() only accepts that store on CPUs
with CPU_FEATURE_HYPV.

Note that this does not reproduce with Debian's sparc64 glibc, without
multiarch. I reproduced with Gentoo stage3, built with -mcpu=3Dultrasparc
and multiarch glibc 2.44.

A small change to translate.c, function gen_st_asi(), fixes the
problem.

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 921ffd2d1b..931fc006ce 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -1863,8 +1863,12 @@ static void gen_st_asi(DisasContext *dc,
DisasASI *da, TCGv src, TCGv addr)
         if (TARGET_LONG_BITS =3D=3D 32) {
             gen_exception(dc, TT_ILL_INSN);
             break;
-        } else if (!(dc->def->features & CPU_FEATURE_HYPV)) {
-            /* Pre OpenSPARC CPUs don't have these */
+        } else if (!(dc->def->features &
+                    (CPU_FEATURE_HYPV | CPU_FEATURE_CRYPTO))) {
+            /*
+             * Pre-OpenSPARC CPUs lack block-init stores. Crypto
instructions
+             * imply T4 or later, which supports them.
+             */
             gen_exception(dc, TT_ILL_INSN);
             break;
         }

My kernel tests missed this, so will improve my testing routines going
forward. Sorry about this extra noise.

The fix is queued for v3.

/Stian

On Wed, 2026-10-21 at 08:46 +0200, Stian Halseth wrote:
> Set HWCAP_SPARC_CRYPTO in AT_HWCAP like Linux does on real hardware
> that supports it. qemu-sparc64 defaults to "TI UltraSparc II",
> which has no crypto feature, so it must be enabled explicitly,
> e.g. -cpu TI-UltraSparc-II,+crypto
>=20
> Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@oss.qualcomm.com>
> Signed-off-by: Stian Halseth <stian@itx.no>
> ---
> =A0linux-user/sparc/elfload.c | 1 +
> =A01 file changed, 1 insertion(+)
>=20
> diff --git a/linux-user/sparc/elfload.c b/linux-user/sparc/elfload.c
> index 181f1e00b5..0412741285 100644
> --- a/linux-user/sparc/elfload.c
> +++ b/linux-user/sparc/elfload.c
> @@ -90,6 +90,7 @@ abi_ulong get_elf_hwcap(CPUState *cs)
> =A0=A0=A0=A0 r |=3D features & CPU_FEATURE_FMAF ? HWCAP_SPARC_FMAF : 0;
> =A0=A0=A0=A0 r |=3D features & CPU_FEATURE_VIS3 ? HWCAP_SPARC_VIS3 : 0;
> =A0=A0=A0=A0 r |=3D features & CPU_FEATURE_IMA ? HWCAP_SPARC_IMA : 0;
> +=A0=A0=A0 r |=3D features & CPU_FEATURE_CRYPTO ? HWCAP_SPARC_CRYPTO : 0;
> =A0#endif
> =A0
> =A0=A0=A0=A0 return r;

--=-lqc/ZBikupAk1wbXMZhN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTK1ph9OaYoND1R57zoeAEuJe36VgUCathtKgAKCRDoeAEuJe36
VvYKAP9nVg6tw9phTjdqdBnoCkIGiJ5QktXXo0bnhMOzkGdihwD/Ue+0hK6PF3/l
yF6b69o3ZG1MWHAidI9VHCPTQslJfwg=
=dJmv
-----END PGP SIGNATURE-----

--=-lqc/ZBikupAk1wbXMZhN--

