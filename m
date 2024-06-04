Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D259CC25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 11:30:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sESLh-0005Eq-PW; Tue, 04 Jun 2024 07:29:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <conor@kernel.org>)
 id 1sESLg-0005E3-7V; Tue, 04 Jun 2024 07:29:04 -0400
Received: from sin.source.kernel.org ([145.40.73.55])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <conor@kernel.org>)
 id 1sESLd-0005Hl-Tv; Tue, 04 Jun 2024 07:29:03 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 5F121CE1102;
 Tue,  4 Jun 2024 11:28:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B2F5C2BBFC;
 Tue,  4 Jun 2024 11:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1717500533;
 bh=1Du/fuuG1zc+ngZtekcNlx2gyx8wH5pn/Kib2fvuTJg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=vLSnAZwXqc/lTHcdM+DA7vCO2k38FORQscAdqjsF+6cWkmgvXQwrIZzOSgVWPbmyQ
 X7M0D3qPpWI7L5AqrxXeQDRf1o6JoCZkOYWp2CVQ7sJawnk49f0RFIBcbKG/AJYhzl
 ecN4mQ2KF80UlxJCqMYy55qj0pAZAYy1MJJsX1wZH4gHioKMn8GVJxgnQQypp2fzSY
 vnkdFQn57MaWeYWyO0SW8SeHjpU31NlN+xBU9xuSG+3TYTZSCCE1zVsFUAxo/urG78
 ZATCLOH5az8ybzbUa3FJN06SmvCg2lVWQCi0gGz1Z1i49OuiCk3FiHV3tDir9R7vvy
 /aCD5bPgn8rXw==
Date: Tue, 4 Jun 2024 12:28:49 +0100
From: Conor Dooley <conor@kernel.org>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 bmeng@tinylab.org, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 apatel@ventanamicro.com, ajones@ventanamicro.com
Subject: Re: [PATCH v2 0/8] hw/riscv/virt.c: aplic/imsic DT fixes
Message-ID: <20240604-stricken-gloomily-4ec1b0eb72d5@spud>
References: <20240531202759.911601-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="IcKORaFfU1KHVbXe"
Content-Disposition: inline
In-Reply-To: <20240531202759.911601-1-dbarboza@ventanamicro.com>
Received-SPF: pass client-ip=145.40.73.55; envelope-from=conor@kernel.org;
 helo=sin.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


--IcKORaFfU1KHVbXe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2024 at 05:27:51PM -0300, Daniel Henrique Barboza wrote:
> Hi,
>=20
> This is a series that is being spun from the reviews given on patch 1
> [1]. We'll fix some DT validation issues we have in the 'virt' machine
> [2] that aren't related to missing extensions in the DT spec.
>=20
> I'll leave to maintainers to squash the patches as they see fit. I
> split it this way to make it easier to bissect possible bugs that these
> individual changes can cause.
>=20
> These are the types of DT warnings solved by this series:
>=20
> /home/danielhb/work/qemu/riscv64_virt.dtb: aplic@d000000: $nodename:0: 'a=
plic@d000000' does not match '^interrupt-controller(@[0-9a-f,]+)*$'
> 	from schema $id: http://devicetree.org/schemas/interrupt-controller/risc=
v,aplic.yaml#
> /home/danielhb/work/qemu/riscv64_virt.dtb: aplic@d000000: compatible:0: '=
riscv,aplic' is not one of ['qemu,aplic']
> 	from schema $id: http://devicetree.org/schemas/interrupt-controller/risc=
v,aplic.yaml#
> /home/danielhb/work/qemu/riscv64_virt.dtb: aplic@d000000: compatible: ['r=
iscv,aplic'] is too short
> 	from schema $id: http://devicetree.org/schemas/interrupt-controller/risc=
v,aplic.yaml#
> /home/danielhb/work/qemu/riscv64_virt.dtb: aplic@d000000: Unevaluated pro=
perties are not allowed ('compatible' was unexpected)
> 	from schema $id: http://devicetree.org/schemas/interrupt-controller/risc=
v,aplic.yaml#
> (...)
> /home/danielhb/work/qemu/riscv64_virt.dtb: imsics@28000000: $nodename:0: =
'imsics@28000000' does not match '^interrupt-controller(@[0-9a-f,]+)*$'
> 	from schema $id: http://devicetree.org/schemas/interrupt-controller/risc=
v,imsics.yaml#
> /home/danielhb/work/qemu/riscv64_virt.dtb: imsics@28000000: compatible:0:=
 'riscv,imsics' is not one of ['qemu,imsics']
> 	from schema $id: http://devicetree.org/schemas/interrupt-controller/risc=
v,imsics.yaml#
> /home/danielhb/work/qemu/riscv64_virt.dtb: imsics@28000000: compatible: [=
'riscv,imsics'] is too short
> 	from schema $id: http://devicetree.org/schemas/interrupt-controller/risc=
v,imsics.yaml#
> /home/danielhb/work/qemu/riscv64_virt.dtb: imsics@28000000: '#msi-cells' =
is a required property
> 	from schema $id: http://devicetree.org/schemas/interrupt-controller/risc=
v,imsics.yaml#
> /home/danielhb/work/qemu/riscv64_virt.dtb: imsics@28000000: Unevaluated p=
roperties are not allowed ('compatible' was unexpected)
> 	from schema $id: http://devicetree.org/schemas/interrupt-controller/risc=
v,imsics.yaml#

I'm not sure that a "Tested-by: Conor Dooley <conor.dooley@microchip.com>"
here is really the right thing, given I only checked against the
bindings and didn't run a guest or anything of that sort, but all of the
validation issues relating to interrupt controllers are now gone.

Thanks for the fixes :)

Conor.

--IcKORaFfU1KHVbXe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZl76cQAKCRB4tDGHoIJi
0u//AP4zFA1m79HqosXVdTs63TNyqy52gUhjUWFHJfus8Yf1CQEAvYXsW1Cmcjqd
Y48rp0PZSFEZUWTjNCkpb9p6m4qeIwM=
=SyBe
-----END PGP SIGNATURE-----

--IcKORaFfU1KHVbXe--

