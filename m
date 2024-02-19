Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 262EFC48BF8
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 22:24:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcC3Q-0002s2-4c; Mon, 19 Feb 2024 17:24:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marmarek@invisiblethingslab.com>)
 id 1rcC3O-0002rd-C3
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 17:24:02 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marmarek@invisiblethingslab.com>)
 id 1rcC3M-0006JM-7D
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 17:24:02 -0500
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
 by mailout.west.internal (Postfix) with ESMTP id 1A4BE3200A06;
 Mon, 19 Feb 2024 17:23:58 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
 by compute7.internal (MEProxy); Mon, 19 Feb 2024 17:23:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 invisiblethingslab.com; h=cc:cc:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1708381437;
 x=1708467837; bh=v5KkPOivRpp66kSB6p7Aw+l5wab5MAOcIyIXRWi4RPc=; b=
 SeWkSHMDpbQV5qgpPZfuuPRyOD2/0iHieACLat5EcdACjy0SPmZqqGbBPT5p8e3a
 wlVV6mX14pPSw7n2B4W9PqulLD9HHH825NJFcDgEnJraNpqr8675XZ3aSo8oyXCp
 t4dzEcNXmlU9upYRVXj/PmxDuC/zxKeXPEDwvf2+DvPLBzzLswYtI0RRCcX/sCcv
 TVhrqvp945ltBWdzsu7DWwG9nzVqmWK6HC3HrOTi3TPZYQfnzkdHiGTWc18YBLgJ
 J7HwnEwOjDnFaLmuRB4u+K2/7IcFzsvmDmcCbcjMxs60oBfjmpR2CXSJFPZSQEZm
 lo8uBRrcQnL5J9/KY8GR2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; t=1708381437; x=1708467837; bh=v5KkPOivRpp66kSB6p7Aw+l5wab5
 MAOcIyIXRWi4RPc=; b=KUJ7SNc9cJ2RQab3m0ECrAf/Zn3Rcrk2ZUz6QobMEDtu
 YK7oMvLRR7ChaxHzzMue+Bj6K7tXMg2MsfA5qgqSO7KmlFYxpf6VXBEmZcIsR2Dj
 /ixAoXcMVMKrQ7R5lBvVQO+EdpxZU1cbf0Hwu8JGCE0EswsLGzIfHgdbf/VB5kwA
 PFYnsa9ZJqxWv9xTrIj7qjRr+mL5aYxyWx7Bwf4Evg6sxYj+jsMZwZxA+MHDmaWj
 0/XVzU91l/IQOIIv9pOXpoCB79Dk3Z9vrnPl+luVzoZeAGkcPXtZjfUbo7MbsMlk
 rGJnnrN9xOtLj685oO+theGeCG8MuHO/eX4NlEfxZg==
X-ME-Sender: <xms:_dTTZYQyy9fpuLwgHK_1AXv4zzK46ZpJ9_zYm30ky5x9gOvN_-64hA>
 <xme:_dTTZVw2jcIkUbNvGhHl90NvJTAo5VXBiYDsp1o-Y4f_lgglzZVeiXFqEDOfXDP9I
 K-ZcZKPSGwXMw>
X-ME-Received: <xmr:_dTTZV0lJ5E48gMxXKFrcK48tGPIO_I0zR2TlHrRTW4UgyoPoZY1TrKuIRQI26ZmiWhzmMrRGb5Brjjwu4JXMsiu9Gdtuya53Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekgdduheekucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepofgrrhgv
 khcuofgrrhgtiiihkhhofihskhhiqdfikphrvggtkhhiuceomhgrrhhmrghrvghksehinh
 hvihhsihgslhgvthhhihhnghhslhgrsgdrtghomheqnecuggftrfgrthhtvghrnhepgfdu
 leetfeevhfefheeiteeliefhjefhleduveetteekveettddvgeeuteefjedunecuvehluh
 hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrrhhmrghrvghk
 sehinhhvihhsihgslhgvthhhihhnghhslhgrsgdrtghomh
X-ME-Proxy: <xmx:_dTTZcDi21UfuTbGTBGD-1K50X-UcChyHOOGpVM6zHLoXO1AKKNQ-g>
 <xmx:_dTTZRjQm-EE3TDOnknUVr2BpAER8SumyyFAJ2UNhi2qxJCVam9Zbw>
 <xmx:_dTTZYrGUzNJm0DGAq5YhjDDiT31BxCGIKTQvtMo6b6mTXhUwjpyTQ>
 <xmx:_dTTZRcmNPMS508i7npDCL1YB8C8lLpJpMoK5ABN3QYUv6kaUG7maQ>
Feedback-ID: i1568416f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Feb 2024 17:23:56 -0500 (EST)
Date: Mon, 19 Feb 2024 23:23:53 +0100
From: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?=
 <marmarek@invisiblethingslab.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?Q?Fr=C3=A9d=C3=A9ric_Pierret_=28fepitre=29?=
 <frederic.pierret@qubes-os.org>, 
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 "open list:X86 Xen CPUs" <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH 2/2] xen: fix stubdom PCI addr
Message-ID: <ZdPU-Yorm66xAN0Z@mail-itl>
References: <20240219181627.282097-1-marmarek@invisiblethingslab.com>
 <20240219181627.282097-2-marmarek@invisiblethingslab.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="OmIj9+efoChGP1II"
Content-Disposition: inline
In-Reply-To: <20240219181627.282097-2-marmarek@invisiblethingslab.com>
Received-SPF: none client-ip=64.147.123.20;
 envelope-from=marmarek@invisiblethingslab.com;
 helo=wout4-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001,
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


--OmIj9+efoChGP1II
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Feb 2024 23:23:53 +0100
From: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?Q?Fr=C3=A9d=C3=A9ric_Pierret_=28fepitre=29?= <frederic.pierret@qubes-os.org>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Anthony Perard <anthony.perard@citrix.com>,
	Paul Durrant <paul@xen.org>,
	"open list:X86 Xen CPUs" <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH 2/2] xen: fix stubdom PCI addr

On Mon, Feb 19, 2024 at 07:16:06PM +0100, Marek Marczykowski-G=C3=B3recki w=
rote:
> From: Fr=C3=A9d=C3=A9ric Pierret (fepitre) <frederic.pierret@qubes-os.org>

This shouldn't be here, it's my patch.

> When running in a stubdomain, the config space access via sysfs needs to
> use BDF as seen inside stubdomain (connected via xen-pcifront), which is
> different from the real BDF. For other purposes (hypercall parameters
> etc), the real BDF needs to be used.
> Get the in-stubdomain BDF by looking up relevant PV PCI xenstore
> entries.
>=20
> Signed-off-by: Marek Marczykowski-G=C3=B3recki <marmarek@invisiblethingsl=
ab.com>
> ---
>  hw/xen/xen-host-pci-device.c | 77 +++++++++++++++++++++++++++++++++++-
>  hw/xen/xen-host-pci-device.h |  6 +++
>  2 files changed, 82 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/xen/xen-host-pci-device.c b/hw/xen/xen-host-pci-device.c
> index 8c6e9a1716..3f8a6f84a8 100644
> --- a/hw/xen/xen-host-pci-device.c
> +++ b/hw/xen/xen-host-pci-device.c
> @@ -9,6 +9,7 @@
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
>  #include "qemu/cutils.h"
> +#include "hw/xen/xen-legacy-backend.h"
>  #include "xen-host-pci-device.h"
> =20
>  #define XEN_HOST_PCI_MAX_EXT_CAP \
> @@ -33,13 +34,76 @@
>  #define IORESOURCE_PREFETCH     0x00001000      /* No side effects */
>  #define IORESOURCE_MEM_64       0x00100000
> =20
> +static void xen_host_pci_fill_local_addr(XenHostPCIDevice *d, Error **er=
rp)
> +{
> +    unsigned int num_devs, len, i;
> +    unsigned int domain, bus, dev, func;
> +    char *be_path =3D NULL;
> +    char path[80];
> +    char *msg =3D NULL;
> +
> +    be_path =3D qemu_xen_xs_read(xenstore, 0, "device/pci/0/backend", &l=
en);
> +    if (!be_path)
> +        goto err_out;
> +    snprintf(path, sizeof(path), "%s/num_devs", be_path);
> +    msg =3D qemu_xen_xs_read(xenstore, 0, path, &len);
> +    if (!msg)
> +        goto err_out;
> +
> +    if (sscanf(msg, "%u", &num_devs) !=3D 1) {
> +        error_setg(errp, "Failed to parse %s (%s)\n", msg, path);
> +        goto err_out;
> +    }
> +    free(msg);
> +
> +    for (i =3D 0; i < num_devs; i++) {
> +        snprintf(path, sizeof(path), "%s/dev-%u", be_path, i);
> +        msg =3D qemu_xen_xs_read(xenstore, 0, path, &len);
> +        if (!msg) {
> +            error_setg(errp, "Failed to read %s\n", path);
> +            goto err_out;
> +        }
> +        if (sscanf(msg, "%x:%x:%x.%x", &domain, &bus, &dev, &func) !=3D =
4) {
> +            error_setg(errp, "Failed to parse %s (%s)\n", msg, path);
> +            goto err_out;
> +        }
> +        free(msg);
> +        if (domain !=3D d->domain ||
> +                bus !=3D d->bus ||
> +                dev !=3D d->dev ||
> +                func!=3D d->func)
> +            continue;
> +        snprintf(path, sizeof(path), "%s/vdev-%u", be_path, i);
> +        msg =3D qemu_xen_xs_read(xenstore, 0, path, &len);
> +        if (!msg) {
> +            error_setg(errp, "Failed to read %s\n", path);
> +            goto out;
> +        }
> +        if (sscanf(msg, "%x:%x:%x.%x", &domain, &bus, &dev, &func) !=3D =
4) {
> +            error_setg(errp, "Failed to parse %s (%s)\n", msg, path);
> +            goto err_out;
> +        }
> +        free(msg);
> +        d->local_domain =3D domain;
> +        d->local_bus =3D bus;
> +        d->local_dev =3D dev;
> +        d->local_func =3D func;
> +        goto out;
> +    }
> +
> +err_out:
> +    free(msg);
> +out:
> +    free(be_path);
> +}
> +
>  static void xen_host_pci_sysfs_path(const XenHostPCIDevice *d,
>                                      const char *name, char *buf, ssize_t=
 size)
>  {
>      int rc;
> =20
>      rc =3D snprintf(buf, size, "/sys/bus/pci/devices/%04x:%02x:%02x.%d/%=
s",
> -                  d->domain, d->bus, d->dev, d->func, name);
> +                  d->local_domain, d->local_bus, d->local_dev, d->local_=
func, name);
>      assert(rc >=3D 0 && rc < size);
>  }
> =20
> @@ -342,6 +406,17 @@ void xen_host_pci_device_get(XenHostPCIDevice *d, ui=
nt16_t domain,
>      d->dev =3D dev;
>      d->func =3D func;
> =20
> +    if (xen_is_stubdomain) {
> +        xen_host_pci_fill_local_addr(d, errp);
> +        if (*errp)
> +            goto error;
> +    } else {
> +        d->local_domain =3D d->domain;
> +        d->local_bus =3D d->bus;
> +        d->local_dev =3D d->dev;
> +        d->local_func =3D d->func;
> +    }
> +
>      xen_host_pci_config_open(d, errp);
>      if (*errp) {
>          goto error;
> diff --git a/hw/xen/xen-host-pci-device.h b/hw/xen/xen-host-pci-device.h
> index 4d8d34ecb0..270dcb27f7 100644
> --- a/hw/xen/xen-host-pci-device.h
> +++ b/hw/xen/xen-host-pci-device.h
> @@ -23,6 +23,12 @@ typedef struct XenHostPCIDevice {
>      uint8_t dev;
>      uint8_t func;
> =20
> +    /* different from the above in case of stubdomain */
> +    uint16_t local_domain;
> +    uint8_t local_bus;
> +    uint8_t local_dev;
> +    uint8_t local_func;
> +
>      uint16_t vendor_id;
>      uint16_t device_id;
>      uint32_t class_code;
> --=20
> 2.43.0
>=20

--=20
Best Regards,
Marek Marczykowski-G=C3=B3recki
Invisible Things Lab

--OmIj9+efoChGP1II
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhrpukzGPukRmQqkK24/THMrX1ywFAmXT1PkACgkQ24/THMrX
1yz4cgf/Rpz3Yf45EIjwMbO5QQaP8hMOP4meVWEvJ3dqrZZ52TFG+ZetC3NMLRsJ
ul0qdLLfj0T+Dm0pzkhMs8qhs6Ezr40xCx6nYbB+svICLs4SHYY1wqk14Nwg95EN
2rt8HmqPhJcKg/8mzBq00P/z2q6vmzUe519p62G7rpZIMYQ0baam4RL5YnoMMlZC
SN3h5w8fMRkN23hQ6i8o7Z/airtnUwDWr4pkvSSs7dN/0cUGvCigIQ0hieAXl2Kc
3XgLPDIxsAby3nIaep+VK5QVnH7sV29IC0Yu8pLxqfstqkwAsjEnFD8b2wdzZSZn
1WVrmSzUH2uBWqj/kAjfOYehm5nDuA==
=twIH
-----END PGP SIGNATURE-----

--OmIj9+efoChGP1II--

