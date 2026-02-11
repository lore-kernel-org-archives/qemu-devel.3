Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00836ECD6D6
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 18:37:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqF4h-0004Ys-Dz; Wed, 11 Feb 2026 13:36:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vqF4g-0004Xy-04
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 13:36:30 -0500
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vqF4e-0000mD-5K
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 13:36:29 -0500
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-3562258142fso2603357a91.3
 for <qemu-devel@nongnu.org>; Wed, 11 Feb 2026 10:36:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770834986; x=1771439786; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UvefsLQsxDtAVpq365tz92xOFV6tC/OPx3cx+SLDHnw=;
 b=PsbEaT9RFYGTRzYoBNTp3dM1Ynuh5UngSCDUAw0KMBE5bNlf+3g6Dt69ixTR4SN1IR
 J7N6VjHeNLOIVIUKOWeO1NfFoBTSZKHJ0gr2E1kc+B1gFUoRCoy9Bw5vYjVr79bvxh7w
 hGWwszj+oXptLM/U9An5etqMsDkMS2XzumOJtfON5gqe1gXnsBaBLTVfGvt9iJKMkB+R
 hbC4vZ39lkGUTVbSqsUvLK3FBN1HxpGXSH4PkgltA7BYonrsvdAbzBF3KrkoWOJql9eu
 g6mC03HWYvIDndHQtpMV3TVX4647RrAiZtbFEjAAR7v1xRsVtvL7MnVrL0DSmF2kwV8x
 fKeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770834986; x=1771439786;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UvefsLQsxDtAVpq365tz92xOFV6tC/OPx3cx+SLDHnw=;
 b=RgWGGr9f8joA9aNsQf+0GvUB71AfpU1OorvkX2drECR5EU1K4wyG3W55ochpgKp7ax
 4kFWgst2Pcy49ShU7W6Pu8V0FEs+vDzZaYCpVSKHOjctS0HuBOkBSuZw4fKs03v2z5Ia
 pZKYyWCcu2zefClFlMKWql6ml0XgDUjaO6l9lWUDwSJOnBiMp+y0F9TFATr+pQxBATC9
 l19gbHptSObdyLh8cbe6kqbtyhMN+OWnM4SOT9YCgEMaeMfHgRoaRXh6LseMDUqXqxDL
 g0OpIJE7+qIM1RkiXN1ZlKW/qG4csRa4f+A3yQ8+7XhjC4qXPXF97x7UHlBF894Ec+wA
 p/Hg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWEGOtvLlkEe6Kv4UYJYxpkkWMiq4dgEUHIv0UlFm6zgdnAGHloHqkuLpBB6scsQQhTOZSimBh/1TBC@nongnu.org
X-Gm-Message-State: AOJu0YxxvrxBkm6rJyTqPhMhmVI0o7rJCOFHvaFxv/bbsS8bhqC614v9
 d/ElPuqw+2fpPV7DWV952je+LAIX/oFoX1Q4XHULC9cUm5hDNCqxUVy+okYofpmI4tE=
X-Gm-Gg: AZuq6aK6XeC3YtKkK3d4wW8iEVAHkfjWRy0A9v3YJZk/UOdSK/76ZFd/CletU2L0kMb
 Xq3FMyPviekqhgIYu5iKZUcwGBcsYsQE80QPCcbbozAR7wxt6xTgjomtO80AERsemSXYcn54dbm
 tMhk/Kpn4L3ybksczDQeFxljHpG/X6tdROTmVKCXPhrq2166eypRByCdI/u003+nSVpyxSp/6mC
 5tUsa50r7Ik8O5YKtcPg8GgryetqAxoaWaeB5qrWHyd4GhF5BB6ZtrtEvdw0O9vcXdn9DLB4p7E
 SxYuSjqXBWp7Awn6CtNAUtFYog0yhTpcqf7yzyLyMIRFGBQ+VC0Z+J+2hBUn1GuZDjRzxxt3K5L
 +V6+cQEVWUWloc2Ps2SVFPZd27ewJot4Dp02EQX4lsRHtyGf41yg01UVh2nPgp8oMANfEcif21u
 Fcj60dHC+gWDb2sjJAHMf+/HxylJxiimI1judBmGdO7AN7xwLRKOXZJuXzAPpiNMtaSBFZ
X-Received: by 2002:a17:90b:39cf:b0:341:88d5:a74e with SMTP id
 98e67ed59e1d1-3568f525b6bmr272285a91.29.1770834986443; 
 Wed, 11 Feb 2026 10:36:26 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3567eba96d0sm2871343a91.11.2026.02.11.10.36.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Feb 2026 10:36:26 -0800 (PST)
Message-ID: <d2ec5397-bfec-442c-9265-6619c6573fbb@linaro.org>
Date: Wed, 11 Feb 2026 10:36:25 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: simplify DiamondRapids CPU docs
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260211180021.1057478-1-berrange@redhat.com>
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
In-Reply-To: <20260211180021.1057478-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1030.google.com
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

On 2/11/26 10:00 AM, Daniel P. Berrangé wrote:
> This aligns the first line of the docs with the style used for previous
> CPU models, and simplifies the text in the remaining docs.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   docs/system/cpu-models-x86.rst.inc | 16 ++++++----------
>   1 file changed, 6 insertions(+), 10 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

I'll let any maintainer for this file pull it, but if needed, I can pull 
it as well.

Regards,
Pierrick

