Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B760DC79F89
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 07:59:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3UFM-0005Wy-2P; Mon, 07 Sep 2026 03:58:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1x3UFJ-0005WM-Fd; Mon, 07 Sep 2026 03:58:29 -0400
Received: from fout-a1-smtp.messagingengine.com ([103.168.172.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1x3UFH-0005BJ-8f; Mon, 07 Sep 2026 03:58:29 -0400
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.phl.internal (Postfix) with ESMTP id F0814EC0260;
 Mon,  7 Sep 2026 03:58:25 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Mon, 07 Sep 2026 03:58:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1788767905; x=
 1788854305; bh=5sGvBgjYGvUrwE/+dF08dHoOO2XcTk86op2dtlcavYo=; b=Z
 zvwgKdkvnlKh5TrqgK0OyeaggZ7xDxjbhq8pAwt4rqO6pMMyFkf0EslmxyW5C6dk
 3OLiXTnGWAlHuDEZuFYHrH1KMCnNLynYdY8eSDk+QLSulWbToP1gIELTUbs0jPhu
 KjG6NCeQo+b6NDaQlnTenBDwPiLhwW4oYVJNpEvKfLVyok3vSWC9jIjBcQ8BkZyH
 vnZydVF4tXITMDTBul/SxqbIWtwzdY2XBesK8UhmV7rHj+9fWmfvtMrQBRhfATLi
 /6wpDgFiKIuVh7XtaP2p/hbG3wKtVFiZ4FszZpi6YbWUHlTD03buMaSzh59BiDAo
 ZRqo5cRauQ3SVhpSJqFZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
 1788767905; x=1788854305; bh=5sGvBgjYGvUrwE/+dF08dHoOO2XcTk86op2
 dtlcavYo=; b=r5JHgcz4HozHbtd7oVKPBRBQaYD1Y3uwNrP11s2XbkGFE2oIg5i
 uA6/tJgF5AzU0+Qh17xulcsPPLxc7nmNGVUa+ceoa23tQ8QJh7OHkvcPDVh+kZkM
 288M0ryDIwH2vccIt63Jni61p3OFMLG+r6TSktiR8b0qXr7Ud2mYnzGFCADiqY2g
 b52oz/iFiZkWRxt3i+gvX+Iq/R4w/hGQ0nRl1bJ4DQ3AlfdCxahvYEVjR1LaDuEC
 oqZmskDPzGAJui/F1Ow4TYBg1UJeF5PlyRYs2qk789LkQNsALV0t+tKnUI0lZ3EH
 llm8mUcljLZnxTbzE5GqO1QxTqZNiTYrBeA==
X-ME-Sender: <xms:oW6easHfmf4PlpQ_G0w49asYBfo6wy0jZI4li99G-tuLMr4432gzdg>
 <xme:oW6eagTKp9nTmaJ6yWBynHfQ9qBnr8S8fFZZ_RVtS6p8IJ-jIHT0VRqvYHCaSJytc
 oAfb8amY5jBiLhSCoT37qMvZ4SFKFxv_uQcBZwaWVQo6-Nh-UPn0rs>
X-ME-Received: <xmr:oW6ealISqS1DQd1YnLfmSNw9IMTrCulTro1bkBEHkvoYpXDew8xrBFU9yofO4w>
X-ME-Proxy-Cause: dmFkZTEc3JEnoGuMrDpFzlIAUanwdf3OYppO7X/RlRK/cNcYZG76y2kAhAt1Kqpj85XUMT
 adpIpde4O3XuuYRAOK4bxwqyZze06/xKZMIH9TMmooCYXElgN1qdm0Bob+nXfu3VosEnNU
 jQn9eo36TICcKMMLDfcWx0W/hsYxeUsfUX4Zj7Xk4wZyraT8ok765uWNpJFyxRqBFyyIqG
 SoAM3WCtR03UJIP2twsHGCp/sR0FKYpcn5IOxbySRI1cKVWx7WOQd36+6RF6AOxPdzQZkJ
 8M0m33NGkHeXPSGsIez9xhHbFUzRayykz5V2YFhyPHHvq2wNNGfBU6xIJPF1/IT1dB0IIP
 9CYTv2LwOshSkXMH9soPqu7/fTnskupXYKJX3ja0xtwdKITzFfqeVPpS5OMsyGFXhNSekZ
 mpc1wZvZmRz8+mOT0rAAfkYqdKK7RS2laDYcP8YfE7+nCFMIp+eNu+A3VeEKu4d0aakkGm
 8CWm15Nb9SkCPe/UZkc8U+qyer8d+Vvyp7C0izOIFvhwR50JSIoG7WDgm2FFebFDiDCSHi
 x91XF65PegU7654G8PUKS/7x/J7s5zTcbnxIXuXNz7l96jYFxF6y3VO4wVNPchOlx1Wwz+
 1c34bo97Z+qMhXizt57UkmrSnapflZ04ofwaYR2SK2ieBX3fLqFmiP+Ja1rA
X-ME-Proxy: <xmx:oW6eajZ92FUvpWZXTHT68Tgm7dZJgq1j8CSxVOqs814zib76gLq0eA>
 <xmx:oW6eav-vtzpPaNXkCBU0mFK1bK9bk5_6nAwm607VHAAvHXS43Ma40A>
 <xmx:oW6easZ3GPgv5ymUCnza5t5wm7Nt3bduV_RiY2IUhqyJkCOcx-e1tA>
 <xmx:oW6earO3QwS_oCgOWrvTsvx8rhAo9S18jLxvFlbJvSJX-mt2aQvzSQ>
 <xmx:oW6eapB8H534Ygn4I-4WRPYtEhkm8zIzo9_s2NEhi3fWf0LHJFX6dJA5>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Sep 2026 03:58:25 -0400 (EDT)
Date: Mon, 7 Sep 2026 09:58:24 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Luigi Leonardi <leonardi@redhat.com>
Cc: qemu-devel@nongnu.org, Keith Busch <kbusch@kernel.org>,
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH] hw/nvme: fix firmware boot path when nvme-ns has a
 bootindex
Message-ID: <ap5rqeQqJpfl1Ejb@AALNPWKJENSEN.aal.scsc.local>
References: <20260819-fix_nvme-v1-1-6d3d5e6909c1@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="EH3DDjtt9an0xaul"
Content-Disposition: inline
In-Reply-To: <20260819-fix_nvme-v1-1-6d3d5e6909c1@redhat.com>
Received-SPF: pass client-ip=103.168.172.144; envelope-from=its@irrelevant.dk;
 helo=fout-a1-smtp.messagingengine.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

--EH3DDjtt9an0xaul
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Aug 19 10:04, Luigi Leonardi wrote:
> The correct way to register an NVMe namespace in fw_boot_order is to use
> the NVMe controller as the device pointer with the namespace ID appended
> as a suffix, producing:
>=20
>   /pci@i0cf8/pci1b36,0010@4/namespace@1,0
>=20
> This is how the controller-level bootindex works.
> Explicit nvme-ns devices instead register the nvme-ns device itself,
> which is wrong: realize() reparents the namespace onto the NVMe subsystem
> bus, disconnecting it from the controller in the bus hierarchy.
> qdev_get_fw_dev_path() therefore produces a path without the controller's
> address:
>=20
>   /nvme-ns/namespace@1,0
>=20
> Fix by re-registering in realize(), once the controller and final nsid
> are known, using the controller as the device pointer with the namespace
> suffix. The old entry (registered against the nvme-ns device) must be
> removed first since add_boot_device_path() only removes entries matching
> the same device pointer, and leaving both would cause a
> duplicate-bootindex error.
>=20
> device_add_bootindex_property() cannot be called in realize() because
> QEMU parses command-line properties before realize() runs, so the
> bootindex property must exist by instance_init() time. The final nsid is
> not yet known then either as it's assigned in realize().
>=20
> The fix is restricted to non-shared namespaces: for shared namespaces
> there is no single controller to register the boot path against.
>=20
> Also add the symmetric unrealize() cleanup so that hot-unplugging a
> non-shared nvme-ns with a bootindex removes the fw_boot_order entry that
> was registered against the controller in realize().
>=20
> Reported-by: Gerd Hoffmann <kraxel@redhat.com>
> Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
> ---
>  hw/nvme/ns.c | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/nvme/ns.c b/hw/nvme/ns.c
> index 7f0f9ac766..83786b4401 100644
> --- a/hw/nvme/ns.c
> +++ b/hw/nvme/ns.c
> @@ -727,6 +727,10 @@ static void nvme_ns_unrealize(DeviceState *dev)
>      nvme_ns_shutdown(ns);
>      nvme_ns_cleanup(ns);
> =20
> +    if (!ns->params.shared && ns->bootindex >=3D 0) {
> +        del_boot_device_path(DEVICE(ns->ctrl), ns->bootindex_suffix);
> +    }
> +
>      /* Symmetric with nvme_ns_realize() which sets subsys->namespaces[ns=
id]. */
>      if (subsys && nsid && subsys->namespaces[nsid] =3D=3D ns) {
>          subsys->namespaces[nsid] =3D NULL;
> @@ -891,6 +895,19 @@ static void nvme_ns_realize(DeviceState *dev, Error =
**errp)
> =20
>      if (!ns->params.shared) {
>          ns->ctrl =3D n;
> +
> +        /*
> +         * Register the boot device path using the NVMe controller
> +         * so the OFW path includes the controller's PCI address:
> +         *   /pci@i0cf8/pci1b36,0010@<slot>,0/namespace@<nsid>,0
> +         */
> +        if (ns->bootindex >=3D 0) {
> +            del_boot_device_path(dev, NULL);
> +            snprintf(ns->bootindex_suffix, sizeof(ns->bootindex_suffix),
> +                     "/namespace@%" PRIu32 ",0", nsid);
> +            add_boot_device_path(ns->bootindex, DEVICE(n),
> +                                 ns->bootindex_suffix);
> +        }
>      }
>  }
> =20
> @@ -1117,10 +1134,8 @@ static void nvme_ns_instance_init(Object *obj)
>  {
>      NvmeNamespace *ns =3D NVME_NS(obj);
> =20
> -    sprintf(ns->bootindex_suffix, "/namespace@%" PRIu32 ",0", ns->params=
=2Ensid);
> -
>      device_add_bootindex_property(obj, &ns->bootindex, "bootindex",
> -                                  ns->bootindex_suffix, DEVICE(obj));
> +                                  NULL, DEVICE(obj));
>  }
> =20
>  static const TypeInfo nvme_ns_info =3D {
>=20
> ---
> base-commit: 9696bf5dc5a5bf0b4a9d05b6cdfe5f13990f97aa
> change-id: 20260818-fix_nvme-d8cfaa3368c9
>=20
> Best regards,
> --=20
> Luigi Leonardi <leonardi@redhat.com>
>=20
>=20

LGTM. Thanks!

Reviewed-by: Klaus Jensen <k.jensen@samsung.com>

--EH3DDjtt9an0xaul
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmqebp8ACgkQTeGvMW1P
DennKwgAgKa2sTUDSdboVECUvC5nuyr5Wh0eK+Kf2n6g0FacK5wHKcvMk/yAMAOg
UOPwTTno7TxcRvTH1KnKei3l5QQAEKbqgioGYSqxQmpDy2VgpkJBnDn00RoADS+X
tY+gcpsMYg3D6O2iq7xl1WRuhoGi8v0KAVBAXh9x4DlhK4DY8qijcXkCwJaJRG0u
y9NaFMT9aa/Oj/Ttr3sM3XGnZahEeJQ4IYZhFZsricclTlmFNs2XQNIwU+Cf/pd9
mS1Sm9iz4zRths+rgNmkc+rzpe/VN8BdwKPpytW1IbhVd3QCV72df1zHmuF0rl9U
ckR0uozPR9uwGPhTtiC+PZQr1wEdoQ==
=FbVH
-----END PGP SIGNATURE-----

--EH3DDjtt9an0xaul--

