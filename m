Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ABE710F9969
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:31:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYbt-0003zj-Vc; Wed, 08 Apr 2026 15:30:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wAY9N-0000S9-1V
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 15:01:17 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wAY9L-0004MP-Du
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 15:01:16 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-43b9d3ebed5so41815f8f.1
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 12:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775674873; x=1776279673; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cOVeol76/J0qiEZ1bohMeyS5E9C/WQO5Se6X+02jaGQ=;
 b=fT0flxkZDqZYj5yd5BTha23BxNajwoteB4k6zoklTVuID6PJT3LPbW5VD7ib/azSet
 Lbf6BdlAHh/RE/mEDVscETCqeJGYkCUqBoTOlX8ZS3fzU54l0VgEFNVoYj0vofwOdncY
 qIMPd4C9M0P83e05u0lTpcdnkPaFdBR71t3PWNMKNzCHYCFp/if6T2MsVXni0FJMxc1g
 N/KP7YdfrVm+TzthX1HC2JrCYI1ITlQk738BvE8RhfCOhB9emK6Xs9mBlXblNFIoJxlw
 HLEoYLkRJXzN5eWdMdTKYEOl28yR2DC6tH773fxODKX3eGG0Uxrk9qHPQZCeJ/9c1QN8
 18CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775674873; x=1776279673;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cOVeol76/J0qiEZ1bohMeyS5E9C/WQO5Se6X+02jaGQ=;
 b=pcgq+NYgY+XiIfsS3hpaVEYUx8joCi6JlFpvzWASbskKw3pb/M9/UnIIoWrmeJ6fGy
 ZOAGQ9wPcCJbmXjiAfW8fBYXJggSM1euoK1fgJIUzVLit8V0MkxmZoeN9WN/q8TmqAaq
 PADEBq4Tkjczj0kI3UGGcml+E3MGjP56U0K9NP3QrC+iAc3PrcQjTl0SkA+UdPhTyFlp
 Fn7NPihtbs9Pw8nAjWhJp6gbeThjQWBNGro+hVRXPdnEDfjUBBuYEhgU7SfY1LVqmc+G
 b+GPZ/um8er0orw4ex7b2Bcbcoe5vlLYUGS0g6V1RElD0uI9Hg/jkBzIKHQpLMQu4O6r
 zjPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVS2/nNhLufkiWnnCBi14JlQkq+M1Ckcv34exnCGbEeHQvhxoOZII/rNtCcea4mFj5yoe/RjjP7cZAI@nongnu.org
X-Gm-Message-State: AOJu0YxLdzSf3NDsy6CzsYwNwZpldNZuXMrvs8fkIWT/DsGRp0OVMqAC
 XWIy95AHl5RqCkvOQRogcCarscezlMuc2aLUYX24m6l4ro6QApMrYk7jn60Vgihbaac=
X-Gm-Gg: AeBDiesAnY5ElF+8d41Yn4Cn7L465SMUfYpHG83da9aE92+2qdXM+IgiEg5KjFnZOfF
 WtIzizVeVWFCkmSTZKRt06HU55aS4nSamPgfPhQ1hSmUPmbljgzIRLnuG4aJMN4CrF5WdSlCMtu
 vJ4XmcMcrK5MZHlGYbF/dlsQWOUtTrYmLLI4c1VySlk2PniMyNvT0QdqNWEu3plw+bvCcTHFLQE
 0RJkH1e4U2EqzuY++yzZCqUBlM3EZVU9++6MT5LAy4gdyqfNk77U7Bi+GakNbpxJGhVlPSP+pvF
 RcMGaSTINzRWtka/b5W96ps3HXpV5QCLkXoLWQMQ1hXWw48HAPb5iDdaHKRYV6uZ/Oy4xcLhq69
 oSJdGOgKvt/5+1BMuJNwiZ23+V6tkV3liS9tk93X8pN/7cCF89MpF7mBeeVzu3P7/e2yQLR6F8a
 PpOgG6V95qx8t4vJ4croooxQL3sOBWufsUO1IMu8NjHWB/6+YKulvezt6arWBoXb3SvQ==
X-Received: by 2002:a05:6000:18a9:b0:43c:fe0e:5bbd with SMTP id
 ffacd0b85a97d-43d292eca64mr30774096f8f.45.1775674873439; 
 Wed, 08 Apr 2026 12:01:13 -0700 (PDT)
Received: from [192.168.69.208] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d1e2a71f7sm62317867f8f.1.2026.04.08.12.01.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Apr 2026 12:01:12 -0700 (PDT)
Message-ID: <04dcf4fa-c596-45df-aae9-bd9879b8abc3@linaro.org>
Date: Wed, 8 Apr 2026 21:01:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 14/21] tcg/translator: add parameter to
 translator_loop for current addr type
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: jim.macarthur@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
References: <20260407222208.271838-1-pierrick.bouvier@linaro.org>
 <20260407222208.271838-15-pierrick.bouvier@linaro.org>
 <41713965-dc77-483d-a026-41bb234b6289@linaro.org>
 <1c026eee-8758-45c9-82df-2563c203dcbf@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <1c026eee-8758-45c9-82df-2563c203dcbf@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

On 8/4/26 17:18, Pierrick Bouvier wrote:
> On 4/8/26 1:33 AM, Philippe Mathieu-Daudé wrote:
>> On 8/4/26 00:22, Pierrick Bouvier wrote:
>>> With TCG_ADDRESS_BITS mechanism, it's now possible to specify which
>>> variant every source file is written for. Compared to before, it means
>>> that addr_type will now vary per tb translation, where it was constant
>>> for a given target previously.
>>>
>>> Thus, we add new a parameter to translator_loop().
>>> This will allow us to convert targets one by one.
>>>
>>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>> ---
>>>    include/exec/translator.h        | 4 +++-
>>>    accel/tcg/translate-all.c        | 1 -
>>>    accel/tcg/translator.c           | 4 +++-
>>>    target/alpha/translate.c         | 3 ++-
>>>    target/arm/tcg/translate-a64.c   | 3 ++-
>>>    target/arm/tcg/translate.c       | 2 +-
>>>    target/avr/translate.c           | 3 ++-
>>>    target/hexagon/translate.c       | 3 ++-
>>>    target/hppa/translate.c          | 3 ++-
>>>    target/i386/tcg/translate.c      | 3 ++-
>>>    target/loongarch/tcg/translate.c | 3 ++-
>>>    target/m68k/translate.c          | 3 ++-
>>>    target/microblaze/translate.c    | 3 ++-
>>>    target/mips/tcg/translate.c      | 3 ++-
>>>    target/or1k/translate.c          | 3 ++-
>>>    target/ppc/translate.c           | 3 ++-
>>>    target/riscv/translate.c         | 3 ++-
>>>    target/rx/translate.c            | 3 ++-
>>>    target/s390x/tcg/translate.c     | 3 ++-
>>>    target/sh4/translate.c           | 3 ++-
>>>    target/sparc/translate.c         | 3 ++-
>>>    target/tricore/translate.c       | 3 ++-
>>>    target/xtensa/translate.c        | 3 ++-
>>>    23 files changed, 45 insertions(+), 23 deletions(-)
>>
>> As per v10:
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> I'm surprised it didn't apply, I ran a b4 trailer before sending v11.

b4 fetches from lore.kernel.org which seems to be having issues.

> 
> Regards,
> Pierrick


