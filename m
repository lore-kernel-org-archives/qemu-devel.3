Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E242C83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Jul 2025 00:39:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucZ7m-0006HS-7U; Thu, 17 Jul 2025 20:38:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ucZ7e-0006DA-2a
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 20:38:48 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ucZ7b-0004o0-Pm
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 20:38:45 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-236377f00a1so14417845ad.3
 for <qemu-devel@nongnu.org>; Thu, 17 Jul 2025 17:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752799121; x=1753403921; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=T5Ov+Bi873odtutvSRAshHC2WnahBUJHPlmSFNGCvw4=;
 b=Wv53p5QeFHWp1fdnpGXzZZJ59x4g0CJ7f7ykmhAtoyB991dBC0IFUdDLSQ3iMJuWiu
 h335zflYz0Lcis5CEkTRbszjXp6+uPyRduUW/lMicNLdlRKd8RkMUZB1qiKziGNb/9bu
 QAk3HUcz1bX/6lYLIbZN61ELlELEWC60eAUsb5B9PoH72kvlb9OYWMvY6nlFOWhhgqfc
 MY+uNuDIlIXM/h9MPHshuGj1OLrOc9ydsgeMehrnFcNj0ubYTP1inUubhqsrDnm1NhcR
 8nzjIt9/aHKQ/7f+Hf+n4PpgNv/BgVwyLu7alevDyIh6RmhIykN8jcdhmjdRaEf3PNdG
 6z+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752799121; x=1753403921;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=T5Ov+Bi873odtutvSRAshHC2WnahBUJHPlmSFNGCvw4=;
 b=mO1G+VTr8yw/eTlL9WoKAwg8V0JOHym/MxVFhaS3nN+1Np7KgvWpx+TVm1hwrlO4zp
 0vAOuL0vA7jqihLmizvSEisZmP2k7fng8E6HMTD8XnXN/gnUrQpTfVEthSTWm+Wwq7v6
 f2tITo15RcjFXMCCNz78EfRETYGyWQ8Nr00TP0nvCSjffvUlEiGhBgBLIeHaL55WjmNx
 nFksqpYEDrEtVBVsfEkQGV4KHKoUwNvZ2a3aerDQEXr+6mZ+h05bbYIYPYKYEtMuq3FO
 7rjJcO+BTR/0usF7AsOzvKS6SU9zif69j4OHCXILB9TFiZ296ITJMzq8cX08xSZ7bLin
 NrbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFUZWvkcy2cG6bGoKocU3Ugg0JO6odSKxCMn4nC7mLmqYegS/kyQVc06froXMtCgnkgKy/ej+C/Q+K@nongnu.org
X-Gm-Message-State: AOJu0YyLbIZCu97mClD7C2eBQIiiPmMpo4GwAyMkyn9DNDC78BJAGyTb
 p77Dcfm7oO39tku5qVQsyLYbTkJf30CwkiUO1MLd+0/DZNXFpXrbPIbzP8qzDf1RWXI=
X-Gm-Gg: ASbGnctIf6OA0kvkK43fkTOfbv7dNYSVDkGusM45Ids2N7Q57hbl7oLJg6bGir320VU
 2CDB7EegvnevAc4CEsRGn8XNy18F5MQvHTw+rZWGx+pwmznW5+L4h+GJcXMQ+xhci83tkUosF8L
 7BSjsyCpvESWKBl+8Dfd6TXqh58ndDBB/VqkaG+kQRneg9nTSrlqKuZmdiYp9Uxevd6RnMnSSZN
 TSJDJpcDakNpLjOktwe3bVCO3EiKUj75grG9deYQQt0me8FSRO/PQShRKAOJpmhmmhegO8S/ZKK
 /+eWGYMFu46E57LXCftHC+06VWn/kBHW9qq5fg19T2sJ2FqtqGBRpfgwXC5r3YGH0Se91hELpBK
 j3yX/XN3byi6UA/u0dmyrqXXdHCFLUH/hTOUO
X-Google-Smtp-Source: AGHT+IEkVdsCIbWQPv3iw9g5WKJGCWszD6iO+toq7Lf7YMfyHose5IQLfUO51FftCIKCk8yYma0F7g==
X-Received: by 2002:a17:902:f691:b0:234:a139:11fb with SMTP id
 d9443c01a7336-23e24f4a8admr128569805ad.27.1752799121330; 
 Thu, 17 Jul 2025 17:38:41 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23e3b60ec7dsm2489905ad.71.2025.07.17.17.38.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Jul 2025 17:38:40 -0700 (PDT)
Message-ID: <c6d4338d-7091-4b1e-9c7e-962672e8b6fa@linaro.org>
Date: Thu, 17 Jul 2025 17:38:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/arm: remove `inline` from `smmu_iotlb_inv_vmid_s1`
To: Roman Kiryanov <rkir@google.com>, qemu-devel@nongnu.org
Cc: eric.auger@redhat.com, mjt@tls.msk.ru, whollins@google.com,
 jansene@google.com, jpcottin@google.com
References: <20250717205735.2345674-1-rkir@google.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250717205735.2345674-1-rkir@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

On 7/17/25 13:57, Roman Kiryanov wrote:
> this function is declared in smmu-common.h without
> `inline`. It is also used outside of this file
> which causes linking errors because the non-inline
> version is not generated.
> 
> Signed-off-by: Will Hollins <whollins@google.com>
> Signed-off-by: Roman Kiryanov <rkir@google.com>
> ---
>   hw/arm/smmu-common.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
> index f39b99e526..0dcaf2f589 100644
> --- a/hw/arm/smmu-common.c
> +++ b/hw/arm/smmu-common.c
> @@ -319,7 +319,7 @@ void smmu_iotlb_inv_vmid(SMMUState *s, int vmid)
>       g_hash_table_foreach_remove(s->iotlb, smmu_hash_remove_by_vmid, &vmid);
>   }
>   
> -inline void smmu_iotlb_inv_vmid_s1(SMMUState *s, int vmid)
> +void smmu_iotlb_inv_vmid_s1(SMMUState *s, int vmid)
>   {
>       trace_smmu_iotlb_inv_vmid_s1(vmid);
>       g_hash_table_foreach_remove(s->iotlb, smmu_hash_remove_by_vmid_s1, &vmid);

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

