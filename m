Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53C55C48BC4
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 20:42:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcWvE-0002DV-VJ; Tue, 20 Feb 2024 15:41:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1rcWv7-00029b-4I; Tue, 20 Feb 2024 15:40:53 -0500
Received: from wfhigh5-smtp.messagingengine.com ([64.147.123.156])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1rcWv4-0003D7-Dv; Tue, 20 Feb 2024 15:40:52 -0500
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
 by mailfhigh.west.internal (Postfix) with ESMTP id B34181800261;
 Tue, 20 Feb 2024 15:40:44 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
 by compute7.internal (MEProxy); Tue, 20 Feb 2024 15:40:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1708461644; x=
 1708548044; bh=gwtTGDFqy5zzt4gw2kuf+XbsoXyMfmIJ7YJvKXCBLgA=; b=R
 8yQ81HfFiy3d8Nv1fzQelLAQOq2/xadBd7+n37w02L4brVEAuDkXEw9CQ10jvtWo
 3R0d9Qy7HXEIRUmR0xpLVOiZpkk+g/tulytWJO3p3OLCCUtlJ95/dYYzxVio4QaY
 RaUf4EvANZl5/9IrK7+KHoyBfj2fqyREEh1W3m7tVbzdolOvtVP+hfF8w/LsSeWq
 qHaDsOOByK/oIXRSlL/xTL7r6QYD3eR6tv0nIv8Ew4UflV5D+ziKK/5woM/ILsN/
 kbKakqnUwb01D6t+gghgYApf4ruCubpTG6FE+2FT14mRJ1SZf7uODsEdA6nZLP0a
 /aNn7aRiOD6kKobuPbOeg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; t=1708461644; x=1708548044; bh=gwtTGDFqy5zzt4gw2kuf+XbsoXyM
 fmIJ7YJvKXCBLgA=; b=Q2ZMenfOqq3Y9GOXDNPb4tUCRfM27f0n8Z9E6uqeAxwm
 Ir0Qa07Bah0QeYJ+EEsSnxMTkRA3ry61kR3GOl2wGUKMsv7uG+TmCa2yN7eABBrW
 7BI458X7bYlYNmALx45WV3mVAualkdpKuqGpAdMfAhTPzOwwoZiXq6aKouhcnc5b
 Xh1ZkECZWJF5nccAbEuVh2fOkBXH2K42anr5csJWosqdL9hTAnuBn3BPXalpUMzY
 GvAGm4oD9tR2vBkXKFBNnU0SHLJz3LvUjEtEBAIsdbYqw3Ky704lx66MkURKTcqm
 jMj2U8seqSfQKZ9PnCTjCq6VSZniXyz74ZtQ/PoC4g==
X-ME-Sender: <xms:Sw7VZbf4eBCNfascVBWd4Z_nya9YUYeFgoxcSCKQfwK3pEZmMTavhg>
 <xme:Sw7VZRNsoPWKqIcUIZ3mE50R9JxFu3pOSbs30eYxuSGLyHJjIeGUT7n37t8uZEk_0
 iOybD0x5Vs2XPfl1rM>
X-ME-Received: <xmr:Sw7VZUhuS8mR2XvtmpGBJ6Nupsfm5se0DgQ1DMb3EXKp8RGdAl8lz8RLlA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedtgddugedtucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepmfhlrghu
 shculfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrth
 htvghrnhepjefgjeefffdvuefhieefhffggfeuleehudekveejvedtuddugeeigeetffff
 jeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepih
 htshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:Sw7VZc8QdtmPipoElymO2b0JGav8a4lTuazPp_HX8LvOgQwqxq3CWQ>
 <xmx:Sw7VZXvmduddOqvw4_YTOSc8OGstOLa0Yi5PlKBwFgqrSNwxR6DQXg>
 <xmx:Sw7VZbFA_QRjZb7HRXX4W6zT7YZ0NLv3xkr548Z1nn_GiFbJT4Cf8A>
 <xmx:TA7VZTS3mecG_lI-4DFYyXxmCUm2qVGrfzslHS3q4m65GL7yeG847Oqnj0Q>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Feb 2024 15:40:42 -0500 (EST)
Date: Tue, 20 Feb 2024 21:40:38 +0100
From: Klaus Jensen <its@irrelevant.dk>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Kevin Wolf <kwolf@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-stable@nongnu.org
Subject: Re: [PATCH v6 01/15] hw/nvme: Use pcie_sriov_num_vfs()
Message-ID: <ZdUORlAIMpQN0hAk@cormorant.local>
References: <20240220-reuse-v6-0-2e42a28b0cf2@daynix.com>
 <20240220-reuse-v6-1-2e42a28b0cf2@daynix.com>
 <ZdS3OI9vIu-jvJ37@redhat.com> <ZdS8-VoNPYAMItEy@redhat.com>
 <763f68fa-5c50-4f68-a758-fadcba36b857@daynix.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Lovn/vZY6U9EDIWs"
Content-Disposition: inline
In-Reply-To: <763f68fa-5c50-4f68-a758-fadcba36b857@daynix.com>
Received-SPF: pass client-ip=64.147.123.156; envelope-from=its@irrelevant.dk;
 helo=wfhigh5-smtp.messagingengine.com
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


--Lovn/vZY6U9EDIWs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Feb 21 00:33, Akihiko Odaki wrote:
> On 2024/02/20 23:53, Kevin Wolf wrote:
> > Am 20.02.2024 um 15:29 hat Kevin Wolf geschrieben:
> > > Am 20.02.2024 um 13:24 hat Akihiko Odaki geschrieben:
> > > > nvme_sriov_pre_write_ctrl() used to directly inspect SR-IOV
> > > > configurations to know the number of VFs being disabled due to SR-I=
OV
> > > > configuration writes, but the logic was flawed and resulted in
> > > > out-of-bound memory access.
> > > >=20
> > > > It assumed PCI_SRIOV_NUM_VF always has the number of currently enab=
led
> > > > VFs, but it actually doesn't in the following cases:
> > > > - PCI_SRIOV_NUM_VF has been set but PCI_SRIOV_CTRL_VFE has never be=
en.
> > > > - PCI_SRIOV_NUM_VF was written after PCI_SRIOV_CTRL_VFE was set.
> > > > - VFs were only partially enabled because of realization failure.
> > > >=20
> > > > It is a responsibility of pcie_sriov to interpret SR-IOV configurat=
ions
> > > > and pcie_sriov does it correctly, so use pcie_sriov_num_vfs(), whic=
h it
> > > > provides, to get the number of enabled VFs before and after SR-IOV
> > > > configuration writes.
> > > >=20
> > > > Cc: qemu-stable@nongnu.org
> > > > Fixes: CVE-2024-26328
> > > > Fixes: 11871f53ef8e ("hw/nvme: Add support for the Virtualization M=
anagement command")
> > > > Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> > > > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> > > > ---
> > > >   hw/nvme/ctrl.c | 26 ++++++++------------------
> > > >   1 file changed, 8 insertions(+), 18 deletions(-)
> > > >=20
> > > > diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> > > > index f026245d1e9e..7a56e7b79b4d 100644
> > > > --- a/hw/nvme/ctrl.c
> > > > +++ b/hw/nvme/ctrl.c
> > > > @@ -8466,36 +8466,26 @@ static void nvme_pci_reset(DeviceState *qde=
v)
> > > >       nvme_ctrl_reset(n, NVME_RESET_FUNCTION);
> > > >   }
> > > > -static void nvme_sriov_pre_write_ctrl(PCIDevice *dev, uint32_t add=
ress,
> > > > -                                      uint32_t val, int len)
> > > > +static void nvme_sriov_post_write_config(PCIDevice *dev, uint16_t =
old_num_vfs)
> > > >   {
> > > >       NvmeCtrl *n =3D NVME(dev);
> > > >       NvmeSecCtrlEntry *sctrl;
> > > > -    uint16_t sriov_cap =3D dev->exp.sriov_cap;
> > > > -    uint32_t off =3D address - sriov_cap;
> > > > -    int i, num_vfs;
> > > > +    int i;
> > > > -    if (!sriov_cap) {
> > > > -        return;
> > > > -    }
> > > > -
> > > > -    if (range_covers_byte(off, len, PCI_SRIOV_CTRL)) {
> > > > -        if (!(val & PCI_SRIOV_CTRL_VFE)) {
> > > > -            num_vfs =3D pci_get_word(dev->config + sriov_cap + PCI=
_SRIOV_NUM_VF);
> > > > -            for (i =3D 0; i < num_vfs; i++) {
> > > > -                sctrl =3D &n->sec_ctrl_list.sec[i];
> > > > -                nvme_virt_set_state(n, le16_to_cpu(sctrl->scid), f=
alse);
> > > > -            }
> > > > -        }
> > > > +    for (i =3D pcie_sriov_num_vfs(dev); i < old_num_vfs; i++) {
> > > > +        sctrl =3D &n->sec_ctrl_list.sec[i];
> > > > +        nvme_virt_set_state(n, le16_to_cpu(sctrl->scid), false);
> > > >       }
> > > >   }
> > >=20
> > > Maybe I'm missing something, but if the concern is that 'i' could run
> > > beyond the end of the array, I don't see anything that limits
> > > pcie_sriov_num_vfs() to the static size of 127 that n->sec_ctrl_list.=
sec
> > > has. register_vfs() seems to just take whatever 16 bit value the guest
> > > wrote without imposing additional restrictions.
> > >=20
> > > If there is some mechanism that makes register_vf() fail if we exceed
> > > the limit, maybe an assertion with a comment would be in order because
> > > it doesn't seem obvious. I couldn't find any code that enforces it,
> > > sriov_max_vfs only ever seems to be used as a hint for the guest.
> > >=20
> > > If not, do we need another check that fails gracefully in the error
> > > case?
> >=20
> > Ok, I see now that patch 2 fixes this. But then the commit message is
> > wrong because it implies that this patch is the only thing you need to
> > fix the problem with nvme. You can't say "Fixes: CVE-2024-26328" if half
> > of the fix is still missing.
>=20
> I didn't assign CVE-2024-26328 for the case that the value of
> PCI_SRIOV_NUM_VF is greater than PCI_SRIOV_TOTAL_VF; it's what
> CVE-2024-26327 deals with.
>=20
> The problem I dealt here is that the value of PCI_SRIOV_NUM_VF may not
> represent the actual number of enabled VFs because another register
> (PCI_SRIOV_CTRL_VFE) is not set, for example.
>=20
> If an assertion to be added, I think it should be in pcie_sriov_num_vfs()
> and ensure the returning value is less than the value of PCI_SRIOV_TOTAL_=
VF
> (aka sriov_max_vfs in hw/nvme/ctrl.c), but I think it's fine without it.
>=20
> >=20
> > Maybe asserting old_num_vfs < n->sec_ctrl_list.numcntl would still be a
> > good idea. But looking at this one, it seems to me that numcntl isn't
> > completely correct either:
> >=20
> >      list->numcntl =3D cpu_to_le16(max_vfs);
> >=20
> > Both list->numcntl and max_vfs are uint8_t, so I think this will always
> > be 0 on big endian hosts?
>=20
> Indeed it looks wrong. Will you write a patch?
>=20

I'll fix it. And give the SR-IOV parts of hw/nvme some love all around.

--Lovn/vZY6U9EDIWs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmXVDkUACgkQTeGvMW1P
Denz3Qf+IxRt3S0DFZQfJzqA9xLrr5n/BoiofYcE7Xo2HTBpKO1mR4uFAeHHu4iW
ysB+r77tjDYIicTanE+iQRxo/2xXmbvvWtLMBJZrISz0IYgDxXtkFVKvzhAn62Jh
akv6BFu++vWjux1p3Ms6go0M686W87HVi2R1g/HjrzHEFhMl4luX8e0ycXPuzQhH
ZnWqF8kpiHiMoosZWPieJ1IvSbYlQjnoJHjXcaVGo2lm6xAkgvBKEgP0OITHHVjM
Ny7XuWbdzRZ8xOUDGn2bbILqLkFJjUn5cASh3l6LcNq2zfnjtyTi4AzJPgjMFmhK
+Jf9dJ13wMC0j4oYWqBgQSLVSoiWqQ==
=X+RV
-----END PGP SIGNATURE-----

--Lovn/vZY6U9EDIWs--

