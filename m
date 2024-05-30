Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17C7EC25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 15:36:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sChoW-0006zM-HR; Thu, 30 May 2024 11:35:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <conor@kernel.org>)
 id 1sChoU-0006yu-QM; Thu, 30 May 2024 11:35:34 -0400
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <conor@kernel.org>)
 id 1sChoQ-00020n-EB; Thu, 30 May 2024 11:35:34 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 17EF56133F;
 Thu, 30 May 2024 15:35:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA73EC2BBFC;
 Thu, 30 May 2024 15:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1717083321;
 bh=MM1NTsGxrx4OmYSbT7oQtRoXJfqrtxhvPbilTVEFym8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=jqu5GmACavaywRNUXWijZBw4pW2tAuE6yRhaaIxbw0McXOG9dNd0HrseNk7v7d8fw
 5eSfX+RkR55iSeExcYEYhZwE9Wl93i3cL23jpXLDBAYMDO52zRG5eVX5HYx25X9Oqs
 BI68/AtSW1HwuqOtq0ZKrESEUaRl9J/BT6T6qmMzlrVt9ZH9IT9N7vAIClyDi20iul
 Ji9BkIvPoVzw8mV95SiJTpeFB4AmPdx1JMZd3KN3pMjMXCHpnGdI5u8VFXaossWn4f
 4FKqRxQMMTURmTyHzdN73LgBxPO4spYDrvMydzv9+g57MtxRZT7rO0dLANHELa6GOe
 0hxyLcAcb1xnw==
Date: Thu, 30 May 2024 16:35:17 +0100
From: Conor Dooley <conor@kernel.org>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: Andrew Jones <ajones@ventanamicro.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 palmer@rivosinc.com, Anup Patel <apatel@ventanamicro.com>
Subject: Re: [PATCH] hw/riscv/virt.c: add address-cells in
 create_fdt_one_aplic()
Message-ID: <20240530-landed-shriek-9362981afade@spud>
References: <20240530084949.761034-1-dbarboza@ventanamicro.com>
 <20240530-45111cf8b1ee719f055d234f@orel>
 <20240530-2a3bc2792856d6c4bcf18269@orel>
 <73abe573-040c-4aa3-af1c-c7755db0ba7a@ventanamicro.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="AotZi1OJ1jfUTocB"
Content-Disposition: inline
In-Reply-To: <73abe573-040c-4aa3-af1c-c7755db0ba7a@ventanamicro.com>
Received-SPF: pass client-ip=139.178.84.217; envelope-from=conor@kernel.org;
 helo=dfw.source.kernel.org
X-Spam_score_int: -71
X-Spam_score: -7.2
X-Spam_bar: -------
X-Spam_report: (-7.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.085,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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


--AotZi1OJ1jfUTocB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 30, 2024 at 09:26:58AM -0300, Daniel Henrique Barboza wrote:
>=20
>=20
> On 5/30/24 08:06, Andrew Jones wrote:
> > On Thu, May 30, 2024 at 01:05:41PM GMT, Andrew Jones wrote:
> > > On Thu, May 30, 2024 at 05:49:49AM GMT, Daniel Henrique Barboza wrote:
> > > > We need #address-cells properties in all interrupt controllers that=
 are
> > > > referred by an interrupt-map [1]. For the RISC-V machine, both PLIC=
 and
> > > > APLIC controllers must have this property.
> > > >=20
> > > > PLIC already sets it in create_fdt_socket_plic(). Set the property =
for
> > > > APLIC in create_fdt_one_aplic().
> > > >=20
> > > > [1] https://lore.kernel.org/linux-arm-kernel/CAL_JsqJE15D-xXxmELsmu=
D+JQHZzxGzdXvikChn6KFWqk6NzPw@mail.gmail.com/
> > >=20
> > > There are other issues[2] with the DT nodes that we should address at=
 the
> > > same time.
> > >=20
> > > [2] https://lore.kernel.org/all/20240529-rust-tile-a05517a6260f@spud/
> >=20
> > I meant to CC Conor. Doing that now.
>=20
> I'll take a look at these other DT nodes issues.
>=20
> Conor, mind give me pointers on how do I reproduce the validation you did
> in [2]? Using upstream 'dtc' I have stuff like:
>=20
> ../qemu/qemu_dts.dts:261.4-68: Warning (interrupts_extended_property): /s=
oc/aplic@d000000:interrupts-extended: cell 0 is not a phandle reference
>=20
> Which seems to also be an error but it's not what you reported. Are you
> using 'dt-validate' from dt-schema?

Yeah, dt-validate. There's probably some stuff that I could add to my
machine to make it more interesting, but I ran:
	$(qemu) -smp 4 -M virt,aia=3Daplic-imsic,dumpdtb=3D$(qemu_dtb) -cpu max -m=
 1G -nographic
	dt-validate --schema $(processed_schema) $(qemu_dtb) 2>&1 | tee logs/dtbdu=
mp.log

A processed schema is a pre-requisite, and I usually have one sitting
around from running dtbs_check or dt_binding_check in Linux, but I think
you can use dt-rebasing to generate one either:
https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebas=
ing.git/tree/Bindings/Makefile

You'll see a bunch of noise from undocumented isa extensions, but at the
end of the output should be the aplic complaints.

I forgot I had it disabled to test something when I did that test the
other day, there's also complaints about the imsics:
qemu.dtb: imsics@28000000: $nodename:0: 'imsics@28000000' does not match '^=
interrupt-controller(@[0-9a-f,]+)*$'
        from schema $id: http://devicetree.org/schemas/interrupt-controller=
/riscv,imsics.yaml#
qemu.dtb: imsics@28000000: compatible:0: 'riscv,imsics' is not one of ['qem=
u,imsics']
        from schema $id: http://devicetree.org/schemas/interrupt-controller=
/riscv,imsics.yaml#
qemu.dtb: imsics@28000000: compatible: ['riscv,imsics'] is too short
        from schema $id: http://devicetree.org/schemas/interrupt-controller=
/riscv,imsics.yaml#
qemu.dtb: imsics@28000000: '#msi-cells' is a required property
        from schema $id: http://devicetree.org/schemas/interrupt-controller=
/riscv,imsics.yaml#
qemu.dtb: imsics@28000000: Unevaluated properties are not allowed ('compati=
ble' was unexpected)
        from schema $id: http://devicetree.org/schemas/interrupt-controller=
/riscv,imsics.yaml#
qemu.dtb: imsics@24000000: $nodename:0: 'imsics@24000000' does not match '^=
interrupt-controller(@[0-9a-f,]+)*$'
        from schema $id: http://devicetree.org/schemas/interrupt-controller=
/riscv,imsics.yaml#
qemu.dtb: imsics@24000000: compatible:0: 'riscv,imsics' is not one of ['qem=
u,imsics']
        from schema $id: http://devicetree.org/schemas/interrupt-controller=
/riscv,imsics.yaml#
qemu.dtb: imsics@24000000: compatible: ['riscv,imsics'] is too short
        from schema $id: http://devicetree.org/schemas/interrupt-controller=
/riscv,imsics.yaml#
qemu.dtb: imsics@24000000: '#msi-cells' is a required property
        from schema $id: http://devicetree.org/schemas/interrupt-controller=
/riscv,imsics.yaml#
qemu.dtb: imsics@24000000: Unevaluated properties are not allowed ('compati=
ble' was unexpected)
        from schema $id: http://devicetree.org/schemas/interrupt-controller=
/riscv,imsics.yaml#

Cheers,
Conor.


--AotZi1OJ1jfUTocB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZlictQAKCRB4tDGHoIJi
0o9jAQC7MjVlsucBqim5OrGSkEivr0d2mav//O99U5QyeVwCDAEA30TOj4wHRx3r
g2c8OAj3pIefQGTfqvop52VPEY7oTgw=
=jVpY
-----END PGP SIGNATURE-----

--AotZi1OJ1jfUTocB--

