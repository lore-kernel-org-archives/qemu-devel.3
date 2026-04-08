Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31EE110F9973
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:09:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYGr-0004iu-EG; Wed, 08 Apr 2026 15:09:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1wAYFQ-0003CY-6R
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 15:07:34 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1wAUfx-0006EH-Lm
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 11:18:43 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2ab46931cf1so7619375ad.0
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 08:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775661519; x=1776266319; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kqgtEvals38xPaAjZwVmWlTvd9x4SgoXu0Y7rLwlXSM=;
 b=WFI4CtzQy3RCWtZAeixllaTCAVfCnMh4yPOgyFruTJmglmix3qS9Lt/zbhNerket8R
 Uw8H/dPf8T8iH0Zq3l45wbAFnYrIFh0n1B21E3+5WfghNWkV4fTxmMU4rAhw8u/Qjn2a
 U4ust2KeG0JpV+HFoelZzqo52wdngtuaH0gjvknlFud3uybz2yZ5vjE+hFIHG0XLdPP6
 hK/9fbAzp2Q9fGY+GReqxCAdNM56lwDvN9ScD/85Auoxou58qEypuQ9hDqM1gdL/oKId
 g+chPrf3OxIkKhL53mx/rDJxc7Wz5Lv7AGZId9mwHmMr7eESobHEcfPdepWi3zzwxktv
 RgZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775661519; x=1776266319;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kqgtEvals38xPaAjZwVmWlTvd9x4SgoXu0Y7rLwlXSM=;
 b=DenmxWRG0LaKX1mCPpsybAl5Ngv4vXwW9ouBUHKxxMWoC4gq3pADhMGEiIS7y6pZOi
 hdmYTmUGSy0UIwZsBJgFHL0ig3PW7xZnMwe4VtC7kq4A5VxYBeXSAJ14hs5F9Gzkz7Kv
 z4uVAKSYm3KRXZnH0gdjl0RFaHSYCNrEGd2Z5J7S4oWMA6s9VeY3r/ikF/Ki1vJ0ww9W
 kQEqCyII8JwDc3uBKsizKUqUaGYnwd4TQMsVACMIfJfByxAZ9mA8/S/xpe8a182l/m14
 TmH30N7UDDPR7Ptxnl4ywhKgNUd0FPHNSF7pCsnkQKhFCH9fWmh6xZbSeJYz/uony9Fc
 vf3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9mbZCbOVb/JWFuIm09j09I4ldTk30yd6vySZ/X3+AJhCzSXqY1rn1HeGNsZCx2/4jzyB+hYkfVgxF@nongnu.org
X-Gm-Message-State: AOJu0YwmR6ySU7L97fsMNO62lxjRfLabFoj5NRXp0XRtK9Mn3Bcea1tG
 oxytgtz1iulSqPSGCbKtFvqq9H+GHqE5Fi6xWDUwBHlByl1uzLNde1MZc+3g0MXyZkY=
X-Gm-Gg: AeBDievQp9eJ4AzvBXiK8+mROnIF00NLLiugBXPmj3re7zaeYRPvdmF9AcrXu+j3TiG
 b75iieFJ1rXO694QC/oXVgk1gL1F9dwUd7UMC0gN8YUFUnz478CkTO2A9iRqS1TDZlUkG354q3Z
 zEIJzYawyQG0nUYVgmH1kSelW/BEZG0YKpr3XvMmkXU7dEaey5ijjNxg7XL+tmsHaSlSsQ8cDy1
 rEWTNH67fuwOxef39X87+nDNuGUIE9Cfl4loY8qG2G5hFpHvMtZwmzvRJBwEp8udQnmt7NCMaiX
 FFTbCEauJ4fqq21EAbuO2PmYd6ya+hUonqmrjB097AokLopN4M5897MwIYAC528c3KriS8qJe1w
 1W1KZtZckL1IrrlMtUdnkV8Ro0rP0Ji5OZBb7ZpTLIbZ1kjRHwQTHw8VXF8Q8obbYOk/LACv8WM
 QjYVtaZkXWxOOaf/eIvRVT0CDPyBqtRdptfjWAfDARQH+fnuH6Grd3YSRMxizzmAQbLdhPpg==
X-Received: by 2002:a17:903:2ec8:b0:2b0:aebe:259 with SMTP id
 d9443c01a7336-2b2821a7fbemr208558575ad.19.1775661518443; 
 Wed, 08 Apr 2026 08:18:38 -0700 (PDT)
Received: from [192.168.1.169] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b2c09cdcd2sm17744075ad.29.2026.04.08.08.18.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Apr 2026 08:18:37 -0700 (PDT)
Message-ID: <1c026eee-8758-45c9-82df-2563c203dcbf@linaro.org>
Date: Wed, 8 Apr 2026 08:18:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 14/21] tcg/translator: add parameter to
 translator_loop for current addr type
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: jim.macarthur@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
References: <20260407222208.271838-1-pierrick.bouvier@linaro.org>
 <20260407222208.271838-15-pierrick.bouvier@linaro.org>
 <41713965-dc77-483d-a026-41bb234b6289@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 xsDNBGK9dgwBDACYuRpR31LD+BnJ0M4b5YnPZKbj+gyu82IDN0MeMf2PGf1sux+1O2ryzmnA
 eOiRCUY9l7IbtPYPHN5YVx+7W3vo6v89I7mL940oYAW8loPZRSMbyCiUeSoiN4gWPXetoNBg
 CJmXbVYQgL5e6rsXoMlwFWuGrBY3Ig8YhEqpuYDkRXj2idO11CiDBT/b8A2aGixnpWV/s+AD
 gUyEVjHU6Z8UervvuNKlRUNE0rUfc502Sa8Azdyda8a7MAyrbA/OI0UnSL1m+pXXCxOxCvtU
 qOlipoCOycBjpLlzjj1xxRci+ssiZeOhxdejILf5LO1gXf6pP+ROdW4ySp9L3dAWnNDcnj6U
 2voYk7/RpRUTpecvkxnwiOoiIQ7BatjkssFy+0sZOYNbOmoqU/Gq+LeFqFYKDV8gNmAoxBvk
 L6EtXUNfTBjiMHyjA/HMMq27Ja3/Y73xlFpTVp7byQoTwF4p1uZOOXjFzqIyW25GvEekDRF8
 IpYd6/BomxHzvMZ2sQ/VXaMAEQEAAc0uUGllcnJpY2sgQm91dmllciA8cGllcnJpY2suYm91
 dmllckBsaW5hcm8ub3JnPsLBDgQTAQoAOBYhBGa5lOyhT38uWroIH3+QVA0KHNAPBQJivXYM
 AhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEH+QVA0KHNAPX58L/1DYzrEO4TU9ZhJE
 tKcw/+mCZrzHxPNlQtENJ5NULAJWVaJ/8kRQ3Et5hQYhYDKK+3I+0Tl/tYuUeKNV74dFE7mv
 PmikCXBGN5hv5povhinZ9T14S2xkMgym2T3DbkeaYFSmu8Z89jm/AQVt3ZDRjV6vrVfvVW0L
 F6wPJSOLIvKjOc8/+NXrKLrV/YTEi2R1ovIPXcK7NP6tvzAEgh76kW34AHtroC7GFQKu/aAn
 HnL7XrvNvByjpa636jIM9ij43LpLXjIQk3bwHeoHebkmgzFef+lZafzD+oSNNLoYkuWfoL2l
 CR1mifjh7eybmVx7hfhj3GCmRu9o1x59nct06E3ri8/eY52l/XaWGGuKz1bbCd3xa6NxuzDM
 UZU+b0PxHyg9tvASaVWKZ5SsQ5Lf9Gw6WKEhnyTR8Msnh8kMkE7+QWNDmjr0xqB+k/xMlVLE
 uI9Pmq/RApQkW0Q96lTa1Z/UKPm69BMVnUvHv6u3n0tRCDOHTUKHXp/9h5CH3xawms7AzQRi
 vXYMAQwAwXUyTS/Vgq3M9F+9r6XGwbak6D7sJB3ZSG/ZQe5ByCnH9ZSIFqjMnxr4GZUzgBAj
 FWMSVlseSninYe7MoH15T4QXi0gMmKsU40ckXLG/EW/mXRlLd8NOTZj8lULPwg/lQNAnc7GN
 I4uZoaXmYSc4eI7+gUWTqAHmESHYFjilweyuxcvXhIKez7EXnwaakHMAOzNHIdcGGs8NFh44
 oPh93uIr65EUDNxf0fDjnvu92ujf0rUKGxXJx9BrcYJzr7FliQvprlHaRKjahuwLYfZK6Ma6
 TCU40GsDxbGjR5w/UeOgjpb4SVU99Nol/W9C2aZ7e//2f9APVuzY8USAGWnu3eBJcJB+o9ck
 y2bSJ5gmGT96r88RtH/E1460QxF0GGWZcDzZ6SEKkvGSCYueUMzAAqJz9JSirc76E/JoHXYI
 /FWKgFcC4HRQpZ5ThvyAoj9nTIPI4DwqoaFOdulyYAxcbNmcGAFAsl0jJYJ5Mcm2qfQwNiiW
 YnqdwQzVfhwaAcPVABEBAAHCwPYEGAEKACAWIQRmuZTsoU9/Llq6CB9/kFQNChzQDwUCYr12
 DAIbDAAKCRB/kFQNChzQD/XaC/9MnvmPi8keFJggOg28v+r42P7UQtQ9D3LJMgj3OTzBN2as
 v20Ju09/rj+gx3u7XofHBUj6BsOLVCWjIX52hcEEg+Bzo3uPZ3apYtIgqfjrn/fPB0bCVIbi
 0hAw6W7Ygt+T1Wuak/EV0KS/If309W4b/DiI+fkQpZhCiLUK7DrA97xA1OT1bJJYkC3y4seo
 0VHOnZTpnOyZ+8Ejs6gcMiEboFHEEt9P+3mrlVJL/cHpGRtg0ZKJ4QC8UmCE3arzv7KCAc+2
 dRDWiCoRovqXGE2PdAW8788qH5DEXnwfzDhnCQ9Eot0Eyi41d4PWI8TWZFi9KzGXJO82O9gW
 5SYuJaKzCAgNeAy3gUVUUPrUsul1oe2PeWMFUhWKrqko0/Qo4HkwTZY6S16drTMncoUahSAl
 X4Z3BbSPXPq0v1JJBYNBL9qmjULEX+NbtRd3v0OfB5L49sSAC2zIO8S9Cufiibqx3mxZTaJ1
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <41713965-dc77-483d-a026-41bb234b6289@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62c.google.com
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

On 4/8/26 1:33 AM, Philippe Mathieu-Daudé wrote:
> On 8/4/26 00:22, Pierrick Bouvier wrote:
>> With TCG_ADDRESS_BITS mechanism, it's now possible to specify which
>> variant every source file is written for. Compared to before, it means
>> that addr_type will now vary per tb translation, where it was constant
>> for a given target previously.
>>
>> Thus, we add new a parameter to translator_loop().
>> This will allow us to convert targets one by one.
>>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>    include/exec/translator.h        | 4 +++-
>>    accel/tcg/translate-all.c        | 1 -
>>    accel/tcg/translator.c           | 4 +++-
>>    target/alpha/translate.c         | 3 ++-
>>    target/arm/tcg/translate-a64.c   | 3 ++-
>>    target/arm/tcg/translate.c       | 2 +-
>>    target/avr/translate.c           | 3 ++-
>>    target/hexagon/translate.c       | 3 ++-
>>    target/hppa/translate.c          | 3 ++-
>>    target/i386/tcg/translate.c      | 3 ++-
>>    target/loongarch/tcg/translate.c | 3 ++-
>>    target/m68k/translate.c          | 3 ++-
>>    target/microblaze/translate.c    | 3 ++-
>>    target/mips/tcg/translate.c      | 3 ++-
>>    target/or1k/translate.c          | 3 ++-
>>    target/ppc/translate.c           | 3 ++-
>>    target/riscv/translate.c         | 3 ++-
>>    target/rx/translate.c            | 3 ++-
>>    target/s390x/tcg/translate.c     | 3 ++-
>>    target/sh4/translate.c           | 3 ++-
>>    target/sparc/translate.c         | 3 ++-
>>    target/tricore/translate.c       | 3 ++-
>>    target/xtensa/translate.c        | 3 ++-
>>    23 files changed, 45 insertions(+), 23 deletions(-)
> 
> As per v10:
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

I'm surprised it didn't apply, I ran a b4 trailer before sending v11.

Regards,
Pierrick

