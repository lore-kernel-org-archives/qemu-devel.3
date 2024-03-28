Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71FD3C54E64
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 13:19:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rppeg-0006bQ-Jw; Thu, 28 Mar 2024 09:18:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rppea-0006YK-1N
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 09:18:50 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rppeY-0002vI-F3
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 09:18:47 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-56845954ffeso1464616a12.2
 for <qemu-devel@nongnu.org>; Thu, 28 Mar 2024 06:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711631924; x=1712236724; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=L4vVCtVJ79BAfEKEivEouWOX6M5IEVlyolcdeT/xuD8=;
 b=Ci3Kx9BP2BHNVaVv7pw4ZJWvwk62kyzWAnoP9Q/d1JijkyTXBl0qKMtYapWUVmmDYw
 l5BiUQyvFvAOT6IT4Pu9aZPXgRmKu1bsIJnhEObQ6Ouq3a+oGKlMhgfW8c3jismiIozW
 wYmW5bSyzYwMfJ8I/HNmn11SvUda9yyDYPED4N0iJ9yuepO40rjIxhSXs+EJSxtMEFtW
 b1VjY5Z5bLgHkKbg8c6zdUZwYI1CXnvABf1PCo65Juk+rPwreHjMD52YUL9U5VyrTkM5
 F5xLFQu4LHXxdRZIbw7mYQMIRa38gYf52VGwqPmtWZ7mlym/31tad/sPaIpKi/eKrCbH
 wbfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711631924; x=1712236724;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=L4vVCtVJ79BAfEKEivEouWOX6M5IEVlyolcdeT/xuD8=;
 b=c9FoPl+DXPDkzBYctklSwuMrTTLdYJTfl4Wp7kai+fl0W2WmR6lH7e6lvAMrDQ34MY
 a7zvK8kl6GN461tnAHJnJM3AfcSXasqSUznCKq+eav9kxX1K/UApFrBH/WizDTzlZPB7
 Y9Jvj/c/o9JI+gdlit36CoxRY/HBR+NIaG25WVu/cRVLnInGYufHHrhxRfOqWO6IjKQm
 Y1Y1dmBHjfE7XbLrdTDjQ40Snvs3ElNc8Zbh4uAL814jA/ykWXTUelP9wa5tCbR+mV8c
 4AEqBV6e49r7ObyLYtyKn0KsXtvLD36u2OHPnb6TvJWzPWkJJecms5NrqpQXDJFTp6pU
 3Nhw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1jfsoPiNqw8ZjywBCLmBfLZWeDNMf0J+2dFmZSExrpwyh/ongRop5hmCDc5Un5NUA73fFNthYM5TrWQGIkmQHR9wbEZM=
X-Gm-Message-State: AOJu0YxfOm74qKlUKKDD32xkJ1jl7Zi45Hp48Zlt6vTYBzdzvvwjVJ7V
 Mt9iZ1qkm9ehBPeYcUlJJ5XdzZ4Dwxs5FA4PZhkX8rMJwuhCiKIl3Qx4bLNIaiU=
X-Google-Smtp-Source: AGHT+IH/f8FU3yK+MSzKwA0NOkWG/qBWjCj8/nSkL3qKXzOVk6nmRwvV95GMTPBqFHusvISddi6d9g==
X-Received: by 2002:a50:d501:0:b0:567:504e:e779 with SMTP id
 u1-20020a50d501000000b00567504ee779mr2026593edi.25.1711631924524; 
 Thu, 28 Mar 2024 06:18:44 -0700 (PDT)
Received: from [192.168.69.100] (pas38-h02-176-184-5-52.dsl.sta.abo.bbox.fr.
 [176.184.5.52]) by smtp.gmail.com with ESMTPSA id
 c2-20020a0564021f8200b0056bfca6f1c0sm811958edc.15.2024.03.28.06.18.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Mar 2024 06:18:44 -0700 (PDT)
Message-ID: <9ac30d29-6ad6-44fb-96ad-22ed16489c73@linaro.org>
Date: Thu, 28 Mar 2024 14:18:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] target/ppc: Fix broadcast tlbie synchronisation
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240328053131.2604454-1-npiggin@gmail.com>
 <20240328053131.2604454-2-npiggin@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240328053131.2604454-2-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x536.google.com
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

On 28/3/24 06:31, Nicholas Piggin wrote:
> With mttcg, broadcast tlbie instructions do not wait until other vCPUs
> have been kicked out of TCG execution before they complete (including
> necessary subsequent tlbsync, etc., instructions). This is contrary to
> the ISA, and it permits other vCPUs to use translations after the TLB
> flush. For example:
> 
>     CPU0
>     // *memP is initially 0, memV maps to memP with *pte
>     *pte = 0;
>     ptesync ; tlbie ; eieio ; tlbsync ; ptesync
>     *memP = 1;
> 
>     CPU1
>     assert(*memV == 0);
> 
> It is possible for the assertion to fail because CPU1 translates memV
> using the TLB after CPU0 has stored 1 to the underlying memory. This
> race was observed with a careful test case where CPU1 checks run in a
> very large expensive TB so it can run for the entire CPU0 period between
> clearing the pte and storing the memory. It's normally very difficult to
> hit, but preemption of host vCPU threads could trigger the race
> anywhere.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   target/ppc/helper_regs.c | 2 +-
>   target/ppc/mmu_helper.c  | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)

To the best of my knowledge,
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


