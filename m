Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4F88C38150
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 07:38:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRRth-0004rv-K6; Wed, 10 Jul 2024 03:37:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1sRRte-0004f2-9G; Wed, 10 Jul 2024 03:37:50 -0400
Received: from fhigh8-smtp.messagingengine.com ([103.168.172.159])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1sRRtV-0004vD-Qn; Wed, 10 Jul 2024 03:37:50 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id A0C241141CBC;
 Wed, 10 Jul 2024 03:37:38 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute6.internal (MEProxy); Wed, 10 Jul 2024 03:37:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1720597058; x=
 1720683458; bh=S/6DE21zK2mwcnippoegGG9SNc9RYEYZ16BwtJN33A8=; b=I
 5fAA9vYiH6wDvmllcz5CVmhvyaORxPH4HMKYW00/6S/59vlZ8RkbuuO41tDeO1Z2
 1ATo4p2zFqYpGW9WxO3i1BKGZt5aoek528Qh7S7/aX9a34W8LwGtx72PqbWuXRvi
 LQoS9giOtnQQBrCvfIpC2+OFVYKNOuNbGX/y5W8iFcIGPxU3OWgLpQewNQauCzeX
 FylAJi3ktrRhcabaK2sojvdnAiNMO7ezwKsXI3BbVgtxt5OvwbfbeBVkJq3iD74v
 MIgxqmBXVSxeAR1SltQFzUTXqWFflLz2LKFTblP+7fsf/hq7h2vD4FXmtWWI9Rhz
 RAB27bytxrzf/eyEGqABA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; t=1720597058; x=1720683458; bh=S/6DE21zK2mwcnippoegGG9SNc9R
 YEYZ16BwtJN33A8=; b=EUQtzQOU1d7SeZas5x8LT2HyCHus72lHPwduvHKR/+ug
 IM43S8kNh/Bl9fGFOjUmcQt2VoyUDKmjbpWP/4fhFxfwfTkWPR8uAI8Ex59zf6yX
 ITwgAn9mbNifBO0REEDXMq+O4Q8cVUN2GRa4jcKZDZq55zEoETG5n8SFyAZzwS1s
 pUeciNgTd8ktmP606i9E0ODW+te2TIsr7mc3AzNSxyvSOaE/A/7+jBsYHUegKGPK
 UovFdr67j6BsKky7dR+Rctuc45mnM9fivjnuloIxjL80woWANDpgaqInjcHkFoFj
 huS6aVITCFWJhReBrrN+1GtEaOeltHDWNqVGOIQ26w==
X-ME-Sender: <xms:QDqOZqpA0fAv8Kf78rcal-YWazvtRrhqzw8BJce8Ets8tO6FQlGoBg>
 <xme:QDqOZopg39neO4f8bs6q2lw6_Kc0oDM_GgFvYHz-ps64ROjoH23Fp30MnExOdBMqr
 -jBhhBtCiW9boXJNMQ>
X-ME-Received: <xmr:QDqOZvNucBdtDqUwns2spaM1gIVVYgbgSIFK-YVP8-bNn4ggS9Faklnp4w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrfedtgdduvdefucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepmfhlrghu
 shculfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrth
 htvghrnhepjefgjeefffdvuefhieefhffggfeuleehudekveejvedtuddugeeigeetffff
 jeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepih
 htshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:QDqOZp77dEVqencB5Fr0O_bjXqcMcFq_mm6r4hDdLQu4lxh6o8CVYg>
 <xmx:QDqOZp7ayuLB_agrVcLDG4HRSlRlv2By-hj-TJd3JqN-sxy0Q_Bpgw>
 <xmx:QDqOZpilV9-VZ_UYJ0U7U9Y1NA1_8mjzBMk3F_8qylqAF2kydL3Ucg>
 <xmx:QDqOZj6j1cFPd34WjRyVWtQcfjpQNXuznW29ESsLdzEYLGUsWW7XiA>
 <xmx:QjqOZmskGICpT30ivbVTRIOqy6nnRWZBbjtsE2ptYM36srXa6w_n9oWD>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Jul 2024 03:37:36 -0400 (EDT)
Date: Wed, 10 Jul 2024 09:37:30 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Zheyu Ma <zheyuma97@gmail.com>
Cc: Keith Busch <kbusch@kernel.org>, Jesper Devantier <foss@defmacro.it>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH] hw/nvme: Fix memory leak in nvme_dsm
Message-ID: <Zo46OsRWrnDiIPTC@cormorant.local>
References: <20240702231303.3077584-1-zheyuma97@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="gh+SomYrTJE6CA2t"
Content-Disposition: inline
In-Reply-To: <20240702231303.3077584-1-zheyuma97@gmail.com>
Received-SPF: pass client-ip=103.168.172.159; envelope-from=its@irrelevant.dk;
 helo=fhigh8-smtp.messagingengine.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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


--gh+SomYrTJE6CA2t
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jul  3 01:13, Zheyu Ma wrote:
> The allocated memory to hold LBA ranges leaks in the nvme_dsm function. T=
his
> happens because the allocated memory for iocb->range is not freed in all
> error handling paths.
>=20
> Fix this by adding a free to ensure that the allocated memory is properly=
 freed.
>=20
> ASAN log:
> =3D=3D3075137=3D=3DERROR: LeakSanitizer: detected memory leaks
>=20
> Direct leak of 480 byte(s) in 6 object(s) allocated from:
>     #0 0x55f1f8a0eddd in malloc llvm/compiler-rt/lib/asan/asan_malloc_lin=
ux.cpp:129:3
>     #1 0x7f531e0f6738 in g_malloc (/lib/x86_64-linux-gnu/libglib-2.0.so.0=
+0x5e738)
>     #2 0x55f1faf1f091 in blk_aio_get block/block-backend.c:2583:12
>     #3 0x55f1f945c74b in nvme_dsm hw/nvme/ctrl.c:2609:30
>     #4 0x55f1f945831b in nvme_io_cmd hw/nvme/ctrl.c:4470:16
>     #5 0x55f1f94561b7 in nvme_process_sq hw/nvme/ctrl.c:7039:29
>=20
> Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
> ---
>  hw/nvme/ctrl.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> index 127c3d2383..cf610eab21 100644
> --- a/hw/nvme/ctrl.c
> +++ b/hw/nvme/ctrl.c
> @@ -2592,6 +2592,7 @@ next:
>  done:
>      iocb->aiocb =3D NULL;
>      iocb->common.cb(iocb->common.opaque, iocb->ret);
> +    g_free(iocb->range);
>      qemu_aio_unref(iocb);
>  }
> =20
> --=20
> 2.34.1
>=20

Thanks! LGTM

Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
Fixes: d7d1474fd85d ("hw/nvme: reimplement dsm to allow cancellation")
Cc: qemu-stable@nongnu.org

--gh+SomYrTJE6CA2t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmaOOjkACgkQTeGvMW1P
DemrnwgAjl7LowgyIjLIKfb88yV3B2tuiWtbibzSXLEBSXfPKIKJOpv0TF9WwLCO
nFZBHRMZF+2V2c06EMwa8JcGfamNLx4NW3Uw7ZsLz2/2wtBHToZlqgv4uB7aXe1J
GY+iKEmlGhpDjU5U2pqpciZ3le428TuqMhfpY/aw4Up3EqPCw9/saEUQWLMX1keR
uRY/wpxhBx53o7npz2WNDveQhbXwal1VLNjMJTrHEmTQ+aUzrLY8L/VkwDfOBtoQ
SBUyy0aN83XRygUWIqiSx0it/jC/nzlGd9xPjies4bUbpxxAYp+HfHEeEmmwI68o
H1it4Ob1sydouxok5PQVx2ngibbQGQ==
=jA4j
-----END PGP SIGNATURE-----

--gh+SomYrTJE6CA2t--

