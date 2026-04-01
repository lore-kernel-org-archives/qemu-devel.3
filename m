Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA58710F6FDC
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 17:55:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7zm3-0007AW-QC; Wed, 01 Apr 2026 13:54:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w7zlf-00078C-VD
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 13:54:17 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w7zle-0006k5-En
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 13:54:15 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-82cebbdbdccso716129b3a.1
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 10:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775066052; x=1775670852; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GNjJ9yneLnMo/A0qgXzBPyfFlVgpiVY0CGjAZST6jP0=;
 b=bVF7XG7xrTcn/0dOmQ9365bTTg9uUcQfs71Ch3kBLSe0cos1R7JhdReqeH0MwvKgio
 ahqQY6lc08ZkTcLrcIYBV5bgx/r0CwziM/MbiTLXv3IhafCOMBLvhAto4en3yWzenaua
 pmRT+q0WA2aGPN3UUzHOBRV1spcPWVedQQN2p+u15mrIGx8lMUiVLHpIwP9r4XEo6vQH
 PEQejJsYCpiBKz73bcidBshcyQpYO2mGy9je7m7XgK+2jdtrcSVMY3FifjQbba4FLFUl
 yp50ySKz/eaHKrQzRyidNls/C5AoVpWvHO/peK6RthROijj3UDEM++3IEw99S3SfEE+f
 +hMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775066052; x=1775670852;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GNjJ9yneLnMo/A0qgXzBPyfFlVgpiVY0CGjAZST6jP0=;
 b=J23gbVVfSxSIHTHVKJitUz00/ADZul106OrJ22wpiImdw27JBoZW/NEvduCb8ULO90
 GF1t3FN4Rs976ltxyYXlsuMXSeIWoZPYwc20dFd9qp3mbXNxYIEF3jBDyhUfqnxE5nVa
 QL9BkAA9xAMvgSFqhSVGUrxBCucQ8FbulvzXclbL6jY8zkayyx91czOmK4tnu4BfNBAL
 jKDpiJ5utry5WQtNqp06LOCTJBMjdpYANBJzuOI6D+MOzA2SxxPRHAPbXZuRs7M8NHw4
 3Jpp2v+oXkK1obwinnXdNrEU73HtoZ/ba9GA3dLGV28PUDvE0t3dQBWV9CUqMWF+HAje
 cLdQ==
X-Gm-Message-State: AOJu0YwrpJrOA/FvjXVWgWVtC2EcjW+UC+G3T7vLYcDKa68Y9RiLJO5Y
 T36t6brtcxBR6XqO7PiKjhrxYGY5JvEMzkJ7A3JSg9QX2dBWVYOsBKdknms6Ag0kqf0xzUYzRBj
 jkuqanabH/w==
X-Gm-Gg: ATEYQzyO/kVc8LjBPP1Qfug/rPPvwvHi5jGrtUDXo6mmhklHi65EUbWsy/Zel65i8IN
 q40dyKjOFegHoNj9bchYfV9iYFZSFK4B9+HT9uwPQhurLR7CGdRQ5Af+PBCHTRa0UoV7NmsCvTZ
 g7KrzhW0KFkpKKKG7XfIYk49qGhzyrRQS3X0E27P634W/tBhu1vy7882YQNTPVkP34hzS4l1B+L
 cPwrev9hJEPol0GmHH/3BwwY3D8pUa9UT1aHbUdPQKBv+woLL5nZhpa160NW34NLTkBynDn4LE0
 JX42KV0/ZNY0zoX1SbIy+SCm8iz3FVx/rh5vk8Jjjc7IOOfY0PgC3tcf6i4le+HIKOHnOfPrFqT
 0rXtR0uecyrR0062mExjRZdWkTl4LfYzE0R/QfvKRJnwNquQZDcS0W0TS7pZiSn3K6TxZahhovj
 dO3urygG/BNhbJ7p5WiZF+atFaCMYB0GHzE0MFlQXKq475XFhnOXSKorF+jese04ozw7aO
X-Received: by 2002:a05:6a00:4211:b0:81c:5bca:8104 with SMTP id
 d2e1a72fcca58-82ceaae5df1mr3564273b3a.24.1775066052319; 
 Wed, 01 Apr 2026 10:54:12 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82cf9c3ce13sm544918b3a.38.2026.04.01.10.54.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Apr 2026 10:54:11 -0700 (PDT)
Message-ID: <e249a5c1-5f5d-469b-9912-3b7ef3b4f400@linaro.org>
Date: Wed, 1 Apr 2026 10:54:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 03/35] target/arm: migrate FP/SIMD trap syndromes to
 registerfields
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20260320130607.2071996-1-alex.bennee@linaro.org>
 <20260320130607.2071996-4-alex.bennee@linaro.org>
 <595c4e17-c6c8-4281-bee2-8ed50d27d582@linaro.org>
 <87a4vmq1xt.fsf@draig.linaro.org>
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
In-Reply-To: <87a4vmq1xt.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x429.google.com
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

On 4/1/26 5:50 AM, Alex Bennée wrote:
> Richard Henderson <richard.henderson@linaro.org> writes:
> 
>> On 3/20/26 23:05, Alex Bennée wrote:
>>>    static inline uint32_t syn_fp_access_trap(int cv, int cond, bool is_16bit,
>>>                                              int coproc)
>>>    {
>>>        /* AArch32 FP trap or any AArch64 FP/SIMD trap: TA == 0 */
>>> -    return (EC_ADVSIMDFPACCESSTRAP << ARM_EL_EC_SHIFT)
>>> -        | (is_16bit ? 0 : ARM_EL_IL)
>>> -        | (cv << 24) | (cond << 20) | coproc;
>>> -}
>>> +    uint32_t res = syn_set_ec(0, EC_ADVSIMDFPACCESSTRAP);
>>> +    res = FIELD_DP32(res, SYNDROME, IL, is_16bit ? 0 : 1);
>>
>> !is_16bit.  I'll not mention it again in the series, but take as
>> given.
> 
> Impressive that I managed to run all our tests and nothing tripped up on
> this!
>

Try running all tests (check-tcg + check thorough) on instrumented gprof 
qemu-system-ar* binaries, you'll be surprised to see what is actually 
covered by our full test suite.

Note: It's probably less than what you expect.

>>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>>
>> r~
> 

