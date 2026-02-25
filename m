Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21C3CFD45EF
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 20:19:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvLLZ-0006zw-Ic; Wed, 25 Feb 2026 15:19:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vvLLX-0006vL-Ow
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 15:18:59 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vvLLV-0000e4-VU
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 15:18:59 -0500
Received: by mail-pf1-x444.google.com with SMTP id
 d2e1a72fcca58-824b05d2786so118192b3a.2
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 12:18:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772050736; x=1772655536; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jda7zHRKjThhiz18NXvJBRCCi0Rzs4wa3znSf/899jE=;
 b=lKgozPjJ7uHXN4fe/ntHayt3ZjZZWGCpA9fmJIypeejVKn7Wd54Yv7rtZa3Nqiuo5N
 AvlvSLi+IG4TOpbsj4xaSPyol00UVavx/UQIIITUCAAF/5qhbyX4JEurXRVLZSW3FQNH
 wRbQZKX/n1F6juIU+1MdNZOmr+kXf9rLHVDzIQPUTSPoN5Y04+BO9IHKamo5HnkSlEs8
 q+x+4xV/sbZPYtMRK1yJijnNnuY5GxhKIKlxpyDg9tCrU5QJIHmsHxDpC+JJ69Gda6qj
 4pKn2dXZ4cwMRV2a7Bk7Vh4CbPf/8pIPpUL3v/kcL+qBNSxOwk64Y1rKZjA2RyY9eZpt
 w5zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772050736; x=1772655536;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jda7zHRKjThhiz18NXvJBRCCi0Rzs4wa3znSf/899jE=;
 b=trDPgvdNZZDKLmPk4IVRAwWce1mZQCyxY9CZVDHIlTguYXiFJsXNST03Je1F1zjyQu
 ok6dAXheNCJ2mJ6tTprE/AbZI0qkVTemtfeueC4PZcbBJobYYoa5HIrIpwQGPMV1knU9
 EjPTFkJqY2+n0XRAogaJiXn7SMUomD6ouyQ654Eg/JZcPp9zNKTibQ0VrEZaNdOvJ+Vz
 M6EBaJqgmul4qF3vsFh5boTe15LAkQUzO1EzmTICGHyzzk+e7KAv8lplfR4/2S5RIw+L
 pTzNDSki2Okh3+mcjzB2/ZRqQAQ7xZnQCXB3DX+7j+Wq7CMCC/9EusftGaSn73U1jG+C
 n08g==
X-Gm-Message-State: AOJu0YzTISZjdDjH7xawRzkP/Y6BUb6LRK7+Hti1j3oFQKl719EjSYW4
 ft3WXl9nsbgRfwu7GZ64p7lGMfGn1m4puhDCO5L7JSoBEAuFGNDReP1aXCjXKy6mVjY=
X-Gm-Gg: ATEYQzzjStZGLwv6WJpRtuQj+44jt5SfbzW1ZFSEF7y/udxS1ESix9WzKyKWMnEQkwf
 oC3s4+fJU+kXxMnYVyu1u1Tyzl2YGPevtBkOZcV1CCSsEancZ+2tYbqoy/pFHoRsiQibTDQYS/o
 5eoZ2G8bv9NqOLIpgm9Snjv+h1EQRATVYVFTQXbklJNj4Dtz+l431p/0xfkq57MC4tkD4zLbNWb
 XA4wUHlJmJ2oNnNyBTdVao45pdSjIgufyvAjycoWp2coOAA+Pk7PLJEiumHaOrj/G3bDOVbmhi5
 HpfUNYIX7w5JZuQz7GDarlvXjKPcgaSi/RmDiL7xjHKccrWvhfhzahzhy007f5Sb9iJqfK3WYTr
 Jt45CyOIDTvMuxn2fPx69Np+ezlOW8hHqp0XRWfZVCtBa5ODa1kmLoiG1yai80cXJ547yecUK57
 JRabMxK26FE9/JzVUkQBuKuR/L8RFU0RE+eZ/fJ/sckGGY3oLSrhUvwU71jQHcFI/ZIrlqpC+r7
 CWgTgg=
X-Received: by 2002:a05:6a00:3990:b0:81e:af19:34bc with SMTP id
 d2e1a72fcca58-826da9ee72amr16723808b3a.36.1772050736498; 
 Wed, 25 Feb 2026 12:18:56 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8273a054b49sm90586b3a.53.2026.02.25.12.18.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Feb 2026 12:18:56 -0800 (PST)
Message-ID: <61bceebb-6e21-4a9b-8191-40a07abc1f5e@linaro.org>
Date: Wed, 25 Feb 2026 12:18:55 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v4 02/31] hw/arm/smmuv3: Correct SMMUEN field name in CR0
Content-Language: en-US
To: Tao Tang <tangtao1634@phytium.com.cn>, Eric Auger
 <eric.auger@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mostafa Saleh <smostafa@google.com>, Chao Liu <chao.liu.zevorn@gmail.com>
References: <20260221100250.2976287-1-tangtao1634@phytium.com.cn>
 <20260221100250.2976287-3-tangtao1634@phytium.com.cn>
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
In-Reply-To: <20260221100250.2976287-3-tangtao1634@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x444.google.com
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

On 2/21/26 2:02 AM, Tao Tang wrote:
> The FIELD macro for the SMMU enable bit in the CR0 register was
> incorrectly named SMMU_ENABLE.
> 
> The ARM SMMUv3 Architecture Specification (both older IHI 0070.E.a and
> newer IHI 0070.G.b) consistently refers to the SMMU enable bit as SMMUEN.
> 
> This change makes our implementation consistent with the manual.
> 
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Link: https://lists.nongnu.org/archive/html/qemu-arm/2025-09/msg01270.html
> ---
>   hw/arm/smmuv3-internal.h       | 2 +-
>   include/hw/arm/smmuv3-common.h | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

