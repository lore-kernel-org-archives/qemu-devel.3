Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B4D2FEA803
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 05:00:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5GL1-0005CE-2r; Wed, 25 Mar 2026 00:59:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w5GL0-0005C0-AP
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 00:59:26 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w5GKy-0006q7-NV
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 00:59:26 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-c73e9e4cdf7so1861531a12.2
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 21:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774414763; x=1775019563; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7o0jeXZgIbwXhYRuM6WT1L4AYIttXsytLPoI39nGUfU=;
 b=Y1IRXCjXNW5h8PB8PhHENojDWDWxbW713dqWdkXL4B+NKaJFQJdlRibbo5bkKUfRE4
 CBTNsigMUAhhjbiBuEIeSnDu3dE0120FOe+HvndY0QnWdcbl+bzPKhszm6d1uSBl70Tq
 1ULpwowPP6Nk++O7nvV1SbCkGZaMJsg3kUOxXhkcrzBTJEr9HwHK4c/NFZxZw4taFHDK
 8bLuq+HoidLtLfI7IQ/yW5cya1fkWh1oSl8fkbE++0t1VvoWGEsApt/0CwzQJunvgfxu
 w8tqa4oxkoqfOHxRAbrjy4qqRkDaYa9N5vH9PtWPf1ZA7tHxTxvD0f9SGIGW/8I9jDEn
 RRkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774414763; x=1775019563;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7o0jeXZgIbwXhYRuM6WT1L4AYIttXsytLPoI39nGUfU=;
 b=AZXJyLMpysdSeGMJ6WmtNLsqTXPsd84F7FtFGIyf5B5Tw/qIB2HkXyS59AUgltwECk
 S/gJyRYAGs1cwb6F0xbJVQfDQT5FpWvcAZdC4HgpcLI9SORb91/L5VI4tSqtzCB5K3h9
 zI+UBiGI75RYnoqOtMMXhsMQySGScJa/WuzY7LjP70dPVGvGMdVFhLzYqnEES4d7TudG
 EW+KUbpOH+qrYd9TkU4WCSwxW1v+z4oy3cE6rlqOp2Qed2H/1xEtlbJNlgXC/K+SiEk6
 16nychJpoVUDmxJHY/Dh1pISR3VKTcdaOeZrhPeKM1vfr15C4C2+pV1Q+utdf9jCyKLG
 wb1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlXqhkG91p+fXxCEq4sqwBov6FYEUI388yehP/8f8ePhcgR5qrg9qnF3f3fYHfJHOsM6VQhHLY75pD@nongnu.org
X-Gm-Message-State: AOJu0Yzc+YKma++d9plzKPnFwt9sxcwjvXwIQr3mgAZfE7iTLiZv0n3R
 WqwOGgzXBhlnWo/kJMgU+XKLSUkIKdjY8gzU1lwfWXqfPSKhxcwX0pH24sYVJiAMUpQM7wgbLJl
 V8agE9Is=
X-Gm-Gg: ATEYQzxYWKIj3gvUsvOeTWZfPbnpvM1cToW1DFOwGdoIe6fcB9n9YAcbmV4OF2blBsQ
 Qfh8tbsOyjAn6qTD0bXsIZaYIFGIymUlYK6IgNfXfu6ygIxV2/mt+125eUNwD9nEUeIXwWTfAun
 kfTqXDKhfk6cpEQonz45/wHqfmV/In3bpYEkj1mIKpn3dUECEO2nad3zjGhU2u3UcmBX3kN+ixn
 FlOYWaupUbWtKabhe+aCz5xhZoTj77wiGxgZXo3afKHPx0pVQiviwmdYaw9yFdMZM5AuzGJzvST
 wX0mN4a+l5DYCifMcpvdtpUuq2dS1mX5i/f3arpjrEFNuVHBmgUMu3lpx258F0MfQYmZis2y9ig
 +seg+c8XDPCO+WhqC6DPDf/S1AGkmU7DFJoQNx6B12TUltzd5T2ESa1pIaaeQ8zU8cz8TeGuwrE
 IIKCI0f/ycdTPnFFgCFg88koc5cdseqzECeDdJUrwReQ==
X-Received: by 2002:a17:903:2bce:b0:2ae:63a4:3baf with SMTP id
 d9443c01a7336-2b0b0b0f401mr25372725ad.46.1774414762660; 
 Tue, 24 Mar 2026 21:59:22 -0700 (PDT)
Received: from [172.16.11.156] ([103.100.225.140])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b083683a8fsm152637145ad.66.2026.03.24.21.59.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Mar 2026 21:59:22 -0700 (PDT)
Message-ID: <8c67019a-49c0-4651-9c02-0d15ae262888@linaro.org>
Date: Wed, 25 Mar 2026 14:59:16 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-11.0] tcg: Pass host-endian values to
 plugin_gen_mem_callbacks_*
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
References: <20260325004052.1026892-1-richard.henderson@linaro.org>
 <456faa09-4889-43e2-a35a-449888f9249e@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <456faa09-4889-43e2-a35a-449888f9249e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x532.google.com
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

On 3/25/26 11:39, Pierrick Bouvier wrote:
> Hi Richard,
> 
> On 3/24/26 5:40 PM, Richard Henderson wrote:
>> If the host does not support swapped-endian loads and stores,
>> then we emulate those within the tcg expanders with explicit
>> bswap operations.
>>
>> However, we were passing values to the plugin interface in
>> the middle of those bswap operations, which meant that we
>> would pass values of the wrong endianness to plugins when
>> running on hosts without swapped-endian loads and stores.
>>
>> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3351
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>
>> Hi Pierrick,
>>
>> On IRC I expressed the opinion that there was an additional
>> big-endian bug with how we treat neg.plugin_mem_value_low,
>> but I now see that isn't true, because of how we adjust the
>> store address in plugin_gen_mem_callbacks_i32.
>>
> 
> Yes, we store the value directly swapped, so there is no further transformation needed.

It's not about storing the value swapped, it's about storing the i32 to the low part of 
the uint64_t for the host endianness.

> It works, but it is still not clear to me why the value orig_val (which is not swapped and 
> in target-endian order) gets stored swapped correctly in neg.plugin_mem_value_low.

Again, it is *not* swapped: orig_val is host-endian order, and so is neg.plugin_mem_value_low.

> I'll probably add another patch to document that better in plugin api, and remove the 
> additional swapping done in tests/tcg/plugins/mem.c.

What swapping is that?

There's a variable called "swapped_value", but it appears to be mis-named, or a remnant of 
swapping that used to occur.


r~

