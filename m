Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B89CCD13CF
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2024 19:39:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slCtB-0002M4-IE; Mon, 02 Sep 2024 15:39:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1slCtA-0002Ks-0J
 for qemu-devel@nongnu.org; Mon, 02 Sep 2024 15:39:00 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1slCt8-00058B-A7
 for qemu-devel@nongnu.org; Mon, 02 Sep 2024 15:38:59 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-42c7a49152aso24873175e9.2
 for <qemu-devel@nongnu.org>; Mon, 02 Sep 2024 12:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725305936; x=1725910736; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AFMPcbPdmswI/B5zFybuc3j30wz6uVogtZxVdmXH7yw=;
 b=uL9ML+oqOyDZjQW/2E1vR2+tXpf3ApiHZI0kHnK7OtshVS+OujImWfRhOXLMtsAsjJ
 wwwVRqqDgSfJjf8tRab2pB5w6a6DSTWY0l6M+hADhf51mZy8gsm6TRMo9GBsIkDOxgC0
 /KnNzaQVNk+0XioidPMrvsVYRbI6VO2durdAB9A1iMTlOhLG/hhfAAeXAiu5xBANs48h
 fBZQ8YDN2HtDDRxJUDIZVizhsxPEJXt/QJvM9Vt2hyX57Bur73xxKcT81diD9rx1n8WW
 fWEODgeLO2SUY4PMq6PoMrzmMZoP7xK/qivc0dBahVY+Frn+JxMAOl+GJPZtH1ZD2mRJ
 3zrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725305936; x=1725910736;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AFMPcbPdmswI/B5zFybuc3j30wz6uVogtZxVdmXH7yw=;
 b=TrtSrJlaSovWIOgKNYYcL7qA1mLWIUHyUY+7hqmSRMKjKM7nmaRS7JHcpC/bIpkaX/
 lLNzCd0SHgW+9uFYQpgDYEvSzCCyD3Rm95IhWjOg8e85mfjvz9YwNwZGuA8eEId8Hjgs
 Ovso25daZ7SbliSFpg1ec+llhy4SexhSv+rRfZ54gB/sVb3N9p924CssrhTUKHnBOyrG
 DDsBNXMp7cHobmNSJkNpjPA+DqdLKvvupQ5PeFTrxoAPGq9wl6yUfM/4LngEnTHHBDA0
 vQIlozoaS3i1lVIz4Jx7p6UjliJwkyTRsFLMAZhdHcOO4sLQMJWwLvE93kVsSAkmfuR6
 d7yQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVoMvrO724cK0tKEIU9qX/+nojwgGsBMMEc/hYIOyUTSYRaRt14s3GUBXHG0ekZz1uptJJb9gfRXlg@nongnu.org
X-Gm-Message-State: AOJu0Yzmc+8ndPQvLYeKk4HVZwDjZZz9i40ECi+8rZkQEjiqfistG/YK
 GWWnZRn5tn3TgrFkQkKd7BsIHxAJKXU02e8KbXE1YkitxmdpFFVH/R/760wfVGY=
X-Google-Smtp-Source: AGHT+IHR6qspJEiqZ8IH1L0GkCh/8v7ecCjRiboYY8B4MlsCNCNceikjis674CXtUjzKt397LEu6dw==
X-Received: by 2002:a05:6000:c8e:b0:367:9903:a91 with SMTP id
 ffacd0b85a97d-3749b526808mr12341097f8f.11.1725305936096; 
 Mon, 02 Sep 2024 12:38:56 -0700 (PDT)
Received: from [192.168.1.67] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3749efb15b8sm12187072f8f.105.2024.09.02.12.38.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Sep 2024 12:38:55 -0700 (PDT)
Message-ID: <294a5480-d871-41e2-8e08-c1067f45d454@linaro.org>
Date: Mon, 2 Sep 2024 21:38:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] qemu/osdep: handle sysconf(_SC_OPEN_MAX) return value
 == -1
To: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>,
 Michael Tokarev <mjt@tls.msk.ru>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20240830111451.3799490-1-cleger@rivosinc.com>
 <20240830111451.3799490-3-cleger@rivosinc.com>
 <de7b12a3-7480-41b9-837a-880da9264dea@tls.msk.ru>
 <dd28ea4f-67eb-4c42-84d2-24956cde7896@rivosinc.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <dd28ea4f-67eb-4c42-84d2-24956cde7896@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 30/8/24 13:57, Clément Léger wrote:
> On 30/08/2024 13:31, Michael Tokarev wrote:
>> 30.08.2024 14:14, Clément Léger wrote:
>>> On some systems (MacOS for instance), sysconf(_SC_OPEN_MAX) can return
>>> -1. In that case we should fallback to using the OPEN_MAX define.
>>> According to "man sysconf", the OPEN_MAX define should be present and
>>> provided by either unistd.h and/or limits.h so include them for that
>>> purpose. For other OSes, just assume a maximum of 1024 files descriptors
>>> as a fallback.
>>>
>>> Fixes: 4ec5ebea078e ("qemu/osdep: Move close_all_open_fds() to oslib-
>>> posix")
>>> Reported-by: Daniel P. Berrangé <berrange@redhat.com>
>>> Signed-off-by: Clément Léger <cleger@rivosinc.com>
>>
>> Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
>>
>>> @@ -928,6 +933,13 @@ static void qemu_close_all_open_fd_fallback(const
>>> int *skip, unsigned int nskip,
>>>    void qemu_close_all_open_fd(const int *skip, unsigned int nskip)
>>>    {
>>>        int open_max = sysconf(_SC_OPEN_MAX);
>>> +    if (open_max == -1) {
>>> +#ifdef CONFIG_DARWIN
>>> +        open_max = OPEN_MAX;

Missing errno check.

>>> +#else
>>> +        open_max = 1024;
>>> +#endif
>>
>> BTW, Can we PLEASE cap this to 1024 in all cases? :)
>> (unrelated to this change but still).
> 
> Hi Michael,
> 
> Do you mean for all OSes or always using 1024 rather than using the
> sysconf returned value ?

Alternatively add:

   long qemu_sysconf(int name, long unsupported_default);

which returns value, unsupported_default if not supported, or -1.

> 
> In any case, the code now uses close_range() or /proc/self/fd and is
> handling that efficiently.
> 
> Thanks,
> 
> Clément
> 
>>
>> /mjt
> 
> 


