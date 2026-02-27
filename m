Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 167471039895
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 21:46:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vw5fL-00043I-0N; Fri, 27 Feb 2026 16:46:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vw5fG-0003wO-2t
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 16:46:27 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vw5fD-0002HQ-Af
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 16:46:25 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2aad1bb5058so25192955ad.0
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 13:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772228782; x=1772833582; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=43qaeDvlPO4pxHAJTr/KYixKEB+1/QDnWx0q/ajv7Uk=;
 b=BSu3+ntIeIzLEPYt7ceW45jX/Tppxcw7IW3z525Sf4qg22mr5PRdhArFHw+B5GcAbb
 DZxrW2vKvzCU/lIrKGMs4NHJ0WsMJ9S8EGgi7o9dOKxdBltQTjZQlV+aVdcDG5nfCprE
 WVit6XfnOALxWw4WbNL0a0yV2FwavEguStnBz+9TnMKpd1RnvaTgc8mscC9GuniPY1Pg
 /kO+wQgMRW3TJ4fCBirM2pMD8KNei9IKvYPLazBn5sXrXSIE5aS+aU83Bd3F9mNtAx9u
 JDEyR2oVq95iTFVG9qog9kkCpAY6dNeBp1bFE3L9D9+rkJVXMKhY0soQgZ1DpQebzv23
 MP/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772228782; x=1772833582;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=43qaeDvlPO4pxHAJTr/KYixKEB+1/QDnWx0q/ajv7Uk=;
 b=YsW0xefGBIOf2sVRbJVK23fziPGzyyeia++A2eqlMo4BHQEGwHIWoq2RxH6RJXlrxN
 ZoG1mNL8H6vvxXVAD/aX/ZV1lgzhXY00aGxOItmlG90h8hEz6rOAQyPt5thQYDTmBmK5
 WMzXDB/z3widzgrf8LlaU3UTtVQCYce0fBHlL2aXjirqBefZjDOXxFEHlVkOjI0onV8d
 LE4yVccg3cLOYjrWtW+1Wb0Ob8TU+DIx9I8Dc7261y26arvblVsxq8a50bUM84i4Qzsa
 tCC+2C+JS+Id7hWybC7+sZgrYSTkUXjfLEqfyviHhcw721/GpqB0G4j3TEIsH1UP0OJq
 lVGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIDJaCcMYKEyayCXwNn6QxVLxzi1vjybDONWp8G0I6Yc5TkqZkC6YjQsXzGj4pejKGBJOTw7HxiuRs@nongnu.org
X-Gm-Message-State: AOJu0YzRmA5G0LDNtflJ6oUQ/6dP6Y+1G1SuNdCSyd0b0Y8ApBH8bUsf
 ZjPv2lm0nvIHInkN2zurJc1S9Wx6+QHI9MC14loxB8nINMkeJq6SYFpxw9xRRpspO30=
X-Gm-Gg: ATEYQzwsJKh0V4mjwJdCmu36S8L7eeMWDPqbDSCnHYsX1Cjj4gnPiOCy7POj+9cbzea
 RUGncNjXzs/J9SiOFp5JnslCTl5hxTXCplxmg3WHmtnoGA9f10CL+QKuV+yt7cQVIyF4Mh8IaBY
 /GdInn40wvobqOrF1aGHpF+ebsOwscVUmqaJDW809bnjAxpqJwGoWfkj5YkbrFdwZcLoUUBt5HU
 b7XG3/NvwqoceNN8o+2j4s87XaqDumRF8WhLprBgpIVL71YGx/IYtPq/cl2jowK39ZGqPq01+hU
 bl7n56593teCQTjhRvbt6KDqqfUMLtC+w7Zm6GJvj6hCRojnYOsbLRj98cDPCU1VopMTxW2vQk1
 wYg3Krxe52vhUYJPjrlHXCTieVmy/qfFHVMIf4RLuAQM+wkU7TCJ+BLBprJCOD77HeNdLsB5Rvd
 j+wgZBlXy6WbjAI69zUvuZ7M5Xi/luW5m+1w1L3pss71ks8PGhPN+7Tu9BUHwDoT+9zyzr
X-Received: by 2002:a17:903:41c6:b0:2ab:1dad:e500 with SMTP id
 d9443c01a7336-2ae2e408246mr48118905ad.18.1772228781818; 
 Fri, 27 Feb 2026 13:46:21 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2adfb5b2bedsm67124205ad.8.2026.02.27.13.46.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Feb 2026 13:46:20 -0800 (PST)
Message-ID: <56e7e193-511c-404d-9f20-f5ed209f2949@linaro.org>
Date: Fri, 27 Feb 2026 13:46:20 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] gdbstub: Have scripts/feature_to_c.py generate more
 verbose output
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Florian Hofhammer <florian.hofhammer@fhofhammer.de>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-ppc@nongnu.org
References: <20260227213958.21170-1-philmd@linaro.org>
 <20260227213958.21170-2-philmd@linaro.org>
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
In-Reply-To: <20260227213958.21170-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x632.google.com
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

On 2/27/26 1:39 PM, Philippe Mathieu-Daudé wrote:
> Make the structure field names explicit, so it is easier
> to figure what is what when reviewing multiple entries.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   scripts/feature_to_c.py | 13 ++++++++-----
>   1 file changed, 8 insertions(+), 5 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

