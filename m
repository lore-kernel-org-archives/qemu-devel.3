Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE5BBC43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 11:47:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wghmu-00065n-D5; Mon, 06 Jul 2026 07:47:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@gandalf.ozlabs.org>)
 id 1wghmi-00063V-RV
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 07:46:51 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@gandalf.ozlabs.org>)
 id 1wghme-0003kR-AR
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 07:46:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gibson.dropbear.id.au; s=202606; t=1783338385;
 bh=0pso4x8EQK6VOqPdj4WxEMjQRHmB2RgOpXm9uZiWMow=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=BVt0SaX2T0+4ptTr3/AksorYlvVCQbVcghm8fxNyzT+aIs36LV64Wej5DqRvVee4z
 aFfCqT/wDfEblVpk9OtH2Sx2orlrSnsxhmpqVoWRFkDgcg2mMoRLceGLEnw9D3PFi7
 /SC+ypQLurA4p++b7mQw4lG973KHbzZw06G2NithHwN6i4Nj+mLNhrRQFOzYsekJ/z
 o24w2HPwKyM1OJynwLMnEswTc2GrcbTR2RYvcR0fy9eN3nEj9q1ipSOw0sN3uHZrLB
 F7B5ltPNhBPZ5rWqnwtYFZlViKW6si3nTL/tY0w3RTuC23nQxRdTLBdw3wYdiJJ+kt
 8cFTDvnnG/+mw==
Received: by gandalf.ozlabs.org (Postfix, from userid 1007)
 id 4gv2cx6JcFz4wJs; Mon, 06 Jul 2026 21:46:25 +1000 (AEST)
Date: Mon, 6 Jul 2026 21:46:19 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Utkarsh Verma <uverma@linux.ibm.com>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, th.huth@posteo.eu,
 nnmlinux@linux.ibm.com, sbhat@linux.ibm.com, harshpb@linux.ibm.com
Subject: Re: VW ELF loader
Message-ID: <akuViylBcKiXMbjH@zatzit>
References: <f881c2e7-be92-9695-6e19-2dd88cbc63c1@ozlabs.ru>
 <99254c26-0b41-4efc-b1cd-ad1e19576f32@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="VIE21t0VnofKrBxl"
Content-Disposition: inline
In-Reply-To: <99254c26-0b41-4efc-b1cd-ad1e19576f32@linux.ibm.com>
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=dgibson@gandalf.ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--VIE21t0VnofKrBxl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 06, 2026 at 02:37:48PM +0530, Utkarsh Verma wrote:
> +Thomas, Narayana, Shiva, Harsh - FYI
>=20
> Hi Alexey, David and Paolo,
> Reviving this thread as would like to add the disk boot support by loading
> GRUB.

Good luck, but I'm afraid I no longer have any interest in, or time to
commit to looking at ppc qemu stuff.

>=20
> On 2/1/20 7:09 PM, Alexey Kardashevskiy wrote:
> > Hi!
> >=20
> > In my effort to "kill SLOF" (the PPC pseries guest firmware), I
> > proceeded to the stage when QEMU needs to load GRUB from the disk. The
> > current workaround is to read it from qcow2, save in a file and then
> > call load_elf(). Not nice.
> >=20
> > 2 problems with that.
> >=20
> > 1. when load_elf calls address_space_write() - I need to know where and
> > how much RAM was used to mark this memory "used" for the OF client
> > interface (/memory@0/available FDT property). So I'll need "preload()"
> > hook.
> >=20
> > 2. (bigger) GRUB comes from PReP partition which is 8MB. load_elf{32|64}
> > consumes filename, not a memory pointer nor a "read_fn" callback - so I
> > thought I need a "read_fn" callback.
> >=20
> > And then I discovered that load_elf actually maps the passed file. And
> > here I got lost.
> >=20
> > Why does not load_elf just map the entire file and parse the bits? It
> > still reads chunks with seek+read and then it maps the file in a loop
> > potentially multiple times - is this even correct? Passing "fd" around
> > is weird.
> >=20
> > Why ROMs are different from "-kernel"?
> >=20
> > If I want to solve 1 and 2 of my problem, should I just cut-n-paste
> > load_elf and tweak bits rather then add more parameters to already
> > 15-parameters long prototypes?
> > Or I could read GRUB from qcow2 into the memory and change the rest to
> > parse ELF from memory (mapped from a ELF file or read from qcow2)?
> To rectify the mentioned issues, would like to implement a custom ELF loa=
der
> for ppc that can load the elf from the buffer and claim the memory for ea=
ch
> program header segment.
>=20
> It was attempted earlier in v6 (Patch 6/6) and v7 (Patch 5/5) , but later
> dropped for reasons unknown to me:
> v6:
> https://lore.kernel.org/qemu-devel/20200203032943.121178-1-aik@ozlabs.ru/
> v7: https://lore.kernel.org/qemu-devel/20200220061622.15064-1-aik@ozlabs.=
ru/
>=20
> I believe disk boot is a worthwhile addition to VOF. It would make the
> pseries machine type fully usable without SLOF for the most common case:
> booting from a distro qcow2 image with a PReP partition containing GRUB.
>=20
> >=20
> >=20
> >=20
> > Thanks,
> >=20
> > ps. VW =3D=3D very weird, indeed :)
> >=20
>=20
> Regards,
> Utkarsh Verma
>=20

--=20
David Gibson (he or they)	| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you, not the other way
				| around.
http://www.ozlabs.org/~dgibson

--VIE21t0VnofKrBxl
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEO+dNsU4E3yXUXRK2zQJF27ox2GcFAmpLlX4ACgkQzQJF27ox
2GfMfhAAhJUkd1uEDSyemR8pS3iQ7AVJ5fXqusxiG01w6MvJKtFZLbjUwSy+4TgK
5XnHJSipReBle58AT+UtZa5u912YP42/C7zOZa06X423tIa0dpAtjKpTtRlNZJZX
r0YAcNItxyuB7Xzf+D2AmVPXP4x+SJiVMmNRzcZvIgPNiOJIs4rt1hgBQxh3ApcC
yJiQTnhUur9OzPCKcbaqPIAJcIx/J63T5VrcRl/zWFl4RVugMKu2Iy9Wir2jM/+m
YizfRuU8XgDCnI9K5lGQXjwBbLNZL2XCRxkMHazXIzA5VkxfitZwg0MArnonIyXj
yW5qQrpetmo+p2ULOi/eOfW8J1HgFCFkzeF73hIz2xq7Yq0VDhbSwYM8mv6KgIyc
qu6Tz3StsvzL/kqZulm6laTuVhzJjr3Zxc+3cPFikZZDn7chTXHGfMSgYerrsZCP
8SimyR6pqwRHJFTxhjLC0xtRLjIh5ezeS+1694H4+xSJqqpr+Gdoq2Hga0+xgEZm
SBM/nkE4hd85rovAV++aNBtT4dvBpifjPvBFeTrGZMmX28RECc3E2e+z17IxaTTg
nIQzUgeqQRxMirq/bLxPfP2+cP1oSk0VzyPjTTU+yw1rVNlvadiJTmfEdtpscF3E
PuS1kfMsybCr5+xXt8ijHTNnJ7+svhttmwpJczlXkQQ0OS3/9Y8=
=Aahq
-----END PGP SIGNATURE-----

--VIE21t0VnofKrBxl--

