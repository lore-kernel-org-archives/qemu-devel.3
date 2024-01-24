Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6B33C46CD2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 07:40:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSXr3-0002HU-BI; Wed, 24 Jan 2024 02:39:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1rSXqy-0002HE-PK; Wed, 24 Jan 2024 02:39:21 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1rSXqw-0002bg-Ck; Wed, 24 Jan 2024 02:39:20 -0500
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
 by mailout.nyi.internal (Postfix) with ESMTP id CEF665C0144;
 Wed, 24 Jan 2024 02:39:15 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute7.internal (MEProxy); Wed, 24 Jan 2024 02:39:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1706081955; x=
 1706168355; bh=KUERMLQXEMXTpbbPnORBSFUIVtxQyeTAcw+8kPrmmGo=; b=g
 nBpQskXsEvsipEyjHPVogptCOT2tcTO85g64HSFRVXGyN1kROT8gPQNkeMy8OK8X
 72bwlSxrrFcLyQrE7cCk1GA16BMCMoMmKITUdTW8Zu4Z22o4nHLLwjjOefMsvO0g
 TJ8Jy+ClW3hiKpATYU+qjnPyNMVTIZ179JV2GPHdU5gVUp4iU3AdReKIsx3H1oRN
 uJ+lz3t9xkHmrSYmFMYSEvnlGWyuqFnCc5H0GoAddkI9EPfoVmSYmaDoNB2jeOg1
 oG7aeKYtBHe36aT4Uwo36fjegnTY2dZshAcI4ySQhQFb/Z0TclwKJT/MKf8cHqkY
 vnNji0pp73cTRnnN7L3UA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; t=1706081955; x=1706168355; bh=KUERMLQXEMXTpbbPnORBSFUIVtxQ
 yeTAcw+8kPrmmGo=; b=YEs0Pc/mlhZZtNUKke9ZoykzMNIGT8sfIndJPRNRcHCI
 gNRuDnMXI/bQyuAqZX/Ru/A5yUJ8SLJHosAnank5ra2v+uVVBR5lLVmsXa4wbM4x
 h/0GCQ0Z3uOMgLKcqfUVYvUNRI4iib6VTjihM5IdNGgVrRgqWM2Xbjy72696l/qk
 b8X0qLT2dtU1U9Bd828lbGpSl8WauWlSl0Q2eBCNQr/M9dOzK9eFzX/ZSYwhOTut
 /VQ9DD9Mx3HCrUGm7KUT3ib1qc3XW79NxTQqf8dJ4fyEPFJwt+t8/pEaEAz3mwJI
 cWcCzUaA1UseWrKPg3osTdo2JaJS88LhErGj+SzsZQ==
X-ME-Sender: <xms:o76wZcsxq0NiyldpiXwmU5itQTIsM1kQE3CYmR5Ed-jypO3fE-Qz3A>
 <xme:o76wZZexutcjwDOUl1MC6RUvmRijJVjuFXmJ0pARwC6ulJc9G7y1VHsMF-hMF4mNG
 77KCx3boX44M4XRGEU>
X-ME-Received: <xmr:o76wZXyfnzYUBRw89_lZrGWR0PX2gjPHmX5YddqRVeUEAmVojH61ne-ewIeBTQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeltddgjeejucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepmfhlrghu
 shculfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrth
 htvghrnhepjefgjeefffdvuefhieefhffggfeuleehudekveejvedtuddugeeigeetffff
 jeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepih
 htshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:o76wZfO7c35_6e-boPUmPe12bNvCF_nRygcWc7y3kaJwEgTjKgjFyQ>
 <xmx:o76wZc8cawySqpfMoqorUv15YVPAIQ175XoYbjYHkOavkU0wSMgCig>
 <xmx:o76wZXXaNxcUV7JguBXDJeX9mleH-nHR-_dUzpWI-wTdzjyH-ztziQ>
 <xmx:o76wZbnam3ttFS3KbZ4XplBdgvczihCe9BRgTF5RqVvrFupHgfUSFA>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Jan 2024 02:39:14 -0500 (EST)
Date: Wed, 24 Jan 2024 08:39:09 +0100
From: Klaus Jensen <its@irrelevant.dk>
To: Hannes Reinecke <hare@suse.de>
Cc: Damien Hedde <dhedde@kalrayinc.com>, qemu-block@nongnu.org,
 Keith Busch <kbusch@kernel.org>, qemu-devel <qemu-devel@nongnu.org>,
 Titouan Huard <thuard@kalrayinc.com>
Subject: Re: NVME hotplug support ?
Message-ID: <ZbC-nSxMTQ6RveHG@cormorant.local>
References: <PR2P264MB0861AAF89D0B361A33710261D1742@PR2P264MB0861.FRAP264.PROD.OUTLOOK.COM>
 <499096d7-1b4d-471b-9abf-5b6f72bb7990@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="MHxbsY50sjgQZC5A"
Content-Disposition: inline
In-Reply-To: <499096d7-1b4d-471b-9abf-5b6f72bb7990@suse.de>
Received-SPF: pass client-ip=66.111.4.28; envelope-from=its@irrelevant.dk;
 helo=out4-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


--MHxbsY50sjgQZC5A
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jan 23 13:40, Hannes Reinecke wrote:
> On 1/23/24 11:59, Damien Hedde wrote:
> > Hi all,
> >=20
> > We are currently looking into hotplugging nvme devices and it is curren=
tly not possible:
> > When nvme was introduced 2 years ago, the feature was disabled.
> > > commit cc6fb6bc506e6c47ed604fcb7b7413dff0b7d845
> > > Author: Klaus Jensen
> > > Date:   Tue Jul 6 10:48:40 2021 +0200
> > >=20
> > >     hw/nvme: mark nvme-subsys non-hotpluggable
> > >     We currently lack the infrastructure to handle subsystem hotplugg=
ing, so
> > >     disable it.
> >=20
> > Do someone know what's lacking or anyone have some tips/idea of what we=
 should develop to add the support ?
> >=20
> Problem is that the object model is messed up. In qemu namespaces are
> attached to controllers, which in turn are children of the PCI device.
> There are subsystems, but these just reference the controller.
>=20
> So if you hotunplug the PCI device you detach/destroy the controller and
> detach the namespaces from the controller.
> But if you hotplug the PCI device again the NVMe controller will be attac=
hed
> to the PCI device, but the namespace are still be detached.
>=20
> Klaus said he was going to fix that, and I dimly remember some patches
> floating around. But apparently it never went anywhere.
>=20
> Fundamental problem is that the NVMe hierarchy as per spec is incompatible
> with the qemu object model; qemu requires a strict
> tree model where every object has exactly _one_ parent.
>=20

A little history might help to nuance this just a bit. And to defend the
current model ;)

When we added support for multiple namespaces we did not consider
subsystem support, so the namespaces would just be associated directly
with a parent controller (in QDev terms, the parent has a bus that the
namespace devices are attached to).

When we added subsystems, where namespaces may be attached to several
controllers, it became necessary to break the controller/namespace
parent/child relationship. The problem was that removing the controller
would take all the bus children with it, causing namespaces to be
removed from other controllers in the subsystem. We fixed this by
reparenting the namespaces to the subsystem device instead.

I think this model fits the NVMe hierarchy as good as possible.
Controllers and namespaces are considered children of the subsystem (as
they are in NVMe).

Now, the problem with namespaces not being re-attached is partly false.
If the namespaces are 'shared=3Don', they will be automatically attached
to any new controller attached to the subsystem. However, if they are
private, that is is not the case. In NVMe, a private namespace just
means a namespace that can only be attached to a single controller at a
time. It is not entirely unlikely that you have a private namespace that
you then reassign to controller B when controller A is removed. Now,
what we could do is track the last controller identifier that a private
namespace was attached to, and if the same controller identifier is
added to the subsystem, we could reattach the private namespace.

However, broadly, I think the current model does a pretty good job in
supporting experimentation with hotplug, multipath and failover
configurations.

--MHxbsY50sjgQZC5A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmWwvpwACgkQTeGvMW1P
DemN/ggAlzc4Z7hyKN/SnGCjhJiiXUqtSph7VVWtjyqpHTQFO41LjCvylkVWCc/W
woSWJa+bA+Ijg1QBysiTe9KRsf8HerAoehQ/3oXYLd0Uu6lEBEUPVSB2l7BggLEv
PgBd3dZv9KcAwevr3E2akzwBLXp09eGuqpBawypIyAxjg3tdPEjuBfcI8rGLY6f+
ZY1KqzmzqK09BySIzaHdrIznG6E1Z4k/PFLDodz5UBPf5ko2VAqz3582WcofrUqa
4KSALYCaaccz5x7dD3JNKbaXHWJ59xGxBqbpUI4vr/Zs1HJ+yCSEUF1/8OusLo0l
CaYdwouadz+Qul8/Y2rRn8TvgGAXLQ==
=bJ3/
-----END PGP SIGNATURE-----

--MHxbsY50sjgQZC5A--

