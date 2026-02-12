Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E9EAEDF052
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 08:04:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqRfe-00041i-Tp; Thu, 12 Feb 2026 03:03:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vqRfa-00040c-6e
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 03:03:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vqRfS-0007k8-TH
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 03:03:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770883397;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=00brVmmSJcPvEvgIpSoQzqKA+OK+OzeU9BZ9N+B5lb4=;
 b=eDlEB/TAFcTESpcKrMGO/MxDmVDKIWJ+kD2iMkZS1DQgzKN59f19+aTsPJPmXbD5bQvWVX
 uvvWrEQQVdC3kzPUGsvXQ95U++VhH+lF8dJSo6QowZDpDuis3zxPK3j5Z1xJyN4sxtFhTk
 f7qYQWtPZg/ON/5ZcfWDN6Jxo+w9fFE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-4SBqHNsRM1OjMH1uNhSvQg-1; Thu, 12 Feb 2026 03:03:16 -0500
X-MC-Unique: 4SBqHNsRM1OjMH1uNhSvQg-1
X-Mimecast-MFC-AGG-ID: 4SBqHNsRM1OjMH1uNhSvQg_1770883395
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-4376ec2b1cfso3357476f8f.0
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 00:03:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770883395; x=1771488195;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=00brVmmSJcPvEvgIpSoQzqKA+OK+OzeU9BZ9N+B5lb4=;
 b=ksHy7aOsyjmcfYrnpxmKXsvdS7xKtYIVsa671CDl1adAF2aIlQn1lT+iNLqAXbDMME
 nSeKRdM4MvpokscvcN0sCyGlm93g6UxHYoJp/MZnJNjxx5nIwh5FenV71nynfrDPgdxr
 JsspAMcYgQmwjKwE31MVgFLjJO3YBBpmt7lhVMMYLjdqsU2SU7Lgn0KcFCRrfSakoCfl
 Z81fmLh2tp4vixduhWZN0xl8RD6DYWdu8SCTT+6MTWIHv2yuqrjdDvjuCyc1ztdX67qP
 vCueLtBGuH/P8HfiUJVWPW1NK+6HooB8IYr80NgqeRJj+YX+eKAk/AqBe+kO+lzHafOH
 z4TA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRplTM7I/9bUsTHZjJwXoH3dyLfF7ydqB8kOywTS9sMjF5R0YQ5H/EGd9GCpKTQ93QMVQ2IpXsTu63@nongnu.org
X-Gm-Message-State: AOJu0YxOVJUnxCwVIVLjy6lkjiHSqpw82XLn5RuGMCViI03UjYFMqi1H
 5D8f5Mr7uUX9pEIrZb59/tGoQIieL+ySEgke/Yiy35/R/9NbtCHKk3EVz1ywsryBWnZWwc6DI5o
 Xtws5MHllHAlKrRDUt3u3VrTw8UCvWy9YNsEbReYDuWBHrkwjdYnTPalf
X-Gm-Gg: AZuq6aKgKc2LTxdzwlHqvSfEt5gWd3G03tnz08HqX5F7R+qKYDZFJ/Ax0yLWRe2ENPM
 bUHvrZ7jeNYzNEVLk8y9FJzCpEBzIUEllSK1JyA7/BT+j82g/8hUmXrMjFmRzKmeGI1IixyBb1w
 MISEI76alLSdWxkMCkUqf066cm7J5MO8zfxvtq9hC7rfX9r13LS5zy3xJBKGP1vr5n4tjPESvi1
 fK1iN4l5cv5zzvWc+DRnGu99ut5gt+dk2gRbT5WnjA0f7evCxVWMqkyCLQq3j9qPTMSoeMgI3c3
 xKNQKcPeSVqQtBiNOOGXU0NZFSiWU9sRYIASZAQAkOYlu9imOf5HZqh3BK55Sh24GwLqOYMuTrC
 /n9fLK+zb/6FXUmvDfErK6GN+SKoMUOnw+A60v2siPG8q5jopVgJmrBAA5RnwqFW6SJaSeA==
X-Received: by 2002:a05:6000:615:b0:435:e451:2f93 with SMTP id
 ffacd0b85a97d-4378acbd1f9mr3259678f8f.60.1770883394852; 
 Thu, 12 Feb 2026 00:03:14 -0800 (PST)
X-Received: by 2002:a05:6000:615:b0:435:e451:2f93 with SMTP id
 ffacd0b85a97d-4378acbd1f9mr3259625f8f.60.1770883394401; 
 Thu, 12 Feb 2026 00:03:14 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43783b09b99sm10372872f8f.0.2026.02.12.00.03.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Feb 2026 00:03:13 -0800 (PST)
Message-ID: <2a134bcc-240a-4169-b1e9-25dcfcc0f892@redhat.com>
Date: Thu, 12 Feb 2026 09:03:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/24] backends/iommufd: Update
 iommufd_backend_get_device_info
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, clg@redhat.com, alex@shazbot.org,
 nicolinc@nvidia.com, nathanc@nvidia.com, mochs@nvidia.com, jan@nvidia.com,
 jgg@nvidia.com, jonathan.cameron@huawei.com, zhangfei.gao@linaro.org,
 zhenzhong.duan@intel.com, kjaju@nvidia.com
References: <20260206144823.80655-1-skolothumtho@nvidia.com>
 <20260206144823.80655-2-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260206144823.80655-2-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Shameer, Nicolin,

On 2/6/26 3:48 PM, Shameer Kolothum wrote:
> From: Nicolin Chen <nicolinc@nvidia.com>
>
> The updated IOMMUFD uAPI introduces the ability for userspace to request
> a specific hardware info data type via IOMMU_GET_HW_INFO. Update
> iommufd_backend_get_device_info() to set IOMMU_HW_INFO_FLAG_INPUT_TYPE
> when a non-zero type is supplied, and adjust all callers to pass a type
> value explicitly initialised to zero (IOMMU_HW_INFO_TYPE_DEFAULT) when
> no specific type is requested.
>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>  backends/iommufd.c    | 7 +++++++
>  hw/arm/smmuv3-accel.c | 2 +-
>  hw/vfio/iommufd.c     | 4 ++--
>  3 files changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/backends/iommufd.c b/backends/iommufd.c
> index acfab907c0..5daefe505e 100644
> --- a/backends/iommufd.c
> +++ b/backends/iommufd.c
> @@ -387,16 +387,23 @@ bool iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be,
>      return true;
>  }
>  
> +/*
> + * @type can carry a desired HW info type defined in the uapi headers. If caller
> + * doesn't have one, indicating it wants the default type, then @type should be
> + * zeroed (i.e. IOMMU_HW_INFO_TYPE_DEFAULT).
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
> index beffb8aa94..14ea4eac37 100644
> --- a/hw/arm/smmuv3-accel.c
> +++ b/hw/arm/smmuv3-accel.c
> @@ -127,7 +127,7 @@ smmuv3_accel_hw_compatible(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
>                             Error **errp)
>  {
>      struct iommu_hw_info_arm_smmuv3 info;
> -    uint32_t data_type;
> +    uint32_t data_type = 0;
I would use IOMMU_HW_INFO_TYPE_DEFAULT explicitly.
>      uint64_t caps;
>  
>      if (!iommufd_backend_get_device_info(idev->iommufd, idev->devid, &data_type,
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index 131612eb83..d0f124300d 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -349,7 +349,7 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>      ERRP_GUARD();
>      IOMMUFDBackend *iommufd = vbasedev->iommufd;
>      VFIOContainer *bcontainer = VFIO_IOMMU(container);
> -    uint32_t type, flags = 0;
> +    uint32_t type = 0, flags = 0;
>      uint64_t hw_caps;
>      VendorCaps caps;
>      VFIOIOASHwpt *hwpt;
> @@ -938,7 +938,7 @@ static bool hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
>      HostIOMMUDeviceIOMMUFD *idev;
>      HostIOMMUDeviceCaps *caps = &hiod->caps;
>      VendorCaps *vendor_caps = &caps->vendor_caps;
> -    enum iommu_hw_info_type type;
> +    enum iommu_hw_info_type type = 0;
here also

With that

Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric



>      uint8_t max_pasid_log2;
>      uint64_t hw_caps;
>  


