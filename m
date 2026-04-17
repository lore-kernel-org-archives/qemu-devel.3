Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 982AFF43688
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 09:30:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDfVk-0002na-7g; Fri, 17 Apr 2026 05:29:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1wDfVh-0002nI-CH; Fri, 17 Apr 2026 05:29:13 -0400
Received: from fhigh-a5-smtp.messagingengine.com ([103.168.172.156])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1wDfVe-000379-VG; Fri, 17 Apr 2026 05:29:13 -0400
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 75FB714000E2;
 Fri, 17 Apr 2026 05:29:07 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Fri, 17 Apr 2026 05:29:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1776418147; x=
 1776504547; bh=b4jX4ABbMpc4EjQ6DVEqZTqMVunKofDlQkZIIMRWS0I=; b=P
 gibdKu8yYWRgW2C1lI//Rwr0EyOOdzIJswszkySPxk90QGmbe/TWHVJVhQoB0InU
 /OWBg8oT6N1ZyNZVIzqaWa//psTMy9Hhzc0Yt4B+zrOisFZIPlhnDIFLwFjuQwdj
 ztEQR0tLLyJYs6Cn2ZoB1lIShHX3O/sa7M7E4qhJK8N1akQPdeEO4CHA6bkz87Iq
 1LiphwRneJi5gC6J5JGJx3RTnFKyzNokoYHN+fwiOaK7IrEmFaGC8MC2y6GF0Vzy
 QDrt9lsc8T7arKn2U7pdeagoZBjHnCc7HZRDSraclMCUVLE6crKadj2LzVxWPY6O
 MW2dBo3F1BCJbFeUx4mgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
 1776418147; x=1776504547; bh=b4jX4ABbMpc4EjQ6DVEqZTqMVunKofDlQkZ
 IIMRWS0I=; b=N/SEL9AgZAq7s+zjpaw9b8DsbFWBYW7iCnCrsZOkQyKGDtbu4ba
 XIWL4WWPqFl9k7Q6V4T/aQF1f0fgIjv59IJEAXouVRTCoH8xjRx1MKqJ3sLJP/Bs
 16ZIDCVkrUf4QcrOW42VeH55pQfM9pK5xvAsgycPWHJt6da4mND5rFeBzsWItHG4
 gJGyAicX8QP+3c6747G3DCq38Vkf0KTvP84iV9UKE3LCf7Qa1fkKRBrgYMfUc9An
 B7gEYeWAoLdVVeNJufJquVFpZs5JXrOn0/xlAHd66yOZIbgvWSXKt1GuuA4IX9wR
 RCXs3wG/b3Jx1vtYpvRwjYYVgsT1Sk34HiQ==
X-ME-Sender: <xms:Yv3haS9wy5lkzxAOCksRdom5hrlYtm4DwmMQl4KN4tZ3LOrTgcVL6w>
 <xme:Yv3hadoc7f73GmghmS13z5ulflSDBQd2B44C-H5HCkAtLIiMAWPAR7xU3bXawvZjo
 iZCLn7S4xWIfb8P33fqY6OkzsJ1aHCdgv48mXQh_qM5uGRaHB5GYIU>
X-ME-Received: <xmr:Yv3haXCb4UX3m2r71dFs4kQePzu67BjzPDsH6tnesuMNBZKYrJhsWSrAcmemYzp6JdYKcF9pgloZykMUHV5wx17WOSnhofs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegleehvdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesghdtreertd
 dtjeenucfhrhhomhepmfhlrghushculfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgr
 nhhtrdgukheqnecuggftrfgrthhtvghrnhepjefgjeefffdvuefhieefhffggfeuleehud
 ekveejvedtuddugeeigeetffffjeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
 rghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukhdpnhgspghrtg
 hpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgrthhthhhivghu
 sehmihhnihhordhiohdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurd
 horhhgpdhrtghpthhtohepqhgvmhhuqdgslhhotghksehnohhnghhnuhdrohhrghdprhgt
 phhtthhopehksghushgthheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtvghfrg
 hnhhgrsehrvgguhhgrthdrtghomhdprhgtphhtthhopehmrghtthhhihgvuhesmhhinhdr
 ihhopdhrtghpthhtohepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:Yv3hafzSw9xDzHu_5KaQOfJXjL9pkLAXgRukP3_X4vhLHUfRnJoLRQ>
 <xmx:Yv3haU0Zg-KaWCeysBUo5QaZvzl1CtHr2_OCbRCVRucOauWLd4BC2A>
 <xmx:Yv3hafxhOOL3KiEltc-WL8dYGZmd5Z9rYGgDmyIUCqsnKNkrkgT0Ig>
 <xmx:Yv3habH0Dh5HIljL9ONDwjZ1tBpQCroSMFKCVZbEH9Ap8b0J3cG59A>
 <xmx:Y_3haUatK0r67KXIIFpUwRadASHMQl5nwNblXV_FQBHvs25rCEBx5KYJ>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Apr 2026 05:29:06 -0400 (EDT)
Date: Fri, 17 Apr 2026 11:29:04 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: mr-083 <matthieu@minio.io>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, kbusch@kernel.org,
 stefanha@redhat.com, mr-083 <matthieu@min.io>
Subject: Re: [PATCH v4] hw/nvme: add namespace hotplug support
Message-ID: <aeH9YOHJjrbt6x5F@AALNPWKJENSEN.aal.scsc.local>
References: <20260409060155.94704-1-matthieu@min.io>
 <20260415173852.71135-1-matthieu@min.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="hONpm4qRd4O57Z9u"
Content-Disposition: inline
In-Reply-To: <20260415173852.71135-1-matthieu@min.io>
Received-SPF: pass client-ip=103.168.172.156; envelope-from=its@irrelevant.dk;
 helo=fhigh-a5-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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


--hONpm4qRd4O57Z9u
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Apr 15 19:38, mr-083 wrote:
> Add hotplug support for nvme-ns devices on the NvmeBus. This enables
> NVMe namespace-level hot-add and hot-remove via device_add and
> device_del with proper Asynchronous Event Notification (AEN), so the
> guest kernel can react to namespace topology changes.
>=20
> Mark nvme-ns devices as hotpluggable and register the NvmeBus as a
> hotplug handler with proper plug and unplug callbacks:
>=20
> - plug: attach namespace to all started controllers and send an
>   Asynchronous Event Notification (AEN) with NS_ATTR_CHANGED so
>   the guest kernel rescans namespaces and adds the block device
> - unplug: drain in-flight I/O, detach from all controllers, send
>   AEN, then unrealize the device. The guest kernel rescans and
>   removes the block device.
>=20
> The plug handler skips controllers that haven't started yet
> (qs_created =3D=3D false) to avoid interfering with boot-time namespace
> attachment in nvme_start_ctrl().
>=20
> The unplug handler drains in-flight I/O via nvme_ns_drain() before
> detaching the namespace from controllers, so pending requests can
> complete normally without touching freed state.
>=20
> For symmetry with nvme_ns_realize() which sets subsys->namespaces[nsid],
> nvme_ns_unrealize() now clears that slot too making the namespace
> lifecycle complete.
>=20
> Both the controller bus and subsystem bus are configured as hotplug
> handlers via qbus_set_bus_hotplug_handler() since nvme-ns devices
> may reparent to the subsystem bus during realize.
>=20
> Example hot-swap sequence using the NVMe subsystem model:
>=20
>   # Boot with: -device nvme-subsys,id=3Dsubsys0
>   #            -device nvme,id=3Dctrl0,subsys=3Dsubsys0
>   #            -device nvme-ns,id=3Dns0,drive=3Ddrv0,bus=3Dctrl0,nsid=3D1
>=20
>   device_del ns0             # guest receives AEN, removes /dev/nvme0n1
>   drive_del drv0
>   drive_add 0 file=3Ddisk.qcow2,format=3Dqcow2,id=3Ddrv0,if=3Dnone
>   device_add nvme-ns,id=3Dns0,drive=3Ddrv0,bus=3Dctrl0,nsid=3D1
>                               # guest receives AEN, adds /dev/nvme0n1
>=20
> Tested with Linux 6.1 guest (NVMe driver processes AEN and rescans
> namespace list automatically).
>=20
> Signed-off-by: Matthieu <matthieu@min.io>
> ---
>  hw/nvme/ctrl.c   | 88 ++++++++++++++++++++++++++++++++++++++++++++++++
>  hw/nvme/ns.c     |  8 +++++
>  hw/nvme/subsys.c |  2 ++
>  3 files changed, 98 insertions(+)
>=20
> diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> index be6c7028cb..2024b0ff75 100644
> --- a/hw/nvme/ctrl.c
> +++ b/hw/nvme/ctrl.c
> @@ -206,6 +206,7 @@
>  #include "system/hostmem.h"
>  #include "hw/pci/msix.h"
>  #include "hw/pci/pcie_sriov.h"
> +#include "hw/core/qdev.h"
>  #include "system/spdm-socket.h"
>  #include "migration/vmstate.h"
> =20
> @@ -9293,6 +9294,7 @@ static void nvme_realize(PCIDevice *pci_dev, Error =
**errp)
>      }
> =20
>      qbus_init(&n->bus, sizeof(NvmeBus), TYPE_NVME_BUS, dev, dev->id);
> +    qbus_set_bus_hotplug_handler(BUS(&n->bus));
> =20
>      if (nvme_init_subsys(n, errp)) {
>          return;
> @@ -9553,10 +9555,96 @@ static const TypeInfo nvme_info =3D {
>      },
>  };
> =20
> +static void nvme_ns_hot_plug(HotplugHandler *hotplug_dev, DeviceState *d=
ev,
> +                              Error **errp)
> +{
> +    NvmeNamespace *ns =3D NVME_NS(dev);
> +    NvmeSubsystem *subsys =3D ns->subsys;
> +    uint32_t nsid =3D ns->params.nsid;
> +    int i;
> +
> +    /*
> +     * Attach to all started controllers and notify via AEN.
> +     * Skip controllers that haven't started yet (boot-time realize) =E2=
=80=94
> +     * nvme_start_ctrl() will attach namespaces during controller init.
> +     */
> +    for (i =3D 0; i < NVME_MAX_CONTROLLERS; i++) {
> +        NvmeCtrl *ctrl =3D nvme_subsys_ctrl(subsys, i);
> +        if (!ctrl || !ctrl->qs_created) {
> +            continue;
> +        }
> +
> +        if (nvme_csi_supported(ctrl, ns->csi) && !ns->params.detached) {
> +            nvme_attach_ns(ctrl, ns);
> +            nvme_update_dsm_limits(ctrl, ns);
> +
> +            if (!test_and_set_bit(nsid, ctrl->changed_nsids)) {
> +                nvme_enqueue_event(ctrl, NVME_AER_TYPE_NOTICE,
> +                                   NVME_AER_INFO_NOTICE_NS_ATTR_CHANGED,
> +                                   NVME_LOG_CHANGED_NSLIST);
> +            }
> +        }
> +    }
> +}
> +
> +static void nvme_ns_hot_unplug(HotplugHandler *hotplug_dev, DeviceState =
*dev,
> +                               Error **errp)
> +{
> +    NvmeNamespace *ns =3D NVME_NS(dev);
> +    NvmeSubsystem *subsys =3D ns->subsys;
> +    uint32_t nsid =3D ns->params.nsid;
> +    int i;
> +
> +    /*
> +     * Drain in-flight I/O before tearing down the namespace.
> +     * This must happen while the namespace is still attached to the
> +     * controllers so any pending requests can complete normally.
> +     */
> +    nvme_ns_drain(ns);
> +
> +    /*
> +     * Detach from all controllers and notify the guest via AEN.
> +     * The guest kernel will rescan namespaces and remove the block devi=
ce.
> +     */
> +    for (i =3D 0; i < NVME_MAX_CONTROLLERS; i++) {
> +        NvmeCtrl *ctrl =3D nvme_subsys_ctrl(subsys, i);
> +        if (!ctrl || !nvme_ns(ctrl, nsid)) {
> +            continue;
> +        }
> +
> +        nvme_detach_ns(ctrl, ns);
> +        nvme_update_dsm_limits(ctrl, NULL);
> +
> +        if (!test_and_set_bit(nsid, ctrl->changed_nsids)) {
> +            nvme_enqueue_event(ctrl, NVME_AER_TYPE_NOTICE,
> +                               NVME_AER_INFO_NOTICE_NS_ATTR_CHANGED,
> +                               NVME_LOG_CHANGED_NSLIST);
> +        }
> +    }
> +
> +    /*
> +     * Unrealize: removes from subsystem (in nvme_ns_unrealize), flushes,
> +     * cleans up structures, and removes from QOM.
> +     */
> +    qdev_unrealize(dev);
> +}
> +
> +static void nvme_bus_class_init(ObjectClass *klass, const void *data)
> +{
> +    HotplugHandlerClass *hc =3D HOTPLUG_HANDLER_CLASS(klass);
> +    hc->plug =3D nvme_ns_hot_plug;
> +    hc->unplug =3D nvme_ns_hot_unplug;
> +}
> +
>  static const TypeInfo nvme_bus_info =3D {
>      .name =3D TYPE_NVME_BUS,
>      .parent =3D TYPE_BUS,
>      .instance_size =3D sizeof(NvmeBus),
> +    .class_init =3D nvme_bus_class_init,
> +    .interfaces =3D (const InterfaceInfo[]) {
> +        { TYPE_HOTPLUG_HANDLER },
> +        { }
> +    },
>  };
> =20
>  static void nvme_register_types(void)
> diff --git a/hw/nvme/ns.c b/hw/nvme/ns.c
> index b0106eaa5c..f4f755c6fc 100644
> --- a/hw/nvme/ns.c
> +++ b/hw/nvme/ns.c
> @@ -719,10 +719,17 @@ void nvme_ns_cleanup(NvmeNamespace *ns)
>  static void nvme_ns_unrealize(DeviceState *dev)
>  {
>      NvmeNamespace *ns =3D NVME_NS(dev);
> +    NvmeSubsystem *subsys =3D ns->subsys;
> +    uint32_t nsid =3D ns->params.nsid;
> =20
>      nvme_ns_drain(ns);
>      nvme_ns_shutdown(ns);
>      nvme_ns_cleanup(ns);
> +
> +    /* Symmetric with nvme_ns_realize() which sets subsys->namespaces[ns=
id]. */
> +    if (subsys && nsid && subsys->namespaces[nsid] =3D=3D ns) {
> +        subsys->namespaces[nsid] =3D NULL;
> +    }
>  }
> =20
>  void nvme_ns_atomic_configure_boundary(bool dn, uint16_t nabsn,
> @@ -937,6 +944,7 @@ static void nvme_ns_class_init(ObjectClass *oc, const=
 void *data)
>      dc->bus_type =3D TYPE_NVME_BUS;
>      dc->realize =3D nvme_ns_realize;
>      dc->unrealize =3D nvme_ns_unrealize;
> +    dc->hotpluggable =3D true;
>      device_class_set_props(dc, nvme_ns_props);
>      dc->desc =3D "Virtual NVMe namespace";
>  }
> diff --git a/hw/nvme/subsys.c b/hw/nvme/subsys.c
> index 777e1c620f..fa35055d3c 100644
> --- a/hw/nvme/subsys.c
> +++ b/hw/nvme/subsys.c
> @@ -9,6 +9,7 @@
>  #include "qemu/osdep.h"
>  #include "qemu/units.h"
>  #include "qapi/error.h"
> +#include "hw/core/qdev.h"
> =20
>  #include "nvme.h"
> =20
> @@ -205,6 +206,7 @@ static void nvme_subsys_realize(DeviceState *dev, Err=
or **errp)
>      NvmeSubsystem *subsys =3D NVME_SUBSYS(dev);
> =20
>      qbus_init(&subsys->bus, sizeof(NvmeBus), TYPE_NVME_BUS, dev, dev->id=
);
> +    qbus_set_bus_hotplug_handler(BUS(&subsys->bus));
> =20
>      nvme_subsys_setup(subsys, errp);
>  }
> --=20
> 2.53.0
>=20
>=20

As an out-of-band mechanism to hot-plug namespaces, this looks good.

Reviewed-by: Klaus Jensen <k.jensen@samsung.com>

I'll pick it up for 11.1. Thanks!

--hONpm4qRd4O57Z9u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmnh/V0ACgkQTeGvMW1P
DemDuwf/W+m/tZfTZaStSXxxrlFB1xvx3ipA/2yt1Q/ga21eXvTuCL3ZUTGTOjk5
w4fljUogIAMnZaI4wYS2RvzCOVv87dlh1rfx5enfSf9xfYw2Fg+aIkoC1k8YQ0OS
Kne4/3oGyr7mrxadYDQJ8+Q57mWNH4gxtkB36rZDOB9m36L5OuhTq2HDKL3B4ER9
ukHlnOyCjSjRPK35Shf2f3tXro0k73PAW3b7xnwxi/NfMwBC6rkAsS6R23IazJps
KR5rXFTwogK76Vw4uNe1JX45EEoKL7n9CQE1sOL1UKay3FF2dsj+4U/GYPwZfufh
OCZDJPBgiNynpaxVgHDg9PXA/fX90g==
=BidM
-----END PGP SIGNATURE-----

--hONpm4qRd4O57Z9u--

