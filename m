Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12851F3C99B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 15:42:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuuXv-0007HZ-RZ; Tue, 24 Feb 2026 10:42:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vuuXo-0007HK-TB
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 10:41:52 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vuuXm-0005rp-NO
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 10:41:52 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2aae4816912so39324405ad.2
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 07:41:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771947709; x=1772552509; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=d9Rx1W6YY6GhvaJyG1os/k49cX/SvOZKQBM+zjsBlz8=;
 b=M6p3UW3ZMQtsh0zPBM8LaG9QV1eQf/Mjn2CZeSFGf3uOBRHVnDzmRb4hX5NDof+XLi
 Qz1261pel5FcmvtcOR5z5Ofv1f8S6ovO2ASpwtAWz23uSxPa9m3RIR3DeLrBzn8yoGFU
 pVFIzYqxfSEcCLKsgW6sNldDCk2VRHmGfghQwaWT54uTHydIBrLqW4SPsyqQmVp0YxFm
 EeiD+mFkua98gLpwxju9dMLcA+U3QNd7A4hdfyCNCm2J+NbfYQCTLbVdVHM9ON9vCPT8
 +JL9PECU55LBsVHuAc+1gT+hzea9M0OboB/qw/djS3wMk4N1mtRphm628TjI4ye0WvoW
 H/1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771947709; x=1772552509;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=d9Rx1W6YY6GhvaJyG1os/k49cX/SvOZKQBM+zjsBlz8=;
 b=HiK/Lmao7CRaB3xCeMMU0osglBbZHjbMTP7EmOPOWEs7yF9gS17dVtxuiTLtvoHsXs
 QuIF8VATbYRJD3bdf2l4dMk7R5AifNlMGQElflbMYp6pK4khu26A/xKSbC9+XlZQ5NeT
 J1W0NZn0V2rYwwGqK+XRMFoeJjaZiuGXZ2UxzsnORzotRa9eORcMCp91/2vJrrhKdudk
 W8Mod3DwYnX5l/kpDnsKqrNCMjJmqcPIUHgwp70foE/dYZAF2iP7bamEjB+QMzLFnjxg
 QOYjr9nA7kmAKl3+xsux/KfA9erkUuI5Spdmd8JEl/g6k2KlXO0IsOSq1iHFrWYgpBHw
 Z9cQ==
X-Gm-Message-State: AOJu0Yy6cw5hlh11dPx7H9Q6LNkgUv4iwJ58EzNlltotxtK5hRQcMwwq
 0H8cnyEEFcfUMlkZ+mOkT1EfKX70CmQ6Gi7CjYlpqgq8EnpMfcGmi7azGy7NHUOlA3mZVTyqsGP
 /7te5
X-Gm-Gg: ATEYQzyVdlLNGNauFQb+SRXIxSXKSxLcSot52WUM7jSzHY/oQc6RvwiFo9sWWT7eHcK
 TMrcxTXzQSmldQQBD3fAdV+5ySw2YV6U9K91LMSx9/FQQ/hsESQo7PqLjhNUdmvI8bxZuNNoQk5
 i2MvAExG8YZVZxPgKc/ElwqYmAA87jAFXQvRfqPyXq1rU+3Zs6EhXyqCnGoAbamFThWqer5i8Ri
 DlDOqd9aEGVvwo25GkSrPZCulL+pHcAlboZiz1OWojaauL2pSJUVNILsi0eR9Jnja0c5VqQdBLz
 6nJ7ZqKPMyqLYnBp9+OTNvWb+GckXtQ51XpoH39u/t1b7mio03RlynLmgIuAbkXmEIh20r5kN6M
 2Ip2JNI0GYOL7vujqT/H8oX5LaThUAZMxprU3+iXw4KXaUTgf/Huaxh0iu+38pMLddp7Vig/lCm
 LxmPOcv5YokL4eEFXtyKFvgpbAZoFS44sL4BknZVtAC2N0feyKzc9Sz6D4xuDTchc30jAJ
X-Received: by 2002:a17:902:e5cb:b0:2a9:4aac:335b with SMTP id
 d9443c01a7336-2ad74504e41mr132277835ad.35.1771947708706; 
 Tue, 24 Feb 2026 07:41:48 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ad74e350a9sm109573555ad.15.2026.02.24.07.41.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Feb 2026 07:41:48 -0800 (PST)
Message-ID: <2e0b4df7-144d-41d3-bd07-0cbfcfffd0e8@linaro.org>
Date: Tue, 24 Feb 2026 07:41:48 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] contrib/plugins/uftrace_symbols.py: filter out some
 addr2line error messages
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, philmd@linaro.org,
 Alexandre Iooss <erdnaxe@crans.org>
References: <20260218172356.938236-1-pierrick.bouvier@linaro.org>
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
In-Reply-To: <20260218172356.938236-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x635.google.com
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

On 2/18/26 9:23 AM, Pierrick Bouvier wrote:
> This was found when tracing Hafnium and SLOF binaries, and it's probably
> related to a bug in toolchain used. It's safe to ignore those entries,
> and related symbols will still be present in output, whether they can be
> found or not.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   contrib/plugins/uftrace_symbols.py | 3 +++
>   1 file changed, 3 insertions(+)
> 

This was merged into master (ba061eb352831adde73b6ff520169bf307be6bbd).

Regards,
Pierrick

