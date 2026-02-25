Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0CA2FD45F1
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 21:32:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvMTs-00007e-87; Wed, 25 Feb 2026 16:31:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vvMTq-00006T-89
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 16:31:38 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vvMTo-0002xz-6S
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 16:31:38 -0500
Received: by mail-pf1-x441.google.com with SMTP id
 d2e1a72fcca58-82310b74496so103714b3a.3
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 13:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772055094; x=1772659894; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vpK1BvruVfr9+YQapkt4lhgoL3LuxwZOgy0XjBiM+Y4=;
 b=nz7/dezqrugv/d68GFuwQtBQAGh5fjcDrl8W0upOznUyivGEW4EkpvzfToY9QF/ChU
 kLa3+d6St2QQUBn/G2KMk0xFmc/CGFmaQHkUf+UPObRJP+qMqm3AXbEfZqsvy74MzqBG
 wU9an35cQgavZhbCRrKJE9Mq71WsJu3zgCMNkZEa/ovN33qc6R+hL6/emynK4XrUHkYZ
 2lXbJBm6W+gGeUMuGtnsBOrv+lb0SwmyfaxSPXIArc2DZKbqzO/kRfeoxEH8CXgZVsrm
 jIMrUb/EukiqLyduCeySFF7P4NjySiKEXcWxpBDPg80Z/6uzyUT3fBhL3AzeSrR5dEyw
 psxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772055094; x=1772659894;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vpK1BvruVfr9+YQapkt4lhgoL3LuxwZOgy0XjBiM+Y4=;
 b=WikoxZ9ae6YdZA+vPoIJh4aHQQYkvDX842/uChk0lHMtOCSjrD+HGAnXQjligg57/w
 3bvnMbggG+LYVcoVQ1lmtRENz7IHQwQMyp2pfyLX/13TX0Lo6Ks4q+XfSVd9XUqeeXUw
 45YtTXweKmPRhoxyvB21hQHNGv5SE6HAPMmCzrc+YkZyl8vnFo0fpAQH3UnriyI9g8Bd
 giTfxAMFBqQFe8Jg3/UrQ7TSJSRwrreeXX4aQslSmwkc0dnqQ5KOPtlFv66VhMFq0jvt
 djnaKUCMqKkz7bQ9CeZOWtilMHmGpIyvZDkIVFA6DgTsSZWD+ZPlKdjcopo8EGNTXfJ6
 F/XA==
X-Gm-Message-State: AOJu0Yw0Mv8gz3vy0bgaWVx5L6rlM3S+hfK1ckSW9ipFQP9m9QvG1ls+
 Y/q0f2EebjRxTTpIpPrS08r4gAEiIl26FnOBQWwa/mc738M7bqwtt7Em+PNphIPHhiw=
X-Gm-Gg: ATEYQzzmGguDPKp6iKDGGuKtIYq2bcu9ai9ekImD3Jp9/Dlro+uBP3fSkHYf9Kpi9nV
 PN/SFakWcBCQWQj9ZqWSZni02MzRMR65lwrvVqnrVPb+IK9v/tJGrVLtJsHYnk9h9z/OYm9vnJy
 orE4OYTxuH2N2cDnawQia553btA7MYOFrgiNd6VUdZk0r2lyyJHia0ZQspHDLJfCkXpEBvd5xzd
 q+MZ9oq7ZzgvC4FC6b3j4t/L/GoON2YsvjeBRerKOaj+St3cHK4is0kKclK3zYY4OxbUvDv0OJu
 G0bYinRtEnjhMPUhuMnKdfyItD4bPCclrlNwR7LzGJQXey63eL6uzmEQMmsWMCGOaZdUcrp6DXO
 5uzQ9qYNw/efkHMFY9gcsT/U6uhh4rAOALqpB6lqD5GPHv/oDb7uJJZaDUJFG8A50IICLGq4lEQ
 fGhAqOBK4nX6o1Ts58H2QHFBtiyH8PHkqrXb877po/KI/0v0epNsRMNX79nm43DpD1vQuw
X-Received: by 2002:a05:6a00:b8c:b0:823:30a1:8958 with SMTP id
 d2e1a72fcca58-826da8c0e85mr16891969b3a.2.1772055094246; 
 Wed, 25 Feb 2026 13:31:34 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82739db4955sm198506b3a.29.2026.02.25.13.31.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Feb 2026 13:31:33 -0800 (PST)
Message-ID: <36f2aa40-1b01-4cb8-8546-06d9e770b30b@linaro.org>
Date: Wed, 25 Feb 2026 13:31:32 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v4 31/31] [NOT-MERGE] hw/arm/smmuv3: temporarily enable SEL2
 bit and sone other features
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
 <20260221101933.2998060-1-tangtao1634@phytium.com.cn>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260221101933.2998060-1-tangtao1634@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x441.google.com
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

On 2/21/26 2:19 AM, Tao Tang wrote:
> Temporarily:
> - enable S_IDR1.SEL2,
> - change AIDR to 0x2 to indicate SMMUv3.2,
> - use smaller SID size and Cmd/Evt queue size.
> 
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> ---
>   hw/arm/smmuv3.c                | 3 ++-
>   include/hw/arm/smmuv3-common.h | 6 +++---
>   2 files changed, 5 insertions(+), 4 deletions(-)
> 

I have been able to boot hafnium with:
- instructions at 
https://hnusdr.github.io/2025/08/09/Test-Secure-SMMU-with-Hafnium-ENG/
- the current patch
- qemu-system-aarch64 -global arm-smmuv3.secure-impl=on ...

In case someone else wants to reproduce this easily:

```
git clone https://github.com/p-b-o/qemu-linux-stack
cd qemu-linux-stack
git checkout optee-secure-smmu
./build.sh # only requires podman and qemu-user-static
./run.sh /path/to/qemu-system-aarch64
```

Tested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

