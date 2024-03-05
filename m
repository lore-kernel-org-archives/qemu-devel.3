Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E64DC54E4A
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 21:52:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhchZ-00020n-0l; Tue, 05 Mar 2024 16:51:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rhchX-00020P-Gp
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 16:51:55 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rhchU-0005zD-Ov
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 16:51:55 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1dd10a37d68so24507525ad.2
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 13:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709675509; x=1710280309; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MmTCoQFF22gWf3auJi/F0Kgj95auySVB2PEJ0aGGck4=;
 b=UNJ2+Izzubb4ZmbcuxJDsi8O/KrBuMQfWFjebRfiwIOVzXSuILH+laFK67tbIruEUU
 I8hHrYh5DW15JOzLUQvoVXjp7OFP8Yazf6AMXBY5Ah9/4VAlm5R82VgFRQ5rK1K134CR
 OWBnKHPwmsoHRyh1kCBWq/BNisgKP97sX2eDm6KuR5Ek1mf7LkPXVOJb1yvnthO9vear
 7Vs8v7hDv6+YqIwIQGCzh9cH+zaKGBMlka9fPt8Jv9iM7hCuar1aZQhZ3Ya+O2cbxEsq
 8eC/8a9xIKNT8k/C4RVQrdWzk6w9fcwa/A8fMYV4HKy3LI4JHxEtqLEeDf/EVeP4/TIB
 dAEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709675509; x=1710280309;
 h=content-transfer-encoding:in-reply-to:references:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MmTCoQFF22gWf3auJi/F0Kgj95auySVB2PEJ0aGGck4=;
 b=QENy8LqfWUNNR/OjYw99qgSDGilziqnDHdlARoMbl6RKMEK5CkV12EbPSWa0AViOfB
 PLcNKw0fXnYC/Vg+iI+3lQwrBMsOlfmQaVFE9SYaarQc9CS14svtwlhzbvm69nl60pqo
 YeLG8P+Qg8Q46wnqEBLTNCdUiKrpFSPPdAF6FzyXcQTNUv3Tq8rDyJsj6i6KFP+97SkJ
 JvOzixSey+ihDVU5oh/c2egxW01PI9hgwgQpdjVO/b58kOxQ8u+aOBbbwWJcIe+fgESg
 d4G44MR3POpb7aswTVLBe2iPZGr4ppYWqzGrIiybnEQbNLyCdXB9ZulJfV3+Df+MhVBd
 2JNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSvaZTTqMJd8KbeAJCmIi9GexhmMHkXWV4GCnluaOe4A5bbfX65OCaf/l2c6XR4ZagGRgoAYxUTsg2THDR3X2aGHLGsgY=
X-Gm-Message-State: AOJu0YxFRW+FPAOk7nGAO63A+xvLBirDoW8ohoResqG7TbbinQLvV9MR
 oy5g9GaQaHgER6GjRpfkBFBsYCqtPt3XgF6Plb1VvOEvQ95EoRLM8PpVEBQnvss=
X-Google-Smtp-Source: AGHT+IHg99lbS4geSaB6M0AG03qeSjh1Q+DbTKXnvYG8A8Qo08Ff/1zAJxHcuLhv9yYQZlOyQrpb4w==
X-Received: by 2002:a17:902:d4cb:b0:1dc:fccb:e043 with SMTP id
 o11-20020a170902d4cb00b001dcfccbe043mr3074182plg.4.1709675509329; 
 Tue, 05 Mar 2024 13:51:49 -0800 (PST)
Received: from [192.168.6.128] (098-147-055-211.res.spectrum.com.
 [98.147.55.211]) by smtp.gmail.com with ESMTPSA id
 h12-20020a170902f2cc00b001dba356b96esm11131789plc.306.2024.03.05.13.51.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Mar 2024 13:51:48 -0800 (PST)
Message-ID: <675d3c62-9b6c-4a19-aace-3c1f57b6ebd5@linaro.org>
Date: Tue, 5 Mar 2024 11:51:46 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v6 17/23] hw/intc/arm_gicv3: Add NMI handling CPU
 interface registers
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>, peter.maydell@linaro.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20240305070331.2151131-1-ruanjinjie@huawei.com>
 <20240305070331.2151131-18-ruanjinjie@huawei.com>
 <1dd86523-572d-45be-baa4-6095981c5923@linaro.org>
In-Reply-To: <1dd86523-572d-45be-baa4-6095981c5923@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 3/5/24 11:50, Richard Henderson wrote:
> On 3/4/24 21:03, Jinjie Ruan via wrote:
>> Add the NMIAR CPU interface registers which deal with acknowledging NMI.
>>
>> When introduce NMI interrupt, there are some updates to the semantics for the
>> register ICC_IAR1_EL1 and ICC_HPPIR1_EL1. For ICC_IAR1_EL1 register, it
>> should return 1022 if the intid has super priority. And for ICC_NMIAR1_EL1
>> register, it should return 1023 if the intid do not have super priority.
>> Howerever, these are not necessary for ICC_HPPIR1_EL1 register.
>>
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>> ---
>> v4:
>> - Define ICC_NMIAR1_EL1 only if FEAT_GICv3_NMI is implemented.
>> - Check sctrl_elx.SCTLR_NMI to return 1022 for icc_iar1_read().
>> - Add gicv3_icc_nmiar1_read() trace event.
>> - Do not check icc_hppi_can_preempt() for icc_nmiar1_read().
>> - Add icv_nmiar1_read() and call it when EL2Enabled() and HCR_EL2.IMO == '1'
>>
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>> ---
>>   hw/intc/arm_gicv3_cpuif.c | 59 +++++++++++++++++++++++++++++++++++++--
>>   hw/intc/gicv3_internal.h  |  1 +
>>   hw/intc/trace-events      |  1 +
>>   3 files changed, 58 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/intc/arm_gicv3_cpuif.c b/hw/intc/arm_gicv3_cpuif.c
>> index e1a60d8c15..df82a413c6 100644
>> --- a/hw/intc/arm_gicv3_cpuif.c
>> +++ b/hw/intc/arm_gicv3_cpuif.c
>> @@ -795,6 +795,13 @@ static uint64_t icv_iar_read(CPUARMState *env, const ARMCPRegInfo *ri)
>>       return intid;
>>   }
>> +static uint64_t icv_nmiar1_read(CPUARMState *env, const ARMCPRegInfo *ri)
>> +{
>> +    /* todo */
>> +    uint64_t intid = INTID_SPURIOUS;
>> +    return intid;
>> +}
> 
> Needs to be implemented, similar to icv_iar_read.

Duh, see next patch.  :-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

