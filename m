Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9159C25B79
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 08:03:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAPtf-0001YA-8r; Fri, 24 May 2024 04:03:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1sAPtX-0001SB-RS; Fri, 24 May 2024 04:03:23 -0400
Received: from fout3-smtp.messagingengine.com ([103.168.172.146])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1sAPtU-0007Xj-30; Fri, 24 May 2024 04:03:18 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailfout.nyi.internal (Postfix) with ESMTP id 89E0613800CB;
 Fri, 24 May 2024 04:03:14 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute5.internal (MEProxy); Fri, 24 May 2024 04:03:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1716537794; x=
 1716624194; bh=mWhJpS7bXARoltxX/K+d4gGL85saP59F80fZBpKYTTw=; b=l
 brIU3j8xn7iyd3RtwOFNGaNGx8UceJfb6AC+6iMBytPorD44V7duiFSpqY63vXZ/
 YSCfTdItHh579iYUXARNVqX9ItQG7Q3bSwPB+TkAZmuRbmR66o4tMp6uj/S+Pc12
 Tp69seF0BxoT5oU27UNMZ3E0khO5ceFyaOE97Ah9c9aKqHrrDmBKmv6lZfbmvr/u
 U4OQEM7P6F2lTtKrbzms6F4ozdG+jSXRV4Aa8SQ9sRYe2I1nZBOwwQse18RVpjax
 optU6lFjhsNbPekWpyjew6P3rI+vszdeUUBpiOzXri6rc0GG4pigJSqhLyV7xoyT
 RncpC+yTFNf6tRHsfY4Sg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; t=1716537794; x=1716624194; bh=mWhJpS7bXARoltxX/K+d4gGL85sa
 P59F80fZBpKYTTw=; b=gQvHZQUO+nT0wLHDvthRPgjG7iZwLo5BMxbW6EOMFbuy
 WgaLKRfvpZchgFgpsJc3zxNrAL+OawnOkLYVSsigPzlSwaadfB5N9/z39mkcQt7X
 cfSfQ5brv/duc1zG7TRMO+PJx/fQcL8ASW3cBz6lkfVMF49hK0ySO5k1dlvBmVjR
 6RG2CeeL2m1IGWoDG15NGBWvqi3QtnRE4Sd1Yp0QolcYQtBLJW74ejnz1mw/GFI+
 R/rlRq2zHa0yg9ynCWcb9ya4Ea7aPjmVSe3Z3HKjC2gzRvHcg69AcGCITXeX/Rq4
 HLbxPi6821tQPtTPGcwejDRL6Zu+uPRcUjR7dG5mAA==
X-ME-Sender: <xms:wUlQZpkfZDOeKU-ZpEFqzkiX2UWfiA87vLOBJucnuFeeNMa-uM0kCQ>
 <xme:wUlQZk0GB-1878y8cTk0t7eIGIJb5ajb2onNPEmy1illoQ9C8DrMtiL7vTifzh7MO
 Vy3hpmEV3YkRJAtgqg>
X-ME-Received: <xmr:wUlQZvo0A8jdnVnOCr31FSntIH9PoyWJmiKIh86U7h0Qc-pJ0rOXjnRp7A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeijedguddvhecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefmlhgr
 uhhsucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrg
 htthgvrhhnpeejgfejfeffvdeuhfeifefhgffgueelhedukeevjeevtdduudegieegteff
 ffejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
 hithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:wklQZpmWUfKLlwWKQE58H25hXOMouBoYlBxKcV8XxZ3Xx1ENB8GNGw>
 <xmx:wklQZn1ZWjkPnMTuKxGhG2h-ncSySsr4yOKL5W4B-8H4ziLqgMzqCg>
 <xmx:wklQZosEAf6ps6vL54sn9qyevwFEbCVd1AWWLClf8PqnsCD5qwJ9Hw>
 <xmx:wklQZrViRT2wio5jZlX2jTNyo3EfN9MxSoyp-EVw6GSC4rV3av15qg>
 <xmx:wklQZsm9IuoeLMEGzRq9NXhvt0Us7ZR9KmRr3Z_CyNif5_bJeeSpDRkf>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 May 2024 04:03:13 -0400 (EDT)
Date: Fri, 24 May 2024 10:03:06 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Vincent Fu <vincentfu@gmail.com>
Cc: Klaus Jensen <k.jensen@samsung.com>, Keith Busch <kbusch@kernel.org>,
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH] hw/nvme: fix mo field in io mgnt send
Message-ID: <ZlBJutfzk9WiMO00@cormorant.local>
References: <20240506-fix-ioms-mo-v1-1-65c315531850@samsung.com>
 <888fce70-768e-474f-8526-fa05b41540c1@gmail.com>
 <50c45bde-738e-4c1d-bf1f-5345eff814b2@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="eC4xwY9wU81gbLdP"
Content-Disposition: inline
In-Reply-To: <50c45bde-738e-4c1d-bf1f-5345eff814b2@gmail.com>
Received-SPF: pass client-ip=103.168.172.146; envelope-from=its@irrelevant.dk;
 helo=fout3-smtp.messagingengine.com
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


--eC4xwY9wU81gbLdP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On May  8 09:36, Vincent Fu wrote:
> On 5/7/24 10:05, Vincent Fu wrote:
> > On 5/6/24 04:06, Klaus Jensen wrote:
> > > The Management Operation field of I/O Management Send is only 8 bits,
> > > not 16.
> > >=20
> > > Fixes: 73064edfb864 ("hw/nvme: flexible data placement emulation")
> > > Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> > > ---
> > > =C2=A0 hw/nvme/ctrl.c | 2 +-
> > > =C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)
> > >=20
> > > diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> > > index 9e7bbebc8bb0..ede5f281dd7c 100644
> > > --- a/hw/nvme/ctrl.c
> > > +++ b/hw/nvme/ctrl.c
> > > @@ -4387,7 +4387,7 @@ static uint16_t nvme_io_mgmt_send(NvmeCtrl *n,
> > > NvmeRequest *req)
> > > =C2=A0 {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NvmeCmd *cmd =3D &req->cmd;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t cdw10 =3D le32_to_cpu(cmd->cd=
w10);
> > > -=C2=A0=C2=A0=C2=A0 uint8_t mo =3D (cdw10 & 0xff);
> > > +=C2=A0=C2=A0=C2=A0 uint8_t mo =3D cdw10 & 0xf;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 switch (mo) {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case NVME_IOMS_MO_NOP:
> > >=20
> > > ---
> > > base-commit: 84b0eb1826f690aa8d51984644318ee6c810f5bf
> > > change-id: 20240506-fix-ioms-mo-97098c6c5396
> > >=20
> > > Best regards,
> >=20
> > Reviewed-by: Vincent Fu <vincent.fu@samsung.com>
>=20
> Klaus, upon taking a second look, the original code is correct. The propo=
sed
> change would only keep the least significant 4 bits of the MO field. The
> original code gives you the 8 bits needed.
>=20
> Let me withdraw my Reviewed-by.
>=20
> Vincent

That was embarrasing. Thanks for catching that Vincent :)

--eC4xwY9wU81gbLdP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmZQSbkACgkQTeGvMW1P
Dendugf9H29p9lM6n6dEjG5YJAItS/PZ2otRxnSrxAWNlbOirINcnCaziLd1yT2A
BzL1erUla657Cmm/hbEt98UpCISfUv172xSFvBmUYaGZ4Hx8LVzjssoXNqKGU6ds
h31Ywbew0oIovThjZg1T40LngFIHEbWQJj4AiSSlm4yuOQdOiKTi303V4GSDDDi8
HnIoyQrE+f8+k6JMowz+kqzPP+kou+bgNpnN3Yc9xCG31VQU810YQEdMjpd05+h6
cujcMLqrlIG2u0tHS7houFQIThYHmDqzzMwrnCYqczAkVzHQJK4wtmuXPS896XlB
hcfx8TZpXWRp67wUuTv3GJ/Qnvn4tw==
=dK9i
-----END PGP SIGNATURE-----

--eC4xwY9wU81gbLdP--

