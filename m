Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6E1DC30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 18:33:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPRGb-0007gH-3z; Thu, 04 Jul 2024 14:33:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1sPRGV-0007Zx-I0
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 14:33:07 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1sPRGQ-0003ep-7w
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 14:33:04 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-42565670e20so12738585e9.0
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2024 11:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720117979; x=1720722779; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=093eQqwjwdZ9T2e/A+1zO+f8C9q+fawb6Z0V4olwT7I=;
 b=oGFaejVMfbXbDcw4C3HdXNDu3fLcDExWTE1TErpMRS4qBGvqpKXaJg1He3zR39Ehlx
 J/F6TjG2NHS97/jPir9EqGVwLZgZH5p9uh9Pmuy5ZhssNN+5+s2+NtuNEk+IKj4ThvaI
 a1Xh3DeDTWKxi+1p/J03jZrWfcvqFo+FPNtZsTtZJmf+tSU7Nl8hhsl0x3M+hIqlblnE
 zpxBOUt8Fed1YCCQxQA6zyn0VgGpW9zyZpT6yDGOjB9RS/Fn2m+qXBw/rIWzthmf+iAk
 7v4XmIveJvHGbzKBC9hB/v5qA6d+nJb9kX1ToqrbH8t5CQxDWObcruHNqJGsq2I8H4C8
 6fcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720117979; x=1720722779;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=093eQqwjwdZ9T2e/A+1zO+f8C9q+fawb6Z0V4olwT7I=;
 b=bD1tiGzQwdoUhsMwjS+MnOtBNBwgI+LoPBy+qe8RI13XDEO+Yzm8vSvzSXnlCXFmkK
 vZWiAN3bezS+uPzITEQww2rR7IDF8Y7bmd23abMyXtfQI/KJm2GhF3YKUz8ky6fUEfCK
 mFf11O0Iq+xisUq/ii/nKjlGfdsOlVKZLgNo3ZElPnPzT+23p6Xb4ANk35Si31t3Tnnu
 V2cHmiLbkxcmSe8W4DrJAvkC3aSgUsPBizIuKfGFbwFRJYKTrB2VeSwjwn2OhpM9xJYF
 idYaOy640dHT4iA4E+0J1rY0PBkRLQ67aqhtZWdEM9Ty3jlKZQfEdrWqIZByR5OOdGH6
 ZC7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgMJSB6jmZQTSFsyq1moaGQ3h0BypxHdmKfIAvo9jiP3+sSdLRvU9O6bd0AkwSbd9dJ952+RN94Ck03Af36dbDqoqdWmE=
X-Gm-Message-State: AOJu0Yw6nEMt+ga6t28EIkTm1YKOmfBzWGBAmfeoNsvRGcPEALj2wwLb
 KGQRhtx9i2dHhVNdyOAJHoeG0teqQSOFpgdChrkjS9TKwYniY8UZSRwoQx4PZ9A=
X-Google-Smtp-Source: AGHT+IGBwHBmVWEtfqQ8PxmOLn331O1Ai9JQG4EVA0Iw5jAdFNzYlMmyBGZig4Rdz8QAXPFixUMlrg==
X-Received: by 2002:a7b:c8c5:0:b0:425:6424:5f97 with SMTP id
 5b1f17b1804b1-4264b126c8emr23507825e9.5.1720117979387; 
 Thu, 04 Jul 2024 11:32:59 -0700 (PDT)
Received: from myrica ([2.221.137.100]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4264a283551sm33165625e9.42.2024.07.04.11.32.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jul 2024 11:32:59 -0700 (PDT)
Date: Thu, 4 Jul 2024 19:33:12 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Mostafa Saleh <smostafa@google.com>
Cc: qemu-arm@nongnu.org, eric.auger@redhat.com, peter.maydell@linaro.org,
 qemu-devel@nongnu.org, alex.bennee@linaro.org, maz@kernel.org,
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org,
 marcin.juszkiewicz@linaro.org
Subject: Re: [PATCH v4 13/19] hw/arm/smmu: Introduce smmu_iotlb_inv_asid_vmid
Message-ID: <20240704183312.GJ1693268@myrica>
References: <20240701110241.2005222-1-smostafa@google.com>
 <20240701110241.2005222-14-smostafa@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701110241.2005222-14-smostafa@google.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=jean-philippe@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Jul 01, 2024 at 11:02:35AM +0000, Mostafa Saleh wrote:
> Soon, Instead of doing TLB invalidation by ASID only, VMID will be
> also required.
> Add smmu_iotlb_inv_asid_vmid() which invalidates by both ASID and VMID.
> 
> However, at the moment this function is only used in SMMU_CMD_TLBI_NH_ASID
> which is a stage-1 command, so passing VMID = -1 keeps the original
> behaviour.
> 
> Signed-off-by: Mostafa Saleh <smostafa@google.com>

One small issue: the change to hw/arm/trace-events for
trace_smmu_iotlb_inv_asid_vmid() should be in patch 13 rather than 14,
otherwise the series isn't bisectable.

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

> ---
>  hw/arm/smmu-common.c         | 20 +++++++++++++-------
>  hw/arm/smmuv3.c              |  2 +-
>  include/hw/arm/smmu-common.h |  2 +-
>  3 files changed, 15 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
> index 5bf9eadeff..d0309a95b2 100644
> --- a/hw/arm/smmu-common.c
> +++ b/hw/arm/smmu-common.c
> @@ -159,13 +159,14 @@ void smmu_iotlb_inv_all(SMMUState *s)
>      g_hash_table_remove_all(s->iotlb);
>  }
>  
> -static gboolean smmu_hash_remove_by_asid(gpointer key, gpointer value,
> -                                         gpointer user_data)
> +static gboolean smmu_hash_remove_by_asid_vmid(gpointer key, gpointer value,
> +                                              gpointer user_data)
>  {
> -    int asid = *(int *)user_data;
> +    SMMUIOTLBPageInvInfo *info = (SMMUIOTLBPageInvInfo *)user_data;
>      SMMUIOTLBKey *iotlb_key = (SMMUIOTLBKey *)key;
>  
> -    return SMMU_IOTLB_ASID(*iotlb_key) == asid;
> +    return (SMMU_IOTLB_ASID(*iotlb_key) == info->asid) &&
> +           (SMMU_IOTLB_VMID(*iotlb_key) == info->vmid);
>  }
>  
>  static gboolean smmu_hash_remove_by_vmid(gpointer key, gpointer value,
> @@ -270,10 +271,15 @@ void smmu_iotlb_inv_ipa(SMMUState *s, int vmid, dma_addr_t ipa, uint8_t tg,
>                                  &info);
>  }
>  
> -void smmu_iotlb_inv_asid(SMMUState *s, int asid)
> +void smmu_iotlb_inv_asid_vmid(SMMUState *s, int asid, int vmid)
>  {
> -    trace_smmu_iotlb_inv_asid(asid);
> -    g_hash_table_foreach_remove(s->iotlb, smmu_hash_remove_by_asid, &asid);
> +    SMMUIOTLBPageInvInfo info = {
> +        .asid = asid,
> +        .vmid = vmid,
> +    };
> +
> +    trace_smmu_iotlb_inv_asid_vmid(asid, vmid);
> +    g_hash_table_foreach_remove(s->iotlb, smmu_hash_remove_by_asid_vmid, &info);
>  }
>  
>  void smmu_iotlb_inv_vmid(SMMUState *s, int vmid)
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index e5ecd93258..928f125523 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -1329,7 +1329,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
>  
>              trace_smmuv3_cmdq_tlbi_nh_asid(asid);
>              smmu_inv_notifiers_all(&s->smmu_state);
> -            smmu_iotlb_inv_asid(bs, asid);
> +            smmu_iotlb_inv_asid_vmid(bs, asid, -1);
>              break;
>          }
>          case SMMU_CMD_TLBI_NH_ALL:
> diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
> index de032fdfd1..2bc9a03d47 100644
> --- a/include/hw/arm/smmu-common.h
> +++ b/include/hw/arm/smmu-common.h
> @@ -212,7 +212,7 @@ void smmu_iotlb_insert(SMMUState *bs, SMMUTransCfg *cfg, SMMUTLBEntry *entry);
>  SMMUIOTLBKey smmu_get_iotlb_key(int asid, int vmid, uint64_t iova,
>                                  uint8_t tg, uint8_t level);
>  void smmu_iotlb_inv_all(SMMUState *s);
> -void smmu_iotlb_inv_asid(SMMUState *s, int asid);
> +void smmu_iotlb_inv_asid_vmid(SMMUState *s, int asid, int vmid);
>  void smmu_iotlb_inv_vmid(SMMUState *s, int vmid);
>  void smmu_iotlb_inv_iova(SMMUState *s, int asid, int vmid, dma_addr_t iova,
>                           uint8_t tg, uint64_t num_pages, uint8_t ttl);
> -- 
> 2.45.2.803.g4e1b14247a-goog
> 

