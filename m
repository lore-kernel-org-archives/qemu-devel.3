Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D3E1C3DA5E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 10:10:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTIec-0007Z6-N7; Mon, 15 Jul 2024 06:09:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1sTIea-0007P9-E6; Mon, 15 Jul 2024 06:09:56 -0400
Received: from fhigh4-smtp.messagingengine.com ([103.168.172.155])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1sTIeY-0002Rq-Jp; Mon, 15 Jul 2024 06:09:56 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id BAC8A1148214;
 Mon, 15 Jul 2024 06:09:51 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute2.internal (MEProxy); Mon, 15 Jul 2024 06:09:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1721038191; x=
 1721124591; bh=r8g8dnpIYHazBKcmOs+/TuknMd+s5Dc72lJYAQ096HA=; b=q
 x8saAPndrKpkuvyFFSuq8ztCWcjdQTS4KfbuxHXVeGkgopcwU95M6+EMq/Qv067R
 AuWkGDq0BumnxK7mHfnGK4j4yckzPr6UbV+cQ/QLnPUmzZfUn0aOrDJVhl8Zb01M
 Q6tGXbEujSNQ0ilja+FVWMPsKjLmyXY0rOtmnaasgYWkrj/4T/mi31Aw9Uw1Unrx
 YpmKXJTl04cNtM1LyPdWw4TCIiyTkU9mE/5vt5OQlzznR97pWKzKwqX6q0mIbdX3
 SlcYPu6PGasYeXOr1RqzMzDERGRJ7DMljREJBOQJS6QPQMtCt9kj1uB9DemKZpev
 /7nqVr8hGV+eB8nhErldg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; t=1721038191; x=1721124591; bh=r8g8dnpIYHazBKcmOs+/TuknMd+s
 5Dc72lJYAQ096HA=; b=ObsMNNIJU/zEywmNc6QPcfH2pAcOezz6SvHGyWsksNG0
 af24T+gtbbSlWYPvqhuDRkkUM61gtgVdsWLx++mCHsi9QZJm44F46qvzkNN24i1X
 afBWCO1cqId636LhhmKzxklKGkHvSeycbr3x6eCpp+WtgaLrsh9MKI10/fLvRHkd
 Yy+lwlv+9vgng9AaB7XohoIaHZ2UjMqjpPnbzs3bnUgJd0V/IQChNJYg6hmRgjrD
 a/atwhuEf8yNn8Zb6GeSRY48dOBJhm0lmfkmWOYtSKZZzKoBraekTRr8zyifcYpS
 OW8EWtSX5VZuLRmYwnbAbiDosiBPRBvPOgh932g+Jg==
X-ME-Sender: <xms:bPWUZmN1TEewhUOx7Ay404RwDJPAf7_Rdb9zlNXImGNKnxwuBhp-bg>
 <xme:bPWUZk8JP2ZLA_VJdMrz3DBLlm4Qqv9DbUfXCep4yaxWbeKV8vCxIcAxbFRO95IyH
 R5nSzKu03K-2laDdP0>
X-ME-Received: <xmr:bPWUZtRIaDlKtSccGsFWn8NVS5Gwh3MZKk__vCszwMPXsput7Ezs0M2h2COO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrgedvgddvgecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeejgfejfeffvdeuhfeifefhgffgueelhedukeevjeevtdduudegieegteffffej
 veenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehith
 hssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:bPWUZmvmKGOLww-jPu9C5mcUi0YKTrOfUo-o__zE7cAmYQxs_fwy5g>
 <xmx:bPWUZucBVmj3HcfX-zR5Oa8fwSqv3vuUjRGo3uo1Ch6N3RUVmvwQNw>
 <xmx:bPWUZq31LkYLWIw2bS9ErH1ffKhcdXqQBMEDzlwpm8dRJpS2_RZSVA>
 <xmx:bPWUZi-a0QbMertdTKSLFLvLY9m3529zd29MeUq2lrYMfWiduPNXiQ>
 <xmx:b_WUZhtoCkzmCjuW5mhBRAv1mb2pMLnmT3VIkASeeQ3iQfc8qtMYwaGu>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Jul 2024 06:09:48 -0400 (EDT)
Date: Mon, 15 Jul 2024 12:09:42 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Changqi Lu <luchangqi.123@bytedance.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com,
 hreitz@redhat.com, stefanha@redhat.com, fam@euphon.net,
 ronniesahlberg@gmail.com, pbonzini@redhat.com, pl@dlhnet.de,
 kbusch@kernel.org, foss@defmacro.it, philmd@linaro.org,
 pizhenwei@bytedance.com, Klaus Jensen <k.jensen@samsung.com>
Subject: Re: [PATCH v9 09/10] hw/nvme: add reservation protocal command
Message-ID: <ZpT1ZnOjx48_6q0j@cormorant.local>
References: <20240712023650.45626-1-luchangqi.123@bytedance.com>
 <20240712023650.45626-10-luchangqi.123@bytedance.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7qvFABXngMpT+HL2"
Content-Disposition: inline
In-Reply-To: <20240712023650.45626-10-luchangqi.123@bytedance.com>
Received-SPF: pass client-ip=103.168.172.155; envelope-from=its@irrelevant.dk;
 helo=fhigh4-smtp.messagingengine.com
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


--7qvFABXngMpT+HL2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jul 12 10:36, Changqi Lu wrote:
> Add reservation acquire, reservation register,
> reservation release and reservation report commands
> in the nvme device layer.
>=20
> By introducing these commands, this enables the nvme
> device to perform reservation-related tasks, including
> querying keys, querying reservation status, registering
> reservation keys, initiating and releasing reservations,
> as well as clearing and preempting reservations held by
> other keys.
>=20
> These commands are crucial for management and control of
> shared storage resources in a persistent manner.
> Signed-off-by: Changqi Lu <luchangqi.123@bytedance.com>
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> Acked-by: Klaus Jensen <k.jensen@samsung.com>
> ---
>  hw/nvme/ctrl.c       | 318 +++++++++++++++++++++++++++++++++++++++++++
>  hw/nvme/nvme.h       |   4 +
>  include/block/nvme.h |  37 +++++
>  3 files changed, 359 insertions(+)
>=20

This looks good to me, but two comments.

  1. Do you have a small guide on how to get a simple test environment
     up for this?

  2. Can you touch on the justification for not supporting the remaining
     mandatory features required when indicating Reservation support?

     hw/nvme *does* compromise on mandatory features from time to time
     when it makes sense, so I'm not saying that not having the log
     pages, notifications and so on is a deal breaker, I'm just
     interested in the justification and/or motivation.

     For instance, I think the SPDK reserve test will fail on this due
     to lack of Host Identifier Feature support.

--7qvFABXngMpT+HL2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmaU9WUACgkQTeGvMW1P
Del4ywf/Sy85Aii/+sp+KVP3YzbhtjoZ95g6Wu06TlpE1gQXxcI6AvJdGj3e7iDy
7G0gsG2Lf9Eqb3UBoO5WNIx/DSH0jk3toq9xy6QZXrQ0GIzVZUbRsY4GHvs0paz7
mR8ilfpGjD9QJygy1Xygz//+cCCxgi6gQ8hO2XDVFHDynCchQAPvafa5Aa3xq4Sk
OXP/oHd16coyKwmarGZS/KVYJTHgKG/tMcyaVXP8q2YugnGjcWokAXEdF2/qqhqe
E5jnn5O5U7qw0oheneGuPGKGl72vBZxPOvlrw92MPztUdQDejImdw3y39XxjnzGs
UCAGAZqd4++f3x57+OxgYAYQYhEMDQ==
=g8j8
-----END PGP SIGNATURE-----

--7qvFABXngMpT+HL2--

