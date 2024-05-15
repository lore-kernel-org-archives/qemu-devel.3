Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2196C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 13:54:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7F5i-0006Ic-3D; Wed, 15 May 2024 09:54:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1s7F5h-0006IM-2K
 for qemu-devel@nongnu.org; Wed, 15 May 2024 09:54:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1s7F5f-0004V0-G8
 for qemu-devel@nongnu.org; Wed, 15 May 2024 09:54:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715781282;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=djiCVZW/OI+w3LX691XOABCJJ+t0FACKYRstfpa06hM=;
 b=V6uiXtkBfq4hmIp6cCJiMEXxw8j5WoHCwyM0sUdh4u0P0rlpju4ISALZWVTNeWb2NGdoVP
 ihGLoRfr8suNhxGDMc6mT7VrWZjzS2/XqbZDkAl/YuyV3859/8XXA6UawCFdRAoestmgHf
 XM/ZOglpnPZmod/sjSSG1xKuToPfLUI=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-QA-so38aMcKrdoWbKZOd9A-1; Wed, 15 May 2024 09:54:41 -0400
X-MC-Unique: QA-so38aMcKrdoWbKZOd9A-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-43df8c36a06so76285831cf.1
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 06:54:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715781280; x=1716386080;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=djiCVZW/OI+w3LX691XOABCJJ+t0FACKYRstfpa06hM=;
 b=gQSIk78Hvb9+6EXBx5Ruf1S15dlzOeGoiyY33y4fq6jVZQLC5+aJWwX5Jxm2qD5rub
 Nf/1fZJVmlL/gp8cwge0L+sK+RUPuIVsrplfmyP1dkqFKTUd7HIwCdelxr4/vHggPA+o
 BKKzTPE9DHxJ1dQrW4hfJJQ5LHaCD5fI3i+UNq51UcvmVjGQpC+cy5ugn/HJcXsCweWT
 DMDSrRfS9cmYdcMRYCg7dI1vnL7DT1lYsL3lJnUOjUc4ljsRnnDMIqx09kUf8XEy8Vu4
 +pqEMcMzcaPeh3jksmDI+kx1OdSFNDCgm0d3PbQpYgUZ8z+7f6X6Xg8gFOen02JHLvO1
 E3QA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDhmkIhpl2dfkY1bWUsk0EeH1g9VMaYILulGMlhOf46N+D++u02bbCu6oX4Ib+Jx6J2W4AhXluwO7WiFNlTmUOQR62NO8=
X-Gm-Message-State: AOJu0YwMk0ChMBqWV9cZmHrpr8cDe/LLoO0mHSEoivro28UUz5BI/Ymu
 H3f3dfM8iRheySreoDo57idnKRfWG6vHt9vJj0nR1m9M1ORoFygHM7ZUksGWYo4DFAncVJ3cwrY
 JrQA5P17Elja2OK4hYkMg1RcvOBOrfACL8kNwbtZR1fSlVTWRnS6v
X-Received: by 2002:ac8:5d4f:0:b0:43a:deee:a5ea with SMTP id
 d75a77b69052e-43dfdb20ed1mr178892551cf.13.1715781280539; 
 Wed, 15 May 2024 06:54:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEuT4h4BOIe7vYdV1exwG62GfuppjWbsMrJnlBtwa52CgiBCuBDoLRJY9oI5gzMRHf1qfSFTA==
X-Received: by 2002:ac8:5d4f:0:b0:43a:deee:a5ea with SMTP id
 d75a77b69052e-43dfdb20ed1mr178892331cf.13.1715781280171; 
 Wed, 15 May 2024 06:54:40 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-43e3a57b396sm389351cf.24.2024.05.15.06.54.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 May 2024 06:54:39 -0700 (PDT)
Message-ID: <6afc41f6-7127-46f2-833f-6eb4abb2730d@redhat.com>
Date: Wed, 15 May 2024 15:54:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 09/18] hw/arm/smmu-common: Rework TLB lookup for
 nesting
Content-Language: en-US
To: Mostafa Saleh <smostafa@google.com>, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, qemu-devel@nongnu.org
Cc: jean-philippe@linaro.org, alex.bennee@linaro.org, maz@kernel.org,
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org,
 marcin.juszkiewicz@linaro.org
References: <20240429032403.74910-1-smostafa@google.com>
 <20240429032403.74910-10-smostafa@google.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240429032403.74910-10-smostafa@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.935,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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



On 4/29/24 05:23, Mostafa Saleh wrote:
> In the previous patch, comine_tlb() was added which combines 2 TLB
combine
> entries into one, which chooses the granule and level from the
> smallest entry.
>
> This means that a nested translation, an entry can be cached with the
that with nested translation
> granule of stage-2 and not stage-1.
>
> However, the lookup for an IOVA in nested configuration is done with
> stage-1 granule, this patch reworks lookup in that case, so it falls
> back to stage-2 granule if no entry is found using stage-1 granule.
I should have read that before commenting previous patch ;-)
Anyway this shows that something is missing in previous patch, at least
the above explanation ;-)

Eric
>
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
> ---
>  hw/arm/smmu-common.c | 24 ++++++++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)
>
> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
> index 0d6945fa54..c67af3bc6d 100644
> --- a/hw/arm/smmu-common.c
> +++ b/hw/arm/smmu-common.c
> @@ -66,8 +66,10 @@ SMMUIOTLBKey smmu_get_iotlb_key(int asid, int vmid, uint64_t iova,
>      return key;
>  }
>  
> -SMMUTLBEntry *smmu_iotlb_lookup(SMMUState *bs, SMMUTransCfg *cfg,
> -                                SMMUTransTableInfo *tt, hwaddr iova)
> +static SMMUTLBEntry *smmu_iotlb_lookup_all_levels(SMMUState *bs,
> +                                                  SMMUTransCfg *cfg,
> +                                                  SMMUTransTableInfo *tt,
> +                                                  hwaddr iova)
>  {
>      uint8_t tg = (tt->granule_sz - 10) / 2;
>      uint8_t inputsize = 64 - tt->tsz;
> @@ -88,6 +90,24 @@ SMMUTLBEntry *smmu_iotlb_lookup(SMMUState *bs, SMMUTransCfg *cfg,
>          }
>          level++;
>      }
> +    return entry;
> +}
> +
> +SMMUTLBEntry *smmu_iotlb_lookup(SMMUState *bs, SMMUTransCfg *cfg,
> +                                SMMUTransTableInfo *tt, hwaddr iova)
> +{
> +    SMMUTLBEntry *entry = NULL;
> +
> +    entry = smmu_iotlb_lookup_all_levels(bs, cfg, tt, iova);
> +    /*
> +     * For nested translation also try the s2 granule, as the TLB will insert
> +     * it if the size of s2 tlb entry was smaller.
> +     */
> +    if (!entry && (cfg->stage == SMMU_NESTED) &&
> +        (cfg->s2cfg.granule_sz != tt->granule_sz)) {
> +        tt->granule_sz = cfg->s2cfg.granule_sz;
> +        entry = smmu_iotlb_lookup_all_levels(bs, cfg, tt, iova);
> +    }
>  
>      if (entry) {
>          cfg->iotlb_hits++;


