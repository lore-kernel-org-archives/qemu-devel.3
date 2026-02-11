Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78FD1E9E309
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 13:26:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqAEE-0007zd-Ue; Wed, 11 Feb 2026 08:26:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vqAEC-0007yb-31
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 08:26:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vqAEA-0005J5-Fu
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 08:25:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770816357;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sX8n9FbwOElmItrRaB3ziXunmuIvqTMIBDaa2YCUup0=;
 b=gDclue0Cwzjjt5o0rp91yFOvc1W6LY4Gd66E94aBzPlb/4S++EdJc53o2gU8Z5fxVutVBF
 i4Isc/EIF1xm6hDbH1+6r/UBnAlqHiqgd722X0NDM4NC2rWWQh31ZoQcY+wWh3owfGmvzL
 R8nQFYUdiQ7m1okiYgH6kcysx5Lq93I=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-298-sC6ohujCP8W3-h9O42hgeQ-1; Wed, 11 Feb 2026 08:25:55 -0500
X-MC-Unique: sC6ohujCP8W3-h9O42hgeQ-1
X-Mimecast-MFC-AGG-ID: sC6ohujCP8W3-h9O42hgeQ_1770816355
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4832c4621c2so46585835e9.3
 for <qemu-devel@nongnu.org>; Wed, 11 Feb 2026 05:25:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770816355; x=1771421155;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sX8n9FbwOElmItrRaB3ziXunmuIvqTMIBDaa2YCUup0=;
 b=easehldoxxO9X3mOOYgRn70fcf5rIxg393G3E8zKZ4K1tsl6szGnTm/Ce/ktiv1Gvn
 w85D5xcz2lspBK9DX+qWoWV7EPJeFhb5yQTfJXnoK4j3saUkEix8ElWRsnsJlEG8q9U5
 IMyrIkKFEpkdoCll7BvOBytBj2zlYqSnvPkEtpzpAqvSFhSkrUuxI/aCZlEBDM0DSIOQ
 yFRagf8aePVbjhDkhh6ekk/9wv0cS6WocstyKU2mwHo5ZcKr2fi2/GF8YLrTB4S7A/KQ
 zc7GFBNPmSaswik6ivrrzU923ufAjeOxdp8i+5aPZ/gvtNe0Fp9f3LAIo4PH8wjoaxyl
 Bj7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwRYiJyc7oj1rx41WDgDQd8U/rV/IyxkK8QKq//xYkPXEUnZ7gFtVEJD4iMukcuEcb3sr920QrkGGn@nongnu.org
X-Gm-Message-State: AOJu0YzVs1kHgoG2zx97AfE9jQo8lA0tVKMHYqX+8Z6BHCupTTLIyEUq
 89s2PS8ydSxKFtNukjbUXvk8lU3j4oMJxqiHml/94j5lyYmCvf/OL32ffimZH6clBi4tPMKjz8e
 6674NuMq+SkUvPQi+LIbs0L4vbGNo6nbX153WG0MpAvx0Og5FnTUaprjY
X-Gm-Gg: AZuq6aKEO2cYap5Ocg6HOE+WK8osxbe+jPI2tXpy+opI2Q6p+/wRbw6yRz9KxpmnhLv
 5TdLs+4plnPi7uHQTL5p0gXWlyeeAu0KRxZE7EHpOm7qtK7msjoPYbVu6AZKt1ZVWqRbRSieQT0
 PF7htLW7LvXy8CJ7KjfnhN7CdSVGtRnaH0PKvLQ939DU1VdpiZlS8WzmEUlaeh/hO0C/vZRt0Pa
 c5wFIw5Mkj4j/j5hKngoTyprQrXdybIx10BMtUhxd/NJ4xv01PhybdYa0C3Qu0Hm3e+0GIbsMR1
 XWRds2KjFzUEADw6BYPspzKuwBiCstyq9Y47BRgxDuODYaKyP+vcTjILy7R7YVAD7g2dGrEuIqw
 xVEfa9YQeo8dTBmruFnYMJ4K4Mhf4ZL1bJOwJ0EvWQIMCcmVwqy7RLhDfFEDOBOck7/LaQg==
X-Received: by 2002:a05:600c:3b1e:b0:480:3b4e:41b8 with SMTP id
 5b1f17b1804b1-48350833443mr78651455e9.33.1770816354612; 
 Wed, 11 Feb 2026 05:25:54 -0800 (PST)
X-Received: by 2002:a05:600c:3b1e:b0:480:3b4e:41b8 with SMTP id
 5b1f17b1804b1-48350833443mr78651045e9.33.1770816354199; 
 Wed, 11 Feb 2026 05:25:54 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4835a5c7c4csm69175545e9.0.2026.02.11.05.25.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Feb 2026 05:25:53 -0800 (PST)
Message-ID: <6d57ca20-1ca8-4ce3-a634-37d70545469e@redhat.com>
Date: Wed, 11 Feb 2026 14:25:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/5] hw/arm/smmuv3-accel: Add viommu free helper
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, nicolinc@nvidia.com, nathanc@nvidia.com,
 mochs@nvidia.com, jan@nvidia.com, jgg@nvidia.com,
 jonathan.cameron@huawei.com, zhangfei.gao@linaro.org,
 zhenzhong.duan@intel.com, kjaju@nvidia.com
References: <20260211083415.133534-1-skolothumtho@nvidia.com>
 <20260211083415.133534-3-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260211083415.133534-3-skolothumtho@nvidia.com>
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

On 2/11/26 9:34 AM, Shameer Kolothum wrote:
> Move viommu teardown into a helper function and use it from the
> last device removal path. No functional change.
>
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  hw/arm/smmuv3-accel.c | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
>
> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> index f5cd4df336..c19c526fca 100644
> --- a/hw/arm/smmuv3-accel.c
> +++ b/hw/arm/smmuv3-accel.c
> @@ -390,6 +390,20 @@ bool smmuv3_accel_issue_inv_cmd(SMMUv3State *bs, void *cmd, SMMUDevice *sdev,
>                     sizeof(Cmd), &entry_num, cmd, errp);
>  }
>  
> +static void smmuv3_accel_free_viommu(SMMUv3AccelState *accel)
> +{
> +    IOMMUFDViommu *viommu = accel->viommu;
> +
> +    if (!viommu) {
> +        return;
> +    }
> +    iommufd_backend_free_id(viommu->iommufd, accel->bypass_hwpt_id);
> +    iommufd_backend_free_id(viommu->iommufd, accel->abort_hwpt_id);
> +    iommufd_backend_free_id(viommu->iommufd, accel->viommu->viommu_id);
> +    g_free(viommu);
> +    accel->viommu = NULL;
> +}
> +
>  static bool
>  smmuv3_accel_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
>                            Error **errp)
> @@ -549,12 +563,7 @@ static void smmuv3_accel_unset_iommu_device(PCIBus *bus, void *opaque,
>      trace_smmuv3_accel_unset_iommu_device(devfn, idev->devid);
>  
>      if (QLIST_EMPTY(&accel->device_list)) {
> -        iommufd_backend_free_id(accel->viommu->iommufd, accel->bypass_hwpt_id);
> -        iommufd_backend_free_id(accel->viommu->iommufd, accel->abort_hwpt_id);
> -        iommufd_backend_free_id(accel->viommu->iommufd,
> -                                accel->viommu->viommu_id);
> -        g_free(accel->viommu);
> -        accel->viommu = NULL;
> +        smmuv3_accel_free_viommu(accel);
>      }
>  }
>  


