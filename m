Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98642D29C2E
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 14:06:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhptc-000403-Vp; Mon, 19 Jan 2026 09:06:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vhptT-0003q1-Ba
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 09:06:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vhptR-0006XS-A3
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 09:06:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768831567;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+ICCTMnjrU73v4nBR3EVR2zTSJwnG39AXJqrZBQY8Hg=;
 b=ZYWPdRQ55FUk4rRCwetD7nB7DoxJ/gqQQQoKpSibT7NS1IzsGzBHV1YKQIPRI4hlsmql0B
 ZmvXi+vkjkimKwu3ABOdHWR3aQv5Wx0DzL5/KcuaQaOuzc0ibdPk7IvD5m2+HFVNxLDhpk
 7myXNQjOHe8Eq/wbAyMZ+DhqH7d6kNg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-GcwhHdsDMM-fbLWEfdRf0Q-1; Mon, 19 Jan 2026 09:06:05 -0500
X-MC-Unique: GcwhHdsDMM-fbLWEfdRf0Q-1
X-Mimecast-MFC-AGG-ID: GcwhHdsDMM-fbLWEfdRf0Q_1768831564
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-430fd96b2f5so4322616f8f.3
 for <qemu-devel@nongnu.org>; Mon, 19 Jan 2026 06:06:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768831564; x=1769436364;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+ICCTMnjrU73v4nBR3EVR2zTSJwnG39AXJqrZBQY8Hg=;
 b=XJt9KjOI8j1jxEc/DUnz5xYhoB/P7dsxDqgKYwhRxm3q0tCG8F37XTri+VRypCkPiH
 igCc0FgSKEKq4BJXxpbQXEHL7o0imvFDblRj2Dlj3wpPsfWLiJy4+4bh1VWCnbwBvyNU
 pQENlk+/gvaibkydQOi4xp3bd5mRGnf54FJcRz0yT+inzDT+NnD2fKlKPJgT5gnr2Bt5
 9kmlecWTBbHtX5qlSXwEdHxujZ0soPgfi/W2gRw0xWPaS0/v9zzyhtQvoz/+yyD4jtsC
 Yby7wwJD0a7Qz2TRJquqNVr74K0BZ0LZ+pMgpuvOewXP+RIU4kJ2if0S/XnlkZAHRkkF
 yDTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAM+ulJ2+19UQLudvIVMs/DzUMV3DO4s4m9xEZE8sIv9KoPE3wNEs7XnZbZsmANyRu0keJgK81OH/K@nongnu.org
X-Gm-Message-State: AOJu0YypcUx6HseC5T+PkAo+hHWuxMSRRVTjUrmNoxTMxNlbdfO3epkn
 W4bITXfcc37gF0sR8POWZmnnBDeA3amuKdgqU6jsU2B+egrcAmOgsC7KrAUJgCFVITjLMzabxer
 30VIfkM/N41pBucUJV2jVefljHNZWE6qqbuDJllCRYYEnQPwx0+ihieKL
X-Gm-Gg: AZuq6aJFiN7aoM/vORENAbxsppIPyKn7qTgp4dbH3CrAqU9FymCM8+fKN3Z7Um5fQyr
 5y/kkCJ3spDSf7w7NHp2oUATIfGXX+Ol7LmnSye59HSwPCC9tOjDx81L2DRqXx75761C2Ya9EYx
 t89hfGYTAgjm0yJb3TG1ph9kWsMSviE1pvynyjcjBxUQPUi2j0Mml5zI86OHfv6MTdSMqPjBK06
 +ScUv2Cg59BuVa+fnBPDICUvvsJxvq8ebGc4po1p/Mmd1n/kKHSdV3VqgcDQF+a+zi8o3trUW85
 eOXByI4fQDhFyqD92yhdN6mm7oI/4QL3vaexIJaCAPzs+rJ+RuUmXT6aCONb3f6/AH/7BQ386+3
 2CM9Rwp/MqbYFmK9mXMjFojPiGDN/sFwE+SS3DWjyooWLx38usk/X79vm2Q==
X-Received: by 2002:a05:6000:26d1:b0:430:f494:6aad with SMTP id
 ffacd0b85a97d-4356996f2damr13625928f8f.2.1768831564076; 
 Mon, 19 Jan 2026 06:06:04 -0800 (PST)
X-Received: by 2002:a05:6000:26d1:b0:430:f494:6aad with SMTP id
 ffacd0b85a97d-4356996f2damr13625859f8f.2.1768831563547; 
 Mon, 19 Jan 2026 06:06:03 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43569926648sm24210514f8f.10.2026.01.19.06.06.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Jan 2026 06:06:03 -0800 (PST)
Message-ID: <45e53597-9117-4d68-b7e5-d80e5f28bc12@redhat.com>
Date: Mon, 19 Jan 2026 15:06:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 32/36] backends/iommufd: Add get_pasid_info() callback
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jgg@nvidia.com, nicolinc@nvidia.com,
 ddutile@redhat.com, berrange@redhat.com, clg@redhat.com, alex@shazbot.org,
 nathanc@nvidia.com, mochs@nvidia.com, smostafa@google.com,
 wangzhou1@hisilicon.com, jiangkunkun@huawei.com,
 jonathan.cameron@huawei.com, zhangfei.gao@linaro.org,
 zhenzhong.duan@intel.com, yi.l.liu@intel.com, kjaju@nvidia.com
References: <20260111195508.106943-1-skolothumtho@nvidia.com>
 <20260111195508.106943-33-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260111195508.106943-33-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.016,
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



On 1/11/26 8:53 PM, Shameer Kolothum wrote:
> The get_pasid_info callback retrieves PASID capability information
> when the HostIOMMUDevice backend supports it. Currently, only the
> Linux IOMMUFD backend provides this information.
>
> This will be used by a subsequent patch to synthesize a PASID
> capability for vfio-pci devices behind a vIOMMU that supports PASID.
>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  backends/iommufd.c                 | 17 +++++++++++++++++
>  include/system/host_iommu_device.h | 15 +++++++++++++++
>  2 files changed, 32 insertions(+)
>
> diff --git a/backends/iommufd.c b/backends/iommufd.c
> index 6381f9664b..f1707eadc6 100644
> --- a/backends/iommufd.c
> +++ b/backends/iommufd.c
> @@ -538,11 +538,28 @@ static int hiod_iommufd_get_cap(HostIOMMUDevice *hiod, int cap, Error **errp)
>      }
>  }
>  
> +static bool hiod_iommufd_get_pasid_info(HostIOMMUDevice *hiod,
> +                                        PasidInfo *pasid_info)
> +{
> +    HostIOMMUDeviceCaps *caps = &hiod->caps;
> +
> +    if (!caps->max_pasid_log2) {
> +        return false;
> +    }
> +
> +    g_assert(pasid_info);
> +    pasid_info->exec_perm = (caps->hw_caps & IOMMU_HW_CAP_PCI_PASID_EXEC);
> +    pasid_info->priv_mod = (caps->hw_caps & IOMMU_HW_CAP_PCI_PASID_PRIV);
> +    pasid_info->max_pasid_log2 = caps->max_pasid_log2;
> +    return true;
> +}
> +
>  static void hiod_iommufd_class_init(ObjectClass *oc, const void *data)
>  {
>      HostIOMMUDeviceClass *hioc = HOST_IOMMU_DEVICE_CLASS(oc);
>  
>      hioc->get_cap = hiod_iommufd_get_cap;
> +    hioc->get_pasid_info = hiod_iommufd_get_pasid_info;
>  };
>  
>  static const TypeInfo types[] = {
> diff --git a/include/system/host_iommu_device.h b/include/system/host_iommu_device.h
> index bfb2b60478..4fbada638f 100644
> --- a/include/system/host_iommu_device.h
> +++ b/include/system/host_iommu_device.h
> @@ -59,6 +59,12 @@ struct HostIOMMUDevice {
>  #endif
>  };
>  
> +typedef struct PasidInfo {
> +    bool exec_perm;
> +    bool priv_mod;
> +    uint8_t max_pasid_log2;
> +} PasidInfo;
> +
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
> +     * @pasid_info: If success, returns the PASID related information.
> +     *
> +     * Returns: true on success, false on failure.
> +     */
> +    bool (*get_pasid_info)(HostIOMMUDevice *hiod, PasidInfo *pasid_info);
>  };
>  
>  /*


