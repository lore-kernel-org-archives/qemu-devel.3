Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 007EEC25B74
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 07:21:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAPEY-00009Y-C0; Fri, 24 May 2024 03:20:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1sAPEV-00008H-IN; Fri, 24 May 2024 03:20:55 -0400
Received: from fout2-smtp.messagingengine.com ([103.168.172.145])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1sAPET-0007AB-SM; Fri, 24 May 2024 03:20:55 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailfout.nyi.internal (Postfix) with ESMTP id 160B7138010C;
 Fri, 24 May 2024 03:20:52 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute6.internal (MEProxy); Fri, 24 May 2024 03:20:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1716535252; x=
 1716621652; bh=q9R3bvHeKxtWqmFsSUnBkzh64//GOE4hyQ6MxzZitLk=; b=i
 QgN3RakXWAX1SDhmM17pV5ibTtps3tcE/xmGfx+Et0+T1G4rshxFmXkFv9bQOoHH
 an5AUcrY8P+0aanwqFvujdzb5+edNjeidOpveiNM/fPLzQpJ9PMdKRPphhcOPEkE
 St6MCs2anK7sTFojQhGNYm12m2Ot8z/yxUhHZOMGICrNzwXmc5C+WSVJDSX1e7QH
 wwrKELNP9Yv4lqrfP4i7XQLZkQWakLnBboHMgXt61JbIBwiCic41lBBisFUuGrNb
 l7EqZHYb80LDzExP3j8GdgPK1RM7tvX9EBQMugKfpBGN307/fhKgMPhlIDqCVaMk
 sjqp+dLonBUnN9+NANeBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; t=1716535252; x=1716621652; bh=q9R3bvHeKxtWqmFsSUnBkzh64//G
 OE4hyQ6MxzZitLk=; b=gwioTA3yP6ayk5tPfp4cpFLTBTjvHtq0SGzr+GjmD6kL
 v6OlSOwvlgb8bcdMx5NeUQMSlVwsb4xvaUHZrNzI2aKcYJdu7xNJ/0n/DwOLdX6J
 Kl6EHpJR9K3ePKOjM0UNc/k3aL1pBRbz/ty79u2SMwAQW1PTAYiLUM6u/sSw6x11
 AzK1QiXzgx6mCjamSm9XS36ToOt4A9JXOMEzXWIUtpKW82EumiLCJejsq/Sjpifl
 xCL78e2v+OmwZuuazgDnCx5bJfSfJ8fcromm+HD+qBD8FJXUrxcBTatek06zmp2/
 tKUra9RnDiKVOnLdjO6vmKSWtRpczhflrw1lxtBkyw==
X-ME-Sender: <xms:0z9QZvm0BORIxWDPHUo9st0Cy0DCtb43bkLASpUf4MHjnF4e87vQow>
 <xme:0z9QZi3gGly9yoa6NvvYLPMNMtZBcYNcBF3EdwRoT65QzkpJ-F9_FwARaf13lAnM4
 rn6aTNqCysVfFGeScs>
X-ME-Received: <xmr:0z9QZlo5tgMdLxBvmQaOpjk-Jbh4APw6fmO_jHMvcn7tpRcdtByHqRCUOQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeijedguddujecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefmlhgr
 uhhsucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrg
 htthgvrhhnpeejgfejfeffvdeuhfeifefhgffgueelhedukeevjeevtdduudegieegteff
 ffejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
 hithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:0z9QZnmz-HtZj5FlOrWgE_5Y4_lFSNwW0WVjyuHSODF2kHXIhcHMsQ>
 <xmx:0z9QZt3k8te4MwzDcsjZob1OPJetnWq6BFGvHgP4S1xTqHai8QTBKw>
 <xmx:0z9QZmucrE6jWBxkRr4nIiJlLchWahjjqywEMYYXkqec6QRwXkCMyA>
 <xmx:0z9QZhVNSAOunhg-DzcFA-S-lWIN90zu1dWejMUY6wquPaIiYbE-Ug>
 <xmx:1D9QZs3Hvw52SE0RlcO_4QnOn9EWdFCBuB-HsAHk4SL_1D8yEBGJW4ku>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 May 2024 03:20:50 -0400 (EDT)
Date: Fri, 24 May 2024 09:20:45 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Changqi Lu <luchangqi.123@bytedance.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com,
 hreitz@redhat.com, stefanha@redhat.com, fam@euphon.net,
 ronniesahlberg@gmail.com, pbonzini@redhat.com, pl@dlhnet.de,
 kbusch@kernel.org, foss@defmacro.it, philmd@linaro.org,
 pizhenwei@bytedance.com
Subject: Re: [PATCH v3 09/11] hw/nvme: enable namespace rescap function
Message-ID: <ZlA_zY0RkPvkAcZV@cormorant.local>
References: <20240517095218.3107672-1-luchangqi.123@bytedance.com>
 <20240517095218.3107672-10-luchangqi.123@bytedance.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="0Mp9Y4V5VKrNvN1D"
Content-Disposition: inline
In-Reply-To: <20240517095218.3107672-10-luchangqi.123@bytedance.com>
Received-SPF: pass client-ip=103.168.172.145; envelope-from=its@irrelevant.dk;
 helo=fout2-smtp.messagingengine.com
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


--0Mp9Y4V5VKrNvN1D
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

This is very brittle. I see that you have an enum for both th eblock
layer and nvme. It is tricky to remember to update this if it changes in
the block layer.

>  }
> =20
>  static int nvme_ns_init(NvmeNamespace *ns, Error **errp)
> --=20
> 2.20.1
>=20

--=20
One of us - No more doubt, silence or taboo about mental illness.

--0Mp9Y4V5VKrNvN1D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmZQP80ACgkQTeGvMW1P
DelZ6wgAwwCfGwyq4r81pSx45KOAp7HFkwAAK/5eAAhSQVM+Ko0akUBBRrz2IqHs
ttriIBT4ApsEGZsAw0U18cjYjKQBMCMv1QF2YAzBf9Tr8YoB8YhlSCTJvw6erLYC
aJwAIo4rFpWCOKNqis4ee7Oej4cCD0Ywh7qc8HXKQvpqC4I7s9rAWldbQnHNBTNE
mPJNkoVUTqacwnK7X053pYDIOeTNl4sRAGy8hY3m2qqe16OT7nIiDL4azk+WtOTQ
/oqnHmFKVgLizR68NnrmA3RPAnWOYjVEpx6oeJjIpQJ/xqgaT1x9YC68zmr2z9+D
vm01ys8ncYJQYna0Sx5wX15ecHkksQ==
=eAxu
-----END PGP SIGNATURE-----

--0Mp9Y4V5VKrNvN1D--

