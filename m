Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DCE6C25B74
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2024 11:13:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5OBT-00088Y-R5; Fri, 10 May 2024 07:13:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1s5OBS-00087Z-1o
 for qemu-devel@nongnu.org; Fri, 10 May 2024 07:13:02 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1s5OBQ-0008FL-4n
 for qemu-devel@nongnu.org; Fri, 10 May 2024 07:13:01 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1e4bf0b3e06so16753465ad.1
 for <qemu-devel@nongnu.org>; Fri, 10 May 2024 04:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1715339577; x=1715944377; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5qISlrsjj5Eu77+J0bao0L8lTrhi/xHbg/hBlxNZHIc=;
 b=E2b7/ZYCfdXR9oJUgu2+xI9dwcBzf+VKfToPY15O8qFTq3cXBE5Hg4YGKfqrx70V12
 Tp71CUdgAR8qMlTK0r9Bl2aVA8rUP8bq/NnCcupcIWwI0tctcUTSnEmdDuHAgi/TMYm6
 ROIyv39vfoU2YLyi93eFIuQVVSMb6Urul3qbThsOK8/6jm86DFpfFpJV0GA8MfvNPFPl
 NrYmYZ0CTVQzmrniHvk++J950ueOZ3JkOlAvETrjJQWYvQovRaNNXXfJqxqqIt0aCkEr
 3cvpTs35S/8maXU1bUdoWvB8Un1q6A9oJvYTV5gAiesE/LqiBBGL3ELrSJnFcDajH4so
 Q+DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715339577; x=1715944377;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5qISlrsjj5Eu77+J0bao0L8lTrhi/xHbg/hBlxNZHIc=;
 b=Uy/Tihw6CyvrvSEQ75Z/I1l2oJrR79OV9hiO2VKlLj+WE9Y93qO9v7K07mr7e+DezJ
 iAeihAdG+eKHu4O6VWTugjFpLZDGwHtwl3YV9Cv0F8xvxQsxr36qdoRNT9igI2TeInjD
 m5TgomkeZNf3YT5YT9jUVRbmefARa5bRCZhcXrQLOXOfRsngGh27DFJDM8EJ9nZD5jnq
 q/AG3KUV05TQRNPje2D/+ELXv9iInADObUVTWufxeazZ1I5FNYdTK3uUKcHvhI52e4Q+
 YqvnLK+NfHV+9cYapB1SaGGBMgpvaAwg8EI4I71WnJE5a7h+WGzy5YGUqiMaF1HGXHCu
 7LRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWm4ZlBHH9bWmxbS1xl+1g0m//+z/X3MsvOjbxIEI++3HiTqx5vXbl0o/uaiQ0FxsXj2+R1M07gXb0vzn/tQc7zpI6SOqU=
X-Gm-Message-State: AOJu0YyDWK6n7ONyysD2h7b7WyKuIZChUZh/4AexmyuN5cy7QlUnA5b1
 VjnpR0oZC+5rcoCe38VZFY0oIERy/sVA6IIp9SmZwzYK9guMPn8wqtjJRMnGQWk=
X-Google-Smtp-Source: AGHT+IHHRGxzR7weYtbqaShE+Ilj2TcOXwOby5lNzKmjxuX1Tc5P2Lzw3NfIzvduZ/KIvrw3O5+3FQ==
X-Received: by 2002:a17:902:ba8a:b0:1eb:acff:63bf with SMTP id
 d9443c01a7336-1ef43e26591mr20835005ad.37.1715339577602; 
 Fri, 10 May 2024 04:12:57 -0700 (PDT)
Received: from [192.168.68.110] ([177.94.42.168])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ef0bf31989sm29603445ad.173.2024.05.10.04.12.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 May 2024 04:12:57 -0700 (PDT)
Message-ID: <e7fd3556-1076-4a10-b9da-1ee894f8dd98@ventanamicro.com>
Date: Fri, 10 May 2024 08:12:53 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: Remove experimental prefix from "B"
 extension
To: Andrew Jones <ajones@ventanamicro.com>
Cc: Rob Bradford <rbradford@rivosinc.com>, qemu-devel@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>
References: <20240507102721.55845-1-rbradford@rivosinc.com>
 <20240508-ff6bfb7f94499a3a8d6382f6@orel>
 <a53ac495-4656-4786-ba90-d83169aaffad@ventanamicro.com>
 <20240510-bd3888b24a94d2a7cbbb9b96@orel>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240510-bd3888b24a94d2a7cbbb9b96@orel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62a.google.com
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



On 5/10/24 05:29, Andrew Jones wrote:
> On Thu, May 09, 2024 at 02:23:42PM GMT, Daniel Henrique Barboza wrote:
>>
>>
>> On 5/8/24 08:22, Andrew Jones wrote:
>>> On Tue, May 07, 2024 at 11:27:21AM GMT, Rob Bradford wrote:
>>>> This extension has now been ratified:
>>>> https://jira.riscv.org/browse/RVS-2006 so the "x-" prefix can be
>>>> removed.
>>>>
>>>> Signed-off-by: Rob Bradford <rbradford@rivosinc.com>
>>>> ---
>>>>    target/riscv/cpu.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
>>>> index eb1a2e7d6d..861d9f4350 100644
>>>> --- a/target/riscv/cpu.c
>>>> +++ b/target/riscv/cpu.c
>>>> @@ -1396,7 +1396,7 @@ static const MISAExtInfo misa_ext_info_arr[] = {
>>>>        MISA_EXT_INFO(RVJ, "x-j", "Dynamic translated languages"),
>>>>        MISA_EXT_INFO(RVV, "v", "Vector operations"),
>>>>        MISA_EXT_INFO(RVG, "g", "General purpose (IMAFD_Zicsr_Zifencei)"),
>>>> -    MISA_EXT_INFO(RVB, "x-b", "Bit manipulation (Zba_Zbb_Zbs)")
>>>> +    MISA_EXT_INFO(RVB, "b", "Bit manipulation (Zba_Zbb_Zbs)")
>>>>    };
>>>>    static void riscv_cpu_validate_misa_mxl(RISCVCPUClass *mcc)
>>>> -- 
>>>> 2.44.0
>>>>
>>>>
>>>
>>> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
>>>
>>> I think we should also either change the false to true for RVB in
>>> misa_ext_cfgs[] or at least ensure RVB is set for the 'max' cpu
>>> type in riscv_init_max_cpu_extensions().
>>
>> I prefer if we keep misa_ext_cfgs[] as is. Changing the defaults in this array
>> will also change the defaults for rv64. IMO we should enable RVB manually in
>> riscv_init_max_cpu_extensions().
>>
>> We already have some precedence for it: RVV is enabled in 'max' while is default
>> 'false' for rv64.
> 
> But do we care if rv64 gets B? rv64 doesn't have any particular set of
> extensions, afaik. And B seems like it should be generally adopted enough
> to be in a "general" cpu type like rv64. Anyway, either way works for me
> as long as 'max' gets B one way or another.

Yes, as long as we enable it in 'max' it's good enough for this patch.

It's not like we're enabling extensions in rv64 just because they were ratified
(e.g. RVV isn't enabled in rv64), so even if we want to enable RVB in rv64 I'd
rather do it in a separated patch with a proper justification.


Thanks,

Daniel

> 
> Thanks,
> drew

