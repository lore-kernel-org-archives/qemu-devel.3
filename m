Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A48EC282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 08:39:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tu5zi-0006lD-Ij; Mon, 17 Mar 2025 04:38:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1tu5zd-0006jO-UW; Mon, 17 Mar 2025 04:38:41 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1tu5za-0006d0-EK; Mon, 17 Mar 2025 04:38:41 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZGSwQ2sCmz6K9Rl;
 Mon, 17 Mar 2025 16:35:34 +0800 (CST)
Received: from frapeml100005.china.huawei.com (unknown [7.182.85.132])
 by mail.maildlp.com (Postfix) with ESMTPS id 4BD2C1402CC;
 Mon, 17 Mar 2025 16:38:23 +0800 (CST)
Received: from frapeml500008.china.huawei.com (7.182.85.71) by
 frapeml100005.china.huawei.com (7.182.85.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 17 Mar 2025 09:38:23 +0100
Received: from frapeml500008.china.huawei.com ([7.182.85.71]) by
 frapeml500008.china.huawei.com ([7.182.85.71]) with mapi id 15.01.2507.039;
 Mon, 17 Mar 2025 09:38:23 +0100
To: Nicolin Chen <nicolinc@nvidia.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>, "nathanc@nvidia.com"
 <nathanc@nvidia.com>, "mochs@nvidia.com" <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>, Linuxarm <linuxarm@huawei.com>,
 "Wangzhou (B)" <wangzhou1@hisilicon.com>, jiangkunkun
 <jiangkunkun@huawei.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>
Subject: RE: [RFC PATCH v2 09/20] hw/arm/smmuv3-accel: Add
 set/unset_iommu_device callback
Thread-Topic: [RFC PATCH v2 09/20] hw/arm/smmuv3-accel: Add
 set/unset_iommu_device callback
Thread-Index: AQHbko+8wiD7SHKG706r955lSVgcbrNuXVGAgAiscFA=
Date: Mon, 17 Mar 2025 08:38:23 +0000
Message-ID: <8fbdb07be20a43bf8281143720a0c10e@huawei.com>
References: <20250311141045.66620-1-shameerali.kolothum.thodi@huawei.com>
 <20250311141045.66620-10-shameerali.kolothum.thodi@huawei.com>
 <Z9CmE2oc55lxzW+q@Asurada-Nvidia>
In-Reply-To: <Z9CmE2oc55lxzW+q@Asurada-Nvidia>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.203.177.241]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=shameerali.kolothum.thodi@huawei.com;
 helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
From:  Shameerali Kolothum Thodi via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Nicolin,

> -----Original Message-----
> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Tuesday, March 11, 2025 9:08 PM
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> Cc: qemu-arm@nongnu.org; qemu-devel@nongnu.org;
> eric.auger@redhat.com; peter.maydell@linaro.org; jgg@nvidia.com;
> ddutile@redhat.com; berrange@redhat.com; nathanc@nvidia.com;
> mochs@nvidia.com; smostafa@google.com; Linuxarm
> <linuxarm@huawei.com>; Wangzhou (B) <wangzhou1@hisilicon.com>;
> jiangkunkun <jiangkunkun@huawei.com>; Jonathan Cameron
> <jonathan.cameron@huawei.com>; zhangfei.gao@linaro.org
> Subject: Re: [RFC PATCH v2 09/20] hw/arm/smmuv3-accel: Add
> set/unset_iommu_device callback
>=20
> On Tue, Mar 11, 2025 at 02:10:34PM +0000, Shameer Kolothum wrote:
> > @@ -30,6 +32,185 @@ static SMMUv3AccelDevice
> *smmuv3_accel_get_dev(SMMUState *s, SMMUPciBus *sbus,
> >      return accel_dev;
> >  }
> >
> > +static bool
> > +smmuv3_accel_dev_attach_viommu(SMMUv3AccelDevice *accel_dev,
> > +                               HostIOMMUDeviceIOMMUFD *idev, Error **e=
rrp)
>=20
> With vEVENTQ v9, vDEVICE (vSID) is required to attach a device
> to a proxy NESTED hwpt (applicable to bypass/abort HWPTs too).
> So, host_iommu_device_iommufd_attach_hwpt() would fail in this
> function because vSID isn't ready at this stage. So all those
> calls should be moved out of the function, then this should be
> likely "smmuv3_accel_dev_alloc_viommu"?
>=20
> That being said, I don't know when QEMU actually prepare a BDF
> number for a vfio-pci device. The only place that I see it is
> ready is at guest-level SMMU installing the Stream Table, i.e.
> in smmuv3_accel_install_nested_ste().
>=20
> > +{
> > +    struct iommu_hwpt_arm_smmuv3 bypass_data =3D {
> > +        .ste =3D { 0x9ULL, 0x0ULL },
> > +    };
> > +    struct iommu_hwpt_arm_smmuv3 abort_data =3D {
> > +        .ste =3D { 0x1ULL, 0x0ULL },
> > +    };
> > +    SMMUDevice *sdev =3D &accel_dev->sdev;
> > +    SMMUState *s =3D sdev->smmu;
> > +    SMMUv3AccelState *s_accel =3D ARM_SMMUV3_ACCEL(s);
> > +    SMMUS2Hwpt *s2_hwpt;
> > +    SMMUViommu *viommu;
> > +    uint32_t s2_hwpt_id;
> > +    uint32_t viommu_id;
> > +
> > +    if (s_accel->viommu) {
> > +        accel_dev->viommu =3D s_accel->viommu;
> > +        return host_iommu_device_iommufd_attach_hwpt(
> > +                       idev, s_accel->viommu->s2_hwpt->hwpt_id, errp);
>=20
> Yea, here is my bad. We shouldn't attach a device to s2_hwpt,
> since eventually s2_hwpt would be a shared hwpt across SMMUs.
>=20
> > +    /* Attach to S2 for MSI cookie */
> > +    if (!host_iommu_device_iommufd_attach_hwpt(idev, s2_hwpt_id,
> errp)) {
> > +        goto free_s2_hwpt;
> > +    }
>=20
> With the merged sw_msi series, we don't need this anymore.
>=20
> > +    /*
> > +     * Attach the bypass STE which means S1 bypass and S2 translate.
> > +     * This is to make sure that the vIOMMU object is now associated
> > +     * with the device and has this STE installed in the host SMMUV3.
> > +     */
> > +    if (!host_iommu_device_iommufd_attach_hwpt(
> > +                idev, viommu->bypass_hwpt_id, errp)) {
> > +        error_report("failed to attach the bypass pagetable");
> > +        goto free_bypass_hwpt;
> > +    }
>=20
> Ditto. We have to postpone this until vdevice is allocated.

Ok.  I will take a look based on the  vEVENTQ v9 series.
I guess this Qemu branch of yours is a more representative of the changes d=
escribed
above?
https://github.com/nicolinc/qemu/tree/wip/for_iommufd_veventq-v9

Right?

Thanks,
Shameer

> > +static void smmuv3_accel_unset_iommu_device(PCIBus *bus, void
> *opaque,
> > +                                            int devfn)
> > +{
> > +    SMMUDevice *sdev;
> > +    SMMUv3AccelDevice *accel_dev;
> > +    SMMUViommu *viommu;
> > +    SMMUState *s =3D opaque;
> > +    SMMUv3AccelState *s_accel =3D ARM_SMMUV3_ACCEL(s);
> > +    SMMUPciBus *sbus =3D g_hash_table_lookup(s-
> >smmu_pcibus_by_busptr, bus);
> > +
> > +    if (!sbus) {
> > +        return;
> > +    }
> > +
> > +    sdev =3D sbus->pbdev[devfn];
> > +    if (!sdev) {
> > +        return;
> > +    }
> > +
> > +    accel_dev =3D container_of(sdev, SMMUv3AccelDevice, sdev);
> > +    if (!host_iommu_device_iommufd_attach_hwpt(accel_dev->idev,
> > +                                               accel_dev->idev->ioas_i=
d,
> > +                                               NULL)) {
> > +        error_report("Unable to attach dev to the default HW pagetable=
");
> > +    }
> > +
> > +
>=20
> Could drop the extra line.
>=20
> Thanks
> Nicolin

