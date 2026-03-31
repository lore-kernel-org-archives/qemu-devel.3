Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 257EA10F92E9
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 18:00:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7dNh-00052F-Ac; Tue, 31 Mar 2026 14:00:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7dNM-000502-G3
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 13:59:42 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7dNK-0002D5-Hy
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 13:59:40 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-43b95e5b3afso3509896f8f.3
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2026 10:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774979976; x=1775584776; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/qS+cREq1W+RKiBSVyZFuDdd6d5V1toNRsD4H7dDYCw=;
 b=IigPJroyVtZf6XBgDUUZ0/eey5FNzGmHcd+vPHxKFDTix+upKisy6v++RhQLwvMwnY
 ugK09Os2ArgJFT2kfcGH+3MYi/z74vEHcXWoSmyErn3UVhZOIvR5lEtMHMbDwwg9VaqK
 SHR5963eN5ymdFNJfurgd/5ueYElr2Xl7vDXBdn1i3g+yEoY4yi2r8nDXYZGjWuvI7Su
 0kj5BZ1nCV4a7ONpPMcoxY026WOJfkVZPlFSMoHF/g8CE3j8ur/UnqHG9chGMYyWSZz7
 d7QKlA5onsoBrqujCm0Mn0UrVukwfzzPl07X/SZSV9/XbpjPTJmJRQlaPHXt2s2XVnPJ
 dMSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774979976; x=1775584776;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/qS+cREq1W+RKiBSVyZFuDdd6d5V1toNRsD4H7dDYCw=;
 b=cNhSjC3RnWh9v4726E6qDAgbbLZgJijONV/G9bFuXNLVVtvyBIRjwHgrwy2TI/eox4
 puegBzlhvQCjwed2U7SYbxQB7uKveAqiVf+r/O5U1h6sjVIF03c/XdrAcGjAlvAmquVb
 yWmSb1J9HmHg1P2pRpITCVNZHavuBRgoJFSUSKy/3kF0Wmk4B46CU0jOt0L4GuT1lFo2
 KUHBw9sCgWL25Wi5fxqRAgRaPzueKsz2Fmmp+ZF85KJU8zZVs1EehqxFfkjurhnU1veX
 MRRLdzn8tpxPLKbVIVUf48rBrDBx/es1yzE3BzcS7GqFBzJ8agNe/5Xi0dSPHLCm0Zdm
 dnKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVok+VJ6nnHC1ejUZs03UE5mY5VtMzQsW1m+xASPYmVEZbObj926L2c14Z5e6ZsjIAuu6RGR4AGMctI@nongnu.org
X-Gm-Message-State: AOJu0Yw+XnxV7JDL3uDQaKQeISw5w97SkbJZolh32Xg38qz6uyStuMbe
 P28qahkp0Fs5t1GES6W8kUGKWilbWpLgr3X1WLqmQZmFU41M8GhpphtKL4MrJ2EYxvE=
X-Gm-Gg: ATEYQzyKuztR8rYu+llqpeWsHzoyIVU9qu7B6AM85k2SnnN6cTQyASqq6u7+FUwgGEG
 hRIUd7H8a0XqwZxna6oSS75qDAhfCVpGHYv9QjH89SeOzc29nklFe7JQnq5bLsHi8N/XK6y7Lbu
 hIzlTWIsIoxs2k8Bfo1MYvAt3DKUWMhC3NB/Sveuch+nV344WVQ4NZLCrNjJ5VaTvOoqncChy9W
 VlAPqRbMh+BdfCTitKgJV3a0wTHJG4O6BD9lrOpVIanM27jXyZJcYaH3O9bSLn1dyGKwKz4NNoW
 vEsESPkO9f5enDaaOMS3IwPbJq8+niPr3FuK8SwiuihgxmjCnr4068zPci6NH/eXngaEKnLk1Eg
 ADwFh/FB+s32yB4SbXJF7A6EGZrxxQA3uEeG9knkz2yAEFCS4bCHrO6KMewzY6qiV5M26EZLDHH
 nVjV0lATCQuXF91lV4h3rVc/dOOK46TGjpbK9YIE1c24r5sHBnTrbHJB6s783YVhqsOg==
X-Received: by 2002:a05:6000:4008:b0:43d:714:34de with SMTP id
 ffacd0b85a97d-43d150f1b6fmr926070f8f.45.1774979975869; 
 Tue, 31 Mar 2026 10:59:35 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43cf245e2f6sm29929612f8f.18.2026.03.31.10.59.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Mar 2026 10:59:35 -0700 (PDT)
Message-ID: <de8a5eb2-b7e0-48c2-a83e-2d1d4f1e94fb@linaro.org>
Date: Tue, 31 Mar 2026 19:59:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/pci/pci: Enforce pci_setup_iommu_per_bus() is called
 only once per bus
Content-Language: en-US
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org,
 mst@redhat.com, skolothumtho@nvidia.com, nicolinc@nvidia.com,
 nathanc@nvidia.com
References: <20260323183024.4069032-1-eric.auger@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260323183024.4069032-1-eric.auger@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 23/3/26 19:30, Eric Auger wrote:
> Currently it is possible to attach several arm-smmuv3 devices to the
> same bus although it is a wrong setup.
> 
> Change the prototype of pci_setup_iommu_per_bus to pass an error
> handle. This latter is set when iommu_per_bus is already set and
> used by the single caller (smmu_base_realize) to report a useful
> error to the end-user.
> 
> While at it document pci_setup_iommu_per_bus callback in the header.
> 
> Fixes: 66d2f665e163 ("hw/arm/virt: Allow user-creatable SMMUv3 dev instantiation")
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>   include/hw/pci/pci.h | 16 +++++++++++++++-
>   hw/arm/smmu-common.c |  2 +-
>   hw/pci/pci.c         |  9 +++++++--
>   3 files changed, 23 insertions(+), 4 deletions(-)


> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
> index 58c4452b1f5..a3aeb5a8796 100644
> --- a/hw/arm/smmu-common.c
> +++ b/hw/arm/smmu-common.c
> @@ -981,7 +981,7 @@ static void smmu_base_realize(DeviceState *dev, Error **errp)
>           }
>   
>           if (s->smmu_per_bus) {
> -            pci_setup_iommu_per_bus(pci_bus, s->iommu_ops, s);
> +            pci_setup_iommu_per_bus(pci_bus, s->iommu_ops, s, errp);

Should we return if the caller returned false? More code could be added
at the end of this function.

>           } else {
>               pci_setup_iommu(pci_bus, s->iommu_ops, s);
>           }

