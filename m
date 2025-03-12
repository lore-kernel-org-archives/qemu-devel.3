Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7531C28B28
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 17:11:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsPc0-0006e1-GU; Wed, 12 Mar 2025 13:11:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tsPbt-0006We-Br
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 13:11:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tsPbo-0001JW-Ea
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 13:11:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741799465;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nlETL8ZVYipxx+R7G6zQoGGvm+40Q4AdDVuaBgCGSYU=;
 b=OypVWm3JWIH+8GSnd963SMCmLcaiPhFDrHpCUL+79LZWvQZ2dKAmEvw8iAhVlNKBGsnCrO
 rN0ixgfsd+MR68CaLCO6Ci8LEuNF+mE4n55czbbbzhGwbbzg/xui1/mwFnGn1F5eTDFqny
 j1WMdJtcAYFzDv07OtJPcLoHPGSiJac=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-175-xiA0C9CCP46pZPDzAgMv1Q-1; Wed, 12 Mar 2025 13:11:04 -0400
X-MC-Unique: xiA0C9CCP46pZPDzAgMv1Q-1
X-Mimecast-MFC-AGG-ID: xiA0C9CCP46pZPDzAgMv1Q_1741799464
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7c3c17f91dbso259885a.0
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 10:11:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741799464; x=1742404264;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nlETL8ZVYipxx+R7G6zQoGGvm+40Q4AdDVuaBgCGSYU=;
 b=rCuBdDQVwES9xOQagf6hNrccPCXl3tkrR29cFzCmehRDh3iOVM+8QCEoRdhnn02k72
 t9dOizz0Zu8MwSNeSeAWeLulBye+5S6WIbIh3D2XPApf2vKCjaXNEQi3VEdXl8ylGJ8j
 HoxaFTEgQFEAX+Y1xvm3LJtHUBuCWx5+yrkv4mHupnjS6CbbWGNVLDCjYx09lmqVNYg+
 +KQfEdAZakcpC2S/ivjYq1LDNSp6XxESF01przuUpLm2gdsNhXWhfWUSVeVCaqp1l4Hb
 C9fDQmBZfbeXWwUPwy95aH1eIPn3NFAg3M11oE92mKt0G2VhwSiD0YPo4W5uroV+MLnz
 6BBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJaYuuCV+I3ypYPc/tGmc2T44FskGAmvGVekp2lvCGkMaOGeHyXEceBOUR7f+vk5HoQnNvKwk2bQNu@nongnu.org
X-Gm-Message-State: AOJu0YyjCHKCS6A6dybqWOdscXo6iq9KqY5X5XUD8VMfQO8JciTlRel1
 HiNCST0lquNtF2gV8SqWKdxaV16YkUjAY0+0LM3zU4YeZRBD+ocrkjva6UFdfGkibaa9U3GzA5l
 cqbcysp2jPqD8I1CG4CaFw5o7fmmniYDFTfrnhyrmkUb9yMqO/6Qo
X-Gm-Gg: ASbGnctpFGqCLnBBoU9+pY+sFr5yBRxBPWa4QQkkYQSDR7vVrPBOZiH7PeEKKUIDcQg
 NEsCj5I4dlyRQi45CWQmHfUqlwHsC35lFGxwvDThf+jNCdx4c4dakFKdj/hj/q6e3NujPbRH/SI
 q3ZuMfLa2CxOIKxJ+IUIHUtwu7Y14ZLoz4jY3LggjY/D+T9RNRGFtGr1YO3PymI5cl7dvzoyKHt
 tIhpgtRftrQllN+89Z0a/tsggjXrYnwOaqrpF0cnhU/O/ALAVbkmcvTB9MnYNNEUV3XcK1crFWV
 GytAfD3SxUqLzVreMno83GRw8meDENCECQaxouIBC/vNxyQtOfeprVep0XbudGs=
X-Received: by 2002:a05:620a:1d06:b0:7c5:5003:81c5 with SMTP id
 af79cd13be357-7c55e93ae9amr1567440385a.52.1741799464210; 
 Wed, 12 Mar 2025 10:11:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKZbNMYp6uVQ/oIpL5DAX+5lBSzjIawp3f48M6aSSzS16qT/vHWBF6+ZuNn7UVpPnn6A2jmg==
X-Received: by 2002:a05:620a:1d06:b0:7c5:5003:81c5 with SMTP id
 af79cd13be357-7c55e93ae9amr1567436685a.52.1741799463935; 
 Wed, 12 Mar 2025 10:11:03 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c547d6fa08sm621214485a.41.2025.03.12.10.11.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Mar 2025 10:11:03 -0700 (PDT)
Message-ID: <1bdaaa53-129d-4a95-91c8-3876262ed74a@redhat.com>
Date: Wed, 12 Mar 2025 18:10:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 07/20] hw/arm/smmu-common: Introduce callbacks for
 PCIIOMMUOps
Content-Language: en-US
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jgg@nvidia.com, nicolinc@nvidia.com,
 ddutile@redhat.com, berrange@redhat.com, nathanc@nvidia.com,
 mochs@nvidia.com, smostafa@google.com, linuxarm@huawei.com,
 wangzhou1@hisilicon.com, jiangkunkun@huawei.com,
 jonathan.cameron@huawei.com, zhangfei.gao@linaro.org
References: <20250311141045.66620-1-shameerali.kolothum.thodi@huawei.com>
 <20250311141045.66620-8-shameerali.kolothum.thodi@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250311141045.66620-8-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org




On 3/11/25 3:10 PM, Shameer Kolothum wrote:
> Subsequently smmuv3-accel will provide these callbacks
>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>  hw/arm/smmu-common.c         | 27 +++++++++++++++++++++++++++
>  include/hw/arm/smmu-common.h |  5 +++++
>  2 files changed, 32 insertions(+)
>
> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
> index 83c0693f5a..9fd455baa0 100644
> --- a/hw/arm/smmu-common.c
> +++ b/hw/arm/smmu-common.c
> @@ -865,6 +865,10 @@ static AddressSpace *smmu_find_add_as(PCIBus *bus, void *opaque, int devfn)
>      SMMUState *s = opaque;
>      SMMUPciBus *sbus = smmu_get_sbus(s, bus);
>  
> +    if (s->accel && s->get_address_space) {
> +        return s->get_address_space(bus, opaque, devfn);
> +    }
after reading subsequent patch the code below should be another
implementation of this specific cb for non accelerate SMMU. So in that
patch you could introduce the implementation for the non accelerated SMMU.

Eric
> +
>      sdev = sbus->pbdev[devfn];
>      if (!sdev) {
>          sdev = sbus->pbdev[devfn] = g_new0(SMMUDevice, 1);
> @@ -874,8 +878,31 @@ static AddressSpace *smmu_find_add_as(PCIBus *bus, void *opaque, int devfn)
>      return &sdev->as;
>  }
>  
> +static bool smmu_dev_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
> +                                      HostIOMMUDevice *hiod, Error **errp)
> +{
> +    SMMUState *s = opaque;
> +
> +    if (s->accel && s->set_iommu_device) {
> +        return s->set_iommu_device(bus, opaque, devfn, hiod, errp);
> +    }
> +
> +    return false;
> +}
> +
> +static void smmu_dev_unset_iommu_device(PCIBus *bus, void *opaque, int devfn)
> +{
> +    SMMUState *s = opaque;
> +
> +    if (s->accel && s->unset_iommu_device) {
> +        s->unset_iommu_device(bus, opaque, devfn);
> +    }
> +}
> +
>  static const PCIIOMMUOps smmu_ops = {
>      .get_address_space = smmu_find_add_as,
> +    .set_iommu_device = smmu_dev_set_iommu_device,
> +    .unset_iommu_device = smmu_dev_unset_iommu_device,
>  };
>  
>  SMMUDevice *smmu_find_sdev(SMMUState *s, uint32_t sid)
> diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
> index 80ff2ef6aa..7b05640167 100644
> --- a/include/hw/arm/smmu-common.h
> +++ b/include/hw/arm/smmu-common.h
> @@ -160,6 +160,11 @@ struct SMMUState {
>  
>      /* For smmuv3-accel */
>      bool accel;
> +
> +    AddressSpace * (*get_address_space)(PCIBus *bus, void *opaque, int devfn);
> +    bool (*set_iommu_device)(PCIBus *bus, void *opaque, int devfn,
> +                             HostIOMMUDevice *dev, Error **errp);
> +    void (*unset_iommu_device)(PCIBus *bus, void *opaque, int devfn);
>  };
>  
>  struct SMMUBaseClass {


