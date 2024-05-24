Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C27B3C25B74
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 07:11:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAP49-0000Nr-Of; Fri, 24 May 2024 03:10:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1sAP43-0000Mz-00; Fri, 24 May 2024 03:10:07 -0400
Received: from fhigh8-smtp.messagingengine.com ([103.168.172.159])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1sAP3z-0004Hq-2Z; Fri, 24 May 2024 03:10:05 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id D0B2B11401CE;
 Fri, 24 May 2024 03:09:59 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute7.internal (MEProxy); Fri, 24 May 2024 03:09:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1716534599; x=
 1716620999; bh=oG4GLfL95NbVm+FN0baXdrCOCbZDvsAKl3l6HpxZu24=; b=c
 19I8sMHFYdR3ISOkFLn+rx65AzGOo5QBsOrDu9gRd6OBiWkgTC2IuxgZVgvIi7kZ
 KdYvZF8i4P0fAYFvr3AxgwNWqz/6fVZuvvg9zXdOva92dCpKBJG4MqWHoU8M0sjW
 1oZ/9EulFKvdJWJ6I6Gko4X7Du0E5tv4jQY4PemMyOfb93M0tBvHlkEAKH6krnhn
 oTj+VU2tTZazHTnxogoo10e8ye19Zi2nSRmVVd5g6dVWN2Ig2VWTXF4E46mP6IqZ
 huSIg7+hVuWqmiIqpMksAKnJPxCuY0ftaDRkdev06U7RCTRlB5rm+IwVuziIMys1
 OYkjz3CToe15XfPP40sHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; t=1716534599; x=1716620999; bh=oG4GLfL95NbVm+FN0baXdrCOCbZD
 vsAKl3l6HpxZu24=; b=S/NoHTWEis2mdAWTqpSCU5hUBjaEPEP3jCFkmRwEGxjW
 edRuhhen6CTdt9J+k55oihCsrQNKNcPbzRCTQ44XeKOZA3U/9U3/Dy7oxuFrsEaP
 nehpK1+K7ybltGQygmfmesnA0zkts1qj6NkLu+75tquO/9BjrBSPf51/nWpsuBCp
 NxzdDehodeQ4lta0AMw4wNt2XMHWa1+UDI4PuFFZtpSq2iGntfkXvtKvqDoxOGWP
 2RpBgwUmf5JHKB6K0OuebELt86lErwqhbDduyXR3/3Sp7vczBcaFiwJ420q9l2lE
 DsN+TinhHFSBoPZ0jCBkGom2Q1X7j1apzjztnuGooA==
X-ME-Sender: <xms:Rj1QZqCjLEDn2Sz2Xcl4bTtlV08ybBjoI3gKYOGRdbR62yO4EWCtyg>
 <xme:Rj1QZkiHeU2INH1qTf-fe5aRhvi4-hzW_KnHYGbxnhwkLIS7xYS4HmopziN7hnJf_
 aW0-61Z0c06eVivBG4>
X-ME-Received: <xmr:Rj1QZtmhCUoaVRRaC67toW7isHrrDb_ALSqyjza4R2M3eKOEfdkc8W-wJg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeijedgudduhecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefmlhgr
 uhhsucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrg
 htthgvrhhnpeejgfejfeffvdeuhfeifefhgffgueelhedukeevjeevtdduudegieegteff
 ffejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
 hithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:Rj1QZoxLctS0WhmeF4F0j9l2Nz1GcnYeZHV-HitFjZ98aIYtLshkkw>
 <xmx:Rj1QZvS23W3mLaW5m8OWFK3MKMFl-kwD1FJ4oxXYWHYXe3Qb_0v4IA>
 <xmx:Rj1QZja6nLsSXtFMzfv4V-bI5kXEtjiLm8HD6QXbNEBockb2ZY2UjQ>
 <xmx:Rj1QZoRebaHje74WeKLkBn5Tnk7l_aMQ_uzeHCEgMd6evciE-rsQag>
 <xmx:Rz1QZgjsEodMFPQtOkPm6tQ6feZ--2DZiqz53eqFEO521vQZPFQbl_GX>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 May 2024 03:09:57 -0400 (EDT)
Date: Fri, 24 May 2024 09:09:51 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Changqi Lu <luchangqi.123@bytedance.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com,
 hreitz@redhat.com, stefanha@redhat.com, fam@euphon.net,
 ronniesahlberg@gmail.com, pbonzini@redhat.com, pl@dlhnet.de,
 kbusch@kernel.org, foss@defmacro.it, philmd@linaro.org,
 pizhenwei@bytedance.com
Subject: Re: [PATCH v3 09/11] hw/nvme: enable namespace rescap function
Message-ID: <ZlA9P4d7eWJPVAIx@cormorant.local>
References: <20240517095218.3107672-1-luchangqi.123@bytedance.com>
 <20240517095218.3107672-10-luchangqi.123@bytedance.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="c3wzNT5v+FD3lVAf"
Content-Disposition: inline
In-Reply-To: <20240517095218.3107672-10-luchangqi.123@bytedance.com>
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


--c3wzNT5v+FD3lVAf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On May 17 17:52, Changqi Lu wrote:
> This commit enables the rescap function in the
> namespace by detecting the supported reservation
> function in the backend driver.
>=20
> Signed-off-by: Changqi Lu <luchangqi.123@bytedance.com>
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> ---
>  hw/nvme/ns.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/hw/nvme/ns.c b/hw/nvme/ns.c
> index ea8db175db..bb09117f4b 100644
> --- a/hw/nvme/ns.c
> +++ b/hw/nvme/ns.c
> @@ -20,6 +20,7 @@
>  #include "qemu/bitops.h"
>  #include "sysemu/sysemu.h"
>  #include "sysemu/block-backend.h"
> +#include "block/block_int.h"
> =20
>  #include "nvme.h"
>  #include "trace.h"
> @@ -55,6 +56,13 @@ void nvme_ns_init_format(NvmeNamespace *ns)
>      }
> =20
>      id_ns->npda =3D id_ns->npdg =3D npdg - 1;
> +
> +    /*
> +     * The persistent reservation capacities of block
> +     * and nvme are currently defined the same.
> +     * If there are subsequent changes, this part needs to be changed.
> +     */
> +    id_ns->rescap =3D blk_bs(ns->blkconf.blk)->file->bs->bl.pr_cap;
>  }
> =20
>  static int nvme_ns_init(NvmeNamespace *ns, Error **errp)
> --=20
> 2.20.1
>=20

This should probably be merged with path 10. I don't think it make sense
on it's own?

--c3wzNT5v+FD3lVAf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmZQPT4ACgkQTeGvMW1P
DemCiAgAwfSyEwp7PxiCHP/nerQcTGBtbl8jHo/ebqupAarGnBuM6XGNrZRZHcmW
45yKlmlTwaqxHXCSZcS1LPPX4ZjlaD4nfkO5xUksqXV/7sKub5MA/NfTqtbaK1XD
M6H/EuPYqcK2zJXZSUQ125lt0rb9cnaEedty2SdzEfEa9qeITOA+XdgtDeof+0W/
YoDJPfnPC/e+rN6/PL4o9XpsguAuEWuTv+24bweJeyPSJdWmjY6FKZCuxlQLe0cL
mT+TTve21DNqZTe+3jQfWcPug5XTFGnLKgh3+hxM/u7CFpBpM8z0DJwxRe2uGTNc
5nqLGp7obsuDaVmGEFZQV9xA9qeKjA==
=XxmU
-----END PGP SIGNATURE-----

--c3wzNT5v+FD3lVAf--

