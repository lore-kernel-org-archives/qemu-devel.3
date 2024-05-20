Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DACCC04FFE
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2024 10:38:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s90PC-0005UU-Nr; Mon, 20 May 2024 06:38:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1s90P9-0005U4-Mw
 for qemu-devel@nongnu.org; Mon, 20 May 2024 06:38:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1s90P8-0000oP-1n
 for qemu-devel@nongnu.org; Mon, 20 May 2024 06:38:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716201485;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qYybloYhddQjFVVfwcV3qV3Wofv8tKjeWYVubu3SEX0=;
 b=BqAXkEUniaKXXYD8EPHsNBhxHcQKfuMTrkCU3vtx8FM2fS4uqp8ZMpEoWsqdPdebIIDTXK
 vn+Ucn9gZUtnyYPf3Aa1eVc9OmmF4PgJsYmJt2mfVTFB1cpI9ykMrKTQqOyRKAVSnhMSiX
 49E82LCtw2JaVFNNn5/v7lkbZ9lqDbs=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-277-IBLB2PPxO5OWAyGzm1dOjA-1; Mon, 20 May 2024 06:38:03 -0400
X-MC-Unique: IBLB2PPxO5OWAyGzm1dOjA-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7948bc4d8d0so15621285a.3
 for <qemu-devel@nongnu.org>; Mon, 20 May 2024 03:38:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716201480; x=1716806280;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qYybloYhddQjFVVfwcV3qV3Wofv8tKjeWYVubu3SEX0=;
 b=WEQ3GhGdgB99v9z0/MvX96NL1uQq+xZit9eUFfGp6F+Hi5Yq/yLEARZcQnap8klsvG
 avnP5vPWpJGX1iFD131os5RX5tSlz30lJecHAHCk5/rv4VwMdfUf8sajo5VJPO11kWuI
 hSUM8WnamXYNym3okMK8S+U12eNaE+7CqyOBpWQ33zZzWOQRILYLlpiTAkrNoYBO37S+
 IhKmesI8CPDVOF9wyVbwiV/yyw9Y8vp9gMi6V6KWhsid8TaRUqRu2OcCJrkqvZbEFWb2
 gSHUUa8ppaDtDfG76w9NPnv26GdGG08FeAfhl90DTJeEHKFaXYhtpvhTDkwAQ/1rt+AD
 rSBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXh8uZMECO6H0cutA31Cts+wRC9HGHeKhmnSCM8XsgjaQVdhwqY9zSIDg76R+p4wRPRO4/AueMrsl9TUGzuCVBs77j7NM=
X-Gm-Message-State: AOJu0YzPPc+dzIxiZVcYIUfgxV6k9Z+sXRveEU/SbuooxGMb9vObg1mP
 z0Rh7QIRpXhRlfjOws03prT+KCBkwYeaOuvjfj8ywuyYJiaxPT3jeKPnxX3lqPWPhSZMFqK45JE
 OU/Kn+4P1m6FJ5j6sVDKQXbZnvtenCviuyFPqS8/FAYvLEye9RvQVB1VbmWaL
X-Received: by 2002:a05:620a:3624:b0:793:31:d2fd with SMTP id
 af79cd13be357-7930031d425mr1280018185a.5.1716201480269; 
 Mon, 20 May 2024 03:38:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsaoJz3LpGcvi7rskuvnmDj95NkjPUV0f+AxbJd7hzmrvLMQvfVsW5YGZuf5CoxMvx6Sm2aA==
X-Received: by 2002:a05:620a:3624:b0:793:31:d2fd with SMTP id
 af79cd13be357-7930031d425mr1280016985a.5.1716201479872; 
 Mon, 20 May 2024 03:37:59 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-792bf2fc67esm1176913585a.74.2024.05.20.03.37.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 May 2024 03:37:59 -0700 (PDT)
Message-ID: <ee406ad2-68c9-47e2-8167-20dbceb1e484@redhat.com>
Date: Mon, 20 May 2024 12:37:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 13/18] hw/arm/smmuv3: Support nested SMMUs in
 smmuv3_notify_iova()
Content-Language: en-US
To: Mostafa Saleh <smostafa@google.com>, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, qemu-devel@nongnu.org
Cc: jean-philippe@linaro.org, alex.bennee@linaro.org, maz@kernel.org,
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org,
 marcin.juszkiewicz@linaro.org
References: <20240429032403.74910-1-smostafa@google.com>
 <20240429032403.74910-14-smostafa@google.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240429032403.74910-14-smostafa@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi Mostafa,

On 4/29/24 05:23, Mostafa Saleh wrote:
> IOMMUTLBEvent only understands IOVA, for stage-2 only SMMUs keep
> the implementation, while only notify for stage-1 invalidation
> in case of nesting.
>
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
> ---
>  hw/arm/smmuv3.c     | 23 +++++++++++++++--------
>  hw/arm/trace-events |  2 +-
>  2 files changed, 16 insertions(+), 9 deletions(-)
>
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index e0fd494646..96d07234fe 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -1051,7 +1051,7 @@ static void smmuv3_notify_iova(IOMMUMemoryRegion *mr,
>                                 IOMMUNotifier *n,
>                                 int asid, int vmid,
>                                 dma_addr_t iova, uint8_t tg,
> -                               uint64_t num_pages)
> +                               uint64_t num_pages, int stage)
add the new param in the doc comment above
>  {
>      SMMUDevice *sdev = container_of(mr, SMMUDevice, iommu);
>      IOMMUTLBEvent event;
> @@ -1075,14 +1075,21 @@ static void smmuv3_notify_iova(IOMMUMemoryRegion *mr,
>              return;
>          }
>  
> -        if (STAGE1_SUPPORTED(s)) {
> +        /*
> +         * IOMMUTLBEvent only understands IOVA, for stage-2 only SMMUs
> +         * keep the implementation, while only notify for stage-1
> +         * invalidation in case of nesting.
> +         */
> +        if (stage == SMMU_STAGE_1) {
>              tt = select_tt(cfg, iova);
>              if (!tt) {
>                  return;
>              }
>              granule = tt->granule_sz;
> -        } else {
> +        } else if (!STAGE1_SUPPORTED(s)) {
I don't get why you don't test stage == SMMU_STAGE_2 instead
in each block shouldn't you test if the corresponding state of supported?
>              granule = cfg->s2cfg.granule_sz;
> +        } else {
I don't really understand the logic here. Please can you comment each case?

Thanks

Eric
> +            return;
>          }
>  
>      } else {
> @@ -1101,7 +1108,7 @@ static void smmuv3_notify_iova(IOMMUMemoryRegion *mr,
>  /* invalidate an asid/vmid/iova range tuple in all mr's */
>  static void smmuv3_inv_notifiers_iova(SMMUState *s, int asid, int vmid,
>                                        dma_addr_t iova, uint8_t tg,
> -                                      uint64_t num_pages)
> +                                      uint64_t num_pages, int stage)
>  {
>      SMMUDevice *sdev;
>  
> @@ -1110,10 +1117,10 @@ static void smmuv3_inv_notifiers_iova(SMMUState *s, int asid, int vmid,
>          IOMMUNotifier *n;
>  
>          trace_smmuv3_inv_notifiers_iova(mr->parent_obj.name, asid, vmid,
> -                                        iova, tg, num_pages);
> +                                        iova, tg, num_pages, stage);
>  
>          IOMMU_NOTIFIER_FOREACH(n, mr) {
> -            smmuv3_notify_iova(mr, n, asid, vmid, iova, tg, num_pages);
> +            smmuv3_notify_iova(mr, n, asid, vmid, iova, tg, num_pages, stage);
>          }
>      }
>  }
> @@ -1144,7 +1151,7 @@ static void smmuv3_range_inval(SMMUState *s, Cmd *cmd, SMMUStage stage)
>  
>      if (!tg) {
>          trace_smmuv3_range_inval(vmid, asid, addr, tg, 1, ttl, leaf, stage);
> -        smmuv3_inv_notifiers_iova(s, asid, vmid, addr, tg, 1);
> +        smmuv3_inv_notifiers_iova(s, asid, vmid, addr, tg, 1, stage);
>          if (stage == SMMU_STAGE_1) {
>              smmu_iotlb_inv_iova(s, asid, vmid, addr, tg, 1, ttl);
>          } else {
> @@ -1167,7 +1174,7 @@ static void smmuv3_range_inval(SMMUState *s, Cmd *cmd, SMMUStage stage)
>          num_pages = (mask + 1) >> granule;
>          trace_smmuv3_range_inval(vmid, asid, addr, tg, num_pages,
>                                   ttl, leaf, stage);
> -        smmuv3_inv_notifiers_iova(s, asid, vmid, addr, tg, num_pages);
> +        smmuv3_inv_notifiers_iova(s, asid, vmid, addr, tg, num_pages, stage);
>          if (stage == SMMU_STAGE_1) {
>              smmu_iotlb_inv_iova(s, asid, vmid, addr, tg, num_pages, ttl);
>          } else {
> diff --git a/hw/arm/trace-events b/hw/arm/trace-events
> index 593cc571da..be6c8f720b 100644
> --- a/hw/arm/trace-events
> +++ b/hw/arm/trace-events
> @@ -55,7 +55,7 @@ smmuv3_cmdq_tlbi_s12_vmid(int vmid) "vmid=%d"
>  smmuv3_config_cache_inv(uint32_t sid) "Config cache INV for sid=0x%x"
>  smmuv3_notify_flag_add(const char *iommu) "ADD SMMUNotifier node for iommu mr=%s"
>  smmuv3_notify_flag_del(const char *iommu) "DEL SMMUNotifier node for iommu mr=%s"
> -smmuv3_inv_notifiers_iova(const char *name, int asid, int vmid, uint64_t iova, uint8_t tg, uint64_t num_pages) "iommu mr=%s asid=%d vmid=%d iova=0x%"PRIx64" tg=%d num_pages=0x%"PRIx64
> +smmuv3_inv_notifiers_iova(const char *name, int asid, int vmid, uint64_t iova, uint8_t tg, uint64_t num_pages, int stage) "iommu mr=%s asid=%d vmid=%d iova=0x%"PRIx64" tg=%d num_pages=0x%"PRIx64" stage=%d"
>  
>  # strongarm.c
>  strongarm_uart_update_parameters(const char *label, int speed, char parity, int data_bits, int stop_bits) "%s speed=%d parity=%c data=%d stop=%d"


