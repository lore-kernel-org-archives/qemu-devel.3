Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F37E5CED606
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 06:20:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syQ3R-0007yP-8j; Wed, 09 Oct 2024 02:20:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1syQ3P-0007y5-CY
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 02:20:11 -0400
Received: from fout-b4-smtp.messagingengine.com ([202.12.124.147])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1syQ3M-00006E-V6
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 02:20:10 -0400
Received: from phl-compute-02.internal (phl-compute-02.phl.internal
 [10.202.2.42])
 by mailfout.stl.internal (Postfix) with ESMTP id 4E1DD11400A9;
 Wed,  9 Oct 2024 02:20:05 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Wed, 09 Oct 2024 02:20:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1728454805; x=
 1728541205; bh=KnXpyuN6J+/DXK2B2g/aRlC26AH/7jKL7enI/Eiwek0=; b=l
 2jojbbsNwuRhAsc0Z0Zz9s1BfQovIYD2Fvqkhbe97+UjHKIxq7etnJFyRmEq21g5
 bHg4mSar0Y0rWU1osobvqyZU44w5G/Pk1FufT6ampKoZsToLocLYbzjJxFP3QZts
 R8v5uftrcGbFKq7xj+xfJZ4fS9dlHYfkvlnL77Mb3g1mgbQV9CsbEKmch6Kk2nrK
 1U9sjCvQ2ovP7CkmUv7losJOfEP8iz1F2u0DzpmZByF5LlcrbbGt+U0kyMmM4dn7
 11ep5iNc3t01vksoJ1QRm3PyBWoySRfNf3275kclFpPfvS9L2fE/RuefXlZGKcs0
 CKOp48vKf+HtXhZX35wpg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; t=1728454805; x=1728541205; bh=KnXpyuN6J+/DXK2B2g/aRlC26AH/
 7jKL7enI/Eiwek0=; b=GwVBOp28jWkyrMWjcKX1T8+O/DgZaCWRWsgzfvR0bOSi
 RFHkGGQPnJfUbMwCSFWjNCq2mzQ0VydAmjsBN0vcPExCwUYLp/M7JOv3KMx6pI2p
 mYoN0Da4LGafQP2sdtFq8bGEbtl2oFo91nsS7cpEWGK4UA1OMd9xqveUP4uy6yGj
 yNLgamFQUNXS8ulihPlMWodHydOfQNkksKoI2BueTz0LYxA6b5CBEzLuH3u4h682
 dZkfM1c/P4WrA1uHUqpdIytZAZjkhC/r7hUdk7vLSn69FRcUXSFCDdqqfptvaaPC
 Airt8AoELB4EvcPQmR9rS2oWNeRKsOU3dXf5AOfJtQ==
X-ME-Sender: <xms:kyAGZ_3n9mBvjBhKggWEz92i-yQHUdo4MFaN3vjsIY7IAdm_7kHBiw>
 <xme:kyAGZ-EwwKjBASHu7WTgxzf1TeXEj4OXtc66tu0i52JpBTtawxZuI5p5ZvHHPAx4D
 gm5mKkTTKYp1ohs4jQ>
X-ME-Received: <xmr:kyAGZ_5Ni6oBLOJuyqelE3buiiDdeiPOiw7FaKP2pGLrjjm6F3qPxYqxcugD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefvddguddtjecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttdej
 necuhfhrohhmpefmlhgruhhsucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnth
 drughkqeenucggtffrrghtthgvrhhnpeejgfejfeffvdeuhfeifefhgffgueelhedukeev
 jeevtdduudegieegteffffejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
 epmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughkpdhnsggprhgtphht
 thhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrhihushhhrdhmheehse
 hsrghmshhunhhgrdgtohhmpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhn
 uhdrohhrghdprhgtphhtthhopehksghushgthheskhgvrhhnvghlrdhorhhgpdhrtghpth
 htohepfhhoshhsseguvghfmhgrtghrohdrihhtpdhrtghpthhtohepihhtshesihhrrhgv
 lhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:kyAGZ03VbTSHSFPjp8PnNt0L0nI6XGxhlsPWbY95DWG8ZupGNS9slg>
 <xmx:kyAGZyHEpqUz_krIE_29H6DPaTw-jpxxXynaozORmJzOD1Fz1emQeA>
 <xmx:kyAGZ1_EiUnP28ki2VsRJ6CSBAFItR3mOitajwr5qcBQ-dvBYj-lLQ>
 <xmx:kyAGZ_mHR_JkR8RALatFlmpkqUbHXsTFGR9aXTrlzVW8Fh3dzdNqWg>
 <xmx:lSAGZ_PUw8CTe68qNt0qLLJyg7NU8XKkEUdVlSabXNKnFFQA-OAdZ3bn>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Oct 2024 02:20:02 -0400 (EDT)
Date: Wed, 9 Oct 2024 08:20:01 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Ayush Mishra <ayush.m55@samsung.com>
Cc: qemu-devel@nongnu.org, kbusch@kernel.org, foss@defmacro.it
Subject: Re: [PATCH v2] hw/nvme: Adding support for NPDAL and NPDGL
Message-ID: <ZwYgkWsqhFyoMOu7@AALNPWKJENSEN.aal.scsc.local>
References: <CGME20241001065838epcas5p158f96030a744df180b1b3818287c2a84@epcas5p1.samsung.com>
 <20241001012833.3551820-1-ayush.m55@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="BKPKXS5jUeUPTgbV"
Content-Disposition: inline
In-Reply-To: <20241001012833.3551820-1-ayush.m55@samsung.com>
Received-SPF: pass client-ip=202.12.124.147; envelope-from=its@irrelevant.dk;
 helo=fout-b4-smtp.messagingengine.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--BKPKXS5jUeUPTgbV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Oct  1 06:58, Ayush Mishra wrote:
> Adding support for new 32 bit NPDGL and NPDAL fields to address the
> needs of larger granularities.
>=20
> Signed-off-by: Ayush Mishra <ayush.m55@samsung.com>
> ---
>  v1 -> v2: Added macros for NSFEAT in /include/block/nvme.h as suggested
> by Klaus.
>=20

LGTM.

I'll add a name to the enum when applying, but that's it.

Reviewed-by: Klaus Jensen <k.jensen@samsung.com>

>  hw/nvme/ns.c         |  5 ++++-
>  include/block/nvme.h | 17 ++++++++++++++++-
>  2 files changed, 20 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/nvme/ns.c b/hw/nvme/ns.c
> index ea8db175db..7f51b6eec4 100644
> --- a/hw/nvme/ns.c
> +++ b/hw/nvme/ns.c
> @@ -30,6 +30,7 @@
>  void nvme_ns_init_format(NvmeNamespace *ns)
>  {
>      NvmeIdNs *id_ns =3D &ns->id_ns;
> +    NvmeIdNsNvm *id_ns_nvm =3D &ns->id_ns_nvm;
>      BlockDriverInfo bdi;
>      int npdg, ret;
>      int64_t nlbas;
> @@ -55,6 +56,8 @@ void nvme_ns_init_format(NvmeNamespace *ns)
>      }
> =20
>      id_ns->npda =3D id_ns->npdg =3D npdg - 1;
> +    id_ns_nvm->npdal =3D npdg;
> +    id_ns_nvm->npdgl =3D npdg;
>  }
> =20
>  static int nvme_ns_init(NvmeNamespace *ns, Error **errp)
> @@ -72,7 +75,7 @@ static int nvme_ns_init(NvmeNamespace *ns, Error **errp)
>      ns->id_ns.dlfeat =3D 0x1;
> =20
>      /* support DULBE and I/O optimization fields */
> -    id_ns->nsfeat |=3D (0x4 | 0x10);
> +    id_ns->nsfeat |=3D (NVME_DEALLOCATED_ERROR | NVME_OPTIONAL_WRITE_PER=
F);
> =20
>      if (ns->params.shared) {
>          id_ns->nmic |=3D NVME_NMIC_NS_SHARED;
> diff --git a/include/block/nvme.h b/include/block/nvme.h
> index 5298bc4a28..7a84664bf2 100644
> --- a/include/block/nvme.h
> +++ b/include/block/nvme.h
> @@ -1413,7 +1413,12 @@ typedef struct QEMU_PACKED NvmeIdNsNvm {
>      uint8_t     pic;
>      uint8_t     rsvd9[3];
>      uint32_t    elbaf[NVME_MAX_NLBAF];
> -    uint8_t     rsvd268[3828];
> +    uint32_t    npdgl;
> +    uint32_t    nprg;
> +    uint32_t    npra;
> +    uint32_t    nors;
> +    uint32_t    npdal;
> +    uint8_t     rsvd288[3808];
>  } NvmeIdNsNvm;
> =20
>  typedef struct QEMU_PACKED NvmeIdNsDescr {
> @@ -1536,6 +1541,16 @@ typedef union NvmeDifTuple {
>      } g64;
>  } NvmeDifTuple;
> =20
> +enum {
> +    NVME_THIN_PROVISIONING          =3D 1 << 0,
> +    NVME_NS_SUPP_ATOMIC_BOUND_POW   =3D 1 << 1,
> +    NVME_DEALLOCATED_ERROR          =3D 1 << 2,
> +    NVME_UID_REUSE                  =3D 1 << 3,
> +    NVME_OPTIONAL_WRITE_PERF        =3D 3 << 4,
> +    NVME_MULTIPLE_ATOMICITY_MODE    =3D 1 << 6,
> +    NVME_OPTIONAL_READ_PERF         =3D 1 << 7,
> +};
> +
>  enum NvmeZoneAttr {
>      NVME_ZA_FINISHED_BY_CTLR         =3D 1 << 0,
>      NVME_ZA_FINISH_RECOMMENDED       =3D 1 << 1,
> --=20
> 2.43.0
>=20
>=20

--BKPKXS5jUeUPTgbV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmcGII4ACgkQTeGvMW1P
DemQ6wf+LFXhfOa0+MWTZIVWjghCVBYYfqEE7OWIzidN+aIUw6zuELwUWlzCF3+W
65zIMBDK1yF/Vx7rOU4m7HoFMA966rjNsTVt4PGbgmCMj/x3aQ0KxlC3MwVfnNUG
mTeojqrCJOwaH/ClCX9VKsBRn8zpLxElGYljzfhSDBYO+D6elr8DmkNS/C/WSrPb
j9kgNII/vHodfaOfzhLULTXb2srMFs0O/VF4azH7yDpbssJFDvM124Cxc1u81kgd
GdQb4sahGdr+72PnCfHZ20e1dnPiNb8we9nevpxHuJ17+h52uTzDGZa8K+SUXSiG
fneZFQ8CApThCnXITmvFraEjVmM2OQ==
=WwMp
-----END PGP SIGNATURE-----

--BKPKXS5jUeUPTgbV--

