Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37BBFD2444F
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 20:24:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syzgk-0007Ei-UO; Thu, 10 Oct 2024 16:23:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1syzge-0007EP-Ci
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 16:23:05 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1syzgc-0004qa-2X
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 16:23:04 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-7cd8803fe0aso979970a12.0
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2024 13:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728591779; x=1729196579; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jkFF3qNCY1x8Ue0hcvOxIAXyaN5AUm18ox9WBSszISQ=;
 b=G69TT30hW2Fw352xa2JhFhKuFbgxT98owpLZytLx3bhOKGGE/hSr9NFnU+RN8xvBuo
 R9WZpXEVbgtnERKBc4QZkMzHjv20CbcMPLa+GsSvuVxzi2xhfZQEWAusutEpPikpCCoo
 QaFKs1UlLk0MCqO7BVDxhPoYXzmKWoR4rTaSsCflq+2291R9qAVfJmHwUDWk4h2dc0DI
 dMe0f3rc1LOqC3FD0gAUsxjtZLPpwil2zim1P4yvBHPTJOL6m0TXOG9Wm9MqBK32ydL8
 RjPmcuXuiaA7QygNYXedaYOyTIeufE7wj/R6ID3+ooS77qXZn0602JIFsLH8QekisOFd
 asAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728591779; x=1729196579;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jkFF3qNCY1x8Ue0hcvOxIAXyaN5AUm18ox9WBSszISQ=;
 b=jq9So+PJnXMRe4Pl4EBQ9TUif0/HVghDGa+FbYVDCV5Hoi4mfmf7zAjLPXQWYBfPwV
 RXMC1tx+yhXL7L/SahfG5EmvISItq9XvuBE/IQilAkZ/PNeYDF8B8ZpBEQJhukPeqH4m
 MD29yPAsPLaMwLDvyLcvDo9W+YPyfPdxZx/F0hGsD1+EfVFmaKRct/7PvqXl3zPR0R+2
 eajFhl1nnW2vANsPaQVjH8uTjPzDyR9O59Hzb9zKWDJWO7vQM3NMDt+rnpjz5QCweuUv
 7EoSY/3igV8gxJMm2/FCkRWillp7YCdsuZMHc1CnewAJZcts7XwNV8msC9cNAu/aE8b3
 jkDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUiKrhqV4E6okTrN41SH31s4hbdMkgsZXDzlvB41Esq79iuH20FosY4EsokSdAt2Z5HYTfJ83uUggJG@nongnu.org
X-Gm-Message-State: AOJu0YzO41c3acZKmwNmUULxjUzMb7eoweUQbd1e9KhKqR8yahin+ThB
 wfo+nqjOxkWUbJ9Roxk0vb5DEW4YGnugw86jnLVa75c8JXygWBSGsbnRu7FymKY=
X-Google-Smtp-Source: AGHT+IGg/gUwBAYNXGCWeY+X940cXCQsjkSBfiszWaJrhzqTTbMKfhOd+s67MPD0Awumx6CYlo91Qg==
X-Received: by 2002:a17:90b:1d8e:b0:2e0:80e8:a31a with SMTP id
 98e67ed59e1d1-2e2f0d9a498mr406353a91.35.1728591778774; 
 Thu, 10 Oct 2024 13:22:58 -0700 (PDT)
Received: from [192.168.100.35] ([45.176.89.169])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e2d5dd2c83sm1775054a91.3.2024.10.10.13.22.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Oct 2024 13:22:58 -0700 (PDT)
Message-ID: <0961097b-d1be-4651-aa95-74d00b62a842@linaro.org>
Date: Thu, 10 Oct 2024 17:22:54 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/12] target/mips: Remove target-specific code in
 mips_cpu_reset_hold()
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aleksandar Rikalo
 <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>,
 Anton Johansson <anjo@rev.ng>
References: <20240930091101.40591-1-philmd@linaro.org>
 <20240930091101.40591-12-philmd@linaro.org>
 <dade7ca6-71d0-40f8-9431-5d3fb4685bc9@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <dade7ca6-71d0-40f8-9431-5d3fb4685bc9@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=philmd@linaro.org; helo=mail-pg1-x530.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 3/10/24 20:01, Richard Henderson wrote:
> On 9/30/24 02:11, Philippe Mathieu-Daudé wrote:
>> Since all code creating vCPUs now set the 'cpu-big-endian' property,
>> we can remove the target-specific #ifdef'ry in mips_cpu_reset_hold():
>> the CP0C0_BE bit is set using the property cpu->is_big_endian value.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   target/mips/cpu.c | 3 ---
>>   1 file changed, 3 deletions(-)
>>
>> diff --git a/target/mips/cpu.c b/target/mips/cpu.c
>> index 02e2e72f2d..9724e71a5e 100644
>> --- a/target/mips/cpu.c
>> +++ b/target/mips/cpu.c
>> @@ -202,9 +202,6 @@ static void mips_cpu_reset_hold(Object *obj, 
>> ResetType type)
>>       env->CP0_PRid = env->cpu_model->CP0_PRid;
>>       env->CP0_Config0 = deposit32(env->cpu_model->CP0_Config0,
>>                                    CP0C0_BE, 1, cpu->is_big_endian);
>> -#if TARGET_BIG_ENDIAN
>> -    env->CP0_Config0 |= (1 << CP0C0_BE);
>> -#endif
>>       env->CP0_Config1 = env->cpu_model->CP0_Config1;
>>       env->CP0_Config2 = env->cpu_model->CP0_Config2;
>>       env->CP0_Config3 = env->cpu_model->CP0_Config3;
> 
> I think this must be merged into patch 8, or patch 8 doesn't work.

Correct.


