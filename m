Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63530D13588
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 09:02:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5Ldm-0003R1-9y; Mon, 28 Oct 2024 05:02:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1t5LdO-0003G6-Ur; Mon, 28 Oct 2024 05:01:59 -0400
Received: from fhigh-a4-smtp.messagingengine.com ([103.168.172.155])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1t5LdM-0004kn-Kh; Mon, 28 Oct 2024 05:01:58 -0400
Received: from phl-compute-10.internal (phl-compute-10.phl.internal
 [10.202.2.50])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 801F911400EE;
 Mon, 28 Oct 2024 05:01:52 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-10.internal (MEProxy); Mon, 28 Oct 2024 05:01:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1730106112; x=
 1730192512; bh=Idf3Nj/bO1IyFzKv+FUd0O2tGj5dP9t7iccKDcM7npM=; b=C
 wbnXR2C9jSY41sqZHgIJu7DcH+4GGw8Sk5xdc0/ThypjSx3asKhwAJ04Bo/EnTKD
 LPVxhJrbrzU8j1AMjOUm7FaQKK+sQdJi36n/PJN6QuY6zChBU2d3lV2oPW7LlvTF
 AtyZiFAt6pHDPFAh2XPXHQMRxz0P5MjcYPX8L8WFH5Cr5ITE4pn88ZEWfoMF8jg6
 M7NM07HVgG5TpnJcvikQqc9AF4GXgN9g7PcWn6raWq5tPbfFHOjnKHae31z3ciZG
 jB7NcqEP/PRqMIp3Hn2tuxuSwsWHyyu/mJpDfMqzqbGWJ7V/yLhqXCkIhSarXvIi
 ndWDVT3Vs3If6SZwWAY7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; t=1730106112; x=1730192512; bh=Idf3Nj/bO1IyFzKv+FUd0O2tGj5d
 P9t7iccKDcM7npM=; b=fzw5/5RVs0Kw9sspurc9V49Eu+WrQFScPrrLMW6kIZz6
 3A+N5WgND5TqUVowBmk5U0Fp4hGZedAWpwiifBWatThMOhvgKmSzw97WeZzBn0dG
 1CSYuihrC9E3orkLmyx25eJ5Xpb3QenBBPv/I60g3FiIfLhVsu+n9/wccOjgTpns
 6BdD+xIFlzfFQ6QuARZxfmKnl4loL1YxBm4r+/Jgsm7ekchjbOTi6UFPyaIzih5X
 571GlEEbUV3+/MpEwFyGrfwJeZIieH8ncHXRwRp6QfXHbFUu448fq2GFemDqmmO9
 7AmvIFyula4EVpytUWf5GEd8YA/63oD/7T8GKA03+Q==
X-ME-Sender: <xms:_1IfZ0rlqzblbpffYC-7A_-LA8f2EAJ8oQyVSeNmVPTT1R82q-4l7Q>
 <xme:_1IfZ6o4X4tqI1Vito4-wJKR0Vi5brEJb8kS62-yFVUA2o4sEa4k-oZOV66BW2vKC
 INfFBdPskjEbCRrPdg>
X-ME-Received: <xmr:_1IfZ5M0jIQiRyxB_uqKSqtV9FGImd-0thSDaryibi3wMO-KYsi69e3mGtCX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejjedguddvkecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttdej
 necuhfhrohhmpefmlhgruhhsucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnth
 drughkqeenucggtffrrghtthgvrhhnpeejgfejfeffvdeuhfeifefhgffgueelhedukeev
 jeevtdduudegieegteffffejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
 epmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughkpdhnsggprhgtphht
 thhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehksghushgthheskhgvrh
 hnvghlrdhorhhgpdhrtghpthhtohepfhhoshhsseguvghfmhgrtghrohdrihhtpdhrtghp
 thhtohepqhgvmhhuqdgslhhotghksehnohhnghhnuhdrohhrghdprhgtphhtthhopehqvg
 hmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpdhrtghpthhtohepkhdrjhgvnhhsvghn
 sehsrghmshhunhhgrdgtohhmpdhrtghpthhtohepqhgvmhhuqdhsthgrsghlvgesnhhonh
 hgnhhurdhorhhgpdhrtghpthhtohepjhifkhhoiigrtgiiuhhksehgmhgrihhlrdgtohhm
 pdhrtghpthhtohepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:_1IfZ77gVZ2URGJBq53EUw_Xof14gwm-Yze2LxcqLFZcr4VScxounA>
 <xmx:_1IfZz4p51R8ZPo8mBIYZA6llPJa6Qi1S003D88mq2rieqXyv54E8g>
 <xmx:_1IfZ7jfiB-vm6oG3r4oIplFvJAgmwM49Vw-uIr4C1wp-PLX8ZgkWA>
 <xmx:_1IfZ94ihKYsfcic4EXe0fqbS-fiBvwevaRhyvbPbKli915iegYODg>
 <xmx:AFMfZ9tnTerXx6cVvnqazJyOtKOKzboDbqU_aO3uaOJNp--OezFDrMie>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Oct 2024 05:01:51 -0400 (EDT)
Date: Mon, 28 Oct 2024 10:01:50 +0100
From: Klaus Jensen <its@irrelevant.dk>
To: Keith Busch <kbusch@kernel.org>
Cc: Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 qemu-stable@nongnu.org, Waldemar Kozaczuk <jwkozaczuk@gmail.com>
Subject: Re: [PATCH] hw/nvme: fix handling of over-committed queues
Message-ID: <Zx9S_tOkgB9MoY7J@AALNPWKJENSEN.aal.scsc.local>
References: <20241025-issue-2388-v1-1-16707e0d3342@samsung.com>
 <ZxvLQ5rSQtDAfE-H@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="4rmTWXwfm5UFA8lh"
Content-Disposition: inline
In-Reply-To: <ZxvLQ5rSQtDAfE-H@kbusch-mbp.dhcp.thefacebook.com>
Received-SPF: pass client-ip=103.168.172.155; envelope-from=its@irrelevant.dk;
 helo=fhigh-a4-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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


--4rmTWXwfm5UFA8lh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Oct 25 10:45, Keith Busch wrote:
> On Fri, Oct 25, 2024 at 12:50:45PM +0200, Klaus Jensen wrote:
> > @@ -1520,9 +1520,16 @@ static void nvme_post_cqes(void *opaque)
> >          nvme_inc_cq_tail(cq);
> >          nvme_sg_unmap(&req->sg);
> > +
> > +        if (QTAILQ_EMPTY(&sq->req_list) && !nvme_sq_empty(sq)) {
> > +            qemu_bh_schedule(sq->bh);
> > +        }
> > +
> >          QTAILQ_INSERT_TAIL(&sq->req_list, req, entry);
> >      }
>=20
> Shouldn't we schedule the bottom half after the req has been added to
> the list? I think everything the callback needs to be written prior to
> calling qemu_bh_schedule().
>=20

Not as far as I know. It is only queued up; it won't be executed
immediately. It might run next (ASAP) if we are already in a bottom
half, but not before whatever context we are in returns.

--4rmTWXwfm5UFA8lh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmcfUvsACgkQTeGvMW1P
DemzpwgAmKqdTeoViyfn55mhRNdrKIVcCDDc1xI9F10cFU5QxWKcsZFla5+VYGo1
83db4ZnhYllD2u3ujOk/SG2YMzxIAjIWNvEiHTht5mhS302BUhu8ntNWDhGzimOg
dsGFaNvutJ7yu0PBvwTq5sAQQlg1yY2lE/GZcGTfxejWcbGV3NxqXMsG7vuI7La7
udf1/MyOjgm5/W6pvQV3R1W33OTmbxkUWl7fKIKx/3zL3M4v2WX4+mYNUMIgkn+Y
U6i/QkPg/VDLlQLczowICzkoRORZLmcvdsbZKXPQBcJxU1DTJ7U7uUOyF1hzD24z
MaxI/OaiIcS2i9oyRo18CwRCzSkAWw==
=dvxT
-----END PGP SIGNATURE-----

--4rmTWXwfm5UFA8lh--

