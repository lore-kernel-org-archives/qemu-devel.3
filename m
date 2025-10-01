Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26CD9CAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 13:54:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3xGp-0001mt-8B; Wed, 01 Oct 2025 09:53:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1v3xGP-0001Uj-Nn; Wed, 01 Oct 2025 09:53:02 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1v3xGL-00058Y-9E; Wed, 01 Oct 2025 09:53:01 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ccGZf6Mf3z67K2K;
 Wed,  1 Oct 2025 21:52:26 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
 by mail.maildlp.com (Postfix) with ESMTPS id 407F114014C;
 Wed,  1 Oct 2025 21:52:44 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 1 Oct
 2025 14:52:43 +0100
Date: Wed, 1 Oct 2025 14:52:41 +0100
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <jgg@nvidia.com>, <nicolinc@nvidia.com>,
 <ddutile@redhat.com>, <berrange@redhat.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <shameerkolothum@gmail.com>
Subject: Re: [PATCH v4 25/27] backends/iommufd: Add a callback helper to
 retrieve PASID support
Message-ID: <20251001145241.00005265@huawei.com>
In-Reply-To: <20250929133643.38961-26-skolothumtho@nvidia.com>
References: <20250929133643.38961-1-skolothumtho@nvidia.com>
 <20250929133643.38961-26-skolothumtho@nvidia.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.203.177.15]
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 dubpeml100005.china.huawei.com (7.214.146.113)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-to:  Jonathan Cameron <jonathan.cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, 29 Sep 2025 14:36:41 +0100
Shameer Kolothum <skolothumtho@nvidia.com> wrote:

> Subsequent patch=A0will make use of this to add a PASID CAP for assigned =
devices.
>=20
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>

Trivial stuff.
> ---
>  backends/iommufd.c                 |  9 +++++++++
>  include/system/host_iommu_device.h | 12 ++++++++++++
>  2 files changed, 21 insertions(+)
>=20
> diff --git a/backends/iommufd.c b/backends/iommufd.c
> index 023e67bc46..0ff46a5747 100644
> --- a/backends/iommufd.c
> +++ b/backends/iommufd.c
> @@ -523,6 +523,14 @@ bool host_iommu_device_iommufd_detach_hwpt(HostIOMMU=
DeviceIOMMUFD *idev,
>      return idevc->detach_hwpt(idev, errp);
>  }
> =20
> +static uint8_t hiod_iommufd_get_pasid(HostIOMMUDevice *hiod, uint64_t *h=
w_caps)
> +{
> +    HostIOMMUDeviceCaps *caps =3D &hiod->caps;
> +
> +    *hw_caps =3D caps->hw_caps;
> +    return caps->max_pasid_log2;
> +}
> +
>  static int hiod_iommufd_get_cap(HostIOMMUDevice *hiod, int cap, Error **=
errp)
>  {
>      HostIOMMUDeviceCaps *caps =3D &hiod->caps;
> @@ -543,6 +551,7 @@ static void hiod_iommufd_class_init(ObjectClass *oc, =
const void *data)
>      HostIOMMUDeviceClass *hioc =3D HOST_IOMMU_DEVICE_CLASS(oc);
> =20
>      hioc->get_cap =3D hiod_iommufd_get_cap;
> +    hioc->get_pasid =3D hiod_iommufd_get_pasid;
>  };
> =20
>  static const TypeInfo types[] =3D {
> diff --git a/include/system/host_iommu_device.h b/include/system/host_iom=
mu_device.h
> index c6a2a3899a..3773c54977 100644
> --- a/include/system/host_iommu_device.h
> +++ b/include/system/host_iommu_device.h
> @@ -115,6 +115,18 @@ struct HostIOMMUDeviceClass {
>       * @hiod: handle to the host IOMMU device
>       */
>      uint64_t (*get_page_size_mask)(HostIOMMUDevice *hiod);
> +    /**
> +     * @get_pasid: Get PASID support information along this
> +     *             @hiod Host IOMMU device
> +     * Optional callback. If not implemented, PASID not supported
> +     *
> +     * @hiod: handle to the host IOMMU device
> +     *
> +     * @out_hw_caps: Output the generic iommu capability info which incl=
udes
> +     *               device PASID CAP info

Blank line here to match local style.

> +     * Returns the width of PASIDs. Zero means no PASID support
      * Returns: width of PASIDs. ...
to match other comments in this file. I only checked a few of them
so maybe this style is there somewhere as well.

> +     */
> +     uint8_t (*get_pasid)(HostIOMMUDevice *hiod, uint64_t *out_hw_caps);
>  };
> =20
>  /*


