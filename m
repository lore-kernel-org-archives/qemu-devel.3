Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B469C3271F
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 18:25:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPR8Q-0001aX-T8; Thu, 04 Jul 2024 14:24:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sPR8P-0001Xa-2a
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 14:24:45 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sPR8N-00007f-47
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 14:24:44 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1fb0d7e4ee9so5257735ad.3
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2024 11:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720117481; x=1720722281; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=O9HMrFcVZDenmphTehp9py7axRg9tQZVyNoIrqkiERM=;
 b=WLPfAzVtiGyfjhcSfVXkkpkTPaYAzn9g6zYhaVnhRt+ivw+qy8+Zmcd17ZfGu9qA7y
 /mnMB/B8U1JEeTjzGOoXCb/Np7GCNcPRaCt0cpu7ol8NdmDWGS9tyElmXDvxbzKnHYx7
 17KiBhvlAZKBffAOctM/OyAck3c0x5VK0r1X5qAy0cLSb149zRgHKlZh9WVH96ioQP1F
 x52ahZY2SJnG8/6U9zHrTsYq7rjqlJ9pqGf/O4uFp54lX33+1C5wHer2FxX4fI3yKX1p
 gC1X9Wd8hFYXujDHlwvvx4jz/rQ1XWikMxvSQuOqfBIuIpOzJL8MQddO/fp0R4Onr7Nv
 xZeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720117481; x=1720722281;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=O9HMrFcVZDenmphTehp9py7axRg9tQZVyNoIrqkiERM=;
 b=DUruLyMt6Xf0h6IGFqMiYPWiaSCEV0d6XFiUhviHBdXi8gid7xzuaSHsu0lnzbHgLV
 ZeIA951ZuLVODOMcG3OMf8MJrbihA4IGsyS/CKjz8R0zjew56p/e/osaVh+JZwEftaPd
 NQ3+qV9kYcHElsNo7sOFjgomGIqOOSGDKm/mIsweTnhMRMCKYtx3yo/7H9+YiNfOurP2
 mQPb+wSvLfd2usgbNCD+TdAaufbFd+XHlk26sTMFqq+nwY9VxO2AB/45M78gv0WOJ+wT
 vBGlgo5W/thxZTt3r9ltAzW2RlImhe/hgnpWIzKPYyFjl/ChZcTdSSSHDHxUdxAMi8Xx
 DFjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHWcEqNa20QSSGFWgGJT1zhPBV9sLhj3NIrGUV4wSwyu0eMcdn8nfH9a5NiU89HSbzm+BFzS2Oywd9pb5COZsAqmfrfD4=
X-Gm-Message-State: AOJu0Yympu8F5ZnleeYluV346DHl1dvnbXhLt84MhzNlOULI86JCc/o8
 faavXPLpojibfmI+EI3tGkueFnAG8uC4Z3nM5n1H6BK1z8SHT/B1N7Ia2J9Z2vjfsm68zM7bw/y
 U
X-Google-Smtp-Source: AGHT+IF6GN5aUIUaK3ll7LKcb6IYXMc+CCh4GI9NYkc+S0UKWER3Q5578+fblBsKtRpFKJth/nTAwg==
X-Received: by 2002:a17:902:f693:b0:1f7:1706:25ba with SMTP id
 d9443c01a7336-1fb33e17bf7mr18111975ad.15.1720117481167; 
 Thu, 04 Jul 2024 11:24:41 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fac0ba60a2sm129029805ad.0.2024.07.04.11.24.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jul 2024 11:24:40 -0700 (PDT)
Message-ID: <c69acef3-aba9-4171-8b9b-167025827b4e@linaro.org>
Date: Thu, 4 Jul 2024 11:24:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] target/arm: Always build Aarch64 gdbstub helpers
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Gustavo Romero <gustavo.romero@linaro.org>,
 qemu-arm@nongnu.org, Anton Johansson <anjo@rev.ng>
References: <20240619124903.56898-1-philmd@linaro.org>
 <42de8f25-3624-4e7c-b38c-ad8e3b8e61a4@linaro.org>
 <83667101-daba-43ea-ba33-1df547020cd9@linaro.org>
 <ebfa6ca6-d93e-45b3-8786-cb52505e2d7c@linaro.org>
 <CAFEAcA9bqgFwxsbvKFLUiGu=ThzF0zAy7-rD+7Yo4yNEoi4Pbg@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA9bqgFwxsbvKFLUiGu=ThzF0zAy7-rD+7Yo4yNEoi4Pbg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

On 7/4/24 08:01, Peter Maydell wrote:
> On Fri, 28 Jun 2024 at 17:50, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> On 6/28/24 09:37, Philippe Mathieu-Daudé wrote:
>>> On 28/6/24 16:31, Richard Henderson wrote:
>>>> On 6/19/24 05:49, Philippe Mathieu-Daudé wrote:
>>>>> Merge gdbstub64.c in gdbstub.c and remove uses of
>>>>> target specific TARGET_AARCH64 definition.
>>>>> Small step toward single ARM/Aarch64 binary.
>>>>>
>>>>> Philippe Mathieu-Daudé (2):
>>>>>     target/arm: Merge gdbstub64.c within gdbstub.c
>>>>>     target/arm: Always build Aarch64 gdbstub helpers
>>>>>
>>>>>    target/arm/cpu.h       |   8 +-
>>>>>    target/arm/internals.h |   2 -
>>>>>    target/arm/gdbstub.c   | 363 +++++++++++++++++++++++++++++++++++++-
>>>>>    target/arm/gdbstub64.c | 383 -----------------------------------------
>>>>>    target/arm/meson.build |   1 -
>>>>>    5 files changed, 364 insertions(+), 393 deletions(-)
>>>>>    delete mode 100644 target/arm/gdbstub64.c
>>>>>
>>>>
>>>> Are we attempting a single binary for user-only as well?
>>>
>>> No, due to ABI constraints, right? I did a user-emulation
>>> smoke build, no failure, did I miss something?
>>
>> Well, no.  But qemu-arm does not need gdbstub64.c.
>> Given TARGET_AARCH64 will be set on a combined build, I'm not sure what is the fix?
> 
> Richard: I'm a bit confused about where we are with this
> patchset. Do your comments mean:
>   * this patchset is OK for system emulation but we
>     should (later) think also about user-mode ?
>   * this patchset has a problem with user-mode so it
>     needs rethinking ?
>   * something else ?

I'm confused about what this patch set improves.

It doesn't remove ifdefs; they're still there in gdbstub.c.  The code that handles aarch64 
is now in gdbstub instead of segregated into gdbstub64.c, so we have one larger file for 
no obvious benefit.

Was there some other build problem that I missed?  Because I don't see how it advances the 
stated goal of "a single ARM/AArch64 binary".


r~

