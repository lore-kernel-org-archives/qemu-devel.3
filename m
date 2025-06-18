Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C94BAC7115A
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Jun 2025 10:39:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRqBg-0006FS-Ad; Wed, 18 Jun 2025 06:38:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uRqBd-0006EZ-6P; Wed, 18 Jun 2025 06:38:33 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uRqBa-0001Xz-2v; Wed, 18 Jun 2025 06:38:32 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bMgBd1f9wz6K7kc;
 Wed, 18 Jun 2025 18:36:09 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id DF06A140119;
 Wed, 18 Jun 2025 18:38:21 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 18 Jun
 2025 12:38:21 +0200
Date: Wed, 18 Jun 2025 11:38:19 +0100
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
CC: Eric Auger <eric.auger@redhat.com>, Linuxarm <linuxarm@huawei.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "ddutile@redhat.com"
 <ddutile@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>,
 "imammedo@redhat.com" <imammedo@redhat.com>, "nathanc@nvidia.com"
 <nathanc@nvidia.com>, "mochs@nvidia.com" <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>, "Wangzhou (B)"
 <wangzhou1@hisilicon.com>, jiangkunkun <jiangkunkun@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>
Subject: Re: [PATCH v4 1/7] hw/arm/smmu-common: Check SMMU has PCIe Root
 Complex association
Message-ID: <20250618113819.0000054b@huawei.com>
In-Reply-To: <49d4c4b73e9a44a783332ddfe9a2fbdf@huawei.com>
References: <20250613144449.60156-1-shameerali.kolothum.thodi@huawei.com>
 <20250613144449.60156-2-shameerali.kolothum.thodi@huawei.com>
 <20250616112019.00003bce@huawei.com>
 <fcd05844-d2d9-450e-b962-59b0f3964185@redhat.com>
 <20250617175247.00007d43@huawei.com>
 <49d4c4b73e9a44a783332ddfe9a2fbdf@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 frapeml500008.china.huawei.com (7.182.85.71)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, 18 Jun 2025 09:35:35 +0100
Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com> wrote:

> > -----Original Message-----
> > From: Jonathan Cameron <jonathan.cameron@huawei.com>
> > Sent: Tuesday, June 17, 2025 5:53 PM
> > To: Eric Auger <eric.auger@redhat.com>
> > Cc: Shameerali Kolothum Thodi
> > <shameerali.kolothum.thodi@huawei.com>; Linuxarm
> > <linuxarm@huawei.com>; qemu-arm@nongnu.org; qemu-
> > devel@nongnu.org; peter.maydell@linaro.org; jgg@nvidia.com;
> > nicolinc@nvidia.com; ddutile@redhat.com; berrange@redhat.com;
> > imammedo@redhat.com; nathanc@nvidia.com; mochs@nvidia.com;
> > smostafa@google.com; Wangzhou (B) <wangzhou1@hisilicon.com>;
> > jiangkunkun <jiangkunkun@huawei.com>; zhangfei.gao@linaro.org
> > Subject: Re: [PATCH v4 1/7] hw/arm/smmu-common: Check SMMU has PCIe
> > Root Complex association
> >=20
> > On Tue, 17 Jun 2025 09:49:54 +0200
> > Eric Auger <eric.auger@redhat.com> wrote:
> >  =20
> > > On 6/16/25 12:20 PM, Jonathan Cameron wrote: =20
> > > > On Fri, 13 Jun 2025 15:44:43 +0100
> > > > Shameer Kolothum <shameerali.kolothum.thodi@huawei.com> wrote:
> > > > =20
> > > >> Although this change does not affect functionality at present, it =
is =20
> > > > Patch title says PCIe.  This check is vs PCI host bridge.
> > > >
> > > > No idea which one you wanted, but if it is PCIe needs to be
> > > > TYPC_PCIE_HOST_BRIDGE from pcie_host.h not the pci_host.h one
> > > > I think. =20
> > > I think we need TYPE_PCI_HOST_BRIDGE as we want to check against pxb
> > >
> > > pci-bridge/pci_expander_bridge.c:=A0=A0=A0 .parent=A0=A0=A0=A0=A0=A0=
=A0 =3D =20
> > TYPE_PCI_HOST_BRIDGE,
> >=20
> > Hmm. That's awkward and I'd forgotten that wrinkle.
> > Need a stronger test but which one?  The PXB root bus has a parent of
> > TYPE_PCIE_BUS.  Maybe we can check that? =20
>=20
> Ok. How about we do something like below?
>=20
>=20
> @@ -925,6 +926,7 @@ static void smmu_base_realize(DeviceState *dev,
> Error **errp)
>  {
>      SMMUState *s =3D ARM_SMMU(dev);
>      SMMUBaseClass *sbc =3D ARM_SMMU_GET_CLASS(dev);
> +    PCIBus *pci_bus =3D s->primary_bus;
>      Error *local_err =3D NULL;
>=20
>      sbc->parent_realize(dev, &local_err);
> @@ -937,10 +939,31 @@ static void smmu_base_realize(DeviceState *dev,
> Error **errp)
>                                       g_free, g_free);
>      s->smmu_pcibus_by_busptr =3D g_hash_table_new(NULL, NULL);
>=20
> -    if (s->primary_bus) {
> -        pci_setup_iommu(s->primary_bus, &smmu_ops, s);
> -    } else {
> +    if (!pci_bus) {
>          error_setg(errp, "SMMU is not attached to any PCI bus!");
> +        return;
> +    }
> +
> +    /*
> +     * We only allow default PCIe Root Complex(pcie.0) or pxb-pcie based=
 extra
> +     * root complexes to be associated with SMMU.
> +     */
> +    if (pci_bus_is_express(pci_bus) && pci_bus_is_root(pci_bus) &&
> +        object_dynamic_cast(OBJECT(pci_bus)->parent, TYPE_PCI_HOST_BRIDG=
E)) {
> +        /*
> +         * For pxb-pcie, parent_dev will be set. Make sure it is
> +         * pxb-pcie indeed.
> +         */
> +        if (pci_bus->parent_dev) {
> +            if (!object_dynamic_cast(OBJECT(pci_bus), "pxb-pcie-bus")) {
> +                error_setg(errp, "SMMU is not attached to pxb-pcie bus!"=
);
> +                return;
> +            }
> +        }
> +        pci_setup_iommu(pci_bus, &smmu_ops, s);
> +    } else {
> +       error_setg(errp, "SMMU should be attached to a default PCIe
> root complex"
> +                  "(pcie.0) or a pxb-pcie based root complex");
>      }
>  }
>=20
> Please let me know if this is good enough or not.
LGTM

>=20
> Thanks,
> Shameer


