Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EEC0F44855
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 12:42:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBBB1-0002Ib-TC; Fri, 10 Apr 2026 08:41:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wBBB0-0002Hq-5j
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 08:41:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wBBAy-0007Rs-03
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 08:41:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775824890;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OkFro9RzyLlMJ1jNDT8zK4zo475sncVAQoU2I6wG3yk=;
 b=KU6YhQB6erdEJwlVSQ+P58OUeBUzFKpXBDE4EsPrLtPjf+iXuRhAIWrVTE86Nqd5/Am0ze
 lC40iAnIGJ18OyfFVAV30C3593Rmwl/7DzfGS+qVyA3kz3yKgW0WpyLaMpSjbYhArmoYGG
 GD/p28Ui6zzYPVlqE9NACsaSxa3bixE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-668-5VEcGlopPG26FGig9nsY0g-1; Fri,
 10 Apr 2026 08:41:27 -0400
X-MC-Unique: 5VEcGlopPG26FGig9nsY0g-1
X-Mimecast-MFC-AGG-ID: 5VEcGlopPG26FGig9nsY0g_1775824885
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2E52919560AA; Fri, 10 Apr 2026 12:41:25 +0000 (UTC)
Received: from localhost (unknown [10.44.33.180])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8F5C93000C16; Fri, 10 Apr 2026 12:41:23 +0000 (UTC)
Date: Fri, 10 Apr 2026 08:41:21 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: mr-083 <matthieu@minio.io>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, its@irrelevant.dk,
 kbusch@kernel.org, mr-083 <matthieu@min.io>
Subject: Re: [PATCH v2] hw/nvme: add namespace hotplug support
Message-ID: <20260410124121.GA485553@fedora>
References: <20260409060155.94704-1-matthieu@min.io>
 <20260409213454.5186-1-matthieu@min.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="MjL36GCxI9d0/xOb"
Content-Disposition: inline
In-Reply-To: <20260409213454.5186-1-matthieu@min.io>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 7
X-Spam_score: 0.7
X-Spam_bar: /
X-Spam_report: (0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--MjL36GCxI9d0/xOb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 09, 2026 at 11:34:51PM +0200, mr-083 wrote:
> Add hotplug support for nvme-ns devices on the NvmeBus. This enables
> namespace-level hot-swap without removing the NVMe controller, matching
> the behavior of physical NVMe drives hot-swapped in the same PCIe slot.

If we rely purely on NVMe's AEN then this is not equivalent to swapping
physical drives in the same PCIe slot. Maybe adjust the wording to
reflect that this is NVMe-level Namespace hotplug?

> Mark nvme-ns devices as hotpluggable and register the NvmeBus as a
> hotplug handler with proper plug and unplug callbacks:
>=20
> - plug: attach namespace to all started controllers and send an
>   Asynchronous Event Notification (AEN) with NS_ATTR_CHANGED so
>   the guest kernel rescans namespaces and adds the block device
> - unplug: detach from all controllers, send AEN, remove from
>   subsystem, then unrealize the device. The guest kernel rescans
>   and removes the block device.
>=20
> The plug handler skips controllers that haven't started yet
> (qs_created =3D=3D false) to avoid interfering with boot-time namespace
> attachment in nvme_start_ctrl().
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

Did you test a Windows Server guest? If not, I can try that next week in
case there are any surprises.

>=20
> Signed-off-by: Matthieu Receveur <matthieu@min.io>
> ---
>  hw/nvme/ctrl.c   | 85 ++++++++++++++++++++++++++++++++++++++++++++++++
>  hw/nvme/ns.c     |  1 +
>  hw/nvme/subsys.c |  2 ++
>  3 files changed, 88 insertions(+)
>=20
> diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> index be6c7028cb..5502e4ea2b 100644
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
> @@ -9553,10 +9555,93 @@ static const TypeInfo nvme_info =3D {
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

While there is qdev_unrealize -> nvme_ns_unrealize -> nvme_ns_drain ->
blk_drain to quiesce I/O requests at the end of this function, I wonder
whether it's safe to start removing the namespace before I/O has been
drained.

Did you test hot unplug while the Namespace is under heavy I/O (e.g. fio
job running inside the guest with lots of queued I/O requests)?

It might be necessary to stop I/O first before tearing down the
namespace.

> +
> +    /*
> +     * Detach from all controllers and notify the guest via AEN.
> +     * Must happen before unrealize to avoid use-after-free when the
> +     * guest sends I/O to a freed namespace.
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
> +    /* Remove from subsystem namespace list. */
> +    subsys->namespaces[nsid] =3D NULL;

The dual of this operation is done in nvme_ns_realize():

  subsys->namespaces[nsid] =3D ns;

Maybe nvme_ns_unrealize() should remove the namespace from the
subsystem for consistency? I guess the lack of removal was never an
issue before hot unplug, but now it would be nice to implement the
lifecycle.

> +
> +    /*
> +     * Unrealize: drain I/O, flush, cleanup structures, remove from QOM.
> +     * nvme_ns_unrealize() handles drain/shutdown/cleanup internally.
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
> index b0106eaa5c..eb628c0734 100644
> --- a/hw/nvme/ns.c
> +++ b/hw/nvme/ns.c
> @@ -937,6 +937,7 @@ static void nvme_ns_class_init(ObjectClass *oc, const=
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

--MjL36GCxI9d0/xOb
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmnY7/AACgkQnKSrs4Gr
c8hlnQgAoGM24bM8QP8yecuDLkruRcLp+NHWgy0zQWP/nJZkxPzZS9NZ5DTKIXQX
BPXgASo20o/+jKbCmbhZqD2Gq7T9sTm0IDpWJXnACuF/pGO+b/Ia8ooKRP+Yqtj5
SO1F7x64Qmdf/huIJl6b7A5PtbT64oHv/3zNIxfyl8+xcX7sytG7hgsq0lrt8lPX
hiFWX48NFFDGLL1YUXUg8T2lN9r47JFjG4ecjxxgwSW5BdS2WQ9gjDsSMnqBeaq9
rS2MduBq1u8mh9tGWGwp9sYVlfiNOLLt7lPEyFergih7PAa39zU2JBx57vh6+wm3
tHo93KPAkh18dSBHcH8s6DLQBkM9VQ==
=J7TG
-----END PGP SIGNATURE-----

--MjL36GCxI9d0/xOb--


