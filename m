Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 526DAC48BF6
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 09:28:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riA2O-0006uW-LT; Thu, 07 Mar 2024 04:27:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1riA2N-0006uB-Hn
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 04:27:39 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1riA2L-00060a-9Q
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 04:27:39 -0500
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6e5eaf5bb3eso534430b3a.3
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 01:27:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1709803655; x=1710408455;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+K34qILXQwio7+NMf8rNd2DN2h1j2oeVjLjxP/7s6y4=;
 b=qxq/XWqmzPi+oR5ASiSMLM+12EjurTYKIPX0l0q+G8NpC3wbGLfWlhpX0CxmmcrgKi
 7ON59a6Z7Q0mmWqzBohA8qn7eSWt1hzoXCQ1LuZq8UGvcOLU17L0En4HCxOSMHTTIt46
 NhOtUeglzDg0QQgYSJUClONVEOKCWVrqpzy1IimmjLrG+CQhmxUVQ9BP3IS9PbHUzDNr
 3MkPErE2GD/rFK3IKxBS9GsI5xqWjAWHbuKrOfWh7nbliD85C1HqHQTAaQZgNPL6zz21
 6nEGYsMw/YTpOtK+yIsrzN3pmbBUb7puVJrvoQe3VrtpLIY6p53QNJc1miocjT8Hh+G1
 C5yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709803655; x=1710408455;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+K34qILXQwio7+NMf8rNd2DN2h1j2oeVjLjxP/7s6y4=;
 b=uNP3e5zM95TJ9B0u/Xxk+zTT7EsTWSF1mnNORYpyLOzCbylTEkJoHp3Uhl/RB1c2gq
 YPxCVyQl0RUMYvbeLqn8bvJIBG3wsVDVMTrmBNXSJeddX35BHcYtHivHW4ePJPID7YOf
 7c/HV8K2kIW288QJdsIB5k5MkbFqmPRNzz/WHpfsBy62T81AOOkABMFmum4OyCgD3x5q
 qEHcMNaTn683jePIwknU4qMJJgk1H/t13ROlzSYQ0GuX6uOdESkl7j1M8Wmy5W88sHTe
 4v+AXXIOzFFS8n5vHavsMz92hmXl7czWmvi99tIGUn9dl55zhHdaLIqlPijrGgz0Kf18
 IuzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyhbN+JtoJ0fZ2cH5MHAvV/ZZ4Zc/+L6BKbbm1c1d3HedkVXKsOSmZvwTaXCx8XebkG0lWMpF9lha0A+HD91rKX/TH/m0=
X-Gm-Message-State: AOJu0YzyN32YFl8/kBZmLiTIawJVK4BC2m48zIUYxWkOnuPMMM9Yxsjl
 k+s4mB958fux2U7NFt63USnun1LsO4vK6gttV1Td3yWR8EvSWPv1gziAMNwjfsQ=
X-Google-Smtp-Source: AGHT+IEWRx9ZteKqCLE38IraS++s/hfA0C/rRZ6lXfoV+RIjwA70H5uAqqPgSgjLwdtBICsQA5S8PA==
X-Received: by 2002:a05:6a00:929a:b0:6e6:2462:d66 with SMTP id
 jw26-20020a056a00929a00b006e624620d66mr12317464pfb.3.1709803655169; 
 Thu, 07 Mar 2024 01:27:35 -0800 (PST)
Received: from [172.16.0.23] (c-67-188-2-18.hsd1.ca.comcast.net. [67.188.2.18])
 by smtp.gmail.com with ESMTPSA id
 c9-20020aa78c09000000b006e56da42e24sm12082837pfd.158.2024.03.07.01.27.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Mar 2024 01:27:34 -0800 (PST)
Message-ID: <26ac4108-640f-41f9-884e-ed6b4e058935@rivosinc.com>
Date: Thu, 7 Mar 2024 01:27:33 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/5] target/riscv: Add cycle & instret privilege mode
 filtering properties
Content-Language: en-US
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, Weiwei Li <liwei1518@gmail.com>, kaiwenxue1@gmail.com
References: <20240228185116.1321730-1-atishp@rivosinc.com>
 <20240228185116.1321730-3-atishp@rivosinc.com>
 <2cff52d0-be4d-4f39-be24-cb8b4a7bb96c@linux.alibaba.com>
From: Atish Patra <atishp@rivosinc.com>
In-Reply-To: <2cff52d0-be4d-4f39-be24-cb8b4a7bb96c@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=atishp@rivosinc.com; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


On 3/4/24 23:01, LIU Zhiwei wrote:
>
> On 2024/2/29 2:51, Atish Patra wrote:
>> From: Kaiwen Xue <kaiwenx@rivosinc.com>
>>
>> This adds the properties for ISA extension smcntrpmf. Patches
>> implementing it will follow.
>>
>> Signed-off-by: Atish Patra <atishp@rivosinc.com>
>> Signed-off-by: Kaiwen Xue <kaiwenx@rivosinc.com>
>> ---
>>   target/riscv/cpu.c     | 2 ++
>>   target/riscv/cpu_cfg.h | 1 +
>>   2 files changed, 3 insertions(+)
>>
>> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
>> index 1b8d001d237f..f9d3c80597fc 100644
>> --- a/target/riscv/cpu.c
>> +++ b/target/riscv/cpu.c
>> @@ -169,6 +169,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
>>       ISA_EXT_DATA_ENTRY(zhinx, PRIV_VERSION_1_12_0, ext_zhinx),
>>       ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
>>       ISA_EXT_DATA_ENTRY(smaia, PRIV_VERSION_1_12_0, ext_smaia),
>> +    ISA_EXT_DATA_ENTRY(smcntrpmf, PRIV_VERSION_1_12_0, ext_smcntrpmf),
>>       ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_smepmp),
>>       ISA_EXT_DATA_ENTRY(smstateen, PRIV_VERSION_1_12_0, ext_smstateen),
>>       ISA_EXT_DATA_ENTRY(ssaia, PRIV_VERSION_1_12_0, ext_ssaia),
>> @@ -1447,6 +1448,7 @@ const char 
>> *riscv_get_misa_ext_description(uint32_t bit)
>>   const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
>>       /* Defaults for standard extensions */
>>       MULTI_EXT_CFG_BOOL("sscofpmf", ext_sscofpmf, false),
>> +    MULTI_EXT_CFG_BOOL("smcntrpmf", ext_smcntrpmf, false),
>>       MULTI_EXT_CFG_BOOL("zifencei", ext_zifencei, true),
>>       MULTI_EXT_CFG_BOOL("zicsr", ext_zicsr, true),
>>       MULTI_EXT_CFG_BOOL("zihintntl", ext_zihintntl, true),
>
> We should not add the configure option for users before the feature 
> has been implemented for bitsect reasons.
>
ok. I will move it to the patch where the feature is actually implemented.


> Thanks,
> Zhiwei
>
>> diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
>> index 833bf5821708..0828841445c5 100644
>> --- a/target/riscv/cpu_cfg.h
>> +++ b/target/riscv/cpu_cfg.h
>> @@ -73,6 +73,7 @@ struct RISCVCPUConfig {
>>       bool ext_zihpm;
>>       bool ext_smstateen;
>>       bool ext_sstc;
>> +    bool ext_smcntrpmf;
>>       bool ext_svadu;
>>       bool ext_svinval;
>>       bool ext_svnapot;

