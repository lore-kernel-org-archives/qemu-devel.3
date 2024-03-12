Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41C66C54E60
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 12:00:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk0n8-0007SP-Pz; Tue, 12 Mar 2024 07:59:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1rk0n4-0007LZ-Nt; Tue, 12 Mar 2024 07:59:31 -0400
Received: from wfhigh1-smtp.messagingengine.com ([64.147.123.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1rk0n1-0007ej-6K; Tue, 12 Mar 2024 07:59:30 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailfhigh.west.internal (Postfix) with ESMTP id AA7D61800095;
 Tue, 12 Mar 2024 07:59:22 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute1.internal (MEProxy); Tue, 12 Mar 2024 07:59:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1710244762; x=
 1710331162; bh=SKqiTgnwHhQV6z4MG4++MabXEo+dEqnV3j4/j3vMjYg=; b=I
 gjQfXp4tkmOqLVlnL3d6IpVNkXNyAL+33nOKn9VTdIdFW2pSO/HAkCRUw5z1QuVG
 FqHX/57buHAq4WD8vEU+d3cI1GnyJmKtcSf9+eMH28Tr61pHSfl31iZVdIqtQaiv
 waTk3WEVfhmj/BYP5WBZ8dzNo+wq+LGq7vpIQsvMiS/l8GnhlLuLLAunJUtuvPLR
 jLvV4bYWa8DrfXX1ZSM5ruU+bGATOIdBgcLI05PEiD4tp7V/v5A4DmYlkuN0iVkH
 G57svZQh92XMu8MzB9RaAE1pO06IoguEwwfw4li28l/z5D0luH99KqpUI64uxQE8
 rkU05eSH4k6bZc4x99hQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; t=1710244762; x=1710331162; bh=SKqiTgnwHhQV6z4MG4++MabXEo+d
 EqnV3j4/j3vMjYg=; b=odR948ZEbu8qTMFoa90usz8Ho5IB5L0SPLW7EB/KI/pi
 bRAMuBStN/n/yX/YcFuthcEmynaDGwmwpefGtQIDW09cunHKGMuV50Tm1wBpZM+6
 zSvtiETzU8fJjgZaEg9nE5zD/m7BN9SZyvK3KGhlwOI8g4PmMPRxWBYMaWQP5uaK
 Mh3b758/U/TJtfGywZ9VO890iv9HyfvMZCkhK1CFyAXe5XhQiXJ0JJ0Q3L2u4Yl+
 bCaNogtJiVNo1GRl+Lt+uIvi55KpeA0V23lNxpCq9jC7FhmXR41WyumvMiyOtm9z
 pyqE7Oh67a0YTaj38fN5jtRz/4Kiyry2OtaFi0qXkQ==
X-ME-Sender: <xms:mEPwZbIAooXGLO2YD5c1PUUOXnmJ00Wrpztbdqr5-7ybyeacRdNmfA>
 <xme:mEPwZfJTqLq0T630iLccH18xUcHgviVMpSDuWZUWbYAKhNP2EplIRfTUSswD6OE2D
 dLLx8fnp7bXQYwDS2k>
X-ME-Received: <xmr:mEPwZTuCj-tkO12_nG6PmL85721-QJlRpAhdmrUXntXnUIKc_vj5rkx9vg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjeefgdefgecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpedufeelgfevvdekfffhuedtudduheehfffhgefhkedvjeelvdevudelieeihefg
 gfenucffohhmrghinhepghhithhhuhgsrdgtohhmpdhgihhtlhgrsgdrtghomhenucevlh
 hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhr
 vghlvghvrghnthdrughk
X-ME-Proxy: <xmx:mEPwZUbhYrhEKSFFS0URRon21zj4jfJVNsWzNbf9iojbKYtObydKUA>
 <xmx:mEPwZSaTSvWfyh-uGZPBugf8YG8l30rxKQ1vPMoHr8Nu4JU-wI3Qmg>
 <xmx:mEPwZYBn44z9P2RsihrlffPGa75NNQ_mNA9GjYW6AevfjuRIU3Hl6w>
 <xmx:mEPwZQajbSgnEb1BdhbRCgh3fPaYb9mwSb_g3MYzcD8Rv09mYvs_Ww>
 <xmx:mkPwZeRwgOSIcse5RnewtXurry-L7zuO_AHJfJhxqNQB3qWGgVTkIbsjDY8>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Mar 2024 07:59:19 -0400 (EDT)
Date: Tue, 12 Mar 2024 12:59:10 +0100
From: Klaus Jensen <its@irrelevant.dk>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-block@nongnu.org, Jesper Devantier <foss@defmacro.it>,
 Yanan Wang <wangyanan55@huawei.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <k.jensen@samsung.com>
Subject: Re: [PULL 0/6] hw/nvme updates
Message-ID: <ZfBDjktm3b7a4sWN@cormorant.local>
References: <20240311191105.35224-8-its@irrelevant.dk>
 <CAFEAcA_FC+FtfLHVy7=ekBH2SJCYpuPrg8rVg45XFZwO6r1+Lw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Fy1y4iAdjgqcQxKT"
Content-Disposition: inline
In-Reply-To: <CAFEAcA_FC+FtfLHVy7=ekBH2SJCYpuPrg8rVg45XFZwO6r1+Lw@mail.gmail.com>
Received-SPF: pass client-ip=64.147.123.152; envelope-from=its@irrelevant.dk;
 helo=wfhigh1-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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


--Fy1y4iAdjgqcQxKT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mar 12 11:34, Peter Maydell wrote:
> On Mon, 11 Mar 2024 at 19:11, Klaus Jensen <its@irrelevant.dk> wrote:
> >
> > From: Klaus Jensen <k.jensen@samsung.com>
> >
> > Hi,
> >
> > The following changes since commit 7489f7f3f81dcb776df8c1b9a9db281fc21b=
f05f:
> >
> >   Merge tag 'hw-misc-20240309' of https://github.com/philmd/qemu into s=
taging (2024-03-09 20:12:21 +0000)
> >
> > are available in the Git repository at:
> >
> >   https://gitlab.com/birkelund/qemu.git tags/nvme-next-pull-request
> >
> > for you to fetch changes up to a1505d799232939bf90c1b3e1fc20e81cd398404:
> >
> >   hw/nvme: add machine compatibility parameter to enable msix exclusive=
 bar (2024-03-11 20:07:41 +0100)
> >
> > ----------------------------------------------------------------
> > hw/nvme updates
> > -----BEGIN PGP SIGNATURE-----
> >
> > iQEzBAABCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmXvVsYACgkQTeGvMW1P
> > DemWtwf9HU3cjtvCp8AeHGoPFTwp8/Vx3cQlQ6ilADKSDm44up2+M504xE/Mdviv
> > 6y3PTPe1yiEpg/MbjWTX/df5lo+VdNoCuCyjph9mea0s1QAjCfVpl+KLMUVF/Oj5
> > y1Iz9PQqOVDJ3O4xlgmPTfd8NXE/frNJaiXAjFuBxF2+4lilD5kMxpyu7DXbLiy2
> > Szd1I3DhFAEOLEbrSSRDI3Fpy0KBdRzdKuUfmRdrHzbmhzHJefW7wnZ3aAiDboaD
> > Ny7y/aovmjGymMp9GrBKWhUFPfSUtJ8l8j4Z7acQs+VDxg8lcAHCJKOyqCBTspUL
> > PSnDe6E/CRyjrG2fUVXTLb6YW1eibQ=3D=3D
> > =3DLd7a
> > -----END PGP SIGNATURE-----
>=20
> Hi; I'm afraid this fails to build for some jobs, eg
> https://gitlab.com/qemu-project/qemu/-/jobs/6373091994
> https://gitlab.com/qemu-project/qemu/-/jobs/6373091978
> https://gitlab.com/qemu-project/qemu/-/jobs/6373091975
>=20
> ../hw/nvme/ctrl.c: In function =E2=80=98nvme_realize=E2=80=99:
> ../hw/nvme/ctrl.c:8146:15: error: =E2=80=98msix_pba_offset=E2=80=99 may b=
e used
> uninitialized in this function [-Werror=3Dmaybe-uninitialized]
> 8146 | ret =3D msix_init(pci_dev, n->params.msix_qsize,
>      | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 8147 | &n->bar0, 0, msix_table_offset,
>      | ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 8148 | &n->bar0, 0, msix_pba_offset, 0, errp);
>      | ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ../hw/nvme/ctrl.c:8099:33: note: =E2=80=98msix_pba_offset=E2=80=99 was de=
clared here
> 8099 | unsigned msix_table_offset, msix_pba_offset;
>      | ^~~~~~~~~~~~~~~
> ../hw/nvme/ctrl.c:8135:9: error: =E2=80=98msix_table_offset=E2=80=99 may =
be used
> uninitialized in this function [-Werror=3Dmaybe-uninitialized]
> 8135 | memory_region_init_io(&n->iomem, OBJECT(n), &nvme_mmio_ops, n, "nv=
me",
>      | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~
> 8136 | msix_table_offset);
>      | ~~~~~~~~~~~~~~~~~~
> ../hw/nvme/ctrl.c:8099:14: note: =E2=80=98msix_table_offset=E2=80=99 was =
declared here
> 8099 | unsigned msix_table_offset, msix_pba_offset;
>      | ^~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
>=20
>=20
> I think this is because the compiler notices that nvme_mbar_size() has
> an early-exit code path which never initializes *msix_table_offset
> and *msix-pba_offset.
>=20

Crap, yeah. I'll fix it up. Thanks!

--Fy1y4iAdjgqcQxKT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmXwQ40ACgkQTeGvMW1P
DellcggArkeBg5t841F6zkYo+X302MXgWlH1pL94D41XYNKcoMrbiP6sZKTCiDnY
bIYFqlx5vSjSzxJiaEZ9lxpOCSDkyTxdC9P9n45o7KloEenMmZstxKEnQOA3vUFe
hzNgWaYyF0NL6kQkG2dsBsYJAFc7mQXgdyP6QKmy6XdaIIezSGDMeSfZmAevU0AY
wz8KjPr5ueYWPzjhALpAl7u4fyUCUb0ds0btS+9X6EXIcmMVfnRkg1TfUaDwyR01
EdZBiVVa+Q7rDQHFuC/dv3VnDPblXd+MRTOkOEnNmcX38OQCrtxSRc0Wfat5/4+F
+8ik0wc1U+VsRMPzXRINBtVre1y7lQ==
=D9eA
-----END PGP SIGNATURE-----

--Fy1y4iAdjgqcQxKT--

