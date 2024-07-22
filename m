Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD93DC3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 11:53:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVrbG-00055q-Il; Mon, 22 Jul 2024 07:53:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1sVrbB-0004dE-7E; Mon, 22 Jul 2024 07:53:02 -0400
Received: from fhigh5-smtp.messagingengine.com ([103.168.172.156])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1sVrb7-0004k2-P6; Mon, 22 Jul 2024 07:52:59 -0400
Received: from compute8.internal (compute8.nyi.internal [10.202.2.227])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id 9554E1140262;
 Mon, 22 Jul 2024 07:52:54 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute8.internal (MEProxy); Mon, 22 Jul 2024 07:52:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1721649174; x=
 1721735574; bh=CsMY6DupU2I3Hftmh8Jukg7Ul9L/fAVm9/u51aOEFP8=; b=w
 I9jAdXMNyJxfUfNDytVLYD1ncs12w//05VE6rbB6flVHfRhRqfAOhz+bjVI3uQo6
 QgdHf7c52mN9Da/HU4/KZj8XRFiaMnjGY3kJ8fecULThPhQ2UTRKSRblX+lj688H
 r1ZmFALN2w58j6cXFU+MvHqChIeh+nZpY52mX7gQXtecV+lyuusfVz8kzAcitAMx
 igdfVGupb6GOOWn5gdC8O/5LjeRAlA2ajAmthma9VZ1fRZgWgo4ebyFBTpWAgExA
 PZdCjSJiUCJwNW3SCjFaj5CCMN52anq+HCoom4gyy3vX5JQXbXTYb1o50LIJKEXn
 57npmWWnPumIUu8akP87Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; t=1721649174; x=1721735574; bh=CsMY6DupU2I3Hftmh8Jukg7Ul9L/
 fAVm9/u51aOEFP8=; b=HAnMWegeqVKIkUCkBCvuxtGzDcxQbhP3sR1VohW4+Llg
 kEg+I8KZWcw7OCkpj8UkFzg8bH1r4jkPqN1RlMhlHUMXxr6BiV+2CiZ1kKF63Z7T
 p+vQjX0RXU57kLUzz2voUuGZcEwELOAskeIxSz/GCRUDyCKTdlY/g15vYe7HDANI
 3dwEG/Dnu3ccbDVXMYX8jQP+SdX+B0QbGyoAh0fXqG/ZDclMD27aqYwRKgz8jOOt
 jD0ZbdHODzSAPJ0oL02nWR+pQ6KoOdjzda6r4ruJcL8o1i5jU7Lq994dLgxtAaxG
 ewGpzUYJ5SsNFnB5Kpua45hEckwMKQS8UDZ9RAm3Pw==
X-ME-Sender: <xms:FUieZuXyvNJaSj_FHpmj9oU5ousX324dAUXdmv4NgfzfUwxidRNhyA>
 <xme:FUieZqlFv0XRIGsyCH8k4tXcSE5BczG5RoNye-7RvPZ4PSg8NCG4Jf5b7pB7ApOQ5
 npq0YINHYgn9-SOX58>
X-ME-Received: <xmr:FUieZibXMkgDiMW0oyPfvfUsLGDF1fysJ4HfKNaCfDxkvV5_Fya41J1ct5bCRQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrheejgdeghecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeejgfejfeffvdeuhfeifefhgffgueelhedukeevjeevtdduudegieegteffffej
 veenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehith
 hssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:FUieZlUr3foWXwd4WzJcEXdr8f1mRDg4It2FeOusxcUZbWVFR1umpw>
 <xmx:FUieZomVuWkeWhHHSXSkBHZDKOeU3_IfmUe0O6UrU9LOurTGeRcM8Q>
 <xmx:FUieZqddkOk0KEmrOB4Al2lnWzLAvAX0NCgb_TCDImwyRdejFYHb4g>
 <xmx:FUieZqF7LcFPhWaFK2nj44KrpeSjcaW_V6CGB6t98l_WLqRADbvNYg>
 <xmx:FkieZmbbEJcL_-H0iglWiD-WyGAnknL4JhqpIVBDNd3qASWdzaXKdbd6>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Jul 2024 07:52:52 -0400 (EDT)
Date: Mon, 22 Jul 2024 13:52:47 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Yao Xingtao <yaoxt.fnst@fujitsu.com>
Cc: qemu-devel@nongnu.org, Keith Busch <kbusch@kernel.org>,
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org
Subject: Re: [PATCH 2/2] nvme/ctrl: remove useless type cast
Message-ID: <Zp5IDzX686apM6mH@cormorant.local>
References: <20240722091728.4334-1-yaoxt.fnst@fujitsu.com>
 <20240722091728.4334-3-yaoxt.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="iwhrNwcgxRrZXwRu"
Content-Disposition: inline
In-Reply-To: <20240722091728.4334-3-yaoxt.fnst@fujitsu.com>
Received-SPF: pass client-ip=103.168.172.156; envelope-from=its@irrelevant.dk;
 helo=fhigh5-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--iwhrNwcgxRrZXwRu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jul 22 05:17, Yao Xingtao wrote:
> The type of req->cmd is NvmeCmd, cast the pointer of this type to
> NvmeCmd* is useless.
>=20
> Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>
> ---
>  hw/nvme/ctrl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> index 5b1b0cabcfc3..221818f551cd 100644
> --- a/hw/nvme/ctrl.c
> +++ b/hw/nvme/ctrl.c
> @@ -4167,7 +4167,7 @@ static bool nvme_zone_matches_filter(uint32_t zafs,=
 NvmeZone *zl)
> =20
>  static uint16_t nvme_zone_mgmt_recv(NvmeCtrl *n, NvmeRequest *req)
>  {
> -    NvmeCmd *cmd =3D (NvmeCmd *)&req->cmd;
> +    NvmeCmd *cmd =3D &req->cmd;
>      NvmeNamespace *ns =3D req->ns;
>      /* cdw12 is zero-based number of dwords to return. Convert to bytes =
*/
>      uint32_t data_size =3D (le32_to_cpu(cmd->cdw12) + 1) << 2;
> --=20
> 2.41.0
>=20

Thanks! Queued on nvme-next!

Reviewed-by: Klaus Jensen <k.jensen@samsung.com>

--iwhrNwcgxRrZXwRu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmaeSA8ACgkQTeGvMW1P
DemOhQf+KuVdvH0MgXXEk5NhfnZVpzyiFxeUeV6wGHeqxj9hPiJVzTfW1LaP2StB
HoqR7FB/WBkGPfqarkZE6w0t3wgGQAxkjcFccqq9XkYEWrOw9Af2Gse9EizzuUzQ
HiVE8AmkDFMq/A5UQZk72355vYRHN3TrP9+y2ov8uPJCTjj3UrKwAbpFlGU6AaCx
xTwOAF9m6a16D+GKRqa+SiNPYqMGTjRaaLoaj/y/KWbplBgGV5sVHVo6IqSa4dIe
H2lEkNGkmxujTM54zJL7ZQ7+lLaul+VmODu+P+LaU35Hfh7nLTySgTQ9ROExYRjv
X2/p0Kn/GURK49fmAqZNPFAk52hcSQ==
=pCsK
-----END PGP SIGNATURE-----

--iwhrNwcgxRrZXwRu--

