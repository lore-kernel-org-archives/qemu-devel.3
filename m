Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5DD7EFCD99
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 11:10:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzYUR-00022A-DG; Mon, 09 Mar 2026 07:09:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vzYUQ-00021h-06
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 07:09:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vzYUO-0004GE-6y
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 07:09:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773054571;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YRd8RDCobWzkOIL/55dBZ6Bma4Lf5yyWSHcJ6UJrR3A=;
 b=FkmXjem3uiqq9lcS0mLc4nrF6C9ALH6Yv6Cod3XwhYIKc1dqeMVTVRd3uQKkmxJBh9FPNI
 Vc57Gz6x2M+24cPomJ5gsw2U4LcjaU5/odwRB7rDOdo4yWnWjF+ArWCL9OU4CWHldQPRZU
 aqzjKQGkbndbf5PHVGM1c5mMyZm7ZNA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-359-DkoH2RpsP1OVu96d8TAEqQ-1; Mon, 09 Mar 2026 07:09:29 -0400
X-MC-Unique: DkoH2RpsP1OVu96d8TAEqQ-1
X-Mimecast-MFC-AGG-ID: DkoH2RpsP1OVu96d8TAEqQ_1773054569
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-439beddef55so6116738f8f.0
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 04:09:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773054568; x=1773659368;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YRd8RDCobWzkOIL/55dBZ6Bma4Lf5yyWSHcJ6UJrR3A=;
 b=XDvZqphkBMwEYijSngnRWrs8KUtuA/EnO15u9868lZB+db0aQ0Ca+mfoPPvWMNjse+
 vdVOqd1izwwsidxbF/NHpYLRlWmOHqQBw9z9di2zNdDGjAJCvrf9/ngMgDApuhJxXFwj
 /wj7R9gdLuTtj+W92BvS9uqzS1M1PoDQnD0qrtkhlJgi2rS20BRcSLDnfd2yjGuUQlaL
 KSbtj+4BHwcuBekWkHTUHT70VT4I+QxoqMaKd7xMwFjs0e8PS9VB1fWHhSxNFSYDO+pX
 k8nuBABVh8ppxCniQI8sktc4NiTmE9lcpb2FtdPTZki2RW/5mG9X2FM+bWdCd4nTPTs8
 9xEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYlE0wHH7L7Y4CAUfFlT2GyBnS4ZQOo3FSGJaxh/SC4UGFNKcS8HWo2eYvoIz2DXlcU6inrJaXpPw/@nongnu.org
X-Gm-Message-State: AOJu0YzjTh0fmYIuIWCnH0xb6ARuMacm+5z73J/wqF/O1Urxj8UglVRn
 oC6QdgL53YvKrZ5ETQs1FCKzRsgx9Rz9D4u+VFgBvz7Gw3yD2VGc7+ZqmP+IT6dzASbXpbC4N7J
 oJr/tgpbu3XKsQDPdfHMj6lsCOpbtf/onT6wQ+Zy41vuTDmpSg4qI2wpC
X-Gm-Gg: ATEYQzz2jNrd74gS6P2cEQnwuRe19kS0GJtrcCnEu5SCXG9s0DX3zr32MuBOz6WT4r6
 77si9Q1HjoyNTHXLArjdZxB2UEXMqIZhERtvGTtVEzxroCiECTeEdY7SbAFT9G6Br9np6A+aD67
 J1G7cE11JDoUvS96CTAyrtrEZY3hZH+4+HoGV/G0/eyNy50vhratuOm9iuFbSh2Tic3BGkO7u+a
 hmuPCu0+l25djp/kgrmfRb8BX/JegN0x5LM8E0nuC34qtvwivH7eypxCk9fQIBGzhAW21BeIvyA
 U2zM98/Cwss2amfiq4PIvfcJzdH2zCWfpjrF4jCg2w3S9gwBS5kzlPBdpgmANTIy6vb54l0HcbR
 x2ma0kI341HGvAkudVouaCT1gkg7eZb4d+90IIhGey4KqBn8NJz/BE/KSBOkvw9Cn0bpyuA==
X-Received: by 2002:a05:600c:500d:b0:47e:e48b:506d with SMTP id
 5b1f17b1804b1-4852695b9f7mr179766605e9.16.1773054568502; 
 Mon, 09 Mar 2026 04:09:28 -0700 (PDT)
X-Received: by 2002:a05:600c:500d:b0:47e:e48b:506d with SMTP id
 5b1f17b1804b1-4852695b9f7mr179766265e9.16.1773054568075; 
 Mon, 09 Mar 2026 04:09:28 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4853f9f82a7sm24560715e9.10.2026.03.09.04.09.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Mar 2026 04:09:27 -0700 (PDT)
Message-ID: <ed5ca420-94e5-4e9e-a2c3-f59eb6ea8ada@redhat.com>
Date: Mon, 9 Mar 2026 12:09:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 13/32] hw/arm/tegra241-cmdqv: Implement CMDQV vIOMMU
 alloc/free
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, clg@redhat.com, alex@shazbot.org,
 nicolinc@nvidia.com, nathanc@nvidia.com, mochs@nvidia.com, jan@nvidia.com,
 jgg@nvidia.com, jonathan.cameron@huawei.com, zhangfei.gao@linaro.org,
 zhenzhong.duan@intel.com, kjaju@nvidia.com, phrdina@redhat.com
References: <20260226105056.897-1-skolothumtho@nvidia.com>
 <20260226105056.897-14-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260226105056.897-14-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 2/26/26 11:50 AM, Shameer Kolothum wrote:
> From: Nicolin Chen <nicolinc@nvidia.com>
>
> Replace the stub implementation with real vIOMMU allocation for
> Tegra241 CMDQV.
>
> Free the vIOMMU ID on teardown.
>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>  hw/arm/tegra241-cmdqv.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
>
> diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
> index 6959766129..d487612ba2 100644
> --- a/hw/arm/tegra241-cmdqv.c
> +++ b/hw/arm/tegra241-cmdqv.c
> @@ -25,14 +25,29 @@ static void tegra241_cmdqv_write(void *opaque, hwaddr offset, uint64_t value,
>  
>  static void tegra241_cmdqv_free_viommu(SMMUv3State *s)
>  {
> +    SMMUv3AccelState *accel = s->s_accel;
> +    IOMMUFDViommu *viommu = accel->viommu;
> +
> +    if (!viommu) {
> +        return;
> +    }
> +    iommufd_backend_free_id(viommu->iommufd, viommu->viommu_id);
>  }
>  
>  static bool
>  tegra241_cmdqv_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
>                              uint32_t *out_viommu_id, Error **errp)
>  {
> -    error_setg(errp, "NVIDIA Tegra241 CMDQV is unsupported");
> -    return false;
> +    Tegra241CMDQV *cmdqv = s->s_accel->cmdqv;
> +
> +    if (!iommufd_backend_alloc_viommu(idev->iommufd, idev->devid,
> +                                      IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV,
if the only think that differs compared to no cmdq is the type, ie.

IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV vs IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV

+ passing true args, maybe you can just record the type of the cmdqv that is being used in the smmu_accel device. Then you can get rid of alloc and free

Eric


> +                                      idev->hwpt_id, &cmdqv->cmdqv_data,
> +                                      sizeof(cmdqv->cmdqv_data), out_viommu_id,
> +                                      errp)) {
> +        return false;
> +    }
> +    return true;
>  }
>  
>  static void tegra241_cmdqv_reset(SMMUv3State *s)


