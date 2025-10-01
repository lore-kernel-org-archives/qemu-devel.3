Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB5AECCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 13:52:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3xEI-0000iL-Ff; Wed, 01 Oct 2025 09:50:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1v3xEE-0000gy-8t; Wed, 01 Oct 2025 09:50:46 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1v3xE2-0004iP-SE; Wed, 01 Oct 2025 09:50:43 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ccGSN6ff8z6M4Gw;
 Wed,  1 Oct 2025 21:47:00 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
 by mail.maildlp.com (Postfix) with ESMTPS id 59B6B140114;
 Wed,  1 Oct 2025 21:50:09 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 1 Oct
 2025 14:50:08 +0100
Date: Wed, 1 Oct 2025 14:50:06 +0100
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <jgg@nvidia.com>, <nicolinc@nvidia.com>,
 <ddutile@redhat.com>, <berrange@redhat.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <shameerkolothum@gmail.com>
Subject: Re: [PATCH v4 24/27] backends/iommufd: Retrieve PASID width from
 iommufd_backend_get_device_info()
Message-ID: <20251001145006.00001837@huawei.com>
In-Reply-To: <20250929133643.38961-25-skolothumtho@nvidia.com>
References: <20250929133643.38961-1-skolothumtho@nvidia.com>
 <20250929133643.38961-25-skolothumtho@nvidia.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
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

On Mon, 29 Sep 2025 14:36:40 +0100
Shameer Kolothum <skolothumtho@nvidia.com> wrote:

Bring the bit of the description in the title down here as well.
Depending on what tools people use for browsing git it might
end up in very different places on their screen.

> And store it in HostIOMMUDeviceCaps for later use.
> 
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Trivial comment inline.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> ---
>  backends/iommufd.c                 | 6 +++++-
>  hw/arm/smmuv3-accel.c              | 3 ++-
>  hw/vfio/iommufd.c                  | 7 +++++--
>  include/system/host_iommu_device.h | 2 ++
>  include/system/iommufd.h           | 3 ++-
>  5 files changed, 16 insertions(+), 5 deletions(-)

...

> diff --git a/include/system/host_iommu_device.h b/include/system/host_iommu_device.h
> index ab849a4a82..c6a2a3899a 100644
> --- a/include/system/host_iommu_device.h
> +++ b/include/system/host_iommu_device.h
> @@ -29,6 +29,7 @@ typedef union VendorCaps {
>   *
>   * @hw_caps: host platform IOMMU capabilities (e.g. on IOMMUFD this represents
>   *           the @out_capabilities value returned from IOMMU_GET_HW_INFO ioctl)

Blank line here to match local style. 

> + * @max_pasid_log2: width of PASIDs supported by host IOMMU device
>   *
>   * @vendor_caps: host platform IOMMU vendor specific capabilities (e.g. on
>   *               IOMMUFD this represents a user-space buffer filled by kernel
> @@ -37,6 +38,7 @@ typedef union VendorCaps {
>  typedef struct HostIOMMUDeviceCaps {
>      uint32_t type;
>      uint64_t hw_caps;
> +    uint8_t max_pasid_log2;
>      VendorCaps vendor_caps;
>  } HostIOMMUDeviceCaps;
>  #endif
> diff --git a/include/system/iommufd.h b/include/system/iommufd.h
> index e852193f35..d3efcffc45 100644
> --- a/include/system/iommufd.h
> +++ b/include/system/iommufd.h
> @@ -71,7 +71,8 @@ int iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas_id,
>                                hwaddr iova, ram_addr_t size);
>  bool iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t devid,
>                                       uint32_t *type, void *data, uint32_t len,
> -                                     uint64_t *caps, Error **errp);
> +                                     uint64_t *caps, uint8_t *pasid_log2,
> +                                     Error **errp);
>  bool iommufd_backend_alloc_hwpt(IOMMUFDBackend *be, uint32_t dev_id,
>                                  uint32_t pt_id, uint32_t flags,
>                                  uint32_t data_type, uint32_t data_len,


