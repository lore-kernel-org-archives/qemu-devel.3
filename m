Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A62E0CD5BAC
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 19:54:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQVwL-0005v5-QY; Fri, 22 May 2026 15:53:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQVwH-0005ol-Or
 for qemu-devel@nongnu.org; Fri, 22 May 2026 15:53:46 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQVwG-0002iE-2R
 for qemu-devel@nongnu.org; Fri, 22 May 2026 15:53:45 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2bc85eda6b6so39270715ad.1
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 12:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779479621; x=1780084421; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xtGS3b+AkFKVQp3luYBT4nrzed8IdHb22XzX7stXo5o=;
 b=qn8pzK179C5OJgMKLwGZ2UakRQIMubAfmaU1brrbe+TNJ8s7+GJdYY3ARpDGb2ED/1
 rigj3yRELKjsQ5vSsi0+oqGyAdAZOHxoUc0rWyd45xYWTS8JJ7v58PDMWou2Q/ejMUTb
 eeM6MW4LTrchlaWJEo7xus7CJyr2znlpcbwbSbnAyhLF8iDg0ENWyVtHkS5DWGPT4iZl
 s49WWen9r9yroOGFXKGBeZXPUxZW9AeVnJfQEFmrWUV9LFxFpfDsIyVeIbej1brxV++g
 R2QJoquu87pEeCvKT6N7uCpd8lRcYEsCW3U1njCmOLC3/Td2AZCPVdlVwky1FNUt0CtT
 DtuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779479621; x=1780084421;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xtGS3b+AkFKVQp3luYBT4nrzed8IdHb22XzX7stXo5o=;
 b=NJbEVz7SAAbFMsa1GDirH4m+++3m8fXCi7Gv6aFLFZIrAOSj1Rsc+Tg84KE9k4xIHM
 klYlXjNcvJunMq5vq4JGW3GlufZyapHe3uNLF706crK8jD4mM9owebOaDXhrCthkRKdE
 n85kkhfOtpkt0pjIGF4DnZpKXTBxfHGb2dsMNdD7gRx4xoF4qd5WY2xyI6i5l0qSQhw1
 i6mW+d2GeJ5EPndzsZGDFyJDKrgtSVOlYYJ+YxYza0lRAiTnEm4apdb+AiifQTYJVnbX
 El6L9QzyywGKol9n1FakZrbHONlXIo4qI5ElEiiX5JGZ9/c9FBujzTJYiK8Qpltf+hju
 rWPQ==
X-Gm-Message-State: AOJu0YwtATmhY4SQltXgvenadcACqTtOgP0QXisILsm8qLhaJZtU/REI
 DHVFqjCB8IdQU/ek2P4lobKIKMI5KXRBGu7Co313nyUX2BY6MmrwDDR6Hf+5Ue7tQCM=
X-Gm-Gg: Acq92OFfOiRtA9nH62sh8ZUffJENeUOfgMqzhwrLDHR35L8/ZFMK1jSCCYHE226KSq7
 DNj+YsJ7KtgmzpvHgvjPBuMoAubFpCc+50gGuSYJ87OrMxl09A8wR8CEMgTbbpLSJL0X8cUvLMu
 oiHYmZJCJ6+1a7UHwxvoa1VnWjp/dgd1ZHWM8ANW/grUNy4HnQsutjsuioyP7GhdJombcGB+e5A
 uDVm2AbIwNfXG4wBNCW6pJMypPl926q6+Y/7jEcjei9u2UYYT+Pxs8QodV+CEXNTIFUYZEMpgLE
 ACygzSq1ztKgDbtGe6KNkjIwQDPU9rSDIdOZjFX7dFv0a2HHj/sjPOdDcUsswa/PVXYawZJd1TQ
 Xq+FLkvkCyVX8b2ZzL1sXxXH9mpIaCW9Aq13Y/TurWWVEy2+VbPgp/KTUFLbSo0duQ7/Lji43OF
 cj0gm38TwjTpmmgC0Axzt7nf9z5+ub6q9Lfg+6Ghfz5wmW4zF5ccM=
X-Received: by 2002:a17:903:19e8:b0:2bd:b6f4:4500 with SMTP id
 d9443c01a7336-2beb038c123mr54710965ad.11.1779479620918; 
 Fri, 22 May 2026 12:53:40 -0700 (PDT)
Received: from [192.168.64.111] ([50.78.183.177])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb58b3085sm24106105ad.53.2026.05.22.12.53.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 May 2026 12:53:40 -0700 (PDT)
Message-ID: <ca98e83c-8917-4db1-b95c-ee3f5fd85f4b@linaro.org>
Date: Fri, 22 May 2026 12:53:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 25/64] target/arm: Implement BF1CVT, BF1CVTLT, BF2CVT, 
 BF2CVTLT for SVE
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20260520182213.872945-1-richard.henderson@linaro.org>
 <20260520182213.872945-26-richard.henderson@linaro.org>
 <CAFEAcA-fwHraHrEuGXeDC93bctG7AAq+gv8Ew39OpR_6wzpdTw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <CAFEAcA-fwHraHrEuGXeDC93bctG7AAq+gv8Ew39OpR_6wzpdTw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

On 5/21/26 09:37, Peter Maydell wrote:
>> +TRANS_FEAT(BF1CVT, aa64_sme2_or_sve2_f8cvt, do_f8cvt, a,
>> +           gen_helper_sve2_bfcvt, false, false)
>> +TRANS_FEAT(BF2CVT, aa64_sme2_or_sve2_f8cvt, do_f8cvt, a,
>> +           gen_helper_sve2_bfcvt, true, false)
>> +TRANS_FEAT(BF1CVTLT, aa64_sme2_or_sve2_f8cvt, do_f8cvt, a,
>> +           gen_helper_sve2_bfcvt, false, true)
>> +TRANS_FEAT(BF2CVTLT, aa64_sme2_or_sve2_f8cvt, do_f8cvt, a,
>> +           gen_helper_sve2_bfcvt, true, true)
> 
> Again, I'm not sure if this gets the "only legal in streaming
> mode from SME2" logic right, but otherwise this looks good.

Fixed.

r~

