Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FCB6D2AB33
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 12:34:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5lQS-00039G-Nm; Tue, 29 Oct 2024 08:34:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1t5lPv-0002up-Sw; Tue, 29 Oct 2024 08:33:47 -0400
Received: from fhigh-a5-smtp.messagingengine.com ([103.168.172.156])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1t5lPr-0001Hu-3w; Tue, 29 Oct 2024 08:33:46 -0400
Received: from phl-compute-09.internal (phl-compute-09.phl.internal
 [10.202.2.49])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 37D8911401C4;
 Tue, 29 Oct 2024 08:33:41 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-09.internal (MEProxy); Tue, 29 Oct 2024 08:33:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1730205221; x=
 1730291621; bh=neIx3kK3H0h0J1vT5KJpEOHRgh8qFCvAbpIoimK4DKk=; b=W
 qw2h9R+RtaB13Zz60JBS4G70HBMEfbpz11y5DxqOCsgOX9nAMNbL8acSh6gIKhPp
 xwLgRVNLi0Cjgt/AUeT0yELUmED68R7HVjloWXdX68OzhfuGOnkwx87tKiryN+qq
 NDJJvxzLJ3yopZXQ2knfV1DPKI+ffA9Nex2ouaI7nD6yuV6P0x0djSdddUTzaY3z
 in8CLr6jYLib0sn78h2gOzxPYE4xhxtphkAGM0PbcBgR1zOYcPy2e+dLPVKYO9FX
 D+kJW4W52ffBSXHCKRnwSonzvb/oGGBi+mQFpFyfRwiqnW/VgLgB450LL9H3NxRS
 YsXakcSt3FTXemSBF75bg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1730205221; x=1730291621; bh=neIx3kK3H0h0J1vT5KJpEOHRgh8qFCvAbpI
 oimK4DKk=; b=VEBxkbUlPngGXqzI1lZrLFFmaKpgM4TWd44tHDUSLE7wqAJNQL/
 2AQOXHX3stXKWJa5o1oubmA1QJOIzRPLJ13FLsGNzh8WcllemusorcxA186LwAGh
 bY5SHofc4heg1pytrHB/CiO1Vpmnj3hw+uaw26Q9EPB3jmBTn7b+calojaR/J5ns
 pPCa8VH4ZfK0WBsw+syKRlTCSESBAPwRyJzzQK4LfA8Dh/4Y61gAj6stvrvGk2Yp
 WGMpKKhx4X4qZWy31p+OVJEB8Hsz91qRvPpdVM+gpmOj7wAaI1590YVVdbBZO+AH
 rNYMoPV7+4WD6oWtqRwttuRSqglZgepboFA==
X-ME-Sender: <xms:JNYgZ5QQ4TEeChxgHq9v7R3HreG-dUVYmaBcYfegleWc_k9uCeJg3Q>
 <xme:JNYgZywjH1pzutNydJ7mhDg6BvIgO9d0mFs2FV6gVRG7dj8R5b2lurpMO6KpM0SOd
 Y_MgiCUcT3i6v4uCjE>
X-ME-Received: <xmr:JNYgZ-3Zy-RbAKMfDDbIahdCWamd4shJf8XanmTNuPhc7zHyssSiMZPZaWvshg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdekuddgfeejucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
 rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
 htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesghdtroertddtjeen
 ucfhrhhomhepmfhlrghushculfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrd
 gukheqnecuggftrfgrthhtvghrnhepieevffffhfeludekhefhteeuleekffduueeikedt
 geethfegfeelieduleevleeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
 hmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukhdpnhgspghrtghpthht
 ohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhgsuhhstghhsehkvghrnh
 gvlhdrohhrghdprhgtphhtthhopehfohhsshesuggvfhhmrggtrhhordhithdprhgtphht
 thhopehqvghmuhdqsghlohgtkhesnhhonhhgnhhurdhorhhgpdhrtghpthhtohepqhgvmh
 huqdguvghvvghlsehnohhnghhnuhdrohhrghdprhgtphhtthhopehkrdhjvghnshgvnhes
 shgrmhhsuhhnghdrtghomhdprhgtphhtthhopehqvghmuhdqshhtrggslhgvsehnohhngh
 hnuhdrohhrghdprhgtphhtthhopehjfihkohiirggtiihukhesghhmrghilhdrtghomhdp
 rhgtphhtthhopehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:JNYgZxAk9kF104VYB00mdVt2YpZ5iOe5-nqURq0P9WB8IjLr7yvm5Q>
 <xmx:JNYgZyh_N5X-H51Jj2Zr1a0Yfjo3gw2tG_pkW9Is2b_NT1r3Eqbtdg>
 <xmx:JNYgZ1qwpc6l9US8JRh1E8wvrtmI-vQdVmBf_isTbqfU-bYRnrHeyA>
 <xmx:JNYgZ9iDkupyQFtpW5Lx0j9isz0WxA0TWn0VaxSkiw0D8uFJeumnFw>
 <xmx:JdYgZ9NoHCDEPN3p2GMrpeBMsB1lzIog0RlUcRhyd-DK6sas9YojnaZz>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Oct 2024 08:33:39 -0400 (EDT)
Date: Tue, 29 Oct 2024 13:33:38 +0100
From: Klaus Jensen <its@irrelevant.dk>
To: Keith Busch <kbusch@kernel.org>
Cc: Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 qemu-stable@nongnu.org, Waldemar Kozaczuk <jwkozaczuk@gmail.com>
Subject: Re: [PATCH] hw/nvme: fix handling of over-committed queues
Message-ID: <ZyDWImCgEqVJmtfE@AALNPWKJENSEN.aal.scsc.local>
References: <20241025-issue-2388-v1-1-16707e0d3342@samsung.com>
 <ZxvLQ5rSQtDAfE-H@kbusch-mbp.dhcp.thefacebook.com>
 <Zx9S_tOkgB9MoY7J@AALNPWKJENSEN.aal.scsc.local>
 <Zx-qdQqRZZlczmf5@kbusch-mbp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="CWbromSLOaW+i3ze"
Content-Disposition: inline
In-Reply-To: <Zx-qdQqRZZlczmf5@kbusch-mbp>
Received-SPF: pass client-ip=103.168.172.156; envelope-from=its@irrelevant.dk;
 helo=fhigh-a5-smtp.messagingengine.com
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


--CWbromSLOaW+i3ze
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Oct 28 09:15, Keith Busch wrote:
> On Mon, Oct 28, 2024 at 10:01:50AM +0100, Klaus Jensen wrote:
> > On Oct 25 10:45, Keith Busch wrote:
> > > On Fri, Oct 25, 2024 at 12:50:45PM +0200, Klaus Jensen wrote:
> > > > @@ -1520,9 +1520,16 @@ static void nvme_post_cqes(void *opaque)
> > > >          nvme_inc_cq_tail(cq);
> > > >          nvme_sg_unmap(&req->sg);
> > > > +
> > > > +        if (QTAILQ_EMPTY(&sq->req_list) && !nvme_sq_empty(sq)) {
> > > > +            qemu_bh_schedule(sq->bh);
> > > > +        }
> > > > +
> > > >          QTAILQ_INSERT_TAIL(&sq->req_list, req, entry);
> > > >      }
> > >=20
> > > Shouldn't we schedule the bottom half after the req has been added to
> > > the list? I think everything the callback needs to be written prior to
> > > calling qemu_bh_schedule().
> > >=20
> >=20
> > Not as far as I know. It is only queued up; it won't be executed
> > immediately. It might run next (ASAP) if we are already in a bottom
> > half, but not before whatever context we are in returns.
>=20
> Okay. I was trying to come up with an explanation for why Waldek was
> still able to reproduce the problem, and that was all I have so far.
>=20

I was too eager in removing the start_sqs stuff. I removed kicking the
cq when transitioning from full to non-full. The core fix is the right
one, but I introduced a bug...

v2 just posted should be good. Verified it with OSv master.

--CWbromSLOaW+i3ze
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmcg1h8ACgkQTeGvMW1P
Denk4wf/XuRFF9GE+CJRSDj8wvPMt3JNOgm8aK/rlaVcpcZ9pCXMfllMPevmvI9Z
Y4UPBu2xTrTkOhHOcLVTmdI7ZzDARltZNKNClqCD9V/hz4geAAQxBY8D/6nrPcdV
iAB6gERKLYI0XLqIwh0YvUBbgfqvWxrReF55cKEwz6TzM40A2D11tj0e8Vr8bjbw
W5R+qVqvtamp27OJ7fQxD6QbS2Crgy4/cdOxF+GFrXuPYDEpZQombdjxjuSQq3AB
KzaN+sZrBQhwd74pIhpz7obO/0kS1STYV3bg4ZRViSyabhzZKcaBiooujufwqISK
HA+h70VlaTERD4lkmwgJE2Z6zS+tYQ==
=jsrp
-----END PGP SIGNATURE-----

--CWbromSLOaW+i3ze--

