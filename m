Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77B9FEC01CC
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 11:39:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4dcD-0002f1-Rd; Mon, 23 Mar 2026 07:38:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1w4dcA-0002e0-1V; Mon, 23 Mar 2026 07:38:34 -0400
Received: from fout-b8-smtp.messagingengine.com ([202.12.124.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1w4dc7-0000Un-OT; Mon, 23 Mar 2026 07:38:33 -0400
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
 by mailfout.stl.internal (Postfix) with ESMTP id DA1591D001BE;
 Mon, 23 Mar 2026 07:38:26 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-10.internal (MEProxy); Mon, 23 Mar 2026 07:38:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1774265906; x=
 1774352306; bh=o8sCfQlzy5s8jSBk3Ce+OSgnj/WKPr6lmYXCWzuGIBs=; b=U
 69GZFyWsPfb+nBK/SX2Sh3sh+8wWdbgzvqJ8qOIAKghwRCfLArMcuG3ZNLNnDTu3
 haOwwfQWj1BzT/+/tKuBIYJJIpmHttPNDA730dr8GJe4NjUR/f9Agpyv069WU8TR
 IlpOahrL+GOjHrdB6wB390Dtcn0UO/4uY4wdwRxGOGYto8uXf6zGVETNxwkIzinz
 tpcIZmwc1NOaw0drXVkvr9jCQcT4ruZ2mTAAAH4voqhkTNDID4wkpw6alfX4W4kR
 01qR+R+f4wwNsunfIiBESCu7gC8RCPHiaffvf+akv41/zqVnYC/ca/fGwZhQhgJ3
 AtA8Hoyth/bDmAAeFHT+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
 1774265906; x=1774352306; bh=o8sCfQlzy5s8jSBk3Ce+OSgnj/WKPr6lmYX
 CWzuGIBs=; b=x0zyhypLE5UH59jwM1DPTtdWJIwIuIcEO0ZpOAeDsnIJO2Bkw5z
 psspQ2O3boQmQ2HnV1YAetlaCxyHqrRN/8rnxUxbN+7vXUfq2tTmMzhpGSnZBGMz
 6nzB9cOYCRUrIO2nlMWJ9NIFMck4XvN7hKc4xWenUZ0el5SRS2yJAXWaOH4gmrM6
 BQXP3GF03oVHb3Ok/aijkMx5fAKbrtCoLV/JPDV+/JWo7Pn4SjvjfhXW7HC3io4k
 BXo7feJDaavCdYQADrLXI8VLwXYovW3cfPgvmpnNmKxZccYNGyEYlTgEy53esYiz
 bWlhlioIQ7m40gVr7wqpxZN2UrjwpXdxTAQ==
X-ME-Sender: <xms:MSbBaShGGtfKVAb07j5oqe7p8KUKpAh-tjRvM4b6YIWPP1Lxk3abOA>
 <xme:MSbBad_tRx0qXvI7LQAsUN7er7mhMXsTleOPXbG7EzPWnjvy1_R3ORXaFTKVOM5-1
 tlbS_59F4EvtWjVa5ozjRShNo1uPI1G0YPH7lipxpfrRJAZPTWOzs0>
X-ME-Received: <xmr:MSbBaZEY89Dg3JGhYuEFz9k70G1jBoI9zNsSTsjPxejfecHTNQ37hpGWyu16lQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefudekieduucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtdorre
 dttdejnecuhfhrohhmpefmlhgruhhsucflvghnshgvnhcuoehithhssehirhhrvghlvghv
 rghnthdrughkqeenucggtffrrghtthgvrhhnpeeufefgjeduveeifefhhfeikeeltdethe
 ehteeutdeuudefveeiheejieeltdegtdenucffohhmrghinhepghhithhlrggsrdgtohhm
 necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepihhtsh
 esihhrrhgvlhgvvhgrnhhtrdgukhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhht
 phhouhhtpdhrtghpthhtohepihhhrghniihhiihhsehgmhgrihhlrdgtohhmpdhrtghpth
 htohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdprhgtphhtthhopehksghu
 shgthheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepfhhoshhsseguvghfmhgrtghroh
 drihhtpdhrtghpthhtohepqhgvmhhuqdgslhhotghksehnohhnghhnuhdrohhrghdprhgt
 phhtthhopehihhgrnhiihhesohhuthhlohhokhdrtghomhdprhgtphhtthhopehithhsse
 hirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:MSbBaQnADcIsXNK1vMNF5Cm7MOIZl9qfPw_JnlwE_8WXw5xPIkG11w>
 <xmx:MSbBada18ruV0X44Q9hFnFA1bFII7U0pgCMhkhFYnDcZ8EPgWkvsvQ>
 <xmx:MSbBaVEerdloYRjQvbtHclVfZpiljHCGP1RIKg1DVAC5nWOWgC9C7g>
 <xmx:MSbBaeKCU7BKFeLDRPf6FIryWB3WFsvTelVwn9PR5R_OtWn7_Dvk0A>
 <xmx:MibBaX1uZ2l3cDZpb25mR6MI2EjNt5dGtK0rONg6A9vLQccPUfjOLtpN>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Mar 2026 07:38:25 -0400 (EDT)
Date: Mon, 23 Mar 2026 12:38:24 +0100
From: Klaus Jensen <its@irrelevant.dk>
To: Han Zhang <ihanzhzh@gmail.com>
Cc: qemu-devel@nongnu.org, kbusch@kernel.org, foss@defmacro.it,
 qemu-block@nongnu.org, Han Zhang <ihanzh@outlook.com>
Subject: Re: [PATCH] hw/nvme: remove unreachable default cases in
 nvme_directive_receive()
Message-ID: <acEmMFBXkcgGLtGo@AALNPWKJENSEN.aal.scsc.local>
References: <20260317010721.232247-1-ihanzh@outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="OhxHg5JLEyL9not+"
Content-Disposition: inline
In-Reply-To: <20260317010721.232247-1-ihanzh@outlook.com>
Received-SPF: pass client-ip=202.12.124.151; envelope-from=its@irrelevant.dk;
 helo=fout-b8-smtp.messagingengine.com
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


--OhxHg5JLEyL9not+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mar 17 09:07, Han Zhang wrote:
> Static analysis reported that the default cases in the switch
> statements handling dtype and doper in nvme_directive_receive()
> are unreachable.
>=20
> The values of dtype and doper are already validated earlier in the
> function, making the default branches redundant.
>=20
> Remove the unreachable cases to simplify the control flow.
>=20
> Reported-by: Ekaterina Zilotina
> Fixes: https://gitlab.com/qemu-project/qemu/-/issues/2472
> Signed-off-by: Han Zhang <ihanzh@outlook.com>
> ---
>  hw/nvme/ctrl.c | 24 ++++++------------------
>  1 file changed, 6 insertions(+), 18 deletions(-)
>=20
> diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> index cc4593cd42..36df6eeca2 100644
> --- a/hw/nvme/ctrl.c
> +++ b/hw/nvme/ctrl.c
> @@ -7550,25 +7550,13 @@ static uint16_t nvme_directive_receive(NvmeCtrl *=
n, NvmeRequest *req)
>          return NVME_INVALID_FIELD | NVME_DNR;
>      }
> =20
> -    switch (dtype) {
> -    case NVME_DIRECTIVE_IDENTIFY:
> -        switch (doper) {
> -        case NVME_DIRECTIVE_RETURN_PARAMS:
> -            if (ns->endgrp && ns->endgrp->fdp.enabled) {
> -                id.supported |=3D 1 << NVME_DIRECTIVE_DATA_PLACEMENT;
> -                id.enabled |=3D 1 << NVME_DIRECTIVE_DATA_PLACEMENT;
> -                id.persistent |=3D 1 << NVME_DIRECTIVE_DATA_PLACEMENT;
> -            }
> -
> -            return nvme_c2h(n, (uint8_t *)&id, trans_len, req);
> -
> -        default:
> -            return NVME_INVALID_FIELD | NVME_DNR;
> -        }
> -
> -    default:
> -        return NVME_INVALID_FIELD;
> +    if (ns->endgrp && ns->endgrp->fdp.enabled) {
> +        id.supported |=3D 1 << NVME_DIRECTIVE_DATA_PLACEMENT;
> +        id.enabled |=3D 1 << NVME_DIRECTIVE_DATA_PLACEMENT;
> +        id.persistent |=3D 1 << NVME_DIRECTIVE_DATA_PLACEMENT;
>      }
> +
> +    return nvme_c2h(n, (uint8_t *)&id, trans_len, req);
>  }
> =20
>  static uint16_t nvme_admin_cmd(NvmeCtrl *n, NvmeRequest *req)
> --=20
> 2.34.1
>=20
>=20

I'd rather keep the switches there and drop the early checks. The
switches are good documentation for what's going on. Removing them makes
the code a little "what, is this correct?".

If you update that, I'll be happy to grab this :)


Thanks,
Klaus

--OhxHg5JLEyL9not+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmnBJiwACgkQTeGvMW1P
DekJ2ggAjV48+QPD4E4fOag6cE6IsECtHHJ8GK+T1fcQGnyg/lMInGMj3wfRIaJk
RM1Jzq7kDC+N3LoAnFZK6MeFhBMyQhaZZkYOhAkgXOUfF+c0VAGldvMDPCYOOi9r
qWY3lpP0MtHAykP1k16Z8TeQhU+Q3QWwSTPrGMloLaXXTDtYAgUcjXETESMcXl4x
1UYubZdov0l1YcQ6jwQD2Z49j3EVEwXH4Rs5KYft2eXbstsWcF7lUbc0Z8gaIgU9
B3Zf+CcnkkuLmebLI+XF33oBBEzg5V9VhQz2rJ+cdnKnByKvXU/8Rs5gawq+915F
67xVm8ZA6nhfD1OO0S1zoRq8GD+Opg==
=yJ8I
-----END PGP SIGNATURE-----

--OhxHg5JLEyL9not+--

