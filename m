Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73621C5B552
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 07:55:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOtow-0007QG-9o; Tue, 10 Jun 2025 03:54:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uOton-0007N7-EU
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 03:54:51 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uOtol-0005h1-8l
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 03:54:48 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43cfe63c592so58697615e9.2
 for <qemu-devel@nongnu.org>; Tue, 10 Jun 2025 00:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749542084; x=1750146884; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8B6qLJiUllI8GeCv/Gl5huzcjr3YE6kXAQV+l9wR3gA=;
 b=xDkXxTPaaJmGacw3CY+nMIrpaOnLKS8aHG9qvlZ+ntTpYNqhj1WfpmXjX+HQjOSyFh
 nNQ3P47GNHh9VnuFf3whWEv811ym62wvEeM7SA1XLIOk73xlPQJ4SV9NYr9xMNJjf42P
 9nzngcMeNU8gvEK+gWyiTu39PGqOGo4Yz2orJf9C7NGlr5rDNj+1cYycK4Tehd4LtG+C
 6aiACuviMiosJm+eDp6FIX5dZUxJNaiG92d5p/OsVKTCW2rb1ow5CXPdz/F1e8nol+Bh
 ODAJn526VfCfkFpXUmHvyXbuY4AWxEnDwEE+Og5Vxe+1DDuyBP/1NWVqb0W4yv1ZwDCk
 H59g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749542084; x=1750146884;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8B6qLJiUllI8GeCv/Gl5huzcjr3YE6kXAQV+l9wR3gA=;
 b=RDsZReARZXeYzJ3SUz/zduZm24enSJ+JJyiFJJXL/Wj0n53CqGruHd0XpUnJxDIa+O
 ih0eJL4x3T3NWwOE7NxXNdphFR1v9Rl/Ws0ujvBym+7tWCPN8FfbGWEr8f75DycR+pB6
 uuceSXsMYTPb5UTTwffU3t5DQI7DdhWuyZHeP2bNJX1B7r7sCNrE5wo+xYjvSdRqJ1VL
 kIFKeoO6z+oPUMbY1ChzsVsaKutoLkV5hnDHtJkzdUs5iWze1C6WhSBUYOJZdVOaNyXf
 52ddyY7s8tvAgq4nFOGzaxpHu3TmgBIXvW2Il3tWwQXokkVYQNtBfr7jYbFZjsOwRMOI
 tXOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/dwuFCra4Z76UsNjV2wEb9HOZuE0u+PJaueCSLaphFzwG8UEAcuNHrdGFpoWTi47A0GJCLRaiQYVr@nongnu.org
X-Gm-Message-State: AOJu0YxtHTRHeFxPVdpOBU1MMYoWfgw1sZA2AH09ZxlCe44m2ELC7JIN
 0miB8X94gyTb7LF0WEsEZ4RVJFZK0xZt1iwgJlFwlk2Olfi16gc7f/6ZARCETvzce3I=
X-Gm-Gg: ASbGncvMjiM+d1PwQtHfb/IroVBSjsmtqDmxMGCMAboQkMyhdWxdBFKL2so9ziRQfwU
 Os7ARm/YO+EJFanQGddbX2kxOSoFNy4HSS+MJjqG2ddm8CoHtg5zl5tD0REkky6LXL2G0gmSRnF
 ailpiGyWAbq6Hg8AaK5LyfL2CzQTteDOkgxENbuw3io0OlXTUTOQSAUKVt6C/pN2srimSp0OkRg
 Yu3+be4o6Qba5L7dkTi4ftoStUtkcn0A4AiP/LFx2I5vPWi8nzHrTTlei3DUZ40Jmawi7cUXx7c
 2dqaF0hnpZ1ojfArSFtMLXdTXiCYXzbyI0oppHf/jgln9zYSWYq2Fs/JSykO1Ug0R2cTU6eS3iN
 7ee6KLsRUTm738TWMToHNuzJnCdQ+qkSSDjQ=
X-Google-Smtp-Source: AGHT+IHKUQ5x0zagsLu97n8yuaiPeEvLwwCjmgbJ68Yx1a3n1ZP5Nc4Wa1b4blqApSy5DObsF13BdQ==
X-Received: by 2002:a05:600c:37cd:b0:43c:ee3f:2c3 with SMTP id
 5b1f17b1804b1-45201364a49mr137358155e9.7.1749542084245; 
 Tue, 10 Jun 2025 00:54:44 -0700 (PDT)
Received: from [192.168.69.138] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a5322aa3c0sm11393162f8f.22.2025.06.10.00.54.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Jun 2025 00:54:43 -0700 (PDT)
Message-ID: <13e2364e-ef09-4316-96b2-ed16a0c6ffc7@linaro.org>
Date: Tue, 10 Jun 2025 09:54:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 13/77] rocker: do not pollute the namespace
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20250530071250.2050910-1-pbonzini@redhat.com>
 <20250530071250.2050910-14-pbonzini@redhat.com>
 <91e38ead-cea4-4100-9f90-f0e75dd748a1@linaro.org>
Content-Language: en-US
In-Reply-To: <91e38ead-cea4-4100-9f90-f0e75dd748a1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 10/6/25 09:53, Philippe Mathieu-Daudé wrote:
> Hi Paolo,
> 
> On 30/5/25 09:11, Paolo Bonzini wrote:
>> Do not leave the __le* macros defined, in fact do not use them at 
>> all.  Fixes a
>> build failure on Alpine with the TDX patches:
>>
>> In file included from ../hw/net/rocker/rocker_of_dpa.c:25:
>> ../hw/net/rocker/rocker_hw.h:14:16: error: conflicting types for 
>> 'uint64_t'; have '__u64' {aka 'long long unsigned int'}
>>     14 | #define __le64 uint64_t
>>        |                ^~~~~~~~
>> In file included from /usr/include/stdint.h:20,
>>                   from ../include/qemu/osdep.h:111,
>>                   from ../hw/net/rocker/rocker_of_dpa.c:17:
>> /usr/include/bits/alltypes.h:136:25: note: previous declaration of 
>> 'uint64_t' with type 'uint64_t' {aka 'long unsigned int'}
>>    136 | typedef unsigned _Int64 uint64_t;
>>        |                         ^~~~~~~~
>>
>> because the Linux headers include a typedef of __leNN.
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> 
> Your tools sometimes miss R-b tags:
> https://lore.kernel.org/qemu- 
> devel/4d8013d1-3787-4d8a-8b8d-3eee7d389d6e@linaro.org/

Bah, my bad, I didn't noticed the PR was posted 4min after the patch;
I shouldn't have reviewed it.

> 
>> ---
>>   hw/net/rocker/rocker.h        | 14 +++---------
>>   hw/net/rocker/rocker_hw.h     | 20 +++++++-----------
>>   hw/net/rocker/rocker_of_dpa.c | 40 +++++++++++++++++------------------
>>   3 files changed, 31 insertions(+), 43 deletions(-)
> 


