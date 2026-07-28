Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9640FC54F4C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 07:46:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wocVz-00038I-3I; Tue, 28 Jul 2026 03:46:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1wocVx-000386-TJ; Tue, 28 Jul 2026 03:46:13 -0400
Received: from fout-a1-smtp.messagingengine.com ([103.168.172.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1wocVv-0001qp-EY; Tue, 28 Jul 2026 03:46:12 -0400
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.phl.internal (Postfix) with ESMTP id 01C69EC0232;
 Tue, 28 Jul 2026 03:46:10 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Tue, 28 Jul 2026 03:46:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1785224769; x=
 1785311169; bh=eJH1NKI/QgFHKbgWCsPI3uuPR850SYB/lPJOS79BJhI=; b=S
 LhxWyNewAB5eLSgLhOc94CU8hyAX1FU6YPjKumMByc814WlrEoqq2jBWZNFhIJyq
 S6FXgiwp+CSTnGoYpF0ezebChyIkDRAH1s02T7EWmVkzDvf9rkwUqjMcs1dMnm3D
 kg13DdZXCQj/IVTsxShUgo5Dg2aJwtu9xA7S0lANexyvo15I+XLHtkLaYveL+cau
 ujrLnCtx1WOm0HObGaabXkkg6RU6mGvBVPTades2OBsAfdZ+CmQ5PMW/XMjsK7Vw
 zUzyPOh7ZjfBYeVJvNikesSDU1GoFL9oxIB8YH6oSPSoLOY30fPisf+6zzGEM4ph
 FlWdQ93CHxs3ZJzKbZtkw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
 1785224769; x=1785311169; bh=eJH1NKI/QgFHKbgWCsPI3uuPR850SYB/lPJ
 OS79BJhI=; b=LHHfhnAYrTyWtNWLoQDVmICDLGxbx06vCs0dWnw+aKXiVBURChY
 V3aIvgjKpefuQFBjIWJt8FyF7wlW1BRaz8fElYvWMoqz62q9a4NkBdsnoQ7Zaqoq
 90kQVY4rON+D8MFVjRd+q1I6eM0Gc8G3H0zOdVV+vnj2ZHq+IPi1DSObJgp0qlU7
 JxB+k6/xJTuYYo8rIDmH9vEhzkDOgb9hl9c2JLP6Zfo2XsXhWGOQPiUiksI+ou/F
 lnVdxx7rUV7/XYGtz7YncGMX2XlRITISrhdP8BCe+NbW4ItfjAajfvymNzdhBBRC
 xh3e7kQl+x06DZj+9vU6DxLhiXt8MZk3/7Q==
X-ME-Sender: <xms:QV5oam2VLzP0XDRYWpqi7lR7OuqNWy6JJVSGQDmXJWb7x1qyIRxMwQ>
 <xme:QV5oaiDn-tUN-e-lrpXM043QSbNgIPqMWbSr4Dy9EItbU51bz2ZZQSi3wR0f8XDUB
 xyY0NmLhoK6C4UAVOvGt16kMwQEFr9yeS4XJ4Eof11iLN2wIEkatfE>
X-ME-Received: <xmr:QV5oaqdwNK-NlA7nX3Nr-KzkaLiPCnk751pE3-Txjy9IkZ9cd8VgBhnJFyJpEw>
X-ME-Proxy-Cause: dmFkZTFG5p0UXrE06AXv3HitZ9HUbiino+zuB15xYT/yvXKuH/reGi/TWKmmeP/o+oHYDM
 bWs563mZow4Tmj50s2lEg78m7D6YPFUo8odqi3b4MJH6vFgOS8L5mBxWU7cXptLC5yRTAf
 w+gNhHe2MFusBgnMg6tAmzR8xuHQwwbk+8lFuSDOMrTSMeXx9Snw6P0EUaN3y0zKVt+pyc
 inMEfyXMrUH0gAtJJPbg2tQBtf9Gvegj0KJoLUignvc1K2qv0ydJjKQXzh7IMY5QpwdyW9
 FzP32S4dQwLQd5rimLjEqpbeAFwtq1THnepum3fCOKftAJyrg3uysiB13EdEG2fVgtFpaF
 0W4MKh8bNA7c74SNx8fWwqjK+ztp2R8qhFaNF7sCmEFIE7HFpkCZq3XDI4KiCgTHHMTGR7
 AeVRMPZ9aEsgw9mNcbvb//cyOgjZ0QY9NAY453gqS1vJfH6COCUuMeJHqevSQTU7R95B+y
 cTx5qRnbNQvAXd3LdObKOP4JfhcFVg8IeFSqW/OecC2zIaXANu8uS1uytK3OraFjh443Hn
 su2Es4qZTVTXFPHzakXNG+FX6H4eePY0hjxPNP4GhSer/xZ9zbA9UeSqi33//lfWUYp93q
 YtXiGsgwV5nt4oQZPRMdsiURZGyDYLfc6jKoYoa/hdt3p0I6Dn3+PgxwcEzQ
X-ME-Proxy: <xmx:QV5oan5C71lNHp1ofRKeVuY6OwmlySW9vvje78WIZ3WqmLVWL5XPsg>
 <xmx:QV5oalXehxlAb4CByPEvpDiVeid4XcUhCZ53gFP-8-oykNO_bUsuvQ>
 <xmx:QV5oau5344BymPEQbeIyrsdFGp_xHkpI8VwWc93etTGqgWZ2cbuJZA>
 <xmx:QV5oaoqzd5jX-fOqHggOHw73Pn7vXsYPKqsFrfw2nXhXOfxUbIFFZg>
 <xmx:QV5oasNGITip7TKfBhpMUb9LkzAlqABZW6-fAVmNazEnLwFnCqfcsFWr>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Jul 2026 03:46:09 -0400 (EDT)
Date: Tue, 28 Jul 2026 09:46:08 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Daniel Paziyski <danielpaziyski@gmail.com>
Cc: Keith Busch <kbusch@kernel.org>, Jesper Devantier <foss@defmacro.it>,
 "open list:nvme" <qemu-block@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Subject: Re: [PATCH] hw/nvme: fix assertion failure on subregion removal when
 removing a nvme controller with a msix exclusive bar
Message-ID: <amhePzE79du0xpUT@AALNPWKJENSEN.aal.scsc.local>
References: <20260726183008.160498-1-danielpaziyski@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="W4oj83cuMl/p+8Zu"
Content-Disposition: inline
In-Reply-To: <20260726183008.160498-1-danielpaziyski@gmail.com>
Received-SPF: pass client-ip=103.168.172.144; envelope-from=its@irrelevant.dk;
 helo=fout-a1-smtp.messagingengine.com
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

--W4oj83cuMl/p+8Zu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jul 26 20:30, Daniel Paziyski wrote:
> When a controller is created with a MSI-X exclusive BAR, the bar0 memory =
region
> is not used at all, and so, the iomem region is not added as a subregion =
of it.
> However, when removing a NVMe controller, the iomem region is uncondition=
ally
> removed as a subregion of bar0, causing an assertion failure. Remove the =
iomem
> memory region as a subregion of bar0 only if not using a MSI-X exclusive =
BAR.
>=20
> QEMU options (requires a hotunplug-aware OS):
>=20
>         -M q35 -device pcie-root-port,id=3Drp0 \
>         -device nvme,serial=3Dctrl0,id=3Dctrl0,bus=3Drp0,msix-exclusive-b=
ar=3Don
>=20
> In the QEMU monitor, or by causing an ejection from the OS:
>=20
>         device_del ctrl0
>=20
> Message in stderr:
>=20
> qemu-system-x86_64: ../system/memory.c:2617: memory_region_del_subregion:=
 Assertion `subregion->container =3D=3D mr' failed.
>=20
> Fixes: fa905f65c554 ("hw/nvme: add machine compatibility parameter to ena=
ble msix exclusive bar")
> Fixes: 9162f1012576 ("hw/nvme: fix msix_uninit with exclusive bar")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4090
> Signed-off-by: Daniel Paziyski <danielpaziyski@gmail.com>
> ---
>  hw/nvme/ctrl.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> index a67e159889..142fbe033e 100644
> --- a/hw/nvme/ctrl.c
> +++ b/hw/nvme/ctrl.c
> @@ -9710,10 +9710,9 @@ static void nvme_exit(PCIDevice *pci_dev)
>          msix_uninit_exclusive_bar(pci_dev);
>      } else {
>          msix_uninit(pci_dev, &n->bar0, &n->bar0);
> +        memory_region_del_subregion(&n->bar0, &n->iomem);
>      }
> =20
> -    memory_region_del_subregion(&n->bar0, &n->iomem);
> -
>      migrate_del_blocker(&n->migration_blocker);
>  }
> =20
> --=20
> 2.55.0
>=20
>=20

LGTM.

Reviewed-by: Klaus Jensen <k.jensen@samsung.com>

--W4oj83cuMl/p+8Zu
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmpoXkAACgkQTeGvMW1P
DelWrAf/UBiPJfTdQvFLJrlo3vThuXkmOHgH3JUMtHsjyPS3zOCKW4fk+zmhPrTi
lt+jPRw315ebQzwKJx3Zo9dH0TP8RckEq5nuR/T4oSRhH44GFuKfk2htWZBmjpdX
/UD5ymNkhP9n4N55Umpto4obSWvOVds4dxfNl4kCFl04KrAClhXwO31n5W1GixR+
DkSPo53mKIIlhCZeZCFUZKJySDIVgTTRH3pkJF8bY/bzr0stQAjCefKdSw2BC3x7
+LfZye/CNf2aCl4AdaQkmZg3SXse4RXmUMCrEt9B7HwB2aBvmh1J1Cx9lAu4dInk
m/73BeTKzh6WXc8UqrImJEaFKU+mzQ==
=VYN0
-----END PGP SIGNATURE-----

--W4oj83cuMl/p+8Zu--

