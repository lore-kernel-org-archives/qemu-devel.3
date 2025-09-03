Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DB8FCA1010
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 09:43:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utk1B-00056Y-Lu; Wed, 03 Sep 2025 05:43:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1utk19-0004x1-6l; Wed, 03 Sep 2025 05:43:03 -0400
Received: from fout-a5-smtp.messagingengine.com ([103.168.172.148])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1utk16-0007nv-Sf; Wed, 03 Sep 2025 05:43:02 -0400
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.phl.internal (Postfix) with ESMTP id 1AB17EC02FE;
 Wed,  3 Sep 2025 05:42:57 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Wed, 03 Sep 2025 05:42:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1756892577; x=
 1756978977; bh=F2UhSh9F8+9magCcLaC0S88kWc2QX3VMS9/j7/RxFt0=; b=b
 PbnpAow6FbpIePovFwRXBtA0EjWydppJC9ebafPpeh0P8w9b8C6YakD2K9vjLAgK
 PVPIvMwSppCQeNyoyOb3NCc18uCCiwb0o/M/fIkfDzCQPvn4cPtaC3J2Twfbn0Jr
 DT2Z3cI+mbsd8lptStbEt4WahOG4u7I32s7wenyCcJJixhjplhaMEFurgZxm/6+H
 ksjuQ5TpIRZHG/qN/vwPLcmWgQzG4GIknNtaOmtKRlk8v3ORYTYnHQLMJnHhthu6
 GmiYMJobxsKw9Zw5mubnHVc9JLHsyXuXzC565XXzxRkBRQDRLsYcEmAggVvYDT/r
 urIADp25RmasgfqxkxJcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
 1756892577; x=1756978977; bh=F2UhSh9F8+9magCcLaC0S88kWc2QX3VMS9/
 j7/RxFt0=; b=AA9C/Az0P9MSLWkE7pbuOzLIuzF4iJhjVFhj7+MWJaU3WQR1CU1
 RdcEr9hSNfLMejs6qK8BHAEsmCL9PJIFk8CzJVVGZxPtyL+phR/SQiQ4vS5hCIYE
 G1KLFKZGD9okocXaPVy/TMHkY52JeKAY+Bg4wDMCpnaq1O5sbRgbryo+bUn1k/I3
 6S+7pePGsAGhPfonojwCo1gueAmfVu2JrPQDhxnAcHO8LRuPu6F/7XIJ2SIgyheS
 VJ4y7EMdFn+OuipcUPko8ZS2OAXLhHbh07kw1lDuLdfsEgfo45okIzydI8Ao3vbw
 1cKdgg9z2loaTxj49r/Tmj5BDvoQJp8qp3w==
X-ME-Sender: <xms:nw24aK4ncyxLdjahmcMwirvEKb0wOxubtnYLjkc3KOLrEd52pELMGw>
 <xme:nw24aC0-QW9k1LNnJb-wVjgFJSDPa6GFa9HpGFPksXyKHwV0lU0g-2SMChNW4COCm
 zkiq8G977arfq1qm-s>
X-ME-Received: <xmr:nw24aFhayof1KWcZFbcjZaYHErM2ozZmJruza1oZRRIpgpZ-f9Mviudtq5BH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvkeduucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
 lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
 epfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepmfhlrghushculfgv
 nhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvghrnh
 epjefgjeefffdvuefhieefhffggfeuleehudekveejvedtuddugeeigeetffffjeevnecu
 vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepihhtshesih
 hrrhgvlhgvvhgrnhhtrdgukhdpnhgspghrtghpthhtohepudeipdhmohguvgepshhmthhp
 ohhuthdprhgtphhtthhopehsthgvfhgrnhhhrgesrhgvughhrghtrdgtohhmpdhrtghpth
 htohepfihilhhfrhgvugdrohhpvghnshhouhhrtggvsehgmhgrihhlrdgtohhmpdhrtghp
 thhtoheprghlihhsthgrihhrrdhfrhgrnhgtihhsseifuggtrdgtohhmpdhrtghpthhtoh
 epkhgsuhhstghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehfohhsshesuggvfhhm
 rggtrhhordhithdprhgtphhtthhopehfrghmsegvuhhphhhonhdrnhgvthdprhgtphhtth
 hopehphhhilhhmugeslhhinhgrrhhordhorhhgpdhrtghpthhtohepkhifohhlfhesrhgv
 ughhrghtrdgtohhmpdhrtghpthhtohephhhrvghithiisehrvgguhhgrthdrtghomh
X-ME-Proxy: <xmx:nw24aKr3VphGixpjVwP9_rk6ybtz6Z3M80pwNA3RRsEO3BlAkwnPgA>
 <xmx:nw24aAP_0xKQpN4cn7eNcwOX6N5sJUuhRxPwTrx1N9lYyg4w3N5_Kw>
 <xmx:nw24aO1Qz0ZnRayElfQRrXrUX8R0FUT-WoMawXt4vEtArvlPHUPAAg>
 <xmx:nw24aGrCKT2KPV-WCCOnNBWHAuSeBCm5_DVXkaeBSRbcWvg2b3iFVw>
 <xmx:oQ24aFOHDZELE09F8NBkBaDggl7uScKQpE-Uq7PWS0cO8RQkDqsZrHNV>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Sep 2025 05:42:55 -0400 (EDT)
Date: Wed, 3 Sep 2025 11:42:54 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Wilfred Mallawa <wilfred.opensource@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Keith Busch <kbusch@kernel.org>,
 Jesper Devantier <foss@defmacro.it>, Fam Zheng <fam@euphon.net>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: Re: [PATCH v3 3/5] hw/nvme: add NVMe Admin Security SPDM support
Message-ID: <aLgNns-n6pODC4JT@AALNPWKJENSEN.aal.scsc.local>
References: <20250901034759.85042-2-wilfred.opensource@gmail.com>
 <20250901034759.85042-5-wilfred.opensource@gmail.com>
 <20250903024705.GA103624@fedora>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="uGG/NEUv1tJA+MBX"
Content-Disposition: inline
In-Reply-To: <20250903024705.GA103624@fedora>
Received-SPF: pass client-ip=103.168.172.148; envelope-from=its@irrelevant.dk;
 helo=fout-a5-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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


--uGG/NEUv1tJA+MBX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sep  2 22:47, Stefan Hajnoczi wrote:
> On Mon, Sep 01, 2025 at 01:47:58PM +1000, Wilfred Mallawa wrote:
> > From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> >=20
> > Adds the NVMe Admin Security Send/Receive command support with support
> > for DMTFs SPDM. The transport binding for SPDM is defined in the
> > DMTF DSP0286.
> >=20
> > Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> > ---
> >  hw/nvme/ctrl.c       | 188 ++++++++++++++++++++++++++++++++++++++++++-
> >  hw/nvme/nvme.h       |   5 ++
> >  include/block/nvme.h |  15 ++++
> >  3 files changed, 207 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> > index f5ee6bf260..557f634016 100644
> > --- a/hw/nvme/ctrl.c
> > +++ b/hw/nvme/ctrl.c
> > @@ -282,6 +282,8 @@ static const uint32_t nvme_cse_acs_default[256] =3D=
 {
> >      [NVME_ADM_CMD_FORMAT_NVM]       =3D NVME_CMD_EFF_CSUPP | NVME_CMD_=
EFF_LBCC,
> >      [NVME_ADM_CMD_DIRECTIVE_RECV]   =3D NVME_CMD_EFF_CSUPP,
> >      [NVME_ADM_CMD_DIRECTIVE_SEND]   =3D NVME_CMD_EFF_CSUPP,
> > +    [NVME_ADM_CMD_SECURITY_SEND]   =3D NVME_CMD_EFF_CSUPP,
> > +    [NVME_ADM_CMD_SECURITY_RECV]   =3D NVME_CMD_EFF_CSUPP,
> >  };
> > =20
> >  static const uint32_t nvme_cse_iocs_nvm_default[256] =3D {
> > @@ -7282,6 +7284,185 @@ static uint16_t nvme_dbbuf_config(NvmeCtrl *n, =
const NvmeRequest *req)
> >      return NVME_SUCCESS;
> >  }
> > =20
> > +static uint16_t nvme_sec_prot_spdm_send(NvmeCtrl *n, NvmeRequest *req)
> > +{
> > +    StorageSpdmTransportHeader hdr =3D {0};
> > +    g_autofree uint8_t *sec_buf =3D NULL;
> > +    uint32_t transfer_len =3D le32_to_cpu(req->cmd.cdw11);
> > +    uint32_t transport_transfer_len =3D transfer_len;
> > +    uint32_t dw10 =3D le32_to_cpu(req->cmd.cdw10);
> > +    uint32_t recvd;
> > +    uint16_t nvme_cmd_status, ret;
> > +    uint8_t secp =3D extract32(dw10, 24, 8);
> > +    uint8_t spsp1 =3D extract32(dw10, 16, 8);
> > +    uint8_t spsp0 =3D extract32(dw10, 8, 8);
> > +    bool spdm_res;
> > +
> > +    transport_transfer_len +=3D sizeof(hdr);
> > +    if (transport_transfer_len > SPDM_SOCKET_MAX_MESSAGE_BUFFER_SIZE) {
>=20
> An integer overflow check is needed since transfer_len comes from the
> untrusted guest. This will prevent the sec_buf buffer overflow below
> when nvme_h2c() is called.
>=20

And it should not be allowed to exceed MDTS (see nvme_check_mdts). MDTS
may be configured as zero, so g_try_malloc should still be used.

--uGG/NEUv1tJA+MBX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmi4DZsACgkQTeGvMW1P
DelmVwgAnz037DSLQQD53O/lqyvIgILtjSzWqu+LsFDhPCUFXTmrr+x5kG+ILULa
SjMShLIN5v+hXEHMwVbivk+WyD/OIzBRENJyQf+elYdKwjx7VZon3PAdAn38VRyz
saHHPUtDrAAZ0jqbtkVzAJQU/ilq+hPAO6dP8bc5/bWpcj6OO1sfq2YrQeMkKarI
b4GzUrkGBnKibCc5GFUqoW7TzBH2k/2rUEKyY0MlvOHVc0WTN8Z/heTwj57qXzY2
BCdXU6ku7fM4BPVhG5tTo4aXAzrEfv1bMsTBJuJFZAOcMAMiyaO1J9Stro0YvjVn
PYPjqGSXsdN1M9xVZ5ray7kdWR/vNQ==
=bA+k
-----END PGP SIGNATURE-----

--uGG/NEUv1tJA+MBX--

