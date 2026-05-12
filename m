Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2001CD4851
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 15:34:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMp6n-0001hX-Ui; Tue, 12 May 2026 11:33:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wMp6j-0001gv-Ie
 for qemu-devel@nongnu.org; Tue, 12 May 2026 11:33:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wMp6h-0007g5-N5
 for qemu-devel@nongnu.org; Tue, 12 May 2026 11:33:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778599994;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H5+xnXbVYTH65ka/uxiCb0qLOyxZQA+00M7WtNB18gU=;
 b=Pfqt6ZTsRwVox98h7bRXxUpgFaXFLF3wRkXE/d4UsafE72oSea5wh0wHYjtY/hFFGetQ7P
 PuOmUrLXMbj4/cNtl0Hqz6SMxg1T3U0dlySLTT8cpz5+fWLRbpQdT/FuAzKPGoydoCi6GO
 DuTaXpjssXX7BEv9s0b7mGvtcgnu+zQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-ElADHGCRNraSjM_P-envuQ-1; Tue, 12 May 2026 11:33:09 -0400
X-MC-Unique: ElADHGCRNraSjM_P-envuQ-1
X-Mimecast-MFC-AGG-ID: ElADHGCRNraSjM_P-envuQ_1778599988
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-48a55de6fb0so39653655e9.3
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 08:33:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778599988; x=1779204788;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H5+xnXbVYTH65ka/uxiCb0qLOyxZQA+00M7WtNB18gU=;
 b=mhseqqJULrFFzGn8XrTNlAg6C2oCqYYS4NFqtrf9XLQ2DQkI9t7fSKQSdLl4ShJAIw
 Tf9Vn+faChqSxJ8OlKNW7Y77i7Tv40dz/uWQRlffXix+6sT0wsGl2jqpyjs1bJyjAkEe
 f1ylsbYcqCr1lWlOEMEsD6sGhiepm02Uv5ChsC9J6OPbHhco0fOOnAo7xD06ltyug3Hl
 xH7twmQncFtJIvjC4wJ4CkTVRaaROIgFfpXV0F/bG1BYDiSSnyIL9UJ+xx5Ekl5ag8Wv
 S7YQ16V/LP7VsOdhPYshaTPnPkO+0Auwc2Ah7xJmpzuaYOguqn0wfHFfG1Oei4Aq7HKb
 9yrg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/s2aDzNXwr7mgexyiXyhp3QTzeDeNzHxpezlGbJ4TjAdB+sWgCDSIu3kFeE7GuJVeyHaiL0BYDgOfV@nongnu.org
X-Gm-Message-State: AOJu0YwdFuZF1TkRwsJ5H9JkmV/RyIrhinUUN5wuTWtImIAWERqplbXu
 GTem83ClCGkyyl0oBDpzqe/MvMpKo57zmrFEJh7lvEIVEjbIXtmiPGPet+gOLlaXcZqupHEQxRg
 EYGhfrzYVbPzjNsh1WvOQ+miCPGd1nlXqhhCaADVR4Sp/pRXpPHLyc9Se
X-Gm-Gg: Acq92OEOyFwY6wWaQnmDL+R7JDRxtDAaWIr3fSAZjWJh8w2CHNynijcCHfo5GZ3ZC/m
 HtgQQcLnIT8fGSU16Wo1UQeWjf1bw62sijVX+5dQtx4WWFRwZ+CKZpGpfWbfZcGcqCArcHs9zCB
 RQvwQBOGG/TKUMit1SDl2gAfcl28XijU4z3gosIsiKrKasqcUj7HVif8OJGcPlt+k9SvTzkenHf
 A7h+mu7jaCR/fvCGexJ1gJ5ZQUa1tYCgRkZusYRhNIY4AGfAn8yIFx9Ov1m7608Ae2WWtPU63zB
 wu5xY4NvJhdt4I0JJtUlVAlre0X++rgt2HDsTY2wT6NuJUjQQI6CmDoKe74BKCZ1Kn4f8HuA3CK
 T1t/1da8F+SbvAMK82AnmgWH8Xm9dHZumTW3Wm3VHfPUriXUIqgWClQ3vSOINlpi4tNH5hw==
X-Received: by 2002:a05:600c:8115:b0:48a:9540:1a3a with SMTP id
 5b1f17b1804b1-48e51e196f9mr472852465e9.8.1778599987866; 
 Tue, 12 May 2026 08:33:07 -0700 (PDT)
X-Received: by 2002:a05:600c:8115:b0:48a:9540:1a3a with SMTP id
 5b1f17b1804b1-48e51e196f9mr472851615e9.8.1778599987380; 
 Tue, 12 May 2026 08:33:07 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e8f445f83sm18667735e9.29.2026.05.12.08.33.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 May 2026 08:33:06 -0700 (PDT)
Message-ID: <ada244d4-0bfd-4bbd-b594-c3278a5570dc@redhat.com>
Date: Tue, 12 May 2026 17:33:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/17] arm/cpu: accessors for writable id registers
Content-Language: en-US
To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>,
 "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "sebott@redhat.com" <sebott@redhat.com>,
 "philmd@linaro.org" <philmd@linaro.org>
Cc: "maz@kernel.org" <maz@kernel.org>,
 "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "abologna@redhat.com" <abologna@redhat.com>,
 "jdenemar@redhat.com" <jdenemar@redhat.com>
References: <20260503073541.790215-1-eric.auger@redhat.com>
 <20260503073541.790215-10-eric.auger@redhat.com>
 <CH3PR12MB7548053696CA900F2A2349BDAB3C2@CH3PR12MB7548.namprd12.prod.outlook.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <CH3PR12MB7548053696CA900F2A2349BDAB3C2@CH3PR12MB7548.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 5/7/26 12:32 PM, Shameer Kolothum Thodi wrote:
>
>> -----Original Message-----
>> From: Eric Auger <eric.auger@redhat.com>
>> Sent: 03 May 2026 08:33
>> To: eric.auger.pro@gmail.com; eric.auger@redhat.com; qemu-
>> devel@nongnu.org; qemu-arm@nongnu.org; kvmarm@lists.linux.dev;
>> peter.maydell@linaro.org; richard.henderson@linaro.org;
>> cohuck@redhat.com; sebott@redhat.com; Shameer Kolothum Thodi
>> <skolothumtho@nvidia.com>; philmd@linaro.org
>> Cc: maz@kernel.org; oliver.upton@linux.dev; pbonzini@redhat.com;
>> armbru@redhat.com; berrange@redhat.com; abologna@redhat.com;
>> jdenemar@redhat.com
>> Subject: [PATCH v4 09/17] arm/cpu: accessors for writable id registers
>>
>> External email: Use caution opening links or attachments
>>
>>
>> From: Cornelia Huck <cohuck@redhat.com>
>>
>> Introduce ARM_FEATURE_ID_RANGE_IDX macro that converts opcodes
>> into the index used to access the 3 * 8 * 8 feature id array.
>>
>> KVM_ARM_GET_REG_WRITABLE_MASKS populates writable masks with
>> that indexing.
>>
>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> ---
>>  target/arm/cpu.h | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
>> index 2aa22360d2..0ac0fd13cf 100644
>> --- a/target/arm/cpu.h
>> +++ b/target/arm/cpu.h
>> @@ -886,6 +886,13 @@ typedef struct IdRegMap {
>>      uint64_t regs[NR_ID_REG_MASKS]; /* writable masks for registers */
>>  } IdRegMap;
>>
>> +#define ARM_FEATURE_ID_RANGE_IDX(op0, op1, crn, crm, op2)               \
>> +        ({                                                              \
>> +                __u64 __op1 = (op1) & 3;                                \
>> +                __op1 -= (__op1 == 3);                                  \
>> +                (__op1 << 6 | ((crm) & 7) << 3 | (op2));                \
>> +        })
>> +
> It looks like this macro is not used anywhere and in next patch it
> uses KVM_ARM_FEATURE_ID_RANGE_IDX instead.

Thanks for pointing this out. Removed that patch

Eric
>
> Please check.
>
> Thanks,
> Shameer
>
>
>>  /* REG is ID_XXX */
>>  #define FIELD_DP64_IDREG(ISAR, REG, FIELD, VALUE)                       \
>>      ({                                                                  \
>> --
>> 2.53.0


