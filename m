Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67F8BCA1016
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 06:31:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwapf-0003bi-37; Thu, 11 Sep 2025 02:31:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1uwapU-0003ZS-3Z; Thu, 11 Sep 2025 02:30:48 -0400
Received: from fout-a2-smtp.messagingengine.com ([103.168.172.145])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1uwapP-0003Xm-NG; Thu, 11 Sep 2025 02:30:47 -0400
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
 by mailfout.phl.internal (Postfix) with ESMTP id BE8DCEC026E;
 Thu, 11 Sep 2025 02:30:42 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-11.internal (MEProxy); Thu, 11 Sep 2025 02:30:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1757572242; x=
 1757658642; bh=2Etjxrl+eTV7CYDKMRSXDKQu5Q6PlmimPKnw52efMLs=; b=B
 tU9DQF+mIalydqfq9CG8Hs1Kmw2ncFf4SJRepCd1XL1B8Op03eCa+0cdY/b2po53
 UKrBjQz8oaazJ+85EiEtyBd8RWyzkNU5g1XD4UpXd7eV92RYo3lFoecgdYrbGpf0
 9FiX/GM3uQcuduXl8hDpfv8YWvsFm9LaN0KDul3z9LO5O8Rqy7BYdAX/6tyDAYeS
 Fa9QDpBfegTJqUCTpjUdrxbT5us0hEUCzvcKoO7bSry5Vr8huurAD8nCJ+BBmxDh
 U/4XoXA2oq4aYEICOQ1HphgFhjhLtD84dn1gnLuqFx3Pqhb2oG3sBGpRR3zAGk8m
 1O/Yt1epLYqeXDo/RZJBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
 1757572242; x=1757658642; bh=2Etjxrl+eTV7CYDKMRSXDKQu5Q6PlmimPKn
 w52efMLs=; b=I0zmSrGj8ikNFFv/1wcuyT1Cp0yZy0EDOuYWdJYEOceevDXdnwu
 eYJY4FNbWA6ExdYhtb6lscHdR8pEQ4DZleng20uLkgkoy8G2RZVaaIp0ay5TE5Wk
 OOfH/KD7dgxQLd5dUxC+faHL4phYby+6UV+BLR71zcRZxHOcyH0cG2K89yPKsqoZ
 yc3NUNnaiV22M4ZgX7RgzznUOpuJIyIbxUOOe7pCnGIBVG4iqaxcpby+sOHwAeEn
 CHQMHtnO1k7bmXBM3kWryG0QmSXMNClxc1Upf4wBN4Gz+eOfZpxYVB+3FoQHiz9Z
 biQ6Cyxi1qznxXytFkrMYT0v3XMJD7A/4gg==
X-ME-Sender: <xms:kWzCaNa5_iKMNEphlOjL_CmTHmBMAOaB8DkJqxz5fuuQnrZfaP0O1g>
 <xme:kWzCaE3XXdoF07Ep_nj6fPMJWIg8xDUfy8bo-sayNWaVfvLTUsKEKQNrFlr6yPJB6
 KKxnhr6z__3QEyq6t4>
X-ME-Received: <xmr:kWzCaPtJQ-u4eT9067T6wD7-hV1MnAB45HlPsl2TqONGO9SFGTdnUPAZzAI8bg4RP1fg8gAyuEhEiySm9X1exA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvheeghecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefmlhgruhhsucfl
 vghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtthgvrh
 hnpefhkeehvdfggfefgfejkeekffeigfejudejveeileehheekgefhheetvddvuefhheen
 ucffohhmrghinhepughmthhfrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
 hrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukhdpnhgspghr
 tghpthhtohepudeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeifihhlfhhrvg
 gurdhophgvnhhsohhurhgtvgesghhmrghilhdrtghomhdprhgtphhtthhopegrlhhishht
 rghirhdrfhhrrghntghishesfigutgdrtghomhdprhgtphhtthhopehksghushgthheskh
 gvrhhnvghlrdhorhhgpdhrtghpthhtohepfhhoshhsseguvghfmhgrtghrohdrihhtpdhr
 tghpthhtohepshhtvghfrghnhhgrsehrvgguhhgrthdrtghomhdprhgtphhtthhopehfrg
 hmsegvuhhphhhonhdrnhgvthdprhgtphhtthhopehphhhilhhmugeslhhinhgrrhhordho
 rhhgpdhrtghpthhtohepkhifohhlfhesrhgvughhrghtrdgtohhmpdhrtghpthhtohephh
 hrvghithiisehrvgguhhgrthdrtghomh
X-ME-Proxy: <xmx:kWzCaIDRE9Qbbme89ih3pPNwVV2xO9RA0MtgMWOKv8jQkte_qQ9bZg>
 <xmx:kWzCaCY-VFfNp79KNlEKixtCMNVqEZT7VRXA9-Hat8OXXpbmFnjPxA>
 <xmx:kWzCaK_5b9H6qZbe9yRo_ti6ToQiZ8wa7bPPFkv0A_LCloBZ4HNZYA>
 <xmx:kWzCaGgRpsp2vySrNbu2ds-Opc6Yyq-aSCDxbzuRTV6is3irf_7oMg>
 <xmx:kmzCaGXzG9x5y-JkXTb2cGPfVxlmMpm4sNueye9tfSkH9-5hOxBEbEDV>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Sep 2025 02:30:40 -0400 (EDT)
Date: Thu, 11 Sep 2025 08:30:38 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Wilfred Mallawa <wilfred.opensource@gmail.com>
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Keith Busch <kbusch@kernel.org>, Jesper Devantier <foss@defmacro.it>,
 Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: Re: [PATCH v6 5/5] hw/nvme: connect SPDM over NVMe Security Send/Recv
Message-ID: <aMJsjobzyBEuny43@AALNPWKJENSEN.aal.scsc.local>
References: <20250911060031.124683-1-wilfred.opensource@gmail.com>
 <20250911060031.124683-6-wilfred.opensource@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="PNNOtTsCIve9T+7G"
Content-Disposition: inline
In-Reply-To: <20250911060031.124683-6-wilfred.opensource@gmail.com>
Received-SPF: pass client-ip=103.168.172.145; envelope-from=its@irrelevant.dk;
 helo=fout-a2-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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


--PNNOtTsCIve9T+7G
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sep 11 16:00, Wilfred Mallawa wrote:
> From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
>=20
> This patch extends the existing support we have for NVMe with only DoE
> to also add support to SPDM over the NVMe Security Send/Recv commands.
>=20
> With the new definition of the `spdm-trans` argument, users can specify
> `spdm_trans=3Dnvme` or `spdm_trans=3Ddoe`. This allows us to select the S=
PDM
> transport respectively. SPDM over the NVMe Security Send/Recv commands
> are defined in the DMTF DSP0286.
>=20
> Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

LGTM. One small nit below that I can fix when merging if another
revision is not rolled.

Reviewed-by: Klaus Jensen <k.jensen@samsung.com>

> ---
>  docs/specs/spdm.rst         | 10 ++++++--
>  hw/nvme/ctrl.c              | 46 ++++++++++++++++++++++++++++---------
>  include/hw/pci/pci_device.h |  2 ++
>  3 files changed, 45 insertions(+), 13 deletions(-)
>=20
> diff --git a/docs/specs/spdm.rst b/docs/specs/spdm.rst
> index f7de080ff0..dd6cfbbd68 100644
> --- a/docs/specs/spdm.rst
> +++ b/docs/specs/spdm.rst
> @@ -98,7 +98,7 @@ Then you can add this to your QEMU command line:
>  .. code-block:: shell
> =20
>      -drive file=3Dblknvme,if=3Dnone,id=3Dmynvme,format=3Draw \
> -        -device nvme,drive=3Dmynvme,serial=3Ddeadbeef,spdm_port=3D2323
> +        -device nvme,drive=3Dmynvme,serial=3Ddeadbeef,spdm_port=3D2323,s=
pdm_trans=3Ddoe
> =20
>  At which point QEMU will try to connect to the SPDM server.
> =20
> @@ -113,7 +113,13 @@ of the default. So the entire QEMU command might loo=
k like this
>          -append "root=3D/dev/vda console=3DttyS0" \
>          -net none -nographic \
>          -drive file=3Dblknvme,if=3Dnone,id=3Dmynvme,format=3Draw \
> -        -device nvme,drive=3Dmynvme,serial=3Ddeadbeef,spdm_port=3D2323
> +        -device nvme,drive=3Dmynvme,serial=3Ddeadbeef,spdm_port=3D2323,s=
pdm_trans=3Ddoe
> +
> +The `spdm_trans` argument defines the underlying transport type that is =
emulated
> +by QEMU. For an PCIe NVMe controller, both "doe" and "nvme" are supporte=
d. Where,
> +"doe" does SPDM transport over the PCIe extended capability Data Object =
Exchange
> +(DOE), and "nvme" uses the NVMe Admin Security Send/Receive commands to
> +implement the SPDM transport.
> =20
>  .. _DMTF:
>     https://www.dmtf.org/standards/SPDM
> diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> index ad52e8f569..8a610f57f2 100644
> --- a/hw/nvme/ctrl.c
> +++ b/hw/nvme/ctrl.c
> @@ -8947,19 +8947,31 @@ static bool nvme_init_pci(NvmeCtrl *n, PCIDevice =
*pci_dev, Error **errp)
> =20
>      pcie_cap_deverr_init(pci_dev);
> =20
> -    /* DOE Initialisation */
> +    /* SPDM Initialisation */
>      if (pci_dev->spdm_port) {
> -        uint16_t doe_offset =3D n->params.sriov_max_vfs ?
> -                                  PCI_CONFIG_SPACE_SIZE + PCI_ARI_SIZEOF
> -                                  : PCI_CONFIG_SPACE_SIZE;
> +        switch  (pci_dev->spdm_trans) {
> +        case SPDM_SOCKET_TRANSPORT_TYPE_PCI_DOE:
> +            uint16_t doe_offset =3D n->params.sriov_max_vfs ?
> +                                    PCI_CONFIG_SPACE_SIZE + PCI_ARI_SIZE=
OF
> +                                    : PCI_CONFIG_SPACE_SIZE;
> =20
> -        pcie_doe_init(pci_dev, &pci_dev->doe_spdm, doe_offset,
> -                      doe_spdm_prot, true, 0);
> +            pcie_doe_init(pci_dev, &pci_dev->doe_spdm, doe_offset,
> +                          doe_spdm_prot, true, 0);
> =20
> -        pci_dev->doe_spdm.spdm_socket =3D spdm_socket_connect(pci_dev->s=
pdm_port,
> -                                                            errp);
> +            pci_dev->doe_spdm.spdm_socket =3D
> +                spdm_socket_connect(pci_dev->spdm_port, errp);
> =20
> -        if (pci_dev->doe_spdm.spdm_socket < 0) {
> +            if (pci_dev->doe_spdm.spdm_socket < 0) {
> +                return false;
> +            }
> +            break;
> +        case SPDM_SOCKET_TRANSPORT_TYPE_NVME:
> +            n->spdm_socket =3D spdm_socket_connect(pci_dev->spdm_port, e=
rrp);
> +            if (n->spdm_socket < 0) {
> +                return false;
> +            }
> +            break;
> +        default:
>              return false;
>          }
>      }
> @@ -9250,11 +9262,17 @@ static void nvme_exit(PCIDevice *pci_dev)
>          g_free(n->cmb.buf);
>      }
> =20
> +    /* Only one of the `spdm_socket` below would have been setup */
>      if (pci_dev->doe_spdm.spdm_socket > 0) {
>          spdm_socket_close(pci_dev->doe_spdm.spdm_socket,
>                            SPDM_SOCKET_TRANSPORT_TYPE_PCI_DOE);
>      }
> =20
> +    if (n->spdm_socket >=3D 0) {
> +        spdm_socket_close(pci_dev->doe_spdm.spdm_socket,
> +                          SPDM_SOCKET_TRANSPORT_TYPE_NVME);
> +    }
> +

Might as well assert the above condition or at least use an else if
here.


--PNNOtTsCIve9T+7G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmjCbI0ACgkQTeGvMW1P
DenVAQgAvZrPTD8NUh/k2zGLkijD3AA3vmB04sTUAmYs6tcdyzF6Eir2U2gFArce
vwjnSKugiaQ8cIiMET0tgypXKSHOdP8f/iXGV7TE9f1iTeExIfW8d0ERjISWEvzh
Vp8Agnt+6mbn72h+EZEiB8Qy7fOtfVKVFMXLJxkGFEI6ZoFcAb6Iu9zr8Yf9rRuw
k2X7SYcLjboGVOPwV7PVNfQbSKn4A8kPkwRtqNShpEDVa/ufV+8e3IPcnyeLuFql
Rr7elobawFbdkeHNKxB1KagaADPn7ulEdGexvdsUTB+pGQHIXF8y5XT+QUm8c4si
gAXsGbBcIvxoJLe3yIYXsYBhC3Z05A==
=4tUi
-----END PGP SIGNATURE-----

--PNNOtTsCIve9T+7G--

