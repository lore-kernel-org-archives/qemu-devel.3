Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08B93C47422
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 14:11:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rURpg-0001wy-H0; Mon, 29 Jan 2024 08:37:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1rURpY-0001m9-W9; Mon, 29 Jan 2024 08:37:46 -0500
Received: from wout3-smtp.messagingengine.com ([64.147.123.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1rURpW-0000iN-EO; Mon, 29 Jan 2024 08:37:44 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailout.west.internal (Postfix) with ESMTP id 9CF0032004AE;
 Mon, 29 Jan 2024 08:37:35 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
 by compute5.internal (MEProxy); Mon, 29 Jan 2024 08:37:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1706535455; x=
 1706621855; bh=7G/q5eftMZJbKWoTuLpbhCIecgF2pjqJrVq5ekVhyeY=; b=U
 dVcise4Xd9emKdDy4JPApEc2rNke3DqOPwWJQMv+Yt3TdFHxMuEmuGJaVbaRnHCM
 seO1zgMs60p0qOgi20ihOUY0PRJP2ChG074WyFsCO+P4Ahl8oL12PJoWKCHPgTA7
 Qc3etctd30MRLoSNALeWPsPKvNluWJDoeQ/FfT/xeqqau2pd5C9TdwmMKxIPZK/y
 S6ggYo28vrWIsRUzwKuOXftHxN+MKec7zNyRdul2FpHMJszLlOQvKuEKE9q0mH2L
 JYUK9gpFv7pX23oxdBOGvBBpCEc1bRGJ22VALra9rjBnQM5Z2wlpm80ngTIkySQ5
 f9W/jn66O5fYDue/h9GJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; t=1706535455; x=1706621855; bh=7G/q5eftMZJbKWoTuLpbhCIecgF2
 pjqJrVq5ekVhyeY=; b=BVECDSJ5uA7mGMHx1HYAeHEXMZZIuAHkwtTqyIZaw8aE
 YyIwLaoIUOszdnNamxHVTf3SaG27nYfJu/CZuJN/BuDOnEDdhrmZr2c+MfP+njkP
 vO3VobmPKiHbxcZ472cxhLNNL0gpaYr8fX99rIYQqPVqZPGB3NWNA8DjKhsPS3Y3
 g9XFWNus0rK7viPcYpXwaBzJnutGqmv5bXZz6ZSthSB8nSWSzW+8rsrFPX7k0aVr
 Z0zfczfUzuTeKk9w/SEgPnMDRkf1dJ/4L7KUHqWpZaa+ewBavlChXXunE1HUbZ+1
 kM9v4VWdM0YBnpxw3/7t3SdIqYzTMxpUV50M3UDOKQ==
X-ME-Sender: <xms:Hqq3ZUHEefUIxI5BpSg3RAIA5D4XPoUSaDm030e29HAWEYOQ_23_Gg>
 <xme:Hqq3ZdURDX28OOQHwJY7_PaFLT4RtSkljKQw8_23DsctYxhaU3cpOpNQaEREKdF3_
 ZaFL6QG0B5wRTslHPA>
X-ME-Received: <xmr:Hqq3ZeJNUhpT3ZbYwJdwJSGUYdpizj0pmeQoJr5xOmpvhXi6_1jXhUVbAoTsmw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedtgedggeegucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepmfhlrghu
 shculfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrth
 htvghrnhepjefgjeefffdvuefhieefhffggfeuleehudekveejvedtuddugeeigeetffff
 jeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepih
 htshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:Hqq3ZWGhPzQJ4RKQnWdCVTp4E37hbEKViPT-KymUcGQGWIK1fGqBGg>
 <xmx:Hqq3ZaWgxIkuwEvWHHTKeP7ptOE9BojCGovQPFWiIW28pQjaG1kLpA>
 <xmx:Hqq3ZZNADwACx8ShDiXjHpRy2EywvM6JQ4-v7R72acJN7yURCgcMhQ>
 <xmx:H6q3ZepymJXizJrN-ZcmPwIP3m8--6roR42nQ-qCWMVYX48pZRFj0Q>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jan 2024 08:37:33 -0500 (EST)
Date: Mon, 29 Jan 2024 14:37:28 +0100
From: Klaus Jensen <its@irrelevant.dk>
To: Damien Hedde <dhedde@kalrayinc.com>
Cc: Hannes Reinecke <hare@suse.de>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-block@nongnu.org, Keith Busch <kbusch@kernel.org>,
 qemu-devel <qemu-devel@nongnu.org>, Titouan Huard <thuard@kalrayinc.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: NVME hotplug support ?
Message-ID: <ZbeqGMdCw2QlHccd@cormorant.local>
References: <PR2P264MB0861AAF89D0B361A33710261D1742@PR2P264MB0861.FRAP264.PROD.OUTLOOK.COM>
 <499096d7-1b4d-471b-9abf-5b6f72bb7990@suse.de>
 <de06e322-37e9-4788-97a2-c9f16a68cd2e@linaro.org>
 <07625f96-4ca1-479f-b6b9-69c2a191de76@suse.de>
 <7e35528b-cc66-d2f1-e3e3-7dece5620c52@kalrayinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="lNgLd6U+E1lVc+C+"
Content-Disposition: inline
In-Reply-To: <7e35528b-cc66-d2f1-e3e3-7dece5620c52@kalrayinc.com>
Received-SPF: pass client-ip=64.147.123.19; envelope-from=its@irrelevant.dk;
 helo=wout3-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--lNgLd6U+E1lVc+C+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jan 29 14:13, Damien Hedde wrote:
>=20
>=20
> On 1/24/24 08:47, Hannes Reinecke wrote:
> > On 1/24/24 07:52, Philippe Mathieu-Daud=C3=A9 wrote:
> > > Hi Hannes,
> > >=20
> > > [+Markus as QOM/QDev rubber duck]
> > >=20
> > > On 23/1/24 13:40, Hannes Reinecke wrote:
> > > > On 1/23/24 11:59, Damien Hedde wrote:
> > > > > Hi all,
> > > > >=20
> > > > > We are currently looking into hotplugging nvme devices and
> > > > > it is currently not possible:
> > > > > When nvme was introduced 2 years ago, the feature was disabled.
> > > > > > commit cc6fb6bc506e6c47ed604fcb7b7413dff0b7d845
> > > > > > Author: Klaus Jensen
> > > > > > Date:=C2=A0=C2=A0 Tue Jul 6 10:48:40 2021 +0200
> > > > > >=20
> > > > > > =C2=A0=C2=A0=C2=A0 hw/nvme: mark nvme-subsys non-hotpluggable
> > > > > > =C2=A0=C2=A0=C2=A0 We currently lack the infrastructure to hand=
le
> > > > > > subsystem hotplugging, so
> > > > > > =C2=A0=C2=A0=C2=A0 disable it.
> > > > >=20
> > > > > Do someone know what's lacking or anyone have some tips/idea
> > > > > of what we should develop to add the support ?
> > > > >=20
> > > > Problem is that the object model is messed up. In qemu
> > > > namespaces are attached to controllers, which in turn are
> > > > children of the PCI device.
> > > > There are subsystems, but these just reference the controller.
> > > >=20
> > > > So if you hotunplug the PCI device you detach/destroy the
> > > > controller and detach the namespaces from the controller.
> > > > But if you hotplug the PCI device again the NVMe controller will
> > > > be attached to the PCI device, but the namespace are still be
> > > > detached.
> > > >=20
> > > > Klaus said he was going to fix that, and I dimly remember some patc=
hes
> > > > floating around. But apparently it never went anywhere.
> > > >=20
> > > > Fundamental problem is that the NVMe hierarchy as per spec is
> > > > incompatible with the qemu object model; qemu requires a strict
> > > > tree model where every object has exactly _one_ parent.
> > >=20
> > > The modelling problem is not clear to me.
> > > Do you have an example of how the NVMe hierarchy should be?
> > >=20
> > Sure.
> >=20
> > As per NVMe spec we have this hierarchy:
> >=20
> >  =C2=A0=C2=A0=C2=A0=C2=A0 --->=C2=A0 subsys ---
> >  =C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> >  =C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 V
> > controller=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 namespaces
> >=20
> > There can be several controllers, and several
> > namespaces.
> > The initiator (ie the linux 'nvme' driver) connects
> > to a controller, queries the subsystem for the attached
> > namespaces, and presents each namespace as a block device.
> >=20
> > For Qemu we have the problem that every device _must_ be
> > a direct descendant of the parent (expressed by the fact
> > that each 'parent' object is embedded in the device object).
> >=20
> > So if we were to present a NVMe PCI device, the controller
> > must be derived from the PCI device:
> >=20
> > pci -> controller
> >=20
> > but now we have to express the NVMe hierarchy, too:
> >=20
> > pci -> ctrl1 -> subsys1 -> namespace1
> >=20
> > which actually works.
> > We can easily attach several namespaces:
> >=20
> > pci -> ctrl1 ->subsys1 -> namespace2
> >=20
> > For a single controller and a single subsystem.
> > However, as mentioned above, there can be _several_
> > controllers attached to the same subsystem.
> > So we can express the second controller:
> >=20
> > pci -> ctrl2
> >=20
> > but we cannot attach the controller to 'subsys1'
> > as then 'subsys1' would need to be derived from
> > 'ctrl2', and not (as it is now) from 'ctrl1'.
> >=20
> > The most logical step would be to have 'subsystems'
> > their own entity, independent of any controllers.
> > But then the block devices (which are derived from
> > the namespaces) could not be traced back
> > to the PCI device, and a PCI hotplug would not
> > 'automatically' disconnect the nvme block devices.
> >=20
> > Plus the subsystem would be independent from the NVMe
> > PCI devices, so you could have a subsystem with
> > no controllers attached. And one would wonder who
> > should be responsible for cleaning up that.
> >=20
>=20
> Thanks for the details !
>=20
> My use case is the simple one with no nvme subsystem/namespaces:
> - hotplug a pci nvme device (nvme controller) as in the following CLI (wh=
ich
> automatically put the drive into a default namespace)
>=20
> ./qemu-system-aarch64 -nographic -M virt \
>    -drive file=3Dnvme0.disk,if=3Dnone,id=3Dnvme-drive0 \
>    -device nvme,serial=3Dnvme0,id=3Dnvmedev0,drive=3Dnvme-drive0
>=20

AFAIK, you just need a pci root port to plug the device into.

  -drive file=3Dnvme0.disk,if=3Dnone,id=3Dnvme-drive0 \
  -device "pcie-root-port,id=3Dpcie_root_port0,chassis=3D1,slot=3D0" \
  -device nvme,serial=3Dnvme0,id=3Dnvmedev0,drive=3Dnvme-drive0

Then, you can use the qemu monitor to `device_del nvmedev0` and add it
with `device_add nvme,serial=3Dnvme0,id=3Dnvmedev0,drive=3Dnvme-drive0`. The
"drive" (blockdev) will stick around after the device_del.

--lNgLd6U+E1lVc+C+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmW3qhgACgkQTeGvMW1P
DemO3wf9E6x9yr6IZenVktIsLssANisuFmLVe59EoivQyWrcylgp4MJSmCd4et5F
NPddAIuNfCy/0RZMV+Yec2F/vwz91XpnLaXMMF96vDvcU2Yl4rVBjWkxICevcdwm
E9SQjuip6buhiiRQm1CQtJpHzwwu8z5BLKjxgLxesNGkB8YOTd3V28SUmeFUwCEi
k1xfvAXQRYDLSxb+oL9PxoywkBgArJ3xm9rhmUbezcZCImcOmupM31UXovDgBGZk
S7KfiksSXSZPy0wsFmmqqdlT75pWzwWMvXDvZ0zv81IhddzLLx1qj9vMx16s7FaW
zrVykjUdNHGy0gb5TV5VjeJLH+PeAw==
=nXB6
-----END PGP SIGNATURE-----

--lNgLd6U+E1lVc+C+--

