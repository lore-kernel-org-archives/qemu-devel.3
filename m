Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBA33C48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 14:49:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcRPX-0006cC-2a; Tue, 20 Feb 2024 09:47:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1rcRPG-0006a1-0Q; Tue, 20 Feb 2024 09:47:40 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1rcRPD-0000Vj-Lz; Tue, 20 Feb 2024 09:47:37 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailout.west.internal (Postfix) with ESMTP id 6380F32001FF;
 Tue, 20 Feb 2024 09:47:28 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
 by compute6.internal (MEProxy); Tue, 20 Feb 2024 09:47:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1708440447; x=
 1708526847; bh=UeXJE9mr/2yGO+4Ybp0gma6t16P8zvl74MUhJeJm+DM=; b=W
 SpIiQ3NXTd5Fr7zLMNv/TyArqaQJR2TPCsvEkUuhDHZVclEJuI0orsER4aM02SqE
 XoLpmUV6a3LaZkythTTQM9r1uZwEnXA8sod6HhT+rrAUfUOyJu7n4ZdsRMhbliBg
 SNxp3bAsKjDfEjgGpb+I2PivaXmx9NIxxeMFrHubhLaUSHrt6cR/cJjdIxX+HW1h
 F9G8x7LcbVYiiyxa4gDHLW+R2u+nGeeAooCeT32GDXIeJdj0+OH5dkbM6T9y++eW
 tmlIr0UMNZn/09SVzU/IZCL8RqElmeDUoR2eYQuA8nyvbhKikJG2rFUt6TewJ0fV
 WVGet6gIX32v7/g02gDlw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; t=1708440447; x=1708526847; bh=UeXJE9mr/2yGO+4Ybp0gma6t16P8
 zvl74MUhJeJm+DM=; b=XvAqkf+Y4bqVyFxbrl5maMntlS9you9kwwke8pQ84m+5
 t/c2Werhw2TAlM4Lv0IlF71cEGJ4x8jtnAxFGjmOJGHHiH4+JGh6L5G80Jv9p88N
 rseCNGKuxqXw6sgWy15XAfkIqxY/EN1FMXmjW2Yovu9AnR5sCq8cUNAXhIvTXzuY
 6ZXUxFtz2h3URGlF6Va6qfoFcVI7Rzj95+/BDrTJhxf/JJna7T1Fo28zhJ2opJvt
 RYCpHycqDIlrocLY7SD8w4Ia0MGzJg4uugXoF+4CkUCGp5pwQr52oyc+r0NJX96L
 QoQhb8HiptRN1SsmMbsZH14yewUOYp0nxxdLixq9nA==
X-ME-Sender: <xms:f7vUZSIuNK4XXrx2PA3TY3V8MaLbnK-zWE-ecl0XmcjRRwYrDalogg>
 <xme:f7vUZaJM-FjmJPmSSIo_dEpfgm4E2E_jcNN8fgOhNgB1EqWwr_lfZ7NIDq2yVhaB8
 ADt7PzoP5JKP3BOP20>
X-ME-Received: <xmr:f7vUZSuFSg88APwoRsWFO7luGkhTRCa8xjhRBwN2GWx8p380_NJMEVRvuw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedtgdeilecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeejgfejfeffvdeuhfeifefhgffgueelhedukeevjeevtdduudegieegteffffej
 veenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehith
 hssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:f7vUZXbB5sgVAAyp_jablXUT6iY7k64XmDiOtq0CRWgDrzFlXDMykQ>
 <xmx:f7vUZZYnHMXmnER_esCLrvwoln4CCpuhTCHo3sRHil3FaCDfvE1jBw>
 <xmx:f7vUZTA7vEt6-to1NWUknk6PjzAUJ782b8r3VRiDo-hTlTXXhFqImA>
 <xmx:f7vUZRK0gVdf6zXT-9oD8Ha_FeN0MENJnmhs_CPEjPmWpZV99BNOzw>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Feb 2024 09:47:26 -0500 (EST)
Date: Tue, 20 Feb 2024 15:47:21 +0100
From: Klaus Jensen <its@irrelevant.dk>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
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
Message-ID: <ZdS7eRTubi7Mvwjc@cormorant.local>
References: <20240220-reuse-v6-0-2e42a28b0cf2@daynix.com>
 <20240220-reuse-v6-1-2e42a28b0cf2@daynix.com>
 <ZdS3OI9vIu-jvJ37@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="N252vfvQo8x5U0MP"
Content-Disposition: inline
In-Reply-To: <ZdS3OI9vIu-jvJ37@redhat.com>
Received-SPF: pass client-ip=64.147.123.20; envelope-from=its@irrelevant.dk;
 helo=wout4-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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


--N252vfvQo8x5U0MP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Feb 20 15:29, Kevin Wolf wrote:
> Am 20.02.2024 um 13:24 hat Akihiko Odaki geschrieben:
> > nvme_sriov_pre_write_ctrl() used to directly inspect SR-IOV
> > configurations to know the number of VFs being disabled due to SR-IOV
> > configuration writes, but the logic was flawed and resulted in
> > out-of-bound memory access.
> >=20
> > It assumed PCI_SRIOV_NUM_VF always has the number of currently enabled
> > VFs, but it actually doesn't in the following cases:
> > - PCI_SRIOV_NUM_VF has been set but PCI_SRIOV_CTRL_VFE has never been.
> > - PCI_SRIOV_NUM_VF was written after PCI_SRIOV_CTRL_VFE was set.
> > - VFs were only partially enabled because of realization failure.
> >=20
> > It is a responsibility of pcie_sriov to interpret SR-IOV configurations
> > and pcie_sriov does it correctly, so use pcie_sriov_num_vfs(), which it
> > provides, to get the number of enabled VFs before and after SR-IOV
> > configuration writes.
> >=20
> > Cc: qemu-stable@nongnu.org
> > Fixes: CVE-2024-26328
> > Fixes: 11871f53ef8e ("hw/nvme: Add support for the Virtualization Manag=
ement command")
> > Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> > ---
> >  hw/nvme/ctrl.c | 26 ++++++++------------------
> >  1 file changed, 8 insertions(+), 18 deletions(-)
> >=20
> > diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> > index f026245d1e9e..7a56e7b79b4d 100644
> > --- a/hw/nvme/ctrl.c
> > +++ b/hw/nvme/ctrl.c
> > @@ -8466,36 +8466,26 @@ static void nvme_pci_reset(DeviceState *qdev)
> >      nvme_ctrl_reset(n, NVME_RESET_FUNCTION);
> >  }
> > =20
> > -static void nvme_sriov_pre_write_ctrl(PCIDevice *dev, uint32_t address,
> > -                                      uint32_t val, int len)
> > +static void nvme_sriov_post_write_config(PCIDevice *dev, uint16_t old_=
num_vfs)
> >  {
> >      NvmeCtrl *n =3D NVME(dev);
> >      NvmeSecCtrlEntry *sctrl;
> > -    uint16_t sriov_cap =3D dev->exp.sriov_cap;
> > -    uint32_t off =3D address - sriov_cap;
> > -    int i, num_vfs;
> > +    int i;
> > =20
> > -    if (!sriov_cap) {
> > -        return;
> > -    }
> > -
> > -    if (range_covers_byte(off, len, PCI_SRIOV_CTRL)) {
> > -        if (!(val & PCI_SRIOV_CTRL_VFE)) {
> > -            num_vfs =3D pci_get_word(dev->config + sriov_cap + PCI_SRI=
OV_NUM_VF);
> > -            for (i =3D 0; i < num_vfs; i++) {
> > -                sctrl =3D &n->sec_ctrl_list.sec[i];
> > -                nvme_virt_set_state(n, le16_to_cpu(sctrl->scid), false=
);
> > -            }
> > -        }
> > +    for (i =3D pcie_sriov_num_vfs(dev); i < old_num_vfs; i++) {
> > +        sctrl =3D &n->sec_ctrl_list.sec[i];
> > +        nvme_virt_set_state(n, le16_to_cpu(sctrl->scid), false);
> >      }
> >  }
>=20
> Maybe I'm missing something, but if the concern is that 'i' could run
> beyond the end of the array, I don't see anything that limits
> pcie_sriov_num_vfs() to the static size of 127 that n->sec_ctrl_list.sec
> has. register_vfs() seems to just take whatever 16 bit value the guest
> wrote without imposing additional restrictions.
>=20

Hi Kevin,

Thanks for reviewing, I believe patch 2 in this series fixes that
missing validation of NumVFs.

--N252vfvQo8x5U0MP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmXUu3gACgkQTeGvMW1P
DemWjgf/dfTQtx267ZIepz1KW1s6sQvKrjQn5gnyab1h0TW14JcjBfOugC5zEaXt
+J98FRIxGCN9CNrnAGqGs3FR/RQomItyxu51HYMlxM6zp+ZWLxDiYl4cgGlO2a//
KWc3e86ejcnPsTZdh0JWCwKz1ePOTM42lJplrzKb3wQRDMIkumW/gLyOMBghJHMi
spnqfPOvOMrxNF1LtxWtgSxppFPpvPMsigIXhVx19dlJf6XxTDUIEBctbNZoKpD+
Ro1FrPWAmZ+L0SFEb+7xdpqlf2jhN4kNfK7xAwYifV73njO7uszRiZydk1zIS0Kr
rXWS2tUtqMv2yR8DLjNJ/W/g7A13iA==
=FCPO
-----END PGP SIGNATURE-----

--N252vfvQo8x5U0MP--

