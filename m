Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87FBEC3600C
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 13:39:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txQxZ-0007kk-Gj; Wed, 26 Mar 2025 09:38:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1txQxX-0007jz-Ox
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 09:38:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1txQxV-0000kA-IH
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 09:38:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742996295;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fc79c2L0cAXU2KnYLVY/R/r8eGq45TPBbCVSyVREE8E=;
 b=E8ZymNtCc43KMPP2FsRQFsoBHe1udeBrE2IimJrjDJFGIcEVKSCgt8QPp79b7nwXfYEjx/
 x3jKpoGkcGAQyP22eRfs7PFssk3bWgnAPiRhnr2dYsYl+uMUL95yOjDYkh1gk5yl+EhNQ7
 5nlUnhLaqnEeWQ4dzDZ+h21Zgkr99a8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-czVK59HfMqOFIszdZllGaA-1; Wed, 26 Mar 2025 09:38:12 -0400
X-MC-Unique: czVK59HfMqOFIszdZllGaA-1
X-Mimecast-MFC-AGG-ID: czVK59HfMqOFIszdZllGaA_1742996291
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3912b54611dso4311426f8f.1
 for <qemu-devel@nongnu.org>; Wed, 26 Mar 2025 06:38:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742996291; x=1743601091;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fc79c2L0cAXU2KnYLVY/R/r8eGq45TPBbCVSyVREE8E=;
 b=KfzBMlyvIBPXY1outkEy623YXKlQZlD3wCzJBEjo6TF9IWtCVJIoznCySqn/jUPcYn
 ee2kGdGO01n0wy9+eZwANsc2qJ0N0l97ESnpFyiCbb9Vf+ik5X7Lr8yE9Xk+sBewdTma
 WhME32LMbFu547TX8GjdinYOo+GUt9OjaGLZ7ptxlXfO78c+yJw81rKUIcP5FYQlvzdp
 +YCXmlWDarkXqwSH052h5CwkmwGElwJKodEXzxm28wSD1pPSBE6BKu6C5QxH0m2+orTQ
 ZwUPFuciHjucefhvZ/2VkRCA8j0RnCVu7rhRT3D+McV5WI46ONj3LXrtVfUhq8SSM4Ow
 xFKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUipVYwK+2sAfc5hJg9LZnkKTPxooHnv8t3BEQJQS3XDh1X2D6Tgh5XRcmhpPHUHpj/BCA2zrvYSGNk@nongnu.org
X-Gm-Message-State: AOJu0Ywd9w7VXs0klkHQaS874ycTAH30FjgpsT5xfTdnAVxKR5H9dxQ7
 U8Zlf/7NlsMH+gRSpoBwI4NADpmDFJdvTlGw7MAy38h+od+kVQt58VP91LoZYYjbPSNjh0ZwHgi
 0TRa2F5J5ptfyk81WyReSetmRt878TfhX3ACR34AqFzR9hG0LeWp1
X-Gm-Gg: ASbGnctrWShmiQevThv5Tuz5P9/PRS8TRs0NcPtmXIXKocmSwXg4pLebjPpK3EIouh/
 8OqSAeCBr88KGDIFEumrez7LRlu1MIgzyvkXCyBXYE2jaXHyOd1Qk7uqRR+bOnQ3RKb6kzSFpMq
 bE9X89oxmgagr3Y65WTDV6dnQQxHwaBhhCEoG3OQ8iLY+PmR26ERWtOBJLnOKAgjnH6Ps6Ozi5L
 bFNYZd8HkdcIw3xiwVXEw8WKFsTQDl92FLhTTHjBsvfvh2VZVoR86LCegjJpxX1J8/Z6aVFoJUB
 vnMuPWKXISyZP7f0HDQlIMts9LpJNKJwRkr6AXo/+5/QaF/oiGp2Vy979eGm7/o=
X-Received: by 2002:a05:6000:178c:b0:391:47f2:8d90 with SMTP id
 ffacd0b85a97d-3997f9017e3mr17029672f8f.20.1742996290721; 
 Wed, 26 Mar 2025 06:38:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4HvT27Tciz3pKzhBUkszbEa/1SSlePFm/ek57F72qYHgckmJSk2cfbXwDsuiNnaBt8xO2mQ==
X-Received: by 2002:a05:6000:178c:b0:391:47f2:8d90 with SMTP id
 ffacd0b85a97d-3997f9017e3mr17029640f8f.20.1742996290216; 
 Wed, 26 Mar 2025 06:38:10 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d830f5708sm2228235e9.32.2025.03.26.06.38.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Mar 2025 06:38:09 -0700 (PDT)
Message-ID: <e23b4803-02d1-4850-8b6e-ad398a66a31c@redhat.com>
Date: Wed, 26 Mar 2025 14:38:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 13/20] hw/arm/smmuv3-accel: Introduce helpers to
 batch and issue cache invalidations
Content-Language: en-US
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jgg@nvidia.com, nicolinc@nvidia.com,
 ddutile@redhat.com, berrange@redhat.com, nathanc@nvidia.com,
 mochs@nvidia.com, smostafa@google.com, linuxarm@huawei.com,
 wangzhou1@hisilicon.com, jiangkunkun@huawei.com,
 jonathan.cameron@huawei.com, zhangfei.gao@linaro.org
References: <20250311141045.66620-1-shameerali.kolothum.thodi@huawei.com>
 <20250311141045.66620-14-shameerali.kolothum.thodi@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250311141045.66620-14-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Shameer, Nicolin,

On 3/11/25 3:10 PM, Shameer Kolothum wrote:
> From: Nicolin Chen <nicolinc@nvidia.com>
>
> Inroduce an SMMUCommandBatch and some helpers to batch and issue the
> commands.  Currently separate out TLBI commands and device cache commands
can you precise which "device cache commands" you are talking about?
> to avoid some errata on certain versions of SMMUs. Later it should check
worth to give more details about this famous errata here.
> IIDR register to detect if underlying SMMU hw has such an erratum.
>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>  hw/arm/smmuv3-accel.c    | 69 ++++++++++++++++++++++++++++++++++++++++
>  hw/arm/smmuv3-internal.h | 29 +++++++++++++++++
>  2 files changed, 98 insertions(+)
>
> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> index 76134d106a..09be838d22 100644
> --- a/hw/arm/smmuv3-accel.c
> +++ b/hw/arm/smmuv3-accel.c
> @@ -160,6 +160,75 @@ void smmuv3_accel_install_nested_ste(SMMUDevice *sdev, int sid)
>                                            nested_data.ste[0]);
>  }
>  
> +/* Update batch->ncmds to the number of execute cmds */
> +int smmuv3_accel_issue_cmd_batch(SMMUState *bs, SMMUCommandBatch *batch)
> +{
> +    SMMUv3AccelState *s_accel = ARM_SMMUV3_ACCEL(bs);
> +    uint32_t total = batch->ncmds;
> +    IOMMUFDViommu *viommu_core;
> +    int ret;
> +
> +    if (!bs->accel) {
> +        return 0;
> +    }
> +
> +    if (!s_accel->viommu) {
> +        return 0;
> +    }
> +    viommu_core = &s_accel->viommu->core;
> +    ret = iommufd_backend_invalidate_cache(viommu_core->iommufd,
> +                                           viommu_core->viommu_id,
> +                                           IOMMU_VIOMMU_INVALIDATE_DATA_ARM_SMMUV3,
> +                                           sizeof(Cmd), &batch->ncmds,
> +                                           batch->cmds);
> +    if (total != batch->ncmds) {
> +        error_report("%s failed: ret=%d, total=%d, done=%d",
> +                      __func__, ret, total, batch->ncmds);
some commands may have been executed (batch->ncmds !=0). Is the
batch_cmds array updated accordingly? In the kernel doc I don't see any
mention of that. Do you need to report a cmd_error as we do for some
other cmds?
> +        return ret;
> +    }
> +
> +    batch->ncmds = 0;
> +    batch->dev_cache = false;
> +    return ret;
> +}
> +
> +int smmuv3_accel_batch_cmds(SMMUState *bs, SMMUDevice *sdev,
I was confused by the name. The helper adds a single Cmd to the batch,
right? so batch_cmd would better suited.
> +                            SMMUCommandBatch *batch, Cmd *cmd,
> +                            uint32_t *cons, bool dev_cache)
> +{
> +    int ret;
> +
> +    if (!bs->accel) {
> +        return 0;
> +    }
> +
> +    if (sdev) {
> +        SMMUv3AccelDevice *accel_dev;
> +        accel_dev = container_of(sdev, SMMUv3AccelDevice, sdev);
> +        if (!accel_dev->s1_hwpt) {
can it happen? in the positive can you add some comment to describe in
which condition?
> +            return 0;
> +        }
> +    }
> +
> +    /*
> +     * Currently separate out dev_cache and hwpt for safety, which might
> +     * not be necessary if underlying HW SMMU does not have the errata.
> +     *
> +     * TODO check IIDR register values read from hw_info.
> +     */
> +    if (batch->ncmds && (dev_cache != batch->dev_cache)) {
> +        ret = smmuv3_accel_issue_cmd_batch(bs, batch);
> +        if (ret) {
> +            *cons = batch->cons[batch->ncmds];
> +            return ret;
> +        }
> +    }
> +    batch->dev_cache = dev_cache;
> +    batch->cmds[batch->ncmds] = *cmd;
> +    batch->cons[batch->ncmds++] = *cons;
> +    return 0;
> +}
> +
>  static bool
>  smmuv3_accel_dev_attach_viommu(SMMUv3AccelDevice *accel_dev,
>                                 HostIOMMUDeviceIOMMUFD *idev, Error **errp)
> diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
> index 46c8bcae14..4602ae6728 100644
> --- a/hw/arm/smmuv3-internal.h
> +++ b/hw/arm/smmuv3-internal.h
> @@ -549,13 +549,42 @@ typedef struct CD {
>      uint32_t word[16];
>  } CD;
>  
> +/**
> + * SMMUCommandBatch - batch of invalidation commands for smmuv3-accel
> + * @cmds: Pointer to list of commands
> + * @cons: Pointer to list of CONS corresponding to the commands
> + * @ncmds: Total ncmds in the batch
number of commands
> + * @dev_cache: Issue to a device cache
indicate whether the invalidation command batch targets device cache?
> + */
> +typedef struct SMMUCommandBatch {
> +    Cmd *cmds;
> +    uint32_t *cons;
> +    uint32_t ncmds;
> +    bool dev_cache;
> +} SMMUCommandBatch;
> +
>  int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste,
>                    SMMUEventInfo *event);
>  void smmuv3_flush_config(SMMUDevice *sdev);
>  
>  #if defined(CONFIG_ARM_SMMUV3_ACCEL) && defined(CONFIG_IOMMUFD)
> +int smmuv3_accel_issue_cmd_batch(SMMUState *bs, SMMUCommandBatch *batch);
> +int smmuv3_accel_batch_cmds(SMMUState *bs, SMMUDevice *sdev,
> +                            SMMUCommandBatch *batch, Cmd *cmd,
> +                            uint32_t *cons, bool dev_cache);
>  void smmuv3_accel_install_nested_ste(SMMUDevice *sdev, int sid);
>  #else
> +static inline int smmuv3_accel_issue_cmd_batch(SMMUState *bs,
> +                                               SMMUCommandBatch *batch)
> +{
> +    return 0;
> +}
> +static inline int smmuv3_accel_batch_cmds(SMMUState *bs, SMMUDevice *sdev,
> +                                          SMMUCommandBatch *batch, Cmd *cmd,
> +                                          uint32_t *cons, bool dev_cache)
> +{
> +    return 0;
> +}
>  static inline void smmuv3_accel_install_nested_ste(SMMUDevice *sdev, int sid)
>  {
>  }
Thanks

Eric


