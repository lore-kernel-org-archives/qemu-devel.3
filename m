Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1757CCD195
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 09:05:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8xRP-0007Wp-My; Wed, 15 Oct 2025 05:05:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <conor@kernel.org>)
 id 1v8xRN-0007WF-Le; Wed, 15 Oct 2025 05:05:01 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <conor@kernel.org>)
 id 1v8xRF-0005Xy-ST; Wed, 15 Oct 2025 05:05:01 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id A9D2948DBF;
 Wed, 15 Oct 2025 09:04:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DDC4C4CEF8;
 Wed, 15 Oct 2025 09:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1760519076;
 bh=VB4Fcz2lHkrUMyoTfMgNF7qNNy6BHxWOLyZuLsG1jyg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=uq6qEb6XMWo1QnZalvPo5+eGqR5RV0x/7Cd90aaNqZTxH5ErMQi+aIDN6ZhgAOJmp
 /59VCqs46yXuBPgTqkgiAINIEOng4rnBNXzu9DCwn4br01VnrHAWM32+L7dAcoQVgy
 U9XkzHvC/8JyLJmpw0vKtqQSYxdAnwSGLrdDlORC0BVpuFkE8L2yth7zd5S/xRM54G
 wt+IGQ8sJK3ycb+m2p+M/L2v5l/8tVdHZJheabqXhsNZJuBoJYELGDfO4+FWejaxOi
 kgZyDRXSpUKX6AZn+dQMV0NFT/Uli6tQKZUPqgxyT6mSZIrFDCzzgd2QgWaMfAAeGl
 ongojqv65GW6w==
Date: Wed, 15 Oct 2025 10:04:32 +0100
From: Conor Dooley <conor@kernel.org>
To: Alistair Francis <alistair23@gmail.com>
Cc: Guenter Roeck <linux@roeck-us.net>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Subject: Re: [PATCH 0/4] Fix Ethernet interface support for
 microchip-icicle-kit
Message-ID: <20251015-chump-certainly-c220ef4541ab@spud>
References: <20251004200049.871646-1-linux@roeck-us.net>
 <CAKmqyKPQDUjQPgzfpcUBSEZ=y1Of6dcrWBj8e6cBhHUH8F9Kng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6CQf4aeaa1Viu3Cu"
Content-Disposition: inline
In-Reply-To: <CAKmqyKPQDUjQPgzfpcUBSEZ=y1Of6dcrWBj8e6cBhHUH8F9Kng@mail.gmail.com>
Received-SPF: pass client-ip=172.234.252.31; envelope-from=conor@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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


--6CQf4aeaa1Viu3Cu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 01:03:50PM +1000, Alistair Francis wrote:
> On Sun, Oct 5, 2025 at 6:02=E2=80=AFAM Guenter Roeck <linux@roeck-us.net>=
 wrote:
> >
> > The Microchip PolarFire SoC Icicle Kit supports two Ethernet interfaces.
> > The PHY on each may be connected to separate MDIO busses, or both may be
> > connected on the same MDIO bus using different PHY addresses. Add suppo=
rt
> > for it to the Cadence GEM emulation.
> >
> > The Linux kernel checks the PCS disabled bit in the R_DESCONF register
> > to determine if SGMII is supported. If the bit is set, SGMII support is
> > disabled. Since the Microchip Icicle devicetree file configures SGMII
> > interface mode, enabling the Ethernet interfaces fails when booting
> > the Linux kernel. Add support for clearing the PCS disabled bit.
> >
> > ----------------------------------------------------------------
> > Guenter Roeck (4):
> >       hw/net/cadence_gem: Support two Ethernet interfaces connected to =
single MDIO bus
> >       hw/riscv: microchip_pfsoc: Connect Ethernet PHY channels
> >       hw/net/cadence_gem: Add pcs-enabled property
> >       microchip icicle: Enable PCS on Cadence Ethernet
>=20
> Thanks!
>=20
> Applied to riscv-to-apply.next

Didn't notice these in time, thanks for fixing this Guenter.

--6CQf4aeaa1Viu3Cu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaO9joAAKCRB4tDGHoIJi
0hQkAP9Fdj/+Z2jwIImK9jyVTpkpgNfxKgIvkDS1c/rwA81KUAD9H1aSP6tW5zol
N+wi9ANWAaggx/aqCh2Nk5UuEr/2rws=
=VzkN
-----END PGP SIGNATURE-----

--6CQf4aeaa1Viu3Cu--

