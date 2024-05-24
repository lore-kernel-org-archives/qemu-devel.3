Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99FB0C25B74
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 07:11:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAP4x-0000jA-Qq; Fri, 24 May 2024 03:11:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1sAP4w-0000gN-4A; Fri, 24 May 2024 03:11:02 -0400
Received: from fhigh8-smtp.messagingengine.com ([103.168.172.159])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1sAP4t-0004as-7g; Fri, 24 May 2024 03:11:00 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id E9CB511401D0;
 Fri, 24 May 2024 03:10:57 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute7.internal (MEProxy); Fri, 24 May 2024 03:10:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1716534657; x=
 1716621057; bh=WtSYHX3UlrqmBRBsvjJ47w/BH2ds2KqGDvloHt9eOtk=; b=R
 Lb0FD01S4crbEY9quQnwobsi+OqYkir77q3CwlX0M1syU6sy0pOb/FWvHyHZIo16
 blzQ4xsFYYcMaHRY8HQSJewvJIx3bmTYuRWlo3wCIlDDjAe1KYaNhozGcxECchxW
 r+vBCM0BONzF/bI2z1ub5ykibNfT3MJ8Nms2QE0UDqRIqKC1xV6vAYzX0d5E9sVy
 zNqO7mBGOLJ7UPpZaNwU5i1Eh6YZOKieQSIH1xz2elt+gawZgRUM8GWmqTXqUmeG
 Ei08YAXHheDwAtPtTPbrUkO1vcMMlqTFuPJiK2c8JIznM2UQmTQ3pmkrRL2Dqayc
 BcFJ/bZ1ilO/kOMgurwLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; t=1716534657; x=1716621057; bh=WtSYHX3UlrqmBRBsvjJ47w/BH2ds
 2KqGDvloHt9eOtk=; b=DXJMvjGm1UrCrmpgmuZ2OpZRnNhcUITLF8G7mXc2sUIz
 I1Qw/UCulh+Pby0tOxGwNZiuZXl3oDw9tCFT1t9a0Pdu2Lp9jcP7qEh4mdfXGLcI
 TeXq6v9ucj9YkO5ScO+bwaGL6EP14WMxYeZ746BTmuCjKf4jWs7dJItD7EsOXkzU
 vB2JiDuxjZdrUl/b3mkc3QGmeALpTn8NAlD4VfxdB3/pjhoiPUzLeHuw2DF7Jiat
 KHcobwIfZG+lpo4lyUQEjol4HuvsLi52dRkHusT6huyiqjiRvnlZqoOxCmCrdgMe
 RReJvXINl+0yKrcf5pdGYLj1KOPhO7ai0Nzk1huEBA==
X-ME-Sender: <xms:gT1QZjE4RMJxO16yLmmwM6ucLgtYKrYjLJg9veM7Bvtl_CjPwCOY2w>
 <xme:gT1QZgUPqpQ-fbC6FWxH3i0RLg72_Kh2AWWkle23mz2Y-OG7ibjYCkTF5fC3l5zZK
 56a34qgtaZ8E1Rd59I>
X-ME-Received: <xmr:gT1QZlI74zvhU2keOez1k9RdjWtG_9X0JVzOqKUZzavSjL5Jy1yEQyrycw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeijedgudduhecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefmlhgr
 uhhsucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrg
 htthgvrhhnpeejgfejfeffvdeuhfeifefhgffgueelhedukeevjeevtdduudegieegteff
 ffejveenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpe
 hithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:gT1QZhFah7fo1OTigcmuxVVMpxkbSE6Duzr19Y_m9o0B-1vjt0EMkA>
 <xmx:gT1QZpVjfMHzlsuU8ozRGeJGRNUzJldZNh0GXz2PBo9m7ttfkJLLAg>
 <xmx:gT1QZsPgsKdAV_6w8pYUse-YUosa-o5gbl6NHRlXipi8BzfuWb4cgw>
 <xmx:gT1QZo12oBAeL7447y1xAEqkrkA649Fz8gR7Mcc7x16qT76uQQNl5Q>
 <xmx:gT1QZqUfFcZcIzoTDATd7L7Cd3NVHKM8yV1mlkxBhG1o5-t7LHgLM8io>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 May 2024 03:10:56 -0400 (EDT)
Date: Fri, 24 May 2024 09:10:51 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Changqi Lu <luchangqi.123@bytedance.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com,
 hreitz@redhat.com, stefanha@redhat.com, fam@euphon.net,
 ronniesahlberg@gmail.com, pbonzini@redhat.com, pl@dlhnet.de,
 kbusch@kernel.org, foss@defmacro.it, philmd@linaro.org,
 pizhenwei@bytedance.com
Subject: Re: [PATCH v3 08/11] hw/nvme: enable ONCS reservations
Message-ID: <ZlA9e4FP7jRwVgjZ@cormorant.local>
References: <20240517095218.3107672-1-luchangqi.123@bytedance.com>
 <20240517095218.3107672-9-luchangqi.123@bytedance.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="bDELGuBROewlJSDF"
Content-Disposition: inline
In-Reply-To: <20240517095218.3107672-9-luchangqi.123@bytedance.com>
Received-SPF: pass client-ip=103.168.172.159; envelope-from=its@irrelevant.dk;
 helo=fhigh8-smtp.messagingengine.com
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


--bDELGuBROewlJSDF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On May 17 17:52, Changqi Lu wrote:
> This commit enables ONCS to support the reservation
> function at the controller level. It also lays the
> groundwork for detecting and enabling the reservation
> function on a per-namespace basis in RESCAP.
>=20
> Signed-off-by: Changqi Lu <luchangqi.123@bytedance.com>
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> ---
>  hw/nvme/ctrl.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> index 127c3d2383..182307a48b 100644
> --- a/hw/nvme/ctrl.c
> +++ b/hw/nvme/ctrl.c
> @@ -8248,7 +8248,8 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *=
pci_dev)
>      id->nn =3D cpu_to_le32(NVME_MAX_NAMESPACES);
>      id->oncs =3D cpu_to_le16(NVME_ONCS_WRITE_ZEROES | NVME_ONCS_TIMESTAM=
P |
>                             NVME_ONCS_FEATURES | NVME_ONCS_DSM |
> -                           NVME_ONCS_COMPARE | NVME_ONCS_COPY);
> +                           NVME_ONCS_COMPARE | NVME_ONCS_COPY |
> +                           NVME_ONCS_RESRVATIONS);
> =20
>      /*
>       * NOTE: If this device ever supports a command set that does NOT us=
e 0x0
> --=20
> 2.20.1
>=20

Should be merged with patch 10.

--bDELGuBROewlJSDF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmZQPXsACgkQTeGvMW1P
DemBnAf+N88+UnOJEZVDnP+WTjrUc3+E+F1lbIlpKM6i1I3KKfePinIYsMU6W8a+
XLW/flzcuDqLx1XUMBlpJGrKXj65E6Np2NBrPnn/k5XmFpd9P5EynEG8JXQiEbN+
Urpm9fOz7DEhImxx70mOBHVAR0krnP0DFU28ZplfWIHbKayDEZWwSRu0NZT/wCqm
o7A3SNgh9D+n1iOjApzEwvSl+3JOBULF0ZnJF+0ENnfuNErxc3rJt90CmXEOytYq
QYPkWdjA28T+KdI6adw8zsqLZnOBfB8htfACZE6Noc1kYoU/et2BY5UbP90ziXhl
RnB7Z1Gg1zr/JQ/MjEZACZT5ZYd86Q==
=tBwo
-----END PGP SIGNATURE-----

--bDELGuBROewlJSDF--

