Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44FC7C53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 09:48:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woePZ-0007B2-Pl; Tue, 28 Jul 2026 05:47:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1woePV-0007AQ-8e; Tue, 28 Jul 2026 05:47:41 -0400
Received: from fhigh-a4-smtp.messagingengine.com ([103.168.172.155])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1woePT-000085-Hj; Tue, 28 Jul 2026 05:47:41 -0400
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 849FC14000BA;
 Tue, 28 Jul 2026 05:47:38 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-07.internal (MEProxy); Tue, 28 Jul 2026 05:47:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1785232058; x=
 1785318458; bh=Y56z1x3HHQfDZl4NQQM0iSCepnBN02JW+Wg5eYM7ptw=; b=G
 IWMqntBlnu+vQIqFHgkD2Hbe4j8+dyj4vS07N7hUVZBryQK2HyDsZPctQRuPN4QN
 fEkEy5nex+VG+30pCPm0j9Im8w2fkFhI05uH7+iSCpVYsX/XbLHyZZ6AcNTjtVO6
 LscEVYvNioBp2tRxs05jL8+PQKZYFB0M+wJNauwbVZkgaZ17YVzQ56eAR1bRiogm
 I5h9TJL5B8YoCjTkvYGk75YGBWd6M0F8Ubr0rixEhp+1lU5WUK4abQKGWe6oOXJj
 +E7JsRUN9QqN4Z67TWYByZ7EM6Fh/071bC5/wJ1x5EO2/CX1tVN/zWVhnXearJIv
 N2TCYj86FTPvzfwOqg0/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
 1785232058; x=1785318458; bh=Y56z1x3HHQfDZl4NQQM0iSCepnBN02JW+Wg
 5eYM7ptw=; b=at+9CtLAabw7276n7uZe0ZOsgzndbZnJhRARkkkWEHbE4huIlj0
 brmG1yJ5vyjnQc2qwL+OzdoXzjEQJrNDxJi2DyFwX4aYT15CsVVM+EmvjCRmXRKe
 PCnoArwrZfHeSJ1bun0g+GUAsoJPJg+LOeYJxWC546y4hXz4P929EAm12Ee+8SM0
 pgKJ5VCWmrsn7Ipwv8O6uqKd3GG8B0RjkuGKVGVbfRZI9EPmUWSvA2vNclDafLhW
 qdTxvMyNL+KacN1/pDw6ymKf1rshxN/jlzln035nu70CYlUgvIQktQkpFTuVYeQv
 XiebCy4obVFSATFSaJQD4O9bQ/iMxBadEbQ==
X-ME-Sender: <xms:uXpoagiF9MInaBF8DYDp_X1-ZEbAqLbAvtsyth3f9EUJJl5M8h2_Kw>
 <xme:uXpoak0_MwLvnfWPuFoR3UYzsgxb53DA47kjN0GH1miw9PHstQcOOkwr_oVLfD1Jd
 i657FVe9hfpo0YMdNtiHOKrNbgJaEBTubmR3E16nCoxaMzf8OC8urI>
X-ME-Received: <xmr:uXpoajdb_uO1MaossD1-QJPHiYLsnYFzjGmo9eMTr-UPwRNC5b6_PQzb2wEi>
X-ME-Proxy-Cause: dmFkZTGD+Cu5NN6TOJELr3+oeGQhRE1Z4W2W/lhPu4RsGM7t4Wl/hJWwEjkSfPMnD7kWaQ
 RnkMycqsMB52PWJHUQnfpX/rkzO+NKqPFIuxlfnOjkQ7q6NDGaAxgCSiPLCIk02yQsZqHu
 njlz4dxscuMmiiiJm+eB1b/zC8qTww9RrCV3DKlCOBHqWbd+IHHGsIeLZ54dQaZtjlFrjH
 oqrvroCwGV1Jj03BlNTZnjloHF+QmFBuGcrzA16dbBqEn5zSg1CFqULz0LX5gAFT1Wl7Ih
 9XaTgwlR1g8nEzqL1oxe7hIe8FQ28hN5FSl08qeqE19uL9aqbx4CCXtnyEyWJtUSVTjwcy
 UWGWMrkOkYjCif0YSojAsmoFM2i+ojqBg5+arMF05txCt9ricJwERdKFCFXq3U6kof3aK/
 aYGCDlo3dQ8rpMI1hOcxqsxHFMyY74lfrDDuEETiKpxyTnYZiq0fuWwTN+dpIUDYyyw1co
 lSvb0LxUoWVWOElLFhhLnCLwVjV1LhDXOrAKr/rs6ljBSUQWv4gyFuAl8QmeQ6bRn2V3BB
 eyrSMPFTBrMkc86jetKBFQPfY3ilbVugxbcg9f4UjWuuj8hfNDF2EgQa2W9Ac1UO6KU7sY
 /Jn6Ju0v5KKOkVp5cSxlVKae5eaew6O/H7Ks9zPjqI2vZBFZroHDfA5JSFJQ
X-ME-Proxy: <xmx:unpoaqx9opSADg3e3ivlCWKMYTYmHuQKwK_Dpyzb5C4dDUGfCaGNVA>
 <xmx:unpoarygMo8mzIlS03iVykybBuSJ8kdhgKDl9AOJ--7jKW5ShEsg7Q>
 <xmx:unpoarYpRtXoHoHnOgrEVdqnoLwO9T1ksb1iVhzpkU6J9yDL7INGmA>
 <xmx:unpoak1UuukKtpPNucQHvj265j-j_bNh3Cbv43dgp0RZ-PDQfYZw5g>
 <xmx:unpoarFwBdVWEwLm9EJ9-6S4HD4s70YErjr9IH1RgjGlesSxcR9iY-Tt>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Jul 2026 05:47:37 -0400 (EDT)
Date: Tue, 28 Jul 2026 11:47:36 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Keith Busch <kbusch@kernel.org>,
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org,
 Klaus Jensen <k.jensen@samsung.com>, qemu-stable@nongnu.org,
 Jihe Wang <wangjihe.mail@gmail.com>,
 boy juju <agx1657748706@gmail.com>, contact <contact@xchglabs.com>,
 david korczynski <david@adalogics.com>
Subject: Re: [PATCH] hw/nvme: fix cross-namespace copy dif buffer overflow
Message-ID: <amh6uJSuBxtnAzn1@AALNPWKJENSEN.aal.scsc.local>
References: <20260728-fix-cross-ns-pract-v1-1-20f66766337f@samsung.com>
 <f9c5f329-bee8-4454-bf53-8a94b24f0e5f@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="wzQBklGw6XHs+psV"
Content-Disposition: inline
In-Reply-To: <f9c5f329-bee8-4454-bf53-8a94b24f0e5f@oss.qualcomm.com>
Received-SPF: pass client-ip=103.168.172.155; envelope-from=its@irrelevant.dk;
 helo=fhigh-a4-smtp.messagingengine.com
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

--wzQBklGw6XHs+psV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jul 28 11:32, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Klaus,
>=20
> On 28/7/26 11:18, Klaus Jensen wrote:
> > From: Klaus Jensen <k.jensen@samsung.com>
> >=20
> > The NVMe specification allows a controller with multiple namespaces to
> > use different LBA formats per namespace. On implication of this is that
>=20
> Typo "One".
>=20
> > the destination namespace may have a metadata area for PI, but the
> > source does not. In that case, the controller shall generate the
> > protection information, but the bounce buffer is errornously allocated
>=20
> Typo "erroneously".
>=20

Thanks!

> > without space for that, causing a buffer overflow.
> >=20
> > Fix the allocation.
> >=20
> > Cc: qemu-stable@nongnu.org
> > Fixes: d522aef88d42 ("hw/nvme: add cross namespace copy support")
> > Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3387
> > Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3692
> > Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3841
> > Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3853
> > Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4031
> > Reported-by: Jihe Wang <wangjihe.mail@gmail.com>
> > Reported-by: boy juju <agx1657748706@gmail.com>
> > Reported-by: contact <contact@xchglabs.com>
> > Reported-by: david korczynski <david@adalogics.com>
> > Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> > ---
> >   hw/nvme/ctrl.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> > index a67e1598891c..409aeb9921c2 100644
> > --- a/hw/nvme/ctrl.c
> > +++ b/hw/nvme/ctrl.c
> > @@ -3332,7 +3332,8 @@ static void nvme_do_copy(NvmeCopyAIOCB *iocb)
> >       g_free(iocb->bounce);
> >       iocb->bounce =3D g_malloc_n(le16_to_cpu(sns->id_ns.mssrl),
> > -                              sns->lbasz + sns->lbaf.ms);
> > +                              sns->lbasz + (sns->lbaf.ms =3D=3D 0 ? dn=
s->lbaf.ms :
> > +                                            sns->lbaf.ms));
>=20
>   sns->lbasz + (sns->lbaf.ms ? : dns->lbaf.ms)
>=20
> Could MAX() be simpler?
>=20

That was my first fix. But the case we are covering is actually only
when the source namespace metadata size is zero. Otherwise, the formats
must match (which is checked earlier). But since you are pointing it
out, I think MAX is probably more clear. We won't accidentially
over-allocate because the formats are checked earlier.

> >       qemu_iovec_reset(&iocb->iov);
> >       qemu_iovec_add(&iocb->iov, iocb->bounce, len);
>=20
> Should we assert @len <=3D what we just allocated?
>=20

Sure, would be reasonable!

> >=20
> > ---
> > base-commit: 299e7557ed15a9a325620698add379a3ce2d1d95
> > change-id: 20260728-fix-cross-ns-pract-6934cc8205f2
> >=20
> > Best regards,
>=20
>=20

--wzQBklGw6XHs+psV
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmpoergACgkQTeGvMW1P
DemNMwf/ZmxWhajKMzjhVcP44jh4DXl+AjR6UgHYhh4fK6533sPfOjB+8lUam20J
Q4gN5szQ4AaBJHrU1DpOe1k8pAB3DfmrMQNFidXAVHhY0CcOjY0Y+ji+65PvjwFd
m2MFdOFTnqs2RiFq2h12j8PWSRasnDD4CgC8CRZBNUV1GI8oz+4509e3GPK8/qPO
CxqdLdvIbYd50w3lMpEaaQRKYeZe5KugqASGrtXrl8o1qDSzqH8hOKZUpxaQIs6R
XRc//JTJFKqubWzzIqrHtv1CPw7JYQvQV6Q+IvokSSJ+58qq2q5/Eqo5ppjNwRan
65kGSY6YRxwEePOQws+8no8L7BNaCQ==
=+uMv
-----END PGP SIGNATURE-----

--wzQBklGw6XHs+psV--

