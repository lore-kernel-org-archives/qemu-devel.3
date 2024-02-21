Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B01A4C48BC4
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 02:09:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcc1u-0006px-9M; Tue, 20 Feb 2024 21:08:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rcc1m-0006bt-7O
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 21:08:06 -0500
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rcc1S-0006p1-Bs
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 21:07:59 -0500
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6e4560664b5so121649b3a.1
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 18:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708481264; x=1709086064; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MJnm+gdmmenYlSaxNOt2bVc0T5hc5BobZ/eJ52YN9EI=;
 b=rFSymLC69iFw2TvGKFPmSjoBIKP3C/fj+VXkwAUuDBQ4SkRhsRHEzzvYJLLWEqil/n
 eXk5JDja6YMyB9trgKUn1KQzUDU2M0HaRvxO5iTFejH0s9poKgFC56gLsSETplN4u8UX
 ssyIcsKrW7dSNtx4WPIFfMZ3SgL6QOoUOlTt53mj3CQLkIzNrPkgebvINpBbrXv/ul6g
 sMjIeqjssx94Ie1Tg3mLwBevuddTdTIGCY5Jsb7G34wxeUqoDe6Smw1TqIQTm3f0fWuB
 4IZcVaeXKusa1WL5zdNySERN8hfAon9a/KjiTJcNIfCjuAU/AlcKBLVa6jdGj0eSQarC
 k7Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708481264; x=1709086064;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MJnm+gdmmenYlSaxNOt2bVc0T5hc5BobZ/eJ52YN9EI=;
 b=JfefQLXTDgJM03i2mtvcLFuoL/boZr0vKlNpfHQDqaglsgJPOCM91Ur42oeLFopIiU
 zInkIrbaqM3DQfeTf3yjHmq0yeU1512PxvSvaG06XYPqBC02/oT3npKXLKjn209/S70u
 U5ejZVytFTru3hbChdzzoxUat+0dHWBt02bO0DV+Gt9MSFbxcg178NvLHpYLk9bZzQsk
 p3PpQ49ybtHU3/nl3j+E6GYgroI0DFzDaCPm+Pr6JeNNfajI/oNKBuJTo7JNlSCmpzrF
 +OpfnhGYPnqGdBcR/MGi+Du6cxhZnfErc8PDeBP1UfWhxDuEldSbTzcInpvZ8H4msQum
 pq3A==
X-Gm-Message-State: AOJu0YwyHXvFBrZGitg2ULca90m8rMQNlk70/smWi8CJh0iutFNdh0p0
 EbWkFVWx8M5b7ntxk+Ig6Vara7Qty0GKXtIN+FqhlZac8Z3aFlQOR+YZ09h4h1I=
X-Google-Smtp-Source: AGHT+IErxa5JRlO9hCxTcEd4AmiuRChm3IbEbnpf2hGmaML+1her1umGx10g83EQgmlmbqIWnI4AhQ==
X-Received: by 2002:a05:6a21:1693:b0:19e:98b3:a1e with SMTP id
 np19-20020a056a21169300b0019e98b30a1emr19198957pzb.55.1708481264354; 
 Tue, 20 Feb 2024 18:07:44 -0800 (PST)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 g29-20020a63521d000000b005dc491ccdcesm6339745pgb.14.2024.02.20.18.07.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Feb 2024 18:07:43 -0800 (PST)
Message-ID: <63284092-627d-4411-a21d-179b8dbf24e9@linaro.org>
Date: Tue, 20 Feb 2024 16:07:40 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/36] linux-user: Adjust SVr4 NULL page mapping
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Helge Deller <deller@gmx.de>
References: <20240215062018.795056-1-richard.henderson@linaro.org>
 <20240215062018.795056-3-richard.henderson@linaro.org>
 <87sf1s4p6a.fsf@draig.linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <87sf1s4p6a.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 2/16/24 01:35, Alex Bennée wrote:
> Richard Henderson <richard.henderson@linaro.org> writes:
> 
>> Use TARGET_PAGE_SIZE and MAP_FIXED_NOREPLACE.
>>
>> We really should be attending to this earlier during
>> probe_guest_base, as well as better detection and
>> emulation of various Linux personalities.
> 
> Do we know all our supported systems support this flag now?

We know that target_mmap() itself supports it, even if by emulation.


r~

> 
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> Acked-by: Helge Deller <deller@gmx.de>
>> Message-Id: <20240102015808.132373-3-richard.henderson@linaro.org>
>> ---
>>   linux-user/elfload.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
>> index b8eef893d0..e918a13748 100644
>> --- a/linux-user/elfload.c
>> +++ b/linux-user/elfload.c
>> @@ -3912,8 +3912,9 @@ int load_elf_binary(struct linux_binprm *bprm, struct image_info *info)
>>                  and some applications "depend" upon this behavior.  Since
>>                  we do not have the power to recompile these, we emulate
>>                  the SVr4 behavior.  Sigh.  */
>> -            target_mmap(0, qemu_host_page_size, PROT_READ | PROT_EXEC,
>> -                        MAP_FIXED | MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
>> +            target_mmap(0, TARGET_PAGE_SIZE, PROT_READ | PROT_EXEC,
>> +                        MAP_FIXED_NOREPLACE | MAP_PRIVATE | MAP_ANONYMOUS,
>> +                        -1, 0);
>>           }
>>   #ifdef TARGET_MIPS
>>           info->interp_fp_abi = interp_info.fp_abi;
> 


