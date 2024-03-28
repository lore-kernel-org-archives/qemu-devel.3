Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EFA8C54E67
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 13:20:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rppg4-00083O-Gh; Thu, 28 Mar 2024 09:20:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rppg2-00081N-87
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 09:20:18 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rppg0-0003Dl-Jq
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 09:20:17 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-56c1364ff79so1120707a12.1
 for <qemu-devel@nongnu.org>; Thu, 28 Mar 2024 06:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711632015; x=1712236815; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=puu8VyzDLKwHhThbmkafeK4qzBVEG9kdut4ENHl8flg=;
 b=RbHSQmkEDP0ocDhfi6Vlz0XDozBcWkPAsPI4dBQe6mHuQg/+ApszVmHPNGXqbhT3ma
 /OS1vIurJ7heZYL2GRsRwUTge0Dvre9/MlPcJ5K1HRcyH2K50XaE+NMGqUddjGRAsxR5
 f/98nTzjoqmg6bkw6E9b8LZ8iSfwImyZ/Twv2VgaCHNqKlPnDfApINqqeiId+3cicG5j
 4A0AkhWc5rq7tA3BydvzE91/cCof6pyDGb1WKUl3QST4NhMHNp0JOcG8xQHwUQ8LCDa5
 696nf6BttDrr2lzo6P0zetAwBSwTmXGnWFetvPohtK56b6SDSs1IvUk0WzK2x11pisds
 2iFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711632015; x=1712236815;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=puu8VyzDLKwHhThbmkafeK4qzBVEG9kdut4ENHl8flg=;
 b=oXwemZokHR0O6hB11SaYyo/fo4+9ppTw5o/21POgIIEnCm0IYiSdJT6AwyOqHcy17p
 bZo64YCfgRMQRm4XTAcbsSYttdQNu7LtFNP6EVtEVwOnhAMg4mRTTf8pF41c8Ozxl26K
 e0G/lxgd2MomonWEvUpuDIJN0rMv9h0myJO4ySM4ezIgaFE2p/cxM02gIbB9MspsOYBr
 1yK8+jqm+/d89HQXNuQ3eDAKJ2Y+k3AyILXv1soYib+AIRNlvV7orOWKBwVUUEHdBVXE
 694xNqCo+CtvtB5Od6s+aFU7fkcMxyfQWNnMcp5CRemVpZgxNYb6FJKWAQzK1YUu7VK8
 YYVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXO+6I+4fRXBqAPtsg+EfVClWcFtlETYpbsCPLYTDKZ7Eo7Svu3kU2q4qxRO0MPg46un+Ws/1ERsm5FPUg6i7dVysP/Fk4=
X-Gm-Message-State: AOJu0YzjdDxTpzMIJ5qenGbhz0R/QnSjXxCpoSLu/18VSk5ThwgWQUM6
 yJ6ouuyN2t51rwibb/tnGwh3BR5iuUN6iBm7z9gUnSB30/HHbgKlGM4CORPgPgA=
X-Google-Smtp-Source: AGHT+IGqNBMgqRE7be7Nh5XXUNzB0Z3KrJbimGHOJfbtzVe8baOWYcc93Yp/DyAl125tmgHMqJ9s8Q==
X-Received: by 2002:a17:906:380f:b0:a47:4b3e:a966 with SMTP id
 v15-20020a170906380f00b00a474b3ea966mr1933363ejc.75.1711632014939; 
 Thu, 28 Mar 2024 06:20:14 -0700 (PDT)
Received: from [192.168.69.100] (pas38-h02-176-184-5-52.dsl.sta.abo.bbox.fr.
 [176.184.5.52]) by smtp.gmail.com with ESMTPSA id
 r1-20020a170906364100b00a4628cacad4sm744180ejb.195.2024.03.28.06.20.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Mar 2024 06:20:14 -0700 (PDT)
Message-ID: <51e36448-5212-40cb-8135-078a3c1b96c8@linaro.org>
Date: Thu, 28 Mar 2024 14:20:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] target/ppc: fix tlb flushing race
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240328053131.2604454-1-npiggin@gmail.com>
 <D058D0G7Z2DX.L8OBHHBGWGU4@wheely> <D05AZMB7725S.27E3ZJNW7GJAF@wheely>
 <D05BGFTTYF1C.1PG514RTVTZTD@wheely>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <D05BGFTTYF1C.1PG514RTVTZTD@wheely>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 28/3/24 11:37, Nicholas Piggin wrote:
> On Thu Mar 28, 2024 at 8:15 PM AEST, Nicholas Piggin wrote:
>> On Thu Mar 28, 2024 at 6:12 PM AEST, Nicholas Piggin wrote:
>>> On Thu Mar 28, 2024 at 3:31 PM AEST, Nicholas Piggin wrote:
>>>> ppc broadcast tlb flushes should be synchronised with other vCPUs,
>>>> like all other architectures that support such operations seem to
>>>> be doing.
>>>>
>>>> Fixing ppc removes the last caller of the non-synced TLB flush
>>>> variants, we can remove some dead code. I'd like to merge patch 1
>>>> for 9.0, and hold patches 2 and 3 until 9.1 to avoid churn (unless
>>>> someone prefers to remove the dead code asap).
>>>
>>> Hmm, turns out to not be so simple, this in parts reverts
>>> the fix in commit 4ddc104689b.

Please mention that in the patch.

> Do other architectures
>>> that use the _synced TLB flush variants have that same problem
>>> with the TLB flush not actually flushing until the TB ends,
>>> I wonder?
>>
>> Huh, I can reproduce that original problem with a little test
>> case (which I will upstream into kvm-unit-tests).
>>
>> async_run_on_cpu(this_cpu) seems to flush before the next TB, but
>> async_safe_run_on_cpu(this_cpu) does not? How does it execute it
>> without exiting from the TB?
> 
> Duh, it's because the non-_synced tlb flush variants don't use
> that for running on this CPU, they just call it directly.
> 
> Okay that all makes sense now. I think this series plus the
> below are good then. Also it's possible some other archs that
> use _all_cpus_synced() (arm, riscv, s390x) _may_ be racy. I
> had a quick look at sfence.vma and ipte, and AFAIKS they're
> supposed to take immediate effect after they execute.
> 
> Thanks,
> Nick
> 


