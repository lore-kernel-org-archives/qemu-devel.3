Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DD3AC83F22
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 10:49:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubdDZ-0007Nt-MM; Tue, 15 Jul 2025 06:49:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1ubdDV-0007Lb-N2; Tue, 15 Jul 2025 06:48:57 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1ubdDT-0006jk-L6; Tue, 15 Jul 2025 06:48:57 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bhG9R4ndcz6L559;
 Tue, 15 Jul 2025 18:47:39 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 1C24F1402EB;
 Tue, 15 Jul 2025 18:48:47 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 15 Jul
 2025 12:48:46 +0200
Date: Tue, 15 Jul 2025 11:48:44 +0100
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 <linuxarm@huawei.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <jgg@nvidia.com>, <nicolinc@nvidia.com>,
 <ddutile@redhat.com>, <berrange@redhat.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>,
 <shameerkolothum@gmail.com>
Subject: Re: [RFC PATCH v3 14/15] Read and validate host SMMUv3 feature bits
Message-ID: <20250715114844.00001714@huawei.com>
In-Reply-To: <20250714155941.22176-15-shameerali.kolothum.thodi@huawei.com>
References: <20250714155941.22176-1-shameerali.kolothum.thodi@huawei.com>
 <20250714155941.22176-15-shameerali.kolothum.thodi@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
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

On Mon, 14 Jul 2025 16:59:40 +0100
Shameer Kolothum <shameerali.kolothum.thodi@huawei.com> wrote:

> From: Nicolin Chen <nicolinc@nvidia.com>
>=20
> Not all fields in the SMMU IDR registers are meaningful for userspace.
> Only the following fields can be used:
>=20
> =A0 - IDR0: ST_LEVEL, TERM_MODEL, STALL_MODEL, TTENDIAN, CD2L, ASID16, TT=
F =A0
> =A0 - IDR1: SIDSIZE, SSIDSIZE =A0
> =A0 - IDR3: BBML, RIL =A0
> =A0 - IDR5: VAX, GRAN64K, GRAN16K, GRAN4K
>=20
> Use the relevant fields from these to check whether the host and emulated
> SMMUv3 features are sufficiently aligned to enable accelerated SMMUv3
> support.
>=20
> To retrieve this information from the host, at least one vfio-pci device
> must be assigned with "arm-smmuv3,accel=3Don" usage. Add a check to enfor=
ce
> this.
>=20
> Note:
>=20
> ATS, PASID, and PRI features are currently not supported. Only devices
> that do not require or make use of these features are expected to work.
>=20
> Also, requiring at least one vfio-pci device to be cold-plugged
> complicates hot-unplug and replug scenarios. For example, if all devices
> behind the vSMMUv3 are unplugged after the guest boots, and a new device
> is later hot-plugged into the same PCI bus, there is no guarantee that
> the underlying host SMMUv3 will expose the same feature set as the one
> originally used when the vSMMU was initialized.
>=20
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
=3D
> +
> +void smmuv3_accel_init_regs(SMMUv3State *s)
> +{
> +    SMMUv3AccelState *s_accel =3D s->s_accel;
> +    SMMUv3AccelDevice *accel_dev;
> +    uint32_t data_type;
> +    uint32_t val;
> +    int ret;
> +
> +    if (s_accel->info.idr[0]) {
> +        /* We already got this */
> +        return;
> +    }
> +
> +    if (!s_accel->viommu || QLIST_EMPTY(&s_accel->viommu->device_list)) {
> +        error_report("For arm-smmuv3,accel=3Don case, atleast one cold-p=
lugged "
> +                     "vfio-pci dev needs to be assigned");
> +        goto out_err;
> +    }
> +
> +    accel_dev =3D QLIST_FIRST(&s_accel->viommu->device_list);
> +    ret =3D smmuv3_accel_host_hw_info(accel_dev, &data_type,
> +                                    sizeof(s_accel->info), &s_accel->inf=
o);
> +    if (ret) {
> +        error_report("Failed to get Host SMMU device info");
> +        goto out_err;
> +    }
> +
> +    if (data_type !=3D IOMMU_HW_INFO_TYPE_ARM_SMMUV3) {
> +        error_report("Wrong data type (%d) for Host SMMU device info",
> +                     data_type);
> +        goto out_err;
> +    }
> +
> +    trace_smmuv3_accel_host_hw_info(s_accel->info.idr[0], s_accel->info.=
idr[1],
> +                                    s_accel->info.idr[3], s_accel->info.=
idr[5]);
> +    /*
> +     * QEMU SMMUv3 supports both linear and 2-level stream tables. If ho=
st
> +     * SMMUv3 supports only linear stream table, report that to Guest.
> +     */
> +    val =3D FIELD_EX32(s_accel->info.idr[0], IDR0, STLEVEL);
> +    if (val < FIELD_EX32(s->idr[0], IDR0, STLEVEL)) {
> +        s->idr[0] =3D FIELD_DP32(s->idr[0], IDR0, STLEVEL, val);
> +    }
> +
> +    /*
> +     * QEMU SMMUv3 supports little-endian support for translation table =
walks.
> +     * If host SMMUv3 supports only big-endian, report error.
> +     */
> +    val =3D FIELD_EX32(s_accel->info.idr[0], IDR0, TTENDIAN);
> +    if (val > FIELD_EX32(s->idr[0], IDR0, TTENDIAN)) {
> +        error_report("Host SUUMU device translation table walk endianess=
 "
> +                     "not supported");
> +        goto out_err;
> +    }
> +
> +    /*
> +     * QEMU SMMUv3 supports AArch64 Translation table format.
> +     * If host SMMUv3 supports only AArch32, report error.
> +     */
> +    val =3D FIELD_EX32(s_accel->info.idr[0], IDR0, TTF);
> +    if (val < FIELD_EX32(s->idr[0], IDR0, TTF)) {
> +        error_report("Host SMMU device Translation table format not supp=
orted");
> +        goto out_err;
> +    }
> +
> +    /*
> +     * QEMU SMMUv3 supports 4K/16K/64K translation granules. If host SMM=
Uv3
> +     * does't support any of these, report the supported ones only to Gu=
est.
> +     */
> +    val =3D FIELD_EX32(s_accel->info.idr[5], IDR5, GRAN4K);
> +    if (val < FIELD_EX32(s->idr[5], IDR5, GRAN4K)) {
> +        s->idr[5] =3D FIELD_DP32(s->idr[5], IDR5, GRAN4K, val);
> +    }
> +    val =3D FIELD_EX32(s_accel->info.idr[5], IDR5, GRAN16K);
> +    if (val < FIELD_EX32(s->idr[5], IDR5, GRAN16K)) {
> +        s->idr[5] =3D FIELD_DP32(s->idr[5], IDR5, GRAN16K, val);
> +    }
> +    val =3D FIELD_EX32(s_accel->info.idr[5], IDR5, GRAN64K);
> +    if (val < FIELD_EX32(s->idr[5], IDR5, GRAN64K)) {
> +        s->idr[5] =3D FIELD_DP32(s->idr[5], IDR5, GRAN64K, val);
> +    }
> +    return;
> +
> +out_err:
> +    exit(1);

Maybe just do this at each error path rather than goto?
Makes it clear that the result is brutal.


> +}
> +
>  static void
>  smmuv3_accel_dev_uninstall_nested_ste(SMMUv3AccelDevice *accel_dev, bool=
 abort)
>  {


> diff --git a/hw/arm/trace-events b/hw/arm/trace-events
> index 7d232ca17c..37ecab10a0 100644
> --- a/hw/arm/trace-events
> +++ b/hw/arm/trace-events
> @@ -70,7 +70,7 @@ smmu_reset_exit(void) ""
>  smmuv3_accel_set_iommu_device(int devfn, uint32_t sid) "devfn=3D0x%x (si=
d=3D0x%x)"
>  smmuv3_accel_unset_iommu_device(int devfn, uint32_t sid) "devfn=3D0x%x (=
sid=3D0x%x"
>  smmuv3_accel_install_nested_ste(uint32_t sid, uint64_t ste_1, uint64_t s=
te_0) "sid=3D%d ste=3D%"PRIx64":%"PRIx64
> -

Stray

> +smmuv3_accel_host_hw_info(uint32_t idr0, uint32_t idr1, uint32_t idr3, u=
int32_t idr5) "idr0=3D0x%x idr1=3D0x%x idr3=3D0x%x idr5=3D0x%x"
>  # strongarm.c
>  strongarm_uart_update_parameters(const char *label, int speed, char pari=
ty, int data_bits, int stop_bits) "%s speed=3D%d parity=3D%c data=3D%d stop=
=3D%d"
>  strongarm_ssp_read_underrun(void) "SSP rx underrun"


