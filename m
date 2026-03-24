Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77E62F532C9
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 03:20:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4sJB-0007BQ-M7; Mon, 23 Mar 2026 23:19:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w4sJ4-00079p-3E
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 23:19:51 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w4sJ2-0006sJ-A1
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 23:19:49 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-35a094cc3e9so3322869a91.3
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 20:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774322387; x=1774927187; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=x5YUaxV2hMWhnd65GT9SAc14OKLNLY196qtkPW8xwVI=;
 b=v8zytQcX+y3e31kZ4ErZyS3vexXqd2gPEJoW/IoDGfNHeR9H+Ja/nJoY6ps08EoyIQ
 J7OGbuCNooIeK+RnSlHVlRh6Jedtxthu9hYUAY2B7pBwoM5ntkt8XwmLVysSD4TscLQz
 2+7Y19AUhztNIrBe9I1iZD1qCHBVd3H0T+g6nmQcEkgDsv1Y9Mf3rejXf+xbh1G41d9L
 OTOOQJ+bGnPfKsuFsN14VCW7DQOzPrlLMZ4GWW5J6IMo2lHuvbiYT9nKQrTEKN77SjOr
 htSnDuC7hMOP3HVwTfDDlAI/Tf4goHXwYV9qBKi3mnQXxFVqj2j8W+F6o2acsHqSCNAH
 speg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774322387; x=1774927187;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=x5YUaxV2hMWhnd65GT9SAc14OKLNLY196qtkPW8xwVI=;
 b=nfhINzwQSz+jvdVxkRLqzGfIJmx/rKAjB6qccky/3qhBEzeXg22UdOGekfcpqG4M2c
 l3gYJlSID0BG/VW29hE6AaH+dIIvH236MIV3gruyC7WGHwHgTSxUcVRj589JLPirUx8F
 S6fHivdtZT95j0oR/p2bONTgQRgAU6wF7op5LVXbcpMGhLyvixWyIfVDI3mE/I3tjguU
 Xtv74NsrYwOSaP/1qlGbtnCyduLorpuHxhM05Gj9O78T/HYxEEYajeR04d+nHCHK6EbX
 v6p2ezamKCCHSp0HF7qOWzt50Nmb/Q36cPvj5W+yaZ8Jq3OPJq1KN9pJVUiUj/2yUAyN
 Y2Ag==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBHdEw6K9Tp7uvbjYiWjc0eLoWgJr7Ep6Vo39ZwI0t69jZJ3xEipv83PWOmwGU6m2M80V32WAOwgcu@nongnu.org
X-Gm-Message-State: AOJu0YyXAoPt3Vk9pOPriySZ3hYo5DuPsp8j7YxHcGqSyb6fYY1EFCSY
 5li3BeB68G/3J7dbEUh0ECk+UCouwfYk/RO6Wx898bM7uMNdHlVHEL6ku0GPajZLCcAeZ+7QhkF
 xmout+nY=
X-Gm-Gg: ATEYQzyBGmozvGQGNdH9TMV03aReuSxMHI4xCAxIUVlmoaotr9UcFgM+TMDF0/MW7/n
 BkO97ogp5qb54n7f0fZsikgKmV2AOXNiYU9DFAbpMln2BRavI+b1W6Q/IeQ087zvy+bzojnNfbN
 YNs0vwaH1L/3UlTkmL8R/BKsC+omFC9YXjVPFi3yNkWSSywWL9G24CG6x3IAzh3jy+Kv9mp+ZQL
 6wWLD1HuA8VMhCTckNg9i69j5ys+huPWs33K8JJmzawO13cMMPIlii+u2cgjtbrOQJI9i8aZn8d
 ohaP3v5BXt+RGvmnzukOGjtE+GT8l88NKRIoRuvV8krQSXFX4xLX3iEdpuYeZgr8ZSGbeF9Rsz7
 Kl2SG9FWqmfyaM7fGd68EzYCuLV934c44DCe0n3Jf442h9IN17v+N6KHnpeXLYexwfhqPW6M27X
 wmdCcmkFlHhnY8LiR7dO0F1RL87e8IWkThJXpYQAXUD7dPKUVGYDE2M1SrgDS3TOYi0QoR
X-Received: by 2002:a17:90b:3908:b0:359:8411:a40 with SMTP id
 98e67ed59e1d1-35bd29a00f1mr13744826a91.0.1774322386713; 
 Mon, 23 Mar 2026 20:19:46 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35c031ed064sm548065a91.9.2026.03.23.20.19.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Mar 2026 20:19:46 -0700 (PDT)
Message-ID: <8abf41ec-3f8f-4b3c-8966-f9309a404862@linaro.org>
Date: Mon, 23 Mar 2026 20:19:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.0] qapi: Remove deprecated
 SchemaInfoEnumMember::values field
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Michael Roth <michael.roth@amd.com>,
 devel@lists.libvirt.org, Markus Armbruster <armbru@redhat.com>
References: <20260323152124.93051-1-philmd@linaro.org>
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
In-Reply-To: <20260323152124.93051-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1036.google.com
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

On 3/23/26 8:21 AM, Philippe Mathieu-Daudé wrote:
> SchemaInfoEnumMember::values field has been deprecated for
> more than 5 years (see commit 75ecee72625 "qapi: Enable enum
> member introspection to show more than name"), it should be
> safe enough to remove.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   docs/about/deprecated.rst       |  6 ------
>   docs/about/removed-features.rst |  7 +++++++
>   qapi/introspect.json            | 12 +-----------
>   scripts/qapi/introspect.py      |  3 +--
>   4 files changed, 9 insertions(+), 19 deletions(-)
> 

By curiosity, is this patch goal is simply to remove a deprecated 
feature/code, or does it unlock something beyond it?
No judgment here, that's a genuine question, and both are valid reasons!

Looks good to me, to the limit of my qapi knowledge :).
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Regards,
Pierrick

