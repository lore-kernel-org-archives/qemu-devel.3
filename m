Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 289A010A88D4
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 16:48:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5nst-0001jZ-S3; Thu, 26 Mar 2026 12:48:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w5nsd-0001fR-KM
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 12:48:26 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w5nsZ-0000KT-OQ
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 12:48:21 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-c742bc88d87so537836a12.1
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2026 09:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774543698; x=1775148498; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NmyGoENwJLaW9tDAc6KN4Q2XMSAgocRn/MvaZn+i+8U=;
 b=dsCl8EKBqAxk6Tg3XHGq+UdYx1rL+MV+vKhQOy6UPLyhjbOoJUv3VJdZOzcRx4BU9X
 s1Vx/f5am0/6IDAGaYV2IzyNddsPYcHx4mYT8iWyEQKybmtv3RBIxvq1GjsYsXObHt3u
 i+MEorrZ7EN1fn6FPph5MV/97gbC09aOFkTTBtitOasBZEin0WPjbzrAPzws3K59/hxe
 oICyxrA7af92hEOrX5aP5jKF6o4VcltGfc2wrWAcmk4ndY+EG9KSPWFB8wVfqhwI7CRP
 Tc/k6x/qxHCpoGUeeCEyOKw5Y713HiJXPCsTHR7y4hVFqRAiOrgncMn5n2e3DW65jKxy
 5Kiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774543698; x=1775148498;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NmyGoENwJLaW9tDAc6KN4Q2XMSAgocRn/MvaZn+i+8U=;
 b=ESfa3WDW/U2A4MnBTPnVCwKq8DnE9508bRY4Wmast6V7Sf9+6AghjDUIKnNOV5+E5A
 CClFkayuN4J7mLmxxIsr6UiL/IM+GKqNep1g7F5d8Zy4ZYgJUMGFgPELQ1r48YbNIarj
 GoJ/hIFyKiTSG3neHvp3nZezOl+7wP3Ch0mm5v/TgrFqEt1c+qa9TBGCseyMsF01KO9O
 EB7SPKRnn+Jy2zaJElWHXd7dNIrQgpThXqINI/92r/lZ/fDnGy/IP+tZQc0SwdfVVlAN
 ZNHtBny+VX9bXOImK1Vc13VZq/1iAHndhqSDglVPk9Cc44Boxb9kZX0JB8EuIyDM64Jb
 WU5Q==
X-Gm-Message-State: AOJu0Yx+JEC/YY9QZFnVBc/eFvO/btSF+UE9Cgs3qGzFYHjvf1k0dQnK
 KoCm4ZUUAz6/DT/1xajm4Ytd6IkhJzld8Ng1duvHLtYtV8wiUNY+fi6MZIdFUBmdt38=
X-Gm-Gg: ATEYQzxbqh6Jg+7S6IOsU4vdZ4nnk6agYEhoh1IdA7QJ1g3FrB1Nv7HeVL7QGOQpGrR
 OOfIUSFoW2/QdAshvYIqgsyAcnngWOHbmXahHY9r55y/K1KMbp8lmjqc+T4W6p9eldJU/ASUl51
 lF69q1yYWgx7b28xPjY/0nB72OhIfSTJdbk9NJ7Z0zbqpN2eN1v/tZWw4bWBboeXt9vpsUS93A0
 RRJ0jB6xuVMxRMFlLt+fJdyuzyjeMfFe/fXDQbuylx5nGpX3a2pE9UB9SyxeuLaao9LYn50U21B
 aYvqWCuOnfL4jY0MucQagbgdCcFHmdvfCF5AUjDsXmmYPvMYP+s0m/4nu1PJo7JZyfBY7Q2+WuV
 pC8qbX5hjYX5cDW5zkZS9PupY8fy3X2GeLLvGZ15EGLnhbxnY5jnvWNx/vTXjXDUIp1wcAvSc2R
 2pJiBEQuzv0EV9xJfpbz8z0gvIsOkAEdAqw4gJ7XT77DWO3G5WRr8WMsr8rSVNEsU+Nq6mjZ9jt
 s7Rbfo=
X-Received: by 2002:a05:6a20:7f84:b0:39b:be6f:3d4d with SMTP id
 adf61e73a8af0-39c4ab5851fmr8528184637.23.1774543698022; 
 Thu, 26 Mar 2026 09:48:18 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c76737f1e75sm2641921a12.3.2026.03.26.09.48.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Mar 2026 09:48:17 -0700 (PDT)
Message-ID: <09297e78-b1bd-4281-919d-99de0a5a33ab@linaro.org>
Date: Thu, 26 Mar 2026 09:48:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] Misc changes to allow building with Windows Clang
Content-Language: en-US
To: Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Yan Vugenfirer <yvugenfi@redhat.com>
References: <20260326160033.68318-1-kkostiuk@redhat.com>
 <E4E91C9F-222E-41CA-B51A-928480FDC405@unpredictable.fr>
 <CAPMcbCoPfE+c1851esnnWRgxFcgm1CRr9CGtOmBNWphX5kt1tA@mail.gmail.com>
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
In-Reply-To: <CAPMcbCoPfE+c1851esnnWRgxFcgm1CRr9CGtOmBNWphX5kt1tA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52c.google.com
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

On 3/26/26 9:43 AM, Kostiantyn Kostiuk wrote:
> 
> 
> 
> On Thu, Mar 26, 2026 at 6:35 PM Mohamed Mediouni 
> <mohamed@unpredictable.fr <mailto:mohamed@unpredictable.fr>> wrote:
> 
> 
>      > On 26. Mar 2026, at 17:00, Kostiantyn Kostiuk
>     <kkostiuk@redhat.com <mailto:kkostiuk@redhat.com>> wrote:
>      >
>      > This is the first set of changes to allow building qemu-ga with
>     Microsoft Windows Clang.
>      > It includes some cleanups and fixes that also make the code more
>     portable.
>      > The main goal is to be able to build qemu-ga with the MSVC toolchain
>      > because MinGW-w64 is not available for ARM64 Windows.
>      >
>     Hello,
> 
>     MinGW-w64 is available for arm64 Windows, although it’s more 
> 
>     mature with Clang as a compiler instead of of MSVC.
> 
> 
> I expect to use clang from the MSVC environment, not the MSVC compiler
>

Is the difference that this clang does not come with mingw preinstalled, 
and thus require using msvc headers/libraries instead?

In all cases, it's just better to use msys2 environment. What is your 
limitation with it?

> 
>     Is it more of a packaging issue with distributions?
> 
>     Thank you,
>     -Mohamed
> 
> 


