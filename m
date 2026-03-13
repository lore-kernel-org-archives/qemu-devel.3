Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18D88107BCCC
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 16:29:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w15Nd-0004jZ-Tk; Fri, 13 Mar 2026 12:28:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w15NY-0004da-6d
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 12:28:50 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w15NU-00006F-QA
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 12:28:46 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-829865a8471so2237582b3a.3
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2026 09:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773419323; x=1774024123; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EjOJP61uyaomqMV9S0msdESK/0R8pV+yOL/cOKPBZ04=;
 b=UxDfgFxycIwayAIYnsDWVk4GNbO+99H2+sio3swqagqfXM/ZNSjiqW9FW4DMXkMoya
 oYwuKJeZnjTRhDrRcIpNnPUj34yGHLG2DUt7G9ckv0Vq9hD9JZPRHw8WtJwqxXGLvFEg
 ykZqjNyDJNO8fhH5ZVRz8sHAeALWZFvcPMgmQOMok9n+atTf4JRXXfcb9mPEtWPL2B8i
 N8m42xTItr//cvIv8F91Ifr2f56XCDCTwEWG4S5/Xd+J3GNHv6x37BcOhDa3A+a7nRem
 LrLQPMz5KIjkxUKlxyNLFJWQO61NVMgSV9rzLsqZEjrUniZ2A3ZbS3KdcxKyFz7hltad
 Aefg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773419323; x=1774024123;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EjOJP61uyaomqMV9S0msdESK/0R8pV+yOL/cOKPBZ04=;
 b=LCLFcLb6xe+0Ckqbn2BmJ0lGXbYmNXKa24/UxZdjMHCxBWDyiR62lT1c4lcLn3mBv2
 j6a4S8UB4mLKgFgv3A7MwIKad79gTrPIhChzg9wu+XIFo006ai69+Bea4gvAh8SHFSdp
 zczGFqhZhOZi8PBRdzREGVEwUGXIhGxdKlyZ+uwpItCLqe0I3Mj0NhByPniKcWmBVtwT
 ikn2wNhYiYRVrDUr/IKez3n8LIfrTrL2qMeFtANJ1Fklhh7esNb+FfBuG5SMRq0cWa08
 esw6nnszbOczyrUxkcxi0IFgL/gN7MYrYAMMasazfL/pjcryhLeV90CXAA+tWXSP5543
 W3HQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNJ27HxhBru6FbNypBSHZJ3YGARmw+JNXNLiEc7IdWFw+KvA7UC4GVp7NWNJ4iaEAlMsExvMptG4l3@nongnu.org
X-Gm-Message-State: AOJu0YyoVntO+CzyZKmHgWjLiE+vegjgYOzG1j13VuNIwybqLnJobcHs
 vLMN0iGfhEXKmVW1qXJc+Ae5OxxbTPK0PHpxFK6VcMEJCqPdmpV+kxoMFX4Cn7b1CdQ=
X-Gm-Gg: ATEYQzyG+dZbtRYwD6B6Il4vS72bOnPlT4OWnc9ooG9vcUzvwEfL6x4Ys/3KQOdehvS
 qBK2LC6muZVIKtdqxxYdtdMHipu5nQxXw4PONHweTuDLzrmTctgqIknlVlWzJcdaUE7nDe4aD+j
 zxaWISbw5ZiIpoI9iOhI8dYneIhtCWiBl0Xijs/bstdkDiFG/mO/gdF548w6/Z4CNbdOnhu/IqO
 /NuJu3dzeIiW/ERaokpsUimR6+mA5pO183LuP5ECC800U21JE8bOVEqbVymQ2JJ6hIhM5O6vzan
 78KLVdNEwZpQL2tXv4o5Cc9nX7s4ZZPrHDoWtIsAAMETezAtZ0gQQRw9roJe5BHf6eDHSLIxXAX
 MPEDE/34Xssz5fT8qf7kj9KzhloE9JLvSfr1PvdAfortGoMmRyd1Uzz9JuaiQnC+ed20Kg+8qiE
 0Lyl/3Dhj3mD/Rb+BbnXq6bQsnW2/2Oe5Oo0PtMelVv9Ktbiiac9gxBRQNwlkPJXNtXp3T9dspI
 m1gmxs=
X-Received: by 2002:a05:6a00:23d4:b0:829:7e2a:2d9d with SMTP id
 d2e1a72fcca58-82a196f3e8emr3630385b3a.5.1773419323174; 
 Fri, 13 Mar 2026 09:28:43 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82a07365b22sm6236232b3a.45.2026.03.13.09.28.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Mar 2026 09:28:42 -0700 (PDT)
Message-ID: <3fc30ba1-ea04-4fc3-9275-835449a7b0f8@linaro.org>
Date: Fri, 13 Mar 2026 09:28:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/38] monitor/hmp: : Include missing
 'exec/target_long.h' header
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Anton Johansson <anjo@rev.ng>
References: <20260313062055.2188-1-philmd@linaro.org>
 <20260313062055.2188-5-philmd@linaro.org>
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
In-Reply-To: <20260313062055.2188-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42f.google.com
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

On 3/12/26 11:20 PM, Philippe Mathieu-Daudé wrote:
> The "exec/target_long.h" header is indirectly included, pulled
> via "cpu.h" -> "exec/cpu-defs.h". Include it explicitly otherwise
> we'd get when removing the latter:
> 
>    monitor/hmp-target.h:35:5: error: type name requires a specifier or qualifier
>       35 |     target_long (*get_value)(Monitor *mon, const struct MonitorDef *md,
>          |     ^
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/monitor/hmp-target.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

