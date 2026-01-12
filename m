Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEB21C9EC92
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 13:31:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfHyL-0002Fw-19; Mon, 12 Jan 2026 08:28:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vfHxf-0001iK-10
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 08:28:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vfHxX-0004Od-Gd
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 08:27:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768224469;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IkQLIYIMTVaiFwsNKy6GJzEudKYpIPfVHLm3IK7wXlQ=;
 b=ZVfL9gkUhQN6NNMlxbDydzLkvr2k1zGhSJ+mR7QpkNSPPW9RxTrp6Vff2+hamGUjgoBbxV
 Arf6cCLwmT/4/qctlG8RquuM0kxImkSDfkFackooNnXVHR0H5gTgMpJatGcAgh46E7qhkm
 s/aBsVq7DjLcWIxTDQFromznueRNDKE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-464-f2JPn4hHOWa5x1-DT6G7Zw-1; Mon, 12 Jan 2026 08:27:48 -0500
X-MC-Unique: f2JPn4hHOWa5x1-DT6G7Zw-1
X-Mimecast-MFC-AGG-ID: f2JPn4hHOWa5x1-DT6G7Zw_1768224467
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-430fb8d41acso4186474f8f.1
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 05:27:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768224467; x=1768829267;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IkQLIYIMTVaiFwsNKy6GJzEudKYpIPfVHLm3IK7wXlQ=;
 b=NTMbG/nnWJcCrasZD0nTiTDE6VcMi5eyROswlRrheCpIrvbiqYs1wytZ8X5DXRRsdn
 D2m8WErQhvYuxxo4h85uUfJHKbh8Ibi4EyZTUk2VaIT6Sv4uZ0AN4XpgfszX2jLzx/dk
 x2EePC/EPbib0HOj732FSBwnRZlDx5UHx/km0iAa2yXqFJ7P85y3zK3OxNyT7elfqUod
 7j2ceZKhDlbGeYfKYYZtfRGCSdeVbOSMLEJqs6IcE6U3pw8aXlnRarBa1RaIJcAp35JP
 tVHI/itokTD8v0fLuejEI1gLtSRQwcLaC9mPmbigFJgmxZMumtPJzWms2sekww04bFhL
 qIyg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgAPa1/Z2yKSjvK0LQUXsKMUCmkuHVQN3FsK43cRuDhwICsLCWuhqrgVHtx8N8fBM3Xg1M9ZolgdWh@nongnu.org
X-Gm-Message-State: AOJu0YwsOXREXMEiGZ6hWgQrvMIiCq3QXXWhTm33ZXElBQQX0L4YZSt4
 jfv+m4Rz7frcq402HTlsaYVT0lOJoIha1K5+vEmjpQSD/B0IOGfbXrEhlk9XxY1Bw0HNHOp290q
 2NZ7R9R6EomHW9GhbNDHmub/gqEjoV0gSwnA0tGhZlgfZFnw/VRTIrSHD
X-Gm-Gg: AY/fxX4FbQP1VTz6I9gRJ5Va7AvX9g9HSwMmXQ+fJHDxPJSCQWPsIyKjL2fZMaGR0Fq
 ls2Wl44SdDuw4260uF9SyW7bT0ETzDRqCJYxE3HxBBHKwQ6dEsrh9HsWfJSvKzPLrcdBOC9L2wl
 MogqIlrsMSB8URo3sf/u/nFW5Q7Am2Tv6YnafAPsl+zGmKjOklfApHTF3lS1egmvVmqXmPsxyWX
 HAqlUz9levH9EUJeFzGKJ2W6DLi1jFcl6oKJIzfpfzrDi3q6ty/J5AJBUnDG7NxZoryoehApp+X
 ahAp+4MI1V7c7Gv5S1ES1aKCA60B4UFqeNlz3OiqoFcbvzCiphl15Vh+nfWLWs1ZD71S6hVvt6C
 iD48N9YVkqXuk1Y67jTe5u1L4HAnIsdEoDTZKguiQm225Fft/bNh8RRuT5g==
X-Received: by 2002:a5d:5f90:0:b0:430:fd84:317a with SMTP id
 ffacd0b85a97d-432c374ff3emr20064443f8f.38.1768224467340; 
 Mon, 12 Jan 2026 05:27:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGW/I+s/ftCE4oAIcqgBWEMpCNRSN4gh37UhmvzjQW8fIlll22Vcqk6sgS4i0ZLBpL7l+hmfg==
X-Received: by 2002:a5d:5f90:0:b0:430:fd84:317a with SMTP id
 ffacd0b85a97d-432c374ff3emr20064415f8f.38.1768224466903; 
 Mon, 12 Jan 2026 05:27:46 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0dacc5sm38550879f8f.5.2026.01.12.05.27.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Jan 2026 05:27:46 -0800 (PST)
Message-ID: <8bfbd034-1798-46af-a549-c9c966ed09cf@redhat.com>
Date: Mon, 12 Jan 2026 14:27:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 01/16] backends/iommufd: Update
 iommufd_backend_get_device_info
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, nicolinc@nvidia.com, nathanc@nvidia.com,
 mochs@nvidia.com, jgg@nvidia.com, jonathan.cameron@huawei.com,
 zhangfei.gao@linaro.org, zhenzhong.duan@intel.com, kjaju@nvidia.com
References: <20251210133737.78257-1-skolothumtho@nvidia.com>
 <20251210133737.78257-2-skolothumtho@nvidia.com>
Content-Language: en-US
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20251210133737.78257-2-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Shameer,

On 12/10/25 2:37 PM, Shameer Kolothum wrote:
> From: Nicolin Chen <nicolinc@nvidia.com>

I would suggest to be more explicit in the commit title like:
Convey input type in iommufd_backend_get_device_info()

>
> The updated IOMMUFD uAPI introduces the ability for userspace to request
> a specific hardware info data type via IOMMU_GET_HW_INFO. Update
> iommufd_backend_get_device_info() to set IOMMU_HW_INFO_FLAG_INPUT_TYPE
> when a non-zero type is supplied, and adjust all callers to pass an
> explicitly initialised type value.
>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>  backends/iommufd.c    | 7 +++++++
>  hw/arm/smmuv3-accel.c | 2 +-
>  hw/vfio/iommufd.c     | 6 ++----
>  3 files changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/backends/iommufd.c b/backends/iommufd.c
> index 633aecd525..938c8fe669 100644
> --- a/backends/iommufd.c
> +++ b/backends/iommufd.c
> @@ -386,16 +386,23 @@ bool iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be,
>      return true;
>  }
>  
> +/*
> + * @type can carry a desired HW info type defined in the uapi headers. If caller
> + * doesn't have one, indicating it wants the default type, then @type should be
> + * zeroed (i.e. IOMMU_HW_INFO_TYPE_DEFAULT).
the kernel uapi doc is a bit ambiguous as it is said:
 * @flags: Must be 0
while a flag value does exist. 
> + */
>  bool iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t devid,
>                                       uint32_t *type, void *data, uint32_t len,
>                                       uint64_t *caps, uint8_t *max_pasid_log2,
>                                       Error **errp)
>  {
>      struct iommu_hw_info info = {
> +        .flags = (*type) ? IOMMU_HW_INFO_FLAG_INPUT_TYPE : 0,
>          .size = sizeof(info),
>          .dev_id = devid,
>          .data_len = len,
>          .data_uptr = (uintptr_t)data,
> +        .in_data_type = *type,
>      };
>  
>      if (ioctl(be->fd, IOMMU_GET_HW_INFO, &info)) {
> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> index d320c62b04..300c35ccb5 100644
> --- a/hw/arm/smmuv3-accel.c
> +++ b/hw/arm/smmuv3-accel.c
> @@ -115,7 +115,7 @@ smmuv3_accel_hw_compatible(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
>                             Error **errp)
>  {
>      struct iommu_hw_info_arm_smmuv3 info;
> -    uint32_t data_type;
> +    uint32_t data_type = 0;
>      uint64_t caps;
>  
>      if (!iommufd_backend_get_device_info(idev->iommufd, idev->devid, &data_type,
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index bbe944d7cc..670bdfc53b 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -306,7 +306,7 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>      ERRP_GUARD();
>      IOMMUFDBackend *iommufd = vbasedev->iommufd;
>      VFIOContainer *bcontainer = VFIO_IOMMU(container);
> -    uint32_t type, flags = 0;
> +    uint32_t type = 0, flags = 0;
>      uint64_t hw_caps;
>      VFIOIOASHwpt *hwpt;
>      uint32_t hwpt_id;
> @@ -631,8 +631,6 @@ skip_ioas_alloc:
>      bcontainer->initialized = true;
>  
>  found_container:
> -    vbasedev->cpr.ioas_id = container->ioas_id;
> -
indeed looks unrelated to that patch
>      ret = ioctl(devfd, VFIO_DEVICE_GET_INFO, &dev_info);
>      if (ret) {
>          error_setg_errno(errp, errno, "error getting device info");
> @@ -889,7 +887,7 @@ static bool hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
>      HostIOMMUDeviceIOMMUFD *idev;
>      HostIOMMUDeviceCaps *caps = &hiod->caps;
>      VendorCaps *vendor_caps = &caps->vendor_caps;
> -    enum iommu_hw_info_type type;
> +    enum iommu_hw_info_type type = 0;
>      uint8_t max_pasid_log2;
>      uint64_t hw_caps;
>  
Besides
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Thanks

Eric


