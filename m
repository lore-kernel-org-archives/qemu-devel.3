Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA85CC04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 10:18:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4eMw-0007Cu-Bp; Wed, 08 May 2024 06:17:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1s4eMX-00072a-3O; Wed, 08 May 2024 06:17:29 -0400
Received: from fout7-smtp.messagingengine.com ([103.168.172.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1s4eMU-0006bg-7v; Wed, 08 May 2024 06:17:24 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailfout.nyi.internal (Postfix) with ESMTP id 564C9138010B;
 Wed,  8 May 2024 06:17:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute1.internal (MEProxy); Wed, 08 May 2024 06:17:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1715163435; x=
 1715249835; bh=3tjTLrAfCX8oS1ucguMM5NZPd8Tz7zn2OYqU5z5dNqg=; b=G
 /4U2Ewo5XQiL6+h5UkAUQyg6YkBZ6asSn5NOfdQay/oHPZ8DXExANoud4iUlNZ9u
 qKQn1w0+YCzBQ/NQ0d/FhJ1GhCPG/fgBptA5GzDyF9SKMiJKwt5RyPlyUG7EwTDb
 es+qtXhkqWs2F/h/ecj1tgYDYgYZLnbIPXunOYN3LW0HHBhtLgsPkgv4bw/kxbx7
 7YPoYgzk5Up23GNCIgyTLvZtXPyVmfR0ukf8B3ji5Dw3sbiJKBPg/0EPgUZLkxWx
 r1ckJI6Onqzzap/QKNX5m2jgV+to9UMUQRkbQsvI9RY1jLyrpP6wHgWvac3wzHxr
 Ryl6aMZG/4O4ZwhX/e1UQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; t=1715163435; x=1715249835; bh=3tjTLrAfCX8oS1ucguMM5NZPd8Tz
 7zn2OYqU5z5dNqg=; b=LznbA9dD8TARdEbZkAJF3hIZBCcnuDNwrDYucgPvVjkN
 Qhqqm+xtvbTA85FJgR6BH8oI/QQh4nSrRITIGqDtoTynsMu60bxZXRW1R2GxI56I
 kDQxG145CV+YIwvoAIFL8k3IZsLu56zfWnXFNfTMvDyx/n8YZ2A41pieVMu4i3Wp
 llNI1RlSSRZ/Fm82OugtResUnLlQ62YSWRQ8B9mR0OZgaP3523nMzRfnB9ovxQ1+
 Z2rnSX7jyB1ijwT6M1mXuwWabFDFAKbvuwDZJinY6TlkkXQK8w3YnH2sdxrDQ8G0
 vM/PMcM0B4GHxMNOoT4rJxips8viikn9CbnPhuTwtQ==
X-ME-Sender: <xms:KlE7Zrg6ExUv8qIx0MCqd6iKHr2RV1LuGKq-anWLNveJpx5F-Sgofg>
 <xme:KlE7ZoBshznC4ewNMawMk7j085p0njnTcIvUffhYpkkf0nImhBJPgE2LuIRlx5TLb
 WDq7wl3aZfAfEbSNHA>
X-ME-Received: <xmr:KlE7ZrGKhCdKwVNdknnGvqiOrQCAmYcAtQV2NVdj5c3jxU08tvD1nwX7WXAi>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeftddgvdehucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepmfhlrghu
 shculfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrth
 htvghrnhepjefgjeefffdvuefhieefhffggfeuleehudekveejvedtuddugeeigeetffff
 jeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepih
 htshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:KlE7ZoR_GYaoj0gs66BDZ-50zBK7L-AI1XZ7qD4iPs4kDtVg9CddNg>
 <xmx:KlE7ZoynX0PlrS8GvaJ7vnHQIdxeglNeLqrLoCjxQHC-YwQRg-QUEg>
 <xmx:KlE7Zu66OP6JUN1ZxlqiA3C-RJ5_t4Kw5N790fBqpEPHUYJtcGlF3A>
 <xmx:KlE7Ztz8HmBjG2eFlMcp2qkg0oWbJ7mL7A7w_YBMYg6RVHrbizE71A>
 <xmx:K1E7ZnoZ9CB7zrdThyK4ZxpZFD8xIMmm3e1II2vu4--RpQp6lBsZwQru>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 May 2024 06:17:14 -0400 (EDT)
Date: Wed, 8 May 2024 12:17:08 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Alan Adamson <alan.adamson@oracle.com>
Cc: qemu-devel@nongnu.org, kbusch@kernel.org, qemu-block@nongnu.org
Subject: Re: [RFC 0/1] hw/nvme: add atomic write support
Message-ID: <ZjtRJP7roXOdR236@cormorant.local>
References: <20240415234639.3021291-1-alan.adamson@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="iN7F0X1OXWn2po/x"
Content-Disposition: inline
In-Reply-To: <20240415234639.3021291-1-alan.adamson@oracle.com>
Received-SPF: pass client-ip=103.168.172.150; envelope-from=its@irrelevant.dk;
 helo=fout7-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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


--iN7F0X1OXWn2po/x
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Apr 15 16:46, Alan Adamson wrote:
> Since there is discussion in the Linux NVMe Driver community to add NVMe =
Atomic Write
> support, it would be desirable to test it with qemu nvme emulation.
> =20
> Initially, this RFC will focus on supporting NVMe controller atomic write=
 parameters(AWUN,
> AWUPF, and ACWU) but will be extended to support Namespace parameters (NA=
WUN, NAWUPF
> and NACWU).
> =20
> Atomic Write Parameters for NVMe QEMU
> -------------------------------------
> New NVMe QEMU Parameters (See NVMe Specification for details):
>         atomic.dn (default off) - Set the value of Disable Normal.
>         atomic.awun=3DUINT16 (default: 0)
>         atomic.awupf=3DUINT16 (default: 0)
>         atomic.acwu=3DUINT16 (default: 0)
> =20
> qemu command line example:
>         qemu-system-x86_64 -cpu host --enable-kvm -smp cpus=3D4 -no-reboo=
t -m 8192M -drive file=3D./disk.img,if=3Dide \
>         -boot c -device e1000,netdev=3Dnet0,mac=3DDE:CC:CC:EF:99:88 -netd=
ev tap,id=3Dnet0 \
>         -device nvme,id=3Dnvme-ctrl-0,serial=3Dnvme-1,atomic.dn=3Doff,ato=
mic.awun=3D63,atomic.awupf=3D63,atomic.acwu=3D0 \
>         -drive file=3D./nvme.img,if=3Dnone,id=3Dnvm-1 -device nvme-ns,dri=
ve=3Dnvm-1,bus=3Dnvme-ctrl-0 nvme-ns,drive=3Dnvm-1,bus=3Dnvme-ctrl-0
> =20
> Making Writes Atomic:
> ---------------------
> - Prior to a command being pulled off the SQ and executed, a check is mad=
e to see if it
>   conflicts "atomically" with a currently executing command.
> - All currently executing commands on the same namespace, across all SQs =
need to be checked.
> - If an atomic conflict is detected, the command is not started and remai=
ns on the queue.
> =20
> Testing
> -------
> NVMe QEMU Parameters used: atomic.dn=3Doff,atomic.awun=3D63,atomic.awupf=
=3D63,atomic.acwu=3D0
> =20
> # nvme id-ctrl /dev/nvme0 | grep awun
> awun      : 63
> # nvme id-ctrl /dev/nvme0 | grep awupf
> awupf     : 63
> # nvme id-ctrl /dev/nvme0 | grep acwu
> acwu      : 0    < Since qemu-nvme doesn't support Compare and Write, thi=
s is always zero
> # nvme get-feature /dev/nvme0  -f 0xa
> get-feature:0x0a (Write Atomicity Normal), Current value:00000000
> #
> =20
> # fio --filename=3D/dev/nvme0n1 --direct=3D1 --rw=3Drandwrite --bs=3D32k =
--iodepth=3D256 --name=3Diops --numjobs=3D50 --verify=3Dcrc64 --verify_fata=
l=3D1 --ioengine=3Dlibaio
> =20
> When executed without atomic write support, eventually the following erro=
r will be
> observed:
> =20
>         crc64: verify failed at file /dev/nvme0n1 offset 857669632, lengt=
h 32768
> (requested block: offset=3D857669632, length=3D32768, flags=3D88)
>             Expected CRC: 9c87d3539dafdca0
>             Received CRC: d521f7ea3b69d2ee
> =20
> When executed with atomic write support, this error no longer happens.
> =20
> Questions
> ---------
> AWUN vs AWUPF - Does the nvme emulation need to do treat these differentl=
y? Currently the
> larger of the two will be used as the max atomic write size.
> =20
> Future Work
> -----------
> - Namespace support (NAWUN, NAWUPF and NACWU)
> - Namespace Boundary support (NABSN, NABO, and NABSPF)
> - Atomic Compare and Write Unit (ACWU)
>=20
> Alan Adamson (1):
>   nvme: add atomic write support
>=20
>  hw/nvme/ctrl.c | 147 ++++++++++++++++++++++++++++++++++++++++++++++++-
>  hw/nvme/nvme.h |  17 ++++++
>  2 files changed, 163 insertions(+), 1 deletion(-)
>=20
> --=20
> 2.39.3
>=20

Hi Alan,

I have no obvious qualms about this. It is clearly useful for driver
testing and verification and does not negatively impact the performance
when this "faked" feature is not enabled.

Acked-by: Klaus Jensen <k.jensen@samsung.com>

--iN7F0X1OXWn2po/x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmY7USMACgkQTeGvMW1P
Den/qQgAk2p5gEQ+TZPcGiblGO1bF3l0ACdtqKBBXJv6sh/MJYeCWL9xzLXKBlS0
vktpCJWxNxpO1OxfrhlRwsNVAq0PKbWvV6w/V+26UlgRwE0M5eyms+qn9eBfNnpU
McVGG97ysmZAcsCDVDFyBL4PxfWHCVni8P2NA6rNlc1x9jjKo4fdWMZfmsu+wjzC
qRYOIJRJ+HXVNQ4T4VpHQxNJ0KwBvaOs5QDFbvR36RzKBzL9Zj3bMtRgxAsf7BrL
Z/Q70035mlk7/dPXNr85CBeUrGS1uD6jId/lHd/GzDNYDubfecNNYPc5S97BffPi
vGGT5bDQdKSEEExCFF4JJT/n2IIz8Q==
=dQ0G
-----END PGP SIGNATURE-----

--iN7F0X1OXWn2po/x--

