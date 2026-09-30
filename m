Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1600DCA5FB1
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 09:30:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBqda-0001UB-KT; Wed, 30 Sep 2026 05:30:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=7264c68bd=Conor.Dooley@microchip.com>)
 id 1xBqdY-0001TJ-MT; Wed, 30 Sep 2026 05:30:04 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=7264c68bd=Conor.Dooley@microchip.com>)
 id 1xBqdW-0006rr-DD; Wed, 30 Sep 2026 05:30:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1790760602; x=1822296602;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=ONXCNXXeu3Rmufy5m1SE9oC3B+giJocSSSHSybe06eU=;
 b=ZhQIseRHSp7xY+do2bfPQnlJZ3OzfbjP2Yg1+8rgbDMfDXC764Vh8VD3
 90Ukw2GVAEnh+hUPLBYRs0AxD65/a+vtfi2lf22jt2QmgUcSm7XGMuIfR
 pgPcmXVylFjm6jiWkCPPLZ9TC8QYRuQBt/jOe3EMIzFmBVMzHdwLrYlR/
 71soraNhYw6/8XYB6PVtr0jUoi6xY0EwE8uG1YcXdRSABHuxzYye5Jo1I
 DZM9sIStjDA3FYy3VaDkYBEak1fNBCGhtcj7S+duLowiTtAyEJvlkhsxm
 xW3ea2aPnjrMLOwUjmdEYikOl3qqutso+Q0NlxHbruhmDBZQb1V6bmADs Q==;
X-CSE-ConnectionGUID: 1adufEWCTYW3T9J1aPyqMA==
X-CSE-MsgGUID: LMyAHQIHTVOKGzNjlOB1KA==
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
 d="asc'?scan'208";a="63430182"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 30 Sep 2026 02:29:59 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Wed, 30 Sep 2026 02:29:59 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex02.mchp-main.com (10.10.85.144)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.58 via Frontend
 Transport; Wed, 30 Sep 2026 02:29:57 -0700
Date: Wed, 30 Sep 2026 10:28:38 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: Bin Meng <bin.meng@processmission.com>
CC: QEMU <qemu-devel@nongnu.org>, Chao Liu <chao.liu@processmission.com>,
 Alistair Francis <alistair.francis@wdc.com>, Conor Dooley <conor@kernel.org>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, Liu Zhiwei
 <zhiwei_liu@linux.alibaba.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Sebastian Huber <sebastian.huber@embedded-brains.de>, Weiwei Li
 <liwei1518@gmail.com>, <qemu-riscv@nongnu.org>
Subject: Re: [PATCH v2 17/24] hw/riscv: pfsoc: Correct PolarFire SoC DDR
 aliases
Message-ID: <20260930-bulgur-dab-28a151f39dc3@wendy>
References: <20260904155758.3833179-1-bin.meng@processmission.com>
 <20260904155758.3833179-18-bin.meng@processmission.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="OKcC5An3cw0Za35D"
Content-Disposition: inline
In-Reply-To: <20260904155758.3833179-18-bin.meng@processmission.com>
Received-SPF: pass client-ip=68.232.154.123;
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

--OKcC5An3cw0Za35D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 04, 2026 at 11:57:36PM +0800, Bin Meng wrote:
> The 64-bit cached and non-cached windows alias the complete physical
> DDR from offset zero. Treating them as only the portion above 1 GiB

This is not strictly true, how these regions overlap depends on how the
FPGA itself is configured. In the past, the regions were set up
sequentially and someone may choose to set their device up that way if
they want to, provided they change their devicetree to match.

I think the change is worth making, but the commit doing so should cite
reality and explain that this aliasing is the case in the reference
designs provided by microchip, not present it as the whole truth.

Ditto for the comment.

> leaves valid Icicle Kit memory nodes unbacked with the board's 2 GiB.
>=20
> Map both high windows over the full machine RAM.
>=20
> Signed-off-by: Bin Meng <bin.meng@processmission.com>
> Reviewed-by: Chao Liu <chao.liu@processmission.com>
> ---
>=20
> (no changes since v1)
>=20
>  hw/riscv/microchip_pfsoc.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
> index 87c9c89cb0..83ac352c1e 100644
> --- a/hw/riscv/microchip_pfsoc.c
> +++ b/hw/riscv/microchip_pfsoc.c
> @@ -573,15 +573,27 @@ static void microchip_icicle_kit_machine_init(Machi=
neState *machine)
>                              TYPE_MICROCHIP_PFSOC);
>      qdev_realize(DEVICE(&s->soc), NULL, &error_fatal);
> =20
> -    /* Split RAM into low and high regions using aliases to machine->ram=
 */
> +    /*
> +     * The four CPU-visible windows alias the same physical DDR from off=
set
> +     * zero. For the Icicle Kit's 2 GiB of DDR, they map as follows:
> +     *
> +     * CPU address     Attribute           Visible size   DDR range
> +     * 0x0080000000    32-bit cached       1 GiB          [0, 1 GiB)
> +     * 0x00c0000000    32-bit non-cached   1 GiB          [0, 1 GiB)
> +     * 0x1000000000    64-bit cached       2 GiB          [0, 2 GiB)
> +     * 0x1400000000    64-bit non-cached   2 GiB          [0, 2 GiB)
> +     *
> +     * "Low" and "high" describe the CPU address windows, not the lower =
and
> +     * upper portions of physical DDR.
> +     */
>      mem_low_size =3D memmap[MICROCHIP_PFSOC_DRAM_LO].size;
> -    mem_high_size =3D machine->ram_size - mem_low_size;
> +    mem_high_size =3D machine->ram_size;
>      memory_region_init_alias(mem_low, NULL,
>                               "microchip.icicle.kit.ram_low", machine->ra=
m,
>                               0, mem_low_size);
>      memory_region_init_alias(mem_high, NULL,
>                               "microchip.icicle.kit.ram_high", machine->r=
am,
> -                             mem_low_size, mem_high_size);
> +                             0, mem_high_size);
> =20
>      /* Register RAM */
>      memory_region_add_subregion(system_memory,
> --=20
> 2.53.0
>=20
>=20

--OKcC5An3cw0Za35D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCarzWRgAKCRB4tDGHoIJi
0i9zAQDCkJVgGBfH9ill626mYnq2F0I5l45WAkJmE8hTZCyQygEAz8ZSU01BbU5U
i7esjDm2olMLQK6HJI3OhqwS8fRNfgY=
=mIs5
-----END PGP SIGNATURE-----

--OKcC5An3cw0Za35D--

