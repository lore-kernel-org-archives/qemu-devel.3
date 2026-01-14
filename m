Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43CD0D29FEC
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 11:23:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfyy6-0005m6-LM; Wed, 14 Jan 2026 06:23:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vfyy5-0005ku-Hi; Wed, 14 Jan 2026 06:23:17 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vfyy4-0006DF-3p; Wed, 14 Jan 2026 06:23:17 -0500
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4drkHf12BtzHnHJ3;
 Wed, 14 Jan 2026 19:22:54 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
 by mail.maildlp.com (Postfix) with ESMTPS id EDDFF40570;
 Wed, 14 Jan 2026 19:23:13 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Wed, 14 Jan
 2026 11:23:12 +0000
Date: Wed, 14 Jan 2026 11:23:11 +0000
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <jgg@nvidia.com>, <nicolinc@nvidia.com>,
 <ddutile@redhat.com>, <berrange@redhat.com>, <clg@redhat.com>,
 <alex@shazbot.org>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <smostafa@google.com>, <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>,
 <kjaju@nvidia.com>
Subject: Re: [PATCH v7 32/36] backends/iommufd: Add get_pasid_info() callback
Message-ID: <20260114112311.00005102@huawei.com>
In-Reply-To: <20260111195508.106943-33-skolothumtho@nvidia.com>
References: <20260111195508.106943-1-skolothumtho@nvidia.com>
 <20260111195508.106943-33-skolothumtho@nvidia.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.15]
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 dubpeml100005.china.huawei.com (7.214.146.113)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Jonathan Cameron <jonathan.cameron@huawei.com>
From:  Jonathan Cameron via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sun, 11 Jan 2026 19:53:18 +0000
Shameer Kolothum <skolothumtho@nvidia.com> wrote:

> The get_pasid_info callback retrieves PASID capability information
> when the HostIOMMUDevice backend supports it. Currently, only the
> Linux IOMMUFD backend provides this information.
> 
> This will be used by a subsequent patch to synthesize a PASID
> capability for vfio-pci devices behind a vIOMMU that supports PASID.
> 
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Hi Shameer,

Trivial missing parameter docs comment below.  Assuming you just duplicate
the equivalent docs from just above:

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

J
> diff --git a/include/system/host_iommu_device.h b/include/system/host_iommu_device.h
> index bfb2b60478..4fbada638f 100644
> --- a/include/system/host_iommu_device.h
> +++ b/include/system/host_iommu_device.h
...
>  /**
>   * struct HostIOMMUDeviceClass - The base class for all host IOMMU devices.
>   *
> @@ -116,6 +122,15 @@ struct HostIOMMUDeviceClass {
>       * @hiod: handle to the host IOMMU device
>       */
>      uint64_t (*get_page_size_mask)(HostIOMMUDevice *hiod);
> +    /**
> +     * @get_pasid_info: Return the PASID information associated with the Host
> +     * IOMMU device.
> +     *

Feels like it should be complete and say what hiod is as well (see call above).

> +     * @pasid_info: If success, returns the PASID related information.
> +     *
> +     * Returns: true on success, false on failure.
> +     */
> +    bool (*get_pasid_info)(HostIOMMUDevice *hiod, PasidInfo *pasid_info);
>  };
>  
>  /*


