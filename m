Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30FF0CA5FC1
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 09:35:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBqiF-00037z-BM; Wed, 30 Sep 2026 05:34:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=7264c68bd=Conor.Dooley@microchip.com>)
 id 1xBqiD-00037m-KD; Wed, 30 Sep 2026 05:34:53 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=7264c68bd=Conor.Dooley@microchip.com>)
 id 1xBqiB-0007Pr-W7; Wed, 30 Sep 2026 05:34:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1790760892; x=1822296892;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=WiqjK0H5dHNHqSdSxTTUHbb/Ia/bkCydsWY/KI1nVS0=;
 b=NfWigMDAhI7hlcHZMj+MeSHgdNXWTJV4zwEvDa4u9eutaylbga7UlGrr
 PUkUbwSN5IVWRmIVkLbA3wgErfl0ltI2mcDq9IXup23tSxl470ghJebyB
 5mZHBXvg5mfqo0v93e0CQU24W31YlpRTUEA2csKotVI+SGMczSh17Yv0c
 EhljpaTEOVVZrq4sFXqDhPB4IqkrJlDwy730HCsIFthFAXSwR8RKdmSZi
 DsnHeTnkVstZtc+HFxiqcNW4hBtCPkemNyoBSHiO79P196Wt8+8b8qjbj
 Vt+F5w2YsIS7my5Siy8ixehDniERexKYK6bgpcX4Dnr2T6HxftJg2HIYQ Q==;
X-CSE-ConnectionGUID: rJcVBsf1QVClHOwVXTvdfA==
X-CSE-MsgGUID: bTyTQUN1SUKX2o2Ugy/zVA==
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
 d="asc'?scan'208";a="295773504"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2026 02:34:49 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.49; Wed, 30 Sep 2026 02:34:48 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex02.mchp-main.com (10.10.85.144)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.58 via Frontend
 Transport; Wed, 30 Sep 2026 02:34:46 -0700
Date: Wed, 30 Sep 2026 10:33:27 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: Bin Meng <bin.meng@processmission.com>
CC: QEMU <qemu-devel@nongnu.org>, Chao Liu <chao.liu@processmission.com>,
 Alistair Francis <alistair.francis@wdc.com>, Conor Dooley <conor@kernel.org>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, Liu Zhiwei
 <zhiwei_liu@linux.alibaba.com>, Palmer Dabbelt <palmer@dabbelt.com>, Pierrick
 Bouvier <pierrick.bouvier@oss.qualcomm.com>, Sebastian Huber
 <sebastian.huber@embedded-brains.de>, Weiwei Li <liwei1518@gmail.com>,
 <qemu-riscv@nongnu.org>
Subject: Re: [PATCH v2 19/24] hw/riscv: pfsoc: Fix Icicle Kit hart count at
 five
Message-ID: <20260930-livestock-stylist-cedacf269035@wendy>
References: <20260904155758.3833179-1-bin.meng@processmission.com>
 <20260904155758.3833179-20-bin.meng@processmission.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ium6xMQA5t20lfla"
Content-Disposition: inline
In-Reply-To: <20260904155758.3833179-20-bin.meng@processmission.com>
Received-SPF: pass client-ip=68.232.153.233;
 envelope-from=prvs=7264c68bd=Conor.Dooley@microchip.com;
 helo=esa.microchip.iphmx.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--ium6xMQA5t20lfla
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 04, 2026 at 11:57:38PM +0800, Bin Meng wrote:
> The Icicle Kit always contains one E51 management hart and four U54
> application harts. The model currently accepts two to five harts and
> defaults to two, allowing configurations that cannot match the board.

Updating the default to 5 makes sense, stops accidentally trying to boot
something expecting 5 CPUs and getting only 2. But why the change to the
minimum? If someone intentionally wants to have only 1 u54, why prevent
that?

>=20
> Set the minimum and default CPU counts to the five-hart maximum.
> Update the documentation to state that other hart counts are rejected.
>=20
> Signed-off-by: Bin Meng <bin.meng@processmission.com>
> Reviewed-by: Chao Liu <chao.liu@processmission.com>
> ---
>=20
> (no changes since v1)
>=20
>  docs/system/riscv/microchip-icicle-kit.rst | 1 +
>  hw/riscv/microchip_pfsoc.c                 | 4 ++--
>  2 files changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/docs/system/riscv/microchip-icicle-kit.rst b/docs/system/ris=
cv/microchip-icicle-kit.rst
> index 3db2b3c7e3..38352cc62b 100644
> --- a/docs/system/riscv/microchip-icicle-kit.rst
> +++ b/docs/system/riscv/microchip-icicle-kit.rst
> @@ -27,6 +27,7 @@ The ``microchip-icicle-kit`` machine supports the follo=
wing devices:
>  * 1 SDHC storage controller
> =20
>  The machine has a fixed 2 GiB of RAM. Other memory sizes are rejected.
> +The machine always exposes all five harts. Other CPU counts are rejected.
> =20
>  Boot options
>  ------------
> diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
> index 11403a6087..1238811ed8 100644
> --- a/hw/riscv/microchip_pfsoc.c
> +++ b/hw/riscv/microchip_pfsoc.c
> @@ -768,8 +768,8 @@ static void microchip_icicle_kit_machine_class_init(O=
bjectClass *oc,
>      mc->init =3D microchip_icicle_kit_machine_init;
>      mc->max_cpus =3D MICROCHIP_PFSOC_MANAGEMENT_CPU_COUNT +
>                     MICROCHIP_PFSOC_COMPUTE_CPU_COUNT;
> -    mc->min_cpus =3D MICROCHIP_PFSOC_MANAGEMENT_CPU_COUNT + 1;
> -    mc->default_cpus =3D mc->min_cpus;
> +    mc->min_cpus =3D mc->max_cpus;
> +    mc->default_cpus =3D mc->max_cpus;
>      mc->default_ram_id =3D "microchip.icicle.kit.ram";
>      mc->auto_create_sdcard =3D true;
> =20
> --=20
> 2.53.0
>=20
>=20

--ium6xMQA5t20lfla
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCarzXZwAKCRB4tDGHoIJi
0n1CAP0Q1EUeIsfMF95ZdWnruLYjFPMUzCbDjEsURPL1R4WAzAD/esCCQaSeUtjP
TPgXgi9I1SfzFL++WMPpAqO2K5HCTwo=
=Hxpp
-----END PGP SIGNATURE-----

--ium6xMQA5t20lfla--

