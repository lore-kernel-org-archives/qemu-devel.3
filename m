Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69C48CD98ED
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 08:52:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wa8Ta-0004iQ-7F; Thu, 18 Jun 2026 04:51:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wa8TZ-0004iE-BH
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 04:51:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wa8TX-0002Zp-IH
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 04:51:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781772709;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=sBi3Lp4of6vDvN6G2sBUsxDMYYuqHClU+KJJkNU0d+U=;
 b=W43und0jixxWMkmUL6oJej3vVZX/WO7W5CQuCO9Lfu/Y1L1L9iTooq6XvCNSpPLwk++Hqn
 3+UytlLSK5e2Rs8k8QMtVbKR2SgMYsSDPzxx94m4BU0++SIpbzFrR8VcHkbgrpiWpEl/LR
 12dMHrh8jmt0PHi8VQgJ6Wcp6Ggk9Kc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-533-gKZLtcdOOzaTv0hUtBFPkA-1; Thu, 18 Jun 2026 04:51:47 -0400
X-MC-Unique: gKZLtcdOOzaTv0hUtBFPkA-1
X-Mimecast-MFC-AGG-ID: gKZLtcdOOzaTv0hUtBFPkA_1781772706
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-45eec2ba533so532864f8f.3
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 01:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781772706; x=1782377506; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=sBi3Lp4of6vDvN6G2sBUsxDMYYuqHClU+KJJkNU0d+U=;
 b=AiZT2APs6wJ4a7VEzDJm5LXMmIVmhw63Zvr8GSNMPZ+4+w5eE5B5Lm6D2UYoTbmRdL
 0fINiivC0HIdIy4DTD8wWj8Errb5U0ss7tYpVFEpxD9wveDJJvhwPpvu2xkEaakuBD4f
 w6PMMSG4ybR47c2z1AcC9g7LhsX/79FWpWMKybQ5RY3Kbj+lgQmOtpXPmrpNC05xpyrZ
 fRXs+2wlNjjtjhWqrbiMf+CqdlbdF8tx1hcoiCkPaIAPlrS+cleULMeJibRzOaXSlh8B
 PKs6DHYI6cxFkzVs4geIY20OcmWcp1qCHMBsLuCnJejvA/7H9sx17u+OoGIcasXEQpCX
 3bhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781772706; x=1782377506;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sBi3Lp4of6vDvN6G2sBUsxDMYYuqHClU+KJJkNU0d+U=;
 b=qtrMjFjNZq9twc2W35NchHImCpHPtkPjOUyvGt9bpVlpzm5oCGiHCW8yu1xwiD5z1I
 VtS7+0sIGtEbtUHAcmXNmXSsrHhU0ZHV2pxRyYHx4NbbecOTGVC14ujV2rI5+HST5D5Y
 LOOk9Moc7AKb4ND1QQlTzdS8U3Ie2vTjuwEuDMt6kKtf+YXZ1p+/iNktJjCMpuGFOdLV
 jRTFZ/3WOdz7jFpoGfxwuN5TGo12IJ7XCcCQbW8pKnChGpgCY7xvyfjzYY/PFOlyrMtS
 7GX7UyFvIErEXfCzeSMddnG/Q1T4EojJXvV7Y6cydY+Vb+Het0DeNOJFz2AVrjnhdn1R
 q5zw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8vomSM84P6+S3qAu0NslSUrYBQf4Te1uLjaY5ZvKvgwrtVEmnsUoM2++LnX+AWiqY9VlAMq90B4SLB@nongnu.org
X-Gm-Message-State: AOJu0YxJQJx5+eFzB8sf7MqwJK0z2F0rPqHpubN9GRPNs5/5zYwF9hnr
 nZN6XckyQ0Gd+RAFCzthDtgci5U5VDjYHYHoqLKPY1f0gvvNm9WSJgGtLPeuCJ69B/MC1csMY77
 9YLMxQXUsC7IGCnAdJOzM46tngz3bfzK+M6+sCC7eI0kTT6e9tYRD5Jnj
X-Gm-Gg: Acq92OGWIeON6e/znSzIgL1kJtF7Yh21wh8niBuvRqxCoDI4WpJ4Le1oPw95qbxNm0n
 pMMd21CEUa9SkjYlX3PukMqz0vKIMuOws4hfVyfFk7R0Yhj5ytOIOTVaO3YKWnCXrjyEokDDBrw
 pBTKORmw6ajfc1M7vUzXXpzin6Ol1Hj7/gsioTntRQOXl3xT1jV/IVWFoJFo1Ql753OB4+gdeVk
 +u5c4zm0swI3qDV98mNHamxrXioO5wx3JPMtt/U9eoaEtwYksYyAbXPKn9//bMEpJrsEfRUHu8N
 w1D8YEZY9nOUQ5eXP8Btwz7pidKxq37gBWOhgmEsC44ReviTZWiQ8AxQ83P+D1vkJr6SWwis+mk
 dfUOHIFA=
X-Received: by 2002:a05:600c:8010:b0:490:bad9:de43 with SMTP id
 5b1f17b1804b1-492381a5b88mr45903265e9.0.1781772706399; 
 Thu, 18 Jun 2026 01:51:46 -0700 (PDT)
X-Received: by 2002:a05:600c:8010:b0:490:bad9:de43 with SMTP id
 5b1f17b1804b1-492381a5b88mr45902705e9.0.1781772705805; 
 Thu, 18 Jun 2026 01:51:45 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.114.89]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-462a9784497sm13611415f8f.34.2026.06.18.01.51.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jun 2026 01:51:45 -0700 (PDT)
Message-ID: <29376366-e35b-458f-86c1-ccbfcd0a8cfc@redhat.com>
Date: Thu, 18 Jun 2026 10:51:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 15/28] hw/i386/x86-iommu: Remove
 X86IOMMUState::pt_supported field
To: Peter Krempa <pkrempa@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>
References: <20260305105215.302571-1-thuth@redhat.com>
 <20260305105215.302571-16-thuth@redhat.com> <ajOkhPtZvUakzpoi@angien.pipo.sk>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <ajOkhPtZvUakzpoi@angien.pipo.sk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 18/06/2026 09.55, Peter Krempa wrote:
> On Thu, Mar 05, 2026 at 11:52:02 +0100, Thomas Huth wrote:
>> From: Philippe Mathieu-Daudé <philmd@linaro.org>
>>
>> The X86IOMMUState::pt_supported boolean was only set in
>> the hw_compat_2_9[] array, via the 'pt=off' property. We
>> removed all machines using that array, lets remove that
>> property and all the code around it, always setting the
>> VTD_ECAP_PT capability.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Message-ID: <20250501210456.89071-19-philmd@linaro.org>
>> [thuth: Dropped the hunks that were already merged via commit 31753d5a336f]
>> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> Message-ID: <20260225092024.794595-16-thuth@redhat.com>
>> ---
>>   include/hw/i386/x86-iommu.h |  1 -
>>   hw/i386/intel_iommu.c       | 13 ++-----------
>>   hw/i386/x86-iommu.c         |  1 -
>>   3 files changed, 2 insertions(+), 13 deletions(-)
> 
> [...]
> 
>> diff --git a/hw/i386/x86-iommu.c b/hw/i386/x86-iommu.c
>> index 33ac0bfc97e..a57445404ef 100644
>> --- a/hw/i386/x86-iommu.c
>> +++ b/hw/i386/x86-iommu.c
>> @@ -129,7 +129,6 @@ static const Property x86_iommu_properties[] = {
>>       DEFINE_PROP_ON_OFF_AUTO("intremap", X86IOMMUState,
>>                               intr_supported, ON_OFF_AUTO_AUTO),
>>       DEFINE_PROP_BOOL("device-iotlb", X86IOMMUState, dt_supported, false),
>> -    DEFINE_PROP_BOOL("pt", X86IOMMUState, pt_supported, true),
>>       DEFINE_PROP_BOOL("dma-translation", X86IOMMUState, dma_translation, true),
> 
> Sorry for necromancing this 3 months later.
> 
> This removes the 'pt' option from the 'amd-iommu' device too since
> it inherits from  X86IOMMUState. Libvirt does expose the setting for
> that option although I no longer remember why that was added.
> 
> I'm not sure based on the commit message though whether that was an
> intended outcome.
> 
> When updating the libvirt dumps of capability probing I unfortunately
> mis-read the diff and thought that 'pt' was added instead of removed so
> I didn't pay any closer attention:
> 
>   https://gitlab.com/libvirt/libvirt/-/commit/75edc7ae98938ae0548e4c368d9c291d3763289a
> 
> IMO since device properties are visible from outside changes like this
> should be mentioned in the 'deprecated.rst' document.
Drat, this should not happen, indeed.

The problem is that from QEMU's point of view, you can hardly distinguish 
any properties that were just meant for internal compatibility handling, and 
properties that are meant as config knobs for the users. In this case, it 
looked like an internal property only.

Now that we know that this has somehow been exposed to users, it's maybe 
best to revert the QEMU patch, WDYT?

  Thomas


