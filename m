Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88B3AC282EC
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 22:06:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ttDA8-00080y-Mq; Fri, 14 Mar 2025 18:05:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ttDA7-00080Z-A1
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 18:05:51 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ttDA5-00071I-Gh
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 18:05:50 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-225df540edcso21663795ad.0
 for <qemu-devel@nongnu.org>; Fri, 14 Mar 2025 15:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741989948; x=1742594748; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9fyPQrITOKaN5NY3m6rDId37G+HYo7WAzZajZfkdWP0=;
 b=mKoVSmpCZ3kWTIXpKmYmOCAdurAlGGfeqOIsl7YKZstZw6S7InLTdHCb0ZxCXqOpnj
 LmOE6BhNx/UXuvKLVxKqr2eGHU07Ar9+5GP7EcmBHkP4kdOfOgpMquQoTbHidqGccVg8
 fivEdfedL10FFYjDGXsIPf8J937NsoBG1MCmaZzUH1kgybsWdeRI+M0nLt8Pbs71ITKa
 bCfmIkXqL2Zdm4xjgdm1QAcYeZgCzsRRUW1I8kExxvUhhKz1QNdrfN4+28sCgHGYtk4w
 Qh7ZHPl+JPP5RQgtU3XZUIJjARPienOfCVzIHN01a+0m5wj9cNO1UJ2K9r8HOoaIZvuz
 pUpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741989948; x=1742594748;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9fyPQrITOKaN5NY3m6rDId37G+HYo7WAzZajZfkdWP0=;
 b=o4JJyoMSm96ghgKxxUmSAtUo+5CtsoMgbazayoj1t1u9P4rd1QVtJDH0F1CjtDXvWE
 mGqTVXeiqk0hljHkSKmSFJsk5EN4yPl2C31L8dqRqgUpj61qnCPdw9jD1KSVC+kXBI7x
 4T5KYdQ0mcE8t3qiY54C9h/P96jmVo/dAmI667DOfbhOesPurUsLNBBv5IziWjn0n+vV
 yQlGvxVcTHzrRaQiSEdX5sSNIpSeBEiB2rWahZ1RwcnWt8pUUe7gRUGgdx5U9EISsD2V
 /EDWZb9ZPRjNgzlGEzIb6e52PKUNkqLiHoa/S6G5z0pEdpIudIclpgRYn859DySjYxM3
 BoFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW92r2aJgSm+WVWperfY7h3s+WHCyRFdlp1Y5+LywaV12A8TU6y3pwl+21HeC8LwvqxvJZQmDhHOOkD@nongnu.org
X-Gm-Message-State: AOJu0YwXJlem3nTfzeqkDJuwOJHg3rLZ0y5G7KwYYHovRYFfjM88hpZ3
 v/JMarXnq4qXqmhwoC3dFt9Ulrvoiwo2u595/gpFeoGckFW+X6E4t9SVi9SMvkU=
X-Gm-Gg: ASbGncty64LorFSQu27dTZOrZc3Y335nuzSk4nvL31+7fT6edG4266ha/m8Gau6F+Pf
 Smf69gRikJ9uNmDenIHd5VJ7XqYRhV6dp83Ak9AzfLpi4aeQyKtGjvb/MEdrXHyaO4wHbpzo7Yr
 9jzF5s+adg6iQNQU1ohrjtGZakcv+WBoLOSmdlDoV93cKygf9PHxBkZ5BtW6Ue+L3uMEWw7vkqH
 x5fGQMkOm/i6G97HmfwD9vrIXezeg2O84ZMoVMlRrUy5TVpxG4YHlZGtIJ51dLJYqoiQcHKzOeB
 YsQDIsOMsFhSj71aPL1kJD6+rYaTOF3PLiHgkR+eSHa4FwJQyl2eEcC1DcTVt13WoAld
X-Google-Smtp-Source: AGHT+IFwPP0xbIQjeTRTO+LP84mJYjWIod3RkTNt8DGEVasFmdk9Y+sqDVTNr0auYGU611kkrQ0rdA==
X-Received: by 2002:a05:6a21:700b:b0:1f3:1e5c:c655 with SMTP id
 adf61e73a8af0-1f5c2804547mr5686003637.6.1741989947645; 
 Fri, 14 Mar 2025 15:05:47 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7371167e0a6sm3351492b3a.116.2025.03.14.15.05.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Mar 2025 15:05:47 -0700 (PDT)
Message-ID: <4117f7f8-f4a5-452b-9b25-2afa3066a596@linaro.org>
Date: Fri, 14 Mar 2025 15:05:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 32/37] include/hw/intc: Remove ifndef CONFIG_USER_ONLY
 from armv7m_nvic.h
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, philmd@linaro.org
References: <20250313034524.3069690-1-richard.henderson@linaro.org>
 <20250313034524.3069690-33-richard.henderson@linaro.org>
 <7f665a47-2bba-4c3a-980c-a252ec44723c@linaro.org>
 <807dbc0d-db15-4bd3-95f3-b3e87951bd7f@linaro.org>
 <42b1f9f3-2ed4-461b-9460-0318011097ee@linaro.org>
 <e3d39823-734e-4186-95b6-07717663bdf2@linaro.org>
 <ad7cd476-1830-4806-b4d2-20d8456af849@linaro.org>
 <7f10a102-5cea-4543-bae0-927e89e8e471@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <7f10a102-5cea-4543-bae0-927e89e8e471@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62a.google.com
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

On 3/14/25 13:59, Richard Henderson wrote:
> On 3/14/25 13:34, Pierrick Bouvier wrote:
>> On 3/14/25 13:03, Richard Henderson wrote:
>>> I'm not quite sure what you're arguing for here.
>>> A build-time error is vastly preferable to a run-time error.
>>>
>>
>> Even though this specific patch is safe (code calling those functions should be under
>> system anyway, so it should not be linked in a user binary), I just wonder if we should
>> not add explicit checks for this, for other kind of replacement we'll have to do.
> 
> Any such runtime check should not be for "system" vs "user", but for "feature enabled".
> 

 From our build system point of view, I don't really see what is the 
difference. That's part of why I insisted previously on cleaning user vs 
system ifdefs at the same time we make files common, but the answer I 
had was "We don't need to do that now", so I stopped arguing.

When building user vs system, we use ifdef to detect this case, and we 
select different implementations and include a specific set of source 
files, the same way we do for some features, or specific targets. So, 
why should it be treated differently, or later?

>>> If it's a lesser used configuration or feature, a run-time error could lay dormant for
>>> years before a user encounters it.
>>>
>>
>> Sure, but wouldn't it better to have an explicit assert, instead of observing a random
>> behaviour?
> 
> What random behaviour are you suggesting?
> 

In case we return a stub value by accident, when you expect to have a 
side effect done somewhere. And that it would not result in an immediate 
crash, but later at a random place.

Maybe the case just does not exist, but my point was that it does not 
cost anything to add an assert just in case.

>> I'm just worried we end up calling something we should not (user vs system, or any other
>> ifdef CONFIG/TARGET that might be hidden somewhere), and silently return a wrong value,
>> which would not be covered by our test suite.
> 
> Where is the wrong value going to be returned from, the stub?
> Yes, many stubs do abort, typically after the "enabled" stub returns false.
> 

Many, but not all of them I guess.

> It's still best if "feature enabled" is compile-time false when possible, such that
> everything after the feature check gets compiled out.  At which point we don't need the
> stubs: they won't be reachable and errors are caught at build-time.
> 

Sure, but as we saw, it's not always possible, because some calls are 
under: if (X_enabled()) {...do_X()...}, which requires to be able to 
link do_X even though it will be dead code at runtime.

Maybe my concern is unfounded, but seeing some of the inline stubs and 
the ifdefs associated, I hope we won't miss a corner case.

> 
> r~


